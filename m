Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C059E909DB
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 16:45:18 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16480.1771346712987445951
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 08:45:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 61HGjBKJ445911;
	Tue, 17 Feb 2026 10:45:11 -0600
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 61HGjAUP020128;
	Tue, 17 Feb 2026 10:45:10 -0600
Message-ID: <586decc9-87e3-4403-8d60-28e7bdaa5c32@kernel.crashing.org>
Date: Tue, 17 Feb 2026 10:45:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] ports/linux: define __NR_openat2
 if missing
To: yocto-patches@lists.yoctoproject.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
References: <20260217154814.483670-1-yoann.congal@smile.fr>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20260217154814.483670-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 16:45:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3251

I'm inclined to say if __NR_openat2 isn't defined we don't want to support 
openat2 at all in the _standard_ pseudo.  Since the system userspace is 
effectively disconnected from the kernel.

Now, from the OE/YP point of view this is different, we want to build a system 
with support for openat2 (at least the intercept) even if the host system 
doesn't support it.

(I thought all of the 'modern' supported/not deprecated host systems were new 
enough that everyone had NR_openat2 defined in them.  I guess I was wrong.)

Right now the reply is ENOSYS, so it shouldn't be any sort of issue just always 
enabling it.  But I'd really like to get openat2 enabled at some point, and if 
we do it becomes very important that we only wrap it if it exists, otherwise we 
need to wrap and call the syscall then look for ENOSYS and 'unwrap' any changes 
we've made...

So I'm tempted to suggest a few things:

1) If NR_openat2 is not defined, we disable openat2 in the upstream project.  YP 
then carries a patch that unconditionally defines the value.

2) We optionally supply the NR_openat2 value (if undefined), but we add some 
sort of configure switch to pseudo to activate this behavior.

3) We say we always support openat2 due to the current ENOSYS behavior and just 
bake it into the future implementation that we need to handle this.  In this 
case the patch below (or one like it) is fine.

(A few notes below)

On 2/17/26 9:48 AM, Yoann Congal via lists.yoctoproject.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> On kernel <5.6, __NR_openat2 is not defined. To support build on these
> older kernel, define __NR_openat2 at the value it has on every kernel
> since 5.6: 437 [0].
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>   ports/linux/portdefs.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
> index a8b2be6..32b95ba 100644
> --- a/ports/linux/portdefs.h
> +++ b/ports/linux/portdefs.h
> @@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
>   #endif
>   #endif
>   
> -/* Debian 11 and Opensuse 15.5 need this */
> +/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */
>   #ifndef SYS_openat2
> +
> +/* On kernel <5.6, __NR_openat2 is not defined. Import the definition from
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> + */
> +#ifndef __NR_openat2
> +#define __NR_openat2 437

The value of 437 is arch specific.  I'm worried we need to expand this.

alpha - 547

(everyone else is 437)

I seriously down anyone is going to use pseudo on an alpha platform, so maybe 
this isn't a real concern anymore.

--Mark

> +#endif
> +
>   #define SYS_openat2 __NR_openat2
>   #endif
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3248): https://lists.yoctoproject.org/g/yocto-patches/message/3248
> Mute This Topic: https://lists.yoctoproject.org/mt/117858536/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

