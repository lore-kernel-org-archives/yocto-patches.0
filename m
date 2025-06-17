Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:45:52 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.22678.1750175146046896859
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:45:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=JEy25Aor;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1472B4390F;
	Tue, 17 Jun 2025 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750175144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMF3crfi3A4UOsNkQFFDfpAQeMNPfLAS4AQGDMp3F0M=;
	b=JEy25AordNgv4mtUjjbyaqnhRhMnP4hRRTDmzayCK7juyYVMSwblJ6HhNbwsiC7yYH67M2
	UuxHtYez/+KuhE/6RlMPq64CjHAdUSLAt8wAH+RtntWSDSnMQ3PTYGv7za4ck1QxTbv8lQ
	QoAikuGpUGOQ/yCgjLOE6kYxbPGb5s65UohzoAoKo3OdYPpzClSuTiApydrpfoPAzWJYXx
	uWQqLTFIMSI7b7I2orMydWfJTf0AMDCe3b0H1FBr79SXz6zMdaCFrsPHxmOHySGyA5FguO
	S1KNGRHgO8PeLIuw+x/JPFyzdtoINGZdBiTBCEBXiLmPq2fpWQ8BN2J+fKcGlA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Jun 2025 17:45:43 +0200
Message-Id: <DAOXB5FFF6ZJ.1R9HFZP8C1HMR@bootlin.com>
Subject: Re: [PATCH swat-tools 0/4] Improvements and fixes to swat-tools
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Antonin Godard" <antonin.godard@bootlin.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
In-Reply-To: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehli
 hhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Jun 2025 15:45:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1655

On Tue Jun 17, 2025 at 5:04 PM CEST, Antonin Godard wrote:
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Antonin Godard (4):
>       main: fix --yes short flag
>       pokyciarchive: fetch tags with --tags
>       Add a b4 configuration file
>       README: add a contributing section
>
>  .b4-config                |  3 +++
>  README.md                 | 19 +++++++++++++++++++
>  swattool/main.py          |  2 +-
>  swattool/pokyciarchive.py |  2 +-
>  4 files changed, 24 insertions(+), 2 deletions(-)
> ---
> base-commit: 72997bc94167082b3767571f1833ac805cdcb4a4
> change-id: 20250617-improvements-e5cbad7184b0
>
> Best regards,

Looks good, thanks!

I have merged the series.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


