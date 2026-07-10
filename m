Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A9C43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 10:16:18 +0000 (UTC)
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9488.1783678261666339865
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jul 2026 03:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=1t/jGRol;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.142.35, mailfrom: prvs=865130ee06=shreejit.c@emerson.com)
Received: from pps.filterd (m0484884.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dwcG947562;
	Fri, 10 Jul 2026 10:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=vH6dNf5WMoxHcpYZzOGzk4ekEI
	gYpRp4NuumqNQxs3M=; b=1t/jGRol7Y91hKZjgmTSa9JG4KddmbxA/GwpETgam6
	8pMV+RtEy4GPO34YBuDOi3u+zfx5k7710C2GE5lxNR8dhcPynB4OQaArV6X1z2iU
	9ocbtP0R+hEhiJpCcuAa/0B9t3tPn5B3Crj/+XqsVqCxAdfyJK6K2ZgWOQrFKgvQ
	8jS8evwMVAhoMQQK0hiHeXRIzlS3ECOLUFJwD7uH3/YOGJNgI8Bn3VuZSoc0zaY7
	5fB7Rk9eNBcq9ZzXz4H579v6ysocZ7jeGAYOG/mM6Xnx61hlgmgHtQBIIpMJcDhJ
	7/4QFg8fYIKtly6n7Du+ieIgr3X7BNYOqEnKBL9LwdLA==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4fasn2j3qq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 10:10:59 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 Jul 2026 05:10:57 -0500
Received: from tonks.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 10 Jul 2026 05:10:56
 -0500
From: "Shreejit C" <shreejit.c@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <scott.murray@konsulko.com>, <rybczynska@gmail.com>,
        Shreejit C
	<shreejit.c@emerson.com>
Subject: [meta-security][PATCH] meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)
Date: Fri, 10 Jul 2026 15:40:51 +0530
Message-ID: <20260710101051.3011922-1-shreejit.c@emerson.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: lglvztbz2aLPJYqNk_8KqqgDvjPi-yBt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwMCBTYWx0ZWRfX0508HITB4k5V
 N8FciHYf0pRDq4p3NHX2A19hpAAQJRnSVUOELCqOb596XifJgjFHcSTyuUfaq3RoUlMyQd7Tg8L
 3aCOEp8DYaj1JEOGtJNeY71NXYSYtyOxerrBFu7teVP7X3djPQzD
X-Authority-Analysis: v=2.4 cv=QuZuG1yd c=1 sm=1 tr=0 ts=6a50c533 cx=c_pps
 a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ps6gwBxKFAOpZu8f3VnT:22
 a=amQ93Wefht2Ng08MFDbD:22 a=NEAV23lmAAAA:8 a=geDs06hvAAAA:8
 a=aNEeLs8aBdlhPjH15v0A:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwMCBTYWx0ZWRfX10QDiDG8UuSG
 TagmDki9GqUI6jG9ycKKIphb9ygJZqTq8cbJn3uY+95RCFILpxy8ovsmfeVqixZQ3wLYjvlY+Qo
 LpveWg9Itjd6g/iSt7nuix+92O0bdTJTVjmXln7C1Nt6r18T/tj0Pxbl7rxqWUb4C0V8b/b03F4
 rJjouXxS3zyqxBZGfIMOvmnh3EwFsTsc8+ASTqFyU9E27ZA8hUHf7Mx8134dMU6ZNHMXFBO5sGs
 3eCd+tSQMTDm1tFGb/JkPcIQ/igyt9h2LYTNzXCKZs8QyDG9esIQGuxz7AnAdr0i8yonk0yZyhy
 mjDtKrqbibksSZNxTXy2L5DYZOtVvLIcrc50LufFpfuJYxysqbX1szFpX9/i1q9V9Zv2cVFhCEa
 KrectY+SyeaHLJNGpzP8ATlX9jmfDJtqoDL4qVQlUILwmYuX8TgODKe1P4BY3zHORi8yxaaf7ZH
 qM3v5CSqoxNyIyajVNg==
X-Proofpoint-ORIG-GUID: lglvztbz2aLPJYqNk_8KqqgDvjPi-yBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100100
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 10:16:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4465

Several meta-tpm recipes were missing HOMEPAGE and/or SUMMARY entries,
tripping the missing-metadata recipe QA check that is enabled for
core-layer recipes. The warnings surface whenever do_recipe_qa actually
runs (a fresh build with no sstate hit), e.g.:

  WARNING: tpm2-tss-4.1.3-r0 do_recipe_qa: QA Issue: Recipe tpm2-tss in
  .../tpm2-tss_4.1.3.bb does not contain a HOMEPAGE. Please add an entry.
  [missing-metadata]

Add the upstream project URL as HOMEPAGE, and a SUMMARY where absent:

  - tpm2-tss:                    add HOMEPAGE
  - tpm2-tools:                  add HOMEPAGE
  - tpm2-openssl:               add HOMEPAGE
  - tpm2-abrmd:                 add HOMEPAGE
  - tpm2-pkcs11:                add HOMEPAGE
  - tpm2-tss-engine:            add HOMEPAGE
  - python3-tpm2-pytss:         add SUMMARY
  - packagegroup-security-tpm2: add SUMMARY

Signed-off-by: Shreejit C <shreejit.c@emerson.com>
---
 meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb | 1 +
 meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb             | 1 +
 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb         | 1 +
 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb           | 1 +
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb     | 1 +
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb               | 1 +
 meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb   | 1 +
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb                 | 1 +
 8 files changed, 8 insertions(+)

diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
index b986097..b04851f 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
@@ -1,3 +1,4 @@
+SUMMARY = "TPM2 packagegroup for Security"
 DESCRIPTION = "TPM2 packagegroup for Security"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
diff --git a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
index 1b8eff1..b829a68 100644
--- a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
@@ -5,6 +5,7 @@ is implemented using Glib and the GObject system. In this documentation and \
 in the code we use `tpm2-abrmd` and `tabrmd` interchangeably. \
 "
 SECTION = "security/tpm"
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-abrmd"
 
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
index ed756b1..e97a208 100644
--- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
@@ -1,4 +1,5 @@
 SUMMARY = "Provider for integration of TPM 2.0 to OpenSSL 3.0"
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-openssl"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3f4b4cb00f4d0d6807a0dc79759a57ac"
 
diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
index 3d04e5b..1a671bc 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
@@ -1,6 +1,7 @@
 SUMMARY = "A PKCS#11 interface for TPM2 hardware"
 DESCRIPTION = "PKCS #11 is a Public-Key Cryptography Standard that defines a standard method to access cryptographic services from tokens/ devices such as hardware security modules (HSM), smart cards, etc. In this project we intend to use a TPM2 device as the cryptographic token."
 SECTION = "security/tpm"
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-pkcs11"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=0fc19f620a102768d6dbd1e7166e78ab"
 
diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 63ed8cf..44c6ed2 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -1,3 +1,4 @@
+SUMMARY = "Python bindings for the TPM2 Software Stack (TSS2)"
 DESCRIPTION = "TPM2 TSS Python bindings for Enhanced System API (ESYS), Feature API (FAPI), Marshaling (MU), TCTI Loader (TCTILdr), TCTIs, policy, and RC Decoding (rcdecode) libraries"
 HOMEPAGE = "https://github.com/tpm2-software/tpm2-pytss"
 LICENSE = "BSD-2-Clause"
diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index e1a0c5d..04ada78 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -1,5 +1,6 @@
 SUMMARY = "Tools for TPM2."
 DESCRIPTION = "tpm2-tools"
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-tools"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index 6bc44ef..e620995 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -1,5 +1,6 @@
 SUMMARY = "The tpm2-tss-engine project implements a cryptographic engine for OpenSSL." 
 DESCRIPTION = "The tpm2-tss-engine project implements a cryptographic engine for OpenSSL for Trusted Platform Module (TPM 2.0) using the tpm2-tss software stack that follows the Trusted Computing Groups (TCG) TPM Software Stack (TSS 2.0). It uses the Enhanced System API (ESAPI) interface of the TSS 2.0 for downwards communication. It supports RSA decryption and signatures as well as ECDSA signatures."
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-tss-engine"
 
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=7b3ab643b9ce041de515d1ed092a36d4"
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
index 67a51e4..f8e87a5 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
@@ -1,5 +1,6 @@
 SUMMARY = "Software stack for TPM2."
 DESCRIPTION = "OSS implementation of the TCG TPM2 Software Stack (TSS2) "
+HOMEPAGE = "https://github.com/tpm2-software/tpm2-tss"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
 SECTION = "tpm"
-- 
2.34.1


