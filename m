Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9445F8809B
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:55 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7878.1776323268500674732
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3fvEyU9v;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d734223e4so183702f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323266; x=1776928066; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UqfbjoxtYG80j15KLRMKWbnsuKXj6RQYZdmLFsAqYs=;
        b=3fvEyU9vyVu6yV4qDrD2l6hptWFstSuGSB6LH6hhGjNQayjwruomRzUr6NDjRDS9Pd
         huHCwz/KVKJred+IkQp+z/ZcL+Hf9P4KA+YXL9LCwF7cci0l+3H8URwJS+mugH3mULe/
         Aaq7U1ay7WFO8sHhvNBRVZ+LDfRjyoI6Qh3aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323266; x=1776928066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7UqfbjoxtYG80j15KLRMKWbnsuKXj6RQYZdmLFsAqYs=;
        b=H9KPUfk467xyo+0pFz9ML7JRz+5y6PUU5gXmaqLq+zFEsLSRgniqzszs48ZhVyfbeB
         yCbk5FkazAjQzpdJygF+ANt75lemu7PE4paH2L9FROSXcZW77YePky2zfDmmbVrMsFEo
         fYp50mGjCRn/ebRqdKeS8WsvTsg0v4Cb/sOedh0VX20t+Jh26Gig11yoOT0bTa+4EqYs
         JQbCjTeAAr/1vSiXj5K6H6sBAoqAepFVBR0u0i7Vg6HzZS6XypbklrF5b/+cH/TPqOuO
         UoJj3pYWLjvTriy75yosqZI6DmY0BWsOE+1g4sKYPWWt0NU6FRxdZMhy6vq0lCwhvrzi
         Vn6g==
X-Gm-Message-State: AOJu0Yw+a+2kkgGvVs4lKZbpBNvziVhnSDnMk7wpJoD0P4kvr6s1AMDr
	rQM9VJE1Ohnz66HIi/N1iNzzRApvLlenvzhTLLQkGBakp5zwATCgzRHzZYfRtE7QIMlIboRxoaz
	qXWbibSuA7g==
X-Gm-Gg: AeBDiesTSl73JRaDyVlWoV2fj7eW6/O6lTMg6EP/1T22g4rIBPnByzvRbnAuhrakbAy
	jtZK0ud/ieQ8L8folGZaReI7+Y3mKeONZ52m/xg7dXF1/KBXos+bfAYA/H951illC1VkoosFx9X
	Mwfj4sJpgtbsY+w7eyVVRFMtV9U88CoTLNlh/DGqNY47IRFg4DImzI6RTVuOHunX3uQyYBD4wP4
	zuC5IZg1KKJBpShW1z8sm/PyN/ifsr3NqMi7XjxYtrq6iGp9d9ily9uHgPYEspdvgmx1y4QAGgK
	ihTH0mF+YYT+Xp2D7kvqu70aJc5DUdoImM5TCgucoouturmNgco/JsYbZI8kp4QKdbhiFtZK+5i
	jYyPwmm1xs6WY0JiOTE+0Uug7h4f/GkxA15inMiaVXSXDKmz4672DyrvZpC96azkUCO0Cg8KbQ1
	JGvYoGvHuQS1ltDjotR/zArty+cXPMg1ia6jJ8HkpYIm2jUtfNze9iNoKnbQkKDqAco8GP3b3O/
	MeOPeyogHQta4LbErPu/uyb28ieGxW7D3umng==
X-Received: by 2002:a05:6000:4808:b0:43d:384a:9e96 with SMTP id ffacd0b85a97d-43eb107fc77mr3049133f8f.4.1776323266523;
        Thu, 16 Apr 2026 00:07:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 3/5] config.json: Fix bring up after bitbake-setup changes
Date: Thu, 16 Apr 2026 09:07:38 +0200
Message-ID: <c85e80d38c11065b9695054b978d192279605256.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3719

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have to leave MACHINE/DISTRO unset via fragments for oe-selftest, tweak the bringup
target setup to handle this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fbb31b12e73053727a0f8e34252661aff9e8398f)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/config.json b/config.json
index 9cb8693..6000254 100644
--- a/config.json
+++ b/config.json
@@ -192,36 +192,51 @@
        "bringup" : {
             "BUILDINFO" : true,
             "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
-            "MACHINE" : "qemuarm64",
-             "step1" : {
-                 "SDKMACHINE" : "x86_64",
-                 "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext core-image-sato:do_populate_sdk_ext",
-                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
-             },
+            "MACHINE" : "unset",
+            "DISTRO" : "unset",
+            "step1" : {
+                "SDKMACHINE" : "x86_64",
+                "extravars" : [
+                    "MACHINE = 'qemuarm64'",
+                    "DISTRO = 'poky'"
+                ],
+                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext core-image-sato:do_populate_sdk_ext",
+                "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
+            },
             "step2" : {
                 "SDKMACHINE" : "x86_64",
-                "MACHINE" : "qemux86-64",
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'",
+                    "DISTRO = 'poky'"
+                ],
                 "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-ptest-all core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
 
             },
             "step3" : {
                  "SDKMACHINE" : "i686",
+                 "extravars" : [
+                    "MACHINE = 'qemuarm64'",
+                    "DISTRO = 'poky'"
+                 ],
                  "BBTARGETS" : "core-image-sato:do_populate_sdk",
                  "SANITYTARGETS" : "core-image-sato:do_testsdk"
-             },
+            },
             "step4" : {
-                "MACHINE" : "qemux86-64",
                 "SDKMACHINE" : "i686",
+                 "extravars" : [
+                    "MACHINE = 'qemux86-64'",
+                    "DISTRO = 'poky'"
+                 ],
                 "BBTARGETS" : "core-image-sato:do_populate_sdk",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
             },
             "step5" : {
                 "BUILDINFO" : false,
-                "MACHINE" : "qemux86-64",
                 "SDKMACHINE" : "x86_64",
                 "PACKAGE_CLASSES" : "package_rpm",
                 "extravars" : [
+                    "MACHINE = 'qemux86-64'",
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
                 "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],

