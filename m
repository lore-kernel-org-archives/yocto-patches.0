Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB34D47CC2
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 10:04:35 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2799.1768557874575813011
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 Jan 2026 02:04:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CdBZo/ZI;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso19280436d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557873; x=1769162673; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVzaOH07ffow3JutbH9wZoszolp1hocos01KxQce87c=;
        b=CdBZo/ZIHzEVeDPvpd+0CJ3dEKEUJpZlXuBYY7VciVreH8ltK3cIoJCB0alEpkZ1Lu
         5rkuwa4SQDbl867eIdY0b3L1RFP12hKSq7VzVs/X2aqUMjLl3pk5vdQLnfbPO7okD+n7
         wKHWHm3hiwV/vKJrhzWFDxL5naTe+9tc4OM7Mb9kHITDyivvq5YwaDuRG+fByelUcD8z
         AbSPCMQwGzUyuytDXe4cHa6qPer/Ol8I1kTysniehxlv8R/BD26HlmchEZlj2rkpT7Wt
         H31dxGaihkUCUYM9miaFjOSrLHVFp58vZRxU/pk45fTaLNlgAJk73FJG0cNnIN2HZ2zh
         pCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557873; x=1769162673;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVzaOH07ffow3JutbH9wZoszolp1hocos01KxQce87c=;
        b=GqQCRRE5oZjU4qJrti36IpWXknX/emem74D5r2c4kklIaT1LqCvC5E/o/RhrAITWzw
         UeXsew9+m3jobb0Agk0XXYQ8t5CIruPXOW8K6+iOYd5aqrSQs+wv1KaKGGrMaqbnmVhh
         46k9RBGh5oJX22qcSD/2p5tJB0JNBKc90vNxz6bN34mF7DCFTWqond4cSyofk8Gt63MF
         2PC0YCLEdzcHjTpK2LiGnwlSnb3ISpK0TiBcbTH5QUlD2i2BZNgEptU21Zkydh2zJ96q
         E0HuINhTU5r5vEslja4QkJu1CovUdNBa3tJJe73QnHLiUE7zua9MaejKZ59UH1S99ubr
         Z3xQ==
X-Gm-Message-State: AOJu0YxiceNAmHXGjkC4GrdsS07LcEbrljbbI0MzZN0w38s/g/J1U5cY
	K9HTwCUeugD2qGYZ4ghmFhu3wevtAsoTz1nQ3AEar/d95KvPMRYql1QVk/xjPMBFDwjE5VggpHV
	uCXGVTkSqvqm+4qFNY19aRDgP+USjYh8W6nVV
X-Gm-Gg: AY/fxX5JTNFUCnFFTrA8V6LQ7oA+6LWG5NpVxZHzoz3o6RzT8CgWdFc7can5AEjC7N7
	/2HD7nEfvmfdTluuQyT3SH0QHul5/9fhHD6cNBToiOJ5brPXXIATTNlkFQECOYS5PvBqAYRB3Be
	32xKTeGmReXF+bkfrOC/Jv0cPgpKIjS2KCBh6tDX6F83cDZollbBt6L8I/qQiwQk3ueXGnhgj7l
	TvG4oW+PSnSskusm5XZtGHUww0k/r0EU19UU66J5qwwhtdR84rlP8jo0W0yDKGnDwLeAg==
X-Received: by 2002:a05:6214:19e6:b0:890:1b3:e3f3 with SMTP id
 6a1803df08f44-8942e4b037cmr40669026d6.51.1768557873276; Fri, 16 Jan 2026
 02:04:33 -0800 (PST)
MIME-Version: 1.0
References: <188B2DD1C24AD0EF.2721127@lists.yoctoproject.org>
In-Reply-To: <188B2DD1C24AD0EF.2721127@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 16 Jan 2026 11:04:22 +0100
X-Gm-Features: AZwV_QhXQeqOPQcMAIRtp-a8klMnxMsbMquTTBL2AWNDG21UxX89HOcYtqGRv7A
Message-ID: <CANNYZj9=2Kcrjy-BH+A8c=OxkowzWMut_f0MD+=vSK026ibaWw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/shared-repo-unpack: disable the common-sstate feature of bitbake-setup
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 10:04:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3001

Note: this should be merged at the same time as the common-sstate
bitbake-setup feature merges, assuming it does not get any further
reworks.


Alex

On Fri, 16 Jan 2026 at 11:00, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:
>
> From: Alexander Kanavin <alex@linutronix.de>
>
> Autobuilder runs its own custom sstate setup with a dedicated hash equiv
> server, and bitbake-setup should not be getting in the way of that.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  scripts/shared-repo-unpack | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
> index a12fcaa..797dec6 100755
> --- a/scripts/shared-repo-unpack
> +++ b/scripts/shared-repo-unpack
> @@ -96,6 +96,7 @@ try:
>             "--setting", "default", "top-dir-prefix",  os.path.dirname(os.path.dirname(args.abworkdir)),
>             "--setting", "default", "top-dir-name", os.path.basename(os.path.dirname(args.abworkdir)),
>             "--setting", "default", "dl-dir", bbs_dldir,
> +           "--setting", "default", "common-sstate", "no",
>             "--global-settings", args.abworkdir + "/settings.conf",
>             "init",
>             "--skip-selection", "machine",
> --
> 2.47.2
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3000): https://lists.yoctoproject.org/g/yocto-patches/message/3000
> Mute This Topic: https://lists.yoctoproject.org/mt/117295324/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

