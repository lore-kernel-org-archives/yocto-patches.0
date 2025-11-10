Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB5CCFA13
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 10:13:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45072.1762769577863526530
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 02:12:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=V02O2RTk;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06B1CC108EA
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 10:12:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 503D0606F5
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 10:12:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72305103718CC;
	Mon, 10 Nov 2025 11:12:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762769574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xovv+NEUpK/uloQeh3PMDwAI+K5o/uYColt2FtRV5hI=;
	b=V02O2RTkdjBtHdH3CifsA0tx9xa3jYeu11B9/jcHgV0UckNn3a2LzGcD/wkN2f5/sCUpqw
	A7aBwIwUhiR0Cx8shJ6x4vTIbnTuX13ij4Xg4P/BCZ26WvkTZij+ecQL1qs6DCHVgZK+wp
	7KX7hBVwRQ7sEltLPCEUD+R8ijTYamvsfXsTCeBMRWBcicgBR82/3GqZvoTTY4STPAISwC
	tnwOeVe9O8LqIJiU41S6/afTtp8iSAATXjktASjdQmz3LIYsm03YfF2FhJIzRzE9DhFMxE
	sztlzQYTeKiow5+292xX8boDWBSXICjow0k7EEYGcJd6pvufSFK6NL0o09fovA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 11:12:53 +0100
Message-Id: <DE4XNUKMV1P0.2W00O0VLX0KVJ@bootlin.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] reporters: swatbot:
 Fix branch name retrieval
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <1863DFD4C9467C5A.10180@lists.yoctoproject.org>
In-Reply-To: <1863DFD4C9467C5A.10180@lists.yoctoproject.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 10:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2472

On Wed Sep 10, 2025 at 10:52 AM CEST, Mathieu Dubois-Briand via lists.yocto=
project.org wrote:
> The swatbot reporter tries to get the name of the built branch, using
> the "branch_poky" property of the build. Some builders, such as "docs",
> do not use the poky git, so this property is missing. Currently, this
> result in a non-fatal error on the buildbot controller, but the build
> entry is not added to swatbot.
>
> Import code from swattool, falling back to oecore or yocto-docs branch
> name.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  reporters/swatbot.py | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/reporters/swatbot.py b/reporters/swatbot.py
> index 5e434d5d04a4..6e3827329033 100644
> --- a/reporters/swatbot.py
> +++ b/reporters/swatbot.py
> @@ -49,6 +49,24 @@ class SwatBotURI(object):
>              return self.client.get(query, timeout=3Dself.TIMEOUT, header=
s=3Dself.headers, allow_redirects=3DFalse)
>          return req
> =20
> +    def get_build_branch(self, build):
> +        """Extract branch name from build properties.
> +
> +        Args:
> +            build: Build dictionary containing properties
> +
> +        Returns:
> +            Branch name if found, None otherwise
> +        """
> +        repos =3D ['poky', 'oecore', 'yocto-docs']
> +        for repo in repos:
> +            branch =3D build['properties'].get(f'branch_{repo}')
> +            if branch:
> +                return branch[0]
> +        branches =3D [p for p in build['properties'] if p.startswith('br=
anch')]
> +        log.err("Failed to get corresponding branch, possible values: %s=
", branches)
> +        return None
> +
>      def find_build_collection(self, build):
>          dbid =3D None
> =20
> @@ -77,7 +95,7 @@ class SwatBotURI(object):
>                      'attributes': {
>                          "buildid": collection_build_id,
>                          "targetname": build['builder']['name'],
> -                        "branch": build['properties']['branch_poky'][0],
> +                        "branch": self.get_build_branch(build)
>                      }
>                  }
>              }
>
> ---
> base-commit: 247aaef0910826113ccfc892f42f9012a45034f7
> change-id: 20250910-contrib-mathieu-swatbot_branches_fix-7fbe5402eed6
>
> Best regards,

Hi Richard,

I believe this patch was never merged, any opinion on these changes?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


