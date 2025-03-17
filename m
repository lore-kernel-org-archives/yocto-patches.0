Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA02C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 21:03:35 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.2293.1742245407544579884
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 14:03:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fTjnm44F;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: raj.khem@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f3ecfa7a76so2517250b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742245407; x=1742850207; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58bKawMGDaSe1v8lVncfRjVEdCJUs5pFPhyw0jYtURI=;
        b=fTjnm44FATe148sfmmJtUxQRgFSiDSr3JVVhP1bsR3ybJbeUy+HTRyTkMuPF40QhxL
         31tCA2kIX72kZdl0WDkNHwES0d1xQupYS5aURVy2mSiLJFkC0S/agibPSNyle+639Sy6
         hbyo4Bf6Dha33E/bdM5Dh3DbdynwKsaqm0uDxc7LdEXirIf4eiAoeN3gbk+c81zgSKFT
         4eAm0DHzDVLdIMzKOwNLwKuGAojhhqD3Wt5PtTE+tx0MZ9uKgy/MA+3g3JHFyEhNvrK5
         NvcF39T2GYbaoiOEn3fW8dyMAFgdWm5Kr/bNTGQpdhope6YD8FyjKj7CRg1u7isW86sf
         w4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245407; x=1742850207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58bKawMGDaSe1v8lVncfRjVEdCJUs5pFPhyw0jYtURI=;
        b=jovaU1iT9j2m2/6v/2S8xIj56hL2s6qzVgo/5o0d1B1Dhznj81Id1EgxkI9U08uVnF
         y4LZKfTtQVr0eaTZ5P94RE/vDeXzFlXqvPdIpVxEKdwydW78RPja7tKrALlCUXYaeGdj
         TYA8x/i6g3Eo/3tQTbav2/aZ7GpGUXdLNZJTEpSgdmRlYygZZeYNBCASpegS11MlvQF8
         0zeYrbTmdQZ8MDR35BCEct9drIkRd3Kaq19KsjF6Ol4Bu1ibvR4mNgC+VcntM6UWWZPX
         KZ7sOfgK8hNgISawmoK6eW2jYdZvbNqKqUSi6jv/CRiE8WwNFyxyXXQyR3EssE92E00M
         UrtA==
X-Gm-Message-State: AOJu0YwlySPiODkj9jrzXER2XdB4Xup9D2EMmy9NKfOL85uXcKilrn0t
	y7ECYsWwCrvuWsMNh+F3kwoJeYLfYtEMh8MWcJeCPtcBVNqfWjaUyOMIujppxISTcVptd0icOv1
	yNX0x2qjHkvhGAapZx9gEYwTnc0w=
X-Gm-Gg: ASbGncv1K1WwCUIgxJLytFxfIGDSYRzgdLePRAT9Gix2C2tWVsXhg3UGWEtdUnfc6Zp
	az56eP1KJczh2O0h/5I5BvS7kR+hHrBYLHMBnxmLrYaSo8IFb2aJTjLGpHQF/TavEKpsS7W6Q5I
	5bPqn2c/ZxsEfiYgJ5UjVXJA4SEVEwP5Bn4KbsMrIZz01Qq6qfR1x6Z8M=
X-Google-Smtp-Source: AGHT+IHXFdoO+wxrSeUbaelbvp/pP2Fw2TkL3w3CAsyHSO5cansCzkDq3p4UfMej1nFMwI2So1RVj3yATlSrWRNdoEE=
X-Received: by 2002:a05:6808:158e:b0:3f9:d5a2:899b with SMTP id
 5614622812f47-3fdf08344d4mr7157263b6e.38.1742245406772; Mon, 17 Mar 2025
 14:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250317200926.3247948-1-yoann.congal@smile.fr>
In-Reply-To: <20250317200926.3247948-1-yoann.congal@smile.fr>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 17 Mar 2025 14:03:00 -0700
X-Gm-Features: AQ5f1Jo8ugF0y5IE-KanPJ9dwSsIOUA5QgiriOUAX9GItYAzU5pmRzc7xNlpMgA
Message-ID: <CAMKF1sqB27jfoYSYcwaXMpYgFKSU45+2WEsFNtQEQFvueczKOg@mail.gmail.com>
Subject: Re: [yocto-autobuilder2][PATCH] config: Ban Ubuntu 20.04 from running "reproducible-meta-oe"
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 21:03:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1210

On Mon, Mar 17, 2025 at 1:09=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> From: Yoann Congal <yoann.congal@smile.fr>
>
> Ubuntu 20.04 lacks a g++ recent enough to build nodejs. Nodejs builds a
> native C++ program using std=3Dg++20 which is not supported in Ubuntu
> 20.04 g++ (9.4).
>
> For example, see these AB runs:
>  * https://autobuilder.yoctoproject.org/valkyrie/#/builders/87/builds/33/=
steps/32/logs/stdio
>  * https://autobuilder.yoctoproject.org/valkyrie/#/builders/87/builds/36/=
steps/32/logs/stdio
> Note, these logs show the nodejs failure but not the reason (I
> reproduced locally to get it).
>
> Link: https://lists.openembedded.org/g/openembedded-devel/topic/111740469
> Cc: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  config.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/config.py b/config.py
> index 74c7c0a..8fb34d1 100644
> --- a/config.py
> +++ b/config.py
> @@ -236,6 +236,8 @@ builder_to_workers =3D {
>       # Have gitstats and gnuplot
>      "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu24=
10-vk-1"],
>      "toaster": workers_toaster,
> +    # Ban Ubuntu 20.04 from trying "reproducible-meta-oe" (lacks a g++ r=
ecent enough (std=3Dg++20) to build nodejs)
> +    "reproducible-meta-oe": [worker for worker in workers if not worker.=
startswith("ubuntu2004-")],

Another option would be to ask for buildtools tarball to be used. I
think that might be a slightly better option
going forward.

>      "default": workers
>  }
>

