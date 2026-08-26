Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBEC61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:52 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22429.1787777928918428590
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DNIcpbsL;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52b6543169fso9910051cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777928; x=1788382728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JW9cq2/7lJJhkkeG450SgmPQn9n6p2wP/mvleS1h/zg=;
        b=DNIcpbsLELbatirPf27Dlk6N/VXWEks5mXmPGxzVGOngvwH/j5ZtQHzMhNuwNm885h
         iv0VxF/PywNUSUaOi4qdBTrXI8DhgdRpsrxWv6Vi9wo4lUkm/3KpEAeSULlIXN3X6Osa
         9rGjUknAJRjry82avJpuMMBdj1eKI7ynHxFlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777928; x=1788382728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JW9cq2/7lJJhkkeG450SgmPQn9n6p2wP/mvleS1h/zg=;
        b=Xd6iSExZ5xkquQAH0oEdiKE/8g7UttMmGuNPZ86pO90VOZgucdbXVpvmrdcrzd6bGf
         ovq+n7B6Vk+2U3J8NdiSW+BZFDM41vpoetddcfAb4cDPd1Gd+hCWiJ1ssu9MDsR/sH17
         5gUXszjRp02DKVXkAB7cnUhtr4TE2+dv3bKcXeg1cu/8zDJNZeKj/26La+iuJ7Uabpod
         KtdDBlzm6vYBzp8lCQz2dUVpVS5ozZnXoLhXPjoCghWouca4xb3E3UmX/zwyAy8qXd8X
         6ErOQI+AL1AMm7Vm4GtBg/7IItk1TFAnniDlqoSa9cR7+j3LdII8cXzkYlQ7pziStJcY
         t0LA==
X-Gm-Message-State: AFuF++kMVPVCOOnGoRXtpL43BiW11G9WxjNOfZvjvCZ2e49JdYnKA1aS
	/3sdkFgEWwRvszmfUhIfu3+IOeVqstEfoHYkpv5HHBqYyj+1Z2WLdE958TvDWoX6+ylQO6aVbVO
	CHmuH
X-Gm-Gg: AR+sD13NRtVtbIJ+LgQq+aFX9pEe0RP7+VwDCLxUG76Fe1URfetVCUkXPE3qwClY/uv
	RDYFUFP1/eCB/b+I5NGA5sTfTOoOk2Qyo52ASBObShyhCQov+3ozP9s+l8hOdZuLbSi+tDMWoBJ
	1O+2GwrGiGW3isqJFQeupOZWLWNuVry43t7fWDd72hiWxIMVwwIyB3mCKpB5GerCUkf8NUC01gB
	BRlQDHFREQnywNCZ2RJB5Vf1YM6GcGVXRD0Xjgw4RLp91SCuADZsFjXL3ZLsLVsIex7FhWuklrN
	HiO3GdngFsu5uepg8mqieBewEJHSjiTnHUUtAkxJg5HdLQYHiDMFo4kofdSMD4Y3SCZtg1pep4S
	NAAtRdaz4HRyUc+40tWWZqXewkp6ksbe8VNXpdRX5Jpgukp+NgnWcTDlvdgKvDxpO+H0RooDSFJ
	PdjEdda0TwOoUB7FrUO7GLBPdpchvqDZd/rp+oRbDDDKx9GWXbYMMEPC9WEXmB2FxVHknz+4p84
	hgMBW3SmBVL6vQxettTJ9P/yojNJdyYeObVlT5pPp07+7S03IyDFybbTYQ4KOUQ7ju1ODM0YRak
	yb9BCa650458WeQzLhmBKYmKMqg=
X-Received: by 2002:a05:622a:2605:b0:528:3157:7a8e with SMTP id d75a77b69052e-52e4222de28mr114531271cf.9.1787777927461;
        Wed, 26 Aug 2026 13:58:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 05/15] meta-tpm: Add missing recipe metadata (HOMEPAGE/SUMMARY)
Date: Wed, 26 Aug 2026 16:57:39 -0400
Message-ID: <3ef6b7cc57f537e8612b02ee2389782689e95881.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4697

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


