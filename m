Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD3C369DC
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 01:19:35 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.9811.1746148772522283346
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 18:19:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 5421HS3d029318;
	Thu, 1 May 2025 20:17:29 -0500
Received: from [192.168.2.37] ([192.168.2.37])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 5421HR7n031252;
	Thu, 1 May 2025 20:17:28 -0500
Message-ID: <74a087d4-076e-4caa-82a8-3bba4f5ef0e2@kernel.crashing.org>
Date: Thu, 1 May 2025 20:17:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: Re: [yocto-patches] [pseudo][PATCH v2 0/2] nftw, ftw: add wrappers
Reply-To: yocto-patches@lists.yoctoproject.org
To: yocto-patches@lists.yoctoproject.org, skandigraun@gmail.com
Cc: landervanloock@gmail.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>, fntoth@gmail.com
References: <20250407191414.2992785-1-skandigraun@gmail.com>
 <18342C3498EB800F.31078@lists.yoctoproject.org>
Content-Language: en-US
In-Reply-To: <18342C3498EB800F.31078@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 May 2025 01:19:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1475

[resend] my CC was incomplete and I want to make sure everyone interested is 
aware of the review and status

+ skandigraun@gmail.com
+ fntoth@gmail.com


I'm sorry this took as long as it did to review.  I've been able to rework some 
things, but the test cases need to be reworked.  They don't work properly for me.

I've posted my work-in-progress pseudo tree to:

https://github.com/mhatle/pseudo/tree/master-next

The top three commits (I split and reworked patch 1/2, 2/2 has minor rework in 
it, but doesn't function properly) are the current version of this code:

Move ftw and ftw64 to calling ntfw and nftw64:

https://github.com/mhatle/pseudo/commit/be112c56767d2b149403ddb84bf99fa8efc35797

The above is based on your investigation, but changes the way the call through 
works.

There is no need to declare a special type for the function, instead typecasting 
to (void *) will avoid the compiler warning and work the same way.  (I took this 
idea from glibc, which uses void * for the same reason.).  And as your note 
already indicated, the cast "should work", it seems wrong, but glibc does this.


nftw, nftw64: add wrapper:

https://github.com/mhatle/pseudo/commit/6bb390832553e7d112fd2375e27f8cebdb9e2acd

I reworked a good chunk of this, but it was only for integration not functionality.

Your initial version included a full copy of the wrapper code.  This is 
unnecessary as the system will already generate this code.  Then the 'guts' 
function simply needs to call your implementation.  The typical way we've done 
this in the past is tot implment a 'pseudo_func' function that holds the custom 
work.  This way the automatic ports just call it.

Your solution for the nftw_wrapper_base.c appears to be working well.  I did 
change a few things (moved many of the defines into that C file for instance) 
and I resolved compiler warnings about return codes being ignored on chdir and 
fchdir.   All in all I checked and I don't believe I changed how this functions, 
just the integration details.

Note I did drop the part of the commit:

+# nftw64 (and its deprecated pair, ftw64) are only present in case large
+# file support is present.
+cat > dummy.c <<EOF
+#define _GNU_SOURCE
+#include <features.h>
+#ifndef __USE_LARGEFILE64
+#error "no large file support"
+#endif
+int i;
+EOF
+if ${CC} -c -o dummy.o dummy.c >/dev/null 2>&1; then
+        echo linux/nftw64
+fi
+rm -f dummy.c dummy.o

Since nftw64 is already in the wrapfuncs.in it should be unnecessary.  However, 
if we need to make this dynamic, the right way is to add your change BACK into 
the system and remove it from wrapfuncs.in.  If this is the case, I'd like to 
make it a separate commit so we're clear and what we're doing.


ftw, nftw, ftw64 and nftw64: add tests:

https://github.com/mhatle/pseudo/commit/86d228c1308949b1917cdcd1feae1fd8b08457ea

This commit I could not get working.  I attempted to diagnose it, and never did 
figure out what was wrong.

One change I did make was to avoid stopping in the case of a failure, but 
running all of the test cases so we got a full list of information from the test 
run.  I'm running these tests by doing:

./configure --prefix=`pwd`/foo
make
make test

The output I get from the test cases is:

Incorrect return value. Expected: 0, actual: 2
test-nftw: nftw subtree skipping with pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw sibling skipping with pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw sibling skipping chddir with pseudo: Failed
Incorrect return value. Expected: 0, actual: 2
test-nftw: nftw64 subtree skipping with pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw64 sibling skipping with pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Incorrect return value. Expected: 0, actual: 1
test-nftw: ftw non-recursive walking with pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Recursive call failed
test-nftw: ftw recursive walking with pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Incorrect return value. Expected: 0, actual: 1
test-nftw: ftw64 non-recursive walking with pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Recursive call failed
test-nftw: ftw64 recursive walking with pseudo: Failed
Incorrect return value. Expected: 0, actual: 2
test-nftw: nftw subtree skipping without pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw sibling skipping without pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw sibling skipping chdir without pseudo: Failed
Incorrect return value. Expected: 0, actual: 2
test-nftw: nftw subtree skipping without pseudo: Failed
Incorrect return value. Expected: 0, actual: 3
test-nftw: nftw sibling skipping without pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Incorrect return value. Expected: 0, actual: 1
test-nftw: ftw non-recursive walking without pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Recursive call failed
test-nftw: ftw recursive walking without pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Incorrect return value. Expected: 0, actual: 1
test-nftw: ftw non-recursive walking without pseudo: Failed
Incorrect fpath received. Expected: walking/a1/b1/c1/file, actual: 
alking/a1/b1/c1/file3
Recursive call failed
test-nftw: ftw recursive walking without pseudo: Failed
test-nftw: Failed.


Can you take a look at the test cases, I don't really understand them very well. 
   Some of this stuff looks like it could be off-by-1 errors both in the 
'Expected' and 'Actual' side of things.  As for the other failures, I'm really 
not sure everything that is going on here and I figured it might be more obvious 
to someone else.

--Mark


On 4/7/25 6:11 PM, Mark Hatle wrote:
> Thank you for the additional items.  I'm going to attempt to review this in the
> next day or so and I'll reply with my findings.  On the surface it looks a bit
> more complicated then I originally thought it would.  But that may very well be
> needed.
> 
> --Mark
> 
> On 4/7/25 2:14 PM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
>> This is an (attempt at the) implementation of the nftw and ftw[1] calls in pseudo.
>>
>> The main motivation is a change in btrfs-tools[2], in which
>> they have changed from walking the filetree and calling stat
>> on each entries separately to using the nftw call. As a result,
>> btrfs filesystem generation currently happens with incorrect
>> ownership details, as the nftw calls go around pseudo.
>>
>> See also the relevant report[3] on the Yocto mailing list.
>>
>> The main idea: with a custom wrapper capture the nftw call, and switch the callback
>> to our own callback. When our own callback is called, fix the received
>> stat struct, and call the original callback, this time with the correct
>> stat struct.
>>
>> Big thanks to Lander Van Loock, who not only reported the
>> original issue, but also helped testing and reviewing the first version
>> of the code.
>>
>> Please let me know what you think.
>>
>> [1]: https://linux.die.net/man/3/nftw
>> [2]: https://github.com/kdave/btrfs-progs/commit/c6464d3f99ed1dabceff1168eabb207492c37624
>> [3]: https://lists.yoctoproject.org/g/yocto/message/64889
>>
>>
>> ---
>> v1: https://lore.kernel.org/yocto-patches/20250317113445.3855518-1-skandigraun@gmail.com/T/
>>
>> changes in v2:
>> - Add wrapper for ftw, ftw64, nftw and nftw64 (instead of only nftw in v1). All of them
>>     use the same wrapper file, using macros to account for the naming differences.
>> - ftw64 and nftw64 depend on large file support of the system. To account for this, move
>>     these implementations into their own subport folder, and compile them conditionally.
>> - Move tests into separate commit (and add some tests for the new calls too)
>> - The original implementation didn't consider multiple concurrent requests
>>     when it was saving the original call's details (callback function pointer,
>>     flags), and subsequent calls could overwrite data. This version stores
>>     these details in an array that behaves similar to a LIFO proto-stack.
>> - Fix one bug in FTW_CHDIR flag behavior in conjuction with FTW_DEPTH flag (it switched
>>     to a folder, which didn't match glibc implementation's behavior)
>> - Minor change in Makefile: since the tests between ftw/ftw64 and nftw/nftw64 are exactly
>>     the same, they are also implemented in the same file, which however is expected to be
>>     included in other files, and is not a compile-unit on its own. For this, the Makefile
>>     looks for files with "test-" prefix in the test folder.
>>
>> ---
>>
>> Gyorgy Sarvari (2):
>>     nftw, ftw: add wrapper
>>     nftw, ftw: add tests
>>
>>    Makefile.in                            |   4 +-
>>    guts/README                            |   6 +-
>>    ports/linux/guts/ftw64.c               |  16 --
>>    ports/linux/nftw64/guts/ftw64.c        |  29 +++
>>    ports/linux/{ => nftw64}/guts/nftw64.c |   7 +-
>>    ports/linux/nftw64/pseudo_wrappers.c   |  45 +++++
>>    ports/linux/nftw64/wrapfuncs.in        |   2 +
>>    ports/linux/subports                   |  14 ++
>>    ports/linux/wrapfuncs.in               |   2 -
>>    ports/unix/guts/ftw.c                  |  13 +-
>>    ports/unix/guts/nftw.c                 |   7 +-
>>    ports/unix/guts/nftw_wrapper_base.c    | 211 ++++++++++++++++++++++
>>    ports/unix/pseudo_wrappers.c           |  45 +++++
>>    ports/unix/wrapfuncs.in                |   2 +-
>>    test/ftw-test-impl.c                   | 226 +++++++++++++++++++++++
>>    test/nftw-test-impl.c                  | 236 +++++++++++++++++++++++++
>>    test/test-ftw.c                        |   4 +
>>    test/test-ftw64.c                      |   4 +
>>    test/test-nftw.c                       |   4 +
>>    test/test-nftw.sh                      |  84 +++++++++
>>    test/test-nftw64.c                     |   4 +
>>    21 files changed, 937 insertions(+), 28 deletions(-)
>>    delete mode 100644 ports/linux/guts/ftw64.c
>>    create mode 100644 ports/linux/nftw64/guts/ftw64.c
>>    rename ports/linux/{ => nftw64}/guts/nftw64.c (57%)
>>    create mode 100644 ports/linux/nftw64/pseudo_wrappers.c
>>    create mode 100644 ports/linux/nftw64/wrapfuncs.in
>>    create mode 100644 ports/unix/guts/nftw_wrapper_base.c
>>    create mode 100644 test/ftw-test-impl.c
>>    create mode 100644 test/nftw-test-impl.c
>>    create mode 100644 test/test-ftw.c
>>    create mode 100644 test/test-ftw64.c
>>    create mode 100644 test/test-nftw.c
>>    create mode 100755 test/test-nftw.sh
>>    create mode 100644 test/test-nftw64.c
>>
>>
>>
>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1331): https://lists.yoctoproject.org/g/yocto-patches/message/1331
> Mute This Topic: https://lists.yoctoproject.org/mt/112139640/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

