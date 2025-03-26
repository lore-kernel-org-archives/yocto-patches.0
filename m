Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EFC3600B
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 16:32:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.27162.1743006756870059912
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 09:32:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 023141424
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 09:32:42 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 148E63F694
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 09:32:35 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] config.json: add build definition for musl-qemuarm64
Date: Wed, 26 Mar 2025 16:32:29 +0000
Message-ID: <20250326163229.869295-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 16:32:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1257

This is identical to the musl-qemux86 builds, but for qemuarm64.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/config.json b/config.json
index 7efc476e..3a81f3b4 100644
--- a/config.json
+++ b/config.json
@@ -1207,6 +1207,14 @@
                 ]
             }
         },
+        "musl-qemuarm64" : {
+            "MACHINE" : "qemuarm64",
+            "BBTARGETS" : "core-image-minimal core-image-full-cmdline co=
re-image-sato-sdk world",
+            "SANITYTARGETS" : "core-image-minimal:do_testimage core-imag=
e-full-cmdline:do_testimage core-image-sato-sdk:do_testimage",
+            "extravars" : [
+                "TCLIBC =3D 'musl'"
+            ]
+        },
         "musl-qemux86" : {
             "MACHINE" : "qemux86",
             "BBTARGETS" : "core-image-minimal core-image-full-cmdline co=
re-image-sato-sdk world",
--=20
2.43.0


