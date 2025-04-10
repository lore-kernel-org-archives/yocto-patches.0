Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD6C3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:46:21 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.34551.1744292772612954238
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Xi7GKq2A;
 spf=pass (domain: snapchat.com, ip: 209.85.221.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso489274f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744292771; x=1744897571; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9u0qlVYfptMTexSRgN0UxMRPwiY40pw9TlKZAIc0TGk=;
        b=Xi7GKq2AwW36brgvWzQLUHbGTALhz1lk7YH/n+lSz7Zx2sc63l0Zk1G9AXQbsuHRNz
         Upoipj35qBJ43cFYa8b+HIlGwAkRXZjSJU+jHMrE2XS3n2nWrVD84fypjPUHguMHkAcm
         q67rOZlKWLlBNNOwIDI83DbBMyF9IPOT5HOg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292771; x=1744897571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u0qlVYfptMTexSRgN0UxMRPwiY40pw9TlKZAIc0TGk=;
        b=lv77OoAd7oKAKJlvmR5NLA0Mexcxu0/GvLhAoB1sgNo6HKrdyK2NpP5Bpm7eOawuPT
         OuJtGQ7YEdPxes5eH6/PLo+oM10sejQB8DcUfylhBDpEW6/azEWuw10o0QVf0heOHmcY
         HxIVqqbOgANXW8/VWVzAuHA0AVCnIqlxTWHEPnF/mPz8yoqhbqOQtt+9QpSGNzJaJpvT
         sxxoC595PZvW5fARelvSs0XIA2qK/EhuWcQNMxeTLqQ9+FYZj6s+SfZGBm3pkzT6sFZX
         oAbP/tQdTpBKRbeOtzgqzEB8nF3vOQsnJzJpSJag9ouxyF/8hIXQViYqPp+J2ZkzzQZV
         hCZg==
X-Gm-Message-State: AOJu0YwozKEYUowxx602rK06ZDLLR/5jhkEm9mhDpdbovtIj/yOZLbtj
	hjFoqayKpu9dmyrINO4xuyTZ4dgM1QYFZ64ZLmHFowi1R8pS48UlwMbdibyBY9Zgb5JNYNQskGp
	GIm0=
X-Gm-Gg: ASbGncuZL33qj7/qxoRegs9/bnf4WErT4xn+5FT1H4IO1mjIs2xfmRYsMkJm8Kmfwaq
	BQR50dFsXEf/FnLjztBo7iJtuptFtW0UZQgcxWg00IFTHFBuUIKknkZgaaKnerG0sLRlnzRGE+P
	Q0BjfHzxNvW5eVYBEME1cKtUna+mSPMgf6VmWCvD/59LJshgM3rl+piDCmQBynYQ7vZwCvdaTIB
	qb21a15fFkPszwwhNDmvdIxO9mW3E5IavoDYOxe71+euZ2Sjl7T7w+GHmytrbR/GG/v8Vrl7H6j
	1TiULew8ysynb8cv9RehvX5w55QHxORT9WFYknjJIO/HhrMKb+qjs7cN3oaoSAbyJD+X4xnPLOR
	oidHQN/m+QfGBBZhP5Rk=
X-Google-Smtp-Source: AGHT+IGJLC6hVfbQjOM0HEcq8lp5nmx5nzZssTtzL3Mv+XvRtD9GvtdL2lyYLrqchfxr9IX4A7L+4A==
X-Received: by 2002:a05:6000:178b:b0:39a:d336:16 with SMTP id ffacd0b85a97d-39d8f4993c8mr2550911f8f.34.1744292770767;
        Thu, 10 Apr 2025 06:46:10 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89378daasm4886996f8f.38.2025.04.10.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:46:10 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 1/4] cctools-port: update to 1010.6
Date: Thu, 10 Apr 2025 15:45:07 +0200
Message-ID: <20250410134510.17001-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:46:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1348

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...0.1.bb => cctools-port-crosssdk_1010.6.bb} | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
 rename recipes-devtools/cctools-port/{cctools-port-crosssdk_973.0.1.bb => cctools-port-crosssdk_1010.6.bb} (73%)

diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
similarity index 73%
rename from recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
rename to recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
index 1246d88..4d2625a 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
@@ -3,17 +3,25 @@ SECTION = "devel"
 LICENSE = "APSL-2.0"
 LIC_FILES_CHKSUM = "file://cctools/APPLE_LICENSE;md5=dacaafbaf91483700da837d31213a1e8"
 
-SRCREV = "f28fb5e9c31efd3d0552afcce2d2c03cae25c1ca"
-SRC_URI = "git://github.com/tpoechtrager/cctools-port.git;branch=master;protocol=https"
-
-PR = "r2"
+SRCREV = "a2724f04cafe3590fbc3d0beacc37293d83a2177"
+SRC_URI = "git://github.com/tpoechtrager/cctools-port.git;nobranch=1;protocol=https"
 
 inherit autotools crosssdk
 
-DEPENDS += "util-linux-native openssl-native xar-native libtapi-native"
+DEPENDS += " \
+    util-linux-native \
+    openssl-native \
+    xar-native \
+    libtapi-native \
+    libdispatch-native \
+"
+
 PROVIDES = "virtual/${TARGET_PREFIX}binutils"
 
-DEPENDS += "clang-native libcxx-native"
+DEPENDS += " \
+    clang-native \
+    libcxx-native \
+"
 
 TOOLCHAIN:class-crosssdk = "clang"
 COMPILER_RT:class-crosssdk = "-rtlib=libgcc --unwindlib=libgcc"
-- 
2.43.0


