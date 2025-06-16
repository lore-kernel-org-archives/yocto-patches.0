Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66714C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 07:51:02 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Sakai, Osaka, JP (14.10.72.34)
X-Originating-Platform: Windows Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 16 Jun 2025 00:50:53 -0700
References: <13355.1749788690158478865@lists.yoctoproject.org>
In-Reply-To: <13355.1749788690158478865@lists.yoctoproject.org>
Message-ID: <13137.1750060253705028741@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="7wbUvTnKuPb6xOuhP5YT"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Jun 2025 07:51:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1647

--7wbUvTnKuPb6xOuhP5YT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I continue my investigation and analyse the log.

I read that :

| =C2=A0 [INFO] `x install` now skips providing tarball sources (under 'bui=
ld/dist' path) to speed up the installation process.
| =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/118724

Following the link, I read this message :

With a link to this commit :
https://github.com/rust-lang/rust/commit/a13ec8d00396ac6f5a3f285f8fcd95a2ab=
6c8824

And if we go to the parent :
https://github.com/rust-lang/rust/commit/94597e85cfd2df40b467f087a12c8f7278=
13b947

>=20
> I think this is this parent commit that produce my error. I can see in th=
e
> log file :
> yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/temp/log.do_install=
.26776
>=20
>=20
> This lines :
>=20
> running: cd
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85=
.1-src"
> && env -u MAKEFLAGS -u MFLAGS CARGO_INCREMENTAL=3D"0"
> CARGO_LOG=3D"cargo::core::compiler::fingerprint=3Dinfo"
> CARGO_PROFILE_RELEASE_DEBUG=3D"0"
> CARGO_PROFILE_RELEASE_DEBUG_ASSERTIONS=3D"false"
> CARGO_PROFILE_RELEASE_OVERFLOW_CHECKS=3D"false"
> CARGO_PROFILE_RELEASE_STRIP=3D"false"
> CARGO_TARGET_DIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1=
.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage0-bootstrap-t=
ools"
> CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=3D""
> CC_x86_64_unknown_linux_gnu=3D""
> CFG_COMPILER_BUILD_TRIPLE=3D"x86_64-unknown-linux-gnu"
> CFG_COMPILER_HOST_TRIPLE=3D"x86_64-unknown-linux-gnu" CFG_RELEASE=3D"1.85=
.1"
> CFG_RELEASE_CHANNEL=3D"stable" CFG_RELEASE_NUM=3D"1.85.1" CFG_VERSION=3D"=
1.85.1
> (4eb161250 2025-03-15) (built from a source tarball)"
> CFG_VER_DATE=3D"2025-03-15"
> CFG_VER_HASH=3D"4eb161250e340c8f48f66e2b929ef4a5bed7c181"
> CFG_VIRTUAL_RUST_SOURCE_BASE_DIR=3D"/rustc/4eb161250e340c8f48f66e2b929ef4=
a5bed7c181"
> CFLAGS_x86_64_unknown_linux_gnu=3D"" CXXFLAGS_x86_64_unknown_linux_gnu=3D=
""
> CXX_x86_64_unknown_linux_gnu=3D""
> DOC_RUST_LANG_ORG_CHANNEL=3D"https://doc.rust-lang.org/1.85.1"
> FORCE_ON_BROKEN_PIPE_KILL=3D"-Zon-broken-pipe=3Dkill" LIBC_CHECK_CFG=3D"1=
"
> LZMA_API_STATIC=3D"1"
> REAL_LIBRARY_PATH=3D"/source/yocto/build/tmp/sysroots-components/x86_64/p=
seudo-native/usr/lib/pseudo/lib:/source/yocto/build/tmp/sysroots-components=
/x86_64/pseudo-native/usr/lib/pseudo/lib64"
> REAL_LIBRARY_PATH_VAR=3D"LD_LIBRARY_PATH"
> RUSTBUILD_NATIVE_DIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/ru=
st/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/native"
> RUSTC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/ru=
stc-1.85.1-src/build/bootstrap/debug/rustc"
> RUSTC_ALLOW_FEATURES=3D"binary-dep-depinfo,proc_macro_span,proc_macro_spa=
n_shrink,proc_macro_diagnostic"
> RUSTC_BOOTSTRAP=3D"1" RUSTC_BREAK_ON_ICE=3D"1"
> RUSTC_CARGO_REGISTRY_SRC_TO_REMAP=3D"/source/yocto/build/tmp/work/armv8a-=
poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/vendor=3D/rust/deps"
> RUSTC_DEBUGINFO_MAP=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rus=
t/1.85.1-r0/rustc-1.85.1-src=3D/rustc/4eb161250e340c8f48f66e2b929ef4a5bed7c=
181"
> RUSTC_ERROR_METADATA_DST=3D"/source/yocto/build/tmp/work/armv8a-poky-linu=
x/rust/1.85.1-r0/rustc-1.85.1-src/build/tmp/extended-error-metadata"
> RUSTC_HOST_FLAGS=3D"-Zunstable-options --check-cfg=3Dcfg(bootstrap)
> --check-cfg=3Dcfg(test) -Clinker=3D" RUSTC_INSTALL_BINDIR=3D"bin"
> RUSTC_LIBDIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.=
1-r0/recipe-sysroot-native/usr/lib"
> RUSTC_LINK_STD_INTO_RUSTC_DRIVER=3D"1" RUSTC_LINT_FLAGS=3D"-Wrust_2018_id=
ioms
> -Wunused_lifetimes -Dwarnings"
> RUSTC_REAL=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/recipe-sysroot-native/usr/bin/rustc"
> RUSTC_SNAPSHOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.8=
5.1-r0/recipe-sysroot-native/usr/bin/rustc"
> RUSTC_SNAPSHOT_LIBDIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/r=
ust/1.85.1-r0/recipe-sysroot-native/usr/lib"
> RUSTC_STAGE=3D"1"
> RUSTC_SYSROOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85=
.1-r0/recipe-sysroot-native/usr"
> RUSTC_TLS_MODEL_INITIAL_EXEC=3D"1" RUSTC_VERBOSE=3D"1"
> RUSTC_WRAPPER=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85=
.1-r0/rustc-1.85.1-src/build/bootstrap/debug/rustc"
> RUSTDOC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/=
rustc-1.85.1-src/build/bootstrap/debug/rustdoc"
> RUSTDOCFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a=
-poky-linux/rust/1.85.1-r0=3D
> -Csymbol-mangling-version=3Dv0 -Zunstable-options --check-cfg=3Dcfg(boots=
trap)
> --check-cfg=3Dcfg(test) -Dwarnings -Wrustdoc::invalid_codeblock_attribute=
s
> --crate-version
> 1.85.1\t(4eb161250\t2025-03-15)\t(built\tfrom\ta\tsource\ttarball)
> -Clinker=3D" RUSTDOC_REAL=3D"/path/to/nowhere/rustdoc/not/required"
> RUSTFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a-po=
ky-linux/rust/1.85.1-r0=3D
> -Csymbol-mangling-version=3Dv0 -Zunstable-options --check-cfg=3Dcfg(boots=
trap)
> --check-cfg=3Dcfg(test) -Zmacro-backtrace -Csplit-debuginfo=3Doff
> -Clink-args=3D-Wl,-z,origin -Clink-args=3D-Wl,-rpath,$ORIGIN/../lib
> -Zunstable-options" RUST_TEST_THREADS=3D"8"
> SYSROOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/=
rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage0-sysroot"
> __CARGO_DEFAULT_LIB_METADATA=3D"bootstrap"
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/recipe-sys=
root-native/usr/bin/cargo"
> "build" "--target" "x86_64-unknown-linux-gnu" "--release"
> "-Zbinary-dep-depinfo" "-j" "8"
> "-Zroot-dir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/rustc-1.85.1-src"
> "-v" "--frozen" "--manifest-path"
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85=
.1-src/src/tools/rust-installer/Cargo.toml"
> "--message-format" "json-render-diagnostics"
> Forcing dist.compression-profile =3D 'no-op' for `x install`.
> Removing sysroot
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.=
1-src/build/aarch64-poky-linux-gnu/stage2
> to avoid caching bugs
> running: cd
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85=
.1-src"
> && env -u MAKEFLAGS -u MFLAGS CARGO_INCREMENTAL=3D"0"
> CARGO_LOG=3D"cargo::core::compiler::fingerprint=3Dinfo"
> CARGO_PROFILE_RELEASE_DEBUG=3D"0"
> CARGO_PROFILE_RELEASE_DEBUG_ASSERTIONS=3D"false"
> CARGO_PROFILE_RELEASE_OVERFLOW_CHECKS=3D"false"
> CARGO_PROFILE_RELEASE_STRIP=3D"false"
> CARGO_TARGET_AARCH64_POKY_LINUX_GNU_LINKER=3D""
> CARGO_TARGET_DIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1=
.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1-rustc"
> CC_aarch64_poky_linux_gnu=3D""
> CFG_COMPILER_BUILD_TRIPLE=3D"x86_64-unknown-linux-gnu"
> CFG_COMPILER_HOST_TRIPLE=3D"aarch64-poky-linux-gnu"
> CFG_DEFAULT_CODEGEN_BACKEND=3D"llvm" CFG_DISABLE_UNSTABLE_FEATURES=3D"1"
> CFG_LIBDIR_RELATIVE=3D"lib" CFG_RELEASE=3D"1.85.1"
> CFG_RELEASE_CHANNEL=3D"stable" CFG_VERSION=3D"1.85.1 (4eb161250 2025-03-1=
5)
> (built from a source tarball)" CFG_VER_DATE=3D"2025-03-15"
> CFG_VER_HASH=3D"4eb161250e340c8f48f66e2b929ef4a5bed7c181"
> CFG_VIRTUAL_RUST_SOURCE_BASE_DIR=3D"/rustc/4eb161250e340c8f48f66e2b929ef4=
a5bed7c181"
> CFLAGS_aarch64_poky_linux_gnu=3D"" CXXFLAGS_aarch64_poky_linux_gnu=3D""
> CXX_aarch64_poky_linux_gnu=3D"" LIBC_CHECK_CFG=3D"1"
> LLVM_CONFIG=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1=
-r0/recipe-sysroot/usr/lib/llvm-rust/bin/llvm-config"
> REAL_LIBRARY_PATH=3D"/source/yocto/build/tmp/sysroots-components/x86_64/p=
seudo-native/usr/lib/pseudo/lib:/source/yocto/build/tmp/sysroots-components=
/x86_64/pseudo-native/usr/lib/pseudo/lib64"
> REAL_LIBRARY_PATH_VAR=3D"LD_LIBRARY_PATH"
> RUSTBUILD_NATIVE_DIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/ru=
st/1.85.1-r0/rustc-1.85.1-src/build/aarch64-poky-linux-gnu/native"
> RUSTC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/ru=
stc-1.85.1-src/build/bootstrap/debug/rustc"
> RUSTC_BOOTSTRAP=3D"1" RUSTC_BREAK_ON_ICE=3D"1"
> RUSTC_CARGO_REGISTRY_SRC_TO_REMAP=3D"/source/yocto/build/tmp/work/armv8a-=
poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/vendor=3D/rust/deps"
> RUSTC_DEBUGINFO_MAP=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rus=
t/1.85.1-r0/rustc-1.85.1-src=3D/rustc/4eb161250e340c8f48f66e2b929ef4a5bed7c=
181"
> RUSTC_ERROR_METADATA_DST=3D"/source/yocto/build/tmp/work/armv8a-poky-linu=
x/rust/1.85.1-r0/rustc-1.85.1-src/build/tmp/extended-error-metadata"
> RUSTC_FORCE_UNSTABLE=3D"1" RUSTC_HOST_FLAGS=3D"-Zunstable-options
> --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test) -Clinker=3D"
> RUSTC_INSTALL_BINDIR=3D"bin"
> RUSTC_LIBDIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.=
1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1/lib"
> RUSTC_LINK_STD_INTO_RUSTC_DRIVER=3D"1" RUSTC_LINT_FLAGS=3D"-Wrust_2018_id=
ioms
> -Wunused_lifetimes -Dwarnings"
> RUSTC_REAL=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1/bin/rustc"
> RUSTC_SNAPSHOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.8=
5.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1/bin/rustc"
> RUSTC_SNAPSHOT_LIBDIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/r=
ust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1/lib"
> RUSTC_STAGE=3D"1"
> RUSTC_SYSROOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85=
.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1"
> RUSTC_TLS_MODEL_INITIAL_EXEC=3D"1" RUSTC_VERBOSE=3D"1"
> RUSTC_WRAPPER=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85=
.1-r0/rustc-1.85.1-src/build/bootstrap/debug/rustc"
> RUSTDOC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/=
rustc-1.85.1-src/build/bootstrap/debug/rustdoc"
> RUSTDOCFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a=
-poky-linux/rust/1.85.1-r0=3D
> --cfg=3Dwindows_raw_dylib -Csymbol-mangling-version=3Dv0 -Zunstable-optio=
ns
> --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test)
> --check-cfg=3Dcfg(llvm_enzyme) -Dwarnings
> -Wrustdoc::invalid_codeblock_attributes --crate-version
> 1.85.1\t(4eb161250\t2025-03-15)\t(built\tfrom\ta\tsource\ttarball)
> -Clinker=3D -Zcrate-attr=3Dwarn(rust_2018_idioms)"
> RUSTDOC_REAL=3D"/path/to/nowhere/rustdoc/not/required"
> RUSTFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a-po=
ky-linux/rust/1.85.1-r0=3D
> --cfg=3Dwindows_raw_dylib -Csymbol-mangling-version=3Dv0 -Zunstable-optio=
ns
> --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test)
> --check-cfg=3Dcfg(llvm_enzyme) -Zdual-proc-macros -Zmacro-backtrace
> -Csplit-debuginfo=3Doff -Wrustc::internal
> -Drustc::symbol_intern_string_literal -Wkeyword_idents_2024
> -Wunsafe_op_in_unsafe_fn -Cprefer-dynamic -Clink-args=3D-Wl,-z,origin
> -Clink-args=3D-Wl,-rpath,$ORIGIN/../lib -Zon-broken-pipe=3Dkill"
> RUST_TEST_THREADS=3D"8" WINAPI_NO_BUNDLED_LIBRARIES=3D"1"
> __CARGO_DEFAULT_LIB_METADATA=3D"stable"
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/recipe-sys=
root-native/usr/bin/cargo"
> "build" "--target" "aarch64-poky-linux-gnu" "--release"
> "-Zdual-proc-macros" "-Zbinary-dep-depinfo" "-j" "8"
> "-Zroot-dir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/rustc-1.85.1-src"
> "-v" "--frozen" "--features" "llvm max_level_info" "--manifest-path"
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85=
.1-src/compiler/rustc/Cargo.toml"
> "--message-format" "json-render-diagnostics"
> Forcing dist.compression-profile =3D 'no-op' for `x install`.
> Removing sysroot
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.=
1-src/build/x86_64-unknown-linux-gnu/stage2
> to avoid caching bugs
>=20

In this log, I can read the line : "Forcing dist.compression-profile =3D 'n=
o-op' for `x install`."

I think this is because of this line I encounter my problem.

I don't really know what is the new x.py command to prepare this tar.xz.

Comparing the meta-lts-mixins recipe with the one from meta-rust (1.86.0), =
I see that they do this :

>=20
> do_compile () {
> rust_runx build --stage 2
> }
>=20

>=20
> rust_do_install() {
> rust_runx install
> }
>=20

So I try to add the same line in rust_1.85.1.bb :

>=20
> do_compile () {
> rust_runx build --stage 2
> }
>=20

Without changement int the output log. The tar.xz is never find.

If this source.tar.xz file is not necessary, how can I skip un untar proced=
ure in the Yocto build ?Where I have to investigate to try to fix this prob=
lem ?

What way you advise me to investigate ?

Maxime.

Maxime.

--7wbUvTnKuPb6xOuhP5YT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I continue my investigation and analyse the log.</div>
<div>&nbsp;</div>
<div>I read that :<br /><br />| &nbsp; [INFO] `x install` now skips providi=
ng tarball sources (under 'build/dist' path) to speed up the installation p=
rocess.<br />| &nbsp; &nbsp; - PR Link <a href=3D"https://github.com/rust-l=
ang/rust/pull/118724" target=3D"_blank" rel=3D"noopener">https://github.com=
/rust-lang/rust/pull/118724</a><br /><br />Following the link, I read this =
message :</div>
<div>&nbsp;</div>
<div>With a link to this commit :<br /><a href=3D"https://github.com/rust-l=
ang/rust/commit/a13ec8d00396ac6f5a3f285f8fcd95a2ab6c8824" target=3D"_blank"=
 rel=3D"noopener">https://github.com/rust-lang/rust/commit/a13ec8d00396ac6f=
5a3f285f8fcd95a2ab6c8824</a></div>
<div>&nbsp;</div>
<div>And if we go to the parent :</div>
<div><a href=3D"https://github.com/rust-lang/rust/commit/94597e85cfd2df40b4=
67f087a12c8f727813b947" target=3D"_blank" rel=3D"noopener">https://github.c=
om/rust-lang/rust/commit/94597e85cfd2df40b467f087a12c8f727813b947</a></div>
<div>&nbsp;</div>
<blockquote>
<div>I think this is this parent commit that produce my error. I can see in=
 the log file : yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/temp/=
log.do_install.26776<br /><br />This lines :<br /><br />running: cd "/sourc=
e/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src" &=
amp;&amp; env -u MAKEFLAGS -u MFLAGS CARGO_INCREMENTAL=3D"0" CARGO_LOG=3D"c=
argo::core::compiler::fingerprint=3Dinfo" CARGO_PROFILE_RELEASE_DEBUG=3D"0"=
 CARGO_PROFILE_RELEASE_DEBUG_ASSERTIONS=3D"false" CARGO_PROFILE_RELEASE_OVE=
RFLOW_CHECKS=3D"false" CARGO_PROFILE_RELEASE_STRIP=3D"false" CARGO_TARGET_D=
IR=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1=
.85.1-src/build/x86_64-unknown-linux-gnu/stage0-bootstrap-tools" CARGO_TARG=
ET_X86_64_UNKNOWN_LINUX_GNU_LINKER=3D"" CC_x86_64_unknown_linux_gnu=3D"" CF=
G_COMPILER_BUILD_TRIPLE=3D"x86_64-unknown-linux-gnu" CFG_COMPILER_HOST_TRIP=
LE=3D"x86_64-unknown-linux-gnu" CFG_RELEASE=3D"1.85.1" CFG_RELEASE_CHANNEL=
=3D"stable" CFG_RELEASE_NUM=3D"1.85.1" CFG_VERSION=3D"1.85.1 (4eb161250 202=
5-03-15) (built from a source tarball)" CFG_VER_DATE=3D"2025-03-15" CFG_VER=
_HASH=3D"4eb161250e340c8f48f66e2b929ef4a5bed7c181" CFG_VIRTUAL_RUST_SOURCE_=
BASE_DIR=3D"/rustc/4eb161250e340c8f48f66e2b929ef4a5bed7c181" CFLAGS_x86_64_=
unknown_linux_gnu=3D"" CXXFLAGS_x86_64_unknown_linux_gnu=3D"" CXX_x86_64_un=
known_linux_gnu=3D"" DOC_RUST_LANG_ORG_CHANNEL=3D"https://doc.rust-lang.org=
/1.85.1" FORCE_ON_BROKEN_PIPE_KILL=3D"-Zon-broken-pipe=3Dkill" LIBC_CHECK_C=
FG=3D"1" LZMA_API_STATIC=3D"1" REAL_LIBRARY_PATH=3D"/source/yocto/build/tmp=
/sysroots-components/x86_64/pseudo-native/usr/lib/pseudo/lib:/source/yocto/=
build/tmp/sysroots-components/x86_64/pseudo-native/usr/lib/pseudo/lib64" RE=
AL_LIBRARY_PATH_VAR=3D"LD_LIBRARY_PATH" RUSTBUILD_NATIVE_DIR=3D"/source/yoc=
to/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x=
86_64-unknown-linux-gnu/native" RUSTC=3D"/source/yocto/build/tmp/work/armv8=
a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/bootstrap/debug/rustc" R=
USTC_ALLOW_FEATURES=3D"binary-dep-depinfo,proc_macro_span,proc_macro_span_s=
hrink,proc_macro_diagnostic" RUSTC_BOOTSTRAP=3D"1" RUSTC_BREAK_ON_ICE=3D"1"=
 RUSTC_CARGO_REGISTRY_SRC_TO_REMAP=3D"/source/yocto/build/tmp/work/armv8a-p=
oky-linux/rust/1.85.1-r0/rustc-1.85.1-src/vendor=3D/rust/deps" RUSTC_DEBUGI=
NFO_MAP=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/ru=
stc-1.85.1-src=3D/rustc/4eb161250e340c8f48f66e2b929ef4a5bed7c181" RUSTC_ERR=
OR_METADATA_DST=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85=
.1-r0/rustc-1.85.1-src/build/tmp/extended-error-metadata" RUSTC_HOST_FLAGS=
=3D"-Zunstable-options --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test)=
 -Clinker=3D" RUSTC_INSTALL_BINDIR=3D"bin" RUSTC_LIBDIR=3D"/source/yocto/bu=
ild/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/recipe-sysroot-native/usr/lib=
" RUSTC_LINK_STD_INTO_RUSTC_DRIVER=3D"1" RUSTC_LINT_FLAGS=3D"-Wrust_2018_id=
ioms -Wunused_lifetimes -Dwarnings" RUSTC_REAL=3D"/source/yocto/build/tmp/w=
ork/armv8a-poky-linux/rust/1.85.1-r0/recipe-sysroot-native/usr/bin/rustc" R=
USTC_SNAPSHOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1=
-r0/recipe-sysroot-native/usr/bin/rustc" RUSTC_SNAPSHOT_LIBDIR=3D"/source/y=
octo/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/recipe-sysroot-native/=
usr/lib" RUSTC_STAGE=3D"1" RUSTC_SYSROOT=3D"/source/yocto/build/tmp/work/ar=
mv8a-poky-linux/rust/1.85.1-r0/recipe-sysroot-native/usr" RUSTC_TLS_MODEL_I=
NITIAL_EXEC=3D"1" RUSTC_VERBOSE=3D"1" RUSTC_WRAPPER=3D"/source/yocto/build/=
tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/bootstrap/=
debug/rustc" RUSTDOC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust=
/1.85.1-r0/rustc-1.85.1-src/build/bootstrap/debug/rustdoc" RUSTDOCFLAGS=3D"=
--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1=
.85.1-r0=3D -Csymbol-mangling-version=3Dv0 -Zunstable-options --check-cfg=
=3Dcfg(bootstrap) --check-cfg=3Dcfg(test) -Dwarnings -Wrustdoc::invalid_cod=
eblock_attributes --crate-version 1.85.1\t(4eb161250\t2025-03-15)\t(built\t=
from\ta\tsource\ttarball) -Clinker=3D" RUSTDOC_REAL=3D"/path/to/nowhere/rus=
tdoc/not/required" RUSTFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/t=
mp/work/armv8a-poky-linux/rust/1.85.1-r0=3D -Csymbol-mangling-version=3Dv0 =
-Zunstable-options --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test) -Zm=
acro-backtrace -Csplit-debuginfo=3Doff -Clink-args=3D-Wl,-z,origin -Clink-a=
rgs=3D-Wl,-rpath,$ORIGIN/../lib -Zunstable-options" RUST_TEST_THREADS=3D"8"=
 SYSROOT=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/r=
ustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage0-sysroot" __CARGO_DEFA=
ULT_LIB_METADATA=3D"bootstrap" "/source/yocto/build/tmp/work/armv8a-poky-li=
nux/rust/1.85.1-r0/recipe-sysroot-native/usr/bin/cargo" "build" "--target" =
"x86_64-unknown-linux-gnu" "--release" "-Zbinary-dep-depinfo" "-j" "8" "-Zr=
oot-dir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rus=
tc-1.85.1-src" "-v" "--frozen" "--manifest-path" "/source/yocto/build/tmp/w=
ork/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/src/tools/rust-instal=
ler/Cargo.toml" "--message-format" "json-render-diagnostics"<br />Forcing d=
ist.compression-profile =3D 'no-op' for `x install`.<br />Removing sysroot =
/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-=
src/build/aarch64-poky-linux-gnu/stage2 to avoid caching bugs<br />running:=
 cd "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.=
85.1-src" &amp;&amp; env -u MAKEFLAGS -u MFLAGS CARGO_INCREMENTAL=3D"0" CAR=
GO_LOG=3D"cargo::core::compiler::fingerprint=3Dinfo" CARGO_PROFILE_RELEASE_=
DEBUG=3D"0" CARGO_PROFILE_RELEASE_DEBUG_ASSERTIONS=3D"false" CARGO_PROFILE_=
RELEASE_OVERFLOW_CHECKS=3D"false" CARGO_PROFILE_RELEASE_STRIP=3D"false" CAR=
GO_TARGET_AARCH64_POKY_LINUX_GNU_LINKER=3D"" CARGO_TARGET_DIR=3D"/source/yo=
cto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/=
x86_64-unknown-linux-gnu/stage1-rustc" CC_aarch64_poky_linux_gnu=3D"" CFG_C=
OMPILER_BUILD_TRIPLE=3D"x86_64-unknown-linux-gnu" CFG_COMPILER_HOST_TRIPLE=
=3D"aarch64-poky-linux-gnu" CFG_DEFAULT_CODEGEN_BACKEND=3D"llvm" CFG_DISABL=
E_UNSTABLE_FEATURES=3D"1" CFG_LIBDIR_RELATIVE=3D"lib" CFG_RELEASE=3D"1.85.1=
" CFG_RELEASE_CHANNEL=3D"stable" CFG_VERSION=3D"1.85.1 (4eb161250 2025-03-1=
5) (built from a source tarball)" CFG_VER_DATE=3D"2025-03-15" CFG_VER_HASH=
=3D"4eb161250e340c8f48f66e2b929ef4a5bed7c181" CFG_VIRTUAL_RUST_SOURCE_BASE_=
DIR=3D"/rustc/4eb161250e340c8f48f66e2b929ef4a5bed7c181" CFLAGS_aarch64_poky=
_linux_gnu=3D"" CXXFLAGS_aarch64_poky_linux_gnu=3D"" CXX_aarch64_poky_linux=
_gnu=3D"" LIBC_CHECK_CFG=3D"1" LLVM_CONFIG=3D"/source/yocto/build/tmp/work/=
armv8a-poky-linux/rust/1.85.1-r0/recipe-sysroot/usr/lib/llvm-rust/bin/llvm-=
config" REAL_LIBRARY_PATH=3D"/source/yocto/build/tmp/sysroots-components/x8=
6_64/pseudo-native/usr/lib/pseudo/lib:/source/yocto/build/tmp/sysroots-comp=
onents/x86_64/pseudo-native/usr/lib/pseudo/lib64" REAL_LIBRARY_PATH_VAR=3D"=
LD_LIBRARY_PATH" RUSTBUILD_NATIVE_DIR=3D"/source/yocto/build/tmp/work/armv8=
a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/aarch64-poky-linux-gnu/n=
ative" RUSTC=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/rustc-1.85.1-src/build/bootstrap/debug/rustc" RUSTC_BOOTSTRAP=3D"1" RUST=
C_BREAK_ON_ICE=3D"1" RUSTC_CARGO_REGISTRY_SRC_TO_REMAP=3D"/source/yocto/bui=
ld/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/vendor=3D/rus=
t/deps" RUSTC_DEBUGINFO_MAP=3D"/source/yocto/build/tmp/work/armv8a-poky-lin=
ux/rust/1.85.1-r0/rustc-1.85.1-src=3D/rustc/4eb161250e340c8f48f66e2b929ef4a=
5bed7c181" RUSTC_ERROR_METADATA_DST=3D"/source/yocto/build/tmp/work/armv8a-=
poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/tmp/extended-error-metadat=
a" RUSTC_FORCE_UNSTABLE=3D"1" RUSTC_HOST_FLAGS=3D"-Zunstable-options --chec=
k-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg(test) -Clinker=3D" RUSTC_INSTALL_B=
INDIR=3D"bin" RUSTC_LIBDIR=3D"/source/yocto/build/tmp/work/armv8a-poky-linu=
x/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linux-gnu/stage1/lib=
" RUSTC_LINK_STD_INTO_RUSTC_DRIVER=3D"1" RUSTC_LINT_FLAGS=3D"-Wrust_2018_id=
ioms -Wunused_lifetimes -Dwarnings" RUSTC_REAL=3D"/source/yocto/build/tmp/w=
ork/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-=
linux-gnu/stage1/bin/rustc" RUSTC_SNAPSHOT=3D"/source/yocto/build/tmp/work/=
armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-linu=
x-gnu/stage1/bin/rustc" RUSTC_SNAPSHOT_LIBDIR=3D"/source/yocto/build/tmp/wo=
rk/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-l=
inux-gnu/stage1/lib" RUSTC_STAGE=3D"1" RUSTC_SYSROOT=3D"/source/yocto/build=
/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-un=
known-linux-gnu/stage1" RUSTC_TLS_MODEL_INITIAL_EXEC=3D"1" RUSTC_VERBOSE=3D=
"1" RUSTC_WRAPPER=3D"/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.=
85.1-r0/rustc-1.85.1-src/build/bootstrap/debug/rustc" RUSTDOC=3D"/source/yo=
cto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/=
bootstrap/debug/rustdoc" RUSTDOCFLAGS=3D"--remap-path-prefix=3D/source/yoct=
o/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0=3D --cfg=3Dwindows_raw_dy=
lib -Csymbol-mangling-version=3Dv0 -Zunstable-options --check-cfg=3Dcfg(boo=
tstrap) --check-cfg=3Dcfg(test) --check-cfg=3Dcfg(llvm_enzyme) -Dwarnings -=
Wrustdoc::invalid_codeblock_attributes --crate-version 1.85.1\t(4eb161250\t=
2025-03-15)\t(built\tfrom\ta\tsource\ttarball) -Clinker=3D -Zcrate-attr=3Dw=
arn(rust_2018_idioms)" RUSTDOC_REAL=3D"/path/to/nowhere/rustdoc/not/require=
d" RUSTFLAGS=3D"--remap-path-prefix=3D/source/yocto/build/tmp/work/armv8a-p=
oky-linux/rust/1.85.1-r0=3D --cfg=3Dwindows_raw_dylib -Csymbol-mangling-ver=
sion=3Dv0 -Zunstable-options --check-cfg=3Dcfg(bootstrap) --check-cfg=3Dcfg=
(test) --check-cfg=3Dcfg(llvm_enzyme) -Zdual-proc-macros -Zmacro-backtrace =
-Csplit-debuginfo=3Doff -Wrustc::internal -Drustc::symbol_intern_string_lit=
eral -Wkeyword_idents_2024 -Wunsafe_op_in_unsafe_fn -Cprefer-dynamic -Clink=
-args=3D-Wl,-z,origin -Clink-args=3D-Wl,-rpath,$ORIGIN/../lib -Zon-broken-p=
ipe=3Dkill" RUST_TEST_THREADS=3D"8" WINAPI_NO_BUNDLED_LIBRARIES=3D"1" __CAR=
GO_DEFAULT_LIB_METADATA=3D"stable" "/source/yocto/build/tmp/work/armv8a-pok=
y-linux/rust/1.85.1-r0/recipe-sysroot-native/usr/bin/cargo" "build" "--targ=
et" "aarch64-poky-linux-gnu" "--release" "-Zdual-proc-macros" "-Zbinary-dep=
-depinfo" "-j" "8" "-Zroot-dir=3D/source/yocto/build/tmp/work/armv8a-poky-l=
inux/rust/1.85.1-r0/rustc-1.85.1-src" "-v" "--frozen" "--features" "llvm ma=
x_level_info" "--manifest-path" "/source/yocto/build/tmp/work/armv8a-poky-l=
inux/rust/1.85.1-r0/rustc-1.85.1-src/compiler/rustc/Cargo.toml" "--message-=
format" "json-render-diagnostics"<br />Forcing dist.compression-profile =3D=
 'no-op' for `x install`.<br />Removing sysroot /source/yocto/build/tmp/wor=
k/armv8a-poky-linux/rust/1.85.1-r0/rustc-1.85.1-src/build/x86_64-unknown-li=
nux-gnu/stage2 to avoid caching bugs</div>
</blockquote>
<div>&nbsp;</div>
<div>In this log, I can read the line : "Forcing dist.compression-profile =
=3D 'no-op' for `x install`."</div>
<div>&nbsp;</div>
<div>I think this is because of this line I encounter my problem.</div>
<div>&nbsp;</div>
<div>I don't really know what is the new x.py command to prepare this tar.x=
z.<br /><br />Comparing the meta-lts-mixins recipe with the one from meta-r=
ust (1.86.0), I see that they do this :</div>
<blockquote>
<div>do_compile () {<br />&nbsp; &nbsp; rust_runx build --stage 2<br />}</d=
iv>
</blockquote>
<blockquote>
<div>rust_do_install() {<br />&nbsp; &nbsp; rust_runx install<br />}</div>
</blockquote>
<div>So I try to add the same line in rust_1.85.1.bb :</div>
<blockquote>
<div>do_compile () {<br />&nbsp; &nbsp; rust_runx build --stage 2<br />}</d=
iv>
</blockquote>
<div>&nbsp;</div>
<div>Without changement int the output log. The tar.xz is never find.<br />=
<br />If this source.tar.xz file is not necessary, how can I skip un untar =
procedure in the Yocto build ?Where I have to investigate to try to fix thi=
s problem ?<br /><br />What way you advise me to investigate ?</div>
<div>&nbsp;</div>
<div>Maxime.<br /><br />Maxime.</div>
<div>&nbsp;</div>

--7wbUvTnKuPb6xOuhP5YT--

