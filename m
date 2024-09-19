Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16870CE8D52
	for <webhook@archiver.kernel.org>; Thu, 19 Sep 2024 07:08:21 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
 by mx.groups.io with SMTP id smtpd.web10.13861.1726729699387428585
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Sep 2024 00:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=iSwy3HpJ;
 spf=pass (domain: fujitsu.com, ip: 68.232.139.117, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1726729699; x=1758265699;
  h=from:to:cc:subject:date:message-id;
  bh=kfRJBM23pEEznn1EPy8qn9b5doD/BaC3GbkqVBPzmN8=;
  b=iSwy3HpJ7hwftZN7HB0qWxRiHqcFrnFV0DZd3mV5dxjSvylUVSnXJX9I
   BjaTREtMNTP4ugf4hTPOAjNs2lBqstuVZaibS6nD3yk2cicwmXDNKmfd1
   SWu5+UxH7g+ncIuNfTTuhrOSb7KsWRPT+FqK1obIDlBwl1LN1UbePQebI
   dxtF4oRMAWWIzYwjTLsKzrnkFE8QdtqkLbCo2Y9/EfzdYXGFDNalI7tlb
   2YC4yLyk4Wp8rtvo2Ueoiy03yBhBGKWDpiYs6sycIrD4Z6A5sGHsGvG+W
   ugdJZ4RaEeVqMhSB+QbRg/duAGUZfoJU4jP36K42WfJlSNTLqiE5UCPFP
   A==;
X-CSE-ConnectionGUID: b1ZyVJWnQImMasCYXroEfQ==
X-CSE-MsgGUID: DxkC9XwmTrCperfT/pvp9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="174323912"
X-IronPort-AV: E=Sophos;i="6.10,241,1719846000"; 
   d="scan'208";a="174323912"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 16:08:16 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 819F6C9442
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:14 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CB8E4D5042
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 510CB227A87
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:13 +0900 (JST)
Received: from vm4860.g01.fujitsu.local (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C42951A000B;
	Thu, 19 Sep 2024 15:08:12 +0800 (CST)
From: wangmy@fujitsu.com
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [meta-selinux] [PATCH] layer.conf: set LAYERSERIES_COMPAT with styhead
Date: Thu, 19 Sep 2024 15:07:59 +0800
Message-Id: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28674.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28674.000
X-TMASE-Result: 10-0.385900-10.000000
X-TMASE-MatchedRID: xQhc9986zPgv+0FNnM7lDQPZZctd3P4BtkpWbH/Eii6bKItl61J/yfJv
	ocwUrWp7do5KXLcCiwULbigRnpKlKZx+7GyJjhAUfvbkYEX0mO09UkLelw2xt9DK1tZD4D0sz9N
	wNVpMfMPKRWv/tfJB4N8u4n6oHTkXbWVwZZrBznNNvsGhVcxWQHQf/BSN/fih7H2fVekOqwmYL1
	KImKhq1ZuOe7yPCBvAf2OJxbAVgHQ+kK598Yf3Mg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 07:08:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/659

From: Wang Mingyu <wangmy@fujitsu.com>

Set LAYERSERIES_COMPAT with styhead in layer.conf which aligns with oe-core.

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 4e04e5c..c7f8dfb 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "scarthgap"
+LAYERSERIES_COMPAT_selinux = "styhead"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.34.1


