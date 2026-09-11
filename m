Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFFC88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:48 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48516.1789157627759238751
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pz8vr9e2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53024149d40so7837181cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157627; x=1789762427; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V2PIo9AfLbIFdtaj8ikm3G3uDKFJlGyHN18S4LuOdvk=;
        b=pz8vr9e2WY0DE3z7kJRf630QKiKlPk0sdx8RbX3XMClGqflAZX5KpUKRrwsvIFTHgT
         KkG03OD1Y4891QCP1vQuu7WmusYc+8H3QGg415+pSrvDbOSWWFIgeJ2AaF8cy2nCi6sz
         T0BFAALomy4r10er6taNRL1dPTPhxO+YORO5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157627; x=1789762427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V2PIo9AfLbIFdtaj8ikm3G3uDKFJlGyHN18S4LuOdvk=;
        b=mkTDfbRWUkdNVODZlFoB2nlOE3TO7IPsJh/ds1SjLr9+M6+rUPk/KzUwG8I1r4MWFn
         ukBsIYvwtYMp+FXHzhMHYc/np84elu+Kf/IdxJuvl00zzgoTGftal88XIzeVMfxKThfy
         gjIp4BWDgIYDUaPkeGr5ZdvKnbv11CT4EH+ISJPpz9cT9ILhjT82JnBttUpjG/VfKZzR
         ZW4ThEf1tHWZ03LgMpvyEVHg8xGh4Zr5hMm0fZUbtS2aBNb6XaGL7rEjAeMvx98OYjSU
         L/tnqbfk7DaBUnurUvyN1zxukTx6xbK7pBG9NJ2MyVrVaxmgBOAo/H11p3e0TZTqxC4M
         lRDA==
X-Gm-Message-State: AFuF++leEkemkRKeBFwwarGx3l/5K9V09O4OJL0/0jI6GLB/zGOuUYsG
	kwU5/+/jUajp0XPl5obobd89oFzYipXjz00GOf0TzivrQqe211rXsESAppqz9U3Y5/NcYYJhFiw
	f3QRD
X-Gm-Gg: AYBFou2mKSPMO7/KUIzpbso2LEIF8Yw82A1m03txxHbfSaFwS5WDKwk6byQh4hnEdIe
	UPYIoTMdrHVmcPkqRWbMEzm50oNlA+HpC6lFoVxcnL26YSGvArrcfY20q27YJPkaeDZn+4YN5ys
	VbToN/yb7U8Brw43GWW/4q/kX2sQupuopxZOYC6bOKOSFFYp2/xBayR1pczN+wnl2n9Mo2nq8Mi
	weMlcv5c2zTlgKB3nhRBeorpSwFHAhMG2XaNXt+1RJrOY67mJ3pwx3tz6ETb+L4ooVuPrp76Dsk
	ud/qxB+eFfGaSJ7u5mXbxNec7OH2p3dMrdkk8KhViP1+6iupSWafqoY3Fm1/YI6E+QFrL3KVCiz
	xvQAY2UdQiiuM/sotZGb2GGlnLv4BMEI8w0Iyavb6Tn+WJVtoBRiWcjxDQFnUF/Q90Dk0uWD747
	pNXs7iIbgPwsrsitjCV0YgLE8IdiscYTfCleTWyDsO/pW2Z2GicxOKS5sufzcnwlmcUu+X9bVe+
	vz4yP0MNIMx9iH2y2R0VGtSrmpLeTYZNav6eczA/k/GqjWJGwS+93kIm9EuxFlyzBq3KlYoDj5t
	4K8+gGsNNrVR0930hgZ+g2fSsitkoDglCSc=
X-Received: by 2002:a05:622a:64a:b0:530:b2e1:8e3f with SMTP id d75a77b69052e-530c87458b1mr91056341cf.58.1789157626481;
        Fri, 11 Sep 2026 13:13:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/37] rust: Move do_update_snapshot to rust-source
Date: Fri, 11 Sep 2026 16:12:55 -0400
Message-ID: <80fd100de90de248676db00e6fb27f3ab3e7733c.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4775

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Move do_update_snapshot from rust to rust-source, since
rust-source now owns do_fetch/do_unpack/do_patch tasks
after the shared source refactoring.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b0734d8d34e04df5f544f119ed9161253e200670)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source_1.96.1.bb | 72 ++++++++++++++++++++
 recipes-devtools/rust/rust_1.96.1.bb        | 73 ---------------------
 2 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/recipes-devtools/rust/rust-source_1.96.1.bb b/recipes-devtools/rust/rust-source_1.96.1.bb
index 570c03c..7f2948e 100644
--- a/recipes-devtools/rust/rust-source_1.96.1.bb
+++ b/recipes-devtools/rust/rust-source_1.96.1.bb
@@ -54,3 +54,75 @@ B = "${WORKDIR}/build"
 RUST_BUILD_ARCH = "${@{'ppc': 'powerpc', 'ppc64': 'powerpc64', 'ppc64le': 'powerpc64le', 'riscv64': 'riscv64gc'}.get(d.getVar('BUILD_ARCH'), d.getVar('BUILD_ARCH'))}"
 
 EXCLUDE_FROM_WORLD = "1"
+
+addtask do_update_snapshot after do_patch
+do_update_snapshot[nostamp] = "1"
+
+# Run with `bitbake rust-source-${PV} -c update_snapshot` to update `rust-snapshot.inc`
+# with the checksums for the rust snapshot associated with this rustc-src tarball.
+python do_update_snapshot() {
+    import json
+    import re
+    import sys
+
+    from collections import defaultdict
+
+    key_value_pairs = {}
+    with open(os.path.join(d.getVar("S"), "src", "stage0")) as f:
+        for line in f:
+            # Skip empty lines or comments
+            if not line.strip() or line.startswith("#"):
+                continue
+            # Split the line into key and value using '=' as separator
+            match = re.match(r'(\S+)\s*=\s*(\S+)', line.strip())
+            if match:
+                key = match.group(1)
+                value = match.group(2)
+                key_value_pairs[key] = value
+    # Extract the required values from key_value_pairs
+    config_dist_server = key_value_pairs.get('dist_server', '')
+    compiler_date = key_value_pairs.get('compiler_date', '')
+    compiler_version = key_value_pairs.get('compiler_version', '')
+
+    src_uri = defaultdict(list)
+    # Assuming checksums_sha256 is now a key-value pair like: checksum_key = checksum_value
+    for k, v in key_value_pairs.items():
+        # Match the pattern for checksums
+        if "dist" in k and "tar.xz" in k:
+            m = re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
+            if m:
+                component = m.group('component')
+                arch = m.group('arch')
+                src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] = \"{v}\"")
+    # Create the snapshot string with the extracted values
+    snapshot = """\
+## This is information on the rust-snapshot (binary) used to build our current release.
+## snapshot info is taken from rust/src/stage0
+## Rust is self-hosting and bootstraps itself with a pre-built previous version of itself.
+## The exact (previous) version that has been used is specified in the source tarball.
+## The version is replicated here.
+
+SNAPSHOT_VERSION = "%s"
+
+""" % compiler_version
+    # Add the checksum components to the snapshot
+    for arch, components in src_uri.items():
+        snapshot += "\n".join(components) + "\n\n"
+    # Add the additional snapshot URIs
+    snapshot += """\
+SRC_URI += " \\
+    ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
+    ${RUST_DIST_SERVER}/dist/${RUSTC_SNAPSHOT}.tar.xz;name=rustc-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
+    ${RUST_DIST_SERVER}/dist/${CARGO_SNAPSHOT}.tar.xz;name=cargo-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
+"
+
+RUST_DIST_SERVER = "%s"
+
+RUST_STD_SNAPSHOT = "rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+RUSTC_SNAPSHOT = "rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+CARGO_SNAPSHOT = "cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+""" % config_dist_server
+    # Write the updated snapshot information to the rust-snapshot.inc file
+    with open(os.path.join(d.getVar("THISDIR"), "rust-snapshot.inc"), "w") as f:
+        f.write(snapshot)
+}
diff --git a/recipes-devtools/rust/rust_1.96.1.bb b/recipes-devtools/rust/rust_1.96.1.bb
index 03970cd..a7101d5 100644
--- a/recipes-devtools/rust/rust_1.96.1.bb
+++ b/recipes-devtools/rust/rust_1.96.1.bb
@@ -345,79 +345,6 @@ rust_do_install:class-target() {
     rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
 }
 
-addtask do_update_snapshot after do_patch
-do_update_snapshot[nostamp] = "1"
-
-# Run with `bitbake -c update_snapshot rust` to update `rust-snapshot.inc`
-# with the checksums for the rust snapshot associated with this rustc-src
-# tarball.
-python do_update_snapshot() {
-    import json
-    import re
-    import sys
-
-    from collections import defaultdict
-
-    key_value_pairs = {}
-    with open(os.path.join(d.getVar("S"), "src", "stage0")) as f:
-        for line in f:
-            # Skip empty lines or comments
-            if not line.strip() or line.startswith("#"):
-                continue
-            # Split the line into key and value using '=' as separator
-            match = re.match(r'(\S+)\s*=\s*(\S+)', line.strip())
-            if match:
-                key = match.group(1)
-                value = match.group(2)
-                key_value_pairs[key] = value
-    # Extract the required values from key_value_pairs
-    config_dist_server = key_value_pairs.get('dist_server', '')
-    compiler_date = key_value_pairs.get('compiler_date', '')
-    compiler_version = key_value_pairs.get('compiler_version', '')
-
-    src_uri = defaultdict(list)
-    # Assuming checksums_sha256 is now a key-value pair like: checksum_key = checksum_value
-    for k, v in key_value_pairs.items():
-        # Match the pattern for checksums
-        if "dist" in k and "tar.xz" in k:
-            m = re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
-            if m:
-                component = m.group('component')
-                arch = m.group('arch')
-                src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] = \"{v}\"")
-    # Create the snapshot string with the extracted values
-    snapshot = """\
-## This is information on the rust-snapshot (binary) used to build our current release.
-## snapshot info is taken from rust/src/stage0
-## Rust is self-hosting and bootstraps itself with a pre-built previous version of itself.
-## The exact (previous) version that has been used is specified in the source tarball.
-## The version is replicated here.
-
-SNAPSHOT_VERSION = "%s"
-
-""" % compiler_version
-    # Add the checksum components to the snapshot
-    for arch, components in src_uri.items():
-        snapshot += "\n".join(components) + "\n\n"
-    # Add the additional snapshot URIs
-    snapshot += """\
-SRC_URI += " \\
-    ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
-    ${RUST_DIST_SERVER}/dist/${RUSTC_SNAPSHOT}.tar.xz;name=rustc-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
-    ${RUST_DIST_SERVER}/dist/${CARGO_SNAPSHOT}.tar.xz;name=cargo-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
-"
-
-RUST_DIST_SERVER = "%s"
-
-RUST_STD_SNAPSHOT = "rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
-RUSTC_SNAPSHOT = "rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
-CARGO_SNAPSHOT = "cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
-""" % config_dist_server
-    # Write the updated snapshot information to the rust-snapshot.inc file
-    with open(os.path.join(d.getVar("THISDIR"), "rust-snapshot.inc"), "w") as f:
-        f.write(snapshot)
-}
-
 RUSTLIB_DEP:class-nativesdk = ""
 
 # musl builds include libunwind.a
-- 
2.55.0


