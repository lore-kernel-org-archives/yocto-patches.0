Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D3103E166
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 11:13:34 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11582.1773832407585444744
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 04:13:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=NK0GsM08;
 spf=pass (domain: baylibre.com, ip: 209.85.221.67, mailfrom: ukleinek@baylibre.com)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso6760635f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773832406; x=1774437206; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsQDzI38fc6MOGDWfeixyaDEdfgj6wwKx1j260zsGgc=;
        b=NK0GsM08dm18YF92Q+CtJUPzkjEKRO0QaFYoMzLfpJ0OlyYrsOOlMJDclAix1wz4Oi
         lBGuHkw2g3JWr0si4IhvJ33GhOwCi6GdiK2ifQRitJwonTSxprAArd5wIuwhq0vE0P8I
         POR6HarAiKIt4Tj2Cuc/jtY/E9x3Yzl2CKVIzZM93eX7Oq/64hqOgG+Efj7Bec/TZHoi
         zYWBjGLVpjT4WJ1JtJLJV2qHV4ldjdQt7KVPdDjTSYCoxQpkMllyOk76OjisCwv7Kg0A
         ZCD2sVQW3TTUQ0thjlumcBDIOTuM+Ob+A/po1F5vIESG1mem5xX9HBShBvyWuCiXls13
         V1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773832406; x=1774437206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsQDzI38fc6MOGDWfeixyaDEdfgj6wwKx1j260zsGgc=;
        b=dtaPx8CiG41G1bN4EHFi2O60alcJmRCUboomOgivGxKZvX7YUGRfJIFWz0HBkJWXn1
         CfxJba3PADzuqc5OT/u/5Ozgq5ti/aPUoB4qOvUCB31EH9tpdo2hTM6AY5Dsf1DHb6Kv
         OB95H1xDbnB3WWhv6e/3FLFc1CyL1SAHv2R48wzXbYgtp4t//t7OIyLW0JZUr3QqSbyK
         z89Gw6yvSgCGLlmf35iszidhX6WJ4xYtCpiTynAW6kNDHSckLj5lXvJexR5GXL1d/x/G
         TzLgovPQ6wXQ7uY7Du8fqIQ4hy3fjzpHZ6NiolxmToZLE9EnNhStMZeUJ0WaiE93cHxd
         DTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPDC+LNNPxRWpB0M33WNOj33W7nRGPhTGS/VCXdFsir+31V4+OtgTfc8nOfggHU5E0xppquCPfkaiMfFGh@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxCk6Ar6ieBIS+E4h5nbyFBipzaW2sws77bERNc2ABmknCa/H/s
	SCiJ3PNTyMGP1HxVgC0/2ERSvy25rYm5IWHV64Op7eBSvCkum1FAPJ+Usg6/x7l8lr8=
X-Gm-Gg: ATEYQzx6ZkKFjO+L3HYcNfDQ1tRBe0qCaBha6HwF+MxB3+1o0Iui0TcXlw+HYSpVetO
	z1rBj4Rjd0BgOaXIWiWoXKsdjhXKDYT4nsoB1+gqdw/WNLb5XNA/jHBMeNsDftDRZWESAdHNrqJ
	BBzPfU8yjPeOnVOHrgX+J6jTMR2aeE5Cpv1MPbmpfn1HgX00AHwwi7o6HWg+Gl3l2/2bnjXYPRG
	emaGnxuKCZZtJ/WsKO52UiPfxZrqDPbfif268zjO77ks1bkEJxrMe4XvET1aNuVNymC6pdhhtwB
	behV/TuUDgF6ZueAwtGXCgiiOzdIsoVsmF9NaYSpDJMcQIIdTy/ui9o7bPzPlTcwrmhEQeQr19S
	rF2zR8wPJkRqa0zPRoD4Flp6BJvRSPDUtmqpwVjH2IkYGrUvGuDdQkEIpAgfM81k2GEo3qXIISn
	dAfyjp6GFaypy2l81J+nhso4e48VJB
X-Received: by 2002:a5d:5d0b:0:b0:439:df60:f87a with SMTP id ffacd0b85a97d-43b527c7b4amr4979365f8f.46.1773832405804;
        Wed, 18 Mar 2026 04:13:25 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b51892161sm7560266f8f.21.2026.03.18.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:13:25 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:13:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org, Yi Zhao <yi.zhao@windriver.com>, 
	Hiago De Franco <hfranco@baylibre.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <abqEzAjosilonVNP@monoceros>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
 <abpXXjX8C23hL8RO@monoceros>
 <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnjlq3j3jz5qbjzv"
Content-Disposition: inline
In-Reply-To: <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 11:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3512


--jnjlq3j3jz5qbjzv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
MIME-Version: 1.0

On Wed, Mar 18, 2026 at 09:12:52AM +0000, Richard Purdie wrote:
> On Wed, 2026-03-18 at 08:50 +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> > > On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoctopr=
oject.org wrote:
> > > > Hi Richard,
> > > >=20
> > > > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> > > > > On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject=
=2Eorg wrote:
> > > > > >=20
> > > > > > On 2/13/26 23:42, "Uwe Kleine-K=F6nig wrote:
> > > > > > > With SELinux enabled for the target it makes sense to have SE=
Linux
> > > > > > > support enabled for the native tools, too.
> > > > > > >=20
> > > > > > > Note that for native packages DISTRO_FEATURES is filtered, th=
us up to now
> > > > > > > it never contained "selinux". Append to DISTRO_FEATURES_FILTE=
R_NATIVE to
> > > > > > > make "selinux" propagate also to DISTRO_FEATURES for native p=
ackages.
> > > > > > > ---
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I use this on scarthgap, but the patch applies fine to master=
, too.
> > > > > > >=20
> > > > > > > During a debug session it took me quite a while to find out w=
hy
> > > > > > >=20
> > > > > > > 	ls -lZ "${IMAGE_ROOTFS}
> > > > > > >=20
> > > > > > > at the end of selinux_set_labels() didn't show the labels add=
ed by
> > > > > > > setfiles.
> > > > > > >=20
> > > > > > > Best regards
> > > > > > > Uwe
> > > > > > >=20
> > > > > > > =A0 classes/enable-selinux.bbclass | 2 +-
> > > > > > > =A0 conf/layer.conf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 4 ++++
> > > > > > > =A0 2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-=
selinux.bbclass
> > > > > > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > > > > > --- a/classes/enable-selinux.bbclass
> > > > > > > +++ b/classes/enable-selinux.bbclass
> > > > > > > @@ -1,3 +1,3 @@
> > > > > > > =A0 inherit selinux
> > > > > > > =A0=20
> > > > > > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
> > > > > > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATUR=
ES', 'selinux', d)}"
> > > > > > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > > > > > index 4e04e5cc7e6a..ca981db57019 100644
> > > > > > > --- a/conf/layer.conf
> > > > > > > +++ b/conf/layer.conf
> > > > > > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > > > > > > =A0 "
> > > > > > > =A0=20
> > > > > > > =A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-tar=
geted"
> > > > > > > +
> > > > > > > +# With target support for SELinux it is very helpful during =
debug when the
> > > > > > > +# native tools support SELinux, too.
> > > > > > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> > > > > >=20
> > > > > > Can we add this to the doc (e.g. README) instead of enabling it=
 directly=20
> > > > > > in layer.conf? Since we haven't directly enabled DISTRO_FEATURE=
S =3D=20
> > > > > > "selinux" in layer.conf either.
> > > > >=20
> > > > > I just wanted to add that putting that directly in layer.conf wil=
l mean
> > > > > the layer isn't Yocto Project Compatible too.
> > > >=20
> > > > I am going to send a v2 and take over this work, already asked Uwe =
about
> > > > that.
> > > >=20
> > > > But before doing it, I was wondering why changing layer.conf will m=
ake
> > > > the layer not compatible with Yocto Project anymore. Can you explai=
n to
> > > > us the reason?
> > >=20
> > > I'd guess it is from this criteria of the Yocto Compatible layer[0]:
> > > > Inclusion of any layer in the submission does not change the
> > > > behavior/configuration of the overall system without the user
> > > > explicitly opting into those changes
> > >=20
> > > By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> > > configuration changes globally without explicit opt-in of the user.
> >=20
> > Note that the patch didn't change DISTRO_FEATURES, it appended "selinux"
> > to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't already
> > contain "selinux", this is a noop. So I don't see how this violates the
> > quoted critera.
> >=20
> > What am I missing?
>=20
> I guess it would depend whether any of the functions/variables in core
> have hard dependencies on that variable. I was assuming that they do
> but that might not be the case, I'm not sure without checking and you
> may be right.

Wouldn't that be a bug if a function changes behaviour depending on
DISTRO_FEATURES_FILTER_NATIVE containing "selinux" or not? (Apart from
having "selinux" for native packages iff the global DISTRO_FEATURES has
"selinux".)

I grepped for DISTRO_FEATURES_FILTER_NATIVE in oe-core, bitbake and
meta-openembedded, there are only matches in the first and these are
about default settings, appending DISTRO_FEATURES_OVERRIDES and
providing a filtered version of the global DISTRO_FEATURES for native
packages.

So unless I missed something, I'd claim setting
DISTRO_FEATURES_FILTER_NATIVE:append in a layer doesn't result in a
relevant change without an explicit opt-in (by adding "selinux" to
DISTRO_FEATURES) and then this (implicit) v1 is better than the v2 that
Hiago sent.

Best regards
Uwe

--jnjlq3j3jz5qbjzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm6iNAACgkQj4D7WH0S
/k5JuggApvKBe09NCOQatyGHnNUeJBuxXXIOBUrWBEZq9HVbur2Xd1n7uPqXDQGR
HuJnepd6MJeiijAHTC5R3iBHzZ20/ntrVoMPME8YwjIOFzvduaB/FGjiOGS4bBCq
+veAeOYFT2pHv8VGIL7CAyLy1lvtNoVHg9CqbvsUDQ5nMXvdiGG0S1lvBoZ/cvcS
+dv2ObFVpYFz9m4Pzwd3DDcEW/Lxk3Eiq4yE3iPg8xJBqcH/1wtLeSnMU6oFn8qt
fAGdqCZypgT5awGtZoj0NeG1RNoHjCBVA7jc3HIG0P/502bnKomYMqZHdLkMybAp
XJlbfM3jl0E7PTudTzeuVfVQpSsrmA==
=9vn/
-----END PGP SIGNATURE-----

--jnjlq3j3jz5qbjzv--

