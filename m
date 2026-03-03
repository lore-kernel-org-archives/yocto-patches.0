Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F80CEC145A
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 14:25:29 +0000 (UTC)
Subject: Re: [meta-darwin][PATCH 1/1] Add DMG and PKG SDK installers
To: yocto-patches@lists.yoctoproject.org
From: "Eric L. Hernes" <dev@qinc.tv>
X-Originating-Location: US (165.23.88.160)
X-Originating-Platform: Mac Safari 26.2
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 03 Mar 2026 06:25:19 -0800
References: <20260202165146.3727-2-dev@qinc.tv> <20260202165146.3727-3-dev@qinc.tv> <CAHUKmYZW+-5=5q8mz_NOjECnG00yuZkPg1ZQ7g07BzqQqEUzdA@mail.gmail.com>
In-Reply-To: <CAHUKmYZW+-5=5q8mz_NOjECnG00yuZkPg1ZQ7g07BzqQqEUzdA@mail.gmail.com>
Message-ID: <229771.1772547919640337612@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="KcB5Jh7pbza1gbKJKwQr"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 14:25:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3318

--KcB5Jh7pbza1gbKJKwQr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

I'm looking at these changes now.

It's interesting that I just copied the toolchain-shar-extract.sh straight =
from poky and only changed the sed references to use gsed. =C2=A0The origin=
al poky version has the same typo(s) with fsdevtype. =C2=A0Honestly, though=
, the fs_dev_type of "6969" looks highly linux specific and may be out of p=
lace on macOS entirely. =C2=A0Nonetheless, I've patched the script.

The others are cleaned up.

I also realized that the .dmg is actually an .img file. =C2=A0The relevant =
part is that a .dmg is read only. =C2=A0We need the image to be writable so=
 we can run the finalize script and sign the binaries. =C2=A0I've updated t=
hings so that it's properly called an .img file. =C2=A0I've also added a fi=
nal command to bzip2 compress it for distribution. =C2=A0It will still need=
 to be uncompressed on the macOS host, but that happens with all SDKs. =C2=
=A0It could be re-compressed back to a genuine .dmg after processing on the=
 host, but the advantages are not so clear.

I have also updated the .pkg file to use xz compression, which makes it sma=
ller as well. =C2=A0On meta-toolchain, here's what I'm seeing now:

-rwxr-xr-x 2 ubuntu ubuntu 766M Mar =C2=A02 17:59 oecore-meta-toolchain-aar=
ch64-armv8a-rk3576-pg2-toolchain-1.sh
-rw-r--r-- 2 ubuntu ubuntu 861M Mar =C2=A02 18:03 oecore-meta-toolchain-aar=
ch64-armv8a-rk3576-pg2-toolchain-1.pkg
-rw-r--r-- 2 ubuntu ubuntu 1.3G Mar =C2=A02 18:05 oecore-meta-toolchain-aar=
ch64-armv8a-rk3576-pg2-toolchain-1.img.bz2

-Eric

--KcB5Jh7pbza1gbKJKwQr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Etienne,</div>
<div>&nbsp;</div>
<div>I'm looking at these changes now.</div>
<div>&nbsp;</div>
<div>It's interesting that I just copied the toolchain-shar-extract.sh stra=
ight from poky and only changed the sed references to use gsed. &nbsp;The o=
riginal poky version has the same typo(s) with fsdevtype. &nbsp;Honestly, t=
hough, the fs_dev_type of "6969" looks highly linux specific and may be out=
 of place on macOS entirely. &nbsp;Nonetheless, I've patched the script.</d=
iv>
<div>&nbsp;</div>
<div>The others are cleaned up.</div>
<div>&nbsp;</div>
<div>I also realized that the .dmg is actually an .img file. &nbsp;The rele=
vant part is that a .dmg is read only. &nbsp;We need the image to be writab=
le so we can run the finalize script and sign the binaries. &nbsp;I've upda=
ted things so that it's properly called an .img file. &nbsp;I've also added=
 a final command to bzip2 compress it for distribution. &nbsp;It will still=
 need to be uncompressed on the macOS host, but that happens with all SDKs.=
 &nbsp;It could be re-compressed back to a genuine .dmg after processing on=
 the host, but the advantages are not so clear.<br /><br />I have also upda=
ted the .pkg file to use xz compression, which makes it smaller as well. &n=
bsp;On meta-toolchain, here's what I'm seeing now:</div>
<div>&nbsp;</div>
<div>-rwxr-xr-x 2 ubuntu ubuntu 766M Mar &nbsp;2 17:59 oecore-meta-toolchai=
n-aarch64-armv8a-rk3576-pg2-toolchain-1.sh<br />-rw-r--r-- 2 ubuntu ubuntu =
861M Mar &nbsp;2 18:03 oecore-meta-toolchain-aarch64-armv8a-rk3576-pg2-tool=
chain-1.pkg<br />-rw-r--r-- 2 ubuntu ubuntu 1.3G Mar &nbsp;2 18:05 oecore-m=
eta-toolchain-aarch64-armv8a-rk3576-pg2-toolchain-1.img.bz2<br /><br />-Eri=
c</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

--KcB5Jh7pbza1gbKJKwQr--

