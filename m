Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50267C021A2
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:57 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.1822.1739301468010165311
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rVm9RRNV;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c04e462c3bso294268785a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301467; x=1739906267; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCS1FmmYnHuEfR5lOWAlz0yJBSb5GoWJoGDaUFrfbNc=;
        b=rVm9RRNV5Xmzpp++mo5M5CseSAGjT8i4QP0g+RxCFMm05l4BveA9tw2NjZH1wdMCyD
         6z/4y71zFLPBjcOJ27SJNNExFJWXybdxPh1kAImFitazvFV3Sqv/4p2s6FMNUcgsh5qo
         pyONk8S0GSSywv1KpdFUzcUOfAYeeKGqHp6q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301467; x=1739906267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCS1FmmYnHuEfR5lOWAlz0yJBSb5GoWJoGDaUFrfbNc=;
        b=m91Ffaj1QMf7rFofVr177ecjoLFR79dLd3+Od5C5Ea40cQ+A4yyFEqF/M99jEou3ga
         wNt0U31i0S3pl9O2MbHENfIKYntCy4ruiMGJzYALH196so2ekQekW22JK71UYs34Z9OC
         jKvoJyRPVnGB4q7CStxsbyBFVNERJLDyAS8JWS9J0CRYATEwUO6WTT0GaK7lcKD86bhl
         BsVhMySWdkirpzJewaT7b8OB5e03f6Z0cCcxpSAruRsiJ1t2COoKdtsg2ByLOuP9aypQ
         TwORO7acKF8MnXc0IgBOrRUzpd4YxFzUuLVtW1+e47Oy45NHyeLNeEN8cAjaun+jlCYu
         SFWQ==
X-Gm-Message-State: AOJu0YzvOR814HFXQRUs4Emsef20QhtXjnCSKHFbt8QtfH7kLGOSjTb+
	n+BJKmYfl4pIAP/BNN1b8WzqJQZCSRLMqpeoXJEriWMNzzJnGgWsm9UjXuMSwxuGnYlIulTBq0M
	X
X-Gm-Gg: ASbGncsyu2NIuUH5XjT7LsKEopzlYLPi6BD4/Qhv4AcaIuTaKWR1PjejoM7Wgs/VXIC
	RrKWAoIgvFfyVWr/8q4y08QkXrrcDa3QlucQ19OZQKt4cHI95QwmtNS6RqcZFemXc1nM5ALxqo0
	AH+lUSG0HGYiWb5EX4+jmMCfsWKrsmQL5ZOK5N5kQTJCAfTGtC0siuvaf20FKR98P4i+h/7IcHn
	pNI4V7pI9BBKyXByI1vlVZ7Sr22m+FgFMq+6Dx8BqYfBDR+7Z3f0AibiZNtV8kgCKqfXt6jQP00
	sfhpVoBteK8/eQF3WBcJ7s/XcmcriuIXlljDArvheJOD/ndXHt120DDwJHq5Smr1vSM=
X-Google-Smtp-Source: AGHT+IHWnKs4DW52EvYhxn2RDTqkMt1NHZeVsHZX5deHZZlkS6IIkmbPdS29ixOLLdPvYBrlvOqksg==
X-Received: by 2002:a05:620a:2b86:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7c06fc69b23mr75671585a.18.1739301466836;
        Tue, 11 Feb 2025 11:17:46 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:46 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 06/10] rust: Fix for duplicate libstd.so
Date: Tue, 11 Feb 2025 14:17:19 -0500
Message-ID: <9a86110789eccdf15816a0c0c4ba116403eaac5f.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1072

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

During the Rust build process, multiple copies of libstd-*.so are generated, as Rust copies the
required files from the stage2 build artifacts to the target image directory. When these build
binaries are copied to the image, Yocto's do_package step encounters an error. To resolve this,
the redundant libstd-*.so files are removed during the do_install step.

-----------------------------------------------------------------------------------------------
ERROR: rust-1.81.0-r0 do_package: rust: Multiple shlib providers for libstd-20c3de2d9292cd03.so:..
....
-----------------------------------------------------------------------------------------------

Multiple copies of libstd-*.so are generated during the Rust build process.
The redundant files are removed during the do_install step.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/rust/rust_1.80.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust_1.80.1.bb b/recipes-devtools/rust/rust_1.80.1.bb
index 396ea9c..cc00053 100644
--- a/recipes-devtools/rust/rust_1.80.1.bb
+++ b/recipes-devtools/rust/rust_1.80.1.bb
@@ -271,6 +271,7 @@ rust_do_install:class-nativesdk() {
     rm ${D}${libdir}/rustlib/uninstall.sh
     rm ${D}${libdir}/rustlib/install.log
     rm ${D}${libdir}/rustlib/manifest*
+    rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
 }
 
 EXTRA_TOOLS ?= "cargo-clippy clippy-driver rustfmt"
@@ -294,6 +295,7 @@ rust_do_install:class-target() {
     rm ${D}${libdir}/rustlib/uninstall.sh
     rm ${D}${libdir}/rustlib/install.log
     rm ${D}${libdir}/rustlib/manifest*
+    rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
 }
 
 addtask do_update_snapshot after do_patch
-- 
2.48.1


