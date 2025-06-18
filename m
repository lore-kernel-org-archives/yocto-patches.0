Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F17CC7115B
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 07:06:24 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Osaka, JP (160.86.248.152)
X-Originating-Platform: Linux Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 00:06:16 -0700
References: <13137.1750071563599758232@lists.yoctoproject.org>
In-Reply-To: <13137.1750071563599758232@lists.yoctoproject.org>
Message-ID: <26140.1750230376932992667@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="NxgFmBaA2nFcN4HoLccf"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 07:06:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1656

--NxgFmBaA2nFcN4HoLccf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Ok I fix my problem.

So first, I try to build some rustc version. I detect that indeed, the tar.=
xz is not more produce on a "x build" command.

So for this part of my rust recipe I add the "rust_runx dist" line :
EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
rust_do_install:class-target() {
export PSEUDO_UNLOAD=3D1
rust_runx dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<---------------------- first line added
rust_runx install
rust_runx install clippy
rust_runx install rustfmt
unset PSEUDO_UNLOAD

Then, I get the tar.xz. After that I get an error from the same untar comma=
nd, but now it tell me that it can't uncompress the file because inside, th=
e file have a root ownership.
So as a quick workaround that I will improve, I just unzip by changing the =
ownership and re tar.xz it after.

Then I copy this new tar.xz in the {D}../rustc-1.85.1-src folder.
In my recipe, I add this line :

EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"
rust_do_install:class-target() {
export PSEUDO_UNLOAD=3D1
rust_runx dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<---------------------- first line added
rust_runx install
rust_runx install clippy
rust_runx install rustfmt
unset PSEUDO_UNLOAD
cp ${D}/../rustc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz $=
{D}/../rustc-1.85.1-src/build/dist=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<---------------------- second li=
ne added

And everything work.

I can't explain why I encounter this error.

I see that the uncompress (with tar command) appear in my run.do_install fi=
le like that :

rust_do_install () {
export PSEUDO_UNLOAD =3D 1
rust_runx dist
rust_runx install
rust_runx install clippy
rust_runx install rustfmt
unset PSEUDO_UNLOAD

cp /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/../r=
ustc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz /source/yocto=
/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/../rustc-1.85.1-src/=
build/dist

// Here some code of my recipe...

// After that, the following code doesn't belong to my recipe :

mkdir -p _dist
rlib_path =3D "rust-std-1.85.1-aarch64-poky-linux-gnu/rust-std-aarch64-poky=
-linux-gnu/lib/rustlib"
tar -C _dist -xf build/dist/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz $=
rlib_path

target_dir =3D /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r=
0/image/usr/lib/rustlib
install -d $target_dir
cp -r _dist/ $rlib_path /aarch64-poky-linux-gnu $target_dir
rm -rf _dist
install -m 0644 /source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-=
r0/rust-targets/aarch64-poky-linux-gnu.json /source/yocto/build/tmp/work/ar=
mv8a-poky-linux/rust/1.85.1-r0/image/usr/lib/rustlib/aarch64-poky-linux-gnu=
/target.json
}
And this mkdir to install doesn't appear in my do_install recipe so I suspe=
ct a do_install:append somewhere but I never find it.

I hope this message will help someone that have the same problem.

--NxgFmBaA2nFcN4HoLccf
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Ok I fix my problem.<br /><br />So first, I try to build some rustc ve=
rsion. I detect that indeed, the tar.xz is not more produce on a "x build" =
command.<br /><br />So for this part of my rust recipe I add the "rust_runx=
 dist" line :<br />EXTRA_TOOLS ?=3D "cargo-clippy clippy-driver rustfmt"<br=
 />rust_do_install:class-target() {<br />&nbsp; &nbsp; export PSEUDO_UNLOAD=
=3D1<br />&nbsp; &nbsp; rust_runx dist&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;---------------------- fi=
rst line added<br />&nbsp; &nbsp; rust_runx install<br />&nbsp; &nbsp; rust=
_runx install clippy<br />&nbsp; &nbsp; rust_runx install rustfmt<br />&nbs=
p; &nbsp; unset PSEUDO_UNLOAD<br /><br />Then, I get the tar.xz. After that=
 I get an error from the same untar command, but now it tell me that it can=
't uncompress the file because inside, the file have a root ownership.<br /=
>So as a quick workaround that I will improve, I just unzip by changing the=
 ownership and re tar.xz it after.<br /><br />Then I copy this new tar.xz i=
n the {D}../rustc-1.85.1-src folder.<br />In my recipe, I add this line :<b=
r /><br />
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
<br /><br />And everything work.<br /><br />I can't explain why I encounter=
 this error.<br /><br />I see that the uncompress (with tar command) appear=
 in my run.do_install file like that :<br /><br />
<div style=3D"color: #cccccc; background-color: #1f1f1f; font-family: 'Droi=
d Sans Mono', 'monospace', monospace; font-weight: normal; font-size: 14px;=
 line-height: 19px; white-space: pre;">
<div><span style=3D"color: #dcdcaa;">rust_do_install</span><span style=3D"c=
olor: #cccccc;">() {</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #569cd6;=
">export</span><span style=3D"color: #cccccc;"> </span><span style=3D"color=
: #9cdcfe;">PSEUDO_UNLOAD</span><span style=3D"color: #d4d4d4;">=3D</span><=
span style=3D"color: #b5cea8;">1</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">rust_runx</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">dist</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">rust_runx</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">install</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">rust_runx</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">install</span><span style=3D"color: #cccccc;"> </span><span =
style=3D"color: #ce9178;">clippy</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">rust_runx</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">install</span><span style=3D"color: #cccccc;"> </span><span =
style=3D"color: #ce9178;">rustfmt</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">unset</span><span style=3D"color: #cccccc;"> </span><span style=3D"color:=
 #ce9178;">PSEUDO_UNLOAD</span></div>
<br />
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">cp</span><span style=3D"color: #cccccc;"> </span><span style=3D"color: #c=
e9178;">/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image=
/../rustc-1.85.1-src/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz</span><s=
pan style=3D"color: #cccccc;"> </span><span style=3D"color: #ce9178;">/sour=
ce/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/../rustc-1.8=
5.1-src/build/dist</span></div>
<br />// Here some code of my recipe...
<div><span style=3D"color: #ce9178;"><br />// After that, the following cod=
e doesn't belong to my recipe :<br /><br /></span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">mkdir</span><span style=3D"color: #cccccc;"> </span><span style=3D"color:=
 #569cd6;">-p</span><span style=3D"color: #cccccc;"> </span><span style=3D"=
color: #ce9178;">_dist</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #9cdcfe;=
">rlib_path</span><span style=3D"color: #d4d4d4;">=3D</span><span style=3D"=
color: #ce9178;">"rust-std-1.85.1-aarch64-poky-linux-gnu/rust-std-aarch64-p=
oky-linux-gnu/lib/rustlib"</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">tar</span><span style=3D"color: #cccccc;"> </span><span style=3D"color: #=
569cd6;">-C</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">_dist</span><span style=3D"color: #cccccc;"> </span><span st=
yle=3D"color: #569cd6;">-xf</span><span style=3D"color: #cccccc;"> </span><=
span style=3D"color: #ce9178;">build/dist/rust-std-1.85.1-aarch64-poky-linu=
x-gnu.tar.xz</span><span style=3D"color: #cccccc;"> </span><span style=3D"c=
olor: #9cdcfe;">$rlib_path</span></div>
<br />
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #9cdcfe;=
">target_dir</span><span style=3D"color: #d4d4d4;">=3D</span><span style=3D=
"color: #ce9178;">/source/yocto/build/tmp/work/armv8a-poky-linux/rust/1.85.=
1-r0/image/usr/lib/rustlib</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">install</span><span style=3D"color: #cccccc;"> </span><span style=3D"colo=
r: #569cd6;">-d</span><span style=3D"color: #cccccc;"> </span><span style=
=3D"color: #9cdcfe;">$target_dir</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">cp</span><span style=3D"color: #cccccc;"> </span><span style=3D"color: #5=
69cd6;">-r</span><span style=3D"color: #cccccc;"> </span><span style=3D"col=
or: #ce9178;">_dist/</span><span style=3D"color: #9cdcfe;">$rlib_path</span=
><span style=3D"color: #ce9178;">/aarch64-poky-linux-gnu</span><span style=
=3D"color: #cccccc;"> </span><span style=3D"color: #9cdcfe;">$target_dir</s=
pan></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">rm</span><span style=3D"color: #cccccc;"> </span><span style=3D"color: #5=
69cd6;">-rf</span><span style=3D"color: #cccccc;"> </span><span style=3D"co=
lor: #ce9178;">_dist</span></div>
<div><span style=3D"color: #cccccc;"> </span><span style=3D"color: #dcdcaa;=
">install</span><span style=3D"color: #cccccc;"> </span><span style=3D"colo=
r: #569cd6;">-m</span><span style=3D"color: #cccccc;"> </span><span style=
=3D"color: #b5cea8;">0644</span><span style=3D"color: #cccccc;"> </span><sp=
an style=3D"color: #ce9178;">/source/yocto/build/tmp/work/armv8a-poky-linux=
/rust/1.85.1-r0/rust-targets/aarch64-poky-linux-gnu.json</span><span style=
=3D"color: #cccccc;"> </span><span style=3D"color: #ce9178;">/source/yocto/=
build/tmp/work/armv8a-poky-linux/rust/1.85.1-r0/image/usr/lib/rustlib/aarch=
64-poky-linux-gnu/target.json</span></div>
<div><span style=3D"color: #cccccc;">}</span></div>
</div>
</div>
<div>And this mkdir to install doesn't appear in my do_install recipe so I =
suspect a do_install:append somewhere but I never find it.<br /><br />I hop=
e this message will help someone that have the same problem.</div>
<div>&nbsp;</div>

--NxgFmBaA2nFcN4HoLccf--

