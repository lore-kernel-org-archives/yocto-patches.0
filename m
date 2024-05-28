Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A6C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 05:46:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15471.1716875172161670268
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 22:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S50UQ9022039
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:46:12 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90ae47-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:46:11 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 22:46:11 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 22:46:10 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH] recipes: WORKDIR -> UNPACKDIR transition
Date: Tue, 28 May 2024 13:46:09 +0800
Message-ID: <20240528054609.4111089-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rCNqfRGEFYs5Ahbtg5mucfAVnXI6d1Pv
X-Proofpoint-GUID: rCNqfRGEFYs5Ahbtg5mucfAVnXI6d1Pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280041
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 05:46:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/233

From: Changqing Li <changqing.li@windriver.com>

* WORKDIR -> UNPACKDIR transition
* Switch away from S = WORKDIR

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb           | 3 ++-
 recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb | 8 ++++----
 recipes-framework/tensorflow/tensorflow_2.16.1.bb      | 8 ++++----
 recipes-model/googlecodelabs/tensorflow-for-poets_2.bb | 2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index c930054..20f6c55 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
@@ -24,7 +24,8 @@ DEPENDS = "coreutils-native \
            openjdk-11-native \
           "
 
-S="${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit bazel-base
 
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb b/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
index dd3ef0b..f6666e5 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
@@ -29,11 +29,11 @@ RDEPENDS:${PN} += " \
 
 do_configure:append () {
     mkdir -p ${S}/third_party/toolchains/yocto/
-    sed "s#%%CPU%%#${BAZEL_TARGET_CPU}#g" ${WORKDIR}/BUILD.in  > ${S}/third_party/toolchains/yocto/BUILD
+    sed "s#%%CPU%%#${BAZEL_TARGET_CPU}#g" ${UNPACKDIR}/BUILD.in  > ${S}/third_party/toolchains/yocto/BUILD
     chmod 644 ${S}/third_party/toolchains/yocto/BUILD
-    install -m 644 ${WORKDIR}/cc_config.bzl.tpl ${S}/third_party/toolchains/yocto/
-    install -m 644 ${WORKDIR}/yocto_compiler_configure.bzl ${S}/third_party/toolchains/yocto/
-    install -m 644 ${WORKDIR}/BUILD.yocto_compiler ${S}
+    install -m 644 ${UNPACKDIR}/cc_config.bzl.tpl ${S}/third_party/toolchains/yocto/
+    install -m 644 ${UNPACKDIR}/yocto_compiler_configure.bzl ${S}/third_party/toolchains/yocto/
+    install -m 644 ${UNPACKDIR}/BUILD.yocto_compiler ${S}
 
     CT_NAME=$(echo ${HOST_PREFIX} | rev | cut -c 2- | rev)
     SED_COMMAND="s#%%CT_NAME%%#${CT_NAME}#g"
diff --git a/recipes-framework/tensorflow/tensorflow_2.16.1.bb b/recipes-framework/tensorflow/tensorflow_2.16.1.bb
index 713c9c0..45e4a95 100644
--- a/recipes-framework/tensorflow/tensorflow_2.16.1.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.16.1.bb
@@ -50,11 +50,11 @@ RDEPENDS:python3-tensorflow += " \
 
 do_configure:append () {
     mkdir -p ${S}/third_party/toolchains/yocto/
-    sed "s#%%CPU%%#${BAZEL_TARGET_CPU}#g" ${WORKDIR}/BUILD.in  > ${S}/third_party/toolchains/yocto/BUILD
+    sed "s#%%CPU%%#${BAZEL_TARGET_CPU}#g" ${UNPACKDIR}/BUILD.in  > ${S}/third_party/toolchains/yocto/BUILD
     chmod 644 ${S}/third_party/toolchains/yocto/BUILD
-    install -m 644 ${WORKDIR}/cc_config.bzl.tpl ${S}/third_party/toolchains/yocto/
-    install -m 644 ${WORKDIR}/yocto_compiler_configure.bzl ${S}/third_party/toolchains/yocto/
-    install -m 644 ${WORKDIR}/BUILD.yocto_compiler ${S}
+    install -m 644 ${UNPACKDIR}/cc_config.bzl.tpl ${S}/third_party/toolchains/yocto/
+    install -m 644 ${UNPACKDIR}/yocto_compiler_configure.bzl ${S}/third_party/toolchains/yocto/
+    install -m 644 ${UNPACKDIR}/BUILD.yocto_compiler ${S}
 
     CT_NAME=$(echo ${HOST_PREFIX} | rev | cut -c 2- | rev)
     SED_COMMAND="s#%%CT_NAME%%#${CT_NAME}#g"
diff --git a/recipes-model/googlecodelabs/tensorflow-for-poets_2.bb b/recipes-model/googlecodelabs/tensorflow-for-poets_2.bb
index b3eb21f..ae41bc8 100644
--- a/recipes-model/googlecodelabs/tensorflow-for-poets_2.bb
+++ b/recipes-model/googlecodelabs/tensorflow-for-poets_2.bb
@@ -88,7 +88,7 @@ do_install () {
     for file in retrain.py label_image.py __init__.py; do
         install -m 755 ${S}/scripts/$file ${D}/${PYTHON_SITEPACKAGES_DIR}/tensorflow_for_poets
     done
-    install -m 755 ${WORKDIR}/label_image_lite.py ${D}/${PYTHON_SITEPACKAGES_DIR}/tensorflow_for_poets
+    install -m 755 ${UNPACKDIR}/label_image_lite.py ${D}/${PYTHON_SITEPACKAGES_DIR}/tensorflow_for_poets
 
     install -d ${D}${datadir}/label_image
     install -m 644 ${S}/tf_files/*.pb ${D}${datadir}/label_image
-- 
2.25.1


