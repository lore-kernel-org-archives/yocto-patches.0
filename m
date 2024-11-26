Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC9BD6554F
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.53412.1732644740660967886
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZklmqRhN;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d846307673so21372946d6.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644739; x=1733249539; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnJvkNDdYp1qgTsgyYP5I7zMimz2YAbhtdprmWQRZRs=;
        b=ZklmqRhNlCoQ8rhnNBqgVhoXXBTdJKk75RSClByStsj9iF8QkBvW2xbCS8Wvvv/3rU
         izosra2MchQWLfugCIe4uDEn5U+Bj6kNpXpu32Y1kHXe9ep1T5kjMXstreqpeokaKzd+
         IQDo4eF4cbBOwDNDowQfx1KdgkqsMPQdclaU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644739; x=1733249539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnJvkNDdYp1qgTsgyYP5I7zMimz2YAbhtdprmWQRZRs=;
        b=N7L35c1wuI4AoGC2UdTlJehPRsFiWmN7q9InsoaRFpHSzPvxoC4XVsPrJOZ7hyvAbY
         JxRIVDf4FVAxcaTftGXXn8Ht/F+JyIj4oAbXisOlMIcEOD8ANzrN75ji1mA99xbcB2hl
         1/TqjFhnQR9b6LDfkyU+vMkVJg+IfMeN7/mroSChl/+v+u/X/ciDWSSbM9JxZWsPSRoB
         3KE8XcL/wDGJgSh0ieIJUlyWXT0PaWaELrgn9IASuEBnDUaGK/hvjQhHfXQCDrayJecQ
         jOCrNvR3da4i/DJ8qyTVUpoN/vPSj7dxA+Lov7laJwOQpwA8Jdd+FLfyAo6QvGP3MuBs
         3eFQ==
X-Gm-Message-State: AOJu0YyzH1SF679vsHLAh+HhQRWucqsy32d67tQWd8BizAqq3CEsFsZ9
	iz8LrEryGpPcwrbCaB+iANtDI3B/+OO009t1iCfYPsdutHeHP01imwygW5GADVotbmWYsiEP8Cx
	f
X-Gm-Gg: ASbGncvdOD5LogFZqwNjtg8AB8qKUIvD5Mh57BHQ1BLF76gcXbRCalR61U1MUrLpZyz
	IyzkbpNMnJoR0SqOSYZ6gwFlIsxyhf76Hfk2ro5HZTiVUm/LEgWRLCgOWFGm72uEOsAcssmfFz+
	1/0jHZOl9VZS8mhwqfB6sq5lGQdhf3D7Dwm81xKBmhVtd+3BseGzhTEUxZff0O5xTjEtEH8wNca
	wquWRZSm46w2viiPbAuNR6s+n4b/BP+9k+a/yvW5CGVR+7dj2wTWqv85JMMo86Yl3z1CS4PX6YG
	2zOC+MiRhzqwcaJPNc2iTe7vQA==
X-Google-Smtp-Source: AGHT+IGuQbLGHh8D0d/B3Wd19Vih8Zaaj/mQmZbmjJSphJ9AYM252y41lF6J9QYRxX07ZxDVmJJryw==
X-Received: by 2002:a05:6214:c83:b0:6d4:238e:35ba with SMTP id 6a1803df08f44-6d864d5b1d4mr351616d6.21.1732644739309;
        Tue, 26 Nov 2024 10:12:19 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:18 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 8/9] rust-target-config: Fix TARGET_C_INT_WIDTH with correct size
Date: Tue, 26 Nov 2024 13:11:39 -0500
Message-ID: <20241126181152.407253-9-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/841

From: Harish Sadineni <Harish.Sadineni@windriver.com>

[YOCTO #15600]

The TARGET_C_INT_WIDTH value was incorrectly set to 64 instead of 32.
It is updated for PPC, Mips, and riscv64 architectures.

Discussion links for solution:
 https://lists.openembedded.org/g/openembedded-core/message/207486
 https://lists.openembedded.org/g/openembedded-core/message/207496

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b9df8cd8b29064d115dab3bfd1ea14f94a5c0238)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 993706c..e44252b 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -198,7 +198,7 @@ MAX_ATOMIC_WIDTH[mipsel] = "32"
 DATA_LAYOUT[mips64] = "E-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
 TARGET_ENDIAN[mips64] = "big"
 TARGET_POINTER_WIDTH[mips64] = "64"
-TARGET_C_INT_WIDTH[mips64] = "64"
+TARGET_C_INT_WIDTH[mips64] = "32"
 MAX_ATOMIC_WIDTH[mips64] = "64"
 
 ## mips64-n32-unknown-linux-{gnu, musl}
@@ -212,7 +212,7 @@ MAX_ATOMIC_WIDTH[mips64-n32] = "64"
 DATA_LAYOUT[mips64el] = "e-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
 TARGET_ENDIAN[mips64el] = "little"
 TARGET_POINTER_WIDTH[mips64el] = "64"
-TARGET_C_INT_WIDTH[mips64el] = "64"
+TARGET_C_INT_WIDTH[mips64el] = "32"
 MAX_ATOMIC_WIDTH[mips64el] = "64"
 
 ## powerpc-unknown-linux-{gnu, musl}
@@ -226,14 +226,14 @@ MAX_ATOMIC_WIDTH[powerpc] = "32"
 DATA_LAYOUT[powerpc64] = "E-m:e-i64:64-n32:64-S128-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64] = "big"
 TARGET_POINTER_WIDTH[powerpc64] = "64"
-TARGET_C_INT_WIDTH[powerpc64] = "64"
+TARGET_C_INT_WIDTH[powerpc64] = "32"
 MAX_ATOMIC_WIDTH[powerpc64] = "64"
 
 ## powerpc64le-unknown-linux-{gnu, musl}
 DATA_LAYOUT[powerpc64le] = "e-m:e-i64:64-n32:64-v256:256:256-v512:512:512"
 TARGET_ENDIAN[powerpc64le] = "little"
 TARGET_POINTER_WIDTH[powerpc64le] = "64"
-TARGET_C_INT_WIDTH[powerpc64le] = "64"
+TARGET_C_INT_WIDTH[powerpc64le] = "32"
 MAX_ATOMIC_WIDTH[powerpc64le] = "64"
 
 ## riscv32gc-unknown-linux-{gnu, musl}
@@ -247,7 +247,7 @@ MAX_ATOMIC_WIDTH[riscv32gc] = "32"
 DATA_LAYOUT[riscv64gc] = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
 TARGET_ENDIAN[riscv64gc] = "little"
 TARGET_POINTER_WIDTH[riscv64gc] = "64"
-TARGET_C_INT_WIDTH[riscv64gc] = "64"
+TARGET_C_INT_WIDTH[riscv64gc] = "32"
 MAX_ATOMIC_WIDTH[riscv64gc] = "64"
 
 ## loongarch64-unknown-linux-{gnu, musl}
-- 
2.47.0


