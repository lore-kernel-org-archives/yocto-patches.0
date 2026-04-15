Return-Path: <Jiaying.Song.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BBFA0C3B
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 06:53:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13145.1776235993283358482
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 23:53:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lftwU0i2;
 spf=none, err=permanent DNS error (domain: ala-lpggp9.wrs.com, ip: 205.220.166.238, mailfrom: prvs=8565083339=jsong-cn@ala-lpggp9.wrs.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4lXU22672674
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 23:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=kKMlwxzH1
	yO4MjhPPD8Rf/FByG8ZyPOJH29Ah4k71eA=; b=lftwU0i2ecBb79Nkahr982NM2
	1Sjj+LxAvz1g+Hbu2NcXZSQAiAxYQvgytuf6dYcMz9ijx68mCZiiX4o2nK5o0raF
	6l4tjMqtU/30Qq1Q4/r1r6jgYL37QlvH4qZHNVI2HeFovoXBvCQlLRLJBVxdTszV
	rIOAkcS9BwPehgNFUOySIv1I+gIWkbNnoyzf4u2LNq4EXxNSg+1OHJjOwqkPd/hp
	OOtvLOCxIPewDVxuSvV1UWlPXxR8IlQ2MDDtsfSjDZDcTAM53ca4vYGKkTpEpIbY
	JLlvPQ5H8djgLyfX5wckYYCeJ6I71cx2W/l372gF7VyCuvCN9hPrGtzuwjNZw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh87msp1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 23:53:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 14 Apr 2026 23:53:11 -0700
Received: from ala-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 14 Apr 2026 23:53:11 -0700
Received: by ala-lpggp9.wrs.com (Postfix, from userid 1762369440)
	id BE54C800CA1; Tue, 14 Apr 2026 23:53:11 -0700 (PDT)
From: Jiaying Song <Jiaying.Song.CN@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Jiaying Song <Jiaying.Song.CN@windriver.com>
Subject: [meta-security][PATCH] crowdsec: Fix recipe to match upstream source layout
Date: Tue, 14 Apr 2026 23:53:05 -0700
Message-ID: <20260415065305.2608607-1-Jiaying.Song.CN@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2MiBTYWx0ZWRfX/NABlzlh2o9v
 tLwweianTKJz8Bs1vuGkGp9TVDJDLK1PFd4qMP82WllfMGwjtnMrvDReDYXgbVR4F75cGrzpOon
 m1M59jmSTGUB2cC07p3H2bU5FazLhcnk2arCg2Ir1L6GtNHj5dQWWhgWpFjJfmDIxLoG+CEXDQm
 340WhIbMmby7R1NhrO0Yzn4aPgouJtzEj4asIOWho++WMybVP7jGRlyb04g5E2iSFHz+yF21Yqs
 Rq9eBGZ7lKfvfRy2E7vshH2eXo5qoxpSDOKIm89lJz16AxxQQlVVEFiSs3KOPDqGFgoLBrlRuyw
 yVm9TIl1FXOz0kJ+VIASI1d6Ig2CGUJV6GdPRPg2k/3OPYf+8qcb7Hz56GsUnCyavSNVWLRiZXU
 vGxEkoDuy/UBclWN2tPdX2Rrpr5/cHng4vD+Mj+BZZpBBg1XabD07iASGISISRzkUnvBTmdFw5N
 AE1Yzz9ny7pReoJvzmw==
X-Proofpoint-ORIG-GUID: SkbTf6EVj3LaXZdxxy29yOeUY0ZP57GY
X-Authority-Analysis: v=2.4 cv=GupyPE1C c=1 sm=1 tr=0 ts=69df35d8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8
 a=iTNWgs4gTr2Q6GHRRsgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: SkbTf6EVj3LaXZdxxy29yOeUY0ZP57GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150062
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 06:53:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3705

The LICENSE file is in the repository root, not src/import/.
The Makefile is also in the root, so do_compile should cd to ${S}.
Fix do_install_ typo to do_install so the task actually runs.

Signed-off-by: Jiaying Song <Jiaying.Song.CN@windriver.com>
---
 recipes-ids/crowdsec/crowdsec_1.1.1.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/crowdsec/crowdsec_1.1.1.bb b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
index fa13e9d..c7fe3dd 100644
--- a/recipes-ids/crowdsec/crowdsec_1.1.1.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
@@ -1,7 +1,7 @@
 SUMMARY = "CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network."
 
 LICENSE = "MIT"
-LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=105e75b680b2ab82fa5718661b41f3bf"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=105e75b680b2ab82fa5718661b41f3bf"
 
 SRC_URI = "git://github.com/crowdsecurity/crowdsec.git;branch=master;protocol=https"
 SRCREV = "73e0bbaf93070f4a640eb5a22212b5dcf26699de"
@@ -24,11 +24,11 @@ do_compile() {
     export CGO_CFLAGS="${BUILDSDK_CFLAGS} --sysroot=${STAGING_DIR_TARGET}"
     export CGO_LDFLAGS="${BUILDSDK_LDFLAGS} --sysroot=${STAGING_DIR_TARGET}"
 
-    cd ${S}/src/import
+    cd ${S}
     oe_runmake release
 }
 
-do_install_ () {
+do_install () {
    chmod +x -R --silent ${B}/pkg
 }
 
-- 
2.49.0


