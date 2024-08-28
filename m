Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48BC7112E
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web11.5850.1724875802205380225
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uitB0sL7;
 spf=pass (domain: konsulko.com, ip: 209.85.166.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-829e856a14eso135528639f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875801; x=1725480601; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzkGUrha+x8l/gB4mQbRDmVU1SlV0Nw7PXqaAPbmHQs=;
        b=uitB0sL7WW31GW/u8SoObSSTK9/23IbjeYTKfr0AxFs3UVxKzV6MHmZ47n04CFKB2d
         ixcw4RHH5RdT+F+HbnfKccVCJxJ2dEQ5dSXmQCbS9EsNWog4SBCmVxFmlidVxGqF09Uo
         fQ1LjHbO2EXDWbXWdeSBOFsDJmWwCZPU8Xvp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875801; x=1725480601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzkGUrha+x8l/gB4mQbRDmVU1SlV0Nw7PXqaAPbmHQs=;
        b=ExuQYvcepHlTTOePNvZ7fueLEpcKeNxg5lmn/ZI6xur9/UtEOmXSjfXRRxPqQBCJcV
         48bInxQDSPh/n7rUciyHyh9cDSIbEUubjOVaFyAHXxbnumnVdx7QijlYKyvS6ZglChty
         kbLXP0LO43wrJD9e3sLfJutM7qlI4ynJjOYifzaDZCSbo+D5i/E1JoXMPhiclHpRBZ5/
         F68iXRKDJRKrqv4Egf/ZvkUT/3b/CRL9SNjv8rvLvmcr+XH3eH0ggfKeIWDUsvQiLVfH
         egLEsvxex7Pjkhjh03n3LpfWTzs2P5ANbhLXpE9Sq146WNYnG5Tk4qxm0pUMWVAv/FJv
         9SgQ==
X-Gm-Message-State: AOJu0YxD6g7NJthiCdjUTQumnOJGVvDgkwdIjyuD+6hW88qDeWYF/Ixd
	SjoDp5XSzObal89oQoSFNnV5SGhlnFoHlsHEmDfGzSWMN0Leu4gCxPspmNpJKjo8pWXb5l3EutA
	a
X-Google-Smtp-Source: AGHT+IGkbWj+jAKA9nNIB/TpspHD0d1Si4Iaeb/CyAjWBUDHTPpJwckuxyZW8rvyojl1yOfCLIBlPw==
X-Received: by 2002:a05:6602:26c6:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-82a10d7fa0amr86168439f.0.1724875800990;
        Wed, 28 Aug 2024 13:10:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 16/33] librsvg: don't try to run target code at build time
Date: Wed, 28 Aug 2024 16:09:02 -0400
Message-ID: <6ee488b1b5ad8d45acdf562042b7e62a83886674.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/583

From: Ross Burton <ross.burton@arm.com>

The rsvg-loader test binary isn't installed but building it causes a mix
of build host and target code to be executed.  As we don't install the
test, don't build it.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 78667e67a77df39c2af417e56ebf480962ff2e42)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../librsvg/disable-rsvg-loader-test.patch    | 40 +++++++++++++++++++
 recipes-gnome/librsvg/librsvg_2.57.1.bb       |  1 +
 2 files changed, 41 insertions(+)
 create mode 100644 recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch

diff --git a/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch b/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
new file mode 100644
index 0000000..e56772a
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
@@ -0,0 +1,40 @@
+From df94cfa4a637c229fef32c349b5c2dfee2dca3fc Mon Sep 17 00:00:00 2001
+From: Ross Burton <ross.burton@arm.com>
+Date: Thu, 27 Jun 2024 17:09:11 +0100
+Subject: [PATCH] Don't build rsvg-loader in cross builds
+
+This binary is a non-installed test binary that isn't any use in cross builds, and
+causes problems because it generates a gdk-pixbuf loader cache at build time using
+a mix of host and target libraries.
+
+As we don't install the binary, we can just not build it.
+
+Upstream-Status: Inappropriate [upstream has moved to Meson]
+Signed-off-by: Ross Burton <ross.burton@arm.com>
+---
+ gdk-pixbuf-loader/Makefile.am | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/gdk-pixbuf-loader/Makefile.am b/gdk-pixbuf-loader/Makefile.am
+index 44df9c6c..fb417d24 100644
+--- a/gdk-pixbuf-loader/Makefile.am
++++ b/gdk-pixbuf-loader/Makefile.am
+@@ -30,6 +30,7 @@ if PLATFORM_WIN32
+ libpixbufloader_svg_la_LDFLAGS += -no-undefined
+ endif
+ 
++if !CROSS_COMPILING
+ noinst_PROGRAMS = rsvg-loader
+ 
+ rsvg_loader_SOURCES = \
+@@ -52,6 +53,7 @@ EXTRA_rsvg_loader_DEPENDENCIES = libpixbufloader-svg.la gdk-pixbuf-loaders
+ 
+ gdk-pixbuf-loaders: Makefile
+ 	$(AM_V_GEN) ( $(GDK_PIXBUF_QUERYLOADERS) ./libpixbufloader-svg.la && GDK_PIXBUF_MODULEDIR=$(gdk_pixbuf_moduledir) $(GDK_PIXBUF_QUERYLOADERS)) > gdk-pixbuf.loaders 2>/dev/null
++endif
+ 
+ if CROSS_COMPILING
+ RUN_QUERY_LOADER_TEST=false
+-- 
+2.34.1
+
diff --git a/recipes-gnome/librsvg/librsvg_2.57.1.bb b/recipes-gnome/librsvg/librsvg_2.57.1.bb
index 0a883dd..81a328f 100644
--- a/recipes-gnome/librsvg/librsvg_2.57.1.bb
+++ b/recipes-gnome/librsvg/librsvg_2.57.1.bb
@@ -20,6 +20,7 @@ require ${BPN}-crates.inc
 
 SRC_URI += " \
            file://0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch \
+           file://disable-rsvg-loader-test.patch \
            "
 
 SRC_URI[archive.sha256sum] = "074671a3ed6fbcd67cae2a40e539107f4f097ca8a4ab1a894c05e2524ff340ef"
-- 
2.46.0


