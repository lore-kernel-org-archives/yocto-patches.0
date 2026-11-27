Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14833.1795781518353894399
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 04:11:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=XDkhNDIj;
 spf=pass (domain: gmail.com, ip: 74.125.224.54, mailfrom: twoerner@gmail.com)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677d35fd1d2so8076242d50.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795781517; x=1796386317; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VAVwPlMrepJkGtIKOvQWeHyZx9/Ina176h+Xev2xHoA=;
        b=XDkhNDIjPIIYV6iMJCobbKPUkZm2nnDTXDxMznkXjggzZ9SvmW4kAJ8FBvRQ8uhtDy
         0ReBA01mnpOUGdkBfCNCLuS2IXOpr1iReGEbIvlriVlZm8n2oZ8Y6kkkG7hDBWYEdbL/
         p8aBVfXb6pimF2VVFDLff7+hjfc+qY8ykM5sJZzMs53yn9tNPZp/IzJn5nuNbVXRjUFc
         dwfQd6rDClS3xxbm58QFgSmDagOxkVW+6plmRXYlAdreLRfB0rWK4BwBDfXGHSkvRJVi
         NeUTLtm5Q0ohtPDzsJzhSWbE2bW+P0foDiPbhEvQkiAyDKwQQKm4SXGquyvvZNQiEQGZ
         0/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781517; x=1796386317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAVwPlMrepJkGtIKOvQWeHyZx9/Ina176h+Xev2xHoA=;
        b=wGjCBew2KhZxm5X3V2nuAypPnML/DvMIkIG71S/VpgxfoIHf/IhSi26pDzi5pKAMDo
         BXGbNAJuUuNYZnmOU1/JH1K1i1NQ5gRbSoXsHKTfW9BGRatcwzy+0ZMqOVR6+NfAT77u
         oGWd2rWwYAbOsG3p6fPGt+ZTiONPMIMjTViKuUId98To7VWmYfknv9Tt51njtps4xtot
         +PCZJAk2cJ8vTKLVH8jKAVeeaInohaDI86ZjKC2+UwhKHPKSLLUOnNyVOXPGJIxB8xOP
         J17hlQpG+s1R24eyCl73DJrp/EYgnfBmzE/IAW9tZrY1yiolUQHL8ulFEq6cmshWjX+m
         sNUw==
X-Gm-Message-State: APuU4Z82bUD++XLwFNCB6/EjhKXkDgT5t5QzSOlHSHs1PNd+ZP1RZxg+
	6uy+5OUuV8dC9cl6YW4VFA2AqKtyHDldOBmH2jmGUegYkesUF9VexLpR
X-Gm-Gg: AZFdTZcUW0wErzTcDEuHRES0w2ODp3/NQIYRieZ4IcK01/MVjFHRIjnohVRb43YzQZm
	KJ2coWZUZmQCpnBdNS73f1cYPL7nW6APBqsFh0uMK6bnDM5Yb/MCFdZwC8NFmxpbG3BRmmLD4Pm
	vwChGkakoqe1IxdYkveEuoauf5vPFbpHVrGuCZzQSC/Un1za+FiVu6IAp7TzuUaXgxO3N5EKUjo
	H0S+nIM47TBtSiPzve4VvW711D81Ww10Hz0tPCPz/Imw6cCkMODvYpC5ph2X1Z1VosGNysmc4HP
	qqGKilH6lR/XcUsHFhKE/9ryswu4oRgluGlpezZf42/pJYzMuJVdQmO7s4ExzjbOTqjapXBSKCg
	tDRF8EelVvEB0B2+skQ/FI7tDOlUxlClJcU2dcrOtJI8QtIkl0ClSW5a8L0YeG9Z9zB9c8cBttW
	erP1JY2D9S3TEZdk1EJ2QDUVwBx0sE6JIMfW0aFjyHKucQDZeBt3148Ql6vLyr6YXh1s8bjgFvv
	ujZ+iJ+bjGPEgXDkPqKClS7XJ5YkvfO3HwIxZVicvy4vlfrijPE6yHbSr6uAmW3HxeonSwAxNRg
	lewQRpdYomgK7S7kBmVG6wTA1tZCwVb5bvEhovsc/d28jdnev1PyAg2k3GBZMQsqR2V/A+WsjpE
	n+0BG2TuLlf3+Fbhl5OlRWzaEvx65y54=
X-Received: by 2002:a05:690e:440c:b0:67d:98b7:8868 with SMTP id 956f58d0204a3-67df4475aa4mr4700688d50.49.1795781517184;
        Fri, 27 Nov 2026 04:11:57 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b50besm212485596d6.9.2026.11.27.04.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:11:56 -0800 (PST)
Date: Fri, 27 Nov 2026 07:11:54 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 1/2] kernel: only add the rocket NPU
 fragment on rk3588s
Message-ID: <awlziqHj7tx47PjX@localhost.localdomain>
References: <20261127114049.3566943-1-twoerner@gmail.com>
 <6b21fbb2-cc3f-4553-a6f2-cfb202bdb89e@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b21fbb2-cc3f-4553-a6f2-cfb202bdb89e@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 12:12:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5551

On Fri 2026-11-27 @ 12:52:49 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 11/27/26 12:40 PM, Trevor Woerner wrote:
> > The fragment was appended for every rockchip machine, so setting
> 
> No? It's clearly only added when you set ENABLE_UPSTREAM_RKNPU boolean.
> Don't set it for SoCs that don't support it?

I just performed a build test where I set

	ENABLE_UPSTREAM_RKNPU = "1"

in conf/local.conf then build for every MACHINE in meta-rockchip. All of
them show either:

	WARNING: linux-yocto-7.2.15+git-r0 do_kernel_configcheck: [kernel config]: specified values did not make it into the kernel's final configuration:

	    [NOTE]: 'CONFIG_DRM_ACCEL_ROCKET' last val (y) and .config val (n) do not match
	    [INFO]: CONFIG_DRM_ACCEL_ROCKET : n
	    [INFO]: raw config text:

		config DRM_ACCEL_ROCKET
			tristate "Rocket (support for Rockchip NPUs)"
			select DRM_SCHED
			select DRM_GEM_SHMEM_HELPER
			depends on DRM_ACCEL && ((ARCH_ROCKCHIP && ARM64) || COMPILE_TEST) && (ROCKCHIP_IOMMU || COMPILE_TEST) && MMU && DRM
			help
			  Choose this option if you have a Rockchip SoC that contains a
			  compatible Neural Processing Unit (NPU), such as the RK3588. Called by
			  Rockchip either RKNN or RKNPU, it accelerates inference of neural
			  networks.

			  The interface exposed to userspace is described in
			  include/uapi/drm/rocket_accel.h and is used by the Rocket userspace
			  driver in Mesa3D.

			  If unsure, say N.

			  To compile this driver as a module, choose M here: the
			  module will be called rocket.

		Config 'DRM_ACCEL_ROCKET' has the following Direct dependencies (DRM_ACCEL_ROCKET=n):
			DRM_ACCEL(=y) && (ARCH_ROCKCHIP(=y) && ARM64(undefined/n)) || COMPILE_TEST(=n) (=n) && ROCKCHIP_IOMMU(=y) || COMPILE_TEST(=n) (=y) && MMU(=y) && DRM(=y)
		Parent dependencies are:
		     ARCH_ROCKCHIP [y] MMU [y] DRM_ACCEL [y] COMPILE_TEST [n] DRM [y] ROCKCHIP_IOMMU [y] ARM64 [ARM64]
	    [INFO]: config 'CONFIG_DRM_ACCEL_ROCKET' was set, but it wasn't assignable, check (parent) dependencies

for the 32-bit MACHINEs or

	WARNING: linux-yocto-7.2.15+git-r0 do_kernel_configcheck: [kernel config]: specified values did not make it into the kernel's final configuration:

	    [NOTE]: 'CONFIG_DRM_ACCEL_ROCKET' last val (y) and .config val (m) do not match
	    [INFO]: CONFIG_DRM_ACCEL_ROCKET : m ## .config: 5561 :configs//bsp/rockchip/rocket-npu.cfg (y)
	    [INFO]: raw config text:

		config DRM_ACCEL_ROCKET
			tristate "Rocket (support for Rockchip NPUs)"
			select DRM_SCHED
			select DRM_GEM_SHMEM_HELPER
			depends on DRM_ACCEL && ((ARCH_ROCKCHIP && ARM64) || COMPILE_TEST) && (ROCKCHIP_IOMMU || COMPILE_TEST) && MMU && DRM
			help
			  Choose this option if you have a Rockchip SoC that contains a
			  compatible Neural Processing Unit (NPU), such as the RK3588. Called by
			  Rockchip either RKNN or RKNPU, it accelerates inference of neural
			  networks.

			  The interface exposed to userspace is described in
			  include/uapi/drm/rocket_accel.h and is used by the Rocket userspace
			  driver in Mesa3D.

			  If unsure, say N.

			  To compile this driver as a module, choose M here: the
			  module will be called rocket.

		Config 'DRM_ACCEL_ROCKET' has the following Direct dependencies (DRM_ACCEL_ROCKET=m):
			DRM_ACCEL(=y) && (ARCH_ROCKCHIP(=y) && ARM64(=y)) || COMPILE_TEST(=n) (=y) && ROCKCHIP_IOMMU(=y) || COMPILE_TEST(=n) (=y) && MMU(=y) && DRM(=m)
		Parent dependencies are:
		     MMU [y] ARCH_ROCKCHIP [y] COMPILE_TEST [n] DRM [m] ROCKCHIP_IOMMU [y] ARM64 [y] DRM_ACCEL [y]

for the 64-bit ones.

> > ENABLE_UPSTREAM_RKNPU made the kernel config audit warn on all the
> > others: the driver only supports RK3588's NPU, and on 32-bit machines it
> > cannot be enabled at all. Use the rk3588s override, as the mesa
> > PACKAGECONFIG already does.
> > 
> 
> Mesa probably should be using :rockchip as well. The knob is enough.
> Otherwise every time there'll be a new SoC supported by Rocket, we'll need
> to enable ENABLE_UPSTREAM_RKNPU (or document it's supported) in the SoC .inc
> file, then update linux-rockchip.inc as well as mesa.bbappend to add an
> SoC-specific override, which is totally unnecessary.
> 
> The same logic applies to the stateless VPU for example (c.f.
> ENABLE_STATELESS_VPU_GST). We probably also should have a kernel config
> fragment to enable the appropriate stateless video codecs in the kernel
> (hantro, rkvdec, rkvdec2, ...).
> 
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > AI-Generated: codex/claude-opus 5.5 (xhigh)
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   recipes-kernel/linux/linux-rockchip.inc | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> > index f91492ee7968..006d9f0ecf14 100644
> > --- a/recipes-kernel/linux/linux-rockchip.inc
> > +++ b/recipes-kernel/linux/linux-rockchip.inc
> > @@ -37,4 +37,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
> >   KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
> >   KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> >   KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_FEATURES:append:rockchip = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
> > +KERNEL_FEATURES:append:rk3588s = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
> 
