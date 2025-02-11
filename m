Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD94C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:17:06 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.3250.1739290618869551053
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:16:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iz44wP6A;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43690d4605dso39801005e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290617; x=1739895417; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oGNX5T24LWtEWnKJGMY5g4QXsEZft9zh9DDH3Ifpxw=;
        b=iz44wP6AaZQ3zR9urlWX6X8kbmHoKYTt18EgED47azW6ipyJ3iO08LTcMWBsdTqvrV
         P4joGkWud2fdlog3nIKmX1VWJUI8LbvYRzDIVdYL+9UE+v48Yor9/AqXA2LNMEWEcEWe
         Ypyb+NBNauV6FQgDrNzjN/suoDsmPzP6qYv3j3RyAbMx/6qT4JnsNLoKYL8g8BDKrVW/
         ZmQ0TnCQlywwW+9UC0l+7lZShCsy4qIeMSk4J7ohDraxryFC9t+KeiRVZcw0DXqKUJh6
         qdtOB0neW4XQ/yK+qhS06pX5I6cIoTQ4UdLiy+WXvafXN+tWZ+BSOiOy37jtRu9+gbSz
         /adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290617; x=1739895417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oGNX5T24LWtEWnKJGMY5g4QXsEZft9zh9DDH3Ifpxw=;
        b=eHPeD/50OY22ZThHfVQnhr0XqabuAYKYC1jsGHuvdyeIen6fHBOacPF0+5rKltxol5
         5ePTGdWqoHurXJEWzF+PbnFJJ1SPJqyViA/PmZgumObP+hJOqMAR2MeegMB2Bo1CfJZ5
         Co4ElR3LkV8GBx6Hu9Kx4F+vYkP3UCLeidZ1xvTTuFfk0SadfaJWQS6P4yFB9Dh4STbP
         uDX0vATh6j3VefvAxdZqh8Jd8Sh1g4xgKlzbCjn0DUPw+xlCzvWYMvzhVnCEiFL6mKXk
         IUx3iLpE9Ivdx5dAxDawzY1pHbSj2jM/Rj9aA4scMsQ0+mEZaWGJnAkVYSnJz5TflKdh
         3MDQ==
X-Gm-Message-State: AOJu0Yztj+7gb6eL7BY1AVMlG9JSuSASH8QLvFK+yKb6OyvNObLUeLPV
	cAQ+gSs43Tzjnithw6V/DloSxuPO/+N2vcpvROTQyh2zX/XjHA6fNafvMA==
X-Gm-Gg: ASbGncvqgT8V9t7Ew2tCP4eYxDcXuZc6qrk7N7MSrT8ceC8G4NaJdSQA8xM3Jqz1/jz
	NdDFgZHB4a2piprg04WTP3EWPsw+IDl2XMNbK4ANDgrWmWphtaeurZ9K+kBr+Q5gAiMsNqoXJFM
	WjEf6OU6spn5a4NlTe2KWRisi1BMmO57usHRFripTkJtNsUnmyznfqXrHVEB27FJ3Om950AZc+v
	31h22xqslKbOuv2ytbokpHzrMriHAJoXn7+xaSnnrMNj5yVgAPbW1IF3RrjqHr3c/FJKaZxJTy2
	5dWAeIcPYCs0mbeBGjZDUGW0MMGBNN9bw2KSnRbfbpu2PUx5
X-Google-Smtp-Source: AGHT+IHe7hFDwBpB4PBInbgWJsyYroIwAL6IN6VY4y7SRtjgFTgnhh+n3gPwU1II3xxBOSg/Hg/ugA==
X-Received: by 2002:a05:600c:3acc:b0:439:4cef:3510 with SMTP id 5b1f17b1804b1-4394cef37f2mr40391015e9.10.1739290615299;
        Tue, 11 Feb 2025 08:16:55 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4393f202721sm82444555e9.21.2025.02.11.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:16:54 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][kirkstone][PATCH 2/2] tensorflow: refresh and rename the .patch files
Date: Tue, 11 Feb 2025 17:15:16 +0100
Message-ID: <20250211161516.3084692-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211161516.3084692-1-martin.jansa@gmail.com>
References: <20250211161516.3084692-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:17:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1065

* use --no-signature as devtool does to avoid unnecessary git signature
  changes
* rename to have increasing numbers in the order how they should
  be applied (so they can be all easily applied with single git
  am call)

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 .../tensorflow/files/0001-support-musl.patch  |  5 +---
 ...l-to-workaround-bazel-paralle-issue.patch} |  9 +++----
 ..._archive-workaround-ice-failure-whi.patch} | 11 +++-----
 ...config.patch => 0004-drop-v2-config.patch} |  9 +++----
 ...ains_repositories-to-support-offlin.patch} |  5 +---
 ....sysconfig.get_python_lib-with-sysc.patch} | 15 +++++------
 ...oolchain-to-support-cross-compiling.patch} | 13 ++++------
 ...low-lite-examples-label_image-label.patch} | 11 +++-----
 ..._image-tweak-default-model-location.patch} |  7 ++---
 ...e.lite-tweak-default-model-location.patch} |  5 +---
 ...atureOrDie-use-warning-to-avoid-die.patch} |  5 +---
 ...upport-32-bit-x64-and-arm-for-yocto.patch} | 17 +++++-------
 ...ct_host_configuration-false-by-defa.patch} |  9 +++----
 ...-is-deprecated-in-Python-3.10-51776.patch} |  5 +---
 .../tensorflow/tensorflow-lite_2.10.0.bb      | 26 +++++++++----------
 recipes-framework/tensorflow/tensorflow.inc   | 15 +++++------
 .../tensorflow/tensorflow_2.10.0.bb           | 26 +++++++++----------
 17 files changed, 75 insertions(+), 118 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch => 0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch} (79%)
 rename recipes-framework/tensorflow/files/{0001-third_party-eigen_archive-workaround-ice-failure-whi.patch => 0003-third_party-eigen_archive-workaround-ice-failure-whi.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-drop-v2-config.patch => 0004-drop-v2-config.patch} (79%)
 rename recipes-framework/tensorflow/files/{0001-drop-bazel_toolchains_repositories-to-support-offlin.patch => 0005-drop-bazel_toolchains_repositories-to-support-offlin.patch} (94%)
 rename recipes-framework/tensorflow/files/{0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch => 0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch} (90%)
 rename recipes-framework/tensorflow/files/{0001-add-yocto-toolchain-to-support-cross-compiling.patch => 0007-add-yocto-toolchain-to-support-cross-compiling.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-fix-build-tensorflow-lite-examples-label_image-label.patch => 0008-fix-build-tensorflow-lite-examples-label_image-label.patch} (85%)
 rename recipes-framework/tensorflow/files/{0001-label_image-tweak-default-model-location.patch => 0009-label_image-tweak-default-model-location.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-label_image.lite-tweak-default-model-location.patch => 0010-label_image.lite-tweak-default-model-location.patch} (94%)
 rename recipes-framework/tensorflow/files/{0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch => 0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch} (95%)
 rename recipes-framework/tensorflow/files/{0001-support-32-bit-x64-and-arm-for-yocto.patch => 0012-support-32-bit-x64-and-arm-for-yocto.patch} (91%)
 rename recipes-framework/tensorflow/files/{0001-Revert-set-distinct_host_configuration-false-by-defa.patch => 0013-Revert-set-distinct_host_configuration-false-by-defa.patch} (81%)
 rename recipes-framework/tensorflow/files/{0001-distutils-is-deprecated-in-Python-3.10-cross.patch => 0014-distutils-is-deprecated-in-Python-3.10-51776.patch} (96%)

diff --git a/recipes-framework/tensorflow/files/0001-support-musl.patch b/recipes-framework/tensorflow/files/0001-support-musl.patch
index 355b0cb..76d5e2f 100644
--- a/recipes-framework/tensorflow/files/0001-support-musl.patch
+++ b/recipes-framework/tensorflow/files/0001-support-musl.patch
@@ -1,4 +1,4 @@
-From a37010bee0ef08a2b42c10fc6ca1f3bd793b0e6a Mon Sep 17 00:00:00 2001
+From 80ff19bdafd336108779bf110dea4ee2d115242c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 8 Dec 2020 17:06:52 +0800
 Subject: [PATCH] support musl
@@ -45,6 +45,3 @@ index 70fcdc27042..f38fe71c917 100644
  #define TF_GENERATE_STACKTRACE
  #endif
  
--- 
-2.18.2
-
diff --git a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch b/recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
rename to recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
index 8a17700..04396fa 100644
--- a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch
+++ b/recipes-framework/tensorflow/files/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
@@ -1,4 +1,4 @@
-From bbdf1bbca17f8bce98e32b25aa9bfadc8f465f24 Mon Sep 17 00:00:00 2001
+From 856e20e86e771224963d5791d57c8f6e802b1450 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Sun, 15 May 2022 23:59:17 -0700
 Subject: [PATCH] use local bazel to workaround bazel paralle issue
@@ -12,10 +12,10 @@ Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/configure.py b/configure.py
-index dae3dce89d3..979f00f3633 100644
+index bf338bdda22..034e7c7c67f 100644
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
index 2056c20..821f31f 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
+++ b/recipes-framework/tensorflow/files/0003-third_party-eigen_archive-workaround-ice-failure-whi.patch
@@ -1,4 +1,4 @@
-From 385074d9300c18293a42c9d8ca9fb12cbffccb80 Mon Sep 17 00:00:00 2001
+From ce9fd298ef95a3399d66fb8b9c3c15ff975d2e64 Mon Sep 17 00:00:00 2001
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
@@ -104,6 +104,3 @@ index 1380722ee67..722cfbece83 100644
          sha256 = EIGEN_SHA256,
          strip_prefix = "eigen-{commit}".format(commit = EIGEN_COMMIT),
          urls = tf_mirror_urls("https://gitlab.com/libeigen/eigen/-/archive/{commit}/eigen-{commit}.tar.gz".format(commit = EIGEN_COMMIT)),
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
similarity index 79%
rename from recipes-framework/tensorflow/files/0001-drop-v2-config.patch
rename to recipes-framework/tensorflow/files/0004-drop-v2-config.patch
index ff74a3c..63f5b67 100644
--- a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch
+++ b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
@@ -1,4 +1,4 @@
-From 104224b8b30f74dabed893aa057f400ad7cd2695 Mon Sep 17 00:00:00 2001
+From 938ce13d91b6d0cbf6bc5199094629ab26431129 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:10:55 -0700
 Subject: [PATCH] drop v2 config
@@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 3 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index b6a72c1e5d3..a71ade6950f 100644
+index 9cc8c84673b..4d46f9b2a85 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -138,9 +138,6 @@ build --define=with_xla_support=true
+@@ -134,9 +134,6 @@ build --define=with_xla_support=true
  # TODO(mihaimaruseac): Document this option or remove if no longer needed
  build --config=short_logs
  
@@ -24,6 +24,3 @@ index b6a72c1e5d3..a71ade6950f 100644
  # Disable AWS/HDFS support by default
  build --define=no_aws_support=true
  build --define=no_hdfs_support=true
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch b/recipes-framework/tensorflow/files/0005-drop-bazel_toolchains_repositories-to-support-offlin.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
rename to recipes-framework/tensorflow/files/0005-drop-bazel_toolchains_repositories-to-support-offlin.patch
index 730f2c2..59b2e60 100644
--- a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositories-to-support-offlin.patch
+++ b/recipes-framework/tensorflow/files/0005-drop-bazel_toolchains_repositories-to-support-offlin.patch
@@ -1,4 +1,4 @@
-From 6bb9c02aae20996a6e4edd8fe743a90ce8d677aa Mon Sep 17 00:00:00 2001
+From f3ccd400246a3bf2ef3656b3d5e12b5d99172815 Mon Sep 17 00:00:00 2001
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
diff --git a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch b/recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
similarity index 90%
rename from recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
rename to recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
index 9ce46ee..9eb170d 100644
--- a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
+++ b/recipes-framework/tensorflow/files/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
@@ -1,7 +1,7 @@
-From 5dc007d64a9928d379851a6524a376bfdb819c6d Mon Sep 17 00:00:00 2001
+From 8eeeb59072d85ea2bdffc71ca0c7f1664140f1a1 Mon Sep 17 00:00:00 2001
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
+index 3bb0bb91ba6..7de533deee1 100644
 --- a/tensorflow/api_template.__init__.py
 +++ b/tensorflow/api_template.__init__.py
 @@ -26,7 +26,7 @@ only a placeholder to enable test cases to run. The TensorFlow build replaces
@@ -33,7 +33,7 @@ index 1ed97439b06..58904070e62 100644
  import inspect as _inspect
  import logging as _logging
  import os as _os
-@@ -122,8 +122,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
+@@ -117,8 +117,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
  if 'getsitepackages' in dir(_site):
    _site_packages_dirs += _site.getsitepackages()
  
@@ -44,7 +44,7 @@ index 1ed97439b06..58904070e62 100644
  _site_packages_dirs = list(set(_site_packages_dirs))
  
 diff --git a/tensorflow/api_template_v1.__init__.py b/tensorflow/api_template_v1.__init__.py
-index 87d9bc1f204..70e0fd70c34 100644
+index f11fedce109..f21296e7528 100644
 --- a/tensorflow/api_template_v1.__init__.py
 +++ b/tensorflow/api_template_v1.__init__.py
 @@ -14,7 +14,7 @@
@@ -56,7 +56,7 @@ index 87d9bc1f204..70e0fd70c34 100644
  import inspect as _inspect
  import os as _os
  import site as _site
-@@ -163,8 +163,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
+@@ -158,8 +158,7 @@ _site_packages_dirs += [_p for _p in _sys.path if 'site-packages' in _p]
  if 'getsitepackages' in dir(_site):
    _site_packages_dirs += _site.getsitepackages()
  
@@ -66,6 +66,3 @@ index 87d9bc1f204..70e0fd70c34 100644
  
  _site_packages_dirs = list(set(_site_packages_dirs))
  
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0007-add-yocto-toolchain-to-support-cross-compiling.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
rename to recipes-framework/tensorflow/files/0007-add-yocto-toolchain-to-support-cross-compiling.patch
index 62804ec..3515ae6 100644
--- a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0007-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,4 +1,4 @@
-From 2bc17fd2dfa2e4d6b0cbedf692a31b56e02cf6e6 Mon Sep 17 00:00:00 2001
+From b3759f094bc1bfcb74b0c828f2f6c4637364cb9f Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:31:42 -0700
 Subject: [PATCH] add yocto toolchain to support cross compiling
@@ -27,10 +27,10 @@ index 1286ef9ac03..3ed96c1052d 100644
 +    build_file = "//:BUILD.yocto_compiler",
 +)
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 92e11a68e8d..7ae7fc79356 100644
+index 19ee8000206..d01b55aaa92 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -207,6 +207,15 @@ config_setting(
+@@ -259,6 +259,15 @@ config_setting(
      visibility = ["//visibility:public"],
  )
  
@@ -47,7 +47,7 @@ index 92e11a68e8d..7ae7fc79356 100644
      name = "android_arm",
      flag_values = if_google(
 diff --git a/tensorflow/workspace2.bzl b/tensorflow/workspace2.bzl
-index 77c76aa6e20..f5c323174d5 100644
+index e255103df98..a49aeeb7434 100644
 --- a/tensorflow/workspace2.bzl
 +++ b/tensorflow/workspace2.bzl
 @@ -10,6 +10,7 @@ load("//third_party/git:git_configure.bzl", "git_configure")
@@ -58,7 +58,7 @@ index 77c76aa6e20..f5c323174d5 100644
  load("//tensorflow/tools/toolchains/embedded/arm-linux:arm_linux_toolchain_configure.bzl", "arm_linux_toolchain_configure")
  load("//third_party:repo.bzl", "tf_http_archive", "tf_mirror_urls")
  load("//third_party/clang_toolchain:cc_configure_clang.bzl", "cc_download_clang_toolchain")
-@@ -114,6 +115,13 @@ def _tf_toolchains():
+@@ -109,6 +110,13 @@ def _tf_toolchains():
          remote_config_repo_aarch64 = "../aarch64_compiler",
      )
  
@@ -72,6 +72,3 @@ index 77c76aa6e20..f5c323174d5 100644
      # TFLite crossbuild toolchain for embeddeds Linux
      arm_linux_toolchain_configure(
          name = "local_config_embedded_arm",
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/files/0008-fix-build-tensorflow-lite-examples-label_image-label.patch
similarity index 85%
rename from recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
rename to recipes-framework/tensorflow/files/0008-fix-build-tensorflow-lite-examples-label_image-label.patch
index 0502c5b..490c49b 100644
--- a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-examples-label_image-label.patch
+++ b/recipes-framework/tensorflow/files/0008-fix-build-tensorflow-lite-examples-label_image-label.patch
@@ -1,4 +1,4 @@
-From 1af9e2180f680c1b0c94fbeeaee9dc522f353d07 Mon Sep 17 00:00:00 2001
+From 26aa60bece56d2d9ffbd387b2e4f079cd1effa6d Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 17 Aug 2021 16:00:24 +0800
 Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:label_image
@@ -21,10 +21,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 8 insertions(+)
 
 diff --git a/tensorflow/lite/kernels/internal/BUILD b/tensorflow/lite/kernels/internal/BUILD
-index 8c714fc282d..6ea96e4f103 100644
+index 095c75c626e..744d7a6e82b 100644
 --- a/tensorflow/lite/kernels/internal/BUILD
 +++ b/tensorflow/lite/kernels/internal/BUILD
-@@ -112,6 +112,13 @@ config_setting(
+@@ -114,6 +114,13 @@ config_setting(
      },
  )
  
@@ -38,7 +38,7 @@ index 8c714fc282d..6ea96e4f103 100644
  config_setting(
      name = "haswell",
      values = {
-@@ -235,6 +242,7 @@ selects.config_setting_group(
+@@ -244,6 +251,7 @@ selects.config_setting_group(
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
diff --git a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0009-label_image-tweak-default-model-location.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0009-label_image-tweak-default-model-location.patch
index 5962c90..0a6d581 100644
--- a/recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0009-label_image-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 17e03724c925f8d0b11c8f14699646aa498af798 Mon Sep 17 00:00:00 2001
+From 2d65aad61ad4c349e39aa67fd379d21e54818b64 Mon Sep 17 00:00:00 2001
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
diff --git a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0010-label_image.lite-tweak-default-model-location.patch
similarity index 94%
rename from recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0010-label_image.lite-tweak-default-model-location.patch
index 597021a..f4f7cf4 100644
--- a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0010-label_image.lite-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From dd73bef88a23d29299bc6e2f3c892ed81d65a86c Mon Sep 17 00:00:00 2001
+From 7fb242d6ecefb6c8749d18ec64af24cfee257207 Mon Sep 17 00:00:00 2001
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
diff --git a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch b/recipes-framework/tensorflow/files/0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
rename to recipes-framework/tensorflow/files/0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch
index 7bde666..404910c 100644
--- a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-avoid-die.patch
+++ b/recipes-framework/tensorflow/files/0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch
@@ -1,4 +1,4 @@
-From 1455cd4232f382b73cb4ff6dfa6ccc7bd5197428 Mon Sep 17 00:00:00 2001
+From d038e1a80360361369b5e0f6c92a0bea611ddd9d Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:39:33 -0700
 Subject: [PATCH] CheckFeatureOrDie: use warning to avoid die
@@ -36,6 +36,3 @@ index 11a438925c1..9874ed34793 100644
    }
  }
  
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0012-support-32-bit-x64-and-arm-for-yocto.patch
similarity index 91%
rename from recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
rename to recipes-framework/tensorflow/files/0012-support-32-bit-x64-and-arm-for-yocto.patch
index 5eae2fd..8a192d3 100644
--- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0012-support-32-bit-x64-and-arm-for-yocto.patch
@@ -1,4 +1,4 @@
-From 73fffc29b6384c2695fa221fac9067c9661af4de Mon Sep 17 00:00:00 2001
+From 294bf761d1fee1771b5b1636f00910659d6ba38a Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 19 Sep 2022 00:02:14 -0700
 Subject: [PATCH] support 32 bit x64 and arm for yocto
@@ -8,11 +8,11 @@ Upstream-Status: Inappropriate [oe specific]
 Rebase to 2.10.0
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
 
@@ -52,7 +52,7 @@ index a49aeeb7434..c1d90686dcb 100644
      )
 diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 new file mode 100644
-index 00000000000..2141c37236b
+index 00000000000..e2c053e6f8c
 --- /dev/null
 +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
 @@ -0,0 +1,27 @@
@@ -85,7 +85,7 @@ index 00000000000..2141c37236b
 +
 diff --git a/third_party/0001-cpuinfo-support-32-bit-x86.patch b/third_party/0001-cpuinfo-support-32-bit-x86.patch
 new file mode 100644
-index 00000000000..0c83cf01675
+index 00000000000..cd6b27eaea3
 --- /dev/null
 +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
 @@ -0,0 +1,27 @@
@@ -116,6 +116,3 @@ index 00000000000..0c83cf01675
 +-- 
 +2.37.1
 +
--- 
-2.37.1
-
diff --git a/recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch b/recipes-framework/tensorflow/files/0013-Revert-set-distinct_host_configuration-false-by-defa.patch
similarity index 81%
rename from recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch
rename to recipes-framework/tensorflow/files/0013-Revert-set-distinct_host_configuration-false-by-defa.patch
index adc4661..68a3dd6 100644
--- a/recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_configuration-false-by-defa.patch
+++ b/recipes-framework/tensorflow/files/0013-Revert-set-distinct_host_configuration-false-by-defa.patch
@@ -1,4 +1,4 @@
-From 0076b9b52016c7a22c4418d25945ebc893a67b12 Mon Sep 17 00:00:00 2001
+From 46c5b23f136efbf61a29576bb30bcf79fc703a8c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:53:00 -0700
 Subject: [PATCH] Revert "set --distinct_host_configuration=false by default
@@ -16,10 +16,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  1 file changed, 2 deletions(-)
 
 diff --git a/.bazelrc b/.bazelrc
-index a71ade6950f..9f7627bb7c6 100644
+index 4d46f9b2a85..cf8d2c2b028 100644
 --- a/.bazelrc
 +++ b/.bazelrc
-@@ -355,8 +355,6 @@ build:windows --features=compiler_param_file
+@@ -374,8 +374,6 @@ build:windows --features=compiler_param_file
  
  # On windows, we never cross compile
  build:windows --distinct_host_configuration=false
@@ -28,6 +28,3 @@ index a71ade6950f..9f7627bb7c6 100644
  
  # Do not risk cache corruption. See:
  # https://github.com/bazelbuild/bazel/issues/3360
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch b/recipes-framework/tensorflow/files/0014-distutils-is-deprecated-in-Python-3.10-51776.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch
rename to recipes-framework/tensorflow/files/0014-distutils-is-deprecated-in-Python-3.10-51776.patch
index e79fc24..6c628e1 100644
--- a/recipes-framework/tensorflow/files/0001-distutils-is-deprecated-in-Python-3.10-cross.patch
+++ b/recipes-framework/tensorflow/files/0014-distutils-is-deprecated-in-Python-3.10-51776.patch
@@ -1,4 +1,4 @@
-From 79bd5c1e597ffd877822297a48d9eaa9ca3a317d Mon Sep 17 00:00:00 2001
+From 4b869ac19a6192df34e5ed41ab7a3f5ff3db8438 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 01:18:43 -0700
 Subject: [PATCH] `distutils` is deprecated in Python 3.10 #51776
@@ -47,6 +47,3 @@ index 300cbfb6c71..e57af9f9dc9 100644
  
  def _get_python_import_lib_name(repository_ctx, python_bin):
      """Get Python import library name (pythonXY.lib) on Windows."""
--- 
-2.36.0
-
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
index 12ea7a6..8ecc048 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
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
+    file://0007-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0008-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0009-label_image-tweak-default-model-location.patch \
+    file://0010-label_image.lite-tweak-default-model-location.patch \
+    file://0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0012-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0013-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0014-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index e63cb8e..386fc3e 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -5,14 +5,13 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=4158a261ca7f2525513e31ba9c50ae98"
 DEPENDS = "bazel-native protobuf-native util-linux-native protobuf"
 SRCREV = "359c3cdfc5fabac82b3c70b3b6de2b0a8c16874f"
 SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.10;protocol=https \
-           file://0001-support-musl.patch \
-           file://0001-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
-           file://0001-third_party-eigen_archive-workaround-ice-failure-whi.patch \
-           file://0001-drop-bazel_toolchains_repositories-to-support-offlin.patch \
-           file://0001-drop-v2-config.patch \
-           file://0002-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
-          "
-
+    file://0001-support-musl.patch \
+    file://0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch \
+    file://0003-third_party-eigen_archive-workaround-ice-failure-whi.patch \
+    file://0004-drop-v2-config.patch \
+    file://0005-drop-bazel_toolchains_repositories-to-support-offlin.patch \
+    file://0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch \
+"
 S = "${WORKDIR}/git"
 
 DEPENDS += " \
diff --git a/recipes-framework/tensorflow/tensorflow_2.10.0.bb b/recipes-framework/tensorflow/tensorflow_2.10.0.bb
index a0e75ee..3957737 100644
--- a/recipes-framework/tensorflow/tensorflow_2.10.0.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.10.0.bb
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
+    file://0007-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0008-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0009-label_image-tweak-default-model-location.patch \
+    file://0010-label_image.lite-tweak-default-model-location.patch \
+    file://0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0012-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0013-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0014-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://BUILD.in \
+    file://BUILD.yocto_compiler \
+    file://cc_config.bzl.tpl \
+    file://yocto_compiler_configure.bzl \
+"
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
 SRC_URI[model-inv3.md5sum] = "a904ddf15593d03c7dd786d552e22d73"
-- 
2.48.1


