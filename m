Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90047C27C43
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 02:54:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.13647.1716864858217731645
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 19:54:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S1ATC9005521
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 19:54:17 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90aaqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 19:54:17 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 19:54:16 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 19:54:16 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-raspberrypi][PATCH 4/7] psplash_%.bbappend: WORKDIR -> UNPACKDIR transition
Date: Tue, 28 May 2024 10:54:09 +0800
Message-ID: <20240528025412.2417168-4-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528025412.2417168-1-changqing.li@windriver.com>
References: <20240528025412.2417168-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _sAaClX3QRe36GNB4_11sQvkseOf5g3u
X-Proofpoint-GUID: _sAaClX3QRe36GNB4_11sQvkseOf5g3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=927 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 02:54:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/226

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-core/psplash/psplash_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/psplash/psplash_%.bbappend b/recipes-core/psplash/psplash_%.bbappend
index 57cade8..22e8061 100644
--- a/recipes-core/psplash/psplash_%.bbappend
+++ b/recipes-core/psplash/psplash_%.bbappend
@@ -5,7 +5,7 @@ SRC_URI:append:rpi = " file://framebuf.conf"
 
 do_install:append:rpi() {
     if [ "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}" ]; then
-        install -Dm 0644 ${WORKDIR}/framebuf.conf ${D}${systemd_system_unitdir}/psplash-start.service.d/framebuf.conf
+        install -Dm 0644 ${UNPACKDIR}/framebuf.conf ${D}${systemd_system_unitdir}/psplash-start.service.d/framebuf.conf
     fi
 }
 
-- 
2.25.1


