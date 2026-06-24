Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF942CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 07:09:42 +0000 (UTC)
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1488.1782284981046048540
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 00:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=fJHDeCLx;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=CiKazknK;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.152, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5A6D140007E;
	Wed, 24 Jun 2026 03:09:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 24 Jun 2026 03:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782284979; x=1782371379; bh=yCfUdp1+Ol
	5TyJxkiG7sX/5S1ZXjITogd9b5ITfRZRM=; b=fJHDeCLxu7oiHta6K5Cym6nmJt
	OBanMRc2yZkshUEEr7BpReoU77ji3q6i/XfXVN80pKbgFmseYWtGZduKnx4DUC2H
	U9jmgV2XXI1hqZJjnQgSjqiWEf9mV5EakyFfBKN8EkOvHEG/4HoL2JvyggLGU2sj
	CL2e9CFCTEJgMml6HjhzomtRPYXh7DTYgTnIv9UXz/4A4FITd419I7opYuwOK6Tg
	ZOyP/DG9vlTFjUu44xTE7za6q2/BKZCEsAjtYYxLiJpYU60xilrZVrwGg62iZ/GV
	/EeE+uy0uMx9UExwTK0fH564sSCLHKI8o2M0xkzbvKL2CgzL30yFSQUzqUXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782284979; x=1782371379; bh=yCfUdp1+Ol5TyJxkiG7sX/5S1ZXjITogd9b
	5ITfRZRM=; b=CiKazknKOSOCBSlUADTA/HcGVWko5mGwot5c5z9E1EVBGH3qJ1Y
	YxWwnud0OBLkbm4IBY2c595lyg8/HXoF/vrOfVb1c6+SDFSbF6QOxkYPkp3g2WQ3
	JBZXsCKWHa6zgB2irbZZf1cu6V5PrJtzZQboc3m+4ecVZM2Gav64XM3pcnFBb6at
	XwdRFMV9YdxgfZbH+P/O60x3tUeVhL7Y02qlWeKPsgWlKBY5rE2cSeKG+cFBsH8W
	Gb7Fd4nsQkkEwJpTcGUuFj4cYpFLAfL8a6FyhT0Tk90jKZEROkjJueSnMn4/LM5Z
	7A+EcttGJhTopPcoKTwShfFImG5nVJIeeoQ==
X-ME-Sender: <xms:s4I7aiisfU0oitV-1FHacZp1qVZaDOarB7mPEhyeMIFFOhXp86KavQ>
    <xme:s4I7aqc04P0ezl4sPfp2MyjUzp8SVcuWYisjI5dvLL72gFN88sovaHk2HSg5txlbu
    x99KHXrhp0rrkbaBmGPhWSRTBoah3EA6AlsR56e2GUY-64Rhsny8eo>
X-ME-Received: <xmr:s4I7and9NhgFrMU1OdoJdini1Jg1DvZT9EqZ2KZPB0IXmyyQflTZ48ZRl-hsb7kX0HELefQhjwNZjpQ4PUfFKzUGC8nLPDrFFf4tqAJ-IzdL>
X-ME-Proxy-Cause: dmFkZTEd06zime1vFCrRE7/woK7DB1pDg4FRcfMhlIWLN2Tf3bEb30ztHwRPq8cvme9qZo
    JuwxEjeFYlDCV5LMRy7UamaK5sPX+giI/UNUw0QniBa+XvMwpZ/6yFzLZiSIlnJOdnOXae
    h4k6cuUsoQnN1bIi8G8kJ6LNPEVBUFDlRECXvcZIrCyhiYF+tEYOvzQQ9JJAhC1R//4+6+
    qehAuSB7RNwg46aoYAIp31gTALjY7iN5EKQhumgi7NJYfugxT4+WXKNKuNRepOZF+t9T78
    vDxDbRKWn9NyBakqmagB+FGgX1NJokeCebRh5Teq9VfsuX5wYwEVBjWyQyTAyjQf94cqsG
    wu28dp0N6yJk7XmY0C7+aTXfUyxBs5QAAqLAxSzx2TioGkEcOQZTkNDE4xadZGDgRxaC+h
    /issPtuguAxfXNUKUiAAHYas3s72gH7M2Mn6WdBLX1CtLDXmy9EvCDg+Bv8sQv+Xt0Tni3
    2xjTf5OF6KOYHxq2pqk5jvMHf5daRhklicbtjmJW3s9B7AdTsnDwxGFiRte+PbBskovu2M
    kEh5uc90TbIpyEbXcULo25akX8xDzo/2iX7V4vk11Pmqwk9FAOGLSjOuH4lggkQRlkDzr5
    DOvI2fd9Jkg6QVfiSJCWENAmztnutdpIGGFJB9IafzV/H7FXmMXSiASPUJRw
X-ME-Proxy: <xmx:s4I7ak_ZaghvEWnuMLMWBkM9EuD01awlE0Z1Df6v8EVr4H4yA7eZjw>
    <xmx:s4I7ajn88NXbzv1kUIvvBCXkv0VbiVAXWA8Rpegtx-1FaPh1D67fOQ>
    <xmx:s4I7am8bVJcbCpmsc3439ofSKUBlNoxAncaiNb7u5D7xcx3goYRCIw>
    <xmx:s4I7ahlynPlu-vs-r8SrQf5ix7aZ6EZiqKTStvWcCWgvYs5yDFJf3A>
    <xmx:s4I7ai2g2nCWmQCqiSY22qbmDKgak-WRQNZ2vZ_9VGDUxQ4PfK3T7Lyv>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 03:09:39 -0400 (EDT)
Message-ID: <122daa5c4b8c9a2ab72a39e2285489ba15250588.camel@pbarker.dev>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] config.py: Add
 meta-lts-mixin layer
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>
Date: Wed, 24 Jun 2026 08:09:32 +0100
In-Reply-To: <20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com>
References: <20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-feXVhzAN5dh/wQBnjkGK"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 07:09:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4289


--=-feXVhzAN5dh/wQBnjkGK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-23 at 16:46 +0200, Mathieu Dubois-Briand via
lists.yoctoproject.org wrote:
> meta-qcom wrynose branch has a dependency on meta-lts-mixin: we will
> need to clone it during some builds.
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  config.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/config.py b/config.py
> index 63e8b5627ae2..438753395da1 100644
> --- a/config.py
> +++ b/config.py
> @@ -70,6 +70,7 @@ repos =3D {
>      "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "=
master"],
>      "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master=
"],
>      "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
> +    "meta-lts-mixins": ["ssh://git@push.yoctoproject.org/meta-lts-mixins=
", "master"],
>  }

Hi Mathieu,

The meta-lts-mixins repo is special, each mixin layer is stored as a
separate branch.

Perhaps we need to have an entry like this:

    "mixin-wrynose-linux-firmware" : ["ssh://git@push.yoctoproject.org/meta=
-lts-mixins", "wrynose/linux-firmware"]

The question is whether our scripts can handle multiple clones of the
same repo, checking out different branches.

Thanks,

--=20
Paul Barker


--=-feXVhzAN5dh/wQBnjkGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCajuCrREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0br+zAP4z5v9Iml8R5ApTOiJ9/OoMQcIbsSDoqWGc
rFXN4HD/iwEAgCaLIyZjQW+OVkmSpTorRp4PNkPRhc0dLD5Qf/GZHwQ=
=h+ZG
-----END PGP SIGNATURE-----

--=-feXVhzAN5dh/wQBnjkGK--

