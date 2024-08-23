Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F0C5321E
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 13:55:33 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.16606.1724421324945775607
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 06:55:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IRIvlz7Q;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d024f775so129087985a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724421323; x=1725026123; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMJdiuLt8rMPdj+2icqzbnQ/3gx48VxeQ+BP9I/fk+A=;
        b=IRIvlz7QDGGw2ew8DIQgRSD2KlAo0jJlqS/hcWMTHgjac4HdIOwitvmAPhEEWIhG+o
         xPxba34ywqKndv2BBzZf7lRbwUNyQWcKhzqVFSg6/08rb0yd5Wi5xO6taB1bkGUhGdv8
         93VM6DXNM7s3r4EyVzb7itp2tPGf04I2yz7w0UvjSAwYOAE7cJBE6Gae6MAhSmPT8zC3
         Bn//vIAY/Yv8NNm4+7MUJbPLMSXzEqo/Gp9cWsgxN6WY4DYX0xPx21Y05gZYZt9tNjSo
         d+r/vOpRHfbmrEwiQojwZWigOzpAiQovRmJ/Ln8rjC45iF1v0fpa9KJnhH0iXuST5+Ai
         qC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724421323; x=1725026123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMJdiuLt8rMPdj+2icqzbnQ/3gx48VxeQ+BP9I/fk+A=;
        b=Brf88lHJpl/AWy1nrA1XFP+nQwN18iIhP/ssgqy32ZomkRz5i2BM9/adtUdHcdlHp5
         fwb07FPtzANpgpHoxrkhHGVZLJF7urwb9y6Yb7Fm+aBmQ9ktanLkUfuLlROug+IP97Qm
         NyhpLxxeGf12iB69pIge/K+DbOHBgYf+3k3vGhvm4H1vzeQR4wGSVlWbwkNFCZPQPLYJ
         iSybpdaNm9dWDllG4Z2+orv++7t/s/7jzi4zUjVMgnahVnf4CJbpYFp+ALeXly0uRS19
         4K98h9/aBjwiresPztXRwTkFjKG4Y+0JmRfPuQvJESBNF9nPI2Kdd0vgAEuzjU4ggxT1
         re7Q==
X-Gm-Message-State: AOJu0YzmMaTyHaB5GRnKNvaUgqCUEQxEmQotFPxb5EMj5sP4Vs9Rq8+y
	sj8r6WTSB5CA52NGPn5QMq0D1WAVc1afwMYKoxHfMhw8kuTgu8Chzxq2Nw==
X-Google-Smtp-Source: AGHT+IEIdXJiwT6u5zXsS9lfbvGr5fow/WmRsvLbkCW3V9N5WqpTPp1xf1lt9ZYcVVhJ3d7/i2yR3w==
X-Received: by 2002:a05:620a:458e:b0:79f:735:4cfd with SMTP id af79cd13be357-7a68978f4d4mr267653985a.50.1724421323231;
        Fri, 23 Aug 2024 06:55:23 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f347500sm179883885a.45.2024.08.23.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:55:22 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:55:20 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
Message-ID: <20240823135520.GB28691@localhost>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
 <20240821044243.GA1194@localhost>
 <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
 <20240822122328.GA24992@localhost>
 <d29f0a9a-bab3-4f73-9b9e-361909b95092@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d29f0a9a-bab3-4f73-9b9e-361909b95092@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 13:55:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/558

On Thu 2024-08-22 @ 02:38:11 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 8/22/24 2:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Hi Trevor,
> > > 
> > > On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > > > 
> > > > > 
> > > > > On 8/20/24 2:56 PM, Quentin Schulz wrote:
> > > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > 
> > > > > > RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
> > > > > > v4l2codecs plugin can be built.
> > > > > > 
> > > > > 
> > > > > RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
> > > > > and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
> > > > > supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
> > > > > sure the naming of the variable is proper? Should we go for
> > > > > HAS_STATELESS_VPU instead?
> > > > 
> > > > What about 2 knobs:
> > > > 	1. HAS_HANTRO
> > > > 	2. HAS_RKVDEC
> > > > ?
> > > > 
> > > > Does gstreamer have knobs for both sets?
> > > > 
> > > 
> > > They are both stateless VPUs, supported by the same kernel API I believe. So
> > > the same meson option is used, v4l2codecs, so I don't think we need to have
> > > two separate knobs for those? At least, I used the same gstreamer plugin for
> > > decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
> > > RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
> > > an RKVDECv2, which likely is also stateless?
> > 
> > Is this something the user will definitely always want on (i.e. it won't
> > work without it) or should we allow the user the choose whether they want it
> > enabled or not?
> > 
> 
> Considering that the only other tool I'm aware of for decoding is ffmpeg and
> it does not currently support stateless VPUs
> (https://ffmpeg.org/pipermail/ffmpeg-devel/2024-August/332034.html), if one
> wants to do decoding on upstream kernel on Rockchip boards, they'll need the
> v4l2codecs PACKAGECONFIG option for gst-plugins-bad recipe selected.
> 
> They could also disable it for their board if they want to by redefining
> HAS_HANTRO variable in their own config file? Or in a distro, etc.

I just wanted to make sure the = in the patches wasn't going to prevent them
from doing that.

> 
> > Personally I would rather see one patch to add this one feature, rather than
> > 8.
> > 
> 
> Those were separate patches for multiple reasons:
> - I only tested on 2 vanilla upstream kernel (RK3399, PX30)
> - I only tested on 1 downstream upstream-based kernel (RK3588)
> - the rest is untested (not even built)
> - All patches except the one for RK3588(s) could be backported to other
> branches (e.g. scarthgap); this turned out to be incorrect because the
> :rockchip OVERRIDES isn't available in that branch (but we can fix this :)
> ).
> 
> I wanted to provide also the context for tests I've performed on those
> boards in the commit log. It could be quite long if I put all tests for all
> SoC in the same commit log (but that's fine with me).

Have you seen the size of some of my commit messages? ;-) I don't mind a large
commit message. I've build-tested your patchset against all rockchip MACHINEs
and it builds fine. When it comes time to backport, the patch can be adjusted
as necessary.

> > Should we add a note in the README about this, or perhaps the gstreamer
> > bbappend?
> > 
> 
> What exactly would you like to see there?

Nobody starts by reading the README, but if a user is browsing the MACHINE
files, notices the HANTRO line and is looking for a quick understanding, they
might reach for the README file then? You know that HANTRO refers to something
to do with video decoding, does everybody? Even if all you do is duplicate the
commit message from 1/9 that would be great.


> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#550): https://lists.yoctoproject.org/g/yocto-patches/message/550
> Mute This Topic: https://lists.yoctoproject.org/mt/107999800/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

