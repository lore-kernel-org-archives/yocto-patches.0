Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3672C02196
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 15:24:38 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.118986.1738682676340105633
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Feb 2025 07:24:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VbPYsWDH;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863494591bso2917833f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738682675; x=1739287475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op73Gmsbw4fw1RAX3Hi0/khkZCJ/+ItblUKkVvdZ40o=;
        b=VbPYsWDHzhhp5Xrtbs4O9f8eMzb5j1cI7R5gehztpqXS5BmBKuH2OWz4PX1LF11AqV
         6lIpjX5UYJMcV55lIY77x/x7iJ6d9ZKoIId3NmODQOBK/B4iap8JO9HIkzLw16hX0AAX
         wNyJ+DM0xm9ZtzHqZtiz42HxaRgQpa2WUBzd4mWBGMrRVu6ZNLCe003/28GiPWK4ZPm/
         Zt8y6dUS9QESr99pNJMb909dLJhD4xaoEkX7NdflJFWR1CjgcGn625i6XowcYMl143/6
         vnBZA0PGLuTvh14dU4DJxAPoV+BlvH45yn7CAmQnmP35mSP50Uom2dAswemoWtYcD3mB
         bsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682675; x=1739287475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op73Gmsbw4fw1RAX3Hi0/khkZCJ/+ItblUKkVvdZ40o=;
        b=CGbEtx1FiFxmi5pFUXhPgz9SMvP63WHdzlVAwTH0HoJGcQViyt0QcjBRkQE8wowc/K
         kgZMDc6TF8c7CGzA+iNLquvTL1VSHKfXuI0Qindofs+QfvuoKv9MO/XFaEn1TTrQqqm3
         OOn0kr8xTeEweoPx3hk0SiaGl2EMWE3HKgljppiIoav+A3+s7Utd09ljRnVpl9GDAVW0
         t4x4iwX5C4YpQ1ZHPHhgVuChyi7PKWK9kkAL6Gkrr/t+Rflf/CNu8/TOq29Kkos8E7VU
         MIdlTzCt1ErQ4GDF7EEcsnpFoKlIdnBnx1Bo2q/obC6omsTh1o53bX36XJcHaWM9AzbZ
         UMnA==
X-Gm-Message-State: AOJu0Yx3hY+sxelI3Gu266z3FHlbDPBeHsjR/YocXBGQiey14URuXM/Y
	XTtqnmd0XLckocjovPQhV7CsxVxCa90UJkF+gMa8TPhKyL4h8AamWSIVDg==
X-Gm-Gg: ASbGncuEQyeopWgmtqL6CCX9bh5CEV0jjsD0AMAyICOKfSLb+PvYisQl7g4e+pnr8yS
	Cfa+dRuRZci7ig5GckUoMdzqys5i/NTw31I8IyoPqOI5+md7aYakTd+2ScG7IwiyRchhAfM2G00
	1gzFsepkfAjopThITg3BXqUDMtM1zvsUCtADWcoA5tlmFm9WpMfR4n7wzB9fdPcdG8zuw22noXH
	4y2/t5TzLvk5tGdUSKcCSsW41mt7htmCisedFju/5NJYkqqZvgNeDU/pA3gZSB37d2gRWX00nQG
	p1Ju/kCk/2a0PrX6Iz+LhrUP87GaVQaYZBFE65CdnrJrfFBQ
X-Google-Smtp-Source: AGHT+IELEyJ7ZtEblqArl9kpQs2JtvClPLbjLCSfujt4D4IVHS7ig6rYQHSwlaqzVReQpnHBBQn8Ww==
X-Received: by 2002:a05:6000:1862:b0:38d:a948:efed with SMTP id ffacd0b85a97d-38da948f73amr1921320f8f.1.1738682674421;
        Tue, 04 Feb 2025 07:24:34 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38db085ab80sm1040757f8f.26.2025.02.04.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:24:33 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hongxu Jia <hongxu.jia@windriver.com>
Subject: [meta-tensorflow][kirkstone][PATCH 1/3] bazel-native: fix compile failure on gcc 13
Date: Tue,  4 Feb 2025 16:24:26 +0100
Message-ID: <20250204152428.3550416-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 15:24:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1027

From: Hongxu Jia <hongxu.jia@windriver.com>

external/com_google_absl/absl/strings/internal/str_format/extension.h:34:33: error: found ':' in nested-name-specifier, expected '::'
   34 | enum class FormatConversionChar : uint8_t;

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-devtools/bazel/bazel-native_5.1.1.bb  |  1 +
 .../0001-fix-compile-failure-on-gcc-13.patch  | 71 +++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch

diff --git a/recipes-devtools/bazel/bazel-native_5.1.1.bb b/recipes-devtools/bazel/bazel-native_5.1.1.bb
index aa42ba6..c7490fc 100644
--- a/recipes-devtools/bazel/bazel-native_5.1.1.bb
+++ b/recipes-devtools/bazel/bazel-native_5.1.1.bb
@@ -10,6 +10,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://0001-fix-unzip-command-not-found.patch \
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
            file://0001-cutsomize-native-toolchains-for-Yocto.patch \
+           file://0001-fix-compile-failure-on-gcc-13.patch \
 "
 
 inherit python3native
diff --git a/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch b/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch
new file mode 100644
index 0000000..2fce1dc
--- /dev/null
+++ b/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch
@@ -0,0 +1,71 @@
+From 02fcd86787da1ebb2afad1909cb70839cdac24dc Mon Sep 17 00:00:00 2001
+From: Hongxu Jia <hongxu.jia@windriver.com>
+Date: Wed, 13 Sep 2023 10:56:02 +0800
+Subject: [PATCH] fix compile failure on gcc 13
+
+external/com_google_absl/absl/strings/internal/str_format/extension.h:34:33: error: found ':' in nested-name-specifier, expected '::'
+   34 | enum class FormatConversionChar : uint8_t;
+
+Upstream-Status: Pending
+
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ distdir_deps.bzl                              |  4 +++
+ .../0001-fix-compile-failure-on-gcc-13.patch  | 30 +++++++++++++++++++
+ 2 files changed, 34 insertions(+)
+ create mode 100644 third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
+
+diff --git a/distdir_deps.bzl b/distdir_deps.bzl
+index 2ca988e..c460025 100755
+--- a/distdir_deps.bzl
++++ b/distdir_deps.bzl
+@@ -163,6 +163,10 @@ DIST_DEPS = {
+     },
+     "com_google_absl": {
+         "archive": "20211102.0.tar.gz",
++        "patch_args": ["-p1"],
++        "patches": [
++            "//third_party:com_google_absl/0001-fix-compile-failure-on-gcc-13.patch",
++        ],
+         "sha256": "dcf71b9cba8dc0ca9940c4b316a0c796be8fab42b070bb6b7cab62b48f0e66c4",
+         "urls": [
+             "https://mirror.bazel.build/github.com/abseil/abseil-cpp/archive/refs/tags/20211102.0.tar.gz",
+diff --git a/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch b/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
+new file mode 100644
+index 0000000..257e887
+--- /dev/null
++++ b/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
+@@ -0,0 +1,30 @@
++From 4cb33b2e98fd0b2f201e765a5a0d9c1d4277041e Mon Sep 17 00:00:00 2001
++From: Hongxu Jia <hongxu.jia@windriver.com>
++Date: Wed, 13 Sep 2023 11:17:34 +0800
++Subject: [PATCH] fix compile failure on gcc 13
++
++external/com_google_absl/absl/strings/internal/str_format/extension.h:34:33: error: found ':' in nested-name-specifier, expected '::'
++   34 | enum class FormatConversionChar : uint8_t;
++
++Upstream-Status: Pending
++
++Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
++---
++ absl/strings/internal/str_format/extension.h | 1 +
++ 1 file changed, 1 insertion(+)
++
++diff --git a/absl/strings/internal/str_format/extension.h b/absl/strings/internal/str_format/extension.h
++index 55cbb56..67d4cc8 100644
++--- a/absl/strings/internal/str_format/extension.h
+++++ b/absl/strings/internal/str_format/extension.h
++@@ -21,6 +21,7 @@
++ #include <cstddef>
++ #include <cstring>
++ #include <ostream>
+++#include <cstdint>
++ 
++ #include "absl/base/config.h"
++ #include "absl/base/port.h"
++-- 
++2.17.1
++
+-- 
+2.27.0
+
-- 
2.48.1


