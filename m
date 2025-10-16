Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8604CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 08:20:30 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.3314.1760602828360749896
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 01:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ffsMfW1W;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=238448c8df=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G4KkBo3790124;
	Thu, 16 Oct 2025 01:20:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=YYuTVoEEu
	5/uw3Ifkj9azc4VbZ2k23sA8BQzYXxftk4=; b=ffsMfW1WLQI9F/2caCbI0ajt2
	G5cCi17Sw8ua7w74fZimNzIJuxeBCZAO0FWT86Sf+C93zBmmioFppDpwaL5BMz8b
	+CckwxO5fA3xJ1TFJTTldqNp/+Lj9TMU+BWPm6gyfr6O/ofu5/FyQ1qct1uKTAtn
	dSxgUBuSjjQAUsD4rfKEwYkc8XXot/IOp1P6VhmjItTYPdgvGT/WPp965Rl1Jt1R
	lYDqEbnjC7rBt+G73v+7ew+ncE6WQGwrieF117ZRy3aJ/x9u1XoWQkOon8p6cYC4
	UA0NiVEi9i3zKhywlXFjQnMOViRAqUVMNj/YTiLwT/ThcNVJorueqnm42OSgQ==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qjh1nsvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Oct 2025 01:20:26 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Thu, 16 Oct 2025 01:20:25 -0700
Received: from pek-lpg-core6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Thu, 16 Oct 2025 01:20:25 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw][PATCH] mingw-w64.inc: replace WORKDIR with UNPACKDIR
Date: Thu, 16 Oct 2025 16:20:24 +0800
Message-ID: <20251016082024.54528-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA2NCBTYWx0ZWRfXwRGzLwLegXoj
 GSxZE4u4k+wXgPtxofx8IJyeA400jHLb44pe3U/8BnKZWjKFqwnu3M4EBEYBhz9yXd9JE6Cngzw
 mAhFX5bstbegf8rDE1w99Mtrj1TtNUOKj/EVjExKR738YOL3fPJy91q0yTfBZxhJIuFXgdXSQ44
 9ox0aMTsT+6waOH8NbURQ7zzScRJwlkvhY8rAWJsUApJcbrvjrjSlWCXtvAnruuhlcbghPKTljy
 fpYrj5Q7tyBmQyHMd2eeM9ElS3J96QklfLiXM/+nKeVldddk6LsJAXuXMLMxNsZ1HSrSXKYyZxI
 iXfoRb51Fy4f23SJyKTVXQIQQMKaLjor4XFrVnmEN4Zd8XSuBoLg385r7jpOAzRl293u7bV3Wif
 xdo2lcG9PJQ67EvJlet+tbqsr7Qhhg==
X-Proofpoint-GUID: ibw_KzJnaR6yNoE9dm7mxRTOem5JscC9
X-Proofpoint-ORIG-GUID: ibw_KzJnaR6yNoE9dm7mxRTOem5JscC9
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=68f0aaca cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=viYYBFxVdqyEtiWg3bAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510160064
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 08:20:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2310

From: Changqing Li <changqing.li@windriver.com>

Sources already moved under UNPACKDIR, fix failure:
ERROR: nativesdk-mingw-w64-headers-12.0.0-r0 do_populate_lic: QA Issue:
nativesdk-mingw-w64-headers: LIC_FILES_CHKSUM points to an invalid file:
/build/tmp/work/x86_64-nativesdk-mingw32-w64-mingw32/nativesdk-mingw-w64-headers/12.0.0/mingw-w64-v12.0.0/COPYING
[license-checksum]

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
index 97315f4..a24e96c 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -1,5 +1,5 @@
 LICENSE = "ZPL-2.1"
-LIC_FILES_CHKSUM = "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
 
 COMPATIBLE_HOST = ".*-mingw.*"
 
-- 
2.34.1


