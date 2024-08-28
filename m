Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E1C6FD39
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.5964.1724875793992657026
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fwGrJK5t;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso279869239f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875793; x=1725480593; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATZqSft8Eaas6bsMekranwquKbgnBDkcV1Y09pCudnw=;
        b=fwGrJK5tkV5AU0b2X2v8nmgk5xo2pZ6KU0Ph8cH9Bz2F9QhLUcl2mZWK7pRoJp5e5o
         6gztHGfF9xZTh3DpUoahRxOGNJRb8pn8iahFzwgJpHXs05CJ/HQF7cQvdhFXFZeGAI1c
         /c0ft+aLvky1MXQxWHNj9HzRGpGeCz3bQCCfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875793; x=1725480593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATZqSft8Eaas6bsMekranwquKbgnBDkcV1Y09pCudnw=;
        b=Rl/fx3wnLxeVUFu2gue0uQ0nhuvXy8kQ6qIXpUjLUuqJuUMvBRxC9LHwP+1cHAi8hK
         7CL3jaHj9/MfaVHpvzgAAdQbhoADmFhLmmZGQnMUxcy9jfJ5xXpe2WXmAJPfxmL9ANtu
         NCseGRDkWt5K3leP0Qzk1FPfw6Cg+GbCl7mOWIjQC0pZ84xh8QIY0cg3tEi8YiF9iqjO
         hibmDZiUTGJECOjz8rkk76EihKZeGpX0+0elMIPCOsjiVD4X1/ruZ7tX6Mb85+ZAfWxW
         YqDb7+PUq25U1pVxc+QOcf566LJJxCC24ieUNzWTElUMRMJNC6ZHZ2Lp09rQthtefO/k
         f6Sw==
X-Gm-Message-State: AOJu0Yy//gQvu1d+HDRJgQV8+5f8Zyc5mYC4hyJcedKkvNdzmP9mqXtO
	J2KoQrtN613fnlEFGmJyOX0Fe/83Km+uzkn4j4TmegmgPaFMeKaVHdFhpjRGB+pJ2eSl9UF+RtX
	Z
X-Google-Smtp-Source: AGHT+IFIy+12Xm7l15wHxQsh/irFuQwHpp24uy6qh8wf3JsbPJ0ZbhGt7MjsDUygWJqfkKRYT3OuoQ==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id ca18e2360f4ac-82a11094588mr87778739f.13.1724875792958;
        Wed, 28 Aug 2024 13:09:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 06/33] rust: reproducibility issue fix with v1.75
Date: Wed, 28 Aug 2024 16:08:52 -0400
Message-ID: <05ebb071926989e6eb32f1e59aa173f9bef78543.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/572

From: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>

Patch updated with upstream fix.
https://github.com/rust-lang/rust/pull/121959/commits/a9a979839bbdfec48c75d618ab0dce8a953589b8

Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2eceaa4b6ca398ec233b18c1064970bdf68a9258)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../files/repro-issue-fix-with-v175.patch     | 37 +++++++++++++------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-v175.patch b/recipes-devtools/rust/files/repro-issue-fix-with-v175.patch
index 6840baf..fe0507c 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-v175.patch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-v175.patch
@@ -1,23 +1,36 @@
 rust: reproducibility issue fix with v1.75
 
-With 1.75 rust release, the '.rustc' section of shared object libs are embedded with absolute path names which is casuing reproducibiluty issues.
+With 1.75 rust release, the '.rustc' section of shared object libs are embedded with absolute path names which is casuing reproducibility issues.
 This change will fix the path name format back to '/rust/$hash' as in earlier versions.
 
 Below are the links for detailed bug description & discusssion with upstream rust.
 https://github.com/rust-lang/rust/issues/120825#issuecomment-1964307219
 https://github.com/rust-lang/rust/issues/120825#issuecomment-1964652656
 
-Upstream-Status: Inappropriate [patches need rework]
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/121959/commits/a9a979839bbdfec48c75d618ab0dce8a953589b8]
 Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
 ---
---- a/compiler/rustc_session/src/session.rs	2023-12-21 08:55:28.000000000 -0800
-+++ b/compiler/rustc_session/src/session.rs	2024-02-26 07:29:15.527577022 -0800
-@@ -1269,7 +1269,7 @@
-                 | CrateType::Rlib
-                 | CrateType::Staticlib
-                 | CrateType::Cdylib => continue,
+--- a/compiler/rustc_session/src/session.rs     2023-12-21 08:55:28.000000000 -0800
++++ b/compiler/rustc_session/src/session.rs     2024-02-26 07:29:15.527577022 -0800
+@@ -1260,19 +1260,6 @@
+     }
+
+     pub fn should_prefer_remapped_for_codegen(&self) -> bool {
+-        // bail out, if any of the requested crate types aren't:
+-        // "compiled executables or libraries"
+-        for crate_type in &self.opts.crate_types {
+-            match crate_type {
+-                CrateType::Executable
+-                | CrateType::Dylib
+-                | CrateType::Rlib
+-                | CrateType::Staticlib
+-                | CrateType::Cdylib => continue,
 -                CrateType::ProcMacro => return false,
-+                CrateType::ProcMacro => return true,
-             }
-         }
- 
+-            }
+-        }
+-
+         let has_split_debuginfo = match self.split_debuginfo() {
+             SplitDebuginfo::Off => false,
+             SplitDebuginfo::Packed => true,
+
+
-- 
2.46.0


