Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.106.1794851985186726058
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 09:59:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AGHxhaq3500074
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 11:59:44 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AGHxhKm002036
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 11:59:43 -0600
Message-ID: <1a28c1eb-1aca-4c2c-a3c6-e77072a35a33@kernel.crashing.org>
Date: Mon, 16 Nov 2026 11:59:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH RFC] ports/linux: Wrap
 name_to_handle_at() and open_by_handle_at()
To: yocto-patches@lists.yoctoproject.org
References: <20261112175234.523998-1-mark.hatle@amd.com>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20261112175234.523998-1-mark.hatle@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 17:59:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5411

I have decided to push this work to master.  It's going to require re-world 
testing to know if this causes issues or not, we'll resolve any issues through 
the normal bug/pull request process.

--Mark

On 11/12/26 11:52 AM, Mark Hatle via yocto-patches wrote:
> open_by_handle_at() was not wrapped, so pseudo never learned the path of
> the descriptor it returns, and *at() calls relative to it failed.  It
> also needs CAP_DAC_READ_SEARCH, so under pseudo it failed with EPERM
> anyway.
> 
> Always emulate it: check the arguments as the kernel does, then search
> below mount_fd with nftw() for a file that name_to_handle_at(), which
> needs no privilege, encodes to the same handle, and open it.  A symlink
> is only opened with O_PATH, and a handle that isn't found gives ESTALE,
> as with the kernel.  The descriptor's path is then recorded.
> 
> name_to_handle_at() is wrapped to resolve its path like other wrappers,
> so it works in a chroot.  It only follows a final symlink with
> AT_SYMLINK_FOLLOW.  Both are also handled when called through syscall().
> 
> [YOCTO #16380]
> 
> Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> AI-Generated: Uses GitHub Copilot
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>
> ---
> This is sent as an RFC for review.  I don't understand this workflow
> enough to know what the LLM helped me implement is actualy correct or
> not.  I do know it matches the behavior and man pages as I understand
> them, but I don't know of any real-world test cases I can use to verify
> the behavior.
> 
> Any comments would be appreciated!
> 
>   ports/linux/guts/name_to_handle_at.c |  32 +++++
>   ports/linux/guts/open_by_handle_at.c |  59 +++++++++
>   ports/linux/pseudo_wrappers.c        | 145 ++++++++++++++++++++++
>   ports/linux/wrapfuncs.in             |   2 +
>   test/test-name_to_handle_at.c        | 107 ++++++++++++++++
>   test/test-name_to_handle_at.sh       |  21 ++++
>   test/test-open_by_handle_at.c        | 174 +++++++++++++++++++++++++++
>   test/test-open_by_handle_at.sh       |  22 ++++
>   8 files changed, 562 insertions(+)
>   create mode 100644 ports/linux/guts/name_to_handle_at.c
>   create mode 100644 ports/linux/guts/open_by_handle_at.c
>   create mode 100644 test/test-name_to_handle_at.c
>   create mode 100755 test/test-name_to_handle_at.sh
>   create mode 100644 test/test-open_by_handle_at.c
>   create mode 100755 test/test-open_by_handle_at.sh
> 
> diff --git a/ports/linux/guts/name_to_handle_at.c b/ports/linux/guts/name_to_handle_at.c
> new file mode 100644
> index 0000000..1d600ff
> --- /dev/null
> +++ b/ports/linux/guts/name_to_handle_at.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2026 Yocto Project
> + * guts/COPYRIGHT for information.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * int name_to_handle_at(int dirfd, const char *name, struct file_handle *handle, int *mount_id, int flags)
> + *	int rc = -1;
> + */
> +
> +	const char *path;
> +
> +	/* Encoding a handle needs no privilege, so the real call does it;
> +	 * pseudo only has to resolve the path (chroot, dirfd).  Real handles
> +	 * also let open_by_handle_at() find the file by encoding candidates
> +	 * and comparing.
> +	 *
> +	 * name isn't canonicalized by the wrapper, as name_to_handle_at()
> +	 * only follows a final symlink with AT_SYMLINK_FOLLOW, and rejects
> +	 * the AT_SYMLINK_NOFOLLOW the generated code adds for an empty path.
> +	 */
> +	if (name && !*name && (flags & AT_EMPTY_PATH)) {
> +		rc = real_name_to_handle_at(dirfd, name, handle, mount_id, flags);
> +	} else {
> +		path = pseudo_root_path(__func__, __LINE__, dirfd, name,
> +			(flags & AT_SYMLINK_FOLLOW) ? 0 : AT_SYMLINK_NOFOLLOW);
> +		rc = real_name_to_handle_at(AT_FDCWD, path, handle, mount_id, flags);
> +	}
> +
> +/*	return rc;
> + * }
> + */
> diff --git a/ports/linux/guts/open_by_handle_at.c b/ports/linux/guts/open_by_handle_at.c
> new file mode 100644
> index 0000000..08b77fa
> --- /dev/null
> +++ b/ports/linux/guts/open_by_handle_at.c
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (c) 2026 Yocto Project
> + * guts/COPYRIGHT for information.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags)
> + *	int rc = -1;
> + */
> +
> +	PSEUDO_STATBUF buf;
> +	char procpath[32];
> +	char *path;
> +	ssize_t len;
> +	int save_errno;
> +
> +	/* always emulated, as decoding a handle needs privilege */
> +	rc = pseudo_open_by_handle(mount_fd, handle, flags);
> +	if (rc == -1)
> +		return rc;
> +	save_errno = errno;
> +
> +	/* A handle names an inode, not a path.  Record the path the kernel
> +	 * reports for the descriptor, if it still names the same file, so
> +	 * that calls using the descriptor, including *at() calls relative
> +	 * to it, can be resolved.
> +	 */
> +	snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", rc);
> +	path = malloc(pseudo_path_max());
> +	if (path) {
> +		len = real_readlink(procpath, path, pseudo_path_max() - 1);
> +		if (len > 0 && path[0] == '/') {
> +			path[len] = '\0';
> +			if (!pseudo_client_path_matches_fd(path, rc, 1)) {
> +				free(path);
> +				path = NULL;
> +			}
> +		} else {
> +			free(path);
> +			path = NULL;
> +		}
> +	}
> +
> +	if (path) {
> +		if (base_fstat(rc, &buf) != -1)
> +			pseudo_client_op(OP_OPEN, 0, rc, -1, path, &buf);
> +		else
> +			pseudo_client_op(OP_OPEN, 0, rc, -1, path, 0);
> +		free(path);
> +	} else {
> +		pseudo_debug(PDBGF_FILE, "open_by_handle_at: no path for fd %d\n", rc);
> +		/* drop any path left over from a close pseudo didn't see */
> +		pseudo_client_op(OP_CLOSE, 0, rc, -1, 0, 0);
> +	}
> +	errno = save_errno;
> +
> +/*	return rc;
> + * }
> + */
> diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
> index e8a2780..a573abb 100644
> --- a/ports/linux/pseudo_wrappers.c
> +++ b/ports/linux/pseudo_wrappers.c
> @@ -54,6 +54,121 @@ int pseudo_capset(cap_user_header_t hdrp, const cap_user_data_t datap) {
>   	return 0;
>   }
>   
> +/* open_by_handle_at() emulation.
> + *
> + * The kernel only decodes a file handle for a caller with
> + * CAP_DAC_READ_SEARCH, which a pseudo "root" doesn't have, so search
> + * below mount_fd for the file instead.  name_to_handle_at() needs no
> + * privilege, so a file matches if it encodes to the same handle.
> + */
> +/* include/linux/exportfs.h */
> +#define PSEUDO_FILEID_USER_FLAGS 0xffff0000U
> +#define PSEUDO_FILEID_IS_CONNECTABLE 0x10000
> +#define PSEUDO_FILEID_IS_DIR 0x20000
> +#define PSEUDO_FILEID_VALID_USER_FLAGS (PSEUDO_FILEID_IS_CONNECTABLE | PSEUDO_FILEID_IS_DIR)
> +#ifndef AT_HANDLE_CONNECTABLE
> +#define AT_HANDLE_CONNECTABLE 0x002
> +#endif
> +
> +/* nftw() has no context argument */
> +static struct {
> +	const struct file_handle *handle;
> +	int encode_flags;
> +	char *path;
> +	PSEUDO_STATBUF st;
> +} pseudo_handle_search;
> +
> +static int
> +pseudo_handle_search_visit(const char *path, const struct stat64 *sb, int typeflag, struct FTW *ftw) {
> +	union {
> +		struct file_handle fh;
> +		char space[sizeof(struct file_handle) + MAX_HANDLE_SZ];
> +	} h;
> +	int mount_id;
> +
> +	(void) ftw;
> +	if (typeflag == FTW_NS)
> +		return 0;
> +	h.fh.handle_bytes = MAX_HANDLE_SZ;
> +	if (real_name_to_handle_at(AT_FDCWD, path, &h.fh, &mount_id, pseudo_handle_search.encode_flags) == -1 ||
> +	    h.fh.handle_type != pseudo_handle_search.handle->handle_type ||
> +	    h.fh.handle_bytes != pseudo_handle_search.handle->handle_bytes ||
> +	    memcmp(h.fh.f_handle, pseudo_handle_search.handle->f_handle, h.fh.handle_bytes))
> +		return 0;
> +	pseudo_handle_search.path = strdup(path);
> +	pseudo_handle_search.st = *sb;
> +	return 1;
> +}
> +
> +/* Check the arguments as the kernel does (fs/fhandle.c), then find and
> + * open the file.
> + */
> +static int
> +pseudo_open_by_handle(int mount_fd, const struct file_handle *handle, int flags) {
> +	char *root = NULL;
> +	char procpath[32];
> +	PSEUDO_STATBUF st;
> +	ssize_t len;
> +	int fd = -1;
> +
> +	if (!handle) {
> +		errno = EFAULT;
> +		return -1;
> +	}
> +	if (handle->handle_bytes == 0 || handle->handle_bytes > MAX_HANDLE_SZ ||
> +	    handle->handle_type < 0 ||
> +	    ((unsigned int) handle->handle_type & PSEUDO_FILEID_USER_FLAGS & ~PSEUDO_FILEID_VALID_USER_FLAGS)) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +	if (mount_fd < 0 && mount_fd != AT_FDCWD) {
> +		errno = EBADF;
> +		return -1;
> +	}
> +	if (base_fstatat(mount_fd, "", &st, AT_EMPTY_PATH) == -1)
> +		return -1;
> +
> +	root = malloc(pseudo_path_max());
> +	if (!root)
> +		return -1;
> +	if (mount_fd == AT_FDCWD) {
> +		if (!real_getcwd(root, pseudo_path_max()))
> +			goto out;
> +	} else {
> +		snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", mount_fd);
> +		len = real_readlink(procpath, root, pseudo_path_max() - 1);
> +		if (len <= 0 || root[0] != '/') {
> +			errno = ESTALE;
> +			goto out;
> +		}
> +		root[len] = '\0';
> +	}
> +
> +	memset(&pseudo_handle_search, 0, sizeof(pseudo_handle_search));
> +	pseudo_handle_search.handle = handle;
> +	pseudo_handle_search.encode_flags = (handle->handle_type & PSEUDO_FILEID_IS_CONNECTABLE) ? AT_HANDLE_CONNECTABLE : 0;
> +	real_nftw64(root, pseudo_handle_search_visit, 16, FTW_PHYS | FTW_MOUNT);
> +	if (!pseudo_handle_search.path) {
> +		errno = ESTALE;
> +		goto out;
> +	}
> +
> +	/* as the kernel, a symlink is only opened with O_PATH */
> +	fd = real_openat(AT_FDCWD, pseudo_handle_search.path, (flags & ~(O_CREAT | O_EXCL)) | O_NOFOLLOW);
> +	/* the path could have been replaced since it was checked */
> +	if (fd != -1 && (base_fstat(fd, &st) == -1 ||
> +	    st.st_dev != pseudo_handle_search.st.st_dev || st.st_ino != pseudo_handle_search.st.st_ino)) {
> +		real_close(fd);
> +		fd = -1;
> +		errno = ESTALE;
> +	}
> +	free(pseudo_handle_search.path);
> +	pseudo_handle_search.path = NULL;
> +out:
> +	free(root);
> +	return fd;
> +}
> +
>   long
>   syscall(long number, ...) {
>   	long rc = -1;
> @@ -175,6 +290,36 @@ syscall(long number, ...) {
>   #error SYS_open_tree_attr not defined
>   #endif
>   
> +#ifdef SYS_name_to_handle_at
> +	if (number == SYS_name_to_handle_at) {
> +		pseudo_debug(PDBGF_SYSCALL, "syscall, faking name_to_handle_at.\n");
> +		va_start(ap, number);
> +		int dirfd = va_arg(ap, int);
> +		const char *name = va_arg(ap, const char *);
> +		struct file_handle *handle = va_arg(ap, struct file_handle *);
> +		int *mount_id = va_arg(ap, int *);
> +		int flags = va_arg(ap, int);
> +
> +		return wrap_name_to_handle_at(dirfd, name, handle, mount_id, flags);
> +	}
> +#else
> +#error SYS_name_to_handle_at not defined
> +#endif
> +
> +#ifdef SYS_open_by_handle_at
> +	if (number == SYS_open_by_handle_at) {
> +		pseudo_debug(PDBGF_SYSCALL, "syscall, faking open_by_handle_at.\n");
> +		va_start(ap, number);
> +		int mount_fd = va_arg(ap, int);
> +		struct file_handle *handle = va_arg(ap, struct file_handle *);
> +		int flags = va_arg(ap, int);
> +
> +		return wrap_open_by_handle_at(mount_fd, handle, flags);
> +	}
> +#else
> +#error SYS_open_by_handle_at not defined
> +#endif
> +
>   #ifdef SYS_renameat2
>           /* Call out wrapper, expanding the variable arguments first */
>   	if (number == SYS_renameat2) {
> diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
> index a682383..1874b60 100644
> --- a/ports/linux/wrapfuncs.in
> +++ b/ports/linux/wrapfuncs.in
> @@ -12,6 +12,8 @@ int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=(
>   int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
>   int open_tree(int dirfd, const char *path, unsigned int flags); /* preserve_paths=1, noignore_path=1 */
>   int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct mount_attr *attr, size_t size); /* preserve_paths=1, noignore_path=1*/
> +int name_to_handle_at(int dirfd, const char *name, struct file_handle *handle, int *mount_id, int flags);
> +int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags);
>   int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod, path_lock=1 */
>   int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat, path_lock=1 */
>   int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW, path_lock=1 */
> diff --git a/test/test-name_to_handle_at.c b/test/test-name_to_handle_at.c
> new file mode 100644
> index 0000000..0f9e2e7
> --- /dev/null
> +++ b/test/test-name_to_handle_at.c
> @@ -0,0 +1,107 @@
> +/*
> + * Test that name_to_handle_at() resolves paths the way pseudo does,
> + * including inside a chroot, and only follows a final symlink with
> + * AT_SYMLINK_FOLLOW.
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * Returns 77 if the filesystem doesn't support file handles.
> + */
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +static struct file_handle *
> +get_handle(int dirfd, const char *name, int flags, int use_syscall) {
> +	struct file_handle *fh = malloc(sizeof(*fh) + MAX_HANDLE_SZ);
> +	int mount_id, rc;
> +
> +	if (!fh)
> +		return NULL;
> +	fh->handle_bytes = MAX_HANDLE_SZ;
> +	if (use_syscall)
> +		rc = syscall(SYS_name_to_handle_at, dirfd, name, fh, &mount_id, flags);
> +	else
> +		rc = name_to_handle_at(dirfd, name, fh, &mount_id, flags);
> +	if (rc == -1) {
> +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
> +			printf("name_to_handle_at not supported: %s\n", strerror(errno));
> +			exit(77);
> +		}
> +		printf("name_to_handle_at(%d, '%s', %#x): %s\n", dirfd, name, flags, strerror(errno));
> +		free(fh);
> +		return NULL;
> +	}
> +	return fh;
> +}
> +
> +static int
> +same(const struct file_handle *a, const struct file_handle *b) {
> +	return a && b && a->handle_bytes == b->handle_bytes &&
> +		a->handle_type == b->handle_type &&
> +		!memcmp(a->f_handle, b->f_handle, a->handle_bytes);
> +}
> +
> +int
> +main(int argc, char *argv[]) {
> +	struct file_handle *file, *link, *h;
> +	char path[4096];
> +	int fd, rc = 0;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage: %s <chrootdir>\n", argv[0]);
> +		return 2;
> +	}
> +
> +	snprintf(path, sizeof(path), "%s/file", argv[1]);
> +	file = get_handle(AT_FDCWD, path, 0, 0);
> +	snprintf(path, sizeof(path), "%s/link", argv[1]);
> +	link = get_handle(AT_FDCWD, path, 0, 0);
> +	if (!file || !link)
> +		return 1;
> +	if (same(file, link)) {
> +		printf("handle for a symlink matches its target\n");
> +		return 1;
> +	}
> +
> +	if (chroot(argv[1]) == -1 || chdir("/") == -1) {
> +		perror("chroot");
> +		return 1;
> +	}
> +
> +	if (!same(get_handle(AT_FDCWD, "/file", 0, 0), file)) {
> +		printf("/file inside the chroot has the wrong handle\n");
> +		rc = 1;
> +	}
> +	if (!same(get_handle(AT_FDCWD, "/link", 0, 0), link)) {
> +		printf("/link without AT_SYMLINK_FOLLOW has the wrong handle\n");
> +		rc = 1;
> +	}
> +	if (!same(get_handle(AT_FDCWD, "/link", AT_SYMLINK_FOLLOW, 0), file)) {
> +		printf("/link with AT_SYMLINK_FOLLOW has the wrong handle\n");
> +		rc = 1;
> +	}
> +	if (!same(get_handle(AT_FDCWD, "/file", 0, 1), file)) {
> +		printf("/file through syscall() has the wrong handle\n");
> +		rc = 1;
> +	}
> +
> +	fd = open("/file", O_RDONLY);
> +	if (fd == -1) {
> +		perror("open /file");
> +		return 1;
> +	}
> +	h = get_handle(fd, "", AT_EMPTY_PATH, 0);
> +	if (!same(h, file)) {
> +		printf("AT_EMPTY_PATH has the wrong handle\n");
> +		rc = 1;
> +	}
> +	close(fd);
> +
> +	return rc;
> +}
> diff --git a/test/test-name_to_handle_at.sh b/test/test-name_to_handle_at.sh
> new file mode 100755
> index 0000000..351b0cb
> --- /dev/null
> +++ b/test/test-name_to_handle_at.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +#
> +# Test name_to_handle_at() path resolution, including inside a chroot.
> +# SPDX-License-Identifier: LGPL-2.1-only
> +#
> +# rc 77 indicates the filesystem doesn't support file handles, so report
> +# skipped (255).
> +
> +dir=$(pwd)/name_to_handle_at_test
> +trap 'rm -rf "$dir"' 0
> +rm -rf "$dir"
> +mkdir -p "$dir"
> +touch "$dir/file"
> +ln -s file "$dir/link"
> +
> +./test/test-name_to_handle_at "$dir"
> +rc=$?
> +if [ "$rc" -eq 77 ]; then
> +	exit 255
> +fi
> +exit $rc
> diff --git a/test/test-open_by_handle_at.c b/test/test-open_by_handle_at.c
> new file mode 100644
> index 0000000..a05b9d7
> --- /dev/null
> +++ b/test/test-open_by_handle_at.c
> @@ -0,0 +1,174 @@
> +/*
> + * Test open_by_handle_at() under pseudo.  The kernel needs privilege to
> + * decode a file handle, so pseudo finds and opens the file itself.
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * Returns 77 if the filesystem doesn't support file handles.
> + */
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +static int failed;
> +
> +#define FAIL(...) do { printf(__VA_ARGS__); failed = 1; } while (0)
> +
> +static struct file_handle *
> +handle_for(const char *path, int flags) {
> +	struct file_handle *fh = malloc(sizeof(*fh) + MAX_HANDLE_SZ);
> +	int mount_id;
> +
> +	if (!fh)
> +		exit(1);
> +	fh->handle_bytes = MAX_HANDLE_SZ;
> +	if (name_to_handle_at(AT_FDCWD, path, fh, &mount_id, flags) == -1) {
> +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
> +			printf("name_to_handle_at not supported: %s\n", strerror(errno));
> +			exit(77);
> +		}
> +		printf("name_to_handle_at(%s): %s\n", path, strerror(errno));
> +		exit(1);
> +	}
> +	return fh;
> +}
> +
> +/* Make the handle in another process, so this one can't have
> + * remembered where it came from.
> + */
> +static struct file_handle *
> +handle_from_child(const char *path) {
> +	struct file_handle *fh = malloc(sizeof(*fh) + MAX_HANDLE_SZ);
> +	int pipefd[2], status;
> +	pid_t pid;
> +
> +	if (!fh || pipe(pipefd) == -1)
> +		exit(1);
> +	pid = fork();
> +	if (pid == -1)
> +		exit(1);
> +	if (pid == 0) {
> +		struct file_handle *child = handle_for(path, 0);
> +		ssize_t len = sizeof(*child) + child->handle_bytes;
> +		_exit(write(pipefd[1], child, len) == len ? 0 : 1);
> +	}
> +	close(pipefd[1]);
> +	if (read(pipefd[0], fh, sizeof(*fh) + MAX_HANDLE_SZ) < (ssize_t) sizeof(*fh))
> +		exit(1);
> +	close(pipefd[0]);
> +	if (waitpid(pid, &status, 0) == -1 || !WIFEXITED(status) || WEXITSTATUS(status))
> +		exit(WIFEXITED(status) ? WEXITSTATUS(status) : 1);
> +	return fh;
> +}
> +
> +static void
> +check_dirfd(const char *how, int dirfd) {
> +	struct stat st;
> +
> +	if (dirfd == -1) {
> +		FAIL("%s: open_by_handle_at: %s\n", how, strerror(errno));
> +		return;
> +	}
> +	if (fstatat(dirfd, "file", &st, 0) == -1)
> +		FAIL("%s: fstatat: %s\n", how, strerror(errno));
> +	else if (st.st_uid != 123 || st.st_gid != 456)
> +		FAIL("%s: file owned by %d:%d, expected 123:456\n",
> +			how, (int) st.st_uid, (int) st.st_gid);
> +	close(dirfd);
> +}
> +
> +int
> +main(int argc, char *argv[]) {
> +	struct file_handle *fh;
> +	char path[4096], buf[16];
> +	struct stat st;
> +	int mount_fd, fd;
> +	ssize_t len;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage: %s <dir>\n", argv[0]);
> +		return 2;
> +	}
> +	mount_fd = open(argv[1], O_RDONLY | O_DIRECTORY);
> +	if (mount_fd == -1) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	/* a directory handle, used for *at() calls */
> +	snprintf(path, sizeof(path), "%s/dir/file", argv[1]);
> +	if (chown(path, 123, 456) == -1) {
> +		perror("chown");
> +		return 1;
> +	}
> +	snprintf(path, sizeof(path), "%s/dir", argv[1]);
> +	fh = handle_for(path, 0);
> +	check_dirfd("function", open_by_handle_at(mount_fd, fh, O_RDONLY | O_DIRECTORY));
> +	check_dirfd("syscall", syscall(SYS_open_by_handle_at, mount_fd, fh, O_RDONLY | O_DIRECTORY));
> +	free(fh);
> +
> +	/* a file below mount_fd that this process never named */
> +	snprintf(path, sizeof(path), "%s/dir/sub/data", argv[1]);
> +	fh = handle_from_child(path);
> +	fd = open_by_handle_at(mount_fd, fh, O_RDONLY);
> +	if (fd == -1) {
> +		FAIL("data: open_by_handle_at: %s\n", strerror(errno));
> +	} else {
> +		len = read(fd, buf, sizeof(buf) - 1);
> +		buf[len > 0 ? len : 0] = '\0';
> +		if (strcmp(buf, "hello\n"))
> +			FAIL("data: read '%s'\n", buf);
> +		close(fd);
> +	}
> +	free(fh);
> +
> +	/* mount_fd itself */
> +	fh = handle_from_child(argv[1]);
> +	fd = open_by_handle_at(mount_fd, fh, O_RDONLY | O_DIRECTORY);
> +	if (fd == -1)
> +		FAIL("mount_fd: open_by_handle_at: %s\n", strerror(errno));
> +	else
> +		close(fd);
> +	free(fh);
> +
> +	/* a symlink only opens with O_PATH, as the link itself */
> +	snprintf(path, sizeof(path), "%s/dir/link", argv[1]);
> +	fh = handle_from_child(path);
> +	fd = open_by_handle_at(mount_fd, fh, O_RDONLY);
> +	if (fd != -1 || errno != ELOOP)
> +		FAIL("link: expected ELOOP, got %d (%s)\n", fd, strerror(errno));
> +	fd = open_by_handle_at(mount_fd, fh, O_PATH);
> +	if (fd == -1)
> +		FAIL("link: O_PATH: %s\n", strerror(errno));
> +	else if (fstat(fd, &st) == -1 || !S_ISLNK(st.st_mode))
> +		FAIL("link: O_PATH didn't open the symlink\n");
> +	if (fd != -1)
> +		close(fd);
> +	free(fh);
> +
> +	/* a deleted file */
> +	snprintf(path, sizeof(path), "%s/gone", argv[1]);
> +	fh = handle_from_child(path);
> +	unlink(path);
> +	fd = open_by_handle_at(mount_fd, fh, O_RDONLY);
> +	if (fd != -1 || errno != ESTALE)
> +		FAIL("gone: expected ESTALE, got %d (%s)\n", fd, strerror(errno));
> +	if (fd != -1)
> +		close(fd);
> +
> +	/* the kernel's own argument checks still apply */
> +	fh->handle_bytes = 0;
> +	fd = open_by_handle_at(mount_fd, fh, O_RDONLY);
> +	if (fd != -1 || errno != EINVAL)
> +		FAIL("empty handle: expected EINVAL, got %d (%s)\n", fd, strerror(errno));
> +	free(fh);
> +
> +	return failed;
> +}
> diff --git a/test/test-open_by_handle_at.sh b/test/test-open_by_handle_at.sh
> new file mode 100755
> index 0000000..ef4a9f7
> --- /dev/null
> +++ b/test/test-open_by_handle_at.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +#
> +# Test open_by_handle_at() under pseudo.
> +# SPDX-License-Identifier: LGPL-2.1-only
> +#
> +# rc 77 indicates the filesystem doesn't support file handles, so report
> +# skipped (255).
> +
> +dir=$(pwd)/open_by_handle_at_test
> +trap 'rm -rf "$dir"' 0
> +rm -rf "$dir"
> +mkdir -p "$dir/dir/sub"
> +touch "$dir/dir/file" "$dir/gone"
> +echo hello > "$dir/dir/sub/data"
> +ln -s file "$dir/dir/link"
> +
> +./test/test-open_by_handle_at "$dir"
> +rc=$?
> +if [ "$rc" -eq 77 ]; then
> +	exit 255
> +fi
> +exit $rc
