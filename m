Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2566.1794370864802514744
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lm2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:04 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 02/34] ports: hold the path lock in create and metadata wrappers
Date: Tue, 10 Nov 2026 22:20:30 -0600
Message-Id: <1794370862-30908-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5261
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Like rename() and unlink(), the wrappers that create a name, or that
look at a path and then change its metadata in the database, do so in
separate steps: the real operation on disk, then a request to the
server.  Another client renaming onto or removing the same name in
between leaves the database out of step with the filesystem, which the
server reports as an inode or path mismatch, and may abort a client.

Hold the path lock exclusively in the wrappers that create a name:
link, linkat, symlink, symlinkat, mkdir, mkdirat, mkfifo, mkfifoat,
mknod, mknodat, __xmknod, __xmknodat, bind, mkdtemp and the mkstemp
family.  None of these can block indefinitely.

Hold it shared in the wrappers that look at a path and then record or
query its metadata: chmod, lchmod, fchmodat, chown, lchown, fchownat,
fts_read, fts_children, and the path based xattr calls.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/wrapfuncs.in       | 16 +++++++--------
 ports/linux/xattr/wrapfuncs.in | 16 +++++++--------
 ports/unix/wrapfuncs.in        | 46 +++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 65f2d7a..a682383 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -5,17 +5,17 @@ char *get_current_dir_name(void);
 int __xstat(int ver, const char *path, struct stat *buf); /* path_lock=shared */
 int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=shared */
 int __fxstat(int ver, int fd, struct stat *buf);
-int lchmod(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
-int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW */
+int lchmod(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=shared */
+int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=shared */
 int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags); /* path_lock=shared */
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int open_tree(int dirfd, const char *path, unsigned int flags); /* preserve_paths=1, noignore_path=1 */
 int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct mount_attr *attr, size_t size); /* preserve_paths=1, noignore_path=1*/
-int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
-int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
-int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
-int __xmknodat(int ver, int dirfd, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
+int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod, path_lock=1 */
+int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat, path_lock=1 */
+int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int __xmknodat(int ver, int dirfd, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int fcntl(int fd, int cmd, ...{struct flock *lock});  /* noignore_path=1 */
 int fcntl64(int fd, int cmd, ...{struct flock *lock});  /* noignore_path=1 */
 # just so we know the inums of symlinks
@@ -44,8 +44,8 @@ int ftw64(const char *path, int (*fn)(const char *, const struct stat64 *, int),
 int glob64(const char *pattern, int flags, int (*errfunc)(const char *, int), glob64_t *pglob);
 int scandir64(const char *path, struct dirent64 ***namelist, int (*filter)(const struct dirent64 *), int (*compar)());
 int truncate64(const char *path, off64_t length);
-int mkostemp64(char *template, int oflags); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkstemp64(char *template); /* flags=AT_SYMLINK_NOFOLLOW */
+int mkostemp64(char *template, int oflags); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkstemp64(char *template); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int getgrouplist(const char *user, gid_t group, gid_t *groups, int *ngroups);
 int setgroups(size_t size, const gid_t *list);
 int setfsgid(gid_t fsgid);
diff --git a/ports/linux/xattr/wrapfuncs.in b/ports/linux/xattr/wrapfuncs.in
index 09eba23..89b1c68 100644
--- a/ports/linux/xattr/wrapfuncs.in
+++ b/ports/linux/xattr/wrapfuncs.in
@@ -1,12 +1,12 @@
-ssize_t getxattr(const char *path, const char *name, void *value, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+ssize_t getxattr(const char *path, const char *name, void *value, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
+ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
 ssize_t fgetxattr(int filedes, const char *name, void *value, size_t size); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int setxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int lsetxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+int setxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
+int lsetxattr(const char *path, const char *name, const void *value, size_t size, int xflags); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
 int fsetxattr(int filedes, const char *name, const void *value, size_t size, int xflags); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t listxattr(const char *path, char *list, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-ssize_t llistxattr(const char *path, char *list, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+ssize_t listxattr(const char *path, char *list, size_t size); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
+ssize_t llistxattr(const char *path, char *list, size_t size); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
 ssize_t flistxattr(int filedes, char *list, size_t size); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int removexattr(const char *path, const char *name); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
-int lremovexattr(const char *path, const char *name); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
+int removexattr(const char *path, const char *name); /* flags=0, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
+int lremovexattr(const char *path, const char *name); /* flags=AT_SYMLINK_NOFOLLOW, version="GLIBC_2.3", version-aarch64="GLIBC_2.17", path_lock=shared */
 int fremovexattr(int filedes, const char *name); /* version="GLIBC_2.3", version-aarch64="GLIBC_2.17" */
diff --git a/ports/unix/wrapfuncs.in b/ports/unix/wrapfuncs.in
index 5956742..5ffee83 100644
--- a/ports/unix/wrapfuncs.in
+++ b/ports/unix/wrapfuncs.in
@@ -4,7 +4,7 @@ char *getwd(char *buf);
 int close(int fd);  /* noignore_path=1 */
 int fchmod(int fd, mode_t mode);
 int fchown(int fd, uid_t owner, gid_t group);
-int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW */
+int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=shared */
 int dup2(int oldfd, int newfd); /* noignore_path=1 */
 int dup(int fd); /* noignore_path=1 */
 int chdir(const char *path); /* noignore_path=1 */
@@ -13,13 +13,13 @@ int access(const char *path, int mode);
 int faccessat(int dirfd, const char *path, int mode, int flags);
 int faccessat2(int dirfd, const char *path, int mode, int flags);
 FTS *fts_open(char * const *path_argv, int options, int (*compar)(const FTSENT **, const FTSENT **));
-FTSENT *fts_read(FTS *ftsp); /* noignore_path=1 */
-FTSENT *fts_children(FTS *ftsp, int options); /* noignore_path=1 */
+FTSENT *fts_read(FTS *ftsp); /* noignore_path=1, path_lock=shared */
+FTSENT *fts_children(FTS *ftsp, int options); /* noignore_path=1, path_lock=shared */
 int ftw(const char *path, int (*fn)(const char *, const struct stat *, int), int nopenfd);
 int nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag);
 int glob(const char *pattern, int flags, int (*errfunc)(const char *, int), glob_t *pglob);
 int lutimes(const char *path, const struct timeval *tv); /* flags=AT_SYMLINK_NOFOLLOW */
-char *mkdtemp(char *template);
+char *mkdtemp(char *template); /* path_lock=1 */
 char *mktemp(char *template);
 long pathconf(const char *path, int name);
 char *realpath(const char *name, char *resolved_name); /* version="GLIBC_2.3" */
@@ -37,27 +37,27 @@ int fclose(FILE *fp);  /* noignore_path=1 */
 FILE *freopen(const char *path, const char *mode, FILE *stream); /* noignore_path=1 */
 int chroot(const char *path); /* noignore_path=1 */
 int acct(const char *path);
-int chmod(const char *path, mode_t mode);
-int chown(const char *path, uid_t owner, gid_t group);
-int fchmodat(int dirfd, const char *path, mode_t mode, int flags);
-int fchownat(int dirfd, const char *path, uid_t owner, gid_t group, int flags);
-int link(const char *oldname, const char *newname); /* flags=AT_SYMLINK_NOFOLLOW */
-int linkat(int olddirfd, const char *oldname, int newdirfd, const char *newname, int flags);
-int mkdir(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkdirat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkfifo(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkfifoat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
-int mknod(const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW */
-int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkstemp(char *template); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkostemp(char *template, int oflags); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkstemps(char *template, int suffixlen); /* flags=AT_SYMLINK_NOFOLLOW */
-int mkostemps(char *template, int suffixlen, int oflags); /* flags=AT_SYMLINK_NOFOLLOW */
+int chmod(const char *path, mode_t mode); /* path_lock=shared */
+int chown(const char *path, uid_t owner, gid_t group); /* path_lock=shared */
+int fchmodat(int dirfd, const char *path, mode_t mode, int flags); /* path_lock=shared */
+int fchownat(int dirfd, const char *path, uid_t owner, gid_t group, int flags); /* path_lock=shared */
+int link(const char *oldname, const char *newname); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int linkat(int olddirfd, const char *oldname, int newdirfd, const char *newname, int flags); /* path_lock=1 */
+int mkdir(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkdirat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkfifo(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkfifoat(int dirfd, const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mknod(const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkstemp(char *template); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkostemp(char *template, int oflags); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkstemps(char *template, int suffixlen); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int mkostemps(char *template, int suffixlen, int oflags); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int rename(const char *oldpath, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int renameat(int olddirfd, const char *oldpath, int newdirfd, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int rmdir(const char *path); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
-int symlink(const char *oldname, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW */
-int symlinkat(const char *oldname, int dirfd, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW */
+int symlink(const char *oldname, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
+int symlinkat(const char *oldname, int dirfd, const char *newpath); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int unlink(const char *path); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 int unlinkat(int dirfd, const char *path, int rflags); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
 # primarily for use with chroot()
@@ -74,4 +74,4 @@ void sync(void); /* async_skip= */
 int sync_file_range(int fd, off64_t offset, off64_t nbytes, unsigned int flags); /* async_skip=0 */
 int msync(void *addr, size_t length, int flags); /* async_skip=0 */
 mode_t umask(mode_t mask);
-int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
+int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen); /* path_lock=1 */
-- 
1.8.3.1

