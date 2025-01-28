Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619BFC0218D
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 08:12:06 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.13187.1738051921917933886
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jan 2025 00:12:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=O+F9eGSM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0178C0003;
	Tue, 28 Jan 2025 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738051920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUUPre/+FgFo+qB6D8rX3PyMlkluYb4Kix6KtjQacFw=;
	b=O+F9eGSMG5y7Tey07P8EUaCJX135VSfTcbwhtyW8GFV5VnD2zXeD+PeRZaxeQXg89xj9+T
	K3LELw1VEUewXkVgcADHAv80d70YmmJ8lI1xC6Evz35UHAy+uI2yBqlC3LUuQWB7mymKk/
	ahDJPeyJqx+InYpkKkMGIhmDunc5686nLppp52LICRuFqbaTAiLawrSg7c5h1UBzxVF58x
	RZARxRQdW5XnCrVAYeK3cWxRfPEhTGRRzDJ8BY1JldA0zWqOIliWih0YICWJxiy9Aja397
	mQVPyqVmhoD6fPwU5y7fIovAlgKM3yIVa3ppwL/dnfjrgC37F+vTd3vhnCx2dQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jan 2025 09:12:00 +0100
Message-Id: <D7DJZHCOLHSJ.XL65V59UKWG1@bootlin.com>
Subject: Re: [yocto-autobuilder2][PATCH v2] Fix overriding of the
 yocto-autobuilder-helper parameters
Cc: "Richard Purdie" <richard.purdie@linuxfoundation.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Antonin Godard" <antonin.godard@bootlin.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20250122-fix-autobuilder-dep-v2-1-84e8c0f623e5@bootlin.com>
In-Reply-To: <20250122-fix-autobuilder-dep-v2-1-84e8c0f623e5@bootlin.com>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jan 2025 08:12:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1007

On Wed Jan 22, 2025 at 9:41 AM CET, Antonin Godard wrote:
[...]
> diff --git a/schedulers.py b/schedulers.py
> index e4760ed8bf1d02f4edca9af87725cf116630a14b..cb4ac2b6c8042e03899551bb4=
2e1ff7e72824717 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -399,7 +399,7 @@ for builder in config.subbuilders:
>      schedulers.append(sched.ForceScheduler(
>          name=3Dbuilder,
>          builderNames=3D[builder],
> -        codebases=3D[util.CodebaseParameter(codebase=3D'', label=3D"yoct=
o-autobuilder-helper:", project=3DNone)],
> +        codebases=3D[util.CodebaseParameter(codebase=3D'', project=3DNon=
e)],

Come to think of it, I think the label could also be something like "Defaul=
t
parameters:" to clearly explain what it is.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

