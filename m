Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390F1C021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:14:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.3175.1739290477538497918
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:14:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cboi5CWW;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso35915675e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290476; x=1739895276; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=os2rvhWYZc19u3e44AvFgNZZTxIFXhso6agcw2DSJ0c=;
        b=cboi5CWW5NAmDZWxqNBTv6j0e/E9uaHZl947Bz3fkG2qXbqnWmYSNG8QVWm2wOkqm0
         jqiKUVZVDQr1zcQJ10WgdCfHdYOkh6UBFYNWkTTvV+k80ayzTtD8KU908XIMVR19xT0A
         y5+geYhll6BmoeadnPqaAHNf5Gtf2JbIZMZS23kA27l/tLGvXkLVz7jZ6I8UiQukmq78
         2fO1eMIW5+sAX9ukhGTe//aFGT5vQPD2AaNymnJmjVKhN5MMAogyaf3Par10iMfCqAYu
         exFa3BzOBBru/k4BlW9fftNo5DE3jQ67becbPB7anOZscghzYeNHjAyaZrVNh2JdU7EB
         XBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290476; x=1739895276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=os2rvhWYZc19u3e44AvFgNZZTxIFXhso6agcw2DSJ0c=;
        b=T6ezZ5yk7EAG5Xn9e7xT2iz7epbOIO55D43+3GCqKJ3rg3RMXGG/Yue7Yznbg9PYVC
         GMZr8dElrKWWUNBhb4VA0q93QfZMdu/qsvVmX6a0WuqoKzvbp9AsWk9ONH6pOARqv3cu
         s+W28TGnO3AEuzBfl8citGEO13Fg0zsfBxjuu3ktO2zMqGcJP3OHjsuKFkNbQIshd0i2
         I7bEZYsJsV9I0k+cKlzS4xoJ1dmFlCWuyUKcFJa3Ga58I7QQodenVwfxYZGSYgCyKV4M
         wbw+hQUl7EKQVQzMoAp+oe+XQnPbrJOJHWEkMqSuKD08MhJBUs8XKa+bR8CzgrX2qL2p
         XjSg==
X-Gm-Message-State: AOJu0YyRhXh+86XVg1d4bn2g7+zZ53Ewqf8Q6wjbsjSz4GhiBRo0QwA8
	zAX93dks5du271HMgGZw5iRMNb6a10N6hqHKgn08+4ybYaLBINEPvmExuw==
X-Gm-Gg: ASbGncsMphXEiUbg8y3ISdIO4dveoMya7W4O8X/Ohep3DsJqAI+i5WG/eu9MYnkyMvW
	0RQqxMVD1Mo0AShQBEFgaNWbh+TlRyFAfotpSZhp2UPWXM9qc8F9TMhlRyDMRgVv7MVSwAoqN5+
	LcTrcDXFO+IUnz9UPgRR33gB1RCpYP5ZNbMNY4h0XPQ5DryFBm3stmkEfL4DTuR0v/j3ClBrh40
	xHZsfXTZFILNR1uk0q/fhvS+bO1EftCHhUnBlm9mKoJt7jluHTKOdCmwo9+raB54954Q0CuzMmS
	oGbdSBm5oXoRmN2WPnyw/Ogwxl3Ur4pIGN2V8DqjzltkFLAm
X-Google-Smtp-Source: AGHT+IHnNAefR/6BVCDwcaVsWfXGiPClNbIqBMtznlEc4/yz2ohVT2777xBVacV5pxBIvbHM9AhpYA==
X-Received: by 2002:a05:600c:3b10:b0:439:5756:ad4c with SMTP id 5b1f17b1804b1-4395756afdemr8539795e9.14.1739290475580;
        Tue, 11 Feb 2025 08:14:35 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38ddbfbb4ffsm7133558f8f.94.2025.02.11.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:14:35 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][master][PATCH 1/2] tensorflow: drop Upstream-Status inside third_party .patch files
Date: Tue, 11 Feb 2025 17:14:26 +0100
Message-ID: <20250211161427.3067063-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:14:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1057

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

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 .../tensorflow/files/0001-hardcode-go-SDKS.patch           | 4 +---
 .../files/0001-support-32-bit-x64-and-arm-for-yocto.patch  | 7 ++-----
 ...rd_party-eigen_archive-workaround-ice-failure-whi.patch | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

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
index 837e425..9cbbea1 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
@@ -56,7 +56,7 @@ new file mode 100644
 index 00000000000..9d7e91ff9fe
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
-@@ -0,0 +1,29 @@
+@@ -0,0 +1,27 @@
 +From 13f013db421c5aefa021f3b75d9d8554ad4fde52 Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 +Date: Fri, 1 Mar 2024 00:35:18 -0800
@@ -64,8 +64,6 @@ index 00000000000..9d7e91ff9fe
 +
 +Use android_x86 as a workaround to support 32 bit x86
 +
-+Upstream-Status: Inappropriate [oe specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
 +---
 + build_config/BUILD.bazel | 1 -
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
index 3c8a685..572e708 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -24,7 +24,7 @@ new file mode 100644
 index 00000000000..523a32d78f7
 --- /dev/null
 +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
-@@ -0,0 +1,70 @@
+@@ -0,0 +1,68 @@
 +From 649d0b938aab1b7081c3895aa1f527d034edb735 Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Fri, 23 Aug 2024 10:49:54 +0800
@@ -37,8 +37,6 @@ index 00000000000..523a32d78f7
 +But we could not patch on native gcc,so try to workaround,
 +Refer: https://github.com/tensorflow/tensorflow/issues/25323
 +
-+Upstream-Status: Inappropriate [wr-installer specific]
-+
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
 + unsupported/Eigen/CXX11/src/Tensor/TensorImagePatch.h | 4 +++-
-- 
2.48.1


