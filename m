Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5081C3ABA9
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:35:25 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.13459.1745915715575069865
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 01:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KSsPcPHk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D344443302;
	Tue, 29 Apr 2025 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745915713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWbSLA5S8lyJAbDbKkoQPQ0X7oR5cBoILXruSLm24j4=;
	b=KSsPcPHke8fhcQ1tP332NnQnuJ08KKItM1083pU8s0uBheO+aebccDokFgHrdNE5Q9Y4Ib
	f/jvMVfu9iQrEWQzs95nLDKRk8FqVTmkx6RNM7KmG3qx4bQk9SjNNBMjYDpeqYvgdoopy2
	mTCYxg0Of2+3HtHX8exfz9x5IXniNxqTA4u2HuJGzY/MWS2+x5eYz/k74V4jFkaDqlknFT
	xsUJz2oZjXSE+ytLgoX0BHWkUmL3cKOqXIW+SjvC1ZG5sgL7xjv4flxS6r2terBc3QKg1i
	FfbqriFp4iO77uOmWzPq6sH1pFB8AuDETbMU/sE1MAAoviN9iuD+WpFsdKca6Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 10:35:12 +0200
Message-Id: <D9IZGTSK88IQ.3SW3K1MGF0SI6@bootlin.com>
To: "Martin Jansa" <martin.jansa@gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] schedulers: add
 meta-webosose scheduled build for scarthgap
Cc: <yocto-patches@lists.yoctoproject.org>, "Hieu Van Nguyen"
 <hieu2.nguyen@lge.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250429021622.309740-1-hieu2.nguyen@lge.com>
 <D9IWYS89PR2K.3BQ97RPTUB3UR@bootlin.com>
 <CA+chaQcOT+oRpoDSDXxfQutAeR2m4OO0YzYK08iPevbY36+wnA@mail.gmail.com>
In-Reply-To: <CA+chaQcOT+oRpoDSDXxfQutAeR2m4OO0YzYK08iPevbY36+wnA@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelteetgfffhfefvddvvdeghfelleegffffveefheeukedvveekheektddvveekjeenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghrthhinhdrjhgrnhhsrgesghhmrghilhdrtghomhdprhgtphhtthhop
 eihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehhihgvuhdvrdhnghhuhigvnheslhhgvgdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 08:35:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1419

On Tue Apr 29, 2025 at 8:47 AM CEST, Martin Jansa wrote:
> On Tue, Apr 29, 2025 at 8:37=E2=80=AFAM Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>>
>> IIRC in your previous version you also had changes about meta-qt6
>> versions. Are these changes not needed anymore?
>
> Maybe you mean this commit:
> https://web.git.yoctoproject.org/yocto-autobuilder2/commit/?id=3D21b5aa78=
0ea79c32b340d53aaef808520983b88b
> which was already merged and the same version should be used for both
> kirkstone and scarthgap based builds.
>
> Cheers,

Oh yes, it was that!

So everything is fine, I'm OK to merge this patch.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


