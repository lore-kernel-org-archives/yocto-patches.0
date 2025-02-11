Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB1C021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:14:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.3175.1739290492034749974
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:14:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l8bSk88S;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43934d41730so31208015e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290490; x=1739895290; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfnxPg1z1r8LYVPzKCKsecYrCdhtbpOyXVebWqVxgb4=;
        b=l8bSk88SjCTbwsD41Rl1EEFcn5LDSb9frW2ORFA9i5D3rNKcd9yZ1fRpPanUsrnP2Y
         TkE2PBW4uaE34uBU7f6YEkEAPHCYufjA4I+95EyoFC1QTBDlFtiNRlFy2OAPjnsQ9IIZ
         CtyQGjq6Bg7/FYOLSDJx4uWuKm4uq2w3C8h6frjBpwu7kKmqtD2x4PmGcu0Tvo6aJpRF
         d2GAR5gC14rz6yn332U7ZUK/R5yp4qmRi7DifxD9I7EFp4BXBGveelOrKQ3AQgp1lMk7
         N7K+gakOHwNFuTq9BW3Dy5f44XXYaWwGEUeHpFC23NNisTCt1da1Sek4RgH8Ekjdlc9b
         DeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290490; x=1739895290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfnxPg1z1r8LYVPzKCKsecYrCdhtbpOyXVebWqVxgb4=;
        b=ookFwsDkymFWwOsa4AAdPiSrG2R7qrMOTfugRyScHFFJhMkZJWujezoGjz9c7pa/fC
         2eTHa4YFvt69hU8mP1OGh18XqraGuZOOH1hZ9ILp90VUfHuYwhIo5XyFetAc26vLtdQu
         L+weADT5a74mNXA5kMPh/QgXzg9usXA2DoDKdSFAYTq9HwrW+EGINdngZGwwIXZqVVez
         y//26yXWnnwxp99Ej0NBsS14aiqHRlMOfDRYLcedUPItRuvt4hTpmlM5EZdQPxqdX8yp
         VNASM4ySeoWp31gHZMLGpw3jR1kkRZl7T4XXvB1hSD4Iya5Op/Fx4i9HEKd2KpKi8G4g
         8yoQ==
X-Gm-Message-State: AOJu0Yy/wkGxo0113XADakv6RhBsU1stRdpcreP0wI0WAJWmsUDwMyaL
	TeDezgd+iWy80II1q7F3jF4OT1EaEuRiW0wOcFz7LX5RUs6vcTTw8bJhNQ==
X-Gm-Gg: ASbGncuYFwR3fuoiuNKXTifKfXrkFMpvaP8/dkX1R6CsDhC9OvLODUYn5OrtJVMLCxm
	He6tK7VcLExX3GuOAR65yYsDt7QuoMW5OG96ZJ0S8kEKCHKAs2hFBp5+C9mFQIahfbJ5lD5n6/H
	KL3o0cGrqSmbFzNStsMODuigNN8b0K0waavEc42Xs+yVr20qmtNMlB1PP4aYVQ6Cnkea/2T+zaj
	IOcKRkGvKUw5T7+j7dIYglyTKM7na8E9lNrrG/bL2+N0bXSJGGBLbht/CNX7lZoX7w60rYu3vRz
	u+6lTnCQgF0XuHQfcJFHVvyCy5j1ABGcDKQ3ibQpkjxeRTjL
X-Google-Smtp-Source: AGHT+IHVQ/bjehAFEFi4Q0NwKwOvml4UPHvOK1812nSiveXWKE7HIqmW7iKoTz53VFXg/r8dejE9cg==
X-Received: by 2002:a05:6000:1862:b0:38d:d6cc:a6e1 with SMTP id ffacd0b85a97d-38de937cdefmr339265f8f.28.1739290490143;
        Tue, 11 Feb 2025 08:14:50 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd44c5e3dsm9805823f8f.62.2025.02.11.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:14:49 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCH 2/2] tensorflow: refresh and rename the .patch files
Date: Tue, 11 Feb 2025 17:14:43 +0100
Message-ID: <20250211161443.3073462-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211161443.3073462-1-martin.jansa@gmail.com>
References: <20250211161443.3073462-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:14:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1060

* use --no-signature as devtool does to avoid unnecessary git signature
  changes
* rename to have increasing numbers in the order how they should
  be applied (so they can be all easily applied with single git
  am call), the only exception is
  0001-disable-avxvnni-for-x86.patch used only in native builds

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 ...el-to-workaround-bazel-paralle-issue.patch |  9 +++----
 ..._archive-workaround-ice-failure-whi.patch} | 13 ++++------
 ...ains_repositories-to-support-offlin.patch} |  9 +++----
 ...config.patch => 0004-drop-v2-config.patch} |  9 +++----
 ...sysconfig.get_python_lib-with-sysco.patch} |  5 +---
 ...SDKS.patch => 0006-hardcode-go-SDKS.patch} | 15 +++++-------
 ...ure.patch => 0007-fix-build-failure.patch} |  5 +---
 ...tch => 0008-support-hermetic-Python.patch} |  7 ++----
 ...metic-python3-support-offline-build.patch} |  7 ++----
 ...patch => 0010-Fix-build-with-gcc-12.patch} |  5 +---
 ...oolchain-to-support-cross-compiling.patch} | 13 ++++------
 ...tch => 0011-disable-avxvnni-for-x86.patch} |  5 +---
 ...low-lite-examples-label_image-label.patch} | 11 ++++-----
 ..._image-tweak-default-model-location.patch} | 13 ++++------
 ...e.lite-tweak-default-model-location.patch} |  5 +---
 ...atureOrDie-use-warning-to-avoid-die.patch} |  9 +++----
 ...upport-32-bit-x64-and-arm-for-yocto.patch} | 21 +++++++---------
 ...api_gen_binary_target-as-host-tools.patch} |  5 +---
 .../tensorflow/tensorflow-lite_2.16.1.bb      | 22 ++++++++---------
 .../tensorflow/tensorflow-native_2.16.1.bb    |  2 +-
 recipes-framework/tensorflow/tensorflow.inc   | 22 ++++++++---------
 .../tensorflow/tensorflow_2.16.1.bb           | 24 +++++++++----------
 22 files changed, 91 insertions(+), 145 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-third_party-eigen_archive-workaround-ice-failure-whi.patch => 0002-third_party-eigen_archive-workaround-ice-failure-whi.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-drop-bazel_toolchains_repositories-to-support-offlin.patch => 0003-drop-bazel_toolchains_repositories-to-support-offlin.patch} (89%)
 rename recipes-framework/tensorflow/files/{0001-drop-v2-config.patch => 0004-drop-v2-config.patch} (79%)
 rename recipes-framework/tensorflow/files/{0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch => 0005-eplace-distutils.sysconfig.get_python_lib-with-sysco.patch} (97%)
 rename recipes-framework/tensorflow/files/{0001-hardcode-go-SDKS.patch => 0006-hardcode-go-SDKS.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-failure.patch => 0007-fix-build-failure.patch} (96%)
 rename recipes-framework/tensorflow/files/{0001-support-hermetic-Python.patch => 0008-support-hermetic-Python.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-make-hermetic-python3-support-offline-build.patch => 0009-make-hermetic-python3-support-offline-build.patch} (96%)
 rename recipes-framework/tensorflow/files/{0001-Fix-build-with-gcc-12.patch => 0010-Fix-build-with-gcc-12.patch} (92%)
 rename recipes-framework/tensorflow/files/{0001-add-yocto-toolchain-to-support-cross-compiling.patch => 0011-add-yocto-toolchain-to-support-cross-compiling.patch} (92%)
 rename recipes-framework/tensorflow/files/{0001-disable-avxvnni-for-x86.patch => 0011-disable-avxvnni-for-x86.patch} (96%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-tensorflow-lite-examples-label_image-label.patch => 0012-fix-build-tensorflow-lite-examples-label_image-label.patch} (85%)
 rename recipes-framework/tensorflow/files/{0001-label_image-tweak-default-model-location.patch => 0013-label_image-tweak-default-model-location.patch} (89%)
 rename recipes-framework/tensorflow/files/{0001-label_image.lite-tweak-default-model-location.patch => 0014-label_image.lite-tweak-default-model-location.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch => 0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch} (90%)
 rename recipes-framework/tensorflow/files/{0001-support-32-bit-x64-and-arm-for-yocto.patch => 0016-support-32-bit-x64-and-arm-for-yocto.patch} (89%)
 rename recipes-framework/tensorflow/files/{0001-build-api_gen_binary_target-as-host-tools.patch => 0017-build-api_gen_binary_target-as-host-tools.patch} (98%)

diff --git a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch b/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
index 8a17700..3d54b7e 100644
--- a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
+++ b/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
@@ -1,4 +1,4 @@
-From bbdf1bbca17f8bce98e32b25aa9bfadc8f465f24 Mon Sep 17 00:00:00 2001
+From 3a89b6024e27239d645b73804318fe23157787b8 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 15 May 2022 23:59:17 -0700
 Subject: [PATCH] use local bazel to workaround bazel paralle issue
@@ -12,10 +12,10 @@ Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/configure.py b/configure.py
-index dae3dce89d3..979f00f3633 100644
+index c1cb2016201..a160912ba0b 100644
 --- a/configure.py
 +++ b/configure.py
-@@ -475,7 +475,7 @@ def check_bazel_version(min_version, max_version):
+@@ -423,7 +423,7 @@ def retrieve_bazel_version():
    Returns:
      The bazel version detected.
    """
@@ -24,6 +24,3 @@ index dae3dce89d3..979f00f3633 100644
    if bazel_executable is None:
      bazel_executable = which('bazelisk')
      if bazel_executable is None:
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/files/0002-third_party-eigen_archive-workaround-ice-failure-whi.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
rename to recipes-framework/tensorflow/files/0002-third_party-eigen_archive-workaround-ice-failure-whi.patch
index 2056c20..7705747 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0002-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -1,4 +1,4 @@
-From 385074d9300c18293a42c9d8ca9fb12cbffccb80 Mon Sep 17 00:00:00 2001
+From fda2e557683c2a38b7bbc9eb20d4f8a4f557ac03 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 23:15:47 -0700
 Subject: [PATCH] third_party/eigen_archive:workaround ice failure while
@@ -14,14 +14,14 @@ Upstream-Status: Inappropriate [wr-installer specific]
 
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
- ...ailure-while-building-from-source-wi.patch | 69 +++++++++++++++++++
+ ...ailure-while-building-from-source-wi.patch | 67 +++++++++++++++++++
  third_party/eigen3/workspace.bzl              |  1 +
- 2 files changed, 70 insertions(+)
+ 2 files changed, 68 insertions(+)
  create mode 100644 third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 
 diff --git a/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 new file mode 100644
-index 00000000000..436f35fca13
+index 00000000000..6032258ed82
 --- /dev/null
 +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 @@ -0,0 +1,67 @@
@@ -93,7 +93,7 @@ index 00000000000..436f35fca13
 +2.37.1
 +
 diff --git a/third_party/eigen3/workspace.bzl b/third_party/eigen3/workspace.bzl
-index 1380722ee67..722cfbece83 100644
+index 027454e46dd..6871cd1b5dd 100644
 --- a/third_party/eigen3/workspace.bzl
 +++ b/third_party/eigen3/workspace.bzl
 @@ -14,6 +14,7 @@ def repo():
@@ -104,6 +104,3 @@ index 1380722ee67..722cfbece83 100644
          sha256 = EIGEN_SHA256,
          strip_prefix = "eigen-{commit}".format(commit = EIGEN_COMMIT),
          urls = tf_mirror_urls("https://gitlab.com/libeigen/eigen/-/archive/{commit}/eigen-{commit}.tar.gz".format(commit = EIGEN_COMMIT)),
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch b/recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
similarity index 89%
rename from recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
rename to recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
index 730f2c2..b86dfa5 100644
--- a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
+++ b/recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
@@ -1,4 +1,4 @@
-From 6bb9c02aae20996a6e4edd8fe743a90ce8d677aa Mon Sep 17 00:00:00 2001
+From 280d8828009ecdf442e98f3d9315ff62d1bb16c1 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 18 Sep 2022 23:52:34 -0700
 Subject: [PATCH] drop bazel_toolchains_repositories to support offline build
@@ -14,7 +14,7 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 deletions(-)
 
 diff --git a/tensorflow/workspace0.bzl b/tensorflow/workspace0.bzl
-index c3c081b19ef..445de71bb13 100644
+index d8b53e1ef8b..2e80169790c 100644
 --- a/tensorflow/workspace0.bzl
 +++ b/tensorflow/workspace0.bzl
 @@ -2,7 +2,6 @@
@@ -25,7 +25,7 @@ index c3c081b19ef..445de71bb13 100644
  load("@build_bazel_rules_apple//apple:repositories.bzl", "apple_rules_dependencies")
  load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")
  load("@build_bazel_apple_support//lib:repositories.bzl", "apple_support_dependencies")
-@@ -104,8 +103,6 @@ def workspace():
+@@ -105,8 +104,6 @@ def workspace():
          ],
      )
  
@@ -34,6 +34,3 @@ index c3c081b19ef..445de71bb13 100644
      # Apple rules for Bazel. https://github.com/bazelbuild/rules_apple.
      # Note: We add this to fix Kokoro builds.
      # The rules below call into `rules_proto` but the hash has changed and
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-drop-v2-config.patch
rename to recipes-framework/tensorflow/files/0004-drop-v2-config.patch
index ff74a3c..aa8b63f 100644
--- a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch
+++ b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
@@ -1,4 +1,4 @@
-From 104224b8b30f74dabed893aa057f400ad7cd2695 Mon Sep 17 00:00:00 2001
+From bf8ccc7a5907b2d241d77dbb7ef4f7f979e651e2 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:10:55 -0700
 Subject: [PATCH] drop v2 config
@@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index b6a72c1e5d3..a71ade6950f 100644
+index 315669e7930..deb1a918146 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -138,9 +138,6 @@ build --define=with_xla_support=true
+@@ -117,9 +117,6 @@ build --define=with_xla_support=true
  # TODO(mihaimaruseac): Document this option or remove if no longer needed
  build --config=short_logs
  
@@ -24,6 +24,3 @@ index b6a72c1e5d3..a71ade6950f 100644
  # Disable AWS/HDFS support by default
  build --define=no_aws_support=true
  build --define=no_hdfs_support=true
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch b/recipes-framework/tensorflow/files/0005-eplace-distutils.sysconfig.get_python_lib-with-sysco.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
rename to recipes-framework/tensorflow/files/0005-eplace-distutils.sysconfig.get_python_lib-with-sysco.patch
index acde266..79950da 100644
--- a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
+++ b/recipes-framework/tensorflow/files/0005-eplace-distutils.sysconfig.get_python_lib-with-sysco.patch
@@ -1,4 +1,4 @@
-From 3b3b8bc65c30fb5ac2a3d5beaa424b27ceb41dc8 Mon Sep 17 00:00:00 2001
+From ed741b43579f3b543832daf66486fb8522dec9c4 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Thu, 29 Feb 2024 23:26:53 -0800
 Subject: [PATCH] eplace distutils.sysconfig.get_python_lib() with
@@ -68,6 +68,3 @@ index 6a4ab4e655f..012c54f7fed 100644
  
  _site_packages_dirs = list(set(_site_packages_dirs))
  
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch b/recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
rename to recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
index e365c27..71b857f 100644
--- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
+++ b/recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
@@ -1,4 +1,4 @@
-From c0fa623063942d53f9f65fb14ada4cbec5cc9b9a Mon Sep 17 00:00:00 2001
+From 0d7249addc24abd868ee9850ef2f4077ccd84c18 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Thu, 1 Dec 2022 23:10:37 +0800
 Subject: [PATCH] hardcode go SDKS
@@ -17,15 +17,15 @@ Upstream-Status: Inappropriate [Yocto specific]
 Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
 ---
  tensorflow/workspace2.bzl               |  1 +
- third_party/0001-hardcode-go-SDKS.patch | 49 +++++++++++++++++++++++++
- 2 files changed, 50 insertions(+)
+ third_party/0001-hardcode-go-SDKS.patch | 47 +++++++++++++++++++++++++
+ 2 files changed, 48 insertions(+)
  create mode 100644 third_party/0001-hardcode-go-SDKS.patch
 
 diff --git a/tensorflow/workspace2.bzl b/tensorflow/workspace2.bzl
-index 1b947d006fe..410a0ba8b54 100644
+index 9e15c75c183..3ef4a544f1a 100644
 --- a/tensorflow/workspace2.bzl
 +++ b/tensorflow/workspace2.bzl
-@@ -883,6 +883,7 @@ def _tf_repositories():
+@@ -805,6 +805,7 @@ def _tf_repositories():
      #   - patch upb so that it's compatible with Bazel 6.0, the latest version of upb doesn't work with the old grpc version.
      tf_http_archive(
          name = "io_bazel_rules_go",
@@ -35,7 +35,7 @@ index 1b947d006fe..410a0ba8b54 100644
      )
 diff --git a/third_party/0001-hardcode-go-SDKS.patch b/third_party/0001-hardcode-go-SDKS.patch
 new file mode 100644
-index 00000000000..b51d7262f4c
+index 00000000000..b66926be35d
 --- /dev/null
 +++ b/third_party/0001-hardcode-go-SDKS.patch
 @@ -0,0 +1,47 @@
@@ -86,6 +86,3 @@ index 00000000000..b51d7262f4c
 +-- 
 +2.32.0
 +
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-build-failure.patch b/recipes-framework/tensorflow/files/0007-fix-build-failure.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-fix-build-failure.patch
rename to recipes-framework/tensorflow/files/0007-fix-build-failure.patch
index 30a0361..74bbdcd 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-failure.patch
+++ b/recipes-framework/tensorflow/files/0007-fix-build-failure.patch
@@ -1,4 +1,4 @@
-From cd26d8228aef93559dc11c7584d8cf8d0a529d1d Mon Sep 17 00:00:00 2001
+From 5e62da8b26fc868d26b6d9dd1561ffdfd99998e9 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 4 Mar 2024 15:07:58 +0800
 Subject: [PATCH] fix build failure
@@ -49,6 +49,3 @@ index 2a49fdfce60..24c2bbf82ef 100644
  ] + tsl_async_value_deps()
  
  package(
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch b/recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch
rename to recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
index a1be846..35fe696 100644
--- a/recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch
+++ b/recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
@@ -1,4 +1,4 @@
-From cd7dc62667df74f9e4c8293dbc087a3ed10c8890 Mon Sep 17 00:00:00 2001
+From f05fc1268ef38b36d35397c46a49b0095270d643 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 4 Mar 2024 17:44:35 +0800
 Subject: [PATCH] support hermetic Python
@@ -58,7 +58,7 @@ index 675709d4314..65b3fd20b4f 100644
      win_def_file = ":pywrap_tensorflow_filtered_def_file",
      deps = [
 diff --git a/tensorflow/tensorflow.bzl b/tensorflow/tensorflow.bzl
-index 45c597b3ef4..d821a60aa5f 100644
+index 51ae807cae7..a2cdbfd73fd 100644
 --- a/tensorflow/tensorflow.bzl
 +++ b/tensorflow/tensorflow.bzl
 @@ -3304,6 +3304,8 @@ def tf_python_pybind_static_deps(testonly = False):
@@ -70,6 +70,3 @@ index 45c597b3ef4..d821a60aa5f 100644
      ]
      static_deps += tsl_async_value_deps()
      static_deps += [] if not testonly else [
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch b/recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch
rename to recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
index 95cc193..91c8dc1 100644
--- a/recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch
+++ b/recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
@@ -1,4 +1,4 @@
-From e060b1fa679f809407e5597bd045105914fb1c05 Mon Sep 17 00:00:00 2001
+From fb71dd4dfd574326c29c5d8ccda5a6e3f73c942b Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Fri, 8 Mar 2024 11:31:26 +0800
 Subject: [PATCH] make hermetic python3 support offline build
@@ -32,7 +32,7 @@ index a697405110e..9b33f0cfdf1 100644
  
 diff --git a/third_party/0001-support-offline-build.patch b/third_party/0001-support-offline-build.patch
 new file mode 100644
-index 00000000000..3804e9c7152
+index 00000000000..c540a27c818
 --- /dev/null
 +++ b/third_party/0001-support-offline-build.patch
 @@ -0,0 +1,50 @@
@@ -86,6 +86,3 @@ index 00000000000..3804e9c7152
 +-- 
 +2.27.0
 +
--- 
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-Fix-build-with-gcc-12.patch b/recipes-framework/tensorflow/files/0010-Fix-build-with-gcc-12.patch
similarity index 92%
rename from recipes-framework/tensorflow/files/0001-Fix-build-with-gcc-12.patch
rename to recipes-framework/tensorflow/files/0010-Fix-build-with-gcc-12.patch
index 7c0385d..d00b0b3 100644
--- a/recipes-framework/tensorflow/files/0001-Fix-build-with-gcc-12.patch
+++ b/recipes-framework/tensorflow/files/0010-Fix-build-with-gcc-12.patch
@@ -1,4 +1,4 @@
-From 150a64dc59ec3a6240fa71fc018f20f1ac0f451d Mon Sep 17 00:00:00 2001
+From e750973d0c3c9e11f4e11fb1b04875a8e052de84 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Fri, 28 Jun 2024 11:27:15 +0800
 Subject: [PATCH] Fix build with gcc-12
@@ -30,6 +30,3 @@ index 4bd4c2960e1..45e73ec3831 100644
 +        ],
 +    }),
  )
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
similarity index 92%
rename from recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
rename to recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
index 5fdc04c..02fd1d0 100644
--- a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,4 +1,4 @@
-From 2e03e5bcd0b1e05f10f7d2d0cfede314fbfa5818 Mon Sep 17 00:00:00 2001
+From e51de51550c25c86dbadd247a0ed37bc56c07c32 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Fri, 1 Mar 2024 00:22:22 -0800
 Subject: [PATCH] add yocto toolchain to support cross compiling
@@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
  3 files changed, 23 insertions(+)
 
 diff --git a/WORKSPACE b/WORKSPACE
-index 720fee74bd2..94095bf1914 100644
+index 9b33f0cfdf1..852ee626ff1 100644
 --- a/WORKSPACE
 +++ b/WORKSPACE
-@@ -40,3 +40,9 @@ tf_workspace1()
+@@ -92,3 +92,9 @@ tf_workspace1()
  load("@//tensorflow:workspace0.bzl", "tf_workspace0")
  
  tf_workspace0()
@@ -27,10 +27,10 @@ index 720fee74bd2..94095bf1914 100644
 +    build_file = "//:BUILD.yocto_compiler",
 +)
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 9e724aff49b..0918af13243 100644
+index 0bf6127ffd1..fc4f0314429 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -352,6 +352,15 @@ config_setting(
+@@ -358,6 +358,15 @@ config_setting(
      visibility = ["//visibility:public"],
  )
  
@@ -72,6 +72,3 @@ index 3ef4a544f1a..9e4c2da9fe2 100644
      # TFLite crossbuild toolchain for embeddeds Linux
      arm_linux_toolchain_configure(
          name = "local_config_embedded_arm",
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/files/0001-disable-avxvnni-for-x86.patch b/recipes-framework/tensorflow/files/0011-disable-avxvnni-for-x86.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-disable-avxvnni-for-x86.patch
rename to recipes-framework/tensorflow/files/0011-disable-avxvnni-for-x86.patch
index 4ef941b..3b376fc 100644
--- a/recipes-framework/tensorflow/files/0001-disable-avxvnni-for-x86.patch
+++ b/recipes-framework/tensorflow/files/0011-disable-avxvnni-for-x86.patch
@@ -1,4 +1,4 @@
-From af2df9de80e402a3632cff8e1d40a467509c7f70 Mon Sep 17 00:00:00 2001
+From 47175b6c700f31a90d49facac3b6df63846a07bb Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 18 Mar 2024 16:24:48 +0800
 Subject: [PATCH] disable avxvnni for x86
@@ -63,6 +63,3 @@ index 00000000000..e07cd9bd930
 +-- 
 +2.27.0
 +
--- 
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
similarity index 85%
rename from recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
rename to recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
index 0502c5b..870c62b 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
+++ b/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
@@ -1,4 +1,4 @@
-From 1af9e2180f680c1b0c94fbeeaee9dc522f353d07 Mon Sep 17 00:00:00 2001
+From f06f0f718d51d3f06f807842c949eb21b7cb57ad Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 17 Aug 2021 16:00:24 +0800
 Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:label_image
@@ -21,10 +21,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 8 insertions(+)
 
 diff --git a/tensorflow/lite/kernels/internal/BUILD b/tensorflow/lite/kernels/internal/BUILD
-index 8c714fc282d..6ea96e4f103 100644
+index 1bbf1516f82..5873cc75471 100644
 --- a/tensorflow/lite/kernels/internal/BUILD
 +++ b/tensorflow/lite/kernels/internal/BUILD
-@@ -112,6 +112,13 @@ config_setting(
+@@ -135,6 +135,13 @@ config_setting(
      },
  )
  
@@ -38,7 +38,7 @@ index 8c714fc282d..6ea96e4f103 100644
  config_setting(
      name = "haswell",
      values = {
-@@ -235,6 +242,7 @@ selects.config_setting_group(
+@@ -273,6 +280,7 @@ selects.config_setting_group(
          ":arm",
          ":arm64-v8a",
          ":armeabi-v7a",
@@ -46,6 +46,3 @@ index 8c714fc282d..6ea96e4f103 100644
          ":armhf",
          ":armv7a",
          ":ios_armv7",
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
similarity index 89%
rename from recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
index 5962c90..b673ed0 100644
--- a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 17e03724c925f8d0b11c8f14699646aa498af798 Mon Sep 17 00:00:00 2001
+From fdfacf235bbe0fe8b1cb0424659ff3d74638bd7f Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:36:00 -0700
 Subject: [PATCH] label_image: tweak default model location
@@ -12,10 +12,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  2 files changed, 6 insertions(+), 6 deletions(-)
 
 diff --git a/tensorflow/examples/label_image/label_image.py b/tensorflow/examples/label_image/label_image.py
-index 3e4bc1ddaab..83558251d77 100644
+index 4b7b79a7291..9bb182c8993 100644
 --- a/tensorflow/examples/label_image/label_image.py
 +++ b/tensorflow/examples/label_image/label_image.py
-@@ -62,10 +62,10 @@ def load_labels(label_file):
+@@ -64,10 +64,10 @@ def load_labels(label_file):
  
  
  if __name__ == "__main__":
@@ -30,10 +30,10 @@ index 3e4bc1ddaab..83558251d77 100644
    input_width = 299
    input_mean = 0
 diff --git a/tensorflow/examples/label_image/main.cc b/tensorflow/examples/label_image/main.cc
-index 13bb5980276..38935a57dd4 100644
+index c96cdc4dd9e..b19d6797146 100644
 --- a/tensorflow/examples/label_image/main.cc
 +++ b/tensorflow/examples/label_image/main.cc
-@@ -279,11 +279,11 @@ int main(int argc, char* argv[]) {
+@@ -282,11 +282,11 @@ int main(int argc, char* argv[]) {
    // They define where the graph and input data is located, and what kind of
    // input the model expects. If you train your own model, or use something
    // other than inception_v3, then you'll need to update these.
@@ -48,6 +48,3 @@ index 13bb5980276..38935a57dd4 100644
    int32_t input_width = 299;
    int32_t input_height = 299;
    float input_mean = 0;
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
index 597021a..e8cee85 100644
--- a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From dd73bef88a23d29299bc6e2f3c892ed81d65a86c Mon Sep 17 00:00:00 2001
+From feb0280937d17aff99d7a4cddbd670213030c015 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 9 Dec 2020 09:53:30 +0800
 Subject: [PATCH] label_image.lite: tweak default model location
@@ -30,6 +30,3 @@ index 1c00edb6558..a5bcf8c64d8 100644
    int number_of_threads = 4;
    int number_of_results = 5;
    int max_profiling_buffer_entries = 1024;
--- 
-2.18.2
-
diff --git a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch b/recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
similarity index 90%
rename from recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
rename to recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
index 7bde666..466336b 100644
--- a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
+++ b/recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
@@ -1,4 +1,4 @@
-From 1455cd4232f382b73cb4ff6dfa6ccc7bd5197428 Mon Sep 17 00:00:00 2001
+From 03ff3a3547ea31c27f6ef5581359bb7c86f09bff Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:39:33 -0700
 Subject: [PATCH] CheckFeatureOrDie: use warning to avoid die
@@ -14,10 +14,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 7 deletions(-)
 
 diff --git a/tensorflow/core/platform/cpu_feature_guard.cc b/tensorflow/core/platform/cpu_feature_guard.cc
-index 11a438925c1..9874ed34793 100644
+index 748dc21090a..ecc9504864d 100644
 --- a/tensorflow/core/platform/cpu_feature_guard.cc
 +++ b/tensorflow/core/platform/cpu_feature_guard.cc
-@@ -36,18 +36,11 @@ void CheckFeatureOrDie(CPUFeature feature, const string& feature_name) {
+@@ -36,18 +36,11 @@ void CheckFeatureOrDie(CPUFeature feature, const std::string& feature_name) {
      const auto error_msg =
          "The TensorFlow library was compiled to use " + feature_name +
          " instructions, but these aren't available on your machine.";
@@ -36,6 +36,3 @@ index 11a438925c1..9874ed34793 100644
    }
  }
  
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
similarity index 89%
rename from recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
rename to recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
index a07777f..1481021 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
@@ -1,4 +1,4 @@
-From 161e6195a47466b354dbb9a095c5aeeba890a81a Mon Sep 17 00:00:00 2001
+From 236ce47a0cf6386ebf025f8a2ef919bf9d2ecebc Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Fri, 1 Mar 2024 00:28:25 -0800
 Subject: [PATCH] support 32 bit x64 and arm for yocto
@@ -9,19 +9,19 @@ Rebase to 2.14.0
 
 Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
 ---
- tensorflow/BUILD                              |  3 --
+ tensorflow/BUILD                              |  3 ---
  tensorflow/workspace2.bzl                     |  2 ++
- .../0001-XNNPACK-support-32-bit-x86.patch     | 29 +++++++++++++++++++
- .../0001-cpuinfo-support-32-bit-x86.patch     | 28 ++++++++++++++++++
- 4 files changed, 59 insertions(+), 3 deletions(-)
+ .../0001-XNNPACK-support-32-bit-x86.patch     | 27 +++++++++++++++++++
+ .../0001-cpuinfo-support-32-bit-x86.patch     | 27 +++++++++++++++++++
+ 4 files changed, 56 insertions(+), 3 deletions(-)
  create mode 100644 third_party/0001-XNNPACK-support-32-bit-x86.patch
  create mode 100644 third_party/0001-cpuinfo-support-32-bit-x86.patch
 
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 0918af13243..3684d9a8757 100644
+index fc4f0314429..1e540ba64b0 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -269,9 +269,6 @@ config_setting(
+@@ -275,9 +275,6 @@ config_setting(
          [],
      ),
      values = dict(
@@ -53,7 +53,7 @@ index 9e4c2da9fe2..0aed90f6203 100644
  
 diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 new file mode 100644
-index 00000000000..9d7e91ff9fe
+index 00000000000..397405a74c1
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 @@ -0,0 +1,27 @@
@@ -86,7 +86,7 @@ index 00000000000..9d7e91ff9fe
 +
 diff --git a/third_party/0001-cpuinfo-support-32-bit-x86.patch b/third_party/0001-cpuinfo-support-32-bit-x86.patch
 new file mode 100644
-index 00000000000..0c83cf01675
+index 00000000000..cd6b27eaea3
 --- /dev/null
 +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
 @@ -0,0 +1,27 @@
@@ -117,6 +117,3 @@ index 00000000000..0c83cf01675
 +-- 
 +2.37.1
 +
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch b/recipes-framework/tensorflow/files/0017-build-api_gen_binary_target-as-host-tools.patch
similarity index 98%
rename from recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch
rename to recipes-framework/tensorflow/files/0017-build-api_gen_binary_target-as-host-tools.patch
index c7f3034..15bf3fd 100644
--- a/recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch
+++ b/recipes-framework/tensorflow/files/0017-build-api_gen_binary_target-as-host-tools.patch
@@ -1,4 +1,4 @@
-From e1471b0dd1eb2c6ee152f749437cab65c2b27ef3 Mon Sep 17 00:00:00 2001
+From 4d84b9cd4580cefcb73d2a68d6ae261eda28a589 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Fri, 1 Mar 2024 00:41:25 -0800
 Subject: [PATCH] build api_gen_binary_target as host tools
@@ -44,6 +44,3 @@ index c41aeecc476..a087557ad0f 100644
          "loading_value": attr.string(mandatory = True),
          "api_packages_path": attr.output(),
      },
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb b/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
index dd3ef0b..2893ee6 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb
@@ -1,17 +1,17 @@
 include tensorflow.inc
 
 SRC_URI += " \
-           file://0001-add-yocto-toolchain-to-support-cross-compiling.patch \
-           file://0001-fix-build-tensorflow-lite-examples-label_image-label.patch \
-           file://0001-label_image-tweak-default-model-location.patch \
-           file://0001-label_image.lite-tweak-default-model-location.patch \
-           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
-           file://BUILD.in \
-           file://BUILD.yocto_compiler \
-           file://cc_config.bzl.tpl \
-           file://yocto_compiler_configure.bzl \
-          "
+    file://0011-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0012-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0013-label_image-tweak-default-model-location.patch \
+    file://0014-label_image.lite-tweak-default-model-location.patch \
+    file://0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0016-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
diff --git a/recipes-framework/tensorflow/tensorflow-native_2.16.1.bb b/recipes-framework/tensorflow/tensorflow-native_2.16.1.bb
index 0fc3b5b..ea1b82d 100644
--- a/recipes-framework/tensorflow/tensorflow-native_2.16.1.bb
+++ b/recipes-framework/tensorflow/tensorflow-native_2.16.1.bb
@@ -1,7 +1,7 @@
 include tensorflow.inc
 
 SRC_URI += " \
-    file://0001-disable-avxvnni-for-x86.patch \
+    file://0011-disable-avxvnni-for-x86.patch \
 "
 
 inherit native
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index 2682b3b..e48808c 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -11,17 +11,17 @@ DEPENDS = " \
 "
 SRCREV = "5bc9d26649cca274750ad3625bd93422617eed4b"
 SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.16;protocol=https \
-           file://0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
-           file://0001-third_party-eigen_archive-workaround-ice-failure-whi.patch \
-           file://0001-drop-bazel_toolchains_repositories-to-support-offlin.patch \
-           file://0001-drop-v2-config.patch \
-           file://0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
-           file://0001-hardcode-go-SDKS.patch \
-           file://0001-fix-build-failure.patch \
-           file://0001-support-hermetic-Python.patch \
-           file://0001-make-hermetic-python3-support-offline-build.patch \
-           file://0001-Fix-build-with-gcc-12.patch \
-          "
+    file://0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
+    file://0002-third_party-eigen_archive-workaround-ice-failure-whi.patch \
+    file://0003-drop-bazel_toolchains_repositories-to-support-offlin.patch \
+    file://0004-drop-v2-config.patch \
+    file://0005-eplace-distutils.sysconfig.get_python_lib-with-sysco.patch \
+    file://0006-hardcode-go-SDKS.patch \
+    file://0007-fix-build-failure.patch \
+    file://0008-support-hermetic-Python.patch \
+    file://0009-make-hermetic-python3-support-offline-build.patch \
+    file://0010-Fix-build-with-gcc-12.patch \
+"
 
 S = "${WORKDIR}/git"
 
diff --git a/recipes-framework/tensorflow/tensorflow_2.16.1.bb b/recipes-framework/tensorflow/tensorflow_2.16.1.bb
index 713c9c0..d2a46a4 100644
--- a/recipes-framework/tensorflow/tensorflow_2.16.1.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.16.1.bb
@@ -1,18 +1,18 @@
 include tensorflow.inc
 
 SRC_URI += " \
-           file://0001-add-yocto-toolchain-to-support-cross-compiling.patch \
-           file://0001-fix-build-tensorflow-lite-examples-label_image-label.patch \
-           file://0001-label_image-tweak-default-model-location.patch \
-           file://0001-label_image.lite-tweak-default-model-location.patch \
-           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
-           file://0001-build-api_gen_binary_target-as-host-tools.patch \
-           file://BUILD.in \
-           file://BUILD.yocto_compiler \
-           file://cc_config.bzl.tpl \
-           file://yocto_compiler_configure.bzl \
-          "
+    file://0011-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0012-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0013-label_image-tweak-default-model-location.patch \
+    file://0014-label_image.lite-tweak-default-model-location.patch \
+    file://0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0016-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0017-build-api_gen_binary_target-as-host-tools.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
-- 
2.48.1


