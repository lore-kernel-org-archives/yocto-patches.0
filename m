Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924BC52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 13:24:43 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web10.16000.1724419479091130011
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 06:24:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M+mDMRdi;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44ff398cefcso10052491cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419478; x=1725024278; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0LKylOBQPvi0V0ChHsGYlNeYFeyzfZ2bcO51khzWsM=;
        b=M+mDMRdi7F5Dc2NkvjMqTyrnwp8V+u0QnjGdfyx6tFylI+CSeT0rcI6RE1PgV4gLNU
         yFHYdl6uf9ja4Fp+gmr6eu0gXiTidl4Yj8vAazrpSTo9Fq5aWEHBDR2VVgFckfDztBFf
         yPPyQiBL3K6j6ME9V2H8DA2sGeuzmDBvZiimEKjj7jRmPi20rkbXDol/TXf6lIMyryfE
         7eToVdJvhyLSpoWe9zwAJu44LdIc1caO82DNDOXzeTWv4+QVhA5P3tng6OhszBdfDtCt
         NGcc7dsik6HkuMfoVuMkMjXXnIClAbsRFjTOEKmSDGQrSSHoWJk92alC3Wi8W5gbkm1R
         CCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419478; x=1725024278;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0LKylOBQPvi0V0ChHsGYlNeYFeyzfZ2bcO51khzWsM=;
        b=vubVs4bfT0CoBdRCjGP2I9A+rPlBmnH5fS2SE1i3FNJug4kggShJbqQzhb/bFPBPhX
         CWxHDRP26twWnCmGPppc9OL/4WjqCf9eqtNOQXMD/D1ebIw+h82lRqTI+TqIPl8F+ava
         +7QdiSp+1JFj0je05bt8JIZPHHVg5YQG9uTEHVP7khVnnLbgZGknmpPxhPybN3Jv6OFI
         hDSDON9lW3Wff4Mj0XZKV7TnW4xJIe0eCtEEeLw+VGVWnBbKEfxD+jh2ppl9jS/jMOwV
         UTQ1mds7mjREYoynAmrKhBOgc7H58Enpe/cKLP9U2IsBUcNWLXvgrNWhz2QZNu/TNpkn
         868w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3Qbivh3DXiz9tZjjGISq0wVt+yv7TkEHrqQjBLmHEspfb/SistlVqVoeU7FR64Ks63OsKlqdOZNTZFYz@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyb/zD6N+R5Q0iKejJ8f/3rVEicjSfx5ma09zc+PtX2+it+lVet
	N5FTBHo7SJq/PXB5xJy5/28J8ZUn4y2hM7iFFBAFe2RBV4k6qlC5
X-Google-Smtp-Source: AGHT+IH5Sy+qVwPDrUdx9mkRF3xbIY+o5Q2a+Gvs+iH9kMoj5jo2NKzW4sdebCmkx+nNLexMBLvezw==
X-Received: by 2002:a05:622a:418f:b0:446:5c35:d9c8 with SMTP id d75a77b69052e-4550968f0a7mr34749531cf.30.1724419477973;
        Fri, 23 Aug 2024 06:24:37 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0dc810sm17304371cf.34.2024.08.23.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:24:36 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:24:34 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: Rename bbappend to
 match oe-core
Message-ID: <20240823132434.GA28691@localhost>
References: <20240823131438.1539692-1-raj.khem@gmail.com>
 <88170668-0528-4faa-a727-73777e91a8ce@cherry.de>
 <CAMKF1sqE9UFyAJ+xVqMfbyu0tAOSYf6qAo_iakxipmZJPkyEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMKF1sqE9UFyAJ+xVqMfbyu0tAOSYf6qAo_iakxipmZJPkyEkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 13:24:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/557

On Fri 2024-08-23 @ 06:18:00 AM, Khem Raj wrote:
> On Fri, Aug 23, 2024 at 6:17 AM Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >
> > Hi Khem,
> >
> > On 8/23/24 3:14 PM, Khem Raj via lists.yoctoproject.org wrote:
> > > OE-core dropped _git from mesa recipe name
> > >
> >
> > There's already another patch posted on the ML, c.f.
> > https://lore.kernel.org/yocto-patches/20240823123253.3562592-1-martin.jansa@gmail.com/T/#u
> >
> 
> cool. discard this then

Thanks for the patch, I'll add your SoB as well. It's nice to see it's being
used. I'm just doing a quick sanity build with all MACHINEs as we speak, then
I'll post it.

> > Thanks!
> > Quentin

