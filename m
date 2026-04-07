Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80545F3D5E1
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 11:14:27 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78879.1775560462954486609
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 04:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VQoqFeT3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so11001755e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775560461; x=1776165261; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxxtqKshhkbkuQ5/RXSkvph6E+dvNa/OxFUnCzBqu2c=;
        b=VQoqFeT3sAB1jmt/SFNwcsZnpRHJ/iPLpIfSVSj0pLnVywZI7tJSwNeKzv/pUMD/CR
         tMkWqGJTTiDLsVzHJor0REyQcOT7oYxNHB10LHR6Yhs4rTVM+CcdivsCxH0SkQQfbKDK
         pIX9LTp4rjN3UVtgfumZYOYRf+Mph68VVAxWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775560461; x=1776165261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxxtqKshhkbkuQ5/RXSkvph6E+dvNa/OxFUnCzBqu2c=;
        b=CKkrzM1FDbbVWAhnB78oaxBEhCXFG0dnNdfhPHIyqxL1NjcEl60v9mYbVwu+nrbW1h
         6qvfjO0zsDCN3a8U3DZ8Hq6rXU5U4cNYTMfIDb3tbrGb1o2sB3VOJBI4C2B0jVfGlBvm
         hWU0MbxTpQDHK5c4DGyRqjRyvQb638AvwJnpYJL0TsYxWPNNKjIbJ5ADm++2jUnyoC//
         Z/6rWFf+WltduSciXO4s4f6H0wgxTVaH4YzfoW6BZGiUADWe08epBSk2p/EqYtf7nojc
         qo0G9/X8T70Vp5dq1NDujZDulJSMcEKILQu7sgnpTloP1/tU16EicdAyIXZB3hNNtJbo
         V5hg==
X-Gm-Message-State: AOJu0YzuwLdbZn4xuqFXe9o5sjTnlRGGExmLKwq35SXlEE5YmTEkIWdS
	V/9QJv/BWepHaLlwTy+RJ30M0GrbjPwcKcAq/+fpHr1e5TpcJnq9RhgGUG/K4C6BVeHnPnXDyzJ
	1mvg9
X-Gm-Gg: AeBDiesJkyYH811454DO59dwxY3NwF4SFywh2sHVzC3vwwSVcoawdYZAjD3YPfk3RiC
	nWy8GlNb+lEcj67R/wi/zozk+eP64iWKXH/VdCfeCBz3dbv7VTTp+DpRQKy0gQNW6006eAniNEi
	3Yjq4eHTOffac7m6HMnhfu5YW7OutBp6sKg8Sv/oSvtGf5zFjDa4/ouL0EXKoR45odphfDOHf5G
	5wY1Im2P0rvvW+T92RLbA7ey0ZEXPJlPNK68NNCGWKxgpr9G0hC0V/96aH+9Sq5/W6CUZygGsV5
	PTNxS6Fw3SWnM6kAHzlQGomUewEuSYR+ZloOq9cz8qTnJepWTichQn8sq/tEJB3kCthlc8bWC9s
	IiOo/ZtZZUQYPM9iZVcVlL87W/L/ym4JOuJeMtB3xk5hXhTq8PvoEkjBRnruUicdB56yqKx1Yu7
	UPaHAKj0UZrOjyP93QMWyrALh2Nkz4pu36f73Mj+azV/Oh92TyQmBfqODba5XcV5YZe4hzrG5Wg
	WqN7Y7ArL6pvvPi
X-Received: by 2002:a05:600c:a10f:b0:488:869c:eda1 with SMTP id 5b1f17b1804b1-4889977c971mr166106175e9.15.1775560460652;
        Tue, 07 Apr 2026 04:14:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e3c7:294f:9240:15a1? ([2001:8b0:aba:5f3c:e3c7:294f:9240:15a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b6ff70bcsm215012595e9.14.2026.04.07.04.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:14:19 -0700 (PDT)
Message-ID: <080fe4d04a344b7d31be90a7e43e7760c9033562.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/yocto-supported-distros: fix an incorrect regular expression for
 stream
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yoann Congal
	 <yoann.congal@smile.fr>
Date: Tue, 07 Apr 2026 12:14:19 +0100
In-Reply-To: <DHMVBNW8H8K0.CQXRP80OH374@bootlin.com>
References: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
	 <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
	 <DHMVBNW8H8K0.CQXRP80OH374@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 11:14:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3653

On Tue, 2026-04-07 at 12:58 +0200, Antonin Godard via lists.yoctoproject.or=
g wrote:
> Hi,
>=20
> On Mon Apr 6, 2026 at 10:49 AM CEST, Paul Barker wrote:
> > On Thu, 2026-03-26 at 17:22 +0100, Antonin Godard via
> > lists.yoctoproject.org wrote:
> > > The lsb string for CentOS Stream is actually centosstream-*, not
> > > centos-*. It was thus not detecting centosstream entries in
> > > SANITY_TESTED_DISTROS.
> > >=20
> > > This was preventing the script from outputting the docs-formatted Cen=
tOS
> > > strings.
> > >=20
> > > Reported-by: Yoann Congal <yoann.congal@smile.fr>
> > > Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> > > ---
> > > =C2=A0scripts/yocto-supported-distros | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supporte=
d-distros
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
>=20
> In meta-yocto :)
>=20
> > On the stream9-vk-1 autobuilder worker and on a local centos stream 9
> > instance I see "centos-9":
> >=20
> > =C2=A0=C2=A0=C2=A0 $ ( source /etc/os-release && echo $ID-$VERSION_ID )
> > =C2=A0=C2=A0=C2=A0 centos-9
> >=20
> > We currently have "centosstream-9" listed as a supported distro, but if
> > I build on stream9-vk-1 I see:
> >=20
> > =C2=A0=C2=A0=C2=A0 WARNING: Host distribution "centos-9" has not been v=
alidated with
> > =C2=A0=C2=A0=C2=A0 this version of the build system; you may possibly e=
xperience
> > =C2=A0=C2=A0=C2=A0 unexpected failures. It is recommended that you use =
a tested
> > =C2=A0=C2=A0=C2=A0 distribution.
> >=20
> > So, I sent a patch for meta-yocto [1]. We should try to resolve which
> > one is correct.
> >=20
> > [1]: https://lore.kernel.org/poky/20260403-centos-9-v1-1-e5324bd74ea3@p=
barker.dev/T/
>=20
> Your fix to meta-yocto is the correct one. I didn't realize the issue was=
 in
> meta-yocto at first, and yocto-supported-distros uses meta-yocto as input=
.
>=20
> This means that this commit can be reverted from yocto-autobuilder-helper=
. I'll
> send a patch when yours is applied to meta-yocto.

I've applied it...

Cheers,

Richard

