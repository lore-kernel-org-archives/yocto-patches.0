Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64815C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 20:52:37 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.6418.1742331151229936273
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Mar 2025 13:52:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 52IKpSmk028366;
	Tue, 18 Mar 2025 15:51:28 -0500
Received: from [192.168.2.109] ([192.168.2.109])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 52IKpS9r005447;
	Tue, 18 Mar 2025 15:51:28 -0500
Message-ID: <867744bb-3842-4310-b772-371a0c3d0c7d@kernel.crashing.org>
Date: Tue, 18 Mar 2025 15:51:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH 1/1] nftw: add wrapper
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Lander Van Loock <landervanloock@gmail.com>
References: <20250317113445.3855518-1-skandigraun@gmail.com>
 <20250317113445.3855518-2-skandigraun@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20250317113445.3855518-2-skandigraun@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 20:52:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1219

I think this is a good start.  However, I do have some questions/concerns below, 
inline.

On 3/17/25 6:34 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> Add a wrapper for nftw[1] call.
> 
> The call in brief: it accepts a path, which it walks. For every
> entries it finds, it calls a user-specified callback function, and
> passes some information about the entry to this callback.
> 
> The implementation saves the callback from the nftw call, and subtitutes
> it with its own "fake_callback". When the real nftw calls the fake_callback,
> it corrects the stat struct it received with information queried from pseudo.
> Afterwards it calls the original callback and passes the now corrected
> information to it.
> 
> Most of the ports/unix/nftw/pseudo_wrappers.c is generated, at least the
> top int nftw(...) function - just a copy-paste of the original.
> 
> [1]: https://linux.die.net/man/3/nftw
> 
> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
> Reviewed-by: Lander Van Loock <landervanloock@gmail.com>
> ---
>   ports/unix/guts/nftw.c            |  16 ----
>   ports/unix/nftw/guts/nftw.c       |  22 +++++
>   ports/unix/nftw/pseudo_wrappers.c | 122 +++++++++++++++++++++++++
>   ports/unix/nftw/wrapfuncs.in      |   1 +
>   ports/unix/subports               |   2 +
>   ports/unix/wrapfuncs.in           |   1 -
>   test/test-nftw.c                  | 144 ++++++++++++++++++++++++++++++
>   test/test-nftw.sh                 |  42 +++++++++
>   8 files changed, 333 insertions(+), 17 deletions(-)
>   delete mode 100644 ports/unix/guts/nftw.c
>   create mode 100644 ports/unix/nftw/guts/nftw.c
>   create mode 100644 ports/unix/nftw/pseudo_wrappers.c
>   create mode 100644 ports/unix/nftw/wrapfuncs.in
>   create mode 100644 test/test-nftw.c
>   create mode 100755 test/test-nftw.sh
> 
> diff --git a/ports/unix/guts/nftw.c b/ports/unix/guts/nftw.c
> deleted file mode 100644
> index dac3106..0000000
> --- a/ports/unix/guts/nftw.c
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/*
> - * Copyright (c) 2010 Wind River Systems; see
> - * guts/COPYRIGHT for information.
> - *
> - * SPDX-License-Identifier: LGPL-2.1-only
> - *
> - * static int
> - * wrap_nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag) {
> - *	int rc = -1;
> - */
> -
> -	rc = real_nftw(path, fn, nopenfd, flag);
> -
> -/*	return rc;
> - * }
> - */
> diff --git a/ports/unix/nftw/guts/nftw.c b/ports/unix/nftw/guts/nftw.c
> new file mode 100644
> index 0000000..df28546
> --- /dev/null
> +++ b/ports/unix/nftw/guts/nftw.c

The directory ports/unix/nftw should only be used if we're aware of unix(like) 
systems that do NOT have the nftw function on them.  This way building on those 
platforms we can exclude this directory.  This is what the syncfs function does.

I don't object to the moving of the file and directory, just making a point that 
if nftw is considered to be 'everywhere' and standard enough to not be going 
away then moving directories is probably not desired.

> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (c) 2010 Wind River Systems; see
> + * guts/COPYRIGHT for information.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * static int
> + * wrap_nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag) {
> + *	int rc = -1;
> + */
> +
> +    // Save the flags and the original callback. Forward the details to
> +    // real_nftw, but instead of the original callback, use our callback.
> +    // Our callback will fix the stat, and call the original callback with
> +    // the correct details.
> +    saved_flags = flag;
> +    real_callback = fn;
> +    rc = real_nftw(path, wrap_nftw_callback, nopenfd, flag);
> +
> +/*	return rc;
> + * }
> + */
> diff --git a/ports/unix/nftw/pseudo_wrappers.c b/ports/unix/nftw/pseudo_wrappers.c
> new file mode 100644
> index 0000000..ffedf4f
> --- /dev/null
> +++ b/ports/unix/nftw/pseudo_wrappers.c
> @@ -0,0 +1,122 @@
> +int
> +nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag) {
> +        sigset_t saved;
> +
> +        int rc = -1;
> +        PROFILE_START;
> +
> +
> +
> +        if (!pseudo_check_wrappers() || !real_nftw) {
> +                /* rc was initialized to the "failure" value */
> +                pseudo_enosys("nftw");
> +                PROFILE_DONE;
> +                return rc;
> +        }
> +
> +
> +
> +        if (pseudo_disabled) {
> +                rc = (*real_nftw)(path, fn, nopenfd, flag);
> +
> +                PROFILE_DONE;
> +                return rc;
> +        }
> +
> +        pseudo_debug(PDBGF_WRAPPER, "wrapper called: nftw\n");
> +        pseudo_sigblock(&saved);
> +        pseudo_debug(PDBGF_WRAPPER | PDBGF_VERBOSE, "nftw - signals blocked, obtaining lock\n");
> +        if (pseudo_getlock()) {
> +                errno = EBUSY;
> +                sigprocmask(SIG_SETMASK, &saved, NULL);
> +                pseudo_debug(PDBGF_WRAPPER, "nftw failed to get lock, giving EBUSY.\n");
> +                PROFILE_DONE;
> +                return -1;
> +        }
> +
> +        int save_errno;
> +        if (antimagic > 0) {
> +                /* call the real syscall */
> +                pseudo_debug(PDBGF_SYSCALL, "nftw calling real syscall.\n");
> +                rc = (*real_nftw)(path, fn, nopenfd, flag);
> +        } else {
> +                path = pseudo_root_path(__func__, __LINE__, AT_FDCWD, path, 0);
> +                if (pseudo_client_ignore_path(path)) {
> +                        /* call the real syscall */
> +                        pseudo_debug(PDBGF_SYSCALL, "nftw ignored path, calling real syscall.\n");
> +                        rc = (*real_nftw)(path, fn, nopenfd, flag);
> +                } else {
> +                        /* exec*() use this to restore the sig mask */
> +                        pseudo_saved_sigmask = saved;
> +                        rc = wrap_nftw(path, fn, nopenfd, flag);
> +                }
> +        }
> +
> +        save_errno = errno;
> +        pseudo_droplock();
> +        sigprocmask(SIG_SETMASK, &saved, NULL);
> +        pseudo_debug(PDBGF_WRAPPER | PDBGF_VERBOSE, "nftw - yielded lock, restored signals\n");
> +#if 0
> +/* This can cause hangs on some recentish systems which use locale
> + * stuff for strerror...
> + */
> +        pseudo_debug(PDBGF_WRAPPER, "wrapper completed: nftw returns %d (errno: %s)\n", rc, strerror(save_errno));
> +#endif

The if 0 above...

I see that this appears to be copied out of ports/unix/pseudo_wrappers.c and the 
popen.  The comment in the ChangeLog:

2011-04-21:
         * (seebs) don't use strerror in wrappers, because it can
           lead to malloc deadlocks if part of setting up a malloc
           operation falls into strerror which uses locale... Curse
           you, Fedora 13.  You and your perfectly reasonable and
           standards-conforming behavior which happened to inconvenience
           me.

It looks like there are two existing places in the code with the same comment. 
So duplicating it here makes sense for completion.

> +        pseudo_debug(PDBGF_WRAPPER, "wrapper completed: nftw returns %d (errno: %d)\n", rc, save_errno);
> +        errno = save_errno;
> +        PROFILE_DONE;
> +        return rc;
> +}
> +
> +#ifdef __clang__
> +static __declspec(thread) int (*real_callback)(const char *, const struct stat *, int, struct FTW *);
> +static __declspec(thread) int saved_flags;
> +#else
> +static __thread int (*real_callback)(const char *, const struct stat *, int, struct FTW *);
> +static __thread int saved_flags;
> +#endif

I don't think we have any other clang or gcc specific thread settings in the 
code.  I know generally in pseudo we are required to be thread safe in the 
functions themselves, since we don't control the execution environment.

Where I am going with this, I'm wondering if we should be using them anywhere else.

> +
> +static int wrap_nftw_callback(const char* fpath, const struct stat *sb, int typeflag, struct FTW *ftwbuf) {
> +    char *orig_cwd;
> +    char *target_dir;
> +
> +    // This flag is supposed to be handled by real_nftw, however
> +    // apparently working directory change isn't persisted within
> +    // pseudo, when it is initiated outside of it.
> +    // Just save the current working dir, switch to the directory
> +    // of the file, and call the callback before switching back to
> +    // the original directory.
> +    if ((saved_flags & FTW_CHDIR) && strcmp(fpath, "/") != 0) {
> +       orig_cwd = getcwd(NULL, 0);
> +       target_dir = malloc(ftwbuf->base + 1);
> +       memset(target_dir, 0, ftwbuf->base + 1);
> +       strncpy(target_dir, fpath, ftwbuf->base);
> +       chdir(target_dir);
> +    }

Above is the first place I do have a concern with this review.  On a more 
traditional unix system, the current working directory is shared on a process, 
so if one thread changes it they are all affected.  From some quick research 
Linux and MacOS support per-thread directory changes, but effectively this is OS 
defined behavior.  So I'm worried that the above is fragile, and even Linux 
behavior could change in the future.

I've not looked into what glibc is doing here, but it might be useful to try to 
document/mimic the behavior of glibc when the ntfw function and callback are 
used.  (It's possible you've already done which is what lead to this code path, 
but I'd like a reference pointed to glibc or similar code in case this fails in 
the future.)

> +
> +    // This is the main point of this call. Instead of the stat that
> +    // came from real_nftw, use the stat returned by pseudo.
> +    // If the target can't be stat'd (DNR), then just forward whatever
> +    // is inside - no information can be retrieved of it anyway.
> +    if (typeflag != FTW_DNR) {
> +        (saved_flags & FTW_PHYS) ? lstat(fpath, sb) : stat(fpath, sb);
> +    }
> +
> +    int ret = real_callback(fpath, sb, typeflag, ftwbuf);
> +
> +    if (saved_flags & FTW_CHDIR) {
> +        chdir(orig_cwd);
> +        free(target_dir);
> +    }
> +
> +    return ret;
> +}
> +
> +static int
> +wrap_nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag) {
> +    int rc = -1;
> +
> +#include "guts/nftw.c"
> +
> +    return rc;
> +}
> diff --git a/ports/unix/nftw/wrapfuncs.in b/ports/unix/nftw/wrapfuncs.in
> new file mode 100644
> index 0000000..435e261
> --- /dev/null
> +++ b/ports/unix/nftw/wrapfuncs.in
> @@ -0,0 +1 @@
> +int nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag); /* hand_wrapped=1 */


Looking at the man page for nftw I see both 'ftw' and 'nftw' are similar 
functions, except the valyue of the 'ftwbuf' in the nftw case.

Looking at the current ftw implementation I see:


  * static int
  * wrap_ftw(const char *path, int (*fn)(const char *, const struct stat *, 
int), int nopenfd) {
  *      int rc = -1;
  */

         rc = real_ftw(path, fn, nopenfd);

/*      return rc;

I'm wondering if real_ftw also needs to be wrapped, and if we can use the above 
nftw function to implement this functionality.  Otherwise, I think we probably 
have a similar latest 'ftw' failure.

Similar to this, the Linux ports also define nftw64 (and ftw64).  In both cases, 
we'll need to duplicate the same functionality again.  So I think we're missing 
some wrappers here.  We may very well be able to use a single wrapper for all 4 
cases, but I'd like you to look into this, and as part of the test cases below, 
test that all 4 functions are working properly.

Note: ftw64/nftw64 are Linux specific AFAIK, and may only exist in certain 
cases.  Looking at the header on an older system I see:

#ifdef __USE_XOPEN_EXTENDED
typedef int (*__nftw_func_t) (const char *__filename,
                               const struct stat *__status, int __flag,
                               struct FTW *__info);
# ifdef __USE_LARGEFILE64
typedef int (*__nftw64_func_t) (const char *__filename,
                                 const struct stat64 *__status,
                                 int __flag, struct FTW *__info);
# endif
#endif


All in all the patches look good with the few items I mentioned above, specifically:

* Concern about the chdir (due to threading)
* Missing ftw/ftw64 and nftw64 wrappers for potentially the same issue

--Mark

> diff --git a/ports/unix/subports b/ports/unix/subports
> index bd5a2f6..27a77ba 100755
> --- a/ports/unix/subports
> +++ b/ports/unix/subports
> @@ -12,3 +12,5 @@ if ${CC} -o dummy dummy.c > /dev/null 2>&1; then
>   	echo "unix/syncfs"
>   fi
>   rm -f dummy.c dummy
> +
> +echo "unix/nftw"
> diff --git a/ports/unix/wrapfuncs.in b/ports/unix/wrapfuncs.in
> index 7724fc7..79e3303 100644
> --- a/ports/unix/wrapfuncs.in
> +++ b/ports/unix/wrapfuncs.in
> @@ -14,7 +14,6 @@ int faccessat(int dirfd, const char *path, int mode, int flags);
>   int faccessat2(int dirfd, const char *path, int mode, int flags);
>   FTS *fts_open(char * const *path_argv, int options, int (*compar)(const FTSENT **, const FTSENT **)); /* inode64=1 */
>   int ftw(const char *path, int (*fn)(const char *, const struct stat *, int), int nopenfd);
> -int nftw(const char *path, int (*fn)(const char *, const struct stat *, int, struct FTW *), int nopenfd, int flag);
>   int glob(const char *pattern, int flags, int (*errfunc)(const char *, int), glob_t *pglob);
>   int lutimes(const char *path, const struct timeval *tv); /* flags=AT_SYMLINK_NOFOLLOW */
>   char *mkdtemp(char *template);
> diff --git a/test/test-nftw.c b/test/test-nftw.c
> new file mode 100644
> index 0000000..4b27294
> --- /dev/null
> +++ b/test/test-nftw.c
> @@ -0,0 +1,144 @@
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <ftw.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +#define LAST_VAL 999
> +#define LAST_PATH "LAST_SENTINEL"
> +
> +#define TEST_WITH_PSEUDO 1
> +#define TEST_WITHOUT_PSEUDO 0
> +
> +static int current_idx = 0;
> +static int* current_responses;
> +static char** expected_fpaths;
> +
> +static int pseudo_active;
> +
> +static int expected_gid;
> +static int expected_uid;
> +
> +static int callback(const char* fpath, const struct stat *sb, int typeflag, struct FTW *ftwbuf){
> +    int ret = current_responses[current_idx];
> +//    printf("path: %s, ret: %d\n", fpath, ret);
> +
> +    if (ret == LAST_VAL){
> +        printf("Unexpected callback, it should have stopped already! fpath: %s\n", fpath);
> +        return FTW_STOP;
> +    }
> +
> +    char* expected_fpath_ending = expected_fpaths[current_idx];
> +
> +    if (strcmp(expected_fpath_ending, LAST_PATH) == 0){
> +        printf("Unexpected fpath received: %s\n", fpath);
> +        return FTW_STOP;
> +    }
> +
> +    const char* actual_fpath_ending = fpath + strlen(fpath) - strlen(expected_fpath_ending);
> +
> +    if (strcmp(actual_fpath_ending, expected_fpath_ending) != 0){
> +        printf("Incorrect fpath received. Expected: %s, actual: %s\n", expected_fpath_ending, actual_fpath_ending);
> +        return FTW_STOP;
> +    }
> +
> +    if (pseudo_active) {
> +        if (sb->st_gid != 0 || sb->st_uid != 0) {
> +            printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, 0, sb->st_uid, 0);
> +            return FTW_STOP;
> +        }
> +    } else if (sb->st_gid != expected_gid || sb->st_uid != expected_uid) {
> +        printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, expected_gid, sb->st_uid, expected_uid);
> +        return FTW_STOP;
> +    }
> +
> +    ++current_idx;
> +    return ret;
> +}
> +
> +static int run_test(int* responses, char** fpaths, int expected_retval, int with_pseudo, int flags) {
> +    int ret;
> +    current_responses = responses;
> +    expected_fpaths = fpaths;
> +    pseudo_active = with_pseudo;
> +
> +    ret = nftw("./walking", callback, 10, flags);
> +    current_responses = NULL;
> +    expected_fpaths = NULL;
> +
> +    if (ret != expected_retval){
> +        printf("Incorrect return value. Expected: %d, actual: %d\n", expected_retval, ret);
> +        return 1;
> +    }
> +
> +    if (responses[current_idx] != LAST_VAL){
> +        printf("Not all expected paths were walked!\n");
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static int test_skip_siblings_file_depth_walking(int with_pseudo){
> +    int responses[] = {FTW_SKIP_SIBLINGS, FTW_CONTINUE, FTW_SKIP_SIBLINGS, FTW_CONTINUE,
> +                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, LAST_VAL};
> +    char* fpaths[] = {"walking/a1/b2/file5",
> +                      "walking/a1/b2",
> +                      "walking/a1/b1/c1/file",
> +                      "walking/a1/b1/c1",
> +                      "walking/a1/b1",
> +                      "walking/a1/b3",
> +                      "walking/a1",
> +                      "walking",
> +                      LAST_PATH};
> +    int expected_retval = 0;
> +    int flags = FTW_ACTIONRETVAL | FTW_DEPTH;
> +
> +    return run_test(responses, fpaths, expected_retval, with_pseudo, flags);
> +}
> +
> +/*
> + * Every time a folder entry is sent to the callback, respond with FTW_SKIP_SUBTREE.
> + * This should skip that particular folder completely, and continue processing
> + * with its siblings (or parent, if there are no siblings).
> + * Return value is expected to be 0, default walking order.
> + */
> +static int test_skip_subtree_on_folder(int with_pseudo){
> +    int responses[] = {FTW_CONTINUE, FTW_CONTINUE, FTW_SKIP_SUBTREE, FTW_SKIP_SUBTREE,
> +                       FTW_SKIP_SUBTREE, LAST_VAL};
> +    char* fpaths[] = {"walking",
> +                      "walking/a1",
> +                      "walking/a1/b2",
> +                      "walking/a1/b1",
> +                      "walking/a1/b3",
> +                      LAST_PATH};
> +    int expected_retval = 0;
> +    int flags = FTW_ACTIONRETVAL;
> +
> +    return run_test(responses, fpaths, expected_retval, with_pseudo, flags);
> +}
> +
> +int main(int argc, char* argv[])
> +{
> +    if (argc < 2) {
> +        printf("Need a test name as argument\n");
> +        return 1;
> +    }
> +
> +    if (strcmp(argv[1], "skip_subtree_pseudo") == 0) {
> +        return test_skip_subtree_on_folder(TEST_WITH_PSEUDO);
> +    } else if (strcmp(argv[1], "skip_subtree_no_pseudo") == 0) {
> +        expected_gid = atoi(argv[2]);
> +        expected_uid = atoi(argv[3]);
> +        return test_skip_subtree_on_folder(TEST_WITHOUT_PSEUDO);
> +    } else if (strcmp(argv[1], "skip_siblings_pseudo") == 0) {
> +        return test_skip_siblings_file_depth_walking(TEST_WITH_PSEUDO);
> +    } else if (strcmp(argv[1], "skip_siblings_no_pseudo") == 0) {
> +        expected_gid = atoi(argv[2]);
> +        expected_uid = atoi(argv[3]);
> +        return test_skip_siblings_file_depth_walking(TEST_WITHOUT_PSEUDO);
> +    } else {
> +        printf("Unknown test name\n");
> +        return 1;
> +    }
> +}
> diff --git a/test/test-nftw.sh b/test/test-nftw.sh
> new file mode 100755
> index 0000000..71654b9
> --- /dev/null
> +++ b/test/test-nftw.sh
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +#
> +# Test nftw call and its behavior modifying flags
> +# SPDX-License-Identifier: LGPL-2.1-only
> +#
> +
> +trap "rm -rf ./walking" 0
> +
> +check_retval_and_fail_if_needed(){
> +  if [ $1 -ne 0 ]; then
> +    echo $2
> +    exit 1
> +  fi
> +}
> +
> +
> +mkdir -p walking/a1/b1/c1
> +touch walking/a1/b1/c1/file
> +mkdir walking/a1/b2
> +mkdir walking/a1/b3
> +touch walking/a1/b1/c1/file2
> +touch walking/a1/b1/c1/file3
> +touch walking/a1/b2/file4
> +touch walking/a1/b2/file5
> +
> +./test/test-nftw skip_subtree_pseudo
> +check_retval_and_fail_if_needed $? "nftw subtree skipping with pseudo failed"
> +
> +./test/test-nftw skip_siblings_pseudo
> +check_retval_and_fail_if_needed $? "nftw sibling skipping with pseudo failed"
> +
> +export PSEUDO_DISABLED=1
> +
> +uid=`env -i id -u`
> +gid=`env -i id -g`
> +
> +./test/test-nftw skip_subtree_no_pseudo $gid $uid
> +check_retval_and_fail_if_needed $? "nftw subtree skipping without pseudo failed"
> +
> +./test/test-nftw skip_siblings_no_pseudo $gid $uid
> +check_retval_and_fail_if_needed $? "nftw sibling skipping without pseudo failed"
> +
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1208): https://lists.yoctoproject.org/g/yocto-patches/message/1208
> Mute This Topic: https://lists.yoctoproject.org/mt/111747235/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

