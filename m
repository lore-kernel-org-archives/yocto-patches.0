Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.950.1713975614436896830
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Apr 2024 09:20:14 -0700
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417e327773cso6584865e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Apr 2024 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975612; x=1714580412; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33wNe+Wwer2hx4UwyhtexKAu2o9DVpPRpEAXGAwRmV8=;
        b=WcP3uIC/dJA33My/cP11U2RUe54qXckq8XEvm3b63Zv4sNnSoEvJWoP7yvGrxpk6Gf
         jl5TJpiU+d6GKY/nlEbbVhtq/j2deX3l365WqiIGDjOfsuuAbTJpu5XssI27X2JEhVW9
         gc30FCQkRgZuJRK2yG7woXirGCZrrVPHz/yHimc1mJUJ43cnlbQ3vmKrMM19TNPEKvww
         0Z7mevT8TX7VVDKnI29lTrkLMkMbzw0o6vZKQQDRvH8xg6x65F2+hrrAu1HRzu4LpXc7
         K89IhjKHYMHA5mCM1ksWA0UhRxM+b70b1AAGlbBn8eA4CaYMLjojflPckT+NfitoTrP1
         WaFQ==
Return-Path: <rybczynska@gmail.com>
From: "Marta Rybczynska" <rybczynska@gmail.com>
Subject: [meta-security][PATCH] packagegroup-core-security: update libseccomp dependencies
Date: Wed, 24 Apr 2024 18:20:04 +0200
Message-ID: <20240424162004.1659072-1-marta.rybczynska@syslinbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@syslinbit.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

libseccomp requires DISTRO_FEATURE seccomp enabled. This one
is automatically removed for riscv, so we do not need to add
an additional condition.

This change is necessary for cve-check on world with meta-security

Signed-off-by: Marta Rybczynska <marta.rybczynska@syslinbit.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 3ef77e5..9eab063 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -40,7 +40,7 @@ RDEPENDS:packagegroup-security-utils = "\
     pinentry \
     softhsm \
     sshguard \
-    ${@bb.utils.contains_any("TUNE_FEATURES", "riscv32 ", "", " libseccomp",d)} \
+    ${@bb.utils.contains("DISTRO_FEATURES", "seccomp ", "libseccomp", "",d)} \
     ${@bb.utils.contains("DISTRO_FEATURES", "pam", "google-authenticator-libpam", "",d)} \
     ${@bb.utils.contains("DISTRO_FEATURES", "pax", "pax-utils packctl", "",d)} \
     "
-- 
2.42.0

