Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3FFD8FE2
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 17:22:52 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75440.1772126568229329645
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 09:22:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=UAMsnkeq;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48371bb515eso15317905e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 09:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772126567; x=1772731367; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBwFFIxo6ed/8QkbLTyg4gEbFrLDjPQH24auctv1/h4=;
        b=UAMsnkeqyJhrdixbXyshb50rtmztD1fxaNBaUe2sn//trS/qeeI42QMSH0cflq8rPO
         sHjmdpGGhYgET0Se6+gnT49VOyYBEOnVNQuABMnR14W7CudHe/BTu916ZHG9vMJdk5Sh
         9JHu29+mTxpzjjnfMWK3zUCg1qqaYlWRGFGYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126567; x=1772731367;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBwFFIxo6ed/8QkbLTyg4gEbFrLDjPQH24auctv1/h4=;
        b=XXOKFnKd4LYHPgB4RRUjxXn+ph5+ae/qtap17XBWqgBdvmqHHiuF9gxTBtLLFSGCpi
         F7msJcaFjYTxXBE/LLYeTBOY9CIkX9rotEGtXcO6lOhgE3cqafzjNUC6tyzWqxxs0Yu0
         7B8zAiPf8qJxWIlQQP7V9JagLszmQLcYR5ak20wJiiHaLYUOG1SoKLn/p0edraXBa5dz
         vJbK+hyLHgdifkv7Ujjt8e3s+NwtFL1h0NG7FrvpMZuq05R1Lbl7iCiPU7CYq9BF7vD9
         Tpja2IbCm6r/+t0uo1e//WxkAJz4UWz45yXz7BnOM3+VuAdahVgkqI01rgsd0Z8/kBxT
         Lsdg==
X-Forwarded-Encrypted: i=1; AJvYcCVTZhFc+ME2IOrCPRSlupbkRxIpBFkPAe0X5HlI6WIUnVjzUy/qQ305TbubdgS0xi23vBGU/Hh1sZLdo/Ng@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxMZIhNnbOUbFj8RyJiqsHXVSCCCEnZvrPYImfDoHx+vmCGu43O
	GrFbo+af9hb+CMn5vZGCvU1KzKRmdf591VrZMZ3Hq53Tphls/JZDe6Bw8rHmQAkNdtw=
X-Gm-Gg: ATEYQzys1nc4XbuB2kvJ7o6dAYUiHMC104RX+bhcoFt1fqSFczFTxEShTuA4An3rG72
	iCGrG5tNxPJ8KXX1YyLIeVIYixacwgVWkIRMzkRwgF1Ud/LddVe9F9/jcWQy/w/vjkMu8JWIUn+
	5rEwoOA6xUQCF12O7+HQD3dJg1c95aIzSdhEuR+xuY6TFzBIGI5lFEhzTnS+fY5hVBKITH/4OJ5
	6DoMkCapThE5cRgPgbMazuy9AO8bH710iHVGzSOLKUsBWAnMUcmWwqHQXu5FL1sy433mUtGGK9c
	RGGAB1IVM6TzNKf0HHW3eXc9L4tYiyUjPfd1MyCdHUdxHWxpllrVEk98E5zB6TYDP5rfLZpkElU
	+enoGwELAOh1KgmqaY6Z/6CqvUN11OX4Nd2c5o6fUlixHgYGOaMTdlkyEAWUGqJw+Vo+dcrnUTM
	R90p4sPpOaPxgM32/HnYYPjxwg/cKcvstVVhwhdNCb1+JxRLHUD7sY+wi0tmeIL+OMtZHpaFedy
	QwALUyIrcHvaSnTekZWdpJ+6+Q=
X-Received: by 2002:a05:600c:1d1d:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c3deae7cmr48980785e9.26.1772126566568;
        Thu, 26 Feb 2026 09:22:46 -0800 (PST)
Received: from localhost (2a01cb001331aa002c0b752a8b25831e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:2c0b:752a:8b25:831e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b19esm697605f8f.25.2026.02.26.09.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 09:22:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 18:22:45 +0100
Message-Id: <DGP2FTGRLVW6.2YKYDHP4SZRCI@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2] schedulers: Add
 stable -next/-nut builds to the branch selector
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260226144201.47577-1-yoann.congal@smile.fr>
 <433b819f2977f580713495429fab3cad59a5c430.camel@linuxfoundation.org>
 <DGOZSACRJBVH.18WU5AD0T6D8@smile.fr>
 <2caa358b916e7cc6e76b3f51d4ec2dda6e9b95bd.camel@linuxfoundation.org>
In-Reply-To: <2caa358b916e7cc6e76b3f51d4ec2dda6e9b95bd.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 17:22:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3294

On Thu Feb 26, 2026 at 4:20 PM CET, Richard Purdie wrote:
> On Thu, 2026-02-26 at 16:17 +0100, Yoann Congal wrote:
>> On Thu Feb 26, 2026 at 4:11 PM CET, Richard Purdie wrote:
>> > On Thu, 2026-02-26 at 15:42 +0100, Yoann Congal via
>> > lists.yoctoproject.org wrote:
>> > > From: Yoann Congal <yoann.congal@smile.fr>
>> > >=20
>> > > These build setups are frequently used for stable maintenance
>> > > work. A shortcut is appreciated.
>> > >=20
>> > > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> > > ---
>> > > =C2=A0schedulers.py | 76
>> > > ++++++++++++++++++++++++++++++++++++++++++++++++++-
>> > > =C2=A01 file changed, 75 insertions(+), 1 deletion(-)
>> >=20
>> > Do we need both -next and -nut?
>>=20
>> It depends on what you want to see in my pull requests for stable
>> branches. If you find a -nut AB build convincing enough, -nut is
>> enough
>> and I don't need -next.
>>=20
>> I will send a v3 without -next.
>
> There isn't any point in me duplicating your builds!
>
> I did wonder if it would be clearer if you just use the -next
> namespace, as long as it is in the contrib repos? "nut" is a bit
> convoluted. The only reason we have the differences was to differ
> between my builds and those of Mathieu, Ross or others.

For the records, we did discuss this after the bugtriage call:
* I only need the -nut selector (I sent a v3 with -next selector
  removed)
* I keep the -nut branches (for testing on AB and during the review
  request period) as well as the -next branches (for the Pull request
  period)

Regards,

>
> Cheers,
>
> Richard


--=20
Yoann Congal
Smile ECS


