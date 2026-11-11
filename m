Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1737.1794358338118949606
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 16:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCHGtW_u_Nq5xsGAA--.24092S3;
	Wed, 11 Nov 2026 08:50:08 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWppu_Nq6Q4zAA--.3584S2;
	Wed, 11 Nov 2026 08:48:41 +0800 (CST)
Message-ID: <295dd652-4ddc-4783-aaeb-6ef0be150d8d@cetc.com.cn>
Date: Wed, 11 Nov 2026 08:51:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH V2 1/2] pseudo_client: resolve
 /proc/<pid>/fd/<n> to the descriptor
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org,
 chen_q07@163.com
References: <20261103013028.3295799-1-chenqi_hycx@cetc.com.cn>
 <0b977592-3cbf-494b-82e9-0659ab1408a0@kernel.crashing.org>
 <cbeb1b10-725a-464a-af1d-a70020950eca@cetc.com.cn>
 <c7bbe9c5-57fc-494a-8107-d2526125b8f8@kernel.crashing.org>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <c7bbe9c5-57fc-494a-8107-d2526125b8f8@kernel.crashing.org>
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADneWppu_Nq6Q4zAA--.3584S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYICmrzHZcEEQAAsA
X-CM-DELIVERINFO: =?B?rnU/gqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOIjgpGi0GuTdhhpJJ2ykM9O3RWrSELxTu3E32mAxk+yVTdo38O4aQQp2GyauusxwFhlG
	scTb9GDTeIckc5MZkrWsn2KwgnRMDjx4DXSctx9yTeU9Zu80VuFN3D81DiyKyw==
X-Coremail-Antispam: 1Uk129KBj9fXoWfur1rur4rGr18ur4kKrW8KrX_yoW8KF4Uuo
	W8Kr1fJr4rXr1UWr1UJ3yDJrya93W8GrnrJryUGr9rJF10vr17A3yxAryUt3yUGr18Gr1U
	AryUJry0yFWjqw1rl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5xqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6wUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
	v_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8y5l5UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 00:52:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5259
Content-Type: text/plain; charset="utf-8"; format="flowed"


On 11/10/26 22:47, Mark Hatle wrote:
>
>
> On 11/10/26 3:16 AM, Chen Qi wrote:
>> Hi Mark,
>>
>> Thanks a lot for reviewing this! I was quite surprised by the bugs you
>> found.
>> I went through the commits one by one and I think they do fix problems
>> of my original patch.
>>
>> I also tested the master-next branch and I can confirm that things work
>> for me.
>
> Wonderful.  I'll go through the patches and will probably squash at 
> least some of them together.  I need to evaluate the set again now 
> that it my morning and make sure squashing really makes sense here.
>
>> I have a question on the TOCTOU section of the README.security:
>>   From my understanding, pseudo uses an inode based database, so path
>> based TOCTOU issues should not exist in the first place? Because if that
>> happens, inode mismatch error will be reported.
>
> My understanding (which may be wrong), is that selinux and other 
> security tools will often use /proc/pid/fd/descriptor in order to get 
> a single fd that refers to a file or component.  Then all subsequent 
> actions happen against the one fd making sure that a external actor 
> can't manipulate the file via a race condition.
>
> Introducing pseudo into the mix, we now have a series of stat, 
> emulation (processing db calls), and then open in order to perform the 
> same action.  So we are introducing a potential race window (for 
> secure applications) where a malicious actor could now change the file 
> between the stat and the open.  While this is all theoretical, in a 
> running system it very much would be an attack vector.  (This BTW also 
> appears to be the actual cause of the two parallel rename and symlink 
> failures in the tests.  Which I'm working on a fix for. However even 
> with the fix, it still wouldn't be a guarenty but simply less likely 
> to cause a problem.)
>
> Basically it's a complex problem, and I wanted to make sure it was 
> clearly documented for people that pseudo is not intended to be used 
> in a secure run-time environment, but instead it's part of a build 
> system tooling to emulate certain behavior.  Due to the nature of the 
> emulation, it will likely never be as secure as a properly implemented 
> operating system, container environment, etc.  Things we just can't do!
>
> --Mark
>
Thanks for the detailed explanation. I think you're right.

Regards,
Qi

>
>> Regards,
>> Qi
>>
>> On 11/10/26 10:56, Mark Hatle wrote:
>>> I believe I have found some bugs in this set.  I worked through it and
>>> I THINK I have them fixed.  I did not squash them into your commit, as
>>> I'm not completely sure I understand the full workflow you are using.
>>>
>>> Can you please review the following commits.  If you agree they fix
>>> issues in yoru commit, I'll squash them into a single commit. See:
>>>
>>> https://git.yoctoproject.org/pseudo/log/?h=master-next
>>>
>>>
>>> Specifically the commits:
>>>
>>>
>>> 89592a8f6c378526fdfab40396f61c97fce68d68 pseudo_client.h: remove
>>> dangling pseudo_client_fdpath declaration
>>> 65f48296f01ab949f0dab72e27cfda3f6ae2b45c pseudo_client: don't rewrite
>>> /proc/self/fd/<n> within a chroot
>>> 90789d335c990cfa37f34aa357f0fbed7133fbc6 pseudo_client: validate the
>>> descriptor for /proc/self/fd/<n>/<path>
>>> 914512e431dc07611c09bc9a1aefa9199463bd62 pseudo_client: only rewrite
>>> /proc/<pid>/fd/<n> for this process
>>> 5e4ea38a0daeabe1e05a604c2e5c3cb29570363f pseudo_client: don't use the
>>> rewritten path after freeing it in base_path()
>>> 21a9576df43f63ac82777166e801813ef88f8b3b pseudo_client: resolve
>>> /proc/<pid>/fd/<n> to the descriptor
>>>
>>> (the list is from newest to oldest, so git log format)
>>>
>>> The first and last commits are the ones submitted.  The ones in the
>>> middle are my fixes to issues found during review and testing.
>>>
>>> The set in master-next also contains other changes as well as two
>>> additional test cases based on your changes:
>>>
>>> c8770dc60339af270c8eb582d244600116889473 test-chroot-proc-dev: Add
>>> /proc and /dev within a chroot test
>>> 96338ee7f2b4118cd0477d7e77a5cf2df05ad5d4 test-proc-fd: Add a stale
>>> directory descriptor case
>>>
>>> as well as a README file that I figured was necessary.  The LLM based
>>> review pointed out that tools use the /proc interfaces to ensure a
>>> reference without a race window to the fd.  However using pseudo does
>>> not allow for this ability. The solution to this is we're documenting
>>> it as a design decision and that users should not believe that pseudo
>>> can be used in secure workflows.
>>>
>>>
>>> Any concerns, with the above (or anything in the master-next) please
>>> let me know!  Thank you for the submissions!  Sorry it took me so long
>>> to review it.
>>>
>>> --Mark
>>>
>>> On 11/2/26 7:30 PM, Chen Qi wrote:
>>>> From: Chen Qi <chenqi_hycx@cetc.com.cn>
>>>>
>>>> Paths such as /proc/self/fd/<n> and /dev/fd/<n> denote the open file:
>>>> the
>>>> kernel resolves them to the descriptor, so an O_PATH|O_NOFOLLOW
>>>> descriptor
>>>> on a symlink addresses the symlink itself.
>>>>
>>>> Path canonicalization expands them with readlink(2) and follows the
>>>> result, which changes that meaning.  For a descriptor on a symlink an
>>>> xattr set through it lands on the link target instead of the link,
>>>> and for
>>>> a dangling symlink the call fails with ENOENT.  Once expanded, the
>>>> path no
>>>> longer looks like something pseudo tracks either, so the operation is
>>>> passed straight through to the real syscall.
>>>>
>>>> libselinux 3.11 labels the rootfs through such descriptors, so 
>>>> setfiles
>>>> could not label any symlink and do_image fell back to a first boot
>>>> relabel:
>>>>
>>>>     setfiles: Could not set context for .../etc/mtab:  No such file or
>>>> directory
>>>>     setfiles: Could not set context for
>>>> .../etc/systemd/system/default.target:  Operation not permitted
>>>>
>>>> Rewrite the reference to the path pseudo recorded for the descriptor,
>>>> which keeps the operation under pseudo's control.  The descriptor 
>>>> itself
>>>> identifies the inode, so the final component is followed only when
>>>> following it is what reproduces that inode, i.e. for a descriptor
>>>> obtained
>>>> through a symlink.  When the caller passes AT_SYMLINK_NOFOLLOW the
>>>> reference itself is what is being asked about (readlink, lstat,
>>>> l*xattr),
>>>> so it is left alone for the kernel to resolve.
>>>>
>>>> Adds test/test-proc-fd.sh covering both descriptor flavours.
>>>>
>>>> Assisted-by: Codewhale:deepseek-v4-flash
>>>> Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
>>>> ---
>>>>    pseudo_client.c      | 110 +++++++++++++++++++++++++++
>>>>    pseudo_client.h      |   2 +
>>>>    pseudo_util.c        |   2 +
>>>>    pseudo_wrappers.c    |   2 +
>>>>    test/test-proc-fd.c  | 174 
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>    test/test-proc-fd.sh |  17 +++++
>>>>    6 files changed, 307 insertions(+)
>>>>    create mode 100644 test/test-proc-fd.c
>>>>    create mode 100755 test/test-proc-fd.sh
>>>>
>>>> diff --git a/pseudo_client.c b/pseudo_client.c
>>>> index 302ef21..c8247e8 100644
>>>> --- a/pseudo_client.c
>>>> +++ b/pseudo_client.c
>>>> @@ -1451,12 +1451,112 @@ pseudo_client_shutdown(int wait_on_socket) {
>>>>        return 0;
>>>>    }
>>>>    +/* /proc/self/fd/<n>, /proc/<pid>/fd/<n> and /dev/fd/<n> denote
>>>> the open file,
>>>> + * not the path the magic link prints.  Canonicalization resolves
>>>> symlinks with
>>>> + * readlink(2), which changes the meaning of such a path: the kernel
>>>> resolves it
>>>> + * to the descriptor, so an O_PATH|O_NOFOLLOW descriptor on a
>>>> symlink addresses
>>>> + * the symlink itself, whereas the expansion yields the link target
>>>> and then
>>>> + * follows it.  That labels the wrong inode, or fails when the
>>>> target does not
>>>> + * resolve.
>>>> + *
>>>> + * Rewrite the reference to the path pseudo recorded for the
>>>> descriptor, which
>>>> + * also puts the operation under pseudo's control instead of passing
>>>> it through.
>>>> + * The descriptor itself identifies the inode, so the final
>>>> component is only
>>>> + * followed when following it is what reproduces that inode, i.e. 
>>>> for a
>>>> + * descriptor obtained through a symlink.  Returns NULL to leave the
>>>> path alone.
>>>> + */
>>>> +static char *
>>>> +rewrite_proc_fd_ref(const char *path, int *leave_last) {
>>>> +    const char *p;
>>>> +    const char *digits;
>>>> +    const char *recpath;
>>>> +    char *out;
>>>> +    PSEUDO_STATBUF fbuf, pbuf;
>>>> +    int fd = 0;
>>>> +
>>>> +    if (!path || path[0] != '/')
>>>> +        return NULL;
>>>> +
>>>> +    if (!strncmp(path, "/dev/fd/", 8)) {
>>>> +        p = path + 8;
>>>> +    } else if (!strncmp(path, "/proc/", 6)) {
>>>> +        p = path + 6;
>>>> +        if (!strncmp(p, "self/fd/", 8)) {
>>>> +            p += 8;
>>>> +        } else if (!strncmp(p, "thread-self/fd/", 15)) {
>>>> +            p += 15;
>>>> +        } else {
>>>> +            const char *q = p;
>>>> +
>>>> +            while (*q >= '0' && *q <= '9')
>>>> +                ++q;
>>>> +            if (q == p || strncmp(q, "/fd/", 4))
>>>> +                return NULL;
>>>> +            p = q + 4;
>>>> +        }
>>>> +    } else {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    digits = p;
>>>> +    while (*p >= '0' && *p <= '9') {
>>>> +        if (fd > (0x7fffffff - 9) / 10)
>>>> +            return NULL;
>>>> +        fd = fd * 10 + (*p - '0');
>>>> +        ++p;
>>>> +    }
>>>> +    if (p == digits || (*p != '\0' && *p != '/'))
>>>> +        return NULL;
>>>> +
>>>> +    recpath = fd_path(fd);
>>>> +    if (!recpath || recpath[0] != '/')
>>>> +        return NULL;
>>>> +
>>>> +    /* Within a chroot the recorded path carries the chroot prefix,
>>>> while
>>>> +     * base_path() adds that prefix to absolute paths. Strip it, or
>>>> give up
>>>> +     * if the descriptor is not inside the chroot.
>>>> +     */
>>>> +    if (pseudo_chroot_len) {
>>>> +        if (strncmp(recpath, pseudo_chroot, pseudo_chroot_len) ||
>>>> +            (recpath[pseudo_chroot_len] != '\0' &&
>>>> recpath[pseudo_chroot_len] != '/'))
>>>> +            return NULL;
>>>> +        recpath += pseudo_chroot_len;
>>>> +        if (*recpath == '\0')
>>>> +            recpath = "/";
>>>> +    }
>>>> +
>>>> +    if (*p != '\0') {
>>>> +        size_t len = strlen(recpath) + strlen(p) + 1;
>>>> +
>>>> +        out = malloc(len);
>>>> +        if (!out)
>>>> +            return NULL;
>>>> +        snprintf(out, len, "%s%s", recpath, p);
>>>> +        return out;
>>>> +    }
>>>> +
>>>> +    if (!pseudo_real_fstat || !pseudo_real_lstat)
>>>> +        return NULL;
>>>> +    if (pseudo_real_fstat(fd, &fbuf) == -1)
>>>> +        return NULL;
>>>> +    if (pseudo_real_lstat(recpath, &pbuf) == 0 &&
>>>> +        pbuf.st_dev == fbuf.st_dev && pbuf.st_ino == fbuf.st_ino) {
>>>> +        *leave_last = 1;
>>>> +    } else if (pseudo_real_stat == NULL || pseudo_real_stat(recpath,
>>>> &pbuf) == -1 ||
>>>> +           pbuf.st_dev != fbuf.st_dev || pbuf.st_ino != 
>>>> fbuf.st_ino) {
>>>> +        /* The recorded path no longer describes this descriptor. */
>>>> +        return NULL;
>>>> +    }
>>>> +    return strdup(recpath);
>>>> +}
>>>> +
>>>>    static char *
>>>>    base_path(int dirfd, const char *path, int leave_last) {
>>>>        char *basepath = 0;
>>>>        size_t baselen = 0;
>>>>        size_t minlen = 0;
>>>>        char *newpath;
>>>> +    char *rewritten;
>>>>          if (!path)
>>>>            return NULL;
>>>> @@ -1501,7 +1601,17 @@ base_path(int dirfd, const char *path, int
>>>> leave_last) {
>>>>            minlen = pseudo_chroot_len;
>>>>        }
>>>>    +    /* Only when the caller follows the final component. With
>>>> +     * AT_SYMLINK_NOFOLLOW the reference itself is what the caller 
>>>> asks
>>>> +     * about (readlink, lstat, l*xattr), so it must be left for the
>>>> kernel
>>>> +     * to resolve.
>>>> +     */
>>>> +    rewritten = leave_last ? NULL : rewrite_proc_fd_ref(path,
>>>> &leave_last);
>>>> +    if (rewritten)
>>>> +        path = rewritten;
>>>> +
>>>>        newpath = pseudo_fix_path(basepath, path, minlen, baselen,
>>>> NULL, leave_last);
>>>> +    free(rewritten);
>>>>        pseudo_debug(PDBGF_PATH, "base_path[%s]: %s</>%s => %s\n",
>>>>            leave_last ? "nofollow" : "follow",
>>>>            basepath ? basepath : "<nil>",
>>>> diff --git a/pseudo_client.h b/pseudo_client.h
>>>> index 9b9f86a..b3f9f49 100644
>>>> --- a/pseudo_client.h
>>>> +++ b/pseudo_client.h
>>>> @@ -51,6 +51,8 @@ extern FILE *pseudo_grp;
>>>>      /* pseudo_wrappers will try to initialize these */
>>>>    extern int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF
>>>> *buf);
>>>> +extern int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf);
>>>> +extern int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF 
>>>> *buf);
>>>>    extern int (*pseudo_real_fork)(void);
>>>>    extern int (*pseudo_real_execv)(const char *, char * const *);
>>>>    diff --git a/pseudo_util.c b/pseudo_util.c
>>>> index 6e7c465..12718a5 100644
>>>> --- a/pseudo_util.c
>>>> +++ b/pseudo_util.c
>>>> @@ -99,6 +99,8 @@ static int pseudo_util_initted = -1;  /* Not yet
>>>> run */
>>>>      /* bypass wrapper logic on path computations */
>>>>    int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *buf) =
>>>> NULL;
>>>> +int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf) = NULL;
>>>> +int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF *buf) = 
>>>> NULL;
>>>>    /* bash workaround */
>>>>    int (*pseudo_real_unsetenv)(const char *) = unsetenv;
>>>>    char * (*pseudo_real_getenv)(const char *) = getenv;
>>>> diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
>>>> index 16a451a..d073b1e 100644
>>>> --- a/pseudo_wrappers.c
>>>> +++ b/pseudo_wrappers.c
>>>> @@ -174,6 +174,8 @@ pseudo_init_wrappers(void) {
>>>>        pseudo_real_fsetxattr = real_fsetxattr;
>>>>    #endif
>>>>        pseudo_real_lstat = base_lstat;
>>>> +    pseudo_real_fstat = base_fstat;
>>>> +    pseudo_real_stat = base_stat;
>>>>        /* and these are used so the client's server spawn can bypass
>>>>         * wrappers.
>>>>         */
>>>> diff --git a/test/test-proc-fd.c b/test/test-proc-fd.c
>>>> new file mode 100644
>>>> index 0000000..9550809
>>>> --- /dev/null
>>>> +++ b/test/test-proc-fd.c
>>>> @@ -0,0 +1,174 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: LGPL-2.1-only
>>>> + *
>>>> + * Check that xattr operations on /proc/self/fd/<n> address the file
>>>> the
>>>> + * descriptor refers to, and not the path the magic link prints.
>>>> + *
>>>> + * A descriptor opened with O_PATH|O_NOFOLLOW on a symlink denotes 
>>>> the
>>>> + * symlink itself, so a context set through it must land on the link
>>>> and
>>>> + * leave the target alone.  A descriptor opened by following a 
>>>> symlink
>>>> + * denotes the target, so the context must land there instead.
>>>> + *
>>>> + * Exit status: 0 all checks passed, 1 a check failed, 255 skipped
>>>> because
>>>> + * the platform has no xattr support.
>>>> + */
>>>> +#define _GNU_SOURCE
>>>> +#include <errno.h>
>>>> +#include <fcntl.h>
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <string.h>
>>>> +#include <unistd.h>
>>>> +#include <sys/stat.h>
>>>> +#include <sys/types.h>
>>>> +#include <sys/xattr.h>
>>>> +
>>>> +#define CTX "security.selinux"
>>>> +
>>>> +static int failures;
>>>> +
>>>> +static void
>>>> +fail(const char *what, const char *detail)
>>>> +{
>>>> +    printf("  FAIL  %-52s %s\n", what, detail);
>>>> +    ++failures;
>>>> +}
>>>> +
>>>> +static void
>>>> +pass(const char *what)
>>>> +{
>>>> +    printf("  PASS  %s\n", what);
>>>> +}
>>>> +
>>>> +/* Read the context of path itself, without following a final 
>>>> symlink.
>>>> + * Returns NULL when there is none.
>>>> + */
>>>> +static const char *
>>>> +get_ctx(const char *path, char *buf, size_t buflen)
>>>> +{
>>>> +    ssize_t n = lgetxattr(path, CTX, buf, buflen - 1);
>>>> +
>>>> +    if (n < 0)
>>>> +        return NULL;
>>>> +    buf[n] = '\0';
>>>> +    return buf;
>>>> +}
>>>> +
>>>> +static void
>>>> +expect_ctx(const char *what, const char *path, const char *want)
>>>> +{
>>>> +    char buf[256];
>>>> +    const char *got = get_ctx(path, buf, sizeof buf);
>>>> +
>>>> +    if (!want) {
>>>> +        if (got)
>>>> +            fail(what, got);
>>>> +        else
>>>> +            pass(what);
>>>> +        return;
>>>> +    }
>>>> +    if (got && strcmp(got, want) == 0)
>>>> +        pass(what);
>>>> +    else
>>>> +        fail(what, got ? got : "<no context>");
>>>> +}
>>>> +
>>>> +/* Set the context through the descriptor, the same way libselinux
>>>> does when
>>>> + * it pins a file: path-based call, no extra flags.
>>>> + */
>>>> +static int
>>>> +set_via_fd(int fd, const char *value)
>>>> +{
>>>> +    char path[64];
>>>> +
>>>> +    snprintf(path, sizeof path, "/proc/self/fd/%d", fd);
>>>> +    return setxattr(path, CTX, value, strlen(value) + 1, 0);
>>>> +}
>>>> +
>>>> +int
>>>> +main(int argc, char **argv)
>>>> +{
>>>> +    const char *dir = argc > 1 ? argv[1] : ".";
>>>> +    char path[512];
>>>> +    int fd;
>>>> +
>>>> +    snprintf(path, sizeof path, "%s/file", dir);
>>>> +    if (close(open(path, O_CREAT | O_WRONLY, 0644)) == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    snprintf(path, sizeof path, "%s/link", dir);
>>>> +    if (symlink("file", path) == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    snprintf(path, sizeof path, "%s/dangling", dir);
>>>> +    if (symlink("/nonexistent/xyz", path) == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    /* 1. O_PATH|O_NOFOLLOW on a symlink: label the link, not its
>>>> target. */
>>>> +    snprintf(path, sizeof path, "%s/link", dir);
>>>> +    fd = open(path, O_PATH | O_NOFOLLOW);
>>>> +    if (fd == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    if (set_via_fd(fd, "onlink") == -1 && errno == ENOTSUP) {
>>>> +        printf("  SKIP  xattr support unavailable\n");
>>>> +        return 255;
>>>> +    }
>>>> +    close(fd);
>>>> +
>>>> +    snprintf(path, sizeof path, "%s/link", dir);
>>>> +    expect_ctx("context landed on the symlink", path, "onlink");
>>>> +    snprintf(path, sizeof path, "%s/file", dir);
>>>> +    expect_ctx("context did not land on the target", path, NULL);
>>>> +
>>>> +    /* 2. A dangling symlink must not make the operation fail. */
>>>> +    snprintf(path, sizeof path, "%s/dangling", dir);
>>>> +    fd = open(path, O_PATH | O_NOFOLLOW);
>>>> +    if (fd == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    if (set_via_fd(fd, "ondangling") == -1) {
>>>> +        fail("context set on a dangling symlink", strerror(errno));
>>>> +    } else {
>>>> +        pass("context set on a dangling symlink");
>>>> +    }
>>>> +    close(fd);
>>>> +    expect_ctx("context landed on the dangling link", path,
>>>> "ondangling");
>>>> +
>>>> +    /* 3. A descriptor obtained by following a symlink denotes the
>>>> target. */
>>>> +    snprintf(path, sizeof path, "%s/target", dir);
>>>> +    if (close(open(path, O_CREAT | O_WRONLY, 0644)) == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    snprintf(path, sizeof path, "%s/link2", dir);
>>>> +    if (symlink("target", path) == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    fd = open(path, O_RDONLY);
>>>> +    if (fd == -1) {
>>>> +        perror(path);
>>>> +        return 1;
>>>> +    }
>>>> +    if (set_via_fd(fd, "ontarget") == -1) {
>>>> +        fail("context set through a followed descriptor",
>>>> strerror(errno));
>>>> +    } else {
>>>> +        pass("context set through a followed descriptor");
>>>> +    }
>>>> +    close(fd);
>>>> +
>>>> +    snprintf(path, sizeof path, "%s/target", dir);
>>>> +    expect_ctx("context landed on the target", path, "ontarget");
>>>> +    snprintf(path, sizeof path, "%s/link2", dir);
>>>> +    expect_ctx("context did not land on the link", path, NULL);
>>>> +
>>>> +    printf("%s: %d check(s) failed\n", failures ? "FAIL" : "OK",
>>>> failures);
>>>> +    return failures ? 1 : 0;
>>>> +}
>>>> diff --git a/test/test-proc-fd.sh b/test/test-proc-fd.sh
>>>> new file mode 100755
>>>> index 0000000..4a7f8ba
>>>> --- /dev/null
>>>> +++ b/test/test-proc-fd.sh
>>>> @@ -0,0 +1,17 @@
>>>> +#!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: LGPL-2.1-only
>>>> +#
>>>> +# Regressions guarded here: an xattr call on /proc/self/fd/<n> must
>>>> address
>>>> +# the file the descriptor refers to.  Path canonicalization used to
>>>> expand the
>>>> +# magic link with readlink(2) and then follow the result, so a
>>>> context set
>>>> +# through an O_PATH|O_NOFOLLOW descriptor on a symlink landed on the
>>>> link
>>>> +# target, and a dangling link made the call fail with ENOENT.
>>>> libselinux 3.11
>>>> +# labels the rootfs that way, which left every symlink in the image
>>>> unlabelled.
>>>> +#
>>>> +# The temporary tree has to live below $PWD so that pseudo tracks it.
>>>> +
>>>> +tmpdir="$(mktemp -d -p "$PWD" proc_fd_XXXXXX)"
>>>> +trap "rm -rf '$tmpdir'" EXIT TERM INT
>>>> +
>>>> +./test/test-proc-fd "$tmpdir"
>>>
>>>
>>>
>>
>>
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5257): 
> https://lists.yoctoproject.org/g/yocto-patches/message/5257
> Mute This Topic: https://lists.yoctoproject.org/mt/122070118/10573603
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: 
> https://lists.yoctoproject.org/g/yocto-patches/leave/15343253/10573603/1695603168/xyzzy 
> [chenqi_hycx@cetc.com.cn]
> -=-=-=-=-=-=-=-=-=-=-=-

