Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9704710854D9
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 09:12:58 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9960.1773825176069968123
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 02:12:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JCudnqBb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c6fc2910so5015095f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773825174; x=1774429974; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omQsVE3JjaL6s+zNiSx186Quq64xCxZ1tRsKNyGftGg=;
        b=JCudnqBb6xCwdmLfAVPZcXg0mAGsNHRvncqenmJx6XjXxcP47awsLeOfRXpfj4gn9v
         hMEYREGMc8+xxxqcXTQ26p4BBhDB8W5kYRyNd7F5iMjdd6LQrvirMf5oJgkWd+t2jOti
         Tu4GEPtZJNUnNNUVoBmlV8pNxfZbFjA9d3CBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773825174; x=1774429974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omQsVE3JjaL6s+zNiSx186Quq64xCxZ1tRsKNyGftGg=;
        b=Iso7/bdL5FxWZ9PguCfWVnRripD7ER6h9AbAA6QreSIJsCbH/+DnqNVxfitvn1DDB1
         qMEtzNbr93uaG7INO+xg0qmRdN3puy62S+TPKp3XLnj5Nj3sO5G1spaY1Q0dv9K29NQS
         T2+tvXg08oNDW1AX+KxGoRhitrLZ27VyHUzztEzEHifwsLRhdkVIYXamboWWPbBFapOX
         8lVSSKpYdxyC1faWnvGpbISsmsa8ORAdQZwLi5RopkYTHUTk6n33ztSQFsSYkhqntAUm
         45iQiG7jYDVivLR7vqoW0kGT8kav3qNeAC4M+7MeZeBWqKsymDq+uZukmPnt/Z/nxA82
         Ndbw==
X-Gm-Message-State: AOJu0YzwV3Q46V5GJvF9NKBEt/7s3/AFofo3iDxRdrfdydA5aGE4pilJ
	+6u67pV/LXnzfokyQwkdRPQi4UFBMSZ89QoLaKVK6WJJQF/C6HEC5qYpVYGy2A/5lGE=
X-Gm-Gg: ATEYQzzUXm2nb6vs/2tUVCQV1OWW9ZonKxMQy5IPIKCi+OOscsrx13rBigeCyR/tEJg
	HsQrX7vnQ2t5Ptqi2m1C0M9pNF33HklY4q3nUzwfjKhZd7cO5ktUWYMDW43SaGdsF6GnekE/9Id
	bpfTBPIGwW1ymDTvf4BUJrbcbOG3HahUbKcuMt0lVaIiF2xmG/d3ibDN2jNy1UXQKl+0Kf1LvQw
	FV1RWsu7E3q5jbNtFUHoyS2ADjxumj4Jo0c7Y7ZY6heKyCFMJ55jadbnrzxdtkmV40i4i5xPNZp
	/WjZAhRSWXKWQFYdeVF+NqLvoRo7THP7IIvzGiRgOZw2F22qGS0SiPEpmsKApGMtn+Gzc8AIl5H
	CRG6s/j712wZCR2ZqsGPOJJFyyvNBW6/fWAlWOi/TSHy8GhOiVioXeQq73snu8wu4dthWITLbMM
	ttc304OtAXLzUEQgOXy7XEWlxVXyYpRlEVM9r+ho3aM5qzpzGX8EaRu5WaAO5RV1GHHOjtuMz4+
	3XcZz9M/3/vR1JUGD0yAn8V2w==
X-Received: by 2002:a05:6000:2211:b0:43b:4592:f91b with SMTP id ffacd0b85a97d-43b527a3aeemr4231303f8f.5.1773825174115;
        Wed, 18 Mar 2026 02:12:54 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ccd1:68ee:ff8c:5895? ([2001:8b0:aba:5f3c:ccd1:68ee:ff8c:5895])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm6389126f8f.12.2026.03.18.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:12:53 -0700 (PDT)
Message-ID: <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org, Yi Zhao <yi.zhao@windriver.com>
Date: Wed, 18 Mar 2026 09:12:52 +0000
In-Reply-To: <abpXXjX8C23hL8RO@monoceros>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
	 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
	 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
	 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
	 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr> <abpXXjX8C23hL8RO@monoceros>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 09:12:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3507

On Wed, 2026-03-18 at 08:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> > On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoctoproj=
ect.org wrote:
> > > Hi Richard,
> > >=20
> > > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> > > > On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.o=
rg wrote:
> > > > >=20
> > > > > On 2/13/26 23:42, "Uwe Kleine-K=C3=B6nig wrote:
> > > > > > With SELinux enabled for the target it makes sense to have SELi=
nux
> > > > > > support enabled for the native tools, too.
> > > > > >=20
> > > > > > Note that for native packages DISTRO_FEATURES is filtered, thus=
 up to now
> > > > > > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_=
NATIVE to
> > > > > > make "selinux" propagate also to DISTRO_FEATURES for native pac=
kages.
> > > > > > ---
> > > > > > Hello,
> > > > > >=20
> > > > > > I use this on scarthgap, but the patch applies fine to master, =
too.
> > > > > >=20
> > > > > > During a debug session it took me quite a while to find out why
> > > > > >=20
> > > > > > 	ls -lZ "${IMAGE_ROOTFS}
> > > > > >=20
> > > > > > at the end of selinux_set_labels() didn't show the labels added=
 by
> > > > > > setfiles.
> > > > > >=20
> > > > > > Best regards
> > > > > > Uwe
> > > > > >=20
> > > > > > =C2=A0 classes/enable-selinux.bbclass | 2 +-
> > > > > > =C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > > > > > =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-se=
linux.bbclass
> > > > > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > > > > --- a/classes/enable-selinux.bbclass
> > > > > > +++ b/classes/enable-selinux.bbclass
> > > > > > @@ -1,3 +1,3 @@
> > > > > > =C2=A0 inherit selinux
> > > > > > =C2=A0=20
> > > > > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
> > > > > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATURES=
', 'selinux', d)}"
> > > > > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > > > > index 4e04e5cc7e6a..ca981db57019 100644
> > > > > > --- a/conf/layer.conf
> > > > > > +++ b/conf/layer.conf
> > > > > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > > > > > =C2=A0 "
> > > > > > =C2=A0=20
> > > > > > =C2=A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-ta=
rgeted"
> > > > > > +
> > > > > > +# With target support for SELinux it is very helpful during de=
bug when the
> > > > > > +# native tools support SELinux, too.
> > > > > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
> > > > >=20
> > > > > Can we add this to the doc (e.g. README) instead of enabling it d=
irectly=20
> > > > > in layer.conf? Since we haven't directly enabled DISTRO_FEATURES =
=3D=20
> > > > > "selinux" in layer.conf either.
> > > >=20
> > > > I just wanted to add that putting that directly in layer.conf will =
mean
> > > > the layer isn't Yocto Project Compatible too.
> > >=20
> > > I am going to send a v2 and take over this work, already asked Uwe ab=
out
> > > that.
> > >=20
> > > But before doing it, I was wondering why changing layer.conf will mak=
e
> > > the layer not compatible with Yocto Project anymore. Can you explain =
to
> > > us the reason?
> >=20
> > I'd guess it is from this criteria of the Yocto Compatible layer[0]:
> > > Inclusion of any layer in the submission does not change the
> > > behavior/configuration of the overall system without the user
> > > explicitly opting into those changes
> >=20
> > By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
> > configuration changes globally without explicit opt-in of the user.
>=20
> Note that the patch didn't change DISTRO_FEATURES, it appended "selinux"
> to DISTRO_FEATURES_FILTER_NATIVE. If DISTRO_FEATURES doesn't already
> contain "selinux", this is a noop. So I don't see how this violates the
> quoted critera.
>=20
> What am I missing?

I guess it would depend whether any of the functions/variables in core
have hard dependencies on that variable. I was assuming that they do
but that might not be the case, I'm not sure without checking and you
may be right.

Cheers,

Richard


