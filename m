Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C808AD2AB15
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 15:35:49 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.17873.1730302548192199170
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 08:35:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=FgmjEaGP;
 spf=softfail (domain: sakoman.com, ip: 209.85.160.45, mailfrom: steve@sakoman.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288661760d3so3891439fac.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730302547; x=1730907347; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvPpvqkUYdP3i0KdZDwrJP2bscr92iFXfl70fvDvOXo=;
        b=FgmjEaGPmE72dmuTyTUfbYzvLDuLBsE5Avly2RexC7OtjS3aKfiPKm3aPm10oSpyVW
         QMiKp4i3SG8HH4Uje3T+5aS2d53tmU518T16GeFD4pawSfcLahskc4nksZq8xGwwrL0U
         f8F1Yjrvl5l2+Sg/VxyiXcb4HVPNdwikvUyBFbVeQjk1iqBwYxMlsHS+EaJolpsRlA5s
         Z9gtskALhra9urLlrZg3ai+1voqTl4E0xQNDCMStcs6WYtkSFK40cgdqauK5ZPFCJECt
         Fi5VKBD+sqlnvqibgYhehJwXk1go9+kNsk7vQxoaKzCBST566AOihRUji5Y1jCGnSIe6
         PL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302547; x=1730907347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvPpvqkUYdP3i0KdZDwrJP2bscr92iFXfl70fvDvOXo=;
        b=q981iYZvjex1XTYbhhQu+VRGDEwTsKEcRngdgj22fdZbhO0OVwC24nl8av5nZMxApi
         2B28j8lLSECueaQFWzmb3pS7Q/woBZo2ZBGey/2J/Sr48ajs8xsSAgmcK4OkYlPO/op2
         hunpHfA+N8z56dxlyJN00jfOGr2+pDUmVV7Zann/MDCAS64e0HzIr6CZU0l+u0uaxl+O
         a0KqCkJBF9Aqgiji8fj6M/yfhnBjhZXJqoUW+k6dCV+F3ex8gDb54l8g1i+Zx6q5rG9C
         RHOkGpbyMbog/lxKzY67mehj1M0STg+cpkR8PYl0BSkYGaKLcLo+4JUBALpYTXE67vlq
         rVHg==
X-Gm-Message-State: AOJu0Yw2DBpPtoKPx+z3V9m4cGbgpU6KyrOAUz/nJ8JoeP6zV/coYh0T
	/XuzRH79XcWguKvBZPiSB+we/GQStU0vHmmhYHzb8E3C0ItpKKDBJXXoP/G2y3os8cZU4CIHYW/
	Y
X-Google-Smtp-Source: AGHT+IFkffgC7hbcgaTq1p3xZnbdKBamUMgaP5RmZtWII2K9BvpJN9zUIemBBRp11pEDbHTKF1w7aw==
X-Received: by 2002:a05:6870:3310:b0:255:2e14:3d9d with SMTP id 586e51a60fabf-29051adb328mr14392944fac.5.1730302547272;
        Wed, 30 Oct 2024 08:35:47 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8667c6bsm9300439a12.19.2024.10.30.08.35.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:35:46 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][styhead] config-json: skip meta-agl-core testing on styhead
Date: Wed, 30 Oct 2024 08:35:35 -0700
Message-Id: <b71d0caa34e7d1f608bdefe5e1b3c0245f74e837.1730302455.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730302455.git.steve@sakoman.com>
References: <cover.1730302455.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 15:35:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/774

meta-agl only supports master and LTS branches

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 config.json | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/config.json b/config.json
index 6881452..3147bee 100644
--- a/config.json
+++ b/config.json
@@ -684,23 +684,6 @@
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-weston:do_testimage"
             }
         },
-        "meta-agl-core" : {
-            "NEEDREPOS" : ["poky", "meta-agl"],
-            "ADDLAYER" : [
-                "${BUILDDIR}/../meta-agl/meta-agl-core"
-            ],
-            "DISTRO" : "poky-agl",
-            "BUILDINFO" : true,
-            "BUILDHISTORY" : true,
-            "PACKAGE_CLASSES" : "package_rpm",
-            "extravars" : [
-                "AGL_FEATURES = 'aglcore'"
-            ],
-            "step1" : {
-                "MACHINE": "qemux86-64",
-                "BBTARGETS": "agl-image-core-autobuilder"
-            }
-        },
         "meta-aws" : {
             "NEEDREPOS" : ["poky", "meta-openembedded", "meta-aws"],
             "ADDLAYER" : [
@@ -1245,41 +1228,37 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
+            "NEEDREPOS" : ["poky", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
             "step1" : {
-                "shortname" : "Test meta-agl YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
-            },
-            "step2" : {
                 "shortname" : "Test meta-arm YP Compatibility",
                 "MACHINE" : "qemuarm64",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-arm/meta-arm ../meta-arm/meta-arm-toolchain ../meta-arm/meta-arm-bsp ../meta-arm/meta-gem5 ../meta-arm/meta-arm-autonomy --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python ../meta-poky ../meta-openembedded/meta-filesystems ../meta-virtualization --no-auto-dependency"]
             },
-            "step3" : {
+            "step2" : {
                 "shortname" : "Test meta-aws YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-aws --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-multimedia ../meta-openembedded/meta-python -n --no-auto-dependency"]
             },
-            "step4" : {
+            "step3" : {
                 "shortname" : "Test meta-intel YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-intel --no-auto-dependency"]
             },
-            "step5" : {
+            "step4" : {
                 "shortname" : "Test meta-ti YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-ti/meta-ti-bsp ../meta-ti/meta-ti-extras --dependency ../meta-arm --no-auto-dependency"]
             },
-            "step6" : {
+            "step5" : {
                 "shortname" : "Test meta-oe YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-openembedded --no-auto-dependency"]
             },
-            "step7" : {
+            "step6" : {
                 "shortname" : "Test meta-virtualization YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-virtualization --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python ../meta-openembedded/meta-filesystems --no-auto-dependency"]
             },
-            "step8" : {
+            "step7" : {
                 "shortname" : "Test meta-clang YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-clang --no-auto-dependency"]
             },
-            "step9" : {
+            "step8" : {
                 "shortname" : "Test meta-exein YP Compatibility",
                 "extravars" : [
                     "HOSTTOOLS:remove = 'clang llvm-strip'"
-- 
2.34.1


