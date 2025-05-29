Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B980C3ABB2
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:23 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.12289.1748486537464769730
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Wo+H81RE;
 spf=pass (domain: konsulko.com, ip: 209.85.216.53, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3109f106867so472049a91.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486536; x=1749091336; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmRt8Ms4cHicRXKaFF+6/iLHOg2bv/pF5iKfKFCWGZI=;
        b=Wo+H81REdPOouOwkDCeJZ2yqd5LcjxMMPzhnSn9DKmKxBDu5TV5lQBzfF8L5yZI4Uj
         //3vs5YtKD22yCbMsawWxvW7L93CaJrL3kbOg6ACsOekQI+CVRloNx+LO6pbGYH58oMo
         JE7eybIu15j3xWtsj1IhK2FGR9ICLeyDLcRBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486536; x=1749091336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmRt8Ms4cHicRXKaFF+6/iLHOg2bv/pF5iKfKFCWGZI=;
        b=e+gFlAIgKpK0FPpiX0f+w6efPBeovaYcSlaWptnipQ4zVklR6qf3W3jZ3UqXGLjAvf
         16E5tx1QU8SI4LJt/ZRYRcK/i4E8rFXPUZeaA7ReHRg2meNiSIR0Lmj0EnqEdY8+KGQH
         Hjhhz9zdzjTTQysqXZ/rOTxVn+NJQQUiMT/dOnfBG0434BKy1OGeFkxB8qfxsUT4jl64
         ONm3AtPdwEBoDtSQXUOcY+9YYtIiKjVUlrhAQKZYaGi4UvqANbBUZil95Yt8jL1g6d3y
         u63b4bBiR4NtgmyY1PIn7bbeZ5SYbMLbRSvYWRrHl2uNaHQ+q0BPwpi3aq67reJnYn7h
         1gAA==
X-Gm-Message-State: AOJu0YwfOT3whKB75cc0nW+XZFK8Ys8JQIXD27qY0bENzfapVZtqo/Ck
	XSvc3bheQZaasbWcZgYOazqWAWUr44i0VtG6d16A0DEAsOoTmLEgf7w9Y9E3cV1vZFw3F2Xfule
	Di8Uxc17r9Q==
X-Gm-Gg: ASbGnctB0nfUZnDy/mdoH4BTdujp1Vj0b3MpJQiOgURW7JVdpf1ciAPq0TYqJ9n5KEW
	t6bKijAMqFd0iwYuFvf52xtJHO5nSl7xcd86uA4+HYtmoGrR41q4X5DkIMGzGOl83j20NBS+37p
	o0BuunSro21BmjwH76tn4aluM+muFeaYjjbTeWER4fjqOEEhkoGoyp3D4Rpxf55jlZn3dFAuOot
	j3zMvWa1RTbNFJ4ViPxa+Qj2l7+NHWWHVyOaLX6T5IJ43wLXUQAetWWd/Whv2McUvhMAmpgFPWB
	SipSKJiUK5Zx4zXIPMfz1vD2xYFp5iVzZOmrpN9w5BJE1/f1CdJ+rp9GhbzcthVAx0fY6x4/0+u
	tasSdWlKGFLm/XMY=
X-Google-Smtp-Source: AGHT+IEKaPJE5DFbT2Q0kz+wMEkJtHAtcNCGJ7q2MlTah1P4OsM28OSS57iNV+YNZiCfxG61nb3rnA==
X-Received: by 2002:a17:90a:e710:b0:311:bdea:dca0 with SMTP id 98e67ed59e1d1-3121dcc544bmr991601a91.33.1748486536455;
        Wed, 28 May 2025 19:42:16 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b6fb2c2sm355156a91.2.2025.05.28.19.42.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:16 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 10/11] u-boot-tools.inc: Fix variable assignment whitespace
Date: Wed, 28 May 2025 19:41:37 -0700
Message-ID: <ccbeb7201e789d623b5d335c6d2c6956124188a2.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1594

From: Tim Orling <tim.orling@konsulko.com>

Recipes are much more readable with whitespace around the assignment operators.
Fix various assignments in OE-Core to show this is definitely the preferred
formatting.

(From OE-Core rev: 30ea609d3357fb3de911f2f6a5e6856c151b976a)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Only apply to u-boot-tools.inc

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-tools.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-tools.inc b/recipes-bsp/u-boot/u-boot-tools.inc
index 09b3c3f..278360c 100644
--- a/recipes-bsp/u-boot/u-boot-tools.inc
+++ b/recipes-bsp/u-boot/u-boot-tools.inc
@@ -2,7 +2,7 @@ SUMMARY = "U-Boot bootloader tools"
 DEPENDS += "gnutls openssl util-linux swig-native"
 
 inherit python3native
-export STAGING_INCDIR="${STAGING_INCDIR_NATIVE}"
+export STAGING_INCDIR = "${STAGING_INCDIR_NATIVE}"
 
 PROVIDES = "${MLPREFIX}u-boot-mkimage ${MLPREFIX}u-boot-mkenvimage"
 PROVIDES:class-native = "u-boot-mkimage-native u-boot-mkenvimage-native"
-- 
2.43.0


