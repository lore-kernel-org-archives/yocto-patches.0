Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64EECD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 13:31:59 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20344.1780493512504418868
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 06:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E6nMmSNN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bdb3fd39045so1900567466b.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780493511; x=1781098311; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxDzRSwx+yiTLSNXYlwmoE3yDaWrE078ZTpZVkpeuLI=;
        b=E6nMmSNN6yh4L7d8kF2P1hXdSYJrsWVaw7OrXJIoEnUadUTIxka2uH0HILGyoNl12Q
         XsyP82AfGuxTLGWG7E45zzU7DVY8UAQkTIFymuL9toiRWP1rnNCk9canJb/3tdERZRR+
         WkAH+V/aea1IKQfsMMtu8dGQt36LsSFC/8NVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493511; x=1781098311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxDzRSwx+yiTLSNXYlwmoE3yDaWrE078ZTpZVkpeuLI=;
        b=EhajbwQKWCmJfJHRSwPeR/95zULe1PXB35QkYUMk4uxRP2T47/0QcQ6zq+jnXZqv/S
         IAirUKvIYPfmbG6pjuroamhvb59Q7rOZbSar0B+icGO21t7p3RMv+/hdYcjN7Lm9MzkC
         AM1NX+2qO9kmyQ+81/sVtSEq7q1Hbhd7cKl6IVCnoRU0kvqwLQ2UxK7vOPaYGtuu2qc3
         zEfrxAczYWs7BXOHwu53/H1d3Q3HkmTEPM+fImJHm/vrT+naAkchW7k90tLUfXGWKj2C
         8cHyrugeV9Y+8Zx+aSa/hxWVQFQNy16z+rbM9zpPtlqmcPXgdTSav6ePR+O0KAJpAI+/
         Fhpw==
X-Gm-Message-State: AOJu0YyRa/TjpHckSs5F6aGhJKdelNovoC6bJs3ojLD4eTK8hcBpqrYI
	0rKfGX84q5+cSBHKmUrcM4NkDKi7IZgGti1EZAfTLMjOcSugEAdIuv5SWMiTOQ3jqG34tscGWw0
	K+c1f
X-Gm-Gg: Acq92OGCke5+wIJXSIpsvmV2S4Tv2Z2BgBXWe69qDpWaxOC4XMPSMNOH5L9NV/spzsG
	4UZdDr/Q748APY3VZfVrJ147h1k/csmM6M9E1/EP658UMsEmvgqnEsKr2pBS472jy2gwnPsmF+6
	mKa/dIWMnN7/Rds9xobkOYly1+fZ7X1ilZAXW/ELK/k9flR2lCjvWSofK26Mi3D70OyeNbCPfXA
	EFCTv7mrIsMkxPZEcmBEm1FSujCTmMjThAtkeU1g1XXKd9JYVFs+eshmef4MBaUV1aIknDLHxaR
	bsPaYf6FiiOfVPJSnzTfGzmRo+dmboEakf67dQUORDY4HqOcEXEsscbbMfOUUNMHuI6vXXpCcY2
	OClyqU2DvpgiKgNDiLTUWiB34kc+gF1dA04RWBs0nIvvAvGIxCw4gA2SILvGJiNHL2b96W9lq3V
	HB25M8fsK/EvHkE6/D33Tc2q60WPOZ75a0e+bG63uY2ZcclXpUeX5RyTN3ovE54A==
X-Received: by 2002:a17:907:8990:b0:beb:e858:7192 with SMTP id a640c23a62f3a-bf0af0fc87amr185103766b.37.1780493502661;
        Wed, 03 Jun 2026 06:31:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm156048366b.52.2026.06.03.06.31.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:31:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/3] config.json: Drop bringup and oecore-qemuarm i686 SDK testing
Date: Wed,  3 Jun 2026 14:31:38 +0100
Message-ID: <20260603133139.1113999-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603133139.1113999-1-richard.purdie@linuxfoundation.org>
References: <20260603133139.1113999-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 13:31:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4118

i686 SDKs aren't being used, drop them from bringup testing and from
oecore-qemuarm since that just duplicates a pointless build.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/config.json b/config.json
index a9fb40c..e650b1e 100644
--- a/config.json
+++ b/config.json
@@ -214,24 +214,6 @@
 
             },
             "step3" : {
-                 "SDKMACHINE" : "i686",
-                 "extravars" : [
-                    "MACHINE = 'qemuarm64'",
-                    "DISTRO = 'poky'"
-                 ],
-                 "BBTARGETS" : "core-image-sato:do_populate_sdk",
-                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
-            },
-            "step4" : {
-                "SDKMACHINE" : "i686",
-                 "extravars" : [
-                    "MACHINE = 'qemux86-64'",
-                    "DISTRO = 'poky'"
-                 ],
-                "BBTARGETS" : "core-image-sato:do_populate_sdk",
-                "SANITYTARGETS" : "core-image-sato:do_testsdk"
-            },
-            "step5" : {
                 "BUILDINFO" : false,
                 "SDKMACHINE" : "x86_64",
                 "PACKAGE_CLASSES" : "package_rpm",
@@ -521,11 +503,6 @@
             "step1" : {
                 "BBTARGETS" : "core-image-sato core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext",
                 "SANITYTARGETS" : "core-image-sato:do_testimage core-image-sato:do_testsdk"
-            },
-            "step2" : {
-                "SDKMACHINE" : "i686",
-                "BBTARGETS" : "core-image-sato:do_populate_sdk",
-                "SANITYTARGETS" : "core-image-sato:do_testsdk"
             }
         },
         "qemuarm" : {

