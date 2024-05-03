Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D57C4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 15:47:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.16568.1714751234807383985
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 May 2024 08:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B6FD13D5
	for <yocto-patches@lists.yoctoproject.org>; Fri,  3 May 2024 08:47:39 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1386A3F73F
	for <yocto-patches@lists.yoctoproject.org>; Fri,  3 May 2024 08:47:13 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] config.json: add sbsa-ref builds to meta-arm
Date: Fri,  3 May 2024 15:47:10 +0000
Message-Id: <20240503154710.3995359-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 May 2024 15:47:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/82

This machine replaces qemu-generic-arm64, which was built on the AB until
60825ac6 landed.

Because the sbsa-ref machine boots a disk image inside qemu there is no
way for the static IPs to be passed to the kernel directly, which means
TAP networking fails. Work around this by always running the tests with
slirp networking.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/config.json b/config.json
index fb3b082e..6c9946f1 100644
--- a/config.json
+++ b/config.json
@@ -665,6 +665,27 @@
                 "shortname": "Build for fvp-base",
                 "MACHINE": "fvp-base",
                 "BBTARGETS": "core-image-minimal core-image-sato"
+            },
+            "step2": {
+                "shortname": "Build for sbsa-ref (poky)",
+                "MACHINE": "sbsa-ref",
+                "extravars" : [
+                    "IMAGE_INSTALL:append =3D ' ssh-pregen-hostkeys'",
+                    "TEST_RUNQEMUPARAMS +=3D 'slirp'"
+                ],
+                "BBTARGETS" : "core-image-minimal core-image-sato core-i=
mage-weston",
+                "SANITYTARGETS" : "core-image-minimal:do_testimage core-=
image-sato:do_testimage core-image-weston:do_testimage"
+            },
+            "step3": {
+                "shortname": "Build for sbsa-ref (poky-altcfg)",
+                "DISTRO": "poky-altcfg",
+                "MACHINE": "sbsa-ref",
+                "extravars" : [
+                    "IMAGE_INSTALL:append =3D ' ssh-pregen-hostkeys'",
+                    "TEST_RUNQEMUPARAMS +=3D 'slirp'"
+                ],
+                "BBTARGETS" : "core-image-minimal core-image-sato core-i=
mage-weston",
+                "SANITYTARGETS" : "core-image-minimal:do_testimage core-=
image-sato:do_testimage core-image-weston:do_testimage"
             }
         },
         "meta-agl-core" : {
--=20
2.34.1


