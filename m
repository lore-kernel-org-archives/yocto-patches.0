Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A71CAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 17:19:56 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.862.1758907195169530872
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 10:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g4fzM+o6;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso12277301cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758907194; x=1759511994; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYry57B+raJwas7KCyYxBD1Tmr0m5wDqXCKC3GUbTM=;
        b=g4fzM+o6mHiu17PGQcfcuIAJaQ4I3NGL3mK7y1mur+Y2Fovpdfoc6aVO5BcSMRx8W9
         qogkigopD4yAMKoHlxAKID3Ds+PhYYgde7yc8UmM//5d2YAltxJr5qKykFyZDcxuYpH8
         72fv7mr7a+RO782AfugxMIJLXcCDxueb4QDUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758907194; x=1759511994;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYry57B+raJwas7KCyYxBD1Tmr0m5wDqXCKC3GUbTM=;
        b=V7mDb5zdDFgjJ+NC/QPsVET1GaTmty3I8U+8BhK9a672zeyj7G24Mf6ccA6TXZ5Kv1
         xFyEPbLWyWUEnyeWuHmzTIhEQTp3vQLPrQlnJDdMPEddNFSuWDQU0hGcEBllCt7nIA+w
         A0YAesel1+dYa7vLJt8tNV2u0YMMj89erFMYM0h5KKmKvaCBq/jy57DAuxXzLqfJdz+E
         rf6YTmbwLVrdhRaxC/cI7UZNoMiwsrhJsEquZvagGrsssqcMbZgudRfxcX6W3N86FmOe
         XdlM8kTc/MLfaPTMO+agAesTJdF3fnujYk1KmJPi5xtM4RKwbqK3mMRF74R8dasjhTs1
         m1zA==
X-Gm-Message-State: AOJu0Yx0d3HlnMGCEq96j9xwbZcbog1aysETfZ8bNwlr+8e/Qrle8sgQ
	c1YKwiai8t0nw1wAiLYs/ku3j7ErCskKTvnClV5Nn7AO+IiqWoeqg6BUeZ7i2BRPcx8=
X-Gm-Gg: ASbGncvAfA4GvuewdNca9SAJYFWgYDfEz/h/ntV2P2xGM8Tn/QjkRq7HhgvfXmBp0cU
	cCy7CbbJCCDlR4wYuLtExdG7ajj/JLehqMILlQh9VVu8331Gh21UW7VKMkZiTXgYQwK+HZKjyrt
	nWXIjPDk4MpDEWO+/AEv44ceoU4ViT7Jv4bsHlg/3y+3HA5lCtHcgmiYlkv29fqTQ5LBENJcJ5I
	iJNvQ93UUnM/2PWw4baY0J/+pBjmhmrhGSncYpjZ282i1U6LGjB6koQteCedECD6pxDXMKECKCy
	pc3O9X9RLMvZ6OlxaNtl/RoxxCP9qwxIuZysWl0yectltMLjSrBAfC7WhN+9USfFMcsmhcrU/vK
	kUMsdrxS6eUjyM1uCF/i5UbScnMAYGl2Irj8mOfWJOtSg4rtkFhljgOBiBBC6ZtsfcZjo
X-Google-Smtp-Source: AGHT+IEMCpRuH5Wv4VPqpXGbUfOw25KD53q3FE4wxA+WYIxuh1Z4Y0xAstI2jcJOSvLzFbI9DgWg5w==
X-Received: by 2002:a05:622a:480b:b0:4b7:aff5:e8c2 with SMTP id d75a77b69052e-4da4bbe4440mr99089721cf.58.1758907193889;
        Fri, 26 Sep 2025 10:19:53 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016701923csm29349106d6.36.2025.09.26.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:19:53 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:19:40 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Yi Zhao <yi.zhao@windriver.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com
Subject: Re: [meta-security][PATCH] libmhash: fix build with gcc 15
In-Reply-To: <20250926061054.1868481-1-yi.zhao@windriver.com>
Message-ID: <2ebef80a-a8eb-323b-cc9e-9a214380079c@konsulko.com>
References: <20250926061054.1868481-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 17:19:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2242

On Fri, 26 Sep 2025, Yi Zhao wrote:

> GCC 15 switched to C23 by default, which libmhash does not yet support.
> So keep using C17.

Nothing in meta-security actually uses libmhash at the moment, so I'm
curious if you have a usecase for using it standalone?  It used to be
pulled in by the aide recipe via PACKAGECONFIG, but Armin disabled that
last year with a note that newer releases will drop using it.  So my plan
is to take this patch, but unless you can confirm you need the libmhash
recipe for   something, we will drop it when aide is updated, which I
intend to do soon.

Thanks,

Scott


> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
> index f5518d2..805cf05 100644
> --- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
> +++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
> @@ -25,6 +25,8 @@ SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab24
>
>  inherit autotools-brokensep ptest multilib_header
>
> +CFLAGS += "-std=gnu17"
> +
>  do_install:append() {
>      oe_multilib_header mutils/mhash_config.h
>  }
>

