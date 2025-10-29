Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0316CCD1BF
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 02:33:23 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.26239.1761705196580299738
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Oct 2025 19:33:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JAVnKhpg;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e89c433c00so72488781cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705195; x=1762309995; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arJF5jd15P4D7CmBANqKkRReko0sYnR3mgL7w8R/PMg=;
        b=JAVnKhpg6yS17BVLlBmFV5uuzvP1wmwuMyi22APdfrD7dpwLs3h9XVfKKBLmU0Gdep
         RluQXtWn0UVSE8t+DfES99dBBIaWzyhPSvKnHrQ8vdY2mk5qWFQlWS3iuSaKro9BBngq
         He/pXREqbaCcWDHY53s86IOYtpNZhr6iAO9qKh3krsp2bBmMdz8gSS017pcaJ0HeYmci
         zRy70lIEMo0yI3haI2cwrlyUedFNERZwoZnifIZ+HDgDyJ207r2ogn3JpSuI82liYdVm
         X8CwET5DDvEp5QEoix1AlcpTooR6L/HwLDhESxXOpjGSMGd4Yntb3fU/NWxetJJTfihx
         l2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705195; x=1762309995;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arJF5jd15P4D7CmBANqKkRReko0sYnR3mgL7w8R/PMg=;
        b=ZyL6IKA30t60Xs5mhgVlaBMhxVRJvMrUjQ/oCsAQSs+2hjBhuHlsrl7M+oMburOmSU
         i2Zz76qkV/JxCuuQYZMtJVf+dSk6ERZd+fWYEy4sc+mA0PVp2i/PqUGxtmej96er8l2H
         Uuh0DmYw8ySoC7SDpZfrvPVwMdGDwWFVxWbDHbTBtrekmnz7A70QRqDcR/rnjAiqX/fE
         Qo7NX7biqvQekLvsNGItePO503J177eMZw1t6reqiaDxIk9q2kGmkqV2qxr8UvKnAQq1
         FwDi1y+4ucXxAY2cKYCX9ri8AdaWikYJxCccmrfayLCBiVvlLH1Yt2LSNCI8jyFoN/ji
         0WtA==
X-Gm-Message-State: AOJu0YwypQfSuKPj9Zoo9yd4Ca/Cq2uoM457sBJCa0XVN9rmML+mYH54
	Q0otEZ8vSzCybyHuJ8UkuuvK6EaPDmaXa48D4NlDHqL+GqzZVJR8xKc02WzWmg==
X-Gm-Gg: ASbGncv53XzwYc6WLWKkhd4rGaxoDlTguOmuewiZYKNTRuRGjzC0z+YiLhlLeKruzkb
	x9334cN8G6PyJblWN2gOrYInEXSARSuBGPwrFb4nCWW7jkuy+lrYc4wLmzqwr6GFBQTWuCiEzWY
	W9ysY3MmywccePXAvDLZQibnRVORAwRATOgY0Z2IKZJe7ak0mpqCCkx8Oj9+M69CVpbSJVFtELD
	B+gPY1NFV3K5RMB+YhAS7aWj4x2H3aFx18ySeUZEL7Au4T3fKf32O6Dd19KI8PQdoEV7mUouUR+
	0O0D0LGVfdqYq4TG/csKdcxNkLg4dYqAJFSpvr8e8fKkr/avD081TN5v1ldQhELqVt2QwQQM1Is
	FU9Edpl5NW8swJp8QBDRgjV7s9wSEH8FT63K78VIlzgFoYf7uluxNwPq8vL4XD1Yli1VhNfBqOS
	YWOkzJQGme0uLisKCmCkLF5j7iVCQ=
X-Google-Smtp-Source: AGHT+IGl5C56YxurFrAZURMR8i6+AknNvsJLDIf4jxncqdVxDabCfM3rd6KrmG5BtlvkO10OTxGBkg==
X-Received: by 2002:ac8:5a06:0:b0:4ec:f1cc:37c0 with SMTP id d75a77b69052e-4ed15cbec04mr18773131cf.81.1761705195032;
        Tue, 28 Oct 2025 19:33:15 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f262698adsm975162485a.56.2025.10.28.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:33:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:33:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v3] rock-pi-4b-plus: add
Message-ID: <20251029023310.GA26278@localhost>
References: <20251028134734.974027-1-contact@schnwalter.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028134734.974027-1-contact@schnwalter.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 02:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2400

On Tue 2025-10-28 @ 03:45:16 PM, Walter Werner SCHNEIDER via lists.yoctoproject.org wrote:
> The Radxa ROCK (Pi) 4B+ is a SBC with an overclocked RK3399 SoC (the OP1)
> and it comes with WiFi5, BT5 and PoE Support.
> 
> Product Page:
> https://radxa.com/products/rock4/4bp/
> 
> Documentation page:
> https://docs.radxa.com/en/rock4/rock4ab-se
> 
> Specs:
> - Rockchip OP1
> - Dual-Core Arm Cortex-A72 @ 2.0GHz
> - Quad-Core Arm Cortex-A53 @ 1.5GHz
> - Arm Mali T860MP4 GPU
> - OpenGL ES 1.1/2.0/3.0/3.1/3.2
> - Vulkan 1.0
> - OpenCL 1.1/1.2
> - DirectX 11.1
> - LPDDR4 RAM (2/4)
> - Onboard eMMC (16/32/64/128 GB)
> - 1x M.2 M-Key (4-lane PCIe 2.1) supports NVMe SSD
> - 1x Micro SD Card Slot
> - 1x HDMI
> - 1x 4-lane MIPI DSI
> - 1x 2-lane MIPI CSI
> - IEEE 802.11 b/g/n/ac and Bluetooth 5.0 with BLE
> - 1x Gigabit Ethernet with PoE support via an HAT
> - 1x USB3 OTG/HOST port
> - 1x USB3 HOST port
> - 2x USB2 HOST ports
> - 1x 4-ring 3.5mm Headphone Jack
> - 40x GPIO, UART, SPI, I2C, PCM/I2S, SPDIF, PWM, ADC, 5V in and 3.3V out
> - USB Type-C with PD and Quick Charge
> - Dimensions: 85 mm x 56 mm
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Walter Werner SCHNEIDER <contact@schnwalter.eu>
> ---
> V2 -> V3: Updated README
> V1 -> V2: Fixed name
> 
>  README                            | 1 +
>  conf/machine/rock-pi-4b-plus.conf | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 conf/machine/rock-pi-4b-plus.conf

Applied to meta-rockchip, master branch.
Thanks!

