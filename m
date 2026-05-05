Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E41DCD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:44:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.155.1777995875305998580
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 08:44:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=WhDxFd8B;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621AB2681
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:29 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5EB913F836
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777995874; bh=Hq8PeOlCCm2PiM3JJkhrD6frXScxKIxwmjw+EN1FoNI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WhDxFd8BD2yAOMWXElSY9jzwWd7eGzNc3+kah1XRkIYTNlS/yZqhXH9yj+gfs+0GK
	 EaI4pndHJTy1H9+PNJ2Vk08aLDDlKd/ILnuXDCsC5PhwhCp+V/oP8BFntmXJmgqpJ7
	 r+h8lKCnT41rhWK+DxcsKsuDSpNLBL6A/4ZyE7pE=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-security][meta-parsec 3/3] parsec-service: update TS group name
Date: Tue,  5 May 2026 16:44:23 +0100
Message-ID: <20260505154423.535572-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505154423.535572-1-ross.burton@arm.com>
References: <20260505154423.535572-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 15:44:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3918

meta-arm recently changed the group name that is used by TS[1], so update
the group name to match.

[1] meta-arm 595cb0f1a0 ("arm/trusted-services: fix udev management in li=
bts")

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../recipes-parsec/parsec-service/parsec-service_1.5.0.bb       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5=
.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index 0268c0e..857a3c8 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -86,7 +86,7 @@ def parsec_groups(d):
     if "TPM" in config:
         groups.append("tss")
     if "TS" in config:
-        groups.append("teeclnt")
+        groups.append("tee")
     return "--groups " + ",".join(groups) if groups else ""
=20
 FILES:${PN} +=3D " \
--=20
2.43.0


