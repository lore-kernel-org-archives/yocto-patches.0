Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDEDC0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:17:06 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.3218.1739290615960657256
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:16:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fBQklZrK;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so4394195f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290614; x=1739895414; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHZH2qUp7pbWIAcC77iLNCAqHCg/eE2lNQ6XBsPA3JM=;
        b=fBQklZrK7pJxrTFODw+2YkISnj4iqLksMxuOhc8MGitpf3t/MIBui3Wo3Xn2bSSE5u
         ygv0QRUZqdNFA8OOV1Njgr/lejx0LvC14G4dmhxTLa0mLTgoZz8s1iNYEuD7BdIDfdNt
         oSEWK5DL/1y7mXzVKWMbpQHnqRZEdYQGthc1ihZSjYNEXFMv4zNbIydUycizIB/EnAtG
         HQ8TObHOYDgg6moSmqARTwi1B1YW5Q1n6DtjvMakaw88DD/tGI7lwSJHLSLBqnZAmbaM
         +aSsZ4p5waYWvIsbODd8cw8HMTSQ0YLguqKNpSEz8qyMEHW6CopIiSZEKIJ9c4GI+JeD
         Cj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290614; x=1739895414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHZH2qUp7pbWIAcC77iLNCAqHCg/eE2lNQ6XBsPA3JM=;
        b=vzG1o94namzuta+JIXeZE2qajNjslZN5BE/2kVMa2akQp/n3NIIa8ZrWkjkkKPEGFx
         QaLc49NCBZIi3rKeBZu2ewlEH/7kxvZa6owcrUNNpqOOr0kvCTgZ2rGNiWhjYrATMdfw
         xMtKy9w+j/g4OUD8Y+sHFXrAyTiJ/UyjDmp1ZqR+WeebGWyNj8FqC1e1ALcuhuSQabOV
         ozeE/K93UvbrSw/MwCFZFOqJGoazHZ+dYjixYPnQGfI3ftlbcL0+YIHTXEi0Nffb9x5O
         nCfIU7IUwBYiAvI/XbGaRgbvV08OOjv4evFN/ijeuhry47TNdcr3OjdSpa8+atHY/uru
         1VGw==
X-Gm-Message-State: AOJu0YyQtAeKGpWcjU0JYuXEJZyd98DZo8Sv8h8d+7Xzz1srjMOD9pOu
	5LXuhzfu6m6DqU6y9a5dl34M0T9EDqZm8YaayAFP3ky2AR9GBpsJF8O9jg==
X-Gm-Gg: ASbGncubUkHvJIKJRon8ryQHaFKvcuyTdynJ3x+mjal5nSAHYcjyzkyGK39eXjdP0y8
	W6CLzoP2eSMw8l9UVB1FGDLdtrbgCwFeYsWK36PceKJTKEg/kzWq/HfZeYo8XD0vZ7WBYMExy6v
	ExlbJFUxp0+lM5mgUhA54X3joQyXBLzcryiCLtsmRdJzG4RlihpCRri1tFRuQ2msV7rVps5Mww4
	7Ec47kB5kQ5encalTPlOZUsA6VTLfCaU0ztaRl6gEsmDA8O/pFYFBlV83p8+aj6o2Ni+AKHo/Iv
	PfvkPKP4REBKCD2j4OAIaLbWgvL/o/wqhaEnDeYfsBdOKaeo
X-Google-Smtp-Source: AGHT+IFNHT0BSO/RgpHkKF2T8NxN3pGnxL/HoaKYdLpT+VjZSGBU3YWYKT5WvicicoLfeGGSnaFcWg==
X-Received: by 2002:a5d:47cd:0:b0:38d:dfdc:52b6 with SMTP id ffacd0b85a97d-38de949dcc8mr353910f8f.37.1739290614247;
        Tue, 11 Feb 2025 08:16:54 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dbde1dfaesm15403032f8f.90.2025.02.11.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:16:53 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][kirkstone][PATCH 1/2] tensorflow: drop Upstream-Status inside third_party .patch files
Date: Tue, 11 Feb 2025 17:15:15 +0100
Message-ID: <20250211161516.3084692-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:17:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1064

* these patches create:
  third_party/0001-XNNPACK-support-32-bit-x86.patch
  third_party/0001-cpuinfo-support-32-bit-x86.patch
  third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch

  which aren't applied by do_patch bitbake task but by bazel:

  tensorflow $ grep patch_file tensorflow/workspace2.bzl | head -n 2
  tensorflow/workspace2.bzl: patch_file = ["//third_party:0001-XNNPACK-support-32-bit-x86.patch"],
  tensorflow/workspace2.bzl: patch_file = ["//third_party:0001-cpuinfo-support-32-bit-x86.patch"],
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

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 .../files/0001-support-32-bit-x64-and-arm-for-yocto.patch  | 7 ++-----
 ...rd_party-eigen_archive-workaround-ice-failure-whi.patch | 4 +---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
index 45e7c6d..5eae2fd 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
@@ -55,7 +55,7 @@ new file mode 100644
 index 00000000000..2141c37236b
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
-@@ -0,0 +1,29 @@
+@@ -0,0 +1,27 @@
 +From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Tue, 17 Aug 2021 01:09:53 -0700
@@ -63,8 +63,6 @@ index 00000000000..2141c37236b
 +
 +Use android_x86 as a workaround to support 32 bit x86
 +
-+Upstream-Status: Inappropriate [oe specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
 + BUILD.bazel | 1 -
@@ -90,7 +88,7 @@ new file mode 100644
 index 00000000000..0c83cf01675
 --- /dev/null
 +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
-@@ -0,0 +1,28 @@
+@@ -0,0 +1,27 @@
 +From f5e52b2db5516954dab9026e4f386982c4c3c3a4 Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Mon, 19 Sep 2022 00:10:18 -0700
@@ -98,7 +96,6 @@ index 00000000000..0c83cf01675
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
-- 
2.48.1


