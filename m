Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40255.1795607233536469712
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 03:47:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DeqUlC4B;
 spf=pass (domain: gmail.com, ip: 74.125.224.53, mailfrom: deepakdas.linux@gmail.com)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67df3b1ca06so6337314d50.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 03:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795607232; cv=none;
        d=google.com; s=arc-20260327;
        b=VVfVByQjRThwn1JQQrrrxHEY3x+Rda+kqhCxIvsDBhCgzD3+w3WjCb+RcNVcqMB8PF
         eqdd/fFT7rAK2Mffo860HYgOVB5kh1Oc0WhWK3keDIZmuvJlQqW0qGnaM4riLdKbXq09
         mLf1C5Bt5DsBK1TNxpew0WoHHgDT17+r0C7NFznZl5DMv8bgO0U4vPliRD7BxGzc0VGo
         qS+hWBh6QX+JxNhPTgMDyygCpAN0nFyoSZG2GQt+v0gZwSGS7/BlJrEqQjZMzpe1W3mt
         ljgGKQ5HEK4hQtbnfkGbWf6iD6dQCi2q5yYYx+C4AqLgOmdIeajmfggtIPUXqpwZFrdw
         k5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rllm1HcHzrrKNkQQbMFbtfLEoTispU5e7kXYFiO02GE=;
        fh=ft/l+YB3Ihpx0eiqUN2cv3vDHTVDdf2i1BKfJzl+Bbs=;
        b=cqlt8TEt6aBS2wNpeVNSBbo/AuBBdZSiuJUzFGm8O+GU5ZPUROdY5cHotsQ8ffJfkN
         YUqEq7oopmAshmcqRRK2vTqj0E8FgfiK3VY/7RY/p84c87RYBUkJUsnJ06NRk+dHO82v
         fX1o/1tXOKa1N9XxCq1ZL+C77qkAx/vNsE+GmzqMMF/8qcnADAHlrpE/hZsWXps//XMf
         OUx5iXT4B3MulOBXi9ZypdX7IwLWEmkdCMT/PoO5KY1mS0/JFYHrBvlpSqI9Kt4WD9GA
         1yGZxWObX/PPr7zoN6r6nICvCsshE1P3vApAqxGfOC04TdaUX33AyYhUvJAoOol2Pt/+
         BoOA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607232; x=1796212032; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rllm1HcHzrrKNkQQbMFbtfLEoTispU5e7kXYFiO02GE=;
        b=DeqUlC4B7/M9S67JO+BDDIv2NhsubtZXJWVkyBsHLtXpKahQq56gl8G60nGfBI4oqq
         mz/DFc4P/qe8G4QBtsfiHH5KiV+Sx/XqUQi+Ibs2G4CdoTAqTXKVg7aQweRVuFS/FvCs
         PLutoJ8tbhC5W1kqI7RJd3gf8QFOeFq2cWDueMlE3eZpbzMllxsNSvge/Lojt+Lh0oyP
         PRFs6vegbQ5/dO5WPQZWmyE8cHIuzhptLx1Edror2klB/FUCPzO+I7fh2mCafmiEDjEx
         Kl1aHGfBfi3l+vKLtad9hCFap1YtFg9nXWPaFo6GFLzYph19AGiCFTkRwTd9QS76FPhK
         EcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607232; x=1796212032;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rllm1HcHzrrKNkQQbMFbtfLEoTispU5e7kXYFiO02GE=;
        b=Uuko7OonNycpPrI92BC3k4rLCynMtCfSxXc2rynrNX9jpxDqhLNPK+1QnchyzaTS0M
         Ionh3l8C3tdGjNRgF9o1PG2nO8W6AsPslLz6zIHCvTlWAlzCHU5TZy478PGLWnT6LIF+
         sl2bNpYhIsurYOfWPEddGHj/EDeHhtTBz+eFi20WO4HQVBTaqriVizdSdRsrcOiSxmIQ
         g5DmjdMFIE5jS9PswX3qml/wCHky+xBbwXBJhEXPKKx8QwUr1e/0AHDVdObcf38hCrgr
         6ko2QWyWXcXA7JoztNicAogU+bprFLfITP/Xp99LZSMITi/yGIEYebmj+SCG7W2qXnvc
         Bv2A==
X-Gm-Message-State: APuU4Z9H6QM/GWvbK5zeu7VDF5VZZUOLDxBnGR27VX10qZsDkYMoJjzL
	mO8BTe1ienuT6bfMUakgWNwK1V7ES0RhoSK2XxO4FCJRU+mXlw4fKNH6z4+FTFNSj1IsL48bZ+C
	xcn/8ocAQqXPPVTDj/B69RqVgaRYImhVzBfspEfY=
X-Gm-Gg: AZFdTZeMTuCMi4d0GTxKx3Rx6KYuVxvh9mlNuL32bWof7ZW6UuRehQqFM1yfrVo8D8i
	aTgPDAg+prGY4C0LPw6UVw6eGvLtThf94MB0rccWVVqjqTPdDxKIf8qTq1uQIUyaRS2srBmXilo
	rXjDFRUrfwG7JHVVkachXijKBYe041ClN/25LdLO8n92vdzYYmJU3oZZwtjNbPZlGPCzZ7y8tJC
	E1DatFVL2yCHn7Mtq0vSiPWV7edKvfDgaTkN3yhE4zRZN2TrWx0ZDwBAU/vSm4Uzal7+ZQ6teIi
	BN0reStDrsPOCDwCLAbyI9K6Chl89zzPudud5aEUIiSL9gzMU5u+MveqFGBrvcioHVKZE01eSIP
	dDn/1axlyWHB8WkeyVptYnUDLqZP8ByO/w6DF
X-Received: by 2002:a05:690e:a4f:b0:672:964b:f071 with SMTP id
 956f58d0204a3-67df44b3ca6mr7762443d50.94.1795607232380; Wed, 25 Nov 2026
 03:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20261124052240.1121147-1-deepakdas.linux@gmail.com> <0e03c7b8-52ec-443d-839b-76a466d40810@cherry.de>
In-Reply-To: <0e03c7b8-52ec-443d-839b-76a466d40810@cherry.de>
From: Deepak Das <deepakdas.linux@gmail.com>
Date: Wed, 25 Nov 2026 17:16:59 +0530
X-Gm-Features: Aa3M54q8BJefkaEXTCMFXNVwZLOGQhtrQaKEQQFqKD7ZO4SIJlq69EahZW9c4Ts
Message-ID: <CADkO9SPOW_v84L_VB-W+8UGpRSx2JNSS8AV6-wDsCsOL6mgU_Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] nanopc-t4: add
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 11:47:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5515

On Tue, 24 Nov 2026 at 15:21, Quentin Schulz via yocto-patches
<quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
>
> Hi Deepak,
>
> On 11/24/26 6:22 AM, Deepak Das via yocto-patches wrote:
> > [You don't often get email from deepakdas.linux=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > The FriendlyElec NanoPC-T4 is an RK3399 SBC with 4GB LPDDR3 RAM and
> > 16GB onboard eMMC.
> >
> > Documentation page:
> > https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
> >
> > Specs:
> > - Rockchip RK3399
> > - Dual-Core Arm Cortex-A72 + Quad-Core Arm Cortex-A53
> > - Arm Mali T860MP4 GPU
> > - 4GB LPDDR3 RAM
> > - 16GB eMMC
> > - 1x Micro SD Card Slot
> > - 1x M.2 M-Key (4-lane PCIe 2.1)
> > - 1x Gigabit Ethernet
> > - 802.11ac WiFi and Bluetooth
> > - 1x USB3 Type-C, 2x USB3 HOST, 1x USB2 HOST
> > - 1x HDMI 2.0, 1x eDP, 1x MIPI DSI, 2x MIPI CSI
> > - 40-pin GPIO header
> > - Debug UART at 1500000 baud
> > - 12V DC input
> >
> > Upstream U-Boot (nanopc-t4-rk3399_defconfig) and the upstream kernel
> > device tree (rk3399-nanopc-t4.dts) are used.
> >
> > Tested on scarthgap by building core-image-base and booting the wic
> > image from the SD card to a login prompt. On master, u-boot and
> > linux-yocto build successfully for this machine.
> >
> > AI-Generated: Claude Code, Opus 5.5
> > Signed-off-by: Deepak Das <deepakdas.linux@gmail.com>
> > ---
> >   README                                  |  1 +
> >   conf/machine/nanopc-t4.conf             | 11 +++++++++++
> >   recipes-kernel/linux/linux-rockchip.inc |  1 +
> >   3 files changed, 13 insertions(+)
> >   create mode 100644 conf/machine/nanopc-t4.conf
> >
> > diff --git a/README b/README
> > index c2697d1..3d8c568 100644
> > --- a/README
> > +++ b/README
> > @@ -25,6 +25,7 @@ Status of supported boards:
> >                          vyasa-rk3288
> >
> >                  64-bit:
> > +                       nanopc-t4
> >                          nanopc-t6
> >                          nanopi-m4
> >                          nanopi-m4-2gb
> > diff --git a/conf/machine/nanopc-t4.conf b/conf/machine/nanopc-t4.conf
> > new file mode 100644
> > index 0000000..20c47d3
> > --- /dev/null
> > +++ b/conf/machine/nanopc-t4.conf
> > @@ -0,0 +1,11 @@
> > +#@TYPE: Machine
> > +#@NAME: NanoPC-T4
> > +#@DESCRIPTION: NanoPC-T4 RK3399 board from FriendlyElec, 4GB LPDDR3
> > +#https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
> > +
> > +require conf/machine/include/rk3399.inc
> > +
> > +MACHINE_FEATURES += "usbhost serial"
> > +
> > +KERNEL_DEVICETREE = "rockchip/rk3399-nanopc-t4.dtb"
> > +UBOOT_MACHINE = "nanopc-t4-rk3399_defconfig"
>
> question: any reason for not including
>
> MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
>
> I'm assuming this would help in case the default Linux kernel config has
> modules that would be of interest for the board?
>
> Otherwise, looks good to me.
>
> Cheers,
> Quentin
>
Hi Quentin,

Thanks for the review. I based the machine on nanopi-m4, which is the
one RK3399 machine without it. I have a nanopi-m4 but it is broken at
the moment so could not verify why it is omitted there. Sent v2 with
MACHINE_EXTRA_RRECOMMENDS += "kernel-modules", built and boot-tested
on master and it shows all the modules in lsmod.

Thanks & regards,
Deepak
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5501): https://lists.yoctoproject.org/g/yocto-patches/message/5501
> Mute This Topic: https://lists.yoctoproject.org/mt/122424943/10762485
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15596334/10762485/93709656/xyzzy [deepakdas.linux@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
