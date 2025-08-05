Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E54C87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 21:46:57 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web10.11064.1754430413239625420
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 Aug 2025 14:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BQNhTTwq;
 spf=pass (domain: gmail.com, ip: 209.85.166.181, mailfrom: twoerner@gmail.com)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e3f01612daso22402235ab.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 05 Aug 2025 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430412; x=1755035212; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edsFrGXMOOyY+CSw8CQyK24dOeJABxQf+eex3dQTZnY=;
        b=BQNhTTwqeRsAPfuw1yy+y8SKdeScXkj3DWEmLYL9vjxxN/i+naVEpfpDcOKpfqxjps
         m6lTIjfC0Fnshmvubp+1+FDP2FQ+flt2xhKI+acMAe2mLLp0VPHqv0BGnLtUkvCKJnlN
         YlQ60oEJbTjf0q1Xusi7nMgg8f0HRwxzbrTg3pAWq1DZ2vfNpI7hGZw0yzJqsrRnW+EU
         YnvxC+JgsxYV93v1XJywZ8HCvh/SYpNnu1a93LQBNG57i+tna4zxPP4A3qhn0JTt/xew
         SADsS5qNMwjo6LVfs4RvuT8QPTY2KNWwwR47BdFEKvSqYs4T7qKDWwsmtV3k6/+ixl4g
         +kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430412; x=1755035212;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edsFrGXMOOyY+CSw8CQyK24dOeJABxQf+eex3dQTZnY=;
        b=gFZaXwdJ9lp3l2V6U1rS6nW9+Dz0XDMexb3nNpaG5Tpngqtoa6vEjPSvuUE5912oiM
         JuAlWNEZLq6t1Gza6Xa5EpF0toNSfYoSKmfxNFLuleDgU0/26nseOOpQwazrjNTgJO4k
         g+A0ZswIWH+z8bb7XKYO5+NtECQFQvSF4gcb+ZQqUp2uwDaxoOsjCarG+cD8UgHjsIP/
         gLZQSVuEaccFP57qL25T4DNl8NwvK/FRLY8EORWQ8m11mG+wzeCIzGmSux3PctzRElA9
         XJDZydEG4aVQJkPx/n4DUpo0v10GrTKFVwteI8B0fFv8FJ0CIURsQ0Njgn3EXP7Z8DvW
         7Flw==
X-Gm-Message-State: AOJu0YwPKuRabPxGRXFVw67zgpdc86KIX3FtJ0XIrsfNvgsF/7h+mfmO
	7cKzaktUc7UNlWf3qSq5zEyLUG3jR9P5PboMGrLWt4NyCCjIOBc/MwtC4GAmog==
X-Gm-Gg: ASbGnctrPApvFxsttNgI9HEZlAxBcndGfj/HfH4K7cboyfIx1XyUDqErJJGKVO0+X8K
	IftT4TgEvlV5UqErilZYzTCY4dvY2EoRtJUVdNqa5feIWjnf1tIQ52Z/V1WZ5gMcefyXrpVdQTZ
	XnMAxUOpuapmC8DkFSOqCI6TX1FIlms74m5NBnGm407Nz4vM6tnFIzDt2MM3FMjP/bJgyEE5Odj
	GgaDWYHcgWrq3U2GqFUNKU3k2pFIfAq+qlgjoVWnz53t8QUc79utT26ECWWNup1zNuNQV71/g0H
	i0cQKkCtZMkUUmQwQ9udD9oGsZioNcRxdIF7fS1YOGghmP4TunOhjuSGFo9/T5XXEuvKyJ5KQE4
	WX4f3Xx/+iOdtTRGWIHEaUEO3PtHc+ICxRBID8HaZ8muHEP7iPldjziQhRaZY
X-Google-Smtp-Source: AGHT+IFFasFXXwQVZAn4XRVrCiR9AI2DB15WlniDhi/3SB4/8QDdAYZQiTBbyjarOCtMMSzA0OXElg==
X-Received: by 2002:a05:6e02:2486:b0:3e2:9aea:8049 with SMTP id e9e14a558f8ab-3e51b8fe031mr3657335ab.13.1754430412253;
        Tue, 05 Aug 2025 14:46:52 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029d41a6sm54105765ab.24.2025.08.05.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:46:51 -0700 (PDT)
Date: Tue, 5 Aug 2025 17:46:48 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] nanopc-t6: add
Message-ID: <20250805214648.GA37396@localhost>
References: <20250803172432.1341178-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250803172432.1341178-1-scott.murray@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 Aug 2025 21:46:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1887

On Sun 2025-08-03 @ 01:24:32 PM, Scott Murray wrote:
> The FriendlyElec NanoPC-T6 is a one-for-all high performance open
> source platform for edge computing, designed and developed by the
> FriendlyElec team.
> 
> Website:
>     https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292
> 
> Wiki:
>     https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
> 
> Specs:
> - Rockchip RK3588 (4x ARM Cortex-A76 + 4x Cortex-A55)
> - ARM Mali-G610 MP4 (OpenGLES 1.1, 2.0, and 3.2, OpenCL up to 2.2 and Vulkan 1.2)
> - 4GB/8GB/16GB LPDDR4X
> - µSD
> - 32GB/64GB/256GB eMMC
> - 32MB SPI NOR Flash
> - 2x PCIe 2.5G Ethernet
> - 1x USB 3.0 Type A, 1x USB Type C
> - 2x USB 2.0 Type A (LTS model)
> - 1x HDMI (4Kp60) in
> - 2x HDMI (HDMI2.1, HDMI2.0, and HDMI1.4, 1x 8Kp60, 1x 4Kp60) out
> - 2x 4-lane MIPI-CSI
> - 2x 4-lane MIPI-DSI
> - 1x M.2 M-Key connector with PCIe 3.0 x4
> - 1x M.2 E-key connector with PCIe 2.1 x1 and USB2.0 Host
> - 1x Mini PCIe for 3G/4G module (non-LTS model)
> - 40-pin 2.54mm header (up to 2x SPIs, 6x UARTs, 1x I2Cs, 8x PWMs, 2x I2Ss, 28x GPIO)
> - 110 x 80 mm
> 
> Upstream kernel support for the T6 has matured enough to be usable, so
> add a machine configuration to allow people to migrate off of the older
> bits in the Rockchip BSP layer.  Note that there are two variants of
> the board, original and a newer "LTS" version that drops the MiniPCIe
> slot for a modem for two extra USB 2.0 ports and adds a USB-C connector
> for the debug UART.  Devicetrees for both are shipped.
> 
> Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> ---
>  conf/machine/nanopc-t6.conf                   | 15 +++++++++++++++
>  recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
>  2 files changed, 17 insertions(+)
>  create mode 100644 conf/machine/nanopc-t6.conf

Added to meta-rockchip, master branch
(with the addition of an entry in the README)

Thanks!

