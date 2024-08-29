Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DCCA0ECA
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 23:30:44 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web10.1002.1724974238073242256
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Aug 2024 16:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HxFenuDK;
 spf=pass (domain: gmail.com, ip: 209.85.219.180, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so1346328276.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Aug 2024 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724974236; x=1725579036; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAIxhJFY4RHqjIdfIXs9llsLl74S0ik9dkhr7dmZM+s=;
        b=HxFenuDKzU9Ds+M1bzO4u/873q+FQUoHZ8I+gFjypL7n6l22tXSov5ODtpCKW3gwzi
         7CZMx09JbqWInn5XW+QxjP7Ykl+ztnM3gk5U69p2NI3awflaZAi9FHqD40/BMF/1WrH0
         6ZlET/hbnwySd08rSZQssFmYPd9WKl/erjIibpH8iytuIrkZcEXqzz9bnixT6WCSp+fA
         fzZ/uYzIbbg2T681ViPK83wuzHWqyfxnS0DK2oRWa1oUjVSL7OYhdslxhn6S1SJ5RQtr
         W9c/xeqJKsFYKmSoUPIHEbsjac3QYTkYmpf6SwEvg7tCsQIyDzEV2hX0JjAlYYGp1/8p
         M57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974236; x=1725579036;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAIxhJFY4RHqjIdfIXs9llsLl74S0ik9dkhr7dmZM+s=;
        b=NxHMf+B+pTmrfhv2pIJ+Nzaw8A3xVy8e8PCx0t5SWWagqt1rvyTWM5NsGx5F0NqGSe
         ddIf8/Jw2Lk4m0v+riVRvO7uMfONVz4keAQDsnVoNNGiw5mE7Aww4VAygE5aAr15K8+W
         6ILIScMrFH7Z3mK0mxlsIJl2xJh4r5xqvgt3T4Q0Kw3A2tVuR3d/oRwZosbCjG4059El
         vKcaaHzAda1SwAUun2s1dfwexYR3b2Tcua50gzTZQjrYbFIhy5rVMRVMsUa8e8tds4Vb
         eUIXWko7tvhAluu+3gdTF2WgCaCi1GeYsKvGCrn5krSQEkDd/OHjNGUqZhPpi+Ls80GC
         go8w==
X-Gm-Message-State: AOJu0YyafJC0KlPBJ0qzLBLVwfBNQO/x7N+FtiIanrqQBNtHRG01+pwY
	xGi9aEkCyPgRKQkw7i9KS5g9Ah16cAFK4eV1rK74LAr8rUyl7wg/zeZMkw==
X-Google-Smtp-Source: AGHT+IF/zBweUmJPjfMk4+w0ncL5r+Hyvk8tgRaHatF5gaL/CmhcKRHaQXTDe4GdeuHoId3HHkBFfA==
X-Received: by 2002:a05:6902:1886:b0:e13:dfdc:d83b with SMTP id 3f1490d57ef6-e1a78ab4d17mr467464276.0.1724974236471;
        Thu, 29 Aug 2024 16:30:36 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c97ad6sm9545336d6.84.2024.08.29.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:30:35 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:30:33 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2] enable HW VPU decoding
 for SoCs that have stateless VPUs
Message-ID: <20240829233033.GA12038@localhost>
References: <20240828-gst-hantro-v2-1-a85ed037e5c1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828-gst-hantro-v2-1-a85ed037e5c1@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Aug 2024 23:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/602

On Wed 2024-08-28 @ 06:23:59 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
> decoding. The Rockchip SoCs that have a VPU all seems to be based on
> Hantro, RKVDEC or RKVDECv2, all stateless encoding/decoding VPUs.
> 
> Therefore, let's enable VPU decoding in Gstreamer whenever possible,
> when the SoC supports it.
> 
> PX30, RK3066, RK3188, RK3288, RK3328, RK3399, RK356x and RK3588(s) all
> have at least one Hantro VPU.
> 
> RK3328, RK3399, RK356x and RK3588(s) all have at least one
> RKVDEC/RKVDECv2 VPU (though not necessarily supported in the upstream
> kernel just yet).
> 
> === PX30
> Tested on PX30 Ringneck with with Haikou+Haikou Video Demo adapter:
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> 
> Needed packages are:
> - weston
> - gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> A few frames are dropped every other second for 1080p but otherwise
> smooth.
> 
> === RK3399
> Tested on RK3399 Puma with Haikou:
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip
> 
> Needed packages are:
> - weston
> - gstreamer1.0-plugins-bad (for waylandsink and v4l2codecs)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> === RK3588
> 
> Tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter - on a
> downstream v6.6 (upstream-based, not Rockchip BSP-based) with DSI
> patches - :
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink
> 
> with FILE storing the path to any AV1 file, e.g.
> http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
> https://woolyss.com/f/av1-nosound-chimera.mp4
> https://woolyss.com/f/av1-opus-sita.webm
> 
> Needed packages are:
> - gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> For some reason though, waylandsink is very choppy. Combining
> fpsdisplaysink with fakesink shows a ~60fps when decoding the 432p file,
> ~24fps for the two others.
> Note that 10b-depth isn't supported (at least in my setup).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> (Most) Rockchip SoCs have a VPU that can be used with v4l2codecs plugin
> from gstreamer. In the kernel this VPU is supported by the Hantro,
> RKVDEC or RKVDECv2 drivers which do both stateless HW video encoding and
> decoding, however gstreamer only supports decoding for now, see [1] for
> encoding support.
> 
> All Rockchip SoCs supported in this layer to the exception of the RK3308
> have at least one stateless VPU according to the compatible list in the
> Linux kernel, so all SoC includes (except the one for the RK3308) now
> set ENABLE_STATELESS_VPU_GST value to enable VPU decoding via gstreamer.
> 
> Note that RK3588 upstream Linux kernel only supports AV1 decoding right
> now. Also, there's currently no video output support, so this was tested
> on a private downstream branch supporting DSI on RK3588 Tiger with
> Haikou + Haikou Video Demo adapter).
> 
> Note that Gstreamer v4l2codecs only added support for av1 decoding in
> 1.23.1, so the RK3588 part of this series doesn't necessarily make sense
> to be backported right now to other branches (e.g. scarthgap or
> kirkstone), at the very least until more than AV1 decoding is supported
> (which will probably land this year or the next).
> 
> [1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676
> ---
> Changes in v2:
> - rename HAS_HANTRO to ENABLE_STATELESS_VPU_GST
> - add documentation in README
> - squash all commits
> - mention rkvdec/rkvdecv2 as well
> - Link to v1: https://lore.kernel.org/r/20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de
> ---
>  README                                             | 22 ++++++++++++++++++++++
>  conf/machine/include/px30.inc                      |  2 ++
>  conf/machine/include/rk3066.inc                    |  2 ++
>  conf/machine/include/rk3188.inc                    |  2 ++
>  conf/machine/include/rk3288.inc                    |  2 ++
>  conf/machine/include/rk3328.inc                    |  2 ++
>  conf/machine/include/rk3399.inc                    |  2 ++
>  conf/machine/include/rk3566.inc                    |  2 ++
>  conf/machine/include/rk3568.inc                    |  2 ++
>  conf/machine/include/rk3588s.inc                   |  2 ++
>  .../gstreamer/gstreamer1.0-plugins-bad_%.bbappend  |  1 +
>  11 files changed, 41 insertions(+)

Applied to meta-rockchip, master branch. Thanks!

