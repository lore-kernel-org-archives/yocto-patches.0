Return-Path: <Nicholas.Lowell@lexmark.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C091C369A6
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:43 +0000 (UTC)
Subject: Re: [meta-zephyr][PATCH] zephyr-core/zephyr-kernel: specify newlib capability with cross-compile toolchain
To: yocto-patches@lists.yoctoproject.org
From: "Nicholas Lowell" <Nicholas.Lowell@lexmark.com>
X-Originating-Location: US (74.110.238.139)
X-Originating-Platform: Windows Chrome 134
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 07 Apr 2025 11:16:40 -0700
References: <d8508244-5fac-4264-8b10-e65ffb6db329@gmail.com>
In-Reply-To: <d8508244-5fac-4264-8b10-e65ffb6db329@gmail.com>
Message-ID: <6565.1744049800147581135@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="hQOSKwz3Am5di5OpJdPc"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 18:16:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1296

--hQOSKwz3Am5di5OpJdPc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If you look in zephyr source, in the cmake/toolchain folder, you will see t=
hat the TOOLCHAIN_HAS_NEWLIB cmake variable was set for each toolchain, eit=
her true or false, except for cross-compile.=C2=A0 By this convention, I wo=
uld say any creation/use of a cross-compile toolchain, like the one created=
 by meta-zephyr, should be setting this variable.=C2=A0 So really, it's a q=
uestion of whether it should be true or false.=C2=A0 Since newlib is availa=
ble to be used, then we must set the variable to true.=C2=A0 Otherwise, it'=
s not possible to build with newlib--there will be compile errors.=C2=A0 TO=
OLCHAIN_HAS_NEWLIB is just a gatekeeper for whether newlib can be used to b=
uild or not.

As to your question about size, zephyr-philosophers saw a 42 byte increase =
in ELF file size.=C2=A0 This is most likely from the added #define CONFIG_N=
EWLIB_LIBC_SUPPORTED 1 in autoconf.h, which should be there and is, again, =
required in order for CONFIG_NEWLIB_LIBC=3Dy, when desired.

--hQOSKwz3Am5di5OpJdPc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>If you look in zephyr source, in the cmake/toolchain folder, you will =
see that the TOOLCHAIN_HAS_NEWLIB cmake variable was set for each toolchain=
, either true or false, except for cross-compile.&nbsp; By this convention,=
 I would say any creation/use of a cross-compile toolchain, like the one cr=
eated by meta-zephyr, should be setting this variable.&nbsp; So really, it'=
s a question of whether it should be true or false.&nbsp; Since newlib is a=
vailable to be used, then we must set the variable to true.&nbsp; Otherwise=
, it's not possible to build with newlib--there will be compile errors.&nbs=
p; TOOLCHAIN_HAS_NEWLIB is just a gatekeeper for whether newlib can be used=
 to build or not.</div>
<div>&nbsp;</div>
<div>As to your question about size, zephyr-philosophers saw a 42 byte incr=
ease in ELF file size.&nbsp; This is most likely from the added #define CON=
FIG_NEWLIB_LIBC_SUPPORTED 1 in autoconf.h, which should be there and is, ag=
ain, required in order for CONFIG_NEWLIB_LIBC=3Dy, when desired.</div>

--hQOSKwz3Am5di5OpJdPc--

