Return-Path: <Haitao.Liu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CDFF8868
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 09:19:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9169.1777367985918047133
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 02:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cCAeaAjo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85783cf450=haitao.liu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5x11j1807631
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 02:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=7rapWCExsmpZA7XWNzyO
	sj8JEf9pbMzmttrKIk7HY/0=; b=cCAeaAjoo9fz3e2m2ZdV9INb/MwxT2/LlsoQ
	uRNVlR3aFH2UBNzBdLViJSCzKWycaUZK4hSDSFUZTIeE0IThteDp+2m7FfJxs5T3
	1n5NLpMfONLfrToZ6LwR4QpuerUHT99a7M7vR7U9cmM9ZxDtt9/WD01sn6wyBY0B
	dy83mTc4xykJEg9QwAOkn+Ts8b2bIELTvesPwF1HB0+XjK24zL72VsF49r64tvFt
	GkY3HpPvMpx7GLccpIHPbsm19DDzdDfGfePurDu/L6ubJs0/0TpogvpjSSCLIz/K
	Z/c8mAQ58/XoUYQoMjFm4oW1WlMDIMyH6hCROK66pvxA4U+2Ww==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drw4j2v42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 02:19:44 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 28 Apr 2026 02:19:44 -0700
Received: from pek-starlingx-w1.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 28 Apr 2026 02:19:43 -0700
From: Haitao Liu <haitao.liu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches][meta-security][PATCH] aide: fix pkg_postinst_ontarget shell script
Date: Tue, 28 Apr 2026 17:19:42 +0800
Message-ID: <20260428091942.3915623-1-haitao.liu@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nlf4J9FiNrdYu73po6V3248zW3B3q7lq
X-Proofpoint-ORIG-GUID: nlf4J9FiNrdYu73po6V3248zW3B3q7lq
X-Authority-Analysis: v=2.4 cv=Iroutr/g c=1 sm=1 tr=0 ts=69f07bb0 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Rqg5FfbeET4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=E_dPmeEeCkFoVfi_jN8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfX0h3xKVCnf/19
 6EjyRkM1VHh3MA+P7lus6W+ov9i/o6+pDH8hU3Z9dawxW5Fcfig94chLNUvP1FYltTQ0Vkt9Ria
 Cfhxht08SU+pyPurjUQNkuT5l1CzE5ARvuMdLY1oORuHnGxQd15HTR2mCh9LlSwMwNLoPSVJA/c
 Ouguc2+931nhYK5Z5V4Hj2kUGnFCeKL4lnu8LpWhS7W4mNFu1dv7JgjSG7tFpL9A3j4bYetm/OG
 YjPuvgxha5lYttUQRQYghx7lOteQGFw+KRiacQo3WflzQVmp41OfnDbdY5t4r9ALwVFZHA+o3Ho
 RT4cui6i3/ELMu0obepeDvcROTU5RLvdQxfI1CaOPvHrrQxnILBY9Z4ct3Nc6zD3py0rWVoE1AX
 HMMhX9DxIyeXe7uSXrIYIDCr2wRwNfFn0c+trdXawCofrfuiplWJInuW+IDqTcf3MGK1q7arOIJ
 iQM3avJYOyRboZudt5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 09:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3864

  - Fix conditional checks for AIDE_SCAN_POSTINIT and AIDE_RESCAN_POSTINIT:
    '[ 0 ]' always evaluates to true since it's a non-empty string.
    Use string comparison '= "1"' instead.
  - Fix invalid use of '&&' inside '[ ]' test brackets. Use separate
    test expressions joined by shell '&&'.

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
---
 recipes-ids/aide/aide_0.18.8.bb | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/recipes-ids/aide/aide_0.18.8.bb b/recipes-ids/aide/aide_0.18.8.bb
index 2912cb2..7d1c05a 100644
--- a/recipes-ids/aide/aide_0.18.8.bb
+++ b/recipes-ids/aide/aide_0.18.8.bb
@@ -63,12 +63,13 @@ CONF_FILE = "${sysconfdir}/aide.conf"
 FILES:${PN} += "${libdir}/${PN} ${sysconfdir}/aide.conf"
 
 pkg_postinst_ontarget:${PN} () {
-    if [ ${AIDE_SCAN_POSTINIT} ]; then
-        ${bindir}/aide -i
-    fi
-    if [ ${AIDE_RESCAN_POSTINIT}  && -e ${libdir}/aide/aide.db.gz ]; then
-        ${bindir}/aide -C
-    fi
+    if [ "${AIDE_SCAN_POSTINIT}" = "1" ]; then
+          ${bindir}/aide -i
+      fi
+      if [ "${AIDE_RESCAN_POSTINIT}" = "1" ] && [ -e ${libdir}/aide/aide.db.gz ]; then
+          ${bindir}/aide -C
+      fi
+
 }
 
 RDEPENDS:${PN} = "bison libpcre"
-- 
2.43.0


