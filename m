Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21FC61DB9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 02:25:26 +0000 (UTC)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.583.1787883918131034852
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Aug 2026 19:25:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=ba+IsaxW;
 spf=pass (domain: fujitsu.com, ip: 207.54.90.47, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787883918; x=1819419918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K7RZg1WxsZP/u0D5ZrHZy14ai7OAr+sEyGlEdHw/0+4=;
  b=ba+IsaxWN75jsKrRY2fme42fXVun1DwdvfuJgOeUSTtLD45juvSb1vbi
   hDJEalYlmDO/EEpaZ+HqGJn9GJqzKl+Tjl+4+oyCG1SV9ODWOGtweshct
   0qmoC8PuPGHt2x5SuRQVrSzQATKp2yGw0dd6wwNwoYlJGfMtGY6IXZ/15
   0XmmC3lpQC0ZRWTjboooSBKZfywmvctqI0kvkiNfQdcgX8YVtts/KeZyf
   DwFD0ZZD2/V/l456uWlDvla+M3JmeYr3Jzj3gvCTHQWJVRv11a4nVoxus
   CmDTF68+CYQwpxkmfouoWWN1sy9bEq9pSRq0x64YR5os03RfHBLUK91iy
   Q==;
X-CSE-ConnectionGUID: loAUp6t+SwaamfsfGSy8NA==
X-CSE-MsgGUID: jNokufdcSbmYlISKmwXNyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="252954755"
X-IronPort-AV: E=Sophos;i="6.25,247,1779116400"; 
   d="scan'208";a="252954755"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 11:25:16 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 28ADA821101
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 02:25:16 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id CEAE7C00316
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 02:25:15 +0000 (UTC)
Received: from G08FNSTD200057.g08.fujitsu.local (unknown [10.167.135.104])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id C572110001DB;
	Fri, 28 Aug 2026 02:25:13 +0000 (UTC)
From: Wang Mingyu < wangmy@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [yocto-patches] [meta-security] [PATCH] ccs-tools: upgrade 1.8.9 -> 1.8.14
Date: Fri, 28 Aug 2026 10:25:09 +0800
Message-ID: <20260828022509.1221-1-wangmy@fujitsu.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 02:25:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4713

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 .../ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb}   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)

diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
similarity index 84%
rename from recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
rename to recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
index 3f754e9..aaf17b0 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
@@ -7,10 +7,10 @@ LIC_FILES_CHKSUM = "file://COPYING.ccs;md5=751419260aa954499f7abaabaa882bbe"
 
 DEPENDS = "ncurses"
 
-DS = "20210910"
-SRC_URI = "http://osdn.dl.sourceforge.jp/tomoyo/49693/${BPN}-${PV}-${DS}.tar.gz"
+DS = "20250707"
+SRC_URI = "https://sourceforge.net/projects/tomoyo/files/ccs-tools/1.8/${BPN}-${PV}-${DS}.tar.gz"
 
-SRC_URI[sha256sum] = "7900126cf2dd8706c42c2c1ef7a37fd8b50f1505abd7d9c3d653dc390fb4d620"
+SRC_URI[sha256sum] = "b62e344cc357a982310a08760f2a2cebf4cf48b1341ea9bd3990ae55f45bab03"
 
 S = "${UNPACKDIR}/${BPN}"
 
-- 
2.43.0


