Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142BF5A8AD
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 18:30:40 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.205.1776709832953681953
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 11:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63KIUUPu3563308;
	Mon, 20 Apr 2026 13:30:30 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: [PATCH 1/5] openat2: Implement openat2 wrapper
Date: Mon, 20 Apr 2026 13:30:25 -0500
Message-Id: <1776709829-2754-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 18:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3741

From: Mark Hatle <mark.hatle@amd.com>

This wrapper is based on ports/linux/guts/openat.c wrapper.

The flag and mode semantics have been replaced with 'open_how'.
The new resolve items should work, but are not processed by pseudo.
The input value is simply passed to the openat2 syscall.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/openat2/guts/openat2.c | 184 +++++++++++++++++++++++++++++++++++--
 ports/linux/pseudo_wrappers.c      |   3 +
 test/test-syscall.c                |   9 +-
 3 files changed, 182 insertions(+), 14 deletions(-)

diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index 366fb95..946a4e4 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -1,22 +1,186 @@
 /*
- * Copyright (c) 2026 Mark Hatle <mark.hatle@amd.com>; see
- * guts/COPYRIGHT for information.
+ * Copyright (c) 2008-2010, 2013 Wind River Systems
+ * Copyright (c) 2026 Yocto Project
+ * see guts/COPYRIGHT for information.
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
  * int openat2(int dirfd, const char *path, const struct open_how *how, size_t size)
  *	int rc = -1;
  */
+	struct stat64 buf;
+	int overly_magic_nonblocking = 0;
+	int existed = 1;
+	int save_errno;
+	sigset_t local_saved_sigmask;
+	struct open_how my_how;
 
-	(void) dirfd;
-	(void) path;
-	(void) how;
-	(void) size;
-	/* for now, let's try just failing out hard, and hope things retry with a
-	 * different syscall.
+	/* Validate parameters */
+	if (!how || size < sizeof(struct open_how)) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (size > sizeof(struct open_how)) {
+		errno = E2BIG;
+		return -1;
+	}
+
+	memcpy(&my_how, how, size);
+
+	/* mask out mode bits appropriately */
+	my_how.mode = my_how.mode & ~pseudo_umask;
+
+#if defined(PSEUDO_NO_REAL_AT_FUNCTIONS) || ! defined(SYS_openat2)
+	if (dirfd != AT_FDCWD) {
+		errno = ENOSYS;
+		return -1;
+	}
+#endif
+
+#ifdef PSEUDO_FORCE_ASYNC
+	/* Yes, I'm aware that every Linux system I've seen has
+	 * DSYNC and RSYNC being the same value as SYNC.
+	 */
+
+	my_how.flags &= ~(O_SYNC
+#ifdef O_DIRECT
+		| O_DIRECT
+#endif
+#ifdef O_DSYNC
+		| O_DSYNC
+#endif
+#ifdef O_RSYNC
+		| O_RSYNC
+#endif
+	);
+#endif
+
+#ifdef O_TMPFILE
+	/* don't handle O_CREAT the same way if O_TMPFILE exists
+	 * and is set.
 	 */
-	errno = ENOSYS;
-	rc = -1;
+	if ((my_how.flags & O_TMPFILE) == O_TMPFILE) {
+		existed = 0;
+	} else
+#endif
+	/* if a creation has been requested, check whether file exists */
+	/* note "else" in #ifdef O_TMPFILE above */
+	if (my_how.flags & O_CREAT) {
+		save_errno = errno;
+#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
+		if (my_how.flags & O_NOFOLLOW) {
+			rc = real___lxstat64(_STAT_VER, path, &buf);
+		} else {
+			rc = real___xstat64(_STAT_VER, path, &buf);
+		}
+#else
+		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+#endif
+		existed = (rc != -1);
+		if (!existed)
+			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", path, my_how.mode);
+		errno = save_errno;
+	}
+
+	/* if a pipe is opened without O_NONBLOCK, for only reading or
+	 * only writing, it can block forever. We need to do extra magic
+	 * in that case...
+	 */
+	if (!(my_how.flags & O_NONBLOCK) && ((my_how.flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_RDWR)) {
+		save_errno = errno;
+#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
+		if (my_how.flags & O_NOFOLLOW) {
+			rc = real___lxstat64(_STAT_VER, path, &buf);
+		} else {
+			rc = real___xstat64(_STAT_VER, path, &buf);
+		}
+#else
+		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+#endif
+		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
+			overly_magic_nonblocking = 1;
+		}
+	}
+
+	/* this is a horrible special case and i do not know whether it will work */
+	if (overly_magic_nonblocking) {
+		pseudo_droplock();
+		sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, &local_saved_sigmask);
+	}
+	/* because we are not actually root, secretly mask in 0600 to the
+	 * underlying mode.  The ", 0" is because the only time mode matters
+	 * is if a file is going to be created, in which case it's
+	 * not a directory.
+	 */
+#if defined(PSEUDO_NO_REAL_AT_FUNCTIONS) || ! defined(SYS_openat2)
+	pseudo_debug(PDBGF_SYSCALL, "openat2, calling open.\n");
+	rc = real_open(path, my_how.flags, PSEUDO_FS_MODE(my_how.mode, 0));
+#else
+	/* openat2 in glibc is still rare, so directly call the syscall if required */
+	if (real_openat2) {
+		pseudo_debug(PDBGF_SYSCALL, "openat2, calling openat2.\n");
+		rc = real_openat2(dirfd, path, how, size);
+	} else {
+		pseudo_debug(PDBGF_SYSCALL, "openat2, calling syscall.\n");
+		rc = real_syscall(SYS_openat2, dirfd, path, how, size);
+	}
+#endif
+	if (overly_magic_nonblocking) {
+		save_errno = errno;
+		sigprocmask(SIG_SETMASK, &local_saved_sigmask, NULL);
+		/* well this is a problem. we can't NOT proceed; we may have
+		 * already opened the file! we can't even return up the call
+		 * stack to stuff that's going to try to drop the lock.
+		 */
+		if (pseudo_getlock()) {
+			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
+				path, rc, errno, save_errno);
+			abort();
+		}
+		errno = save_errno;
+	}
+
+	if (rc != -1) {
+		save_errno = errno;
+		int stat_rc;
+#ifdef O_TMPFILE
+		/* in O_TMPFILE case, nothing gets put in the
+		 * database, because there's no directory entries for
+		 * the file yet.
+		 */
+		if ((my_how.flags & O_TMPFILE) == O_TMPFILE) {
+			real_fchmod(rc, PSEUDO_FS_MODE(my_how.mode, 0));
+			errno = save_errno;
+			return rc;
+		}
+#endif
+#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
+		if (my_how.flags & O_NOFOLLOW) {
+			stat_rc = real___lxstat64(_STAT_VER, path, &buf);
+		} else {
+			stat_rc = real___xstat64(_STAT_VER, path, &buf);
+		}
+#else
+		stat_rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+#endif
+
+		pseudo_debug(PDBGF_FILE, "openat2(path %s), flags %lld, stat rc %d, stat mode %o\n",
+			path, my_how.flags, stat_rc, buf.st_mode);
+		if (stat_rc != -1) {
+			buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, my_how.mode);
+			if (!existed) {
+				real_fchmod(rc, PSEUDO_FS_MODE(my_how.mode, 0));
+				// file has no path, but has been created
+				pseudo_client_op(OP_CREAT, 0, -1, dirfd, path, &buf);
+			}
+				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, path, &buf);
+		} else {
+			pseudo_debug(PDBGF_FILE, "openat2 (fd %d, path %d/%s, flags %lld) succeeded, but stat failed (%s).\n",
+				rc, dirfd, path, my_how.flags, strerror(errno));
+			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, path, 0);
+		}
+		errno = save_errno;
+	}
 
 /*	return rc;
  * }
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 300b5a5..b920cb2 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -69,6 +69,7 @@ syscall(long number, ...) {
 	/* pseudo and seccomp are incompatible as pseudo uses different syscalls
 	 * so pretend to enable seccomp but really do nothing */
 	if (number == SYS_seccomp) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking seccomp.\n");
 		unsigned long cmd;
 		va_start(ap, number);
 		cmd = va_arg(ap, unsigned long);
@@ -88,6 +89,7 @@ syscall(long number, ...) {
 	 * uses syscall to access openat2() and breaks builds if we don't redirect.
 	 */
 	if (number == SYS_openat2) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking openat2.\n");
 		va_start(ap, number);
 		int dirfd = va_arg(ap, int);
 		const char * path = va_arg(ap, const char *);
@@ -103,6 +105,7 @@ syscall(long number, ...) {
 #ifdef SYS_renameat2
         /* Call out wrapper, expanding the variable arguments first */
 	if (number == SYS_renameat2) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking renameat2.\n");
 		va_start(ap, number);
 		int olddirfd = va_arg(ap, int);
 		const char * oldpath = va_arg(ap, const char *);
diff --git a/test/test-syscall.c b/test/test-syscall.c
index 9031766..170fd31 100644
--- a/test/test-syscall.c
+++ b/test/test-syscall.c
@@ -72,12 +72,13 @@ int main() {
             printf("openat2: fail: function implemented: %s\n", strerror(errno));
             rc++;
         }
-        else
-            printf("openat2: pass\n");
+        else {
+            printf("openat2: fail: %s", strerror(errno));
+            rc++;
+	}
     }
     else {
-        printf("openat2: fail: function implemented\n");
-        rc++;
+        printf("openat2: pass\n");
     }
 
     close(fd);
-- 
1.8.3.1


