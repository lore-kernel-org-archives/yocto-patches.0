Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D932C52D7C
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 12:23:43 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.11973.1724329413229963030
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Aug 2024 05:23:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ILlWInFC;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44ff9281e93so3176951cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724329411; x=1724934211; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxOE4pACVJVjGuan2YqlP4Fdc/0tiuRJ2zNjyAfMXzc=;
        b=ILlWInFCqeVPpJ7h2Qv3Hfgdat7lny8AEAcHRrynsXgB22tj0yKY9ABnhdO5ha5GPU
         JkOC/4s6LH+AnWuly+xPYDBzpcMp3BNCbtXmDVRDONOM32b9BBIhE/o303NeBxzwRB8h
         9NEzJIGMlL+KEjPAHY4Cb/Mc3S2nnewXSVnZfQIvTwH7HtYtqjE99p6ocUmv9Via1Nmv
         vWT3TpXL1ybwNki4YybjGiCobtLnJlpiLcPf0Q6PLEGvnz0Mer0b2Ixs3PM6MAjqDC8S
         QA0U17kiEPXF4MfshDbqzhRLEUV8i+srri1HU1/PE802hkmahlfcnyeMeVx5+tze1VIy
         Ywrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329411; x=1724934211;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxOE4pACVJVjGuan2YqlP4Fdc/0tiuRJ2zNjyAfMXzc=;
        b=XLsmMH/gvoC7pahQrLMlwvMwnktfD18vopWvb6cHz4Xe28g+Ou16kAyMlbsgUklTwZ
         7kPapFd70XRt3dKbuFOaUKLWlmJLIpRFZOt6CrNIG3u7syrO3RTsNhw9L1pJ8j12ZbMy
         BmNkfb1sA1b8iori0wbyBoGRSMmMT3w1awys8kVSWuFkyg8ar9iibnMjpfqyCwF5eY77
         K9ruqj6BTwVpBjHOrxMclmN6ganMVjWWmX7u0veZ7D9uZNzAbSQS+etaVeRKEPKDNg7j
         U1jgWv5lhbt6FoXlgBnw9gJp4YJAekiymf3HQIxhV2Om2qWQA4S/yN3Ywoi33Jt5+VIl
         6Uog==
X-Gm-Message-State: AOJu0YwdZrdVevbnCLfL2Q5fJslwBzHg5mz5KnQQG86Xexw3FsYkaKYp
	rpZuColjzvlL3Gw14nRVhqh91ILougfgFOpr3PkDB/ckC4rwwB/mRECKWQ==
X-Google-Smtp-Source: AGHT+IGP2RjwZK6ZQ6mFNY4zcgxor/mHIvRaCdEbdHlQTUMxThiXfHtAVfjWyomsDL7Pj+JUGwlfDQ==
X-Received: by 2002:a05:622a:5988:b0:451:ca77:c5a1 with SMTP id d75a77b69052e-454ff7f9639mr19423371cf.35.1724329411403;
        Thu, 22 Aug 2024 05:23:31 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0d8f85sm6135261cf.24.2024.08.22.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:23:30 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:23:28 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
Message-ID: <20240822122328.GA24992@localhost>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
 <20240821044243.GA1194@localhost>
 <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 12:23:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/549

On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > 
> > > 
> > > On 8/20/24 2:56 PM, Quentin Schulz wrote:
> > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > 
> > > > RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
> > > > v4l2codecs plugin can be built.
> > > > 
> > > 
> > > RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
> > > and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
> > > supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
> > > sure the naming of the variable is proper? Should we go for
> > > HAS_STATELESS_VPU instead?
> > 
> > What about 2 knobs:
> > 	1. HAS_HANTRO
> > 	2. HAS_RKVDEC
> > ?
> > 
> > Does gstreamer have knobs for both sets?
> > 
> 
> They are both stateless VPUs, supported by the same kernel API I believe. So
> the same meson option is used, v4l2codecs, so I don't think we need to have
> two separate knobs for those? At least, I used the same gstreamer plugin for
> decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
> RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
> an RKVDECv2, which likely is also stateless?

Is this something the user will definitely always want on (i.e. it won't
work without it) or should we allow the user the choose whether they want it
enabled or not?

Personally I would rather see one patch to add this one feature, rather than
8.

Should we add a note in the README about this, or perhaps the gstreamer
bbappend?

> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#538): https://lists.yoctoproject.org/g/yocto-patches/message/538
> Mute This Topic: https://lists.yoctoproject.org/mt/107999800/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

