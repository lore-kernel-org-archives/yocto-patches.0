Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A701D4922A
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 13:49:25 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13060.1765547364287636104
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 05:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NFY2CCh5;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8887f43b224so9372996d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765547363; x=1766152163; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWD/c0DPbCdfqw5fAdLldY1zelHuXQDE5bItZyj+kWI=;
        b=NFY2CCh5cVLb+WXiY/P88SYiGdCbQKJfu/1UdIzTqvH703TSnhTWN3Tqww5j6SCVhM
         XokwoWmOGnAd1+0xd5CiABi8TD4ovNt9lsJkW6dY7W3k9EYBf+GsQ6joJS5Ywx6DEtCc
         cCXconc2H0KQFjgqFIC+p6D/x0GOsxaCPqNb2upGmCIa8n70gwZ9EeqXtkX8r+w5Wy/F
         dIi7mfRMWcFumtIwN7BK6OUnZ2hDBhFL9L19oFqy9gYkcnok8CBIJFG4c/tuKeFoFsuK
         D2uQS/6Jf9HEpgS+Ip5/UARR/3yVxRUPCWHSiQmO/pVtcQPk4lFHXhmZk/MHV24/WVIz
         A+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547363; x=1766152163;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWD/c0DPbCdfqw5fAdLldY1zelHuXQDE5bItZyj+kWI=;
        b=YBFMdhGv4TKaqupFNqjREVlVnPC1p+iwE2NIlRFEz3DCpnTpon3rJ3kPe270IQKtYb
         1iELgXw0KFdhMXDQmsy5n1617TvVHmvspsbKnqRSBRzUSmtWY0eA8XTN65D8qk6WBcRg
         wbluazkZrIusJ76a5C8A+FCBonL2XK3cXikFaF/yDNsQLRac7lsiUCzkdpNHbnTbDuIX
         F8miT8wKc9yibXYzW5gzbPO53oasVkzJpg/38GOw2oGeaq8NRAGCepZCKsBNVMYy+dFN
         dztUa6utoVetB2N86Y7aabippjTghTPhzynZLfRcywRrU89E3xkmm6e+QB0IAmzRXRZv
         w9VA==
X-Gm-Message-State: AOJu0YyKvkploJHHuZFAeU2+j5EWkEEOewP8egPX/FcjTvHK9o45mCma
	O6jq9eXn4+v3C240zE3SMWDtvSjhybGQRCCbHWZP+LjQQhTFzrJHp9sb9iHQmA==
X-Gm-Gg: AY/fxX6GbEQAtK0yFVgkv8KItCeGjhawbkp3QxSWPfOmKV0sc6nDO5oQcR1WZqX8F0K
	IbCV5CrwrvwfvPzmukLm084MBAWufym7j/8ATTPaEcSddAcfb5As/9SrEpXj5sTE8hgkRH3N4TP
	GY4Geo/05njKQbJ6j53wDtdMPyrsk9x1+WJEX1i9rPM4+aR/M65dtKJMvvPtDfERgXNJ5FyTZDF
	T6JwcFEcFlSqM7AEgOxbm1k5KRHrwydHAuhykQrUYOTGt4z9EXGZcIUcJBOXn0aUHhHBzV7u7/2
	HgHUzbXIHNpo6qEh4XlamwcKaDPBt3Ok7CX8AgC3T8Sq2xK4RcRGQT9fV+nRPcgLzvmRV3OiF7D
	uuToi0zd1KaZ3kIuuwBxAyzsLXRkXDrUJsML8mpQ6iZOjtjor3ym9iSjy/mbN1LU8ZiwMnlcFXf
	CiOKNk2Jk8PH45APDfgdA4rmCS3yQ4s+XwkMoIxex7f0euBtMc
X-Google-Smtp-Source: AGHT+IH0v8hh47l2fUYqJMXmVkhmLkXKgIQ7s71IxolqdjM0QLF+nRCuxwqKA+FiGLehUl3LeywiIg==
X-Received: by 2002:a05:6214:311e:b0:880:1be2:82d4 with SMTP id 6a1803df08f44-8887e1ab9e5mr30695236d6.26.1765547362502;
        Fri, 12 Dec 2025 05:49:22 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888818ccf43sm12814736d6.32.2025.12.12.05.49.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 05:49:21 -0800 (PST)
Date: Fri, 12 Dec 2025 08:49:20 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] provide a filesystem
 overlay example
Message-ID: <20251212134919.GA8875@localhost>
References: <20251211210332.25509-1-twoerner@gmail.com>
 <12e8c8b3-f1b4-4aaa-abac-9449f9daffd3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12e8c8b3-f1b4-4aaa-abac-9449f9daffd3@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2773

On Fri 2025-12-12 @ 11:47:55 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 12/11/25 10:03 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Most implementations that use an A/B, full-partition update mechanism
> > (such as RAUC configured for this scenario) need some way of preserving
> > system configurations in a location that survives updates. The RAUC demo
> > provided in this layer is an example of a full-partition update,
> > therefore provide an example of using a filesystem overlay to preserve
> > system configurations. This example is gated by a configuration knob:
> > 
> > 	RK_OVERLAY_DEMO
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   README                                        | 28 +++++++++++++++++++
> >   conf/machine/include/rockchip-rauc.inc        |  1 +
> >   .../systemd/data-partition-overlay_1.0.bb     | 22 +++++++++++++++
> >   .../recipes-core/systemd/files/etc.mount      | 13 +++++++++
> >   .../recipes-core/systemd/files/home.mount     | 13 +++++++++
> >   5 files changed, 77 insertions(+)
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
> >   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> > 
> > diff --git a/README b/README
> > index 6a13428d488d..92dc072a0833 100644
> > --- a/README
> > +++ b/README
> > @@ -140,6 +140,34 @@ Notes:
> >   	this layer, perform the same steps as above except for the step enabling
> >   	RK_RAUC_DEMO.
> > +  /data overlay with RAUC
> > +	When using RAUC for whole-partition rootfs updates, you will need some
> > +	way of preserving some pieces of data between updates; this is why the
> > +	DEMO scheme provided in this layer also includes a /data partition.
> > +	Now that you have a /data partition that is not updated, you need some
> > +	way of storing your important data there and making it available,
> > +	seamlessly, into your system regardless of which slot is running.
> > +
> > +	One way of accomplishing this is to move your important files into
> > +	/data and providing symlinks back into each running bundle. But that
> > +	requires you to know ahead of time which files will be touched... which
> > +	quickly can become a game of whack-a-mole. A better alternative is to
> > +	use a filesystem overlay. With a filesystem overlay, multiple paths are
> > +	overlaid on top of each other behind the scenes so what you see is one
> > +	directory containing the aggregation of all layers. Filesystem overlays
> > +	have a concept of "bottom layers" and "upper layers", if you write a new
> > +	file into an overlay, the file will be written into the uppermost
> > +	layer, leaving the lower layers intact. If a file is modified, the
> > +	modifications are stored in the upper layer, occluding the lower layer.
> > +	Therefore, creating an overlay using locations in the /data partition
> > +	as the uppermost layer allows changes to persist across RAUC updates.
> > +
> > +	This layer includes a simple overlay scheme to demonstrate one way of
> > +	making use of this mechanism. To enable the demo included in this layer
> > +	RAUC must be enabled, then also enable:
> > +
> > +		RK_OVERLAY_DEMO
> > +
> 
> You're overlaying two directories, so please make this explicit in the
> README. /etc and /home are overlaid. Now, is the root user's home directory
> in /home/root or in /root? Because you may want to overlay that as well?

It's in /root, good point! ...or I could put root's home directory under
/home?

In desktop Linux I guess it's common for /home to have lots of
sub-directories, and be NFS-mounted, etc in which case having root's
home handled separately is good, but there probably is no need for it
here?

> Additionally, CONFIG_OVERLAY_FS support likely needs to be enabled in the
> kernel for this to work, so mentioning this would be nice? (though we also
> didn't mention this for the VPU, so... :) ).

It's funny I didn't mention this, considering the other email thread in
progress ;-) The aarch64 defconfig includes:

	CONFIG_OVERLAY_FS=m

which is good enough to make this work. It also includes

	CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y

which might be questionable. The in-kernel documentation says:

	OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW:

	    If this is enabled, then redirects are always followed by default.
	    Enabling this results in a less secure configuration. Enable this
	    option only when worried about backward compatibility with kernels
	    that have the redirect_dir feature and follow redirects even if
	    turned off.

> >     HW video decoding with gstreamer
> >   	Most Rockchip SoCs have some integrated VPU, either Hantro, RKVDEC or
> > diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
> > index a6f79503076b..3ea95298fed6 100644
> > --- a/conf/machine/include/rockchip-rauc.inc
> > +++ b/conf/machine/include/rockchip-rauc.inc
> > @@ -2,3 +2,4 @@
> >   # rauc demo configuration from this layer
> >   OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> >   IMAGE_INSTALL:append:rk-rauc-demo = " abd-partition"
> > +IMAGE_INSTALL:append:rk-rauc-demo = " ${@ 'data-partition-overlay' if bb.utils.to_boolean(d.getVar('RK_OVERLAY_DEMO'), False) else ''}"
> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
> > new file mode 100644
> > index 000000000000..7d9a9e6de82b
> > --- /dev/null
> > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
> > @@ -0,0 +1,22 @@
> > +SUMMARY = "Overlay Logic onto the /data partition"
> > +LICENSE = "OSL-3.0"
> > +LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/OSL-3.0;md5=438ec6d864bbb958a49df939a56511cf"
> > +
> > +inherit rk-rauc-demo-features-check systemd
> > +
> > +SYSTEMD_SERVICE:${PN} = "etc.mount home.mount"
> > +
> > +S = "${UNPACKDIR}"
> > +
> > +SRC_URI = " \
> > +        file://etc.mount \
> > +        file://home.mount \
> > +	"
> > +
> > +do_install() {
> > +	install -d ${D}${sysconfdir}/systemd/system
> > +	install -m 0644 ${UNPACKDIR}/etc.mount ${D}${sysconfdir}/systemd/system/
> > +	install -m 0644 ${UNPACKDIR}/home.mount ${D}${sysconfdir}/systemd/system/
> 
> I see we have a couple of systemd_*unitdir variables in bitbake.conf, should
> we use one of those instead?

Good catch.

> > +}
> > +
> > +RDEPENDS:${PN} += "abd-partition"
> 
> Maybe add a comment this is necessary because of the data.mount requirement?

Sounds good, and yes.

> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
> > new file mode 100644
> > index 000000000000..65b896563bef
> > --- /dev/null
> > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
> > @@ -0,0 +1,13 @@
> > +[Unit]
> > +Description=OverlayFS mount for /etc to /data/overlay/etc
> > +Requires=data.mount
> > +After=data.mount
> > +
> 
> I'm wondering if this cannot be handled by
> 
> RequiresMountsFor=/data
> 
> c.f. https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#RequiresMountsFor=

Okay, I'll try that. systemd unit files are such a labyrinth. Some AI
suggested the above ;-)

> > +[Mount]
> > +What=overlay
> > +Where=/etc
> > +Type=overlay
> > +Options=lowerdir=/etc,upperdir=/data/overlay/etc,workdir=/data/overlay-workdir/etc
> > +
> > +[Install]
> > +WantedBy=multi-user.target
> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> > new file mode 100644
> > index 000000000000..d6a384fa9c75
> > --- /dev/null
> > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> > @@ -0,0 +1,13 @@
> > +[Unit]
> > +Description=OverlayFS mount for /home to /data/overlay/home
> > +Requires=etc.mount
> > +After=etc.mount
> > +
> 
> Why is this not data.mount too?

I did this patch one piece at a time. It took me less than an hour from
start of reading to getting /etc working. It then took me the rest of
the day to get /home added as well. The problem was with
ordering/dependencies.

If I ordered both /home and /etc overlays after data.mount it would
always fail; either one or both of the mounts would not appear in the
`mount` output or (worse) the overlays would appear to be mounted (they
would show up in the `mount` output) but one or both of the mounts would
not work.

The solution I found was to explicitly order them: data → etc → home. In
practice it didn't matter whether home or etc came first, they just
needed to be strongly ordered.

While trying to get this right, sometimes systemd itself would throw a:

	[ SKIP ] Ordering cycle found, skipping Ove…mount for /etc to /data/overlay/etc

on boot (sometimes for etc, sometime for home) which at least warned me
that something went wrong. Other times it didn't give the error, but
failed anyway.

tl;dr: it's a bit finicky ;-)

> Otherwise looks ok to me.

Thanks!

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2771): https://lists.yoctoproject.org/g/yocto-patches/message/2771
> Mute This Topic: https://lists.yoctoproject.org/mt/116736285/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

