Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B452D72361
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:02:17 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64051.1769158927714155402
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:02:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=eoIePZpA;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12B8E1A2AEA
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:02:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D51BD6070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:02:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 245FD119A879A;
	Fri, 23 Jan 2026 10:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u50Naz9iwnzd84UI+xtygwwAj5TtK/JTJI1TcSP8mYM=;
	b=eoIePZpAd0nLqydf116lnxIGSD7U5yCGdOgBlJRGsKfjQVvehVBLnc8NNwhpH+TBCbpK7b
	jjkpxqgSMRO97QIurTPIaSurS0bUpEwIWhpOZm3Bg3fwFVwq56EzaNmZUoskdD0ouLptwM
	W25wTpwhqJ968O0NAZ/MeOC3YW6QIHWj40eRpJd0xzOFPlF91gEaa1cS1hEWgoAyRpzRgv
	/oQoPPlwHoDgEqWUUHSfBLk2X41JQBNzc9cPC1ai/Pd5WNwi2g8kFZW7asdM7AqfY/ACzb
	3gA+KDLhm1qJG3qdckFaakpneL7lMiUFjBPxgeiXlDMA27KZ7t+phT1egfOW/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 10:02:04 +0100
Message-Id: <DFVUHXU20L5L.386K54P1ZHN2P@bootlin.com>
Subject: Re: [yocto-autobuilder-helper][PATCH v2 5/9] config.json: indexing:
 don't add yocto-docs as a layer
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
 <20260123-releases-parser-updates-v2-5-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-5-c24c30da807b@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:02:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3065

Erm sorry.. I could have squashed this and the previous patch in the first =
one,
and forgot. Feel free to do so when merging.

Antonin

