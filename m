Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4DCAC59C
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:53:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.34259.1757944377472151591
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:52:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=H5Pffm5S;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CD9561A0DC1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:52:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A447D6063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:52:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18CF9102F2AC8;
	Mon, 15 Sep 2025 15:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757944375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zm9bMpnS/k5cI2I6ab20Gjh+ugGK7SQkt0NbXjvdwmU=;
	b=H5Pffm5SGqjq7elm+fCTJZC+xmabWiwXODIvPf8aArlmXt5UoPPr0MYdaWoBZUDYp8gJrb
	XxCF75oO640jd+EiOxlFYp4as5tqwZqsSBdRwA8qBzlTFdr0ZLwJtN++xYaiJk9C/o4ml2
	WXfGOUKiesKPDVe7I253wCdnqWo1OCJV9OcXntEOdrw6wqiFqTJeIoXZqC6XykeqsO8eMw
	PYbQ1eMcYK3hnFL1rhVARmB5A2+THz9xmYFPYE2DFHO7YA3ojeTB0ImwQ2yLmA72VRoi9N
	a74zTfJI52Zj2xZuXGzzV+iY2FfWjQh0Z42ULw4tJoU9GjhZ8LAq9pygiaWh2A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 15:52:54 +0200
Message-Id: <DCTF9SSNYURU.37CQ1DVIGX6K7@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 2/3]
 scripts/run-docs-build: pass active releases to bitbake
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com> <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com> <4d2ad38d-230c-4719-b517-db79bdc6725d@cherry.de>
In-Reply-To: <4d2ad38d-230c-4719-b517-db79bdc6725d@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:53:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2197

On Mon Sep 15, 2025 at 3:31 PM CEST, Quentin Schulz via lists.yoctoproject.=
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
>>  =20
>>   for branch in 1.46 $(git branch --remote --contains "$first_sphinx_com=
mit" --format '%(refname:lstrip=3D3)'); do
>>       if [ "$branch" =3D "HEAD" ]; then
>> @@ -132,7 +138,7 @@ for branch in 1.46 $(git branch --remote --contains =
"$first_sphinx_commit" --for
>>       git checkout $branch
>>       git reset --hard
>>       git clean -ffdx
>> -    git checkout origin/master releases.rst
>> +    git checkout origin/master releases.rst set_versions.py sphinx-stat=
ic/switchers.js.in Makefile
>
> I don't think we should be checking out Makefile from master, we would=20
> have to keep in mind that the Makefile needs to be backwards compatible=
=20
> forever. This is a big burden to carry IMO.
>
> If we really need something from the current Makefile, we can always=20
> patch the bitbake docs the same way we patch the yocto-docs on the fly.

Indeed, I don't think the Makefile was necessary to backport anyway, I'll r=
emove
it.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


