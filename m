Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F9D65542
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:14 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.53403.1732644731048873532
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NcCLKen4;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d849a93088so18471506d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644730; x=1733249530; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWwf2ilC3IOKb/anFd5xPxvGf7Au4aAfkMAh/wqJfGQ=;
        b=NcCLKen4K2/nPWYTVjIrup1iA5M1SwV3lG0F2BmQDsC2xehpRJGCyg7oVf0nxuKl9W
         iKbPx1BRzUDOr3HhkjYF2PYh4emhk9VTsxGGTxVRMnr6rTRM4Us2nj+Kc4LgdNXso9Lz
         0bLwHoPMzw6NctKcjjLXKJ8hBSvMm/s841tX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644730; x=1733249530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWwf2ilC3IOKb/anFd5xPxvGf7Au4aAfkMAh/wqJfGQ=;
        b=jHQUorHq4SrtTgtSvqYrjXNgKyVAu/JKujE9nl69jJy0/XTsvGH7nBSKjSpTcBs856
         ROUm+AHnDqArnCFstdKHAQ+OVxzhOQ2AbBOfM0PskpFeCs7wajmWOVQ7GVbAK/ecR96q
         FSVLWYh7YlsqYVInszl9G6ra66+VGyBSQ7QbBEYPsXxnUGIlvXmoSRf8TUBu+MGIYM79
         9mzNugyWj3It3gK24JGA2D+8YFVHyzzRJA0YCSv/oo5j5D8TggMXcvajZ+hLBMdB9MQh
         ecE8P1vIGey/6IiG5lEJ3s0OhOAKbOh8rumB/G3k+uSx9JO3IYBM+pfnWO+WDvhwmy0q
         lJhw==
X-Gm-Message-State: AOJu0YxUjroOsbaZaSBl+KYBE36qQEZ5fBWqQm7XZnwpibCtIL0OXgNx
	/MCKjketUAcN3aRJQ3dgyzGN4dT6+f/o8oqvxxvecjS+2Fv+AV+YO0kJZ2QUvStnV3Y3VFc0wv5
	M
X-Gm-Gg: ASbGncuPLXWSz2jaAHCYpf9gH7g3bIj6cooDoDCKrHzRWCX488pkgKByNbFyGqmkMKe
	hv4YClDWhiCUcHEUIxK4F9LA0CbMEWtpuQvqRbc++/Ova5l3qXNlv3QZlBUvfOdA5rHwkklknC1
	i1qq5XGeZfOItgQ4fL2M/Zjr/YJX2GIY39W/n4nGSrs9ilVMFL3lULB07vTN37uojsASh8Xu/62
	HFCG3/lXN2+rQsGn72Pb7eoA46o34uqcrf0VRtMuUFKDyFAVFraFLo/2IsHZnwtEOE2ypZ/7Jdt
	Paeq1nkPibc0CCXgDzyfJVMnmw==
X-Google-Smtp-Source: AGHT+IE3b62P7x95QKJ9DAWcY94FsgB2D+hxlGoQlcDrk77ghcvoHZmWka31x8a2IhiQfdxkh0PC0g==
X-Received: by 2002:a05:6214:c68:b0:6cb:e4d3:10a0 with SMTP id 6a1803df08f44-6d864dcf5f1mr80916d6.48.1732644729794;
        Tue, 26 Nov 2024 10:12:09 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:09 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 0/9] Upgrade to Rust 1.80.1
Date: Tue, 26 Nov 2024 13:11:31 -0500
Message-ID: <20241126181152.407253-1-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/833

This patch series for the kirkstone/rust mixin layer backports the
various Rust toolchain changes in oe-core master to pull in the
1.79.0 -> 1.80.0 -> 1.80.1 updates that have landed in the last few
months in oe-core.  As the layer README.md mentions, the interim
versions have not been tested at this time, but in theory they
should be usable if you point at the appropriate commit.  I have
improved my backporting process to try to better ensure that commits
are in the same order as they happened in oe-core to hopefully
work better in that situation.

I intend to push this series to kirkstone/rust within 24 hours
unless a serious showstopper is pointed out.

Deepesh Varatharajan (1):
  rust-target-config: Update the data layout for x86-64 target

Deepthi Hemraj (1):
  rust: Upgrade 1.80.0->1.80.1

Harish Sadineni (2):
  rust: Upgrade 1.79.0->1.80.0
  rust-target-config: Fix TARGET_C_INT_WIDTH with correct size

Peter Tatrai (1):
  rust: Add patch to increase timeout in process-sigpipe rust selftest

Ranjitsinh Rathod (1):
  rust: set CVE_STATUS for CVE-2024-43402

Scott Murray (1):
  rust: Restore CVE_CHECK_IGNORE

Yash Shinde (2):
  rust: Oe-selftest changes for rust v1.79
  rust: Upgrade 1.78.0->1.79.0

 classes/rust-target-config.bbclass            |  12 +-
 conf/layer.conf                               |   2 +-
 .../rust/{cargo_1.78.0.bb => cargo_1.80.1.bb} |   0
 .../rust/files/cross-targets-backport.patch   |  31 ----
 ...crease-timeout-in-process-sigpipe-ru.patch |  31 ++++
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 147 ++++++------------
 .../rust/files/rust-oe-selftest.patch         |  69 ++++----
 .../rust/files/rv32-rustix-libc-backend.patch |  16 +-
 .../rust/files/zlib-off64_t.patch             |  16 +-
 ...ibstd-rs_1.78.0.bb => libstd-rs_1.80.1.bb} |   0
 ....78.0.bb => rust-cross-canadian_1.80.1.bb} |   0
 ...ust-llvm_1.78.0.bb => rust-llvm_1.80.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++++-----
 recipes-devtools/rust/rust-source.inc         |   8 +-
 .../rust/{rust_1.78.0.bb => rust_1.80.1.bb}   |   0
 15 files changed, 184 insertions(+), 226 deletions(-)
 rename recipes-devtools/rust/{cargo_1.78.0.bb => cargo_1.80.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/cross-targets-backport.patch
 create mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
 rename recipes-devtools/rust/{libstd-rs_1.78.0.bb => libstd-rs_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.78.0.bb => rust-cross-canadian_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.78.0.bb => rust-llvm_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.78.0.bb => rust_1.80.1.bb} (100%)

-- 
2.47.0


