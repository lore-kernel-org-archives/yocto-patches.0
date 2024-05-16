Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E9C25B75
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 03:03:14 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.4278.1715828585507412126
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 20:03:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T5YKwM6G;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: raj.khem@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f67c6fc504so589356b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 20:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715828584; x=1716433384; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xonoidXPpaMYqZAMnJVlbX7g9Zg8TWMw05Md7b9bFLM=;
        b=T5YKwM6GT1n8uLmkjjj3Qc3sm4B0VqM1w3CB72sIvepSYs0w6VCCtc5U6d6wxtE3hH
         FAoH2Fvh3tPWIR+GgG859406pm+yGz9yiFJQge+Txz8r1uTGwk765mOTRd+PQPqkoi57
         Lj013cUa0z/2E8P4kWk6M4eG2fKlXcJswEYCQ5zF7hp1nWsKnMx+bwxTGB/bL51COGpQ
         NUasuc3K/zbzKokhy93/0UOB7dIkZ2vkqxGMriZkXVwgBfauCMjpXRxwf1g0ZW/UOqVN
         ejuayv7ocdG5nZ26fsjY00HLUgS0YkDS1EIJosJrzyREwa/X8gOIQ3XBjADj5vggwOZY
         /dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715828584; x=1716433384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xonoidXPpaMYqZAMnJVlbX7g9Zg8TWMw05Md7b9bFLM=;
        b=B0gTvDvdn30i8wpnqWyiI/oDenrOGQvVDUfzeItbmwGh1nP7uetn1yvAI3IY8woOCf
         aRSiWJdGyN/jET+ctnnXfG2DCFqKLfCy2NYvmhxgIA+5fK0SOBqwCed0eir322SaeBi4
         SPZii5o90q7G8yFqzaXgIJ3CiuRAYogNCWgqcrmQ8/9fxHQwrr8FCfQi53Kn7PTOtL48
         q1d4oF28jXeThIoTW8dhUopv/o8VWBOombOGzuAe+Zw4JSJtMbmVQBbAFDqOqW1DDlH7
         K0KBmA8Nh+nzLijVN37Mg2EiTKNyfTeslVgfaqsUEunfkVueN6vC5SOmvGkwdwQ7HdUa
         lYig==
X-Gm-Message-State: AOJu0YxGpTdmMMr3QA4vWH6I+2wrJ2047NAmnosxdIzVE33d+oikSVim
	zTGMPcVHGNUWsXqaSMKkrmH4A7thOMHcBxuw6nSAisZGOrVPYTiJcUIPFH2jxiM=
X-Google-Smtp-Source: AGHT+IE6DvNfXuX7idqAwPehbyHqImWDxkMzgAyaSiOI5T1CwKXcQ07W6aOfQjYM+px+JlPyGGYtfQ==
X-Received: by 2002:a05:6a20:d486:b0:1af:8df6:bdad with SMTP id adf61e73a8af0-1afde0d2498mr17694596637.17.1715828584377;
        Wed, 15 May 2024 20:03:04 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::6fff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03aadbsm126194495ad.227.2024.05.15.20.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 20:03:04 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org,
	jpewhacker@gmail.com
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [meta-mingw] [PATCH] nativesdk-mingw-w64-runtime: Fix build error/warning -Wincompatible-pointer-types
Date: Wed, 15 May 2024 20:02:57 -0700
Message-ID: <20240516030259.3422982-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 May 2024 03:03:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/157

This pops up with gcc trunk

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 ...in-the-ucrt-__imp_vfscanf-assignment.patch | 30 +++++++++++++++++++
 .../nativesdk-mingw-w64-runtime_9.0.0.bb      |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100644 recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch

diff --git a/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch b/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch
new file mode 100644
index 0000000..bc41482
--- /dev/null
+++ b/recipes-devtools/mingw-w64/files/0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch
@@ -0,0 +1,30 @@
+From b0dcc496228373417e4f6134beb2f13ca3ed807e Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
+Date: Thu, 5 Aug 2021 11:08:39 +0300
+Subject: [PATCH] crt: Fix a typo in the ucrt __imp_vfscanf assignment
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+The wrong function was assigned; this was a bug present since
+0dd9563a3ad71ad75cab1699ba5cfef2dd0bf9d8 (April 2021).
+
+Upstream-Status: Backport [https://sourceforge.net/p/mingw-w64/mingw-w64/ci/b0dcc496228373417e4f6134beb2f13ca3ed807e]
+Signed-off-by: Martin Storsjö <martin@martin.st>
+---
+ mingw-w64-crt/stdio/ucrt_vfscanf.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/mingw-w64-crt/stdio/ucrt_vfscanf.c b/mingw-w64-crt/stdio/ucrt_vfscanf.c
+index fe44cdf71..8d1a76a8b 100644
+--- a/mingw-w64-crt/stdio/ucrt_vfscanf.c
++++ b/mingw-w64-crt/stdio/ucrt_vfscanf.c
+@@ -11,4 +11,4 @@
+ int __cdecl vfscanf (FILE *__stream,  const char *__format, __builtin_va_list __local_argv) {
+   return __stdio_common_vfscanf(0, __stream, __format, NULL, __local_argv);
+ }
+-int __cdecl (*__MINGW_IMP_SYMBOL(vfscanf))(FILE *, const char *, __builtin_va_list) = vsscanf;
++int __cdecl (*__MINGW_IMP_SYMBOL(vfscanf))(FILE *, const char *, __builtin_va_list) = vfscanf;
+-- 
+2.43.0
+
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb
index e2ca6a5..1aa470e 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_9.0.0.bb
@@ -2,6 +2,8 @@ DESCRIPTION = "Runtime libraries from MinGW-w64 project"
 
 require mingw-w64.inc
 
+SRC_URI += "file://0001-crt-Fix-a-typo-in-the-ucrt-__imp_vfscanf-assignment.patch;striplevel=2"
+
 S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
 B = "${WORKDIR}/build-${TARGET_SYS}"
 
-- 
2.45.1


