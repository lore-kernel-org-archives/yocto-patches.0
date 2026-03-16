Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14E8F013EA
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 08:57:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46224.1773651474122072978
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 01:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FQSUIGyb;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 116801A2DDB
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 08:57:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD3BB5FC4A
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 08:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D989103680A9;
	Mon, 16 Mar 2026 09:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773651471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b8tP+Hh2ZBPytkceg9vzf47V5P4TsykB9RspWeF6e3E=;
	b=FQSUIGybR+5ehQP+vXZCX2vyhRNkDi+BilAZJe5fciNx5C8dldSqM1ewQeXOfcFGwdp9Dh
	/Hwo7QtOm73U82ua63eR0LRnHFEGpXqGqHwNGm3m9+5ILWZu3VL+OaOU45NB8ZEOlD4tS3
	seXWXozZHyn+r1eYIV030i5cbevFJgUCj8lSflKRkpRKAMbios1qDczbh0NzypHnWCPdwe
	QJWIDNovip3mfAj3rIhlempJOwFU44sJPJkAM84vJOQo6eD5mbfm/R9A6xoeX4yspvnuUi
	gXTZR+GvVoa+yAB20dvpV1zU5D5XFBy8Q0k6T9bEN7o4jb+MKPW8cCZlXhLXTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 09:57:49 +0100
Message-Id: <DH42Z0QXNNSZ.2OI2R6DSNV24I@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-autobuilder-helper][PATCH] scripts/release-parser.py:
 add bitbake version mappings to releases.json
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>
References: <20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com>
In-Reply-To: <20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 08:57:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3467

Hi,

Gentle reminder regarding this patch. This should allow me to move forward =
with
documentation series for yocto-docs and bitbake.

Antonin

