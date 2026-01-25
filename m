Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D460D7237C
	for <webhook@archiver.kernel.org>; Sun, 25 Jan 2026 21:52:51 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6265.1769377967777133311
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Jan 2026 13:52:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WD4GMxJN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-435903c4040so2363263f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Jan 2026 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769377966; x=1769982766; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qr9FwO/az8f92oRiZsPXqbyuGUbO0u+YbxMtQ+ei//g=;
        b=WD4GMxJNSEPlOPSKPi00g1OSqDJ7obz04Lgu770bz2p3qPaWn9pRV5JMXQmNLDcmwF
         ouAMGpPAJMyYXDACy7rfcJcEbEWNGJ5W8WOfGGy0Nn1EjTWr76JUSCsZSB1KTB/EQJwn
         E5ovM6KvqnfaMJtn4x1JPJIJ/n5YLREfQwleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769377966; x=1769982766;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr9FwO/az8f92oRiZsPXqbyuGUbO0u+YbxMtQ+ei//g=;
        b=U6b0MnQojfL+M7/B+nV0pTX5o2oJoy+xqH4eXqJzSQ6pGTuCjjorul77cO9fO+1C0I
         PTOFk2v0RgQcbUVVgnJ7JoQ0IkKsZvF5Ax8Yeq7m+Z0f8Z2nszz0NrUXyQlIBc44J186
         g+iINJTHwM1A7Xz5oO2EXdsVIKQiwyLDQGeeaTXAp1k4UOdXF8bPHRo6u6z+25c36DNg
         kmqnXr+Es6iRtmWJP8G6Kvs3FelAEreHw9x3KvgDhsJSUVz1o+LvhXS+EQKxu8cJAay0
         eVumT8RwE/97VyUZJdifkk6z3Kn52SmTGcwHXW5oqwjcIWfaMr8JMbdFl+IR5HobvRL7
         DF/g==
X-Gm-Message-State: AOJu0YxyRKwHRlVLqlfOGaLHRa3w8RueGtpUz+qY11AACVaW0GP8siTC
	HTFxoLsADL9ZFkDQur4HeIRldrB5C2wiN+GTV9cnTVR9wTSCmwAeNsm5B04ZujvP8/ekLifOD9c
	GLrUEWR8=
X-Gm-Gg: AZuq6aJkB+c8uknyqUfm5h1VSPbxaFcFefteNfwA3v3+PWv6qAjD4DgDm6H6RwRkb9P
	YD61YI6btK2N+D147sDSp8i1+qmmVsxC5Srqqxv2QCuNJEpb4Z8HrtZ79eYBxSi1hE6MlEeyiMV
	zN2v7jjKvgTEFJSVoXWxqxmPxeR5TxfrB1HRyNXIbmGwMdtkuPYZ0MJqiaTVjdsNpFvgyI0x7hB
	sOs0A7B/rIIszogL/wHlIRfvobx1oEfcHu1bKjKVsN5XYLjISdysNB1x4DNozTFPsuNsij1r4Ed
	M5fJDA502eECwcn2JpcSPpb3aFLjyiLya4V2HBehZTgbWRBXIDfE0fEEOj8xCv0R+nkGQIPM72h
	wIo5a7TGp6EGOPn60ORNDjehahZ3/alaQLSBUfUEcCJtsxg5ZEmyZ5gSBAiaYz8nhDWKB7GI4Bo
	kFtyndGGB5NOaAZhLOAUJF65CdAceQ22T9YHmn9OHYF8g6XDAbTDwjoVThohWcqMm8JTvbwnkwD
	Pu+of4vpvA+Cw==
X-Received: by 2002:a05:6000:1866:b0:435:ab90:6f34 with SMTP id ffacd0b85a97d-435ca124849mr3932147f8f.16.1769377965744;
        Sun, 25 Jan 2026 13:52:45 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2c23:1ef4:9a85:53f4? ([2001:8b0:aba:5f3c:2c23:1ef4:9a85:53f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7164dsm25234599f8f.23.2026.01.25.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:52:45 -0800 (PST)
Message-ID: <010e5f88c6444634471f8e166044c15f182fac46.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:
 sort repo branches in maintained stable branches
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Sun, 25 Jan 2026 21:52:44 +0000
In-Reply-To: <DB5PR02MB10213B6D7B2ED24E5B7C1BC72EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260121174651.64212-1-yoann.congal@smile.fr>
	 <DB5PR02MB10213B6D7B2ED24E5B7C1BC72EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 25 Jan 2026 21:52:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3076

On Wed, 2026-01-21 at 17:52 +0000, Peter Kjellerstedt via lists.yoctoprojec=
t.org wrote:
> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org=C2=A0<yocto-patches@lists.yo=
ctoproject.org> On Behalf Of Yoann Congal via lists.yoctoproject.org
> > Sent: den 21 januari 2026 18:47
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Yoann Congal <yoann.congal@smile.fr>
> > Subject: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:=
 sort repo branches in maintained stable branches
> >=20
> > From: Yoann Congal <yoann.congal@smile.fr>
> >=20
> > This should help seeing if any branch is missing by comparing with the
> > "Build Properties" page of a build.
> >=20
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> > =C2=A0schedulers.py | 22 +++++++++++-----------
> > =C2=A01 file changed, 11 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/schedulers.py b/schedulers.py
> > index 42983a8..0018fcb 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -73,16 +73,16 @@ branchdefaults =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0 'whinlatter': {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch': 'whinlatter'=
,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_poky': 'master',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_bitbake': '2.1=
6',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-arm': 'wh=
inlatter',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-gplv2': '=
master',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-mingw': '=
whinlatter',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-openembed=
ded': 'whinlatter',
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-virtualization=
': 'whinlatter',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-yocto': '=
whinlatter',
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_yocto-docs': 'whinl=
atter',
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_oecore': 'whin=
latter',
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-virtualization=
': 'whinlatter',
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_poky': 'master',
>=20
> I don't know how these are actually used, but is a branch for poky=20
> really meaningful with Whinlatter? Though I notice that meta-gplv2=20
> is also mentioned above, and it has been dead and buried for years...

It is a limitation of the build infrastructure, it needs to be set to
something resolvable. No, it isn't ideal, equally we've a lot of bigger
problems. When we drop kirkstone, we can drop that too.

Cheers,

Richard

