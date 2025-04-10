Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22697C369A6
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:51:21 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.35022.1744293080203396296
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=QUuupd7Z;
 spf=pass (domain: snapchat.com, ip: 209.85.221.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc0b5so567538f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744293078; x=1744897878; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhVgOk5VCbio0h7otagKnvQNaQloeV3b8DiyLWFqeK8=;
        b=QUuupd7ZhLvC28J5iMTFhvQKMlraSIsupaTQsF8h5UU/bKcnyeTNhViA+c7Wzs/TL6
         EgA155arp8N+bkN5vnPbFEZ/IrhsLF4oep38J+H+9iPyHL9oNY7em5KPFJ1UwmYxRFhB
         KSf2Svid4Hgmd3wRdYKG2eg1EPh35XQSg4xB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293078; x=1744897878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhVgOk5VCbio0h7otagKnvQNaQloeV3b8DiyLWFqeK8=;
        b=RfI1uujXYvJf+yp5p3WJJTsNSNNlsJyKtLQocB5hkbsbOJ/aMRZ2iMiUHLstPyJt16
         UX3Obj1VGXnyz1Ok9EgdlZ+9X0G4oIcMC3z5n98nyTnFTktzv0zP5GUP7IehQdjhAV+v
         quPKZS4wf/Wpl+R4AfXaEu/lKmxS3lcjXQDxRTLewAGm+dV8URe6CBIdG0RPQiZMDlsr
         Bj5VEKamrjjWSM57EmzZIs9OK5IGwdFZmZa92kjI/B9gno1Ioy0VC5TG0FUYvxYFRMTi
         h/+93OY/wzWeD1IHbzQxnqgRVJ3C2ds6j3l89Ao7q9WJYk19s5zgMhmx4Iad21GtnnIK
         zuVA==
X-Gm-Message-State: AOJu0YxpQohCdwiDgxyPXCpj6h0SaICcYvRlm+F/BPqp3GktSRPcK2xF
	NmppgZFRnp609SZebsgDRKosli5fu2685AeBjYUvQhHrSA9VYa+NRpp7li1jgYN67vo1mFBf976
	3Ak4=
X-Gm-Gg: ASbGncsP/VFKNzs+C2t2QrfQnDBt0DwRns5TRIH8eS3TCHYcGBAh7dXX5YbAh3SEoMF
	+evDax2d7OIjZBmRpHBUx2/5alQ9evU1UMGd6hZkI6tEMIj5Be1O26DC/scZCwrXtsan2Ul1A5l
	kssCDX/sPsCOe4RVn7Ir/vBDT0epji/bXPB9KNGS5sMAyuIbwCsJhZwz19yLOjA98YDXtdOco9D
	iC60yfzg0Z0O1Hr78fIvK9dW/ejOQEQDebv3phD+nNi1C+ps/VDnkFGVk51FTtFPB2TDCgkZAis
	fGPygkNFfuz006shzGT9PU5p0wK/2EHiOwqonbMMS8gNHwZyEsTIlvX5kdsoiCWU8PybPlrrO3q
	n+thCOdVSwZIBM/Y8kak=
X-Google-Smtp-Source: AGHT+IGbVM0zbKckffJ75ZWB+DJqd64k4zyH5tmHwfsZI/6h6ALA89jVBwwd8PWgJJZ54+CpOvQS+A==
X-Received: by 2002:a05:6000:2a8:b0:38f:3e1c:211d with SMTP id ffacd0b85a97d-39d8f4684bdmr2555737f8f.14.1744293078277;
        Thu, 10 Apr 2025 06:51:18 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207c8fb4sm55864195e9.35.2025.04.10.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:18 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] osx-runtime: update to 14.5
Date: Thu, 10 Apr 2025 15:50:24 +0200
Message-ID: <20250410135024.19183-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:51:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1352

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 README                                        | 22 +-------------
 .../osx-runtime/files/sdk-14.5.patch          | 18 ++++++++++++
 ..._12.3.bb => nativesdk-osx-runtime_14.5.bb} | 29 +++++++++++++------
 3 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 recipes-devtools/osx-runtime/files/sdk-14.5.patch
 rename recipes-devtools/osx-runtime/{nativesdk-osx-runtime_12.3.bb => nativesdk-osx-runtime_14.5.bb} (69%)

diff --git a/README b/README
index 4cea8d6..89845b5 100644
--- a/README
+++ b/README
@@ -3,31 +3,11 @@ meta-darwin
 
 OpenEmbedded meta layer for darwin based SDKs
 
-Note: Only macOS SDK version 12.3 (Darwin 21) is supported.
+Note: Only macOS SDK version 14.5 (>=Darwin 21) is supported.
 
 Ensure you have read and understood the Xcode license terms:
 https://www.apple.com/legal/sla/docs/xcode.pdf
 
-You also need a macOS sysroot tarball/zip file generated (copied) from a target macOS
-system. This is placed in the osx-runtime files directory and is used to compile the SDK
-against it. It needs to contain the system libraries (/usr/lib) and include files 
-(/usr/include). This tarball is not part of this meta-darwin layer and must be
-created by the user. To create it, the user is required to have a legitimate Mac computer
-with macOS 12.3 or later and with Xcode installed.
-
-Information on packaging the SDK is available at:
-https://github.com/tpoechtrager/osxcross#packaging-the-sdk
-
-Copy the created OSX-sdk.zip file to your Yocto development machine, placing it into
-meta-darwin layer:
-
- <...>/meta-darwin/recipes-devtools/osx-runtime/files
-
-You can alternatively add a nativesdk-osx-runtime_%.bbappend file to your
-layer and override SRC_URI and do_configure() to extract the SDK from
-a different location.
-
-
 This layer depends on:
 
  URI: git://git.openembedded.org/openembedded-core
diff --git a/recipes-devtools/osx-runtime/files/sdk-14.5.patch b/recipes-devtools/osx-runtime/files/sdk-14.5.patch
new file mode 100644
index 0000000..075efa3
--- /dev/null
+++ b/recipes-devtools/osx-runtime/files/sdk-14.5.patch
@@ -0,0 +1,18 @@
+From: Dominik Schnitzer <dominik@snap.com>
+Date: Mon, 17 Mar 2025 10:22:17 +0000
+Subject: [PATCH] Handle __FLT_EVAL_METHOD__ == 16
+
+Upstream-Status: Inappropriate [OE specific]
+Signed-off-by: Dominik Schnitzer <dominik@snap.com>
+diff -ru OSX-sdk-orig/usr/include/math.h OSX-sdk/usr/include/math.h
+--- OSX-sdk-orig/usr/include/math.h	2024-10-16 20:10:36.199787938 +0200
++++ OSX-sdk/usr/include/math.h	2024-10-16 20:21:31.536514706 +0200
+@@ -41,7 +41,7 @@
+     taking advantage of GCC's __FLT_EVAL_METHOD__ (which a compiler may
+     define anytime and GCC does) that shadows FLT_EVAL_METHOD (which a
+     compiler must define only in float.h).                                    */
+-#if __FLT_EVAL_METHOD__ == 0 || __FLT_EVAL_METHOD__ == -1
++#if __FLT_EVAL_METHOD__ == 0 || __FLT_EVAL_METHOD__ == -1 || __FLT_EVAL_METHOD__ == 16
+     typedef float float_t;
+     typedef double double_t;
+ #elif __FLT_EVAL_METHOD__ == 1
diff --git a/recipes-devtools/osx-runtime/nativesdk-osx-runtime_12.3.bb b/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
similarity index 69%
rename from recipes-devtools/osx-runtime/nativesdk-osx-runtime_12.3.bb
rename to recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
index f572b16..a7421cf 100644
--- a/recipes-devtools/osx-runtime/nativesdk-osx-runtime_12.3.bb
+++ b/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
@@ -1,18 +1,22 @@
-DESCRIPTION = "Runtime libraries from OSX"
+DESCRIPTION = "Runtime libraries for MacOS"
 LICENSE = "Proprietary"
 
 COMPATIBLE_HOST = ".*-darwin.*"
 
-OSX_SDK ?= "file://OSX-sdk.zip"
+OSX_SDK ?= "git://github.com/alexey-lysiuk/macos-sdk.git;nobranch=1;protocol=https;subpath=MacOSX14.5.sdk;destsuffix=git"
+SRCREV = "69ddec41e6224afebd5f19bb24764305ac3e828a"
 
-SRC_URI = "${OSX_SDK} \
-           file://LICENSE"
+SRC_URI = " \
+    ${OSX_SDK} \
+    file://sdk-14.5.patch \
+    file://LICENSE \
+"
 
 LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE;md5=03fe683ef28b9ddfe7f658a0f4b3b80e"
 
 PR = "1"
 
-S = "${WORKDIR}/OSX-sdk"
+S = "${WORKDIR}/git"
 
 inherit nativesdk
 
@@ -48,7 +52,7 @@ do_configure() {
 
 do_install () {
     mkdir -p ${D}
-	cp -r ${WORKDIR}/OSX-sdk/* ${D}/
+    cp -r ${S}/* ${D}/
 }
 
 do_stash_locale () {
@@ -59,12 +63,19 @@ ALLOW_EMPTY:${PN} = "1"
 
 PACKAGES = "${PN} ${PN}-dontship"
 
-FILES:${PN}-dontship = "/usr /System /Entitlements.plist /SDKSettings.json /SDKSettings.plist /Library"
+FILES:${PN}-dontship = " \
+    /usr \
+    /System \
+    /Entitlements.plist \
+    /SDKSettings.json \
+    /SDKSettings.plist \
+    /Library \
+    /patches \
+"
 
 SYSROOT_DIRS_NATIVE:append = " ${SDKPATHNATIVE}/runtime"
 SYSROOT_DIRS:append = " ${SDKPATHNATIVE}/runtime"
 
 sysroot_stage_all:append() {
-	sysroot_stage_dir ${D} ${SYSROOT_DESTDIR}${SDKPATHNATIVE}/runtime
+    sysroot_stage_dir ${D} ${SYSROOT_DESTDIR}${SDKPATHNATIVE}/runtime
 }
-
-- 
2.43.0


