Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2607103A984
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13681.1774405046635726767
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qJF0pQtZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJu3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=zY35fvLGK5sTwM1tb8A1VHR+VeUnMkpL76LzjmgG6kY=; b=qJF0pQtZE/G4
	DtqkgsxmsJ4aZVJQXli9Y7zHlFSqGHdZLgymA0o/RzFNYPu+COPnOgu2Ed0tRXBE
	pHUOqc0gp5cnmm5yj7sMR3fPn1xgXAed71X6jdqxiiEeTrDAVKIyU/6xGy36yJJk
	ier7wSgFRvJkzoKZ1hZghyL4YYzZMUS6G3mjy/PIOvctfhGCd2Np2bL06bbPfYMS
	FZ9pCe/1lMvYgMsurJmN5cu7sOQ4REb/Kd+VUEzPMOoN2voKYxytSihNGwax3bjY
	ET1kSZssQCDHIoq28lC/oRtYFbd2oOMOKc0iitGnQyYAmRJmSOKYdTbfBHx2ePvd
	y4fMP369uA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84du8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:25 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:24 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:24 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 4/14] python3-optree: add recipe 0.19.0
Date: Wed, 25 Mar 2026 10:17:09 +0800
Message-ID: <20260325021719.1526525-5-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JC7r65kxMXnSww_ZzDD4hhYQQq0XH3LU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfXwZZ6PXGCqg6F
 cIKdrwb9bD2jydhn0y02cmsLLHzyZBu3qbALNDLl3K+UyEMYAgxvEb7cm7WPZsiwPg7OQifNVwT
 u2XFonI6k5Jyh6bA/i4C9pmUU2kwJY2wS+7d1SE7WSYAcqzh1D0i/7L4pfYLK/50gtHC1NN78TV
 7EON0RqcZ4txQZqy9ihpoz6S8VjyqvNPAVIObMt2JixON6UT/facfl676CZZ+l1pklYCPJsbomJ
 E3PBALoKU9wxtmxLDjF3qnwcqo3WaOV+dvTCXnhjLIzjyrPw9wRqgTIBn0pIqMPialAAcQwsoOc
 Eg87XQnafhRVhklssW4mswV7qrY1xdoqioKPbQZc4y2oGwBqeQUKSikOTzFtzIhX/0gGAog4Mt1
 AHEwWl4RdVxIf03cCuRspWWEUiZ2P+3pMOH+5XK1CUSK34uQGIV8QYUuhzvXO4R8kGSKrKiBZLA
 1ZUq9T73EcKZSg0SO8Q==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b5 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=oqjUEpmZWFyIQUjMQAEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: JC7r65kxMXnSww_ZzDD4hhYQQq0XH3LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3540

It is required by tensorflow and keras

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 .../python/python3-optree_0.19.0.bb           | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 recipes-devtools/python/python3-optree_0.19.0.bb

diff --git a/recipes-devtools/python/python3-optree_0.19.0.bb b/recipes-devtools/python/python3-optree_0.19.0.bb
new file mode 100644
index 0000000..511a339
--- /dev/null
+++ b/recipes-devtools/python/python3-optree_0.19.0.bb
@@ -0,0 +1,21 @@
+SUMMARY = "Optimized PyTree Utilities."
+HOMEPAGE = "https://github.com/metaopt/optree"
+SECTION = "devel/python"
+LICENSE = "Apache-2.0"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=936b16b5b0a197fc3bb914f69ebc8e31"
+
+SRC_URI[sha256sum] = "bc1991a948590756409e76be4e29efd4a487a185056d35db6c67619c19ea27a1"
+
+inherit pypi python_setuptools_build_meta
+
+DEPENDS += " \
+    python3-pybind11-native \
+"
+
+UPSTREAM_CHECK_PYPI_PACKAGE = "optree"
+
+INSANE_SKIP:${PN} += " \
+    already-stripped \
+"
+
+BBCLASSEXTEND = "native"
-- 
2.34.1


