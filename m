Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F965C83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 14:50:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.14576.1753368634805330765
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 07:50:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B84D1176C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:50:27 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A17FC3F66E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:50:33 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper][styhead] config.json: Use buildtools tarball for rocky8
Date: Thu, 24 Jul 2025 15:50:27 +0100
Message-ID: <20250724145027.783899-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 14:50:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1869

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index e12bea7a..daa3987d 100644
--- a/config.json
+++ b/config.json
@@ -1917,6 +1917,7 @@
     "buildtools" : {
         "ubuntu1804-arm-*" : "${BUILDTOOLS_ARM_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
+        "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",
--=20
2.43.0


