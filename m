Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD0CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:51:52 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.33987.1757944309667872090
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=f110EDXh;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 02533C8F1FA
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:51:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DABE6063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:51:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7FD4102F2AC6;
	Mon, 15 Sep 2025 15:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757944307; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tgSbBmYjbJGv6IN59KjdaDwlaGTSWhdpw+HrV4bToTg=;
	b=f110EDXheyAr9hWfojFpM7RdHWDwjEaarGTKmW5vot2RnRFBKDGHziJVXGk8DXfIGcolIX
	5udlYmVmzMRes5S0GNQUiotHhJew0fOqJBjD70HqYuVkcpXyLJFT02dpvqjl1OIEwVohDx
	qKKCv2nS+nMOBPi8fgaiP6ebrba7mno3MyNNAmeVuAdA2vzp5DCAuRrazp4mqsEIV6mlUQ
	CL0NlmpKDztSa5PGZ9UzBrLtQ7nkHrpHrm4lqeesx+DWzt4F8Yh7F7Bg42JM6y0mnzzwt+
	Q48kVxROVWf1zebn659PmnwlAcMbkXaYqJdnAZaLPaClumVdImUOI5+Gqeb5KQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 15:51:44 +0200
Message-Id: <DCTF8WTBNZ6G.19EHR49OA99TA@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 2/3]
 scripts/run-docs-build: pass active releases to bitbake
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com> <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com> <8a7ec4a7-95cc-4d43-be75-9f88c9ead7e8@cherry.de>
In-Reply-To: <8a7ec4a7-95cc-4d43-be75-9f88c9ead7e8@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:51:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2196

On Mon Sep 15, 2025 at 3:21 PM CEST, Quentin Schulz via lists.yoctoproject.=
org wrote:
> Hi Antonin,
>
> On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
>> BitBake's doc now supports setting the active releases in the switchers
>> menu from an environment variable. Pass the active releases from the
>> list in yocto-docs/documentation/set_versions.py. This way we only have
>> to maintain active releases from the yocto-docs location.
>>=20
>> The latest_branch information is retrieved from it, otherwise we land on
>> the in-development branch (2.14) instead of the latest stable one
>> (2.12) - at the time of writing this commit message.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>>   scripts/run-docs-build | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/scripts/run-docs-build b/scripts/run-docs-build
>> index aa1847d..549032f 100755
>> --- a/scripts/run-docs-build
>> +++ b/scripts/run-docs-build
>> @@ -111,6 +111,11 @@ tar --exclude=3Declipse -xJf ${docbookarchive_local=
path}
>>  =20
>>   $scriptdir/docs_add_banner.py
>>  =20
>> +# Retrieve the active bitbake releases from the yocto active releases, =
by using
>> +# set_versions.py from yocto-docs
>> +BITBAKE_ACTIVE_RELEASES=3D$("$ypdocs"/set_versions.py bitbake-active-re=
leases)
>> +export BITBAKE_ACTIVE_RELEASES
>> +
>>   cd $bbdocs
>>   mkdir -p $outputdir/bitbake
>>  =20
>> @@ -121,7 +126,8 @@ mkdir -p $outputdir/bitbake
>>   # see the latest releases.
>>   first_sphinx_commit=3D84ccba0f4aff91528f764523fe1205a354c889ed
>>  =20
>> -latest_branch=3D$(git branch --remote --contains "$first_sphinx_commit"=
 --format '%(refname:lstrip=3D3)' --sort=3D'-version:refname' | grep --max-=
count=3D1 "[0-9]*\.[0-9]*")
>> +# Get the latest branch from the active releases in BITBAKE_ACTIVE_RELE=
ASES
>> +latest_branch=3D"$(echo "$BITBAKE_ACTIVE_RELEASES" | cut -d',' -f1 | so=
rt -V | tail -n 1)"
>
> I see... Bitbake development differs from YP's. BitBake already has a=20
> branch named after the next release, while YP only branches off soon=20
> before merging?

Yes exactly. With the current form, we'd get 2.14 as the default landing pa=
ge.

> Another option could be to simply list the tags, and the take the=20
> numerically highest one and extract the first two numbers.
>
> git tag --contains "$first_sphinx_commit" --sort=3D'-version:refname'=20
> '[0-9]*.[0-9]*' | grep --max-count=3D1 -o "^[0-9]\+\.[0-9]\+"
>
> will return the branch, provided it's also one number dot one number for=
=20
> the branch from which we have a tag named one number dot one number dot=
=20
> one number (which may be 0).
>
> This avoids to rely on a script from outside of the bitbake repo or an=20
> environment variable.

Good idea, I'll see how that works out.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


