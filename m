Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A5C61CE7
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 13:09:18 +0000 (UTC)
Subject: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Sakai, Osaka, JP (14.10.72.34)
X-Originating-Platform: Windows Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 06:09:13 -0700
Message-ID: <szGz.1749647353353443131.4PnY@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="ixZQ2vT6dvpIRJIK7zSs"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 13:09:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1633

--ixZQ2vT6dvpIRJIK7zSs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm new with Yocto project and I'm trying to update for a project Rust for =
a Tinker Board from Asus that use meta-lts-mixins. Repo is fork here : http=
s://github.com/TinkerBoard-Linux/rockchip-linux-yocto-meta-lts-mixins

I check it from the official repository and they change nothing.

Basically, their version is using Rust 1.75.0 and I succeed to build their =
project with Rust 1.76.0 by changing the head patch of the meta-lts-mixins.

I'm trying to build on the Rust version I need which are Rust 1.80.0.

After a try from a clean environment, I get this error :

>=20
> | Installing stage2 rustfmt (aarch64-poky-linux-gnu)
> | running: BootstrapCommand { command: cd
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/rustc-1.80=
.0-src/build/tmp/empty_dir"
> && "sh"
> "/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/rustc-1.80=
.0-src/build/tmp/tarball/rustfmt/aarch64-poky-linux-gnu/rustfmt-1.80.0-aarc=
h64-poky-linux-gnu/install.sh"
> "--prefix=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0=
/image/usr"
> "--sysconfdir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.=
0-r0/image/etc"
> "--datadir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r=
0/image/usr/share"
> "--docdir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0=
/image/usr/share/doc/rustfmt"
> "--bindir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0=
/image/usr/bin"
> "--libdir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0=
/image/usr/lib"
> "--mandir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0=
/image/usr/share/man"
> "--disable-ldconfig", failure_behavior: Exit, output_mode: PrintAll }
> | install: creating uninstall script at
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/l=
ib/rustlib/uninstall.sh
>=20
> | install: installing component 'rustfmt-preview'
> |
> | =C2=A0 =C2=A0 rustfmt installed.
> |
> | There have been changes to x.py since you last updated:
> | =C2=A0 [INFO] Use of the `if-available` value for `download-ci-llvm` is
> deprecated; prefer using the new `if-unchanged` value.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/117813
> | =C2=A0 [INFO] The `rust.use-lld` configuration now has different option=
s
> ('external'/true or 'self-contained'), and its behaviour has changed.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/116278
> | =C2=A0 [INFO] Removed rust.run_dsymutil and dist.gpg_password_file conf=
ig
> options, as they were unused.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/118703
> | =C2=A0 [WARNING] rust-analyzer-proc-macro-srv is no longer enabled by
> default. To build it, you must either enable it in the configuration or
> explicitly invoke it with x.py.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/119124
> | =C2=A0 [INFO] The dist.missing-tools config option was deprecated, as i=
t was
> unused. If you are using it, remove it from your config, it will be
> removed soon.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/119373
> | =C2=A0 [WARNING] A new `optimized-compiler-builtins` option has been
> introduced. Whether to build llvm's `compiler-rt` from source is no longe=
r
> implicitly controlled by git state. See the PR for more details.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/102579
> | =C2=A0 [INFO] New option `target.<triple>.codegen-backends` added to
> config.toml.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/120348
> | =C2=A0 [INFO] A new `rust.frame-pointers` option has been introduced an=
d made
> the default in the compiler and codegen profiles.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/121203
> | =C2=A0 [WARNING] The "codegen"/"llvm" profile has been removed and repl=
aced
> with "compiler", use it instead for the same behavior.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/121278
> | =C2=A0 [INFO] `x install` now skips providing tarball sources (under
> 'build/dist' path) to speed up the installation process.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/118724
> | =C2=A0 [INFO] A new `boostrap-cache-path` option has been introduced wh=
ich
> can be utilized to modify the cache path for bootstrap.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/121976
> | =C2=A0 [INFO] a new `target.*.runner` option is available to specify a
> wrapper executable required to run tests for a target
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/122108
> | =C2=A0 [INFO] New option `rust.llvm-bitcode-linker` that will build the
> llvm-bitcode-linker.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/117458
> | =C2=A0 [WARNING] `rust.split-debuginfo` has been moved to
> `target.<triple>.split-debuginfo` and its default value is determined for
> each target individually.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/121754
> | =C2=A0 [WARNING] The deprecated field `changelog-seen` has been removed=
.
> Using that field in `config.toml` from now on will result in breakage.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/123711
> | =C2=A0 [INFO] New option `build.lldb` that will override the default ll=
db
> binary path used in debuginfo tests
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/124501
> | =C2=A0 [INFO] The compiler profile now defaults to rust.debuginfo-level=
 =3D
> "line-tables-only"
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/123337
> | =C2=A0 [WARNING] `rust.lld` has a new default value of `true` on
> `x86_64-unknown-linux-gnu`. Starting at stage1, `rust-lld` will thus be
> this target's default linker. No config changes should be necessary.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/124129
> | =C2=A0 [WARNING] Removed `dist.missing-tools` configuration as it was
> deprecated long time ago.
> | =C2=A0 =C2=A0 - PR Link https://github.com/rust-lang/rust/pull/125535
> | NOTE: to silence this warning, update `config.toml` to use `change-id =
=3D
> 125535` instead
> | NOTE: this message was printed twice to make it more likely to be seen
> | Build completed successfully in 0:00:07
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/cargo-clippy:
> RPATH=3D$ORIGIN/../lib
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/cargo-clippy:
> new RPATH: $ORIGIN/../lib
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/clippy-driver:
> RPATH=3D$ORIGIN/../lib
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/clippy-driver:
> new RPATH: $ORIGIN/../lib
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/rustfmt:
> RPATH=3D$ORIGIN/../lib
> |
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/b=
in/rustfmt:
> new RPATH: $ORIGIN/../lib
> | tar: build/dist/rust-std-1.80.0-aarch64-poky-linux-gnu.tar.xz: Cannot
> open: No such file or directory
> | tar: Error is not recoverable: exiting now
> | WARNING: exit code 2 from a shell command.
> NOTE: recipe rust-1.80.0-r0: task do_install: Failed
> ERROR: Task
> (/source/yocto/build/../meta-lts-mixins/recipes-devtools/rust/rust_1.80.0=
.bb:do_install)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 6118 tasks of which 6114 didn't need to be
> rerun and 1 failed.
> Summary: 1 task failed:
> /source/yocto/build/../meta-lts-mixins/recipes-devtools/rust/rust_1.80.0.=
bb:do_install
>=20
> Summary: There was 1 WARNING message.
> Summary: There was 1 ERROR message, returning a non-zero exit code.
>=20

I try to find where this download are made but the recipe contains only thi=
s part :
File rust81.80.0.bb :

>=20
> do_install () {
> rust_do_install
> }
> rust_do_install() {
> rust_runx install
> }
> rust_do_install:class-nativesdk() {
> export PSEUDO_UNLOAD=3D1
> rust_runx install
> rust_runx install clippy
> rust_runx install rustfmt
> unset PSEUDO_UNLOAD
> install -d ${D}${bindir}
> for i in cargo-clippy clippy-driver rustfmt; do
> cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i
> ${D}${bindir}
> chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
> done
> chown root:root ${D}/ -R
> rm ${D}${libdir}/rustlib/uninstall.sh
> rm ${D}${libdir}/rustlib/install.log
> rm ${D}${libdir}/rustlib/manifest*
> }
>=20

And for me, it's little hard to understand where the problem come from. Eve=
n in the tmp folder in the build folder, I didn't find where the download a=
re operate.

If anyone know where this error come from I will appreciate help.

Last question, meta-lts-mixins require which minimal Python version in the =
environment to be build ? The readme talk about a Python version that shoul=
d be 3.11. Does I have to use this exact version ?

Thanks a lot !

--ixZQ2vT6dvpIRJIK7zSs
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi everyone,</div>
<div>&nbsp;</div>
<div>I'm new with Yocto project and I'm trying to update for a project Rust=
 for a Tinker Board from Asus that use meta-lts-mixins. Repo is fork here :=
 <a href=3D"https://github.com/TinkerBoard-Linux/rockchip-linux-yocto-meta-=
lts-mixins" target=3D"_blank" rel=3D"noopener">https://github.com/TinkerBoa=
rd-Linux/rockchip-linux-yocto-meta-lts-mixins</a><br /><br />I check it fro=
m the official repository and they change nothing.<br /><br />Basically, th=
eir version is using Rust 1.75.0 and I succeed to build their project with =
Rust 1.76.0 by changing the head patch of the meta-lts-mixins.<br /><br />I=
'm trying to build on the Rust version I need which are Rust 1.80.0.<br /><=
br />After a try from a clean environment, I get this error :<br /><br />
<blockquote>
<div>| Installing stage2 rustfmt (aarch64-poky-linux-gnu)<br />| running: B=
ootstrapCommand { command: cd "/source/yocto/build/tmp/work/armv8a-poky-lin=
ux/rust/1.80.0-r0/rustc-1.80.0-src/build/tmp/empty_dir" &amp;&amp; "sh" "/s=
ource/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/rustc-1.80.0-sr=
c/build/tmp/tarball/rustfmt/aarch64-poky-linux-gnu/rustfmt-1.80.0-aarch64-p=
oky-linux-gnu/install.sh" "--prefix=3D/source/yocto/build/tmp/work/armv8a-p=
oky-linux/rust/1.80.0-r0/image/usr" "--sysconfdir=3D/source/yocto/build/tmp=
/work/armv8a-poky-linux/rust/1.80.0-r0/image/etc" "--datadir=3D/source/yoct=
o/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/share" "--docdi=
r=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr=
/share/doc/rustfmt" "--bindir=3D/source/yocto/build/tmp/work/armv8a-poky-li=
nux/rust/1.80.0-r0/image/usr/bin" "--libdir=3D/source/yocto/build/tmp/work/=
armv8a-poky-linux/rust/1.80.0-r0/image/usr/lib" "--mandir=3D/source/yocto/b=
uild/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/share/man" "--disa=
ble-ldconfig", failure_behavior: Exit, output_mode: PrintAll }<br />| insta=
ll: creating uninstall script at /source/yocto/build/tmp/work/armv8a-poky-l=
inux/rust/1.80.0-r0/image/usr/lib/rustlib/uninstall.sh<br />| install: inst=
alling component 'rustfmt-preview'<br />|&nbsp;<br />| &nbsp; &nbsp; rustfm=
t installed.<br />|&nbsp;<br />| There have been changes to x.py since you =
last updated:<br />| &nbsp; [INFO] Use of the `if-available` value for `dow=
nload-ci-llvm` is deprecated; prefer using the new `if-unchanged` value.<br=
 />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull/117813<=
br />| &nbsp; [INFO] The `rust.use-lld` configuration now has different opt=
ions ('external'/true or 'self-contained'), and its behaviour has changed.<=
br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull/11627=
8<br />| &nbsp; [INFO] Removed rust.run_dsymutil and dist.gpg_password_file=
 config options, as they were unused.<br />| &nbsp; &nbsp; - PR Link https:=
//github.com/rust-lang/rust/pull/118703<br />| &nbsp; [WARNING] rust-analyz=
er-proc-macro-srv is no longer enabled by default. To build it, you must ei=
ther enable it in the configuration or explicitly invoke it with x.py.<br /=
>| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull/119124<br=
 />| &nbsp; [INFO] The dist.missing-tools config option was deprecated, as =
it was unused. If you are using it, remove it from your config, it will be =
removed soon.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/r=
ust/pull/119373<br />| &nbsp; [WARNING] A new `optimized-compiler-builtins`=
 option has been introduced. Whether to build llvm's `compiler-rt` from sou=
rce is no longer implicitly controlled by git state. See the PR for more de=
tails.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pul=
l/102579<br />| &nbsp; [INFO] New option `target.&lt;triple&gt;.codegen-bac=
kends` added to config.toml.<br />| &nbsp; &nbsp; - PR Link https://github.=
com/rust-lang/rust/pull/120348<br />| &nbsp; [INFO] A new `rust.frame-point=
ers` option has been introduced and made the default in the compiler and co=
degen profiles.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang=
/rust/pull/121203<br />| &nbsp; [WARNING] The "codegen"/"llvm" profile has =
been removed and replaced with "compiler", use it instead for the same beha=
vior.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull=
/121278<br />| &nbsp; [INFO] `x install` now skips providing tarball source=
s (under 'build/dist' path) to speed up the installation process.<br />| &n=
bsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull/118724<br />| =
&nbsp; [INFO] A new `boostrap-cache-path` option has been introduced which =
can be utilized to modify the cache path for bootstrap.<br />| &nbsp; &nbsp=
; - PR Link https://github.com/rust-lang/rust/pull/121976<br />| &nbsp; [IN=
FO] a new `target.*.runner` option is available to specify a wrapper execut=
able required to run tests for a target<br />| &nbsp; &nbsp; - PR Link http=
s://github.com/rust-lang/rust/pull/122108<br />| &nbsp; [INFO] New option `=
rust.llvm-bitcode-linker` that will build the llvm-bitcode-linker.<br />| &=
nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull/117458<br />|=
 &nbsp; [WARNING] `rust.split-debuginfo` has been moved to `target.&lt;trip=
le&gt;.split-debuginfo` and its default value is determined for each target=
 individually.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/=
rust/pull/121754<br />| &nbsp; [WARNING] The deprecated field `changelog-se=
en` has been removed. Using that field in `config.toml` from now on will re=
sult in breakage.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-la=
ng/rust/pull/123711<br />| &nbsp; [INFO] New option `build.lldb` that will =
override the default lldb binary path used in debuginfo tests<br />| &nbsp;=
 &nbsp; - PR Link https://github.com/rust-lang/rust/pull/124501<br />| &nbs=
p; [INFO] The compiler profile now defaults to rust.debuginfo-level =3D "li=
ne-tables-only"<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang=
/rust/pull/123337<br />| &nbsp; [WARNING] `rust.lld` has a new default valu=
e of `true` on `x86_64-unknown-linux-gnu`. Starting at stage1, `rust-lld` w=
ill thus be this target's default linker. No config changes should be neces=
sary.<br />| &nbsp; &nbsp; - PR Link https://github.com/rust-lang/rust/pull=
/124129<br />| &nbsp; [WARNING] Removed `dist.missing-tools` configuration =
as it was deprecated long time ago.<br />| &nbsp; &nbsp; - PR Link https://=
github.com/rust-lang/rust/pull/125535<br />| NOTE: to silence this warning,=
 update `config.toml` to use `change-id =3D 125535` instead<br />| NOTE: th=
is message was printed twice to make it more likely to be seen<br />| Build=
 completed successfully in 0:00:07<br />| /source/yocto/build/tmp/work/armv=
8a-poky-linux/rust/1.80.0-r0/image/usr/bin/cargo-clippy: RPATH=3D$ORIGIN/..=
/lib<br />| /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/i=
mage/usr/bin/cargo-clippy: new RPATH: $ORIGIN/../lib<br />| /source/yocto/b=
uild/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/usr/bin/clippy-driver:=
 RPATH=3D$ORIGIN/../lib<br />| /source/yocto/build/tmp/work/armv8a-poky-lin=
ux/rust/1.80.0-r0/image/usr/bin/clippy-driver: new RPATH: $ORIGIN/../lib<br=
 />| /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.80.0-r0/image/us=
r/bin/rustfmt: RPATH=3D$ORIGIN/../lib<br />| /source/yocto/build/tmp/work/a=
rmv8a-poky-linux/rust/1.80.0-r0/image/usr/bin/rustfmt: new RPATH: $ORIGIN/.=
./lib<br />| tar: build/dist/rust-std-1.80.0-aarch64-poky-linux-gnu.tar.xz:=
 Cannot open: No such file or directory<br />| tar: Error is not recoverabl=
e: exiting now<br />| WARNING: exit code 2 from a shell command.<br />NOTE:=
 recipe rust-1.80.0-r0: task do_install: Failed<br />ERROR: Task (/source/y=
octo/build/../meta-lts-mixins/recipes-devtools/rust/rust_1.80.0.bb:do_insta=
ll) failed with exit code '1'<br />NOTE: Tasks Summary: Attempted 6118 task=
s of which 6114 didn't need to be rerun and 1 failed.</div>
<div>Summary: 1 task failed:<br />&nbsp; /source/yocto/build/../meta-lts-mi=
xins/recipes-devtools/rust/rust_1.80.0.bb:do_install<br />Summary: There wa=
s 1 WARNING message.<br />Summary: There was 1 ERROR message, returning a n=
on-zero exit code.</div>
</blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>I try to find where this download are made but the recipe contains onl=
y this part :<br />File rust81.80.0.bb :<br /><br />
<blockquote>
<div>do_install () {<br />&nbsp; &nbsp; rust_do_install<br />}</div>
<div>rust_do_install() {<br />&nbsp; &nbsp; rust_runx install<br />}</div>
<div>rust_do_install:class-nativesdk() {<br />&nbsp; &nbsp; export PSEUDO_U=
NLOAD=3D1<br />&nbsp; &nbsp; rust_runx install<br />&nbsp; &nbsp; rust_runx=
 install clippy<br />&nbsp; &nbsp; rust_runx install rustfmt<br />&nbsp; &n=
bsp; unset PSEUDO_UNLOAD</div>
<div>&nbsp; &nbsp; install -d ${D}${bindir}<br />&nbsp; &nbsp; for i in car=
go-clippy clippy-driver rustfmt; do<br />&nbsp; &nbsp; &nbsp; &nbsp; cp bui=
ld/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}=
<br />&nbsp; &nbsp; &nbsp; &nbsp; chrpath -r "\$ORIGIN/../lib" ${D}${bindir=
}/$i<br />&nbsp; &nbsp; done</div>
<div>&nbsp; &nbsp; chown root:root ${D}/ -R<br />&nbsp; &nbsp; rm ${D}${lib=
dir}/rustlib/uninstall.sh<br />&nbsp; &nbsp; rm ${D}${libdir}/rustlib/insta=
ll.log<br />&nbsp; &nbsp; rm ${D}${libdir}/rustlib/manifest*<br />}</div>
</blockquote>
<br />And for me, it's little hard to understand where the problem come fro=
m. Even in the tmp folder in the build folder, I didn't find where the down=
load are operate.<br /><br />If anyone know where this error come from I wi=
ll appreciate help.<br /><br />Last question, meta-lts-mixins require which=
 minimal Python version in the environment to be build ? The readme talk ab=
out a Python version that should be 3.11. Does I have to use this exact ver=
sion ?<br /><br /></div>
<div>Thanks a lot !</div>
<br /><br /><br /></div>

--ixZQ2vT6dvpIRJIK7zSs--

