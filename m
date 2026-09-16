Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57ECC982C1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:52 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27126.1789597851500428319
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cojcMw+5;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-531034aa31bso1044661cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597850; x=1790202650; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y1nmUi30Xj9EZJKrH3g+y4BwWeLPIaPAfbSYIno5bEI=;
        b=cojcMw+5vENrbPud58P3plx3XzsEv8k07AfAgx6jH5SBS/Ssp0RizcK8Qi2EmxUya5
         LFG8S/6Z3aVB+h5rXCDtifMKXqDqxmQIPEv6SaFP3IxfcxVOTfaLOJ+SKW7IIup1EoiJ
         0fzc2PmCqafEGSO90xVQKvXUIqWAFS1vK39kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597850; x=1790202650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y1nmUi30Xj9EZJKrH3g+y4BwWeLPIaPAfbSYIno5bEI=;
        b=QwyC8euORT8SYcWaqkWJtWrXbUAN8mX6SSwpRVgNX/AWf/1D3Xaao3AHgFP6X9cDwg
         qUN3Ykm/8NAcMVJWanWIeDnv7OMuWwVdOgssKprz+Pi44ObbfcuMsZH+SZKWRyJ0QAR5
         WaP6RdLz4RJe0vZxa/CaHgRR+94usjCzlTFan3PVvG0iYBJ/F+x3wGFHs9vyF5QLBXTO
         IbYgrtBZW+I57uHjA4hFw0QtO4BhS/0TwZ1/GlC0Cgz1Ri+TldBiiDTtabMj/oGH2S03
         vnXcEhdPi3eq0YiyfcBMJimFAgdh3UiUER1LPMDPFyYNkbKha42O8us+OGoWUXoEO7C0
         h6mw==
X-Gm-Message-State: AFuF++nJWfe4HtIZ2Bwa+aO2n5Ml7pSuZbple9ZYKr32AvuHf9arnrXC
	YIiuDKaYe9xXQNCqXvbkFuqIceYOr9VmkX4ExDnpESJ8v7iT/QZWwCOfplx4+36BCtlShxVYoFy
	2uH/C
X-Gm-Gg: AYBFou0SnQb6dcoZgf0/iAv+xkuVlZQ4ZznvT+TIVi43Y4idYVxTz+PdfBxFZmPyNB1
	yR1etprIourAqsj+8VCM4IDBRGOc//eYva1LfFMdFd52k79lZwoSvmvv6EwuGEYhSYVVmztsc3r
	3gMr7Gs5Z9AT4evfHbzmWoWse0sPtfIe7r+EBlHOstrCg6XWttXRCcEYwKv1SO+csxnwZzc1aeX
	9d66qRQMsBDw36F13L1KdNCsOiBPBM0MdLrVYS3+rzvgcUdnosJU04Uwu5MAvROT6wo8nQO7d/y
	I+kSoUZYAorX4/4jJJ/5ZAaSeeiHR5KmyLIlkwn7h7mOHh66ZmW+tD4zI6QnPTwITqCymds61QD
	G1ZWAAxWEiZo78W+jCii7BUORDBzJ2yaqfHnlChHi6l4FkO7EHLMqu42jd7LIEuIJGJBhtIL9JA
	EEkPTJQJOr9g5l+QxOlFJdO19xWFu6iHysIVm89L4LI6O8fy/Gt8+gLvQolEJuSQY7cGaHRzJg1
	VHRaL4ipEqK5e2aJk0x0iF/3FdO+9SxGVNDFdGuBhcBmNVweWJba+n/p0ME2hMdzbYwY5EI+yqw
	kVCfNR5abkcH0Guar0Q/kdQar+ddsbjyT3E=
X-Received: by 2002:a05:622a:8f:b0:531:6f07:d6ef with SMTP id d75a77b69052e-5327edddf92mr77064001cf.2.1789597850119;
        Wed, 16 Sep 2026 15:30:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 20/24] tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1
Date: Wed, 16 Sep 2026 18:30:14 -0400
Message-ID: <d34b7b803111c7b07da039af7ea6c2a9640c8632.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4896

From: Khem Raj <raj.khem@gmail.com>

Fixes the build against OpenSSL 4.0, which completes the opaquing of
struct asn1_string_st:

  src/lib/ssl_util.c:201:9: error: incomplete definition of type
      'ASN1_OCTET_STRING' (aka 'struct asn1_string_st')

Upstream switched both call sites in ssl_util.c to the
ASN1_STRING_get0_data()/ASN1_STRING_length() accessors, so the upgrade
is all that is needed, no local patch.

Drop 0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch, it is
already applied upstream in this release (PR #923) and now fails to
apply.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...eturn-NULL-for-twist-on-auth-failure.patch | 28 -------------------
 ...-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} |  3 +-
 2 files changed, 1 insertion(+), 30 deletions(-)
 delete mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
 rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.2.bb => tpm2-pkcs11_1.10.1.bb} (91%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch b/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
deleted file mode 100644
index 2992b11..0000000
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 0db779aecaae93633be963ffb8fdb097c85cc166 Mon Sep 17 00:00:00 2001
-From: Peter Marko <peter.marko@siemens.com>
-Date: Thu, 9 Apr 2026 00:00:00 +0000
-Subject: [PATCH] src/lib/tpm: return NULL for twist on auth failure
-
-`tpm_unseal` returns `twist` (a const char pointer alias). Returning
-`false` in the error path is a type mismatch that fails with stricter
-compiler settings. Return `NULL` instead.
-
-Upstream-Status: Submitted [https://github.com/tpm2-software/tpm2-pkcs11/pull/923]
-Signed-off-by: Peter Marko <peter.marko@siemens.com>
----
- src/lib/tpm.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/src/lib/tpm.c b/src/lib/tpm.c
-index 5fff5d5..c51d984 100644
---- a/src/lib/tpm.c
-+++ b/src/lib/tpm.c
-@@ -1037,7 +1037,7 @@ twist tpm_unseal(tpm_ctx *ctx, uint32_t handle, twist objauth) {
- 
-     bool result = set_esys_auth(ctx->esys_ctx, handle, objauth);
-     if (!result) {
--        return false;
-+        return NULL;
-     }
- 
-     TPM2B_SENSITIVE_DATA *unsealed_data = NULL;
diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.10.1.bb
similarity index 91%
rename from meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
rename to meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.10.1.bb
index 1a671bc..b5bf6c1 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.10.1.bb
@@ -8,9 +8,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=0fc19f620a102768d6dbd1e7166e78ab"
 DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools libyaml p11-kit python3-setuptools-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
-SRC_URI += "file://0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch"
 
-SRC_URI[sha256sum] = "1bdabdaed6a5fa4ce8a1e82307f4612c30e30b0a0415e1bc7d9c30f713227480"
+SRC_URI[sha256sum] = "f3315d17811f918779a1046ba20e49060a40b2b586a06ab013ff8c8da53752e4"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.55.0


