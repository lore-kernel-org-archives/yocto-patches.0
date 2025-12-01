Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C8D111A8
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 07:03:28 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15649.1764572603788393109
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 30 Nov 2025 23:03:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=swu8e86S;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4430a8f5e9=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B14trqP3279537
	for <yocto-patches@lists.yoctoproject.org>; Mon, 1 Dec 2025 07:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=9U2RLqNWrxcAS42UvJ4R
	M4bHWoX376tTha9AtKDyNvQ=; b=swu8e86SuRMgobNP4i5vJU7LV/boSRvRk49G
	+Ug3VTI9vH/M1fqVA4lQCOnv/Ma4CFJzfpDf2acm2/vgHPEgo++9uq0gCBhPWtMZ
	byIgz8fTr7YDGlYW9LUqPDuUvGf2e0M4Lv0qHPKDMynf7CFEGLhNQrtyAMORcyDz
	jxsZL/xJirgNjjvRqZ7HZ6323euQozn1LFLnjN8bJcKQK+tN+1rYeEkt+6W1BgwQ
	V3FQzxxklwFJI75J9hIN+EpgHjfaXO0v8ceDrQQ1h0ArJ4+njdQbIYAk76kD6TXR
	pINVsYCTxZt4+bMD4C2i8lferlfofEvM7MTMR/F2aVsCBFb2QA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aqp21sjm1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Dec 2025 07:03:22 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sun, 30 Nov 2025 23:03:21 -0800
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sun, 30 Nov 2025 23:03:21 -0800
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] openscap: switch to libpcre2
Date: Mon, 1 Dec 2025 15:03:20 +0800
Message-ID: <20251201070320.361249-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: POMLZxbjZ9r3ZcRPBp_vgLEsiZn6VM1k
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=692d3dba cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=5B1P-IGBAAAA:8
 a=t7CeM3EgAAAA:8 a=NZW13PFlGe4wxn_J1X4A:9 a=PcRJL-ISiCqaXG01ICqs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA1NSBTYWx0ZWRfX8Sua8gOLQnKP
 apxEFOGql4Vgka/8YIY11hCOMb02PezH6BeBeob3ZmmenDNDuaPuLUvCasGLAqF+hxFe/L8twVF
 972yjeyWpTc3xdyOstjk4VIiKFWm2NHNcq0peLvyg6hMnNqP/PDk2aJ7k74i4zbcgtercAlG042
 TPE1kY5acbCdQUJi515VKFHdZZog6glkbSnPar2DuqezAc2td/s1EmqOqzJnPAcj7eyvdmQz/HU
 T7B2osVqeM93Sk4CzkU9/gxOk3ujiiapibM3QUZig9FjdKuw0VyKj/KUGTXphQcmTSk/rBzoZD9
 U3kLS01qf4A0DApdvU3LJx1BZOXwqPoO0Qe0GwHN6sZaTzdgdfJZpS3BYfMmiYuHh6Q6hMyLmzB
 RvAs+2ylG3mtmp7d2J4Q2rVVkIIKJQ==
X-Proofpoint-ORIG-GUID: POMLZxbjZ9r3ZcRPBp_vgLEsiZn6VM1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010055
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Dec 2025 07:03:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2731

The openscap added PCRE2 library since 2023 [1]

[1] https://github.com/OpenSCAP/openscap/commit/cd1d4289581fa15527e516ddd07be814af7cba55

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-compliance/openscap/openscap_1.4.1.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-compliance/openscap/openscap_1.4.1.bb
index 3e5f00a..1820db5 100644
--- a/recipes-compliance/openscap/openscap_1.4.1.bb
+++ b/recipes-compliance/openscap/openscap_1.4.1.bb
@@ -6,8 +6,8 @@ HOME_URL = "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=fbc093901857fcd118f065f900982c24"
 LICENSE = "LGPL-2.1-only"
 
-DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swig libpcre  xmlsec1"
-DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
+DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swig libpcre2  xmlsec1"
+DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre2-native xmlsec1-native"
 
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
-- 
2.34.1


