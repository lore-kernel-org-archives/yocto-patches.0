Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67507C3ABAA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:04 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.6710.1746137760532231493
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HQpafBNN;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso16726566d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137759; x=1746742559; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqxHboYCRDLwWB4+fzvT6m2+jR+lcveGtFx8Ho0jXs4=;
        b=HQpafBNNEOKJ5zubdltGJuDE69HVSu3AAa/2KjFWRugkOKGVceWsplqkxsISShJMV3
         MvSylR+M5hy9wkvSgz2e0/B1NWfsJVGB8PoKzSg6foaZBVf1wCZe/fezTlOaONt6DBxh
         GkK637lN6EFV4QgAP9MKcvTv6BQ4EkQdwaAEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137759; x=1746742559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqxHboYCRDLwWB4+fzvT6m2+jR+lcveGtFx8Ho0jXs4=;
        b=jpwz3zObmGPQvSt/W4PSSI5RGX3L5gsebQ4GiksUiq6s75eiv0kzb44Ioe+wJu/STO
         QWlRZyCTwMtw8tKCsLVmeoBuXz1kQijSR1RyiqZ6ACUU+kwh36hgThgTChqWtZUWw2fD
         O6ZFeOS429z8Xcbcljp4Cv7SYLqIuiNPm+gvMbZZh6EiJlF2BVzpijXgmm1HWADugZ9/
         ypb/Ygl1YZy2CecatmuqcLMBeejGP+qzmlga3AcDLhvoSLY50HoO//xqXFEMWnzCJDDV
         Fdy9cJEy9uu7aXpNJhHx1pwGUSGtkE3Y79bKvfX+L6lXX9bBH0QKlYkio//NWLm8Rlb8
         kovQ==
X-Gm-Message-State: AOJu0YzvXouNHccAaIU0p2diYirzO79RHShqwG5CffLXHRFKjb1tI/wY
	DqsXa2HwmLE4fwEXwS4jSqxSuFD0jYGDBP64ZvrtVghcFp/BolOOtCOo9WJY1nu/N64LADL+ZCl
	p
X-Gm-Gg: ASbGncv5efYWSOVDrROZ76JejT32RtNdC+3xinAeGuv1GCKbgL8xgqcxj4JpYmqBL7Q
	nQ+n//j1ERFKTr4jomIzOn5BLldrICp5O4GkSf4XpsDgwZ/5OJsb+fwnGaRon0dkwZ7P2Jx1KKq
	bSoI0AMzPUW9tNmoRCEndN0zHV5aGDBidW7FPH+LrtdlVUgOwEI549MgobvuekDb/W8dF7296iP
	5TDB178Z/fjTuSpxEqi0NXdjxMY7O2cy1EtGIIE5v5UVSz1mzf168UUjDaaIBGB438J1pshJfk1
	5AdTwDCw7jF2GccDlwO3noHgku5bbJFDkt9CpmuupjjTKlESjvSmAMjahsV0/VUWoe+qqVoVVud
	j6s7fG+cZPDOYI2AD
X-Google-Smtp-Source: AGHT+IHqkw1FzXzhlCijoavTDUmdSSRFyvH977htvrDC3aoJSyFZ790rxzg5jxL1HVkzcBZ8QvgKSA==
X-Received: by 2002:a05:6214:268b:b0:6f2:d45c:4a35 with SMTP id 6a1803df08f44-6f515610aa4mr17742646d6.37.1746137759172;
        Thu, 01 May 2025 15:15:59 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.15.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:15:58 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 0/7] Pull in recent oe-core updates
Date: Thu,  1 May 2025 18:15:36 -0400
Message-ID: <cover.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1466

This patch series backports the recent post-1.85.1 Rust toolchain changes
from oe-core master branch, and brings scarthgap/rust to the same level as
the series I posted for kirkstone/rust earlier.

I intend to push this series to scarthgap/rust in about 24 hours unless a
serious showstopper is pointed out.

Changes:

Deepesh Varatharajan (2):
  rust: re-enable the unit tests that are ignored
  rust: re-enable the unit tests that are ignored

Khem Raj (2):
  rust-llvm: Disable benchmarks by cmake options
  cargo-c,rust: Fix build on risv32

Peter Kjellerstedt (1):
  libstd-rs: Correct the license to use Unicode-3.0

Scott Murray (1):
  Update README.md wrt dynamic layer submissions

Yoann Congal (1):
  cargo-c: Update patch Upstream-Status

 README.md                                     |  37 +++
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
 .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++++
 .../rust/files/rust-oe-selftest.patch         | 195 ---------------
 .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ------------------
 recipes-devtools/rust/libstd-rs_1.85.1.bb     |   2 +-
 .../0003-llvm-fix-include-benchmarks.patch    |  25 --
 recipes-devtools/rust/rust-llvm_1.85.1.bb     |   2 +-
 recipes-devtools/rust/rust-source.inc         |   2 +-
 10 files changed, 191 insertions(+), 459 deletions(-)
 create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
 delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch

-- 
2.49.0


