Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D83C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 04:24:57 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Sakai, Osaka, JP (14.10.72.34)
X-Originating-Platform: Windows Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 12 Jun 2025 21:24:50 -0700
References: <036a708b-c723-fe56-47c2-3574a0bdaa87@konsulko.com>
In-Reply-To: <036a708b-c723-fe56-47c2-3574a0bdaa87@konsulko.com>
Message-ID: <13355.1749788690158478865@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="2loIEujOc6IDiGnNOQq3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 04:24:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1636

--2loIEujOc6IDiGnNOQq3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Scott, sorry for the late, I want to come back with the maximum of infor=
mation that could help us.

>=20
> Which specific commit on kirkstone/rust are you trying?
>=20

I test to build on these sha1 :

a451591a2506811dced5124fc01687360e51d902 : rust: Add patch to increase time=
out in process-sigpipe rust selftest
Error encountered : tar: build/dist/rust-std-1.79.0-aarch64-poky-linux-gnu.=
tar.xz: Cannot open: No such file or directory

3d6c313be185352f65e8c928e0e29ab84cd4e955 : rust: Upgrade 1.79.0->1.80.0
Error encountered : tar: build/dist/rust-std-1.80.0-aarch64-poky-linux-gnu.=
tar.xz: Cannot open: No such file or directory

194e3073d96077c77c0207809684348189de1c1e : rust: Upgrade 1.80.0->1.80.1
Error encountered : tar: build/dist/rust-std-1.80.1-aarch64-poky-linux-gnu.=
tar.xz: Cannot open: No such file or directory

2c51da6c41614ae1132f1e9e5803fbf97905ab76 : rust: Upgrade 1.80.1->1.81.0
Error encountered : tar : build/dist/rust-std-1.81.0-aarch64-poky-linux-gnu=
.tar.xz: Cannot open: No such file or directory

c0794922957a6e5df23e6f4922bd252adb5f5d80 : rust: Upgrade 1.85.0->1.85.1
Error encountered : tar : build/dist/rust-std-1.85.1-aarch64-poky-linux-gnu=
.tar.xz: Cannot open: No such file or directory

dcc60f3115a8133c4013ce36cb6fe0969c07d6f5 : mozjs: Use RUST_HOST_SYS and RUS=
T_TARGET_SYS
Error encountered : tar: build/dist/rust-std-1.85.1-aarch64-poky-linux-gnu.=
tar.xz: Cannot open: No such file or directory

So I think I technically test your both version, ie 1.80.1 and 1.85.1. I di=
dn't the last commit of the 1.80.1 (9a86110789eccdf15816a0c0c4ba116403eaac5=
f) before switching to 1.81.0 and this is what I will to today.

The most recent commit with a OK build is the b1cfa357ba4f046c9f739ceb357fe=
8a7971cc0d3 : rust: Upgrade 1.77.1->1.77.2
On this build, the rust-std-1.77.2-aarch64-poky-linux-gnu.tar.xz file is pr=
esent here : <yocto_build_directory> /tmp/work/armv8a-poky-linux/rust/1.77.=
2-r0/rustc-1.77.2-src/build/dist/rust-std-1.77.2-aarch64-poky-linux-gnu.tar=
.xz

I'm currently building the version 1.78.0 trying to know on which sha1 the =
problem start to appear.

I have some question :
When I update my head on the meta-lts-mixins repository branch remotes/yoct=
o/kirkstone/rust, does IU have to update the head of another repository on =
my environment to have a build succeed ? Through this question I want to kn=
ow if there are any depencency I have to update. I know that this layer dep=
end on :
- URI: git://github.com/openembedded/openembedded-core.git =20
 layers: meta =20
 branch: kirkstone So if I update meta-lts-mixins, does I have to update th=
is my head on this repository too ?

I'm sorry about this last question. I'm a newcommer in the Yocto world.

Maxime.

--2loIEujOc6IDiGnNOQq3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Scott, sorry for the late, I want to come back with the maximum of =
information that could help us.</div>
<div>&nbsp;</div>
<blockquote>
<div>Which specific commit on kirkstone/rust are you trying?</div>
</blockquote>
<div>I test to build on these sha1 :<br /><br />a451591a2506811dced5124fc01=
687360e51d902 : rust: Add patch to increase timeout in process-sigpipe rust=
 selftest<br />Error encountered : <span style=3D"font-size: 10pt; font-fam=
ily: Arial; font-style: normal;" data-sheets-root=3D"1">tar: build/dist/rus=
t-std-1.79.0-aarch64-poky-linux-gnu.tar.xz: Cannot open: No such file or di=
rectory</span><br /><br />3d6c313be185352f65e8c928e0e29ab84cd4e955 : rust: =
Upgrade 1.79.0-&gt;1.80.0<br />Error encountered : tar: <span style=3D"font=
-size: 10pt; font-family: Arial; font-style: normal;" data-sheets-root=3D"1=
">build/dist/rust-std-1.80.0-aarch64-poky-linux-gnu.tar.xz: Cannot open: No=
 such file or directory</span><br /><br /></div>
<div>194e3073d96077c77c0207809684348189de1c1e : rust: Upgrade 1.80.0-&gt;1.=
80.1</div>
<div>Error encountered : <span style=3D"font-size: 10pt; font-family: Arial=
; font-style: normal;" data-sheets-root=3D"1">tar: build/dist/rust-std-1.80=
.1-aarch64-poky-linux-gnu.tar.xz: Cannot open: No such file or directory<br=
 /></span><br />2c51da6c41614ae1132f1e9e5803fbf97905ab76 : rust: Upgrade 1.=
80.1-&gt;1.81.0<br />Error encountered : tar : <span style=3D"font-size: 10=
pt; font-family: Arial; font-style: normal;" data-sheets-root=3D"1">build/d=
ist/rust-std-1.81.0-aarch64-poky-linux-gnu.tar.xz: Cannot open: No such fil=
e or directory</span><br /><br />c0794922957a6e5df23e6f4922bd252adb5f5d80 :=
 rust: Upgrade 1.85.0-&gt;1.85.1<br />Error encountered : tar : <span style=
=3D"font-size: 10pt; font-family: Arial; font-style: normal;" data-sheets-r=
oot=3D"1">build/dist/rust-std-1.85.1-aarch64-poky-linux-gnu.tar.xz: Cannot =
open: No such file or directory</span><br /><br />dcc60f3115a8133c4013ce36c=
b6fe0969c07d6f5 : mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS<br />Error e=
ncountered : <span style=3D"font-size: 10pt; font-family: Arial; font-style=
: normal;" data-sheets-root=3D"1">tar: build/dist/rust-std-1.85.1-aarch64-p=
oky-linux-gnu.tar.xz: Cannot open: No such file or directory</span></div>
<div>&nbsp;</div>
<div>So I think I technically test your both version, ie 1.80.1 and 1.85.1.=
 I didn't the last commit of the 1.80.1 (9a86110789eccdf15816a0c0c4ba116403=
eaac5f) before switching to 1.81.0 and this is what I will to today.</div>
<div><br />The most recent commit with a OK build is the b1cfa357ba4f046c9f=
739ceb357fe8a7971cc0d3 : rust: Upgrade 1.77.1-&gt;1.77.2<br />On this build=
, the <span style=3D"font-size: 10pt; font-family: Arial; font-style: norma=
l;" data-sheets-root=3D"1"><span style=3D"font-size: 10pt; font-family: Ari=
al; font-style: normal;" data-sheets-root=3D"1">rust-std-1.77.2-aarch64-pok=
y-linux-gnu.tar.xz file is present here : &lt;yocto_build_directory&gt;<spa=
n style=3D"font-size: 10pt; font-family: Arial; font-style: normal;" data-s=
heets-root=3D"1">/tmp/work/armv8a-poky-linux/rust/1.77.2-r0/rustc-1.77.2-sr=
c/build/dist/rust-std-1.77.2-aarch64-poky-linux-gnu.tar.xz</span><br /><br =
/>I'm currently building the version 1.78.0 trying to know on which sha1 th=
e problem start to appear.<br /><br />I have some question :<br />When I up=
date my head on the meta-lts-mixins repository branch remotes/yocto/kirksto=
ne/rust, does IU have to update the head of another repository on my enviro=
nment to have a build succeed ? Through this question I want to know if the=
re are any depencency I have to update. I know that this layer depend on :<=
br /></span></span>
<pre><span class=3D"k">-</span> URI: git://github.com/openembedded/openembe=
dded-core.git =20
  layers: meta =20
  branch: kirkstone</pre>
<span style=3D"font-size: 10pt; font-family: Arial; font-style: normal;" da=
ta-sheets-root=3D"1">So if I update meta-lts-mixins, does I have to update =
this my head on this repository too ?<br /><br />I'm sorry about this last =
question. I'm a newcommer in the Yocto world.<br /><br />Maxime.<br /><br /=
><br /><br /></span></div>

--2loIEujOc6IDiGnNOQq3--

