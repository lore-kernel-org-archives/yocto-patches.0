Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC0D609A7
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 15:13:56 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24913.1765898033999388507
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 07:13:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=iCwC7BDk;
 spf=pass (domain: baylibre.com, ip: 209.85.160.169, mailfrom: tgamblin@baylibre.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed861eb98cso52249231cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765898032; x=1766502832; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sv79Wv8EAzvFHJkWrp61H3v+Cdwe23kKW+o/aXt1Sc=;
        b=iCwC7BDkl10AWTzw5b7hX0urXwcu+UNtTEkrT8Fj8P0oOkxJkqEE+6IQhW/ZumRc2B
         1zzAITjlKE8Sg2W8RpL3UbpyUZMWNqPP6AA1Jtf+VlLUj4kqkpJiQhiiwLGgp8rssro3
         jEHtLBgqhobihnSQDOhRGGhmWOXBhIIG+R4BWY0fmXDWv/6yFxAEO0lAopVLBL0SAJu5
         Joti6lRH0YvJIybnp3SZ4SJjmlGSUncJXBiqsMKVDwAgFiirElLZdb758FyJ9frTydWn
         LCaN9wbD/Rdv/IUI0SvSHkbBCqWliADllqwK1kVUDwqZSfbM3DoKsZ1duZc6Zepz1IT5
         Dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898032; x=1766502832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sv79Wv8EAzvFHJkWrp61H3v+Cdwe23kKW+o/aXt1Sc=;
        b=UQCFX3Np0iRf9H2NQ5yqtmg9Ka2/39cQ0h7HGZ6SOqm0KG/m5z6sNEUmq8cE8u+RmK
         l/otioTW6KEfBH0BsKMzl6V4x5dx67+qHE/Dw58PA7lCiwPi06BabYuuHwz3y+u+nqKz
         Kn3146djzkoZ+a1BcKAafhhxrhQCeyIcf9oQbOlbW7d4BAXwGChSejOl4my8iQb3sRjn
         2sSgaKYul+Gva0G5mpye+AkKV2a82s6a3wxIupRGiPO5W745v8NlL3fkrblPkKMf4JkV
         VuovZ/Vy6pyoEcuvFxHoZ5bBlcW4X3hHRq/716LdFw4iJevaflsFa6H3nnCrJs6CoFXr
         jnzw==
X-Gm-Message-State: AOJu0YyWuqnLJAp6lou+Qo98IiwdtVVVxAiGAPzpcW0lxeRpld785frS
	B75dHtDRtZzfLmzMkyCDh8XwCxN4s8FdYv0vmexhDuJ3dOhNrAd8iR0u82/qaz6qtoC9jq8k2WC
	Qvf0Zy6s=
X-Gm-Gg: AY/fxX53TqwYJM3+TqIHjkmJbDZhYg/n1lVbj477FVwj8cGFQtqkKmwbXpfOcxcYQk7
	eWoTvBFadu1HujtWPTLjxvDZN2AaoYD57vXhmP+YmlaDy0W2KCwmv5IPh3nCh82xn6B2MATdMpn
	3xGcfCl36e3KD/SIEVVDcoGmtPkR+4tPoytA0RYKJ9qbX+SamZJtFLUUf4rf9ruwvfePzowFqGI
	ph7MKLkCetCJLldU96bw2yDgavXqFtonyfGrnn9hQ7LClKvGnL40oN3pa2pyKFLAonVw2aExznZ
	DyXwZ9DpEHy3eZmBvZ/Th7ZSKO7BemMa43TNZbTvKNcFt9f+XAEqbXwxZYeghRejcoeM23/wIXP
	ck8W8mDJZlfIz8UTVjAGkEfsHaqSQdzX09oqT61foaMh1vmzUHwwbKPnodZjXQunuaLdtRcIi0R
	wXruHpE4tn8JRP/mQ=
X-Google-Smtp-Source: AGHT+IFr8iLeVx/73Z+ZZ2xHa3QQqjSnXKIk8Mp8MOn/7Cz8Ha15iX7/hMBhqQKD7mHqfmxSoUKDxQ==
X-Received: by 2002:ac8:5d4b:0:b0:4ed:1948:a8af with SMTP id d75a77b69052e-4f1d04f4944mr190685671cf.36.1765898032320;
        Tue, 16 Dec 2025 07:13:52 -0800 (PST)
Received: from localhost ([2001:1970:3847:e000:8598:5636:16ad:2a8f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345b16ce5sm16080541cf.6.2025.12.16.07.13.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:13:51 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-patches][yocto-autobuilder2][PATCH] config.py: add meta-riscv
Date: Tue, 16 Dec 2025 10:13:50 -0500
Message-ID: <20251216151350.2550960-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 15:13:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2805

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 2b4d7bc..50710bc 100644
--- a/config.py
+++ b/config.py
@@ -24,7 +24,7 @@ buildertorepos = {
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
     "check-layer": baserepos + ["meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
+    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": baserepos + ["meta-openembedded"],
     "patchtest": baserepos + ["meta-patchtest", "meta-openembedded"],
@@ -66,6 +66,7 @@ repos = {
     "meta-clang": ["https://github.com/kraj/meta-clang.git", "master"],
     "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "master"],
     "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master"],
+    "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
 }
 
 trigger_builders_wait_shared = [
-- 
2.52.0


