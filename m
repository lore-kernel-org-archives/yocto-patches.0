Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824FFF887E
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:57:33 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14892.1777478249183737805
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:57:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=guJ8BsNJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d880e6fbbso9851311cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777478248; x=1778083048; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx0uWB3/y0iDemOSm3Er0LVH+Wgbc0EyzbeOfSfd+xk=;
        b=guJ8BsNJcvcnnNTX45iqfqIDNCXLmtmZ46GexXArLh+Cc3ooRnMVaq3y8ECG0DoBwa
         wL9ua+YwL1qC6rxS/ZeC/ULdU7p3fTO5DUj2QcXlZ9jxlI0b3Ww4bhMYrmwMQ7Zh4x0h
         xBnOVYsxFC4Qq3Ca/l06WO0lInD6Tw3ubrWoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777478248; x=1778083048;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xx0uWB3/y0iDemOSm3Er0LVH+Wgbc0EyzbeOfSfd+xk=;
        b=H9v6l3pfv67oEKBT6LqcP6zINZD5s2mtCh1qI3ISlESTDY1Cg/srVqVD3/01WSDWtI
         yi7rFQc2MwP1XqAUd+hIRHz/Ob7iN4IvvHmxaXuXZTGfg1SdgXGVHq2Igw7lE7atidfZ
         RWPzXc3N0DDhj5jyqpunTI03MF2PC00sHA8vsZ+JYSZpouq9sI81Moqr/eBi2yPVZ2sQ
         lW1088gCfN50hm6MF7FmLOeiQJ2FaVtLHfoPF65LA9EJfkvY9e3t9RfhUcegnX/0EGhs
         Bv4GcYoi4XpbMmUVUlhtgd3C21YVivRyt82brIbZNDSdzwLNkoX9sCcaZ4IFh5dDNuPn
         qjqw==
X-Gm-Message-State: AOJu0YxIThwSOthSETebT2EnGE5gPzqWw5de9FO3UWIU8r0Mof1eFMe9
	1grqADdNdEXLOuGwl2r8nR9FPCaDKP9OCLHjN8E1QW4C8in4/+MbabJjVT93dDTgmm8X2Shpllx
	yUufa
X-Gm-Gg: AeBDieuSAJsjpEq3QmigWy1B+Whv6oZy1eBxQBlZ+pEPMo7X4aQTc2rKnfctYyuRrjl
	kf/NOneVjN4y3k1kdvEpr8/Kbkap8O3Qw4CEPq4oUePxHUYsF7GUC2QZm6Yhb26qkNP6Xdn3M1i
	Db1z5g9rOnhVJUheSsJUjNLTfA+E4gP5Ighni9rKc2mjGNxEUzk//NHpvsOV9Xy4PRomZnsVBOV
	R+gWZBAg42eHuEzr2r7nrlB2hQlcKMAV4J0mJcr0qYofDe5Go4alL4rUrC6AA9BnHgnQOAodjQF
	6oSUZ+/HSxh5m+ig8H3U+hrt1M+iZGi0Gf7LIGsS1Qw8AyoJ5Fy+CYfG9hXH0oCVYGE9m1nxcRe
	ulJRXQTGcScxTOO7sizGZY9Va3WFM0AemionBL0ZRJk25yUdMSEs2kwIhMhRehXIMRjwTEpUGyH
	crmPY/UjzLV1Fg9OER3+JQIQM1YJRAPjRXSof7drYAha0yXOkU+qXDj/syvjnnPP1DStGW9bRYK
	gXdi7MT5NyeUvtbrtXb1gr3AraJUnQb4bZo5p3SzLwdWQTH6EXR/Ku+EFM41hAkcO0I
X-Received: by 2002:ac8:5813:0:b0:50d:7632:ddb2 with SMTP id d75a77b69052e-51019a37774mr48479851cf.12.1777478247542;
        Wed, 29 Apr 2026 08:57:27 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef70b5c9sm21976816d6.18.2026.04.29.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:57:27 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:57:06 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
cc: Jiaying.Song.CN@windriver.com
Subject: Re: [yocto-patches] [meta-security][PATCH] crowdsec: Fix recipe to
 match upstream source layout
In-Reply-To: <IA4PR11MB94205D035B1B00B9B862B221B82D2@IA4PR11MB9420.namprd11.prod.outlook.com>
Message-ID: <4d74e4f3-790d-1d94-027a-402e37bb7863@konsulko.com>
References: <18A675399E9F3E23.1455959@lists.yoctoproject.org> <IA4PR11MB94205D035B1B00B9B862B221B82D2@IA4PR11MB9420.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:57:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3888

On Wed, 22 Apr 2026, Song, Jiaying (CN) via lists.yoctoproject.org wrote:

> Kindly ping

Note that I made this patch irrelevant in a rewrite to fix the crowdsec
recipe so it actually builds.  While I appreciate fixes, the license file
check failing was a symptom of a larger problem.

Scott


> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org> On Behalf Of Song, Jiaying (CN) via lists.yoctoproject.org
> Sent: Wednesday, April 15, 2026 2:53 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Song, Jiaying (CN) <Jiaying.Song.CN@windriver.com>
> Subject: [yocto-patches] [meta-security][PATCH] crowdsec: Fix recipe to match upstream source layout
>
> The LICENSE file is in the repository root, not src/import/.
> The Makefile is also in the root, so do_compile should cd to ${S}.
> Fix do_install_ typo to do_install so the task actually runs.
>
> Signed-off-by: Jiaying Song <Jiaying.Song.CN@windriver.com>
> ---
>  recipes-ids/crowdsec/crowdsec_1.1.1.bb | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/recipes-ids/crowdsec/crowdsec_1.1.1.bb b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
> index fa13e9d..c7fe3dd 100644
> --- a/recipes-ids/crowdsec/crowdsec_1.1.1.bb
> +++ b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
> @@ -1,7 +1,7 @@
>  SUMMARY = "CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network."
>
>  LICENSE = "MIT"
> -LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=105e75b680b2ab82fa5718661b41f3bf"
> +LIC_FILES_CHKSUM = "file://LICENSE;md5=105e75b680b2ab82fa5718661b41f3bf"
>
>  SRC_URI = "git://github.com/crowdsecurity/crowdsec.git;branch=master;protocol=https"
>  SRCREV = "73e0bbaf93070f4a640eb5a22212b5dcf26699de"
> @@ -24,11 +24,11 @@ do_compile() {
>      export CGO_CFLAGS="${BUILDSDK_CFLAGS} --sysroot=${STAGING_DIR_TARGET}"
>      export CGO_LDFLAGS="${BUILDSDK_LDFLAGS} --sysroot=${STAGING_DIR_TARGET}"
>
> -    cd ${S}/src/import
> +    cd ${S}
>      oe_runmake release
>  }
>
> -do_install_ () {
> +do_install () {
>     chmod +x -R --silent ${B}/pkg
>  }
>
>

