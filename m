Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2643DC369DC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 22:29:02 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.37959.1746397735139914206
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 15:28:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 544MRqPM015616;
	Sun, 4 May 2025 17:27:52 -0500
Received: from [192.168.2.37] ([192.168.2.37])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 544MRp1S027824;
	Sun, 4 May 2025 17:27:52 -0500
Message-ID: <9e686f8d-7d40-4376-97fa-02624be8c4a4@kernel.crashing.org>
Date: Sun, 4 May 2025 17:27:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH v4] ftw, nftw, ftw64, nftw64: add
 tests
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, skandigraun@gmail.com
References: <183C546FDCCF2C10.22941@lists.yoctoproject.org>
 <c0f7f65f-de10-477a-b5b3-4c820711e6a8@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <c0f7f65f-de10-477a-b5b3-4c820711e6a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 22:29:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1491

I checked and this is working as expected.  Without the new nftw code it fails, 
add the code and it passes.

Thanks for reworking this.

--Mark

On 5/4/25 8:02 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> I have executed this on ext4 and btrfs @ EndeavourOS successfully - but
> please let me know if it still crashes and burns for you in some novel way.
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1486): https://lists.yoctoproject.org/g/yocto-patches/message/1486
> Mute This Topic: https://lists.yoctoproject.org/mt/112610906/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

