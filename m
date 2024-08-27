Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79737C5472F
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 15:10:33 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web11.80247.1724771432546922372
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Aug 2024 08:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ltPPdMAp;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fff73f223so29511041cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Aug 2024 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724771431; x=1725376231; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF8CzJ15Lpqbbu+88v9Llqzx0LMPxWT31+3y+qQp2jA=;
        b=ltPPdMApNrF1YjaEkXffzqxQw4R2Z9zFOwkYxutbSOrrD8jjnxvL4BhLcabvI+dvY2
         s1J0X8aVfk0/8Yjz7N3MjQTqFSFI0RtB8KAzWo/LmbL+99LHdRiDZt0Dcsrm0LTOlmhT
         n7nQfS0zc1UP3zBtUrwUjcwcEMOWZF/xSRTMXAVWezw1G/wiZsmAHlnfdyCmk3EV5aIa
         hsbHDvpUHYyHqm/D1tFDy80T+dp1OXoC3IznzKLyNF2Kh0c24Y9WewInHlUgXR/RkEuu
         7Bdi34JCUi7ib6nRO1kaMLgMellhQ1wcHfSRQEH+fkQnDnKDatUuOy1mkuRdZw4czOHI
         k+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771431; x=1725376231;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF8CzJ15Lpqbbu+88v9Llqzx0LMPxWT31+3y+qQp2jA=;
        b=XPcyPlXUOJd5w/aCZ/NKbMEg9Ib8X47NK5juWEAa2XQmVN5YGY/i/z+HBk+h/vVpia
         Qu0ZFwRkrCpZHQG25s4LCa0qjapSJhz24QvqXbuJv0g4SPVtgyalERKfAyyp21XMvat4
         c6exAl/CoEpifvMW9KqsoA7W8vAJmWkRvvD5UERJiykVZAUtro0fip0RUMItspoT4iYq
         hv2jiltHnx5qnTBiZ6PzH6jAF/tNGAcJeMztTz/Vhi9yWL+td75ab5lmJbvP8M95Usup
         m6WYRJTqOihkWC6snrEVIkYUIkBl1WrIj18xeWCmcQk8uaeop1dM+j7fD5Lg/a2TUdDb
         OfgA==
X-Gm-Message-State: AOJu0Yw1YutiZrkahAAFBalO/1K4TjDXH2QRJSnvrqb0lkZe4PBXwhtU
	LC8jRdPsHBD+Dokp1pLZo5UHCaRExQAol8TOeH24hE7BcviCFYORWJWkjw==
X-Google-Smtp-Source: AGHT+IFqpwj3CLqsurrmiTt45fIes3R4PVsrfmcFHnt+mF13ipLdbsanosJx8J59wcs/iSen+xx69Q==
X-Received: by 2002:a05:6214:5882:b0:6c1:6e3a:6d17 with SMTP id 6a1803df08f44-6c32b6a1808mr31947686d6.6.1724771430492;
        Tue, 27 Aug 2024 08:10:30 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcc904sm56485476d6.104.2024.08.27.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:10:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:10:27 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
Message-ID: <20240827151027.GA29205@localhost>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
 <20240821044243.GA1194@localhost>
 <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
 <20240822122328.GA24992@localhost>
 <d29f0a9a-bab3-4f73-9b9e-361909b95092@cherry.de>
 <20240823135520.GB28691@localhost>
 <be2e3176-18a9-44f6-843f-d52c43e1df39@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be2e3176-18a9-44f6-843f-d52c43e1df39@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Aug 2024 15:10:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/564

On Mon 2024-08-26 @ 05:35:14 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 8/23/24 3:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Thu 2024-08-22 @ 02:38:11 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Hi Trevor,
> > > 
> > > On 8/22/24 2:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > > > Hi Trevor,
> > > > > 
> > > > > On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > > > On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 8/20/24 2:56 PM, Quentin Schulz wrote:
> > > > > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > > > 
> > > > > > > > RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
> > > > > > > > v4l2codecs plugin can be built.
> > > > > > > > 
> > > > > > > 
> > > > > > > RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
> > > > > > > and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
> > > > > > > supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
> > > > > > > sure the naming of the variable is proper? Should we go for
> > > > > > > HAS_STATELESS_VPU instead?
> > > > > > 
> > > > > > What about 2 knobs:
> > > > > > 	1. HAS_HANTRO
> > > > > > 	2. HAS_RKVDEC
> > > > > > ?
> > > > > > 
> > > > > > Does gstreamer have knobs for both sets?
> > > > > > 
> > > > > 
> > > > > They are both stateless VPUs, supported by the same kernel API I believe. So
> > > > > the same meson option is used, v4l2codecs, so I don't think we need to have
> > > > > two separate knobs for those? At least, I used the same gstreamer plugin for
> > > > > decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
> > > > > RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
> > > > > an RKVDECv2, which likely is also stateless?
> > > > 
> > > > Is this something the user will definitely always want on (i.e. it won't
> > > > work without it) or should we allow the user the choose whether they want it
> > > > enabled or not?
> > > > 
> > > 
> > > Considering that the only other tool I'm aware of for decoding is ffmpeg and
> > > it does not currently support stateless VPUs
> > > (https://ffmpeg.org/pipermail/ffmpeg-devel/2024-August/332034.html), if one
> > > wants to do decoding on upstream kernel on Rockchip boards, they'll need the
> > > v4l2codecs PACKAGECONFIG option for gst-plugins-bad recipe selected.
> > > 
> > > They could also disable it for their board if they want to by redefining
> > > HAS_HANTRO variable in their own config file? Or in a distro, etc.
> > 
> > I just wanted to make sure the = in the patches wasn't going to prevent them
> > from doing that.
> > 
> 
> Well, it does. So thanks for bringing this up :)
> 
> > > 
> > > > Personally I would rather see one patch to add this one feature, rather than
> > > > 8.
> > > > 
> > > 
> > > Those were separate patches for multiple reasons:
> > > - I only tested on 2 vanilla upstream kernel (RK3399, PX30)
> > > - I only tested on 1 downstream upstream-based kernel (RK3588)
> > > - the rest is untested (not even built)
> > > - All patches except the one for RK3588(s) could be backported to other
> > > branches (e.g. scarthgap); this turned out to be incorrect because the
> > > :rockchip OVERRIDES isn't available in that branch (but we can fix this :)
> > > ).
> > > 
> > > I wanted to provide also the context for tests I've performed on those
> > > boards in the commit log. It could be quite long if I put all tests for all
> > > SoC in the same commit log (but that's fine with me).
> > 
> > Have you seen the size of some of my commit messages? ;-) I don't mind a large
> > commit message. I've build-tested your patchset against all rockchip MACHINEs
> > and it builds fine. When it comes time to backport, the patch can be adjusted
> > as necessary.
> > 
> 
> ACK, will do.
> 
> > > > Should we add a note in the README about this, or perhaps the gstreamer
> > > > bbappend?
> > > > 
> > > 
> > > What exactly would you like to see there?
> > 
> > Nobody starts by reading the README, but if a user is browsing the MACHINE
> > files, notices the HANTRO line and is looking for a quick understanding, they
> > might reach for the README file then? You know that HANTRO refers to something
> > to do with video decoding, does everybody? Even if all you do is duplicate the
> > commit message from 1/9 that would be great.
> > 
> 
> Fair point, the hardest part is now to come up with a proper name for the
> variable that is not misleading.
> 
> Something like:
> 
> UPSTREAM_STATELESS_VPU ?= "1"
> 
> maybe?

If one reads the text that scrolls past while booting, the word Hantro does
show up on devices that have it. Could the variable include the string
"hantro" in it somewhere?

> 
> I would still add a comment in the README as requested.
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#563): https://lists.yoctoproject.org/g/yocto-patches/message/563
> Mute This Topic: https://lists.yoctoproject.org/mt/107999800/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

