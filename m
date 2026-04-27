Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CAFFF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 05:55:05 +0000 (UTC)
Subject: Re: [meta-selinux][PATCH] mingw32-common.inc: disable meson exe wrapper for mingw targets
To: yocto-patches@lists.yoctoproject.org
From: "Rong Fu" <rong.fu.cn@windriver.com>
X-Originating-Location: KR (61.107.31.5)
X-Originating-Platform: Windows Firefox 150
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 26 Apr 2026 22:54:55 -0700
References: <20260427055125.2349479-1-rong.fu.cn@windriver.com>
In-Reply-To: <20260427055125.2349479-1-rong.fu.cn@windriver.com>
Message-ID: <1095967.1777269295310827333@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="gbZquT7pAfY2lzEbW52h"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 05:55:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3827

--gbZquT7pAfY2lzEbW52h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Reproduce steps:
1. mkdir -p <workdir>
2. cd <workdir>
3. git clone https://git.openembedded.org/bitbake
4. ./bitbake/bin/bitbake-setup init --non-interactive poky-master poky mach=
ine/qemux86-64 distro/poky
5. cd bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64
6. git clone https://git.yoctoproject.org/meta-mingw layers/meta-mingw
7. source build/init-build-env
8. bitbake-layers add-layer ../layers/meta-mingw
9. echo 'SDKMACHINE =3D "i686-mingw32"' >> conf/local.conf
10. bitbake nativesdk-dtc

--gbZquT7pAfY2lzEbW52h
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Reproduce steps:<br />1. mkdir -p &lt;workdir&gt;<br />2. cd &lt;workd=
ir&gt;<br />3. git clone https://git.openembedded.org/bitbake<br />4. ./bit=
bake/bin/bitbake-setup init --non-interactive poky-master poky machine/qemu=
x86-64 distro/poky<br />5. cd bitbake-builds/poky-master-poky-distro_poky-m=
achine_qemux86-64<br />6. git clone https://git.yoctoproject.org/meta-mingw=
 layers/meta-mingw<br />7. source build/init-build-env<br />8. bitbake-laye=
rs add-layer ../layers/meta-mingw<br />9. echo 'SDKMACHINE =3D "i686-mingw3=
2"' &gt;&gt; conf/local.conf<br />10. bitbake nativesdk-dtc</div>

--gbZquT7pAfY2lzEbW52h--

