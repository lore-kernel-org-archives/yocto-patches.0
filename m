Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977F1CD1292
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:00 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13172.1762633195728502600
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:19:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cXcLvLgm;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8804d05dfcaso22698116d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633194; x=1763237994; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmXPB6loC1AeQ6UQAlYp3J/cPwwTkCxFD+99KJJln+o=;
        b=cXcLvLgmED3Ss9MCkkJBqPpiZ+T+GgwqDBZN8Pqc2LCRmkOY/Xv2uE1rurgFXvHewy
         VyKSp+pUHet20a+TQ+K3qSQVBPg85RvqbXzqa04qbXlxbJZW/SuIffmtlK4a/6kgYpfl
         pJNtGcGx9jDny2KYip6K9H8WHE/BECLNtUehs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633194; x=1763237994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DmXPB6loC1AeQ6UQAlYp3J/cPwwTkCxFD+99KJJln+o=;
        b=oVuh8H/cSfjTxkC0Pg8oLJ2LInwancXDWenZ6RjBqZEV9D3/bqyDhbVO03QnkLBpT/
         Wu///hMA6dDtvk0vkUSmmi/k7H189P3S/08svc5owVCj73LtEYanF6/hDHZMQimF/fgb
         KAW8v1Lc6zz0W1IFPGCmqxx5IzSftSPHqIspt+djg66D+MzYETEUMWRWrZ5uTmzE1xra
         0gRLxwvXvEssKS96C+uBq/UhWq0W7l00WH81hvnZmNRhRgfrsLdQnS9eOATTfEQMDKgf
         TFx+iWr3mZNBUaw9C2LUsSMGRDQhCFCCfFDjoNbsXxfvcijP+lDltArPLVFtXtrx8OEq
         ebrA==
X-Gm-Message-State: AOJu0YxK27cXd/YWFhUidHaiDsA1HvLP68G8jBYz+Y59usStz+jA5zYa
	voFrK/JELUWdyGlLGKnvHeZTquaIhs7oqPAvbfxUg2jccfxpiUtgdl1a8wAai+rko+ywUo/SfIO
	lBiBa
X-Gm-Gg: ASbGncv/fL+r4dkx/53P2W0VHFPcWJR47jqWJE1O2I/OAsQRF3lyrvLr8ZGEEKOa6OX
	7vn5kt3tS4Mf3xxVmiTL+mKfnzdIz4POTVQJdLtLKa+D4y4qvtO9szmS0JaAOt5WaogtBK7//AO
	Fmb9OuC8vcmQhWDZ29pWGYuFfc3bpOv9PakjbATfhTWlAMy9HUK97rYBsCtaEfjZiH9rQfxts6W
	dSIPeNxkx9qZls7LqJXfQnA3cdM9rBwjarvo4ztieTfL84g9Dv4dKvtp68A4JS4N2i7U+L8kkQ7
	eSklZJ6Xa4MCPs2cb9iUdil/OCgg5St/xalt2wfcnA7OrCRFEXoS2K+csQYXQPR5eZ10jpUoHt0
	QFbaCWKIX3B4g3BvluLT7jkHdmNUEcNtqOI9xsc0zdZVtK/LSc32BuGzjgBpBfCXo1eXCbCSdW6
	C8xngN/7RnrGbjAf6aeIFLV4+4OmOX0+4gMh9ewHZpztv2NDkc1MSiiIywmFiEBDI=
X-Google-Smtp-Source: AGHT+IHcrCgpCviYQWGHFSPZGsz7ydJoyBfL4hNiB7qsioZSmqZ/6/l0FMrM+VkvH401UAwoQ8tmgg==
X-Received: by 2002:a05:6214:2242:b0:87c:1f80:7609 with SMTP id 6a1803df08f44-882386f91damr49439386d6.34.1762633194063;
        Sat, 08 Nov 2025 12:19:54 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 01/11] librsvg: add ptest support
Date: Sat,  8 Nov 2025 15:19:36 -0500
Message-ID: <a6a3d4a6fa3f49a5fb2e6477622e3ddc30bf19e7.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2448

From: Gyorgy Sarvari <skandigraun@gmail.com>

The suite is quick, it takes ~5 seconds on my machine to execute.

The tests consist of 2 or 3 parts, depending on how one counts them.

The apitest PACKAGACONFIG compiles tests for the c-interface, as part of
the main meson build. This apitest expects test data to be present in
a folder relative the test binary: ../../rsvg/tests folder.

ptest-cargo compiles two sets of test: rsvg-convert tests, and generic assorted
tests for the library, in multiple binaries.

The rsvg-convert tests expect test data to be present in a "tests" folder,
in the same folder where the test binaries are.

The library tests expect the tests to be in a folder called "tests", that's
location is specified by the CARGO_MANIFEST_DIR environment variable.

As part of compiling the cargo tests, rsvg-convert is also compiled specifically
for the tests, however it is not supposed to be different from the actual binary.
It is deleted from the test set, because of two reasons:
1. It is not bit-identical to the actually installed rsvg-convert (it is compiled differently,
   with cargo only, without meson)
2. ptest-cargo class treated it as a test binary, and tried to execute it, which resulted
   in failing/hanging test.

It is avoided by not installing this binary, but rather use the real rsvg package
as a runtime dependency, and create a symlink to it in the run-ptest script.

Added liberation-fonts as a runtime dependency to the tests - the rsvg-convert
tests require some fonts to be available to be able to render during some
svg->pdf conversion tests.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3aee16beac9b12403babfc7eef02be71b2297e70)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg/run-ptest | 17 +++++++++++++
 recipes-gnome/librsvg/librsvg_2.61.0.bb | 32 ++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 recipes-gnome/librsvg/librsvg/run-ptest

diff --git a/recipes-gnome/librsvg/librsvg/run-ptest b/recipes-gnome/librsvg/librsvg/run-ptest
new file mode 100644
index 0000000..da1c65f
--- /dev/null
+++ b/recipes-gnome/librsvg/librsvg/run-ptest
@@ -0,0 +1,17 @@
+#!/bin/sh
+export CARGO_MANIFEST_DIR="$(cd "$(dirname "$0")" && pwd)"
+cd $CARGO_MANIFEST_DIR
+
+ln -sf `which rsvg-convert` ./rsvg-convert
+
+./api_test/bin/api
+
+if [ $? = 0 ]; then
+  echo PASS: /usr/lib/librsvg/ptest/api_test/bin/api
+  rc=0
+else
+  echo FAIL: /usr/lib/librsvg/ptest/api_test/bin/api
+  rc=1
+fi
+
+# rust tests are appended here by ptest-cargo class
diff --git a/recipes-gnome/librsvg/librsvg_2.61.0.bb b/recipes-gnome/librsvg/librsvg_2.61.0.bb
index c1ecb39..700c5ef 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.0.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.0.bb
@@ -11,9 +11,10 @@ LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c"
 
 SECTION = "x11/utils"
 DEPENDS = "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-native cargo-c-native"
+RDEPENDS:${PN}-ptest += "rsvg liberation-fonts"
 BBCLASSEXTEND = "native nativesdk"
 
-inherit cargo_common gnomebase pixbufcache gobject-introspection rust vala gi-docgen cargo-update-recipe-crates
+inherit cargo_common gnomebase pixbufcache gobject-introspection rust vala gi-docgen cargo-update-recipe-crates ptest-cargo
 GIR_MESON_ENABLE_FLAG = 'enabled'
 GIR_MESON_DISABLE_FLAG = 'disabled'
 GIDOCGEN_MESON_OPTION = 'docs'
@@ -23,7 +24,8 @@ GIDOCGEN_MESON_DISABLE_FLAG = 'disabled'
 require ${BPN}-crates.inc
 
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
-            file://0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch"
+            file://0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch \
+            file://run-ptest"
 SRC_URI[archive.sha256sum] = "dbd0db40a1179a382fbb8cc930837671b973d722ba106a3dee2aad0fd858e2c4"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
@@ -58,17 +60,41 @@ LDFLAGS += " -L${B}/rsvg"
 # needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym'' errors
 BUILD_LDFLAGS += " -ldl"
 
-PACKAGECONFIG ??= "gdkpixbuf"
+PACKAGECONFIG ??= "gdkpixbuf ${@bb.utils.contains('PTEST_ENABLED', '1', 'apitest', '', d)}"
 PACKAGECONFIG:append:class-target = " ${@bb.utils.contains('GI_DATA_ENABLED', 'True', 'vala', '', d)}"
 # The gdk-pixbuf loader
 PACKAGECONFIG[gdkpixbuf] = "-Dpixbuf-loader=enabled,-Dpixbuf-loader=disabled,gdk-pixbuf-native"
 PACKAGECONFIG[vala] = "-Dvala=enabled,-Dvala=disabled"
+PACKAGECONFIG[apitest] = "-Dtests=true,-Dtests=false"
 
 do_install:append() {
 	# Loadable modules don't need .a or .la on Linux
 	rm -f ${D}${libdir}/gdk-pixbuf-2.0/*/loaders/*.a ${D}${libdir}/gdk-pixbuf-2.0/*/loaders/*.la
 }
 
+do_compile_ptest_cargo:prepend() {
+    # The packageconfig is for meson, but the rust tests are compiled directly with cargo,
+    # so these arguments don't apply. Note that this is Python, the intendation is intentional.
+    d.setVar('PACKAGECONFIG_CONFARGS', '')
+}
+
+do_compile_ptest:prepend() {
+	# rsvg-convert is the tested binary, which shouldn't be executed as a test.
+	# Beside this, it is not bit-identical to the actual rsvg-convert binary, so
+	# remove it from this list, as create  a symlink to the real thing from run-ptest script
+	sed -i '/rsvg-convert$/d' ${CARGO_TEST_BINARIES_FILES}
+}
+
+do_install_ptest:append() {
+	install -d ${D}${PTEST_PATH}/api_test/bin
+	cp -r ${S}/rsvg/tests ${D}${PTEST_PATH}
+	cp -r ${S}/rsvg_convert/tests ${D}${PTEST_PATH}
+	install ${B}/librsvg-c/tests-c/api ${D}${PTEST_PATH}/api_test/bin
+	# the api tests look for the required files in rsvg folder, so simulate it
+	# with a symlink that points to the current folder
+	ln -s . ${D}${PTEST_PATH}/rsvg
+}
+
 PACKAGES =+ "librsvg-gtk rsvg"
 FILES:rsvg = "${bindir}/rsvg* \
 	      ${datadir}/pixmaps/svg-viewer.svg \
-- 
2.51.0


