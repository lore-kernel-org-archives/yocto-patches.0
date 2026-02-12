Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744EEB2719
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:38:53 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41250.1770885531074985985
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:38:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=ajzIaXf3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260212083847ae057f3f1400020726-_nm87c@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260212083847ae057f3f1400020726
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 12 Feb 2026 09:38:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Ie+R5m34UOXT5A/gdqD98KnUTaH0DUdSzIcpxCbC0BM=;
 b=ajzIaXf3Bh+jObTDrErzxHwShBXXbefbUrIGSaPwbsZTxNVxTB3fS7ukfgmnzAoXeCPyrF
 W4V10Znd76TCRvGA6Gq3toh/ta0fYdyWwwnRi3HucyVKPqMfr3wKngD6bUIqcWPaCX+MSD2d
 GoYJKXORitV3gizVNrt5gxNT7xzhkEil/MYrwry3wi0GaYfkjGegdnqbovcwN5M5m0UElnYF
 shsG0fjhWnkbJMr2Ni57ClF73LKQetpvHNob9z55b3rHAoVXLWBxjRL0z2RB2dboCMWf4Evt
 khnWTrtU9N0o8r06qaQLz6V7Ye24ufX73Go98DaJPOd2GTmv7xPxgnAA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH] python3-tpm2-pytss: BBCLASSEXTEND native and nativesdk
Date: Thu, 12 Feb 2026 09:38:35 +0100
Message-Id: <20260212083835.9784-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:38:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3222

From: Peter Marko <peter.marko@siemens.com>

Commit cd729862f68152bc76db02cd4a93ca12a9424f88 added native/nativesdk
possibility to tpm2-pkcs11.
After 784ca4b6584101e971b2d5d76ec7b716ad1301b5 which added rdepends on
python3-tpm2-pytss, there are errors like:

Missing or unbuildable dependency chain was:
['<image>', 'swtpm-native', 'tpm2-pkcs11-tools-native', 'python3-tpm2-pytss-native']

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 4ddf287..63ed8cf 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -19,3 +19,5 @@ DEPENDS = " \
 "
 
 RDEPENDS:${PN} = "libtss2 python3-asn1crypto"
+
+BBCLASSEXTEND = "native nativesdk"

