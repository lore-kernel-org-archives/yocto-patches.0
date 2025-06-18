Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4127C71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 13:29:46 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7394.1750253385184093334
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Jun 2025 06:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8264e32d1b=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAlBRG024055
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:44 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 478xa1mmyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:44 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 18 Jun 2025 06:29:42 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 18 Jun 2025 06:29:40 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/2] python3-awscrt: fix unsafe include path error during cross-compilation
Date: Wed, 18 Jun 2025 18:59:36 +0530
Message-ID: <20250618132937.4119240-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PuiTbxM3 c=1 sm=1 tr=0 ts=6852bf48 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=KuCMGVAfJcUA:10 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=9xJKYEJgGxaB0NQWSqwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: wehUquvCSNa8AXPst8OVNgRVBkVGPXuT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDExNCBTYWx0ZWRfXz4qRtb8/uVKg qA3yG2pE4dm7Incn3dTf8PVPVw2AHHQOfy7gLI+bDYpraGT8CtT0ocpqL08PrAKdY0wJ+ZMbNA4 dDA5j90N4BAcLP8oOv8RYfh0B439B460atlTk4IfPdp8y3fd0+UCjxpKqmN4C3E9wlIdKVa3Jjb
 kQf7elBNmcDQUnvu9nbN0v8+Wh6hdo5TIETMetR5K8YBvHKaB73KJ9Vel1GSVGLHMVZX0wL/uKE o1QpZc359PtjSI7oHxnv9VlLmu2I3DwkTrbNXIQZMcMUDgSVgg1lbeZ5DIgScY78ElPuKrPXV6t Dac9WZZ4PCUViroPopISPpshSQpDxYnEY6S27R1MmY5FEyaDtXHuVNtWh4cjdI2oYFWLMNqBgro
 VL3SkpzlOnKJdFfvo7g8MBS7D0iz46pT/B/BKdKMSrtRpmLak3lhqmbChE/Mm/JEPxoEUy3/
X-Proofpoint-GUID: wehUquvCSNa8AXPst8OVNgRVBkVGPXuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=776 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506180114
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1659

From: Soumya Sambu <soumya.sambu@windriver.com>

After meta-lts-mixins introduced a newer setuptools, python3-awscrt is failing
to build due to unsafe include path

cc1: error: include location "/usr/include/python3.10" is unsafe for cross-compilation [-Werror=poison-system-directories]

The issue is resolved by explicitly forcing setuptools to use distutils

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 conf/layer.conf                                                | 3 ++-
 .../iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend

diff --git a/conf/layer.conf b/conf/layer.conf
index 4fe4ec4..280393d 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -28,7 +28,8 @@ BBMASK:append = " meta/recipes-devtools/python/python3-setuptools-rust-native_%"
 
 BBFILES_DYNAMIC += " \
     meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bbappend \
-    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend"
+    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend \
+    iot-cloud:${LAYERDIR}/dynamic-layers/iot-cloud/recipes-*/*/*.bbappend"
 
 # These are in bitbake.conf in langdale and up, adding them here to make
 # using the layer more turn-key seems reasonable.
diff --git a/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend
new file mode 100644
index 0000000..bd0b910
--- /dev/null
+++ b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend
@@ -0,0 +1,3 @@
+do_compile:prepend() {
+    export SETUPTOOLS_USE_DISTUTILS=stdlib
+}
-- 
2.40.0


