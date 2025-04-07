Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324ABC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:51:25 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.60575.1744062683220603705
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:51:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AuYqb/si;
 spf=pass (domain: gmail.com, ip: 209.85.161.50, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-603ff8e915aso1225457eaf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744062682; x=1744667482; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFJpMbvDWsMNWpL3WMvUcBWnJfyeXN5L/0U9gopk3nY=;
        b=AuYqb/si3PlJCp62SnuVZ3zLPsb81/tBn1JQZ90QZaaxvmEk0KJK1jxMZSSSr0KsY8
         jGJmKvhhWBarCTdXepOGjBTFTmdZr50PiSDNdHCLfWcAwBPqA2zfqaAr7++YZbZU/e1m
         jJI+oOTXs+MrfizqMN1nfZ+Uzs7ZG81kofWNCGquGv7HiqmsJfG/aK+2Ktyflb9yn89i
         tvLlt3ofsy43ejdk3nfD+eXXsUB5mGaeuTLWK6Zdn26GQAz0aiFYOTx5tucWV5IivwFW
         SRm99wrlRtOyaGLGaM6SCB9DpB35eHYks7sD5ko2rnHjv/Y625yljt3kkwuDii0KkAgJ
         /AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744062682; x=1744667482;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFJpMbvDWsMNWpL3WMvUcBWnJfyeXN5L/0U9gopk3nY=;
        b=WoTVZ4rH1EPFZPoVW9ySpQkMe2bC4aPjPrhcE+xiLJkJURd9yOXvMUQNwp7PvnEUYQ
         Z2zXcoPXP8f62za89wZVyVPZL2HMbLcjxWDe+exBueWHYmWS11byuxaBG49yhP5yp/+9
         G1ou742yy48Wq7ZFGdTEeIcOdTdjOxMBTZ0kuiLl6DHDcm+ISugTrZKnyP1quZN0MJhF
         U8jQS6tC07Ug68GNGllv9xW04KZLDuki++JjQl/zhVjTv7vt68us4JkhAysEsAIvjg7v
         boneazEQ4aXkFZyWuJavhdjXiyzHhkKofOOOxjCXyvu+2wkNRCDyHaKKEROP8OwE0/F6
         OMlw==
X-Gm-Message-State: AOJu0Yy6wFJuAjnIA2aM1AFb8Pvj+e7Br9UR4uYQAI3+xuzrT0dV4sew
	CfXLnSwsiyvBW0+a4xu44GGGnrwoRYD7pVfjlGMzG69YfcypdkIhzlQNHGd/LMljj+/fDHTFuZw
	P4GyD0B83fGVlGlXr5Gi8iDr8I+oZqccL
X-Gm-Gg: ASbGncs/Y14fW7dsLgYxahkNvNgXh4dn5AiVsrhlDfLujkNoWJGb8+KBBc4uPs1n+5T
	17kjzyhXihyplfVyRjtdxlrRovDKRRCykiBr9dDr0fvvCDrYhX2qOr7Thahc3rDuSC10XNRxGnU
	KtGnf7SYrQWcvY113O+7GgZVHK5AbZy49UOPcqBDwCf+rJLRUHjp8fe4zbQ9AEtZDaiIQ=
X-Google-Smtp-Source: AGHT+IHRyBDtPmVk0W1X7/I2uU15LGDUnRi17kkA6I24J3dj+9i5CDXnsxkhFlr5sinrUo5BcJ74Tf/jujVTD8xIYUQ=
X-Received: by 2002:a05:6820:228e:b0:601:a927:351e with SMTP id
 006d021491bc7-604200900c2mr6072200eaf.7.1744062682142; Mon, 07 Apr 2025
 14:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744061149.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 7 Apr 2025 14:50:56 -0700
X-Gm-Features: ATxdqUGufS7NLiHaVbhMPZ7678fNw6XcD8XVm2mCBWcdyYu_yUx4gOkpK-YtMMk
Message-ID: <CAMKF1srXm2pA=TyTrz58FApuiP+Jg8bhShe7HDunwMHu2DR9tg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/29]
 Update to Rust 1.85.1
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:51:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1330

On Mon, Apr 7, 2025 at 2:30=E2=80=AFPM Scott Murray via lists.yoctoproject.=
org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:
>
> This patch series for the scarthgap/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to to pull in the
> 1.81.0 -> 1.85.1 updates that have landed in the last couple of months
> in oe-core.  At this point the backported selftest (as the "rust_mixin"
> module) is passing in my environment except on qemuriscv64, which
> is currently also failing on oe-core master based on my testing.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.
>

series looks ok to me

> Changes:
>
> Alexander Kanavin (1):
>   rust: restore parallel builds, disable lto only for rustdoc
>
> Deepesh Varatharajan (11):
>   rust: Upgrade 1.81.0->1.82.0
>   rust: oe-selftest issue fix with v1.82
>   rust: Oe-selftest changes for rust v1.82.0
>   rust: Upgrade 1.82.0->1.83.0
>   rust: Fix build break because of download-ci-llvm
>   rust: Oe-selftest changes for rust v1.83.0
>   rust: Fix bloat issue in recent rust updates
>   rust: Fix build break because of "download-rustc" and "llvm-tools"
>   rust: Upgrade 1.83.0->1.84.1
>   rust: Fix build failure when multilibs are enabled
>   rust: Oe-selftest changes for rust v1.84.1
>
> Enrico Scholz (1):
>   cargo_common: use 'config.toml' instead of plain 'config'
>
> Harish Sadineni (2):
>   rust: fix for rust multilib sdk configuration
>   rust: remove redundant cargo config file
>
> Igor Opaniuk (1):
>   rust/README-rust.md: fix markdown style issues
>
> Jean-Pierre Geslin (1):
>   cargo: pass PACKAGECONFIG_CONFARGS to cargo build
>
> Khem Raj (1):
>   rust-llvm: Fix build break found with clang
>
> Martin Jansa (1):
>   cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
>
> Pedro Ferreira (1):
>   rust-common.bbclass: soft assignment for RUSTLIB path
>
> Richard Purdie (5):
>   meta/meta-selftest: Fix variable assignment whitespace
>   recipes: Drop ld-is-gold support
>   rust-source: Fix remove_gcc_directory
>   rust-llvm: Compile llvm to use dynamic libraries
>   rust-llvm: Disable libedit
>
> Sean Nyekjaer (1):
>   rust-cross-canadian: set CC_<triple> for nativesdk
>
> Yash Shinde (3):
>   rust: Update "do_update_snapshot" task for rust-snapshot.inc
>   rust: Upgrade 1.84.1->1.85.0
>   rust: Upgrade 1.85.0->1.85.1
>
>  classes-recipe/cargo.bbclass                  |   6 +-
>  classes-recipe/cargo_common.bbclass           |  20 +-
>  classes-recipe/rust-common.bbclass            |   2 +-
>  classes-recipe/rust-target-config.bbclass     |   5 +
>  classes-recipe/rust.bbclass                   |   8 +-
>  conf/layer.conf                               |   4 +-
>  files/common-licenses/Unicode-3.0             |  39 +++
>  lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
>  recipes-devtools/rust/README-rust.md          |  24 +-
>  .../rust/{cargo_1.81.0.bb =3D> cargo_1.85.1.bb} |  13 +
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 ++++
>  .../Zdual-proc-macros-additional-check.patch  |  31 +++
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 +++++--
>  ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++++++
>  .../rust/files/rust-oe-selftest.patch         | 152 ++++++++---
>  ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
>  .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ------
>  .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ++++++++++++++++++
>  .../rust/files/rv32-rustix-libc-backend.patch |  33 ---
>  .../rust/files/zlib-off64_t.patch             |  31 ---
>  ...ibstd-rs_1.81.0.bb =3D> libstd-rs_1.85.1.bb} |   9 +-
>  recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
>  ....81.0.bb =3D> rust-cross-canadian_1.85.1.bb} |   0
>  ...ust-llvm_1.81.0.bb =3D> rust-llvm_1.85.1.bb} |   8 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  81 +++---
>  recipes-devtools/rust/rust-source.inc         |  10 +-
>  .../rust/{rust_1.81.0.bb =3D> rust_1.85.1.bb}   |  76 ++++--
>  27 files changed, 931 insertions(+), 343 deletions(-)
>  create mode 100644 files/common-licenses/Unicode-3.0
>  rename recipes-devtools/rust/{cargo_1.81.0.bb =3D> cargo_1.85.1.bb} (87%=
)
>  create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps=
-tool.rs-switch-off-lto-for-rust.patch
>  create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additio=
nal-check.patch
>  create mode 100644 recipes-devtools/rust/files/revert-link-std-staticall=
y-in-rustc_driver-feature.patch
>  delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-c=
argo-config-for-codegenunits.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28=
-fix.patch
>  create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40=
-fix.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.=
patch
>  delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
>  rename recipes-devtools/rust/{libstd-rs_1.81.0.bb =3D> libstd-rs_1.85.1.=
bb} (79%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb =3D> rust-cr=
oss-canadian_1.85.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.81.0.bb =3D> rust-llvm_1.85.1.=
bb} (93%)
>  rename recipes-devtools/rust/{rust_1.81.0.bb =3D> rust_1.85.1.bb} (81%)
>
> --
> 2.49.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1300): https://lists.yoctoproject.org/g/yocto-patches=
/message/1300
> Mute This Topic: https://lists.yoctoproject.org/mt/112142231/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334078=
6/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

