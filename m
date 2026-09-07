Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B442C79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 05:06:37 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28033.1788757593224719032
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Sep 2026 22:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IherRjBl;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: raj.khem@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2784301a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Sep 2026 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788757592; x=1789362392; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSwtAcygHATJKHj9yQ7QuaBKpqruKHXjzTj5Ttb+itQ=;
        b=IherRjBlSzQq0bwJdrXgMiHWGc69XLpSjutoj5VZW3xJ70VxJ90S3TsolX28/1LqVI
         4Wr5rDrzfHl0VjkqhV6wTNdMPpai7LFM1aYJkS648f6z0IOvCZli6Ta6HmwIi+ZM8P7d
         CYXqzdBcI2g50Uxx0d8tHzfQ0gbeuspHPnkvtUoABT1uVeK6WlMZaulNFXTaT4cwhSDd
         iyOOEBxR56mhgq/hq8pu1BA/+0XWEuCD4RpApJGziAvejfEMxt4gCsMOs8dDdxVYsyKf
         ySyPxR7JRpUGhEL8w06MIWJF9Lxr6Fu/YF+IQLep4jlU6ROfdnt5AoYSWXNASnqUg+FJ
         mBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788757592; x=1789362392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSwtAcygHATJKHj9yQ7QuaBKpqruKHXjzTj5Ttb+itQ=;
        b=EU8bY3Zj29cJVQC+hCT5Z0W8ddb4VR3VCjF79iQ+8aTlhE6N1tEYfXpvGZ3DVBIlEi
         ewPrx3I7hG9V7teRjUp85vd/0Y6+ablxp7ZrKl1P0u81wP9EZtCH4IifLh6FZDvjXIzf
         DaRz8TJebsrzGC5EBFbXw885amd7QlRUiLHDfnNxkvEh9QN0vJtUKS4S9nMjcojN5XjU
         vZcf4cY/L1crRlfzZQMtEvidOc6gk2HDLQnBaQQiWh5/lHzTkZYuxPpD7ngVUfYb6Sjk
         D6Dk/BY5l+c7tquQ5BCollBQxpcXDLjo7syo7VKd34xJy2zLcELVEcgEjEH3kkKMq27T
         sYIg==
X-Gm-Message-State: AFuF++nCjCtJbxhRqraylUA3KNDFYs42PyMPoCtZjxqcao32q7bWWexA
	Aom2AOnEK3HANmTnJdHSpjfxMsUYny+2ZO02SSqFYeis3E1OpTXGYEgIXphoNQ==
X-Gm-Gg: AYBFou2dcJP4f4e1+LdGuAfdbpF0xmekPXi9dYG+a5rv7a6kZ4Bkc2IXsaPh7R1Y6qa
	d7Vmx1s+Cvc2fEvqW9rC54KvIFMPIFGVHHBFofGQwE5R4s/FxHr9fdNfJ0UYfFRpdxiAh2wf/pj
	o95XsnCMI6EyDk3HdRAesunx9j4gJJPg/5m7+5xsgJDu+6MkROYIj0x/g5+0jdGnA/aGnbpvbKJ
	HeGFV0fUXHv+3E3a+LsxmHfyj4CPmmuemncEReC4yqSBoOd+HwQzkqtBp2u2yKEktToeG5+5J6M
	RVjhhK02vasA+T5xd4NncyUo/7V1oULk17p0YyIZiK0M9eMTdKKhCO4mI7pT7rMu3tsJe8b81mY
	i5JuK9zsUMIlpJso3YFRKiLLGQ3+jE2Z4gOTC3ErS3j5qryja78k9RntT2kQ1UNVgLxkxFWKmSd
	H00T5ZezA29qoSuAjbwlsejd9A0Hqh17xwwm5bARYveT+3MkM7VTUDCXPNCu+sK6PeGRRD6m79t
	OCBvBGZo0p43/vO2bP4SD5d+ITkmZoZwkJBUYQUtr4yVayJIGKKrW00nrFIuPasHeoEZuiG79dw
	h3OmfU1D2HhSXhVggaosmk7HKOetzPrGK2B1g8G0lBuDm/hOqdv7VEzc5fKRrAkX2DMhpXgkgXR
	A2zbsAPsvMRDtYC+LA5wUTTTyPkAFwSIrFJjwKHLzpUa/cw==
X-Received: by 2002:a17:90a:d64d:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39b086549c0mr31047843a91.17.1788757592409;
        Sun, 06 Sep 2026 22:06:32 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm23722188eec.22.2026.09.06.22.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 22:06:31 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] tpm2-openssl: Fix build with OpenSSL 4.x
Date: Sun,  6 Sep 2026 22:06:28 -0700
Message-ID: <20260907050628.1500032-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 05:06:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4739

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
 

