Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE87D2F006
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 00:41:38 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2541.1769560894679142721
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 16:41:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WRQgHVI6;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c655e0ee70so765553585a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769560893; x=1770165693; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZOETYx4pQg3Aa2bt/KlSKNc83sucJ728NCTBdTwzG0=;
        b=WRQgHVI6MeuSnFCzvbrnTENn42Ve/m8nl8T4AhyUOi0CnTO5Ql45ZsbjAo9io67MxA
         d6a9nHqcZk95EcHsgMzhdQAJGEB7ymibKmWpVK2hpjxfddw9b3Y2M7Tee0TeCIBYV4rI
         MBPe51ljVeivpbL/4IjrXKs9Fyi6wQRsK8X50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560893; x=1770165693;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZOETYx4pQg3Aa2bt/KlSKNc83sucJ728NCTBdTwzG0=;
        b=IqRE2th43yE6wkDPMn2iDWQa9PHwzVdTFa6o7dfCu40H+ktqYzGSfnlBE7WzfemL3k
         9mo1rTStLh/kSoQfDf34c/jE/8Vk5uxNs2x4FaY7nZHWZU2VAO9F7rZLeZgwQLGIRo7M
         KEezS3AoqNUpgxLzo/7pjgnCkypUtkJZR1HaJT633WDo+JNW3Tbtm8edWDgMG7O7NpmS
         gmBafQBvzK2ybC+wHFN42Zm5TFFrNw2tchqOBQwNzEn7e7zXOCoOSAN4z1Uk+HFeXbcf
         wT5yDtLIxNJn+gv3RPVTHwhyWu14sk7hYnOHwRjlAh9UgeI3WBEDogMxGHIqMLDUGfrr
         GHQA==
X-Gm-Message-State: AOJu0YzMKYQWrpXa35RVBDhIpAPSnFi8LLMACz4HuHru0GTtjYwte6Hb
	+02JZYmMO7GEuL9wtiPt5aEjxvk5gqbv8+iTn5j/mvk5KoYwkAS1zGHqUmvN+BK5uxNck+LxLJX
	JpnKLhl4=
X-Gm-Gg: AZuq6aIZp/guy1mr31xwa8mEvI2ANoQU4lnSBAFoemjLVlctBIGsibve7t/Zmt30BEy
	l6JUJBnIu8TecnHnFnYyLHZranAc6IqmcXs42wlN6y+K01O+eM6JN+O8PosP3JYu+AIUvltI4QN
	P863ne+7+zfve7daGJ8xpPbieAsGIGeD1zUVQ5KiegSI0uoGHXPjKl2Jb6U93kit9M+ne6ESSlj
	70Sy9kR4PGF4PQKSQV1ynRK9MqaRAykLhVUm/VCkc2BxEL51zpnuxISuOS5KxD17CdE900Z3cFy
	aEkY9DHPsFnk3usxDD4dq3eSvu0+yF2xB2dPeyPeAK3yV2Vo/NaSR2iY7qGHM8k3QzTVqMb96Un
	ikCeomvzFG3I7SEPLU10L8DmFIZGO/OmmiaLXlskKS2FnHa79WwPpXoOm0ZhRNiPtacB74fnBN3
	tRRe5otLzHkkOULPIVbvMxfvOrtKmfFUUCRfyqajoSdsMtjNH80azLW55ctQtALuAlSsoAyBQgz
	/8oJ4+rH4ShTLY3vPvhZJ286VuoaPVx8u4=
X-Received: by 2002:a05:620a:bcb:b0:8b2:dd0a:8809 with SMTP id af79cd13be357-8c70b92cbf2mr444710585a.89.1769560893242;
        Tue, 27 Jan 2026 16:41:33 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm7059866d6.26.2026.01.27.16.41.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 16:41:32 -0800 (PST)
Date: Tue, 27 Jan 2026 19:41:31 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/11]
 Update to Rust 1.92.0
In-Reply-To: <188E6CF1C67DE384.3837557@lists.yoctoproject.org>
Message-ID: <bccfa78b-27be-0151-2521-639da5f616c2@konsulko.com>
References: <188E6CF1C67DE384.3837557@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 00:41:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3120

On Mon, 26 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.90.0 -> 1.91.0 -> 1.91.1 -> 1.92.0 updates and other fixes.
>
> I intend to push this series to scarthgap/rust by end of day tomorrow
> (January 26, EST) unless a serious showstopper is pointed out.

These have now been merged to scarthgap/rust.

Scott

> Changes:
>
> Alexander Kanavin (3):
>   rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature
>     exclusions
>   rust-target-config.bbclass: apply signature exclusions only to
>     native/nativesdk
>   librsvg: upgrade 2.61.0 -> 2.61.3
>
> Deepesh Varatharajan (2):
>   cargo-c: update 0.10.16 -> 0.10.18
>   cargo-c: update 0.10.18 -> 0.10.19
>
> Hemanth Kumar M D (2):
>   rust: Upgrade 1.91.1 -> 1.92.0
>   rust: enable default uwtable and ignore arm no_std test
>
> Yash Shinde (4):
>   oeqa/selftest/rust: Exclude tier-check and fix openssl-sys build error
>   rust: Upgrade 1.90.0 -> 1.91.0
>   rust: remove passing tests from excluded and ignored list.
>   rust: Upgrade 1.91.0 -> 1.91.1
>
>  classes-recipe/rust-target-config.bbclass     |   9 +-
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   9 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 658 +++++++++---------
>  ...Use-libc-SYS_futex_time64-on-riscv32.patch |  36 -
>  ...1.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} |   5 +-
>  .../rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} |   0
>  ...-gcs-instead-of-gcs-target-attribute.patch |  66 --
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  20 +-
>  .../rust/files/rust-oe-selftest.patch         | 163 +----
>  ...ibstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} |   0
>  ....90.0.bb => rust-cross-canadian_1.92.0.bb} |   0
>  ...ust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} |   2 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +--
>  recipes-devtools/rust/rust-source.inc         |   3 +-
>  .../rust/{rust_1.90.0.bb => rust_1.92.0.bb}   |   4 +-
>  recipes-gnome/librsvg/librsvg-crates.inc      | 624 ++++++++---------
>  ...ld-do-not-force-disable-gdk-pixbuf-l.patch |   2 +-
>  ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
>  ...e-care-of-deprecated-assert_cmd-Comm.patch |  42 ++
>  .../{librsvg_2.61.0.bb => librsvg_2.61.3.bb}  |   4 +-
>  21 files changed, 790 insertions(+), 939 deletions(-)
>  delete mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.16+cargo-0.91.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} (70%)
>  rename recipes-devtools/rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
>  rename recipes-devtools/rust/{libstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.90.0.bb => rust-cross-canadian_1.92.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.90.0.bb => rust_1.92.0.bb} (99%)
>  create mode 100644 recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
>  rename recipes-gnome/librsvg/{librsvg_2.61.0.bb => librsvg_2.61.3.bb} (95%)
>
>

