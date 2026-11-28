Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8044.1795878150936731186
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 07:02:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ASF2S6F1647437;
	Sat, 28 Nov 2026 09:02:28 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6ASF2RGs016072;
	Sat, 28 Nov 2026 09:02:28 -0600
Message-ID: <a53842ab-ccbb-4bf4-85cf-a61c0a66d9fa@kernel.crashing.org>
Date: Sat, 28 Nov 2026 09:02:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] Version 1.99.2 has been tagged
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Reply-To: yocto-patches@lists.yoctoproject.org
References: <18EB1F83C863D45A.1772791@lists.yoctoproject.org>
Content-Language: en-US
In-Reply-To: <18EB1F83C863D45A.1772791@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 15:02:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5557



On 11/24/26 5:38 PM, Mark Hatle wrote:
> All of the pending commits have been pushed to master, and version 1.99.2 has
> been tagged.
> 
> It is intended that this will be the 2.0 version unless additional problems are
> found.

Testing on Yocto Project master showed there is some kind of bug, most likely 
with strtol call in some of the new changes.  I'd advise against 1.99.2.  I've 
staged work in master-next to attempt to resolve it, testing is in progress.

I'll create a 1.99.3 if this passes.

--Mark

> --Mark
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5513): https://lists.yoctoproject.org/g/yocto-patches/message/5513
> Mute This Topic: https://lists.yoctoproject.org/mt/122438071/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
