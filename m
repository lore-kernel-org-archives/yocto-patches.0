Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA71073C8C
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:14:23 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.102816.1775643260909623352
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 03:14:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LEMQxjgW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so19020855e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775643259; x=1776248059; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4eI35Bt3ON5WIqgYafaiSNT/ziaiZ+K+qDYqmyfkQA=;
        b=LEMQxjgWbwSrMmnH6RJ7IsfxaBdTK63T1aEFtJLofiPjytjuwLLhtf/vIOjQmDNVrW
         RV3hyWCZXQ0eDcRDt+jidnQyXS47BfmyB5p9pUHshx59MO1+VZD/kYMcsFq2TKqW8/5T
         8ElbPabgnd6grQPHbH33kRhpkNndQhdXTz+bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775643259; x=1776248059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4eI35Bt3ON5WIqgYafaiSNT/ziaiZ+K+qDYqmyfkQA=;
        b=kOqcg8bKQQ9qf97xEOr0ImCIycrRMM3NzLs8ewoKuOsw9aTqTdaROlAxcIxiDJkkf1
         mZJZ90uNWO+vlYTvnySuxqtm8y+KEfLwxcYBf2mPjfPRZbnsUR5efA6ziy0kwulVCcGG
         SvZDYe++DnTew0r3IZaIyRcBrK079Hfq/wkPjBaYkzhtqJ1BylJigir/6bB9sl7qHmWI
         1rNPWLxXUB9w65xJIS+j8sEkx+mLyZmPD03BFNFFHrZMszvFqnOQLbWdQc+n64Atf3Cq
         0pcDPOLjp/MCRlwvHoRKPu963YoWPx1uyUb8WHwmBr3pw9XsnDU3dKYx6/qAWHc2QtPT
         +9Jg==
X-Gm-Message-State: AOJu0YyeF8yVlG8lA0q/ZIji+ys8qCIghGK6FqpTtKEnVhoWOTAS65kt
	vA1BUF9iJRYGRD7OEBn7y4oUq8WfTGSVhyvLqpuSc1KwZbr2ugn+grZqI/YoaHeDPtysZq089/O
	78sObHis=
X-Gm-Gg: AeBDiesGP9evug/2AqkAeTTPfhuP3E2tJC1B3mZ/wFYsMNm1ouXkEgJIHe9H7RdyzbS
	TyOpcK+Y4q1fbF5jbypNUBDalEkrM0bcKELMflid97xAnnRAbXzu+EJXZl2CA+8xdDOxrAuk51o
	W21rJL2YIF8AFh6AgircLmWCecPOxYO2COKWAJ8mjhfV7fN4GS8hHUF4EV/o4e9LRTVod98DPYb
	6JjU9wH4cxR9IDr0NGFqxXRPHfiTgLjajeF3pTAe0o3MT6qR9e8kxL0LNWTC/MugIX2rqhBqFPq
	4dCXgS8kZDdt5DuM8vKSSbw3MuJgi0Ny+U0n4nEe0B167jgrIisoFjpYXdRdPoymqgfImkZXeuP
	v6DdlNN9CJDR0kjhXEjea0UihTjHueRGtWYk0gIProib3juS4o65b1r21hMeLrPpUfVk8PtcST7
	KAlGb7fuwYWo24uUu1fK/i8V/0FIjGCwpdzGC5wRNiPXITrjmKsCbprLypVnE2MKZQ3inX50lXI
	9zXgSI3cAojlLdy
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr278493885e9.13.1775643258536;
        Wed, 08 Apr 2026 03:14:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3a70:3593:db41:cfe4? ([2001:8b0:aba:5f3c:3a70:3593:db41:cfe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c53326d7sm18230205e9.8.2026.04.08.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:14:17 -0700 (PDT)
Message-ID: <8701b1c37a2d192c4d8698eee648025ea632060c.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/yocto-supported-distros: fix an incorrect regular expression for
 stream
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yoann Congal
	 <yoann.congal@smile.fr>
Date: Wed, 08 Apr 2026 11:14:17 +0100
In-Reply-To: <DHNLEVZSJENP.8TRZXPDC4RO3@bootlin.com>
References: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
	 <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
	 <DHNLEVZSJENP.8TRZXPDC4RO3@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 10:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3661

On Wed, 2026-04-08 at 09:25 +0200, Antonin Godard via
lists.yoctoproject.org wrote:
> Hi,
>=20
> On Mon Apr 6, 2026 at 10:49 AM CEST, Paul Barker wrote:
> > On Thu, 2026-03-26 at 17:22 +0100, Antonin Godard via
> > lists.yoctoproject.org wrote:
> > > The lsb string for CentOS Stream is actually centosstream-*, not
> > > centos-*. It was thus not detecting centosstream entries in
> > > SANITY_TESTED_DISTROS.
> > >=20
> > > This was preventing the script from outputting the docs-formatted
> > > CentOS
> > > strings.
> > >=20
> > > Reported-by: Yoann Congal <yoann.congal@smile.fr>
> > > Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> > > ---
> > > =C2=A0scripts/yocto-supported-distros | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/scripts/yocto-supported-distros b/scripts/yocto-
> > > supported-distros
> > > index 11b05b7..f1dac04 100755
> > > --- a/scripts/yocto-supported-distros
> > > +++ b/scripts/yocto-supported-distros
> > > @@ -83,7 +83,7 @@ INPUT_REGEXES =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > > =C2=A0=C2=A0=C2=A0=C2=A0 "centosstream": {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ab": re.compile(r"^=
stream(\d+)"),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "lsb": re.compile(r"^stre=
am-(\d+)"),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "lsb": re.compile(r"^cent=
osstream-(\d+)"),
> >=20
> > Hi Antonin,
> >=20
> > Where do you see centosstream-* reported?
> >=20
> > On the stream9-vk-1 autobuilder worker and on a local centos stream
> > 9
> > instance I see "centos-9":
> >=20
> > =C2=A0=C2=A0=C2=A0 $ ( source /etc/os-release && echo $ID-$VERSION_ID )
> > =C2=A0=C2=A0=C2=A0 centos-9
> >=20
> > We currently have "centosstream-9" listed as a supported distro,
> > but if
> > I build on stream9-vk-1 I see:
> >=20
> > =C2=A0=C2=A0=C2=A0 WARNING: Host distribution "centos-9" has not been v=
alidated
> > with
> > =C2=A0=C2=A0=C2=A0 this version of the build system; you may possibly e=
xperience
> > =C2=A0=C2=A0=C2=A0 unexpected failures. It is recommended that you use =
a tested
> > =C2=A0=C2=A0=C2=A0 distribution.
> >=20
> > So, I sent a patch for meta-yocto [1]. We should try to resolve
> > which
> > one is correct.
> >=20
> > [1]:
> > https://lore.kernel.org/poky/20260403-centos-9-v1-1-e5324bd74ea3@pbarke=
r.dev/T/
>=20
> I'm a bit confused, why was this not a problem on whinlatter and
> scarthgap then?
> Both of them have either centosstream-8 or centosstream-9 as their
> lsb string in
> poky.conf.
>=20
> https://git.yoctoproject.org/meta-yocto/tree/meta-poky/conf/distro/poky.c=
onf?h=3Dwhinlatter
> https://git.yoctoproject.org/meta-yocto/tree/meta-poky/conf/distro/poky.c=
onf?h=3Dscarthgap
>=20
> Even CentOS Stream 8 images report centos-8 (with a local docker
> image):
>=20
> $ docker run --rm -it quay.io/centos/centos:stream8 bash
> [root@c33732bb804a /]# cat /etc/os-release
> NAME=3D"CentOS Stream"
> VERSION=3D"8"
> ID=3D"centos"
> ID_LIKE=3D"rhel fedora"
> VERSION_ID=3D"8"
>=20
> Should we backport your change to both of these branches?

It does sound like we got that wrong so yes, we should probably fix it.

Cheers,

Richard

