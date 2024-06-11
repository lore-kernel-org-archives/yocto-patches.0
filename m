Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F22C27C77
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 15:13:27 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.12262.1718118797978597208
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 08:13:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kcEcAvnu;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4405c2263eeso14620501cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718118796; x=1718723596; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfRgN40GS0iyg6IU/K+0BTH8qNhzeYj2+GoZkMvoHVc=;
        b=kcEcAvnufjrpoaWWYAabxg6n/Z8w2CvXDLz7o3oGx2zkd46rtHw3DMLbo6G+zsN4eD
         FnvWBN4bypJglvG1hnIOjXjKAk/zBdUge8LHVD2c4f73BlEq598LDCtM/oMCoYHNf6/g
         zjuIscHpXX66QnrS0+zyLVV22IvQ0wpVT55SlhTwYsmAdKuQZfCSlz+D1KVlLDRzS2Rz
         liUGWN4unSyowz6D8GLyhabL5Ox0qif4+jD15aAhmNo4nhTb94vlNgYmgeOlDmCpgXWY
         SfM4b0lx1Szk62x+0RE3GlTI6OZDdhy6rqI+8IiDUIu6dksQvlvTl/1QbV/0WctWwoOs
         v11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118796; x=1718723596;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfRgN40GS0iyg6IU/K+0BTH8qNhzeYj2+GoZkMvoHVc=;
        b=OKvb0vHDqe+RAtY1eKuF5LHJ4vk8oTWclRgeXdO/mODTM4dHZUx7hgVlacipAMdzoz
         Yr/x8TOK6iqkj2yl9001Xt+QjZLHyaZ0rvzPOpjnutNGwhoQwdK8l4Im2ZsURfF+MUtA
         BLA56AC5ZKeltoxFArJ7vp/OmLxcnRDfWepd7iuJaEokazLRjBo3SnqzSyrkWCCqWVkw
         ae4YiVGW7BbGI7UmYjwtdD7xIHykYsblUO2OKg6TPwas4QFIaHm8g3UD64dkNCeF9n00
         +HHtzM+vM7gXmPivG0S1cvlpleWDFfgpOmVDpnjjjG8Nvrjle9rb30mBMqiFG9gnFcT7
         pc3g==
X-Gm-Message-State: AOJu0YzJ80s9N+ELhjppNwnXAkMl8Z+mqZQXlv10P1oUVyDU2ObyiFxZ
	jrHsAiBrvw9JejBNioOMJ+KUH2rU0R3rPcyYNfIDQ/RwxX0ZFwgTlVDl4Q==
X-Google-Smtp-Source: AGHT+IE6+o6JHznKDKQWYNCMqCa+ud4zwGXm8Kby0AAZRYFbtdcREQ7GSVbwh9M4sFh+AWJnUvc3rA==
X-Received: by 2002:a05:622a:1307:b0:43e:404a:890c with SMTP id d75a77b69052e-44041c4b05dmr142950741cf.19.1718118796111;
        Tue, 11 Jun 2024 08:13:16 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44048a85288sm38729861cf.51.2024.06.11.08.13.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:13:15 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:13:13 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] user-selectable wic format
Message-ID: <20240611151313.GB7654@localhost>
References: <20240611141540.4209-1-twoerner@gmail.com>
 <61fc0c47-d17b-4254-832a-83c4c9d37c97@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61fc0c47-d17b-4254-832a-83c4c9d37c97@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 15:13:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/305

On Tue 2024-06-11 @ 04:31:26 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/11/24 4:15 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Allow the user to choose their preferred wic image format.
> > 
> 
> Can you provide some use case for this?

In order to build a wic.xz image the build has to first create a wic image,
then compress it as an extra step. On a slow machine this extra step takes
a noticeable amount of time.

On my local, slow build machine I prefer wic images since it saves build time
not having to do the compression and since everything is local, there's no
over-the-internet xfer time to consider.

When I build using some remote, fast build machine, the extra time spent doing
the extra step of compressing is recuperated by the savings in transfer time
retrieving the image from the remote. Therefore I prefer to make wic.xz
images. Building wic images on remote machines would lead to very long xfer
times to download the image artifact.

If I simply do:

	IMAGE_FSTYPES += "wic.xz"

in my conf/local.conf then MACHINEs that don't normally build wic images will
fail. So the only way to build wic.xz images on remote builds is to tweak the
meta-rockchip:conf/machine/include/rockchip-wic.inc file. So I'm always
carrying this tweak for every remote build that I do.

So I could simply modify conf/machine/includes/rockchip-wic.inc to set it to
wic.xz but that wouldn't suit my use-case since I could then have to tweak it
again for any local builds. Besides, I could never guess what preferred wic
version others would prefer and I don't want to be changing it every other
week.

So this patch maintains the existing behaviour completely, and when I do a
build on a remote machine I can simply set

	WIC_FSTYPE = "wic.xz"

in my conf/local.conf without having to tweak the layer.

And if others want compression but would prefer bz2 or gzip (or whatever) then
then can specify it however they wish.

> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   conf/machine/include/rockchip-wic.inc | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> > index dab61d83ed2c..eb895cd0b4ad 100644
> > --- a/conf/machine/include/rockchip-wic.inc
> > +++ b/conf/machine/include/rockchip-wic.inc
> > @@ -5,7 +5,8 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
> >   SPL_BINARY ?= "idbloader.img"
> > -IMAGE_FSTYPES += "wic wic.bmap"
> > +WIC_FSTYPE ?= "wic"
> > +IMAGE_FSTYPES += "${WIC_FSTYPE} wic.bmap"
> 
> Would this be a way to NOT have wic in IMAGE_FSTYPES? What are we trying to
> achieve here?
> 
> If so, shouldn't we also not build wic.bmap there?

The goal isn't to not build a wic image, the point is to allow the user to
specify which type of wic image (i.e. with or without compression and if with
compression, which one?).

I guess I could do:

	WIC_COMPRESSION ?= ""
	IMAGE_FSTYPES += "wic${WIC_COMPRESSION} wic.bmap"

And then specify:

	WIC_COMPRESSION = ".xz"

in my conf/local.conf?

