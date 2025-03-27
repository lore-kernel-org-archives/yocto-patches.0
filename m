Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0948EC3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 11:39:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.47890.1743075538682255881
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 04:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5181479d3f=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7C0O2029593
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 11:38:57 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68nuaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 11:38:57 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 27 Mar 2025 04:38:56 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 27 Mar 2025 04:38:55 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 2/2] python3-yamlpath: upgrade 3.8.0 -> 3.8.2
Date: Thu, 27 Mar 2025 19:38:54 +0800
Message-ID: <20250327113854.1393190-2-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327113854.1393190-1-changqing.li@windriver.com>
References: <20250327113854.1393190-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PNGRom-trTN15gcACVplSQT_KHBMmsoK
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e538d1 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=CckQENj0AAAA:8 a=t7CeM3EgAAAA:8 a=HP5yY2Pn9Vn8AiXgzqQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: PNGRom-trTN15gcACVplSQT_KHBMmsoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 11:39:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1265

From: Changqing Li <changqing.li@windriver.com>

Release note:
Enhancements:
    The MergerConfig class now accepts overrides for config values as "keys" and
    "rules" keyword arguments to the constructor.
    Credit and my thanks go to https://github.com/leviem1!
BREAKING CHANGES:
    Support for Python 3.6 has been dropped. This is forced by incompatibilities
    discovered with the latest version of pytest and because dependencies like
    dateutil and ruamel-yaml-clib no longer support Python 3.6. Support for
    Python 3.7 is tepid. While pytest is still working with Python 3.7, other
    dependencies are no longer supporting Python 3.7; however, the extensive
    tests for yamlpath show no issues with them, so far. For now, Python 3.12
    support is pending, waiting for the dateutil library to resolve a
    DeprecationWarning regarding its use of datetime.datetime.utcfromtimestamp().

Refer:
https://pypi.org/project/yamlpath/3.8.2/

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 ...python3-yamlpath_3.8.0.bb => python3-yamlpath_3.8.2.bb} | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
 rename dynamic-layers/meta-python/recipes-devtools/python/{python3-yamlpath_3.8.0.bb => python3-yamlpath_3.8.2.bb} (59%)

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
similarity index 59%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb
rename to dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
index 8d5f33e..e2d95ae 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
@@ -2,7 +2,7 @@ DESCRIPTION="YAML Path and Command-Line Tools"
 LICENSE = "ISC"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=5abda174c5040dd12ed2b225e3a096f0"
 
-SRC_URI[sha256sum] = "81d5b8baba60c255b519ccd31a691f9bc064223ff196709d41119bde81bba49e"
+SRC_URI[sha256sum] = "4f30cc214b5085d4b0e7756e06c3af3ae589ecde9650d2ada7e1d345ec4fda4f"
 
 PYPI_PACKAGE = "yamlpath"
 
@@ -11,3 +11,8 @@ inherit pypi python_setuptools_build_meta
 DEPENDS += " \
     python3-setuptools-scm-native \
 "
+RDEPENDS:${PN} += "\
+   python3-datetime \
+   python3-ruamel-yaml \
+   python3-dateutil \
+"
-- 
2.34.1


