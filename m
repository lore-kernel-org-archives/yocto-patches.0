Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C9D340BD
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 00:42:08 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2550.1769560918590017958
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 16:41:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=P5erTYEN;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502f101d1cfso62638051cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 16:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769560917; x=1770165717; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbyiLJLf1A4MYY9XvfuzQjEs/jp1HivRe4i/x0TNuUw=;
        b=P5erTYENLEohnpfQNxb5g/of2CR133LrHkCIj31j/x4yIDNaJG67HPqfKnKuJMeS1t
         InIhZXW6JHe2h6VsF0M0mA25wWpt+CAv6sAGyOU2k+BMvYUnkQJnEvAo3FXWq/LgemKy
         wE5LhJiUCI/3Nj5vHhncfl7ApAysQSM4xwOLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560917; x=1770165717;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbyiLJLf1A4MYY9XvfuzQjEs/jp1HivRe4i/x0TNuUw=;
        b=tsRGAg7B1e6iUVRG3wVYSrmYe2q17u1PHsUrDwfzbb0CW8EOv07gpodNuPAhcQtvjh
         9iy11NDuve7fVexakA0AR7sQ0gFNheeWkM9cLxqrIIgK1b41rrwSanw4bIziUsJPq+Js
         QFaIHlvBSaD00t47G84yUVE3rbdrCMyVsrA6YaYtJW2xJFdcoruwjzIXU9/I0Z19z324
         4x2OT52G9n9miDQG/fb9vi2hsh9O7aBiVSLFbfXWEKG5xPyru5tT4h9azcpIX63LtNkI
         xFb5WNWmhjoxH60UgGGi1AB5l6T/7c4ERwWsAq2XVq+dpr41V0+2/ckJqDr+2S7uNrnV
         qztQ==
X-Gm-Message-State: AOJu0Yyt9MksXvfz47CGQ7Zbh8HC+AS8ap1qzTMHPgxiGWpwyaYUQL9K
	z62GPwkVappIiNeAHfsO+yI2X83XsGAV1TmehvgKnftvyH8Of8ZqXMev6GESCZYUu2WCJdft1Ej
	8T8Diwmw=
X-Gm-Gg: AZuq6aLCeGbNQx8u5ZEkbGNTE5mRE4dru6V4KUrnW2pUkdh8WniZPFMqA5Dbl5TsWUQ
	iX3sIP0lsgnqowm+mFwRpoeN6/F7Q/HTpVlpAjxzuwzDlPOXqCmQmZenvRM2mRC48Acf6gCBZ7u
	cJXCMSVKwx88rnLIubjIAg9fOnH8dVHYYxgh2O8JZ+KEtLsBwZpYZDoeuxg59CJ0REGCOPwTggk
	nXJYIejCEqVkGejYIDCHLT+47Wu1yNJJF6m2CkA4x3wvPM9ja64FIeZZGC2t2iN54be7u56GyfP
	ajhklrn1ETgBUAcmE/rSUeeMhu44jXg751P4bAopGQnM1P2QZ9HuebZgJJmSdDyOYcHrSVc4ANm
	KpCVKExX1X4OreO3WyphlMIy8dQPKU36No01+ogcR4bbcNpXR1Gc7q8NCRp4CwFrpfcMH3Ef0Hr
	3WnBT9VQTr8HA7+WJ7FD65xvuqQsAcj1g1S0kn1USVBEKKe5p8/aUbzBuxlTer5K3qRh9dXxGjP
	TZcjv82foVYZWNe2yLDiMvRJHW+gqObQjc=
X-Received: by 2002:a05:622a:b:b0:4f1:ab3b:a29a with SMTP id d75a77b69052e-5032fc15151mr45423551cf.65.1769560917195;
        Tue, 27 Jan 2026 16:41:57 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cbdb47sm5577681cf.31.2026.01.27.16.41.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 16:41:56 -0800 (PST)
Date: Tue, 27 Jan 2026 19:41:56 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/10]
 Update to Rust 1.92.0
In-Reply-To: <188E6D231EF94D5B.3235750@lists.yoctoproject.org>
Message-ID: <5cfe5283-bc53-d4e2-7437-7f192d95dba1@konsulko.com>
References: <188E6D231EF94D5B.3235750@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 00:42:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3121

On Mon, 26 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.90.0 -> 1.91.0 -> 1.91.1 -> 1.92.0 updates and other fixes.
>
> I intend to push this series to kirkstone/rust by end of day tomorrow
> (January 26, EST) unless a serious showstopper is pointed out.

These have now been merged to kirkstone/rust.

Scott


> Changes:
>
> Alexander Kanavin (2):
>   rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature
>     exclusions
>   rust-target-config.bbclass: apply signature exclusions only to
>     native/nativesdk
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
>  classes/rust-target-config.bbclass            |   9 +-
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
>  16 files changed, 435 insertions(+), 620 deletions(-)
>  delete mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.16+cargo-0.91.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} (72%)
>  rename recipes-devtools/rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
>  rename recipes-devtools/rust/{libstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.90.0.bb => rust-cross-canadian_1.92.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.90.0.bb => rust_1.92.0.bb} (99%)
>
>

