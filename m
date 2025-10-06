Return-Path: <joaomarcos.costa@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A72CAC5B8
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 09:18:07 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.30063.1759742278874506340
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Oct 2025 02:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=Je4IZDbQ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 205F74E40F22
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Oct 2025 09:17:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4983606B7;
	Mon,  6 Oct 2025 09:17:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 415F8102F1C35;
	Mon,  6 Oct 2025 11:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759742276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y6Pe8oZ9IG1DYxK5WvghhO4miEyO6YQqiM7l4y9BrRI=;
	b=Je4IZDbQkTiG16TvQy9oubrYcgivqDEugQyXZa1wfadk4gRnWmDkgDTS4hOY2JQVoE/9Bi
	lziZ6dQKwXbBZcMavbY2h1X6YVaZuLouauewso3A0sQFNMnRHaAdqJEjdiQP2dYtUhhZ1W
	4rVXulkIQHaeVcgQw6AOOvI6CiC8x+AuqiHWaaQ/1e0XZZGNNpZ8yfXRhR8zsTVYgMnOIq
	UfAQXTtMBsycSOa/l9RY7iOd1kaqswARWZwGW1IqnHuefAkSqRe0iw2P4GMLZCNyxZWota
	jGTAqYw48tUuLvI5onvqvO+0CQMWytwyghELyTToiOE4ig7WWxXj09dTJ8cpBw==
Message-ID: <b80fe998-eb2d-46e0-bf8f-1299967cc27f@bootlin.com>
Date: Mon, 6 Oct 2025 11:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH v2 0/1] initscripts: fix incompatibility
 with read-only-rootfs
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com, peter.kjellerstedt@axis.com,
 joe.macdonald@siemens.com, yi.zhao@windriver.com
References: <20250929162057.48553-1-joaomarcos.costa@bootlin.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20250929162057.48553-1-joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Oct 2025 09:18:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2271

Hello,

On 9/29/25 18:20, Jo=C3=A3o Marcos Costa wrote:
> Hello,
>=20
> This patch presents a possible fix for a build-time issue whenever the
> 'read-only-rootfs' IMAGE_FEATURE is used. I decided to keep the details=
 on the
> commit message itself, and to add this cover letter mostly for keeping =
a
> changelog.
>=20
> Best regards,
> ---
>=20
> Changes in v2:
> - removed the do_ prefix in do_restore_context as it is used mostly for=
 tasks
> - replaced the python anonymous function by 'postfuncs' variable flag
>=20
> Jo=C3=A3o Marcos Costa (1):
>    initscripts: fix incompatibility with read-only-rootfs
>=20
>   recipes-core/initscripts/initscripts-1.0_selinux.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20

I'm realizing now that I didn't add the maintainers to CC in my previous=20
mail, sorry about that.

--=20
Best regards,
Jo=C3=A3o Marcos Costa

