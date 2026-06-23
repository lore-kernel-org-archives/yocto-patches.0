Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A1CDB471
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 22:21:03 +0000 (UTC)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32728.1782253256103679171
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 15:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail2 header.b=uCVdPMrF;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.116, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782253253; x=1782512453;
	bh=ClxUzZ9myUPSWOSOQ+kw9H7hpHojEYeMlU+/Tj9UEY4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uCVdPMrFNNbgod8GGe+mfDrEWKWUJHjdzR/ZtSn5MpJCJAhop20zJYflLIBtrO71G
	 aztL23GpZueWUs5Y2wxBE/K0SUUkPaGDdjM3RQItMIxeI03nMYSMF8h9jzHERi54lu
	 Cx7d9jqgbBJvR3Sd7FDub0/ngb9THSuHsaui4bl82vVqS2jVirbFDhEuL4We9neA90
	 PHmg09A5ulD9qyEw+AnkTCJvhvRWEBKHc3O50G+MVltiFw2Y9NQpj5ehx1/z72NqEB
	 SnXVP9aZeDXkwzA8Emd/6vFRGo9bDIJWD99G9j5f1iaIcRNLDTSX9Ls6hRqoFUuOXt
	 OxhOq9BYsAwpw==
Date: Tue, 23 Jun 2026 22:20:50 +0000
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
From: Martin Herren <sputnik@on-the-web.ch>
Subject: Re: [yocto-patches] [rockchip][PATCH 2/2] rock-4d: add initial support
Message-ID: <fkPPtH1stRXArMl2K_un7dTDIpVqe0Wm0h9oxrPPv1LJFcZima0E_Pl2IDfe-vORdVazaPLAYSQbGrPDiyMnqLRzYb7TL-Fjwr1F-le3Icg=@on-the-web.ch>
In-Reply-To: <ea1a1238-4662-4be0-a177-8728d01eeeab@cherry.de>
References: <20260621211915.72650-1-sputnik@on-the-web.ch> <20260621211915.72650-3-sputnik@on-the-web.ch> <ea1a1238-4662-4be0-a177-8728d01eeeab@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 2f562d5f15e6b0cdf10996c6607431fc5f516466
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------2b7424b9e06ae902dd44720deeb1858f9417858419dcd49a3c39bde1d312845d"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 22:21:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4286

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2b7424b9e06ae902dd44720deeb1858f9417858419dcd49a3c39bde1d312845d
Content-Type: multipart/mixed;boundary=---------------------fe01dac01bb4aa0974b4a7bad0f39fd2

-----------------------fe01dac01bb4aa0974b4a7bad0f39fd2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Quentin,

On Monday, June 22nd, 2026 at 7:19 PM, Quentin Schulz via lists.yoctoproje=
ct.org <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Martin,
> =


> On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> > From: Martin Herren <sputnik@on-the-web.ch>
> >
> > The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
> > numerous top-tier functions, features, and expansion options.
> >
> > Equipped with the Rockchip RK3576 SoC, the ROCK 4D boasts an octa-core
> > CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 MC3 GPU, and a 6 TOPS NP=
U,
> > making it ideal for AI and multimedia tasks.
> >
> > 	http://radxa.com/products/rock4/4d
> >
> > tech specs:
> > - Rockchip RK3576 (4x Arm Cortex-A72 + 4x Cortex-A53)
> > - Arm Mali-G52 MC3 GPU
> > - DDR5 RAM (2/4/8/16 GB)
> > - uSD, eMMC/UFS module connector
> > - GbE
> > - 1x USB-C (power delivery only)
> > - USB 3.0: 1x Type-A HOST, 1x Type-A OTG/HOST
> > - USB 2.0: 2x Type-A HOST
> > - 1x HDMI 2.1
> > - 1x MIPI CSI camera port
> > - 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> >
> > The ROCK 4D is the only board of the Rock 4 series using the new RK357=
6
> > SoC instead of the RK3399 used in the rest of the Rock 4x serie.
> >
> > NOTES:
> > Due to the RK3576 boot ROM limitations, the bootloader cannot be
> > loaded
> > from the SD card; it must be extracted from the wic image and
> > flashed to the SPI flash. The kernel and rootfs then boot from the SD
> > card. See the "rk3576 booting" note in the README for details.
> >
> =


> I'm confused, if it doesn't work, what is the purpose of using Jonas's
> U-Boot fork?

With Jonas' fork it works when flashed to the SPI. With upstream it won't =
work, neither on SD nor SPI.

> > Ethernet is only partially working, mostly in degraded 100 or even 10
> > Mbps mode or sometimes not at all. Investigations are still ongoing an=
d
> > if found a fix will be submitted in a future patch.
> >
> > Wifi is not yet working, requires an out-of-tree kernel driver. Work o=
n
> > this will be done on a separate future patch.
> >
> > Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> > ---
> >   README                                  | 17 +++++++++++++++++
> >   conf/machine/rock-4d.conf               | 11 +++++++++++
> >   recipes-kernel/linux/linux-rockchip.inc |  1 +
> >   3 files changed, 29 insertions(+)
> >   create mode 100644 conf/machine/rock-4d.conf
> >
> > diff --git a/README b/README
> > index c2697d1..8192284 100644
> > --- a/README
> > +++ b/README
> > @@ -39,6 +39,7 @@ Status of supported boards:
> >   			roc-rk3328-cc
> >   			roc
> > k-3a
> >   			rock-4c-plus
> > +			rock-4d
> >   			rock-5a
> >   			rock-5b
> >   			rock-pi-4a
> > @@ -122,6 +123,22 @@ Notes:
> >
> >   	in the configuration (e.g. conf/local.conf).
> >
> > +  rk3576 booting:
> > +	The RK3576 boot ROM cannot load the bootloader from the SD card.
> =


> The datasheet claims otherwise.
> =


> It could simply be that the board doesn't allow you to select booting
> from SD card first. On RK35xx family, the SARADC channel 0 is used by
> the BootROM to select which devices to try loading the bootloader from.
> I'm thinking either you already have something valid on SPI and/or
> eMMC/UFS and the board starts from there, or the board is configured in
> such a way that the ADC selects a configuration for which the BootROM
> will not attempt to load from SD card. I don't have a reference design
> for the RK3576 and Radxa's schematics for the Rock4D don't provide this
> table so your guess is as good as mine as to which values select which
> devices. There's some weird circuitry on Rock4D schematics though on
> that channel, c.f. page 11.

Yes it is strange. The board ships with with the vendor's bootloader alrea=
dy flashed in the SPI.
This is different from like the Rock 5B with a rk3588 where the board come=
s with empty SPI. Flashing the bootloader is only needed when booting from=
 NVMe for example on the 5B.

With the 4D the preinstalled vendor bootloader already crashes when parsin=
g the GPT from the Yocto image.
Erasing the SPI won't boot, neither with the vendor bootloader nor upstrea=
m nor Jonas' on the SD card.
So it seems it can only boot from SPI.

Didn't try with an UFS, don't have any. eMMC seems mutualy exclusive with =
the SPI according to Radxa on their support forum.

> > +	For rk3576-based boards (e.g. the rock-4d) the bootloader must be
> > +	extracted from the wic image and flashed to the SPI flash; the
> > +	kernel and rootfs then boot from the SD card.
> > +
> > +	To extract the SPI bootloader region (first 16 MiB) from a wic
> > +	image:
> > +
> > +		dd if=3D<image>.wic of=3Dspi.bin bs=3D1M count=3D16
> > +
> =


> Please just make sure idbloader.img and u-boot.itb are in the deploy
> directory (or even better, u-boot-rockchip-spi.bin which contains both
> with u-boot.itb at the right offset already) and tell the user to flash
> those binaries on SPI at a specific offset. I believe you're also
> copying the partition table, which doesn't make sense on the SPI flash
> (at least not that partition table since there's for sure not enough
> room for the full system on it).

That's sounds much cleaner, will need to look how to do it. Having a clean=
 u-boot-rockchip-spi.bin would be useful for some other boards like the Ro=
ck 5B as wel.

> > +	Then flash spi.bin to the SPI flash, e.g. with rkdeveloptool
> > +	from a host PC with the board in Maskrom mode; see the board
> > +	vendor's documentation for details:
> =


> Missing newline.

Added

> > +		https://docs.radxa.com/en/rock4/rock4d/low-level-dev/spi_flash
> > +
> =


> The "code" changes are fine.
> =


> Cheers,
> Quentin

Cheers,

Martin

> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4264): https://lists.yoctoproject.org/g/yocto-patche=
s/message/4264
> Mute This Topic: https://lists.yoctoproject.org/mt/119915817/10317775
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/150570=
71/10317775/2038727303/xyzzy [sputnik@on-the-web.ch]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
-----------------------fe01dac01bb4aa0974b4a7bad0f39fd2--

--------2b7424b9e06ae902dd44720deeb1858f9417858419dcd49a3c39bde1d312845d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmo7BrQJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeqtV8LIjnLtulzly46i5i8SgjnNnBo9bDzKFNg
iCjtTxYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAABKkAD8D8Yb2XE8wd3WAqg/
MQ64HBtXMBs/EJCY5S6ZY+JyNVgBAMDOCf0oBOJbdrhZd8ceFw0JSjbtaeo2
uryYRDetWoMD
=kedd
-----END PGP SIGNATURE-----


--------2b7424b9e06ae902dd44720deeb1858f9417858419dcd49a3c39bde1d312845d--


