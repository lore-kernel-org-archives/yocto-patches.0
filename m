Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB9C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 14:37:43 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.10303.1744209459192506925
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 07:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ogSFNsUo;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 115C544338;
	Wed,  9 Apr 2025 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744209457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncC5aP6kFyNsKNUd2PFtM8CZPO/MSqI0u9NM5ZAfUzQ=;
	b=ogSFNsUoyh6JXO3r+lbgpjQHsXWuNZ8xojTHBeOdOJdKAXpI9XaXQqs0xJKCiRKzVcfVfY
	g/Jj6yRvLZ8fFHY9PgSuMmNFVUo4UkHP9W4wBlUPKGGuXIl0k1qX69z7/8/u9pTkIJF80a
	qtmmp3rEv4q/6AB4IfAXNTkpf/UPpfT331P2g6nlRHDfBcrbmJa8f5gRZjx4Khun/Z2Aph
	umO7KcO1CQmrxKv7SZVIlie9k7IL023ptCpgn8/3w9MdcfbIWmZrEym1usqANI191fdlDS
	snQsMNtQ5SDgguYzGvYdd8msa+HeZUnmGs1H/LYEliFu6QCREShIIvgIoI4n1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 16:37:35 +0200
Message-Id: <D926NE9BWQNP.24UZVBATV4CNF@bootlin.com>
Subject: Re: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: add a
 builder for meta-webosose
Cc: <martin.jansa@gmail.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <hieu2.nguyen@lge.com>, <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409135714.3204718-1-hieu2.nguyen@lge.com>
In-Reply-To: <20250409135714.3204718-1-hieu2.nguyen@lge.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehhihgvuhdvrdhnghhuhigvnheslhhgvgdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdpr
 hgtphhtthhopehmrghrthhinhdrjhgrnhhsrgesghhmrghilhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 14:37:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1341

On Wed Apr 9, 2025 at 3:57 PM CEST, hieu2.nguyen wrote:
> From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
>
> Backport from master, with the extend layers updated and
> the target default branch changed to scarthgap-webos.
>
> Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> ---

Looks good to me. Thanks.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


