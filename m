Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FABC88E5C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:42 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48498.1789157732931339175
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OTkzIoEG;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90e9e042ee1so14089326d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157732; x=1789762532; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O5FvJfF6IIAaFSgnN05Fk4S+WDve/x+vbR5n1hlnsAw=;
        b=OTkzIoEGQVkhLdTnxZulZF887kVee0JlP+63fbWFOIl/2zz2cH2zFOKeVtEhKra31d
         Fn8rDsPouA/XiMOUyEkH+gCpZCm8KiqXW8RsRjDAIYeWx50RnUMrek8azx1zUNijKKc4
         AQ+LGLSvFkzqgYWkapeNFLKwNmq8XIEHi499M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157732; x=1789762532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O5FvJfF6IIAaFSgnN05Fk4S+WDve/x+vbR5n1hlnsAw=;
        b=YrJchLbiOVlALJtbGsZbuugck78zXW8Ynfc0tXtAQa4TCYataTCz0zHhNRrf1h9JTD
         8dHOr0JzEJJKcZ5xUjbGZQ2oYzOGZsU/SQySq0mmjEEHEdyAi21GIGZgZAd+89LipJn1
         +QWzt8Z3OzuLO8mamYL1xPmeCl1z1Gytydm76PS8DHtnb70W7g2Vluob1oDiRFxlNE4r
         8czoVwl8gHXoOKyhCKslg9YXcOePSOjUJxG90UEzs4RkhOg3a1V27on1iwYqRWR+D2z3
         PSzQ8Y+PmrGPEjJYR4i6p7sIt+dQfuLNYsZvRklznNpt0xL94FjsM7SC7J+328Cm5rm8
         wEyw==
X-Gm-Message-State: AFuF++lij9O9BSLBqDO70wMp7pEVNMyGnJ4A5nsrNkaKQPy64BX+TRJS
	e6E9jY+xbndNyOcBMdWozytoDUlQe81FaRpqv5N5zFzjxqJktipiNhFvmozNjSCxE3a0sVF21jW
	5Ft6n
X-Gm-Gg: AYBFou17QmMIdeSKTPJOQGl0yqqNBWxtLiSH55P4bhTpmjcDgCHZ0C7KCoI8UkXi2lR
	yEl1afruelrSQGFa99O3vn8e8pf5qOocP/A+GGVYOiJnr8WNx/S9Tnak3BdxRlY3ks6O9FUS5yq
	nho54C7RnGjgX3KQsUTo6cNiVH04uFZ/ByKLML8sRnj7vNn1fL6ARWiYiHBeM4QptWA2YAmV6hm
	RxSzLMJfUD8Rym8h8CyrQ3m/hkAkB7jNyIr63Td9/KYYNPC2W5UXaSUkQNwMLHn+K39itQhSsyK
	sZzua/iU1RQ4EETRNGak290D7bGCGTXKk6wMvud9vAQRIl7SGt4EYUGQYqvvM1vOzqlmbGllph+
	JRf0bmTWHbdKxIyuWdT/fCRR2biiJ7oIkht3wneINZ/CHMb4pjtUrgSRRP9ogRm0TUTj+TmNUaD
	5deBDwdoSLyKnJcimZYiwD4rQ7FS6zKuY1VVjucnRZHIXQtDH5vM+32FvY+hZW50qWirf1IRw9K
	oSdMVS7sKy4oVg63JVBpm9sk6D5zYw0f027yzXfgLeVk7p4tDaviGkI9WPZxETiUDzvCALoUYt2
	CViJjdwOGeY0SLo/hvqeIGWYnUMHOI6OqyQ=
X-Received: by 2002:a05:6214:1d2e:b0:907:c025:e4 with SMTP id 6a1803df08f44-91212086ac4mr80287446d6.13.1789157729442;
        Fri, 11 Sep 2026 13:15:29 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:29 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 08/11] rust: Upgrade 1.97.1 -> 1.98.0
Date: Fri, 11 Sep 2026 16:15:12 -0400
Message-ID: <ba2a817da37cc6e62851e4387c03a7affafd8df4.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4815

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Rust Changes:
https://github.com/rust-lang/rust/releases/tag/1.98.0

Cargo Changes:
https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-198-2026-08-20

Release highlights:
- New lints: deny-by-default `invalid_runtime_symbol_definitions` and
  warn-by-default `c_void_returns` for checking core::ffi::c_void returns
- Stabilized APIs: str::substr_range, algebraic float operations,
  String::from_utf16{le,be}, NumBuffer, and integer format_into

Update local patches:
0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
repro-issue-fix-with-cc-crate-hashmap.patch
rust-oe-selftest.patch

New patch:
0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch
Backport a patch from rust upstream to fix oe-selftest failure
seen with rust 1.98.0

Selftest Change:
Ignore one failing testcase because of custom target.

Ignore the failing test_remap_cwd_prefix_not_in_remap_path_prefix
selftest because "*-poky-linux-gnu" is a custom target and is not
included in Rust's built-in target list.

Issue: https://github.com/rust-lang/rust/issues/155963

Excluded tests:
+---------+---------+---------+
| Before  |  After  | Skipped |
+---------+---------+---------+
|   42    |   43    |   +1    |
+---------+---------+---------+

rust v1.98.0 (from autobuilder)
+-------------+---------+---------+
| Machine     | Passed  | Skipped |
+-------------+---------+---------+
| qemux86-64  |  23169  |   805   |
| qemux86     |  22913  |  1061   |
| qemuarm64   |  22999  |   975   |
| qemuarm     |  22893  |  1081   |
| qemuriscv64 |  22942  |  1032   |
+-------------+---------+---------+

Test results difference (1.98.0 - 1.97.1):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |  +417  |   +43   |
| qemux86     |  +408  |   +52   |
| qemuarm64   |  +420  |   +40   |
| qemuarm     |  +407  |   +53   |
| qemuriscv64 |  +414  |   +46   |
+-------------+--------+---------+

Reproducibility: PASSED (x86-64)

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2c80b400ff591709e489de105872df2d0e60b8e0)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   4 +-
 .../rust/{cargo_1.97.1.bb =3D> cargo_1.98.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |   9 +-
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   6 +-
 ...ip-StdarchVerify-when-remote-testing.patch |  30 +++++
 ...epro-issue-fix-with-cc-crate-hashmap.patch |   5 +-
 .../rust/files/rust-oe-selftest.patch         |  24 ++--
 ...ibstd-rs_1.97.1.bb =3D> libstd-rs_1.98.0.bb} |   0
 ....97.1.bb =3D> rust-cross-canadian_1.98.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +++++++++---------
 recipes-devtools/rust/rust-source.inc         |   3 +-
 ...source_1.97.1.bb =3D> rust-source_1.98.0.bb} |   0
 .../rust/{rust_1.97.1.bb =3D> rust_1.98.0.bb}   |   0
 13 files changed, 110 insertions(+), 75 deletions(-)
 rename recipes-devtools/rust/{cargo_1.97.1.bb =3D> cargo_1.98.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0003-bootstrap-skip-Stdarch=
Verify-when-remote-testing.patch
 rename recipes-devtools/rust/{libstd-rs_1.97.1.bb =3D> libstd-rs_1.98.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.97.1.bb =3D> rust-cros=
s-canadian_1.98.0.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.97.1.bb =3D> rust-source_1.98.=
0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.97.1.bb =3D> rust_1.98.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7595a8b..5997fb9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,8 +13,8 @@ LAYERSERIES_COMPAT_wrynose-rust-mixin =3D "wrynose"
=20
 LAYERDEPENDS_wrynose-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.97.1%"
+RUSTVERSION ?=3D "1.98.0%"
=20
 # For lack of a better place to put this since it needs to be visible
 # globally, carry it here.
-RECIPE_MAINTAINER:pn-rust-source-1.97.1 =3D "Deepesh Varatharajan <Deepesh=
.Varatharajan@windriver.com>"
+RECIPE_MAINTAINER:pn-rust-source-1.98.0 =3D "Deepesh Varatharajan <Deepesh=
.Varatharajan@windriver.com>"
diff --git a/recipes-devtools/rust/cargo_1.97.1.bb b/recipes-devtools/rust/=
cargo_1.98.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.97.1.bb
rename to recipes-devtools/rust/cargo_1.98.0.bb
diff --git a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-ri=
scv32gc-unknown-linux-g.patch b/recipes-devtools/rust/files/0001-Define-mor=
e-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
index 3a8ee0b..92ce9ff 100644
--- a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
+++ b/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
@@ -9,6 +9,7 @@ architectures, including riscv32gc-unknown-linux-gnu.
=20
 Upstream-Status: Backport [https://github.com/rust-lang/libc/pull/4382]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
 ---
  src/unix/linux_like/linux/arch/generic/mod.rs | 75 ++++---------------
  1 file changed, 15 insertions(+), 60 deletions(-)
@@ -111,15 +112,15 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 --- a/vendor/libc-0.2.169/.cargo-checksum.json
 +++ b/vendor/libc-0.2.169/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
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
+-{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
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
-+{"files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
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
++{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"10b1465646eab936004b2ef7e46ba605d7b0cc5=
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
--{"files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
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
+-{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
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
-+{"files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
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
++{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"05a2dd302c1c8516cc824f6153ebee609e34091=
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
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-=
switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-b=
uild_steps-tool.rs-switch-off-lto-for-rust.patch
index 35ebf3b..d4cec95 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
@@ -16,6 +16,7 @@ various crates, which should be safe to mix.
=20
 Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/r=
ust/issues/134589]
 Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
 ---
  src/bootstrap/src/core/build_steps/tool.rs | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
@@ -25,7 +26,7 @@ index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
 @@ -13,14 +13,12 @@ use std::ffi::OsStr;
- use std::path::PathBuf;
+ use std::path::{Path, PathBuf};
  use std::{env, fs};
=20
 -use crate::core::build_steps::compile::is_lto_stage;
@@ -42,7 +43,7 @@ index 087df2f8a..00790affb 100644
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
  use crate::{Compiler, FileType, Kind, Mode};
-@@ -121,22 +121,7 @@ impl Step for ToolBuild {
+@@ -121,22 +118,7 @@ impl Step for ToolBuild {
              cargo.env("RUSTC_WRAPPER", ccache);
          }
=20
@@ -67,6 +68,7 @@ index 087df2f8a..00790affb 100644
              cargo.allow_features(self.allow_features);
          }
 diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/cor=
e/builder/mod.rs
+index 1234567..abcdefg 100644
 --- a/src/bootstrap/src/core/builder/mod.rs
 +++ b/src/bootstrap/src/core/builder/mod.rs
 @@ -13,7 +13,7 @@ use clap::ValueEnum;
diff --git a/recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-=
when-remote-testing.patch b/recipes-devtools/rust/files/0003-bootstrap-skip=
-StdarchVerify-when-remote-testing.patch
new file mode 100644
index 0000000..a57765f
--- /dev/null
+++ b/recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-when-re=
mote-testing.patch
@@ -0,0 +1,30 @@
+From ca4541f4241f48f8344bc8b8dd7fcbb476ea6900 Mon Sep 17 00:00:00 2001
+From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+Date: Wed, 26 Aug 2026 03:49:52 -0700
+Subject: [PATCH] bootstrap: skip StdarchVerify when remote testing is enab=
led
+
+When TEST_DEVICE_ADDR is set for cross-testing, the StdarchVerify step
+incorrectly attempts to run on the remote target. Since stdarch-verify
+is a host-only verification tool, skip it when remote testing is enabled.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/ca4541=
f4241f48f8344bc8b8dd7fcbb476ea6900]
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+
+diff --git a/src/bootstrap/src/core/build_steps/test.rs b/src/bootstrap/sr=
c/core/build_steps/test.rs
+index a2d05f8..3753aec 100644
+--- a/src/bootstrap/src/core/build_steps/test.rs
++++ b/src/bootstrap/src/core/build_steps/test.rs
+@@ -962,7 +962,12 @@ impl Step for StdarchVerify {
+     }
+
+     fn make_run(run: RunConfig<'_>) {
+-        run.builder.ensure(StdarchVerify);
++        let builder =3D run.builder;
++        if builder.remote_tested(run.target) {
++            builder.info("remote testing is not supported by stdarch-veri=
fy. skipping");
++            return;
++        }
++        builder.ensure(StdarchVerify);
+     }
+
+     fn run(self, builder: &Builder<'_>) {
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index 3fa8566..efb379a 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -8,6 +8,7 @@ https://github.com/rust-lang/cc-rs/pull/1277
=20
 Upstream-Status: Submitted [https://github.com/rust-lang/cc-rs/pull/1277]
 Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
 diff --git a/vendor/cc-1.2.0/src/command_helpers.rs b/vendor/cc-1.2.0/src/=
command_helpers.rs
 index fe919a5239..2b1f442019 100644
 --- a/vendor/cc-1.2.0/src/command_helpers.rs
@@ -61,6 +62,6 @@ index b070eeb322..ba768ff86f 100644
 --- a/vendor/cc-1.2.0/.cargo-checksum.json
 +++ b/vendor/cc-1.2.0/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
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
+-{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
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
-+{"files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
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
++{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
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
index 58c7644..41d7384 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -288,18 +288,6 @@ index 89c61cd..144ea0e 100644
  fn main() -> ExitCode {
      rustc_driver::main()
  }
-diff --git a/tests/assembly-llvm/riscv-redundant-memory-stores.rs b/tests/=
assembly-llvm/riscv-redundant-memory-stores.rs
-index acdb69d..2220e6d 100644
---- a/tests/assembly-llvm/riscv-redundant-memory-stores.rs
-+++ b/tests/assembly-llvm/riscv-redundant-memory-stores.rs
-@@ -4,6 +4,7 @@
- //@ compile-flags: -Copt-level=3D3 --target riscv64gc-unknown-linux-gnu
- //@ needs-llvm-components: riscv
- //@ only-riscv64
-+//@ ignore-riscv64
-
- pub struct SomeComplexType {
-     a: u64,
 diff --git a/tests/ui/c-variadic/same-program-multiple-abis-arm.rs b/tests=
/ui/c-variadic/same-program-multiple-abis-arm.rs
 index fbc5573..f259529 100644
 --- a/tests/ui/c-variadic/same-program-multiple-abis-arm.rs
@@ -311,3 +299,15 @@ index fbc5573..f259529 100644
  //@ ignore-thumb (this test uses arm assembly)
  //@ only-eabihf (the assembly below requires float hardware support)
  #![feature(c_variadic, c_variadic_naked_functions)]
+diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interf=
ace/src/tests.rs
+index ab69cf5..f0e3fd3 100644
+--- a/compiler/rustc_interface/src/tests.rs
++++ b/compiler/rustc_interface/src/tests.rs
+@@ -182,6 +182,7 @@ fn test_can_print_warnings() {
+ // storing the absolute cwd there invalidates the incremental cache acros=
s build
+ // directories (see #132132). It must instead be applied via `file_path_m=
apping`.
+ #[test]
++#[ignore]
+ fn test_remap_cwd_prefix_not_in_remap_path_prefix() {
+     sess_and_cfg(
+         &["--remap-path-prefix=3D/explicit=3Dmapped", "-Zremap-cwd-prefix=
=3Dcwd-mapped"],
diff --git a/recipes-devtools/rust/libstd-rs_1.97.1.bb b/recipes-devtools/r=
ust/libstd-rs_1.98.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.97.1.bb
rename to recipes-devtools/rust/libstd-rs_1.98.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.97.1.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.98.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.97.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.98.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 540ae74..f2ee5e3 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,58 +4,58 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.96.0"
-
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "76b1a6e8dd1636e364d4bbba685=
485ff44eee5ff6434add089bab4c703c7e19d"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "538e85452709687797d99057=
9a491ff9b02f8bffba4a5d54cfa945e28868053e"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "09ea03e74aa94e07db7bc00bd2e=
c1ad86d90a7348c89fde3909a8922543b949f"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "f0304a59688cccc77da29bbfbb=
96cb29407b4fdc152337f8de198d81a01eac05"
-
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "8caea1b6a1e76c9452cd2041c78680=
a9948b01abdc06be90c2e5ab3121793398"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "2d13b8c801c9ad1ff55dceacaf1=
d1777601e328bc56cd390c4209a2f61d76ce2"
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "c478ba084e1f95d1dc0cc47d125ab4=
15667277fbbed17d24b80c797cb3b71f42"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "f741c872aa729dbecc5bcf055306b=
82c3a28420a4ad1d0d0d3791b4e640b3eaf"
-
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "173a4daefeae1b3a9f38885=
93acb64bc75b36e8a781056b1515d6ca30cac5fd9"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "1dcd3b58ceb6237d3e21=
9d8e432260d4cac2a196210751c7f33ebe5537839c5f"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "80507b976a3698fd29f9d7d=
b90bb1ba65b2a6f182d7f2f70dd44aa73fc30273a"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "3e6b7c5504eccb08d66ade=
baab3d93a0d88009317512c88404735cd4d1541f71"
-
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "d3f4dc0ba3121ac18cb0948b635=
52573d4521cdf8e4504df916e2785a92d62d1"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "d434927909a92ec1298bd9ea=
51a3d251c1d5ef44c7ed334353cb832a7e124a7b"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "b905b1dd5c2f711f689ef0f641f=
0e1cc92d8977fbede3a31cdb299b7253b9560"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "e741b5bd87a5b7aca17d78a6a2=
e1cff49c3123710de6f3ade47a664359f6fd18"
-
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "bf73e9dc666c3894a9edfe8af=
cc87f69f92c9eae3e401e35097e213f7e77e4d0"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "cf273029a7a8dba56fe4fd=
517ae4c8bd862a3e27c56369a8b9d6411c8d74085d"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "e9cbd8e65bf2a98662ff85d09=
e7059ef09ced38198961cc9433bda9b070fe53c"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "ccf270a4a2cd1bbebb1e8cbd=
4701057aeb8b552097e34c0103d6bcd4c78c998b"
-
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "36f98b29bf631e27e0aaa2f=
fc1e33eb585a8f3a93e60e4b64e355b4e2aec4ede"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "347ff4e5dd463849f213=
91b9db90093dee33578d98f30b42bbb78b4777921747"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "6315038d99cb0270694afd7=
2155faf899aebb700dd14c51f5d7186bfad73ab9a"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "725786e4c0362e1e406631=
aee93b340504dc452d82ead766ed5c15bda4099e32"
-
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "4db1266212a226421893443d7=
ebdc679dc9bf04c9e68bc4140de50e0018c9463"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "595e4a980dccb7571441f3=
30782cad6cd23d64f331ed453de57dd386665f5615"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "96917e09cb2494b6a26173b4b=
b81f8c485e3769771bfb6665e84591a7fee3561"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "ab5fc3717691786362095eac=
58493a29161fb809c5d60deba85fe6eb382b5c94"
-
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "1b8c91ad1ba323c9155adc5a60c9b=
dc0b482357d8a052f72a5a8cd0bc0961474"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "92e5a9dcd09892d399963ab0e8=
de121e0027f2213168f32e13014641c0bfb13b"
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "3d6ba391ed3a97b4cc33edaac6c79=
3f4b979ff3fff5a45613cecbd1c26b4cd2b"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "3b44a8a94e1e9e43679f1bf38664=
08adc4b3e0b5402e8615d1341f10424490da"
-
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "7d7fa1d0cfb0fab71a956bb78f41=
107202c17f30ab56c45288e869a37fd9633d"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "c09c7c646248f14f473f5f7a0=
29af15ee57c3a9f9bc93dfa72d9621938586b82"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "dee75c3c8f9f600ad75bc0c93249=
e767d3047845a4dd668327ce43ab039ba266"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "9b0b89c67d5ce8195e1c8733587=
a63e326353fdda65f62455a64fa03e25659f2"
-
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "3f42faca55ac0df4e94aa5ac3c6=
b86c4a4d5a623cfc084bb41b76674a7705d35"
-
-SRC_URI[rust-std-snapshot-riscv64a23.sha256sum] =3D "727f9d546fe6b16d5b0eb=
4668cff217cef06266e28d1869c963db0597fad8086"
-
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "687a80cee4631d02b820e7a6=
52bd4e30661772a684fa0ce2f936cdd932f31d51"
+SNAPSHOT_VERSION =3D "1.97.1"
+
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "b344b81f0cd4c2246c7da8b197f=
e7a339d7dd02bb15cb69b2524115d9c75224c"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "46aed8e63186350004d8ec6a=
fca798811e6530b514352e5a8a26f3dc4939b3be"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "8f70bcaccea5ba4db187c3fd4d6=
4e24592b4e16af513497201f5909d61691dbe"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "d8bac7b0ba5ca9bb868ccb9e36=
7a1d52f4837f3ebf4892eaf64cda37ce362bb5"
+
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "c096e21362fe1390e7aefc731671bc=
e208a43828a83bcc32a35ffb8302f5802e"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "7f4be0697e96dd81f75f66f0e25=
a51d595223e7c58af6675810f066cab6ef584"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "b76d87a7a550c51c48d4e9396cec29=
917b2e8fcac7b7ffeb6da01b22e2b723dc"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "97d20d083e3475bb50898e399cf67=
6d286763ecd978b2fafb57d5d582af27fdf"
+
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "140c1dd5973d42fb1503b1d=
3bdc6da23a628b07137fc126998ae7f0f41b80a30"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "8b7cbf62dcc4a65da806=
80f9ae6a15d9934ba1fc30a689dbe53de99f6e4622a7"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "41f0ebc698f24fef6989d0e=
31e64d2377ba09d66ad5aba17d88634bd6aea0568"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "c48fcbae8a844db00948b0=
c46527fb701582c8b867ee908d8bdf145953572bce"
+
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "929b9ab78cb8aef161420b33592=
b070516b09f27fdc923dd4153318280449074"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "9c3286cc2aab1868f693cd45=
8d5d7bf8c307aaf8809e9a2dddbfc31ece94629f"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "673caa54fdbf5477ab18bbc20e7=
c580f0f6179a772589abf2d22d3030a94daa2"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "fd3061d0f7e31e515fc615d442=
43588b59adaf0743980477e35bc96e48247396"
+
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "a52596a0fbdb41c4f6874ae7b=
fdeeb0197fb1227f185d897e040cd908de48d63"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "58675598a59db1524e934a=
27f279b6669d65e91f53675d022fd5e32046c2742c"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "48ee9abeaa117a1663c3ef3a1=
771f808cd7d64d86db5d2904d10d8aa829b96e8"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "48b6494a0b5d5cc239827c05=
c46444ad3e2039e11aba3efff1ad4aa6073e9550"
+
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "5ec2a5477d961114b735e43=
138ddee914ce12be225b8a5bfbfadb8ca966bd8f3"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "ab2fb5c9dd7d3a0987c9=
7c9f56732d013a11796fcd1510651570ae2fcc512bb2"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "fcdcda6e055a77ea7fbe6d7=
4e30d3949a0501116c08966a97fd728dc3bf5872e"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "df0d9c12645b006016fbf1=
2634f4b00c54182620907808d11991bf1bc234d7a2"
+
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "3cb19f130eb83b56277c526f7=
37ce02dedf6d38145f5220ff66af5b47c499dcb"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "5cec88477a70fe83c10a12=
efd6bdad1b0f8dd4c1ebba1e427f00c69666c5b6f9"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "df0d9edd65f4f7710a1a49a76=
4a3da84e7a95467ded15dade41bbdf74051743b"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "d7c1ed5a12a028e0a1213428=
3136f24787597f879ad4e9797aedab5f54b40a5e"
+
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "05103f9a7c658bf2b16bb810879c0=
f73e4123ac8ac066f66e277d6809468fe9c"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "6c6b2b285225f3551250bd4c5e=
05293a0839fc18d1625c545b81fbea9f82c31b"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "3236fef696f28c21e754dbd78de27=
72e8b418b7086a4511870e8e469e7ccb572"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "8d0a6a7759451cdbf957cda05275=
79b59ef1b2a7600b65af05257a7d2aea6360"
+
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "9819d0a32d56bd339585319c8026=
0e332779f5541fd66838ab7e016d6c814819"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "1c1e704ae80126b7de34f72ea=
2825f7fd01736dec20732faed47374b95282fba"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "e1be5f5ff7f7f80ca506fb65770b=
759edbdc6d303781ed71c5de8ec8a8394779"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "3441df8fb54db985f8c8a3e8356=
b8874a3f92cc8cca8565cfe36f1dc15935e72"
+
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "a3090f555a9c3fd91d3c8b73152=
eee007fa348d20a8d026ea577a467acf5e7c7"
+
+SRC_URI[rust-std-snapshot-riscv64a23.sha256sum] =3D "1600b3358f88c8a80dc18=
68b6d98ca899fcb1b2b9c512fdc8b832928e7a37875"
+
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "be689309aae0247e0a58a87b=
6ed69c28573ec5ec3f56766cb8b0b3066a3a0a70"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 68f3009..dd3e89a 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -6,8 +6,9 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUS=
T_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
             file://0002-Fix-rust-build-failure-with-unstable-options.patch=
;patchdir=3D${RUSTSRC} \
+            file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.p=
atch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "0ed06fdaffd4722a7702e0b4eebfafc897ab8f513e8e1=
b247cdd7e5c6df6ded2"
+SRC_URI[rust.sha256sum] =3D "271fa73d8174f53d713c46a8310da7bf7cfdcfb8b7cfd=
1c2b74b84a83ae9fb1e"
=20
 # Point UNPACKDIR into the work-shared location so rust-source.bb and all
 # consumers (via S/RUSTSRC) reference a single shared source tree.
diff --git a/recipes-devtools/rust/rust-source_1.97.1.bb b/recipes-devtools=
/rust/rust-source_1.98.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-source_1.97.1.bb
rename to recipes-devtools/rust/rust-source_1.98.0.bb
diff --git a/recipes-devtools/rust/rust_1.97.1.bb b/recipes-devtools/rust/r=
ust_1.98.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.97.1.bb
rename to recipes-devtools/rust/rust_1.98.0.bb
--=20
2.55.0


