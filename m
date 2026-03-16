Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C2BF46436
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 09:31:20 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46623.1773653472831309352
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 02:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Q8cql4Mq;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 83B2AC415A5
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:31:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B6535FC4A;
	Mon, 16 Mar 2026 09:31:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8554B10369A9D;
	Mon, 16 Mar 2026 10:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773653461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c4Pvo0+IOG/sjq9X3lA8dtyxNpfI7YNveo6Mc3hmB18=;
	b=Q8cql4MqaXZqGvQUQWqxu+8zrLZ34QUJH8l0aCY1MQy8NPOifVy7GWu3r/54b2vwhmtzvQ
	J4K9RgJ0l/QMhQpBsJTRHzyZSLbyqNBQbo7RSRbsrpyvISQGEA8XorBlKNhEOZcdNEBU2V
	iwRL6IdP/+wPt7i9xABxLpfUHfTx0MDI72TwJ0TpSxdlZ8BIXmn+hun+8TUoYttULgMg93
	PVtrIU+s75ybyMGdhNSrYBDcrfwn00v+LKuNRXN4x+MSYediEek/ASw33RhxrocKHmB3MA
	+09XnBe+zgAcEZk7NAgmr12pdJI6HorVCIZjBfYMxeifQXeiaT+n2HA20wHZ4g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 10:30:59 +0100
Message-Id: <DH43OEYB7W0E.T9XQDHR8TC6D@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/release-parser.py: add bitbake version mappings to releases.json
References: <20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com> <DH42Z0QXNNSZ.2OI2R6DSNV24I@bootlin.com> <d5b8168f1c98b0a36e699fc78069b1581624777d.camel@linuxfoundation.org>
In-Reply-To: <d5b8168f1c98b0a36e699fc78069b1581624777d.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:31:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3469

On Mon Mar 16, 2026 at 10:16 AM CET, Richard Purdie wrote:
> On Mon, 2026-03-16 at 09:57 +0100, Antonin Godard via lists.yoctoproject.=
org wrote:
>> Gentle reminder regarding this patch. This should allow me to move
>> forward with documentation series for yocto-docs and bitbake.
>
> The challenge is you sent patches with "X needs to merge before Y else
> things break" and I just haven't had the time to focus and work it out.

This particular patch does not depend on another series being merged, and I
believe I haven't sent a series depending on this one yet. However I did
recently send other series with docs <-> yab-helper dependencies (the switc=
her
menu work) so I could see this easily being mixed up.

> This patch needs to be rebased as it doesn't apply as far as I can tell
> after spending too long trying to work out if I was missing a patch.

Sorry that's on me, I did not notice Yoann's patch. I will rebase and resen=
d
this.

Antonin

