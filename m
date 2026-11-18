Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5115.1795030925893534460
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 11:42:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T4/T/R0J;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53644ab1f7bso11161731cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795030925; x=1795635725; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tf4bIT2exp000CywnBoIOejjvpRWRt2MH/CT7Ww+ZPw=;
        b=T4/T/R0JCxeg6ksJsvrtgfm/8z4DsXtNFAhc1/0dZZgQ1AIax/Fm/mObHiNM/dTidu
         r1FHk4EaN50k26m1ToF97a3470v0lVV2l9dQ0cSuSvnHJuKnvld+JGuobQqzKnJFKILI
         5UvzsOUAkGW0H62unVVTt0RaM3aTPp+86DsOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030925; x=1795635725;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tf4bIT2exp000CywnBoIOejjvpRWRt2MH/CT7Ww+ZPw=;
        b=L7rKxGDHbW0N/AtZ4/gpVtqVzdIWG54pOGAXkRHnoskwFXVxMKlHHmMdAIGJ3kye+c
         pMmjR8YkIsQ6FZKBcJNOciqWfbEV3Z7wa+7JrQoD/aZH26tVagKItl9sDUKAqNEsSz6Q
         kQmqvDQB3IRcpLRgozfKJtC6Be+u6eMHi6ClSYnQKD2dQm85AytWzQHAJ1Yr1HFDTbFp
         YPlpPcPC0tTKidJgddtLv8lR4i0aiqeZ9//byL3TxmZw8Ln2EDyU9uertO4d/NE7gc1n
         LFIh47bfpJOlPbCaVcg/5785L/p6MpuCq0KKA/W8IVWOXtGmH7dRYsjsYRp2vyLsEqcd
         lPHA==
X-Gm-Message-State: APuU4Z8rScPfkc7mTIjGet4qriRXvRVIXRF4pVayqwVHxftrM0dmNUlA
	Ro2g9rb3QlZU2Areq1+qP4M1BKPiYe8AJMwqQsbTFc0cKs0c6c8nnHozvNlexxoWrMG1GPk7R7A
	BluiHsek=
X-Gm-Gg: AYBFou1FStH8f1EM4lwpzPsLhFfV9sg23QU9/gO+0B7hdSCGDLY8mzCR4EOsiahRh2k
	ItJasYMm1Rg5me62QK+cNMkf1k6d6cvHILrL1NVlnCwoaxy32Z6piMz4wDeJM0rdaMnaoDE0vVK
	8DUy9/Q8z5+6qfdQ/lI9GUnyWk50iXPeYCn8y2/keodxTbzR6fwimoiPYJo00Z/1EjozToBu5qh
	+zxK+R6vs6KYKlEargOaiC6AawRsdhiTNlD3wI4KxecBGzDSmN/hGlg276JFhPGKMZS09XQUtfm
	Sn2ooxEtHDRh0b4b5cXjy0EgHDgA+HmUQIePfPXqBxtax97PBSeWTaHoSBwObNlaXoEeyc5JnnK
	Y/2LjbzvNMbBNwERX2JixEL8UBp6UEbjmO1CXVJIy7HpStc9NWe0zr3ftQJIaAViXjikFjKlsHB
	qo1lFvRWlFJFrjwAu1Be40U5alw7D76SeRKSDjo0ryUoENCJOvUABZAKew2oOMQ5hC0ntu9I0x0
	zwY68qMLS4x5wnG6ZsR06k2ajhIQaIYzCswNf0Kw2OIOL59CKT1jBSgbgfXJ1kgMo+9cxXtke2P
	x/7F6BdjOYb8QCAlkB7T4ARqkT4SVtsjmGCo6WRtajza+3f73yE+Xl7L+RJgxOLcC3j4htU43LC
	EiBy6xFSigRCjLVan8ErrRbYn4F/ZOz8uqId2CU23+w==
X-Received: by 2002:ac8:5a96:0:b0:533:8900:4eae with SMTP id d75a77b69052e-55d5a543209mr52869011cf.13.1795030924496;
        Wed, 18 Nov 2026 11:42:04 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c4fcd1sm6971371cf.28.2026.11.18.11.42.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:42:04 -0800 (PST)
Date: Wed, 18 Nov 2026 14:41:52 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][wrynose/rust][PATCH 00/19]
 Update to 1.99.1
In-Reply-To: <18E8A975C57A5D05.1248965@lists.yoctoproject.org>
Message-ID: <b188aedf-d134-6edf-bf6f-43b4b92780ce@konsulko.com>
References: <18E8A975C57A5D05.1248965@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 19:42:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5475

On Mon, 16 Nov 2026, Scott Murray via yocto-patches wrote:

> This patch series for the wrynose/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.98.1 -> 1.99.0 -> 1.99.1 updates and other fixes.
>
> I intend to merge this series to wrynose/rust by end of day tomorrow
> (November 17, EST) unless an issue is pointed out.

These have now been merged to wrynose/rust.

Scott


> Changes:
>
> Ankur Tyagi (1):
>   librsvg: upgrade 2.63.2 -> 2.63.3
>
> Deepesh Varatharajan (1):
>   cargo-c: upgrade 0.10.25 -> 0.10.26
>
> Harish Sadineni (1):
>   rust-cross-canadian: install target-specific env scripts and fix
>     rustlib lookup
>
> Hemanth Kumar M D (2):
>   rust: Upgrade 1.98.1 -> 1.99.0
>   rust-target-config: fix invalid +v5 LLVM feature for armv5
>
> Jaipaul Cheernam (1):
>   librsvg: upgrade 2.63.3 -> 2.63.4
>
> Khem Raj (1):
>   rust-common: Use 64-bit time_t libc layouts for riscv32 musl
>
> Markus Volk (1):
>   cargo_common: map the cargo vendoring directory for the C compiler
>
> Peter Tatrai (1):
>   rust: add secure-plt to generated powerpc targets
>
> Richard Purdie (1):
>   librsvg: upgrade 2.63.0 -> 2.63.2
>
> Ross Burton (2):
>   librsvg: upgrade 2.62.3 -> 2.63.0
>   classes/cargo_c: use CARGO_C_BUILD_FLAGS for cargo-c flags
>
> Sowmya Sathram (1):
>   rust: Upgrade 1.99.0 -> 1.99.1
>
> Sunil Dora (5):
>   rust: drop the cc object-name reproducibility patch
>   rust: hash cc object names relative to their source roots
>   rust: keep the build host triple out of cargo unit metadata
>   rust: backport deterministic DocLinkResMap serialisation
>   rust: sort hygiene data before it is encoded
>
> Vasileios Anagnostopoulos (1):
>   ptest-cargo: align test and application build environments
>
>  classes-recipe/cargo_c.bbclass                |   6 +-
>  classes-recipe/cargo_common.bbclass           |   5 +
>  classes-recipe/ptest-cargo.bbclass            |  35 +-
>  classes-recipe/rust-common.bbclass            |   3 +
>  classes-recipe/rust-target-config.bbclass     |   6 +-
>  conf/layer.conf                               |   4 +-
>  recipes-devtools/cargo-c/cargo-c-crates.inc   | 332 +++----
>  ....0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} |   2 +-
>  .../rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 219 -----
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  51 +-
>  ...ommits-from-rust-Fix-selftest-llvm23.patch | 661 -------------
>  ...-host-triple-from-unit-metadata-hash.patch |  62 ++
>  ...hygiene-encoding-order-deterministic.patch |  59 ++
>  ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |  38 -
>  ...ject-names-relative-to-source-roots.patch} | 118 +--
>  .../rust/files/rust-oe-selftest.patch         |  14 +-
>  ...ibstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} |   0
>  recipes-devtools/rust/rust-cross-canadian.inc |   9 +-
>  ....98.1.bb => rust-cross-canadian_1.99.1.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       | 104 +-
>  recipes-devtools/rust/rust-source.inc         |   9 +-
>  ...source_1.98.1.bb => rust-source_1.99.1.bb} |   0
>  .../rust/{rust_1.98.1.bb => rust_1.99.1.bb}   |   2 -
>  recipes-gnome/librsvg/librsvg-crates.inc      | 924 +++++++++---------
>  ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
>  ...e-care-of-deprecated-assert_cmd-Comm.patch |   2 +-
>  .../{librsvg_2.62.3.bb => librsvg_2.63.4.bb}  |   2 +-
>  28 files changed, 934 insertions(+), 1735 deletions(-)
>  rename recipes-devtools/cargo-c/{cargo-c_0.10.25+cargo-0.99.0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} (87%)
>  rename recipes-devtools/rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  delete mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
>  create mode 100644 recipes-devtools/rust/files/0004-cargo-omit-host-triple-from-unit-metadata-hash.patch
>  create mode 100644 recipes-devtools/rust/files/0005-rustc-span-make-hygiene-encoding-order-deterministic.patch
>  delete mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
>  rename recipes-devtools/rust/files/{repro-issue-fix-with-cc-crate-hashmap.patch => cc-hash-object-names-relative-to-source-roots.patch} (68%)
>  rename recipes-devtools/rust/{libstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.98.1.bb => rust-cross-canadian_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-source_1.98.1.bb => rust-source_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.98.1.bb => rust_1.99.1.bb} (99%)
>  rename recipes-gnome/librsvg/{librsvg_2.62.3.bb => librsvg_2.63.4.bb} (98%)
>
>
