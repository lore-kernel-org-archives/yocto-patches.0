Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB475C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:24 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161490.1783375638008241500
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:07:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FZ5CDe2Z;
 spf=pass (domain: gmail.com, ip: 209.85.210.177, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84347ad88edso4793317b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375637; x=1783980437; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E2FO7Mm6qMpb9g9o9CU8GObzrUu2x4qgPD5lv75UqCw=;
        b=FZ5CDe2ZFsAvKEs6FSHqwKnQJEnfflorJSYxoKUnL79FJp+BhPCidMpkisocdFh4ur
         375S5CqyVvHGGIIibpjJKWt7NPsK/VnaLvhn/MrHF75KNNAx4EnGoKZuLcdMXVm7XCWz
         ermr2RA+QxHTLxVT/qrkmbsWL+QhncSDT6mhOIh0jTjaKOxAUq6FCCkZaSKJ13u67RN7
         pmR8bdAP9OEA6JqNDGK6xmx90dgwNabwnzEhVxevR2qr/L3qqB/1TJsr2t1PsGTM6yjX
         86yFWtqCaRKrxom9Vv3fpGpcx/6FcA8C6lceaHpu58KCQhsYP6a1kyCs2PyGW5OkPyS4
         OTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375637; x=1783980437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E2FO7Mm6qMpb9g9o9CU8GObzrUu2x4qgPD5lv75UqCw=;
        b=A5k0SFCKppr0aExOrKgPKcMP1oyX5XV6iHIoGMLdXy0qncw/KqFK2EJKVV8fxZwxC6
         s/ArdlZPx5sUyyYQUHla5GfP5uIIk90CbIRfE+E6gjMnIWoXrfj41Lv36x2qS5Avxu9I
         462Z6IyYzpjqlOTNUrhviBNgNuzJ+FfWBslspG3i0st0oNB3qCqi0e/fPTEJFl7tOlcb
         e9KVbn3AtHH0lD8zobg/vpOHwSSKj27dH0up/GV76XI9CxEx3oTmSbrRaAOmNXjNS6j0
         7EQ4W3+K/nmHSzvloef4eGOT/qcXV6zlvkz/8d4dh/NJc+yVsM7EvpVZRH6uP4K5aDBg
         jABA==
X-Gm-Message-State: AOJu0YzJvCGCG76U0HXvgeMNxOxI8MJ9AIlSBShsKzUuuesVA29llzUz
	KSc6Px3W2/cYqGnm+NpwdAaVhiFSUuf6TDkrW/BAuMEXRaveb5CJ3kEs5Hh5uA==
X-Gm-Gg: AfdE7ckl0CaHAFuWEyLA1WRwpMo8cOHThMLp/NEMEepBa1wvpeHBPi9ox4CaMqkaBNc
	edM+GAODexhn/qzB5DSGS3waZ+ph5rV7WHVTc8H7V3PuoL6nsQXqd1S640mLbbyvYT4pTRgDnAf
	yusFr4rO98V/GwU98gaoR91XAozyj9lhBy3utK7rgqd+IwzGr5NNq50ZzQ5pZCM1wyls9QyYP/Q
	Y/lNv02MEIJDW7sBbwYVARn5x7xLBdWQ51cjoj7+7TGdhUpogjy+F4WkTLCAxGZXAt0muzirb08
	wbyCiRbfGkafB4VuLKmn72VxHT4eg48KUmwIXUsLw7JTFNV9MqhzM5x7NJ0kehaevyqF53os63Y
	oVCNHvb+QKEK6HFQD5VzoIdnjtQIh8w7yChB9ls1MZmvj75aO2qsuVfPvNX3MHx4cRQXEP7cBcL
	I8YD37LY5sfYDo88RBhF47obUlvzo0Nn2MBE3wEZh1aS+ZNVG10UxKs+p23o+kWwl6GJJnJ1cz2
	ALjKeS1KVEq
X-Received: by 2002:a05:6a21:3202:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3c08ec76eecmr3000721637.4.1783375637040;
        Mon, 06 Jul 2026 15:07:17 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.07.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:07:14 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 10/11] config.json: add -dev container builds to containers-library
Date: Mon,  6 Jul 2026 15:05:42 -0700
Message-ID: <016a8a8640de4acf06b678e875e1c74577b0af4f.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:07:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4440

For some of the containers, we want to provide a -dev version,
denoted by '-dev' appended to the tag(s). This runs the
container as UID '0' root user and adds a shell.

Inspired by dhi.io (Docker Hardened Images).

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/config.json b/config.json
index a1eee57..118401a 100644
--- a/config.json
+++ b/config.json
@@ -1925,37 +1925,78 @@
                 "shortname" : "Build 'base' multiarch container",
                 "BBTARGETS" : "container-image-multiarch-container-base",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-container-base": "base"},
-                "CONTAINER_VERSION_RECIPE" : "base-files"
+                "CONTAINER_VERSION_RECIPE" : "base-files",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
             "step3" : {
                 "shortname" : "Build 'curl' multiarch container",
                 "BBTARGETS" : "container-image-multiarch-app-container-curl",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
-                "CONTAINER_VERSION_RECIPE" : "curl"
+                "CONTAINER_VERSION_RECIPE" : "curl",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
             "step4" : {
+                "shortname" : "Build 'curl' multiarch container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-curl",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-curl": "curl"},
+                "CONTAINER_VERSION_RECIPE" : "curl",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-curl = 'dev'"]
+            },
+            "step5" : {
                 "shortname" : "Build 'python' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-python",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
-                "CONTAINER_VERSION_RECIPE" : "python3"
+                "CONTAINER_VERSION_RECIPE" : "python3",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step5" : {
+            "step6" : {
+                "shortname" : "Build 'python' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-python",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-python": "python"},
+                "CONTAINER_VERSION_RECIPE" : "python3",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-python = 'dev'"]
+            },
+            "step7" : {
                 "shortname" : "Build 'mosquitto' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
-                "CONTAINER_VERSION_RECIPE" : "mosquitto"
+                "CONTAINER_VERSION_RECIPE" : "mosquitto",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step6" : {
+            "step8" : {
+                "shortname" : "Build 'mosquitto' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-mosquitto",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-mosquitto": "mosquitto"},
+                "CONTAINER_VERSION_RECIPE" : "mosquitto",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-mosquitto = 'dev'"]
+            },
+            "step9" : {
                 "shortname" : "Build 'valkey' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-valkey",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
-                "CONTAINER_VERSION_RECIPE" : "valkey"
+                "CONTAINER_VERSION_RECIPE" : "valkey",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
             },
-            "step7" : {
+            "step10" : {
+                "shortname" : "Build 'valkey' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-valkey",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-valkey": "valkey"},
+                "CONTAINER_VERSION_RECIPE" : "valkey",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-valkey = 'dev'"]
+            },
+            "step11" : {
                 "shortname" : "Build 'nginx' container",
                 "BBTARGETS" : "container-image-multiarch-app-container-nginx",
                 "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
-                "CONTAINER_VERSION_RECIPE" : "nginx"
+                "CONTAINER_VERSION_RECIPE" : "nginx",
+                "extravars" : ["PACKAGE_EXTRA_ARCHS:append = ' container-dummy-provides'"]
+            },
+            "step12" : {
+                "shortname" : "Build 'nginx' container (dev)",
+                "BBTARGETS" : "container-image-multiarch-app-container-nginx",
+                "CONTAINER_IMAGE_MAP" : {"container-image-multiarch-app-container-nginx": "nginx"},
+                "CONTAINER_VERSION_RECIPE" : "nginx",
+                "extravars" : ["PACKAGECONFIG:pn-app-container-nginx = 'dev'"]
             }
         }
     },
-- 
2.54.0


