Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14072EDF056
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:18:23 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41378.1770884293325293269
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:18:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Hzr2pkZp;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE6C34E40CAD
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:18:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8637E606CD
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:18:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5AEC11971342
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 09:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770884290; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zZzr6ld/lWhDaZi3SGCtctdRmF2UsLk/vfhIYDrHySU=;
	b=Hzr2pkZprBH7N1DxXKwigTzLBk4n2gTeKA9rRhKmXK1xs99/IFO/KFyvKfdCCtyzOCi14/
	yYfUma5cG768aZk7Pp7chz7W3emQy5Z8R965G+IAz1n5XKDR7pU8cdPQWCOS1lTG28orU5
	rxqx4mWlLE67syhIHqf7D0y4xiqTEfQKB1UhjJQZDTK3pFpjaAI/uTnApHegiZIZYZnFXo
	tqv5A/ICqXzyfFFsDJLqy50dkBs9UHHgCVxBzAQDq4DwyXakJvSyaOy1q0qLWfgvAuyCWz
	uz02mMIUoOdAVXBbaPlZrjtZ4xQrfNLlLyWJMwBtD6pJs046nUsUDPAdoY2QMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 09:18:08 +0100
Message-Id: <DGCU378W4HUB.TVZ9O0X0Y24V@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/release-parser: remove poky repo add wrynose branch
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
In-Reply-To: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:18:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3219

On Thu Feb 12, 2026 at 12:15 AM CET, Michael Halstead via lists.yoctoprojec=
t.org wrote:
> Remove references to the deprecated poky repository. Use meta-yocto for
> tag data instead. Update to include the 6.0 branch.
>
> Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
> ---
>  scripts/release-parser.py | 12 ++++++------
>  scripts/run-gitstats      |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/release-parser.py b/scripts/release-parser.py
> index 21a6d57..079bada 100755
> --- a/scripts/release-parser.py
> +++ b/scripts/release-parser.py
> @@ -10,7 +10,7 @@ from collections import defaultdict
>  import datetime
>  import semver
>
> -GIT_REPO =3D "~/git/mirror/poky"
> +GIT_REPO =3D "~/git/mirror/meta-yocto"
>

Hi Michael,

This is breaking the indexing build:

+ /srv/pokybuild/yocto-worker/indexing/yocto-autobuilder-helper/scripts/rel=
ease-parser.py
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/indexing/yocto-autobuilder-helper/scrip=
ts/release-parser.py", line 15, in <module>
    repo =3D Repo(GIT_REPO)
           ^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/git/repo/base.py", line 210, in __in=
it__
    raise NoSuchPathError(epath)
git.exc.NoSuchPathError: /srv/pokybuild/git/mirror/meta-yocto

https://autobuilder.yoctoproject.org/valkyrie/#/builders/104/builds/46325

I believe the issue is a "meta-yocto" entry should be added to
"repo-defaults" section of config.json.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


