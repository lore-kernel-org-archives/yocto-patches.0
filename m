Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A7C3ABB6
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 20:56:20 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web11.61813.1746478572364548256
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 13:56:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dypVyIOo;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0ad74483fso58944396d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746478571; x=1747083371; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBvlYPg7MVnK2OQE+bZ3N+AxbsebeXamH36a9Fe1YCg=;
        b=dypVyIOoKm/GDh3j+kZ1z892yX8cZVkunkbo7xAYRvoDaC6Mk7fL1dN8MYfrUg7deM
         3ykljINd630OV6ZI1rRRKe4RQjr67rfV9qiYM5BORW3LccsHW9R/Y6jA7WO3D/wXC/S9
         iFk7sftMzSVohpmihm67AopDuCCJ0h+8uOgiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478571; x=1747083371;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBvlYPg7MVnK2OQE+bZ3N+AxbsebeXamH36a9Fe1YCg=;
        b=j6S9ksAOYOPqHBBcZ3CIesLHmT5yACP82l5PPL7GINujk3xPEeYVAPyY3o7TMnd5LI
         x2AKzWgmySO29IejWVlo1nuavZSO/0N1TWb4Nz+Zhblm3sRvl9XS/8E0PFjYcgERf1rj
         weevWkPpns6PD6GWcqXYL7qlin6zzaWRJAFjNvckdICwDB4ptbW8zcE7lXxsESugSWrN
         sJvn4i2kJPftagGAh6CPOpGWJliXXmTPZWSJLKU23QtRcUvIa+zbxXOPeeEF5WoIHWj5
         FyumePoPDAARTMC6iWTmRRYS4deebHXN5gmKInnBaa3tULfKiTahMXG/erJYet+lR+b0
         f9nA==
X-Gm-Message-State: AOJu0YwNGoNeDXoBlT2TEjVvArgaOpV6tN0wx1diXu/nBhaX5sykFVdw
	6TBtK+04GfQ/tdMJZ5KjfIncYZ5TkBlvD60hIUhMjZ0gRPGQMJRGekQ5FkgzdSvDA3IXWUqyNXN
	a
X-Gm-Gg: ASbGncv5NeFhOqU6hCvf2P37vbxjk2vgiHtVsQOTNs0KLBxDylV4u3NLhPJvtPodRp4
	V3aUW7bcthmbNF44ds3IF3acEqFeF8KXV1cG88q9hXaZQ+lvUwMxkHJE2u+d7neLq7xjQkaP785
	Sz+Tx8B/u4TUJeH7Ecwxwtq76FxZoH79xZlRAkj5fcCIpnEbV8LIHp1MKKkNc6811kYX5s/gZfb
	t3dQpZWWmZdIdtJGi62scokbfb4rIBl23qDxRwUCOjnxx5/9PPual3Esz+qw0ESETDmaH+0HEUc
	5LhluPjdycxJ+GdjEwm53xAAnBE6kR9oHNhn2GOmyS2Zkj79zTCCodrVTis6XAXQEatFSsgQPZ0
	=
X-Google-Smtp-Source: AGHT+IHPPWpl8UzgPgdpmBrihINydDRoxdxPNPW3F0lf7S7thJDigeID2XC06MHGKW/n4ERCfoEhWQ==
X-Received: by 2002:a05:6214:1943:b0:6e8:f2bf:7262 with SMTP id 6a1803df08f44-6f5358ee090mr6816436d6.41.1746478569714;
        Mon, 05 May 2025 13:56:09 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c382dsm60254346d6.41.2025.05.05.13.56.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:56:09 -0700 (PDT)
Date: Mon, 5 May 2025 16:56:08 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 0/7]
 Pull in recent oe-core updates
In-Reply-To: <183C08C1E6C7903B.32718@lists.yoctoproject.org>
Message-ID: <d390a052-abf8-d8a8-0d31-cdf016f3d6cb@konsulko.com>
References: <183B870AC2968629.4763@lists.yoctoproject.org> <183C08C1E6C7903B.32718@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 20:56:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1516

On Sat, 3 May 2025, Scott Murray via lists.yoctoproject.org wrote:

> On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:
>
> > This patch series backports the recent post-1.85.1 Rust toolchain changes
> > from oe-core master branch, and brings scarthgap/rust to the same level as
> > the series I posted for kirkstone/rust earlier.
> >
> > I intend to push this series to scarthgap/rust in about 24 hours unless a
> > serious showstopper is pointed out.
>
> These changes have now been merged to scarthgap/rust.

To address the ptest-cargo.bbclass issue that Peter Marko pointed out,
I've pushed the following on top of thse changes:

a8046d5 rust: Fix build with GCC-15 on aarch64/musl
6889319 ptest-cargo: fix incorrect FAIL count when multiple tests are run
08f4e69 ptest-cargo: refactor run-ptest generation to remove redundancy
138faa7 ptest-cargo: handle packageconfig arguments
8e7090d Add ptest-cargo.bbclass

This catches things up with oe-core master as of this morning.

Scott


> > Changes:
> >
> > Deepesh Varatharajan (2):
> >   rust: re-enable the unit tests that are ignored
> >   rust: re-enable the unit tests that are ignored
> >
> > Khem Raj (2):
> >   rust-llvm: Disable benchmarks by cmake options
> >   cargo-c,rust: Fix build on risv32
> >
> > Peter Kjellerstedt (1):
> >   libstd-rs: Correct the license to use Unicode-3.0
> >
> > Scott Murray (1):
> >   Update README.md wrt dynamic layer submissions
> >
> > Yoann Congal (1):
> >   cargo-c: Update patch Upstream-Status
> >
> >  README.md                                     |  37 +++
> >  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
> >  .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
> >  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++++
> >  .../rust/files/rust-oe-selftest.patch         | 195 ---------------
> >  .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ------------------
> >  recipes-devtools/rust/libstd-rs_1.85.1.bb     |   2 +-
> >  .../0003-llvm-fix-include-benchmarks.patch    |  25 --
> >  recipes-devtools/rust/rust-llvm_1.85.1.bb     |   2 +-
> >  recipes-devtools/rust/rust-source.inc         |   2 +-
> >  10 files changed, 191 insertions(+), 459 deletions(-)
> >  create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
> >  create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
> >  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
> >  delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
> >
> >
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1480): https://lists.yoctoproject.org/g/yocto-patches/message/1480
> Mute This Topic: https://lists.yoctoproject.org/mt/112570951/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

