Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D08C87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 15:12:35 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.21847.1753456351924156694
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Jul 2025 08:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ah+oSSWt;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab6e66ea68so26321461cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Jul 2025 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753456351; x=1754061151; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aSzq6UNPM3/qRbgSkzanX9YTmljneJFS2qy50uPJWQ=;
        b=Ah+oSSWt5dNm1ZAjV3+p7Hk13e8xI0Ryn8f0tAx4OBAlk7XOscx5oTCx4z6IaR+6bl
         9Q0Q/mPHnK4VGfCvg+YqSpZZNhpjI2fMrl50rI+ASS4lk6vv8ecFDC/uoJYFahReWB+n
         PF2yCPcuaWHWbEK64HVpz9DWb6/nGsxG9lkNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456351; x=1754061151;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aSzq6UNPM3/qRbgSkzanX9YTmljneJFS2qy50uPJWQ=;
        b=Nc2IlDHLCqibxSJ021AYD3Nzi9ybGIOD5PrAjBB89gUBtPspVuAj1UB9Gw7pMwwjMp
         8+dHOiI12WbzbbMWBZK3fG7JSHPL+H2vkn8f60OonlsiJ7Tw+z3I9sngUo12e07qFnN6
         7rOz7sba3UI+B8+Xrfw0AXVSED+ymCGDlfjma+1ItX/Wnn9jAMJM4S6kD4PJ13wl/x3v
         hjvUh5hkXhBZm1/EB9NH9UTFJ66j6m1Hr2hOLupLTOneaHpUFr/NDRHCOtzc4f5hUZty
         PFP70M4spA9sRb3v0DdU2g2rtCE0XZzpLmLss/D4ox9yUaBzFT5NYVTCABGu6Dz6R8cE
         dCyg==
X-Gm-Message-State: AOJu0YxjoIsNy36eWNBWZeqsoapPoe6GUIEKZy1sMi3JMC21/fyWm4PT
	QoS/i4ReUP4XtMsIhQo+c1Axc8OvfNqev0Su6S1lHm4tXXzh3zWJQEWmqQVKTOAxhRosa6pdgsF
	cquB5
X-Gm-Gg: ASbGncscB0dfYRCJlonYjb9UdRaRLwBTLyGYffPRVn4W4wYI8eh10uXvN8odZcGx/dd
	KGRIXABPP7TL1JHrzBN+yER2pKwUDdNOJBxQEvAtnB3yPbNUrQjDlgrcPHU89SwT2x5mkIdDUYk
	Zk0Tnw42pfVJIdncKXKltuOoC7LsImGKpJ8MiDpt3C80M1LZcQf4l28vQWtAy1ZbSdmBoU74IbY
	683SWtXgX3gUa4MDSpTvlyFgtm3wUzxhamgnhxnnWH/QpJQ3lGJDalRCPqYslIpCd6/tSJmKfJ8
	RTPTSdzYCTv9a8bYcTvYaTumRFiYvcTz5lKCzgYtsjYZp/ZcRsQFsCoXaJZ9xlXny1DCwE0vHLF
	cPwJ+Ew/DXLWatJKnkVTak+m5mR3A1u1/nZpf6t0YM3m61ePIWVz55j0t
X-Google-Smtp-Source: AGHT+IE0KM3peV0H/EZOYXqaaWnrSCmhXqjsfWPGaQiDV/0a6T+bPZ4X6P/F+FY4i9YYH8W9lUT3Zg==
X-Received: by 2002:a05:622a:2c3:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4ae8ef41b55mr29281031cf.13.1753456350589;
        Fri, 25 Jul 2025 08:12:30 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966e341sm1028101cf.51.2025.07.25.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:12:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:12:29 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: soumya.sambu@windriver.com
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/13]
 Update to Rust 1.87.0
In-Reply-To: <1854F6D41938F8D7.17240@lists.yoctoproject.org>
Message-ID: <40c4a877-f49c-34fa-a46e-44fe9029cd6b@konsulko.com>
References: <1854F6D41938F8D7.17240@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Jul 2025 15:12:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1873

On Wed, 23 Jul 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.85.1 -> 1.87.0 updates.  In addition to my usual smoke test
> of building librsvg and python-cryptography, etc., I did some
> experiments with the backported selftest this go around, and to my
> surprise all tests but one (a simd one) pass in my test environment.
> When I get some time, I plan to go through the selftest change history
> to see if that test can be ignored with the older kirkstone toolchain
> or not (I believe it was being ignored at one point, but need to
> double-check).  If you happen to have a strong desire to see the
> selftest working usefully with kirkstone/rust, assistance would be
> appreciated.
>
> With respect to the mozjs-* support via the dynamic-layers applied
> bbappends, I have renamed the rust bbappend that's in there so it
> won't break parsing, but from the looks of it the underlying issue
> needs to be reinvestigated, as its use of RUST_BUILD_CCLD is now
> incorrect AFAICT (results in a path into WORKDIR that is not usable).
> As well, mozjs-91 builds fine for me without that bbappend, so I
> suspect it likely will be better if it is replaced with a more
> contained mozjs-78 tweak done with a bbappend to its recipe.
> That will also make testing less painful as it will not affect
> sstate the way a rust bbappend does...
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.

I have gone ahead and merged these changes.

Scott

> Changes:
>
> Deepesh Varatharajan (1):
>   rust: re-enable the unit tests that are previously ignored
>
> Ines KCHELFI (1):
>   ptest-cargo: fix tests output format for testimage
>
> Khem Raj (2):
>   rust: Use patchelf in place of chrpath to edit rpaths
>   rust: Disable cross-unwinding support in llvm libunwind
>
> Richard Purdie (1):
>   oeqa/selftest/rust: Add exclusion to fix riscv64 builds
>
> Ross Burton (3):
>   rust: remove python3-native DEPENDS
>   rust: consolidate rust-llvm dependencies
>   rust: remove file-native DEPENDS
>
> Scott Murray (1):
>   Make dynamic layer rust bbappend version generic
>
> Yash Shinde (4):
>   rust: Upgrade 1.85.1->1.86.0
>   rust: Drop obsolete rust-lld and extended tools dependencies
>   rust: Upgrade 1.86.0 -> 1.87.0
>   cargo-c-native: Update 0.10.5 -> 0.10.13
>
>  classes/ptest-cargo.bbclass                   |  12 +-
>  classes/rust-target-config.bbclass            |   2 +-
>  conf/layer.conf                               |   2 +-
>  .../{rust_1.85.1.bbappend => rust_%.bbappend} |   0
>  lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 910 ++++++++++--------
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 -
>  ...3.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} |   3 +-
>  .../rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  32 -
>  ...bunwind-cross-architecture-unwinding.patch |  46 +
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  64 +-
>  .../Zdual-proc-macros-additional-check.patch  |  31 -
>  ...crease-timeout-in-process-sigpipe-ru.patch |   4 +-
>  ...d-statically-in-rustc_driver-feature.patch |  11 +-
>  .../rust/files/rust-oe-selftest.patch         | 254 +++--
>  recipes-devtools/rust/files/triagebot.patch   |  32 +
>  ...ibstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} |   2 +-
>  ....85.1.bb => rust-cross-canadian_1.87.0.bb} |   0
>  ...ust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} |   2 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +-
>  recipes-devtools/rust/rust-source.inc         |   5 +-
>  .../rust/{rust_1.85.1.bb => rust_1.87.0.bb}   |  29 +-
>  23 files changed, 836 insertions(+), 724 deletions(-)
>  rename dynamic-layers/meta-python/recipes-devtools/rust/{rust_1.85.1.bbappend => rust_%.bbappend} (100%)
>  delete mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} (64%)
>  rename recipes-devtools/rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} (100%)
>  create mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
>  delete mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
>  create mode 100644 recipes-devtools/rust/files/triagebot.patch
>  rename recipes-devtools/rust/{libstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} (95%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.85.1.bb => rust-cross-canadian_1.87.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.85.1.bb => rust_1.87.0.bb} (94%)
>
>

