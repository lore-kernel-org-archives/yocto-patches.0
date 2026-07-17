Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6EC4451B
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 14:01:55 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14205.1784296909360159783
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 07:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dvs2HIxK;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e512a9a6bso430648085a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296908; x=1784901708; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16tuT2ST+lg1PvlPzC97/+iA4ThyO+rGF8dTgBW4Ho4=;
        b=dvs2HIxKBUQ1p8/En5Epe8Mlm6Q3p3l/dqtHZV1n8m6jKBdVsXqz9p31JRBlv6L3sV
         hNm/XaV2NZWSc2q+OuFJkFUBOVIDP/NvoQ4a386Q+0xEpi7VXMiA0ubxzc9aCCpOMQGT
         BZKFM2qQkKeQ7OKlfVg53irvBn4lz3d4ENtNe1g+nCpReixpR6OxgvBGfqDt7UVe7Qho
         vx7Hj0QXb8iS/f1cADjMikqon4mppVadXo9rp680YfuULza6ZYdytSM69FQ1xTxsOs9z
         sl7+5PDmrhcNnFWf/DAnXuHr850V1/hYUnsmtHUJoD6Lbowur/QUDZOjphKYAHCmOg2T
         vXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296908; x=1784901708;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16tuT2ST+lg1PvlPzC97/+iA4ThyO+rGF8dTgBW4Ho4=;
        b=DBZ26vLlnykh7cDMmZ8r0I67twnV1TX7PDtZ76sEHmUDfAHx29BGI9fKFx9kmV84bD
         RCPYJZRvZKbZKgcAuHsHs5u5z+Uhip5TK/S2bE3bDyrtBP8skbHVH6iSJ1s9rO9ePjNj
         j0taWbNzwaas64bIlkAJlvstLt6LXl6KgDWoLDIz2m99/YNeCR2Fdf7tA9pyWBiQWRa7
         hCCFAIKdy/EUHTKzSYIbhEhAuNppzOjT6z1J0370w2kvRV0weTTu3ubgT1sxY/D9rGmM
         y2dy0fL99oOG2dcRC7k0gkpD6RHXgFf/Oj4TQZgaKq09ARH2ydpbav88l/uPSXzm3+Fp
         d/nQ==
X-Gm-Message-State: AOJu0YxpAZKvm/YyqbVKWTt7vg0YfUA4Vdu9Jy8OYNsjUw1MQRX5j5qZ
	hdUt33txLv/ZsizIVxPor4/bUxlG27JDaeeFW6Fr188RLLWoDCykA5/sVupG1Q==
X-Gm-Gg: AfdE7cmUypO96WzEEBwQU5OoAJehiX8s4NbmV29BHVFNqRyebFfwV+A6fYgLKDpdiir
	x8so7NKMcp8zDe09Vdv1ZCH1LoR9lxw6iwJsbxDGUl8yBZMNpPMgamMd1CBMUYo/gJl9RlXpaI/
	c028YOxFBGbh3YUDPtZOdgtrg9IAUf2WYIHG33oOyKOHmrGkgY4pMDTjqsBKyf5nhjHTOvY+shJ
	AzWBZciuXEdz9dGtDv97cDOttjd9Hnyq0k6n2RAYCdzpU8EE2mYctalBGsYsCBPeS6ll/IHjyUh
	LU8jINZlF6ZTuvp6BOgsF0soCy288a/DOixJPP977HmxnL+AOfJAsD2bMiqmJ6a72sPeibsiQs8
	4PNSW7E8s/FOJmuaQYkDp5MAdBoT60tNYPFnGfUkRiUi/T1LRjEpQ79lCEt6fCPtTy8Jol2+hfd
	ncNEYqT54hUQDRT+81lt+agdMPvyssbNZljqFBHfh0oUd6
X-Received: by 2002:a05:620a:17a0:b0:92e:72a4:f28c with SMTP id af79cd13be357-930b3ed5207mr278161285a.30.1784296907846;
        Fri, 17 Jul 2026 07:01:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545ed7esm156751185a.32.2026.07.17.07.01.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:01:46 -0700 (PDT)
Date: Fri, 17 Jul 2026 10:01:44 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [wic][PATCH 0/5] ksparser: four argparse-type
 fixes plus unit coverage
Message-ID: <alo1yL1T2rX5kBfI@localhost.localdomain>
References: <20260715223226.3371498-1-twoerner@gmail.com>
 <49870a1432520f1e91fbffa168cad8d876ed4bd4.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49870a1432520f1e91fbffa168cad8d876ed4bd4.camel@pbarker.dev>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 14:01:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4502

On Thu 2026-07-16 @ 08:37:57 AM, Paul Barker via lists.yoctoproject.org wrote:
> On Wed, 2026-07-15 at 18:32 -0400, Trevor Woerner via
> lists.yoctoproject.org wrote:
> > This series continues the standalone unit-test work, this time over the
> > custom argparse types in ksparser.py: sizetype(), overheadtype(), and
> > systemidtype(). It keeps the shape the suite settled on: each source fix
> > is its own standalone commit, and the green test module lands last, so
> > the suite passes at every commit.
> > 
> > Four fixes come first, each independent of the others:
> > 
> >   - sizetype() accepted a leading minus, so "-1M" returned -1024 and
> >     "-5" returned -5120. A negative size is meaningless for every
> >     consumer (--size, --fixed-size, --offset, --extra-*-space, the empty
> >     source plugin's size=/bs=); reject it.
> >   - overheadtype()'s below-1.0 error path did "...message..." % arg with
> >     no %-placeholder, so every out-of-range value crashed with an opaque
> >     TypeError instead of the intended ArgumentTypeError. Add the missing
> >     placeholder.
> >   - overheadtype() let float('nan') and float('inf') slip past the < 1.0
> >     guard, which then multiplied the rootfs size by nan/inf downstream.
> >     Reject any non-finite factor up front.
> >   - systemidtype() converted with int(arg, 16), which also accepts a
> >     bare "82" (hex 130) and a signed "+0x82", contradicting its
> >     documented "hex between 0x1 and 0xFF" contract. Require an explicit
> >     0x prefix.
> > 
> > The final commit adds tests/unit/test_ksparser_types.py, covering the
> > three types' accepted forms, boundaries, and rejected inputs, and
> > locking in the four fixes. Backing any fix out turns the matching test
> > red. The suite is green at every commit and ruff-clean.
> > 
> > Trevor Woerner (5):
> >   ksparser: reject negative sizes in sizetype()
> >   ksparser: fix crash on out-of-range overhead factor
> >   ksparser: reject non-finite overhead factors
> >   ksparser: require an explicit 0x prefix for --system-id
> >   tests/unit/test_ksparser_types: cover ksparser's argparse types
> > 
> >  src/wic/ksparser.py               |  15 +-
> >  tests/unit/test_ksparser_types.py | 226 ++++++++++++++++++++++++++++++
> >  2 files changed, 236 insertions(+), 5 deletions(-)
> >  create mode 100644 tests/unit/test_ksparser_types.py
> 
> Hi Trevor,
> 
> This all looks good to me!
> 
> Reviewed-by: Paul Barker <paul@pbarker.dev>

Patch series applied to wic, master branch.
Thanks, Paul, for your review and support!

