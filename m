Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DDC3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 05:43:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.70241.1746510204398233166
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 22:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 5465gLpi008957;
	Tue, 6 May 2025 00:42:22 -0500
Received: from [192.168.2.37] ([192.168.2.37])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 5465gL0N012619;
	Tue, 6 May 2025 00:42:21 -0500
Message-ID: <b399726a-90fb-49f2-bf68-b09069c3ccda@kernel.crashing.org>
Date: Tue, 6 May 2025 00:42:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH v4] ftw, nftw, ftw64, nftw64: add
 tests
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, skandigraun@gmail.com
Reply-To: yocto-patches@lists.yoctoproject.org
References: <183C546FDCCF2C10.22941@lists.yoctoproject.org>
 <c0f7f65f-de10-477a-b5b3-4c820711e6a8@gmail.com>
 <183C737CE9E3BD51.22941@lists.yoctoproject.org>
In-Reply-To: <183C737CE9E3BD51.22941@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 May 2025 05:43:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1517

Just want to confirm, that everything passed my testing and I've pushed the code 
to the git server:

https://git.yoctoproject.org/pseudo/log/

Changelog:
     nftw, nftw64: add wrapper
     ftw, nftw, ftw64, nftw64: add tests
     Move ftw and ftw64 to calling ntfw and nftw64
     makewrappers: Introduce 'array' support
     pseudo_util.c: Avoid warning when we intentionally discard const
     pseudo_client.c: Fix warning
     yocto-older-glibc-symbols.path: Add as a reference patch
     pseudo/pseudo_client: Add wrapper functions to operate correctly with glibc 
2.38 onwards
     configure: Prune PIE flags
     test/test-parallel-rename.sh: Add parallel rename test
     test/test-parallel-symlinks.sh: Add parallel symlink test
     Now version 1.9.1
     ports/linux/guts: Add .gitignore to ignore generated files


On 5/4/25 5:27 PM, Mark Hatle wrote:
> I checked and this is working as expected.  Without the new nftw code it fails,
> add the code and it passes.
> 
> Thanks for reworking this.
> 
> --Mark
> 
> On 5/4/25 8:02 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
>> I have executed this on ext4 and btrfs @ EndeavourOS successfully - but
>> please let me know if it still crashes and burns for you in some novel way.
>>
>>
>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1491): https://lists.yoctoproject.org/g/yocto-patches/message/1491
> Mute This Topic: https://lists.yoctoproject.org/mt/112610906/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

