Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E4C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 15:46:51 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.30682.1719416809286038006
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 08:46:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e7yjKO9M;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so22476176d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719416808; x=1720021608; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJwXHUqls3Vfpu910gjstS+D55O/0aQuf31lj2LXImI=;
        b=e7yjKO9MdaXZFhMe+Hzu9JuFmq150Y80xSm6bjISNwY57I7WVMhF8IKpC0zwyQ9Qg9
         +Ix/Emdm43gOSiZwulig/Nx7MfSebTo8ytQaifN0aPUYtZ5AgSuBLTrTMCvNmu6R86PO
         3ev1T0p5FJ5qEuISQuGgWGry0f1y9X82pkvbcKfQh6OEZwPeRaMYwFqARcbqb/M0mTxe
         FpRHClZ8JoMVOm5jlPea+dER04DAWl6X/mmvbjayBsRPYRI/hWdVP+F6ndIuSxTiP2rz
         6Kz7vL/icRfnl+Ge0n3HbEUzi6mmG6y7Ze3VOK11JgV9kfU2HRknFCoPZbPfFvTLEBuS
         cnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416808; x=1720021608;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJwXHUqls3Vfpu910gjstS+D55O/0aQuf31lj2LXImI=;
        b=Tk+0OVtYGGQ8okJ9cH09biSPs3MrWSPpQkL0QDQT1DBK/SS0orb2iMBL5nHyHppho5
         ladawlMUnHjJFtebddNb4MW2n/Q0PzDrn6j0BMyOAgZd+8qyD4ov21B+1k+1NjQimQNl
         H2cQIOLvXSWh3LML58sWG0GM8V8eC1CFDs+kd1Cui75D1JNH986tJNbXJOgMTgAT4ji+
         vMUKjDzOSlNPfQW3dfuYZ1rcHFkvQGzdTyIz9ZIM/0BVcMShbjGY9uf3leMN8xRFXdGt
         uM5pUnlMBLOapG60YzQqSPx33Fy/k4TeQFnJ0UvoBLepUlso95a9RfgwuobMVErHGP+9
         q9NA==
X-Gm-Message-State: AOJu0YzhmPuGoPYe9+lVkTFWF8T8HaG7MTb7sdOVZV48bFRt9eKZ6dqy
	MGSZd9lw2LmriVRid+mvPw/PuqYqbSq4itBP7Gm36QBKPOJjt43KHQuh3A==
X-Google-Smtp-Source: AGHT+IEHTUN/4CaWYF4reHDfcSDIM4a38nSEQmCqGf0X11AeVwcOntSagRixspw4ay6Su65l1U+3Fg==
X-Received: by 2002:a0c:e141:0:b0:6b5:832e:d999 with SMTP id 6a1803df08f44-6b58d3aed34mr1138736d6.19.1719416807214;
        Wed, 26 Jun 2024 08:46:47 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5ca8fsm55384956d6.119.2024.06.26.08.46.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:46:46 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:46:44 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3] rauc demo: add
Message-ID: <20240626154644.GA22782@localhost>
References: <20240626135632.1623-1-twoerner@gmail.com>
 <daeccf50-cf37-4ca7-8f08-0daaccf33502@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daeccf50-cf37-4ca7-8f08-0daaccf33502@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 15:46:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/382

On Wed 2024-06-26 @ 05:09:14 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/26/24 3:56 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Add an example of implementing rauc on a rockchip board. Adding the meta-rauc
> > layer, adding 'rauc' to DISTRO_FEATURES, and enabling RK_RAUC_DEMO will build
> > an image using the example provided in dynamic-layers/rk-rauc-demo.
> > 
> > This example uses a simple A/B + D scheme (i.e. two root partitions and a
> > non-updated /data partition). Repartitioning occurs automatically on first
> > boot thanks to systemd's 'repart' mechanism.
> > 
> > NOTE:
> > - this example only works with systemd
> > 
> > If you wish to provide your own implementation, simply add the meta-rauc
> > layer, add 'rauc' to DISTRO_FEATURES, don't enable RK_RAUC_DEMO, and provide
> > your own implementation in a separate layer.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > v3 changes:
> > - change the OVERRIDE mechanism from a class to a config
> > - fix the required features check to include an OVERRIDE
> > - use a systemd mount unit for the /data partition
> > - abd-partition recipe cleanup:
> >    - remove extraneous FILESEXTRAPATHS
> >    - remove OVERRIDES, this recipe will only be used with rauc
> >    - remove extraneous FILES:${PN} for ${sysconfdir}
> > 
> > v2 changes:
> > - add information/instructions to README
> > - rauc-conf cleanup:
> >    - remove ca.cert.pem from SRC_URI, it's already in parent
> >    - rename systemd.conf.in to system.conf so the parent handles it
> >    - process the system.conf file as a prepend, leaving it for the parent to manage
> > - use walrus operator with THISDIR
> > - break out the systemd repart config files into their own recipe so they can
> >    be updated without triggering a full rebuild of systemd (and its dependents)
> > - class cleanup:
> >    - update the classes so they have only 1 job (each)
> >    - rename the classes to reflect their jobs
> >    - update recipes/configs to use the new classes
> > ---
> >   README                                        | 18 +++++
> >   .../rk-rauc-demo-features-check.bbclass       |  8 ++
> >   conf/layer.conf                               |  4 +
> >   conf/machine/include/rockchip-rauc.inc        |  4 +
> >   conf/machine/include/rockchip-wic.inc         |  2 +
> >   .../recipes-bsp/u-boot/files/boot.cmd.in      | 51 ++++++++++++
> >   .../recipes-bsp/u-boot/files/uboot-rauc.cfg   |  8 ++
> >   .../recipes-bsp/u-boot/u-boot_%.bbappend      | 26 ++++++
> >   .../base-files/base-files_%.bbappend          |  2 +
> >   .../recipes-core/base-files/files/fstab       |  5 ++
> >   .../rauc-bundles/files/development-1.cert.pem | 80 +++++++++++++++++++
> >   .../rauc-bundles/files/development-1.key.pem  | 28 +++++++
> >   .../rauc-bundles/rockchip-rauc-bundle.bb      | 14 ++++
> >   .../recipes-core/rauc/files/ca.cert.pem       | 80 +++++++++++++++++++
> >   .../recipes-core/rauc/files/system.conf       | 17 ++++
> >   .../recipes-core/rauc/rauc-conf.bbappend      |  7 ++
> >   .../recipes-core/systemd/abd-partition.bb     | 26 ++++++
> >   .../systemd/files/25-rootfsA.conf             |  4 +
> >   .../systemd/files/35-rootfsB.conf             |  7 ++
> >   .../recipes-core/systemd/files/45-data.conf   |  6 ++
> >   .../recipes-core/systemd/files/data.mount     | 10 +++
> >   .../recipes-core/systemd/systemd_%.bbappend   |  3 +
> >   22 files changed, 410 insertions(+)
> >   create mode 100644 classes-recipe/rk-rauc-demo-features-check.bbclass
> >   create mode 100644 conf/machine/include/rockchip-rauc.inc
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/data.mount
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> > 
> > diff --git a/README b/README
> > index 6003e7c652fe..8ff006e942b9 100644
> > --- a/README
> > +++ b/README
> > @@ -85,6 +85,24 @@ Notes:
> >   	in the configuration (e.g. conf/local.conf).
> > +  A/B updates with RAUC
> > +	This layer now contains one example of building an A/B update using RAUC.
> > +	Users are free to use/test this example, to optionally enable it, to build
> > +	their own update strategies based on this one, or to ignore it completely.
> > +	This example only works with
> > +
> > +		INIT_MANAGER = "systemd"
> > +
> > +	If you wish to use this example in your builds:
> > +	- enable 'systemd' as your init system
> > +	- add the meta-rauc layer to your build (with the corresponding branch)
> > +	- add 'rauc' to your DISTRO_FEATURES
> > +	- enable RK_RAUC_DEMO in your config
> > +
> > +	If you wish to implement your own RAUC update without using the example from
> > +	this layer, perform the same steps as above except for the step enabling
> > +	RK_RAUC_DEMO.
> > +
> >   U-Boot Environment:
> >   ------------------
> >   	In order to configure U-Boot to be able to store its environment into the
> > diff --git a/classes-recipe/rk-rauc-demo-features-check.bbclass b/classes-recipe/rk-rauc-demo-features-check.bbclass
> > new file mode 100644
> > index 000000000000..946091802f8d
> > --- /dev/null
> > +++ b/classes-recipe/rk-rauc-demo-features-check.bbclass
> > @@ -0,0 +1,8 @@
> > +inherit features_check
> > +
> > +REQUIRED_DISTRO_FEATURES:append:rk-rauc-demo = " systemd rauc"
> > +REQUIRED_MACHINE_FEATURES:append:rk-rauc-demo = " rk-u-boot-env"
> > +
> > +# 'RK_RAUC_DEMO' indicates the user wants to use the
> > +# rauc demo configuration from this layer
> > +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> 
> I don't understand why this is in a recipe bbclass, the one in
> conf/machine/include/rockchip-rauc.inc should already be enough?

Good catch! That wasn't supposed to be there, it must have snuck in with all
the rebasing I was doing late at night.

> [...]
> 
> > diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
> > new file mode 100644
> > index 000000000000..a6f79503076b
> > --- /dev/null
> > +++ b/conf/machine/include/rockchip-rauc.inc
> > @@ -0,0 +1,4 @@
> > +# 'RK_RAUC_DEMO' indicates the user wants to use the
> > +# rauc demo configuration from this layer
> > +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> 
> [...]
> 
> > +do_compile:append:rk-rauc-demo() {
> > +	# create boot script
> > +	sed -e 's|@@KERNEL_BOOTFILE@@|${UBOOT_EXTLINUX_KERNEL_IMAGE}|' \
> > +	    "${UNPACKDIR}/boot.cmd.in" > "${UNPACKDIR}/boot.cmd"
> > +	mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${UNPACKDIR}/boot.cmd" ${UNPACKDIR}/boot.scr
> > +
> 
> Richard has said today he'd prefer we don't use UNPACKDIR for that kind of
> things, c.f. https://lore.kernel.org/openembedded-core/20240623213254.3215897-1-leon.anavi@konsulko.com/T/#md4b10cea4af07c1a2e5be43e4ee8c8b1fbc6e420
> (though we "agreed" later in the thread to use ${B} instead of the
> originally suggested ${WORKDIR}).

Alright.

> [...]
> 
> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> > new file mode 100644
> > index 000000000000..4945c67345c4
> > --- /dev/null
> > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> > @@ -0,0 +1,17 @@
> > +[system]
> > +compatible=@MACHINE@
> > +bootloader=uboot
> > +data-directory=/data/
> > +
> > +[keyring]
> > +path=/etc/rauc/ca.cert.pem
> > +
> > +[slot.rootfs.0]
> > +device=/dev/disk/by-partlabel/rootfsA
> > +type=ext4
> > +bootname=A
> > +
> > +[slot.rootfs.1]
> > +device=/dev/disk/by-partlabel/rootfsB
> > +type=ext4
> > +bootname=B
> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> > new file mode 100644
> > index 000000000000..281eb2c4de91
> > --- /dev/null
> > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> > @@ -0,0 +1,7 @@
> > +inherit rk-rauc-demo-features-check
> > +
> > +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> > +
> 
> I would recommend renaming the directory to rauc-conf here, but that's just
> up to one's preference.

Hmm... the rauc-conf recipe is in the rauc diretory in meta-rauc so I followed
how the parent layer was doing it. I think I prefer it this way; makes it
slightly easier to find the thing the bbappend is appending when both the
parent and child layers use the same directory structure.

> Looking good otherwise :)
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#381): https://lists.yoctoproject.org/g/yocto-patches/message/381
> Mute This Topic: https://lists.yoctoproject.org/mt/106889680/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

