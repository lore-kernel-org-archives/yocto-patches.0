Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284BC55174
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4468.1785497602075568044
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F4JDzfeO;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff20870ac7so5899896d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497601; x=1786102401; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t3tVjuh/SjlxlW8o4EOqRU6VH7aYyNbaPD5no3gfYaM=;
        b=F4JDzfeOEhBZkusjThZyE05OA96DLIjQdg4dGDrlzS5kRP453o1Ij4t1rHULN4iluh
         m+br2C16zneghdAhS3lh4XIApgTwZv3CzaOqdC7bIV8qiG97P7rT9GDqEUKrfyZf4wB/
         xVBeJFcw42xAuGhYM7aHVxTUBEKdGkzd6MZIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497601; x=1786102401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t3tVjuh/SjlxlW8o4EOqRU6VH7aYyNbaPD5no3gfYaM=;
        b=IY4W6cZ/B/Wj3Gn2t6UbPbadzEkzGO18giWyL6AAmIL0I99syU7SsuvHq0d0jRDh0k
         pR/dyVm5QYFFj9Zg4mxug20tpQb2LgvPLfxNJd58Q3mkaN8kQVWu6IUiibiQfm1ENjev
         bMLW0Q/d3y4hwW6jo0x3iVKZhc8zDHfoImUand4MNGZF28GjWULAr6F+aznxqkek8t6w
         foyyZkDno/jruYyDZ1cEKW7jcU7KIkH0loBadihGKzFsVrhzH62buApMB9T35S1JOfhc
         3vDodSm3ViTRThdDG8CRHiYtRhA86iiZUwAgGolgvgS50fZV5e6ZLOLh6uvnVxVQUk1L
         94dA==
X-Gm-Message-State: AOJu0Yz9YxWD7LtSCxE4inmN5zDc0QYU0RUtjktK5L41MWHHDVGZOoH+
	cMrOagkQK4yl30affWZcPb/1/iJ1bq1DjUVFwmktkPfno9KftfS/BWusjuZIiW71roQO/oOprQ9
	6ZPBk
X-Gm-Gg: AR+sD10N+t/IUa3Lz5206b5Ur97PNi8xR0L0PPn7sruT4YqcoXiKgc4OSR5eKDxU/EK
	6TfjQK037gThKIOaCZ/IL5fw80E+u7TaCyWp31ppt15qYrmKUoLzOByHRJmdubTbzluoF0zGugd
	iY4JxyL0y7tSzuzI9EV1979nNpkd7ma+1y7UDYB7E5FHLKh/BhpH9NGBBLOxWeJoyK5ZJksaz0S
	rRorTd47hDre9jXLRjyz2TjZwqoKqKF2WsyuXKGcqzltrI2qj8Xqn9hLWk5jagtCVFNIBpS7k0o
	4c+5ru6yHY3vt3M/2gP5GMWdzj2/d+oVdA6zwzuM7yVZ0WYvpl2Y2CMwd7ef3EXlakWxT/gn97G
	LTpbtrHUfhHZ4ac0Z+yLETvoJU8pM4VJwvrkrpfLG5p6f3Ts+V8UYqYcLZKIRSwUEFYaydzOyF9
	stMscord5dNfJ9F76HuyFg0re68BCCUDmBIzB7xZ/+rkTL/i1kIJ+/D52I69oyvMk9G7yi5x5rx
	2bVz4yxMHBwBRg7wSZUGrWlK9DvHFqAkcD4xPXLOi2ORASwHQQpwrx+51osHLQsS34cEnoTdn+9
	nhM0fG8j8AyzD9Any46IQ7RJQA==
X-Received: by 2002:a05:620a:a719:b0:92e:da7b:561b with SMTP id af79cd13be357-93496592073mr187047585a.19.1785497600433;
        Fri, 31 Jul 2026 04:33:20 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:20 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 04/35] rust: Upgrade 1.92.0 -> 1.93.0
Date: Fri, 31 Jul 2026 07:32:34 -0400
Message-ID: <290af0a377e6adb22861c742ab8cec67d54703ad.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4580

From: Hemanth Kumar M D <Hemanth.KumarMD@windriver.com>

https://blog.rust-lang.org/2026/01/22/Rust-1.93.0/
Rust changes: https://github.com/rust-lang/rust/releases/tag/1.93.0
Cargo changes: https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-193-2026-01-22

* rust-oe-selftest.patch updated for 1.93:
  Renamed UI test directive from add-core-stubs to add-minicore as in
  https://github.com/rust-lang/rust/commit/3796f7de57f5d4cf4325d1f13aeb07fdaa57983b

* OE-selftests:
  - Exclude src/tools/remote-test-client from test suite.
    This unit test modifies the TEST_DEVICE_ADDR environment variable,
    which breaks the OE test harness that uses the same variable for
    QEMU remote testing. Filed a bug with upstream:
    https://github.com/rust-lang/rust/issues/151823

  - Enable +v8a feature for cortexa57.
    Rust 1.93.0 added a regression test (PR #149549) to verify that the
    ARMv8-A system register ttbr0_el2 is recognized in inline assembly.
    This addresses issue #97724 where LLVM wasn't recognizing ttbr0_el2
    as a valid register. Upstream Rust enables +v8a by default for all
    AArch64 targets (PR #105026), but Yocto's custom target specification
    doesn't inherit this. Adding +v8a ensures LLVM recognizes ARMv8-A
    system registers, fixing the test failure.

    Related upstream links:
    - PR #149549: https://github.com/rust-lang/rust/pull/149549
    - Issue #97724: https://github.com/rust-lang/rust/issues/97724
    - PR #105026: https://github.com/rust-lang/rust/pull/105026

Test results:

rust v1.93.0
+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  | 21,689 |   646   |
| qemux86     | 21,439 |   896   |
| qemuarm64   | 21,495 |   840   |
| qemuarm     | 21,421 |   914   |
| qemuriscv64 | 21,466 |   869   |
+-------------+--------+---------+

Test results difference (1.93.0 - 1.92.0):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |  +205  |   +33   |
| qemux86     |  +205  |   +33   |
| qemuarm64   |  +206  |   +32   |
| qemuarm     |  +205  |   +33   |
| qemuriscv64 |  +205  |   +33   |
+-------------+--------+---------+

Signed-off-by: Hemanth Kumar M D <Hemanth.KumarMD@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ee1a997f0fa7a7bc42d3d38f994e3701295095fc)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass     |  2 +
 conf/layer.conf                               |  2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  1 +
 .../rust/{cargo_1.92.0.bb => cargo_1.93.0.bb} |  0
 .../rust/files/rust-oe-selftest.patch         |  2 +-
 ...ibstd-rs_1.92.0.bb => libstd-rs_1.93.0.bb} |  0
 ....92.0.bb => rust-cross-canadian_1.93.0.bb} |  0
 ...ust-llvm_1.92.0.bb => rust-llvm_1.93.0.bb} |  0
 recipes-devtools/rust/rust-snapshot.inc       | 78 +++++++++----------
 recipes-devtools/rust/rust-source.inc         |  2 +-
 recipes-devtools/rust/rust-source.inc.orig    | 17 ++++
 .../rust/{rust_1.92.0.bb => rust_1.93.0.bb}   |  0
 12 files changed, 62 insertions(+), 42 deletions(-)
 rename recipes-devtools/rust/{cargo_1.92.0.bb => cargo_1.93.0.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.92.0.bb => libstd-rs_1.93.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.92.0.bb => rust-cross-canadian_1.93.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.92.0.bb => rust-llvm_1.93.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/rust-source.inc.orig
 rename recipes-devtools/rust/{rust_1.92.0.bb => rust_1.93.0.bb} (100%)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 0f1e2e1..8fda878 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -77,6 +77,8 @@ def llvm_features_from_tune(d):
         f.append("+a15")
     if 'cortexa17' in feat:
         f.append("+a17")
+    if 'cortexa57' in feat:
+        f.append("+v8a")
     if ('riscv64' in feat) or ('riscv32' in feat):
         f.append("+a,+c,+d,+f,+m")
     return f
diff --git a/conf/layer.conf b/conf/layer.conf
index 32a3729..6c01a40 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.92.0%"
+RUSTVERSION ?= "1.93.0%"
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 79e0dae..afe5b37 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -70,6 +70,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'src/tools/coverage-dump',
                             'src/tools/jsondoclint',
                             'src/tools/lint-docs',
+                            'src/tools/remote-test-client',
                             'src/tools/replace-version-placeholder',
                             'src/tools/rust-analyzer',
                             'src/tools/rustdoc-themes',
diff --git a/recipes-devtools/rust/cargo_1.92.0.bb b/recipes-devtools/rust/cargo_1.93.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.92.0.bb
rename to recipes-devtools/rust/cargo_1.93.0.bb
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index d1fba81..dc4ed9d 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -207,7 +207,7 @@ index 551485469d3..575db924968 100644
 --- a/tests/ui/abi/rust-cold-works-with-rustic-args.rs
 +++ b/tests/ui/abi/rust-cold-works-with-rustic-args.rs
 @@ -1,6 +1,7 @@
- //@ add-core-stubs
+ //@ add-minicore
  //@ build-pass
  //@ compile-flags: -Clink-dead-code=true
 +//@ ignore-riscv64
diff --git a/recipes-devtools/rust/libstd-rs_1.92.0.bb b/recipes-devtools/rust/libstd-rs_1.93.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.92.0.bb
rename to recipes-devtools/rust/libstd-rs_1.93.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.92.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.93.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.92.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.93.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.92.0.bb b/recipes-devtools/rust/rust-llvm_1.93.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.92.0.bb
rename to recipes-devtools/rust/rust-llvm_1.93.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index 4314734..7a0049c 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.91.0"
+SNAPSHOT_VERSION = "1.92.0"
 
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "f3ea3c964b7f3b884337f2d411764032bbd1722d7f55592a547cbb29afd87c03"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "ff23dc81f796d64e34e866a44fd0bcae726e34014835369b8f9393a544167eca"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "003d7008219ca0d225ad1dfa301f7c079b123499430ee0780c85782e0878eeff"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "a5f8bd961fb30962144d2f68be0bdd1014cf07110323087b0d6a68251a7a4eca"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "7c8706fad4c038b5eacab0092e15db54d2b365d5f3323ca046fe987f814e7826"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "ce2ab42c09d633b0a8b4b65a297c700ae0fad47aae890f75894782f95be7e36d"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "cb2ce6be6411b986e25c71ad8a813f9dfbe3461738136fd684e3644f8dd75df4"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "333ab38c673b589468b8293b525e5704fb52515d9d516ee28d3d34dd5a63d3c3"
 
-SRC_URI[rustc-snapshot-i686.sha256sum] = "bf718b184d6ace8fab0012835d129130a6dd6a8d78f4f742ae9308a86b96dfc5"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "059fe4b9802c3cb64b539cc501ff5e64f8d750573009c3004fd0b583b3f50d39"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "92486e31c070667681328ad57dd3bd4ca1e3d37958540d622b2afda9b67fbe3d"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "14cae2980accb8536ae700bb7ec6a3b540a06d84e7a4c71db1c7f05a17b1edbd"
+SRC_URI[rustc-snapshot-i686.sha256sum] = "c1c920cd59e255e5dcf844af22b80483fe4b04ff04f143be6da69314bd6733f8"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "abc840631a4462a4c8ec61341110ff653ab2ef86ef3b10f84489d00cc8a9310d"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "63001bbde1c036fae9ad624807bfb18117c7e7cb4a04de81adc4acc7e8580c07"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "f21090ddb01503ab7e326ff8b1ab44121611121e83572aa2dba2c5ceffe12d22"
 
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "04bdbb954f48fcd0b125fbddbf3e59841ec81c58ff858471f7977c8343d9a73c"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "cb0c3c2704add4d1271713ff87e1b7a8a4f756b4dc9f580b62953532efd0f7b9"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "9437727091d30d73a987e2c56463a2de4f01fb69cfd229617e2f8a7d8de5c05a"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "060a0eb3ee236e8a3bfb2cad9495165d755ea60d32e62ce85f12ad17c26afedf"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "6207ea209b332c01437fe742c2ef2bc914c88b6d4f9a23a43bc01ad924f6e4a8"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "62e2568ebf6f1addc750a8c32dd1fa4fef8d27679cbac33b837afeb54f204819"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "32f4b393f1471d7d50c9a50512f02116187b3ea6a885c26ff2d74f87fa72baa8"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "70783e0b31682938db53b78f87c948acfe589e3ece5dee6ae6aa5b667a384f3c"
 
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "c625de10cbfd21031f71fa6fdd50ccaffd449744614ef1f57ee3cefe80c57792"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "d5ecd84b78eefaf30fb65ec169af1806bd06d0b5bbe166bf010b058c9c59d27f"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "1f8f0ac1b05acb7cc50592ca39ec78e374093a0701405e8ea1894bb64a7422cd"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "425e5a1a72cc20c476416682cb5df4222c0b9c28fbb9818d4d8f505ccea578e3"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "961cb6b8c2b5e969ad8eb0256fee43b88608b27310d946a7df3c9e9577139cae"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "c3e809a324b00eb53096c58df38645bb496c6560de334dfe04ed0b77c0605aaa"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "1249c64f95d8187b3a89cf8429329bdbc98f53a9fc538e898c95c487e3234d90"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "93ed9fdd6fc2655c7789ed096d57a47178532b6bda1ec4480adca7920563e934"
 
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "139a077f72197ce73031dae7cd2156fb6718b09fe9a3f4008266d34fb8d09ae6"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "ac046a72a957bf9fd1213e95d46d7ca431a6704f63e99c759ccdd9ae7c07f7d9"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "abc14cced999e0d5f0ec75f10af33998dcaef39fab27b8e2c63b93ca0b79f2ab"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "b8129667c5b30963698466b7edeef4c5a1c869e78b5f9218fcf1426defa5cea9"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "357dd4745f978080d35dbb6192ecfea331abbb93d88be7d70407856b30722a40"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "2ce706afa4a46b6773340854de877fc63618a40e351298a4e3da8eb482619863"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "e94a8f97c3143158e285b4f8ade1fae844961caca30c0eeed44f6c14da484f05"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "7912584254f455b90ed6ce6089c4efded33bb753d1bf948286ef2f4f782d2f30"
 
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "c526302dcf4f1627525b0eef3ef4181bea801f119c4a0963c3675b390cba164f"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "c79c071fd14ef094c1a2e750f19795e7e162f4237bf92299885c0d56fa6017fe"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "704bfa80ffeeafacb8f13043873e20e1b9c4a5e785ee6c5e7d0e5828fc1f0c8b"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "1571b18b39f97d808b9f10ed2697b9d87bc3959abf858bfcd3baf9eaf8d5d548"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "f48a214ff6fa36a77de8a0a2ee009be8aa48ba1533792450aca5edac29497606"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "eba59766c2d9805c0a1fc82fd723acbb36569e1bec1088c037bba84d965f70ba"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "49dd01f5d10e3f368181223db0fbf7dc191161f7d80a295de4909bf87e53da58"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "873047278043e6506f5c98b8f633a9b96dc49ff83869a86a151fe5b1b9455044"
 
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "7c3d4ceaa630ddb45bcd538c687637a349b2c3e18634a2b944178a7b4b42a4cc"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "7486237c83844d48ac96b67241ef0c1f4f702ceb74c44721f6f8660c3068dede"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "8946ea952e5a516e8bb6fd859d9798902877e01bd4508b717f8b9fd915019ad5"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "97feb6d6b2158b410a83c40d7eeba1e97220e505eae6666aa09d112665cc8dc1"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "729f4c074ccda30bff493fa94f255bcfcec1be594fecd8a4d0f57da845121c64"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "8ee20dcf3b1063fa6069b3ce85e1fcf42794dfa783263314865cb53fff42d9e4"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "e8708d0a929ad15941ecde368e8a156911927a805b492afafc737124b6aa55d4"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "bdedabeedd48080e6ef70376c52338fbb45ff80d1fbb12a81aa2d8cabbb706c8"
 
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "073c3817f91ff425ffa141a6db215d54b50db5a8abe08fed593b7597687bdf94"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "454ecc9a53dda63762f3d1d92b7e4f4459c58c89d39a4178cce1fd9fd0ce09b5"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "3af10597a739402d6ecb3db85abaf62e12f7b298d2df6377c3c80e09a54f91b6"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "8d3bb8aa79abcfe5c24a37651d09dd356f994663699e65e7dd9978514a5ebf31"
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "6a8cf614a74f7469c70d32b378f0163633e6bbe19624b248b758501c5bcdfe84"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "ebf944dc95015498d322504a54e4f9cdb28590f7790aa3a9eb86d6cf4b6c93ff"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "a290edf359a5632dfda3b2325a309d9edeb58c97de97e3cc67274335b58adf05"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "41aa44f1cf37cac87b83e450eb19148c539ff266bb40dc146207ad5b9e1e1acc"
 
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "a7169e8cb6174af2f45717703370363d8de82ce55f6ccba185893045b9370874"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "89e6520b16c12b43526440298d2da0dcb70747c5cc2d0b8e47d39b5da9aeef49"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "7103c03fb8abe85b23307005a9dfe4f01c826a89945d84b96fa2d03fd4d2d138"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "0087c3d58d2fdeafa89830c299b1026c9f981b49835db89c922b3c6a299b3225"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "78b2dd9c6b1fcd2621fa81c611cf5e2d6950690775038b585c64f364422886e0"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "5f106805ed86ebf8df287039e53a45cf974391ef4d088c2760776b05b8e48b5d"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "e5e12be2c7126a7036c8adf573078a28b92611f5767cc9bd0a6f7c83081df103"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "2c1bf6e7da8ec50feba03fe188fc9a744ba59e2c6ece7970c13e201d08defa9a"
 
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "47e91cba208b1f87348e7b6a49274ebb4364651a4191fa67e6850e7813e26ad5"
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "8b984b31ffca1f27d32ee77ec2cc4c2ab59e72beab67bfce13bbd926dbea8715"
 
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "4f7bffb09cf5a0c25dda9b51811c60996eb1ae06a277c1e836980c21b3a44766"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "d85afb14120c3c7367338a565a920db653dccd4bc5062398791d7b62b89fd1fd"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 6a9b922..c5e5f6e 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,7 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "ebee170bfe4c4dfc59521a101de651e5534f4dae889756a5c97ca9ea40d0c307"
+SRC_URI[rust.sha256sum] = "e30d898272c587a22f77679f03c5e8192b5645c7c9ccc3407ad1106761507cea"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust-source.inc.orig b/recipes-devtools/rust/rust-source.inc.orig
new file mode 100644
index 0000000..6a9b922
--- /dev/null
+++ b/recipes-devtools/rust/rust-source.inc.orig
@@ -0,0 +1,17 @@
+RUST_VERSION ?= "${@d.getVar('PV').split('-')[0]}"
+
+SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;name=rust \
+            file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch;patchdir=${RUSTSRC} \
+            file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
+            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
+            file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
+            file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
+            file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
+            file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
+"
+SRC_URI[rust.sha256sum] = "ebee170bfe4c4dfc59521a101de651e5534f4dae889756a5c97ca9ea40d0c307"
+
+RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
+
+UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
+UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
diff --git a/recipes-devtools/rust/rust_1.92.0.bb b/recipes-devtools/rust/rust_1.93.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.92.0.bb
rename to recipes-devtools/rust/rust_1.93.0.bb
-- 
2.55.0


