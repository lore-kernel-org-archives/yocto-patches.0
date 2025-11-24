Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7EECFD367
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 22:54:54 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4573.1764024893305458278
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 14:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AOVGPrcD;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88043139c35so48723956d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1764024892; x=1764629692; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5fG80eLwa6fRcPb8DA9bf25i5fr4VJBW8xVu/QKUx0=;
        b=AOVGPrcD12xdS0teUl9gtTpYJ/ZDuHl+89zfhW5pIRXbjEZrw+4uPYAFnz+a/BVIs9
         PDXFu5tP4ztiNVHq5xVSr57byClrBjHwCstg6z1nPLjUJ0pF2uuvshQ7w6jG2JdrMowY
         Phtnh6tkfQFeUAWFkUQuuKfy2kabjyWaKzSww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764024892; x=1764629692;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5fG80eLwa6fRcPb8DA9bf25i5fr4VJBW8xVu/QKUx0=;
        b=N/q6HBnEQEumqjakWZSN8jCp67pOmV9zwFqYeiHOCLN6QSR5kVHkeCMJ5Wj1dt6sVH
         i1tK8IV66BBKerc3pA5qQSwjf3b9gqCAcyYn/hpMRDURfBJ+pBKhHy+V6+b6vciUgBpx
         oKIWFR3ofCyDovXASQahTaYa0Fi8X35/qPnMBD1NMu2ClltaSgHgnd/o0CAHQfQGIn8I
         aXoZoOAzt2x7UXESteiTggk8a5+dr4a+E2OloT2xXbYvvowBtpOBT+0lngVhcJRU6S0Z
         HVC2sWWObYubfnj89eK3L9vijs8ahFAv8KgFSt3W8wv+Bblq8FsghFx8Dd9TaoflPApP
         jyyA==
X-Gm-Message-State: AOJu0YwdQQEqhg1GCorfNGnkMbeoHGOMPxxQbNNh2Y0sD081xEBJ47os
	2fNKo6kikXEwR8QHonsslZPqTtTG9PsIKDOAtzlyFuaZxrbBngwC5wOxICV33F4Ls8JU0gcvaSX
	JaZfL
X-Gm-Gg: ASbGncuzKYGbcifsch44H5el9Lv/t30W00Ckejmow41jzEkzmXS0mnx19b04eMAw4Q5
	9UflzhvCYWVVoZhyJjI1hbX8jhAFkPtRACFjOC/bLT14iXo04oJCRReLZrx0zyOC+pKupGwPqV3
	5BR6ujhrA5Qt6ZtxGfvd3M7mJPlHF9mcgudRSrUjUsxligwBmBYkFAw254FsmEzD76229P2Y4sN
	Qgl3w8M84/4DVyo+tN12SjEnA6cOIofhXzn/i3Pa3c2YRv/YgU0j4m9fcchTze4T/hB2qCUMFGP
	5S1TsKanog3QAxzcGfHHKCUNntxigGq7XgiWlfwvfkqsA6nR2088xhzAEE/MRo4WOPgUepzeGWh
	syOfFvwLR7cbxaLBXxjCBezigiKejGZq0DieaFOibhUcbkq2TG1Ans6WFPGbmUnzFeYBny4A96Q
	oshYw1/GiLb7QHKAnjo9nUNW7QIgLmvyEHTJMrpE9oZVJ2sQ==
X-Google-Smtp-Source: AGHT+IHaUMsmMuFLsC83pxFm1B5K3FDcCsYElKxnAXnzvw1ZZOkadmsqtA/YGX4kEMvmlXzBNsrmew==
X-Received: by 2002:a05:6214:5010:b0:879:b99b:9952 with SMTP id 6a1803df08f44-8863af15a96mr11012706d6.17.1764024891902;
        Mon, 24 Nov 2025 14:54:51 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e48f0d8sm110179286d6.25.2025.11.24.14.54.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:54:51 -0800 (PST)
Date: Mon, 24 Nov 2025 17:54:50 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 0/6] Assorted updates
In-Reply-To: <187A0B8B661E603D.1534078@lists.yoctoproject.org>
Message-ID: <35e818dc-eabb-8dc5-40fa-2fc2ceda888e@konsulko.com>
References: <187A0B8B661E603D.1534078@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 22:54:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2706

On Fri, 21 Nov 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up contributed patches from the past few weeks,
> including a couple I missed with last week's push.  They are queued on
> the master-next branch if you would like to check them out to test
> yourself.  I intend to merge these to master branch at end of day Monday
> unless there are objections.

These have now been merged to master.

Scott


> For folks looking for scarthgap updates, I've been a bit delayed, but
> am still working up a patch series, hopefully will have it out by Monday.
>
> Scott
>
>
> Louis Rannou (2):
>   openscap: fixes
>   oeqa: openscap test
>
> Yi Zhao (4):
>   openscap: upgrade 1.4.1 -> 1.4.2
>   scap-security-guide: upgrade 0.1.77 -> 0.1.78
>   libgssglue: update HOMEPAGE
>   libgssglue: add UPSTREAM_CHECK_GITTAGREGEX
>
>  lib/oeqa/runtime/cases/openscap.py            | 48 +++++++++++++++++++
>  .../{openscap_1.4.1.bb => openscap_1.4.2.bb}  |  8 ++--
>  ....1.77.bb => scap-security-guide_0.1.78.bb} |  2 +-
>  recipes-core/images/security-test-image.bb    |  2 +-
>  recipes-security/libgssglue/libgssglue_0.9.bb |  4 +-
>  5 files changed, 58 insertions(+), 6 deletions(-)
>  create mode 100644 lib/oeqa/runtime/cases/openscap.py
>  rename recipes-compliance/openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb} (94%)
>  rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} (96%)
>
>

