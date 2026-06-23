Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9ADCD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:48 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14976.1782195038731725200
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gTPyl+GY;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6856433b0so3979765ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195038; x=1782799838; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3fxQnp+iOjUrYQ9b5oKSR0aNEWSELapkO6tmNPgYg=;
        b=gTPyl+GYPtkJsE7st17FlOANf1DyRU2v0M7RLRGbIvqe9hYbAqEckSIRWofeQHbtJF
         el2g7otqjjAkWc1AuQdh8LrWFqp74IEySa0TmHBgxli4NlvD9HufDEtNIE7UuVszBn3Y
         /YnhKrI07uwHsaELSfAiuErbraPE/AbWbdqWbrXmWxrRhIQNryGi5Y+Q6Q4szHdd2GBt
         NxL5v3rk63iGaYT2KkSIQHkNvmJmt1FexA0g44yxAdz5uFXv2m+9vTMncCujOumC9muU
         wXQsECBmuVmNJDwSokKjtHTsGqdCPQcA01STu3x/Zuo0c+VnUDJaD8MLCTC4NtZhy7u5
         PgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195038; x=1782799838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ3fxQnp+iOjUrYQ9b5oKSR0aNEWSELapkO6tmNPgYg=;
        b=F7pywqmer2JGWALwMot50Ufawg7qsPLpS30M9z0vZ1spD5/fVsCPbfpJEpxe2z8Yht
         dIK4/4dT9W0BWpxplYrUK+4U+qcpoJREpo2Fdnhlcd18JqqKxYqbz6dnLq9I72eML7/r
         Vq5tNUcRyO/B4Z4+aErEUgp0XiGAoOwT78RCcfIlkRRh0HDWHS1jadhfwsEXU40/OvGQ
         saxsrxexeBe7+jGSrzjrUQc+rtoaYBvwKui+fFsyxePS0CSpLW0zAv91+dZE4JXLHTtt
         c88QrWOB33HVxlZoFe2Jo2Lk59vQLGioB3AeZcSifriMJv0xfKWsddONvjln9KLJy/Dt
         tLmw==
X-Gm-Message-State: AOJu0YygRZxjeZkVAmQWG/ySOWUWdaLiMZVWqVoHoa4j9ppg3EIoqPB3
	ovSumcFdkvoOvOvRWNWCXi1NAiFxaGvjfPGlUI9ablChU5dcnNZOPjBt9INv2fvqrL0=
X-Gm-Gg: AfdE7clA5QsEyiYHrKrqiF9SW69Bz0Ca7TRa9mycxj9WRRr+1zi9b1MJ0AbLBs8bz0t
	LUZLOx377zURLlV0P8jrhmOz7iSdneHIsPxOo8fZ7PpWlv2rqb60vUoBkjncfFUB5dxPurjMK9v
	l+nyQnJ6ZXLrv9/o/OEdEfvy7mP/KwEnq4iXZCiD+hTs/ssRl1ZcmiKO9LwK+fkfJqdB6yik2K5
	cP2YaOVyy5Hg+/Mgg3DOMm3mGGxRDluq3UyAl3F5irMHqb1Ll6JSBH2yhxsZrdq605MRMBBHUok
	mTBiIRcMKRURYtBX6Je7XGTMVMETiSWOdNgRb6qfqolPHomCfeFYBgegLaDm6JaF9dy0iYAxxDl
	eFAJh6cxg3xqwtWu+itpqVagXGgWSKEQnwrp68UTZtYHpCg9o3SjBWW3unf8sR/6uwaLP7nU0KZ
	DY+VxhxOWWKivkKKlsk5GwowZRAey11TMJRg==
X-Received: by 2002:a17:902:d4d0:b0:2c0:ab82:6b98 with SMTP id d9443c01a7336-2c7bf1b3d2fmr15778205ad.3.1782195037878;
        Mon, 22 Jun 2026 23:10:37 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:37 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 7/7] strongswan: Fix CVE-2026-35334
Date: Tue, 23 Jun 2026 11:40:01 +0530
Message-Id: <20260623061001.644583-7-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4273

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35334.patch     | 244 ++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |   1 +
 2 files changed, 245 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35334.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35334.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35334.patch
new file mode 100644
index 0000000..cb6777a
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35334.patch
@@ -0,0 +1,244 @@
+From: Tobias Brunner <tobias@strongswan.org>
+Date: Tue, 24 Mar 2026 18:00:23 +0100
+Subject: gmp: Avoid crash and timing leaks in PKCS#1 v1.5 decryption padding
+ validation
+MIME-Version: 1.0
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: 8bit
+
+This fixes a potential crash due to a null-pointer dereference if rsadp()
+returns NULL (e.g. with an all-zero ciphertext).
+
+And it also implements the PKCS#1 v1.5 decryption padding check in
+constant time.
+
+The timing leak caused by the previous implementation was measured at
+~17.5 μs at 3 GHz, which could allow a Bleichenbacher-like attack in
+LAN environments.  However, because of how RSA encryption is used in
+strongSwan, this is not that much of an issue in practice.  The mechanism
+is only used for two use cases.  One is SCEP/EST via PKCS#7 enveloped
+data.  Fortunately, this can not be triggered in significant numbers by
+an attacker.  The other use case is TLS as used by EAP methods (EAP-TLS,
+EAP-PEAP/TTLS) during the authentication.  While the cipher suites that
+use RSA encryption are still enabled by default, the TLS messages are
+wrapped in EAP and encrypted by IKE, making any kind of attack difficult.
+
+Note that the gmp plugin isn't enabled anymore by default.  And even
+before that, most setups had the openssl plugin enabled, which has
+priority over the gmp plugin.  So it's unlikely the plugin was used in
+practice.
+
+Also note that this patch doesn't modify libstrongswan's Makefile.am
+to avoid potentially requiring autotools when patching a tarball.
+
+Fixes: d615ffdcf3cd ("implement gmp_rsa_private_key.decrypt()")
+Fixes: CVE-2026-35334
+
+CVE: CVE-2026-35334
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libstrongswan/plugins/gmp/gmp_rsa_private_key.c b/src/libstrongswan/plugins/gmp/gmp_rsa_private_key.c
+index 47784b6..08c5eee 100644
+--- a/src/libstrongswan/plugins/gmp/gmp_rsa_private_key.c
++++ b/src/libstrongswan/plugins/gmp/gmp_rsa_private_key.c
+@@ -495,8 +495,8 @@ METHOD(private_key_t, decrypt, bool,
+ 	private_gmp_rsa_private_key_t *this, encryption_scheme_t scheme,
+ 	void *params, chunk_t crypto, chunk_t *plain)
+ {
+-	chunk_t em, stripped;
+-	bool success = FALSE;
++	chunk_t em;
++	u_int valid, i, j, found_sep = 0, sep_index = 0, m_index;
+ 
+ 	if (scheme != ENCRYPT_RSA_PKCS1)
+ 	{
+@@ -505,33 +505,51 @@ METHOD(private_key_t, decrypt, bool,
+ 		return FALSE;
+ 	}
+ 	/* rsa decryption using PKCS#1 RSADP */
+-	stripped = em = rsadp(this, crypto);
++	em = rsadp(this, crypto);
++	if (em.len != this->k)
++	{
++		return FALSE;
++	}
+ 
+-	/* PKCS#1 v1.5 8.1 encryption-block formatting (EB = 00 || 02 || PS || 00 || D) */
++	/* PKCS#1 v1.5, RFC 8017, section 7.2.2 message structure:
++	 * EM = 00 || 02 || PS || 00 || M */
+ 
+ 	/* check for hex pattern 00 02 in decrypted message */
+-	if ((*stripped.ptr++ != 0x00) || (*(stripped.ptr++) != 0x02))
++	valid  = constant_time_eq(em.ptr[0], 0x00);
++	valid &= constant_time_eq(em.ptr[1], 0x02);
++
++        /* the plaintext data starts after first 0x00 byte */
++	for (i = 2; i < em.len; i++)
+ 	{
+-		DBG1(DBG_LIB, "incorrect padding - probably wrong rsa key");
+-		goto end;
++		u_int zero = constant_time_eq(em.ptr[i], 0x00);
++
++		sep_index = constant_time_select(i, sep_index, ~found_sep & zero);
++		found_sep |= zero;
+ 	}
+-	stripped.len -= 2;
+ 
+-	/* the plaintext data starts after first 0x00 byte */
+-	while (stripped.len-- > 0 && *stripped.ptr++ != 0x00)
++	/* make sure PS is at least eight bytes long (plus the initial bytes) */
++	valid &= constant_time_ge(sep_index, 10);
+ 
+-	if (stripped.len == 0)
++	/* instead of copying the message directly, we try not to reveal the message
++         * length i.e. where the 0x00 byte was. and since clearing a chunk is
++         * relatively efficient, i.e. doesn't leak much, we always allocate and copy
++         * a value and then clear it if the structure was invalid */
++         m_index = constant_time_select(sep_index + 1, 11, valid);
++
++	*plain = chunk_alloc(this->k);
++	for (i = 0, j = 0; i < em.len; i++)
+ 	{
+-		DBG1(DBG_LIB, "no plaintext data");
+-		goto end;
++		plain->ptr[j] = em.ptr[i];
++		j += constant_time_ge(i, m_index);
+ 	}
++	plain->len = j;
+ 
+-	*plain = chunk_clone(stripped);
+-	success = TRUE;
+-
+-end:
++	if (!valid)
++	{
++		chunk_clear(plain);
++	}
+ 	chunk_clear(&em);
+-	return success;
++	return valid;
+ }
+ 
+ METHOD(private_key_t, get_keysize, int,
+diff --git a/src/libstrongswan/utils/utils.h b/src/libstrongswan/utils/utils.h
+index 40fe76a..80199a9 100644
+--- a/src/libstrongswan/utils/utils.h
++++ b/src/libstrongswan/utils/utils.h
+@@ -53,6 +53,7 @@
+ #include "utils/atomics.h"
+ #include "utils/align.h"
+ #include "utils/byteorder.h"
++#include "utils/constant_time.h"
+ #include "utils/string.h"
+ #include "utils/memory.h"
+ #include "utils/strerror.h"
+diff --git a/src/libstrongswan/utils/utils/constant_time.h b/src/libstrongswan/utils/utils/constant_time.h
+new file mode 100644
+index 0000000..30a8549
+--- /dev/null
++++ b/src/libstrongswan/utils/utils/constant_time.h
+@@ -0,0 +1,103 @@
++/*
++ * Copyright (C) 2026 Tobias Brunner
++ *
++ * Copyright (C) secunet Security Networks AG
++ *
++ * This program is free software; you can redistribute it and/or modify it
++ * under the terms of the GNU General Public License as published by the
++ * Free Software Foundation; either version 2 of the License, or (at your
++ * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
++ *
++ * This program is distributed in the hope that it will be useful, but
++ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
++ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
++ * for more details.
++ */
++
++/**
++ * @defgroup constant_time_i constant_time
++ * @{ @ingroup constant_time_i
++ */
++
++#ifndef CONSTANT_TIME_H_
++#define CONSTANT_TIME_H_
++
++#include <stdint.h>
++
++/**
++ * Check if the given values are not equal in constant time.
++ *
++ * @param x            first value to check
++ * @param y            second value to check
++ * @return             1 if values are not equal, 0 otherwise
++ */
++static inline u_int constant_time_neq(uint32_t x, uint32_t y)
++{
++       return ((x-y) | (y-x)) >> 31;
++}
++
++/**
++ * Check if the given values are equal in constant time.
++ *
++ * @param x            first value to check
++ * @param y            second value to check
++ * @return             1 if values are equal, 0 otherwise
++ */
++static inline u_int constant_time_eq(uint32_t x, uint32_t y)
++{
++       return 1 ^ constant_time_neq(x, y);
++}
++
++/**
++ * Compare the two values and return 1 if the first argument is lower than
++ * the second in constant time.
++ *
++ * @param x            first value to check
++ * @param y            second value to check
++ * @return             1 if first value is lower than second
++ */
++static inline u_int constant_time_lt(uint32_t x, uint32_t y)
++{
++       return (x ^ ((x^y) | ((x-y) ^ y))) >> 31;
++}
++
++/**
++ * Compare the two values and return 1 if the first argument greater or equal to
++ * the second in constant time.
++ *
++ * @param x            first value to check
++ * @param y            second value to check
++ * @return             1 if first value is greater or equal to the second
++ */
++static inline u_int constant_time_ge(uint32_t x, uint32_t y)
++{
++       return 1 ^ constant_time_lt(x, y);
++}
++
++/**
++ * Return a 32-bit all bit-set mask if the given value is not 0.
++ *
++ * @param x            value to check
++ * @return             0xffffffff if value is != 0, 0 otherwise
++ */
++static inline uint32_t constant_time_mask(uint32_t x)
++{
++       return -(uint32_t)constant_time_neq(x, 0);
++}
++
++/**
++ * Select one of two values depending on whether the condition is != 0 or not.
++ * Basically equivalent to 'c ? x : y'.
++ *
++ * @param x            first value to select
++ * @param y            second value to select
++ * @param c            condition
++ * @return             x if c is != 0, y otherwise
++ */
++static inline uint32_t constant_time_select(uint32_t x, uint32_t y, uint32_t c)
++{
++       uint32_t m = constant_time_mask(c);
++       return (x & m) | (y & ~m);
++}
++
++#endif /** CONSTANT_TIME_H_ @} */
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index ecc7788..ce3f750 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -6,4 +6,5 @@ SRC_URI += "\
     file://CVE-2026-35331.patch \
     file://CVE-2026-35332.patch \
     file://CVE-2026-35333.patch \
+    file://CVE-2026-35334.patch \
 "
-- 
2.34.1


