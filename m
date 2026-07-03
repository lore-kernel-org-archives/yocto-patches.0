Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F3CC44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82806.1783039584732453762
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ19069650;
	Thu, 2 Jul 2026 19:46:22 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 10/23] wrappers: Change pseudo_diag() calls to appropriate macros
Date: Thu,  2 Jul 2026 19:46:05 -0500
Message-Id: <1783039578-31531-11-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4370

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/darwin/pseudo_wrappers.c      | 3 +--
 ports/linux/guts/fcntl.c            | 2 +-
 ports/linux/guts/fcntl64.c          | 2 +-
 ports/linux/guts/getpw.c            | 2 +-
 ports/linux/guts/openat.c           | 3 +--
 ports/linux/openat2/guts/openat2.c  | 3 +--
 ports/linux/xattr/pseudo_wrappers.c | 3 +--
 ports/unix/guts/getcwd.c            | 6 +++---
 ports/unix/guts/linkat.c            | 2 +-
 ports/unix/guts/nftw_wrapper_base.c | 6 +++---
 ports/unix/guts/symlinkat.c         | 2 +-
 ports/unix/guts/tempnam.c           | 2 +-
 ports/unix/guts/tmpnam.c            | 2 +-
 ports/unix/guts/unlinkat.c          | 2 +-
 pseudo_ipc.c                        | 2 +-
 pseudo_wrappers.c                   | 2 +-
 16 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/ports/darwin/pseudo_wrappers.c b/ports/darwin/pseudo_wrappers.c
index 3f05936..a7a1341 100644
--- a/ports/darwin/pseudo_wrappers.c
+++ b/ports/darwin/pseudo_wrappers.c
@@ -73,9 +73,8 @@ static int
 posix_permissions(const acl_header *header, int entries, int *extra, int *mode) {
 	int acl_seen = 0;
 	if (le32(header->version) != 2) {
-		pseudo_diag("Fatal: ACL support no available for header version %d.\n",
+		pseudo_critical("ACL support no available for header version %d.\n",
 			le32(header->version));
-		return 1;
 	}
 	*mode = 0;
 	*extra = 0;
diff --git a/ports/linux/guts/fcntl.c b/ports/linux/guts/fcntl.c
index ffb50be..d6babb5 100644
--- a/ports/linux/guts/fcntl.c
+++ b/ports/linux/guts/fcntl.c
@@ -89,7 +89,7 @@
 		break;
 #endif
 	default:
-		pseudo_diag("unknown fcntl argument %d, assuming long argument.\n",
+		pseudo_error("unknown fcntl argument %d, assuming long argument.\n",
 			cmd);
 		rc = real_fcntl(fd, cmd, arg);
 		break;
diff --git a/ports/linux/guts/fcntl64.c b/ports/linux/guts/fcntl64.c
index 99de43d..169fc6d 100644
--- a/ports/linux/guts/fcntl64.c
+++ b/ports/linux/guts/fcntl64.c
@@ -89,7 +89,7 @@
 		break;
 #endif
 	default:
-		pseudo_diag("unknown fcntl64 argument %d, assuming long argument.\n",
+		pseudo_error("unknown fcntl64 argument %d, assuming long argument.\n",
 			cmd);
 		rc = real_fcntl64(fd, cmd, arg);
 		break;
diff --git a/ports/linux/guts/getpw.c b/ports/linux/guts/getpw.c
index 5aa0bca..111799e 100644
--- a/ports/linux/guts/getpw.c
+++ b/ports/linux/guts/getpw.c
@@ -12,7 +12,7 @@
 	static char pwbuf[PSEUDO_PWD_MAX];
 	struct passwd *pwp;
 
-	pseudo_diag("warning: unsafe getpw() called.  hoping buf has at least %d chars.\n",
+	pseudo_warning("unsafe getpw() called.  hoping buf has at least %d chars.\n",
 		PSEUDO_PWD_MAX);
 	rc = wrap_getpwuid_r(uid, &pwd, pwbuf, PSEUDO_PWD_MAX, &pwp);
 	/* different error return conventions */
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index 656ac2b..0a44063 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -112,9 +112,8 @@
 		 * stack to stuff that's going to try to drop the lock.
 		 */
 		if (pseudo_getlock()) {
-			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
+			pseudo_critical("after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
 				path, rc, errno, save_errno);
-			abort();
 		}
 		errno = save_errno;
 	}
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index a0acbe7..f1c523e 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -147,9 +147,8 @@
 		 * stack to stuff that's going to try to drop the lock.
 		 */
 		if (pseudo_getlock()) {
-			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
+			pseudo_critical("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
 				pseudo_path, rc, errno, save_errno);
-			abort();
 		}
 		errno = save_errno;
 	}
diff --git a/ports/linux/xattr/pseudo_wrappers.c b/ports/linux/xattr/pseudo_wrappers.c
index 0b65920..896c84d 100644
--- a/ports/linux/xattr/pseudo_wrappers.c
+++ b/ports/linux/xattr/pseudo_wrappers.c
@@ -66,9 +66,8 @@ static int
 posix_permissions(const acl_header *header, int entries, int *extra, int *mode) {
 	int acl_seen = 0;
 	if (le32(header->version) != 2) {
-		pseudo_diag("Fatal: ACL support not available for header version %d.\n",
+		pseudo_critical("Fatal: ACL support not available for header version %d.\n",
 			le32(header->version));
-		return -1;
 	}
 	*mode = 0;
 	*extra = 0;
diff --git a/ports/unix/guts/getcwd.c b/ports/unix/guts/getcwd.c
index a5bf2ef..f9d6bfc 100644
--- a/ports/unix/guts/getcwd.c
+++ b/ports/unix/guts/getcwd.c
@@ -11,7 +11,7 @@
 	pseudo_debug(PDBGF_CLIENT, "wrap_getcwd: %p, %lu\n",
 		(void *) buf, (unsigned long) size);
 	if (!pseudo_cwd) {
-		pseudo_diag("Asked for CWD, but don't have it!\n");
+		pseudo_error("Asked for CWD, but don't have it!\n");
 		errno = EACCES;
 		return NULL;
 	}
@@ -33,13 +33,13 @@
 		if (size) {
 			buf = malloc(size);
 		} else {
-			pseudo_diag("can't figure out CWD: length %ld + 1 - %ld => %ld\n",
+			pseudo_error("can't figure out CWD: length %ld + 1 - %ld => %ld\n",
 				(unsigned long) pseudo_cwd_len,
 				(unsigned long) pseudo_chroot_len,
 				(unsigned long) size);
 		}
 		if (!buf) {
-			pseudo_diag("couldn't allocate requested CWD buffer - need %ld byes\n",
+			pseudo_error("couldn't allocate requested CWD buffer - need %ld byes\n",
 				(unsigned long) size);
 			errno = ENOMEM;
 			return NULL;
diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index 60fbf63..ff707c8 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -82,7 +82,7 @@
 		rc2 = base_lstat(oldpath, &buf);
 	}
 	if (rc2 == -1) {
-		pseudo_diag("Fatal: Tried to stat '%s' after linking it, but failed: %s.\n",
+		pseudo_error("Fatal: Tried to stat '%s' after linking it, but failed: %s.\n",
 			oldpath, strerror(errno));
 		errno = ENOENT;
 		return rc2;
diff --git a/ports/unix/guts/nftw_wrapper_base.c b/ports/unix/guts/nftw_wrapper_base.c
index 000fa18..b9f761a 100644
--- a/ports/unix/guts/nftw_wrapper_base.c
+++ b/ports/unix/guts/nftw_wrapper_base.c
@@ -68,7 +68,7 @@ static void NFTW_DELETE_FN_NAME() {
             NFTW_STORAGE_ARRAY_NAME = NULL;
             --NFTW_STORAGE_ARRAY_SIZE;
         } else {
-            pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+            pseudo_error("%s: Invalid callback storage content, can't find corresponding data", __func__);
         }
         return;
     }
@@ -82,7 +82,7 @@ static void NFTW_DELETE_FN_NAME() {
     }
 
     if (found_idx == -1) {
-        pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+        pseudo_error("%s: Invalid callback storage content, can't find corresponding data", __func__);
         return;
     }
 
@@ -102,7 +102,7 @@ static int NFTW_CALLBACK_NAME(const char* fpath, const struct NFTW_STAT_STRUCT _
     struct NFTW_STAT_STRUCT pseudo_sb;
 
     if (!NFTW_FIND_FN_NAME(&saved_details)) {
-        pseudo_diag("%s: Could not find corresponding callback!", __func__);
+        pseudo_error("%s: Could not find corresponding callback!", __func__);
         return -1;
     }
 
diff --git a/ports/unix/guts/symlinkat.c b/ports/unix/guts/symlinkat.c
index c96ff3e..5673912 100644
--- a/ports/unix/guts/symlinkat.c
+++ b/ports/unix/guts/symlinkat.c
@@ -38,7 +38,7 @@
 #endif
 	if (rc == -1) {
 		int save_errno = errno;
-		pseudo_diag("symlinkat: couldn't stat '%s' even though symlink creation succeeded (%s).\n",
+		pseudo_warning("symlinkat: couldn't stat '%s' even though symlink creation succeeded (%s).\n",
 			newpath, strerror(errno));
 		errno = save_errno;
 		free(roldname);
diff --git a/ports/unix/guts/tempnam.c b/ports/unix/guts/tempnam.c
index 26ae3e1..e2d2c75 100644
--- a/ports/unix/guts/tempnam.c
+++ b/ports/unix/guts/tempnam.c
@@ -11,7 +11,7 @@
 	/* let gcc know we ignored these on purpose */
 	(void) template;
 	(void) pfx;
-	pseudo_diag("tempnam() is so ludicrously insecure as to defy implementation.");
+	pseudo_warning("tempnam() is so ludicrously insecure as to defy implementation.");
 	errno = ENOMEM;
 	rc = NULL;
 
diff --git a/ports/unix/guts/tmpnam.c b/ports/unix/guts/tmpnam.c
index 190d260..60b66e0 100644
--- a/ports/unix/guts/tmpnam.c
+++ b/ports/unix/guts/tmpnam.c
@@ -11,7 +11,7 @@
 
 	/* let gcc know we're ignoring this */
 	(void) s;
-	pseudo_diag("tmpnam() is so ludicrously insecure as to defy implementation.");
+	pseudo_warning("tmpnam() is so ludicrously insecure as to defy implementation.");
 	errno = ENOMEM;
 	rc = NULL;
 
diff --git a/ports/unix/guts/unlinkat.c b/ports/unix/guts/unlinkat.c
index 7e4f87c..9889b2e 100644
--- a/ports/unix/guts/unlinkat.c
+++ b/ports/unix/guts/unlinkat.c
@@ -23,7 +23,7 @@
 		 * with that flag unless the real AT functions exist, so 
 		 * something must have gone horribly wrong....
 		 */
-		pseudo_diag("wrap_unlinkat called with flags (0x%x), path '%s'\n",
+		pseudo_info("wrap_unlinkat called with flags (0x%x), path '%s'\n",
 			rflags, path ? path : "<nil>");
 		errno = ENOSYS;
 		return -1;
diff --git a/pseudo_ipc.c b/pseudo_ipc.c
index 838eba2..e51fe0e 100644
--- a/pseudo_ipc.c
+++ b/pseudo_ipc.c
@@ -165,7 +165,7 @@ pseudo_msg_receive(int fd) {
 	if (!incoming || header.pathlen >= incoming_pathlen) {
 		newmsg = pseudo_msg_new(header.pathlen + 128, 0);
 		if (!newmsg) {
-			pseudo_diag("Couldn't allocate header for path of %d bytes.\n",
+			pseudo_error("Couldn't allocate header for path of %d bytes.\n",
 				(int) header.pathlen);
 			return 0;
 		}
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 9ae1200..662c276 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -249,7 +249,7 @@ pseudo_magic() {
 
 static void
 pseudo_enosys(const char *func) {
-	pseudo_diag("pseudo: ENOSYS for '%s'.\n", func ? func : "<nil>");
+	pseudo_info("pseudo: ENOSYS for '%s'.\n", func ? func : "<nil>");
 	char * value = pseudo_get_value("PSEUDO_ENOSYS_ABORT");
 	if (value)
 		abort();
-- 
2.53.0


