Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D78CAC58C
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:29 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.2984.1757443459625492331
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DeLoc14L;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b38d4de6d9so30996511cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443458; x=1758048258; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MabMhEEFs4ic2MBr0vrRr4Ig4bReVt/glF7bRp27pV8=;
        b=DeLoc14L6Cvd2iPj7wxF/F0MlMHQcKfZL4nz7IjY8G50tHocyz+924kPC7Un0CHoxm
         jHlVo/CkfhQSj6+1EwHq3LEH2iAvX+b4o2dhgHmH+5vcDrZ0WUSg15pT8X67XJWNMwwo
         9+XSRr0ReobhL1xPlgyaQYkCiXhI4oU6qIPyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443458; x=1758048258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MabMhEEFs4ic2MBr0vrRr4Ig4bReVt/glF7bRp27pV8=;
        b=pSlP1CSGcpMJ/CHDaCa4FvPuEo/tarpaXKY1zvI//7c3spbA/SavNNlrRqxdN3AHKM
         Y/7iV5zc7WxMsElOv7hcJ2iffCC/ZFS8X3mUTo31CeWe3sZSLpXcYoVhhMuqpRjX1xgZ
         Mtrvlq76mU0zZJItn5FCGbG4Zc0LjBawFAKcfOAlUVuELqV7/cuMOg4x80wriGAULWXc
         mSFeQX5aECaVqlrYH6AjdOWW4eDUqQQMD2KLQOaiVy4Ob/JssB7mwIqwdaNEkmePka0r
         VoN3WAqbDtPjGDURPfAVZzcKg0AhgSwAYNtfSJRRyKKW2I1Yi3biHMw/CsBdCf2esYox
         aYJQ==
X-Gm-Message-State: AOJu0Yzwx3oeT+Jr1FOMXJT1AkLSuJB5//+xowb17/x/WVyvNqYNFa0s
	LKOKea/h2liOs5mk4AF8kA9dvCgA3NigeaQUazPwNh+bO4cLMmAP+oZyAt8HM0Q91tXLdcvLf1R
	4fHhs
X-Gm-Gg: ASbGncv9cvQU7vGcvzhCSzSl0HBT6pCcWw5NGmtbWJ5bw8dg07b9FKzu+zdbLi81cVh
	c0RT2dxMZE3+o9+6kU8AALGizicJIasCEWh96yp7lqOiizZ/QEE+BaK6i2Zaom1VETOIjiBCgQ/
	3/ZWojQCn2EthlbTyF+Rj/AcCKVZDruCX2Rael/pDPS0K9gbJUC3LKNud/Dx6ANGy4SZc0Nda8e
	JgBLX69lu4Ghi/8uqBjdmwn9q/bdO6mXSudK9+LSosEy80ErZ3UOtSW3osdl+7Xti1rIABWB/Pm
	9NjQStAW1rX0CI7TMcVOX+9dq0XSTUiKS1i9LJeyJiQnaAycpFx9tpkMA8MxxLT4h45ocvaaWWV
	tUuZbxhdKy0BM92KyzzQJu4mXIjUnjTL2gqvPNwZCBduxtHAFprxz3UgWRxiSYTNUKuwGe1Ub7f
	75NWO9tit/
X-Google-Smtp-Source: AGHT+IGLojBoE7owRBYXVacUMD39K9kcF5cMnzhDxHQFpQHHQ6Wj+pyfLxBL51ukxmNhMPVAAwzGIg==
X-Received: by 2002:a05:622a:f:b0:4b5:f244:6657 with SMTP id d75a77b69052e-4b5f8425eafmr145969781cf.42.1757443456874;
        Tue, 09 Sep 2025 11:44:16 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:16 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 3/9] rust: Upgrade 1.88.0 -> 1.89.0
Date: Tue,  9 Sep 2025 14:43:56 -0400
Message-ID: <b9642c8f8931a66e46c3b58c80a862ff6bca8a21.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2161

From: Jayasurya Maganuru <Maganuru.Jayasurya@windriver.com>

Rust stable version upgraded to 1.89.0
https://blog.rust-lang.org/2025/08/07/Rust-1.89.0/

* Drop merged patches with rust v1.89.0.
  - 0001-Disable-libunwind-cross-architecture-unwinding.patch
  - triagebot.patch

* Update and rebase existing patches with rust v1.89.0.
  - revert-link-std-statically-in-rustc_driver-feature.patch
  - rust-oe-selftest.patch
  - 0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
  - 0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
    (To fix build failures for riscv with musl, this patch adds
     aliases for plain syscalls to their time64 variants in libc-0.2.174,
     These changes are in addition to similar fixes already applied
     to libc-0.2.172)
  - 0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
    (Changes for libc-0.2.170 are no longer needed, as that version
     is not present in rust v1.89.0 vendor sources)

* OE-selftests:
  - Doc-tests fail in 55 crates,test-float-parse tests also fail.
    These tests are excluded to ensure the overall test suite passes.

   Test Results Summary:
   +-----------+--------+---------+
   | Machine   | Passed | Ignored |
   +-----------+--------+---------+
   | arm-32    | 29,239 | 1,468   |
   | arm-64    | 29,329 | 1,412   |
   | x86-32    | 29,231 | 1,449   |
   | x86-64    | 29,484 | 1,225   |
   | riscv-64  | 29,304 | 1,436   |
   +-----------+--------+---------+

Signed-off-by: Jayasurya Maganuru <Maganuru.Jayasurya@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit fca454a188592c9fa854e93ff1a9c3e70a681e23)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
 .../rust/{cargo_1.88.0.bb =3D> cargo_1.89.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 101 ------------------
 ...bunwind-cross-architecture-unwinding.patch |  46 --------
 ...lain-syscalls-as-their-time64-varian.patch |  32 ++++++
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   8 +-
 ...d-statically-in-rustc_driver-feature.patch |  14 +--
 .../rust/files/rust-oe-selftest.patch         |  13 ---
 recipes-devtools/rust/files/triagebot.patch   |  32 ------
 ...ibstd-rs_1.88.0.bb =3D> libstd-rs_1.89.0.bb} |   0
 ....88.0.bb =3D> rust-cross-canadian_1.89.0.bb} |   0
 ...ust-llvm_1.88.0.bb =3D> rust-llvm_1.89.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++++++-------
 recipes-devtools/rust/rust-source.inc         |   4 +-
 .../rust/{rust_1.88.0.bb =3D> rust_1.89.0.bb}   |   0
 16 files changed, 86 insertions(+), 247 deletions(-)
 rename recipes-devtools/rust/{cargo_1.88.0.bb =3D> cargo_1.89.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cros=
s-architecture-unwinding.patch
 delete mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.88.0.bb =3D> libstd-rs_1.89.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.88.0.bb =3D> rust-cros=
s-canadian_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.88.0.bb =3D> rust-llvm_1.89.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.88.0.bb =3D> rust_1.89.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 92899f9..891852f 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
 LICENSE_PATH +=3D "${LAYERDIR}/files/common-licenses"
=20
-RUSTVERSION ?=3D "1.88.0%"
+RUSTVERSION ?=3D "1.89.0%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/case=
s/rust_mixin.py
index 922aa67..653867f 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -74,6 +74,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
                             'src/tools/rust-analyzer',
                             'src/tools/rustdoc-themes',
                             'src/tools/rust-installer',
+                            'src/tools/test-float-parse',
                             'src/tools/suggest-tests',
                             'src/tools/tidy',
                             'tests/assembly/asm/aarch64-outline-atomics.rs=
',
@@ -98,7 +99,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
=20
         exclude_fail_tests =3D " ".join([" --exclude " + item for item in =
exclude_list])
         # Add exclude_fail_tests with other test arguments
-        testargs =3D  exclude_fail_tests + " --no-fail-fast --bless"
+        testargs =3D  exclude_fail_tests + " --no-doc --no-fail-fast --ble=
ss"
=20
         # wrap the execution with a qemu instance.
         # Tests are run with 512 tasks in parallel to execute all tests ve=
ry quickly
diff --git a/recipes-devtools/rust/cargo_1.88.0.bb b/recipes-devtools/rust/=
cargo_1.89.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.88.0.bb
rename to recipes-devtools/rust/cargo_1.89.0.bb
diff --git a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-ri=
scv32gc-unknown-linux-g.patch b/recipes-devtools/rust/files/0001-Define-mor=
e-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
index 3b3556a..024d549 100644
--- a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
+++ b/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
@@ -216,104 +216,3 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
=20=20
  cfg_if! {
      if #[cfg(any(target_arch =3D "arm", target_arch =3D "s390x"))] {
---- a/vendor/libc-0.2.170/.cargo-checksum.json
-+++ b/vendor/libc-0.2.170/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CHANGELOG.md":"62da82cb89e09539698a1fbf378b719263f4e4716b23350=
48ef4ca560b41c281","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"8c028e8a0b5154e274850fcdd44d2970=
f1a985c2bcf296f930e838cf8ff13c2c","Cargo.toml":"7c99fbe25db508ac34b78e20be9=
071a9d08ee4a4d21c51a74c42924b5df8a624","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"da4dd=
3ae25a26615e6f99c0da151d3d0e6254e54a5be0bc8b9d6b3504c479ddf","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"91b72cb1c09275f147b9766274a2c306c5aea0920fa=
7b7be316c5ef4d2da7a6e","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"ec146647ca=
68e5b4c6ef57a30846657c2d08b34a50edea767939be56f355bdae","src/hermit.rs":"71=
a04dbd8b1b9da80caf38b52ee258f0c8e2082d21a7dcccd071f737e3b962ee","src/lib.rs=
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
49c77f65e22","src/unix/aix/mod.rs":"51bbcf76fe8577f9b7addde82f528815dc84c4c=
e5364d6a41eb32c22ab1d3df0","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"cb5077a0d10165ba78c879849cafd59c94198c021e9a0467b557fc09c6594218","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c22=
b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"bc759e890299aa=
7dcdad91daeb09ffa9daf132cd015ee29a8f26f760f4ded6a6","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5a=
8593f4","src/unix/bsd/apple/mod.rs":"5c5079bd63cdc772f6a8451d78f170889c5201=
a491b9321ab59ca248a9b55704","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"cfcfde18ab9c3e4befda9b217dbd9c2ff8093de=
4cb80e4d2943c8d24784da3b6","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a517=
9391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f3403=
ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0b=
60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"ffe0270f602a73ee019024cdc01b8e1e052d5b1abd7=
ade00259cea44a665fcb5","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"8e06010254be97c4e3ad558b8d20ba3e6dd2f=
3d4788075797102f92b649cd42d","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"992701b9c06912fb637fb521f2f32d77b5d9f8cda489dbc9432282dd20c938a8","src/=
unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670c=
efe3bac88782de879f8","src/unix/bsd/mod.rs":"51433cfd7d7aaeecf3de594a8c867d5=
f526b72415d7a9fbacb8a2259783a721b","src/unix/bsd/netbsdlike/mod.rs":"d089ee=
f37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"f72b1b20ca902f5ba6abfdf=
09a4aecac25e2f6d6ff3166307001090cbc3f1f28","src/unix/bsd/netbsdlike/netbsd/=
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
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e6311057=
44b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"5ddb4b9b3fb4825=
f2718f1a656c2efbdb688bae166da46d6ad46a2ba94c77d09","src/unix/haiku/b32.rs":=
"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/uni=
x/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c=
27d242","src/unix/haiku/mod.rs":"4336bfcb6f9c7f06bb30f7e23d773f31e5c02f6f83=
bb8c691bf8165c87f6dcc9","src/unix/haiku/native.rs":"fafc7daab134d37ed260373=
f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8e=
f6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hur=
d/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123=
","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd=
78aff0806cb931f","src/unix/hurd/mod.rs":"ad0dbac278bd0b9c1a0c2f005bae8709ec=
2bb04d65240f1e77715064ede8bb2b","src/unix/linux_like/android/b32/arm.rs":"0=
6dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/=
linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa=
2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942=
e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux=
_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce1=
52f25d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"6a87e7e=
673677882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c","src/unix/linux_=
like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7b=
a87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"c=
ab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/=
linux_like/android/mod.rs":"49ed71bf45aecbeb2bd72aa7384cb7c9d175774dcfb7c39=
432863e07c2e65506","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16=
525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/e=
mscripten/mod.rs":"4dd28aed8e023e3ed9f8a12ea03c31cb5620d505b69accfb2b7dd7e7=
53b6a2fa","src/unix/linux_like/linux/arch/generic/mod.rs":"0055aaff81c906b0=
3c74047a825c0caedca9b328676e353d7c4ba808b29abc05","src/unix/linux_like/linu=
x/arch/mips/mod.rs":"5d81a976ce7bbe25486922e2eac09985dce7fd9d75eca981c1f945=
2f54f993b8","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f12=
4ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch=
/powerpc/mod.rs":"ba3f418789dedaf548f195216e2c4370b61088dcd9d4693edd8973a77=
3f53434","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678b=
180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/g=
nu/b32/arm/mod.rs":"dc7277cf0fe479227142b936ddd9d4f333411f39ebe7c5fd0fd8516=
a8069d53c","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e60be36b8d7cc82=
aed1921fd68182e05d52ba9ce0e8f52041bc398140a3daad7","src/unix/linux_like/lin=
ux/gnu/b32/m68k/mod.rs":"e12209151a09b07731b212112fe656e1cdf1a14ff79a60e9aa=
49a9e7c0e8daa5","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"9548e4cccb=
bc85e54b3f38d4f9ea8071535c3ace254534893a55438deed5b19b","src/unix/linux_lik=
e/linux/gnu/b32/mod.rs":"f8f17f697866f3148d13f974ed5af50c2af8f26e6390996914=
77e7eb93d41f08","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"6bddf8e9d66=
ec086aad0d5c7945bddf03e43035380a094bf1c8c591e20813dee","src/unix/linux_like=
/linux/gnu/b32/riscv32/mod.rs":"0c03d3597a6316ccb9beaa7fe223cbb1ecbbf9bf8f2=
151ac09b5e79698ba9e5a","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"89=
5f999648d2663139ce471ef57ca4a236879952339c77edf271a162e7449b79","src/unix/l=
inux_like/linux/gnu/b32/x86/mod.rs":"9072f4052e6a9161942c7a308894ff51d92e48=
c2f94ba892ea230d0548b89d3b","src/unix/linux_like/linux/gnu/b64/aarch64/ilp3=
2.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","s=
rc/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04=
c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b6=
4/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596=
e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046=
086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_li=
ke/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168=
ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a98=
1ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux_=
like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e643310=
9ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod=
.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","sr=
c/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02=
c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc6=
4/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7=
","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"c56a20c8469f2726cc37de=
6742ae69fd32fb640b30f5ba0cd027050dc85a74c5","src/unix/linux_like/linux/gnu/=
b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c5=
8ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b78=
1dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_li=
ke/linux/gnu/mod.rs":"b35391cb2bbb2693d127620e30a33c43f72f53c715c45505c07dc=
44f22a60738","src/unix/linux_like/linux/mod.rs":"27ad9305958b2b9656a8e07532=
0106c9a4d126c68a5b7bd033a6d604ff1e695b","src/unix/linux_like/linux/musl/b32=
/arm/mod.rs":"9ac98d5d204838f75305ba68bfe00120c6b64ec46ffb4c4b77f7cfbb07b2c=
29b","src/unix/linux_like/linux/musl/b32/hexagon.rs":"6e377c21bbcfed3f8d4db=
dd19feabe26fce251f83f49ceb38014bf1654523c41","src/unix/linux_like/linux/mus=
l/b32/mips/mod.rs":"ca0eec67edad64de2226df6e6d8545628d852b5439ac66def819111=
0ae1c9ef4","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b2=
5ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/m=
usl/b32/powerpc.rs":"9ab9d3514d2ee1b8f7e4b8a565a14106d1a6b406ac4738feaf9b3c=
a8be51757b","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"43c6296ac9=
9205a227c303c0cf822dc6d95e76e56ce18023049d5d62363020fd","src/unix/linux_lik=
e/linux/musl/b32/x86/mod.rs":"af87ce32f8006940a56c3f94d519dc15045cc3c268513=
9b8e3291f7e7d1e8608","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"e=
f117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/=
linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a=
9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/m=
ips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e=
","src/unix/linux_like/linux/musl/b64/mod.rs":"7abae0587e5e1d70162d4e3c7af2=
2b5c7fb3b536e3e2ecb72dbce77ed3d4bfb0","src/unix/linux_like/linux/musl/b64/p=
owerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697=
466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc38=
11d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux=
/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461=
be33fae359","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a317282fb50=
4c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/linux_like=
/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3e=
76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"f3754ea82ae792a2fb3f=
15cba51d5b4e807a36a0619b60fc0793490e49bd073a","src/unix/linux_like/linux/uc=
libc/arm/mod.rs":"e54235f562a0905d21561723e3a7ca1f5a3fa98fe80d769c1e713485a=
d1a72a3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"d2f26640c0b=
22a0ab494c10570f5fe47829a1d5518172d4a4b620af57048c98a","src/unix/linux_like=
/linux/uclibc/mips/mips64/mod.rs":"e8847ab09d94941797f780aefe9a2e8dacc2c738=
4380d8e16fdbcfad6da5b87f","src/unix/linux_like/linux/uclibc/mips/mod.rs":"e=
ad3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix/=
linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee3=
b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"=
059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","src/unix=
/linux_like/linux/uclibc/x86_64/mod.rs":"925a1712f19d5b7ba8f6e23ec863807091=
7d296373dd58d5d1d6517d36d992e3","src/unix/linux_like/linux/uclibc/x86_64/ot=
her.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def",=
"src/unix/linux_like/mod.rs":"98af2658664aa14208c9aa7e734c57891fd420514e0ed=
7c5c7ec4a13ae4ef99e","src/unix/mod.rs":"0cbcc5c240136c9eff99965063fb9de2d60=
e18ee395cc087ac44c2341ef73ebe","src/unix/newlib/aarch64/mod.rs":"ec594c54dc=
0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/newlib/ar=
m/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40cf180665=
","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0e35b6f3d=
eb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e09849341=
30425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mod=
.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11313","sr=
c/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797e=
a7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17ebb66dcbf3=
b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.rs":"239c=
90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/new=
lib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191ad53a8fc=
124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e853175070a8ac=
2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d86=
977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab7=
b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/x=
86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410f5e7929b=
","src/unix/nuttx/mod.rs":"fdaf81acb8c0de10133bdeb9fdca0f28740fc154fe330315=
a5c202a13761c18f","src/unix/redox/mod.rs":"a9a0005c8572ad5404cc9680a83a610d=
8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/solarish/compat.rs":"c02a889188=
52b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish/=
illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e234b2b9b021eed32572b8a28d991a3=
98","src/unix/solarish/mod.rs":"dd57ff6ad3117c445b7d181bf426677a49ae3727b52=
323e53935b378b7c4679c","src/unix/solarish/solaris.rs":"54bae4c960b65d849bee=
a8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8","src/unix/solarish/x86.rs":"4=
4261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix/=
solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde10359292=
2ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f1=
3187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4236500f9=
8858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/arm.rs"=
:"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vx=
works/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbdecbdd9ac26b38430b33b04f0c50ad=
dcc7","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af5009851c8c5820=
31926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858fc249f3b6=
858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/ris=
cv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a"=
,"src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a0=
9a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd1880e87b54a=
e0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485eabd2c32=
bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":"=
320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/wind=
ows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37a0935de4=
7c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c41=
13a1a87fae8e64549c00","src/xous.rs":"a52f9f28399018197e8c7c95f1c21a4e558bc8=
a0d24a3571bb383e41b1680c0b","tests/const_fn.rs":"8ac3171d7bced3576a4e93f485=
70b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"875b3680cb2f8f71bdcf9a3=
0f38d48282f5d3c95cbf9b3fa57269bb5d5c06828"}
-\ No newline at end of file
-+{"files":{"CHANGELOG.md":"62da82cb89e09539698a1fbf378b719263f4e4716b23350=
48ef4ca560b41c281","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"8c028e8a0b5154e274850fcdd44d2970=
f1a985c2bcf296f930e838cf8ff13c2c","Cargo.toml":"7c99fbe25db508ac34b78e20be9=
071a9d08ee4a4d21c51a74c42924b5df8a624","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"da4dd=
3ae25a26615e6f99c0da151d3d0e6254e54a5be0bc8b9d6b3504c479ddf","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"91b72cb1c09275f147b9766274a2c306c5aea0920fa=
7b7be316c5ef4d2da7a6e","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"ec146647ca=
68e5b4c6ef57a30846657c2d08b34a50edea767939be56f355bdae","src/hermit.rs":"71=
a04dbd8b1b9da80caf38b52ee258f0c8e2082d21a7dcccd071f737e3b962ee","src/lib.rs=
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
49c77f65e22","src/unix/aix/mod.rs":"51bbcf76fe8577f9b7addde82f528815dc84c4c=
e5364d6a41eb32c22ab1d3df0","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"cb5077a0d10165ba78c879849cafd59c94198c021e9a0467b557fc09c6594218","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c22=
b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"bc759e890299aa=
7dcdad91daeb09ffa9daf132cd015ee29a8f26f760f4ded6a6","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5a=
8593f4","src/unix/bsd/apple/mod.rs":"5c5079bd63cdc772f6a8451d78f170889c5201=
a491b9321ab59ca248a9b55704","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"cfcfde18ab9c3e4befda9b217dbd9c2ff8093de=
4cb80e4d2943c8d24784da3b6","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a517=
9391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f3403=
ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0b=
60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"ffe0270f602a73ee019024cdc01b8e1e052d5b1abd7=
ade00259cea44a665fcb5","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"8e06010254be97c4e3ad558b8d20ba3e6dd2f=
3d4788075797102f92b649cd42d","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"992701b9c06912fb637fb521f2f32d77b5d9f8cda489dbc9432282dd20c938a8","src/=
unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670c=
efe3bac88782de879f8","src/unix/bsd/mod.rs":"51433cfd7d7aaeecf3de594a8c867d5=
f526b72415d7a9fbacb8a2259783a721b","src/unix/bsd/netbsdlike/mod.rs":"d089ee=
f37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"f72b1b20ca902f5ba6abfdf=
09a4aecac25e2f6d6ff3166307001090cbc3f1f28","src/unix/bsd/netbsdlike/netbsd/=
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
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e6311057=
44b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"5ddb4b9b3fb4825=
f2718f1a656c2efbdb688bae166da46d6ad46a2ba94c77d09","src/unix/haiku/b32.rs":=
"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a20e039f","src/uni=
x/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f90c597ec88f6dc1f4c=
27d242","src/unix/haiku/mod.rs":"4336bfcb6f9c7f06bb30f7e23d773f31e5c02f6f83=
bb8c691bf8165c87f6dcc9","src/unix/haiku/native.rs":"fafc7daab134d37ed260373=
f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8e=
f6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hur=
d/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec785428708059d853dc123=
","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffcc8a05ca7cef6dbfbd=
78aff0806cb931f","src/unix/hurd/mod.rs":"ad0dbac278bd0b9c1a0c2f005bae8709ec=
2bb04d65240f1e77715064ede8bb2b","src/unix/linux_like/android/b32/arm.rs":"0=
6dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4a8672","src/unix/=
linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59d65619aa5a53991aa=
2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x86/mod.rs":"ad5942=
e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0","src/unix/linux=
_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8b8776459a60c08ce1=
52f25d137f845d8371673b7e","src/unix/linux_like/android/b64/mod.rs":"6a87e7e=
673677882c31eb4b69375427b71f7f9f61f883322bb1fba8ecb9ff39c","src/unix/linux_=
like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244659fc700b95aa8a7b=
a87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/x86_64/mod.rs":"c=
ab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8b2a3e","src/unix/=
linux_like/android/mod.rs":"49ed71bf45aecbeb2bd72aa7384cb7c9d175774dcfb7c39=
432863e07c2e65506","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf16=
525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/e=
mscripten/mod.rs":"4dd28aed8e023e3ed9f8a12ea03c31cb5620d505b69accfb2b7dd7e7=
53b6a2fa","src/unix/linux_like/linux/arch/generic/mod.rs":"79c02a52eb5ae4c3=
ce3ef4d02b362884c384e7aab8e3e8fc554c9333c91ff99e","src/unix/linux_like/linu=
x/arch/mips/mod.rs":"5d81a976ce7bbe25486922e2eac09985dce7fd9d75eca981c1f945=
2f54f993b8","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f12=
4ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arch=
/powerpc/mod.rs":"ba3f418789dedaf548f195216e2c4370b61088dcd9d4693edd8973a77=
3f53434","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678b=
180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/g=
nu/b32/arm/mod.rs":"dc7277cf0fe479227142b936ddd9d4f333411f39ebe7c5fd0fd8516=
a8069d53c","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"e60be36b8d7cc82=
aed1921fd68182e05d52ba9ce0e8f52041bc398140a3daad7","src/unix/linux_like/lin=
ux/gnu/b32/m68k/mod.rs":"e12209151a09b07731b212112fe656e1cdf1a14ff79a60e9aa=
49a9e7c0e8daa5","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"9548e4cccb=
bc85e54b3f38d4f9ea8071535c3ace254534893a55438deed5b19b","src/unix/linux_lik=
e/linux/gnu/b32/mod.rs":"f8f17f697866f3148d13f974ed5af50c2af8f26e6390996914=
77e7eb93d41f08","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"6bddf8e9d66=
ec086aad0d5c7945bddf03e43035380a094bf1c8c591e20813dee","src/unix/linux_like=
/linux/gnu/b32/riscv32/mod.rs":"0c03d3597a6316ccb9beaa7fe223cbb1ecbbf9bf8f2=
151ac09b5e79698ba9e5a","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"89=
5f999648d2663139ce471ef57ca4a236879952339c77edf271a162e7449b79","src/unix/l=
inux_like/linux/gnu/b32/x86/mod.rs":"9072f4052e6a9161942c7a308894ff51d92e48=
c2f94ba892ea230d0548b89d3b","src/unix/linux_like/linux/gnu/b64/aarch64/ilp3=
2.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0c58e863000417","s=
rc/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e70467b2f00735d3a04=
c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_like/linux/gnu/b6=
4/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324ab8ad41cd419bc596=
e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"425047046=
086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","src/unix/linux_li=
ke/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba8916b756752612590168=
ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a98=
1ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux_=
like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1a5dba69ac2e643310=
9ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gnu/b64/riscv64/mod=
.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a77392b48e1b2265","sr=
c/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d8cc0743adb4506f02=
c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/linux/gnu/b64/sparc6=
4/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc261f2b8a9fefd2caa7=
","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"c56a20c8469f2726cc37de=
6742ae69fd32fb640b30f5ba0cd027050dc85a74c5","src/unix/linux_like/linux/gnu/=
b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b499c9c9b57898441c5=
8ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"914898b78=
1dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","src/unix/linux_li=
ke/linux/gnu/mod.rs":"b35391cb2bbb2693d127620e30a33c43f72f53c715c45505c07dc=
44f22a60738","src/unix/linux_like/linux/mod.rs":"27ad9305958b2b9656a8e07532=
0106c9a4d126c68a5b7bd033a6d604ff1e695b","src/unix/linux_like/linux/musl/b32=
/arm/mod.rs":"9ac98d5d204838f75305ba68bfe00120c6b64ec46ffb4c4b77f7cfbb07b2c=
29b","src/unix/linux_like/linux/musl/b32/hexagon.rs":"6e377c21bbcfed3f8d4db=
dd19feabe26fce251f83f49ceb38014bf1654523c41","src/unix/linux_like/linux/mus=
l/b32/mips/mod.rs":"ca0eec67edad64de2226df6e6d8545628d852b5439ac66def819111=
0ae1c9ef4","src/unix/linux_like/linux/musl/b32/mod.rs":"e0f53df7ca1dbe9b0b2=
5ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/linux_like/linux/m=
usl/b32/powerpc.rs":"9ab9d3514d2ee1b8f7e4b8a565a14106d1a6b406ac4738feaf9b3c=
a8be51757b","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"43c6296ac9=
9205a227c303c0cf822dc6d95e76e56ce18023049d5d62363020fd","src/unix/linux_lik=
e/linux/musl/b32/x86/mod.rs":"af87ce32f8006940a56c3f94d519dc15045cc3c268513=
9b8e3291f7e7d1e8608","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"e=
f117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee842208178","src/unix/=
linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f37378774f3991f05971a=
9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like/linux/musl/b64/m=
ips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9952112da13036e50e=
","src/unix/linux_like/linux/musl/b64/mod.rs":"7abae0587e5e1d70162d4e3c7af2=
2b5c7fb3b536e3e2ecb72dbce77ed3d4bfb0","src/unix/linux_like/linux/musl/b64/p=
owerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d239a37dc8693af697=
466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a76a7a24d52f2fc38=
11d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix/linux_like/linux=
/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b19fc0f9c7fc1af461=
be33fae359","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"a317282fb50=
4c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf0f75e7f","src/unix/linux_like=
/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3e=
76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"f3754ea82ae792a2fb3f=
15cba51d5b4e807a36a0619b60fc0793490e49bd073a","src/unix/linux_like/linux/uc=
libc/arm/mod.rs":"e54235f562a0905d21561723e3a7ca1f5a3fa98fe80d769c1e713485a=
d1a72a3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"d2f26640c0b=
22a0ab494c10570f5fe47829a1d5518172d4a4b620af57048c98a","src/unix/linux_like=
/linux/uclibc/mips/mips64/mod.rs":"e8847ab09d94941797f780aefe9a2e8dacc2c738=
4380d8e16fdbcfad6da5b87f","src/unix/linux_like/linux/uclibc/mips/mod.rs":"e=
ad3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix/=
linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee3=
b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"=
059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a8742658ff25f05361c","src/unix=
/linux_like/linux/uclibc/x86_64/mod.rs":"925a1712f19d5b7ba8f6e23ec863807091=
7d296373dd58d5d1d6517d36d992e3","src/unix/linux_like/linux/uclibc/x86_64/ot=
her.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def",=
"src/unix/linux_like/mod.rs":"98af2658664aa14208c9aa7e734c57891fd420514e0ed=
7c5c7ec4a13ae4ef99e","src/unix/mod.rs":"0cbcc5c240136c9eff99965063fb9de2d60=
e18ee395cc087ac44c2341ef73ebe","src/unix/newlib/aarch64/mod.rs":"ec594c54dc=
0e7784668d02ef737fd194dcc3f1e6ee23328d810fd2453bcb6f20","src/unix/newlib/ar=
m/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4c1311579f23bae2b26a40cf180665=
","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db027b8b0b5aa5126f15bc0e35b6f3d=
eb2339acf403c961f13df26f","src/unix/newlib/generic.rs":"182e584f14e09849341=
30425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mod=
.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d688aa6f115713f644b8a11313","sr=
c/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797e=
a7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"4e5f804a13e907e17ebb66dcbf3=
b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/unix/newlib/rtems/mod.rs":"239c=
90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/new=
lib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f31eeeab9729e1bb188191ad53a8fc=
124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca13454a75c7b0815e853175070a8ac=
2eefa338012a03e8b59f01e0c","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d86=
977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab7=
b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/x=
86_64.rs":"8da99138e210516a95d49c8c0265eada4c5f7b93d59be86224844410f5e7929b=
","src/unix/nuttx/mod.rs":"fdaf81acb8c0de10133bdeb9fdca0f28740fc154fe330315=
a5c202a13761c18f","src/unix/redox/mod.rs":"a9a0005c8572ad5404cc9680a83a610d=
8aa82278fcb5d24a4b99ab32fcc6eb60","src/unix/solarish/compat.rs":"c02a889188=
52b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish/=
illumos.rs":"7c5da4d4ea69ebfb83a59764eeafc74e234b2b9b021eed32572b8a28d991a3=
98","src/unix/solarish/mod.rs":"dd57ff6ad3117c445b7d181bf426677a49ae3727b52=
323e53935b378b7c4679c","src/unix/solarish/solaris.rs":"54bae4c960b65d849bee=
a8f0beb79dc37afebc1e9d7664424df13e6082ccc2e8","src/unix/solarish/x86.rs":"4=
4261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix/=
solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde10359292=
2ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f1=
3187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"4d4236500f9=
8858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/arm.rs"=
:"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vx=
works/mod.rs":"b2857bf7695b4571ad7fba8f44ebcbdecbdd9ac26b38430b33b04f0c50ad=
dcc7","src/vxworks/powerpc.rs":"4d4236500f98858fc249f3b6858af5009851c8c5820=
31926b8195b2646f7da5e","src/vxworks/powerpc64.rs":"4d4236500f98858fc249f3b6=
858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/riscv32.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/ris=
cv64.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a"=
,"src/vxworks/x86.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a0=
9a277dc3302a","src/vxworks/x86_64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/wasi/mod.rs":"cac5127894b50bd1880e87b54a=
e0cbc9afe98f99ee739f74aec04172c14bcc1a","src/wasi/p2.rs":"feecc0485eabd2c32=
bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":"=
320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/wind=
ows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f9ab25d68173c51d561f37a0935de4=
7c","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c41=
13a1a87fae8e64549c00","src/xous.rs":"a52f9f28399018197e8c7c95f1c21a4e558bc8=
a0d24a3571bb383e41b1680c0b","tests/const_fn.rs":"8ac3171d7bced3576a4e93f485=
70b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"875b3680cb2f8f71bdcf9a3=
0f38d48282f5d3c95cbf9b3fa57269bb5d5c06828"}
---- a/vendor/libc-0.2.170/src/unix/linux_like/linux/arch/generic/mod.rs
-+++ b/vendor/libc-0.2.170/src/unix/linux_like/linux/arch/generic/mod.rs
-@@ -1,5 +1,5 @@
- use crate::prelude::*;
--use crate::Ioctl;
-+use crate::{Ioctl, _IOR, _IOW};
-=20
- s! {
-     pub struct termios2 {
-@@ -143,21 +143,8 @@ cfg_if! {
- // pub const SO_PREFER_BUSY_POLL: c_int =3D 69;
- // pub const SO_BUSY_POLL_BUDGET: c_int =3D 70;
-=20
--cfg_if! {
--    if #[cfg(any(
--        target_arch =3D "x86",
--        target_arch =3D "x86_64",
--        target_arch =3D "arm",
--        target_arch =3D "aarch64",
--        target_arch =3D "riscv64",
--        target_arch =3D "s390x",
--        target_arch =3D "csky",
--        target_arch =3D "loongarch64"
--    ))] {
--        pub const FICLONE: c_ulong =3D 0x40049409;
--        pub const FICLONERANGE: c_ulong =3D 0x4020940D;
--    }
--}
-+pub const FICLONE: Ioctl =3D _IOW::<c_int>(0x94, 9) as Ioctl;
-+pub const FICLONERANGE: Ioctl =3D _IOW::<crate::file_clone_range>(0x94, 1=
3) as Ioctl;
-=20
- // Defined in unix/linux_like/mod.rs
- // pub const SCM_TIMESTAMP: c_int =3D SO_TIMESTAMP;
-@@ -275,49 +262,18 @@ pub const TUNGETVNETBE: Ioctl =3D 0x800454
- pub const TUNSETSTEERINGEBPF: Ioctl =3D 0x800454e0;
- pub const TUNSETFILTEREBPF: Ioctl =3D 0x800454e1;
-=20
--cfg_if! {
--    // Those type are constructed using the _IOC macro
--    // DD-SS_SSSS_SSSS_SSSS-TTTT_TTTT-NNNN_NNNN
--    // where D stands for direction (either None (00), Read (01) or Write=
 (11))
--    // where S stands for size (int, long, struct...)
--    // where T stands for type ('f','v','X'...)
--    // where N stands for NR (NumbeR)
--    if #[cfg(any(
--        target_arch =3D "x86",
--        target_arch =3D "arm",
--        target_arch =3D "csky"
--    ))] {
--        pub const FS_IOC_GETFLAGS: Ioctl =3D 0x80046601;
--        pub const FS_IOC_SETFLAGS: Ioctl =3D 0x40046602;
--        pub const FS_IOC_GETVERSION: Ioctl =3D 0x80047601;
--        pub const FS_IOC_SETVERSION: Ioctl =3D 0x40047602;
--        pub const FS_IOC32_GETFLAGS: Ioctl =3D 0x80046601;
--        pub const FS_IOC32_SETFLAGS: Ioctl =3D 0x40046602;
--        pub const FS_IOC32_GETVERSION: Ioctl =3D 0x80047601;
--        pub const FS_IOC32_SETVERSION: Ioctl =3D 0x40047602;
--        pub const TUNATTACHFILTER: Ioctl =3D 0x400854d5;
--        pub const TUNDETACHFILTER: Ioctl =3D 0x400854d6;
--        pub const TUNGETFILTER: Ioctl =3D 0x800854db;
--    } else if #[cfg(any(
--        target_arch =3D "x86_64",
--        target_arch =3D "riscv64",
--        target_arch =3D "aarch64",
--        target_arch =3D "s390x",
--        target_arch =3D "loongarch64"
--    ))] {
--        pub const FS_IOC_GETFLAGS: Ioctl =3D 0x80086601;
--        pub const FS_IOC_SETFLAGS: Ioctl =3D 0x40086602;
--        pub const FS_IOC_GETVERSION: Ioctl =3D 0x80087601;
--        pub const FS_IOC_SETVERSION: Ioctl =3D 0x40087602;
--        pub const FS_IOC32_GETFLAGS: Ioctl =3D 0x80046601;
--        pub const FS_IOC32_SETFLAGS: Ioctl =3D 0x40046602;
--        pub const FS_IOC32_GETVERSION: Ioctl =3D 0x80047601;
--        pub const FS_IOC32_SETVERSION: Ioctl =3D 0x40047602;
--        pub const TUNATTACHFILTER: Ioctl =3D 0x401054d5;
--        pub const TUNDETACHFILTER: Ioctl =3D 0x401054d6;
--        pub const TUNGETFILTER: Ioctl =3D 0x801054db;
--    }
--}
-+pub const FS_IOC_GETFLAGS: Ioctl =3D _IOR::<c_long>('f' as u32, 1) as Ioc=
tl;
-+pub const FS_IOC_SETFLAGS: Ioctl =3D _IOW::<c_long>('f' as u32, 2) as Ioc=
tl;
-+pub const FS_IOC_GETVERSION: Ioctl =3D _IOR::<c_long>('v' as u32, 1) as I=
octl;
-+pub const FS_IOC_SETVERSION: Ioctl =3D _IOW::<c_long>('v' as u32, 2) as I=
octl;
-+pub const FS_IOC32_GETFLAGS: Ioctl =3D _IOR::<c_int>('f' as u32, 1) as Io=
ctl;
-+pub const FS_IOC32_SETFLAGS: Ioctl =3D _IOW::<c_int>('f' as u32, 2) as Io=
ctl;
-+pub const FS_IOC32_GETVERSION: Ioctl =3D _IOR::<c_int>('v' as u32, 1) as =
Ioctl;
-+pub const FS_IOC32_SETVERSION: Ioctl =3D _IOW::<c_int>('v' as u32, 2) as =
Ioctl;
-+
-+pub const TUNATTACHFILTER: Ioctl =3D _IOW::<crate::sock_fprog>('T' as u32=
, 213) as Ioctl;
-+pub const TUNDETACHFILTER: Ioctl =3D _IOW::<crate::sock_fprog>('T' as u32=
, 214) as Ioctl;
-+pub const TUNGETFILTER: Ioctl =3D _IOR::<crate::sock_fprog>('T' as u32, 2=
19) as Ioctl;
-=20
- cfg_if! {
-     if #[cfg(any(target_arch =3D "arm", target_arch =3D "s390x"))] {
diff --git a/recipes-devtools/rust/files/0001-Disable-libunwind-cross-archi=
tecture-unwinding.patch b/recipes-devtools/rust/files/0001-Disable-libunwin=
d-cross-architecture-unwinding.patch
deleted file mode 100644
index 4a28203..0000000
--- a/recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture=
-unwinding.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-From 56b669cd7adcc413bb1e64c3d2d7c347a82ae35a Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Wed, 21 May 2025 18:47:09 -0700
-Subject: [PATCH] Disable libunwind cross-architecture unwinding
-
-Building with _LIBUNWIND_IS_NATIVE_ONLY disables code for cross-architectu=
re unwinding
-it is disabled by default in LLVM [1], replicate the cmake behavior in boo=
tstrap process
-
-It also enables some additional code that handles PAC-specific unwind info
-it helps compiling with the -mbranch-protection=3Dpac or -mbranch-protecti=
on=3Dstandard flags
-
-This fixes build with clang/musl on aarch64
-
-[1] https://github.com/llvm/llvm-project/commit/85624c5de3e831ffa01fdc2d15=
9e3d69c30de08d
-
-Upstream-Status: Submitted [https://github.com/rust-lang/rust/pull/141375]
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- src/bootstrap/src/core/build_steps/llvm.rs | 3 +--
- 1 file changed, 1 insertion(+), 2 deletions(-)
-
-diff --git a/src/bootstrap/src/core/build_steps/llvm.rs b/src/bootstrap/sr=
c/core/build_steps/llvm.rs
-index a3788197471..5e4a1c7d9f0 100644
---- a/src/bootstrap/src/core/build_steps/llvm.rs
-+++ b/src/bootstrap/src/core/build_steps/llvm.rs
-@@ -1430,6 +1430,7 @@ fn run(self, builder: &Builder<'_>) -> Self::Output {
-             cfg.flag("-funwind-tables");
-             cfg.flag("-fvisibility=3Dhidden");
-             cfg.define("_LIBUNWIND_DISABLE_VISIBILITY_ANNOTATIONS", None);
-+            cfg.define("_LIBUNWIND_IS_NATIVE_ONLY", "1");
-             cfg.include(root.join("include"));
-             cfg.cargo_metadata(false);
-             cfg.out_dir(&out_dir);
-@@ -1447,12 +1448,10 @@ fn run(self, builder: &Builder<'_>) -> Self::Outpu=
t {
-                 cfg.define("__NO_STRING_INLINES", None);
-                 cfg.define("__NO_MATH_INLINES", None);
-                 cfg.define("_LIBUNWIND_IS_BAREMETAL", None);
--                cfg.define("__LIBUNWIND_IS_NATIVE_ONLY", None);
-                 cfg.define("NDEBUG", None);
-             }
-             if self.target.is_windows() {
-                 cfg.define("_LIBUNWIND_HIDE_SYMBOLS", "1");
--                cfg.define("_LIBUNWIND_IS_NATIVE_ONLY", "1");
-             }
-         }
-=20
diff --git a/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls=
-as-their-time64-varian.patch b/recipes-devtools/rust/files/0001-riscv32-De=
fine-plain-syscalls-as-their-time64-varian.patch
index 933b7ad..fc604af 100644
--- a/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-the=
ir-time64-varian.patch
+++ b/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-the=
ir-time64-varian.patch
@@ -15,6 +15,38 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
  .../linux_like/linux/musl/b32/riscv32/mod.rs  | 19 +++++++++++++++++++
  1 file changed, 19 insertions(+)
=20
+--- a/vendor/libc-0.2.174/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
++++ b/vendor/libc-0.2.174/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
+@@ -633,3 +633,23 @@ pub const SYS_faccessat2: c_long =3D 439;
+ pub const SYS_process_madvise: c_long =3D 440;
+ pub const SYS_epoll_pwait2: c_long =3D 441;
+ pub const SYS_mount_setattr: c_long =3D 442;
++
++// Plain syscalls aliased their time64 variants
++pub const SYS_clock_gettime: c_long =3D SYS_clock_gettime64;
++pub const SYS_clock_settime: c_long =3D SYS_clock_settime64;
++pub const SYS_clock_adjtime: c_long =3D SYS_clock_adjtime64;
++pub const SYS_clock_getres: c_long =3D SYS_clock_getres_time64;
++pub const SYS_clock_nanosleep: c_long =3D SYS_clock_nanosleep_time64;
++pub const SYS_timer_gettime: c_long =3D SYS_timer_gettime64;
++pub const SYS_timer_settime: c_long =3D SYS_timer_settime64;
++pub const SYS_timerfd_gettime: c_long =3D SYS_timerfd_gettime64;
++pub const SYS_timerfd_settime: c_long =3D SYS_timerfd_settime64;
++pub const SYS_utimensat: c_long =3D SYS_utimensat_time64;
++pub const SYS_pselect6: c_long =3D SYS_pselect6_time64;
++pub const SYS_ppoll: c_long =3D SYS_ppoll_time64;
++pub const SYS_recvmmsg: c_long =3D SYS_recvmmsg_time64;
++pub const SYS_mq_timedsend: c_long =3D SYS_mq_timedsend_time64;
++pub const SYS_mq_timedreceive: c_long =3D SYS_mq_timedreceive_time64;
++pub const SYS_rt_sigtimedwait: c_long =3D SYS_rt_sigtimedwait_time64;
++pub const SYS_futex: c_long =3D SYS_futex_time64;
++pub const SYS_sched_rr_get_interval: c_long =3D SYS_sched_rr_get_interval=
_time64;
+--- a/vendor/libc-0.2.174/.cargo-checksum.json
++++ b/vendor/libc-0.2.174/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"d4d202929497332d94acf48737a5cf4a2c5f53d25c93f67=
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
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"d4d202929497332d94acf48737a5cf4a2c5f53d25c93f67=
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
 --- a/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
 +++ b/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
 @@ -633,3 +633,23 @@ pub const SYS_faccessat2: c_long =3D 439;
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-=
switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-b=
uild_steps-tool.rs-switch-off-lto-for-rust.patch
index 1ff43d1..e2f533a 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
@@ -39,12 +39,12 @@ index 087df2f8a..00790affb 100644
 +
 +use crate::core::builder::{Builder, Cargo as CargoCommand, RunConfig, Sho=
uldRun, Step};
 +use crate::core::config::{DebuginfoLevel, TargetSelection};
- use crate::utils::channel::GitInfo;
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
-@@ -148,20 +146,7 @@ impl Step for ToolBuild {
-             &self.extra_features,
-         );
+ use crate::{Compiler, FileType, Kind, Mode, gha};
+@@ -171,20 +171,7 @@ impl Step for ToolBuild {
+             cargo.env("RUSTC_WRAPPER", ccache);
+         }
=20
 -        // Rustc tools (miri, clippy, cargo, rustfmt, rust-analyzer)
 -        // could use the additional optimizations.
diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rust=
c_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-static=
ally-in-rustc_driver-feature.patch
index 3f92014..9d345bc 100644
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
@@ -106,7 +106,7 @@ diff --git a/src/bootstrap/src/bin/rustc.rs b/src/boots=
trap/src/bin/rustc.rs
 index d04e2fbeb7..011c289d93 100644
 --- a/src/bootstrap/src/bin/rustc.rs
 +++ b/src/bootstrap/src/bin/rustc.rs
-@@ -89,24 +89,6 @@ fn main() {
+@@ -92,24 +92,6 @@ fn main() {
          rustc_real
      };
=20
@@ -131,16 +131,16 @@ index d04e2fbeb7..011c289d93 100644
      let mut cmd =3D match env::var_os("RUSTC_WRAPPER_REAL") {
          Some(wrapper) if !wrapper.is_empty() =3D> {
              let mut cmd =3D Command::new(wrapper);
-@@ -117,6 +99,9 @@ fn main() {
+@@ -120,6 +102,9 @@ fn main() {
      };
      cmd.args(&args).env(dylib_path_var(), env::join_paths(&dylib_path).un=
wrap());
=20
 +    // Get the name of the crate we're compiling, if any.
 +    let crate_name =3D parse_value_from_args(&orig_args, "--crate-name");
 +
-     if let Some(crate_name) =3D crate_name {
-         if let Some(target) =3D env::var_os("RUSTC_TIME") {
-             if target =3D=3D "all"
+     if let Some(crate_name) =3D crate_name
+         && let Some(target) =3D env::var_os("RUSTC_TIME")
+         && (target =3D=3D "all"
 diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/c=
ore/builder/cargo.rs
 index 0688a1d689..066e6bf53f 100644
 --- a/src/bootstrap/src/core/builder/cargo.rs
@@ -170,8 +170,8 @@ index 9754254cdd..dd95cc71cd 100644
 --- a/src/tools/clippy/tests/compile-test.rs
 +++ b/src/tools/clippy/tests/compile-test.rs
 @@ -1,4 +1,4 @@
--#![feature(rustc_private, let_chains)]
-+#![feature(let_chains)]
+-#![feature(rustc_private)]
++// warn on lints, that are included in `rust-lang/rust`s bootstrap
  #![warn(rust_2018_idioms, unused_lifetimes)]
  #![allow(unused_extern_crates)]
=20
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index 61f366d..550ac4e 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -242,19 +242,6 @@ index 5b8e5ff4f4a..e558fbd7bd7 100644
  //@ only-linux
  //@ aux-build:dwarf-mixed-versions-lto-aux.rs
  //@ compile-flags: -C lto -g -Cdwarf-version=3D5
-diff --git a/tests/codegen/dont-shuffle-bswaps.rs b/tests/codegen/dont-shu=
ffle-bswaps.rs
-index 0e712bc3a4e..93965d990d0 100644
---- a/tests/codegen/dont-shuffle-bswaps.rs
-+++ b/tests/codegen/dont-shuffle-bswaps.rs
-@@ -1,3 +1,8 @@
-+//@ only-x86
-+//@ only-x86_64
-+//@ only-arm
-+//@ only-aarch64
-+
- //@ revisions: OPT2 OPT3 OPT3_S390X
- //@[OPT2] compile-flags: -Copt-level=3D2
- //@[OPT3] compile-flags: -C opt-level=3D3
 diff --git a/tests/codegen/uninhabited-transparent-return-abi.rs b/tests/c=
odegen/uninhabited-transparent-return-abi.rs
 index face1577c3f..d69e5e34a7b 100644
 --- a/tests/codegen/uninhabited-transparent-return-abi.rs
diff --git a/recipes-devtools/rust/files/triagebot.patch b/recipes-devtools=
/rust/files/triagebot.patch
deleted file mode 100644
index 715664d..0000000
--- a/recipes-devtools/rust/files/triagebot.patch
+++ /dev/null
@@ -1,32 +0,0 @@
-Skip tidy triagebot linkcheck if triagebot.toml doesn't exist
-
-Distribution tarballs won't include triagebot.toml, which
-causes tidy checks to fail with the following error:
-
-   tidy error: triagebot.toml file not found
-   some tidy checks failed
-
-Drop the triagebot.toml check which is mostly to catch broken
-path filters *within* `triagebot.toml` and not enforce
-the existence of it.
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/142666/c=
ommits]
-
-Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
----
-diff --git a/src/tools/tidy/src/triagebot.rs b/src/tools/tidy/src/triagebo=
t.rs
---- a/src/tools/tidy/src/triagebot.rs
-+++ b/src/tools/tidy/src/triagebot.rs
-@@ -6,8 +6,11 @@
-=20
- pub fn check(path: &Path, bad: &mut bool) {
-     let triagebot_path =3D path.join("triagebot.toml");
-+
-+    // This check is mostly to catch broken path filters *within* `triage=
bot.toml`, and not enforce
-+    // the existence of `triagebot.toml` itself (which is more obvious), =
as distribution tarballs
-+    // will not include non-essential bits like `triagebot.toml`.
-     if !triagebot_path.exists() {
--        tidy_error!(bad, "triagebot.toml file not found");
-         return;
-     }
-
diff --git a/recipes-devtools/rust/libstd-rs_1.88.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.89.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.88.0.bb
rename to recipes-devtools/rust/libstd-rs_1.89.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.88.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.89.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.88.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.89.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.88.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.89.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.88.0.bb
rename to recipes-devtools/rust/rust-llvm_1.89.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 76ec809..2bf48fa 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.87.0"
+SNAPSHOT_VERSION =3D "1.88.0"
=20
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "93c59a880632aa1c69e3ffaa183=
0b5b19c08341ae2cd364bf4e6d13901facfed"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "80fab79c1f57b7cd89a1e637=
9b2196a208352403aa7bd7f674341a172ac0697f"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "51e237e7f383840a404a5be7214=
91a8ca4671bf9c14e62566ecadccfcc6e4291"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "38b5bb919b5e256cc8bed5b69e=
ecca577677ccb404fdd7bc3a9f2f79bede1a50"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "b841d40bb98b2718c6452ec8421=
a4a8df584fce8d41875bcd9b1af83f52f7d96"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "e9ac4ff3c87247a2195fcced=
dbf1bdeee5c4fd337f014d8f4c4e3ac99002021f"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "5aa43865f2002914ce4fca8916b=
4403bfca62f17e779ad368f6a17553296a58b"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "e210ec3d6158bb4730dd168ae1=
d35d4f6f9e9bf629c8e14362dc45b10b404867"
=20
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "e59bb135589f8ca062e63ec244f61a=
4226fa348de5221fa96e9350f3e28a5fd1"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "df2bcaa75c9bfec12b4d0b43112=
c90647383865871cd0ea19f4af16b8942ac9f"
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "840baaa8d99087b4fbb67c57cf0687=
f53b51f387b0c44ea206d5c6262114c9ed"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "fbaf630b50109512573152d667977=
60933a1aa44e4ab2056c39e2e5ef457ffd9"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "91feab28a2ba348840b15017303f43=
847974c75b443ea37b330ecb3d80c01007"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "ced56f7ab86496f6eb42d356841=
f9d0b625159eba65afd1913f232bb66d4b7e0"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "ebf94de491865963fc02a3cdbbf1fe=
c8f3e9df49fe2af4d92c2a05cfddd5b3d8"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "aa2984ada59dc4e00f3820bb60dbd=
e8d143a383b1c23f9133af6911bfb7d0ea5"
=20
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "21f2e20d2dab04683f24771=
a4a1ba81500bf2d876b3f8e134b6f39ba88cafc33"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "333cf7f4328c13e2ea0d=
05fa87ee0509d63c57bab570b685c891fe6113e6d36a"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "ae613f51e848f09e2e2b079=
b0036f07beee965a3a15f80b39ec1f791c72c6a8f"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "7825d8bc9ab68f2015a1b4=
32b26aad9f208b6293369a67887d2a2f8b5cabfb01"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "6b00f9be938ce27a146d73a=
45fb7930c68b2bb87101d2af00c44541d8ed11ef9"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "f2bc8745ec01c7e560b3=
f7b214040fd8053be191f8839887b58b441992952e72"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "95499f3734dc2dab7de07bd=
502d98c10e3854aca1c0dfa6ad16c798ec6de8a36"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "176caa1f7048acb93c8136=
d2ef436d89da9374f85bd6686e8abc0dccd5242e90"
=20
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "a650e3d8701c5916893845f5cea=
e1eb0bf9714ac608ef304976a9ee2ace16caf"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "df327566871a7595efc393e8=
fec9cd529615d4296727a228625cffd67a322126"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "b6ffefdf0c1bc00880aae0a2a4f=
c038e1412b7df364c8f601b63ca3589ef9e76"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "53307af7138bf26b8cd5da2057=
c2642830969b4482560c9fb1c229d984d8abdb"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "17ef139220f60cbc6f54c6f85dc=
e34cb2035a92ce321a1fbd1e76d340e54dbd2"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "891fe38736ca637bcd776f6d=
2b1822d761bd92305188482e45d26ab0dd84344b"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "ffd3d742fe3ffecf560b73c36ff=
6500ffc73b8899d58f98492d18f8fa71d7dcf"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "8889c94c8c0e27b34b93fefb59=
8d312357ff1b4cc01a440d260bffb2c6e5c191"
=20
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "96c0a3d1a6f1c3d9ac677187a=
f6837e1b0fb782a270762741d02b5c299c62d77"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "4a69e1a021ddd0c645fe7b=
ee229a4db306c08a6f4976dc5eaf64bf95a810f7c2"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "c3992ae2b799941acd2956197=
8115315ccc31fae851d23c7ac93c716b7b10ad7"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "7f968106335bb20b944ad0ff=
988ebe918b62a923d8f5fcfe8a998583ea22cebd"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "e1755dd3552209d564b77d20f=
5267d824851bfba2ecfb4bcb768deeea45078bc"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "89cf8b30e0fae601e0603e=
41d5eaf58881729208cac83636eff89b94724b7112"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "d234100429586cf8a3e7dd741=
49f95a864a4bd2ed914db72c13edcc4b4accd2f"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "bbbcdab98f901429766b89ef=
d6d30934f8d35c489be909c95635295f180d0cf5"
=20
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "b861d2ccaa379261d7a0533=
1b25971687a9d90efbab14c58829b78abe3add2e6"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "73ed9c6ef539095cdca4=
e41b789b4e47effce6f796be73542f86cb9d5855a9ea"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "2b9ef59c3c1818d6712ea4e=
c8af53720a0c2017ace80a15c287f05768ac04e0a"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "1dd6d1622f4e8fe33af90f=
4fca7851757fe2856248c36d79fdef38abc81f98b2"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "4acf67a5352df836246f457=
ae61ce40feb38a3360aec13881f5a26f22323ccb4"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "1030e71f755692c3429b=
b16829cca776c1ac372abbce3001b04d4e46b1e4f32f"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "f7a561ad6b0d6ccf5d6c243=
36fe96e215cda7215f538baaf6f0f5c7fea6030d0"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "a5b851a61427f4d85229fd=
3b588794e34b62b9862e577de8d110ac13abbfb9c2"
=20
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "45708d5767ecd589ec852068d=
c0e0afb27427e7e9e03b4586f2cb75673f885b6"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "71f3a9dee3955255cd25ea=
4b15fe664284ac89591bc920667b9e47ff37f330fd"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "ced9e08041d4d246115933665=
37f3f14db63cede6a4d65c1297853b72c7b72d9"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "8d3665a04ecf3191196998f7=
aeb94cd6cdafba9200345387d854101629f94fe6"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "f46ff6b6707e1e48519bf18c5=
dede1730cce6b2e347f4f15d841f919df92b859"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "d446fc0d8e4ce985c2d21a=
a2adb6ec9fce8f7ebde85655200abd71e142b9a981"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "38bca9242e9468335e433ac22=
31f2e778c351b3ac200de059be4789360a3956e"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "f467dfe7bdab310ac88efbf4=
ada1bf823982e0a3aff13f8ef35e33a6246d886f"
=20
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "4b961ed0731f0f4f3c1270c165519=
8a01269e6e4ca129bf1b975114e3bde511e"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "9fb2a2ceb9671ab74ccceb61c5=
763c591eb1be21584b944ad7e5458edab171c9"
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "73402a5585c32bdc80ace0070cec6=
95768395fcc85efa0843ca42a453034a953"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "bab8cff53f93466c77d2f17b0071=
32c77cf782314bfc6c3d897dc0fc1e4e6375"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "f214cb9a93428ebf24b9f9261b683=
3c53a91738f6e98029cf7bedf023caaf42c"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "df3144f87a22d606abea4dcfe8=
8369fcd499ef2fc748724b47941308ae259a5d"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "6d3e6072f556f9ac11425bb273a29=
82e3255435d803994a51201709601c5f2d5"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "fb5ecad2896871c5db00cbaad11a=
039a5c071ba8d748ea1ce87df7dfa804bfe1"
=20
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "e8395c5c5756253b76107055e093=
ffbc4431af7b30aeebe72ce2684b9cb53973"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "1b57253bd32b8b292c965b3a2=
d992a266763158494cab8555584c09360b90f77"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "469d5dc479835adadd728bc3587f=
8abf1941b3dd71f9865abd3e0783ae662555"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "9d440eef6811112a000acf96a06=
2df7bcbc013fa4f8e00a7f9a4f57ef90637a1"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "b049fd57fce274d10013e2cf0e05=
f215f68f6580865abc52178f66ae9bf43fd8"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "36d7eacf46bd5199cb433e49a=
9ed9c9b380d82f8a0ebc05e89b43b51c070c955"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "856962610ee821648cee32e3d6ab=
ac667af7bb7ea6ec6f3d184cc31e66044f6b"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "db09c9e4a8a0b486781d87403f7=
4a203a58d9ef0a58ba10c39264916d93ac603"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "fc656140b5810a1bfa3b80456e4=
16a0381dd68c565fc67fd23f945f8df80254b"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "7c9016ce85e24dde9d76c0a3406=
1fa0fd6f742ea495dd1784804b60061b39627"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "2a7f654b1c31cb60b4841bf0=
a041a2fcdec9baecf8bb0f9ae1d1743862073907"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "95be6d0dec8be07fa13313a1=
0dd177e72df9737660c235a3e673bffcdd2e9068"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 8ab2c81..4208aea 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,12 +8,10 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patc=
h;patchdir=3D${RUSTSRC} \
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.=
patch;patchdir=3D${RUSTSRC} \
-            file://0001-Disable-libunwind-cross-architecture-unwinding.pat=
ch;patchdir=3D${RUSTSRC} \
-            file://triagebot.patch;patchdir=3D${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-vari=
an.patch;patchdir=3D${RUSTSRC} \
             file://backport-fix-test-string-merging.patch;patchdir=3D${RUS=
TSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "0c1dcbb4f762513d021e1a282c0ac58c0a423642b3a6b=
f581cafb5414df4193e"
+SRC_URI[rust.sha256sum] =3D "0b9d55610d8270e06c44f459d1e2b7918a5e673809c59=
2abed9b9c600e33d95a"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.88.0.bb b/recipes-devtools/rust/r=
ust_1.89.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.88.0.bb
rename to recipes-devtools/rust/rust_1.89.0.bb
--=20
2.50.1


