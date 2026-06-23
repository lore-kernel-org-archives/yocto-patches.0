Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F8CDB479
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 14:47:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22708.1782226010682276742
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 07:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GnWqTh6G;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F32344E40773
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:46:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2AA4601C2
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:46:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3430106C853A;
	Tue, 23 Jun 2026 16:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782226008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lFA31uSLXWsi9JK8dCjCF7+IvhKrj/AHrXMo0fiV4BY=;
	b=GnWqTh6GlqaAcY9QVuRqeehf0VprIa0z9Plk9Qlh9m+I2gpdvsARaZOBJ38QWRB23R7m5U
	yYGuCcVXtpfvoZnF3CuBhWmfcDo/O6jHChYhLBqBpNNSQkQk29xQQ+RfF1fCQgagAUhG/4
	W1GYU5rGDXrPuNi1RwOPuT9SABz8qOfDEU3HJV+DUtjO2pfUqT4vXPJKegTJuEiC4jI0EX
	PUMFneoeU+4kMt/cjyqeOWrba/07fw+DV8Sh9dUJJk3694jl4uqHqPQcG6A6bcsFX64xkW
	dausREXGqGWkZt3Wp3tRK9aZds7COJC+jQxFlBmZT0LIJVEKuqKfyCvJDff9pQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 23 Jun 2026 16:46:45 +0200
Subject: [PATCH yocto-autobuilder-helper wrynose] config.json: Add
 meta-qcom dependency on meta-lts-mixin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-contrib-mathieu-wrynose-qcom-lts-mixin-v1-1-78465e9bec56@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFWcOmoC/y3NQQrCMBBA0auUWTtQowbxKuIiTad2IM3USaItp
 Xc3iMu/eX+DRMqU4NZsoPTmxBJrHA8N+NHFJyH3tcG0xrbWnNBLzModTi6PTAU/ukZJhC8vE4a
 ccOKFIxp7vrrL0LW9GaBis9LAy290h1V8FnQlS1c49KQ4UphJmz8Gj33/AgdbH3OaAAAA
X-Change-ID: 20260623-contrib-mathieu-wrynose-qcom-lts-mixin-2648a5fb0d2f
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782226007; l=2209;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=J/lmcYOC83EMOWs1Pgfu/XayPX3DV+cD5mAJNOYyqQw=;
 b=nOV/ZzHJI83vbV+mUBQQt2c2bYXffs4gVEbjZ+xAswpwLdsIOT9TnPioRXVwGZ3GzDPamuJlH
 CfCYfuEaSuhBMd5qz2lQFUZgVlaPsolnm4AjIsUiThSdNnlXrhUpL/I
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:47:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4284

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 6b37eb96254f..c18c7de80f91 100644
--- a/config.json
+++ b/config.json
@@ -1313,7 +1313,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "meta-lts-mixin"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1356,7 +1356,7 @@
             },
             "step10" : {
                 "shortname" : "Test meta-qcom YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --no-auto-dependency"]
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --dependency ../meta-lts-mixins --no-auto-dependency"]
             },
             "step11" : {
                 "shortname" : "Test meta-riscv YP Compatibility",
@@ -1996,6 +1996,12 @@
             "branch" : "master",
             "revision" : "HEAD",
             "no-layer-add" : true
+        },
+        "meta-lts-mixin" : {
+            "url" : "ssh://git@push.yoctoproject.org/meta-lts-mixins",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
         }
     },
     "buildtools" : {

---
base-commit: 418241c48f0206522e46fbb91aefce2331c72949
change-id: 20260623-contrib-mathieu-wrynose-qcom-lts-mixin-2648a5fb0d2f

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


