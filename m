Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF464CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 10:12:03 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.126443.1781518315742469801
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 03:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=PaVj9pmW;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=U2vTsRM/;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D717C1D0017C;
	Mon, 15 Jun 2026 06:11:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781518314; x=1781604714; bh=Ww7HoqD9Ke
	IpHrqyMDX1AGzy+d2s+zsB10jt90Qv0sg=; b=PaVj9pmWnI+9HXySTwgSqBhR0z
	zd7srVbRSP1Q1a3CzTuZ9F5bldAkqr/58VP7LLzHVCwzSFF8TTgR/KLKTwbWyu3c
	qYntCXNAA27OSwKMOErNVqHUdM/ku8AJnt8vuDX1AJX6FZ1gv9LPYNoBE1rtld1B
	QoDRlMNembhYoAzPv4rPiSJdO80K2X/S4QqwfZzaXRYH/TBNyaUuVUabE0tOHW6Q
	edv4plmO8Pf3KtA3V+J3ab1lJ5FIldcrOiyEfvjSnouhq70bQ89wfpHbQGVhlTbI
	HvywHVzUX06ncuMoi1tKKsqP6az1ouEJdEKnjBHhjilGlvdwX2VKKkige6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781518314; x=1781604714; bh=Ww7HoqD9KeIpHrqyMDX1AGzy+d2s+zsB10j
	t90Qv0sg=; b=U2vTsRM/cCzQGCV9tpTsbmQ4V4248J4m9uxqqxVLXQzVgaFc8Zt
	eWh95Hkq0HEQpGBoOiilgxILGS8Px9BiHUUbytaMBaNUveax42L/I3NZjr23VOu/
	y8dtEXIHTeIPRka4Xl0uH/l8pUGEie03TWVP+tCXeL//pYEJMGzZ9ECsTe5J8I1Z
	byyDAxqo8Z5OEwwMpWY5d5gDLD3CExWb2m0FRDHMGQDRmiJGRqkeXPSjDywwqdIe
	1uoHGRuXIawifa0CLKpwp0gMrSQNNsRwp7QcVqwYwFdT7RkOfSwOVCsd3ZIK4UxD
	ZB4Hj9bnxl6qNaIG1uBXDayaH8U6rjbOuNg==
X-ME-Sender: <xms:6s8vaqL97cAkd9cq6TMBStDnB0yHVZNiLpsNIVuWa4M1W0znc1in-w>
    <xme:6s8vapJKu6cXFXU3WonM9ibe7r5tbPIsA49Z9Rra7s4fn9AAEEtiA2hDhhk5KKovO
    ekeGJx8YWR-b40xOyIkEdQzGiKxXC0ly6g8BwtYFxqCPrE4tIfCHg>
X-ME-Received: <xmr:6s8vavv5P3iluVYU7WgRzMR-OecQDQMfUIqFUnmjPmcQJRexyGT5ryipKsKBMm__BiWmj2HQUPcXvJ0c6UqgChCqSrMeePJcEo3eThtiI13o>
X-ME-Proxy-Cause: dmFkZTEwGrfxhoDX3gul4JMBBQUJvBVDz0Ty10SbdQsgQ5Rdw9nLj7ktlKwsb1quijz1pb
    G0O+ymmhQO+VSGTB+AdM3FG2zQ4pXMVnGlHJ2COkvNt2PGj9enuFAjI+lqFZ93yZ+zOED2
    8mFUQzerNKpWe4QOFrLd5fWRCGciioVPI3EAPlGUNxauBiGTL6+2yeIbPxGkOpSHZqZhs/
    mzEQfOTubCn4vz2yho+sOJs0lhDDW7mmyuuSJxzZ0KJbGVwimPr7SaqfHhHJ/5EHGLV8kG
    ClPK0xGeeM6+z0+yiQ7nxbDAzmXq2FlhMp+JNmmFqWaCyaWvKpSr22h5aGA6XNsp9JwDSS
    +6+H8HPTlKWkU83wpP7AXfGD8VZSnHA+E2Wtbq9jlRTlsh5k0XayCT41NjyQa2CFVud1Kf
    jkV9DIz9Zg6QPFOhZ6L0HHAb3Q4qXKbeV+LuemoUDh94CRyaH9umTEuMaOBcSp7PX7uf6L
    koIFdAc/GPLg0whCk7zWC99L5QLeCKURpcptr4uJ3qpmSWfdtvhmnCviuJni6X4j8Uqei3
    43o3+b948RmjUpkg8q1t6lXvBv88XEuU1thLvbgGbDMVPAVdeww6huzyHXHHCXMlWsqpGm
    33hC4nvl2Je4IoD+pgmJNnFmLHvpXLETTtXyWNi03OlSzD9ucf5yISEYzVIw
X-ME-Proxy: <xmx:6s8vauT_WKRwt-r6NSJ9UCPo2iVAfp95mF7Ns-_YXJ7e20jlZp9Wmw>
    <xmx:6s8vatMBPTu0NzNu3ByUjUpFuOiLp4TLDDLUu7W5z183VngZO82rXA>
    <xmx:6s8varamt__yGQ3z68I9OeRq37Negn_PqcmOgSoHd4xC56vpAOgLTw>
    <xmx:6s8vavySrOzUits9Y47TkLUu_0_HO1K9kTi1G8Lt4PlNYYxY6OOFuA>
    <xmx:6s8vaipK0XbpxjzWMPLF1anR6IPzqVglN-qlVT2lt3NKYkrZognVK8Hj>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 06:11:53 -0400 (EDT)
Message-ID: <3530cd67283e86e8bb942dd878e7e5d78cb574fd.camel@pbarker.dev>
Subject: Re: [yocto-patches] [meta-lts-mixins][PATCH v1] bluez5: Backport
 BLE Channel Sounding (CS) reflector role
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Date: Mon, 15 Jun 2026 11:11:50 +0100
In-Reply-To: <20260615093350.1170306-1-prathm@qti.qualcomm.com>
References: <20260615093350.1170306-1-prathm@qti.qualcomm.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JA6BDWOTyR9gDWAaOUBt"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 10:12:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4225


--=-JA6BDWOTyR9gDWAaOUBt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-15 at 15:03 +0530, Prathibha Madugonde via
lists.yoctoproject.org wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>=20
> Add 16 patches backporting the CS reflector role and Ranging Service
> (RAS) support for BLE Channel Sounding into the bluez5 recipe.
>=20
> There is no clear upstream BlueZ timeline for this feature; patches
> will be removed once the functionality is merged into the BlueZ version
> shipped with Wrynose.
>=20
> Signed-off-by: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

[snip]

> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000..cdbb030
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,57 @@
> +meta-lts-mixins - wrynose/bluez
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +"Mixin" layer for adding BLE Channel Sounding (CS) support to BlueZ in t=
he
> +Yocto Project LTS Wrynose release.

Hi Prathibha,

There is not currently a 'wrynose/bluez' branch in meta-lts-mixins.

If you'd like to create a new branch, please send a request to the main
yocto list (yocto@lists.yoctoproject.org) to request that, with an
explanation of what it will contain, why it is needed and who will
maintain it. As an LTS mixin layer, the policy should require patches to
be merged to master before they are backported.

A layer backporting a single bluez feature is unlikely to be accepted
for hosting on git.yoctoproject.org. You could suggest a layer for
something slightly wider, such as new bluetooth/wifi features.
Alternatively, you could carry the patches in meta-qcom if this is
specific to Qualcomm hardware.

Best regards,

--=20
Paul Barker


--=-JA6BDWOTyR9gDWAaOUBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCai/P5hEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bs4dAPsHCAh1H2Pz3Q9SFMKOPsRZwsjtKnqof+Nb
TtGn9Rw4MAEAtBiO/bEW9X9ur5qPJHoJy8Jog481et9mqIPTZIRD7QE=
=Ypou
-----END PGP SIGNATURE-----

--=-JA6BDWOTyR9gDWAaOUBt--

