Return-Path: <joaomarcos.costa@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97309CCA476
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 08:04:07 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.38060.1760342640993546395
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 01:04:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=K5LYMuXC;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2A62B4E41064;
	Mon, 13 Oct 2025 08:03:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA05A606C6;
	Mon, 13 Oct 2025 08:03:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBA9C102F224A;
	Mon, 13 Oct 2025 10:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760342638; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7wLMZNe1Di3kw1ftfkZN1ci5whni+ZevIeYGuytHGOA=;
	b=K5LYMuXC7LMFr3JBS3MeCGcbbm4Q/4sLsKAduZEZuLgk0mscq8juTIt3vSRTFc4Qek8Pao
	DWZ69SeXEU7oBv/RxS9nrOMwHV0XGXUfpI2GHoovzECQC22vVSTBh2jNLsjlAw1DY4xf/1
	/aHL2sBvjYpsNFaf8MO1aXNO/1dX1kedQlA15UEV+m78bBfg0/eRkw8a5PYWfjxqCJAsXo
	+vHT98zT5tNoZdN4JkVgxC7RvgusFwv0o9SVsFPtcPLO8+ZySjqT+XXAUNXSJAXbMfDmnS
	aQcNTzDo/B6ceZUBuP0NgHgOmYiqwDqDQht4IBbwRHfHgBD19oWABbW9KP9K1Q==
Message-ID: <3d30bc09-fbb0-4d49-b866-be17c5d6270b@bootlin.com>
Date: Mon, 13 Oct 2025 10:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH v2 0/1] initscripts: fix incompatibility
 with read-only-rootfs
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com, joe.macdonald@siemens.com,
 yi.zhao@windriver.com
References: <20250929162057.48553-1-joaomarcos.costa@bootlin.com>
 <b80fe998-eb2d-46e0-bf8f-1299967cc27f@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <b80fe998-eb2d-46e0-bf8f-1299967cc27f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 08:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2291

Hello,

On 10/6/25 11:17, Joao Marcos Costa wrote:
> Hello,
>=20
> On 9/29/25 18:20, Jo=C3=A3o Marcos Costa wrote:
>> Hello,
>>
>> This patch presents a possible fix for a build-time issue whenever the
>> 'read-only-rootfs' IMAGE_FEATURE is used. I decided to keep the=20
>> details on the
>> commit message itself, and to add this cover letter mostly for keeping=
 a
>> changelog.
>>
>> Best regards,
>> ---

Gentle ping: would there be any updates about this patch?
Thanks!

--=20
Best regards,
Jo=C3=A3o Marcos Costa

