Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E813D2E036
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:38:19 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.4899.1729676290451014904
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 02:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OM6BSQyB;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e6c754bdso6334854e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729676288; x=1730281088; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMXk2pVuPSURr12D/soMKhoOhEYN6iVZmPJjS9NAgrw=;
        b=OM6BSQyBs1kH5Qg+087Ki/JN/0nBiCQ9PcylW2F3z52Amb3F5n0V62EmlFqFB3MZsi
         OlyZaLV7JVLOCFIq5W566YasOSntHkthnVrA0J1k75JUFw6A1Pt1su0LIvFC9PzGxm4x
         L1Gplbuac8lffAq+Q1s0Jm33mm1K4ALUPHNvS8ck4HlCxBkUwUinZmsxnVWh9/f2o9e4
         dQh3PU5y6mkr14+33E+24tgFDVKEgEI/f36V4C2HXtfPzhEYNrEu/QZSykwtmSRyAhKb
         9VWLPRtc4ts7cfjOpYTgDWsnhAugiJzJg5MWkV6Cf18KiVAW5wusaLOA9k/i9JC0yDoF
         nqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676288; x=1730281088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMXk2pVuPSURr12D/soMKhoOhEYN6iVZmPJjS9NAgrw=;
        b=Ljz8AqfoGqa7yQvk6stFo+aIXX+vd8zWsP+gMj5CkQARhh+UIe5LWHRX7zBL9puEhI
         3fjA3Uxf40K3Yrt01eY7V0SYk2/C2zk0ar3aNjWCj33D4nzWZrprVSnMTWcxwoF52Cfk
         eQ1ramaJU7tJ2O6hgjg6s50D+rGpIqG9x2A41/kU/RkaOdpov5sBi7AugsCPfWno+Hc+
         b0XHqflXDtMbhuUXKWz206RZnmS+Sr1VP5ZcFQgu6OZCFmcrkLbUqcQ9Z6R9KHgUsmWl
         adD0EY/w5ekHDwkn0VyNV8p0baWQaAfGmVJskjRrJm9klJ5TBrxvXpQm1I983M6ZurPN
         kz0A==
X-Gm-Message-State: AOJu0YxsL0Vs4lYtGjgwZhng56SvmnfIXeVofWWF1LRlq/xvNGnHLb4e
	pwRuumdN+pA+kF09l2Pecv1+ZobLu4IX4ypE9wxVJ7khLjNnN3NED6HeJJWol1g2x5CuAjd/YCU
	8Zk/4hyOC3ho0iorIoGfW+E7vbTDQ2g==
X-Google-Smtp-Source: AGHT+IH2PlAky1BfEQn1qgqIokxe5uwvvOIo0UM7qvQFQ2x8YAohXjBBLqvxy+Li7zSAUvDiOBcyo18CjaHYbPcfwNo=
X-Received: by 2002:a05:6512:3b87:b0:539:fc23:1497 with SMTP id
 2adb3069b0e04-53b1a30d4eamr858828e87.9.1729676288274; Wed, 23 Oct 2024
 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241022171035.460059-1-dixitparmar19@gmail.com>
In-Reply-To: <20241022171035.460059-1-dixitparmar19@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Oct 2024 11:37:56 +0200
Message-ID: <CANNYZj-YHx0Hw_GGPWMruF2+vp5CWe6yyxPMqPGBSx-S6Mk=Yg@mail.gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 09:38:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/727

Hello Dixit,

This looks fine, except for one point.

On Tue, 22 Oct 2024 at 19:11, Dixit Parmar via lists.yoctoproject.org
<dixitparmar19=gmail.com@lists.yoctoproject.org> wrote:
> +++ b/applets/battery/battery-sysfs.c
> @@ -0,0 +1,155 @@
> +/*
> + * (C) 2008 Intel.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Licensed under the GPL v2 or greater.
> + */
> +
> +#include "battery.h"

The origin and copyright of this new file needs to be explained. Have
you written it yourself or was it copied partly or wholly from a
different place? If so, why does it have an Intel copyright dating to
2008?

If you've written it yourself, was it done as part of your work
duties, and if so, should the copyright be assigned to your employer?

Alex

