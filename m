Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F78C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 10:08:25 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.11772.1739354896682714601
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Feb 2025 02:08:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LNWn7XWH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd91c313bso2033916f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 02:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739354895; x=1739959695; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOxI2zNz7/aJrSEWxzQSi6N4Uza1wXnZ/0829U3Jhm8=;
        b=LNWn7XWHWsg56d0DjEVUoagCiSLmV5SVOZbTW+pe1Ri4EnFh7S6PfxnAS18zrqBh/f
         dMq8WrFzMaURJ1IXTXOfYmlrkpcXzPIUTVnK6srLkQTpiyQoMX5916iHu9VfnlcZsot2
         gAit+xuhcvPvwrG05a4ONdv6OCGSLbh5G5aZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354895; x=1739959695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOxI2zNz7/aJrSEWxzQSi6N4Uza1wXnZ/0829U3Jhm8=;
        b=YjckzdYpMK1rfyAmTIfObXbXHWQRCXiZmC+7tutf/8oeZGBakLENEUalH5fzcmoYXQ
         xooJ+dR+ll3jcsv5ZqcqxplW+UquwOA7ni4RFW7H9zaPp6y0HFM1B9SBHV7TGJFx8tuk
         cHo8yorrXrZBNwDM1ZSFjScI7RXqrh+yF4I9o0cGL+eLaXl2i3YXfQWKC60iYJBAD0gc
         jS7vXHVf+d4GnVeqgx2qbFJmcQzqDgUFlNAUymnuTIQmkz3sgMDo1km2Jqp0252u3PtB
         laCXguf7OknKzAKTrLbvf8QHC9Dv67372glxo9ytgEZjW7H53cehepdEl4g13Hyx5mA/
         kbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzgGhPp6JWGAi+6MRevv5ajxQAir2bFvvRkpcWMGLS1ttKE3kCfrQZRd2i3LFAKVeruzfQen0pvYM8U1Yj@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwEZIzJ14ALgGiW5RLn+EmctYUmoLEWcM274+mJHZ8mSTA0pXIA
	HxbutMKloYyUaqrsKa3JIUWxEZtLf2LpDGZS4/1QvUZVZwcHxLYVzdTGWHux0FA=
X-Gm-Gg: ASbGncvV00O7QqDDtQPCH0sjYn79JdMKXUQjjxQc752JbddSVXAyMxjyCP4WmkCppBn
	x7Ge7KtfaolmzXmtF4LmGuo9A4d+V0UagnTlOkJEJwemaluLJqTqr2sWLcAHDH0hhb003LMv+iX
	s9PRdlwScVzhq1/V8VwG/wxOQnxhRHDPvC0ZViTfqp6QFJ0Kf1UIl6ZXLNRJHGmGYo05krVopvl
	6j11il0+LAM8f3+lD4hrorUYxCfSdGXIsFjU8o8KLYJDqe1k/nwkQ3dnPifzReM9CnNMBYwOaee
	axUZ8nhSS3P6xyNidMdkbyzNhrQp+Sgeidf+LyHAIALVvlT9xplxZxunItatfiCbeRzP5u/qg1n
	cLA==
X-Google-Smtp-Source: AGHT+IFcLY+de0UihynlEreVQmIp/gVIbRD7Z/EBGnqrUDlHud0wE/CFU8h1NViuBib11aUjSSNzCQ==
X-Received: by 2002:a5d:5192:0:b0:38d:e411:ebbf with SMTP id ffacd0b85a97d-38dea604099mr1337575f8f.45.1739354894948;
        Wed, 12 Feb 2025 02:08:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:af16:73ba:601:d9ae? ([2001:8b0:aba:5f3c:af16:73ba:601:d9ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1c2aasm31653265e9.0.2025.02.12.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:08:13 -0800 (PST)
Message-ID: <3409aa96b46408784992ece9c475a50e2e8a8be0.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2 2/3]
 yocto_console_view: Keep known revision mappings
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 12 Feb 2025 10:08:13 +0000
In-Reply-To: <D7QBFLDY4P2O.16N4AMK1DM3F5@bootlin.com>
References: 
	<20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
	 <20250211-mathieu-console_view_colspan-v1-2-d94a8c55acf9@bootlin.com>
	 <410d2fa497ea2b0bcf194559ad6eba60799a8928.camel@linuxfoundation.org>
	 <D7QBFLDY4P2O.16N4AMK1DM3F5@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 10:08:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1078

On Wed, 2025-02-12 at 09:14 +0100, Mathieu Dubois-Briand wrote:
> On Wed Feb 12, 2025 at 1:01 AM CET, Richard Purdie wrote:
> > On Tue, 2025-02-11 at 15:48 +0100, Mathieu Dubois-Briand via
> > lists.yoctoproject.org wrote:
> > > The yp_build_revision property disappears from the build instance
> > > once
> > > the build is done. There is no reason for its value to change, so
> > > keep
> > > the last seen value in revision mapping. This will prevent
> > > finished
> > > builds to jump back to "Unresolved Revision".
> > >=20
> > > Signed-off-by: Mathieu Dubois-Briand
> > > <mathieu.dubois-briand@bootlin.com>
> > > ---
> > > =C2=A0.../src/views/ConsoleView/ConsoleView.tsx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 +++-----
> > > --------------
> > > =C2=A01 file changed, 3 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git
> > > a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > > b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > > index 973c26424233..93c51b340b17 100644
> > > --- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > > +++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > > @@ -208,6 +208,9 @@ function selectChangeForBuild(build: Build,
> > > buildset: Buildset,
> > > =C2=A0=C2=A0 return fakeChange
> > > =C2=A0}
> > > =C2=A0
> > > +const revMapping =3D new Map<int, string>();
> > > +const branchMapping =3D new Map<int, string>();
> > > +
> > > =C2=A0export const ConsoleView =3D observer(() =3D> {
> > > =C2=A0=C2=A0 const accessor =3D useDataAccessor([]);
> > > =C2=A0
> > > @@ -263,8 +266,6 @@ export const ConsoleView =3D observer(() =3D> {
> > > =C2=A0=C2=A0=C2=A0=C2=A0 builderIdsWithBuilds.add(build.builderid);
> > > =C2=A0=C2=A0 }
> > > =C2=A0
> > > -=C2=A0 const revMapping =3D new Map<int, string>();
> > > -=C2=A0 const branchMapping =3D new Map<int, string>();
> > > =C2=A0=C2=A0 for (const build of buildsQuery.array) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0 let change =3D false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 let {
> > > @@ -278,26 +279,6 @@ export const ConsoleView =3D observer(() =3D> {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branchMapping[build.buildid] =3D
> > > build.properties.yp_build_branch[0];
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D true;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0 if ((!revMapping[buildid] || !branchMapping[build=
id]) &&
> > > !build.complete_at) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build.getProperties().onChange =3D pr=
operties =3D> {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D false;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buildid =3D properties.en=
dpoint.split('/')[1];
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!revMapping[buildid])=
 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const rev =3D=
 getBuildProperty(properties[0],
> > > 'yp_build_revision');
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rev !=3D =
null) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
evMapping[buildid] =3D rev;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
hange =3D true;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!branchMapping[buildi=
d]) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const branch =
=3D getBuildProperty(properties[0],
> > > 'yp_build_branch');
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (branch !=
=3D null) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
ranchMapping[buildid] =3D branch;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
hange =3D true;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > -=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0 }
> > > =C2=A0
> > > =C2=A0=C2=A0 function getBuildProperty(properties, property) {
> >=20
> > When you start a build, it gets "Unresolved Revision" and I think
> > by
> > removing this code, it remains there even when the revision becomes
> > known. The code would have allowed it to move to the correct line
> > in
> > the display. This therefore may fix one issue at the expense of
> > another...
> >=20
>=20
> The issue is this part of the code actually did nothing. I believe I
> imported this from the previous version of the plugin but never
> really tested it.
>=20
> I've been trying a few variations, yesterday but it looks like we
> never get the property update.

I know it was one of the more problematic elements in the code in the
past and can result in a lot more queries.=C2=A0The idea was that when the
property became available, we'd update the UI. I'd probably have to
replicate a test environment to be able to offer much help at this
point...

Cheers,

Richard

