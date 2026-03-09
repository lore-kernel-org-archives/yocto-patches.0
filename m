Return-Path: <hetpat@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDDF513F1
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 09:10:03 +0000 (UTC)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9847.1773047396394853645
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 02:09:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=U4OxIfN5;
 spf=pass (domain: cisco.com, ip: 173.37.142.93, mailfrom: hetpat@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1371; q=dns/txt;
  s=iport01; t=1773047396; x=1774256996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ruk9BRglijS9aBb90jkdZ4zB8kO+3yam7wIqkGbUQKk=;
  b=U4OxIfN5ECjv53z6FvcKflZgAzqbUzo+Ru0Af9J+mAUTEegTiRDx8vwj
   7tBHhfedI4RXzgIZZrkU1K7kZIqqBpTVyAn5PumDYRLse2qNF00rv9TVR
   VFxQp70cbxrYITE22YTkcPW0Es1dDiGcGvMBjbpil7GDEOfF/pryCbr1S
   8EfRerIciLKFVBfVRk7xnl4ggBPcwVcoa6WVGpdgGfslStUid9Zi9YLRL
   fONtF+uQkveeFtYc5+E+pL63ytSeMZamGTmpDLkz5XMjwBr8awEaetmYv
   cC1YCzIY/30upk/P/S9ZLZe4xy7eNMNX2EetBDwhCj55SooeRf4K9xeDJ
   w==;
X-CSE-ConnectionGUID: GudbG0EhTk+V3j4eFG0hOg==
X-CSE-MsgGUID: W+Id4YiISiaZR3od3kos7Q==
X-IPAS-Result: =?us-ascii?q?A0DyCAC2ja5p/5P/Ja1aglmCSA9xX0JJk1oBgnCeHYF/D?=
 =?us-ascii?q?wEBAQ9EDQQBAYRBRo0iAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZPDYZdNgFGMFxEgwIBgnMCARGqWYIsgQGEfNsmAQUGFAGBO?=
 =?us-ascii?q?IU8iBl0hHonGxuBcoR9gmECAhiBDYEGhXcEgiKBDoF/kRxIgR4DWSwBVRMNC?=
 =?us-ascii?q?gsHBYFmAzUSKhVuMh2BIz4XgQsbBwWFIA+IcnRugRODAwMLGA1IESw3FBsEP?=
 =?us-ascii?q?m4HjWo+gjMBIRxRLIIspXShDgoog3SMHpU6GjOqay6YWI4JlWdphGiBaDyBW?=
 =?us-ascii?q?XAVgyJSGQ+SIYUTxBkjNQI6AgcLAQEDCZFqgX0BAQ?=
IronPort-Data: A9a23:jpeXc6w3FKGakRe6QVJ6t+d8xyrEfRIJ4+MujC+fZmUNrF6WrkVTz
 jcZXGrSOPzeYDOnKtslO4Tl9RwO65GEyd9qTFY//lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4iaT/H3Ygf/hWYvajNMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJG4rMYc3ost3PWINy
 6cadD0jQUiDoO3jldpXSsE07igiBNPgMIVavjRryivUSK9+B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cPHWjOX9PYH46tOelmmH2bxVTqUmeouw85G27IAlZjuixbIKLK4baLSlTtnnbh
 26azmXYORATBubEzjbe8XW32daayEsXX6pXTtVU7MVCkVqY2mtWEBQKXlu2utG9i1WiQJROL
 EcI/TI0qqo//1DtScPyNyBUu1aetRIaHt4VGOog5UTUkuzf4h2SAS4PSTsphMEaifLajAcCj
 jeh9+4FzxQ02FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:5mqEQKtPaIHkUz/K+iIEBZYi7skDfdV00zEX/kB9WHVpmwKj+P
 xG+85rsCMc5wxxZJhNo7290cq7MBHhHOBOgbX5VI3KNGKNhILCFu9fBOXZrwEIYxeOldK0Ec
 xbAs9D4BqaNykfsfrH
X-Talos-CUID: 9a23:he27xm/kwIEg83bP3k6Vv2EJFsoKKlDd8HSTHRS6VWtHZ+WVblDFrQ==
X-Talos-MUID: 9a23:bIyhIAS578+1uG+pRXTTxxBuaPZpwp+vAXI3ypIK4MqDLnNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770595200"; 
   d="scan'208";a="684406928"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Mar 2026 09:09:55 +0000
Received: from sjc-ads-8556.cisco.com (sjc-ads-8556.cisco.com [171.68.222.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 7055518000892;
	Mon,  9 Mar 2026 09:09:55 +0000 (GMT)
Received: by sjc-ads-8556.cisco.com (Postfix, from userid 1847788)
	id 013F8CC8CB9; Mon,  9 Mar 2026 02:09:54 -0700 (PDT)
From: "Het Patel -X (hetpat - E INFOCHIPS PRIVATE LIMITED at Cisco)" <hetpat@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: xe-linux-external@cisco.com,
	vchavda@cisco.com
Subject: [meta-selinux] [PATCH v1] selinux_common: Correct `CVE_PRODUCT` value
Date: Mon,  9 Mar 2026 02:09:53 -0700
Message-Id: <20260309090953.1399082-1-hetpat@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 171.68.222.95, sjc-ads-8556.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 09:10:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3381

From: Het Patel <hetpat@cisco.com>

The current `CVE_PRODUCT` value (`kernel:selinux`) is incorrect for
this recipe.

Root Cause Analysis:
`CVE-2020-10751` is reported against the `kernel:selinux` CPE, and
its fix (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb73974172ff)
applies to the Linux kernel source tree. This change is unrelated to
the source code used by this recipe.

Change Justification:
`CVE-2021-36084` is reported against the `selinux_project:selinux`
CPE. Its fix (https://github.com/SELinuxProject/selinux/commit/f34d3d30c832)
directly applies to the SELinux source repository used by this recipe,
confirming the vulnerability is applicable to this product.

Based on this analysis, `CVE_PRODUCT` has been updated to the
correct value: `selinux_project:selinux`

Signed-off-by: Het Patel <hetpat@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index a7f704d..aaf0b90 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -20,4 +20,4 @@ do_install() {
         SHLIBDIR="${base_libdir}"
 }
 
-CVE_PRODUCT ?= "kernel:selinux"
+CVE_PRODUCT ?= "selinux_project:selinux"

