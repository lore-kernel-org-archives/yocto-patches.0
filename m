Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C1E103E171
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 12:37:55 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12968.1773837467021049529
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 05:37:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g7ORTGPu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so57263955e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773837465; x=1774442265; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ksI/BlTJFO/RjV9zGI/DTb7R21u3OkzOTbzD1OdajwI=;
        b=g7ORTGPu2hrpmJTLEiIxR63kFz+SMHJVnr5HpIG05aEukopJpqYe0RtgKeKqvrEGWH
         MqdL/SyI1N8tfRuUMkziMAzMProBS897xlr5cS+GiZvik36o9VEArYmOsTKEkCSXPoHs
         UqWdT03hg3eJ6//qv5NOzeNMg31clvO+qYB+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837465; x=1774442265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksI/BlTJFO/RjV9zGI/DTb7R21u3OkzOTbzD1OdajwI=;
        b=acxJxKKG50u5pXw8ngOMz9VmCrYKnJ9rbWLXJqnqqyvxNCpvnBjTtgmewLMPru+0i5
         6ODM4/R2VmSzHBCUnZw+UnBUz7wh4NphHh+r7ONYRod+Wo48pdDbNFrCo++GVTNaUlSe
         X9gGmXYHl8h/S5tf7w7dqwlwakGfjMHQBW70bjusmXSW33s/b8G+K4vyeyKVZK7J0ea+
         In8DFRat+tmqHLsAJdmjxlM8j0P30IVTZ07aDdJqkCdp0wnMFd7Zmllp9jejU4/le74W
         bosFahP9qMIcY1qEMjVh10FhSHBLDI0MOo9cPTfUikGzROIn7NbRM6qz2QYNbBZWq6XI
         BZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWPStQYWahzkjyYZOOENKnM7vaaGz3pGEaqw7d1ykfI1VMUiilNWDVlQrn1dA8ILLpIcvU2djgEt5UQzHjN@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwerI/NCd56IJN9xBaaaO+Mx7gXC1L3/y7AbZWD5lsUF2+PamL3
	5FkKol/drV54/ZMeca/+q4y+rJ8fzkhlpBh2fLoAxTjx/WnzL+Nj8YldJFN8jITefZnKterWMcY
	Ju0Nc45c=
X-Gm-Gg: ATEYQzyOqBYw17mMKyix4vYrp9WZrIlQfwjHfS1o2H7WhAnw8kddFKkSrGVF5bYs42d
	otpM7bWw15HQqps0/vYpi3aZjF06YMRCTX4OY4N3fRG1oEuV6TjmgHtGU+AsX1mcw3OYSP4pOxE
	i0WxX4OluTeT1P8ldM61489D/D+89KS3Yp+UE0qxQRMbZ/Nx/JC7AkDDwcl0aLyW5+iclZruA+O
	ER0R0fqhLZoV3UZx+n3PFpkOAL4v7kLY2WnTCTSF+E8JupA1m7ZC1G+KqvaTAe2HSHvV91XWNEn
	7lgQ+IfCEqFvfE/gDM2Auf18OIoKUOEo7NvicSwfUyW1cp2Izlle0Cp+4kL0TlPO+tL6xMgPoqS
	0Jglk+9y6DH1YDch8hx081jmPNNLS2mTUF0uP8ggS0Dn3ydRqaBznecVQcY/tX+XfhiN30osi+7
	6+/eUscQmVsPW7f7noAcvmZSQT3yiTBvqGHHEUB/mhmTwfl4Dk2QT551djcRb8S/dzq+rHFaLE+
	ilwQwaMt6omD5TlD3OGf322cA==
X-Received: by 2002:a05:600c:c490:b0:485:f1d1:8f29 with SMTP id 5b1f17b1804b1-486f441b9femr59933535e9.2.1773837464917;
        Wed, 18 Mar 2026 05:37:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c5d8:efeb:ae8c:c686? ([2001:8b0:aba:5f3c:c5d8:efeb:ae8c:c686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7830516f8f.25.2026.03.18.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:37:44 -0700 (PDT)
Message-ID: <d8f70ee878b8101ef7a5f1b11c1bb52aa172c89b.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org, Yi Zhao <yi.zhao@windriver.com>,
 Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 18 Mar 2026 12:37:42 +0000
In-Reply-To: <abqEzAjosilonVNP@monoceros>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
	 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
	 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
	 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
	 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr> <abpXXjX8C23hL8RO@monoceros>
	 <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
	 <abqEzAjosilonVNP@monoceros>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 12:37:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3513

On Wed, 2026-03-18 at 12:13 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Mar 18, 2026 at 09:12:52AM +0000, Richard Purdie wrote:
> > On Wed, 2026-03-18 at 08:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> > > > On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yocto=
project.org wrote:
> > > > > Hi Richard,
> > > > >=20
> > > > > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> > > > > > On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproje=
ct.org wrote:
> > > > > > >=20
> > > > > > > On 2/13/26 23:42, "Uwe Kleine-K=C3=B6nig wrote:
> > > > > > > > With SELinux enabled for the target it makes sense to have =
SELinux
> > > > > > > > support enabled for the native tools, too.
> > > > > > > >=20
> > > > > > > > Note that for native packages DISTRO_FEATURES is filtered, =
thus up to now
> > > > > > > > it never contained "selinux". Append to DISTRO_FEATURES_FIL=
TER_NATIVE to
> > > > > > > > make "selinux" propagate also to DISTRO_FEATURES for native=
 packages.
> > > > > > > > ---
> > > > > > > > Hello,
> > > > > > > >=20
> > > > > > > > I use this on scarthgap, but the patch applies fine to mast=
er, too.
> > > > > > > >=20
> > > > > > > > During a debug session it took me quite a while to find out=
 why
> > > > > > > >=20
> > > > > > > > 	ls -lZ "${IMAGE_ROOTFS}
> > > > > > > >=20
> > > > > > > > at the end of selinux_set_labels() didn't show the labels a=
dded by
> > > > > > > > setfiles.
> > > > > > > >=20
> > > > > > > > Best regards
> > > > > > > > Uwe
> > > > > > > >=20
> > > > > > > > =C2=A0 classes/enable-selinux.bbclass | 2 +-
> > > > > > > > =C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > > > > > > > =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git a/classes/enable-selinux.bbclass b/classes/enabl=
e-selinux.bbclass
> > > > > > > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > > > > > > --- a/classes/enable-selinux.bbclass
> > > > > > > > +++ b/classes/enable-selinux.bbclass
> > > > > > > > @@ -1,3 +1,3 @@
> > > > > > > > =C2=A0 inherit selinux
> > > > > > > > =C2=A0=20
> > > > > > > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')=
}"
> > > > > > > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEAT=
URES', 'selinux', d)}"
> > > > > > > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > > > > > > index 4e04e5cc7e6a..ca981db57019 100644
> > > > > > > > --- a/conf/layer.conf
> > > > > > > > +++ b/conf/layer.conf
> > > > > > > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > > > > > > > =C2=A0 "
> > > > > > > > =C2=A0=20
> > > > > > > > =C2=A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolic=
y-targeted"
> > > > > > > > +
> > > > > > > > +# With target support for SELinux it is very helpful durin=
g debug when the
> > > > > > > > +# native tools support SELinux, too.
> > > > > > > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> > > > > > >=20
> > > > > > > Can we add this to the doc (e.g. README) instead of enabling =
it directly=20
> > > > > > > in layer.conf? Since we haven't directly enabled DISTRO_FEATU=
RES =3D=20
> > > > > > > "selinux" in layer.conf either.
> > > > > >=20
> > > > > > I just wanted to add that putting that directly in layer.conf w=
ill mean
> > > > > > the layer isn't Yocto Project Compatible too.
> > > > >=20
> > > > > I am going to send a v2 and take over this work, already asked Uw=
e about
> > > > > that.
> > > > >=20
> > > > > But before doing it, I was wondering why changing layer.conf will=
 make
> > > > > the layer not compatible with Yocto Project anymore. Can you expl=
ain to
> > > > > us the reason?
> > > >=20
> > > > I'd guess it is from this criteria of the Yocto Compatible layer[0]=
:
> > > > > Inclusion of any layer in the submission does not change the
> > > > > behavior/configuration of the overall system without the user
> > > > > explicitly opting into those changes
> > > >=20
> > > > By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> > > > configuration changes globally without explicit opt-in of the user.
> > >=20
> > > Note that the patch didn't change DISTRO_FEATURES, it appended "selin=
ux"
> > > to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't already
> > > contain "selinux", this is a noop. So I don't see how this violates t=
he
> > > quoted critera.
> > >=20
> > > What am I missing?
> >=20
> > I guess it would depend whether any of the functions/variables in core
> > have hard dependencies on that variable. I was assuming that they do
> > but that might not be the case, I'm not sure without checking and you
> > may be right.
>=20
> Wouldn't that be a bug if a function changes behaviour depending on
> DISTRO_FEATURES_FILTER_NATIVE containing "selinux" or not? (Apart from
> having "selinux" for native packages iff the global DISTRO_FEATURES has
> "selinux".)

It depends on how that variable is being used. Some usages would be an
issue, some would not. I have not checked how it is being used and what
the implications of that are.

> I grepped for DISTRO_FEATURES_FILTER_NATIVE in oe-core, bitbake and
> meta-openembedded, there are only matches in the first and these are
> about default settings, appending DISTRO_FEATURES_OVERRIDES and
> providing a filtered version of the global DISTRO_FEATURES for native
> packages.
>=20
> So unless I missed something, I'd claim setting
> DISTRO_FEATURES_FILTER_NATIVE:append in a layer doesn't result in a
> relevant change without an explicit opt-in (by adding "selinux" to
> DISTRO_FEATURES) and then this (implicit) v1 is better than the v2 that
> Hiago sent.

I'm starting to wish I'd just never said anything :/.

It would be nice if meta-selinux passes yocto-check-layer but that
isn't my call, I don't know if it does currently pass or not. I wanted
to caution that changing DISTRO_FEATURES or things related to
DISTRO_FEATURES from layer.conf is generally a bad idea. In this case
you might get away with it, I don't know. Has anyone tested it?

I am generally worried about the amount of things people "load" up
layer.conf with as whilst it seems easy, the scope of it can be
problematic as it affects other layers, and in general you don't want
to be doing that unless it is configurable.

Cheers,

Richard




