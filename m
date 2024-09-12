Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228ADEEE253
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 19:49:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.57263.1726170582291317596
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 12:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FDD3152B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 12:50:11 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5ED953F64C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 12:49:41 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/2] config.json: don't build core-image-ptest-all in arch-hw
Date: Thu, 12 Sep 2024 20:49:35 +0100
Message-Id: <20240912194935.1680712-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912194935.1680712-1-ross.burton@arm.com>
References: <20240912194935.1680712-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 19:49:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/652

When the target is real hardware there is no need to build the
core-image-ptest-all image (which expands to ~100 images) as this swamps
the release artifacts and they're not actually tested.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index cfced7a7..e3690ee9 100644
--- a/config.json
+++ b/config.json
@@ -185,7 +185,7 @@
         "arch-hw" : {
             "BUILDINFO" : true,
             "step1" : {
-                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-=
image-minimal core-image-full-cmdline core-image-ptest-all core-image-sat=
o:do_populate_sdk",
+                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-=
image-minimal core-image-full-cmdline core-image-sato:do_populate_sdk",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
             }
         },
--=20
2.34.1


