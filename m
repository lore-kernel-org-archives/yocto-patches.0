Return-Path: <dorum@noisolation.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A18D711C2
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 16:25:56 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.17913.1732119949744784886
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Nov 2024 08:25:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@noisolation.com header.s=google header.b=JlQBjNn5;
 spf=pass (domain: noisolation.com, ip: 209.85.167.42, mailfrom: dorum@noisolation.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e4b7409fso1190786e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noisolation.com; s=google; t=1732119948; x=1732724748; darn=lists.yoctoproject.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouOwJ1ZPfvVIcUg+jfL5jO9a+ic2rUVQG3iFiUFbFiA=;
        b=JlQBjNn5uvGuGvyL8gVUvSHRuk1h78MP/q6pg8z/owl/qCCBJfQKFGBSLotQw3+tUy
         MDNSz5IS7PUmdimdUBKJHmmJgjJO3f//lKUv9AYWO5jVWAv0atbHyQ7RGYcB13a0L2+5
         sLOMjb3EYhXspHnayoZdZ6MSmKc6L6bSOMqWGjMPTAgjLWIMuTdhHdb6zBxJWRWUn4g7
         lLu1AvF/TRqrFp1aF559wR2YeNrS64ma6KGdCzAudWSIswi1oX6oRasFEs70bZQ9Jk7C
         vMh/Ifn5Cp4i2MkW5GlZBjvEOHHuUWxL/H5uPvJr02Z8hu4yLrBa8XWiD18Ovjp1o5Md
         xD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119948; x=1732724748;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouOwJ1ZPfvVIcUg+jfL5jO9a+ic2rUVQG3iFiUFbFiA=;
        b=vGLeNmovmPFK1OKtbJVKOrWZ27MJYAM17lVPi3hKz8tDQLJbKXMTmEQ/AsdR9/xVKJ
         vah3SCQqa8oYldQeTKsn3wrQC4WGqS2ooOq+M5Oal1wYCj+Uu69/TmVSdWttxk9WVSi9
         Ti6hNFJLdZ1lIBpI/YOhP+xiVF/H+fZacObgqHMX64BZiTtFTXNY4EWcgbnKtF2tF/Em
         yUkeZg14EUD4lqpyGR0pe40Kn5eG3jwQpfju16tdKf3rqJz+SNXIG98o0q3mB8CkI0Uc
         Wf3AwnFP0aX27NQgfeayZmC1MRnIvQK4BbBLA3ukrFrQm87scg9QakXQzXLuPiruUcmn
         PK1A==
X-Gm-Message-State: AOJu0YzIG1M/tMoiBVM9wFAMFNoSqClrY1+/Qp2f/1s/5s/ND6WYBWJV
	pgmPVPaII5q/Gee71b4mSbcYDmxiuziyQSuhbN5jIouTkcZe7+Pja5gJKfJxREGjcwar0FU4vuu
	3
X-Google-Smtp-Source: AGHT+IGEL0pMnkungccWgzzUgtdOc1leJoakyrS0WmFSejpnebvZub/svndIro5SFd4l9NsyZawUBQ==
X-Received: by 2002:ac2:4c4c:0:b0:539:e873:6d4 with SMTP id 2adb3069b0e04-53dc0fbd2d6mr1322100e87.22.1732119946495;
        Wed, 20 Nov 2024 08:25:46 -0800 (PST)
Received: from smtpclient.apple (203.237.92.62.static.cust.telenor.net. [62.92.237.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edfc1sm686989e87.41.2024.11.20.08.25.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:25:45 -0800 (PST)
From: =?utf-8?Q?Martin_D=C3=B8rum?= <dorum@noisolation.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: [meta-lts-mixins] Create scarthgap/rust branch to backport Rust 1.80
 to Scarthgap
Message-Id: <C9A737D5-315E-444F-8D89-1B190D13D3AC@noisolation.com>
Date: Wed, 20 Nov 2024 17:25:32 +0100
Cc: yocto@lists.yoctoproject.org
To: yocto-patches@lists.yoctoproject.org
X-Mailer: Apple Mail (2.3826.200.121)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Nov 2024 16:25:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/826

At present, upgrading from Kirkstone to Scarthgap might mean
downgrading from Rust 1.78 to Rust 1.75, because
meta-lts-mixins kirkstone/rust exists to backport Rust 1.78 to
Kirkstone while there's no equivalent for Scarthgap.
We encountered this issue as we tried to upgrade from Kirkstone
to Scarthgap and were unable to build code which depends on Rust 1.78.

To enable our upgrade from Kirkstone to Scarthgap, I created a
meta-lts-mixins scarthgap/rust branch myself, with backports from
the current Poky master branch, in the style of meta-lts-mixins
kirkstone/rust.

I kept the recipes as unchanged from master as possible,
but I had to replace ${UNPACKDIR} with ${WORKDIR},
as that change turned out to be incompatible with Scarthgap.
The Scarthgap version of the recipes uses ${WORKDIR}.

I kept the master branch's Rust 1.78 recipes,
even though they don't work.
They could be made to work by setting different shasums for different
Rust versions in 'rust-source.inc'.
I kept it as-is because if this should be fixed at all,
it should probably be fixed in the master branch first
and then backported.

I haven't tested this extremely thoroughly,
but I've verified that a basic Yocto project with Poky Scarthgap +
scarthgap/rust can build librsvg (a Rust library).
I've also tested it with our real-world Yocto setup which
has some application software written in Rust.

What follows is a commit which works as the root commit of a new
scarthgap/rust branch.

=46rom 50f95beb1db66d2b2473ac88a7488123222acbfd Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Martin=3D20D=3DC3=3DB8rum?=3D <dorum@noisolation.com>
Date: Wed, 20 Nov 2024 13:33:17 +0000
Subject: [PATCH] initial commit: rust 1.80

---
.gitignore                                    |   1 +
LICENSE.MIT                                   |  25 +
README.md                                     |  72 ++
.../cargo-update-recipe-crates.bbclass        |  81 +++
classes-recipe/cargo.bbclass                  |  93 +++
classes-recipe/cargo_c.bbclass                |  41 ++
classes-recipe/cargo_common.bbclass           | 238 ++++++
classes-recipe/ptest-cargo.bbclass            | 138 ++++
classes-recipe/python_pyo3.bbclass            |  36 +
classes-recipe/rust-common.bbclass            | 196 +++++
classes-recipe/rust-target-config.bbclass     | 440 ++++++++++++
classes-recipe/rust.bbclass                   |  51 ++
conf/layer.conf                               |  29 +
lib/mixin/rust.py                             |  13 +
meta/lib/oeqa/selftest/cases/rust.py          | 132 ++++
.../packagegroup-rust-cross-canadian.bb       |  21 +
.../packagegroup-rust-sdk-target.bb           |  14 +
recipes-devtools/rust/README-rust.md          |  38 +
recipes-devtools/rust/cargo-c-crates.inc      | 676 ++++++++++++++++++
.../cargo-c-native_0.10.3+cargo-0.81.0.bb     |  17 +
recipes-devtools/rust/cargo_1.78.0.bb         |  73 ++
recipes-devtools/rust/cargo_1.80.0.bb         |  73 ++
...te-host-information-into-compilation.patch |  51 ++
.../rust/files/cross-targets-backport.patch   |  31 +
.../rust/files/hardcodepaths.patch            |  46 ++
...crease-timeout-in-process-sigpipe-ru.patch |  31 +
...epro-issue-fix-with-cc-crate-hashmap.patch |  57 ++
.../rust/files/rust-oe-selftest.patch         | 403 +++++++++++
...ue-fix-cargo-config-for-codegenunits.patch |  26 +
.../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ++
.../rust/files/rv32-rustix-libc-backend.patch |  33 +
.../rust/files/target-rust-ccld.c             |  19 +
.../rust/files/zlib-off64_t.patch             |  33 +
recipes-devtools/rust/libstd-rs_1.78.0.bb     |  55 ++
recipes-devtools/rust/libstd-rs_1.80.0.bb     |  55 ++
recipes-devtools/rust/rust-cross-canadian.inc |  92 +++
.../rust/rust-cross-canadian_1.78.0.bb        |   2 +
.../rust/rust-cross-canadian_1.80.0.bb        |   2 +
...r-sort-ClassInfo-lists-by-name-as-we.patch |  31 +
...-llvm-allow-env-override-of-exe-path.patch |  33 +
.../0003-llvm-fix-include-benchmarks.patch    |  25 +
recipes-devtools/rust/rust-llvm_1.78.0.bb     |  94 +++
recipes-devtools/rust/rust-llvm_1.80.0.bb     |  94 +++
recipes-devtools/rust/rust-snapshot.inc       |  67 ++
recipes-devtools/rust/rust-source.inc         |  22 +
recipes-devtools/rust/rust_1.78.0.bb          | 369 ++++++++++
recipes-devtools/rust/rust_1.80.0.bb          | 369 ++++++++++
47 files changed, 4608 insertions(+)
create mode 100644 .gitignore
create mode 100644 LICENSE.MIT
create mode 100644 README.md
create mode 100644 classes-recipe/cargo-update-recipe-crates.bbclass
create mode 100644 classes-recipe/cargo.bbclass
create mode 100644 classes-recipe/cargo_c.bbclass
create mode 100644 classes-recipe/cargo_common.bbclass
create mode 100644 classes-recipe/ptest-cargo.bbclass
create mode 100644 classes-recipe/python_pyo3.bbclass
create mode 100644 classes-recipe/rust-common.bbclass
create mode 100644 classes-recipe/rust-target-config.bbclass
create mode 100644 classes-recipe/rust.bbclass
create mode 100644 conf/layer.conf
create mode 100644 lib/mixin/rust.py
create mode 100644 meta/lib/oeqa/selftest/cases/rust.py
create mode 100644 =
recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
create mode 100644 =
recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
create mode 100644 recipes-devtools/rust/README-rust.md
create mode 100644 recipes-devtools/rust/cargo-c-crates.inc
create mode 100644 =
recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb
create mode 100644 recipes-devtools/rust/cargo_1.78.0.bb
create mode 100644 recipes-devtools/rust/cargo_1.80.0.bb
create mode 100644 =
recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-=
compilation.patch
create mode 100644 =
recipes-devtools/rust/files/cross-targets-backport.patch
create mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
create mode 100644 =
recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigp=
ipe-ru.patch
create mode 100644 =
recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.patch
create mode 100644 recipes-devtools/rust/files/rust-oe-selftest.patch
create mode 100644 =
recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codeg=
enunits.patch
create mode 100644 =
recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
create mode 100644 =
recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
create mode 100644 recipes-devtools/rust/files/target-rust-ccld.c
create mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
create mode 100644 recipes-devtools/rust/libstd-rs_1.78.0.bb
create mode 100644 recipes-devtools/rust/libstd-rs_1.80.0.bb
create mode 100644 recipes-devtools/rust/rust-cross-canadian.inc
create mode 100644 recipes-devtools/rust/rust-cross-canadian_1.78.0.bb
create mode 100644 recipes-devtools/rust/rust-cross-canadian_1.80.0.bb
create mode 100644 =
recipes-devtools/rust/rust-llvm/0001-AsmMatcherEmitter-sort-ClassInfo-list=
s-by-name-as-we.patch
create mode 100644 =
recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path.p=
atch
create mode 100644 =
recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
create mode 100644 recipes-devtools/rust/rust-llvm_1.78.0.bb
create mode 100644 recipes-devtools/rust/rust-llvm_1.80.0.bb
create mode 100644 recipes-devtools/rust/rust-snapshot.inc
create mode 100644 recipes-devtools/rust/rust-source.inc
create mode 100644 recipes-devtools/rust/rust_1.78.0.bb
create mode 100644 recipes-devtools/rust/rust_1.80.0.bb

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0d20b64
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+*.pyc
diff --git a/LICENSE.MIT b/LICENSE.MIT
new file mode 100644
index 0000000..a6919eb
--- /dev/null
+++ b/LICENSE.MIT
@@ -0,0 +1,25 @@
+Permission is hereby granted, free of charge, to any person obtaining a =
copy
+of this software and associated documentation files (the "Software"), =
to deal
+in the Software without restriction, including without limitation the =
rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included =
in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING =
FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+SOFTWARE.
+
+Note:
+Individual files contain the following tag instead of the full license =
text.
+
+    SPDX-License-Identifier: MIT
+
+This enables machine processing of license information based on the =
SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..173c4de
--- /dev/null
+++ b/README.md
@@ -0,0 +1,72 @@
+meta-mixins-lts - scarthgap/rust
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+A "mixin" layer for adding current Rust toolchain into the Yocto =
Project LTS.
+At the time Scarthgap was released in April 2024 it included Rust =
1.75.0, and
+officially Scarthgap supports only that. This thin special-purpose =
mixin
+layer is meant to provide a current Rust toolchain for Scarthgap by
+backporting the appropriate recipes from the master branch of
+openembedded-core.
+
+Notes
+-----
+
+- **Not all Rust version updates carried here have been individually =
tested!**
+  Care has been taken to keep backported changes in the same order as =
they
+  have been applied to oe-core, so the various older Rust versions =
should
+  be buildable, but that is not guaranteed.  It is highly recommended =
that
+  you perform your own tests for correctness when using this layer.  =
The
+  cargo-ptests bbclass has been backported to potentially assist with
+  doing so.
+- cargo-update-recipe-crates.bbclass has been backported with a tweak =
to
+  use host rather than native Python since kirkstone does not have a =
new
+  enough Python (3.11 is required).  Using the update task in the class
+  will fail unless the host environment contains Python 3.11 or newer.
+- While changes to Rust recipe and class files related to oe-selftest
+  support are included by necessity, no effort has been made to =
backport
+  the actual addition of Rust to oe-selftest, as that is considered too
+  invasive and maintenance heavy.
+- To include Rust support in a SDK, do the following in e.g. =
local.conf:
+  ```
+  TOOLCHAIN_HOST_TASK:append =3D " =
packagegroup-rust-cross-canadian-${MACHINE}" =20
+  TOOLCHAIN_TARGET_TASK:append =3D " ${@multilib_pkg_extend(d, =
'libstd-rs')}"
+  ```
+  Overriding populate_sdk_base.bbclass to avoid needing to do this =
seems
+  too invasive for this layer.
+- The intent is to track any further upgrades that occur in the master
+  branch of oe-core, with an expected end of support in April 2026, the
+  same as Yocto Project's planned EOL for Kirkstone (per
+  https://wiki.yoctoproject.org/wiki/Releases).
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git =20
+  layers: meta =20
+  branch: scarthgap
+
+Contributing
+------------
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is =
used
+for questions, comments and patch review. It is subscriber only, so =
please
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][scarthgap/rust]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=3Dyocto-patches@lists.yoctoproject.org =
--subject-prefix=3D'meta-lts-mixins][scarthgap/rust][PATCH'
+
+Note that changes that are not direct backports from oe-core master =
branch, or
+are not fixes for a demonstrated build breakage against Scarthgap are =
unlikely
+to be accepted.  Functional changes should be submitted and merged to =
oe-core
+master branch first.
+
+Maintenance
+-----------
+
+Layer maintainers:
+Scott Murray <scott.murray@konsulko.com>
diff --git a/classes-recipe/cargo-update-recipe-crates.bbclass =
b/classes-recipe/cargo-update-recipe-crates.bbclass
new file mode 100644
index 0000000..3251d5e
--- /dev/null
+++ b/classes-recipe/cargo-update-recipe-crates.bbclass
@@ -0,0 +1,81 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+##
+## Purpose:
+## This class is used to update the list of crates in SRC_URI
+## by reading Cargo.lock in the source tree.
+##
+## See meta/recipes-devtools/python/python3-bcrypt_*.bb for an example
+##
+## To perform the update: bitbake -c update_crates recipe-name
+
+addtask do_update_crates after do_patch
+do_update_crates[depends] =3D "python3-native:do_populate_sysroot"
+do_update_crates[nostamp] =3D "1"
+do_update_crates[doc] =3D "Update the recipe by reading Cargo.lock and =
write in ${THISDIR}/${BPN}-crates.inc"
+
+RECIPE_UPGRADE_EXTRA_TASKS +=3D "do_update_crates"
+
+# The directory where to search for Cargo.lock files
+CARGO_LOCK_SRC_DIR ??=3D "${S}"
+
+do_update_crates() {
+    TARGET_FILE=3D"${THISDIR}/${BPN}-crates.inc"
+
+    nativepython3 - <<EOF
+
+def get_crates(f):
+    import tomllib
+    c_list =3D '# from %s' % os.path.relpath(f, =
'${CARGO_LOCK_SRC_DIR}')
+    c_list +=3D '\nSRC_URI +=3D " \\\'
+    crates =3D tomllib.load(open(f, 'rb'))
+
+    # Build a list with crates info that have crates.io in the source
+    crates_candidates =3D list(filter(lambda c: 'crates.io' in =
c.get('source', ''), crates['package']))
+
+    if not crates_candidates:
+        raise ValueError("Unable to find any candidate crates that use =
crates.io")
+
+    # Update crates uri and their checksum, to avoid name clashing on =
the checksum
+    # we need to rename crates with name and version to have a unique =
key
+    cksum_list =3D ''
+    for c in crates_candidates:
+        rename =3D "%s-%s" % (c['name'], c['version'])
+        c_list +=3D '\n    crate://crates.io/%s/%s \\\' % (c['name'], =
c['version'])
+        if 'checksum' in c:
+            cksum_list +=3D '\nSRC_URI[%s.sha256sum] =3D "%s"' % =
(rename, c['checksum'])
+
+    c_list +=3D '\n"\n'
+    c_list +=3D cksum_list
+    c_list +=3D '\n'
+    return c_list
+
+import os
+crates =3D "# Autogenerated with 'bitbake -c update_crates ${PN}'\n\n"
+found =3D False
+for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
+    # ignore git and patches directories
+    if root.startswith(os.path.join('${CARGO_LOCK_SRC_DIR}', '.pc')):
+        continue
+    if root.startswith(os.path.join('${CARGO_LOCK_SRC_DIR}', '.git')):
+        continue
+    for file in files:
+        if file =3D=3D 'Cargo.lock':
+            try:
+                cargo_lock_path =3D os.path.join(root, file)
+                crates +=3D get_crates(os.path.join(root, file))
+            except Exception as e:
+                raise ValueError("Cannot parse '%s'" % cargo_lock_path) =
from e
+            else:
+                found =3D True
+if not found:
+    raise ValueError("Unable to find any Cargo.lock in =
${CARGO_LOCK_SRC_DIR}")
+open("${TARGET_FILE}", 'w').write(crates)
+EOF
+
+    bbnote "Successfully update crates inside '${TARGET_FILE}'"
+}
diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
new file mode 100644
index 0000000..0829a58
--- /dev/null
+++ b/classes-recipe/cargo.bbclass
@@ -0,0 +1,93 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+##
+## Purpose:
+## This class is used by any recipes that are built using
+## Cargo.
+
+inherit cargo_common
+inherit rust-target-config
+
+# the binary we will use
+CARGO =3D "cargo"
+
+# We need cargo to compile for the target
+BASEDEPENDS:append =3D " cargo-native"
+
+# Ensure we get the right rust variant
+DEPENDS:append:class-target =3D " rust-native ${RUSTLIB_DEP}"
+DEPENDS:append:class-nativesdk =3D " rust-native ${RUSTLIB_DEP}"
+DEPENDS:append:class-native =3D " rust-native"
+
+# Enable build separation
+B =3D "${WORKDIR}/build"
+
+# In case something fails in the build process, give a bit more =
feedback on
+# where the issue occured
+export RUST_BACKTRACE =3D "1"
+
+RUSTFLAGS ??=3D ""
+BUILD_MODE =3D "${@['--release', ''][d.getVar('DEBUG_BUILD') =3D=3D =
'1']}"
+# --frozen flag will prevent network access (which is required since =
only
+# the do_fetch step is authorized to access network)
+# and will require an up to date Cargo.lock file.
+# This force the package being built to already ship a Cargo.lock, in =
the end
+# this is what we want, at least, for reproducibility of the build.
+CARGO_BUILD_FLAGS =3D "-v --frozen --target ${RUST_HOST_SYS} =
${BUILD_MODE} --manifest-path=3D${CARGO_MANIFEST_PATH}"
+
+# This is based on the content of CARGO_BUILD_FLAGS and generally will =
need to
+# change if CARGO_BUILD_FLAGS changes.
+BUILD_DIR =3D "${@['release', 'debug'][d.getVar('DEBUG_BUILD') =3D=3D =
'1']}"
+CARGO_TARGET_SUBDIR=3D"${RUST_HOST_SYS}/${BUILD_DIR}"
+oe_cargo_build () {
+	export RUSTFLAGS=3D"${RUSTFLAGS}"
+	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
+	bbnote "cargo =3D $(which ${CARGO})"
+	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
+	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
+}
+
+do_compile[progress] =3D "outof:\s+(\d+)/(\d+)"
+cargo_do_compile () {
+	oe_cargo_build
+}
+
+cargo_do_install () {
+	local have_installed=3Dfalse
+	for tgt in "${B}/target/${CARGO_TARGET_SUBDIR}/"*; do
+		case $tgt in
+		*.so|*.rlib)
+			install -d "${D}${rustlibdir}"
+			install -m755 "$tgt" "${D}${rustlibdir}"
+			have_installed=3Dtrue
+			;;
+		*examples)
+			if [ -d "$tgt" ]; then
+				for example in "$tgt/"*; do
+					if [ -f "$example" ] && [ -x =
"$example" ]; then
+						install -d =
"${D}${bindir}"
+						install -m755 "$example" =
"${D}${bindir}"
+						have_installed=3Dtrue
+					fi
+				done
+			fi
+			;;
+		*)
+			if [ -f "$tgt" ] && [ -x "$tgt" ]; then
+				install -d "${D}${bindir}"
+				install -m755 "$tgt" "${D}${bindir}"
+				have_installed=3Dtrue
+			fi
+			;;
+		esac
+	done
+	if ! $have_installed; then
+		die "Did not find anything to install"
+	fi
+}
+
+EXPORT_FUNCTIONS do_compile do_install
diff --git a/classes-recipe/cargo_c.bbclass =
b/classes-recipe/cargo_c.bbclass
new file mode 100644
index 0000000..ef43163
--- /dev/null
+++ b/classes-recipe/cargo_c.bbclass
@@ -0,0 +1,41 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+##
+## Purpose:
+## This class is used by any recipes that want to compile a C ABI =
compatible
+## library with header and pkg config file
+
+inherit cargo pkgconfig
+
+# the binaries we will use
+CARGO_C_BUILD =3D "cargo-cbuild"
+CARGO_C_INSTALL =3D "cargo-cinstall"
+
+# We need cargo-c to compile for the target
+BASEDEPENDS:append =3D " cargo-c-native"
+
+do_compile[progress] =3D "outof:\s+(\d+)/(\d+)"
+cargo_c_do_compile() {
+    oe_cargo_fix_env
+    export RUSTFLAGS=3D"${RUSTFLAGS}"
+    bbnote "Using rust targets from ${RUST_TARGET_PATH}"
+    bbnote "cargo-cbuild =3D $(which ${CARGO_C_BUILD})"
+    bbnote "${CARGO_C_BUILD} cbuild ${CARGO_BUILD_FLAGS}"
+    "${CARGO_C_BUILD}" cbuild ${CARGO_BUILD_FLAGS}
+}
+
+cargo_c_do_install() {
+    oe_cargo_fix_env
+    export RUSTFLAGS=3D"${RUSTFLAGS}"
+    bbnote "cargo-cinstall =3D $(which ${CARGO_C_INSTALL})"
+    "${CARGO_C_INSTALL}" cinstall ${CARGO_BUILD_FLAGS} \
+        --destdir ${D} \
+        --prefix ${prefix} \
+        --library-type cdylib
+}
+
+EXPORT_FUNCTIONS do_compile do_install
diff --git a/classes-recipe/cargo_common.bbclass =
b/classes-recipe/cargo_common.bbclass
new file mode 100644
index 0000000..26de947
--- /dev/null
+++ b/classes-recipe/cargo_common.bbclass
@@ -0,0 +1,238 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+##
+## Purpose:
+## This class is to support building with cargo. It
+## must be different than cargo.bbclass because Rust
+## now builds with Cargo but cannot use cargo.bbclass
+## due to dependencies and assumptions in cargo.bbclass
+## that Rust & Cargo are already installed. So this
+## is used by cargo.bbclass and Rust
+##
+
+# add crate fetch support
+inherit rust-common
+
+# Where we download our registry and dependencies to
+export CARGO_HOME =3D "${WORKDIR}/cargo_home"
+
+# The pkg-config-rs library used by cargo build scripts disables itself =
when
+# cross compiling unless this is defined. We set up pkg-config =
appropriately
+# for cross compilation, so tell it we know better than it.
+export PKG_CONFIG_ALLOW_CROSS =3D "1"
+
+# Don't instruct cargo to use crates downloaded by bitbake. Some rust =
packages,
+# for example the rust compiler itself, come with their own vendored =
sources.
+# Specifying two [source.crates-io] will not work.
+CARGO_DISABLE_BITBAKE_VENDORING ??=3D "0"
+
+# Used by libstd-rs to point to the vendor dir included in rustc src
+CARGO_VENDORING_DIRECTORY ??=3D "${CARGO_HOME}/bitbake"
+
+# The directory of the Cargo.toml relative to the root directory, per =
default
+# assume there's a Cargo.toml directly in the root directory
+CARGO_SRC_DIR ??=3D ""
+
+# The actual path to the Cargo.toml
+CARGO_MANIFEST_PATH ??=3D "${S}/${CARGO_SRC_DIR}/Cargo.toml"
+
+# Path to Cargo.lock
+CARGO_LOCK_PATH ??=3D "${@ =
os.path.join(os.path.dirname(d.getVar('CARGO_MANIFEST_PATH')), =
'Cargo.lock')}"
+
+CARGO_RUST_TARGET_CCLD ??=3D "${RUST_TARGET_CCLD}"
+cargo_common_do_configure () {
+	mkdir -p ${CARGO_HOME}/bitbake
+
+	cat <<- EOF > ${CARGO_HOME}/config
+	# EXTRA_OECARGO_PATHS
+	paths =3D [
+	$(for p in ${EXTRA_OECARGO_PATHS}; do echo \"$p\",; done)
+	]
+	EOF
+
+	cat <<- EOF >> ${CARGO_HOME}/config
+
+	# Local mirror vendored by bitbake
+	[source.bitbake]
+	directory =3D "${CARGO_VENDORING_DIRECTORY}"
+	EOF
+
+	if [ ${CARGO_DISABLE_BITBAKE_VENDORING} =3D "0" ]; then
+		cat <<- EOF >> ${CARGO_HOME}/config
+
+		[source.crates-io]
+		replace-with =3D "bitbake"
+		local-registry =3D "/nonexistent"
+		EOF
+	fi
+
+	cat <<- EOF >> ${CARGO_HOME}/config
+
+	[http]
+	# Multiplexing can't be enabled because http2 can't be enabled
+	# in curl-native without dependency loops
+	multiplexing =3D false
+
+	# Ignore the hard coded and incorrect path to certificates
+	cainfo =3D =
"${STAGING_ETCDIR_NATIVE}/ssl/certs/ca-certificates.crt"
+
+	EOF
+
+	cat <<- EOF >> ${CARGO_HOME}/config
+
+	# HOST_SYS
+	[target.${RUST_HOST_SYS}]
+	linker =3D "${CARGO_RUST_TARGET_CCLD}"
+	EOF
+
+	if [ "${RUST_HOST_SYS}" !=3D "${RUST_BUILD_SYS}" ]; then
+		cat <<- EOF >> ${CARGO_HOME}/config
+
+		# BUILD_SYS
+		[target.${RUST_BUILD_SYS}]
+		linker =3D "${RUST_BUILD_CCLD}"
+		EOF
+	fi
+
+	if [ "${RUST_TARGET_SYS}" !=3D "${RUST_BUILD_SYS}" -a =
"${RUST_TARGET_SYS}" !=3D "${RUST_HOST_SYS}" ]; then
+		cat <<- EOF >> ${CARGO_HOME}/config
+
+		# TARGET_SYS
+		[target.${RUST_TARGET_SYS}]
+		linker =3D "${RUST_TARGET_CCLD}"
+		EOF
+	fi
+
+	# Put build output in build directory preferred by bitbake =
instead of
+	# inside source directory unless they are the same
+	if [ "${B}" !=3D "${S}" ]; then
+		cat <<- EOF >> ${CARGO_HOME}/config
+
+		[build]
+		# Use out of tree build destination to avoid polluting =
the source tree
+		target-dir =3D "${B}/target"
+		EOF
+	fi
+
+	cat <<- EOF >> ${CARGO_HOME}/config
+
+	[term]
+	progress.when =3D 'always'
+	progress.width =3D 80
+	EOF
+}
+
+python cargo_common_do_patch_paths() {
+    import shutil
+
+    cargo_config =3D os.path.join(d.getVar("CARGO_HOME"), "config")
+    if not os.path.exists(cargo_config):
+        return
+
+    src_uri =3D (d.getVar('SRC_URI') or "").split()
+    if len(src_uri) =3D=3D 0:
+        return
+
+    patches =3D dict()
+    workdir =3D d.getVar('WORKDIR')
+    fetcher =3D bb.fetch2.Fetch(src_uri, d)
+    for url in fetcher.urls:
+        ud =3D fetcher.ud[url]
+        if ud.type =3D=3D 'git' or ud.type =3D=3D 'gitsm':
+            name =3D ud.parm.get('name')
+            destsuffix =3D ud.parm.get('destsuffix')
+            if name is not None and destsuffix is not None:
+                if ud.user:
+                    repo =3D '%s://%s@%s%s' % (ud.proto, ud.user, =
ud.host, ud.path)
+                else:
+                    repo =3D '%s://%s%s' % (ud.proto, ud.host, ud.path)
+                path =3D '%s =3D { path =3D "%s" }' % (name, =
os.path.join(workdir, destsuffix))
+                patches.setdefault(repo, []).append(path)
+
+    with open(cargo_config, "a+") as config:
+        for k, v in patches.items():
+            print('\n[patch."%s"]' % k, file=3Dconfig)
+            for name in v:
+                print(name, file=3Dconfig)
+
+    if not patches:
+        return
+
+    # Cargo.lock file is needed for to be sure that artifacts
+    # downloaded by the fetch steps are those expected by the
+    # project and that the possible patches are correctly applied.
+    # Moreover since we do not want any modification
+    # of this file (for reproducibility purpose), we prevent it by
+    # using --frozen flag (in CARGO_BUILD_FLAGS) and raise a clear =
error
+    # here is better than letting cargo tell (in case the file is =
missing)
+    # "Cargo.lock should be modified but --frozen was given"
+
+    lockfile =3D d.getVar("CARGO_LOCK_PATH")
+    if not os.path.exists(lockfile):
+        bb.fatal(f"{lockfile} file doesn't exist")
+
+    # There are patched files and so Cargo.lock should be modified but =
we use
+    # --frozen so let's handle that modifications here.
+    #
+    # Note that a "better" (more elegant ?) would have been to use =
cargo update for
+    # patched packages:
+    #  cargo update --offline -p package_1 -p package_2
+    # But this is not possible since it requires that cargo local git =
db
+    # to be populated and this is not the case as we fetch git repo =
ourself.
+
+    lockfile_orig =3D lockfile + ".orig"
+    if not os.path.exists(lockfile_orig):
+        shutil.copy(lockfile, lockfile_orig)
+
+    newlines =3D []
+    with open(lockfile_orig, "r") as f:
+        for line in f.readlines():
+            if not line.startswith("source =3D \"git"):
+                newlines.append(line)
+
+    with open(lockfile, "w") as f:
+        f.writelines(newlines)
+}
+do_configure[postfuncs] +=3D "cargo_common_do_patch_paths"
+
+do_compile:prepend () {
+        oe_cargo_fix_env
+}
+
+oe_cargo_fix_env () {
+	export CC=3D"${RUST_TARGET_CC}"
+	export CXX=3D"${RUST_TARGET_CXX}"
+	export CFLAGS=3D"${CFLAGS}"
+	export CXXFLAGS=3D"${CXXFLAGS}"
+	export AR=3D"${AR}"
+	export TARGET_CC=3D"${RUST_TARGET_CC}"
+	export TARGET_CXX=3D"${RUST_TARGET_CXX}"
+	export TARGET_CFLAGS=3D"${CFLAGS}"
+	export TARGET_CXXFLAGS=3D"${CXXFLAGS}"
+	export TARGET_AR=3D"${AR}"
+	export HOST_CC=3D"${RUST_BUILD_CC}"
+	export HOST_CXX=3D"${RUST_BUILD_CXX}"
+	export HOST_CFLAGS=3D"${BUILD_CFLAGS}"
+	export HOST_CXXFLAGS=3D"${BUILD_CXXFLAGS}"
+	export HOST_AR=3D"${BUILD_AR}"
+}
+
+EXTRA_OECARGO_PATHS ??=3D ""
+
+EXPORT_FUNCTIONS do_configure
+
+# The culprit for this setting is the libc crate,
+# which as of Jun 2023 calls directly into 32 bit time functions in =
glibc,
+# bypassing all of glibc provisions to choose the right Y2038-safe =
functions. As
+# rust components statically link with that crate, pretty much =
everything
+# is affected, and so there's no point trying to have recipe-specific
+# INSANE_SKIP entries.
+#
+# Upstream ticket and PR:
+# https://github.com/rust-lang/libc/issues/3223
+# https://github.com/rust-lang/libc/pull/3175
+INSANE_SKIP:append =3D " 32bit-time"
diff --git a/classes-recipe/ptest-cargo.bbclass =
b/classes-recipe/ptest-cargo.bbclass
new file mode 100644
index 0000000..fd1df9d
--- /dev/null
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -0,0 +1,138 @@
+inherit cargo ptest
+
+RUST_TEST_ARGS ??=3D ""
+RUST_TEST_ARGS[doc] =3D "Arguments to give to the test binaries (e.g. =
--shuffle)"
+
+# I didn't find a cleaner way to share data between compile and install =
tasks
+CARGO_TEST_BINARIES_FILES ?=3D "${B}/test_binaries_list"
+
+# Sadly, generated test binaries have no deterministic names =
(https://github.com/rust-lang/cargo/issues/1924)
+# This forces us to parse the cargo output in json format to find those =
test binaries.
+python do_compile_ptest_cargo() {
+    import subprocess
+    import json
+
+    cargo =3D bb.utils.which(d.getVar("PATH"), d.getVar("CARGO"))
+    cargo_build_flags =3D d.getVar("CARGO_BUILD_FLAGS")
+    rust_flags =3D d.getVar("RUSTFLAGS")
+    manifest_path =3D d.getVar("CARGO_MANIFEST_PATH")
+    project_manifest_path =3D os.path.normpath(manifest_path)
+    manifest_dir =3D os.path.dirname(manifest_path)
+
+    env =3D os.environ.copy()
+    env['RUSTFLAGS'] =3D rust_flags
+    cmd =3D f"{cargo} build --tests --message-format json =
{cargo_build_flags}"
+    bb.note(f"Building tests with cargo ({cmd})")
+
+    try:
+        proc =3D subprocess.Popen(cmd, shell=3DTrue, env=3Denv, =
stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STDOUT, text=3DTrue)
+    except subprocess.CalledProcessError as e:
+        bb.fatal(f"Cannot build test with cargo: {e}")
+
+    lines =3D []
+    for line in proc.stdout:
+        data =3D line.strip('\n')
+        lines.append(data)
+        bb.note(data)
+    proc.communicate()
+    if proc.returncode !=3D 0:
+        bb.fatal(f"Unable to compile test with cargo, '{cmd}' failed")
+
+    # Definition of the format: =
https://doc.rust-lang.org/cargo/reference/external-tools.html#json-message=
s
+    test_bins =3D []
+    for line in lines:
+        try:
+            data =3D json.loads(line)
+        except json.JSONDecodeError:
+            # skip lines that are not a json
+            pass
+        else:
+            try:
+                # Filter the test packages coming from the current =
project:
+                #    - test binaries from the root manifest
+                #    - test binaries from sub manifest of the current =
project if any
+                current_manifest_path =3D =
os.path.normpath(data['manifest_path'])
+                common_path =3D =
os.path.commonpath([current_manifest_path, project_manifest_path])
+                if common_path in [manifest_dir, =
current_manifest_path]:
+                    if (data['target']['test'] or =
data['target']['doctest']) and data['executable']:
+                        test_bins.append(data['executable'])
+            except (KeyError, ValueError) as e:
+                # skip lines that do not meet the requirements
+                pass
+
+    # All rust project will generate at least one unit test binary
+    # It will just run a test suite with 0 tests, if the project didn't =
define some
+    # So it is not expected to have an empty list here
+    if not test_bins:
+        bb.fatal("Unable to find any test binaries")
+
+    cargo_test_binaries_file =3D d.getVar('CARGO_TEST_BINARIES_FILES')
+    bb.note(f"Found {len(test_bins)} tests, write their paths into =
{cargo_test_binaries_file}")
+    with open(cargo_test_binaries_file, "w") as f:
+        for test_bin in test_bins:
+            f.write(f"{test_bin}\n")
+
+}
+
+python do_install_ptest_cargo() {
+    import shutil
+
+    dest_dir =3D d.getVar("D")
+    pn =3D d.getVar("PN")
+    ptest_path =3D d.getVar("PTEST_PATH")
+    cargo_test_binaries_file =3D d.getVar('CARGO_TEST_BINARIES_FILES')
+    rust_test_args =3D d.getVar('RUST_TEST_ARGS') or ""
+
+    ptest_dir =3D os.path.join(dest_dir, ptest_path.lstrip('/'))
+    os.makedirs(ptest_dir, exist_ok=3DTrue)
+
+    test_bins =3D []
+    with open(cargo_test_binaries_file, "r") as f:
+        for line in f.readlines():
+            test_bins.append(line.strip('\n'))
+
+    test_paths =3D []
+    for test_bin in test_bins:
+        shutil.copy2(test_bin, ptest_dir)
+        test_paths.append(os.path.join(ptest_path, =
os.path.basename(test_bin)))
+
+    ptest_script =3D os.path.join(ptest_dir, "run-ptest")
+    if os.path.exists(ptest_script):
+        with open(ptest_script, "a") as f:
+            f.write(f"\necho \"\"\n")
+            f.write(f"echo \"## starting to run rust tests ##\"\n")
+            for test_path in test_paths:
+                f.write(f"{test_path} {rust_test_args}\n")
+    else:
+        with open(ptest_script, "a") as f:
+            f.write("#!/bin/sh\n")
+            for test_path in test_paths:
+                f.write(f"{test_path} {rust_test_args}\n")
+        os.chmod(ptest_script, 0o755)
+
+    # this is chown -R root:root ${D}${PTEST_PATH}
+    for root, dirs, files in os.walk(ptest_dir):
+        for d in dirs:
+            shutil.chown(os.path.join(root, d), "root", "root")
+        for f in files:
+            shutil.chown(os.path.join(root, f), "root", "root")
+}
+
+do_install_ptest_cargo[dirs] =3D "${B}"
+do_install_ptest_cargo[doc] =3D "Create or update the run-ptest script =
with rust test binaries generated"
+do_compile_ptest_cargo[dirs] =3D "${B}"
+do_compile_ptest_cargo[doc] =3D "Generate rust test binaries through =
cargo"
+
+addtask compile_ptest_cargo after do_compile            before =
do_compile_ptest_base
+addtask install_ptest_cargo after do_install_ptest_base before =
do_package
+
+python () {
+    if not bb.data.inherits_class('native', d) and not =
bb.data.inherits_class('cross', d):
+        d.setVarFlag('do_install_ptest_cargo', 'fakeroot', '1')
+        d.setVarFlag('do_install_ptest_cargo', 'umask', '022')
+
+    # Remove all '*ptest_cargo' tasks when ptest is not enabled
+    if not(d.getVar('PTEST_ENABLED') =3D=3D "1"):
+        for i in ['do_compile_ptest_cargo', 'do_install_ptest_cargo']:
+            bb.build.deltask(i, d)
+}
diff --git a/classes-recipe/python_pyo3.bbclass =
b/classes-recipe/python_pyo3.bbclass
new file mode 100644
index 0000000..9a32eac
--- /dev/null
+++ b/classes-recipe/python_pyo3.bbclass
@@ -0,0 +1,36 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+#
+# This class helps make sure that Python extensions built with PyO3
+# and setuptools_rust properly set up the environment for cross =
compilation
+#
+
+inherit cargo python3-dir siteinfo
+
+export PYO3_CROSS=3D"1"
+export PYO3_CROSS_PYTHON_VERSION=3D"${PYTHON_BASEVERSION}"
+export PYO3_CROSS_LIB_DIR=3D"${STAGING_LIBDIR}"
+export CARGO_BUILD_TARGET=3D"${RUST_HOST_SYS}"
+export RUSTFLAGS
+export PYO3_PYTHON=3D"${PYTHON}"
+export PYO3_CONFIG_FILE=3D"${WORKDIR}/pyo3.config"
+
+python_pyo3_do_configure () {
+    cat > ${WORKDIR}/pyo3.config << EOF
+implementation=3DCPython
+version=3D${PYTHON_BASEVERSION}
+shared=3Dtrue
+abi3=3Dfalse
+lib_name=3D${PYTHON_DIR}
+lib_dir=3D${STAGING_LIBDIR}
+pointer_width=3D${SITEINFO_BITS}
+build_flags=3DWITH_THREAD
+suppress_build_script_link_lines=3Dfalse
+EOF
+}
+
+EXPORT_FUNCTIONS do_configure
diff --git a/classes-recipe/rust-common.bbclass =
b/classes-recipe/rust-common.bbclass
new file mode 100644
index 0000000..6940093
--- /dev/null
+++ b/classes-recipe/rust-common.bbclass
@@ -0,0 +1,196 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit python3native
+inherit rust-target-config
+
+# Common variables used by all Rust builds
+export rustlibdir =3D "${libdir}/rustlib/${RUST_HOST_SYS}/lib"
+FILES:${PN} +=3D "${rustlibdir}/*.so"
+FILES:${PN}-dev +=3D "${rustlibdir}/*.rlib ${rustlibdir}/*.rmeta"
+FILES:${PN}-dbg +=3D "${rustlibdir}/.debug"
+
+RUSTLIB =3D "-L ${STAGING_DIR_HOST}${rustlibdir}"
+RUST_DEBUG_REMAP =3D =
"--remap-path-prefix=3D${WORKDIR}=3D${TARGET_DBGSRC_DIR}"
+RUSTFLAGS +=3D "${RUSTLIB} ${RUST_DEBUG_REMAP}"
+RUSTLIB_DEP ??=3D "libstd-rs"
+RUST_PANIC_STRATEGY ??=3D "unwind"
+
+def target_is_armv7(d):
+    '''Determine if target is armv7'''
+    # TUNE_FEATURES may include arm* even if the target is not arm
+    # in the case of *-native packages
+    if d.getVar('TARGET_ARCH') !=3D 'arm':
+        return False
+
+    feat =3D d.getVar('TUNE_FEATURES')
+    feat =3D frozenset(feat.split())
+    mach_overrides =3D d.getVar('MACHINEOVERRIDES')
+    mach_overrides =3D frozenset(mach_overrides.split(':'))
+
+    v7=3Dfrozenset(['armv7a', 'armv7r', 'armv7m', 'armv7ve'])
+    if mach_overrides.isdisjoint(v7) and feat.isdisjoint(v7):
+        return False
+    else:
+        return True
+target_is_armv7[vardepvalue] =3D "${@target_is_armv7(d)}"
+
+# Responsible for taking Yocto triples and converting it to Rust =
triples
+def rust_base_triple(d, thing):
+    '''
+    Mangle bitbake's *_SYS into something that rust might support (see
+    rust/mk/cfg/* for a list)
+
+    Note that os is assumed to be some linux form
+    '''
+
+    # The llvm-target for armv7 is armv7-unknown-linux-gnueabihf
+    if d.getVar('{}_ARCH'.format(thing)) =3D=3D d.getVar('TARGET_ARCH') =
and target_is_armv7(d):
+        arch =3D "armv7"
+    else:
+        arch =3D =
oe.rust.arch_to_rust_arch(d.getVar('{}_ARCH'.format(thing)))
+
+    # Substituting "unknown" when vendor is empty will match rust's =
standard
+    # targets when building native recipes (including rust-native =
itself)
+    vendor =3D d.getVar('{}_VENDOR'.format(thing)) or "-unknown"
+
+    # Default to glibc
+    libc =3D "-gnu"
+    os =3D d.getVar('{}_OS'.format(thing))
+    # This catches ARM targets and appends the necessary hard float =
bits
+    if os =3D=3D "linux-gnueabi" or os =3D=3D "linux-musleabi":
+        libc =3D bb.utils.contains('TUNE_FEATURES', =
'callconvention-hard', 'hf', '', d)
+    elif os =3D=3D "linux-gnux32" or os =3D=3D "linux-muslx32":
+        libc =3D ""
+    elif "musl" in os:
+        libc =3D "-musl"
+        os =3D "linux"
+    elif "elf" in os:
+        libc =3D "-elf"
+        os =3D "none"
+    elif "eabi" in os:
+        libc =3D "-eabi"
+        os =3D "none"
+
+    return arch + vendor + '-' + os + libc
+
+
+# In some cases uname and the toolchain differ on their idea of the =
arch name
+RUST_BUILD_ARCH =3D =
"${@oe.rust.arch_to_rust_arch(d.getVar('BUILD_ARCH'))}"
+
+# Naming explanation
+# Yocto
+# - BUILD_SYS - Yocto triple of the build environment
+# - HOST_SYS - What we're building for in Yocto
+# - TARGET_SYS - What we're building for in Yocto
+#
+# So when building '-native' packages BUILD_SYS =3D=3D HOST_SYS =3D=3D =
TARGET_SYS
+# When building packages for the image HOST_SYS =3D=3D TARGET_SYS
+# This is a gross over simplification as there are other modes but
+# currently this is all that's supported.
+#
+# Rust
+# - TARGET - the system where the binary will run
+# - HOST - the system where the binary is being built
+#
+# Rust additionally will use two additional cases:
+# - undecorated (e.g. CC) - equivalent to TARGET
+# - triple suffix (e.g. CC:x86_64_unknown_linux_gnu) - both
+#   see: https://github.com/rust-lang/cc-rs
+# The way that Rust's internal triples and Yocto triples are mapped =
together
+# its likely best to not use the triple suffix due to potential =
confusion.
+
+RUST_BUILD_SYS =3D "${@rust_base_triple(d, 'BUILD')}"
+RUST_BUILD_SYS[vardepvalue] =3D "${RUST_BUILD_SYS}"
+RUST_HOST_SYS =3D "${@rust_base_triple(d, 'HOST')}"
+RUST_HOST_SYS[vardepvalue] =3D "${RUST_HOST_SYS}"
+RUST_TARGET_SYS =3D "${@rust_base_triple(d, 'TARGET')}"
+RUST_TARGET_SYS[vardepvalue] =3D "${RUST_TARGET_SYS}"
+
+# wrappers to get around the fact that Rust needs a single
+# binary but Yocto's compiler and linker commands have
+# arguments. Technically the archiver is always one command but
+# this is necessary for builds that determine the prefix and then
+# use those commands based on the prefix.
+WRAPPER_DIR =3D "${WORKDIR}/wrapper"
+RUST_BUILD_CC =3D "${WRAPPER_DIR}/build-rust-cc"
+RUST_BUILD_CXX =3D "${WRAPPER_DIR}/build-rust-cxx"
+RUST_BUILD_CCLD =3D "${WRAPPER_DIR}/build-rust-ccld"
+RUST_BUILD_AR =3D "${WRAPPER_DIR}/build-rust-ar"
+RUST_TARGET_CC =3D "${WRAPPER_DIR}/target-rust-cc"
+RUST_TARGET_CXX =3D "${WRAPPER_DIR}/target-rust-cxx"
+RUST_TARGET_CCLD =3D "${WRAPPER_DIR}/target-rust-ccld"
+RUST_TARGET_AR =3D "${WRAPPER_DIR}/target-rust-ar"
+
+create_wrapper_rust () {
+	file=3D"$1"
+	shift
+	extras=3D"$1"
+	shift
+	crate_cc_extras=3D"$1"
+	shift
+
+	cat <<- EOF > "${file}"
+	#!/usr/bin/env python3
+	import os, sys
+	orig_binary =3D "$@"
+	extras =3D "${extras}"
+
+	# Apply a required subset of CC crate compiler flags
+	# when we build a target recipe for a non-bare-metal target.
+	# https://github.com/rust-lang/cc-rs/blob/main/src/lib.rs#L1614
+	if "CRATE_CC_NO_DEFAULTS" in os.environ.keys() and \
+	   "TARGET" in os.environ.keys() and not "-none-" in =
os.environ["TARGET"]:
+	    orig_binary +=3D "${crate_cc_extras}"
+
+	binary =3D orig_binary.split()[0]
+	args =3D orig_binary.split() + sys.argv[1:]
+	if extras:
+	    args.append(extras)
+	os.execvp(binary, args)
+	EOF
+	chmod +x "${file}"
+}
+
+WRAPPER_TARGET_CC =3D "${CC}"
+WRAPPER_TARGET_CXX =3D "${CXX}"
+WRAPPER_TARGET_CCLD =3D "${CCLD}"
+WRAPPER_TARGET_LDFLAGS =3D "${LDFLAGS}"
+WRAPPER_TARGET_EXTRALD =3D ""
+# see =
recipes-devtools/gcc/gcc/0018-Add-ssp_nonshared-to-link-commandline-for-mu=
sl-targe.patch
+# we need to link with ssp_nonshared on musl to avoid "undefined =
reference to `__stack_chk_fail_local'"
+# when building MACHINE=3Dqemux86 for musl
+WRAPPER_TARGET_EXTRALD:libc-musl =3D "-lssp_nonshared"
+WRAPPER_TARGET_AR =3D "${AR}"
+
+# compiler is used by gcc-rs
+# linker is used by rustc/cargo
+# archiver is used by the build of libstd-rs
+do_rust_create_wrappers () {
+	mkdir -p "${WRAPPER_DIR}"
+
+	# Yocto Build / Rust Host C compiler
+	create_wrapper_rust "${RUST_BUILD_CC}" "" "${CRATE_CC_FLAGS}" =
"${BUILD_CC}"
+	# Yocto Build / Rust Host C++ compiler
+	create_wrapper_rust "${RUST_BUILD_CXX}" "" "${CRATE_CC_FLAGS}" =
"${BUILD_CXX}"
+	# Yocto Build / Rust Host linker
+	create_wrapper_rust "${RUST_BUILD_CCLD}" "" "" "${BUILD_CCLD}" =
"${BUILD_LDFLAGS}"
+	# Yocto Build / Rust Host archiver
+	create_wrapper_rust "${RUST_BUILD_AR}" "" "" "${BUILD_AR}"
+
+	# Yocto Target / Rust Target C compiler
+	create_wrapper_rust "${RUST_TARGET_CC}" =
"${WRAPPER_TARGET_EXTRALD}" "${CRATE_CC_FLAGS}" "${WRAPPER_TARGET_CC}" =
"${WRAPPER_TARGET_LDFLAGS}"
+	# Yocto Target / Rust Target C++ compiler
+	create_wrapper_rust "${RUST_TARGET_CXX}" =
"${WRAPPER_TARGET_EXTRALD}" "${CRATE_CC_FLAGS}" "${WRAPPER_TARGET_CXX}" =
"${CXXFLAGS}"
+	# Yocto Target / Rust Target linker
+	create_wrapper_rust "${RUST_TARGET_CCLD}" =
"${WRAPPER_TARGET_EXTRALD}" "" "${WRAPPER_TARGET_CCLD}" =
"${WRAPPER_TARGET_LDFLAGS}"
+	# Yocto Target / Rust Target archiver
+	create_wrapper_rust "${RUST_TARGET_AR}" "" "" =
"${WRAPPER_TARGET_AR}"
+
+}
+
+addtask rust_create_wrappers before do_configure after do_patch =
do_prepare_recipe_sysroot
+do_rust_create_wrappers[dirs] +=3D "${WRAPPER_DIR}"
diff --git a/classes-recipe/rust-target-config.bbclass =
b/classes-recipe/rust-target-config.bbclass
new file mode 100644
index 0000000..f7aa6c7
--- /dev/null
+++ b/classes-recipe/rust-target-config.bbclass
@@ -0,0 +1,440 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+# Right now this is focused on arm-specific tune features.
+# We get away with this for now as one can only use x86-64 as the build =
host
+# (not arm).
+# Note that TUNE_FEATURES is _always_ refering to the target, so we =
really
+# don't want to use this for the host/build.
+def llvm_features_from_tune(d):
+    f =3D []
+    feat =3D d.getVar('TUNE_FEATURES')
+    if not feat:
+        return []
+    feat =3D frozenset(feat.split())
+
+    mach_overrides =3D d.getVar('MACHINEOVERRIDES')
+    mach_overrides =3D frozenset(mach_overrides.split(':'))
+
+    if 'vfpv4' in feat:
+        f.append("+vfp4")
+    elif 'vfpv4d16' in feat:
+        f.append("+vfp4")
+        f.append("-d32")
+    elif 'vfpv3' in feat:
+        f.append("+vfp3")
+    elif 'vfpv3d16' in feat:
+        f.append("+vfp3")
+        f.append("-d32")
+    elif 'vfpv2' in feat or 'vfp' in feat:
+        f.append("+vfp2")
+
+    if 'neon' in feat:
+        f.append("+neon")
+    elif target_is_armv7(d):
+        f.append("-neon")
+
+    if 'mips32' in feat:
+        f.append("+mips32")
+
+    if 'mips32r2' in feat:
+        f.append("+mips32r2")
+
+    if target_is_armv7(d):
+        f.append('+v7')
+
+    if ('armv6' in mach_overrides) or ('armv6' in feat):
+        f.append("+v6")
+    if 'armv5te' in feat:
+        f.append("+strict-align")
+        f.append("+v5te")
+    elif 'armv5' in feat:
+        f.append("+strict-align")
+        f.append("+v5")
+
+    if ('armv4' in mach_overrides) or ('armv4' in feat):
+        f.append("+strict-align")
+
+    if 'dsp' in feat:
+        f.append("+dsp")
+
+    if 'thumb' in feat:
+        if d.getVar('ARM_THUMB_OPT') =3D=3D "thumb":
+            if target_is_armv7(d):
+                f.append('+thumb2')
+            f.append("+thumb-mode")
+
+    if 'cortexa5' in feat:
+        f.append("+a5")
+    if 'cortexa7' in feat:
+        f.append("+a7")
+    if 'cortexa9' in feat:
+        f.append("+a9")
+    if 'cortexa15' in feat:
+        f.append("+a15")
+    if 'cortexa17' in feat:
+        f.append("+a17")
+    if ('riscv64' in feat) or ('riscv32' in feat):
+        f.append("+a,+c,+d,+f,+m")
+    return f
+llvm_features_from_tune[vardepvalue] =3D =
"${@llvm_features_from_tune(d)}"
+
+# TARGET_CC_ARCH changes from build/cross/target so it'll do the right =
thing
+# this should go away when https://github.com/rust-lang/rust/pull/31709 =
is
+# stable (1.9.0?)
+def llvm_features_from_cc_arch(d):
+    f =3D []
+    feat =3D d.getVar('TARGET_CC_ARCH')
+    if not feat:
+        return []
+    feat =3D frozenset(feat.split())
+
+    if '-mmmx' in feat:
+        f.append("+mmx")
+    if '-msse' in feat:
+        f.append("+sse")
+    if '-msse2' in feat:
+        f.append("+sse2")
+    if '-msse3' in feat:
+        f.append("+sse3")
+    if '-mssse3' in feat:
+        f.append("+ssse3")
+    if '-msse4.1' in feat:
+        f.append("+sse4.1")
+    if '-msse4.2' in feat:
+        f.append("+sse4.2")
+    if '-msse4a' in feat:
+        f.append("+sse4a")
+    if '-mavx' in feat:
+        f.append("+avx")
+    if '-mavx2' in feat:
+        f.append("+avx2")
+
+    return f
+
+def llvm_features_from_target_fpu(d):
+    # TARGET_FPU can be hard or soft. +soft-float tell llvm to use soft =
float
+    # ABI. There is no option for hard.
+
+    fpu =3D d.getVar('TARGET_FPU')
+    return ["+soft-float"] if fpu =3D=3D "soft" else []
+
+def llvm_features(d):
+    return ','.join(llvm_features_from_tune(d) +
+                    llvm_features_from_cc_arch(d) +
+                    llvm_features_from_target_fpu(d))
+
+llvm_features[vardepvalue] =3D "${@llvm_features(d)}"
+
+## arm-unknown-linux-gnueabihf
+DATA_LAYOUT[arm-eabi] =3D =
"e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
+TARGET_ENDIAN[arm-eabi] =3D "little"
+TARGET_POINTER_WIDTH[arm-eabi] =3D "32"
+TARGET_C_INT_WIDTH[arm-eabi] =3D "32"
+MAX_ATOMIC_WIDTH[arm-eabi] =3D "64"
+FEATURES[arm-eabi] =3D "+v6,+vfp2"
+
+## armv7-unknown-linux-gnueabihf
+DATA_LAYOUT[armv7-eabi] =3D =
"e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
+TARGET_ENDIAN[armv7-eabi] =3D "little"
+TARGET_POINTER_WIDTH[armv7-eabi] =3D "32"
+TARGET_C_INT_WIDTH[armv7-eabi] =3D "32"
+MAX_ATOMIC_WIDTH[armv7-eabi] =3D "64"
+FEATURES[armv7-eabi] =3D "+v7,+vfp2,+thumb2"
+
+## aarch64-unknown-linux-{gnu, musl}
+DATA_LAYOUT[aarch64] =3D =
"e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
+TARGET_ENDIAN[aarch64] =3D "little"
+TARGET_POINTER_WIDTH[aarch64] =3D "64"
+TARGET_C_INT_WIDTH[aarch64] =3D "32"
+MAX_ATOMIC_WIDTH[aarch64] =3D "128"
+
+## x86_64-unknown-linux-{gnu, musl}
+DATA_LAYOUT[x86_64] =3D =
"e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:6=
4-S128"
+TARGET_ENDIAN[x86_64] =3D "little"
+TARGET_POINTER_WIDTH[x86_64] =3D "64"
+TARGET_C_INT_WIDTH[x86_64] =3D "32"
+MAX_ATOMIC_WIDTH[x86_64] =3D "64"
+
+## x86_64-unknown-linux-gnux32
+DATA_LAYOUT[x86_64-x32] =3D =
"e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64=
-S128"
+TARGET_ENDIAN[x86_64-x32] =3D "little"
+TARGET_POINTER_WIDTH[x86_64-x32] =3D "32"
+TARGET_C_INT_WIDTH[x86_64-x32] =3D "32"
+MAX_ATOMIC_WIDTH[x86_64-x32] =3D "64"
+
+## i686-unknown-linux-{gnu, musl}
+DATA_LAYOUT[i686] =3D "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
+TARGET_ENDIAN[i686] =3D "little"
+TARGET_POINTER_WIDTH[i686] =3D "32"
+TARGET_C_INT_WIDTH[i686] =3D "32"
+MAX_ATOMIC_WIDTH[i686] =3D "64"
+
+## XXX: a bit of a hack so qemux86 builds, clone of =
i686-unknown-linux-{gnu, musl} above
+DATA_LAYOUT[i586] =3D "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
+TARGET_ENDIAN[i586] =3D "little"
+TARGET_POINTER_WIDTH[i586] =3D "32"
+TARGET_C_INT_WIDTH[i586] =3D "32"
+MAX_ATOMIC_WIDTH[i586] =3D "64"
+
+## mips-unknown-linux-{gnu, musl}
+DATA_LAYOUT[mips] =3D "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
+TARGET_ENDIAN[mips] =3D "big"
+TARGET_POINTER_WIDTH[mips] =3D "32"
+TARGET_C_INT_WIDTH[mips] =3D "32"
+MAX_ATOMIC_WIDTH[mips] =3D "32"
+
+## mipsel-unknown-linux-{gnu, musl}
+DATA_LAYOUT[mipsel] =3D =
"e-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64"
+TARGET_ENDIAN[mipsel] =3D "little"
+TARGET_POINTER_WIDTH[mipsel] =3D "32"
+TARGET_C_INT_WIDTH[mipsel] =3D "32"
+MAX_ATOMIC_WIDTH[mipsel] =3D "32"
+
+## mips64-unknown-linux-{gnu, musl}
+DATA_LAYOUT[mips64] =3D "E-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
+TARGET_ENDIAN[mips64] =3D "big"
+TARGET_POINTER_WIDTH[mips64] =3D "64"
+TARGET_C_INT_WIDTH[mips64] =3D "64"
+MAX_ATOMIC_WIDTH[mips64] =3D "64"
+
+## mips64-n32-unknown-linux-{gnu, musl}
+DATA_LAYOUT[mips64-n32] =3D =
"E-m:e-p:32:32-i8:8:32-i16:16:32-i64:64-n32:64-S128"
+TARGET_ENDIAN[mips64-n32] =3D "big"
+TARGET_POINTER_WIDTH[mips64-n32] =3D "32"
+TARGET_C_INT_WIDTH[mips64-n32] =3D "32"
+MAX_ATOMIC_WIDTH[mips64-n32] =3D "64"
+
+## mips64el-unknown-linux-{gnu, musl}
+DATA_LAYOUT[mips64el] =3D "e-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
+TARGET_ENDIAN[mips64el] =3D "little"
+TARGET_POINTER_WIDTH[mips64el] =3D "64"
+TARGET_C_INT_WIDTH[mips64el] =3D "64"
+MAX_ATOMIC_WIDTH[mips64el] =3D "64"
+
+## powerpc-unknown-linux-{gnu, musl}
+DATA_LAYOUT[powerpc] =3D "E-m:e-p:32:32-i64:64-n32"
+TARGET_ENDIAN[powerpc] =3D "big"
+TARGET_POINTER_WIDTH[powerpc] =3D "32"
+TARGET_C_INT_WIDTH[powerpc] =3D "32"
+MAX_ATOMIC_WIDTH[powerpc] =3D "32"
+
+## powerpc64-unknown-linux-{gnu, musl}
+DATA_LAYOUT[powerpc64] =3D =
"E-m:e-i64:64-n32:64-S128-v256:256:256-v512:512:512"
+TARGET_ENDIAN[powerpc64] =3D "big"
+TARGET_POINTER_WIDTH[powerpc64] =3D "64"
+TARGET_C_INT_WIDTH[powerpc64] =3D "64"
+MAX_ATOMIC_WIDTH[powerpc64] =3D "64"
+
+## powerpc64le-unknown-linux-{gnu, musl}
+DATA_LAYOUT[powerpc64le] =3D =
"e-m:e-i64:64-n32:64-v256:256:256-v512:512:512"
+TARGET_ENDIAN[powerpc64le] =3D "little"
+TARGET_POINTER_WIDTH[powerpc64le] =3D "64"
+TARGET_C_INT_WIDTH[powerpc64le] =3D "64"
+MAX_ATOMIC_WIDTH[powerpc64le] =3D "64"
+
+## riscv32gc-unknown-linux-{gnu, musl}
+DATA_LAYOUT[riscv32gc] =3D "e-m:e-p:32:32-i64:64-n32-S128"
+TARGET_ENDIAN[riscv32gc] =3D "little"
+TARGET_POINTER_WIDTH[riscv32gc] =3D "32"
+TARGET_C_INT_WIDTH[riscv32gc] =3D "32"
+MAX_ATOMIC_WIDTH[riscv32gc] =3D "32"
+
+## riscv64gc-unknown-linux-{gnu, musl}
+DATA_LAYOUT[riscv64gc] =3D "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
+TARGET_ENDIAN[riscv64gc] =3D "little"
+TARGET_POINTER_WIDTH[riscv64gc] =3D "64"
+TARGET_C_INT_WIDTH[riscv64gc] =3D "64"
+MAX_ATOMIC_WIDTH[riscv64gc] =3D "64"
+
+## loongarch64-unknown-linux-{gnu, musl}
+DATA_LAYOUT[loongarch64] =3D =
"e-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128"
+TARGET_ENDIAN[loongarch64] =3D "little"
+TARGET_POINTER_WIDTH[loongarch64] =3D "64"
+TARGET_C_INT_WIDTH[loongarch64] =3D "32"
+MAX_ATOMIC_WIDTH[loongarch64] =3D "64"
+FEATURES[loongarch64] =3D "+d"
+
+# Convert a normal arch (HOST_ARCH, TARGET_ARCH, BUILD_ARCH, etc) to =
something
+# rust's internals won't choke on.
+def arch_to_rust_target_arch(arch):
+    if arch =3D=3D "i586" or arch =3D=3D "i686":
+        return "x86"
+    elif arch =3D=3D "mipsel":
+        return "mips"
+    elif arch =3D=3D "mip64sel":
+        return "mips64"
+    elif arch =3D=3D "armv7":
+        return "arm"
+    elif arch =3D=3D "powerpc64le":
+        return "powerpc64"
+    elif arch =3D=3D "riscv32gc":
+        return "riscv32"
+    elif arch =3D=3D "riscv64gc":
+        return "riscv64"
+    else:
+        return arch
+
+# Convert a rust target string to a llvm-compatible triplet
+def rust_sys_to_llvm_target(sys):
+    if sys.startswith('riscv32gc-'):
+        return sys.replace('riscv32gc-', 'riscv32-', 1)
+    if sys.startswith('riscv64gc-'):
+        return sys.replace('riscv64gc-', 'riscv64-', 1)
+    return sys
+
+# generates our target CPU value
+def llvm_cpu(d):
+    cpu =3D d.getVar('PACKAGE_ARCH')
+    target =3D d.getVar('TRANSLATED_TARGET_ARCH')
+
+    trans =3D {}
+    trans['corei7-64'] =3D "corei7"
+    trans['core2-32'] =3D "core2"
+    trans['x86-64'] =3D "x86-64"
+    trans['i686'] =3D "i686"
+    trans['i586'] =3D "i586"
+    trans['mips64'] =3D "mips64"
+    trans['mips64el'] =3D "mips64"
+    trans['powerpc64le'] =3D "ppc64le"
+    trans['powerpc64'] =3D "ppc64"
+    trans['riscv64'] =3D "generic-rv64"
+    trans['riscv32'] =3D "generic-rv32"
+    trans['loongarch64'] =3D "la464"
+
+    if target in ["mips", "mipsel", "powerpc"]:
+        feat =3D frozenset(d.getVar('TUNE_FEATURES').split())
+        if "mips32r2" in feat:
+            trans['mipsel'] =3D "mips32r2"
+            trans['mips'] =3D "mips32r2"
+        elif "mips32" in feat:
+            trans['mipsel'] =3D "mips32"
+            trans['mips'] =3D "mips32"
+        elif "ppc7400" in feat:
+            trans['powerpc'] =3D "7400"
+
+    try:
+        return trans[cpu]
+    except:
+        return trans.get(target, "generic")
+
+llvm_cpu[vardepvalue] =3D "${@llvm_cpu(d)}"
+
+def rust_gen_target(d, thing, wd, arch):
+    import json
+
+    build_sys =3D d.getVar('BUILD_SYS')
+    target_sys =3D d.getVar('TARGET_SYS')
+
+    sys =3D d.getVar('{}_SYS'.format(thing))
+    prefix =3D d.getVar('{}_PREFIX'.format(thing))
+    rustsys =3D d.getVar('RUST_{}_SYS'.format(thing))
+
+    abi =3D None
+    cpu =3D "generic"
+    features =3D ""
+
+    # Need to apply the target tuning consitently, only if the triplet =
applies to the target
+    # and not in the native case
+    if sys =3D=3D target_sys and sys !=3D build_sys:
+        abi =3D d.getVar('ABIEXTENSION')
+        cpu =3D llvm_cpu(d)
+        if bb.data.inherits_class('native', d):
+            features =3D ','.join(llvm_features_from_cc_arch(d))
+        else:
+            features =3D llvm_features(d) or ""
+        # arm and armv7 have different targets in llvm
+        if arch =3D=3D "arm" and target_is_armv7(d):
+            arch =3D 'armv7'
+
+    rust_arch =3D oe.rust.arch_to_rust_arch(arch)
+
+    if abi:
+        arch_abi =3D "{}-{}".format(rust_arch, abi)
+    else:
+        arch_abi =3D rust_arch
+
+    features =3D features or d.getVarFlag('FEATURES', arch_abi) or ""
+    features =3D features.strip()
+
+    # build tspec
+    tspec =3D {}
+    tspec['llvm-target'] =3D rust_sys_to_llvm_target(rustsys)
+    tspec['data-layout'] =3D d.getVarFlag('DATA_LAYOUT', arch_abi)
+    if tspec['data-layout'] is None:
+        bb.fatal("No rust target defined for %s" % arch_abi)
+    tspec['max-atomic-width'] =3D int(d.getVarFlag('MAX_ATOMIC_WIDTH', =
arch_abi))
+    tspec['target-pointer-width'] =3D =
d.getVarFlag('TARGET_POINTER_WIDTH', arch_abi)
+    tspec['target-c-int-width'] =3D d.getVarFlag('TARGET_C_INT_WIDTH', =
arch_abi)
+    tspec['target-endian'] =3D d.getVarFlag('TARGET_ENDIAN', arch_abi)
+    tspec['arch'] =3D arch_to_rust_target_arch(rust_arch)
+    if "baremetal" in d.getVar('TCLIBC'):
+        tspec['os'] =3D "none"
+    else:
+        tspec['os'] =3D "linux"
+    if "musl" in tspec['llvm-target']:
+        tspec['env'] =3D "musl"
+    else:
+        tspec['env'] =3D "gnu"
+    if "riscv64" in tspec['llvm-target']:
+        tspec['llvm-abiname'] =3D "lp64d"
+    if "riscv32" in tspec['llvm-target']:
+        tspec['llvm-abiname'] =3D "ilp32d"
+    if "loongarch64" in tspec['llvm-target']:
+        tspec['llvm-abiname'] =3D "lp64d"
+    tspec['vendor'] =3D "unknown"
+    tspec['target-family'] =3D "unix"
+    tspec['linker'] =3D "{}{}gcc".format(d.getVar('CCACHE'), prefix)
+    tspec['cpu'] =3D cpu
+    if features !=3D "":
+        tspec['features'] =3D features
+    tspec['dynamic-linking'] =3D True
+    tspec['executables'] =3D True
+    tspec['linker-is-gnu'] =3D True
+    tspec['linker-flavor'] =3D "gcc"
+    tspec['has-rpath'] =3D True
+    tspec['position-independent-executables'] =3D True
+    tspec['panic-strategy'] =3D d.getVar("RUST_PANIC_STRATEGY")
+
+    # write out the target spec json file
+    with open(wd + rustsys + '.json', 'w') as f:
+        json.dump(tspec, f, indent=3D4)
+
+# These are accounted for in tmpdir path names so don't need to be in =
the task sig
+rust_gen_target[vardepsexclude] +=3D "ABIEXTENSION llvm_cpu"
+
+do_rust_gen_targets[vardeps] +=3D "DATA_LAYOUT TARGET_ENDIAN =
TARGET_POINTER_WIDTH TARGET_C_INT_WIDTH MAX_ATOMIC_WIDTH FEATURES"
+
+RUST_TARGETS_DIR =3D "${WORKDIR}/rust-targets/"
+export RUST_TARGET_PATH =3D "${RUST_TARGETS_DIR}"
+
+python do_rust_gen_targets () {
+    wd =3D d.getVar('RUST_TARGETS_DIR')
+    # Order of BUILD, HOST, TARGET is important in case the files =
overwrite, most specific last
+    rust_gen_target(d, 'BUILD', wd, d.getVar('BUILD_ARCH'))
+    rust_gen_target(d, 'HOST', wd, d.getVar('HOST_ARCH'))
+    rust_gen_target(d, 'TARGET', wd, d.getVar('TARGET_ARCH'))
+}
+
+addtask rust_gen_targets after do_patch before do_compile
+do_rust_gen_targets[dirs] +=3D "${RUST_TARGETS_DIR}"
+
+# For building target C dependecies use only compiler parameters =
defined in OE
+# and ignore the CC crate defaults which conflicts with OE ones in some =
cases.
+# =
https://github.com/rust-lang/cc-rs#external-configuration-via-environment-=
variables
+# Some CC crate compiler flags are still required.
+# We apply them conditionally in rust wrappers.
+
+CRATE_CC_FLAGS:class-native =3D ""
+CRATE_CC_FLAGS:class-nativesdk =3D ""
+CRATE_CC_FLAGS:class-target =3D " -ffunction-sections -fdata-sections =
-fPIC"
+
+do_compile:prepend:class-target() {
+    export CRATE_CC_NO_DEFAULTS=3D1
+}
+do_install:prepend:class-target() {
+    export CRATE_CC_NO_DEFAULTS=3D1
+}
diff --git a/classes-recipe/rust.bbclass b/classes-recipe/rust.bbclass
new file mode 100644
index 0000000..dae25ca
--- /dev/null
+++ b/classes-recipe/rust.bbclass
@@ -0,0 +1,51 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit rust-common
+
+RUSTC =3D "rustc"
+
+RUSTC_ARCHFLAGS +=3D "--target=3D${RUST_HOST_SYS} ${RUSTFLAGS}"
+
+def rust_base_dep(d):
+    # Taken from meta/classes/base.bbclass `base_dep_prepend` and =
modified to
+    # use rust instead of gcc
+    deps =3D ""
+    if not d.getVar('INHIBIT_DEFAULT_RUST_DEPS'):
+        if (d.getVar('HOST_SYS') !=3D d.getVar('BUILD_SYS')):
+            deps +=3D " rust-native ${RUSTLIB_DEP}"
+        else:
+            deps +=3D " rust-native"
+    return deps
+
+DEPENDS:append =3D " ${@rust_base_dep(d)}"
+
+# BUILD_LDFLAGS
+# 	${STAGING_LIBDIR_NATIVE}
+# 	${STAGING_BASE_LIBDIR_NATIVE}
+# BUILDSDK_LDFLAGS
+# 	${STAGING_LIBDIR}
+# 	#{STAGING_DIR_HOST}
+# TARGET_LDFLAGS ?????
+#RUSTC_BUILD_LDFLAGS =3D "\
+#	--sysroot ${STAGING_DIR_NATIVE} \
+#	-L${STAGING_LIBDIR_NATIVE}	\
+#	-L${STAGING_BASE_LIBDIR_NATIVE}	\
+#"
+
+# XXX: for some reason bitbake sets BUILD_* & TARGET_* but uses the =
bare
+# variables for HOST. Alias things to make it easier for us.
+HOST_LDFLAGS  ?=3D "${LDFLAGS}"
+HOST_CFLAGS   ?=3D "${CFLAGS}"
+HOST_CXXFLAGS ?=3D "${CXXFLAGS}"
+HOST_CPPFLAGS ?=3D "${CPPFLAGS}"
+
=
+rustlib_suffix=3D"${TUNE_ARCH}${TARGET_VENDOR}-${TARGET_OS}/rustlib/${RUS=
T_HOST_SYS}/lib"
+# Native sysroot standard library path
+rustlib_src=3D"${prefix}/lib/${rustlib_suffix}"
+# Host sysroot standard library path
+rustlib=3D"${libdir}/${rustlib_suffix}"
+rustlib:class-native=3D"${libdir}/rustlib/${BUILD_SYS}/lib"
diff --git a/conf/layer.conf b/conf/layer.conf
new file mode 100644
index 0000000..90c11d8
--- /dev/null
+++ b/conf/layer.conf
@@ -0,0 +1,29 @@
+# We have a conf and classes directory, but we have classes that should
+# override those in oe-core, so prepend to BBPATH
+BBPATH =3D. "${LAYERDIR}:"
+
+# We have a recipes directory, add to BBFILES
+BBFILES +=3D "${LAYERDIR}/recipes*/*/*.bb =
${LAYERDIR}/recipes*/*/*.bbappend"
+
+BBFILE_COLLECTIONS +=3D "lts-rust-mixin"
+BBFILE_PATTERN_lts-rust-mixin :=3D "^${LAYERDIR}/"
+BBFILE_PRIORITY_lts-rust-mixin =3D "6"
+
+LAYERSERIES_COMPAT_lts-rust-mixin =3D "scarthgap"
+
+LAYERDEPENDS_lts-rust-mixin =3D "core"
+
+RUSTVERSION ?=3D "1.80%"
+
+# This is not ideal, but it seems better to mask out the older oe-core
+# recipes completely since they will not work with this layer on top,
+# and several of them result in parse warnings.
+BBMASK:append =3D " meta/recipes-devtools/cargo/ =
meta/recipes-devtools/rust/"
+
+# These are in bitbake.conf in langdale and up, adding them here to =
make
+# using the layer more turn-key seems reasonable.
+BB_BASEHASH_IGNORE_VARS:append =3D " RUST_BUILD_SYS RUST_HOST_SYS =
RUST_TARGET_SYS"
+
+# Since we cannot overlay the lib/oe version easily, make sure our =
backport
+# of rust.py in lib/mixin is picked up.
+OE_EXTRA_IMPORTS:append =3D " mixin.rust"
diff --git a/lib/mixin/rust.py b/lib/mixin/rust.py
new file mode 100644
index 0000000..185553e
--- /dev/null
+++ b/lib/mixin/rust.py
@@ -0,0 +1,13 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+# Handle mismatches between `uname -m`-style output and Rust's arch =
names
+def arch_to_rust_arch(arch):
+    if arch =3D=3D "ppc64le":
+        return "powerpc64le"
+    if arch in ('riscv32', 'riscv64'):
+        return arch + 'gc'
+    return arch
diff --git a/meta/lib/oeqa/selftest/cases/rust.py =
b/meta/lib/oeqa/selftest/cases/rust.py
new file mode 100644
index 0000000..42e0258
--- /dev/null
+++ b/meta/lib/oeqa/selftest/cases/rust.py
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: MIT
+import subprocess
+import time
+from oeqa.core.decorator import OETestTag
+from oeqa.core.decorator.data import skipIfArch
+from oeqa.core.case import OEPTestResultTestCase
+from oeqa.selftest.case import OESelftestTestCase
+from oeqa.utils.commands import runCmd, bitbake, get_bb_var, runqemu
+from oeqa.utils.sshcontrol import SSHControl
+
+def parse_results(filename):
+    tests =3D {}
+    with open(filename, "r") as f:
+        lines =3D f.readlines()
+        for line in lines:
+            if "..." in line and "test [" in line:
+                test =3D line.split("test ")[1].split(" ... ")[0]
+                if "] " in test:
+                    test =3D test.split("] ", 1)[1]
+                result =3D line.split(" ... ")[1].strip()
+                if result =3D=3D "ok":
+                    result =3D "PASS"
+                elif result =3D=3D "failed":
+                    result =3D "FAIL"
+                elif "ignored" in result:
+                    result =3D "SKIPPED"
+                if test in tests:
+                    if tests[test] !=3D result:
+                        print("Duplicate and mismatching result %s for =
%s" % (result, test))
+                    else:
+                        print("Duplicate result %s for %s" % (result, =
test))
+                else:
+                    tests[test] =3D result
+    return tests
+
+# Total time taken for testing is of about 2hr 20min, with =
PARALLEL_MAKE set to 40 number of jobs.
+@OETestTag("toolchain-system")
+@OETestTag("toolchain-user")
+@OETestTag("runqemu")
+class RustSelfTestSystemEmulated(OESelftestTestCase, =
OEPTestResultTestCase):
+
+    @skipIfArch(['mips', 'mips64'])
+    def test_rust(self, *args, **kwargs):
+        # build remote-test-server before image build
+        recipe =3D "rust"
+        start_time =3D time.time()
+        bitbake("{} -c test_compile".format(recipe))
+        builddir =3D get_bb_var("RUSTSRC", "rust")
+        # build core-image-minimal with required packages
+        default_installed_packages =3D ["libgcc", "libstdc++", =
"libatomic", "libgomp"]
+        features =3D []
+        features.append('IMAGE_FEATURES +=3D "ssh-server-dropbear"')
+        features.append('CORE_IMAGE_EXTRA_INSTALL +=3D "{0}"'.format(" =
".join(default_installed_packages)))
+        self.write_config("\n".join(features))
+        bitbake("core-image-minimal")
+
+        # Exclude the test folders that error out while building
+        # TODO: Fix the errors and include them for testing
+        # no-fail-fast: Run all tests regardless of failure.
+        # bless: First runs rustfmt to format the codebase,
+        # then runs tidy checks.
+        exclude_list =3D  [
+                            'src/bootstrap',
+                            'src/doc/rustc',
+                            'src/doc/rustdoc',
+                            'src/doc/unstable-book',
+                            'src/librustdoc',
+                            'src/rustdoc-json-types',
+                            'src/tools/jsondoclint',
+                            'src/tools/lint-docs',
+                            'src/tools/replace-version-placeholder',
+                            'src/tools/rust-analyzer',
+                            'src/tools/rustdoc-themes',
+                            'src/tools/rust-installer',
+                            'src/tools/suggest-tests',
+                            =
'tests/assembly/asm/aarch64-outline-atomics.rs',
+                            'tests/codegen/issues/issue-122805.rs',
+                            'tests/codegen/thread-local.rs',
+                            'tests/mir-opt/',
+                            'tests/run-make',
+                            'tests/run-make-fulldeps',
+                            'tests/rustdoc',
+                            'tests/rustdoc-json',
+                            'tests/rustdoc-js-std',
+                            'tests/ui/abi/stack-probes-lto.rs',
+                            'tests/ui/abi/stack-probes.rs',
+                            =
'tests/ui/codegen/mismatched-data-layouts.rs',
+                            =
'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and-split-debuginfo.rs',
+                            'tests/ui-fulldeps/',
+                            'tests/ui/process/nofile-limit.rs',
+                            'tidyselftest'
+                        ]
+
+        exclude_fail_tests =3D " ".join([" --exclude " + item for item =
in exclude_list])
+        # Add exclude_fail_tests with other test arguments
+        testargs =3D  exclude_fail_tests + " --no-fail-fast --bless"
+
+        # wrap the execution with a qemu instance.
+        # Tests are run with 512 tasks in parallel to execute all tests =
very quickly
+        with runqemu("core-image-minimal", runqemuparams =3D =
"nographic", qemuparams =3D "-m 512") as qemu:
+            # Copy remote-test-server to image through scp
+            host_sys =3D get_bb_var("RUST_BUILD_SYS", "rust")
+            ssh =3D SSHControl(ip=3Dqemu.ip, logfile=3Dqemu.sshlog, =
user=3D"root")
+            ssh.copy_to(builddir + "/build/" + host_sys + =
"/stage1-tools-bin/remote-test-server","~/")
+            # Execute remote-test-server on image through background =
ssh
+            command =3D '~/remote-test-server --bind 0.0.0.0:12345 -v'
+            sshrun=3Dsubprocess.Popen(("ssh", '-o',  =
'UserKnownHostsFile=3D/dev/null', '-o',  'StrictHostKeyChecking=3Dno', =
'-f', "root@%s" % qemu.ip, command), shell=3DFalse, =
stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.PIPE)
+            # Get the values of variables.
+            tcpath =3D get_bb_var("TARGET_SYS", "rust")
+            targetsys =3D get_bb_var("RUST_TARGET_SYS", "rust")
+            rustlibpath =3D get_bb_var("WORKDIR", "rust")
+            tmpdir =3D get_bb_var("TMPDIR", "rust")
+
+            # Set path for target-poky-linux-gcc, RUST_TARGET_PATH and =
hosttools.
+            cmd =3D "export TARGET_VENDOR=3D\"-poky\";"
+            cmd =3D cmd + " export =
PATH=3D%s/recipe-sysroot-native/usr/bin/python3-native:%s/recipe-sysroot-n=
ative/usr/bin:%s/recipe-sysroot-native/usr/bin/%s:%s/hosttools:$PATH;" % =
(rustlibpath, rustlibpath, rustlibpath, tcpath, tmpdir)
+            cmd =3D cmd + " export RUST_TARGET_PATH=3D%s/rust-targets;" =
% rustlibpath
+            # Trigger testing.
+            cmd =3D cmd + " export TEST_DEVICE_ADDR=3D\"%s:12345\";" % =
qemu.ip
+            cmd =3D cmd + " cd %s; python3 src/bootstrap/bootstrap.py =
test %s --target %s" % (builddir, testargs, targetsys)
+            retval =3D runCmd(cmd)
+            end_time =3D time.time()
+
+            resultlog =3D rustlibpath + "/results-log.txt"
+            with open(resultlog, "w") as f:
+                f.write(retval.output)
+
+            ptestsuite =3D "rust"
+            self.ptest_section(ptestsuite, duration =3D int(end_time - =
start_time), logfile=3Dresultlog)
+            test_results =3D parse_results(resultlog)
+            for test in test_results:
+                self.ptest_result(ptestsuite, test, test_results[test])
diff --git =
a/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb =
b/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
new file mode 100644
index 0000000..bb10a2d
--- /dev/null
+++ b/recipes-core/packagegroups/packagegroup-rust-cross-canadian.bb
@@ -0,0 +1,21 @@
+SUMMARY =3D "Host SDK package for Rust cross canadian toolchain"
+PN =3D "packagegroup-rust-cross-canadian-${MACHINE}"
+
+inherit cross-canadian packagegroup
+
+PACKAGEGROUP_DISABLE_COMPLEMENTARY =3D "1"
+
+RUST=3D"rust-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+
+RDEPENDS:${PN} =3D " \
+    ${@all_multilib_tune_values(d, 'RUST')} \
+    nativesdk-binutils \
+    nativesdk-gcc \
+    nativesdk-glibc-dev \
+    nativesdk-libgcc-dev \
+    nativesdk-rust \
+    nativesdk-cargo \
+    nativesdk-rust-tools-clippy \
+    nativesdk-rust-tools-rustfmt \
+"
+
diff --git a/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb =
b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
new file mode 100644
index 0000000..59874c4
--- /dev/null
+++ b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
@@ -0,0 +1,14 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+SUMMARY =3D "Target packages for the Rust SDK"
+
+inherit packagegroup
+
+RDEPENDS:${PN} =3D " \
+    rust \
+    cargo \
+"
diff --git a/recipes-devtools/rust/README-rust.md =
b/recipes-devtools/rust/README-rust.md
new file mode 100644
index 0000000..209836a
--- /dev/null
+++ b/recipes-devtools/rust/README-rust.md
@@ -0,0 +1,38 @@
+## Introduction
+
+This provides the Rust compiler, tools for building packages (cargo), =
and=20
+a few example projects.
+
+## Building a rust package
+
+When building a rust package in bitbake, it's usually easiest to build =
with
+cargo using cargo.bbclass.  If the package already has a Cargo.toml =
file (most
+rust packages do), then it's especially easy.  Otherwise you should =
probably
+get the code building in cargo first.=20
+
+Once your package builds in cargo, you can use
+[cargo-bitbake](https://github.com/cardoe/cargo-bitbake) to generate a =
bitbake
+recipe for it.  This allows bitbake to fetch all the necessary =
dependent
+crates, as well as a pegged version of the crates.io index, to ensure =
maximum
+reproducibility. Once the Rust SDK support is added to oe-core, =
cargo-bitbake
+may also be added to the SDK.
+
+NOTE: You will have to edit the generated recipe based on the comments
+contained within it
+
+## Pitfalls
+
+ - TARGET_SYS _must_ be different from BUILD_SYS. This is due to the =
way Rust
+ configuration options are tracked for different targets. This is the =
reason=20
+ we use the Yocto triples instead of the native Rust triples. See =
rust-lang/cargo#3349.
+
+## Dependencies
+
+On the host:
+ - Any `-sys` packages your project might need must have RDEPENDs for
+ the native library.
+
+On the target:
+ - Any `-sys` packages your project might need must have RDEPENDs for
+ the native library.
+
diff --git a/recipes-devtools/rust/cargo-c-crates.inc =
b/recipes-devtools/rust/cargo-c-crates.inc
new file mode 100644
index 0000000..2c84c32
--- /dev/null
+++ b/recipes-devtools/rust/cargo-c-crates.inc
@@ -0,0 +1,676 @@
+# Autogenerated with 'bitbake -c update_crates cargo-c-native'
+
+# from Cargo.lock
+SRC_URI +=3D " \
+    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/ahash/0.8.11 \
+    crate://crates.io/aho-corasick/1.1.3 \
+    crate://crates.io/allocator-api2/0.2.18 \
+    crate://crates.io/annotate-snippets/0.11.4 \
+    crate://crates.io/anstream/0.6.15 \
+    crate://crates.io/anstyle/1.0.8 \
+    crate://crates.io/anstyle-parse/0.2.5 \
+    crate://crates.io/anstyle-query/1.1.1 \
+    crate://crates.io/anstyle-wincon/3.0.4 \
+    crate://crates.io/anyhow/1.0.86 \
+    crate://crates.io/arc-swap/1.7.1 \
+    crate://crates.io/autocfg/1.3.0 \
+    crate://crates.io/base16ct/0.2.0 \
+    crate://crates.io/base64/0.22.1 \
+    crate://crates.io/base64ct/1.6.0 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bitflags/2.6.0 \
+    crate://crates.io/bitmaps/2.1.0 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/bstr/1.10.0 \
+    crate://crates.io/bumpalo/3.16.0 \
+    crate://crates.io/byteorder/1.5.0 \
+    crate://crates.io/bytes/1.6.1 \
+    crate://crates.io/bytesize/1.3.0 \
+    crate://crates.io/cargo/0.81.0 \
+    crate://crates.io/cargo-credential/0.4.6 \
+    crate://crates.io/cargo-credential-libsecret/0.4.6 \
+    crate://crates.io/cargo-credential-macos-keychain/0.4.6 \
+    crate://crates.io/cargo-credential-wincred/0.4.6 \
+    crate://crates.io/cargo-platform/0.1.8 \
+    crate://crates.io/cargo-util/0.2.13 \
+    crate://crates.io/cargo-util-schemas/0.4.0 \
+    crate://crates.io/cbindgen/0.26.0 \
+    crate://crates.io/cc/1.1.7 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/clap/4.5.11 \
+    crate://crates.io/clap_builder/4.5.11 \
+    crate://crates.io/clap_derive/4.5.11 \
+    crate://crates.io/clap_lex/0.7.2 \
+    crate://crates.io/clru/0.6.2 \
+    crate://crates.io/color-print/0.3.6 \
+    crate://crates.io/color-print-proc-macro/0.3.6 \
+    crate://crates.io/colorchoice/1.0.2 \
+    crate://crates.io/const-oid/0.9.6 \
+    crate://crates.io/core-foundation/0.9.4 \
+    crate://crates.io/core-foundation-sys/0.8.6 \
+    crate://crates.io/cpufeatures/0.2.12 \
+    crate://crates.io/crates-io/0.40.3 \
+    crate://crates.io/crc32fast/1.4.2 \
+    crate://crates.io/crossbeam-channel/0.5.13 \
+    crate://crates.io/crossbeam-deque/0.8.5 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-utils/0.8.20 \
+    crate://crates.io/crypto-bigint/0.5.5 \
+    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/ct-codecs/1.1.1 \
+    crate://crates.io/curl/0.4.46 \
+    crate://crates.io/curl-sys/0.4.73+curl-8.8.0 \
+    crate://crates.io/dbus/0.9.7 \
+    crate://crates.io/der/0.7.9 \
+    crate://crates.io/deranged/0.3.11 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/dunce/1.0.4 \
+    crate://crates.io/ecdsa/0.16.9 \
+    crate://crates.io/ed25519-compact/2.1.1 \
+    crate://crates.io/either/1.13.0 \
+    crate://crates.io/elliptic-curve/0.13.8 \
+    crate://crates.io/encoding_rs/0.8.34 \
+    crate://crates.io/equivalent/1.0.1 \
+    crate://crates.io/erased-serde/0.4.5 \
+    crate://crates.io/errno/0.3.9 \
+    crate://crates.io/fallible-iterator/0.3.0 \
+    crate://crates.io/fallible-streaming-iterator/0.1.9 \
+    crate://crates.io/faster-hex/0.9.0 \
+    crate://crates.io/fastrand/2.1.0 \
+    crate://crates.io/ff/0.13.0 \
+    crate://crates.io/fiat-crypto/0.2.9 \
+    crate://crates.io/filetime/0.2.23 \
+    crate://crates.io/flate2/1.0.30 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/foreign-types/0.3.2 \
+    crate://crates.io/foreign-types-shared/0.1.1 \
+    crate://crates.io/form_urlencoded/1.2.1 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/getrandom/0.2.15 \
+    crate://crates.io/git2/0.18.3 \
+    crate://crates.io/git2-curl/0.19.0 \
+    crate://crates.io/gix/0.63.0 \
+    crate://crates.io/gix-actor/0.31.5 \
+    crate://crates.io/gix-attributes/0.22.3 \
+    crate://crates.io/gix-bitmap/0.2.11 \
+    crate://crates.io/gix-chunk/0.4.8 \
+    crate://crates.io/gix-command/0.3.8 \
+    crate://crates.io/gix-commitgraph/0.24.3 \
+    crate://crates.io/gix-config/0.37.0 \
+    crate://crates.io/gix-config-value/0.14.7 \
+    crate://crates.io/gix-credentials/0.24.4 \
+    crate://crates.io/gix-date/0.8.7 \
+    crate://crates.io/gix-diff/0.44.1 \
+    crate://crates.io/gix-dir/0.5.0 \
+    crate://crates.io/gix-discover/0.32.0 \
+    crate://crates.io/gix-features/0.38.2 \
+    crate://crates.io/gix-filter/0.11.3 \
+    crate://crates.io/gix-fs/0.11.2 \
+    crate://crates.io/gix-glob/0.16.4 \
+    crate://crates.io/gix-hash/0.14.2 \
+    crate://crates.io/gix-hashtable/0.5.2 \
+    crate://crates.io/gix-ignore/0.11.3 \
+    crate://crates.io/gix-index/0.33.1 \
+    crate://crates.io/gix-lock/14.0.0 \
+    crate://crates.io/gix-macros/0.1.5 \
+    crate://crates.io/gix-negotiate/0.13.2 \
+    crate://crates.io/gix-object/0.42.3 \
+    crate://crates.io/gix-odb/0.61.1 \
+    crate://crates.io/gix-pack/0.51.1 \
+    crate://crates.io/gix-packetline/0.17.5 \
+    crate://crates.io/gix-packetline-blocking/0.17.4 \
+    crate://crates.io/gix-path/0.10.9 \
+    crate://crates.io/gix-pathspec/0.7.6 \
+    crate://crates.io/gix-prompt/0.8.6 \
+    crate://crates.io/gix-protocol/0.45.2 \
+    crate://crates.io/gix-quote/0.4.12 \
+    crate://crates.io/gix-ref/0.44.1 \
+    crate://crates.io/gix-refspec/0.23.1 \
+    crate://crates.io/gix-revision/0.27.2 \
+    crate://crates.io/gix-revwalk/0.13.2 \
+    crate://crates.io/gix-sec/0.10.7 \
+    crate://crates.io/gix-submodule/0.11.0 \
+    crate://crates.io/gix-tempfile/14.0.1 \
+    crate://crates.io/gix-trace/0.1.9 \
+    crate://crates.io/gix-transport/0.42.2 \
+    crate://crates.io/gix-traverse/0.39.2 \
+    crate://crates.io/gix-url/0.27.4 \
+    crate://crates.io/gix-utils/0.1.12 \
+    crate://crates.io/gix-validate/0.8.5 \
+    crate://crates.io/gix-worktree/0.34.1 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/globset/0.4.14 \
+    crate://crates.io/group/0.13.0 \
+    crate://crates.io/hashbrown/0.12.3 \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/hashlink/0.9.1 \
+    crate://crates.io/heck/0.4.1 \
+    crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hex/0.4.3 \
+    crate://crates.io/hkdf/0.12.4 \
+    crate://crates.io/hmac/0.12.1 \
+    crate://crates.io/home/0.5.9 \
+    crate://crates.io/http-auth/0.1.9 \
+    crate://crates.io/humantime/2.1.0 \
+    crate://crates.io/idna/0.5.0 \
+    crate://crates.io/ignore/0.4.22 \
+    crate://crates.io/im-rc/15.1.0 \
+    crate://crates.io/indexmap/1.9.3 \
+    crate://crates.io/indexmap/2.2.6 \
+    crate://crates.io/is_terminal_polyfill/1.70.1 \
+    crate://crates.io/itertools/0.12.1 \
+    crate://crates.io/itertools/0.13.0 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/jobserver/0.1.32 \
+    crate://crates.io/js-sys/0.3.69 \
+    crate://crates.io/kstring/2.0.2 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/lazycell/1.3.0 \
+    crate://crates.io/libc/0.2.155 \
+    crate://crates.io/libdbus-sys/0.2.5 \
+    crate://crates.io/libgit2-sys/0.16.2+1.7.2 \
+    crate://crates.io/libloading/0.8.5 \
+    crate://crates.io/libnghttp2-sys/0.1.10+1.61.0 \
+    crate://crates.io/libsqlite3-sys/0.28.0 \
+    crate://crates.io/libssh2-sys/0.3.0 \
+    crate://crates.io/libz-sys/1.1.18 \
+    crate://crates.io/linux-raw-sys/0.4.14 \
+    crate://crates.io/lock_api/0.4.12 \
+    crate://crates.io/log/0.4.22 \
+    crate://crates.io/matchers/0.1.0 \
+    crate://crates.io/maybe-async/0.2.10 \
+    crate://crates.io/memchr/2.7.4 \
+    crate://crates.io/memmap2/0.9.4 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/miniz_oxide/0.7.4 \
+    crate://crates.io/miow/0.6.0 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/normpath/1.2.0 \
+    crate://crates.io/nu-ansi-term/0.46.0 \
+    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/num_threads/0.1.7 \
+    crate://crates.io/once_cell/1.19.0 \
+    crate://crates.io/opener/0.7.1 \
+    crate://crates.io/openssl/0.10.66 \
+    crate://crates.io/openssl-macros/0.1.1 \
+    crate://crates.io/openssl-probe/0.1.5 \
+    crate://crates.io/openssl-src/300.3.1+3.3.1 \
+    crate://crates.io/openssl-sys/0.9.103 \
+    crate://crates.io/ordered-float/2.10.1 \
+    crate://crates.io/orion/0.17.6 \
+    crate://crates.io/os_info/3.8.2 \
+    crate://crates.io/overload/0.1.1 \
+    crate://crates.io/p384/0.13.0 \
+    crate://crates.io/parking_lot/0.12.3 \
+    crate://crates.io/parking_lot_core/0.9.10 \
+    crate://crates.io/pasetors/0.6.8 \
+    crate://crates.io/pathdiff/0.2.1 \
+    crate://crates.io/pem-rfc7468/0.7.0 \
+    crate://crates.io/percent-encoding/2.3.1 \
+    crate://crates.io/pin-project-lite/0.2.14 \
+    crate://crates.io/pkcs8/0.10.2 \
+    crate://crates.io/pkg-config/0.3.30 \
+    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/ppv-lite86/0.2.18 \
+    crate://crates.io/primeorder/0.13.6 \
+    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/prodash/28.0.0 \
+    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/rand_xoshiro/0.6.0 \
+    crate://crates.io/redox_syscall/0.4.1 \
+    crate://crates.io/redox_syscall/0.5.3 \
+    crate://crates.io/regex/1.10.5 \
+    crate://crates.io/regex-automata/0.1.10 \
+    crate://crates.io/regex-automata/0.4.7 \
+    crate://crates.io/regex-syntax/0.6.29 \
+    crate://crates.io/regex-syntax/0.8.4 \
+    crate://crates.io/rfc6979/0.4.0 \
+    crate://crates.io/rusqlite/0.31.0 \
+    crate://crates.io/rustfix/0.8.4 \
+    crate://crates.io/rustix/0.38.34 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/schannel/0.1.23 \
+    crate://crates.io/scopeguard/1.2.0 \
+    crate://crates.io/sec1/0.7.3 \
+    crate://crates.io/security-framework/2.11.1 \
+    crate://crates.io/security-framework-sys/2.11.1 \
+    crate://crates.io/semver/1.0.23 \
+    crate://crates.io/serde/1.0.204 \
+    crate://crates.io/serde-untagged/0.1.6 \
+    crate://crates.io/serde-value/0.7.0 \
+    crate://crates.io/serde_derive/1.0.204 \
+    crate://crates.io/serde_ignored/0.1.10 \
+    crate://crates.io/serde_json/1.0.121 \
+    crate://crates.io/serde_spanned/0.6.7 \
+    crate://crates.io/sha1/0.10.6 \
+    crate://crates.io/sha1_smol/1.0.1 \
+    crate://crates.io/sha2/0.10.8 \
+    crate://crates.io/sharded-slab/0.1.7 \
+    crate://crates.io/shell-escape/0.1.5 \
+    crate://crates.io/shell-words/1.1.0 \
+    crate://crates.io/signature/2.2.0 \
+    crate://crates.io/sized-chunks/0.6.5 \
+    crate://crates.io/smallvec/1.13.2 \
+    crate://crates.io/socket2/0.5.7 \
+    crate://crates.io/spki/0.7.3 \
+    crate://crates.io/static_assertions/1.1.0 \
+    crate://crates.io/strsim/0.11.1 \
+    crate://crates.io/subtle/2.6.1 \
+    crate://crates.io/supports-hyperlinks/3.0.0 \
+    crate://crates.io/supports-unicode/3.0.0 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.72 \
+    crate://crates.io/tar/0.4.41 \
+    crate://crates.io/tempfile/3.10.1 \
+    crate://crates.io/terminal_size/0.3.0 \
+    crate://crates.io/thiserror/1.0.63 \
+    crate://crates.io/thiserror-impl/1.0.63 \
+    crate://crates.io/thread_local/1.1.8 \
+    crate://crates.io/time/0.3.36 \
+    crate://crates.io/time-core/0.1.2 \
+    crate://crates.io/time-macros/0.2.18 \
+    crate://crates.io/tinyvec/1.8.0 \
+    crate://crates.io/tinyvec_macros/0.1.1 \
+    crate://crates.io/toml/0.5.11 \
+    crate://crates.io/toml/0.8.16 \
+    crate://crates.io/toml_datetime/0.6.7 \
+    crate://crates.io/toml_edit/0.22.17 \
+    crate://crates.io/tracing/0.1.40 \
+    crate://crates.io/tracing-attributes/0.1.27 \
+    crate://crates.io/tracing-chrome/0.7.2 \
+    crate://crates.io/tracing-core/0.1.32 \
+    crate://crates.io/tracing-log/0.2.0 \
+    crate://crates.io/tracing-subscriber/0.3.18 \
+    crate://crates.io/typeid/1.0.0 \
+    crate://crates.io/typenum/1.17.0 \
+    crate://crates.io/unicase/2.7.0 \
+    crate://crates.io/unicode-bidi/0.3.15 \
+    crate://crates.io/unicode-bom/2.0.3 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/unicode-normalization/0.1.23 \
+    crate://crates.io/unicode-width/0.1.13 \
+    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/url/2.5.2 \
+    crate://crates.io/utf8parse/0.2.2 \
+    crate://crates.io/valuable/0.1.0 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/version_check/0.9.5 \
+    crate://crates.io/walkdir/2.5.0 \
+    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/wasm-bindgen/0.2.92 \
+    crate://crates.io/wasm-bindgen-backend/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
+    crate://crates.io/wasm-bindgen-shared/0.2.92 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.8 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-sys/0.48.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.48.5 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.48.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.48.5 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.48.5 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.48.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.48.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/0.6.16 \
+    crate://crates.io/zerocopy/0.6.6 \
+    crate://crates.io/zerocopy/0.7.35 \
+    crate://crates.io/zerocopy-derive/0.6.6 \
+    crate://crates.io/zerocopy-derive/0.7.35 \
+    crate://crates.io/zeroize/1.8.1 \
+"
+
+SRC_URI[adler-1.0.2.sha256sum] =3D =
"f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[ahash-0.8.11.sha256sum] =3D =
"e89da841a80418a9b391ebaea17f5c112ffaaa96f621d2c285b5174da76b9011"
+SRC_URI[aho-corasick-1.1.3.sha256sum] =3D =
"8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
+SRC_URI[allocator-api2-0.2.18.sha256sum] =3D =
"5c6cb57a04249c6480766f7f7cef5467412af1490f8d1e243141daddada3264f"
+SRC_URI[annotate-snippets-0.11.4.sha256sum] =3D =
"24e35ed54e5ea7997c14ed4c70ba043478db1112e98263b3b035907aa197d991"
+SRC_URI[anstream-0.6.15.sha256sum] =3D =
"64e15c1ab1f89faffbf04a634d5e1962e9074f2741eef6d97f3c4e322426d526"
+SRC_URI[anstyle-1.0.8.sha256sum] =3D =
"1bec1de6f59aedf83baf9ff929c98f2ad654b97c9510f4e70cf6f661d49fd5b1"
+SRC_URI[anstyle-parse-0.2.5.sha256sum] =3D =
"eb47de1e80c2b463c735db5b217a0ddc39d612e7ac9e2e96a5aed1f57616c1cb"
+SRC_URI[anstyle-query-1.1.1.sha256sum] =3D =
"6d36fc52c7f6c869915e99412912f22093507da8d9e942ceaf66fe4b7c14422a"
+SRC_URI[anstyle-wincon-3.0.4.sha256sum] =3D =
"5bf74e1b6e971609db8ca7a9ce79fd5768ab6ae46441c572e46cf596f59e57f8"
+SRC_URI[anyhow-1.0.86.sha256sum] =3D =
"b3d1d046238990b9cf5bcde22a3fb3584ee5cf65fb2765f454ed428c7a0063da"
+SRC_URI[arc-swap-1.7.1.sha256sum] =3D =
"69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
+SRC_URI[autocfg-1.3.0.sha256sum] =3D =
"0c4b4d0bd25bd0b74681c0ad21497610ce1b7c91b1022cd21c80c6fbdd9476b0"
+SRC_URI[base16ct-0.2.0.sha256sum] =3D =
"4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
+SRC_URI[base64-0.22.1.sha256sum] =3D =
"72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
+SRC_URI[base64ct-1.6.0.sha256sum] =3D =
"8c3c1a368f70d6cf7302d78f8f7093da241fb8e8807c05cc9e51a125895a6d5b"
+SRC_URI[bitflags-1.3.2.sha256sum] =3D =
"bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bitflags-2.6.0.sha256sum] =3D =
"b048fb63fd8b5923fc5aa7b340d8e156aec7ec02f0c78fa8a6ddc2613f6f71de"
+SRC_URI[bitmaps-2.1.0.sha256sum] =3D =
"031043d04099746d8db04daf1fa424b2bc8bd69d92b25962dcde24da39ab64a2"
+SRC_URI[block-buffer-0.10.4.sha256sum] =3D =
"3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[bstr-1.10.0.sha256sum] =3D =
"40723b8fb387abc38f4f4a37c09073622e41dd12327033091ef8950659e6dc0c"
+SRC_URI[bumpalo-3.16.0.sha256sum] =3D =
"79296716171880943b8470b5f8d03aa55eb2e645a4874bdbb28adb49162e012c"
+SRC_URI[byteorder-1.5.0.sha256sum] =3D =
"1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
+SRC_URI[bytes-1.6.1.sha256sum] =3D =
"a12916984aab3fa6e39d655a33e09c0071eb36d6ab3aea5c2d78551f1df6d952"
+SRC_URI[bytesize-1.3.0.sha256sum] =3D =
"a3e368af43e418a04d52505cf3dbc23dda4e3407ae2fa99fd0e4f308ce546acc"
+SRC_URI[cargo-0.81.0.sha256sum] =3D =
"f24c9dcadcdad2f6fa2553b63d5e9c9700fa6932b75d53f3b11b8aea35ebab99"
+SRC_URI[cargo-credential-0.4.6.sha256sum] =3D =
"3a3e7c625670eacbefd48f552588c491eccc79a85a96898af13af7b312d1c4cd"
+SRC_URI[cargo-credential-libsecret-0.4.6.sha256sum] =3D =
"7133c8156697989e0d3547f886083bdcb4d7463be67699c37c206152e46925b0"
+SRC_URI[cargo-credential-macos-keychain-0.4.6.sha256sum] =3D =
"5e238786dd6bc99a94a99a108a0fedcc7e786a86c81b8e9857da88ca3caac3d0"
+SRC_URI[cargo-credential-wincred-0.4.6.sha256sum] =3D =
"cc0e24a553bb387e22fd5a18f49b72f15db22426b5a0cd37c5fc804978f5ce13"
+SRC_URI[cargo-platform-0.1.8.sha256sum] =3D =
"24b1f0365a6c6bb4020cd05806fd0d33c44d38046b8bd7f0e40814b9763cabfc"
+SRC_URI[cargo-util-0.2.13.sha256sum] =3D =
"14104698cb1694d43c2ff73492468ccf2bb0b047071a9838d999eeba9e984ffa"
+SRC_URI[cargo-util-schemas-0.4.0.sha256sum] =3D =
"34ddc7fc157e3dbbd88f05ef8be7c3ed3ecb05925a3f51f716d6103a607fb7c4"
+SRC_URI[cbindgen-0.26.0.sha256sum] =3D =
"da6bc11b07529f16944307272d5bd9b22530bc7d05751717c9d416586cedab49"
+SRC_URI[cc-1.1.7.sha256sum] =3D =
"26a5c3fd7bfa1ce3897a3a3501d362b2d87b7f2583ebcb4a949ec25911025cbc"
+SRC_URI[cfg-if-1.0.0.sha256sum] =3D =
"baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[clap-4.5.11.sha256sum] =3D =
"35723e6a11662c2afb578bcf0b88bf6ea8e21282a953428f240574fcc3a2b5b3"
+SRC_URI[clap_builder-4.5.11.sha256sum] =3D =
"49eb96cbfa7cfa35017b7cd548c75b14c3118c98b423041d70562665e07fb0fa"
+SRC_URI[clap_derive-4.5.11.sha256sum] =3D =
"5d029b67f89d30bbb547c89fd5161293c0aec155fc691d7924b64550662db93e"
+SRC_URI[clap_lex-0.7.2.sha256sum] =3D =
"1462739cb27611015575c0c11df5df7601141071f07518d56fcc1be504cbec97"
+SRC_URI[clru-0.6.2.sha256sum] =3D =
"cbd0f76e066e64fdc5631e3bb46381254deab9ef1158292f27c8c57e3bf3fe59"
+SRC_URI[color-print-0.3.6.sha256sum] =3D =
"1ee543c60ff3888934877a5671f45494dd27ed4ba25c6670b9a7576b7ed7a8c0"
+SRC_URI[color-print-proc-macro-0.3.6.sha256sum] =3D =
"77ff1a80c5f3cb1ca7c06ffdd71b6a6dd6d8f896c42141fbd43f50ed28dcdb93"
+SRC_URI[colorchoice-1.0.2.sha256sum] =3D =
"d3fd119d74b830634cea2a0f58bbd0d54540518a14397557951e79340abc28c0"
+SRC_URI[const-oid-0.9.6.sha256sum] =3D =
"c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
+SRC_URI[core-foundation-0.9.4.sha256sum] =3D =
"91e195e091a93c46f7102ec7818a2aa394e1e1771c3ab4825963fa03e45afb8f"
+SRC_URI[core-foundation-sys-0.8.6.sha256sum] =3D =
"06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
+SRC_URI[cpufeatures-0.2.12.sha256sum] =3D =
"53fe5e26ff1b7aef8bca9c6080520cfb8d9333c7568e1829cef191a9723e5504"
+SRC_URI[crates-io-0.40.3.sha256sum] =3D =
"3b7837d3d2ea5d21a399489029609840d95608bfdf1dc5fd8604392df4b219b3"
+SRC_URI[crc32fast-1.4.2.sha256sum] =3D =
"a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
+SRC_URI[crossbeam-channel-0.5.13.sha256sum] =3D =
"33480d6946193aa8033910124896ca395333cae7e2d1113d1fef6c3272217df2"
+SRC_URI[crossbeam-deque-0.8.5.sha256sum] =3D =
"613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] =3D =
"5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-utils-0.8.20.sha256sum] =3D =
"22ec99545bb0ed0ea7bb9b8e1e9122ea386ff8a48c0922e43f36d45ab09e0e80"
+SRC_URI[crypto-bigint-0.5.5.sha256sum] =3D =
"0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
+SRC_URI[crypto-common-0.1.6.sha256sum] =3D =
"1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
+SRC_URI[ct-codecs-1.1.1.sha256sum] =3D =
"f3b7eb4404b8195a9abb6356f4ac07d8ba267045c8d6d220ac4dc992e6cc75df"
+SRC_URI[curl-0.4.46.sha256sum] =3D =
"1e2161dd6eba090ff1594084e95fd67aeccf04382ffea77999ea94ed42ec67b6"
+SRC_URI[curl-sys-0.4.73+curl-8.8.0.sha256sum] =3D =
"450ab250ecf17227c39afb9a2dd9261dc0035cb80f2612472fc0c4aac2dcb84d"
+SRC_URI[dbus-0.9.7.sha256sum] =3D =
"1bb21987b9fb1613058ba3843121dd18b163b254d8a6e797e144cbac14d96d1b"
+SRC_URI[der-0.7.9.sha256sum] =3D =
"f55bf8e7b65898637379c1b74eb1551107c8294ed26d855ceb9fd1a09cfc9bc0"
+SRC_URI[deranged-0.3.11.sha256sum] =3D =
"b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
+SRC_URI[digest-0.10.7.sha256sum] =3D =
"9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
+SRC_URI[dunce-1.0.4.sha256sum] =3D =
"56ce8c6da7551ec6c462cbaf3bfbc75131ebbfa1c944aeaa9dab51ca1c5f0c3b"
+SRC_URI[ecdsa-0.16.9.sha256sum] =3D =
"ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
+SRC_URI[ed25519-compact-2.1.1.sha256sum] =3D =
"e9b3460f44bea8cd47f45a0c70892f1eff856d97cd55358b2f73f663789f6190"
+SRC_URI[either-1.13.0.sha256sum] =3D =
"60b1af1c220855b6ceac025d3f6ecdd2b7c4894bfe9cd9bda4fbb4bc7c0d4cf0"
+SRC_URI[elliptic-curve-0.13.8.sha256sum] =3D =
"b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
+SRC_URI[encoding_rs-0.8.34.sha256sum] =3D =
"b45de904aa0b010bce2ab45264d0631681847fa7b6f2eaa7dab7619943bc4f59"
+SRC_URI[equivalent-1.0.1.sha256sum] =3D =
"5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
+SRC_URI[erased-serde-0.4.5.sha256sum] =3D =
"24e2389d65ab4fab27dc2a5de7b191e1f6617d1f1c8855c0dc569c94a4cbb18d"
+SRC_URI[errno-0.3.9.sha256sum] =3D =
"534c5cf6194dfab3db3242765c03bbe257cf92f22b38f6bc0c58d59108a820ba"
+SRC_URI[fallible-iterator-0.3.0.sha256sum] =3D =
"2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
+SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] =3D =
"7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
+SRC_URI[faster-hex-0.9.0.sha256sum] =3D =
"a2a2b11eda1d40935b26cf18f6833c526845ae8c41e58d09af6adeb6f0269183"
+SRC_URI[fastrand-2.1.0.sha256sum] =3D =
"9fc0510504f03c51ada170672ac806f1f105a88aa97a5281117e1ddc3368e51a"
+SRC_URI[ff-0.13.0.sha256sum] =3D =
"ded41244b729663b1e574f1b4fb731469f69f79c17667b5d776b16cda0479449"
+SRC_URI[fiat-crypto-0.2.9.sha256sum] =3D =
"28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
+SRC_URI[filetime-0.2.23.sha256sum] =3D =
"1ee447700ac8aa0b2f2bd7bc4462ad686ba06baa6727ac149a2d6277f0d240fd"
+SRC_URI[flate2-1.0.30.sha256sum] =3D =
"5f54427cfd1c7829e2a139fcefea601bf088ebca651d2bf53ebc600eac295dae"
+SRC_URI[fnv-1.0.7.sha256sum] =3D =
"3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[foreign-types-0.3.2.sha256sum] =3D =
"f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
+SRC_URI[foreign-types-shared-0.1.1.sha256sum] =3D =
"00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
+SRC_URI[form_urlencoded-1.2.1.sha256sum] =3D =
"e13624c2627564efccf4934284bdd98cbaa14e79b0b5a141218e507b3a823456"
+SRC_URI[generic-array-0.14.7.sha256sum] =3D =
"85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[getrandom-0.2.15.sha256sum] =3D =
"c4567c8db10ae91089c99af84c68c38da3ec2f087c3f82960bcdbf3656b6f4d7"
+SRC_URI[git2-0.18.3.sha256sum] =3D =
"232e6a7bfe35766bf715e55a88b39a700596c0ccfd88cd3680b4cdb40d66ef70"
+SRC_URI[git2-curl-0.19.0.sha256sum] =3D =
"78e26b61608c573ffd26fc79061a823aa5147449a1afe1f61679a21e2031f7c3"
+SRC_URI[gix-0.63.0.sha256sum] =3D =
"984c5018adfa7a4536ade67990b3ebc6e11ab57b3d6cd9968de0947ca99b4b06"
+SRC_URI[gix-actor-0.31.5.sha256sum] =3D =
"a0e454357e34b833cc3a00b6efbbd3dd4d18b24b9fb0c023876ec2645e8aa3f2"
+SRC_URI[gix-attributes-0.22.3.sha256sum] =3D =
"e37ce99c7e81288c28b703641b6d5d119aacc45c1a6b247156e6249afa486257"
+SRC_URI[gix-bitmap-0.2.11.sha256sum] =3D =
"a371db66cbd4e13f0ed9dc4c0fea712d7276805fccc877f77e96374d317e87ae"
+SRC_URI[gix-chunk-0.4.8.sha256sum] =3D =
"45c8751169961ba7640b513c3b24af61aa962c967aaf04116734975cd5af0c52"
+SRC_URI[gix-command-0.3.8.sha256sum] =3D =
"0d76867867da891cbe32021ad454e8cae90242f6afb06762e4dd0d357afd1d7b"
+SRC_URI[gix-commitgraph-0.24.3.sha256sum] =3D =
"133b06f67f565836ec0c473e2116a60fb74f80b6435e21d88013ac0e3c60fc78"
+SRC_URI[gix-config-0.37.0.sha256sum] =3D =
"53fafe42957e11d98e354a66b6bd70aeea00faf2f62dd11164188224a507c840"
+SRC_URI[gix-config-value-0.14.7.sha256sum] =3D =
"b328997d74dd15dc71b2773b162cb4af9a25c424105e4876e6d0686ab41c383e"
+SRC_URI[gix-credentials-0.24.4.sha256sum] =3D =
"198588f532e4d1202e04e6c3f50e4d7c060dffc66801c6f53cc246f1d234739e"
+SRC_URI[gix-date-0.8.7.sha256sum] =3D =
"9eed6931f21491ee0aeb922751bd7ec97b4b2fe8fbfedcb678e2a2dce5f3b8c0"
+SRC_URI[gix-diff-0.44.1.sha256sum] =3D =
"1996d5c8a305b59709467d80617c9fde48d9d75fd1f4179ea970912630886c9d"
+SRC_URI[gix-dir-0.5.0.sha256sum] =3D =
"60c99f8c545abd63abe541d20ab6cda347de406c0a3f1c80aadc12d9b0e94974"
+SRC_URI[gix-discover-0.32.0.sha256sum] =3D =
"fc27c699b63da66b50d50c00668bc0b7e90c3a382ef302865e891559935f3dbf"
+SRC_URI[gix-features-0.38.2.sha256sum] =3D =
"ac7045ac9fe5f9c727f38799d002a7ed3583cd777e3322a7c4b43e3cf437dc69"
+SRC_URI[gix-filter-0.11.3.sha256sum] =3D =
"e6547738da28275f4dff4e9f3a0f28509f53f94dd6bd822733c91cb306bca61a"
+SRC_URI[gix-fs-0.11.2.sha256sum] =3D =
"6adf99c27cdf17b1c4d77680c917e0d94d8783d4e1c73d3be0d1d63107163d7a"
+SRC_URI[gix-glob-0.16.4.sha256sum] =3D =
"fa7df15afa265cc8abe92813cd354d522f1ac06b29ec6dfa163ad320575cb447"
+SRC_URI[gix-hash-0.14.2.sha256sum] =3D =
"f93d7df7366121b5018f947a04d37f034717e113dcf9ccd85c34b58e57a74d5e"
+SRC_URI[gix-hashtable-0.5.2.sha256sum] =3D =
"7ddf80e16f3c19ac06ce415a38b8591993d3f73aede049cb561becb5b3a8e242"
+SRC_URI[gix-ignore-0.11.3.sha256sum] =3D =
"5e6afb8f98e314d4e1adc822449389ada863c174b5707cedd327d67b84dba527"
+SRC_URI[gix-index-0.33.1.sha256sum] =3D =
"9a9a44eb55bd84bb48f8a44980e951968ced21e171b22d115d1cdcef82a7d73f"
+SRC_URI[gix-lock-14.0.0.sha256sum] =3D =
"e3bc7fe297f1f4614774989c00ec8b1add59571dc9b024b4c00acb7dedd4e19d"
+SRC_URI[gix-macros-0.1.5.sha256sum] =3D =
"999ce923619f88194171a67fb3e6d613653b8d4d6078b529b15a765da0edcc17"
+SRC_URI[gix-negotiate-0.13.2.sha256sum] =3D =
"9ec879fb6307bb63519ba89be0024c6f61b4b9d61f1a91fd2ce572d89fe9c224"
+SRC_URI[gix-object-0.42.3.sha256sum] =3D =
"25da2f46b4e7c2fa7b413ce4dffb87f69eaf89c2057e386491f4c55cadbfe386"
+SRC_URI[gix-odb-0.61.1.sha256sum] =3D =
"20d384fe541d93d8a3bb7d5d5ef210780d6df4f50c4e684ccba32665a5e3bc9b"
+SRC_URI[gix-pack-0.51.1.sha256sum] =3D =
"3e0594491fffe55df94ba1c111a6566b7f56b3f8d2e1efc750e77d572f5f5229"
+SRC_URI[gix-packetline-0.17.5.sha256sum] =3D =
"b70486beda0903b6d5b65dfa6e40585098cdf4e6365ca2dff4f74c387354a515"
+SRC_URI[gix-packetline-blocking-0.17.4.sha256sum] =3D =
"c31d42378a3d284732e4d589979930d0d253360eccf7ec7a80332e5ccb77e14a"
+SRC_URI[gix-path-0.10.9.sha256sum] =3D =
"8d23d5bbda31344d8abc8de7c075b3cf26e5873feba7c4a15d916bce67382bd9"
+SRC_URI[gix-pathspec-0.7.6.sha256sum] =3D =
"d307d1b8f84dc8386c4aa20ce0cf09242033840e15469a3ecba92f10cfb5c046"
+SRC_URI[gix-prompt-0.8.6.sha256sum] =3D =
"7e0595d2be4b6d6a71a099e989bdd610882b882da35fb8503d91d6f81aa0936f"
+SRC_URI[gix-protocol-0.45.2.sha256sum] =3D =
"bad8da8e89f24177bd77947092199bb13dcc318bbd73530ba8a05e6d6adaaa9d"
+SRC_URI[gix-quote-0.4.12.sha256sum] =3D =
"cbff4f9b9ea3fa7a25a70ee62f545143abef624ac6aa5884344e70c8b0a1d9ff"
+SRC_URI[gix-ref-0.44.1.sha256sum] =3D =
"3394a2997e5bc6b22ebc1e1a87b41eeefbcfcff3dbfa7c4bd73cb0ac8f1f3e2e"
+SRC_URI[gix-refspec-0.23.1.sha256sum] =3D =
"6868f8cd2e62555d1f7c78b784bece43ace40dd2a462daf3b588d5416e603f37"
+SRC_URI[gix-revision-0.27.2.sha256sum] =3D =
"01b13e43c2118c4b0537ddac7d0821ae0dfa90b7b8dbf20c711e153fb749adce"
+SRC_URI[gix-revwalk-0.13.2.sha256sum] =3D =
"1b030ccaab71af141f537e0225f19b9e74f25fefdba0372246b844491cab43e0"
+SRC_URI[gix-sec-0.10.7.sha256sum] =3D =
"1547d26fa5693a7f34f05b4a3b59a90890972922172653bcb891ab3f09f436df"
+SRC_URI[gix-submodule-0.11.0.sha256sum] =3D =
"921cd49924ac14b6611b22e5fb7bbba74d8780dc7ad26153304b64d1272460ac"
+SRC_URI[gix-tempfile-14.0.1.sha256sum] =3D =
"006acf5a613e0b5cf095d8e4b3f48c12a60d9062aa2b2dd105afaf8344a5600c"
+SRC_URI[gix-trace-0.1.9.sha256sum] =3D =
"f924267408915fddcd558e3f37295cc7d6a3e50f8bd8b606cee0808c3915157e"
+SRC_URI[gix-transport-0.42.2.sha256sum] =3D =
"27c02b83763ffe95bcc27ce5821b2b7f843315a009c06f1cd59c9b66c508c058"
+SRC_URI[gix-traverse-0.39.2.sha256sum] =3D =
"e499a18c511e71cf4a20413b743b9f5bcf64b3d9e81e9c3c6cd399eae55a8840"
+SRC_URI[gix-url-0.27.4.sha256sum] =3D =
"e2eb9b35bba92ea8f0b5ab406fad3cf6b87f7929aa677ff10aa042c6da621156"
+SRC_URI[gix-utils-0.1.12.sha256sum] =3D =
"35192df7fd0fa112263bad8021e2df7167df4cc2a6e6d15892e1e55621d3d4dc"
+SRC_URI[gix-validate-0.8.5.sha256sum] =3D =
"82c27dd34a49b1addf193c92070bcbf3beaf6e10f16a78544de6372e146a0acf"
+SRC_URI[gix-worktree-0.34.1.sha256sum] =3D =
"26f7326ebe0b9172220694ea69d344c536009a9b98fb0f9de092c440f3efe7a6"
+SRC_URI[glob-0.3.1.sha256sum] =3D =
"d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[globset-0.4.14.sha256sum] =3D =
"57da3b9b5b85bd66f31093f8c408b90a74431672542466497dcbdfdc02034be1"
+SRC_URI[group-0.13.0.sha256sum] =3D =
"f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
+SRC_URI[hashbrown-0.12.3.sha256sum] =3D =
"8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
+SRC_URI[hashbrown-0.14.5.sha256sum] =3D =
"e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[hashlink-0.9.1.sha256sum] =3D =
"6ba4ff7128dee98c7dc9794b6a411377e1404dba1c97deb8d1a55297bd25d8af"
+SRC_URI[heck-0.4.1.sha256sum] =3D =
"95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
+SRC_URI[heck-0.5.0.sha256sum] =3D =
"2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+SRC_URI[hex-0.4.3.sha256sum] =3D =
"7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
+SRC_URI[hkdf-0.12.4.sha256sum] =3D =
"7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
+SRC_URI[hmac-0.12.1.sha256sum] =3D =
"6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
+SRC_URI[home-0.5.9.sha256sum] =3D =
"e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
+SRC_URI[http-auth-0.1.9.sha256sum] =3D =
"643c9bbf6a4ea8a656d6b4cd53d34f79e3f841ad5203c1a55fb7d761923bc255"
+SRC_URI[humantime-2.1.0.sha256sum] =3D =
"9a3a5bfb195931eeb336b2a7b4d761daec841b97f947d34394601737a7bba5e4"
+SRC_URI[idna-0.5.0.sha256sum] =3D =
"634d9b1461af396cad843f47fdba5597a4f9e6ddd4bfb6ff5d85028c25cb12f6"
+SRC_URI[ignore-0.4.22.sha256sum] =3D =
"b46810df39e66e925525d6e38ce1e7f6e1d208f72dc39757880fcb66e2c58af1"
+SRC_URI[im-rc-15.1.0.sha256sum] =3D =
"af1955a75fa080c677d3972822ec4bad316169ab1cfc6c257a942c2265dbe5fe"
+SRC_URI[indexmap-1.9.3.sha256sum] =3D =
"bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
+SRC_URI[indexmap-2.2.6.sha256sum] =3D =
"168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
+SRC_URI[is_terminal_polyfill-1.70.1.sha256sum] =3D =
"7943c866cc5cd64cbc25b2e01621d07fa8eb2a1a23160ee81ce38704e97b8ecf"
+SRC_URI[itertools-0.12.1.sha256sum] =3D =
"ba291022dbbd398a455acf126c1e341954079855bc60dfdda641363bd6922569"
+SRC_URI[itertools-0.13.0.sha256sum] =3D =
"413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
+SRC_URI[itoa-1.0.11.sha256sum] =3D =
"49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[jobserver-0.1.32.sha256sum] =3D =
"48d1dbcbbeb6a7fec7e059840aa538bd62aaccf972c7346c4d9d2059312853d0"
+SRC_URI[js-sys-0.3.69.sha256sum] =3D =
"29c15563dc2726973df627357ce0c9ddddbea194836909d655df6a75d2cf296d"
+SRC_URI[kstring-2.0.2.sha256sum] =3D =
"558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
+SRC_URI[lazy_static-1.5.0.sha256sum] =3D =
"bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[lazycell-1.3.0.sha256sum] =3D =
"830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
+SRC_URI[libc-0.2.155.sha256sum] =3D =
"97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+SRC_URI[libdbus-sys-0.2.5.sha256sum] =3D =
"06085512b750d640299b79be4bad3d2fa90a9c00b1fd9e1b46364f66f0485c72"
+SRC_URI[libgit2-sys-0.16.2+1.7.2.sha256sum] =3D =
"ee4126d8b4ee5c9d9ea891dd875cfdc1e9d0950437179104b183d7d8a74d24e8"
+SRC_URI[libloading-0.8.5.sha256sum] =3D =
"4979f22fdb869068da03c9f7528f8297c6fd2606bc3a4affe42e6a823fdb8da4"
+SRC_URI[libnghttp2-sys-0.1.10+1.61.0.sha256sum] =3D =
"959c25552127d2e1fa72f0e52548ec04fc386e827ba71a7bd01db46a447dc135"
+SRC_URI[libsqlite3-sys-0.28.0.sha256sum] =3D =
"0c10584274047cb335c23d3e61bcef8e323adae7c5c8c760540f73610177fc3f"
+SRC_URI[libssh2-sys-0.3.0.sha256sum] =3D =
"2dc8a030b787e2119a731f1951d6a773e2280c660f8ec4b0f5e1505a386e71ee"
+SRC_URI[libz-sys-1.1.18.sha256sum] =3D =
"c15da26e5af7e25c90b37a2d75cdbf940cf4a55316de9d84c679c9b8bfabf82e"
+SRC_URI[linux-raw-sys-0.4.14.sha256sum] =3D =
"78b3ae25bc7c8c38cec158d1f2757ee79e9b3740fbc7ccf0e59e4b08d793fa89"
+SRC_URI[lock_api-0.4.12.sha256sum] =3D =
"07af8b9cdd281b7915f413fa73f29ebd5d55d0d3f0155584dade1ff18cea1b17"
+SRC_URI[log-0.4.22.sha256sum] =3D =
"a7a70ba024b9dc04c27ea2f0c0548feb474ec5c54bba33a7f72f873a39d07b24"
+SRC_URI[matchers-0.1.0.sha256sum] =3D =
"8263075bb86c5a1b1427b5ae862e8889656f126e9f77c484496e8b47cf5c5558"
+SRC_URI[maybe-async-0.2.10.sha256sum] =3D =
"5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
+SRC_URI[memchr-2.7.4.sha256sum] =3D =
"78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[memmap2-0.9.4.sha256sum] =3D =
"fe751422e4a8caa417e13c3ea66452215d7d63e19e604f4980461212f3ae1322"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] =3D =
"68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[miniz_oxide-0.7.4.sha256sum] =3D =
"b8a240ddb74feaf34a79a7add65a741f3167852fba007066dcac1ca548d89c08"
+SRC_URI[miow-0.6.0.sha256sum] =3D =
"359f76430b20a79f9e20e115b3428614e654f04fab314482fc0fda0ebd3c6044"
+SRC_URI[nom-7.1.3.sha256sum] =3D =
"d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
+SRC_URI[normpath-1.2.0.sha256sum] =3D =
"5831952a9476f2fed74b77d74182fa5ddc4d21c72ec45a333b250e3ed0272804"
+SRC_URI[nu-ansi-term-0.46.0.sha256sum] =3D =
"77a8165726e8236064dbb45459242600304b42a5ea24ee2948e18e023bf7ba84"
+SRC_URI[num-conv-0.1.0.sha256sum] =3D =
"51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-traits-0.2.19.sha256sum] =3D =
"071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[num_threads-0.1.7.sha256sum] =3D =
"5c7398b9c8b70908f6371f47ed36737907c87c52af34c268fed0bf0ceb92ead9"
+SRC_URI[once_cell-1.19.0.sha256sum] =3D =
"3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
+SRC_URI[opener-0.7.1.sha256sum] =3D =
"f8df34be653210fbe9ffaff41d3b92721c56ce82dfee58ee684f9afb5e3a90c0"
+SRC_URI[openssl-0.10.66.sha256sum] =3D =
"9529f4786b70a3e8c61e11179af17ab6188ad8d0ded78c5529441ed39d4bd9c1"
+SRC_URI[openssl-macros-0.1.1.sha256sum] =3D =
"a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
+SRC_URI[openssl-probe-0.1.5.sha256sum] =3D =
"ff011a302c396a5197692431fc1948019154afc178baf7d8e37367442a4601cf"
+SRC_URI[openssl-src-300.3.1+3.3.1.sha256sum] =3D =
"7259953d42a81bf137fbbd73bd30a8e1914d6dce43c2b90ed575783a22608b91"
+SRC_URI[openssl-sys-0.9.103.sha256sum] =3D =
"7f9e8deee91df40a943c71b917e5874b951d32a802526c85721ce3b776c929d6"
+SRC_URI[ordered-float-2.10.1.sha256sum] =3D =
"68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
+SRC_URI[orion-0.17.6.sha256sum] =3D =
"7abdb10181903c8c4b016ba45d6d6d5af1a1e2a461aa4763a83b87f5df4695e5"
+SRC_URI[os_info-3.8.2.sha256sum] =3D =
"ae99c7fa6dd38c7cafe1ec085e804f8f555a2f8659b0dbe03f1f9963a9b51092"
+SRC_URI[overload-0.1.1.sha256sum] =3D =
"b15813163c1d831bf4a13c3610c05c0d03b39feb07f7e09fa234dac9b15aaf39"
+SRC_URI[p384-0.13.0.sha256sum] =3D =
"70786f51bcc69f6a4c0360e063a4cac5419ef7c5cd5b3c99ad70f3be5ba79209"
+SRC_URI[parking_lot-0.12.3.sha256sum] =3D =
"f1bf18183cf54e8d6059647fc3063646a1801cf30896933ec2311622cc4b9a27"
+SRC_URI[parking_lot_core-0.9.10.sha256sum] =3D =
"1e401f977ab385c9e4e3ab30627d6f26d00e2c73eef317493c4ec6d468726cf8"
+SRC_URI[pasetors-0.6.8.sha256sum] =3D =
"6b36d47c66f2230dd1b7143d9afb2b4891879020210eddf2ccb624e529b96dba"
+SRC_URI[pathdiff-0.2.1.sha256sum] =3D =
"8835116a5c179084a830efb3adc117ab007512b535bc1a21c991d3b32a6b44dd"
+SRC_URI[pem-rfc7468-0.7.0.sha256sum] =3D =
"88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
+SRC_URI[percent-encoding-2.3.1.sha256sum] =3D =
"e3148f5046208a5d56bcfc03053e3ca6334e51da8dfb19b6cdc8b306fae3283e"
+SRC_URI[pin-project-lite-0.2.14.sha256sum] =3D =
"bda66fc9667c18cb2758a2ac84d1167245054bcf85d5d1aaa6923f45801bdd02"
+SRC_URI[pkcs8-0.10.2.sha256sum] =3D =
"f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
+SRC_URI[pkg-config-0.3.30.sha256sum] =3D =
"d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
+SRC_URI[powerfmt-0.2.0.sha256sum] =3D =
"439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[ppv-lite86-0.2.18.sha256sum] =3D =
"dee4364d9f3b902ef14fab8a1ddffb783a1cb6b4bba3bfc1fa3922732c7de97f"
+SRC_URI[primeorder-0.13.6.sha256sum] =3D =
"353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
+SRC_URI[proc-macro2-1.0.86.sha256sum] =3D =
"5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+SRC_URI[prodash-28.0.0.sha256sum] =3D =
"744a264d26b88a6a7e37cbad97953fa233b94d585236310bcbc88474b4092d79"
+SRC_URI[quote-1.0.36.sha256sum] =3D =
"0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[rand-0.8.5.sha256sum] =3D =
"34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_chacha-0.3.1.sha256sum] =3D =
"e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.4.sha256sum] =3D =
"ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[rand_xoshiro-0.6.0.sha256sum] =3D =
"6f97cdb2a36ed4183de61b2f824cc45c9f1037f28afe0a322e9fff4c108b5aaa"
+SRC_URI[redox_syscall-0.4.1.sha256sum] =3D =
"4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
+SRC_URI[redox_syscall-0.5.3.sha256sum] =3D =
"2a908a6e00f1fdd0dfd9c0eb08ce85126f6d8bbda50017e74bc4a4b7d4a926a4"
+SRC_URI[regex-1.10.5.sha256sum] =3D =
"b91213439dad192326a0d7c6ee3955910425f441d7038e0d6933b0aec5c4517f"
+SRC_URI[regex-automata-0.1.10.sha256sum] =3D =
"6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
+SRC_URI[regex-automata-0.4.7.sha256sum] =3D =
"38caf58cc5ef2fed281f89292ef23f6365465ed9a41b7a7754eb4e26496c92df"
+SRC_URI[regex-syntax-0.6.29.sha256sum] =3D =
"f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
+SRC_URI[regex-syntax-0.8.4.sha256sum] =3D =
"7a66a03ae7c801facd77a29370b4faec201768915ac14a721ba36f20bc9c209b"
+SRC_URI[rfc6979-0.4.0.sha256sum] =3D =
"f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
+SRC_URI[rusqlite-0.31.0.sha256sum] =3D =
"b838eba278d213a8beaf485bd313fd580ca4505a00d5871caeb1457c55322cae"
+SRC_URI[rustfix-0.8.4.sha256sum] =3D =
"4cef0c817217c330b3ef879e06455d726c1cffc800eaf7734d3b4ac63213636b"
+SRC_URI[rustix-0.38.34.sha256sum] =3D =
"70dc5ec042f7a43c4a73241207cecc9873a06d45debb38b329f8541d85c2730f"
+SRC_URI[ryu-1.0.18.sha256sum] =3D =
"f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[same-file-1.0.6.sha256sum] =3D =
"93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
+SRC_URI[schannel-0.1.23.sha256sum] =3D =
"fbc91545643bcf3a0bbb6569265615222618bdf33ce4ffbbd13c4bbd4c093534"
+SRC_URI[scopeguard-1.2.0.sha256sum] =3D =
"94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
+SRC_URI[sec1-0.7.3.sha256sum] =3D =
"d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
+SRC_URI[security-framework-2.11.1.sha256sum] =3D =
"897b2245f0b511c87893af39b033e5ca9cce68824c4d7e7630b5a1d339658d02"
+SRC_URI[security-framework-sys-2.11.1.sha256sum] =3D =
"75da29fe9b9b08fe9d6b22b5b4bcbc75d8db3aa31e639aa56bb62e9d46bfceaf"
+SRC_URI[semver-1.0.23.sha256sum] =3D =
"61697e0a1c7e512e84a621326239844a24d8207b4669b41bc18b32ea5cbf988b"
+SRC_URI[serde-1.0.204.sha256sum] =3D =
"bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
+SRC_URI[serde-untagged-0.1.6.sha256sum] =3D =
"2676ba99bd82f75cae5cbd2c8eda6fa0b8760f18978ea840e980dd5567b5c5b6"
+SRC_URI[serde-value-0.7.0.sha256sum] =3D =
"f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
+SRC_URI[serde_derive-1.0.204.sha256sum] =3D =
"e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
+SRC_URI[serde_ignored-0.1.10.sha256sum] =3D =
"a8e319a36d1b52126a0d608f24e93b2d81297091818cd70625fcf50a15d84ddf"
+SRC_URI[serde_json-1.0.121.sha256sum] =3D =
"4ab380d7d9f22ef3f21ad3e6c1ebe8e4fc7a2000ccba2e4d71fc96f15b2cb609"
+SRC_URI[serde_spanned-0.6.7.sha256sum] =3D =
"eb5b1b31579f3811bf615c144393417496f152e12ac8b7663bf664f4a815306d"
+SRC_URI[sha1-0.10.6.sha256sum] =3D =
"e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
+SRC_URI[sha1_smol-1.0.1.sha256sum] =3D =
"bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
+SRC_URI[sha2-0.10.8.sha256sum] =3D =
"793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
+SRC_URI[sharded-slab-0.1.7.sha256sum] =3D =
"f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6"
+SRC_URI[shell-escape-0.1.5.sha256sum] =3D =
"45bb67a18fa91266cc7807181f62f9178a6873bfad7dc788c42e6430db40184f"
+SRC_URI[shell-words-1.1.0.sha256sum] =3D =
"24188a676b6ae68c3b2cb3a01be17fbf7240ce009799bb56d5b1409051e78fde"
+SRC_URI[signature-2.2.0.sha256sum] =3D =
"77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
+SRC_URI[sized-chunks-0.6.5.sha256sum] =3D =
"16d69225bde7a69b235da73377861095455d298f2b970996eec25ddbb42b3d1e"
+SRC_URI[smallvec-1.13.2.sha256sum] =3D =
"3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
+SRC_URI[socket2-0.5.7.sha256sum] =3D =
"ce305eb0b4296696835b71df73eb912e0f1ffd2556a501fcede6e0c50349191c"
+SRC_URI[spki-0.7.3.sha256sum] =3D =
"d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
+SRC_URI[static_assertions-1.1.0.sha256sum] =3D =
"a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
+SRC_URI[strsim-0.11.1.sha256sum] =3D =
"7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+SRC_URI[subtle-2.6.1.sha256sum] =3D =
"13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
+SRC_URI[supports-hyperlinks-3.0.0.sha256sum] =3D =
"2c0a1e5168041f5f3ff68ff7d95dcb9c8749df29f6e7e89ada40dd4c9de404ee"
+SRC_URI[supports-unicode-3.0.0.sha256sum] =3D =
"b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
+SRC_URI[syn-1.0.109.sha256sum] =3D =
"72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.72.sha256sum] =3D =
"dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+SRC_URI[tar-0.4.41.sha256sum] =3D =
"cb797dad5fb5b76fcf519e702f4a589483b5ef06567f160c392832c1f5e44909"
+SRC_URI[tempfile-3.10.1.sha256sum] =3D =
"85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
+SRC_URI[terminal_size-0.3.0.sha256sum] =3D =
"21bebf2b7c9e0a515f6e0f8c51dc0f8e4696391e6f1ff30379559f8365fb0df7"
+SRC_URI[thiserror-1.0.63.sha256sum] =3D =
"c0342370b38b6a11b6cc11d6a805569958d54cfa061a29969c3b5ce2ea405724"
+SRC_URI[thiserror-impl-1.0.63.sha256sum] =3D =
"a4558b58466b9ad7ca0f102865eccc95938dca1a74a856f2b57b6629050da261"
+SRC_URI[thread_local-1.1.8.sha256sum] =3D =
"8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
+SRC_URI[time-0.3.36.sha256sum] =3D =
"5dfd88e563464686c916c7e46e623e520ddc6d79fa6641390f2e3fa86e83e885"
+SRC_URI[time-core-0.1.2.sha256sum] =3D =
"ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
+SRC_URI[time-macros-0.2.18.sha256sum] =3D =
"3f252a68540fde3a3877aeea552b832b40ab9a69e318efd078774a01ddee1ccf"
+SRC_URI[tinyvec-1.8.0.sha256sum] =3D =
"445e881f4f6d382d5f27c034e25eb92edd7c784ceab92a0937db7f2e9471b938"
+SRC_URI[tinyvec_macros-0.1.1.sha256sum] =3D =
"1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
+SRC_URI[toml-0.5.11.sha256sum] =3D =
"f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
+SRC_URI[toml-0.8.16.sha256sum] =3D =
"81967dd0dd2c1ab0bc3468bd7caecc32b8a4aa47d0c8c695d8c2b2108168d62c"
+SRC_URI[toml_datetime-0.6.7.sha256sum] =3D =
"f8fb9f64314842840f1d940ac544da178732128f1c78c21772e876579e0da1db"
+SRC_URI[toml_edit-0.22.17.sha256sum] =3D =
"8d9f8729f5aea9562aac1cc0441f5d6de3cff1ee0c5d67293eeca5eb36ee7c16"
+SRC_URI[tracing-0.1.40.sha256sum] =3D =
"c3523ab5a71916ccf420eebdf5521fcef02141234bbc0b8a49f2fdc4544364ef"
+SRC_URI[tracing-attributes-0.1.27.sha256sum] =3D =
"34704c8d6ebcbc939824180af020566b01a7c01f80641264eba0999f6c2b6be7"
+SRC_URI[tracing-chrome-0.7.2.sha256sum] =3D =
"bf0a738ed5d6450a9fb96e86a23ad808de2b727fd1394585da5cdd6788ffe724"
+SRC_URI[tracing-core-0.1.32.sha256sum] =3D =
"c06d3da6113f116aaee68e4d601191614c9053067f9ab7f6edbcb161237daa54"
+SRC_URI[tracing-log-0.2.0.sha256sum] =3D =
"ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3"
+SRC_URI[tracing-subscriber-0.3.18.sha256sum] =3D =
"ad0f048c97dbd9faa9b7df56362b8ebcaa52adb06b498c050d2f4e32f90a7a8b"
+SRC_URI[typeid-1.0.0.sha256sum] =3D =
"059d83cc991e7a42fc37bd50941885db0888e34209f8cfd9aab07ddec03bc9cf"
+SRC_URI[typenum-1.17.0.sha256sum] =3D =
"42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
+SRC_URI[unicase-2.7.0.sha256sum] =3D =
"f7d2d4dafb69621809a81864c9c1b864479e1235c0dd4e199924b9742439ed89"
+SRC_URI[unicode-bidi-0.3.15.sha256sum] =3D =
"08f95100a766bf4f8f28f90d77e0a5461bbdb219042e7679bebe79004fed8d75"
+SRC_URI[unicode-bom-2.0.3.sha256sum] =3D =
"7eec5d1121208364f6793f7d2e222bf75a915c19557537745b195b253dd64217"
+SRC_URI[unicode-ident-1.0.12.sha256sum] =3D =
"3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[unicode-normalization-0.1.23.sha256sum] =3D =
"a56d1686db2308d901306f92a263857ef59ea39678a5458e7cb17f01415101f5"
+SRC_URI[unicode-width-0.1.13.sha256sum] =3D =
"0336d538f7abc86d282a4189614dfaa90810dfc2c6f6427eaf88e16311dd225d"
+SRC_URI[unicode-xid-0.2.4.sha256sum] =3D =
"f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
+SRC_URI[url-2.5.2.sha256sum] =3D =
"22784dbdf76fdde8af1aeda5622b546b422b6fc585325248a2bf9f5e41e94d6c"
+SRC_URI[utf8parse-0.2.2.sha256sum] =3D =
"06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+SRC_URI[valuable-0.1.0.sha256sum] =3D =
"830b7e5d4d90034032940e4ace0d9a9a057e7a45cd94e6c007832e39edb82f6d"
+SRC_URI[vcpkg-0.2.15.sha256sum] =3D =
"accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
+SRC_URI[version_check-0.9.5.sha256sum] =3D =
"0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+SRC_URI[walkdir-2.5.0.sha256sum] =3D =
"29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] =3D =
"9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+SRC_URI[wasm-bindgen-0.2.92.sha256sum] =3D =
"4be2531df63900aeb2bca0daaaddec08491ee64ceecbee5076636a3b026795a8"
+SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] =3D =
"614d787b966d3989fa7bb98a654e369c762374fd3213d212cfc0251257e747da"
+SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] =3D =
"a1f8823de937b71b9460c0c34e25f3da88250760bec0ebac694b49997550d726"
+SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] =3D =
"e94f17b526d0a461a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
+SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] =3D =
"af190c94f2773fdb3729c55b007a722abb5384da03bc0986df4c289bf5567e96"
+SRC_URI[winapi-0.3.9.sha256sum] =3D =
"5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] =3D =
"ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-util-0.1.8.sha256sum] =3D =
"4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] =3D =
"712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+SRC_URI[windows-sys-0.48.0.sha256sum] =3D =
"677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
+SRC_URI[windows-sys-0.52.0.sha256sum] =3D =
"282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.48.5.sha256sum] =3D =
"9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
+SRC_URI[windows-targets-0.52.6.sha256sum] =3D =
"9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] =3D =
"2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] =3D =
"32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] =3D =
"dc35310971f3b2dbbf3f0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] =3D =
"09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.48.5.sha256sum] =3D =
"a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] =3D =
"8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] =3D =
"0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.48.5.sha256sum] =3D =
"8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] =3D =
"240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] =3D =
"53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] =3D =
"147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] =3D =
"0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] =3D =
"24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] =3D =
"ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] =3D =
"589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.6.16.sha256sum] =3D =
"b480ae9340fc261e6be3e95a1ba86d54ae3f9171132a73ce8d4bbaf68339507c"
+SRC_URI[zerocopy-0.6.6.sha256sum] =3D =
"854e949ac82d619ee9a14c66a1b674ac730422372ccb759ce0c39cabcf2bf8e6"
+SRC_URI[zerocopy-0.7.35.sha256sum] =3D =
"1b9b4fd18abc82b8136838da5d50bae7bdea537c574d8dc1a34ed098d6c166f0"
+SRC_URI[zerocopy-derive-0.6.6.sha256sum] =3D =
"125139de3f6b9d625c39e2efdd73d41bdac468ccd556556440e322be0e1bbd91"
+SRC_URI[zerocopy-derive-0.7.35.sha256sum] =3D =
"fa4f8080344d4671fb4e831a13ad1e68092748387dfc4f55e356242fae12ce3e"
+SRC_URI[zeroize-1.8.1.sha256sum] =3D =
"ced3678a2879b30306d323f4542626697a464a97c0a07c9aebf7ebca65cd4dde"
diff --git a/recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb =
b/recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb
new file mode 100644
index 0000000..145e704
--- /dev/null
+++ b/recipes-devtools/rust/cargo-c-native_0.10.3+cargo-0.81.0.bb
@@ -0,0 +1,17 @@
+SUMMARY =3D "cargo applet to build and install C-ABI compatible dynamic =
and static libraries."
+HOMEPAGE =3D "https://crates.io/crates/cargo-c"
+LICENSE =3D "MIT"
+LIC_FILES_CHKSUM =3D " \
+    file://LICENSE;md5=3D384ed0e2e0b2dac094e51fbf93fdcbe0 \
+"
+
+SRC_URI =3D "crate://crates.io/cargo-c/${PV};name=3Dcargo-c"
+SRC_URI[cargo-c.sha256sum] =3D =
"99f10fab01de791f95e81134202792e4a6975c3a3921fec2d4cbf3e9c269b709"
+S =3D "${CARGO_VENDORING_DIRECTORY}/cargo-c-${PV}"
+
+inherit cargo cargo-update-recipe-crates pkgconfig native
+
+DEPENDS =3D "openssl curl"
+
+require ${BPN}-crates.inc
+
diff --git a/recipes-devtools/rust/cargo_1.78.0.bb =
b/recipes-devtools/rust/cargo_1.78.0.bb
new file mode 100644
index 0000000..50b7e7c
--- /dev/null
+++ b/recipes-devtools/rust/cargo_1.78.0.bb
@@ -0,0 +1,73 @@
+SUMMARY =3D "Cargo, a package manager for Rust."
+HOMEPAGE =3D "https://crates.io"
+LICENSE =3D "MIT | Apache-2.0"
+SECTION =3D "devel"
+
+DEPENDS =3D "openssl zlib curl ca-certificates libssh2"
+
+LIC_FILES_CHKSUM =3D " \
+    file://LICENSE-MIT;md5=3Db377b220f43d747efdec40d69fcaa69d \
+    file://LICENSE-APACHE;md5=3D71b224ca933f0676e26d5c2e2271331c \
+    file://LICENSE-THIRD-PARTY;md5=3Df257ad009884cb88a3a87d6920e7180a \
+"
+
+require rust-source.inc
+require rust-snapshot.inc
+
+S =3D "${RUSTSRC}/src/tools/cargo"
+CARGO_VENDORING_DIRECTORY =3D "${RUSTSRC}/vendor"
+
+inherit cargo pkgconfig
+
+DEBUG_PREFIX_MAP +=3D =
"-fdebug-prefix-map=3D${RUSTSRC}/vendor=3D${TARGET_DBGSRC_DIR}"
+
+do_cargo_setup_snapshot () {
+	${WORKDIR}/rust-snapshot-components/${CARGO_SNAPSHOT}/install.sh =
--prefix=3D"${WORKDIR}/${CARGO_SNAPSHOT}" --disable-ldconfig
+	# Need to use uninative's loader if enabled/present since the =
library paths
+	# are used internally by rust and result in symbol mismatches if =
we don't
+	if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; =
then
+		patchelf-uninative =
${WORKDIR}/${CARGO_SNAPSHOT}/bin/cargo --set-interpreter =
${UNINATIVE_LOADER}
+	fi
+}
+
+addtask cargo_setup_snapshot after do_unpack before do_configure
+do_cargo_setup_snapshot[dirs] +=3D "${WORKDIR}/${CARGO_SNAPSHOT}"
+do_cargo_setup_snapshot[vardepsexclude] +=3D "UNINATIVE_LOADER"
+
+
+do_compile:prepend () {
+	export RUSTC_BOOTSTRAP=3D"1"
+}
+
+do_install () {
+	install -d "${D}${bindir}"
+	install -m 755 "${B}/target/${CARGO_TARGET_SUBDIR}/cargo" =
"${D}${bindir}"
+}
+
+do_install:append:class-nativesdk() {
+	# To quote the cargo docs, "Cargo also sets the dynamic library =
path when compiling
+	# and running binaries with commands like `cargo run` and `cargo =
test`". Sadly it
+	# sets to libdir but not base_libdir leading to symbol =
mismatches depending on the
+	# host OS. Fully set LD_LIBRARY_PATH to contain both to avoid =
this.
+	create_wrapper ${D}/${bindir}/cargo =
LD_LIBRARY_PATH=3D${libdir}:${base_libdir}
+}
+
+# Disabled due to incompatibility with libgit2 0.28.x =
(https://github.com/rust-lang/git2-rs/issues/458, =
https://bugs.gentoo.org/707746#c1)
+# as shipped by Yocto Dunfell.
+# According to =
https://github.com/rust-lang/git2-rs/issues/458#issuecomment-522567539, =
there are no compatibility guarantees between
+# libgit2-sys and arbitrary system libgit2 versions, so better keep =
this turned off.
+#export LIBGIT2_SYS_USE_PKG_CONFIG =3D "1"
+
+# Needed for pkg-config to be used
+export LIBSSH2_SYS_USE_PKG_CONFIG =3D "1"
+
+# When building cargo-native we don't have cargo-native to use and =
depend on,
+# so we must use the locally set up snapshot to bootstrap the build.
+BASEDEPENDS:remove:class-native =3D "cargo-native"
+CARGO:class-native =3D "${WORKDIR}/${CARGO_SNAPSHOT}/bin/cargo"
+
+DEPENDS:append:class-nativesdk =3D " nativesdk-rust"
+RUSTLIB:append:class-nativesdk =3D " -L =
${STAGING_DIR_HOST}/${SDKPATHNATIVE}/usr/lib/rustlib/${RUST_HOST_SYS}/lib"=

+RUSTLIB_DEP:class-nativesdk =3D ""
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git a/recipes-devtools/rust/cargo_1.80.0.bb =
b/recipes-devtools/rust/cargo_1.80.0.bb
new file mode 100644
index 0000000..50b7e7c
--- /dev/null
+++ b/recipes-devtools/rust/cargo_1.80.0.bb
@@ -0,0 +1,73 @@
+SUMMARY =3D "Cargo, a package manager for Rust."
+HOMEPAGE =3D "https://crates.io"
+LICENSE =3D "MIT | Apache-2.0"
+SECTION =3D "devel"
+
+DEPENDS =3D "openssl zlib curl ca-certificates libssh2"
+
+LIC_FILES_CHKSUM =3D " \
+    file://LICENSE-MIT;md5=3Db377b220f43d747efdec40d69fcaa69d \
+    file://LICENSE-APACHE;md5=3D71b224ca933f0676e26d5c2e2271331c \
+    file://LICENSE-THIRD-PARTY;md5=3Df257ad009884cb88a3a87d6920e7180a \
+"
+
+require rust-source.inc
+require rust-snapshot.inc
+
+S =3D "${RUSTSRC}/src/tools/cargo"
+CARGO_VENDORING_DIRECTORY =3D "${RUSTSRC}/vendor"
+
+inherit cargo pkgconfig
+
+DEBUG_PREFIX_MAP +=3D =
"-fdebug-prefix-map=3D${RUSTSRC}/vendor=3D${TARGET_DBGSRC_DIR}"
+
+do_cargo_setup_snapshot () {
+	${WORKDIR}/rust-snapshot-components/${CARGO_SNAPSHOT}/install.sh =
--prefix=3D"${WORKDIR}/${CARGO_SNAPSHOT}" --disable-ldconfig
+	# Need to use uninative's loader if enabled/present since the =
library paths
+	# are used internally by rust and result in symbol mismatches if =
we don't
+	if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; =
then
+		patchelf-uninative =
${WORKDIR}/${CARGO_SNAPSHOT}/bin/cargo --set-interpreter =
${UNINATIVE_LOADER}
+	fi
+}
+
+addtask cargo_setup_snapshot after do_unpack before do_configure
+do_cargo_setup_snapshot[dirs] +=3D "${WORKDIR}/${CARGO_SNAPSHOT}"
+do_cargo_setup_snapshot[vardepsexclude] +=3D "UNINATIVE_LOADER"
+
+
+do_compile:prepend () {
+	export RUSTC_BOOTSTRAP=3D"1"
+}
+
+do_install () {
+	install -d "${D}${bindir}"
+	install -m 755 "${B}/target/${CARGO_TARGET_SUBDIR}/cargo" =
"${D}${bindir}"
+}
+
+do_install:append:class-nativesdk() {
+	# To quote the cargo docs, "Cargo also sets the dynamic library =
path when compiling
+	# and running binaries with commands like `cargo run` and `cargo =
test`". Sadly it
+	# sets to libdir but not base_libdir leading to symbol =
mismatches depending on the
+	# host OS. Fully set LD_LIBRARY_PATH to contain both to avoid =
this.
+	create_wrapper ${D}/${bindir}/cargo =
LD_LIBRARY_PATH=3D${libdir}:${base_libdir}
+}
+
+# Disabled due to incompatibility with libgit2 0.28.x =
(https://github.com/rust-lang/git2-rs/issues/458, =
https://bugs.gentoo.org/707746#c1)
+# as shipped by Yocto Dunfell.
+# According to =
https://github.com/rust-lang/git2-rs/issues/458#issuecomment-522567539, =
there are no compatibility guarantees between
+# libgit2-sys and arbitrary system libgit2 versions, so better keep =
this turned off.
+#export LIBGIT2_SYS_USE_PKG_CONFIG =3D "1"
+
+# Needed for pkg-config to be used
+export LIBSSH2_SYS_USE_PKG_CONFIG =3D "1"
+
+# When building cargo-native we don't have cargo-native to use and =
depend on,
+# so we must use the locally set up snapshot to bootstrap the build.
+BASEDEPENDS:remove:class-native =3D "cargo-native"
+CARGO:class-native =3D "${WORKDIR}/${CARGO_SNAPSHOT}/bin/cargo"
+
+DEPENDS:append:class-nativesdk =3D " nativesdk-rust"
+RUSTLIB:append:class-nativesdk =3D " -L =
${STAGING_DIR_HOST}/${SDKPATHNATIVE}/usr/lib/rustlib/${RUST_HOST_SYS}/lib"=

+RUSTLIB_DEP:class-nativesdk =3D ""
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git =
a/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-int=
o-compilation.patch =
b/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-int=
o-compilation.patch
new file mode 100644
index 0000000..7579ea0
--- /dev/null
+++ =
b/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-int=
o-compilation.patch
@@ -0,0 +1,51 @@
+=46rom 065d7c263091118437465d714d8a29dbb6296921 Mon Sep 17 00:00:00 =
2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Mon, 13 May 2024 14:57:54 +0200
+Subject: [PATCH] cargo: do not write host information into compilation =
unit
+ hashes
+
+This breaks reproducibility in cross-builds where the cross-target
+can be the same, but build hosts are different, as seen with
+"rustc --version -v":
+...
+host: x86_64-unknown-linux-gnu
+
+vs.
+
+host: aarch64-unknown-linux-gnu
+
+This can possibly be improved by only hashing host info if the build
+is a native one (e.g. there's no --target option passed to cargo
+invocation) but I'm not sure how.
+
+Upstream-Status: Inappropriate [reported at =
https://github.com/rust-lang/cargo/issues/13922]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ .../src/cargo/core/compiler/context/compilation_files.rs      | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git =
a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.r=
s =
b/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.r=
s
+index d83dbf10c..b2ad8d9f3 100644
+--- =
a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.r=
s
++++ =
b/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_files.r=
s
+@@ -652,7 +652,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, =
hasher: &mut StableHasher) {
+     if vers.pre.is_empty() || =
bcx.gctx.cli_unstable().separate_nightlies {
+         // For stable, keep the artifacts separate. This helps if =
someone is
+         // testing multiple versions, to avoid recompiles.
+-        bcx.rustc().verbose_version.hash(hasher);
++        //bcx.rustc().verbose_version.hash(hasher);
+         return;
+     }
+     // On "nightly"/"beta"/"dev"/etc, keep each "channel" separate. =
Don't hash
+@@ -665,7 +665,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, =
hasher: &mut StableHasher) {
+     // Keep "host" since some people switch hosts to implicitly change
+     // targets, (like gnu vs musl or gnu vs msvc). In the future, we =
may want
+     // to consider hashing `unit.kind.short_name()` instead.
+-    bcx.rustc().host.hash(hasher);
++    //bcx.rustc().host.hash(hasher);
+     // None of the other lines are important. Currently they are:
+     // binary: rustc  <-- or "rustdoc"
+     // commit-hash: 38114ff16e7856f98b2b4be7ab4cd29b38bed59a
+--=20
+2.39.2
+
diff --git a/recipes-devtools/rust/files/cross-targets-backport.patch =
b/recipes-devtools/rust/files/cross-targets-backport.patch
new file mode 100644
index 0000000..6613cfa
--- /dev/null
+++ b/recipes-devtools/rust/files/cross-targets-backport.patch
@@ -0,0 +1,31 @@
+Backport the patch for "ensure std for cross-targets".
+
+Previously, doing `x test compiler/*` would fail the build due to =
missing std.
+This change ensures that it is prepared.
+
+Also, add "[ignore]" tags to the failing unit tests to
+ignore them during rust oe-selftest.
+
+Upstream-Status: Backport =
[https://github.com/rust-lang/rust/pull/122205/commits/5aece7fad06baaa7457=
84d118db862b3e3ccf7f8]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/src/bootstrap/src/core/build_steps/test.rs =
b/src/bootstrap/src/core/build_steps/test.rs
+index 4a4497e57db..da8c88dcd41 100644
+--- a/src/bootstrap/src/core/build_steps/test.rs
++++ b/src/bootstrap/src/core/build_steps/test.rs
+@@ -2505,8 +2505,12 @@
+         let mode =3D self.mode;
+
+         // See [field@compile::Std::force_recompile].
+-        builder.ensure(compile::Std::force_recompile(compiler, =
target));
+-        builder.ensure(RemoteCopyLibs { compiler, target });
++        builder.ensure(compile::Std::force_recompile(compiler, =
compiler.host));
++
++        if builder.config.build !=3D target {
++            builder.ensure(compile::Std::force_recompile(compiler, =
target));
++            builder.ensure(RemoteCopyLibs { compiler, target });
++        }
+
+         // If we're not doing a full bootstrap but we're testing a =
stage2
+         // version of libstd, then what we're actually testing is the =
libstd
diff --git a/recipes-devtools/rust/files/hardcodepaths.patch =
b/recipes-devtools/rust/files/hardcodepaths.patch
new file mode 100644
index 0000000..6966542
--- /dev/null
+++ b/recipes-devtools/rust/files/hardcodepaths.patch
@@ -0,0 +1,46 @@
+When building for the target, some build paths end up embedded in the =
binaries.
+These changes remove that. Further investigation is needed to work out =
the way
+to resolve these issues properly upstream.
+
+Upstream-Status: Inappropriate [patches need rework]
+Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
+Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
+
+diff --git a/compiler/rustc_codegen_llvm/src/context.rs =
b/compiler/rustc_codegen_llvm/src/context.rs
+index b4b2ab1e1f8a..8bb3e3f0557c 100644
+--- a/compiler/rustc_codegen_llvm/src/context.rs
++++ b/compiler/rustc_codegen_llvm/src/context.rs
+@@ -34,7 +34,6 @@
+ use smallvec::SmallVec;
+
+ use libc::c_uint;
+-use std::borrow::Borrow;
+ use std::cell::{Cell, RefCell};
+ use std::ffi::CStr;
+ use std::str;
+@@ -155,25 +154,6 @@
+         }
+     }
+=20
+-    // Ensure the data-layout values hardcoded remain the defaults.
+-    {
+-        let tm =3D =
crate::back::write::create_informational_target_machine(tcx.sess);
+-        llvm::LLVMRustSetDataLayoutFromTargetMachine(llmod, &tm);
+-
+-        let llvm_data_layout =3D llvm::LLVMGetDataLayoutStr(llmod);
+-        let llvm_data_layout =3D =
str::from_utf8(CStr::from_ptr(llvm_data_layout).to_bytes())
+-            .expect("got a non-UTF8 data-layout from LLVM");
+-
+-        if target_data_layout !=3D llvm_data_layout {
+-            tcx.dcx().emit_err(crate::errors::MismatchedDataLayout {
+-                rustc_target: =
sess.opts.target_triple.to_string().as_str(),
+-                rustc_layout: target_data_layout.as_str(),
+-                llvm_target: sess.target.llvm_target.borrow(),
+-                llvm_layout: llvm_data_layout,
+-            });
+-        }
+-    }
+-
+     let data_layout =3D SmallCStr::new(&target_data_layout);
+     llvm::LLVMSetDataLayout(llmod, data_layout.as_ptr());
+
diff --git =
a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-si=
gpipe-ru.patch =
b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-si=
gpipe-ru.patch
new file mode 100644
index 0000000..b42dda8
--- /dev/null
+++ =
b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-si=
gpipe-ru.patch
@@ -0,0 +1,31 @@
+=46rom b4524278985f517b0785b6f64a21380dcf1ff096 Mon Sep 17 00:00:00 =
2001
+From: Peter Tatrai <peter.tatrai.ext@siemens.com>
+Date: Mon, 4 Nov 2024 13:58:16 +0100
+Subject: [PATCH] oeqa/selftest: Increase timeout in process-sigpipe =
rust test
+
+This patch increases the timeout for the process-sigpipe rust test, =
which
+occasionally fails when the server is under heavy load. Increasing the =
timeout
+reduces the likelihood of false negatives under load.
+
+Fixes [YOCTO #15625]
+
+Upstream-Status: Inappropriate [OE testing specific]
+
+Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
+---
+ tests/ui/process/process-sigpipe.rs | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/tests/ui/process/process-sigpipe.rs =
b/tests/ui/process/process-sigpipe.rs
+index 11f363d62..c12d66016 100644
+--- a/tests/ui/process/process-sigpipe.rs
++++ b/tests/ui/process/process-sigpipe.rs
+@@ -23,7 +23,7 @@ use std::thread;
+ fn main() {
+     // Just in case `yes` doesn't check for EPIPE...
+     thread::spawn(|| {
+-        thread::sleep_ms(5000);
++        thread::sleep_ms(10000);
+         process::exit(1);
+     });
+     let output =3D process::Command::new("sh")
diff --git =
a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.patch =
b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.patch
new file mode 100644
index 0000000..e3f57e7
--- /dev/null
+++ =
b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.patch
@@ -0,0 +1,57 @@
+rust: reproducibility issue fix with v1.80
+
+A few crates are using the updated version of the 'cc' crate and this =
is causing the generated object file names containing a unique hashmap =
id.
+By the following changes same hash values will be genarted even for =
diffrent build paths.
+
+Below are the links for detailed bug description & discusssion with =
upstream rust.
+https://github.com/rust-lang/cc-rs/pull/1277
+
+Upstream-Status: Submitted =
[https://github.com/rust-lang/cc-rs/pull/1277]
+Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
+--- a/vendor/cc-1.0.97/src/command_helpers.rs
++++ b/vendor/cc-1.0.97/src/command_helpers.rs
+@@ -257,6 +257,7 @@
+ /// and store them in the output Object.
+ pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> =
Result<Vec<Object>, Error> {
+     let mut objects =3D Vec::with_capacity(files.len());
++    let target_substring =3D ["rustc"];
+     for file in files {
+         let basename =3D file
+             .file_name()
+@@ -277,10 +278,29 @@
+             })?
+             .to_string_lossy();
+
++        // Function to find the position of the first occurrence of =
the target substring
++        fn find_target_position(s: &str, targets: &[&str]) -> =
Option<usize> {
++            let mut pos =3D None;
++            for target in targets {
++                if let Some(index) =3D s.rfind(target) {
++                     //If a target is found and pos is None, set it
++                         if pos.is_none() || index < pos.unwrap() {
++                             pos =3D Some(index);
++                         }
++                }
++            }
++            pos
++        }
++
++        let filtered_dirname =3D if let Some(pos) =3D =
find_target_position(&dirname, &target_substring) {
++            dirname[pos..].to_string()  //Keep everything from the =
target substring onwards
++        }  else {
++            dirname.to_string()  //If target substring is not found, =
keep the original dirname
++        };
+         // Hash the dirname. This should prevent conflicts if we have =
multiple
+         // object files with the same filename in different =
subfolders.
+         let mut hasher =3D hash_map::DefaultHasher::new();
+-        hasher.write(dirname.to_string().as_bytes());
++        hasher.write(filtered_dirname.as_bytes());
+         let obj =3D dst
+             .join(format!("{:016x}-{}", hasher.finish(), basename))
+             .with_extension("o");
+--- a/vendor/cc-1.0.97/.cargo-checksum.json
++++ b/vendor/cc-1.0.97/.cargo-checksum.json
+@@ -1 +1 @@
=
+-{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756c=
da9b6f40d7b0e845","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d0=
59d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2=
ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0=
a7598e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"15afbc35=
930a5a53f00d74a8910cff35caeb5511c26642cffe5630377aced901","src/detect_comp=
iler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf39=
2f5a29","src/lib.rs":"d805931c886be881ed685c3f75b104e96068c4a7e51f48c9a304=
b3fdebcfdcda","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042=
c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0=
295c965c684904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel=
/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063=
","src/parallel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe=
20a76307e31597f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb=
9f52f171648e15e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da668200=
4b5b615dc83250b253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24=
dc4ccdb4326583ef074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"=
be1564756c9f3ef1398eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/win=
dows/find_tools.rs":"06aaf9d6247f407cb6077c68d0c9469f64a098eda2222059e7400=
588e7e05f6a","src/windows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47=
d2f531d626e9ae0c48ba49005","src/windows/registry.rs":"c521b72c825e8095843e=
73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs=
":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/=
windows/vs_instances.rs":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064=
099840893eaa7587","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058c=
fce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"5a440eb39=
d8a0c176b66177e8753186797793bc5d7896292c408fb44c12dfed3"},"package":"099a5=
357d84c4c61eb35fc8eafa9a79a902c2f76911e5747ced4e032edd8d9b4"}
+\ No newline at end of file
=
++{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756c=
da9b6f40d7b0e845","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d0=
59d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2=
ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0=
a7598e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"c2a9981b=
1c9f5430ac2a41f2953064f2383e4064feb281dc76915e4972d52226","src/detect_comp=
iler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf39=
2f5a29","src/lib.rs":"d805931c886be881ed685c3f75b104e96068c4a7e51f48c9a304=
b3fdebcfdcda","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042=
c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0=
295c965c684904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel=
/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063=
","src/parallel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe=
20a76307e31597f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb=
9f52f171648e15e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da668200=
4b5b615dc83250b253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24=
dc4ccdb4326583ef074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"=
be1564756c9f3ef1398eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/win=
dows/find_tools.rs":"06aaf9d6247f407cb6077c68d0c9469f64a098eda2222059e7400=
588e7e05f6a","src/windows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47=
d2f531d626e9ae0c48ba49005","src/windows/registry.rs":"c521b72c825e8095843e=
73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs=
":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/=
windows/vs_instances.rs":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064=
099840893eaa7587","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058c=
fce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"5a440eb39=
d8a0c176b66177e8753186797793bc5d7896292c408fb44c12dfed3"},"package":"099a5=
357d84c4c61eb35fc8eafa9a79a902c2f76911e5747ced4e032edd8d9b4"}
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch =
b/recipes-devtools/rust/files/rust-oe-selftest.patch
new file mode 100644
index 0000000..01c3634
--- /dev/null
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -0,0 +1,403 @@
+Add "[ignore]" tags to the failing unit tests to
+ignore them during rust oe-selftest.
+
+Upstream-Status: Inappropriate [OE testing specific]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs =
b/compiler/rustc_errors/src/markdown/tests/term.rs
+--- a/compiler/rustc_errors/src/markdown/tests/term.rs
++++ b/compiler/rustc_errors/src/markdown/tests/term.rs
+@@ -61,6 +61,7 @@ fn test_wrapping_write() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_output() {
+     // Capture `--bless` when run via ./x
+     let bless =3D std::env::var_os("RUSTC_BLESS").is_some_and(|v| v !=3D=
 "0");
+diff --git a/compiler/rustc_interface/src/tests.rs =
b/compiler/rustc_interface/src/tests.rs
+--- a/compiler/rustc_interface/src/tests.rs
++++ b/compiler/rustc_interface/src/tests.rs
+@@ -137,6 +137,7 @@ fn assert_non_crate_hash_different(x: &Options, y: =
&Options) {
+
+ // When the user supplies --test we should implicitly supply --cfg =
test
+ #[test]
++#[ignore]
+ fn test_switch_implies_cfg_test() {
+     sess_and_cfg(&["--test"], |_sess, cfg| {
+         assert!(cfg.contains(&(sym::test, None)));
+@@ -145,6 +146,7 @@ fn test_switch_implies_cfg_test() {
+
+ // When the user supplies --test and --cfg test, don't implicitly add =
another --cfg test
+ #[test]
++#[ignore]
+ fn test_switch_implies_cfg_test_unless_cfg_test() {
+     sess_and_cfg(&["--test", "--cfg=3Dtest"], |_sess, cfg| {
+         let mut test_items =3D cfg.iter().filter(|&&(name, _)| name =3D=3D=
 sym::test);
+@@ -154,6 +156,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_can_print_warnings() {
+     sess_and_cfg(&["-Awarnings"], |sess, _cfg| {
+         assert!(!sess.dcx().can_emit_warnings());
+diff --git a/library/test/src/stats/tests.rs =
b/library/test/src/stats/tests.rs
+--- a/library/test/src/stats/tests.rs
++++ b/library/test/src/stats/tests.rs
+@@ -40,6 +40,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_min_max_nan() {
+     let xs =3D &[1.0, 2.0, f64::NAN, 3.0, 4.0];
+     let summary =3D Summary::new(xs);
+diff --git a/library/std/src/io/buffered/tests.rs =
b/library/std/src/io/buffered/tests.rs
+index 35a5291a347..5f2858d2505 100644
+--- a/library/std/src/io/buffered/tests.rs
++++ b/library/std/src/io/buffered/tests.rs
+@@ -488,6 +488,7 @@ fn flush(&mut self) -> io::Result<()> {
+ }
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os =3D "emscripten", ignore)]
+ fn panic_in_write_doesnt_flush_in_drop() {
+     static WRITES: AtomicUsize =3D AtomicUsize::new(0);
+diff --git a/library/std/src/io/stdio/tests.rs =
b/library/std/src/io/stdio/tests.rs
+index f89fd27ce6c..79737f5b127 100644
+--- a/library/std/src/io/stdio/tests.rs
++++ b/library/std/src/io/stdio/tests.rs
+@@ -25,6 +25,7 @@ fn stderrlock_unwind_safe() {
+ fn assert_unwind_safe<T: UnwindSafe + RefUnwindSafe>() {}
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os =3D "emscripten", ignore)]
+ fn panic_doesnt_poison() {
+     thread::spawn(|| {
+diff --git a/library/std/src/sync/mpsc/sync_tests.rs =
b/library/std/src/sync/mpsc/sync_tests.rs
+index 945de280f40..1ac7eeabc5c 100644
+--- a/library/std/src/sync/mpsc/sync_tests.rs
++++ b/library/std/src/sync/mpsc/sync_tests.rs
+@@ -252,6 +252,7 @@ fn oneshot_single_thread_send_port_close() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_single_thread_recv_chan_close() {
+     // Receiving on a closed chan will panic
+     let res =3D thread::spawn(move || {
+@@ -347,6 +348,7 @@ fn oneshot_multi_task_recv_then_send() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_task_recv_then_close() {
+     let (tx, rx) =3D sync_channel::<Box<i32>>(0);
+     let _t =3D thread::spawn(move || {
+@@ -371,6 +373,7 @@ fn oneshot_multi_thread_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_send_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) =3D sync_channel::<i32>(0);
+@@ -385,6 +388,7 @@ fn oneshot_multi_thread_send_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_recv_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) =3D sync_channel::<i32>(0);
+diff --git a/library/std/src/sync/mpsc/tests.rs =
b/library/std/src/sync/mpsc/tests.rs
+index ac1a804cf9c..7c687982324 100644
+--- a/library/std/src/sync/mpsc/tests.rs
++++ b/library/std/src/sync/mpsc/tests.rs
+@@ -233,6 +233,7 @@ fn oneshot_single_thread_send_port_close() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_single_thread_recv_chan_close() {
+     // Receiving on a closed chan will panic
+     let res =3D thread::spawn(move || {
+@@ -313,6 +314,7 @@ fn oneshot_multi_task_recv_then_send() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_task_recv_then_close() {
+     let (tx, rx) =3D channel::<Box<i32>>();
+     let _t =3D thread::spawn(move || {
+@@ -337,6 +339,7 @@ fn oneshot_multi_thread_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_send_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) =3D channel::<i32>();
+@@ -351,6 +354,7 @@ fn oneshot_multi_thread_send_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_recv_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) =3D channel::<i32>();
+diff --git a/library/std/src/sync/mutex/tests.rs =
b/library/std/src/sync/mutex/tests.rs
+index 1786a3c09ff..9dcead7092b 100644
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -82,6 +82,7 @@ fn drop(&mut self) {
+ }
+
+ #[test]
++#[ignore]
+ fn test_into_inner_poison() {
+     let m =3D Arc::new(Mutex::new(NonCopy(10)));
+     let m2 =3D m.clone();
+@@ -106,6 +107,7 @@ fn test_get_mut() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_get_mut_poison() {
+     let m =3D Arc::new(Mutex::new(NonCopy(10)));
+     let m2 =3D m.clone();
+@@ -146,6 +148,7 @@ fn test_mutex_arc_condvar() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_arc_condvar_poison() {
+     let packet =3D Packet(Arc::new((Mutex::new(1), Condvar::new())));
+     let packet2 =3D Packet(packet.0.clone());
+@@ -175,6 +178,7 @@ fn test_arc_condvar_poison() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_poison() {
+     let arc =3D Arc::new(Mutex::new(1));
+     assert!(!arc.is_poisoned());
+@@ -220,6 +220,7 @@ fn test_mutex_arc_nested() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_access_in_unwind() {
+     let arc =3D Arc::new(Mutex::new(1));
+     let arc2 =3D arc.clone();
+diff --git a/library/std/src/sync/rwlock/tests.rs =
b/library/std/src/sync/rwlock/tests.rs
+index 1a9d3d3f12f..0a9cfc48806 100644
+--- a/library/std/src/sync/rwlock/tests.rs
++++ b/library/std/src/sync/rwlock/tests.rs
+@@ -47,6 +47,7 @@ fn frob() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_wr() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -72,6 +73,7 @@ fn test_rw_arc_poison_mapped_w_r() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_ww() {
+     let arc =3D Arc::new(RwLock::new(1));
+     assert!(!arc.is_poisoned());
+@@ -100,6 +102,7 @@ fn test_rw_arc_poison_mapped_w_w() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_no_poison_rr() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -127,6 +130,7 @@ fn test_rw_arc_no_poison_mapped_r_r() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_no_poison_rw() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -192,6 +196,7 @@ fn test_rw_arc() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_access_in_unwind() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -275,6 +280,7 @@ fn drop(&mut self) {
+ }
+
+ #[test]
++#[ignore]
+ fn test_into_inner_poison() {
+     let m =3D Arc::new(RwLock::new(NonCopy(10)));
+     let m2 =3D m.clone();
+@@ -299,6 +305,7 @@ fn test_get_mut() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_get_mut_poison() {
+     let m =3D Arc::new(RwLock::new(NonCopy(10)));
+     let m2 =3D m.clone();
+diff --git a/library/std/src/sys/pal/unix/process/process_unix/tests.rs =
b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
+index 0a6c6ec19fc..bec257bc630 100644
+--- a/library/std/src/sys/pal/unix/process/process_unix/tests.rs
++++ b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
+@@ -6,6 +6,7 @@
+ // safety etc., are tested in =
tests/ui/process/process-panic-after-fork.rs
+
+ #[test]
++#[ignore]
+ fn exitstatus_display_tests() {
+     // In practice this is the same on every Unix.
+     // If some weird platform turns out to be different, and this test =
fails, use #[cfg].
+@@ -37,6 +38,7 @@
+ }
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os =3D "emscripten", ignore)]
+ fn test_command_fork_no_unwind() {
+     let got =3D catch_unwind(|| {
+diff --git a/library/std/src/thread/tests.rs =
b/library/std/src/thread/tests.rs
+index 5d6b9e94ee9..a5aacb2eb87 100644
+--- a/library/std/src/thread/tests.rs
++++ b/library/std/src/thread/tests.rs
+@@ -116,6 +116,7 @@ fn test_is_finished() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_join_panic() {
+     match thread::spawn(move || panic!()).join() {
+         result::Result::Err(_) =3D> (),
+@@ -218,6 +219,7 @@ fn test_simple_newsched_spawn() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_message_string_literal() {
+     match thread::spawn(move || {
+         panic!("static string");
+@@ -234,6 +236,7 @@ fn test_try_panic_message_string_literal() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_owned_str() {
+     match thread::spawn(move || {
+         panic_any("owned string".to_string());
+@@ -250,6 +253,7 @@ fn test_try_panic_any_message_owned_str() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_any() {
+     match thread::spawn(move || {
+         panic_any(Box::new(413u16) as Box<dyn Any + Send>);
+@@ -268,6 +272,7 @@ fn test_try_panic_any_message_any() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_unit_struct() {
+     struct Juju;
+
+diff --git a/library/alloc/src/slice/tests.rs =
b/library/alloc/src/slice/tests.rs
+--- a/library/alloc/src/slice/tests.rs
++++ b/library/alloc/src/slice/tests.rs
+@@ -186,6 +186,7 @@
+ std::thread_local!(static SILENCE_PANIC: Cell<bool> =3D =
Cell::new(false));
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os =3D "emscripten", ignore)] // no threads
+ #[cfg_attr(not(panic =3D "unwind"), ignore =3D "test requires =
unwinding support")]
+ fn panic_safe() {
+diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
+--- a/library/test/src/tests.rs
++++ b/library/test/src/tests.rs
+@@ -424,6 +424,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_time_options_threshold() {
+     let unit =3D TimeThreshold::new(Duration::from_millis(50), =
Duration::from_millis(100));
+     let integration =3D TimeThreshold::new(Duration::from_millis(500), =
Duration::from_millis(1000));
+diff --git a/library/std/src/sync/mutex/tests.rs =
b/library/std/src/sync/mutex/tests.rs
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -193,6 +193,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_poison_mapped() {
+     let arc =3D Arc::new(Mutex::new(1));
+     assert!(!arc.is_poisoned());
+diff --git a/library/std/src/sync/mutex/tests.rs =
b/library/std/src/sync/mutex/tests.rs
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -272,6 +272,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn panic_while_mapping_unlocked_poison() {
+     let lock =3D Mutex::new(());
+
+diff --git a/library/std/src/sync/rwlock/tests.rs =
b/library/std/src/sync/rwlock/tests.rs
+--- a/library/std/src/sync/rwlock/tests.rs
++++ b/library/std/src/sync/rwlock/tests.rs
+@@ -59,6 +59,7 @@ fn test_rw_arc_poison_wr() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_mapped_w_r() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -86,6 +87,7 @@ fn test_rw_arc_poison_ww() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_mapped_w_w() {
+     let arc =3D Arc::new(RwLock::new(1));
+     let arc2 =3D arc.clone();
+@@ -431,6 +433,7 @@ fn panic_while_mapping_read_unlocked_no_poison() {
+ }
+
+ #[test]
++#[ignore]
+ fn panic_while_mapping_write_unlocked_poison() {
+     let lock =3D RwLock::new(());
+
+diff --git a/library/core/benches/num/int_log/mod.rs =
b/library/core/benches/num/int_log/mod.rs
+index 3807cd5d76c..018c5c04456 100644
+--- a/library/core/benches/num/int_log/mod.rs
++++ b/library/core/benches/num/int_log/mod.rs
+@@ -98,6 +98,7 @@ fn $random_small(bench: &mut Bencher) {
+         }
+
+         #[bench]
++        #[ignore]
+         fn $geometric(bench: &mut Bencher) {
+             let bases: [$t; 16] =3D [2, 3, 4, 5, 7, 8, 9, 15, 16, 17, =
31, 32, 33, 63, 64, 65];
+             let base_and_numbers: Vec<($t, Vec<$t>)> =3D bases
diff --git =
a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-cod=
egenunits.patch =
b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-cod=
egenunits.patch
new file mode 100644
index 0000000..0aab877
--- /dev/null
+++ =
b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-cod=
egenunits.patch
@@ -0,0 +1,26 @@
+rust: rustdoc reproducibility issue fix
+
+rust: rustdoc reproducibility issue fix
+
+The 'codegen-units' option split the crate into multiple compilation =
units for parallel compilation. Currently, this split is causing the =
rustdoc to generate differnt binary between the builds.
+To fix this the codegen-units & the lto options are disabled.
+
+More info about options:
+https://doc.rust-lang.org/cargo/reference/profiles.html#codegen-units
+https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
+
+Upstream-Status: Inappropriate [oe specific]
+
+Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
+---
+--- a/.cargo/config.toml
++++ b/.cargo/config.toml
+@@ -3,3 +3,7 @@
+
+ [source.vendored-sources]
+ directory =3D "vendor"
++
++[profile.release]
++codegen-units =3D 1
++
+
diff --git =
a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch =
b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
new file mode 100644
index 0000000..16124fa
--- /dev/null
+++ b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
@@ -0,0 +1,70 @@
+Fix cargo build on riscv32
+
+riscv32 support is added to latest rustix already
+therefore this patch is limited to rustix-0.38.19
+once cargo/rust moves beyond rustix-0.38.19 as dependency
+we can remove this patch
+
+Upstream-Status: Inappropriate [Specific to rustix-0.38.19]
+
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+
+--- a/vendor/rustix-0.38.28/src/backend/libc/termios/syscalls.rs
++++ b/vendor/rustix-0.38.28/src/backend/libc/termios/syscalls.rs
+@@ -138,7 +138,7 @@ pub(crate) fn tcsetattr(
+         use crate::utils::default_array;
+         use linux_raw_sys::general::{termios2, BOTHER, CBAUD, =
IBSHIFT};
+=20
+-        #[cfg(not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64")))]
++        #[cfg(not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32")))]
+         use linux_raw_sys::ioctl::{TCSETS, TCSETS2};
+=20
+         // linux-raw-sys' ioctl-generation script for sparc isn't =
working yet,
+@@ -147,6 +147,10 @@ pub(crate) fn tcsetattr(
+         const TCSETS: u32 =3D 0x8024_5409;
+         #[cfg(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))]
+         const TCSETS2: u32 =3D 0x802c_540d;
++        #[cfg(any(target_arch =3D "riscv32"))]
++        const TCSETS: u32 =3D 0x5402;
++        #[cfg(any(target_arch =3D "riscv32"))]
++        const TCSETS2: u32 =3D 0x402C542B;
+=20
+         // Translate from `optional_actions` into an ioctl request =
code. On
+         // MIPS, `optional_actions` already has `TCGETS` added to it.
+--- a/vendor/rustix-0.38.28/.cargo-checksum.json
++++ b/vendor/rustix-0.38.28/.cargo-checksum.json
+@@ -1 +1 @@
=
+-{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e8=
5e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231=
d2fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b05=
32d35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"9dc4e968d6cfe719f1=
548d4ba7f6ccb74eea14beb7f175784b2e58bd29c38df1","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-=
2.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb=
39ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8=
a715d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f=
0a12ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2=
f0c851939b7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd=
28eb5982e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e=
260e67273aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs=
":"5f93559819ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/=
backend/libc/c.rs":"985d441769f1f5d8ed36bce0517504e9a72aaed2ae8bc53235c453=
82dbe4d198","src/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf=
88e5bc8071b9dc98d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9=
151a5a8f17d4d139053b38cffae30701a69ad507f71e666c3dfbca869","src/backend/li=
bc/event/mod.rs":"7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48=
d1c994db","src/backend/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f1=
0dc4e7010942286f6fb7cca93954ab63e01d9","src/backend/libc/event/syscalls.rs=
":"f91bbe7d222987c89a2647817f6819dd536cbc4a685dfb794f403543c32df777","src/=
backend/libc/event/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b=
784583207ad2df473f13","src/backend/libc/event/windows_syscalls.rs":"ebfac6=
65c6676c4b803134ab8806be8aa2e96bdbc7799a19c544cd9069b35787","src/backend/l=
ibc/fs/dir.rs":"9dff590f81fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74=
b091b8","src/backend/libc/fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850=
b466240b0a2296d72b9834c0096968e8","src/backend/libc/fs/makedev.rs":"89c679=
a0ef18dd41b3c6223bce0f329ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/l=
ibc/fs/mod.rs":"3d28b803011b57da6315bb747daf0117218687c0cc610358f5dafddf0b=
7d44d3","src/backend/libc/fs/syscalls.rs":"f2d24c7b287a1e9a424331b60f5c599=
c7588ee4f150fb19bf3e04ba9d83d9df1","src/backend/libc/fs/types.rs":"7099515=
1d71b5ed10099e6b047cc491e1cc1d5f9964d5a863c5c35908f07df26","src/backend/li=
bc/io/errno.rs":"50de98470979377559520ddc35b9777c761248b9083d93d86ff4f101f=
80c724d","src/backend/libc/io/mod.rs":"746647bd864e4ec7717925b6d176cebdb39=
2b7d015070244cc48d92780351dd6","src/backend/libc/io/syscalls.rs":"d77032e4=
d7ec41e441e06181461ffc519d7c6e6dfc720244a55399f0f870bb16","src/backend/lib=
c/io/types.rs":"2efd39bb3df19a9db5496217284f3d2235ddb354fac81dd71861109a56=
bede0b","src/backend/libc/io/windows_syscalls.rs":"fab3fa099aa89cea56a6edc=
651dd37750e581534f4f45b04a7e425f130b08468","src/backend/libc/io_uring/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/io_uring/syscalls.rs":"5af8146d5971c833e6fd657f652c618b31f8=
54e1b0811864fba9b658cb633e19","src/backend/libc/mm/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mm/s=
yscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a05658cea4763207f9250db4f9362de=
2fe","src/backend/libc/mm/types.rs":"55478e173b7d82e2c85934fc0dda79c29f46a=
305228df78f1e90c68ac9d3cfec","src/backend/libc/mod.rs":"087d2676df88510b08=
9255053a4865e62c64172723588386fe8244d2f1a681c4","src/backend/libc/mount/mo=
d.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","=
src/backend/libc/mount/syscalls.rs":"d2d35f7ae989bb52722e28cdbd775243c5d7d=
a9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mount/types.rs":"bf1d541daa=
248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e113","src/backend/libc/=
net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c79cb547f08105087cd0f79d=
5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86b47a2ab34340e3f6cc7b5=
3b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod.rs":"5f0bd80a6575ab=
a4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","src/backend/libc/net/=
msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c41684279d50d8f0a967=
01","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56cd152ed0731f571e4d=
9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net/send_recv.rs":"=
1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f21b36c","src/bac=
kend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d820e238db8cbd05b=
e3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"3d24b9ada485aacaa87=
a41d7ebe13fecddac7465bf1f04e52016da041b71bade","src/backend/libc/net/write=
_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867cb6c89e1fe1=
c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289224ccf40c9=
6fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":"5234b8f1=
bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/backend/lib=
c/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964038f9a=
931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8aa966f=
af3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/li=
bc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6aca=
ba882a68d259","src/backend/libc/pipe/types.rs":"9826013bc5fa18acdcbf09c650=
b96ce301a18ec009139ebaf79162669b1fc2c8","src/backend/libc/prctl/mod.rs":"2=
c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6=
e5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b=
6c61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/proc=
ess/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2=
e97","src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904=
fbf95094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"=
fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/bac=
kend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b=
7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd6=
1acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.=
rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b55123ba94d3d5a95","sr=
c/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a=
5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"35ea6b6e0f8a7fb0=
64fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backend/libc/rand/t=
ypes.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880=
","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e0=
8e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm=
/types.rs":"2206eac8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce5463788382=
33","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e=
85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs":"abe10=
93f3495668d8576ae55073c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/=
libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd7=
3e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/syscal=
ls.rs":"f377dfbf501fbc3cdbc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5",=
"src/backend/libc/thread/futex.rs":"b666828653b12634bbd7fd709acf69641b648e=
c40962a1d4f904c5db14d2eff5","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/th=
read/syscalls.rs":"c8e84ad232ec1317be989529c24e204c51bb4e1e0212de2c1937b00=
bc92e5483","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0=
5718e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"f8=
2e0725c5af8a52e61ee83aad2c77694f2f7a72ac1e6eb284109a70ac6edc38","src/backe=
nd/libc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161=
dc4fd72de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61ac=
b841819bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs=
":"8edf91b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/=
backend/libc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec96=
5f9816366c6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8=
a321c180f52b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_ra=
w/arch/arm.rs":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32=
774db6","src/backend/linux_raw/arch/mips.rs":"24af364aa93fd4b9917639d47333=
6490a143f0d1723b09f388e72d534160ee51","src/backend/linux_raw/arch/mips32r6=
.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc951e1e1318d51759444fb8b658e","s=
rc/backend/linux_raw/arch/mips64.rs":"897da9ddc877963ad59464d7f81dc59df8a7=
e91251e6adea14cfd946e2740a1c","src/backend/linux_raw/arch/mips64r6.rs":"3c=
08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641afb82c46f6aa4f6cd1","src/backe=
nd/linux_raw/arch/mod.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3e=
e642ab0e45dee237d","src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a=
5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_r=
aw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef96=
6bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592=
bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_raw/arch/x8=
6.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54b277cd003eab33316e","=
src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7=
b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"5669c25110b62=
dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","src/backend/linux_ra=
w/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e61c7615947e9ce088=
f0","src/backend/linux_raw/event/epoll.rs":"a102c2d8d7d5d07a5d846f30672153=
269d1762d1d846be1786b22fcf095e8721","src/backend/linux_raw/event/mod.rs":"=
72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/bac=
kend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd00=
45e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"44460=
b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","src/backend/=
linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f=
7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e9720208ece6=
06af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_raw/fs/in=
otify.rs":"713ec3b85f281efca19bc4f495b7537e745fbf1d8c26592c80ceec6fd2ab59b=
5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2=
c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a4=
2bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/=
linux_raw/fs/syscalls.rs":"799630cb4322a3a88558f2f2dd678fdf5bbbd7704098b27=
b2da51705ee050ab1","src/backend/linux_raw/fs/types.rs":"a2b1bb81b9b50e9127=
885b4facb4c26b42e9e7b1374ff38f203bc36b54c41091","src/backend/linux_raw/io/=
errno.rs":"6464c776312d478d9a7aae0e66f624ecbec5e56f1c33713a5f11f2ed5000ba9=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f7=
90a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"568e=
16751191c14bb37f7883b17cb577dc97e09d615d17849c0e7e10e3898f1b","src/backend=
/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf=
6b08a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a075162=
5edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/i=
o_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a0=
6c47b9b18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f=
7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscall=
s.rs":"4e469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","=
src/backend/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f=
3f51cd59c72efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57=
a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw=
/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814961f69c488222=
faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_raw/mount/ty=
pes.rs":"bf3dff5aad1cec9d998496230469958c836b76643f0ad17b0ea29b957357bcca"=
,"src/backend/linux_raw/net/addr.rs":"920373911f43deff1a5e54b9d01a8712e697=
1734f7eba7932dc813b9a30771d6","src/backend/linux_raw/net/mod.rs":"904b2ccd=
4228ebcda25db0223b92fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/lin=
ux_raw/net/msghdr.rs":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd=
286ebc8284acf","src/backend/linux_raw/net/read_sockaddr.rs":"3aac93a52053b=
0ffba7097b4738c3c78aaf0e35884a3451df0628a772b1907eb","src/backend/linux_ra=
w/net/send_recv.rs":"6d5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed00=
8baa01128cc","src/backend/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed=
48dec2f3e01f085222b6cc36f4916b20143e08ae575","src/backend/linux_raw/net/sy=
scalls.rs":"5347eefe5bd3892c9e3d6f91a04b9dd215180b1e148ed2ab7ff20bafbe1617=
ae","src/backend/linux_raw/net/write_sockaddr.rs":"a9374256cb47b3f4d5fec30=
8986a109ce51a521abab31590df1f66c04c07d437","src/backend/linux_raw/param/au=
xv.rs":"ee59d2a618a8c631516814b53655830eeb7ae33cda847d1be382419ba3cdb559",=
"src/backend/linux_raw/param/init.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a=
5fbe723aa3bce2eee5f55e850bde0","src/backend/linux_raw/param/libc_auxv.rs":=
"d7d2c46feba6d383d17d9d25293ab40e39dfefb23533844ee7abaa917923e2b5","src/ba=
ckend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626=
dd9bea03067f28f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a07516=
25edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/=
pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe3=
3c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e=
5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscall=
s.rs":"366c730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a9113b2749e476faf6f83","=
src/backend/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee15e0e3566ceaad39fda44=
e69ed6f94a99fadd9be9b8be09cf","src/backend/linux_raw/prctl/mod.rs":"2c6478=
857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/l=
inux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52e=
fb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_set.rs":"dfdcbdf35=
aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be82dcc0f7c55","src/backend/linu=
x_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15=
c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"be1427f2ab11ce=
35b2746b48351c5a0aff2b71ad2b6471a2876f88cb80c0b7f7","src/backend/linux_raw=
/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a31c07f01953=
ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b0048746087f52=
615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_raw/pty/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","=
src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9=
dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e90c5=
dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31eed=
6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_raw=
/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce225204740ba087e034abce6=
","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.=
rs":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","sr=
c/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414=
113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf=
3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linu=
x_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b31=
82cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c=
9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/syste=
m/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd=
7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f501d9=
803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/types=
.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","s=
rc/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfb=
a1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/ba=
ckend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4=
b2f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90=
b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linu=
x_raw/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b8=
7b139e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7=
452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/tim=
e/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de940484=
5312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a=
81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs"=
:"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/b=
ackend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db=
84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d=
4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_ra=
w/vdso_wrappers.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b7=
5e90784f39a","src/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e210=
16cbd67ac31a8219ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa61=
6898f988fc79b43af24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a4=
95f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"7237847231=
f9d2bd070606262a25de6351de666f95065972967a5f2aae6fef0e","src/cstr.rs":"41a=
f2a4429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/=
eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839=
fa1","src/event/kqueue.rs":"2f776485e16fe57639ad7454886e0ae761880b12297614=
1ac05b4b2e7d82183a","src/event/mod.rs":"7f82a5734d4ba2791054d154273cab48d1=
cce5ca47d680d44a1b71b96eee932c","src/event/pause.rs":"cac3317286478565298a=
40788c1ce13c1b71543078a6f09655419de325022f6f","src/event/poll.rs":"899bbee=
8e565110b2581594e7aa5067a426f859f0a414935e2ce3a9732b6152a","src/event/port=
.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","s=
rc/ffi.rs":"c2b8b38c02d72749aceb715c496726caba1f1fa989ad3856d0103a2fafed89=
ed","src/fs/abs.rs":"99ecd74dd3447d16f142651c74397daca53aa5a21e7daf632937b=
0860ed63a84","src/fs/at.rs":"e2e017e48139101c882df6697f9e4842aed3dbd372c44=
8249c61fd9486163183","src/fs/constants.rs":"23923e0fce3221bdac371fe2d05028=
f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":"d3b644374=
390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/cwd.rs":"=
9f429a79ace6e17455634da09216ee0ad3d067a4541518b3193ae6a8d9ff1e26","src/fs/=
dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5aed69966"=
,"src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d48738050a052c504f745ca67130daa=
6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1cc1b8b76f39c82074624055=
7daa9e14b47b1799120dc39","src/fs/fcntl_apple.rs":"e2f23f038083621bcdecc98d=
02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f61e=
1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":"f=
e53f211e91352d522ac4f3b553a9366506458e2158295a93c5e746618f7a5fe","src/fs/g=
etpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2ed=
d9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a=
6c6222e0cb","src/fs/ioctl.rs":"e798eb41bbc201c375bc295ad2928c2467b45b4fbbf=
f3c82236dccbc0d6391a5","src/fs/makedev.rs":"85520b484cb7c15ab71ea1c368578e=
a3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"a8bf1dced54c=
7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","src/fs/mod.rs":"e92=
dc5dc03b93181256dfdfd059739a4147323507aa1df3a3a9ed46a8816414b","src/fs/mou=
nt.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317be5b",=
"src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696bdaf4=
5af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4028e03ace=
477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e91=
efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741c=
f4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx.rs":"=
f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa2757907aebefeca","src/fs/=
sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b9196234cfd=
","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca6e7=
2d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2eef8=
026407b8d009cb3ceae6b8","src/io/dup.rs":"bbebf4633120e21c7c49ecb93576cffa7=
e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20ba0924e4d514e3c=
876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be5=
5aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"=
0979246359dc2e53c84a4e1aa72044373682154656adafac6103c2ff753d9c8d","src/io/=
is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519=
ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd=
4e0e97015508c0bb8f","src/io/read_write.rs":"bda0a708d86066686fd55a19a89818=
357a6a2ea9072e3853820314aea957868b","src/io_uring.rs":"4e641c9aaeba14890e4=
a354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"32ba339=
9a0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linu=
x.rs":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","=
src/ioctl/mod.rs":"300dd73c0632ff322afc9a267f7be2a497e4681b73a3775b57cff9e=
b500522a5","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0=
b717c45b45447630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0=
c20b0bea6f185b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"7=
7889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/mayb=
e_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9c=
ff3a19049d88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244=
f758f2bc31d3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill=
/no_std/net/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4=
f360f9606dd","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176=
cde76323abcffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/n=
o_std/os/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e8=
0771d507c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9=
afd10269f09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_st=
d/os/fd/raw.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999=
e7c6943","src/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2f=
cc7c825310606b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/wind=
ows/io/mod.rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753=
b92fd2","src/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938=
a49328b5637cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_s=
td/os/windows/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2a=
f4dc5d2c64808308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416=
f8f231a4e778b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_pol=
yfill/std/mod.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b=
3eba115fc","src/mm/madvise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440=
bcf8b12f951f37745bc1dc","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcd=
e1542c17475951e5ed900b86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b9123=
55cedead761211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ec=
bfa9c14edb935404513498b0da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.=
rs":"8073443bd181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","sr=
c/mount/fsopen.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc5=
7a4621e382","src/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0=
d1b68e1f34d12a7136cb19","src/mount/mount_unmount.rs":"8ad11675e5d762d33fbe=
fbed06a6a9f9e52a9b689bd06662446152614321ab77","src/mount/types.rs":"601ae3=
e10b7dc496fed7f3b40a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.r=
s":"a6bc55f9e086caf46a7c00783498d73a328a66f2a991f1ec65d5f13931377b0f","src=
/net/send_recv/mod.rs":"b4794b54dc0f09d99bcbc8fd2cb94f5fb03b39c5f99c1e8ef4=
a5c42dd49a56ea","src/net/send_recv/msg.rs":"5e889662c076db5aa5041a75302aec=
04eb471c41570ffeb22b1a6c0760a3716a","src/net/socket.rs":"623de263730ed4dfe=
5085382f8f27c4953e40570813ab05f5771f790a3f1d544","src/net/socket_addr_any.=
rs":"a9af81e967a91b45e51aec4f46a068fade7035c5d19dfaf05bfdcd3b3c32e9bf","sr=
c/net/socketpair.rs":"56f4885c31d2664cd16e18a9a88792a4912fedd953cec36dba67=
e8581fd57921","src/net/sockopt.rs":"5c778b3d392079858b76d3738ed7117f0136c3=
eda4b49345ae44457ad3403c1a","src/net/types.rs":"d1186106a0a7dab578a9d7f360=
21ba4c77a50585ad155bd531ebb8553dff3366","src/net/wsa.rs":"29856e6d0108be6b=
719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"860=
2af47a39bb340d319807bdecdb9be8b467101a9ed96061277b90234801913","src/param/=
init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55=
","src/param/mod.rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f6417=
5c8b35577288","src/path/arg.rs":"1cbee317403a5d2281a4dea663cee03c9a968042f=
06d55145b8c5521513d393e","src/path/dec_int.rs":"8ff8e14442c46f8e7a9b80d739=
73619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.rs":"6b1b949c94bcc47=
e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd6","src/pid.rs":"f1c486000=
c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs":"9f=
269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a9e11","src/prctl=
.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b7","s=
rc/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b0007835b85c719875=
d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad2705174f7ad50cdc0a=
5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5504a00cb375d=
8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.rs":"e4733f9=
e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc1","src/process/io=
ctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e0236db37e76"=
,"src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94bbfca7e75=
ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe16352eedfc=
a9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909afcb08=
1281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd.rs":=
"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5b5b","src/pr=
ocess/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11dad9e6199c98=
df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f3391189095e1f4f5=
1fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71ea8aa0=
daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procctl.rs"=
:"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea","src/p=
rocess/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75031d5=
e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c07661e7f5=
7c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b66ddc=
74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs":"1=
a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/proc=
ess/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b49=
fcd3","src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f=
9d7e13f687920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7a=
f344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca2=
86b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe77=
673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf1=
567c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b=
96fe8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/sign=
al.rs":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2",=
"src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0=
098bdf0988e662e260","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2=
f3a93c7945c2b8fcb948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccb=
e8ef78fd7f5705b7dfe3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a=
482f8bb53847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":=
"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/te=
rmios/tc.rs":"5a56f252dcde4a841fae47a7a6f7890d81f61385c7b512143ece93896520=
04ae","src/termios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac3=
0e0953220808ef7034","src/termios/types.rs":"b5671eedf541754c54f680002bafed=
1adbabce172d09d7c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271eb3e68=
31d9b0c3a01bfddbe4bd69dee237bbaa059884de452b29e79","src/thread/futex.rs":"=
985f9a0dce1e2a4892ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thr=
ead/id.rs":"ad72db4fea9fccb728310bbfd01ef8c00f6cc60fa2a750f6349646a134f700=
9b","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154=
791fd38438e2ca7db1","src/thread/mod.rs":"98634ece0b882f123ad887017692f2a4d=
94a23a1dec278ed660b3497cac5cceb","src/thread/prctl.rs":"ebc89b731eb8fd1a8f=
82a50dbba849061476a4537bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9=
142b1f3a5b3f329683be185f960c50e5c1636149e91fbf59e88a897fc607d","src/time/c=
lock.rs":"e59a29f1bed8c31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f=
","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211=
e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96c=
c2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153290db=
920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b1=
50f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6=
cc350cdd58c9084b5c3a5a708eeecd769783debdbcbaef442182","src/weak.rs":"c7cf0=
3bf2aeba494b1999ab32183fa8c603ab72e254c0e312a67f168877e410d"},"package":"7=
2e572a5e8ca657d7366229cdde4bd14c4eb5499a9573d4d366fe1b599daa316"}
+\ No newline at end of file
=
++{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e8=
5e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231=
d2fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b05=
32d35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"9dc4e968d6cfe719f1=
548d4ba7f6ccb74eea14beb7f175784b2e58bd29c38df1","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-=
2.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb=
39ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8=
a715d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f=
0a12ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2=
f0c851939b7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd=
28eb5982e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e=
260e67273aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs=
":"5f93559819ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/=
backend/libc/c.rs":"a0827e017f2bd4a406af521a862ba7783542dd2ebf2d29ec8a62f9=
e0b991102c","src/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf=
88e5bc8071b9dc98d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9=
151a5a8f17d4d139053b38cffae30701a69ad507f71e666c3dfbca869","src/backend/li=
bc/event/mod.rs":"7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48=
d1c994db","src/backend/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f1=
0dc4e7010942286f6fb7cca93954ab63e01d9","src/backend/libc/event/syscalls.rs=
":"f91bbe7d222987c89a2647817f6819dd536cbc4a685dfb794f403543c32df777","src/=
backend/libc/event/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b=
784583207ad2df473f13","src/backend/libc/event/windows_syscalls.rs":"ebfac6=
65c6676c4b803134ab8806be8aa2e96bdbc7799a19c544cd9069b35787","src/backend/l=
ibc/fs/dir.rs":"9dff590f81fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74=
b091b8","src/backend/libc/fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850=
b466240b0a2296d72b9834c0096968e8","src/backend/libc/fs/makedev.rs":"89c679=
a0ef18dd41b3c6223bce0f329ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/l=
ibc/fs/mod.rs":"3d28b803011b57da6315bb747daf0117218687c0cc610358f5dafddf0b=
7d44d3","src/backend/libc/fs/syscalls.rs":"f2d24c7b287a1e9a424331b60f5c599=
c7588ee4f150fb19bf3e04ba9d83d9df1","src/backend/libc/fs/types.rs":"7099515=
1d71b5ed10099e6b047cc491e1cc1d5f9964d5a863c5c35908f07df26","src/backend/li=
bc/io/errno.rs":"50de98470979377559520ddc35b9777c761248b9083d93d86ff4f101f=
80c724d","src/backend/libc/io/mod.rs":"746647bd864e4ec7717925b6d176cebdb39=
2b7d015070244cc48d92780351dd6","src/backend/libc/io/syscalls.rs":"d77032e4=
d7ec41e441e06181461ffc519d7c6e6dfc720244a55399f0f870bb16","src/backend/lib=
c/io/types.rs":"2efd39bb3df19a9db5496217284f3d2235ddb354fac81dd71861109a56=
bede0b","src/backend/libc/io/windows_syscalls.rs":"fab3fa099aa89cea56a6edc=
651dd37750e581534f4f45b04a7e425f130b08468","src/backend/libc/io_uring/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/io_uring/syscalls.rs":"5af8146d5971c833e6fd657f652c618b31f8=
54e1b0811864fba9b658cb633e19","src/backend/libc/mm/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mm/s=
yscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a05658cea4763207f9250db4f9362de=
2fe","src/backend/libc/mm/types.rs":"55478e173b7d82e2c85934fc0dda79c29f46a=
305228df78f1e90c68ac9d3cfec","src/backend/libc/mod.rs":"087d2676df88510b08=
9255053a4865e62c64172723588386fe8244d2f1a681c4","src/backend/libc/mount/mo=
d.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","=
src/backend/libc/mount/syscalls.rs":"d2d35f7ae989bb52722e28cdbd775243c5d7d=
a9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mount/types.rs":"bf1d541daa=
248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e113","src/backend/libc/=
net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c79cb547f08105087cd0f79d=
5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86b47a2ab34340e3f6cc7b5=
3b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod.rs":"5f0bd80a6575ab=
a4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","src/backend/libc/net/=
msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c41684279d50d8f0a967=
01","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56cd152ed0731f571e4d=
9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net/send_recv.rs":"=
1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f21b36c","src/bac=
kend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d820e238db8cbd05b=
e3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"3d24b9ada485aacaa87=
a41d7ebe13fecddac7465bf1f04e52016da041b71bade","src/backend/libc/net/write=
_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867cb6c89e1fe1=
c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289224ccf40c9=
6fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":"5234b8f1=
bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/backend/lib=
c/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964038f9a=
931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8aa966f=
af3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/li=
bc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6aca=
ba882a68d259","src/backend/libc/pipe/types.rs":"9826013bc5fa18acdcbf09c650=
b96ce301a18ec009139ebaf79162669b1fc2c8","src/backend/libc/prctl/mod.rs":"2=
c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6=
e5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b=
6c61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/proc=
ess/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2=
e97","src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904=
fbf95094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"=
fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/bac=
kend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b=
7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd6=
1acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.=
rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b55123ba94d3d5a95","sr=
c/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a=
5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"35ea6b6e0f8a7fb0=
64fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backend/libc/rand/t=
ypes.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880=
","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e0=
8e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm=
/types.rs":"2206eac8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce5463788382=
33","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e=
85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs":"abe10=
93f3495668d8576ae55073c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/=
libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd7=
3e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/syscal=
ls.rs":"3149bd6254589a39d03904de21257e92fcd8d2754167f917d45b0d74d410174c",=
"src/backend/libc/thread/futex.rs":"b666828653b12634bbd7fd709acf69641b648e=
c40962a1d4f904c5db14d2eff5","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/th=
read/syscalls.rs":"c8e84ad232ec1317be989529c24e204c51bb4e1e0212de2c1937b00=
bc92e5483","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0=
5718e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"f8=
2e0725c5af8a52e61ee83aad2c77694f2f7a72ac1e6eb284109a70ac6edc38","src/backe=
nd/libc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161=
dc4fd72de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61ac=
b841819bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs=
":"8edf91b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/=
backend/libc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec96=
5f9816366c6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8=
a321c180f52b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_ra=
w/arch/arm.rs":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32=
774db6","src/backend/linux_raw/arch/mips.rs":"24af364aa93fd4b9917639d47333=
6490a143f0d1723b09f388e72d534160ee51","src/backend/linux_raw/arch/mips32r6=
.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc951e1e1318d51759444fb8b658e","s=
rc/backend/linux_raw/arch/mips64.rs":"897da9ddc877963ad59464d7f81dc59df8a7=
e91251e6adea14cfd946e2740a1c","src/backend/linux_raw/arch/mips64r6.rs":"3c=
08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641afb82c46f6aa4f6cd1","src/backe=
nd/linux_raw/arch/mod.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3e=
e642ab0e45dee237d","src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a=
5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_r=
aw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef96=
6bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592=
bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_raw/arch/x8=
6.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54b277cd003eab33316e","=
src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7=
b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"5669c25110b62=
dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","src/backend/linux_ra=
w/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e61c7615947e9ce088=
f0","src/backend/linux_raw/event/epoll.rs":"a102c2d8d7d5d07a5d846f30672153=
269d1762d1d846be1786b22fcf095e8721","src/backend/linux_raw/event/mod.rs":"=
72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/bac=
kend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd00=
45e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"44460=
b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","src/backend/=
linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f=
7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e9720208ece6=
06af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_raw/fs/in=
otify.rs":"713ec3b85f281efca19bc4f495b7537e745fbf1d8c26592c80ceec6fd2ab59b=
5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2=
c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a4=
2bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/=
linux_raw/fs/syscalls.rs":"799630cb4322a3a88558f2f2dd678fdf5bbbd7704098b27=
b2da51705ee050ab1","src/backend/linux_raw/fs/types.rs":"a2b1bb81b9b50e9127=
885b4facb4c26b42e9e7b1374ff38f203bc36b54c41091","src/backend/linux_raw/io/=
errno.rs":"6464c776312d478d9a7aae0e66f624ecbec5e56f1c33713a5f11f2ed5000ba9=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f7=
90a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"568e=
16751191c14bb37f7883b17cb577dc97e09d615d17849c0e7e10e3898f1b","src/backend=
/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf=
6b08a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a075162=
5edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/i=
o_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a0=
6c47b9b18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f=
7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscall=
s.rs":"4e469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","=
src/backend/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f=
3f51cd59c72efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57=
a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw=
/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814961f69c488222=
faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_raw/mount/ty=
pes.rs":"bf3dff5aad1cec9d998496230469958c836b76643f0ad17b0ea29b957357bcca"=
,"src/backend/linux_raw/net/addr.rs":"920373911f43deff1a5e54b9d01a8712e697=
1734f7eba7932dc813b9a30771d6","src/backend/linux_raw/net/mod.rs":"904b2ccd=
4228ebcda25db0223b92fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/lin=
ux_raw/net/msghdr.rs":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd=
286ebc8284acf","src/backend/linux_raw/net/read_sockaddr.rs":"3aac93a52053b=
0ffba7097b4738c3c78aaf0e35884a3451df0628a772b1907eb","src/backend/linux_ra=
w/net/send_recv.rs":"6d5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed00=
8baa01128cc","src/backend/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed=
48dec2f3e01f085222b6cc36f4916b20143e08ae575","src/backend/linux_raw/net/sy=
scalls.rs":"5347eefe5bd3892c9e3d6f91a04b9dd215180b1e148ed2ab7ff20bafbe1617=
ae","src/backend/linux_raw/net/write_sockaddr.rs":"a9374256cb47b3f4d5fec30=
8986a109ce51a521abab31590df1f66c04c07d437","src/backend/linux_raw/param/au=
xv.rs":"ee59d2a618a8c631516814b53655830eeb7ae33cda847d1be382419ba3cdb559",=
"src/backend/linux_raw/param/init.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a=
5fbe723aa3bce2eee5f55e850bde0","src/backend/linux_raw/param/libc_auxv.rs":=
"d7d2c46feba6d383d17d9d25293ab40e39dfefb23533844ee7abaa917923e2b5","src/ba=
ckend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626=
dd9bea03067f28f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a07516=
25edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/=
pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe3=
3c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e=
5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscall=
s.rs":"366c730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a9113b2749e476faf6f83","=
src/backend/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee15e0e3566ceaad39fda44=
e69ed6f94a99fadd9be9b8be09cf","src/backend/linux_raw/prctl/mod.rs":"2c6478=
857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/l=
inux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52e=
fb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_set.rs":"dfdcbdf35=
aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be82dcc0f7c55","src/backend/linu=
x_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15=
c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"be1427f2ab11ce=
35b2746b48351c5a0aff2b71ad2b6471a2876f88cb80c0b7f7","src/backend/linux_raw=
/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a31c07f01953=
ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b0048746087f52=
615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_raw/pty/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","=
src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9=
dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e90c5=
dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31eed=
6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_raw=
/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce225204740ba087e034abce6=
","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.=
rs":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","sr=
c/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414=
113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf=
3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linu=
x_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b31=
82cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c=
9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/syste=
m/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd=
7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f501d9=
803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/types=
.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","s=
rc/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfb=
a1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/ba=
ckend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4=
b2f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90=
b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linu=
x_raw/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b8=
7b139e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7=
452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/tim=
e/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de940484=
5312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a=
81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs"=
:"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/b=
ackend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db=
84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d=
4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_ra=
w/vdso_wrappers.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b7=
5e90784f39a","src/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e210=
16cbd67ac31a8219ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa61=
6898f988fc79b43af24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a4=
95f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"7237847231=
f9d2bd070606262a25de6351de666f95065972967a5f2aae6fef0e","src/cstr.rs":"41a=
f2a4429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/=
eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839=
fa1","src/event/kqueue.rs":"2f776485e16fe57639ad7454886e0ae761880b12297614=
1ac05b4b2e7d82183a","src/event/mod.rs":"7f82a5734d4ba2791054d154273cab48d1=
cce5ca47d680d44a1b71b96eee932c","src/event/pause.rs":"cac3317286478565298a=
40788c1ce13c1b71543078a6f09655419de325022f6f","src/event/poll.rs":"899bbee=
8e565110b2581594e7aa5067a426f859f0a414935e2ce3a9732b6152a","src/event/port=
.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","s=
rc/ffi.rs":"c2b8b38c02d72749aceb715c496726caba1f1fa989ad3856d0103a2fafed89=
ed","src/fs/abs.rs":"99ecd74dd3447d16f142651c74397daca53aa5a21e7daf632937b=
0860ed63a84","src/fs/at.rs":"e2e017e48139101c882df6697f9e4842aed3dbd372c44=
8249c61fd9486163183","src/fs/constants.rs":"23923e0fce3221bdac371fe2d05028=
f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":"d3b644374=
390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/cwd.rs":"=
9f429a79ace6e17455634da09216ee0ad3d067a4541518b3193ae6a8d9ff1e26","src/fs/=
dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5aed69966"=
,"src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d48738050a052c504f745ca67130daa=
6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1cc1b8b76f39c82074624055=
7daa9e14b47b1799120dc39","src/fs/fcntl_apple.rs":"e2f23f038083621bcdecc98d=
02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f61e=
1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":"f=
e53f211e91352d522ac4f3b553a9366506458e2158295a93c5e746618f7a5fe","src/fs/g=
etpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2ed=
d9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a=
6c6222e0cb","src/fs/ioctl.rs":"71327efab1e73c7844c681ea7e822b5124738196b2f=
c687aabc786b90be9fe32","src/fs/makedev.rs":"85520b484cb7c15ab71ea1c368578e=
a3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"a8bf1dced54c=
7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","src/fs/mod.rs":"e92=
dc5dc03b93181256dfdfd059739a4147323507aa1df3a3a9ed46a8816414b","src/fs/mou=
nt.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317be5b",=
"src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696bdaf4=
5af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4028e03ace=
477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e91=
efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741c=
f4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx.rs":"=
f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa2757907aebefeca","src/fs/=
sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b9196234cfd=
","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca6e7=
2d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2eef8=
026407b8d009cb3ceae6b8","src/io/dup.rs":"bbebf4633120e21c7c49ecb93576cffa7=
e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20ba0924e4d514e3c=
876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be5=
5aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"=
0979246359dc2e53c84a4e1aa72044373682154656adafac6103c2ff753d9c8d","src/io/=
is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519=
ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd=
4e0e97015508c0bb8f","src/io/read_write.rs":"bda0a708d86066686fd55a19a89818=
357a6a2ea9072e3853820314aea957868b","src/io_uring.rs":"4e641c9aaeba14890e4=
a354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"32ba339=
9a0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linu=
x.rs":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","=
src/ioctl/mod.rs":"300dd73c0632ff322afc9a267f7be2a497e4681b73a3775b57cff9e=
b500522a5","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0=
b717c45b45447630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0=
c20b0bea6f185b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"7=
7889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/mayb=
e_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9c=
ff3a19049d88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244=
f758f2bc31d3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill=
/no_std/net/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4=
f360f9606dd","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176=
cde76323abcffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/n=
o_std/os/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e8=
0771d507c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9=
afd10269f09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_st=
d/os/fd/raw.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999=
e7c6943","src/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2f=
cc7c825310606b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/wind=
ows/io/mod.rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753=
b92fd2","src/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938=
a49328b5637cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_s=
td/os/windows/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2a=
f4dc5d2c64808308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416=
f8f231a4e778b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_pol=
yfill/std/mod.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b=
3eba115fc","src/mm/madvise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440=
bcf8b12f951f37745bc1dc","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcd=
e1542c17475951e5ed900b86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b9123=
55cedead761211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ec=
bfa9c14edb935404513498b0da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.=
rs":"8073443bd181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","sr=
c/mount/fsopen.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc5=
7a4621e382","src/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0=
d1b68e1f34d12a7136cb19","src/mount/mount_unmount.rs":"8ad11675e5d762d33fbe=
fbed06a6a9f9e52a9b689bd06662446152614321ab77","src/mount/types.rs":"601ae3=
e10b7dc496fed7f3b40a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.r=
s":"a6bc55f9e086caf46a7c00783498d73a328a66f2a991f1ec65d5f13931377b0f","src=
/net/send_recv/mod.rs":"b4794b54dc0f09d99bcbc8fd2cb94f5fb03b39c5f99c1e8ef4=
a5c42dd49a56ea","src/net/send_recv/msg.rs":"5e889662c076db5aa5041a75302aec=
04eb471c41570ffeb22b1a6c0760a3716a","src/net/socket.rs":"623de263730ed4dfe=
5085382f8f27c4953e40570813ab05f5771f790a3f1d544","src/net/socket_addr_any.=
rs":"a9af81e967a91b45e51aec4f46a068fade7035c5d19dfaf05bfdcd3b3c32e9bf","sr=
c/net/socketpair.rs":"56f4885c31d2664cd16e18a9a88792a4912fedd953cec36dba67=
e8581fd57921","src/net/sockopt.rs":"5c778b3d392079858b76d3738ed7117f0136c3=
eda4b49345ae44457ad3403c1a","src/net/types.rs":"d1186106a0a7dab578a9d7f360=
21ba4c77a50585ad155bd531ebb8553dff3366","src/net/wsa.rs":"29856e6d0108be6b=
719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"860=
2af47a39bb340d319807bdecdb9be8b467101a9ed96061277b90234801913","src/param/=
init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55=
","src/param/mod.rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f6417=
5c8b35577288","src/path/arg.rs":"1cbee317403a5d2281a4dea663cee03c9a968042f=
06d55145b8c5521513d393e","src/path/dec_int.rs":"8ff8e14442c46f8e7a9b80d739=
73619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.rs":"6b1b949c94bcc47=
e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd6","src/pid.rs":"f1c486000=
c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs":"9f=
269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a9e11","src/prctl=
.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b7","s=
rc/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b0007835b85c719875=
d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad2705174f7ad50cdc0a=
5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5504a00cb375d=
8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.rs":"e4733f9=
e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc1","src/process/io=
ctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e0236db37e76"=
,"src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94bbfca7e75=
ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe16352eedfc=
a9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909afcb08=
1281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd.rs":=
"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5b5b","src/pr=
ocess/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11dad9e6199c98=
df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f3391189095e1f4f5=
1fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71ea8aa0=
daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procctl.rs"=
:"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea","src/p=
rocess/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75031d5=
e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c07661e7f5=
7c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b66ddc=
74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs":"1=
a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/proc=
ess/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b49=
fcd3","src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f=
9d7e13f687920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7a=
f344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca2=
86b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe77=
673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf1=
567c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b=
96fe8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/sign=
al.rs":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2",=
"src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0=
098bdf0988e662e260","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2=
f3a93c7945c2b8fcb948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccb=
e8ef78fd7f5705b7dfe3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a=
482f8bb53847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":=
"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/te=
rmios/tc.rs":"5a56f252dcde4a841fae47a7a6f7890d81f61385c7b512143ece93896520=
04ae","src/termios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac3=
0e0953220808ef7034","src/termios/types.rs":"b5671eedf541754c54f680002bafed=
1adbabce172d09d7c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271eb3e68=
31d9b0c3a01bfddbe4bd69dee237bbaa059884de452b29e79","src/thread/futex.rs":"=
985f9a0dce1e2a4892ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thr=
ead/id.rs":"ad72db4fea9fccb728310bbfd01ef8c00f6cc60fa2a750f6349646a134f700=
9b","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154=
791fd38438e2ca7db1","src/thread/mod.rs":"98634ece0b882f123ad887017692f2a4d=
94a23a1dec278ed660b3497cac5cceb","src/thread/prctl.rs":"ebc89b731eb8fd1a8f=
82a50dbba849061476a4537bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9=
142b1f3a5b3f329683be185f960c50e5c1636149e91fbf59e88a897fc607d","src/time/c=
lock.rs":"e59a29f1bed8c31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f=
","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211=
e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96c=
c2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153290db=
920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b1=
50f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6=
cc350cdd58c9084b5c3a5a708eeecd769783debdbcbaef442182","src/weak.rs":"c7cf0=
3bf2aeba494b1999ab32183fa8c603ab72e254c0e312a67f168877e410d"},"package":"7=
2e572a5e8ca657d7366229cdde4bd14c4eb5499a9573d4d366fe1b599daa316"}
+--- a/vendor/rustix-0.38.28/src/fs/ioctl.rs
++++ b/vendor/rustix-0.38.28/src/fs/ioctl.rs
+@@ -48,7 +48,7 @@ pub fn ioctl_blkpbszget<Fd: AsFd>(fd: Fd
+ ///  - [Linux]
+ ///
+ /// [Linux]: =
https://man7.org/linux/man-pages/man2/ioctl_ficlone.2.html
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D=
 "sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D=
 "sparc64", target_arch =3D "riscv32"))))]
+ #[inline]
+ #[doc(alias =3D "FICLONE")]
+ pub fn ioctl_ficlone<Fd: AsFd, SrcFd: AsFd>(fd: Fd, src_fd: SrcFd) -> =
io::Result<()> {
+@@ -77,7 +77,7 @@ unsafe impl ioctl::Ioctl for Ficlone<'_>
+     type Output =3D ();
+=20
+     const IS_MUTATING: bool =3D false;
+-    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(c::FICLONE as =
ioctl::RawOpcode);
++    const OPCODE: ioctl::Opcode =3D =
ioctl::Opcode::old(linux_raw_sys::ioctl::FICLONE as ioctl::RawOpcode);
+=20
+     fn as_ptr(&mut self) -> *mut c::c_void {
+         self.0.as_raw_fd() as *mut c::c_void
+--- a/vendor/rustix-0.38.28/src/backend/libc/c.rs=20
++++ b/vendor/rustix-0.38.28/src/backend/libc/c.rs
+@@ -6,6 +6,8 @@
+ // things below.
+ pub(crate) use libc::*;
+=20
++use linux_raw_sys::ioctl::FICLONE;
++
+ /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs =
filesystem.
+ #[cfg(all(linux_kernel, target_env =3D "musl"))]
+ pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
diff --git a/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch =
b/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
new file mode 100644
index 0000000..37ed5d6
--- /dev/null
+++ b/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
@@ -0,0 +1,33 @@
+Use FICLONE from linux_raw_sys module
+
+Upstream-Status: Pending
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+--- a/vendor/rustix-0.38.32/src/backend/libc/c.rs
++++ b/vendor/rustix-0.38.32/src/backend/libc/c.rs
+@@ -6,6 +6,8 @@
+ // things below.
+ pub(crate) use libc::*;
+=20
++use linux_raw_sys::ioctl::FICLONE;
++
+ /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs =
filesystem.
+ #[cfg(all(linux_kernel, target_env =3D "musl"))]
+ pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
+--- a/vendor/rustix-0.38.32/.cargo-checksum.json
++++ b/vendor/rustix-0.38.32/.cargo-checksum.json
+@@ -1 +1 @@
=
+-{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e8=
5e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231=
d2fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b05=
32d35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"5e3eef3032f414825f=
b0d0a4d221d4c15989905fe6c675d6d360da3430f97003","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-=
2.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb=
39ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8=
a715d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f=
0a12ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2=
f0c851939b7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd=
28eb5982e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e=
260e67273aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs=
":"5f93559819ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/=
backend/libc/c.rs":"f3ea8ee60f4b79196914ef4782b6493466e5755ef922f6ff2b7cbf=
9671332ff5","src/backend/libc/conv.rs":"a254fa84164286ee6be64f49b5bd5f7e2f=
d503ebd5ca9076dad4c2507a351dc2","src/backend/libc/event/epoll.rs":"93d3eb9=
e0e397afc3c44797b315ce92ff8b22f2372812b19cec9e063c55032c3","src/backend/li=
bc/event/mod.rs":"ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4=
677ec231","src/backend/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f1=
0dc4e7010942286f6fb7cca93954ab63e01d9","src/backend/libc/event/syscalls.rs=
":"f91bbe7d222987c89a2647817f6819dd536cbc4a685dfb794f403543c32df777","src/=
backend/libc/event/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b=
784583207ad2df473f13","src/backend/libc/event/windows_syscalls.rs":"ebfac6=
65c6676c4b803134ab8806be8aa2e96bdbc7799a19c544cd9069b35787","src/backend/l=
ibc/fs/dir.rs":"3c43768f9e56cb4297594c05d91a52be20029dd2b3e0b91f6b1a13f31e=
595fe2","src/backend/libc/fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850=
b466240b0a2296d72b9834c0096968e8","src/backend/libc/fs/makedev.rs":"89c679=
a0ef18dd41b3c6223bce0f329ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/l=
ibc/fs/mod.rs":"3d28b803011b57da6315bb747daf0117218687c0cc610358f5dafddf0b=
7d44d3","src/backend/libc/fs/syscalls.rs":"23df7677c327225d4830262961a44b6=
3b5e182c80c6bb885e0629a5c0bcfc31a","src/backend/libc/fs/types.rs":"d6b031c=
83e333dc5ff52f3bb0eaa92ba2d05a72fa0540c73e3b15e63f67e6812","src/backend/li=
bc/io/errno.rs":"bac592ece7b44692237a350ff4905bfad30fa042d1e8126e5229e0291=
3fb1c9d","src/backend/libc/io/mod.rs":"746647bd864e4ec7717925b6d176cebdb39=
2b7d015070244cc48d92780351dd6","src/backend/libc/io/syscalls.rs":"c93a7867=
fc13eecc953c6335fd79c37d4d1734d3a06e13e5d7e08bd985c66326","src/backend/lib=
c/io/types.rs":"2efd39bb3df19a9db5496217284f3d2235ddb354fac81dd71861109a56=
bede0b","src/backend/libc/io/windows_syscalls.rs":"fab3fa099aa89cea56a6edc=
651dd37750e581534f4f45b04a7e425f130b08468","src/backend/libc/io_uring/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/io_uring/syscalls.rs":"5af8146d5971c833e6fd657f652c618b31f8=
54e1b0811864fba9b658cb633e19","src/backend/libc/mm/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mm/s=
yscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a05658cea4763207f9250db4f9362de=
2fe","src/backend/libc/mm/types.rs":"55478e173b7d82e2c85934fc0dda79c29f46a=
305228df78f1e90c68ac9d3cfec","src/backend/libc/mod.rs":"087d2676df88510b08=
9255053a4865e62c64172723588386fe8244d2f1a681c4","src/backend/libc/mount/mo=
d.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","=
src/backend/libc/mount/syscalls.rs":"d2d35f7ae989bb52722e28cdbd775243c5d7d=
a9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mount/types.rs":"bf1d541daa=
248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e113","src/backend/libc/=
net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c79cb547f08105087cd0f79d=
5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86b47a2ab34340e3f6cc7b5=
3b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod.rs":"562d23225d6dba=
8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","src/backend/libc/net/=
msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d10437bb19bf7496666bd6d=
e6","src/backend/libc/net/netdevice.rs":"c6c3cd11b0181a74243705438fbf0fede=
b02d4201ff3ad9f45a084fbd57a9c21","src/backend/libc/net/read_sockaddr.rs":"=
61fc1c744b376d57a18d78d8f7ab469236c614f5fa7aeaf37a636e6a967b9066","src/bac=
kend/libc/net/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c=
56d164ccda38f21b36c","src/backend/libc/net/sockopt.rs":"d53d52f1c55f522c1d=
0de5e446df3017757b08270c0a0b593a583fd6c56b0876","src/backend/libc/net/sysc=
alls.rs":"1412f9deed57ac0909b0b1c3ac3e5fb7d5c31ab356212c9131e33378c342d2a5=
","src/backend/libc/net/write_sockaddr.rs":"bee221d0a1fedf4ddcff045faa2702=
c1f1e68b4d6c3f2f7b079d888e0ef9da56","src/backend/libc/param/auxv.rs":"fc94=
76c85482b1d44190289224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend=
/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354=
bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841=
819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs":"49=
ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backe=
nd/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489=
fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d=
1e48be5c1039be414f8ef7d5a6acaba882a68d259","src/backend/libc/pipe/types.rs=
":"9826013bc5fa18acdcbf09c650b96ce301a18ec009139ebaf79162669b1fc2c8","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fae=
ded15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a75550=
98dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/proces=
s/cpu_set.rs":"b3d36b01b53b0b6c61a20ed8a69d48eccdd90cc17f82f2926ef1e844f00=
2d0b7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d=
348da147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"=
f08a76a5f32e40a69c99261eeabb405a58476ef9e85ae142f2fce19679a42ec4","src/bac=
kend/libc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80=
c758b748bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb=
3965f74fd76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod=
.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a=
8f4fe18b55123ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a=
93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/s=
yscalls.rs":"35ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db8=
5e7","src/backend/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be2=
8a38b7b07a705ec605b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf385=
3d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/sh=
m/syscalls.rs":"60d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e4923=
1c268c","src/backend/libc/shm/types.rs":"2206eac8ee74951b995e1e80f10bf235c=
c6b04e0a099f4adefce546378838233","src/backend/libc/system/mod.rs":"38563ea=
68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backend/li=
bc/system/syscalls.rs":"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44c=
da53bc9d6fcf03","src/backend/libc/system/types.rs":"6871e16aee14fe2ae03cea=
798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/backend/libc/termios/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cdbc9e190dd650c8141c00=
c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/futex.rs":"b66682865=
3b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5","src/backend/libc=
/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302=
a679fff","src/backend/libc/thread/syscalls.rs":"435392788b133b83eaf73913a3=
adee5b244b471df316dec02469832cfdc71160","src/backend/libc/time/mod.rs":"38=
563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backe=
nd/libc/time/syscalls.rs":"bf847e94cc156bdb553755baa88dac240db4dcaf690f303=
b0f205777c5a9cdfc","src/backend/libc/time/types.rs":"d0307994ffddd3f21f702=
d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/ugid/mod.rs=
":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/=
backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b0723a371677f=
29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"502da2ed3cd6ca99b=
b7ee08b0b30e25c212632885cec965f9816366c6b931ac6","src/backend/linux_raw/ar=
ch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caeae63c24=
587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d420911837=
65f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.rs":=
"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src/ba=
ckend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc95=
1e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9d=
dc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641a=
fb82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d=
170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arc=
h/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07=
da74477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2=
b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thum=
b.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","=
src/backend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db6=
5ac9fe54b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e92903=
6a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/l=
inux_raw/c.rs":"db66abe9b91ce0f16dd71762744013046f29542a46a577454c9ff063e9=
cb649c","src/backend/linux_raw/conv.rs":"48a261b8dd6182ce876690cd4946d00c3=
697bcf7c3d89a46e3a3d6f50d39c2db","src/backend/linux_raw/event/epoll.rs":"a=
102c2d8d7d5d07a5d846f30672153269d1762d1d846be1786b22fcf095e8721","src/back=
end/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe9=
16faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e=
30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_=
raw/event/syscalls.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5=
a36726b8db2d41","src/backend/linux_raw/event/types.rs":"0551b18f982e233a0a=
06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/=
dir.rs":"3107b07276f171a5837bd37a9c1e05151ca21d59ae2b85afd2c6e59e721cdcf2"=
,"src/backend/linux_raw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7537e74=
5fbf1d8c26592c80ceec6fd2ab59b5","src/backend/linux_raw/fs/makedev.rs":"c6b=
4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backen=
d/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca09=
21f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"dc7475b41ef2c5e0fb=
860ddbbcb05a966afb2b699f4f5fc3e67945936809d71e","src/backend/linux_raw/fs/=
types.rs":"4742cc26f754809664d49f3ff70e0f6eab131dd2d1174ba1332c5d686a98eda=
9","src/backend/linux_raw/io/errno.rs":"befa94275b30e8262718e8c9e9662b0852=
6ec55779861dab4e2e499daa3e097d","src/backend/linux_raw/io/mod.rs":"7ae2324=
427892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/li=
nux_raw/io/syscalls.rs":"568e16751191c14bb37f7883b17cb577dc97e09d615d17849=
c0e7e10e3898f1b","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0=
f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_ur=
ing/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/linux_raw/io_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5=
b23558871a452a29ac6095a0184a06c47b9b18eb6","src/backend/linux_raw/mm/mod.r=
s":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src=
/backend/linux_raw/mm/syscalls.rs":"4e469542c88ea15853d5022e7e1d4b8fc29126=
5ca314766d60d9395dad927e19","src/backend/linux_raw/mm/types.rs":"b5bf9bf77=
5d3771e79aa234788fa3d1f25009f3f51cd59c72efc4f5e2c7bd790","src/backend/linu=
x_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bc=
a2221","src/backend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls=
.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","s=
rc/backend/linux_raw/mount/types.rs":"bf3dff5aad1cec9d998496230469958c836b=
76643f0ad17b0ea29b957357bcca","src/backend/linux_raw/net/addr.rs":"161ff30=
891526e309b1cf9514e9113227c6901c5c1bb346cb8fc3a53e43aa410","src/backend/li=
nux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257=
fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64=
733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux_raw/net/net=
device.rs":"a0354e44ae2f8402576b55470e48446dd655d77a69f27f814a298ab3e3a1af=
ac","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323c=
d83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/net/send_=
recv.rs":"6d5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc=
","src/backend/linux_raw/net/sockopt.rs":"2b42cd181772ea78d1b5b64d03fd2939=
a5e1a0c49b84c943c9fe8707b6477344","src/backend/linux_raw/net/syscalls.rs":=
"0138662012ca89e063b3a03cf8fe17b97fbeb38a3d18c42938ae047a4a392105","src/ba=
ckend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acfccd3=
1a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"aa5=
7b07c1ff5524dcda5cef9a484f753c7b0bcc7b9410c5dbb2ed59c39de5f68","src/backen=
d/linux_raw/param/init.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3b=
ce2eee5f55e850bde0","src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feb=
a6d383d17d9d25293ab40e39dfefb23533844ee7abaa917923e2b5","src/backend/linux=
_raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067=
f28f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61ac=
b841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscall=
s.rs":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","=
src/backend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0=
287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"366c=
730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a9113b2749e476faf6f83","src/backend=
/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee15e0e3566ceaad39fda44e69ed6f94a9=
9fadd9be9b8be09cf","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625=
edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pr=
ctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf058=
5b757343","src/backend/linux_raw/process/cpu_set.rs":"dfdcbdf35aff6a3e08e7=
d38193bf18c12ca8aa64eb0dc417667be82dcc0f7c55","src/backend/linux_raw/proce=
ss/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd=
68","src/backend/linux_raw/process/syscalls.rs":"07c14d796a65d3958a9199dae=
00c8b864fda70e26b67815aff20edd20a985f2f","src/backend/linux_raw/process/ty=
pes.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d"=
,"src/backend/linux_raw/process/wait.rs":"921aee4b0048746087f52615a98edc2a=
a0fb4b53d6df44be4533098df55d1b05","src/backend/linux_raw/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend=
/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460=
d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":"8aa966faf3853d1a=
93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/r=
and/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e90c5dba73e1ac34=
75ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31eed6b59a57520b=
e5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_raw/reg.rs":"6=
bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41c","src/back=
end/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b68464040dcac33c=
6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.rs":"dc7df0=
416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","src/backend/l=
inux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113a04a7391=
60929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853d1a93d0=
ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/shm/s=
yscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf3cb9c=
8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c9289f525777=
6a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/system/mod.rs":"=
8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f55=
f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/=
linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"25a0341ded=
4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/backend/linux=
_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2f6cb29669=
e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900=
b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/threa=
d/syscalls.rs":"9bc9a7360b6b8711b82bc6eff58dbcfc1d936f6e2cdf828084ed56036a=
de76d7","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d2=
8b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.=
rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","sr=
c/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e=
726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857=
a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251=
309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337=
ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrap=
pers.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a=
","src/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31=
a8219ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc7=
9b43af24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227=
b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd443c60868586c1a3114=
afacc95193de1d8cb99b7c9d710e0b3835596c74a24","src/cstr.rs":"41af2a4429fe6c=
67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs"=
:"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/e=
vent/kqueue.rs":"2f776485e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7=
d82183a","src/event/mod.rs":"77f6c7051f70d4d5873787cf744e05b64519ba61d8da4=
2298aeed27a906031f2","src/event/pause.rs":"cac3317286478565298a40788c1ce13=
c1b71543078a6f09655419de325022f6f","src/event/poll.rs":"899bbee8e565110b25=
81594e7aa5067a426f859f0a414935e2ce3a9732b6152a","src/event/port.rs":"4e51f=
f150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":=
"c2b8b38c02d72749aceb715c496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs=
/abs.rs":"b671489378e14b708c784c4a673e6645741a869c7d1dd1918e28e1eb1a138829=
","src/fs/at.rs":"13f50b86575443db8b881ce525ce2c5d2f377e528c33258729f0c060=
37de9499","src/fs/constants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f=
9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff=
749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/cwd.rs":"9f429a79ace=
6e17455634da09216ee0ad3d067a4541518b3193ae6a8d9ff1e26","src/fs/dir.rs":"34=
7a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fa=
dvise.rs":"1220e2cf5cf58fc7cc950d48738050a052c504f745ca67130daa6410e248230=
a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1cc1b8b76f39c820746240557daa9e14b47=
b1799120dc39","src/fs/fcntl_apple.rs":"e2f23f038083621bcdecc98d02ce1023508=
afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086=
077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":"a46ecb4c3bea=
d93a9677683080645bf4f320fe7f9b65702c8ddc759d58aa09b1","src/fs/getpath.rs":=
"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2edd9","src/fs=
/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a6c6222e0cb"=
,"src/fs/ioctl.rs":"c7c2db229daf7c9f0109fe7f45f05fa9a6a472950a2ad408c71514=
e6cb7c9d7b","src/fs/makedev.rs":"85520b484cb7c15ab71ea1c368578ea3b7e484d82=
f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"a8bf1dced54c7592e71da89=
6021338d5092c1693d12cc42e79bac435fab2792b","src/fs/mod.rs":"b1e92f119ce8ac=
bcc55597f5512727622bcd12d6d0ce9fdb2d9b1cfaa9e42a64","src/fs/mount.rs":"8f6=
ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317be5b","src/fs/ope=
nat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696bdaf45af8aef96db=
","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4028e03ace477d0520d9b=
226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e91efee2e3f2dc=
de16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741cf4b1698f34d=
84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx.rs":"f925be3d9a1=
79a903549b3ac18038d004f4f2021e46dad4aa2757907aebefeca","src/fs/sync.rs":"a=
3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b9196234cfd","src/fs/x=
attr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca6e72d44cbe8334=
","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2eef8026407b8d00=
9cb3ceae6b8","src/io/dup.rs":"335e76f8ad5aa021e654f61e043058e964c2f9914c47=
85fc09bf6f49f4975290","src/io/errno.rs":"58a4d20ba0924e4d514e3c876fbe08982=
f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be55aaa68144dc=
c8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"af4e736b673=
9cb1ff0477c1b818eeac789258863b79d12e441a08be99d49fb77","src/io/is_read_wri=
te.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519ff9bb73b4",=
"src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd4e0e9701550=
8c0bb8f","src/io/read_write.rs":"f36488a87a35c37c004f5111e76aad3cf6c2c793f=
41f78f2daba7a84ecae9079","src/io_uring.rs":"b08662af4b1b205ef644ca75176889=
57cf54cab3fc693f6205165550a330a5cc","src/ioctl/bsd.rs":"32ba3399a0fe3f68bb=
458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.rs":"96df=
90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/ioctl/m=
od.rs":"ebb1e0865bed1b98917d4824082caf1445559a0a19f588094db90f46c224f780",=
"src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c45b454=
47630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0c20b0bea6f1=
85b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c5a4=
f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfill/=
no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d8=
8c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f758f2bc31d=
3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_std/net=
/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f9606dd=
","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde76323abc=
ffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/os/fd=
/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47=
","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09=
a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw=
.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","s=
rc/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c8253106=
06b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.=
rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","sr=
c/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637=
cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windo=
ws/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c648=
08308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e77=
8b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/m=
od.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc",=
"src/mm/madvise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951=
f37745bc1dc","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475=
951e5ed900b86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761=
211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb9=
35404513498b0da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"807344=
3bd181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fso=
pen.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382"=
,"src/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d=
12a7136cb19","src/mount/mount_unmount.rs":"3805b63d4415d5838bdae34c6f6d500=
17d09b0d837de141961e66c7fb94dcc0a","src/mount/types.rs":"601ae3e10b7dc496f=
ed7f3b40a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807=
c9ad9e3fdbfd8b3ce2a1c7053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdev=
ice.rs":"932cb84bbec55220ce4089b27be4c77853e49d82e1557bbfcfbea6faa4ea730f"=
,"src/net/send_recv/mod.rs":"b00743069268f2671570f76a4ff08b5487a344e5a6a12=
e62d40c2be5c25ac22d","src/net/send_recv/msg.rs":"c8ecb0e45df2c6cf655f13025=
ea7880214e5c085cd9dcbfdfa912f5420a6f3a3","src/net/socket.rs":"c1865fee7c35=
4a9cc810853844a86c5ab4ab93dcec5e6de2d76993550b412ce4","src/net/socket_addr=
_any.rs":"b5fe6f012c67d70e0e4885b9e5d6e463c282e12330a0579ea98bdf8fedbccd60=
","src/net/socketpair.rs":"56f4885c31d2664cd16e18a9a88792a4912fedd953cec36=
dba67e8581fd57921","src/net/sockopt.rs":"21d269c34992643d403d50e3071b646cd=
9ed05dc9bdc53fe2f795bb5df43fa60","src/net/types.rs":"bd3ee0cdb102e8cd1f2e0=
434639084b599a10561fc7f2aaa226d44bf892cef63","src/net/wsa.rs":"29856e6d010=
8be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs"=
:"8602af47a39bb340d319807bdecdb9be8b467101a9ed96061277b90234801913","src/p=
aram/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be=
27a55","src/param/mod.rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9=
f64175c8b35577288","src/path/arg.rs":"c0f0a7c2fe37192cf6f7b35ae0e17620b863=
b31e55efb7b2d9f31b5def56a749","src/path/dec_int.rs":"8ff8e14442c46f8e7a9b8=
0d73973619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.rs":"8355324af7=
eaa91dce30fc4ebdd161691f9d8bf7a61bde1dde27a1bcca15369b","src/pid.rs":"f1c4=
86000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs=
":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a9e11","src/=
prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b=
7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b0007835b85c7=
19875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad2705174f7ad50=
cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5504a00c=
b375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.rs":"e0=
a26da426962dd5898fbc05700083a68399d5b669fd5f4afaac7b282e0178fd","src/proce=
ss/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e0236db3=
7e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94bbfc=
a7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe16352=
eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909a=
fcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd=
.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3b79ae316cab","s=
rc/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461fdc8493b259031e=
35f8f558768d960cc2","src/process/prctl.rs":"0130d05362a17a9282f3391189095e=
1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71e=
a8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procct=
l.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea","=
src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75=
031d5e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c0766=
1e7f57c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b=
66ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.r=
s":"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src=
/process/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014=
b7b49fcd3","src/procfs.rs":"4d4812a8db6897dabc33269ff59bf6d7192a65be977e87=
9613704e29a8b73505","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b8=
98b7af344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c=
41ca286b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f195=
8fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"95=
8cdf1567c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.r=
s":"b96fe8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src=
/signal.rs":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccd=
af2","src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c8=
2eec0098bdf0988e662e260","src/stdio.rs":"6f78cbc0d102eff9354fa1fdfd1b63a45=
ea159d0a9ac5d25ecf703383b847b55","src/system.rs":"e048eccf6f60ff49fa3312e7=
a01a9f641787c195c4db745f1f5a2f2c443d7e91","src/termios/ioctl.rs":"a1ac967f=
7811a482f8bb53847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod=
.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","s=
rc/termios/tc.rs":"9af4eb264bf23bc0b0ad1707fcca687020b20f0775a28209b237fbb=
72089d991","src/termios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c=
5bac30e0953220808ef7034","src/termios/types.rs":"b5671eedf541754c54f680002=
bafed1adbabce172d09d7c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271e=
b3e6831d9b0c3a01bfddbe4bd69dee237bbaa059884de452b29e79","src/thread/futex.=
rs":"985f9a0dce1e2a4892ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","sr=
c/thread/id.rs":"d4402a50f76823f8b08b1c43469846cf7bad0b11e6c267680f7fa826a=
ba0d1a4","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4=
e1154791fd38438e2ca7db1","src/thread/mod.rs":"09b19f25ed1aa65f6605ed7deccc=
4bd945e3ae872a60275787f44944a73edf3f","src/thread/prctl.rs":"ebc89b731eb8f=
d1a8f82a50dbba849061476a4537bba8702b29db657d5287ffa","src/thread/setns.rs"=
:"ea9142b1f3a5b3f329683be185f960c50e5c1636149e91fbf59e88a897fc607d","src/t=
ime/clock.rs":"e59a29f1bed8c31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1c=
e735f","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff3=
09211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c=
8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153=
290db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43a=
ee5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"9ae76f8=
a41d6cc350cdd58c9084b5c3a5a708eeecd769783debdbcbaef442182","src/weak.rs":"=
7e3169bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"packag=
e":"65e04861e65f21776e67888bfbea442b3642beaa0138fdb1dd7a84a52dffdb89"}
+\ No newline at end of file
=
++{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e8=
5e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231=
d2fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b05=
32d35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"5e3eef3032f414825f=
b0d0a4d221d4c15989905fe6c675d6d360da3430f97003","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-=
2.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb=
39ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8=
a715d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f=
0a12ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2=
f0c851939b7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd=
28eb5982e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e=
260e67273aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs=
":"5f93559819ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/=
backend/libc/c.rs":"1d4f1794a08e0ede95f2b034098f18e0ede275868f65fdd61e2367=
77b4e92721","src/backend/libc/conv.rs":"a254fa84164286ee6be64f49b5bd5f7e2f=
d503ebd5ca9076dad4c2507a351dc2","src/backend/libc/event/epoll.rs":"93d3eb9=
e0e397afc3c44797b315ce92ff8b22f2372812b19cec9e063c55032c3","src/backend/li=
bc/event/mod.rs":"ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4=
677ec231","src/backend/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f1=
0dc4e7010942286f6fb7cca93954ab63e01d9","src/backend/libc/event/syscalls.rs=
":"f91bbe7d222987c89a2647817f6819dd536cbc4a685dfb794f403543c32df777","src/=
backend/libc/event/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b=
784583207ad2df473f13","src/backend/libc/event/windows_syscalls.rs":"ebfac6=
65c6676c4b803134ab8806be8aa2e96bdbc7799a19c544cd9069b35787","src/backend/l=
ibc/fs/dir.rs":"3c43768f9e56cb4297594c05d91a52be20029dd2b3e0b91f6b1a13f31e=
595fe2","src/backend/libc/fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850=
b466240b0a2296d72b9834c0096968e8","src/backend/libc/fs/makedev.rs":"89c679=
a0ef18dd41b3c6223bce0f329ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/l=
ibc/fs/mod.rs":"3d28b803011b57da6315bb747daf0117218687c0cc610358f5dafddf0b=
7d44d3","src/backend/libc/fs/syscalls.rs":"23df7677c327225d4830262961a44b6=
3b5e182c80c6bb885e0629a5c0bcfc31a","src/backend/libc/fs/types.rs":"d6b031c=
83e333dc5ff52f3bb0eaa92ba2d05a72fa0540c73e3b15e63f67e6812","src/backend/li=
bc/io/errno.rs":"bac592ece7b44692237a350ff4905bfad30fa042d1e8126e5229e0291=
3fb1c9d","src/backend/libc/io/mod.rs":"746647bd864e4ec7717925b6d176cebdb39=
2b7d015070244cc48d92780351dd6","src/backend/libc/io/syscalls.rs":"c93a7867=
fc13eecc953c6335fd79c37d4d1734d3a06e13e5d7e08bd985c66326","src/backend/lib=
c/io/types.rs":"2efd39bb3df19a9db5496217284f3d2235ddb354fac81dd71861109a56=
bede0b","src/backend/libc/io/windows_syscalls.rs":"fab3fa099aa89cea56a6edc=
651dd37750e581534f4f45b04a7e425f130b08468","src/backend/libc/io_uring/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/io_uring/syscalls.rs":"5af8146d5971c833e6fd657f652c618b31f8=
54e1b0811864fba9b658cb633e19","src/backend/libc/mm/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mm/s=
yscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a05658cea4763207f9250db4f9362de=
2fe","src/backend/libc/mm/types.rs":"55478e173b7d82e2c85934fc0dda79c29f46a=
305228df78f1e90c68ac9d3cfec","src/backend/libc/mod.rs":"087d2676df88510b08=
9255053a4865e62c64172723588386fe8244d2f1a681c4","src/backend/libc/mount/mo=
d.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","=
src/backend/libc/mount/syscalls.rs":"d2d35f7ae989bb52722e28cdbd775243c5d7d=
a9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mount/types.rs":"bf1d541daa=
248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e113","src/backend/libc/=
net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c79cb547f08105087cd0f79d=
5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86b47a2ab34340e3f6cc7b5=
3b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod.rs":"562d23225d6dba=
8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","src/backend/libc/net/=
msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d10437bb19bf7496666bd6d=
e6","src/backend/libc/net/netdevice.rs":"c6c3cd11b0181a74243705438fbf0fede=
b02d4201ff3ad9f45a084fbd57a9c21","src/backend/libc/net/read_sockaddr.rs":"=
61fc1c744b376d57a18d78d8f7ab469236c614f5fa7aeaf37a636e6a967b9066","src/bac=
kend/libc/net/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c=
56d164ccda38f21b36c","src/backend/libc/net/sockopt.rs":"d53d52f1c55f522c1d=
0de5e446df3017757b08270c0a0b593a583fd6c56b0876","src/backend/libc/net/sysc=
alls.rs":"1412f9deed57ac0909b0b1c3ac3e5fb7d5c31ab356212c9131e33378c342d2a5=
","src/backend/libc/net/write_sockaddr.rs":"bee221d0a1fedf4ddcff045faa2702=
c1f1e68b4d6c3f2f7b079d888e0ef9da56","src/backend/libc/param/auxv.rs":"fc94=
76c85482b1d44190289224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend=
/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354=
bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841=
819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs":"49=
ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backe=
nd/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489=
fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d=
1e48be5c1039be414f8ef7d5a6acaba882a68d259","src/backend/libc/pipe/types.rs=
":"9826013bc5fa18acdcbf09c650b96ce301a18ec009139ebaf79162669b1fc2c8","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fae=
ded15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a75550=
98dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/proces=
s/cpu_set.rs":"b3d36b01b53b0b6c61a20ed8a69d48eccdd90cc17f82f2926ef1e844f00=
2d0b7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d=
348da147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"=
f08a76a5f32e40a69c99261eeabb405a58476ef9e85ae142f2fce19679a42ec4","src/bac=
kend/libc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80=
c758b748bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb=
3965f74fd76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod=
.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a=
8f4fe18b55123ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a=
93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/s=
yscalls.rs":"35ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db8=
5e7","src/backend/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be2=
8a38b7b07a705ec605b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf385=
3d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/sh=
m/syscalls.rs":"60d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e4923=
1c268c","src/backend/libc/shm/types.rs":"2206eac8ee74951b995e1e80f10bf235c=
c6b04e0a099f4adefce546378838233","src/backend/libc/system/mod.rs":"38563ea=
68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backend/li=
bc/system/syscalls.rs":"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44c=
da53bc9d6fcf03","src/backend/libc/system/types.rs":"6871e16aee14fe2ae03cea=
798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/backend/libc/termios/mod.=
rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","sr=
c/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cdbc9e190dd650c8141c00=
c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/futex.rs":"b66682865=
3b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5","src/backend/libc=
/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302=
a679fff","src/backend/libc/thread/syscalls.rs":"435392788b133b83eaf73913a3=
adee5b244b471df316dec02469832cfdc71160","src/backend/libc/time/mod.rs":"38=
563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backe=
nd/libc/time/syscalls.rs":"bf847e94cc156bdb553755baa88dac240db4dcaf690f303=
b0f205777c5a9cdfc","src/backend/libc/time/types.rs":"d0307994ffddd3f21f702=
d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/ugid/mod.rs=
":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/=
backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b0723a371677f=
29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"502da2ed3cd6ca99b=
b7ee08b0b30e25c212632885cec965f9816366c6b931ac6","src/backend/linux_raw/ar=
ch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caeae63c24=
587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d420911837=
65f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.rs":=
"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src/ba=
ckend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc95=
1e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9d=
dc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641a=
fb82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d=
170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arc=
h/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07=
da74477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2=
b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thum=
b.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","=
src/backend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db6=
5ac9fe54b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e92903=
6a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/l=
inux_raw/c.rs":"db66abe9b91ce0f16dd71762744013046f29542a46a577454c9ff063e9=
cb649c","src/backend/linux_raw/conv.rs":"48a261b8dd6182ce876690cd4946d00c3=
697bcf7c3d89a46e3a3d6f50d39c2db","src/backend/linux_raw/event/epoll.rs":"a=
102c2d8d7d5d07a5d846f30672153269d1762d1d846be1786b22fcf095e8721","src/back=
end/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe9=
16faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e=
30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_=
raw/event/syscalls.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5=
a36726b8db2d41","src/backend/linux_raw/event/types.rs":"0551b18f982e233a0a=
06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/=
dir.rs":"3107b07276f171a5837bd37a9c1e05151ca21d59ae2b85afd2c6e59e721cdcf2"=
,"src/backend/linux_raw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7537e74=
5fbf1d8c26592c80ceec6fd2ab59b5","src/backend/linux_raw/fs/makedev.rs":"c6b=
4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backen=
d/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca09=
21f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"dc7475b41ef2c5e0fb=
860ddbbcb05a966afb2b699f4f5fc3e67945936809d71e","src/backend/linux_raw/fs/=
types.rs":"4742cc26f754809664d49f3ff70e0f6eab131dd2d1174ba1332c5d686a98eda=
9","src/backend/linux_raw/io/errno.rs":"befa94275b30e8262718e8c9e9662b0852=
6ec55779861dab4e2e499daa3e097d","src/backend/linux_raw/io/mod.rs":"7ae2324=
427892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/li=
nux_raw/io/syscalls.rs":"568e16751191c14bb37f7883b17cb577dc97e09d615d17849=
c0e7e10e3898f1b","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0=
f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_ur=
ing/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/linux_raw/io_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5=
b23558871a452a29ac6095a0184a06c47b9b18eb6","src/backend/linux_raw/mm/mod.r=
s":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src=
/backend/linux_raw/mm/syscalls.rs":"4e469542c88ea15853d5022e7e1d4b8fc29126=
5ca314766d60d9395dad927e19","src/backend/linux_raw/mm/types.rs":"b5bf9bf77=
5d3771e79aa234788fa3d1f25009f3f51cd59c72efc4f5e2c7bd790","src/backend/linu=
x_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bc=
a2221","src/backend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls=
.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","s=
rc/backend/linux_raw/mount/types.rs":"bf3dff5aad1cec9d998496230469958c836b=
76643f0ad17b0ea29b957357bcca","src/backend/linux_raw/net/addr.rs":"161ff30=
891526e309b1cf9514e9113227c6901c5c1bb346cb8fc3a53e43aa410","src/backend/li=
nux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257=
fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64=
733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux_raw/net/net=
device.rs":"a0354e44ae2f8402576b55470e48446dd655d77a69f27f814a298ab3e3a1af=
ac","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323c=
d83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/net/send_=
recv.rs":"6d5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc=
","src/backend/linux_raw/net/sockopt.rs":"2b42cd181772ea78d1b5b64d03fd2939=
a5e1a0c49b84c943c9fe8707b6477344","src/backend/linux_raw/net/syscalls.rs":=
"0138662012ca89e063b3a03cf8fe17b97fbeb38a3d18c42938ae047a4a392105","src/ba=
ckend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acfccd3=
1a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"aa5=
7b07c1ff5524dcda5cef9a484f753c7b0bcc7b9410c5dbb2ed59c39de5f68","src/backen=
d/linux_raw/param/init.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3b=
ce2eee5f55e850bde0","src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feb=
a6d383d17d9d25293ab40e39dfefb23533844ee7abaa917923e2b5","src/backend/linux=
_raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067=
f28f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61ac=
b841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscall=
s.rs":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","=
src/backend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0=
287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"366c=
730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a9113b2749e476faf6f83","src/backend=
/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee15e0e3566ceaad39fda44e69ed6f94a9=
9fadd9be9b8be09cf","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625=
edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pr=
ctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf058=
5b757343","src/backend/linux_raw/process/cpu_set.rs":"dfdcbdf35aff6a3e08e7=
d38193bf18c12ca8aa64eb0dc417667be82dcc0f7c55","src/backend/linux_raw/proce=
ss/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd=
68","src/backend/linux_raw/process/syscalls.rs":"07c14d796a65d3958a9199dae=
00c8b864fda70e26b67815aff20edd20a985f2f","src/backend/linux_raw/process/ty=
pes.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d"=
,"src/backend/linux_raw/process/wait.rs":"921aee4b0048746087f52615a98edc2a=
a0fb4b53d6df44be4533098df55d1b05","src/backend/linux_raw/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend=
/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460=
d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":"8aa966faf3853d1a=
93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/r=
and/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e90c5dba73e1ac34=
75ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31eed6b59a57520b=
e5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_raw/reg.rs":"6=
bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41c","src/back=
end/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b68464040dcac33c=
6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.rs":"dc7df0=
416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","src/backend/l=
inux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113a04a7391=
60929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853d1a93d0=
ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/shm/s=
yscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf3cb9c=
8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c9289f525777=
6a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/system/mod.rs":"=
8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f55=
f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/=
linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"25a0341ded=
4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/backend/linux=
_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2f6cb29669=
e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900=
b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/threa=
d/syscalls.rs":"9bc9a7360b6b8711b82bc6eff58dbcfc1d936f6e2cdf828084ed56036a=
de76d7","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d2=
8b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.=
rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","sr=
c/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e=
726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857=
a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251=
309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337=
ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrap=
pers.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a=
","src/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31=
a8219ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc7=
9b43af24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227=
b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd443c60868586c1a3114=
afacc95193de1d8cb99b7c9d710e0b3835596c74a24","src/cstr.rs":"41af2a4429fe6c=
67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs"=
:"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/e=
vent/kqueue.rs":"2f776485e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7=
d82183a","src/event/mod.rs":"77f6c7051f70d4d5873787cf744e05b64519ba61d8da4=
2298aeed27a906031f2","src/event/pause.rs":"cac3317286478565298a40788c1ce13=
c1b71543078a6f09655419de325022f6f","src/event/poll.rs":"899bbee8e565110b25=
81594e7aa5067a426f859f0a414935e2ce3a9732b6152a","src/event/port.rs":"4e51f=
f150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":=
"c2b8b38c02d72749aceb715c496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs=
/abs.rs":"b671489378e14b708c784c4a673e6645741a869c7d1dd1918e28e1eb1a138829=
","src/fs/at.rs":"13f50b86575443db8b881ce525ce2c5d2f377e528c33258729f0c060=
37de9499","src/fs/constants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f=
9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff=
749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/cwd.rs":"9f429a79ace=
6e17455634da09216ee0ad3d067a4541518b3193ae6a8d9ff1e26","src/fs/dir.rs":"34=
7a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fa=
dvise.rs":"1220e2cf5cf58fc7cc950d48738050a052c504f745ca67130daa6410e248230=
a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1cc1b8b76f39c820746240557daa9e14b47=
b1799120dc39","src/fs/fcntl_apple.rs":"e2f23f038083621bcdecc98d02ce1023508=
afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086=
077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":"a46ecb4c3bea=
d93a9677683080645bf4f320fe7f9b65702c8ddc759d58aa09b1","src/fs/getpath.rs":=
"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2edd9","src/fs=
/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a6c6222e0cb"=
,"src/fs/ioctl.rs":"84f144999c1482fdeb21c8969166c668bf74fc97d3308d7f473d5b=
eb436f9ca0","src/fs/makedev.rs":"85520b484cb7c15ab71ea1c368578ea3b7e484d82=
f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"a8bf1dced54c7592e71da89=
6021338d5092c1693d12cc42e79bac435fab2792b","src/fs/mod.rs":"b1e92f119ce8ac=
bcc55597f5512727622bcd12d6d0ce9fdb2d9b1cfaa9e42a64","src/fs/mount.rs":"8f6=
ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317be5b","src/fs/ope=
nat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696bdaf45af8aef96db=
","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4028e03ace477d0520d9b=
226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e91efee2e3f2dc=
de16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741cf4b1698f34d=
84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx.rs":"f925be3d9a1=
79a903549b3ac18038d004f4f2021e46dad4aa2757907aebefeca","src/fs/sync.rs":"a=
3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b9196234cfd","src/fs/x=
attr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca6e72d44cbe8334=
","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2eef8026407b8d00=
9cb3ceae6b8","src/io/dup.rs":"335e76f8ad5aa021e654f61e043058e964c2f9914c47=
85fc09bf6f49f4975290","src/io/errno.rs":"58a4d20ba0924e4d514e3c876fbe08982=
f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be55aaa68144dc=
c8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"af4e736b673=
9cb1ff0477c1b818eeac789258863b79d12e441a08be99d49fb77","src/io/is_read_wri=
te.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519ff9bb73b4",=
"src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd4e0e9701550=
8c0bb8f","src/io/read_write.rs":"f36488a87a35c37c004f5111e76aad3cf6c2c793f=
41f78f2daba7a84ecae9079","src/io_uring.rs":"b08662af4b1b205ef644ca75176889=
57cf54cab3fc693f6205165550a330a5cc","src/ioctl/bsd.rs":"32ba3399a0fe3f68bb=
458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.rs":"96df=
90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/ioctl/m=
od.rs":"ebb1e0865bed1b98917d4824082caf1445559a0a19f588094db90f46c224f780",=
"src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c45b454=
47630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0c20b0bea6f1=
85b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c5a4=
f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfill/=
no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d8=
8c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f758f2bc31d=
3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_std/net=
/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f9606dd=
","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde76323abc=
ffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/os/fd=
/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47=
","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09=
a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw=
.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","s=
rc/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c8253106=
06b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.=
rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","sr=
c/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637=
cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windo=
ws/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c648=
08308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e77=
8b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/m=
od.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc",=
"src/mm/madvise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951=
f37745bc1dc","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475=
951e5ed900b86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761=
211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb9=
35404513498b0da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"807344=
3bd181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fso=
pen.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382"=
,"src/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d=
12a7136cb19","src/mount/mount_unmount.rs":"3805b63d4415d5838bdae34c6f6d500=
17d09b0d837de141961e66c7fb94dcc0a","src/mount/types.rs":"601ae3e10b7dc496f=
ed7f3b40a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807=
c9ad9e3fdbfd8b3ce2a1c7053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdev=
ice.rs":"932cb84bbec55220ce4089b27be4c77853e49d82e1557bbfcfbea6faa4ea730f"=
,"src/net/send_recv/mod.rs":"b00743069268f2671570f76a4ff08b5487a344e5a6a12=
e62d40c2be5c25ac22d","src/net/send_recv/msg.rs":"c8ecb0e45df2c6cf655f13025=
ea7880214e5c085cd9dcbfdfa912f5420a6f3a3","src/net/socket.rs":"c1865fee7c35=
4a9cc810853844a86c5ab4ab93dcec5e6de2d76993550b412ce4","src/net/socket_addr=
_any.rs":"b5fe6f012c67d70e0e4885b9e5d6e463c282e12330a0579ea98bdf8fedbccd60=
","src/net/socketpair.rs":"56f4885c31d2664cd16e18a9a88792a4912fedd953cec36=
dba67e8581fd57921","src/net/sockopt.rs":"21d269c34992643d403d50e3071b646cd=
9ed05dc9bdc53fe2f795bb5df43fa60","src/net/types.rs":"bd3ee0cdb102e8cd1f2e0=
434639084b599a10561fc7f2aaa226d44bf892cef63","src/net/wsa.rs":"29856e6d010=
8be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs"=
:"8602af47a39bb340d319807bdecdb9be8b467101a9ed96061277b90234801913","src/p=
aram/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be=
27a55","src/param/mod.rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9=
f64175c8b35577288","src/path/arg.rs":"c0f0a7c2fe37192cf6f7b35ae0e17620b863=
b31e55efb7b2d9f31b5def56a749","src/path/dec_int.rs":"8ff8e14442c46f8e7a9b8=
0d73973619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.rs":"8355324af7=
eaa91dce30fc4ebdd161691f9d8bf7a61bde1dde27a1bcca15369b","src/pid.rs":"f1c4=
86000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs=
":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a9e11","src/=
prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b=
7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b0007835b85c7=
19875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad2705174f7ad50=
cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5504a00c=
b375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.rs":"e0=
a26da426962dd5898fbc05700083a68399d5b669fd5f4afaac7b282e0178fd","src/proce=
ss/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e0236db3=
7e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94bbfc=
a7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe16352=
eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909a=
fcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd=
.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3b79ae316cab","s=
rc/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461fdc8493b259031e=
35f8f558768d960cc2","src/process/prctl.rs":"0130d05362a17a9282f3391189095e=
1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71e=
a8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procct=
l.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea","=
src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75=
031d5e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c0766=
1e7f57c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b=
66ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.r=
s":"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src=
/process/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014=
b7b49fcd3","src/procfs.rs":"4d4812a8db6897dabc33269ff59bf6d7192a65be977e87=
9613704e29a8b73505","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b8=
98b7af344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c=
41ca286b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f195=
8fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"95=
8cdf1567c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.r=
s":"b96fe8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src=
/signal.rs":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccd=
af2","src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c8=
2eec0098bdf0988e662e260","src/stdio.rs":"6f78cbc0d102eff9354fa1fdfd1b63a45=
ea159d0a9ac5d25ecf703383b847b55","src/system.rs":"e048eccf6f60ff49fa3312e7=
a01a9f641787c195c4db745f1f5a2f2c443d7e91","src/termios/ioctl.rs":"a1ac967f=
7811a482f8bb53847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod=
.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","s=
rc/termios/tc.rs":"9af4eb264bf23bc0b0ad1707fcca687020b20f0775a28209b237fbb=
72089d991","src/termios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c=
5bac30e0953220808ef7034","src/termios/types.rs":"b5671eedf541754c54f680002=
bafed1adbabce172d09d7c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271e=
b3e6831d9b0c3a01bfddbe4bd69dee237bbaa059884de452b29e79","src/thread/futex.=
rs":"985f9a0dce1e2a4892ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","sr=
c/thread/id.rs":"d4402a50f76823f8b08b1c43469846cf7bad0b11e6c267680f7fa826a=
ba0d1a4","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4=
e1154791fd38438e2ca7db1","src/thread/mod.rs":"09b19f25ed1aa65f6605ed7deccc=
4bd945e3ae872a60275787f44944a73edf3f","src/thread/prctl.rs":"ebc89b731eb8f=
d1a8f82a50dbba849061476a4537bba8702b29db657d5287ffa","src/thread/setns.rs"=
:"ea9142b1f3a5b3f329683be185f960c50e5c1636149e91fbf59e88a897fc607d","src/t=
ime/clock.rs":"e59a29f1bed8c31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1c=
e735f","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff3=
09211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c=
8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153=
290db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43a=
ee5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"9ae76f8=
a41d6cc350cdd58c9084b5c3a5a708eeecd769783debdbcbaef442182","src/weak.rs":"=
7e3169bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"packag=
e":"65e04861e65f21776e67888bfbea442b3642beaa0138fdb1dd7a84a52dffdb89"}
+\ No newline at end of file
+--- a/vendor/rustix-0.38.32/src/fs/ioctl.rs
++++ b/vendor/rustix-0.38.32/src/fs/ioctl.rs
+@@ -77,7 +77,7 @@ unsafe impl ioctl::Ioctl for Ficlone<'_>
+     type Output =3D ();
+=20
+     const IS_MUTATING: bool =3D false;
+-    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(c::FICLONE as =
ioctl::RawOpcode);
++    const OPCODE: ioctl::Opcode =3D =
ioctl::Opcode::old(linux_raw_sys::ioctl::FICLONE as ioctl::RawOpcode);
+=20
+     fn as_ptr(&mut self) -> *mut c::c_void {
+         self.0.as_raw_fd() as *mut c::c_void
diff --git a/recipes-devtools/rust/files/target-rust-ccld.c =
b/recipes-devtools/rust/files/target-rust-ccld.c
new file mode 100644
index 0000000..d3d491f
--- /dev/null
+++ b/recipes-devtools/rust/files/target-rust-ccld.c
@@ -0,0 +1,19 @@
+/*
+*
+* Copyright (C) 2022      Wind River Systems
+*
+* SPDX-License-Identifier: MIT
+*
+*/
+
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main (int argc, char *argv[])
+{
+    unsetenv("LD_LIBRARY_PATH");
+    execvp("target-rust-ccld-wrapper", argv);
+
+    return 0;
+}
diff --git a/recipes-devtools/rust/files/zlib-off64_t.patch =
b/recipes-devtools/rust/files/zlib-off64_t.patch
new file mode 100644
index 0000000..030c6c2
--- /dev/null
+++ b/recipes-devtools/rust/files/zlib-off64_t.patch
@@ -0,0 +1,33 @@
+Do not undefine _FILE_OFFSET_BITS when
+_LARGEFILE64_SOURCE is defined. This ends up
+causing 64bit time_t to fail the build because
+it needs 64 bit off_t
+
+Upstream-Status: Submitted [https://github.com/madler/zlib/pull/764]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+Index: rustc-1.79.0-src/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--- rustc-1.79.0-src.orig/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
++++ rustc-1.79.0-src/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
+@@ -3,13 +3,6 @@
+  * For conditions of distribution and use, see copyright notice in =
zlib.h
+  */
+=20
+-#ifdef _LARGEFILE64_SOURCE
+-#  ifndef _LARGEFILE_SOURCE
+-#    define _LARGEFILE_SOURCE 1
+-#  endif
+-#  undef _FILE_OFFSET_BITS
+-#  undef _TIME_BITS
+-#endif
+=20
+ #ifdef HAVE_HIDDEN
+ #  define ZLIB_INTERNAL __attribute__((visibility ("hidden")))
+Index: rustc-1.79.0-src/vendor/libz-sys-1.1.16/.cargo-checksum.json
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--- rustc-1.79.0-src.orig/vendor/libz-sys-1.1.16/.cargo-checksum.json
++++ rustc-1.79.0-src/vendor/libz-sys-1.1.16/.cargo-checksum.json
+@@ -1 +1 @@
=
+-{"files":{"Cargo.toml":"b4ed89b98aea5ea05fa475a9ba6f824dc6e759ea7a4c358e=
7fcecc7423e44777","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d0=
59d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d=
464acb3408d4c599d3dc5fe4fa1b4c84f","README-zng.md":"438ab65416835d72c7dd16=
8338af3db6f1a3d8ccee455af4e1d75438a781eb71","README.md":"62fa314f90fdc5430=
c6446ddb212b782ad69721cd5363983820261a41b53890e","build.rs":"b139f25e59a8c=
c78a9fff8bdc25b34f6ba926ddf410bac65bfb7f279f1a92d76","build_zng.rs":"059da=
8bf3ed5f2bfa613874b8f6720643ae948a811fefaff8237e95e0771cbc3","src/lib.rs":=
"8f9f42e8c80e134fa6f5724c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/sm=
oke.c":"10607c81b73811bfcb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b",=
"src/zlib-ng/CMakeLists.txt":"6b7d83767c0fe0b98e2d5321a2c35339e04bf314f6bf=
650f4716a7434a3e164c","src/zlib-ng/FAQ.zlib":"c524f4f86d336b3de71dd6977afd=
dffa9c02fda5c26db4dfefae44959e7614a2","src/zlib-ng/INDEX.md":"989545e90d8e=
9ac149034f762ce78ed8976ebf9324326228dea37ca190154609","src/zlib-ng/LICENSE=
.md":"d3c80be055d94d798eaa786116e84fa0b010bc11420b5d2060d978ea77845436","s=
rc/zlib-ng/Makefile.in":"3c46b870035b795f4e9c365a1688392377dbfef90cbb81429=
4d4d33d3ead1f4e","src/zlib-ng/PORTING.md":"097591000d86f6265fea6cfcd226359=
84eb6c9f54e8690ca2667cfb92a11919d","src/zlib-ng/README.md":"5e1032d7f44647=
ce88475872a4fff9bd1671e3bedf8bdca43925dd8fde97c8b3","src/zlib-ng/adler32.c=
":"b96656d1fc0133c44caeb3509d545d0b68580e77157b8c6f0fd6dcf681726ea5","src/=
zlib-ng/adler32_fold.c":"66b32963c96e43c84b53eff737d11186bf165e04a48e9c332=
8faa5c86ce8128c","src/zlib-ng/adler32_fold.h":"c40114c2c742b6410e54b58ea02=
533fe6e9ae0ca62d3453e5d2a1725d33e2be4","src/zlib-ng/adler32_p.h":"fa8b9637=
1128c54ed9c2a06175006738d395d380672b4894c32fece37b8a96a0","src/zlib-ng/arc=
h/arm/Makefile.in":"67e906298f31bf83feeb526c9d09a65c1d39517423ded8f50cfc36=
9f05a1d629","src/zlib-ng/arch/arm/acle_intrins.h":"313646b741417269d175b26=
20c7bd2cf1cb5bfc940c5bb3dd600189fce27cd79","src/zlib-ng/arch/arm/adler32_n=
eon.c":"bce2fe7d3a5f663ba2894d3c9b13151c5cd4c16bcc1d31ac32a85713ecc20f8c",=
"src/zlib-ng/arch/arm/arm_features.c":"dc2fa2e5593f0ff1f837138b99f26d1f805=
f82f69d2721cc2b2a386b5dac7b1a","src/zlib-ng/arch/arm/arm_features.h":"0667=
e8baaba1edfa60ec6faa5ce35eb35f5e91c85633e831f397a9af3c220b9e","src/zlib-ng=
/arch/arm/chunkset_neon.c":"042d3e6f865b5b0bfec8b5196288cce2ec47e9ca2c8a5e=
075580dd302238e421","src/zlib-ng/arch/arm/compare256_neon.c":"7eec4ca0415d=
ec895a461a4d1fcd3068e0d68482d048257022511b3490372ca3","src/zlib-ng/arch/ar=
m/crc32_acle.c":"3fa85db742ee584f3787e3d131d92d6196e44f9df5f3034d804abc78c=
bf81d3f","src/zlib-ng/arch/arm/insert_string_acle.c":"5ca256a6f796d8bff478=
671ae5b0d7cfe236b58abffd6a99bb2cac097fe7935b","src/zlib-ng/arch/arm/neon_i=
ntrins.h":"22262195cbd668a11953449c9e1be3b9b3374469d21f3e73ab34c6ea0dcf275=
f","src/zlib-ng/arch/arm/slide_hash_armv6.c":"9abacab94d74e7d8b1d863f20aa9=
7fb5380059f08b91480a14377d3ed2d1f768","src/zlib-ng/arch/arm/slide_hash_neo=
n.c":"7c4927c0dc8b28c5fba1efb30273653e71172ce051a0341ce2f1d2c0bbfa418c","s=
rc/zlib-ng/arch/generic/Makefile.in":"93255a212569673a3ce9e7fbaba789b3cd82=
375e7f6459c22c84bcb7a12097c7","src/zlib-ng/arch/generic/chunk_permute_tabl=
e.h":"3f1e09e697a9b2dff4395aca356e61765c44511a9dc653abb6998671afd20ae6","s=
rc/zlib-ng/arch/power/Makefile.in":"015cb5635da6dbcd54c6bcef5d8958c6ea5369=
b55797e342a2632b0bf03bc4ab","src/zlib-ng/arch/power/adler32_power8.c":"e5a=
5bfdd9963e8f906e36978f1a655139908740559da2b382ddd5f3e2ffe6f56","src/zlib-n=
g/arch/power/adler32_vmx.c":"841a7e3792d1f68a0925969d6f9737cfb2b650b3a8272=
1a88f1e5648f7b0a58a","src/zlib-ng/arch/power/chunkset_power8.c":"569a7dc68=
6a0d80686e516ec8fb7c2331225f706b37ccbf0874e6d822e82f806","src/zlib-ng/arch=
/power/compare256_power9.c":"cfdc33f5e605fd41351423fda0eaf7692f9e9f0083d6c=
4ac870c6e467d534f48","src/zlib-ng/arch/power/crc32_constants.h":"d73e3b902=
5de9fade7fa3ba2bbf5f56a1499a84c53d8ca7f5e744a0714d8599b","src/zlib-ng/arch=
/power/crc32_power8.c":"add20ee86ff5c28396ee2e7f77d825d7e425b8946733195369=
0c40f40b5dba41","src/zlib-ng/arch/power/fallback_builtins.h":"78a8da60bad8=
ba01278e495482108adabf9e96bdb214e869b61ab1f63f518c9b","src/zlib-ng/arch/po=
wer/power_features.c":"4dc4c14dfa2d3333c73fad7b1f7a79d3fff68c1d1fd643012fa=
f82bd4114553e","src/zlib-ng/arch/power/power_features.h":"c9c47cfcfff347e7=
9f83f56a0677565d40299e03ffbeb918c4ae69518d290ada","src/zlib-ng/arch/power/=
slide_hash_power8.c":"58d93cee1a2cf14f13a8e9e31ba5149fe2b1e069846f52ac1f11=
c42cfcbd49a4","src/zlib-ng/arch/power/slide_hash_vmx.c":"1b6297a9616456ba5=
34bc1d93afcb99e36dac357be68aed106bb71dfea621a86","src/zlib-ng/arch/power/s=
lide_ppc_tpl.h":"c8900c594591e1aba3188f97c374e5561fe1e96f653c668352b25647e=
449f4c0","src/zlib-ng/arch/riscv/README.md":"7a3e00ab7fe5a66cf5cfe5671e9e8=
367e6c655a3b72d12de18d840538c506ef0","src/zlib-ng/arch/riscv/adler32_rvv.c=
":"e2472cf46b376a0ed8b7545a3192d195659353e093772216f0d28ae7d75afb1a","src/=
zlib-ng/arch/riscv/chunkset_rvv.c":"d5b0fd27dcc8d4b3773caae16290014fdbc001=
1cf62e7f63a4e5d897149b165e","src/zlib-ng/arch/riscv/compare256_rvv.c":"4ed=
8d6b39ef2218c1d474ab586fc19d7e0821445241e5ccd6a75992cb17b3bb7","src/zlib-n=
g/arch/riscv/riscv_features.c":"a117eada0164dd92c06e9804a70fd2f434b8d14a6d=
443f0b3513330fe08c18a3","src/zlib-ng/arch/riscv/riscv_features.h":"26953a0=
9f72edb0e66978044d75e054e40d36d2b62244359b5e5e4ab936d2c9c","src/zlib-ng/ar=
ch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337b482fcb72d080b0897e48abc9=
753b51d40facd9a1a1","src/zlib-ng/arch/s390/Makefile.in":"8cb582f8e6ccd9146=
f64214a513e546122976c60e782cede19b282bf3b519235","src/zlib-ng/arch/s390/RE=
ADME.md":"0dae0e510935c5f91e00dfe0d57a9b7a82891ff59edbd14b64b54c950327d708=
","src/zlib-ng/arch/s390/crc32-vx.c":"c5250cb1df20eadcf0c56ba68e0dd7cf43d9=
36f92f245aad2bfb519988f902a1","src/zlib-ng/arch/s390/dfltcc_common.c":"9a7=
01d5f973c07e054797ed030851171abaf20a40a4ab2359914c737b0ab9671","src/zlib-n=
g/arch/s390/dfltcc_common.h":"1d042b79da6bbcf4e1f5b32ca017bc49fa89129c7a92=
5ea17b931de34012ef18","src/zlib-ng/arch/s390/dfltcc_deflate.c":"146569d921=
d68fd9af7b67a74bcf0aa41108a4072564629db7ad6c2dc8a429ef","src/zlib-ng/arch/=
s390/dfltcc_deflate.h":"309d7c9bc4e5de3196ebe61a2e5c17e07bfb66bb8a170562e9=
0e9105e68ab302","src/zlib-ng/arch/s390/dfltcc_detail.h":"6ba837c1522d85df5=
99d5baeb5e0076d67355979a9768da9b6a095d65e645d41","src/zlib-ng/arch/s390/df=
ltcc_inflate.c":"b1eb56def7acf39aabb7abea8249a48c4af0dfea7a63ac380e5437d43=
2ff9d9e","src/zlib-ng/arch/s390/dfltcc_inflate.h":"06dc026f991022a7be73865=
a554785b31d167261c4006ca6438de7ca31893ceb","src/zlib-ng/arch/s390/s390_fea=
tures.c":"fd99ba0abc73a37168a5c369a0714e3f35816a792438bcb1e8e60f5dd2983293=
","src/zlib-ng/arch/s390/s390_features.h":"f65396333635e937634dff42a43a8bf=
a272f53ac88e763d52d4c56241b1eaab9","src/zlib-ng/arch/s390/self-hosted-buil=
der/actions-runner.Dockerfile":"5d4c45e9929fd9736640aea294f1d13f346fd52a4f=
4771073be32abe96ada971","src/zlib-ng/arch/s390/self-hosted-builder/actions=
-runner.service":"62a19075adeddb3bee57bbac81c7acadacbf9c288e2b497e36ff7f2b=
3daa7558","src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/actions-ru=
nner":"f647e18728ea15fe927ac9f8cba83a5b343654a0e91b5ebe653bae7af7375110","=
src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/entrypoint":"add4ebdc=
4f06ed15bb1de12a8c9ceb370a60baebb0932a1026a75433940ad3df","src/zlib-ng/arc=
h/s390/self-hosted-builder/qemu-user-static.service":"54551049f6181da88700=
a2a944a72b0af3b8abde876fa28e1348deb5eb96c91b","src/zlib-ng/arch/x86/Makefi=
le.in":"ad6e71fe6e42005b65db8454b0ea0a6c9ee91664698c08729c01e6b00d0df933",=
"src/zlib-ng/arch/x86/adler32_avx2.c":"cc0598333eff9110b5e8c0dc38ba543bfdd=
3ca5a66825f440909ba7a8923fdd3","src/zlib-ng/arch/x86/adler32_avx2_p.h":"45=
e6264edffc737081f55a5b5e85b28d9db0b27b63183ffbb492f8c11bc670a2","src/zlib-=
ng/arch/x86/adler32_avx512.c":"7a949d8ad2d15709d33872ee97e70a2e0cc2c6c375d=
7064cbc02b87e70905d1e","src/zlib-ng/arch/x86/adler32_avx512_p.h":"1b4beda1=
1693ac03e4b20e054a765df427f845a279bce547b8208d20f5a302bb","src/zlib-ng/arc=
h/x86/adler32_avx512_vnni.c":"9d11d2049df211f11a48a91e340e20686763c1eac204=
63dcd27dd7bfaa159f76","src/zlib-ng/arch/x86/adler32_sse42.c":"1d2dc53b05ac=
75667c6d1c625c8c391e4851b28cff9e97ebfdb774767581fff2","src/zlib-ng/arch/x8=
6/adler32_ssse3.c":"7666f99b2e530265cb9848c1047ccc150da0add19b41aa2d7756c6=
17377622c6","src/zlib-ng/arch/x86/adler32_ssse3_p.h":"5aab2f802ba6bdebc63b=
411018e5116fe26d38e90adf353646b65af4ebe7fa40","src/zlib-ng/arch/x86/chunks=
et_avx2.c":"ac300f37fbc99ab2d3bf47a640bdf2d87ad8358ef081eea21c541966830281=
b3","src/zlib-ng/arch/x86/chunkset_sse2.c":"a400a128a84185c945f9ac9303e17c=
944f2008085d7a4402d279bd59893dc89a","src/zlib-ng/arch/x86/chunkset_ssse3.c=
":"1f69ef9ae20cca1e4fc6924462255b8969685387c10694ef1dda28b3098d6f6d","src/=
zlib-ng/arch/x86/compare256_avx2.c":"2516d00faa6939e61dbb0978a9c4c81f9e3a4=
2fd053b2a2241673da7cf4fc781","src/zlib-ng/arch/x86/compare256_sse2.c":"3b9=
83708034f33b5da49f6f5041351a2e66358c76645c552f6e4dc37fb890a80","src/zlib-n=
g/arch/x86/crc32_fold_pclmulqdq_tpl.h":"1b3b79dabff0bf7ecc3b07356c5aeb6ae1=
fece0fd70ac7e235aacce3da77ea19","src/zlib-ng/arch/x86/crc32_fold_vpclmulqd=
q_tpl.h":"7eddba31e3d1b1808fc6df9f96ada03c59952961af895d8538f5a8292392b5cc=
","src/zlib-ng/arch/x86/crc32_pclmulqdq.c":"f247408c353bbd0fcafff23fb97aeb=
4d9a72e0a416effea566183b9b5dbedf7c","src/zlib-ng/arch/x86/crc32_pclmulqdq_=
tpl.h":"5fedffe4b853cabfef09cfcebb501cd53a97c212e470bdfc65c28dc998840e05",=
"src/zlib-ng/arch/x86/crc32_vpclmulqdq.c":"870d06ca9fa7b48db4b720d2fd62620=
94200cf6180fa76a601d17c722bf0e406","src/zlib-ng/arch/x86/insert_string_sse=
42.c":"28a6d418a9563d464414c3880d6053c656aab40c6ebe21947cf17687d82e547a","=
src/zlib-ng/arch/x86/slide_hash_avx2.c":"9740a36bb4dd90f40394344026be9a13f=
3acb6e85e6b7681c30fd7f7cbf8e28e","src/zlib-ng/arch/x86/slide_hash_sse2.c":=
"fa009305a1c82708638dff25e037067656350303b25f5774489417e096c30ecb","src/zl=
ib-ng/arch/x86/x86_features.c":"b755befa09a56ed27d70f2be93b0a72a355fe8b490=
827b55fce60ab51693c70d","src/zlib-ng/arch/x86/x86_features.h":"6429fa7345a=
9892633c884f7fc26f9558d86c77df9e8589ba9623a27e1d9fd57","src/zlib-ng/arch/x=
86/x86_intrins.h":"707b836360628cb34a0fb7fa675b5e8674d146f55b1f60fd739b85a=
a5dc935cf","src/zlib-ng/chunkset.c":"531f58c77c184b225304888ddf1930a76beef=
be4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"9919e10e9c22443=
16e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng/cmake/dete=
ct-arch.c":"1af38707fadc192c8e4a28715c896148a0909be821fb443919e191ff2374ff=
db","src/zlib-ng/cmake/detect-arch.cmake":"85a2eed469fc7765e51c382f475868a=
644036f057f5b749d3ef59eec2b4b2748","src/zlib-ng/cmake/detect-coverage.cmak=
e":"4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a9","src=
/zlib-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a31fc7a7=
8f0beeac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsics.cm=
ake":"cfad619b863adf57132434f7b9c36c4f1a0466e5fdb11ac673e703ed5e471cd0","s=
rc/zlib-ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5d14=
70ef48852f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cmake=
":"a8c8f70e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src/=
zlib-ng/cmake/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1=
de3705b39a66a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"0=
5e38076fd6ffb9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib=
-ng/cmake/toolchain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b=
1beb5d16876b741717673341","src/zlib-ng/cmake/toolchain-llvm-mingw-aarch64.=
cmake":"4deffb541ecd21ade019daa2e96e832ead8c2c62b633bedb8688d0e7c7012d33",=
"src/zlib-ng/cmake/toolchain-llvm-mingw-armv7.cmake":"3e95adbade93ec162478=
de3339427ed88b12c922f4975c2918977859325f5459","src/zlib-ng/cmake/toolchain=
-llvm-mingw-i686.cmake":"1064a1ff2bab21489c184c1cc2b07181ebbbcc32e45c13cf8=
ed6b9ec60560c2e","src/zlib-ng/cmake/toolchain-llvm-mingw-x86_64.cmake":"57=
7d333ad70cf27ededc75554428368e84c334cc7b716e18113620f5e7edf305","src/zlib-=
ng/cmake/toolchain-mingw-i686.cmake":"df9000354b820d3713d1469edc9f94cd0953=
89b0cca83965730b8e64857fdf3f","src/zlib-ng/cmake/toolchain-mingw-x86_64.cm=
ake":"ee316e6e3202919da5d497f9e246466fd715fcf079cb5b4afc4774089d1fefad","s=
rc/zlib-ng/cmake/toolchain-mips.cmake":"0d0d00b809a30021bb4b9e3ace7371200b=
b4bfa6509813c829ca0cb569c7af68","src/zlib-ng/cmake/toolchain-mips64.cmake"=
:"f19574aa068ca4374b657ce7bd0517b9297c622144814a095e26db05f0a1cd20","src/z=
lib-ng/cmake/toolchain-powerpc.cmake":"9bd6fc58ce5b70603657f2c195c4a5cf52f=
ae96ad63ac787978831c5858f762c","src/zlib-ng/cmake/toolchain-powerpc64-clan=
g.cmake":"aab0b9e0f19a281dc99f4dfa5675976c40b5fb7f8139dd2eb0901fdf3cedc952=
","src/zlib-ng/cmake/toolchain-powerpc64-power9.cmake":"57c789c468e733971c=
2654faf34f7dfc9dd1e0e5bcabbd609dcd01dcbd25c487","src/zlib-ng/cmake/toolcha=
in-powerpc64.cmake":"917fc5eef84921d8b38f43c2b4f60870965b4eecc8f018c7b3499=
e1142c715af","src/zlib-ng/cmake/toolchain-powerpc64le-clang.cmake":"47ac4a=
05b61210a83c7845a5522b91740bc8a7bb897312cc37131f85bae9e1b5","src/zlib-ng/c=
make/toolchain-powerpc64le-power9.cmake":"b295b61ea248d8ef98d9276fad3db143=
a6fb80ab738c54bf88cb594d82c70a8d","src/zlib-ng/cmake/toolchain-powerpc64le=
.cmake":"5b2edd36d62de513db2d32bfbf779979d81ac527b981cc3379a4e933fc5a94d1"=
,"src/zlib-ng/cmake/toolchain-riscv.cmake":"d7b4ac4be3651aec2e55788d815141=
482d4fe92713713fdaba9215dbbbc9b88a","src/zlib-ng/cmake/toolchain-s390x.cma=
ke":"cf52cecea7bd2a9d1ff5fd8edcb03c531e3b404bbcd15a15dec2e0e19936f2ac","sr=
c/zlib-ng/cmake/toolchain-sparc64.cmake":"e543062485d06a7e0fec8135887c5e73=
363517fa4babc23ef7b780916d75afda","src/zlib-ng/compare256.c":"4890f97239f6=
3dfbbc986ddd05039798752ec0ad530ff7d25978deb44f774ad5","src/zlib-ng/compare=
256_rle.h":"30fca191b0474e1549d3ce292bb11ee90dc3dc9fc685932cec3971c1d0e8f6=
52","src/zlib-ng/compress.c":"f7c69a4d2f3b87ff0094115977dde1cd17703cc9856b=
a19489dd94e0ed16b646","src/zlib-ng/configure":"5778b60178bd2cf770fc01c5ce2=
562e50c1859a0cc67f8b522deb38ae4dbab77","src/zlib-ng/cpu_features.c":"aec35=
9d85d64c2ff88132a123406726bd966e0d56d0dc8ce1d5c3f25e1801440","src/zlib-ng/=
cpu_features.h":"21c43d2a8375e73abea63082e08d9279eaf457970d34f877830bb3157=
5498a8d","src/zlib-ng/crc32_braid.c":"8a33cffb026b82a027b45e041935836b36b2=
d075796e5498e33ce64ec0cf93e8","src/zlib-ng/crc32_braid_comb.c":"217741d3c1=
c0018bb12ab22c987804634605f5b7ad6bd243e25eb0499c80af5d","src/zlib-ng/crc32=
_braid_comb_p.h":"6c8035e05d30a6241be55467fc59e4d7deda6b618b955a11339ffee0=
8a39c75a","src/zlib-ng/crc32_braid_p.h":"951cbd948664498dd8a56393bc88debda=
d8b21dcc8e1f16d883c07170e4adb4e","src/zlib-ng/crc32_braid_tbl.h":"e22af112=
e3c1c8bb4065d39fe678eba71dd08893eb06f9414b02f4cf5a6f46de","src/zlib-ng/crc=
32_fold.c":"f6363abbd1e167bc7a6fa8f92e5211f4fa3e70d30fa5e10fa6f416f5db3726=
78","src/zlib-ng/crc32_fold.h":"42412c5029057579148a2238b0bc882f294f661d2a=
f102bd9213531894302f29","src/zlib-ng/deflate.c":"70c72cdbf88987660e787a996=
58641bce36fff4848f9bf395f3727df9543664b","src/zlib-ng/deflate.h":"f45a6097=
10150fb758ca89b36a7f5a029b525fe70f0e3296a4847d73872db2ca","src/zlib-ng/def=
late_fast.c":"52648097b16070c156c27d38566720eca08d48e35cd89a80f196f0e77951=
112a","src/zlib-ng/deflate_huff.c":"923d316676c00f307a7d6a58d77f9364f06607=
afcc686b464b557ff5478f8b6d","src/zlib-ng/deflate_medium.c":"d3172c1ea0ae1b=
c2e3b7691b005bbae35e84b7588ef2f5805b9dd0c4ccecbd67","src/zlib-ng/deflate_p=
.h":"2eaac98e9232959c730d84a408bed641be817dc3468aeb427062d06b02eb80b4","sr=
c/zlib-ng/deflate_quick.c":"3825eb4d22a150f9cdaba93db890d95b8d9e9d0f3f1052=
4fb27a9a1289aa4c0f","src/zlib-ng/deflate_rle.c":"5dcc0496f74b5ce677ab5a58e=
a232d0ba653102d2f71cf35daa6069ef88b7af6","src/zlib-ng/deflate_slow.c":"544=
9816c381138eb07cd54ec7c0c77fb811f4f274c27bf15d26e008de6a9eb5c","src/zlib-n=
g/deflate_stored.c":"89b81c09be2ffd84138940ac6c4e9688f956603b45eec6d0d52d5=
79cac3f15e5","src/zlib-ng/doc/algorithm.txt":"0d21a0a4c47e512743389628d138=
5a831a5e5ff716491095a382b923287f4223","src/zlib-ng/doc/crc-doc.1.0.pdf":"0=
64f9252d6e2e15ea56c2bd18e160e5c9c84bcd137c11a7af497aaa511ace998","src/zlib=
-ng/doc/crc-pclmulqdq.pdf":"3cf18f738dd0da7e5a28ff999d987bb61ac42cce354bbe=
e1364d06fb3944f7fc","src/zlib-ng/doc/rfc1950.txt":"8f0475a5c984657bf26277f=
73df9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib-ng/doc/rfc1951.txt":"=
5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f301350009","src/zli=
b-ng/doc/rfc1952.txt":"f7c810fd9d719d002d605207a9b880600f71d039b9626c5b4b0=
3f2122438dd2d","src/zlib-ng/doc/txtvsbin.txt":"47c273bb22c9773248d380549a3=
30e5c262266b1292154b0d3014f731cc73f47","src/zlib-ng/fallback_builtins.h":"=
c02e559d19f351f2f9371ee2042ca6a725d14f17862dff2414fd2ab3d7984875","src/zli=
b-ng/functable.c":"d7ac98c7def281c707796a4317e2dd6754d654bc8d833ae67a77f47=
a7c1dd5bd","src/zlib-ng/functable.h":"64fbabaa8459898d14cb88078676c42fce12=
a951b4b1d83f9085e104ad407a47","src/zlib-ng/gzguts.h":"d9a4e984bb6c2ebe5c85=
8b37b1c6411af1edc21c3c15d63b6588016b71369b71","src/zlib-ng/gzlib.c":"91011=
bdfaa99bb5e49aece64fdee995207b1ce5a96227990f16f9aea55026c8e","src/zlib-ng/=
gzread.c.in":"3501e5124923207b2603d9695c3bad1815ca2dc8f18b6525bdd5dfea6031=
3acd","src/zlib-ng/gzwrite.c":"9f474aeefaf0150d8871eb9202ebd43a28f18bdf39e=
aca4f35cfb52227e74c63","src/zlib-ng/infback.c":"db99c5b105c34c7c2967bd97e1=
6f976217530c22d6545e61cbf657522e24de87","src/zlib-ng/inffast_tpl.h":"51622=
f34e8808798a43412b4fde62ebd58ba012f5452bf2ad9a8001c98539166","src/zlib-ng/=
inffixed_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe7ee0111ed8e32a26bcd52187=
f364314","src/zlib-ng/inflate.c":"2c1bd0f4939c372e49a9ee0ec8a8cdee369d9c6c=
10124b4e11cd197f44ce3a36","src/zlib-ng/inflate.h":"1750ab33be4461f2e6b8e43=
bef5da11f3db49d5d2a3eacd03d881d33c1df7def","src/zlib-ng/inflate_p.h":"4a31=
088faf818d2615de31b099e8f55ee8463166477d6cb5d6763c913b6acef9","src/zlib-ng=
/inftrees.c":"206fa4c762203823151dcd3b1a5b389fb40efd4c88aeb2bc302aa1d5cfd6=
d6d5","src/zlib-ng/inftrees.h":"2ba1beb76d7922fcb37708809e31f62ee366827da8=
0faf09a7e461b439afd291","src/zlib-ng/insert_string.c":"7a9455cbb3ca8fe6e71=
11471b9f4c0a32fb49a6d0ec589b027dc2cb2b65c8dce","src/zlib-ng/insert_string_=
roll.c":"4d05f19591a5c29d2da398e10e9d0b050d738cc8838d8dda4beb1cc7281ede07"=
,"src/zlib-ng/insert_string_tpl.h":"972e69808ce5e74d0c54af4ee447b996b2d056=
3eb861b90856693037ce8cca9f","src/zlib-ng/match_tpl.h":"1e20d0ef73a58266062=
40f4efd2a8e993d203f376017397342b9899b1f919276","src/zlib-ng/slide_hash.c":=
"74adb34a4a35331db810dbb5d740af10cc1db7d24a89ea387aa2dec956a05b2b","src/zl=
ib-ng/test/CMakeLists.txt":"d9c0e5c87fef7b26826f8acc84fb34df0c90cf8804818f=
93fc12edf91d92d744","src/zlib-ng/test/CVE-2002-0059/test.gz":"60bf96b8f433=
bd7e057ce3496aceaccd70ec80f596a4aa8bcc7786056705ce66","src/zlib-ng/test/CV=
E-2004-0797/test.gz":"38caae524705f676bde13a8df9fc8c7d2fe105ba6bdbab62a405=
b0276fd3aa2e","src/zlib-ng/test/CVE-2005-1849/test.gz":"e4d5a60617df4b5dd4=
4eda94751ce1eacdb325792bba6e3cc4676719a3adf742","src/zlib-ng/test/CVE-2005=
-2096/test.gz":"8f702d4861aa3ec98ac03a59ff26b430939630cb5cd4266d2658d3b836=
d576f9","src/zlib-ng/test/CVE-2018-25032/default.txt":"d7f8278db331c47bd12=
08bf41e7903cbddee4f7b47c666c40afdd3c96237752e","src/zlib-ng/test/CVE-2018-=
25032/fixed.txt":"3b27a98edd2f3f580033f9add11d3469d7808c969a1128ee00c18ac7=
a12cef57","src/zlib-ng/test/GH-1600/packobj.gz":"372ba8e7aa3bf258e85c793ab=
e1268965765a9f1bc6e2a0e77d3b723a4a019a3","src/zlib-ng/test/GH-361/test.txt=
":"358497d0a7251ea42101dc77b02337f46fd89af09643a8288e2a3082e5d24128","src/=
zlib-ng/test/GH-364/test.bin":"af5570f5a1810b7af78caf4bc70a660f0df51e42baf=
91d4de5b2328de0e83dfc","src/zlib-ng/test/GH-382/defneg3.dat":"b22bef6b7392=
401c9e7b079402c4a4074053d7a914d050400e37fd7af6fe26d5","src/zlib-ng/test/GH=
-751/test.txt":"b83d833803b7bc3124fb2a0034081f0b999ad10c33a8dfa3bfd181dc07=
8ae3ee","src/zlib-ng/test/GH-979/pigz-2.6.tar.gz":"2eed7b0d7449d1d70903f2a=
62cd6005d262eb3a8c9e98687bc8cbb5809db2a7d","src/zlib-ng/test/Makefile.in":=
"2eed5e763754e1f0f0ee1908e2f8080a2fa9e5f2770b3fc8d74b9975b4cd2bb5","src/zl=
ib-ng/test/README.md":"6a34f8fc7a0144958cc9a0cded46fc38a7e15aba3dfa5bf56d8=
d86c3fb72d82c","src/zlib-ng/test/abi/ignore":"36e1928ffa34c21c1d2fd783633c=
9975e1ff282682ba2eca14b61b87650a2e13","src/zlib-ng/test/abi/zlib-04f42ceca=
40f73e2978b50e93806c2a18c1281fc-aarch64-unknown-linux-gnu.abi":"e55ef93145=
cb4ceb2e22562ab5c18a2e26f8330862ed9468df7ada66a47dfe08","src/zlib-ng/test/=
abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-arm-unknown-linux-gnueab=
i.abi":"d45ec6ff3f41ce11713a39aaad08e4ed9d21a165754a1c5a5e5f123c4daf8241",=
"src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-arm-un=
known-linux-gnueabihf.abi":"2cef33db7275ba069bfa3a929299dcb8f1529f3d0ad344=
c1e0ef483905e996c7","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e9380=
6c2a18c1281fc-mips-unknown-linux-gnu.abi":"25cf82ce8d5afde37456ce22943358e=
6d5f4dec31c1d1f732a1b07f34d7003f0","src/zlib-ng/test/abi/zlib-04f42ceca40f=
73e2978b50e93806c2a18c1281fc-mips64-unknown-linux-gnuabi64.abi":"59e435fa4=
2a1aacd30d24d184d1ae505392123a8f16eaa0ca55e061ff2c427cb","src/zlib-ng/test=
/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-powerpc-unknown-linux-g=
nu.abi":"5b4c5724c018d4e5820cfd9f94526ae41101fbcfa960ca98efcc06ed33a5b7ed"=
,"src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-power=
pc64-unknown-linux-gnu.abi":"e4d05062bbbace98c02f297585ac69a88e6b4f34122de=
6a854e5176d6d81ef9d","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e938=
06c2a18c1281fc-powerpc64le-unknown-linux-gnu.abi":"bc41acbb1e207e8dfbf0f4b=
d628a0d32b94e288d324f924dc353898c3ae3bd37","src/zlib-ng/test/abi/zlib-04f4=
2ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu-m32.abi":"5b79e86=
fc4f99e7d5c38b08e63ee347f29ed5312ac7dac16459b3d4562c04a50","src/zlib-ng/te=
st/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu.a=
bi":"568cdd3893cd364fcdfdb1536f394dda4d237a03a0a7fe80938763b73739092c","sr=
c/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-aarch6=
4-unknown-linux-gnu.abi":"af41851f1b97ccb94e534cf3e54985fda0700c94d8fa850e=
c021f4b7d907f480","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c15=
5e4baf80882311-arm-unknown-linux-gnueabi.abi":"b2197b5aa7145c62c39775e7e97=
ce8de4d00b44f4f2ecded47aec8e725cf4563","src/zlib-ng/test/abi/zlib-ng-e4614=
ebcb9b3e5b108dc983c155e4baf80882311-arm-unknown-linux-gnueabihf.abi":"a037=
a1494a5f724462b6fb34d595b7d1517cdd60af1d890d00fa557394c0d923","src/zlib-ng=
/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-mips-unknown-li=
nux-gnu.abi":"8cf1dd6da2c8fadb53748687e7cae304cef025f490cd8a9d1970bdff04f1=
3ddd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf808823=
11-mips64-unknown-linux-gnuabi64.abi":"38549f6d4efc5a4e60e83dfee03f727b426=
ed969b6e476acf11ab1d5f562eb1d","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e=
5b108dc983c155e4baf80882311-powerpc-unknown-linux-gnu.abi":"09e7feffa1d24c=
f68cfd7d0c1a5a80a5d9d5df5bbda383b2a7d5f99f194a06fc","src/zlib-ng/test/abi/=
zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc64-unknown-linux-g=
nu.abi":"cb360745c650e62db182932ed37e7648d1fe939caa50eccf7f9068e653ce9a11"=
,"src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-po=
werpc64le-unknown-linux-gnu.abi":"75170876a3b207c383889bac021ae0ff710e2915=
ad8c6b5f02c38d6e3ef731cd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108=
dc983c155e4baf80882311-x86_64-pc-linux-gnu-m32.abi":"023ad5584f431bd2985d7=
231581058c249dcc0544b21fbb678ab04417c5e8103","src/zlib-ng/test/abi/zlib-ng=
-e4614ebcb9b3e5b108dc983c155e4baf80882311-x86_64-pc-linux-gnu.abi":"f07233=
6d8a54a31ae4e991ecd2e0482b3c8102e0256da5f020112aeb5a9d68d4","src/zlib-ng/t=
est/abicheck.md":"d960023cd80e04b2d4dcec8cdd3315c7292229d45a3301a5dc521305=
8ba22185","src/zlib-ng/test/abicheck.sh":"293af1e5c1e18133d1f27c9e34bdeb0f=
8b0123cf3c825562a11a31e87d2b544e","src/zlib-ng/test/add-subdirectory-proje=
ct/CMakeLists.txt":"0d5d9bcb4aac1e17b5146eb727ca95e4fb91fb098fe567925befd7=
a88f8cf677","src/zlib-ng/test/add-subdirectory-project/main.c":"0f84f056dd=
c067fa1374bea36c45c516b5ce1b4a78e8a381c06cce03320e66dc","src/zlib-ng/test/=
benchmarks/CMakeLists.txt":"3a9207269ce3ceb3b9351c8b68681cb316be79a686ac99=
becd27df7f0bc69601","src/zlib-ng/test/benchmarks/README.md":"f44de30583886=
085f4a3158040c795284cef19e32c50a80fff54608ab735e5aa","src/zlib-ng/test/ben=
chmarks/benchmark_adler32.cc":"d2de7d69b94aa6447804e3d42ed7c889b2d6a5e1d4c=
9f595a8eff2f919f1716e","src/zlib-ng/test/benchmarks/benchmark_adler32_copy=
.cc":"7c5617b6d014b4f1e0c116439fb4a6e0e720b4fcd132c68b8f1f49ea8aa06af9","s=
rc/zlib-ng/test/benchmarks/benchmark_compare256.cc":"2ffcc22f1fd7df9db92c9=
d97302e46f83811f5cadf35327387ff22f27d09ee22","src/zlib-ng/test/benchmarks/=
benchmark_compare256_rle.cc":"3631acf6fc6bca5a4028cf58dd25347bbe448e19bd9c=
ae1d4456ae30dfeccf74","src/zlib-ng/test/benchmarks/benchmark_crc32.cc":"cc=
1c6119ff9bd112999d0cd6ae62b1abd95268d8671cc9ee5abb7f6659496a74","src/zlib-=
ng/test/benchmarks/benchmark_main.cc":"67270b2efb97c24af9358220cd642cf0c8e=
d393d07f61abca31bc0c103b1bab7","src/zlib-ng/test/benchmarks/benchmark_png_=
decode.cc":"e9485de5e722ef1b62131a27a98d2cfe668ee8becbd5fc9938972022e07c8d=
60","src/zlib-ng/test/benchmarks/benchmark_png_encode.cc":"4b2203af2ef58f9=
5773ca6d82569f747f2cfb3c4116334871cfb255a0d7741e1","src/zlib-ng/test/bench=
marks/benchmark_png_shared.h":"2a02ef2aa7b7b60afd5e474ca729498c8e6a7873e96=
8634fd0c43d10d1506ca5","src/zlib-ng/test/benchmarks/benchmark_slidehash.cc=
":"d239dfced67f85fb2dcea7a6a03b2649a59a63948e9e6af8c2bd3653d73f8130","src/=
zlib-ng/test/cmake/compress-and-verify.cmake":"0dd1712183a15dd79bd2501dfac=
ef681a402493d23aa3439a9293c1ec5aca863","src/zlib-ng/test/cmake/run-and-com=
pare.cmake":"13d85c12c9d6c7b1b148bd0c5a5b4faa6a4b56f3823bf03c4f8d914c9c594=
9d8","src/zlib-ng/test/cmake/run-and-redirect.cmake":"7f08d18c09aa58113882=
ec760735a62a1723a5bfcae9f73bd3713a4dbaeab898","src/zlib-ng/test/cmake/test=
-cves.cmake":"c526d10727275eda6a6e5912a000e5f2ee369f904f923001f196b69eae7c=
f5cb","src/zlib-ng/test/cmake/test-data.cmake":"4b4e003f000fe15dc57052faf5=
637a85c9c7f3a6d07592184b87ea508b6fc0dd","src/zlib-ng/test/cmake/test-issue=
s.cmake":"258d8453dcea579d47abbedbe8e7d4f13d0048642ea3ab53880245998de4f22b=
","src/zlib-ng/test/cmake/test-tools.cmake":"d6cdc83cf1b5c6c342b461bed6c87=
d57c2b78bcac3f6b3e357bffba2181d49c8","src/zlib-ng/test/data/fireworks.jpg"=
:"93b986ce7d7e361f0d3840f9d531b5f40fb6ca8c14d6d74364150e255f126512","src/z=
lib-ng/test/data/lcet10.txt":"1eb5d7bddb1c3cb68064d5b5f7f27814949674b67025=
64ff7025ced60795a6d9","src/zlib-ng/test/data/paper-100k.pdf":"60f73a051b7c=
a35bfec44734b2eed7736cb5c0b7f728beb7b97ade6c5e44849b","src/zlib-ng/test/ex=
ample.c":"5c2d07af5ecf874823ca73e6ff0d292c5d3c5370104d87526169b6f222182dcd=
","src/zlib-ng/test/fuzz/CMakeLists.txt":"395049b7625f120abee1e118487c55a8=
bd3288d0974081ecaa8baf33f60e80c8","src/zlib-ng/test/fuzz/fuzzer_checksum.c=
":"68ed79ec1d7fefa548f4d32ab7885479442520cdf53ad59eadfae13e4b15efe0","src/=
zlib-ng/test/fuzz/fuzzer_compress.c":"3f507a18710fb2a1d87fde5cf3affc74b53a=
689e9d2ce6f887ee64eb778e568b","src/zlib-ng/test/fuzz/fuzzer_example_dict.c=
":"46541ed3ef9bb7378120d47133f18b4194e955e7a84a439647205de68e745c08","src/=
zlib-ng/test/fuzz/fuzzer_example_flush.c":"393e7872825bb1ca366d0d8552b9444=
2511ed4a557db6ece16540b79b7e9cbdf","src/zlib-ng/test/fuzz/fuzzer_example_l=
arge.c":"e3b91b1ced83dfe538e8ae5262f1756181a7785e8c2ab38ac2881456bd562277"=
,"src/zlib-ng/test/fuzz/fuzzer_example_small.c":"de9f5dc3182405750341a0f44=
c37bd8ba4f21d993284456ba8e6ce3e36d6b9b3","src/zlib-ng/test/fuzz/fuzzer_min=
igzip.c":"dbc35b317935ba7cd2dfbacc067b5b17534488dc9ac1daa2bb28b67b1b850aa3=
","src/zlib-ng/test/fuzz/standalone_fuzz_target_runner.c":"e6170b744faa68b=
f2a414e99fc87accf4db2a5e0eb58b17aded5c692ea493604","src/zlib-ng/test/gh123=
5.c":"057934cf585b9998478e3d77ecd0782d941e20ebe50688ef32b961559d6dfe2a","s=
rc/zlib-ng/test/infcover.c":"82ccdf5b2bb081b9da18c55c0078ff030ae145a4943dc=
90bb85c4cce00e9deb5","src/zlib-ng/test/minideflate.c":"1b2d38cdbcb8e2c399b=
7dc9db59fe95b19f0c052a79dddf91fcc0733c898d389","src/zlib-ng/test/minigzip.=
c":"154131d41a881ef3264abb9eb70f7cdc6782718a2164f4f16b63b4e5363ca313","src=
/zlib-ng/test/pigz/CMakeLists.txt":"e55880cb8b15839774f2387c07aaf42df680ce=
c0305522ddecbe5f638e5af2d9","src/zlib-ng/test/pkgcheck.sh":"61a6ebf6ef9fe0=
5935467b29e25669fc44bb6240ea0ca87e9c066d982032f4b3","src/zlib-ng/test/swit=
chlevels.c":"1c726e63cbe24fc12c88e9928db5a1515c18364987dfe588daabef4f8b1a3=
21f","src/zlib-ng/test/test_adler32.cc":"aeb9533ae9be0f76879100d038980f373=
1ff4c249b4de105f2df6f371a7990a5","src/zlib-ng/test/test_aligned_alloc.cc":=
"bebdd6dba3c7452e7d8557c47b14226209175fb5fe313b176cf752848117536e","src/zl=
ib-ng/test/test_compare256.cc":"4362eccf7b473d82778fc4171552f8160b54b6fc61=
95bf930cd0e988dff5a093","src/zlib-ng/test/test_compare256_rle.cc":"8428d82=
04d0598cd1071f3db9176b42fd423e532051cd14fd91e5835a01ba203","src/zlib-ng/te=
st/test_compress.cc":"32d3bb507a95d56d0441280a04569164d19a8241d85084a9fcf4=
9f51afb82fcf","src/zlib-ng/test/test_compress_bound.cc":"21f71385edd73f92f=
40a9451673bdb9ea3f82a49e7f4d4bdcc4b74b086320b12","src/zlib-ng/test/test_co=
mpress_dual.cc":"a76759d3d5c54315a4ee3197109a4517dfae9931eb65ae8cbaffd8a58=
bb562e9","src/zlib-ng/test/test_cpu_features.h":"28bbb2bdf56ee7988d4fdfccf=
4c6ad584bb8b39c4ae80fdab12effcc33c4d8ae","src/zlib-ng/test/test_crc32.cc":=
"57a428c33f3158f1b78840b779dfb46f55a943fb5e7d2c23541b9ca7090d7264","src/zl=
ib-ng/test/test_cve-2003-0107.cc":"629f1fe659558c9deb767b3fbbb615539b0458f=
8b67a405ece924cac6bebb531","src/zlib-ng/test/test_deflate_bound.cc":"eecbc=
494f22282bfd94a2545fc142b8fdb5582991c22b6e50fd46c40885ad81e","src/zlib-ng/=
test/test_deflate_concurrency.cc":"27a91c74cf9811921bc2424c235e540a18ed638=
53d37e29814a60ed21f1a8654","src/zlib-ng/test/test_deflate_copy.cc":"1a286b=
a7772bb1a6d06233b075a83f3f1814bab2fd7d3757c090f5db25db90f1","src/zlib-ng/t=
est/test_deflate_dict.cc":"3395afdc925059faa1b334bf8a497803132f9ca7703d48d=
ff0ab0264f5292f73","src/zlib-ng/test/test_deflate_hash_head_0.cc":"2d0b7bb=
7dcd00a630358e6c3cd79676a838efc262794b751b42d030d949e7587","src/zlib-ng/te=
st/test_deflate_header.cc":"643763a811a3673a05959eb6dfeffa3ff25dc3672f67dc=
8a9f1406a31812068f","src/zlib-ng/test/test_deflate_params.cc":"7c747362cac=
9f74b2bb8e8d276539807e8222b18db172b81ccbaf96235b8be61","src/zlib-ng/test/t=
est_deflate_pending.cc":"1a0e700d3a2863b6087041fef379bd683e882d5932840fbec=
b3e0b91e74565cf","src/zlib-ng/test/test_deflate_prime.cc":"d98d4aee8c240f5=
bc3b3b83f828917586b846850ed82ade6f5f728a4281a1321","src/zlib-ng/test/test_=
deflate_quick_bi_valid.cc":"9706d0bf9d844b21f1655498bf0f9901c7dfc272cdef37=
f2d1af238c71df611c","src/zlib-ng/test/test_deflate_quick_block_open.cc":"7=
edb512a287542f83ee448fbcafc3d654b62a36440b6474e9cae3bb5d36577ab","src/zlib=
-ng/test/test_deflate_tune.cc":"dad52ad7941aca761ff177877a0d60f1b68b3a6d28=
a8f4bd382005f3c04bad64","src/zlib-ng/test/test_dict.cc":"2bb6c32ec0ea76561=
172e0b5e8c6a7bf4f64efc2b41534b42ec1d6c3d0990897","src/zlib-ng/test/test_gz=
io.cc":"337f711eb6e80e77fd28963c89a646f6528d635036cd0367c398387e0a72cfde",=
"src/zlib-ng/test/test_inflate_adler32.cc":"0967f8e72388a8232bcc1436196214=
ea1a13dd0fbd5e7633e24a9246abc2a950","src/zlib-ng/test/test_inflate_sync.cc=
":"fbb1121ea5b5448723c6d6d8692110c7362e6833fae22afcd46909d4ecb1289b","src/=
zlib-ng/test/test_large_buffers.cc":"0c76a002071e6280d6e6b380db5e1ada00730=
b0534722ba5c208cb1e51de0b7b","src/zlib-ng/test/test_main.cc":"884dcbfb7207=
f541ef82bc9fe6f657fbe1918b0917fa3e5eda124ad042ce732e","src/zlib-ng/test/te=
st_raw.cc":"0ac0c7c63777d4278a36e087b2060a369be16150d40a6963d3a0d60a7efb17=
40","src/zlib-ng/test/test_shared.h":"cc6a7f3dd115edd5de50da2da266e615464e=
2d5ae41d102e117b09215889a2c4","src/zlib-ng/test/test_shared_ng.h":"4570992=
f5ba61d2cf9e502d3aac163945d5d2f65883ce29f3a0797052c779b91","src/zlib-ng/te=
st/test_small_buffers.cc":"680ba24dc58c7dd05e8dab2e430a8e0c99b946cbc341a5f=
b39c4b4b921b6fb33","src/zlib-ng/test/test_small_window.cc":"0f784eae1977ee=
62d56f6280b269aa9edc42a5f3d20502c39abcb6cf126ec5ea","src/zlib-ng/test/test=
_version.cc":"8599eca8dd63a96962a5c8ac01a3172d203f9065e228867928ed4bce61cf=
6009","src/zlib-ng/tools/config.sub":"32186cfeb5db62c99e1dfbfb07f24c1a5097=
7447b4c26d2907021c74422a70d2","src/zlib-ng/tools/makecrct.c":"73acdb94f73d=
fea474927a9e1be33e0f2cb015d97831bc2718106141adbc1d05","src/zlib-ng/tools/m=
akefixed.c":"bffd02540231304f9bcc755b8cb9ae5cfbc48975857bbb4547f1d6acce21e=
f57","src/zlib-ng/tools/maketrees.c":"48a3e4ee246b1fb061d8e643efbd4b80e45f=
9c3814e21170a5893a9f4ca9619b","src/zlib-ng/trees.c":"310fe64c50fb313773c20=
58c606b1a3cc085b8af7771eba325ad5c9355659100","src/zlib-ng/trees.h":"24174f=
3543b01ee1ef370bbf6d15551a21871cded18b2aadf09a71e7904b6f99","src/zlib-ng/t=
rees_emit.h":"6c541dcf01eecf393d4eab7800bc558ad524114bb5a8deb86f13376fbef8=
8754","src/zlib-ng/trees_tbl.h":"022736ff3362ef3591d1f8fc3b7fede5927c0d25a=
b0813d7ef8cd95efd6ea242","src/zlib-ng/uncompr.c":"bb03a6ae65e1395f3cb2fba1=
dee63246a1fcd30683fd3348e320e789521055a6","src/zlib-ng/win32/Makefile.a64"=
:"f1feaed8da22e6e1470689186db22946ccb67019a87edd34e9ed25b438b626db","src/z=
lib-ng/win32/Makefile.arm":"a952ff273854b6b025760ed6c841c450d298cda462dae3=
163f6d7288ad2cf55f","src/zlib-ng/win32/Makefile.msc":"f299f7987ec266ac35d9=
383f4c7459da02094a10c877a4c471ee2df1ec44caf9","src/zlib-ng/win32/replace.v=
bs":"0ecd6d2f42f4f49d835acbf7b89a79cbdf17fed29d5931eeb3b40da6d3133946","sr=
c/zlib-ng/win32/zlib-ng.def.in":"0b75299a93ef3af54ab37f1282f254ccf2f635fec=
9b2691edc3840d851bbc20a","src/zlib-ng/win32/zlib-ng1.rc":"91f28a6930d6a376=
a1057a73ea5613bc13717028c89fdd0b4c8015059295fcd2","src/zlib-ng/win32/zlib.=
def.in":"ec69c79c2a5612a5c4dc9de08c930c9b251f2455e4bca8781f70c05f7170fb3a"=
,"src/zlib-ng/win32/zlib1.rc":"5644cee99821019a7d541d5587376236cb5b99e98d6=
6c904a25f9b69d1d56062","src/zlib-ng/win32/zlibcompat.def.in":"c4dff5ac2cfe=
629155c7de5b0f139fb1c962fb01addbc032c3cf35110921eb27","src/zlib-ng/zbuild.=
h":"e6f34c26bd82dd7650a664d7b336d1e4c83b871bded79e05602e779ffa69993b","src=
/zlib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e9aa47fa84bb625ed2ac6117284=
f514cacc42a993d","src/zlib-ng/zconf.h.in":"6768f84c439683b4a590338a9be40c3=
bd7a9702b25e8e546c705fac08674c3bc","src/zlib-ng/zendian.h":"5be3e298952419=
8f13b68cc083b1502747effe92325edee59e3c4ad93cc3c62f","src/zlib-ng/zlib-ng.h=
.in":"3bafbff2b78a88c1f0de4195a17b8fcd1fb12fcf2d40ffe1970415f6778bf9df","s=
rc/zlib-ng/zlib-ng.map":"111f656dfdf4da285621a909fecd0532be37f83b49f6e18f3=
57fc8d2a22a726f","src/zlib-ng/zlib.h.in":"9f74dd9f3244ac1152639c5ad5dd1995=
914b7362adb1f3890698da377cf26c3f","src/zlib-ng/zlib.map":"f746610758741f04=
2f8025502b4c0c04f9bcd48864004cc6e502b99d3754d78f","src/zlib-ng/zlib.pc.cma=
kein":"a97486fcab3f191d807ec04d4487d6a428053ab452b59687ee1f71cf52b02a31","=
src/zlib-ng/zlib.pc.in":"848e017a079b14853df8d19699f4edac2304767ef4eb2cf52=
5a06ceb60d301b3","src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579=
afe7ce8c1f8a5473598c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_=
mangling.h.empty":"38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ec=
b1d142058","src/zlib-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b=
12e71245d3b7cb79ed318fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"fce8e83d2=
040be8bc389ec61a8d6c7b32c0b3cd208599c01c5a58ef6418de87b","src/zlib-ng/zuti=
l.h":"618641510d89936fcbca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","s=
rc/zlib-ng/zutil_p.h":"6ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca0=
90adea8eb3f2d","src/zlib/CMakeLists.txt":"ab5f3afca6fe38983dc30a28da487770=
6e3a690a564eda3d4929fff39dab190e","src/zlib/ChangeLog":"f3bc368fd1722570d2=
5411fece6b0e026ab95a9e20ccf39c4395aa41a956a4f0","src/zlib/FAQ":"e18aaaae6d=
7d8acd15c1f439306ef554372bc39db7e19258836708362a0b7cca","src/zlib/INDEX":"=
3b4e325d47ae66456d43fcf143ba21ab67a02a4f81be7ef2da480ba30d774266","src/zli=
b/LICENSE":"845efc77857d485d91fb3e0b884aaa929368c717ae8186b66fe1ed24957532=
43","src/zlib/Makefile":"ef23b08ce01239843f1ded3f373bfc432627a477d62f945cb=
f63b2ac03db118a","src/zlib/Makefile.in":"a6d202a2ac158f8fbd1fa7361e1f2c7ad=
fd1b7b80c1f6515a4203925c2c0f24a","src/zlib/README":"d106dcdb2a0b3087cb3a23=
80b9f00a0bbadc7eb835cd80408f94a2d78d69727d","src/zlib/adler32.c":"9cd1443a=
24ff2a3053961695bd432035c58347386a420d3388232376ebabe211","src/zlib/amiga/=
Makefile.pup":"a65cb3cd40b1b8ec77e288974dd9dc53d91ed78bbe495e94ccc84ddd423=
edf1f","src/zlib/amiga/Makefile.sas":"0e63cf88b505a1a04327bb666af3a985c5e1=
1835c0c00aed4058c0dcc315d60e","src/zlib/compress.c":"86f802c16a965e7a28737=
e3730b4e576c5ba40981753967e3e30916f4dc1b4b1","src/zlib/configure":"f7c0050=
f218691ee1cae28311144a703bfa3515df903d537d6a5cb4bd3dcd8cd","src/zlib/contr=
ib/README.contrib":"b925ae08d371b33c4b5ffd67c707150729a476caf47cfe2eafc002=
291f23f931","src/zlib/contrib/ada/buffer_demo.adb":"469cf566a6965767fee6b9=
87a239ed8cedcc66614940d45a9b434331fbb435ce","src/zlib/contrib/ada/mtest.ad=
b":"41b6f31684770334afdc4375871eb1408542f37a823a073556fdbfdb63753160","src=
/zlib/contrib/ada/read.adb":"fa5b989aef0c5715a3fcb15de93985f7f10aeb0a7f571=
6745c95ed820eb9af9c","src/zlib/contrib/ada/readme.txt":"2cb6c99547bf527648=
342723a2183f503ef64182bc19a506976815725a207438","src/zlib/contrib/ada/test=
.adb":"ad2b2f61e0603044065887849e2cca394cfe37d3ba08d3cd368f670462b9296e","=
src/zlib/contrib/ada/zlib-streams.adb":"f45988e2bac76eb25a0dc981f46576e743=
2c35dde1790bbc2b650f0090b7fa72","src/zlib/contrib/ada/zlib-streams.ads":"2=
dae2309e863a6ea44731773aabac5fd5f5436b6dcfcf53fd7e6389556ca8c3c","src/zlib=
/contrib/ada/zlib-thin.adb":"03d89244ee5ec9771d9b5050e586c609f851af551b2e6=
4eb151f1d5be0b63ae9","src/zlib/contrib/ada/zlib-thin.ads":"631ef170bde16c3=
ca8d412b54a0e519815b80197d208f8f393e6fe017bb0968e","src/zlib/contrib/ada/z=
lib.adb":"8168ac962cd775e1f3dc35dc95a038eb370034c9b1f8cb1511d4bcd6b297a1f5=
","src/zlib/contrib/ada/zlib.ads":"9340f4cfaeafca0efce7a649ef5e9b42a8bcafc=
5dbdc4abff41f9a19ee08c3cc","src/zlib/contrib/ada/zlib.gpr":"859bb69dce38db=
e9dca06753cf7ae7bd16d48f4fece8b87582dab8e30681d3de","src/zlib/contrib/blas=
t/Makefile":"17d5d26c24bf51cad51045a38ffb73cc3539d29e89885aa249fcfd45a8659=
d5c","src/zlib/contrib/blast/README":"baa763ae03d88ef7ece6eb80d9a099b43d0b=
57639d6d281e1c7c6ca79d81daba","src/zlib/contrib/blast/blast.c":"1ab3e479d3=
42bfc144167b808fb00142264bc50f24a110ca88cc774e351c218e","src/zlib/contrib/=
blast/blast.h":"9c1c422b76311d4cb06863ffc056668b6240f3dd998bc02e89ee590d48=
2bfdc2","src/zlib/contrib/blast/test.pk":"5f5c262c545574a5c221132d5ef83247=
8d222d70b015341795b3860204140d7c","src/zlib/contrib/blast/test.txt":"9679b=
2c98e1283222d0782b25a1c198dc64ba9ebd1addd6dc6f643a45947cda3","src/zlib/con=
trib/delphi/ZLib.pas":"0a3ea9e7e6644df99dda9c275f5a7be7cbaa96f8333f0467bd0=
07141496dff17","src/zlib/contrib/delphi/ZLibConst.pas":"84bcc580bdf397e570=
f86f3f5a5b8c7bf537828f30b4b72648b81911f6bf5095","src/zlib/contrib/delphi/r=
eadme.txt":"f7420ed2de77d4b498eefbbe6402a1d17dc2d411735289c78a265c7f10fdae=
e5","src/zlib/contrib/delphi/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0=
f10118cd88bb32c4b7226988776f8d511","src/zlib/contrib/dotzlib/DotZLib.build=
":"b96137097669644ecb9f42cdd3399d1fce9c512788374609303f7e50abf597f0","src/=
zlib/contrib/dotzlib/DotZLib.chm":"20d0e3edd57f849143255a7f0df1cd59d41db46=
4a72c0d5ab42846438a729579","src/zlib/contrib/dotzlib/DotZLib.sln":"a979198=
c5b8d144c1ac8f993bfb6f4085d135aa58ca9dcf63ebabf52b5c695f7","src/zlib/contr=
ib/dotzlib/DotZLib/AssemblyInfo.cs":"314afcfb339ea95f5431047b7ab24631b11c3=
532c7ce5dc2094ed0cf80a7c16d","src/zlib/contrib/dotzlib/DotZLib/ChecksumImp=
l.cs":"871fc7b34a095dde13cf4505800d4edc9f40b033d5e840c597ad8ada599d26ed","=
src/zlib/contrib/dotzlib/DotZLib/CircularBuffer.cs":"be84c9736fe7bdc2bfae7=
0466d8fff582504e928d5b5e110fd758090090c8cb7","src/zlib/contrib/dotzlib/Dot=
ZLib/CodecBase.cs":"b373f1f0c08565bf362c41969881a2f25be449eb894a477659231d=
6d3b86c07a","src/zlib/contrib/dotzlib/DotZLib/Deflater.cs":"06ba6696a3c15c=
53ba5fd5a1c2bf50b51f217010228fc1e4c8495ee578f480de","src/zlib/contrib/dotz=
lib/DotZLib/DotZLib.cs":"9837fe993fd631233cc5e53ff084d86754b97f05ec77c54b0=
764c2706f186134","src/zlib/contrib/dotzlib/DotZLib/DotZLib.csproj":"21606d=
b31dfef6410dd438b73f1db68856eacabcce6c0f0411fc4f17e17001f3","src/zlib/cont=
rib/dotzlib/DotZLib/GZipStream.cs":"7c4e8bf7e0b51f04bd3f457bead842aee13338=
8d18ec8e210295899ad2327cbf","src/zlib/contrib/dotzlib/DotZLib/Inflater.cs"=
:"9016ca73818f5b6a28791abc3af6da7c4d2773b6a3804f593f6d5737a62b99ad","src/z=
lib/contrib/dotzlib/DotZLib/UnitTests.cs":"3f22cb690bd38fa151a944afa5a1844=
499fe30df5b410edfd769b7e2a41ddc94","src/zlib/contrib/dotzlib/LICENSE_1_0.t=
xt":"36266a8fd073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","sr=
c/zlib/contrib/dotzlib/readme.txt":"bdb18e0114d3b5683749cf08cedbdf6b502e5a=
bd344418b858e339839561e66c","src/zlib/contrib/gcc_gvmat64/gvmat64.S":"22ff=
411b8b1d1b04aeaa8418b68245400267dc43c6f44104f6ccd37f0daee89f","src/zlib/co=
ntrib/infback9/README":"890288f02bb3b1f9cc654b87a07fcea695f90f6b9bd672d25b=
f6be1da2ec1688","src/zlib/contrib/infback9/infback9.c":"c236f4e5ef216f5ebc=
66f95ccbf9d399a19ad3838444065308b8d859cb42dc74","src/zlib/contrib/infback9=
/infback9.h":"c89d926607c1afa1830c17f807de368d2f1afe2d1e7df426763f6d4bf595=
0379","src/zlib/contrib/infback9/inffix9.h":"84a2ba4727767c18af6505f0e81d9=
c814489c8b9ed330a25dad433db72997e43","src/zlib/contrib/infback9/inflate9.h=
":"32a907676cc36e27d0fdc0d99adb83a0b23f20ab61896269216d40fecf08d349","src/=
zlib/contrib/infback9/inftree9.c":"9e739f5735d3cd77ca1b0d46d2a43371acf2afd=
64c9c0889e737da369ccd92d0","src/zlib/contrib/infback9/inftree9.h":"4ecd9db=
884bf43e33fbd34273c814029022477e1597676129f9c98e09d8cef56","src/zlib/contr=
ib/iostream/test.cpp":"0f3c77e013949eb9c91e6b690ea894e19d97944d6b0885b8280=
6fc3ad99680cf","src/zlib/contrib/iostream/zfstream.cpp":"8ebb9b3d521cc3392=
953f27658cf1f6dcb763216079f69a1518ec5ca0e42a63b","src/zlib/contrib/iostrea=
m/zfstream.h":"4369c35e66f63f52ca4a5e1759bf720507ccabb8f3f132e2f18e68686c8=
12401","src/zlib/contrib/iostream2/zstream.h":"d0343e0c57ff58008b6f29643d2=
89c72713aa2d653fe3dcd2e939fc77e7e20b6","src/zlib/contrib/iostream2/zstream=
_test.cpp":"f789df183cc58b78751985466380c656308490a9036eb48a7ef79704c3d3f2=
29","src/zlib/contrib/iostream3/README":"43ec48ecbd95a8c45db20b107fac73b74=
0bb11595a4737329188f06b713972cc","src/zlib/contrib/iostream3/TODO":"af5ebc=
83fb88f69706c8af896733784753dead147687e1c046f410c0997fd88b","src/zlib/cont=
rib/iostream3/test.cc":"8e17fc48dfdbc6e268838b8b427491b5843b6d18bc97caa692=
4de9fad7abe3da","src/zlib/contrib/iostream3/zfstream.cc":"8cdd67ed0b13c192=
c11e5ea90e9d5782d6627eb303fbc4aa5ebda2531ec00ff8","src/zlib/contrib/iostre=
am3/zfstream.h":"d89587b446f928351565d099decd006a06b7a420cb1ff8ee9bb82e4d8=
c7235dd","src/zlib/contrib/minizip/Makefile":"b95eb8b05baef661a18ca90fa72f=
43e76f1bc987f9199197fe283e2860060e0a","src/zlib/contrib/minizip/Makefile.a=
m":"2313a3480a2c3745fa7ce216829cd0367058907d3a0902e5832c66c84a2fdfc6","src=
/zlib/contrib/minizip/MiniZip64_Changes.txt":"c371d1672b1ec23c6fe0c600543e=
0c96374400b4d434447ff2596f21255079f1","src/zlib/contrib/minizip/MiniZip64_=
info.txt":"122719c32ef1763a5f6ba9c8cdefc1d78a76f7156b09e7b6f69b73f968e0dac=
3","src/zlib/contrib/minizip/configure.ac":"99a48f7b786cf192a778aae2af3083=
6b0d2aaaec6e84c3a89a2edcbe77b46e1a","src/zlib/contrib/minizip/crypt.h":"5c=
978923cff1e80f76baf437eed699d5b4ad1bf515008d669475d3dd0d89ef70","src/zlib/=
contrib/minizip/ioapi.c":"6dff11ded396f5e3147c632a639423e80ced6705bf7bf75d=
21cda0c571fdf86b","src/zlib/contrib/minizip/ioapi.h":"6d2f2c3520dfc3061ea9=
128a1afb843f5cfe8d7317adcefe3a45884bc06e06a1","src/zlib/contrib/minizip/io=
win32.c":"882383d1ee9df8c5f236411734b51e96f5e29c38496d4e531f2beb3d07f682ef=
","src/zlib/contrib/minizip/iowin32.h":"4feed64c3c5f5cff2d8a0431233766b61d=
4e06a9f232482cb41272ed1ca487df","src/zlib/contrib/minizip/make_vms.com":"6=
5736d9c4888f2373d3db0a13864d150c5040453f5bc2a5c8784379a7ea67590","src/zlib=
/contrib/minizip/miniunz.c":"c60f2c68be981464ff02dfbe01da2a8e66692416bdda2=
144fc75df3420b4107f","src/zlib/contrib/minizip/miniunzip.1":"66d8684392167=
091ef0fe01598d6a0daa26e7e448e2df6c3cb257487735b83f7","src/zlib/contrib/min=
izip/minizip.1":"5404596e8e5587a52f563906119f32ceee30a6d97a966afa5c7afbe4d=
373e210","src/zlib/contrib/minizip/minizip.c":"6d7d7daffc713ba15a976814347=
1902c5bfd661a19287172f3870bc9ed2d5665","src/zlib/contrib/minizip/minizip.p=
c.in":"8b6670b42d8e5e519e1cc89db093efc07ba23cb1ddfedd3c93ff2df08c3ce8ac","=
src/zlib/contrib/minizip/mztools.c":"3d6027270a2b6ed5ca19a339d7488f682c697=
98e3977d2278d379b7f14f17b63","src/zlib/contrib/minizip/mztools.h":"6f82c52=
279e8f79165f4446be652e5741a49992ac58632470335aa34c564072a","src/zlib/contr=
ib/minizip/unzip.c":"10881ab576f49fe0825a21f77e322ece6ee88d34ed66fb3a3ce7a=
22f4b6cd2d9","src/zlib/contrib/minizip/unzip.h":"2ff9df0b1da7499adc806bc0e=
c098ef1c7b9d361a8fd5b08a98299a1a4e88399","src/zlib/contrib/minizip/zip.c":=
"213f853d71266ebe8d8335740cfe94b0731009d8fb3f7e6ae01a627398732ec8","src/zl=
ib/contrib/minizip/zip.h":"99ad45c0b546b5fd0ee3d0819ff057840a892a3d6dbacc8=
5b757a35a43047398","src/zlib/contrib/nuget/nuget.csproj":"a6cf81c9a9b8be66=
fae032193ac6282a4ceae93c8a25a9245d7eaf477d532471","src/zlib/contrib/nuget/=
nuget.sln":"074a80c6c3898ea4f7935734d81fe81d3c15f5dae5b17806fa7a036b69ad5c=
33","src/zlib/contrib/pascal/example.pas":"d842d456ecb6ff80e34cee2da31deb2=
072cc69ca837497bea8b8bee203403474","src/zlib/contrib/pascal/readme.txt":"0=
2f997c37991ddae0cb986039f7b4f6fc816b3fd0ffd332cad371d04c12cf1b9","src/zlib=
/contrib/pascal/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0f10118cd88bb3=
2c4b7226988776f8d511","src/zlib/contrib/pascal/zlibpas.pas":"c5559b148a9dc=
dd32843e6920b4d2a2b030f7d32979dfd253aeaa9a4ed31770f","src/zlib/contrib/puf=
f/Makefile":"d9d738030464aaae354196c14fd928adf591832fce7d71ac1977c1d8d4923=
a4b","src/zlib/contrib/puff/README":"c5b9852fb11e0d6b6e916e5134cf034524d90=
1b95368972133e0381e480eb479","src/zlib/contrib/puff/puff.c":"5b9d75aeb5baf=
3575415bc6ade3f2a02e50b6b971b3f8b4fda2b03543bc6e52f","src/zlib/contrib/puf=
f/puff.h":"969b7be2a930db0cdcb19b0e5b29ae6741f5a8f663b6dba6d647e12ec60cfa8=
e","src/zlib/contrib/puff/pufftest.c":"d24e31c1d277d07c268f34e9490050c6b53=
c68b128da3efbb1d05fc5b31004f7","src/zlib/contrib/puff/zeros.raw":"b7b08870=
89f7af1f6d1e0b4c0a1e8eddd10223b23554299455c6c9be71b653a3","src/zlib/contri=
b/testzlib/testzlib.c":"753dbb39c5d2f0fffac0406c1c94fd1da7b0251d679e4d137b=
0708901dfd61d8","src/zlib/contrib/testzlib/testzlib.txt":"2359bbdc84eb8a04=
e0f1cd16cd81a2896e957f2ad58dab3ca78ef55b7d0dc577","src/zlib/contrib/untgz/=
Makefile":"8f5ab1564813e091cea8f1bb63da32fd80ac763d029277b0cabf50f60aceefe=
1","src/zlib/contrib/untgz/Makefile.msc":"d0f537de11d9e0e36e2a98b3971c5372=
65f4b533b4c48797094365ad9ae8388b","src/zlib/contrib/untgz/untgz.c":"f96c1e=
8529eb10d723b4547aa965741d72a46f2b1d5c9a2c193bd3f5e2c2a45e","src/zlib/cont=
rib/vstudio/readme.txt":"ee95a52d9d2a16aceb070a54dd2c45a1f861178351baf8ea0=
3c2f80328691974","src/zlib/contrib/vstudio/vc10/miniunz.vcxproj":"dd607d43=
c64581172c20c22112821924dfe862f56b2e5eb8780bdd0714d9527b","src/zlib/contri=
b/vstudio/vc10/miniunz.vcxproj.filters":"4b8466bf00c70b81c31cc903e756e0415=
1fd90fdcbe102f3568a2c8b6190ea27","src/zlib/contrib/vstudio/vc10/minizip.vc=
xproj":"af73f2cf8ae51e65e85342faeb40849a2310c97bc77def42b38d7070460a6cf0",=
"src/zlib/contrib/vstudio/vc10/minizip.vcxproj.filters":"f2815f9e3386c393d=
0a351632823b221ef9689da1f422ecaa561dba2a612fb0a","src/zlib/contrib/vstudio=
/vc10/testzlib.vcxproj":"c21e64259bf9efe97e1103212e7a6e1b7372b50067b4ba14c=
fa678e1f491095f","src/zlib/contrib/vstudio/vc10/testzlib.vcxproj.filters":=
"a7caddbac3ba90b5d482e6d926ef35cc40dc3553ed3776ef6b68a528fd5b0631","src/zl=
ib/contrib/vstudio/vc10/testzlibdll.vcxproj":"3f317d8964f17901c3e68bff5dea=
ec10b6ccc50a572235999e8097292692984c","src/zlib/contrib/vstudio/vc10/testz=
libdll.vcxproj.filters":"29c9535775aa76320ee4efd001d41961faf6c58cedd8b29d3=
986e85f73d2f6fb","src/zlib/contrib/vstudio/vc10/zlib.rc":"7aa6cfd50ac67821=
504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/zlib/contrib/vstudi=
o/vc10/zlibstat.vcxproj":"50402ab8c63f746c034d6ce51d9612aff5b6af9aa27790cf=
fa4b7deed4b30eb8","src/zlib/contrib/vstudio/vc10/zlibstat.vcxproj.filters"=
:"eeb1de64c252c46b822f73f272127f6f9f0570ef22d234e093070ba95a4dde24","src/z=
lib/contrib/vstudio/vc10/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf32283d=
f77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc10/zlibvc.sln":"=
e659860f705f31b87ea9139a3cb4ebe1561e120bce495383a54614fc82b49990","src/zli=
b/contrib/vstudio/vc10/zlibvc.vcxproj":"efad8cb150c0e5122f8c700d95c5de659d=
ff92b171917c66bdbd082fff500b58","src/zlib/contrib/vstudio/vc10/zlibvc.vcxp=
roj.filters":"c801732b7c7017796add50d2b71a228f99f95a46650baad307ff7e8358a2=
bfb0","src/zlib/contrib/vstudio/vc11/miniunz.vcxproj":"746e4c11fb8af4bcd6a=
9d68ba81ed1dc366a5de3bed56b291ee969ad733a7bb0","src/zlib/contrib/vstudio/v=
c11/minizip.vcxproj":"340617cae9cf4fcb003308021d3782ec3639e60d62d79a3aafc0=
a50bb55b061e","src/zlib/contrib/vstudio/vc11/testzlib.vcxproj":"99eadfdf2e=
41bc036141c174c4d0035d87572ce5795dcc28f39133f818a79d08","src/zlib/contrib/=
vstudio/vc11/testzlibdll.vcxproj":"583bdef522b0176829f0d8139ea2a88b9cbc143=
79d1334f3a863989ed3df9b67","src/zlib/contrib/vstudio/vc11/zlib.rc":"7aa6cf=
d50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/zlib/cont=
rib/vstudio/vc11/zlibstat.vcxproj":"b07f792843d05ac883391075bc3b9625437490=
d8d40944ad359aa2134a09a3aa","src/zlib/contrib/vstudio/vc11/zlibvc.def":"40=
c8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/=
contrib/vstudio/vc11/zlibvc.sln":"27389b515997defd080519f95aff87e89fcbe8b2=
6d73c5ebb73c544cfef4d60e","src/zlib/contrib/vstudio/vc11/zlibvc.vcxproj":"=
d02d014ef957119a6fd0ab243c892b74d1592b117750b95fed21097c8ed922d9","src/zli=
b/contrib/vstudio/vc12/miniunz.vcxproj":"1494af54570f6e93852932956d49a8c25=
e57b5abc1ac979945605ca9143df9f8","src/zlib/contrib/vstudio/vc12/minizip.vc=
xproj":"9bf128ed6760ca5f019006f178b1c65f4c7ff122dba8d297b64b0eb72feeb120",=
"src/zlib/contrib/vstudio/vc12/testzlib.vcxproj":"be88bc1220c0447c2379fdab=
3ac88055f58a8a788d3e9cec494342187e760eaf","src/zlib/contrib/vstudio/vc12/t=
estzlibdll.vcxproj":"93416510256935d79625dc9fd349cfce6968c062d42a138bec404=
a26b2f92f5e","src/zlib/contrib/vstudio/vc12/zlib.rc":"c0e44b6f99079b298e0a=
11f013e7b1476402a49f19e4d892467abb4aa116f2c8","src/zlib/contrib/vstudio/vc=
12/zlibstat.vcxproj":"faa229a851c76b77d65bb4742d8369efe566652bb6a1447d1e35=
39f289b5313d","src/zlib/contrib/vstudio/vc12/zlibvc.def":"40c8e74194874b8c=
1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudi=
o/vc12/zlibvc.sln":"162e0faa80a56d89eea71a0b89377708eec2faa0dc72091cc0abb0=
7fbdea49a0","src/zlib/contrib/vstudio/vc12/zlibvc.vcxproj":"8ac8cb2d29b880=
a738011d29d0511af9b14f321bed90f674109c446f4108d442","src/zlib/contrib/vstu=
dio/vc14/miniunz.vcxproj":"0312511d4a30cea979c4e36edf994a537ed8a9d924f6b5c=
536cbcd094773c11f","src/zlib/contrib/vstudio/vc14/minizip.vcxproj":"9e7bb7=
a6ac723e4b2db900627c366f9bb93a351381995d9c69a50c0126f64233","src/zlib/cont=
rib/vstudio/vc14/testzlib.vcxproj":"88667873d9d61d65016b9501ca925532eb55f5=
6230e5911d3e2a01cd8a9fb2a4","src/zlib/contrib/vstudio/vc14/testzlibdll.vcx=
proj":"69f544898b4275cd3d8e19b8f1f8cb39c1cb98a30cdb033242e4b94c57bfa150","=
src/zlib/contrib/vstudio/vc14/zlib.rc":"c0e44b6f99079b298e0a11f013e7b14764=
02a49f19e4d892467abb4aa116f2c8","src/zlib/contrib/vstudio/vc14/zlibstat.vc=
xproj":"5629eb0cc30674a39aa3636f1cdd190393b0dbd4c69a35e36ad85b6340055605",=
"src/zlib/contrib/vstudio/vc14/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf=
32283df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc14/zlibvc.=
sln":"47a50bbde8ca6336cecd8c0e4b65e515fc46ae84c7b61008ac9864162f777286","s=
rc/zlib/contrib/vstudio/vc14/zlibvc.vcxproj":"09f496a2ad3afdd5e3f36b728544=
0369dcac4559656edc00ed7a74c7ec9fa10f","src/zlib/contrib/vstudio/vc17/miniu=
nz.vcxproj":"aa70a28fb573e98c0ef68ead2b875765de180e4c6f46c6135806244257fd9=
18f","src/zlib/contrib/vstudio/vc17/minizip.vcxproj":"43ab4593b3ea568dc9e6=
f78a46cbb011850349e9cf3337cfb91dfdc3e623b414","src/zlib/contrib/vstudio/vc=
17/testzlib.vcxproj":"e596d1170c68c6c7912070293e74b794f6753afb1a6d42177dc3=
626fe1b0e0d4","src/zlib/contrib/vstudio/vc17/testzlibdll.vcxproj":"c61f1f6=
e7e0625f283ac4f4e3ca76f25773ada0da43c7c72ce003637f9892c3b","src/zlib/contr=
ib/vstudio/vc17/zlib.rc":"c0e44b6f99079b298e0a11f013e7b1476402a49f19e4d892=
467abb4aa116f2c8","src/zlib/contrib/vstudio/vc17/zlibstat.vcxproj":"331eff=
bbcf295912daff00fb3594c2ee300824733897efc5df7d31b2d379a222","src/zlib/cont=
rib/vstudio/vc17/zlibvc.def":"1fa9a4d1624675b0181554ddd841d368a9cf39fe931b=
80737bfa21402f27a7d8","src/zlib/contrib/vstudio/vc17/zlibvc.sln":"36da58a5=
377e65f446c95c7e4c04a915caac9873b94d0dab231e9862391bba78","src/zlib/contri=
b/vstudio/vc17/zlibvc.vcxproj":"f3222e055d4001f9ee04265a72b8f349f92bd27189=
ce51852c96dde58539c335","src/zlib/contrib/vstudio/vc9/miniunz.vcproj":"7db=
9b2ef5ff05d3de4ba633feab10e85d45434c865d520ffa1974421904996f3","src/zlib/c=
ontrib/vstudio/vc9/minizip.vcproj":"7797a9ad3c0056f3a3cf8fcde7618acd1d151c=
65d15f841fccd8d9d878ae7bb0","src/zlib/contrib/vstudio/vc9/testzlib.vcproj"=
:"8df405917800adccee6bad2116022c2c82d661b37ea40ea16405fe4dbcb4b69f","src/z=
lib/contrib/vstudio/vc9/testzlibdll.vcproj":"cde6806f5c81d1fc311f9921c17ba=
56f8e386d097783a6a90875d385837c47e7","src/zlib/contrib/vstudio/vc9/zlib.rc=
":"7aa6cfd50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/=
zlib/contrib/vstudio/vc9/zlibstat.vcproj":"d393d418d827ad9fb9c6516f1a76203=
71d15e3f5afef8ba60b51e50acc7199e9","src/zlib/contrib/vstudio/vc9/zlibvc.de=
f":"40c8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src=
/zlib/contrib/vstudio/vc9/zlibvc.sln":"26e58d4b2cfcd941c367fb2a18537b3b9f0=
02f2ac1278b700ea1129c50501452","src/zlib/contrib/vstudio/vc9/zlibvc.vcproj=
":"eaca98fcf166738b59fcdbd179dac9f98f985c6ba49212b186343a998816f081","src/=
zlib/crc32.c":"8fd16f0a7714d51c89c2eb37eb98ec15e8a4dc57ba343e7b7398b191440=
39fda","src/zlib/crc32.h":"9a2223575183ac2ee8a247f20bf3ac066e8bd0140369556=
bdbdffc777435749e","src/zlib/deflate.c":"3b956337350f94c34987750f785587ef3=
3d9c89ceaebb7c2afb189c956360cbe","src/zlib/deflate.h":"48baf016326d8d5e3e3=
2ac8153cc7e22f854b8e6834830b167b998a7fb1e7989","src/zlib/doc/algorithm.txt=
":"a2581ab546bf053e3e95d191a6accc3b06bbd4f08ad2fb888eacbfb9773c1d30","src/=
zlib/doc/crc-doc.1.0.pdf":"064f9252d6e2e15ea56c2bd18e160e5c9c84bcd137c11a7=
af497aaa511ace998","src/zlib/doc/rfc1950.txt":"8f0475a5c984657bf26277f73df=
9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib/doc/rfc1951.txt":"5ebf4b5=
b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f301350009","src/zlib/doc/r=
fc1952.txt":"164ef0897b4cbec63abf1b57f069f3599bd0fb7c72c2a4dee21bd7e03ec9a=
f67","src/zlib/doc/txtvsbin.txt":"d1549fb75137f03102798f70fd34ff76285e717d=
dd520dd82274c1c0510eacf0","src/zlib/examples/README.examples":"1bc1c677bbe=
be1aa5e85015bb62f0cf3fcdbf95652d30494159bee6166c1854a","src/zlib/examples/=
enough.c":"c14a257c60bbe0d65bb54746dd97774a1853ef9e3f78db118a27d8bc0d26d73=
8","src/zlib/examples/fitblk.c":"bec64da6fc0c9a2a37a96722e8b88ca09059148e5=
be5ecbb486bdba5339e228a","src/zlib/examples/gun.c":"3bfd36b06284ba97d6105b=
8a6a5d18b2b34b75b3a1285f16d018680fb174915f","src/zlib/examples/gzappend.c"=
:"6de91c8305e37560117bff44136abff72b16b028c0bda0bbac7ea07e4988b0ce","src/z=
lib/examples/gzjoin.c":"90b9d6c39a5fc91cf1cc9b96b025a508a8015dc502cd9374c7=
54b44078593f57","src/zlib/examples/gzlog.c":"d9a2f9871e7f1724f9f9359fd4851=
dc0eac7af10d8234bab66327badb33d1a38","src/zlib/examples/gzlog.h":"681f2804=
37f867820bf39880e2f4fc641d402879e399ba2e6a31d73feefe8edc","src/zlib/exampl=
es/gznorm.c":"e5a8f5c3b107f27212f7d5fbfcf072a337a1b4ea32929ae31c168997438a=
5cc0","src/zlib/examples/zlib_how.html":"bada2526c34e9da7c9682a7216c0b0d7a=
c26f49195f98d3ef56f14ae9b438177","src/zlib/examples/zpipe.c":"68140a82582e=
de938159630bca0fb13a93b4bf1cb2e85b08943c26242cf8f3a6","src/zlib/examples/z=
ran.c":"f4bc94b710841b8412aee04c42ea522bd1687343d65f0c0d92b4dd5801d03956",=
"src/zlib/examples/zran.h":"913158e13f6177224074cfa9b497438545054ac0d54ab1=
3a6ad4182df8d2ee99","src/zlib/gzclose.c":"35ea6e991a63095f797d8c4cc25817fa=
c7a7155c2ba7dcdbbf648f7871c7ea40","src/zlib/gzguts.h":"716fa648aca1bb06c21=
9d7b97ad4846d8479206143bc39557bfd8283f5783e04","src/zlib/gzlib.c":"042c2be=
8ec67ad525a2812e508de7381c6766dde903acf5ae6ac4fa6b541946d","src/zlib/gzrea=
d.c":"72e481aca07b0b85a9783237b85dc67ff3a4c1d19878d0cec69f58d38634867b","s=
rc/zlib/gzwrite.c":"469b1e58932ea11bdda2a153f6655f7b3c13254240fae157181b49=
ed1bc93b47","src/zlib/infback.c":"62df9a6dd3eef126f1d81d0ad7a534504610dec4=
4482b0a472b61c93cbab6554","src/zlib/inffast.c":"e6ef64ce5dc0a4cd5c7ad08cee=
b2b2a698b8447f6bd156057caeb2edab68c0cb","src/zlib/inffast.h":"05cc5dc9ff1d=
a7b8b52a4bd8bda0d8a5c236a2f39efe84b941516ea13857e6c5","src/zlib/inffixed.h=
":"237ba710f090e432b62ebf963bee8b302867e9691406b2d3f8ee89ee7bfef9b0","src/=
zlib/inflate.c":"34c998ce0037c0537c04b03b276f680b945f9b2c9d1e01b287605bd68=
79f7fd2","src/zlib/inflate.h":"e8d4a51b07694bf48cb91979c19974cf6a5ab0b8a09=
d26ec0d14df349230673e","src/zlib/inftrees.c":"5d4f335221d2dc76f17abd2577d9=
2c2d7baf68fa6d7f23373b360830493d1563","src/zlib/inftrees.h":"0a0fcaf2ae2fa=
e57426bdc06637270e9bba974f35202cadbdba479d946e6409d","src/zlib/make_vms.co=
m":"14ed54bdd391c1648cedfb69d8a73a26dcc7f1187d59b0f18d944b7665cec85b","src=
/zlib/msdos/Makefile.bor":"292ab363f7ffbc4ae84d37cd9bdffd2dac1003bee52d223=
a8489844870f20702","src/zlib/msdos/Makefile.dj2":"9208450c2ae6dcbfcc25560b=
5b9ca763f461e7246e37b0552474edf8fa898906","src/zlib/msdos/Makefile.emx":"c=
749d6ec7f88e8e639d4f03bdbdcbbe9d1c304210be4c4be621ceb22961d3d64","src/zlib=
/msdos/Makefile.msc":"0e021a6f42212415b060e4ad468eb415d0a8c1f343137fb9dff2=
cb8f9ead3027","src/zlib/msdos/Makefile.tc":"2ae12ee2a3e62f7c5a0520d0fbe4ad=
ee772bc07fe816002b07ccb43db3daa76a","src/zlib/nintendods/Makefile":"ea5823=
efe6830132294eddf2f56dbd7db8712244c210bb4968c431b1a91bd066","src/zlib/nint=
endods/README":"e362426c47b39ff6a7d6c75c6660b20abf076cdfa5e1e421716dc629a7=
1aef95","src/zlib/old/Makefile.emx":"d811f032272aae50123a889297af3a02fbd60=
d1e42bbef11466462f627ff7b5b","src/zlib/old/Makefile.riscos":"d1a488b160fbf=
d53272b68a913283a4be08ba9d490796b196dddb2ba535b41e0","src/zlib/old/README"=
:"551a0f4d91fe0f827a31cbdfbb4a71d1f3dc4d06564d80a3f526b749dd104d11","src/z=
lib/old/descrip.mms":"8ff08c35c056df9c986f23c09cf8936db63ccf12c3c42f7d18a4=
8b36f060cff7","src/zlib/old/os2/Makefile.os2":"6ad247c00f00ff42fd2d62555e8=
6251cef06e4079378241b5f320c227507d51d","src/zlib/old/os2/zlib.def":"ea9c61=
876d2e20b67ef2d9495991a32798eb40d13ede95859a2f4f03b65b9b61","src/zlib/old/=
visual-basic.txt":"04f39c86a8894561498430ca169e9d6ca2c5cc99b43ee9230818840=
65a0b2b1f","src/zlib/os400/README400":"96580d63002088615c4b5ea865cdbec234f=
ef0c8471667d2dc66273398123743","src/zlib/os400/bndsrc":"3c36a17975eed5a8d3=
3bc5443b39fead1e68c01393496be9c1f4a61444bcb0f6","src/zlib/os400/make.sh":"=
143394d1e3876c61c29078c0e47310e726e1f5bd42739fe92df9ece65711655f","src/zli=
b/os400/zlib.inc":"c01ddd22689c281066f2bd2e3a020fad4cd50c1e543f17fae963da8=
9a0d69a29","src/zlib/qnx/package.qpg":"6c499168c561fc08e2fc41b07fc7a43882a=
52ede30c1599ed9f6a4035e764225","src/zlib/test/example.c":"b7aeca68f7585e29=
ca6572542e0ecbd9c3c9370035ae15152008b3efbd4f84ac","src/zlib/test/infcover.=
c":"13a0d18d8bca440c4617d88c2236913f53eedebc50e469be472edd4280c697e5","src=
/zlib/test/minigzip.c":"57e4a1b9bb1bdb59ac9e5ac1dc9132183e8740cec2f6b5c5f2=
476aac08a2375f","src/zlib/treebuild.xml":"7d1cb70609017f6f22079af7569c8d8b=
e2ae51e9524fc173719a487181d60860","src/zlib/trees.c":"f63c68c16c05fcd19605=
0529d1a0e7657960e4136b9987d90a6ac3e58a964b0f","src/zlib/trees.h":"bb0a9d3c=
a88ee00c81adb7c636e73b97085f6ef1b52d6d58edbe2b6dc3adeb4d","src/zlib/uncomp=
r.c":"04dca5e31b3b8a17d1806426f66f0c539f4184d657e149d40be07070c6227b52","s=
rc/zlib/watcom/watcom_f.mak":"7e039b912f9cffaa40835281430bb284fa9042b0a0d1=
2f6b34700a06bca6576e","src/zlib/watcom/watcom_l.mak":"d11b4064604a03472586=
0e63e3f6d347056372e4b1675b183e20a93533b20cc9","src/zlib/win32/DLL_FAQ.txt"=
:"539adcdcea4dcab44d0e788febd217a6f192bc0758dc7813cd5f5d8474d9b428","src/z=
lib/win32/Makefile.bor":"7d73a0d2c3e38b7c610bbc9c22f683a4fe1ab9b8b65649a3a=
8ac4ff7fcc14ba6","src/zlib/win32/Makefile.gcc":"97140c30506a8f6b2edb6b3d8a=
1b6b539d7929d4b957deba9950301090f579bf","src/zlib/win32/Makefile.msc":"235=
529bd529d4690d5d4b7871fdd0a1f118f2fe18862cbdec5f5ac674c55a60d","src/zlib/w=
in32/README-WIN32.txt":"508bee0ef1a34892281517919970eb337e017503671d0fa0f1=
39523b44b4d0eb","src/zlib/win32/VisualC.txt":"9ec0babd46eaa012371dee2d3a8a=
55d9c7130f7895512c3371c737e4a7f6a997","src/zlib/win32/zlib.def":"c00693a5c=
825f8bfbdb68124fd03cb2fa5269338071147bdaa14434aaf3962b9","src/zlib/win32/z=
lib1.rc":"54e161029b59e99a4f9cb2281b956f00ecfb1814318ddef9c741ff4f832c5c1d=
","src/zlib/zconf.h":"f5134250a67d57459234b63858f0d9d3ef8dcc48e9e1028d3f4f=
dcf6eae677ae","src/zlib/zconf.h.cmakein":"350fb02462487a3e8612c18ad2790539=
96ce0c85ebfece25a959baea9db86562","src/zlib/zconf.h.in":"f5134250a67d57459=
234b63858f0d9d3ef8dcc48e9e1028d3f4fdcf6eae677ae","src/zlib/zlib.3":"5aadb3=
f129c4c7e29f28bb6c5954dea061df3046d0fe3e134aff2ef4a217b1d6","src/zlib/zlib=
.3.pdf":"434e8d80e43ed24ed58a7dad0867a1136035864ad3e5fd4cc2c69e0715628c66"=
,"src/zlib/zlib.h":"8a5579af72ea4f427ff00a4150f0ccb3fc5c1e4379f726e101133b=
1ab9fc600c","src/zlib/zlib.map":"e83d883a3f7bb93b3dcfab28f5300a569bc7586de=
d2e067c0639d0697d13fe1e","src/zlib/zlib.pc.cmakein":"2f1d0b18ce37c2af415a4=
69857f02aee2c41a58877aff21d29e9c6db32b55cb7","src/zlib/zlib.pc.in":"04c01c=
c2e1a0ed123518b5855f585c93a24526dd88982c414111ea1fc9f07997","src/zlib/zuti=
l.c":"8ced40d8c88588811edd2bdb35b7439983d5e1f8e9e32b8a3b244731f3c317b7","s=
rc/zlib/zutil.h":"dddb2dc7a1dc339ecf2c8e089b366f08bb731c0839c7110240d17ce7=
31bb4fea"},"package":"5e143b5e666b2695d28f6bca6497720813f699c9602dd7f5cac9=
1008b8ada7f9"}
+\ No newline at end of file
=
++{"files":{"Cargo.toml":"b4ed89b98aea5ea05fa475a9ba6f824dc6e759ea7a4c358e=
7fcecc7423e44777","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d0=
59d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d=
464acb3408d4c599d3dc5fe4fa1b4c84f","README-zng.md":"438ab65416835d72c7dd16=
8338af3db6f1a3d8ccee455af4e1d75438a781eb71","README.md":"62fa314f90fdc5430=
c6446ddb212b782ad69721cd5363983820261a41b53890e","build.rs":"b139f25e59a8c=
c78a9fff8bdc25b34f6ba926ddf410bac65bfb7f279f1a92d76","build_zng.rs":"059da=
8bf3ed5f2bfa613874b8f6720643ae948a811fefaff8237e95e0771cbc3","src/lib.rs":=
"8f9f42e8c80e134fa6f5724c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/sm=
oke.c":"10607c81b73811bfcb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b",=
"src/zlib-ng/CMakeLists.txt":"6b7d83767c0fe0b98e2d5321a2c35339e04bf314f6bf=
650f4716a7434a3e164c","src/zlib-ng/FAQ.zlib":"c524f4f86d336b3de71dd6977afd=
dffa9c02fda5c26db4dfefae44959e7614a2","src/zlib-ng/INDEX.md":"989545e90d8e=
9ac149034f762ce78ed8976ebf9324326228dea37ca190154609","src/zlib-ng/LICENSE=
.md":"d3c80be055d94d798eaa786116e84fa0b010bc11420b5d2060d978ea77845436","s=
rc/zlib-ng/Makefile.in":"3c46b870035b795f4e9c365a1688392377dbfef90cbb81429=
4d4d33d3ead1f4e","src/zlib-ng/PORTING.md":"097591000d86f6265fea6cfcd226359=
84eb6c9f54e8690ca2667cfb92a11919d","src/zlib-ng/README.md":"5e1032d7f44647=
ce88475872a4fff9bd1671e3bedf8bdca43925dd8fde97c8b3","src/zlib-ng/adler32.c=
":"b96656d1fc0133c44caeb3509d545d0b68580e77157b8c6f0fd6dcf681726ea5","src/=
zlib-ng/adler32_fold.c":"66b32963c96e43c84b53eff737d11186bf165e04a48e9c332=
8faa5c86ce8128c","src/zlib-ng/adler32_fold.h":"c40114c2c742b6410e54b58ea02=
533fe6e9ae0ca62d3453e5d2a1725d33e2be4","src/zlib-ng/adler32_p.h":"fa8b9637=
1128c54ed9c2a06175006738d395d380672b4894c32fece37b8a96a0","src/zlib-ng/arc=
h/arm/Makefile.in":"67e906298f31bf83feeb526c9d09a65c1d39517423ded8f50cfc36=
9f05a1d629","src/zlib-ng/arch/arm/acle_intrins.h":"313646b741417269d175b26=
20c7bd2cf1cb5bfc940c5bb3dd600189fce27cd79","src/zlib-ng/arch/arm/adler32_n=
eon.c":"bce2fe7d3a5f663ba2894d3c9b13151c5cd4c16bcc1d31ac32a85713ecc20f8c",=
"src/zlib-ng/arch/arm/arm_features.c":"dc2fa2e5593f0ff1f837138b99f26d1f805=
f82f69d2721cc2b2a386b5dac7b1a","src/zlib-ng/arch/arm/arm_features.h":"0667=
e8baaba1edfa60ec6faa5ce35eb35f5e91c85633e831f397a9af3c220b9e","src/zlib-ng=
/arch/arm/chunkset_neon.c":"042d3e6f865b5b0bfec8b5196288cce2ec47e9ca2c8a5e=
075580dd302238e421","src/zlib-ng/arch/arm/compare256_neon.c":"7eec4ca0415d=
ec895a461a4d1fcd3068e0d68482d048257022511b3490372ca3","src/zlib-ng/arch/ar=
m/crc32_acle.c":"3fa85db742ee584f3787e3d131d92d6196e44f9df5f3034d804abc78c=
bf81d3f","src/zlib-ng/arch/arm/insert_string_acle.c":"5ca256a6f796d8bff478=
671ae5b0d7cfe236b58abffd6a99bb2cac097fe7935b","src/zlib-ng/arch/arm/neon_i=
ntrins.h":"22262195cbd668a11953449c9e1be3b9b3374469d21f3e73ab34c6ea0dcf275=
f","src/zlib-ng/arch/arm/slide_hash_armv6.c":"9abacab94d74e7d8b1d863f20aa9=
7fb5380059f08b91480a14377d3ed2d1f768","src/zlib-ng/arch/arm/slide_hash_neo=
n.c":"7c4927c0dc8b28c5fba1efb30273653e71172ce051a0341ce2f1d2c0bbfa418c","s=
rc/zlib-ng/arch/generic/Makefile.in":"93255a212569673a3ce9e7fbaba789b3cd82=
375e7f6459c22c84bcb7a12097c7","src/zlib-ng/arch/generic/chunk_permute_tabl=
e.h":"3f1e09e697a9b2dff4395aca356e61765c44511a9dc653abb6998671afd20ae6","s=
rc/zlib-ng/arch/power/Makefile.in":"015cb5635da6dbcd54c6bcef5d8958c6ea5369=
b55797e342a2632b0bf03bc4ab","src/zlib-ng/arch/power/adler32_power8.c":"e5a=
5bfdd9963e8f906e36978f1a655139908740559da2b382ddd5f3e2ffe6f56","src/zlib-n=
g/arch/power/adler32_vmx.c":"841a7e3792d1f68a0925969d6f9737cfb2b650b3a8272=
1a88f1e5648f7b0a58a","src/zlib-ng/arch/power/chunkset_power8.c":"569a7dc68=
6a0d80686e516ec8fb7c2331225f706b37ccbf0874e6d822e82f806","src/zlib-ng/arch=
/power/compare256_power9.c":"cfdc33f5e605fd41351423fda0eaf7692f9e9f0083d6c=
4ac870c6e467d534f48","src/zlib-ng/arch/power/crc32_constants.h":"d73e3b902=
5de9fade7fa3ba2bbf5f56a1499a84c53d8ca7f5e744a0714d8599b","src/zlib-ng/arch=
/power/crc32_power8.c":"add20ee86ff5c28396ee2e7f77d825d7e425b8946733195369=
0c40f40b5dba41","src/zlib-ng/arch/power/fallback_builtins.h":"78a8da60bad8=
ba01278e495482108adabf9e96bdb214e869b61ab1f63f518c9b","src/zlib-ng/arch/po=
wer/power_features.c":"4dc4c14dfa2d3333c73fad7b1f7a79d3fff68c1d1fd643012fa=
f82bd4114553e","src/zlib-ng/arch/power/power_features.h":"c9c47cfcfff347e7=
9f83f56a0677565d40299e03ffbeb918c4ae69518d290ada","src/zlib-ng/arch/power/=
slide_hash_power8.c":"58d93cee1a2cf14f13a8e9e31ba5149fe2b1e069846f52ac1f11=
c42cfcbd49a4","src/zlib-ng/arch/power/slide_hash_vmx.c":"1b6297a9616456ba5=
34bc1d93afcb99e36dac357be68aed106bb71dfea621a86","src/zlib-ng/arch/power/s=
lide_ppc_tpl.h":"c8900c594591e1aba3188f97c374e5561fe1e96f653c668352b25647e=
449f4c0","src/zlib-ng/arch/riscv/README.md":"7a3e00ab7fe5a66cf5cfe5671e9e8=
367e6c655a3b72d12de18d840538c506ef0","src/zlib-ng/arch/riscv/adler32_rvv.c=
":"e2472cf46b376a0ed8b7545a3192d195659353e093772216f0d28ae7d75afb1a","src/=
zlib-ng/arch/riscv/chunkset_rvv.c":"d5b0fd27dcc8d4b3773caae16290014fdbc001=
1cf62e7f63a4e5d897149b165e","src/zlib-ng/arch/riscv/compare256_rvv.c":"4ed=
8d6b39ef2218c1d474ab586fc19d7e0821445241e5ccd6a75992cb17b3bb7","src/zlib-n=
g/arch/riscv/riscv_features.c":"a117eada0164dd92c06e9804a70fd2f434b8d14a6d=
443f0b3513330fe08c18a3","src/zlib-ng/arch/riscv/riscv_features.h":"26953a0=
9f72edb0e66978044d75e054e40d36d2b62244359b5e5e4ab936d2c9c","src/zlib-ng/ar=
ch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337b482fcb72d080b0897e48abc9=
753b51d40facd9a1a1","src/zlib-ng/arch/s390/Makefile.in":"8cb582f8e6ccd9146=
f64214a513e546122976c60e782cede19b282bf3b519235","src/zlib-ng/arch/s390/RE=
ADME.md":"0dae0e510935c5f91e00dfe0d57a9b7a82891ff59edbd14b64b54c950327d708=
","src/zlib-ng/arch/s390/crc32-vx.c":"c5250cb1df20eadcf0c56ba68e0dd7cf43d9=
36f92f245aad2bfb519988f902a1","src/zlib-ng/arch/s390/dfltcc_common.c":"9a7=
01d5f973c07e054797ed030851171abaf20a40a4ab2359914c737b0ab9671","src/zlib-n=
g/arch/s390/dfltcc_common.h":"1d042b79da6bbcf4e1f5b32ca017bc49fa89129c7a92=
5ea17b931de34012ef18","src/zlib-ng/arch/s390/dfltcc_deflate.c":"146569d921=
d68fd9af7b67a74bcf0aa41108a4072564629db7ad6c2dc8a429ef","src/zlib-ng/arch/=
s390/dfltcc_deflate.h":"309d7c9bc4e5de3196ebe61a2e5c17e07bfb66bb8a170562e9=
0e9105e68ab302","src/zlib-ng/arch/s390/dfltcc_detail.h":"6ba837c1522d85df5=
99d5baeb5e0076d67355979a9768da9b6a095d65e645d41","src/zlib-ng/arch/s390/df=
ltcc_inflate.c":"b1eb56def7acf39aabb7abea8249a48c4af0dfea7a63ac380e5437d43=
2ff9d9e","src/zlib-ng/arch/s390/dfltcc_inflate.h":"06dc026f991022a7be73865=
a554785b31d167261c4006ca6438de7ca31893ceb","src/zlib-ng/arch/s390/s390_fea=
tures.c":"fd99ba0abc73a37168a5c369a0714e3f35816a792438bcb1e8e60f5dd2983293=
","src/zlib-ng/arch/s390/s390_features.h":"f65396333635e937634dff42a43a8bf=
a272f53ac88e763d52d4c56241b1eaab9","src/zlib-ng/arch/s390/self-hosted-buil=
der/actions-runner.Dockerfile":"5d4c45e9929fd9736640aea294f1d13f346fd52a4f=
4771073be32abe96ada971","src/zlib-ng/arch/s390/self-hosted-builder/actions=
-runner.service":"62a19075adeddb3bee57bbac81c7acadacbf9c288e2b497e36ff7f2b=
3daa7558","src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/actions-ru=
nner":"f647e18728ea15fe927ac9f8cba83a5b343654a0e91b5ebe653bae7af7375110","=
src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/entrypoint":"add4ebdc=
4f06ed15bb1de12a8c9ceb370a60baebb0932a1026a75433940ad3df","src/zlib-ng/arc=
h/s390/self-hosted-builder/qemu-user-static.service":"54551049f6181da88700=
a2a944a72b0af3b8abde876fa28e1348deb5eb96c91b","src/zlib-ng/arch/x86/Makefi=
le.in":"ad6e71fe6e42005b65db8454b0ea0a6c9ee91664698c08729c01e6b00d0df933",=
"src/zlib-ng/arch/x86/adler32_avx2.c":"cc0598333eff9110b5e8c0dc38ba543bfdd=
3ca5a66825f440909ba7a8923fdd3","src/zlib-ng/arch/x86/adler32_avx2_p.h":"45=
e6264edffc737081f55a5b5e85b28d9db0b27b63183ffbb492f8c11bc670a2","src/zlib-=
ng/arch/x86/adler32_avx512.c":"7a949d8ad2d15709d33872ee97e70a2e0cc2c6c375d=
7064cbc02b87e70905d1e","src/zlib-ng/arch/x86/adler32_avx512_p.h":"1b4beda1=
1693ac03e4b20e054a765df427f845a279bce547b8208d20f5a302bb","src/zlib-ng/arc=
h/x86/adler32_avx512_vnni.c":"9d11d2049df211f11a48a91e340e20686763c1eac204=
63dcd27dd7bfaa159f76","src/zlib-ng/arch/x86/adler32_sse42.c":"1d2dc53b05ac=
75667c6d1c625c8c391e4851b28cff9e97ebfdb774767581fff2","src/zlib-ng/arch/x8=
6/adler32_ssse3.c":"7666f99b2e530265cb9848c1047ccc150da0add19b41aa2d7756c6=
17377622c6","src/zlib-ng/arch/x86/adler32_ssse3_p.h":"5aab2f802ba6bdebc63b=
411018e5116fe26d38e90adf353646b65af4ebe7fa40","src/zlib-ng/arch/x86/chunks=
et_avx2.c":"ac300f37fbc99ab2d3bf47a640bdf2d87ad8358ef081eea21c541966830281=
b3","src/zlib-ng/arch/x86/chunkset_sse2.c":"a400a128a84185c945f9ac9303e17c=
944f2008085d7a4402d279bd59893dc89a","src/zlib-ng/arch/x86/chunkset_ssse3.c=
":"1f69ef9ae20cca1e4fc6924462255b8969685387c10694ef1dda28b3098d6f6d","src/=
zlib-ng/arch/x86/compare256_avx2.c":"2516d00faa6939e61dbb0978a9c4c81f9e3a4=
2fd053b2a2241673da7cf4fc781","src/zlib-ng/arch/x86/compare256_sse2.c":"3b9=
83708034f33b5da49f6f5041351a2e66358c76645c552f6e4dc37fb890a80","src/zlib-n=
g/arch/x86/crc32_fold_pclmulqdq_tpl.h":"1b3b79dabff0bf7ecc3b07356c5aeb6ae1=
fece0fd70ac7e235aacce3da77ea19","src/zlib-ng/arch/x86/crc32_fold_vpclmulqd=
q_tpl.h":"7eddba31e3d1b1808fc6df9f96ada03c59952961af895d8538f5a8292392b5cc=
","src/zlib-ng/arch/x86/crc32_pclmulqdq.c":"f247408c353bbd0fcafff23fb97aeb=
4d9a72e0a416effea566183b9b5dbedf7c","src/zlib-ng/arch/x86/crc32_pclmulqdq_=
tpl.h":"5fedffe4b853cabfef09cfcebb501cd53a97c212e470bdfc65c28dc998840e05",=
"src/zlib-ng/arch/x86/crc32_vpclmulqdq.c":"870d06ca9fa7b48db4b720d2fd62620=
94200cf6180fa76a601d17c722bf0e406","src/zlib-ng/arch/x86/insert_string_sse=
42.c":"28a6d418a9563d464414c3880d6053c656aab40c6ebe21947cf17687d82e547a","=
src/zlib-ng/arch/x86/slide_hash_avx2.c":"9740a36bb4dd90f40394344026be9a13f=
3acb6e85e6b7681c30fd7f7cbf8e28e","src/zlib-ng/arch/x86/slide_hash_sse2.c":=
"fa009305a1c82708638dff25e037067656350303b25f5774489417e096c30ecb","src/zl=
ib-ng/arch/x86/x86_features.c":"b755befa09a56ed27d70f2be93b0a72a355fe8b490=
827b55fce60ab51693c70d","src/zlib-ng/arch/x86/x86_features.h":"6429fa7345a=
9892633c884f7fc26f9558d86c77df9e8589ba9623a27e1d9fd57","src/zlib-ng/arch/x=
86/x86_intrins.h":"707b836360628cb34a0fb7fa675b5e8674d146f55b1f60fd739b85a=
a5dc935cf","src/zlib-ng/chunkset.c":"531f58c77c184b225304888ddf1930a76beef=
be4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"9919e10e9c22443=
16e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng/cmake/dete=
ct-arch.c":"1af38707fadc192c8e4a28715c896148a0909be821fb443919e191ff2374ff=
db","src/zlib-ng/cmake/detect-arch.cmake":"85a2eed469fc7765e51c382f475868a=
644036f057f5b749d3ef59eec2b4b2748","src/zlib-ng/cmake/detect-coverage.cmak=
e":"4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a9","src=
/zlib-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a31fc7a7=
8f0beeac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsics.cm=
ake":"cfad619b863adf57132434f7b9c36c4f1a0466e5fdb11ac673e703ed5e471cd0","s=
rc/zlib-ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5d14=
70ef48852f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cmake=
":"a8c8f70e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src/=
zlib-ng/cmake/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1=
de3705b39a66a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"0=
5e38076fd6ffb9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib=
-ng/cmake/toolchain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b=
1beb5d16876b741717673341","src/zlib-ng/cmake/toolchain-llvm-mingw-aarch64.=
cmake":"4deffb541ecd21ade019daa2e96e832ead8c2c62b633bedb8688d0e7c7012d33",=
"src/zlib-ng/cmake/toolchain-llvm-mingw-armv7.cmake":"3e95adbade93ec162478=
de3339427ed88b12c922f4975c2918977859325f5459","src/zlib-ng/cmake/toolchain=
-llvm-mingw-i686.cmake":"1064a1ff2bab21489c184c1cc2b07181ebbbcc32e45c13cf8=
ed6b9ec60560c2e","src/zlib-ng/cmake/toolchain-llvm-mingw-x86_64.cmake":"57=
7d333ad70cf27ededc75554428368e84c334cc7b716e18113620f5e7edf305","src/zlib-=
ng/cmake/toolchain-mingw-i686.cmake":"df9000354b820d3713d1469edc9f94cd0953=
89b0cca83965730b8e64857fdf3f","src/zlib-ng/cmake/toolchain-mingw-x86_64.cm=
ake":"ee316e6e3202919da5d497f9e246466fd715fcf079cb5b4afc4774089d1fefad","s=
rc/zlib-ng/cmake/toolchain-mips.cmake":"0d0d00b809a30021bb4b9e3ace7371200b=
b4bfa6509813c829ca0cb569c7af68","src/zlib-ng/cmake/toolchain-mips64.cmake"=
:"f19574aa068ca4374b657ce7bd0517b9297c622144814a095e26db05f0a1cd20","src/z=
lib-ng/cmake/toolchain-powerpc.cmake":"9bd6fc58ce5b70603657f2c195c4a5cf52f=
ae96ad63ac787978831c5858f762c","src/zlib-ng/cmake/toolchain-powerpc64-clan=
g.cmake":"aab0b9e0f19a281dc99f4dfa5675976c40b5fb7f8139dd2eb0901fdf3cedc952=
","src/zlib-ng/cmake/toolchain-powerpc64-power9.cmake":"57c789c468e733971c=
2654faf34f7dfc9dd1e0e5bcabbd609dcd01dcbd25c487","src/zlib-ng/cmake/toolcha=
in-powerpc64.cmake":"917fc5eef84921d8b38f43c2b4f60870965b4eecc8f018c7b3499=
e1142c715af","src/zlib-ng/cmake/toolchain-powerpc64le-clang.cmake":"47ac4a=
05b61210a83c7845a5522b91740bc8a7bb897312cc37131f85bae9e1b5","src/zlib-ng/c=
make/toolchain-powerpc64le-power9.cmake":"b295b61ea248d8ef98d9276fad3db143=
a6fb80ab738c54bf88cb594d82c70a8d","src/zlib-ng/cmake/toolchain-powerpc64le=
.cmake":"5b2edd36d62de513db2d32bfbf779979d81ac527b981cc3379a4e933fc5a94d1"=
,"src/zlib-ng/cmake/toolchain-riscv.cmake":"d7b4ac4be3651aec2e55788d815141=
482d4fe92713713fdaba9215dbbbc9b88a","src/zlib-ng/cmake/toolchain-s390x.cma=
ke":"cf52cecea7bd2a9d1ff5fd8edcb03c531e3b404bbcd15a15dec2e0e19936f2ac","sr=
c/zlib-ng/cmake/toolchain-sparc64.cmake":"e543062485d06a7e0fec8135887c5e73=
363517fa4babc23ef7b780916d75afda","src/zlib-ng/compare256.c":"4890f97239f6=
3dfbbc986ddd05039798752ec0ad530ff7d25978deb44f774ad5","src/zlib-ng/compare=
256_rle.h":"30fca191b0474e1549d3ce292bb11ee90dc3dc9fc685932cec3971c1d0e8f6=
52","src/zlib-ng/compress.c":"f7c69a4d2f3b87ff0094115977dde1cd17703cc9856b=
a19489dd94e0ed16b646","src/zlib-ng/configure":"5778b60178bd2cf770fc01c5ce2=
562e50c1859a0cc67f8b522deb38ae4dbab77","src/zlib-ng/cpu_features.c":"aec35=
9d85d64c2ff88132a123406726bd966e0d56d0dc8ce1d5c3f25e1801440","src/zlib-ng/=
cpu_features.h":"21c43d2a8375e73abea63082e08d9279eaf457970d34f877830bb3157=
5498a8d","src/zlib-ng/crc32_braid.c":"8a33cffb026b82a027b45e041935836b36b2=
d075796e5498e33ce64ec0cf93e8","src/zlib-ng/crc32_braid_comb.c":"217741d3c1=
c0018bb12ab22c987804634605f5b7ad6bd243e25eb0499c80af5d","src/zlib-ng/crc32=
_braid_comb_p.h":"6c8035e05d30a6241be55467fc59e4d7deda6b618b955a11339ffee0=
8a39c75a","src/zlib-ng/crc32_braid_p.h":"951cbd948664498dd8a56393bc88debda=
d8b21dcc8e1f16d883c07170e4adb4e","src/zlib-ng/crc32_braid_tbl.h":"e22af112=
e3c1c8bb4065d39fe678eba71dd08893eb06f9414b02f4cf5a6f46de","src/zlib-ng/crc=
32_fold.c":"f6363abbd1e167bc7a6fa8f92e5211f4fa3e70d30fa5e10fa6f416f5db3726=
78","src/zlib-ng/crc32_fold.h":"42412c5029057579148a2238b0bc882f294f661d2a=
f102bd9213531894302f29","src/zlib-ng/deflate.c":"70c72cdbf88987660e787a996=
58641bce36fff4848f9bf395f3727df9543664b","src/zlib-ng/deflate.h":"f45a6097=
10150fb758ca89b36a7f5a029b525fe70f0e3296a4847d73872db2ca","src/zlib-ng/def=
late_fast.c":"52648097b16070c156c27d38566720eca08d48e35cd89a80f196f0e77951=
112a","src/zlib-ng/deflate_huff.c":"923d316676c00f307a7d6a58d77f9364f06607=
afcc686b464b557ff5478f8b6d","src/zlib-ng/deflate_medium.c":"d3172c1ea0ae1b=
c2e3b7691b005bbae35e84b7588ef2f5805b9dd0c4ccecbd67","src/zlib-ng/deflate_p=
.h":"2eaac98e9232959c730d84a408bed641be817dc3468aeb427062d06b02eb80b4","sr=
c/zlib-ng/deflate_quick.c":"3825eb4d22a150f9cdaba93db890d95b8d9e9d0f3f1052=
4fb27a9a1289aa4c0f","src/zlib-ng/deflate_rle.c":"5dcc0496f74b5ce677ab5a58e=
a232d0ba653102d2f71cf35daa6069ef88b7af6","src/zlib-ng/deflate_slow.c":"544=
9816c381138eb07cd54ec7c0c77fb811f4f274c27bf15d26e008de6a9eb5c","src/zlib-n=
g/deflate_stored.c":"89b81c09be2ffd84138940ac6c4e9688f956603b45eec6d0d52d5=
79cac3f15e5","src/zlib-ng/doc/algorithm.txt":"0d21a0a4c47e512743389628d138=
5a831a5e5ff716491095a382b923287f4223","src/zlib-ng/doc/crc-doc.1.0.pdf":"0=
64f9252d6e2e15ea56c2bd18e160e5c9c84bcd137c11a7af497aaa511ace998","src/zlib=
-ng/doc/crc-pclmulqdq.pdf":"3cf18f738dd0da7e5a28ff999d987bb61ac42cce354bbe=
e1364d06fb3944f7fc","src/zlib-ng/doc/rfc1950.txt":"8f0475a5c984657bf26277f=
73df9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib-ng/doc/rfc1951.txt":"=
5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f301350009","src/zli=
b-ng/doc/rfc1952.txt":"f7c810fd9d719d002d605207a9b880600f71d039b9626c5b4b0=
3f2122438dd2d","src/zlib-ng/doc/txtvsbin.txt":"47c273bb22c9773248d380549a3=
30e5c262266b1292154b0d3014f731cc73f47","src/zlib-ng/fallback_builtins.h":"=
c02e559d19f351f2f9371ee2042ca6a725d14f17862dff2414fd2ab3d7984875","src/zli=
b-ng/functable.c":"d7ac98c7def281c707796a4317e2dd6754d654bc8d833ae67a77f47=
a7c1dd5bd","src/zlib-ng/functable.h":"64fbabaa8459898d14cb88078676c42fce12=
a951b4b1d83f9085e104ad407a47","src/zlib-ng/gzguts.h":"d9a4e984bb6c2ebe5c85=
8b37b1c6411af1edc21c3c15d63b6588016b71369b71","src/zlib-ng/gzlib.c":"91011=
bdfaa99bb5e49aece64fdee995207b1ce5a96227990f16f9aea55026c8e","src/zlib-ng/=
gzread.c.in":"3501e5124923207b2603d9695c3bad1815ca2dc8f18b6525bdd5dfea6031=
3acd","src/zlib-ng/gzwrite.c":"9f474aeefaf0150d8871eb9202ebd43a28f18bdf39e=
aca4f35cfb52227e74c63","src/zlib-ng/infback.c":"db99c5b105c34c7c2967bd97e1=
6f976217530c22d6545e61cbf657522e24de87","src/zlib-ng/inffast_tpl.h":"51622=
f34e8808798a43412b4fde62ebd58ba012f5452bf2ad9a8001c98539166","src/zlib-ng/=
inffixed_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe7ee0111ed8e32a26bcd52187=
f364314","src/zlib-ng/inflate.c":"2c1bd0f4939c372e49a9ee0ec8a8cdee369d9c6c=
10124b4e11cd197f44ce3a36","src/zlib-ng/inflate.h":"1750ab33be4461f2e6b8e43=
bef5da11f3db49d5d2a3eacd03d881d33c1df7def","src/zlib-ng/inflate_p.h":"4a31=
088faf818d2615de31b099e8f55ee8463166477d6cb5d6763c913b6acef9","src/zlib-ng=
/inftrees.c":"206fa4c762203823151dcd3b1a5b389fb40efd4c88aeb2bc302aa1d5cfd6=
d6d5","src/zlib-ng/inftrees.h":"2ba1beb76d7922fcb37708809e31f62ee366827da8=
0faf09a7e461b439afd291","src/zlib-ng/insert_string.c":"7a9455cbb3ca8fe6e71=
11471b9f4c0a32fb49a6d0ec589b027dc2cb2b65c8dce","src/zlib-ng/insert_string_=
roll.c":"4d05f19591a5c29d2da398e10e9d0b050d738cc8838d8dda4beb1cc7281ede07"=
,"src/zlib-ng/insert_string_tpl.h":"972e69808ce5e74d0c54af4ee447b996b2d056=
3eb861b90856693037ce8cca9f","src/zlib-ng/match_tpl.h":"1e20d0ef73a58266062=
40f4efd2a8e993d203f376017397342b9899b1f919276","src/zlib-ng/slide_hash.c":=
"74adb34a4a35331db810dbb5d740af10cc1db7d24a89ea387aa2dec956a05b2b","src/zl=
ib-ng/test/CMakeLists.txt":"d9c0e5c87fef7b26826f8acc84fb34df0c90cf8804818f=
93fc12edf91d92d744","src/zlib-ng/test/CVE-2002-0059/test.gz":"60bf96b8f433=
bd7e057ce3496aceaccd70ec80f596a4aa8bcc7786056705ce66","src/zlib-ng/test/CV=
E-2004-0797/test.gz":"38caae524705f676bde13a8df9fc8c7d2fe105ba6bdbab62a405=
b0276fd3aa2e","src/zlib-ng/test/CVE-2005-1849/test.gz":"e4d5a60617df4b5dd4=
4eda94751ce1eacdb325792bba6e3cc4676719a3adf742","src/zlib-ng/test/CVE-2005=
-2096/test.gz":"8f702d4861aa3ec98ac03a59ff26b430939630cb5cd4266d2658d3b836=
d576f9","src/zlib-ng/test/CVE-2018-25032/default.txt":"d7f8278db331c47bd12=
08bf41e7903cbddee4f7b47c666c40afdd3c96237752e","src/zlib-ng/test/CVE-2018-=
25032/fixed.txt":"3b27a98edd2f3f580033f9add11d3469d7808c969a1128ee00c18ac7=
a12cef57","src/zlib-ng/test/GH-1600/packobj.gz":"372ba8e7aa3bf258e85c793ab=
e1268965765a9f1bc6e2a0e77d3b723a4a019a3","src/zlib-ng/test/GH-361/test.txt=
":"358497d0a7251ea42101dc77b02337f46fd89af09643a8288e2a3082e5d24128","src/=
zlib-ng/test/GH-364/test.bin":"af5570f5a1810b7af78caf4bc70a660f0df51e42baf=
91d4de5b2328de0e83dfc","src/zlib-ng/test/GH-382/defneg3.dat":"b22bef6b7392=
401c9e7b079402c4a4074053d7a914d050400e37fd7af6fe26d5","src/zlib-ng/test/GH=
-751/test.txt":"b83d833803b7bc3124fb2a0034081f0b999ad10c33a8dfa3bfd181dc07=
8ae3ee","src/zlib-ng/test/GH-979/pigz-2.6.tar.gz":"2eed7b0d7449d1d70903f2a=
62cd6005d262eb3a8c9e98687bc8cbb5809db2a7d","src/zlib-ng/test/Makefile.in":=
"2eed5e763754e1f0f0ee1908e2f8080a2fa9e5f2770b3fc8d74b9975b4cd2bb5","src/zl=
ib-ng/test/README.md":"6a34f8fc7a0144958cc9a0cded46fc38a7e15aba3dfa5bf56d8=
d86c3fb72d82c","src/zlib-ng/test/abi/ignore":"36e1928ffa34c21c1d2fd783633c=
9975e1ff282682ba2eca14b61b87650a2e13","src/zlib-ng/test/abi/zlib-04f42ceca=
40f73e2978b50e93806c2a18c1281fc-aarch64-unknown-linux-gnu.abi":"e55ef93145=
cb4ceb2e22562ab5c18a2e26f8330862ed9468df7ada66a47dfe08","src/zlib-ng/test/=
abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-arm-unknown-linux-gnueab=
i.abi":"d45ec6ff3f41ce11713a39aaad08e4ed9d21a165754a1c5a5e5f123c4daf8241",=
"src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-arm-un=
known-linux-gnueabihf.abi":"2cef33db7275ba069bfa3a929299dcb8f1529f3d0ad344=
c1e0ef483905e996c7","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e9380=
6c2a18c1281fc-mips-unknown-linux-gnu.abi":"25cf82ce8d5afde37456ce22943358e=
6d5f4dec31c1d1f732a1b07f34d7003f0","src/zlib-ng/test/abi/zlib-04f42ceca40f=
73e2978b50e93806c2a18c1281fc-mips64-unknown-linux-gnuabi64.abi":"59e435fa4=
2a1aacd30d24d184d1ae505392123a8f16eaa0ca55e061ff2c427cb","src/zlib-ng/test=
/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-powerpc-unknown-linux-g=
nu.abi":"5b4c5724c018d4e5820cfd9f94526ae41101fbcfa960ca98efcc06ed33a5b7ed"=
,"src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-power=
pc64-unknown-linux-gnu.abi":"e4d05062bbbace98c02f297585ac69a88e6b4f34122de=
6a854e5176d6d81ef9d","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e938=
06c2a18c1281fc-powerpc64le-unknown-linux-gnu.abi":"bc41acbb1e207e8dfbf0f4b=
d628a0d32b94e288d324f924dc353898c3ae3bd37","src/zlib-ng/test/abi/zlib-04f4=
2ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu-m32.abi":"5b79e86=
fc4f99e7d5c38b08e63ee347f29ed5312ac7dac16459b3d4562c04a50","src/zlib-ng/te=
st/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu.a=
bi":"568cdd3893cd364fcdfdb1536f394dda4d237a03a0a7fe80938763b73739092c","sr=
c/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-aarch6=
4-unknown-linux-gnu.abi":"af41851f1b97ccb94e534cf3e54985fda0700c94d8fa850e=
c021f4b7d907f480","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c15=
5e4baf80882311-arm-unknown-linux-gnueabi.abi":"b2197b5aa7145c62c39775e7e97=
ce8de4d00b44f4f2ecded47aec8e725cf4563","src/zlib-ng/test/abi/zlib-ng-e4614=
ebcb9b3e5b108dc983c155e4baf80882311-arm-unknown-linux-gnueabihf.abi":"a037=
a1494a5f724462b6fb34d595b7d1517cdd60af1d890d00fa557394c0d923","src/zlib-ng=
/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-mips-unknown-li=
nux-gnu.abi":"8cf1dd6da2c8fadb53748687e7cae304cef025f490cd8a9d1970bdff04f1=
3ddd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf808823=
11-mips64-unknown-linux-gnuabi64.abi":"38549f6d4efc5a4e60e83dfee03f727b426=
ed969b6e476acf11ab1d5f562eb1d","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e=
5b108dc983c155e4baf80882311-powerpc-unknown-linux-gnu.abi":"09e7feffa1d24c=
f68cfd7d0c1a5a80a5d9d5df5bbda383b2a7d5f99f194a06fc","src/zlib-ng/test/abi/=
zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc64-unknown-linux-g=
nu.abi":"cb360745c650e62db182932ed37e7648d1fe939caa50eccf7f9068e653ce9a11"=
,"src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-po=
werpc64le-unknown-linux-gnu.abi":"75170876a3b207c383889bac021ae0ff710e2915=
ad8c6b5f02c38d6e3ef731cd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108=
dc983c155e4baf80882311-x86_64-pc-linux-gnu-m32.abi":"023ad5584f431bd2985d7=
231581058c249dcc0544b21fbb678ab04417c5e8103","src/zlib-ng/test/abi/zlib-ng=
-e4614ebcb9b3e5b108dc983c155e4baf80882311-x86_64-pc-linux-gnu.abi":"f07233=
6d8a54a31ae4e991ecd2e0482b3c8102e0256da5f020112aeb5a9d68d4","src/zlib-ng/t=
est/abicheck.md":"d960023cd80e04b2d4dcec8cdd3315c7292229d45a3301a5dc521305=
8ba22185","src/zlib-ng/test/abicheck.sh":"293af1e5c1e18133d1f27c9e34bdeb0f=
8b0123cf3c825562a11a31e87d2b544e","src/zlib-ng/test/add-subdirectory-proje=
ct/CMakeLists.txt":"0d5d9bcb4aac1e17b5146eb727ca95e4fb91fb098fe567925befd7=
a88f8cf677","src/zlib-ng/test/add-subdirectory-project/main.c":"0f84f056dd=
c067fa1374bea36c45c516b5ce1b4a78e8a381c06cce03320e66dc","src/zlib-ng/test/=
benchmarks/CMakeLists.txt":"3a9207269ce3ceb3b9351c8b68681cb316be79a686ac99=
becd27df7f0bc69601","src/zlib-ng/test/benchmarks/README.md":"f44de30583886=
085f4a3158040c795284cef19e32c50a80fff54608ab735e5aa","src/zlib-ng/test/ben=
chmarks/benchmark_adler32.cc":"d2de7d69b94aa6447804e3d42ed7c889b2d6a5e1d4c=
9f595a8eff2f919f1716e","src/zlib-ng/test/benchmarks/benchmark_adler32_copy=
.cc":"7c5617b6d014b4f1e0c116439fb4a6e0e720b4fcd132c68b8f1f49ea8aa06af9","s=
rc/zlib-ng/test/benchmarks/benchmark_compare256.cc":"2ffcc22f1fd7df9db92c9=
d97302e46f83811f5cadf35327387ff22f27d09ee22","src/zlib-ng/test/benchmarks/=
benchmark_compare256_rle.cc":"3631acf6fc6bca5a4028cf58dd25347bbe448e19bd9c=
ae1d4456ae30dfeccf74","src/zlib-ng/test/benchmarks/benchmark_crc32.cc":"cc=
1c6119ff9bd112999d0cd6ae62b1abd95268d8671cc9ee5abb7f6659496a74","src/zlib-=
ng/test/benchmarks/benchmark_main.cc":"67270b2efb97c24af9358220cd642cf0c8e=
d393d07f61abca31bc0c103b1bab7","src/zlib-ng/test/benchmarks/benchmark_png_=
decode.cc":"e9485de5e722ef1b62131a27a98d2cfe668ee8becbd5fc9938972022e07c8d=
60","src/zlib-ng/test/benchmarks/benchmark_png_encode.cc":"4b2203af2ef58f9=
5773ca6d82569f747f2cfb3c4116334871cfb255a0d7741e1","src/zlib-ng/test/bench=
marks/benchmark_png_shared.h":"2a02ef2aa7b7b60afd5e474ca729498c8e6a7873e96=
8634fd0c43d10d1506ca5","src/zlib-ng/test/benchmarks/benchmark_slidehash.cc=
":"d239dfced67f85fb2dcea7a6a03b2649a59a63948e9e6af8c2bd3653d73f8130","src/=
zlib-ng/test/cmake/compress-and-verify.cmake":"0dd1712183a15dd79bd2501dfac=
ef681a402493d23aa3439a9293c1ec5aca863","src/zlib-ng/test/cmake/run-and-com=
pare.cmake":"13d85c12c9d6c7b1b148bd0c5a5b4faa6a4b56f3823bf03c4f8d914c9c594=
9d8","src/zlib-ng/test/cmake/run-and-redirect.cmake":"7f08d18c09aa58113882=
ec760735a62a1723a5bfcae9f73bd3713a4dbaeab898","src/zlib-ng/test/cmake/test=
-cves.cmake":"c526d10727275eda6a6e5912a000e5f2ee369f904f923001f196b69eae7c=
f5cb","src/zlib-ng/test/cmake/test-data.cmake":"4b4e003f000fe15dc57052faf5=
637a85c9c7f3a6d07592184b87ea508b6fc0dd","src/zlib-ng/test/cmake/test-issue=
s.cmake":"258d8453dcea579d47abbedbe8e7d4f13d0048642ea3ab53880245998de4f22b=
","src/zlib-ng/test/cmake/test-tools.cmake":"d6cdc83cf1b5c6c342b461bed6c87=
d57c2b78bcac3f6b3e357bffba2181d49c8","src/zlib-ng/test/data/fireworks.jpg"=
:"93b986ce7d7e361f0d3840f9d531b5f40fb6ca8c14d6d74364150e255f126512","src/z=
lib-ng/test/data/lcet10.txt":"1eb5d7bddb1c3cb68064d5b5f7f27814949674b67025=
64ff7025ced60795a6d9","src/zlib-ng/test/data/paper-100k.pdf":"60f73a051b7c=
a35bfec44734b2eed7736cb5c0b7f728beb7b97ade6c5e44849b","src/zlib-ng/test/ex=
ample.c":"5c2d07af5ecf874823ca73e6ff0d292c5d3c5370104d87526169b6f222182dcd=
","src/zlib-ng/test/fuzz/CMakeLists.txt":"395049b7625f120abee1e118487c55a8=
bd3288d0974081ecaa8baf33f60e80c8","src/zlib-ng/test/fuzz/fuzzer_checksum.c=
":"68ed79ec1d7fefa548f4d32ab7885479442520cdf53ad59eadfae13e4b15efe0","src/=
zlib-ng/test/fuzz/fuzzer_compress.c":"3f507a18710fb2a1d87fde5cf3affc74b53a=
689e9d2ce6f887ee64eb778e568b","src/zlib-ng/test/fuzz/fuzzer_example_dict.c=
":"46541ed3ef9bb7378120d47133f18b4194e955e7a84a439647205de68e745c08","src/=
zlib-ng/test/fuzz/fuzzer_example_flush.c":"393e7872825bb1ca366d0d8552b9444=
2511ed4a557db6ece16540b79b7e9cbdf","src/zlib-ng/test/fuzz/fuzzer_example_l=
arge.c":"e3b91b1ced83dfe538e8ae5262f1756181a7785e8c2ab38ac2881456bd562277"=
,"src/zlib-ng/test/fuzz/fuzzer_example_small.c":"de9f5dc3182405750341a0f44=
c37bd8ba4f21d993284456ba8e6ce3e36d6b9b3","src/zlib-ng/test/fuzz/fuzzer_min=
igzip.c":"dbc35b317935ba7cd2dfbacc067b5b17534488dc9ac1daa2bb28b67b1b850aa3=
","src/zlib-ng/test/fuzz/standalone_fuzz_target_runner.c":"e6170b744faa68b=
f2a414e99fc87accf4db2a5e0eb58b17aded5c692ea493604","src/zlib-ng/test/gh123=
5.c":"057934cf585b9998478e3d77ecd0782d941e20ebe50688ef32b961559d6dfe2a","s=
rc/zlib-ng/test/infcover.c":"82ccdf5b2bb081b9da18c55c0078ff030ae145a4943dc=
90bb85c4cce00e9deb5","src/zlib-ng/test/minideflate.c":"1b2d38cdbcb8e2c399b=
7dc9db59fe95b19f0c052a79dddf91fcc0733c898d389","src/zlib-ng/test/minigzip.=
c":"154131d41a881ef3264abb9eb70f7cdc6782718a2164f4f16b63b4e5363ca313","src=
/zlib-ng/test/pigz/CMakeLists.txt":"e55880cb8b15839774f2387c07aaf42df680ce=
c0305522ddecbe5f638e5af2d9","src/zlib-ng/test/pkgcheck.sh":"61a6ebf6ef9fe0=
5935467b29e25669fc44bb6240ea0ca87e9c066d982032f4b3","src/zlib-ng/test/swit=
chlevels.c":"1c726e63cbe24fc12c88e9928db5a1515c18364987dfe588daabef4f8b1a3=
21f","src/zlib-ng/test/test_adler32.cc":"aeb9533ae9be0f76879100d038980f373=
1ff4c249b4de105f2df6f371a7990a5","src/zlib-ng/test/test_aligned_alloc.cc":=
"bebdd6dba3c7452e7d8557c47b14226209175fb5fe313b176cf752848117536e","src/zl=
ib-ng/test/test_compare256.cc":"4362eccf7b473d82778fc4171552f8160b54b6fc61=
95bf930cd0e988dff5a093","src/zlib-ng/test/test_compare256_rle.cc":"8428d82=
04d0598cd1071f3db9176b42fd423e532051cd14fd91e5835a01ba203","src/zlib-ng/te=
st/test_compress.cc":"32d3bb507a95d56d0441280a04569164d19a8241d85084a9fcf4=
9f51afb82fcf","src/zlib-ng/test/test_compress_bound.cc":"21f71385edd73f92f=
40a9451673bdb9ea3f82a49e7f4d4bdcc4b74b086320b12","src/zlib-ng/test/test_co=
mpress_dual.cc":"a76759d3d5c54315a4ee3197109a4517dfae9931eb65ae8cbaffd8a58=
bb562e9","src/zlib-ng/test/test_cpu_features.h":"28bbb2bdf56ee7988d4fdfccf=
4c6ad584bb8b39c4ae80fdab12effcc33c4d8ae","src/zlib-ng/test/test_crc32.cc":=
"57a428c33f3158f1b78840b779dfb46f55a943fb5e7d2c23541b9ca7090d7264","src/zl=
ib-ng/test/test_cve-2003-0107.cc":"629f1fe659558c9deb767b3fbbb615539b0458f=
8b67a405ece924cac6bebb531","src/zlib-ng/test/test_deflate_bound.cc":"eecbc=
494f22282bfd94a2545fc142b8fdb5582991c22b6e50fd46c40885ad81e","src/zlib-ng/=
test/test_deflate_concurrency.cc":"27a91c74cf9811921bc2424c235e540a18ed638=
53d37e29814a60ed21f1a8654","src/zlib-ng/test/test_deflate_copy.cc":"1a286b=
a7772bb1a6d06233b075a83f3f1814bab2fd7d3757c090f5db25db90f1","src/zlib-ng/t=
est/test_deflate_dict.cc":"3395afdc925059faa1b334bf8a497803132f9ca7703d48d=
ff0ab0264f5292f73","src/zlib-ng/test/test_deflate_hash_head_0.cc":"2d0b7bb=
7dcd00a630358e6c3cd79676a838efc262794b751b42d030d949e7587","src/zlib-ng/te=
st/test_deflate_header.cc":"643763a811a3673a05959eb6dfeffa3ff25dc3672f67dc=
8a9f1406a31812068f","src/zlib-ng/test/test_deflate_params.cc":"7c747362cac=
9f74b2bb8e8d276539807e8222b18db172b81ccbaf96235b8be61","src/zlib-ng/test/t=
est_deflate_pending.cc":"1a0e700d3a2863b6087041fef379bd683e882d5932840fbec=
b3e0b91e74565cf","src/zlib-ng/test/test_deflate_prime.cc":"d98d4aee8c240f5=
bc3b3b83f828917586b846850ed82ade6f5f728a4281a1321","src/zlib-ng/test/test_=
deflate_quick_bi_valid.cc":"9706d0bf9d844b21f1655498bf0f9901c7dfc272cdef37=
f2d1af238c71df611c","src/zlib-ng/test/test_deflate_quick_block_open.cc":"7=
edb512a287542f83ee448fbcafc3d654b62a36440b6474e9cae3bb5d36577ab","src/zlib=
-ng/test/test_deflate_tune.cc":"dad52ad7941aca761ff177877a0d60f1b68b3a6d28=
a8f4bd382005f3c04bad64","src/zlib-ng/test/test_dict.cc":"2bb6c32ec0ea76561=
172e0b5e8c6a7bf4f64efc2b41534b42ec1d6c3d0990897","src/zlib-ng/test/test_gz=
io.cc":"337f711eb6e80e77fd28963c89a646f6528d635036cd0367c398387e0a72cfde",=
"src/zlib-ng/test/test_inflate_adler32.cc":"0967f8e72388a8232bcc1436196214=
ea1a13dd0fbd5e7633e24a9246abc2a950","src/zlib-ng/test/test_inflate_sync.cc=
":"fbb1121ea5b5448723c6d6d8692110c7362e6833fae22afcd46909d4ecb1289b","src/=
zlib-ng/test/test_large_buffers.cc":"0c76a002071e6280d6e6b380db5e1ada00730=
b0534722ba5c208cb1e51de0b7b","src/zlib-ng/test/test_main.cc":"884dcbfb7207=
f541ef82bc9fe6f657fbe1918b0917fa3e5eda124ad042ce732e","src/zlib-ng/test/te=
st_raw.cc":"0ac0c7c63777d4278a36e087b2060a369be16150d40a6963d3a0d60a7efb17=
40","src/zlib-ng/test/test_shared.h":"cc6a7f3dd115edd5de50da2da266e615464e=
2d5ae41d102e117b09215889a2c4","src/zlib-ng/test/test_shared_ng.h":"4570992=
f5ba61d2cf9e502d3aac163945d5d2f65883ce29f3a0797052c779b91","src/zlib-ng/te=
st/test_small_buffers.cc":"680ba24dc58c7dd05e8dab2e430a8e0c99b946cbc341a5f=
b39c4b4b921b6fb33","src/zlib-ng/test/test_small_window.cc":"0f784eae1977ee=
62d56f6280b269aa9edc42a5f3d20502c39abcb6cf126ec5ea","src/zlib-ng/test/test=
_version.cc":"8599eca8dd63a96962a5c8ac01a3172d203f9065e228867928ed4bce61cf=
6009","src/zlib-ng/tools/config.sub":"32186cfeb5db62c99e1dfbfb07f24c1a5097=
7447b4c26d2907021c74422a70d2","src/zlib-ng/tools/makecrct.c":"73acdb94f73d=
fea474927a9e1be33e0f2cb015d97831bc2718106141adbc1d05","src/zlib-ng/tools/m=
akefixed.c":"bffd02540231304f9bcc755b8cb9ae5cfbc48975857bbb4547f1d6acce21e=
f57","src/zlib-ng/tools/maketrees.c":"48a3e4ee246b1fb061d8e643efbd4b80e45f=
9c3814e21170a5893a9f4ca9619b","src/zlib-ng/trees.c":"310fe64c50fb313773c20=
58c606b1a3cc085b8af7771eba325ad5c9355659100","src/zlib-ng/trees.h":"24174f=
3543b01ee1ef370bbf6d15551a21871cded18b2aadf09a71e7904b6f99","src/zlib-ng/t=
rees_emit.h":"6c541dcf01eecf393d4eab7800bc558ad524114bb5a8deb86f13376fbef8=
8754","src/zlib-ng/trees_tbl.h":"022736ff3362ef3591d1f8fc3b7fede5927c0d25a=
b0813d7ef8cd95efd6ea242","src/zlib-ng/uncompr.c":"bb03a6ae65e1395f3cb2fba1=
dee63246a1fcd30683fd3348e320e789521055a6","src/zlib-ng/win32/Makefile.a64"=
:"f1feaed8da22e6e1470689186db22946ccb67019a87edd34e9ed25b438b626db","src/z=
lib-ng/win32/Makefile.arm":"a952ff273854b6b025760ed6c841c450d298cda462dae3=
163f6d7288ad2cf55f","src/zlib-ng/win32/Makefile.msc":"f299f7987ec266ac35d9=
383f4c7459da02094a10c877a4c471ee2df1ec44caf9","src/zlib-ng/win32/replace.v=
bs":"0ecd6d2f42f4f49d835acbf7b89a79cbdf17fed29d5931eeb3b40da6d3133946","sr=
c/zlib-ng/win32/zlib-ng.def.in":"0b75299a93ef3af54ab37f1282f254ccf2f635fec=
9b2691edc3840d851bbc20a","src/zlib-ng/win32/zlib-ng1.rc":"91f28a6930d6a376=
a1057a73ea5613bc13717028c89fdd0b4c8015059295fcd2","src/zlib-ng/win32/zlib.=
def.in":"ec69c79c2a5612a5c4dc9de08c930c9b251f2455e4bca8781f70c05f7170fb3a"=
,"src/zlib-ng/win32/zlib1.rc":"5644cee99821019a7d541d5587376236cb5b99e98d6=
6c904a25f9b69d1d56062","src/zlib-ng/win32/zlibcompat.def.in":"c4dff5ac2cfe=
629155c7de5b0f139fb1c962fb01addbc032c3cf35110921eb27","src/zlib-ng/zbuild.=
h":"e6f34c26bd82dd7650a664d7b336d1e4c83b871bded79e05602e779ffa69993b","src=
/zlib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e9aa47fa84bb625ed2ac6117284=
f514cacc42a993d","src/zlib-ng/zconf.h.in":"6768f84c439683b4a590338a9be40c3=
bd7a9702b25e8e546c705fac08674c3bc","src/zlib-ng/zendian.h":"5be3e298952419=
8f13b68cc083b1502747effe92325edee59e3c4ad93cc3c62f","src/zlib-ng/zlib-ng.h=
.in":"3bafbff2b78a88c1f0de4195a17b8fcd1fb12fcf2d40ffe1970415f6778bf9df","s=
rc/zlib-ng/zlib-ng.map":"111f656dfdf4da285621a909fecd0532be37f83b49f6e18f3=
57fc8d2a22a726f","src/zlib-ng/zlib.h.in":"9f74dd9f3244ac1152639c5ad5dd1995=
914b7362adb1f3890698da377cf26c3f","src/zlib-ng/zlib.map":"f746610758741f04=
2f8025502b4c0c04f9bcd48864004cc6e502b99d3754d78f","src/zlib-ng/zlib.pc.cma=
kein":"a97486fcab3f191d807ec04d4487d6a428053ab452b59687ee1f71cf52b02a31","=
src/zlib-ng/zlib.pc.in":"848e017a079b14853df8d19699f4edac2304767ef4eb2cf52=
5a06ceb60d301b3","src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579=
afe7ce8c1f8a5473598c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_=
mangling.h.empty":"38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ec=
b1d142058","src/zlib-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b=
12e71245d3b7cb79ed318fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"fce8e83d2=
040be8bc389ec61a8d6c7b32c0b3cd208599c01c5a58ef6418de87b","src/zlib-ng/zuti=
l.h":"618641510d89936fcbca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","s=
rc/zlib-ng/zutil_p.h":"6ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca0=
90adea8eb3f2d","src/zlib/CMakeLists.txt":"ab5f3afca6fe38983dc30a28da487770=
6e3a690a564eda3d4929fff39dab190e","src/zlib/ChangeLog":"f3bc368fd1722570d2=
5411fece6b0e026ab95a9e20ccf39c4395aa41a956a4f0","src/zlib/FAQ":"e18aaaae6d=
7d8acd15c1f439306ef554372bc39db7e19258836708362a0b7cca","src/zlib/INDEX":"=
3b4e325d47ae66456d43fcf143ba21ab67a02a4f81be7ef2da480ba30d774266","src/zli=
b/LICENSE":"845efc77857d485d91fb3e0b884aaa929368c717ae8186b66fe1ed24957532=
43","src/zlib/Makefile":"ef23b08ce01239843f1ded3f373bfc432627a477d62f945cb=
f63b2ac03db118a","src/zlib/Makefile.in":"a6d202a2ac158f8fbd1fa7361e1f2c7ad=
fd1b7b80c1f6515a4203925c2c0f24a","src/zlib/README":"d106dcdb2a0b3087cb3a23=
80b9f00a0bbadc7eb835cd80408f94a2d78d69727d","src/zlib/adler32.c":"9cd1443a=
24ff2a3053961695bd432035c58347386a420d3388232376ebabe211","src/zlib/amiga/=
Makefile.pup":"a65cb3cd40b1b8ec77e288974dd9dc53d91ed78bbe495e94ccc84ddd423=
edf1f","src/zlib/amiga/Makefile.sas":"0e63cf88b505a1a04327bb666af3a985c5e1=
1835c0c00aed4058c0dcc315d60e","src/zlib/compress.c":"86f802c16a965e7a28737=
e3730b4e576c5ba40981753967e3e30916f4dc1b4b1","src/zlib/configure":"f7c0050=
f218691ee1cae28311144a703bfa3515df903d537d6a5cb4bd3dcd8cd","src/zlib/contr=
ib/README.contrib":"b925ae08d371b33c4b5ffd67c707150729a476caf47cfe2eafc002=
291f23f931","src/zlib/contrib/ada/buffer_demo.adb":"469cf566a6965767fee6b9=
87a239ed8cedcc66614940d45a9b434331fbb435ce","src/zlib/contrib/ada/mtest.ad=
b":"41b6f31684770334afdc4375871eb1408542f37a823a073556fdbfdb63753160","src=
/zlib/contrib/ada/read.adb":"fa5b989aef0c5715a3fcb15de93985f7f10aeb0a7f571=
6745c95ed820eb9af9c","src/zlib/contrib/ada/readme.txt":"2cb6c99547bf527648=
342723a2183f503ef64182bc19a506976815725a207438","src/zlib/contrib/ada/test=
.adb":"ad2b2f61e0603044065887849e2cca394cfe37d3ba08d3cd368f670462b9296e","=
src/zlib/contrib/ada/zlib-streams.adb":"f45988e2bac76eb25a0dc981f46576e743=
2c35dde1790bbc2b650f0090b7fa72","src/zlib/contrib/ada/zlib-streams.ads":"2=
dae2309e863a6ea44731773aabac5fd5f5436b6dcfcf53fd7e6389556ca8c3c","src/zlib=
/contrib/ada/zlib-thin.adb":"03d89244ee5ec9771d9b5050e586c609f851af551b2e6=
4eb151f1d5be0b63ae9","src/zlib/contrib/ada/zlib-thin.ads":"631ef170bde16c3=
ca8d412b54a0e519815b80197d208f8f393e6fe017bb0968e","src/zlib/contrib/ada/z=
lib.adb":"8168ac962cd775e1f3dc35dc95a038eb370034c9b1f8cb1511d4bcd6b297a1f5=
","src/zlib/contrib/ada/zlib.ads":"9340f4cfaeafca0efce7a649ef5e9b42a8bcafc=
5dbdc4abff41f9a19ee08c3cc","src/zlib/contrib/ada/zlib.gpr":"859bb69dce38db=
e9dca06753cf7ae7bd16d48f4fece8b87582dab8e30681d3de","src/zlib/contrib/blas=
t/Makefile":"17d5d26c24bf51cad51045a38ffb73cc3539d29e89885aa249fcfd45a8659=
d5c","src/zlib/contrib/blast/README":"baa763ae03d88ef7ece6eb80d9a099b43d0b=
57639d6d281e1c7c6ca79d81daba","src/zlib/contrib/blast/blast.c":"1ab3e479d3=
42bfc144167b808fb00142264bc50f24a110ca88cc774e351c218e","src/zlib/contrib/=
blast/blast.h":"9c1c422b76311d4cb06863ffc056668b6240f3dd998bc02e89ee590d48=
2bfdc2","src/zlib/contrib/blast/test.pk":"5f5c262c545574a5c221132d5ef83247=
8d222d70b015341795b3860204140d7c","src/zlib/contrib/blast/test.txt":"9679b=
2c98e1283222d0782b25a1c198dc64ba9ebd1addd6dc6f643a45947cda3","src/zlib/con=
trib/delphi/ZLib.pas":"0a3ea9e7e6644df99dda9c275f5a7be7cbaa96f8333f0467bd0=
07141496dff17","src/zlib/contrib/delphi/ZLibConst.pas":"84bcc580bdf397e570=
f86f3f5a5b8c7bf537828f30b4b72648b81911f6bf5095","src/zlib/contrib/delphi/r=
eadme.txt":"f7420ed2de77d4b498eefbbe6402a1d17dc2d411735289c78a265c7f10fdae=
e5","src/zlib/contrib/delphi/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0=
f10118cd88bb32c4b7226988776f8d511","src/zlib/contrib/dotzlib/DotZLib.build=
":"b96137097669644ecb9f42cdd3399d1fce9c512788374609303f7e50abf597f0","src/=
zlib/contrib/dotzlib/DotZLib.chm":"20d0e3edd57f849143255a7f0df1cd59d41db46=
4a72c0d5ab42846438a729579","src/zlib/contrib/dotzlib/DotZLib.sln":"a979198=
c5b8d144c1ac8f993bfb6f4085d135aa58ca9dcf63ebabf52b5c695f7","src/zlib/contr=
ib/dotzlib/DotZLib/AssemblyInfo.cs":"314afcfb339ea95f5431047b7ab24631b11c3=
532c7ce5dc2094ed0cf80a7c16d","src/zlib/contrib/dotzlib/DotZLib/ChecksumImp=
l.cs":"871fc7b34a095dde13cf4505800d4edc9f40b033d5e840c597ad8ada599d26ed","=
src/zlib/contrib/dotzlib/DotZLib/CircularBuffer.cs":"be84c9736fe7bdc2bfae7=
0466d8fff582504e928d5b5e110fd758090090c8cb7","src/zlib/contrib/dotzlib/Dot=
ZLib/CodecBase.cs":"b373f1f0c08565bf362c41969881a2f25be449eb894a477659231d=
6d3b86c07a","src/zlib/contrib/dotzlib/DotZLib/Deflater.cs":"06ba6696a3c15c=
53ba5fd5a1c2bf50b51f217010228fc1e4c8495ee578f480de","src/zlib/contrib/dotz=
lib/DotZLib/DotZLib.cs":"9837fe993fd631233cc5e53ff084d86754b97f05ec77c54b0=
764c2706f186134","src/zlib/contrib/dotzlib/DotZLib/DotZLib.csproj":"21606d=
b31dfef6410dd438b73f1db68856eacabcce6c0f0411fc4f17e17001f3","src/zlib/cont=
rib/dotzlib/DotZLib/GZipStream.cs":"7c4e8bf7e0b51f04bd3f457bead842aee13338=
8d18ec8e210295899ad2327cbf","src/zlib/contrib/dotzlib/DotZLib/Inflater.cs"=
:"9016ca73818f5b6a28791abc3af6da7c4d2773b6a3804f593f6d5737a62b99ad","src/z=
lib/contrib/dotzlib/DotZLib/UnitTests.cs":"3f22cb690bd38fa151a944afa5a1844=
499fe30df5b410edfd769b7e2a41ddc94","src/zlib/contrib/dotzlib/LICENSE_1_0.t=
xt":"36266a8fd073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","sr=
c/zlib/contrib/dotzlib/readme.txt":"bdb18e0114d3b5683749cf08cedbdf6b502e5a=
bd344418b858e339839561e66c","src/zlib/contrib/gcc_gvmat64/gvmat64.S":"22ff=
411b8b1d1b04aeaa8418b68245400267dc43c6f44104f6ccd37f0daee89f","src/zlib/co=
ntrib/infback9/README":"890288f02bb3b1f9cc654b87a07fcea695f90f6b9bd672d25b=
f6be1da2ec1688","src/zlib/contrib/infback9/infback9.c":"c236f4e5ef216f5ebc=
66f95ccbf9d399a19ad3838444065308b8d859cb42dc74","src/zlib/contrib/infback9=
/infback9.h":"c89d926607c1afa1830c17f807de368d2f1afe2d1e7df426763f6d4bf595=
0379","src/zlib/contrib/infback9/inffix9.h":"84a2ba4727767c18af6505f0e81d9=
c814489c8b9ed330a25dad433db72997e43","src/zlib/contrib/infback9/inflate9.h=
":"32a907676cc36e27d0fdc0d99adb83a0b23f20ab61896269216d40fecf08d349","src/=
zlib/contrib/infback9/inftree9.c":"9e739f5735d3cd77ca1b0d46d2a43371acf2afd=
64c9c0889e737da369ccd92d0","src/zlib/contrib/infback9/inftree9.h":"4ecd9db=
884bf43e33fbd34273c814029022477e1597676129f9c98e09d8cef56","src/zlib/contr=
ib/iostream/test.cpp":"0f3c77e013949eb9c91e6b690ea894e19d97944d6b0885b8280=
6fc3ad99680cf","src/zlib/contrib/iostream/zfstream.cpp":"8ebb9b3d521cc3392=
953f27658cf1f6dcb763216079f69a1518ec5ca0e42a63b","src/zlib/contrib/iostrea=
m/zfstream.h":"4369c35e66f63f52ca4a5e1759bf720507ccabb8f3f132e2f18e68686c8=
12401","src/zlib/contrib/iostream2/zstream.h":"d0343e0c57ff58008b6f29643d2=
89c72713aa2d653fe3dcd2e939fc77e7e20b6","src/zlib/contrib/iostream2/zstream=
_test.cpp":"f789df183cc58b78751985466380c656308490a9036eb48a7ef79704c3d3f2=
29","src/zlib/contrib/iostream3/README":"43ec48ecbd95a8c45db20b107fac73b74=
0bb11595a4737329188f06b713972cc","src/zlib/contrib/iostream3/TODO":"af5ebc=
83fb88f69706c8af896733784753dead147687e1c046f410c0997fd88b","src/zlib/cont=
rib/iostream3/test.cc":"8e17fc48dfdbc6e268838b8b427491b5843b6d18bc97caa692=
4de9fad7abe3da","src/zlib/contrib/iostream3/zfstream.cc":"8cdd67ed0b13c192=
c11e5ea90e9d5782d6627eb303fbc4aa5ebda2531ec00ff8","src/zlib/contrib/iostre=
am3/zfstream.h":"d89587b446f928351565d099decd006a06b7a420cb1ff8ee9bb82e4d8=
c7235dd","src/zlib/contrib/minizip/Makefile":"b95eb8b05baef661a18ca90fa72f=
43e76f1bc987f9199197fe283e2860060e0a","src/zlib/contrib/minizip/Makefile.a=
m":"2313a3480a2c3745fa7ce216829cd0367058907d3a0902e5832c66c84a2fdfc6","src=
/zlib/contrib/minizip/MiniZip64_Changes.txt":"c371d1672b1ec23c6fe0c600543e=
0c96374400b4d434447ff2596f21255079f1","src/zlib/contrib/minizip/MiniZip64_=
info.txt":"122719c32ef1763a5f6ba9c8cdefc1d78a76f7156b09e7b6f69b73f968e0dac=
3","src/zlib/contrib/minizip/configure.ac":"99a48f7b786cf192a778aae2af3083=
6b0d2aaaec6e84c3a89a2edcbe77b46e1a","src/zlib/contrib/minizip/crypt.h":"5c=
978923cff1e80f76baf437eed699d5b4ad1bf515008d669475d3dd0d89ef70","src/zlib/=
contrib/minizip/ioapi.c":"6dff11ded396f5e3147c632a639423e80ced6705bf7bf75d=
21cda0c571fdf86b","src/zlib/contrib/minizip/ioapi.h":"6d2f2c3520dfc3061ea9=
128a1afb843f5cfe8d7317adcefe3a45884bc06e06a1","src/zlib/contrib/minizip/io=
win32.c":"882383d1ee9df8c5f236411734b51e96f5e29c38496d4e531f2beb3d07f682ef=
","src/zlib/contrib/minizip/iowin32.h":"4feed64c3c5f5cff2d8a0431233766b61d=
4e06a9f232482cb41272ed1ca487df","src/zlib/contrib/minizip/make_vms.com":"6=
5736d9c4888f2373d3db0a13864d150c5040453f5bc2a5c8784379a7ea67590","src/zlib=
/contrib/minizip/miniunz.c":"c60f2c68be981464ff02dfbe01da2a8e66692416bdda2=
144fc75df3420b4107f","src/zlib/contrib/minizip/miniunzip.1":"66d8684392167=
091ef0fe01598d6a0daa26e7e448e2df6c3cb257487735b83f7","src/zlib/contrib/min=
izip/minizip.1":"5404596e8e5587a52f563906119f32ceee30a6d97a966afa5c7afbe4d=
373e210","src/zlib/contrib/minizip/minizip.c":"6d7d7daffc713ba15a976814347=
1902c5bfd661a19287172f3870bc9ed2d5665","src/zlib/contrib/minizip/minizip.p=
c.in":"8b6670b42d8e5e519e1cc89db093efc07ba23cb1ddfedd3c93ff2df08c3ce8ac","=
src/zlib/contrib/minizip/mztools.c":"3d6027270a2b6ed5ca19a339d7488f682c697=
98e3977d2278d379b7f14f17b63","src/zlib/contrib/minizip/mztools.h":"6f82c52=
279e8f79165f4446be652e5741a49992ac58632470335aa34c564072a","src/zlib/contr=
ib/minizip/unzip.c":"10881ab576f49fe0825a21f77e322ece6ee88d34ed66fb3a3ce7a=
22f4b6cd2d9","src/zlib/contrib/minizip/unzip.h":"2ff9df0b1da7499adc806bc0e=
c098ef1c7b9d361a8fd5b08a98299a1a4e88399","src/zlib/contrib/minizip/zip.c":=
"213f853d71266ebe8d8335740cfe94b0731009d8fb3f7e6ae01a627398732ec8","src/zl=
ib/contrib/minizip/zip.h":"99ad45c0b546b5fd0ee3d0819ff057840a892a3d6dbacc8=
5b757a35a43047398","src/zlib/contrib/nuget/nuget.csproj":"a6cf81c9a9b8be66=
fae032193ac6282a4ceae93c8a25a9245d7eaf477d532471","src/zlib/contrib/nuget/=
nuget.sln":"074a80c6c3898ea4f7935734d81fe81d3c15f5dae5b17806fa7a036b69ad5c=
33","src/zlib/contrib/pascal/example.pas":"d842d456ecb6ff80e34cee2da31deb2=
072cc69ca837497bea8b8bee203403474","src/zlib/contrib/pascal/readme.txt":"0=
2f997c37991ddae0cb986039f7b4f6fc816b3fd0ffd332cad371d04c12cf1b9","src/zlib=
/contrib/pascal/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0f10118cd88bb3=
2c4b7226988776f8d511","src/zlib/contrib/pascal/zlibpas.pas":"c5559b148a9dc=
dd32843e6920b4d2a2b030f7d32979dfd253aeaa9a4ed31770f","src/zlib/contrib/puf=
f/Makefile":"d9d738030464aaae354196c14fd928adf591832fce7d71ac1977c1d8d4923=
a4b","src/zlib/contrib/puff/README":"c5b9852fb11e0d6b6e916e5134cf034524d90=
1b95368972133e0381e480eb479","src/zlib/contrib/puff/puff.c":"5b9d75aeb5baf=
3575415bc6ade3f2a02e50b6b971b3f8b4fda2b03543bc6e52f","src/zlib/contrib/puf=
f/puff.h":"969b7be2a930db0cdcb19b0e5b29ae6741f5a8f663b6dba6d647e12ec60cfa8=
e","src/zlib/contrib/puff/pufftest.c":"d24e31c1d277d07c268f34e9490050c6b53=
c68b128da3efbb1d05fc5b31004f7","src/zlib/contrib/puff/zeros.raw":"b7b08870=
89f7af1f6d1e0b4c0a1e8eddd10223b23554299455c6c9be71b653a3","src/zlib/contri=
b/testzlib/testzlib.c":"753dbb39c5d2f0fffac0406c1c94fd1da7b0251d679e4d137b=
0708901dfd61d8","src/zlib/contrib/testzlib/testzlib.txt":"2359bbdc84eb8a04=
e0f1cd16cd81a2896e957f2ad58dab3ca78ef55b7d0dc577","src/zlib/contrib/untgz/=
Makefile":"8f5ab1564813e091cea8f1bb63da32fd80ac763d029277b0cabf50f60aceefe=
1","src/zlib/contrib/untgz/Makefile.msc":"d0f537de11d9e0e36e2a98b3971c5372=
65f4b533b4c48797094365ad9ae8388b","src/zlib/contrib/untgz/untgz.c":"f96c1e=
8529eb10d723b4547aa965741d72a46f2b1d5c9a2c193bd3f5e2c2a45e","src/zlib/cont=
rib/vstudio/readme.txt":"ee95a52d9d2a16aceb070a54dd2c45a1f861178351baf8ea0=
3c2f80328691974","src/zlib/contrib/vstudio/vc10/miniunz.vcxproj":"dd607d43=
c64581172c20c22112821924dfe862f56b2e5eb8780bdd0714d9527b","src/zlib/contri=
b/vstudio/vc10/miniunz.vcxproj.filters":"4b8466bf00c70b81c31cc903e756e0415=
1fd90fdcbe102f3568a2c8b6190ea27","src/zlib/contrib/vstudio/vc10/minizip.vc=
xproj":"af73f2cf8ae51e65e85342faeb40849a2310c97bc77def42b38d7070460a6cf0",=
"src/zlib/contrib/vstudio/vc10/minizip.vcxproj.filters":"f2815f9e3386c393d=
0a351632823b221ef9689da1f422ecaa561dba2a612fb0a","src/zlib/contrib/vstudio=
/vc10/testzlib.vcxproj":"c21e64259bf9efe97e1103212e7a6e1b7372b50067b4ba14c=
fa678e1f491095f","src/zlib/contrib/vstudio/vc10/testzlib.vcxproj.filters":=
"a7caddbac3ba90b5d482e6d926ef35cc40dc3553ed3776ef6b68a528fd5b0631","src/zl=
ib/contrib/vstudio/vc10/testzlibdll.vcxproj":"3f317d8964f17901c3e68bff5dea=
ec10b6ccc50a572235999e8097292692984c","src/zlib/contrib/vstudio/vc10/testz=
libdll.vcxproj.filters":"29c9535775aa76320ee4efd001d41961faf6c58cedd8b29d3=
986e85f73d2f6fb","src/zlib/contrib/vstudio/vc10/zlib.rc":"7aa6cfd50ac67821=
504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/zlib/contrib/vstudi=
o/vc10/zlibstat.vcxproj":"50402ab8c63f746c034d6ce51d9612aff5b6af9aa27790cf=
fa4b7deed4b30eb8","src/zlib/contrib/vstudio/vc10/zlibstat.vcxproj.filters"=
:"eeb1de64c252c46b822f73f272127f6f9f0570ef22d234e093070ba95a4dde24","src/z=
lib/contrib/vstudio/vc10/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf32283d=
f77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc10/zlibvc.sln":"=
e659860f705f31b87ea9139a3cb4ebe1561e120bce495383a54614fc82b49990","src/zli=
b/contrib/vstudio/vc10/zlibvc.vcxproj":"efad8cb150c0e5122f8c700d95c5de659d=
ff92b171917c66bdbd082fff500b58","src/zlib/contrib/vstudio/vc10/zlibvc.vcxp=
roj.filters":"c801732b7c7017796add50d2b71a228f99f95a46650baad307ff7e8358a2=
bfb0","src/zlib/contrib/vstudio/vc11/miniunz.vcxproj":"746e4c11fb8af4bcd6a=
9d68ba81ed1dc366a5de3bed56b291ee969ad733a7bb0","src/zlib/contrib/vstudio/v=
c11/minizip.vcxproj":"340617cae9cf4fcb003308021d3782ec3639e60d62d79a3aafc0=
a50bb55b061e","src/zlib/contrib/vstudio/vc11/testzlib.vcxproj":"99eadfdf2e=
41bc036141c174c4d0035d87572ce5795dcc28f39133f818a79d08","src/zlib/contrib/=
vstudio/vc11/testzlibdll.vcxproj":"583bdef522b0176829f0d8139ea2a88b9cbc143=
79d1334f3a863989ed3df9b67","src/zlib/contrib/vstudio/vc11/zlib.rc":"7aa6cf=
d50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/zlib/cont=
rib/vstudio/vc11/zlibstat.vcxproj":"b07f792843d05ac883391075bc3b9625437490=
d8d40944ad359aa2134a09a3aa","src/zlib/contrib/vstudio/vc11/zlibvc.def":"40=
c8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/=
contrib/vstudio/vc11/zlibvc.sln":"27389b515997defd080519f95aff87e89fcbe8b2=
6d73c5ebb73c544cfef4d60e","src/zlib/contrib/vstudio/vc11/zlibvc.vcxproj":"=
d02d014ef957119a6fd0ab243c892b74d1592b117750b95fed21097c8ed922d9","src/zli=
b/contrib/vstudio/vc12/miniunz.vcxproj":"1494af54570f6e93852932956d49a8c25=
e57b5abc1ac979945605ca9143df9f8","src/zlib/contrib/vstudio/vc12/minizip.vc=
xproj":"9bf128ed6760ca5f019006f178b1c65f4c7ff122dba8d297b64b0eb72feeb120",=
"src/zlib/contrib/vstudio/vc12/testzlib.vcxproj":"be88bc1220c0447c2379fdab=
3ac88055f58a8a788d3e9cec494342187e760eaf","src/zlib/contrib/vstudio/vc12/t=
estzlibdll.vcxproj":"93416510256935d79625dc9fd349cfce6968c062d42a138bec404=
a26b2f92f5e","src/zlib/contrib/vstudio/vc12/zlib.rc":"c0e44b6f99079b298e0a=
11f013e7b1476402a49f19e4d892467abb4aa116f2c8","src/zlib/contrib/vstudio/vc=
12/zlibstat.vcxproj":"faa229a851c76b77d65bb4742d8369efe566652bb6a1447d1e35=
39f289b5313d","src/zlib/contrib/vstudio/vc12/zlibvc.def":"40c8e74194874b8c=
1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudi=
o/vc12/zlibvc.sln":"162e0faa80a56d89eea71a0b89377708eec2faa0dc72091cc0abb0=
7fbdea49a0","src/zlib/contrib/vstudio/vc12/zlibvc.vcxproj":"8ac8cb2d29b880=
a738011d29d0511af9b14f321bed90f674109c446f4108d442","src/zlib/contrib/vstu=
dio/vc14/miniunz.vcxproj":"0312511d4a30cea979c4e36edf994a537ed8a9d924f6b5c=
536cbcd094773c11f","src/zlib/contrib/vstudio/vc14/minizip.vcxproj":"9e7bb7=
a6ac723e4b2db900627c366f9bb93a351381995d9c69a50c0126f64233","src/zlib/cont=
rib/vstudio/vc14/testzlib.vcxproj":"88667873d9d61d65016b9501ca925532eb55f5=
6230e5911d3e2a01cd8a9fb2a4","src/zlib/contrib/vstudio/vc14/testzlibdll.vcx=
proj":"69f544898b4275cd3d8e19b8f1f8cb39c1cb98a30cdb033242e4b94c57bfa150","=
src/zlib/contrib/vstudio/vc14/zlib.rc":"c0e44b6f99079b298e0a11f013e7b14764=
02a49f19e4d892467abb4aa116f2c8","src/zlib/contrib/vstudio/vc14/zlibstat.vc=
xproj":"5629eb0cc30674a39aa3636f1cdd190393b0dbd4c69a35e36ad85b6340055605",=
"src/zlib/contrib/vstudio/vc14/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf=
32283df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc14/zlibvc.=
sln":"47a50bbde8ca6336cecd8c0e4b65e515fc46ae84c7b61008ac9864162f777286","s=
rc/zlib/contrib/vstudio/vc14/zlibvc.vcxproj":"09f496a2ad3afdd5e3f36b728544=
0369dcac4559656edc00ed7a74c7ec9fa10f","src/zlib/contrib/vstudio/vc17/miniu=
nz.vcxproj":"aa70a28fb573e98c0ef68ead2b875765de180e4c6f46c6135806244257fd9=
18f","src/zlib/contrib/vstudio/vc17/minizip.vcxproj":"43ab4593b3ea568dc9e6=
f78a46cbb011850349e9cf3337cfb91dfdc3e623b414","src/zlib/contrib/vstudio/vc=
17/testzlib.vcxproj":"e596d1170c68c6c7912070293e74b794f6753afb1a6d42177dc3=
626fe1b0e0d4","src/zlib/contrib/vstudio/vc17/testzlibdll.vcxproj":"c61f1f6=
e7e0625f283ac4f4e3ca76f25773ada0da43c7c72ce003637f9892c3b","src/zlib/contr=
ib/vstudio/vc17/zlib.rc":"c0e44b6f99079b298e0a11f013e7b1476402a49f19e4d892=
467abb4aa116f2c8","src/zlib/contrib/vstudio/vc17/zlibstat.vcxproj":"331eff=
bbcf295912daff00fb3594c2ee300824733897efc5df7d31b2d379a222","src/zlib/cont=
rib/vstudio/vc17/zlibvc.def":"1fa9a4d1624675b0181554ddd841d368a9cf39fe931b=
80737bfa21402f27a7d8","src/zlib/contrib/vstudio/vc17/zlibvc.sln":"36da58a5=
377e65f446c95c7e4c04a915caac9873b94d0dab231e9862391bba78","src/zlib/contri=
b/vstudio/vc17/zlibvc.vcxproj":"f3222e055d4001f9ee04265a72b8f349f92bd27189=
ce51852c96dde58539c335","src/zlib/contrib/vstudio/vc9/miniunz.vcproj":"7db=
9b2ef5ff05d3de4ba633feab10e85d45434c865d520ffa1974421904996f3","src/zlib/c=
ontrib/vstudio/vc9/minizip.vcproj":"7797a9ad3c0056f3a3cf8fcde7618acd1d151c=
65d15f841fccd8d9d878ae7bb0","src/zlib/contrib/vstudio/vc9/testzlib.vcproj"=
:"8df405917800adccee6bad2116022c2c82d661b37ea40ea16405fe4dbcb4b69f","src/z=
lib/contrib/vstudio/vc9/testzlibdll.vcproj":"cde6806f5c81d1fc311f9921c17ba=
56f8e386d097783a6a90875d385837c47e7","src/zlib/contrib/vstudio/vc9/zlib.rc=
":"7aa6cfd50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/=
zlib/contrib/vstudio/vc9/zlibstat.vcproj":"d393d418d827ad9fb9c6516f1a76203=
71d15e3f5afef8ba60b51e50acc7199e9","src/zlib/contrib/vstudio/vc9/zlibvc.de=
f":"40c8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src=
/zlib/contrib/vstudio/vc9/zlibvc.sln":"26e58d4b2cfcd941c367fb2a18537b3b9f0=
02f2ac1278b700ea1129c50501452","src/zlib/contrib/vstudio/vc9/zlibvc.vcproj=
":"eaca98fcf166738b59fcdbd179dac9f98f985c6ba49212b186343a998816f081","src/=
zlib/crc32.c":"8fd16f0a7714d51c89c2eb37eb98ec15e8a4dc57ba343e7b7398b191440=
39fda","src/zlib/crc32.h":"9a2223575183ac2ee8a247f20bf3ac066e8bd0140369556=
bdbdffc777435749e","src/zlib/deflate.c":"3b956337350f94c34987750f785587ef3=
3d9c89ceaebb7c2afb189c956360cbe","src/zlib/deflate.h":"48baf016326d8d5e3e3=
2ac8153cc7e22f854b8e6834830b167b998a7fb1e7989","src/zlib/doc/algorithm.txt=
":"a2581ab546bf053e3e95d191a6accc3b06bbd4f08ad2fb888eacbfb9773c1d30","src/=
zlib/doc/crc-doc.1.0.pdf":"064f9252d6e2e15ea56c2bd18e160e5c9c84bcd137c11a7=
af497aaa511ace998","src/zlib/doc/rfc1950.txt":"8f0475a5c984657bf26277f73df=
9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib/doc/rfc1951.txt":"5ebf4b5=
b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f301350009","src/zlib/doc/r=
fc1952.txt":"164ef0897b4cbec63abf1b57f069f3599bd0fb7c72c2a4dee21bd7e03ec9a=
f67","src/zlib/doc/txtvsbin.txt":"d1549fb75137f03102798f70fd34ff76285e717d=
dd520dd82274c1c0510eacf0","src/zlib/examples/README.examples":"1bc1c677bbe=
be1aa5e85015bb62f0cf3fcdbf95652d30494159bee6166c1854a","src/zlib/examples/=
enough.c":"c14a257c60bbe0d65bb54746dd97774a1853ef9e3f78db118a27d8bc0d26d73=
8","src/zlib/examples/fitblk.c":"bec64da6fc0c9a2a37a96722e8b88ca09059148e5=
be5ecbb486bdba5339e228a","src/zlib/examples/gun.c":"3bfd36b06284ba97d6105b=
8a6a5d18b2b34b75b3a1285f16d018680fb174915f","src/zlib/examples/gzappend.c"=
:"6de91c8305e37560117bff44136abff72b16b028c0bda0bbac7ea07e4988b0ce","src/z=
lib/examples/gzjoin.c":"90b9d6c39a5fc91cf1cc9b96b025a508a8015dc502cd9374c7=
54b44078593f57","src/zlib/examples/gzlog.c":"d9a2f9871e7f1724f9f9359fd4851=
dc0eac7af10d8234bab66327badb33d1a38","src/zlib/examples/gzlog.h":"681f2804=
37f867820bf39880e2f4fc641d402879e399ba2e6a31d73feefe8edc","src/zlib/exampl=
es/gznorm.c":"e5a8f5c3b107f27212f7d5fbfcf072a337a1b4ea32929ae31c168997438a=
5cc0","src/zlib/examples/zlib_how.html":"bada2526c34e9da7c9682a7216c0b0d7a=
c26f49195f98d3ef56f14ae9b438177","src/zlib/examples/zpipe.c":"68140a82582e=
de938159630bca0fb13a93b4bf1cb2e85b08943c26242cf8f3a6","src/zlib/examples/z=
ran.c":"f4bc94b710841b8412aee04c42ea522bd1687343d65f0c0d92b4dd5801d03956",=
"src/zlib/examples/zran.h":"913158e13f6177224074cfa9b497438545054ac0d54ab1=
3a6ad4182df8d2ee99","src/zlib/gzclose.c":"35ea6e991a63095f797d8c4cc25817fa=
c7a7155c2ba7dcdbbf648f7871c7ea40","src/zlib/gzguts.h":"231ce0588532fd17249=
c4d40fde1b923c3fe4e6b372b4817c931256df1dbcdf7","src/zlib/gzlib.c":"042c2be=
8ec67ad525a2812e508de7381c6766dde903acf5ae6ac4fa6b541946d","src/zlib/gzrea=
d.c":"72e481aca07b0b85a9783237b85dc67ff3a4c1d19878d0cec69f58d38634867b","s=
rc/zlib/gzwrite.c":"469b1e58932ea11bdda2a153f6655f7b3c13254240fae157181b49=
ed1bc93b47","src/zlib/infback.c":"62df9a6dd3eef126f1d81d0ad7a534504610dec4=
4482b0a472b61c93cbab6554","src/zlib/inffast.c":"e6ef64ce5dc0a4cd5c7ad08cee=
b2b2a698b8447f6bd156057caeb2edab68c0cb","src/zlib/inffast.h":"05cc5dc9ff1d=
a7b8b52a4bd8bda0d8a5c236a2f39efe84b941516ea13857e6c5","src/zlib/inffixed.h=
":"237ba710f090e432b62ebf963bee8b302867e9691406b2d3f8ee89ee7bfef9b0","src/=
zlib/inflate.c":"34c998ce0037c0537c04b03b276f680b945f9b2c9d1e01b287605bd68=
79f7fd2","src/zlib/inflate.h":"e8d4a51b07694bf48cb91979c19974cf6a5ab0b8a09=
d26ec0d14df349230673e","src/zlib/inftrees.c":"5d4f335221d2dc76f17abd2577d9=
2c2d7baf68fa6d7f23373b360830493d1563","src/zlib/inftrees.h":"0a0fcaf2ae2fa=
e57426bdc06637270e9bba974f35202cadbdba479d946e6409d","src/zlib/make_vms.co=
m":"14ed54bdd391c1648cedfb69d8a73a26dcc7f1187d59b0f18d944b7665cec85b","src=
/zlib/msdos/Makefile.bor":"292ab363f7ffbc4ae84d37cd9bdffd2dac1003bee52d223=
a8489844870f20702","src/zlib/msdos/Makefile.dj2":"9208450c2ae6dcbfcc25560b=
5b9ca763f461e7246e37b0552474edf8fa898906","src/zlib/msdos/Makefile.emx":"c=
749d6ec7f88e8e639d4f03bdbdcbbe9d1c304210be4c4be621ceb22961d3d64","src/zlib=
/msdos/Makefile.msc":"0e021a6f42212415b060e4ad468eb415d0a8c1f343137fb9dff2=
cb8f9ead3027","src/zlib/msdos/Makefile.tc":"2ae12ee2a3e62f7c5a0520d0fbe4ad=
ee772bc07fe816002b07ccb43db3daa76a","src/zlib/nintendods/Makefile":"ea5823=
efe6830132294eddf2f56dbd7db8712244c210bb4968c431b1a91bd066","src/zlib/nint=
endods/README":"e362426c47b39ff6a7d6c75c6660b20abf076cdfa5e1e421716dc629a7=
1aef95","src/zlib/old/Makefile.emx":"d811f032272aae50123a889297af3a02fbd60=
d1e42bbef11466462f627ff7b5b","src/zlib/old/Makefile.riscos":"d1a488b160fbf=
d53272b68a913283a4be08ba9d490796b196dddb2ba535b41e0","src/zlib/old/README"=
:"551a0f4d91fe0f827a31cbdfbb4a71d1f3dc4d06564d80a3f526b749dd104d11","src/z=
lib/old/descrip.mms":"8ff08c35c056df9c986f23c09cf8936db63ccf12c3c42f7d18a4=
8b36f060cff7","src/zlib/old/os2/Makefile.os2":"6ad247c00f00ff42fd2d62555e8=
6251cef06e4079378241b5f320c227507d51d","src/zlib/old/os2/zlib.def":"ea9c61=
876d2e20b67ef2d9495991a32798eb40d13ede95859a2f4f03b65b9b61","src/zlib/old/=
visual-basic.txt":"04f39c86a8894561498430ca169e9d6ca2c5cc99b43ee9230818840=
65a0b2b1f","src/zlib/os400/README400":"96580d63002088615c4b5ea865cdbec234f=
ef0c8471667d2dc66273398123743","src/zlib/os400/bndsrc":"3c36a17975eed5a8d3=
3bc5443b39fead1e68c01393496be9c1f4a61444bcb0f6","src/zlib/os400/make.sh":"=
143394d1e3876c61c29078c0e47310e726e1f5bd42739fe92df9ece65711655f","src/zli=
b/os400/zlib.inc":"c01ddd22689c281066f2bd2e3a020fad4cd50c1e543f17fae963da8=
9a0d69a29","src/zlib/qnx/package.qpg":"6c499168c561fc08e2fc41b07fc7a43882a=
52ede30c1599ed9f6a4035e764225","src/zlib/test/example.c":"b7aeca68f7585e29=
ca6572542e0ecbd9c3c9370035ae15152008b3efbd4f84ac","src/zlib/test/infcover.=
c":"13a0d18d8bca440c4617d88c2236913f53eedebc50e469be472edd4280c697e5","src=
/zlib/test/minigzip.c":"57e4a1b9bb1bdb59ac9e5ac1dc9132183e8740cec2f6b5c5f2=
476aac08a2375f","src/zlib/treebuild.xml":"7d1cb70609017f6f22079af7569c8d8b=
e2ae51e9524fc173719a487181d60860","src/zlib/trees.c":"f63c68c16c05fcd19605=
0529d1a0e7657960e4136b9987d90a6ac3e58a964b0f","src/zlib/trees.h":"bb0a9d3c=
a88ee00c81adb7c636e73b97085f6ef1b52d6d58edbe2b6dc3adeb4d","src/zlib/uncomp=
r.c":"04dca5e31b3b8a17d1806426f66f0c539f4184d657e149d40be07070c6227b52","s=
rc/zlib/watcom/watcom_f.mak":"7e039b912f9cffaa40835281430bb284fa9042b0a0d1=
2f6b34700a06bca6576e","src/zlib/watcom/watcom_l.mak":"d11b4064604a03472586=
0e63e3f6d347056372e4b1675b183e20a93533b20cc9","src/zlib/win32/DLL_FAQ.txt"=
:"539adcdcea4dcab44d0e788febd217a6f192bc0758dc7813cd5f5d8474d9b428","src/z=
lib/win32/Makefile.bor":"7d73a0d2c3e38b7c610bbc9c22f683a4fe1ab9b8b65649a3a=
8ac4ff7fcc14ba6","src/zlib/win32/Makefile.gcc":"97140c30506a8f6b2edb6b3d8a=
1b6b539d7929d4b957deba9950301090f579bf","src/zlib/win32/Makefile.msc":"235=
529bd529d4690d5d4b7871fdd0a1f118f2fe18862cbdec5f5ac674c55a60d","src/zlib/w=
in32/README-WIN32.txt":"508bee0ef1a34892281517919970eb337e017503671d0fa0f1=
39523b44b4d0eb","src/zlib/win32/VisualC.txt":"9ec0babd46eaa012371dee2d3a8a=
55d9c7130f7895512c3371c737e4a7f6a997","src/zlib/win32/zlib.def":"c00693a5c=
825f8bfbdb68124fd03cb2fa5269338071147bdaa14434aaf3962b9","src/zlib/win32/z=
lib1.rc":"54e161029b59e99a4f9cb2281b956f00ecfb1814318ddef9c741ff4f832c5c1d=
","src/zlib/zconf.h":"f5134250a67d57459234b63858f0d9d3ef8dcc48e9e1028d3f4f=
dcf6eae677ae","src/zlib/zconf.h.cmakein":"350fb02462487a3e8612c18ad2790539=
96ce0c85ebfece25a959baea9db86562","src/zlib/zconf.h.in":"f5134250a67d57459=
234b63858f0d9d3ef8dcc48e9e1028d3f4fdcf6eae677ae","src/zlib/zlib.3":"5aadb3=
f129c4c7e29f28bb6c5954dea061df3046d0fe3e134aff2ef4a217b1d6","src/zlib/zlib=
.3.pdf":"434e8d80e43ed24ed58a7dad0867a1136035864ad3e5fd4cc2c69e0715628c66"=
,"src/zlib/zlib.h":"8a5579af72ea4f427ff00a4150f0ccb3fc5c1e4379f726e101133b=
1ab9fc600c","src/zlib/zlib.map":"e83d883a3f7bb93b3dcfab28f5300a569bc7586de=
d2e067c0639d0697d13fe1e","src/zlib/zlib.pc.cmakein":"2f1d0b18ce37c2af415a4=
69857f02aee2c41a58877aff21d29e9c6db32b55cb7","src/zlib/zlib.pc.in":"04c01c=
c2e1a0ed123518b5855f585c93a24526dd88982c414111ea1fc9f07997","src/zlib/zuti=
l.c":"8ced40d8c88588811edd2bdb35b7439983d5e1f8e9e32b8a3b244731f3c317b7","s=
rc/zlib/zutil.h":"dddb2dc7a1dc339ecf2c8e089b366f08bb731c0839c7110240d17ce7=
31bb4fea"},"package":"5e143b5e666b2695d28f6bca6497720813f699c9602dd7f5cac9=
1008b8ada7f9"}
diff --git a/recipes-devtools/rust/libstd-rs_1.78.0.bb =
b/recipes-devtools/rust/libstd-rs_1.78.0.bb
new file mode 100644
index 0000000..fe016e7
--- /dev/null
+++ b/recipes-devtools/rust/libstd-rs_1.78.0.bb
@@ -0,0 +1,55 @@
+SUMMARY =3D "Rust standard libaries"
+HOMEPAGE =3D "http://www.rust-lang.org"
+SECTION =3D "devel"
+LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
+LIC_FILES_CHKSUM =3D =
"file://../../COPYRIGHT;md5=3Dc2cccf560306876da3913d79062a54b9"
+
+require rust-source.inc
+
+# The dummy crate named `sysroot` represents the standard library =
target.
+#
+# See fd4c81f4c19e ("Add a `sysroot` crate to represent the standard =
library crates")
+# https://github.com/rust-lang/rust/pull/108865/
+S =3D "${RUSTSRC}/library/sysroot"
+
+RUSTLIB_DEP =3D ""
+inherit cargo
+
+CVE_PRODUCT =3D "rust"
+
+DEPENDS:append:libc-musl =3D " libunwind"
+# rv32 does not have libunwind ported yet
+DEPENDS:remove:riscv32 =3D "libunwind"
+DEPENDS:remove:riscv64 =3D "libunwind"
+
+# Embed bitcode in order to allow compiling both with and without LTO
+RUSTFLAGS +=3D "-Cembed-bitcode=3Dyes"
+# Needed so cargo can find libbacktrace
+RUSTFLAGS +=3D "-L ${STAGING_LIBDIR} -C link-arg=3D-Wl,-soname,libstd.so"=

+
+CARGO_FEATURES ?=3D "panic-unwind backtrace"
+CARGO_BUILD_FLAGS +=3D "--features '${CARGO_FEATURES}'"
+CARGO_VENDORING_DIRECTORY =3D "${RUSTSRC}/vendor"
+
+do_compile:prepend () {
+    export CARGO_TARGET_DIR=3D"${B}"
+    # For Rust 1.13.0 and newer
+    export RUSTC_BOOTSTRAP=3D"1"
+}
+
+do_install () {
+    mkdir -p ${D}${rustlibdir}
+
+    # With the incremental build support added in 1.24, the libstd deps =
directory also includes dependency
+    # files that get installed. Those are really only needed to =
incrementally rebuild the libstd library
+    # itself and don't need to be installed.
+    rm -f ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
+    cp ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
+}
+
+BBCLASSEXTEND =3D "nativesdk"
+
+# Since 1.70.0 upgrade this fails to build with gold:
+# http://errors.yoctoproject.org/Errors/Details/708194/
+# ld: error: version script assignment of  to symbol =
__rust_alloc_error_handler_should_panic failed: symbol not defined
+LDFLAGS:append =3D "${@bb.utils.contains('DISTRO_FEATURES', =
'ld-is-gold', ' -fuse-ld=3Dbfd', '', d)}"
diff --git a/recipes-devtools/rust/libstd-rs_1.80.0.bb =
b/recipes-devtools/rust/libstd-rs_1.80.0.bb
new file mode 100644
index 0000000..1416171
--- /dev/null
+++ b/recipes-devtools/rust/libstd-rs_1.80.0.bb
@@ -0,0 +1,55 @@
+SUMMARY =3D "Rust standard libaries"
+HOMEPAGE =3D "http://www.rust-lang.org"
+SECTION =3D "devel"
+LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
+LIC_FILES_CHKSUM =3D =
"file://../../COPYRIGHT;md5=3Dc2cccf560306876da3913d79062a54b9"
+
+require rust-source.inc
+
+# The dummy crate named `sysroot` represents the standard library =
target.
+#
+# See fd4c81f4c19e ("Add a `sysroot` crate to represent the standard =
library crates")
+# https://github.com/rust-lang/rust/pull/108865/
+S =3D "${RUSTSRC}/library/sysroot"
+
+RUSTLIB_DEP =3D ""
+inherit cargo
+
+CVE_PRODUCT =3D "rust"
+
+DEPENDS:append:libc-musl =3D " libunwind"
+# rv32 does not have libunwind ported yet
+DEPENDS:remove:riscv32 =3D "libunwind"
+DEPENDS:remove:riscv64 =3D "libunwind"
+
+# Embed bitcode in order to allow compiling both with and without LTO
+RUSTFLAGS +=3D "-Cembed-bitcode=3Dyes"
+# Needed so cargo can find libbacktrace
+RUSTFLAGS +=3D "-L ${STAGING_LIBDIR} -C link-arg=3D-Wl,-soname,libstd.so"=

+
+CARGO_FEATURES ?=3D "panic-unwind backtrace"
+CARGO_BUILD_FLAGS +=3D "--features '${CARGO_FEATURES}'"
+CARGO_VENDORING_DIRECTORY =3D "${RUSTSRC}/vendor"
+
+do_compile:prepend () {
+    export CARGO_TARGET_DIR=3D"${B}"
+    # For Rust 1.13.0 and newer
+    export RUSTC_BOOTSTRAP=3D"1"
+}
+
+do_install () {
+    mkdir -p ${D}${rustlibdir}
+
+    # With the incremental build support added in 1.24, the libstd deps =
directory also includes dependency
+    # files that get installed. Those are really only needed to =
incrementally rebuild the libstd library
+    # itself and don't need to be installed.
+    rm -f ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
+    cp ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
+}
+
+BBCLASSEXTEND =3D "nativesdk"
+
+# Since 1.70.0 upgrade this fails to build with gold:
+# http://errors.yoctoproject.org/Errors/Details/708194/
+# ld: error: version script assignment of  to symbol =
__rust_alloc_error_handler_should_panic failed: symbol not defined
+LDFLAGS +=3D "${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', =
'-fuse-ld=3Dbfd', '', d)}"
diff --git a/recipes-devtools/rust/rust-cross-canadian.inc =
b/recipes-devtools/rust/rust-cross-canadian.inc
new file mode 100644
index 0000000..98b40bf
--- /dev/null
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -0,0 +1,92 @@
+SUMMARY =3D "Rust compiler and runtime libaries (cross-canadian for =
${TARGET_ARCH} target)"
+PN =3D "rust-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+CVE_PRODUCT =3D "rust"
+
+inherit rust-target-config
+inherit rust-common
+
+LICENSE =3D "MIT"
+
+MODIFYTOS =3D "0"
+
+DEPENDS +=3D "virtual/${SDK_PREFIX}gcc virtual/nativesdk-libc =
virtual/nativesdk-${SDK_PREFIX}compilerlibs"
+
+SRC_URI +=3D "file://target-rust-ccld.c"
+LIC_FILES_CHKSUM =3D =
"file://target-rust-ccld.c;md5=3Daf4e0e29f81a34cffe05aa07c89e93e9;endline=3D=
7"
+S =3D "${WORKDIR}/sources"
+
+# Need to use our SDK's sh here, see #14878
+create_sdk_wrapper () {
+        file=3D"$1"
+        shift
+        cat <<- EOF > "${file}"
+		#!/bin/sh
+		\$$1 \$@
+		EOF
+
+        chmod +x "$file"
+}
+
+do_install () {
+    # Rust requires /usr/lib to contain the libs.
+    # The required structure is retained for simplicity.
+    SYS_LIBDIR=3D$(dirname ${D}${libdir})
+    SYS_BINDIR=3D$(dirname ${D}${bindir})
+    RUSTLIB_DIR=3D${SYS_LIBDIR}/${TARGET_SYS}/rustlib
+
+    install -d ${RUSTLIB_DIR}
+    install -m 0644 "${RUST_TARGETS_DIR}/${RUST_HOST_SYS}.json" =
"${RUSTLIB_DIR}"
+    install -m 0644 "${RUST_TARGETS_DIR}/${RUST_TARGET_SYS}.json" =
"${RUSTLIB_DIR}"
+
+    # Uses SDK's CC as linker so linked binaries works out of box.
+    # We have a problem as rust sets LD_LIBRARY_PATH and this will =
break running host
+    # binaries (even /bin/sh) in the SDK as they detect a newer glibc =
from the SDK
+    # in those paths and we hit symbol errors. We saw particular =
problems with symbol
+    # mismatch on ubuntu1804 during development. To avoid this we have =
an SDK built
+    # binary which unsets LD_LIBRARY_PATH, which can then call the =
wrapper script
+    # where the context is easier to do the env maniupations needed
+    install -d ${SYS_BINDIR}
+    outfile=3D"${SYS_BINDIR}/target-rust-ccld"
+    ${CC} ${S}/target-rust-ccld.c -o $outfile
+    chmod +x "$outfile"
+    create_sdk_wrapper "${SYS_BINDIR}/target-rust-ccld-wrapper" "CC"
+
+    ENV_SETUP_DIR=3D${D}${base_prefix}/environment-setup.d
+    mkdir "${ENV_SETUP_DIR}"
+    RUST_ENV_SETUP_SH=3D"${ENV_SETUP_DIR}/rust.sh"
+
+    RUST_TARGET_TRIPLE=3D`echo ${RUST_TARGET_SYS} | tr '[:lower:]' =
'[:upper:]' | sed 's/-/_/g'`
+    RUST_HOST_TRIPLE=3D`echo ${RUST_HOST_SYS} | tr '[:lower:]' =
'[:upper:]' | sed 's/-/_/g'`
+    SDKLOADER=3D${@bb.utils.contains('SDK_ARCH', 'x86_64', =
'ld-linux-x86-64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'i686', =
'ld-linux.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', 'aarch64', =
'ld-linux-aarch64.so.1', '', d)}${@bb.utils.contains('SDK_ARCH', =
'ppc64le', 'ld64.so.2', '', d)}${@bb.utils.contains('SDK_ARCH', =
'riscv64', 'ld-linux-riscv64-lp64d.so.1', '', d)}
+
+    cat <<- EOF > "${RUST_ENV_SETUP_SH}"
+	export =
CARGO_TARGET_${RUST_TARGET_TRIPLE}_RUSTFLAGS=3D"--sysroot=3D\$OECORE_TARGE=
T_SYSROOT/usr -C link-arg=3D--sysroot=3D\$OECORE_TARGET_SYSROOT"
+	export =
CARGO_TARGET_${RUST_HOST_TRIPLE}_RUNNER=3D"\$OECORE_NATIVE_SYSROOT/lib/${S=
DKLOADER}"
+	export =
RUST_TARGET_PATH=3D"\$OECORE_NATIVE_SYSROOT/usr/lib/${TARGET_SYS}/rustlib"=

+	EOF
+
+    chown -R root.root ${D}
+
+    CARGO_ENV_SETUP_SH=3D"${ENV_SETUP_DIR}/cargo.sh"
+    cat <<- EOF > "${CARGO_ENV_SETUP_SH}"
+	export CARGO_HOME=3D"\$OECORE_TARGET_SYSROOT/home/cargo"
+	mkdir -p "\$CARGO_HOME"
+        # Init the default target once, it might be otherwise user =
modified.
+	if [ ! -f "\$CARGO_HOME/config" ]; then
+		touch "\$CARGO_HOME/config"
+		echo "[build]" >> "\$CARGO_HOME/config"
+		echo 'target =3D "'${RUST_TARGET_SYS}'"' >> =
"\$CARGO_HOME/config"
+		echo '# TARGET_SYS' >> "\$CARGO_HOME/config"
+		echo '[target.'${RUST_TARGET_SYS}']' >> =
"\$CARGO_HOME/config"
+		echo 'linker =3D "target-rust-ccld"' >> =
"\$CARGO_HOME/config"
+    fi
+
+	# Keep the below off as long as HTTP/2 is disabled.
+	export CARGO_HTTP_MULTIPLEXING=3Dfalse
+
+	export =
CARGO_HTTP_CAINFO=3D"\$OECORE_NATIVE_SYSROOT/etc/ssl/certs/ca-certificates=
.crt"
+	EOF
+}
+
+FILES:${PN} +=3D "${base_prefix}/environment-setup.d"
+
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.78.0.bb =
b/recipes-devtools/rust/rust-cross-canadian_1.78.0.bb
new file mode 100644
index 0000000..5586523
--- /dev/null
+++ b/recipes-devtools/rust/rust-cross-canadian_1.78.0.bb
@@ -0,0 +1,2 @@
+inherit cross-canadian
+require rust-cross-canadian.inc
\ No newline at end of file
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.80.0.bb =
b/recipes-devtools/rust/rust-cross-canadian_1.80.0.bb
new file mode 100644
index 0000000..5586523
--- /dev/null
+++ b/recipes-devtools/rust/rust-cross-canadian_1.80.0.bb
@@ -0,0 +1,2 @@
+inherit cross-canadian
+require rust-cross-canadian.inc
\ No newline at end of file
diff --git =
a/recipes-devtools/rust/rust-llvm/0001-AsmMatcherEmitter-sort-ClassInfo-li=
sts-by-name-as-we.patch =
b/recipes-devtools/rust/rust-llvm/0001-AsmMatcherEmitter-sort-ClassInfo-li=
sts-by-name-as-we.patch
new file mode 100644
index 0000000..48af6fc
--- /dev/null
+++ =
b/recipes-devtools/rust/rust-llvm/0001-AsmMatcherEmitter-sort-ClassInfo-li=
sts-by-name-as-we.patch
@@ -0,0 +1,31 @@
+=46rom 86940d87026432683fb6741cd8a34d3b9b18e40d Mon Sep 17 00:00:00 =
2001
+From: Alexander Kanavin <alex.kanavin@gmail.com>
+Date: Fri, 27 Nov 2020 10:11:08 +0000
+Subject: [PATCH] AsmMatcherEmitter: sort ClassInfo lists by name as =
well
+
+Otherwise, there are instances which are identical in
+every other field and therefore sort non-reproducibly
+(which breaks binary and source reproducibiliy).
+
+Upstream-Status: Submitted [https://reviews.llvm.org/D97477]
+Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
+---
+ llvm/utils/TableGen/AsmMatcherEmitter.cpp | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/llvm/utils/TableGen/AsmMatcherEmitter.cpp =
b/llvm/utils/TableGen/AsmMatcherEmitter.cpp
+index ccf0959389b..1f801e83b7d 100644
+--- a/llvm/utils/TableGen/AsmMatcherEmitter.cpp
++++ b/llvm/utils/TableGen/AsmMatcherEmitter.cpp
+@@ -359,7 +359,10 @@ public:
+     // name of a class shouldn't be significant. However, some of the =
backends
+     // accidentally rely on this behaviour, so it will have to stay =
like this
+     // until they are fixed.
+-    return ValueName < RHS.ValueName;
++    if (ValueName !=3D RHS.ValueName)
++        return ValueName < RHS.ValueName;
++    // All else being equal, we should sort by name, for source and =
binary reproducibility
++    return Name < RHS.Name;
+   }
+ };
+=20
diff --git =
a/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path=
.patch =
b/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path=
.patch
new file mode 100644
index 0000000..9be2667
--- /dev/null
+++ =
b/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path=
.patch
@@ -0,0 +1,33 @@
+=46rom 7111770e8290082530d920e120995bf81431b0aa Mon Sep 17 00:00:00 =
2001
+From: Martin Kelly <mkelly@xevo.com>
+Date: Fri, 19 May 2017 00:22:57 -0700
+Subject: [PATCH 12/18] llvm: allow env override of exe path
+
+When using a native llvm-config from inside a sysroot, we need =
llvm-config to
+return the libraries, include directories, etc. from inside the sysroot =
rather
+than from the native sysroot. Thus provide an env override for calling
+llvm-config from a target sysroot.
+
+Upstream-Status: Inappropriate [oe-core specific]
+Signed-off-by: Martin Kelly <mkelly@xevo.com>
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ llvm/tools/llvm-config/llvm-config.cpp | 7 +++++++
+ 1 file changed, 7 insertions(+)
+
+--- a/llvm/tools/llvm-config/llvm-config.cpp
++++ b/llvm/tools/llvm-config/llvm-config.cpp
+@@ -226,6 +226,13 @@ Typical components:\n\
+=20
+ /// Compute the path to the main executable.
+ std::string GetExecutablePath(const char *Argv0) {
++  // Hack for Yocto: we need to override the root path when we are =
using
++  // llvm-config from within a target sysroot.
++  const char *Sysroot =3D std::getenv("YOCTO_ALTERNATE_EXE_PATH");
++  if (Sysroot !=3D nullptr) {
++    return Sysroot;
++  }
++
+   // This just needs to be some symbol in the binary; C++ doesn't
+   // allow taking the address of ::main however.
+   void *P =3D (void *)(intptr_t)GetExecutablePath;
diff --git =
a/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch =
b/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
new file mode 100644
index 0000000..ff31c0b
--- /dev/null
+++ =
b/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
@@ -0,0 +1,25 @@
+Subject: LLVM_INCLUDE_BENCHMARKS with llvm 14.0.1 failing to build
+
+https://github.com/llvm/llvm-project/issues/54941
+
+The LLVM_INCLUDE_BENCHMARKS is turned OFF to fix the build error as
+per the discussions in the above link. We will work on the issue and
+replace the workaround with actual fix once committed in LLVM.
+
+Please refer the following link for more discussions on the issue:-
+https://github.com/rust-lang/rust/issues/96054
+
+Upstream-Status: Pending
+Signed-off-by: Pgowda <pgowda.cve@gmail.com>
+
+--- a/llvm/CMakeLists.txt	2022-04-22 00:45:30.543445478 -0700
++++ b/llvm/CMakeLists.txt	2022-04-22 00:45:42.095232974 -0700
+@@ -615,7 +615,7 @@ option(LLVM_INCLUDE_GO_TESTS "Include th
+=20
+ option(LLVM_BUILD_BENCHMARKS "Add LLVM benchmark targets to the list =
of default
+ targets. If OFF, benchmarks still could be built using Benchmarks =
target." OFF)
+-option(LLVM_INCLUDE_BENCHMARKS "Generate benchmark targets. If OFF, =
benchmarks can't be built." ON)
++option(LLVM_INCLUDE_BENCHMARKS "Generate benchmark targets. If OFF, =
benchmarks can't be built." OFF)
+=20
+ option (LLVM_BUILD_DOCS "Build the llvm documentation." OFF)
+ option (LLVM_INCLUDE_DOCS "Generate build targets for llvm =
documentation." ON)
diff --git a/recipes-devtools/rust/rust-llvm_1.78.0.bb =
b/recipes-devtools/rust/rust-llvm_1.78.0.bb
new file mode 100644
index 0000000..13bdadb
--- /dev/null
+++ b/recipes-devtools/rust/rust-llvm_1.78.0.bb
@@ -0,0 +1,94 @@
+SUMMARY =3D "LLVM compiler framework (packaged with rust)"
+LICENSE ?=3D "Apache-2.0-with-LLVM-exception"
+HOMEPAGE =3D "http://www.rust-lang.org"
+
+# check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
+#
+LLVM_RELEASE =3D "17.0.6"
+
+require rust-source.inc
+
+SRC_URI +=3D =
"file://0002-llvm-allow-env-override-of-exe-path.patch;striplevel=3D2 \
+            =
file://0001-AsmMatcherEmitter-sort-ClassInfo-lists-by-name-as-we.patch;str=
iplevel=3D2 \
+	    file://0003-llvm-fix-include-benchmarks.patch;striplevel=3D2"
+
+S =3D "${RUSTSRC}/src/llvm-project/llvm"
+
+LIC_FILES_CHKSUM =3D =
"file://LICENSE.TXT;md5=3D8a15a0759ef07f2682d2ba4b893c9afe"
+
+inherit cmake
+
+DEPENDS +=3D "ninja-native rust-llvm-native"
+
+ARM_INSTRUCTION_SET:armv5 =3D "arm"
+ARM_INSTRUCTION_SET:armv4t =3D "arm"
+
+# rustc_llvm with debug info is not recognized as a valid crate that's
+# generated by rust-llvm-native.
+CFLAGS:remove =3D "-g"
+CXXFLAGS:remove =3D "-g"
+
+LLVM_DIR =3D "llvm${LLVM_RELEASE}"
+
+RUST_LLVM_TARGETS ?=3D "ARM;AArch64;Mips;PowerPC;RISCV;X86"
+
+EXTRA_OECMAKE =3D " \
+    -DCMAKE_BUILD_TYPE=3DRelease \
+    -DLLVM_TARGETS_TO_BUILD=3D'${RUST_LLVM_TARGETS}' \
+    -DLLVM_BUILD_DOCS=3DOFF \
+    -DLLVM_ENABLE_TERMINFO=3DOFF \
+    -DLLVM_ENABLE_ZLIB=3DOFF \
+    -DLLVM_ENABLE_ZSTD=3DOFF \
+    -DLLVM_ENABLE_LIBXML2=3DOFF \
+    -DLLVM_ENABLE_FFI=3DOFF \
+    -DLLVM_INSTALL_UTILS=3DON \
+    -DLLVM_BUILD_EXAMPLES=3DOFF \
+    -DLLVM_INCLUDE_EXAMPLES=3DOFF \
+    -DLLVM_BUILD_TESTS=3DOFF \
+    -DLLVM_INCLUDE_TESTS=3DOFF \
+    -DLLVM_TARGET_ARCH=3D${TARGET_ARCH} \
+    -DCMAKE_INSTALL_PREFIX:PATH=3D${libdir}/llvm-rust \
+"
+
+# Forcibly disable the detection of these packages as otherwise
+# it will look at the host Python install
+EXTRA_OECMAKE +=3D "\
+    -DPY_PYGMENTS_FOUND=3DOFF \
+    -DPY_PYGMENTS_LEXERS_C_CPP_FOUND=3DOFF \
+    -DPY_YAML_FOUND=3DOFF \
+"
+
+EXTRA_OECMAKE:append:class-target =3D "\
+    -DLLVM_BUILD_TOOLS=3DOFF \
+    -DLLVM_TABLEGEN=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-tblgen =
\
+    =
-DLLVM_CONFIG_PATH=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config =
\
+"
+
+EXTRA_OECMAKE:append:class-nativesdk =3D "\
+    -DLLVM_BUILD_TOOLS=3DOFF \
+    -DLLVM_TABLEGEN=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-tblgen =
\
+    =
-DLLVM_CONFIG_PATH=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config =
\
+"
+
+# The debug symbols are huge here (>2GB) so suppress them since they
+# provide almost no value. If you really need them then override this
+INHIBIT_PACKAGE_DEBUG_SPLIT =3D "1"
+
+export YOCTO_ALTERNATE_EXE_PATH =3D =
"${STAGING_LIBDIR}/llvm-rust/bin/llvm-config"
+
+do_install:append () {
+    # we don't need any of this stuff to build Rust
+    rm -rf "${D}/usr/lib/cmake"
+}
+
+PACKAGES =3D+ "${PN}-bugpointpasses ${PN}-llvmhello ${PN}-liblto"
+
+# Add the extra locations to avoid the complaints about unpackaged =
files
+FILES:${PN}-bugpointpasses =3D =
"${libdir}/llvm-rust/lib/BugpointPasses.so"
+FILES:${PN}-llvmhello =3D "${libdir}/llvm-rust/lib/LLVMHello.so"
+FILES:${PN}-liblto =3D "${libdir}/llvm-rust/lib/libLTO.so.*"
+FILES:${PN}-staticdev =3D+ "${libdir}/llvm-rust/*/*.a"
+FILES:${PN} +=3D "${libdir}/libLLVM*.so.* =
${libdir}/llvm-rust/lib/*.so.* ${libdir}/llvm-rust/bin"
+FILES:${PN}-dev +=3D "${datadir}/llvm ${libdir}/llvm-rust/lib/*.so =
${libdir}/llvm-rust/include ${libdir}/llvm-rust/share =
${libdir}/llvm-rust/lib/cmake"
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git a/recipes-devtools/rust/rust-llvm_1.80.0.bb =
b/recipes-devtools/rust/rust-llvm_1.80.0.bb
new file mode 100644
index 0000000..13bdadb
--- /dev/null
+++ b/recipes-devtools/rust/rust-llvm_1.80.0.bb
@@ -0,0 +1,94 @@
+SUMMARY =3D "LLVM compiler framework (packaged with rust)"
+LICENSE ?=3D "Apache-2.0-with-LLVM-exception"
+HOMEPAGE =3D "http://www.rust-lang.org"
+
+# check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
+#
+LLVM_RELEASE =3D "17.0.6"
+
+require rust-source.inc
+
+SRC_URI +=3D =
"file://0002-llvm-allow-env-override-of-exe-path.patch;striplevel=3D2 \
+            =
file://0001-AsmMatcherEmitter-sort-ClassInfo-lists-by-name-as-we.patch;str=
iplevel=3D2 \
+	    file://0003-llvm-fix-include-benchmarks.patch;striplevel=3D2"
+
+S =3D "${RUSTSRC}/src/llvm-project/llvm"
+
+LIC_FILES_CHKSUM =3D =
"file://LICENSE.TXT;md5=3D8a15a0759ef07f2682d2ba4b893c9afe"
+
+inherit cmake
+
+DEPENDS +=3D "ninja-native rust-llvm-native"
+
+ARM_INSTRUCTION_SET:armv5 =3D "arm"
+ARM_INSTRUCTION_SET:armv4t =3D "arm"
+
+# rustc_llvm with debug info is not recognized as a valid crate that's
+# generated by rust-llvm-native.
+CFLAGS:remove =3D "-g"
+CXXFLAGS:remove =3D "-g"
+
+LLVM_DIR =3D "llvm${LLVM_RELEASE}"
+
+RUST_LLVM_TARGETS ?=3D "ARM;AArch64;Mips;PowerPC;RISCV;X86"
+
+EXTRA_OECMAKE =3D " \
+    -DCMAKE_BUILD_TYPE=3DRelease \
+    -DLLVM_TARGETS_TO_BUILD=3D'${RUST_LLVM_TARGETS}' \
+    -DLLVM_BUILD_DOCS=3DOFF \
+    -DLLVM_ENABLE_TERMINFO=3DOFF \
+    -DLLVM_ENABLE_ZLIB=3DOFF \
+    -DLLVM_ENABLE_ZSTD=3DOFF \
+    -DLLVM_ENABLE_LIBXML2=3DOFF \
+    -DLLVM_ENABLE_FFI=3DOFF \
+    -DLLVM_INSTALL_UTILS=3DON \
+    -DLLVM_BUILD_EXAMPLES=3DOFF \
+    -DLLVM_INCLUDE_EXAMPLES=3DOFF \
+    -DLLVM_BUILD_TESTS=3DOFF \
+    -DLLVM_INCLUDE_TESTS=3DOFF \
+    -DLLVM_TARGET_ARCH=3D${TARGET_ARCH} \
+    -DCMAKE_INSTALL_PREFIX:PATH=3D${libdir}/llvm-rust \
+"
+
+# Forcibly disable the detection of these packages as otherwise
+# it will look at the host Python install
+EXTRA_OECMAKE +=3D "\
+    -DPY_PYGMENTS_FOUND=3DOFF \
+    -DPY_PYGMENTS_LEXERS_C_CPP_FOUND=3DOFF \
+    -DPY_YAML_FOUND=3DOFF \
+"
+
+EXTRA_OECMAKE:append:class-target =3D "\
+    -DLLVM_BUILD_TOOLS=3DOFF \
+    -DLLVM_TABLEGEN=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-tblgen =
\
+    =
-DLLVM_CONFIG_PATH=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config =
\
+"
+
+EXTRA_OECMAKE:append:class-nativesdk =3D "\
+    -DLLVM_BUILD_TOOLS=3DOFF \
+    -DLLVM_TABLEGEN=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-tblgen =
\
+    =
-DLLVM_CONFIG_PATH=3D${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config =
\
+"
+
+# The debug symbols are huge here (>2GB) so suppress them since they
+# provide almost no value. If you really need them then override this
+INHIBIT_PACKAGE_DEBUG_SPLIT =3D "1"
+
+export YOCTO_ALTERNATE_EXE_PATH =3D =
"${STAGING_LIBDIR}/llvm-rust/bin/llvm-config"
+
+do_install:append () {
+    # we don't need any of this stuff to build Rust
+    rm -rf "${D}/usr/lib/cmake"
+}
+
+PACKAGES =3D+ "${PN}-bugpointpasses ${PN}-llvmhello ${PN}-liblto"
+
+# Add the extra locations to avoid the complaints about unpackaged =
files
+FILES:${PN}-bugpointpasses =3D =
"${libdir}/llvm-rust/lib/BugpointPasses.so"
+FILES:${PN}-llvmhello =3D "${libdir}/llvm-rust/lib/LLVMHello.so"
+FILES:${PN}-liblto =3D "${libdir}/llvm-rust/lib/libLTO.so.*"
+FILES:${PN}-staticdev =3D+ "${libdir}/llvm-rust/*/*.a"
+FILES:${PN} +=3D "${libdir}/libLLVM*.so.* =
${libdir}/llvm-rust/lib/*.so.* ${libdir}/llvm-rust/bin"
+FILES:${PN}-dev +=3D "${datadir}/llvm ${libdir}/llvm-rust/lib/*.so =
${libdir}/llvm-rust/include ${libdir}/llvm-rust/share =
${libdir}/llvm-rust/lib/cmake"
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git a/recipes-devtools/rust/rust-snapshot.inc =
b/recipes-devtools/rust/rust-snapshot.inc
new file mode 100644
index 0000000..66d777f
--- /dev/null
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -0,0 +1,67 @@
+## This is information on the rust-snapshot (binary) used to build our =
current release.
+## snapshot info is taken from rust/src/stage0.json
+## Rust is self-hosting and bootstraps itself with a pre-built previous =
version of itself.
+## The exact (previous) version that has been used is specified in the =
source tarball.
+## The version is replicated here.
+
+SNAPSHOT_VERSION =3D "1.79.0"
+
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D =
"4ca5e9bd141b0111387ea1aa0355f87eb8d0da52fbc616cefa4ecde4997aa65b"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D =
"77803cfff2ea0342f26b59eabec353bc43a1791012aa70855ecfea0fb7ae76ac"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D =
"519abf4757fbd8d7e3bb4e4cfdc362ded972c1d95f04675684df2d31e8c0899b"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D =
"9c847b42b81325d25a9240e33bf03fa8652f5dd321ae90a9a7a58b46bf124b17"
+
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D =
"57bd43f363ebd399a38aa4ac3b137e9172706770f8b23479f9dd859c6ae779ab"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D =
"1d2612c829d946ca8ce32f2beacfde2c5ebed1fcacb720a58fb8e7786e4c82f2"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D =
"158294f7c424ef75d84046b573f225c15d531745cc79d416a18c11aa8253830e"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D =
"4695a6eb66252d519510ca0a859803fff3a5041f71004404df0ccc9fbf0298d5"
+
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D =
"354d498a8e36abe6ebd7bd859c8c7e7f02b029aa1897b9b60a87e9902ebb1079"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D =
"88eab562705d56a246a09f2897cbae9e37a66dc3cc2cab52c781cd78024f2b52"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D =
"88730b1b0d9c5252e041ed1fc2375d7292dc45132bcc8b6214490c578de240d3"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D =
"f39a604e1a5a5ba1c7342c9d98c9952b5ba252cda4b55cc6ae7bd6fca72f3889"
+
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D =
"2a55e97ce512c27a012720bb2a0cd86554c1d734b5cb91b98f58af167cc0fde1"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D =
"1ae0bbe5835d9461a12f22d509787e6c11aac8335c677152a57a04f8d22cf755"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D =
"6aa2f351bc7dccb544781f4fecddb5ef67e05bb310c84e0106d968231384d9f4"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D =
"3b9a8067e97dd269a27fe91be163e046e85b47973f5d512c3368c49d332dacb1"
+
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D =
"1e2ffcc41a2083be2f4733d534d5ee0e05fc2ace1f21033792a4e2497cbbfbe4"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D =
"0bceeb8dc5b48e5ea9cff67cdcf8488fe2afe44d7e75ca04669c7c0c2e02a0df"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D =
"af95929af71494ee3e6988ead07204ea05b6f2b729cdb1ffcc26db75e47bf318"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D =
"2295d50425ed5dfb028560ac0f9a611212d8deb43791a1d199419043157ab95e"
+
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D =
"bec32adad9f2cd1650ed24ee82fccf7329c68243cdef7cef1e720ccaea097dab"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D =
"6bb12041b6171e80598c0c04eb7e9bd07ab4fb4d654a9289618e3288a4d2f6c8"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D =
"3b5d53d70837d5ec942ec41a8da37ed932bbdc1e53f78dc54e218db458701588"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D =
"3b144840f179114cde3078909370bfb6928153d0ae303ac9848622c57cee3578"
+
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D =
"83e28f3e02cce4a9d19841bcb40ec0c8ad4e9af9fb215c39876028e6e9e6baf1"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D =
"fbc978db4be2e6fdb1dbcb3ca00ee54c44dafd08930738f1c6aa7ae249685a34"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D =
"2b8af4060acb10f347c66a3477ae92151beba12192590ea40723dcf9b1f7f5b2"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D =
"1b952b8cd597060ac07bbe99cea382651ca6eee4ac2abe0a90303ccf2278e60e"
+
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D =
"5663e6ea018a13f1c87ac74de267829952ea979fbe5f8ee5c1c3531e25d1749c"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D =
"c00bd892e0f29bbc2514f87c7521210ced8c175a41eee0a428e19a6ef157779f"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D =
"d70e710a5138871e8d972f195ced9f7aa639ccef23a87fa03cc527d2b9c3cd36"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D =
"ef4b494fb7356b6e88a69b71378c04ae0f4a3c264adae84c9d4f3a1314eaa2b4"
+
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D =
"07fcadd27b645ad58ff4dae5ef166fd730311bbae8f25f6640fe1bfd2a1f3c3c"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D =
"3fb282ee97626e4f25c4f6faac3997859b89f13983dd6fa111e25182dfcb91fa"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D =
"2c914483c0882d44af2e50a181cbd2c953d672d50b31aa669ee2346cade1f108"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D =
"a04cf42022d0a5faf01c31082bfb1dde9c38409f0ca6da90a3e40faa03e797ae"
+
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D =
"9c38f2cd4c19196fcf113166237ab03512bf19ce5a7f13c3bfe0e5cc3317eb44"
+
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D =
"f7c7a73a8e5640f9d5aca6b26866b4da08cf3d3509ed1c4184309fb868acbff2"
+
+SRC_URI +=3D " \
+    =
${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-snaps=
hot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
+    =
${RUST_DIST_SERVER}/dist/${RUSTC_SNAPSHOT}.tar.xz;name=3Drustc-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
+    =
${RUST_DIST_SERVER}/dist/${CARGO_SNAPSHOT}.tar.xz;name=3Dcargo-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
+"
+
+RUST_DIST_SERVER =3D "https://static.rust-lang.org"
+RUST_STD_SNAPSHOT =3D =
"rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+RUSTC_SNAPSHOT =3D =
"rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+CARGO_SNAPSHOT =3D =
"cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
diff --git a/recipes-devtools/rust/rust-source.inc =
b/recipes-devtools/rust/rust-source.inc
new file mode 100644
index 0000000..0cd329f
--- /dev/null
+++ b/recipes-devtools/rust/rust-source.inc
@@ -0,0 +1,22 @@
+RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
+
+SRC_URI +=3D =
"https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;name=3D=
rust \
+            file://hardcodepaths.patch;patchdir=3D${RUSTSRC} \
+            file://zlib-off64_t.patch;patchdir=3D${RUSTSRC} \
+            file://rv32-rustix-libc-backend.patch;patchdir=3D${RUSTSRC} =
\
+            =
file://rv32-cargo-rustix-0.38.28-fix.patch;patchdir=3D${RUSTSRC} \
+            =
file://0001-cargo-do-not-write-host-information-into-compilation.patch;pat=
chdir=3D${RUSTSRC} \
+            =
file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdi=
r=3D${RUSTSRC} \
+            file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
+            =
file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D${RUSTSRC} =
\
+            =
file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=
=3D${RUSTSRC} \
+"
+SRC_URI[rust.sha256sum] =3D =
"0b9ca1e2e45b8a5f0b58db140af0dc92f8311faeb0ad883c5b71a72c02dc6e80"
+
+RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
+
+UPSTREAM_CHECK_URI =3D =
"https://forge.rust-lang.org/infra/other-installation-methods.html"
+UPSTREAM_CHECK_REGEX =3D "rustc-(?P<pver>\d+(\.\d+)+)-src"
+
+CVE_STATUS[CVE-2024-24576] =3D "not-applicable-platform: Issue only =
applies on Windows"
+CVE_STATUS[CVE-2024-43402] =3D "not-applicable-platform: Issue only =
applies on Windows"
diff --git a/recipes-devtools/rust/rust_1.78.0.bb =
b/recipes-devtools/rust/rust_1.78.0.bb
new file mode 100644
index 0000000..396ea9c
--- /dev/null
+++ b/recipes-devtools/rust/rust_1.78.0.bb
@@ -0,0 +1,369 @@
+SUMMARY =3D "Rust compiler and runtime libaries"
+HOMEPAGE =3D "http://www.rust-lang.org"
+SECTION =3D "devel"
+LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
+LIC_FILES_CHKSUM =3D =
"file://COPYRIGHT;md5=3Dc2cccf560306876da3913d79062a54b9"
+
+inherit rust
+inherit cargo_common
+
+DEPENDS +=3D "file-native python3-native"
+DEPENDS:append:class-native =3D " rust-llvm-native"
+DEPENDS:append:class-nativesdk =3D " nativesdk-rust-llvm"
+
+# native rust uses cargo/rustc from binary snapshots to bootstrap
+# but everything else should use our native builds
+DEPENDS:append:class-target =3D " cargo-native rust-native"
+DEPENDS:append:class-nativesdk =3D " cargo-native rust-native"
+
+DEPENDS +=3D "rust-llvm (=3D${PV})"
+
+RDEPENDS:${PN}:append:class-target =3D " gcc g++ binutils"
+
+# Otherwise we'll depend on what we provide
+INHIBIT_DEFAULT_RUST_DEPS:class-native =3D "1"
+# We don't need to depend on gcc-native because yocto assumes it exists
+PROVIDES:class-native =3D "virtual/${TARGET_PREFIX}rust"
+
+S =3D "${RUSTSRC}"
+
+# Use at your own risk, accepted values are stable, beta and nightly
+RUST_CHANNEL ?=3D "stable"
+PV .=3D "${@bb.utils.contains('RUST_CHANNEL', 'stable', '', =
'-${RUST_CHANNEL}', d)}"
+
+export FORCE_CRATE_HASH=3D"${BB_TASKHASH}"
+
+RUST_ALTERNATE_EXE_PATH ?=3D =
"${STAGING_LIBDIR}/llvm-rust/bin/llvm-config"
+RUST_ALTERNATE_EXE_PATH_NATIVE =3D =
"${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config"
+
+# We don't want to use bitbakes vendoring because the rust sources do =
their
+# own vendoring.
+CARGO_DISABLE_BITBAKE_VENDORING =3D "1"
+
+setup_cargo_environment () {
+    # The first step is to build bootstrap and some early stage tools,
+    # these are build for the same target as the snapshot, e.g.
+    # x86_64-unknown-linux-gnu.
+    # Later stages are build for the native target (i.e. =
target.x86_64-linux)
+    cargo_common_do_configure
+}
+
+inherit rust-target-config
+
+do_rust_setup_snapshot () {
+    for installer in =
"${WORKDIR}/rust-snapshot-components/"*"/install.sh"; do
+        "${installer}" --prefix=3D"${WORKDIR}/rust-snapshot" =
--disable-ldconfig
+    done
+
+    # Some versions of rust (e.g. 1.18.0) tries to find cargo in =
stage0/bin/cargo
+    # and fail without it there.
+    mkdir -p ${RUSTSRC}/build/${RUST_BUILD_SYS}
+    ln -sf ${WORKDIR}/rust-snapshot/ =
${RUSTSRC}/build/${RUST_BUILD_SYS}/stage0
+
+    # Need to use uninative's loader if enabled/present since the =
library paths
+    # are used internally by rust and result in symbol mismatches if we =
don't
+    if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
+        for bin in cargo rustc rustdoc; do
+            patchelf-uninative ${WORKDIR}/rust-snapshot/bin/$bin =
--set-interpreter ${UNINATIVE_LOADER}
+        done
+    fi
+}
+addtask rust_setup_snapshot after do_unpack before do_configure
+addtask do_test_compile after do_configure do_rust_gen_targets
+do_rust_setup_snapshot[dirs] +=3D "${WORKDIR}/rust-snapshot"
+do_rust_setup_snapshot[vardepsexclude] +=3D "UNINATIVE_LOADER"
+
+RUSTC_BOOTSTRAP =3D "${STAGING_BINDIR_NATIVE}/rustc"
+CARGO_BOOTSTRAP =3D "${STAGING_BINDIR_NATIVE}/cargo"
+RUSTC_BOOTSTRAP:class-native =3D "${WORKDIR}/rust-snapshot/bin/rustc"
+CARGO_BOOTSTRAP:class-native =3D "${WORKDIR}/rust-snapshot/bin/cargo"
+
+python do_configure() {
+    import json
+    import configparser
+
+    # toml is rather similar to standard ini like format except it =
likes values
+    # that look more JSON like. So for our purposes simply escaping all =
values
+    # as JSON seem to work fine.
+
+    e =3D lambda s: json.dumps(s)
+
+    config =3D configparser.RawConfigParser()
+
+    # [target.ARCH-poky-linux]
+    host_section =3D "target.{}".format(d.getVar('RUST_HOST_SYS'))
+    config.add_section(host_section)
+
+    llvm_config_target =3D d.expand("${RUST_ALTERNATE_EXE_PATH}")
+    llvm_config_build =3D d.expand("${RUST_ALTERNATE_EXE_PATH_NATIVE}")
+    config.set(host_section, "llvm-config", e(llvm_config_target))
+
+    config.set(host_section, "cxx", e(d.expand("${RUST_TARGET_CXX}")))
+    config.set(host_section, "cc", e(d.expand("${RUST_TARGET_CC}")))
+    config.set(host_section, "linker", =
e(d.expand("${RUST_TARGET_CCLD}")))
+    if "musl" in host_section:
+        config.set(host_section, "musl-root", =
e(d.expand("${STAGING_DIR_HOST}${exec_prefix}")))
+
+    # If we don't do this rust-native will compile it's own llvm for =
BUILD.
+    # [target.${BUILD_ARCH}-unknown-linux-gnu]
+    build_section =3D "target.{}".format(d.getVar('RUST_BUILD_SYS'))
+    if build_section !=3D host_section:
+        config.add_section(build_section)
+
+        config.set(build_section, "llvm-config", e(llvm_config_build))
+
+        config.set(build_section, "cxx", =
e(d.expand("${RUST_BUILD_CXX}")))
+        config.set(build_section, "cc", =
e(d.expand("${RUST_BUILD_CC}")))
+        config.set(build_section, "linker", =
e(d.expand("${RUST_BUILD_CCLD}")))
+
+    target_section =3D "target.{}".format(d.getVar('RUST_TARGET_SYS'))
+    if target_section !=3D host_section and target_section !=3D =
build_section:
+        config.add_section(target_section)
+
+        config.set(target_section, "llvm-config", =
e(llvm_config_target))
+
+        config.set(target_section, "cxx", =
e(d.expand("${RUST_TARGET_CXX}")))
+        config.set(target_section, "cc", =
e(d.expand("${RUST_TARGET_CC}")))
+        config.set(target_section, "linker", =
e(d.expand("${RUST_TARGET_CCLD}")))
+
+    # [llvm]
+    config.add_section("llvm")
+    config.set("llvm", "static-libstdcpp", e(False))
+    if "llvm" in (d.getVar('TC_CXX_RUNTIME') or ""):
+        config.set("llvm", "use-libcxx", e(True))
+
+    # [rust]
+    config.add_section("rust")
+    config.set("rust", "rpath", e(True))
+    config.set("rust", "remap-debuginfo", e(True))
+    config.set("rust", "lto", "\"off\"")
+    config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
+
+    # Whether or not to optimize the compiler and standard library
+    config.set("rust", "optimize", e(True))
+
+    # Emits extraneous output from tests to ensure that failures of the =
test
+    # harness are debuggable just from logfiles
+    config.set("rust", "verbose-tests", e(True))
+
+    # [build]
+    config.add_section("build")
+    config.set("build", "submodules", e(False))
+    config.set("build", "docs", e(False))
+
+    rustc =3D d.getVar('RUSTC_BOOTSTRAP')
+    config.set("build", "rustc", e(rustc))
+
+    cargo =3D d.getVar('CARGO_BOOTSTRAP')
+    config.set("build", "cargo", e(cargo))
+
+    config.set("build", "vendor", e(True))
+
+    config.set("build", "target", e([d.getVar("RUST_TARGET_SYS")]))
+
+    config.set("build", "host", e([d.getVar("RUST_HOST_SYS")]))
+
+    # We can't use BUILD_SYS since that is something the rust snapshot =
knows
+    # nothing about when trying to build some stage0 tools (like =
fabricate)
+    config.set("build", "build", e(d.getVar("RUST_BUILD_SYS")))
+
+    # [install]
+    config.add_section("install")
+    # ./x.py install doesn't have any notion of "destdir"
+    # but we can prepend ${D} to all the directories instead
+    config.set("install", "prefix",  e(d.getVar("D") + =
d.getVar("prefix")))
+    config.set("install", "bindir",  e(d.getVar("D") + =
d.getVar("bindir")))
+    config.set("install", "libdir",  e(d.getVar("D") + =
d.getVar("libdir")))
+    config.set("install", "datadir", e(d.getVar("D") + =
d.getVar("datadir")))
+    config.set("install", "mandir",  e(d.getVar("D") + =
d.getVar("mandir")))
+    config.set("install", "sysconfdir",  e(d.getVar("D") + =
d.getVar("sysconfdir")))
+
+    with open("config.toml", "w") as f:
+        f.write('change-id =3D 116881\n\n')
+        config.write(f)
+
+    # set up ${WORKDIR}/cargo_home
+    bb.build.exec_func("setup_cargo_environment", d)
+}
+
+rust_runx () {
+    echo "COMPILE ${PN}" "$@"
+
+    # CFLAGS, LDFLAGS, CXXFLAGS, CPPFLAGS are used by rust's build for =
a
+    # wide range of targets (not just TARGET). Yocto's settings for =
them will
+    # be inappropriate, avoid using.
+    unset CFLAGS
+    unset LDFLAGS
+    unset CXXFLAGS
+    unset CPPFLAGS
+
+    export RUSTFLAGS=3D"${RUST_DEBUG_REMAP}"
+
+    # Copy the natively built llvm-config into the target so we can run =
it. Horrible,
+    # but works!
+    if [ ${RUST_ALTERNATE_EXE_PATH_NATIVE} !=3D =
${RUST_ALTERNATE_EXE_PATH} -a ! -f ${RUST_ALTERNATE_EXE_PATH} ]; then
+        mkdir -p `dirname ${RUST_ALTERNATE_EXE_PATH}`
+        cp ${RUST_ALTERNATE_EXE_PATH_NATIVE} ${RUST_ALTERNATE_EXE_PATH}
+        if [ -e ${STAGING_LIBDIR_NATIVE}/libc++.so.1 ]; then
+            chrpath -r \$ORIGIN/../../../../../`basename =
${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
+        else
+            chrpath -d ${RUST_ALTERNATE_EXE_PATH}
+        fi
+    fi
+
+    oe_cargo_fix_env
+
+    python3 src/bootstrap/bootstrap.py =
${@oe.utils.parallel_make_argument(d, '-j %d')} "$@" --verbose
+}
+rust_runx[vardepsexclude] +=3D "PARALLEL_MAKE"
+
+require rust-source.inc
+require rust-snapshot.inc
+
+INSANE_SKIP:${PN}:class-native =3D "already-stripped"
+FILES:${PN} +=3D "${libdir}/rustlib"
+FILES:${PN} +=3D "${libdir}/*.so"
+FILES:${PN}-dev =3D ""
+
+do_compile () {
+}
+
+do_test_compile[dirs] =3D "${B}"
+do_test_compile () {
+    rust_runx build src/tools/remote-test-server --target =
"${RUST_TARGET_SYS}"
+}
+
+ALLOW_EMPTY:${PN} =3D "1"
+
+PACKAGES =3D+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt"
+FILES:${PN}-rustdoc =3D "${bindir}/rustdoc"
+FILES:${PN}-tools-clippy =3D "${bindir}/cargo-clippy =
${bindir}/clippy-driver"
+FILES:${PN}-tools-rustfmt =3D "${bindir}/rustfmt"
+RDEPENDS:${PN}-rustdoc =3D "${PN}"
+RDEPENDS:${PN}-tools-clippy =3D "${PN}"
+RDEPENDS:${PN}-tools-rustfmt =3D "${PN}"
+
+SUMMARY:${PN}-tools-clippy =3D "A collection of lints to catch common =
mistakes and improve your Rust code"
+SUMMARY:${PN}-tools-rustfmt =3D "A tool for formatting Rust code =
according to style guidelines"
+
+do_install () {
+    rust_do_install
+}
+
+rust_do_install() {
+    rust_runx install
+}
+
+rust_do_install:class-nativesdk() {
+    export PSEUDO_UNLOAD=3D1
+    rust_runx install
+    rust_runx install clippy
+    rust_runx install rustfmt
+    unset PSEUDO_UNLOAD
+
+    install -d ${D}${bindir}
+    for i in cargo-clippy clippy-driver rustfmt; do
+        cp =
build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i =
${D}${bindir}
+        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+    done
+
+    chown root:root ${D}/ -R
+    rm ${D}${libdir}/rustlib/uninstall.sh
+    rm ${D}${libdir}/rustlib/install.log
+    rm ${D}${libdir}/rustlib/manifest*
+}
+
+EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
+rust_do_install:class-target() {
+    export PSEUDO_UNLOAD=3D1
+    rust_runx install
+    rust_runx install clippy
+    rust_runx install rustfmt
+    unset PSEUDO_UNLOAD
+
+    install -d ${D}${bindir}
+    for i in ${EXTRA_TOOLS}; do
+        cp =
build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i =
${D}${bindir}
+        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+    done
+
+    install -d ${D}${libdir}/rustlib/${RUST_HOST_SYS}
+    install -m 0644 ${WORKDIR}/rust-targets/${RUST_HOST_SYS}.json =
${D}${libdir}/rustlib/${RUST_HOST_SYS}/target.json
+
+    chown root:root ${D}/ -R
+    rm ${D}${libdir}/rustlib/uninstall.sh
+    rm ${D}${libdir}/rustlib/install.log
+    rm ${D}${libdir}/rustlib/manifest*
+}
+
+addtask do_update_snapshot after do_patch
+do_update_snapshot[nostamp] =3D "1"
+
+# Run with `bitbake -c update_snapshot rust` to update =
`rust-snapshot.inc`
+# with the checksums for the rust snapshot associated with this =
rustc-src
+# tarball.
+python do_update_snapshot() {
+    import json
+    import re
+    import sys
+
+    from collections import defaultdict
+
+    with open(os.path.join(d.getVar("S"), "src", "stage0.json")) as f:
+        j =3D json.load(f)
+
+    config_dist_server =3D j['config']['dist_server']
+    compiler_date =3D j['compiler']['date']
+    compiler_version =3D j['compiler']['version']
+
+    src_uri =3D defaultdict(list)
+    for k, v in j['checksums_sha256'].items():
+        m =3D =
re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<=
arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
+        if m:
+            component =3D m.group('component')
+            arch =3D m.group('arch')
+            =
src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] =3D =
\"{v}\"")
+
+    snapshot =3D """\
+## This is information on the rust-snapshot (binary) used to build our =
current release.
+## snapshot info is taken from rust/src/stage0.json
+## Rust is self-hosting and bootstraps itself with a pre-built previous =
version of itself.
+## The exact (previous) version that has been used is specified in the =
source tarball.
+## The version is replicated here.
+
+SNAPSHOT_VERSION =3D "%s"
+
+""" % compiler_version
+
+    for arch, components in src_uri.items():
+        snapshot +=3D "\n".join(components) + "\n\n"
+
+    snapshot +=3D """\
+SRC_URI +=3D " \\
+    =
${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-snaps=
hot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+    =
${RUST_DIST_SERVER}/dist/${RUSTC_SNAPSHOT}.tar.xz;name=3Drustc-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+    =
${RUST_DIST_SERVER}/dist/${CARGO_SNAPSHOT}.tar.xz;name=3Dcargo-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+"
+
+RUST_DIST_SERVER =3D "%s"
+
+RUST_STD_SNAPSHOT =3D =
"rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+RUSTC_SNAPSHOT =3D =
"rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+CARGO_SNAPSHOT =3D =
"cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+""" % config_dist_server
+
+    with open(os.path.join(d.getVar("THISDIR"), "rust-snapshot.inc"), =
"w") as f:
+        f.write(snapshot)
+}
+
+RUSTLIB_DEP:class-nativesdk =3D ""
+
+# musl builds include libunwind.a
+INSANE_SKIP:${PN} =3D "staticdev"
+
+BBCLASSEXTEND =3D "native nativesdk"
+
+# Since 1.70.0 upgrade this fails to build with gold:
+# http://errors.yoctoproject.org/Errors/Details/708196/
+# ld: error: version script assignment of  to symbol =
__rust_alloc_error_handler_should_panic failed: symbol not defined
+LDFLAGS:append =3D "${@bb.utils.contains('DISTRO_FEATURES', =
'ld-is-gold', ' -fuse-ld=3Dbfd', '', d)}"
diff --git a/recipes-devtools/rust/rust_1.80.0.bb =
b/recipes-devtools/rust/rust_1.80.0.bb
new file mode 100644
index 0000000..3d9ea70
--- /dev/null
+++ b/recipes-devtools/rust/rust_1.80.0.bb
@@ -0,0 +1,369 @@
+SUMMARY =3D "Rust compiler and runtime libaries"
+HOMEPAGE =3D "http://www.rust-lang.org"
+SECTION =3D "devel"
+LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
+LIC_FILES_CHKSUM =3D =
"file://COPYRIGHT;md5=3Dc2cccf560306876da3913d79062a54b9"
+
+inherit rust
+inherit cargo_common
+
+DEPENDS +=3D "file-native python3-native"
+DEPENDS:append:class-native =3D " rust-llvm-native"
+DEPENDS:append:class-nativesdk =3D " nativesdk-rust-llvm"
+
+# native rust uses cargo/rustc from binary snapshots to bootstrap
+# but everything else should use our native builds
+DEPENDS:append:class-target =3D " cargo-native rust-native"
+DEPENDS:append:class-nativesdk =3D " cargo-native rust-native"
+
+DEPENDS +=3D "rust-llvm (=3D${PV})"
+
+RDEPENDS:${PN}:append:class-target =3D " gcc g++ binutils"
+
+# Otherwise we'll depend on what we provide
+INHIBIT_DEFAULT_RUST_DEPS:class-native =3D "1"
+# We don't need to depend on gcc-native because yocto assumes it exists
+PROVIDES:class-native =3D "virtual/${TARGET_PREFIX}rust"
+
+S =3D "${RUSTSRC}"
+
+# Use at your own risk, accepted values are stable, beta and nightly
+RUST_CHANNEL ?=3D "stable"
+PV .=3D "${@bb.utils.contains('RUST_CHANNEL', 'stable', '', =
'-${RUST_CHANNEL}', d)}"
+
+export FORCE_CRATE_HASH=3D"${BB_TASKHASH}"
+
+RUST_ALTERNATE_EXE_PATH ?=3D =
"${STAGING_LIBDIR}/llvm-rust/bin/llvm-config"
+RUST_ALTERNATE_EXE_PATH_NATIVE =3D =
"${STAGING_LIBDIR_NATIVE}/llvm-rust/bin/llvm-config"
+
+# We don't want to use bitbakes vendoring because the rust sources do =
their
+# own vendoring.
+CARGO_DISABLE_BITBAKE_VENDORING =3D "1"
+
+setup_cargo_environment () {
+    # The first step is to build bootstrap and some early stage tools,
+    # these are build for the same target as the snapshot, e.g.
+    # x86_64-unknown-linux-gnu.
+    # Later stages are build for the native target (i.e. =
target.x86_64-linux)
+    cargo_common_do_configure
+}
+
+inherit rust-target-config
+
+do_rust_setup_snapshot () {
+    for installer in =
"${WORKDIR}/rust-snapshot-components/"*"/install.sh"; do
+        "${installer}" --prefix=3D"${WORKDIR}/rust-snapshot" =
--disable-ldconfig
+    done
+
+    # Some versions of rust (e.g. 1.18.0) tries to find cargo in =
stage0/bin/cargo
+    # and fail without it there.
+    mkdir -p ${RUSTSRC}/build/${RUST_BUILD_SYS}
+    ln -sf ${WORKDIR}/rust-snapshot/ =
${RUSTSRC}/build/${RUST_BUILD_SYS}/stage0
+
+    # Need to use uninative's loader if enabled/present since the =
library paths
+    # are used internally by rust and result in symbol mismatches if we =
don't
+    if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
+        for bin in cargo rustc rustdoc; do
+            patchelf-uninative ${WORKDIR}/rust-snapshot/bin/$bin =
--set-interpreter ${UNINATIVE_LOADER}
+        done
+    fi
+}
+addtask rust_setup_snapshot after do_unpack before do_configure
+addtask do_test_compile after do_configure do_rust_gen_targets
+do_rust_setup_snapshot[dirs] +=3D "${WORKDIR}/rust-snapshot"
+do_rust_setup_snapshot[vardepsexclude] +=3D "UNINATIVE_LOADER"
+
+RUSTC_BOOTSTRAP =3D "${STAGING_BINDIR_NATIVE}/rustc"
+CARGO_BOOTSTRAP =3D "${STAGING_BINDIR_NATIVE}/cargo"
+RUSTC_BOOTSTRAP:class-native =3D "${WORKDIR}/rust-snapshot/bin/rustc"
+CARGO_BOOTSTRAP:class-native =3D "${WORKDIR}/rust-snapshot/bin/cargo"
+
+python do_configure() {
+    import json
+    import configparser
+
+    # toml is rather similar to standard ini like format except it =
likes values
+    # that look more JSON like. So for our purposes simply escaping all =
values
+    # as JSON seem to work fine.
+
+    e =3D lambda s: json.dumps(s)
+
+    config =3D configparser.RawConfigParser()
+
+    # [target.ARCH-poky-linux]
+    host_section =3D "target.{}".format(d.getVar('RUST_HOST_SYS'))
+    config.add_section(host_section)
+
+    llvm_config_target =3D d.expand("${RUST_ALTERNATE_EXE_PATH}")
+    llvm_config_build =3D d.expand("${RUST_ALTERNATE_EXE_PATH_NATIVE}")
+    config.set(host_section, "llvm-config", e(llvm_config_target))
+
+    config.set(host_section, "cxx", e(d.expand("${RUST_TARGET_CXX}")))
+    config.set(host_section, "cc", e(d.expand("${RUST_TARGET_CC}")))
+    config.set(host_section, "linker", =
e(d.expand("${RUST_TARGET_CCLD}")))
+    if "musl" in host_section:
+        config.set(host_section, "musl-root", =
e(d.expand("${STAGING_DIR_HOST}${exec_prefix}")))
+
+    # If we don't do this rust-native will compile it's own llvm for =
BUILD.
+    # [target.${BUILD_ARCH}-unknown-linux-gnu]
+    build_section =3D "target.{}".format(d.getVar('RUST_BUILD_SYS'))
+    if build_section !=3D host_section:
+        config.add_section(build_section)
+
+        config.set(build_section, "llvm-config", e(llvm_config_build))
+
+        config.set(build_section, "cxx", =
e(d.expand("${RUST_BUILD_CXX}")))
+        config.set(build_section, "cc", =
e(d.expand("${RUST_BUILD_CC}")))
+        config.set(build_section, "linker", =
e(d.expand("${RUST_BUILD_CCLD}")))
+
+    target_section =3D "target.{}".format(d.getVar('RUST_TARGET_SYS'))
+    if target_section !=3D host_section and target_section !=3D =
build_section:
+        config.add_section(target_section)
+
+        config.set(target_section, "llvm-config", =
e(llvm_config_target))
+
+        config.set(target_section, "cxx", =
e(d.expand("${RUST_TARGET_CXX}")))
+        config.set(target_section, "cc", =
e(d.expand("${RUST_TARGET_CC}")))
+        config.set(target_section, "linker", =
e(d.expand("${RUST_TARGET_CCLD}")))
+
+    # [llvm]
+    config.add_section("llvm")
+    config.set("llvm", "static-libstdcpp", e(False))
+    if "llvm" in (d.getVar('TC_CXX_RUNTIME') or ""):
+        config.set("llvm", "use-libcxx", e(True))
+
+    # [rust]
+    config.add_section("rust")
+    config.set("rust", "rpath", e(True))
+    config.set("rust", "remap-debuginfo", e(True))
+    config.set("rust", "lto", "\"off\"")
+    config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
+
+    # Whether or not to optimize the compiler and standard library
+    config.set("rust", "optimize", e(True))
+
+    # Emits extraneous output from tests to ensure that failures of the =
test
+    # harness are debuggable just from logfiles
+    config.set("rust", "verbose-tests", e(True))
+
+    # [build]
+    config.add_section("build")
+    config.set("build", "submodules", e(False))
+    config.set("build", "docs", e(False))
+
+    rustc =3D d.getVar('RUSTC_BOOTSTRAP')
+    config.set("build", "rustc", e(rustc))
+
+    cargo =3D d.getVar('CARGO_BOOTSTRAP')
+    config.set("build", "cargo", e(cargo))
+
+    config.set("build", "vendor", e(True))
+
+    config.set("build", "target", e([d.getVar("RUST_TARGET_SYS")]))
+
+    config.set("build", "host", e([d.getVar("RUST_HOST_SYS")]))
+
+    # We can't use BUILD_SYS since that is something the rust snapshot =
knows
+    # nothing about when trying to build some stage0 tools (like =
fabricate)
+    config.set("build", "build", e(d.getVar("RUST_BUILD_SYS")))
+
+    # [install]
+    config.add_section("install")
+    # ./x.py install doesn't have any notion of "destdir"
+    # but we can prepend ${D} to all the directories instead
+    config.set("install", "prefix",  e(d.getVar("D") + =
d.getVar("prefix")))
+    config.set("install", "bindir",  e(d.getVar("D") + =
d.getVar("bindir")))
+    config.set("install", "libdir",  e(d.getVar("D") + =
d.getVar("libdir")))
+    config.set("install", "datadir", e(d.getVar("D") + =
d.getVar("datadir")))
+    config.set("install", "mandir",  e(d.getVar("D") + =
d.getVar("mandir")))
+    config.set("install", "sysconfdir",  e(d.getVar("D") + =
d.getVar("sysconfdir")))
+
+    with open("config.toml", "w") as f:
+        f.write('change-id =3D 116881\n\n')
+        config.write(f)
+
+    # set up ${WORKDIR}/cargo_home
+    bb.build.exec_func("setup_cargo_environment", d)
+}
+
+rust_runx () {
+    echo "COMPILE ${PN}" "$@"
+
+    # CFLAGS, LDFLAGS, CXXFLAGS, CPPFLAGS are used by rust's build for =
a
+    # wide range of targets (not just TARGET). Yocto's settings for =
them will
+    # be inappropriate, avoid using.
+    unset CFLAGS
+    unset LDFLAGS
+    unset CXXFLAGS
+    unset CPPFLAGS
+
+    export RUSTFLAGS=3D"${RUST_DEBUG_REMAP}"
+
+    # Copy the natively built llvm-config into the target so we can run =
it. Horrible,
+    # but works!
+    if [ ${RUST_ALTERNATE_EXE_PATH_NATIVE} !=3D =
${RUST_ALTERNATE_EXE_PATH} -a ! -f ${RUST_ALTERNATE_EXE_PATH} ]; then
+        mkdir -p `dirname ${RUST_ALTERNATE_EXE_PATH}`
+        cp ${RUST_ALTERNATE_EXE_PATH_NATIVE} ${RUST_ALTERNATE_EXE_PATH}
+        if [ -e ${STAGING_LIBDIR_NATIVE}/libc++.so.1 ]; then
+            chrpath -r \$ORIGIN/../../../../../`basename =
${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
+        else
+            chrpath -d ${RUST_ALTERNATE_EXE_PATH}
+        fi
+    fi
+
+    oe_cargo_fix_env
+
+    python3 src/bootstrap/bootstrap.py =
${@oe.utils.parallel_make_argument(d, '-j %d')} "$@" --verbose
+}
+rust_runx[vardepsexclude] +=3D "PARALLEL_MAKE"
+
+require rust-source.inc
+require rust-snapshot.inc
+
+INSANE_SKIP:${PN}:class-native =3D "already-stripped"
+FILES:${PN} +=3D "${libdir}/rustlib"
+FILES:${PN} +=3D "${libdir}/*.so"
+FILES:${PN}-dev =3D ""
+
+do_compile () {
+}
+
+do_test_compile[dirs] =3D "${B}"
+do_test_compile () {
+    rust_runx build src/tools/remote-test-server --target =
"${RUST_TARGET_SYS}"
+}
+
+ALLOW_EMPTY:${PN} =3D "1"
+
+PACKAGES =3D+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt"
+FILES:${PN}-rustdoc =3D "${bindir}/rustdoc"
+FILES:${PN}-tools-clippy =3D "${bindir}/cargo-clippy =
${bindir}/clippy-driver"
+FILES:${PN}-tools-rustfmt =3D "${bindir}/rustfmt"
+RDEPENDS:${PN}-rustdoc =3D "${PN}"
+RDEPENDS:${PN}-tools-clippy =3D "${PN}"
+RDEPENDS:${PN}-tools-rustfmt =3D "${PN}"
+
+SUMMARY:${PN}-tools-clippy =3D "A collection of lints to catch common =
mistakes and improve your Rust code"
+SUMMARY:${PN}-tools-rustfmt =3D "A tool for formatting Rust code =
according to style guidelines"
+
+do_install () {
+    rust_do_install
+}
+
+rust_do_install() {
+    rust_runx install
+}
+
+rust_do_install:class-nativesdk() {
+    export PSEUDO_UNLOAD=3D1
+    rust_runx install
+    rust_runx install clippy
+    rust_runx install rustfmt
+    unset PSEUDO_UNLOAD
+
+    install -d ${D}${bindir}
+    for i in cargo-clippy clippy-driver rustfmt; do
+        cp =
build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i =
${D}${bindir}
+        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+    done
+
+    chown root:root ${D}/ -R
+    rm ${D}${libdir}/rustlib/uninstall.sh
+    rm ${D}${libdir}/rustlib/install.log
+    rm ${D}${libdir}/rustlib/manifest*
+}
+
+EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
+rust_do_install:class-target() {
+    export PSEUDO_UNLOAD=3D1
+    rust_runx install
+    rust_runx install clippy
+    rust_runx install rustfmt
+    unset PSEUDO_UNLOAD
+
+    install -d ${D}${bindir}
+    for i in ${EXTRA_TOOLS}; do
+        cp =
build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i =
${D}${bindir}
+        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+    done
+
+    install -d ${D}${libdir}/rustlib/${RUST_HOST_SYS}
+    install -m 0644 ${WORKDIR}/rust-targets/${RUST_HOST_SYS}.json =
${D}${libdir}/rustlib/${RUST_HOST_SYS}/target.json
+
+    chown root:root ${D}/ -R
+    rm ${D}${libdir}/rustlib/uninstall.sh
+    rm ${D}${libdir}/rustlib/install.log
+    rm ${D}${libdir}/rustlib/manifest*
+}
+
+addtask do_update_snapshot after do_patch
+do_update_snapshot[nostamp] =3D "1"
+
+# Run with `bitbake -c update_snapshot rust` to update =
`rust-snapshot.inc`
+# with the checksums for the rust snapshot associated with this =
rustc-src
+# tarball.
+python do_update_snapshot() {
+    import json
+    import re
+    import sys
+
+    from collections import defaultdict
+
+    with open(os.path.join(d.getVar("S"), "src", "stage0.json")) as f:
+        j =3D json.load(f)
+
+    config_dist_server =3D j['config']['dist_server']
+    compiler_date =3D j['compiler']['date']
+    compiler_version =3D j['compiler']['version']
+
+    src_uri =3D defaultdict(list)
+    for k, v in j['checksums_sha256'].items():
+        m =3D =
re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<=
arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
+        if m:
+            component =3D m.group('component')
+            arch =3D m.group('arch')
+            =
src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] =3D =
\"{v}\"")
+
+    snapshot =3D """\
+## This is information on the rust-snapshot (binary) used to build our =
current release.
+## snapshot info is taken from rust/src/stage0.json
+## Rust is self-hosting and bootstraps itself with a pre-built previous =
version of itself.
+## The exact (previous) version that has been used is specified in the =
source tarball.
+## The version is replicated here.
+
+SNAPSHOT_VERSION =3D "%s"
+
+""" % compiler_version
+
+    for arch, components in src_uri.items():
+        snapshot +=3D "\n".join(components) + "\n\n"
+
+    snapshot +=3D """\
+SRC_URI +=3D " \\
+    =
${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-snaps=
hot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+    =
${RUST_DIST_SERVER}/dist/${RUSTC_SNAPSHOT}.tar.xz;name=3Drustc-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+    =
${RUST_DIST_SERVER}/dist/${CARGO_SNAPSHOT}.tar.xz;name=3Dcargo-snapshot-${=
RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \\
+"
+
+RUST_DIST_SERVER =3D "%s"
+
+RUST_STD_SNAPSHOT =3D =
"rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+RUSTC_SNAPSHOT =3D =
"rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+CARGO_SNAPSHOT =3D =
"cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
+""" % config_dist_server
+
+    with open(os.path.join(d.getVar("THISDIR"), "rust-snapshot.inc"), =
"w") as f:
+        f.write(snapshot)
+}
+
+RUSTLIB_DEP:class-nativesdk =3D ""
+
+# musl builds include libunwind.a
+INSANE_SKIP:${PN} =3D "staticdev"
+
+BBCLASSEXTEND =3D "native nativesdk"
+
+# Since 1.70.0 upgrade this fails to build with gold:
+# http://errors.yoctoproject.org/Errors/Details/708196/
+# ld: error: version script assignment of  to symbol =
__rust_alloc_error_handler_should_panic failed: symbol not defined
+LDFLAGS +=3D "${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', =
'-fuse-ld=3Dbfd', '', d)}"
--=20
2.34.1


