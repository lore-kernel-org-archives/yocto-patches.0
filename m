Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEAC0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:14:46 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.3170.1739290479107587151
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:14:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NqZxZL2a;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43957634473so1531815e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290477; x=1739895277; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNhBzy1GxBN7UWB8o85PdIksCMkGqKlcRAoEskpGFBw=;
        b=NqZxZL2aGKVM7cm9AMLM+9FE4RQutJtMMOV32uy2fNhM7h/CblbYfUHY0AXNctrSVu
         iAlgCTOwund8UelKHISLsEJKtq7LsLtqycvU0FIe9C8V40+NoI3VPdAEXFO7nRIa1qJX
         glqLunZhAhV7YLUcxeZ1AYxHA0H/cwr9KqvHWb25fhKTJKcHNaQOLu6aWCfhY/7TFZzL
         WeHJLNWO1Ux48yRpzVDs6GLjsnTgzgt2LxjpcooAFN8UY3nXm5ubuZ/DRRQraO7l4eek
         McSSGacHh4iii73kNMTz0Qg5jO3RvouUkin1Jiy/oFY/JZwTokqN3JQ+xBICeMGihOgZ
         xCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290477; x=1739895277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNhBzy1GxBN7UWB8o85PdIksCMkGqKlcRAoEskpGFBw=;
        b=awhH8MXsAW7b9kuDMjyNalaKNwLqOOOrXBg0fjsd32FE31e1t0TtxtFSX5w+TN/9ls
         WxH9yI7VvDf8JBu2IUAL3xvVXv0gXlRM870XmvS1eisNh3jbucMvhSb6Spgn/g6g43IY
         DAs8UylrcfqF6K16WvPScP0zRf3pXmEUWSxUEqUFBiGfVx2EzHqidGJt94Zdl5u8VF72
         kR5fWl2C6Mu7iZfxML9godeZaVblcTEnp0P+HoI0K7PY3MYFMIHP4VoZ8rrEMtWNSGWw
         tJaGxxVES9cDYNb0kexHsVoVC4JUWUSgJhSFzjZg1MR8Ox1jJTw8roNXaSIW5EGHXIzd
         CFkw==
X-Gm-Message-State: AOJu0YzlRNUIe77u/UMOUhH/f/8mPy5qt0+vmHJ5RKQ4ITDZQYi75GnD
	pqayQ4mfeHOWnvwWe+3NjSLMg2HZ7q+5YqqW7MQPcJokiHnL7QIqUKnR3w==
X-Gm-Gg: ASbGncsLaWWfT7iqutF9hYG5L8P7u9tFsuDzBLzzfkLdjlWINvoOnXkpFC9obyGtR0h
	w9C35uU/D6NJO88XYkEveyrx9+ILMFJ6cZu8dY4gh8yeKTLg8aNCm+uLIGzi+NLSXgVJvrLyWoA
	f1UpWHWTdcTxEswgww7TJwM27+flCQBg7nWml86z0g6syhwOik0OZpYzYN//fkkoVYXmhVWETSh
	l7bQ1mbV+XOTHgvjDXB/Z+WhzYbw/bZCpubxbDlS6082NxQX2T92nPvVrLEL75hm2xVhY2uZOks
	6dRB3m8bY0vVDe0ANNTMQnZXBXLq9x8UxOu0UoZnvUJjvLNu
X-Google-Smtp-Source: AGHT+IGaLomqT5ys5JnBUNjMJFEFQcObyGFlm1CqkWBoWez4HnPhZFpkhoUyW9PDrs5zRhJnC4mN6g==
X-Received: by 2002:a5d:64ed:0:b0:38d:d8b2:cf0a with SMTP id ffacd0b85a97d-38dd8b2d311mr10131410f8f.31.1739290476783;
        Tue, 11 Feb 2025 08:14:36 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4394354d255sm69830305e9.25.2025.02.11.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:14:36 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][master][PATCH 2/2] tensorflow: refresh and rename the .patch files
Date: Tue, 11 Feb 2025 17:14:27 +0100
Message-ID: <20250211161427.3067063-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211161427.3067063-1-martin.jansa@gmail.com>
References: <20250211161427.3067063-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:14:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1058

* use --no-signature as devtool does to avoid unnecessary git signature
  changes
* rename to have increasing numbers in the order how they should
  be applied (so they can be all easily applied with single git
  am call), the only exception is
  0013-disable-avxvnni-and-avx512fp16-for-x86.patch
  used only in native builds

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 ...el-to-workaround-bazel-paralle-issue.patch |  9 +++----
 ..._archive-workaround-ice-failure-whi.patch} | 11 +++-----
 ...ains_repositories-to-support-offlin.patch} |  5 +---
 ...config.patch => 0004-drop-v2-config.patch} |  9 +++----
 ....sysconfig.get_python_lib-with-sysc.patch} | 12 ++++-----
 ...SDKS.patch => 0006-hardcode-go-SDKS.patch} | 15 +++++------
 ...ure.patch => 0007-fix-build-failure.patch} |  9 +++----
 ...tch => 0008-support-hermetic-Python.patch} | 19 ++++++--------
 ...metic-python3-support-offline-build.patch} | 11 +++-----
 ...patch => 0010-Fix-build-with-gcc-12.patch} |  5 +---
 ...atch => 0011-fix-patchelf-not-found.patch} |  5 +---
 ...x-llvm-project-timeout-occasionally.patch} |  5 +---
 ...oolchain-to-support-cross-compiling.patch} | 17 +++++-------
 ...able-avxvnni-and-avx512fp16-for-x86.patch} |  5 +---
 ...low-lite-examples-label_image-label.patch} | 11 +++-----
 ..._image-tweak-default-model-location.patch} | 13 ++++------
 ...e.lite-tweak-default-model-location.patch} |  9 +++----
 ...atureOrDie-use-warning-to-avoid-die.patch} |  9 +++----
 ...upport-32-bit-x64-and-arm-for-yocto.patch} | 17 +++++-------
 ...api_gen_binary_target-as-host-tools.patch} |  9 +++----
 .../tensorflow/tensorflow-lite_2.17.0.bb      | 22 ++++++++--------
 .../tensorflow/tensorflow-native_2.17.0.bb    |  2 +-
 recipes-framework/tensorflow/tensorflow.inc   | 26 +++++++++----------
 .../tensorflow/tensorflow_2.17.0.bb           | 24 ++++++++---------
 24 files changed, 110 insertions(+), 169 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-third_party-eigen_archive-workaround-ice-failure-whi.patch => 0002-third_party-eigen_archive-workaround-ice-failure-whi.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-drop-bazel_toolchains_repositories-to-support-offlin.patch => 0003-drop-bazel_toolchains_repositories-to-support-offlin.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-drop-v2-config.patch => 0004-drop-v2-config.patch} (79%)
 rename recipes-framework/tensorflow/files/{0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch => 0005-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch} (88%)
 rename recipes-framework/tensorflow/files/{0001-hardcode-go-SDKS.patch => 0006-hardcode-go-SDKS.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-failure.patch => 0007-fix-build-failure.patch} (92%)
 rename recipes-framework/tensorflow/files/{0001-support-hermetic-Python.patch => 0008-support-hermetic-Python.patch} (86%)
 rename recipes-framework/tensorflow/files/{0001-make-hermetic-python3-support-offline-build.patch => 0009-make-hermetic-python3-support-offline-build.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-Fix-build-with-gcc-12.patch => 0010-Fix-build-with-gcc-12.patch} (92%)
 rename recipes-framework/tensorflow/files/{0001-fix-patchelf-not-found.patch => 0011-fix-patchelf-not-found.patch} (92%)
 rename recipes-framework/tensorflow/files/{0001-fix-llvm-project-timeout-occasionally.patch => 0012-fix-llvm-project-timeout-occasionally.patch} (98%)
 rename recipes-framework/tensorflow/files/{0001-add-yocto-toolchain-to-support-cross-compiling.patch => 0013-add-yocto-toolchain-to-support-cross-compiling.patch} (88%)
 rename recipes-framework/tensorflow/files/{0001-disable-avxvnni-and-avx512fp16-for-x86.patch => 0013-disable-avxvnni-and-avx512fp16-for-x86.patch} (97%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-tensorflow-lite-examples-label_image-label.patch => 0014-fix-build-tensorflow-lite-examples-label_image-label.patch} (85%)
 rename recipes-framework/tensorflow/files/{0001-label_image-tweak-default-model-location.patch => 0015-label_image-tweak-default-model-location.patch} (89%)
 rename recipes-framework/tensorflow/files/{0001-label_image.lite-tweak-default-model-location.patch => 0016-label_image.lite-tweak-default-model-location.patch} (88%)
 rename recipes-framework/tensorflow/files/{0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch => 0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch} (90%)
 rename recipes-framework/tensorflow/files/{0001-support-32-bit-x64-and-arm-for-yocto.patch => 0018-support-32-bit-x64-and-arm-for-yocto.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-build-api_gen_binary_target-as-host-tools.patch => 0019-build-api_gen_binary_target-as-host-tools.patch} (96%)

diff --git a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch b/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
index 8a17700..647267e 100644
--- a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
+++ b/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
@@ -1,4 +1,4 @@
-From bbdf1bbca17f8bce98e32b25aa9bfadc8f465f24 Mon Sep 17 00:00:00 2001
+From ed14f6a3bb1f9ca907e4b7df4b49a94d8d028903 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 15 May 2022 23:59:17 -0700
 Subject: [PATCH] use local bazel to workaround bazel paralle issue
@@ -12,10 +12,10 @@ Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/configure.py b/configure.py
-index dae3dce89d3..979f00f3633 100644
+index 0081eeabf66..0cd34f56e66 100644
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
index 572e708..d7db5d0 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0002-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -1,4 +1,4 @@
-From fa4e3fc3673f19f5b5ea279807078a9c0ec3607f Mon Sep 17 00:00:00 2001
+From c81fdf3c6678d922e225659a6ad470b349cf3bae Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 23:15:47 -0700
 Subject: [PATCH] third_party/eigen_archive:workaround ice failure while
@@ -14,14 +14,14 @@ Upstream-Status: Inappropriate [wr-installer specific]
 
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
- ...ailure-while-building-from-source-wi.patch | 70 +++++++++++++++++++
+ ...ailure-while-building-from-source-wi.patch | 68 +++++++++++++++++++
  third_party/eigen3/workspace.bzl              |  1 +
- 2 files changed, 71 insertions(+)
+ 2 files changed, 69 insertions(+)
  create mode 100644 third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 
 diff --git a/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 new file mode 100644
-index 00000000000..523a32d78f7
+index 00000000000..82ef62a0d9a
 --- /dev/null
 +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-from-source-wi.patch
 @@ -0,0 +1,68 @@
@@ -105,6 +105,3 @@ index 36c73565a5e..0c34110cf1b 100644
          sha256 = EIGEN_SHA256,
          strip_prefix = "eigen-{commit}".format(commit = EIGEN_COMMIT),
          urls = tf_mirror_urls("https://gitlab.com/libeigen/eigen/-/archive/{commit}/eigen-{commit}.tar.gz".format(commit = EIGEN_COMMIT)),
--- 
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch b/recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
rename to recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
index 6f39473..6674be1 100644
--- a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
+++ b/recipes-framework/tensorflow/files/0003-drop-bazel_toolchains_repositories-to-support-offlin.patch
@@ -1,4 +1,4 @@
-From f1169a95cc393404648f171f8edc0788ec2be754 Mon Sep 17 00:00:00 2001
+From 47247f1d1908f6bd1d85d0866a9025dfe609019b Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Thu, 22 Aug 2024 01:42:24 -0700
 Subject: [PATCH] drop bazel_toolchains_repositories to support offline build
@@ -33,6 +33,3 @@ index 0fdb0342fae..d617f7d02d2 100644
      # Apple rules for Bazel. https://github.com/bazelbuild/rules_apple.
      # Note: We add this to fix Kokoro builds.
      # The rules below call into `rules_proto` but the hash has changed and
--- 
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-drop-v2-config.patch
rename to recipes-framework/tensorflow/files/0004-drop-v2-config.patch
index ff74a3c..2a2621b 100644
--- a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch
+++ b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
@@ -1,4 +1,4 @@
-From 104224b8b30f74dabed893aa057f400ad7cd2695 Mon Sep 17 00:00:00 2001
+From 2b7979f3ebed80bdbb272e7fb4afe10fafbd76fc Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:10:55 -0700
 Subject: [PATCH] drop v2 config
@@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index b6a72c1e5d3..a71ade6950f 100644
+index fb80a081c56..1a59209e4dc 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -138,9 +138,6 @@ build --define=with_xla_support=true
+@@ -114,9 +114,6 @@ build --define=with_xla_support=true
  # TODO(mihaimaruseac): Document this option or remove if no longer needed
  build --config=short_logs
  
@@ -24,6 +24,3 @@ index b6a72c1e5d3..a71ade6950f 100644
  # Disable AWS/HDFS support by default
  build --define=no_aws_support=true
  build --define=no_hdfs_support=true
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch b/recipes-framework/tensorflow/files/0005-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
similarity index 88%
rename from recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
rename to recipes-framework/tensorflow/files/0005-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
index acde266..48d02fd 100644
--- a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
+++ b/recipes-framework/tensorflow/files/0005-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
@@ -1,7 +1,7 @@
-From 3b3b8bc65c30fb5ac2a3d5beaa424b27ceb41dc8 Mon Sep 17 00:00:00 2001
+From 66ac16ab8d6dddde20ac87ee99dc5bb4a2e4e5d7 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Thu, 29 Feb 2024 23:26:53 -0800
-Subject: [PATCH] eplace distutils.sysconfig.get_python_lib() with
+Subject: [PATCH] Replace distutils.sysconfig.get_python_lib() with
  sysconfig.get_path('purelib') - python 3.10 support
 
 This is part of the effort for 51776 to get python 3.10 support.
@@ -17,13 +17,14 @@ Upstream-Status: Backport from tensorflow github
 
 Rebase to 2.16
 Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
+Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
 ---
  tensorflow/api_template.__init__.py    | 5 ++---
  tensorflow/api_template_v1.__init__.py | 5 ++---
  2 files changed, 4 insertions(+), 6 deletions(-)
 
 diff --git a/tensorflow/api_template.__init__.py b/tensorflow/api_template.__init__.py
-index a0f88926b5e..d98c045bdeb 100644
+index 5ea9ef248d5..b447341bab3 100644
 --- a/tensorflow/api_template.__init__.py
 +++ b/tensorflow/api_template.__init__.py
 @@ -27,7 +27,7 @@ this file with a file generated from [`api_template.__init__.py`](https://www.gi
@@ -35,7 +36,7 @@ index a0f88926b5e..d98c045bdeb 100644
  import importlib
  import inspect as _inspect
  import os as _os
-@@ -98,8 +98,7 @@ _site_packages_dirs += [p for p in _sys.path if "site-packages" in p]
+@@ -100,8 +100,7 @@ _site_packages_dirs += [p for p in _sys.path if "site-packages" in p]
  if "getsitepackages" in dir(_site):
    _site_packages_dirs += _site.getsitepackages()
  
@@ -68,6 +69,3 @@ index 6a4ab4e655f..012c54f7fed 100644
  
  _site_packages_dirs = list(set(_site_packages_dirs))
  
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch b/recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
rename to recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
index e365c27..762e49e 100644
--- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
+++ b/recipes-framework/tensorflow/files/0006-hardcode-go-SDKS.patch
@@ -1,4 +1,4 @@
-From c0fa623063942d53f9f65fb14ada4cbec5cc9b9a Mon Sep 17 00:00:00 2001
+From 8d8146e906a302b3a0811b10d9b22befe0b2e392 Mon Sep 17 00:00:00 2001
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
+index fd29dff05f3..43053967ca1 100644
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
similarity index 92%
rename from recipes-framework/tensorflow/files/0001-fix-build-failure.patch
rename to recipes-framework/tensorflow/files/0007-fix-build-failure.patch
index 30a0361..09edafe 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-failure.patch
+++ b/recipes-framework/tensorflow/files/0007-fix-build-failure.patch
@@ -1,4 +1,4 @@
-From cd26d8228aef93559dc11c7584d8cf8d0a529d1d Mon Sep 17 00:00:00 2001
+From abef350ce8de5b62e64bd653b16f885a3b9c430a Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 4 Mar 2024 15:07:58 +0800
 Subject: [PATCH] fix build failure
@@ -36,10 +36,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 2a49fdfce60..24c2bbf82ef 100644
+index fb87fda9f82..5d6390c6907 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -131,6 +131,9 @@ PACKAGE_STATIC_DEPS = [
+@@ -132,6 +132,9 @@ PACKAGE_STATIC_DEPS = [
      "@triton//:__subpackages__",
      "@local_tsl//:__subpackages__",
      "@local_xla//:__subpackages__",
@@ -49,6 +49,3 @@ index 2a49fdfce60..24c2bbf82ef 100644
  ] + tsl_async_value_deps()
  
  package(
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch b/recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
similarity index 86%
rename from recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch
rename to recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
index a1be846..434bbc7 100644
--- a/recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch
+++ b/recipes-framework/tensorflow/files/0008-support-hermetic-Python.patch
@@ -1,4 +1,4 @@
-From cd7dc62667df74f9e4c8293dbc087a3ed10c8890 Mon Sep 17 00:00:00 2001
+From 311bfb81a750a7689b8ac48ee23f1add7f8ce1e2 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 4 Mar 2024 17:44:35 +0800
 Subject: [PATCH] support hermetic Python
@@ -19,10 +19,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  4 files changed, 8 insertions(+)
 
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 24c2bbf82ef..0bf6127ffd1 100644
+index 5d6390c6907..d1650039097 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -134,6 +134,9 @@ PACKAGE_STATIC_DEPS = [
+@@ -135,6 +135,9 @@ PACKAGE_STATIC_DEPS = [
      "@riegeli//:__subpackages__",
      "@org_brotli//:__subpackages__",
      "@net_zstd//:__subpackages__",
@@ -33,7 +33,7 @@ index 24c2bbf82ef..0bf6127ffd1 100644
  
  package(
 diff --git a/tensorflow/compiler/tf2tensorrt/BUILD b/tensorflow/compiler/tf2tensorrt/BUILD
-index 91ef722b52d..320c3e80e6c 100644
+index 498aa0f91e4..30434cf8f49 100644
 --- a/tensorflow/compiler/tf2tensorrt/BUILD
 +++ b/tensorflow/compiler/tf2tensorrt/BUILD
 @@ -1097,6 +1097,7 @@ pybind_extension(
@@ -45,10 +45,10 @@ index 91ef722b52d..320c3e80e6c 100644
      deps = [
          ":common_utils",
 diff --git a/tensorflow/python/BUILD b/tensorflow/python/BUILD
-index 675709d4314..65b3fd20b4f 100644
+index c3f9a377e01..4212ebb4f1e 100644
 --- a/tensorflow/python/BUILD
 +++ b/tensorflow/python/BUILD
-@@ -741,6 +741,8 @@ pywrap_tensorflow_macro(
+@@ -743,6 +743,8 @@ pywrap_tensorflow_macro(
          "@zlib//:__subpackages__",
          "@local_tsl//tsl:__subpackages__",
          "@local_xla//xla:__subpackages__",
@@ -58,10 +58,10 @@ index 675709d4314..65b3fd20b4f 100644
      win_def_file = ":pywrap_tensorflow_filtered_def_file",
      deps = [
 diff --git a/tensorflow/tensorflow.bzl b/tensorflow/tensorflow.bzl
-index 45c597b3ef4..d821a60aa5f 100644
+index 6e656b861be..4ae1a96f905 100644
 --- a/tensorflow/tensorflow.bzl
 +++ b/tensorflow/tensorflow.bzl
-@@ -3304,6 +3304,8 @@ def tf_python_pybind_static_deps(testonly = False):
+@@ -3316,6 +3316,8 @@ def tf_python_pybind_static_deps(testonly = False):
          "@upb//:__subpackages__",
          "@zlib//:__subpackages__",
          "@local_tsl//tsl:__subpackages__",
@@ -70,6 +70,3 @@ index 45c597b3ef4..d821a60aa5f 100644
      ]
      static_deps += tsl_async_value_deps()
      static_deps += [] if not testonly else [
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch b/recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch
rename to recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
index 95cc193..b3ee997 100644
--- a/recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-offline-build.patch
+++ b/recipes-framework/tensorflow/files/0009-make-hermetic-python3-support-offline-build.patch
@@ -1,4 +1,4 @@
-From e060b1fa679f809407e5597bd045105914fb1c05 Mon Sep 17 00:00:00 2001
+From bcd4ad2fb5608c3dab5259daa8e6c8d9f296a5ea Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Fri, 8 Mar 2024 11:31:26 +0800
 Subject: [PATCH] make hermetic python3 support offline build
@@ -18,10 +18,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  create mode 100644 third_party/0001-support-offline-build.patch
 
 diff --git a/WORKSPACE b/WORKSPACE
-index a697405110e..9b33f0cfdf1 100644
+index cb024a13a19..5c9eff6249d 100644
 --- a/WORKSPACE
 +++ b/WORKSPACE
-@@ -16,6 +16,8 @@ http_archive(
+@@ -26,6 +26,8 @@ http_archive(
      name = "rules_python",
      sha256 = "9d04041ac92a0985e344235f5d946f71ac543f1b1565f2cdbc9a2aaee8adf55b",
      strip_prefix = "rules_python-0.26.0",
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
index 7c0385d..6115c99 100644
--- a/recipes-framework/tensorflow/files/0001-Fix-build-with-gcc-12.patch
+++ b/recipes-framework/tensorflow/files/0010-Fix-build-with-gcc-12.patch
@@ -1,4 +1,4 @@
-From 150a64dc59ec3a6240fa71fc018f20f1ac0f451d Mon Sep 17 00:00:00 2001
+From 8d8e8657f1c80f8efb1f82e1a6641e84c9f21aca Mon Sep 17 00:00:00 2001
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
diff --git a/recipes-framework/tensorflow/files/0001-fix-patchelf-not-found.patch b/recipes-framework/tensorflow/files/0011-fix-patchelf-not-found.patch
similarity index 92%
rename from recipes-framework/tensorflow/files/0001-fix-patchelf-not-found.patch
rename to recipes-framework/tensorflow/files/0011-fix-patchelf-not-found.patch
index bb850a1..363759a 100644
--- a/recipes-framework/tensorflow/files/0001-fix-patchelf-not-found.patch
+++ b/recipes-framework/tensorflow/files/0011-fix-patchelf-not-found.patch
@@ -1,4 +1,4 @@
-From 03fdc48cea3a939b2d10fd170bef045c23b3ca5f Mon Sep 17 00:00:00 2001
+From 7148d2557430f24c461028f4728aa2898db6c7f8 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Fri, 23 Aug 2024 14:40:35 +0800
 Subject: [PATCH] fix patchelf not found
@@ -27,6 +27,3 @@ index 01f878410e4..ef77ead6430 100644
      )
      return [DefaultInfo(files = depset(direct = [output]))]
  
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-llvm-project-timeout-occasionally.patch b/recipes-framework/tensorflow/files/0012-fix-llvm-project-timeout-occasionally.patch
similarity index 98%
rename from recipes-framework/tensorflow/files/0001-fix-llvm-project-timeout-occasionally.patch
rename to recipes-framework/tensorflow/files/0012-fix-llvm-project-timeout-occasionally.patch
index af9bcc2..92c0106 100644
--- a/recipes-framework/tensorflow/files/0001-fix-llvm-project-timeout-occasionally.patch
+++ b/recipes-framework/tensorflow/files/0012-fix-llvm-project-timeout-occasionally.patch
@@ -1,4 +1,4 @@
-From bda6860a3457d3a690780031b391feee8e378130 Mon Sep 17 00:00:00 2001
+From 214385f13baed5e53f0d88d926f116a1bb7d973f Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 16 Oct 2024 14:48:23 +0800
 Subject: [PATCH] fix llvm-project timeout occasionally
@@ -92,6 +92,3 @@ index 10601c8a766..73616d42b25 100644
          ],
          link_files = {"//third_party/llvm:run_lit.sh": "mlir/run_lit.sh"},
      )
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0013-add-yocto-toolchain-to-support-cross-compiling.patch
similarity index 88%
rename from recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
rename to recipes-framework/tensorflow/files/0013-add-yocto-toolchain-to-support-cross-compiling.patch
index 5fdc04c..d947d7f 100644
--- a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0013-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,4 +1,4 @@
-From 2e03e5bcd0b1e05f10f7d2d0cfede314fbfa5818 Mon Sep 17 00:00:00 2001
+From bdffcf56d9856adea10e4f65e49d70bf75f29b8c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Fri, 1 Mar 2024 00:22:22 -0800
 Subject: [PATCH] add yocto toolchain to support cross compiling
@@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
  3 files changed, 23 insertions(+)
 
 diff --git a/WORKSPACE b/WORKSPACE
-index 720fee74bd2..94095bf1914 100644
+index 5c9eff6249d..87e8f1fda10 100644
 --- a/WORKSPACE
 +++ b/WORKSPACE
-@@ -40,3 +40,9 @@ tf_workspace1()
+@@ -103,3 +103,9 @@ tf_workspace1()
  load("@//tensorflow:workspace0.bzl", "tf_workspace0")
  
  tf_workspace0()
@@ -27,10 +27,10 @@ index 720fee74bd2..94095bf1914 100644
 +    build_file = "//:BUILD.yocto_compiler",
 +)
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 9e724aff49b..0918af13243 100644
+index d1650039097..21ccd9dead0 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -352,6 +352,15 @@ config_setting(
+@@ -359,6 +359,15 @@ config_setting(
      visibility = ["//visibility:public"],
  )
  
@@ -47,10 +47,10 @@ index 9e724aff49b..0918af13243 100644
      name = "android_arm",
      constraint_values = if_google(
 diff --git a/tensorflow/workspace2.bzl b/tensorflow/workspace2.bzl
-index 3ef4a544f1a..9e4c2da9fe2 100644
+index 43053967ca1..d52d1f00f8c 100644
 --- a/tensorflow/workspace2.bzl
 +++ b/tensorflow/workspace2.bzl
-@@ -49,6 +49,7 @@ load("//tensorflow/tools/def_file_filter:def_file_filter_configure.bzl", "def_fi
+@@ -12,6 +12,7 @@ load("//tensorflow/tools/def_file_filter:def_file_filter_configure.bzl", "def_fi
  load("//tensorflow/tools/toolchains:cpus/aarch64/aarch64_compiler_configure.bzl", "aarch64_compiler_configure")
  load("//tensorflow/tools/toolchains:cpus/arm/arm_compiler_configure.bzl", "arm_compiler_configure")
  load("//tensorflow/tools/toolchains/clang6:repo.bzl", "clang6_configure")
@@ -72,6 +72,3 @@ index 3ef4a544f1a..9e4c2da9fe2 100644
      # TFLite crossbuild toolchain for embeddeds Linux
      arm_linux_toolchain_configure(
          name = "local_config_embedded_arm",
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/files/0001-disable-avxvnni-and-avx512fp16-for-x86.patch b/recipes-framework/tensorflow/files/0013-disable-avxvnni-and-avx512fp16-for-x86.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0001-disable-avxvnni-and-avx512fp16-for-x86.patch
rename to recipes-framework/tensorflow/files/0013-disable-avxvnni-and-avx512fp16-for-x86.patch
index ae1a65a..b9f2aac 100644
--- a/recipes-framework/tensorflow/files/0001-disable-avxvnni-and-avx512fp16-for-x86.patch
+++ b/recipes-framework/tensorflow/files/0013-disable-avxvnni-and-avx512fp16-for-x86.patch
@@ -1,4 +1,4 @@
-From b0b6611ae25441d27f4a0238d20bc3d77decaccc Mon Sep 17 00:00:00 2001
+From ad2f365ca2bd70cceef3648300c45bd403764887 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 15 Oct 2024 14:25:30 +0800
 Subject: [PATCH] disable avxvnni and avx512fp16 for x86
@@ -93,6 +93,3 @@ index 00000000000..1c0d952070e
 +-- 
 +2.25.1
 +
--- 
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/files/0014-fix-build-tensorflow-lite-examples-label_image-label.patch
similarity index 85%
rename from recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
rename to recipes-framework/tensorflow/files/0014-fix-build-tensorflow-lite-examples-label_image-label.patch
index 0502c5b..ff5a84c 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
+++ b/recipes-framework/tensorflow/files/0014-fix-build-tensorflow-lite-examples-label_image-label.patch
@@ -1,4 +1,4 @@
-From 1af9e2180f680c1b0c94fbeeaee9dc522f353d07 Mon Sep 17 00:00:00 2001
+From 055e12414a27fbf60e083e1d40e13f17d68d928d Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 17 Aug 2021 16:00:24 +0800
 Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:label_image
@@ -21,10 +21,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 8 insertions(+)
 
 diff --git a/tensorflow/lite/kernels/internal/BUILD b/tensorflow/lite/kernels/internal/BUILD
-index 8c714fc282d..6ea96e4f103 100644
+index 11292aeb2bb..1746336cd1d 100644
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
diff --git a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0015-label_image-tweak-default-model-location.patch
similarity index 89%
rename from recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0015-label_image-tweak-default-model-location.patch
index 5962c90..bb695ef 100644
--- a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0015-label_image-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 17e03724c925f8d0b11c8f14699646aa498af798 Mon Sep 17 00:00:00 2001
+From 3d3d77f9b7db2f6c21a7f1249753bfa3b0714246 Mon Sep 17 00:00:00 2001
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
+index 7a287a7ff3d..d2609041a6a 100644
 --- a/tensorflow/examples/label_image/main.cc
 +++ b/tensorflow/examples/label_image/main.cc
-@@ -279,11 +279,11 @@ int main(int argc, char* argv[]) {
+@@ -294,11 +294,11 @@ int main(int argc, char* argv[]) {
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
diff --git a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0016-label_image.lite-tweak-default-model-location.patch
similarity index 88%
rename from recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0016-label_image.lite-tweak-default-model-location.patch
index 597021a..f940975 100644
--- a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0016-label_image.lite-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From dd73bef88a23d29299bc6e2f3c892ed81d65a86c Mon Sep 17 00:00:00 2001
+From 60ebef697006bf3a1d00bbb625e2006ad6799a39 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 9 Dec 2020 09:53:30 +0800
 Subject: [PATCH] label_image.lite: tweak default model location
@@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 5 insertions(+), 3 deletions(-)
 
 diff --git a/tensorflow/lite/examples/label_image/label_image.h b/tensorflow/lite/examples/label_image/label_image.h
-index 1c00edb6558..a5bcf8c64d8 100644
+index db55265b7e0..44c41ef48a8 100644
 --- a/tensorflow/lite/examples/label_image/label_image.h
 +++ b/tensorflow/lite/examples/label_image/label_image.h
-@@ -34,10 +34,12 @@ struct Settings {
+@@ -36,10 +36,12 @@ struct Settings {
    int loop_count = 1;
    float input_mean = 127.5f;
    float input_std = 127.5f;
@@ -30,6 +30,3 @@ index 1c00edb6558..a5bcf8c64d8 100644
    int number_of_threads = 4;
    int number_of_results = 5;
    int max_profiling_buffer_entries = 1024;
--- 
-2.18.2
-
diff --git a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch b/recipes-framework/tensorflow/files/0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch
similarity index 90%
rename from recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
rename to recipes-framework/tensorflow/files/0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch
index 7bde666..115ad2e 100644
--- a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
+++ b/recipes-framework/tensorflow/files/0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch
@@ -1,4 +1,4 @@
-From 1455cd4232f382b73cb4ff6dfa6ccc7bd5197428 Mon Sep 17 00:00:00 2001
+From 6cdd81bb4d7d699ac049b7024f432f2d185dfb20 Mon Sep 17 00:00:00 2001
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
diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0018-support-32-bit-x64-and-arm-for-yocto.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
rename to recipes-framework/tensorflow/files/0018-support-32-bit-x64-and-arm-for-yocto.patch
index 9cbbea1..4533ffc 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0018-support-32-bit-x64-and-arm-for-yocto.patch
@@ -1,4 +1,4 @@
-From 87e7f67bc9a0fb3a9d227c5f676ec28ebdcaa010 Mon Sep 17 00:00:00 2001
+From 379a2f377fb18139a28a90ed87fdb8da7bb160cd Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Thu, 22 Aug 2024 01:56:07 -0700
 Subject: [PATCH] support 32 bit x64 and arm for yocto
@@ -9,11 +9,11 @@ Rebase to 2.17.0
 
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
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
 
@@ -53,7 +53,7 @@ index d52d1f00f8c..5892b7ad446 100644
  
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
-2.25.1
-
diff --git a/recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch b/recipes-framework/tensorflow/files/0019-build-api_gen_binary_target-as-host-tools.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch
rename to recipes-framework/tensorflow/files/0019-build-api_gen_binary_target-as-host-tools.patch
index c7f3034..8bb02d2 100644
--- a/recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-host-tools.patch
+++ b/recipes-framework/tensorflow/files/0019-build-api_gen_binary_target-as-host-tools.patch
@@ -1,4 +1,4 @@
-From e1471b0dd1eb2c6ee152f749437cab65c2b27ef3 Mon Sep 17 00:00:00 2001
+From b1b6a5810b95eb1e20ac9d4e500f279b379817a1 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Fri, 1 Mar 2024 00:41:25 -0800
 Subject: [PATCH] build api_gen_binary_target as host tools
@@ -32,10 +32,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/tensorflow/python/tools/api/generator/api_gen.bzl b/tensorflow/python/tools/api/generator/api_gen.bzl
-index c41aeecc476..a087557ad0f 100644
+index d066b3422e0..6298edff674 100644
 --- a/tensorflow/python/tools/api/generator/api_gen.bzl
 +++ b/tensorflow/python/tools/api/generator/api_gen.bzl
-@@ -267,7 +267,7 @@ api_gen_rule = rule(
+@@ -266,7 +266,7 @@ api_gen_rule = rule(
          "outs": attr.output_list(mandatory = True),
          "srcs": attr.label_list(allow_files = True),
          "flags": attr.string_list(),
@@ -44,6 +44,3 @@ index c41aeecc476..a087557ad0f 100644
          "loading_value": attr.string(mandatory = True),
          "api_packages_path": attr.output(),
      },
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.17.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.17.0.bb
index 8f9c1ff..eaa1494 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.17.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.17.0.bb
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
+    file://0013-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0014-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0015-label_image-tweak-default-model-location.patch \
+    file://0016-label_image.lite-tweak-default-model-location.patch \
+    file://0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0018-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
diff --git a/recipes-framework/tensorflow/tensorflow-native_2.17.0.bb b/recipes-framework/tensorflow/tensorflow-native_2.17.0.bb
index 58cb76f..ae52f06 100644
--- a/recipes-framework/tensorflow/tensorflow-native_2.17.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-native_2.17.0.bb
@@ -1,7 +1,7 @@
 include tensorflow.inc
 
 SRC_URI += " \
-    file://0001-disable-avxvnni-and-avx512fp16-for-x86.patch \
+    file://0013-disable-avxvnni-and-avx512fp16-for-x86.patch \
 "
 
 inherit native
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index 5e6c82b..15464b9 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -11,19 +11,19 @@ DEPENDS = " \
 "
 SRCREV = "999767f61417203f38537361e23bcdf3273deb8f"
 SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.17;protocol=https \
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
-           file://0001-fix-patchelf-not-found.patch \
-           file://0001-fix-llvm-project-timeout-occasionally.patch \
-          "
+    file://0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
+    file://0002-third_party-eigen_archive-workaround-ice-failure-whi.patch \
+    file://0003-drop-bazel_toolchains_repositories-to-support-offlin.patch \
+    file://0004-drop-v2-config.patch \
+    file://0005-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
+    file://0006-hardcode-go-SDKS.patch \
+    file://0007-fix-build-failure.patch \
+    file://0008-support-hermetic-Python.patch \
+    file://0009-make-hermetic-python3-support-offline-build.patch \
+    file://0010-Fix-build-with-gcc-12.patch \
+    file://0011-fix-patchelf-not-found.patch \
+    file://0012-fix-llvm-project-timeout-occasionally.patch \
+"
 
 S = "${WORKDIR}/git"
 
diff --git a/recipes-framework/tensorflow/tensorflow_2.17.0.bb b/recipes-framework/tensorflow/tensorflow_2.17.0.bb
index 3b26f1c..40cb93a 100644
--- a/recipes-framework/tensorflow/tensorflow_2.17.0.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.17.0.bb
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
+    file://0013-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0014-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0015-label_image-tweak-default-model-location.patch \
+    file://0016-label_image.lite-tweak-default-model-location.patch \
+    file://0017-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0018-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0019-build-api_gen_binary_target-as-host-tools.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
-- 
2.48.1


