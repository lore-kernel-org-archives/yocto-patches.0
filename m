Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6300.1794870774918404538
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ot2BS/rA;
 spf=pass (domain: konsulko.com, ip: 209.85.221.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so275873e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870774; x=1795475574; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V8s5eOMxSwHMBP41tn4SHU4rFL2YWGr76buZj9FisVk=;
        b=ot2BS/rAHrdYTJrC4KPWPrqHRU0J7vNNRpZPuaM4Lzie6Uy6u1mfi1IGYFotAzYv0I
         21XKfTEP2RgmFH2Q+e+LboeiusDFv2FcBPTB9x0QDZ/sHpB2NeoBffJoeoydjhj7CBW/
         mNA6j9aVH6eOj+LaJe8Tl1fbaravhalxiOsLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870774; x=1795475574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V8s5eOMxSwHMBP41tn4SHU4rFL2YWGr76buZj9FisVk=;
        b=AjhnWqYmfx+1VM69aYx4nRwZioNyElIHl7y7G958z7Qehdr4+E1uSiYuliqHwxhmIr
         NsmR5UfP5+NVshwi3GLCgQoXzvrfHEOtx9dxpAf0fNmsC7wE8inw17jVzJ3INgir2dHp
         tJWe5sM2DfjvZLJR4VPgTMYGosLYlLZCnZcsbNB1p23bCzOLtlrhIZ0FETQtfHHMrQbS
         kZgxjKy1b9VDbhrgq08/fVNyiXIUQCaVvn5A6Av006YCQ8PLtAGCoFl91cHECiI1MISp
         e0flr4rNRAY8Lz72diFV59eQRf5wY7+emcznc0PN+GBKc2Tj9715DINdfjZ3rQxYPx2H
         WbmQ==
X-Gm-Message-State: APuU4Z/b/6IlFRLFHXy+NZOJua1xX37z58p6RpVjI3veqxa1CxTKPl4O
	Rori3Perp1hrzi6/W+PyfIyvKtdk4jKIyvjZY21wR7jEbzXD/VM2hRICC3vFZD0cVZcY7s0PA8o
	9VoXVzq4=
X-Gm-Gg: AYBFou0B8nFbRHi66KiJT2du33tabCRg73HjxC7F60lFJXDY8Hcf0BbRppMC5Yu0ce8
	tUr7ROUg+1ogCTzwXr6LazGW2Tbjei6/jfb291lMFeGUps70T2KLLznqrE5wIuIghZcYgjS1Smt
	oGcgX2dubToc6oMFhMDDg11/FJHrcU1sHhggt+xFhABmlscA4JGQ02YicwxebPDzM0V4ju1la9w
	hHvo3u9XNf0x9FabcqhFen4rrqfBU6km1owxcYKoo3XZlLEnTwc2ZdHJLU0mpf9aJYWay8h46nE
	iqlaaHVCsOq0c2I465VT48iHSiIGtwiAQwwZ6Jp9/krSJmrlJrUbogB/52Zhp3G25h3U7n1gS39
	ifaTZqtEsgsCz1Wns0Rl4wgEYcCce+8JOxxTjsfGwZ+H+r/Ztk5e97HbttxrAPi6JqpWp99vzDk
	TJa8wkkZrfod4d3aVmrTWEp3UAKmfnobU6ZpwEXHIHJoJjME8me1npcEK5CGwen2S0o/o/syw4r
	P8qvyVtIpdR339kME7Y5I/xSe7RkSlxryX3dY6pjn+vb3XfB2o6BSIhkXVLZwpa5G5Z+2UJkU8g
	YNz0yx1oYpOuPASrXOgwwttolnbiaXqJ81Bfve2Xom9lolkc3pd41IbgsVkwEqBxNd0Jfz1h0MG
	fDVZW9jG/XujtUdVUuavNX1/v52KecyUvS0874DkjWcLJ8zsxfPEglerrQvRQpES3+Q==
X-Received: by 2002:a05:6122:46a6:b0:5ec:d9c6:73b2 with SMTP id 71dfb90a1353d-5ee5b737ecbmr302532e0c.7.1794870773497;
        Mon, 16 Nov 2026 15:12:53 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 01/19] rust: add secure-plt to generated powerpc targets
Date: Mon, 16 Nov 2026 18:12:22 -0500
Message-ID: <a039f4ce86697e3cc84e38f8724637f42569a69d.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5440
Content-Type: text/plain; charset="utf-8"

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

Rust's built-in powerpc-unknown-linux-gnu target has used the
+secure-plt feature since rust-lang/rust#136154. OpenEmbedded generates
its own powerpc-poky-linux-gnu target specification, however, and the
feature was missing there. Consequently LLVM emitted objects that were
incompatible with the secure-plt toolchain default, making ld fall back
to bss-plt and print a diagnostic that rustc 1.97+ exposes through the
linker_messages lint.

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 88c0d94bc177bd8e3edc016316c92528c6d38586)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 58c36bf..1cba275 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -254,6 +254,7 @@ TARGET_ENDIAN[powerpc] = "big"
 TARGET_POINTER_WIDTH[powerpc] = "32"
 TARGET_C_INT_WIDTH[powerpc] = "32"
 MAX_ATOMIC_WIDTH[powerpc] = "32"
+FEATURES[powerpc] = "+secure-plt"
 
 ## powerpc64-unknown-linux-{gnu, musl}
 DATA_LAYOUT[powerpc64] = "E-m:e-Fi64-i64:64-i128:128-n32:64-S128-v256:256:256-v512:512:512"
-- 
2.56.0

