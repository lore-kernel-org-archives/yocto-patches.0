Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EEACF9C69
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 14:04:14 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.37369.1727100246523804521
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Sep 2024 07:04:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ogfe3P/b;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581d15c3e3so39385861cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Sep 2024 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727100245; x=1727705045; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hffQKcJ3g78edrHTI3J0ImDtzMhaMP1C1pQzycew2Uc=;
        b=Ogfe3P/bEQa/Admvgxcc5Cr+xj4FFD4cY+BkoBEnGS0uhEwRGZa1N+6r1jMj7po/i0
         uZLbUXcsokc6U60rUywnYyNySyHTasFQSqPrtvNYckh5lOipZi3qkCSkS2MZPkNc9nOk
         /bISuYNAASGwGbfpkHDJnPM1X3gxDeZs99Io8IWzk2d9D+IMHyshfpr3r1J8S2Pm/X7+
         YypiO/fkopUC7LoDs+hgNAZbjZgUsic/vp1oSLuUhM+ja7yzdOFM/3pSs/h6qJLl40Ea
         /VWCg/TRD723vzB4IKZEx94dt2OzoF0P/duLogMhkYrODtTxQrEXMtloH7EIX+KHRK3t
         2Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727100245; x=1727705045;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hffQKcJ3g78edrHTI3J0ImDtzMhaMP1C1pQzycew2Uc=;
        b=u7sCRGsagj36b3hkgez0SM8kLB9fBJOp0p81nwkEdcA9vk9LHmVJoda3eZU3erzTQE
         69RiIr8iS2um2K6CfWORXNRPtCvLPrB/ydcorm++JaiRGHTEkQaMnGoYlw2VV1usec34
         7JusKri6gDakLd26E1LmCKssTUQmJ8qAHteNmOQzLDKafH0rc6bFPaOSLIrIU7gEe7+u
         av55fyYLE3mWrx7XItrH0r+e7pJ2kUndZn+v0g09OJAztlaLVDNMx1v56R9yazCtzXhQ
         XfbDdiZ4mDKP0EgXxgZV2wEr8QRuFwAQGyZ++vqZznrxrjYjtU0Wgc4qJdU/fQoMO2rU
         v2lg==
X-Gm-Message-State: AOJu0YzDPr0tdXlCqHT/yaCPJGCPBhqR56yZNvJ/e62ZK/jP6mgRpfxr
	xwd931h3GWrowuq3SdwEPz1jZftXllt3YyiH08wV6TqftQ0SPx0xqFWqWQ==
X-Google-Smtp-Source: AGHT+IFON4y/mcnFtL8DVPu8Ia5EfrA4WIyx80mXH7MWkhQsb8vBe/J3lXD9rBjCiPCI6h6yGjuSkg==
X-Received: by 2002:a05:622a:410:b0:458:5d27:8527 with SMTP id d75a77b69052e-45b20560928mr184665281cf.51.1727100244614;
        Mon, 23 Sep 2024 07:04:04 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b178f3956sm47153781cf.77.2024.09.23.07.04.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:04:03 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:04:01 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] abd-partition: add
 runtime dependency
Message-ID: <20240923140401.GA4944@localhost>
References: <17F66BD6D408F640.22254@lists.yoctoproject.org>
 <20240921121639.GA23774@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240921121639.GA23774@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Sep 2024 14:04:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/664

On Sat 2024-09-21 @ 08:16:39 AM, Trevor Woerner wrote:
> On Wed 2024-09-18 @ 03:01:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The rauc demo implementation provided by this layer uses ext4-formatted
> > partitions. Therefore the tool required to format ext4 partitions is required
> > otherwise the repartitioning will fail.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  .../rk-rauc-demo/recipes-core/systemd/abd-partition.bb          | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied to meta-rockchip, master branch.

... and scarthgap :-)

