Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2174AC021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:15:16 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.3184.1739290507964493598
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:15:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Uncdqz0A;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so3228792f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290506; x=1739895306; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLGCAQYFngTyb0kot8GDRQH6Q02ioF+MfdSwN3IvLw8=;
        b=Uncdqz0ATJ14OK6F2ESMoTPhTFQJHSlLVAQ2714xR/DWNarTqXY5vE8DIwWe2zbeDG
         5ibRD5RhtGBZM+8TzExs/LP3ixeOuc7XWNjXqLIgPNTLvOX9z1E0z6gF3rBHIvi0zQSG
         UKTPp6Ch2UH0sIFmCYQALZkZL/aGG4RF9UAKhi4DlE5NqW0P4fmmctarSpOWl3nsJ5jQ
         y8z3CK6QXgxg4T2BBkI35MlmHQF2dbC07Dnv+vpmRp/SZ7XobdRGR42W039J/uiaAZsI
         py2cQHdtMdwWC5QzYPWfC48BMjf4duGVx2yJbUDvvhxETOvfPsGaqpNRnvyPELY9DBS7
         IbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290506; x=1739895306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLGCAQYFngTyb0kot8GDRQH6Q02ioF+MfdSwN3IvLw8=;
        b=q7BKjhF5CbfbQ5m4sNQrDyxxRXakpz4GsSvJwDAZ4alYlafpV7abaHQOkZljHO09tP
         OYsNix2sCAmj1dK9PoWAqA2o5WbE8HxuFqsugGdNEqXyWmA+/uvoMPa29vCpuec0bLVo
         MxsUW6jn29HO6cCedgK12g6PAeIWvGbEYIRLXszfWLFyGWtCHjiEin1XojZ46MmhLj1N
         eFT9Tivl2ABTmNlLWtUQnzQtDI+QYypHl8YdFleiSY5P3aniP24hLzsS4vcIlxhTdS4P
         IgdAggce4ZgX9+J05MnDcvQOuySRMzOeWX0xlv5Hch9EpJQoydzA1KaQP3xF+rItoMW3
         aaGg==
X-Gm-Message-State: AOJu0Yz6Y9MSrywssp2MexEm3O1nnGNrNaT5UZp72u+Qwzxxi9jlIEWk
	Y/Hkwgh7Fr4mXQGWugwF/lVNsVTtvi/IO2fnVLTORFrpqvvUSkAQV3qOtg==
X-Gm-Gg: ASbGncvpZNof9CYrU0Bv4KsE0QVxTSbvmtKD6rkIbYclBG1695/pzqb+rS8lgTv1f36
	pTWXxZ04kxph+7bHc1r0L3TRKnd33rSsSkX+iLw9jnVp4BBV+jMJRNO7K97KNjCawpvPONXajsy
	Yoxojw7Rbin2AfVnaCEtMAe1HObFxfqf1e7zhNJNRw68mckaE/lGOVL4Q1MCKEYgCKzcwoSF+x5
	Nyr+jEGQRrkeUsEOkWQkukVTX2ovo5AIsiW0Gbt7jqF+mc6CO1VQk3ZtUG3pZ7pOTEtGOTJrMgn
	degRDuKzNdnhbnIpTP1Wm8VBK8qXpmcLOYg3LT3KXf3JQXdr
X-Google-Smtp-Source: AGHT+IEn7RGJI6b25FMHtg5gR5HkSefiQTFa8rEa3NSi1zwQULHYlwCkNYJwgGHsiOwp7MsLeai97g==
X-Received: by 2002:a05:6000:402b:b0:385:fa26:f0d9 with SMTP id ffacd0b85a97d-38dc89171f9mr14287972f8f.0.1739290506031;
        Tue, 11 Feb 2025 08:15:06 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd187360asm10392786f8f.43.2025.02.11.08.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:15:05 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][mickledore][PATCH 2/3] tensorflow: refresh and rename the .patch files
Date: Tue, 11 Feb 2025 17:14:58 +0100
Message-ID: <20250211161500.3077588-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211161500.3077588-1-martin.jansa@gmail.com>
References: <20250211161500.3077588-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1062

* use --no-signature as devtool does to avoid unnecessary git signature
  changes
* rename to have increasing numbers in the order how they should
  be applied (so they can be all easily applied with single git
  am call), the only exception is
  0001-fix-python3-include-directory-not-found.patch used only
  in native builds which will be resolved in next commit

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 ...-python3-include-directory-not-found.patch |  5 +---
 .../tensorflow/files/0001-support-musl.patch  |  5 +---
 ...l-to-workaround-bazel-paralle-issue.patch} |  9 +++----
 ..._archive-workaround-ice-failure-whi.patch} | 13 ++++------
 ...ains_repositories-to-support-offlin.patch} |  5 +---
 ...config.patch => 0005-drop-v2-config.patch} |  9 +++----
 ....sysconfig.get_python_lib-with-sysc.patch} | 15 +++++------
 ...SDKS.patch => 0007-hardcode-go-SDKS.patch} | 15 +++++------
 ...=> 0008-Fix-failure-while-gcc-7.5.0.patch} |  5 +---
 ...0009-fix-compile-error-for-gcc-13.1.patch} |  5 +---
 ...e.patch => 0010-fix-compile-failure.patch} |  5 +---
 ...oolchain-to-support-cross-compiling.patch} |  5 +---
 ...low-lite-examples-label_image-label.patch} | 11 +++-----
 ..._image-tweak-default-model-location.patch} |  7 ++---
 ...e.lite-tweak-default-model-location.patch} |  5 +---
 ...atureOrDie-use-warning-to-avoid-die.patch} |  9 +++----
 ...upport-32-bit-x64-and-arm-for-yocto.patch} | 17 +++++-------
 ...ct_host_configuration-false-by-defa.patch} |  9 +++----
 ...-is-deprecated-in-Python-3.10-51776.patch} |  5 +---
 .../tensorflow/tensorflow-lite_2.12.0.bb      | 26 +++++++++----------
 recipes-framework/tensorflow/tensorflow.inc   | 23 ++++++++--------
 .../tensorflow/tensorflow_2.12.0.bb           | 26 +++++++++----------
 22 files changed, 88 insertions(+), 146 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch => 0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch} (79%)
 rename recipes-framework/tensorflow/files/{0001-third_party-eigen_archive-workaround-ice-failure-whi.patch => 0003-third_party-eigen_archive-workaround-ice-failure-whi.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-drop-bazel_toolchains_repositories-to-support-offlin.patch => 0004-drop-bazel_toolchains_repositories-to-support-offlin.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-drop-v2-config.patch => 0005-drop-v2-config.patch} (79%)
 rename recipes-framework/tensorflow/files/{0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch => 0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch} (90%)
 rename recipes-framework/tensorflow/files/{0001-hardcode-go-SDKS.patch => 0007-hardcode-go-SDKS.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-Fix-failure-while-gcc-7.5.0.patch => 0008-Fix-failure-while-gcc-7.5.0.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-fix-compile-error-for-gcc-13.1.patch => 0009-fix-compile-error-for-gcc-13.1.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-fix-compile-failure.patch => 0010-fix-compile-failure.patch} (93%)
 rename recipes-framework/tensorflow/files/{0001-add-yocto-toolchain-to-support-cross-compiling.patch => 0011-add-yocto-toolchain-to-support-cross-compiling.patch} (97%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-tensorflow-lite-examples-label_image-label.patch => 0012-fix-build-tensorflow-lite-examples-label_image-label.patch} (85%)
 rename recipes-framework/tensorflow/files/{0001-label_image-tweak-default-model-location.patch => 0013-label_image-tweak-default-model-location.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-label_image.lite-tweak-default-model-location.patch => 0014-label_image.lite-tweak-default-model-location.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch => 0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch} (90%)
 rename recipes-framework/tensorflow/files/{0001-support-32-bit-x64-and-arm-for-yocto.patch => 0016-support-32-bit-x64-and-arm-for-yocto.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-Revert-set-distinct_host_configuration-false-by-defa.patch => 0017-Revert-set-distinct_host_configuration-false-by-defa.patch} (81%)
 rename recipes-framework/tensorflow/files/{0001-distutils-is-deprecated-in-Python-3.10-cross.patch => 0018-distutils-is-deprecated-in-Python-3.10-51776.patch} (96%)

diff --git a/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch b/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch
index fd1988e..4e9b9c5 100644
--- a/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch
+++ b/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch
@@ -1,4 +1,4 @@
-From 2b6f5a64686ec78b4d1649ba401d06ae44b5a2d5 Mon Sep 17 00:00:00 2001
+From b0df1f017ab730b150dcfe71084620e4edf44504 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 14 Nov 2022 15:27:41 +0800
 Subject: [PATCH] fix python3 include directory not found
@@ -41,6 +41,3 @@ index 300cbfb6c71..14248233dc1 100644
          ],
          error_msg = "Problem getting python include path.",
          error_details = ("Is the Python binary path set up right? " +
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-support-musl.patch b/recipes-framework/tensorflow/files/0001-support-musl.patch
index 574b810..62dabb1 100644
--- a/recipes-framework/tensorflow/files/0001-support-musl.patch
+++ b/recipes-framework/tensorflow/files/0001-support-musl.patch
@@ -1,4 +1,4 @@
-From cc3c636c06bbc6ca6e81a547c9a740c4ead21f61 Mon Sep 17 00:00:00 2001
+From 9e8fe4970d6c93afda28a97b42fbdfc2b6ca2f5a Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Wed, 30 Nov 2022 22:20:52 -0800
 Subject: [PATCH] support musl
@@ -45,6 +45,3 @@ index 1b62651b1be..4dc38cba6bd 100644
  #define TF_GENERATE_STACKTRACE
  #endif
  
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch b/recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
rename to recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
index 8a17700..230b4f9 100644
--- a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
+++ b/recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
@@ -1,4 +1,4 @@
-From bbdf1bbca17f8bce98e32b25aa9bfadc8f465f24 Mon Sep 17 00:00:00 2001
+From 96107c017d401160526608f58b8f1428462f7060 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 15 May 2022 23:59:17 -0700
 Subject: [PATCH] use local bazel to workaround bazel paralle issue
@@ -12,10 +12,10 @@ Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/configure.py b/configure.py
-index dae3dce89d3..979f00f3633 100644
+index 6abde63a28a..85c6a04319a 100644
 --- a/configure.py
 +++ b/configure.py
-@@ -475,7 +475,7 @@ def check_bazel_version(min_version, max_version):
+@@ -420,7 +420,7 @@ def retrieve_bazel_version():
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
diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/files/0003-third_party-eigen_archive-workaround-ice-failure-whi.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
rename to recipes-framework/tensorflow/files/0003-third_party-eigen_archive-workaround-ice-failure-whi.patch
index 2056c20..272ff10 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0003-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -1,4 +1,4 @@
-From 385074d9300c18293a42c9d8ca9fb12cbffccb80 Mon Sep 17 00:00:00 2001
+From 25cddd0178dad6b208eb13cef8d4db18700edd4e Mon Sep 17 00:00:00 2001
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
+index 67e625d6842..5f45e060c2f 100644
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
diff --git a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch b/recipes-framework/tensorflow/files/0004-drop-bazel_toolchains_repositories-to-support-offlin.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
rename to recipes-framework/tensorflow/files/0004-drop-bazel_toolchains_repositories-to-support-offlin.patch
index 730f2c2..4567db0 100644
--- a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
+++ b/recipes-framework/tensorflow/files/0004-drop-bazel_toolchains_repositories-to-support-offlin.patch
@@ -1,4 +1,4 @@
-From 6bb9c02aae20996a6e4edd8fe743a90ce8d677aa Mon Sep 17 00:00:00 2001
+From eb5149642a766dc7938acc9c6a7357f309940317 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 18 Sep 2022 23:52:34 -0700
 Subject: [PATCH] drop bazel_toolchains_repositories to support offline build
@@ -34,6 +34,3 @@ index c3c081b19ef..445de71bb13 100644
      # Apple rules for Bazel. https://github.com/bazelbuild/rules_apple.
      # Note: We add this to fix Kokoro builds.
      # The rules below call into `rules_proto` but the hash has changed and
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch b/recipes-framework/tensorflow/files/0005-drop-v2-config.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-drop-v2-config.patch
rename to recipes-framework/tensorflow/files/0005-drop-v2-config.patch
index ff74a3c..45c4a0f 100644
--- a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch
+++ b/recipes-framework/tensorflow/files/0005-drop-v2-config.patch
@@ -1,4 +1,4 @@
-From 104224b8b30f74dabed893aa057f400ad7cd2695 Mon Sep 17 00:00:00 2001
+From f1384b8e665960cea56ee6be801a0f682c90ca4e Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:10:55 -0700
 Subject: [PATCH] drop v2 config
@@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index b6a72c1e5d3..a71ade6950f 100644
+index a2ff5848fcf..2ec8746e5c7 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -138,9 +138,6 @@ build --define=with_xla_support=true
+@@ -135,9 +135,6 @@ build --define=with_xla_support=true
  # TODO(mihaimaruseac): Document this option or remove if no longer needed
  build --config=short_logs
  
@@ -24,6 +24,3 @@ index b6a72c1e5d3..a71ade6950f 100644
  # Disable AWS/HDFS support by default
  build --define=no_aws_support=true
  build --define=no_hdfs_support=true
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch b/recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
similarity index 90%
rename from recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
rename to recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
index 9ce46ee..3a0bebd 100644
--- a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
+++ b/recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
@@ -1,7 +1,7 @@
-From 5dc007d64a9928d379851a6524a376bfdb819c6d Mon Sep 17 00:00:00 2001
+From 0e0f64ba41170ef9b603bb1e4e8fde9e5f2d8c6f Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:17:02 -0700
-Subject: [PATCH] Replace distutils.sysconfig.get_python_lib() with 
+Subject: [PATCH] Replace distutils.sysconfig.get_python_lib() with
  sysconfig.get_path('purelib') - python 3.10 support
 
 This is part of the effort for 51776 to get python 3.10 support.
@@ -21,7 +21,7 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  2 files changed, 4 insertions(+), 6 deletions(-)
 
 diff --git a/tensorflow/api_template.__init__.py b/tensorflow/api_template.__init__.py
-index 1ed97439b06..58904070e62 100644
+index cd3cbac7a96..217fb15514f 100644
 --- a/tensorflow/api_template.__init__.py
 +++ b/tensorflow/api_template.__init__.py
 @@ -26,7 +26,7 @@ only a placeholder to enable test cases to run. The TensorFlow build replaces
@@ -33,7 +33,7 @@ index 1ed97439b06..58904070e62 100644
  import inspect as _inspect
  import logging as _logging
  import os as _os
-@@ -122,8 +122,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
+@@ -115,8 +115,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
  if 'getsitepackages' in dir(_site):
    _site_packages_dirs += _site.getsitepackages()
  
@@ -44,7 +44,7 @@ index 1ed97439b06..58904070e62 100644
  _site_packages_dirs = list(set(_site_packages_dirs))
  
 diff --git a/tensorflow/api_template_v1.__init__.py b/tensorflow/api_template_v1.__init__.py
-index 87d9bc1f204..70e0fd70c34 100644
+index 6c42fea562f..1cee4e6bc29 100644
 --- a/tensorflow/api_template_v1.__init__.py
 +++ b/tensorflow/api_template_v1.__init__.py
 @@ -14,7 +14,7 @@
@@ -56,7 +56,7 @@ index 87d9bc1f204..70e0fd70c34 100644
  import inspect as _inspect
  import os as _os
  import site as _site
-@@ -163,8 +163,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
+@@ -156,8 +156,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
  if 'getsitepackages' in dir(_site):
    _site_packages_dirs += _site.getsitepackages()
  
@@ -66,6 +66,3 @@ index 87d9bc1f204..70e0fd70c34 100644
  
  _site_packages_dirs = list(set(_site_packages_dirs))
  
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch b/recipes-framework/tensorflow/files/0007-hardcode-go-SDKS.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
rename to recipes-framework/tensorflow/files/0007-hardcode-go-SDKS.patch
index e365c27..085ac99 100644
--- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
+++ b/recipes-framework/tensorflow/files/0007-hardcode-go-SDKS.patch
@@ -1,4 +1,4 @@
-From c0fa623063942d53f9f65fb14ada4cbec5cc9b9a Mon Sep 17 00:00:00 2001
+From 99b30ec0c6f344208ab3f674e542e90a1b487059 Mon Sep 17 00:00:00 2001
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
+index 1261273bc92..11681ff4e29 100644
 --- a/tensorflow/workspace2.bzl
 +++ b/tensorflow/workspace2.bzl
-@@ -883,6 +883,7 @@ def _tf_repositories():
+@@ -895,6 +895,7 @@ def _tf_repositories():
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
diff --git a/recipes-framework/tensorflow/files/0001-Fix-failure-while-gcc-7.5.0.patch b/recipes-framework/tensorflow/files/0008-Fix-failure-while-gcc-7.5.0.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-Fix-failure-while-gcc-7.5.0.patch
rename to recipes-framework/tensorflow/files/0008-Fix-failure-while-gcc-7.5.0.patch
index 514779d..9e09bb4 100644
--- a/recipes-framework/tensorflow/files/0001-Fix-failure-while-gcc-7.5.0.patch
+++ b/recipes-framework/tensorflow/files/0008-Fix-failure-while-gcc-7.5.0.patch
@@ -1,4 +1,4 @@
-From d844e0ed4cab7ca4156927a029df36279e119edc Mon Sep 17 00:00:00 2001
+From e87e5a405cc01b65cdf367de562035922a21c058 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 27 Mar 2023 12:33:25 +0800
 Subject: [PATCH] Fix failure while gcc <= 7.5.0
@@ -29,6 +29,3 @@ index fe1b205ce1d..09db4f83531 100644
    if (ec) {
      return absl::InternalError(absl::StrFormat(
          "Unable to open file: %s, error: %s", dump_file_path, ec.message()));
--- 
-2.17.1
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-compile-error-for-gcc-13.1.patch b/recipes-framework/tensorflow/files/0009-fix-compile-error-for-gcc-13.1.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-fix-compile-error-for-gcc-13.1.patch
rename to recipes-framework/tensorflow/files/0009-fix-compile-error-for-gcc-13.1.patch
index 31bc523..69bb1c9 100644
--- a/recipes-framework/tensorflow/files/0001-fix-compile-error-for-gcc-13.1.patch
+++ b/recipes-framework/tensorflow/files/0009-fix-compile-error-for-gcc-13.1.patch
@@ -1,4 +1,4 @@
-From 9dae6d9e9555787bb097e50dc1449f787003de00 Mon Sep 17 00:00:00 2001
+From b6d8dea6d8718b270dd0e2bd25f8e4612ee34e62 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 28 Jun 2023 14:44:50 +0800
 Subject: [PATCH] fix compile error for gcc 13.1
@@ -43,6 +43,3 @@ index f894c5916d5..4e509cea05c 100644
  #include "tensorflow/tsl/platform/stringpiece.h"
  
  // A Cache is an interface that maps keys to values.  It has internal
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-compile-failure.patch b/recipes-framework/tensorflow/files/0010-fix-compile-failure.patch
similarity index 93%
rename from recipes-framework/tensorflow/files/0001-fix-compile-failure.patch
rename to recipes-framework/tensorflow/files/0010-fix-compile-failure.patch
index 3b8775f..f509e0b 100644
--- a/recipes-framework/tensorflow/files/0001-fix-compile-failure.patch
+++ b/recipes-framework/tensorflow/files/0010-fix-compile-failure.patch
@@ -1,4 +1,4 @@
-From b8abee60ed3c49d496eb1427f36ec6c23e768ff6 Mon Sep 17 00:00:00 2001
+From 111aba5fda30dc301bcb72e494277d45b3337518 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 12 Sep 2023 14:23:26 +0800
 Subject: [PATCH] fix compile failure
@@ -28,6 +28,3 @@ index d8685c4db26..e6d36a08d48 100644
  
  // If we're on gcc 4.8 or older, there's a known bug that prevents the use of
  // intrinsics when the architecture is not defined in the flags. See
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
rename to recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
index f202e1d..aea4618 100644
--- a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,4 +1,4 @@
-From c7a3e265041f9fd0d86d473338122a597d5234c5 Mon Sep 17 00:00:00 2001
+From cc522bdebaa28115662d38b655f3b9e8eee28026 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Sun, 12 Mar 2023 23:38:01 -0700
 Subject: [PATCH] add yocto toolchain to support cross compiling
@@ -72,6 +72,3 @@ index 11681ff4e29..b8fa81642bd 100644
      # TFLite crossbuild toolchain for embeddeds Linux
      arm_linux_toolchain_configure(
          name = "local_config_embedded_arm",
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
similarity index 85%
rename from recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
rename to recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
index 0502c5b..f9d16c3 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
+++ b/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
@@ -1,4 +1,4 @@
-From 1af9e2180f680c1b0c94fbeeaee9dc522f353d07 Mon Sep 17 00:00:00 2001
+From 0dd71f76f8384c8dec85c31f94df6bdaa9ee665e Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 17 Aug 2021 16:00:24 +0800
 Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:label_image
@@ -21,10 +21,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 8 insertions(+)
 
 diff --git a/tensorflow/lite/kernels/internal/BUILD b/tensorflow/lite/kernels/internal/BUILD
-index 8c714fc282d..6ea96e4f103 100644
+index a830c5df2e2..bbfb07bf21f 100644
 --- a/tensorflow/lite/kernels/internal/BUILD
 +++ b/tensorflow/lite/kernels/internal/BUILD
-@@ -112,6 +112,13 @@ config_setting(
+@@ -116,6 +116,13 @@ config_setting(
      },
  )
  
@@ -38,7 +38,7 @@ index 8c714fc282d..6ea96e4f103 100644
  config_setting(
      name = "haswell",
      values = {
-@@ -235,6 +242,7 @@ selects.config_setting_group(
+@@ -246,6 +253,7 @@ selects.config_setting_group(
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
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
index 5962c90..3785f77 100644
--- a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 17e03724c925f8d0b11c8f14699646aa498af798 Mon Sep 17 00:00:00 2001
+From 4b97089f7c18df8fef47cb4d825d96aa07316d35 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:36:00 -0700
 Subject: [PATCH] label_image: tweak default model location
@@ -30,7 +30,7 @@ index 3e4bc1ddaab..83558251d77 100644
    input_width = 299
    input_mean = 0
 diff --git a/tensorflow/examples/label_image/main.cc b/tensorflow/examples/label_image/main.cc
-index 13bb5980276..38935a57dd4 100644
+index 3a5d44eb669..fcf8dcb7644 100644
 --- a/tensorflow/examples/label_image/main.cc
 +++ b/tensorflow/examples/label_image/main.cc
 @@ -279,11 +279,11 @@ int main(int argc, char* argv[]) {
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
index 597021a..b870e59 100644
--- a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From dd73bef88a23d29299bc6e2f3c892ed81d65a86c Mon Sep 17 00:00:00 2001
+From 5e6734503d8d5bc56dfe47dd7d5d0ee50aa4832c Mon Sep 17 00:00:00 2001
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
index 7bde666..c826c1e 100644
--- a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
+++ b/recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
@@ -1,4 +1,4 @@
-From 1455cd4232f382b73cb4ff6dfa6ccc7bd5197428 Mon Sep 17 00:00:00 2001
+From 6c0e8215f1e476862f42b61b7ee6029d8ba397a4 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:39:33 -0700
 Subject: [PATCH] CheckFeatureOrDie: use warning to avoid die
@@ -14,10 +14,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 7 deletions(-)
 
 diff --git a/tensorflow/core/platform/cpu_feature_guard.cc b/tensorflow/core/platform/cpu_feature_guard.cc
-index 11a438925c1..9874ed34793 100644
+index 245f3263a9e..a642056fb02 100644
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
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
rename to recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
index 22bd6c1..cca7899 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
@@ -1,4 +1,4 @@
-From 66e10e0d0999493509d0946a40ce2e8bf8b50ff4 Mon Sep 17 00:00:00 2001
+From 480271c4007031090043db9534a63acd4db997e9 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Sun, 12 Mar 2023 23:48:00 -0700
 Subject: [PATCH] support 32 bit x64 and arm for yocto
@@ -9,11 +9,11 @@ Rebase to 2.12.0
 
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
 
@@ -53,7 +53,7 @@ index b8fa81642bd..2c86e3c8639 100644
  
 diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 new file mode 100644
-index 00000000000..2141c37236b
+index 00000000000..e2c053e6f8c
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 @@ -0,0 +1,27 @@
@@ -86,7 +86,7 @@ index 00000000000..2141c37236b
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
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch b/recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch
similarity index 81%
rename from recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch
rename to recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch
index adc4661..a6d4131 100644
--- a/recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch
+++ b/recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch
@@ -1,4 +1,4 @@
-From 0076b9b52016c7a22c4418d25945ebc893a67b12 Mon Sep 17 00:00:00 2001
+From c40feb600abaeba1de7e736a4a4d0de71d798a44 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:53:00 -0700
 Subject: [PATCH] Revert "set --distinct_host_configuration=false by default
@@ -16,10 +16,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 2 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index a71ade6950f..9f7627bb7c6 100644
+index 2ec8746e5c7..e6db7e4c586 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -355,8 +355,6 @@ build:windows --features=compiler_param_file
+@@ -397,8 +397,6 @@ build:windows --features=compiler_param_file
  
  # On windows, we never cross compile
  build:windows --distinct_host_configuration=false
@@ -28,6 +28,3 @@ index a71ade6950f..9f7627bb7c6 100644
  
  # Do not risk cache corruption. See:
  # https://github.com/bazelbuild/bazel/issues/3360
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch b/recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch
rename to recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch
index e79fc24..a1b6a6d 100644
--- a/recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch
+++ b/recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch
@@ -1,4 +1,4 @@
-From 79bd5c1e597ffd877822297a48d9eaa9ca3a317d Mon Sep 17 00:00:00 2001
+From 85fada9708cd38c278cc4237feb90d0c94425758 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 01:18:43 -0700
 Subject: [PATCH] `distutils` is deprecated in Python 3.10 #51776
@@ -47,6 +47,3 @@ index 300cbfb6c71..e57af9f9dc9 100644
  
  def _get_python_import_lib_name(repository_ctx, python_bin):
      """Get Python import library name (pythonXY.lib) on Windows."""
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
index e76a09b..b85000f 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
@@ -1,19 +1,19 @@
 include tensorflow.inc
 
 SRC_URI += " \
-           file://0001-add-yocto-toolchain-to-support-cross-compiling.patch \
-           file://0001-fix-build-tensorflow-lite-examples-label_image-label.patch \
-           file://0001-label_image-tweak-default-model-location.patch \
-           file://0001-label_image.lite-tweak-default-model-location.patch \
-           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
-           file://0001-Revert-set-distinct_host_configuration-false-by-defa.patch \
-           file://0001-distutils-is-deprecated-in-Python-3.10-cross.patch \
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
+    file://0017-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0018-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 SRC_URI:append:arm = " \
     file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
 "
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index 0d1d5aa..c32b902 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -5,18 +5,17 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=4158a261ca7f2525513e31ba9c50ae98"
 DEPENDS = "bazel-native protobuf-native util-linux-native protobuf"
 SRCREV = "0db597d0d758aba578783b5bf46c889700a45085"
 SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.12;protocol=https \
-           file://0001-support-musl.patch \
-           file://0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
-           file://0001-third_party-eigen_archive-workaround-ice-failure-whi.patch \
-           file://0001-drop-bazel_toolchains_repositories-to-support-offlin.patch \
-           file://0001-drop-v2-config.patch \
-           file://0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
-           file://0001-hardcode-go-SDKS.patch \
-           file://0001-Fix-failure-while-gcc-7.5.0.patch \
-           file://0001-fix-compile-error-for-gcc-13.1.patch \
-           file://0001-fix-compile-failure.patch \
-          "
-
+    file://0001-support-musl.patch \
+    file://0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
+    file://0003-third_party-eigen_archive-workaround-ice-failure-whi.patch \
+    file://0004-drop-bazel_toolchains_repositories-to-support-offlin.patch \
+    file://0005-drop-v2-config.patch \
+    file://0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
+    file://0007-hardcode-go-SDKS.patch \
+    file://0008-Fix-failure-while-gcc-7.5.0.patch \
+    file://0009-fix-compile-error-for-gcc-13.1.patch \
+    file://0010-fix-compile-failure.patch \
+"
 S = "${WORKDIR}/git"
 
 DEPENDS += " \
diff --git a/recipes-framework/tensorflow/tensorflow_2.12.0.bb b/recipes-framework/tensorflow/tensorflow_2.12.0.bb
index 19c5b99..e045a7d 100644
--- a/recipes-framework/tensorflow/tensorflow_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.12.0.bb
@@ -1,19 +1,19 @@
 include tensorflow.inc
 
 SRC_URI += " \
-           file://0001-add-yocto-toolchain-to-support-cross-compiling.patch \
-           file://0001-fix-build-tensorflow-lite-examples-label_image-label.patch \
-           file://0001-label_image-tweak-default-model-location.patch \
-           file://0001-label_image.lite-tweak-default-model-location.patch \
-           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
-           file://0001-Revert-set-distinct_host_configuration-false-by-defa.patch \
-           file://0001-distutils-is-deprecated-in-Python-3.10-cross.patch \
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
+    file://0017-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0018-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
-- 
2.48.1


