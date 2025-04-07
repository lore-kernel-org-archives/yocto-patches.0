Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D431C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 23:12:45 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.61797.1744067559489259545
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 16:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 537NBXkO020135;
	Mon, 7 Apr 2025 18:11:33 -0500
Received: from [192.168.2.185] ([192.168.2.185])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 537NBVDt006101;
	Mon, 7 Apr 2025 18:11:31 -0500
Message-ID: <88d39373-9d16-4761-9f8a-c3b7d41d6aa1@kernel.crashing.org>
Date: Mon, 7 Apr 2025 18:11:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH v2 0/2] nftw, ftw: add wrappers
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: landervanloock@gmail.com
References: <20250407191414.2992785-1-skandigraun@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20250407191414.2992785-1-skandigraun@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 23:12:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1331

Thank you for the additional items.  I'm going to attempt to review this in the 
next day or so and I'll reply with my findings.  On the surface it looks a bit 
more complicated then I originally thought it would.  But that may very well be 
needed.

--Mark

On 4/7/25 2:14 PM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> This is an (attempt at the) implementation of the nftw and ftw[1] calls in pseudo.
> 
> The main motivation is a change in btrfs-tools[2], in which
> they have changed from walking the filetree and calling stat
> on each entries separately to using the nftw call. As a result,
> btrfs filesystem generation currently happens with incorrect
> ownership details, as the nftw calls go around pseudo.
> 
> See also the relevant report[3] on the Yocto mailing list.
> 
> The main idea: with a custom wrapper capture the nftw call, and switch the callback
> to our own callback. When our own callback is called, fix the received
> stat struct, and call the original callback, this time with the correct
> stat struct.
> 
> Big thanks to Lander Van Loock, who not only reported the
> original issue, but also helped testing and reviewing the first version
> of the code.
> 
> Please let me know what you think.
> 
> [1]: https://linux.die.net/man/3/nftw
> [2]: https://github.com/kdave/btrfs-progs/commit/c6464d3f99ed1dabceff1168eabb207492c37624
> [3]: https://lists.yoctoproject.org/g/yocto/message/64889
> 
> 
> ---
> v1: https://lore.kernel.org/yocto-patches/20250317113445.3855518-1-skandigraun@gmail.com/T/
> 
> changes in v2:
> - Add wrapper for ftw, ftw64, nftw and nftw64 (instead of only nftw in v1). All of them
>    use the same wrapper file, using macros to account for the naming differences.
> - ftw64 and nftw64 depend on large file support of the system. To account for this, move
>    these implementations into their own subport folder, and compile them conditionally.
> - Move tests into separate commit (and add some tests for the new calls too)
> - The original implementation didn't consider multiple concurrent requests
>    when it was saving the original call's details (callback function pointer,
>    flags), and subsequent calls could overwrite data. This version stores
>    these details in an array that behaves similar to a LIFO proto-stack.
> - Fix one bug in FTW_CHDIR flag behavior in conjuction with FTW_DEPTH flag (it switched
>    to a folder, which didn't match glibc implementation's behavior)
> - Minor change in Makefile: since the tests between ftw/ftw64 and nftw/nftw64 are exactly
>    the same, they are also implemented in the same file, which however is expected to be
>    included in other files, and is not a compile-unit on its own. For this, the Makefile
>    looks for files with "test-" prefix in the test folder.
> 
> ---
> 
> Gyorgy Sarvari (2):
>    nftw, ftw: add wrapper
>    nftw, ftw: add tests
> 
>   Makefile.in                            |   4 +-
>   guts/README                            |   6 +-
>   ports/linux/guts/ftw64.c               |  16 --
>   ports/linux/nftw64/guts/ftw64.c        |  29 +++
>   ports/linux/{ => nftw64}/guts/nftw64.c |   7 +-
>   ports/linux/nftw64/pseudo_wrappers.c   |  45 +++++
>   ports/linux/nftw64/wrapfuncs.in        |   2 +
>   ports/linux/subports                   |  14 ++
>   ports/linux/wrapfuncs.in               |   2 -
>   ports/unix/guts/ftw.c                  |  13 +-
>   ports/unix/guts/nftw.c                 |   7 +-
>   ports/unix/guts/nftw_wrapper_base.c    | 211 ++++++++++++++++++++++
>   ports/unix/pseudo_wrappers.c           |  45 +++++
>   ports/unix/wrapfuncs.in                |   2 +-
>   test/ftw-test-impl.c                   | 226 +++++++++++++++++++++++
>   test/nftw-test-impl.c                  | 236 +++++++++++++++++++++++++
>   test/test-ftw.c                        |   4 +
>   test/test-ftw64.c                      |   4 +
>   test/test-nftw.c                       |   4 +
>   test/test-nftw.sh                      |  84 +++++++++
>   test/test-nftw64.c                     |   4 +
>   21 files changed, 937 insertions(+), 28 deletions(-)
>   delete mode 100644 ports/linux/guts/ftw64.c
>   create mode 100644 ports/linux/nftw64/guts/ftw64.c
>   rename ports/linux/{ => nftw64}/guts/nftw64.c (57%)
>   create mode 100644 ports/linux/nftw64/pseudo_wrappers.c
>   create mode 100644 ports/linux/nftw64/wrapfuncs.in
>   create mode 100644 ports/unix/guts/nftw_wrapper_base.c
>   create mode 100644 test/ftw-test-impl.c
>   create mode 100644 test/nftw-test-impl.c
>   create mode 100644 test/test-ftw.c
>   create mode 100644 test/test-ftw64.c
>   create mode 100644 test/test-nftw.c
>   create mode 100755 test/test-nftw.sh
>   create mode 100644 test/test-nftw64.c
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1297): https://lists.yoctoproject.org/g/yocto-patches/message/1297
> Mute This Topic: https://lists.yoctoproject.org/mt/112139640/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

