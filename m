Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15592CA5FA5
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 08:28:44 +0000 (UTC)
Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6495.1790843320994406658
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Oct 2026 01:28:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EQF8pmWo;
 spf=pass (domain: konsulko.com, ip: 74.125.230.230, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5337ecb5b48so12261801cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1790843320; x=1791448120; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4caWn8lmaqJNOoBeg/bJO6d7sjdrfoJlH352Zpc4ek=;
        b=EQF8pmWoOTiUKRElvdh+VHj6IZ7OLF+tX+56AfF8QLI8VA48TbN4ZePJPhthReSHg8
         31a298wVcnBHubR9sGubz496f+FJQg50L6fQwUuWPUyQYK+gG/OaOF0nawIgVJ1ctPN/
         y0/U0tHbBxA/uGdRRpYdw1ZbOzRel2xob5MO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843320; x=1791448120;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4caWn8lmaqJNOoBeg/bJO6d7sjdrfoJlH352Zpc4ek=;
        b=svEaGK4wqw6AXsGBFKPBtdFGu5e1kJXn3UiLZqV4iMFN0dRaCm6LCSYFlOPML6IEZE
         z4I9iOtqkT+jfAMZfWQBj+X3tuh50HRZv9a3QPxeDJW3GBx/ucEYPrw8VKkBUoi/OWan
         EFfAPRm8iaW3x8QxTgrHhagthA1ED7TuLEHmtXT62O7mtYx7sWYRi4gRfNiNeHkecPm1
         INJJARtYCKCsH082aJsR1pUgodEw1dw75nqvNJL7+bChTv8XysI0/iZlRGkrmV5+GLiD
         pTEnozbKGyGg/7LsjrLPQ/SeEnOAjn6g1LcRNE9bCLu592MkBMc7h1l6kzjl6OxPEGlt
         BZoQ==
X-Gm-Message-State: AFuF++ko7fz43dtc16jzFATAGlWxpR5Ww08mviUL1yRI02e6kYHItfOi
	Mn3pbPKYMn3hUT0f0+QttiDYE2MSKoAjpU9O+8gbd7DquBZh3FPUyqybDbST0QlkRowBQ3uw/7f
	DpBBu
X-Gm-Gg: AYBFou1fPvsGq9PvfNlSZNV6tvSrgdug79u2qIGHKx/dikQgCL21ioB+luQSSRU3H/8
	FLR+jNvTjGBwChMlHArUjZz1UfWBpOmr3gZW7QRay9DlVVlBIN6zKrZ/82bzNnIQtbx+Ev30RM1
	bRJ2cxdsLNDrUpdNxscrewSz5oikLzhkqIxz//NHa5ksHL2N/QE/QGRmsvLQZNVGqRj2wjy5G4q
	1ONdSgG7guBHcP+jc19OLEzknBtD7o9Tio2Za5EpfRGn1Acha1e0+cY5ZgpV+uddYjYdo8LbqkP
	h1EE4+vUAwqNlENdFaH4hiS2JDNlt+wfnyzQ2nK9+2fXLvTmEe3Jbv/7LGlN10SzIMzqPlN0uik
	tv1zzjpp1gTH8JMJHXa/gf8sSczov9rdsiI6ZU2cI1Y6BnAnn/Hgq/3Ns7tsdpKjxAJLgNFQ2Dl
	mhEjiCvo0leO5kGyMgOZPJ3FXZeNJsa3DjplrfMDMC24OJyQV6CxcysAY2imjva/uAGATe5Xac2
	26ZkV8GzKLEo6RhsS4txhy6grwhzDQItAV+59nrk2jHoACW0udv4XFYB0NOr5gdrXDM8YKUeHqW
	nkr0q96sSJcAgcz1lA==
X-Received: by 2002:ac8:588e:0:b0:530:f5b6:f007 with SMTP id d75a77b69052e-53373aa2ca4mr74782341cf.0.1790843319595;
        Thu, 01 Oct 2026 01:28:39 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53385f8294esm15063831cf.2.2026.10.01.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:28:39 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:28:38 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Khem Raj <khem.raj@oss.qualcomm.com>, raj.khem@gmail.com, 
    Martin Jansa <martin.jansa@gmail.com>, 
    Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] layer: Add blacksail YP
 6.1 to compatible releases
In-Reply-To: <18DA0F69C534A454.2741088@lists.yoctoproject.org>
Message-ID: <ccdeabb1-0901-4ca2-4861-34b74a6a1e21@konsulko.com>
References: <20260927032841.305194-1-khem.raj@oss.qualcomm.com> <18DA0F69C534A454.2741088@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 08:28:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4974

On Wed, 30 Sep 2026, Scott Murray via lists.yoctoproject.org wrote:

> Sorry for the delay on this, the timing wasn't great wrt some conference
> travel.  I'm running it through CI now just in case there's some other new
> master breakage, and aim to push it later today (CEST); I'll reply to this
> when I've pushed it to master.

CI run took a bit, but it's all green, and I have pushed this to master.

Scott


> On Sat, 26 Sep 2026, Khem Raj via lists.yoctoproject.org wrote:
>
> > Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
> > ---
> >  conf/layer.conf                | 2 +-
> >  meta-hardening/conf/layer.conf | 2 +-
> >  meta-integrity/conf/layer.conf | 2 +-
> >  meta-parsec/conf/layer.conf    | 2 +-
> >  meta-tpm/conf/layer.conf       | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/conf/layer.conf b/conf/layer.conf
> > index f0d8bba..af9b105 100644
> > --- a/conf/layer.conf
> > +++ b/conf/layer.conf
> > @@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
> >  BBFILE_PATTERN_security = "^${LAYERDIR}/"
> >  BBFILE_PRIORITY_security = "8"
> >
> > -LAYERSERIES_COMPAT_security = "wrynose"
> > +LAYERSERIES_COMPAT_security = "blacksail"
> >
> >  LAYERDEPENDS_security = "core openembedded-layer"
> >
> > diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
> > index c95371f..ef61466 100644
> > --- a/meta-hardening/conf/layer.conf
> > +++ b/meta-hardening/conf/layer.conf
> > @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
> >  BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
> >  BBFILE_PRIORITY_harden-layer = "6"
> >
> > -LAYERSERIES_COMPAT_harden-layer = "wrynose"
> > +LAYERSERIES_COMPAT_harden-layer = "blacksail"
> >
> >  LAYERDEPENDS_harden-layer = "core openembedded-layer"
> >
> > diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
> > index 22d2992..e5bdc89 100644
> > --- a/meta-integrity/conf/layer.conf
> > +++ b/meta-integrity/conf/layer.conf
> > @@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
> >  # interactive shell is enough.
> >  OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
> >
> > -LAYERSERIES_COMPAT_integrity = "wrynose"
> > +LAYERSERIES_COMPAT_integrity = "blacksail"
> >  # ima-evm-utils depends on keyutils from meta-oe
> >  LAYERDEPENDS_integrity = "core openembedded-layer"
> >
> > diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
> > index e2a7a8d..fec647b 100644
> > --- a/meta-parsec/conf/layer.conf
> > +++ b/meta-parsec/conf/layer.conf
> > @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
> >  BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
> >  BBFILE_PRIORITY_parsec-layer = "5"
> >
> > -LAYERSERIES_COMPAT_parsec-layer = "wrynose whinlatter walnascar scarthgap"
> > +LAYERSERIES_COMPAT_parsec-layer = "blacksail wrynose whinlatter walnascar scarthgap"
> >
> >  LAYERDEPENDS_parsec-layer = "core"
> >  BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
> > diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
> > index 3ea7c08..b376a93 100644
> > --- a/meta-tpm/conf/layer.conf
> > +++ b/meta-tpm/conf/layer.conf
> > @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
> >  BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
> >  BBFILE_PRIORITY_tpm-layer = "6"
> >
> > -LAYERSERIES_COMPAT_tpm-layer = "wrynose"
> > +LAYERSERIES_COMPAT_tpm-layer = "blacksail"
> >
> >  LAYERDEPENDS_tpm-layer = " \
> >      core \
> >
> >
> >
> >
> >
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4969): https://lists.yoctoproject.org/g/yocto-patches/message/4969
> Mute This Topic: https://lists.yoctoproject.org/mt/121451461/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

