Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21AFC83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 00:11:33 +0000 (UTC)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
 by mx.groups.io with SMTP id smtpd.web11.1887.1751587889801589683
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 17:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=VA3w6nIi;
 spf=pass (domain: fujitsu.com, ip: 207.54.90.48, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1751587890; x=1783123890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gvk+b/QdCNfv11UF3KCWbuBdgknrjU1qEGEUJjhAPpk=;
  b=VA3w6nIieoSP3fvMupxh/U9b8u/buVMrg1m8i/NhcX9v/+eK2e8/m+Gf
   Z27/Sa02j0FqWh9Jv4Oc2Ey23cDMLPj0FK+aoz4DF317A9mDS+qLwLsnO
   Pskxw2SAuEwNwWPdMDiFD7qVlxckXnQgra2CYBynAcZJFd0OmAgxrEkaW
   YhFN88/I4Qeepg6FNP3sjDRYlGTyj0lFSbFk8uOfJYcn/0WIqTUbHOCz8
   R9Hh73xWVouPMyge82zR0YqMEyUVx1JaqNv40uC/OW6POBznVOkok6O3s
   J4gbl0yPcsbCMfpBzqyaPnTQoTNNPkg6xEvcMgGc4XGt/mbaHPd0KRJld
   A==;
X-CSE-ConnectionGUID: mybsZ+4hTDqrGwcUa49TVw==
X-CSE-MsgGUID: P0vOU1x8Rj6/Of8FvrB7qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="205121939"
X-IronPort-AV: E=Sophos;i="6.16,285,1744038000"; 
   d="scan'208";a="205121939"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:11:28 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id CDE931000349
	for <yocto-patches@lists.yoctoproject.org>; Fri,  4 Jul 2025 00:11:27 +0000 (UTC)
Received: from oym-m1.gw.nic.fujitsu.com (oym-m1.gw.nic.fujitsu.com [10.85.9.161])
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTP id 509C918009C4
	for <yocto-patches@lists.yoctoproject.org>; Fri,  4 Jul 2025 00:11:27 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B3D58D4F40
	for <yocto-patches@lists.yoctoproject.org>; Fri,  4 Jul 2025 09:11:25 +0900 (JST)
Received: from G08FNSTD200057.g08.fujitsu.local (unknown [10.193.161.187])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 059801A0071;
	Fri,  4 Jul 2025 08:11:24 +0800 (CST)
From: Wang Mingyu < wangmy@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [yocto-patches] [meta-security] [PATCH] python3-fail2ban: drop unneeded S assignment
Date: Fri,  4 Jul 2025 08:11:22 +0800
Message-ID: <20250704001122.227-1-wangmy@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 00:11:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1749

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb           | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 52d35f8..7312bf8 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -26,8 +26,6 @@ inherit systemd
 
 SYSTEMD_SERVICE:${PN} = "fail2ban.service"
 
-S = "${UNPACKDIR}/git"
-
 do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
-- 
2.43.0


