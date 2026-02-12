Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC45EDF057
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:20:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41084.1770884396888701639
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:19:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=XgtPLKte;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C28EC23DAB
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:20:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5091C606CA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:19:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0E1B11971335
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 09:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770884393; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bw82kryrUSQd7abBr5GNOHFAmzbgJhUNi1iUgDp4BvY=;
	b=XgtPLKteo7L47gSvnX4Wf2BzdhNpEn2jrYSmuzAt7YB8sTpDi5vJilDUwiZcR33n0MCBKK
	c6hKrFzrYF+Q6GNF1CUNAQgfXqbxAU+xCHMqkrc0kRq+rctQmD9LP2UZrqkicrq5IZkJEJ
	nPP0MzCXyHYnEWupkqXGGxse/Rxt3ZAVrZsKfMISmpoP++F3KG/d5A8uH0Ep5BTLn3fTjp
	REzH3YW2+FQ7zLlsBGz1KYgz+AKmZ3joqaG6FrkM+hBFr8cwizxjj1Dt7VsWpHzVWWnGPi
	RKWAXfl2J4P6B5ZcS3eVoQm5RmGw02/S305uGybQb45mot4VV7so8HThpkS3Hw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 09:19:52 +0100
Message-Id: <DGCU4J5YR1W5.INVOLGGIIOMG@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/release-parser: remove poky repo add wrynose branch
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
In-Reply-To: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:20:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3220

Hi,

On Thu Feb 12, 2026 at 12:15 AM CET, Michael Halstead via lists.yoctoprojec=
t.org wrote:
> Remove references to the deprecated poky repository. Use meta-yocto for
> tag data instead. Update to include the 6.0 branch.

I had already sent a series about this:
https://lore.kernel.org/r/20260204-releases-parser-updates-v3-0-be208a7748b=
1@bootlin.com

Which does some improvements to the script, mainly for maintainability. If
there's better reason to use meta-yocto instead of yocto-docs, maybe we cou=
ld
merge the two? Should I resend?

Antonin

