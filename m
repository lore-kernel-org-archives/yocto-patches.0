Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC03F9EDDB
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 14:10:49 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83442.1776867043927669928
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 07:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63MEAe4D3976348;
	Wed, 22 Apr 2026 09:10:41 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 63MEAeMA026494;
	Wed, 22 Apr 2026 09:10:40 -0500
Message-ID: <4144b8f6-a49a-456f-9d67-98a833751d6b@kernel.crashing.org>
Date: Wed, 22 Apr 2026 09:10:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo] [PATCH] ports/linux: Add missing __open_2 wrapper
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
References: <20260421212410.3716914-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20260421212410.3716914-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 14:10:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3761

Thought I had responded to this yesterday.

I did review this, looks fine to me.

--Mark

On 4/21/26 4:24 PM, Richard Purdie wrote:
> Somehow we've missed the wrapper for __open_2 for far too long (over a decade!).
> It can be called from useradd in shadow, so add the missing wrapper. We already
> have the similar __openat_2 wrapper.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   ports/linux/guts/__open_2.c | 15 +++++++++++++++
>   ports/linux/wrapfuncs.in    |  1 +
>   2 files changed, 16 insertions(+)
>   create mode 100644 ports/linux/guts/__open_2.c
> 
> diff --git a/ports/linux/guts/__open_2.c b/ports/linux/guts/__open_2.c
> new file mode 100644
> index 0000000..7e54c8f
> --- /dev/null
> +++ b/ports/linux/guts/__open_2.c
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) 2026 Richard Purdie
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * static int
> + * wrap___open_2(const char *path, int flags) {
> + *	int rc = -1;
> + */
> +
> +	rc = wrap_open(path, flags, 0);
> +
> +/*	return rc;
> + * }
> + */
> diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
> index 234a13c..0e275d5 100644
> --- a/ports/linux/wrapfuncs.in
> +++ b/ports/linux/wrapfuncs.in
> @@ -1,4 +1,5 @@
>   int open(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
> +int __open_2(const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
>   char *get_current_dir_name(void);
>   int __xstat(int ver, const char *path, struct stat *buf);
>   int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW */

