Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF6CA0EED
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 10:12:22 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10354.1755598339103483464
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 03:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IYnaQbKy;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so6983582a12.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755598337; x=1756203137; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaHeAFeAer8xp0+ze8OtmfGWDtvMCnCzH8CjPs09ALE=;
        b=IYnaQbKyJs7gCROVHXdQdXlCCaOHUDSSrbuPxUmYnN/VlXdD7bD+QZh5fCNVVwtlkv
         ZU22xw4EmcTpoNTuxN8RoVHlKF2euLPBv0yx73PCBDM29/f5Pm4JqYTbsXF3rdMN9e+4
         8vPQADyM3UWxCD6QdPl06hMrRSsM9LrpQBYSR8ApSvscAkBjDH+3GF+7GozJcWywsr+b
         FGfqeeFupo/0E7YhIDaXh77jOP2vNyTRJGwXR8eVcliQBIK9B5B0X0FmcmIVNVyCIn4B
         L3LQAl23ip1lgnXsYvzDWc3/9DFh9Y1cWSBHrqHxXCXcbOkRWp3bv+c01x07CIJvT572
         FgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598337; x=1756203137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaHeAFeAer8xp0+ze8OtmfGWDtvMCnCzH8CjPs09ALE=;
        b=Tnwfv2FMJn/ZCs33V9M75R5KmtSQONOrNhP27RcW0uG/ZQA17S/zIqH8upM2UCKyHE
         swxzLiqW986S5WAOPqq2f6jLL+EClbu9t5CXXVQ6Orm/bnukUO1Agm1X2Rh23TuuQ44P
         MuDaG/mk9ZV8yMZSvs8IpyMKY28Oky517vIUaYXzyIu9moRqHmRlHZGEgCBlWwUSfgCv
         eK3XPLG6bNnapCta+fhXQFOpmcNrEz2U/n51PCW5SnRQTV+C8mU1zy+m7fSu0e9JWTOW
         UavPN9e2fD9pR2hHoW8y9WM1t3X3/kX3yFK2F1kaRBA/D/WkWDrNSuIcv4/nlIUMGjSx
         HZeQ==
X-Gm-Message-State: AOJu0YxmxIDHiovgN0kbDSATsOZ1BANcxbx046SmmM5onbTM/EclI8hO
	mETFcXDO++iZxD0KkJX2Ns6ZALrNwXaCzVl9NoOZ2wE/oVmFrpeA9FwSO+9dAg==
X-Gm-Gg: ASbGncu36we2MTslgVwPsGbhcEHlmSZf14W+AMZOjNwszVEa9vtdCuWc1Dsz2wz2q94
	WD1GSobl0dMz+fBQagbEqMgYH/PlzvbcTablLo30QK87W2piLt9a40AVXY/Oh9d7QC3tQMLsvJv
	S6zhwbCspp9aVzOBiHnPW89JxILIHFRtT+N1lDS7JXVIKxdvLOSeF1hTuUKcn5w7yMA9J2K2ORD
	YZQj/fp4Jc/xHV7JxfV5XYjfYL11LSz0g2CzgWvfLfWpJw6BEkULwfG0gzjyH2s3063MLwoB8W9
	Z/Hy3bzuEjI1I1pj+6oo8ybvcjYQzYQPVsic87GNXt9G8CdTSKNAEjqxlv28N9ewJvPDOWtEkzF
	qpdhm59tkOzGor22L5DIgNHjojAlMa6/y4frf7qMnGfozLWAfNW14wZlwaupMCzqAzdQ=
X-Google-Smtp-Source: AGHT+IEkkdbgjugffCtMFtGhTvh6jqR5lGp+sWczMmFQHhyTzDB2DOa7VLDjEHu4WxRj9p8wvqE1FA==
X-Received: by 2002:a05:6402:278c:b0:618:229d:707a with SMTP id 4fb4d7f45d1cf-61a7e6d9a35mr1414971a12.6.1755598337188;
        Tue, 19 Aug 2025 03:12:17 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a7577462esm1472430a12.36.2025.08.19.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:12:16 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][master][PATCH] bazel-native: fix build with gcc-15
Date: Tue, 19 Aug 2025 12:12:13 +0200
Message-ID: <20250819101213.2899917-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 10:12:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2054

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
 .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/include_stdint.patch

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index bc63430..4960358 100644
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

