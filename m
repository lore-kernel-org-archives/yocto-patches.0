Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5006.1794867264679000771
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NR/EHSAZ;
 spf=pass (domain: konsulko.com, ip: 209.85.128.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so15362055e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794867263; x=1795472063; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8bAWPNdUnGHsiKdF1FwKlpPUbP1OoqfnhjFrq5+pgnU=;
        b=NR/EHSAZuMTOSJSXX5EGat0qE6TgCpB2gKx9sJFtaAJ97Uu+n/hARz7ddnWqaXNruK
         0k3cKt+ma5dZk5lDYgPbJJtnrrV5QCJWJi1Wcg/sORWPI/7NoUK1e3GCs6JvtZN0yQu7
         xPNsLtlexi3myLxN4ZuwqrxRtJPmN6Y2zCGpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867263; x=1795472063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8bAWPNdUnGHsiKdF1FwKlpPUbP1OoqfnhjFrq5+pgnU=;
        b=S6Gg5BFT31rM2f01ksbTjZu8g8+eUTn0fkiaAGZQwdK2qTziX35SYtSdoDmKXCwShw
         Am88ARuCB88EmZyKstoD2frO9XCmABUGp1d4bJHeCYL/1e/i2PLg9JqDLgUk3+NUwOH0
         TgZS5ujTRddvF2JI11r5XD5UHTdfFygTJp/MZwfdoboZ1JOFrGU/rRkIMJQpNss4285c
         bBJ0rm/DmvJiT3oJ4oPKyyup0Um6Ldx3JjtGdemqYGEMHhtnWXW8LAjXxFT9EQydA8jn
         bdA/fkt2YV6YoKDbgOk0S9U6RIgofDgUcbHRxtP3ngLFgh2y2ENiHTO8ji58WWfcZZBi
         qS0w==
X-Gm-Message-State: APuU4Z+ZgLXW3tXKkZajYQKSo2eG1BeaZRtaZ78wEeoxGg6i+iyIESlt
	4DcHrCnjF6PfnIQzVZBm6Qyb8+LOy3FR7cv+FN0nVhqoe1qCpFZKYKTZTubpTqtBxDs0bIJeIJG
	kDayre/0=
X-Gm-Gg: AYBFou2p/YEgLusr2sz0Tq8+fDUTmV04FAYT0rvKhZBHUYzh253odlZ1W4rbyiyfL+Q
	0KSVrFO85T0wOIWj6vMP3VVHK73BtFvihXrnPaQ6iHtRn1zUTCFyY86NP6H4KAaLM2GZ1UXGYvi
	THnn/7u43wPYuHGhep5c/O3PKIaIgblIcHmhMYOPakeyTwuZRejBh82K77UnQ1MsgWJGdHOhwc8
	ORpJRxoscrnQ2d1iSGHOywGkk6kiV7eI9L1/uPyOQmLqIzcLXJqOBDt1uw0r+1542C3Y0YmlaMs
	OkduGJPMrZbe4F/jh00PHHo0O2F7uGVm8PsoabtyOptm9GyRbu59H1cH+2J5oovb6otlUA0Hg+J
	M2JorpKl74c6gBWuW20/7UXoCGbhXrAyehrkv6qPx1XsxwXB6y7Ev15cqlTvyBT00Pannjg7RDw
	eIoLZ8Yd7E/jUHzanGroDTubYat5LrT7/+BhQV3XCWB5BwDiYuGeN2kP+OzrcBT4wp/mgNj2a32
	kvLXABkq958KUGyJTiH3nqGo2KWNKuN5hzX+GcHCDjrKgVOBI6ai4vEouDihoRW3zNlU/oWQmSr
	U4IbAsvfYKcKhb0tPVuNwVjD2wNNqdqRnQNnbzT0FaRDEIOgUBLuVLsVpOsZJy0snfP8ZSiejRS
	vAzg7XSwOmsxjEMb6p1LkU8NifdJ4Qw==
X-Received: by 2002:a7b:ce9a:0:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb55a911aemr165680895e9.28.1794867262500;
        Mon, 16 Nov 2026 14:14:22 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm24346413f8f.9.2026.11.16.14.14.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:14:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] tpm2-openssl: Fix building with OpenSSL 4.1.0
Date: Tue, 17 Nov 2026 00:14:06 +0200
Message-ID: <eded1d1d6f120e4c752359a54c8238ca0fc0b0ff.1794866391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1794866391.git.scott.murray@konsulko.com>
References: <cover.1794866391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:14:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5427
Content-Type: text/plain; charset="utf-8"

Backport a patch to fix building tpm2-openssl after oe-core's upgrade
to OpenSSL 4.1.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...key-fix-compilation-with-OpenSSL-4.1.patch | 87 +++++++++++++++++++
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
 2 files changed, 88 insertions(+)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
new file mode 100644
index 0000000..159354a
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
@@ -0,0 +1,87 @@
+From 7260f90e981279e078835814d02968c134122a8a Mon Sep 17 00:00:00 2001
+From: Moritz Buhl <moritz.buhl@infineon.com>
+Date: Tue, 1 Sep 2026 09:58:28 +0200
+Subject: [PATCH] pkey: fix compilation with OpenSSL 4.1
+
+Avoid deprecated OpenSSL functions, add fallback defines for older
+versions:
+src/tpm2-provider-pkey.c:91:5: error: 'ASN1_STRING_set' is deprecated:
+Since OpenSSL 4.1; use ASN1_STRING_set1_data() or ASN1_STRING_set1_string()
+[-Werror,-Wdeprecated-declarations]
+src/tpm2-provider-pkey.c:165:41: error: 'ASN1_STRING_length' is deprecated:
+Since OpenSSL 4.1; use ASN1_STRING_get_length()
+[-Werror,-Wdeprecated-declarations]
+
+Add missing header:
+src/tpm2-provider-pkey.c:32:1: error: call to undeclared function 'ERR_raise';
+ISO C99 and later do not support implicit function declarations
+[-Wimplicit-function-declaration]
+
+Signed-off-by: Moritz Buhl <moritz.buhl@infineon.com>
+
+Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-openssl/commit/6dcc3b2984e3f4dc1849c79d89c6ce736a8435b3]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ src/tpm2-provider-pkey.c | 22 ++++++++++++++++------
+ 1 file changed, 16 insertions(+), 6 deletions(-)
+
+diff --git a/src/tpm2-provider-pkey.c b/src/tpm2-provider-pkey.c
+index 80213af..bb56ba7 100644
+--- a/src/tpm2-provider-pkey.c
++++ b/src/tpm2-provider-pkey.c
+@@ -2,6 +2,8 @@
+ 
+ #include <string.h>
+ 
++#include <openssl/err.h>
++#include <openssl/opensslv.h>
+ #include <openssl/pem.h>
+ #include <openssl/rand.h>
+ 
+@@ -9,6 +11,14 @@
+ 
+ #include "tpm2-provider-pkey.h"
+ 
++#if OPENSSL_VERSION_NUMBER >= 0x40100000
++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_get_length(x)
++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set1_data(s, d, l)
++#else
++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_length(x)
++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set(s, d, l)
++#endif
++
+ typedef struct {
+     ASN1_OBJECT *type;
+     ASN1_BOOLEAN emptyAuth;
+@@ -81,8 +91,8 @@ tpm2_keydata_write(const TPM2_KEYDATA *keydata, BIO *bout, TPM2_PKEY_FORMAT form
+     else
+         ASN1_INTEGER_set_uint64(tpk->parent, TPM2_RH_OWNER);
+ 
+-    ASN1_STRING_set(tpk->privkey, &privbuf[0], privbuf_len);
+-    ASN1_STRING_set(tpk->pubkey, &pubbuf[0], pubbuf_len);
++    TPM2_ASN1_STRING_set1_data(tpk->privkey, &privbuf[0], privbuf_len);
++    TPM2_ASN1_STRING_set1_data(tpk->pubkey, &pubbuf[0], pubbuf_len);
+ 
+     switch (format) {
+     case KEY_FORMAT_PEM:
+@@ -150,13 +160,13 @@ tpm2_keydata_read(BIO *bin, TPM2_KEYDATA *keydata, TPM2_PKEY_FORMAT format)
+         goto error;
+ 
+     if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(ASN1_STRING_get0_data(tpk->privkey),
+-                                        ASN1_STRING_length(tpk->privkey), NULL,
+-                                        &keydata->priv))
++                                        TPM2_ASN1_STRING_get_length(tpk->privkey),
++                                        NULL, &keydata->priv))
+         goto error;
+ 
+     if (Tss2_MU_TPM2B_PUBLIC_Unmarshal(ASN1_STRING_get0_data(tpk->pubkey),
+-                                       ASN1_STRING_length(tpk->pubkey), NULL,
+-                                       &keydata->pub))
++                                       TPM2_ASN1_STRING_get_length(tpk->pubkey),
++                                       NULL, &keydata->pub))
+         goto error;
+ 
+     TSSPRIVKEY_free(tpk);
+-- 
+2.47.3
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
index 07feb00..fdef883 100644
--- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
@@ -7,6 +7,7 @@ DEPENDS = "autoconf-archive-native tpm2-tss openssl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
            file://0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch \
+           file://0002-pkey-fix-compilation-with-OpenSSL-4.1.patch \
            "
 
 SRC_URI[sha256sum] = "9a9aca55d4265ec501bcf9c56d21d6ca18dba902553f21c888fe725b42ea9964"
-- 
2.47.3

