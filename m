Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C24C7115B
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 07:09:14 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Osaka, JP (160.86.248.152)
X-Originating-Platform: Linux Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 00:09:06 -0700
References: <13137.1750071563599758232@lists.yoctoproject.org>
In-Reply-To: <13137.1750071563599758232@lists.yoctoproject.org>
Message-ID: <26140.1750230376932992667@lists.yoctoproject.org>
X-Old-Date: Wed, 18 Jun 2025 00:06:16 -0700
Content-Type: multipart/alternative; boundary="NxgFmBaA2nFcN4HoLccf"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 07:09:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1656
Message-ID: <20250618070906.PgSWAT7GUzWujkY1iC1-M-bRDFpwCs6l83kk3bgRVNw@z>

--NxgFmBaA2nFcN4HoLccf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok I fix my problem.

So first, I try to build some rustc version. I detect that indeed, the tar.=
xz is not more produce on a "x build" command.

So for this part of my rust recipe I add the "rust_runx dist" line :

>=20
>=20
> EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
> rust_do_install:class-target() {
> export PSEUDO_UNLOAD=3D1
> rust_runx dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<---------------------- first line
> added
> rust_runx install
> rust_runx install clippy
> rust_runx install rustfmt
> unset PSEUDO_UNLOAD
>=20
>=20

Then, I get the tar.xz. After that I get an error from the same untar comma=
nd, but now it tell me that it can't uncompress the file because inside, th=
e file have a root ownership.
So as a quick workaround that I will improve, I just unzip by changing the =
ownership and re tar.xz it after.

Then I copy this new tar.xz in the {D}../rustc-1.85.1-src folder.
In my recipe, I add this line :

>=20
> EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
> rust_do_install:class-target() {
> export PSEUDO_UNLOAD=3D1
> rust_runx dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<---------------------- first line
> added
> rust_runx install
> rust_runx install clippy
> rust_runx install rustfmt
> unset PSEUDO_UNLOAD
> cp ${D}/../rustc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz
> ${D}/../rustc-1.85.1-src/build/dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> <---------------------- second line added
>=20

And everything work.

I can't explain why I encounter this error.

I see that the uncompress (with tar command) appear in my run.do_install fi=
le like that :

>=20
> rust_do_install() {
> export PSEUDO_UNLOAD=3D1
> rust_runx dist
> rust_runx install
> rust_runx install clippy
> rust_runx install rustfmt
> unset PSEUDO_UNLOAD
> cp
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/../ru=
stc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/../ru=
stc-1.85.1-src/build/dist
>=20
>=20
> // Here some code that belong to my recipe.
> // After that, the following code doesn't belong to my recipde :
>=20
> mkdir -p _dist
> rlib_path=3D"rust-std-1.85.1-aarch64-poky-linux-gnu/rust-std-aarch64-poky=
-linux-gnu/lib/rustlib"
>=20
> tar -C _dist -xf build/dist/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz
> $rlib_path
> target_dir=3D/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r=
0/image/usr/lib/rustlib
>=20
> install -d $target_dir
> cp -r _dist/$rlib_path/aarch64-poky-linux-gnu $target_dir
> rm -rf _dist
> install -m 0644
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rust-target=
s/aarch64-poky-linux-gnu.json
> /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/usr/l=
ib/rustlib/aarch64-poky-linux-gnu/target.json
>=20
> }
>=20

And this mkdir to install doesn't appear in my do_install recipe so I suspe=
ct a do_install:append somewhere but I never find it.

I hope this message will help someone that have the same problem.

--NxgFmBaA2nFcN4HoLccf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Ok I fix my problem.<br /><br />So first, I try to build some rustc ve=
rsion. I detect that indeed, the tar.xz is not more produce on a "x build" =
command.<br /><br />So for this part of my rust recipe I add the "rust_runx=
 dist" line :</div>
<blockquote>
<div><br />EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"<br />rust_=
do_install:class-target() {<br />&nbsp; &nbsp; export PSEUDO_UNLOAD=3D1<br =
/>&nbsp; &nbsp; rust_runx dist&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;---------------------- first line=
 added<br />&nbsp; &nbsp; rust_runx install<br />&nbsp; &nbsp; rust_runx in=
stall clippy<br />&nbsp; &nbsp; rust_runx install rustfmt<br />&nbsp; &nbsp=
; unset PSEUDO_UNLOAD</div>
<div>&nbsp;</div>
</blockquote>
<div>&nbsp;</div>
<div>
<div>Then, I get the tar.xz. After that I get an error from the same untar =
command, but now it tell me that it can't uncompress the file because insid=
e, the file have a root ownership.<br />So as a quick workaround that I wil=
l improve, I just unzip by changing the ownership and re tar.xz it after.<b=
r /><br />Then I copy this new tar.xz in the {D}../rustc-1.85.1-src folder.=
<br />In my recipe, I add this line :</div>
<div>&nbsp;</div>
<div>
<blockquote>
<div>EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"<br />rust_do_ins=
tall:class-target() {<br />&nbsp; &nbsp; export PSEUDO_UNLOAD=3D1<br />&nbs=
p; &nbsp; rust_runx dist&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;---------------------- first line added=
<br />&nbsp; &nbsp; rust_runx install<br />&nbsp; &nbsp; rust_runx install =
clippy<br />&nbsp; &nbsp; rust_runx install rustfmt<br />&nbsp; &nbsp; unse=
t PSEUDO_UNLOAD</div>
<div>&nbsp; &nbsp; cp ${D}/../rustc-1.85.1-src/rust-std-1.85.1-aarch64-poky=
-linux-gnu.tar.xz ${D}/../rustc-1.85.1-src/build/dist&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;----------=
------------ second line added</div>
</blockquote>
<br />And everything work.<br /><br />I can't explain why I encounter this =
error.<br /><br />I see that the uncompress (with tar command) appear in my=
 run.do_install file like that :</div>
<div>&nbsp;</div>
</div>
<div>
<blockquote>
<div>rust_do_install() {<br />&nbsp; &nbsp; export PSEUDO_UNLOAD=3D1<br />&=
nbsp; &nbsp; rust_runx dist<br />&nbsp; &nbsp; rust_runx install<br />&nbsp=
; &nbsp; rust_runx install clippy<br />&nbsp; &nbsp; rust_runx install rust=
fmt<br />&nbsp; &nbsp; unset PSEUDO_UNLOAD</div>
<div>&nbsp; &nbsp; cp /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1=
.85.1-r0/image/../rustc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.t=
ar.xz /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/.=
./rustc-1.85.1-src/build/dist</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; // Here some code that belong to my recipe.</div>
<div>&nbsp; &nbsp; // After that, the following code doesn't belong to my r=
ecipde :&nbsp; &nbsp;</div>
<div><br />&nbsp; &nbsp; mkdir -p _dist<br />&nbsp; &nbsp; rlib_path=3D"rus=
t-std-1.85.1-aarch64-poky-linux-gnu/rust-std-aarch64-poky-linux-gnu/lib/rus=
tlib"<br />&nbsp; &nbsp; tar -C _dist -xf build/dist/rust-std-1.85.1-aarch6=
4-poky-linux-gnu.tar.xz $rlib_path</div>
<div>&nbsp; &nbsp; target_dir=3D/source/yocto/build/tmp/work/armv8a-poky-li=
nux/rust/1.85.1-r0/image/usr/lib/rustlib<br />&nbsp; &nbsp; install -d $tar=
get_dir<br />&nbsp; &nbsp; cp -r _dist/$rlib_path/aarch64-poky-linux-gnu $t=
arget_dir<br />&nbsp; &nbsp; rm -rf _dist<br />&nbsp; &nbsp; install -m 064=
4 /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/rust-target=
s/aarch64-poky-linux-gnu.json /source/yocto/build/tmp/work/armv8a-poky-linu=
x/rust/1.85.1-r0/image/usr/lib/rustlib/aarch64-poky-linux-gnu/target.json<b=
r />}</div>
</blockquote>
</div>
<div>&nbsp;</div>
<div>And this mkdir to install doesn't appear in my do_install recipe so I =
suspect a do_install:append somewhere but I never find it.<br /><br />I hop=
e this message will help someone that have the same problem.</div>
<div>&nbsp;</div>

--NxgFmBaA2nFcN4HoLccf--

