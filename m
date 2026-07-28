Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FBDC53209
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:47 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2423.1785202901355165821
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ywv4jufR;
 spf=pass (domain: gmail.com, ip: 209.85.210.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f236418so2538883b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202901; x=1785807701; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yaMhRIeZDmDZcvUzreSIEIweTn0GounFk13YcooEGGE=;
        b=Ywv4jufRWKcA5/XvYgZVrL/TWvCJfej6gC+bc7LoTZ50pgiOh2xM79fwiS8lizZl+B
         D2FZg1bpkW7Bq+ScVqjdXHC4RS94yi1gH/FutQm9Dw2Pu9/LhPgrloOw8BX8W2ltOn4n
         UHFk0CTdnnKxtkBglYZB8vHYQWuQ8+WyRhBFd7/hqNYFdvYJFLTpn3udriRuHHNIuPkn
         LaxUTByvx6L3MNdmsGmF0Zlv99DMR5Z7OEcLSZoDOSq8OwB/2F75k54I6oKy7eb9pzmp
         ptdQqmJBuDOmXVt6jdIf5TUkL+rH0Acjs4gMcrF0Ihot2a7ieASJTZKcsEcB34sTDaYp
         dVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202901; x=1785807701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yaMhRIeZDmDZcvUzreSIEIweTn0GounFk13YcooEGGE=;
        b=ecyrycf5e5a2tgIoToATfw3xAN/bfxEN+nFCMrz6uyZYaSs/7cYbsn8GUiEh4ZF31V
         J2kgcVTyW/tpSXj3n25jhhCfuhPwGB/h2Rnlo9XaSQkB7H1ToJWf/jjuV1qgeaB7wFgS
         kNcFxtQXTDesiOFxjAIYAVBtEX1IxI4IWkEcwjTmgJiB04XzVTEaOqmbTQS1BR4vqQHr
         TZ+KD2lK9Wtk3gqaja5oShAdquczo1HQq/wPPijmZFNkKZTdztt8X8kfxkOg1kaQkb5G
         FwSsTwcysRtQYewV/iEkoiRrUTkmx06z/UWWEAsEs9LFD+IpS+Pjk7H0oRfPkR2IhF2M
         Uy+g==
X-Gm-Message-State: AOJu0YwRCwlJ02Lstp/pbUnDggLllgLVo3fSIuN6OZg5u4vybuB/uIUz
	d+Zby4rmtYLUwLPWFgGl7MjCDbaccBfG2C78m65TBd5uW9s8haV3yh3Kelb66Q==
X-Gm-Gg: AR+sD103MolNUf5TQu7CqQ8i27UCtwHxggUrg4Jg6CtkS8dPC9Tcjh6e7Ae/G40E3ro
	7/M6Z4FfVuxj9CCgfIRv/SGdatsON1cGm7q6aDEFcxT1bLICEZz1r0ItIRk7xhCL/Q92cv145jJ
	3RUFvUVu4PXgwqANnnwGftgnOpWNG1GPTdTBHruks0fRNi7nZtAsi9MJn2Dc4pgvsQA414xhv/z
	TiGBTaqbYsFbQptgxSmuLsk8MZCzuPES0rxHl7LiKasMWqPcYFaS43AOztuRaT3jbfuRnmw8f/c
	zOJ29GqpZ497ETruQydkUQeJdl48UgRqa4j+uQJm3C9NxYBtW1LFaYAKDKR9kVA+RFC8RmoEaO6
	s4qwKgVDQRWaGUK69BxFVZRtpTr80iI5RB5jrvkxsTgTVa1vw3fSTq0cZBiNInNuD5uLhjj2kyd
	Ca6eQ2LjppFE5o0BAFtPAsIJmoScQslbO4co/Nd9+5tw5VRvzQYcUK+mIG9CqHqQv3FGjMl/jY6
	A==
X-Received: by 2002:a05:6a00:13a3:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84e9330f06fmr320125b3a.76.1785202900684;
        Mon, 27 Jul 2026 18:41:40 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:39 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 10/12] config.json: add -dev container builds to containers-library
Date: Mon, 27 Jul 2026 18:40:43 -0700
Message-ID: <de896ed723f2842b29f14be065a7f032eece59fd.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4549

For some of the containers, we want to provide a -dev version,
denoted by '-dev' appended to the tag(s). This runs the
container as UID '0' root user and adds a shell.

Inspired by dhi.io (Docker Hardened Images).

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/config.json b/config.json
index 00fc498..8c23c2b 100644
--- a/config.json
+++ b/config.json
@@ -1916,37 +1916,78 @@
                 "shortname" : "Build 'base' multiarch container",
                 "BBTARGETS" : "container-image-multiarch-container-base",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-container-base": "base"},
-                "CONTAINER_VERSION_RECIPE" : "base-files"
+                "CONTAINER_VERSION_RECIPE" : "base-files",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
             "step2" : {
                 "shortname" : "Build 'curl' multiarch container",
                 "BBTARGETS" : "container-image-multiarch-app-container-curl",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
-                "CONTAINER_VERSION_RECIPE" : "curl"
+                "CONTAINER_VERSION_RECIPE" : "curl",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
             "step3" : {
+                "shortname" : "Build 'curl' multiarch container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-curl",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
+                "CONTAINER_VERSION_RECIPE" : "curl",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-curl = 'dev'"]
+            },
+            "step4" : {
                 "shortname" : "Build 'python' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-python",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
-                "CONTAINER_VERSION_RECIPE" : "python3"
+                "CONTAINER_VERSION_RECIPE" : "python3",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step4" : {
+            "step5" : {
+                "shortname" : "Build 'python' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-python",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
+                "CONTAINER_VERSION_RECIPE" : "python3",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-python = 'dev'"]
+            },
+            "step6" : {
                 "shortname" : "Build 'mosquitto' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
-                "CONTAINER_VERSION_RECIPE" : "mosquitto"
+                "CONTAINER_VERSION_RECIPE" : "mosquitto",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step5" : {
+            "step7" : {
+                "shortname" : "Build 'mosquitto' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
+                "CONTAINER_VERSION_RECIPE" : "mosquitto",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-mosquitto = 'dev'"]
+            },
+            "step8" : {
                 "shortname" : "Build 'valkey' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-valkey",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
-                "CONTAINER_VERSION_RECIPE" : "valkey"
+                "CONTAINER_VERSION_RECIPE" : "valkey",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step6" : {
+            "step9" : {
+                "shortname" : "Build 'valkey' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-valkey",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
+                "CONTAINER_VERSION_RECIPE" : "valkey",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-valkey = 'dev'"]
+            },
+            "step10" : {
                 "shortname" : "Build 'nginx' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-nginx",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
-                "CONTAINER_VERSION_RECIPE" : "nginx"
+                "CONTAINER_VERSION_RECIPE" : "nginx",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
+            },
+            "step11" : {
+                "shortname" : "Build 'nginx' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-nginx",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
+                "CONTAINER_VERSION_RECIPE" : "nginx",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-nginx = 'dev'"]
             }
         }
     },
-- 
2.55.0


