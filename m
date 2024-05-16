Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0720C25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 03:40:44 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.4955.1715830828780779810
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 20:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=m2YkX9A2;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecd9a81966so60202625ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715830828; x=1716435628; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5DoOnIYs3+Neis/J+VkG3Sui7JsPmcSBeX5Ox0kcrQ=;
        b=m2YkX9A20Y3Jm4UFiFjyQyva243eyRLN6G7sB+oUupFAPXyNMYOoTGDjkTDRVtZIF3
         B2MQGXlhVG0DFYkK1srP7FcJGQDgG3yLx9jfWn1DXtcA8jOOrrdgp8t48MdcfRrOB5Ja
         FE42aBnuqyRq59ehPGWsFjovfSJAvIyQtcgNPGqtNoMNZ6TyNR2OEq5nANZL/DLZaV+9
         mEDS833hpdDbZuKE1T7oXQg8rO/3ZhsbUdwLOhqL2sGOnJ4uuLo9JXusuTnvgDTKkdbc
         NT/xHOApWa2LwSnFOy7iq6w1tw+MUpvjwXeZ/H54ynw7EheCyIx2ZDHc08Ql9irFh0UT
         Z8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715830828; x=1716435628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5DoOnIYs3+Neis/J+VkG3Sui7JsPmcSBeX5Ox0kcrQ=;
        b=TDkJVzS/gq6t6OtBcwA3xAy+JqMrDyUC1Xe5CIE85HIHnx7Qo/Zw9j2XvzUOAJG/g8
         RiqEe+xjHzkWSlOae+yjObomEseaYMmSFqV2SiWZafp38VHZBL1EoFc3SQbErFmzt/D8
         FirZu3diDj1gVPw0JqEl1amHN/1GE2sbcMXjwi8BqCSIFmoVNVN2T62gjflQRugG572j
         NznbZ5qjtOqhgIHoOsb4SwXmIHmzZJTK9vd3G6y1GjnysRZkDcZZ9jF9fvkEolXzTDQq
         BVH58/iZeXDcKYyzrBWXlwzzcZgzwBAflZ9due5g6swbsiMcr/KFMyFgSJIfR8VDoXbM
         t9Iw==
X-Gm-Message-State: AOJu0YyywQXQVGGfCnkk67TvanRdnsqptxp9KDxUKD+LxzprpzCqa+AG
	XkxwOkP5yrC28xfiCkK7rCv2a9LN8FDGbzLNJChlf35eqWSnGgwq511YjSgMZ/s=
X-Google-Smtp-Source: AGHT+IH/TD8epgj5UwzOPCWLgZ0SfWOirVtF5jFmwbYKRkIZyJzK4CiZ8MCDWe62583surhVCICsBA==
X-Received: by 2002:a17:903:2282:b0:1f0:8cbf:c1b5 with SMTP id d9443c01a7336-1f08cbfcffamr82900285ad.16.1715830827791;
        Wed, 15 May 2024 20:40:27 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::6fff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036347sm126888065ad.203.2024.05.15.20.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 20:40:27 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org,
	jpewhacker@gmail.com
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [meta-mingw] [PATCH] mingw-w64: Upgrade to 11.0.0 release
Date: Wed, 15 May 2024 20:40:21 -0700
Message-ID: <20240516034023.3614113-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 May 2024 03:40:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/158

Drop GCC-14 related backport, its not needed anymore

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 ...in-the-ucrt-__imp_vfscanf-assignment.patch | 30 -------------------
 recipes-devtools/mingw-w64/mingw-w64.inc      |  2 +-
 ... => nativesdk-mingw-w64-headers_11.0.0.bb} |  0
 ... => nativesdk-mingw-w64-runtime_11.0.0.bb} |  2 +-
 ...nativesdk-mingw-w64-winpthreads_11.0.0.bb} |  0
 5 files changed, 2 insertions(+), 32 deletions(-)
 delete mode 100644 recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-headers_9.0.0.bb => nativesdk-mingw-w64-headers_11.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-runtime_9.0.0.bb => nativesdk-mingw-w64-runtime_11.0.0.bb} (86%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-winpthreads_9.0.0.bb => nativesdk-mingw-w64-winpthreads_11.0.0.bb} (100%)

diff --git a/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch b/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch
deleted file mode 100644
index bc41482..0000000
--- a/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From b0dcc496228373417e4f6134beb2f13ca3ed807e Mon Sep 17 00:00:00 2001
-From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
-Date: Thu, 5 Aug 2021 11:08:39 +0300
-Subject: [PATCH] crt: Fix a typo in the ucrt __imp_vfscanf assignment
-MIME-Version: 1.0
-Content-Type: text/plain; charset=UTF-8
-Content-Transfer-Encoding: 8bit
-
-The wrong function was assigned; this was a bug present since
-0dd9563a3ad71ad75cab1699ba5cfef2dd0bf9d8 (April 2021).
-
-Upstream-Status: Backport [https://sourceforge.net/p/mingw-w64/mingw-w64/ci/b0dcc496228373417e4f6134beb2f13ca3ed807e]
-Signed-off-by: Martin Storsjö <martin@martin.st>
----
- mingw-w64-crt/stdio/ucrt_vfscanf.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/mingw-w64-crt/stdio/ucrt_vfscanf.c b/mingw-w64-crt/stdio/ucrt_vfscanf.c
-index fe44cdf71..8d1a76a8b 100644
---- a/mingw-w64-crt/stdio/ucrt_vfscanf.c
-+++ b/mingw-w64-crt/stdio/ucrt_vfscanf.c
-@@ -11,4 +11,4 @@
- int __cdecl vfscanf (FILE *__stream,  const char *__format, __builtin_va_list __local_argv) {
-   return __stdio_common_vfscanf(0, __stream, __format, NULL, __local_argv);
- }
--int __cdecl (*__MINGW_IMP_SYMBOL(vfscanf))(FILE *, const char *, __builtin_va_list) = vsscanf;
-+int __cdecl (*__MINGW_IMP_SYMBOL(vfscanf))(FILE *, const char *, __builtin_va_list) = vfscanf;
--- 
-2.43.0
-
diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
index ce5d0db..f5fa730 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -5,7 +5,7 @@ COMPATIBLE_HOST = ".*-mingw.*"
 
 SRC_URI = "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${PV}.tar.bz2"
 
-SRC_URI[sha256sum] = "1929b94b402f5ff4d7d37a9fe88daa9cc55515a6134805c104d1794ae22a4181"
+SRC_URI[sha256sum] = "bd0ea1633bd830204cc23a696889335e9d4a32b8619439ee17f22188695fcc5f"
 
 UPSTREAM_CHECK_URI = "http://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/"
 UPSTREAM_CHECK_REGEX = "mingw-w64-v(?P<pver>(\d+[\.\-_]*)+)\.tar"
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_9.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_11.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_9.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_11.0.0.bb
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_11.0.0.bb
similarity index 86%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_11.0.0.bb
index 1aa470e..6d01d35 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_11.0.0.bb
@@ -2,7 +2,7 @@ DESCRIPTION = "Runtime libraries from MinGW-w64 project"
 
 require mingw-w64.inc
 
-SRC_URI += "file://0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch;striplevel=2"
+#SRC_URI += "file://0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch;striplevel=2"
 
 S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
 B = "${WORKDIR}/build-${TARGET_SYS}"
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_9.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_11.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_9.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_11.0.0.bb
-- 
2.45.1


