Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9032FF886E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2118.1777312614186923949
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAi876837;
	Mon, 27 Apr 2026 12:56:44 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 05/11] ports/unix: fts_*: Certain functions were incorrectly returning stat data
Date: Mon, 27 Apr 2026 12:56:35 -0500
Message-Id: <1777312601-1393-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3853

From: Mark Hatle <mark.hatle@amd.com>

Glibc appears to be using fts private symbols for stat/fstatat/etc. This
caused incorrect ownership and permissions data to be returned from
fts_read().  It appears that glibc's fts_read calls directly into
__fstatat64 instead of using the standard fstatat64 function.

This means fts_read() populates FTSENT->fts_statp with real stat data
(actual on-disk uid/gid), not pseudo's fake data.

fts_read and fts_children wrappers

The fix: wrap fts_read() and fts_children() so that after the real
libc function returns, we re-query pseudo's database for each entry.
This is the same pattern used by nftw where each callback re-stats
each file through pseudo to void internal functions returning actual
data.

AI-Generate: Fix suggested by github copilot (claude opus 6.4)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/fts_children.c | 64 +++++++++++++++++++++++++++++++++++++++
 ports/unix/guts/fts_read.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
 ports/unix/wrapfuncs.in        |  2 ++
 3 files changed, 134 insertions(+)
 create mode 100644 ports/unix/guts/fts_children.c
 create mode 100644 ports/unix/guts/fts_read.c

diff --git a/ports/unix/guts/fts_children.c b/ports/unix/guts/fts_children.c
new file mode 100644
index 0000000..f5d1890
--- /dev/null
+++ b/ports/unix/guts/fts_children.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2026 Yocto Project; see
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static FTSENT *
+ * wrap_fts_children(FTS *ftsp, int options) {
+ *	FTSENT * rc = NULL;
+ */
+
+	rc = real_fts_children(ftsp, options);
+
+	/* glibc's fts_children calls fstatat internally using glibc-private
+	 * symbols, which bypass pseudo's LD_PRELOAD wrappers. We need to
+	 * re-stat each entry through pseudo so that pseudo-tracked
+	 * ownership and permissions are visible to callers.
+	 */
+	FTSENT *p;
+	for (p = rc; p != NULL; p = p->fts_link) {
+		if (p->fts_statp && p->fts_path) {
+			pseudo_msg_t *msg;
+			int save_errno = errno;
+			const char *fts_rpath;
+			PSEUDO_STATBUF buf64;
+
+			switch (p->fts_info) {
+			case FTS_F:
+			case FTS_D:
+			case FTS_SL:
+			case FTS_SLNONE:
+			case FTS_DEFAULT:
+				/* See fts_read.c: fts_path may already contain
+				 * the chroot prefix from fts_open's path resolution.
+				 * Use it directly in that case.
+				 */
+				if (p->fts_path[0] == '/' && pseudo_chroot_len &&
+				    !memcmp(p->fts_path, pseudo_chroot, pseudo_chroot_len) &&
+				    (p->fts_path[pseudo_chroot_len] == '/' ||
+				     p->fts_path[pseudo_chroot_len] == '\0')) {
+					fts_rpath = p->fts_path;
+				} else {
+					fts_rpath = PSEUDO_ROOT_PATH(AT_FDCWD, p->fts_path, AT_SYMLINK_NOFOLLOW);
+				}
+				if (fts_rpath) {
+					pseudo_stat64_from32(&buf64, p->fts_statp);
+					msg = pseudo_client_op(OP_STAT, 0, -1, -1, fts_rpath, &buf64);
+					if (msg && msg->result == RESULT_SUCCEED) {
+						pseudo_stat_msg(&buf64, msg);
+						pseudo_stat32_from64(p->fts_statp, &buf64);
+					}
+				}
+				break;
+			default:
+				break;
+			}
+
+			errno = save_errno;
+		}
+	}
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/unix/guts/fts_read.c b/ports/unix/guts/fts_read.c
new file mode 100644
index 0000000..654b982
--- /dev/null
+++ b/ports/unix/guts/fts_read.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2026 Yocto Project; see
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static FTSENT *
+ * wrap_fts_read(FTS *ftsp) {
+ *	FTSENT * rc = NULL;
+ */
+
+	rc = real_fts_read(ftsp);
+
+	/* glibc's fts_read calls fstatat internally using glibc-private
+	 * symbols, which bypass pseudo's LD_PRELOAD wrappers. We need to
+	 * re-stat the entry through pseudo so that pseudo-tracked
+	 * ownership and permissions are visible to callers.
+	 */
+	if (rc && rc->fts_statp && rc->fts_accpath) {
+		pseudo_msg_t *msg;
+		int save_errno = errno;
+		const char *fts_rpath;
+		PSEUDO_STATBUF buf64;
+
+		switch (rc->fts_info) {
+		case FTS_F:
+		case FTS_D:
+		case FTS_DP:
+		case FTS_SL:
+		case FTS_SLNONE:
+		case FTS_DEFAULT:
+			/* fts_open passes real (chroot-resolved) paths to real_fts_open,
+			 * so fts_path is already a real filesystem path. We must use
+			 * it directly without PSEUDO_ROOT_PATH, which would
+			 * incorrectly prepend the chroot prefix a second time.
+			 *
+			 * However, for the non-chroot case (or when fts was given
+			 * relative paths that are still relative in fts_path),
+			 * we still need PSEUDO_ROOT_PATH to make them absolute.
+			 */
+			if (rc->fts_path[0] == '/' && pseudo_chroot_len &&
+			    !memcmp(rc->fts_path, pseudo_chroot, pseudo_chroot_len) &&
+			    (rc->fts_path[pseudo_chroot_len] == '/' ||
+			     rc->fts_path[pseudo_chroot_len] == '\0')) {
+				/* Already a real path with chroot prefix */
+				fts_rpath = rc->fts_path;
+			} else {
+				fts_rpath = PSEUDO_ROOT_PATH(AT_FDCWD, rc->fts_path, AT_SYMLINK_NOFOLLOW);
+			}
+			if (fts_rpath) {
+				pseudo_stat64_from32(&buf64, rc->fts_statp);
+				msg = pseudo_client_op(OP_STAT, 0, -1, -1, fts_rpath, &buf64);
+				if (msg && msg->result == RESULT_SUCCEED) {
+					pseudo_stat_msg(&buf64, msg);
+					pseudo_stat32_from64(rc->fts_statp, &buf64);
+				}
+			}
+			break;
+		default:
+			break;
+		}
+
+		errno = save_errno;
+	}
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/unix/wrapfuncs.in b/ports/unix/wrapfuncs.in
index 7724fc7..5665735 100644
--- a/ports/unix/wrapfuncs.in
+++ b/ports/unix/wrapfuncs.in
@@ -13,6 +13,8 @@ int access(const char *path, int mode);
 int faccessat(int dirfd, const char *path, int mode, int flags);
 int faccessat2(int dirfd, const char *path, int mode, int flags);
 FTS *fts_open(char * const *path_argv, int options, int (*compar)(const FTSENT **, const FTSENT **)); /* inode64=1 */
+FTSENT *fts_read(FTS *ftsp); /* noignore_path=1, inode64=1 */
+FTSENT *fts_children(FTS *ftsp, int options); /* noignore_path=1, inode64=1 */
 int ftw(const char *path, int (*fn)(const char *, const struct stat *, int), int nopenfd);
 int nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag);
 int glob(const char *pattern, int flags, int (*errfunc)(const char *, int), glob_t *pglob);
-- 
1.8.3.1


