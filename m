Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F1C369A4
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 16:06:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.79861.1744128374620375678
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 09:06:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 538G6DmF007028
	for <yocto-patches@lists.yoctoproject.org>; Tue, 8 Apr 2025 11:06:13 -0500
Received: from [192.168.2.185] ([192.168.2.185])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 538G6DXU029824
	for <yocto-patches@lists.yoctoproject.org>; Tue, 8 Apr 2025 11:06:13 -0500
Message-ID: <1bd5bd95-8387-4f76-8018-389738f3f910@kernel.crashing.org>
Date: Tue, 8 Apr 2025 11:06:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH v2 2/2] nftw, ftw: add tests
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
References: <20250407191414.2992785-1-skandigraun@gmail.com>
 <18341F33308F8E0B.31078@lists.yoctoproject.org>
 <b4499a40-ff59-4d17-9dc4-00a7221c4e19@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <b4499a40-ff59-4d17-9dc4-00a7221c4e19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 16:06:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1335



On 4/8/25 9:33 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> On 4/7/25 21:14, Gyorgy Sarvari via lists.yoctoproject.org wrote:
>> +#if !defined(__USE_LARGEFILE64) && FTW_NAME == ftw64
>> +return 0
>> +#endif
> If nothing else, at the very least a semicolon is missing in this short
> path when the call is not available (and in its nftw64 pair). Will keep
> it in mind to fix - won't submit a v3 only with this on my own.

Thanks, I'll add this to my local merge for review and testing.

--Mark

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1333): https://lists.yoctoproject.org/g/yocto-patches/message/1333
> Mute This Topic: https://lists.yoctoproject.org/mt/112153968/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

