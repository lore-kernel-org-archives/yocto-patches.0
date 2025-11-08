Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBECD13D2
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13110.1762632967141786989
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XiSOu93a;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-880570bdef8so20144906d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632966; x=1763237766; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+mUHl95REeBe0e+8dRPwvPkAgaNpqwN/gWgAsJjubs=;
        b=XiSOu93aCfnzXqQry+7IYrFA1+vSZIngcec/bat4L66cbDCAOYwn7zwb2uwumIn3fA
         Nrcl95PUuj2u1OsFal2NFfPJT5G5Jo1s+EGfZJPepDsiKdh8Sr1oP1wCyR7ezTbli6hp
         zJ7PZn1/nPxRJlSwPxgnmDPl0WY2C39XD373s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632966; x=1763237766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+mUHl95REeBe0e+8dRPwvPkAgaNpqwN/gWgAsJjubs=;
        b=W4rYqtaZ+KLFue7tfvK7m6q8YFDL7OH4Qih/E3s98iO4Qwaz4jrg9JnqGHaLf09AEx
         XsDyfjwLWKOUBb2TPONusUKWt6dh5OMFmETzX+M/SpO6H8OARLE/fYzMtv0/BryUiij3
         y4P4bgBo/29Zs2eGB997SkPDosqm07uDAs3Sq5evFTkbkSfxbi9MW4He1Pqed+d1k3QZ
         zWA3n44juHa4qkC7rUWZN2L0FidtC87A1NHLmuyP2r38sGV+KuS2AncugSGU1rZuOYjh
         QtbF/sOJIzq9Ac6y+Srpswkn48JhQ4AjRmNCgRKT3+nQQl6EYZqJSw5RrduEXBFwyTnC
         TDwQ==
X-Gm-Message-State: AOJu0Yx89QPW1S/3WgUAHm/ovBRzet1yPqN7SvTiwoeKxKj8aC1CcxV8
	qW5j3Dwbpvtrk5HrLmBXpsLa1rONwlpFy/5mmon1uVGbOrAUc01TuNEcq4w1fPuIIfAdWcb4FCj
	6Zy0s
X-Gm-Gg: ASbGncuL/xO3EHgLPhE8G88iAcFxVzR+bwkUmBnPp01oFUOxoI7eFJeZmcmEot13Nn+
	fBSKRpLPoRpWwTIj1Of3kArakmpnW8lXMOnK11S4jgjoAWyBoI6RytV/Q3QpVdVaI7guLjiPk7X
	w7IHB4149AdehE/991XENGNDXBlywYsBYQdsQV4jGPdak4pjWUbhg+Mq+sDh9o1k7M1WI3jMifZ
	Fs3S8xJK9bdvBUSX2nIVXydFoASokHZdRcRHIyU1aKNsmPjGF6YehGcMNqogXbIxhvYnX9llE+N
	b/NNCN+Oj1SR6FSFqbrpOjsw3SZYLIUs8taD5/8PyJyIC4MlEPdLKzN3KyjIIiuIC4hXAweHVtn
	bNvFr11XM+cmMTCELvoARk7E0Usw+mMhZgI7YyxPHhRcaaX626Dl9ZSpKPff6rM9nwg0I2B3s3i
	o1olRQZgNKg77UwJWy7ZaK9qEu8l1q7wOr8NDP7J8YNFTu9mAXKBIX6ComtG2NlV8=
X-Google-Smtp-Source: AGHT+IHmnPUqI1vqxJKcxuXr7X1WHLe5r/v47ijEHjAbb3TawTOjDJlqpXkI/+WH41cG4khptGaRBg==
X-Received: by 2002:a05:6214:27ea:b0:880:471f:2ecc with SMTP id 6a1803df08f44-8823860c3f7mr54156026d6.29.1762632964463;
        Sat, 08 Nov 2025 12:16:04 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:03 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 03/11] rust: Upgrade 1.89.0 -> 1.90.0
Date: Sat,  8 Nov 2025 15:15:45 -0500
Message-ID: <17bddf0bbf215e0c6df2e28d4b9b7d3c9dc8ea05.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2439

From: Yash Shinde <Yash.Shinde@windriver.com>

https://blog.rust-lang.org/2025/09/18/Rust-1.90.0/

* Recent changes in rustc require 'target-c-int-width' to be an integer,
  not a string. This fixes type consistency when generating target specs.
  https://github.com/rust-lang/rust/pull/142352.

* Rebase existing patches with v1.90.0.

* Drop merged patches with rust v1.90.0.
  - backport-fix-test-string-merging.patch
  https://github.com/rust-lang/rust/commit/2d51acd2fbcbadb6f30709c5dd305494=
d413d388

* The "remote-test-server" bin is now generated in stage1-tools-bin dir
  rather than stage2. Update the test suite accordingly.

  The tests/{assembly/codegen} dirs are renamed to
  tests/{assembly,codegen}-llvm. Update the test suite and
  patches accordingly.
  https://github.com/rust-lang/rust/pull/144249/commits

* Use "//@ ignore-riscv64" tag for tests failing on riscv-64 instead of pre=
vious
  "only-<target_arch>" tags.

  Test results summary:

   rust v1.90.0
   +-----------+--------+---------+
   | Machine   | Passed | Ignored |
   +-----------+--------+---------+
   | arm-32    | 29,517 |  1,529  |
   | arm-64    | 29,608 |  1,471  |
   | x86-32    | 29,508 |  1,507  |
   | x86-64    | 29,903 |  1,275  |
   | riscv-64  | 29,584 |  1,494  |
   +-----------+--------+---------+

   Test results difference (1.90 - 1.89):
   +-----------+--------+---------+
   | Machine   | Passed | Ignored |
   +-----------+--------+---------+
   | arm-32    |  +278  |   +61   |
   | arm-64    |  +279  |   +59   |
   | x86-32    |  +277  |   +58   |
   | x86-64    |  +419  |   +50   |
   | riscv-64  |  +280  |   +58   |
   +-----------+--------+---------+

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 86d09ec9cdbcea6e076ebac6e1243f9e20fb4378)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass            |   2 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  10 +-
 .../rust/{cargo_1.89.0.bb =3D> cargo_1.90.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |   8 +-
 ...lain-syscalls-as-their-time64-varian.patch |   8 +-
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  12 +-
 .../backport-fix-test-string-merging.patch    |  27 ---
 ...epro-issue-fix-with-cc-crate-hashmap.patch |   4 +-
 .../rust/files/rust-oe-selftest.patch         | 189 ++++++++++++------
 ...ibstd-rs_1.89.0.bb =3D> libstd-rs_1.90.0.bb} |   0
 ....89.0.bb =3D> rust-cross-canadian_1.90.0.bb} |   0
 ...ust-llvm_1.89.0.bb =3D> rust-llvm_1.90.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 ++++----
 recipes-devtools/rust/rust-source.inc         |   3 +-
 .../rust/{rust_1.89.0.bb =3D> rust_1.90.0.bb}   |   0
 16 files changed, 193 insertions(+), 152 deletions(-)
 rename recipes-devtools/rust/{cargo_1.89.0.bb =3D> cargo_1.90.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/backport-fix-test-string-me=
rging.patch
 rename recipes-devtools/rust/{libstd-rs_1.89.0.bb =3D> libstd-rs_1.90.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.89.0.bb =3D> rust-cros=
s-canadian_1.90.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.89.0.bb =3D> rust-llvm_1.90.0.bb=
} (99%)
 rename recipes-devtools/rust/{rust_1.89.0.bb =3D> rust_1.90.0.bb} (100%)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-confi=
g.bbclass
index d45a932..c2d5d3e 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -369,7 +369,7 @@ def rust_gen_target(d, thing, wd, arch):
         bb.fatal("No rust target defined for %s" % arch_abi)
     tspec['max-atomic-width'] =3D int(d.getVarFlag('MAX_ATOMIC_WIDTH', arc=
h_abi))
     tspec['target-pointer-width'] =3D d.getVarFlag('TARGET_POINTER_WIDTH',=
 arch_abi)
-    tspec['target-c-int-width'] =3D d.getVarFlag('TARGET_C_INT_WIDTH', arc=
h_abi)
+    tspec['target-c-int-width'] =3D int(d.getVarFlag('TARGET_C_INT_WIDTH',=
 arch_abi))
     tspec['target-endian'] =3D d.getVarFlag('TARGET_ENDIAN', arch_abi)
     tspec['arch'] =3D arch_to_rust_target_arch(rust_arch)
     if "elf" in os:
diff --git a/conf/layer.conf b/conf/layer.conf
index 891852f..287f795 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
 LICENSE_PATH +=3D "${LAYERDIR}/files/common-licenses"
=20
-RUSTVERSION ?=3D "1.89.0%"
+RUSTVERSION ?=3D "1.90.0%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/case=
s/rust_mixin.py
index 653867f..95859a9 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -77,9 +77,9 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
                             'src/tools/test-float-parse',
                             'src/tools/suggest-tests',
                             'src/tools/tidy',
-                            'tests/assembly/asm/aarch64-outline-atomics.rs=
',
-                            'tests/codegen/issues/issue-122805.rs',
-                            'tests/codegen/thread-local.rs',
+                            'tests/assembly-llvm/asm/aarch64-outline-atomi=
cs.rs',
+                            'tests/codegen-llvm/issues/issue-122805.rs',
+                            'tests/codegen-llvm/thread-local.rs',
                             'tests/mir-opt/',
                             'tests/run-make',
                             'tests/run-make-fulldeps',
@@ -89,7 +89,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
                             'tests/ui/abi/stack-probes-lto.rs',
                             'tests/ui/abi/stack-probes.rs',
                             'tests/ui/codegen/mismatched-data-layouts.rs',
-                            'tests/codegen/rust-abi-arch-specific-adjustme=
nt.rs',
+                            'tests/codegen-llvm/rust-abi-arch-specific-adj=
ustment.rs',
                             'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and=
-split-debuginfo.rs',
                             'tests/ui/feature-gates/version_check.rs',
                             'tests/ui-fulldeps/',
@@ -107,7 +107,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OE=
PTestResultTestCase):
             # Copy remote-test-server to image through scp
             host_sys =3D get_bb_var("RUST_BUILD_SYS", "rust")
             ssh =3D SSHControl(ip=3Dqemu.ip, logfile=3Dqemu.sshlog, user=
=3D"root")
-            ssh.copy_to(builddir + "/build/" + host_sys + "/stage2-tools-b=
in/remote-test-server","~/")
+            ssh.copy_to(builddir + "/build/" + host_sys + "/stage1-tools-b=
in/remote-test-server","~/")
             # Execute remote-test-server on image through background ssh
             command =3D '~/remote-test-server --bind 0.0.0.0:12345 -v'
             sshrun=3Dsubprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=
=3D/dev/null', '-o',  'StrictHostKeyChecking=3Dno', '-f', "root@%s" % qemu.=
ip, command), shell=3DFalse, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.=
PIPE)
diff --git a/recipes-devtools/rust/cargo_1.89.0.bb b/recipes-devtools/rust/=
cargo_1.90.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.89.0.bb
rename to recipes-devtools/rust/cargo_1.90.0.bb
diff --git a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-ri=
scv32gc-unknown-linux-g.patch b/recipes-devtools/rust/files/0001-Define-mor=
e-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
index 024d549..3a8ee0b 100644
--- a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
+++ b/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
@@ -111,15 +111,15 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 --- a/vendor/libc-0.2.169/.cargo-checksum.json
 +++ b/vendor/libc-0.2.169/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"e48a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49=
da9bef3b8d85f5454","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"647ea80df57c844de63e49629b9e13d0=
2e8dfdcb0e1ec3b301002e3ca5e6d461","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec=
8124aa442cc4676bcb2a85e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"6d1d40c1473a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31=
","src/lib.rs":"1171567598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f7529668=
8a565","src/macros.rs":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f9=
33bcf553a4fe3","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21f=
ed6737585490a1dce7a9d4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f=
4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"174e10b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228=
babe","src/trusty.rs":"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14=
513a402212c2","src/unix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082f=
f7b1f2e13c22a888fa8bdb1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c031=
6f72050f6fd82dbcbbc6258a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc882=
4e9123ec77237d37b64f133741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f=
17b1d52eb9b5228dc912955ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"9ef5040678d489522ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e=
7391ae266957c31878cb","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8=
c3e70f4c7c65425933eef04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3=
435f6860fc355abe7603ca7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105=
744b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"fafc7daab134d37ed26037=
3f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
b51bc534e9b5d31544207e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74=
c06e3f9b1a0b52ba0fc8ed6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed10517=
0d1e71fe8443229aeb9e2430","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
393fd4940dc44bddf3153fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix=
/linux_like/android/mod.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca0=
0ef45f6477c4a5d02b","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"695b717593cbd25=
4bf8250521a261d87a39824333f35a50b7c75f252eae5a7d6","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1=
fbc2a35f1efb092c725906","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"fb3086756cc7aa87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82=
cf3a65038c68","src/unix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92f=
b0a642dd6076caf32ae52daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb=
0f24820a0b9ccef9f68eb28e1bc57011ea701d57df63ed34","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac5=
4445d9841a0d57dcce83615add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc29=
6277daae6d0149aeac9b87860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe25=
05f48f7997abaf6e8551c655e","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"927c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4=
fec686ff","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"3fdcc6f28787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c88=
7","src/unix/nuttx/mod.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24a=
f6470669ffa1b6425","src/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023=
332b1cb6af1e8c66fa2dd9c4255439d52","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e16=
4e304f56dfff172e313098","src/unix/solarish/solaris.rs":"3a37167395881640117=
a37728ca848d1dbeb4286912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde1035929=
22ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"d02d216bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff7=
98a1b","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018c=
db5b6e9a2c0d3a2a34d9a6c095d8469272ca8f137e4336140962be3177","src/vxworks/ri=
scv64.rs":"16bff4f1c4eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfc=
c4d620c7ebfb122c613afb886ca8803fa4e128a20a"}
+-{"files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
8c559674e697c1c1d213d0c46",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"e48=
a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49da9bef3b8d85f5454","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.toml":"647ea80df57c844de63e49629b9e13d02e8dfdcb0e1ec3b301002e3ca5e6d46=
1","Cargo.toml.orig":"0ecb7fa67c89fdadd15d65f6495a98a8df9fa0c78f3f10a51ec91=
3c55d719051","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac022b5d=
2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672dbfe3=
004257ca8de708aac1415937a1","README.md":"38061c8bb600c2e01b48b662288cb11f38=
c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc711029460fcc4f7fd8e38c4=
87006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e9321ff995242e8cb0a49842=
54f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_width_ints.rs":"10eb30=
cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550ae66c","src/fuchsia/aa=
rch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de1857f7963453792c7161def=
","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec8124aa442cc4676bcb2a8=
5e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb25d6380f6df69ad91cf62=
efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs":"e63daa4085c6f6ab35=
d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/hermit.rs":"6d1d40c147=
3a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31","src/lib.rs":"11715=
67598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f75296688a565","src/macros.rs=
":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f933bcf553a4fe3","src/p=
sp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53678ef9529607ba3ea7","=
src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63d8b4d52823de2ccbba7eb=
49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21fed6737585490a1dce7a9d=
4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4f=
ba435b8ef7084777cb181d788e88","src/solid/mod.rs":"01116b18b9be6791fdf4ff572=
d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.rs":"bb0ce1331c61a28ca=
ea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/teeos/mod.rs":"174e10=
b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228babe","src/trusty.rs"=
:"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14513a402212c2","src/un=
ix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082ff7b1f2e13c22a888fa8bd=
b1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c0316f72050f6fd82dbcbbc62=
58a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod.rs":"9f20c77e86b812f=
f09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","src/unix/bsd/apple/b64/=
aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c22b51a23a4527b9404c948=
318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87fa6e2d79fb856ce314282=
bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b64/x86_64/mod.rs":"e03=
794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5a8593f4","src/unix/bs=
d/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc8824e9123ec77237d37b64f1=
33741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac3=
5fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/dra=
gonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65eb633bf6b7f1251a045670=
b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"aea276451dca89f086d01=
4b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix/bsd/freebsdlike/free=
bsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b47f452493b430f295d7264=
af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d047=
55a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/f=
reebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d2671=
9290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"400f1=
8465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a5179391","src/unix/bsd/=
freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f3403ac934dff1fc70c666087=
de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlike/freebsd/freebsd12/x=
86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21=
","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"e6f3430838d94dd17e35=
9419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/unix/bsd/freebsdlike/fre=
ebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa1400=
4692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"7d23=
d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0b60eab","src/unix/bsd=
/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fc=
d6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd=
15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925a4c13c8afc057ce6b4d8f=
e","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc77=
9efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike=
/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f17b1d52eb9b5228dc9129=
55ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36912b999e0571adccc=
06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/unix/bsd/freebsdlike/fr=
eebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67779e6cdac157d64b5b9f7=
c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"b6bbfb556ed35c38=
97a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src/unix/bsd/freebsdlike=
/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432f84cef1442e3bf5438c3b=
a9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"9ef5040678d48952=
2ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src/unix/bsd/freebsdlike=
/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670cefe3bac88782de879f8"=
,"src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f28f84ff8f0d919d2dbc37=
055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089eef37c5888f59479c49614=
15b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/netbsdlike/netbsd/aar=
ch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e7391ae266957c31878cb"=
,"src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4879648cac3d462e0daa7e=
980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdlike/netbsd/mips.rs":"=
8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d802b5b5782","src/unix=
/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8c3e70f4c7c65425933eef=
04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"42f66be=
7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2bed68","src/unix/bsd/ne=
tbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3435f6860fc355abe7603c=
a7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"78985b140b=
0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82","src/unix/bsd/netbs=
dlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c483998756a07b7c5d4b86348fc3f=
79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"b60e896c10ba86a59b=
13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/unix/bsd/netbsdlike/op=
enbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f1cc9ca26217d7144f000f=
8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8c975d4b94a8b8d11dcc52=
24db628997003a8d289f12fb12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd=
/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd39442c9f74a7f231c43eca=
48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105744b4509e528baa14bcdc=
0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/netbsdlike/openbsd/power=
pc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","=
src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6ccd830b8bbe94c9be8a92a7=
19105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/netbsdlike/openbsd/risc=
v64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d7240aa57f258bb4546fa9c",=
"src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287afbaa2c5df9d48c94e837=
4a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/netbsdlike/openbsd/x86.r=
s":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c3362f0b6423fa3c7a","src/=
unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d28fe546d35e98ae1dc671a=
a253663f9923d147548233def260a","src/unix/haiku/b32.rs":"c56aa69ed87dded0d29=
7d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/unix/haiku/b64.rs":"d44=
daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6033a07e","src/unix/ha=
iku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5aaecd2dfc0ac0f563eac86=
f3","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3a8177cc0fd88ba14=
7c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8ef6b462bc32b327044052=
6f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hurd/b32.rs":"3e79bb09b=
66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6a","src/unix/hurd/b64=
.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f4929197366f28e8c22815","sr=
c/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de976dec369104a14da1e3b20=
a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"b51bc534e9b5d31544207=
e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix/linux_like/android/b=
32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8f0d8325ecaf2f7ca70312=
e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74c06e3f9b1a0b52ba0fc8e=
d6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linux_like/android/b64/aa=
rch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3e27132d3e9549aee8f5e3=
b1d0","src/unix/linux_like/android/b64/mod.rs":"186edde6293b874c5ae96e10be7=
60f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux_like/android/b64/ris=
cv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed105170d1e71fe8443229aeb9e2=
430","src/unix/linux_like/android/b64/x86_64/mod.rs":"393fd4940dc44bddf3153=
fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix/linux_like/android/m=
od.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca00ef45f6477c4a5d02b","=
src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a578a68237f985409=
0eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscripten/mod.rs":"3=
58a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2ed9a1cf77","src/unix/=
linux_like/linux/arch/generic/mod.rs":"695b717593cbd254bf8250521a261d87a398=
24333f35a50b7c75f252eae5a7d6","src/unix/linux_like/linux/arch/mips/mod.rs":=
"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e6401b4442515b","src/uni=
x/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac76ad92e5ae36b2d06=
44203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/powerpc/mod.rs":"92=
c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69e32123e0","src/unix/l=
inux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678b180ff9903e0d5d529c81=
12d01bd135f53fce742f433a6","src/unix/linux_like/linux/gnu/b32/arm/mod.rs":"=
7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fbfcff1910be","src/unix=
/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3336a0f6a279c0cd6a95c7=
9ccb86443848fc96ddc1026279696","src/unix/linux_like/linux/gnu/b32/m68k/mod.=
rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29678b69170dd1a1f","src=
/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd7401743cad8e6e03ddee156=
86bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_like/linux/gnu/b32/mod.=
rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa5539b763609e87d70","src=
/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a11848747e0a480407ba7379be=
fef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_like/linux/gnu/b32/riscv=
32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1fbc2a35f1efb092c72590=
6","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5e2e2d605ca74af943e539=
c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/linux_like/linux/gnu/=
b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fae36edea27c3abe1504e73=
f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs":"47cc25f28c4be=
a16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","src/unix/linux_like/l=
inux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd982734c0feb9d15cb3a6a9a6b=
029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b64/aarch64/mod.rs":"2=
4f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef05dcd6e027","src/unix/=
linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c252104151390dfc521ffd6=
3e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_like/linux/gnu/b64/mip=
s64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6653a981963b1cc288fa75=
16","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a981ff02176331f2402806e=
6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux_like/linux/gnu/b64/p=
owerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1ca9b400fa2c5fb9187189a=
8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs":"fb3086756cc7aa=
87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","src/unix/linux_like/li=
nux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab300cd98922545c88b19682=
06442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc64/mod.rs":"006ce4296=
9449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e4","src/unix/linux_li=
ke/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2d5a28fecbeff276faad5c=
b79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu/b64/x86_64/not_x32.r=
s":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f695c4f708d81f17","src/=
unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9bd8d9fe13eeb9b27a92baf=
715c9d77af1229262fce93362da72f11fe5","src/unix/linux_like/linux/gnu/mod.rs"=
:"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82cf3a65038c68","src/un=
ix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92fb0a642dd6076caf32ae52=
daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b32/arm/mod.rs":"64d2f8=
1625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a4905","src/unix/linux=
_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7247a471255181e2245882=
5c61b5464fafd36a31a8545","src/unix/linux_like/linux/musl/b32/mips/mod.rs":"=
b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c384d6159cfa","src/unix=
/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbaddb821588645590a7a11d22=
c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/musl/b32/powerpc.rs":=
"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab92631b53c82f","src/uni=
x/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9a0f312cc2336cac38ecd5=
390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_like/linux/musl/b32/x86=
/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53b6587154e546b09d3efc"=
,"src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"8e718cec34d53079e9c84=
1084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix/linux_like/linux/mus=
l/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1c35e686d8d15f781ce78f=
83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/mips64.rs":"be1c8bd1f=
406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016c","src/unix/linux_li=
ke/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0f1a88747bdb5207658343=
ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/powerpc64.rs":"eb4d57=
a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63ac802","src/unix/linux=
_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb0f24820a0b9ccef9f68eb=
28e1bc57011ea701d57df63ed34","src/unix/linux_like/linux/musl/b64/s390x.rs":=
"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498cf331af17fd1","src/uni=
x/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3cb6c3b48d2413a73961db=
7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_like/linux/musl/lfs64.rs=
":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/u=
nix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a39573ae9a0ba071500d0e9=
66a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/uclibc/arm/mod.rs":"1b=
0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6d5d6fea3","src/unix/l=
inux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db5148d5a78988010087954=
1563fa1de8bf5feb792341b4270244968","src/unix/linux_like/linux/uclibc/mips/m=
ips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151cc1085735613791e60386=
5a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f=
25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix/linux_like/linux/ucl=
ibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee3b341cb3e98c435196d19=
1e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"076ad477f0786a2e4944=
cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/unix/linux_like/linux/uc=
libc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac54445d9841a0d57dcce836=
15add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/other.rs":"12f8d404986=
2fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def","src/unix/linux_like=
/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdba3d5d05b9e19d8f077ea"=
,"src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc296277daae6d0149aeac9b8=
7860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6ac7f8b381f8699b3604cf4=
60a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/arm/mod.rs":"ddea29e7c=
e40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac8","src/unix/newlib/e=
spidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe2505f48f7997abaf6e8551c=
655e","src/unix/newlib/generic.rs":"182e584f14e0984934130425dd2be0781ca2c13=
1449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mod.rs":"a484d84f56fd5b=
49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","src/unix/newlib/mod.rs=
":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/u=
nix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eebc8ac57b2f0ef0111abdcd=
5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3f=
cbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/newlib/vita/mod.rs":"92=
7c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4fec686ff","src/unix/n=
to/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100ed561e560665983359b7b9=
43075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d86977403023bb1645c83ce=
c2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3=
536709704715a49905024b6c520696a65086f9","src/unix/nto/x86_64.rs":"3fdcc6f28=
787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c887","src/unix/nuttx/mo=
d.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24af6470669ffa1b6425","s=
rc/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023332b1cb6af1e8c66fa2dd=
9c4255439d52","src/unix/solarish/compat.rs":"c02a88918852b7a9c60e45a34f7b00=
3901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish/illumos.rs":"cc7104f=
002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4af1","src/unix/solari=
sh/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e164e304f56dfff172e31309=
8","src/unix/solarish/solaris.rs":"3a37167395881640117a37728ca848d1dbeb4286=
912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0d=
ab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix/solarish/x86_64.rs":=
"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde103592922ec15295ef","src/uni=
x/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e=
4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc511cd02557e506c21fed673=
7585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs":"acb7968ce99fe3f4ab=
df39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/vxworks/mod.rs":"d02d2=
16bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff798a1b","src/vxworks/p=
owerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e8=
8","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c21fed6737585490a1dce7=
a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018cdb5b6e9a2c0d3a2a34d9a=
6c095d8469272ca8f137e4336140962be3177","src/vxworks/riscv64.rs":"16bff4f1c4=
eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069","src/vxworks/x86.rs=
":"552f007f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/v=
xworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98=
ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e00f0affdce627d9165681=
c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d28=
2741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":"320ddf761f731c24a27e=
061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/windows/mod.rs":"282daea=
cf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af440","src/windows/msv=
c/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00=
","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772abc3ca20dc4b09b5878098=
0b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85=
a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfcc4d620c7ebfb122c613af=
b886ca8803fa4e128a20a"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"e48a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49=
da9bef3b8d85f5454","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"647ea80df57c844de63e49629b9e13d0=
2e8dfdcb0e1ec3b301002e3ca5e6d461","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec=
8124aa442cc4676bcb2a85e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"6d1d40c1473a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31=
","src/lib.rs":"1171567598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f7529668=
8a565","src/macros.rs":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f9=
33bcf553a4fe3","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21f=
ed6737585490a1dce7a9d4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f=
4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"174e10b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228=
babe","src/trusty.rs":"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14=
513a402212c2","src/unix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082f=
f7b1f2e13c22a888fa8bdb1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c031=
6f72050f6fd82dbcbbc6258a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc882=
4e9123ec77237d37b64f133741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f=
17b1d52eb9b5228dc912955ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"9ef5040678d489522ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e=
7391ae266957c31878cb","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8=
c3e70f4c7c65425933eef04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3=
435f6860fc355abe7603ca7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105=
744b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"fafc7daab134d37ed26037=
3f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
b51bc534e9b5d31544207e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74=
c06e3f9b1a0b52ba0fc8ed6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed10517=
0d1e71fe8443229aeb9e2430","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
393fd4940dc44bddf3153fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix=
/linux_like/android/mod.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca0=
0ef45f6477c4a5d02b","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"645e12265e1171c=
9fa2fb3fb5dd58891cc1926c581bb0f7a94ed665daf813f5e","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1=
fbc2a35f1efb092c725906","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"fb3086756cc7aa87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82=
cf3a65038c68","src/unix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92f=
b0a642dd6076caf32ae52daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb=
0f24820a0b9ccef9f68eb28e1bc57011ea701d57df63ed34","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac5=
4445d9841a0d57dcce83615add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc29=
6277daae6d0149aeac9b87860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe25=
05f48f7997abaf6e8551c655e","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"927c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4=
fec686ff","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"3fdcc6f28787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c88=
7","src/unix/nuttx/mod.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24a=
f6470669ffa1b6425","src/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023=
332b1cb6af1e8c66fa2dd9c4255439d52","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e16=
4e304f56dfff172e313098","src/unix/solarish/solaris.rs":"3a37167395881640117=
a37728ca848d1dbeb4286912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde1035929=
22ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"d02d216bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff7=
98a1b","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018c=
db5b6e9a2c0d3a2a34d9a6c095d8469272ca8f137e4336140962be3177","src/vxworks/ri=
scv64.rs":"16bff4f1c4eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfc=
c4d620c7ebfb122c613afb886ca8803fa4e128a20a"}
++{"files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
8c559674e697c1c1d213d0c46",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"e48=
a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49da9bef3b8d85f5454","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.toml":"647ea80df57c844de63e49629b9e13d02e8dfdcb0e1ec3b301002e3ca5e6d46=
1","Cargo.toml.orig":"0ecb7fa67c89fdadd15d65f6495a98a8df9fa0c78f3f10a51ec91=
3c55d719051","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac022b5d=
2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672dbfe3=
004257ca8de708aac1415937a1","README.md":"38061c8bb600c2e01b48b662288cb11f38=
c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc711029460fcc4f7fd8e38c4=
87006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e9321ff995242e8cb0a49842=
54f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_width_ints.rs":"10eb30=
cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550ae66c","src/fuchsia/aa=
rch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de1857f7963453792c7161def=
","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec8124aa442cc4676bcb2a8=
5e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb25d6380f6df69ad91cf62=
efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs":"e63daa4085c6f6ab35=
d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/hermit.rs":"6d1d40c147=
3a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31","src/lib.rs":"11715=
67598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f75296688a565","src/macros.rs=
":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f933bcf553a4fe3","src/p=
sp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53678ef9529607ba3ea7","=
src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63d8b4d52823de2ccbba7eb=
49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21fed6737585490a1dce7a9d=
4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4f=
ba435b8ef7084777cb181d788e88","src/solid/mod.rs":"01116b18b9be6791fdf4ff572=
d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.rs":"bb0ce1331c61a28ca=
ea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/teeos/mod.rs":"174e10=
b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228babe","src/trusty.rs"=
:"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14513a402212c2","src/un=
ix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082ff7b1f2e13c22a888fa8bd=
b1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c0316f72050f6fd82dbcbbc62=
58a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod.rs":"9f20c77e86b812f=
f09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","src/unix/bsd/apple/b64/=
aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c22b51a23a4527b9404c948=
318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87fa6e2d79fb856ce314282=
bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b64/x86_64/mod.rs":"e03=
794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5a8593f4","src/unix/bs=
d/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc8824e9123ec77237d37b64f1=
33741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac3=
5fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/dra=
gonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65eb633bf6b7f1251a045670=
b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"aea276451dca89f086d01=
4b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix/bsd/freebsdlike/free=
bsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b47f452493b430f295d7264=
af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d047=
55a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/f=
reebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d2671=
9290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"400f1=
8465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a5179391","src/unix/bsd/=
freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f3403ac934dff1fc70c666087=
de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlike/freebsd/freebsd12/x=
86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21=
","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"e6f3430838d94dd17e35=
9419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/unix/bsd/freebsdlike/fre=
ebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa1400=
4692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"7d23=
d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0b60eab","src/unix/bsd=
/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fc=
d6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd=
15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925a4c13c8afc057ce6b4d8f=
e","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc77=
9efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike=
/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f17b1d52eb9b5228dc9129=
55ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36912b999e0571adccc=
06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/unix/bsd/freebsdlike/fr=
eebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67779e6cdac157d64b5b9f7=
c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"b6bbfb556ed35c38=
97a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src/unix/bsd/freebsdlike=
/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432f84cef1442e3bf5438c3b=
a9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"9ef5040678d48952=
2ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src/unix/bsd/freebsdlike=
/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670cefe3bac88782de879f8"=
,"src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f28f84ff8f0d919d2dbc37=
055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089eef37c5888f59479c49614=
15b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/netbsdlike/netbsd/aar=
ch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e7391ae266957c31878cb"=
,"src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4879648cac3d462e0daa7e=
980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdlike/netbsd/mips.rs":"=
8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d802b5b5782","src/unix=
/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8c3e70f4c7c65425933eef=
04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"42f66be=
7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2bed68","src/unix/bsd/ne=
tbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3435f6860fc355abe7603c=
a7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"78985b140b=
0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82","src/unix/bsd/netbs=
dlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c483998756a07b7c5d4b86348fc3f=
79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"b60e896c10ba86a59b=
13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/unix/bsd/netbsdlike/op=
enbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f1cc9ca26217d7144f000f=
8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8c975d4b94a8b8d11dcc52=
24db628997003a8d289f12fb12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd=
/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd39442c9f74a7f231c43eca=
48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105744b4509e528baa14bcdc=
0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/netbsdlike/openbsd/power=
pc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","=
src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6ccd830b8bbe94c9be8a92a7=
19105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/netbsdlike/openbsd/risc=
v64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d7240aa57f258bb4546fa9c",=
"src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287afbaa2c5df9d48c94e837=
4a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/netbsdlike/openbsd/x86.r=
s":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c3362f0b6423fa3c7a","src/=
unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d28fe546d35e98ae1dc671a=
a253663f9923d147548233def260a","src/unix/haiku/b32.rs":"c56aa69ed87dded0d29=
7d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/unix/haiku/b64.rs":"d44=
daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6033a07e","src/unix/ha=
iku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5aaecd2dfc0ac0f563eac86=
f3","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3a8177cc0fd88ba14=
7c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8ef6b462bc32b327044052=
6f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hurd/b32.rs":"3e79bb09b=
66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6a","src/unix/hurd/b64=
.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f4929197366f28e8c22815","sr=
c/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de976dec369104a14da1e3b20=
a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"b51bc534e9b5d31544207=
e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix/linux_like/android/b=
32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8f0d8325ecaf2f7ca70312=
e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74c06e3f9b1a0b52ba0fc8e=
d6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linux_like/android/b64/aa=
rch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3e27132d3e9549aee8f5e3=
b1d0","src/unix/linux_like/android/b64/mod.rs":"186edde6293b874c5ae96e10be7=
60f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux_like/android/b64/ris=
cv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed105170d1e71fe8443229aeb9e2=
430","src/unix/linux_like/android/b64/x86_64/mod.rs":"393fd4940dc44bddf3153=
fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix/linux_like/android/m=
od.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca00ef45f6477c4a5d02b","=
src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a578a68237f985409=
0eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscripten/mod.rs":"3=
58a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2ed9a1cf77","src/unix/=
linux_like/linux/arch/generic/mod.rs":"645e12265e1171c9fa2fb3fb5dd58891cc19=
26c581bb0f7a94ed665daf813f5e","src/unix/linux_like/linux/arch/mips/mod.rs":=
"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e6401b4442515b","src/uni=
x/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac76ad92e5ae36b2d06=
44203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/powerpc/mod.rs":"92=
c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69e32123e0","src/unix/l=
inux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678b180ff9903e0d5d529c81=
12d01bd135f53fce742f433a6","src/unix/linux_like/linux/gnu/b32/arm/mod.rs":"=
7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fbfcff1910be","src/unix=
/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3336a0f6a279c0cd6a95c7=
9ccb86443848fc96ddc1026279696","src/unix/linux_like/linux/gnu/b32/m68k/mod.=
rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29678b69170dd1a1f","src=
/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd7401743cad8e6e03ddee156=
86bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_like/linux/gnu/b32/mod.=
rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa5539b763609e87d70","src=
/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a11848747e0a480407ba7379be=
fef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_like/linux/gnu/b32/riscv=
32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1fbc2a35f1efb092c72590=
6","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5e2e2d605ca74af943e539=
c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/linux_like/linux/gnu/=
b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fae36edea27c3abe1504e73=
f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs":"47cc25f28c4be=
a16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","src/unix/linux_like/l=
inux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd982734c0feb9d15cb3a6a9a6b=
029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b64/aarch64/mod.rs":"2=
4f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef05dcd6e027","src/unix/=
linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c252104151390dfc521ffd6=
3e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_like/linux/gnu/b64/mip=
s64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6653a981963b1cc288fa75=
16","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a981ff02176331f2402806e=
6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux_like/linux/gnu/b64/p=
owerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1ca9b400fa2c5fb9187189a=
8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs":"fb3086756cc7aa=
87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","src/unix/linux_like/li=
nux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab300cd98922545c88b19682=
06442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc64/mod.rs":"006ce4296=
9449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e4","src/unix/linux_li=
ke/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2d5a28fecbeff276faad5c=
b79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu/b64/x86_64/not_x32.r=
s":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f695c4f708d81f17","src/=
unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9bd8d9fe13eeb9b27a92baf=
715c9d77af1229262fce93362da72f11fe5","src/unix/linux_like/linux/gnu/mod.rs"=
:"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82cf3a65038c68","src/un=
ix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92fb0a642dd6076caf32ae52=
daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b32/arm/mod.rs":"64d2f8=
1625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a4905","src/unix/linux=
_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7247a471255181e2245882=
5c61b5464fafd36a31a8545","src/unix/linux_like/linux/musl/b32/mips/mod.rs":"=
b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c384d6159cfa","src/unix=
/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbaddb821588645590a7a11d22=
c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/musl/b32/powerpc.rs":=
"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab92631b53c82f","src/uni=
x/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9a0f312cc2336cac38ecd5=
390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_like/linux/musl/b32/x86=
/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53b6587154e546b09d3efc"=
,"src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"8e718cec34d53079e9c84=
1084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix/linux_like/linux/mus=
l/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1c35e686d8d15f781ce78f=
83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/mips64.rs":"be1c8bd1f=
406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016c","src/unix/linux_li=
ke/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0f1a88747bdb5207658343=
ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/powerpc64.rs":"eb4d57=
a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63ac802","src/unix/linux=
_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb0f24820a0b9ccef9f68eb=
28e1bc57011ea701d57df63ed34","src/unix/linux_like/linux/musl/b64/s390x.rs":=
"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498cf331af17fd1","src/uni=
x/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3cb6c3b48d2413a73961db=
7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_like/linux/musl/lfs64.rs=
":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/u=
nix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a39573ae9a0ba071500d0e9=
66a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/uclibc/arm/mod.rs":"1b=
0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6d5d6fea3","src/unix/l=
inux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db5148d5a78988010087954=
1563fa1de8bf5feb792341b4270244968","src/unix/linux_like/linux/uclibc/mips/m=
ips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151cc1085735613791e60386=
5a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f=
25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix/linux_like/linux/ucl=
ibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee3b341cb3e98c435196d19=
1e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"076ad477f0786a2e4944=
cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/unix/linux_like/linux/uc=
libc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac54445d9841a0d57dcce836=
15add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/other.rs":"12f8d404986=
2fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def","src/unix/linux_like=
/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdba3d5d05b9e19d8f077ea"=
,"src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc296277daae6d0149aeac9b8=
7860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6ac7f8b381f8699b3604cf4=
60a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/arm/mod.rs":"ddea29e7c=
e40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac8","src/unix/newlib/e=
spidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe2505f48f7997abaf6e8551c=
655e","src/unix/newlib/generic.rs":"182e584f14e0984934130425dd2be0781ca2c13=
1449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mod.rs":"a484d84f56fd5b=
49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","src/unix/newlib/mod.rs=
":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/u=
nix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eebc8ac57b2f0ef0111abdcd=
5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3f=
cbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/newlib/vita/mod.rs":"92=
7c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4fec686ff","src/unix/n=
to/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100ed561e560665983359b7b9=
43075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d86977403023bb1645c83ce=
c2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3=
536709704715a49905024b6c520696a65086f9","src/unix/nto/x86_64.rs":"3fdcc6f28=
787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c887","src/unix/nuttx/mo=
d.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24af6470669ffa1b6425","s=
rc/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023332b1cb6af1e8c66fa2dd=
9c4255439d52","src/unix/solarish/compat.rs":"c02a88918852b7a9c60e45a34f7b00=
3901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish/illumos.rs":"cc7104f=
002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4af1","src/unix/solari=
sh/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e164e304f56dfff172e31309=
8","src/unix/solarish/solaris.rs":"3a37167395881640117a37728ca848d1dbeb4286=
912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0d=
ab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix/solarish/x86_64.rs":=
"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde103592922ec15295ef","src/uni=
x/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e=
4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc511cd02557e506c21fed673=
7585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs":"acb7968ce99fe3f4ab=
df39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/vxworks/mod.rs":"d02d2=
16bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff798a1b","src/vxworks/p=
owerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e8=
8","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c21fed6737585490a1dce7=
a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018cdb5b6e9a2c0d3a2a34d9a=
6c095d8469272ca8f137e4336140962be3177","src/vxworks/riscv64.rs":"16bff4f1c4=
eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069","src/vxworks/x86.rs=
":"552f007f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/v=
xworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98=
ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e00f0affdce627d9165681=
c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d28=
2741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":"320ddf761f731c24a27e=
061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/windows/mod.rs":"282daea=
cf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af440","src/windows/msv=
c/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00=
","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772abc3ca20dc4b09b5878098=
0b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85=
a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfcc4d620c7ebfb122c613af=
b886ca8803fa4e128a20a"}
 --- a/vendor/libc-0.2.171/.cargo-checksum.json
 +++ b/vendor/libc-0.2.171/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"747b437db48b8ded620a8738f9c1dbc2fde3d26db03d078=
2796537a9e505a263","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"8f6d0b13c977c8016b568c0a35b5ae70=
9318e0766af3cff4a84d351219013841","Cargo.toml":"7f31f2e612b4c14b57ecdcec491=
2ac1514e26e3c061d5b06b54e1e34e83191b1","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"199eb=
63f03c4e90cad31c1f03a15bac3d81ca97f31bcb81c45bbd0d909e57d61","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"e4=
14a3ecd5b5bc6c0bf7ce7c31639805943b789fbbf6006ceeb85ab44f3e4564","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"77bef57a5697d837331cff8947c50d070b28bb7aaa51b23f4d604cedaba7=
6806","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"2dfe0dd90c956e3b=
cc8bbbd6926c5b370829f411f22b80fa749fe87ebf0ea47b","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
f0d4d0fcd6c4e3bd77f84474a404be8a3a326731e9fe52008a09bcfb123a98a0","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"c6efc4de30803d89d7c73ef59e5e18dfb3c4a0c0688855b9193b2285736=
51106","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"48730e73367432bce709d5bcf316197c48f7501833a=
4798df5fc5f7043f04030","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"59ba589299a415936aad6f99f253a5b31e9b1=
e83ab6f0db3ceba077b7ba198b7","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"df73622ea883b9e44980e14=
eb7cee3b53bcdddd62190fe3d672ac5843b2e2e95","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"13c9af853fa35f3318f629b336fd8727e62ab106ac3a2cfa0a2ac13e77536900","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"6a87e7e673677882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"980694e20136b3f83176af5b6a2fcc=
7c70aa8e7a76baef324cefb7c9ac3b1af8","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"affb1e1abc4d58d8f37ba834981cf86858242c2a01c1c4bfd905c9e3bbbeacab","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"abda6685083597ed88c1f5d4121b387288d29=
a7bfb5f9b47a1580a45d3f523d8","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"aa5958011a063d025f11cf0cfc999dbc987ca5=
cbe0aad5385ab5e7ff7fc55abe","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"333c338367275ec420fc4c83779e3f0e52f86cace91d7940718a5b02c2e60297","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"7a4767d2409a4764ec0735f7f47d7d082=
247b324d28bdd2baee03802f95fa3e3","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"336f24e10b2dbd2faf0fb003cf43220c08f325695a02f4f7fd63fa06c23ce381","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"756ea27c90bee66496aac32fba1a2e38b4ecb1e9c104a3160010eaa50580=
7efb","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"9d28eac7d1bf98aa38832=
b8e55757ddef3ee8bde4cb00ba5e4145d07038bf827","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"52e1300f6c25cefd4c3d491ec7e1385f423a=
1fbbeb97b774c9a400b1c1b2b822","src/unix/linux_like/linux/mod.rs":"07f336f3e=
08712d51a96380250784c5a3364361d6c75f1e135931779b8d752af","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"8aefb482620db0e6853abc2313877f6bf87b3b4d63c0=
891d99189cdb12ce7733","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e97baedfe7f1a0cb48f0ba9e5389f86c19c4a=
08e22de1d82f18f411dba4c95e2","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"435ba055ec51d48bea1f835aeea91d01a24a12db9363aa34d1587dc7f0ac99e4","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"b27cf5ff9f1f734957af06f50881=
360dffb20538f7703daea01bbebf0e232bf0","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"07081d34712=
92a46d5ed69a5a376fceac9c6a01533c76db277eb6f9923092d5f","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"7fc0d475f397b64eb40c57bf5835a4612267d2a42c955e12f486032a8b54b8d9",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"ed8bd29fc3031=
9dfc149ccc5d150ca41e2d28ea5210fc26d9af91ad5903d0093","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"e04413e0d1c5207b=
58ab6c49f7995b9000be1f2fb1d4595c357a32df38951410","src/unix/mod.rs":"72b609=
e49e61591b3082cf674bb8df806f2ca5b755b9a052d94c6c8cb0f5e597","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"ded4a28f5b322446b0885290b917171d771b7897f39bf5616122283318b7a8e2","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"69beba3516f66d36c5b=
5e38130ff1fde8a8403d6d8ec79bebe437ac5d385176f","src/unix/redox/mod.rs":"a9a=
0005c8572ad5404cc9680a83a610d8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/so=
larish/compat.rs":"c02a88918852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f=
84936c8b","src/unix/solarish/illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e2=
34b2b9b021eed32572b8a28d991a398","src/unix/solarish/mod.rs":"ae04bf0fd7a30c=
0d0e22df180617c545428874c50a6ff815048a82124c2c6d75","src/unix/solarish/sola=
ris.rs":"54bae4c960b65d849beea8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbd=
ecbdd9ac26b38430b33b04f0c50addcc7","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"c19937216e9d3aa9956d9bb8dfc0b0c8beb6058fc4f7a4dc4d850edf86a237d6"}
+-{"files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
0e83f494b2c385738f9fea2ea",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"747=
b437db48b8ded620a8738f9c1dbc2fde3d26db03d0782796537a9e505a263","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"8f6d0b13c977c8016b568c0a35b5ae709318e0766af3cff4a84d35121901384=
1","Cargo.toml":"7f31f2e612b4c14b57ecdcec4912ac1514e26e3c061d5b06b54e1e34e8=
3191b1","Cargo.toml.orig":"b690a71106c17d70788343841b89bfe6cd5359b556b5b6cf=
394e54a1edd96281","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"199eb63f03c4e90cad31c1f03a=
15bac3d81ca97f31bcb81c45bbd0d909e57d61","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01d97a9a880d9d7be6d9f7f=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f81b1d7c962671aa074d70=
9c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"e414a3ecd5b5bc6c0bf7ce7=
c31639805943b789fbbf6006ceeb85ab44f3e4564","src/lib.rs":"d65975abfeac27f8db=
ef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/macros.rs":"076f328df1=
d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab547719b8ae2b371f9cb21","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa230f14965ee808eeab288=
4408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75ef15f85989f8feffb4f38b=
ac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.rs":"39a7f5cf92cf2d26=
ca50f54182fe57028cf24147ec12cb89d251301d65862138","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2edadb39db562e655ea5efdb1=
02ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64/x86_64/mod.rs":"71ba=
d5c051368805146168c4063534b010afcb358477c1f164712bb015bf3fb6","src/unix/bsd=
/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad85361e6b1389f699b2b88d46a=
a3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f7584d3fe4ab43bc7967dd=
0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9e8e5a9f1de648b248f257=
aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3910e19b082130811c2f28=
9","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"77bef5=
7a5697d837331cff8947c50d070b28bb7aaa51b23f4d604cedaba76806","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"2dfe0dd90c956e3bcc8bbbd6926c5b370829f=
411f22b80fa749fe87ebf0ea47b","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"f0d4d0fcd6c4e3bd77f84=
474a404be8a3a326731e9fe52008a09bcfb123a98a0","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"c6efc=
4de30803d89d7c73ef59e5e18dfb3c4a0c0688855b9193b228573651106","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"48730e73367432bce709d5bcf316197c48f7501833a4798df5fc5f7043f04030=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"59ba589299a415936aad6f99f253a5b31e9b1e83ab6f0db3ceba077b7b=
a198b7","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36a03b20551864c92852=
e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e3c96854c58b7a478b9972=
407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"3dfdc394922c2cb66=
790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a7650d2773a009b269bbceafd=
819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"85b4b6118ef4e08a7=
4b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/unix/bsd/freebsdlike/=
mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59d04e0f2978722c68101",=
"src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c9b9d27e9e21c0e4bafb6f=
1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b617c42084db1bd3aa4f5d5d=
1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"df73622ea883b9e44980e14eb7cee3b53bcdddd62190=
fe3d672ac5843b2e2e95","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95e324e90e3a7c8905c5930=
25f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f107e9cfd8e7e7e0d494567=
5a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs":"13c9af853fa35f3318f=
629b336fd8727e62ab106ac3a2cfa0a2ac13e77536900","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab8303dc7604488bf7e0b75=
33fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3=
a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"4480c042=
3eac3f288202df587b54025292633869a868bd0ac2767cd40afb5173","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d01bd36bb5e6541cddbe62=
858571328a03c6b7bb8a208262","src/unix/linux_like/android/b32/arm.rs":"06dfd=
e862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/linu=
x_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa2c0c=
33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942e15c=
6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"6a87e7e6736=
77882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"cab0e=
8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/linu=
x_like/android/mod.rs":"980694e20136b3f83176af5b6a2fcc7c70aa8e7a76baef324ce=
fb7c9ac3b1af8","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b0780a3c430b2f098715e4=
153a","src/unix/linux_like/linux/arch/generic/mod.rs":"affb1e1abc4d58d8f37b=
a834981cf86858242c2a01c1c4bfd905c9e3bbbeacab","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"abda6685083597ed88c1f5d4121b387288d29a7bfb5f9b47a1580a45d3=
f523d8","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759ae0871c13b91fce43ad152=
351","src/unix/linux_like/linux/arch/sparc/mod.rs":"9735216185ae78271e8333f=
8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"aa5958011a063d025f11cf0cfc999dbc987ca5cbe0aad5385ab5e7ff7fc=
55abe","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e1c53b84e1c13d91d94=
a44da0c3f120788c135d4253834782db57cccf0a39db4","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e21f299975a6d82a6472950=
6781259e43","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"333c338367275e=
c420fc4c83779e3f0e52f86cace91d7940718a5b02c2e60297","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"7a4767d2409a4764ec0735f7f47d7d082247b324d28bdd2baee038=
02f95fa3e3","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"336f24e10b2dbd2=
faf0fb003cf43220c08f325695a02f4f7fd63fa06c23ce381","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe839915dbef9b2bcc1bea5484ef=
a4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"756ea2=
7c90bee66496aac32fba1a2e38b4ecb1e9c104a3160010eaa505807efb","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"9d28eac7d1bf98aa38832b8e55757ddef3ee8bde4c=
b00ba5e4145d07038bf827","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596e16c=
d640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046086c=
6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168ddc1=
27315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"d1d38f4a25d=
885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e6433109ec0=
0260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02c53b=
df3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc444c2550be09ccf7a4231=
024b8af4acd6024de81da110ad932b62707698","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"52e1300f6c25cefd4c3d491ec7e1385f423a1fbbeb97b774c9a400b1c=
1b2b822","src/unix/linux_like/linux/mod.rs":"07f336f3e08712d51a96380250784c=
5a3364361d6c75f1e135931779b8d752af","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"8aefb482620db0e6853abc2313877f6bf87b3b4d63c0891d99189cdb12ce7733"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"400457049bad619da3accbca2=
c841206d1cd2673d670baf7210bf17427510271","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f04015e6c4dcf3b3e3061a7538=
bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"e97baedfe7f1a0cb48f0ba9e5389f86c19c4a08e22de1d82f18f411dba=
4c95e2","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"435ba055ec51d4=
8bea1f835aeea91d01a24a12db9363aa34d1587dc7f0ac99e4","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"b27cf5ff9f1f734957af06f50881360dffb20538f7703daea=
01bbebf0e232bf0","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"ef117=
d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a9b72=
5766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"07081d3471292a46d5ed69a5a376fcea=
c9c6a01533c76db277eb6f9923092d5f","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697466"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc3811d7=
2f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461be33=
fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"f44f7b2ade822aa=
468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a31=
7282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"7fc0d475f397=
b64eb40c57bf5835a4612267d2a42c955e12f486032a8b54b8d9","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842ce62b295bc0bd9eaf1b5f=
9792e442b681090","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"ed8bd29fc30319dfc149ccc5d150ca41e2=
d28ea5210fc26d9af91ad5903d0093","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c37752975c173aeb1641bae0e7=
43ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"e04413e0d1c5207b58ab6c49f7995b9000be1=
f2fb1d4595c357a32df38951410","src/unix/mod.rs":"72b609e49e61591b3082cf674bb=
8df806f2ca5b755b9a052d94c6c8cb0f5e597","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7=
f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"ded4a28f5b322446b=
0885290b917171d771b7897f39bf5616122283318b7a8e2","src/unix/nto/neutrino.rs"=
:"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"69beba3516f66d36c5b5e38130ff1fde8a8403d6=
d8ec79bebe437ac5d385176f","src/unix/redox/mod.rs":"a9a0005c8572ad5404cc9680=
a83a610d8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/solarish/compat.rs":"c0=
2a88918852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/s=
olarish/illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e234b2b9b021eed32572b8a=
28d991a398","src/unix/solarish/mod.rs":"ae04bf0fd7a30c0d0e22df180617c545428=
874c50a6ff815048a82124c2c6d75","src/unix/solarish/solaris.rs":"54bae4c960b6=
5d849beea8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde=
103592922ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbdecbdd9ac26b38430b33b0=
4f0c50addcc7","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd188=
0e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37=
a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"c19937216e9d3aa=
9956d9bb8dfc0b0c8beb6058fc4f7a4dc4d850edf86a237d6"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"747b437db48b8ded620a8738f9c1dbc2fde3d26db03d078=
2796537a9e505a263","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"8f6d0b13c977c8016b568c0a35b5ae70=
9318e0766af3cff4a84d351219013841","Cargo.toml":"7f31f2e612b4c14b57ecdcec491=
2ac1514e26e3c061d5b06b54e1e34e83191b1","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"199eb=
63f03c4e90cad31c1f03a15bac3d81ca97f31bcb81c45bbd0d909e57d61","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"e4=
14a3ecd5b5bc6c0bf7ce7c31639805943b789fbbf6006ceeb85ab44f3e4564","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"77bef57a5697d837331cff8947c50d070b28bb7aaa51b23f4d604cedaba7=
6806","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"2dfe0dd90c956e3b=
cc8bbbd6926c5b370829f411f22b80fa749fe87ebf0ea47b","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
f0d4d0fcd6c4e3bd77f84474a404be8a3a326731e9fe52008a09bcfb123a98a0","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"c6efc4de30803d89d7c73ef59e5e18dfb3c4a0c0688855b9193b2285736=
51106","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"48730e73367432bce709d5bcf316197c48f7501833a=
4798df5fc5f7043f04030","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"59ba589299a415936aad6f99f253a5b31e9b1=
e83ab6f0db3ceba077b7ba198b7","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"df73622ea883b9e44980e14=
eb7cee3b53bcdddd62190fe3d672ac5843b2e2e95","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"13c9af853fa35f3318f629b336fd8727e62ab106ac3a2cfa0a2ac13e77536900","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"6a87e7e673677882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"980694e20136b3f83176af5b6a2fcc=
7c70aa8e7a76baef324cefb7c9ac3b1af8","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"ecfca2e786d13fd5971a851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"abda6685083597ed88c1f5d4121b387288d29=
a7bfb5f9b47a1580a45d3f523d8","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"aa5958011a063d025f11cf0cfc999dbc987ca5=
cbe0aad5385ab5e7ff7fc55abe","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"333c338367275ec420fc4c83779e3f0e52f86cace91d7940718a5b02c2e60297","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"7a4767d2409a4764ec0735f7f47d7d082=
247b324d28bdd2baee03802f95fa3e3","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"336f24e10b2dbd2faf0fb003cf43220c08f325695a02f4f7fd63fa06c23ce381","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"756ea27c90bee66496aac32fba1a2e38b4ecb1e9c104a3160010eaa50580=
7efb","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"9d28eac7d1bf98aa38832=
b8e55757ddef3ee8bde4cb00ba5e4145d07038bf827","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"52e1300f6c25cefd4c3d491ec7e1385f423a=
1fbbeb97b774c9a400b1c1b2b822","src/unix/linux_like/linux/mod.rs":"07f336f3e=
08712d51a96380250784c5a3364361d6c75f1e135931779b8d752af","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"8aefb482620db0e6853abc2313877f6bf87b3b4d63c0=
891d99189cdb12ce7733","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e97baedfe7f1a0cb48f0ba9e5389f86c19c4a=
08e22de1d82f18f411dba4c95e2","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"435ba055ec51d48bea1f835aeea91d01a24a12db9363aa34d1587dc7f0ac99e4","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"b27cf5ff9f1f734957af06f50881=
360dffb20538f7703daea01bbebf0e232bf0","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"07081d34712=
92a46d5ed69a5a376fceac9c6a01533c76db277eb6f9923092d5f","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"7fc0d475f397b64eb40c57bf5835a4612267d2a42c955e12f486032a8b54b8d9",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"ed8bd29fc3031=
9dfc149ccc5d150ca41e2d28ea5210fc26d9af91ad5903d0093","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"e04413e0d1c5207b=
58ab6c49f7995b9000be1f2fb1d4595c357a32df38951410","src/unix/mod.rs":"72b609=
e49e61591b3082cf674bb8df806f2ca5b755b9a052d94c6c8cb0f5e597","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"ded4a28f5b322446b0885290b917171d771b7897f39bf5616122283318b7a8e2","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"69beba3516f66d36c5b=
5e38130ff1fde8a8403d6d8ec79bebe437ac5d385176f","src/unix/redox/mod.rs":"a9a=
0005c8572ad5404cc9680a83a610d8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/so=
larish/compat.rs":"c02a88918852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f=
84936c8b","src/unix/solarish/illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e2=
34b2b9b021eed32572b8a28d991a398","src/unix/solarish/mod.rs":"ae04bf0fd7a30c=
0d0e22df180617c545428874c50a6ff815048a82124c2c6d75","src/unix/solarish/sola=
ris.rs":"54bae4c960b65d849beea8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbd=
ecbdd9ac26b38430b33b04f0c50addcc7","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"c19937216e9d3aa9956d9bb8dfc0b0c8beb6058fc4f7a4dc4d850edf86a237d6"}
++{"files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
0e83f494b2c385738f9fea2ea",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"747=
b437db48b8ded620a8738f9c1dbc2fde3d26db03d0782796537a9e505a263","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"8f6d0b13c977c8016b568c0a35b5ae709318e0766af3cff4a84d35121901384=
1","Cargo.toml":"7f31f2e612b4c14b57ecdcec4912ac1514e26e3c061d5b06b54e1e34e8=
3191b1","Cargo.toml.orig":"b690a71106c17d70788343841b89bfe6cd5359b556b5b6cf=
394e54a1edd96281","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"199eb63f03c4e90cad31c1f03a=
15bac3d81ca97f31bcb81c45bbd0d909e57d61","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01d97a9a880d9d7be6d9f7f=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f81b1d7c962671aa074d70=
9c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"e414a3ecd5b5bc6c0bf7ce7=
c31639805943b789fbbf6006ceeb85ab44f3e4564","src/lib.rs":"d65975abfeac27f8db=
ef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/macros.rs":"076f328df1=
d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab547719b8ae2b371f9cb21","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa230f14965ee808eeab288=
4408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75ef15f85989f8feffb4f38b=
ac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.rs":"39a7f5cf92cf2d26=
ca50f54182fe57028cf24147ec12cb89d251301d65862138","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2edadb39db562e655ea5efdb1=
02ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64/x86_64/mod.rs":"71ba=
d5c051368805146168c4063534b010afcb358477c1f164712bb015bf3fb6","src/unix/bsd=
/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad85361e6b1389f699b2b88d46a=
a3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f7584d3fe4ab43bc7967dd=
0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9e8e5a9f1de648b248f257=
aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3910e19b082130811c2f28=
9","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"77bef5=
7a5697d837331cff8947c50d070b28bb7aaa51b23f4d604cedaba76806","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"2dfe0dd90c956e3bcc8bbbd6926c5b370829f=
411f22b80fa749fe87ebf0ea47b","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"f0d4d0fcd6c4e3bd77f84=
474a404be8a3a326731e9fe52008a09bcfb123a98a0","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"c6efc=
4de30803d89d7c73ef59e5e18dfb3c4a0c0688855b9193b228573651106","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"48730e73367432bce709d5bcf316197c48f7501833a4798df5fc5f7043f04030=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"59ba589299a415936aad6f99f253a5b31e9b1e83ab6f0db3ceba077b7b=
a198b7","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36a03b20551864c92852=
e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e3c96854c58b7a478b9972=
407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"3dfdc394922c2cb66=
790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a7650d2773a009b269bbceafd=
819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"85b4b6118ef4e08a7=
4b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/unix/bsd/freebsdlike/=
mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59d04e0f2978722c68101",=
"src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c9b9d27e9e21c0e4bafb6f=
1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b617c42084db1bd3aa4f5d5d=
1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"df73622ea883b9e44980e14eb7cee3b53bcdddd62190=
fe3d672ac5843b2e2e95","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95e324e90e3a7c8905c5930=
25f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f107e9cfd8e7e7e0d494567=
5a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs":"13c9af853fa35f3318f=
629b336fd8727e62ab106ac3a2cfa0a2ac13e77536900","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab8303dc7604488bf7e0b75=
33fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3=
a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"4480c042=
3eac3f288202df587b54025292633869a868bd0ac2767cd40afb5173","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d01bd36bb5e6541cddbe62=
858571328a03c6b7bb8a208262","src/unix/linux_like/android/b32/arm.rs":"06dfd=
e862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/linu=
x_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa2c0c=
33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942e15c=
6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"6a87e7e6736=
77882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"cab0e=
8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/linu=
x_like/android/mod.rs":"980694e20136b3f83176af5b6a2fcc7c70aa8e7a76baef324ce=
fb7c9ac3b1af8","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b0780a3c430b2f098715e4=
153a","src/unix/linux_like/linux/arch/generic/mod.rs":"ecfca2e786d13fd5971a=
851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"abda6685083597ed88c1f5d4121b387288d29a7bfb5f9b47a1580a45d3=
f523d8","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759ae0871c13b91fce43ad152=
351","src/unix/linux_like/linux/arch/sparc/mod.rs":"9735216185ae78271e8333f=
8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"aa5958011a063d025f11cf0cfc999dbc987ca5cbe0aad5385ab5e7ff7fc=
55abe","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e1c53b84e1c13d91d94=
a44da0c3f120788c135d4253834782db57cccf0a39db4","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e21f299975a6d82a6472950=
6781259e43","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"333c338367275e=
c420fc4c83779e3f0e52f86cace91d7940718a5b02c2e60297","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"7a4767d2409a4764ec0735f7f47d7d082247b324d28bdd2baee038=
02f95fa3e3","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"336f24e10b2dbd2=
faf0fb003cf43220c08f325695a02f4f7fd63fa06c23ce381","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe839915dbef9b2bcc1bea5484ef=
a4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"756ea2=
7c90bee66496aac32fba1a2e38b4ecb1e9c104a3160010eaa505807efb","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"9d28eac7d1bf98aa38832b8e55757ddef3ee8bde4c=
b00ba5e4145d07038bf827","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596e16c=
d640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046086c=
6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168ddc1=
27315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"d1d38f4a25d=
885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e6433109ec0=
0260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02c53b=
df3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc444c2550be09ccf7a4231=
024b8af4acd6024de81da110ad932b62707698","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"52e1300f6c25cefd4c3d491ec7e1385f423a1fbbeb97b774c9a400b1c=
1b2b822","src/unix/linux_like/linux/mod.rs":"07f336f3e08712d51a96380250784c=
5a3364361d6c75f1e135931779b8d752af","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"8aefb482620db0e6853abc2313877f6bf87b3b4d63c0891d99189cdb12ce7733"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"400457049bad619da3accbca2=
c841206d1cd2673d670baf7210bf17427510271","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f04015e6c4dcf3b3e3061a7538=
bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"e97baedfe7f1a0cb48f0ba9e5389f86c19c4a08e22de1d82f18f411dba=
4c95e2","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"435ba055ec51d4=
8bea1f835aeea91d01a24a12db9363aa34d1587dc7f0ac99e4","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"b27cf5ff9f1f734957af06f50881360dffb20538f7703daea=
01bbebf0e232bf0","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"ef117=
d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a9b72=
5766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"07081d3471292a46d5ed69a5a376fcea=
c9c6a01533c76db277eb6f9923092d5f","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697466"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc3811d7=
2f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461be33=
fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"f44f7b2ade822aa=
468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a31=
7282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"7fc0d475f397=
b64eb40c57bf5835a4612267d2a42c955e12f486032a8b54b8d9","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842ce62b295bc0bd9eaf1b5f=
9792e442b681090","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"ed8bd29fc30319dfc149ccc5d150ca41e2=
d28ea5210fc26d9af91ad5903d0093","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c37752975c173aeb1641bae0e7=
43ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"e04413e0d1c5207b58ab6c49f7995b9000be1=
f2fb1d4595c357a32df38951410","src/unix/mod.rs":"72b609e49e61591b3082cf674bb=
8df806f2ca5b755b9a052d94c6c8cb0f5e597","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7=
f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"ded4a28f5b322446b=
0885290b917171d771b7897f39bf5616122283318b7a8e2","src/unix/nto/neutrino.rs"=
:"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"69beba3516f66d36c5b5e38130ff1fde8a8403d6=
d8ec79bebe437ac5d385176f","src/unix/redox/mod.rs":"a9a0005c8572ad5404cc9680=
a83a610d8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/solarish/compat.rs":"c0=
2a88918852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/s=
olarish/illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e234b2b9b021eed32572b8a=
28d991a398","src/unix/solarish/mod.rs":"ae04bf0fd7a30c0d0e22df180617c545428=
874c50a6ff815048a82124c2c6d75","src/unix/solarish/solaris.rs":"54bae4c960b6=
5d849beea8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde=
103592922ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbdecbdd9ac26b38430b33b0=
4f0c50addcc7","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd188=
0e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37=
a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"c19937216e9d3aa=
9956d9bb8dfc0b0c8beb6058fc4f7a4dc4d850edf86a237d6"}
 --- a/vendor/libc-0.2.171/src/unix/linux_like/linux/arch/generic/mod.rs
 +++ b/vendor/libc-0.2.171/src/unix/linux_like/linux/arch/generic/mod.rs
 @@ -1,5 +1,5 @@
diff --git a/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls=
-as-their-time64-varian.patch b/recipes-devtools/rust/files/0001-riscv32-De=
fine-plain-syscalls-as-their-time64-varian.patch
index fc604af..6342873 100644
--- a/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-the=
ir-time64-varian.patch
+++ b/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-the=
ir-time64-varian.patch
@@ -44,9 +44,9 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 --- a/vendor/libc-0.2.174/.cargo-checksum.json
 +++ b/vendor/libc-0.2.174/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"d4d202929497332d94acf48737a5cf4a2c5f53d25c93f67=
34df535b8b56bc30b","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"a3b7f6b5d63de50ad386146d4ab8126e=
4ce71b91f086861aaf3d7c2cd3a1426e","Cargo.toml":"08c008bd409b6862f7723b927d7=
cb50e83e093b336b306687f5b0356230cead2","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"b3115=
efae7f0487ed04d36bfaa0d6449db6448356a9cbeb3e10821d79008720d","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"d783900ea7e696ed25bb2f04c8714b0afdff0877d46=
418a29025c61e535254cd","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"a6de0a3c9a=
45e7af2f0bac96d73da6a7cfb8c003335183016b08a25e2acab65b","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"4d32db18cf39bf8b36fa0688bf2a7d2c9b3bb4c9664a1583fc203f008f8045a2","src/m=
acros.rs":"9697bfcb664007468f7e5a4bdb754ab554a5c12273d7576d2d78392f61d19e15=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"6ab902bad5bd5c97a6e300b354820602703f1f802071a8b=
7a935c42444c587ca","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"abe29e873d9492f46bef8a7596469ad4698af08=
7ab29619c059221b0f7c0fa91","src/unix/aix/powerpc64.rs":"6e1d1f50a58a8cb15f7=
a11cabfa8d7d2c0c5078d328d53c5fcf46bc706cf1a4d","src/unix/bsd/apple/b32/mod.=
rs":"76a5dce8b65aeb51626bb7316ab200015021dd87bddde86185cb424118c78528","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"75a313514fd3b9=
f21391ddb77f965386c36e99bbf4a4c952445e4e8d50bb16b5","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"996ae7cd5a730ec595fde9a02add78f9417086204538abb80f6d24c80a=
0b649b","src/unix/bsd/apple/mod.rs":"109b57bb1db39a37c1ca90eeaadcc9637c4bf3=
1d0df0bb53aab0778eb903750b","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"c542f3f05e161fb77f50d718fa7e52ce9f2dcc9=
dcb3a615d8d604a0a520febfe","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"f=
796f19f04336225de81151897387ce5e975a67510f400cdcc8f0048d5d484bb","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"f3e3410bbca7c6aa591f06b7215645da4ccceab82b=
9c478277eeffdf9310f92a","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"b1ddf661a8a331184e6b1134307ea25454547472a21c05752200b0700211=
0171","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"ed37853a6c281746=
424f7c2109122312faf2b81f862280918955a94906b79189","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
ac75d9267ab2f0c3432d4d173d417dd05306a8c63af6c050c67ed35a9c68dd6f","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"7cac2e91eb6afde7babbfd5dd593e038a1b711929c7d48110f3b430f921=
c478a","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"23f496d5e30ed99449efac7d2d28e6b72faee7ba644=
5a0ea92a0f9b44cc80fe1","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"90ef01d22cbb53af4f7fe88dae51fc04db018=
26d4dca4be5915c6a2c7a50c328","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"bfc3ac2f4e1d2136589181db2297c6f9d279fd160f00fe2c42bc0820978d7934","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"4843e5303d6c29756c5b62f2ceb4134e0d=
72a5f99c8a0b10892b3bb916e6dae3","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"94538d52efac5c8fea0c3ed30c1c9451820dd396f028b4159b908c1898987bc3","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"3a2c28e6cbfa27a4a663a85a2cd2bc3307613=
670f815c99650850629ab05150d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"f0af70c5b623224b3348ae9832272cb4940a45124e55fd2d0b0202930e4cf244","src/=
unix/bsd/freebsdlike/mod.rs":"2e7188c40dcbf437da93184184108d1f840b82bb04457=
d8002bf1a49f7f9f81c","src/unix/bsd/mod.rs":"c7322c39fadbd78cc957ea51a7c6490=
d07a630a6ae07ca397bd1e611adc5095a","src/unix/bsd/netbsdlike/mod.rs":"345a3a=
ca0dd0349c88ccb4b89857304e7523661f2dbf7761182123596d5e3eb9","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"851007845bd8743cea35ce9=
1a850d28c6aa2a0d543ac6946476c1d13ed4a2684","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"b3b6c85aa=
7dba31aa80c4668b2758a03feb43ea18f7a6f2dec183e00986e3709","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"caaf5a547299500=
d8a7b0a17214215916a53819e19cbc6ac392bef30f5982906","src/unix/cygwin/mod.rs"=
:"70a44e600a59a2003088ac517076183068b5ec84159f43c1bf05ba880aa1cfe4","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"211b4b9239a3f73f94c94ac30=
c96f01838d776f2df4e42e887e167b06c45446f","src/unix/haiku/native.rs":"4f52d1=
3ba164c6c4d138de445541d2358ca5c4f69898efd6c15c506c2f341a6f","src/unix/haiku=
/x86_64.rs":"09f2384474b2fcb7d0febb0e9e802610a627cadca29dc0e60eb4cfe15552f9=
78","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"e3dbad685a3d29dae=
510b438d29f692f6a8fdf37a422924915a36a3e854b1219","src/unix/linux_like/andro=
id/b32/arm.rs":"e68f6a15870a22e0383770ed1a5bd443d4c2ed237d16fea338c5da1ab9b=
f1fe3","src/unix/linux_like/android/b32/mod.rs":"5b10ebe56435d868846ae720bb=
9081cf814486722b5c13520fd4ef50a7ecfb58","src/unix/linux_like/android/b32/x8=
6/mod.rs":"d21913dab5d6b482106087297fbb643fd7cd3f83c01d56c1a1f8203dc57d8c16=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"ddc2932b78be316904019cd6209baccb1ce0732ad4332fecd99a7db0b5bf963a"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"7449054f5815b6d9f734867d97d60a4eff13c809fbf32272a40826137bd=
6469c","src/unix/linux_like/android/mod.rs":"983d08c419c3489bf83c283d2cd0c1=
f6312c8d0ff8bbc31b8c40259bbf3e1772","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"5baf8617a99b77897c1f226adf4e96a9582f356=
e3dd389a39fc4f1a75f052046","src/unix/linux_like/linux/arch/generic/mod.rs":=
"c8f4d88ba7ffe044c47fc84ca1e21751bfd2446806ccabbe8729958cbb5d1ccc","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"058ebf07f8b10358af9a7f66bd96ba14df1cc=
6a942203da9abe8d1abab00fcbb","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"0e20b7e63fe39a200cb4813eeb934bc25d91a242=
7cd1b1d81bc2cfa4e2368ed5","src/unix/linux_like/linux/arch/sparc/mod.rs":"96=
ed29a86c629657c521a5e12dece22e570ef7ceee9e8f4a58c2e0782d74e01d","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"33e971a4c2b20aada29a84fcae8b374664548f=
6d17462c03b031086d2c7bcb04","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"34e3a077861bb12baf7c97f7e4e8e1d52d58384337039361e09887b29c4f1ffe","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"07b89d105c91654079ed27cc373cc800a=
a4182f740dd5aa7a14ab756eb2968e6","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"1b0262dd90ba38e66c14404e8e07be11b9f1cc18fac1cd62db11e2b7e29dc673","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"050fa9856b151b3e33214b570cf7527ec=
a11eaa9145d40a1524824b5232b2500","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"7c3b9aad8856408517e056bdcfde877ca9d4529b9c39ffada70b56cdf244c403","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"5fa3d4b5f3c32251f5aa8c1130=
f3b7ccf37d66091734f43245ad3678cd216e9b","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"045c69c191b162532dd4e2a911542c31ce4fea5b800ff34834eecebd51c1=
6565","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"6ae9d44a8eac65d537f3d=
173d70846d6a31a962868a8c416e59ddc6c4e3b9bdb","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"6295789556ca344693fe9e2f7a0319429f2d579=
c2b912734767f2a0e15a8f5f5","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"713c94cb544ddddde3076fa3f27747507ecb6becc8e89a50adaea78f8abab64c","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"457279848453764fba944be61=
23c7fadd6ec9ccdfaa9e2c98d482f729a29acd5","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"30d1286c6b53a8c1cc090921a4192d5c05c7dbe0a7ff1aa4577774f9db934515"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"578fee223a62f2788352=
169b403d1547ae31d3e4be2806ab363b35239ed0aee2","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"1f6d2655bfdaf7e3c1030ede9cfd2608eaa29401e039c6a416e9=
a96bbccbe390","src/unix/linux_like/linux/gnu/b64/s390x.rs":"64fba1b75736ef6=
e22c11751c9daa3abd61af47b27da641d655e9ebb04b0f507","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8c3760938b956ea8944bc9d59defe02901427e343b140f3=
a94f00338daa13d36","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"5c815=
f9a2b85266b4be9999fb58037ead6388f360d07241fbdc4b054e584d5ba","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"fb6808e027f28dfb51a402f3bda4f8fca1a1=
e0513e19bc2ffa6278d5050ea9aa","src/unix/linux_like/linux/mod.rs":"e5bcfb003=
48a63f767f3cd37e8a3670f0228ca7a7cf26b5a3c5dcd996b5ad8ae","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"8bb6d0da8ac855120783a09d2ae07ea84696a4c65730=
9b2d0895d05d92be5e7b","src/unix/linux_like/linux/musl/b32/hexagon.rs":"1b0c=
68839dc46d00010d99e946f356d50dc4ad1c7468f99a8afe839f9542ebd0","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"46e9507a4a19b3f79206cea1ff14126f27bc67=
740bbae7e8c2c59634d733434f","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"03fa0663ca77029ebd5cf99b1a8c7fab0fbbb=
51087dd44b939dd1b03ffae17c8","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"07e92b7bcd186241d728305bd522110a4f30c508c15e1be02bc29ddc75665f1f","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"dc90270beefe8090d2a87f926302=
affb0656ef0f847b6c10d332758359675a59","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"835c57754ccacd0a8630ec14661a98b3b0bb06f13cb1586eb36d3fde3da=
1fd29","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"0be190a6aee=
332b19ff6f005f7ebc1ee3da61c7e0cc64aa049c4cf491027c250","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"9ccd2d9ed31459b33435c09fa47e2cdef386149d2df013f=
6810e7499cbdf634a","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"5ae8c86a5939c021ee8f298ca0c141b5f323c4e7df3b=
0b8d0e59d493207ed4b5","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
f3893250f00da52e6895a39ca20947748340cab0c2176f2fbcc44f8a3d1df696","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"9174e156d17f09de2c4975e974af40eaa3726=
f11d44e17077eb2e9efaf91d0a9","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"503278ab86dfdbdd1f59188333162602744f413c937dcf132f97bc16ec03b943","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"32b422900fc8831c718620dcd102fd91f4c819946a2b7cdab1df9ed7d=
b5b8577","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"17543653f63f7c0acb96857b42ebcf5591e225322c7e3fc2de7b750712642c11",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"a90c7811623714e168b676aa50b1=
62931e66ce86f8c59b0acac131afde474b2c","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"af6323cebdeeeb4f0e86ddfddb9cf21cf251f27a98a8c02=
feb4f80e81d7a996a","src/unix/linux_like/linux/uclibc/mod.rs":"128d586702c6a=
a6f1d1c56342f855d62550063ea7df97c6c16abdb01fd6bf94e","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"061ca=
21386ad438be46e6c74f187240636c3ae351b81ca61daae56681c7f6c35","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"23fb0653259a860b=
97abec8391d8f8766d1d6a3f77908112958bc4eda60af4cd","src/unix/mod.rs":"260101=
219eb92ed352920fad95b46362dec95e5206a4af4ee452327d3c20e629","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"6400cd5566e457fcfff2112=
16ac86a49127f190b4b863703e1e5096cc3f9c125","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"fd7d2ea12b221cde0655878ede3e983e0df514fc721e99f11d847c81803a0acd","src/=
unix/nto/neutrino.rs":"2cef6af9943eec590b2b0af96a63bc3169e9d2af5c7713e3360e=
b09a807f248a","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"353dd905bddd5d7bbfa=
21c4367fc4a6f562a214a632e8dfd3fbdb330615342ae","src/unix/redox/mod.rs":"e6a=
2852f2366001ffaa4a60ff217db6f44dfad9118c64919b59da4d6bcceb93a","src/unix/so=
larish/compat.rs":"4346fbe9f8640868ac20b63bf3b52f883a37587e1df15ffe54fa0393=
a48a5588","src/unix/solarish/illumos.rs":"c6305f2555bc542dd63ac0edbc8e517f6=
5a7a870ef9c406d0809d25c6c32276c","src/unix/solarish/mod.rs":"3d85a303327598=
3a0ad1386af9ca37c2611187958a5dbaa0a1b4851fbb764a92","src/unix/solarish/sola=
ris.rs":"59466eb385fefddac9a097ee3dab919df9043d2ac4061e31fe404c2c3ff5a23f",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"d888cd12da647f543df8cce7a=
e04e4a67f8647f71fd14cf7b4f968dbafcd4f5e","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"cf1adb4b57e016298a58af602f408a1=
f16ff639be994331e57cff94285470b82","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"fefb225e135277652868e8065849e4d8c6bfe4a4961614b4f34645282e1ebb95","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"d69f6aea427500cdf47898b87e0a54253=
82d46b5ef3f2f843818a62372fa72f5","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"1171693293099992e19cddea4e8b849964e9846f4acee11b3948bcc337be8776"}
+-{"files":{".cargo_vcs_info.json":"9e3f383a0671ce544ba60129f113826026bfd39=
d6f9a2f7323198c88a462be44",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"d4d=
202929497332d94acf48737a5cf4a2c5f53d25c93f6734df535b8b56bc30b","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"a3b7f6b5d63de50ad386146d4ab8126e4ce71b91f086861aaf3d7c2cd3a1426=
e","Cargo.toml":"08c008bd409b6862f7723b927d7cb50e83e093b336b306687f5b035623=
0cead2","Cargo.toml.orig":"647a491d157e1afbeea48f635be858ab1b1c9c2064c24d15=
a1e30808c6d7bd35","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"b3115efae7f0487ed04d36bfaa=
0d6449db6448356a9cbeb3e10821d79008720d","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"d783900ea7e696ed25bb2f04c8714b0afdff0877d46418a29025c61e535254cd=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"a6de0a3c9a45e7af2f0bac96d73da6a=
7cfb8c003335183016b08a25e2acab65b","src/hermit.rs":"f150c2882a4d8e510259697=
ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs":"4d32db18cf39bf8b36=
fa0688bf2a7d2c9b3bb4c9664a1583fc203f008f8045a2","src/macros.rs":"9697bfcb66=
4007468f7e5a4bdb754ab554a5c12273d7576d2d78392f61d19e15","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"6ab902bad5bd5c97a6e300b354820602703f1f802071a8b7a935c42444c587ca","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"abe29e873d9492f46bef8a7596469ad4698af087ab29619c059221b0f7c0=
fa91","src/unix/aix/powerpc64.rs":"6e1d1f50a58a8cb15f7a11cabfa8d7d2c0c5078d=
328d53c5fcf46bc706cf1a4d","src/unix/bsd/apple/b32/mod.rs":"76a5dce8b65aeb51=
626bb7316ab200015021dd87bddde86185cb424118c78528","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"75a313514fd3b9f21391ddb77f965386c36=
e99bbf4a4c952445e4e8d50bb16b5","src/unix/bsd/apple/b64/x86_64/mod.rs":"996a=
e7cd5a730ec595fde9a02add78f9417086204538abb80f6d24c80a0b649b","src/unix/bsd=
/apple/mod.rs":"109b57bb1db39a37c1ca90eeaadcc9637c4bf31d0df0bb53aab0778eb90=
3750b","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"c542f3f05e161fb77f50d718fa7e52ce9f2dcc9dcb3a615d8d604a0a520f=
ebfe","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"f796f19f04336225de8115=
1897387ce5e975a67510f400cdcc8f0048d5d484bb","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"f3e3410bbca7c6aa591f06b7215645da4ccceab82b9c478277eeffdf9310f92=
a","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"b1ddf6=
61a8a331184e6b1134307ea25454547472a21c05752200b07002110171","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"ed37853a6c281746424f7c2109122312faf2b=
81f862280918955a94906b79189","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"ac75d9267ab2f0c3432d4=
d173d417dd05306a8c63af6c050c67ed35a9c68dd6f","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"7cac2=
e91eb6afde7babbfd5dd593e038a1b711929c7d48110f3b430f921c478a","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"23f496d5e30ed99449efac7d2d28e6b72faee7ba6445a0ea92a0f9b44cc80fe1=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"90ef01d22cbb53af4f7fe88dae51fc04db01826d4dca4be5915c6a2c7a=
50c328","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"bfc3ac2f4e1d21365891=
81db2297c6f9d279fd160f00fe2c42bc0820978d7934","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"4843e5303d6c29756c5b62f2ceb4134e0d72a5f99c8a0b10892b3bb=
916e6dae3","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"94538d52efac5c8fe=
a0c3ed30c1c9451820dd396f028b4159b908c1898987bc3","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"3a2c28e6cbfa27a4a663a85a2cd2bc3307613670f815c99650850629ab=
05150d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"f0af70c5b623224b3=
348ae9832272cb4940a45124e55fd2d0b0202930e4cf244","src/unix/bsd/freebsdlike/=
mod.rs":"2e7188c40dcbf437da93184184108d1f840b82bb04457d8002bf1a49f7f9f81c",=
"src/unix/bsd/mod.rs":"c7322c39fadbd78cc957ea51a7c6490d07a630a6ae07ca397bd1=
e611adc5095a","src/unix/bsd/netbsdlike/mod.rs":"345a3aca0dd0349c88ccb4b8985=
7304e7523661f2dbf7761182123596d5e3eb9","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"851007845bd8743cea35ce91a850d28c6aa2a0d543ac=
6946476c1d13ed4a2684","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"b3b6c85aa7dba31aa80c4668b2758a=
03feb43ea18f7a6f2dec183e00986e3709","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"caaf5a547299500d8a7b0a17214215916a53=
819e19cbc6ac392bef30f5982906","src/unix/cygwin/mod.rs":"70a44e600a59a200308=
8ac517076183068b5ec84159f43c1bf05ba880aa1cfe4","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"211b4b9239a3f73f94c94ac30c96f01838d776f2df4e42=
e887e167b06c45446f","src/unix/haiku/native.rs":"4f52d13ba164c6c4d138de44554=
1d2358ca5c4f69898efd6c15c506c2f341a6f","src/unix/haiku/x86_64.rs":"09f23844=
74b2fcb7d0febb0e9e802610a627cadca29dc0e60eb4cfe15552f978","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"e3dbad685a3d29dae510b438d29f692f6a8fdf=
37a422924915a36a3e854b1219","src/unix/linux_like/android/b32/arm.rs":"e68f6=
a15870a22e0383770ed1a5bd443d4c2ed237d16fea338c5da1ab9bf1fe3","src/unix/linu=
x_like/android/b32/mod.rs":"5b10ebe56435d868846ae720bb9081cf814486722b5c135=
20fd4ef50a7ecfb58","src/unix/linux_like/android/b32/x86/mod.rs":"d21913dab5=
d6b482106087297fbb643fd7cd3f83c01d56c1a1f8203dc57d8c16","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"ddc2932b78b=
e316904019cd6209baccb1ce0732ad4332fecd99a7db0b5bf963a","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"74490=
54f5815b6d9f734867d97d60a4eff13c809fbf32272a40826137bd6469c","src/unix/linu=
x_like/android/mod.rs":"983d08c419c3489bf83c283d2cd0c1f6312c8d0ff8bbc31b8c4=
0259bbf3e1772","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"5baf8617a99b77897c1f226adf4e96a9582f356e3dd389a39fc4f1a75f05=
2046","src/unix/linux_like/linux/arch/generic/mod.rs":"c8f4d88ba7ffe044c47f=
c84ca1e21751bfd2446806ccabbe8729958cbb5d1ccc","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"058ebf07f8b10358af9a7f66bd96ba14df1cc6a942203da9abe8d1abab=
00fcbb","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"0e20b7e63fe39a200cb4813eeb934bc25d91a2427cd1b1d81bc2cfa4e2368=
ed5","src/unix/linux_like/linux/arch/sparc/mod.rs":"96ed29a86c629657c521a5e=
12dece22e570ef7ceee9e8f4a58c2e0782d74e01d","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"33e971a4c2b20aada29a84fcae8b374664548f6d17462c03b031086d2c7=
bcb04","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"34e3a077861bb12baf7=
c97f7e4e8e1d52d58384337039361e09887b29c4f1ffe","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"07b89d105c91654079ed27cc373cc800aa4182f740dd5aa7a14ab7=
56eb2968e6","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"1b0262dd90ba38=
e66c14404e8e07be11b9f1cc18fac1cd62db11e2b7e29dc673","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"050fa9856b151b3e33214b570cf7527eca11eaa9145d40a1524824=
b5232b2500","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"7c3b9aad8856408=
517e056bdcfde877ca9d4529b9c39ffada70b56cdf244c403","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"5fa3d4b5f3c32251f5aa8c1130f3b7ccf37d66091734f43=
245ad3678cd216e9b","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"045c69=
c191b162532dd4e2a911542c31ce4fea5b800ff34834eecebd51c16565","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"6ae9d44a8eac65d537f3d173d70846d6a31a962868=
a8c416e59ddc6c4e3b9bdb","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"6295789556ca344693fe9e2f7a0319429f2d579c2b912734767f2a0e15a8=
f5f5","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"713c94cb544dd=
ddde3076fa3f27747507ecb6becc8e89a50adaea78f8abab64c","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"457279848453764fba944be6123c7fadd6ec9ccdfaa9e2=
c98d482f729a29acd5","src/unix/linux_like/linux/gnu/b64/mod.rs":"30d1286c6b5=
3a8c1cc090921a4192d5c05c7dbe0a7ff1aa4577774f9db934515","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"578fee223a62f2788352169b403d1547ae31d3e4b=
e2806ab363b35239ed0aee2","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"1f6d2655bfdaf7e3c1030ede9cfd2608eaa29401e039c6a416e9a96bbccbe390","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"64fba1b75736ef6e22c11751c9daa3abd61a=
f47b27da641d655e9ebb04b0f507","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8c3760938b956ea8944bc9d59defe02901427e343b140f3a94f00338daa13d36","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"5c815f9a2b85266b4be9999fb5=
8037ead6388f360d07241fbdc4b054e584d5ba","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"fb6808e027f28dfb51a402f3bda4f8fca1a1e0513e19bc2ffa6278d50=
50ea9aa","src/unix/linux_like/linux/mod.rs":"e5bcfb00348a63f767f3cd37e8a367=
0f0228ca7a7cf26b5a3c5dcd996b5ad8ae","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"8bb6d0da8ac855120783a09d2ae07ea84696a4c657309b2d0895d05d92be5e7b"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"1b0c68839dc46d00010d99e94=
6f356d50dc4ad1c7468f99a8afe839f9542ebd0","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"46e9507a4a19b3f79206cea1ff14126f27bc67740bbae7e8c2c59634d73=
3434f","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"03fa0663ca77029ebd5cf99b1a8c7fab0fbbb51087dd44b939dd1b03ff=
ae17c8","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"07e92b7bcd1862=
41d728305bd522110a4f30c508c15e1be02bc29ddc75665f1f","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"dc90270beefe8090d2a87f926302affb0656ef0f847b6c10d=
332758359675a59","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"835c5=
7754ccacd0a8630ec14661a98b3b0bb06f13cb1586eb36d3fde3da1fd29","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"0be190a6aee332b19ff6f005f7ebc1ee=
3da61c7e0cc64aa049c4cf491027c250","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"9ccd2d9ed31459b33435c09fa47e2cdef386149d2df013f6810e7499cbdf634a","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c01bc412b3e13a0d41102e5=
8a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"5ae8c86a5939c021ee8f298ca0c141b5f323c4e7df3b0b8d0e59d493207ed4b5"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"f3893250f00da52e6895a=
39ca20947748340cab0c2176f2fbcc44f8a3d1df696","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"9174e156d17f09de2c4975e974af40eaa3726f11d44e17077eb2e9efaf=
91d0a9","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"503278ab86dfdbd=
d1f59188333162602744f413c937dcf132f97bc16ec03b943","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"32b=
422900fc8831c718620dcd102fd91f4c819946a2b7cdab1df9ed7db5b8577","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"17543653f63f=
7c0acb96857b42ebcf5591e225322c7e3fc2de7b750712642c11","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"a90c7811623714e168b676aa50b162931e66ce86f8c59b0ac=
ac131afde474b2c","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"af6323cebdeeeb4f0e86ddfddb9cf21cf251f27a98a8c02feb4f80e81d7a996a","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"128d586702c6aa6f1d1c56342f855d6255=
0063ea7df97c6c16abdb01fd6bf94e","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"061ca21386ad438be46e6c74f1=
87240636c3ae351b81ca61daae56681c7f6c35","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"23fb0653259a860b97abec8391d8f8766d1d6=
a3f77908112958bc4eda60af4cd","src/unix/mod.rs":"260101219eb92ed352920fad95b=
46362dec95e5206a4af4ee452327d3c20e629","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"6400cd5566e457fcfff211216ac86a49127f190b4b86=
3703e1e5096cc3f9c125","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"fd7d2ea12b221cde0=
655878ede3e983e0df514fc721e99f11d847c81803a0acd","src/unix/nto/neutrino.rs"=
:"2cef6af9943eec590b2b0af96a63bc3169e9d2af5c7713e3360eb09a807f248a","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"353dd905bddd5d7bbfa21c4367fc4a6f562a214a=
632e8dfd3fbdb330615342ae","src/unix/redox/mod.rs":"e6a2852f2366001ffaa4a60f=
f217db6f44dfad9118c64919b59da4d6bcceb93a","src/unix/solarish/compat.rs":"43=
46fbe9f8640868ac20b63bf3b52f883a37587e1df15ffe54fa0393a48a5588","src/unix/s=
olarish/illumos.rs":"c6305f2555bc542dd63ac0edbc8e517f65a7a870ef9c406d0809d2=
5c6c32276c","src/unix/solarish/mod.rs":"3d85a3033275983a0ad1386af9ca37c2611=
187958a5dbaa0a1b4851fbb764a92","src/unix/solarish/solaris.rs":"59466eb385fe=
fddac9a097ee3dab919df9043d2ac4061e31fe404c2c3ff5a23f","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"d888cd12da647f543df8cce7ae04e4a67f8647f71fd14c=
f7b4f968dbafcd4f5e","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"cf1adb4b57e016298a58af602f408a1f16ff639be994331e57cf=
f94285470b82","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"fefb225e1352776528=
68e8065849e4d8c6bfe4a4961614b4f34645282e1ebb95","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"d69f6aea427500cdf47898b87e0a5425382d46b5ef3f2f843818a6=
2372fa72f5","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"117169329309999=
2e19cddea4e8b849964e9846f4acee11b3948bcc337be8776"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"d4d202929497332d94acf48737a5cf4a2c5f53d25c93f67=
34df535b8b56bc30b","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"a3b7f6b5d63de50ad386146d4ab8126e=
4ce71b91f086861aaf3d7c2cd3a1426e","Cargo.toml":"08c008bd409b6862f7723b927d7=
cb50e83e093b336b306687f5b0356230cead2","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"b3115=
efae7f0487ed04d36bfaa0d6449db6448356a9cbeb3e10821d79008720d","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"d783900ea7e696ed25bb2f04c8714b0afdff0877d46=
418a29025c61e535254cd","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"a6de0a3c9a=
45e7af2f0bac96d73da6a7cfb8c003335183016b08a25e2acab65b","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"4d32db18cf39bf8b36fa0688bf2a7d2c9b3bb4c9664a1583fc203f008f8045a2","src/m=
acros.rs":"9697bfcb664007468f7e5a4bdb754ab554a5c12273d7576d2d78392f61d19e15=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"6ab902bad5bd5c97a6e300b354820602703f1f802071a8b=
7a935c42444c587ca","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"abe29e873d9492f46bef8a7596469ad4698af08=
7ab29619c059221b0f7c0fa91","src/unix/aix/powerpc64.rs":"6e1d1f50a58a8cb15f7=
a11cabfa8d7d2c0c5078d328d53c5fcf46bc706cf1a4d","src/unix/bsd/apple/b32/mod.=
rs":"76a5dce8b65aeb51626bb7316ab200015021dd87bddde86185cb424118c78528","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"75a313514fd3b9=
f21391ddb77f965386c36e99bbf4a4c952445e4e8d50bb16b5","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"996ae7cd5a730ec595fde9a02add78f9417086204538abb80f6d24c80a=
0b649b","src/unix/bsd/apple/mod.rs":"109b57bb1db39a37c1ca90eeaadcc9637c4bf3=
1d0df0bb53aab0778eb903750b","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"c542f3f05e161fb77f50d718fa7e52ce9f2dcc9=
dcb3a615d8d604a0a520febfe","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"f=
796f19f04336225de81151897387ce5e975a67510f400cdcc8f0048d5d484bb","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"f3e3410bbca7c6aa591f06b7215645da4ccceab82b=
9c478277eeffdf9310f92a","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"b1ddf661a8a331184e6b1134307ea25454547472a21c05752200b0700211=
0171","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"ed37853a6c281746=
424f7c2109122312faf2b81f862280918955a94906b79189","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
ac75d9267ab2f0c3432d4d173d417dd05306a8c63af6c050c67ed35a9c68dd6f","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"7cac2e91eb6afde7babbfd5dd593e038a1b711929c7d48110f3b430f921=
c478a","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"23f496d5e30ed99449efac7d2d28e6b72faee7ba644=
5a0ea92a0f9b44cc80fe1","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"90ef01d22cbb53af4f7fe88dae51fc04db018=
26d4dca4be5915c6a2c7a50c328","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"bfc3ac2f4e1d2136589181db2297c6f9d279fd160f00fe2c42bc0820978d7934","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"4843e5303d6c29756c5b62f2ceb4134e0d=
72a5f99c8a0b10892b3bb916e6dae3","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"94538d52efac5c8fea0c3ed30c1c9451820dd396f028b4159b908c1898987bc3","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"3a2c28e6cbfa27a4a663a85a2cd2bc3307613=
670f815c99650850629ab05150d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"f0af70c5b623224b3348ae9832272cb4940a45124e55fd2d0b0202930e4cf244","src/=
unix/bsd/freebsdlike/mod.rs":"2e7188c40dcbf437da93184184108d1f840b82bb04457=
d8002bf1a49f7f9f81c","src/unix/bsd/mod.rs":"c7322c39fadbd78cc957ea51a7c6490=
d07a630a6ae07ca397bd1e611adc5095a","src/unix/bsd/netbsdlike/mod.rs":"345a3a=
ca0dd0349c88ccb4b89857304e7523661f2dbf7761182123596d5e3eb9","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"851007845bd8743cea35ce9=
1a850d28c6aa2a0d543ac6946476c1d13ed4a2684","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"b3b6c85aa=
7dba31aa80c4668b2758a03feb43ea18f7a6f2dec183e00986e3709","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"caaf5a547299500=
d8a7b0a17214215916a53819e19cbc6ac392bef30f5982906","src/unix/cygwin/mod.rs"=
:"70a44e600a59a2003088ac517076183068b5ec84159f43c1bf05ba880aa1cfe4","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"211b4b9239a3f73f94c94ac30=
c96f01838d776f2df4e42e887e167b06c45446f","src/unix/haiku/native.rs":"4f52d1=
3ba164c6c4d138de445541d2358ca5c4f69898efd6c15c506c2f341a6f","src/unix/haiku=
/x86_64.rs":"09f2384474b2fcb7d0febb0e9e802610a627cadca29dc0e60eb4cfe15552f9=
78","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"e3dbad685a3d29dae=
510b438d29f692f6a8fdf37a422924915a36a3e854b1219","src/unix/linux_like/andro=
id/b32/arm.rs":"e68f6a15870a22e0383770ed1a5bd443d4c2ed237d16fea338c5da1ab9b=
f1fe3","src/unix/linux_like/android/b32/mod.rs":"5b10ebe56435d868846ae720bb=
9081cf814486722b5c13520fd4ef50a7ecfb58","src/unix/linux_like/android/b32/x8=
6/mod.rs":"d21913dab5d6b482106087297fbb643fd7cd3f83c01d56c1a1f8203dc57d8c16=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"ddc2932b78be316904019cd6209baccb1ce0732ad4332fecd99a7db0b5bf963a"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"7449054f5815b6d9f734867d97d60a4eff13c809fbf32272a40826137bd=
6469c","src/unix/linux_like/android/mod.rs":"983d08c419c3489bf83c283d2cd0c1=
f6312c8d0ff8bbc31b8c40259bbf3e1772","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"5baf8617a99b77897c1f226adf4e96a9582f356=
e3dd389a39fc4f1a75f052046","src/unix/linux_like/linux/arch/generic/mod.rs":=
"c8f4d88ba7ffe044c47fc84ca1e21751bfd2446806ccabbe8729958cbb5d1ccc","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"058ebf07f8b10358af9a7f66bd96ba14df1cc=
6a942203da9abe8d1abab00fcbb","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"0e20b7e63fe39a200cb4813eeb934bc25d91a242=
7cd1b1d81bc2cfa4e2368ed5","src/unix/linux_like/linux/arch/sparc/mod.rs":"96=
ed29a86c629657c521a5e12dece22e570ef7ceee9e8f4a58c2e0782d74e01d","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"33e971a4c2b20aada29a84fcae8b374664548f=
6d17462c03b031086d2c7bcb04","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"34e3a077861bb12baf7c97f7e4e8e1d52d58384337039361e09887b29c4f1ffe","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"07b89d105c91654079ed27cc373cc800a=
a4182f740dd5aa7a14ab756eb2968e6","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"1b0262dd90ba38e66c14404e8e07be11b9f1cc18fac1cd62db11e2b7e29dc673","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"050fa9856b151b3e33214b570cf7527ec=
a11eaa9145d40a1524824b5232b2500","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"7c3b9aad8856408517e056bdcfde877ca9d4529b9c39ffada70b56cdf244c403","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"5fa3d4b5f3c32251f5aa8c1130=
f3b7ccf37d66091734f43245ad3678cd216e9b","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"045c69c191b162532dd4e2a911542c31ce4fea5b800ff34834eecebd51c1=
6565","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"6ae9d44a8eac65d537f3d=
173d70846d6a31a962868a8c416e59ddc6c4e3b9bdb","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"6295789556ca344693fe9e2f7a0319429f2d579=
c2b912734767f2a0e15a8f5f5","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"713c94cb544ddddde3076fa3f27747507ecb6becc8e89a50adaea78f8abab64c","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"457279848453764fba944be61=
23c7fadd6ec9ccdfaa9e2c98d482f729a29acd5","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"30d1286c6b53a8c1cc090921a4192d5c05c7dbe0a7ff1aa4577774f9db934515"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"578fee223a62f2788352=
169b403d1547ae31d3e4be2806ab363b35239ed0aee2","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"1f6d2655bfdaf7e3c1030ede9cfd2608eaa29401e039c6a416e9=
a96bbccbe390","src/unix/linux_like/linux/gnu/b64/s390x.rs":"64fba1b75736ef6=
e22c11751c9daa3abd61af47b27da641d655e9ebb04b0f507","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8c3760938b956ea8944bc9d59defe02901427e343b140f3=
a94f00338daa13d36","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"5c815=
f9a2b85266b4be9999fb58037ead6388f360d07241fbdc4b054e584d5ba","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"fb6808e027f28dfb51a402f3bda4f8fca1a1=
e0513e19bc2ffa6278d5050ea9aa","src/unix/linux_like/linux/mod.rs":"e5bcfb003=
48a63f767f3cd37e8a3670f0228ca7a7cf26b5a3c5dcd996b5ad8ae","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"8bb6d0da8ac855120783a09d2ae07ea84696a4c65730=
9b2d0895d05d92be5e7b","src/unix/linux_like/linux/musl/b32/hexagon.rs":"1b0c=
68839dc46d00010d99e946f356d50dc4ad1c7468f99a8afe839f9542ebd0","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"46e9507a4a19b3f79206cea1ff14126f27bc67=
740bbae7e8c2c59634d733434f","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"03fa0663ca77029ebd5cf99b1a8c7fab0fbbb=
51087dd44b939dd1b03ffae17c8","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"fc1fb6028a892ef1b8ceefd0ce93e098b860ec347159f71578ed439122ab80fd","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"dc90270beefe8090d2a87f926302=
affb0656ef0f847b6c10d332758359675a59","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"835c57754ccacd0a8630ec14661a98b3b0bb06f13cb1586eb36d3fde3da=
1fd29","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"0be190a6aee=
332b19ff6f005f7ebc1ee3da61c7e0cc64aa049c4cf491027c250","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"9ccd2d9ed31459b33435c09fa47e2cdef386149d2df013f=
6810e7499cbdf634a","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"5ae8c86a5939c021ee8f298ca0c141b5f323c4e7df3b=
0b8d0e59d493207ed4b5","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
f3893250f00da52e6895a39ca20947748340cab0c2176f2fbcc44f8a3d1df696","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"9174e156d17f09de2c4975e974af40eaa3726=
f11d44e17077eb2e9efaf91d0a9","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"503278ab86dfdbdd1f59188333162602744f413c937dcf132f97bc16ec03b943","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"32b422900fc8831c718620dcd102fd91f4c819946a2b7cdab1df9ed7d=
b5b8577","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"17543653f63f7c0acb96857b42ebcf5591e225322c7e3fc2de7b750712642c11",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"a90c7811623714e168b676aa50b1=
62931e66ce86f8c59b0acac131afde474b2c","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"af6323cebdeeeb4f0e86ddfddb9cf21cf251f27a98a8c02=
feb4f80e81d7a996a","src/unix/linux_like/linux/uclibc/mod.rs":"128d586702c6a=
a6f1d1c56342f855d62550063ea7df97c6c16abdb01fd6bf94e","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"061ca=
21386ad438be46e6c74f187240636c3ae351b81ca61daae56681c7f6c35","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"23fb0653259a860b=
97abec8391d8f8766d1d6a3f77908112958bc4eda60af4cd","src/unix/mod.rs":"260101=
219eb92ed352920fad95b46362dec95e5206a4af4ee452327d3c20e629","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"6400cd5566e457fcfff2112=
16ac86a49127f190b4b863703e1e5096cc3f9c125","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"fd7d2ea12b221cde0655878ede3e983e0df514fc721e99f11d847c81803a0acd","src/=
unix/nto/neutrino.rs":"2cef6af9943eec590b2b0af96a63bc3169e9d2af5c7713e3360e=
b09a807f248a","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"353dd905bddd5d7bbfa=
21c4367fc4a6f562a214a632e8dfd3fbdb330615342ae","src/unix/redox/mod.rs":"e6a=
2852f2366001ffaa4a60ff217db6f44dfad9118c64919b59da4d6bcceb93a","src/unix/so=
larish/compat.rs":"4346fbe9f8640868ac20b63bf3b52f883a37587e1df15ffe54fa0393=
a48a5588","src/unix/solarish/illumos.rs":"c6305f2555bc542dd63ac0edbc8e517f6=
5a7a870ef9c406d0809d25c6c32276c","src/unix/solarish/mod.rs":"3d85a303327598=
3a0ad1386af9ca37c2611187958a5dbaa0a1b4851fbb764a92","src/unix/solarish/sola=
ris.rs":"59466eb385fefddac9a097ee3dab919df9043d2ac4061e31fe404c2c3ff5a23f",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"d888cd12da647f543df8cce7a=
e04e4a67f8647f71fd14cf7b4f968dbafcd4f5e","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"cf1adb4b57e016298a58af602f408a1=
f16ff639be994331e57cff94285470b82","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"fefb225e135277652868e8065849e4d8c6bfe4a4961614b4f34645282e1ebb95","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"d69f6aea427500cdf47898b87e0a54253=
82d46b5ef3f2f843818a62372fa72f5","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"1171693293099992e19cddea4e8b849964e9846f4acee11b3948bcc337be8776"}
++{"files":{".cargo_vcs_info.json":"9e3f383a0671ce544ba60129f113826026bfd39=
d6f9a2f7323198c88a462be44",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"d4d=
202929497332d94acf48737a5cf4a2c5f53d25c93f6734df535b8b56bc30b","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"a3b7f6b5d63de50ad386146d4ab8126e4ce71b91f086861aaf3d7c2cd3a1426=
e","Cargo.toml":"08c008bd409b6862f7723b927d7cb50e83e093b336b306687f5b035623=
0cead2","Cargo.toml.orig":"647a491d157e1afbeea48f635be858ab1b1c9c2064c24d15=
a1e30808c6d7bd35","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"b3115efae7f0487ed04d36bfaa=
0d6449db6448356a9cbeb3e10821d79008720d","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"d783900ea7e696ed25bb2f04c8714b0afdff0877d46418a29025c61e535254cd=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"a6de0a3c9a45e7af2f0bac96d73da6a=
7cfb8c003335183016b08a25e2acab65b","src/hermit.rs":"f150c2882a4d8e510259697=
ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs":"4d32db18cf39bf8b36=
fa0688bf2a7d2c9b3bb4c9664a1583fc203f008f8045a2","src/macros.rs":"9697bfcb66=
4007468f7e5a4bdb754ab554a5c12273d7576d2d78392f61d19e15","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"6ab902bad5bd5c97a6e300b354820602703f1f802071a8b7a935c42444c587ca","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"abe29e873d9492f46bef8a7596469ad4698af087ab29619c059221b0f7c0=
fa91","src/unix/aix/powerpc64.rs":"6e1d1f50a58a8cb15f7a11cabfa8d7d2c0c5078d=
328d53c5fcf46bc706cf1a4d","src/unix/bsd/apple/b32/mod.rs":"76a5dce8b65aeb51=
626bb7316ab200015021dd87bddde86185cb424118c78528","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"75a313514fd3b9f21391ddb77f965386c36=
e99bbf4a4c952445e4e8d50bb16b5","src/unix/bsd/apple/b64/x86_64/mod.rs":"996a=
e7cd5a730ec595fde9a02add78f9417086204538abb80f6d24c80a0b649b","src/unix/bsd=
/apple/mod.rs":"109b57bb1db39a37c1ca90eeaadcc9637c4bf31d0df0bb53aab0778eb90=
3750b","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"c542f3f05e161fb77f50d718fa7e52ce9f2dcc9dcb3a615d8d604a0a520f=
ebfe","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"f796f19f04336225de8115=
1897387ce5e975a67510f400cdcc8f0048d5d484bb","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"f3e3410bbca7c6aa591f06b7215645da4ccceab82b9c478277eeffdf9310f92=
a","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"b1ddf6=
61a8a331184e6b1134307ea25454547472a21c05752200b07002110171","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"ed37853a6c281746424f7c2109122312faf2b=
81f862280918955a94906b79189","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"ac75d9267ab2f0c3432d4=
d173d417dd05306a8c63af6c050c67ed35a9c68dd6f","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"7cac2=
e91eb6afde7babbfd5dd593e038a1b711929c7d48110f3b430f921c478a","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"23f496d5e30ed99449efac7d2d28e6b72faee7ba6445a0ea92a0f9b44cc80fe1=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"90ef01d22cbb53af4f7fe88dae51fc04db01826d4dca4be5915c6a2c7a=
50c328","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"bfc3ac2f4e1d21365891=
81db2297c6f9d279fd160f00fe2c42bc0820978d7934","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"4843e5303d6c29756c5b62f2ceb4134e0d72a5f99c8a0b10892b3bb=
916e6dae3","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"94538d52efac5c8fe=
a0c3ed30c1c9451820dd396f028b4159b908c1898987bc3","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"3a2c28e6cbfa27a4a663a85a2cd2bc3307613670f815c99650850629ab=
05150d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"f0af70c5b623224b3=
348ae9832272cb4940a45124e55fd2d0b0202930e4cf244","src/unix/bsd/freebsdlike/=
mod.rs":"2e7188c40dcbf437da93184184108d1f840b82bb04457d8002bf1a49f7f9f81c",=
"src/unix/bsd/mod.rs":"c7322c39fadbd78cc957ea51a7c6490d07a630a6ae07ca397bd1=
e611adc5095a","src/unix/bsd/netbsdlike/mod.rs":"345a3aca0dd0349c88ccb4b8985=
7304e7523661f2dbf7761182123596d5e3eb9","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"851007845bd8743cea35ce91a850d28c6aa2a0d543ac=
6946476c1d13ed4a2684","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"b3b6c85aa7dba31aa80c4668b2758a=
03feb43ea18f7a6f2dec183e00986e3709","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"caaf5a547299500d8a7b0a17214215916a53=
819e19cbc6ac392bef30f5982906","src/unix/cygwin/mod.rs":"70a44e600a59a200308=
8ac517076183068b5ec84159f43c1bf05ba880aa1cfe4","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"211b4b9239a3f73f94c94ac30c96f01838d776f2df4e42=
e887e167b06c45446f","src/unix/haiku/native.rs":"4f52d13ba164c6c4d138de44554=
1d2358ca5c4f69898efd6c15c506c2f341a6f","src/unix/haiku/x86_64.rs":"09f23844=
74b2fcb7d0febb0e9e802610a627cadca29dc0e60eb4cfe15552f978","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"e3dbad685a3d29dae510b438d29f692f6a8fdf=
37a422924915a36a3e854b1219","src/unix/linux_like/android/b32/arm.rs":"e68f6=
a15870a22e0383770ed1a5bd443d4c2ed237d16fea338c5da1ab9bf1fe3","src/unix/linu=
x_like/android/b32/mod.rs":"5b10ebe56435d868846ae720bb9081cf814486722b5c135=
20fd4ef50a7ecfb58","src/unix/linux_like/android/b32/x86/mod.rs":"d21913dab5=
d6b482106087297fbb643fd7cd3f83c01d56c1a1f8203dc57d8c16","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"ddc2932b78b=
e316904019cd6209baccb1ce0732ad4332fecd99a7db0b5bf963a","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"74490=
54f5815b6d9f734867d97d60a4eff13c809fbf32272a40826137bd6469c","src/unix/linu=
x_like/android/mod.rs":"983d08c419c3489bf83c283d2cd0c1f6312c8d0ff8bbc31b8c4=
0259bbf3e1772","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"5baf8617a99b77897c1f226adf4e96a9582f356e3dd389a39fc4f1a75f05=
2046","src/unix/linux_like/linux/arch/generic/mod.rs":"c8f4d88ba7ffe044c47f=
c84ca1e21751bfd2446806ccabbe8729958cbb5d1ccc","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"058ebf07f8b10358af9a7f66bd96ba14df1cc6a942203da9abe8d1abab=
00fcbb","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"0e20b7e63fe39a200cb4813eeb934bc25d91a2427cd1b1d81bc2cfa4e2368=
ed5","src/unix/linux_like/linux/arch/sparc/mod.rs":"96ed29a86c629657c521a5e=
12dece22e570ef7ceee9e8f4a58c2e0782d74e01d","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"33e971a4c2b20aada29a84fcae8b374664548f6d17462c03b031086d2c7=
bcb04","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"34e3a077861bb12baf7=
c97f7e4e8e1d52d58384337039361e09887b29c4f1ffe","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"07b89d105c91654079ed27cc373cc800aa4182f740dd5aa7a14ab7=
56eb2968e6","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"1b0262dd90ba38=
e66c14404e8e07be11b9f1cc18fac1cd62db11e2b7e29dc673","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"050fa9856b151b3e33214b570cf7527eca11eaa9145d40a1524824=
b5232b2500","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"7c3b9aad8856408=
517e056bdcfde877ca9d4529b9c39ffada70b56cdf244c403","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"5fa3d4b5f3c32251f5aa8c1130f3b7ccf37d66091734f43=
245ad3678cd216e9b","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"045c69=
c191b162532dd4e2a911542c31ce4fea5b800ff34834eecebd51c16565","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"6ae9d44a8eac65d537f3d173d70846d6a31a962868=
a8c416e59ddc6c4e3b9bdb","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"6295789556ca344693fe9e2f7a0319429f2d579c2b912734767f2a0e15a8=
f5f5","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"713c94cb544dd=
ddde3076fa3f27747507ecb6becc8e89a50adaea78f8abab64c","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"457279848453764fba944be6123c7fadd6ec9ccdfaa9e2=
c98d482f729a29acd5","src/unix/linux_like/linux/gnu/b64/mod.rs":"30d1286c6b5=
3a8c1cc090921a4192d5c05c7dbe0a7ff1aa4577774f9db934515","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"578fee223a62f2788352169b403d1547ae31d3e4b=
e2806ab363b35239ed0aee2","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"1f6d2655bfdaf7e3c1030ede9cfd2608eaa29401e039c6a416e9a96bbccbe390","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"64fba1b75736ef6e22c11751c9daa3abd61a=
f47b27da641d655e9ebb04b0f507","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8c3760938b956ea8944bc9d59defe02901427e343b140f3a94f00338daa13d36","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"5c815f9a2b85266b4be9999fb5=
8037ead6388f360d07241fbdc4b054e584d5ba","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"fb6808e027f28dfb51a402f3bda4f8fca1a1e0513e19bc2ffa6278d50=
50ea9aa","src/unix/linux_like/linux/mod.rs":"e5bcfb00348a63f767f3cd37e8a367=
0f0228ca7a7cf26b5a3c5dcd996b5ad8ae","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"8bb6d0da8ac855120783a09d2ae07ea84696a4c657309b2d0895d05d92be5e7b"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"1b0c68839dc46d00010d99e94=
6f356d50dc4ad1c7468f99a8afe839f9542ebd0","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"46e9507a4a19b3f79206cea1ff14126f27bc67740bbae7e8c2c59634d73=
3434f","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"03fa0663ca77029ebd5cf99b1a8c7fab0fbbb51087dd44b939dd1b03ff=
ae17c8","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"fc1fb6028a892e=
f1b8ceefd0ce93e098b860ec347159f71578ed439122ab80fd","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"dc90270beefe8090d2a87f926302affb0656ef0f847b6c10d=
332758359675a59","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"835c5=
7754ccacd0a8630ec14661a98b3b0bb06f13cb1586eb36d3fde3da1fd29","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"0be190a6aee332b19ff6f005f7ebc1ee=
3da61c7e0cc64aa049c4cf491027c250","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"9ccd2d9ed31459b33435c09fa47e2cdef386149d2df013f6810e7499cbdf634a","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c01bc412b3e13a0d41102e5=
8a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"5ae8c86a5939c021ee8f298ca0c141b5f323c4e7df3b0b8d0e59d493207ed4b5"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"f3893250f00da52e6895a=
39ca20947748340cab0c2176f2fbcc44f8a3d1df696","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"9174e156d17f09de2c4975e974af40eaa3726f11d44e17077eb2e9efaf=
91d0a9","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"503278ab86dfdbd=
d1f59188333162602744f413c937dcf132f97bc16ec03b943","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"32b=
422900fc8831c718620dcd102fd91f4c819946a2b7cdab1df9ed7db5b8577","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"17543653f63f=
7c0acb96857b42ebcf5591e225322c7e3fc2de7b750712642c11","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"a90c7811623714e168b676aa50b162931e66ce86f8c59b0ac=
ac131afde474b2c","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"af6323cebdeeeb4f0e86ddfddb9cf21cf251f27a98a8c02feb4f80e81d7a996a","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"128d586702c6aa6f1d1c56342f855d6255=
0063ea7df97c6c16abdb01fd6bf94e","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"061ca21386ad438be46e6c74f1=
87240636c3ae351b81ca61daae56681c7f6c35","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"23fb0653259a860b97abec8391d8f8766d1d6=
a3f77908112958bc4eda60af4cd","src/unix/mod.rs":"260101219eb92ed352920fad95b=
46362dec95e5206a4af4ee452327d3c20e629","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"6400cd5566e457fcfff211216ac86a49127f190b4b86=
3703e1e5096cc3f9c125","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"fd7d2ea12b221cde0=
655878ede3e983e0df514fc721e99f11d847c81803a0acd","src/unix/nto/neutrino.rs"=
:"2cef6af9943eec590b2b0af96a63bc3169e9d2af5c7713e3360eb09a807f248a","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"353dd905bddd5d7bbfa21c4367fc4a6f562a214a=
632e8dfd3fbdb330615342ae","src/unix/redox/mod.rs":"e6a2852f2366001ffaa4a60f=
f217db6f44dfad9118c64919b59da4d6bcceb93a","src/unix/solarish/compat.rs":"43=
46fbe9f8640868ac20b63bf3b52f883a37587e1df15ffe54fa0393a48a5588","src/unix/s=
olarish/illumos.rs":"c6305f2555bc542dd63ac0edbc8e517f65a7a870ef9c406d0809d2=
5c6c32276c","src/unix/solarish/mod.rs":"3d85a3033275983a0ad1386af9ca37c2611=
187958a5dbaa0a1b4851fbb764a92","src/unix/solarish/solaris.rs":"59466eb385fe=
fddac9a097ee3dab919df9043d2ac4061e31fe404c2c3ff5a23f","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"d888cd12da647f543df8cce7ae04e4a67f8647f71fd14c=
f7b4f968dbafcd4f5e","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"cf1adb4b57e016298a58af602f408a1f16ff639be994331e57cf=
f94285470b82","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"fefb225e1352776528=
68e8065849e4d8c6bfe4a4961614b4f34645282e1ebb95","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"d69f6aea427500cdf47898b87e0a5425382d46b5ef3f2f843818a6=
2372fa72f5","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"117169329309999=
2e19cddea4e8b849964e9846f4acee11b3948bcc337be8776"}
 --- a/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
 +++ b/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
 @@ -633,3 +633,23 @@ pub const SYS_faccessat2: c_long =3D 439;
@@ -76,6 +76,6 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 --- a/vendor/libc-0.2.172/.cargo-checksum.json
 +++ b/vendor/libc-0.2.172/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"346dd2531ef95edd4f55cdbd1bae011599905025ccb8c49=
9ab2f0906a7e1e9f4","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"56c4dfee156428a661f3351c2c7c91bb=
499b79f7a37617b3735d2d4a34d0e92a","Cargo.toml":"56ad89d6913657901ac241f5d2f=
f433e1f7aabc5e565494b8dea2970101fd4d4","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33=
b16dfe94388f70255bd0d009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"0f7a9de19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa3=
6b10","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59e=
f486aeb4d97effa5800ac4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
b55b4a4953da9240b243edc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"05a9cdf865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d=
28357","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd80=
8ab81ee9422ef2d506cc7","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7e=
dc83b45ff4efac750a8c79f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f8201672=
2f1e5d8de35635b4ee745830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"8f122bd9fd1fa155045ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"f92637aaf3edb4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa=
8b0faf88b914b938c86ddbcc7146515220","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"ecfca2e786d13fd5971a851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc=
1fd9db2b6aa525db11764d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8=
fa8bd7a4e49bf0e143a8d87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"7b70846d26c4daef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281=
f53c32c042a33f94a4a33391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"27fe942d85f2a22b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"1589a8a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f48721=
8ba4","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310=
d51eebd386e12e8595874e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f571=
4c5b8a01fea7ba3b5781cbe4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076e=
cf8c14e6f07659cfbc5e49ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"6368f45ada05676c98a394194e715756760eabff9721=
0d2d65a1c6e7104d63ce","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b=
126bddea758cb01854d49fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"13335be149517d72bacf8cb4cc1a54a17217f2436daeca4f9646379d40bd6c6a","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718=
aff0bfe01967fe3bf1fde5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"f5dfcb0b4bc2a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae=
4c03c41038c43b374847e2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"183cd281f404e8d6=
4563383343216e90f604c0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a977=
37d394fa7b293068fffa1554e08a8a484a40de985a865e61b6f694cab8","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"9cfcdbb158f3c9b86b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0a=
a3adcce005021018db93f814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5a=
fadfc34e33ace8bd4154e471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/so=
larish/compat.rs":"dd69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4=
d20b676c","src/unix/solarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6f=
be1f94c2d5c5c26d634e38bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e853=
1df71b89e4aee1ab4d3b3b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/sola=
ris.rs":"ffc34e8c4049588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230c=
f4cad6637c45a4022af297a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
+-{"files":{".cargo_vcs_info.json":"e9388a6ce12521c5a43426c80f605d9ff4895ea=
5a824af7a1e195c6aa6f9d297",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"346=
dd2531ef95edd4f55cdbd1bae011599905025ccb8c499ab2f0906a7e1e9f4","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"56c4dfee156428a661f3351c2c7c91bb499b79f7a37617b3735d2d4a34d0e92=
a","Cargo.toml":"56ad89d6913657901ac241f5d2ff433e1f7aabc5e565494b8dea297010=
1fd4d4","Cargo.toml.orig":"9fe01b43f2e1f08e72fe6a6b900e11f0fad4647d6f38eba1=
ff55503d3a72a58c","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33b16dfe94388f70255bd0d=
009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01d97a9a880d9d7be6d9f7f=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f81b1d7c962671aa074d70=
9c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f150c2882a4d8e510259697=
ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs":"d65975abfeac27f8db=
ef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/macros.rs":"076f328df1=
d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab547719b8ae2b371f9cb21","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa230f14965ee808eeab288=
4408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75ef15f85989f8feffb4f38b=
ac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.rs":"39a7f5cf92cf2d26=
ca50f54182fe57028cf24147ec12cb89d251301d65862138","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2edadb39db562e655ea5efdb1=
02ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64/x86_64/mod.rs":"71ba=
d5c051368805146168c4063534b010afcb358477c1f164712bb015bf3fb6","src/unix/bsd=
/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad85361e6b1389f699b2b88d46a=
a3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f7584d3fe4ab43bc7967dd=
0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9e8e5a9f1de648b248f257=
aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3910e19b082130811c2f28=
9","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"0f7a9d=
e19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa36b10","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59ef486aeb4d97effa5800ac=
4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"b55b4a4953da9240b243e=
dc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"05a9c=
df865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d28357","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd808ab81ee9422ef2d506cc7=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7edc83b45ff4efac750a8c7=
9f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36a03b20551864c92852=
e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e3c96854c58b7a478b9972=
407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"3dfdc394922c2cb66=
790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a7650d2773a009b269bbceafd=
819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"85b4b6118ef4e08a7=
4b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/unix/bsd/freebsdlike/=
mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59d04e0f2978722c68101",=
"src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c9b9d27e9e21c0e4bafb6f=
1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b617c42084db1bd3aa4f5d5d=
1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f82016722f1e5d8de35635b4ee745=
830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95e324e90e3a7c8905c5930=
25f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f107e9cfd8e7e7e0d494567=
5a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs":"8f122bd9fd1fa155045=
ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab8303dc7604488bf7e0b75=
33fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3=
a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"4480c042=
3eac3f288202df587b54025292633869a868bd0ac2767cd40afb5173","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d01bd36bb5e6541cddbe62=
858571328a03c6b7bb8a208262","src/unix/linux_like/android/b32/arm.rs":"06dfd=
e862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/linu=
x_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa2c0c=
33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942e15c=
6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"f92637aaf3e=
db4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"cab0e=
8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/linu=
x_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa8b0faf88b914b938c86dd=
bcc7146515220","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b0780a3c430b2f098715e4=
153a","src/unix/linux_like/linux/arch/generic/mod.rs":"ecfca2e786d13fd5971a=
851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc1fd9db2b6aa525db11764=
d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759ae0871c13b91fce43ad152=
351","src/unix/linux_like/linux/arch/sparc/mod.rs":"9735216185ae78271e8333f=
8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8fa8bd7a4e49bf0e143a8d=
87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e1c53b84e1c13d91d94=
a44da0c3f120788c135d4253834782db57cccf0a39db4","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e21f299975a6d82a6472950=
6781259e43","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"7b70846d26c4da=
ef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281f53c32c042a33f94a4a33=
391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"27fe942d85f2a22=
b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe839915dbef9b2bcc1bea5484ef=
a4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"1589a8=
a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f487218ba4","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310d51eebd386e12e8595874=
e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596e16c=
d640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046086c=
6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168ddc1=
27315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"d1d38f4a25d=
885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e6433109ec0=
0260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02c53b=
df3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc444c2550be09ccf7a4231=
024b8af4acd6024de81da110ad932b62707698","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f5714c5b8a01fea7ba3b5781c=
be4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076ecf8c14e6f07659cfbc5e4=
9ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"6368f45ada05676c98a394194e715756760eabff97210d2d65a1c6e7104d63ce"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"400457049bad619da3accbca2=
c841206d1cd2673d670baf7210bf17427510271","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f04015e6c4dcf3b3e3061a7538=
bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b126bddea758cb01854d49=
fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"13335be149517d=
72bacf8cb4cc1a54a17217f2436daeca4f9646379d40bd6c6a","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718aff0bfe01967fe3bf1fde=
5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"ef117=
d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a9b72=
5766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c01bc412b3e13a0d41102e5=
8a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697466"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc3811d7=
2f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461be33=
fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"f44f7b2ade822aa=
468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a31=
7282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"f5dfcb0b4bc2=
a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842ce62b295bc0bd9eaf1b5f=
9792e442b681090","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae4c03c41038c43b374847e=
2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c37752975c173aeb1641bae0e7=
43ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"183cd281f404e8d64563383343216e90f604c=
0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a97737d394fa7b293068fffa1=
554e08a8a484a40de985a865e61b6f694cab8","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7=
f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"9cfcdbb158f3c9b86=
b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/unix/nto/neutrino.rs"=
:"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0aa3adcce005021018db93f=
814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5afadfc34e33ace8bd4154e=
471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/solarish/compat.rs":"dd=
69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4d20b676c","src/unix/s=
olarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6fbe1f94c2d5c5c26d634e3=
8bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e8531df71b89e4aee1ab4d3b3=
b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/solaris.rs":"ffc34e8c4049=
588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde=
103592922ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230cf4cad6637c45a4022af29=
7a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd188=
0e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37=
a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"d750af042f7ef4f=
724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"346dd2531ef95edd4f55cdbd1bae011599905025ccb8c49=
9ab2f0906a7e1e9f4","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"56c4dfee156428a661f3351c2c7c91bb=
499b79f7a37617b3735d2d4a34d0e92a","Cargo.toml":"56ad89d6913657901ac241f5d2f=
f433e1f7aabc5e565494b8dea2970101fd4d4","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33=
b16dfe94388f70255bd0d009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"0f7a9de19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa3=
6b10","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59e=
f486aeb4d97effa5800ac4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
b55b4a4953da9240b243edc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"05a9cdf865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d=
28357","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd80=
8ab81ee9422ef2d506cc7","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7e=
dc83b45ff4efac750a8c79f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f8201672=
2f1e5d8de35635b4ee745830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"8f122bd9fd1fa155045ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"f92637aaf3edb4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa=
8b0faf88b914b938c86ddbcc7146515220","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"ecfca2e786d13fd5971a851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc=
1fd9db2b6aa525db11764d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8=
fa8bd7a4e49bf0e143a8d87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"7b70846d26c4daef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281=
f53c32c042a33f94a4a33391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"27fe942d85f2a22b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"1589a8a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f48721=
8ba4","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310=
d51eebd386e12e8595874e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f571=
4c5b8a01fea7ba3b5781cbe4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076e=
cf8c14e6f07659cfbc5e49ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"6368f45ada05676c98a394194e715756760eabff9721=
0d2d65a1c6e7104d63ce","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b=
126bddea758cb01854d49fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"b076c7f32ef6137e96c50a6e6b45fe4ba0f84ef4505b0094a2afbe0a7b2d92f2","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718=
aff0bfe01967fe3bf1fde5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"f5dfcb0b4bc2a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae=
4c03c41038c43b374847e2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"183cd281f404e8d6=
4563383343216e90f604c0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a977=
37d394fa7b293068fffa1554e08a8a484a40de985a865e61b6f694cab8","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"9cfcdbb158f3c9b86b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0a=
a3adcce005021018db93f814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5a=
fadfc34e33ace8bd4154e471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/so=
larish/compat.rs":"dd69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4=
d20b676c","src/unix/solarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6f=
be1f94c2d5c5c26d634e38bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e853=
1df71b89e4aee1ab4d3b3b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/sola=
ris.rs":"ffc34e8c4049588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230c=
f4cad6637c45a4022af297a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
++{"files":{".cargo_vcs_info.json":"e9388a6ce12521c5a43426c80f605d9ff4895ea=
5a824af7a1e195c6aa6f9d297",".git-blame-ignore-revs":"761aa385c661241fa77c15=
b502c361398cf500bbb9f8c3a4579b412c4c6249d7",".release-plz.toml":"fcf2d382c4=
a2abd96caf9cc391b63e0c94d5832f5c48e9ab9eb4b2c847c0887c","CHANGELOG.md":"346=
dd2531ef95edd4f55cdbd1bae011599905025ccb8c499ab2f0906a7e1e9f4","CONTRIBUTIN=
G.md":"155e7f4e96fafe9ee5c8adb5068be27a22de89a95ca9bfc7baf517b9850d20d6","C=
argo.lock":"56c4dfee156428a661f3351c2c7c91bb499b79f7a37617b3735d2d4a34d0e92=
a","Cargo.toml":"56ad89d6913657901ac241f5d2ff433e1f7aabc5e565494b8dea297010=
1fd4d4","Cargo.toml.orig":"9fe01b43f2e1f08e72fe6a6b900e11f0fad4647d6f38eba1=
ff55503d3a72a58c","LICENSE-APACHE":"62c7a1e35f56406896d7aa7ca52d0cc0d272ac0=
22b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56a8932dba07660672=
dbfe3004257ca8de708aac1415937a1","README.md":"a198be444453fe0b24d4fb6a8b732=
eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33b16dfe94388f70255bd0d=
009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml":"e9321ff995242e8cb0a=
4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fuchsia/aarch64.rs":"9c=
d032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729fa43b5738","src/fuchsi=
a/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01d97a9a880d9d7be6d9f7f=
","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41aafc63c5db293b93113fa=
973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f81b1d7c962671aa074d70=
9c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f150c2882a4d8e510259697=
ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs":"d65975abfeac27f8db=
ef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/macros.rs":"076f328df1=
d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a","src/primitives.rs"=
:"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe92594339a547b","src/ps=
p.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab547719b8ae2b371f9cb21","s=
rc/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5c338070b6a4cd156ebc9e=
6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926=
b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858fc249f3b6858af5009851c=
8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045b6089af91bd533a666773=
d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs":"bfdcaf0268d79652ee=
52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/teeos/mod.rs":"2cca695=
904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7795","src/trusty.rs":=
"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a49c77f65e22","src/uni=
x/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa230f14965ee808eeab288=
4408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75ef15f85989f8feffb4f38b=
ac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.rs":"39a7f5cf92cf2d26=
ca50f54182fe57028cf24147ec12cb89d251301d65862138","src/unix/bsd/apple/b64/a=
arch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc49a1695a708b12dff2ee01=
f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2edadb39db562e655ea5efdb1=
02ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64/x86_64/mod.rs":"71ba=
d5c051368805146168c4063534b010afcb358477c1f164712bb015bf3fb6","src/unix/bsd=
/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad85361e6b1389f699b2b88d46a=
a3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"07b19390b9ae8f541ac35=
fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix/bsd/freebsdlike/drag=
onfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f7584d3fe4ab43bc7967dd=
0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9e8e5a9f1de648b248f257=
aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/bsd/freebsdlike/freeb=
sd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3910e19b082130811c2f28=
9","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs":"8d9bef35f3e490d0475=
5a59a99ad054ef20498beff979ae8b14acbec1097318a","src/unix/bsd/freebsdlike/fr=
eebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14afae7261827ec4838d26719=
290466efc4f023","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.rs":"0f7a9d=
e19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa36b10","src/unix/bsd/f=
reebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59ef486aeb4d97effa5800ac=
4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike/freebsd/freebsd12/x8=
6_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004692a56cee44be21"=
,"src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"b55b4a4953da9240b243e=
dc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix/bsd/freebsdlike/free=
bsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa14004=
692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"05a9c=
df865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d28357","src/unix/bsd/=
freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109dc779efe5584b79d34fcd=
6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/freebsd/freebsd1=
5/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd808ab81ee9422ef2d506cc7=
","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.rs":"d6e66809e109dc779=
efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsdlike/=
freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7edc83b45ff4efac750a8c7=
9f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":"36a03b20551864c92852=
e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/unix/bsd/freebsdlike/fre=
ebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e3c96854c58b7a478b9972=
407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.rs":"3dfdc394922c2cb66=
790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/unix/bsd/freebsdlike/=
freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a7650d2773a009b269bbceafd=
819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"85b4b6118ef4e08a7=
4b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/unix/bsd/freebsdlike/=
mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59d04e0f2978722c68101",=
"src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c9b9d27e9e21c0e4bafb6f=
1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b617c42084db1bd3aa4f5d5d=
1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/netbsdlike/netbsd/aarc=
h64.rs":"bd36c92099db501350fb8617414d1fea89a6bb12867498e1821167813ab70a02",=
"src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e7be9ccd4fef6e3be7db79=
ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdlike/netbsd/mips.rs":"d=
1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff4424b102bc7","src/unix/=
bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f82016722f1e5d8de35635b4ee745=
830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"94494f34=
8f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b94","src/unix/bsd/net=
bsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167cfb10b91580ffbf5831007=
89a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"d50816e8302=
25779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c","src/unix/bsd/netbsd=
like/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c302599b0fd2b0ee7b5c48=
0177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"4ced76b3640d465f6de=
ad8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/unix/bsd/netbsdlike/ope=
nbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f2501a2b5d35107db3babb=
896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81c71e1cfe436b8f32cfe06=
4991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/=
mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493cc42bcb9829c1e47e4b05f=
5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95e324e90e3a7c8905c5930=
25f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netbsdlike/openbsd/powerp=
c.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","s=
rc/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813fe2fd7ca66ee8d70d13887=
b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/netbsdlike/openbsd/riscv=
64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8f50a7fb3c7e1f89ac6","=
src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4cae63e09e1c156164ddc82e=
0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netbsdlike/openbsd/x86.rs=
":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7a1836f83ac56a","src/u=
nix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f107e9cfd8e7e7e0d494567=
5a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs":"8f122bd9fd1fa155045=
ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/unix/haiku/b32.rs":"c3f=
8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/unix/ha=
iku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c27d2=
42","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab8303dc7604488bf7e0b75=
33fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7daab134d37ed260373f9c3=
a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"4480c042=
3eac3f288202df587b54025292633869a868bd0ac2767cd40afb5173","src/unix/hurd/b3=
2.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123","s=
rc/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd78af=
f0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d01bd36bb5e6541cddbe62=
858571328a03c6b7bb8a208262","src/unix/linux_like/android/b32/arm.rs":"06dfd=
e862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/linu=
x_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa2c0c=
33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942e15c=
6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux_lik=
e/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce152f2=
5d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"f92637aaf3e=
db4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5","src/unix/linux_like=
/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7ba87c=
aef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"cab0e=
8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/linu=
x_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa8b0faf88b914b938c86dd=
bcc7146515220","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16525a=
578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/emscr=
ipten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b0780a3c430b2f098715e4=
153a","src/unix/linux_like/linux/arch/generic/mod.rs":"ecfca2e786d13fd5971a=
851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/unix/linux_like/linux/ar=
ch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc1fd9db2b6aa525db11764=
d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f124ac7=
6ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch/pow=
erpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759ae0871c13b91fce43ad152=
351","src/unix/linux_like/linux/arch/sparc/mod.rs":"9735216185ae78271e8333f=
8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/linux_like/linux/gnu/b=
32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8fa8bd7a4e49bf0e143a8d=
87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e1c53b84e1c13d91d94=
a44da0c3f120788c135d4253834782db57cccf0a39db4","src/unix/linux_like/linux/g=
nu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e21f299975a6d82a6472950=
6781259e43","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"7b70846d26c4da=
ef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","src/unix/linux_like/li=
nux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281f53c32c042a33f94a4a33=
391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"27fe942d85f2a22=
b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","src/unix/linux_like/lin=
ux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe839915dbef9b2bcc1bea5484ef=
a4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"1589a8=
a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f487218ba4","src/unix/linux=
_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310d51eebd386e12e8595874=
e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu/b64/aarch64/ilp32.rs=
":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","src/u=
nix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04c369=
e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b64/aa=
rch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596e16c=
d640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046086c=
6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_like/l=
inux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168ddc1=
27315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"d1d38f4a25d=
885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42","src/unix/linux_like=
/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e6433109ec0=
0260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod.rs"=
:"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","src/un=
ix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02c53b=
df3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc64/mo=
d.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7","s=
rc/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc444c2550be09ccf7a4231=
024b8af4acd6024de81da110ad932b62707698","src/unix/linux_like/linux/gnu/b64/=
x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c58ac2=
e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b781dfe=
6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_like/l=
inux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f5714c5b8a01fea7ba3b5781c=
be4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076ecf8c14e6f07659cfbc5e4=
9ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_like/linux/musl/b32/arm=
/mod.rs":"6368f45ada05676c98a394194e715756760eabff97210d2d65a1c6e7104d63ce"=
,"src/unix/linux_like/linux/musl/b32/hexagon.rs":"400457049bad619da3accbca2=
c841206d1cd2673d670baf7210bf17427510271","src/unix/linux_like/linux/musl/b3=
2/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f04015e6c4dcf3b3e3061a7538=
bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b25cce=
cf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/musl/=
b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b126bddea758cb01854d49=
fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"b076c7f32ef613=
7e96c50a6e6b45fe4ba0f84ef4505b0094a2afbe0a7b2d92f2","src/unix/linux_like/li=
nux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718aff0bfe01967fe3bf1fde=
5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"ef117=
d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/linu=
x_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a9b72=
5766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/mips6=
4.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e","s=
rc/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c01bc412b3e13a0d41102e5=
8a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like/linux/musl/b64/power=
pc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697466"=
,"src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc3811d7=
2f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux/mus=
l/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461be33=
fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod.rs":"f44f7b2ade822aa=
468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","src/unix/linux_like/lin=
ux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab505e397af2acce146accb62=
efff654fe458b6af02","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a31=
7282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/li=
nux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e=
789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"f5dfcb0b4bc2=
a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1","src/unix/linux_like/=
linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842ce62b295bc0bd9eaf1b5f=
9792e442b681090","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"594=
93f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8e329580","src/unix/li=
nux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae376f403873aa566f37bff9=
9c6c323d334f3201667e5f7200b04643","src/unix/linux_like/linux/uclibc/mips/mo=
d.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","s=
rc/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae4c03c41038c43b374847e=
2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/linux/uclibc/x86_64/l4=
re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","=
src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c37752975c173aeb1641bae0e7=
43ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linux_like/linux/uclibc/x=
86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4=
093def","src/unix/linux_like/mod.rs":"183cd281f404e8d64563383343216e90f604c=
0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a97737d394fa7b293068fffa1=
554e08a8a484a40de985a865e61b6f694cab8","src/unix/newlib/aarch64/mod.rs":"ec=
594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/n=
ewlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40=
cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0=
e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e=
0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/hor=
izon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11=
313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7=
f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17eb=
b66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.r=
s":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/=
unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191=
ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e85317=
5070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"9cfcdbb158f3c9b86=
b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/unix/nto/neutrino.rs"=
:"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/un=
ix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410=
f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0aa3adcce005021018db93f=
814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5afadfc34e33ace8bd4154e=
471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/solarish/compat.rs":"dd=
69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4d20b676c","src/unix/s=
olarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6fbe1f94c2d5c5c26d634e3=
8bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e8531df71b89e4aee1ab4d3b3=
b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/solaris.rs":"ffc34e8c4049=
588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43","src/unix/solarish/x8=
6.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","s=
rc/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde=
103592922ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e=
8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4=
236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks=
/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e"=
,"src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230cf4cad6637c45a4022af29=
7a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af500985=
1c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":=
"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxw=
orks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277=
dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613=
acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18=
fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd188=
0e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485=
eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/m=
od.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","=
src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37=
a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9=
f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c40248ad4d0c08e1fd4c110=
7d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs":"8ac3171d7bced3576a=
4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"d750af042f7ef4f=
724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-=
switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-b=
uild_steps-tool.rs-switch-off-lto-for-rust.patch
index e2f533a..7f25ba9 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
@@ -24,7 +24,7 @@ diff --git a/src/bootstrap/src/core/build_steps/tool.rs b=
/src/bootstrap/src/core
 index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
-@@ -15,14 +15,12 @@ use std::{env, fs};
+@@ -16,14 +16,12 @@ use std::{env, fs};
  #[cfg(feature =3D "tracing")]
  use tracing::instrument;
=20
@@ -33,22 +33,22 @@ index 087df2f8a..00790affb 100644
  use crate::core::build_steps::{compile, llvm};
  use crate::core::builder;
 -use crate::core::builder::{
--    Builder, Cargo as CargoCommand, RunConfig, ShouldRun, Step, cargo_pro=
file_var,
+-    Builder, Cargo as CargoCommand, RunConfig, ShouldRun, Step, StepMetad=
ata, cargo_profile_var,
 -};
 -use crate::core::config::{DebuginfoLevel, RustcLto, TargetSelection};
 +
-+use crate::core::builder::{Builder, Cargo as CargoCommand, RunConfig, Sho=
uldRun, Step};
++use crate::core::builder::{Builder, Cargo as CargoCommand, RunConfig, Sho=
uldRun, Step, StepMetadata};
 +use crate::core::config::{DebuginfoLevel, TargetSelection};
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
  use crate::{Compiler, FileType, Kind, Mode, gha};
-@@ -171,20 +171,7 @@ impl Step for ToolBuild {
+@@ -160,20 +158,7 @@ impl Step for ToolBuild {
              cargo.env("RUSTC_WRAPPER", ccache);
          }
=20
 -        // Rustc tools (miri, clippy, cargo, rustfmt, rust-analyzer)
 -        // could use the additional optimizations.
--        if self.mode =3D=3D Mode::ToolRustc && is_lto_stage(&self.compile=
r) {
+-        if self.mode =3D=3D Mode::ToolRustc && is_lto_stage(&self.build_c=
ompiler) {
 -            let lto =3D match builder.config.rust_lto {
 -                RustcLto::Off =3D> Some("off"),
 -                RustcLto::Thin =3D> Some("thin"),
@@ -74,5 +74,5 @@ diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/=
bootstrap/src/core/buil
 -pub use self::cargo::{Cargo, cargo_profile_var};
 +pub use self::cargo::Cargo;
  pub use crate::Compiler;
+ use crate::core::build_steps::compile::{Std, StdLink};
  use crate::core::build_steps::{
-     check, clean, clippy, compile, dist, doc, gcc, install, llvm, run, se=
tup, test, tool, vendor,
diff --git a/recipes-devtools/rust/files/backport-fix-test-string-merging.p=
atch b/recipes-devtools/rust/files/backport-fix-test-string-merging.patch
deleted file mode 100644
index 1e72c10..0000000
--- a/recipes-devtools/rust/files/backport-fix-test-string-merging.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From 2d51acd2fbcbadb6f30709c5dd305494d413d388 Mon Sep 17 00:00:00 2001
-From: Jens Reidel <adrian@travitia.xyz>
-Date: Fri, 18 Jul 2025 19:44:20 +0200
-Subject: [PATCH] tests: assembly: cstring-merging: Disable GlobalMerge pass
-
-The test relies on LLVM not merging all the globals into one and would
-currently otherwise fail on powerpc64le.
-
-Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/2d51ac=
d2fbcbadb6f30709c5dd305494d413d388]
----
- tests/assembly/cstring-merging.rs | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/tests/assembly/cstring-merging.rs b/tests/assembly/cstring-me=
rging.rs
-index f7d0775f7affd..03688e0068b79 100644
---- a/tests/assembly/cstring-merging.rs
-+++ b/tests/assembly/cstring-merging.rs
-@@ -2,7 +2,7 @@
- // other architectures (including ARM and x86-64) use the prefix `.Lanon.`
- //@ only-linux
- //@ assembly-output: emit-asm
--//@ compile-flags: --crate-type=3Dlib -Copt-level=3D3
-+//@ compile-flags: --crate-type=3Dlib -Copt-level=3D3 -Cllvm-args=3D-enab=
le-global-merge=3D0
- //@ edition: 2024
-=20
- use std::ffi::CStr;
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index 53b1290..3fa8566 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -61,6 +61,6 @@ index b070eeb322..ba768ff86f 100644
 --- a/vendor/cc-1.2.0/.cargo-checksum.json
 +++ b/vendor/cc-1.2.0/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b371f7ae29e501e8=
51aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bdd514509d98cdbc5=
9e96e5f10888df4b6fca19d3a75","LICENSE-APACHE":"a60eea817514531668d7e0076573=
1449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c3941=
8f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b7833=
3a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350=
883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.=
rs":"b766a70e39b8ea7bb57afd288bcac205a23f6a26ac5619cb1d5b10f70c5dfdea","src=
/detect_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd=
26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5c694b2a02e5353452ee08a29e=
4e4d4d67ea8fcbd87605df","src/parallel/async_executor.rs":"4ce24435fff6b6555=
b43fee042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs=
":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68cfa2bf557ac24e5f2","src/p=
arallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd729682625543=
6fa063","src/parallel/stderr.rs":"74384d41198740a6fce0877f144262db09fb09122=
5fa8fbfa771314bb11487c6","src/target.rs":"7313240db078ad85c1209a42a5fa96c36=
92b5d6e5093c7f366a1b99677247109","src/target/apple.rs":"6afbecac9f66aa72db5=
5694413532f80b2753f28466a6213d1aa901a03c78bcd","src/target/generated.rs":"a=
f067e1c291e895ddb591f92534eed0c48977cdb2b58f8239423e07c6de31cd3","src/targe=
t/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b48154e4c8b6cb12f5373c5935da6=
e","src/target/parser.rs":"4f2129a24273d62bf8ab339098e7f758e4e42b0df369dd2b=
0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08b0706916ed911d4245240e60c=
3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e6550062e021f2b394388172bbb01e8=
6fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.rs":"52b30b24a1c31cdefb105=
309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/windows/com.rs":"a2800ddb=
81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find=
_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7bd07a83918d13a70c8465642e=
2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e4200439af3cc5c6433baf=
81502596040a89","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810e=
d066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab=
492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_ins=
tances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c7478f9c24c3950db6=
b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b0=
76147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307bfa083b9745eb0e4=
6cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows_targets.rs":"5=
b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1ccee"},"package"=
:"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"}
+-{"files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
87e4b514f3983f8dd141ea813","CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe9305=
7068cb1906a7f10b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b=
371f7ae29e501e851aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bd=
d514509d98cdbc59e96e5f10888df4b6fca19d3a75","Cargo.toml.orig":"0aff9dc74ddb=
e3bfe89ad9698212a6a18d6124b9593780aad25e277d28e9a71f","LICENSE-APACHE":"a60=
eea817514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT=
":"378f5840b258e2779c39418f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","READM=
E.md":"f1ddbede208a5b78333a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","c=
lippy.toml":"aa7850db4350883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb=
1d","src/command_helpers.rs":"b766a70e39b8ea7bb57afd288bcac205a23f6a26ac561=
9cb1d5b10f70c5dfdea","src/detect_compiler_family.c":"97ca4b021495611e828bec=
ea6187add37414186a16dfedd26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5=
c694b2a02e5353452ee08a29e4e4d4d67ea8fcbd87605df","src/parallel/async_execut=
or.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85b45983","=
src/parallel/job_token.rs":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68=
cfa2bf557ac24e5f2","src/parallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118=
a2d6295a7d6cd7296826255436fa063","src/parallel/stderr.rs":"74384d41198740a6=
fce0877f144262db09fb091225fa8fbfa771314bb11487c6","src/target.rs":"7313240d=
b078ad85c1209a42a5fa96c3692b5d6e5093c7f366a1b99677247109","src/target/apple=
.rs":"6afbecac9f66aa72db55694413532f80b2753f28466a6213d1aa901a03c78bcd","sr=
c/target/generated.rs":"af067e1c291e895ddb591f92534eed0c48977cdb2b58f823942=
3e07c6de31cd3","src/target/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b481=
54e4c8b6cb12f5373c5935da6e","src/target/parser.rs":"4f2129a24273d62bf8ab339=
098e7f758e4e42b0df369dd2b0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08=
b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e65500=
62e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.r=
s":"52b30b24a1c31cdefb105309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/=
windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3=
f2a5e3","src/windows/find_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7=
bd07a83918d13a70c8465642e2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea529=
5d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72=
c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/set=
up_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996db=
bec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec29076310=
1097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e988=
9dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e=
2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windo=
ws/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2=
e6e2c49d1ccee"},"package":"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e1=
2706b94263b36db8"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b371f7ae29e501e8=
51aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bdd514509d98cdbc5=
9e96e5f10888df4b6fca19d3a75","LICENSE-APACHE":"a60eea817514531668d7e0076573=
1449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c3941=
8f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b7833=
3a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350=
883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.=
rs":"174101852b2633a2478cef20d063fb9c2f1b092eac47913a6e708c85663b8404","src=
/detect_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd=
26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5c694b2a02e5353452ee08a29e=
4e4d4d67ea8fcbd87605df","src/parallel/async_executor.rs":"4ce24435fff6b6555=
b43fee042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs=
":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68cfa2bf557ac24e5f2","src/p=
arallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd729682625543=
6fa063","src/parallel/stderr.rs":"74384d41198740a6fce0877f144262db09fb09122=
5fa8fbfa771314bb11487c6","src/target.rs":"7313240db078ad85c1209a42a5fa96c36=
92b5d6e5093c7f366a1b99677247109","src/target/apple.rs":"6afbecac9f66aa72db5=
5694413532f80b2753f28466a6213d1aa901a03c78bcd","src/target/generated.rs":"a=
f067e1c291e895ddb591f92534eed0c48977cdb2b58f8239423e07c6de31cd3","src/targe=
t/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b48154e4c8b6cb12f5373c5935da6=
e","src/target/parser.rs":"4f2129a24273d62bf8ab339098e7f758e4e42b0df369dd2b=
0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08b0706916ed911d4245240e60c=
3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e6550062e021f2b394388172bbb01e8=
6fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.rs":"52b30b24a1c31cdefb105=
309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/windows/com.rs":"a2800ddb=
81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find=
_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7bd07a83918d13a70c8465642e=
2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e4200439af3cc5c6433baf=
81502596040a89","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810e=
d066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab=
492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_ins=
tances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c7478f9c24c3950db6=
b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b0=
76147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307bfa083b9745eb0e4=
6cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows_targets.rs":"5=
b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1ccee"},"package"=
:"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"}
++{"files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
87e4b514f3983f8dd141ea813","CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe9305=
7068cb1906a7f10b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b=
371f7ae29e501e851aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bd=
d514509d98cdbc59e96e5f10888df4b6fca19d3a75","Cargo.toml.orig":"0aff9dc74ddb=
e3bfe89ad9698212a6a18d6124b9593780aad25e277d28e9a71f","LICENSE-APACHE":"a60=
eea817514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT=
":"378f5840b258e2779c39418f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","READM=
E.md":"f1ddbede208a5b78333a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","c=
lippy.toml":"aa7850db4350883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb=
1d","src/command_helpers.rs":"174101852b2633a2478cef20d063fb9c2f1b092eac479=
13a6e708c85663b8404","src/detect_compiler_family.c":"97ca4b021495611e828bec=
ea6187add37414186a16dfedd26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5=
c694b2a02e5353452ee08a29e4e4d4d67ea8fcbd87605df","src/parallel/async_execut=
or.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85b45983","=
src/parallel/job_token.rs":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68=
cfa2bf557ac24e5f2","src/parallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118=
a2d6295a7d6cd7296826255436fa063","src/parallel/stderr.rs":"74384d41198740a6=
fce0877f144262db09fb091225fa8fbfa771314bb11487c6","src/target.rs":"7313240d=
b078ad85c1209a42a5fa96c3692b5d6e5093c7f366a1b99677247109","src/target/apple=
.rs":"6afbecac9f66aa72db55694413532f80b2753f28466a6213d1aa901a03c78bcd","sr=
c/target/generated.rs":"af067e1c291e895ddb591f92534eed0c48977cdb2b58f823942=
3e07c6de31cd3","src/target/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b481=
54e4c8b6cb12f5373c5935da6e","src/target/parser.rs":"4f2129a24273d62bf8ab339=
098e7f758e4e42b0df369dd2b0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08=
b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e65500=
62e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.r=
s":"52b30b24a1c31cdefb105309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/=
windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3=
f2a5e3","src/windows/find_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7=
bd07a83918d13a70c8465642e2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea529=
5d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72=
c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/set=
up_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996db=
bec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec29076310=
1097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e988=
9dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e=
2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windo=
ws/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2=
e6e2c49d1ccee"},"package":"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e1=
2706b94263b36db8"}
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index 550ac4e..fe683e9 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -226,76 +226,117 @@ index a05f274136..0e69b4cb98 100644
  fn sparse_inserts() {
      let cache: VecCache<u32, u8, u32> =3D VecCache::default();
      let end =3D if cfg!(target_pointer_width =3D "64") && cfg!(target_os =
=3D "linux") {
-diff --git a/tests/assembly/dwarf-mixed-versions-lto.rs b/tests/assembly/d=
warf-mixed-versions-lto.rs
-index 5b8e5ff4f4a..e558fbd7bd7 100644
---- a/tests/assembly/dwarf-mixed-versions-lto.rs
-+++ b/tests/assembly/dwarf-mixed-versions-lto.rs
-@@ -2,6 +2,11 @@
- // will choose the highest DWARF version for the final binary. This match=
es Clang's behavior.
- // Note: `.2byte` directive is used on MIPS.
-=20
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
-+
- //@ only-linux
- //@ aux-build:dwarf-mixed-versions-lto-aux.rs
+diff --git a/tests/assembly-llvm/dwarf-mixed-versions-lto.rs b/tests/assem=
bly-llvm/dwarf-mixed-versions-lto.rs
+index 828328df843..30753c56c76 100644
+--- a/tests/assembly-llvm/dwarf-mixed-versions-lto.rs
++++ b/tests/assembly-llvm/dwarf-mixed-versions-lto.rs
+@@ -8,6 +8,7 @@
  //@ compile-flags: -C lto -g -Cdwarf-version=3D5
-diff --git a/tests/codegen/uninhabited-transparent-return-abi.rs b/tests/c=
odegen/uninhabited-transparent-return-abi.rs
-index face1577c3f..d69e5e34a7b 100644
---- a/tests/codegen/uninhabited-transparent-return-abi.rs
-+++ b/tests/codegen/uninhabited-transparent-return-abi.rs
-@@ -1,4 +1,8 @@
+ //@ assembly-output: emit-asm
+ //@ no-prefer-dynamic
++//@ ignore-riscv64
+=20
+ extern crate dwarf_mixed_versions_lto_aux;
+=20
+diff --git a/tests/codegen-llvm/const-vector.rs b/tests/codegen-llvm/const=
-vector.rs
+index f4307492341..617e31140e9 100644
+--- a/tests/codegen-llvm/const-vector.rs
++++ b/tests/codegen-llvm/const-vector.rs
+@@ -3,6 +3,7 @@
+ //@ [OPT0_S390X] only-s390x
+ //@ [OPT0] compile-flags: -C no-prepopulate-passes -Copt-level=3D0
+ //@ [OPT0_S390X] compile-flags: -C no-prepopulate-passes -Copt-level=3D0 =
-C target-cpu=3Dz13
++//@ ignore-riscv64
+=20
+ // This test checks that constants of SIMD type are passed as immediate v=
ectors.
+ // We ensure that both vector representations (struct with fields and str=
uct wrapping array) work.
+diff --git a/tests/codegen-llvm/enum/enum-aggregate.rs b/tests/codegen-llv=
m/enum/enum-aggregate.rs
+index 0161e5f3fa1..773a06fabb4 100644
+--- a/tests/codegen-llvm/enum/enum-aggregate.rs
++++ b/tests/codegen-llvm/enum/enum-aggregate.rs
+@@ -1,6 +1,7 @@
+ //@ compile-flags: -Copt-level=3D0 -Cno-prepopulate-passes
+ //@ min-llvm-version: 19
+ //@ only-64bit
++//@ ignore-riscv64
+=20
+ #![crate_type =3D "lib"]
+=20
+diff --git a/tests/codegen-llvm/enum/enum-match.rs b/tests/codegen-llvm/en=
um/enum-match.rs
+index 57db44ec74e..1e2507f7c90 100644
+--- a/tests/codegen-llvm/enum/enum-match.rs
++++ b/tests/codegen-llvm/enum/enum-match.rs
+@@ -1,5 +1,6 @@
+ //@ compile-flags: -Copt-level=3D1
+ //@ only-64bit
++//@ ignore-riscv64
+=20
+ #![crate_type =3D "lib"]
+ #![feature(core_intrinsics)]
+diff --git a/tests/codegen-llvm/enum/enum-transparent-extract.rs b/tests/c=
odegen-llvm/enum/enum-transparent-extract.rs
+index c5efb8d472b..e79b8916fc1 100644
+--- a/tests/codegen-llvm/enum/enum-transparent-extract.rs
++++ b/tests/codegen-llvm/enum/enum-transparent-extract.rs
+@@ -1,5 +1,6 @@
+ //@ compile-flags: -Copt-level=3D0
+ //@ only-64bit
++//@ ignore-riscv64
+=20
+ #![crate_type =3D "lib"]
+=20
+diff --git a/tests/codegen-llvm/repeat-operand-zero-len.rs b/tests/codegen=
-llvm/repeat-operand-zero-len.rs
+index b4cec42a07c..d450fead9a4 100644
+--- a/tests/codegen-llvm/repeat-operand-zero-len.rs
++++ b/tests/codegen-llvm/repeat-operand-zero-len.rs
+@@ -1,4 +1,5 @@
+ //@ compile-flags: -Copt-level=3D1 -Cno-prepopulate-passes
++//@ ignore-riscv64
+=20
+ // This test is here to hit the `Rvalue::Repeat` case in `codegen_rvalue_=
operand`.
+ // It only applies when the resulting array is a ZST, so the test is writ=
ten in
+diff --git a/tests/codegen-llvm/simd/extract-insert-dyn.rs b/tests/codegen=
-llvm/simd/extract-insert-dyn.rs
+index 729f0145314..2b1d1beb86a 100644
+--- a/tests/codegen-llvm/simd/extract-insert-dyn.rs
++++ b/tests/codegen-llvm/simd/extract-insert-dyn.rs
+@@ -1,4 +1,5 @@
+ //@compile-flags: -C opt-level=3D3 -C no-prepopulate-passes
++//@ ignore-riscv64
+=20
+ #![feature(
+     core_intrinsics,
+diff --git a/tests/codegen-llvm/transmute-scalar.rs b/tests/codegen-llvm/t=
ransmute-scalar.rs
+index ce1b0558b2e..e8fda2cd566 100644
+--- a/tests/codegen-llvm/transmute-scalar.rs
++++ b/tests/codegen-llvm/transmute-scalar.rs
+@@ -1,5 +1,6 @@
+ //@ add-core-stubs
+ //@ compile-flags: -C opt-level=3D0 -C no-prepopulate-passes
++//@ ignore-riscv64
+=20
+ #![crate_type =3D "lib"]
+ #![feature(no_core, repr_simd, arm_target_feature, mips_target_feature, s=
390x_target_feature)]
+diff --git a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs b/te=
sts/codegen-llvm/uninhabited-transparent-return-abi.rs
+index face1577c3f..09e0846bad0 100644
+--- a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
++++ b/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
+@@ -1,4 +1,5 @@
  //@ compile-flags: -Copt-level=3D3
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
++//@ ignore-riscv64
=20=20
  // See https://github.com/rust-lang/rust/issues/135802
-
+=20
 diff --git a/tests/ui/abi/rust-cold-works-with-rustic-args.rs b/tests/ui/a=
bi/rust-cold-works-with-rustic-args.rs
-index 57027364699..3faa7ea035e 100644
+index 551485469d3..575db924968 100644
 --- a/tests/ui/abi/rust-cold-works-with-rustic-args.rs
 +++ b/tests/ui/abi/rust-cold-works-with-rustic-args.rs
-@@ -1,5 +1,9 @@
- //@build-pass
- //@compile-flags: -Clink-dead-code=3Dtrue --crate-type lib
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
+@@ -1,6 +1,7 @@
+ //@ add-core-stubs
+ //@ build-pass
+ //@ compile-flags: -Clink-dead-code=3Dtrue
++//@ ignore-riscv64
  // We used to not handle all "rustic" ABIs in a (relatively) uniform way,
  // so we failed to fix up arguments for actually passing through the ABI.=
..
  #![feature(rust_cold_cc)]
-diff --git a/tests/codegen/simd/extract-insert-dyn.rs b/tests/codegen/simd=
/extract-insert-dyn.rs
-index 729f0145314..1b21356518e 100644
---- a/tests/codegen/simd/extract-insert-dyn.rs
-+++ b/tests/codegen/simd/extract-insert-dyn.rs
-@@ -1,3 +1,8 @@
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
-+
- //@compile-flags: -C opt-level=3D3 -C no-prepopulate-passes
-
- #![feature(
-diff --git a/tests/codegen/const-vector.rs b/tests/codegen/const-vector.rs
-index 42921442e03..af0edc2ee92 100644
---- a/tests/codegen/const-vector.rs
-+++ b/tests/codegen/const-vector.rs
-@@ -1,3 +1,8 @@
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
-+
- //@ revisions: OPT0 OPT0_S390X
- //@ [OPT0] ignore-s390x
- //@ [OPT0_S390X] only-s390x
-
 diff --git a/tests/ui/linking/executable-no-mangle-strip.rs b/tests/ui/lin=
king/executable-no-mangle-strip.rs
 index cc283dc53..73cbab9c0 100644
 --- a/tests/ui/linking/executable-no-mangle-strip.rs
@@ -308,3 +349,31 @@ index cc283dc53..73cbab9c0 100644
=20=20
  // Regression test for <https://github.com/rust-lang/rust/issues/139744>.
  // Functions in the binary marked with no_mangle should be GC-ed if they
+diff --git a/library/std_detect/src/detect/os/linux/aarch64/tests.rs b/lib=
rary/std_detect/src/detect/os/linux/aarch64/tests.rs
+index a3562f2fd93..d4e52ed91be 100644
+--- a/library/std_detect/src/detect/os/linux/aarch64/tests.rs
++++ b/library/std_detect/src/detect/os/linux/aarch64/tests.rs
+@@ -27,6 +27,7 @@ fn baseline_hwcaps() -> AtHwcap {
+     }
+=20
+     #[test]
++    #[ignore]
+     fn linux_empty_hwcap2_aarch64() {
+         let file =3D concat!(
+             env!("CARGO_MANIFEST_DIR"),
+@@ -39,6 +40,7 @@ fn linux_empty_hwcap2_aarch64() {
+         assert_eq!(AtHwcap::from(v), baseline_hwcaps());
+     }
+     #[test]
++    #[ignore]
+     fn linux_no_hwcap2_aarch64() {
+         let file =3D concat!(
+             env!("CARGO_MANIFEST_DIR"),
+@@ -51,6 +53,7 @@ fn linux_no_hwcap2_aarch64() {
+         assert_eq!(AtHwcap::from(v), baseline_hwcaps());
+     }
+     #[test]
++    #[ignore]
+     fn linux_hwcap2_aarch64() {
+         let file =3D
+             concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/li=
nux-hwcap2-aarch64.auxv");
diff --git a/recipes-devtools/rust/libstd-rs_1.89.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.90.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.89.0.bb
rename to recipes-devtools/rust/libstd-rs_1.90.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.89.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.90.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.89.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.90.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.89.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.90.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust-llvm_1.89.0.bb
rename to recipes-devtools/rust/rust-llvm_1.90.0.bb
index 5ecc34a..42d4031 100644
--- a/recipes-devtools/rust/rust-llvm_1.89.0.bb
+++ b/recipes-devtools/rust/rust-llvm_1.90.0.bb
@@ -4,7 +4,7 @@ HOMEPAGE =3D "http://www.rust-lang.org"
=20
 # check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
 #
-LLVM_RELEASE =3D "20.1.5"
+LLVM_RELEASE =3D "20.1.8"
=20
 require rust-source.inc
=20
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 2bf48fa..6a8802c 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.88.0"
+SNAPSHOT_VERSION =3D "1.89.0"
=20
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "b841d40bb98b2718c6452ec8421=
a4a8df584fce8d41875bcd9b1af83f52f7d96"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "e9ac4ff3c87247a2195fcced=
dbf1bdeee5c4fd337f014d8f4c4e3ac99002021f"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "5aa43865f2002914ce4fca8916b=
4403bfca62f17e779ad368f6a17553296a58b"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "e210ec3d6158bb4730dd168ae1=
d35d4f6f9e9bf629c8e14362dc45b10b404867"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "16ed8d8c7628a481c8501e7cd10=
22a123269b297bdedbb7f211f37a15e937e0e"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "abea0955dded88c68d731524=
ab9d29b162fae23bf5805b9f1dec063cba37c2aa"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "f9df3ee6d55a2387459b8434777=
43fa386c3c0f126bd0be01691ee49309681b8"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "46512c61e217e613dc4d329fda=
8c6dde0d0ea94c4ae59c1ca2af9cf480458ff0"
=20
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "91feab28a2ba348840b15017303f43=
847974c75b443ea37b330ecb3d80c01007"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "ced56f7ab86496f6eb42d356841=
f9d0b625159eba65afd1913f232bb66d4b7e0"
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "ebf94de491865963fc02a3cdbbf1fe=
c8f3e9df49fe2af4d92c2a05cfddd5b3d8"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "aa2984ada59dc4e00f3820bb60dbd=
e8d143a383b1c23f9133af6911bfb7d0ea5"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "a5ca58ab1b419ddbf5e4ea9b206a3d=
1feb0cfc4e0879a96c2c2f809ee9ca00b0"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "853605815e8267baf8fdc6e4594=
514d2e0afb46fb29f478ebec871a3424430f3"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "1b3edcf590af9b9abdfa95f34b90a4=
258560627464a2a25d4e4503bb5834e291"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "2c47960ee78d804ce679b06c9c759=
e777ac7f39cae48bd8ffaf7ff706f951520"
=20
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "6b00f9be938ce27a146d73a=
45fb7930c68b2bb87101d2af00c44541d8ed11ef9"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "f2bc8745ec01c7e560b3=
f7b214040fd8053be191f8839887b58b441992952e72"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "95499f3734dc2dab7de07bd=
502d98c10e3854aca1c0dfa6ad16c798ec6de8a36"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "176caa1f7048acb93c8136=
d2ef436d89da9374f85bd6686e8abc0dccd5242e90"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "c090c2ab6b54a8d84129de4=
ef53bd4df35358191092d3217bf6fa99c20c860c6"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "2c5aa2cad944499c5b64=
947dcfeb12f3d5c91ced330a0982e000f22ec3dea27f"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "d22678ae984535464cd9aff=
3515e9ec5145ecb8db489ef4cce5c697e0538b500"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "0392c4fc97dc72b0d7d518=
129428c928b887e63b47f3d931fab7e54e2332ca9c"
=20
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "17ef139220f60cbc6f54c6f85dc=
e34cb2035a92ce321a1fbd1e76d340e54dbd2"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "891fe38736ca637bcd776f6d=
2b1822d761bd92305188482e45d26ab0dd84344b"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "ffd3d742fe3ffecf560b73c36ff=
6500ffc73b8899d58f98492d18f8fa71d7dcf"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "8889c94c8c0e27b34b93fefb59=
8d312357ff1b4cc01a440d260bffb2c6e5c191"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "08de18310e7750796261b45d5fa=
ccc31ff94ff64148bb5d9fa65e9727a432010"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "a03b3c3facf4701b6c7e8f37=
9f2aac445a582227b881e3268dee3752a84a89eb"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "ebdb0c8c9fad2d07dc702c9bfae=
e5dd140f6b0f9493bdd0c0d33f1449b7d97c2"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "f93cb4327943f30b3da8e671ea=
b6a78cdc3110c6612ad2a5eeaa9d8597fbd452"
=20
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "e1755dd3552209d564b77d20f=
5267d824851bfba2ecfb4bcb768deeea45078bc"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "89cf8b30e0fae601e0603e=
41d5eaf58881729208cac83636eff89b94724b7112"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "d234100429586cf8a3e7dd741=
49f95a864a4bd2ed914db72c13edcc4b4accd2f"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "bbbcdab98f901429766b89ef=
d6d30934f8d35c489be909c95635295f180d0cf5"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "6c66c8a3d698bb338d20453c8=
8d768e87a5af8970af4f4082d18dec26c10da2c"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "29338a9b067fe1adfd4d5a=
d681577c2333b3ca266a631822f23fad0984dcca39"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "f23184532c1e2eef6df49358f=
dfb867e99e84db7c814ce667744a36bc2fd8d37"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "695228193ff41ac32ec56214=
0294d87b1988311dfe685acc72b725429e2651d9"
=20
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "4acf67a5352df836246f457=
ae61ce40feb38a3360aec13881f5a26f22323ccb4"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "1030e71f755692c3429b=
b16829cca776c1ac372abbce3001b04d4e46b1e4f32f"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "f7a561ad6b0d6ccf5d6c243=
36fe96e215cda7215f538baaf6f0f5c7fea6030d0"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "a5b851a61427f4d85229fd=
3b588794e34b62b9862e577de8d110ac13abbfb9c2"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "14b7a8b7b3951a59a765804=
e1dd2ad454d3412000e7166ad8f2f621e29a88941"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "40123b87f0b909376d7f=
0bd291553b7e10aa637dd710f4bc698bcdcd0b08d21b"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "764eb5f54c2b0779f9e84c6=
fb0763e45316d5a51fbd187b56f9f6d7a646272d4"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "682d112649355a637a8713=
47d41317e361eb555bbfd4a4e48b26b0978449184b"
=20
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "f46ff6b6707e1e48519bf18c5=
dede1730cce6b2e347f4f15d841f919df92b859"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "d446fc0d8e4ce985c2d21a=
a2adb6ec9fce8f7ebde85655200abd71e142b9a981"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "38bca9242e9468335e433ac22=
31f2e778c351b3ac200de059be4789360a3956e"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "f467dfe7bdab310ac88efbf4=
ada1bf823982e0a3aff13f8ef35e33a6246d886f"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "2a2a00288faa8a55b16a3135c=
979bbd9c823f1e9ff376ea452ef0700ccc20d48"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "ee83276bb2d45611651763=
8b8ff379c24ceffe1c0e381103739cb1db8e4c20da"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "ec9a8f609f23b196d09e6537d=
baec7c6fd947e3b8266406c6654b2c112530de2"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "6bba0817c70b4dfae08238be=
b38003c623404d26b9ec00a297d08c9bf81c6d76"
=20
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "f214cb9a93428ebf24b9f9261b683=
3c53a91738f6e98029cf7bedf023caaf42c"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "df3144f87a22d606abea4dcfe8=
8369fcd499ef2fc748724b47941308ae259a5d"
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "6d3e6072f556f9ac11425bb273a29=
82e3255435d803994a51201709601c5f2d5"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "fb5ecad2896871c5db00cbaad11a=
039a5c071ba8d748ea1ce87df7dfa804bfe1"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "b2b811644d26d10195be0272b81bd=
28ed55aa998300c52b0d3b74bb40c162c42"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "2a7ed11535aac5b298a2179929=
2ad8393b14a16acbac6358416406a0d2639746"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "92534c38ffe3a6b17964f37ca812c=
5d00f079011acb060ec036945d2f568a772"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "a4a050854353325c1710440a5f72=
7e4280f1758fad5c0da6ba336ed57156fb48"
=20
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "b049fd57fce274d10013e2cf0e05=
f215f68f6580865abc52178f66ae9bf43fd8"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "36d7eacf46bd5199cb433e49a=
9ed9c9b380d82f8a0ebc05e89b43b51c070c955"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "856962610ee821648cee32e3d6ab=
ac667af7bb7ea6ec6f3d184cc31e66044f6b"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "db09c9e4a8a0b486781d87403f7=
4a203a58d9ef0a58ba10c39264916d93ac603"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "b42c254e1349df86bd40bc28fdf3=
86172a1a46f2eeabe3c7a08a75cf1fb60e27"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "2719470dcd78b3f97d78b978c=
8f85a1a58d84ff11b62558294621c01bca34d49"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "99fc10be2aeedf2c23a484f217bf=
a76458494495a0eee33e280d3616bb08282d"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "c6c362c6cd74567022e9ba0c16f=
6676f8c2b73d955adcf1f6f4c51cf15e57ce8"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "7c9016ce85e24dde9d76c0a3406=
1fa0fd6f742ea495dd1784804b60061b39627"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "7909e4bff0a971286958f2a88c3=
bbf231d6ba4ac1add0b2aa3669adb9f869836"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "95be6d0dec8be07fa13313a1=
0dd177e72df9737660c235a3e673bffcdd2e9068"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "a23126912b494dc2fcad495f=
78f920e43c2b1f06159e45477664aa37c03d80fa"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 4208aea..895e9a8 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,9 +9,8 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUS=
T_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patc=
h;patchdir=3D${RUSTSRC} \
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.=
patch;patchdir=3D${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-vari=
an.patch;patchdir=3D${RUSTSRC} \
-            file://backport-fix-test-string-merging.patch;patchdir=3D${RUS=
TSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "0b9d55610d8270e06c44f459d1e2b7918a5e673809c59=
2abed9b9c600e33d95a"
+SRC_URI[rust.sha256sum] =3D "6bfeaddd90ffda2f063492b092bfed925c4b8c701579b=
af4b1316e021470daac"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.89.0.bb b/recipes-devtools/rust/r=
ust_1.90.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.89.0.bb
rename to recipes-devtools/rust/rust_1.90.0.bb
--=20
2.51.0


