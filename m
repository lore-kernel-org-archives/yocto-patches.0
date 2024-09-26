Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FC2CDE01B
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 15:48:37 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web11.47390.1727365708218534048
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Sep 2024 08:48:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VPq39AlK;
 spf=pass (domain: gmail.com, ip: 209.85.219.174, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1651f48c31so1257369276.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Sep 2024 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727365707; x=1727970507; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z/xBHQvFo5S+NSs+kSVbWB+JJDcxvICxfSyN1S4rtU=;
        b=VPq39AlKQxBdlzA9xqlbcXfq7THrN1zl+PBsjIxH8FMrtC2il3WXSJtHmgOa4BhHu2
         po6GY4dfX0sAzgbsByfGNxDIvWeV4eoryiStXpu1HOi+607dxj5khCJ8Qro1pJAfsBrY
         hS301dW3Fb6fOZ06aUmjtyrnSYLgXtGsPiGkpLIwEhXkABZgO4w5FF9D03vkQkuvFftz
         Rk0DupIIebOT13LC/akWl0KPpl40YpDH8CfOWkhHq5R87Rpg2G3pV/PFrH/upTf9CkWA
         +QDw/THq4FPw94lJOzkLzl1CygE7tC14s0JQcijViDfsbbr5Bi6Mqi15qAkTIAeVI66w
         quYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365707; x=1727970507;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z/xBHQvFo5S+NSs+kSVbWB+JJDcxvICxfSyN1S4rtU=;
        b=Bl27OlheoRZ6Zz53le4v3YjenCwQKrMlGw4kvfgCEPaKBkY5xoENaX0nWWm86stW1M
         /UMxjWnbP4nHq9JgIIepdcOX9TH4domq2s7uyxl/2p9AhkE82fMsq1FJ8yEi7pvF5own
         HNLf8zV7aTktZblewB7o8GaTWwvIKkTFNGH4v6R2m3WeliCYDzM6PIXaHv5ufl80XnLL
         pagDUZdj8t6iIoqBTiaeqBwlQRpWkZ4Ho6jgjqRZyMdWTlzYf2pAH2zkxTS8v36Zltrz
         2wKgqgP7bHcJqket1kcRAQAyzVFr8EPrvDBaIh5M9B5FyYXe4weRpTkoWitX4YLUEh6g
         5zng==
X-Gm-Message-State: AOJu0Yyb9rSe4iWaqHxS6GaHz8AjJR4bSCtRvqxOfJlWLpiWapu17bYT
	oQSttvQJELiXqYAl8vM+00d9Hzt3SpTvDcHbctS+ijxySH9vRZih
X-Google-Smtp-Source: AGHT+IHW3dj6w3CQUq426klibBl060OtlLDQDpsALzxxjpL6cEWtIEvc9nWuQQdKIZiUKtky7roQug==
X-Received: by 2002:a25:844f:0:b0:e25:ca37:b669 with SMTP id 3f1490d57ef6-e25ca37b66emr2395630276.24.1727365707221;
        Thu, 26 Sep 2024 08:48:27 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783ff45sm860185a.115.2024.09.26.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:48:26 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:48:23 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [meta-rockchip PATCH scarthgap] enable HW VPU decoding for SoCs
 that have stateless VPUs
Message-ID: <20240926154823.GA39077@localhost>
References: <20240925-gst-stateless-scarthga-v1-1-7b78e4575e26@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925-gst-stateless-scarthga-v1-1-7b78e4575e26@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Sep 2024 15:48:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/675

On Wed 2024-09-25 @ 12:13:51 PM, Quentin Schulz wrote:
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
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> 
> Needed packages are:
> - gstreamer1.0-plugins-bad (for fakesink and v4l2slh264dec)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> waylandsink isn't used with weston because of rendering glitches, c.f.
> https://gitlab.freedesktop.org/wayland/weston/-/issues/839. While the
> link specifies it is for RK3399, PX30 is also impacted, albeit
> differently since a different kind of glitch can be seen (like seeing
> the image through a negative filter).
> This is fixed in Styhead.
> 
> === RK3399
> Tested on RK3399 Puma with Haikou:
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip
> 
> Needed packages are:
> - gstreamer1.0-plugins-bad (for fakesink and v4l2codecs)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> waylandsink isn't used with weston because of rendering glitches, c.f.
> https://gitlab.freedesktop.org/wayland/weston/-/issues/839.
> This is fixed in Styhead.
> 
> === RK3588
> 
> Tested on a RK3588 Jaguar with HDMI - on a downstream v6.11-rc6
> (upstream-based, not Rockchip BSP-based) with a bunch of patches - :
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slmpeg2dec ! fakesink
> 
> with FILE storing the path to any MPEG2 file, e.g.
> https://drive.google.com/file/d/0BwxFVkl63-lETXlOa3hEMmVyZGM/view?resourcekey=0-FG5JbjCsd8QduRhkZ2aT8A
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slvp8dec ! fakesink
> 
> with FILE storing the path to any VP8 file, e.g.
> https://test-videos.co.uk/vids/bigbuckbunny/webm/vp8/1080/Big_Buck_Bunny_1080_10s_30MB.webm
> 
> Needed packages are:
> - gstreamer1.0-plugins-bad (for fakesink and v4l2codecs)
> - gstreamer1.0-plugins-base (for parsebin)
> 
> waylandsink isn't used with weston because starting gst-launch makes
> weston segfault.
> 
> (cherry picked from commit 91a694e250a050ac77acab94521a80faac822aa1)
> [adapt commit log to Scarthgap]
> [replace waylandsink with fakesink as weston has glitches or segfaults]
> [no av1 decoding in gst 1.22 in Scarthgap]
> [rk3588 has gained h264, mpeg2 and vp8 decoding, added to the commit log]
> [update setup for RK3588]
> [note: only RK3588 was tested for this commit in Scarthgap]
> [note: use fpsdisplaysink gst plugin with gst-launch in verbose mode for
>  more information on on-going decoding session:
>  $ gst-launch-1.0 -v filesrc location=$FILE ! parsebin ! v4l2slvp8dec ! fpsdisplaysink signal-fps-measurements=true text-overlay=false video-sink=fakesink
>  /GstPipeline:pipeline0/GstFPSDisplaySink:fpsdisplaysink0: last-message = rendered: 287, dropped: 0, current: 30.02, average: 30.17
> ]
> 
> Reviewed-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
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

Applied to meta-rockchip, scarthgap branch. Thanks!
I only build-tested this one, but it looks good.

