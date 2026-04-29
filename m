Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D8CCFA13
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 16:00:43 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14866.1777478441034672488
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 09:00:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=seXi9Myy;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so1381126785a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777478440; x=1778083240; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhQ0BJz1FoNximZJnwz19CZZ4vkawUnip0ZStSMLMKw=;
        b=seXi9Myyay7z9wpdKoFqlyEN3wEYnU0jpm8dZmBSbr+lFg4uAeusLLWSjjSYrrAe80
         Gj4mc2BpOsCylyuvPoSCSm0o9u8wwFhh9pTRfxFnRj6OF+d3EuRs/wiR5vIGz5nxWh5E
         2mjtrlt/r7IR9vyHMrqY/gHxHyhVyE0Nd0wFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777478440; x=1778083240;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhQ0BJz1FoNximZJnwz19CZZ4vkawUnip0ZStSMLMKw=;
        b=sILFJIK3/WFlO/330BvTIQFEVJLrKaL5973zll5Lna3ZzSqCcvw404DrI7jU/QEAhR
         dsPzWj0B4jB+K70xwHXsVejgPbN5DrPbbbs2lEBvR2eP+dZJnUS/Hi29iaLY7T+R9DiJ
         ZagTXgjy950r36D/WaAUAv4MBT6zNM3LQeD3Ajus06MGyKpY3oUiau1O3wWLCQXInEhM
         ipgOoOstSukKlWfL2g3e1hWRFZGNDtIX/i4f2WFm5Kz47gZDlIBHwHhVf4StGx3miGC/
         f5ifhzKXNIriKr4YV/KcJm5IIjSfudfiKAh0Wf3VrT4Xv4QiT/te/5X0LNj+RhbS/Oqq
         QDsQ==
X-Gm-Message-State: AOJu0YzaDOGzf0GZ2oN2cCiJgCj+maRwKiZwMhVIX8RWoDGHORKuicP0
	zhjvz0UPZAGC67zUhEi7jOKG3zR1vZvN7Ls6yo7k/wEOix8G3hJHVfPKy8whWn4K6jjmaZbqRHf
	0gyoO
X-Gm-Gg: AeBDievEHkhP2rO6KdCNeu4DxxJFf9gnacIFm5wrccrFh+C0vS4/iHXOKLxTdD0YOoR
	LArjpUXhm5FvhXg1MqRtN7uekaNNShaD2J2bMJF4FjWbKujWS9S0vhJjHmFZ8XxgKBTygJFMbqG
	69s5nftZMb3PZzZz0rlAp1VkfImEwvz8mnqvgDIs6OmtU3WUPgMAJ41awGHhUwL1vjmMGChy2SQ
	1C8INmwYwy15OgL0SYhlKuigZuvSNneImq5W4+b0pIC9SHEHRzWSwzfRo27GC4+JqEiR/BnCVHP
	w1jwtWiceEhgp8YZroc3xh8XdGDzFAGEFrA1tsu1msUm4XLVt5pbXYY+H82BsEYV7mifamYl7B2
	1+R+gSr38Tob7X2XRNj04b5TWXWVGPmtVYVFcKOdwup1A392cma/E0au/4nnmenTE0FgJVmr1xE
	47IslyUrm0ICgzMnU3lOPfp4NEsJOpAPAiTx2efkBO87UJZFXUkauXqQ/7z/rLgo0Hfa7Ueq29z
	WeeL6rXGE0E3j1QH/KQD8gIDwJNnoo7+5WhfJRhvh+gKEaEYzXGRR1T2Q==
X-Received: by 2002:a05:620a:2981:b0:8cd:8751:2b26 with SMTP id af79cd13be357-8f7d9d0f7a1mr1134612985a.58.1777478429242;
        Wed, 29 Apr 2026 09:00:29 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f582e46sm198736285a.25.2026.04.29.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:00:28 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:00:28 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "jason.lau via lists.yoctoproject.org" <Haitao.Liu=windriver.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org, Haitao.Liu@windriver.com
Subject: Re: [yocto-patches][meta-security][PATCH] libmspack: clean up
 recipe
In-Reply-To: <20260428085124.3871627-1-haitao.liu@windriver.com>
Message-ID: <97f8f6a4-158b-a78f-cbd5-c7874e2a6a40@konsulko.com>
References: <20260428085124.3871627-1-haitao.liu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 16:00:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3889

On Tue, 28 Apr 2026, jason.lau via lists.yoctoproject.org wrote:

>  - Remove empty DEPENDS assignment (no build dependencies needed)
>  - Remove duplicate 'inherit autotools'
>
> Signed-off-by: Haitao Liu <haitao.liu@windriver.com>

Note that I've made this patch irrelevant in what I have queued on
master-next, as I've removed the recipe.  It is no longer required
by clamav, and there is a version in meta-oe that people can use
instead.

Scott


> ---
>  recipes-security/libmspack/libmspack_1.11.bb | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/recipes-security/libmspack/libmspack_1.11.bb b/recipes-security/libmspack/libmspack_1.11.bb
> index 7203dee..3642128 100644
> --- a/recipes-security/libmspack/libmspack_1.11.bb
> +++ b/recipes-security/libmspack/libmspack_1.11.bb
> @@ -2,15 +2,12 @@ SUMMARY = "A library for Microsoft compression formats"
>  HOMEPAGE = "http://www.cabextract.org.uk/libmspack/"
>  SECTION = "lib"
>  LICENSE = "LGPL-2.1-only"
> -DEPENDS = ""
>
>  LIC_FILES_CHKSUM = "file://COPYING.LIB;beginline=1;endline=2;md5=5b1fd1f66ef926b3c8a5bb00a72a28dd"
>
>  SRCREV = "305907723a4e7ab2018e58040059ffb5e77db837"
>  SRC_URI = "git://github.com/kyz/libmspack.git;branch=master;protocol=https"
>
> -inherit autotools
> -
>  S = "${UNPACKDIR}/${BP}/${BPN}"
>
>  inherit autotools
>

