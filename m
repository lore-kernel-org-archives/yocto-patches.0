Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C3BC79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 07:14:50 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29037.1788765284568473216
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 00:14:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aumex7m0;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: raj.khem@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647184c73so3845657a91.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788765284; x=1789370084; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQ2KV1iSXwhIcNQJTjpKcKjnzBHICZGf5SOaYQkEmkA=;
        b=aumex7m0x5jxDkUDOFd7fbzo1QCTNTUlWlhtvAyItqu5niCK3Ibhs0cTZnUeALTueW
         fpCiZ+mVrvkVAwTQbe1dZi8o+6CXpxXaWGf450cKe92FUlLcqX6FEYAKuqrHcaLbnsmf
         th6tsNv3PlcWiymhKTGpFButxp9yr5RYcpIGCiQ8SAshyY/EEAyOkavNH8ou1BvZQg78
         QANgod04K+FDruIn3+IJ1Ixo32jfdvIZ0dfmKlmHCgi+zgMm5je6RYOnw7OO+zKce21F
         mJxEY27jkOTMVNxgvm2UCx+xK/PhNyYsCYzOLX3+OX1I58ESrWRhcX80dd4nubwBfkm1
         Ubsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765284; x=1789370084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQ2KV1iSXwhIcNQJTjpKcKjnzBHICZGf5SOaYQkEmkA=;
        b=CMgeujIUp0yRxPjKoTGcvdmKyxBMk+zPM0qs0GtERlidXdXg0nwDvERPgH2wGyqPDd
         9jax2fpII7IkZaYnfGHCsAYDPYyww9j/xAQpaHTXZRsRotUiK6kwvL3fbwgFp1r1fkzO
         3Gbjp/4nEicL2M65eVM1GjlvvlMQuXg/WihokI4QnKr6tjRqS0yPKnT/j1xcatWczmbn
         0EXXvwLFbIVTP2QlmD2ER0kV+OwcrHtiSmlH2Q1Im9BUNUZ69EKe1KUpsqD1ZFjJOVEI
         oWvVRu6sGqrbsrmT75L9exbEJh1LlwYMq13KZQt1Affjsa0W4rTsXNSgnwNgXIRKoEBB
         exjQ==
X-Gm-Message-State: AFuF++lP0H1pAZRr8/7dec+nRDos42uyA+EkTVMwRkVJvxUpuvciahuL
	a8NTYt1/Hvo0LFSSW/7xGlxQAvpwXcxIbBC52xIUOWL5bthBjAVNKE5ltexuRA==
X-Gm-Gg: AYBFou3XmS1i15ESlxNXKSsSvK9mbnmOly3LJl0ICecQqQ08v5BhozZntek16cTPgkA
	YDQIYBPZLCn3rAHZ09Q1wyHNJ8Rsx02+HJcmRBEOln3nYU/hXWxVVA6CbKUFKIbbONwBCyD2PFi
	OjZGGXkTHRZYTHYGvL8QUVsdCXW0ZjB9anVNORQB+kGraBUid788XzNtFUSlyWPSqOpcXiKFKVO
	ovdqZilyHPpxNodazY14y8HYsKxgv2YkKrcZ1odtUCEPT8sfYBNyzUV1zwTmxMSgReyrYZAphDt
	OcN5oRt0eGdzl0ws1gdDpR0mnNQ/AgttdMHBozMCahLUcoFg8LuDDqt0yORUecan92eE2tM/ztP
	TnOcqJWW/G/Be4fPESkU1l1ehI0eMYZaLgUBA1NL/81tIs5GT4uG2jwRnTYstm3Rk03NozMo4B9
	AAzxRssdQE7XAJ5mmajdWGW7Qs4l7BjbimrbFDajikiatumIGVa1U+nVlfLemubMVdYRlu8ec9D
	+DPkFAwdzIWzKtI1WqCCmSBQGWJDJ6jSzk7Acnr9D/p9mMDfQHP1E1ItDuTPAyxSBaimQ50KxQS
	mag383HqQersZ96QzWteVdWYtI/qz3wz2S9XZZqRY36ypeet4osIMf2ms6+FwQ/QZ8w6Yu1bcVH
	L0+FEgN/6pCFpNO5HYKp23TKzGl8J3YcC2mlY9BsBC2MtNA==
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39b08799871mr28362189a91.23.1788765283837;
        Mon, 07 Sep 2026 00:14:43 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm22966474c88.13.2026.09.07.00.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:14:43 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1
Date: Mon,  7 Sep 2026 00:14:40 -0700
Message-ID: <20260907071440.1685177-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 07:14:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4740

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
 

