Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB682C43602
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 16:40:27 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49591.1782924026121490276
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 09:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 661GeMmv3759229;
	Wed, 1 Jul 2026 11:40:22 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 661GeL0D021034;
	Wed, 1 Jul 2026 11:40:21 -0500
Message-ID: <1a6863b7-b95f-4330-913d-8230827212a9@kernel.crashing.org>
Date: Wed, 1 Jul 2026 11:40:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo] [PATCH 1/7] pseudo.h: Avoid accessing unallocated memory
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 16:40:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4350



On 7/1/26 8:13 AM, Richard Purdie wrote:
> We can call STARTSWITH in cases where the item being searched for is longer
> than the string itself. Switch from memcmp to strncmp to avoid accessing
> unassigned memory.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   pseudo.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pseudo.h b/pseudo.h
> index b6c13f2..1152c19 100644
> --- a/pseudo.h
> +++ b/pseudo.h
> @@ -99,7 +99,7 @@ extern char *pseudo_version;
>    #define PSEUDO_LIBDIR "lib"
>   #endif
>   
> -#define STARTSWITH(x, y) (!memcmp((x), (y), sizeof(y) - 1))
> +#define STARTSWITH(x, y) (strncmp(y, x, strlen(y)) == 0)

I've not looked at the users of STARTSWITH.  If they are all strings this is 
fine.  I believe memcmp was originally used because it could be items with nulls 
in it.  The bug may be that 'sizeof' was not calculated properly (specifically 
checking both X and Y, only y.. which can lead that the issue.)

>   
>   #ifndef PSEUDO_LOCALSTATEDIR
>    #define PSEUDO_LOCALSTATEDIR "var/pseudo"

