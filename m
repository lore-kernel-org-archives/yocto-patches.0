Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CB5C9832E
	for <webhook@archiver.kernel.org>; Sat, 17 Jan 2026 16:09:01 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11178.1768666132578942582
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Jan 2026 08:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60HG8oae2511094;
	Sat, 17 Jan 2026 10:08:50 -0600
Received: from [192.168.2.106] ([192.168.2.106])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 60HG8mMO002116;
	Sat, 17 Jan 2026 10:08:49 -0600
Message-ID: <b511b5ae-3401-4ca3-8d3a-83eaeed9b623@kernel.crashing.org>
Date: Sat, 17 Jan 2026 10:08:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH 13/20]
 ports/linux/pseudo_wrappers.c: Reorder the syscall operations
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Reply-To: yocto-patches@lists.yoctoproject.org
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
 <188B0C23901378A4.2703508@lists.yoctoproject.org>
In-Reply-To: <188B0C23901378A4.2703508@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Jan 2026 16:09:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3003



On 1/15/26 5:43 PM, Mark Hatle wrote:
> The seccomp wrap always takes effect when pseudo is running, this will
> prevent various behavior, even if pseudo is generally considered to be
> disabled, but in memory.
> 
> The openat2 and renameat2 however should only run if pseudo is enabled.
> 
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
> ---
>   ports/linux/pseudo_wrappers.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
> index 6b54083..b486c34 100644
> --- a/ports/linux/pseudo_wrappers.c
> +++ b/ports/linux/pseudo_wrappers.c
> @@ -65,19 +65,6 @@ syscall(long number, ...) {
>   		return rc;
>   	}
>   
> -#ifdef SYS_renameat2
> -	/* concerns exist about trying to parse arguments because syscall(2)
> -	 * specifies strange ABI behaviors. If we can get better clarity on
> -	 * that, it could make sense to redirect to wrap_renameat2().
> -	 */
> -	if (number == SYS_renameat2) {
> -		errno = ENOSYS;
> -		return -1;
> -	}
> -#else
> -	(void) number;
> -#endif
> -
>   #ifdef SYS_seccomp
>   	/* pseudo and seccomp are incompatible as pseudo uses different syscalls
>   	 * so pretend to enable seccomp but really do nothing */
> @@ -92,6 +79,10 @@ syscall(long number, ...) {
>   	}
>   #endif
>   
> +        if (pseudo_disabled) {
> +                goto call_syscall;
> +        }
> +
>   #ifdef SYS_openat2
>   	/* concerns exist about trying to parse arguments because syscall(2)
>   	 * specifies strange ABI behaviors. If we can get better clarity on
> @@ -105,6 +96,18 @@ syscall(long number, ...) {
>   	}
>   #endif
>   
> +#ifdef SYS_renameat2
> +	/* concerns exist about trying to parse arguments because syscall(2)
> +	 * specifies strange ABI behaviors. If we can get better clarity on
> +	 * that, it could make sense to redirect to wrap_renameat2().
> +	 */
> +	if (number == SYS_renameat2) {
> +		errno = ENOSYS;
> +		return -1;
> +	}
> +#endif
> +
> +call_syscall:

On Debian 11 this fails to compile.  I had to add a patch to workaround what I 
suspect is a compiler bug:

  call_syscall:
+       /* On Debian 11 - gcc (Debian 10.2.1-6) this results in:
+        *   error: a label can only be part of a statement and a declaration
+        *   is not a statement
+        *
+        * adding a ; here resolves this
+        */
+       ;
+




>   	/* gcc magic to attempt to just pass these args to syscall. we have to
>   	 * guess about the number of args; the docs discuss calling conventions
>   	 * up to 7, so let's try that?

