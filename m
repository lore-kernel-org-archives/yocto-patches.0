Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21671C982D9
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:51 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26475.1789595929954372831
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kUGeqNyn;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910a0cefaso11565785a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595929; x=1790200729; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=us28+U6Eowt764eQCNtKd059yKJrOzP+to7c1jLpBKQ=;
        b=kUGeqNyni6HkU1sRH3u1oUfTa3V7CXY3gMWdxjO0GwtA+/k6sH+gWPumB2OyzWNVMz
         +CbCleHEztF926o0ocXaeAvDW4iC1tDSvvXOV6C9O1JUD94KSCz47HpeO5omZxgO2RBh
         giYLH3uAk1472VzVlzWYUyYsOrcZU2oH7/xU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595929; x=1790200729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=us28+U6Eowt764eQCNtKd059yKJrOzP+to7c1jLpBKQ=;
        b=VbMP5mVeZ8xnyx3BmQoCM5myTCDI1n3R0pTS3xBaLeIn9XdcKbq+fBT3DhtAxmwEF5
         xRXcjcsLZiYRl/2hbmtfn9Nbr7ODP5HkgrvW63ZBw6350ZQuOddILuD2e5eLQ7NYCdnk
         3fgB7QbXWyrtPZks+rMw/DzfIQ+wkmhvECXStrKoLJZOTk+Gd+KlADC8zsbwL61+V3kc
         qX9tkluxq7MXRFjH6KCIxSthNai5uz9rKz2cBq6a41WuDvLVHDV49lhvR31TW4cr7RTv
         opyWPf4fCHFySoV6f5ru/GvlaB1JeUMONo20zmJgt1PTVVJOQmNQiytFcuGJ2CLD307e
         ypUA==
X-Gm-Message-State: AFuF++m1ekyrd/Kl6YJlV44Q8vCULmj/u12jkJnbjZHdDKywV7MlyM25
	xtwkqG4VZrszt6TPrmtldXTDZid7rYAch3EbFDoECtuHYRTll2kFRExP9eoK8g6O2iRs0DhGo4u
	7G5C6
X-Gm-Gg: AYBFou2DB0B43SNLKd2YLtU+693Ke0NovCNHv3ul9cNJT9bLLPgUos4N2Pv124ww4Ko
	5LHf0jvR6rtIhgUFPYMa2YcxgsAGSS6E7hj/1bnqFda+xw09v+V8zDmNfU1DQvDsdUQYU50IHh5
	YfJT165mtaWIqd1M+I2Y8XGUlwCVmrCvvjtWYMoI+s+IkJuXGCWSQQg17HRuQxGUeAi6Agrn7JO
	JyPz+A7ivc+L4svyuJl7a/ka+4EcMSOy4xlUjOO/Aml6vK3GTGrPRmApvsEhKIjU8sEUqmpMviL
	EWK8tSmmKBKF25Sy2Fxxu5ptG6FxDWSzkdBLnXrYL3KhR8ctZDkIFv5MWAUhwLq9bbS+aFQ3vlI
	6gXUbVyHs70OGjpLRAscl3eD4gHxgXGV45LBBEwFg2BubmTzd4ZtpmonEAEZfRxDh/24tEDwENo
	yyjn73EfFrPUupeuK5kZuyPm7WHc29WqZWXf734fJUjbDZdgZgo/aP+bwYMocZVE0cBhQIOh/Wl
	GI0Epa46iulI/5bar1FoRxoyh1SyK1w24/pNpp3gLlnu3+wNdw+/3TdqHMUHYYoszexcRJC0763
	qslRhH87X8/WEf1IgwlYhuOCZ/w2o+mR8h8=
X-Received: by 2002:a05:620a:438b:b0:93a:1b82:4962 with SMTP id af79cd13be357-93bb79b5b59mr795556885a.47.1789595928734;
        Wed, 16 Sep 2026 14:58:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 12/19] tpm2-openssl: Fix build with OpenSSL 4.x
Date: Wed, 16 Sep 2026 17:58:12 -0400
Message-ID: <91c22ab48e54a3267a5ed30dcf96296421c3b8e3.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4868

From: Khem Raj <raj.khem@gmail.com>

OpenSSL 4.0 completes the opaquing of struct asn1_string_st, so reaching
into ASN1_OCTET_STRING directly no longer compiles:

  src/tpm2-provider-pkey.c:152:53: error: incomplete definition of type
      'ASN1_OCTET_STRING' (aka 'struct asn1_string_st')
    152 |     if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(tpk->privkey->data,
        |                                         ~~~~~~~~~~~~~^

Backport upstream commit 6dcc3b2 which switches tpm2_keydata_read() to
the ASN1_STRING_get0_data()/ASN1_STRING_length() accessors. 1.3.0 is
still the newest release, so there is no upgrade to take instead.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...TRING-and-X509_NAME-access-for-OpenS.patch | 95 +++++++++++++++++++
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  4 +-
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch
new file mode 100644
index 0000000..ad6d9d9
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch
@@ -0,0 +1,95 @@
+From 6dcc3b2984e3f4dc1849c79d89c6ce736a8435b3 Mon Sep 17 00:00:00 2001
+From: Petr Gotthard <petr.gotthard@advantech.cz>
+Date: Sat, 7 Mar 2026 15:51:12 +0100
+Subject: [PATCH] Fix ASN1_OCTET_STRING and X509_NAME access for OpenSSL 4.0
+ compatibility
+
+Fixes: #166
+
+OpenSSL 4.0 completes the opaquing of struct asn1_string_st, so reaching
+into ASN1_OCTET_STRING directly no longer compiles:
+
+  src/tpm2-provider-pkey.c:152:53: error: incomplete definition of type
+      'ASN1_OCTET_STRING' (aka 'struct asn1_string_st')
+    152 |     if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(tpk->privkey->data,
+        |                                         ~~~~~~~~~~~~~^
+
+Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-openssl/commit/6dcc3b2984e3f4dc1849c79d89c6ce736a8435b3]
+
+Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
+---
+ src/tpm2-provider-pkey.c    |  8 ++++----
+ test/ec_genpkey_x509_csr.c  | 10 ++++++----
+ test/rsa_pki/etc/email.conf |  2 +-
+ 3 files changed, 11 insertions(+), 9 deletions(-)
+
+diff --git a/src/tpm2-provider-pkey.c b/src/tpm2-provider-pkey.c
+index 38f748e..80213af 100644
+--- a/src/tpm2-provider-pkey.c
++++ b/src/tpm2-provider-pkey.c
+@@ -149,13 +149,13 @@ tpm2_keydata_read(BIO *bin, TPM2_KEYDATA *keydata, TPM2_PKEY_FORMAT format)
+             strcmp(type_oid, OID_loadableKey))
+         goto error;
+
+-    if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(tpk->privkey->data,
+-                                        tpk->privkey->length, NULL,
++    if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(ASN1_STRING_get0_data(tpk->privkey),
++                                        ASN1_STRING_length(tpk->privkey), NULL,
+                                         &keydata->priv))
+         goto error;
+
+-    if (Tss2_MU_TPM2B_PUBLIC_Unmarshal(tpk->pubkey->data,
+-                                       tpk->pubkey->length, NULL,
++    if (Tss2_MU_TPM2B_PUBLIC_Unmarshal(ASN1_STRING_get0_data(tpk->pubkey),
++                                       ASN1_STRING_length(tpk->pubkey), NULL,
+                                        &keydata->pub))
+         goto error;
+
+diff --git a/test/ec_genpkey_x509_csr.c b/test/ec_genpkey_x509_csr.c
+index e3523ec..5c9790a 100644
+--- a/test/ec_genpkey_x509_csr.c
++++ b/test/ec_genpkey_x509_csr.c
+@@ -15,7 +15,7 @@ int generate_csr(const char *password, const char *filename)
+     EVP_PKEY_CTX *pctx = NULL;
+     EVP_PKEY *pkey = NULL;
+     X509_REQ *x509 = NULL;
+-    X509_NAME *name;
++    X509_NAME *name = NULL;
+     STACK_OF(X509_EXTENSION) *exts = NULL;
+     X509_EXTENSION *ex;
+     FILE *csr_file = NULL;
+@@ -40,9 +40,10 @@ int generate_csr(const char *password, const char *filename)
+             || X509_REQ_set_pubkey(x509, pkey) != 1)
+         goto error1;
+
+-    name = X509_REQ_get_subject_name(x509);
+-    if (!X509_NAME_add_entry_by_NID(name, NID_countryName, MBSTRING_ASC, (unsigned char *)"CZ", -1, -1, 0)
+-            || !X509_NAME_add_entry_by_NID(name, NID_commonName, MBSTRING_ASC, (const unsigned char *)"www.example.com", -1, -1, 0))
++    if (!(name = X509_NAME_new())
++            || !X509_NAME_add_entry_by_NID(name, NID_countryName, MBSTRING_ASC, (unsigned char *)"CZ", -1, -1, 0)
++            || !X509_NAME_add_entry_by_NID(name, NID_commonName, MBSTRING_ASC, (const unsigned char *)"www.example.com", -1, -1, 0)
++            || X509_REQ_set_subject_name(x509, name) != 1)
+         goto error1;
+
+     // set requested extensions
+@@ -75,6 +76,7 @@ int generate_csr(const char *password, const char *filename)
+     fclose(csr_file);
+ error1:
+     sk_X509_EXTENSION_pop_free(exts, X509_EXTENSION_free);
++    X509_NAME_free(name);
+     X509_REQ_free(x509);
+     EVP_PKEY_free(pkey);
+     EVP_PKEY_CTX_free(pctx);
+diff --git a/test/rsa_pki/etc/email.conf b/test/rsa_pki/etc/email.conf
+index 7606c38..73c06d2 100644
+--- a/test/rsa_pki/etc/email.conf
++++ b/test/rsa_pki/etc/email.conf
+@@ -24,4 +24,4 @@ emailAddress            = "fred@simple.org"
+ keyUsage                = critical,digitalSignature,keyEncipherment
+ extendedKeyUsage        = emailProtection,clientAuth
+ subjectKeyIdentifier    = hash
+-subjectAltName          = email:move
++subjectAltName          = email:copy
+--
+2.51.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
index e97a208..07feb00 100644
--- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
@@ -5,7 +5,9 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3f4b4cb00f4d0d6807a0dc79759a57ac"
 
 DEPENDS = "autoconf-archive-native tpm2-tss openssl"
 
-SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
+SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
+           file://0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch \
+           "
 
 SRC_URI[sha256sum] = "9a9aca55d4265ec501bcf9c56d21d6ca18dba902553f21c888fe725b42ea9964"
 
-- 
2.55.0


