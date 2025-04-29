Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B7C369CB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 06:37:45 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.10847.1745908660514951436
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 23:37:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WXU4HIlb;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E6B8438D7;
	Tue, 29 Apr 2025 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745908658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQlfxFlHpu96VFIwvvsWo9SpK28Xlvzvbst6PMIzLU0=;
	b=WXU4HIlbIqCIWI0vUExHLHdktujVypfrm6uh9oKYUvNFNgTkuQxttLi2cvooG1pyOhdXN3
	iDgyD6EdaHFsDXl2i4mqxiG7OMCCxvq37t5m0j37J/7oa2OyX74tO5oT9KEtgMyCUosX6J
	H0x048F1gaU5ZvD7/2bKDmCdM2234nde7GHhqgBlywwIvzqG1RTaeEG6juR4SacWfAtG5f
	4OlZp5dISTlVcOLEZ+SB/6gi0N7TScLZ2Q7t06z0HbfyKHL7u53w5CwtHLbAPwHUMyJ5h0
	XDFiYunpRbotkkOXJMnCthzzO9x6zCKJNbmWdDAcrtbWjBBEnByCvqBpleaZ2w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 08:37:36 +0200
Message-Id: <D9IWYS89PR2K.3BQ97RPTUB3UR@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] schedulers: add
 meta-webosose scheduled build for scarthgap
Cc: <martin.jansa@gmail.com>, "Hieu Van Nguyen" <hieu2.nguyen@lge.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250429021622.309740-1-hieu2.nguyen@lge.com>
In-Reply-To: <20250429021622.309740-1-hieu2.nguyen@lge.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgefhkeettdefgeejffdvhfduteelvdeffffhteekffelfeejgfeiffduteejveenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjv
 ggtthdrohhrghdprhgtphhtthhopehmrghrthhinhdrjhgrnhhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehhihgvuhdvrdhnghhuhigvnheslhhgvgdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 06:37:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1415

On Tue Apr 29, 2025 at 4:16 AM CEST, Hieu Van Nguyen via lists.yoctoproject=
.org wrote:
> From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
>
> Support to build meta-webosose for both of kirkstone and scarthgap
> branches.
>
> Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> ---
>  schedulers.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/schedulers.py b/schedulers.py
> index fd2cad6..1fead60 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -642,7 +642,10 @@ schedulers.append(sched.AnyBranchScheduler(name=3D"b=
itbake-docs-changed",
>              properties=3Drepos_dict_for_scheduler("docs"),
>              builderNames=3D["docs"]))
> =20
> -# Run meta-webosose for kirkstone once a week on weekends (2am on Friday=
)
> +# Run meta-webosose for kirkstone and scarthgap once a week on weekends =
(2am on Friday)
>  schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=
=3D'kirkstone', properties=3Dparent_default_props('meta-webosose', 'kirksto=
ne'),
>                                  codebases =3D {'' : {'branch' : 'kirksto=
ne'}},
>                                  builderNames=3D['meta-webosose'], hour=
=3D2, minute=3D0, dayOfWeek=3D4))
> +schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=
=3D'scarthgap', properties=3Dparent_default_props('meta-webosose', 'scarthg=
ap'),
> +                                codebases =3D {'' : {'branch' : 'scarthg=
ap'}},
> +                                builderNames=3D['meta-webosose'], hour=
=3D2, minute=3D0, dayOfWeek=3D4))

Hi Hieu,

IIRC in your previous version you also had changes about meta-qt6
versions. Are these changes not needed anymore?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


