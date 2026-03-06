Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B74F0182F
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 11:51:47 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67649.1772797901478278978
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 03:51:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nAQ6Bl51;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF8F14E4258C;
	Fri,  6 Mar 2026 11:51:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 968BD5FF92;
	Fri,  6 Mar 2026 11:51:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACF191036996A;
	Fri,  6 Mar 2026 12:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772797899; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=V77v8e0LaqlGtjd4kuuJt7U/iUr50fFfZTAiAac5pxY=;
	b=nAQ6Bl51jdnMPCeniy0ZROU2/qU2z8T5mblwhL0RtF/AuEm3WDGyRpPhxVR2M8My8/W9u/
	AIPOvl6rRcUWiAQuHs2UpWJQ1puXrFt0Ajf9XZHYhoanfDd9pfvOfy7/JqAVa1cfRQ+LPO
	Gc7pV64fiM4zCT1gkKkXU7f52tqJ6KEI5IaKjfNtCMdPZihtK4Ffi4uYo8hhvB9Ye42gKj
	5q3FU6Vf153GfUMJP8HVgWO44W6X30l6qS8Vb+pR9z8r09QBlsvAe9p3TdhbKSArjqTPLI
	OC7kmAKWjezCrEiJmP1QICV8EPptojQSi2eIQereaK6f4i0NbJQgwh5+/rWiyg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 06 Mar 2026 12:51:14 +0100
Subject: [PATCH yocto-autobuilder-helper v2] config: Fix wic builder after
 wic removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-contrib-mathieu-wic-builder-v2-1-e93e1915894e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALG/qmkC/42OQQqDQAxFryJZN2VUFO2q9yguNKadgBqZGW1Fv
 HsHofsuHzze/zt4dsIebskOjlfxolOE7JIA2XZ6MUofGTKTlSY3BZJOwUmHYxus8IJvIewWGXp
 2mNdUU1pTdAuIhdnxUz5n/QGbUlBsl6A/3fIws4MmmlZ8ULedN9b09P9aXFNMsaiqkkxJfV619
 041DDJdSUdojuP4Ar7dN0HiAAAA
X-Change-ID: 20260305-contrib-mathieu-wic-builder-39c9c19c0265
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Trevor Woerner <twoerner@gmail.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772797898; l=7670;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=hPjLekc6ZbJmFmwNrRtuIW5ywh4rEHCNxCHTrvq9B54=;
 b=exId63eMoJZBz+9HyyunHn3JpOHZX4pkQCmuEtuZ4dsZvuXE3g3zU5Nk/8xx0qclFQAuI0oHn
 kW8d5/rMAKHAX5wevPNC5XiAwxz2iGSHtrf3zbEWAuao6dD0aG1pb7u
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 11:51:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3346

Wic tool is now stored in an external git, so we can no longer rely on
it being provided by openembedded-core scripts directory. Use the
version provided by the wic recipe instead.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com
---
 config.json | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/config.json b/config.json
index c7c92c3a2b0e..88d47c614d9b 100644
--- a/config.json
+++ b/config.json
@@ -1014,41 +1014,53 @@
             "step1" : {
                 "MACHINE" : "qemux86",
                 "shortname" : "qemux86 wic",
-                "BBTARGETS" : "wic-tools core-image-sato",
+                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "extravars" : [
+                     "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
+                ],
                 "EXTRACMDS" : [
-                    "wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/",
-                    "wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/",
-                    "wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/"
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/core-image-sato.env",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/core-image-sato.env",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/core-image-sato.env"
                 ]
             },
             "step2" : {
                 "MACHINE" : "genericx86",
                 "shortname" : "genericx86 wic",
-                "BBTARGETS" : "wic-tools core-image-sato",
+                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "extravars" : [
+                     "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
+                ],
                 "EXTRACMDS" : [
-                    "wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/",
-                    "wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/",
-                    "wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/"
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/core-image-sato.env",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/core-image-sato.env",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/core-image-sato.env"
                 ]
             },
             "step3" : {
                 "MACHINE" : "qemux86-64",
                 "shortname" : "qemux86-64 wic",
-                "BBTARGETS" : "wic-tools core-image-sato",
+                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "extravars" : [
+                     "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
+                ],
                 "EXTRACMDS" : [
-                    "wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/",
-                    "wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/",
-                    "wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/"
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/core-image-sato.env",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/core-image-sato.env",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/core-image-sato.env"
                 ]
             },
             "step4" : {
                 "MACHINE" : "genericx86-64",
                 "shortname" : "genericx86-64 wic",
-                "BBTARGETS" : "wic-tools core-image-sato",
+                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "extravars" : [
+                     "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
+                ],
                 "EXTRACMDS" : [
-                    "wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/",
-                    "wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/",
-                    "wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/"
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/core-image-sato.env",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/core-image-sato.env",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/core-image-sato.env"
                 ]
             }
         },

---
base-commit: b880494dfbe888193a9d39dc7694a29c03b4e5ec
change-id: 20260305-contrib-mathieu-wic-builder-39c9c19c0265

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


