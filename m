Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16ACD37AD
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:24 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4649.1778205621944335710
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LYGwg2A+;
 spf=pass (domain: konsulko.com, ip: 209.85.210.177, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so603675b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205621; x=1778810421; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEP8G1O95TpTZYH/jfmYSZcfeUJ+uQ/O8q92RN1QEwk=;
        b=LYGwg2A+XTPVkPUqjZa2BgktJ9f5JTdKTQDhTV2zG79ipPJvkKKnI6/aRDDZt81V6M
         KpEGzUx3Fz1+5nctOH9svybrK6NAjgCIh/RnCA8lvnin3Jz2032wGe8r0rT2lE3lf8wN
         0up679U07vno4HwFzXz1plOvP0XL+P5XSr8fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205621; x=1778810421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEP8G1O95TpTZYH/jfmYSZcfeUJ+uQ/O8q92RN1QEwk=;
        b=aGoad1F9glCDTI/aGKJd0x1pjGoUOl4bGAdpYDx87ZocQtnUwM0hyn4w2bDmprU2F4
         p4GNiO/xt44aabh9dxFzf5aQT9aBhWM96iSNSn6u2vs/X8ECaRWNqnfxVTx7W51CL8LZ
         pmqzDA1EeTwwoY84FQyLUPt9owgyjFDo2+Q2jeIdtG4AKquL++I5doJEG3Vw2CQPuTN8
         h4lgryGYmQIHMz9cku/jutlN1DUwsrcW/2wVz//d8ppgDzM7Np5gnH/EtQvEIVcYVKp0
         xLf+LM48050r8hpAVA64yz1TsY1wtvZG2pD+t+MsueqqvSFslnKqJKK0h9XE63wEogw0
         KJ3g==
X-Gm-Message-State: AOJu0Yw/Tl514M5zJFiQsV9zkHnZ6vaB82X6MQRbL6EBjxrDgVEBZ6rE
	m/z6Gv3QviPxf7PyDdnmB6W1KvXMlSJYd+Wl5epza4Y1fd7cUrF2NLAb1r3tTZPH3DpGAicskb8
	8DSz2
X-Gm-Gg: AeBDieu40chAe57NwbvZ5qf+tc57ExoXYJi3Gp9DJ3OgIUDAt63o2+ITQMwsocu8zA2
	M47Dxd9AgmtPo6KxPee3ORS27m5Ddj9+z4aSY1Hn+kMctAa4VIviT7zysdJct+VUGyAuc+JvSsZ
	rJvaOB2wFCfOfsICF2YnDdhCxalDycqKirUScMYzMYaNbDVd6IlsUGtkQYhV2xrNza/AciJfIbp
	+5cYE3lrFAqPH5h+K2RuxYbIkq54sCTMHbsvAF6E8bTeyk29VItFbvrMMAqW3+Plt38KTOBwcBF
	Xr2Pk3Z2+yCd8p/c8k27AC4GmChg5PLZJq93YCBKlvc7S8lcGwhgpSqTwg3HqV9Fy/FOxYNBZd4
	7vFlkxrzpQBXe+zATSbJQ+8UH22NG9kD1mNk8kDoZA/grWHtZvIvty0r/GyWxAQelmLLmQyHmzX
	irvrB4GbCja+s6FozQAjtJepU3akQ+n21lWSGkBsrXOQig7KEldgNoE7U5Yg9noKE=
X-Received: by 2002:a05:6a00:3a12:b0:82c:dde3:f2ef with SMTP id d2e1a72fcca58-83a5ea40ddamr9541355b3a.50.1778205620893;
        Thu, 07 May 2026 19:00:20 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563ac51sm10344035b3a.2.2026.05.07.19.00.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:20 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH 2/4] config.py: add containers-meta-virt;-library jobs
Date: Thu,  7 May 2026 19:00:04 -0700
Message-ID: <e8cacf7019cd9855bb698acb43e40ce11df2f728.1778202070.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202070.git.tim.orling@konsulko.com>
References: <cover.1778202070.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3936

From: Tim Orling <tim.orling@konsulko.com>

Add 'containers-meta-virt' job for the original containers available in
meta-virtualization itself.

Add 'containers-library' which includes 'meta-yocto-containers-demo' and
adds additional containers. The pattern is modeled after
docker.io/library/*

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 630c8d3..e7f9619 100644
--- a/config.py
+++ b/config.py
@@ -35,6 +35,8 @@ buildertorepos = {
     "metrics-gitstats":  baserepos + ["meta-openembedded", "yocto-docs"],
     "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
     "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "containers-meta-virt": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "containers-library": baserepos + ["meta-openembedded", "meta-virtualization", "meta-yocto-containers-demo"],
     "default": baserepos
 }
 
@@ -68,6 +70,8 @@ repos = {
     "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "master"],
     "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master"],
     "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
+    "meta-yocto-containers-demo":
+        ["https://github.com/moto-timo/meta-yocto-containers-demo.git", "master"],
 }
 
 trigger_builders_wait_shared = [
@@ -161,7 +165,9 @@ builders_others = [
     "non-gpl3",
     "meta-webosose",
     "meta-qcom",
-    "vcontainer-tarball"
+    "vcontainer-tarball",
+    "containers-meta-virt",
+    "containers-library",
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -329,4 +335,6 @@ builder_tags = {
     "metrics-gitstats": ["metrics"],
 
     "vcontainer-tarball": ["containers"],
+    "containers-meta-virt": ["containers"],
+    "containers-library": ["containers"],
 }
-- 
2.43.0


