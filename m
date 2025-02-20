Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E9C021B3
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 20:46:18 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.7675.1740084377950382968
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 12:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SHdLnqGx;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72714016741so776079a34.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740084376; x=1740689176; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSeQFD55xYOngJJkE1/yALnxr/jRPzqXZ089DQVhr24=;
        b=SHdLnqGxzoTWwcN1JdL64PVQxchhY5qWhxy6osW8TxZox47BXgxnz/0KXEB8FRFBN1
         3fm1ZKrhzfjKLcBWri263kukyRA3gIrVUB6/8te3sHqqa/oqdDfn9igsJK+qXST0mAYW
         hpUTRjoV08x4SGScxbQQN2B0/uQjNgH1BPJz3k22zoamO49BdtpItC+QAw1v0NJTq24Y
         a5IqquefVU/VkwmrsYsuplAhJeZGxtxs41UZ+jgz9CAtMTEIwS9z8TkTQ6tdjQfM/WE6
         6u9gRQxeJ14u07j24HG5sqHOZj9/EAsT/3JajqKvNnuBbMpEjzvhxQsp7BmDTiwzfcoE
         QYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084376; x=1740689176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSeQFD55xYOngJJkE1/yALnxr/jRPzqXZ089DQVhr24=;
        b=qj6RKhSuAUcv0UqdIi5tUdrDRupNzZZbHQGYUNYh+a6svJ5YTQ6M+2dayKTgHZDkTe
         jdX3z+O9VBb0ewjwsZLalFP+OSrpY8SV1YxSXAfDaMfGmPXSnZLT94aYBkwRtpvl08dH
         k8LjYFlBdTiUQdxa3ETN/mNo/LmgTw2qqlOJ5y79TCwgy1dcAxthk7EktykmjGjv71ss
         R1nz5UZbkNP7g2snHCRhll1tEDb9WV+lBgI/sXFDbRwzxep9Xo9omK6IcJJG1+eBVUPT
         dfTJ9c27VqB80AYqXRdw8JMdtbwYZLH8/ZSEVeB/FUo+2WpMhKFN3smta1Fw6vwXvAKU
         50jA==
X-Gm-Message-State: AOJu0YwS4LAmdnwnIDYppsUiySUppoyx+nscjpK8A0rDM1GwbkUXyIr7
	zJJ9YOs2uawSLquU03bM9eai2tAnwznSprxd00o1L2FqaOs7vMSxp/drF+G6
X-Gm-Gg: ASbGncszAZbj9EIknwgRXj8nVUtZ05pousag3148JvEnXdnMQ6CNAfVHdax7UDf9AjO
	fvgGP6D3WmfIp/txBXc7XxV3BX53C3DnlMNQ/5QebHxBZXHJnGtVaIi49b2li0yWzLMVj4l18Ii
	R9Xf/WwHDqdwLjD1fNOhgfL1wuQ87Xngg+/6REF1CEZ4loKqsjhoRW5/WpTotSMLdCLFBXE93UR
	ol2vxkh8oZMI3alZhRqSXUxW36IaFOdL4WztjTvoIzNl3nr7dTeL6lUwVDNnEkunoqY9T2Wpuwk
	OY5KJCarUbJk8A==
X-Google-Smtp-Source: AGHT+IEBEFjvmNUh88bjF7oNDVi1Awr+L5bC0svxWxs1o/4hUfhwdsnIZCld4f0K+ju8laUPlLAjlQ==
X-Received: by 2002:a05:6830:f86:b0:727:2cbb:9be6 with SMTP id 46e09a7af769-7274c4a1b5dmr433239a34.5.1740084376288;
        Thu, 20 Feb 2025 12:46:16 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::db07])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727354673bfsm1488769a34.9.2025.02.20.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:46:15 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] diffutils: Refresh patches
Date: Thu, 20 Feb 2025 13:46:10 -0700
Message-ID: <20250220204610.2842086-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 20:46:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1106

Refresh the diffutils patches for the latest version. The stricoll()
patch can be dropped as upstream removed usage of stricoll()

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 ...01-sdiff-Match-execvp-argument-types.patch | 27 +++++++++-----
 ...efine-stricoll-as-_stricoll-on-mingw.patch | 37 -------------------
 .../diffutils/diffutils_%.bbappend            |  2 +-
 3 files changed, 19 insertions(+), 47 deletions(-)
 delete mode 100644 recipes-extended/diffutils/diffutils/0002-Define-stricoll-as-_stricoll-on-mingw.patch

diff --git a/recipes-extended/diffutils/diffutils/0001-sdiff-Match-execvp-argument-types.patch b/recipes-extended/diffutils/diffutils/0001-sdiff-Match-execvp-argument-types.patch
index 2dff6db..935e435 100644
--- a/recipes-extended/diffutils/diffutils/0001-sdiff-Match-execvp-argument-types.patch
+++ b/recipes-extended/diffutils/diffutils/0001-sdiff-Match-execvp-argument-types.patch
@@ -1,7 +1,7 @@
-From 197c0c72a6cb60a647db02c2874a8103be4557d6 Mon Sep 17 00:00:00 2001
+From 4e1aa44797f5629d4654623235c06ec3331b3749 Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Wed, 29 May 2024 10:58:54 -0700
-Subject: [PATCH 1/2] sdiff: Match execvp argument types
+Subject: [PATCH] sdiff: Match execvp argument types
 
 Fixes build with GCC-14
 
@@ -16,22 +16,31 @@ Fixes build with GCC-14
 Upstream-Status: Submitted [https://lists.gnu.org/archive/html/bug-diffutils/2024-05/msg00003.html]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
 ---
- src/sdiff.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
+ src/sdiff.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/src/sdiff.c b/src/sdiff.c
-index 0b638d4..a4642b1 100644
+index 07b4510..7ccdbe8 100644
 --- a/src/sdiff.c
 +++ b/src/sdiff.c
-@@ -576,7 +576,7 @@ main (int argc, char *argv[])
+@@ -573,7 +573,7 @@ main (int argc, char *argv[])
        diffarg (argv[optind]);
        diffarg (argv[optind + 1]);
-       diffarg (0);
+       diffarg (nullptr);
 -      execvp (diffargv[0], (char **) diffargv);
 +      execvp (diffargv[0], diffargv);
-       perror_fatal (diffargv[0]);
+       perror_fatal (squote (0, diffargv[0]));
      }
    else
+@@ -636,7 +636,7 @@ main (int argc, char *argv[])
+                 close (diff_fds[1]);
+               }
+ 
+-            execvp (diffargv[0], (char **) diffargv);
++            execvp (diffargv[0], diffargv);
+             _exit (errno == ENOENT ? 127 : 126);
+           }
+ 
 -- 
-2.45.1
+2.47.1
 
diff --git a/recipes-extended/diffutils/diffutils/0002-Define-stricoll-as-_stricoll-on-mingw.patch b/recipes-extended/diffutils/diffutils/0002-Define-stricoll-as-_stricoll-on-mingw.patch
deleted file mode 100644
index 23807c6..0000000
--- a/recipes-extended/diffutils/diffutils/0002-Define-stricoll-as-_stricoll-on-mingw.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-From 9e1318440a5f7f4a00f077fc3cbd1edc07e0985d Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Wed, 29 May 2024 21:20:12 -0700
-Subject: [PATCH 2/2] Define stricoll as _stricoll on mingw
-
-* src/system.h: Define stricoll as _stricoll on mingw.
-
-Upstream-Status: Submitted [https://lists.gnu.org/archive/html/bug-diffutils/2024-05/msg00004.html]
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- src/system.h | 10 ++++++++++
- 1 file changed, 10 insertions(+)
-
-diff --git a/src/system.h b/src/system.h
-index b37893f..4c7a318 100644
---- a/src/system.h
-+++ b/src/system.h
-@@ -63,6 +63,16 @@
- #include <inttypes.h>
- 
- #include <string.h>
-+/* stricoll is not provided by any headers on windows/mingw
-+   only _stricoll is provided, the function is however aliased
-+   to provide stricoll in runtime libraries, the configure check
-+   to detect stricoll defines the prototype in generated test
-+   itself and thus test passes, however compiling fails with
-+   GCC-14 which enables implicit-function-declaration as error  */ 
-+#if defined _WIN32 && ! defined __CYGWIN__
-+#define stricoll _stricoll
-+#endif
-+
- #if ! HAVE_STRCASECOLL
- # if HAVE_STRICOLL || defined stricoll
- #  define strcasecoll(a, b) stricoll (a, b)
--- 
-2.45.1
-
diff --git a/recipes-extended/diffutils/diffutils_%.bbappend b/recipes-extended/diffutils/diffutils_%.bbappend
index 284f8cb..177809b 100644
--- a/recipes-extended/diffutils/diffutils_%.bbappend
+++ b/recipes-extended/diffutils/diffutils_%.bbappend
@@ -5,7 +5,7 @@ CFLAGS:append:mingw32 = " -DSIGALRM=14 -DSIGHUP=1 -DSIGQUIT=3 -DSIGPIPE=13 -DSIG
 
 SRC_URI:append:mingw32 = "\
        file://0001-sdiff-Match-execvp-argument-types.patch \
-       file://0002-Define-stricoll-as-_stricoll-on-mingw.patch"
+       "
 
 do_configure:prepend:mingw32 () {
     # Remove building of "man" and "gnulib-tests". The tests don't
-- 
2.47.1


