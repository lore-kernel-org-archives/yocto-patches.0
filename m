Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129FEEE250
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 19:49:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.57142.1726170582006559076
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 12:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE7F13D5
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 12:50:10 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7E483F64C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 12:49:40 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/2] config.json: unify image list by adding full-cmdline to arch-hw
Date: Thu, 12 Sep 2024 20:49:34 +0100
Message-Id: <20240912194935.1680712-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 19:49:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/651

The poky-altcfg builds all build core-image-full-cmdline but the poky
builds do not. This causes confusion when someone is after a fully
featured but headless image and there are none available for poky, just
-minimal or -sato.

Also add core-image-full-cmdline:do_testimage to arch-hw-qemu.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.json b/config.json
index 0a83f8d8..cfced7a7 100644
--- a/config.json
+++ b/config.json
@@ -185,15 +185,15 @@
         "arch-hw" : {
             "BUILDINFO" : true,
             "step1" : {
-                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-=
image-minimal core-image-ptest-all core-image-sato:do_populate_sdk",
+                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-=
image-minimal core-image-full-cmdline core-image-ptest-all core-image-sat=
o:do_populate_sdk",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
             }
         },
         "arch-hw-qemu" : {
             "BUILDINFO" : true,
             "step1" : {
-                "BBTARGETS" : "core-image-minimal core-image-sato core-i=
mage-sato-sdk core-image-sato:do_populate_sdk core-image-sato:do_populate=
_sdk_ext",
-                "SANITYTARGETS" : "core-image-minimal:do_testimage core-=
image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:=
do_testsdk core-image-sato:do_testsdkext"
+                "BBTARGETS" : "core-image-minimal core-image-full-cmdlin=
e core-image-sato core-image-sato-sdk core-image-sato:do_populate_sdk cor=
e-image-sato:do_populate_sdk_ext",
+                "SANITYTARGETS" : "core-image-minimal:do_testimage core-=
image-full-cmdline:do_testimage core-image-sato:do_testimage core-image-s=
ato-sdk:do_testimage core-image-sato:do_testsdk core-image-sato:do_testsd=
kext"
             },
             "step2" : {
                 "shortname" : "Machine oe-selftest",
--=20
2.34.1


