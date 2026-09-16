Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E1C982D7
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27123.1789597842149104999
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PRKwsABb;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso14939885a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597841; x=1790202641; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=drO7TWnsD5dKGC67T9fihFMC8uJ6JAn7tdAET4ohkRE=;
        b=PRKwsABbOB7exkv1ZYdRYnGjiS6Htvu3kP2YhYRV8ucSC0pd85dfNorbyYMvugXwiv
         T4134I2Qo1UkYaa+ofbsVmPZjz+AcZiUocG/Hj1xvJR2dcsadlosNZTaAm4dz0QF3kNI
         TBSbhAsRiJA93Vu9bGJnhlWM2wxaXnag1FzHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597841; x=1790202641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=drO7TWnsD5dKGC67T9fihFMC8uJ6JAn7tdAET4ohkRE=;
        b=jqUWHWE/gELw+hnW90JTNklfS4AS4M33sBhx9aMTjF+/6vCPUrTlSkUbEKxNE6pas2
         dJ5OdwUlUVZvKNqljsFBOQlI4NHNCT9iI8RaSqFUY1rdH/lcbhGx9co6gv7PC1rZVxiS
         j2Rcdt6FlEQQ1yFQBKD0zUavituJ5L7imHg5qW4+/243QbC2GCtgAHRxyh9D+pWrmKoc
         K/zcLHLqbyRWtKQwHfz1vdl9uDgFCQJgpkLA66/ZO5JnHDxKvjq9YPPqonTf4PkInkwo
         5YXTjBvYW5nRf3cv+AMvKylCN/RtP9aAxxXV9nXD6Bwqn4JIzo2VtAfuMmPmEIBT6DHf
         y0yA==
X-Gm-Message-State: AFuF++nud7z7f4uv88jefNzcqpXkD9HTaoB8Q31GK0WqVaOcSpstiW1N
	uufP1FQEOxI96M1ChtZ5RsxcaH3Vs4rTO4zJ+0sPdK5p2Iw7piQIc6Uj3G/J5KSpTP0UktR1eNC
	B9IxZ
X-Gm-Gg: AYBFou3n9GdTwXCYgC30l2aRcXujYV83yTBBBZOpjT0hlJh/reFYTQ4GLC5a8Yt4zrB
	Wo5kppugIz7+SHePpPY6W0vNvl9FGdbNGYPFwlPjSc2kjrmn43dbw2GY6vTY5GJzoVBKpCiLCGb
	Ttbb2lcwFw67dkugKmzm6HgH1/MwLGK4M6/OrTvLUhy45J1BvK21y6SkiCsVir69nny+mF/62WF
	Gy6pzsaYeXaImmI7RoTpyxcPYkSQw3v08zPcbowF2/zBuoxSORU1g3bnKzh8F9OMYw2REloDa5k
	juci4q4u+u1yWCbHON78Nlto31Wu3jMQ2IMRtikwpU9a/MbrfTOnElxIkmd8k/7cwQzaolec2wV
	NYvhxCQEOPdNvE7lrbuuwOcNoL1HT5mRprx9ucME9B+h4ocLQr5aQAHX/1VyfdaFgq44dP+dlYy
	1cONpJIQdaMt+Cx/0XUqip8jt6GmhRwSyOQ6a8xp+jj0QfyKkhDVvWgePkEzJ2xUIzNgbCxmhRw
	3q2Q1xdIC17iLgSaaRHF+WMSG/N7c4kP2I272GT1VaI4gRXcJ56Iidw8eSlq7W3KiQJV96qmqNj
	c60xUOb6m/teooOJzIHrrSa+G3nFIvHmp1Q=
X-Received: by 2002:a05:620a:4145:b0:934:946d:599d with SMTP id af79cd13be357-93bb77e24bamr759181985a.33.1789597840842;
        Wed, 16 Sep 2026 15:30:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 10/24] meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes
Date: Wed, 16 Sep 2026 18:30:04 -0400
Message-ID: <55fa46e742fdb8bcdae83db5d0a741ca357e3ddb.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4886

To quiet the missing metadata warnings, switch DESCRIPTION to SUMMARY
in the following recipes:
- security-tpm-image
- security-tpm2-image
- packagegroup-security-tpm
- openssl-tpm-engine

and add HOMEPAGE to these recipes:
- libtpms
- swtpm
- tpm-tools

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-core/images/security-tpm-image.bb              | 2 +-
 meta-tpm/recipes-core/images/security-tpm2-image.bb             | 2 +-
 meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb | 2 +-
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb                   | 1 +
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb                      | 1 +
 .../recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb | 2 +-
 meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb            | 1 +
 7 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/meta-tpm/recipes-core/images/security-tpm-image.bb b/meta-tpm/recipes-core/images/security-tpm-image.bb
index dbdd309..c6d25a2 100644
--- a/meta-tpm/recipes-core/images/security-tpm-image.bb
+++ b/meta-tpm/recipes-core/images/security-tpm-image.bb
@@ -1,4 +1,4 @@
-DESCRIPTION = "A small image for building a tpm image for testing"
+SUMMARY = "A small image for building a tpm image for testing"
 
 IMAGE_FEATURES += "ssh-server-openssh"
 
diff --git a/meta-tpm/recipes-core/images/security-tpm2-image.bb b/meta-tpm/recipes-core/images/security-tpm2-image.bb
index 941a661..117d34e 100644
--- a/meta-tpm/recipes-core/images/security-tpm2-image.bb
+++ b/meta-tpm/recipes-core/images/security-tpm2-image.bb
@@ -1,4 +1,4 @@
-DESCRIPTION = "A small image for building a tpm2 image for testing"
+SUMMARY = "A small image for building a tpm2 image for testing"
 
 IMAGE_FEATURES += "ssh-server-openssh"
 
diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
index a1d4d44..f92bf01 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
@@ -1,4 +1,4 @@
-DESCRIPTION = "Security packagegroup for Poky"
+SUMMARY = "Security packagegroup for Poky"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                     file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
index 7f00216..2b6f670 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
@@ -1,4 +1,5 @@
 SUMMARY = "LIBPM - Software TPM Library"
+HOMEPAGE = "https://github.com/stefanberger/libtpms"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=e73f0786a936da3814896df06ad225a9"
 
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index d5470f4..8472f02 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -1,4 +1,5 @@
 SUMMARY = "SWTPM - Software TPM Emulator"
+HOMEPAGE = "https://github.com/stefanberger/swtpm"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=fe8092c832b71ef20dfe4c6d3decb3a8"
 SECTION = "apps"
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb b/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
index b792151..13f0d0d 100644
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
+++ b/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
@@ -1,4 +1,4 @@
-DESCRIPTION = "OpenSSL secure engine based on TPM hardware"
+SUMMARY = "OpenSSL secure engine based on TPM hardware"
 HOMEPAGE = "https://github.com/mgerstner/openssl_tpm_engine"
 SECTION = "security/tpm"
 
diff --git a/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb b/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
index 6d911c9..97a7aef 100644
--- a/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
+++ b/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
@@ -1,4 +1,5 @@
 SUMMARY = "The tpm-tools package contains commands to allow the platform administrator the ability to manage and diagnose the platform's TPM."
+HOMEPAGE = "https://sourceforge.net/p/trousers/tpm-tools"
 DESCRIPTION = " \
   The tpm-tools package contains commands to allow the platform administrator \
   the ability to manage and diagnose the platform's TPM.  Additionally, the \
-- 
2.55.0


