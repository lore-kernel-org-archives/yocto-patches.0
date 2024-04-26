Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ADAC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 19:07:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.4282.1714158437049777424
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Apr 2024 12:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6131C1007;
	Fri, 26 Apr 2024 12:07:44 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD473F793;
	Fri, 26 Apr 2024 12:07:15 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nd@arm.com
Subject: [PATCH][yocto-autobuilder-helper 2/2] config.json: don't do SDK tests on fvp-base
Date: Fri, 26 Apr 2024 19:07:10 +0000
Message-Id: <20240426190710.3808629-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426190710.3808629-1-ross.burton@arm.com>
References: <20240426190710.3808629-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Apr 2024 19:07:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/72

There's very little to be gained by doing SDK tests for fvp-base, so
save some cycles by removing them.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.json b/config.json
index c963c1bd..fbf2e6c6 100644
--- a/config.json
+++ b/config.json
@@ -679,8 +679,7 @@
             "step1": {
                 "shortname": "Build for fvp-base",
                 "MACHINE": "fvp-base",
-                "BBTARGETS": "core-image-minimal core-image-sato core-im=
age-sato:do_populate_sdk",
-                "SANITYTARGETS" : "core-image-sato:do_testsdk"
+                "BBTARGETS": "core-image-minimal core-image-sato"
             }
         },
         "meta-agl-core" : {
--=20
2.34.1


