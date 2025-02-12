Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68100C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 20:32:19 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.26707.1739392329287869851
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Feb 2025 12:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oAAXzIcl;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e46349b7daso2718516d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739392328; x=1739997128; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWmesIQETNg0Jq8hjZwzqeNLq7bwwqBRnAwjzWmUkNA=;
        b=oAAXzIclM9TZwB0CO4OFsXCyaGPhQ8QaDYgiccwt9/ChVg1O36v+0z/UYF34WleU0T
         0GzHx3J3esmv6kOhLXlv63gk0CMZhkw7PSghb7Qs3peIJDt40LntTRL6L0xoOsFkhiCa
         RQdBAIYzKb70QZ0SEn1u4snrNcF2xsCbCe/yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392328; x=1739997128;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWmesIQETNg0Jq8hjZwzqeNLq7bwwqBRnAwjzWmUkNA=;
        b=d54Dgoy6gnD6yw8BB8OiCYt3TIefyOlH8qaIp4Qm6/KJhTO/E8+GB469pTx+TfhRUu
         XFtFoLtZwD0ZjXOAG+NOKcKT8p2HzQdQXie0O5HggphwVcKjFINIAf0JpH6cKfLsi9gC
         zdqRy5pnfrGGoAvFEv7OsEuMYgAgb3jfHicpwtxI4y8YYCNTJVuJYqT7ddCFsipswNo2
         3c978yUs0sbzwwztuSSG0dKNpZOE625866SkWY9raRcdI8A6To8RF31PlpEAD4Ha9Fx1
         AXrlBYfiiepeJuIb+ITEJPqdezbX5K4oulWtnYB5tq8X48o3ExL8q82BzJK4RhknVMzf
         2QhQ==
X-Gm-Message-State: AOJu0YwOwIRFg7dQaBpCTUZMFlmcpE9wRdk7UE2P9KNeRLV9OUMsbyNM
	oUTZGqfQ8GmJATATtBY1tOprdgna0aP+CCdf1TUoKpyx/N+KXli2fgdKWenaAn9RnXcHFEtt31w
	u
X-Gm-Gg: ASbGncsl6wB5QMthPagQazB7Hc4GdusB7sLPk4iCmjA9dEUdL24eRgF8D6ZwL44Uw08
	x1VWVRVymcqAw9lLHFfqXhDHZneMNpnJUHfD8I3f00afmsuPRCbfYe6c8KUPxsDJwLdyR0vZp9u
	f0ApPHizKLHWP68ky42KZdB6aCK0U+EiCZWmaRFanFnhpSGwgBoHtY7itBkcJ3zJ5NdkerEfjXF
	eO9bivHXqdCljCsRaCoSB5Qi9CuIg7jIHfpU3+rhg+hM5//kEHIM/mv6Z6+7VaTS2j/epDNBDTg
	aLjF8ZkVcdV3GibjKK8Chr6HwE32+VJJsNfwKwS2ZZSmvHvU9A==
X-Google-Smtp-Source: AGHT+IGXeemzXA1HURKopQDIA4CK7wiumJFJexhDWLf7RfpNLfDdajX8uTXZX2j8c2zpELwWUeXUFA==
X-Received: by 2002:a05:6214:5186:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6e65bf39841mr15174596d6.1.1739392328052;
        Wed, 12 Feb 2025 12:32:08 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e52798f66asm14140846d6.37.2025.02.12.12.32.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:32:07 -0800 (PST)
Date: Wed, 12 Feb 2025 15:31:57 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/10]
 Update to Rust 1.81.0
In-Reply-To: <18233D76BA5A4356.9264@lists.yoctoproject.org>
Message-ID: <f3ff9c5a-7a1f-e4c6-39d8-9296f0472412@konsulko.com>
References: <18233D76BA5A4356.9264@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 20:32:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1080

On Tue, 11 Feb 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to to pull in the
> 1.80.0 -> 1.80.1 updates that have landed in the last few months in
> oe-core.  There are a couple of notable policy changes coming with
> this set:
>
> - Since librsvg 2.59.x is not buildable on kirksone due to its
>   meson 1.2.0 requirement, I am for now freezing librsvg to the
>   latest (and likely last) 2.58.x release, 2.58.5.  If that stops
>   building with newer versions of Rust, this will be re-evaluated.
> - I had included a backport of cargo-c since it is required for
>   librsvg 2.59.x, and have decided to keep it even though that
>   librsvg bump has been dropped.  The reasoning for this is to
>   simplify future backporting, and to provide some consistency
>   with the availabile version.
>
> I intend to push this series to kirkstone/rust within 24 hours
> unless a serious showstopper is pointed out.

These have now been merged to kirkstone/rust in meta-lts-mixins.

Scott


> Changes:
>
> Adrian Freihofer (1):
>   rust: increase test timeout again
>
> Alexander Kanavin (3):
>   cargo.bbclass: do not install libraries by default
>   cargo-c-native: update 0.10.3 -> 0.10.5
>   cargo-c: convert to target recipe
>
> Deepesh Varatharajan (3):
>   rust-target-config: Update the data layout for x86 , ppc , riscv64 ,
>     aarch64 and loongaarch64 targets.
>   rust: Fix for duplicate libstd.so
>   rust: Upgrade 1.80.1->1.81.0
>
> Enrico Scholz (1):
>   rust-common: add LDFLAGS to 'build-rust-cc' wrapper
>
> Scott Murray (2):
>   Add cargo-c backport
>   librsvg: upgrade to 2.58.5
>
>  README.md                                     |   4 +
>  classes/cargo.bbclass                         |   8 +-
>  classes/cargo_c.bbclass                       |  41 ++
>  classes/rust-common.bbclass                   |   2 +-
>  classes/rust-target-config.bbclass            |  18 +-
>  conf/layer.conf                               |   2 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 682 ++++++++++++++++++
>  .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |  17 +
>  .../rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} |   0
>  ...te-host-information-into-compilation.patch |  51 --
>  .../rust/files/hardcodepaths.patch            |  46 --
>  ...crease-timeout-in-process-sigpipe-ru.patch |   2 +-
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |  53 +-
>  .../rust/files/zlib-off64_t.patch             |  14 +-
>  ...ibstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} |   0
>  ....80.1.bb => rust-cross-canadian_1.81.0.bb} |   0
>  ...ust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +-
>  recipes-devtools/rust/rust-source.inc         |   4 +-
>  .../rust/{rust_1.80.1.bb => rust_1.81.0.bb}   |   2 +
>  recipes-gnome/librsvg/librsvg-crates.inc      |  10 +-
>  .../{librsvg_2.58.2.bb => librsvg_2.58.5.bb}  |   2 +-
>  22 files changed, 866 insertions(+), 170 deletions(-)
>  create mode 100644 classes/cargo_c.bbclass
>  create mode 100644 recipes-devtools/rust/cargo-c-crates.inc
>  create mode 100644 recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
>  rename recipes-devtools/rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
>  delete mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
>  rename recipes-devtools/rust/{libstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.80.1.bb => rust-cross-canadian_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.80.1.bb => rust_1.81.0.bb} (99%)
>  rename recipes-gnome/librsvg/{librsvg_2.58.2.bb => librsvg_2.58.5.bb} (96%)
>
>

