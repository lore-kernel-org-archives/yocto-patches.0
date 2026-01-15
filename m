Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5261DD47CAA
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.762.1768520624110854572
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjk2408772;
	Thu, 15 Jan 2026 17:43:42 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 15/20] ports/linux: Add additional EFAULTS for Linux functions
Date: Thu, 15 Jan 2026 17:43:31 -0600
Message-Id: <1768520616-7289-16-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2987

Note, other functions claim to return EFAULT when the path element is NULL,
however glibc has these parameters tagged as non-null which optimizes out
any sort of NULL test by default.  Due to this only items that don't error
were included.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/linux/openat2/wrapfuncs.in |  2 +-
 ports/linux/wrapfuncs.in         | 22 +++++++++++-----------
 ports/linux/xattr/wrapfuncs.in   | 16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapfuncs.in
index 96ae8a7..419813f 100644
--- a/ports/linux/openat2/wrapfuncs.in
+++ b/ports/linux/openat2/wrapfuncs.in
@@ -1 +1 @@
-int openat2(int dirfd, const char *path, struct open_how *how, size_t size);
+int openat2(int dirfd, const char *path, struct open_how *how, size_t size); /* efault=path */
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 234a13c..7a2e9f0 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -1,17 +1,17 @@
 int open(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 char *get_current_dir_name(void);
-int __xstat(int ver, const char *path, struct stat *buf);
-int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW */
+int __xstat(int ver, const char *path, struct stat *buf); /* efault=path */
+int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW, efault=path */
 int __fxstat(int ver, int fd, struct stat *buf);
 int lchmod(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
 int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW */
-int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags);
+int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags); /* efault=path */
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
-int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
-int __xmknodat(int ver, int dirfd, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
+int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW, efault=path */
+int __xmknodat(int ver, int dirfd, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW, efault=path */
 int fcntl(int fd, int cmd, ...{struct flock *lock});  /* noignore_path=1 */
 int fcntl64(int fd, int cmd, ...{struct flock *lock});  /* noignore_path=1 */
 # just so we know the inums of symlinks
@@ -24,15 +24,15 @@ int creat64(const char *path, mode_t mode);
 int stat(const char *path, struct stat *buf); /* real_func=pseudo_stat */
 int lstat(const char *path, struct stat *buf); /* real_func=pseudo_lstat, flags=AT_SYMLINK_NOFOLLOW */
 int fstat(int fd, struct stat *buf); /* real_func=pseudo_fstat */
-int fstatat(int dirfd, const char *path, struct stat *buf, int flags);
+int fstatat(int dirfd, const char *path, struct stat *buf, int flags); /* efault=path */
 int stat64(const char *path, struct stat64 *buf); /* real_func=pseudo_stat64 */
 int lstat64(const char *path, struct stat64 *buf); /* real_func=pseudo_lstat64, flags=AT_SYMLINK_NOFOLLOW */
 int fstat64(int fd, struct stat64 *buf); /* real_func=pseudo_fstat64 */
-int fstatat64(int dirfd, const char *path, struct stat64 *buf, int flags);
-int __xstat64(int ver, const char *path, struct stat64 *buf);
-int __lxstat64(int ver, const char *path, struct stat64 *buf); /* flags=AT_SYMLINK_NOFOLLOW */
+int fstatat64(int dirfd, const char *path, struct stat64 *buf, int flags); /* efault=path */
+int __xstat64(int ver, const char *path, struct stat64 *buf); /* efault=path */
+int __lxstat64(int ver, const char *path, struct stat64 *buf); /* flags=AT_SYMLINK_NOFOLLOW, efault=path */
 int __fxstat64(int ver, int fd, struct stat64 *buf);
-int __fxstatat64(int ver, int dirfd, const char *path, struct stat64 *buf, int flags);
+int __fxstatat64(int ver, int dirfd, const char *path, struct stat64 *buf, int flags); /* efault=path */
 FILE *fopen64(const char *path, const char *mode); /* noignore_path=1 */
 int nftw64(const char *path, int (*fn)(const char *, const struct stat64 *, int, struct FTW *), int nopenfd, int flag); /* noignore_path=1 */
 FILE *freopen64(const char *path, const char *mode, FILE *stream);  /* noignore_path=1 */
@@ -61,7 +61,7 @@ int getpwent_r(struct passwd *pwbuf, char *buf, size_t buflen, struct passwd **p
 int getgrent_r(struct group *gbuf, char *buf, size_t buflen, struct group **gbufp);
 int capset(cap_user_header_t hdrp, const cap_user_data_t datap); /* real_func=pseudo_capset */
 long syscall(long nr, ...); /* hand_wrapped=1 */
-int renameat2(int olddirfd, const char *oldpath, int newdirfd, const char *newpath, unsigned int flags); /* flags=AT_SYMLINK_NOFOLLOW */
+int renameat2(int olddirfd, const char *oldpath, int newdirfd, const char *newpath, unsigned int flags); /* flags=AT_SYMLINK_NOFOLLOW, efault=oldpath|newpath */
 int prctl(int option, ...); /* hand_wrapped=1 */
 int close_range(unsigned int lowfd, unsigned int maxfd, int flags);
 void closefrom(int fd);
diff --git a/ports/linux/xattr/wrapfuncs.in b/ports/linux/xattr/wrapfuncs.in
index 09eba23..e8045b9 100644
--- a/ports/linux/xattr/wrapfuncs.in
+++ b/ports/linux/xattr/wrapfuncs.in
@@ -1,12 +1,12 @@
-ssize_t getxattr(const char *path, const char *name, void *value, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+ssize_t getxattr(const char *path, const char *name, void *value, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
+ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
 ssize_t fgetxattr(int filedes, const char *name, void *value, size_t size); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int setxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int lsetxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+int setxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
+int lsetxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
 int fsetxattr(int filedes, const char *name, const void *value, size_t size, int xflags); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t listxattr(const char *path, char *list, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t llistxattr(const char *path, char *list, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+ssize_t listxattr(const char *path, char *list, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
+ssize_t llistxattr(const char *path, char *list, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
 ssize_t flistxattr(int filedes, char *list, size_t size); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int removexattr(const char *path, const char *name); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int lremovexattr(const char *path, const char *name); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+int removexattr(const char *path, const char *name); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
+int lremovexattr(const char *path, const char *name); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", efault=path */
 int fremovexattr(int filedes, const char *name); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-- 
2.43.0


