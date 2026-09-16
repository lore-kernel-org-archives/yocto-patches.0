Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3422CC982C1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26476.1789595931099942320
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bQiqZjlI;
 spf=pass (domain: konsulko.com, ip: 74.125.230.218, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so12082885a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595930; x=1790200730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y1nmUi30Xj9EZJKrH3g+y4BwWeLPIaPAfbSYIno5bEI=;
        b=bQiqZjlIKL/PYvyjTkfApymuVnk2jbSlWUbF+PdwDPUNNKX6xU0w2fGyz9zRhyw+Kf
         ujhM4SOZskCW79gOUhMCBw7f1rpTV1VkEnjEGwWZsX5eLwxxoV/5bSM4db6Nbb5giKpO
         bt1h9SYKB5jk+YPfzNx0WG/ZN2Ezf2j4nNyPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595930; x=1790200730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y1nmUi30Xj9EZJKrH3g+y4BwWeLPIaPAfbSYIno5bEI=;
        b=klroHuYvVocFW9Ghxo8Fy8RR9qm9ZOvQFus9r00AzhmZDCaOkbumL5QMoVXAP/R4WZ
         f+VPtVaWVF/eeDpB1mScYxqfJ2PmQwygViJLZVnlGV6BFRLod3ICTIaOcAn+hEKkmBt2
         TUvgfrUInTfSB6BztSV8a+HyBYQVil+ZqTRZIbEKj5xL1I9vfE0S+NLShPfFupMIqWY6
         goO+qVxCJj3YPcJ7dN0jVqVkwVRLGvfb9VUf9vw+eKS4YKET4q9KbsSs4o8qIN3A1lQA
         vv2xeqwxG5WJZRgmn4bEvD0isDl2ZFcVe+4+ZBnhqDPW8MKoL+xPGxyBAgvo4taJapVB
         j7qw==
X-Gm-Message-State: AFuF++ngQPJrhgyKJTScjO6vr/S5YVnlBYxa9mGs7W4/bTVjWYcbvxJv
	0q65TsshaUE+EfyfPScImRlHhRLALX9Vjb3+RlIxbqSfxBzm5u+ROJALL8tycXsTpWHOJJmN7s/
	7dh2H
X-Gm-Gg: AYBFou3kB6MNYyZyAUeltVuLPtdEBO/eOevddG/UJgR+THL0mLsGFsnntSo2411LAae
	XUrfodg/wnc22YCY8Q1s/aSYonTrZncqE/JMc9r1i5i2SKQISkhkM/4xTqhMMa4YtawUYv7h+U6
	B+Hk/gqowbTkkuPbdSo39nt0IEh3W78jxUljH9SEncHMTMkDfnrX7NK7w8Yr37yLnGEvwOVI2GG
	HwfIavcxUld5JK/8x4p8+QqsElCm+Kar6oVcZJ22PCvkCE8Oqq3GWej2BDSnoO0L1a7kgBStBXx
	X3IDKtsg4aQIdUq+ZjmqXL3/17cIDiD7okMtkv0QY5DYXzHZkKIC4lZUx1wLylP71zpaWZIeAtg
	FF2nXOzBL7Z88qgS7o+Cl6WaaEQjNyvIzwdUTqz+8hBDz0+AzFVkF1QCqOsI7SiFEarV5wmAnTN
	QJ+SB0a4y61bzYN0sOabENsjy7hiq1Dor445NC46ZXzV06aoxRHb2seruHuxIHZGn9woM06dq8c
	kZeTD/FCWIWId5/cHVDVu5EOmBAukIFBlLCKB2UkI0NsjofDlmpJtbGHbOPVEHvHGVIvJ6mYBNH
	b0uAhszIbrY4GlUHkwE6MoZPBWxCvC9PYZs=
X-Received: by 2002:a05:620a:a2c8:10b0:93b:c458:8254 with SMTP id af79cd13be357-93bc458828cmr282586385a.46.1789595929858;
        Wed, 16 Sep 2026 14:58:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 13/19] tpm2-pkcs11: Upgrade 1.9.2 -> 1.10.1
Date: Wed, 16 Sep 2026 17:58:13 -0400
Message-ID: <37a94c86c5c5da12e54d1d4bc587976550ab9475.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4869

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


