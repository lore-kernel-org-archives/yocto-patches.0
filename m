Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B9D711D5
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 02:47:45 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8966.1766112458772332497
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 18:47:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j/QDqiWK;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b5ed9e7500so101002485a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 18:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112457; x=1766717257; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuFqCS/CCk0Yaosq9R445N5ZEnSHyaWMmyKkf/DZ99Y=;
        b=j/QDqiWKyMeF3CUgvWQoxe14BHLWl9lUZdZBaMT0gDSCpHtxuoX1c//mYNnEai4WL4
         o3ruFlyuoN0xZTtRqBQH2DNFKjojYbpb8R4UenlWueBGJavse+5/ALYqZnTEhoCMwNga
         IXfaGuO8YhHFISTh/kv4481bBhT0Dw/a7pB+AfM/wlGIffVonXj4AFWt7ki9CSecIHsj
         hzv6iNwWXsmcB5DuBGWzTbFfFkZMFotKxD17qtvrKk98X9VvK2TOWlpy5+PbtrGL2SaY
         0ZozFEH0htkwIoB9bUhJj2gn0QGtGKq3motumsC5uquHr3oppxlYuOISC8U03U18/uCX
         V4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112457; x=1766717257;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuFqCS/CCk0Yaosq9R445N5ZEnSHyaWMmyKkf/DZ99Y=;
        b=RVHQb//DUn9+WcyRmRRqwds95pV5en6VxibM05lIWpghw0ajZYF3zmB1Dk3w3vL1XU
         VNF0UHjbVNbabgmLzHu/uXS049sOtc31YqFpJYOpcEEiG/WIPdwu740tJO7QRPm6adyD
         I/z+MNUBS9BmS2fl7jbkjTUxJE26AqnvGgzvAO9RM/QPGJHFf0ZanKjKltddE+lzmcJt
         EDyyZQxbUKVqZbOBQdYcaR33jxLVW0oIkY08+8pf+vXbgY6ljuCzZtRYR70YTykvAe2F
         BlrecwYUVtzKsE25POcTwFGOtikwPcFjBOeb7W+F5py0qxDfrX1JBVQvljIg+aSKvabR
         Pqkw==
X-Gm-Message-State: AOJu0Yz/+zThyjKLEgn0srgRSWSA2fmBR9y7wSc/elO7AFQmunV9+Caz
	hjB1mtvz3gOLMy1Ray5Yer81N51WtptOlVhwqzpnp9uzrQPCxCIl7YvSf6PhJw==
X-Gm-Gg: AY/fxX7CdexZk+bbwRNfo9fZzXB5IcQEMvvnThd51gSQZaneocUsbjTlCOApArQ9aZG
	WiSIBpjnUHLc9tWwXCiM90XLJwBfs4ylc69CI8nM6V+23vVcbHwG3kuAGyXN3clzMLPpzmPGD7i
	BfMgx1s47jsgm7oXuT4kSH9wRYKgcgweGcowKYW0smNjE4h9JsyJW98C2UgLRwQLjiUo9mzFO44
	W6Y3MqYZgOTCZ4Q+hf3LrP4tbSRdjnGNpYYwifJ/QnrLs/4sqQMGDMY/lsnSvrYHf01Q4R7cTes
	LIQorXDeW+U52yUlupcZFyUJM4HqJ5DS0qmAtHf4HnrczyGq+bHzYec9VSSCgGK75fbjEdFIkga
	zUBs00J97owWxeVujJ4HVTESWCtPhMVyAoPSNKdcSHvhJH2s5IgT5xJESn3N4F93rfcWW6BjmSi
	nB9KfygxhJb3UsRgCJZWKOBPORkdY8zT+JvDDZ+Q==
X-Google-Smtp-Source: AGHT+IFwagSXiWw9BmhlvlLchWwD4hPc+8IRrs6fafN0B1chjgPugUCBYHygLXSt4cm7Yj2D8XVTjw==
X-Received: by 2002:a05:620a:4690:b0:8b2:e8b5:1e9a with SMTP id af79cd13be357-8c08fbdef1bmr297126685a.21.1766112457111;
        Thu, 18 Dec 2025 18:47:37 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ee182sm83769785a.33.2025.12.18.18.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 18:47:36 -0800 (PST)
Date: Thu, 18 Dec 2025 21:47:34 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
Message-ID: <20251219024734.GA5613@localhost>
References: <20251218060321.2194839-1-michael.opdenacker@rootcommit.com>
 <026999a3-ef46-4590-99ab-bbd8fbb0affc@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <026999a3-ef46-4590-99ab-bbd8fbb0affc@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 02:47:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2819

On Thu 2025-12-18 @ 11:46:10 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Michael,
> 
> On 12/18/25 7:03 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > 
> > Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
> > with the Rockchip rk3566 SoC.
> > 
> > Support for such boards was introduced in the 6.19-rc1 version
> > of the Linux kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f80b3952318d7ef18573a5010f06118602f992e
> > 
> > Therefore, the https://github.com/betafive/meta-linux-mainline/
> > layer is currently a prerequisite to build images for such machines.
> > 
> > Here are already supported features:
> > - Debug UART (/dev/ttyS2)
> > - SD card (/dev/mmcblk1)
> > - eMMC (/dev/mmcblk0, only on Tinker Board 3S)
> > - I2C:
> >    - i2c0 (internal bus with a PMIC and regulators)
> >    - i2c2 (internal bus with an at24 eeprom and an RTC device)
> > - USB 2.0 ports
> > - 2 GPIO LEDS
> > 
> > [1] https://tinker-board.asus.com/series/tinker-board-3.html
> > [2] https://tinker-board.asus.com/series/tinker-board-3s.html
> > 
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > ---
> >   conf/machine/include/tinker-board-3.inc     | 11 +++++++++++
> >   conf/machine/tinker-board-3.conf            | 10 ++++++++++
> >   conf/machine/tinker-board-3s.conf           | 10 ++++++++++
> >   recipes-kernel/linux/linux-yocto_%.bbappend |  2 ++
> >   4 files changed, 33 insertions(+)
> >   create mode 100644 conf/machine/include/tinker-board-3.inc
> >   create mode 100644 conf/machine/tinker-board-3.conf
> >   create mode 100644 conf/machine/tinker-board-3s.conf
> > 
> > diff --git a/conf/machine/include/tinker-board-3.inc b/conf/machine/include/tinker-board-3.inc
> > new file mode 100644
> > index 0000000..17d0ecc
> > --- /dev/null
> > +++ b/conf/machine/include/tinker-board-3.inc
> > @@ -0,0 +1,11 @@
> > +require conf/machine/include/rk3566.inc
> > +
> > +# Kernel provided by https://github.com/betafive/meta-linux-mainline/
> > +PREFERRED_PROVIDER_virtual/kernel = "linux-mainline"
> > +PREFERRED_VERSION_virtual/kernel = "6.19-rc1"
> > +
> 
> Not sure we really want to do this. Maybe wait for linux-yocto-dev to hit
> v6.19*? We used to do this for some Radxa board in the past I believe.

I would prefer to add this board once support is available via any of
the Yocto Project kernels. We've added boards to meta-rockchip many
times in the past when support was available through linux-yocto-dev.
Ideally upstream U-Boot would support it as well.

