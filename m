Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6EC47BCA
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 08:54:37 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86164.1767689667324997582
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Jan 2026 00:54:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CuGAuMwG;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B47931A2691
	for <yocto-patches@lists.yoctoproject.org>; Tue,  6 Jan 2026 08:54:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8955260739
	for <yocto-patches@lists.yoctoproject.org>; Tue,  6 Jan 2026 08:54:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9A66103C85DA;
	Tue,  6 Jan 2026 09:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767689665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S4p0F8BsINdp4VkyipZRT4L+nV09m3HiRDmIFoic0lo=;
	b=CuGAuMwG9IFvGV9P50mPdJEozvc/A6nn3WeHmXKpnnvcBRssi+ayndXPKcSu88ijGaXR8B
	KccT3yPClJz4QWcVYsrU4SoR9fcO8Qa5LStfn6GprYPmVkv8O+Yw7hA84GjimIindoImW2
	vIXkY/dvE4e/BsSyBDv2RftqXV4ENqHfv+s0ZfuXZ/yH6/jMc5Cjmpxg1mLmF8YZtfdZ7J
	gdL+dPZZvCEvrFip/LnzkTiW2TJNfkuP+o8jCRSoSbqfPKxpXzGVFx6q0M4z/IfP7O52Eb
	G/YxcFhPAd7WFUr87MfamI0DSKC88pCSecxBvE9u0Jszicwsfgkn0Vh4HGlFFA==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 09:54:24 +0100
Message-Id: <DFHDOT5PJD17.276DXUP096DSW@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [layerindex-web][PATCH RESEND] layerindex: branchcompare: add
 rST format
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
References: <20251127-branch-compare-rst-v1-1-4eaf3a66ea91@bootlin.com>
In-Reply-To: <20251127-branch-compare-rst-v1-1-4eaf3a66ea91@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 08:54:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2902

Hi,

On Thu Nov 27, 2025 at 4:48 PM CET, Antonin Godard wrote:
> Add a new rST output format for the branch comparison tool. This can be
> used to help write the Yocto Project release notes.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> An existing example (that I formatted manually at the time):
> https://git.yoctoproject.org/yocto-docs/tree/documentation/migration-guid=
es/release-notes-5.2.rst?id=3D79cd33b06e87c04e4f873a5afd9d53714bc5047f#n876
>
> HTML output: https://docs.yoctoproject.org/5.2.4/migration-guides/release=
-notes-5.2.html#recipe-upgrades-in-yocto-ver

Gentle reminder on this patch, would be nice to have for the next Yocto rel=
eases!

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


