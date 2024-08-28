Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E973C6FD3C
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web10.5962.1724875792317112930
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f77YKgCr;
 spf=pass (domain: konsulko.com, ip: 209.85.166.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d22965434so3077375ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875791; x=1725480591; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiCr1JhHa3HW0JFtrk7F4yogu4bbYifZPVMmWuNnT/c=;
        b=f77YKgCr0zl9XVsCnO6aoLktWV3dyHvvRam0JeAyrrQPrExRbWwDVjaHDxifEnZHNZ
         B5d+c75ApTTBjV2iKVRvD8O4wbw2nzWmYt+DmmnjB96cAaACzNA2S7Kt2hQNGvfI/8cd
         8Be1myUxFNG1ARNjhW/JAaGbG/01rDi6WoH1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875791; x=1725480591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiCr1JhHa3HW0JFtrk7F4yogu4bbYifZPVMmWuNnT/c=;
        b=TdeElFpC76lCNO0G61s7Tk/fl1X9hC6zW78IqglBtDbmcPFMqIp0EXpHiy1eunN6fd
         ZI6v9gQov4dRkgd33QdyM48qdwR1ovLceuyWtMrhGDAcVd4zLTID0uP0ZjJp51kq91fA
         WlWIC+vnYVJbMINXotL8YuTo7gNbBf/dkXsQmiCcbbDO0YrIKqy0ZgLyfGF+ZBu8Qskg
         83Vi7OB7vhoCSocRZm1ZInOH1d4xQLAzQGm0UypAHAoC/LAVrlb/OWjXMooWTBcugjer
         tUAweXety6n/78Si8SGKjAX6PSu7Gx6cQGZadEcDLxXs7VAuK84t3qKyKuitOuHDCMtJ
         Z1Zg==
X-Gm-Message-State: AOJu0Yy+iKgj2HSNvLgBD8G703XItPuFBESbp2tDa6ct+csRsNOOpqzv
	X19smGAGuF4B4YSjuhdIKIjKnirN5WYZQp4tKjk1dCnEbVLt/So7GCEo7i+ffv2jYckxZQGEtSy
	m
X-Google-Smtp-Source: AGHT+IGqv42q32yjn7U1TbeFNFBDY//h9Jq3WJgJfIWV/ja7vW+tPYlAeJ4PhewWNcSU6SxaT1RoYQ==
X-Received: by 2002:a05:6e02:1847:b0:39e:69bc:a7fe with SMTP id e9e14a558f8ab-39f38b68e54mr2094005ab.10.1724875791101;
        Wed, 28 Aug 2024 13:09:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/33] Add cairo backport
Date: Wed, 28 Aug 2024 16:08:50 -0400
Message-ID: <499021f9acd4437b6ba1ffe79d28ce1167d23bdd.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/571

cairo 1.18.0 is needed to build librsvg >= 2.57.1, so add a
backport of its recipe (as of oe-core e7388c4b) to allow future
librsvg updates.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...tmap_surface-bsc1036789-CVE-2017-7475.diff | 22 +++++
 recipes-graphics/cairo/cairo_1.18.0.bb        | 86 +++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 recipes-graphics/cairo/cairo/cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff
 create mode 100644 recipes-graphics/cairo/cairo_1.18.0.bb

diff --git a/recipes-graphics/cairo/cairo/cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff b/recipes-graphics/cairo/cairo/cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff
new file mode 100644
index 0000000..6c761bf
--- /dev/null
+++ b/recipes-graphics/cairo/cairo/cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff
@@ -0,0 +1,22 @@
+Cairo: Fix Denial-of-Service Attack due to Logical Problem in Program
+
+https://bugs.freedesktop.org/show_bug.cgi?id=100763
+
+CVE: CVE-2017-7475
+Upstream-Status: Submitted [https://gitlab.freedesktop.org/cairo/cairo/-/issues/80]
+
+Signed-off-by: Fan Xin <fan.xin@jp.fujitsu.com>
+
+Index: cairo-1.15.4/src/cairo-ft-font.c
+===================================================================
+--- cairo-1.15.4.orig/src/cairo-ft-font.c
++++ cairo-1.15.4/src/cairo-ft-font.c
+@@ -1149,7 +1149,7 @@ _get_bitmap_surface (FT_Bitmap		     *bi
+     width = bitmap->width;
+     height = bitmap->rows;
+ 
+-    if (width == 0 || height == 0) {
++    if (width == 0 || height == 0 || bitmap->buffer == NULL) {
+ 	*surface = (cairo_image_surface_t *)
+ 	    cairo_image_surface_create_for_data (NULL, format, 0, 0, 0);
+ 	return (*surface)->base.status;
diff --git a/recipes-graphics/cairo/cairo_1.18.0.bb b/recipes-graphics/cairo/cairo_1.18.0.bb
new file mode 100644
index 0000000..4c97e97
--- /dev/null
+++ b/recipes-graphics/cairo/cairo_1.18.0.bb
@@ -0,0 +1,86 @@
+SUMMARY = "The Cairo 2D vector graphics library"
+DESCRIPTION = "Cairo is a multi-platform library providing anti-aliased \
+vector-based rendering for multiple target backends. Paths consist \
+of line segments and cubic splines and can be rendered at any width \
+with various join and cap styles. All colors may be specified with \
+optional translucence (opacity/alpha) and combined using the \
+extended Porter/Duff compositing algebra as found in the X Render \
+Extension."
+HOMEPAGE = "http://cairographics.org"
+BUGTRACKER = "https://gitlab.freedesktop.org/cairo/cairo/-/issues"
+SECTION = "libs"
+
+LICENSE = "(MPL-1.1 | LGPL-2.1-only) & GPL-3.0-or-later"
+LICENSE:${PN} = "MPL-1.1 | LGPL-2.1-only"
+LICENSE:${PN}-dev = "MPL-1.1 | LGPL-2.1-only"
+LICENSE:${PN}-doc = "MPL-1.1 | LGPL-2.1-only"
+LICENSE:${PN}-gobject = "MPL-1.1 | LGPL-2.1-only"
+LICENSE:${PN}-script-interpreter = "MPL-1.1 | LGPL-2.1-only"
+LICENSE:${PN}-perf-utils = "GPL-3.0-or-later"
+# Adapt the licenses for cairo-dbg and cairo-src depending on whether
+# cairo-trace is being built.
+LICENSE:${PN}-dbg = "(MPL-1.1 | LGPL-2.1-only)${@bb.utils.contains('PACKAGECONFIG', 'trace', ' & GPL-3.0-or-later', '', d)}"
+LICENSE:${PN}-src = "(MPL-1.1 | LGPL-2.1-only)${@bb.utils.contains('PACKAGECONFIG', 'trace', ' & GPL-3.0-or-later', '', d)}"
+
+LIC_FILES_CHKSUM = "file://COPYING;md5=e73e999e0c72b5ac9012424fa157ad77 \
+                    ${@bb.utils.contains('PACKAGECONFIG', 'trace', 'file://util/cairo-trace/COPYING-GPL-3;md5=d32239bcb673463ab874e80d47fae504', '', d)}"
+
+
+DEPENDS = "fontconfig freetype glib-2.0 libpng pixman zlib"
+
+SRC_URI = "http://cairographics.org/releases/cairo-${PV}.tar.xz \
+           file://cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff \
+          "
+
+SRC_URI[sha256sum] = "243a0736b978a33dee29f9cca7521733b78a65b5418206fef7bd1c3d4cf10b64"
+
+inherit meson pkgconfig upstream-version-is-even gtk-doc multilib_script
+
+# if qemu usermode isn't available, this value needs to be set statically
+# (otherwise it's determinted by running a small target executable with qemu)
+do_write_config:append() {
+    cat >${WORKDIR}/cairo.cross <<EOF
+[properties]
+ipc_rmid_deferred_release = 'true'
+EOF
+}
+EXTRA_OEMESON:append:class-nativesdk = "${@' --cross-file ${WORKDIR}/cairo.cross' if d.getVar('EXEWRAPPER_ENABLED') == 'False' else ''}"
+EXTRA_OEMESON:append:class-target = "${@' --cross-file ${WORKDIR}/cairo.cross' if d.getVar('EXEWRAPPER_ENABLED') == 'False' else ''}"
+
+GTKDOC_MESON_OPTION = "gtk_doc"
+
+MULTILIB_SCRIPTS = "${PN}-perf-utils:${bindir}/cairo-trace"
+
+PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xlib xcb', '', d)} trace"
+PACKAGECONFIG[xlib] = "-Dxlib=enabled,-Dxlib=disabled,virtual/libx11 libxrender libxext"
+PACKAGECONFIG[xcb] = "-Dxcb=enabled,-Dxcb=disabled,libxcb"
+# cairo-trace is GPLv3 so add an option to remove it
+PACKAGECONFIG[trace] = ""
+
+do_install:append () {
+    if ! ${@bb.utils.contains('PACKAGECONFIG', 'trace', 'true', 'false', d)}; then
+        rm ${D}${bindir}/cairo-trace ${D}${libdir}/cairo/libcairo-trace.so
+        rmdir --ignore-fail-on-non-empty ${D}${bindir} ${D}${libdir}/cairo
+    fi
+}
+
+PACKAGES =+ "cairo-gobject cairo-script-interpreter cairo-perf-utils"
+
+SUMMARY:cairo-gobject = "The Cairo library GObject wrapper library"
+DESCRIPTION:cairo-gobject = "A GObject wrapper library for the Cairo API."
+
+SUMMARY:cairo-script-interpreter = "The Cairo library script interpreter"
+DESCRIPTION:cairo-script-interpreter = "The Cairo script interpreter implements \
+CairoScript.  CairoScript is used by tracing utilities to enable the ability \
+to replay rendering."
+
+DESCRIPTION:cairo-perf-utils = "The Cairo library performance utilities"
+
+FILES:${PN} = "${libdir}/libcairo.so.*"
+FILES:${PN}-gobject = "${libdir}/libcairo-gobject.so.*"
+FILES:${PN}-script-interpreter = "${libdir}/libcairo-script-interpreter.so.*"
+FILES:${PN}-perf-utils = "${bindir}/cairo-* ${libdir}/cairo/libcairo-trace.so ${libdir}/cairo/libcairo-fdr.so"
+
+BBCLASSEXTEND = "native nativesdk"
+
+UPSTREAM_CHECK_REGEX = "cairo-(?P<pver>\d+(\.\d+)+).tar.xz"
-- 
2.46.0


