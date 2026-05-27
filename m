Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D514CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:00:45 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15248.1779868842472530368
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 01:00:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BJki2F5/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914bb8e95c2so263421285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779868841; x=1780473641; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5Vyz9j1NH8xX2CrrGMFeSXcf6uKxUiLe1/QnSdxvCg=;
        b=BJki2F5/+Ba/yc9vCBUBiueEib8s5M4nqvEpny6pfGFLgvP0aznIVCxoboO0nXmh2d
         q8ka0WgMnydg4v8ZFTKrYkfi83eIklP24Dq0ji2EG/gWmsuJQpVYkcvtF05UhIQW0Zlc
         NEjZbGR/x9Sf1MhWKpz9izGAnWe8x23AFP78E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868841; x=1780473641;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5Vyz9j1NH8xX2CrrGMFeSXcf6uKxUiLe1/QnSdxvCg=;
        b=XGRM13juBP+9Ov96K3i/NIFrl7bexRKk1rWGFJSFU09LbydhliFBANeAD6hmkZcr5k
         C7D0zj0HzfMZ+jyC9/1eX70mA1xSn9su8zRUQ9Bdnxc4IeeLiARDoFVXv7llKaytOAme
         07XLwKaiItEo70uvWfcMvBt7CClGx0MysLf11xjj8Yoz3UGwWcq0KxX/auUr91fnvTMz
         jaIOIi7Cl1uRCXFprko2TuPkb2+n9x/1G/g6hg+H3l03nUKrYDEgOvNN6YVQQv9SyVcm
         7SdmbqjBgLkZGNW10QW/jmuA4ddF54uje/ujQCVmKrQVwa4pmhuXRZqKIaikhWb3hv4I
         U6EQ==
X-Gm-Message-State: AOJu0Yy20lMwvnAHjbsBgk9wr/jooKY7006imYxo3lHVJ411zSuH5pn4
	kqsUeVrSiPyKMbMCUZ1jYGpZmBlp/YfOrPgl7W1zAv498HfY3CvpxMle3F0usATtpXDKn6InlHj
	+MYq7fBwCKg==
X-Gm-Gg: Acq92OF/wa6MTCDiGWj5JG0aG6Wz+SO5aX2fZhyvf89oBuNRYv17Q7D8vMtKRRS9FU3
	O/XC9jqR5XCbNZci+YQnLJt0VkEJiHD7kStfDjTd9f8IiBu+rjyGDZK4iKuDVY9BKHTRMgRFFpT
	qRz41Ab66e9ZW3hseUVvXy1hPmxpF5S1GlUt7P/As15jiJjz23Zs8C87BIT5Q/jnum/9OLtLnaM
	t/gCbpA2fhwP+lMencxHaGjzAUzEro+UhfB0JbIitdV8S+pVNj3ZzP811oYRKnMk45MuxdGj8IT
	dT8TNtIE6CFNF5QPShlhpsccziziKO7xlwtkB2nyTuyFascSmCwp4TyiNDOUtOhaDCPIKv1Kw1J
	z9B7SamqBll32RqH7Pj2Y7BgLgJNYwcZiAK6SX9BvU8jmnFLKgrO1uJS8E5Wj0wQyW547dN2rBd
	AEtxMwkeOhVeWuga2nYd4A1AN5gm8oj4fJJgSOkr9v8NlLPvDOtxehxHpaJu5k0f4yNBHOP9GR5
	jPjuibX9gvfGDyYboSyCRvLgMnpwAH5jIyF9OxSX4y8HG586r4zWU2WLg==
X-Received: by 2002:a05:620a:2408:20b0:914:ba7d:160c with SMTP id af79cd13be357-914ba7d17c8mr2050694385a.35.1779868840959;
        Wed, 27 May 2026 01:00:40 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87f2903sm407235985a.32.2026.05.27.01.00.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:00:40 -0700 (PDT)
Date: Wed, 27 May 2026 04:00:39 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 05/24
In-Reply-To: <18B27F7865A0A7DC.3884864@lists.yoctoproject.org>
Message-ID: <c621c0e7-ab9b-ac6c-3c50-fd72c670d992@konsulko.com>
References: <18B27F7865A0A7DC.3884864@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:00:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4063

On Sun, 24 May 2026, Scott Murray via lists.yoctoproject.org wrote:

> My apologies for the delay in getting this out, this patch series rolls
> up the contributed patches from the past few weeks.  These changes are
> queued on the master-next branch if you would like to check them out to
> test yourself.  I intend to merge these to master branch Tuesday evening
> (CEST, May 26) unless there are objections.

These changes, and the tpm2-pkcs11 update I'd missed, have now been merged
to master branch.

Scott

> Note that there is one known issue with latest meta-oe that has blocked
> getting clean CI runs that likely will impact anyone using the dm-verity
> bbclass.  The root cause seems to be a new packaging conflict between
> lvm2 and libdevmapper after the recent upgrade in meta-oe, but I have not
> had time to try to dig into it and come up with a clean fix.  I plan to
> look at that if time permits while I am at Embedded Recipes this coming
> week.
>
> Scott
>
>
> Changes:
>
> Anton Antonov (2):
>   parsec-service: Update Parsec service version.
>   meta-parsec: Do not run Parsec CI jobs on 32bit platforms.
>
> Bin Cao (1):
>   samhain: upgrade 4.5.2 -> 4.5.3
>
> Li Zhou (3):
>   firejail: fix COMPATIBLE_MACHINE setting
>   layer.conf: correct WARN_QA
>   aide-base.bbclass: correct STAGING_AIDE_DIR
>
> Peter Marko (1):
>   tpm2-tools: make efivar optional
>
> Ross Burton (3):
>   parsec-service: assign PACKAGECONFIG in one line
>   parsec-service: do group membership modifications in useradd
>   parsec-service: update TS group name
>
> Yi Zhao (1):
>   arpwatch: fix typos
>
> jason.lau (2):
>   google-authenticator-libpam: update 1.0.9 -> 1.11
>   aide: fix pkg_postinst_ontarget shell script
>
>  .gitlab-ci.yml                                |  12 -
>  classes/aide-base.bbclass                     |   2 +-
>  kas/qemuarm-parsec.yml                        |   6 -
>  kas/qemux86-parsec.yml                        |   6 -
>  ...Fix-unnecessary-qualifications-error.patch |  50 -
>  .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
>  ...rvice_1.4.1.bb => parsec-service_1.5.0.bb} |  30 +-
>  meta-tpm/conf/layer.conf                      |   2 +-
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |   5 +-
>  recipes-ids/aide/aide_0.19.3.bb               |   4 +-
>  recipes-ids/samhain/samhain.inc               |   4 +-
>  recipes-scanners/arpwatch/arpwatch_3.3.bb     |   8 +-
>  recipes-security/Firejail/firejail_0.9.72.bb  |   5 +-
>  ...bb => google-authenticator-libpam_1.11.bb} |   4 +-
>  14 files changed, 533 insertions(+), 473 deletions(-)
>  delete mode 100644 kas/qemuarm-parsec.yml
>  delete mode 100644 kas/qemux86-parsec.yml
>  delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
>  rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.bb => parsec-service_1.5.0.bb} (78%)
>  rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)
>
>

