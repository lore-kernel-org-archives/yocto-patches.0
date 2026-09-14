Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275AC88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:13:33 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5849.1789413208393070429
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:13:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=dBTl7AEV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-20260914191326baeca44130000207dd-yql8kd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260914191326baeca44130000207dd
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:13:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MxtQlsvAEiTbkSvvCzSkjXdsDtS49yw9w4RXkmP/XTg=;
 b=dBTl7AEVJK8abpfBh+Ny8mazbUZFkZKT9ubMZxNI59bkF3AP5WM0WGxttYUJmJCopl/XWw
 roHwhO+GY6NefmcrHzOvC7AN/5gfLWnUMhkBzdirgTHwOK8SGNIgR4rIknhXwypYgRw7e3Ey
 eCSnlU8fPjy5z+xGoSPGcd2cU0pU71pE9YEHaLXGRIY2ROJX0viEYGEUj6w/Tb55ag1dY7b7
 RnqdOqoyshnEN5Eio5kYGTLfD518DK0MR/C2L06Cvs8lHrgN8hn9yGIE/Uhz6Pt7qIQ37p5I
 haOqva4SoiDXWpgT5tfSxMN2uYnzxJZNgvezjjgTIpkfeAcIwYEKiAHQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 03/11] go: add from openembedded-core wrynose
Date: Mon, 14 Sep 2026 21:12:32 +0200
Message-ID: <20260914191240.1066469-3-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:13:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4830

From: Peter Marko <peter.marko@siemens.com>

Taken from oe-core f5d807c50beaac084c14e42e1f9cc8041b757862 which is
between yocto-6.0.3 and yocto-6.0.4.

Version 1.26.7 is the last version from master before upgrading to
1.27.0. The only difference in master and wrynose recipes is ptest
support which will be added in later backport commit.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.26.7.inc             |  19 ++
 .../go/go-binary-native_1.26.7.bb             |  52 ++++
 recipes-devtools/go/go-common.inc             |  48 ++++
 recipes-devtools/go/go-cross-canadian.inc     |  62 +++++
 .../go/go-cross-canadian_1.26.7.bb            |   2 +
 recipes-devtools/go/go-cross.inc              |  54 +++++
 recipes-devtools/go/go-cross_1.26.7.bb        |   2 +
 recipes-devtools/go/go-crosssdk.inc           |  44 ++++
 recipes-devtools/go/go-crosssdk_1.26.7.bb     |   2 +
 recipes-devtools/go/go-runtime.inc            |  94 ++++++++
 recipes-devtools/go/go-runtime_1.26.7.bb      |   3 +
 recipes-devtools/go/go-target.inc             |  53 +++++
 ...ent-based-hash-generation-less-pedan.patch | 173 ++++++++++++++
 ...OOLDIR-to-be-overridden-in-the-envir.patch |  56 +++++
 ...3-ld-add-soname-to-shareable-objects.patch |  51 ++++
 ...de-CC-when-building-dist-and-go_boot.patch |  48 ++++
 ...dist-separate-host-and-target-builds.patch | 224 ++++++++++++++++++
 ...d-go-make-GOROOT-precious-by-default.patch | 114 +++++++++
 ...ut-build-specific-paths-from-linker-.patch |  63 +++++
 ...ldgo.go-do-not-hardcode-host-compile.patch |  46 ++++
 ...uild-paths-on-staticly-linked-arches.patch |  61 +++++
 ...OOT-for-func-ldShared-when-trimpath-.patch |  48 ++++
 recipes-devtools/go/go_1.26.7.bb              |  18 ++
 23 files changed, 1337 insertions(+)
 create mode 100644 recipes-devtools/go/go-1.26.7.inc
 create mode 100644 recipes-devtools/go/go-binary-native_1.26.7.bb
 create mode 100644 recipes-devtools/go/go-common.inc
 create mode 100644 recipes-devtools/go/go-cross-canadian.inc
 create mode 100644 recipes-devtools/go/go-cross-canadian_1.26.7.bb
 create mode 100644 recipes-devtools/go/go-cross.inc
 create mode 100644 recipes-devtools/go/go-cross_1.26.7.bb
 create mode 100644 recipes-devtools/go/go-crosssdk.inc
 create mode 100644 recipes-devtools/go/go-crosssdk_1.26.7.bb
 create mode 100644 recipes-devtools/go/go-runtime.inc
 create mode 100644 recipes-devtools/go/go-runtime_1.26.7.bb
 create mode 100644 recipes-devtools/go/go-target.inc
 create mode 100644 recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
 create mode 100644 recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
 create mode 100644 recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
 create mode 100644 recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
 create mode 100644 recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
 create mode 100644 recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
 create mode 100644 recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
 create mode 100644 recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
 create mode 100644 recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
 create mode 100644 recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
 create mode 100644 recipes-devtools/go/go_1.26.7.bb

diff --git a/recipes-devtools/go/go-1.26.7.inc b/recipes-devtools/go/go-1.26.7.inc
new file mode 100644
index 0000000..fed8701
--- /dev/null
+++ b/recipes-devtools/go/go-1.26.7.inc
@@ -0,0 +1,19 @@
+require go-common.inc
+
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/go:"
+
+LIC_FILES_CHKSUM = "file://LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
+
+SRC_URI += "\
+    file://0001-cmd-go-make-content-based-hash-generation-less-pedan.patch \
+    file://0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch \
+    file://0003-ld-add-soname-to-shareable-objects.patch \
+    file://0004-make.bash-override-CC-when-building-dist-and-go_boot.patch \
+    file://0005-cmd-dist-separate-host-and-target-builds.patch \
+    file://0006-cmd-go-make-GOROOT-precious-by-default.patch \
+    file://0007-exec.go-filter-out-build-specific-paths-from-linker-.patch \
+    file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
+    file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
+    file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
+"
+SRC_URI[main.sha256sum] = "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
diff --git a/recipes-devtools/go/go-binary-native_1.26.7.bb b/recipes-devtools/go/go-binary-native_1.26.7.bb
new file mode 100644
index 0000000..753f1b1
--- /dev/null
+++ b/recipes-devtools/go/go-binary-native_1.26.7.bb
@@ -0,0 +1,52 @@
+# This recipe is for bootstrapping our go-cross from a prebuilt binary of Go from golang.org.
+
+SUMMARY = "Go programming language compiler (upstream binary for bootstrap)"
+HOMEPAGE = " http://golang.org/"
+LICENSE = "BSD-3-Clause"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
+
+PROVIDES = "go-native"
+
+# Checksums available at https://go.dev/dl/
+SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
+SRC_URI[go_linux_amd64.sha256sum] = "ffb5f8de10c62550dfddab66b36b57030721e0a44a3218e9e1181d7b59f121ca"
+SRC_URI[go_linux_arm64.sha256sum] = "5a4ec883379d51ee9ce1040d5e87f8d35e20387574dd8c947feb01eabc3c1b37"
+SRC_URI[go_linux_ppc64le.sha256sum] = "22d3b362d557175fd16b79651cab0cad64f8aaaedca745f66d16f44d56bc5de1"
+
+UPSTREAM_CHECK_URI = "https://golang.org/dl/"
+UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
+
+CVE_PRODUCT = "golang:go"
+CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
+CVE_STATUS[CVE-2024-24786] = "cpe-incorrect: this CVE is for golang-google-protobuf"
+
+S = "${UNPACKDIR}/go"
+
+inherit goarch native
+
+do_compile() {
+    :
+}
+
+make_wrapper() {
+	rm -f ${D}${bindir}/$1
+	cat <<END >${D}${bindir}/$1
+#!/bin/bash
+here=\`dirname \$0\`
+export GOROOT="${GOROOT:-\`readlink -f \$here/../lib/go\`}"
+\$here/../lib/go/bin/$1 "\$@"
+END
+	chmod +x ${D}${bindir}/$1
+}
+
+do_install() {
+    find ${S} -depth -type d -name testdata -exec rm -rf {} +
+
+	install -d ${D}${bindir} ${D}${libdir}/go
+	cp --preserve=mode,timestamps -R ${S}/ ${D}${libdir}/
+
+	for f in ${S}/bin/*
+	do
+	  	make_wrapper `basename $f`
+	done
+}
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
new file mode 100644
index 0000000..5d0177b
--- /dev/null
+++ b/recipes-devtools/go/go-common.inc
@@ -0,0 +1,48 @@
+SUMMARY = "Go programming language compiler"
+DESCRIPTION = " The Go programming language is an open source project to make \
+ programmers more productive. Go is expressive, concise, clean, and\
+ efficient. Its concurrency mechanisms make it easy to write programs\
+ that get the most out of multicore and networked machines, while its\
+ novel type system enables flexible and modular program construction.\
+ Go compiles quickly to machine code yet has the convenience of\
+ garbage collection and the power of run-time reflection. It's a\
+ fast, statically typed, compiled language that feels like a\
+ dynamically typed, interpreted language."
+
+HOMEPAGE = " http://golang.org/"
+LICENSE = "BSD-3-Clause"
+
+inherit goarch
+
+SRC_URI = "https://golang.org/dl/go${PV}.src.tar.gz;name=main"
+S = "${UNPACKDIR}/go"
+B = "${S}"
+UPSTREAM_CHECK_REGEX = "(?P<pver>\d+(\.\d+)+)\.src\.tar"
+
+# all recipe variants are created from the same product
+CVE_PRODUCT = "golang:go"
+CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
+CVE_STATUS[CVE-2024-24786] = "cpe-incorrect: this CVE is for golang-google-protobuf"
+
+INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
+SSTATE_SCAN_CMD = "true"
+
+export GOROOT_OVERRIDE = "1"
+export GOTMPDIR ?= "${WORKDIR}/build-tmp"
+GOTMPDIR[vardepvalue] = ""
+export CGO_ENABLED = "1"
+
+export GOHOSTOS ?= "${BUILD_GOOS}"
+export GOHOSTARCH ?= "${BUILD_GOARCH}"
+export GOROOT_BOOTSTRAP ?= "${STAGING_LIBDIR_NATIVE}/go"
+export GOOS ?= "${TARGET_GOOS}"
+export GOARCH ?= "${TARGET_GOARCH}"
+export GOARM ?= "${TARGET_GOARM}"
+export GO386 ?= "${TARGET_GO386}"
+export GOMIPS ?= "${TARGET_GOMIPS}"
+
+export GODEBUG = "gocachehash=1"
+
+do_compile:prepend() {
+	BUILD_CC=${BUILD_CC}
+}
diff --git a/recipes-devtools/go/go-cross-canadian.inc b/recipes-devtools/go/go-cross-canadian.inc
new file mode 100644
index 0000000..4a6f2f4
--- /dev/null
+++ b/recipes-devtools/go/go-cross-canadian.inc
@@ -0,0 +1,62 @@
+inherit cross-canadian
+
+DEPENDS = "go-native virtual/${HOST_PREFIX}go virtual/nativesdk-${HOST_PREFIX}go-runtime \
+           virtual/nativesdk-cross-cc virtual/nativesdk-libc \
+           virtual/nativesdk-compilerlibs"
+PN = "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+
+GOARCH = "${HOST_GOARCH}"
+
+# it uses gcc on build machine during go-cross-canadian bootstrap, but
+# the gcc version may be old and not support option '-fmacro-prefix-map'
+# which is one of default values of DEBUG_PREFIX_MAP
+DEBUG_PREFIX_MAP = "-fdebug-prefix-map=${WORKDIR}=${TARGET_DBGSRC_DIR} \
+                    -fdebug-prefix-map=${STAGING_DIR_HOST}= \
+                    -fdebug-prefix-map=${STAGING_DIR_NATIVE}= \
+                    "
+
+export GOTOOLDIR_BOOTSTRAP = "${STAGING_LIBDIR_NATIVE}/${HOST_SYS}/go/pkg/tool/${BUILD_GOTUPLE}"
+export CGO_CFLAGS = "${CFLAGS}"
+export CGO_LDFLAGS = "${LDFLAGS}"
+export GO_LDFLAGS = '-extld ${HOST_PREFIX}gcc -extldflags "--sysroot=${STAGING_DIR_HOST} ${SECURITY_NOPIE_CFLAGS} ${HOST_CC_ARCH} ${LDFLAGS}"'
+
+do_configure[noexec] = "1"
+
+do_compile() {
+	export CC_FOR_${HOST_GOTUPLE}="${HOST_PREFIX}gcc --sysroot=${STAGING_DIR_HOST} ${SECURITY_NOPIE_CFLAGS}"
+	export CXX_FOR_${HOST_GOTUPLE}="${HOST_PREFIX}gxx --sysroot=${STAGING_DIR_HOST} ${SECURITY_NOPIE_CFLAGS}"
+	cd src
+	./make.bash --target-only --no-banner
+	cd ${B}
+}
+do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
+
+make_wrapper() {
+	rm -f ${D}${bindir}/$2
+	cat <<END >${D}${bindir}/$2
+#!/bin/sh
+here=\`dirname \$0\`
+native_goroot=\`readlink -f \$here/../../lib/${TARGET_SYS}/go\`
+export GOARCH="${TARGET_GOARCH}"
+export GOOS="${TARGET_GOOS}"
+test -n "\$GOARM" || export GOARM="${TARGET_GOARM}"
+test -n "\$GO386" || export GO386="${TARGET_GO386}"
+test -n "\$GOMIPS" || export GOMIPS="${TARGET_GOMIPS}"
+export GOTOOLDIR="\$native_goroot/pkg/tool/${HOST_GOTUPLE}"
+test -n "\$GOROOT" || export GOROOT="\$OECORE_TARGET_SYSROOT/${target_libdir}/go"
+\$here/../../lib/${TARGET_SYS}/go/bin/$1 "\$@"
+END
+	chmod +x ${D}${bindir}/$2
+}
+
+do_install() {
+	install -d ${D}${libdir}/go/pkg/tool
+	cp --preserve=mode,timestamps -R ${B}/pkg/tool/${HOST_GOTUPLE} ${D}${libdir}/go/pkg/tool/
+	install -d ${D}${bindir} ${D}${libdir}/go/bin
+	for f in $(find ${B}/${GO_BUILD_BINDIR} -type f)
+	do
+		base=`basename $f`
+		install -m755 $f ${D}${libdir}/go/bin
+		make_wrapper $base ${TARGET_PREFIX}$base
+	done
+}
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.7.bb b/recipes-devtools/go/go-cross-canadian_1.26.7.bb
new file mode 100644
index 0000000..7ac9449
--- /dev/null
+++ b/recipes-devtools/go/go-cross-canadian_1.26.7.bb
@@ -0,0 +1,2 @@
+require go-cross-canadian.inc
+require go-${PV}.inc
diff --git a/recipes-devtools/go/go-cross.inc b/recipes-devtools/go/go-cross.inc
new file mode 100644
index 0000000..ebee2e5
--- /dev/null
+++ b/recipes-devtools/go/go-cross.inc
@@ -0,0 +1,54 @@
+inherit cross
+
+PROVIDES = "virtual/${TUNE_PKGARCH}-go"
+DEPENDS = "go-native"
+
+PN = "go-cross-${TUNE_PKGARCH}"
+
+CCACHE_DISABLE = "1"
+
+export GOCACHE = "${B}/.cache"
+CC = "${@d.getVar('BUILD_CC').strip()}"
+
+do_configure[noexec] = "1"
+
+do_compile() {
+	export CC_FOR_${TARGET_GOTUPLE}="${TARGET_PREFIX}gcc ${TARGET_CC_ARCH} --sysroot=${STAGING_DIR_TARGET}"
+	export CXX_FOR_${TARGET_GOTUPLE}="${TARGET_PREFIX}g++ ${TARGET_CC_ARCH} --sysroot=${STAGING_DIR_TARGET}"
+	cd src
+	./make.bash --host-only --no-banner
+	cd ${B}
+}
+do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
+
+make_wrapper() {
+	rm -f ${D}${bindir}/$2
+	cat <<END >${D}${bindir}/$2
+#!/bin/bash
+here=\`dirname \$0\`
+export GOARCH="${TARGET_GOARCH}"
+export GOOS="${TARGET_GOOS}"
+export GOARM="\${GOARM:-${TARGET_GOARM}}"
+export GO386="\${GO386:-${TARGET_GO386}}"
+export GOMIPS="\${GOMIPS:-${TARGET_GOMIPS}}"
+\$here/../../lib/${CROSS_TARGET_SYS_DIR}/go/bin/$1 "\$@"
+END
+	chmod +x ${D}${bindir}/$2
+}
+
+do_install() {
+	install -d ${D}${libdir}/go
+	cp --preserve=mode,timestamps -R ${B}/pkg ${D}${libdir}/go/
+	install -d ${D}${libdir}/go/src
+	(cd ${S}/src; for d in *; do \
+		[ ! -d $d ] || cp --preserve=mode,timestamps -R ${S}/src/$d ${D}${libdir}/go/src/; \
+	done)
+	find ${D}${libdir}/go/src -depth -type d -name testdata -exec rm -rf {} \;
+	install -d ${D}${bindir} ${D}${libdir}/go/bin
+	for f in ${B}/bin/*
+	do
+		base=`basename $f`
+		install -m755 $f ${D}${libdir}/go/bin
+		make_wrapper $base ${TARGET_PREFIX}$base
+	done
+}
diff --git a/recipes-devtools/go/go-cross_1.26.7.bb b/recipes-devtools/go/go-cross_1.26.7.bb
new file mode 100644
index 0000000..80b5a03
--- /dev/null
+++ b/recipes-devtools/go/go-cross_1.26.7.bb
@@ -0,0 +1,2 @@
+require go-cross.inc
+require go-${PV}.inc
diff --git a/recipes-devtools/go/go-crosssdk.inc b/recipes-devtools/go/go-crosssdk.inc
new file mode 100644
index 0000000..4f19025
--- /dev/null
+++ b/recipes-devtools/go/go-crosssdk.inc
@@ -0,0 +1,44 @@
+inherit crosssdk
+
+DEPENDS = "go-native virtual/nativesdk-cross-cc virtual/nativesdk-compilerlibs virtual/nativesdk-cross-binutils"
+PN = "go-crosssdk-${SDK_SYS}"
+PROVIDES = "virtual/${TARGET_PREFIX}go"
+
+export GOCACHE = "${B}/.cache"
+
+do_configure[noexec] = "1"
+
+do_compile() {
+	export CC_FOR_${TARGET_GOTUPLE}="${TARGET_PREFIX}gcc ${TARGET_CC_ARCH} --sysroot=${STAGING_DIR_TARGET}${SDKPATHNATIVE}"
+	export CXX_FOR_${TARGET_GOTUPLE}="${TARGET_PREFIX}g++ ${TARGET_CC_ARCH} --sysroot=${STAGING_DIR_TARGET}${SDKPATHNATIVE}"
+	cd src
+	./make.bash --host-only --no-banner
+	cd ${B}
+}
+do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
+
+make_wrapper() {
+    rm -f ${D}${bindir}/$2
+    cat <<END >${D}${bindir}/$2
+#!/bin/bash
+here=\`dirname \$0\`
+export GOARCH="${TARGET_GOARCH}"
+export GOOS="${TARGET_GOOS}"
+\$here/../../lib/${CROSS_TARGET_SYS_DIR}/go/bin/$1 "\$@"
+END
+    chmod +x ${D}${bindir}/$2
+}
+
+do_install() {
+	install -d ${D}${libdir}/go
+	install -d ${D}${libdir}/go/bin
+	install -d ${D}${libdir}/go/pkg/tool
+	install -d ${D}${bindir}
+	cp --preserve=mode,timestamps -R ${S}/pkg/tool/${BUILD_GOTUPLE} ${D}${libdir}/go/pkg/tool/
+	for f in ${B}/bin/*
+	do
+		base=`basename $f`
+		install -m755 $f ${D}${libdir}/go/bin
+		make_wrapper $base ${TARGET_PREFIX}$base
+	done
+}
diff --git a/recipes-devtools/go/go-crosssdk_1.26.7.bb b/recipes-devtools/go/go-crosssdk_1.26.7.bb
new file mode 100644
index 0000000..1857c8a
--- /dev/null
+++ b/recipes-devtools/go/go-crosssdk_1.26.7.bb
@@ -0,0 +1,2 @@
+require go-crosssdk.inc
+require go-${PV}.inc
diff --git a/recipes-devtools/go/go-runtime.inc b/recipes-devtools/go/go-runtime.inc
new file mode 100644
index 0000000..e5f1733
--- /dev/null
+++ b/recipes-devtools/go/go-runtime.inc
@@ -0,0 +1,94 @@
+DEPENDS = "virtual/${TUNE_PKGARCH}-go go-native"
+DEPENDS:class-nativesdk = "virtual/${TARGET_PREFIX}go"
+PROVIDES = "virtual/${TARGET_PREFIX}go-runtime"
+
+DEBUG_PREFIX_MAP = "\
+                     -fdebug-prefix-map=${STAGING_DIR_HOST}= \
+                     -fdebug-prefix-map=${STAGING_DIR_NATIVE}= \
+"
+
+export CGO_CFLAGS = "${CFLAGS}"
+export CGO_CPPFLAGS = "${CPPFLAGS}"
+export CGO_CXXFLAGS = "${CXXFLAGS}"
+# Filter out -fdebug-prefix-map options as they clash with the GO's build system
+export CGO_LDFLAGS = "${@ ' '.join(filter(lambda f: not f.startswith('-fdebug-prefix-map'), d.getVar('LDFLAGS').split())) }"
+export GOCACHE = "${B}/.cache"
+
+GO_EXTLDFLAGS ?= "${HOST_CC_ARCH}${TOOLCHAIN_OPTIONS} ${LDFLAGS}"
+GO_SHLIB_LDFLAGS ?= '-ldflags="-extldflags '${GO_EXTLDFLAGS}'"'
+
+do_configure() {
+	:
+}
+
+do_configure:libc-musl() {
+	rm -f ${S}/src/runtime/race/*.syso
+}
+
+do_compile() {
+	export CC_FOR_${TARGET_GOTUPLE}="${CC}"
+	export CXX_FOR_${TARGET_GOTUPLE}="${CXX}"
+
+	cd src
+	./make.bash --target-only --no-banner std
+	if [ -n "${GO_DYNLINK}" ]; then
+		export GOTOOLDIR="${B}/pkg/tool/native_native"
+		CC="$CC_FOR_${TARGET_GOTUPLE}" GOARCH="${TARGET_GOARCH}" GOOS="${TARGET_GOOS}" GOROOT=${B} \
+			$GOTOOLDIR/go_bootstrap install -linkshared -trimpath -buildmode=shared ${GO_SHLIB_LDFLAGS} std
+	fi
+	cd ${B}
+}
+do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
+
+do_install() {
+	install -d ${D}${libdir}/go/src
+	cp --preserve=mode,timestamps -R ${B}/pkg ${D}${libdir}/go/
+	if [ "${BUILD_GOTUPLE}" != "${TARGET_GOTUPLE}" ]; then
+		rm -rf ${D}${libdir}/go/pkg/${BUILD_GOTUPLE}
+		rm -rf ${D}${libdir}/go/pkg/obj/${BUILD_GOTUPLE}
+	fi
+	rm -rf ${D}${libdir}/go/pkg/tool
+	rm -rf ${D}${libdir}/go/pkg/obj
+	rm -rf ${D}${libdir}/go/pkg/bootstrap
+	# the cmd directory is built for the native arch so if BUILD == TARGET
+	rm -rf ${D}${libdir}/go/pkg/${BUILD_GOTUPLE}/cmd
+	find src -mindepth 1 -maxdepth 1 -type d | while read srcdir; do
+		cp --preserve=mode,timestamps -R $srcdir ${D}${libdir}/go/src/
+	done
+	find ${D}${libdir}/go/src -depth -type d -name testdata -exec rm -rf {} \;
+	rm -f ${D}${libdir}/go/src/cmd/dist/dist
+        rm -f ${D}${libdir}/go/src/cmd/cgo/zdefaultcc.go
+        rm -f ${D}${libdir}/go/src/cmd/go/internal/cfg/zdefaultcc.go
+
+}
+
+ALLOW_EMPTY:${PN} = "1"
+FILES:${PN} = "${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*${SOLIBSDEV}"
+FILES:${PN}-dev = "${libdir}/go/src ${libdir}/go/pkg/include \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*/*/*.shlibname \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*/*.a \
+                   ${libdir}/go/pkg/${TARGET_GOTUPLE}_dynlink/*/*/*/*/*/*/*.a \
+"
+FILES:${PN}-staticdev = "${libdir}/go/pkg/${TARGET_GOTUPLE}"
+
+# Go sources include some scripts and pre-built binaries for
+# multiple architectures.  The static .a files for dynamically-linked
+# runtime are also required in -dev.
+INSANE_SKIP:${PN}-dev = "staticdev file-rdeps arch"
+
+INHIBIT_PACKAGE_STRIP = "1"
+INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
+INHIBIT_SYSROOT_STRIP = "1"
+
+BBCLASSEXTEND = "nativesdk"
diff --git a/recipes-devtools/go/go-runtime_1.26.7.bb b/recipes-devtools/go/go-runtime_1.26.7.bb
new file mode 100644
index 0000000..63464a1
--- /dev/null
+++ b/recipes-devtools/go/go-runtime_1.26.7.bb
@@ -0,0 +1,3 @@
+require go-${PV}.inc
+require go-runtime.inc
+
diff --git a/recipes-devtools/go/go-target.inc b/recipes-devtools/go/go-target.inc
new file mode 100644
index 0000000..981c7ab
--- /dev/null
+++ b/recipes-devtools/go/go-target.inc
@@ -0,0 +1,53 @@
+DEPENDS = "virtual/${TUNE_PKGARCH}-go go-native"
+DEPENDS:class-nativesdk = "virtual/${TARGET_PREFIX}go go-native"
+
+DEBUG_PREFIX_MAP = "\
+                     -fdebug-prefix-map=${STAGING_DIR_HOST}= \
+                     -fdebug-prefix-map=${STAGING_DIR_NATIVE}= \
+"
+
+export CGO_CFLAGS = "${CFLAGS}"
+export CGO_CPPFLAGS = "${CPPFLAGS}"
+export CGO_CXXFLAGS = "${CXXFLAGS}"
+# Filter out -fdebug-prefix-map options as they clash with the GO's build system
+export CGO_LDFLAGS = "${@ ' '.join(filter(lambda f: not f.startswith('-fdebug-prefix-map'), d.getVar('LDFLAGS').split())) }"
+
+export GOCACHE = "${B}/.cache"
+export GO_LDFLAGS = ""
+export GOBUILDFLAGS = "-gcflags=-trimpath=$GOPATH -asmflags=-trimpath=$GOPATH -trimpath"
+CC:append:class-nativesdk = " ${SECURITY_NOPIE_CFLAGS}"
+
+do_configure[noexec] = "1"
+
+do_compile() {
+	export CC_FOR_${TARGET_GOOS}_${TARGET_GOARCH}="${CC}"
+	export CXX_FOR_${TARGET_GOOS}_${TARGET_GOARCH}="${CXX}"
+
+	cd src
+	./make.bash --target-only --no-banner
+	cd ${B}
+}
+do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
+
+do_install() {
+	install -d ${D}${libdir}/go/pkg/tool
+	cp --preserve=mode,timestamps -R ${B}/pkg/tool/${TARGET_GOTUPLE} ${D}${libdir}/go/pkg/tool/
+	install -d ${D}${libdir}/go/src
+	cp --preserve=mode,timestamps -R ${S}/src/cmd ${D}${libdir}/go/src/
+	find ${D}${libdir}/go/src -depth -type d -name testdata -exec rm -rf {} \;
+	install -d ${D}${libdir}/go/bin
+	install -d ${D}${bindir}
+	for f in ${B}/${GO_BUILD_BINDIR}/*; do
+		name=`basename $f`
+		install -m 0755 $f ${D}${libdir}/go/bin/
+		ln -sf ../${baselib}/go/bin/$name ${D}${bindir}/
+	done
+	rm -rf ${D}${libdir}/go/src
+}
+
+PACKAGES = "${PN} ${PN}-dev"
+FILES:${PN} = "${libdir}/go/bin ${libdir}/go/pkg/tool/${TARGET_GOTUPLE} ${bindir}"
+RDEPENDS:${PN} = "go-runtime"
+INSANE_SKIP:${PN} = "ldflags"
+
+BBCLASSEXTEND = "nativesdk"
diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
new file mode 100644
index 0000000..077bebe
--- /dev/null
+++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generation-less-pedan.patch
@@ -0,0 +1,173 @@
+From 51c04a9a19dec5a48fa0f38324dc2480b7a859e4 Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Sat, 22 Feb 2025 03:24:48 -0800
+Subject: [PATCH 01/11] cmd/go: make content-based hash generation less
+ pedantic
+
+Go 1.10's build tool now uses content-based hashes to
+determine when something should be built or re-built.
+This same mechanism is used to maintain a built-artifact
+cache for speeding up builds.
+
+However, the hashes it generates include information that
+doesn't work well with OE, nor with using a shared runtime
+library.
+
+First, it embeds path names to source files, unless
+building within GOROOT.  This prevents the building
+of a package in GOPATH for later staging into GOROOT.
+
+This patch adds support for the environment variable
+GOPATH_OMIT_IN_ACTIONID.  If present, path name
+embedding is disabled.
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alex Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Matt Madison <matt@madison.systems>
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.23.4
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ src/cmd/go/internal/envcmd/env.go |  2 +-
+ src/cmd/go/internal/work/exec.go  | 44 ++++++++++++++++++++++++-------
+ 2 files changed, 36 insertions(+), 10 deletions(-)
+
+diff --git a/src/cmd/go/internal/envcmd/env.go b/src/cmd/go/internal/envcmd/env.go
+index 7c370d427f..c2441f7695 100644
+--- a/src/cmd/go/internal/envcmd/env.go
++++ b/src/cmd/go/internal/envcmd/env.go
+@@ -219,7 +219,7 @@ func ExtraEnvVarsCostly(loaderstate *modload.State) []cfg.EnvVar {
+ 		}
+ 	}()
+ 
+-	cppflags, cflags, cxxflags, fflags, ldflags, err := b.CFlags(&load.Package{})
++	cppflags, cflags, cxxflags, fflags, ldflags, err := b.CFlags(&load.Package{}, false)
+ 	if err != nil {
+ 		// Should not happen - b.CFlags was given an empty package.
+ 		fmt.Fprintf(os.Stderr, "go: invalid cflags: %v\n", err)
+diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
+index 7b073165d5..1f618be0bb 100644
+--- a/src/cmd/go/internal/work/exec.go
++++ b/src/cmd/go/internal/work/exec.go
+@@ -257,6 +257,8 @@ func (b *Builder) Do(ctx context.Context, root *Action) {
+ 	writeActionGraph()
+ }
+ 
++var omitGopath = os.Getenv("GOPATH_OMIT_IN_ACTIONID") != ""
++
+ // buildActionID computes the action ID for a build action.
+ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 	p := a.Package
+@@ -278,7 +280,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 		if p.Module != nil {
+ 			fmt.Fprintf(h, "module %s@%s\n", p.Module.Path, p.Module.Version)
+ 		}
+-	} else if p.Goroot {
++	} else if p.Goroot || omitGopath {
+ 		// The Go compiler always hides the exact value of $GOROOT
+ 		// when building things in GOROOT.
+ 		//
+@@ -313,9 +315,9 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 	}
+ 	if len(p.CgoFiles)+len(p.SwigFiles)+len(p.SwigCXXFiles) > 0 {
+ 		fmt.Fprintf(h, "cgo %q\n", b.toolID("cgo"))
+-		cppflags, cflags, cxxflags, fflags, ldflags, _ := b.CFlags(p)
++		cppflags, cflags, cxxflags, fflags, ldflags, _ := b.CFlags(p, true)
+ 
+-		ccExe := b.ccExe()
++		ccExe := filterCompilerFlags(b.ccExe(), true)
+ 		fmt.Fprintf(h, "CC=%q %q %q %q\n", ccExe, cppflags, cflags, ldflags)
+ 		// Include the C compiler tool ID so that if the C
+ 		// compiler changes we rebuild the package.
+@@ -325,7 +327,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 			fmt.Fprintf(h, "CC ID ERROR=%q\n", err)
+ 		}
+ 		if len(p.CXXFiles)+len(p.SwigCXXFiles) > 0 {
+-			cxxExe := b.cxxExe()
++			cxxExe := filterCompilerFlags(b.cxxExe(), true)
+ 			fmt.Fprintf(h, "CXX=%q %q\n", cxxExe, cxxflags)
+ 			if cxxID, _, err := b.gccToolID(cxxExe[0], "c++"); err == nil {
+ 				fmt.Fprintf(h, "CXX ID=%q\n", cxxID)
+@@ -334,7 +336,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 			}
+ 		}
+ 		if len(p.FFiles) > 0 {
+-			fcExe := b.fcExe()
++			fcExe := filterCompilerFlags(b.fcExe(), true)
+ 			fmt.Fprintf(h, "FC=%q %q\n", fcExe, fflags)
+ 			if fcID, _, err := b.gccToolID(fcExe[0], "f95"); err == nil {
+ 				fmt.Fprintf(h, "FC ID=%q\n", fcID)
+@@ -353,7 +355,7 @@ func (b *Builder) buildActionID(a *Action) cache.ActionID {
+ 		}
+ 	}
+ 	if p.Internal.BuildInfo != nil {
+-		fmt.Fprintf(h, "modinfo %q\n", p.Internal.BuildInfo.String())
++		//fmt.Fprintf(h, "modinfo %q\n", p.Internal.BuildInfo.String())
+ 	}
+ 
+ 	// Configuration specific to compiler toolchain.
+@@ -2804,8 +2806,25 @@ func envList(key, def string) []string {
+ 	return args
+ }
+ 
++var filterFlags = os.Getenv("CGO_PEDANTIC") == ""
++
++func filterCompilerFlags(flags []string, keepfirst bool) []string {
++	var newflags []string
++   var realkeepfirst bool = keepfirst
++	if !filterFlags {
++		return flags
++	}
++	for _, flag := range flags {
++		if strings.HasPrefix(flag, "-m") || realkeepfirst {
++			newflags = append(newflags, flag)
++           realkeepfirst = false
++		}
++	}
++	return newflags
++}
++
+ // CFlags returns the flags to use when invoking the C, C++ or Fortran compilers, or cgo.
+-func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, ldflags []string, err error) {
++func (b *Builder) CFlags(p *load.Package, filtered bool) (cppflags, cflags, cxxflags, fflags, ldflags []string, err error) {
+ 	if cppflags, err = buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS, checkCompilerFlags); err != nil {
+ 		return
+ 	}
+@@ -2821,6 +2840,13 @@ func (b *Builder) CFlags(p *load.Package) (cppflags, cflags, cxxflags, fflags, l
+ 	if ldflags, err = buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS, checkLinkerFlags); err != nil {
+ 		return
+ 	}
++	if filtered {
++		cppflags = filterCompilerFlags(cppflags, false)
++		cflags = filterCompilerFlags(cflags, false)
++		cxxflags = filterCompilerFlags(cxxflags, false)
++		fflags = filterCompilerFlags(fflags, false)
++		ldflags = filterCompilerFlags(ldflags, false)
++	}
+ 
+ 	return
+ }
+@@ -2909,7 +2935,7 @@ func (b *Builder) runCgo(ctx context.Context, a *Action) error {
+ 	cgoExe := base.Tool("cgo")
+ 	cgofiles = mkAbsFiles(p.Dir, cgofiles)
+ 
+-	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, cgoFFLAGS, cgoLDFLAGS, err := b.CFlags(p)
++	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, cgoFFLAGS, cgoLDFLAGS, err := b.CFlags(p, false)
+ 	if err != nil {
+ 		return err
+ 	}
+@@ -3462,7 +3488,7 @@ func (b *Builder) swigOne(a *Action, file, objdir string, pcCFLAGS []string, cxx
+ 	p := a.Package
+ 	sh := b.Shell(a)
+ 
+-	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, _, _, err := b.CFlags(p)
++	cgoCPPFLAGS, cgoCFLAGS, cgoCXXFLAGS, _, _, err := b.CFlags(p, false)
+ 	if err != nil {
+ 		return err
+ 	}
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
new file mode 100644
index 0000000..f6767d0
--- /dev/null
+++ b/recipes-devtools/go/go/0002-cmd-go-Allow-GOTOOLDIR-to-be-overridden-in-the-envir.patch
@@ -0,0 +1,56 @@
+From fdad9a0ea659cf2281a0df16b0f69f179605ec9a Mon Sep 17 00:00:00 2001
+From: Alex Kube <alexander.j.kube@gmail.com>
+Date: Wed, 23 Oct 2019 21:15:37 +0430
+Subject: [PATCH 02/11] cmd/go: Allow GOTOOLDIR to be overridden in the
+ environment
+
+to allow for split host/target build roots
+
+Adapted to Go 1.13 from patches originally submitted to
+the meta/recipes-devtools/go tree by
+Matt Madison <matt@madison.systems>.
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/dist/build.go          | 4 +++-
+ src/cmd/go/internal/cfg/cfg.go | 6 +++++-
+ 2 files changed, 8 insertions(+), 2 deletions(-)
+
+diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
+index 1f467647f5..b62e518030 100644
+--- a/src/cmd/dist/build.go
++++ b/src/cmd/dist/build.go
+@@ -271,7 +271,9 @@ func xinit() {
+ 	}
+ 	xatexit(rmworkdir)
+ 
+-	tooldir = pathf("%s/pkg/tool/%s_%s", goroot, gohostos, gohostarch)
++	if tooldir = os.Getenv("GOTOOLDIR"); tooldir == "" {
++		tooldir = pathf("%s/pkg/tool/%s_%s", goroot, gohostos, gohostarch)
++	}
+ 
+ 	goversion := findgoversion()
+ 	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
+diff --git a/src/cmd/go/internal/cfg/cfg.go b/src/cmd/go/internal/cfg/cfg.go
+index 3b9f27e91d..ec043c1530 100644
+--- a/src/cmd/go/internal/cfg/cfg.go
++++ b/src/cmd/go/internal/cfg/cfg.go
+@@ -279,7 +279,11 @@ func SetGOROOT(goroot string, isTestGo bool) {
+ 			// This matches the initialization of ToolDir in go/build, except for
+ 			// using ctxt.GOROOT and the installed GOOS and GOARCH rather than the
+ 			// GOROOT, GOOS, and GOARCH reported by the runtime package.
+-			build.ToolDir = filepath.Join(GOROOTpkg, "tool", installedGOOS+"_"+installedGOARCH)
++	   		if s := os.Getenv("GOTOOLDIR"); s != "" {
++				build.ToolDir = filepath.Clean(s)
++			} else {
++				build.ToolDir = filepath.Join(GOROOTpkg, "tool", installedGOOS+"_"+installedGOARCH)
++			}
+ 		}
+ 	}
+ }
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
new file mode 100644
index 0000000..0b5026f
--- /dev/null
+++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patch
@@ -0,0 +1,51 @@
+From 1546d837c69b654754ee137af1fa1c2f7500cfa2 Mon Sep 17 00:00:00 2001
+From: Alex Kube <alexander.j.kube@gmail.com>
+Date: Wed, 23 Oct 2019 21:16:32 +0430
+Subject: [PATCH 03/11] ld: add soname to shareable objects
+
+so that OE's shared library dependency handling
+can find them.
+
+Adapted to Go 1.13 from patches originally submitted to
+the meta/recipes-devtools/go tree by
+Matt Madison <matt@madison.systems>.
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/link/internal/ld/lib.go | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/src/cmd/link/internal/ld/lib.go b/src/cmd/link/internal/ld/lib.go
+index 2d8f964f35..dfc72e02c0 100644
+--- a/src/cmd/link/internal/ld/lib.go
++++ b/src/cmd/link/internal/ld/lib.go
+@@ -1652,6 +1652,7 @@ func (ctxt *Link) hostlink() {
+ 				argv = append(argv, "-Wl,-z,relro")
+ 			}
+ 			argv = append(argv, "-shared")
++			argv = append(argv, fmt.Sprintf("-Wl,-soname,%s", filepath.Base(*flagOutfile)))
+ 			if ctxt.HeadType == objabi.Hwindows {
+ 				argv = addASLRargs(argv, *flagAslr)
+ 			} else {
+@@ -1667,6 +1668,7 @@ func (ctxt *Link) hostlink() {
+ 			argv = append(argv, "-Wl,-z,relro")
+ 		}
+ 		argv = append(argv, "-shared")
++		argv = append(argv, fmt.Sprintf("-Wl,-soname,%s", filepath.Base(*flagOutfile)))
+ 	case BuildModePlugin:
+ 		if ctxt.HeadType == objabi.Hdarwin {
+ 			argv = append(argv, "-dynamiclib")
+@@ -1675,6 +1677,7 @@ func (ctxt *Link) hostlink() {
+ 				argv = append(argv, "-Wl,-z,relro")
+ 			}
+ 			argv = append(argv, "-shared")
++			argv = append(argv, fmt.Sprintf("-Wl,-soname,%s", filepath.Base(*flagOutfile)))
+ 		}
+ 	}
+ 
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
new file mode 100644
index 0000000..abbb7bd
--- /dev/null
+++ b/recipes-devtools/go/go/0004-make.bash-override-CC-when-building-dist-and-go_boot.patch
@@ -0,0 +1,48 @@
+From b41aaa851f0074682fcd4bf07c891fbdf0fdf70c Mon Sep 17 00:00:00 2001
+From: Alex Kube <alexander.j.kube@gmail.com>
+Date: Sat, 22 Feb 2025 03:14:37 -0800
+Subject: [PATCH 04/11] make.bash: override CC when building dist and
+ go_bootstrap
+
+for handling OE cross-canadian builds.
+
+Adapted to Go 1.13 from patches originally submitted to
+the meta/recipes-devtools/go tree by
+Matt Madison <matt@madison.systems>.
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.23.4
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ src/make.bash | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/src/make.bash b/src/make.bash
+index b67ae1529f..b59cdabd09 100755
+--- a/src/make.bash
++++ b/src/make.bash
+@@ -153,7 +153,7 @@ fi
+ export GOROOT_BOOTSTRAP
+ 
+ bootstrapenv() {
+-	GOROOT="$GOROOT_BOOTSTRAP" GO111MODULE=off GOENV=off GOOS= GOARCH= GOEXPERIMENT= GOFLAGS= "$@"
++	CC="${BUILD_CC:-${CC}}" GOROOT="$GOROOT_BOOTSTRAP" GO111MODULE=off GOENV=off GOOS= GOARCH= GOEXPERIMENT= GOFLAGS= "$@"
+ }
+ 
+ export GOROOT="$(cd .. && pwd)"
+@@ -216,7 +216,7 @@ fi
+ # Run dist bootstrap to complete make.bash.
+ # Bootstrap installs a proper cmd/dist, built with the new toolchain.
+ # Throw ours, built with the bootstrap toolchain, away after bootstrap.
+-./cmd/dist/dist bootstrap -a $vflag $GO_DISTFLAGS "$@"
++CC="${BUILD_CC:-${CC}}" ./cmd/dist/dist bootstrap -a $vflag $GO_DISTFLAGS "$@"
+ rm -f ./cmd/dist/dist
+ 
+ # DO NOT ADD ANY NEW CODE HERE.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
new file mode 100644
index 0000000..7c8923f
--- /dev/null
+++ b/recipes-devtools/go/go/0005-cmd-dist-separate-host-and-target-builds.patch
@@ -0,0 +1,224 @@
+From 12bf824f8b7e85f05434aa00e866e883a551aaeb Mon Sep 17 00:00:00 2001
+From: Alex Kube <alexander.j.kube@gmail.com>
+Date: Fri, 28 Feb 2025 19:09:17 -0800
+Subject: [PATCH 05/11] cmd/dist: separate host and target builds
+
+Change the dist tool to allow for OE-style cross-
+and cross-canadian builds:
+
+ - command flags --host-only and --target only are added;
+   if one is present, the other changes mentioned below
+   take effect, and arguments may also be specified on
+   the command line to enumerate the package(s) to be
+   built.
+
+ - for OE cross builds, go_bootstrap is always built for
+   the current build host, and is moved, along with the supporting
+   toolchain (asm, compile, etc.) to a separate 'native_native'
+   directory under GOROOT/pkg/tool.
+
+ - go_bootstrap is not automatically removed after the build,
+   so it can be reused later (e.g., building both static and
+   shared runtime).
+
+Note that for --host-only builds, it would be nice to specify
+just the "cmd" package to build only the go commands/tools,
+the staleness checks in the dist tool will fail if the "std"
+library has not also been built.  So host-only builds have to
+build everything anyway.
+
+Adapted to Go 1.13 from patches originally submitted to
+the meta/recipes-devtools/go tree by
+Matt Madison <matt@madison.systems>.
+
+Rework the patch to avoid identation, it breaks formatting rules but
+makes the changes more obvious and maintainable.
+Jose Quaresma <jose.quaresma@foundries.io>
+Richard Purdie <richard.purdie@linuxfoundation.org>
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+
+Rebase to 1.24.0
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ src/cmd/dist/build.go | 76 ++++++++++++++++++++++++++++++++++++++++++-
+ 1 file changed, 75 insertions(+), 1 deletion(-)
+
+diff --git a/src/cmd/dist/build.go b/src/cmd/dist/build.go
+index b62e518030..0c54d82300 100644
+--- a/src/cmd/dist/build.go
++++ b/src/cmd/dist/build.go
+@@ -50,6 +50,7 @@ var (
+ 	gofips140        string
+ 	workdir          string
+ 	tooldir          string
++	build_tooldir    string
+ 	oldgoos          string
+ 	oldgoarch        string
+ 	oldgocache       string
+@@ -62,6 +63,7 @@ var (
+ 	rebuildall bool
+ 	noOpt      bool
+ 	isRelease  bool
++	crossBuild bool
+ 
+ 	vflag int // verbosity
+ )
+@@ -278,6 +280,8 @@ func xinit() {
+ 	goversion := findgoversion()
+ 	isRelease = (strings.HasPrefix(goversion, "release.") || strings.HasPrefix(goversion, "go")) &&
+ 		!strings.Contains(goversion, "devel")
++
++	build_tooldir = pathf("%s/pkg/tool/native_native", goroot)
+ }
+ 
+ // compilerEnv returns a map from "goos/goarch" to the
+@@ -543,8 +547,10 @@ func setup() {
+ 	goosGoarch := pathf("%s/pkg/%s_%s", goroot, gohostos, gohostarch)
+ 	if rebuildall {
+ 		xremoveall(goosGoarch)
++		xremoveall(build_tooldir)
+ 	}
+ 	xmkdirall(goosGoarch)
++	xmkdirall(build_tooldir)
+ 	xatexit(func() {
+ 		if files := xreaddir(goosGoarch); len(files) == 0 {
+ 			xremove(goosGoarch)
+@@ -1415,14 +1421,20 @@ func cmdbootstrap() {
+ 	defer timelog("end", "dist bootstrap")
+ 
+ 	var debug, distpack, force, noBanner, noClean bool
++	var hostOnly bool
++	var targetOnly bool
++	var toBuild = []string{"std", "cmd"}
++
+ 	flag.BoolVar(&rebuildall, "a", rebuildall, "rebuild all")
+ 	flag.BoolVar(&debug, "d", debug, "enable debugging of bootstrap process")
+ 	flag.BoolVar(&distpack, "distpack", distpack, "write distribution files to pkg/distpack")
+ 	flag.BoolVar(&force, "force", force, "build even if the port is marked as broken")
+ 	flag.BoolVar(&noBanner, "no-banner", noBanner, "do not print banner")
+ 	flag.BoolVar(&noClean, "no-clean", noClean, "print deprecation warning")
++	flag.BoolVar(&hostOnly, "host-only", hostOnly, "build only host binaries, not target")
++	flag.BoolVar(&targetOnly, "target-only", targetOnly, "build only target binaries, not host")
+ 
+-	xflagparse(0)
++	xflagparse(-1)
+ 
+ 	if noClean {
+ 		xprintf("warning: --no-clean is deprecated and has no effect; use 'go install std cmd' instead\n")
+@@ -1434,6 +1446,18 @@ func cmdbootstrap() {
+ 			"Use the -force flag to build anyway.\n", goos, goarch)
+ 	}
+ 
++	if hostOnly && targetOnly {
++		fatalf("specify only one of --host-only or --target-only\n")
++	}
++	crossBuild = hostOnly || targetOnly
++	if flag.NArg() > 0 {
++		if crossBuild {
++			toBuild = flag.Args()
++		} else {
++			fatalf("package names not permitted without --host-only or --target-only\n")
++		}
++	}
++
+ 	// Set GOPATH to an internal directory. We shouldn't actually
+ 	// need to store files here, since the toolchain won't
+ 	// depend on modules outside of vendor directories, but if
+@@ -1512,9 +1536,14 @@ func cmdbootstrap() {
+ 		xprintf("\n")
+ 	}
+ 
++	// For split host/target cross/cross-canadian builds, we don't
++	// want to be setting these flags until after we have compiled
++	// the toolchain that runs on the build host.
++if !crossBuild {
+ 	gogcflags = os.Getenv("GO_GCFLAGS") // we were using $BOOT_GO_GCFLAGS until now
+ 	setNoOpt()
+ 	goldflags = os.Getenv("GO_LDFLAGS") // we were using $BOOT_GO_LDFLAGS until now
++}
+ 	goBootstrap := pathf("%s/go_bootstrap", tooldir)
+ 	if debug {
+ 		run("", ShowOutput|CheckExit, pathf("%s/compile", tooldir), "-V=full")
+@@ -1542,7 +1571,11 @@ func cmdbootstrap() {
+ 		xprintf("\n")
+ 	}
+ 	xprintf("Building Go toolchain2 using go_bootstrap and Go toolchain1.\n")
++if !crossBuild {
+ 	os.Setenv("CC", compilerEnvLookup("CC", defaultcc, goos, goarch))
++} else {
++		os.Setenv("CC", defaultcc[""])
++}
+ 	// Now that cmd/go is in charge of the build process, enable GOEXPERIMENT.
+ 	os.Setenv("GOEXPERIMENT", goexperiment)
+ 	// No need to enable PGO for toolchain2.
+@@ -1595,6 +1628,7 @@ func cmdbootstrap() {
+ 		os.Setenv("GOCACHE", oldgocache)
+ 	}
+ 
++if !crossBuild {
+ 	if goos == oldgoos && goarch == oldgoarch {
+ 		// Common case - not setting up for cross-compilation.
+ 		timelog("build", "toolchain")
+@@ -1638,6 +1672,42 @@ func cmdbootstrap() {
+ 		checkNotStale(toolenv(), goBootstrap, toolchain...)
+ 		copyfile(pathf("%s/compile4", tooldir), pathf("%s/compile", tooldir), writeExec)
+ 	}
++} else {
++		gogcflags = os.Getenv("GO_GCFLAGS")
++		goldflags = os.Getenv("GO_LDFLAGS")
++		tool_files, _ := filepath.Glob(pathf("%s/*", tooldir))
++		for _, f := range tool_files {
++			copyfile(pathf("%s/%s", build_tooldir, filepath.Base(f)), f, writeExec)
++			xremove(f)
++		}
++		os.Setenv("GOTOOLDIR", build_tooldir)
++		goBootstrap = pathf("%s/go_bootstrap", build_tooldir)
++		if hostOnly {
++			timelog("build", "host toolchain")
++			if vflag > 0 {
++				xprintf("\n")
++			}
++			xprintf("Building %s for host, %s/%s.\n", strings.Join(toBuild, ","), goos, goarch)
++			goInstall(toolenv(), goBootstrap, toBuild...)
++			checkNotStale(toolenv(), goBootstrap, toBuild...)
++			// Skip cmdGo staleness checks here, since we can't necessarily run the cmdGo binary
++
++			timelog("build", "target toolchain")
++			if vflag > 0 {
++				xprintf("\n")
++			}
++		} else if targetOnly {
++			goos = oldgoos
++			goarch = oldgoarch
++			os.Setenv("GOOS", goos)
++			os.Setenv("GOARCH", goarch)
++			os.Setenv("CC", compilerEnvLookup("CC", defaultcc, goos, goarch))
++			xprintf("Building %s for target, %s/%s.\n", strings.Join(toBuild, ","), goos, goarch)
++			goInstall(toolenv(), goBootstrap, toBuild...)
++			checkNotStale(toolenv(), goBootstrap, toBuild...)
++			// Skip cmdGo staleness checks here, since we can't run the target's cmdGo binary
++		}
++}
+ 
+ 	// Check that there are no new files in $GOROOT/bin other than
+ 	// go and gofmt and $GOOS_$GOARCH (target bin when cross-compiling).
+@@ -1660,8 +1730,12 @@ func cmdbootstrap() {
+ 		}
+ 	}
+ 
++	// Except that for split host/target cross-builds, we need to
++	// keep it.
++if !crossBuild {
+ 	// Remove go_bootstrap now that we're done.
+ 	xremove(pathf("%s/go_bootstrap"+exe, tooldir))
++}
+ 
+ 	if goos == "android" {
+ 		// Make sure the exec wrapper will sync a fresh $GOROOT to the device.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
new file mode 100644
index 0000000..9aebc2f
--- /dev/null
+++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.patch
@@ -0,0 +1,114 @@
+From ba3caa9f969bac2b937f8f1ffed4a3679cd16ec7 Mon Sep 17 00:00:00 2001
+From: Alex Kube <alexander.j.kube@gmail.com>
+Date: Wed, 23 Oct 2019 21:18:56 +0430
+Subject: [PATCH 06/11] cmd/go: make GOROOT precious by default
+
+The go build tool normally rebuilds whatever it detects is
+stale.  This can be a problem when GOROOT is intended to
+be read-only and the go runtime has been built as a shared
+library, since we don't want every application to be rebuilding
+the shared runtime - particularly in cross-build/packaging
+setups, since that would lead to 'abi mismatch' runtime errors.
+
+This patch prevents the install and linkshared actions from
+installing to GOROOT unless overridden with the GOROOT_OVERRIDE
+environment variable.
+
+Adapted to Go 1.13 from patches originally submitted to
+the meta/recipes-devtools/go tree by
+Matt Madison <matt@madison.systems>.
+
+Upstream-Status: Inappropriate [OE specific]
+
+Signed-off-by: Alexander J Kube <alexander.j.kube@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/go/internal/work/action.go |  3 +++
+ src/cmd/go/internal/work/build.go  |  6 ++++++
+ src/cmd/go/internal/work/exec.go   | 25 +++++++++++++++++++++++++
+ 3 files changed, 34 insertions(+)
+
+diff --git a/src/cmd/go/internal/work/action.go b/src/cmd/go/internal/work/action.go
+index 44bb9f8c1e..87ac4e30e5 100644
+--- a/src/cmd/go/internal/work/action.go
++++ b/src/cmd/go/internal/work/action.go
+@@ -1076,6 +1076,9 @@ func (b *Builder) addTransitiveLinkDeps(s *modload.State, a, a1 *Action, shlib s
+ 			if p1 == nil || p1.Shlib == "" || haveShlib[filepath.Base(p1.Shlib)] {
+ 				continue
+ 			}
++			if goRootPrecious && (p1.Standard || p1.Goroot) {
++				continue
++			}
+ 			haveShlib[filepath.Base(p1.Shlib)] = true
+ 			// TODO(rsc): The use of ModeInstall here is suspect, but if we only do ModeBuild,
+ 			// we'll end up building an overall library or executable that depends at runtime
+diff --git a/src/cmd/go/internal/work/build.go b/src/cmd/go/internal/work/build.go
+index 3508d51fbb..77f5e7241a 100644
+--- a/src/cmd/go/internal/work/build.go
++++ b/src/cmd/go/internal/work/build.go
+@@ -238,6 +238,8 @@ See also: go install, go get, go clean.
+ 	`,
+ }
+ 
++var goRootPrecious bool = true
++
+ func init() {
+ 	// break init cycle
+ 	CmdBuild.Run = runBuild
+@@ -292,6 +294,10 @@ func init() {
+ 	case "gc", "gccgo":
+ 		buildCompiler{}.Set(build.Default.Compiler)
+ 	}
++
++	if x := os.Getenv("GOROOT_OVERRIDE"); x != "" {
++		goRootPrecious = false
++	}
+ }
+ 
+ type BuildFlagMask int
+diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
+index 1f618be0bb..651fa64582 100644
+--- a/src/cmd/go/internal/work/exec.go
++++ b/src/cmd/go/internal/work/exec.go
+@@ -605,6 +605,23 @@ func (b *Builder) checkCacheForBuild(a, buildAction *Action, covMetaFileName str
+ 		return nil, err
+ 	}
+ 
++	if goRootPrecious && (a.Package.Standard || a.Package.Goroot) {
++		_, err := os.Stat(a.Package.Target)
++		if err == nil {
++			a.built = a.Package.Target
++			a.Target = a.Package.Target
++			a.buildID = b.fileHash(a.Package.Target)
++			a.Package.Stale = false
++			a.Package.StaleReason = "GOROOT-resident package"
++			return nil, err
++		}
++		a.Package.Stale = true
++		a.Package.StaleReason = "missing or invalid GOROOT-resident package"
++		if b.IsCmdList {
++			return nil, err
++		}
++	}
++
+ 	if err := sh.Mkdir(buildAction.Objdir); err != nil {
+ 		return nil, err
+ 	}
+@@ -1888,6 +1905,14 @@ func (b *Builder) linkShared(ctx context.Context, a *Action) (err error) {
+ 		return err
+ 	}
+ 
++	if goRootPrecious && a.Package != nil {
++		p := a.Package
++		if p.Standard || p.Goroot {
++			err := fmt.Errorf("attempting to install package %s into read-only GOROOT", p.ImportPath)
++			return err
++		}
++	}
++
+ 	if err := b.Shell(a).Mkdir(a.Objdir); err != nil {
+ 		return err
+ 	}
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
new file mode 100644
index 0000000..2598a7b
--- /dev/null
+++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths-from-linker-.patch
@@ -0,0 +1,63 @@
+From 2197f813c9cff65eedef44473872ec5ea9ced227 Mon Sep 17 00:00:00 2001
+From: Changqing Li <changqing.li@windriver.com>
+Date: Tue, 27 Feb 2024 18:06:51 +0800
+Subject: [PATCH 07/11] exec.go: filter out build-specific paths from linker
+ flags
+
+The flags can contain build-specific paths, breaking reproducibility.
+Filter out options that have build-specific paths.
+
+Upstream-Status: Inappropriate [ Not perfect for upstream ]
+
+Signed-off-by: Changqing Li <changqing.li@windriver.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/go/internal/work/exec.go | 25 ++++++++++++++++++++++++-
+ 1 file changed, 24 insertions(+), 1 deletion(-)
+
+diff --git a/src/cmd/go/internal/work/exec.go b/src/cmd/go/internal/work/exec.go
+index 651fa64582..586079afb4 100644
+--- a/src/cmd/go/internal/work/exec.go
++++ b/src/cmd/go/internal/work/exec.go
+@@ -1563,6 +1563,29 @@ func (b *Builder) linkActionID(a *Action) cache.ActionID {
+ 	return h.Sum()
+ }
+ 
++func filterLinkerFlags(flags []string) []string {
++	var newflags []string
++	var skipflag bool
++	skipflag = false
++	for i, flag := range flags {
++		if skipflag == true {
++			skipflag = false
++			continue
++		}
++		if strings.HasPrefix(flag, "--sysroot") || strings.HasPrefix(flag, "-fmacro-prefix-map") || strings.HasPrefix(flag, "-fdebug-prefix-map") || strings.HasPrefix(flag, "-ffile-prefix-map") || strings.HasPrefix(flag, "-fcanon-prefix-map") || strings.HasPrefix(flag, "-fprofile-prefix-map") || strings.HasPrefix(flag, "-Wl,-rpath-link"){
++			continue
++		} else if strings.HasPrefix(flag, "-extldflags") {
++			skipflag = true
++			newflags = append(newflags, flag)
++			var filterd_Extldflags []string = filterLinkerFlags(strings.Split(flags[i+1], " "))
++			newflags = append(newflags, strings.Join(filterd_Extldflags, " "))
++		} else {
++			newflags = append(newflags, flag)
++		}
++	}
++	return newflags
++}
++
+ // printLinkerConfig prints the linker config into the hash h,
+ // as part of the computation of a linker-related action ID.
+ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+@@ -1573,7 +1596,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
+ 	case "gc":
+ 		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags, ldBuildmode)
+ 		if p != nil {
+-			fmt.Fprintf(h, "linkflags %q\n", p.Internal.Ldflags)
++			fmt.Fprintf(h, "linkflags %q\n", filterLinkerFlags(p.Internal.Ldflags))
+ 		}
+ 
+ 		// GOARM, GOMIPS, etc.
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
new file mode 100644
index 0000000..59cbff1
--- /dev/null
+++ b/recipes-devtools/go/go/0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch
@@ -0,0 +1,46 @@
+From e5752b239707df8ad7a72dc60420e01c5912d606 Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex.kanavin@gmail.com>
+Date: Tue, 10 Nov 2020 16:33:27 +0000
+Subject: [PATCH 08/11] src/cmd/dist/buildgo.go: do not hardcode host compilers
+ into target binaries
+
+These come from $CC/$CXX on the build host and are not useful on targets;
+additionally as they contain host specific paths, this helps reproducibility.
+
+Upstream-Status: Inappropriate [needs upstream discussion]
+
+Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/dist/buildgo.go | 8 ++++----
+ 1 file changed, 4 insertions(+), 4 deletions(-)
+
+diff --git a/src/cmd/dist/buildgo.go b/src/cmd/dist/buildgo.go
+index 884e9d729a..2f52edacfe 100644
+--- a/src/cmd/dist/buildgo.go
++++ b/src/cmd/dist/buildgo.go
+@@ -50,8 +50,8 @@ func mkzdefaultcc(dir, file string) {
+ 		fmt.Fprintf(&buf, "package cfg\n")
+ 		fmt.Fprintln(&buf)
+ 		fmt.Fprintf(&buf, "const DefaultPkgConfig = `%s`\n", defaultpkgconfig)
+-		buf.WriteString(defaultCCFunc("DefaultCC", defaultcc))
+-		buf.WriteString(defaultCCFunc("DefaultCXX", defaultcxx))
++		buf.WriteString(defaultCCFunc("DefaultCC", map[string]string{"":"gcc"}))
++		buf.WriteString(defaultCCFunc("DefaultCXX", map[string]string{"":"g++"}))
+ 		writefile(buf.String(), file, writeSkipSame)
+ 		return
+ 	}
+@@ -61,8 +61,8 @@ func mkzdefaultcc(dir, file string) {
+ 	fmt.Fprintf(&buf, "package main\n")
+ 	fmt.Fprintln(&buf)
+ 	fmt.Fprintf(&buf, "const defaultPkgConfig = `%s`\n", defaultpkgconfig)
+-	buf.WriteString(defaultCCFunc("defaultCC", defaultcc))
+-	buf.WriteString(defaultCCFunc("defaultCXX", defaultcxx))
++	buf.WriteString(defaultCCFunc("defaultCC", map[string]string{"":"gcc"}))
++	buf.WriteString(defaultCCFunc("defaultCXX", map[string]string{"":"g++"}))
+ 	writefile(buf.String(), file, writeSkipSame)
+ }
+ 
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
new file mode 100644
index 0000000..140923f
--- /dev/null
+++ b/recipes-devtools/go/go/0009-go-Filter-build-paths-on-staticly-linked-arches.patch
@@ -0,0 +1,61 @@
+From 79a1c80ed43f2a541bcab665656a4e2bb87baab3 Mon Sep 17 00:00:00 2001
+From: Richard Purdie <richard.purdie@linuxfoundation.org>
+Date: Sat, 2 Jul 2022 23:08:13 +0100
+Subject: [PATCH 09/11] go: Filter build paths on staticly linked arches
+
+Filter out build time paths from ldflags and other flags variables when they're
+embedded in the go binary so that builds are reproducible regardless of build
+location. This codepath is hit for statically linked go binaries such as those
+on mips/ppc.
+
+Upstream-Status: Submitted [https://github.com/golang/go/pull/56410]
+
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
+---
+ src/cmd/go/internal/load/pkg.go | 15 +++++++++++++--
+ 1 file changed, 13 insertions(+), 2 deletions(-)
+
+diff --git a/src/cmd/go/internal/load/pkg.go b/src/cmd/go/internal/load/pkg.go
+index 15f6b2e87b..47c5b865a1 100644
+--- a/src/cmd/go/internal/load/pkg.go
++++ b/src/cmd/go/internal/load/pkg.go
+@@ -2314,6 +2314,17 @@ func appendBuildSetting(info *debug.BuildInfo, key, value string) {
+ 	info.Settings = append(info.Settings, debug.BuildSetting{Key: key, Value: value})
+ }
+ 
++func filterCompilerFlags(flags string) string {
++	var newflags []string
++	for _, flag := range strings.Fields(flags) {
++		if strings.HasPrefix(flag, "--sysroot") || strings.HasPrefix(flag, "-fmacro-prefix-map") || strings.HasPrefix(flag, "-fdebug-prefix-map") {
++			continue
++		}
++		newflags = append(newflags, flag)
++	}
++	return strings.Join(newflags, " ")
++}
++
+ // setBuildInfo gathers build information and sets it into
+ // p.Internal.BuildInfo, which will later be formatted as a string and embedded
+ // in the binary. setBuildInfo should only be called on a main package with no
+@@ -2421,7 +2432,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
+ 	if gcflags := BuildGcflags.String(); gcflags != "" && cfg.BuildContext.Compiler == "gc" {
+ 		appendSetting("-gcflags", gcflags)
+ 	}
+-	if ldflags := BuildLdflags.String(); ldflags != "" {
++	if ldflags := filterCompilerFlags(BuildLdflags.String()); ldflags != "" {
+ 		// https://go.dev/issue/52372: only include ldflags if -trimpath is not set,
+ 		// since it can include system paths through various linker flags (notably
+ 		// -extar, -extld, and -extldflags).
+@@ -2467,7 +2478,7 @@ func (p *Package) setBuildInfo(ctx context.Context, f *modfetch.Fetcher, autoVCS
+ 	// subset of flags that are known not to be paths?
+ 	if cfg.BuildContext.CgoEnabled && !cfg.BuildTrimpath {
+ 		for _, name := range []string{"CGO_CFLAGS", "CGO_CPPFLAGS", "CGO_CXXFLAGS", "CGO_LDFLAGS"} {
+-			appendSetting(name, cfg.Getenv(name))
++			appendSetting(name, filterCompilerFlags(cfg.Getenv(name)))
+ 		}
+ 	}
+ 	appendSetting("GOARCH", cfg.BuildContext.GOARCH)
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
new file mode 100644
index 0000000..33e91bb
--- /dev/null
+++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch
@@ -0,0 +1,48 @@
+From c4215b5ca69a7626d97cf9b7ebc460c2b5b9148b Mon Sep 17 00:00:00 2001
+From: Hongxu Jia <hongxu.jia@windriver.com>
+Date: Fri, 28 Feb 2025 19:13:18 -0800
+Subject: [PATCH 10/11] cmd/go: clear GOROOT for func ldShared when -trimpath
+ is used
+
+In commit [cmd: remove support for GOROOT_FINAL][1], it clear GOROOT
+for func ld when -trimpath is used. [2]
+
+This commit do the same thing for func ldShared, otherwise run go_bootstrap
+with -trimpath does not remove build path directory from the generated share
+libarary
+
+  $ ./make.bash --target-only --no-banner std
+  $ go_bootstrap install -linkshared -buildmode=shared -trimpath std
+  $ grep "$(pwd)" ./pkg/linux_amd64_dynlink/libstd.so
+  Binary file ./pkg/linux_amd64_dynlink/libstd.so matches
+
+[1] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98
+[2] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98#diff-cab5921f94f2667bb0bc1b935d2d46b4c03541b4351b33438ab7290b94dea212R669
+
+Upstream-Status: Submitted [https://go-review.googlesource.com/c/go/+/653895]
+
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ src/cmd/go/internal/work/gc.go | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/src/cmd/go/internal/work/gc.go b/src/cmd/go/internal/work/gc.go
+index 3a173efee8..8b7a44e031 100644
+--- a/src/cmd/go/internal/work/gc.go
++++ b/src/cmd/go/internal/work/gc.go
+@@ -717,6 +717,12 @@ func (gcToolchain) ldShared(b *Builder, root *Action, toplevelactions []*Action,
+ 	// the output file path is recorded in the .gnu.version_d section.
+ 	dir, targetPath := filepath.Split(targetPath)
+ 
++	// When -trimpath is used, GOROOT is cleared
++	if cfg.BuildTrimpath {
++		cfgChangedEnv = append(cfgChangedEnv, "GOROOT=")
++	} else {
++		cfgChangedEnv = append(cfgChangedEnv, "GOROOT="+cfg.GOROOT)
++	}
+ 	return b.Shell(root).run(dir, targetPath, cfgChangedEnv, cfg.BuildToolexec, base.Tool("link"), "-o", targetPath, "-importcfg", importcfg, ldflags)
+ }
+ 
+-- 
+2.25.1
+
diff --git a/recipes-devtools/go/go_1.26.7.bb b/recipes-devtools/go/go_1.26.7.bb
new file mode 100644
index 0000000..46f5fbc
--- /dev/null
+++ b/recipes-devtools/go/go_1.26.7.bb
@@ -0,0 +1,18 @@
+require go-${PV}.inc
+require go-target.inc
+
+inherit linuxloader
+
+CGO_LDFLAGS:append = " -no-pie"
+
+export GO_LDSO = "${@get_linuxloader(d)}"
+export CC_FOR_TARGET = "gcc"
+export CXX_FOR_TARGET = "g++"
+
+# mips/rv64 doesn't support -buildmode=pie, so skip the QA checking for mips/riscv32 and its
+# variants.
+python() {
+    if 'mips' in d.getVar('TARGET_ARCH') or 'riscv32' in d.getVar('TARGET_ARCH'):
+        d.appendVar('INSANE_SKIP:%s' % d.getVar('PN'), " textrel")
+}
+

