Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C63DC55162
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 11:55:26 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9973.1785412522008534325
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Jul 2026 04:55:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Or7g/Ujf;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso128134585a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785412521; x=1786017321; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRcSYVjTfPR2nQ9fJ6/YN1Who1TnId/GobPopr+JTjE=;
        b=Or7g/Ujfq9yP18gbzXqRpcd8CN+x+KvyY5EPNgN6tHyheTK1g/sV0l2+Ig2/6OBflG
         6bDuPBF96ImT0MzcgAqX0kudzdL8NI2Y3oo22wA/c8Ykww8CZMnGxdfWQt4T48TWCUn+
         9rHzqKCqkQ2UjMyhNMDV+a2xua4QACE6Rzti8/JBhBEKUwJUkdzoju40leOgPW45stgr
         qv9Njzzr+Ok++zKn2EWhYCipx4KJoybkKMGaegdivyyOHprqxvGEwqF3VZus+iSy/jje
         qIvD6k9MOTEjvYyxGougTdYyEPEwld1PWWXPozEins63wQMo/sIlTNwcomngFwQHU/W8
         zOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412521; x=1786017321;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRcSYVjTfPR2nQ9fJ6/YN1Who1TnId/GobPopr+JTjE=;
        b=NZR5UcLFmVj0O4bLkbEgkQ/uizQGm3xdgTTryI5tNQsGklaF/eIBHxBn9F/0i6PrtM
         zYXe3jm7+Kj5/vtvOKi21exVW/7BHbQlGRl/e3kiVNw6WaJlr7AYWbilO2e3gWTBDEpm
         y4AKPGvEY9cs2AfNRP3m4pZ1+f66EAbp5pR4+lquiwBedr9O0UaSd9VfMK/jQuN+5onQ
         pGCC9qTkg2Is+MffNR3GeZCe5OHziO2uSZtJs/FHci7e/jhIMjpTA3HVw549w2LWxl7z
         /w+ubLtvmPJO2jNdWxyoIbdFVhXPFM8+DG24jiqwc1FSDjhljYjRA8LRgR0o4lpTogG3
         6lcQ==
X-Gm-Message-State: AOJu0YzV06SbjF3oMLcR/vwxAFJhcfjUMOdRdHB8XQDC8DshhtMU728N
	8wRrr/3P+YS215ylTt7JUTsDQz8N6h+nh3if4HbUTKwTuc6uOe3e8YaphVuV2w==
X-Gm-Gg: AR+sD122dG1KWDdKDeRGwko58alUFulx7MtyG38iNNhhhKrpu2GmPqA0now0j4QhUiu
	l3FoDnaHUQWE4zNafy7wrvojymbUCte1JbYu2HKIaiY11hdQx+azBo4qJJbSL/VB0SHVeUDlEso
	KNoMY/NUZjPtAEXP7UlOtcP2Rb/uRpN7C6IzWFubWrGKGiSRePjftkbC4md14z0n/FxAefQ9O2Z
	OhYLRZbIotJ5psDAwjKNA5AJx8zM4KOcMKyMgVD9w5MFuHZL93b2QMm1q6Ao99y7N8gdyVaNMpD
	AsJmUPFDQMlGfuoAa+yzPT0TqP2xKHPPiDk9WJMCFw5B4NhDChFrga/H+PAkcGjipwtYXCktQ7k
	v45FXEgzFv4MfMjhsJxMA4jng70ZOOAlc4YoClabqrQgSadtwbRfqaoi8MW7qOUiN3tXJRvqLKy
	IHWtjzqlO32AHPxcXailuVnE8D1MeweQc+S0uB6MH3x5UYtqdmnMldFUBkTzmXsA4Tsf/CBdK2Z
	tuCu7h54e5WMInaAWFMlncxJAKC9mA=
X-Received: by 2002:a05:620a:4723:b0:930:adff:9aa1 with SMTP id af79cd13be357-93485f9ac86mr239846385a.13.1785412520690;
        Thu, 30 Jul 2026 04:55:20 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e712d40bsm395562385a.27.2026.07.30.04.55.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:55:19 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:55:17 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [wic][PATCH v2 0/4] oe/path: three fixes plus
 unit coverage
Message-ID: <ams7pWxsG4ZjkuyN@localhost.localdomain>
References: <20260724115020.38079-1-twoerner@gmail.com>
 <243b9b065b08ae79eb0c2f7dd2ac9b8d18ba54f8.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <243b9b065b08ae79eb0c2f7dd2ac9b8d18ba54f8.camel@pbarker.dev>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 11:55:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4573

On Fri 2026-07-24 @ 04:04:55 PM, Paul Barker via lists.yoctoproject.org wrote:
> On Fri, 2026-07-24 at 07:50 -0400, Trevor Woerner via
> lists.yoctoproject.org wrote:
> > This series continues the standalone unit-test work, this time over
> > oe/path.py. It follows the same shape the suite settled on: each
> > source fix is its own standalone commit, and the green test module
> > lands last, so the suite passes at every commit.
> > 
> > Three fixes come first, each independent of the others:
> > 
> >   - __realpath's isdir guard assigns a bare `false`, which is not a
> >     Python name; when os.path.isdir() raises, the handler meant to
> >     absorb the error raises NameError instead. Use the builtin False.
> >   - symlink(force=True) cleared the destination through remove(), which
> >     globs its argument; a destination containing glob metacharacters
> >     could fail to match itself or match unrelated files. Remove the
> >     literal destination instead.
> >   - canonicalize('') and canonicalize(None) returned the current
> >     working directory, because os.path.realpath('') does; a stray
> >     separator injected a spurious cwd entry too. Skip empty tokens.
> > 
> > The final commit adds tests/unit/test_oe_path.py, covering oe/path's
> > own logic (join, is_path_parent, symlink, make_relative_symlink,
> > canonicalize, which_wild, realpath) and locking in the three fixes.
> > Backing any fix out turns the matching test red. The suite is green
> > and ruff-clean, and the series passes oe-core's wic oe-selftest with
> > no regressions.
> > 
> > These same three fixes and their equivalent selftest coverage have now
> > landed in OE-core (meta/lib/oe/path.py and oeqa/selftest/liboe.py),
> > where oe/path.py originates. wic vendors a copy of that module; this
> > series keeps the vendored copy from diverging by carrying the identical
> > fixes, with the coverage expressed as wic's own pytest suite.
> > 
> > Trevor Woerner (4):
> >   oe/path: fix bare `false` NameError in __realpath's isdir guard
> >   oe/path: don't glob-expand the destination in symlink(force=True)
> >   oe/path: canonicalize('') should return '' rather than the cwd
> >   tests/unit/test_oe_path: cover oe/path's own path logic
> 
> LGTM, assuming these are direct copies of what was added to OE-core.

Almost. The 3 "fix" patches are identical, but the unit test patch is
different because wic uses pytest and oe-core uses unittest. The test
coverage and what is tested are the same between them, just expressed
differently depending on the test framework.

> Best regards,
> 
> -- 
> Paul Barker
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4537): https://lists.yoctoproject.org/g/yocto-patches/message/4537
> Mute This Topic: https://lists.yoctoproject.org/mt/120424183/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 



