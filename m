Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADEC87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 15:12:06 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web11.21836.1753456317174875319
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Jul 2025 08:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ePp4NOMI;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e278d8345aso218062385a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Jul 2025 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753456316; x=1754061116; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbUJ7FyF+Ui7V5BEhpqa1PeLS4LOjnHjqsG3bzMqXQg=;
        b=ePp4NOMIpRZUCCrDp1Nq719KfMxu3wQQWThXq9oCSmTyFhi2nsMQYsa+Ti1LqrGSOi
         OtcemUFHLoCFzQo7uegQJR3HlI94hkVtA4yFB5J55i1nfqmBysuNMCRKPzcO8xXvxbY1
         FGesuV0CD+axiTVm6RTyeCKdIb6xMwJDbly7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456316; x=1754061116;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbUJ7FyF+Ui7V5BEhpqa1PeLS4LOjnHjqsG3bzMqXQg=;
        b=mxVa2eru3xfvpFUbmH2H8HwtbWVu3LsnXULphKEkavXbemwj8KNErMUx+CsdGljlui
         7wi+edfHUW42TYn7MD1RI/MlWYL0ZBcWvOZprb5Idp8vqCVzVZ6PEuOkA20T7s6r8M9C
         /vJvisZHtKMqh4QoGavyDe8RFRf09XBtkzpvB8VblFjPPoY4d0E6tfBEDo1fCpbN8dcg
         lZMZpi6E3NnfKbAVFlJ2XuZcwW11yyxIajPDSQ8J9hG+NppA2JrOqoTLdjb8ZHGvZC9E
         Yx3dkdZGDTjpFNXSNNo3sgrI7ifOb+vDXeTHyt8WFCZO61oYnKc/lJ7xJ7lnRkBluo/j
         9BXQ==
X-Gm-Message-State: AOJu0Yzcw2+0V6VBVsF7ysInxrrSuGoGq/Di5RNdDr9an7fIllKJE2z5
	bGbGSySzQ1i9xB/Iae/qkK9V64roON3w3TjGe2RXjZxfzwC3tfzFaLdY9SpPO7lCU8t7p7t4Guv
	1QDxM
X-Gm-Gg: ASbGnctWy9G5StjUQqnQYlGm09UsUAiZV7wTd9eNYKqhSDMn/tbEi+GQGgTO0J7PzNe
	2Ovbi20ybF1C3HGY7LEZZDqXRZUDbkQ2iFZOhSUeBPxI1fXAhOg44hOJGgrvN8euLfrDSCZr0v0
	K7O7cdDjNrnyKgp/vHuB8eThMU0S5P7lGK2dydEk9UT3bOvmiK4AOJX6YYZmTKeFdVUERE4Rbwe
	kNG0lvEyzptHKgOJR5wH7Vu/GmrhRJQCPIhGZFbw5HKGtBhYVnVaJfxZxroIjznV3+cRNQR1Bh3
	gQhH1Yex+fUbh0cd3hKj98g/KRw+vw5w5j/WVSuglF4C4+VtktK3taoUKVhe5c7w6YYkdapAlDn
	Ob+niwoATwUgWatNslFHzBkqf5R/LPf4XTYo0FIcNZJWki6uwagQ+BQcd
X-Google-Smtp-Source: AGHT+IGk5z6NLIRWe9ZFhAW/ruQlh0iJm018ixLQ4ExJMV1nOhH/wv7OelbFu8AGAe/puXBfukkAag==
X-Received: by 2002:a05:620a:21d5:b0:7e6:383e:b168 with SMTP id af79cd13be357-7e63bf9d11cmr196620785a.45.1753456315868;
        Fri, 25 Jul 2025 08:11:55 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64388e98csm6065585a.69.2025.07.25.08.11.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:11:55 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:11:54 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/13]
 Update to Rust 1.87.0
In-Reply-To: <1854F5741D086CFA.17240@lists.yoctoproject.org>
Message-ID: <83d7aaaa-3730-f4bd-0507-3a4a5a21e4cf@konsulko.com>
References: <1854F5741D086CFA.17240@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Jul 2025 15:12:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1872

On Wed, 23 Jul 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.85.1 -> 1.87.0 updates.  The backported selftest (as the
> "rust_mixin" module) did pass for qemux86-64 with both 1.86.0 and
> 1.87.0 in my test environment.
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
>   rust: override DEBUG_PREFIX_MAP
>
> Yash Shinde (4):
>   rust: Upgrade 1.85.1->1.86.0
>   rust: Drop obsolete rust-lld and extended tools dependencies
>   rust: Upgrade 1.86.0 -> 1.87.0
>   cargo-c-native: Update 0.10.5 -> 0.10.13
>
>  classes-recipe/ptest-cargo.bbclass            |  12 +-
>  classes-recipe/rust-target-config.bbclass     |   2 +-
>  conf/layer.conf                               |   2 +-
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
>  recipes-devtools/rust/rust_%.bbappend         |  10 +
>  .../rust/{rust_1.85.1.bb => rust_1.87.0.bb}   |  29 +-
>  23 files changed, 846 insertions(+), 724 deletions(-)
>  delete mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} (67%)
>  rename recipes-devtools/rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} (100%)
>  create mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
>  delete mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
>  create mode 100644 recipes-devtools/rust/files/triagebot.patch
>  rename recipes-devtools/rust/{libstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} (95%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.85.1.bb => rust-cross-canadian_1.87.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} (99%)
>  create mode 100644 recipes-devtools/rust/rust_%.bbappend
>  rename recipes-devtools/rust/{rust_1.85.1.bb => rust_1.87.0.bb} (94%)
>
>

