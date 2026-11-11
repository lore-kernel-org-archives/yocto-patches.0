Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2570.1794370865575399059
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lr2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 07/34] ports: Let the port define how pseudo stats files
Date: Tue, 10 Nov 2026 22:20:35 -0600
Message-Id: <1794370862-30908-8-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5267
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

stat64(), lstat64() and fstat64() are not POSIX.  They come from the
Large File Summit transitional interface, which glibc provides but the
BSDs and macOS don't, and musl is phasing out.  The __xstat64() family
called with _STAT_VER is glibc internal, and only kept for binary
compatibility since glibc 2.33.

pseudo_client.h chose between two sets of base_*stat() definitions with
PSEUDO_STATBUF_64, which the Linux port always set, while several guts
called real___xstat64(_STAT_VER, ...) and friends directly, and shared
code used struct stat64.

Move the base_stat(), base_lstat(), base_fstat() and base_fstatat()
definitions into ports/linux/portdefs.h, next to PSEUDO_STATBUF, and
make pseudo_client.h fail with #error if a port doesn't define them.
Use the base_*() macros instead of the direct calls in the guts, except
in the __fxstat64 and __fxstatat64 wrappers, which pass through the
caller's version.  Use PSEUDO_STATBUF instead of struct stat64 in shared
code and for local buffers in the guts.

real_stat64() and friends are pseudo_stat64() and friends, which call
real___xstat64(_STAT_VER, ...), so the behaviour is unchanged.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/guts/__xmknodat.c      |  6 +++---
 ports/linux/guts/fopen64.c         |  6 +++---
 ports/linux/guts/freopen64.c       |  6 +++---
 ports/linux/guts/mkostemp64.c      |  4 ++--
 ports/linux/guts/open_tree.c       |  4 ++--
 ports/linux/guts/open_tree_attr.c  |  4 ++--
 ports/linux/guts/openat.c          | 10 +++++-----
 ports/linux/openat2/guts/openat2.c | 10 +++++-----
 ports/linux/portdefs.h             | 10 +++++++++-
 pseudo.h                           |  6 ++++--
 pseudo_client.c                    |  6 +++---
 pseudo_client.h                    | 13 +++----------
 pseudo_util.c                      |  4 ++--
 13 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/ports/linux/guts/__xmknodat.c b/ports/linux/guts/__xmknodat.c
index 84d535b..21ad641 100644
--- a/ports/linux/guts/__xmknodat.c
+++ b/ports/linux/guts/__xmknodat.c
@@ -9,7 +9,7 @@
  *	int rc = -1;
  */
  	pseudo_msg_t *msg;
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 
 	/* mask out mode bits appropriately */
 	mode = mode & ~pseudo_umask;
@@ -23,7 +23,7 @@
 	/* we don't use underlying call, so _ver is irrelevant to us */
 	(void) ver;
 
-	rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
+	rc = base_fstatat(dirfd, path, &buf, AT_SYMLINK_NOFOLLOW);
 	if (rc != -1) {
 		/* if we can stat the file, you can't mknod it */
 		errno = EEXIST;
@@ -39,7 +39,7 @@
 		return -1;
 	}
 	real_fchmod(rc, PSEUDO_FS_MODE(mode, 0));
-	real___fxstat64(_STAT_VER, rc, &buf);
+	base_fstat(rc, &buf);
 	/* mknod does not really open the file.  We don't have
 	 * to use wrap_close because we've never exposed this file
 	 * descriptor to the client code.
diff --git a/ports/linux/guts/fopen64.c b/ports/linux/guts/fopen64.c
index a6efd18..6355334 100644
--- a/ports/linux/guts/fopen64.c
+++ b/ports/linux/guts/fopen64.c
@@ -8,10 +8,10 @@
  * wrap_fopen64(const char *path, const char *mode) {
  *	FILE * rc = 0;
  */
- 	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int save_errno;
 
-	int existed = (real___xstat64(_STAT_VER, path, &buf) != -1);
+	int existed = (base_stat(path, &buf) != -1);
 
 	rc = real_fopen64(path, mode);
 	save_errno = errno;
@@ -20,7 +20,7 @@
 		int fd = fileno(rc);
 
 		pseudo_debug(PDBGF_FILE, "fopen64 '%s': fd %d <FILE %p>\n", path, fd, (void *) rc);
-		if (real___fxstat64(_STAT_VER, fd, &buf) != -1) {
+		if (base_fstat(fd, &buf) != -1) {
 			if (!existed) {
 				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
diff --git a/ports/linux/guts/freopen64.c b/ports/linux/guts/freopen64.c
index 6057eda..99ca9cf 100644
--- a/ports/linux/guts/freopen64.c
+++ b/ports/linux/guts/freopen64.c
@@ -8,9 +8,9 @@
  * wrap_freopen64(const char *path, const char *mode, FILE *stream) {
  *	FILE * rc = NULL;
  */
- 	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int save_errno;
-	int existed = (real___xstat64(_STAT_VER, path, &buf) != -1);
+	int existed = (base_stat(path, &buf) != -1);
 
 	rc = real_freopen64(path, mode, stream);
 	save_errno = errno;
@@ -19,7 +19,7 @@
 		int fd = fileno(rc);
 
 		pseudo_debug(PDBGF_FILE, "freopen64 '%s': fd %d\n", path, fd);
-		if (real___fxstat64(_STAT_VER, fd, &buf) != -1) {
+		if (base_fstat(fd, &buf) != -1) {
 			if (!existed) {
 				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
diff --git a/ports/linux/guts/mkostemp64.c b/ports/linux/guts/mkostemp64.c
index 502211b..23c30c4 100644
--- a/ports/linux/guts/mkostemp64.c
+++ b/ports/linux/guts/mkostemp64.c
@@ -8,7 +8,7 @@
  * wrap_mkstemp64(char *template, int oflags) {
  *	int rc = -1;
  */
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
  	int save_errno;
 	size_t len;
 	char *tmp_template;
@@ -35,7 +35,7 @@
 	if (rc != -1) {
 		save_errno = errno;
 
-		if (real___fxstat64(_STAT_VER, rc, &buf) != -1) {
+		if (base_fstat(rc, &buf) != -1) {
 			real_fchmod(rc, PSEUDO_FS_MODE(0600, 0));
 			pseudo_client_op(OP_CREAT, 0, -1, -1, tmp_template, &buf);
 			pseudo_client_op(OP_OPEN, PSA_READ | PSA_WRITE, rc, -1, tmp_template, &buf);
diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
index f2e39ad..01d3dfc 100644
--- a/ports/linux/guts/open_tree.c
+++ b/ports/linux/guts/open_tree.c
@@ -8,7 +8,7 @@
  *	int rc = -1;
  */
 
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int save_errno;
 	char *pseudo_path;
 
@@ -46,7 +46,7 @@
 		save_errno = errno;
 		int stat_rc;
 
-		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc = base_fstatat(dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o, stat rc %d, stat mode %o\n",
 			pseudo_path, flags, stat_rc, buf.st_mode);
diff --git a/ports/linux/guts/open_tree_attr.c b/ports/linux/guts/open_tree_attr.c
index 8e00c8c..96f32bb 100644
--- a/ports/linux/guts/open_tree_attr.c
+++ b/ports/linux/guts/open_tree_attr.c
@@ -10,7 +10,7 @@
 
 	/* Mostly based on open_tree wrapper */
 
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int save_errno;
 	char *pseudo_path;
 
@@ -44,7 +44,7 @@
 		save_errno = errno;
 		int stat_rc;
 
-		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc = base_fstatat(dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "open_tree_attr(path %s), flags %o, stat rc %d, stat mode %o\n",
 			pseudo_path, flags, stat_rc, buf.st_mode);
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index f5469e6..9d32283 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -8,7 +8,7 @@
  * wrap_openat(int dirfd, const char *path, int flags, ...mode_t mode) {
  *	int rc = -1;
  */
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int overly_magic_nonblocking = 0;
 	int existed = 1;
 	int save_errno;
@@ -47,7 +47,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (flags & O_CREAT) {
 		save_errno = errno;
-		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 		existed = (rc != -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat_creat: %s -> 0%o\n", path, mode);
@@ -60,7 +60,7 @@
 	 */
 	if (!(flags & O_NONBLOCK) && ((flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_RDWR)) {
 		save_errno = errno;
-		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking = 1;
 		}
@@ -105,7 +105,7 @@
 			return rc;
 		}
 #endif
-		stat_rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc = base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "openat(path %s), flags %o, stat rc %d, stat mode %o\n",
 			path, flags, stat_rc, buf.st_mode);
@@ -116,7 +116,7 @@
 				real_fchmod(rc, PSEUDO_FS_MODE(mode, 0));
 				// file has no path, but has been created
 				if (pseudo_client_path_matches_fd(path, rc, flags & O_NOFOLLOW) &&
-				    real___fxstat64(_STAT_VER, rc, &buf) != -1) {
+				    base_fstat(rc, &buf) != -1) {
 					buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, mode);
 					pseudo_client_op(OP_CREAT, 0, -1, dirfd, path, &buf);
 				}
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index 5171647..bb4a125 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -8,7 +8,7 @@
  * int openat2(int dirfd, const char *path, const struct open_how *how, size_t size)
  *	int rc = -1;
  */
-	struct stat64 buf;
+	PSEUDO_STATBUF buf;
 	int overly_magic_nonblocking = 0;
 	int existed = 1;
 	int save_errno;
@@ -81,7 +81,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (my_how.flags & O_CREAT) {
 		save_errno = errno;
-		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 		existed = (rc != -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", pseudo_path, my_how.mode);
@@ -94,7 +94,7 @@
 	 */
 	if (!(my_how.flags & O_NONBLOCK) && ((my_how.flags & (O_WRONLY | O_RDONLY | O_RDWR)) != O_RDWR)) {
 		save_errno = errno;
-		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking = 1;
 		}
@@ -151,7 +151,7 @@
 			return rc;
 		}
 #endif
-		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc = base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "openat2(path %s), flags %lld, stat rc %d, stat mode %o\n",
 			pseudo_path, my_how.flags, stat_rc, buf.st_mode);
@@ -162,7 +162,7 @@
 				real_fchmod(rc, PSEUDO_FS_MODE(my_how.mode, 0));
 				// file has no path, but has been created
 				if (pseudo_client_path_matches_fd(pseudo_path, rc, my_how.flags & O_NOFOLLOW) &&
-				    real___fxstat64(_STAT_VER, rc, &buf) != -1) {
+				    base_fstat(rc, &buf) != -1) {
 					buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, my_how.mode);
 					pseudo_client_op(OP_CREAT, 0, -1, dirfd, pseudo_path, &buf);
 				}
diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index ac1d971..3ac9466 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -4,8 +4,16 @@
  */
 #define PRELINK_LIBRARIES "LD_PRELOAD"
 #define PRELINK_PATH "LD_LIBRARY_PATH"
-#define PSEUDO_STATBUF_64 1
 #define PSEUDO_STATBUF struct stat64
+/* How pseudo stats files itself, bypassing its own wrappers.  glibc's
+ * stat64() and friends were inline wrappers around __xstat64() and
+ * friends before glibc 2.33, and pseudo still uses those to work with
+ * binaries built against older glibc.
+ */
+#define base_lstat real_lstat64
+#define base_fstat real_fstat64
+#define base_stat real_stat64
+#define base_fstatat(dirfd, path, buf, flags) real___fxstatat64(_STAT_VER, dirfd, path, buf, flags)
 #define PSEUDO_LINKPATH_SEPARATOR " "
 /* Linux NEVER follows symlinks for link(2)... except on old kernels
  * I don't care about.
diff --git a/pseudo.h b/pseudo.h
index 53bf13f..d83281c 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -104,8 +104,6 @@ extern ssize_t pseudo_sys_path_max(void);
 extern ssize_t pseudo_path_max(void);
 #define PSEUDO_PWD_MAX 4096
 extern int pseudo_etc_file(const char *filename, char *realname, int flags, const char **search_dirs, int dircount);
-extern void pseudo_stat32_from64(struct stat *, const struct stat64 *);
-extern void pseudo_stat64_from32(struct stat64 *, const struct stat *);
 
 extern long pseudo_strtol_wrapper(const char *, char **, int);
 extern long long pseudo_strtoll_wrapper(const char *, char **, int);
@@ -180,3 +178,7 @@ typedef struct {
 } pseudo_profile_t;
 #endif
 #include "pseudo_ports.h"
+
+/* convert between struct stat and the port's PSEUDO_STATBUF */
+extern void pseudo_stat32_from64(struct stat *, const PSEUDO_STATBUF *);
+extern void pseudo_stat64_from32(PSEUDO_STATBUF *, const struct stat *);
diff --git a/pseudo_client.c b/pseudo_client.c
index a3d461e..4c9c2e8 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -218,7 +218,7 @@ typedef struct {
 static pseudo_msg_t xattrdb_data;
 
 pseudo_msg_t *
-pseudo_xattrdb_save(int fd, const char *path, const struct stat64 *buf) {
+pseudo_xattrdb_save(int fd, const char *path, const PSEUDO_STATBUF *buf) {
 	int rc = -1;
 	if (!path && fd < 0)
 		return NULL;
@@ -249,7 +249,7 @@ pseudo_xattrdb_save(int fd, const char *path, const struct stat64 *buf) {
 }
 
 pseudo_msg_t *
-pseudo_xattrdb_load(int fd, const char *path, const struct stat64 *buf) {
+pseudo_xattrdb_load(int fd, const char *path, const PSEUDO_STATBUF *buf) {
 	int rc = -1, retryrc = -1;
 	if (!path && fd < 0)
 		return NULL;
@@ -1845,7 +1845,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 
 #ifdef PSEUDO_XATTRDB
 	if (buf) {
-		struct stat64 bufcopy = *buf;
+		PSEUDO_STATBUF bufcopy = *buf;
 		int do_save = 0;
 		/* maybe use xattr instead */
 		/* note: if we use xattr, logging won't work reliably
diff --git a/pseudo_client.h b/pseudo_client.h
index 716c441..ef959e6 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -10,16 +10,9 @@ extern pseudo_msg_t *pseudo_client_op(pseudo_op_t op, int access, int fd, int di
 extern int pseudo_client_ignore_path(const char *path);
 extern int pseudo_client_ignore_fd(int fd);
 extern void pseudo_client_linked_paths(const char *oldpath, const char *newpath);
-#if PSEUDO_STATBUF_64
-#define base_lstat real_lstat64
-#define base_fstat real_fstat64
-#define base_stat real_stat64
-#define base_fstatat(dirfd, path, buf, flags) real___fxstatat64(_STAT_VER, dirfd, path, buf, flags)
-#else
-#define base_lstat real_lstat
-#define base_fstat real_fstat
-#define base_stat real_stat
-#define base_fstatat(dirfd, path, buf, flags) real___fxstatat(_STAT_VER, dirfd, path, buf, flags)
+/* The port defines how pseudo stats files itself, on PSEUDO_STATBUF */
+#if !defined(base_lstat) || !defined(base_fstat) || !defined(base_stat) || !defined(base_fstatat)
+#error "pseudo: the port must define base_lstat, base_fstat, base_stat and base_fstatat"
 #endif
 extern void pseudo_antimagic(void);
 extern void pseudo_magic(void);
diff --git a/pseudo_util.c b/pseudo_util.c
index 9845bd2..25f8bc0 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1776,7 +1776,7 @@ pseudo_evlog_logfile(char *defname, int prefer_fd) {
 }
 
 void
-pseudo_stat32_from64(struct stat *buf32, const struct stat64 *buf) {
+pseudo_stat32_from64(struct stat *buf32, const PSEUDO_STATBUF *buf) {
 	buf32->st_dev = buf->st_dev;
 	buf32->st_ino = buf->st_ino;
 	buf32->st_mode = buf->st_mode;
@@ -1793,7 +1793,7 @@ pseudo_stat32_from64(struct stat *buf32, const struct stat64 *buf) {
 }
 
 void
-pseudo_stat64_from32(struct stat64 *buf64, const struct stat *buf) {
+pseudo_stat64_from32(PSEUDO_STATBUF *buf64, const struct stat *buf) {
 	buf64->st_dev = buf->st_dev;
 	buf64->st_ino = buf->st_ino;
 	buf64->st_mode = buf->st_mode;
-- 
1.8.3.1

