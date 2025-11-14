Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FACCE8D6C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:07:56 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4740.1763143673782034441
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 10:07:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XRVXfg0A;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b26b12be9eso238174885a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763143673; x=1763748473; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vhsqGiUcMzAgUTcVn+MuVOhrE9OJzohb9m4PGTQu28=;
        b=XRVXfg0ApUWrciEWpQH1s+MwuvdY9wFD1EvdJx+9ruP5VzA0RyVoHiGhWJ4xywqvib
         Eb/IjlolBDUb1FkiE+ILFJQXz8q38Swke1Ez8W/BTzSi0UHQTYDz5DjvFH2ao4Pfj1bw
         U1PViRRKdgfAPoRiuSHS8qCgJohAxS6B1tKyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143673; x=1763748473;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vhsqGiUcMzAgUTcVn+MuVOhrE9OJzohb9m4PGTQu28=;
        b=YTt60KQvFUK8M12gqyyGPz7HQpe9ztpJT/8ixMR+7KOUwrzHFUc60pUmBxVVYc15HF
         EyPuFwopadWlztN05nqYCCDVg6JIm6fpxJbKhGvlA5l9VJWbcQsTdDwwSg1xEVrr/3AX
         G8ojQaZrM/brISRuX/PH5ZjgGu/ObLHpKicEd4oCXxe2QLbAgUvH1d896ZOniCg/QXxQ
         7hX1mn/pibOeXyT0MMy5nfBHSRMzDu8CN8qZ6ES2EVjL2gSKaIw5Cn5xs6Zb7S4TlgQ5
         /czFcBAPNy3q8sc+gerBXLB+ZSguTnpUec/mpWqEsNHD3tewtmv+kE+zZutdKSk5ayR/
         vTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNt6fwmoJ//2RWFv/ForkkZhFCsn9fmWhsfe/5gXBMl9gBCT7wFvH+CywvgCnqG+xJK8oDasehsiV4hvFt@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yxk+EVfXqCCvwyG82JYy78yvaIC6LkqiZecOr3AJitwOy9gMhnV
	gmjfoLk2iD4cX7ItKULqU7t75IAW7cZDOzDfMOITJ0CpJXb/QD+oZ9pDloJVxENnSjo=
X-Gm-Gg: ASbGncvSD/Ygh4SxZ49dsJ8FKNblnFcc50KMGdX135lQ91cnFVAnZccjrbITfYFjTmF
	zqLeyVfQkWP71rw9a1Xxjvg2RYoPS/Q/9WkVdzFkHjQPUrtI44dmrj6KWciM0baxIlclE7PEWR5
	hx7PH+jTE+9IFhYb0TXY35Or7Zn/4wlw/DR58XvxZOu63f0Qk3voT6icuuA44r/Q9i9Yv6IaY5f
	4akTlOwEae2DqavO8dycqgig07nbKQxudMg+ZvbwmFrUSPLDbLEso5HCxrAI052DFiXuUGh1flX
	THtNDOJLBv8naQrX46NS2AMIvgAywBADzB3kbbWJ+0dZIA8z+0YV5Gj5g/ZQoMZIAFAq/F4AkM5
	uTuybTFACixLnNBW6zvErecrdeR+NRYU9i6o4FCh901F2jb8+7KqUD2C2o79/9OOM0A7xtstTxa
	/1EwmRnFeG8InieemI4HflOIpEgf3K0zs+VC4=
X-Google-Smtp-Source: AGHT+IHQ3ol/0XocEqhhndNjEP5VaD5C3XRFz4Wv73lH809ADAHIClvG1h2hFcPJg0XSOqOtAFQDkg==
X-Received: by 2002:a05:620a:2892:b0:8b2:5fa9:61 with SMTP id af79cd13be357-8b2c3166457mr493553385a.25.1763143672498;
        Fri, 14 Nov 2025 10:07:52 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af042c9csm376610285a.46.2025.11.14.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:07:52 -0800 (PST)
Date: Fri, 14 Nov 2025 13:07:51 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Yi Zhao <yi.zhao@windriver.com>
cc: rybczynska@gmail.com, 
    "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-security][PATCH 1/3] openscap: upgrade
 1.4.1 -> 1.4.2
In-Reply-To: <0859aa52-03ac-4765-98e3-bab602196ba9@windriver.com>
Message-ID: <52848101-1617-59a4-2ff1-6f8156aca8c7@konsulko.com>
References: <186D6728E3F9CC27.13356@lists.yoctoproject.org> <0859aa52-03ac-4765-98e3-bab602196ba9@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-545265794-1763143672=:3510"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 18:07:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2572

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-545265794-1763143672=:3510
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Nov 2025, Yi Zhao wrote:

> Hi Scott,
>
>
> These patches were sent a few weeks ago.  Can these be merged? Thanks.

My apologies, I missed this one, will get it in in the next few days.

Thanks,

Scott


> //Yi
>
> On 10/11/25 17:53, Yi Zhao via lists.yoctoproject.org wrote:
> > ChangeLog:
> > https://github.com/OpenSCAP/openscap/releases/tag/1.4.2
> >
> > Disable building on musl as scap-security-guide already does.
> >
> > Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> > ---
> >   .../openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb}         | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >   rename recipes-compliance/openscap/{openscap_1.4.1.bb =>
> >   openscap_1.4.2.bb} (97%)
> >
> > diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb
> > b/recipes-compliance/openscap/openscap_1.4.2.bb
> > similarity index 97%
> > rename from recipes-compliance/openscap/openscap_1.4.1.bb
> > rename to recipes-compliance/openscap/openscap_1.4.2.bb
> > index 3e5f00a..f1eb647 100644
> > --- a/recipes-compliance/openscap/openscap_1.4.1.bb
> > +++ b/recipes-compliance/openscap/openscap_1.4.2.bb
> > @@ -13,7 +13,9 @@ SRC_URI =
> > "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
> >             file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch
> >             \
> >             "
> >   -SRCREV = "23a8ea3de3c4fd6017db4067675a81287177166e"
> > +SRCREV = "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
> > +
> > +COMPATIBLE_HOST:libc-musl = "null"
> >
> >   inherit cmake pkgconfig python3native python3targetconfig perlnative
> >   systemd
> >
>
>
---1463811583-545265794-1763143672=:3510--

