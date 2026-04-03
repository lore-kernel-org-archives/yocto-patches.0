Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9784ED6AB19
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 08:28:11 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7273.1775204886563589014
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 01:28:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=f9gkW4xX;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1775204886; x=1806740886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qwDUyM9nVT9vS+3rCSkQr59Y/lwZaS3ta1IztltopKQ=;
  b=f9gkW4xX4XBlIgW1XOna0Bn5yS/c320ahBS7pMJvXL5HayQe67FZ320R
   flPjsMFOwk1NpeoOEvav8Qj4hJa75lWmVol5LBs4cVB8nmvcnCCDcnJZa
   3xZKojnMw86menQBWGf2CQ8qgG9LIHGwOEg9uYXdlLdhGyuDwuRBW5sA6
   HxyN4yVX4hp500K3+gnPzw+w4/GKdGmusbJXXjO8PApzKzFyQKDOyQHcR
   epA0ZCJy46Knnl0iWlL3vRgy0KAMnAk6cxOMZZ2BOoVqFp8cn+UniyYxC
   rPxU/Qmh9m5VsmzUiNnrRqdoulCrBnKuSeAsiGDAozhVHQ/fFO/RVEZev
   Q==;
X-CSE-ConnectionGUID: 3Ou44L6kSZ6uzH17miRw0A==
X-CSE-MsgGUID: 2bvCZz2cTBiClZYi9hYLVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="224345848"
X-IronPort-AV: E=Sophos;i="6.23,157,1770562800"; 
   d="scan'208";a="224345848"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:28:05 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id CDFD51C166DA
	for <yocto-patches@lists.yoctoproject.org>; Fri,  3 Apr 2026 08:28:04 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (az2uksmom3.o.css.fujitsu.com [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 89275181AA59
	for <yocto-patches@lists.yoctoproject.org>; Fri,  3 Apr 2026 08:28:04 +0000 (UTC)
Received: from G08FNSTD200057.g08.fujitsu.local (unknown [10.167.135.104])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTP id 2482D1003F5A;
	Fri,  3 Apr 2026 08:28:01 +0000 (UTC)
From: Wang Mingyu < wangmy@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Date: Fri,  3 Apr 2026 16:27:58 +0800
Message-ID: <20260403082758.1460-1-wangmy@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 08:28:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3623

From: Wang Mingyu <wangmy@fujitsu.com>

LAYERSERIES_COMPAT: add wrynose

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 meta-cgl-common/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-cgl-common/conf/layer.conf b/meta-cgl-common/conf/layer.conf
index 522e121..8ac281b 100644
--- a/meta-cgl-common/conf/layer.conf
+++ b/meta-cgl-common/conf/layer.conf
@@ -11,6 +11,6 @@ BBFILE_PRIORITY_cgl-common = "7"
 
 LAYERDEPENDS_cgl-common = "core openembedded-layer networking-layer perl-layer filesystems-layer security selinux yocto"
 
-LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead walnascar whinlatter"
+LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead walnascar whinlatter wrynose"
 
 require conf/distro/include/cgl_common_security_flags.inc
-- 
2.43.0


