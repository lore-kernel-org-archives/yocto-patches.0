Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97393C25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:37:46 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web11.6670.1716730665192638526
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:37:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MaS/hJdi;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df4dce67becso4837062276.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730664; x=1717335464; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABn3+8CInLBXxyJ1JEsv0WnkRl7HYqDGhFs1EXh3XBw=;
        b=MaS/hJdiuIGbDZXhuYxUllPJcjLYB9GBLAm13cOhSPuucaDoiKMkovumPxf2fRVuVR
         jzieSeNHCKS/DUeJSdprCRnRPckn2mk/wyURIR3HieQkJXHkNoH4ksbSP9TKXj/2GIWW
         B25hYv0xihoNVBzlbRroi+mCYkj5YCprGxJy6McfPQTaA5QqPnMF4/UkzEG2YeABw/SZ
         RtgA7hE2XqxoWzFgn5uqwk0sX58fFVI9yP3/pCIixrtNhrt2Pwbbgn1ofiKA1Hbufgqq
         6S/62/u6eK4aHyugaGZleeOBj6+i3vZQISPfROeqtHtcNWbYhqO3HemVeiZZDnUuzSbN
         ifwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730664; x=1717335464;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABn3+8CInLBXxyJ1JEsv0WnkRl7HYqDGhFs1EXh3XBw=;
        b=ZsnZ8NIPGtmePaYxyUgHRqZNXs5PorhUEQDgw6nFR9dbSlSkWxj3ZHUhXoAvQfD35q
         zFsqIYWghkub5UT7Swl1f9Y6MadUMAPkOXSgbv5P5kxtwaRkByj2eoeV9F3oVI+fwI4a
         qCGin5/k6sFAH9eI2eXsPsJvn8aASfql+HQxyRRyICIB/8pJdsOCmpyQxYzF1XkFlxKN
         W0Dp3XuKWU8nFbEzevQ3J0yuQVIu74+8VPHq8aRtiIWciNaGoa9kp5IVTf47dK0nJP4E
         co8yNVaLUr1QSwAuNpGDEiLfDKfIvrNxbL8jAMspzs0f55CnIIqjwPSGgPhbwZaDGUN1
         tK5g==
X-Gm-Message-State: AOJu0YwG8/oIhaJJZiqgjorTSbhFWl320npOYHXNTgeeA5H2zJWEsLbU
	wi7F7npzozTgRkhFqCBod48XIOyiHL0SJEL5DBXiCF3w4wi6LIbKOWQcag==
X-Google-Smtp-Source: AGHT+IHys1o4El/wYl6ZhLHb/MHh7CK4OHasKYosgDtyA0hEtda+In2jAIHPQUkUkwHF6fntbutOgA==
X-Received: by 2002:a25:ab02:0:b0:deb:d7b5:5c27 with SMTP id 3f1490d57ef6-df772382acdmr6768066276.53.1716730663733;
        Sun, 26 May 2024 06:37:43 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd33a71sm225882085a.122.2024.05.26.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:37:43 -0700 (PDT)
Date: Sun, 26 May 2024 09:37:41 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] rockchip-extlinux.inc:
 add kernel and dtb packages to the image
Message-ID: <20240526133741.GB15238@localhost>
References: <20240522-nonfitdt-multi-dt-v1-0-c75dffd3aa7c@cherry.de>
 <20240522-nonfitdt-multi-dt-v1-2-c75dffd3aa7c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522-nonfitdt-multi-dt-v1-2-c75dffd3aa7c@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:37:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/203

On Wed 2024-05-22 @ 08:26:44 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> If an image doesn't include kernel-modules, the kernel-image package
> won't be installed by default. This means that no
> kernel-image-${KERNEL_IMAGETYPE} package will be pulled in, resulting in
> neither fitImage nor Image (or uImage, or zImage, or...) making it to
> the filesystem, rendering the image non-bootable.
> 
> For non-fitImage scenarios, we currently expect DTB-less kernel images
> (no bundle, like in uImage) so we also need to pull in the DTB via the
> kernel-devicetree package.
> 
> Those packages used to be pulled in by the wic plugin through the
> IMAGE_BOOT_FILES variable.
> 
> Fixes: 3b51866f2251 ("remove /boot partition")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  conf/machine/include/rockchip-extlinux.inc | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Applied to meta-rockchip, master branch. Thanks!

