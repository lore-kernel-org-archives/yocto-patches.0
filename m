Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C6109878C
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 14:32:11 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14189.1774017127402631544
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 07:32:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 62KEW5Dn1408832;
	Fri, 20 Mar 2026 09:32:06 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 62KEW3B8013042;
	Fri, 20 Mar 2026 09:32:03 -0500
Message-ID: <781ef458-bf35-4cf4-9f28-b320a956f4cb@kernel.crashing.org>
Date: Fri, 20 Mar 2026 09:32:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH pseudo 0/3] Memory management fixes and b4
 config
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
References: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 14:32:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3529

The set looks good to me.  I'm surprised about the possible alloc/buffer overflow.

I suspect it's never triggered because we over allocate for the PSEUDO variables 
just before that, but relying on that behavior is not safe, so your change 
should ensure we have enough space at all times.

--Mark

On 3/20/26 7:01 AM, Paul Barker wrote:
> Fix memory management issues found by Claude Opus 4.6, and add
> configuration for b4 to simplify sending patches.
> 
> ---
> Paul Barker (3):
>        pseudo_setupenvp: Allocate space for new env vars if needed
>        pseudo_setupenvp: Handle malloc failure safely
>        Add b4 configuration
> 
>   .b4-config    |  4 ++++
>   pseudo_util.c | 18 ++++++++++++++----
>   2 files changed, 18 insertions(+), 4 deletions(-)
> ---
> base-commit: 56e1f8df4761da60e41812fc32b1de797d1765e9
> change-id: 20260320-some-fixes-d87097cdbeb5
> 
> Best regards,

