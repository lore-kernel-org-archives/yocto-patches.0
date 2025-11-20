Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F488CFA44A
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 21:03:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4956.1763672634099287861
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 13:03:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bTSvJpoj;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b2dd19681so137515f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763672632; x=1764277432; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7RKRTy4IsjceQhU21h2R/gEXKFAOgxmDeHL3ucrZY0=;
        b=bTSvJpojEP7mLhzZKmWscJFJc692cbpSVrQVsGRG/q2l5+uy/PZyA9uNdg1ELXTVbZ
         obIdl0rCutaSRhrXM/bbvu1h5M7c7GTWJqWzww89iUDgCMZVd703aoRdIYssu+DIic87
         0QhLXFPnBYW4kdNwXtuVighxzA3Iy9v6RGRqwgfzl/5j3BG6At9CDowRf7nH84hhso8e
         ISq6M8SIKHfGTfH6e0AVpWar+gZDAD1kqUjAvQV5NjRuDkM4SvWGHMBocf8ADinMsrGF
         9Ug2Lugi0X78Kiu2ioecwHRgmVBQg7bFHoTfh58Ij6EkaZaRy9OYbuTcab3rq0SmXNDY
         g6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672632; x=1764277432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7RKRTy4IsjceQhU21h2R/gEXKFAOgxmDeHL3ucrZY0=;
        b=IPId4gukXJf2XDFjKP0rfeX1hkMRN4uVTX8e+KOaxB8e7y39kXxMx6iO5xg4emgbiO
         6BtGFVbkka+iH95gJa5ngqBYWrAc4GMgkXcMPjOnMHCo/EoD5QoG3Vl9tEAZ1fzEBpjY
         n4mgBzNzf6pwLJ9psDJbiwu0cgInd16Dc4ytGQ3IfYVhJryolihHCbEsqMuu2E8Wjl0K
         HeR0kDo9Oo1i3aR0BXz9V6dzoWe3me+Qzh2Igc4Jy8fyE3+CavnPXciN5k5gCacK35+F
         NI2TXJ8YB8iJkaeEDG+gx54afcpSfnSgJ6087lHA2lYW2NYGXMdbfNetfwMGuparq3D+
         ExRQ==
X-Gm-Message-State: AOJu0YyelKbm79go/OBhSIni/x2vH00yscinnx4y8mIwQiq1NFwKiwGx
	e/INJ5ZK1wC00tNNrNCApgmXHT1ghUJCd+KLdj27mRBZxwaAV38J8iohoIX85aqsVkk=
X-Gm-Gg: ASbGncvy5tMY4CUqSbkLohm7KyZK8PLMap78Kdf5wKQXD/UY3d8e4RCaJG+ZIPq1PMl
	hCuuQJ6oBpnzz8uIGYImg1F4H8Bc7yHwh8zl09gseunpPlNQZuL1Vo49SMiO5LfURHzfO+z1EGR
	b+DqoITX8d2EXZPgey4tQ1uuCTyFbwH80C+Y4DCAILfr6ljv2haqiAqnfl05EPMzrrblZP2Ku1Q
	TWlaaUjmAiLolv7B3h7RWoCrmbyuMqqP0+U4oBUzPxoIDb4QPI9RLEx5zb006Os7FKPQwb3fSrQ
	28YndMSzq4yZQ8I+Ji4ro5mfAcgA0Zkt9dB+5BRLgKIlBc9NQtkIrTgTEaKaWGEp+wwhHFpT2Ir
	GKQazgzlI4GjYkFRPNw7S+hF9fwWr1lzvOdT0aXv2/BPWsely2kGY0/Hq3vMd2tarL5ZAnNrcIb
	eSpC24mEh6LVSkiE8wYTMPujrHvMLkPijfb9tg/dsmhwMpjvQr41JknLZjPwwoxd7s5g==
X-Google-Smtp-Source: AGHT+IHjo7atAcrU/UNGoQ+Ord58dM5DxR4h+rSRrbAUXbE2fXTxeEmNGgm07Erhj6gh5E2wmtpS5A==
X-Received: by 2002:a05:6000:22c7:b0:429:d084:d210 with SMTP id ffacd0b85a97d-42cb9487881mr2507144f8f.0.1763672632056;
        Thu, 20 Nov 2025 13:03:52 -0800 (PST)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:da5d:d2f9:b3b6:6e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35b7sm7433341f8f.20.2025.11.20.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:03:51 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [psplash][PATCH 2/2] Add configure flags to set colors
Date: Thu, 20 Nov 2025 22:03:46 +0100
Message-ID: <20251120210348.88193-2-gael.portay+rtone@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2635

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


