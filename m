Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07BC0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:15:16 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.3185.1739290508915741364
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 08:15:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bHSGwLm6;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso2786344f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290507; x=1739895307; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOBe6bUCPXBDlU4S+T2jmnXfL5BWPxuFml1rkS6Sl7s=;
        b=bHSGwLm6S1P5izIRO5LRBZO6cOmInDOcRuspEuIyZv8kmIsgb0V+SzHkGeTyL05Prf
         cmYnAK3TvhhWfz+x3FHDAYtJRoklzHuJcsqFWD3jbWJB50N36UWnN7uqwOq84miaBFyY
         m+l88uinN7u8mwRjDhExatWzistpmq9R/Qrpf2I+xXVz2dEtB3mYIKClS793U0WO9hjz
         229sCAW5n+PVZsVygNpe3Xh876VpyCHpN1bR4+ek/95Jr0k5Qwc4WjERV0bRVHbdTtix
         hiDQDkZMkJFMjz7PKEut7zdozLSc/KAff+GHXf1MNe15iwXZTWfV6Zyonz6gP3ve+FsD
         Ys+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290507; x=1739895307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOBe6bUCPXBDlU4S+T2jmnXfL5BWPxuFml1rkS6Sl7s=;
        b=UKnAWHpQKgrXao84lTWn3TaUUXSW5LbVK8Wg31+Dup/AIZhN4iEPSqbWNjnz48iOYl
         3NMrCPDS3Hxxb1cJS6i90LCYvyq7pjnap3gOe8Vc9K58UqN9yU3/KQoHvl3tclpismz7
         stiw7JmqJKXClk1cSrLBne33OOgJ+UMY9W+eMdOmcMeDLgU8nbiQTnWeOn2PXj7HdDgq
         h2wz4rcW2qeP2gJjxBHxrLYM1rx0e2koQM2ctSqEYd7UnBYsljdo7v0GoeQf7jL7kUtE
         fZLtbYZR1H61xos6TPSp7PY2GTocJq3IDNRjqzX6LOTrQ/v6KSSelIEyCDmWdNCXxHOf
         H89A==
X-Gm-Message-State: AOJu0YyW6PwNYYQwr+O2smbYcomNcIpmvAO+VyWoq5dCf1y7pcNY4W3J
	g+lWxoC+PWh/d8uPYjNPwehkL8iF8uF00LisZHMLKBGMnqpzjO3yCnADBw==
X-Gm-Gg: ASbGncuDPZGju7Tr7Dg+LdKIoNkw3VYputi8sPmDOGg6E+D+DmGXEchgdODsUx+pOkk
	yryBtnI+LTU9HlAy1KnudFOheoEd0Y5y904Vwxavm3naQ/4y3KZgZjjm7ygK/OXMTJiI9KiEOrp
	oHM6pw6dnCYwVU1rtLeK1pCAhUCQF1cU+I2rGxlG+tGSmOsx4xI84arjiKs3iLjIFReK+/4Gxbh
	XhUeDYPpR6HAuVafyhZzrowk2KaYyu88C7mWyp3A4dkDQOtPQy2GbUUwtR1qlzqKB6w/0LtUS5G
	7em6G10iO9aStpu18Kt3JPA8wPfUDZyaanb9d6jv/iVq996b
X-Google-Smtp-Source: AGHT+IFRQT9nO1BxaDvuSiV42EkVKy63VY22MERUZPZLA+9EYxPj2g7jb2XY1A7CO6mzY0cheMNNBQ==
X-Received: by 2002:a05:6000:178d:b0:38d:e363:494b with SMTP id ffacd0b85a97d-38de439d6d6mr3486159f8f.8.1739290507112;
        Tue, 11 Feb 2025 08:15:07 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dbf2ed900sm15092504f8f.53.2025.02.11.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:15:06 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][mickledore][PATCH 3/3] tensorflow: add 0001-fix-python3-include-directory-not-found.patch everywhere
Date: Tue, 11 Feb 2025 17:14:59 +0100
Message-ID: <20250211161500.3077588-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211161500.3077588-1-martin.jansa@gmail.com>
References: <20250211161500.3077588-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1063

* move 0001-fix-python3-include-directory-not-found.patch from
  tensorflow-native to tensorflow.inc as the whole section is later
  removed for target builds by:
  0019-distutils-is-deprecated-in-Python-3.10-51776.patch
  so we can use single chain of .patch files

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 ...-python3-include-directory-not-found.patch} |  2 +-
 ...toolchain-to-support-cross-compiling.patch} |  2 +-
 ...flow-lite-examples-label_image-label.patch} |  2 +-
 ...l_image-tweak-default-model-location.patch} |  2 +-
 ...ge.lite-tweak-default-model-location.patch} |  2 +-
 ...eatureOrDie-use-warning-to-avoid-die.patch} |  2 +-
 ...support-32-bit-x64-and-arm-for-yocto.patch} |  2 +-
 ...nct_host_configuration-false-by-defa.patch} |  2 +-
 ...s-is-deprecated-in-Python-3.10-51776.patch} | 18 ++++++++----------
 ...ix-XNNPACK-build-failure-for-qemuarm.patch} |  2 +-
 .../tensorflow/tensorflow-lite_2.12.0.bb       | 18 +++++++++---------
 .../tensorflow/tensorflow-native_2.12.0.bb     |  4 ----
 recipes-framework/tensorflow/tensorflow.inc    |  1 +
 .../tensorflow/tensorflow_2.12.0.bb            | 17 +++++++++--------
 14 files changed, 36 insertions(+), 40 deletions(-)
 rename recipes-framework/tensorflow/files/{0001-fix-python3-include-directory-not-found.patch => 0011-fix-python3-include-directory-not-found.patch} (96%)
 rename recipes-framework/tensorflow/files/{0011-add-yocto-toolchain-to-support-cross-compiling.patch => 0012-add-yocto-toolchain-to-support-cross-compiling.patch} (97%)
 rename recipes-framework/tensorflow/files/{0012-fix-build-tensorflow-lite-examples-label_image-label.patch => 0013-fix-build-tensorflow-lite-examples-label_image-label.patch} (95%)
 rename recipes-framework/tensorflow/files/{0013-label_image-tweak-default-model-location.patch => 0014-label_image-tweak-default-model-location.patch} (97%)
 rename recipes-framework/tensorflow/files/{0014-label_image.lite-tweak-default-model-location.patch => 0015-label_image.lite-tweak-default-model-location.patch} (95%)
 rename recipes-framework/tensorflow/files/{0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch => 0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch} (95%)
 rename recipes-framework/tensorflow/files/{0016-support-32-bit-x64-and-arm-for-yocto.patch => 0017-support-32-bit-x64-and-arm-for-yocto.patch} (98%)
 rename recipes-framework/tensorflow/files/{0017-Revert-set-distinct_host_configuration-false-by-defa.patch => 0018-Revert-set-distinct_host_configuration-false-by-defa.patch} (93%)
 rename recipes-framework/tensorflow/files/{0018-distutils-is-deprecated-in-Python-3.10-51776.patch => 0019-distutils-is-deprecated-in-Python-3.10-51776.patch} (70%)
 rename recipes-framework/tensorflow/files/{0019-fix-XNNPACK-build-failure-for-qemuarm.patch => 0020-fix-XNNPACK-build-failure-for-qemuarm.patch} (99%)

diff --git a/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch b/recipes-framework/tensorflow/files/0011-fix-python3-include-directory-not-found.patch
similarity index 96%
rename from recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch
rename to recipes-framework/tensorflow/files/0011-fix-python3-include-directory-not-found.patch
index 4e9b9c5..d516d70 100644
--- a/recipes-framework/tensorflow/files/0001-fix-python3-include-directory-not-found.patch
+++ b/recipes-framework/tensorflow/files/0011-fix-python3-include-directory-not-found.patch
@@ -1,4 +1,4 @@
-From b0df1f017ab730b150dcfe71084620e4edf44504 Mon Sep 17 00:00:00 2001
+From d15265b01f6247e32ee3793e44ac6d0416e63615 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 14 Nov 2022 15:27:41 +0800
 Subject: [PATCH] fix python3 include directory not found
diff --git a/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
rename to recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
index aea4618..74be839 100644
--- a/recipes-framework/tensorflow/files/0011-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,4 +1,4 @@
-From cc522bdebaa28115662d38b655f3b9e8eee28026 Mon Sep 17 00:00:00 2001
+From 8c0c0341c7db90116e970d5920cfcbc8458172d9 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Sun, 12 Mar 2023 23:38:01 -0700
 Subject: [PATCH] add yocto toolchain to support cross compiling
diff --git a/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/files/0013-fix-build-tensorflow-lite-examples-label_image-label.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
rename to recipes-framework/tensorflow/files/0013-fix-build-tensorflow-lite-examples-label_image-label.patch
index f9d16c3..03ca5e1 100644
--- a/recipes-framework/tensorflow/files/0012-fix-build-tensorflow-lite-examples-label_image-label.patch
+++ b/recipes-framework/tensorflow/files/0013-fix-build-tensorflow-lite-examples-label_image-label.patch
@@ -1,4 +1,4 @@
-From 0dd71f76f8384c8dec85c31f94df6bdaa9ee665e Mon Sep 17 00:00:00 2001
+From eb54003a69b626e7b46764e817426c5e7e63b95c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Tue, 17 Aug 2021 16:00:24 +0800
 Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:label_image
diff --git a/recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0014-label_image-tweak-default-model-location.patch
similarity index 97%
rename from recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0014-label_image-tweak-default-model-location.patch
index 3785f77..1649484 100644
--- a/recipes-framework/tensorflow/files/0013-label_image-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0014-label_image-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 4b97089f7c18df8fef47cb4d825d96aa07316d35 Mon Sep 17 00:00:00 2001
+From fc0d23151539eba2beb9a33e8229e99a32453d2a Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:36:00 -0700
 Subject: [PATCH] label_image: tweak default model location
diff --git a/recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch b/recipes-framework/tensorflow/files/0015-label_image.lite-tweak-default-model-location.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
rename to recipes-framework/tensorflow/files/0015-label_image.lite-tweak-default-model-location.patch
index b870e59..64c407c 100644
--- a/recipes-framework/tensorflow/files/0014-label_image.lite-tweak-default-model-location.patch
+++ b/recipes-framework/tensorflow/files/0015-label_image.lite-tweak-default-model-location.patch
@@ -1,4 +1,4 @@
-From 5e6734503d8d5bc56dfe47dd7d5d0ee50aa4832c Mon Sep 17 00:00:00 2001
+From 4b546bb68b8b1c3ebb244bd0e0b4071bb6fc3595 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 9 Dec 2020 09:53:30 +0800
 Subject: [PATCH] label_image.lite: tweak default model location
diff --git a/recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch b/recipes-framework/tensorflow/files/0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch
similarity index 95%
rename from recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
rename to recipes-framework/tensorflow/files/0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch
index c826c1e..a094eb6 100644
--- a/recipes-framework/tensorflow/files/0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch
+++ b/recipes-framework/tensorflow/files/0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch
@@ -1,4 +1,4 @@
-From 6c0e8215f1e476862f42b61b7ee6029d8ba397a4 Mon Sep 17 00:00:00 2001
+From 8d182dd0c99c063b308bcfb26aad662fd38a8264 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:39:33 -0700
 Subject: [PATCH] CheckFeatureOrDie: use warning to avoid die
diff --git a/recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0017-support-32-bit-x64-and-arm-for-yocto.patch
similarity index 98%
rename from recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
rename to recipes-framework/tensorflow/files/0017-support-32-bit-x64-and-arm-for-yocto.patch
index cca7899..c85965f 100644
--- a/recipes-framework/tensorflow/files/0016-support-32-bit-x64-and-arm-for-yocto.patch
+++ b/recipes-framework/tensorflow/files/0017-support-32-bit-x64-and-arm-for-yocto.patch
@@ -1,4 +1,4 @@
-From 480271c4007031090043db9534a63acd4db997e9 Mon Sep 17 00:00:00 2001
+From 11bc5bdda19d610e2b0f7704fccf3372f27e6e1c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@eng.windriver.com>
 Date: Sun, 12 Mar 2023 23:48:00 -0700
 Subject: [PATCH] support 32 bit x64 and arm for yocto
diff --git a/recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch b/recipes-framework/tensorflow/files/0018-Revert-set-distinct_host_configuration-false-by-defa.patch
similarity index 93%
rename from recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch
rename to recipes-framework/tensorflow/files/0018-Revert-set-distinct_host_configuration-false-by-defa.patch
index a6d4131..f519424 100644
--- a/recipes-framework/tensorflow/files/0017-Revert-set-distinct_host_configuration-false-by-defa.patch
+++ b/recipes-framework/tensorflow/files/0018-Revert-set-distinct_host_configuration-false-by-defa.patch
@@ -1,4 +1,4 @@
-From c40feb600abaeba1de7e736a4a4d0de71d798a44 Mon Sep 17 00:00:00 2001
+From 07554cdcd86f1091c8e27090dce6ce3863b68e8f Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 00:53:00 -0700
 Subject: [PATCH] Revert "set --distinct_host_configuration=false by default
diff --git a/recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch b/recipes-framework/tensorflow/files/0019-distutils-is-deprecated-in-Python-3.10-51776.patch
similarity index 70%
rename from recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch
rename to recipes-framework/tensorflow/files/0019-distutils-is-deprecated-in-Python-3.10-51776.patch
index a1b6a6d..f7ab138 100644
--- a/recipes-framework/tensorflow/files/0018-distutils-is-deprecated-in-Python-3.10-51776.patch
+++ b/recipes-framework/tensorflow/files/0019-distutils-is-deprecated-in-Python-3.10-51776.patch
@@ -1,4 +1,4 @@
-From 85fada9708cd38c278cc4237feb90d0c94425758 Mon Sep 17 00:00:00 2001
+From f4bdb494b665d13b469b00e4b51e468b30268f1b Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Mon, 16 May 2022 01:18:43 -0700
 Subject: [PATCH] `distutils` is deprecated in Python 3.10 #51776
@@ -14,14 +14,14 @@ Upstream-Status: Inappropriate [oe specific]
 
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
- third_party/py/python_configure.bzl | 19 +------------------
- 1 file changed, 1 insertion(+), 18 deletions(-)
+ third_party/py/python_configure.bzl | 17 +----------------
+ 1 file changed, 1 insertion(+), 16 deletions(-)
 
 diff --git a/third_party/py/python_configure.bzl b/third_party/py/python_configure.bzl
-index 300cbfb6c71..e57af9f9dc9 100644
+index 14248233dc1..e57af9f9dc9 100644
 --- a/third_party/py/python_configure.bzl
 +++ b/third_party/py/python_configure.bzl
-@@ -149,24 +149,7 @@ def _check_python_bin(repository_ctx, python_bin):
+@@ -149,22 +149,7 @@ def _check_python_bin(repository_ctx, python_bin):
  
  def _get_python_include(repository_ctx, python_bin):
      """Gets the python include path."""
@@ -31,11 +31,9 @@ index 300cbfb6c71..e57af9f9dc9 100644
 -            python_bin,
 -            "-Wignore",
 -            "-c",
--            "import importlib; " +
--            "import importlib.util; " +
--            "print(importlib.import_module('distutils.sysconfig').get_python_inc() " +
--            "if importlib.util.find_spec('distutils.sysconfig') " +
--            "else importlib.import_module('sysconfig').get_path('include'))",
+-            "from __future__ import print_function;" +
+-            "import sysconfig;" +
+-            "print(sysconfig.get_path('include'))"
 -        ],
 -        error_msg = "Problem getting python include path.",
 -        error_details = ("Is the Python binary path set up right? " +
diff --git a/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch b/recipes-framework/tensorflow/files/0020-fix-XNNPACK-build-failure-for-qemuarm.patch
similarity index 99%
rename from recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch
rename to recipes-framework/tensorflow/files/0020-fix-XNNPACK-build-failure-for-qemuarm.patch
index 1a792ee..4838644 100644
--- a/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure-for-qemuarm.patch
+++ b/recipes-framework/tensorflow/files/0020-fix-XNNPACK-build-failure-for-qemuarm.patch
@@ -1,4 +1,4 @@
-From 2ace7a16a8033169b7ddb71a79956416644ffa3e Mon Sep 17 00:00:00 2001
+From 78979d043ffc4395b4a311aeef220cc34aac8c8d Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Thu, 23 Mar 2023 10:28:04 +0800
 Subject: [PATCH] fix XNNPACK build failure for qemuarm
diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
index b85000f..1f228a6 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
@@ -1,21 +1,21 @@
 include tensorflow.inc
 
 SRC_URI += " \
-    file://0011-add-yocto-toolchain-to-support-cross-compiling.patch \
-    file://0012-fix-build-tensorflow-lite-examples-label_image-label.patch \
-    file://0013-label_image-tweak-default-model-location.patch \
-    file://0014-label_image.lite-tweak-default-model-location.patch \
-    file://0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-    file://0016-support-32-bit-x64-and-arm-for-yocto.patch \
-    file://0017-Revert-set-distinct_host_configuration-false-by-defa.patch \
-    file://0018-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://0012-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0013-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0014-label_image-tweak-default-model-location.patch \
+    file://0015-label_image.lite-tweak-default-model-location.patch \
+    file://0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0017-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0018-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0019-distutils-is-deprecated-in-Python-3.10-51776.patch \
     file://BUILD.in \
     file://BUILD.yocto_compiler \
     file://cc_config.bzl.tpl \
     file://yocto_compiler_configure.bzl \
 "
 SRC_URI:append:arm = " \
-    file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
+    file://0020-fix-XNNPACK-build-failure-for-qemuarm.patch \
 "
 
 SRC_URI += "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=model-inv3"
diff --git a/recipes-framework/tensorflow/tensorflow-native_2.12.0.bb b/recipes-framework/tensorflow/tensorflow-native_2.12.0.bb
index 7cf24ce..a3a9515 100644
--- a/recipes-framework/tensorflow/tensorflow-native_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-native_2.12.0.bb
@@ -1,9 +1,5 @@
 include tensorflow.inc
 
-SRC_URI += " \
-    file://0001-fix-python3-include-directory-not-found.patch \
-"
-
 inherit native
 
 export PYTHON_BIN_PATH="${PYTHON}"
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index c32b902..54ab3db 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -15,6 +15,7 @@ SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.12;protocol=http
     file://0008-Fix-failure-while-gcc-7.5.0.patch \
     file://0009-fix-compile-error-for-gcc-13.1.patch \
     file://0010-fix-compile-failure.patch \
+    file://0011-fix-python3-include-directory-not-found.patch \
 "
 S = "${WORKDIR}/git"
 
diff --git a/recipes-framework/tensorflow/tensorflow_2.12.0.bb b/recipes-framework/tensorflow/tensorflow_2.12.0.bb
index e045a7d..f613164 100644
--- a/recipes-framework/tensorflow/tensorflow_2.12.0.bb
+++ b/recipes-framework/tensorflow/tensorflow_2.12.0.bb
@@ -1,14 +1,15 @@
 include tensorflow.inc
 
 SRC_URI += " \
-    file://0011-add-yocto-toolchain-to-support-cross-compiling.patch \
-    file://0012-fix-build-tensorflow-lite-examples-label_image-label.patch \
-    file://0013-label_image-tweak-default-model-location.patch \
-    file://0014-label_image.lite-tweak-default-model-location.patch \
-    file://0015-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
-    file://0016-support-32-bit-x64-and-arm-for-yocto.patch \
-    file://0017-Revert-set-distinct_host_configuration-false-by-defa.patch \
-    file://0018-distutils-is-deprecated-in-Python-3.10-51776.patch \
+    file://0011-fix-python3-include-directory-not-found.patch \
+    file://0012-add-yocto-toolchain-to-support-cross-compiling.patch \
+    file://0013-fix-build-tensorflow-lite-examples-label_image-label.patch \
+    file://0014-label_image-tweak-default-model-location.patch \
+    file://0015-label_image.lite-tweak-default-model-location.patch \
+    file://0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
+    file://0017-support-32-bit-x64-and-arm-for-yocto.patch \
+    file://0018-Revert-set-distinct_host_configuration-false-by-defa.patch \
+    file://0019-distutils-is-deprecated-in-Python-3.10-51776.patch \
     file://BUILD.in \
     file://BUILD.yocto_compiler \
     file://cc_config.bzl.tpl \
-- 
2.48.1


