Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B86C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 14:47:19 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.39790.1721054834428715090
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jul 2024 07:47:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HKr4JQFi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266edee10cso27746935e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721054833; x=1721659633; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9PTd8t0ilkZBjgDORL8njgnE28OdExjS0FkeNZJ/p8=;
        b=HKr4JQFiNOoEfoQwVSkilp4Hg+D+izgkNeY5ZUmD1qOQGENUmknOmHA86EY0+/FaUz
         WIPr/mweAFS5gv/HhRfsaWvGCe1txCold+GbcTgDZHfk7Ct2uhvQu0jBh71NbEDOUUaU
         XdZEjI6of63Nft6XZ9yx52Iyxl5Shwz1VO0hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054833; x=1721659633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9PTd8t0ilkZBjgDORL8njgnE28OdExjS0FkeNZJ/p8=;
        b=ELZRlx6R+v1JRFXc7N+JrAdfO5yF/1cM27IBoVm4KWk8dxKSlOJfkQVkcboihZnuAn
         QUsh4BDpEBsyxglTsatVqrz0INZWO4xkKQaeEkoQsu7SGIrWKRTS+lgOSTpXyyks1vik
         Iunh0ytYA7SCJNLghrw5oW3XJsbT+naCGx6VXVKu8wBDsg/EwgwIGSpNjr7vE5ZXd2MH
         QXn3g66AftdeVuxosEF0XYH6QXaC8FE7NNjzNwbEYvHRzyY3QAq9FpKvImUWz4n9GYac
         a0glXzICrBXiOORqVVOpC9o2/5v0opd5yLlPWNqGmboK7h4IAzt/iA2H3QnyTMw+cYdi
         gq+g==
X-Gm-Message-State: AOJu0YzDHEDNzLLmEH6IXKLHr0B/19uN2YL9RPELwSPN96E9E0/6l9zg
	hihvIROZxfe7kpc6lcP3HDuQ3Ad0ToVnVcy8NfY3Ytvd/8//i6/Q6BYVVbiAZYixgo3sW4eRznA
	Q
X-Google-Smtp-Source: AGHT+IGTdElGtFRlb16s4DQ8rfECEde6TUiGBY2nO3thKZyD6XQKCEtya9gcA3Lql6NhB//IIfwWbQ==
X-Received: by 2002:a05:600c:6c51:b0:426:5e55:199a with SMTP id 5b1f17b1804b1-426707e3149mr131547965e9.23.1721054832595;
        Mon, 15 Jul 2024 07:47:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2eb0:8378:bf2c:f110? ([2001:8b0:aba:5f3c:2eb0:8378:bf2c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db048a8sm6607140f8f.111.2024.07.15.07.47.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:47:12 -0700 (PDT)
Message-ID: <5afa76ad9a887b364e4a4640959de3332330bd5a.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 ignore TMPDIR issues
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 15 Jul 2024 15:47:11 +0100
In-Reply-To: <20240715143149.16336-1-twoerner@gmail.com>
References: <20240715143149.16336-1-twoerner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 14:47:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/430

On Mon, 2024-07-15 at 10:31 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> oe-core has raised the status of some checks from warnings to errors.
> Ignore
> the "...contains references to TMPDIR..." error when building the
> torvalds-next kernel.
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> =C2=A0recipes-kernel/linux/linux-torvalds-next_git.bb | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb
> b/recipes-kernel/linux/linux-torvalds-next_git.bb
> index c0ac1de22005..6f3db7c61bdf 100644
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -5,6 +5,7 @@ SECTION =3D "kernel"
> =C2=A0LICENSE =3D "GPL-2.0-only"
> =C2=A0LIC_FILES_CHKSUM =3D
> "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e46"
> =C2=A0
> +ERROR_QA:remove =3D "buildpaths"
> =C2=A0DEFAULT_PREFERENCE =3D "-1"
> =C2=A0COMPATIBLE_MACHINE =3D "^$"
> =C2=A0COMPATIBLE_MACHINE:radxa-zero-3 =3D "radxa-zero-3"

You may want to add that to WARN_QA so you remember to at least look at
them a some point. They're a sign of non-reproducible builds for a
start and break hash equivalence sstate reuse.

Cheers,

Richard

