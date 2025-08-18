Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22FCA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 14:38:18 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.76761.1755527889181868292
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 07:38:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZUnOqFXB;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb731ca8eso696307966b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527887; x=1756132687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/ZCTD3CoBmIo1m3aJNcQF+7G4PwkX5UZGvAuuIN1NQ=;
        b=ZUnOqFXBVUQW9zjTE1qn9UXoZP3rZbQ+ZlX3ieZ7ymVK99ffl24murgmLFqG93If17
         cMlZV+l5egockgqL9K55eouAV+xlKtVCFgQiw4wFF0azbm8NRAV1UAROTgAxL/+cMlzM
         ESW8mD6wKmCng7RQhsATzCn2DD2k+UVf6yQki2hzKn9KFG0uvC4uludASEjOVJANz2+Q
         GWPSxSwujhFWUrsEb+Fynq1qHWlw+4TTR2F7BJZ4i7OixH+SUw3cZnHEitQoNIaaDJNi
         ++4ULAXc2tEbDkY/WYKzwgibmvkEWsH6q5ZslC3lBBczLqawagaU/aGW9WigVD/ez74w
         c2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527887; x=1756132687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/ZCTD3CoBmIo1m3aJNcQF+7G4PwkX5UZGvAuuIN1NQ=;
        b=sgYu/bgyZEs07cV+wX8uaRR5fC86AK/21yR8XTdplNQpg6BC2TVBKI2f0POjA0Rr+C
         uiVTNhlXznBivkN71JD0yMma6m2jlSounsh+ehXjxQnvEhELprP/7fRz7e1rU6BYU427
         4VbgkmKwHiHk1kM4+jnYI9nVuWxujHM8EJ6cKFODVP7RCYwhcEqQQsCi/sifKFopwnvX
         4PVxoP5Uubp9SCQ2Jym8rOip+a+ysxPKyW2i/B9ARniBro1CRNjYLmF/+/0VjiTP6thI
         RVq+X65n3tPm76SljhqhHH0KMuAHAW7X6kxksELDphOb27qNMMaObpWRdBRZarkZZx+h
         7euA==
X-Gm-Message-State: AOJu0YwH7pfpqSJr214UN26Ku3V1DI9p/KVEzeaMOCzDjFQXh2zKHUKw
	EGphBc5B13iuBx8W9rRBFVQzlG+5u1BBJn6hQvUtn/lBBgMCxsgWj6mKkDnlXQ==
X-Gm-Gg: ASbGncu19kG+WoXCp9vSow2loHlapAp+G4Y4G+qxUX+MqDJNxULrdiemaxTyPqOegnO
	KDiW6buPqscOVowO65OtV7ka7UWE0mhfnw9OeC6WyGz3Pi0nlukhlmV9ob/Mai9m06ZVai64h2o
	4z1mDZGGd4reNN8BV1LwnBvIgN0Ha3XAmkPX2PChdKifzmzd8A9GTzap6exKPwjojdmJcnyJckv
	qXDKHd9+DxChABnmCDlLRzdj6wXKcrCDh4EzcQ3Bd9txJWRY7W+nWUXJktUW9hCPt+la+QlAV/W
	6l5p20PPCrniYK5pfG2wLCQOpeb3WYT+Kw013peTMDPf/+cmOyFho1/wrt8zu7Vkt/atRMANSvL
	elKgVTXeMXDFcJckILZHb6HnpEd07PBpCQzanfrY1jXJ1Mlj+3ElgXD3M
X-Google-Smtp-Source: AGHT+IEysKE6cCRAd9+oGoXgYIYy3ALROsquBOQJIZ715H1tTNMJFtH9Y3u1ZKpUD6nxXiLHdyRyMQ==
X-Received: by 2002:a17:907:6a13:b0:ae9:bf58:4190 with SMTP id a640c23a62f3a-afcdc1f8f21mr1135689866b.4.1755527887250;
        Mon, 18 Aug 2025 07:38:07 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdce72d51sm823060766b.40.2025.08.18.07.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:38:06 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][walnascar][PATCH] bazel-native: fix build with gcc-15
Date: Mon, 18 Aug 2025 16:38:03 +0200
Message-ID: <20250818143803.908059-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 14:38:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2035

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
 .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/include_stdint.patch

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index 19b411b..a0daa3b 100644
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

