Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9748C3ABB0
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.4578.1746132042993075293
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m/+HIFOV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f2b05f87bcso15709086d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132042; x=1746736842; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7NItwXhvilrzp1DYYA0eBkBMCggf1Yo1ytrg+jVHek=;
        b=m/+HIFOVUPZ2MxDseAoeifE8F54s+8egSZj2GsIfQ07UEKgDqaAXCeutP+4cT8P7x9
         /K0c/D5tcQKjPJ1P3bLJWFONBlLeX7qq97f+dN/HGjjU3kbs3zxDurBFbgwXmgkPLtMV
         1wxaA5Wy7kEC5lVlsGEaYiyoAa7EwjlGs04yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132042; x=1746736842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7NItwXhvilrzp1DYYA0eBkBMCggf1Yo1ytrg+jVHek=;
        b=OahsEAFCYa6EAmy4OIbvMisQrjZBmaHG7dXlrvo3l18AgznJWY+LclF0iwtgxPDwLp
         PRNOjeHNWWbzI6YzilwzAwr3or4iu6PZNMg1pKmANj6rwz3LGhcq1VfOcVh3VXpRWZyV
         Ic6q2xro65jWcVWNyKu5GqarrMFmA+cezemDWe8plZVgFDgR1hV4Nz96vniLTOzi3q4U
         9MS/+LXgcPrSKLusujBEisjZvrim6SeVA3FZiJOz/t9xEDOmxnjTmshpSF/6MUDPfht2
         jvboYXs6O0JbrGP5ZBavZIdgNzRQnybAxRvBZXulTcX/+PDmURXjKfSCIFmjg84Wu1xP
         zfGQ==
X-Gm-Message-State: AOJu0YxqNGjEfCuvWa+rhwy5Ezw/6TIsdK57ph5NjbCasI8TOfR+OnnB
	qavLoJlJ0MyZpqLkvOIhX1l6ogZ7AsR1NFJuvTOrEjrUNRTmdmfSTFuuegFeZFXVPR5AFN/cv8j
	k
X-Gm-Gg: ASbGncuJtG+3bOVtPWupzlEklw6FkYcvbUoMXZpLqJUvGkKdWfo2dmpag98bIsQwP6a
	LOdt1tC8VU86jg/Leo5Z1OgBXNrR02tIhcOAsS8G71lMTfvdeNXnva4ksHQGfUXGiz232NUaeLP
	+IVnNt5810yKkdVHRaadpu4Qfmz7/3qtepfSd+dHbtx6EkIPTnf8rOwTGIZNKtjk9OaN0xGC2n4
	cQ67H5iczRhF0Yu1fd8ooVBdpRp77rKl92kqcv1BXabkKkFluVXYHXOSoKIOPlohIU5eJLx1d+9
	Zrf88oeVWX6vb928n8nzpTtbjV6vL09d1o02Z8vIvewn0b0PeB0gqAGWZO/oI6YBiYt2B20TBu/
	qKBWZ6mfjubU2Q2Q2
X-Google-Smtp-Source: AGHT+IHOoSmdmJtkKBglWn059Ow9I50X9AUb4yEaE+fioCYBjmaAhcTpWDRtqirGRkQCkSqPhDaRhQ==
X-Received: by 2002:a05:6214:21eb:b0:6f2:c94f:8cfe with SMTP id 6a1803df08f44-6f515278539mr12076936d6.23.1746132041692;
        Thu, 01 May 2025 13:40:41 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/38] rust/README-rust.md: fix markdown style issues
Date: Thu,  1 May 2025 16:39:43 -0400
Message-ID: <d96cee28796fa4a9533d8c0c3e348cc8eb5798a4.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1434

From: Igor Opaniuk <igor.opaniuk@foundries.io>

Fix markdown style issues using markdownlint tool [1]:

$ cat ./recipes-devtools/rust/README-rust.md | mdl
(stdin):1: MD002 First header should be a top level header
(stdin):25: MD006 Consider starting bulleted lists at the beginning of the line
(stdin):3: MD009 Trailing spaces
(stdin):11: MD009 Trailing spaces
(stdin):26: MD009 Trailing spaces
(stdin):39: MD012 Multiple consecutive blank lines
(stdin):32: MD032 Lists should be surrounded by blank lines
(stdin):36: MD032 Lists should be surrounded by blank lines

[1] https://github.com/markdownlint/markdownlint
Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 62bade83dd6e021f11e9599a2699a1b202324f0f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/README-rust.md | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/recipes-devtools/rust/README-rust.md b/recipes-devtools/rust/README-rust.md
index 209836a..a7e19c5 100644
--- a/recipes-devtools/rust/README-rust.md
+++ b/recipes-devtools/rust/README-rust.md
@@ -1,14 +1,14 @@
-## Introduction
+# Introduction
 
-This provides the Rust compiler, tools for building packages (cargo), and 
+This provides the Rust compiler, tools for building packages (cargo), and
 a few example projects.
 
 ## Building a rust package
 
 When building a rust package in bitbake, it's usually easiest to build with
 cargo using cargo.bbclass.  If the package already has a Cargo.toml file (most
-rust packages do), then it's especially easy.  Otherwise you should probably
-get the code building in cargo first. 
+rust packages do), then it's especially easy. Otherwise you should probably
+get the code building in cargo first.
 
 Once your package builds in cargo, you can use
 [cargo-bitbake](https://github.com/cardoe/cargo-bitbake) to generate a bitbake
@@ -22,17 +22,19 @@ contained within it
 
 ## Pitfalls
 
- - TARGET_SYS _must_ be different from BUILD_SYS. This is due to the way Rust
- configuration options are tracked for different targets. This is the reason 
- we use the Yocto triples instead of the native Rust triples. See rust-lang/cargo#3349.
+`TARGET_SYS` _must_ be different from `BUILD_SYS`. This is due to the way Rust
+configuration options are tracked for different targets. This is the reason
+we use the Yocto triples instead of the native Rust triples. See
+[Add the ability to provide build flags for the build-script-build #3349](https://github.com/rust-lang/cargo/issues/3349)
 
 ## Dependencies
 
 On the host:
- - Any `-sys` packages your project might need must have RDEPENDs for
- the native library.
+
+* Any `-sys` packages your project might need must have RDEPENDs for
+  the native library.
 
 On the target:
- - Any `-sys` packages your project might need must have RDEPENDs for
- the native library.
 
+* Any `-sys` packages your project might need must have RDEPENDs for
+  the native library.
-- 
2.49.0


