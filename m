Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F6C83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 13:44:14 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web11.19329.1751982245000552268
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 06:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BuZv33Qo;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1D314420E;
	Tue,  8 Jul 2025 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751982243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttjbIlcwRZamUoMBmkeO6lcWCwrR0kk/wvNNqC7T+8U=;
	b=BuZv33Qo6vnZ9rr1yha4LUGYQYeHWZ8+NOqpzZu3sZ72siXCos3x0dfpXIyerrjYZyHYlV
	rUz3d9VXwod8nEAFjc1jbK2cv9wuOzWMlCyDz9wKwbqOCvX2OFroEm6p45yfHZLxwMByPQ
	c2aT+3GlAfFzWal1roRLTVtNYXxIJ82WZ02P1idgb19IXvsWBUyPYws/CDwF4Wkja3KGG1
	a6taGwErFcSOWm0iVYLfi6P0NqwzA8B+uvAJ/6Ro//Ix5g8lnAk5pvnKub4absyVo0Hwea
	LtMLcxBeakT/Ye+BPpQVI+YamZMeom6lHyIp1AaYMmVmWSWRny6XtSUggoIIIg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 15:44:02 +0200
Message-Id: <DB6PVF3X5TB3.1RJMGWID88B8R@bootlin.com>
Subject: Re: [swat-tools][PATCH] Add a parent build column and filter
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Antonin Godard" <antonin.godard@bootlin.com>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
In-Reply-To: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghss
 ehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 13:44:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1785

On Fri Jun 20, 2025 at 11:08 AM CEST, Antonin Godard wrote:
> To be able to filter failures by parent build number, e.g. filter all
> failures for a-full build number xyz, add a --parent-build-filter (-p)
> option to swattool. The option can be passed multiple times and can be a
> regular expression.
>
> It is also displayed by default in show-pending-failures, after the
> column "Build" as "Parent".
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---

Hi Antonin,

I really like the overall idea, but I believe we should also add a way
to identify the buildbot instance this build number belongs to. As the
build number is not unique across different instances. E.g. You have ids
that can refer either to builds on valkyrie or typhoon.

On the other hand I don't want to end-up with overly complicated ids, nor
overly complicated logic here. Maybe we can just use ids such as vk/1234
or tp/1234 and have a built-in list of known buildbot instances to do
the association.

Tell me if you want to work on it, otherwise I will try to rework a bit
your patch later this week.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


