Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB32C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:14:56 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.3174.1739290490774471510
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:14:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IdVVySXl;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso35929925e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290489; x=1739895289; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9FII/fUj4tIeAkfD6h2ZketEol/wqLzqaeKhrfU9QY=;
        b=IdVVySXllQsvCh4nNKsMIllc6QGGEUD2P/ISd45C4jwDkAZVyG9lkc6ywmT7S7qqs3
         UUm3aN8/L2W0DpWdgVLpI8xFyr86PYn4Q1kYxJV0MffmiyqgoweOE7nATelB/WQGodPC
         vIDKHmRobrSkl0cwRFI9JB07o2FfuJUzvTo1kPyoPfzH8aEXQCgcX0yysni05tru5YZo
         F9u0BZmMftiBn6BlMitw2mnJTWx0kA0/BOK1ICBN1DpXbkt05VNkbiuRLGy6WsMZate2
         4fccCTKF6j7o7x0sDkuLhIXrSeXnfDG/bq/Oa8GZKsu1XVcl+2/R/KD9o5LEnOySeo4V
         UNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290489; x=1739895289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9FII/fUj4tIeAkfD6h2ZketEol/wqLzqaeKhrfU9QY=;
        b=GATjQhNKkgl/H8zKdmFBtdBI/aEh9z/YkryBjoROcrLvvtlEyaXBdi/vDuWUS36DaH
         7BWTKkNu8M48I2rAjwqBcXYR/auVqaptbkKp48RoOjvGvEQR8rrSaQhedRIjkHcD1i2g
         YrtIA6FQgA50aJjHxg7aRkitqKIBKXUDOAzmmg+9BeH20lmadPRrWN489t5GncOs4uM1
         5YF+YxKPN4AHRrDDJyz5R+NacL8RhAJiP2rfDlO1LaOSvLhP5/tVvH7n8ZEmaeh1HnhI
         SQfCQjU66dku8686ZmJD91lGEEd6o8exOfazs2CE9yoe34aYajT8plLHPOMqQiszW9g9
         5bng==
X-Gm-Message-State: AOJu0YzxNcuyh2Ns9opgwGb5TboCAb8vjZP/kzNXwki0zjkLKsy/vV8Q
	WQdUcjzrY9mdPVynGjKzSRORunXr3ovt3g7kha5TsXyrtSsQutdl6dX1mg==
X-Gm-Gg: ASbGnct1LDAx1PHfkWlV+DVShmQ70GeD5wT+2bOic8b2TYvzCaYbcyGJvCXx77FSZ68
	Ns4haTcUwZvQ0PjhmGbCJyPtOPBJud3qQC+8X+vny3KUlxfPFF/EcPJ3gPEJbPVS7FNRNNRH4yO
	gMPzMJuMUJNAOwnbdBW2DarwI1gXeR+T5G4u1FRw3KUlcwCucNlKLSWa0ACQUe2Doq0zfBs8Nhj
	Kc5PPGWXHoGj8aGRw6jxx+L8UGG0n1cQakuP/l7zV/c9s0VTQ2PmN98KF1NW2OgCxlWXCR4nHkw
	bGO4qQ++Ki4ym+zbBpTE0pkBKN6ZWfT2h3lFTPB8O5SRbcDz
X-Google-Smtp-Source: AGHT+IG1kZ10MBRp7hVEm0H0WoUbZJuaQ97pM+0PRsHdxf3Zng97qTmbNLN5P8QY2kfyis3GfyZdZQ==
X-Received: by 2002:a05:600c:1c07:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-4392497d041mr203014645e9.5.1739290488911;
        Tue, 11 Feb 2025 08:14:48 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4391da964e2sm183578265e9.4.2025.02.11.08.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:14:48 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCH 1/2] tensorflow: drop Upstream-Status inside third_party .patch files
Date: Tue, 11 Feb 2025 17:14:42 +0100
Message-ID: <20250211161443.3073462-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:14:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1059

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
index d9d79e8..a07777f 100644
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


