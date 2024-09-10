Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366DEB64DE
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 04:52:19 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web11.15666.1725943938940672832
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 21:52:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OSIwAa6H;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9a7bea3d8so27536785a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943937; x=1726548737; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrxklByy59iPfCggrBsl5nfiRJgJFeU3JxELn0N/TxI=;
        b=OSIwAa6HAQitxhgIncICK1mj1gByL6qn6ikr8k5id4v6GVwsJ6oPLpM7WgU8qAstLc
         r1n5VahOdex4aa8h797RlziZPmqlYH3UeJutCqTXTvn1vaZGF8b+yjuTpAnaPzdio2Ks
         iJDPNyxN+ofVdXIBqmk1aKSr6F5nmOYwwrjTPtQs9NzqiwYN0Knu4HdI/NmDf2EAgKVa
         GbCrmlbkHufo5O6uK5ZrDMKa9e4/en7XpEAoor6SYSB6LJNw2i5cg8r8i5qmBoLRWXh/
         gZmtCTYGtLXqe61SqA3KjI1YLHoTneVdXfhp+iZS4YtZ7JUuw+lCKtSlagS7LS6hm/fw
         6d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943937; x=1726548737;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrxklByy59iPfCggrBsl5nfiRJgJFeU3JxELn0N/TxI=;
        b=veCBXIbbveW+B09FGsGrr0vbBDXJeCzY/7nlI1JDQBYF+cQAis0+9L0bYDOq3zpO/Y
         szBhPOpnqeRCtH1m7o+lslGhFIVIeEj98ZT1LLzplngk1QFhX2bo+AXwuwry0NNG/Uyk
         kCVpI/QtC8XABgGA5XPI0M6qfONtDqXuVI7+ibK6RmCkgo/X4Ai0vBdHLpzpRN2tZOFH
         9sqIXiaJ5T4Hnxt3SH6Xxjb6K6wRknBHDTnSxFNk3VoY8SJrvpCCsqVxdj1q2pQYxKRb
         GxHDmD7w9mcXDZAXgNsHTS1ws4A1JhmdQFD3ML2UcFuwPamLFUClHDG3/f5QnGcZHQqw
         uGRw==
X-Gm-Message-State: AOJu0YyUlGc6JsZ02apa2DtX6E7Sz2ZXHrztscoBLMS7F7s2fbdEV5bZ
	FkFtdRAReZoiyI2aq7iXqbuolvAeqVBUxkTxSBtvpm42aduAQtzob5B+Mw==
X-Google-Smtp-Source: AGHT+IEykOluzve+C+pmCDe+1MtS5eyKhjZ2yKrOISID/ordKzQp3vFCGCThSJjQSC8HYH5ggXBS6A==
X-Received: by 2002:a05:620a:4712:b0:7a7:f91f:ba3c with SMTP id af79cd13be357-7a9a38a905cmr1024575985a.20.1725943936942;
        Mon, 09 Sep 2024 21:52:16 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a185dfsm279798185a.99.2024.09.09.21.52.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:52:16 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:52:14 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][scarthgap][PATCH 09/10] enable
 HW VPU decoding for SoCs that have stateless VPUs
Message-ID: <20240910045214.GA32228@localhost>
References: <20240909145530.25301-1-twoerner@gmail.com>
 <20240909145530.25301-10-twoerner@gmail.com>
 <f900b17c-8b9b-454d-9339-25886e30f269@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f900b17c-8b9b-454d-9339-25886e30f269@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 04:52:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/639

On Mon 2024-09-09 @ 06:01:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 9/9/24 4:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
> > decoding. The Rockchip SoCs that have a VPU all seems to be based on
> > Hantro, RKVDEC or RKVDECv2, all stateless encoding/decoding VPUs.
> > 
> > Therefore, let's enable VPU decoding in Gstreamer whenever possible,
> > when the SoC supports it.
> > 
> > PX30, RK3066, RK3188, RK3288, RK3328, RK3399, RK356x and RK3588(s) all
> > have at least one Hantro VPU.
> > 
> > RK3328, RK3399, RK356x and RK3588(s) all have at least one
> > RKVDEC/RKVDECv2 VPU (though not necessarily supported in the upstream
> > kernel just yet).
> > 
> > === PX30
> > Tested on PX30 Ringneck with with Haikou+Haikou Video Demo adapter:
> > 
> > $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> > 
> > with FILE storing the path to any h264 file, e.g.
> > https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
> > https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> > 
> > Needed packages are:
> > - weston
> > - gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
> > - gstreamer1.0-plugins-base (for parsebin)
> > 
> 
> Weston output is broken on Scarthgap. c.f.
> https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/
> 
> > A few frames are dropped every other second for 1080p but otherwise
> > smooth.
> > 
> > === RK3399
> > Tested on RK3399 Puma with Haikou:
> > 
> > $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> > 
> > with FILE storing the path to any h264 file, e.g.
> > https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> > https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip
> > 
> > Needed packages are:
> > - weston
> > - gstreamer1.0-plugins-bad (for waylandsink and v4l2codecs)
> > - gstreamer1.0-plugins-base (for parsebin)
> > 
> 
> Weston output is broken on Scarthgap. c.f.
> https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/
> 
> > === RK3588
> > 
> > Tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter - on a
> > downstream v6.6 (upstream-based, not Rockchip BSP-based) with DSI
> > patches - :
> > 
> > $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink
> > 
> > with FILE storing the path to any AV1 file, e.g.
> > http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
> > https://woolyss.com/f/av1-nosound-chimera.mp4
> > https://woolyss.com/f/av1-opus-sita.webm
> > 
> > Needed packages are:
> > - gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
> > - gstreamer1.0-plugins-base (for parsebin)
> > 
> 
> Stateless AV1 decoding is not available in the mesa release used on
> Scarthgap.
> 
> So...
> 
> RK3588 seems to have gained upstream support for VDPU121 which should allow
> h264, mpeg2 and vp8 decoding. Building a linux-next kernel after tag
> next-20240829 should have the support AFAICT.
> 
> So, I would retest RK3588 support for those video formats and drop the AV1
> mention from the commit log as it for sure doesn't work because of the
> version of mesa in Scarthgap. We could backport later releases into
> meta-rockchip to gain support for it. I think this **may** be an idea once
> there's support for 24.1 and later merged into OE-Core because it brings
> Panthor (open-source GPU drivers) support to RK3588 which would be a shame
> not to have in an LTS. But let's see when that happens.
> 
> 
> 
> As for the issues with display on PX30 and RK3399, it seems those are
> supposed to be patched in newer releases of gstreamer, c.f.
> https://gitlab.freedesktop.org/wayland/weston/-/issues/839. Note that
> Robert said it would be fixed in gstreamer 1.22 but the linked patch
> only made it to 1.23 (Scarthgap has 1.22, Styhead 1.24).
> 
> Considering what Robert said in the link above, I assume people using
> another compositor than weston may be fine on Scarthgap, so I would suggest
> to backport the patches I submitted in this series to scarthgap anyway? One
> is not forced to use weston to do VPU decoding.
> FYI, I gave ~30min at backporting the gstreamer patches to 1.22.11 but this
> is above my skill set today.
> 
> For those, I would just mention the issue in the README and commit log and
> maybe switch to fakesink in the commit log instead of waylandsink (and drop
> weston from the needed packages).
> 
> What do you think?

To be clear, when I say I've run-tested this build I'm not implying I've
tested every aspect, feature, and functionality of each chip. I've simply
flashed an SD card, applied power, watched it boot to a prompt, log in, and
run something simple like "uname -a" to verify it's using the scarthgap kernel
and not the latest master. I'm not really in a position to test stateless VPU
decoding or anything fancy like that :-)

If there aren't any issues or objections, perhaps I could start by applying
the other patches in this series while considering what to do about this one?
Maybe after the others are applied you'd like to have a go at making a
scarthgap version of this patch (with all the proper commit messages etc)?

Best regards,
	Trevor

