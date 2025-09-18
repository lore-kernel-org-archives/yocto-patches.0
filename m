Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A0CAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 12:43:03 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.13286.1758199373208185084
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Sep 2025 05:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fPROuJTv;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b794e9a850so7752431cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758199371; x=1758804171; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPkeCS1u988IJSfr2weiQgK/UiQPTDyiwbmOaQ2DuUw=;
        b=fPROuJTv+8WMp+m0RyPZ1K/xx5F2w2MnztmJ2E1BOL9bVWW/VGR2w/tX8Ds8qEw2sI
         825mCHt2IpE2J/mLkhsvjzTystfCmCe+kQt6yBUtR1dvz79lYJ1vNhb1YwzvBKIggWqX
         CJNsKtC8GzvxmfwF9ocKoZv9kSq07w5ygP0rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199371; x=1758804171;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPkeCS1u988IJSfr2weiQgK/UiQPTDyiwbmOaQ2DuUw=;
        b=dIScV5OwV/vhVuOQl+wnGWpcmtwFW2IrE9PAoJJRvNH7Hr8mfAY2EKCWjqyevCSsjA
         fqPxQ1lQwLQaR7YYyeG0B956k2z8iaVmVad8l2Dj4NIGuRBl1byvtM4ePblEQvK3oVw1
         sNRIYdO7yxmhoirJ3S9ffUzAUlJhfs2UBYBhANVUwEHOySxG2W7UoOHNSTkorq8ABuBz
         Vq3KPb38+iU0jHTy19xZ8QqnUe8nRSYy/anLqS+4CDLarabJYFQoV9a8tQ/Wipo/V0D/
         Lk5iyQMNB3XHtkNbnQHJaH4Ewfu/5X7yQkK5lVo6W8IGbOBhI5c5BEqr4Le+Dd6dUj3m
         yKTA==
X-Gm-Message-State: AOJu0Yx/KBb/JzhkzQOoJ/S4L15fVgLwG+9hPloMdJuvflbTFn4YjIyR
	CA8lnSpLcYQ59xQIYx/A1+uRaFNVvDgvBXt1iD1V+WVeMGEtY+nRPL8BS+AbdyTd3r6k7o0XydE
	FUOQm
X-Gm-Gg: ASbGnctR+Pd+1c0QNz6gDaLYxc80dVxoKbP28BcyMsvgbCTjt+9dMqIJvHoZ/pHPS9P
	3f1xM65ZQYqenuvFFsKKMeGQraKVd0qSpxGNawsQrTnPSHujlHvDP3+pYsEVMgEyTB+hgASQCau
	xyd6KYT7B16Qz/5iLEm0x6+qDyNwMbtjJwkFx3zi0uxYKUL5ElItrFc8WMFJW5an1bF5neYeHuG
	0WqT2+n5YtnEZLYEO0uqZxe0td5/iPhsD4fvpFAEOcaetLJuuGVskhs4PRCRfoER3zWpIBPuGSu
	LlxCA53TAuqzl98AWym45DOX2LYwKswz0ox9gRbgkpkzWHAIIUNLHSWFZYOWeeFwMdEUU4ZvcoL
	+/shwCXCiUGe7c3dhPOmpg3cdUP0+wZ4hLMclZV0sya2pKtHsD27Ouhp8EaLLKCpoCOcbbmrBy9
	kT
X-Google-Smtp-Source: AGHT+IFN1/nV0BkrEmUrrxx/P5Odo0prEbXVS+QQRHsQ01YCslE0hO/xFe8/jQ8D8BtzhecozxoMFw==
X-Received: by 2002:a05:622a:1488:b0:4b6:23d0:c89a with SMTP id d75a77b69052e-4ba676bb299mr62328751cf.37.1758199371463;
        Thu, 18 Sep 2025 05:42:51 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccd2dsm156056885a.13.2025.09.18.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:42:51 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:42:50 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <marta.rybczynska@ygreky.com>, rybczynska@gmail.com
Subject: Re: [yocto-patches] [meta-security][PATCH 5/5] lynis: update to
 3.1.5
In-Reply-To: <CAApg2=TMGYOJN0=u5-YSSaEnZC3UDjnXf_deEpWSB9pAjFJyXA@mail.gmail.com>
Message-ID: <bc3df76c-5037-46f4-ca68-b8e0fd281585@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com> <730ebbddc121016151a72d3e0bce61351a0ad365.1758138771.git.scott.murray@konsulko.com> <CAApg2=TMGYOJN0=u5-YSSaEnZC3UDjnXf_deEpWSB9pAjFJyXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-2133505461-1758199371=:17462"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 12:43:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2216

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-2133505461-1758199371=:17462
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 18 Sep 2025, Marta Rybczynska via lists.yoctoproject.org wrote:

> On Wed, Sep 17, 2025 at 10:43 PM Scott Murray via lists.yoctoproject.org
> <scott.murray=konsulko.com@lists.yoctoproject.org> wrote:
>
> > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >
> > Tested on master (whinlatter) with beaglebone-yocto
> >
> > New in version 3.1.5 (2025-07-29):
> > https://cisofy.com/changelog/lynis/#315
> >
> > Added:
> > - Support for OpenWrt
> > - Bitdefender detection on Linux
> > - Detection of openSUSE Tumbleweed-Slowroll
> >
> > Changed:
> > - Corrected detection of service manager SMF
> > - Extended GetHostID function to allow HostID and HostID2 creation on
> > OpenWrt
> > - Check modules also under /usr/lib/modules.d
> >
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > ---
> >  recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (93%)
> >
> > diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb
> > b/recipes-compliance/lynis/lynis_3.1.5.bb
> > similarity index 93%
> > rename from recipes-compliance/lynis/lynis_3.1.4.bb
> > rename to recipes-compliance/lynis/lynis_3.1.5.bb
> > index 3546a9e..3d1e8b7 100644
> > --- a/recipes-compliance/lynis/lynis_3.1.4.bb
> > +++ b/recipes-compliance/lynis/lynis_3.1.5.bb
> > @@ -8,7 +8,7 @@ LIC_FILES_CHKSUM =
> > "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
> >
> >  SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
> >
> > -SRC_URI[sha256sum] =
> > "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
> > +SRC_URI[sha256sum] =
> > "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
> >
> >  #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
> >
>
> Hello,
> I was thinking about this one, as lynis is causing issues for each new
> version. The last version is indeed  ${BPN}-${PV}.tar.gz
> <https://downloads.cisofy.com/lynis/$%7BBPN%7D-$%7BPV%7D.tar.gz>, but when
> they release, they move the previous one. Existing recipes do not work
> anymore.
>
> I think the solution would be to use their GitHub releases like
> https://github.com/CISOfy/lynis/archive/refs/tags/3.1.5.tar.gz
>
> That would avoid the need to update the link every time they release.
>
> What do you think?

Those are not reliable, as Github may regenerate them randomly.  There's
actually a QA check in oe-core (src-uri-bad) that explicitly flags such
URIs.  It may be worth asking upstream to always also put the new
releases into their archive directory on downloads.cisofy.com right away
so that the URI can stay stable.  I can imagine them not going for that,
though, based on the recommendation to always use the latest version on
their download site.

Scott
---1463811583-2133505461-1758199371=:17462--

