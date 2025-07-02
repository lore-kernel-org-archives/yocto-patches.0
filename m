Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61749C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 06:48:54 +0000 (UTC)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
 by mx.groups.io with SMTP id smtpd.web11.14394.1751423551294369849
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Jul 2025 19:32:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=UoXR1Pp1;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.225, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1751423551; x=1782959551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idN6QjGwwMsvjqkQGED6W9qKiNnHCdiJm8t6yQx5cTQ=;
  b=UoXR1Pp1+QP295BJ3WLr68OOrpUiOAqp4OQJVKmWTEROr1u4AN3KGN7u
   H/0KvzdHPgnYKVJ3BEmRFCGN/AJGeErXZQ7h6pOIVo8Ddju8DAEt+ilf4
   E+WX815kxC0yh5EtTVLHkjb9xRLIJ6wVIDqGPWlRzubA9fLuNqkpr9aXn
   EcSHNVIU1hIhJGXlGeBCDOamWRGIaMPmNhOohGgp2TEAO6V3WQOOEaEHZ
   uWg9LRod9FCAuc6dICNSbTY3nBZRR2I17YWl0rVI9pfRWa4E6CZaazDoa
   QBFimvLgCSzofL23JtlwourJNnZ66aOKTKuWHcflI9dJwBMA5aWma6wpv
   w==;
X-CSE-ConnectionGUID: Kx2MaHOdTGi6a6EAUdOzAg==
X-CSE-MsgGUID: H7t3obmXSeC9Pgff1lxR2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="192315064"
X-IronPort-AV: E=Sophos;i="6.16,280,1744038000"; 
   d="scan'208";a="192315064"
Received: from unknown (HELO az2uksmgr4.o.css.fujitsu.com) ([52.151.125.128])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 11:32:24 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 217A4C00203
	for <yocto-patches@lists.yoctoproject.org>; Wed,  2 Jul 2025 02:32:24 +0000 (UTC)
Received: from yto-m1.gw.nic.fujitsu.com (yto-m1.gw.nic.fujitsu.com [10.128.47.162])
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTP id 99B09C0247F
	for <yocto-patches@lists.yoctoproject.org>; Wed,  2 Jul 2025 02:32:23 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C8F5D8A9E
	for <yocto-patches@lists.yoctoproject.org>; Wed,  2 Jul 2025 11:32:22 +0900 (JST)
Received: from G08FNSTD190088.g08.fujitsu.local (unknown [10.193.160.53])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 39B541A006C;
	Wed,  2 Jul 2025 10:32:21 +0800 (CST)
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	yocto-patches@lists.yoctoproject.org
Cc: Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: [meta-security][PATCH v2 1/2] layer: drop styhead, add whinlatter
Date: Wed,  2 Jul 2025 10:32:12 +0800
Message-ID: <20250702023213.848-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 06:48:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1742

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


