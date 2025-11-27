Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB0CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 15:47:58 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21509.1764258474833519065
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 07:47:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WOd31Q0W;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DF6144E418F5
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:47:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A763460722
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:47:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CAF7A103C8C44;
	Thu, 27 Nov 2025 16:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764258472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ijZD40Psi9geKmzSJ2SHW+pjQkvlv+d/iIr1R94BhAk=;
	b=WOd31Q0WbM1u4MxqxFnv9k1raGEbuWsfYnallfFQC9ghArAFaPj7iw6pZ3DutiHX79qScR
	2iRBvenncGXSJ6KEyQIpuXGreAVtInBGW/fyYSbf4IZz7vzDfe8SkK5Eqyq/yEF6HTkEQT
	ElJN96FXxtd5byBbMEL3hMWnsq1jeuWGNTJiFZLSI/VUrN0YY9UkKq5B1GRISGlm7CqtnD
	qghf4k07/eOCeGgeosNv5LJ6+iOY8oyiyKG3MuETBJ3b0vd2Q/OOGdwUL5b/9oxS3eFJVt
	6xOKGSnczfalLoGkvEMNPNP61ISLQ5OmA+heoizwnckJYcK9xunvSFDm+3lj1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 16:47:50 +0100
Message-Id: <DEJLFKMUJ4U5.3D9DQM3B7YEX8@bootlin.com>
Subject: Re: [PATCH] layerindex: branchcompare: add rST format
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20251127-branch-compare-rst-v1-1-70c00ab5c149@bootlin.com>
In-Reply-To: <20251127-branch-compare-rst-v1-1-70c00ab5c149@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2719

Sorry, this is missing [layerindex-web] before the subject, I will resend i=
t.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


