Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA543CE8D58
	for <webhook@archiver.kernel.org>; Thu, 19 Sep 2024 07:08:30 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.web10.13862.1726729700170869493
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Sep 2024 00:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=PgWj+GTM;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1726729700; x=1758265700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wfFqcpUvmdZTCTKXmVgrD5H4JewIchzGMFK+h4tuRfo=;
  b=PgWj+GTMzlLy0zKtBx3nOktR+GphynNZS1vN+0boKyJrylvSefrz7Xot
   jMF6SqTyirGVDPXMJnbqP59R6bw5T+13FgYS0DhQW2FSEGGpDl+7DDRZ+
   FsbBdnZJwvYibOdD851kztKDV3XYuylY29MQOTI5dyVu+nDSPNJCdlqLh
   Cv8mTalZNKgKU381sECeU/4gbJRrfC91CN2/u4QUMbIpCaxqrKS2b6D1F
   akLaGmXFRi7+i1s7NJKS6dN1bv3qN/yAi11vBj23qF5GpYAaYn7jsU/KC
   /yOvi07TObhuUH0M4EF2582kFf90TP4PVGWx94bKGqTdA6qHjrGUQ88aq
   Q==;
X-CSE-ConnectionGUID: 1XJcPIiDSLGNT9P9CE24Jg==
X-CSE-MsgGUID: PhG721+iRqWofqK0wrdTxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="162481266"
X-IronPort-AV: E=Sophos;i="6.10,241,1719846000"; 
   d="scan'208";a="162481266"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 16:08:17 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 464CAC3F95
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:15 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 91C16D5042
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:14 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 18D5920086EBF
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:14 +0900 (JST)
Received: from vm4860.g01.fujitsu.local (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B86B21A000B;
	Thu, 19 Sep 2024 15:08:13 +0800 (CST)
From: wangmy@fujitsu.com
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [meta-java] [PATCH] layer.conf: Mark as compatible with styhead
Date: Thu, 19 Sep 2024 15:08:00 +0800
Message-Id: <1726729681-15869-2-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
References: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28674.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28674.000
X-TMASE-Result: 10--2.407700-10.000000
X-TMASE-MatchedRID: ZYjN+pfhQkov+0FNnM7lDQPZZctd3P4BRzUPAqhCjtiysPB8dBBorXGH
	F8brtu3j4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8hxKpvEGAbTDsSM67NHwyCUwu2
	T0gh73pIxJLkFGe4eVxOUwnA3gkJlA/5YGW1V2CrjW2BiYskPuCY6oL+gPNUAZb12LBb2JWrJDV
	velws+iYK+pasWyF5Rwt7TMGN5mtsVA4/nYFEFckxOwqPXyr98
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 07:08:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/660

From: Wang Mingyu <wangmy@fujitsu.com>

LAYERSERIES_COMPAT: replace scarthgap with styhead for Yocto 5.1

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 71d6a10..3b77b2d 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -7,7 +7,7 @@ BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
 BBFILE_COLLECTIONS += "meta-java"
 BBFILE_PATTERN_meta-java := "^${LAYERDIR}/"
 BBFILE_PRIORITY_meta-java = "10"
-LAYERSERIES_COMPAT_meta-java = "scarthgap"
+LAYERSERIES_COMPAT_meta-java = "styhead"
 LAYERDEPENDS_meta-java += "openembedded-layer"
 
 LICENSE_PATH += "${LAYERDIR}/licenses"
-- 
2.34.1


