Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46DEC982D3
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk2-f28.google.com (mail-qk2-f28.google.com [74.125.230.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26478.1789595932864019738
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VajzUjhH;
 spf=pass (domain: konsulko.com, ip: 74.125.230.220, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f28.google.com with SMTP id af79cd13be357-93910a0cb7aso13269785a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595932; x=1790200732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LNFdRJVMLZIvUKdXlrIWnYSNyMlZkDDjuFhipA8MRiw=;
        b=VajzUjhHQgyBnySqivZF1azhtpA8N3HQjtAOvKvxckDP9EuFAE1qV3sEiLtWa3Z0MY
         ERUzL32O3EUSB6hXuQeVRf15gXiYy4x0fLX254qS+psXhdJz9Am0PIZCZJnFrqSjsRYA
         e46B2jMfTEQTqswX46HBCqZPtClFNVgg0VJ8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595932; x=1790200732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LNFdRJVMLZIvUKdXlrIWnYSNyMlZkDDjuFhipA8MRiw=;
        b=SdLbajeyeWCtQ+BUnk8EDi/NRDESIkaqwYTZwZyHX3OUyd8rlv5R86VoyHZK9CcDr2
         oaDO2VkGdYqdLE3n9g6R+PEaVPdBgKcnqobaZflXmPKuulRGRdyxTWxWLrjlPJmNytuR
         4G8BkI9FeTnAx8gQiM8DTQILlQ9GK6NSfmsXErDMHennRVU2cp2rRKBVBEQQYM5Hh8ys
         qG4l6WoRqNaozrGP8FOe3Z/HeWOtAC3U/vKZLckAJ9oeQQiZtPcl+0cxPyXMdEsAsElN
         tVhSBEBiTdlLaiwJkGh/gVHo62pVF6WKkf05DG83RZixU89nLB2bSGPR4AVfhTv1WUVz
         H+Lw==
X-Gm-Message-State: AFuF++k0/Zd+S8n7p+IDINUNhvXz+DAzY1wcUYXe0DaPykVs4ZOg2cah
	hNUlxN3Ur6zZbbAZLg6v8WhuDq+j5yGf6FQhL6Mgk/JSaufsb3LpHza34hsLehWY9ugoCh5Nldt
	N1enn
X-Gm-Gg: AYBFou1pANw5fpZeqwoN4g7X7h/Y2jGL0UhUDeuwjG9lm6vkc3ZoWWtemxItHDQdXVq
	vQdLhwIU5xP5PtRCcr89qPOdezsFAwVz0mh8D6lzKDQnvmVbXt7g1+IJvZhGcIE6jk974tpYa+Z
	11IjPUW8fGJy8CBapTyWcHHwrZqzv7qnONuyCEecvquqkYTqhSMaPpfXHGSC72fGqbv9kDFZ3su
	tFPHwxRA9ETvYBNAJFN0AiaGm6FUvul35XAWUKTEzZKqc2l0PUYPywHTWZ+t6fOxoK/gP+RCTJ5
	DwUj9fzfAPw42SMU+Grtu55iF8disc1sHYhrKyEujmHLDdin/YcB6ZplX6pnF3AzEWeusPvzFvf
	VK0YR4XLRqTxoP0zFurGJgQXyEwKrMWyl65kzG3rGefYcYQbNEAMxuN0S8G1xY2YRJNQHkCvlSh
	/00+nuQMvgY2UlcQpB+LuqlBoMn62eY38dME21vsFfh8eOnf4TrUNyE044Y8BTR/OZVzxNCdOgv
	VuCcckYis0F/SXYa4MVtxvGHi52bc6NZ6gyuiPCSPTBtMfwYe14JySp/qaXWqMwPffzYGsoIogf
	NYzOGviMIbX3s6L/VyKig7ge+2y92SwlVDk=
X-Received: by 2002:a05:620a:29c3:b0:939:6c9a:8f8d with SMTP id af79cd13be357-93bb78fa7d7mr699252285a.28.1789595931323;
        Wed, 16 Sep 2026 14:58:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 15/19] meta-tpm: Remove openssl-tpm-engine
Date: Wed, 16 Sep 2026 17:58:15 -0400
Message-ID: <a7771d6a00c5165cb8856dd5b57adbe4f1478932.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4871

OpenSSL 4.x no longer supports engines, so remove recipe.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../distro/include/maintainers-meta-tpm.inc   |   1 -
 .../packagegroup/packagegroup-security-tpm.bb |   1 -
 ...pm-key-support-well-known-key-option.patch | 101 -------
 .../0002-libtpm-support-env-TPM_SRK_PW.patch  |  82 ------
 ...engine-parse-an-encrypted-tpm-SRK-pa.patch | 253 ------------------
 ...engine-change-variable-c-type-from-c.patch |  33 ---
 .../files/openssl11_build_fix.patch           |  34 ---
 .../openssl-tpm-engine_0.5.0.bb               |  63 -----
 8 files changed, 568 deletions(-)
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0001-create-tpm-key-support-well-known-key-option.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0002-libtpm-support-env-TPM_SRK_PW.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/files/openssl11_build_fix.patch
 delete mode 100644 meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb

diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index 0507ca4..7c92def 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -24,7 +24,6 @@ RECIPE_MAINTAINER:pn-tpm-quote-tools = "Scott Murray <scott.murray@konsulko.com>
 RECIPE_MAINTAINER:pn-libtpms = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-trousers = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-swtpm = "Scott Murray <scott.murray@konsulko.com>"
-RECIPE_MAINTAINER:pn-openssl-tpm-engine = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm-tools = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-abrmd = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm2-totp = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
index f92bf01..709b434 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm.bb
@@ -15,7 +15,6 @@ RDEPENDS:packagegroup-security-tpm = " \
     tpm-quote-tools \
     swtpm \
     libhoth \
-    openssl-tpm-engine \
     ${X86_TPM_MODULES} \
     "
 
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0001-create-tpm-key-support-well-known-key-option.patch b/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0001-create-tpm-key-support-well-known-key-option.patch
deleted file mode 100644
index e6068af..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0001-create-tpm-key-support-well-known-key-option.patch
+++ /dev/null
@@ -1,101 +0,0 @@
-Upstream-Status: Pending
-
-commit 16dac0cb7b73b8a7088300e45b98ac20819b03ed
-Author: Junxian.Xiao <Junxian.Xiao@windriver.com>
-Date:   Wed Jun 19 18:57:13 2013 +0800
-
-support well-known password in openssl-tpm-engine.
-
-Add "-z" option to select well known password in create_tpm_key tool.
-
-Signed-off-by: Junxian.Xiao <Junxian.Xiao@windriver.com>
-
-Index: git/src/create_tpm_key.c
-===================================================================
---- git.orig/src/create_tpm_key.c
-+++ git/src/create_tpm_key.c
-@@ -48,6 +48,8 @@
- 
- #include "ssl_compat.h"
- 
-+#define TPM_WELL_KNOWN_KEY_LEN 20   /*well know key length is 20 bytes zero*/
-+
- #define print_error(a,b) \
- 	fprintf(stderr, "%s:%d %s result: 0x%x (%s)\n", __FILE__, __LINE__, \
- 		a, b, Trspi_Error_String(b))
-@@ -72,6 +74,7 @@ usage(char *argv0)
- 		"\t\t-e|--enc-scheme  encryption scheme to use [PKCSV15] or OAEP\n"
- 		"\t\t-q|--sig-scheme  signature scheme to use [DER] or SHA1\n"
- 		"\t\t-s|--key-size    key size in bits [2048]\n"
-+		"\t\t-z|--zerokey     use well known 20 bytes zero as SRK password.\n"
- 		"\t\t-a|--auth        require a password for the key [NO]\n"
- 		"\t\t-p|--popup       use TSS GUI popup dialogs to get the password "
- 		"for the\n\t\t\t\t key [NO] (implies --auth)\n"
-@@ -154,6 +157,7 @@ int main(int argc, char **argv)
- 	int		asn1_len;
- 	char		*filename, c, *openssl_key = NULL;
- 	int		option_index, auth = 0, popup = 0, wrap = 0;
-+	int		wellknownkey = 0;
- 	UINT32		enc_scheme = TSS_ES_RSAESPKCSV15;
- 	UINT32		sig_scheme = TSS_SS_RSASSAPKCS1V15_DER;
- 	UINT32		key_size = 2048;
-@@ -161,12 +165,15 @@ int main(int argc, char **argv)
- 
- 	while (1) {
- 		option_index = 0;
--		c = getopt_long(argc, argv, "pe:q:s:ahw:",
-+		c = getopt_long(argc, argv, "pe:q:s:zahw:",
- 				long_options, &option_index);
- 		if (c == -1)
- 			break;
- 
- 		switch (c) {
-+			case 'z':
-+				wellknownkey = 1;
-+				break;
- 			case 'a':
- 				initFlags |= TSS_KEY_AUTHORIZATION;
- 				auth = 1;
-@@ -300,6 +307,8 @@ int main(int argc, char **argv)
- 
- 	if (srk_authusage) {
- 		char *authdata = calloc(1, 128);
-+		TSS_FLAG secretMode = TSS_SECRET_MODE_PLAIN;
-+		int authlen = 0;
- 
- 		if (!authdata) {
- 			fprintf(stderr, "malloc failed.\n");
-@@ -316,17 +325,26 @@ int main(int argc, char **argv)
- 			exit(result);
- 		}
- 
--		if (EVP_read_pw_string(authdata, 128, "SRK Password: ", 0)) {
--			Tspi_Context_CloseObject(hContext, hKey);
--			Tspi_Context_Close(hContext);
--			free(authdata);
--			exit(result);
-+		if (wellknownkey) {
-+			memset(authdata, 0, TPM_WELL_KNOWN_KEY_LEN);
-+			secretMode = TSS_SECRET_MODE_SHA1;
-+			authlen = TPM_WELL_KNOWN_KEY_LEN;
-+		}
-+		else {
-+			if (EVP_read_pw_string(authdata, 128, "SRK Password: ", 0)) {
-+				Tspi_Context_CloseObject(hContext, hKey);
-+				Tspi_Context_Close(hContext);
-+				free(authdata);
-+				exit(result);
-+			}
-+			secretMode = TSS_SECRET_MODE_PLAIN;
-+			authlen = strlen(authdata);
- 		}
- 
- 		//Set Secret
- 		if ((result = Tspi_Policy_SetSecret(srkUsagePolicy,
--						    TSS_SECRET_MODE_PLAIN,
--						    strlen(authdata),
-+						    secretMode,
-+						    authlen,
- 						    (BYTE *)authdata))) {
- 			print_error("Tspi_Policy_SetSecret", result);
- 			free(authdata);
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0002-libtpm-support-env-TPM_SRK_PW.patch b/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0002-libtpm-support-env-TPM_SRK_PW.patch
deleted file mode 100644
index 74def4f..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0002-libtpm-support-env-TPM_SRK_PW.patch
+++ /dev/null
@@ -1,82 +0,0 @@
-Upstream-Status: Pending
-
-commit 16dac0cb7b73b8a7088300e45b98ac20819b03ed
-Author: Junxian.Xiao <Junxian.Xiao@windriver.com>
-Date:   Wed Jun 19 18:57:13 2013 +0800
-
-support reading SRK password from env TPM_SRK_PW
-
-Add "env TPM_SRK_PW=xxxx" to set password for libtpm.so. Specially,
-use "env TPM_SRK_PW=#WELLKNOWN#" to set well known password.
-
-Signed-off-by: Junxian.Xiao <Junxian.Xiao@windriver.com>
-
-Index: git/src/e_tpm.c
-===================================================================
---- git.orig/src/e_tpm.c
-+++ git/src/e_tpm.c
-@@ -38,6 +38,8 @@
- #include "e_tpm.h"
- #include "ssl_compat.h"
- 
-+#define TPM_WELL_KNOWN_KEY_LEN 20   /*well know key length is 20 bytes zero*/
-+
- //#define DLOPEN_TSPI
- 
- #ifndef OPENSSL_NO_HW
-@@ -262,6 +264,10 @@ int tpm_load_srk(UI_METHOD *ui, void *cb
- 	TSS_RESULT result;
- 	UINT32 authusage;
- 	BYTE *auth;
-+	char *srkPasswd = NULL;
-+	TSS_FLAG secretMode = secret_mode;
-+	int authlen = 0;
-+
- 
- 	if (hSRK != NULL_HKEY) {
- 		DBGFN("SRK is already loaded.");
-@@ -313,18 +319,36 @@ int tpm_load_srk(UI_METHOD *ui, void *cb
- 		return 0;
- 	}
- 
--	if (!tpm_engine_get_auth(ui, (char *)auth, 128, "SRK authorization: ",
--				cb_data)) {
--		Tspi_Context_CloseObject(hContext, hSRK);
--		free(auth);
--		TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
--		return 0;
-+	srkPasswd = getenv("TPM_SRK_PW");
-+	if (NULL != srkPasswd) {
-+		if (0 == strcmp(srkPasswd, "#WELLKNOWN#")) {
-+			memset(auth, 0, TPM_WELL_KNOWN_KEY_LEN);
-+			secretMode = TSS_SECRET_MODE_SHA1;
-+			authlen = TPM_WELL_KNOWN_KEY_LEN;
-+		} else {
-+			int authbuflen = 128;
-+			memset(auth, 0, authbuflen);
-+			strncpy(auth, srkPasswd, authbuflen-1);
-+			secretMode = TSS_SECRET_MODE_PLAIN;
-+			authlen = strlen(auth);
-+		}
-+	}
-+	else {
-+		if (!tpm_engine_get_auth(ui, (char *)auth, 128,
-+				"SRK authorization: ", cb_data)) {
-+			Tspi_Context_CloseObject(hContext, hSRK);
-+			free(auth);
-+			TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
-+			return 0;
-+		}
-+		secretMode = secret_mode;
-+		authlen = strlen(auth);
- 	}
- 
- 	/* secret_mode is a global that may be set by engine ctrl
- 	 * commands.  By default, its set to TSS_SECRET_MODE_PLAIN */
--	if ((result = Tspi_Policy_SetSecret(hSRKPolicy, secret_mode,
--					      strlen((char *)auth), auth))) {
-+	if ((result = Tspi_Policy_SetSecret(hSRKPolicy, secretMode,
-+					      authlen, auth))) {
- 		Tspi_Context_CloseObject(hContext, hSRK);
- 		free(auth);
- 		TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch b/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch
deleted file mode 100644
index 732961d..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch
+++ /dev/null
@@ -1,253 +0,0 @@
-From eb28ad92a2722fd30f8114840cf2b1ade26b80ee Mon Sep 17 00:00:00 2001
-From: Limeng <Meng.Li@windriver.com>
-Date: Fri, 23 Jun 2017 11:39:04 +0800
-Subject: [PATCH] tpm:openssl-tpm-engine:parse an encrypted tpm SRK password 
- from env
-
-Before, we support reading SRK password from env TPM_SRK_PW,
-but it is a plain password and not secure.
-So, we improve it and support to get an encrypted (AES algorithm)
-SRK password from env, and then parse it. The default decrypting
-AES password and salt is set in bb file.
-When we initialize TPM, and set a SRK pw, and then we need to
-encrypt it with the same AES password and salt by AES algorithm.
-At last, we set a env as below:
-export TPM_SRK_ENC_PW=xxxxxxxx
-"xxxxxxxx" is the encrypted SRK password for libtpm.so.
-
-Signed-off-by: Meng Li <Meng.Li@windriver.com>
----
-Upstream-Status: Pending
-
- e_tpm.c     | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
- e_tpm.h     |   4 ++
- e_tpm_err.c |   4 ++
- 3 files changed, 164 insertions(+), 1 deletion(-)
-
-Index: git/src/e_tpm.c
-===================================================================
---- git.orig/src/e_tpm.c
-+++ git/src/e_tpm.c
-@@ -259,6 +259,118 @@ void ENGINE_load_tpm(void)
- 	ERR_clear_error();
- }
- 
-+static int tpm_decode_base64(unsigned char *indata,
-+				int in_len,
-+				unsigned char *outdata,
-+				int *out_len)
-+{
-+	int total_len, len, ret;
-+	EVP_ENCODE_CTX dctx;
-+
-+	EVP_DecodeInit(&dctx);
-+
-+	total_len = 0;
-+	ret = EVP_DecodeUpdate(&dctx, outdata, &len, indata, in_len);
-+	if (ret < 0) {
-+		TSSerr(TPM_F_TPM_DECODE_BASE64, TPM_R_DECODE_BASE64_FAILED);
-+		return 1;
-+	}
-+
-+	total_len += len;
-+	ret = EVP_DecodeFinal(&dctx, outdata, &len);
-+	if (ret < 0) {
-+		TSSerr(TPM_F_TPM_DECODE_BASE64, TPM_R_DECODE_BASE64_FAILED);
-+		return 1;
-+	}
-+	total_len += len;
-+
-+	*out_len = total_len;
-+
-+	return 0;
-+}
-+
-+static int tpm_decrypt_srk_pw(unsigned char *indata, int in_len,
-+				unsigned char *outdata,
-+				int *out_len)
-+{
-+	int dec_data_len, dec_data_lenfinal;
-+	unsigned char dec_data[256];
-+	unsigned char *aes_pw;
-+	unsigned char aes_salt[PKCS5_SALT_LEN];
-+	unsigned char key[EVP_MAX_KEY_LENGTH], iv[EVP_MAX_IV_LENGTH];
-+	const EVP_CIPHER *cipher = NULL;
-+	const EVP_MD *dgst = NULL;
-+	EVP_CIPHER_CTX *ctx = NULL;
-+
-+	if (sizeof(SRK_DEC_SALT) - 1 > PKCS5_SALT_LEN) {
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		return 1;
-+	}
-+
-+	aes_pw = malloc(sizeof(SRK_DEC_PW) - 1);
-+	if (aes_pw == NULL) {
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		return 1;
-+	}
-+
-+	memset(aes_salt, 0x00, sizeof(aes_salt));
-+	memcpy(aes_pw, SRK_DEC_PW, sizeof(SRK_DEC_PW) - 1);
-+	memcpy(aes_salt, SRK_DEC_SALT, sizeof(SRK_DEC_SALT) - 1);
-+
-+	cipher = EVP_get_cipherbyname("aes-128-cbc");
-+	if (cipher == NULL) {
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		free(aes_pw);
-+		return 1;
-+	}
-+	dgst = EVP_sha256();
-+
-+	EVP_BytesToKey(cipher, dgst, aes_salt, (unsigned char *)aes_pw, sizeof(SRK_DEC_PW) - 1, 1, key, iv);
-+
-+	ctx = EVP_CIPHER_CTX_new();
-+	/* Don't set key or IV right away; we want to check lengths */
-+	if (!EVP_CipherInit_ex(ctx, cipher, NULL, NULL, NULL, 0)) {
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		free(aes_pw);
-+		return 1;
-+	}
-+
-+	OPENSSL_assert(EVP_CIPHER_CTX_key_length(ctx) == 16);
-+	OPENSSL_assert(EVP_CIPHER_CTX_iv_length(ctx) == 16);
-+
-+	if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, iv, 0)) {
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		free(aes_pw);
-+		return 1;
-+	}
-+
-+	if (!EVP_CipherUpdate(ctx, dec_data, &dec_data_len, indata, in_len)) {
-+		/* Error */
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		free(aes_pw);
-+		EVP_CIPHER_CTX_free(ctx);
-+		return 1;
-+	}
-+
-+	if (!EVP_CipherFinal_ex(ctx, dec_data + dec_data_len, &dec_data_lenfinal)) {
-+		/* Error */
-+		TSSerr(TPM_F_TPM_DECRYPT_SRK_PW, TPM_R_DECRYPT_SRK_PW_FAILED);
-+		free(aes_pw);
-+		EVP_CIPHER_CTX_free(ctx);
-+		return 1;
-+	}
-+
-+	dec_data_len = dec_data_len + dec_data_lenfinal;
-+
-+	memcpy(outdata, dec_data, dec_data_len);
-+	*out_len = dec_data_len;
-+
-+	free(aes_pw);
-+	EVP_CIPHER_CTX_free(ctx);
-+
-+	return 0;
-+}
-+
- int tpm_load_srk(UI_METHOD *ui, void *cb_data)
- {
- 	TSS_RESULT result;
-@@ -319,8 +431,50 @@ int tpm_load_srk(UI_METHOD *ui, void *cb
- 		return 0;
- 	}
- 
--	srkPasswd = getenv("TPM_SRK_PW");
-+	srkPasswd = getenv("TPM_SRK_ENC_PW");
- 	if (NULL != srkPasswd) {
-+		int in_len = strlen(srkPasswd);
-+		int out_len;
-+		unsigned char *out_buf;
-+
-+		if (!in_len || in_len % 4) {
-+			Tspi_Context_CloseObject(hContext, hSRK);
-+			free(auth);
-+			TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
-+			return 0;
-+		}
-+
-+		out_len = in_len * 3 / 4;
-+		out_buf = malloc(out_len);
-+		if (NULL == out_buf) {
-+			Tspi_Context_CloseObject(hContext, hSRK);
-+			free(auth);
-+			TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
-+			return 0;
-+		}
-+
-+		if (tpm_decode_base64(srkPasswd, strlen(srkPasswd),
-+					out_buf, &out_len)) {
-+			Tspi_Context_CloseObject(hContext, hSRK);
-+			free(auth);
-+			free(out_buf);
-+			TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
-+			return 0;
-+		}
-+
-+		if (tpm_decrypt_srk_pw(out_buf, out_len,
-+							auth, &authlen)) {
-+			Tspi_Context_CloseObject(hContext, hSRK);
-+			free(auth);
-+			free(out_buf);
-+			TSSerr(TPM_F_TPM_LOAD_SRK, TPM_R_REQUEST_FAILED);
-+			return 0;
-+		}
-+		secretMode = TSS_SECRET_MODE_PLAIN;
-+		free(out_buf);
-+	}
-+#ifdef TPM_SRK_PLAIN_PW
-+	else if (NULL != (srkPasswd = getenv("TPM_SRK_PW")) {
- 		if (0 == strcmp(srkPasswd, "#WELLKNOWN#")) {
- 			memset(auth, 0, TPM_WELL_KNOWN_KEY_LEN);
- 			secretMode = TSS_SECRET_MODE_SHA1;
-@@ -333,6 +487,7 @@ int tpm_load_srk(UI_METHOD *ui, void *cb
- 			authlen = strlen(auth);
- 		}
- 	}
-+#endif
- 	else {
- 		if (!tpm_engine_get_auth(ui, (char *)auth, 128,
- 				"SRK authorization: ", cb_data)) {
-Index: git/src/e_tpm.h
-===================================================================
---- git.orig/src/e_tpm.h
-+++ git/src/e_tpm.h
-@@ -66,6 +66,8 @@ void ERR_TSS_error(int function, int rea
- #define TPM_F_TPM_FILL_RSA_OBJECT		116
- #define TPM_F_TPM_ENGINE_GET_AUTH		117
- #define TPM_F_TPM_CREATE_SRK_POLICY		118
-+#define TPM_F_TPM_DECODE_BASE64			119
-+#define TPM_F_TPM_DECRYPT_SRK_PW		120
- 
- /* Reason codes. */
- #define TPM_R_ALREADY_LOADED			100
-@@ -96,6 +98,8 @@ void ERR_TSS_error(int function, int rea
- #define TPM_R_ID_INVALID			125
- #define TPM_R_UI_METHOD_FAILED			126
- #define TPM_R_UNKNOWN_SECRET_MODE		127
-+#define TPM_R_DECODE_BASE64_FAILED		128
-+#define TPM_R_DECRYPT_SRK_PW_FAILED		129
- 
- /* structure pointed to by the RSA object's app_data pointer */
- struct rsa_app_data
-Index: git/src/e_tpm_err.c
-===================================================================
---- git.orig/src/e_tpm_err.c
-+++ git/src/e_tpm_err.c
-@@ -234,6 +234,8 @@ static ERR_STRING_DATA TPM_str_functs[]
- 	{ERR_PACK(0, TPM_F_TPM_BIND_FN, 0), "TPM_BIND_FN"},
- 	{ERR_PACK(0, TPM_F_TPM_FILL_RSA_OBJECT, 0), "TPM_FILL_RSA_OBJECT"},
- 	{ERR_PACK(0, TPM_F_TPM_ENGINE_GET_AUTH, 0), "TPM_ENGINE_GET_AUTH"},
-+	{ERR_PACK(0, TPM_F_TPM_DECODE_BASE64, 0), "TPM_DECODE_BASE64"},
-+	{ERR_PACK(0, TPM_F_TPM_DECRYPT_SRK_PW, 0), "TPM_DECRYPT_SRK_PW"},
- 	{0, NULL}
- };
- 
-@@ -264,6 +266,8 @@ static ERR_STRING_DATA TPM_str_reasons[]
- 	{TPM_R_FILE_READ_FAILED, "failed reading the key file"},
- 	{TPM_R_ID_INVALID, "engine id doesn't match"},
- 	{TPM_R_UI_METHOD_FAILED, "ui function failed"},
-+	{TPM_R_DECODE_BASE64_FAILED, "decode base64 failed"},
-+	{TPM_R_DECRYPT_SRK_PW_FAILED, "decrypt srk password failed"},
- 	{0, NULL}
- };
- 
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch b/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch
deleted file mode 100644
index 3cbfc3c..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From fb44e2814fd819c086f9a4c925427f89c0e8cec6 Mon Sep 17 00:00:00 2001
-From: Limeng <Meng.Li@windriver.com>
-Date: Fri, 21 Jul 2017 16:32:02 +0800
-Subject: [PATCH] tpm:openssl-tpm-engine: change variable c type from char
- into int
-
-refer to getopt_long() function definition, its return value type is
-int. So, change variable c type from char into int.
-On arm platform, when getopt_long() calling fails, if we define c as
-char type, its value will be 255, not -1. This will cause code enter
-wrong case.
-
-Signed-off-by: Meng Li <Meng.Li@windriver.com>
----
-Upstream-Status: Pending
-
- create_tpm_key.c |    3 ++-
- 1 file changed, 2 insertions(+), 1 deletion(-)
-
-Index: git/src/create_tpm_key.c
-===================================================================
---- git.orig/src/create_tpm_key.c
-+++ git/src/create_tpm_key.c
-@@ -155,7 +155,8 @@ int main(int argc, char **argv)
- 	ASN1_OCTET_STRING *blob_str;
- 	unsigned char	*blob_asn1 = NULL;
- 	int		asn1_len;
--	char		*filename, c, *openssl_key = NULL;
-+	char		*filename, *openssl_key = NULL;
-+	int		c;
- 	int		option_index, auth = 0, popup = 0, wrap = 0;
- 	int		wellknownkey = 0;
- 	UINT32		enc_scheme = TSS_ES_RSAESPKCSV15;
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/openssl11_build_fix.patch b/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/openssl11_build_fix.patch
deleted file mode 100644
index 2f8eb81..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/files/openssl11_build_fix.patch
+++ /dev/null
@@ -1,34 +0,0 @@
-Fix compiling for openssl 1.1
-
-Upstream-Status: Pending
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/src/e_tpm.c
-===================================================================
---- git.orig/src/e_tpm.c
-+++ git/src/e_tpm.c
-@@ -265,19 +265,20 @@ static int tpm_decode_base64(unsigned ch
- 				int *out_len)
- {
- 	int total_len, len, ret;
--	EVP_ENCODE_CTX dctx;
-+	EVP_ENCODE_CTX *dctx;
- 
--	EVP_DecodeInit(&dctx);
-+	dctx = EVP_ENCODE_CTX_new();
-+	EVP_DecodeInit(dctx);
- 
- 	total_len = 0;
--	ret = EVP_DecodeUpdate(&dctx, outdata, &len, indata, in_len);
-+	ret = EVP_DecodeUpdate(dctx, outdata, &len, indata, in_len);
- 	if (ret < 0) {
- 		TSSerr(TPM_F_TPM_DECODE_BASE64, TPM_R_DECODE_BASE64_FAILED);
- 		return 1;
- 	}
- 
- 	total_len += len;
--	ret = EVP_DecodeFinal(&dctx, outdata, &len);
-+	ret = EVP_DecodeFinal(dctx, outdata, &len);
- 	if (ret < 0) {
- 		TSSerr(TPM_F_TPM_DECODE_BASE64, TPM_R_DECODE_BASE64_FAILED);
- 		return 1;
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb b/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
deleted file mode 100644
index 13f0d0d..0000000
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
+++ /dev/null
@@ -1,63 +0,0 @@
-SUMMARY = "OpenSSL secure engine based on TPM hardware"
-HOMEPAGE = "https://github.com/mgerstner/openssl_tpm_engine"
-SECTION = "security/tpm"
-
-LICENSE = "OpenSSL"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=11f0ee3af475c85b907426e285c9bb52"
-
-DEPENDS += "openssl trousers"
-
-SRC_URI = "\
-    git://github.com/mgerstner/openssl_tpm_engine.git;branch=master;protocol=https \
-    file://0001-create-tpm-key-support-well-known-key-option.patch \
-    file://0002-libtpm-support-env-TPM_SRK_PW.patch \
-    file://0003-tpm-openssl-tpm-engine-parse-an-encrypted-tpm-SRK-pa.patch \
-    file://0004-tpm-openssl-tpm-engine-change-variable-c-type-from-c.patch \
-    file://openssl11_build_fix.patch \
-"
-SRCREV = "b28de5065e6eb9aa5d5afe2276904f7624c2cbaf"
-
-inherit autotools-brokensep pkgconfig
-
-# The definitions below are used to decrypt the srk password.
-# It is allowed to define the values in 3 forms: string, hex number and
-# the hybrid, e.g,
-# srk_dec_pw = "incendia"
-# srk_dec_pw = "\x69\x6e\x63\x65\x6e\x64\x69\x61"
-# srk_dec_pw = "\x1""nc""\x3""nd""\x1""a"
-#
-# Due to the limit of escape character, the hybrid must be written in
-# above style. The actual values defined below in C code style are:
-# srk_dec_pw[] = { 0x01, 'n', 'c', 0x03, 'n', 'd', 0x01, 'a' };
-# srk_dec_salt[] = { 'r', 0x00, 0x00, 't' };
-srk_dec_pw ?= "\\"\\\x1\\"\\"nc\\"\\"\\\x3\\"\\"nd\\"\\"\\\x1\\"\\"a\\""
-srk_dec_salt ?= "\\"r\\"\\"\\\x00\\\x00\\"\\"t\\""
-
-CFLAGS:append = " -DSRK_DEC_PW=${srk_dec_pw} -DSRK_DEC_SALT=${srk_dec_salt}"
-
-# Uncomment below line if using the plain srk password for development
-#CFLAGS:append = " -DTPM_SRK_PLAIN_PW"
-
-do_configure:prepend() {
-    cd ${B}
-    cp LICENSE COPYING
-    touch NEWS AUTHORS ChangeLog README
-}
-
-FILES:${PN}-staticdev += "${libdir}/ssl/engines-3/tpm.la"
-FILES:${PN}-dbg += "\
-    ${libdir}/ssl/engines-3/.debug \
-    ${libdir}/engines-3/.debug \
-    ${prefix}/local/ssl/lib/engines-3/.debug \
-"
-FILES:${PN} += "\
-    ${libdir}/ssl/engines-3/tpm.so* \
-    ${libdir}/engines-3/tpm.so* \
-    ${libdir}/libtpm.so* \
-    ${prefix}/local/ssl/lib/engines-3/tpm.so* \
-"
-
-RDEPENDS:${PN} += "libcrypto libtspi"
-
-INSANE_SKIP:${PN} = "libdir"
-INSANE_SKIP:${PN}-dbg = "libdir"
-- 
2.55.0


