Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22AFD8FCA
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 15:11:31 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72230.1772118689872990041
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 07:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UOWMbQzE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b936505e7a0so69984966b.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772118688; x=1772723488; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVAU/NFUtHB5XMEE/ozzj4ggdVTTbZOegPJxvc6eeAI=;
        b=UOWMbQzESgFNMQiP3tUUWfXBNqpHWSoge2w+5gLTAYHXLEJzRMuR9pNDZQXK3Pk9UI
         Ac8iSugu8B3BpZcecYEO9dcqUAUemMqnJYikKrxYYOyGdxzvUB0TRIzOPuui10YVQKl7
         HqXSY4su7qLKIwQ/+CYmGQ7R+SXzKbJWlcj4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118688; x=1772723488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVAU/NFUtHB5XMEE/ozzj4ggdVTTbZOegPJxvc6eeAI=;
        b=tXFecX91g+0IJKSR1VVdDOsC/3o64dwNEpzBgx0dlHbMf1BUlB3rSJgmxdpzPf7EoE
         49/V+Sp0EsjZqIMtL7PSyi1mCPbJbEy7NL91C+FIT5OaTEZq6Bfb+rfsHCjprd3lLV9+
         h7AWOIHb8Ou2DyZEp5HSbqYhCVsnin4DvxVgQ3SzhodxOEE8NCcQL5hKoH7GbkvjQHbb
         HJJ0QojtvszpyrTcNNrrXetylfdSggROX5rqe4l9ZYV1BcJirDNSgVtmywN9y6W2Sa8F
         if49B9aP+FPiIsKecJlDWi/zXV+Se01zfUjb8B4gtggJSBSGnCulnJGWbZNuYE1zaJlY
         y/gw==
X-Gm-Message-State: AOJu0YwmH+psj1nIz8QhHdOFoInfmHC0maxoUiLMTzlC6SPX+/37AQVX
	poxuznOBPCliDiM4E1HwQM/2qUmx9ncrnHdrnwyL80bq6j27E8LfV3pTE53vDrT3cjVAeqUzyK0
	IJTnkfag=
X-Gm-Gg: ATEYQzytJMUee9etS6KcZTOEhMdFRuMTT6odyc3pbP6rINIoYkSI3zt/iOA2EpZesMS
	NwRwitu7PK0vBOpgtx1KXGz9ZSwuJGo8CKTAoNPsZ8QUu4oAYmRTa5+H8zr2j3f3rseJSeyqTnx
	YiEIJYI4tr33IhUdAB7AvRysoS+v9qTtuDDNtlnh/Ra6B9SeAXZhqiuOhs4hskacecgnTA0y60Y
	HqjBVQ82WE/R7wax+y5oY4REvd70p1jyZ1lLrRV8hPJcth61v7csj/F/6n0j6j+2OIB0+07oIN2
	vhV+aKJFP3jwSKs/CrBkj4Nz6l+t2IJuWTtkRC/x/wN0QnZv58DL1G8wZw02R0TD1QXxIBKqcKC
	nH0xNK9/GJg7saAjCRWx5RIEoAM1IZRywMEiNJd+kIJNo3kNDFckLvsUA5I4jXt6hIcYJb0YO9y
	CeByfAN732fxUId5XzY+MrEDrEYjnHPUanSnO1OVoY1uF4A+uNM++j2Hgskzhs8mbY2lDNXqLj5
	Elg1durIwZJQL4=
X-Received: by 2002:a17:907:9614:b0:b8e:7e21:133e with SMTP id a640c23a62f3a-b93572808ecmr180541066b.27.1772118687664;
        Thu, 26 Feb 2026 07:11:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6? ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae613ddsm65576266b.33.2026.02.26.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:26 -0800 (PST)
Message-ID: <433b819f2977f580713495429fab3cad59a5c430.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2] schedulers: Add
 stable -next/-nut builds to the branch selector
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 26 Feb 2026 15:11:25 +0000
In-Reply-To: <20260226144201.47577-1-yoann.congal@smile.fr>
References: <20260226144201.47577-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 15:11:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3290

On Thu, 2026-02-26 at 15:42 +0100, Yoann Congal via lists.yoctoproject.org =
wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> These build setups are frequently used for stable maintenance
> work. A shortcut is appreciated.
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> =C2=A0schedulers.py | 76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 75 insertions(+), 1 deletion(-)

Do we need both -next and -nut?

Cheers,

Richard

