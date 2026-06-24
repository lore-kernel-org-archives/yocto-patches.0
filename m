Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A5CDB470
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:22 +0000 (UTC)
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1519.1782285195368903224
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 00:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=A7cOGbXO;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=hCLYeTOP;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.148, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 75F53EC006F;
	Wed, 24 Jun 2026 03:13:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 03:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782285194; x=1782371594; bh=0b6JeuLYTl
	mDSnx8ki8bYd1083nZwH/LjMNpVbyWPWU=; b=A7cOGbXOySGlQGyeODUMwjHY/2
	xgzq0o/UHl34/xCvXSodEoNq93DZoSEl3Crs6LUVXQXvVmG3btfv8lBKo4fjUOzB
	GQ2kLwl8beKSN6a+tx4xvub+UrIFbVwHZxlud5kw3k8Ug6lbw4FskNWXdoAb1Xqm
	GxLZCyWE7JDVGibf4QbxsNUXe8MFVbGd41zS2U9j8gj4mqXBuE3S4enT6D5TIGfF
	wC/vocIfCKsABo8HAtngNUtNShq4d9nHfh+Yt+Zl/sWOPbD210qahp41RlBN2/ur
	ftYcxODfoNu8ENOug1x8GKxgitQtxilPsTVq/8CcuSA8OyH8ivXNgKot7uig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782285194; x=1782371594; bh=0b6JeuLYTlmDSnx8ki8bYd1083nZwH/LjMN
	pVbyWPWU=; b=hCLYeTOP6tIYK0f9uUchGyjqaY8wIZz+nYxd7Uqj1cnwFVK4HBB
	cKiZIDVr6ZrpPeS76AvhTwCV4RT12xM5wvt368prN+/p4MzGxAXdiRe3GTrrnEYn
	ATpk+Bqrr2nCqrx57QAOfh3U/cKB7J/dLMUlrudvct6spw8wTKBqFxVyz34PFHG1
	JAKu4+293LSVOJMnBBSuvUy6NDNUCLFp8r0j/gA9/j8H6WHgS2puAP9ulneEzByh
	jfPAxNIP8zDYeFV5n2l++Oq/+n/G/Ydh1gUv1pHUWypMDYv3tbplYxhUQjXEs0Me
	cX3o1M+7u1yNGoogdacH+e96mSBL1XsL0EQ==
X-ME-Sender: <xms:ioM7aguVsTOKzm5md66og35m7kLPRTSw35NsdwcNxNC36sP9zO4TpQ>
    <xme:ioM7ak5PejB3WwVyV4pzf-bm1L_0qs4xksJpWUMLaiDTbbsRDAphvJiOHfSnBmwS0
    hl1P5tasPIHaqZzGZkiLCdm3x9A-L-Utz_BJeZfwr38kwe0KH4M8h4>
X-ME-Received: <xmr:ioM7apLguXsTj914bU9KLKSx3f1rL8nJmyBMV6BZcx-27aWhyh8ThAvk2tQ5cLMTyHOosFXuVHUSalTQaJ-Xcm8CBj8-TmjNi15PfmvQWkyw>
X-ME-Proxy-Cause: dmFkZTGKnAqksqlwXt9Kbu8ePPfnaq6TQZcKJvkfutYR1CbTawSDq/X5ctwyzUK9HmaA2e
    +OC/DI/uf7PGmRKZMYvHjnaoNJIhOVPHonn6+BSMaZ76wFqfdNQn3v0gZbHiB2UUGqVnnf
    HmJLHmNACXz2n9nUn49N8ccq8bXLegqc7DqAfx/2slbU8xyp75Y2jhKvIObwimwK5AWi2u
    dQlUTPdpjaNSY0X8Rr+/xnkGaH5aNL1Ds8NcLxXpl+9T7KKKtPMpFGICpHE4xrDeHN33Gu
    zPmpWsmGdkZgxgi1PuBR05gij70y0HDFAql5p+XyWJoDzUYjnvg8xKEMKtrEPyDNQci7LS
    axr6xdwhoqcLJTYbXKZuICCdZfGsTQpXq7up5AVHcPLr2R1S4nDMko87mOfm/XajUb/Dow
    IAzzsJJ4K0RP1uPfrUAGMiiAPhPfLBZ+1AX3DUolkbwzaP28OGoz75IgEZVamYyqb2aq7w
    QMwdivLHsmviQh9XCE1R5ysvvA9AcFlnjNq0FSfMwipocwQdvUU6YR+hd+8yyixY9HXXPf
    A2MafI5krIqq4Zs/ESOLhKslrVT3Km3x2V4cLaDCxVHexPimo3+O1k0I/K6PJCK2NEEg8O
    GAV3Mxbsww6Dj2uwdzPIoKg6jEPBq1Ol46mb5GqbWwx3WW7LowYD7Nonl/mg
X-ME-Proxy: <xmx:ioM7as5NSjkTclLg4eGg593m4sbkdpGXoS3ZIaw3rDCIuBgYk4kkuQ>
    <xmx:ioM7akyw0-6u-4LjPC-yO1FhMMrsxuQfObQ815vynqY_YigV7R6tYw>
    <xmx:ioM7aobZJ1l7GOVsYgZ_tZm8H4ZVSVwAU6RNYRdKOTTmoxl17wFSWA>
    <xmx:ioM7auQLwez6-ChEYQ8I5Fiu9ylyhKnvuGmqkwmXJ21pB4rSzRtfLQ>
    <xmx:ioM7asQ1ssh463vUBdRdSkfBFggj9sys6fUPpO6oiTgQpkpgIWi9taVa>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 03:13:13 -0400 (EDT)
Message-ID: <06637e0dcd24f27d67122158982fc84678121e5a.camel@pbarker.dev>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper wrynose]
 config.json: Add meta-qcom dependency on meta-lts-mixin
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>
Date: Wed, 24 Jun 2026 08:13:10 +0100
In-Reply-To: <20260623-contrib-mathieu-wrynose-qcom-lts-mixin-v1-1-78465e9bec56@bootlin.com>
References: 
	<20260623-contrib-mathieu-wrynose-qcom-lts-mixin-v1-1-78465e9bec56@bootlin.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ibw06KoEQOzBbl3dl3cX"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 07:13:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4290


--=-ibw06KoEQOzBbl3dl3cX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-23 at 16:46 +0200, Mathieu Dubois-Briand via
lists.yoctoproject.org wrote:
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  config.json | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/config.json b/config.json
> index 6b37eb96254f..c18c7de80f91 100644
> --- a/config.json
> +++ b/config.json
> @@ -1313,7 +1313,7 @@
>              }
>          },
>          "check-layer-nightly" : {
> -            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws"=
, "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "met=
a-clang", "meta-exein", "meta-qcom", "meta-riscv"],
> +            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws"=
, "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "met=
a-clang", "meta-exein", "meta-qcom", "meta-riscv", "meta-lts-mixin"],
>              "step1" : {
>                  "shortname" : "Test meta-agl YP Compatibility",
>                  "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/me=
ta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta=
-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python -=
-no-auto-dependency"]
> @@ -1356,7 +1356,7 @@
>              },
>              "step10" : {
>                  "shortname" : "Test meta-qcom YP Compatibility",
> -                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom -=
-no-auto-dependency"]
> +                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom -=
-dependency ../meta-lts-mixins --no-auto-dependency"]

We should run yocto-check-layer-wrapper on the wrynose/linux-firmware
mixin layer as well as on meta-qcom.

>              },
>              "step11" : {
>                  "shortname" : "Test meta-riscv YP Compatibility",
> @@ -1996,6 +1996,12 @@
>              "branch" : "master",
>              "revision" : "HEAD",
>              "no-layer-add" : true
> +        },
> +        "meta-lts-mixin" : {
> +            "url" : "ssh://git@push.yoctoproject.org/meta-lts-mixins",
> +            "branch" : "master",
> +            "revision" : "HEAD",
> +            "no-layer-add" : true
>          }

Based on my reply to the yocto-autobuilder2 patch, perhaps this should
be:

    "mixin-wrynose-linux-firmware" : {
        "url" : "ssh://git@push.yoctoproject.org/meta-lts-mixins",
        "branch" : "wrynose/linux-firmware",
        "revision" : "HEAD",
        "no-layer-add" : true
    }

With the repository name changed in NEEDREPOS and EXTRACMDS above.

Best regards,

--=20
Paul Barker


--=-ibw06KoEQOzBbl3dl3cX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCajuDhhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bjciAQCtWUV7CANT401E/ko3uUfZM1+1v/Soygwm
8WL+9T3rNAD9EaEB99IZr+ZkTeWT8Jiyi6bXj+7YmZ5YUrkqTIwqXQw=
=UI/p
-----END PGP SIGNATURE-----

--=-ibw06KoEQOzBbl3dl3cX--

