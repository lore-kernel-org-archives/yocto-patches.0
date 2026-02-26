Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C8FD8FC9
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 15:20:21 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72285.1772119220278575795
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 07:20:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GxA3syCi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483bd7354efso13016515e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772119219; x=1772724019; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtnBFs48fPEYb+f+qRU/6uUVnERA552t8DlMFvCADyU=;
        b=GxA3syCiXgbwcukcTLwhXJaEkyL/oinpsqD1JJe/jc5neCfSsG7Kskzxp5SvkyazLR
         A5/gqnpuB13alJDINQFf2cMykwmmAIiq5w0vIwR8V7+vC5WmHxq32HlGbNaMSXNKzif5
         V8W43kfgPEKfx9TSeu9slZOPC7PZx34uYlHec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119219; x=1772724019;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtnBFs48fPEYb+f+qRU/6uUVnERA552t8DlMFvCADyU=;
        b=I19kHCVHUY4bA++zGFZXI3UNCwhxgMV7NqDkU39i0HIOi/pZKskrL+bcoaQUtYuVmX
         aa/sMqbF1DvqWAxTYVx03JUorfw4zgh41QQMdxxWaBumMGVHNDwy64tGNivLSk0C5onI
         iEeTqU1oPRee27yUMrUSdf9AB/Sj1um4+M6q+v6FmmT2aBVyk88v/DrrlanbuTnKDtt1
         kYisvjT5G6Stb9nZDMymWde/K/gEwtz+my9VOJtlOS+NB0Lq9XWtGEGpKF8bz6GQDVex
         VuF+OVKzcOJR31Y1FEQmciuivXi4/covPFLlfpeKrZBKB3Q1y1rf4GIIiWs0UHzvcLSW
         k5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJl/OhISAsZeT9/V4xHDY8aSn7RKTB3agiEj7tB7cuGXiz97bGg3X1Hwrw3qX7nhAwkUlUs/xJmSwc0T3@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yy8bMmh095L6vMHSo3Ut2NlIIoDLZt05O/tU9hgytJnjTMATpIf
	JRgvYoId2RmnzjdPiGQhZrjV+76Fe3MPtJOkU2A7YZFAOEzr4+n5unKUoe3CMpPc+Zk=
X-Gm-Gg: ATEYQzws+ZLFc7/bw5Q6JT7zx0QM/nIN5PkyoPk6CF8/XBK8IZzUROzQNvaeOJEzdcA
	NC/qQ+lQmlps8E2D1dQPBFtEiYaU8JessS4gfPdyXAdWOpzqUNiIVAhpin9yKzd40KdGWqX0xT9
	DSL61laVx/u/x17MajqtYtmAec/cMv2RzP6eVHTRamUaxUub94AFzZJPSh48WeHntR22BiZi4O7
	L941T8iPViK4wAJVO51JdH5z9VabMcqZ63DfFHRqy3qRBwtCNExYsJfWk64QaOqEaivr9BwQLJF
	7DI6kQlikgkLzP7iZpxtFs4fZZkM1qwmznK3JksQe0KKFKAX3O8jlv5fs7HBCKVfyU71riQDrSd
	XtURm3K02B3Vm9k71L9l9Crecj/PRnabqKP3AmqYrQhxoY/A6l09wqmQCqgEd3nRfCMEGPJF9Tx
	a9MC6ID8YO/11n1g+IQ7DqlyI7b0DAVvG24ejkPd8+X/vYb6x78LOFphv3kdSKxkOjMWsw+8l0g
	584SaUXrPwSOnI=
X-Received: by 2002:a05:600c:a11:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-483c217cba0mr82285425e9.15.1772119218462;
        Thu, 26 Feb 2026 07:20:18 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6? ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776b0sm40143445e9.1.2026.02.26.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:20:17 -0800 (PST)
Message-ID: <2caa358b916e7cc6e76b3f51d4ec2dda6e9b95bd.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2] schedulers: Add
 stable -next/-nut builds to the branch selector
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org
Date: Thu, 26 Feb 2026 15:20:16 +0000
In-Reply-To: <DGOZSACRJBVH.18WU5AD0T6D8@smile.fr>
References: <20260226144201.47577-1-yoann.congal@smile.fr>
	 <433b819f2977f580713495429fab3cad59a5c430.camel@linuxfoundation.org>
	 <DGOZSACRJBVH.18WU5AD0T6D8@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 15:20:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3292

On Thu, 2026-02-26 at 16:17 +0100, Yoann Congal wrote:
> On Thu Feb 26, 2026 at 4:11 PM CET, Richard Purdie wrote:
> > On Thu, 2026-02-26 at 15:42 +0100, Yoann Congal via
> > lists.yoctoproject.org wrote:
> > > From: Yoann Congal <yoann.congal@smile.fr>
> > >=20
> > > These build setups are frequently used for stable maintenance
> > > work. A shortcut is appreciated.
> > >=20
> > > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > > ---
> > > =C2=A0schedulers.py | 76
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > =C2=A01 file changed, 75 insertions(+), 1 deletion(-)
> >=20
> > Do we need both -next and -nut?
>=20
> It depends on what you want to see in my pull requests for stable
> branches. If you find a -nut AB build convincing enough, -nut is
> enough
> and I don't need -next.
>=20
> I will send a v3 without -next.

There isn't any point in me duplicating your builds!

I did wonder if it would be clearer if you just use the -next
namespace, as long as it is in the contrib repos? "nut" is a bit
convoluted. The only reason we have the differences was to differ
between my builds and those of Mathieu, Ross or others.

Cheers,

Richard

