Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB0C369A2
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 07:12:48 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.web11.28798.1744269165660831199
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 00:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=rI7ayH95;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744269165; x=1775805165;
  h=from:to:cc:subject:date:message-id;
  bh=lee4pst/L8ihy16becjf1dIW6Mj8/lbKfaBzXJZmScg=;
  b=rI7ayH95jgrPmFgwpKv88mkwOZ1mc21HGvzsGKgyeLUu1Hke+S5TjAxW
   cP92TT0i1lP4pF8EidpPqGgOn5jdBY/bVPlErcQ0gIhVmWE1rEYybn7SD
   jrqzLT3tXAmjgrVuB8LpiFYfmBUQmu/wxdINBK7qOMFJypHD/fiCjtF9X
   gvZo84fh1btbwLKK0GWbBoSIncUs6HA1S/qATmbKFEBUQnetDT5w6JGQF
   fOcpz+Pq4wUnnxJPqH8J/ldTrv4Daj9b/PtygHGqiFFYur+wRewyZgnqq
   9u9qzUIDaJn1meeXC0Xc8TGLFjw+gOl/6jjN5+JouFv+3rIjaQxDrOpoR
   A==;
X-CSE-ConnectionGUID: VUHsf+9FSoOtyMOMXxvASQ==
X-CSE-MsgGUID: 4eH7QwqEQMyc9Oxb8pfTqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="184411143"
X-IronPort-AV: E=Sophos;i="6.15,202,1739804400"; 
   d="scan'208";a="184411143"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 16:12:43 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B2C8DBB87
	for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 16:12:41 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E75DED7001
	for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 16:12:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 49E211A0078;
	Thu, 10 Apr 2025 15:12:40 +0800 (CST)
From: wangmy@fujitsu.com
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [yocto-patches] [meta-cgl] [PATCH] layer.conf: add walnascar to LAYERSERIES_COMPAT
Date: Thu, 10 Apr 2025 15:12:34 +0800
Message-Id: <1744269154-14762-1-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 07:12:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1345

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 meta-cgl-common/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-cgl-common/conf/layer.conf b/meta-cgl-common/conf/layer.conf
index 2912dd9..4444542 100644
--- a/meta-cgl-common/conf/layer.conf
+++ b/meta-cgl-common/conf/layer.conf
@@ -11,6 +11,6 @@ BBFILE_PRIORITY_cgl-common = "7"
 
 LAYERDEPENDS_cgl-common = "core openembedded-layer networking-layer perl-layer filesystems-layer security selinux yocto"
 
-LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead"
+LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead walnascar"
 
 require conf/distro/include/cgl_common_security_flags.inc
-- 
2.43.0


