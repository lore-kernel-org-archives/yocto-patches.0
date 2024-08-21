Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C64C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 04:42:51 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.12882.1724215368606371769
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 21:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XT6AtCkL;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: twoerner@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d311d8091so18668395ab.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 21:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724215367; x=1724820167; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYGEHLdgZbXFuWRQgnAx305tXtMexFWc0ETaQ7T+3Ps=;
        b=XT6AtCkLlsca0vGI94PS03nzmgzWy3MGM+LCRs2IQNle6kzqZpWRnbz1AK/9ladvC9
         dXroFc/O4MujPk75JpSqCObY4RhnOw1VYfLmPRbLvXUu+bcNG0W7MlZPGwekwMVbyZyW
         uOu9kcN2QcizR++UxcdGB5j52gwvTlQWtMEvYhwYPQKfB9QF0fspb3gaGt/1Qqx/kVtw
         feGpS9vOU87AYvTyu3kNDXXVmRajSf3dUoxhzrOYSROGPzBidKTBNaBoLvS8Ntbi9ztK
         ev0N7SCAAInHAzK9P6d5OJgAl0B5LRA3/0WlfYL0HqGkw7/46DPnGq/zVNF9Ys5Kqc5H
         kVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724215367; x=1724820167;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYGEHLdgZbXFuWRQgnAx305tXtMexFWc0ETaQ7T+3Ps=;
        b=cWIlefsYPXMA+HEGFGRPzl45m0sp57mlFJdLA7qJNQ6Tjvq6pALomVBOzh3XtWkW/6
         bL5xcR5r9QIWtuWB0xBkxTeyWmymkTEw0jm8NAmkIavxh7J9jhLZ8z/UKiU/VE1cbXud
         ZYiV9N7lxpVEDalgAmkVr3RyYZl4ObB9WF2b1ayCsiVPDEzoiAm7vnBpicA21E7olm9B
         J77puRtQi/ki56Vh/PNmglXBSo1mQNbWit1IzTkzWTMOmbKkJX9MIGufaOzy2OuXDTjo
         aiJXvrazWNKzZGxNuTWH9rUd7AnMUCSEnHnV2X4enYyGBoAkRCQ/x9vELynl8Nww4Tp7
         4A+g==
X-Gm-Message-State: AOJu0YyhFt1mkoca3YHe1KlYE4i98tdye+fRyAneIPignDgYfuAOwauQ
	yCTCApR5qgeIcWXasJq9C1juiUniGJ9STWYgsbAePg6yWM3PC2iURxHDhJum
X-Google-Smtp-Source: AGHT+IHD9q/Q2tlhsFrxQkdHekrd4yBS7YO+C8cavBHWMNzwzCslFevkYC6Za6Plq7dn//r4syGGdw==
X-Received: by 2002:a05:6e02:1aa4:b0:375:aaaf:e88f with SMTP id e9e14a558f8ab-39d6c3bdfacmr10917825ab.27.1724215366974;
        Tue, 20 Aug 2024 21:42:46 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d34bd5a85sm31315945ab.4.2024.08.20.21.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 21:42:45 -0700 (PDT)
Date: Wed, 21 Aug 2024 00:42:43 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
Message-ID: <20240821044243.GA1194@localhost>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 04:42:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/536

On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> 
> 
> On 8/20/24 2:56 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
> > v4l2codecs plugin can be built.
> > 
> 
> RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
> and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
> supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
> sure the naming of the variable is proper? Should we go for
> HAS_STATELESS_VPU instead?

What about 2 knobs:
	1. HAS_HANTRO
	2. HAS_RKVDEC
?

Does gstreamer have knobs for both sets?

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#535): https://lists.yoctoproject.org/g/yocto-patches/message/535
> Mute This Topic: https://lists.yoctoproject.org/mt/107999800/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

