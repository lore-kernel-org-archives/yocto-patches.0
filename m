Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE8D2ECFA
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 23:58:34 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48669.1768867108262746919
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 15:58:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60JNwPdr2658117;
	Mon, 19 Jan 2026 17:58:25 -0600
Received: from [192.168.2.106] ([192.168.2.106])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 60JNwONT003069;
	Mon, 19 Jan 2026 17:58:24 -0600
Message-ID: <0f67e95c-1e76-422d-b43a-8a59b0af8c58@kernel.crashing.org>
Date: Mon, 19 Jan 2026 17:58:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Seebs <seebs@seebs.net>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: Pseudo master - 1.9.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 23:58:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3031

With all of the recent changes, I've now push the latest work to master and 
declared it as '1.9.3' release.

Changelog (summary):

Makefile.in: Bump version to 1.9.3
configure: Minor code quality changes
pseudo: code quality scan - resolved various potential issues
makewrappers: improve error handling and robustness
Update COPYRIGHT files
ports/linux/pseudo_wrappers.c: Call the wrappers where possible
ports/linux/pseudo_wrappers.c: Workaround compile error on Debian 11
ports/linux/pseudo_wrappers.c: Reorder the syscall operations
ports/unix/guts/realpath.c: Fix indents
pseudo_util.c: Skip realpath like expansion for /proc on Linux
test/test-proc-pipe.sh: Add test case for proc pipes
ports/unix/guts/realpath.c: realpath fails if the resolved path doesn't exist
test-tclsh-fork: Skip test if tclsh is not available
test/test-nftw: Avoid compile warnings
test/test-statx: Add uutils test case
run_tests.sh: In verbose mode, include pseudo.log in output
test-realpath: Verify the realpath behavior matches glibc
test/test-statx.sh: It should be a failure if pseudo prints an error
test: Cleanup test output
test-syscall: Remove build warning
makewrappers: Fix EFAULT implementation
makewrappers: Enable a new efault option
ports/linux/openat2: Add dummy wrapper
test-syscall: Add a syscall test
ports/linux/pseudo_wrappers: Avoid openat2 usage via syscall
pseudo_db.c: Fix xattr memory allocation
linux/portdefs: Fix _STAT_VER/_MKNOD_VER for riscv

Contirbutors:
Gauthier HADERER
Mark Hatle
Nick Owens
Richard Purdie

