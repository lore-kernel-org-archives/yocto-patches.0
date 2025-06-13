Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BCC71136
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 15:05:42 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.12714.1749827135211317449
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 08:05:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mG3nc2gL;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d098f7bd77so235530285a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827133; x=1750431933; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3lnL4oRBGqMAjQyfjG5gQA2cskpjHZDgerTRRs6sxo=;
        b=mG3nc2gLNSsSKrDrNggvb+2P6Ez5ffMcm4ZrM2onJa3BO6mlmirEoNlNqK2TIRgmmp
         EQ4zHRaKrBP6EiAVTCfQEf616wIzzSdNCYzEbUzXAk3X9aFFDfV8kpjmyeqRnWf+Waik
         bwGL2cucNgcgIA8umrLzmYYvauRpPz1ky1iTJk0rGJ7SzV0IzX5fmUtqD5rxvz7vWxwy
         LWTjKnocZtCoGT//tdp9bYn2fw+o6IBiU5hh7X3L2dRYXXmcaS1y3bwfj1ddPMsS9aF1
         By1V10eWkamKhuaokoYt2p6WANwT6ImM5dCAFM19EusOc9fPVjIX1WSxgpBQyBmbTj2R
         BV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827133; x=1750431933;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3lnL4oRBGqMAjQyfjG5gQA2cskpjHZDgerTRRs6sxo=;
        b=BT87yoFNBlajmcYP+HlP7fq2Uew90lkPEaS1JfikW0jtoxP7VhKSHbB3AfQJp3nldS
         aqY2+GU1PzVVhzjZRJLPKRD3uk+lGrt7fHwfqYA/M2Q0/kot+x8UFyAeEHKpIin42PCz
         TOl/UmgTHNex/+6CFJf26ib/bQGtWeAawDpszr2u2S3TilX26JtMKPLGmegirLCdtu4E
         GhiI0kQZL39zggWi6Ppzf9mIo7GuImrIwMYR1MoGAVw0kyQnh6+qV6b1or7+Wzp/5pJO
         iwdbSFA6yT43fOtYYKDGoe05RTIJyVpdUrdEAME+0m44Bvh5OFgYzEZuQY2ulYvC14zK
         VPtQ==
X-Gm-Message-State: AOJu0YxcFbXPOjzFW2bAb6SKaPlTPcZK8o/E6VgOfsAQeX+2F7ky3CyN
	r0KKRKMKg7cG76JZ1QhgQCl/1n9DVDfbJC3pWBO0YyZ2QuTwdOn8fp3mavwAwQ2N
X-Gm-Gg: ASbGncvXnAKxNXu9FaLZJ8JlynbyM7bNcA9OxCaoCom8Q0RI2hmTLyg14Fj8mc0jkwq
	du3pcyAR3ZeLzuhBSvUWzjsvhkxsdUqjbe2TQxeNOjIC23WbS7PYbT4qLp6yzcot27zXZFeDTgm
	SHuEeLviGS434gNV/IOpvyvrqUXT3hT7lhLPIHAE2lexTdkwTNFFauMCEHHYCuV/S9DTNH1w3U4
	5wJXuXzgDSslAQtVVZjYWI3UNRg0whQXBD5kDOtod8eU5N0xrhVqsMRhB7AFv06QHMAVqROtLfq
	Hq0NoJcHiHpDGs/+wgaXoY3ShLjKXwJ9RHld86j8yfwIWiYNf41VqcHryT+oBmeBwsPCfT/mz6+
	akP//l01Uqn2I7Q==
X-Google-Smtp-Source: AGHT+IG9fkISo2z7UlgNQNc2sFfNYka8qkNGDG30iMZ3nctCPxCNvuFt1XQ/Mi42ecJj0358nKzZ0Q==
X-Received: by 2002:a05:620a:4483:b0:7cd:1b4b:e5fb with SMTP id af79cd13be357-7d3c6855c8fmr6871185a.21.1749827133535;
        Fri, 13 Jun 2025 08:05:33 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eceb35sm179371485a.80.2025.06.13.08.05.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:05:32 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:05:30 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/2] trusted-firmware-a:
 remove no-longer-required patches
Message-ID: <20250613150530.GA20372@localhost>
References: <20250613102357.1539-1-twoerner@gmail.com>
 <7d7b6604-a642-49ee-97fd-181a41072b0f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d7b6604-a642-49ee-97fd-181a41072b0f@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 15:05:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1642

On Fri 2025-06-13 @ 02:11:07 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/13/25 12:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The two patches being carried in this layer for tf-a are no longer required
> > and can be dropped.
> > 
> 
> Better even, they were merged :)
> 
> f86c230ab02c ("fix(rk3399): dram: Fix build with gcc 11")
> 
> for the first one, part of v2.13 (but maybe will be backported to lts
> releases?)
> 
> 7f25d3cc7823 ("fix(rockchip): pmu: Do not mark already defined functions as
> weak")
> 
> for the second one, part of v2.13 (but maybe will be backport to lts
> releases? watch out for Yocto branches with 2.12 release for example).
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Awesome thanks! Added to the commit.

> Thanks!
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1639): https://lists.yoctoproject.org/g/yocto-patches/message/1639
> Mute This Topic: https://lists.yoctoproject.org/mt/113621967/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

