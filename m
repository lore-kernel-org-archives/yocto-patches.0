Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919C3C982D6
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27119.1789597833563867281
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=D/PFRCQD;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067fso17613685a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597832; x=1790202632; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JW9cq2/7lJJhkkeG450SgmPQn9n6p2wP/mvleS1h/zg=;
        b=D/PFRCQDn3Ei8RSJN1QVj9j8sBOVEGPBoooOv6JuqBGpGT2VkTOD1IUa1EAe1Vx1BY
         wQ9piSVihcxB5qlMHpuH41Svpgrvt54vayG8HQHFYYXFZjaMAwCcOpLYCWTzDywluDvW
         +CyZ4AOBg5/K1W55KyUXVtv4qvuI/m47wPinA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597832; x=1790202632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JW9cq2/7lJJhkkeG450SgmPQn9n6p2wP/mvleS1h/zg=;
        b=1V5xLes26vsKGi5tzBGLdvtVcPLekoNDf9pID/+VzTcyI5JOBtFFl5PXKgmykyCYGg
         jwjUzjJua6KrxM2bOqKRuSWaAG7L7l0TcVM/1afnPAzLSrMcqXEFkC856H5W9txEnH4j
         xTaIH/O6MEtyRZz5B8GiCKrVgijMbkSoKnwCieWeP6ec8HFjJbjasEtzN64TzacjLIqB
         44y4JiHCRLF7CqoNXrLF9BZp8xGdTCBbNwIHDB7zsiM9fdew+YW2MTYbSCxMGk84Xdfg
         HvjjGPmme+YHigNZ3n+DpMglJ1o5Fw6YiwHu9WFktJcgkweAWcrFUYyWWZLZO5fY64DI
         NWcA==
X-Gm-Message-State: AFuF++mcD2mproE8yTzKxiHFozzJmz1/SV1U3h/Ejx/t0rZRxjuJ4P1a
	Trl/fa2swMsECDqPbY6DO2KT/ZWnyUAVKK5ahE78dmn0ckGH1tJZ/UElGOq/96O93Em8RXN1Oz+
	M6nqW
X-Gm-Gg: AYBFou04bxuGmZo3tP41wY3LpZqBS1cfI+vSADAQ2vvO/FqoClQdsMX51i4j6Uq9Ysn
	HZAtvhP8R1rvZvfx0mkheFRiVaLvKf1BAJEVkfaW3akWIJFzhk3CpUZZWlrKMzI69MELO1gXK0t
	E6XLNlq3IbHfkrn72coaUv8WsAPQEvauvskgkhB7zrV2XBLQ+IIAGTUA3zecrdrvhLMWa4r1uBJ
	qN0JGzYngxEmtgCl3P3WlFpjojRwxeRp6GHSKlrNuIFq6/9Hgoi1hZpr4jtianSreESWrqjQp/u
	WKwssxuUT5qRuGC8HaPStXzb1T/sAmSCbfpgSIrXuFQJZErp7L1THUGgvsD5nQXZFFMd5obUGhw
	6C/6jB5UHTPwK9KuVmdVp5glnbeU77O02WrKYk2TsYguLCNYGz8OOKHNUlST+Y264W+ML/BJ9rY
	ufpknKEvkvPg1MHfpIvaSgP1GjN/CNcYwEws7suFqfmAoy81+tSwmCwiZv1KDmcguTDYzEaaiWX
	XLKpwMms0drG8L6u6IwT1oYGLZgs3AW/uXU8flm4GlIKapuuzXavNZkkXuFjA4HWkBEEYWMQLX2
	nVQ12GdR7qH/Ra/IYalNJuGLGHLLHDXcH6A=
X-Received: by 2002:a05:620a:319a:b0:939:4a34:621e with SMTP id af79cd13be357-93bb77e2108mr753569385a.28.1789597832307;
        Wed, 16 Sep 2026 15:30:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 03/24] meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)
Date: Wed, 16 Sep 2026 18:29:57 -0400
Message-ID: <3c2feadddb73b59d70c44701a656659802563e87.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4879

From: Shreejit C <shreejit.c@emerson.com>

Several meta-tpm recipes were missing HOMEPAGE and/or SUMMARY entries,
tripping the missing-metadata recipe QA check that is enabled for
core-layer recipes. The warnings surface whenever do_recipe_qa actually
runs (a fresh build with no sstate hit), e.g.:

  WARNING: tpm2-tss-4.1.3-r0 do_recipe_qa: QA Issue: Recipe tpm2-tss in
  .../tpm2-tss_4.1.3.bb does not contain a HOMEPAGE. Please add an entry.
  [missing-metadata]

Add the upstream project URL as HOMEPAGE, and a SUMMARY where absent:

  - tpm2-tss:                   add HOMEPAGE
  - tpm2-tools:                 add HOMEPAGE
  - tpm2-openssl:               add HOMEPAGE
  - tpm2-abrmd:                 add HOMEPAGE
  - tpm2-pkcs11:                add HOMEPAGE
  - tpm2-tss-engine:            add HOMEPAGE
  - python3-tpm2-pytss:         add SUMMARY
  - packagegroup-security-tpm2: add SUMMARY

Signed-off-by: Shreejit C <shreejit.c@emerson.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
2.55.0


