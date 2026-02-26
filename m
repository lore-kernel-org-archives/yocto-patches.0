Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE34FCE06F
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 12:47:30 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69015.1772110048049633944
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 04:47:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dRrElHrn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4398f9e3b40so786314f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 04:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772110045; x=1772714845; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuUq9JmrucZMd6ElJ1AJphJrII3jUWYoT9ca0gr+zQo=;
        b=dRrElHrnK0029JQ+OhnIyGiRHC8J3MyyOI5hL4rTwfBLC09LBV4C0zyiRSf5nFVRa1
         HUSKQlUeJVDuOSB10iZUaX6r9If3qHmlrZ14aNkYUEuclQVKcshdc6eBAOnHhG9h/253
         /WIbanYlXIOYiOTe1ZkJyHD0a4y6aFaa61KMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110045; x=1772714845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuUq9JmrucZMd6ElJ1AJphJrII3jUWYoT9ca0gr+zQo=;
        b=UxNdH8vT/FwbIjzVvLMKZ4/hrH0Uh+H8mhrUS5YawPHhCf4da5+p5sNJCNQpTOQpj5
         qOMqxTEyDhszQNHVzu8nD8hbSz8kBa8Kr6ZdCC9leRkqMCTqW7BwdmlMiHTJaOoTwsiK
         YbHdLcAHrTgt1aRcL5Cl3tD0mi8OEBoX3dFyQLsjJz1LLakSB6P3RGeO+ZpTeQZiE+kl
         /L2UsPpMMiCfB1AiZUBlxjI52EabehcoznVK6EejY84U5lXtVsSeV/kb5kqZzSzTPHJ/
         BeL9If09aRtU/ZT1SqgQU3JyY3MiW2xWj01LquuQjBcDsdVe0tNNnctbvUwjQGeSj5jo
         uucQ==
X-Gm-Message-State: AOJu0Yw9OhOwgjxZfls/9PT1O3Eq+ptH2NrH4ci7fKuiHCju3tSDejvH
	i4/eAbFvASJQ3DJ9TPnGEdYLgL31ximPyOcbo2AXtwKHye8JUqzexr9+S25kYU1jBVrQDjjD6Yb
	gcxrtyaU=
X-Gm-Gg: ATEYQzwopZ9stI7DBYR42923hx5itFNx35+xil2xMLOWLwTu/VqHf8Jdf4LjnWiozgE
	ecgZa/5q3ErSM0/5Y7aP1gt52NCgcQgg+m8c8um5pbl+PLHd+1NzIFNyj3qAv7XxlTaYpyVj/+v
	K8E3PwWDBRUH4Fw1yOCWPjdwWOcl/WaSfK0v20/s7pmA/h6eMGiCwbyWYLYUnPrG7ITzupphRfj
	gSTcAMz7iQBGwFPS2u2D9OPAKcjQTVNAkxc2Q+fs7tHUj5Gh4sPMsLf2xqAdPQiM+Kxu2nj28Rv
	3dX1yaeINvyIwjPXxNoEjg4LbGSpEUHujL14tvRiOeJlaOiNwHMZxBEAqAtx4EtrqST1buYxzv2
	5e/znZEzoQsS7to1TBAlKHuwIZEWhe3jWloRM1QHAupGlLavJhnaTDLvgEc+tycIRun385iyOqs
	UnheVw570iE5W1h6MlTiA0xn9DGe7qwhNanZgq5y4sGl3FP3Srhn8=
X-Received: by 2002:a05:6000:2dc6:b0:437:81b0:6650 with SMTP id ffacd0b85a97d-43997f464bamr4324093f8f.56.1772110045396;
        Thu, 26 Feb 2026 04:47:25 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398fefa3f8sm10855302f8f.36.2026.02.26.04.47.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:47:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/3] config: Drop meta-mingw from builds as a default test target
Date: Thu, 26 Feb 2026 12:47:21 +0000
Message-ID: <20260226124724.717336-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 12:47:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3282

meta-mingw is no longer going to be part of a-full/a-quick testing
and will be manually triggered instead when needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.py b/config.py
index 70f11a18..70e41109 100644
--- a/config.py
+++ b/config.py
@@ -86,7 +86,7 @@ trigger_builders_wait_shared = [
     "wic", "poky-tiny", "no-x11",
     "musl-qemuarm64", "musl-qemux86", "musl-qemux86-64",
     "qa-extras", "qa-extras2",
-    "check-layer", "meta-mingw",
+    "check-layer",
     "reproducible",
     "patchtest-selftest",
     "oe-selftest-armhost",
@@ -113,12 +113,13 @@ trigger_builders_wait_quick_releases = {
     "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl", "qemumips", "qemumips64", "qemuppc"],
 }
 
-old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc"]
+old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc", "meta-mingw"]
 riscv = ["qemuriscv64", "qemuriscv64-tc", "qemuriscv64-ptest"]
 
 trigger_builders_wait_full_releases = {
     "master" : trigger_builders_wait_full + ["meta-clang"] + riscv,
-    "walnascar" : trigger_builders_wait_full + ["meta-clang"],
+    "whinlatter" : trigger_builders_wait_full + ["meta-mingw"],
+    "walnascar" : trigger_builders_wait_full + ["meta-clang", "meta-mingw"],
     "styhead" : trigger_builders_wait_full + old_arch_full,
     "scarthgap" : trigger_builders_wait_full + old_arch_full,
     "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
@@ -128,7 +129,7 @@ trigger_builders_wait_perf = ["buildperf-debian11", "buildperf-alma8"]
 
 # Builders which are individually triggered
 builders_others = [
-    "meta-oe", "meta-virt", "meta-clang", "meta-exein",
+    "meta-oe", "meta-virt", "meta-clang", "meta-exein", "meta-mingw",
     "bringup", "bringup-fast", "buildtools-docs",
     "qemuarm-armhost",
     "check-layer-nightly",

