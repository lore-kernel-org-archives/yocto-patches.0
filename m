Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129FC2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 10:22:38 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9328.1747304549251774526
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 May 2025 03:22:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YTaEid4L;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b933f214so459363f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 May 2025 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747304547; x=1747909347; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtNOYTybXCig/9kUttVzDpqxVW45o7UEK9/j1WLkoIE=;
        b=YTaEid4LS5nx/vBPMydH1EdoTY2wYiRHitFJiEL940GAX+Y89YyaSwSPMTNGT/OQUs
         /au/jSBp8HYmcjrEg5I4jlu4kl9r7A+dH4fz8oqph8vhbvGSZtNJhxexeapKnyrlWNSC
         RoI2nwTtD4lSdjJqtl3l5LlNBqoor9hXY925s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304547; x=1747909347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtNOYTybXCig/9kUttVzDpqxVW45o7UEK9/j1WLkoIE=;
        b=uxd1DDfdr5eTtSH54ApBWb1uNCld1fWun77V00ZoTaw6t24JpoVWYr30Au9LfitP07
         mfWWK7updZ/paTCHph3xx1/fL2gL3JgexKi4Rx3C2db9UspCC0f7yUeM3TndZ9LCcx5X
         LzCiA5g0X7980vNekRt6CJFxhD9GCeuZ2+Nh5/EnQrDpFaKlsIYcMTKUjpzKLezJyu9l
         M78SptVEI+mmxZuI8DIQEJADbJ49SwqCi0DiKq2KzXkKYaMorM8EXH6ARmQsHbrx+cRG
         ymHCaipjCYZ44WpsVt1dCr0kGS0KQv+X6669wSZAfb1dF/wnIcVDLhrfXTxyddX+mFph
         PUVw==
X-Gm-Message-State: AOJu0YwJlqBqeo/B8fGoCPPhrGnq7U/vqlmACXPkxg2L5BkY2tu0spYK
	W4MYR6dSc60/bBB/S9sDEFNb3hc9VCO1iwT6dU7X7ACWuINXNjbs2McRHmM1gIIeZvUTfTgYFK/
	E
X-Gm-Gg: ASbGncvLRav5O6SW3OR3rbDIuCnQs9JptIlZaM6kphhlH2x4i4un1VMcbnTqPU3qOpO
	HGeeJOdwJMMK8ffELMmf7hVlwcS1ci4RpudV2eDct7RvQEe3ZBzG75TIC3qluzS4iAFJHrulg8E
	9adCPXdNOpEYHaSOl2EvpCJ5Z1T//jn2hFXiMEF13UKgZaN8Lfdv0ubCkj3pV+eR8V12sivd25o
	so2a5xoOPzfk9fCn83cV6i2Ynvx3ZAdx0qdGXC7w+w1Wo+Yjn6sUri67d5P1ldC9Hc3iw+pPD6O
	72fQ5m5WOYeVGohqiNGn65UQ7+swFlyjBX/GrhxMNZXsRHU8Wm0mVIEC6wS1ibMUgqGhePE25u0
	5WAk=
X-Google-Smtp-Source: AGHT+IHTl+ehNLcYr6pXpKM//FKBbto5BTO4y1/NM7whn+Q7hycBB5Iuxj7Hc6mx80kHM44e+8bOwQ==
X-Received: by 2002:a05:6000:1f10:b0:3a3:55ea:c6f8 with SMTP id ffacd0b85a97d-3a355eac818mr894858f8f.49.1747304547040;
        Thu, 15 May 2025 03:22:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7c21:701d:240:45b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd46aa4sm60821085e9.1.2025.05.15.03.22.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 03:22:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Add qemuriscv64 to a-full master branch
Date: Thu, 15 May 2025 11:22:23 +0100
Message-ID: <20250515102223.1624902-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 May 2025 10:22:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1558

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index a3489ecb..a6555555 100644
--- a/config.py
+++ b/config.py
@@ -121,9 +121,10 @@ trigger_builders_wait_quick_releases = {
 }
 
 old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc"]
+riscv = ["qemuriscv64", "qemuriscv64-tc", "qemuriscv64-ptest"]
 
 trigger_builders_wait_full_releases = {
-    "master" : trigger_builders_wait_full + ["meta-clang"],
+    "master" : trigger_builders_wait_full + ["meta-clang"] + riscv,
     "walnascar" : trigger_builders_wait_full + ["meta-clang"],
     "styhead" : trigger_builders_wait_full + old_arch_full,
     "scarthgap" : trigger_builders_wait_full + old_arch_full,
@@ -144,7 +145,6 @@ builders_others = [
     "check-layer-nightly",
     "metrics", "indexing", "metrics-gitstats",
     "qemuriscv32", "qemuriscv32-tc",
-    "qemuriscv64", "qemuriscv64-ptest", "qemuriscv64-tc",
     "qemuppc64", "qemuppc64-tc",
     "qemux86-ptest", "qemux86-ptest-fast",
     "qemux86-musl-ptest", "qemux86-64-musl-ptest", "qemuarm64-musl-ptest",
@@ -162,7 +162,7 @@ builders_others = [
     "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
     "meta-webosose"
-] + old_arch_full
+] + old_arch_full + riscv
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
 builders = ["a-quick", "a-full", "docs"] + subbuilders

