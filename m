Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2873E677EB
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 15:37:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.82313.1766417826952510203
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 07:37:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 5BMFb4dP674379;
	Mon, 22 Dec 2025 09:37:05 -0600
Received: from [192.168.2.103] ([192.168.2.103])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 5BMFb2uE021599;
	Mon, 22 Dec 2025 09:37:03 -0600
Message-ID: <0cb04994-2f26-40ca-b500-39727b7a7acc@kernel.crashing.org>
Date: Mon, 22 Dec 2025 09:37:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] unix: realpath fails if the
 resolved path doesn't exist.
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Gauthier HADERER <ghaderer@wyplay.com>
References: <20251219140600.212527-1-ghaderer@wyplay.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20251219140600.212527-1-ghaderer@wyplay.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 15:37:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2845

I'm going to investigate this a bit more, but I think generally speaking this 
may be right.

Looking at the POSIX documentation for realpath, we need to set errno as well. 
I've just got to figure out what the errno needs to be.  It looks like there are 
two different errno settings, one is based on the dirname, the other the 
basename.  But I need to figure out what real glibc does in this case so we can 
mimic.

I plan to work on this today and provide more feedback as I get it.

--Mark

On 12/19/25 8:06 AM, Gauthier HADERER via lists.yoctoproject.org wrote:
> The pseudo implementation of `realpath()' may return a path which doesn't
> exist. This is not POSIX compliant and causes troubles with uutils (coreutils
> in Rust).
> 
> For example, the tail commands tries to determine the file path of its standard
> input file descriptor by calling `realpath("/dev/fd/0")'. When the input is a
> pipe, the GNU C library returns NULL but pseudo returns
> `/proc/<pid>/fd/pipe:[xxxxxx]'. As it got a path, the tail command tries to
> open it and fails.
> 
> Upstream-Status: Pending
> ---
>   ports/unix/guts/realpath.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/ports/unix/guts/realpath.c b/ports/unix/guts/realpath.c
> index 8d8118b..ee7d409 100644
> --- a/ports/unix/guts/realpath.c
> +++ b/ports/unix/guts/realpath.c
> @@ -14,6 +14,14 @@
>   		errno = ENAMETOOLONG;
>   		return NULL;
>   	}
> +
> +	/* We must fail if the target path doesn't exist. */
> +	struct stat buf;
> +
> +	if (base_lstat(rname, &buf) == -1) {
> +		return NULL;
> +	}
> +
>   		len = strlen(rname);
>   		char *ep = rname + len - 1;
>   		while (ep > rname && *ep == '/') {

