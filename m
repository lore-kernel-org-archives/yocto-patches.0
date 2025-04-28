Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15BC369DC
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:44:39 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.46097.1745840671150802761
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 04:44:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=eQ8d26q3;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BA1343AF3
	for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745840669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLUw00snpFd4tcuaPS+HTfvZJl1xg5CUO3XzT843F7M=;
	b=eQ8d26q3+ZZf1IHne2vvhknt6CZ4Nit84niUQdWuiOGuZrChyR053tMoQ0iYg4kEQOD5nP
	UiJgrihIn7sdMH4rcUbQ3O1dtxdmRSJqtPapgRM0IAVp+uxjjIJu23UJsvXYqlp5It4zXI
	U6YbDQuH02FsEpJ1gLNl8hr4x9Jw5BvXeEb/er/a/slBYgp0C05Dz38MJUFKJfIlw7yGQg
	hmLNUdYWRNIjfzxY1QY609JooLw9SSHKpxarAlOufmM/f+ZBsAV4dGGPk75indcBEirOsu
	JSK+3/0YmAPPrDYNt4T+OsL3Z4t8BmzrTCQsXSOfYkRNFmE1k7TbFEv0RCAhVg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 13:44:28 +0200
Message-Id: <D9I8V74MZOPK.3D7IBD96E1R3A@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][scarthgap][PATCH]
 config.json: add a builder for meta-webosose
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <2632b1436e89479a8e9045188905c804f292e7c4.camel@linuxfoundation.org> <25979.1745837806742414180@lists.yoctoproject.org>
In-Reply-To: <25979.1745837806742414180@lists.yoctoproject.org>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffvdelfefhffekuedvtefhgfegtdfhvefggeetfefhhefgfeeflefhteduvdekffenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 11:44:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1409

On Mon Apr 28, 2025 at 12:56 PM CEST, Hieu Van Nguyen via lists.yoctoprojec=
t.org wrote:
> On Mon, Apr 28, 2025 at 04:52 PM, Richard Purdie wrote:
>
>>=20
>> https://lists.yoctoproject.org/g/yocto-patches/message/1339
>
> Thanks Richard, to support the webosose: Scarthgap build, we need to sche=
dule this branch separately, similar to K irkstone , right?
>
> Thanks and best regards,
> Hieu
>

Yes, I know you had some bits of a patch a few weeks ago, so either you
can rebase it on the master branch and send it, or I can work on it on
my side.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


