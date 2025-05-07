Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527AC3ABBF
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 13:57:13 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.9817.1746626232891996219
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 06:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=DFy6UYoD;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30a509649e3so4107987a91.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1746626232; x=1747231032; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQtRJJU9HnjSz883s2HCw25J6vusQPFTuLBpxflQVPw=;
        b=DFy6UYoD9asuOQmDKbgXQpUKlPStKve5IvYoOsc9om+2+QR5PuYI5op8PvEEAIeAsc
         CKTROjDB6515uRlAYbM/cyetZT2dGihT7xWaN4y+udgCLxa07xvleeO3xmSRdlOlAMhD
         vE2uePwwI9exv1EqEnZvFhvokiPEYJKH1Rkl5ghKi1lnXwg1EHNSYA6QXB/ugI6z+4sy
         t7ZjCi/Fg3qQrQlktZNBWYB9N2KIelRza1QP7AyWPTEemsUV1hqqpTYHBwyFYZe/rTmE
         Kut1JhmRkwlD+91CqmO9sS/2kEVSKPu+mRrB4aZhSJbGWQ1VoGRLHKZ60bazIhUjYdHR
         OR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626232; x=1747231032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQtRJJU9HnjSz883s2HCw25J6vusQPFTuLBpxflQVPw=;
        b=SqSxMwNXPEE55v4q58rYvr1joE5TamJPKrsfYRj8sh1DwNy5ocnJ657bybK0FiGlFc
         ZaJjqmMo23Cs/8b/L69WMpjm3d0AhC8glgbvJvmUtdvkiRSXsIDTxgNCfxbqgtDNt8MT
         nps7YANpaS8mgJOzVkNZjNLQTOL90ZjJe38yQWoI5QTdBVGOGSElnI0bHuoMRWY1TI/F
         JTEivtzdTMifbIJWHgFslyfNmz4mlYJxng2y11KdaQje31DM7EVxM++y4Zxm2G4ivfIO
         JoxZkTWytMTFpovjcwAWLVsfXIyaUpSAiiUfc8kZxJcOY775k3hVjnHyVf+6pYwHxYEI
         5PEg==
X-Gm-Message-State: AOJu0YzX9os7USg/R0f/Jgh4WSCnneC7Q54PblK0O97qHAwfTCV6OnlA
	LlgVx4n/x8T9GmBLy0Tww5aYI3aEDgaTKCxvmpLxFPUPdgbLcv03GoGlc+g6iBOH2lwEfdATagR
	O
X-Gm-Gg: ASbGncuI3F0lSrRQ4Z2ZxLKhVtpAgLGCoDii0RQhDiEnwDs9FgsOezRv7ddQjwm8WrE
	DOnC+Fy7dfydcBa6UzyLxlcbrT3HMRSlkMPuUfpXMamM2x7iufFvPXIMLcW25rJUggvqvpFDtez
	uZ9/KQPal4xZ5s/h1AFMaFCDIEx+9JT0XrF0d2BxhXNmXBl3kjCEeNYlvW+hN2fgoMM+EsJGrTK
	vQ+7QMEAr02boIiWIK5r1INAjD1FCPqP1vJXO4Kuv0h1+rugKb4YpDUW/uXFXYYMiFft/y/hRM/
	JaH4G2sYSIr9wl9Ip0Hr2yq8Bwn0SKcZ31PcoOh+aBU=
X-Google-Smtp-Source: AGHT+IGeZO83SNiMYNO6zYWLgP4kQ36lcasC8bhhCz2RNgVgzvZ5so9ATo/f2eX/Ecs3YSjaVTl2UA==
X-Received: by 2002:a17:90b:3945:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-30aac19d430mr5928069a91.11.1746626231835;
        Wed, 07 May 2025 06:57:11 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:7681:5b3e:8acc:798e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4b40ecbsm134922a91.12.2025.05.07.06.57.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:57:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][walnascar] config-json: skip meta-agl-core testing on walnascar
Date: Wed,  7 May 2025 06:57:04 -0700
Message-ID: <c76127eb5b4b84466988cc32000efc438cdeb8ca.1746626158.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746626158.git.steve@sakoman.com>
References: <cover.1746626158.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 13:57:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1528

meta-agl only supports master and LTS branches

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 config.json | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/config.json b/config.json
index 03472a5..bc1ecc8 100644
--- a/config.json
+++ b/config.json
@@ -669,23 +669,6 @@
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
@@ -1241,41 +1224,37 @@
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
2.43.0


