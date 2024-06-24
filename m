Return-Path: <Pascal.Weisser.ext@karlstorz.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE0C2BD05
	for <webhook@archiver.kernel.org>; Mon, 24 Jun 2024 09:03:10 +0000 (UTC)
Received: from mx08-0040c702.pphosted.com (mx08-0040c702.pphosted.com [185.183.31.154])
 by mx.groups.io with SMTP id smtpd.web11.136096.1719219782159090291
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Jun 2024 02:03:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=gNmT7JAB;
 spf=pass (domain: karlstorz.com, ip: 185.183.31.154, mailfrom: pascal.weisser.ext@karlstorz.com)
Received: from pps.filterd (m0267678.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O4PGj5023319
	for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	S-DKIM-20210427; bh=Y52ybEBxavc3Rz0FpK2Oy/FLuw/J6dWpn0D51t+T8tk=; b=
	gNmT7JABqrPNgq6x4Vjd5hkGiwlXUtdZgnWBURodl5QWieXfBBPf9dIH8AQ1Adqr
	CuZXQ0v36eoleGEF+eF82ekxNeTOKGbAj9DVuzGiUulHfwlp2vP/6rplG15VVrY+
	Kbp2HrhBLDuB/HF1IX+PrfvwfiAcWBy+9res0CHkbdgnim908hO6MbGeUuBkt/b/
	SIFs3RfwJxMfp0H9LaQFFOpDTLyPv9FyTqNkQT/1s0fFdF7i9UVBKS1CmfMfT+4I
	kD9Zip8RLXR9F2jH0raBf7gkDuzUbZGBN8TTLWDHMAag0wlm7t4CBRjx2ReM8ihW
	XHIWkjDvqMyXqS4FljAfCg==
Received: from tut-ex22-pv.kstg.corp (62-134-76-232.business.static.de.bt.net [62.134.76.232])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 3ywnhbnxgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:02:59 +0000 (GMT)
Received: from TUT-EX23-PV.KSTG.corp (10.0.10.227) by TUT-EX22-PV.KSTG.corp
 (10.0.10.226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 11:02:57 +0200
Received: from tutn-bpfb5m3.kstg.corp (10.0.10.41) by
 InternalSMTPRelay.KSTG.corp (10.0.10.227) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 24 Jun 2024 11:02:57 +0200
From: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
Subject: [meta-selinux][PATCH 1/1] Add SELinux specific configuration snippet for busybox.
Date: Mon, 24 Jun 2024 11:02:00 +0200
Message-ID: <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
References: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AWn9CAdv4si5tauJoFeP9yTzJ1l57zoe
X-Proofpoint-ORIG-GUID: AWn9CAdv4si5tauJoFeP9yTzJ1l57zoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_07,2024-06-21_01,2024-05-17_01
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:03:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/370

This patch adds a SELinux specific configuration snippet for busybox to
enable SELinux support in busybox out of the box. This is needed to enable
SELinux specific command line options for certain commands like ps -Z.

Signed-off-by: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
---
 recipes-core/busybox/busybox_selinux.inc | 6 ++++++
 recipes-core/busybox/files/selinux.cfg   | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 recipes-core/busybox/files/selinux.cfg

diff --git a/recipes-core/busybox/busybox_selinux.inc b/recipes-core/busybox/busybox_selinux.inc
index 740980f..ade30cf 100644
--- a/recipes-core/busybox/busybox_selinux.inc
+++ b/recipes-core/busybox/busybox_selinux.inc
@@ -1,3 +1,9 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+SRC_URI:append = " file://selinux.cfg"
+
+DEPENDS:append  = " libselinux"
+
 PTEST_BINDIR = "0"
 
 FILES:${PN} += "${libdir}/${PN}"
diff --git a/recipes-core/busybox/files/selinux.cfg b/recipes-core/busybox/files/selinux.cfg
new file mode 100644
index 0000000..00aeb51
--- /dev/null
+++ b/recipes-core/busybox/files/selinux.cfg
@@ -0,0 +1 @@
+CONFIG_SELINUX=y
-- 
2.45.2


