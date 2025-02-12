Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1777C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 08:14:44 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.10227.1739348075006368306
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Feb 2025 00:14:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=klNy+4D9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFFC643191;
	Wed, 12 Feb 2025 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MM2b72OKDq0KmPEhJFVRFfyLEgkdd46a9QxeJjjLz/s=;
	b=klNy+4D9TAJ+zoY6R2ejuthnAmupd2z8aqygF3AefYWuUzCvkzVlP69AhfzV8/cAiE99+x
	sGRZDxKaqSzwrs07MbQ/7mmWgDHLFJjnyYbstG7ANzCi7NLevqW4OYHbN0Bi5DgGqc9Okd
	yCWDkAkGoY/dlzp3Mg6TY3EGHCWg2M6NM52rAlLCFrxWHCA8NkdEwEBboo67mfYHImEPQh
	cO/2U8m6z+mcmE2Ly6paP0WSfTjY7nO1UZ9vk+p9eFlzGwAJtS67MYpsecfCcFq6+ZC0Ta
	dKr3gBVGk2eWFeSrPjBoZipcNjZLn/2BrJFeX6aN/rqYE5C4y6Q+xth6QBt9tg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:14:32 +0100
Message-Id: <D7QBFLDY4P2O.16N4AMK1DM3F5@bootlin.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2 2/3]
 yocto_console_view: Keep known revision mappings
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com> <20250211-mathieu-console_view_colspan-v1-2-d94a8c55acf9@bootlin.com> <410d2fa497ea2b0bcf194559ad6eba60799a8928.camel@linuxfoundation.org>
In-Reply-To: <410d2fa497ea2b0bcf194559ad6eba60799a8928.camel@linuxfoundation.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeeghfektedtfeegjeffvdfhudetledvfeffhfetkeffleefjefgieffudetjeevnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 08:14:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1077

On Wed Feb 12, 2025 at 1:01 AM CET, Richard Purdie wrote:
> On Tue, 2025-02-11 at 15:48 +0100, Mathieu Dubois-Briand via lists.yoctop=
roject.org wrote:
> > The yp_build_revision property disappears from the build instance once
> > the build is done. There is no reason for its value to change, so keep
> > the last seen value in revision mapping. This will prevent finished
> > builds to jump back to "Unresolved Revision".
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> > =C2=A0.../src/views/ConsoleView/ConsoleView.tsx=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 +++-------------------
> > =C2=A01 file changed, 3 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b=
/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > index 973c26424233..93c51b340b17 100644
> > --- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > +++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> > @@ -208,6 +208,9 @@ function selectChangeForBuild(build: Build, buildse=
t: Buildset,
> > =C2=A0=C2=A0 return fakeChange
> > =C2=A0}
> > =C2=A0
> > +const revMapping =3D new Map<int, string>();
> > +const branchMapping =3D new Map<int, string>();
> > +
> > =C2=A0export const ConsoleView =3D observer(() =3D> {
> > =C2=A0=C2=A0 const accessor =3D useDataAccessor([]);
> > =C2=A0
> > @@ -263,8 +266,6 @@ export const ConsoleView =3D observer(() =3D> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 builderIdsWithBuilds.add(build.builderid);
> > =C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0 const revMapping =3D new Map<int, string>();
> > -=C2=A0 const branchMapping =3D new Map<int, string>();
> > =C2=A0=C2=A0 for (const build of buildsQuery.array) {
> > =C2=A0=C2=A0=C2=A0=C2=A0 let change =3D false;
> > =C2=A0=C2=A0=C2=A0=C2=A0 let {
> > @@ -278,26 +279,6 @@ export const ConsoleView =3D observer(() =3D> {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branchMapping[build.buildid] =3D b=
uild.properties.yp_build_branch[0];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D true;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0 if ((!revMapping[buildid] || !branchMapping[buildid=
]) && !build.complete_at) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build.getProperties().onChange =3D prop=
erties =3D> {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D false;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buildid =3D properties.endp=
oint.split('/')[1];
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!revMapping[buildid]) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const rev =3D g=
etBuildProperty(properties[0], 'yp_build_revision');
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rev !=3D nu=
ll) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rev=
Mapping[buildid] =3D rev;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cha=
nge =3D true;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!branchMapping[buildid]=
) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const branch =
=3D getBuildProperty(properties[0], 'yp_build_branch');
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (branch !=3D=
 null) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bra=
nchMapping[buildid] =3D branch;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cha=
nge =3D true;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > -=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0 function getBuildProperty(properties, property) {
>
> When you start a build, it gets "Unresolved Revision" and I think by
> removing this code, it remains there even when the revision becomes
> known. The code would have allowed it to move to the correct line in
> the display. This therefore may fix one issue at the expense of
> another...
>

The issue is this part of the code actually did nothing. I believe I
imported this from the previous version of the plugin but never really
tested it.

I've been trying a few variations, yesterday but it looks like we never
get the property update.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


