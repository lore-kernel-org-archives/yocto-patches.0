Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D44BD5E39B
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 14:50:36 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24269.1765896634299335924
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 06:50:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=el5JOBfe;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=R4DJHw9w;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EE2F14001E1;
	Tue, 16 Dec 2025 09:50:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 16 Dec 2025 09:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765896633; x=1765983033; bh=EY3w0UMn7G
	1iB7S/FgQPfMvcSmt+WtZhCFOfDG7FESg=; b=el5JOBfed3+y4dmnj0haZ9c9sz
	jtHuvtxSKdEpzTT3Zdeg5h+HEqYWtwkKNs9HP9gHwlGRq14NwD3OdYnL9PeZC9DY
	L6DBSSvr8Ge8YVyGN9llBMmEW4Lte2/dFqvy0TAKHIC91l/NZH1qsEkkCe9Bc/8C
	tLUSal5ej8ofx33jBX3DsSxOZHVQKp8ag0HqFTt8GR9t09RQDb5Lm1N26ERjeDiA
	Bjxak7Hf0Qppz0gtALNzKk42/heO55pNCX/cwcmayn9IiqneVwGVJe10XqaPtBeO
	XUBPXWEagNRHJ8NmmYswjbN73BJVKJpnycck/VvxYIEGBUCpuw9kvL+g6wiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765896633; x=1765983033; bh=EY3w0UMn7G1iB7S/FgQPfMvcSmt+WtZhCFO
	fDG7FESg=; b=R4DJHw9wTKLZ0F4RA7I48rvElZ+hgIA+/jEBR+pnRnHjQ38TOK5
	/nWMTBWRndn1QGGJbAM3oU5PFU1iONHaJW2KwJtVzEc5akczi/DYu/QKX8k4jWIX
	sjD6ed4Ez/LHjtswlyw09UCTUW0415RF0hg1m5AOMKSLtGtG6D1Tk843OhLauA0W
	ryBdyME/INfr+BWeWaMMASeJ5aM+AYBzvHIixGN9o6jFkBR+Qc58BAuxDZubUU9r
	D0CBcT0UjbRRDCGSq62PZTuDXmIPSiJhKZhAUGF9T9NoR59z1aVWQvnLWsgPtrz5
	chfnkBv1BcEutOkHsJoBt5Tj5ynOz62vLAA==
X-ME-Sender: <xms:uXFBaVg5TczFiQKNBzV9hoCwKJmxmB8EqoQI6-a9QqbMWH5iyhGV-w>
    <xme:uXFBaRz-UHRLmbSb8RqRGkt5G7opSyLEjp9nnUKNigwGXSHgg41lU0bt9lsqsaKGc
    GxWncNFYTGUw6fg8sGaiiD-iOPxIX57rY185_Q-4V_v325nJex1cXE>
X-ME-Received: <xmr:uXFBaYLV-j4Dnlru4TQr1JBh8gDquYfmTjULZk959AeQ1s1pye3NaZr8VBJXJ6W8U6YlY9FeDRPbamSaT3CK-frSfbETJtDJKHK-3-_JssZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ejudefvdfhheevtdduledvleejieehieevffelhefffedtgfduvdevjeekheffhfenucff
    ohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihoh
    gtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdp
    rhgtphhtthhopegrnhhujhdrmhhithhtrghlsehoshhsrdhquhgrlhgtohhmmhdrtghomh
    dprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurght
    ihhonhdrohhrgh
X-ME-Proxy: <xmx:uXFBaYQ1CcdJNNW1ttC9ijMt7x9BKpu_B-slqlnoW4ejuJSoqzGd2Q>
    <xmx:uXFBaQprg0B7c6GINq5Cu3u-iCRUR_vA1OsvT-Me6C9ecs9v0pidew>
    <xmx:uXFBadpPhkbwH1kE3GguxFBEYfMleuGvNEj5nUZ4vUvjVMr-O-cD8g>
    <xmx:uXFBaaPpz8msnChkYll8AV1h79ZXgdy11Jp4oG7wsME1bmDDraTRpw>
    <xmx:uXFBaXH8qcvAiBgQOenZhQ7mKd0xhLxjUVoqP-mg124AO5WP6VCa7Mf8>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 09:50:32 -0500 (EST)
Message-ID: <ae85a91f90b249465bb6169bf5d109ac32869873.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2] config.py: add
 meta-qcom to layers to be built
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org, Anuj Mittal
	 <anuj.mittal@oss.qualcomm.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 16 Dec 2025 14:50:28 +0000
In-Reply-To: <20251216124336.2902015-1-anuj.mittal@oss.qualcomm.com>
References: <20251216124336.2902015-1-anuj.mittal@oss.qualcomm.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jA81JxAbJ1SDSNW+0xMJ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 14:50:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2803


--=-jA81JxAbJ1SDSNW+0xMJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-16 at 18:13 +0530, Anuj Mittal via
lists.yoctoproject.org wrote:
> From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
>=20
> Add builder for Qualcomm BSP layer meta-qcom that can be individually
> triggered.
>=20
> Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Richard merged this and I was able to run a successful build:
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/113/builds/1

You can go ahead and send the a-full config change now.

Best regards,

--=20
Paul Barker


--=-jA81JxAbJ1SDSNW+0xMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaUFxtBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqjWAQC3xW/hZnN1vqg0d9ZxT10BihfYGvnh7UIm
soYE4hECDQD/em2xF3iRrwVWwOS5c6m+6h9nKONkOSjMeDOYXPH/1g8=
=2rVm
-----END PGP SIGNATURE-----

--=-jA81JxAbJ1SDSNW+0xMJ--

