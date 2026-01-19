Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4437CCF2D2
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 09:21:09 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31831.1768814467837325343
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 01:21:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=uHK4uQh8;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CA0164E42179
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 09:21:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9503260731
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 09:21:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAB1110B697AB;
	Mon, 19 Jan 2026 10:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768814465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zdn2CictHTYs8ndy1OoIYb3LdvDdKc20deH4nNTWlgc=;
	b=uHK4uQh8AnwO5SJyeaiy6yoKQG7km3JzZiugVpzvkz7YXNDf66G7aBCHPRWa7+OEnVuuCJ
	RhXSzn5w0B/IzS+sL9csauU0Ss4vQ2ZT9Vx2c1kYbC9692QDi05rXN5IPDn7d2/7JLFcXp
	kg8p4tLAeqaj4pntmywg0FiZIsTzqyk4d0HZ5g840PL+1IL1SE6SuBE5ctjhW7caZWF6t2
	AUrFHIlHxQ6P8at0q0B0NVmM9RLAIMig7RQjIRDc11GC7NROuOrIcmNhm6COIRjxPemeUY
	mXwPQ5ScZreqYOOwPHlLJKbTycn5KBqs7oye9W32ysocPHi3aPa12zQKs5ONMg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 10:21:03 +0100
Message-Id: <DFSGEATL05G4.3SKCAZ9C8UGBT@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] config.json:
 rename qemux86-64 builders to contain "-64"
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20260119-qemux86-64-builds-rename-v1-1-1509a9431c02@bootlin.com> <c232e9f1078adaf155f7c0c7ad74a8665737df0e.camel@linuxfoundation.org>
In-Reply-To: <c232e9f1078adaf155f7c0c7ad74a8665737df0e.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 09:21:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3011

Hi,

On Mon Jan 19, 2026 at 9:53 AM CET, Richard Purdie via lists.yoctoproject.o=
rg wrote:
> On Mon, 2026-01-19 at 09:43 +0100, Antonin Godard via lists.yoctoproject.=
org wrote:
>> It can be confusing as some builds are also named qemux86-<something> fo=
r
>> the "qemux86" machine. Rename these two qemux86-64 to begin with
>> "qemux86-64-".
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>> =C2=A0config.json | 4 ++--
>> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>
> I do agree it is confusing but it isn't this simple, you need to rename
> in autobuilder2 and in every branch of autobuilder-helper. Things like
> the results output then change too :/
>
> It did used to actually build qemux86, we changed that as it didn't
> make sense but I worried about the renaming of the target on the
> autobuilder. I'm not sure whether that was in kirkstone or not.

I see, I sent this knowingly of some possible gotchas, thought I'd send it
anyway. No problem not having this, thanks for the explanation!

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


