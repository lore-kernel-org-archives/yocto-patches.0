Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723CC3ABAA
	for <webhook@archiver.kernel.org>; Sat,  3 May 2025 13:53:11 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.11323.1746280384155539481
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 May 2025 06:53:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BO2C5/d6;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so33725576d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 May 2025 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746280383; x=1746885183; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbzTzlVLmnHrodAaLsAZSr8pGp3WhD7A56yit7Wdewg=;
        b=BO2C5/d6zIlKXEdfFg67wAXMBo055pwNm3U9sf8WjR3/XMAg3fvHG6ETHjQwMUNlNo
         zl2oOjYdHOqEUcjEup2cd1eiq9s6lNbLg3HQEFt4slH+/busk3FXbS6xXN4iJA/MyhuA
         rGscMeQF9kN8uRN7cFfNNXmtp6g1xIWU6Sfgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746280383; x=1746885183;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbzTzlVLmnHrodAaLsAZSr8pGp3WhD7A56yit7Wdewg=;
        b=Af5T+fL6cXeJuWNvEGyz1JkbsSk5ycF3zVDV6svAc6Q+WwSgvugsk+ujkdHQg09rpz
         UO8kCLK4FHC4PtqPpJmyRoWsmQpheTC5Tl03nRFlkh7Vq7B5j+RVwNp99ho7usqykFG4
         vBLmQgdBz2Mm74soI8gPdonMbX2spSdiBO7RdOXe11G3BDc0VORkr+pMsbccKa8jDMGz
         70F04lA+jbJTkm0z5IVcTZDjou+uPhV2g6YL0Nee8Xovux8+4RLAvRn2Aq0WRqEAYHFC
         W18FKADGYEcP961fKNjr0kgOvAgcMHVL89gjn3nAZy2tkLbJhGvidEFrEu2CvTX3i8zo
         HUYA==
X-Gm-Message-State: AOJu0YydvmDGvb2JPy9/5sgWjvwL61nvL5k4gz35wkE8sA6oCS10M+rs
	HHwITQrNQKJVDwIAAoZinH885HZWFpssVq2MBc0pD5HqhEsvpLWNY6Kv4oakLKK2xDopIkcko6v
	5
X-Gm-Gg: ASbGncvzRj07tktcOrUdBlHD+cRqn2I9aSJF3f5Bg2DOwydpeaGlx0siZmdFdEYzjAk
	zu3hjDvcvI7M0elpZUzAQoMQgMjv73Kx1Y7XxUqj1L18hvgEnFFIlYk8alVIPRf6BiJsxDwOtct
	zqsc8W94t+B8MvSjAQQkJKoyIgPmgISUKFAfvd4Q7Q7Y4RzO4wBQvY0a0UxcJxXuTA7C9irvMa1
	Up+R/rP9ZSovsXF7laqtijwY8qRluGGVZNWtlPUy6ODqns37PFFNtBMivCco/ZSAieuNF80WvUg
	zKEEMjNxvjXoGkRrl/EeahW1oFxFzYCqOWED4mf9T0j3ZsW5t4+7c8CEX+XjSA/rB6pt3wAJxHI
	=
X-Google-Smtp-Source: AGHT+IHPbtuLTIwl8NH3xOLAbxJV25ANvGZBcSXJdxzT3UJ+kS3Wleup23QE1LbKNMll7EYIwimAGg==
X-Received: by 2002:a05:6214:258c:b0:6f2:c88a:50b2 with SMTP id 6a1803df08f44-6f515730391mr97585146d6.3.1746280382830;
        Sat, 03 May 2025 06:53:02 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f49cbf3sm31172216d6.125.2025.05.03.06.53.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:53:02 -0700 (PDT)
Date: Sat, 3 May 2025 09:52:49 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 0/7]
 Pull in recent oe-core updates
In-Reply-To: <183B870AC2968629.4763@lists.yoctoproject.org>
Message-ID: <ebdaca1b-6c7b-cdab-ebb8-60db3972d4d5@konsulko.com>
References: <183B870AC2968629.4763@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 03 May 2025 13:53:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1480

On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series backports the recent post-1.85.1 Rust toolchain changes
> from oe-core master branch, and brings scarthgap/rust to the same level as
> the series I posted for kirkstone/rust earlier.
>
> I intend to push this series to scarthgap/rust in about 24 hours unless a
> serious showstopper is pointed out.

These changes have now been merged to scarthgap/rust.

> Changes:
>
> Deepesh Varatharajan (2):
>   rust: re-enable the unit tests that are ignored
>   rust: re-enable the unit tests that are ignored
>
> Khem Raj (2):
>   rust-llvm: Disable benchmarks by cmake options
>   cargo-c,rust: Fix build on risv32
>
> Peter Kjellerstedt (1):
>   libstd-rs: Correct the license to use Unicode-3.0
>
> Scott Murray (1):
>   Update README.md wrt dynamic layer submissions
>
> Yoann Congal (1):
>   cargo-c: Update patch Upstream-Status
>
>  README.md                                     |  37 +++
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
>  .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++++
>  .../rust/files/rust-oe-selftest.patch         | 195 ---------------
>  .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ------------------
>  recipes-devtools/rust/libstd-rs_1.85.1.bb     |   2 +-
>  .../0003-llvm-fix-include-benchmarks.patch    |  25 --
>  recipes-devtools/rust/rust-llvm_1.85.1.bb     |   2 +-
>  recipes-devtools/rust/rust-source.inc         |   2 +-
>  10 files changed, 191 insertions(+), 459 deletions(-)
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
>  delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
>
>

