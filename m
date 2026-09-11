Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FBC88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:52 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48445.1789157627149928329
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ItEb9OGK;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52ff0b7c98aso15232671cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157626; x=1789762426; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8nauNzlgLmw6StG1sB1/7hHWZBKupcwGsJO3B2TZU/Q=;
        b=ItEb9OGKE0IKBLufj7YjG2jqeWXXiXaTpKwBaLWvdkDFdHefY8OXKuFbFtN234HlT2
         aDuiZ7f4HjHGxxMExyMgULXvb4DnXwRWZ/pwScxx99Ncy7ZX4zV/Lbh5YvmvqNuZ7S9M
         x0XbZVW+FXo/b7tH6dmA/BxYxdXgKF3KdQuJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157626; x=1789762426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8nauNzlgLmw6StG1sB1/7hHWZBKupcwGsJO3B2TZU/Q=;
        b=RdGg6K8z6sFKkzRECP/cZep9bKM0FF5nFIOHmk2nh8DAUsDcptwoj+6mpm16osGo3L
         7Bubtt51n21sAUNgrgu3KLeJdx+zDD9svhzIxf8TX88STVw9bdIKHyAGiLd4sTYZvsxx
         Ujrjt0B9h1Be5b4ByS0C/Wz5s5p9FRR8DQ2AlDTturK6mEavpFwPHjH7QVnLLINa7QgM
         4JYzAcc/47lMrZiygi/901LUOsyw1HwtDdem37e9wMYbxVXAXxOXe3VuYnt9uYIE529d
         pRhGoy3NwXAsVyOAhoHDKyxE6B09SDy9Bdzl46TXuqbxGHQ9ia4x2N/Mhh0e1hjgOxWh
         ChtQ==
X-Gm-Message-State: AFuF++mewBSdNYSTs6/vg6vbWbOgFHjoHUl2fvkGhhyRcD67jrvYBeID
	hZaPE9jNcm+A5sLk35RIVjZXSGsiK3hn3EtNp/a4dmmC552y5RObMtFg36QawwlaL1on0NtUFzl
	O/94N
X-Gm-Gg: AYBFou2xm1lP2ZbR8+gC+p5940LAy6W8kIW5gRJw0/jHV7uAybr8AznGPEsmPs/Z3tB
	dDoebW8r7vrEKKnzGCBnEPFsSrhHqYvgt8qNymURTfuWIhyCTfk4yh7rcG98nHvFttufkLlZ4Yc
	iUoZvk9d+iTDrWUI+UXrsC4GCL4+x4VaUEnZkqEy0t2CsdU8tam5tzDQEx3TpJqhK5dsP3Ri8Oq
	+SUWzDyqn3axf+KONoDofj4jAMATApxH3yPlEGFXWLs1j2RzzVe95zLbwRiffMg2fG6h31kv1OR
	7epYaruZYkqhFJTmxS3HDlG7h349iJ14RApFQ2KRiiHfqXZnRh2FyIeqMQWPINr06anzuKOtuf4
	vJFYdljNnH+mlst2B0sMcSWlo/K5TLQZ8cXvr+dOJNL80VQikk9bE1+ng14TD9sofBJ3OThfJxe
	+354VQye2yeYQ32XNfpzWMHwyJrfr7kZHo6L4/qdY4//joN83GUU1SitGMGIpeH+hEFCZQnxFD2
	GmsbdbFFdVvCFnMcNXWzIt0NfMXgUkod4OWco4Ztq+43xcSgEV1iFGCYC7yszFtrcfsQPL4QEHb
	sCYFiA5mFWDTpOrakcV9mHB6mjkqnHQqg60=
X-Received: by 2002:a05:622a:1a8c:b0:52f:a196:79a6 with SMTP id d75a77b69052e-530c869bbb6mr86715081cf.33.1789157625501;
        Fri, 11 Sep 2026 13:13:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/37] rust: refactor source handling into a shared work-shared recipe
Date: Fri, 11 Sep 2026 16:12:54 -0400
Message-ID: <eb72ff9dafc04bffdc3954ac463d6b70e84ab79a.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4774

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

[YOCTO #15808]

Consolidate Rust source management across all Rust recipes (rust, cargo,
libstd-rs and their native/nativesdk variants) into a single shared
source tree using the work-shared pattern.

Disk savings: a world build with multilibs enabled, together with
nativesdk-rust and nativesdk-cargo, now shares a single ~4.2 GB rustc-src
tree instead of maintaining up to 11 independent copies (~46.2 GB total).

Performance (clean core-image-sato build, qemux86-64):

Before: 68m53.507s
After:  65m46.159s
Improvement: 3m07.348s (~4.5%)

New files:

- rust-source_1.96.1.bb: A shared recipe that fetches, unpacks, and patches
  the rustc source tree into ${TMPDIR}/work-shared/rust-source-${PV}-${PR}.
  All build/install/packaging tasks are disabled; this recipe exists solely
  to provide a single copy of the source. Inherits allarch/nopackages,
  excludes itself from rm_work, and is hidden from world builds.
  Also defines RUST_BUILD_ARCH locally since this recipe does not inherit
  rust-common.bbclass but still needs the mapping for snapshot fetching
  via rust-snapshot.inc.

- common-source.inc: Included by consumer recipes (rust, cargo, libstd-rs)
  to disable their local do_fetch/do_unpack/do_patch tasks, clear SRC_URI,
  and add task dependencies on rust-source-${PV} for configure, licensing,
  and SPDX generation. Also provides is_work_shared_spdx() override for
  correct SPDX shared-workdir detection.

Modified files:

- rust-source.inc:
  - Set UNPACKDIR to the work-shared location so all consumers share one
    source tree via RUSTSRC and S.

- rust_1.96.1.bb:
  - Add 'require common-source.inc' to use the shared source tree.
  - Set B = ${WORKDIR}/build to separate build artifacts from shared source.
  - Set CARGO_HOME = ${WORKDIR}/cargo_home to isolate cargo caching.
  - Set build-dir = "rust-build" in config.toml to distinguish Yocto's build
    directory (B), which holds config.toml, from the bootstrap's own build
    output directory. Without this, bootstrap defaults to "build/" inside B,
    creating an ambiguous build/build/ nesting.
  - Use absolute ${S}/src/bootstrap/bootstrap.py path since cwd is now B.
  - Update install functions to reference rust-build/ instead of build/.
  - Update do_test_compile to use absolute ${S}/src/tools/ path.
  - Change do_rust_setup_snapshot from 'after do_unpack' to depend on
    rust-source-${PV}:do_unpack (since local do_unpack is removed).

- cargo_1.96.1.bb:
  - Add 'require common-source.inc' to use the shared source tree.
  - Change do_cargo_setup_snapshot from 'after do_unpack' to depend on
    rust-source-${PV}:do_unpack.

- libstd-rs_1.96.1.bb:
  - Add 'require common-source.inc' to use the shared source tree.

- rust-common.bbclass:
  - Add a second --remap-path-prefix for ${TMPDIR}/work-shared so debug
    info from the shared source tree is correctly remapped.
  - Retain RUST_BUILD_ARCH definition so that consumer recipes (rust, cargo,
    libstd-rs) which inherit this class can resolve snapshot directory names
    used by do_rust_setup_snapshot and do_cargo_setup_snapshot.

- lib/oeqa/selftest/cases/rust.py:
  - Adapt the selftest to the build-dir/source-dir split: use B for build
    artifacts and RUSTSRC for source paths.
  - Update remote-test-server copy path from build/ to rust-build/.
  - Pass --build-dir and --config explicitly to bootstrap.py.

- conf/distro/include/maintainers.inc:
  - Add maintainer entry for the new rust-source recipe.

License-Update: recipe file renames only, no license change

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 395fe161362c5b6d39a9b01e938d99567c6273c3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-common.bbclass          |  4 +-
 conf/layer.conf                             |  4 ++
 lib/oeqa/selftest/cases/rust_mixin.py       |  9 ++--
 recipes-devtools/rust/cargo_1.96.1.bb       | 10 +++-
 recipes-devtools/rust/common-source.inc     | 28 +++++++++++
 recipes-devtools/rust/libstd-rs_1.96.1.bb   |  4 ++
 recipes-devtools/rust/rust-llvm_1.96.1.bb   |  1 +
 recipes-devtools/rust/rust-source.inc       |  6 ++-
 recipes-devtools/rust/rust-source_1.96.1.bb | 56 +++++++++++++++++++++
 recipes-devtools/rust/rust_1.96.1.bb        | 33 ++++++++----
 10 files changed, 138 insertions(+), 17 deletions(-)
 create mode 100644 recipes-devtools/rust/common-source.inc
 create mode 100644 recipes-devtools/rust/rust-source_1.96.1.bb

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index 31331c7..1533dff 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
@@ -14,7 +14,9 @@ FILES:${PN}-dev += "${rustlibdir}/*.rlib ${rustlibdir}/*.rmeta"
 FILES:${PN}-dbg += "${rustlibdir}/.debug"
 
 RUSTLIB ?= "-L ${STAGING_DIR_HOST}${rustlibdir}"
-RUST_DEBUG_REMAP = "--remap-path-prefix=${WORKDIR}=${TARGET_DBGSRC_DIR}"
+RUST_DEBUG_REMAP = "--remap-path-prefix=${WORKDIR}=${TARGET_DBGSRC_DIR} \
+                    --remap-path-prefix=${TMPDIR}/work-shared=${TARGET_DBGSRC_DIR} \
+"
 RUSTFLAGS += "${RUSTLIB} ${RUST_DEBUG_REMAP}"
 RUSTLIB_DEP ??= "libstd-rs"
 RUST_PANIC_STRATEGY ??= "unwind"
diff --git a/conf/layer.conf b/conf/layer.conf
index 3c5351e..530acad 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -16,3 +16,7 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
 RUSTVERSION ?= "1.96.1%"
+
+# For lack of a better place to put this since it needs to be visible
+# globally, carry it here.
+RECIPE_MAINTAINER:pn-rust-source-1.96.1 = "Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>"
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index f09abbd..fb185b2 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -45,7 +45,8 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
         recipe = "rust"
         start_time = time.time()
         bitbake("{} -c test_compile".format(recipe))
-        builddir = get_bb_var("RUSTSRC", "rust")
+        builddir = get_bb_var("B", "rust")
+        sourcedir = get_bb_var("RUSTSRC", "rust")
         # build core-image-minimal with required packages
         default_installed_packages = ["libgcc", "libstdc++", "libatomic", "libgomp", "openssl"]
         features = []
@@ -109,7 +110,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
             # Copy remote-test-server to image through scp
             host_sys = get_bb_var("RUST_BUILD_SYS", "rust")
             ssh = SSHControl(ip=qemu.ip, logfile=qemu.sshlog, user="root")
-            ssh.copy_to(builddir + "/build/" + host_sys + "/stage2-tools-bin/remote-test-server","~/")
+            ssh.copy_to(builddir + "/rust-build/" + host_sys + "/stage2-tools-bin/remote-test-server","~/")
             # Execute remote-test-server on image through background ssh
             command = '~/remote-test-server --bind 0.0.0.0:12345 -v'
             sshrun=subprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=/dev/null', '-o',  'StrictHostKeyChecking=no', '-f', "root@%s" % qemu.ip, command), shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
@@ -129,8 +130,10 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
             # PowerPC mac99 QEMU has 768MB RAM limit, so we need to minimize test binary sizes
             cmd = cmd + " export RUSTFLAGS='-C strip=debuginfo';"
             # Trigger testing.
+            # Run bootstrap from sourcedir with explicit --build-dir and --config
+            # pointing to the separate build directory.
             cmd = cmd + " export TEST_DEVICE_ADDR=\"%s:12345\";" % qemu.ip
-            cmd = cmd + " cd %s; python3 src/bootstrap/bootstrap.py test %s --target %s" % (builddir, testargs, targetsys)
+            cmd = cmd + " cd %s; python3 src/bootstrap/bootstrap.py --build-dir %s/rust-build --config %s/config.toml test %s --target %s" % (sourcedir, builddir, builddir, testargs, targetsys)
             retval = runCmd(cmd)
             end_time = time.time()
 
diff --git a/recipes-devtools/rust/cargo_1.96.1.bb b/recipes-devtools/rust/cargo_1.96.1.bb
index 64944ff..35e9cf9 100644
--- a/recipes-devtools/rust/cargo_1.96.1.bb
+++ b/recipes-devtools/rust/cargo_1.96.1.bb
@@ -13,6 +13,8 @@ LIC_FILES_CHKSUM = " \
 
 require rust-source.inc
 require rust-snapshot.inc
+# Use shared source tree from rust-source.bb; disables local fetch/unpack/patch
+require common-source.inc
 
 S = "${RUSTSRC}/src/tools/cargo"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
@@ -21,10 +23,13 @@ CVE_PRODUCT = "rust-lang:cargo"
 
 inherit cargo pkgconfig
 
+# Explicit CARGO_HOME avoids cargo caching in the shared source tree
+CARGO_HOME = "${WORKDIR}/cargo_home"
+
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
 
 do_cargo_setup_snapshot () {
-	${WORKDIR}/rust-snapshot-components/${CARGO_SNAPSHOT}/install.sh --prefix="${WORKDIR}/${CARGO_SNAPSHOT}" --disable-ldconfig
+	${UNPACKDIR}/rust-snapshot-components/${CARGO_SNAPSHOT}/install.sh --prefix="${WORKDIR}/${CARGO_SNAPSHOT}" --disable-ldconfig
 	# Need to use uninative's loader if enabled/present since the library paths
 	# are used internally by rust and result in symbol mismatches if we don't
 	if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
@@ -32,9 +37,10 @@ do_cargo_setup_snapshot () {
 	fi
 }
 
-addtask cargo_setup_snapshot after do_unpack before do_configure
+addtask cargo_setup_snapshot before do_configure
 do_cargo_setup_snapshot[dirs] += "${WORKDIR}/${CARGO_SNAPSHOT}"
 do_cargo_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
+do_cargo_setup_snapshot[depends] += "rust-source-${PV}:do_unpack"
 
 
 do_compile:prepend () {
diff --git a/recipes-devtools/rust/common-source.inc b/recipes-devtools/rust/common-source.inc
new file mode 100644
index 0000000..a0d4dc5
--- /dev/null
+++ b/recipes-devtools/rust/common-source.inc
@@ -0,0 +1,28 @@
+# common-source.inc - Disable source tasks for recipes using shared rust-source
+#
+# Recipes that include this file rely on rust-source-${PV} for fetching,
+# unpacking, and patching the Rust source tree. This avoids duplicating the
+# ~4.2 GB rustc-src tree per recipe variant (rust, cargo, libstd-rs and their
+# native/nativesdk counterparts).
+
+# Disable local fetch/unpack/patch since rust-source-${PV} handles them
+do_fetch() {
+        :
+}
+do_fetch[noexec] = "1"
+deltask do_unpack
+deltask do_patch
+
+# Clear SRC_URI to prevent fetcher warnings from stale URIs inherited via .inc
+SRC_URI = ""
+
+# Ensure the shared source is fully ready before dependent tasks run
+do_configure[depends] += "rust-source-${PV}:do_patch"
+do_populate_lic[depends] += "rust-source-${PV}:do_unpack"
+do_create_spdx[depends] += "rust-source-${PV}:do_patch"
+
+# The SPDX class uses is_work_shared_spdx() to detect shared workdirs.
+# Since we redirect S rather than WORKDIR, the default detection fails.
+# Override to always return True so SPDX processing works correctly.
+def is_work_shared_spdx(d):
+    return True
diff --git a/recipes-devtools/rust/libstd-rs_1.96.1.bb b/recipes-devtools/rust/libstd-rs_1.96.1.bb
index 8af93be..b52a514 100644
--- a/recipes-devtools/rust/libstd-rs_1.96.1.bb
+++ b/recipes-devtools/rust/libstd-rs_1.96.1.bb
@@ -5,6 +5,7 @@ LICENSE = "(MIT | Apache-2.0) & Unicode-3.0"
 LIC_FILES_CHKSUM = "file://../../COPYRIGHT;md5=11a3899825f4376896e438c8c753f8dc"
 
 require rust-source.inc
+require common-source.inc
 
 # The dummy crate named `sysroot` represents the standard library target.
 #
@@ -33,6 +34,9 @@ CARGO_FEATURES ?= "panic-unwind backtrace"
 CARGO_BUILD_FLAGS += "--features '${CARGO_FEATURES}'"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
+# Explicit CARGO_HOME avoids cargo caching in the shared source tree
+CARGO_HOME = "${WORKDIR}/cargo_home"
+
 do_compile:prepend () {
     # For Rust 1.13.0 and newer
     export RUSTC_BOOTSTRAP="1"
diff --git a/recipes-devtools/rust/rust-llvm_1.96.1.bb b/recipes-devtools/rust/rust-llvm_1.96.1.bb
index 99ae87e..acd0d57 100644
--- a/recipes-devtools/rust/rust-llvm_1.96.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.96.1.bb
@@ -7,6 +7,7 @@ HOMEPAGE = "http://www.rust-lang.org"
 LLVM_RELEASE = "21.1.3"
 
 require rust-source.inc
+require common-source.inc
 
 SRC_URI += "file://0002-llvm-allow-env-override-of-exe-path.patch;striplevel=2 \
             file://0001-AsmMatcherEmitter-sort-ClassInfo-lists-by-name-as-we.patch;striplevel=2 \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index a5d1568..a58eaec 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -13,7 +13,11 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
 "
 SRC_URI[rust.sha256sum] = "77a6ff3003a4ad0cb00697b043c879e3e1a15d945b1a1f63818903bfc3fa8b98"
 
-RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
+# Point UNPACKDIR into the work-shared location so rust-source.bb and all
+# consumers (via S/RUSTSRC) reference a single shared source tree.
+UNPACKDIR = "${TMPDIR}/work-shared/rust-source-${PV}-${PR}"
+RUSTSRC = "${UNPACKDIR}/rustc-${PV}-src"
+S = "${RUSTSRC}"
 
 UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
diff --git a/recipes-devtools/rust/rust-source_1.96.1.bb b/recipes-devtools/rust/rust-source_1.96.1.bb
new file mode 100644
index 0000000..570c03c
--- /dev/null
+++ b/recipes-devtools/rust/rust-source_1.96.1.bb
@@ -0,0 +1,56 @@
+# rust-source_${PN}.bb - Shared source recipe for the Rust toolchain
+#
+# This recipe fetches, unpacks, and patches the rustc source tree into a
+# work-shared location so that rust, cargo, libstd-rs, and their native/nativesdk
+# variants all share a single copy of the source. This eliminates duplication
+# (up to 11 copies of the ~4.2 GB source tree in multilib + nativesdk builds)
+# and significantly reduces disk usage (~46.2 GB -> ~4.2 GB for rustc-src).
+#
+# Only do_fetch, do_unpack, and do_patch are meaningful here. All other
+# tasks are disabled since this recipe exists solely to provide sources.
+
+SUMMARY = "Rust sources"
+HOMEPAGE = "http://www.rust-lang.org"
+SECTION = "devel"
+LICENSE = "(MIT | Apache-2.0) & Unicode-3.0"
+LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=11a3899825f4376896e438c8c753f8dc"
+
+# This recipe only provides source; disable build/install/packaging tasks
+deltask do_configure
+deltask do_compile
+deltask do_install
+deltask do_populate_sysroot
+deltask do_populate_lic
+
+# Prevent rm_work from removing the shared source tree
+RM_WORK_EXCLUDE += "${PN}"
+
+require rust-source.inc
+require rust-snapshot.inc
+
+inherit allarch nopackages
+
+PN = "rust-source-${PV}"
+BPN = "rust-source"
+
+# Place WORKDIR under work-shared so all consumers reference the same location
+WORKDIR = "${TMPDIR}/work-shared/rust-source-${PV}-${PR}"
+SSTATE_SWSPEC = "sstate:rust-source::${PV}:${PR}::${SSTATE_VERSION}:"
+
+# Use work-shared stamp directory so sstate is shared across all architectures
+STAMP = "${STAMPS_DIR}/work-shared/rust-source-${PV}-${PR}"
+STAMPCLEAN = "${STAMPS_DIR}/work-shared/rust-source-${PV}-*"
+
+DEPENDS = ""
+PACKAGES = ""
+baselib = "lib"
+PACKAGE_ARCH = "all"
+
+B = "${WORKDIR}/build"
+
+# rust-source.bb does not inherit rust-common.bbclass (it is allarch/nopackages
+# and has no toolchain dependencies), so we define RUST_BUILD_ARCH locally for
+# snapshot URL resolution in rust-snapshot.inc.
+RUST_BUILD_ARCH = "${@{'ppc': 'powerpc', 'ppc64': 'powerpc64', 'ppc64le': 'powerpc64le', 'riscv64': 'riscv64gc'}.get(d.getVar('BUILD_ARCH'), d.getVar('BUILD_ARCH'))}"
+
+EXCLUDE_FROM_WORLD = "1"
diff --git a/recipes-devtools/rust/rust_1.96.1.bb b/recipes-devtools/rust/rust_1.96.1.bb
index 2b907c7..03970cd 100644
--- a/recipes-devtools/rust/rust_1.96.1.bb
+++ b/recipes-devtools/rust/rust_1.96.1.bb
@@ -4,6 +4,10 @@ SECTION = "devel"
 LICENSE = "(MIT | Apache-2.0) & Unicode-3.0"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=11a3899825f4376896e438c8c753f8dc"
 
+require rust-source.inc
+require rust-snapshot.inc
+require common-source.inc
+
 inherit rust
 inherit cargo_common
 
@@ -21,6 +25,9 @@ INHIBIT_DEFAULT_RUST_DEPS:class-native = "1"
 PROVIDES:class-native = "virtual/${TARGET_PREFIX}rust"
 
 S = "${RUSTSRC}"
+# Separate build directory from the shared source tree so that multiple
+# variants (target, native, nativesdk) don't conflict in the source dir.
+B = "${WORKDIR}/build"
 
 # Use at your own risk, accepted values are stable, beta and nightly
 RUST_CHANNEL ?= "stable"
@@ -35,6 +42,9 @@ RUST_ALTERNATE_EXE_PATH_NATIVE = "${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-co
 # own vendoring.
 CARGO_DISABLE_BITBAKE_VENDORING = "1"
 
+# Explicit CARGO_HOME avoids cargo caching in the shared source tree
+CARGO_HOME = "${WORKDIR}/cargo_home"
+
 setup_cargo_environment () {
     # The first step is to build bootstrap and some early stage tools,
     # these are build for the same target as the snapshot, e.g.
@@ -46,7 +56,7 @@ setup_cargo_environment () {
 inherit rust-target-config
 
 do_rust_setup_snapshot () {
-    for installer in "${WORKDIR}/rust-snapshot-components/"*"/install.sh"; do
+    for installer in "${UNPACKDIR}/rust-snapshot-components/"*"/install.sh"; do
         "${installer}" --prefix="${WORKDIR}/rust-snapshot" --disable-ldconfig
     done
 
@@ -63,11 +73,11 @@ do_rust_setup_snapshot () {
         done
     fi
 }
-addtask rust_setup_snapshot after do_unpack before do_configure
+addtask rust_setup_snapshot before do_configure
 addtask do_test_compile after do_configure do_rust_gen_targets
 do_rust_setup_snapshot[dirs] += "${WORKDIR}/rust-snapshot"
 do_rust_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
-do_rust_setup_snapshot[depends] += "patchelf-native:do_populate_sysroot"
+do_rust_setup_snapshot[depends] += "patchelf-native:do_populate_sysroot rust-source-${PV}:do_unpack"
 
 RUSTC_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/rustc"
 CARGO_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/cargo"
@@ -169,6 +179,12 @@ python do_configure() {
     # nothing about when trying to build some stage0 tools (like fabricate)
     config.set("build", "build", e(d.getVar("RUST_BUILD_SYS")))
 
+    # Yocto's B (${WORKDIR}/build) is where config.toml lives. Rust's
+    # bootstrap creates its own build output directory inside B; name it
+    # "rust-build" to avoid ambiguity with Yocto's build directory and
+    # prevent a confusing build/build/ nesting.
+    config.set("build", "build-dir", e("rust-build"))
+
     # [install]
     config.add_section("install")
     # ./x.py install doesn't have any notion of "destdir"
@@ -215,13 +231,10 @@ rust_runx () {
 
     oe_cargo_fix_env
 
-    python3 src/bootstrap/bootstrap.py ${@oe.utils.parallel_make_argument(d, '-j %d')} "$@" --verbose
+    python3 ${S}/src/bootstrap/bootstrap.py ${@oe.utils.parallel_make_argument(d, '-j %d')} "$@" --verbose
 }
 rust_runx[vardepsexclude] += "PARALLEL_MAKE"
 
-require rust-source.inc
-require rust-snapshot.inc
-
 INSANE_SKIP:${PN}:class-native = "already-stripped"
 FILES:${PN} += "${libdir}/rustlib"
 FILES:${PN} += "${libdir}/*.so"
@@ -232,7 +245,7 @@ do_compile () {
 
 do_test_compile[dirs] = "${B}"
 do_test_compile () {
-    rust_runx build src/tools/remote-test-server --target "${RUST_TARGET_SYS}"
+    rust_runx build ${S}/src/tools/remote-test-server --target "${RUST_TARGET_SYS}"
 }
 
 ALLOW_EMPTY:${PN} = "1"
@@ -273,7 +286,7 @@ rust_do_install:class-nativesdk() {
 
     install -d ${D}${bindir}
     for i in cargo-clippy clippy-driver rustfmt; do
-        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp rust-build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
@@ -313,7 +326,7 @@ rust_do_install:class-target() {
 
     install -d ${D}${bindir}
     for i in ${EXTRA_TOOLS}; do
-        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp rust-build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
-- 
2.55.0


