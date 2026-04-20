Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C56F557F5
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 09:30:54 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15969.1776677448730276170
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 02:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=h5aXnn1r;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1637FC5C990;
	Mon, 20 Apr 2026 09:31:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 480E15FFA5;
	Mon, 20 Apr 2026 09:30:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B88FA10460C08;
	Mon, 20 Apr 2026 11:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776677445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=5zD2np2uWQ7BTMCGZVnsLknAAQqlyKWYHY1u5BHhUzw=;
	b=h5aXnn1r/p0TLjjAH0UfCo3zK6IDB04AnMnJztRG0leGVR9yuOwsmAlMeQC5O7qCBUFPCN
	/DhJVIPhLhvdJ2LeJk73dEC7XNxH9/W2uyNc8YPzxCm7WYJy5fzt52p2IVLX09oyPZA1eu
	oe2Piv3brDP+cro5o5SYTYLxaxutICZ8S450MIvVXaHFDu1a73FVJiAM6Qrb5eYN8dCLAJ
	FXCGPzkoFGENQ9hk82cQJF9ukkKcb6d6v7cihZ6YJdiEwg1nyf2EIsYjWHrNereaiaMf3s
	/qEkJmSpw9YULlFY1wE8CPE1a2VJxznUFXb290AYbkGk2Cat9zGlvjGNciFYWg==
Message-ID: <67d4c3642fdbd5c1aea60667dad6856374658fd0.camel@bootlin.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH]] libsepol: disable LTO to
 fix buildpaths QA failure
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Yi Zhao <yi.zhao@windriver.com>, yocto-patches@lists.yoctoproject.org
Cc: thomas.perrot@bootlin.com, thomas.petazzoni@bootlin.com
Date: Mon, 20 Apr 2026 11:30:42 +0200
In-Reply-To: <031bf8f6-0b96-4ad1-8f84-8f9ba01acb55@windriver.com>
References: <20260328155821.407004-1-thomas.perrot@bootlin.com>
	 <031bf8f6-0b96-4ad1-8f84-8f9ba01acb55@windriver.com>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Mm+6ViBgekR6Qnm+RRzl"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 09:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3733


--=-Mm+6ViBgekR6Qnm+RRzl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yi,

On Thu, 2026-04-02 at 16:31 +0800, Yi Zhao wrote:
> Hi Thomas,
>=20
>=20
> Could you please provide the build steps to reproduce this QA
> failure?=C2=A0

To reproduce it, LTO is required to be enabled. For example:

DISTRO_FEATURES:append =3D " lto"
require conf/distro/include/lto.inc

Kind regards,
Thomas

> I=20
> can not reproduce the issue, even without applying this patch.
>=20
>=20
> Thanks,
>=20
> Yi
>=20
> On 3/28/26 23:58, Thomas Perrot via lists.yoctoproject.org wrote:
> > From: Thomas Perrot <thomas.perrot@bootlin.com>
> >=20
> > Fat LTO objects in the static library embed original source paths
> > in
> > .gnu.lto_* IR sections. Unlike DWARF output, these sections are not
> > affected by -ffile-prefix-map, causing TMPDIR references to survive
> > into the installed libsepol-staticdev package.
> >=20
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> > =C2=A0 recipes-security/selinux/libsepol_3.10.bb | 4 ++++
> > =C2=A0 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-
> > security/selinux/libsepol_3.10.bb
> > index 0423a2a6ea31..0a51aba28ee8 100644
> > --- a/recipes-security/selinux/libsepol_3.10.bb
> > +++ b/recipes-security/selinux/libsepol_3.10.bb
> > @@ -13,4 +13,8 @@ inherit lib_package
> > =C2=A0=20
> > =C2=A0 DEPENDS =3D "flex-native"
> > =C2=A0=20
> > +# LTO fat objects in static library embed original source paths in
> > .gnu.lto_* IR
> > +# sections which are not affected by -ffile-prefix-map, causing
> > buildpaths QA failure
> > +LTO =3D ""
> > +
> > =C2=A0 BBCLASSEXTEND =3D "native"

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-Mm+6ViBgekR6Qnm+RRzl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmnl8kIACgkQn8ALBXH+
Cu3nDAv+NDcX7gbBGtnliZUfKyEAr53kbzd0d9NPdOq2rmO0hGZ8AK5GYJE7KJSE
w+eu/nyJQsSUDkEP9bfIMQ6uANaA7QvS8GVNmJl3jWNICo4lW/sJB2MLpAf86TYf
sE8/eU6Ax1ppHekImEhjmXKI7yz9dHCyQu7LKjxBfTGaGJobZVCY/3Pzcj6GXmBn
Eb4onTO96TPKqp/HsaRofNVroum67wiuIY4cc942ZloJytwWeytEl8SkPzm6drh0
wWtua5K3I7WztspWkgkoWCs5zq9dGn9xgFOR8HjAJNJ4deyrmSiK+nq9bg5xJZPn
RvUu77maWnTrWchn7iqFnHrOh7+z0GQGnlzlV6rMRMC9xuouiadxwZDm4g1m/jqx
9EfF8a9O986qz/dMJ1GbDBMZtcYGyvlvOmvrwH1EQwTDMjNppFn6Uj6C/aWxRF25
2hBgapCPhXpi2CSdGSUORGapwyStcqXZjrzK0K8IhcHTQZf4Vlv+dOQ/OfD+q39g
+qK0c1oy
=tKgD
-----END PGP SIGNATURE-----

--=-Mm+6ViBgekR6Qnm+RRzl--

