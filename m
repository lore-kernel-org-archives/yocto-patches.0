Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF1D59D86
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:28:32 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.233.1765564105240515796
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 10:28:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EWjfMnWy;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ba3ffd54dbso223177285a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765564104; x=1766168904; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sffLWgUvNSoxwXLEmBUIr4ZvZOiHW1pfQGmQDxkZTw=;
        b=EWjfMnWyksjYOkFKRJNQLPZcBfm0FDcVtcfdaVZGfatzs7HYGN66IyCJMLD5KAZlLL
         zrS3SztbtiVU2513McMU+zNucpB8Yw/vtKLSjAT3LVRl7/sm36yQnEfx5/QPRtCk4kPT
         Kp3xfT3n1bsm8gTpM1YJLGBpWk59p6Tvnkh7xqKp6nKrzXaB692MYLuYfK44DIOWOutm
         Q4zawB33nqSNUJw9UHEwAFLc94EPiGPSyuk81k107YEEMPulSTT6ounIgC7+AiL4LbVl
         iyA09PApBMOPBK42XVexdMshDfB5/5Nmn9nsmzwxsziQCBhB6Evw/Lr1mSapdH3iMaM0
         43og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564104; x=1766168904;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sffLWgUvNSoxwXLEmBUIr4ZvZOiHW1pfQGmQDxkZTw=;
        b=TXHLhTxZ/EMuikH0mU2xNtIlLQyyGz5/Qdl3sW2+W5RVmN8kWfsqLQB1W8w4Ic/5DO
         PsoUy/u0Xr2/kZJo/ZFwJ3FwUtKC3E8ggM/qZAAdozuuxvmeiBPPnL5d+SWYMsem5h8V
         9lFQucfdMPyxy+ZFfy0W9QcdYCqAvrRIDLFeZ44aFevwUVDQ7dItp7AL/YzOFn++grIq
         UFSk8QeBUhkdXNqnbvl/KYMikSOPAp4MSn+qEY/acBHNF9/uzXzSvpwZA2S6PmxeN357
         3kP8kLR8cUyhSE5i3w/7WDtuloGyFCCYKl5q+M167vJpV0Cd4tp2bfVpKTpoHoIc8Ylf
         iHJQ==
X-Gm-Message-State: AOJu0YzM2Ypac1QlByG/CNyrTckIRLls8+zR6n1vXEpxJx592y/JmBt/
	KrV+dP91NutnXlayjCpv/EEa5fCUkq5D2cSKhNNvFJoiQRsZpYZFatZXb8zyWA==
X-Gm-Gg: AY/fxX5OLnbbX20bkI1JJqIgKIKNH6rV8X17jG2Zr23KyZM9EV2a0t/uIcTlFcUYkrU
	sG0hO6YeQxQ81Qy80qUV8g7gvNm5cXjtf33AS8wIljvQBO888OlQeSXntXCyxZCvGqH64FNUM54
	RJPHBWMdfvhLRVNPMTCh533H8PQxjbPomBNk0id98FEqskcAKQpBW1r7w+4qDhirI7+Ph9l8q3k
	Uk0AsSLJLBzu2HscOa+DWBLHu23M6Lri2q8FlayqrIgutJWnbY9167vNXVfC1Sm+uCYQis41qGF
	kgIq7ug9cgHya2lSuQuYSqUQCl+NKV4W2QLM3l03b/s+t4lsGLehoaSWw7eR4PL0AxUEnQTj8La
	510lrUc5TM+gcJLSPasPzaevjytALrI9kzpJENXMvKwiewB9cb99Wv5W8UFtIiEM3DTMiCcUwK0
	ZmjB1w+6PdN5s+jSF/RhDsyZAl9MbTM3V3pnwa8Q==
X-Google-Smtp-Source: AGHT+IFGJOnd1nCf67ssiSu7sihNybMag7QWcon6ir1xxss9B5V1x1D9BhCEijlOudsZn/yiKAEcCg==
X-Received: by 2002:a05:620a:290b:b0:891:a6b0:7cda with SMTP id af79cd13be357-8bb3a38f65emr407669585a.81.1765564103560;
        Fri, 12 Dec 2025 10:28:23 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3f637sm522262485a.39.2025.12.12.10.28.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:28:23 -0800 (PST)
Date: Fri, 12 Dec 2025 13:28:21 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] provide a filesystem
 overlay example
Message-ID: <20251212182821.GA25336@localhost>
References: <20251211210332.25509-1-twoerner@gmail.com>
 <12e8c8b3-f1b4-4aaa-abac-9449f9daffd3@cherry.de>
 <20251212134919.GA8875@localhost>
 <1142de2d-3820-4d2a-b51b-14947b710f3a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142de2d-3820-4d2a-b51b-14947b710f3a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 18:28:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2777

On Fri 2025-12-12 @ 03:05:10 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 12/12/25 2:49 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Fri 2025-12-12 @ 11:47:55 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Hi Trevor,
> > > 
> > > On 12/11/25 10:03 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> [...]
> > > Additionally, CONFIG_OVERLAY_FS support likely needs to be enabled in the
> > > kernel for this to work, so mentioning this would be nice? (though we also
> > > didn't mention this for the VPU, so... :) ).
> > 
> > It's funny I didn't mention this, considering the other email thread in
> > progress ;-) The aarch64 defconfig includes:
> > 
> > 	CONFIG_OVERLAY_FS=m
> > 
> > which is good enough to make this work. It also includes
> 
> If one includes kernel-modules in the image ;)
> 
> [...]
> 
> > > > diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> > > > new file mode 100644
> > > > index 000000000000..d6a384fa9c75
> > > > --- /dev/null
> > > > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> > > > @@ -0,0 +1,13 @@
> > > > +[Unit]
> > > > +Description=OverlayFS mount for /home to /data/overlay/home
> > > > +Requires=etc.mount
> > > > +After=etc.mount
> > > > +
> > > 
> > > Why is this not data.mount too?
> > 
> > I did this patch one piece at a time. It took me less than an hour from
> > start of reading to getting /etc working. It then took me the rest of
> > the day to get /home added as well. The problem was with
> > ordering/dependencies.
> > 
> > If I ordered both /home and /etc overlays after data.mount it would
> > always fail; either one or both of the mounts would not appear in the
> > `mount` output or (worse) the overlays would appear to be mounted (they
> > would show up in the `mount` output) but one or both of the mounts would
> > not work.
> > 
> 
> That's really odd. Half wondering if this shouldn't be brought up to the
> systemd community? Not sure exactly what could be going wrong..
> 
> > The solution I found was to explicitly order them: data → etc → home. In
> > practice it didn't matter whether home or etc came first, they just
> > needed to be strongly ordered.
> > 
> > While trying to get this right, sometimes systemd itself would throw a:
> > 
> > 	[ SKIP ] Ordering cycle found, skipping Ove…mount for /etc to /data/overlay/etc
> 
> But there's no circular dependency... That's weird.
> 
> > 
> > on boot (sometimes for etc, sometime for home) which at least warned me
> > that something went wrong. Other times it didn't give the error, but
> > failed anyway.
> > 
> > tl;dr: it's a bit finicky ;-)
> > 
> 
> This is the kind of information one would want to have in a comment or in
> the git commit log so that we know *why* something seemingly odd was done.
> It wasn't a mistake or an oversight, but a work-around for a specific issue.

WOW! Your suggestion to use RequiresMountsFor did the trick! It
literally solved all the problems I was seeing. Take a look at the v2 i
just posted.

Thanks!

