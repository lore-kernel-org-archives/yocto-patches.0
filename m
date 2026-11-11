Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2569.1794370865443395494
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lq2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:04 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 06/34] ports/unix: Remove guts overridden by the Linux port
Date: Tue, 10 Nov 2026 22:20:34 -0600
Message-Id: <1794370862-30908-7-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5266
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

lchown, lutimes, mknod, mknodat, tmpnam and utimes are wrapped by both
ports/unix and ports/linux.  makewrappers always uses the Linux
versions, reporting "Info: <name> from linux overriding unix", so the
ports/unix guts and wrapfuncs.in entries are never used now that Linux
is the only port.

They were removed as a single commit, so if necessary they can be
restored via a git revert if a future port requires them.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security           |  2 +-
 ports/unix/guts/lchown.c  | 15 -----------
 ports/unix/guts/lutimes.c | 16 ------------
 ports/unix/guts/mknod.c   | 15 -----------
 ports/unix/guts/mknodat.c | 64 -----------------------------------------------
 ports/unix/guts/tmpnam.c  | 20 ---------------
 ports/unix/guts/utimes.c  | 15 -----------
 ports/unix/wrapfuncs.in   |  6 -----
 8 files changed, 1 insertion(+), 152 deletions(-)
 delete mode 100644 ports/unix/guts/lchown.c
 delete mode 100644 ports/unix/guts/lutimes.c
 delete mode 100644 ports/unix/guts/mknod.c
 delete mode 100644 ports/unix/guts/mknodat.c
 delete mode 100644 ports/unix/guts/tmpnam.c
 delete mode 100644 ports/unix/guts/utimes.c

diff --git a/README.security b/README.security
index f4378c3..8817450 100644
--- a/README.security
+++ b/README.security
@@ -92,7 +92,7 @@ that protection in several ways:
 * Several wrappers check a path and then act on it by path in a second
   step.  For example, fchmodat (ports/unix/guts/fchmodat.c) stats the
   path and later calls the real chmod on the same path, and mknodat
-  (ports/unix/guts/mknodat.c) removes the path again by name if the
+  (ports/linux/guts/__xmknodat.c) removes the path again by name if the
   database update fails.
 
 If anything else can change the tree while pseudo is working on it, an
diff --git a/ports/unix/guts/lchown.c b/ports/unix/guts/lchown.c
deleted file mode 100644
index 3a14e2f..0000000
--- a/ports/unix/guts/lchown.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (c) 2008,2011 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * int lchown(const char *path, uid_t owner, gid_t group)
- *	int rc = -1;
- */
-
-	rc = wrap_chown(path, owner, group);
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/guts/lutimes.c b/ports/unix/guts/lutimes.c
deleted file mode 100644
index 07cab66..0000000
--- a/ports/unix/guts/lutimes.c
+++ /dev/null
@@ -1,16 +0,0 @@
-/* 
- * Copyright (c) 2010 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * static int
- * wrap_lutimes(const char *path, const struct timeval *tv) {
- *	int rc = -1;
- */
-
-	rc = real_lutimes(path, tv);
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/guts/mknod.c b/ports/unix/guts/mknod.c
deleted file mode 100644
index aff3a0b..0000000
--- a/ports/unix/guts/mknod.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (c) 2011,2014 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * int mknod(const char *path, mode_t mode, dev_t dev)
- *	int rc = -1;
- */
-
-	rc = wrap_mknodat(AT_FDCWD, path, mode, dev);
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/guts/mknodat.c b/ports/unix/guts/mknodat.c
deleted file mode 100644
index 3e8b207..0000000
--- a/ports/unix/guts/mknodat.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright (c) 2011 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev)
- *	int rc = -1;
- */
-
- 	pseudo_msg_t *msg;
-	PSEUDO_STATBUF buf;
-        int save_errno = errno;
-
-	/* mask out mode bits appropriately */
-	mode = mode & ~pseudo_umask;
-        /* if you don't specify a type, assume regular file */
-        if (!(mode & S_IFMT)) {
-                mode |= S_IFREG;
-        }
-        pseudo_debug(PDBGF_FILE, "mknodat creating '%s', mode 0%o\n",
-                path ? path : "<no name>", (int) mode);
-
-	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-	if (rc != -1) {
-		/* if we can stat the file, you can't mknod it */
-		errno = EEXIST;
-		return -1;
-	}
-	rc = real_openat(dirfd, path, O_CREAT | O_WRONLY | O_EXCL,
-		PSEUDO_FS_MODE(mode, 0));
-	if (rc == -1) {
-		return -1;
-	}
-	real_fchmod(rc, PSEUDO_FS_MODE(mode, 0));
-	base_fstat(rc, &buf);
-	/* mknod does not really open the file.  We don't have
-	 * to use wrap_close because we've never exposed this file
-	 * descriptor to the client code.
-	 */
-	real_close(rc);
-
-	/* mask in the mode type bits again */
-	buf.st_mode = (PSEUDO_DB_MODE(buf.st_mode, mode) & 07777) |
-			(mode & ~07777);
-	buf.st_rdev = dev;
-	msg = pseudo_client_op(OP_MKNOD, 0, -1, dirfd, path, &buf);
-	if (msg && msg->result != RESULT_SUCCEED) {
-		errno = EPERM;
-		rc = -1;
-	} else {
-		/* just pretend we worked */
-                errno = save_errno;
-		rc = 0;
-	}
-	if (rc == -1) {
-                save_errno = errno;
-		real_unlinkat(dirfd, path, AT_SYMLINK_NOFOLLOW);
-		errno = save_errno;
-	}
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/guts/tmpnam.c b/ports/unix/guts/tmpnam.c
deleted file mode 100644
index 60b66e0..0000000
--- a/ports/unix/guts/tmpnam.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/* 
- * Copyright (c) 2010 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * static char *
- * wrap_tmpnam(char *s) {
- *	char * rc = NULL;
- */
-
-	/* let gcc know we're ignoring this */
-	(void) s;
-	pseudo_warning("tmpnam() is so ludicrously insecure as to defy implementation.");
-	errno = ENOMEM;
-	rc = NULL;
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/guts/utimes.c b/ports/unix/guts/utimes.c
deleted file mode 100644
index ec49f02..0000000
--- a/ports/unix/guts/utimes.c
+++ /dev/null
@@ -1,15 +0,0 @@
-/* 
- * Copyright (c) 2010 Wind River Systems; see
- * guts/COPYRIGHT for information.
- *
- * SPDX-License-Identifier: LGPL-2.1-only
- *
- * static int
- * wrap_utimes(const char *path, const struct timeval *times) {
- *	int rc = -1;
- */
-	rc = real_utimes(path, times);
-
-/*	return rc;
- * }
- */
diff --git a/ports/unix/wrapfuncs.in b/ports/unix/wrapfuncs.in
index 5ffee83..95fa89c 100644
--- a/ports/unix/wrapfuncs.in
+++ b/ports/unix/wrapfuncs.in
@@ -4,7 +4,6 @@ char *getwd(char *buf);
 int close(int fd);  /* noignore_path=1 */
 int fchmod(int fd, mode_t mode);
 int fchown(int fd, uid_t owner, gid_t group);
-int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=shared */
 int dup2(int oldfd, int newfd); /* noignore_path=1 */
 int dup(int fd); /* noignore_path=1 */
 int chdir(const char *path); /* noignore_path=1 */
@@ -18,7 +17,6 @@ FTSENT *fts_children(FTS *ftsp, int options); /* noignore_path=1, path_lock=shar
 int ftw(const char *path, int (*fn)(const char *, const struct stat *, int), int nopenfd);
 int nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag);
 int glob(const char *pattern, int flags, int (*errfunc)(const char *, int), glob_t *pglob);
-int lutimes(const char *path, const struct timeval *tv); /* flags=AT_SYMLINK_NOFOLLOW */
 char *mkdtemp(char *template); /* path_lock=1 */
 char *mktemp(char *template);
 long pathconf(const char *path, int name);
@@ -27,10 +25,8 @@ int remove(const char *path); /* flags=AT_SYMLINK_NOFOLLOW */
 DIR *opendir(const char *path); /* noignore_path=1 */
 int closedir(DIR *dirp); /* noignore_path=1 */
 char *tempnam(const char *template, const char *pfx);
-char *tmpnam(char *s);
 int truncate(const char *path, off_t length);
 int utime(const char *path, const struct utimbuf *buf);
-int utimes(const char *path, const struct timeval *times);
 # needed because libc stdio does horrible things with inline asm syscalls
 FILE *fopen(const char *path, const char *mode); /* noignore_path=1 */
 int fclose(FILE *fp);  /* noignore_path=1 */
@@ -47,8 +43,6 @@ int mkdir(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_loc
 int mkdirat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int mkfifo(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int mkfifoat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
-int mknod(const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
-int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int mkstemp(char *template); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int mkostemp(char *template, int oflags); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int mkstemps(char *template, int suffixlen); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
-- 
1.8.3.1

