Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B40C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:24 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web10.60139.1744061469100906109
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=c0UyLSL2;
 spf=pass (domain: konsulko.com, ip: 209.85.166.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce868498d3so21215725ab.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061468; x=1744666268; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yER5b46NeFu/BL4/5zWCp+Tm+xZPWNM3cDvCAaMGopY=;
        b=c0UyLSL2s3irlQ3BDF+YgzPiE7oiPyJecCu1FSzaD+bWIY7AOSWcWcxRBotncylP0E
         os3sL0Gjami9x/+eKvGXNIp3LJ64G+sL7edbnWJH1lwHjNhz8leYpWBjPiye8Azeti3/
         ag61sQ6/mhdxtVEli+ZosNdFRPGGtuYV+P8hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061468; x=1744666268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yER5b46NeFu/BL4/5zWCp+Tm+xZPWNM3cDvCAaMGopY=;
        b=oF1o6irBO++w2M4nqFjeF6SglPUQ291krcZ/Q3ROqEPvYLiaA/MiHGVRliSdBlNMld
         6y4m0Gv3P+iw5My8vgnQa848C0wDz9DoDLd2n/dcfuIVIKAL9YvGI9F10/EVFDf5Rxk/
         6hb5uXAE3touDXIVW9ROMMK4kThGnJW/UhhIf+XgtNWTiDRG+KDbc8KwIdVzw9THLre5
         FciIuL31duGUkb0pqAI0dOWb2v3Q5N7O6+OqVRyewG0TAqUSnHdKIRFrdHZ5LdGB5QBH
         Ltm8fhUI04jpoRusA3t07UWnletKR80BHUc9b7qL8HnM/V+z23IdLSfN3qDUkjlbh4LD
         5qfg==
X-Gm-Message-State: AOJu0YyuFipILD2wHRnM+R2wJlJ4Zt0f3SbU5yEhGbX/2LoUAVKOnf6F
	wKS72gQBrIXG5o2qcfQVypkFmVylN7WZaBPaCa8fCRT+Cl7yV0wBeyyjLwC8mT3IKZ8ejz6Cgzy
	Pdy8=
X-Gm-Gg: ASbGnctCIV/MgSQ6ygevPehVCOv188asbJDLDeBa1hRtx5u9+VEsf8KFPiYciVgeyDU
	CkwAo74dTHeFGR8nM9rIBgNQXY1tUVB+wlfUExEHIj6JxHt0n6dQrGUCSDH8Y0AzhT6woNYPsH+
	r8q2wwtqQ9BkfN9LPiqYcz1RJZh8xAOU0yYM2wledgKvuERtzL2FsvhZJmp5AybeaIFznphQxGc
	S27Ng4J52i3GQs1Y5IFQKGuZXqiPlCL1BB8T1RvaHb3DfJXVvRrDha9zKysZuOH0MTLEYiE9i9o
	1DnonBdD4AYktVZS1IbjB8rGat68L7wl5Io4VZBCRKsGHTpLAr3q5QQ0Rv7lzBjgXVu6EKRKy6d
	/VqVdiA2CDNe50pGORe2s
X-Google-Smtp-Source: AGHT+IFrsp7uWaPFUUSFgDdV9jjx8GGhI9MGZEsvIxqxS9Ecf8OmhfcWsf2vJg/bba09h6F4sXaFRA==
X-Received: by 2002:a05:6e02:3f12:b0:3d1:78f1:8a9e with SMTP id e9e14a558f8ab-3d6ec59020amr121182795ab.20.1744061468131;
        Mon, 07 Apr 2025 14:31:08 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:07 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 29/29] rust-llvm: Disable libedit
Date: Mon,  7 Apr 2025 17:30:18 -0400
Message-ID: <65b35821c8e39b13b20f0413c315d0c8f1a64a11.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1328

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This option currently floats and is leading to non-deterministic builds. It
is used for commandline option tab completion which we don't need in our
builds in general, let alone internally within rust's llvm.

This should fix autobuilder deterministic build issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c31859be39c68f215576ba73b8a3d66c8ea590d3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-llvm_1.85.1.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-llvm_1.85.1.bb b/recipes-devtools/rust/rust-llvm_1.85.1.bb
index 566348c..12d7b2f 100644
--- a/recipes-devtools/rust/rust-llvm_1.85.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.85.1.bb
@@ -42,6 +42,7 @@ EXTRA_OECMAKE = " \
     -DLLVM_ENABLE_ZSTD=OFF \
     -DLLVM_ENABLE_LIBXML2=OFF \
     -DLLVM_ENABLE_FFI=OFF \
+    -DLLVM_ENABLE_LIBEDIT=OFF \
     -DLLVM_INSTALL_UTILS=ON \
     -DLLVM_BUILD_EXAMPLES=OFF \
     -DLLVM_BUILD_LLVM_DYLIB=ON \
-- 
2.49.0


