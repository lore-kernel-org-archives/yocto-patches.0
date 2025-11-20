Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B40CFA447
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 21:03:57 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5060.1763672633633642807
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 13:03:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QRgTjkUv;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b30bf0feaso73718f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763672631; x=1764277431; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2r9EYkjJY0I12kIpnAeH+8H8UceY6FmVLUbZiN4WvvQ=;
        b=QRgTjkUvC690ycbKepGi7YBRhFP0njloVSxyvVJjk/qabIeRYFk6LWczIVDJ31etuS
         jx0jyFzoDUy8VZvVGfB7mfhEqvxqN0ftxkRzfXqK3HANmTovpEZXjL13SO1O4yqWlN8q
         rAszyENTaHpC5wsg/r2Xbq36uVvi6WH2o6owQL2LlEOzbIcQoNqm3slyQu/vBHT8Qf2i
         Yk+aZz7dqJqXCneO5SshI0HKdxINuThDKDjO+/omWVJpTiAY5oehltMsIhRAsaTozDrP
         lnLMHyibWA/bSnZkSNfbRcbW2RAQ4q/S2UEd8xVa/hGgzT1vfjEhxsKsA30wCzjPGJiF
         7qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672631; x=1764277431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r9EYkjJY0I12kIpnAeH+8H8UceY6FmVLUbZiN4WvvQ=;
        b=TVmISsc1DZ4prqUC6nEDi8HfA+CcurfFaHQUP5/zoRUGpHGXZBd0p6h1oYkQWQ+ebI
         LSg5OtpL4eyd18b7PbbGCyze8kUhuKfUGTuxiW8lRMzkuwVT79YSQPixMAYyeJKw6zwV
         S9Z1qkMsdq9xcTvQrRU1G6msL6d/ZAHY9wG8dns5xrkFZKzorAVXxRUILoXCdrxdGJP7
         1gKFxFAB5nbz/KCNjAfiF1Dzf+0JLa5Rlwg1hJyFZQwGbhG8lLEDYVSr7vIClRlT+/AH
         FfLi9LC7x+rG/d0hP/2wyVNfzjFiY9cNIXZ+NsupTJOlxcBJilejLxbNxnFZSTVFQDxQ
         4Uqg==
X-Gm-Message-State: AOJu0Yy2B71+YrvFlLiV45aAwoOd63iSGydbkkAkfNvhsUaf+NsUeo26
	QubHsS4r4rjG4YcUM8koK2kia0k3XZ5wsj3Kf7AKWT9aUw7vcEfXgpkyTOTZum5+oTw=
X-Gm-Gg: ASbGncttH0MYdVV2OKC8MXKpKp15ydmv4QJJw/oy62FAQzIjjHzmc3GqghBx6IjXrSJ
	YQyjLWAz80Hp5Wp8FvOw7M9cHNAHsv54tdyBhNtBgVelGr1tXD/12d3tjDRiOd5RNMT4qviHzxX
	Rq6F1xsAz7OgJxuAT+OVhuxlFqTxrQYgpkdFJcPZPdQfj36kdAQCGXHC7hLgpHqbLZ+VD9qOw2D
	ydg5GXIQLCfZJYF5DO+2D6ECZfcG0Tij/610Yv8torfZsiqD0Bv2zccDClLRWOwKzlM0FiCYDZ6
	VQIkv0q7HMu5z8QKCU00H0VOCQLfbVMfNYRa+Zms1iqq+Si9qBhm3Kn8y7Lt7zLoBA+DhvBSZWU
	5wfwaaBaSRCj5/52M2z9gWoSngN6FtW5rEPHRrUhgyZPZ+a4k+TKd9gpvs0OPBfMQPXD+04urFv
	xzt3L6O3gMH/u/+0Omi0G8wzpOrLADRLM25bI/jeEjg8p13xUhz7cW12Y=
X-Google-Smtp-Source: AGHT+IGxhQWSumMFwn3LlnVO8NJuQwf07y76ou/hZ5rcGuqQn3+dyj81yyfuXFtVWXqkqV1MbUuzwQ==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3e0a:64b9 with SMTP id ffacd0b85a97d-42cbb2a9dc1mr2012653f8f.6.1763672631354;
        Thu, 20 Nov 2025 13:03:51 -0800 (PST)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:da5d:d2f9:b3b6:6e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35b7sm7433341f8f.20.2025.11.20.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:03:50 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [psplash][PATCH 1/2] Add configure flags to set progression bar size
Date: Thu, 20 Nov 2025 22:03:45 +0100
Message-ID: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 21:03:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2634

Added --progress-bar-border-size configure option to set progress bar
border size without patching the code. Default behaviour is to show a
progress bar with a 4-pixel border size.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 configure.ac     |  8 ++++++++
 psplash-config.h |  5 +++++
 psplash.c        | 10 +++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 110ce32..a64990a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,6 +45,14 @@ AS_IF([test "x$enable_progress_bar" = "xno"], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_PROGRESS_BAR"
 ])
 
+AC_ARG_WITH([progress-bar-border-size],
+    AS_HELP_STRING([--with-progress-bar-border-size=SIZE], [Set progress bar border size (default is 4 pixel)]),
+    [with_progress_bar_border_size=$withval],
+    [with_progress_bar_border_size=4])
+AS_IF([test "x$with_progress_bar_border_size" != "xyes"], [
+    EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_PROGRESS_BAR_BORDER_SIZE=$with_progress_bar_border_size"
+])
+
 AC_ARG_ENABLE([img-fullscreen],
     AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in fullscreen mode)]),
     [enable_img_fullscreen=$enableval],
diff --git a/psplash-config.h b/psplash-config.h
index eb90ef3..c7fff81 100644
--- a/psplash-config.h
+++ b/psplash-config.h
@@ -26,6 +26,11 @@
 #define PSPLASH_SHOW_PROGRESS_BAR 1
 #endif
 
+/* Size of the progress bar */
+#ifndef PSPLASH_PROGRESS_BAR_BORDER_SIZE
+#define PSPLASH_PROGRESS_BAR_BORDER_SIZE 4
+#endif
+
 /* Position of the image split from top edge, numerator of fraction */
 #define PSPLASH_IMG_SPLIT_NUMERATOR 5
 
diff --git a/psplash.c b/psplash.c
index 261dd1c..fbd51d0 100644
--- a/psplash.c
+++ b/psplash.c
@@ -67,11 +67,11 @@ psplash_draw_progress (PSplashFB *fb, int value)
 {
   int x, y, width, height, barwidth;
 
-  /* 4 pix border */
-  x      = ((fb->width  - BAR_IMG_WIDTH)/2) + 4 ;
-  y      = SPLIT_LINE_POS(fb) + 4;
-  width  = BAR_IMG_WIDTH - 8; 
-  height = BAR_IMG_HEIGHT - 8;
+  /* n pix border */
+  x      = ((fb->width  - BAR_IMG_WIDTH)/2) + PSPLASH_PROGRESS_BAR_BORDER_SIZE;
+  y      = SPLIT_LINE_POS(fb) + PSPLASH_PROGRESS_BAR_BORDER_SIZE;
+  width  = BAR_IMG_WIDTH - 2 * PSPLASH_PROGRESS_BAR_BORDER_SIZE;
+  height = BAR_IMG_HEIGHT - 2 * PSPLASH_PROGRESS_BAR_BORDER_SIZE;
 
   if (value > 0)
     {
-- 
2.43.0


