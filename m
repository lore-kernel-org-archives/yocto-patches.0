Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F65C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:37:17 +0000 (UTC)
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6079.1784543836723387328
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 03:37:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=pC1EjzEI;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dxpeTEg6;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.150, mailfrom: paul@pbarker.dev)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AB501EC010D;
	Mon, 20 Jul 2026 06:37:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 20 Jul 2026 06:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784543835; x=1784630235; bh=PBT8D1K7MV
	A0vCEcOGN7WC61w510BVMlDHZWy9P6LX4=; b=pC1EjzEILi4FgnVHiJrViXyE5G
	w3ZdNfogSTXorP5M5KIgw3eK+zg8dsWNtApDlMNe22W7qzUQGj2aAwHkAcNqUCJn
	fJjGEj2x1mvjDt89vzN1jnBPOrwk2l2CSwtC9uXdGchi4VRH3U0n8e8EN5HA29J0
	YIEzisDFqNzutYKBz3uHtDlV5Lx73YtSx4OQqpd5L2lgzy7GTTRp6XMQNy+sew/4
	AkHxkp/DQLLx+4wpkWql/CUwqPWDGW9iOlgK5N5IxYyPww+9HymrVNgqeMaX9SSM
	SYGPa8JzZ5x0liBAbGuJ+YSygf3ebD5PN7DWG6zJHGiQqYErGONbND3BROvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784543835; x=1784630235; bh=PBT8D1K7MVA0vCEcOGN7WC61w510BVMlDHZ
	Wy9P6LX4=; b=dxpeTEg62BGuNsS2dt0gadRyJ+MH+9bqYZgVhdvMfIyLsEsd8Sb
	5ZtC4vawwFt6BhBpEf6X0j3S/CA/AkVHf6DxzSBMVOOakbAaEvcMg/oQvFK0deKO
	xxBArcuJm9xFkw2EOUfG7pSeGDIK0NizQWmKHU76EE23qqsZlapxvTCmhtjm0gED
	yb15TmZP7T+2Csg02GveLMMktibeDELBW5+GNRVWj1b3Z3+p6k6he/b06zxdd7Bw
	xMVIHnJnotCce0uLy2R+IDDVxH2ktZPEAUtMVC6bp+hTfNSX8A3Q0ieA0tROPfbG
	/A0mFN9eRX64Ubt9D5+x1v3quM9+tWeCtEg==
X-ME-Sender: <xms:W_pdagfUDdG0ldyZRI0lqYObAZaIZoUTz5oBv4C1J63FULZdlTE2MQ>
    <xme:W_pdap8UoOB1txcLH-nbW1xwEo7KQ21K5vUMW_yAPk4DTE_fqjm63qQuRL-Rp8QiX
    R6nlGl2F_XO7mCxDtAaXTM-gVDTVpKYLM1KIpXhHPtgwl6CzZa6Mp4>
X-ME-Received: <xmr:W_pdakkdpcVqmlG438ItGr-j9rSMWKFM2Mhoyc4CR1RXnn6FyCbnRuZ6u6adS6cjPvTg7TqImpnnyctq9rIQsMg7uqGFnnD55D7WBwhsIH2e>
X-ME-Proxy-Cause: dmFkZTFrRy7hmm3eUuJXqI7aZmgcLmA9u2W8AIJbqZTsaHPBGhVvPnikNNTAsj6GoSGP/M
    jajDNc9s/yNjo6zVHQ814x8YEUrsr0ZRh0jLIEwSQ2LOWq+vyjwkwHqpfjZg3C5bBXH2MG
    CE+Oyg9gNUBjPknWowj+1yg7B/xcLrPdIsUEGCj8cME/0RuDuUV5WHcKhK6ozWtpq2OoDx
    qiaqYEKgctU0k5GzddCcTLEdmMWTUBUQhZ2YrHi8aywCc3Q5QgXgIG22mO1Oe0FpE3vcpo
    3tRkdet+WFYVEU0UVOdm1ci4RfWKYmN7lgo2NwTbdnFmqB9GNEOhlwGKhhKOZDeSrwlQVn
    Y+F2QI8x4JLPVJQ++Kunp4MSdZcfflWKjhFj+TgERKJ3BCYSOTuwFTl5SLq8yye7Yaupl6
    BH50xKijduxqBqbXc8aLB468f0qypaFS4ik3jII4yvN+7/KaDTSldybbrjcHkfG0mZm+TG
    wpIw4J8SBtnsYUHCh7M8ChSn2dM5Vx9bq81OziWN++as5A3zSFV1WZIkaCjjbmCc81q+Dl
    3nopGfHJBAsHXoKyGdjL3N9Is1vanvO3UwJYSAtWETK3i26El2U37XjE4rgndrgnzs8cQF
    VWMrR+u6j1ObXCQ/IJuHSDGBOYWCIp4vEIKlv+qrFObYERgfkLc6TeN1juEw
X-ME-Proxy: <xmx:W_pdaj-PetcGBInhDVt06Lz56XR-sv09c52PRds_8Q3Po9fFmlt0pw>
    <xmx:W_pdaqmhyPkH_VJ83Ds2BeW4He8O6_7XVMq7gOhlARFYjduEw_yl7g>
    <xmx:W_pdao1rpZQl0SYaqNS95ZooSzkxAkEKVJhpVVYjoyRhkn_ZwVBR5A>
    <xmx:W_pdatqG9cK6IPQ37Bo1LZLM3qg2YkMmZuOtPKv8ryw__STSG6_6tQ>
    <xmx:W_pdalPeNaKu3vBBQtA5Cogj6hWgg_X6Jb-KcXGdR9mWXfPCvTbsBcRy>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 06:37:14 -0400 (EDT)
Message-ID: <44c06d871d07e71812c83752f6cfe6d6c52cbf0d.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo] [PATCH] linkat: Fix AT_EMPTY_PATH
 handling
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Mon, 20 Jul 2026 11:37:11 +0100
In-Reply-To: <20260717131943.3386262-1-richard.purdie@linuxfoundation.org>
References: <20260717131943.3386262-1-richard.purdie@linuxfoundation.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1Y1Va+eP+jlAtPtuaFqR"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 10:37:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4519


--=-1Y1Va+eP+jlAtPtuaFqR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 14:19 +0100, Richard Purdie via
lists.yoctoproject.org wrote:
> Currently we don't cover the case where AT_EMPTY_PATH is set for atlink.

Typo: s/atlink/linkat/

> Update the code to handle this case in a similar way to the /proc/self
> case which is similar.
>=20
> This is used by some systemd tools which OE might run at rootfs time
> such as hwdb generation.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  ports/unix/guts/linkat.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
> index 60fbf63..36ffc0f 100644
> --- a/ports/unix/guts/linkat.c
> +++ b/ports/unix/guts/linkat.c
> @@ -35,13 +35,18 @@
>  	}
>  #endif
>  	oldpath =3D oldname;
> -	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot=
_len) &&
> +	if (oldpath && !*oldpath && pseudo_chroot_len && !strncmp(oldpath, pseu=
do_chroot, pseudo_chroot_len) &&

Should this be if (oldpath && *oldpath && ... ?

i.e. if oldpath is non-NULL and has non-zero length.

Best regards,

--=20
Paul Barker


--=-1Y1Va+eP+jlAtPtuaFqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCal36VxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqy3AP0SqVYHvX2Oe+8k+Mf6dDgbvF04EH5sRExG
nAkg9xo54AEA4w3Y2NrZyQwfre9/1qO4h/3zaOL0qg/afmqt5zHGqw4=
=9Wq/
-----END PGP SIGNATURE-----

--=-1Y1Va+eP+jlAtPtuaFqR--

