Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F2CDB46F
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 12:16:54 +0000 (UTC)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19730.1782217008712400866
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 05:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail2 header.b=ZsrvukMM;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.96, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782217005; x=1782476205;
	bh=W9nkMzzZsZcJnn3v8kM+RvGJ3kOttWV7dA442FAyxjw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZsrvukMM0bV4OLpKXGMGJ6dWFuBzJy/nZ1+6wi+c0nS9fpn4yM3PVNV745j+lClsK
	 Eu/sGf2AEoHiNZRFkoo0VFeneBw3/JBBNdZSVVnrl7PbaJpelOGjCeK+BTTmqI/Pj+
	 VX/KehGIcNq39OW42qUU8+76W3UwoQhGf5i0968HHnG3wnN3ilzxpsfYcki2vM0b8I
	 yMW/VTCIaOQiSrqB0rMMaJkfaTQgH0p+teHGK1NhOrw9qj5MVPEyd7zirLwrCY0rNS
	 E8I2DQFCbBbosQRk5Z8dTTvPydlIA18lQZRzO9Io8uReQ4s3jygsznPLkXO3tjSXSO
	 p3HaNMyQxcAdA==
Date: Tue, 23 Jun 2026 12:16:42 +0000
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
From: Martin Herren <sputnik@on-the-web.ch>
Subject: Re: [yocto-patches] [rockchip][PATCH 1/2] rk3576: add initial support
Message-ID: <Pq9-9AjU_eNySwkfd928TgfA7sjgmLxhBfF5DyJsQvov-HfOOIUirWuTCsRJND4WsDiLRfuUvqQK-4Q86-ugykRbeT0qcfWW50gJhuKzA4A=@on-the-web.ch>
In-Reply-To: <e077695d-03a0-4910-8e3c-d8859dbda058@cherry.de>
References: <20260621211915.72650-1-sputnik@on-the-web.ch> <20260621211915.72650-2-sputnik@on-the-web.ch> <e077695d-03a0-4910-8e3c-d8859dbda058@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: d88a00786d75d2a8412baa306f36a0d968830cfb
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------79ebc1e1c1a667636cbd176594552cb627d41de6451f6184cbedcd3bd2564111"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 12:16:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4279

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------79ebc1e1c1a667636cbd176594552cb627d41de6451f6184cbedcd3bd2564111
Content-Type: multipart/mixed;boundary=---------------------a1b8b29d15717d891ce786584f459c95

-----------------------a1b8b29d15717d891ce786584f459c95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hej Quentin,

On Monday, June 22nd, 2026 at 6:58 PM, Quentin Schulz via lists.yoctoproje=
ct.org <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Martin,
> =


> On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> > From: Martin Herren <sputnik@on-the-web.ch>
> >
> > Add basic SoC support for the Rockchip RK3576 using the mainline Linux
> > kernel and Rockchip's binary TPL (DDR init), BL31 (TF-A) and BL32
> > (OP-TEE) blobs from rkbin.
> >
> =


> Did you actually boot a U-Boot with OP-TEE OS from rkbin? As far as I
> know, this isn't supported by upstream U-Boot but maybe something's
> changed /me shrugs. How did you test?

True, while I use rkbin's BL32 to build the image, it doesn't work, no OP-=
TEE support yet. Will clarify that.

> > The RK3576 is an octa-core SoC (4x Cortex-A72 + 4x Cortex-A53) with a
> > Mali-G52 MC3 GPU and a 6 TOPS NPU. It is the only currently supported
> > rk3xxx SoC with a different RAM base address, and therefore uses a
> > different UBOOT_ENTRYPOINT of 0x4a000000.
> >
> > NOTE: a bootable rk3576 currently requires a U-Boot fork. Upstream
> > U-Boot has the rk3576 SoC support and board defconfigs, but is missing=
 a
> > critical fix for a BootROM issue that prevents loading boot images fro=
m
> > SD card; see the WIP commit "rockchip: mkimage: Add rk3576 align and
> > sd-card workaround" on Kwiboo's rk3576 branch.
> > > Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> > ---
> >   conf/machine/include/rk3576.inc               | 24 +++++++++++++++++=
++
> >   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  4 ++++
> >   ...
> > /rkbin/rockchip-rkbin-optee-os_git.bb      |  4 ++++
> >   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb  |  3 +++
> >   recipes-bsp/rkbin/rockchip-rkbin.inc          |  2 ++
> >   .../trusted-firmware-a_%.bbappend             |  5 ++++
> >   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 ++++
> >   7 files changed, 47 insertions(+)
> >   create mode 100644 conf/machine/include/rk3576.inc
> >
> > diff --git a/conf/machine/include/rk3576.inc b/conf/machine/include/rk=
3576.inc
> > new file mode 100644
> > index 0000000..acb4249
> > --- /dev/null
> > +++ b/conf/machine/include/rk3576.inc
> > @@ -0,0 +1,24 @@
> > +SOC_FAMILY ?=3D "rk3576"
> =


> Please use =3D, there's no reason to override the SOC_FAMILY for any boa=
rd
> based on rk3576. If you took inspiration from RK3588S, it's because it's
> a mess with RK3588S and RK3588 being covered by the same override for
> convenience.

Yes, used rk3588(S) as a template as I believed it to be the most mature o=
n the rk35xx serie. Will fix.

> > +MACHINEOVERRIDES =3D. "rk3576:"
> =


> I don't think you need this MACHINEOVERRIDES with the SOC_FAMILY above.

Same, inherited from 3588, will remove and retest.

> > +DEFAULTTUNE ?=3D "cortexa72-cortexa53-crypto"
> > +
> > +ROCKCHIP_CLOSED_TPL ?=3D "1"
> > +
> > +require conf/machine/include/rockchip-defaults.inc
> > +require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
> > +require conf/machine/include/rockchip-wic.inc
> > +
> > +SERIAL_CONSOLES =3D "1500000;ttyS0"
> > +
> =


> Please keep this in the machine conf file, the debug output is not
> specific to the SoC and thus shouldn't be defined in the SoC include fil=
e.

Used the other SoC's includes where it is overriden at SoC level as a refe=
rence. Can move it to machine conf.

> > +KBUILD_DEFCONFIG ?=3D "defconfig"
> > +
> > +PREFERRED_PROVIDER_trusted-firmware-a
> > =3D "rockchip-rkbin-tf-a"
> =


> Can you use ?=3D here? Upstream TF-A supports RK3576 since version 2.13
> which is available in meta-arm already.

Will fix, also the next one.

> > +PREFERRED_PROVIDER_optee-os =3D "rockchip-rkbin-optee-os"
> > +
> =


> Same here. OP-TEE OS just gained support for RK3576, see commit
> bddd9f2ea837 ("plat-rockchip: add support for RK3576"). No release yet
> though so that's fine I guess.
> =


> > +UBOOT_SUFFIX ?=3D "itb"
> > +UBOOT_ENTRYPOINT ?=3D "0x4a000000"
> > +
> =


> Why this address specifically? We use 0x06000000 for all other SoCs and
> the DRAM address start at 0 for them. Considering the RK3576 starts DRAM
> at 0x40000000, why not use the same offset and have it at
> =


> 0x46000000
> =


> ?
> =


> At the same time, we default to 0x40800000 for RK3576 in upstream U-Boot
> for the load/entry properties (c.f. CONFIG_TEXT_BASE in
> arch/arm/rockchip-u-boot.dts).

Used the value of kernel_comp_addr_r taken from u-boot's include/configs/r=
k3576_common.h as a reference.
As for other boards it is also defined as 0x0a000000 in u-boot and 0x06000=
000 is used in Yocto, i will update to 0x46000000 to have a coherent offse=
t and retest.

> > +TFA_PLATFORM =3D "rk3576"
> > +TFA_BUILD_TARGET =3D "bl31"
> > +
> > +ENABLE_STATELESS_VPU_GST ?=3D "1"
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp=
/rkbin/rockchip-rkbin-ddr_git.bb
> > index 7f1e820..7427f57 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > @@ -14,6 +14,10 @@ RKBIN_BINVERS:rk3568 ?=3D "v1.23"
> >   RKBIN_BINFILE:rk3568 ?=3D "rk3568_ddr_1560MHz_${RKBIN_BINVERS}.bin"
> >   RKBIN_DEPLOY_FILENAME:rk3568 ?=3D "ddr-rk3568.bin"
> >
> > +RKBIN_BINVERS:rk3576 ?=3D "v1.09"
> > +RKBIN_BINFILE:rk3576 ?=3D "rk3576_ddr_lp4_2112MHz_lp5_2736MHz_${RKBIN=
_BINVERS}.bin"
> > +RKBIN_DEPLOY_FILENAME:rk3576 ?=3D "ddr-rk3576.bin"
> > +
> >   RKBIN_BINVERS:rk3588s ?=3D "v1.18"
> >   RKBIN_BINFILE:rk3588s ?=3D "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${RKB=
IN_BINVERS}.bin"
> >   RKBIN_DEPLOY_FILENAME:rk3588s ?=3D "ddr-rk3588.bin"
> > diff -
> > -git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/=
rkbin/rockchip-rkbin-optee-os_git.bb
> > index 0f3c927..35a102e 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > @@ -19,6 +19,10 @@ RKBIN_BINVERS:rk3568 ?=3D "${RKBIN_BINVERS_RK356x}"
> >   RKBIN_BINFILE:rk3568 ?=3D "rk3568_bl32_${RKBIN_BINVERS}.bin"
> >   RKBIN_DEPLOY_FILENAME:rk3568 ?=3D "tee-rk3568.bin"
> >
> > +RKBIN_BINVERS:rk3576 ?=3D "v1.05"
> > +RKBIN_BINFILE:rk3576 ?=3D "rk3576_bl32_${RKBIN_BINVERS}.bin"
> > +RKBIN_DEPLOY_FILENAME:rk3576 ?=3D "tee-rk3576.bin"
> > +
> >   RKBIN_BINVERS:rk3588s ?=3D "v1.19"
> >   RKBIN_BINFILE:rk3588s ?=3D "rk3588_bl32_${RKBIN_BINVERS}.bin"
> >   RKBIN_DEPLOY_FILENAME:rk3588s ?=3D "tee-rk3588.bin"
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bs=
p/rkbin/rockchip-rkbin-tf-a_git.bb
> > index ece5faa..39cc7ee 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> > @@ -21,5 +21,8 @@ RKBIN_B
> > INFILE:rk3566 ?=3D "rk3568_bl31_${RKBIN_BINVERS}.elf"
> >   RKBIN_BINVERS:rk3568 ?=3D "${RKBIN_BINVERS_RK356x}"
> >   RKBIN_BINFILE:rk3568 ?=3D "rk3568_bl31_${RKBIN_BINVERS}.elf"
> >
> > +RKBIN_BINVERS:rk3576 ?=3D "v1.15"
> > +RKBIN_BINFILE:rk3576 ?=3D "rk3576_bl31_${RKBIN_BINVERS}.elf"
> > +
> =


> We have much newer ddrbin, bl31 and bl32 in current master of rkbin,
> should we consider updating? I haven't looked at the various changelogs
> but maybe it's fixing important stuff.

Didn't look yet. Tried to be the least invasive possible so used the ones =
at the same commit as the other SoCs. Can try to override the SRC_REV for =
this SoC to get the latest and try.

> >   RKBIN_BINVERS:rk3588s ?=3D "v1.48"
> >   RKBIN_BINFILE:rk3588s ?=3D "rk3588_bl31_${RKBIN_BINVERS}.elf"
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/=
rockchip-rkbin.inc
> > index 9ddd54f..a276aa6 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > @@ -11,6 +11,7 @@ COMPATIBLE_MACHINE =3D "^$"
> >   COMPATIBLE_MACHINE:rk3308 =3D "rk3308"
> >   COMPATIBLE_MACHINE:rk3566 =3D "rk3566"
> >   COMPATIBLE_MACHINE:rk3568 =3D "rk3568"
> > +COMPATIBLE_MACHINE:rk3576 =3D "rk3576"
> >   COMPATIBLE_MACHINE:rk3588s =3D "rk3588s"
> >
> >   PACKAGE_ARCH =3D "${MACHINE_ARCH}"
> > @@ -26,6 +27,7 @@ ALLOW_EMPTY:${PN} =3D "1"
> >   RKBIN_BINDIR:rk3308 ?=3D "bin/rk33/"
> >   RKBIN_BINDIR:rk3566 ?=3D "bin/rk35/"
> >   RKBIN_BINDIR:rk3568 ?=3D "bin/r
> > k35/"
> > +RKBIN_BINDIR:rk3576 ?=3D "bin/rk35/"
> >   RKBIN_BINDIR:rk3588s ?=3D "bin/rk35/"
> >
> >   do_deploy() {
> > diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbapp=
end b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> > index 4c7fc3c..4e7265b 100644
> > --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> > +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> > @@ -7,6 +7,7 @@ COMPATIBLE_MACHINE:append:rk3328 =3D "|rk3328"
> >   COMPATIBLE_MACHINE:append:px30 =3D "|px30"
> >   COMPATIBLE_MACHINE:append:rk3566 =3D "|rk3566"
> >   COMPATIBLE_MACHINE:append:rk3568 =3D "|rk3568"
> > +COMPATIBLE_MACHINE:append:rk3576 =3D "|rk3576"
> >   COMPATIBLE_MACHINE:append:rk3588s =3D "|rk3588s"
> >
> >   # code bloats with clang and results in error below now
> > @@ -35,6 +36,10 @@ fixup_baudrate:rk3568() {
> >   	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CO=
NSOLE_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
> >   }
> >
> > +fixup_baudrate:rk3576() {
> > +	sed -i "s/#define RK_DBG_UART_BA
> > UDRATE\s\+.*/#define RK_DBG_UART_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/pl=
at/rockchip/rk3576/rk3576_def.h
> > +}
> > +
> >   fixup_baudrate:rk3588s() {
> >   	sed -i "s/#define RK_DBG_UART_BAUDRATE\s\+.*/#define RK_DBG_UART_BA=
UDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3588/rk3588_def.h
> >   }
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot=
/u-boot_%.bbappend
> > index 08e1730..ddb6fd2 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -4,6 +4,11 @@ FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> >
> >   SRC_URI:append:rk-u-boot-env =3D " file://rockchip-enable-environmen=
t-mmc.cfg"
> >
> > +SRC_URI:rk3576 =3D " \
> > +    git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protoc=
ol=3Dhttps;branch=3Drk3576 \
> > +"
> > +SRCREV:rk3576 =3D "04e6417226f50e4e3cb04272280922eb425c18ab"
> > +
> =


> This is a no, sorry.
> =


> We do not accept non-upstream fork in meta-rockchip.
> =


> And even if we did, it should be its own recipe and not piggy-backing on
> the upstream U-Boot recipe which reports a different version than the
> one in Jonas (Kwiboo)'s current branch.
> =


> Jonas may rebase at his liking and we wouldn't be able to build this
> anymore. It happened in the past and likely would again.

Was afraid this won't pass, even the same seems to have been done in the p=
ast for other boards (rock 3 ?).

> It seems you have found the commit that fixes the issue for you, so
> maybe we should include this patch on top of upstream U-Boot here as a
> ".patch" in SRC_URI. This would be acceptable to me.

I started trying only to backport the last commit, unfortunately it depend=
s on a bunch of previous ones. Thus my switching completely to this fork.
Now that it boots will try to cleanup my patch to use the upstream u-boot =
at 2026.04 with a minimal patch set. If too much, maybe worth to postpone =
this patch and wait u-boot 2026.07 and until yocto switches officially to =
it.

A quick analysis shows it might require 9 patches. The WiP patch, 6 patche=
s submitted without being merged yet and 2 already merged in upstream (not=
 in v2026.04).

> I vaguely recall this was somehow related to boost DDR blob... Jonas
> hasn't sent the patch yet to the mailing list so I'm assuming he's still
> unhappy with it (or is lacking time like most of us :) ).

Yes, the main issue is this boost.bin plus the prerequisites to bundle it =
into the image.

> Wondering if
> an update of the DDR blob from rkbin would make this work? Would this be
> something you could try? Change SRC_URI to ecb4fcbe954e ("README:
> Update" and update the version numbers for rk3576 to point at the right =
one.

Yes, this is something i can try. Although as with the latest ddr bins the=
re is still a boost available, it is probably still required.

> Cheers,
> Quentin

Cheers,

Martin
-----------------------a1b8b29d15717d891ce786584f459c95--

--------79ebc1e1c1a667636cbd176594552cb627d41de6451f6184cbedcd3bd2564111
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmo6eRoJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfreoC7cmA7JnG0dcgB/V0+brduVLO/Sd6guMqy
O8YoEhYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAABoZgEA3HjhQ0X5ZXLHgWr8
iDqMzTVNrJvq3OpDSPoy62bhZrkA+wTvAP17Q4U/SIwMWYG8BHRDY7UtXYE7
1LOket73TdoH
=LK30
-----END PGP SIGNATURE-----


--------79ebc1e1c1a667636cbd176594552cb627d41de6451f6184cbedcd3bd2564111--


