Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249AC02197
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 15:24:48 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.118617.1738682678631733665
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Feb 2025 07:24:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cbdQwnco;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso40059045e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738682677; x=1739287477; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYYZo4SI7EkrGSwc8O7IonRK2oyhrYxdT+QsMu3x32k=;
        b=cbdQwncoFqryM6Z2AtLnlxFY4rDd6EASUojfGDVBEQ74rVr8BNpzAoAgOXC9HVh29N
         oRLXPAf57RAg4YKDHUzZznNIDIUojmf4T8LdS8ip7EBNZgIQzUxvrSn2A4RqthOM/iCd
         Jy3NwcUL3EJ0EYTE6nN2KZrfLXPwCIMtIpzOSniWmmnaCFozudKIhfcP4ndkRRWZanMA
         53Gka00Kf5l1udRmHjzw3zI3y54ll07rS/xTtbz9Mv/LTLGBfynYgI7CW+T6HbFAfCXM
         jRwqETdmjQvHPVw7hB4qMO9qHxik4EHXjOvR4UwiECSN4n/Ac9CTBbW1y8grMZQ4kRBc
         sxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682677; x=1739287477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYYZo4SI7EkrGSwc8O7IonRK2oyhrYxdT+QsMu3x32k=;
        b=PWiisur1ZkdWMifOOMj9y6DW71gkDxykQWI4Dgie9cz5FVinGPEBXwD/Jot6Nlm65E
         JXF2CweVQYl4SxWVwZoxCI2/FaGvEYnZolQxqHHHlOxL/+0qbI+OCB7BG94SHDmM/TSh
         jpHnQIo4LWRYzGM3SX9dhEutjrxdLko88aTZO6ijOxvIT4c/pDwDu/RnlOKxeVWJXKtS
         rX5Du+0oPplTjLDChowox5TFiWkQWePYkGE1hsipif3fUhANpf6dE6k5bbBUjhuS+QyR
         XISrueb5WAhNL+L8DSM3vHk0ND1C7kQhOV6oeL7gDFE0P02BqtvOHouFAefbHFuugQAi
         XsbQ==
X-Gm-Message-State: AOJu0YzPQ/OqvqOI/jYAg6ZpC6Jsz2NFMqrNzx2ToUPEEGdSxoGZQ+Wv
	unzwxOZn2MVBzoVVLFQliOf5WpArQXGpobEzBkA1jKnFxM6g4P19wIhfTw==
X-Gm-Gg: ASbGncvvyI/mmuRRLactQHx1sOMzBPe4Dxx0Yi/lfmU70lIJCYTXGPl9ti/3+JCjvkX
	+eTVl6hl9mBNSrkNs5ijR8SLKXu6z83/zv7WK+0wHAyZXq3/l8YFu2MqwGCYc3kU48WQZJWLJO6
	DSMAiyFkNhSW+p7NPg/I0me6RbVVxuliOace/BO8pqb4+qLXEiX2cXF4LV6s7Kq7/U7TnVt9tlJ
	KL8pXtE4zwaqHtisM/lMBpTga5NLaCAicOKM1fu3TSXi21jwUl65c4cf+pa8FG0JKvME5YUPyJz
	ZOG1UqoUv6P5CuaSadgpWj/gStRW6y9mq4DG/sYjhPHah0mG
X-Google-Smtp-Source: AGHT+IFwmIHNa681u8Dy04nz0oHO6Ms77E/9hcTdafLhtFL6rqr15oTFsAngoIqgrVbkRJQsURN/XQ==
X-Received: by 2002:a05:600c:3ca1:b0:434:fafe:edb with SMTP id 5b1f17b1804b1-438dc41002cmr205288045e9.24.1738682675383;
        Tue, 04 Feb 2025 07:24:35 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38c5c0ec886sm15944667f8f.1.2025.02.04.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:24:34 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anuj Mittal <anuj.mittal@intel.com>
Subject: [meta-tensorflow][kirkstone][PATCH 2/3] bazel-native: fix build with gcc14
Date: Tue,  4 Feb 2025 16:24:27 +0100
Message-ID: <20250204152428.3550416-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204152428.3550416-1-martin.jansa@gmail.com>
References: <20250204152428.3550416-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 15:24:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1029

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
 recipes-devtools/bazel/bazel-native_5.1.1.bb  |  1 +
 ...3ed4ac717b814d02a0d125f160ddabe78003.patch | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch

diff --git a/recipes-devtools/bazel/bazel-native_5.1.1.bb b/recipes-devtools/bazel/bazel-native_5.1.1.bb
index c7490fc..64acb01 100644
--- a/recipes-devtools/bazel/bazel-native_5.1.1.bb
+++ b/recipes-devtools/bazel/bazel-native_5.1.1.bb
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


