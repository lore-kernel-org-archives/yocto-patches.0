Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132AC61DC4
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:03 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22441.1787777938153970882
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aY0kRg+N;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52d8748cde5so140011cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777937; x=1788382737; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=drO7TWnsD5dKGC67T9fihFMC8uJ6JAn7tdAET4ohkRE=;
        b=aY0kRg+NzH8/bGZsG+0u7tcC6MUjmULb5hiZgAsX3tbZ9AjRrp2lcS9MsKe2AA0Cpu
         UJ0OmQXKyfwUNJSF+9uCz/Fc6KrWguf6pbZiMZru2LYnkJRt2KrfrpOrwiWCYPnfgIcj
         E5u6hdORxE5+9spD574RjyuuEr7PUocotHy+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777937; x=1788382737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=drO7TWnsD5dKGC67T9fihFMC8uJ6JAn7tdAET4ohkRE=;
        b=jdG+2gWm0Hgg2Oj1s62sWyiAdWYVFLpyXGc8x9t7xWhWRKDnjgET3GGF+jEnLpIn9C
         SPFyxg/BqulhNbyy9pbRHq0JGMq0jKPFnWjth76OTTXFvjJWmEImAEVnQudkFBYQbPrH
         /Xdat1g1PrFmvj8M7fjXz28aEzgqsd895uJPMUpcwACWxpSyka2LdM4IutKzN+ibgtuq
         eskWs/dgHjJ3UO6jWeODEKZPPWPOqMSvRUT33h8OKlNfecq3DRBzHE/t2ATy9Daiaz3h
         fA2kS5if5mmxbJOoohNJGVzXoqtrg71TpC+Nr/y09I/RB3wz45PZuchy4jgLPGgJy58A
         xBOg==
X-Gm-Message-State: AFuF++lu7uyK5IC9u+XyM+O0Z3RC8yw8EM5+Ie9nhycEd7Ys+aPvtwxR
	0+MVxtfQyDnDT7acRf5nbX2G44pFWHab/Pgb8930+gmBkKCxg3KxURq5oPzcvpeE7zEENbT09ET
	wtgf6
X-Gm-Gg: AR+sD10uKhe9y6exhp4QYt6k0521/1oWjrZeru5A4jpCyFpQzXwppVgjjTAsyDc/EqX
	D7Do7+pj3koSiz0mBOiods3WzssaUUftqUhOBt2QG/2FqMajRSJpgByJDQRsICg7Vlh6195vYQG
	o1TvN24W5+/Hc0Vr6UnLLjt/5qAmBLvDEBEB6sVRBR5ijoEMPWhqjR3yV9C/ayR/IMA3a5Tri0i
	soTme5oJ1hJxlVzgOhHn/GJUf0yAaznySqT7F+3h+xMt6muEI+Fcg0gGDS0qGJc5SpVSCltLOOL
	YDVeGkUSFl9rDt8YqAkXjTlfezf3vue2d7Vk8+239FLlucVJyq9GIvF3b3a+3fBDWrdgA2A+qnP
	ems9c7VqR9XfhkM8RKbYTj20IrCD/MQTOsVplImlCLbZBvL4yyRssLJ1D8KXlDbdCpoTs5FCAQR
	5rQsvWilrYZXmz/oo9Mzj8EuKZXCnzbCX6Etm5fjH7WRYZ0hDIlVLsCDv/A6CS9zmTmYZpC8ubb
	jOQZURJEda7qsb1SId5WkLf63pDABgIFEvagKDlzOxbq1geIlTTao6HcNo3VzitvlTptXG/UxFm
	41S9zGlTNzdLlUwu1302Uvn8iHnR/rRhZZfu
X-Received: by 2002:a05:622a:aa8c:10b0:52e:f046:d669 with SMTP id d75a77b69052e-52ef046e209mr32329391cf.14.1787777936845;
        Wed, 26 Aug 2026 13:58:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 14/15] meta-tpm: Fix SUMMARY/HOMEPAGE in affected recipes
Date: Wed, 26 Aug 2026 16:57:48 -0400
Message-ID: <06a36993a0fd196b1a281042c46b4f2f4165e1cb.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4706

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


