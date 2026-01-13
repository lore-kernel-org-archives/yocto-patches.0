Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125FD29DC9
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 03:52:29 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51486.1768276347344249761
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Jan 2026 19:52:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60D3qOAb2123591;
	Mon, 12 Jan 2026 21:52:24 -0600
Received: from [192.168.2.106] ([192.168.2.106])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 60D3qNeK026939;
	Mon, 12 Jan 2026 21:52:23 -0600
Message-ID: <27df45e8-9f48-4ca7-933a-6d48478bf666@kernel.crashing.org>
Date: Mon, 12 Jan 2026 21:52:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] unix: realpath fails if the
 resolved path doesn't exist.
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
References: <20251219140600.212527-1-ghaderer@wyplay.com>
 <18d3c7cf-d644-42ac-a53c-3920014deb60@kernel.crashing.org>
 <502343.1767620059571907902@lists.yoctoproject.org>
 <583437.1767861396752509344@lists.yoctoproject.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: Gauthier HADERER <ghaderer@wyplay.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <583437.1767861396752509344@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 03:52:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2949

Thank you for the patch.

I've merged this in a temporary branch 'fray/master', along with a test case and 
Richard's openat2 syscall work.

d3c58c2 test-syscall: Add a syscall test
ad9f32c ports/linux/pseudo_wrappers: Avoid openat2 usage via syscall
3225656 unix: realpath fails if the resolved path doesn't exist.
4e4f97a test-realpath: Verify the realpath behavior matches glibc
786d146 pseudo_util.c: Skip realpath like expansion for /proc
0922771 test: Cleanup test output

--Mark

On 1/8/26 2:36 AM, Gauthier HADERER via lists.yoctoproject.org wrote:
> Here's an updated version of my patch with a fix regarding the type of the stat 
> structure.
> _._,_._,_
> --------------------------------------------------------------------------------
> Links:
> 
> You receive all messages sent to this group.
> 
> View/Reply Online (#2913) 
> <https://lists.yoctoproject.org/g/yocto-patches/message/2913> | Reply to Group 
> <mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bpseudo%5D%20%5BPATCH%5D%20unix%3A%20realpath%20fails%20if%20the%20resolved%20path%20doesn%27t%20exist.> | Reply to Sender <mailto:ghaderer@wyplay.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bpseudo%5D%20%5BPATCH%5D%20unix%3A%20realpath%20fails%20if%20the%20resolved%20path%20doesn%27t%20exist.> | Mute This Topic <https://lists.yoctoproject.org/mt/116859482/3616948> | New Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription 
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/3616948> | Contact Group 
> Owner <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe 
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy> [mark.hatle@kernel.crashing.org]
> 
> _._,_._,_

