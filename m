Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4FCFF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 14:14:18 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40138.1777990450839808108
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 07:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=KTLVZKDz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-2026050514140652c43f27ae00020715-zbahgf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026050514140652c43f27ae00020715
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 05 May 2026 16:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=I3dpCckGVddBRpjk7r29mVXSP5FJX6Ahf3qCqSWh1nI=;
 b=KTLVZKDzaF+rVe6y7QjH772ogHLaYuV2OnVcjJzsblbLDMYujSa/Xt/hAAuXzCmn0TEN5X
 VXHdOtPKPCrViL8sOm4Fccsqe+ovUy6fs8ULRV321mjDz7JOyS+GAZwrrSvDDAmMHmmp8wi7
 kevDYj63l35EZs123uy0QXHF5WKQh3/o3VUDtS2Z4R/G5r/QHTw+DS8w6VquGfBe9ZK66ZEc
 sZnmtCH+uOL1mqwUENveBhIAvZpbEC0DvD2xhT/5N+Z3sBEMhyowW2WDd2pwucApjYpgE3wG
 1RVV+avMdch5K9POOgGV11/SLCNZkOqT6c9mbRs14lE/6N2JQYbiBa2A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2
Date: Tue,  5 May 2026 16:13:53 +0200
Message-ID: <20260505141353.3142456-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 14:14:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3915

From: Peter Marko <peter.marko@siemens.com>

This contains fix for building native recipe with security flags
enabled:
* https://github.com/tpm2-software/tpm2-pkcs11/commit/be97b21ae641303ce83a8fbb54002701c1aede31

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../tpm2-pkcs11/{tpm2-pkcs11_1.9.1.bb => tpm2-pkcs11_1.9.2.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.1.bb => tpm2-pkcs11_1.9.2.bb} (95%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
similarity index 95%
rename from meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
rename to meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
index 762b82f..3d04e5b 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
@@ -9,7 +9,7 @@ DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools lib
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 SRC_URI += "file://0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch"
 
-SRC_URI[sha256sum] = "ce24aa5ec2471545576e892b6f64fd873a424371bbf9be4ca3a0e689ea11c9b7"
+SRC_URI[sha256sum] = "1bdabdaed6a5fa4ce8a1e82307f4612c30e30b0a0415e1bc7d9c30f713227480"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 

