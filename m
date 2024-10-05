Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E17CFB42C
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 17:34:39 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web10.16211.1728149675644953031
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Oct 2024 10:34:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gce5uPF1;
 spf=pass (domain: gmail.com, ip: 209.85.219.176, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e288efeb4feso2407712276.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728149675; x=1728754475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxh08PxnkboHgWCWS5ZpSzx7QxM57E4gQ2ElNS4DKqI=;
        b=gce5uPF1TXDUWJonMIBqeyvfMfi2NAjZjqSRhVpDv7JnFHoMcOEsNSyk2VycogE1ZC
         KWNnaGRN+vTiFvW57aDiHT0vh7TxtPbeVk6WBLdjHKQhu1X4IzWmEY14te+FsM2L6tbm
         IgAvPu1JywjOHrW7Mn3uuZoW04QAbZp1Lc9CV8TeBbGPU6ZTUKsyVMfiTRY/VAstgWLU
         6rdyEg4ICUqWV1B0oRsw31heWXX3HfjsOL74zvtjmGe4SGQt6v+S40/ZLLIemMMHImUL
         8a+2hzVizZ/gg2nI+1tTmIOBIlc7pxpVzlZcc+jhzI31QtTxJUWRXL6/zsHvnVKf8DsY
         j0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728149675; x=1728754475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxh08PxnkboHgWCWS5ZpSzx7QxM57E4gQ2ElNS4DKqI=;
        b=Ap6SumcoYkZPpUHwOZyItb7yHhDt8c5IFyPnwpIQGJPJLORLCPPY3C9vuMcGt0qCBa
         J2xujV2d9eGBjFa9yhQTJyyP9AwjE8ifxKapPQo28JbIXnGh9HqlI1/uKSbNCzUhTC7x
         vDCzB4iojoRcW780sbV1B2jPMBN7EOUIDmUo6xn+OjirsJiaqjwBOLYMXbFdRhazyOr7
         mOGMbAim0SwEqShSMUZcP6I477ppr5qrqwYFSoVeR09Gt5Fccb37IZBwxyvdaD5k0CJF
         /xcDJ4+jNcZKHvqF2zwK9rBSaF1igZs7d3jHaXRAx0oXg1Hk68D2MnyYqcOEJXhs7Mym
         1Wgg==
X-Gm-Message-State: AOJu0YyUQpknxt+tdmb2xcVnJ++DvDSWzQ5fm8jIQguDfOHOVqO4Vzf3
	zh65E+Mlx6SoldS7hwC+/v+82T18DWuvMEp30v9zeI24W54HNM6cwBhAYQ==
X-Google-Smtp-Source: AGHT+IHpd0/ZtYD6m5jWEyIyGLHMo4HhOgh3gXvTz6UTCl+DmMimlZH6aJ7y593LWhZfayk4RnO0dQ==
X-Received: by 2002:a05:6902:1002:b0:e26:2c21:d0f8 with SMTP id 3f1490d57ef6-e28936c6705mr5580592276.6.1728149674591;
        Sat, 05 Oct 2024 10:34:34 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8a15:aa34:73ec:b252])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3a3fcsm345137276.20.2024.10.05.10.34.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 10:34:34 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/3] tpm2-tss-engine: update to 1.2.0
Date: Sat,  5 Oct 2024 13:34:31 -0400
Message-ID: <20241005173431.2697319-3-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005173431.2697319-1-akuster808@gmail.com>
References: <20241005173431.2697319-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 17:34:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/691

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 ...-disabling-of-digest-sign-operations.patch | 48 ++++++++++++
 ...OpenSSL-function-signatures-that-cau.patch | 78 +++++++++++++++++++
 ...gine_1.1.0.bb => tpm2-tss-engine_1.2.0.bb} |  7 +-
 3 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
 rename meta-tpm/recipes-tpm2/tpm2-tss-engine/{tpm2-tss-engine_1.1.0.bb => tpm2-tss-engine_1.2.0.bb} (83%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
new file mode 100644
index 0000000..f0f1fad
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
@@ -0,0 +1,48 @@
+From af8b26e7ffe69837197fb841e9a31230ae01c9cc Mon Sep 17 00:00:00 2001
+From: Andreas Fuchs <andreas.fuchs@infineon.com>
+Date: Mon, 22 May 2023 14:06:41 +0200
+Subject: [PATCH 1/2] Configure: Allow disabling of digest-sign operations
+
+Since the digest-sign operations perform the hash on the TPM and
+TPMs in general do not support SHA512, this can lead to errors.
+Depending on the use case, it might be preferable to not support
+restricted keys (via digest+sign) but to rely on ordinary keys
+only.
+
+Upstream-Status: Backport
+Signed-off-by: Andreas Fuchs <andreas.fuchs@infineon.com>
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+
+---
+ configure.ac | 10 ++++++++--
+ 1 file changed, 8 insertions(+), 2 deletions(-)
+
+diff --git a/configure.ac b/configure.ac
+index d4a9356..b379042 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -116,13 +116,19 @@ PKG_CHECK_MODULES([CRYPTO], [libcrypto >= 1.0.2g],
+ PKG_CHECK_MODULES([TSS2_ESYS], [tss2-esys >= 2.3])
+ PKG_CHECK_MODULES([TSS2_MU], [tss2-mu])
+ PKG_CHECK_MODULES([TSS2_TCTILDR], [tss2-tctildr])
++
+ AC_CHECK_LIB([crypto], EC_KEY_METHOD_set_compute_key,
+       [AM_CONDITIONAL([HAVE_OPENSSL_ECDH], true)],
+       [AM_CONDITIONAL([HAVE_OPENSSL_ECDH], false)])
++
++AC_ARG_ENABLE([digestsign],
++              [AS_HELP_STRING([--disable-digestsign],
++                              [Disable support for digest and sign methods, helps with TPM unsupported hash algorithms.])],,
++              [enable_digestsign=yes])
+ AC_CHECK_LIB([crypto], EVP_PKEY_meth_set_digest_custom,
+-      [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], true)],
++      [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], [test "x$enable_digestsign" != "xno"])],
+       [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], false)])
+-AS_IF([test "x$ac_cv_lib_crypto_EVP_PKEY_meth_set_digest_custom" = xyes],
++AS_IF([test "x$ac_cv_lib_crypto_EVP_PKEY_meth_set_digest_custom" = xyes && test "x$enable_digestsign" = "xyes"],
+       [AC_DEFINE([HAVE_OPENSSL_DIGEST_SIGN], [1],
+                  Have required functionality from OpenSSL to support digest and sign)])
+ 
+-- 
+2.43.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
new file mode 100644
index 0000000..0bd4e2e
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
@@ -0,0 +1,78 @@
+From 766505bf5c943c614fd246d27d1e5cd66543250b Mon Sep 17 00:00:00 2001
+From: Matthias Gerstner <matthias.gerstner@suse.de>
+Date: Mon, 6 May 2024 16:07:54 +0200
+Subject: [PATCH 2/2] Fix mismatch of OpenSSL function signatures that cause
+ errors with gcc-14
+
+Building with gcc-14 fails with diagnostics like this:
+
+```
+src/tpm2-tss-engine-rsa.c:805:46: error: passing argument 2 of 'EVP_PKEY_meth_set_copy' from incompatible pointer type [-Wincompatible-pointer-types]
+  805 |     EVP_PKEY_meth_set_copy(pkey_rsa_methods, rsa_pkey_copy);
+      |                                              ^~~~~~~~~~~~~
+      |                                              |
+      |                                              int (*)(EVP_PKEY_CTX *, EVP_PKEY_CTX *) {aka int (*)(struct evp_pkey_ctx_st *, struct evp_pkey_ctx_st *)}
+/usr/include/openssl/evp.h:2005:36: note: expected 'int (*)(EVP_PKEY_CTX *, const EVP_PKEY_CTX *)' {aka 'int (*)(struct evp_pkey_ctx_st *, const struct evp_pkey_ctx_st *)'} but argument is of type 'int (*)(EVP_PKEY_CTX *, EVP_PKEY_CTX *)' {aka 'int (*)(struct evp_pkey_ctx_st *, struct evp_pkey_ctx_st *)'}
+```
+
+A look into OpenSSL upstream shows that these functions have always had const
+`src` parameters. Thus this error was simply not detected by earlier compiler
+versions.
+
+Upstream-Status: Backport
+
+Signed-off-by: Matthias Gerstner <matthias.gerstner@suse.de>
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+
+---
+ src/tpm2-tss-engine-ecc.c | 4 ++--
+ src/tpm2-tss-engine-rsa.c | 4 ++--
+ 2 files changed, 4 insertions(+), 4 deletions(-)
+
+diff --git a/src/tpm2-tss-engine-ecc.c b/src/tpm2-tss-engine-ecc.c
+index 9e72c85..f6b9c5a 100644
+--- a/src/tpm2-tss-engine-ecc.c
++++ b/src/tpm2-tss-engine-ecc.c
+@@ -52,7 +52,7 @@ EC_KEY_METHOD *ecc_methods = NULL;
+ #endif /* OPENSSL_VERSION_NUMBER < 0x10100000 */
+ 
+ #ifdef HAVE_OPENSSL_DIGEST_SIGN
+-static int (*ecdsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src);
++static int (*ecdsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src);
+ static void (*ecdsa_pkey_orig_cleanup)(EVP_PKEY_CTX *ctx);
+ #endif /* HAVE_OPENSSL_DIGEST_SIGN */
+ 
+@@ -405,7 +405,7 @@ ecdsa_ec_key_sign(const unsigned char *dgst, int dgst_len, const BIGNUM *inv,
+ 
+ #ifdef HAVE_OPENSSL_DIGEST_SIGN
+ static int
+-ecdsa_pkey_copy(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src)
++ecdsa_pkey_copy(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src)
+ {
+     if (ecdsa_pkey_orig_copy && !ecdsa_pkey_orig_copy(dst, src))
+         return 0;
+diff --git a/src/tpm2-tss-engine-rsa.c b/src/tpm2-tss-engine-rsa.c
+index 41de34e..e7260c2 100644
+--- a/src/tpm2-tss-engine-rsa.c
++++ b/src/tpm2-tss-engine-rsa.c
+@@ -49,7 +49,7 @@ RSA_METHOD *rsa_methods = NULL;
+ #endif /* OPENSSL_VERSION_NUMBER < 0x10100000 */
+ 
+ #ifdef HAVE_OPENSSL_DIGEST_SIGN
+-static int (*rsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src);
++static int (*rsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src);
+ static void (*rsa_pkey_orig_cleanup)(EVP_PKEY_CTX *ctx);
+ #endif /* HAVE_OPENSSL_DIGEST_SIGN */
+ 
+@@ -637,7 +637,7 @@ RSA_METHOD rsa_methods = {
+ 
+ #ifdef HAVE_OPENSSL_DIGEST_SIGN
+ static int
+-rsa_pkey_copy(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src)
++rsa_pkey_copy(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src)
+ {
+     if (rsa_pkey_orig_copy && !rsa_pkey_orig_copy(dst, src))
+         return 0;
+-- 
+2.43.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.1.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
similarity index 83%
rename from meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.1.0.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index 89162ee..30865d2 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.1.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -8,9 +8,12 @@ SECTION = "security/tpm"
 
 DEPENDS = "autoconf-archive-native bash-completion libtss2 libgcrypt openssl"
 
-SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/v${PV}/${BPN}-${PV}.tar.gz"
+SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
+           file://0001-Configure-Allow-disabling-of-digest-sign-operations.patch \
+           file://0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch \
+           "
 
-SRC_URI[sha256sum] = "ea2941695ac221d23a7f3e1321140e75b1495ae6ade876f2f4c2ed807c65e2a5"
+SRC_URI[sha256sum] = "3c94fef110dd3630b3c28c5875febba76b7d5ba2fcc04a14c4a30f5d2157c265"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.43.0


