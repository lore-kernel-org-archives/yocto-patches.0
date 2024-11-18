Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2ED591AC
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 18:03:27 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.1644.1731953001707457489
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 10:03:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HhGIllRJ;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b15467f383so225677985a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731953001; x=1732557801; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIVcoMyESb3cMzbuIuoYh7E2O4mOG5GoSMT7Am0BKGQ=;
        b=HhGIllRJcXfzy42Ybb5XUnvi7D66WT03hzK4KgGLOIljoX1lkrsbQFn0lbVmmttWKu
         GVA8WgG8mYTMJvF0vZe2thAcgf237Yv7ro1fMGt0ICRO9tLGYBtI/qNqnOjVuZEdAyBr
         LN4sXVz0LFIQH4IlLopj+VreeF361oT/mir9TpSFrr9PtM3EPX5LBEcc5aRUiNkAALMU
         YSOLsySKwV06HqOYevFcz31+opmUpl7u3j97tDAbt1qTYbzZJFoyQs3cB70ir6VCfz7u
         n3e7svcUWYqGK+AdYRDS0H0vgFk5N/CXi0wLtbP0GNCCvqu/zGii3pg9j8ZEQWADR8bV
         7ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731953001; x=1732557801;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIVcoMyESb3cMzbuIuoYh7E2O4mOG5GoSMT7Am0BKGQ=;
        b=kPZyma/fJVa3WPc4Tnr1tFP1umNaLaR8gKf2Wmu7q1poQ5/HAPt67uDV7DHG09w2E3
         /+kidKTeXBgr00CXPu85GCqQSJVWXFMOGT9hfl1eLFqTYcjomEEMj89F/OhX9HA3MXaG
         jMUstXi3iq4DY06tV/smbUY0nasxj+zohHd8+tDHTU46qBHPNo4U5aXXDkZErQeqIUws
         2hLfkgF2d3v0a5UFX1BNaBe6CaeXVDMYN5oYpO+U71sEHw0UX+Wu3UNMYFSrcXNxNR7J
         ZFKJlPmPl3Fiw1rd2zVxs4vl8vBa4XM0IB2T2BH92xxozr0CaHVNhYs4T1F1j5lZlyvU
         6YTQ==
X-Gm-Message-State: AOJu0YywJ2izfBZnSQW7kJbcBp79gkY6Vlsubu3KcaM2oFAV7LJgEonf
	XmWkRlOGUNzqmRbRgWokLbUTTu6yz+mYivcLbLrpIuEvAL1XwLOi
X-Google-Smtp-Source: AGHT+IHh+GFnPVxAFhqqgPHL6PYHfZBT8hRajJNosVMuJ0CDnUFwGE5301qgFUqx2hOfseP8T7E8CQ==
X-Received: by 2002:a05:620a:472c:b0:7b1:4f5c:6e86 with SMTP id af79cd13be357-7b3622ddd0amr1959355385a.17.1731953000562;
        Mon, 18 Nov 2024 10:03:20 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc18062sm38822566d6.48.2024.11.18.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:03:19 -0800 (PST)
Date: Mon, 18 Nov 2024 13:03:17 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: "Paul M. Bendixen" <pbe@trifork.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [meta-rockchip] [PATCH] SOQuartz: add
Message-ID: <20241118180317.GA17525@localhost>
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 18:03:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/820

Hi Paul,

Thanks for your patch!

Are you using "git send-email ..." to send your patches? The patch itself
appears to be base64 encoded. It looks fine in email readers, but using mutt
to save the patch then try to apply it is running into issues.

I'll see if I can figure out the magic to decode (done) in a way that makes
"git am ..." happy (not working).

Thanks, Quentin and Ross, for your help :-)

Best regards,
	Trevor


On Fri 2024-11-15 @ 02:51:08 PM, Paul M. Bendixen wrote:
> The SOQuartz is a RK3566 based compute module and parts of Quartz64 series
> The Model-A base board is one possible board that supports it
> 
> Website:
>      https://pine64.org/devices/soquartz/
> Wiki:
>      https://wiki.pine64.org/wiki/SOQuartz
> 
> Specs:
> - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz
> - Mali-G52 2EE Bifrost GPU@800MHz
> - Raspberry Pi 4 CM form factor
> - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.
> - optional eMMC from 8GB to 128GB
> - optional 128Mb SPI Flash
> - 10/100/1000Mbps Ethernet
> - WiFi 802.11 b/g/n/ac with Bluetooth 5.0
> 
> Exposed preripherals:
> - 1x HDMI
> - 2x DSI
> - 1x eDP
> - 1x LVDS
> - 1x CSI 4-line
> - 1x Ethernet
> - 1x USB 2.0 OTG
> - 1x SD
> - 1x PCIe 1-line
> - 28x GPIO
> 
> Model-A baseboard:
> - 1x microSD - bootable
> - 1x HDMI Port
> - 2x USB A 2.0 Host
> - 1x USB C 2.0 Host
> - 1x 5 pin USB expansion
> - 1x Ethernet w. PoE
> - 1x 40 pole Pi2 compatible GPIO
> - 1x MiPi-CSI 2 lanes
> - 1x MiPi-CSI 4 lanes
> - 1x MiPi-DSI 2 lanes
> - 1x MiPi-DSI 4 lanes
> - 1x PCIe open ended
> 
> Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>
> ---
>   README                                      |  1 +
>   conf/machine/include/soquartz.inc           | 15 +++++++++++++++
>   conf/machine/soquartz-model-a.conf          | 12 ++++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
>   4 files changed, 29 insertions(+)
>   create mode 100644 conf/machine/include/soquartz.inc
>   create mode 100644 conf/machine/soquartz-model-a.conf
> 
> diff --git a/README b/README
> index 09f8691..85ab2ec 100644
> --- a/README
> +++ b/README
> @@ -45,6 +45,7 @@ Status of supported boards:
>               rock-pi-e
>               rock-pi-s
>               rock64
> +            soquartz (on model A base board)
> 
>       builds:
>           32-bit:
> diff --git a/conf/machine/include/soquartz.inc 
> b/conf/machine/include/soquartz.inc
> new file mode 100644
> index 0000000..6714efc
> --- /dev/null
> +++ b/conf/machine/include/soquartz.inc
> @@ -0,0 +1,15 @@
> +#Copyright (C) Trifork A/S 2024
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +# Common override for basing a SOQuartz design on
> +# https://wiki.pine64.org/wiki/SOQuartz
> +
> +MACHINEOVERRIDES =. "soquartz:"
> +
> +require conf/machine/include/rk3566.inc
> +
> +# A machine using this baseboard could use these options or overload them
> +# UBOOT_MACHINE ?= "soquartz-cm4-rk3566_defconfig"
> +# KERNEL_DEVICETREE ?= "rockchip/rk3566-soquartz-cm4.dtb"
> +
> +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> diff --git a/conf/machine/soquartz-model-a.conf 
> b/conf/machine/soquartz-model-a.conf
> new file mode 100644
> index 0000000..b8be4ca
> --- /dev/null
> +++ b/conf/machine/soquartz-model-a.conf
> @@ -0,0 +1,12 @@
> +#Copyright (C) Trifork A/S 2024
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +#@TYPE: Machine
> +#@NAME: SOQuartz on Model A base board
> +#@DESCRIPTION: SOQuartz is a series of Compute Module by Pine64, the 
> Model-A baseboard provides standard connectors for the compute module
> +#https://wiki.pine64.org/wiki/SOQuartz#SOQuartz_Model-A_Baseboard_Features
> +
> +require conf/machine/include/soquartz.inc
> +
> +KERNEL_DEVICETREE = "rockchip/rk3566-soquartz-model-a.dtb"
> +UBOOT_MACHINE = "soquartz-model-a-rk3566_defconfig"
> diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend 
> b/recipes-kernel/linux/linux-yocto_%.bbappend
> index 5528bab..56ec9d7 100644
> --- a/recipes-kernel/linux/linux-yocto_%.bbappend
> +++ b/recipes-kernel/linux/linux-yocto_%.bbappend
> @@ -22,6 +22,7 @@ COMPATIBLE_MACHINE:rock-3a = "rock-3a"
>   COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
>   COMPATIBLE_MACHINE:rock-5a = "rock-5a"
>   COMPATIBLE_MACHINE:rock-5b = "rock-5b"
> +COMPATIBLE_MACHINE:soquartz = "soquartz"
> 
>   SRC_URI:append = " 
> file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>   SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
> -- 
> 2.43.0
> 
> 

