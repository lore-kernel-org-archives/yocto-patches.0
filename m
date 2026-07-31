Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2502C55172
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:55 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4481.1785497625758621507
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EYQhCPNw;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5c92c389so42184885a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497625; x=1786102425; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pjJGh2Cb9U4bxdvEYGKugNj3I7VlHAVBp7Pw0oBayp4=;
        b=EYQhCPNwi76ArQyOCS6VTNXqoeROeuS8pgrV9YqlTp2EOCnlnZpreCgevjeHIW18yi
         zZiCPZdTaFAwmvpWJvJ0F38PjDHQMhs7sQu6OztqtRU+Lh0a+9o8BNaIRlCu/ifGF7or
         URZa8pGcim0VVWKKqMqYylsc8nu1hMb85BhJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497625; x=1786102425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pjJGh2Cb9U4bxdvEYGKugNj3I7VlHAVBp7Pw0oBayp4=;
        b=MFb/M/oxmR/X9eTss2x+9pfU15lZ0MzUgosJAJw33ZUL3tq9i3CGzfwWp4NOJnOyUt
         wb5T/5De8KfnNnW+RoF51H0H4vqrQe0hlcbeYIJ1EmAKzxCxDYky0rc5G4uM+g9AJ+U2
         DMybWHTJPEM6AS3qYKgEHtop0oDwdrIYXr2I8/nTKXeSORCfauKij+GKaONPheWAYuhU
         TvNROdZv9X/YLmSMCEPbfgQ0XiQ5ju0g1Eoo6t0P7fdWRYemC6Nbd7WL6/D/mT6Mylb2
         6uIG6X9SvYb0vBdKmVsJFfLOuEjzM+yjUOkzkKps3xWw59njeYEVLOOA7oKp3vb4EF2h
         /qnw==
X-Gm-Message-State: AOJu0YzpjW1ac6k9Xr52Bp6MsMrZaLylbU8SXouusVi3Nv0WAqHR5Ma4
	QczqX/LDZmfesRDz3Q5PCdrhVDmfqPzEEd3xFd62oOI8ogx11zUPnjzSYcEplz4oHjbc7IQm6Xq
	SQNnR
X-Gm-Gg: AR+sD13dXe0sdbO9Qrr6adiGC64tBy9Akh5RjdBPWjbMO4Yqn8SUlSBRcIvam89kVPa
	a9B0THStxMLZ4h8f/kpt2IaO0BFem4FnM25oygdzskDP1a2oKhS8o+4NfQ1JMXBLTzuBO19eLRa
	9nFY82sBXthC9mubwszawpRa3GhkB+gE5RJA2X7xuk0Xcgp1ygwXT+cCncr7oNR9GeX4zfngAyk
	q0V4SIvNdv90aO2iItpFaJrq21X1ir3vNbCZMr44+QfMt6W24Id2AV5BSIWMqqztZzvm04HApee
	QL1ji39TceY8GlAUF+UMRFn500/yiUdPLVtj4Hi20INcBL254mha0HXDn86gZDfRTV4glucICjl
	k/uSAm3a70inSB6b+/4b9rt+bBHhe6aUE3lXVFJZhpEAuM1URfbcX32KkAy+asK6WgH3Gf/ihCl
	lNM7HbXiNWrMMU2kMuEiSbghA2pWpoBr6JpGT5ikQmJB+x8BwVmja7dzrIOmaP6pWw/5kVLyV46
	Pss6chwxzcaGlpKOe4tTCyEFzidm8YKtShzouJmIJA+WYcmoGctAJ/t+24MXEhPguWbPxeoz1Hk
	sr3Jf2snxDzeaMU5sF6UrTO4Pw==
X-Received: by 2002:a05:620a:6017:b0:92e:e376:cf97 with SMTP id af79cd13be357-934978a789amr182483185a.44.1785497624432;
        Fri, 31 Jul 2026 04:33:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 32/35] rust: Upgrade 1.96.0 -> 1.96.1
Date: Fri, 31 Jul 2026 07:33:02 -0400
Message-ID: <d35e44cdb22930da8be71f57c562d8427678a058.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4608

From: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>

https://blog.rust-lang.org/2026/06/30/Rust-1.96.1/

Rust 1.96.1 fixes:
- Missing retries / timeouts in Cargo's HTTP client
- Miscompilation in a MIR optimization
- Cargo CVEs:: CVE-2025-15661, CVE-2026-55199, CVE-2026-55200

Test results:
No changes

Assisted-by: Kiro
Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 94749b6f915e18141e62f4f7b4bbec53687b897e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                                                 | 2 +-
 recipes-devtools/rust/{cargo_1.96.0.bb => cargo_1.96.1.bb}      | 0
 .../rust/{libstd-rs_1.96.0.bb => libstd-rs_1.96.1.bb}           | 0
 ...t-cross-canadian_1.96.0.bb => rust-cross-canadian_1.96.1.bb} | 0
 .../rust/{rust-llvm_1.96.0.bb => rust-llvm_1.96.1.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.96.0.bb => rust_1.96.1.bb}        | 0
 7 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-devtools/rust/{cargo_1.96.0.bb => cargo_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.96.0.bb => libstd-rs_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.96.0.bb => rust-cross-canadian_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.96.0.bb => rust-llvm_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.96.0.bb => rust_1.96.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 36d14f4..3c5351e 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.96.0%"
+RUSTVERSION ?= "1.96.1%"
diff --git a/recipes-devtools/rust/cargo_1.96.0.bb b/recipes-devtools/rust/cargo_1.96.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.96.0.bb
rename to recipes-devtools/rust/cargo_1.96.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.96.0.bb b/recipes-devtools/rust/libstd-rs_1.96.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.96.0.bb
rename to recipes-devtools/rust/libstd-rs_1.96.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.96.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.96.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.96.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.96.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.96.0.bb b/recipes-devtools/rust/rust-llvm_1.96.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.96.0.bb
rename to recipes-devtools/rust/rust-llvm_1.96.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 3aa3fe6..cc2de41 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -10,7 +10,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0003-explicit-tail-calls-disable-two-tests.patch;patchdir=${RUSTSRC} \
             file://0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "b99ce16cdf0ecfc761b585ac84d131b46733465a02f8ecd0ff2de9713c62ee09"
+SRC_URI[rust.sha256sum] = "77a6ff3003a4ad0cb00697b043c879e3e1a15d945b1a1f63818903bfc3fa8b98"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.96.0.bb b/recipes-devtools/rust/rust_1.96.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.96.0.bb
rename to recipes-devtools/rust/rust_1.96.1.bb
-- 
2.55.0


