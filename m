Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA8C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 03:20:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.3435.1742268009685301263
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 20:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=51723feb02=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1w20q020345
	for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 20:20:09 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d92jtgku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 20:20:09 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 17 Mar 2025 20:20:08 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 17 Mar 2025 20:20:06 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Date: Tue, 18 Mar 2025 03:20:01 +0000
Message-ID: <20250318032001.2031160-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QdRmvtbv c=1 sm=1 tr=0 ts=67d8e669 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=KuCMGVAfJcUA:10 a=Vs1iUdzkB0EA:10 a=t7CeM3EgAAAA:8 a=-MY5uQsLp-xdYS-G4fAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: C-Ng3bWDw-4_wlraSnvKiSenMLMH32eh
X-Proofpoint-GUID: C-Ng3bWDw-4_wlraSnvKiSenMLMH32eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=728 impostorscore=0
 mlxscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 03:20:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1212

From: Soumya Sambu <soumya.sambu@windriver.com>

The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
--target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:

error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".

Updated target configuration to resolve this.

Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
defining the linker for Rust.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
 recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
 recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
 create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend

diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index cc00053..2d91d68 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -146,6 +146,9 @@ python do_configure() {
     # harness are debuggable just from logfiles
     config.set("rust", "verbose-tests", e(True))
 
+    # Override default linker cc.
+    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
+
     # [build]
     config.add_section("build")
     config.set("build", "submodules", e(False))
diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extended/mozjs/mozjs-78_%.bbappend
new file mode 100644
index 0000000..8e8c24a
--- /dev/null
+++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
@@ -0,0 +1,14 @@
+EXTRA_OECONF = " \
+    --target=${RUST_TARGET_SYS} \
+    --host=${BUILD_SYS} \
+    --prefix=${prefix} \
+    --libdir=${libdir} \
+    --x-includes=${STAGING_INCDIR} \
+    --x-libraries=${STAGING_LIBDIR} \
+    --without-system-icu \
+    --disable-tests --disable-strip --disable-optimize \
+    --disable-jemalloc \
+    --with-system-icu \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
+    ${JIT} \
+"
diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extended/mozjs/mozjs-91_%.bbappend
new file mode 100644
index 0000000..c0214b0
--- /dev/null
+++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
@@ -0,0 +1,13 @@
+do_configure() {
+        cd ${B}
+        python3 ${S}/configure.py \
+        --enable-project=js \
+        --target=${RUST_HOST_SYS} \
+        --host=${BUILD_SYS} \
+        --prefix=${prefix} \
+        --libdir=${libdir} \
+        --disable-jemalloc \
+        --disable-strip \
+        ${JIT} \
+        ${ICU}
+}
-- 
2.40.0


