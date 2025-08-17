Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC7CA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 20:44:23 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.60475.1755463458606148937
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 13:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QLHLDhpK;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so6254155a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755463457; x=1756068257; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3k5F/RdfDHPDHvswf2I5yr/8Kxngwrm9suHqHY0VAI=;
        b=QLHLDhpKkW6oaGvh+U984OOlQOhvGJR1PNyPQHVZJM7mpeW5N55qxO+nq2dspwoKLc
         Chi+5GWkeADp5oEt6TS8KZsHkDorEzU4xCmqtht+6WF2A5w66fXtQmxM0g1fERo6yGkV
         wnjeZ50YGKgorypmkbj9jm7lYiottFvECW2dSYtlJ+9CExUf0CGBTGJK4qJeX/9KHS81
         UQLL/zsfUI+zlf1eJwEL7xbDKfNvWD/SRIPt7fjuda95buglAiW+qSUUzZyOz2RVCW3d
         akg5CQZYv2/BCviFh4uJQPK9pRPpkuqIFLGJNzTyVXL3pDWfYBGnVKg0d4Yl/tdpiNDA
         zzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755463457; x=1756068257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3k5F/RdfDHPDHvswf2I5yr/8Kxngwrm9suHqHY0VAI=;
        b=Ehj/9jBN1SydUtho8dpLnYkJkMq9q+jJuVsQjMK2yzhAMb+2ShH/iNFKLAiNljk+0F
         WEcrgwJBNME5DslLhvSAxw/mSYiwwj3zVjZEEkXl8EVg3LVd6bYhZZLXI23Hvgrwcqgw
         pm0Eg50CoAU0jpcJfyBnO4G02Bsja2hbnxkMmYZSOcdq4jvPnR8yH12zj7pzDPBrsboI
         gThABp0Ovq9bnl7oqlNbwqHNuMMpbtURhJddgWYyWkRVGYIAyP3EpFPcmfgRW9iqEBgJ
         hIIRTowr/occDyCv1q+zX3wvVQX3ajb8zDnrZWZThmRPVTtdAGq+YqLofzhGFz+uknsO
         96NQ==
X-Gm-Message-State: AOJu0YzI+pYt35qkI/+OymyyuvjzPFCLzwts9DdbAAwsX9qlluVQcIBm
	+BWEpkaRsT0TpAmsolSvi8QgsWLeaJpzQdCNTQKqNejXiiejCoBtMtRJFDJtKA==
X-Gm-Gg: ASbGnctVnBPQ4NnxTCmP0SAPiiDgsiewtScObtphiWuA/rLiy9meUtjdKow5+gqH9xA
	V3gQLwODmVizYxpmiuajZbZZgjFufenCg0l8k0iZLWsXDJk8Em0TdtOkt3gfyHLNJmqtp0w7TjV
	do+WFtGOmScH4IzbjFWpgRvG/SyLU+jAgCELFD3UEUPfqpxLp3ETruGnYNi5M7urlXIwV8hHAz6
	yRfdJ4P/6SCbAbZDkjsWDPQmAEnawmjC7SQ75s2QiFA9V/VZojPLLmRCRVz46RD9Qa64XT/S+ND
	PrOfpt7LmVmpn2qsLVBah4788TCHpO8HjcJrXKmGzYQY6JzgNzXE67ZkOsl76kIbcY6/z9tZRq2
	Y/9N2vaNcIe6DghGfoD81tnyfPA==
X-Google-Smtp-Source: AGHT+IHEYLqv8EVpMYF+1c9UJIld+mk3fucagUcgPwocoBhJ7u2tZ1K5l+kiGNY5QmP0pz1sJwSpRQ==
X-Received: by 2002:a17:907:9727:b0:ad5:8412:1c9 with SMTP id a640c23a62f3a-afceae4948dmr503565266b.59.1755463456506;
        Sun, 17 Aug 2025 13:44:16 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdce72de4sm680440466b.30.2025.08.17.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 13:44:15 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCH] bazel-native: fix build with gcc-15
Date: Sun, 17 Aug 2025 22:44:08 +0200
Message-ID: <20250817204408.3814451-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 20:44:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2021

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
index 0000000..78b7ba1
--- /dev/null
+++ b/recipes-devtools/bazel/files/include_stdint.patch
@@ -0,0 +1,28 @@
+https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde26df426e12/bazel7/include_stdint.patch
+
+Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues/25514]
+
+diff --git src/main/cpp/archive_utils.h src/main/cpp/archive_utils.h
+index 18856ab..5298a36 100644
+--- src/main/cpp/archive_utils.h
++++ src/main/cpp/archive_utils.h
+@@ -15,6 +15,7 @@
+ #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
+ #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
+
++#include <cstdint>
+ #include <string>
+ #include <vector>
+
+diff --git src/main/cpp/util/logging.h src/main/cpp/util/logging.h
+index b2cd459..7bf5a00 100644
+--- src/main/cpp/util/logging.h
++++ src/main/cpp/util/logging.h
+@@ -14,6 +14,7 @@
+ #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
+ #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
+
++#include <cstdint>
+ #include <memory>
+ #include <sstream>
+ #include <string>

