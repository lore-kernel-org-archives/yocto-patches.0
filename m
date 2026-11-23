Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56488.1795448666618392075
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 07:44:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=pLBUFR/e;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94961bfe1a0so229863785a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795448665; x=1796053465; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aMNDULRNLUQpvHqweSnENTUh8gwbuHCQ6UBVctAolYU=;
        b=pLBUFR/ekY2Z1K19/mDs7jxgJClIkI+HaJ5dpaEHvMeUN37i3c3oMzkK2MyqDlihih
         b9Uk8LbMvXoQSOmkGZqRohSZF4NJdz1w3P8EvvecDOxo5PHEgwuyCYmw1Q3msYUbr1ab
         m9rV7/SXK9gsT62Z3HrOWiMBZKt0PUsrA9EnBOulNPoGaJo+/b5YQQPtXx5/IG/RldqM
         /VsxnaIZn7wvlH+36reGdONOoCiVl5jj7dejjdLdUwvJ3IElGF09oN7Xm6lH18lRH69S
         ZE5bjOQryhVyy7+AfJYjaMstk7tTllbjIhm8DvJm14AmW2WC7Vbl4Bz8C+eGfa3Z6vWj
         D3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448665; x=1796053465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMNDULRNLUQpvHqweSnENTUh8gwbuHCQ6UBVctAolYU=;
        b=0HueOQchsSOkCGrNu36ZoBsbLkYrweSiAwvLHRBLA5hgjhgu7oHhFVT4M/6WdAGrTB
         GsjfZ7AHlw32Y0YY5pT8FJ8ommw13IvEaJ+K5SCzh0a4gYbIlPjF0OcUMYNAYKvCgDRB
         yJpNFAwT6qXNUaVH6up7umj1AaawdEkRZSOjKQxehWfnlAQ1dSwcf0D7d8cPWsuF3CSl
         NPLgkKLbRgo9yiQb1EbMpLzxfFW61VmrW8qPOzi1WbLLLcq52uUa97vXaJ5UohtQVtde
         WYa4VyVW+lqv/8Nm0dCN30AsUyOSV/Q1AsrcDBaTov6E6FKA9XlxFwqNrEL5akeZd0Df
         hgrg==
X-Gm-Message-State: APuU4Z/qPHkvrJdx6iKa4LCjqzAqEtiV4nGm67pHdXcBPLVboKWGA5CH
	iWCEOVqhQliAmx5nUzGKJfDUXlCq2p9vu7LSo3VY5HZKCUpIfh2Af9pDjqgW5w==
X-Gm-Gg: AZFdTZfp10ZIf0hHQZZoJzF2SapolE5aLF8Yv6BJ6zHm2YkvPOxYjw1czN1D8fR2UHT
	u04+IZyc4M5EwWxTrBzZhA6iJ14ra6X40z0BGBzJdpv7X6jftjHNluKrBupTCJij/gicERsGJkw
	yP/699mYhpVsnizEsTDm882RNe58d5goJF6o8bnUq/xWCpO5nocVFQrE6lldC04dzUKjD4YZtwp
	1bSQisdnvzsTVSWUcfDLXASM0mZvNQR1j2IrsNgcfN42ALOJoK1UGgfmr93ur1NouAYx1jdW3uG
	GmN70fLwrldQz8Uu35T1iImMW0qiqVvqRrg+GS7bjFEVb1hclV5/XgZu3Jjqf+zXP8xuyoQftOr
	Igq5nnuPmryFeds6bHV6aL249CU7b/i+ELI+9N85hhtRsnxGMcz4KuOn2WlAZ3UEt/BPdsV4Ws8
	+e84AG0/djCL7LBC8TjM55vntUya1IAnKMFhai3LYd6V036jPQw9gofnCbnC5PQ7uH8jolGdC0o
	QzwEWCA8QznGhGCWv90YG7rgyjFd9UupKX5W2GeoxDCE5ZHjKDMJIBhAh/LYAwTTHLs66QPPnjk
	+tQAi1K8K8M5FRkUU6KhONto8h64xNgMDWWwYb/FOfPI8/BfQss1UGrvphJL38N0oDxHymz9fNz
	vOOErwAzX9ro4mAxhEC2aGa4kMxjdgFY=
X-Received: by 2002:a05:620a:538c:20b0:949:c271:8a93 with SMTP id af79cd13be357-949c2718c9bmr1361496485a.27.1795448665359;
        Mon, 23 Nov 2026 07:44:25 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb397b4bsm833905085a.21.2026.11.23.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:44:24 -0800 (PST)
Date: Mon, 23 Nov 2026 10:44:22 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2] add support for
 upstream RKNPU/RKNN/Rocket HW AI accelerator
Message-ID: <awRfVnmgA5cTr4Xo@localhost.localdomain>
References: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 15:44:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5491

On Thu 2026-04-23 @ 06:19:37 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This adds support for the NPU (Neural Processing Unit) found on the
> RK3588(S).
> 
> The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
> Device Tree nodes (so not all RK3588 devices supported upstream
> necessarily have the NPU declared properly!) and a userspace driver in
> mesa (teflon delegate with rocket gallium driver).
> 
> This adds a config fragment for linux-rockchip kernels such that the
> disabled-by-default Rocket driver is built and enables the Rocket
> gallium mesa driver with the teflon delegate, but only when the user
> requests its support.
> 
> This was tested by running the following:
> 
> """
> wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
> 
> TEFLON_DEBUG=verbose python3 classification.py \
> 	     -i /usr/share/label_image/grace_hopper.bmp \
> 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
> 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
> 	     -e /usr/lib/libteflon.so
> """
> 
> from an image built with meta-tensorflow's tensorflow-lite, mesa's
> libteflon, meta-openembedded's python3-pillow and OE-Core's
> python3-numpy packages.
> 
> Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
> currently supported in the kernel.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This was tested on RK3588 Jaguar with linux-yocto 6.18 +
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f
> 
> Note this (lightly) depends on
> https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
> being merged in meta-tensorflow. Another option is to simply add
> "tensorflow" to DISTRO_FEATURES to pass the (useless) check.
> ---
> Changes in v2:
> - switched to oe.utils.vartrue from bb.utils.to_boolean
> - driver now built-in instead of as module since the necessary patches
>   have been backported to the 6.18 stable kernel version currently in
>   OE-Core via linux-yocto_6.18,
> - updated commit log now that meta-tensorflow is usable without hacks,
>   and filepaths for input files to classification.py have changed with
>   newer tflite,
> - reworded README to specify libteflon needs to be installed in the
>   image manually but the mesa rocket driver and teflon delegate are
>   automatically built if the variable is properly set,
> - Link to v1: https://lore.kernel.org/yocto-patches/20260128-rknn-v1-1-363d7ef2c16c@cherry.de/
> ---
>  README                                               | 20 ++++++++++++++++++++
>  recipes-graphics/mesa/mesa.bbappend                  |  4 ++++
>  recipes-kernel/linux/linux-rockchip.inc              |  1 +
>  .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg       |  2 ++
>  .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc       |  1 +
>  5 files changed, 28 insertions(+)
> 
> diff --git a/README b/README
> index c2697d1..6d9db9b 100644
> --- a/README
> +++ b/README
> @@ -222,6 +222,26 @@ Notes:
>  	NOTE: this variable must be set before any include/require in the
>  	      machine configuration file
>  
> +  Neural Processing Unit (NPU)
> +
> +	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
> +	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
> +	to use Rocket instead. At the time of writing (Linux kernel v7.0), only
> +	RK3588's NPU is supported upstream.
> +
> +	This NPU is an AI hardware-accelerator. You can enable its support by
> +	setting:
> +
> +		ENABLE_UPSTREAM_RKNPU = "1"
> +
> +	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+) and
> +	RKNN Device Tree nodes
> +	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438).
> +	The mesa userspace driver (rocket gallium driver) and teflon delegate
> +	are automatically compiled when this option is enabled. You need to add
> +	the libteflon package to your image to be able to use the teflon
> +	delegate.
> +
>  U-Boot Environment:
>  ------------------
>  	In order to configure U-Boot to be able to store its environment into the
> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> index d9e7c08..69a210f 100644
> --- a/recipes-graphics/mesa/mesa.bbappend
> +++ b/recipes-graphics/mesa/mesa.bbappend
> @@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
>  PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
>  PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
>  
> +# Enable teflon for upstream RKNPU/rocket support
> +# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
> +PACKAGECONFIG:append:rk3588s = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' teflon rocket', '', d)}"
> +
>  # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
>  RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> index 6c62e84..dc30327 100644
> --- a/recipes-kernel/linux/linux-rockchip.inc
> +++ b/recipes-kernel/linux/linux-rockchip.inc
> @@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>  
>  KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>  KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> +KERNEL_FEATURES:append:rockchip = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' bsp/rockchip/rocket-npu.scc', '', d)}"

I was looking to merge this patch the other day; it still applies
(with small adjustments) and i can build-test using rock-5a.
Unfortunately vartrue() isn't how i want it implemented. Toggling
ENABLE_UPSTREAM_RKNPU rebuilds nothing, in either direction, so
whichever state you build first is the one you keep until a cleansstate.
The do_kernel_configme signature is identical with the knob set and
unset:

  knob off   9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
  knob on    9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9

vartrue() passes the variable name as a string literal, which bitbake's
code parser does not track. A [vardeps] flag papers over it, but I would
rather not carry that kludge in the layer. bb.utils.contains() works as
expected and the README already documents the knob as "1", so it is a
drop-in replacement:

  KERNEL_FEATURES:append:rockchip = "${@bb.utils.contains('ENABLE_UPSTREAM_RKNPU', '1', ' bsp/rockchip/rocket-npu.scc', '', d)}"

  knob off   bf89f310b03cafa01f0a4b130fcda233bb9ff2689e6575d8fe77ac3d9aa95806
  knob on    7733dbcc030a79f18343e605afd13363f38a60a3d47c0eb1c7d9247f12b6135f

The mesa.bbappend PACKAGECONFIG line needs the same change.

Bug 3890 got contains() tracked back in 2013, and the visitorcode hook
added to bitbake in 2024 would be the modern way to cover the oe.utils
helpers, but nobody has wired them up.

Would you like to send a v3, or would you rather I make those two 
changes plus the rebase here?

> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
> new file mode 100644
> index 0000000..9f6af63
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
> @@ -0,0 +1,2 @@
> +CONFIG_DRM_ACCEL=y
> +CONFIG_DRM_ACCEL_ROCKET=y
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
> new file mode 100644
> index 0000000..a8b4277
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
> @@ -0,0 +1 @@
> +kconf hardware rocket-npu.cfg
> 
> ---
> base-commit: 7bc349061e8ac3f03b5646f2ae1d3958ce53c460
> change-id: 20260423-rknn-3a394fa3cb83
> 
> Best regards,
> --  
> Quentin Schulz <quentin.schulz@cherry.de>
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3780): https://lists.yoctoproject.org/g/yocto-patches/message/3780
> Mute This Topic: https://lists.yoctoproject.org/mt/118974524/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
