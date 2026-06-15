Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06236CD98DA
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 10:23:34 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.126580.1781519007881609715
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 03:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QqDtJYtU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec3f69d343so450105866b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781519006; x=1782123806; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f1yImiaQ/INlRVRcZovpajLVeHwP36zmf/2vODDEMLk=;
        b=QqDtJYtUXNZy1VYCdop7eeczT573RK6IqQEZx4UZuGHwgyrbAeg2tPraNNu13/u717
         Ny67xCH2tsTPGxY/rInoHK2Sz1yh/SWcXCIv8O5WmBpXIrGxshzTy4K2xpkMkgwgU6UV
         rnAlEqKYOjHzi6H/K0jXbyld7woXrJXj/XoHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781519006; x=1782123806;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1yImiaQ/INlRVRcZovpajLVeHwP36zmf/2vODDEMLk=;
        b=noXmCNj6VPkdHBfECU2RZLb70USPeEiqx5AVJIQHtYH/ZtDTyfULX4UJNPqPWFKwbW
         OPEbTJnBVRmnG6cdOMtQsFUFeqbNhBXC0oRU0P29jeKomvOGk/pxslMncWdRFJ22v00/
         /fps3RA+STo9abf0gTZcX0BPVa0NjlMuMbBmacFU713T4KL/HA61nYQRYPPS0UedVxDS
         bvJBEdOEFnmyALblcdzDtIDSEU24Kz3KjzRsugOS/75T0xEX567/A0WuUQPqtJvkU8A9
         dQa8EENZaIKZYAzLMAYiui0ldVA26xaXc34ImiIGubI+9R+pvG4LwX9ljF7iN1Z7sSBL
         IyKA==
X-Gm-Message-State: AOJu0Yx+Gy5ZVIPXsx9l8MvMbSVaKZ1gUl1nIsqzcftGRbXElVIc8R9T
	gzl3bVoQL6ua9clQjSeimfnxPikATP4uv20ZEDQreE+lZClquYfeZGIiLeMLr4c84qPHWGNzrhQ
	1ALeQ
X-Gm-Gg: Acq92OHBe7/+bKZzVNQpawm09Ep9Ot1dcprG1mJJ6oVc3pqC4kdn7tJDsWeZAeWGiX7
	b7xqxgrRBkxo3Cm5ogTb8wOXSns7+4E2N0uL4QLBK+SAvcjOO7A+I+W/vCWUgcVEvQDzfl3T3BX
	w1Yu2CtUlsObh3JLAGUUfBItiS1T11/pwqvCk/H88Noc21SnuZqPM9PbZDVR1/IH9OwFM15PlWL
	6EE3wwqyDbvXUIl276jNH/Oq+EwxIqmskbks/kRv9dtiXrJr/haROhxWxDfDY/VGnpEJhmkQpRN
	X1F93ov+oMDho2UkehW/YLiTgBkKsju1AiFVGEKLdiYWYPpPq9jp81ahIEVOXQcBgF7uas9Cybc
	gsUFn2J4LEnEnY7fBsUSHwEmp2QdVmHqqx0y3y+17jc2U03Jrl634q/h+XoYCLg7OkatLjrNlsA
	SGQUtyQ5ekHN9Q7iSv2s46TdYBU0/ITM/irbXwPSzsz9Z/NDvGeNcGd0V5w+jd6kkEAZGrqdAUG
	5872yn2TPq9UE/u
X-Received: by 2002:a17:907:e895:b0:bed:d329:1ed9 with SMTP id a640c23a62f3a-bff4bdfcba1mr406315766b.33.1781519003029;
        Mon, 15 Jun 2026 03:23:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e2da:88d9:f720:efe2? ([2001:8b0:aba:5f3c:e2da:88d9:f720:efe2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6d8c2sm427105466b.38.2026.06.15.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:23:22 -0700 (PDT)
Message-ID: <359cd363e6d79716d2d9cf2b960f27ec2c33ac0e.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] schedulers: Switch
 meta-agl to unagi branch for scarthgap
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>
Date: Mon, 15 Jun 2026 11:23:21 +0100
In-Reply-To: <DJ9J47WKVRKJ.1GDBA84GBBGVP@smile.fr>
References: <20260615-mathieu-agl-unagi-v1-1-5c2b5b28bd44@bootlin.com>
	 <DJ9J47WKVRKJ.1GDBA84GBBGVP@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 10:23:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4226

On Mon, 2026-06-15 at 11:52 +0200, Yoann Congal via lists.yoctoproject.org =
wrote:
> On Mon Jun 15, 2026 at 11:38 AM CEST, Mathieu Dubois-Briand via lists.yoc=
toproject.org wrote:
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> > =C2=A0schedulers.py | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/schedulers.py b/schedulers.py
> > index 0f41bd0c7ca6..e5f0684fcb34 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -161,7 +161,7 @@ branchdefaults =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0 'scarthgap': {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch': 'scarthgap',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_bitbake': '2.8=
',
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-agl': 'master'=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-agl': 'unagi',
>=20
> This looks correct but note that I don't test/use this anywhere on normal
> builds.

There are automatically scheduled jobs that do test yocto-check-layer
with it on scarthgap though.

Cheers,

Richard

