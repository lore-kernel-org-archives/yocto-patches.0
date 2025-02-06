Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A0C02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 14:29:35 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.42574.1738852169778441947
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 06:29:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZaT3ExOa;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab6f636d821so177080166b.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852168; x=1739456968; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krWHlunmdV8WzcndGDMD2lIRLqplFUhY2QGlyhUB/x4=;
        b=ZaT3ExOaonvJAa2KR8vyp8o7HcYEdUNwpfnkoMMPZoTj8etGsTiQneQ/kWGXqnSGlA
         9xHHTTNZSnR9PCphDGUrx6xOqeYnkjOUjW5EXPZaQwZn106sYFob7e5pQeMSmXByPF7k
         NZiqpjDr8SXQ19jUN+sXsmCuawD6QPNhCT6kGJrBbU3rqcDHQ5ngeGh8EgFQN53TshRv
         xtRiDe/J7KwRP+CWwP1YTzWoKWzaO17url5njJnYK66+eeA2QgzX9zsqgTh5IXzll9r3
         Gs9TBm+iNSivK0bE+TaRby0O9MigoJE+rG92K0rCt9p4cHG09cT4DoSxaOOjaRzgVLgY
         /6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852168; x=1739456968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krWHlunmdV8WzcndGDMD2lIRLqplFUhY2QGlyhUB/x4=;
        b=t9bkXwFhMOPGj8+eFlP2kOBsddrzBkZSUkejrWu29NlRm0cQPuvoid1aDIXIxLbcQk
         0PjyzFYbG+cV9HEmUWYejCK7zGfUftoijiswQBZD+sp+DjYFM5097bdGsi8+TevayPBl
         oqonPv5jvX4pOuLkG4NEoyRyLSRQO0VBDZEYIVn0nrpAEKpXWD+zeRj1dDxDrCCgmu58
         zgRAX4lETafHGW+RyCWyamOp3gYffPEOVJCO81txfiaWTdlHpg3qialLwOPvnkDXuLJG
         4DpYPf4PD6YXnuXQmWSdK8KbnLQYITOjHDJJcQaKh97CEER7XlPte51aWXSFWuvvY6jx
         xR0Q==
X-Gm-Message-State: AOJu0YxyxcpDqxXRz5BACjVAFoABV/XTaqV2kKjs45ApwKA3OsHNDq/L
	0NCJrSOcwRCsTmkCeEAy/vxHBpY5H3hboyPZL04UqPCfXsaq1n8kbHxD8Q==
X-Gm-Gg: ASbGncvglqDeiDOfQXH0OBbvNOyVc+9Hr5FcjWQnHHa7+tf9fBCw1xi4aRmMFBQjI5M
	fS9ZSvtpClpfRa00PxdhCCRPMcFpAcoHlDCZZPkfb1JlT3By1GFuZRXEWMAxQzF+2OGhNRYPz7U
	qrJcIsf2AONWcvM1k69G+mhZwptn34Z6AqmmNjv/sdYSOzwQdTAOj72O2/qhvQJHBfV/TUl7Ogs
	ec6Fhof/uQtiWw7kyykrmuSJoH1Hi6BEpwbnr53bzrCO9Xsk2EqXD9CVOhHFmg/2x31/O/vP9ct
	iYUgg+p6SIsy0sATdw==
X-Google-Smtp-Source: AGHT+IHdbbmONqJBaILwrNBzsHIxhugd2yg0myA4N4TcIEePdDgMtMPY26A+fb4WowwW/twrtRrhnQ==
X-Received: by 2002:a17:906:7315:b0:ab6:ed9e:9739 with SMTP id a640c23a62f3a-ab75e313812mr864689166b.42.1738852167755;
        Thu, 06 Feb 2025 06:29:27 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7732e70f8sm107486466b.105.2025.02.06.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:29:27 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anuj Mittal <anuj.mittal@intel.com>
Subject: [meta-tensorflow][mickledore][PATCH 2/3] bazel-native: fix build with gcc14
Date: Thu,  6 Feb 2025 15:29:19 +0100
Message-ID: <20250206142920.17790-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206142920.17790-1-martin.jansa@gmail.com>
References: <20250206142920.17790-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 14:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1043

From: Anuj Mittal <anuj.mittal@intel.com>

Backport patch to fix errors while building zlib. Fixes:

| external/bazel_tools/third_party/zlib/gzwrite.c: In function 'gz_comp':
| external/bazel_tools/third_party/zlib/gzwrite.c:89:20: error: implicit declaration of function 'write'; did you mean 'fwrite'? [-Wimplicit-function-declaration]
|    89 |             writ = write(state->fd, strm->next_in, put);
|       |                    ^~~~~
|       |                    fwrite
| external/bazel_tools/third_party/zlib/gzwrite.c: In function 'gzclose_w':
| external/bazel_tools/third_party/zlib/gzwrite.c:673:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
|   673 |     if (close(state->fd) == -1)
|       |         ^~~~~
|       |         pclose

Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 recipes-devtools/bazel/bazel-native_5.3.2.bb  |  1 +
 ...3ed4ac717b814d02a0d125f160ddabe78003.patch | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch

diff --git a/recipes-devtools/bazel/bazel-native_5.3.2.bb b/recipes-devtools/bazel/bazel-native_5.3.2.bb
index ce3431b..52b6534 100644
--- a/recipes-devtools/bazel/bazel-native_5.3.2.bb
+++ b/recipes-devtools/bazel/bazel-native_5.3.2.bb
@@ -11,6 +11,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
            file://0001-cutsomize-native-toolchains-for-Yocto.patch \
            file://0001-fix-compile-failure-on-gcc-13.patch \
+           file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
 "
 
 inherit python3native
diff --git a/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch b/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
new file mode 100644
index 0000000..0d20e66
--- /dev/null
+++ b/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
@@ -0,0 +1,57 @@
+From 1f2b3ed4ac717b814d02a0d125f160ddabe78003 Mon Sep 17 00:00:00 2001
+From: Yun Peng <pcloudy@google.com>
+Date: Wed, 5 Apr 2023 15:13:26 +0200
+Subject: [PATCH] Patch zlib to fix compatibility with latest Xcode
+
+Fixes https://github.com/bazelbuild/bazel/issues/17956
+
+Partial commit for third_party/*, see #17987.
+
+Closes #17987
+
+Signed-off-by: Yun Peng <pcloudy@google.com>
+
+Upstream-Status: Backport [https://github.com/bazelbuild/bazel/commit/1f2b3ed4ac717b814d02a0d125f160ddabe78003]
+Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
+---
+ third_party/zlib/gzguts.h   |  4 ++++
+ third_party/zlib/zlib.patch | 15 +++++++++++++++
+ 2 files changed, 19 insertions(+)
+ create mode 100644 third_party/zlib/zlib.patch
+
+diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
+index 57faf37165a354..54f668fcb20536 100644
+--- a/third_party/zlib/gzguts.h
++++ b/third_party/zlib/gzguts.h
+@@ -3,6 +3,10 @@
+  * For conditions of distribution and use, see copyright notice in zlib.h
+  */
+
++#ifndef _WIN32
++  #include <unistd.h>
++#endif
++
+ #ifdef _LARGEFILE64_SOURCE
+ #  ifndef _LARGEFILE_SOURCE
+ #    define _LARGEFILE_SOURCE 1
+diff --git a/third_party/zlib/zlib.patch b/third_party/zlib/zlib.patch
+new file mode 100644
+index 00000000000000..7181d44aa9f9b1
+--- /dev/null
++++ b/third_party/zlib/zlib.patch
+@@ -0,0 +1,15 @@
++diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
++index 57faf37165..54f668fcb2 100644
++--- a/third_party/zlib/gzguts.h
+++++ b/third_party/zlib/gzguts.h
++@@ -3,6 +3,10 @@
++  * For conditions of distribution and use, see copyright notice in zlib.h
++  */
++
+++#ifndef _WIN32
+++  #include <unistd.h>
+++#endif
+++
++ #ifdef _LARGEFILE64_SOURCE
++ #  ifndef _LARGEFILE_SOURCE
++ #    define _LARGEFILE_SOURCE 1
-- 
2.48.1


