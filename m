Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE09C55177
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4472.1785497614910464104
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ajTn+mNM;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-934974844ffso21616185a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497614; x=1786102414; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9LH2sx7UcG3TP/Q2b9aOXbSY93E9AA/8tZd9Wl8Qdag=;
        b=ajTn+mNMaStUjDR9e1uRWzF+eSfjw6nsca6KAYSk1arCbGONWj4pbNyt3qT35UMJKC
         XZaBLGd4ymQTRjy96wJ+3UR0XGiQeCAyqEtE5eZhbnwfeWuDXk628kLh5iBgCNE/I+wc
         T+mVtLDccnzKvsXYmLN3UNCpfH+YvwkqK0Tzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497614; x=1786102414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9LH2sx7UcG3TP/Q2b9aOXbSY93E9AA/8tZd9Wl8Qdag=;
        b=Qqh8JxB49tdJS/V/Gn1xhNj/9GAZAWcYyFqBuSlkS36sHwP7iQIRunSVRSizh7BWiA
         tSXPzLpASaA0VtImTKr24Xu1R6F26emZPXYdGE5Mfp7p2P7oN/lP0xsIAPWoNPYMJdLY
         C5wbZGdRu26kUUx70KksfJ6uvaqlg28TPd/8xxPOGfngCvqkL4UzVkdlvgJCDGjwQ6Fc
         dmBZ3IWrJt7tUZaHG0Znx8vP0CT0ifuW5k6nzfK4jCXqjilLwVDvoGj/SEncsGLXyMtW
         hvzaqXnv3us+7rrflqrESuENxZI2XJQ1RYz/I4wjhzZnouoTBReZ1zhHqZAm+tskwSnr
         PF9Q==
X-Gm-Message-State: AOJu0YxDuiIIz+IMqX3oADRz8xzK2lqWvP+tIAsgC/eNI+9ho3OuDATt
	zIz1J7OVxShmnknBK5bQx92mJ58w3EccrKURF66w1jD4MCmPHEzYmxKN78W6uDggt+dVHdyoT41
	hDc2P
X-Gm-Gg: AR+sD1310YvgcXC5GuvRJ7zD/phdYiJxz3edrmGipxCxhJy8JgmniiQocj5j5pKorm9
	pRv+AU8f0zm2w3+wEvZHcPzPRwBxwFsjRz+4sdI7UdHqGvOeuDwy3itd9OlI0ywNiJ11YDyTiX2
	ZOzwZfOEea07VJMKIPYq1p+iWy6meNv5TTREIhfJ2dVzW9c5ktma64yZRMdBCqXyKYR1JZ8PpS1
	0xaKhOM72QYolz1atif+oEcr7sOdhUsSpGuTHJUS2qZjJtJ3EmJNYjx814YGza8SJTNLd+nC6Eo
	F9Nyb2js+cTeA8it0tmk6i2W4OoVvWf4SB5/JQCRvPmou5CN8BJLV8uqyWM4eMkqhrf56TU13S+
	LayovSroOWLnGTvXx8qefp0W3svZrgGxY9L3CJLFbHX+6NJcrVZ4fBjn1YQ/RuFqmEomhO42bfT
	+bpbKEg8zBHsS4zReA7+Ox4ZNWsSUKHCVKFh23qmRPGkxW8apyCl+h2sCLp1cIlgo2EeIKi2r49
	0ygMyFSUSHQ8bgjzVJ9G7FuA3oDfYR6HMbZv0mwBPZRkteEibRO3aPq27kmtBRM4BmO+ejk91fU
	srvbsnPMQSUWqDIeN0gg2dksxA==
X-Received: by 2002:a05:620a:2407:20b0:930:a635:a782 with SMTP id af79cd13be357-934965aa073mr171476485a.11.1785497613516;
        Fri, 31 Jul 2026 04:33:33 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:33 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 21/35] librsvg: rewrite cross gdk-pixbuf-query-loaders handling
Date: Fri, 31 Jul 2026 07:32:51 -0400
Message-ID: <b7f6197612bef1e57bb488030f4ef378fc7dbb5d.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4597

From: Ross Burton <ross.burton@arm.com>

There's been a number of attempts at fixing the logic as to when to run
gdk-pixbuf-query-loaders in cross builds. Originally the build failed in
cross so we worked around that, then upstream changed it so that if exe
wrappers are enabled it will run those but our target sysroot doesn't
have binaries so that also fails.

This rework should be upstreamable once it's been shaken out in OE for a
while, and improves the logic so that in cross builds the existance of
gdk-pixbuf-query-loaders is an optional dependency, which is ideal for
our needs as we won't be running it at install-time anyway.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit dbbeae4fc55605d90c8ae9530fe818c124c18908)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 -------
 .../librsvg/librsvg/cross-query-loaders.patch | 128 ++++++++++++++++++
 recipes-gnome/librsvg/librsvg_2.61.3.bb       |   2 +-
 3 files changed, 129 insertions(+), 50 deletions(-)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/cross-query-loaders.patch

diff --git a/recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch b/recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
deleted file mode 100644
index b62f641..0000000
--- a/recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
+++ /dev/null
@@ -1,49 +0,0 @@
-From 33ece256bf7c156a34ab1ee3709718e38829cc9e Mon Sep 17 00:00:00 2001
-From: Gyorgy Sarvari <skandigraun@gmail.com>
-Date: Wed, 6 Aug 2025 13:50:21 +0200
-Subject: [PATCH] Revert "meson.build: do not force-disable gdk-pixbuf-loader
- in cross builds"
-
-This reverts commit 994582cfa995d00f9472dc22f8237b6571b4c510.
-
-The commit that enabled gdk-pixbuf-loader for non-cross builds, references
-a commit that enabled other binaries, claiming that they can be executed with
-a qemu wrapper.
-
-There is one difference - the projects that were enabled by that commit support such
-wrappers officially (see `gi_cross_binary_wrapper` and related build options for g-i).
-However such support is missing from gdk-pixbuf-loader unfortunately, which can cause
-build failures when cross compiling.
-
-To avoid this, revert back to disable gdk-pixbuf-loader for cross-builds
-(until it gains a similar feature).
-
-Upstream-Status: Submitted [https://gitlab.gnome.org/GNOME/librsvg/-/merge_requests/1123]
-
-Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
----
- gdk-pixbuf-loader/meson.build | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/gdk-pixbuf-loader/meson.build b/gdk-pixbuf-loader/meson.build
-index 6fa10a6..c51d803 100644
---- a/gdk-pixbuf-loader/meson.build
-+++ b/gdk-pixbuf-loader/meson.build
-@@ -36,7 +36,7 @@ pixbuf_thumbnailer = configure_file(
-   install_dir: get_option('datadir') / 'thumbnailers'
- )
- 
--if meson.can_run_host_binaries()
-+if not meson.is_cross_build()
-   gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'))
- endif
- 
-@@ -48,7 +48,7 @@ pixbufloader_svg_install_args = [
- ]
- 
- # Tell people to run gdk-pixbuf-query-loaders manually for cross builds
--if not meson.can_run_host_binaries()
-+if meson.is_cross_build()
-   pixbufloader_svg_install_args += '--show-cross-message'
- endif
- 
diff --git a/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch b/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch
new file mode 100644
index 0000000..ab0ca2b
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/cross-query-loaders.patch
@@ -0,0 +1,128 @@
+gdk-pixbuf-loader/meson_install: improve argument parsing and logic
+
+Make the arguments more explicit by changing the path arguments to be
+specified with options, such as --queryloaders <path>. Previously one of
+the paths had an option, but the others were order-based.
+
+Check that either all of the paths have been set or --show-cross-message
+has been passed. If this is not the case, print the usage and exit.
+
+Clean up Path usage, as the options are using pathlib.Path types in the
+parser another Path instance does not need to be created.
+
+None of this changes the underlying logic, just makes it more consistent
+and explicit.
+
+
+gdk-pixbuf-loader: fix install logic in cross builds
+
+The logic in this install rule was getting complicated, but it should be
+quite simple really:
+
+- In native builds we can run host binaries.  Look for the
+  gdk-pixbuf-query-loaders tool and run it when installing.
+- In cross builds we might be able to run host binaries, if an executable
+  wrapper has been set _and_ if the target sysroot contains executables.
+
+The presence of target executables isn't a given, as some systems (such
+as OpenEmbedded) strip the target sysroot down to headers are libraries.
+
+So the logic should be:
+
+- In native builds, look for query-loaders and fail if not found.
+- In cross builds where you can run host binaries, look for query-loaders
+  but allow it to be missing.
+- In cross builds where you cannot run host binaries, there's no use in
+  looking for query-loaders.
+
+Then either pass the paths or --show-cross-message to meson_install.py,
+depending on whether query-loaders was found or not.
+
+This fixes the case where Meson can run host executables, but the target
+sysroot does not actually contain gdk-pixbuf-query-loaders.
+
+Upstream-Status: Pending
+Signed-off-by: Ross Burton <ross.burton@arm.com>
+
+diff --git i/gdk-pixbuf-loader/meson.build w/gdk-pixbuf-loader/meson.build
+index 6fa10a68b..4f88ba037 100644
+--- i/gdk-pixbuf-loader/meson.build
++++ w/gdk-pixbuf-loader/meson.build
+@@ -37,19 +37,21 @@ pixbuf_thumbnailer = configure_file(
+ )
+ 
+ if meson.can_run_host_binaries()
+-  gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'))
++  gdk_pixbuf_query_loaders = find_program(pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', default_value: 'gdk-pixbuf-query-loaders'), required: not meson.is_cross_build())
+ endif
+ 
+-pixbufloader_svg_install_args = [
+-  '--gdk-pixbuf-moduledir',
+-  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_define: ['prefix', prefix]),
+-  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_query_loaders', pkgconfig_define: ['prefix', prefix]),
+-  pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_cache_file', pkgconfig_define: ['prefix', prefix])
+-]
+-
+-# Tell people to run gdk-pixbuf-query-loaders manually for cross builds
+-if not meson.can_run_host_binaries()
+-  pixbufloader_svg_install_args += '--show-cross-message'
++if meson.can_run_host_binaries() and gdk_pixbuf_query_loaders.found()
++  pixbufloader_svg_install_args = [
++    '--moduledir',
++    pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_moduledir', pkgconfig_define: ['prefix', prefix]),
++    '--queryloaders',
++    gdk_pixbuf_query_loaders.full_path(),
++    '--cache-file',
++    pixbuf_dep.get_variable(pkgconfig: 'gdk_pixbuf_cache_file', pkgconfig_define: ['prefix', prefix])
++  ]
++else
++  # Tell people to run gdk-pixbuf-query-loaders manually for cross builds
++  pixbufloader_svg_install_args = ['--show-cross-message']
+ endif
+ 
+ meson.add_install_script(
+diff --git i/gdk-pixbuf-loader/meson_install.py w/gdk-pixbuf-loader/meson_install.py
+index ff003350f..d9bbbe433 100644
+--- i/gdk-pixbuf-loader/meson_install.py
++++ w/gdk-pixbuf-loader/meson_install.py
+@@ -6,29 +6,28 @@ import os
+ import subprocess
+ import sys
+ 
+-argparse = ArgumentParser('Deploy loaders.cache')
+-
+-argparse.add_argument('--gdk-pixbuf-moduledir', type=Path)
+-argparse.add_argument('gdk_pixbuf_queryloaders', type=Path)
+-argparse.add_argument('gdk_pixbuf_cache_file', type=Path)
+-argparse.add_argument('--show-cross-message', action='store_true')
+-
+ if __name__ == '__main__':
++    argparse = ArgumentParser(description='Deploy loaders.cache. Pass required paths, or --show-cross-message.')
++    argparse.add_argument('--queryloaders', type=Path, metavar="PATH", help="gdk-pixbuf-queryloaders to run")
++    argparse.add_argument('--moduledir', type=Path, metavar="PATH", help="installed gdk-pixbuf module directory")
++    argparse.add_argument('--cache-file', type=Path, metavar="PATH", help="module cache file to write")
++    argparse.add_argument('--show-cross-message', action='store_true', help="tell the user to run query-loaders manually")
+     args = argparse.parse_args()
+ 
+-    cache_file: Path = args.gdk_pixbuf_cache_file
++    if not(args.show_cross_message or (args.queryloaders and args.moduledir and args.cache_file)):
++        argparse.print_help()
++        sys.exit(1)
+ 
+     if args.show_cross_message or os.environ.get("DESTDIR"):
+         print('*** Note: Please run gdk-pixbuf-queryloaders manually ' +
+               'against the newly-built gdkpixbuf-svg loader', file=sys.stderr)
+     else:
+         env = os.environ.copy()
+-        env['GDK_PIXBUF_MODULEDIR'] = Path(args.gdk_pixbuf_moduledir).as_posix()
+-        with cache_file.open('w', encoding='utf-8') as f:
++        env['GDK_PIXBUF_MODULEDIR'] = args.moduledir.as_posix()
++        with args.cache_file.open('w', encoding='utf-8') as f:
+             subprocess.run(
+-                [Path(args.gdk_pixbuf_queryloaders).as_posix()],
++                [args.queryloaders.as_posix()],
+                 env=env,
+                 stdout=f,
+                 check=True
+             )
+-
diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index e9a14c6..a7494ac 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -24,8 +24,8 @@ GIDOCGEN_MESON_DISABLE_FLAG = 'disabled'
 require ${BPN}-crates.inc
 
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
-            file://0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
+            file://cross-query-loaders.patch \
             file://run-ptest"
 SRC_URI[archive.sha256sum] = "a56d2c80d744ad2f2718f85df466fe71d24ff1f9bc3e5ef588bde4d7e87815f2"
 
-- 
2.55.0


