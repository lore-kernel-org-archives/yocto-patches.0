Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB5C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 15:12:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.10397.1742483578929390305
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 08:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=XYeHJ2w7;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3965c995151so500538f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1742483577; x=1743088377; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylxg2egYI/LaTXuEb9vG/gLE/dFSAMb0pVUVkmANzmA=;
        b=XYeHJ2w7RwtudcjYasua8k555wzOhYHUvoniqLIVnk7jZ6twgPjuH+tTmIeBGGRSpi
         OASwsL4rovaXASMmz5kGNFd203A2KCyZzCqdkfBNHdy+XjkGhnYhDdFN004LKbSfjebQ
         RN9Rj7G0s/BvFEeCT2l9PSbDsiXUmXK6FP5cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483577; x=1743088377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ylxg2egYI/LaTXuEb9vG/gLE/dFSAMb0pVUVkmANzmA=;
        b=Hpyjg3xvHAdLckRbpYCmSJS60TZsYFfoJB+u0r+dIGSCMtK3IVs5IZRdGVpF+0wLBc
         qzISyz4MEdhg72VmCvBDki5j08qwyjXCFpmyZatrOPapZZAuiIcvrfqnwXfr7ezBsOCT
         UBrhwsO8aWoni1vZgv066XvWeob/z8T7Y2ZkRYjIhRh19lTJSYZpJGQG1ox45Pp7U40U
         jPqSjVWqVgKmBVkklotFGwRBLw/296oWRyfLx4bFkClkNvSt5qF2oMvxHRc4E070Meqr
         ySDgB5nncYAuQVookMnQYad5K7PxIskfAqN95AgLm9aW0kkTCiObIMwlFR5zV7Kvh/OY
         faqA==
X-Gm-Message-State: AOJu0YwH4WFNUuDy5RGf8oQ5mWePejhkCDs4c/bnQ+jLrDOmARoVs+as
	Ct5JyhcwmJrOONPtmZOVFkwIRZiLixLXNmOb3mL+4xMQZKgkZ0uHl6Ly2UIK6Mgi+tI5LtTBunK
	L
X-Gm-Gg: ASbGncvv1JIWj3wF2RXHYZr2AYod/ClvI1E3WPkJ6rDrJHBUsUGszr1i1cB60dFqzKs
	mrbbu8gvEETGgr/8A6t42W8bvymtpBTmfRNMF/ht2Vgwcu3uyVleJnttdhgUM4JA1LZfUTvSGj/
	EMU81J6q9hrBD8a9y1ApW+3qjj9Rikdgfm6CTs+Nsb3La4F9VL/ZsNDwOdtxOl4+2NjfdtrEido
	XMlNMLL1u4yWSwGgCY2dxJB4em1piLxcce58crGAR8OXh78GxACYdtGkCk2xiQXKl7sUGApvS/K
	ItFduGXAKUJnEir/NUMgmZv/3tAKeuVXvPwd4MYayiVYy1QPHMM5cf3h/enBtZW0pr3fksCdSGO
	tk42WMNXTiJQUYctZ7Si6rAE/UlTw/GTmDLxYYnBooSHagI9B7xqGO2ARQA==
X-Google-Smtp-Source: AGHT+IG2SXGnVXgnDzJ841fdshXstYJ2HU8GNF585tJ40I/9q0gZ4LwVOBEgHMRSW52389MLm32M2Q==
X-Received: by 2002:adf:a1d5:0:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-39973af938bmr6775959f8f.35.1742483576926;
        Thu, 20 Mar 2025 08:12:56 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm23685874f8f.27.2025.03.20.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:12:56 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] dashboard: Fix a Auobuilder -> Autobuilder typo
Date: Thu, 20 Mar 2025 16:12:37 +0100
Message-Id: <20250320151237.2775485-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 15:12:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1234

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
index 3b2b36e..0ec601e 100644
--- a/scripts/dashboard/index.html
+++ b/scripts/dashboard/index.html
@@ -15,7 +15,7 @@ font-family: Tahoma, Verdana, Arial, sans-serif; }
 <ul>
 <li><a href="https://autobuilder.yoctoproject.org/valkyrie/#/console">CI Main Console (Valkyrie autobuilder)</a></li>
 <li><a href="https://valkyrie.yocto.io/pub/non-release/">Autobuilder results index</a> (build performance, buildhistory, ptest and test result reports)</li>
-<li><a href="https://valkyrie.yocto.io/pub/non-release/abint/">Auobuilder Intermittent Issue Heatmap/Summary</a></li>
+<li><a href="https://valkyrie.yocto.io/pub/non-release/abint/">Autobuilder Intermittent Issue Heatmap/Summary</a></li>
 <li>CVE Status and Patch Metrics: <a href="https://valkyrie.yocto.io/pub/non-release/patchmetrics/">OE-Core</a> <a href="https://valkyrie.yocto.io/pub/non-release/patchmetrics-meta-oe/">Meta-OpenEmbedded</a></li>
 <li>Git Repository Statistics: <a href="https://dashboard.yoctoproject.org/gitstats/poky/">Poky</a> <a href="https://dashboard.yoctoproject.org/gitstats/oecore/">OE-Core</a> <a href="https://dashboard.yoctoproject.org/gitstats/bitbake/">Bitbake</a> <a href="https://dashboard.yoctoproject.org/gitstats/meta-openembedded/">Meta-OE</a></li>
 <li><a href="bugtriage/">Bug Triage</a></li>

