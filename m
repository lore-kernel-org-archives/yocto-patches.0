Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB8AC43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 14:53:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.754.1783695212035555340
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jul 2026 07:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fvw9iygZ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5C59B4E40D41
	for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:53:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F13F60342
	for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:53:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C5A711BD15D9;
	Fri, 10 Jul 2026 16:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783695209; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Pjsl+l82gKqU0OKt5qogtGE6fdPF/cu4CNvVQOc78Jg=;
	b=fvw9iygZXHlHOVfWwnV907zsflc+DSkkn7wv0JoUMth/O+3ANqZe0deHxzKTHUB8W6iVof
	epd67R+jatWIwi176ArQiyek1YCDJJA255uSnr5OAngVfsJlNHSjkeaN1lhoH6NmXxXADD
	ATYjmwSzi/WuBD8IVjNIKUEytbBoVxnUiRL8ceHL1xqna49gsYamRc2tjZye3ZMaDW6YSE
	w57J5KX5UJwFV8GN274WO9vJ4tOstxYfZKMbnTfGBUBA/s46CwQFMfDNnDtmYjNRyUGp1T
	m61mHKkJCEIkQr9aAG57WhMsvJAjoEnCcYJtyGcEmNqDuXrDnvubOrLHw/EI3Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 10 Jul 2026 16:53:25 +0200
Subject: [PATCH yocto-autobuilder-helper wrynose v2] config.json: Add
 meta-qcom dependency on mixin-wrynose-linux-firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-contrib-mathieu-wrynose-qcom-lts-mixin-v2-1-6e44ffb83f1d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGQHUWoC/5WOQQ6CMBBFr0Jm7RioUtGV9zAuaBlkEuhoW1BCu
 LsN8QIuX/Lf/3+BQJ4pwCVbwNPEgcUlULsMbFe7ByE3iUHlSudaHdCKi54NDnXsmEZ8+9lJIHx
 ZGbCPAQf+sEOlj1VdtiZvVAup7Omp5c82dINZbBSsxyhm5L4hjx31T/LZrwzuyeg4RPHz9mwqN
 u/fE1OBBZ6qoy7pbMiW+mpEYs9un3JwX9f1C19m/PEAAQAA
X-Change-ID: 20260623-contrib-mathieu-wrynose-qcom-lts-mixin-2648a5fb0d2f
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783695209; l=2512;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2iODBCh/Sm2hrLM/fAP2zGcv5t+92Y3N9Q2lTq+1mDo=;
 b=vbPoLnzcrut/pDBrNEUUezGA6WJGzFfGJUq3pgNCbKFYOGBJJwn1JpznAYmNq8jdZTLbcFVs3
 8FwMpx61dCwAX8YQKm9cymory7o2Ir3QQjpuSf71i0Fjj6a6U9WdvTG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:53:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4468

meta-qcom depends on wrynose/linux-firmware branch of meta-lts-mixin

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Fix meta-lts-mixin folder name
- Link to v1: https://lore.kernel.org/r/20260623-contrib-mathieu-wrynose-qcom-lts-mixin-v1-1-78465e9bec56@bootlin.com
---
 config.json | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 6b37eb96254f..194b360dfa63 100644
--- a/config.json
+++ b/config.json
@@ -1313,7 +1313,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1356,7 +1356,7 @@
             },
             "step10" : {
                 "shortname" : "Test meta-qcom YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --no-auto-dependency"]
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --dependency ../mixin-wrynose-linux-firmware --no-auto-dependency"]
             },
             "step11" : {
                 "shortname" : "Test meta-riscv YP Compatibility",
@@ -1996,6 +1996,12 @@
             "branch" : "master",
             "revision" : "HEAD",
             "no-layer-add" : true
+        },
+        "mixin-wrynose-linux-firmware" : {
+            "url" : "ssh://git@push.yoctoproject.org/meta-lts-mixins",
+            "branch" : "wrynose/linux-firmware",
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


