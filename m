Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349DC02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 11:19:23 +0000 (UTC)
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
 by mx.groups.io with SMTP id smtpd.web10.31074.1737350423414385466
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Jan 2025 21:20:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport header.b=M6V2aGbR;
 spf=pass (domain: cisco.com, ip: 173.37.86.76, mailfrom: madmarri@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1032; q=dns/txt; s=iport;
  t=1737350423; x=1738560023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNUm30/vNOj9FKPKOO2+HpwxCyXi9JDz0fi2N7OTTt0=;
  b=M6V2aGbRpM1C539plQ0zAKgGN3qS6qPLV16x2ye/TiVI+pLOn2oKrTrq
   uNPLD0af1REK/GyCKj4J3cynaOQ9i99sbEuZ2UIcezBlgQWHg063/zCLk
   Umighvs0KbdykBo/dN+XQxmroU2tix7LqtQW1SwHAwfSJXMKEBWevIvuJ
   A=;
X-CSE-ConnectionGUID: T3yPe6IeQkKyN0gKgyev/Q==
X-CSE-MsgGUID: pyUmba6YTLe92Hh3vKIBMw==
X-IPAS-Result: =?us-ascii?q?A0AsAADc241n/5H/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkp2WUNIjHKnbYElA1YPAQEBDzsJBAEBhQeKdQImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOFew2GXTYBRoEMRIMBAYJkA?=
 =?us-ascii?q?xG0ToIsgQGDaAJDTtk4gWcGgUgBjUlwhHcnG4FJRIJQgi2BBYFcAQMYghOFd?=
 =?us-ascii?q?wSHZY8MkEZIgSEDWSwBVRMNCgsHBYFxAzgMCzAVgUpEN4JGaUk3Ag0CNYIef?=
 =?us-ascii?q?IIrhFqERWAvAwMDA4M4hVyCFIIWhRBAAwsYDUgRLDcUGwY+bgebZAE8g3Y9U?=
 =?us-ascii?q?SyCLJMfszyEJYRvhymVLhozqlOYfI4ElkOEZoFnPIFHCwczGggbFYMiUhkPj?=
 =?us-ascii?q?jiFYoMVuXJGMgI6AgcLAQEDCZFmAQE?=
IronPort-Data: A9a23:AOjG7qk+ZttP3NHyFx1AYQPo5gzUJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeXW2EPfyIZ2ShfNBzadix9UhX7MCBzdUwTVBrqS01H1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pa31GONgWYubzpNsvPb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FbFD6956X0BDz
 P87ORZVYTOMlu+oh4vuH4GAhux7RCXqFJkUtnclyXTSCuwrBMiTBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZz/7C7pm9Ausrnz2fzhRskiUjaE2+GPUigd21dABNfKOIozXGZ4NwRrwS
 mTu53XEBxsTau2j7TfUqFKs3fHsvAneR9dHfFG/3rsw6LGJ/UQCDxYKUh6jqOWyikOlc9ZeM
 FAPvDspprQ17FasTNT2Q1u/unHsg/IHc8BbH+t/7ESGzbDZpl7JQGMFVTVGLtchsafaWAAX6
 7NApPuxbRQHjVFfYSv1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:ZouWT6gGBuZc7RXVqAjRDuq4yHBQXtEji2hC6mlwRA09TyVXra
 +TdZMgpHrJYVkqOU3I9ersBEDiewK/yXcW2+ks1N6ZNWGM0ldAR7sN0WKN+VHd8lXFh41gPW
 MKSdkYNDU2ZmIK6frH3A==
X-Talos-CUID: 9a23:P45YV26mNljrOcZd09ssyBUFIs17U3Dkz1TBBRe3Kml4RaPScArF
X-Talos-MUID: 9a23:HpQCmAsoU+FrM4K5xM2nnCBfMc1hvZWSLE1cy7UG4NenFAZVJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,218,1732579200"; 
   d="scan'208";a="308543074"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Jan 2025 05:20:22 +0000
Received: from sjc-ads-7373.cisco.com (sjc-ads-7373.cisco.com [10.30.220.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id A1448180001E8;
	Mon, 20 Jan 2025 05:20:22 +0000 (GMT)
Received: by sjc-ads-7373.cisco.com (Postfix, from userid 1839049)
	id 35D35CC12B5; Sun, 19 Jan 2025 21:20:22 -0800 (PST)
From: "Madhu Marri" <madmarri@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: xe-linux-external@cisco.com,
	madmarri@cisco.com
Subject: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as Patched
Date: Mon, 20 Jan 2025 05:20:19 +0000
Message-ID: <20250120052019.2945142-1-madmarri@cisco.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
X-Outbound-SMTP-Client: 10.30.220.158, sjc-ads-7373.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 11:19:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/987

Bug Details: https://nvd.nist.gov/vuln/detail/CVE-2020-10751
Type: Security Advisory
CVE: CVE-2020-10751
Score: 6.1
Patch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb73974172ff

Analysis:
- This is a selinux cve which is addressed in kernel.
- The fix is available at [1].
- Hence, marking the CVE as patched.

Reference:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb73974172ff

Signed-off-by: Madhu Marri <madmarri@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index cecb0b5..d8c91ac 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -19,3 +19,5 @@ do_install() {
 }
 
 CVE_PRODUCT ?= "kernel:selinux"
+
+CVE_STATUS[CVE-2020-10751] = "fixed-version: Fix is present in the current kernel version."
-- 
2.44.1


