Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11156.1795003913946037318
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 04:11:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=nBVjv3At;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5364d86f7f0so10348671cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 04:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003913; x=1795608713; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjupTNLfHAFbFlB2uDjmn2ih+XXmDaw75BZykYuzCl8=;
        b=nBVjv3AtIOM5o8CHulZVV423b3IdETqTqqdq1gC8SpivWPIjL9eTXMNW1LSboVLvGU
         WiE2aTJziuqazP6/QLdkEUgLO4VBKMw5SJroE/tmBAGAUNL+HWrJW/nTs/ScVLrAIAwz
         MN2zvt5XXVGUuYHTga0gympkWHMSQfka0whNbsrYaGpP5e8DGgC68VxFaYKzgwn5cbSq
         tj93dvp6rxWyzGXhKDdOvwrF81+WjSeCZNINwDvYTM97DMoVQLoaWreMwBUmiKqEl5NF
         s0I9MpTRoSaahcXwzlvWdHVb0YG4MIo5Ty/CwtLdibFm/7Jb5KgbUJSTllHcnEe1mFRF
         zVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003913; x=1795608713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjupTNLfHAFbFlB2uDjmn2ih+XXmDaw75BZykYuzCl8=;
        b=W42sPPVAHnfHm4sF3Nyukic8gULktfcqHT90HTwPzDhRHzXuIzcciDE9nPQP9Iau4w
         5tf0H+jMDxo4mGU9K1MS5mDWOKn0BoWwedjsyQQgu9XbwBP8egS5Ww7k5OmfpFtZbSOL
         mDmGAxDSOwEBbQjJjHW98mZLWmoMDEUZHCZddZPS/FRsZp+9xz2bSomhYYWmvm3e2j10
         JsSYro/KgUzpYErCk6++rqF0wcXsLRpO4VD3nD2eOPYQ/PDRk1npAA+x95TJzG42+kYQ
         bDJnrzgxL714t4h9taeYpOGfq9G9RI4MpDfVyrgh6OADIC7mZVgPZFhYHnTDvF8cWAWT
         8wHw==
X-Gm-Message-State: APuU4Z9/edw+ME9huHbF9mcPrEKKTCTMFnJEgER5V53Z58FwzVykWoxe
	ozX12DQq8I33qOoZeUAWIzlBZCKEIcdPSLayCp7jCB+QLPeoS2hlfreO3Ux/6w==
X-Gm-Gg: AYBFou22zIj+3UF+HJ+t5V0Ff18I2Mihh7yVe7qHp5f3EyzitKSPpbtqkcssSSDchDK
	wSMHdlgXPAYXqhVR/+hhXoDY+J4xoZlL2XHZtNDMomw5EBbeJlwXRySwrRN0jmV7v5B22FRxsfA
	F8OL+zd3ya9PRjd/qaXUM4D2AdtewTYOQVDEJzn7R2jdBVNrAk04Afsobco2xT2uG8XlQOlVRKn
	3sm0Gm5ue3hSRDYPParXHD0L+JgmU4sNDa2RuT0jaTwjHsINdjUlFuq8JMmrJCcdb0afvQ9xC/t
	J4HHr8e/mcYDw2cUslezyPQMvQuFK+kyZjLTgO3dTFHkg5WaZHrH6ki4wAgWoJT5vmXviQY+pVa
	d6Q8lpgp7w6SxfGfc9aWG7WagOZfucg591Xg8DK9fQGUS3tzo6FWtsyEwHRTBjLxy1ZBhWOhm0B
	gnrZAEO/BHRp5FcxH+SrQ/VsctSmzNxpJYX4vykcsDJv0qBxwMwWAtS7lT6fIUSkHg7+PQB3y9C
	KgU1618qhDHiH8Nw3nULXZcNACi3Md2xFgCpveAkFkjULjt8qhySBB5xu/EH1ZdO5ogDAUxhS8q
	vhbpO6nvV4ZIeJcPZw19K+FBIi/r1TENdoWOxeebkjXMd5PQwoblRzAiNdJGd9Af4FHZsSpnSj/
	4ZsdZ8o3LnEabxVX6pku/xSlfqkqRH3U=
X-Received: by 2002:a05:622a:4889:b0:533:9753:4e03 with SMTP id d75a77b69052e-55d5a03402dmr37898531cf.0.1795003912705;
        Wed, 18 Nov 2026 04:11:52 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d113f6sm20218456d6.9.2026.11.18.04.11.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:11:51 -0800 (PST)
Date: Wed, 18 Nov 2026 07:11:50 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] kernel: restore the CPU
 errata the 32-bit arch removal drops
Message-ID: <av2WBjfT3bPP9AEQ@localhost.localdomain>
References: <18E8E25C640D8F2D.1313660@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18E8E25C640D8F2D.1313660@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 12:12:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5470

On Tue 2026-11-17 @ 11:35:28 AM, Trevor Woerner via yocto-patches wrote:
> The fragment that puts back the options multi_v7_defconfig only gets
> through "select" from other vendors' platforms does not cover the CPU
> errata workarounds those platforms also select. Of the eight the removal
> drops, six apply to cores this layer ships: five Cortex-A9 errata for
> rk3066 and rk3188, and one Cortex-A7 erratum for rk3036, rk3128 and
> rk322x. The remaining two are Cortex-A8 and Cortex-A15 and are not
> relevant here.
> 
> Found by emptying remove-non-rockchip-arch-arm.scc and diffing the
> resulting configuration against the one the layer builds today.
> 
> AI-Generated: codex/claude-opus 5 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> Applies on top of Andrea Ricchi's "kernel: restore options the 32-bit
> arch removal drops", message-id
> 20261104130230.236614-1-andrea.ricchi@amarulasolutions.com
> ---
>  .../bsp/rockchip/restore-arm-selected-options.cfg        | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to meta-rockchip, master branch.

> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> index ababaf6c911e..df3c6ddd4790 100644
> --- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> @@ -24,3 +24,12 @@ CONFIG_HIGHMEM=y
>  CONFIG_REALTEK_PHY=y
>  CONFIG_USB_EHCI_HCD_PLATFORM=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
> +
> +# errata workarounds the removed platforms used to select; Cortex-A9
> +# covers rk3066 and rk3188, Cortex-A7 covers rk3036, rk3128 and rk322x
> +CONFIG_ARM_ERRATA_720789=y
> +CONFIG_ARM_ERRATA_754322=y
> +CONFIG_ARM_ERRATA_754327=y
> +CONFIG_ARM_ERRATA_764369=y
> +CONFIG_ARM_ERRATA_775420=y
> +CONFIG_ARM_ERRATA_814220=y
> -- 
> 2.50.0.173.g8b6f19ccfc3a
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5463): https://lists.yoctoproject.org/g/yocto-patches/message/5463
> Mute This Topic: https://lists.yoctoproject.org/mt/122316650/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
