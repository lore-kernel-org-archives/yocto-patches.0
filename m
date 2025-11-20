Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02486CFA446
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 21:03:57 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5062.1763672635236094257
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 13:03:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AZhuzP4I;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b54f690b0so86285f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763672633; x=1764277433; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7RKRTy4IsjceQhU21h2R/gEXKFAOgxmDeHL3ucrZY0=;
        b=AZhuzP4IsNB6ILqRXBacpxOmv/F2Z907asJmR6X4fqRIYzwNnwJq8Qn/NdxuxpeQUo
         av7+bOKPgZp8oY3DxYHoHtsElKchZhSI4K/DCXLrlNexlor4ii5zTWSW7GDEUcmfF5pL
         Y18U4vI9tmgReZimMtwaZUDqxvg3MIBE/dAQjKdEcM282O4mAawFjeM37cSGinthU9vJ
         kZ7S0jiKrD3GRrqc8P1EQPE8vIbwip0/e8N2Q/CPFce6ORglBNWeekoahs1C3OhlI4nU
         mdUpqrVPCOs0mvhJhzZ/uJIafKhYP2JzeCwAfxDNb8WKzlsLUlTZKqfgqlP85nU6/yOA
         Rv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672633; x=1764277433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7RKRTy4IsjceQhU21h2R/gEXKFAOgxmDeHL3ucrZY0=;
        b=v7R+REIXcxm5mxsghfiJ54HA3K1l83Sb27EZzq32O5nmge8p0V2cOfHYHLUuBn4UKT
         FBePDfaZlOQwSg+GlQzP0/VINsxl7BaVvU/equvxdey2pUqKhUaS6bKUO36yiI0oLwSv
         eAwlNTHJwy31QxaHaRWXuteg9RbG80ZyG7BRODex9J572FTURAFZCqmUkoJ4MnEHsBAa
         YgywCnAsKuQ+q07X1MpP9VF4fcV8tScT83EoKBNVYXFOA2r0v1dfKI65Yswkt4qIqzv1
         PONK4JScZLEMlX2RCxPmWwVjyWdnBWZhNNMvrr6q2xyAtq+0k+LNS68PfJ7Ektp812jI
         iDCQ==
X-Gm-Message-State: AOJu0Yym2pd9maoGRHUKV2Pq4FJMqtgSu+E8pwIMIL+vcowOvzulomdr
	xyMJdHX9gHm7lKu1ZLivNYlDgiDm6cNbUf6RYywizd4qclqIgX0/Ikw6gByN+0ksEKY=
X-Gm-Gg: ASbGnctADSepHgi8y49ZjF0/04Tyr1dj9v2/zCXWZO1OPtY52bntnt4QozwTCiDwmk9
	fbKEk/YQjtFa71iSAY0EHy5WJnxcYZkPsZby3m/3YdJ0UwqUlziU90H/vR6pNEaa52tpECadmY4
	r3zDaeDfXIWgqAU0rLFMwHgKtCWQ4RBLbC0+1PVIm3dk2Lyss/pkNEpiyfhqipQJhT2/cPUcOzU
	7M4L1U/V/0JciXrF2ZQB1jLXQUqHlQBvswpVhDLoDZbpUI4Qlkj8LCmTkVP5DEwcJReJXRUTrW+
	Yzz7oraGF3QH+qaqKMTo3j7kve6IFe8LCnKEdvQVEOuMa11sviilAXkXkN7IuabK0hTAnOzFgl/
	icN2s7ItV7X7QQuEwosFQx2WDPx4Ihy2zsCnBn4vw4m6O4/5PnpjZhgYwe8PBowZ0aTkNudtrd0
	D+lnr6tojrJ1scxk6gCes6+l2fHaSJVAXNMgZaWMH1Jf0apsKgOZl4L2s=
X-Google-Smtp-Source: AGHT+IG/Z/NOfu71jmr0FEHnByKEJ614vrIyvRo2XC8MhFVUdfGp+8Sb81laR+o1/Ai/NcYvBADLzg==
X-Received: by 2002:a05:600c:4443:b0:45f:2c33:2731 with SMTP id 5b1f17b1804b1-477c0169f1emr466305e9.2.1763672633178;
        Thu, 20 Nov 2025 13:03:53 -0800 (PST)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:da5d:d2f9:b3b6:6e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35b7sm7433341f8f.20.2025.11.20.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:03:52 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 2/2] Add configure flags to set colors
Date: Thu, 20 Nov 2025 22:03:48 +0100
Message-ID: <20251120210348.88193-4-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
References: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 21:03:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2637

Added --with-text-color, --with-background-color, --with-bar-color, and
--with-bar-background-color configure options to set colors without
patching the code. Default colors are 0x6d,0x6d,0x70 for any text output
and bar indicator, and 0xec,0xec,0xe1 for overall background.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 configure.ac     | 32 ++++++++++++++++++++++++++++++++
 psplash-colors.h |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/configure.ac b/configure.ac
index a64990a..d01afce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,6 +53,38 @@ AS_IF([test "x$with_progress_bar_border_size" != "xyes"], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_PROGRESS_BAR_BORDER_SIZE=$with_progress_bar_border_size"
 ])
 
+AC_ARG_WITH([text-color],
+    AS_HELP_STRING([--with-text-color=RED,GREEN,BLUE], [Set color of any text output (default is 0x6d,0x6d,0x70)]),
+    [with_text_color=$withval],
+    [with_text_color=0x6d,0x6d,0x70])
+AS_IF([test "x$with_text_color" != "xyes"], [
+    EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_TEXT_COLOR=$with_text_color"
+])
+
+AC_ARG_WITH([background-color],
+    AS_HELP_STRING([--with-background-color=RED,GREEN,BLUE], [Set color of overall background (default is 0xec,0xec,0xe1)]),
+    [with_background_color=$withval],
+    [with_background_color=0xec,0xec,0xe1])
+AS_IF([test "x$with_background_color" != "xyes"], [
+    EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_BACKGROUND_COLOR=$with_background_color"
+])
+
+AC_ARG_WITH([bar-color],
+    AS_HELP_STRING([--with-bar-color=RED,GREEN,BLUE], [Set color of the progress bar indicator (default is 0x6d,0x6d,0x70)]),
+    [with_bar_color=$withval],
+    [with_bar_color=0x6d,0x6d,0x70])
+AS_IF([test "x$with_bar_color" != "xyes"], [
+    EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_BAR_COLOR=$with_bar_color"
+])
+
+AC_ARG_WITH([bar-background-color],
+    AS_HELP_STRING([--with-bar-background-color=RED,GREEN,BLUE], [Set color of the progress bar background (default is 0xec,0xec,0xe1)]),
+    [with_bar_background_color=$withval],
+    [with_bar_background_color=0xec,0xec,0xe1])
+AS_IF([test "x$with_bar_background_color" != "xyes"], [
+    EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_BAR_BACKGROUND_COLOR=$with_bar_background_color"
+])
+
 AC_ARG_ENABLE([img-fullscreen],
     AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in fullscreen mode)]),
     [enable_img_fullscreen=$enableval],
diff --git a/psplash-colors.h b/psplash-colors.h
index 82a9893..d6d19af 100644
--- a/psplash-colors.h
+++ b/psplash-colors.h
@@ -12,15 +12,23 @@
 #define _HAVE_PSPLASH_COLORS_H
 
 /* This is the overall background color */
+#ifndef PSPLASH_BACKGROUND_COLOR
 #define PSPLASH_BACKGROUND_COLOR 0xec,0xec,0xe1
+#endif
 
 /* This is the color of any text output */
+#ifndef PSPLASH_TEXT_COLOR
 #define PSPLASH_TEXT_COLOR 0x6d,0x6d,0x70
+#endif
 
 /* This is the color of the progress bar indicator */
+#ifdef PSPLASH_BAR_COLOR
 #define PSPLASH_BAR_COLOR 0x6d,0x6d,0x70
+#endif
 
 /* This is the color of the progress bar background */
+#ifdef PSPLASH_BAR_BACKGROUND_COLOR
 #define PSPLASH_BAR_BACKGROUND_COLOR 0xec,0xec,0xe1
+#endif
 
 #endif
-- 
2.43.0


