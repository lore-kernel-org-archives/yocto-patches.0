Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C756F30951
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 11:55:13 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42458.1772711709995647335
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 03:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=z3W2TLnk;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C978C4E42561
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Mar 2026 11:55:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F3335FDEB;
	Thu,  5 Mar 2026 11:55:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94A291036988C;
	Thu,  5 Mar 2026 12:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772711707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=p0Kpea7iHV3bCo+ALCCOMdaDDuCJt4xcyu6rHHmjvHk=;
	b=z3W2TLnkkv4N5TOSc3fWJi0qs71oencsHNeqiK8snp7k/Bnic2BN3CW2M6VySFaCSF1qlm
	6/nYyGoqV2htPU0Qns/ifOoO7q9UBKct7IEsQdSqKYmOoUT2cNjk2ZIrOJM7scwDw/lWCD
	UWNGBLDledxSihPGinS+s4AQG6bOCuprQTbwH5OdfrAUamF0R2ti1XvKmSA664MFAaEebH
	RRz1ccVFLVR/iqhq/1DzI9S5V4o8ITy4Po32DATuxRaB8TxFhmek+XL5lOv5UrEW7csBa0
	cYjlawmMrHmXt3sExo8SFXPiWxh/Fs4l7fyO0A2Fliq7trsQp1WWm+63Nfh9+w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 05 Mar 2026 12:54:53 +0100
Subject: [PATCH yocto-autobuilder-helper] config: Fix wic builder after wic
 removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAxvqWkC/zXMQQqDMBBA0avIrDsQFQvpVUoXcZw2AzaRSWIr4
 t0NhS4/PP4OiVU4wa3ZQXmVJDHUaC8NkHfhxShTbehMdzW9GZBiyCojvl32wgU/QjgWmSdW7C1
 Zai1VO0A9LMpP+f7ud9gi5Yiu5PjnnueFFR7HcQLdCmJohwAAAA==
X-Change-ID: 20260305-contrib-mathieu-wic-builder-39c9c19c0265
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Trevor Woerner <twoerner@gmail.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772711705; l=7404;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=jsWrR1xOGz6vSQGR2ior4vpQJUm/TDcDg1EjOpuuDuw=;
 b=n0wux4zjT2J4lYC8mvEUZ93eKUkhDqkHJ/RWj6rmQui0ai7M0QHsdsNO9CQod57lNLdEiKlfM
 UkFvTwymjfTBY8Zd/SbuD7tjs40USCOOvFxiCCla9byN6yQGeRGHdzN
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 11:55:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3335

Wic tool is now stored in an external git, so we can no longer rely on
it being provided by openembedded-core scripts directory. Use the
version provided by the wic recipe instead.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/config.json b/config.json
index c7c92c3a2b0e..ad80c69c6600 100644
--- a/config.json
+++ b/config.json
@@ -1014,41 +1014,53 @@
             "step1" : {
                 "MACHINE" : "qemux86",
                 "shortname" : "qemux86 wic",
-                "BBTARGETS" : "wic-tools core-image-sato",
+                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "extravars" : [
+                     "DEPENDS:pn-core-image-sato += 'parted-native cross-localedef-native'"
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
+                     "DEPENDS:pn-core-image-sato += 'parted-native cross-localedef-native'"
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
+                     "DEPENDS:pn-core-image-sato += 'parted-native cross-localedef-native'"
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
+                     "DEPENDS:pn-core-image-sato += 'parted-native cross-localedef-native'"
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


