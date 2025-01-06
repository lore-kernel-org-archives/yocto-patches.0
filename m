Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F21E77188
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 13:07:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.58579.1736168845019278960
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jan 2025 05:07:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LfDrzD1O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso95278495e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jan 2025 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736168843; x=1736773643; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02NtZpEozuGWVa5Ds8O0QUE2pq1EuhOdM0vF8p/BVqM=;
        b=LfDrzD1OCBREZi5CxaClkVFs5Sm+kepXWk0RfAob9qHL12ddsysfA6g1q90bMDLwJH
         3xEfFU9sbfy0qw0mFaXlOLDPEcLQvgU36gx9ulgM83BW6VsrGsgpgPhDC9j3d80ZXi4l
         MUiwfMFqLqc0tr4LWalyPZt74x9nNkOc/msyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736168843; x=1736773643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02NtZpEozuGWVa5Ds8O0QUE2pq1EuhOdM0vF8p/BVqM=;
        b=YGyLp8kyCRrG0q5C9fbslTOKPG98f7OTF06We0P8+ZB+69h4bY22POI7xLmFzHMggl
         Z7KNh6WdZokDDC0ivNvk1TVFPblYFNH+g8fvLc8ec7BwMJlXOvmrWyPN/wn9W1HidLe8
         2YrQjluwMCvd1wx2FsC15vir5oCh1jVtqWRw1Voyf1v+qa3+ASfR3L5yN80vmLGw4UOm
         0FwL6crQfsCvBvKvzCfb8fbzYTHBNMT3hIY/b+L5Sl3OTVqC6yet1dMnHV7wYCiWckiG
         EWSp6vwMc6ZyXOcJNp40wKqCC1GGfxYqVlwLjkilvp02/eAlPxeSJ/8say53xh7Iok0i
         j8rw==
X-Gm-Message-State: AOJu0YwBjgy+D0oDQXExvN4TbjVSWjKc5ADXdld+rt3i7UgjxaOKEtXB
	qAc3PzpiPYWae1ffJ8aSB6l2Bc0XqIVIJMBqcFbEXLLqzXhGPTJs0fjeGuE7s1umnGjI1oiJsdn
	LFtI=
X-Gm-Gg: ASbGncskLeGAb0Od7+3UBSCcXbvZztG82VJOQyrgzNovcL7WAWL/QX8g2uuPsKI25RN
	orrToMkyMTdtEZatnscXxi1qm8s4UsFwJ5U5zxMJ/TnAWfjhj3l75jKWjsTeIBoTSIxvNkVOAx9
	1UHbgIyCd2ibU3qGFiKcMt8KZ7Tvk6QWg/qTtPKHm8B3njjUCCnmZWOYAUox+14avu9hSsZve1E
	556sJeZAr4It7CLK8OuSK1vi01ghLYCei2+4lJZQ7KwF/Lam0+GWgf1KuQnvNk/Y9Rfx/V1Vqaf
	mYTuZsKGZX3xmzPpoynznqDbkDZKGvRNaMj1zH7IxEcIaQ==
X-Google-Smtp-Source: AGHT+IGFEoFmADha7XfICJu1qP4iAYPAx0S3E333TnU4jOgMZquawwYJXrBi9kZaxGSHJlTptlMNDA==
X-Received: by 2002:a05:600c:3b23:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-43668b5f3b7mr432262945e9.25.1736168843095;
        Mon, 06 Jan 2025 05:07:23 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3607:7267:e27a:36e4? ([2001:8b0:aba:5f3c:3607:7267:e27a:36e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c848a47sm47276816f8f.62.2025.01.06.05.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:07:22 -0800 (PST)
Message-ID: <6c886818b4a62a4d119e51604c046a0a4afc97b2.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] docs: fetch
 yocto-docs and bitbake using *shared-repos scripts
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Antonin Godard
	 <antonin.godard@bootlin.com>
Date: Mon, 06 Jan 2025 13:07:21 +0000
In-Reply-To: <20250103-docs-build-shared-repos-v1-1-7b5705d895a1@bootlin.com>
References: <20250103-docs-build-shared-repos-v1-1-7b5705d895a1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jan 2025 13:07:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/968

On Fri, 2025-01-03 at 16:24 +0100, Antonin Godard via lists.yoctoproject.or=
g wrote:
> The docs build was one of the only builder not using the shared-repos
> scripts. This prevented some of the repository properties to be
> overriden, such as the bitbake/yocto-docs repository URI. Overriding the
> bitbake URI is especially useful when using bitbake-contrib instead of
> bitbake, to test changes.
>=20
> Leave the yocto-autobuilder-helper in the codebases (like in the other
> builders), but move the yocto-docs/bitbake repositories to NEEDREPOS in
> yocto-autobuilder-helper/config.json.
>=20
> This patch depends on the patch "config.json: add docs build config" on
> yocto-autobuilder-helper.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> =C2=A0builders.py=C2=A0=C2=A0 | 36 ++++++++++++++++++++++--------------
> =C2=A0config.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0schedulers.py | 11 +----------
> =C2=A03 files changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/builders.py b/builders.py
> index 88ff328c7ec6ecf0f28da2693cc9c0210e760b35..e19fe5a138b18deec776f19c6=
b0af507e3021c89 100644
> --- a/builders.py
> +++ b/builders.py
> @@ -389,22 +389,26 @@ def create_doc_builder_factory():
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode=3D'incremental',
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haltOnFailure=3DTrue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3D'Fetch yocto-auto=
builder-helper'))
> -=C2=A0=C2=A0=C2=A0 f.addStep(steps.Git(
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repourl=3Dconfig.repos["yocto=
-docs"][0],

Since I looked at this a bit more, I think this should be:

self.getProperty("repo_yocto-docs") instead of config.repos["yocto-docs"][0=
]

(see steps/writelayerinfo.py)

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branch=3Dconfig.repos["yocto-=
docs"][1],

similarly:

self.getProperty("branch_yocto-docs")


then we'd add=C2=A0properties=3Dparent_default_props('docs') to:

schedulers.append(sched.AnyBranchScheduler(name=3D"yocto-docs-changed"

Cheers,

Richard






