Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0549ACA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 12:52:17 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web11.21169.1757076732459704647
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 05:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V0M8ZRD/;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b340966720so14270831cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076731; x=1757681531; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vxY7ag2dw8na1G0gXSV1yti4Wnj0eraNkqiVNIWsEI=;
        b=V0M8ZRD/0scPzmknLF1dbI/9piSNkJw1uuZXswt3Q1m0D7G99pQErKevTAg9o7XkDF
         uz2dz4S9o6PI7WGmSK3fcinCtbdLTM3WPU/j/+940qRJYud/ThnARb9JteamiIsSuwfp
         3Biu+M/+tRqcb/cLuwBJLjfditlG96WijVfATyonTt0Mdz1LQUhpA7GG8WYTfwB/2UuT
         +o+SN6SXfBq7F4E1yIaTqQzoeVG+WHNt0XGoq1pkmyQEpBhRkvgLwzYep3Dgy8ZS7Hav
         D6joTZfVWbgoMf0aGzl4UZUhWIlzB6RudHmKIW/gGzFEfNW226pPzAEzk+qfuwns1UiV
         frqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076731; x=1757681531;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vxY7ag2dw8na1G0gXSV1yti4Wnj0eraNkqiVNIWsEI=;
        b=enu70KRmEPIVLvz8IfS9LnuYh06icqJXlzGkfy0/GdfwdQiNUrZYqd60ANrxAg9AU8
         CrP5URZiP099gdkz2VXZs93RZHOL8uotk7DFiKxTJhqZVEBCr1aG4nNq7VONHvSvL59D
         ll4yp2Zsoo7tBbSyaVWxtx2FuHh49spAx3xb8pMwpi0Exbg7WCvYUIp8pB3ZTMhiftpU
         lyNsuS44XfnG7rxoZTgGwiOKDAnlwo31v185x5lYUwWMioiwbPHqskLXZvGYSQK0Nr8b
         6vIBWHBhyrRbeMjxdjws/YR2UXeCxBETmczMexyxiNy3JFk4fPHyIwV+qkDGfzLS6oUi
         Odrw==
X-Gm-Message-State: AOJu0YxnQAVPmkdew16RFAbabpXwEtsuqR8guVQiSWL2wLTBe0AWJUFP
	vMmBpoyKIdXaRN9M8jmJN3wBAWWKM/g9tHJJ1i8eH7Of5V9k0wOWhHw0ywC0SQ==
X-Gm-Gg: ASbGncuzvjQKYVu9MMwHWrKoQ5tsO8bpqpMymXooEE1LflrcVfkxn2yly0NZE5rFu3O
	nlb/LkpOKEzdepJE2ADDU6dzBbsJbCPWQDZ+XF6lkcflsN7cqkaIoTCJX4AvD8wGaIQiutfYVjd
	QGveaSmNWxwRuw+B+wE7IcRE2bKUnKoAZar2YPFtpwlUh5ju86jRZiVT7EHYvh9YhcKxgAo9wxG
	L30V5E7HBamIe1uNPAW2C/bfwJa7z7jDqHEqP45+sA+/SePmH6r9veEluwHABJt4wPRRHHJymBV
	sU8c/+PPXltHlayT1xMa7omR4ibpKrXlP16ScD3yottZmxJWiUxf0H0JxCpjMiQtMliEduA47iY
	AoNqmoz3OUyIDKm3uK1fzz1BFDHILClnbFuGItYO06Ihqh9bqf6W+PLmp1q6j
X-Google-Smtp-Source: AGHT+IE9pO+z0EPpKlq8ANjCggLfZf+KnPMPdhjDSHZdupLpXHuobgKip0soSnIKBBjXrb3NpRHGSw==
X-Received: by 2002:a05:6214:20c5:b0:720:4a66:d3e8 with SMTP id 6a1803df08f44-7204a66e0e2mr198390126d6.19.1757076730413;
        Fri, 05 Sep 2025 05:52:10 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720acdff3acsm65177726d6.17.2025.09.05.05.52.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:52:09 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:52:07 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/2] nanopi-r4s: enable
 r8169 built-in
Message-ID: <20250905125207.GB36766@localhost>
References: <20250904194529.22656-1-twoerner@gmail.com>
 <20250904194529.22656-2-twoerner@gmail.com>
 <edc0bc23-fc67-4f2f-a59f-b98e48128942@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edc0bc23-fc67-4f2f-a59f-b98e48128942@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 12:52:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2142

On Fri 2025-09-05 @ 11:10:45 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 9/4/25 9:45 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Since the Realtek RTL8169 is part of this board, enable it unconditionally in
> 
> The FriendlyElec wiki and product page doesn't mention this part number,
> weird (but armbian and openwrt forums do).

...and so does the output of lspci.

> FYI, it seems the default value when using "defconfig" defconfig from
> upstream is R8169 driver built as a module, so you could simply install the
> kernel module instead of marking it as Y. (But then you hit some corner
> cases when you want to use NFS for rootfs for example).

Exactly. If it is a device that is built into the board, I think it should be
built into the kernel rather than a module.

I didn't provide this in the commit message, but while testing with it enabled
as a module, it is the driver that is installed automatically by the system,
that's how/why I chose this driver to convert to =y.

> While many devices supported by this driver seem to require (?) a firmware,
> the R8169 seemingly doesn't seem to require one, so I guess this is fine :)
> 
> > the kernel.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2138): https://lists.yoctoproject.org/g/yocto-patches/message/2138
> Mute This Topic: https://lists.yoctoproject.org/mt/115070708/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

