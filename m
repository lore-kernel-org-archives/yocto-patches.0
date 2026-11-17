Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1685.1794932850931257782
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Nov 2026 08:27:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=bzc2WzlA;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55bd96affd2so12566121cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794932850; x=1795537650; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLt0FOAlDWXN9q1/1LdhqIrVhvki3505nyub6G+HJjU=;
        b=bzc2WzlAgaU4NLS5NIbJzuWLaalBHCG4Dkxcbqp8BJhfobRZuuG4SwikfRoUAPnonw
         jzFELHi0T4rMXN44Pe8P9mvfN78f8Y4UtBByTFzjXmS81RAjAdmuDYHr+HOQ6FWH1vQo
         Y7qXXC6eroDsO+258oP4roMKeQGh6VzAkzlfFbHnffkV2b4p4EmNxsnaP0JAZcZgC+3o
         Jmf4hLDux6APSnFlTiLq4ZqX3M3tHfbjPp5OEG4mcmVhxI/2eDrCkx/PRwtbpnRmpVly
         RFghWWre7SesACPhhwmBi/GviEm9IMRwLLbJKAyBmLELawa4Ys5OVED6vyXnzk/PLKtm
         zuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932850; x=1795537650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLt0FOAlDWXN9q1/1LdhqIrVhvki3505nyub6G+HJjU=;
        b=Go/7gDtiazIJ1w/uP2BZff/zIFlTDAW7byiclLZUvSTWbnEdAHrYH0HT6pOPtY3zv9
         HMQKsNCSckB5cmLIlvOvMG06vfN+OhQn7maIv+d8XpmmOZc7jVluHvObN9tb6/fgSBma
         nNg5sEY2oeh3GgYRqMpAn2WYKAhcGFbwDRa5dv8RcNXpczjrfxwZ5KwN0AAlki/r2vfl
         O8QxEc+DgFT7AX1hyFdc/EUO/1oOd0jUNCdIS7cS8wv1zmtnWMn044CCN5/f8O2FIT62
         QueYPu7EkJaet1nVhjzaVNNbBr96R38oV4F24kMmXogFnaG8LKD2C7m+BSf50Yrfw99Q
         T2pA==
X-Gm-Message-State: APuU4Z++9ocKQM9etr/K6IPqpu8A/IqTmf2TqUQX8NUauAWTd7KnFFju
	j8gF7OPy/t2WhotxHA58ujRPX6ebriYPFbBFRXJxwY9GEPf5PjUVh/v+Gm7Rkw==
X-Gm-Gg: AYBFou17fhKXbnc13P0HcX4gNJKvG1aszMqbFZOYS4hFdFLcMlZM6J+QSBW2ofBi1xy
	M2AQgSd0jGFx7AuROBu3qtC/ZjfK4QZ8uUECEXDyum7O5GrrNlI+cyidadiRlCGsywNplzrlBxM
	UEsK4PeVLeR8lzyaxH756FAKHVNrAiFkf/+GWEFGu9XnWSbl7h3Xs058CJNH+yFm0AAeABGZOl2
	kL6puubIfqaN+SNt8s7PoVjyBUsbsWuTz1KiijA6flf0ipHyCuBvXXg8zvb4465Z4XgvKMFNx6N
	0s9Cvtm0m9mfBgIfipgXp/CD2R3DifZQ5bgRIivORzxvqJAX8eU399D8Vl+LCm9417hIzr1PC0m
	+RysCa4h2qYBdEx/Lg+OEe1Aaym/qpnq593o8ujPDqoT2V8xHj550wE6Pu7foLz/um0HLrTdlfc
	R0zeIxXbq+fj6XWDu1UZlvxZ/HJm7QN2mEVSQNUJ8df+lOgZIFt4+CYBykIi85Uo5L6uRwR+w0b
	xS0JgEPj6ZL2ZDNrsIPuyEaDsmcvTORT7jTRvr+IeDyn9/V5EZ4wd/GuG5XD0cBBfTWeZnFATUt
	LnMKjpEKt/9+sblAdsiiRI411wF4cWjNH0WU5fFVLzg1tZKjYfmWOTX6TVDXgaC5rwVAZOZ1mYM
	EuxJwNrC7t+qIlvteqlRDrjGIRgIRX99X
X-Received: by 2002:a05:622a:5595:b0:55d:2f53:4e8f with SMTP id d75a77b69052e-55d494ad914mr44981981cf.16.1794932849625;
        Tue, 17 Nov 2026 08:27:29 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9210fc8f89bsm6162706d6.19.2026.11.17.08.27.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:27:28 -0800 (PST)
Date: Tue, 17 Nov 2026 11:27:26 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] kernel: add config
 fragment for lttng-modules prerequisites
Message-ID: <avyAbqPASigfXaFy@localhost.localdomain>
References: <18E48235E3D3F81B.190157@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18E48235E3D3F81B.190157@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5461

On Tue 2026-11-03 @ 05:28:34 AM, Trevor Woerner via yocto-patches wrote:
> The machines in this layer have no BSP description in yocto-kernel-cache
> and build from an in-tree defconfig via KBUILD_DEFCONFIG, so the
> standard kernel type's configuration never reaches them. Neither the arm
> nor the arm64 defconfig enables what lttng-modules needs: kprobes is a
> hard compile failure, and without the tracing infrastructure the build
> silently produces no modules at all.
> 
> Ship the missing subset as a fragment in the layer's own kmeta, so it
> resolves for any recipe here rather than only for ones that fetch the
> kernel cache.
> 
> AI-Generated: codex/claude-opus 5 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v4:
> - reword the fragment comment so no line opens with a CONFIG_ symbol
>   name; kconf_check reads such a line as a malformed "is not set" entry
>   and reports the fragment as badly formatted on every build
> 
> changes in v3:
> - move the fragment into the layer's own kmeta and reference it from
>   KERNEL_FEATURES, rather than adding a bare .cfg to SRC_URI, so it sits
>   with the layer's other kernel metadata and can be named
> - enable CONFIG_FTRACE_SYSCALLS, and justify the symbol set by what
>   ktypes/standard already gives a cache-described BSP (features/kprobes,
>   features/ftrace) rather than deriving it from first principles
> - leave CONFIG_KALLSYMS_ALL unset: ktypes/base sets it to n, so the
>   lttng writeback probe is dropped everywhere and this layer should not
>   diverge
> - considered yocto-cfg-fragments (as meta-virtualization does) and
>   CONFIG_ENABLE_DEFAULT_TRACERS as a lighter route to tracepoints; both
>   were dropped in favour of matching the standard kernel type, which
>   every other linux-yocto BSP already gets
> ---
>  recipes-kernel/linux/linux-rockchip.inc          |  1 +
>  .../rockchip-kmeta/bsp/rockchip/lttng.cfg        | 16 ++++++++++++++++
>  .../rockchip-kmeta/bsp/rockchip/lttng.scc        |  1 +
>  3 files changed, 18 insertions(+)
>  create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
>  create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc

Applied to meta-rockchip, master branch.

> 
> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> index 6c62e849834c..b87cb7a14bf8 100644
> --- a/recipes-kernel/linux/linux-rockchip.inc
> +++ b/recipes-kernel/linux/linux-rockchip.inc
> @@ -34,5 +34,6 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
>  SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>  SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>  
> +KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
>  KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>  KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
> new file mode 100644
> index 000000000000..cde4bfcece67
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
> @@ -0,0 +1,16 @@
> +# Prerequisites for building lttng-modules.
> +#
> +# These symbols are what ktypes/standard gives every BSP that has a
> +# yocto-kernel-cache description, via features/kprobes and
> +# features/ftrace, trimmed to what lttng-modules uses: kprobes is a hard
> +# compile requirement (src/wrapper/kallsyms.c), and the tracing
> +# infrastructure is what it traces with - without it the build produces
> +# no modules at all rather than failing.
> +#
> +# KALLSYMS_ALL is deliberately absent: ktypes/base sets it to n, so the
> +# lttng "writeback" probe is dropped on every linux-yocto BSP and this
> +# layer has no reason to diverge.
> +CONFIG_KPROBES=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_FTRACE_SYSCALLS=y
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc
> new file mode 100644
> index 000000000000..2d0412541c81
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc
> @@ -0,0 +1 @@
> +kconf non-hardware lttng.cfg
> -- 
> 2.50.0.173.g8b6f19ccfc3a
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5218): https://lists.yoctoproject.org/g/yocto-patches/message/5218
> Mute This Topic: https://lists.yoctoproject.org/mt/122073729/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
