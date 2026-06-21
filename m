Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F9CD98F2
	for <webhook@archiver.kernel.org>; Sun, 21 Jun 2026 21:19:42 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30866.1782076781377605554
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 21 Jun 2026 14:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=uJjmXsNy;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.17, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782076779; x=1782335979;
	bh=4oYA6ES1MmgyBHN8d/1ethR+6QIc1f6db82ct+B4Wkk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uJjmXsNyhK10+B4ZvZAw4VS0CMr3QoYwd0Vq1lL6Ng9D49l2bD1Dr04DK1Efk35Ki
	 5R6AYdH/GzXM5PtkZpwyuR1a4pqrF388GTuM06/gic2WPEfNnubD1hlwLgOBxqmUoP
	 GjZiukiAaf67LCzbeNTd92lhI4F+bem0uW3Xml/JMrBltCaZi6Ao0B3n7xTXN/nohY
	 YKWBXJbl8uUUP2A3/nr6h08TT5V7R5RQLCnceLaw5zMMIbf++H1oz3ug8g3ePYQ/Xn
	 DlVYA7ZVdTyypR71eWK2mLdr0zpNNG36luBm9OwapmhYfxO6eoQOma3keQi9ZWM5ic
	 yR5ql/zJZ8gig==
Date: Sun, 21 Jun 2026 21:19:34 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 1/2] rk3576: add initial support
Message-ID: <20260621211915.72650-2-sputnik@on-the-web.ch>
In-Reply-To: <20260621211915.72650-1-sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: bd52c4372afcb7aa1d6c69af89a51834ecd43e9f
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------19705ca1b1bdfbcba1bf7837163a22e7cc9c796f75d7293d2f6e7d55c3e77a8e"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Jun 2026 21:19:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4253

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------19705ca1b1bdfbcba1bf7837163a22e7cc9c796f75d7293d2f6e7d55c3e77a8e
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 1/2] rk3576: add initial support
Date: Sun, 21 Jun 2026 23:19:12 +0200
Message-ID: <20260621211915.72650-2-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621211915.72650-1-sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

Add basic SoC support for the Rockchip RK3576 using the mainline Linux
kernel and Rockchip's binary TPL (DDR init), BL31 (TF-A) and BL32
(OP-TEE) blobs from rkbin.

The RK3576 is an octa-core SoC (4x Cortex-A72 + 4x Cortex-A53) with a
Mali-G52 MC3 GPU and a 6 TOPS NPU. It is the only currently supported
rk3xxx SoC with a different RAM base address, and therefore uses a
different UBOOT_ENTRYPOINT of 0x4a000000.

NOTE: a bootable rk3576 currently requires a U-Boot fork. Upstream
U-Boot has the rk3576 SoC support and board defconfigs, but is missing a
critical fix for a BootROM issue that prevents loading boot images from
SD card; see the WIP commit "rockchip: mkimage: Add rk3576 align and
sd-card workaround" on Kwiboo's rk3576 branch.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 conf/machine/include/rk3576.inc               | 24 +++++++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  4 ++++
 ...
/rkbin/rockchip-rkbin-optee-os_git.bb      |  4 ++++
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb  |  3 +++
 recipes-bsp/rkbin/rockchip-rkbin.inc          |  2 ++
 .../trusted-firmware-a_%.bbappend             |  5 ++++
 recipes-bsp/u-boot/u-boot_%.bbappend          |  5 ++++
 7 files changed, 47 insertions(+)
 create mode 100644 conf/machine/include/rk3576.inc

diff --git a/conf/machine/include/rk3576.inc b/conf/machine/include/rk357=
6.inc
new file mode 100644
index 0000000..acb4249
--- /dev/null
+++ b/conf/machine/include/rk3576.inc
@@ -0,0 +1,24 @@
+SOC_FAMILY ?=3D "rk3576"
+MACHINEOVERRIDES =3D. "rk3576:"
+DEFAULTTUNE ?=3D "cortexa72-cortexa53-crypto"
+
+ROCKCHIP_CLOSED_TPL ?=3D "1"
+
+require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
+require conf/machine/include/rockchip-wic.inc
+
+SERIAL_CONSOLES =3D "1500000;ttyS0"
+
+KBUILD_DEFCONFIG ?=3D "defconfig"
+
+PREFERRED_PROVIDER_trusted-firmware-a=20
=3D "rockchip-rkbin-tf-a"
+PREFERRED_PROVIDER_optee-os =3D "rockchip-rkbin-optee-os"
+
+UBOOT_SUFFIX ?=3D "itb"
+UBOOT_ENTRYPOINT ?=3D "0x4a000000"
+
+TFA_PLATFORM =3D "rk3576"
+TFA_BUILD_TARGET =3D "bl31"
+
+ENABLE_STATELESS_VPU_GST ?=3D "1"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rk=
bin/rockchip-rkbin-ddr_git.bb
index 7f1e820..7427f57 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -14,6 +14,10 @@ RKBIN_BINVERS:rk3568 ?=3D "v1.23"
 RKBIN_BINFILE:rk3568 ?=3D "rk3568_ddr_1560MHz_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3568 ?=3D "ddr-rk3568.bin"
=20
+RKBIN_BINVERS:rk3576 ?=3D "v1.09"
+RKBIN_BINFILE:rk3576 ?=3D "rk3576_ddr_lp4_2112MHz_lp5_2736MHz_${RKBIN_BI=
NVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3576 ?=3D "ddr-rk3576.bin"
+
 RKBIN_BINVERS:rk3588s ?=3D "v1.18"
 RKBIN_BINFILE:rk3588s ?=3D "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${RKBIN_B=
INVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3588s ?=3D "ddr-rk3588.bin"
diff -
-git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkb=
in/rockchip-rkbin-optee-os_git.bb
index 0f3c927..35a102e 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -19,6 +19,10 @@ RKBIN_BINVERS:rk3568 ?=3D "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?=3D "rk3568_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3568 ?=3D "tee-rk3568.bin"
=20
+RKBIN_BINVERS:rk3576 ?=3D "v1.05"
+RKBIN_BINFILE:rk3576 ?=3D "rk3576_bl32_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3576 ?=3D "tee-rk3576.bin"
+
 RKBIN_BINVERS:rk3588s ?=3D "v1.19"
 RKBIN_BINFILE:rk3588s ?=3D "rk3588_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3588s ?=3D "tee-rk3588.bin"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/r=
kbin/rockchip-rkbin-tf-a_git.bb
index ece5faa..39cc7ee 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -21,5 +21,8 @@ RKBIN_B
INFILE:rk3566 ?=3D "rk3568_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_BINVERS:rk3568 ?=3D "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?=3D "rk3568_bl31_${RKBIN_BINVERS}.elf"
=20
+RKBIN_BINVERS:rk3576 ?=3D "v1.15"
+RKBIN_BINFILE:rk3576 ?=3D "rk3576_bl31_${RKBIN_BINVERS}.elf"
+
 RKBIN_BINVERS:rk3588s ?=3D "v1.48"
 RKBIN_BINFILE:rk3588s ?=3D "rk3588_bl31_${RKBIN_BINVERS}.elf"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/roc=
kchip-rkbin.inc
index 9ddd54f..a276aa6 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -11,6 +11,7 @@ COMPATIBLE_MACHINE =3D "^$"
 COMPATIBLE_MACHINE:rk3308 =3D "rk3308"
 COMPATIBLE_MACHINE:rk3566 =3D "rk3566"
 COMPATIBLE_MACHINE:rk3568 =3D "rk3568"
+COMPATIBLE_MACHINE:rk3576 =3D "rk3576"
 COMPATIBLE_MACHINE:rk3588s =3D "rk3588s"
=20
 PACKAGE_ARCH =3D "${MACHINE_ARCH}"
@@ -26,6 +27,7 @@ ALLOW_EMPTY:${PN} =3D "1"
 RKBIN_BINDIR:rk3308 ?=3D "bin/rk33/"
 RKBIN_BINDIR:rk3566 ?=3D "bin/rk35/"
 RKBIN_BINDIR:rk3568 ?=3D "bin/r
k35/"
+RKBIN_BINDIR:rk3576 ?=3D "bin/rk35/"
 RKBIN_BINDIR:rk3588s ?=3D "bin/rk35/"
=20
 do_deploy() {
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend=
 b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index 4c7fc3c..4e7265b 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -7,6 +7,7 @@ COMPATIBLE_MACHINE:append:rk3328 =3D "|rk3328"
 COMPATIBLE_MACHINE:append:px30 =3D "|px30"
 COMPATIBLE_MACHINE:append:rk3566 =3D "|rk3566"
 COMPATIBLE_MACHINE:append:rk3568 =3D "|rk3568"
+COMPATIBLE_MACHINE:append:rk3576 =3D "|rk3576"
 COMPATIBLE_MACHINE:append:rk3588s =3D "|rk3588s"
=20
 # code bloats with clang and results in error below now
@@ -35,6 +36,10 @@ fixup_baudrate:rk3568() {
 	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CONSOL=
E_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
 }
=20
+fixup_baudrate:rk3576() {
+	sed -i "s/#define RK_DBG_UART_BA
UDRATE\s\+.*/#define RK_DBG_UART_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/=
rockchip/rk3576/rk3576_def.h
+}
+
 fixup_baudrate:rk3588s() {
 	sed -i "s/#define RK_DBG_UART_BAUDRATE\s\+.*/#define RK_DBG_UART_BAUDRA=
TE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3588/rk3588_def.h
 }
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-=
boot_%.bbappend
index 08e1730..ddb6fd2 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -4,6 +4,11 @@ FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
 SRC_URI:append:rk-u-boot-env =3D " file://rockchip-enable-environment-mm=
c.cfg"
=20
+SRC_URI:rk3576 =3D " \
+    git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=3D=
https;branch=3Drk3576 \
+"
+SRCREV:rk3576 =3D "04e6417226f50e4e3cb04272280922eb425c18ab"
+
 DEPENDS:append:rk3308 =3D " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 =3D " gnutls-native"
 DEPENDS:append:rk-u-boot-env =3D " u-boot-mkenvimage-native"

--------19705ca1b1bdfbcba1bf7837163a22e7cc9c796f75d7293d2f6e7d55c3e77a8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmo4VWYJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdx0A/sIZgFYD1ATEq6wRcHFiEEJgeVlthQxcLg
gu1biK762GoqUA8AABxgAQCWDXoA+Db+3NPt/YVUmBpYdeaMHi6VB6pZ+FEb
kTplGQD/fOP4HpOauEbgtM5WXrADfI5pvVHf/hsqrHmWURpxmwo=
=x2pB
-----END PGP SIGNATURE-----


--------19705ca1b1bdfbcba1bf7837163a22e7cc9c796f75d7293d2f6e7d55c3e77a8e--


