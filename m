Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3ADC71157
	for <webhook@archiver.kernel.org>; Sat, 21 Jun 2025 14:06:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7892.1750514789188831837
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Jun 2025 07:06:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T3vFnynB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce671a08so17153155e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 21 Jun 2025 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750514787; x=1751119587; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn/sxIf99TiGuWdGoadxJTLOM0G4Tj3VTyamQFCbRiY=;
        b=T3vFnynBBDjUQFKkFOiSDS59TtDZyLnHlL3+DtG+0iVlGxyxlLMKAh4J8O2VIWxTXF
         9HxW0VjHc88L6xiqhO0mDpXtcXBS7GjV2ixEbzAEBl8MVuCvAyCgn+4vlIwjXg/0X0+N
         hZbBhVDoaGU5nKHtO6MCT69L3azWNSs8M8WvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750514787; x=1751119587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn/sxIf99TiGuWdGoadxJTLOM0G4Tj3VTyamQFCbRiY=;
        b=TE2BV9yOHZUKTcjQqfpz8SGodU3FEQaWItbV3IrjCuq4MpdCi/FrgtH3/XsBO+gSZl
         oPcgWe6hw+qFAmW3o4Ild4Vqb1H7pGwFSUhXEXYbKlKpvUH4t5ucrvMnrAPs1ZFiE1DL
         nSpsEsV1jBy44twmZQ+9S28toFEdrqgGP6EdddM2Zij22jT/0GyylO8617qGjuHmO2no
         zuiEYFXOQ5Ht3A1OTy+0bXAEXXP3qnA2JzcKR+VYvmI09UINl/1nVoT8BudUkCeMIQAB
         FLMSW0EKfOPdWWrA9Lc3e8vq4HLiQlZMAyolO2oeXeBwvkqlLk6I/hzF78kiLcsd6PWp
         HfDQ==
X-Gm-Message-State: AOJu0Yz0TkkXaHWwgiA/73aBN6Kg5hXZ3gfyfsJb7tw35QrQsxs5zDW5
	HrE6F6TTAXOxDVqIj9WVmYsujHLa1kMcpJC4SUN3GgTWoUDT/K1qm2bcxnITcrjPt/zC6yiFMQO
	BNvlE+5c=
X-Gm-Gg: ASbGnctcA6tUfAWAeBbVawhOVvGepgFQP1fTD5TK/uWtQEtwLAWEXHsDLnpH3KQmkFp
	6fqE4z9Sa9wE4qvG3i4pZN9FJfBVmoZp8a7KB96/I444C2CyP711LZtpX0/jp7HpkBeL/W0iN0R
	IppPuQk1rIXGggBIiJI/ZWn8o8dHjaLE3L6wOGUgkiJx27qa7SFzsKYJTkZBiRpBwWyuH/j2iZi
	2tcIu4QgkVVy6JDhF0ZkILSck0w/Z88TtpibUrbPALOf/Eji9CxpwSANbRGB9Zmr6A/T0W797oR
	huS2aigUPHCcjwgYcQezBin8W1MBchjiCQd0rOxywHsinkKfDsrNJtpf3UyyleragTeuCzWbRus
	Qdk/0u+x6MMBULA==
X-Google-Smtp-Source: AGHT+IH5yWW+lJvfxKso1KDCnMV6qI7wUaGo7LIn1/420+cRs9WjqdZa0tJT8tGoFRbxGpbqZq2Yjw==
X-Received: by 2002:a05:6000:248a:b0:3a4:f5f6:b4ab with SMTP id ffacd0b85a97d-3a6d13044dfmr5058842f8f.30.1750514786810;
        Sat, 21 Jun 2025 07:06:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3287:1ee:865a:f13c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117bfd9sm4915703f8f.57.2025.06.21.07.06.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:06:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Stop oe-selftest-armhost from running on 20.04
Date: Sat, 21 Jun 2025 15:06:25 +0100
Message-ID: <20250621140625.2658721-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 21 Jun 2025 14:06:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1674

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index a6555555..1070fa8d 100644
--- a/config.py
+++ b/config.py
@@ -230,7 +230,7 @@ builder_to_workers = {
     "oe-selftest-ubuntu": workers_ubuntu,
     "oe-selftest-opensuse": workers_opensuse,
     "oe-selftest-centos": workers_centos,
-    "oe-selftest-armhost": workers_arm,
+    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2410-vk-arm1"],
     "meta-mingw": workers_wine,
     "buildperf-debian11": ["perf-debian12-vk"],
     "buildperf-alma8": ["perf-alma8-vk"],
@@ -248,6 +248,7 @@ builder_to_workers = {
     "toaster": workers_toaster,
     "default": workers
 }
+# oe-selftest-armhost doesn't work with 20.04, can change back to workers_arm instead of the list when that is decommissioned
 
 builder_tags = {
     "qemuarm":  ["qemu"],

