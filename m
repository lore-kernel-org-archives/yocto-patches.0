Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD02C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 20:31:17 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.6178.1746736272742541668
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 May 2025 13:31:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=m6xUSf81;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: rs@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 548KVB811181267;
	Thu, 8 May 2025 15:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746736271;
	bh=gVBlan+DgvTvtGmxKoKJiueZI3GHFdq1XLWngv/Sd50=;
	h=From:To:CC:Subject:Date;
	b=m6xUSf81H57kzLdf7GU2pNADb5cxbDCNJgvYTP5k7uaGKD43L7PwiMqc94Rk5cLwD
	 UuXx9GbeDN/XuvNPrHv31WC7x0MhvFpVvrSqBXZyzZsfMWfH9ktn9TwBpSseLlv1p1
	 lGsl3liz9TS1PqZ3vTm0/B2kN3plSSFD0B3KZxu4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 548KVALF2459564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 8 May 2025 15:31:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 May 2025 15:31:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 May 2025 15:31:10 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 548KVArB110295;
	Thu, 8 May 2025 15:31:10 -0500
From: <rs@ti.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <richard.purdie@linuxfoundation.org>, <alex.kanavin@gmail.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: Drop core-image-sato from x86-64-x32
Date: Thu, 8 May 2025 15:30:50 -0500
Message-ID: <20250508203050.1553862-1-rs@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 20:31:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1539

From: Randolph Sapp <rs@ti.com>

Drop core-image-sato from the x86-64-x32 tune test suite and falls back
to core-image-full-cmdline for verification. This change is supported by
previous issues reported in openembedded-core related to graphics and
multimedia, and a dependency issue caused by lack of support of this ABI
in languages like Go [1].

[1] https://lists.openembedded.org/g/openembedded-core/message/216111

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 config.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 0631023..383b18d 100644
--- a/config.json
+++ b/config.json
@@ -872,11 +872,11 @@
                 "baselib = \"${@d.getVar('BASE_LIB_tune-' + (d.getVar('DEFAULTTUNE', True) or 'INVALID'), True) or 'lib'}\""
             ],
             "step1" : {
-                "BBTARGETS" : "core-image-minimal core-image-sato",
+                "BBTARGETS" : "core-image-minimal core-image-full-cmdline",
                 "SANITYTARGETS" : "core-image-minimal:do_testimage"
             },
             "step2" : {
-                "SANITYTARGETS" : "core-image-sato:do_testimage",
+                "SANITYTARGETS" : "core-image-full-cmdline:do_testimage",
                 "extravars" : [
                     "TEST_SUITES:append = ' x32lib'"
                 ]
-- 
2.49.0


