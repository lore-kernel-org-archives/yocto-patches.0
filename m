Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2568.1794370865285605254
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lp2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:04 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 05/34] ports: Remove PSEUDO_NO_REAL_AT_FUNCTIONS
Date: Tue, 10 Nov 2026 22:20:33 -0600
Message-Id: <1794370862-30908-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5265
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

PSEUDO_NO_REAL_AT_FUNCTIONS was defined, along with substitute AT_FDCWD
and AT_SYMLINK_* values, when <fcntl.h> did not provide AT_FDCWD.  The
guts then used non-*at() fallbacks, or failed with ENOSYS when given a
directory descriptor.

Linux always provides the *at() functions, and pseudo.h includes
<fcntl.h>, so the macro is never defined and none of the fallbacks are
ever built.  Remove them, keeping the *at() code, and make a missing
AT_FDCWD a build error instead.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/guts/__fxstatat.c      | 12 ------------
 ports/linux/guts/__fxstatat64.c    | 14 --------------
 ports/linux/guts/__xmknodat.c      | 17 -----------------
 ports/linux/guts/openat.c          | 35 -----------------------------------
 ports/linux/openat2/guts/openat2.c | 28 ++--------------------------
 ports/unix/guts/faccessat2.c       | 12 ------------
 ports/unix/guts/fchmodat.c         | 18 ------------------
 ports/unix/guts/fchownat.c         | 12 ------------
 ports/unix/guts/linkat.c           | 11 -----------
 ports/unix/guts/mkdirat.c          | 17 -----------------
 ports/unix/guts/mkfifoat.c         | 22 ----------------------
 ports/unix/guts/mknodat.c          | 17 -----------------
 ports/unix/guts/readlinkat.c       |  8 --------
 ports/unix/guts/renameat.c         | 12 ------------
 ports/unix/guts/symlinkat.c        | 12 ------------
 ports/unix/guts/unlinkat.c         | 25 -------------------------
 pseudo.h                           | 19 ++++++-------------
 17 files changed, 8 insertions(+), 283 deletions(-)

diff --git a/ports/linux/guts/__fxstatat.c b/ports/linux/guts/__fxstatat.c
index 23dfa73..99198f7 100644
--- a/ports/linux/guts/__fxstatat.c
+++ b/ports/linux/guts/__fxstatat.c
@@ -11,19 +11,7 @@
 
 	struct stat64 buf64;
 	/* populate buffer with complete data */
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (flags & AT_SYMLINK_NOFOLLOW) {
-		rc = real___lxstat(ver, path, buf);
-	} else {
-		rc = real___xstat(ver, path, buf);
-	}
-#else
 	real___fxstatat(ver, dirfd, path, buf, flags);
-#endif
 	/* obtain fake data */
 	rc = wrap___fxstatat64(ver, dirfd, path, &buf64, flags);
 	/* overwrite */
diff --git a/ports/linux/guts/__fxstatat64.c b/ports/linux/guts/__fxstatat64.c
index ecf2952..6f58aa2 100644
--- a/ports/linux/guts/__fxstatat64.c
+++ b/ports/linux/guts/__fxstatat64.c
@@ -11,27 +11,13 @@
 	pseudo_msg_t *msg;
 	int save_errno;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-#endif
 	if (flags & AT_SYMLINK_NOFOLLOW) {
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		rc = real___lxstat64(ver, path, buf);
-#else
 		rc = real___fxstatat64(ver, dirfd, path, buf, flags);
-#endif
 		if (rc == -1) {
 			return rc;
 		}
 	} else {
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		rc = real___xstat64(ver, path, buf);
-#else
 		rc = real___fxstatat64(ver, dirfd, path, buf, flags);
-#endif
 		if (rc == -1) {
 			return rc;
 		}
diff --git a/ports/linux/guts/__xmknodat.c b/ports/linux/guts/__xmknodat.c
index 8c34427..84d535b 100644
--- a/ports/linux/guts/__xmknodat.c
+++ b/ports/linux/guts/__xmknodat.c
@@ -23,15 +23,7 @@
 	/* we don't use underlying call, so _ver is irrelevant to us */
 	(void) ver;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	rc = real___xstat64(_STAT_VER, path, &buf);
-#else
 	rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc != -1) {
 		/* if we can stat the file, you can't mknod it */
 		errno = EEXIST;
@@ -41,13 +33,8 @@
 		errno = EINVAL;
 		return -1;
 	}
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = real_open(path, O_CREAT | O_WRONLY | O_EXCL,
-		PSEUDO_FS_MODE(mode, 0));
-#else
 	rc = real_openat(dirfd, path, O_CREAT | O_WRONLY | O_EXCL,
 		PSEUDO_FS_MODE(mode, 0));
-#endif
 	if (rc == -1) {
 		return -1;
 	}
@@ -73,11 +60,7 @@
 	}
 	if (rc == -1) {
 		int save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		real_unlink(path);
-#else
 		real_unlinkat(dirfd, path, AT_SYMLINK_NOFOLLOW);
-#endif
 		errno = save_errno;
 	}
 
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index 4fd83dd..f5469e6 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -17,13 +17,6 @@
 	/* mask out mode bits appropriately */
 	mode = mode & ~pseudo_umask;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-#endif
-
 #ifdef PSEUDO_FORCE_ASYNC
         /* Yes, I'm aware that every Linux system I've seen has
          * DSYNC and RSYNC being the same value as SYNC.
@@ -54,15 +47,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (flags & O_CREAT) {
 		save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, path, &buf);
-		} else {
-			rc = real___xstat64(_STAT_VER, path, &buf);
-		}
-#else
 		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 		existed = (rc != -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat_creat: %s -> 0%o\n", path, mode);
@@ -75,15 +60,7 @@
 	 */
 	if (!(flags & O_NONBLOCK) && ((flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_RDWR)) {
 		save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, path, &buf);
-		} else {
-			rc = real___xstat64(_STAT_VER, path, &buf);
-		}
-#else
 		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking = 1;
 		}
@@ -99,11 +76,7 @@
 	 * is if a file is going to be created, in which case it's
 	 * not a directory.
 	 */
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = real_open(path, flags, PSEUDO_FS_MODE(mode, 0));
-#else
 	rc = real_openat(dirfd, path, flags, PSEUDO_FS_MODE(mode, 0));
-#endif
 	if (overly_magic_nonblocking) {
 		save_errno = errno;
 		sigprocmask(SIG_SETMASK, &local_saved_sigmask, NULL);
@@ -132,15 +105,7 @@
 			return rc;
 		}
 #endif
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (flags & O_NOFOLLOW) {
-			stat_rc = real___lxstat64(_STAT_VER, path, &buf);
-		} else {
-			stat_rc = real___xstat64(_STAT_VER, path, &buf);
-		}
-#else
 		stat_rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 
 		pseudo_debug(PDBGF_FILE, "openat(path %s), flags %o, stat rc %d, stat mode %o\n",
 			path, flags, stat_rc, buf.st_mode);
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index 06fcec8..5171647 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -44,7 +44,7 @@
 	/* mask out mode bits appropriately */
 	my_how.mode = my_how.mode & ~pseudo_umask;
 
-#if defined(PSEUDO_NO_REAL_AT_FUNCTIONS) || ! defined(SYS_openat2)
+#ifndef SYS_openat2
 	if (dirfd != AT_FDCWD) {
 		errno = ENOSYS;
 		return -1;
@@ -81,15 +81,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (my_how.flags & O_CREAT) {
 		save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (my_how.flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
-		} else {
-			rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
-		}
-#else
 		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 		existed = (rc != -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", pseudo_path, my_how.mode);
@@ -102,15 +94,7 @@
 	 */
 	if (!(my_how.flags & O_NONBLOCK) && ((my_how.flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_RDWR)) {
 		save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (my_how.flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
-		} else {
-			rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
-		}
-#else
 		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking = 1;
 		}
@@ -126,7 +110,7 @@
 	 * is if a file is going to be created, in which case it's
 	 * not a directory.
 	 */
-#if defined(PSEUDO_NO_REAL_AT_FUNCTIONS) || ! defined(SYS_openat2)
+#ifndef SYS_openat2
 	pseudo_debug(PDBGF_SYSCALL, "openat2, calling open.\n");
 	rc = real_open(path, my_how.flags, PSEUDO_FS_MODE(my_how.mode, 0));
 #else
@@ -167,15 +151,7 @@
 			return rc;
 		}
 #endif
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		if (my_how.flags & O_NOFOLLOW) {
-			stat_rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
-		} else {
-			stat_rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
-		}
-#else
 		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
-#endif
 
 		pseudo_debug(PDBGF_FILE, "openat2(path %s), flags %lld, stat rc %d, stat mode %o\n",
 			pseudo_path, my_how.flags, stat_rc, buf.st_mode);
diff --git a/ports/unix/guts/faccessat2.c b/ports/unix/guts/faccessat2.c
index 1283cc6..d4a2a42 100644
--- a/ports/unix/guts/faccessat2.c
+++ b/ports/unix/guts/faccessat2.c
@@ -10,19 +10,7 @@
  */
 	PSEUDO_STATBUF buf;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (flags & AT_SYMLINK_NOFOLLOW) {
-		rc = base_lstat(path, &buf);
-	} else {
-		rc = base_stat(path, &buf);
-	}
-#else
 	rc = base_fstatat(dirfd, path, &buf, flags & AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc == -1)
 		return rc;
 
diff --git a/ports/unix/guts/fchmodat.c b/ports/unix/guts/fchmodat.c
index 5a31151..12dc9e3 100644
--- a/ports/unix/guts/fchmodat.c
+++ b/ports/unix/guts/fchmodat.c
@@ -11,19 +11,7 @@
 	PSEUDO_STATBUF buf;
 	int save_errno = errno;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (flags & AT_SYMLINK_NOFOLLOW) {
-	    rc = base_lstat(path, &buf);
-	} else {
-	    rc = base_stat(path, &buf);
-	}
-#else
 	rc = base_fstatat(dirfd, path, &buf, flags);
-#endif
 	if (rc == -1) {
 		return rc;
 	}
@@ -50,13 +38,7 @@
 #endif
 
 	/* user bits added so "root" can always access files. */
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	/* note:  if path was a symlink, and AT_SYMLINK_NOFOLLOW was
-	 * specified, we already bailed previously. */
-	real_chmod(path, PSEUDO_FS_MODE(mode, S_ISDIR(buf.st_mode)));
-#else
 	rc = real_fchmodat(dirfd, path, PSEUDO_FS_MODE(mode, S_ISDIR(buf.st_mode)), flags);
-#endif
 	/* we otherwise ignore failures from underlying fchmod, because pseudo
 	 * may believe you are permitted to change modes that the filesystem
 	 * doesn't. Note that we also don't need to know whether the
diff --git a/ports/unix/guts/fchownat.c b/ports/unix/guts/fchownat.c
index 76d276a..3af774f 100644
--- a/ports/unix/guts/fchownat.c
+++ b/ports/unix/guts/fchownat.c
@@ -12,19 +12,7 @@
 	PSEUDO_STATBUF buf;
 	int save_errno = errno;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (flags & AT_SYMLINK_NOFOLLOW) {
-		rc = base_lstat(path, &buf);
-	} else {
-		rc = base_stat(path, &buf);
-	}
-#else
 	rc = base_fstatat(dirfd, path, &buf, flags);
-#endif
 	if (rc == -1) {
 		return rc;
 	}
diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index f0cedd4..e22d66a 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -27,12 +27,6 @@
 	
 	rflags = (flags & AT_SYMLINK_FOLLOW) ? 0 : AT_SYMLINK_NOFOLLOW;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (olddirfd != AT_FDCWD || newdirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-#endif
 	oldpath = oldname;
 	if (oldpath && *oldpath && pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
 		oldpath[pseudo_chroot_len] == '/') {
@@ -54,11 +48,6 @@
 	 */
 #ifdef O_TMPFILE
 	if (!strncmp(oldpath, "/proc/self/fd/", 14) && (flags & AT_SYMLINK_FOLLOW)) {
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		/* only linkat() lets you do this horrible thing */
-		errno = ENOSYS;
-		return -1;
-#endif
 		tmpfile_fd = pseudo_atoi_wrapper(oldpath + 14);
 		// call actual link
 		rc = real_linkat(AT_FDCWD, oldpath, AT_FDCWD, newpath, AT_SYMLINK_FOLLOW);
diff --git a/ports/unix/guts/mkdirat.c b/ports/unix/guts/mkdirat.c
index f66e99a..4db3826 100644
--- a/ports/unix/guts/mkdirat.c
+++ b/ports/unix/guts/mkdirat.c
@@ -10,34 +10,17 @@
  */
 	/* mask out mode bits appropriately */
 	mode = mode & ~pseudo_umask;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-
-	rc = real_mkdir(path, PSEUDO_FS_MODE(mode, 1));
-#else
 	rc = real_mkdirat(dirfd, path, PSEUDO_FS_MODE(mode, 1));
-#endif
 	if (rc != -1) {
 		PSEUDO_STATBUF buf;
 		int stat_rc;
 		int save_errno = errno;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		stat_rc = base_lstat(path, &buf);
-#else
 		stat_rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 		if (stat_rc != -1) {
 			buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, mode);
 			pseudo_client_op(OP_MKDIR, 0, -1, dirfd, path, &buf);
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-			real_fchmod(path, PSEUDO_FS_MODE(mode, 1));
-#else
 			real_fchmodat(dirfd, path, PSEUDO_FS_MODE(mode, 1), 0);
-#endif
 		} else {
 			pseudo_debug(PDBGF_OP, "mkdir of %s succeeded, but stat failed: %s\n",
 				path, strerror(errno));
diff --git a/ports/unix/guts/mkfifoat.c b/ports/unix/guts/mkfifoat.c
index bc547eb..c068841 100644
--- a/ports/unix/guts/mkfifoat.c
+++ b/ports/unix/guts/mkfifoat.c
@@ -16,29 +16,12 @@
 	/* mask out mode bits appropriately */
 	mode = mode & ~pseudo_umask;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	rc = base_stat(path, &buf);
-#else
 	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc != -1) {
 		/* if we can stat the file, you can't mkfifo it */
 		errno = EEXIST;
 		return -1;
 	}
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = real_mkfifo(path, PSEUDO_FS_MODE(mode, 0));
-	if (rc == -1) {
-		return -1;
-	}
-	save_errno = errno;
-	rc = base_stat(path, &buf);
-	real_chmod(path, PSEUDO_FS_MODE(mode, 0));
-#else
 	rc = real_mkfifoat(dirfd, path, PSEUDO_FS_MODE(mode, 0));
 	if (rc == -1) {
 		return -1;
@@ -46,7 +29,6 @@
 	save_errno = errno;
 	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
 	real_fchmodat(dirfd, path, PSEUDO_FS_MODE(mode, 0), 0);
-#endif
 	/* if the stat failed, we are going to give up and nuke
 	 * any file we may have created, and hope for the best.
 	 */
@@ -67,11 +49,7 @@
 	}
 	if (rc == -1) {
                 save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		real_unlink(path);
-#else
 		real_unlinkat(dirfd, path, AT_SYMLINK_NOFOLLOW);
-#endif
 		errno = save_errno;
 	}
 
diff --git a/ports/unix/guts/mknodat.c b/ports/unix/guts/mknodat.c
index 9e86c93..3e8b207 100644
--- a/ports/unix/guts/mknodat.c
+++ b/ports/unix/guts/mknodat.c
@@ -21,27 +21,14 @@
         pseudo_debug(PDBGF_FILE, "mknodat creating '%s', mode 0%o\n",
                 path ? path : "<no name>", (int) mode);
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	rc = base_stat(path, &buf);
-#else
 	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc != -1) {
 		/* if we can stat the file, you can't mknod it */
 		errno = EEXIST;
 		return -1;
 	}
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = real_open(path, O_CREAT | O_WRONLY | O_EXCL,
-		PSEUDO_FS_MODE(mode, 0));
-#else
 	rc = real_openat(dirfd, path, O_CREAT | O_WRONLY | O_EXCL,
 		PSEUDO_FS_MODE(mode, 0));
-#endif
 	if (rc == -1) {
 		return -1;
 	}
@@ -68,11 +55,7 @@
 	}
 	if (rc == -1) {
                 save_errno = errno;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-		real_unlink(path);
-#else
 		real_unlinkat(dirfd, path, AT_SYMLINK_NOFOLLOW);
-#endif
 		errno = save_errno;
 	}
 
diff --git a/ports/unix/guts/readlinkat.c b/ports/unix/guts/readlinkat.c
index 86832da..2d1bce0 100644
--- a/ports/unix/guts/readlinkat.c
+++ b/ports/unix/guts/readlinkat.c
@@ -8,15 +8,7 @@
  * wrap_readlinkat(int dirfd, const char *path, char *buf, size_t bufsiz) {
  *	ssize_t rc = -1;
  */
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	rc = real_readlink(path, buf, bufsiz);
-#else
 	rc = real_readlinkat(dirfd, path, buf, bufsiz);
-#endif
 
 	if (rc > 0) {
 		rc = pseudo_dechroot(buf, rc);
diff --git a/ports/unix/guts/renameat.c b/ports/unix/guts/renameat.c
index 69130c6..98391dd 100644
--- a/ports/unix/guts/renameat.c
+++ b/ports/unix/guts/renameat.c
@@ -20,13 +20,6 @@
 		olddirfd, oldpath ? oldpath : "<nil>",
 		newdirfd, newpath ? newpath : "<nil>");
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (olddirfd != AT_FDCWD || newdirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-#endif
-
 	if (!oldpath || !newpath) {
 		errno = EFAULT;
 		return -1;
@@ -34,13 +27,8 @@
 
 	save_errno = errno;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	newrc = base_lstat(newpath, &newbuf);
-	oldrc = base_lstat(oldpath, &oldbuf);
-#else
 	oldrc = base_fstatat(olddirfd, oldpath, &oldbuf, AT_SYMLINK_NOFOLLOW);
 	newrc = base_fstatat(newdirfd, newpath, &newbuf, AT_SYMLINK_NOFOLLOW);
-#endif
 
 	/* nothing to do for a "rename" of a link to itself */
 	if (newrc != -1 && oldrc != -1 &&
diff --git a/ports/unix/guts/symlinkat.c b/ports/unix/guts/symlinkat.c
index 5673912..0efe4d1 100644
--- a/ports/unix/guts/symlinkat.c
+++ b/ports/unix/guts/symlinkat.c
@@ -17,25 +17,13 @@
 		snprintf(roldname, len, "%s%s", pseudo_chroot, oldname);
 	}
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	rc = real_symlink(roldname ? roldname : oldname, newpath);
-#else
 	rc = real_symlinkat(roldname ? roldname : oldname, dirfd, newpath);
-#endif
 
 	if (rc == -1) {
 		free(roldname);
 		return rc;
 	}
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = base_lstat(newpath, &buf);
-#else
 	rc = base_fstatat(dirfd, newpath, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc == -1) {
 		int save_errno = errno;
 		pseudo_warning("symlinkat: couldn't stat '%s' even though symlink creation succeeded (%s).\n",
diff --git a/ports/unix/guts/unlinkat.c b/ports/unix/guts/unlinkat.c
index 9889b2e..d0f795b 100644
--- a/ports/unix/guts/unlinkat.c
+++ b/ports/unix/guts/unlinkat.c
@@ -13,39 +13,14 @@
 	PSEUDO_STATBUF buf;
 	int old_db_entry = 0;
 
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	if (dirfd != AT_FDCWD) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (rflags) {
-		/* the only supported flag is AT_REMOVEDIR.  We'd never call
-		 * with that flag unless the real AT functions exist, so 
-		 * something must have gone horribly wrong....
-		 */
-		pseudo_info("wrap_unlinkat called with flags (0x%x), path '%s'\n",
-			rflags, path ? path : "<nil>");
-		errno = ENOSYS;
-		return -1;
-	}
-#endif
-
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = base_lstat(path, &buf);
-#else
 	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
-#endif
 	if (rc == -1) {
 		return rc;
 	}
 	msg = pseudo_client_op(OP_MAY_UNLINK, 0, -1, dirfd, path, &buf);
 	if (msg && msg->result == RESULT_SUCCEED)
 		old_db_entry = 1;
-#ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
-	rc = real_unlink(path);
-#else
 	rc = real_unlinkat(dirfd, path, rflags);
-#endif
 	if (old_db_entry) {
 		if (rc == -1) {
 			save_errno = errno;
diff --git a/pseudo.h b/pseudo.h
index 6d50b77..53bf13f 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -135,23 +135,16 @@ extern char *pseudo_version;
 
 #define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
 
-/* some systems might not have *at().  We like to define operations in
- * terms of each other, and for instance, open(...) is the same as
- * openat(AT_FDCWD, ...).  If no AT_FDCWD is provided, any value that can't
- * be a valid file descriptor will do.  Using -2 because -1 could be
- * mistaken for a failed syscall return.  AT_SYMLINK_NOFOLLOW has to be
- * non-zero; AT_SYMLINK_FOLLOW has to be non-zero and different.  Finally,
- * if this happened, we set our own flag we can use to indicate that dummy
- * implementations of the _at functions are needed.
+/* pseudo defines operations in terms of each other; for instance,
+ * open(...) is the same as openat(AT_FDCWD, ...).  This requires the *at()
+ * functions and AT_FDCWD, AT_SYMLINK_NOFOLLOW and AT_SYMLINK_FOLLOW from
+ * <fcntl.h>.
  */
 #ifndef AT_FDCWD
-#define AT_FDCWD -2
-#define AT_SYMLINK_NOFOLLOW 1
-#define AT_SYMLINK_FOLLOW 2
-#define PSEUDO_NO_REAL_AT_FUNCTIONS
+#error "pseudo requires *at() function support (AT_FDCWD, AT_SYMLINK_NOFOLLOW, AT_SYMLINK_FOLLOW)"
 #endif
 
-/* Likewise, someone might not have O_LARGEFILE (the flag equivalent to
+/* Someone might not have O_LARGEFILE (the flag equivalent to
  * using open64()).  Since open64() is the same as O_LARGEFILE in flags,
  * we implement it that way... If the system has no O_LARGEFILE, we'll
  * just call open() with nothing special.
-- 
1.8.3.1

