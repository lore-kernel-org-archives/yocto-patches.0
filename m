Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F45C83F22
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 19:43:38 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.31741.1752695009920704826
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Jul 2025 12:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ud2vr1rv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so86556f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752695007; x=1753299807; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVgOlpUuhNa/yqNQ6s+iXBOSc3LPlcCg6l+UoipEmXM=;
        b=Ud2vr1rv9RiI/3+shz93uZ6lZrsxrgfrP9pREEKnn1MeOR4AXwRLhqT/kxE2tRUAx/
         vb3JtCsYa/OCsU1fW4zll9zGoTjepvJCI+DcOGjlo0prDptn00ECViDNaPXmZMzo4Ep+
         Uxkpw55awJSKuYP9niYe+oicZ5QGESX2n4QaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695007; x=1753299807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVgOlpUuhNa/yqNQ6s+iXBOSc3LPlcCg6l+UoipEmXM=;
        b=XOAGu+i77Y1MeApwLUxqzodKR5xoxeQAmfKt0QVf4vFfpnj5LQ72tD0reZFljbAzzn
         WsoePcuopZ6lnTM/hGL+uUzaRVGLyEKonwR5bN6Mo6u4OAMsPp5Im04sZXCfNDdEH8c1
         slnTxrjz1zt09Mc5GAnnkI1nvIZEp5wK9SvTX91L4Fw6DWA5hm/5oonhvTTlPRCm3XL+
         b4r2XJYNZwk+9n7RNhrDLTvGP7Mpjp0B/QD/R6O7wMiOZpkQNAr3lx6dEqUWFfqWhnMK
         5D792DQ7y6BYaiH/F7kCH1NYjf3g09ZpKIQq00PwWXKEwt1XX7QYQVUvIyRc5+0ly7GV
         8MPw==
X-Gm-Message-State: AOJu0Yyid7QM8qYD56NRHIhNfZpz1Gay+9VcB3cQ8c8uIl7H5sxbxeke
	UYjHpZLbff20BiUHxrwmgQUX0u/PbEqXRhkd6q1v+7wgl3njx0cOxt1k7C2Ij+Qoz7zgDRf77/n
	rt9Um
X-Gm-Gg: ASbGncsZJnQ3nSwv+7qDAb/0Z9lDPHQv9Q3g/GTtdn2o9z1kNZXjU7zY+gD3Eg5coO0
	Kf6q9DByIE//b+RwaKjUOUPd5b6oF9A2haYCHxgkq37tLVCKIuM/YtEwa7CLr6sM63gtRlD97pu
	ze0ghNQZ57+ft49sfSPs4+BXIAGtzkDPabwqrQmLK7WX8nrNibnef8/mSHKM16HG48gq5qJ2wjT
	8AnDZm/IAYfSEYM3QU/SkHVtTfgDhBCKabEA1q04eVbiGh7CG50dKn1QiU29DxeDpaeSZOm320m
	QJHSzpuSEj5FeajfcpMAHeOp/+1dfm6HxBYKOLsR0mqyZjftEBDWAaXsq8cjs0CCalS6yuRzpmd
	fZcalTmAKw/LZDVtEgky++ONlEzHzb+LBMgxE2foD+eGn6tugfwQ=
X-Google-Smtp-Source: AGHT+IE50Z7hagFEozTKT3Nwhfs5s7qbdAUASUa0nPCNv5LmWNQqCXJoU542bHbxKHooA27P4TDGiQ==
X-Received: by 2002:a05:6000:4406:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3b60e4d4d6dmr2497374f8f.25.1752695007076;
        Wed, 16 Jul 2025 12:43:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22ad:92e1:8848:8bb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e57200csm30371895e9.0.2025.07.16.12.43.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:43:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Remove meta-clang testing
Date: Wed, 16 Jul 2025 20:43:25 +0100
Message-ID: <20250716194325.115819-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 19:43:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1806

The key pieces moved into core so this no longer makes sense.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/config.json b/config.json
index f62d294..4d27e29 100644
--- a/config.json
+++ b/config.json
@@ -682,24 +682,6 @@
                 "BBTARGETS": "aws-iot-device-sdk-cpp-v2"
             }
         },
-        "meta-clang" : {
-            "NEEDREPOS" : ["poky", "meta-clang"],
-            "extravars" : [
-                "TOOLCHAIN = 'clang'"
-            ],
-            "step1": {
-                "shortname": "Build for qemux86-64",
-                "MACHINE": "qemux86-64",
-                "BBTARGETS": "core-image-sato-sdk",
-                "SANITYTARGETS" : "core-image-sato-sdk:do_testimage"
-            },
-            "step2": {
-                "shortname": "Build for qemuarm64",
-                "MACHINE": "qemuarm64",
-                "BBTARGETS": "core-image-sato-sdk",
-                "SANITYTARGETS" : "core-image-sato-sdk:do_testimage"
-            }
-        },
        "bringup" : {
             "SSTATEDIR" : ["SSTATE_DIR ?= '${HELPERBUILDDIR}/sstate'"],
             "TEMPLATE" : "bringup"
@@ -1219,7 +1201,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
+            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-exein", "meta-qcom"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1249,10 +1231,6 @@
                 "shortname" : "Test meta-virtualization YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-virtualization --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python ../meta-openembedded/meta-filesystems --no-auto-dependency"]
             },
-            "step8" : {
-                "shortname" : "Test meta-clang YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-clang --no-auto-dependency"]
-            },
             "step9" : {
                 "shortname" : "Test meta-exein YP Compatibility",
                 "extravars" : [

