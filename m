Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92677CCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:10 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13179.1762633203956408405
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XT+iB4ur;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88033f09ffeso19272446d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633203; x=1763238003; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGFM7Qdti0gA5V4SvrG9HvPhAL1f5c+htgfG1RdXRJY=;
        b=XT+iB4ursO1wmDayJpXF3QjmltTDInijxn4Ord3Y/UX459RWCzvoZyDbsz43caBOaC
         nugQjsdMMy35SUDhd4xbOAHQ6+6crkYTe7/L5795jsPGxzw+Zn1Yt+uhxGE9S33wqNCH
         EMaNUUkJGSoPXPanLJiIfCU4IIsrzcPEujmo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633203; x=1763238003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGFM7Qdti0gA5V4SvrG9HvPhAL1f5c+htgfG1RdXRJY=;
        b=sXJI0KVRZPSfr0ncu3lGnrEqeWkF/cLqTxgQSGoVGFLHuXZKfN7J8aRBMKcloFendX
         MV8MDJxIDWcUOKHtNx/k05RqPnqZ/1A+eD7A+mAZ4x1z4gXTy027pBBIgfj1Trsnq9on
         rodlA/pP0ebq85QXkOBO9A6lDQYsTgfT/cFlJZraZ8i87mPdHyben6Gbj2D2L8emeTpt
         Wpy+cWMrx2Uivqd4F4y1kpIp/W+1dLHtXlllSIjDNuAZjdKezIbnJbLmylCcO1bKroVU
         9G0rgOBMoN0BxGcmrL2tix75LI3OPJ46RGcOiOhvZo0S7oTIRZokLNERpsem1GGYhAjh
         6fVA==
X-Gm-Message-State: AOJu0YzEnKC/dw2r7CGMiixjrWXjMcOnbEwOLVcoGnVv6O+tGTjt58iE
	3+KAfkpC3xSlB0JPq4O/1LTOnypJsIrCrljdwcd4rCE5AzYAXpCfBrqbVQyC15s29Obf9X2Iw5S
	ERyo8
X-Gm-Gg: ASbGnctFA3ZFaD4QVwmhAWvCLpXBmDI9nM3AZNPKbdeafvgnbRlyhRSbWIX3sx3cPl0
	HyppM7VDAY4GZW3NKGbLA9ykiovU4+jVmBgQAbvGAiaZb2GHfQ/GQ6M9X6M5StKiB+NYJ8gyPO8
	+ijrvHYCv366pqEyxIoJitfiR1JhDcgiMUgaFyDHNbx+BsxUP0SBdCX7czfR3DxIgT4uyM23jfB
	MSlVV0wvzg3ebwqVIPI5xsA8NcQEGLkfsITYmnWSJe4aHbFF60uDBwuN6RxOmpR9vJf9+5im1Nz
	elbaOeCk1iZqDvRuEcuGm84srZBQeUiM2+FN8irwg9Oe+KF+758pe8IWT40pj7nK3vw99ZrcVwT
	7vv1+b9HIoj8O95gC0t20YYC8/ZSWJVNAnpyELm9s65digG8GqYq5f9hb51LM/m5vW/Z4ZtcDiO
	v4vtq8xrOyG8zBiMlICsLZYxkXKKvzmv40ld6QrmrQBT3KFlRYJQ6X6Iioc5IPZ+k=
X-Google-Smtp-Source: AGHT+IGtvtAOloJC1TC7YIRrOdjWxnvWquXsBWVWxXG+M1ej2vzZYuGoTX0eDY6HhdQZ9hsTWi5FWA==
X-Received: by 2002:a05:6214:19ca:b0:880:4ebb:1e05 with SMTP id 6a1803df08f44-8823875749fmr45465896d6.65.1762633202634;
        Sat, 08 Nov 2025 12:20:02 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.20.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:20:02 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/11] rust-target-config: Fix ABI override for powerpc64le target
Date: Sat,  8 Nov 2025 15:19:46 -0500
Message-ID: <00c30d00f7377ee426b017bb46dd8c4c7eeea03b.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2458

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Ensure the powerpc64le check is exclusive by using `elif`, preventing the
powerpc64 condition from overriding it. This keeps the ABI as elfv2 for
PPC64LE and fixes related build failures.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1d4067329d0b84f94aaf2f63d282bb9c99ba5557)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index b9198c7..b5d0d18 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -388,7 +388,7 @@ def rust_gen_target(d, thing, wd, arch):
         tspec['llvm-abiname'] = "lp64d"
     if "powerpc64le" in tspec['llvm-target']:
         tspec['llvm-abiname'] = "elfv2"
-    if "powerpc64" in tspec['llvm-target']:
+    elif "powerpc64" in tspec['llvm-target']:
         tspec['llvm-abiname'] = "elfv1"
     tspec['vendor'] = "unknown"
     tspec['target-family'] = "unix"
-- 
2.51.0


