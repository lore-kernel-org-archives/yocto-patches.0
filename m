Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CAD6A25E
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:13 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.22117.1731680830453019740
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 06:27:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dfxnErdV;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 686A1FF803;
	Fri, 15 Nov 2024 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731680828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8M+sLiiUY466cAF2hCeX1teEw8o/MJ8cx8I24afJsIs=;
	b=dfxnErdVdMJCoAbbaiTDxGTY6duyFzCfnrM1sxseALqxApeclfpCWo57uP2cOtb0rMtP0/
	JLH2H8ho+ZeGHwojbHF8+F6C89PPn0it3b7iErr+0a5F5C52yG6gYfMMrA+rtqm0+lZjlO
	GCxC7PZ0pJtAs+cccukgNqWiLwq02+oS8gkanwJ032l07WEaA6anWLsVktm3bXZGVWUmxC
	fKuQLySyFvIH4bztsz+IIozEdy6GTSwl6pQBiwoCzbGGInr1NR5Y98dAT9ZwduaTwLyhoT
	cqD2emh8pOAu5NgyktNwoB4w4nVLLquaA1QpTI95W9VYnQuivBLtiz/ayGECUg==
Date: Fri, 15 Nov 2024 15:27:07 +0100
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 prepare-shared-repos: Allow to tag poky git
Message-ID: <ZzdaO5pl5BIVCwN_@bootlin-mathieu>
References: <20241115140249.176032-1-mathieu.dubois-briand@bootlin.com>
 <a6d0d2b5-9d8a-47ae-89ed-f332765c37ae@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d0d2b5-9d8a-47ae-89ed-f332765c37ae@cherry.de>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 14:27:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/808

On Fri, Nov 15, 2024 at 03:21:15PM +0100, Quentin Schulz wrote:
> Hi Mathieu,
> 
> Apparently git-push supports pushing without a remote, c.f. the manpage:
> 
>        git push [--all | --branches | --mirror | --tags] [--follow-tags]
> [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>                   [--repo=<repository>] [-f | --force] [-d | --delete]
> [--prune] [-q | --quiet] [-v | --verbose]
>                   [-u | --set-upstream] [-o <string> |
> --push-option=<string>]
>                   [--[no-]signed|--signed=(true|false|if-asked)]
>                   [--force-with-lease[=<refname>[:<expect>]]
> [--force-if-includes]]
>                   [--no-verify] [<repository> [<refspec>...]]
> 
> [...]
> 
>        <repository>
>            The "remote" repository that is the destination of a push
> operation. This parameter can be either a URL (see the section GIT URLS
> below) or the name of a remote (see the section REMOTES below).

Oh, that's nice! I was definitely not aware of this possibility. I will
send a new version.

> 
> This would avoid leftovers from stopped/interrupted/broken runs to mess with
> the git remote addition which could fail if the remote already exists.
> 

Um right, I did not think about builds potentially interrupted in the
mean time, thanks.

> Either don't use an explicit local remote, or remove it beforehand. Except
> that removing a non-existing remote will fail check_call, so you probably
> want to simply run the command and ignore the return code.
> 
> Cheers,
> Quentin

-- 
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

