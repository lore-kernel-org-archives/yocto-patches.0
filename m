Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481E77188
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 13:31:12 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.58990.1736170262162460150
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jan 2025 05:31:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WBSnh3jt;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97EAF1BF208;
	Mon,  6 Jan 2025 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736170259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfNk9EGavN9ue2lsS8QgPgm1bngd6qN1/yDZhUqisQg=;
	b=WBSnh3jt8QT3YxjDH3lfiypvyZZFJsGjQ43eQ0Eo556xcghwK+Hgu+g8DruZW1imiWsA0n
	oyDIhvhTWku387cp6/tGeUrAC8ezQ/ioieOXbRNrHGHcLKZ0yP7msNt8EELNOQP/z143Fy
	rINUVPB3KeqG+tY2Lc5rFEa8ckwOEkbU+4pwXU1fxV3d8AZyYZt0vmho2+zR+eV6L/m8qs
	oYPe8LaDFoEYi+1/UUCdgjXnScujetE2VNN0O4VgfmvOvzHFp3KqNG+JUJG7OM/MR0dRz9
	OGHLE+83QFIrNwlcXeAnoDgrGcg8P46UxsaOMF4YpFvf5IF04GAM+ypYxkkoTA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jan 2025 14:30:59 +0100
Message-Id: <D6V0ZQB35QH0.1BHV3MUAN1O9J@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] docs: fetch
 yocto-docs and bitbake using *shared-repos scripts
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20250103-docs-build-shared-repos-v1-1-7b5705d895a1@bootlin.com>
 <6c886818b4a62a4d119e51604c046a0a4afc97b2.camel@linuxfoundation.org>
In-Reply-To: <6c886818b4a62a4d119e51604c046a0a4afc97b2.camel@linuxfoundation.org>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jan 2025 13:31:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/969

Hi Richard,

On Mon Jan 6, 2025 at 2:07 PM CET, Richard Purdie wrote:
> On Fri, 2025-01-03 at 16:24 +0100, Antonin Godard via lists.yoctoproject.=
org wrote:
>> The docs build was one of the only builder not using the shared-repos
>> scripts. This prevented some of the repository properties to be
>> overriden, such as the bitbake/yocto-docs repository URI. Overriding the
>> bitbake URI is especially useful when using bitbake-contrib instead of
>> bitbake, to test changes.
>>=20
>> Leave the yocto-autobuilder-helper in the codebases (like in the other
>> builders), but move the yocto-docs/bitbake repositories to NEEDREPOS in
>> yocto-autobuilder-helper/config.json.
>>=20
>> This patch depends on the patch "config.json: add docs build config" on
>> yocto-autobuilder-helper.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>> =C2=A0builders.py=C2=A0=C2=A0 | 36 ++++++++++++++++++++++--------------
>> =C2=A0config.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0schedulers.py | 11 +----------
>> =C2=A03 files changed, 24 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/builders.py b/builders.py
>> index 88ff328c7ec6ecf0f28da2693cc9c0210e760b35..e19fe5a138b18deec776f19c=
6b0af507e3021c89 100644
>> --- a/builders.py
>> +++ b/builders.py
>> @@ -389,22 +389,26 @@ def create_doc_builder_factory():
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode=3D'incremental',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haltOnFailure=3DTrue,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'Fetch yocto-aut=
obuilder-helper'))
>> -=C2=A0=C2=A0=C2=A0 f.addStep(steps.Git(
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repourl=3Dconfig.repos["yoct=
o-docs"][0],
>
> Since I looked at this a bit more, I think this should be:
>
> self.getProperty("repo_yocto-docs") instead of config.repos["yocto-docs"]=
[0]
>
> (see steps/writelayerinfo.py)
>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branch=3Dconfig.repos["yocto=
-docs"][1],
>
> similarly:
>
> self.getProperty("branch_yocto-docs")
>
>
> then we'd add=C2=A0properties=3Dparent_default_props('docs') to:
>
> schedulers.append(sched.AnyBranchScheduler(name=3D"yocto-docs-changed"

Thanks, this looks easier than using the scripts, I'll try this instead.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

