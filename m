Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A55F428E3
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:52 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4577.1776284389285420549
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KsEsIoWJ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a5db525cso56616226d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284388; x=1776889188; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9vUmqE6XkYEFOuykPYe5gYE2YnVQF45LI4gwNdOV7U=;
        b=KsEsIoWJT7AK29P8LsPnjLUuPLu11tnpqCX36DS+E0L9ByMPdtC22EBLzpBuRq4eaE
         lT9QjBB5WmL08KC4OlWOehc8XoOYsCMD78n4srsyLuFAPvxs6AHsGgwad/yFP7b3LqdG
         BS7EvJX62Y8CwEeODaNrLcqMq1ddN6iyy0RRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284388; x=1776889188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T9vUmqE6XkYEFOuykPYe5gYE2YnVQF45LI4gwNdOV7U=;
        b=kfdykh/KRiv++zGw2x5yn2vS0NAUy56celCW+wrcFeNWxEVBhJJnWNrCv/+xuRb8fF
         YYOH2VAAb6jIt7OptaNmhH7TPL6eZfij+B72TszD985Nrqarh2GGtzJ+ptDKET/A1bA7
         9OKQNS3tMspAAAEZtt7PTRebIM2Ke1RgIKYoKuJCK9lCIRTnze8XPVrJiVQ5IuqulWH5
         JUidpgjBunTe242QBMXq0CpCUNfR39igexbiohG09zUXreJIupsbaPJrPKret75I8HS5
         UvT0w4NyNSQ19GY7ZfRoXQg7whD5fLhIxFeaMVfwNr1iR3yJQOW+cmdcRvLpGWPrfDt6
         TVbA==
X-Gm-Message-State: AOJu0YxmOu+IYvYqBihbGjs70npbL7TosQvYFKtROV4EzHqMNWdiidKk
	JDKck4GTAe+xUJsLVr7uz5iADNMx1F9jm+cc8CA+WgXyznaFhmCkoj7vgvqSjvH+nQ8GYsaOfOD
	5XaO0
X-Gm-Gg: AeBDievb9an22N8o73vsfS03UK/iz8wjwQlZQwyLzPhQBneJbyBXHiAlEdMWAOf5AoC
	camKOeuWPfxoO8fEwyXdVd35iR0ObeCZi9sgqt1jpCiJpwj3orlzOQJ/PdOWqpaORxU9bvnA+RT
	XEdO6QFeA6sbLd3Pl/hk9EpDAwR9Eu1jfoBXfPSVrOCqAI5mnyBK0mPHpMgF0GKIO+H9Xk+LZEI
	oCCf4QjdtlACNdla5NbufNDeDWJgcD5MIASAKrkJrUJISNwJcK7vRPVAZxpLV9FUvTQ/aKvaODl
	Rtmt5P3d2oWmWpxW4aQTq3Ccdq/eZBZlWpU4Yx+zyTHdTiCR1btU32LaPr1rlFiHJVQSe28ZXk5
	g+4UKzwjOPVxvAKLOw/ISpFKbV1psqGGhGQuckCREA3wFz5xGenS/BM47/ysNcp3PfY7TVF5Uwo
	zUH6ObNJx69aj+AeIlVS5yk79I4Kp+qw45pwjh3q/kU1t36ejLDDiaOmsH9Zw4sTrHZxsfFUirQ
	m+RO63xp+UdOlQxSYoE4tvQ8AKjKzKvxGnzG/ufgM+M2/hIEZ+QaE+X9mjTKQvDE8kqC91J8sw=
X-Received: by 2002:a05:6214:5402:b0:8a2:97cc:af82 with SMTP id 6a1803df08f44-8ac861c6671mr386115976d6.27.1776284387951;
        Wed, 15 Apr 2026 13:19:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 5/7] tpm2-pkcs11: fix build failure
Date: Wed, 15 Apr 2026 16:19:25 -0400
Message-ID: <d975a55a6594cabed377a8f61a41f867a7e02405.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3713

From: Peter Marko <peter.marko@siemens.com>

Use patch submitted upstream to fix build error:
| src/lib/tpm.c: In function ‘tpm_unseal’:
| src/lib/tpm.c:1040:16: error: incompatible types when returning type ‘_Bool’ but ‘twist’ {aka ‘const char *’} was expected
|  1040 |         return false;
|       |                ^~~~~

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++++++
 .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch b/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
new file mode 100644
index 0000000..2992b11
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
@@ -0,0 +1,28 @@
+From 0db779aecaae93633be963ffb8fdb097c85cc166 Mon Sep 17 00:00:00 2001
+From: Peter Marko <peter.marko@siemens.com>
+Date: Thu, 9 Apr 2026 00:00:00 +0000
+Subject: [PATCH] src/lib/tpm: return NULL for twist on auth failure
+
+`tpm_unseal` returns `twist` (a const char pointer alias). Returning
+`false` in the error path is a type mismatch that fails with stricter
+compiler settings. Return `NULL` instead.
+
+Upstream-Status: Submitted [https://github.com/tpm2-software/tpm2-pkcs11/pull/923]
+Signed-off-by: Peter Marko <peter.marko@siemens.com>
+---
+ src/lib/tpm.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/lib/tpm.c b/src/lib/tpm.c
+index 5fff5d5..c51d984 100644
+--- a/src/lib/tpm.c
++++ b/src/lib/tpm.c
+@@ -1037,7 +1037,7 @@ twist tpm_unseal(tpm_ctx *ctx, uint32_t handle, twist objauth) {
+ 
+     bool result = set_esys_auth(ctx->esys_ctx, handle, objauth);
+     if (!result) {
+-        return false;
++        return NULL;
+     }
+ 
+     TPM2B_SENSITIVE_DATA *unsealed_data = NULL;
diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
index 331dc4f..762b82f 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
@@ -7,6 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=0fc19f620a102768d6dbd1e7166e78ab"
 DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools libyaml p11-kit python3-setuptools-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
+SRC_URI += "file://0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch"
 
 SRC_URI[sha256sum] = "ce24aa5ec2471545576e892b6f64fd873a424371bbf9be4ca3a0e689ea11c9b7"
 
-- 
2.53.0


