Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5AEFAD417
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 05:47:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13470.1776923267937244963
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 22:47:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Zxq4+krU;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=P4p/Bsv8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N2r23v3173440
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hXWzMyqw4l5sKPNeXjMhlqJn+rlQ/KAu8ft
	XZm4toiM=; b=Zxq4+krUBaOk6Zg+fSdwONnHtMAzM28WPQIR69lgrhEa3Sca/Kh
	w5JXDZg7dIc6W65vBZfiAV9nrF3VEeDIc6VtczWl1ER9fADchiS8RKuyWkI8PGH2
	yvOpbGtqZGefHnVjBLP+gdXyaJKN5XzAiJG18AZ5/rLvBtnvlWshnK98Msnje7z4
	Jjsrw58Fb0E9WJn3FJYasU8BFpc6IYmn4Tn6vb8UphJGdU+eB5Y/VS9U7hqF9BN/
	N6jKPsWVCIunrp+RzEDldg6kof6iKnVN8sm0g5zn4tXnejXKZNskY20NbaCKvtpZ
	U3GDa5n9grH2RPOObyznJaeC6k1UPUPbaMA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1m32a9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso3149280b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776923266; x=1777528066; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXWzMyqw4l5sKPNeXjMhlqJn+rlQ/KAu8ftXZm4toiM=;
        b=P4p/Bsv8TkIMBXf3Cq8ThW8nHNeFzmI7HEvepnC7eKXuz3ZFqCAxV3ft1KZG4+BOZJ
         sG/YmPgZjM0x+giVyZQ14cJNnB3CNS8u3J7qA5j+hTm054DCT7tb8mPRYCWEjkCB7daz
         Y2pQtDlt09OpuWJMLGrjPqJrtjVANgX8cOCfnUd/T3MSrCAa6CwN/vaRQtK/GD+KcZQs
         QSztA2t5vPv0zntHP3V0apcTsMwbhCOFeLULvdEtOGCypa4IJGoVsNSVpcfqeFItkc5N
         qv//tPjBpel0PGu6KqXYe02SwPYuyVx7JLBSDFTemTFBFGcet4TUF37k6dIeVY9N/aht
         uxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776923266; x=1777528066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXWzMyqw4l5sKPNeXjMhlqJn+rlQ/KAu8ftXZm4toiM=;
        b=IaZtYCiVoAaqcNLrGxN31ImYElYzAxHXOmmz2ZrdeCBMqiWaRSYCk0rvYn4gy6j0Nj
         z7/E6Lv4pMgKr2FbNUpQXoRdjuUojn0jvcCDuQSFsF8RFG8Z8tJSJc80AnhTPzXnJb0Q
         WH9UG+4u4l0I5uGRvjm0e2ahs2nz3k4cJkzlFmKsFyTTeBmbEbi4hs06FsYIBR+ODvcD
         0ZFj+QQyPLakOkr8w+M68AxMXLJLhPaTl/NmtgkDWz4RU+LGiVpKtlukICzF9xbQxldH
         55JPTorvPtgkqFXsiQzGDMVg6q81XXfaXXAyoV8I97nkq+T884kGsyODdO981Kx3xGML
         cX1w==
X-Gm-Message-State: AOJu0YzWEkWqzfg+HZfnzcwDjAb1l11SScsQyzato3xdpW2xjg41Jv/b
	uohwQ6Tpvec32VTEi57bLITfouvzg3zqpiq8JWtsaMVnY3sVoXJuSzEElyNixfP4XTQ1MCUqwlL
	D8m4ylQwS1wfZB8pmaz4u7KtbOJbUrXx4QbWFkN4lyPyklG8lnpdPFfcUYjrHOpCr8qCZ98wThw
	0OzKkysKbLhiks
X-Gm-Gg: AeBDietRwATy0zq3GcnGvq8slCU0C630qz75ksBwUt37xL/6c/DvsZrKOXBZVA88Q7V
	++0bQWGoGNTyWJrSOAXt4l8RP9tqVALnbry8tCZgVcNvflzYfrcCKnd8fxysivXGAhE3QaUdB+R
	bsQ54W8T6UAbmORr1Di8xrsoyk/zmItyyyZ9S+m4x+DanlAMH4nH2eY6W0TFjQCJ5kcw9nnkoly
	94v+Szji53F7CFXQ85n2/TSZCuzg0N2+3F2iDfxgMerF6Q/LL1E0j/wXJ+ePVR/mywjawOtFmJS
	LJv3fJKHsS3a/XlqO05k8z4I5RS1OMgos9BoqU91xb7y8MgB2a31wKR2ibWuaPNGLfSjlEOi7Zr
	Iv4aRKqXNpLj82cZIh4kXQI4ozHhZAM1VrT6G0g==
X-Received: by 2002:a05:6a00:3cc8:b0:82d:30f:b197 with SMTP id d2e1a72fcca58-82f8c8aec07mr27573748b3a.22.1776923265937;
        Wed, 22 Apr 2026 22:47:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cc8:b0:82d:30f:b197 with SMTP id d2e1a72fcca58-82f8c8aec07mr27573725b3a.22.1776923265447;
        Wed, 22 Apr 2026 22:47:45 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm20426925b3a.20.2026.04.22.22.47.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:47:45 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 1/4] dpdk: move common code to inc
Date: Thu, 23 Apr 2026 13:47:28 +0800
Message-ID: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mWKLPCuZxhFNyWtlj78rT6SoqtoE9V2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1MiBTYWx0ZWRfX/w/5SGqQ7ifT
 ETTbeaMFc8LSfQeKqV0BaO38WxT6g9c1fqhTu8Vv13kWUAfnXAdLwWdA1D8T9hUFdWfcrlHPUbI
 ARHoI/mTtryICWV0hL3dgjmGrbbQ8RZ597PRnO3Xgf6i+NP6dclqlU6G/v0wG8Qe13WWLRJkBTj
 3JmqSJsxVh+y9EzniqaPlYw1OTmZ0eeoriDMjXcFCv2CGBhbPQF8tijhVcoJxTYgU4LIAigh4Et
 fwsgwrNvNaeLVZ934zemEevGmnVaiDA6kOKRipvNUBnP4yJ5Aeu0ZbTVQXyxJDuoGMgRVmVIaLN
 tdZMFVr8oCL1mx+mxbtk9lcWcNIFWaAb393CK7pZrC9qpJjxGN2qwKPlRcb33M20sn6R/QIwMDU
 RT0KwJEaptlHzDK2eMIKfK75fvyzEjgeT6OoBpVTsMRmCrPMF8QvRHTeS+FU8Tpu60vERiSNJds
 pbtXLiodnwspNLKX+GA==
X-Authority-Analysis: v=2.4 cv=PsOjqQM3 c=1 sm=1 tr=0 ts=69e9b283 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=eIfyIicyu7bHENRUE-EA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: mWKLPCuZxhFNyWtlj78rT6SoqtoE9V2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3768

Move the common code from both dpdk versions to inc so it's not
duplicated.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk.inc        | 50 ++++++++++++++++++++++++++
 recipes-extended/dpdk/dpdk_23.11.5.bb | 42 ----------------------
 recipes-extended/dpdk/dpdk_25.11.0.bb | 52 ---------------------------
 3 files changed, 50 insertions(+), 94 deletions(-)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index f88ad98..0a947fc 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -9,4 +9,54 @@ LIC_FILES_CHKSUM = "file://license/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4
 SRC_URI = "git://dpdk.org/git/dpdk${STABLE};protocol=https;branch=${BRANCH};tag=v${PV} \
 "
 
+def get_cpu_instruction_set(bb, d):
+    import re
+    march = re.search(r'-march=([^\s]*)', d.getVar('CC'))
+    if march:
+        return march.group(1)
+    else:
+        return "core2"
+
+EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
+EXTRA_OEMESON:append:class-target = " --cross-file ${WORKDIR}/dpdk.cross"
+
+COMPATIBLE_HOST:libc-musl:class-target = "null"
+COMPATIBLE_HOST:linux-gnux32 = "null"
+
+PACKAGECONFIG ??= " "
+PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
+PACKAGECONFIG[libvirt] = ",,libvirt"
+
+RDEPENDS:${PN} += "pciutils python3-core"
+RDEPENDS:${PN}-examples += "bash"
+DEPENDS = "numactl python3-pyelftools-native"
+
+inherit meson pkgconfig
+
+INSTALL_PATH = "${prefix}/share/dpdk"
+
+RTE_PLATFORM ?= "generic"
+
+do_write_config:append() {
+    cat >${WORKDIR}/dpdk.cross <<EOF
+[properties]
+platform = '${RTE_PLATFORM}'
+EOF
+}
+
+do_install:append(){
+    # remove  source files
+    rm -rf ${D}/${INSTALL_PATH}/examples/*
+
+    # Install examples
+    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
+    for dirname in ${B}/examples/dpdk-*
+    do
+        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
+            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
+        fi
+    done
+
+}
+
 CVE_PRODUCT = "data_plane_development_kit"
diff --git a/recipes-extended/dpdk/dpdk_23.11.5.bb b/recipes-extended/dpdk/dpdk_23.11.5.bb
index aaff7eb..4785e0c 100644
--- a/recipes-extended/dpdk/dpdk_23.11.5.bb
+++ b/recipes-extended/dpdk/dpdk_23.11.5.bb
@@ -7,46 +7,6 @@ STABLE = "-stable"
 BRANCH = "23.11"
 SRCREV = "62f583c49bf67dd4d6733ece14e55fe6839e66d1"
 
-def get_cpu_instruction_set(bb, d):
-    import re
-    march = re.search(r'-march=([^\s]*)', d.getVar('CC'))
-    if march:
-        return march.group(1)
-    else:
-        return "core2"
-
-EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)} "
-
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-COMPATIBLE_HOST:linux-gnux32 = "null"
-
-PACKAGECONFIG ??= " "
-PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
-PACKAGECONFIG[libvirt] = ",,libvirt"
-
-RDEPENDS:${PN} += "pciutils python3-core"
-RDEPENDS:${PN}-examples += "bash"
-DEPENDS = "numactl python3-pyelftools-native"
-
-inherit meson pkgconfig
-
-INSTALL_PATH = "${prefix}/share/dpdk"
-
-do_install:append(){
-    # remove  source files
-    rm -rf ${D}/${INSTALL_PATH}/examples/*
-
-    # Install examples
-    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
-    for dirname in ${B}/examples/dpdk-*
-    do
-        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
-            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
-        fi
-    done
-
-}
-
 PACKAGES =+ "${PN}-examples ${PN}-tools"
 
 FILES:${PN} += " ${bindir}/dpdk-testpmd \
@@ -65,6 +25,4 @@ FILES:${PN}-tools = " \
     ${bindir}/dpdk-*.py \
     "
 
-CVE_PRODUCT = "data_plane_development_kit"
-
 INSANE_SKIP:${PN} = "dev-so"
diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
index c2a71d5..d5de179 100644
--- a/recipes-extended/dpdk/dpdk_25.11.0.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -7,56 +7,6 @@ STABLE = "-stable"
 BRANCH = "25.11"
 SRCREV = "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
 
-def get_cpu_instruction_set(bb, d):
-    import re
-    march = re.search(r'-march=([^\s]*)', d.getVar('CC'))
-    if march:
-        return march.group(1)
-    else:
-        return "core2"
-
-EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)} "
-EXTRA_OEMESON:append:class-target = " --cross-file ${WORKDIR}/dpdk.cross"
-
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-COMPATIBLE_HOST:linux-gnux32 = "null"
-
-PACKAGECONFIG ??= " "
-PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
-PACKAGECONFIG[libvirt] = ",,libvirt"
-
-RDEPENDS:${PN} += "pciutils python3-core"
-RDEPENDS:${PN}-examples += "bash"
-DEPENDS = "numactl python3-pyelftools-native"
-
-inherit meson pkgconfig
-
-INSTALL_PATH = "${prefix}/share/dpdk"
-
-RTE_PLATFORM ?= "generic"
-
-do_write_config:append() {
-    cat >${WORKDIR}/dpdk.cross <<EOF
-[properties]
-platform = '${RTE_PLATFORM}'
-EOF
-}
-
-do_install:append(){
-    # remove  source files
-    rm -rf ${D}/${INSTALL_PATH}/examples/*
-
-    # Install examples
-    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
-    for dirname in ${B}/examples/dpdk-*
-    do
-        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
-            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
-        fi
-    done
-
-}
-
 PACKAGES =+ "${PN}-examples ${PN}-tools"
 
 FILES:${PN} += " ${bindir}/dpdk-testpmd \
@@ -75,6 +25,4 @@ FILES:${PN}-tools = " \
     ${bindir}/dpdk-*.py \
     "
 
-CVE_PRODUCT = "data_plane_development_kit"
-
 INSANE_SKIP:${PN} = "dev-so"
-- 
2.53.0


