Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D4C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 19:51:27 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web11.5196.1746733883770967598
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 May 2025 12:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=l+he9bWL;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5c815f8efso137717385a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746733883; x=1747338683; darn=lists.yoctoproject.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROlkdIo80LLKr5ncvVX+A9IKJb3rBI1P+4zLEwwHX+g=;
        b=l+he9bWLtZRpSOBzskVXsEGLJgLvdZSyfivF1K71wYicF703bQu/RdJ9S2t37xIBCC
         G9ZZekc9iKR7a6gtMeUk4gR39akkFrEKV0zxL80m6kXdlB7qBKsNXlDyC5NTzG9ZdWvt
         C6YDBVbavhoufWZZejvA4mvdnzqSLk5J8wB18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746733883; x=1747338683;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROlkdIo80LLKr5ncvVX+A9IKJb3rBI1P+4zLEwwHX+g=;
        b=Bw9/JI0QFrfym7+nYva7jFAMOva8fNwXiYYVsH7xlHlTZx31BOKy4rT0MA0lXJukIV
         n55b/yf31kLcAS6kFdztOUxjM0znSo2lmUAqAky+Og8nI3gdk9hYbXvHLcwkd7Hen1B/
         TCmg+l0AC8QjJS5JLQu4SxHtqT7sSbfyDpYHsifLoCI0HO1juGbnZ/CP8ti0c/wyl9Je
         ntN1wFNnEIMLrglQLvfoIHx6dkw78MVU9cl+yHMc1siFpdMaWwlGijNaoSvDDDrDXDue
         kI82TbP7elk0gEl87kasZ4sCY3TluaHDWyM6D1dXEvvTzaCC9YtpYw9x1ZT2uw7+3Zwf
         ml9g==
X-Gm-Message-State: AOJu0YzUsOEkg2xYh3CxwFxiWVEiZV1YVSvD6Ck7kYek0z5/LlS0+XWD
	iUwnDkoEl5kkkGSKonvMaFg7Z0RM+cxkz5xvbyYLlnEwdhbufrUQNyYw22DeDiE=
X-Gm-Gg: ASbGncufKKb6pdxLqK1hAQWJnjVx6WCV5hFrYtV1vNfWLUy7kAuzUPgFDOFHKTVghbo
	qjL7WdgzBgw44Frx4T5U8G63CG0n1mDBPfusOchn2EqTT0kycy17w4o++jmcl4bQ2y8FNdA51VG
	6Fa38+Z9JpdjdIxXQ8kv0I/UM/XoHwtxJQBA4xZtBh91AsxrcnpBnpSR5VV7UFnCvy9b1YmEAtH
	MVdZAgtC955cmJYFJxKnaxoqT3A7sYK+T4fN8lrxtMhwBg83dW055vNENEjXBSiTD25qe/03Owk
	Ic0Q0YW3o32bZc8fPY/PVn1uW1PHHI6Pxis/PoWc2etu37zUUaxuLQoJi3d3s6cHDu6ToAATwNs
	=
X-Google-Smtp-Source: AGHT+IF3njrnx+AEAvPCXD1cl29aVOEpLRJMKSGZzyvlqlkgQ31klGItkSMGkiZiVGf3DfoHdIKLfA==
X-Received: by 2002:a05:620a:2985:b0:7c5:49b7:237a with SMTP id af79cd13be357-7cd01104524mr117993285a.19.1746733882678;
        Thu, 08 May 2025 12:51:22 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e429sm33402685a.1.2025.05.08.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 12:51:22 -0700 (PDT)
Date: Thu, 8 May 2025 15:51:21 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
    randy.macleod@windriver.com
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/38]
 Update to Rust 1.85.1
In-Reply-To: <CY8PR11MB79216B5AE80A363F1BDF9663818BA@CY8PR11MB7921.namprd11.prod.outlook.com>
Message-ID: <9d7b5b76-2368-a7f0-58be-e32e890d32ee@konsulko.com>
References: <183B81D633F2878F.4763@lists.yoctoproject.org> <04e8df0e-167f-1a58-86fd-145924e3e526@konsulko.com> <CY8PR11MB79216B5AE80A363F1BDF9663818BA@CY8PR11MB7921.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811583-2031833611-1746733769=:3594"
Content-ID: <a5c291e5-5816-a38f-8ee2-51dab2b4772d@spiteful.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 19:51:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1537

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-2031833611-1746733769=:3594
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <0fed5177-9541-cf53-25fd-dc322fca3dd4@spiteful.org>

On Thu, 8 May 2025, Sambu, Soumya wrote:

> Hi Scott,
>
> I have observed the following build failures which appear to be caused by the commit<https://git.yoctoproject.org/meta-lts-mixins/commit/?h=kirkstone/rust&id=5b33fe5072c224b9f644272175ff4e3ea73166f9> - "Backport newer Python setuptools-rust and setuptools":

I'm curious how widely you tested, i.e. is this all that came out of a
world build?

>   1.
> systemtap do_configure failure:
>     ERROR: QA Issue: This autoconf log indicates errors, it looked at host include and/or library paths while determining system capabilities.
>     Rerun configure task after fixing this. [configure-unsafe]
>     NOTE: Checking configure output for unrecognised options ERROR: Fatal QA errors were found, failing task.
>   2.
> python3-grpcio do_compile failure:
>     distutils.errors.CompileError: command '.../x86_64-poky-linux-gcc' failed with exit code 1
>     ...
>     cc1plus: warning: include location "/usr/include/..." is unsafe for cross-compilation [-Wpoison-system-directories]
>   3.
> python3-strict-rfc3339 do_compile failure:
>     error: invalid command 'bdist_wheel'
>     ERROR: 'python3 setup.py bdist_wheel ' execution failed.
>   4.
> python3-cson do_compile failure:
>     File ".../site-packages/setuptools/dist.py", line 350, in _normalize_version
>     normalized = str(Version(version))
>     File ".../packaging/version.py", line 198, in __init__
>     raise InvalidVersion(f"Invalid version: '{version}'")
>     setuptools.extern.packaging.version.InvalidVersion: Invalid version: 'b'1.0.9-16-gf3f2898''
>     ERROR: 'python3 setup.py bdist_wheel ' execution failed.
>
> Regards,
> Soumya

I'm not sure what you'd like me to do here.  A lot of things depend on
python3-cryptography, so it's not like I can revert the change and leave
it broken.  I could go back and make another attempt to hack the
kirkstone setuptools-rust to try to make it work for python3-cryptography
and pray I don't break someone's downstream usecase.  There's enough
entangled change history in setuptools-rust that that did not look like a
great idea the first time, hence backporting a known to work, widely
tested version.  I'm willing to look at making systemtap build, since
it's in oe-core, but jumping through hoops for everything in meta-python
is not something I can commit to.  I would take patches for the
dynamic-layers to fix them, or backports of their scarthgap branch
version if that's what it'd take...

Scott


> ________________________________
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org> on behalf of Scott Murray via lists.yoctoproject.org <scott.murray=konsulko.com@lists.yoctoproject.org>
> Sent: Tuesday, May 6, 2025 12:05 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/38] Update to Rust 1.85.1
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:
>
> > After more of a delay than I would like, here is the patch series to
> > backport the various Rust toolchain changes for the 1.81.0 -> 1.85.1
> > updates that have landed in oe-core master branch in the last several
> > months.
> >
> > The likely most impactful change for users is that in order to fix being
> > able to build python3-cryptography with Rust >= 1.83, I have had to
> > backport newer versions of python3-setuptools-rust, and more importantly,
> > python3-setuptools.  Extracting the required fixes in setuptools-rust
> > seems potentially possible, but untangling the change history in it got
> > to the point where I lost confidence in not accidentally breaking some
> > behavior relied upon by downstream users.  As such, using the tested
> > version from scarthgap branch seems a better solution for now.
> > That said, if you are a heavy Python module user, there may be some
> > potential for breakage due to the unexpected setuptools upgrade.  I have
> > not seen issues in my testing with oe-core recipes, but have not yet tried
> > a world build of all of meta-python.
> >
> > I have also included a README.me update to document my requirements /
> > guidelines for submissions of bbappends in dynamic layers.  They are
> > for the most part what I posted a few weeks back.
> >
> > I intend to push this series to kirkstone/rust in about 48 hours
> > unless a serious showstopper is pointed out.
>
> Sorry for the delay, I have now pushed this to kirkstone/rust, along with
> backporting these handful of newer commits to catch up:
>
> 83ce817 rust: Fix build with GCC-15 on aarch64/musl
> aad06c9 ptest-cargo: fix incorrect FAIL count when multiple tests are run
> 98dd739 ptest-cargo: refactor run-ptest generation to remove redundancy
> 398374c ptest-cargo: handle packageconfig arguments
>
> Hopefully this addresses the ptest-cargo issue that Peter Marko pointed
> out.  Please let me know if you see any issues.
>
> Scott
>
> > Changes:
> >
> > Alexander Kanavin (1):
> >   rust: restore parallel builds, disable lto only for rustdoc
> >
> > Deepesh Varatharajan (13):
> >   rust: Upgrade 1.81.0->1.82.0
> >   rust: oe-selftest issue fix with v1.82
> >   rust: Oe-selftest changes for rust v1.82.0
> >   rust: Upgrade 1.82.0->1.83.0
> >   rust: Fix build break because of download-ci-llvm
> >   rust: Oe-selftest changes for rust v1.83.0
> >   rust: Fix bloat issue in recent rust updates
> >   rust: Fix build break because of "download-rustc" and "llvm-tools"
> >   rust: Upgrade 1.83.0->1.84.1
> >   rust: Fix build failure when multilibs are enabled
> >   rust: Oe-selftest changes for rust v1.84.1
> >   rust: re-enable the unit tests that are ignored
> >   rust: re-enable the unit tests that are ignored
> >
> > Enrico Scholz (1):
> >   cargo_common: use 'config.toml' instead of plain 'config'
> >
> > Harish Sadineni (2):
> >   rust: fix for rust multilib sdk configuration
> >   rust: remove redundant cargo config file
> >
> > Igor Opaniuk (1):
> >   rust/README-rust.md: fix markdown style issues
> >
> > Jean-Pierre Geslin (1):
> >   cargo: pass PACKAGECONFIG_CONFARGS to cargo build
> >
> > Khem Raj (3):
> >   rust-llvm: Fix build break found with clang
> >   rust-llvm: Disable benchmarks by cmake options
> >   cargo-c,rust: Fix build on risv32
> >
> > Martin Jansa (1):
> >   cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
> >
> > Pedro Ferreira (1):
> >   rust-common.bbclass: soft assignment for RUSTLIB path
> >
> > Peter Kjellerstedt (1):
> >   libstd-rs: Correct the license to use Unicode-3.0
> >
> > Richard Purdie (5):
> >   meta/meta-selftest: Fix variable assignment whitespace
> >   recipes: Drop ld-is-gold support
> >   rust-source: Fix remove_gcc_directory
> >   rust-llvm: Compile llvm to use dynamic libraries
> >   rust-llvm: Disable libedit
> >
> > Scott Murray (3):
> >   Add selftest backport to ease maintenance
> >   Backport newer Python setuptools-rust and setuptools
> >   Update README.md wrt dynamic layer submissions
> >
> > Sean Nyekjaer (1):
> >   rust-cross-canadian: set CC_<triple> for nativesdk
> >
> > Yash Shinde (3):
> >   rust: Update "do_update_snapshot" task for rust-snapshot.inc
> >   rust: Upgrade 1.84.1->1.85.0
> >   rust: Upgrade 1.85.0->1.85.1
> >
> > Yoann Congal (1):
> >   cargo-c: Update patch Upstream-Status
> >
> >  README.md                                     |  49 ++-
> >  classes/cargo.bbclass                         |   6 +-
> >  classes/cargo_common.bbclass                  |  20 +-
> >  classes/rust-common.bbclass                   |   2 +-
> >  classes/rust-target-config.bbclass            |   5 +
> >  classes/rust.bbclass                          |   8 +-
> >  conf/layer.conf                               |   8 +-
> >  files/common-licenses/Unicode-3.0             |  39 +++
> >  lib/oeqa/selftest/cases/rust_mixin.py         | 134 ++++++++
> >  meta/lib/oeqa/selftest/cases/rust.py          |  85 -----
> >  .../packagegroup-rust-cross-canadian.bb       |   2 +-
> >  .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
> >  .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
> >  ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
> >  ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
> >  .../python3-setuptools/CVE-2024-6345.patch    | 312 ++++++++++++++++++
> >  .../python/python3-setuptools_69.1.1.bb       |  58 ++++
> >  recipes-devtools/rust/README-rust.md          |  24 +-
> >  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
> >  .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
> >  .../rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} |  13 +
> >  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++
> >  ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 +++
> >  .../Zdual-proc-macros-additional-check.patch  |  31 ++
> >  ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 ++++-
> >  ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++
> >  .../rust/files/rust-oe-selftest.patch         | 279 +++++-----------
> >  ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
> >  .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ----
> >  .../rust/files/rv32-rustix-libc-backend.patch |  33 --
> >  .../rust/files/zlib-off64_t.patch             |  31 --
> >  ...ibstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} |  11 +-
> >  recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
> >  ....81.0.bb => rust-cross-canadian_1.85.1.bb} |   0
> >  .../0003-llvm-fix-include-benchmarks.patch    |  25 --
> >  ...ust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} |   8 +-
> >  recipes-devtools/rust/rust-snapshot.inc       |  81 ++---
> >  recipes-devtools/rust/rust-source.inc         |  10 +-
> >  .../rust/{rust_1.81.0.bb => rust_1.85.1.bb}   |  76 +++--
> >  39 files changed, 1492 insertions(+), 619 deletions(-)
> >  create mode 100644 files/common-licenses/Unicode-3.0
> >  create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
> >  delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py
> >  create mode 100644 recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
> >  create mode 100644 recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
> >  create mode 100644 recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
> >  create mode 100644 recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
> >  create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
> >  create mode 100644 recipes-devtools/python/python3-setuptools_69.1.1.bb
> >  create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
> >  rename recipes-devtools/rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} (87%)
> >  create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
> >  create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
> >  create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
> >  create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
> >  delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
> >  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
> >  delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
> >  delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
> >  rename recipes-devtools/rust/{libstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} (76%)
> >  rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
> >  delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
> >  rename recipes-devtools/rust/{rust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} (94%)
> >  rename recipes-devtools/rust/{rust_1.81.0.bb => rust_1.85.1.bb} (81%)
> >
> >
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1515): https://lists.yoctoproject.org/g/yocto-patches/message/1515
> Mute This Topic: https://lists.yoctoproject.org/mt/112569336/7320427
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14043740/7320427/1891404428/xyzzy [soumya.sambu@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>
---1463811583-2031833611-1746733769=:3594--

