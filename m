Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D1CAC583
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.3149.1757443820673916333
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XFlzTEdB;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b38d4de6d9so31030521cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443819; x=1758048619; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+5Aw7WC6ARKYXrtblbGmOSMw1yDOz6gf1rECE09rgs=;
        b=XFlzTEdBUmeLTb3oFp06pEmOtffW1R3RUQJcgoj2VIpt0BYwkfPsNNFAx6r7hafCsJ
         Ypd5ZgGPNv+9S28uLF8BOEruhAyM2Afp/ABM2RkSE3iW9Re8XST3XKxp9JdYnt7siyCi
         ZoO+YePSCdR7BsuJawWAC9R7kK5xmC5DievpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443819; x=1758048619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+5Aw7WC6ARKYXrtblbGmOSMw1yDOz6gf1rECE09rgs=;
        b=I78fiWOKk9n97hEb9LDsdNj18jT94YLtme/aWgHBqiQaL9DtmfdhmdD8mcIlMiCfVN
         2ZR/9dLKBTN2zNsYA8baT+iqphVZsFUBY+BhBU0nw7nIkUMkY9F/zGNLYdhtd2E+Wynd
         VP//iL8B93JlFhsNIhtVKlHjp7JchQpOc0wEurbbbACxAycGaukoepmMp9/X41SoseGS
         qQzXOFZ6OCRO7cK5QhAfQWLbnfl6IV1ms0E7hqG5Pf14KHiTVI2ln1h7RubgOy9ORp3r
         fH6LZhR/Yo18MJ0FlNH81MqK7FMdGI/o4GHT/tvgzGv19J+GWMSxlwZkRhJGyrCPLz7z
         1Liw==
X-Gm-Message-State: AOJu0YxVZjBL+Mx7RBilC7DW/Cf6HS3G2Kj+6ZJzSOP1XgzXRbv30LGg
	9ovq3MZjCkgxDc12ahqmtThfghI2zOQcZwi8dVUJ/pV7/bu0eSLn7/ibUUIC8F8EFLwNAM/jxAC
	CPUcA
X-Gm-Gg: ASbGnct5bMbvPSBUAfPIDj3WGvissOyoqd1ipNx5HTE0Jcz5VKpN3g77SyRI4MbsHiF
	ryCe3LC/JWV7lsShivaZJVBX3xQUL2t+ySCqapo2ci0VBjzmSoph3nab2EqSIGuSsF7m7J6e/AA
	wLQN1MJ8w+MMZZ2v8B61P+5lfiVR0kkE1fZHBuFCFgulqgm76NsEsQvThFW2Srl51/OyNKcLCYH
	AKXNdL2lZFowJoPcRkxssUUof50BilKVGS6vHENS8U1n7ukN1V8sGmqfuPlVp8HPNnxiKkWvUhy
	d9fvMyB22qe1ltIHIL28KoRePR94/AYXM9tec9o9IszV1efLOoqCSzkPmVffayqdwpV1D7X1bqK
	6OrGbteAR/VL3mCNFg55ka7laD4QfAKkzK5ySno6y9qR9iocwOF20sn4E1yfCPWrCbkH1BbpiBb
	VR+w8XNAsI
X-Google-Smtp-Source: AGHT+IHJHHD5+48615Z8KBeoMt2Z+BOBKFF2DWRJR8q/nNYzk629UMj4GtaOPThXa1iSaZ7CghlViQ==
X-Received: by 2002:a05:622a:5510:b0:4b6:cbd:8cb7 with SMTP id d75a77b69052e-4b60cbd91b3mr83798701cf.54.1757443819424;
        Tue, 09 Sep 2025 11:50:19 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:18 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 0/9] Update to Rust 1.89.0
Date: Tue,  9 Sep 2025 14:49:48 -0400
Message-ID: <cover.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2167

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.88.0 -> 1.89.0 updates and other fixes.

I intend to push this series to scarthgap/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Gyorgy Sarvari (2):
  ptest-cargo.bbclass: sort binaries for reproducibility
  rust-target-config.bbclass: move target generation before do_configure

Jayasurya Maganuru (1):
  rust: Upgrade 1.88.0 -> 1.89.0

Liu Yiding (1):
  librsvg: upgrade 2.60.0 -> 2.61.0

Ovidiu Panait (1):
  rust-target-config: fix nativesdk-libstd-rs build with baremetal

Per x Johansson (1):
  rust-target-config: Add has-thread-local option

Peter Marko (2):
  recipes: cleanup CVE_STATUS which are resolved now
  rust: handle softfp fpu

Yoann Congal (1):
  ptest-cargo: move run-ptest rc variable initialisation

 classes-recipe/ptest-cargo.bbclass            |   4 +-
 classes-recipe/rust-target-config.bbclass     |   8 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
 .../rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 101 ---
 ...bunwind-cross-architecture-unwinding.patch |  46 --
 ...lain-syscalls-as-their-time64-varian.patch |  32 +
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   8 +-
 ...d-statically-in-rustc_driver-feature.patch |  14 +-
 .../rust/files/rust-oe-selftest.patch         |  13 -
 recipes-devtools/rust/files/triagebot.patch   |  32 -
 ...ibstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} |   0
 ....88.0.bb => rust-cross-canadian_1.89.0.bb} |   0
 ...ust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +-
 recipes-devtools/rust/rust-source.inc         |   7 +-
 .../rust/{rust_1.88.0.bb => rust_1.89.0.bb}   |   0
 recipes-gnome/librsvg/librsvg-crates.inc      | 778 ++++++++++--------
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |   4 +-
 ...append-RUSTFLAGS-to-rustc-executable.patch |   4 +-
 .../{librsvg_2.60.0.bb => librsvg_2.61.0.bb}  |   2 +-
 22 files changed, 526 insertions(+), 610 deletions(-)
 rename recipes-devtools/rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
 delete mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.88.0.bb => rust-cross-canadian_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.88.0.bb => rust_1.89.0.bb} (100%)
 rename recipes-gnome/librsvg/{librsvg_2.60.0.bb => librsvg_2.61.0.bb} (97%)

-- 
2.50.1


