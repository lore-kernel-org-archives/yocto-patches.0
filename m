Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693FCC7EE30
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 12:27:43 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.web10.6573.1751364020399040729
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Jul 2025 03:00:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=GYeU0S0R;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1751364019; x=1782900019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idN6QjGwwMsvjqkQGED6W9qKiNnHCdiJm8t6yQx5cTQ=;
  b=GYeU0S0RzhebJ+VaPHgDqkiEXH8AV2tgMx9dH+c5FxG5kpda49wQbb6X
   3jibX0LIxjGBhLpN+yOPXoE0skkYMk3JRffTGZ7vZuohl2J3p8AroPSaS
   2xkTvCVG2fRsrf8L6EzTyDRkOrb2d/WIlk20tIvOKnTqQQhv/8ImlxEKg
   ResDo7EiNf4PYTZp4EmMRKXiYOLADumkHDdtrOWTiUpaZTQYEhYTqFZMl
   8gxxeKb5QwEHJ7OposnmMBRnuvl8ERX7ScqPHXWuEvl25Q67xqE8CS9A8
   Lx2obvUSme6En0HHA8Ylr8y9NCwkJw7S5dmGTpTvH2Iz4a5Mw8UuAGDeJ
   g==;
X-CSE-ConnectionGUID: tkfJh2K3T6uo4C8LfD6Vaw==
X-CSE-MsgGUID: F4X5zRzSS1K1Z0IBVdIafw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="193286289"
X-IronPort-AV: E=Sophos;i="6.16,279,1744038000"; 
   d="scan'208";a="193286289"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([51.138.80.169])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:00:18 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id BD88B42A31A
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 10:00:18 +0000 (UTC)
Received: from oym-m2.gw.nic.fujitsu.com (oym-m2.gw.nic.fujitsu.com [10.85.9.162])
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTP id 3AFBA1000084
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 10:00:18 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8AADFBF3C5
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 19:00:16 +0900 (JST)
Received: from G08FNSTD190088.g08.fujitsu.local (unknown [10.193.160.53])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D2EB1A000B;
	Tue,  1 Jul 2025 18:00:15 +0800 (CST)
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: maxj.fnst@fujitsu.com,
	Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: [meta-security][PATCH 1/2] layer: drop styhead, add whinlatter
Date: Tue,  1 Jul 2025 18:00:11 +0800
Message-ID: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Jul 2025 12:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1730

fix the issue:
ERROR: Layer security is not compatible with the core layer which only supports these series: whinlatter (layer is compatible with styhead walnascar)

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 84d40a1..7c8e403 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "styhead walnascar"
+LAYERSERIES_COMPAT_security = "whinlatter walnascar"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index a7e32e5..d633f8e 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "styhead walnascar"
+LAYERSERIES_COMPAT_harden-layer = "whinlatter walnascar"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 33127c7..d26d753 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "styhead walnascar"
+LAYERSERIES_COMPAT_integrity = "whinlatter walnascar"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index 614c17e..6cee051 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "walnascar styhead nanbield scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar styhead nanbield scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core clang-layer"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 5f96114..7bd14e1 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "styhead walnascar"
+LAYERSERIES_COMPAT_tpm-layer = "whinlatter walnascar"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.43.0


