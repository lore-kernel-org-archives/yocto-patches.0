Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13121FCD0CC
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 07:50:38 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8844.1773820229194533027
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 00:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=PMgOSYfH;
 spf=pass (domain: baylibre.com, ip: 209.85.128.68, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486b96760easo16365775e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 00:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773820227; x=1774425027; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8nxU1XS9bxW7Kaehpa16QTn6D7SGiBUbEWG2v2zNDM=;
        b=PMgOSYfHE96bRk/nAsgxOiNGjDpbSw0Rxnuw7rUVXaun/LHpLe4WD/Nadgaezbv+ar
         ImXlOJb8KYrgdLTiFVUdk1qd19pxZuOXPlIDJbzLcr33Q+GErjuuqeZxQFtu1VSU9nwN
         i47quZn1JE3WritP46VFkB9Y9zb5tTGvaXVwO5XB/n5mZChIOokgZEp/pjghWWyMglAY
         qJKT/Y7ei49zh31nI+8PmunZG4xilXHD9HcQiRo+ILMLHcqb4LQUU54KgT+k6Mkbds/a
         mFY5yNg1WAp0XeSGAVlo/G2opdG1MWOl5EZf0Ctd786Ax0hUslynfv48FhngvCUVbOqL
         aVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820227; x=1774425027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8nxU1XS9bxW7Kaehpa16QTn6D7SGiBUbEWG2v2zNDM=;
        b=pLssrk/2/qvZjJkN8z9kQCTE/yLoQgXm7kpk5XXJe1DoadIaef1Xq3yXdYG7m+ygUL
         PvJ+7Lr7C3Rv9LPhvvfRP5tLOWK9fEK54rBkwKYHq8LidxGmweXIuJQFRewxl65ZPs+j
         mjaPT70UzUJAH6vWsVRnr4dd+V+/5nTTqgFZPLoYXzqyggQBtvxoLvRT78Hzl28Jiahc
         sRfKN9pUvpAwy1Qk7jNEwsvHB27W/npfAaJILbI2f3D2VZY0s2EQM4u5P3DD391pRQDN
         GS8pdgtYyGhdt1cqGfagZpQkbeVfpwwqKJj0KV5+uynrkwvISPeaEaRxi/LvJsmPJ2wu
         gtkA==
X-Gm-Message-State: AOJu0Yy3iODm9ox2N2/M5c/7YGmoJfCOzMPVkVs4AvKkgsyb4swejuxg
	uv9lP72YuNzyVppBuzywJGMQsja+ozS+Q7cpyBk9bhne90+1Z6qHTJTe785onM6ZxUA=
X-Gm-Gg: ATEYQzxPn89FKpuX444B7qElGlpwPrNVd/Eq5g0rAiKEiBDyP0aE2HVBJXpfXT3tsi9
	A0TyR3tJQjuQCRKmvBkVkIbknx8ASYnsIXWAodyfgbyTvWx0Q+PvZnDLSCAVtnB6M+xDEybiKLY
	LumJ/my4np9XydE8svabSEdYjYF6eOGk/hdWXA4kgQ1g1LO3O0oOuR6HNPQCu0AUNl2e5cYz+W1
	2oTJ97XT1zU8FWQwMgnxpPnIxXAeMJ/MAvNLWjNq2kpSL0gzTP3zl4BWBpDlsoLr3DbfjuEBMvs
	BvLQ7x945ZS/zAixfAT6yK2X3Gp78Br/CH+ga5awhSR/Hh1v1ZRpziKrybUuYv1DACqmumTIF70
	Jw1mjjObxLDYtCRpNcuD6+3gDY3Do1YvBknbl36F4glVxHqnxRusTy3FfnwReumhEbRzFNn/TmL
	8yL2hdyGsOzUQ5PsFj+z2IczWYWqal
X-Received: by 2002:a05:600c:b8a:b0:486:f308:94ec with SMTP id 5b1f17b1804b1-486f456fdeemr38990795e9.24.1773820227303;
        Wed, 18 Mar 2026 00:50:27 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4856ea8fb0dsm224824645e9.3.2026.03.18.00.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:50:26 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:50:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, Yi Zhao <yi.zhao@windriver.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <abpXXjX8C23hL8RO@monoceros>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34vmitnfw7j3s44i"
Content-Disposition: inline
In-Reply-To: <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 07:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3505


--34vmitnfw7j3s44i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
MIME-Version: 1.0

On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoctoprojec=
t.org wrote:
> > Hi Richard,
> >
> > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> >> On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.org =
wrote:
> >> >=20
> >> > On 2/13/26 23:42, "Uwe Kleine-K=F6nig wrote:
> >> > > With SELinux enabled for the target it makes sense to have SELinux
> >> > > support enabled for the native tools, too.
> >> > >=20
> >> > > Note that for native packages DISTRO_FEATURES is filtered, thus up=
 to now
> >> > > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NAT=
IVE to
> >> > > make "selinux" propagate also to DISTRO_FEATURES for native packag=
es.
> >> > > ---
> >> > > Hello,
> >> > >=20
> >> > > I use this on scarthgap, but the patch applies fine to master, too.
> >> > >=20
> >> > > During a debug session it took me quite a while to find out why
> >> > >=20
> >> > > 	ls -lZ "${IMAGE_ROOTFS}
> >> > >=20
> >> > > at the end of selinux_set_labels() didn't show the labels added by
> >> > > setfiles.
> >> > >=20
> >> > > Best regards
> >> > > Uwe
> >> > >=20
> >> > > =A0 classes/enable-selinux.bbclass | 2 +-
> >> > > =A0 conf/layer.conf=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
 4 ++++
> >> > > =A0 2 files changed, 5 insertions(+), 1 deletion(-)
> >> > >=20
> >> > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-selin=
ux.bbclass
> >> > > index 3dc61d6931ff..0c9f52e74cec 100644
> >> > > --- a/classes/enable-selinux.bbclass
> >> > > +++ b/classes/enable-selinux.bbclass
> >> > > @@ -1,3 +1,3 @@
> >> > > =A0 inherit selinux
> >> > > =A0=20
> >> > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
> >> > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATURES', =
'selinux', d)}"
> >> > > diff --git a/conf/layer.conf b/conf/layer.conf
> >> > > index 4e04e5cc7e6a..ca981db57019 100644
> >> > > --- a/conf/layer.conf
> >> > > +++ b/conf/layer.conf
> >> > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> >> > > =A0 "
> >> > > =A0=20
> >> > > =A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-targeted"
> >> > > +
> >> > > +# With target support for SELinux it is very helpful during debug=
 when the
> >> > > +# native tools support SELinux, too.
> >> > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> >> >=20
> >> > Can we add this to the doc (e.g. README) instead of enabling it dire=
ctly=20
> >> > in layer.conf? Since we haven't directly enabled DISTRO_FEATURES =3D=
=20
> >> > "selinux" in layer.conf either.
> >>=20
> >> I just wanted to add that putting that directly in layer.conf will mean
> >> the layer isn't Yocto Project Compatible too.
> >
> > I am going to send a v2 and take over this work, already asked Uwe about
> > that.
> >
> > But before doing it, I was wondering why changing layer.conf will make
> > the layer not compatible with Yocto Project anymore. Can you explain to
> > us the reason?
>=20
> I'd guess it is from this criteria of the Yocto Compatible layer[0]:
> > Inclusion of any layer in the submission does not change the
> > behavior/configuration of the overall system without the user
> > explicitly opting into those changes
>=20
> By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> configuration changes globally without explicit opt-in of the user.

Note that the patch didn't change DISTRO_FEATURES, it appended "selinux"
to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't already
contain "selinux", this is a noop. So I don't see how this violates the
quoted critera.

What am I missing?

Best regards
Uwe

--34vmitnfw7j3s44i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm6WTAACgkQj4D7WH0S
/k5IjwgAj0jdGhT0e4eYkTzagxMcqX2/bATjf4MULU9kEEyCf2HvHEng+bnJzhPn
eBFhf1OjmparjuJTBroaqeJbTzXfqREI2jt5ntKkSBrR7AcxzSxGYPvDTt/Czv8J
VFH0fswf70oVQ5hAFTlK2AQt03gR2OcGQDOu97rOvSntyVpazN9kDy7z+VAWRAXK
2Iv9XTbLAHtAU+WdpoEFFGz0zoN7YSsg6x/yD5TF7lLQB0hEBchtKBUzQ2Ave78Y
eKNRJAPeqgvK3cTN1JPHsz2NS6S4y7Over9WJ1KbeRwrfnmGTzibfFbIqRqUKvUI
Ytcd8ScdEtMPai9g1qlvuGVNzhPakQ==
=ENNa
-----END PGP SIGNATURE-----

--34vmitnfw7j3s44i--

