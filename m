Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F0CCD193
	for <webhook@archiver.kernel.org>; Sat, 18 Oct 2025 13:40:07 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.6101.1760794797693301588
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Oct 2025 06:39:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zfF9LoZ1;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FB5D1A14DD
	for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Oct 2025 13:39:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 769846069D
	for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Oct 2025 13:39:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8C3D102F2387;
	Sat, 18 Oct 2025 15:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760794791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OcVP44mVttv/KInwFaVGzDxtlIOdenceuJWP3SKF4bQ=;
	b=zfF9LoZ1nzS0gA5zXXfE18xdK7X2Mr6zHGL+n4fFdBW5uR94S6SLVu5sF3x7KrK2CWFHpk
	dq+2IAixDQkW8EIzOZdxA/kxi8jbewIN3F+1Yw3yPINmXpWfE8rTlduL145BsKAtZFIOSM
	ZYDE3Ljuijq2Btj9KpIRBSeClwlwl3qVgB5EMiUiAiZmbtZOpxE2gYFiRBO9gFRb47eZX+
	4PUFbOXq3MXhDd6VwWXgZt8mktWCpa5yzL4QQEAdM4KSf27fogBwpOIGwNHQRNtRk/IAFX
	cMLlBK19iGSzOtAoFkMrPbvMvaDFCUyrSIZD6hnSRxNBiwa1AD/zjB8P5Gn0nw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Oct 2025 15:39:49 +0200
Message-Id: <DDLHNRC85Q0Y.3MBWTJI5T8ZKA@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [PATCH yocto-autobuilder-helper] prepare-shared-repos: Add tag
 for separate gits
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251017-contrib-mathieu-oe-core-tag-v1-1-9ed5059cde28@bootlin.com>
In-Reply-To: <20251017-contrib-mathieu-oe-core-tag-v1-1-9ed5059cde28@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Oct 2025 13:40:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2352

On Fri Oct 17, 2025 at 10:20 AM CEST, Mathieu Dubois-Briand wrote:
> As poky is no longer used, add tags for openembedded-core, bitbake and
> meta-yocto. We continue to use the same poky-ci-archive repo.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> PLEASE DO NOT MERGE!
>
> Only merge this once oe-core and bitbake master branches have been
> pushed on poky-ci-archive, as we need to bypass push checks to do that.
> ---

I confirm this is now ready to merge on my side.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


