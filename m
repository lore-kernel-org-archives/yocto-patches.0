Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787FC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 10:36:36 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.33483.1721903789856868276
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 03:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gsq0LlkA;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04150796so975403e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903788; x=1722508588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3o7ruRX+Gajh9KEuPqmnma+SiyB/KHjQkjDWUEOJhU=;
        b=Gsq0LlkAyUd6BQr/Q4/rNtrYkJKYGJgxKupvXUFnNeFtF2nRVrOn7up1KwsFeGsWvw
         EcJONmFRKNlQ87Kiu8/4XKum0slOmc3eL/H7NgTaaS2UOlxPygRaYWp79tx4MdewJqvb
         sQBv1cklwTZ08CZ1jWzS2dR9Y6afKQ34YEg5RD1qcIlXpPFd7dkpEQjHa8Qb+BirWcG5
         QdR6i540j8xnqKBRY6smO7CroOgut13PSbVOg3Wy2WQTQmtpgNjvkgE4VkKMcAuyYWZI
         PvRn7V1y9hWo+3bvKvSG8HK/6RRq9Ma1D1D/eP/IimCIKAUAKgYXukaD10i4df6IVHgk
         i/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903788; x=1722508588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3o7ruRX+Gajh9KEuPqmnma+SiyB/KHjQkjDWUEOJhU=;
        b=OUy83q6IvsRzJ5TbMo3v9GRu49Int9An1F8rLxRSHNIu3Kk136Rjyf6gEQ3LQ6AXYC
         KERE2K424XDecQn8kmg42iIrS+MGdRKIZYeHvIG2nuM+o074UMEjSJdA/Ik4bzTm9JdO
         EvtIlFM+1txXi92pgwXLgKrDTISrP7zRL1vjsUW572llzzxt6NuX0yg5BNneGCSOoJEU
         SSip7JEVRNjhl0jO3Ninzt1EjbOEqz59X3eLSN0FI3rug82p3pCtc7/N+Ekj2l0QttIm
         /8TPjn6ReOFRN4Wok8wv9z10mQPNpiVXp4ZxJ83jxJM6Nc5DhJYLST7S3e0piTnR5Fy3
         qZug==
X-Gm-Message-State: AOJu0YxitRDJfgTHDCNRJ5qNz5hRNIBFiSeMKsFfH6VLpzCPZZ+CWwcJ
	N2NfpMEAVwAPtDVc2JkJYQqfdpS5lUk0+Oiqw25cPc7/ojsFvx9PuQi/Ekd1S1tXUb01tL38VYk
	qwG8mpstiob6kgoDqXkdZ423uDEIuxQ==
X-Google-Smtp-Source: AGHT+IHR6RrfD7hPg0zxAQk5p4haPtNIP55TeKO17i4L0TCjVlh0JBX93wDedX8bkeK2fsslkAT3B3Nw3Q1B/o8Jbdo=
X-Received: by 2002:a05:6512:3ca7:b0:52c:df6d:e52e with SMTP id
 2adb3069b0e04-52fd3f118c9mr1974601e87.16.1721903787600; Thu, 25 Jul 2024
 03:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 25 Jul 2024 12:35:58 +0200
Message-ID: <CA+chaQfVw=9mFAPm3VWVKCKT3upPsigVwMMxLzMzviqVjCm7tg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 01/17] bastille: UNPACKDIR fixes
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 10:36:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/476

new poky?

poky is just reference distribution and name of a repo. The change was
implemented in and is required by new oe-core.

On Thu, Jul 25, 2024 at 11:02=E2=80=AFAM Mikko Rapeli via
lists.yoctoproject.org
<mikko.rapeli=3Dlinaro.org@lists.yoctoproject.org> wrote:
>
> New poky version uses UNPACKDIR instead of WORKDIR
>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  .../recipes-security/bastille/bastille_3.2.1.bb      | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_=
3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.=
1.bb
> index f2ef335..7074f68 100644
> --- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.b=
b
> +++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.b=
b
> @@ -83,11 +83,11 @@ do_install () {
>         install -m 0644 Bastille/AccountSecurity.pm    ${D}${libdir}/Bast=
ille
>         install -m 0644 Bastille/Apache.pm    ${D}${libdir}/Bastille
>         install -m 0644 Bastille/API.pm    ${D}${libdir}/Bastille
> -       install -m 0644 ${WORKDIR}/AccountPermission.pm    ${D}${libdir}/=
Bastille/API
> -       install -m 0644 ${WORKDIR}/FileContent.pm    ${D}${libdir}/Bastil=
le/API
> -       install -m 0644 ${WORKDIR}/HPSpecific.pm    ${D}${libdir}/Bastill=
e/API
> -       install -m 0644 ${WORKDIR}/ServiceAdmin.pm    ${D}${libdir}/Basti=
lle/API
> -       install -m 0644 ${WORKDIR}/Miscellaneous.pm    ${D}${libdir}/Bast=
ille/API
> +       install -m 0644 ${UNPACKDIR}/AccountPermission.pm    ${D}${libdir=
}/Bastille/API
> +       install -m 0644 ${UNPACKDIR}/FileContent.pm    ${D}${libdir}/Bast=
ille/API
> +       install -m 0644 ${UNPACKDIR}/HPSpecific.pm    ${D}${libdir}/Basti=
lle/API
> +       install -m 0644 ${UNPACKDIR}/ServiceAdmin.pm    ${D}${libdir}/Bas=
tille/API
> +       install -m 0644 ${UNPACKDIR}/Miscellaneous.pm    ${D}${libdir}/Ba=
stille/API
>         install -m 0644 Bastille/BootSecurity.pm    ${D}${libdir}/Bastill=
e
>         install -m 0644 Bastille/ConfigureMiscPAM.pm    ${D}${libdir}/Bas=
tille
>         install -m 0644 Bastille/DisableUserTools.pm    ${D}${libdir}/Bas=
tille
> @@ -138,7 +138,7 @@ do_install () {
>         install -m 0644 OSMap/OSX.bastille    ${D}${datadir}/Bastille/OSM=
ap
>         install -m 0644 OSMap/OSX.system    ${D}${datadir}/Bastille/OSMap
>
> -       install -m 0644 ${WORKDIR}/config ${D}${sysconfdir}/Bastille/conf=
ig
> +       install -m 0644 ${UNPACKDIR}/config ${D}${sysconfdir}/Bastille/co=
nfig
>
>         for file in `cat Modules.txt` ; do
>                 install -m 0644 Questions/$file.txt ${D}${datadir}/Bastil=
le/Questions
> --
> 2.34.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#458): https://lists.yoctoproject.org/g/yocto-patches/=
message/458
> Mute This Topic: https://lists.yoctoproject.org/mt/107539467/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

