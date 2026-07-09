Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E802C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 03:50:18 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1653.1783569016858181324
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 20:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WDtRxOBO;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d50b0dbso84039385a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569016; x=1784173816; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zwO6dgb48rOCnhb7rhz1bQHBM5l1lCG1s9e0cCN/TD4=;
        b=WDtRxOBOTDCHOKnlctbuUa9YUeg3BUhGSoxVLSWVVZrd6/fqkDj0zWpWxomPrVw/j9
         dD/TRruQoNg4q/iqlePGiZ+E8aw8VAnyR6g3D6w/YrCg7W8u5/1OUngvgLXAbYe1g6rJ
         zahOVa8ZRxQxc/okVJsTSMgILhmPI8iQFeAKFMh5f6ZcxHhMri9HWhxu3t6u1HEMReM0
         VuXROpIKf+hIG0fEQn90geeo8SiPRbkMrzpoKTJ6wKi828TXrZ5OB7qx2iauT5j/icKA
         NgrnX4mdp+WKh7hviBmL2VV1Qiy3lpmxMuGRuBawHJBqFR0OrSyVTBe7Qu26Gm3QQ/y6
         kQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569016; x=1784173816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwO6dgb48rOCnhb7rhz1bQHBM5l1lCG1s9e0cCN/TD4=;
        b=ArBXzPHTXgW1h4aMyV8uXlz0aJ+tjPb0uhSlV061I4tMRc7OjJlW4JtIoQjnAlL1PP
         CKRKvuL5jS++M7sof/9AtIgssQGYN9iB8Ep01VaDExIGlfNO6qQDSu8/WKj0cRLNO8sm
         rUK4W05wlhLE2MMMIBlr9p9frnRQU9D4mq7OXYiH/7hf2WCVU4W08Oj6c7/5XbQwo+DI
         tuNffECqGUs5XYmQlagzSVq7aODIOLdY3FnteHF2dSBNBqF7zbuf/kCG6zA6hzolVUUc
         GY2iTZE00rtV/ilJrGcA5xj6CByxghAlFB+Eqe8Ra6x/lV8Iu5l3o7k5x3FoMthzqLo8
         lGyw==
X-Gm-Message-State: AOJu0Yys4oedY6V5gRSY1G+1iNHhqu6G/ujmMNJshXnFOI0I3h9E/1B5
	TyYmuXwDYnnjA+7QDukNONptwIKypMu80MSUtduuXCX6HHuUZXsqnQHIuZft5Q==
X-Gm-Gg: AfdE7cmY+2mR1fzexrZ7lACwszdeRqVRSSov0AdGatMvtcAfJ33D+ne4z8xGods938m
	94o71phqG7cY4m5sppobjnLPHEkI/gyGSBEr7BkLJhKPok10QOW6x3PEkBs4Bm1EYlwOZYALGcs
	jNz7QcYGt1CsAeuhSoBCbik4SRKwVNIJP449MMfNzRLdMiwvApHV9xaF6wDMgdhHyG6/wnzvhyu
	Igcbw9KEQV3p4fFGzM3gtACBy0BvAriEb71nN6r7SAwROLcii+cw6AhzT7yWwzmOAwFxkGxibVi
	I9Jt85l4dNSNVawg4C/xFTD15mWtASGudi7rQGTKyJavurF/KuLXtixD69z/CVyydTL+D3OFsFJ
	W5YnTF37pOqnw+kq3Vclgo/MNO8W2WgHnoiLiNnpDliqNXCq9HOWD+ouJdLjWc25mXoJA2boVEZ
	1o9OBAzIDi763M0JIVHWgGLszQJuXHSaA7UAWCS5SleAKwQmb5Y5S2xI4=
X-Received: by 2002:a05:620a:2802:b0:92e:c118:18a0 with SMTP id af79cd13be357-92ecf91f3e0mr542344385a.83.1783569015422;
        Wed, 08 Jul 2026 20:50:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm1516806885a.4.2026.07.08.20.50.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:50:14 -0700 (PDT)
Date: Wed, 8 Jul 2026 23:50:12 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [wic][PATCH v4 0/6] tests: standalone test-suite framework plus
 the first unit test
Message-ID: <ak8adD3nntUJyEMY@localhost.localdomain>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 03:50:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4456

Patch series applied to wic, master branch.
Thanks Paul!

On Mon 2026-07-06 @ 06:28:58 PM, Trevor Woerner wrote:
> wic has no test mechanism of its own; it relies on the oe-selftest from
> oe-core, which needs a full bitbake build to exercise even pure-Python
> logic. This series starts a small standalone suite that runs from a
> plain checkout, framework first, then the first fix, and its test.
> 
>   - the suite skeleton (pyproject test extra, pytest config, layout,
>     a justfile command runner, and a README Testing section);
>   - a conftest that imports wic once up front (stopping the session with
>     a clear message if that fails) and prints a session banner;
>   - optional coverage and ruff linting, each exposed as just recipes;
>   - a one-line fix to wic.bb.utils (import errno) so mkdirhier's OSError
>     handler works, as its own commit;
>   - unit tests for mkdirhier() that pin its behaviour and catch that
>     bug.
> 
> The suite is green at every commit and the test tree is ruff-clean.
> 
> Changes in v4 (in response to review feedback, thanks to Paul Barker):
> 
> v4 restructures the v3 10-patch series into 6 patches. How the old
> patches map to the new ones:
> 
>   - v3 1/10 (skeleton) -> v4 1/6, which also gains a justfile command
>     runner in place of the run-tests.sh wrapper and no longer creates a
>     tests/docs/ tree;
>   - v3 2/10 (conftest banner) -> v4 2/6, which also absorbs the
>     wic-import check (see next line);
>   - v3 3/10 (run-tests.sh wrapper) -> dropped; the justfile replaces it
>     and its wic-import check moves into conftest, so the check runs on
>     every invocation rather than only through the wrapper;
>   - v3 4/10 (coverage) -> v4 3/6, exposed as just recipes;
>   - v3 5/10 (ruff linting) -> v4 4/6, exposed as just recipes, with
>     ruff now pinned exactly so the clean-bar gate is reproducible;
>   - v3 8/10 (tests/** E402 ignore) -> folded into v4 4/6;
>   - v3 6/10, 7/10, 10/10 (docs README, authoring guide, review rubric)
>     -> dropped; the suite ships a short README Testing section instead
>     of a tests/docs/ tree;
>   - v3 9/10 (test plus folded-in errno fix) -> split into v4 5/6 (the
>     errno fix, on its own, first) and v4 6/6 (the tests), and the tests
>     are reframed to target mkdirhier's own behaviour rather than
>     re-testing os.makedirs.
> 
> Dependency versions were also refreshed to current releases.
> 
> Changes in v3:
> 
>   - test_bb_utils used the tmp_path fixture instead of
>     tempfile.mkdtemp(), so the tests no longer leaked scratch
>     directories under /tmp;
>   - documented the standard pytest scratch-directory controls (TMPDIR
>     and --basetemp) rather than a custom variable;
>   - added a review-rubric doc.
> 
> Changes in v2:
> 
>   - v1 was a single ~6000-line commit that used xfail markers to record
>     the bugs it found; v2 broke the work into a reviewable series where
>     each test lands green next to the fix that makes it pass, with no
>     xfails.
> 
> Trevor Woerner (6):
>   tests: add the standalone unit-test suite skeleton
>   tests: add conftest with a wic-import preflight and session banner
>   tests: add optional coverage reporting
>   add ruff linting
>   bb/utils: import errno so mkdirhier's OSError handler works
>   tests/unit/test_bb_utils: cover mkdirhier()
> 
>  .gitignore                  |  4 ++
>  README.md                   | 15 +++++++
>  justfile                    | 27 +++++++++++++
>  pyproject.toml              | 24 +++++++++++
>  src/wic/bb/utils.py         |  1 +
>  tests/conftest.py           | 28 +++++++++++++
>  tests/unit/test_bb_utils.py | 81 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 180 insertions(+)
>  create mode 100644 justfile
>  create mode 100644 tests/conftest.py
>  create mode 100644 tests/unit/test_bb_utils.py
> 
> -- 
> 2.50.0.173.g8b6f19ccfc3a

