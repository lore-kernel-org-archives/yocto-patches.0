Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B2CDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 09:06:13 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1120.1782282399372114937
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 23:26:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GxsMCEsz;
 spf=pass (domain: gmail.com, ip: 209.85.216.41, mailfrom: adityags2004@gmail.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so425963a91.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 23:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782282399; x=1782887199; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAm3lCSS8sjkkaFG1gll6DXchHwZ3hQZIzzxwDHzCUc=;
        b=GxsMCEszg8EIx5MGZCPXRCEZ2ctHmRUsg1b5miZuv4+09p/TQ3O2ijGgj6H09syKU4
         PrqvF25TtKZbFdaHOxYFN1KKovmXogGkjW5gX2KRJf1fqlGTAZsD7oGBRah20CYYZvtr
         ZWi2oZyozfOu2Jk8177pOc2aYGV/7VpTL74Zirj6ANTZc97W+REAEOsU5GpqwQoSdBLf
         l8HwaeRvNKIiOBUv+QQ1/plGs3MeQzrGrEE8PnT42o0H6AtBM6osQJtUAYANSkVrMc/d
         x22xo6l/sXG8FCI7KgUcKoIljR5bytmrMcOuD4aIYWghUQm4up3eITT/2zFrZP7F7a4/
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782282399; x=1782887199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAm3lCSS8sjkkaFG1gll6DXchHwZ3hQZIzzxwDHzCUc=;
        b=F9TziSFbV6rBaKDyuapWiMzih/6YwFUhEgF8PYJ4R/r0s8ywW2cE1QkBwSH7UUYCQy
         waI07cZZF2NpFo+BcIeZt+ZktVzRNOpOoSZTsJwJTe3RbmXwQswK4NYsQTuPHV6Y5/wW
         mSyHOUIFy4NsEDyY2S5m+DzWRJRUx1dLmuHFHtrhvsxEzD1SDyWc6JgBPlUX10ov2kMM
         0QEYd+rwhFlnAORgOg5KO/xBR6fORx9Bhu4h+knVa3fxzK5E1dMJoRFkFza4dQg1Nqc4
         MDIkbKNVYNaxYayGSIP+JaWsjJUij84dClIngDHCUbpdtS7czC0KkbU4NF5ER46V6vnA
         OD/Q==
X-Gm-Message-State: AOJu0YzKpl7inavtmQtRLm1H/7x9msqAM7NhxkX3qSHoqVDX7VlOTiuU
	FbhMwn/LVyaOZqYRyF6yddB0uUIP+DcY4trSYfcS5TZN22lKbam8V6meyCZQIg==
X-Gm-Gg: AfdE7cnn47qU+zmd9s3O2c2prgfXXmFlkum3Glg8mtJknQxst6M/hVWQGgAIflcPsyj
	Q1ysBC2e/Yni3n/qeVC9m3tyGE8ODM1DR2/cyiREFLr9PUbtYOkEt6hXA7ZqaB2rE7dha3RoGCN
	nef2qve9uz3yJNaKUkyHa+ZCE5UAZKimcDysWVwFKIoTAGQGhSdAuxVV3g+hayEpheQQN1gTjb0
	SNQOhQRVyOaO9sqs8fQ7jBzE7g6lDZMKM5SPUqjadzPh9UILnt8H4/t/9FQMOzmWzGtw/+AGp5l
	h84V064kxL9QU/+suAPv1kRipWN6xh0IHENwnCEy3k0dCh7RzhFNuSGVFiJLCzWKYHdhVujb0Fz
	9hBbe3DDRi2Rpixx/5zCPfcEQK6+jEmczqHSWxR281gN6vRwwMGZf5GEp4mjyElllyW3dvv+nKL
	9soZBUImLyFGkEwYYB4VunDBGg4EHJDL31dyJtX9371/ybLB+Sw0wXaGXC96v3mVEILQ==
X-Received: by 2002:a17:903:1aad:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c7e15c5297mr22216625ad.35.1782282398565;
        Tue, 23 Jun 2026 23:26:38 -0700 (PDT)
Received: from BLR1RLPT00005.localdomain ([223.231.164.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c799749cb3sm80582675ad.72.2026.06.23.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:26:38 -0700 (PDT)
From: "Aditya GS" <adityags2004@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Aditya GS <adityags2004@gmail.com>,
	Aditya GS <aditya.gs@bmwtechworks.in>
Subject: [meta-lts-collab][kirkstone][PATCH] openssl: upgrade 3.0.20 -> 3.0.21
Date: Wed, 24 Jun 2026 11:56:20 +0530
Message-Id: <20260624062620.753-1-adityags2004@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 09:06:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4293

Upgrade OpenSSL from 3.0.20 to 3.0.21.

This upgrade brings in upstream fixes for multiple CVEs:

  - CVE-2026-45447 (High): heap use-after-free in PKCS7_verify()
  - CVE-2026-7383: heap buffer overflow in ASN.1 multibyte string
  - CVE-2026-9076: out-of-bounds read in CMS password-based decryption
  - CVE-2026-34180: heap buffer over-read in ASN.1 content parsing
  - CVE-2026-42764: NULL pointer dereference in QUIC server packet handling
  - CVE-2026-45445: AES-OCB IV ignored on EVP_Cipher() path
  - CVE-2026-34182: CMS AuthEnvelopedData may accept forged messages
  - CVE-2026-42766: NULL pointer dereference in password-based CMS decryption
  - CVE-2026-42770: FFC-DH peer validation uses attacker-supplied q
  - CVE-2026-45446: incorrect tag processing for empty messages in AES-GCM-SIV and AES-SIV modes

As a result of this upgrade, the following CVEs are already fixed in the
upstream version and no longer require local patches:

  - CVE-2024-41996: vulnerability that could lead to denial of service
  - CVE-2023-50781: fixes related to certificate validation and memory handling

Upstream changelog:
https://github.com/openssl/openssl/blob/openssl-3.0.21/NEWS.md

Signed-off-by: Aditya GS <adityags2004@gmail.com>
Signed-off-by: Aditya GS <aditya.gs@bmwtechworks.in>
---
 .../openssl/{openssl_3.0.20.bb => openssl_3.0.21.bb}     | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
 rename meta-core/recipes-connectivity/openssl/{openssl_3.0.20.bb => openssl_3.0.21.bb} (96%)

diff --git a/meta-core/recipes-connectivity/openssl/openssl_3.0.20.bb b/meta-core/recipes-connectivity/openssl/openssl_3.0.21.bb
similarity index 96%
rename from meta-core/recipes-connectivity/openssl/openssl_3.0.20.bb
rename to meta-core/recipes-connectivity/openssl/openssl_3.0.21.bb
index d33874e..fffe303 100644
--- a/meta-core/recipes-connectivity/openssl/openssl_3.0.20.bb
+++ b/meta-core/recipes-connectivity/openssl/openssl_3.0.21.bb
@@ -12,20 +12,13 @@ SRC_URI = "https://github.com/openssl/openssl/releases/download/openssl-${PV}/op
            file://0001-buildinfo-strip-sysroot-and-debug-prefix-map-from-co.patch \
            file://afalg.patch \
            file://0001-Configure-do-not-tweak-mips-cflags.patch \
-           file://CVE-2024-41996.patch \
-           file://CVE-2023-50781-1.patch \
-           file://CVE-2023-50781-2.patch \
-           file://CVE-2023-50781-3.patch \
-           file://CVE-2023-50781-4.patch \
-           file://CVE-2023-50781-5.patch \
-           file://CVE-2023-50781-6.patch \
           "
 
 SRC_URI:append:class-nativesdk = " \
            file://environment.d-openssl.sh \
            "
 
-SRC_URI[sha256sum] = "c80a01dfc70ece4dc21168932c37739042d404d46ccc81a5986dd75314ecda6f"
+SRC_URI[sha256sum] = "617e29af8e421f46649484a4937e48c685e47f46488167c982f88bc4ec1d522f"
 
 inherit lib_package multilib_header multilib_script ptest perlnative
 MULTILIB_SCRIPTS = "${PN}-bin:${bindir}/c_rehash"
-- 
2.34.1


