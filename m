Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D52C77B7F
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 05:17:20 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.1520.1750915037948536921
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 22:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ayHYCzoJ;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d20f79a00dso84027485a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 22:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750915037; x=1751519837; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoSMCB1ICvaaL/15e4s8Km2H0j3yBtCikTyAuIPOxj0=;
        b=ayHYCzoJSHU/7UU8Sn94kR9ZEnfUOz5sNDf0FiYX9m9WMutSmv2VMYIJR9zG12iSC7
         ET7szB3ibB/pM0Fsnt2l6dH+7bJyGSlQ4ypm4oa+X+LPrAUQECrRlL4SveD466C4cKWz
         fVv/aDTBllLxw6QPnr4VcqZM9dj9ILBkvodlN9syViRi0x0tkzyDM0kzfcTZUXT/hH7c
         ETKxZVdapGX0Q2yZ3/u7oO5JxN9VQ2O/rLY0dhfF/cM24bqmfziXer549dBaecOOAFKI
         oIM2tFy2jKphnvctaCtYUAqx/0TTUFFCzpOmlT3v3FS36SgfFYwQwZhG8DQ8LRyv/zv5
         pTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750915037; x=1751519837;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoSMCB1ICvaaL/15e4s8Km2H0j3yBtCikTyAuIPOxj0=;
        b=rsaYVIwUjAlpx0bF7q0uWbfu5mQCHsMuQVaHFJFwdapSVKfc2kxLfJ7Hgj/T6OlmoL
         46+KuaI3fXVxYlZWBwsuQKyw8JzNPPw8yUz00LNGIT2ygUF4pzZWTcBta79Nz+QIEL0O
         FyKehFR9pcLP2zM4LSTC1He6aC7sCQ3jc/0lAUM7h0WmYQcfe8eK3V1lO39qH1Zlxfce
         x6RlHJahvTpOBR4ZV8m1GUJEjY55sd7nl7rQSAsRxbrPGijp3wJ+CQim1KjSIgtKRrIQ
         HQw8ShXS0DfrMzt0f34ce99d/zqF+P6Q2Yb7xQ3sH82eKFMefYDsmd9kpQ7Jv4YY5kM7
         Zx3Q==
X-Gm-Message-State: AOJu0Yz6snpH+rM6Fq9y7vS1dCBYPEXz2mtwqicrZmlQIWNGHCdZhSVD
	VZvN2ehu7D4iOoFF+BMJCM355B9SrrFyfgafXEll5iVIq+XUpdRVCcz0d2It/+5q9sLHJowVFoS
	eTYPiUKKntzWAdvkTwyon6m1q/gz/EKb8VB8m
X-Gm-Gg: ASbGncsmQIbOJvuOifo08HV98SzWJDhrPXo3KBOXh0FTOR4454ufZOhbEimCM3G3uSM
	LO724GUZHrbzk92ricfX/hmeH9/uqZker5y6fy/gehKElKQBXfySD4uUNnnnt04YJc8hmk18u/0
	dnaEJp6YEMKXz22r43ctZ6kG9XYM4HbYZk9Rw4zd1E/RV9IliiPTW4Cyda5gvVF2v3MFaSlpHx1
	1f3Cw==
X-Google-Smtp-Source: AGHT+IFgsz7G4QOqXBpqPe/VMSrZtvdj/dl4JDQI3Nbb9aVH7wXloe9Ed6ju2jE1QUN5XGSlCyj+HimgkhccerFq4iU=
X-Received: by 2002:a05:620a:410c:b0:7d4:2854:795d with SMTP id
 af79cd13be357-7d4297856cbmr687166785a.39.1750915036806; Wed, 25 Jun 2025
 22:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1750882005.git.scott.murray@konsulko.com> <848dd8066de86d3feeb520ef49e902548743fcdd.1750882005.git.scott.murray@konsulko.com>
In-Reply-To: <848dd8066de86d3feeb520ef49e902548743fcdd.1750882005.git.scott.murray@konsulko.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Jun 2025 07:17:05 +0200
X-Gm-Features: Ac12FXyg4XE8n3WYRsEhhmKMVPn2sgt9CcOVnr2spQ6s-xBg4TIbdIjj-hmephg
Message-ID: <CANNYZj8hvFiu4774qYFkBUu1NCiX8wLtOPnXu8hFb3S-u4SnUA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] Adapt to UNPACKDIR changes
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 05:17:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1696

On Wed, 25 Jun 2025 at 22:10, Scott Murray via lists.yoctoproject.org
<scott.murray=konsulko.com@lists.yoctoproject.org> wrote:
> -S = "${WORKDIR}/git/libselinux"
> +S = "${UNPACKDIR}/${BP}/libselinux"

This is correct...

> -S = "${WORKDIR}/git/libsemanage"

...but how can this be correct? In the absence of S in the recipe,
default S from bitbake.conf is used, that default is set to
${UNPACKDIR}/${BP}, which doesn't include the 'libsemanage' suffix.

There are several other spots in the patch with the same inconsistency.

Alex

