Return-Path: <Haitao.Liu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53BFF886C
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 08:51:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8520.1777366288415457727
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 01:51:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=EGf09nSF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85783cf450=haitao.liu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S4D1r33212938
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 08:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=AgGYTabNZ4RZKHHzsm8J
	4Po6lgwxnwWNVuVeNOC5zQU=; b=EGf09nSFJdxb+oXBYB/E3rqjaXo6l0Ld4kRy
	w4VUJb9hkTEmJ3Sm2a+eD7YhVEBo6RzHAr/qWJWWOBP7T9kMvvww2n6XxGhx2aUk
	hrKu/oO7ItVLbNV79Cbhtoj82rRdRXO3TfzoJyGRSKBCdZhIiesOiFo2m0AybGOa
	vxYwxVzWE86Uow8vNrcryT6kUXHKYnGXndflnCtEyY8Dhes1edNXBBhhlmP+LKjR
	phUX/fcMFFOahJEw0BSTwUEQ4B+GeeDBKuhsfjmFwK/UssjHFCETYcjYUZ4ToybK
	V2h67U6VlZ76vuTclz8tuDR/5jqdWkC70N9P2k98f/VSFkGGmQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6u612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 08:51:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 28 Apr 2026 01:51:25 -0700
Received: from pek-starlingx-w1.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 28 Apr 2026 01:51:25 -0700
From: Haitao Liu <haitao.liu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches][meta-security][PATCH] libmspack: clean up recipe
Date: Tue, 28 Apr 2026 16:51:24 +0800
Message-ID: <20260428085124.3871627-1-haitao.liu@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m3F_fk1h7TKZFnUpwOnUzCCBEFyn-Uos
X-Proofpoint-GUID: m3F_fk1h7TKZFnUpwOnUzCCBEFyn-Uos
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69f0750f cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Rqg5FfbeET4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=vlfEKXvPAAAA:8
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=XEZJw4vCc9T1b_MJWugA:9 a=ZXulRonScM0A:10
 a=0lgtpPvCYYIA:10 a=PnTDuSQR5rMvcWp5Oz0h:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MCBTYWx0ZWRfX+ZPu06wY4PKB
 vKUqCN1ilPQyFXsgHRUT7f+28v0IrvLt6AC0QLhsv6MT9YVqc9HXRkxdhhVL+3n2vF9/d+vnp/0
 AzlGJL6tn35aNIRDMKpide5siLskF4kZIToye/7VupvoV8W0oaSVPMtpHNZ4EKT3TMIrCnUNH0S
 ZA3VolYj/HhMMcehgYs/8d6cOw83CYTd22dxP5etN9ZAosOAhQi9Z/wZcZUFI8vatNSjDHAHzk5
 h/uPv1jP8hpo/KKzykInjP3thjgjnIHwzLMV/nbLyEg+5GSGQ/mz1YclfN8Hn6Sa0p4GpgmJ15M
 SKrALRqXzWw6X/7/3oZC7NVWYb2XaTshYPzOChulxrwvC65fVdCrt8G6ctliRX6+uJIjoVkND95
 2iNsBE2r9hUol0M2/eTCLI8Lh02YG7a7mcYBjLK/+pTHchRbF2jz04sAS3lhgtgvhLfIO+ZljOz
 P2R/2yMfe6z4xC0oQ/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 08:51:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3863

 - Remove empty DEPENDS assignment (no build dependencies needed)
 - Remove duplicate 'inherit autotools'

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
---
 recipes-security/libmspack/libmspack_1.11.bb | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-security/libmspack/libmspack_1.11.bb b/recipes-security/libmspack/libmspack_1.11.bb
index 7203dee..3642128 100644
--- a/recipes-security/libmspack/libmspack_1.11.bb
+++ b/recipes-security/libmspack/libmspack_1.11.bb
@@ -2,15 +2,12 @@ SUMMARY = "A library for Microsoft compression formats"
 HOMEPAGE = "http://www.cabextract.org.uk/libmspack/"
 SECTION = "lib"
 LICENSE = "LGPL-2.1-only"
-DEPENDS = ""
 
 LIC_FILES_CHKSUM = "file://COPYING.LIB;beginline=1;endline=2;md5=5b1fd1f66ef926b3c8a5bb00a72a28dd"
 
 SRCREV = "305907723a4e7ab2018e58040059ffb5e77db837"
 SRC_URI = "git://github.com/kyz/libmspack.git;branch=master;protocol=https"
 
-inherit autotools
-
 S = "${UNPACKDIR}/${BP}/${BPN}"
 
 inherit autotools
-- 
2.43.0


