Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B84C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 15:53:21 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.30691.1719417194110229374
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 08:53:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HDg0nlw5;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b4febddfd3so31459486d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719417192; x=1720021992; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX8fCIYtdh5fAvC7m+HiYZh3jRe4s4/ynJhF7OXKxKM=;
        b=HDg0nlw5AlXeDvJSyDZX4/1J5msOuMgA7aPZmtjud+ZhAqNlu4hjbf7Lx5qqnMUWhv
         ZyYmj4puRDEmbGXXRdABXJ6Bh68jog5HcoHi+7xIv4ZmZDGcBAI7LERWVosVefSUxwmd
         h864cJ10ATgV9FOVP02ZNwciECm1BTwO90MfJqXiD3FviDQCHmZCumybVz8iUjcD0xM/
         diMELlsuJ5VNjja0bgz2hBMGfmJdUUTR6oyMFutJusZY/ZQNjmOyGnHoYG6pTK6j+kXq
         JIp+HfdE/q2VrIvgL+tqAxGw+dQqbuW66XXq6xoQhIY0O3y8I4xiQEMh5Rm9dOUTR1dr
         bf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417192; x=1720021992;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX8fCIYtdh5fAvC7m+HiYZh3jRe4s4/ynJhF7OXKxKM=;
        b=pR/42EacZGGi7/V0tc/7CztciAXq6D3Xfw5ThZfbRjqqfJ62ItG4ZOgWH6wMMItuXA
         /8J40noyfTIssy+9LMb3NedQeU85+2OmFfWjDSHaDZC34n2f/jcAAyeI0UGyDzH1VMcP
         l22DoLCD3eFIpX9kFG7PyCVnV0zelPmvygTWwROwXI41gZXTyF6p+6YrQygjWZWPJbL1
         WXHhpS75wkb9LQ6c1am5KPJjRuVKihHdROB7c0F8pUeDXxvwW0IWweW7J2wnkJ5ij0pd
         5k1G1K/yl+Bm5d95egSe0X/a8nsOc4Altb1G6bsaBHvMFPXDhx8uLEYrgHh7oN4Ut/yI
         1xRA==
X-Gm-Message-State: AOJu0Yw0wqYkG8FtcClxVVN14bMhKYpHeMmMQArCoszlH79K9maRstnn
	TIliPOHBCE8ShoAKkYxHgyahoytZKQYQ+bcIRKQRa13QaSJo4Vc8J8IM2A==
X-Google-Smtp-Source: AGHT+IFT7aXoccG3on3hIEzFO2bZQ2SNKQxHQhiMUyb5jo2RtXFCYUeU7qj7cW0Uzt9Iyyp3p1l6pg==
X-Received: by 2002:a0c:f2c3:0:b0:6b0:7fa6:c004 with SMTP id 6a1803df08f44-6b540bf3ef1mr113486806d6.59.1719417192341;
        Wed, 26 Jun 2024 08:53:12 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30c57sm55937366d6.94.2024.06.26.08.53.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:53:11 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:53:09 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3] rauc demo: add
Message-ID: <20240626155309.GA24963@localhost>
References: <20240626135632.1623-1-twoerner@gmail.com>
 <daeccf50-cf37-4ca7-8f08-0daaccf33502@cherry.de>
 <20240626154644.GA22782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626154644.GA22782@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 15:53:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/383

On Wed 2024-06-26 @ 11:46:44 AM, Trevor Woerner wrote:
> On Wed 2024-06-26 @ 05:09:14 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > Hi Trevor,
> > 
> > On 6/26/24 3:56 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > Add an example of implementing rauc on a rockchip board. Adding the meta-rauc
> > > layer, adding 'rauc' to DISTRO_FEATURES, and enabling RK_RAUC_DEMO will build
> > > an image using the example provided in dynamic-layers/rk-rauc-demo.
> > > 
> > > This example uses a simple A/B + D scheme (i.e. two root partitions and a
> > > non-updated /data partition). Repartitioning occurs automatically on first
> > > boot thanks to systemd's 'repart' mechanism.
> > > 
> > > NOTE:
> > > - this example only works with systemd
> > > 
> > > If you wish to provide your own implementation, simply add the meta-rauc
> > > layer, add 'rauc' to DISTRO_FEATURES, don't enable RK_RAUC_DEMO, and provide
> > > your own implementation in a separate layer.
> > > 
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > > v3 changes:
> > > - change the OVERRIDE mechanism from a class to a config
> > > - fix the required features check to include an OVERRIDE
> > > - use a systemd mount unit for the /data partition
> > > - abd-partition recipe cleanup:
> > >    - remove extraneous FILESEXTRAPATHS
> > >    - remove OVERRIDES, this recipe will only be used with rauc
> > >    - remove extraneous FILES:${PN} for ${sysconfdir}
> > > 
> > > v2 changes:
> > > - add information/instructions to README
> > > - rauc-conf cleanup:
> > >    - remove ca.cert.pem from SRC_URI, it's already in parent
> > >    - rename systemd.conf.in to system.conf so the parent handles it
> > >    - process the system.conf file as a prepend, leaving it for the parent to manage
> > > - use walrus operator with THISDIR
> > > - break out the systemd repart config files into their own recipe so they can
> > >    be updated without triggering a full rebuild of systemd (and its dependents)
> > > - class cleanup:
> > >    - update the classes so they have only 1 job (each)
> > >    - rename the classes to reflect their jobs
> > >    - update recipes/configs to use the new classes
> > > ---
> > >   README                                        | 18 +++++
> > >   .../rk-rauc-demo-features-check.bbclass       |  8 ++
> > >   conf/layer.conf                               |  4 +
> > >   conf/machine/include/rockchip-rauc.inc        |  4 +
> > >   conf/machine/include/rockchip-wic.inc         |  2 +
> > >   .../recipes-bsp/u-boot/files/boot.cmd.in      | 51 ++++++++++++
> > >   .../recipes-bsp/u-boot/files/uboot-rauc.cfg   |  8 ++
> > >   .../recipes-bsp/u-boot/u-boot_%.bbappend      | 26 ++++++
> > >   .../base-files/base-files_%.bbappend          |  2 +
> > >   .../recipes-core/base-files/files/fstab       |  5 ++
> > >   .../rauc-bundles/files/development-1.cert.pem | 80 +++++++++++++++++++
> > >   .../rauc-bundles/files/development-1.key.pem  | 28 +++++++
> > >   .../rauc-bundles/rockchip-rauc-bundle.bb      | 14 ++++
> > >   .../recipes-core/rauc/files/ca.cert.pem       | 80 +++++++++++++++++++
> > >   .../recipes-core/rauc/files/system.conf       | 17 ++++
> > >   .../recipes-core/rauc/rauc-conf.bbappend      |  7 ++
> > >   .../recipes-core/systemd/abd-partition.bb     | 26 ++++++
> > >   .../systemd/files/25-rootfsA.conf             |  4 +
> > >   .../systemd/files/35-rootfsB.conf             |  7 ++
> > >   .../recipes-core/systemd/files/45-data.conf   |  6 ++
> > >   .../recipes-core/systemd/files/data.mount     | 10 +++
> > >   .../recipes-core/systemd/systemd_%.bbappend   |  3 +
> > >   22 files changed, 410 insertions(+)
> > >   create mode 100644 classes-recipe/rk-rauc-demo-features-check.bbclass
> > >   create mode 100644 conf/machine/include/rockchip-rauc.inc
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/data.mount
> > >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> > > 
> > > diff --git a/README b/README
> > > index 6003e7c652fe..8ff006e942b9 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -85,6 +85,24 @@ Notes:
> > >   	in the configuration (e.g. conf/local.conf).
> > > +  A/B updates with RAUC
> > > +	This layer now contains one example of building an A/B update using RAUC.
> > > +	Users are free to use/test this example, to optionally enable it, to build
> > > +	their own update strategies based on this one, or to ignore it completely.
> > > +	This example only works with
> > > +
> > > +		INIT_MANAGER = "systemd"
> > > +
> > > +	If you wish to use this example in your builds:
> > > +	- enable 'systemd' as your init system
> > > +	- add the meta-rauc layer to your build (with the corresponding branch)
> > > +	- add 'rauc' to your DISTRO_FEATURES
> > > +	- enable RK_RAUC_DEMO in your config
> > > +
> > > +	If you wish to implement your own RAUC update without using the example from
> > > +	this layer, perform the same steps as above except for the step enabling
> > > +	RK_RAUC_DEMO.
> > > +
> > >   U-Boot Environment:
> > >   ------------------
> > >   	In order to configure U-Boot to be able to store its environment into the
> > > diff --git a/classes-recipe/rk-rauc-demo-features-check.bbclass b/classes-recipe/rk-rauc-demo-features-check.bbclass
> > > new file mode 100644
> > > index 000000000000..946091802f8d
> > > --- /dev/null
> > > +++ b/classes-recipe/rk-rauc-demo-features-check.bbclass
> > > @@ -0,0 +1,8 @@
> > > +inherit features_check
> > > +
> > > +REQUIRED_DISTRO_FEATURES:append:rk-rauc-demo = " systemd rauc"
> > > +REQUIRED_MACHINE_FEATURES:append:rk-rauc-demo = " rk-u-boot-env"
> > > +
> > > +# 'RK_RAUC_DEMO' indicates the user wants to use the
> > > +# rauc demo configuration from this layer
> > > +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> > 
> > I don't understand why this is in a recipe bbclass, the one in
> > conf/machine/include/rockchip-rauc.inc should already be enough?
> 
> Good catch! That wasn't supposed to be there, it must have snuck in with all
> the rebasing I was doing late at night.
> 
> > [...]
> > 
> > > diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
> > > new file mode 100644
> > > index 000000000000..a6f79503076b
> > > --- /dev/null
> > > +++ b/conf/machine/include/rockchip-rauc.inc
> > > @@ -0,0 +1,4 @@
> > > +# 'RK_RAUC_DEMO' indicates the user wants to use the
> > > +# rauc demo configuration from this layer
> > > +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> > 
> > [...]
> > 
> > > +do_compile:append:rk-rauc-demo() {
> > > +	# create boot script
> > > +	sed -e 's|@@KERNEL_BOOTFILE@@|${UBOOT_EXTLINUX_KERNEL_IMAGE}|' \
> > > +	    "${UNPACKDIR}/boot.cmd.in" > "${UNPACKDIR}/boot.cmd"
> > > +	mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${UNPACKDIR}/boot.cmd" ${UNPACKDIR}/boot.scr
> > > +
> > 
> > Richard has said today he'd prefer we don't use UNPACKDIR for that kind of
> > things, c.f. https://lore.kernel.org/openembedded-core/20240623213254.3215897-1-leon.anavi@konsulko.com/T/#md4b10cea4af07c1a2e5be43e4ee8c8b1fbc6e420
> > (though we "agreed" later in the thread to use ${B} instead of the
> > originally suggested ${WORKDIR}).
> 
> Alright.

Actually... I have to do it that way so that the parent u-boot recipe picks up
this file "automatically". See the "install" line in u-boot.inc in oe-core.

Are our other uses of UNPACKDIR in meta-rockchip okay? If not I could submit
another patch to fix them up (and fixup any of the ones related to this patch
as part of a v4).

> > [...]
> > 
> > > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> > > new file mode 100644
> > > index 000000000000..4945c67345c4
> > > --- /dev/null
> > > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> > > @@ -0,0 +1,17 @@
> > > +[system]
> > > +compatible=@MACHINE@
> > > +bootloader=uboot
> > > +data-directory=/data/
> > > +
> > > +[keyring]
> > > +path=/etc/rauc/ca.cert.pem
> > > +
> > > +[slot.rootfs.0]
> > > +device=/dev/disk/by-partlabel/rootfsA
> > > +type=ext4
> > > +bootname=A
> > > +
> > > +[slot.rootfs.1]
> > > +device=/dev/disk/by-partlabel/rootfsB
> > > +type=ext4
> > > +bootname=B
> > > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> > > new file mode 100644
> > > index 000000000000..281eb2c4de91
> > > --- /dev/null
> > > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> > > @@ -0,0 +1,7 @@
> > > +inherit rk-rauc-demo-features-check
> > > +
> > > +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> > > +
> > 
> > I would recommend renaming the directory to rauc-conf here, but that's just
> > up to one's preference.
> 
> Hmm... the rauc-conf recipe is in the rauc diretory in meta-rauc so I followed
> how the parent layer was doing it. I think I prefer it this way; makes it
> slightly easier to find the thing the bbappend is appending when both the
> parent and child layers use the same directory structure.
> 
> > Looking good otherwise :)
> > 
> > Cheers,
> > Quentin
> > 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#381): https://lists.yoctoproject.org/g/yocto-patches/message/381
> > Mute This Topic: https://lists.yoctoproject.org/mt/106889680/900817
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> > 

