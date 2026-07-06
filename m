Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4558C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:04 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161486.1783375624496164691
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:07:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RlQqWsOl;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842338c18e0so2875126b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375624; x=1783980424; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlTnvgs3WdajwKoonrkpzvKzJdjCAXsH32XvPJJn5xI=;
        b=RlQqWsOlnKsYIhhQ+zowlXBMXMh5w9iydq40lME8pmhJSWLfGZoPdGHNDo0ONybxe4
         pRIljhGGi1oBXUeHQxIcbSuwrqKSX8snRKsnyjhFW3jCGqsqsctxKmZ40dq7y66O6qp/
         +UskIQyDbIWtSLyILx8rr1KB7WROSlUrbd5n+CeusH7hF8Lrv6hMuT6o+BdC2VWF9ii6
         LIrGzEyIkmmW2ozY5u+onwHzN/t3dRUIjgmmSz2wPbD7dsGf2mlZzzYQbhO4qBKynMrm
         Zy0V60e6SClCK4tCzCAttL2id+7f9HAUBaJAKJMmJluduuIFX2cnGedx7zcl/45pyQF1
         Frxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375624; x=1783980424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vlTnvgs3WdajwKoonrkpzvKzJdjCAXsH32XvPJJn5xI=;
        b=iRrTNeSCkHi2PPcIGnfyimQHQORnJC11OXaiEC+cfRukvTX3gK0Ov4S806yhWNEhNh
         Q9nfKSf/MNBrwI74dS1D9ExieQL+IthiwG+OuTW9sIM0hSi4zgE+v1pDqu1VzRglNjFB
         T1PssHokuXIMGvoyWH1FNvDumUgwfTuSMRZPx8QUmRBtfqRAytW8g6oXdS8A35wZWKft
         sc31tLrZzCoUn6URbWRbVlIGzS6UNIp2iazoHL83uSZQI1o9WSgpC0z9EHyiS87xbBq/
         tN8/yAQNBO4c78/eDqXyv2IwCtDb+o7vWkWk6b+Ve1g5QtLagJijDFOKXSxdKYpsu+8n
         v2AQ==
X-Gm-Message-State: AOJu0Yxo/NbZMVx0HX2LWEKpmnYXKILpsJsQjWELHpnmDDmgekmhOZZ2
	dmI7dxi/gl+o8HbXbqR+gz+Bo0yydCkqsuuZbIhMXEsFM9czUHt2GOB9ERI6VQ==
X-Gm-Gg: AfdE7cnAHoYPpzcNoWuhu09lrQFzu2/ii1uT1tq+EE7Gd3iB/q8RXw7sKi3GBpibVZw
	IoZyUpUUlrMZ0/YZNNyECA4PiBLX0b6mDd5r0bh5Ycu9kGNd+lXL2MynScHWHHvaUPwK8yUMkaR
	oAyugH9saOVvOb/lrUx17fs1qFnY0704t20WpJ1c7a1q/JjZsbtrJCRGGIWg95JqOhlSOEDh9vq
	+ro+0M9TLHWMDB/+9KHuEm6Y5rxRKXsNi81XQevdUXTcS3UG/SigN6VBeBGfsSs/RjtEiAuQcAQ
	plgVNpKx1YPr0Ee0s1bPnJUh8+TRaimt3Q9xs9ViZcGkLsAq1cd1v+jfjfK8Eduo0zdym7vE4hK
	NpvlBgFPQYJyaHf/mN93w38IoxaIOGR/3bDT0lmEJlMIvNCrO/s0vnG0JKFS2dut+F1VxPGCi7Z
	YogBnwyjZmq3YutAJUo5OKsKFKfQLBtQCGRagB6xMl4wijxOcxcTtspSscehmYJI3iouBufZsWX
	+R9dhUGDz+A
X-Received: by 2002:a05:6a00:399f:b0:845:d286:1fa5 with SMTP id d2e1a72fcca58-84826f0e4e9mr2409813b3a.52.1783375623772;
        Mon, 06 Jul 2026 15:07:03 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.07.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:07:01 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 07/11] containers-library: switch to multiarch; add alpine single-arch
Date: Mon,  6 Jul 2026 15:05:39 -0700
Message-ID: <7725c52b1c0031a1578f5c3c2ba7bc72665b5c30.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:07:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4437

Utilize the oci-multiarch detection in run-push-containers script,
which uses 'skopeo-native copy' to 'push' the oci/ directory to the
container registries.

Add app-container-alpine as a single-arch container which demonstrates
alpine-oci-base and ensures we are exercising the single-arch path
in run-push-containers.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/config.json b/config.json
index adabd57..878cca0 100644
--- a/config.json
+++ b/config.json
@@ -1915,39 +1915,45 @@
                 "_EXTRA_TAGS=\"$_PV_MAJOR $_PV_MAJOR_MINOR\""
             ],
             "step1" : {
-                "shortname" : "Build 'base' container",
-                "BBTARGETS" : "container-base",
-                "CONTAINER_IMAGE_MAP" : {"container-base": "base"},
-                "CONTAINER_VERSION_RECIPE" : "base-files"
+               "shortname" : "Build 'alpine' single-arch container",
+               "BBTARGETS" : "app-container-alpine",
+               "CONTAINER_IMAGE_MAP" : {"app-container-alpine": "alpine"},
+               "CONTAINER_VERSION_RECIPE" : "alpine-oci-base"
             },
             "step2" : {
-                "shortname" : "Build 'curl' container",
-                "BBTARGETS" : "app-container-curl",
-                "CONTAINER_IMAGE_MAP" : {"app-container-curl": "curl"},
-                "CONTAINER_VERSION_RECIPE" : "curl"
+                "shortname" : "Build 'base' multiarch container",
+                "BBTARGETS" : "container-image-multiarch-container-base",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-container-base": "base"},
+                "CONTAINER_VERSION_RECIPE" : "base-files"
             },
             "step3" : {
+                "shortname" : "Build 'curl' multiarch container",
+                "BBTARGETS" : "container-image-multiarch-app-container-curl",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
+                "CONTAINER_VERSION_RECIPE" : "curl"
+            },
+            "step4" : {
                 "shortname" : "Build 'python' container",
-                "BBTARGETS" : "app-container-python",
-                "CONTAINER_IMAGE_MAP" : {"app-container-python": "python"},
+                "BBTARGETS" : "container-image-multiarch-app-container-python",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
                 "CONTAINER_VERSION_RECIPE" : "python3"
             },
-            "step4" : {
+            "step5" : {
                 "shortname" : "Build 'mosquitto' container",
-                "BBTARGETS" : "app-container-mosquitto",
-                "CONTAINER_IMAGE_MAP" : {"app-container-mosquitto": "mosquitto"},
+                "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
                 "CONTAINER_VERSION_RECIPE" : "mosquitto"
             },
-            "step5" : {
+            "step6" : {
                 "shortname" : "Build 'valkey' container",
-                "BBTARGETS" : "app-container-valkey",
-                "CONTAINER_IMAGE_MAP" : {"app-container-valkey": "valkey"},
+                "BBTARGETS" : "container-image-multiarch-app-container-valkey",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
                 "CONTAINER_VERSION_RECIPE" : "valkey"
             },
-            "step6" : {
+            "step7" : {
                 "shortname" : "Build 'nginx' container",
-                "BBTARGETS" : "app-container-nginx",
-                "CONTAINER_IMAGE_MAP" : {"app-container-nginx": "nginx"},
+                "BBTARGETS" : "container-image-multiarch-app-container-nginx",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
                 "CONTAINER_VERSION_RECIPE" : "nginx"
             }
         }
-- 
2.54.0


