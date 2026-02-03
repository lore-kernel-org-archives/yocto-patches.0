Return-Path: <c.schlegel@televic.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66695E6E80E
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 11:09:35 +0000 (UTC)
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] 
To: yocto-patches@lists.yoctoproject.org
From: c.schlegel@televic.com
X-Originating-Location: Sint-Martens-Latem, Flanders, BE (84.199.255.188)
X-Originating-Platform: Linux Firefox 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 03 Feb 2026 03:09:30 -0800
Message-ID: <icKu.1770116970811561631.kJ0f@lists.yoctoproject.org>
Content-Type: multipart/mixed; boundary="1Ugscv74l3mMMkScwo4n"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 11:09:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3174

--1Ugscv74l3mMMkScwo4n
Content-Type: multipart/alternative; boundary="8QvuB7eMGouw9QriF1g0"

--8QvuB7eMGouw9QriF1g0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We are using meta-lts-mixins for Rust support in our Yocto image and SDK.
Our devices use arm hf.
When looking at the resulted toolchain json, we get
cat ./x86_64-pokysdk-linux/usr/lib/arm-poky-linux-gnueabi/rustlib/armv7-pok=
y-linux-gnueabihf.json
{
"llvm-target": "armv7-poky-linux-gnueabihf",
"data-layout": "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64",
"max-atomic-width": 64,
"target-pointer-width": "32",
"target-c-int-width": 32,
"target-endian": "little",
"arch": "arm",
"os": "linux",
"env": "gnu",
"vendor": "unknown",
"target-family": "unix",
"linker": "arm-poky-linux-gnueabi-gcc",
"cpu": "generic",
"features": "+vfp2,+neon,+v7,+thumb2,+thumb-mode,+a9",
"llvm-floatabi": "hard",
"dynamic-linking": true,
"executables": true,
"linker-is-gnu": true,
"linker-flavor": "gcc",
"has-rpath": true,
"has-thread-local": true,
"position-independent-executables": true,
"panic-strategy": "unwind"
}
With this it builds, but when running on target there is a linkage issue an=
d resulting in a file not found error when running.
After investigating, we think that the gcc flag -mfloat-abi=3Dhard is missi=
ng.

root@tracs-a9:/tmp# ./test_app
-sh: ./test_app: No such file or directory
root@tracs-a9:/tmp# ldd test_app
linux-vdso.so.1 (0xbeca9000)
libc.so.6 =3D> /lib/libc.so.6 (0xb6de0000)
/lib/ld-linux.so.3 =3D> /lib/ld-linux-armhf.so.3 (0xb6f5a000)
libgcc_s.so.1 =3D> /lib/libgcc_s.so.1 (0xb6db0000)

When adding this, things are fine.
...
"llvm-floatabi": "hard",
"pre-link-args": {
"gcc": [
"-mfloat-abi=3Dhard"
]
},
"dynamic-linking": true,
...

root@tracs-a9:/tmp# ./test_app
Guess the number!
Please input your guess.
0
You guessed: 0
Too small!
Please input your guess.
^C
root@tracs-a9:/tmp# ldd ./test_app
linux-vdso.so.1 (0xbed96000)
libc.so.6 =3D> /lib/libc.so.6 (0xb6d80000)
/lib/ld-linux-armhf.so.3 (0xb6ef8000)
libgcc_s.so.1 =3D> /lib/libgcc_s.so.1 (0xb6d50000)
root@tracs-a9:/tmp#

Attached you find a patch for including this flag in the rust-target-config=
.bbclass if armhf is detected.
Patch ids identical for both Kirkstone/Scarthgap
Let me know your thoughts! First time I submit a patch here, so if anything=
 I should do different let me know!

Kind regards,
Clemens Schlegel

--8QvuB7eMGouw9QriF1g0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>We are using meta-lts-mixins for Rust support in our Yocto image and S=
DK.</div>
<div>Our devices use arm hf.</div>
<div>When looking at the resulted toolchain json, we get</div>
<div>cat ./x86_64-pokysdk-linux/usr/lib/arm-poky-linux-gnueabi/rustlib/armv=
7-poky-linux-gnueabihf.json&nbsp;<br />{<br />&nbsp; &nbsp; "llvm-target": =
"armv7-poky-linux-gnueabihf",<br />&nbsp; &nbsp; "data-layout": "e-m:e-p:32=
:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64",<br />&nbsp; &nbsp; "max-atomic-=
width": 64,<br />&nbsp; &nbsp; "target-pointer-width": "32",<br />&nbsp; &n=
bsp; "target-c-int-width": 32,<br />&nbsp; &nbsp; "target-endian": "little"=
,<br />&nbsp; &nbsp; "arch": "arm",<br />&nbsp; &nbsp; "os": "linux",<br />=
&nbsp; &nbsp; "env": "gnu",<br />&nbsp; &nbsp; "vendor": "unknown",<br />&n=
bsp; &nbsp; "target-family": "unix",<br />&nbsp; &nbsp; "linker": "arm-poky=
-linux-gnueabi-gcc",<br />&nbsp; &nbsp; "cpu": "generic",<br />&nbsp; &nbsp=
; "features": "+vfp2,+neon,+v7,+thumb2,+thumb-mode,+a9",<br />&nbsp; &nbsp;=
 "llvm-floatabi": "hard",<br />&nbsp; &nbsp; "dynamic-linking": true,<br />=
&nbsp; &nbsp; "executables": true,<br />&nbsp; &nbsp; "linker-is-gnu": true=
,<br />&nbsp; &nbsp; "linker-flavor": "gcc",<br />&nbsp; &nbsp; "has-rpath"=
: true,<br />&nbsp; &nbsp; "has-thread-local": true,<br />&nbsp; &nbsp; "po=
sition-independent-executables": true,<br />&nbsp; &nbsp; "panic-strategy":=
 "unwind"</div>
<div>}</div>
<div>With this it builds, but when running on target there is a linkage iss=
ue and resulting in a file not found error when running.</div>
<div>After investigating, we think that the gcc flag -mfloat-abi=3Dhard is =
missing.</div>
<div>&nbsp;</div>
<div>root@tracs-a9:/tmp# ./test_app&nbsp;<br />-sh: ./test_app: No such fil=
e or directory<br />root@tracs-a9:/tmp# ldd test_app&nbsp;<br />&nbsp; &nbs=
p; linux-vdso.so.1 (0xbeca9000)<br />&nbsp; &nbsp; libc.so.6 =3D&gt; /lib/l=
ibc.so.6 (0xb6de0000)<br />&nbsp; &nbsp; /lib/ld-linux.so.3 =3D&gt; /lib/ld=
-linux-armhf.so.3 (0xb6f5a000)<br />&nbsp; &nbsp; libgcc_s.so.1 =3D&gt; /li=
b/libgcc_s.so.1 (0xb6db0000)</div>
<div>&nbsp;</div>
<div>When adding this, things are fine.</div>
<div>...</div>
<div>&nbsp; &nbsp; "llvm-floatabi": "hard",</div>
<div>&nbsp; &nbsp; "pre-link-args": {<br />&nbsp; &nbsp; &nbsp; &nbsp; "gcc=
": [<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "-mfloat-abi=3Dhard"<br=
 />&nbsp; &nbsp; &nbsp; &nbsp; ]<br />&nbsp; &nbsp; },<br />&nbsp; &nbsp; "=
dynamic-linking": true,</div>
<div>...</div>
<div>&nbsp;</div>
<div>root@tracs-a9:/tmp# ./test_app&nbsp;<br />Guess the number!<br />Pleas=
e input your guess.<br />0<br />You guessed: 0<br />Too small!<br />Please =
input your guess.<br />^C<br />root@tracs-a9:/tmp# ldd ./test_app&nbsp;<br =
/>&nbsp; &nbsp; linux-vdso.so.1 (0xbed96000)<br />&nbsp; &nbsp; libc.so.6 =
=3D&gt; /lib/libc.so.6 (0xb6d80000)<br />&nbsp; &nbsp; /lib/ld-linux-armhf.=
so.3 (0xb6ef8000)<br />&nbsp; &nbsp; libgcc_s.so.1 =3D&gt; /lib/libgcc_s.so=
.1 (0xb6d50000)<br />root@tracs-a9:/tmp#</div>
<div>&nbsp;</div>
<div>Attached you find a patch for including this flag in the rust-target-c=
onfig.bbclass if armhf is detected.</div>
<div>Patch ids identical for both Kirkstone/Scarthgap</div>
<div>Let me know your thoughts! First time I submit a patch here, so if any=
thing I should do different let me know!</div>
<div>&nbsp;</div>
<div>Kind regards,</div>
<div>Clemens Schlegel</div>

--8QvuB7eMGouw9QriF1g0--

--1Ugscv74l3mMMkScwo4n
Content-Type: text/x-patch; name="0001-rust-target-config.bbclass-set-gcc-compile-flag-in-c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-rust-target-config.bbclass-set-gcc-compile-flag-in-c.patch"

RnJvbSBlYWE5NmUyMGE1MDlhMzUwNjg1ZGM4OTQ0OGMxZWU5NjE3YTQxZWRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGVtZW5zIFNjaGxlZ2VsIDxjLnNjaGxlZ2VsQHRlbGV2aWMu
Y29tPgpEYXRlOiBXZWQsIDcgSmFuIDIwMjYgMTQ6MDM6MjMgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBydXN0LXRhcmdldC1jb25maWcuYmJjbGFzczogc2V0IGdjYyBjb21waWxlIGZsYWcgaW4gY2Fz
ZSBoZgogaXMgbmVlZGVkCgotLS0KIGNsYXNzZXMtcmVjaXBlL3J1c3QtdGFyZ2V0LWNvbmZpZy5i
YmNsYXNzIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvY2xhc3Nlcy1yZWNpcGUvcnVzdC10YXJnZXQtY29uZmlnLmJiY2xhc3MgYi9jbGFzc2Vz
LXJlY2lwZS9ydXN0LXRhcmdldC1jb25maWcuYmJjbGFzcwppbmRleCAwZjFlMmUxLi45ZjJhYTU5
IDEwMDY0NAotLS0gYS9jbGFzc2VzLXJlY2lwZS9ydXN0LXRhcmdldC1jb25maWcuYmJjbGFzcwor
KysgYi9jbGFzc2VzLXJlY2lwZS9ydXN0LXRhcmdldC1jb25maWcuYmJjbGFzcwpAQCAtNDAxLDYg
KzQwMSwxMCBAQCBkZWYgcnVzdF9nZW5fdGFyZ2V0KGQsIHRoaW5nLCB3ZCwgYXJjaCk6CiAgICAg
ICAgIHRzcGVjWydsbHZtLWZsb2F0YWJpJ10gPSAic29mdCIKICAgICBlbGlmIGZwdSA9PSAiaGFy
ZCI6CiAgICAgICAgIHRzcGVjWydsbHZtLWZsb2F0YWJpJ10gPSAiaGFyZCIKKyAgICAgICAgaWYg
ImFybSIgaW4gdHNwZWNbJ2xsdm0tdGFyZ2V0J106CisgICAgICAgICAgICB0c3BlY1sncHJlLWxp
bmstYXJncyddID0geworICAgICAgICAgICAgICAgICJnY2MiOiBbIi1tZmxvYXQtYWJpPWhhcmQi
XQorICAgICAgICAgICAgfQogICAgIHRzcGVjWydkZWZhdWx0LXV3dGFibGUnXSA9IFRydWUKICAg
ICB0c3BlY1snZHluYW1pYy1saW5raW5nJ10gPSBUcnVlCiAgICAgdHNwZWNbJ2V4ZWN1dGFibGVz
J10gPSBUcnVlCi0tIAoyLjQ3LjMKCg==

--1Ugscv74l3mMMkScwo4n--

