Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36222CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:02:12 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.34305.1757944930548002260
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 07:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=07ItHkzF;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0DA1B4E40BFD
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 14:02:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C88F66063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 14:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C9E5102F2AC6;
	Mon, 15 Sep 2025 16:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757944928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uZ3qNJyFXWjEOhWsmbrAPe63Y7Zr842pyveiKYIWGVY=;
	b=07ItHkzFDJxF8hYQ+CVG39VE48rak/o1yQlIRjbBdm0R+91cSf3o5YaAYd76H9qlCLQ2Ee
	LzHmIvmLC4obRAjrepQ88UTTAGAcX2nJZgBSc9JBdD6g3Se0Iv48RcucXGMM2UchxK4vP2
	ox1oK56S89WgcF70IZHX6tI4csasciEd5WRzDzEOM/wGq/AJnNJv9Y2uKQOYCWJbX/OAr8
	Xhm/bUjpqPPB4Js7IPAj/C3vgOJNAMe0tt7QQp4m/Giqx1rd9b0kJohYdNZocyiK+r5bxS
	5zbQD5/YJboZujqaDSS3UqBKZf+xTnkZWJzL0RtL6bsIgT31KSbxVNlA7bzgQw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 16:02:07 +0200
Message-Id: <DCTFGUT538S2.WRWNTIUMFVAH@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 1/3]
 scripts/run-docs-build: cleanups and improvements
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com> <20250915-pass-bitbake-active-releases-v1-1-a5530a97b9ef@bootlin.com> <4519bb54-eb26-44eb-a743-eed5b46e2bc9@cherry.de>
In-Reply-To: <4519bb54-eb26-44eb-a743-eed5b46e2bc9@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 14:02:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2198

On Mon Sep 15, 2025 at 2:53 PM CEST, Quentin Schulz via lists.yoctoproject.=
org wrote:
> Hi Antonin,
>
> On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
>> - Make it possible to override the shared directory to a local directory
>>    from environment
>> - Make variables that can be overridden from environment variables
>>    uppercase, for clarity
>
> If you want to keep exisiting users of this script working, you can keep=
=20
> reading the lowercase variant and assign it to the uppercase variant as=
=20
> default if it isn't already set for example.
>
> buildtools_url=3D${buildtools_url:-https://downloads.yoctoproject.org/rel=
eases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standal=
one-5.1-modified.sh}
> BUILDTOOLS_URL=3D${BUILDTOOLS_URL:-$buildtools_url}

I didn't have this in mind, I can surely do that.

>> - Convert mkdir to mkdir -p when creating output directories
>
> Why? mkdir -p silences some errors. I assume we want to make sure the=20
> directory doesn't exist already so we don't reuse some stale data.

IIRC, I had issues building locally without this. I'll try again without th=
is flag.

>> - Minor indent fixes and overall cleanups
>>=20
>
> One commit per item in this list please, so it's easier to review :)

I'll try splitting it up.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


