Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB75CCD1A5
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 21:45:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.4313.1760996732834811402
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 14:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H/LOfg8S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso43634975e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760996731; x=1761601531; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClCpbY+UeB6GNlRI9C5+L7NgnKECziq6A0SOxcODv5Q=;
        b=H/LOfg8SEiLpc/nliheaZRe3BubN0bWAjJ9oRDk3sL5QYG3jA3BElUKwcvxgp2Asuo
         QVpA8BIR+Jpp0lfI/yDKKu0uUUyTi8qIq+cUEqEzfZvIQDPp60ZDwNtzY8hfiaC+CCDP
         bLa2YOPPd4AexnjX+oNfZFa3jwasnwGs//HFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996731; x=1761601531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClCpbY+UeB6GNlRI9C5+L7NgnKECziq6A0SOxcODv5Q=;
        b=DABd0b/W8GFxKDe8HgbMzZAFSpDLsxcx0hTe/LPtyRTWy3yJMb7EWm6rK+iZCbrV48
         o4wO5MtdUfM6DGsaW6uRYm+JRiwOWvioCnpMxG/yR25y9lpV+dE0t+XTPEOx5nex5mNt
         vMJlEGuWtgOt+l4hPlx6ktYMaMXL4bXnBiWOZtG+28OEBRP7WCUEn/ZyCLcSI96R8FQl
         fvVyJFrp1j/3srPYWllKsMJnsQWNz6eb27mbVRVkFin/UqGlTSWoNvu/SuLybjWoXinQ
         lzEXFjnPifFG9ViEnDcAjCuTxkBUH/yooA3PvP/LVYWkgwDZtLFhBDk0x+mOKAmN3nW2
         ui3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOsd3lSJvo7KKoqYG56BYXt80sAPH9e/YnrO2w8CSF80VwCWuTf44qFXNWKXbcKPW2JNnK44FnY2tWdSnz@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzT6KF0JiI6wrgvDmI07AcJGdh/elB3Asbp/0O5dHx/z+2SB6GK
	gPLzTDHrkFrSEQqDhj2hOEhP4Rl53guqhxW1pMJMu+FWg+W/vZHGQh/opyH9Kwtm96Q=
X-Gm-Gg: ASbGncuXsWTaxZGqQuNU0lezBuw4DE7+vpyGlZU2g7HUrfkK4k4E6ReqjK4A/wvQeMC
	CaO7/jUCznFQwg7pTUJS0+jv35I/cNa+4VFJa7EhludfMBGIa6Rsmffx/o3SxIclyIat3NylGb3
	Bw7nJcmm82SNaaKd2jyEKuNhmEgGHeCWbjRt5QzrJB/kJ7fePPSytWvbv5Lv0fDisPd7PjBeq9E
	DmIE0J+zV4qL1XBks98k8MNftfn4AR8DhjUAizquLIByCdbODEZZp4XBK02P8/Tz8BbH69pItp1
	JONh4VoJmUvwdW8UabWbFCI1AL7OUSoX/Zs0NpDEOP+f6EKKM3JEXmlFhJqwwVfELc4dXglfI8M
	lP44XoKRnvvbQSkKXO3fHkYHI8PzPG1NKscWSNsa1sqgNQWB2hfDT31WtpMuwpFN2TvDHUXHyks
	ObIlHheEVf8dsIbD2mVk8RfTBpSM4chKrjNfYxM2/4gU323nZ29mLua7pzzlcea6wo2D17MxU=
X-Google-Smtp-Source: AGHT+IGR9sTD3WdGdk+K4tlM1KvSJLg+gbZXR21HfUUk0YwrTzBfovfT9deGi2+7cQO2ZgbhzZGIqg==
X-Received: by 2002:a05:6000:1849:b0:427:809:eff0 with SMTP id ffacd0b85a97d-4270809f26cmr9764068f8f.36.1760996731082;
        Mon, 20 Oct 2025 14:45:31 -0700 (PDT)
Received: from ?IPv6:2a0a:ef40:d13:301:bf3d:a1e1:4d2:ab0c? ([2a0a:ef40:d13:301:bf3d:a1e1:4d2:ab0c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d23237sm2047275e9.10.2025.10.20.14.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:45:30 -0700 (PDT)
Message-ID: <f886c5f7bdb8b672010393dc4600b83de313fd51.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json/scripts: Switch to use bitbake-setup
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Date: Mon, 20 Oct 2025 22:45:27 +0100
In-Reply-To: <CANNYZj-KXPZ0dOLoHTuVmnZoXtKy0eJ0Rgk8qmm5_FFWfFVcCA@mail.gmail.com>
References: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
	 <CANNYZj-KXPZ0dOLoHTuVmnZoXtKy0eJ0Rgk8qmm5_FFWfFVcCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 21:45:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2369

On Mon, 2025-10-20 at 13:50 +0200, Alexander Kanavin wrote:
> On Tue, 14 Oct 2025 at 12:23, Richard Purdie via
> lists.yoctoproject.org
> <richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "EX=
TRA_IMAGE_FEATURES ?=3D 'allow-empty-password empty-
> > root-password allow-root-login'"
>=20
> This should be in its own fragment, and testimage class should check
> that the features are in place, and print something helpful when
> they're not. Probably the poky login banner should mention the
> fragment too, so that people aren't baffled when they expect behavior
> from the old poky default template, and typing root without password
> isn't working.
>=20
> I'll come up with a patchset. :)

I'm not 100% convinced that is the right solution.

a) We've wanted these things explicitly spelt out so the users clearly
see "allow root login" for example, not hidden behind some "enable
testing" fragment. This was why we removed "debug-tweaks" and I don't
really want it to get hidden again for something this serious.

b) perhaps some of the testing should configure the images with a
testing key and /or set a root password? It might not work for
testimage but it could for oe-selftest for example. Even for testimage,
we might want a "qemu" key? A local one could work, just a question of
project release image testing artefacts and how to handle those.

Cheers,

Richard

