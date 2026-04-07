Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D2DEDB7E7
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 09:57:53 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77692.1775555869309059317
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 02:57:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dr33hy7m;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 798C14E4293B;
	Tue,  7 Apr 2026 09:57:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50B8C603C7;
	Tue,  7 Apr 2026 09:57:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4710810450229;
	Tue,  7 Apr 2026 11:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775555866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sS3mSTX4nLz4H1h12Z+R4ieCDiNL2Urnb+UDBLYSwCw=;
	b=dr33hy7ml0+60+9SUiRfcBBg7WZTHlpOtYSL1Hfw7qSvvuHI7bkJVsOOEVvJZ3Ngy3eoK8
	1cZiVyrlz6iPK5bxgS8IIst70eyafy3Z0M7lLOjNM7BOq12Rsv5FVQXgYGxmvtJ6nueOLh
	JJHkul2Vda+6nStajRAu0gvPVAh0h+kph72RP9lwZlWgJlNXBTqGSKGuEvk09scfk6o8uQ
	v8EGTWEhOEos1fOGWuM3V56aHqdQ8WI/8Ixjpr5TfBN59jIYrwvvGnidV+n+Xmc6B+9j2H
	5Ja+q2szAbA0D4iRcAUb9nLF2NuRyXK3T+dE55mBg3I3VOv4HyvQaFRhTD7JSQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Apr 2026 11:57:29 +0200
Subject: [PATCH yocto-autobuilder-helper v3] config: Fix wic builder after
 wic removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-contrib-mathieu-wic-builder-v3-1-100c1e736c56@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAnV1GkC/43OwQqCQBDG8VeJPTfhuilup94jOug45YA6srtaI
 r57ixDUJTp+8Oc3syhPjsmr025Rjib2LH0cZr9T2JT9nYDruFWapHlikgxQ+uC4gq4MDdMID0a
 oRm5rcmAsWtQWY5upKAyObvzc9IuaBYNAOQZ55w21Azl1jWXDPoibtzcmvfV/XZw0aMiKIsckx
 9oU5bkSCS33B5Ruk6f0U8t/a2nUyBrSVmeFPdK3tq7rCx9zV6wwAQAA
X-Change-ID: 20260305-contrib-mathieu-wic-builder-39c9c19c0265
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Trevor Woerner <twoerner@gmail.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775555865; l=7532;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=1lGwHxdAcwZKoraLprzVx8Q/xYs5p4S57vpD4XhXzbU=;
 b=6omFEW7az4mxQgkq+75MRMvzDZC4isl+Z6eWxhr5rbvDk2gZdsj0K7ECe+w/c80m4T4UW9B1F
 QFF9KYNveDCCF61/ehq8IuuCUC/VNQeNwvFoqKd16pvBGW0I7OxyNzn
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 09:57:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3651

Wic tool is now stored in an external git, so we can no longer rely on
it being provided by openembedded-core scripts directory. Use the
version provided by the wic recipe instead.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v3:
- updating --vars parameter, as it now has to be a folder.
- Link to v2: https://lore.kernel.org/r/20260306-contrib-mathieu-wic-builder-v2-1-e93e1915894e@bootlin.com

Changes in v2:
- Fixing append syntax.
- Link to v1: https://lore.kernel.org/r/20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com
---
 config.json | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/config.json b/config.json
index 5e5071e6f964..192ee7d850c8 100644
--- a/config.json
+++ b/config.json
@@ -1030,41 +1030,53 @@
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
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86/"
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
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86/"
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
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/qemux86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/qemux86-64/"
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
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/"
                 ]
             }
         },

---
base-commit: 4304a9d29045086b204f7a6274faf2c8ea91b82c
change-id: 20260305-contrib-mathieu-wic-builder-39c9c19c0265

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


