Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BCDC982D4
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26477.1789595931873059287
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nNf/x4xp;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c9ff1fso15315285a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595931; x=1790200731; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HIjIXBtKyKgmb0ris0y8S1P1mdnVXjP9OCH1Sm1ich8=;
        b=nNf/x4xpeBLFkfkEvCkg1MMb9oX+0UcFn4c+ME7G0GLsazulOA4RPwJdkGl+lg9Rt2
         fgc0yMzX/DmbfndIvWFAgdpfGZ03+kUv3B50LOg3g+EY3p3saajMcX9/lutLYOhD+Zzx
         wSyKrqD6QqOA4aOj/z2gfu6x0DKN7PYLSRfVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595931; x=1790200731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HIjIXBtKyKgmb0ris0y8S1P1mdnVXjP9OCH1Sm1ich8=;
        b=a1z/DNG5wTgZNQWpcW97ALmFrA4lNCMBwja1rWpdl7j2EWYaUmTypwKtIoJKgIuCv7
         /yifx/cy1wjplxzxdBxfe4ks19wltonqeDKz0h6yAD8AqNf4uytOXWisLstOVi0M8zbH
         //VQAmxBvejV5rdRpFA7Ri4eBo4OO/Hty5qwD6D3bw3cnB1VKT39RQhKgL9laulRB3Oh
         pUj3QdcVmTSrh/wG32euchuMBG4Ht3UKlIoeHqjdt4tly3rYcClaYlVhQCrKVhQS7Pgx
         Uy6qzvAIAsp/RYTanom6onCYodSECJSF25mOs1caKpdnJ56bULFDFmp3rOQKR05//s5I
         HI/w==
X-Gm-Message-State: AFuF++nVSy+TTiywjqEY7QHAEVr9ciLQy2QK0u1mi8IuxSuU4HtH8lCE
	j7CS8u1Kp03IApCP4nVPnjxrtr2sdKQUgOJzPXDPqYoOMxxePHUG/MHxBEggQAnRaKDNqUVlEyl
	sTBJV
X-Gm-Gg: AYBFou20ggzmjetANMllHIaWTgiJWCKO5BbI77Rx1jNKjhOyE7kuBAFBKE5dM70qtod
	/fxtwp93FlMkO1w4gQpzWgyXf5ptvdrOyDAkEtGkcjuEZAspe0TWskHjqMizYABVdQbNkkCJEjq
	aC+Rtury3d/wEeXCGjY9x4HbED5XIdvFxzlpCFnHGSBldaxpxysFjrOq6BsYCG1j4AVSYQKjUwU
	+ak6MqFJ1aaV8pnxsHt2Qp8JEacXNtyUtJeZpN3RZZwja7kWbGVHmM0badWhFsJA3xG6jEc2tTF
	a1/p1x72YMpKFDM3bFTUce01frJvidacAVhkmt7F1BdpID5v2H8zi3O4QNpurmez0fOYCbchLIh
	50iL+KjWlS/qlIChrR+LxjpzoSso8vdLU8WuQT4C3HbxAB3rFmgoeMvU733LAaQlrvH096tTqZg
	z1Itqk39ZaexjVqpaq9+6nAuhMgSauGXaeywjApSnnv3UUmkfV8ZI+tj1s0HxiLJhSW0fZGFr9x
	I8YD7/4j4q2BdTKZX+ofxSPFC9lZEwraGHyZJNtbG9k35PsYZqcojPlInnDrZtQHWLyCQT1Ab7U
	DecPC43FnhGB/GgVTN5O7k+bMtd/SK951ZE=
X-Received: by 2002:a05:620a:2610:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93bb785c5a0mr749381185a.27.1789595930548;
        Wed, 16 Sep 2026 14:58:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 14/19] meta-tpm: Remove tpm2-tss-engine
Date: Wed, 16 Sep 2026 17:58:14 -0400
Message-ID: <e53abc5d1a4e58623fae40ef9d506f8d3a097c8a.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4870

From: Khem Raj <raj.khem@gmail.com>

OpenSSL 4.x no longer supports engines, so remove recipe.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
(Added removing recipe and updated commit message)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../distro/include/maintainers-meta-tpm.inc   |  1 -
 .../packagegroup-security-tpm2.bb             |  2 -
 ...-disabling-of-digest-sign-operations.patch | 48 ------------
 ...OpenSSL-function-signatures-that-cau.patch | 78 -------------------
 .../tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb  | 40 ----------
 5 files changed, 169 deletions(-)
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb

diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index 0ba4f1b..0507ca4 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -29,7 +29,6 @@ RECIPE_MAINTAINER:pn-tpm-tools = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-abrmd = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-totp = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-tcti-uefi = "Scott Murray <scott.murray@konsulko.com>"
-RECIPE_MAINTAINER:pn-tpm2-tss-engine = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-pkcs11 = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-tss = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-tools = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
index b04851f..423a86f 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
@@ -22,7 +22,5 @@ RDEPENDS:packagegroup-security-tpm2 = " \
     tpm2-abrmd \
     tpm2-pkcs11 \
     tpm2-openssl \
-    tpm2-tss-engine \
-    tpm2-tss-engine-engines \
     python3-tpm2-pytss \
     "
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
deleted file mode 100644
index f0f1fad..0000000
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0001-Configure-Allow-disabling-of-digest-sign-operations.patch
+++ /dev/null
@@ -1,48 +0,0 @@
-From af8b26e7ffe69837197fb841e9a31230ae01c9cc Mon Sep 17 00:00:00 2001
-From: Andreas Fuchs <andreas.fuchs@infineon.com>
-Date: Mon, 22 May 2023 14:06:41 +0200
-Subject: [PATCH 1/2] Configure: Allow disabling of digest-sign operations
-
-Since the digest-sign operations perform the hash on the TPM and
-TPMs in general do not support SHA512, this can lead to errors.
-Depending on the use case, it might be preferable to not support
-restricted keys (via digest+sign) but to rely on ordinary keys
-only.
-
-Upstream-Status: Backport
-Signed-off-by: Andreas Fuchs <andreas.fuchs@infineon.com>
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
----
- configure.ac | 10 ++++++++--
- 1 file changed, 8 insertions(+), 2 deletions(-)
-
-diff --git a/configure.ac b/configure.ac
-index d4a9356..b379042 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -116,13 +116,19 @@ PKG_CHECK_MODULES([CRYPTO], [libcrypto >= 1.0.2g],
- PKG_CHECK_MODULES([TSS2_ESYS], [tss2-esys >= 2.3])
- PKG_CHECK_MODULES([TSS2_MU], [tss2-mu])
- PKG_CHECK_MODULES([TSS2_TCTILDR], [tss2-tctildr])
-+
- AC_CHECK_LIB([crypto], EC_KEY_METHOD_set_compute_key,
-       [AM_CONDITIONAL([HAVE_OPENSSL_ECDH], true)],
-       [AM_CONDITIONAL([HAVE_OPENSSL_ECDH], false)])
-+
-+AC_ARG_ENABLE([digestsign],
-+              [AS_HELP_STRING([--disable-digestsign],
-+                              [Disable support for digest and sign methods, helps with TPM unsupported hash algorithms.])],,
-+              [enable_digestsign=yes])
- AC_CHECK_LIB([crypto], EVP_PKEY_meth_set_digest_custom,
--      [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], true)],
-+      [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], [test "x$enable_digestsign" != "xno"])],
-       [AM_CONDITIONAL([HAVE_OPENSSL_DIGEST_SIGN], false)])
--AS_IF([test "x$ac_cv_lib_crypto_EVP_PKEY_meth_set_digest_custom" = xyes],
-+AS_IF([test "x$ac_cv_lib_crypto_EVP_PKEY_meth_set_digest_custom" = xyes && test "x$enable_digestsign" = "xyes"],
-       [AC_DEFINE([HAVE_OPENSSL_DIGEST_SIGN], [1],
-                  Have required functionality from OpenSSL to support digest and sign)])
- 
--- 
-2.43.0
-
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch b/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
deleted file mode 100644
index 0bd4e2e..0000000
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/files/0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch
+++ /dev/null
@@ -1,78 +0,0 @@
-From 766505bf5c943c614fd246d27d1e5cd66543250b Mon Sep 17 00:00:00 2001
-From: Matthias Gerstner <matthias.gerstner@suse.de>
-Date: Mon, 6 May 2024 16:07:54 +0200
-Subject: [PATCH 2/2] Fix mismatch of OpenSSL function signatures that cause
- errors with gcc-14
-
-Building with gcc-14 fails with diagnostics like this:
-
-```
-src/tpm2-tss-engine-rsa.c:805:46: error: passing argument 2 of 'EVP_PKEY_meth_set_copy' from incompatible pointer type [-Wincompatible-pointer-types]
-  805 |     EVP_PKEY_meth_set_copy(pkey_rsa_methods, rsa_pkey_copy);
-      |                                              ^~~~~~~~~~~~~
-      |                                              |
-      |                                              int (*)(EVP_PKEY_CTX *, EVP_PKEY_CTX *) {aka int (*)(struct evp_pkey_ctx_st *, struct evp_pkey_ctx_st *)}
-/usr/include/openssl/evp.h:2005:36: note: expected 'int (*)(EVP_PKEY_CTX *, const EVP_PKEY_CTX *)' {aka 'int (*)(struct evp_pkey_ctx_st *, const struct evp_pkey_ctx_st *)'} but argument is of type 'int (*)(EVP_PKEY_CTX *, EVP_PKEY_CTX *)' {aka 'int (*)(struct evp_pkey_ctx_st *, struct evp_pkey_ctx_st *)'}
-```
-
-A look into OpenSSL upstream shows that these functions have always had const
-`src` parameters. Thus this error was simply not detected by earlier compiler
-versions.
-
-Upstream-Status: Backport
-
-Signed-off-by: Matthias Gerstner <matthias.gerstner@suse.de>
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
----
- src/tpm2-tss-engine-ecc.c | 4 ++--
- src/tpm2-tss-engine-rsa.c | 4 ++--
- 2 files changed, 4 insertions(+), 4 deletions(-)
-
-diff --git a/src/tpm2-tss-engine-ecc.c b/src/tpm2-tss-engine-ecc.c
-index 9e72c85..f6b9c5a 100644
---- a/src/tpm2-tss-engine-ecc.c
-+++ b/src/tpm2-tss-engine-ecc.c
-@@ -52,7 +52,7 @@ EC_KEY_METHOD *ecc_methods = NULL;
- #endif /* OPENSSL_VERSION_NUMBER < 0x10100000 */
- 
- #ifdef HAVE_OPENSSL_DIGEST_SIGN
--static int (*ecdsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src);
-+static int (*ecdsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src);
- static void (*ecdsa_pkey_orig_cleanup)(EVP_PKEY_CTX *ctx);
- #endif /* HAVE_OPENSSL_DIGEST_SIGN */
- 
-@@ -405,7 +405,7 @@ ecdsa_ec_key_sign(const unsigned char *dgst, int dgst_len, const BIGNUM *inv,
- 
- #ifdef HAVE_OPENSSL_DIGEST_SIGN
- static int
--ecdsa_pkey_copy(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src)
-+ecdsa_pkey_copy(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src)
- {
-     if (ecdsa_pkey_orig_copy && !ecdsa_pkey_orig_copy(dst, src))
-         return 0;
-diff --git a/src/tpm2-tss-engine-rsa.c b/src/tpm2-tss-engine-rsa.c
-index 41de34e..e7260c2 100644
---- a/src/tpm2-tss-engine-rsa.c
-+++ b/src/tpm2-tss-engine-rsa.c
-@@ -49,7 +49,7 @@ RSA_METHOD *rsa_methods = NULL;
- #endif /* OPENSSL_VERSION_NUMBER < 0x10100000 */
- 
- #ifdef HAVE_OPENSSL_DIGEST_SIGN
--static int (*rsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src);
-+static int (*rsa_pkey_orig_copy)(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src);
- static void (*rsa_pkey_orig_cleanup)(EVP_PKEY_CTX *ctx);
- #endif /* HAVE_OPENSSL_DIGEST_SIGN */
- 
-@@ -637,7 +637,7 @@ RSA_METHOD rsa_methods = {
- 
- #ifdef HAVE_OPENSSL_DIGEST_SIGN
- static int
--rsa_pkey_copy(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src)
-+rsa_pkey_copy(EVP_PKEY_CTX *dst, const EVP_PKEY_CTX *src)
- {
-     if (rsa_pkey_orig_copy && !rsa_pkey_orig_copy(dst, src))
-         return 0;
--- 
-2.43.0
-
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
deleted file mode 100644
index e620995..0000000
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ /dev/null
@@ -1,40 +0,0 @@
-SUMMARY = "The tpm2-tss-engine project implements a cryptographic engine for OpenSSL." 
-DESCRIPTION = "The tpm2-tss-engine project implements a cryptographic engine for OpenSSL for Trusted Platform Module (TPM 2.0) using the tpm2-tss software stack that follows the Trusted Computing Groups (TCG) TPM Software Stack (TSS 2.0). It uses the Enhanced System API (ESAPI) interface of the TSS 2.0 for downwards communication. It supports RSA decryption and signatures as well as ECDSA signatures."
-HOMEPAGE = "https://github.com/tpm2-software/tpm2-tss-engine"
-
-LICENSE = "BSD-3-Clause"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=7b3ab643b9ce041de515d1ed092a36d4"
-
-SECTION = "security/tpm"
-
-DEPENDS = "autoconf-archive-native bash-completion libtss2 openssl"
-
-SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
-           file://0001-Configure-Allow-disabling-of-digest-sign-operations.patch \
-           file://0002-Fix-mismatch-of-OpenSSL-function-signatures-that-cau.patch \
-           "
-
-SRC_URI[sha256sum] = "3c94fef110dd3630b3c28c5875febba76b7d5ba2fcc04a14c4a30f5d2157c265"
-
-UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
-
-inherit autotools-brokensep pkgconfig systemd
-
-# It uses the API deprecated since the OpenSSL 3.0
-CFLAGS:append = ' -Wno-deprecated-declarations -Wno-unused-parameter'
-
-do_configure:prepend() {
-    # do not extract the version number from git
-    sed -i -e 's/m4_esyscmd_s(\[git describe --tags --always --dirty\])/${PV}/' ${S}/configure.ac
-}
-
-PACKAGES += "${PN}-engines ${PN}-engines-staticdev ${PN}-bash-completion"
-
-FILES:${PN}-dev = "${includedir}/*"
-FILES:${PN}-engines = "${libdir}/engines-3/*.so*"
-FILES:${PN}-engines-staticdev = "${libdir}/engines-3/libtpm2tss.a"
-FILES:${PN}-bash-completion += "${datadir}/bash-completion/completions"
-
-# The tpm2tss.so symlink is in the main package because OpenSSL
-# searches for the shared object via the symlink.
-INSANE_SKIP:${PN}-engines += "dev-so"
-- 
2.55.0


