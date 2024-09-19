Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11058CE8D52
	for <webhook@archiver.kernel.org>; Thu, 19 Sep 2024 07:08:31 +0000 (UTC)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
 by mx.groups.io with SMTP id smtpd.web11.13998.1726729700873777345
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Sep 2024 00:08:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=n6rAWfdr;
 spf=pass (domain: fujitsu.com, ip: 68.232.139.130, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1726729701; x=1758265701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HJ9bkZF37B+ZWeQBqEiTaVyQ4yAd7BPOgVHwssFk2N0=;
  b=n6rAWfdrpGK2koFp7miRgaPwOyEGtYD6xFRhqn6khTyArV7U770q0KqX
   KmoVenfyH/HhhRnC3SIaE8hsEuwtxi32gVn33R2KJUQuB5NEU2wlCc+Wz
   FYty629E6VMfVYp83XI3Dfco4Z3brEwDRe9CTlwg5VdRe8Jpt2EzTxt+u
   b4lcrmAt+ZteqF3YBeEfeD4UMmbfqTc3AQFkEurkPcgO1UrXTzwspKO0r
   +8HG2eR37BRE2uTXg9KhASB17d9iQv3r8gWgs1RBeKkMy9wzTlINL4bfe
   KeoMQUnwcxQMn2IJIoL+hHt3uRMTTtW/ij0cQMlgi/1EhcqvrjqCg7ngB
   w==;
X-CSE-ConnectionGUID: jBoELtUfTNuVE57RXL2pVw==
X-CSE-MsgGUID: VZDaN1mnSCa3Tly5K+dsUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="173388574"
X-IronPort-AV: E=Sophos;i="6.10,241,1719846000"; 
   d="scan'208";a="173388574"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 16:08:18 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 339E0D424D
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7ACD3D8BA3
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1799D227A87
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 16:08:15 +0900 (JST)
Received: from vm4860.g01.fujitsu.local (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B6EF21A000B;
	Thu, 19 Sep 2024 15:08:14 +0800 (CST)
From: wangmy@fujitsu.com
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [meta-cgl] [PATCH] layer.conf: Add styhead
Date: Thu, 19 Sep 2024 15:08:01 +0800
Message-Id: <1726729681-15869-3-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
References: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28674.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28674.000
X-TMASE-Result: 10-0.613300-10.000000
X-TMASE-MatchedRID: WiDRxrFjYOZSuJfEWZSQfPx0ykrbAxjCwTlc9CcHMZerwqxtE531VIPc
	XuILVCbaQcnXtZIEDVWAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07X1HhKzShSYnHOH
	paS9RUdHcruIjlzYn/LzIBFU8/UfMJ5Mxk1zNkHww1Tyw9TlPR3w77qTHa7l+RSPMysYBzlq+za
	fy6GSAjKWABUtrVACt8gwWDQic4+rPmACeZqO85TioKJ2WPUxTLS4AEOLjtwA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Sep 2024 07:08:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/661

From: Wang Mingyu <wangmy@fujitsu.com>

LAYERSERIES_COMPAT: add styhead for Yocto 5.1

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 meta-cgl-common/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-cgl-common/conf/layer.conf b/meta-cgl-common/conf/layer.conf
index f1f11dc..2912dd9 100644
--- a/meta-cgl-common/conf/layer.conf
+++ b/meta-cgl-common/conf/layer.conf
@@ -11,6 +11,6 @@ BBFILE_PRIORITY_cgl-common = "7"
 
 LAYERDEPENDS_cgl-common = "core openembedded-layer networking-layer perl-layer filesystems-layer security selinux yocto"
 
-LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap"
+LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead"
 
 require conf/distro/include/cgl_common_security_flags.inc
-- 
2.34.1


