Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21016.1795536096885938373
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 08:01:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=rkST57t0;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5361e313e63so63454381cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536096; x=1796140896; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWTdY6KVzOBYtIZ7c0ZG9K4p4lgFSDPA3loNi3Dcx3w=;
        b=rkST57t0403a0MBq+NIoTgZlOgVck9ZNzxSyI4FhtgzyLaO7yvedJQeFasyw+dwWR8
         UhP67CswklPa8q8a5jUcrJGVSGKgO09Z4nLbvElCjHBy54T4kTnQG/Myc7k1ht9Sdibf
         5P8YZuvj3I+/OHPCPPl0mhSbOoJx1D66zdO80ubuzyhRT2Ve+YTFic2otMiVz+AfQFG6
         GYDioLLCUD0w0hqZQiYb5ZUagwCQrr8bsHscKp5LF6ugfi/1uw+pe/BBk6WMQ65bSAQq
         CRM6nCT92ikaB72zSAmEOj4wNI0mcpYn9J+kWUuZLZsgPCDTcvVPhiG+VQhz9H9KuYwF
         McSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536096; x=1796140896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWTdY6KVzOBYtIZ7c0ZG9K4p4lgFSDPA3loNi3Dcx3w=;
        b=X15v22WZpRB7vF7HFYIrn4/hNIGKeLeTJwTfEZC/LfLDw5Qz3F3s42tHQnNB+QMfaA
         T+9d3wJ4l5QBWybKwN9hP/3YbcTxUrm392dRonMKasQvA6b9u6IVsD/O6V1zc7ntXiMc
         S2w5B+D/zMmkkYpWDbU+w7bFlfce8jqzCHkKmkC+eZXcl9LgId5NPS/I8QJ8AbUsezMc
         QUVdwObbuXwjLegel7CCzJoI21nKU/2ODojtn202CTuPTs0YQJrHdJ9jByiJIP4ovzQc
         0/8CeYDQ6l23IS1I345DMkfdpf5Zkn7hQuvcj2HsExDimrI5PliGXmrRMWM3FlkAub4J
         9ksQ==
X-Gm-Message-State: APuU4Z9aP8kY92SmSaouB29ZBeqIXVRAmsMCuY8vnEghAd/rP76uLsnO
	7n90nLQQBLmvuT6rVlqkL2cT5jZnXfeKI9j1Qc6GaVnMnCfo8HLyYFNN
X-Gm-Gg: AZFdTZcJPMi4/FReLlTKyZ9xCsBxcHIL1duuwLtPzosRikJTHDbgUIDBMZE1O/VB84x
	1CJkE+p/X5l3EAFSJsGI08zZIwJPEnttRzZWVbEHB6m9Is0mVmwljUcFLwrzJU6wKwdX1Hj8oAN
	0aTh7Od8MBtpHJZqyS1jMf7lEl/MSVn1uzkmVb24sUwaSiHn9TIHndEWSz+T4+zq6V5bIxM4vXd
	o9D3y8Yd77QqoOyZK41W59v2SkIrt6+uAQrQNSGXdSHThEdbebYCfJC1oda8n7tu59Q4Iaf6WbK
	iytIhg4enfOS7aiiA4KOef3u732kh6GJGfZbQ81xTfES/x7V7/wE8fSzw4s7bHJPhni1Jy9u5ES
	V6rh1+FD/y6fSkEOJZ1vE7czntBPWfcTIUn2HOKwohU9EB7HVCcrWr8y6yfRRVoFOH4MkLnIxlm
	oyf90hckRf0Fj/t8dtj6b2txvBuiEIlY/3H9RIuC8MP/QgZBI7Eky9a11xzZlc5zYptJ/3/1gUd
	zZDSkWm1Gm8Pc6KcpplJwehw99+kSGDmVPuSNhMIPolHoVQf/OynG/ROUmy+ipBL8USsK8Fbkdj
	Cf76ZkmNDurytPnP2jBv6Y/uOnZi4NuDLCltuuT//I6UUnFJeNWkG6MQnnRPSjMGU+DxluPdtC2
	x+7q0fd14XG2oZwSK5jCgIzrAHtaWQqo=
X-Received: by 2002:a05:622a:1f18:b0:55d:3198:255e with SMTP id d75a77b69052e-55d768a4886mr266660161cf.8.1795536095342;
        Tue, 24 Nov 2026 08:01:35 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788116c9sm131796321cf.4.2026.11.24.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:01:34 -0800 (PST)
Date: Tue, 24 Nov 2026 11:01:32 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2] add support for
 upstream RKNPU/RKNN/Rocket HW AI accelerator
Message-ID: <awW03AUKpQ04Ixvj@localhost.localdomain>
References: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
 <awRfVnmgA5cTr4Xo@localhost.localdomain>
 <43f032c6-5d8a-4a1b-a0f5-8bf30873d0a9@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43f032c6-5d8a-4a1b-a0f5-8bf30873d0a9@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 16:01:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5512

On Mon 2026-11-23 @ 05:01:58 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 11/23/26 4:44 PM, Trevor Woerner wrote:
> > On Thu 2026-04-23 @ 06:19:37 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > 
> > > This adds support for the NPU (Neural Processing Unit) found on the
> > > RK3588(S).
> > > 
> > > The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
> > > Device Tree nodes (so not all RK3588 devices supported upstream
> > > necessarily have the NPU declared properly!) and a userspace driver in
> > > mesa (teflon delegate with rocket gallium driver).
> > > 
> > > This adds a config fragment for linux-rockchip kernels such that the
> > > disabled-by-default Rocket driver is built and enables the Rocket
> > > gallium mesa driver with the teflon delegate, but only when the user
> > > requests its support.
> > > 
> > > This was tested by running the following:
> > > 
> > > """
> > > wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
> > > 
> > > TEFLON_DEBUG=verbose python3 classification.py \
> > > 	     -i /usr/share/label_image/grace_hopper.bmp \
> > > 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
> > > 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
> > > 	     -e /usr/lib/libteflon.so
> > > """
> > > 
> > > from an image built with meta-tensorflow's tensorflow-lite, mesa's
> > > libteflon, meta-openembedded's python3-pillow and OE-Core's
> > > python3-numpy packages.
> > > 
> > > Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
> > > currently supported in the kernel.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > > This was tested on RK3588 Jaguar with linux-yocto 6.18 +
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f
> > > 
> > > Note this (lightly) depends on
> > > https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
> > > being merged in meta-tensorflow. Another option is to simply add
> > > "tensorflow" to DISTRO_FEATURES to pass the (useless) check.
> > > ---
> > > Changes in v2:
> > > - switched to oe.utils.vartrue from bb.utils.to_boolean
> > > - driver now built-in instead of as module since the necessary patches
> > >    have been backported to the 6.18 stable kernel version currently in
> > >    OE-Core via linux-yocto_6.18,
> > > - updated commit log now that meta-tensorflow is usable without hacks,
> > >    and filepaths for input files to classification.py have changed with
> > >    newer tflite,
> > > - reworded README to specify libteflon needs to be installed in the
> > >    image manually but the mesa rocket driver and teflon delegate are
> > >    automatically built if the variable is properly set,
> > > - Link to v1: https://lore.kernel.org/yocto-patches/20260128-rknn-v1-1-363d7ef2c16c@cherry.de/
> > > ---
> > >   README                                               | 20 ++++++++++++++++++++
> > >   recipes-graphics/mesa/mesa.bbappend                  |  4 ++++
> > >   recipes-kernel/linux/linux-rockchip.inc              |  1 +
> > >   .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg       |  2 ++
> > >   .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc       |  1 +
> > >   5 files changed, 28 insertions(+)
> > > 
> > > diff --git a/README b/README
> > > index c2697d1..6d9db9b 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -222,6 +222,26 @@ Notes:
> > >   	NOTE: this variable must be set before any include/require in the
> > >   	      machine configuration file
> > > +  Neural Processing Unit (NPU)
> > > +
> > > +	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
> > > +	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
> > > +	to use Rocket instead. At the time of writing (Linux kernel v7.0), only
> > > +	RK3588's NPU is supported upstream.
> > > +
> > > +	This NPU is an AI hardware-accelerator. You can enable its support by
> > > +	setting:
> > > +
> > > +		ENABLE_UPSTREAM_RKNPU = "1"
> > > +
> > > +	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+) and
> > > +	RKNN Device Tree nodes
> > > +	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438).
> > > +	The mesa userspace driver (rocket gallium driver) and teflon delegate
> > > +	are automatically compiled when this option is enabled. You need to add
> > > +	the libteflon package to your image to be able to use the teflon
> > > +	delegate.
> > > +
> > >   U-Boot Environment:
> > >   ------------------
> > >   	In order to configure U-Boot to be able to store its environment into the
> > > diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> > > index d9e7c08..69a210f 100644
> > > --- a/recipes-graphics/mesa/mesa.bbappend
> > > +++ b/recipes-graphics/mesa/mesa.bbappend
> > > @@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
> > >   PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
> > >   PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
> > > +# Enable teflon for upstream RKNPU/rocket support
> > > +# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
> > > +PACKAGECONFIG:append:rk3588s = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' teflon rocket', '', d)}"
> > > +
> > >   # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
> > >   RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
> > > diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> > > index 6c62e84..dc30327 100644
> > > --- a/recipes-kernel/linux/linux-rockchip.inc
> > > +++ b/recipes-kernel/linux/linux-rockchip.inc
> > > @@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
> > >   KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> > >   KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > > +KERNEL_FEATURES:append:rockchip = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' bsp/rockchip/rocket-npu.scc', '', d)}"
> > 
> > I was looking to merge this patch the other day; it still applies
> > (with small adjustments) and i can build-test using rock-5a.
> > Unfortunately vartrue() isn't how i want it implemented. Toggling
> > ENABLE_UPSTREAM_RKNPU rebuilds nothing, in either direction, so
> > whichever state you build first is the one you keep until a cleansstate.
> > The do_kernel_configme signature is identical with the knob set and
> > unset:
> > 
> >    knob off   9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
> >    knob on    9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
> > 
> > vartrue() passes the variable name as a string literal, which bitbake's
> > code parser does not track. A [vardeps] flag papers over it, but I would
> > rather not carry that kludge in the layer. bb.utils.contains() works as
> > expected and the README already documents the knob as "1", so it is a
> > drop-in replacement:
> > 
> >    KERNEL_FEATURES:append:rockchip = "${@bb.utils.contains('ENABLE_UPSTREAM_RKNPU', '1', ' bsp/rockchip/rocket-npu.scc', '', d)}"
> > 
> >    knob off   bf89f310b03cafa01f0a4b130fcda233bb9ff2689e6575d8fe77ac3d9aa95806
> >    knob on    7733dbcc030a79f18343e605afd13363f38a60a3d47c0eb1c7d9247f12b6135f
> > 
> > The mesa.bbappend PACKAGECONFIG line needs the same change.
> > 
> > Bug 3890 got contains() tracked back in 2013, and the visitorcode hook
> > added to bitbake in 2024 would be the modern way to cover the oe.utils
> > helpers, but nobody has wired them up.
> > 
> 
> Can you please open a bug so that this is known? We already have users of
> vartrue in OE-Core, most of which do not actually add the variable to
> vardeps varflag, so we would have an issue there as well.

I looked into it before filing, and I don't think there is a bug.
BitBake works out a task's dependencies from the variable names it can 
see in the metadata, and a name passed to a function as a string is
not one of them [1]. The BitBake manual covers exactly this case:
[vardeps] is for when "a function refers to a variable in a manner that
does not allow BitBake to automatically determine that the variable is
referred to" [2]. vartrue() is such a function, so a variable holding
its result needs the [vardeps] if a task reads it. 

A missing [vardeps] is only a problem when nothing else carries the 
variable into the task, though, and for most of the OE-Core users
something does. DEBUG_BUILD is already a direct dependency of every one 
of those tasks I checked, through the [vardeps] on SELECTED_OPTIMIZATION
and BUILD_OPTIMIZATION in bitbake.conf [3], so toggling it rebuilds
them [4].

webkitgtk is where you are right. Its variables are only caught because
they also change DEPENDS, and for GIDOCGEN_ENABLED that happens only
when it is exactly "True" [5]: GIDOCGEN_ENABLED = "1" turns the 
documentation build on in EXTRA_OECMAKE [6] without changing any 
webkitgtk signature [7], since webkitgtk declares no [vardeps] of its 
own.

In your patch it was only the kernel line, and I also owe you a
correction there. My first mail said the mesa.bbappend line needed the 
same change, and it did not. On OE-Core's own mesa, a vartrue()-gated
PACKAGECONFIG append does change the do_configure signature, because
PACKAGECONFIG ends up holding the expanded value [8]. On linux-yocto's
KERNEL_FEATURES the same construct changes neither do_kernel_metadata
nor do_kernel_configme [8], which matches what I measured with your
kernel line. Sorry for the noise.

For the layer I am going with

  bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False)

in both places rather than the contains() I suggested. It is tracked,
and it matches the other knobs in meta-rockchip.

> > Would you like to send a v3, or would you rather I make those two
> > changes plus the rebase here?
> > 
> 
> I won't have time to do that any time soon, so please do. Thanks!

Okay.

> Cheers,
> Quentin


All measurements: openembedded-core 7412d08ab2ee, bitbake
0861e6e5ba87, only the meta layer, MACHINE = "qemux86-64", signatures
from "bitbake -S none", one TMPDIR per configuration.

[1] bitbake's code parser records a .getVar() reference only when the 
    variable name is a string literal, and otherwise logs "argument ... 
    is not a string literal" at debug level:
    https://git.openembedded.org/bitbake/tree/lib/bb/codeparser.py?id=0861e6e5ba87923b9c20e2878c3920b969e3f556#n272
    vartrue() calls d.getVar(var) with the name it was given:
    https://git.openembedded.org/openembedded-core/tree/meta/lib/oe/utils.py?id=7412d08ab2ee94354a93f3765b94479d84c6b034#n52
[2] "Variable Flags" in the BitBake User Manual:
    https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#variable-flags
[3] https://git.openembedded.org/openembedded-core/tree/meta/conf/bitbake.conf?id=7412d08ab2ee94354a93f3765b94479d84c6b034#n675
[4] bitbake-dumpsig lists DEBUG_BUILD as a direct dependency of
    debugedit:do_configure, bindgen-cli:do_compile (cargo),
    adwaita-icon-theme:do_configure (meson),
    vulkan-validation-layers:do_compile, webkitgtk:do_configure and 
    acl-native:do_compile, and DEBUG_BUILD = "1" changes the signature
    of each.
[5] https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/gi-docgen.bbclass?id=7412d08ab2ee94354a93f3765b94479d84c6b034#n31
[6] https://git.openembedded.org/openembedded-core/tree/meta/recipes-sato/webkit/webkitgtk_2.54.3.bb?id=7412d08ab2ee94354a93f3765b94479d84c6b034#n89
[7] GIDOCGEN_ENABLED:pn-webkitgtk = "False", then "1": bitbake-getvar
    shows -DENABLE_DOCUMENTATION=OFF, then =ON, while do_configure stays
    c5cf476a5e396f4b and do_compile stays 37bb793d50ddc6dc.
[8] Toggling a variable between "0" and "1" in
      PACKAGECONFIG:append:pn-mesa = "${@oe.utils.vartrue('VT_KM', ' teflon', '', d)}"
      KERNEL_FEATURES:append:pn-linux-yocto = "${@oe.utils.vartrue('VT_KM', ' features/vt-probe.scc', '', d)}"
    changes mesa:do_configure from 03e1b0907513a250 to
    994da9c21c5b3e22, and bitbake-diffsigs shows PACKAGECONFIG and 
    PACKAGECONFIG_CONFARGS gaining teflon / -Dteflon=true. It leaves
    linux-yocto:do_kernel_metadata at ff6dff89c0e91f00 and 
    do_kernel_configme at 75ea1e41f7893b67.
