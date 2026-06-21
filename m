Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CFCCD98F0
	for <webhook@archiver.kernel.org>; Sun, 21 Jun 2026 21:19:52 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30867.1782076787966939053
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 21 Jun 2026 14:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=KhFbXN8g;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.17, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782076786; x=1782335986;
	bh=LG9AZkxvXTFnTjXZ96Dh/dpZtzYuqlxLTjvJpQwnbl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KhFbXN8gzehHWgF1AByDj9u2Kc74yWFPEkx1fSVO5coOps9uxQfuml6hywNP59guW
	 JDDvuCLyMafB0pEkt1MewPk2aIueMSrd8PJqsL+aOrw/RbVinX0h3VEsyA7b2JQeDe
	 bAGjfiCtjiIBMzYdxlJiEPbjq8u3hSmv3YgI7YvtJ+BBryZWPJqfVIYuu3EBGUfPld
	 sokkfCnCB5/v9a2b3gWM1eT3BA8WK6aife5tAlMBsrTO6hDF+V10NF2+lc77pSuN4l
	 W7hfANYVsx5rrE5gKgIil1WY9jqM2HrDogo6CevSDMCAvvBn05hdPDllVZzvUN1z+B
	 Plqh8X+JM7B9Q==
Date: Sun, 21 Jun 2026 21:19:41 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 2/2] rock-4d: add initial support
Message-ID: <20260621211915.72650-3-sputnik@on-the-web.ch>
In-Reply-To: <20260621211915.72650-1-sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: db9c367fddcfdcc51c79b735d3556a24f2d67f0f
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------85320c92b278c0f2d90eb3dda5296389fb7b447e0ddfb65f9e5e96322f97817f"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Jun 2026 21:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4254

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------85320c92b278c0f2d90eb3dda5296389fb7b447e0ddfb65f9e5e96322f97817f
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 2/2] rock-4d: add initial support
Date: Sun, 21 Jun 2026 23:19:13 +0200
Message-ID: <20260621211915.72650-3-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621211915.72650-1-sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
numerous top-tier functions, features, and expansion options.

Equipped with the Rockchip RK3576 SoC, the ROCK 4D boasts an octa-core
CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 MC3 GPU, and a 6 TOPS NPU,
making it ideal for AI and multimedia tasks.

	http://radxa.com/products/rock4/4d

tech specs:
- Rockchip RK3576 (4x Arm Cortex-A72 + 4x Cortex-A53)
- Arm Mali-G52 MC3 GPU
- DDR5 RAM (2/4/8/16 GB)
- uSD, eMMC/UFS module connector
- GbE
- 1x USB-C (power delivery only)
- USB 3.0: 1x Type-A HOST, 1x Type-A OTG/HOST
- USB 2.0: 2x Type-A HOST
- 1x HDMI 2.1
- 1x MIPI CSI camera port
- 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)

The ROCK 4D is the only board of the Rock 4 series using the new RK3576
SoC instead of the RK3399 used in the rest of the Rock 4x serie.

NOTES:
Due to the RK3576 boot ROM limitations, the bootloader cannot be
loaded=20
from the SD card; it must be extracted from the wic image and
flashed to the SPI flash. The kernel and rootfs then boot from the SD
card. See the "rk3576 booting" note in the README for details.

Ethernet is only partially working, mostly in degraded 100 or even 10
Mbps mode or sometimes not at all. Investigations are still ongoing and
if found a fix will be submitted in a future patch.

Wifi is not yet working, requires an out-of-tree kernel driver. Work on
this will be done on a separate future patch.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 README                                  | 17 +++++++++++++++++
 conf/machine/rock-4d.conf               | 11 +++++++++++
 recipes-kernel/linux/linux-rockchip.inc |  1 +
 3 files changed, 29 insertions(+)
 create mode 100644 conf/machine/rock-4d.conf

diff --git a/README b/README
index c2697d1..8192284 100644
--- a/README
+++ b/README
@@ -39,6 +39,7 @@ Status of supported boards:
 			roc-rk3328-cc
 			roc
k-3a
 			rock-4c-plus
+			rock-4d
 			rock-5a
 			rock-5b
 			rock-pi-4a
@@ -122,6 +123,22 @@ Notes:
=20
 	in the configuration (e.g. conf/local.conf).
=20
+  rk3576 booting:
+	The RK3576 boot ROM cannot load the bootloader from the SD card.
+	For rk3576-based boards (e.g. the rock-4d) the bootloader must be
+	extracted from the wic image and flashed to the SPI flash; the
+	kernel and rootfs then boot from the SD card.
+
+	To extract the SPI bootloader region (first 16 MiB) from a wic
+	image:
+
+		dd if=3D<image>.wic of=3Dspi.bin bs=3D1M count=3D16
+
+	Then flash spi.bin to the SPI flash, e.g. with rkdeveloptool
+	from a host PC with the board in Maskrom mode; see the board
+	vendor's documentation for details:
+		https://docs.radxa.com/en/rock4/rock4d/low-level-dev/spi_flash
+
   A/B updates with RAUC
 	This layer now contains one example of building an A/B update using RAU=
C.
 	Users are free to use/test this example, to optionally enable it, to bu=
ild
diff --git a/co
nf/machine/rock-4d.conf b/conf/machine/rock-4d.conf
new file mode 100644
index 0000000..c32e4f9
--- /dev/null
+++ b/conf/machine/rock-4d.conf
@@ -0,0 +1,11 @@
+#@TYPE: Machine
+#@NAME: Radxa Rock 4D
+#@DESCRIPTION: ROCK4D is the latest SBC of serie 4 based on the RK3576 S=
oC
+#https://radxa.com/products/rock4/4d
+
+require conf/machine/include/rk3576.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3576-rock-4d.dtb"
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+UBOOT_MACHINE =3D "rock-4d-rk3576_defconfig"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/lin=
ux/linux-rockchip.inc
index 6c62e84..f666283 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -23,6 +23,7 @@ COMPATIBLE_MACHINE:roc-rk3308-cc =3D "roc-rk3308-cc"
 COMPATIBLE_MACHINE:roc-rk3328-cc =3D "roc-rk3328-cc"
 COMPATIBLE_MACHINE:rock-3a =3D "rock-3a"
 COMPATIBLE_MACHINE:rock-4c-plus =3D "rock-4c-plus"
+COMPATIBLE_MACHINE:rock-4d =3D "rock-4d"
 COM
PATIBLE_MACHINE:rock-5a =3D "rock-5a"
 COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"
 COMPATIBLE_MACHINE:rock-pi-4 =3D "rock-pi-4"

--------85320c92b278c0f2d90eb3dda5296389fb7b447e0ddfb65f9e5e96322f97817f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmo4VWwJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdKZwdr1e6xPsmZw6CJ2e71FiEEJgeVlthQxcLg
gu1biK762GoqUA8AAJdkAQDRqis/jWK8dhAJBGr/yptfQPZcCcq4ni3npBQW
JVvBPQD/Zyf4+3Q6ruohLdA5Add6unHAaz54Zr39QdOQhD8HrAU=
=ErE+
-----END PGP SIGNATURE-----


--------85320c92b278c0f2d90eb3dda5296389fb7b447e0ddfb65f9e5e96322f97817f--


