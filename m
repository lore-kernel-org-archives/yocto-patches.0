Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164BFCDB46F
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 11:25:13 +0000 (UTC)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18890.1782213907563025086
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 04:25:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail2 header.b=TLot3uSO;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.116, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782213903; x=1782473103;
	bh=gGYCdpLQLiWcPivshlXhbC+zXD/gRdqkcSVVJTm/ByE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TLot3uSOfaEB/zLau0tcipjk+epZXHP6I9CV2A/MlfxJN7umHEr/3BnAc9E17XPnn
	 5qpqiR4fgRtpTROkPwCUpk3I8xKl0RrflzbQyrn+1nPFeq8VnDljkGx09FtpcQno5Y
	 wZydOCnxoLId2oal95WH/CMyHPPsfgqS0+wVp1vdTir8hdOp7wQB0hd/xxUgXJlAR+
	 S+0xXY639Vw7150XxkEqHlgZnP2DyRwlSQOlIdBVH2UVwnhSETZjCIHT952fOqRAHE
	 urE2sQZizGhp/2nu0h0UZCHpmM30WdIdYxT0O4AmGnYjZqysnD7MOKwKoifyjJJUA0
	 CHq7vYIl6zneA==
Date: Tue, 23 Jun 2026 11:24:58 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>, yocto-patches@lists.yoctoproject.org, Trevor Woerner <twoerner@gmail.com>
From: Martin Herren <sputnik@on-the-web.ch>
Subject: Re: [yocto-patches] [rockchip][PATCH 0/2] rk3576: rock-4d: initial support
Message-ID: <0Fl-fE1i7o4z76GScIuFl-T1GafsC49878P0AMzTUAWk4SucCpn-457zmV_ZAutRHvsGEqBECJ25Hq4OHFNByGTQZq4yeRE4efQ5zvlNt1E=@on-the-web.ch>
In-Reply-To: <c6c70d2a-92d5-4a38-b1ff-c25337965e0f@cherry.de>
References: <20260621211915.72650-1-sputnik@on-the-web.ch> <c6c70d2a-92d5-4a38-b1ff-c25337965e0f@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: f063eb2010d84a45b00352abdb2d5b3d967001b5
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------c305e85d94169f6e738fbd61afef89656d09f17df06d9414d1e3487081571dac"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 11:25:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4278

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------c305e85d94169f6e738fbd61afef89656d09f17df06d9414d1e3487081571dac
Content-Type: multipart/mixed;boundary=---------------------f9568e3e78d75a9cc50a67d78cf91589

-----------------------f9568e3e78d75a9cc50a67d78cf91589
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Quentin,

On Monday, June 22nd, 2026 at 6:33 PM, Quentin Schulz via lists.yoctoproje=
ct.org <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Martin,
> =


> Thanks for the patches. Please note that your patches should have
> [meta-rockchip] and not [rockchip], this may be important for Trevor
> (the maintainer) to not miss your patches.
> =


> c.f. https://git.yoctoproject.org/meta-rockchip/tree/README#n261

Noted, will take this into account for the v2 submission.

> I happened to read your LinkedIn post a few days back so I was waiting
> for something to land on the ML :)
> =


> Will send reviews for the patches soon.

Many thanks for your insightful review. Will comment on your individual co=
mments. A lot will be easy to improve. Some will take longer.

Best regards,

Martin

> On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> > From: Martin Herren <sputnik@on-the-web.ch>
> >
> > rk3576: rock-4d: Add initial SoC and board support
> >
> > This series adds support for the Rockchip RK3576 SoC and the Radxa
> > Rock 4D board to meta-rockchip.
> >
> > The RK3576 is an octa-core SoC (4x Cortex-A72 + 4x Cortex-A53) with a
> > Mali-G52 MC3 GPU and a 6 TOPS NPU. The Radxa Rock 4D is the first boar=
d
> > in the Rock 4 series to use this SoC (the rest use the RK3399).
> >
> > The series is split into two commits so that the SoC infrastructure ca=
n
> > be reviewed and merged independently, providing a base for future
> > rk3576-based boards:
> >
> >    1/2: rk3576: add initial support
> >        SoC include (rk3576.inc), rkbin additions for the DDR/BL31/BL32
> >        blobs, the TF-A bbappend, and the U-Boot fork bbappend.
> >
> >    2/2: rock-4d: add initial support
> >        Board configuration (rock-4d.conf), the linux-rockchip.inc
> >        compatibility entry, and README updates (board listing + a
> >        "rk3576 booting" note documenting the SPI-flash requirement).
> >
> > KNOWN LIMITATIONS
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The u-boot fork lives on a personal contributor branch
> > (source.denx.de/u-boot/contributors/kwiboo, branch "rk3576") which
> > could be rebased or removed. The pinned SRCREV protects reproducibilit=
y
> > today, but fetch would break if the branch disappears. A versioned
> > branch name (=C3=A0 la the existing rk3xxx-2024.07 convention) may be
> > requested from Kwiboo.
> >
> > Martin Herren (2):
> >    rk3576: add initial support
> >    rock-4d: add initial support
> >
> >   README                                        | 17 +++++++++++++
> >   conf/machine/include/rk3576.inc               | 24 +++++++++++++++++=
++
> >   conf/machine/rock-4d.conf                     | 11 +++++++++
> >   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  4 ++++
> >   .../rkbin/rockchip-rkbin-optee-os_git.bb      |  4 ++++
> >   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb  |  3 +++
> >   recipes-bsp/rkbin/rockchip-rkbin.inc          |  2 ++
> >   .../trusted-firmware-a_%.bbappend             |  5 ++++
> >   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 ++++
> >   recipes-kernel/linux/linux-rockchip.inc       |  1 +
> >   10 files changed, 76 insertions(+)
> >   create mode 100644 conf/machine/include/rk3576.inc
> >   create mode 100644 conf/machine/rock-4d.conf
> >
> >
> >
> >
> >
> >
> =


> =


> =


> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4261): https://lists.yoctoproject.org/g/yocto-patche=
s/message/4261
> Mute This Topic: https://lists.yoctoproject.org/mt/119915814/10317775
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/150570=
71/10317775/2038727303/xyzzy [sputnik@on-the-web.ch]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> =


> =


> =


-----------------------f9568e3e78d75a9cc50a67d78cf91589--

--------c305e85d94169f6e738fbd61afef89656d09f17df06d9414d1e3487081571dac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmo6bPoJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdy+ms1UcMaRAcpk/+S66TrZ4yITv9LfWW/zXYX
C9a7vxYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAADQVAD/YrhEBO6CSgdLsFw0
LgAyVthce6ZeYAM7aw9eFwM1dfQBAKNnzIOiPFhQfoLeBUb92OwcqI+eago2
i3pAR41kY04H
=EqnP
-----END PGP SIGNATURE-----


--------c305e85d94169f6e738fbd61afef89656d09f17df06d9414d1e3487081571dac--


