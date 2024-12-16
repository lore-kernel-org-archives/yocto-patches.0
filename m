Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA55AE77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 04:00:16 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.49558.1734321608144433422
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 20:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZM3r3Xwm;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8e773ad77so31415376d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734321606; x=1734926406; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKudAxTKspGQR9j8hyI9Ig8nJBI0tFIffAeoNe37Jzg=;
        b=ZM3r3XwmZO+F7PQ5B7cIO5ITMPO09W548TNt6gr5y4/FL/xZ7eyhrTvT7+Ns8ppb1Q
         L0pTTNjThZwKRoDkfR9z7heayCm7Oi7BO5shgCapCfpv8+hy8gk+NArPgH3hjhX2effg
         GG4ePo0u7KfEGkSx82A7Nr8S5GxZF+JurUiug6ZL+3mDgAS5EUvx1tjZ3A3FKWG+cUTu
         UdL0QwAtUrH1joLXzj5ii/fRTc0q5wX/oOKH4aI+3vu6kCKTXybKr8jb4NRCNh0xK5dY
         pbNSrzvtJykcjKP/OlEllqXZnFe3WLJAMkv3QGNtxyBvOPpp4tbX66+JTlw8sx8T0PH5
         p00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734321606; x=1734926406;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKudAxTKspGQR9j8hyI9Ig8nJBI0tFIffAeoNe37Jzg=;
        b=qQEl6cyAvrfE1nmrDbBNHqtMJe99aV8P8uzXn77feqPkKDII2OPu4l9JUSBZOpmzOz
         Tr+bydBcfYdRD/Rjv0cY5N701O3PoHsB17ExqffXzeAHG9RmlBXkUsGcUl4X6YZ9tzIR
         J446IxgQhzI93PG3dh/4BK0IPAzc250pbPRHASuqV0MKHqMEVeozXdzVGlA4JmDswG8g
         H546OYiVCcMIlxNGqXHlP88qqmq5UoF8ciqTEu/cFDnU6suMvJrZ0YM++Laub0zrLyS+
         hGq9dkS9XYYmqM1Ziuv21gLO+tcvpJZ7QSJpu0R22vlfM8QRB+ikNMZnHbhW9UxUrKNR
         13iA==
X-Gm-Message-State: AOJu0YxHtXLS++JatwdNkMRMj2D1aMyyYr47jlQVmASzN+YPSSdrsGws
	O1NmhIcyOk4b7ARiMePgZ9ekcu8YX2L1161aeKPZjOBbIvyR4AViv9TGFg==
X-Gm-Gg: ASbGncvsrsqR3IJeIi/u98Mb6a6wWVSLC5P9yYhWwBJx210s44ZFTaTwTvG5ld4trKb
	RyOZjRJ42UlyMxDkX9HNQuCOfWFV3zIs69pK5/MQUPxM11e1v+6iSgJlKZNj7O1UAzd75kVHIjU
	oPH5yK067LjpvXHlwovobEiu0W+tQIxTrv+jY7q3o1bNwrXnuaaXoy6gPdHMAbRqFsxUWX9lv6F
	jn95mhZ5Aj8Kjdn2oOrxKQFjTSHfur8YlZk4B6p7LBDzb6uZAbdqQ4Z9sNFKSiIclY+thUbmUms
	f/ngxxEy
X-Google-Smtp-Source: AGHT+IFgyLqC7vk8Z7Of3/nE4W4UvjKofZTgvxvYlKDmJbi1Uq1OTCQuXQfAjYZfWX94/tDyLkHQmg==
X-Received: by 2002:a05:6214:1316:b0:6d8:8f14:2f5c with SMTP id 6a1803df08f44-6dc8ca93ca1mr189756056d6.23.1734321606519;
        Sun, 15 Dec 2024 20:00:06 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f79esm23013926d6.1.2024.12.15.20.00.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:00:05 -0800 (PST)
Date: Sun, 15 Dec 2024 23:00:02 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH 1/3] u-boot: switch to upstream SRCREV for rk-u-boot-env
Message-ID: <20241216040002.GD466@localhost>
References: <20241212195718.25203-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212195718.25203-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 04:00:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/924

On Thu 2024-12-12 @ 02:57:16 PM, Trevor Woerner wrote:
> When the rk-u-boot-env feature was implemented, in order for it to work the
> build needed a version of U-Boot that was slightly newer than 2024.04 (the
> current release supported by Yocto at that time). Now that 2024.10 is out,
> remove the SRCREV pin since the necessary code is now part of this release.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-bsp/u-boot/u-boot_%.bbappend | 1 -
>  1 file changed, 1 deletion(-)

Applied to meta-rockchip, master and styhead branches.

