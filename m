Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666EC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:15:16 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.3191.1739290506500747547
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:15:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R1e4gFG2;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd91c313bso1598981f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290505; x=1739895305; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRFNPzEXt+vQZY0p+5H+Zehw578M9Flar0oIT/1kKbk=;
        b=R1e4gFG2YKP2R9tIzvL44Jn032jhV35YrvNLvtQO4NLsurlT0LmR+xFJu16fz4B0NF
         l7bieD8Vez9j+N8lR6ziNfVSCrTjPYYNx6Mq068l1/+GqcKZC+Cu1W4FU1ZSN7dlklgP
         t6cHY8DLdGQ9x7wf92hyq4oIkgN+6v3YbEIsUpyJagiBg9HtrCRmsACPSimcntq910Z6
         6wl9ESwasLUvvK0fpM2EmIQHPS7A0xhDb9JwLVXxXyAtw16Xe0cplkGqE8MDhKYKGiKl
         TGFB2yoGYHztls/hr1ZJ7j25lUcseHGr/QHM/lHVtjsQDOJ5fZw1TDPFveJ7fupVlrFu
         9tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290505; x=1739895305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRFNPzEXt+vQZY0p+5H+Zehw578M9Flar0oIT/1kKbk=;
        b=aY7mthSHxphdRnlDOde9yg5/ibZKX99f568RvPt2qNqnqt/EixZl5aArMw8ve3ZxO2
         sWvO9SwQvKDoHNAXSMZfmHhNP/fUIhWtmiXGnLDodmBaD/w+marYUGInkUro8lZuy1E5
         brz7QiiVE+ToBugxp8L6LAfm53m4By2aKLdYxQRMtL66RFAcYRVLPFOAFZNvtY/cRPFI
         87neK6ghSJ9PfrvVk2M+J/VCZHVMLDjUJxEODHWIKe2KP7mTnk4jy8VuONPOcNOHEV8x
         u+GTXuhFgni4S/RY0D0KVNmr5v2LlH0tcIwbL3fuo815E5ztDeD+nUsk+ZDoA6iN9DxR
         +ViQ==
X-Gm-Message-State: AOJu0Yxfdwkt46k0ZT7Km1GHMbkD/ztPzrTGSk7DhIeWs71akaA+tl6l
	uTucvOb50PdZ7jIPHa+9Zi281/esINzt5Ix4xxnqfs2yq4f/Js2V0dBeMg==
X-Gm-Gg: ASbGnctHTpxxAzHDZp0oIfbSyLal0VOlO5ucQiJSsDT3wnLnO60fWb6ANoQaXuTiriN
	sLkdM9O8rfzaWCbIRDvoM4Rq89D+6GRVn4F+KKW3ziaRPRwrq46obcvwnvOyi/HmfpAwlpPqEK3
	BjS2K5UNvxDXCBGSz+KdsSCbLx7QiLxuA1U3IXmhPXCukEZuIWZoP21MXdjsGeA/1d8DrJRobP4
	My5adN9djyPdKDV0yiHmF5oyluWPZ25OeIE9atrWbtzqmoB2f9dr0t4ee3h6uxmExFBhBu6a8BS
	VEgrZWRTRLOYMRF5MCmsqDJkkmeGFTr10X8kczqsP80RlxfH
X-Google-Smtp-Source: AGHT+IGPeEA045cX47OXefIfum67TxghmkoBq1rmcr1q+jqJn/YW7Go7XiyLSSjfyNbec3Qrex+6nQ==
X-Received: by 2002:a5d:47c4:0:b0:38d:d8c0:1f87 with SMTP id ffacd0b85a97d-38de419487fmr4227585f8f.30.1739290504591;
        Tue, 11 Feb 2025 08:15:04 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4391dc9ff64sm177507925e9.9.2025.02.11.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:15:04 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][mickledore][PATCH 1/3] tensorflow: drop Upstream-Status inside third_party .patch files
Date: Tue, 11 Feb 2025 17:14:57 +0100
Message-ID: <20250211161500.3077588-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1061

* these patches create:
  third_party/0001-XNNPACK-support-32-bit-x86.patch
  third_party/0001-cpuinfo-support-32-bit-x86.patch
  third_party/0001-hardcode-go-SDKS.patch
  third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch

  which aren't applied by do_patch bitbake task but by bazel:

  tensorflow $ grep patch_file tensorflow/workspace2.bzl | head -n 2
  tensorflow/workspace2.bzl: patch_file = ["//third_party:0001-XNNPACK-support-32-bit-x86.patch"],
  tensorflow/workspace2.bzl: patch_file = ["//third_party:0001-cpuinfo-support-32-bit-x86.patch"],
  tensorflow/workspace2.bzl: patch_file = ["//third_party:0001-hardcode-go-SDKS.patch"],
  third_party/eigen3/workspace.bzl: patch_file = ["//third_party/eigen3:0001-workaround-ice-failure-while-building-from-source-wi.patch"],

  so they don't really need Upstream-Status and including it there
  might cause false possitive e.g. in
  0001-fix-XNNPACK-build-failure-for-qemuarm.patch

  ERROR: tensorflow-lite-2.10.0-r0 do_patch: QA Issue: Malformed Upstream-Status in patch
  recipes-framework/tensorflow/tensorflow-lite/0001-fix-XNNPACK-build-failure-for-qemuarm.patch
  Please correct according to https://docs.yoctoproject.org/contributor-guide/recipe-style-guide.html#patch-upstream-status :
   Upstream-Status: Inappropriate [oe specific] [patch-status]
  ERROR: tensorflow-lite-2.10.0-r0 do_patch: Fatal QA errors were found, failing task.

  caused by extra space before Upstream-Status

  Maybe we should drop 0001-fix-XNNPACK-build-failure-for-qemuarm.patch completely
  as it was already dropped from tensorflow in:
  https://git.yoctoproject.org/meta-tensorflow/commit/?h=mickledore&id=baae9cd6d92f69aa16b874958a332e1d3a362fea
  and from tensorflow-lite in scarthgap branch:
  https://git.yoctoproject.org/meta-tensorflow/commit/?h=scarthgap&id=29509c97e9009ed0ae99ce6c2554e463575dc10c

  and is now used only for tensorflow-lite, refresh it to apply

  It was originally introduced for both in:
  https://git.yoctoproject.org/meta-tensorflow/commit/?h=mickledore&id=e0efac349f2aac3d65ccbeee20475dbb1ea3dd19
  and refreshed in:
  https://git.yoctoproject.org/meta-tensorflow/commit/?h=mickledore&id=30fbec74ea37b646473b08d0ee8d3992ccd56245

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 .../tensorflow/files/0001-hardcode-go-SDKS.patch    |  4 +---
 .../0001-support-32-bit-x64-and-arm-for-yocto.patch |  7 ++-----
 ...y-eigen_archive-workaround-ice-failure-whi.patch |  4 +---
 ...019-fix-XNNPACK-build-failure-for-qemuarm.patch} | 13 ++++---------
 .../tensorflow/tensorflow-lite_2.12.0.bb            |  2 +-
 5 files changed, 9 insertions(+), 21 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-fix-XNNPACK-build-failure-for-qemuarm.patch => 0019-fix-XNNPACK-build-failure-for-qemuarm.patch} (97%)

diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
index b705ec7..e365c27 100644
--- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
+++ b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
@@ -38,7 +38,7 @@ new file mode 100644
 index 00000000000..b51d7262f4c
 --- /dev/null
 +++ b/third_party/0001-hardcode-go-SDKS.patch
-@@ -0,0 +1,49 @@
+@@ -0,0 +1,47 @@
 +From 34242e73f76eff09ee33152c58c3be650331b7ff Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 +Date: Thu, 1 Dec 2022 15:07:10 +0000
@@ -53,8 +53,6 @@ index 00000000000..b51d7262f4c
 +downloaded archive, so hardcode go SDKS list files rather than
 +fetch from internet
 +
-+Upstream-Status: Inappropriate [Yocto specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
 +---
 + go/private/sdk.bzl | 7 +++++++
diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
index a855b30..22bd6c1 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
@@ -56,7 +56,7 @@ new file mode 100644
 index 00000000000..2141c37236b
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
-@@ -0,0 +1,29 @@
+@@ -0,0 +1,27 @@
 +From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Tue, 17 Aug 2021 01:09:53 -0700
@@ -64,8 +64,6 @@ index 00000000000..2141c37236b
 +
 +Use android_x86 as a workaround to support 32 bit x86
 +
-+Upstream-Status: Inappropriate [oe specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
 + BUILD.bazel | 1 -
@@ -91,7 +89,7 @@ new file mode 100644
 index 00000000000..0c83cf01675
 --- /dev/null
 +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
-@@ -0,0 +1,28 @@
+@@ -0,0 +1,27 @@
 +From f5e52b2db5516954dab9026e4f386982c4c3c3a4 Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Mon, 19 Sep 2022 00:10:18 -0700
@@ -99,7 +97,6 @@ index 00000000000..0c83cf01675
 +
 +Use android_x86 as a workaround to support 32 bit x86
 +
-+Upstream-Status: Inappropriate [oe specific]
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
 + BUILD.bazel | 1 -
diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
index b1571ab..2056c20 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -24,7 +24,7 @@ new file mode 100644
 index 00000000000..436f35fca13
 --- /dev/null
 +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
-@@ -0,0 +1,69 @@
+@@ -0,0 +1,67 @@
 +From 035fd96026e18d61c19da038ab2b0f7a61e97799 Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Mon, 19 Sep 2022 01:08:18 -0700
@@ -37,8 +37,6 @@ index 00000000000..436f35fca13
 +But we could not patch on native gcc,so try to workaround,
 +Refer: https://github.com/tensorflow/tensorflow/issues/25323
 +
-+Upstream-Status: Inappropriate [wr-installer specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
 + unsupported/Eigen/CXX11/src/Tensor/TensorImagePatch.h | 3 ++-
diff --git a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qemuarm.patch b/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qemuarm.patch
rename to recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch
index dea74d9..1a792ee 100644
--- a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qemuarm.patch
+++ b/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch
@@ -1,4 +1,4 @@
-From c15caa4d5f133307a23114c41a9c497e5ec9da2c Mon Sep 17 00:00:00 2001
+From 2ace7a16a8033169b7ddb71a79956416644ffa3e Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Thu, 23 Mar 2023 10:28:04 +0800
 Subject: [PATCH] fix XNNPACK build failure for qemuarm
@@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 209 insertions(+), 7 deletions(-)
 
 diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/third_party/0001-XNNPACK-support-32-bit-x86.patch
-index 2141c37236b..ca6a38545b1 100644
+index e2c053e6f8c..89ba615a9fe 100644
 --- a/third_party/0001-XNNPACK-support-32-bit-x86.patch
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
-@@ -1,22 +1,36 @@
+@@ -1,20 +1,34 @@
 -From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 2001
 +From 5ba6883121e91a334cc97ee98eea6ef0afb7a314 Mon Sep 17 00:00:00 2001
  From: Hongxu Jia <hongxu.jia@windriver.com>
@@ -28,8 +28,6 @@ index 2141c37236b..ca6a38545b1 100644
  
 +Does not support 32 bit ARM with Neon DotProduct
 +
- Upstream-Status: Inappropriate [oe specific]
- 
  Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  ---
 - BUILD.bazel | 1 -
@@ -59,7 +57,7 @@ index 2141c37236b..ca6a38545b1 100644
   config_setting(
       name = "android_x86",
       values = {
-@@ -24,6 +38,194 @@ index 27ab07c9..f223d2ab 100644
+@@ -22,6 +36,194 @@ index 27ab07c9..f223d2ab 100644
           "cpu": "x86",
       },
   )
@@ -255,6 +253,3 @@ index 2141c37236b..ca6a38545b1 100644
 -2.30.2
 +2.27.0
  
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
index 83fd12d..e76a09b 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
@@ -15,7 +15,7 @@ SRC_URI += " \
            file://yocto_compiler_configure.bzl \
           "
 SRC_URI:append:arm = " \
-           file://0001-fix-XNNPACK-build-failure-for-qemuarm.patch \
+    file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
 "
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
-- 
2.48.1


