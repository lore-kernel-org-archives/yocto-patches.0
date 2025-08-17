Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88CCA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 20:46:53 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.60518.1755463608932920568
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 13:46:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CsDxbvJq;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a286135c8so4494775e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755463607; x=1756068407; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt+zsCYGE7mg8ELWGAYwd3LGN5iACfaIBtwRO8ldAzw=;
        b=CsDxbvJqw3uCago/9dACzO7ZAsm9eQ1QMUJHQrC69JVegY5paXAoLKqDaXH1cRw3Gr
         pBeYDLK8/FPz6bZVBnVaQoWS35jv6TRcdK+GCcZFN6lYUxqGbgPlrVVeunohYJKeN/TG
         +8/nhm9S6Ah2fRkG8iVS+4vGQVFfBx5Ms6vzUzqbtJGNdTWHWStAYku/7mdRzM5Jk7IV
         +hG+55QqrfajRjvn/TArDChmPG0FBany6OEKiWIZDGTwxGsqHX0BcwjUSs9Svem/n0r4
         JclV+e6Cj8XGmXu2ifDy0RpdUpeCEJC4fGdfDRR3Stj8s92qUYmTXHrSAqNVZyvSqNwY
         6oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755463607; x=1756068407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt+zsCYGE7mg8ELWGAYwd3LGN5iACfaIBtwRO8ldAzw=;
        b=S7baSnRTV4t0Cl+oQkcPxVSZUdX66bUAN2OBJGTiFgRkluM8ZkC+3sqvfZJ3FPDi9B
         uyXkvU804nMXutQRbqB9sJVbHNrlkQ1Pmgh2cGgj+DMjwUQ0Oj0U9QRer4gi0CRLYsc2
         mcomM+FeHLff7dnPi2HEiXkSl71U5bScd9Dn4Ls7carxMqixS9koLQKdUaimYjmGAKAR
         i3WDenO1UFn5WRH5wly3Dy2+i2GZ14XFa5RJlxmUW0yQq4kF3PxUZCA2yngbe+gj8VLJ
         VBfn+n8an1JX1wpfREVFv77zAh2xZN/Rlai3srozou5FPOT6ePzTJ5V0l0yxZ57OYEuO
         5S0w==
X-Gm-Message-State: AOJu0YzQCLkJ5petF+Sr7YZ6IWVqVvlaVTww/489gU9BK/bTCr7kDIhU
	Q2IucVtguuIafingkct45hHhEj53uX5YaKobsoS9fnVbXZMP+p+gDW9ytDQ78w==
X-Gm-Gg: ASbGncuc1s5sSKrva46PHTrLWN9Ex1xC1bnLZ+SYGMjMvk0ereSvazzx4tNgc0YMZIQ
	MrFCq5r+XEFt3AA2Q34xW3snYba0UWw9ugc02yhyIe80jtXFmQbp/B3+DuxBEk403TJWr9fux7f
	YeUDIve1OkeLa2BpZ8GhKY2rVioIgV7c0Xcw47ZRdnKe5QJJlxG37VMd/0c8glaoeJIWJcrfGW+
	ywo0mOnBgraQQ/pWoCTHZsZOVlhcdcKa741XiWSCkWLZ2k53EUllJFYozy8gQQ6/RUulenIJkeJ
	r1FgKOvl5bX55U0VXqUcO2Ft4CPCb89YUFAPwYNzHQnuF7TTurbHBUf+W6bQtAau4+01n2Ys6tB
	TWUt9peNQo8fkiOeg+kdjNXrIxA==
X-Google-Smtp-Source: AGHT+IEBLGei7NYz+7fdx5UuFra6EmQ7/HSyBW8wEBrMiCV1MImloHiZZFfDnFtpqkbCL78adrQtGw==
X-Received: by 2002:a05:6000:25c5:b0:3b9:148b:e6d with SMTP id ffacd0b85a97d-3ba50913636mr12018522f8f.20.1755463606940;
        Sun, 17 Aug 2025 13:46:46 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb64c30c45sm10476183f8f.16.2025.08.17.13.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 13:46:46 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCHv2] bazel-native: fix build with gcc-15
Date: Sun, 17 Aug 2025 22:46:44 +0200
Message-ID: <20250817204644.3817415-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 20:46:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2022

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
 .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/include_stdint.patch

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index 29abd0e..04ca4cc 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
@@ -12,6 +12,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://0001-cutsomize-native-toolchains-for-Yocto.patch \
            file://0001-fix-compile-failure-on-gcc-13.patch \
            file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
+           file://include_stdint.patch \
 "
 
 inherit python3native
diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recipes-devtools/bazel/files/include_stdint.patch
new file mode 100644
index 0000000..35c57c2
--- /dev/null
+++ b/recipes-devtools/bazel/files/include_stdint.patch
@@ -0,0 +1,28 @@
+https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde26df426e12/bazel7/include_stdint.patch
+
+Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues/25514]
+
+diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_utils.h
+index 18856ab..5298a36 100644
+--- a/src/main/cpp/archive_utils.h
++++ b/src/main/cpp/archive_utils.h
+@@ -15,6 +15,7 @@
+ #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
+ #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
+
++#include <cstdint>
+ #include <string>
+ #include <vector>
+
+diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.h
+index b2cd459..7bf5a00 100644
+--- a/src/main/cpp/util/logging.h
++++ b/src/main/cpp/util/logging.h
+@@ -14,6 +14,7 @@
+ #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
+ #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
+
++#include <cstdint>
+ #include <memory>
+ #include <sstream>
+ #include <string>

