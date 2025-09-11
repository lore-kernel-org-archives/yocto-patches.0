Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F6CCAC587
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 19:18:54 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.6102.1757618325828712183
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Sep 2025 12:18:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SGYkbPGB;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7222f8f2b44so9601046d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Sep 2025 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757618324; x=1758223124; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2e6gYPvDPkkGnwX0H8o0ezMgH7D1ZWB0fhN19NHYHA=;
        b=SGYkbPGBQrSTkC8r20xZx/qIkPFN9AXFIMzwfXA76YoEAar6taV8k+sVvYejOcCyGm
         xPExM2EciCOrFsmfIdY2t8BikzzLpeQfhmWpYMsV4U3cfjGZNk1XcC3Mi6OMaYvjvQPV
         isufXofiJncPU6ZeB4LvNE7sI3OzGjHqM5N/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618324; x=1758223124;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2e6gYPvDPkkGnwX0H8o0ezMgH7D1ZWB0fhN19NHYHA=;
        b=mvcnxqb77iLe/prcNmS0n8BAgw+EDj9bxWJsDkzDu920I9T2ey0l/lTqwZcBr4UEQv
         B27iNkt1e1AEfqQ0kWzgR4Zn7DDTwt4EJltcvYyyl60wpHVDZU07ibjf8FQ8H0KpCFag
         7NZ2/eeUAbmFyfqFn+pCK6Vq3qqe36XKuHJ1fBGqhTz2S25SFKNCZYNgdJl163/J+6Fr
         iK0ENm+ZJ5B6hS3RqXIXH7N5LyjBVFfeDfifUU7ds12I/8hIlXA9i89tJ3ebNIkZezvR
         HkJXDC0uXv1bG1MMffylCX/+R/qyAUjlgR4z3pu8mvDKS03doTLsAVlcT9RxEGzUGrVO
         ndlw==
X-Gm-Message-State: AOJu0YzM6ietOxIm24MdW515YxIg2k79E1RMeNrAisaVxSGaH6PsdvQj
	pt50vV1aVbBoyXdMq+OuuW1MhSXKAFL/Ra55OAwOjLxO1IzXkUQBqOCcdfMkLO65iCGSntd1y2n
	KIqJe
X-Gm-Gg: ASbGnctqbh8MJa/ekIZRMPv3tlKMThrb6VwL0t3mW8stOSpMKylcwmRfZTC3wx5flVG
	8RDzznnF5EdOXJVqexs17aggf1pIMV/Qn3BYUEBZ/OAKTx5d1pDTWdYb5Dd1onVVCnbdStQvVKq
	cHveVz8jOtaBM37Bvp9vreNEs6rWEzqTOywBNbdzH3yv/5lLyQdRb8HdiEYoEbzleheVlXbNJ50
	7amVNBKxET+3pHNVg3sXdHEZ5bxiTlWMaHofInhwQIOUX4nogIc9KHkIURFCncxDUnxbcProUGI
	HlQa7sFHP1bTlmGu/gjK/U8JlsoirF1AmymThU1tGN6RZLSsTl4sQs5hu9e7gcu2uksy8kHvnLm
	rE3KPvhFUB010rew7DF6Xv8rVWjKJZgqsBqv6eQmphFGGY6TLW06yWn/YfA==
X-Google-Smtp-Source: AGHT+IGHAHtL6Ote0Le7c1dozgds/2kM9pYk2G5kaf/uWCAahFzEBg3fmXkzhwmCrUnpia7PGwDJDw==
X-Received: by 2002:a05:6214:1d0c:b0:722:30ad:9382 with SMTP id 6a1803df08f44-767bb0d70ccmr6824366d6.5.1757618324424;
        Thu, 11 Sep 2025 12:18:44 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd36aeasm15485006d6.42.2025.09.11.12.18.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:18:43 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:18:43 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 0/9]
 Update to Rust 1.89.0
In-Reply-To: <1863B183615961D9.2720@lists.yoctoproject.org>
Message-ID: <0a621656-2775-fbf0-5690-fbfae5ba88ed@konsulko.com>
References: <1863B183615961D9.2720@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Sep 2025 19:18:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2181

On Tue, 9 Sep 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.88.0 -> 1.89.0 updates and other fixes.  I have also dropped
> the contributed dynamic layers bbappends since they have issues
> and Wind River have stated they're no longer using the mixin.
>
> I intend to push this series to kirkstone/rust within 24 hours
> unless a serious showstopper is pointed out.

These have now been merged to kirkstone/rust, sorry for the delay.

Scott


> Changes:
>
> Gyorgy Sarvari (2):
>   ptest-cargo.bbclass: sort binaries for reproducibility
>   rust-target-config.bbclass: move target generation before do_configure
>
> Jayasurya Maganuru (1):
>   rust: Upgrade 1.88.0 -> 1.89.0
>
> Ovidiu Panait (1):
>   rust-target-config: fix nativesdk-libstd-rs build with baremetal
>
> Per x Johansson (1):
>   rust-target-config: Add has-thread-local option
>
> Peter Marko (2):
>   recipes: cleanup CVE_STATUS which are resolved now
>   rust: handle softfp fpu
>
> Scott Murray (1):
>   Remove dynamic layer bbappends
>
> Yoann Congal (1):
>   ptest-cargo: move run-ptest rc variable initialisation
>
>  README.md                                     |   2 +-
>  classes/ptest-cargo.bbclass                   |   4 +-
>  classes/rust-target-config.bbclass            |   8 +-
>  conf/layer.conf                               |   2 +-
>  .../recipes-devtools/rust/rust_%.bbappend     |   7 --
>  .../mozjs/mozjs-78_%.bbappend                 |  14 ---
>  .../mozjs/mozjs-91_%.bbappend                 |  13 ---
>  lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
>  .../rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 101 ------------------
>  ...bunwind-cross-architecture-unwinding.patch |  46 --------
>  ...lain-syscalls-as-their-time64-varian.patch |  32 ++++++
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |   8 +-
>  ...d-statically-in-rustc_driver-feature.patch |  14 +--
>  .../rust/files/rust-oe-selftest.patch         |  13 ---
>  recipes-devtools/rust/files/triagebot.patch   |  32 ------
>  ...ibstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} |   0
>  ....88.0.bb => rust-cross-canadian_1.89.0.bb} |   0
>  ...ust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +++++++-------
>  recipes-devtools/rust/rust-source.inc         |  10 +-
>  .../rust/{rust_1.88.0.bb => rust_1.89.0.bb}   |   0
>  22 files changed, 94 insertions(+), 293 deletions(-)
>  delete mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
>  delete mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
>  delete mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
>  rename recipes-devtools/rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
>  delete mode 100644 recipes-devtools/rust/files/triagebot.patch
>  rename recipes-devtools/rust/{libstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.88.0.bb => rust-cross-canadian_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.88.0.bb => rust_1.89.0.bb} (100%)
>
>

