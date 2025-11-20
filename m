Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F789CFA44B
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 21:03:58 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5061.1763672634892010364
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 13:03:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eshtvFDw;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477985aea2bso865245e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763672633; x=1764277433; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r9EYkjJY0I12kIpnAeH+8H8UceY6FmVLUbZiN4WvvQ=;
        b=eshtvFDwrfKaHE3/Jcji70ltuCVWmoh/5fNCldjHqa08wNdFyelP0lHK2kYRN2QY/b
         aE00slTMOqqyiYHU+47YZ5RSHDK9hyUhCB5fSGVcOY9eJk7KqskJu3Zu8o1tD2dMGLWx
         MY0vXl2QM60FiZXXzJD5YFHSN+/WMmrKbJJ45poh8StNAG2ScSywhDsfSDG/W9Tyrq1H
         WhzH9+mXZY+caCpVewRsopuLFJHwURiZuirQL2OI3388Gn7HOWJ/a9oCusvpDpbf79Ol
         GO6kTUUpVA/mNRnp4QC61WjOPky+vn01rPPSfVirRwmvvDpwQLF4p4J/7IU97+TM38Fq
         1KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672633; x=1764277433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r9EYkjJY0I12kIpnAeH+8H8UceY6FmVLUbZiN4WvvQ=;
        b=LusinVS6U01zdTDJZY1lQVilfGSH//+vAcEILeMoeKa3sh6+JJ1LMeeOmj4VR2+3PK
         +J72163QaajqWQMajnPB68DHvLN83Pxjb/HGZSwzGfFL/zBEDnwNo3smS1Kl+4/CSLVA
         dOQdqgjQGZzX1p9YhCJ9XpbFNFsFdX2TGtZv5aXSZl3grlBv1GP7VipR0G/ot6+RUAAj
         OVyZxmzcLSxH/wJHM+y/oTGYl15Th2C90bzKFtxaPoE7R2wkOEfvVgPD2ANO7Fz+voXX
         RWcc56z5MhHrQ+Mq0eZ7U2/f/cCnE5AdPDmLTaA0HUq4WPR4Tdjhwms2myYCm22Kex+2
         hALA==
X-Gm-Message-State: AOJu0YytZj65l85zGC7Lwoz2+zR+YFxhdRHhxhp8CT+D7LV78IqcD0EG
	8OL/sRNlJQRYL2LDUHEYDnpLdlvgj4jxHNIZWU7MMFdwmS+oXGiblOopCixK9NVVz54=
X-Gm-Gg: ASbGnctzs1G+ENJtcHJy0nkwlVZ6pXLMjeJS+dli0WrjXx0YqvQy8ekTIibXpMxQwWm
	KrC976u2E4ygp8u6IiC1iBbQvtSqFe/HE3W4iEE3YhXHWsJeaJXgEmQyUZYcTIUlAowDXNwbtjP
	ECof9RB27/3feFY4WQTUPUOrh0U08DzbVUG8i0G/PbWqqAwFD04LpsXOuA5ZMdpUqHhrjoDPn2f
	9eznUDp/Xdr2G0KbwQUm9OiUEEWCXIztAVge33v05U4MSb2nk4BO58YZd/91rhUeHm6AmVhvIAp
	2GwsZ8s+LO50mTzzvS8mByYKLSW5e4xHyJKNVfFd0KLVfSPnKVI3d2qGBpTsPzGugm05+yk5YNQ
	sW9w06KqGzRjRqthPbdqJFocJk+DvnRrTsW5P6fhGcORm9z07IJU3xfGDeu9HQnVNRcO9R6FCtv
	PD5RQZ5PmLUrM8z9CsSpuHTxczRv/+aHFYAZIo+CUN6LqQSAiv/yJ7s/U=
X-Google-Smtp-Source: AGHT+IHu4IyDo95N0T3KjHB9E3D9ZMKXNrBEMhsd/24K53kWXyeD6kY500EA9x1Nk4LYJi48uoF3iA==
X-Received: by 2002:a05:600c:1987:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-477c01d74d9mr519375e9.3.1763672632606;
        Thu, 20 Nov 2025 13:03:52 -0800 (PST)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:da5d:d2f9:b3b6:6e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35b7sm7433341f8f.20.2025.11.20.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:03:52 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 1/2] Add configure flags to set progression bar size
Date: Thu, 20 Nov 2025 22:03:47 +0100
Message-ID: <20251120210348.88193-3-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
References: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 21:03:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2636

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


