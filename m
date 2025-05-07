Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA5C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 06:11:41 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.1879.1746598299915031395
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 May 2025 23:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7222da6ce0=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5474SpPk031888
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 May 2025 23:11:39 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3byg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 May 2025 23:11:39 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 6 May 2025 23:11:38 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 6 May 2025 23:11:36 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <Randy.MacLeod@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Date: Wed, 7 May 2025 06:11:32 +0000
Message-ID: <20250507061132.838447-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EbeFfo7m6i87vaDReOC1CKX-RKuXqS_J
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681af99b cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=KuCMGVAfJcUA:10 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=k-42gJp3AAAA:8 a=owsoTai2-jRsMManM9EA:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: EbeFfo7m6i87vaDReOC1CKX-RKuXqS_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA1NiBTYWx0ZWRfX6Ag2ceVbVSXG Qv022eFCmpl7WOxt/VSZxHJ+4+YJG7ug21eL4BrkwRChYI+lc82SsIsHbe7Mze5Gd48onpfeqdC qe+urNnU04EXA9USV/3pCj95EEpdo0d9ApQFkriUBlqEF+h8RN3paE0ZhJDmdU1UJwQF5FwUUvi
 8XFP67UB4cBI0P8LDNXZIi135F+9wHilCa/kDa5tbEjLEy7ycUgeROuWJq9ztgfUZ6MpCVkSKWS x+sZLr1ikOjY0SxICQNwknLRWHu9err4vyR0ZP+UzNE0+bgv+JTYwpIvKw2OJZtd6KKFhLxkHxV OZGtIwaUeRudT6UdE+kW/5SeD4XFoxyBXoXGPu8lhDUrYlLOOqdJlLiDW1/3glEfyKrsgPJQJrC
 1wUXM4hhzT1f36PvOQh3Zl7N8h45JRJDmLVJahFvLLBXHbFxTuIKM0FO9S3KRI0bG5Zz1fxw
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxlogscore=911 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505070056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 06:11:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1521

From: Soumya Sambu <soumya.sambu@windriver.com>

The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
--target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:

error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".

Updated target configuration to resolve this.

Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
defining the linker for Rust.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 README.md                                          |  2 +-
 conf/layer.conf                                    |  4 ++++
 .../recipes-devtools/rust/rust_1.85.1.bbappend     |  7 +++++++
 .../recipes-extended/mozjs/mozjs-78_%.bbappend     | 14 ++++++++++++++
 .../recipes-extended/mozjs/mozjs-91_%.bbappend     | 13 +++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
 create mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
 create mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend

diff --git a/README.md b/README.md
index 482f0cd..f05accf 100644
--- a/README.md
+++ b/README.md
@@ -132,4 +132,4 @@ Layer maintainers:
 Scott Murray <scott.murray@konsulko.com>
 
 Dynamic layer support maintainers:
-TBD
+Soumya Sambu <soumya.sambu@windriver.com>
diff --git a/conf/layer.conf b/conf/layer.conf
index 281eeca..4fe4ec4 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -26,6 +26,10 @@ BBMASK:append = " meta/recipes-devtools/cargo/ meta/recipes-devtools/rust/ meta/
 # the newer BBCLASSEXTEND version that we carry.
 BBMASK:append = " meta/recipes-devtools/python/python3-setuptools-rust-native_%"
 
+BBFILES_DYNAMIC += " \
+    meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bbappend \
+    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend"
+
 # These are in bitbake.conf in langdale and up, adding them here to make
 # using the layer more turn-key seems reasonable.
 BB_BASEHASH_IGNORE_VARS:append = " RUST_BUILD_SYS RUST_HOST_SYS RUST_TARGET_SYS"
diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
new file mode 100644
index 0000000..9b09f9e
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
@@ -0,0 +1,7 @@
+python do_configure:append() {
+    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
+
+    with open("config.toml", "w") as f:
+        f.write("change-id = 116881\n\n")
+        config.write(f)
+}
diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
new file mode 100644
index 0000000..8e8c24a
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
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
diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
new file mode 100644
index 0000000..c0214b0
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
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


