Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57A6F43684
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 09:00:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40677.1776416419755138434
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Apr 2026 02:00:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JNPZ00tq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eada6d900so401233f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Apr 2026 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776416417; x=1777021217; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WT2sslmjx4t57LDWykZkCgArmtoADXpj5BRNUPgqBK0=;
        b=JNPZ00tqgMCg7aVfacjOZGjROSLbXkwy7ZMwm3LTVb5DqWRN28VZJK3jCbXZ8c8eFa
         8TijZmklJY41Dfl7pIbjakbCVRC3SyL2PnlXfvhFN1p9uZ4EeIOEMaREEHg39zKgfTVw
         GSnrq4S346IdaCYSK7mIiSb5ShmRNnCSMvnc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416417; x=1777021217;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT2sslmjx4t57LDWykZkCgArmtoADXpj5BRNUPgqBK0=;
        b=R9Z3q0TKu1NfnW0ev+/aeRgFWwsUtny3CmAEJID+xwC44DTrP3voakf2WUtMX1C9+g
         LHRXKa5vcx7A0rwWIdVsZ0XLKfKZlzMcBLm1Cp4a5mqcrSCS3nSh4pLYqwj2LBz3f25f
         omjyyRc2xk6ppuX0vGvoyX0lRbCQ03OeTYe/t80Xb6947tN0VDTZ0cQ6+4Z7plX2oCvn
         JrixMipfVA5SJ2FuknrateOr4K7ndfj1CDYbvnXKpQ6KDQtgi4gyeOXLvQlOU2KCKXE4
         YjcGXuFEpW/ViQfuIlbZs3aj7+q1PqCM7ucrNaG83DUR27+EZ02+RF98iL0BNIVXRV8M
         bSJg==
X-Gm-Message-State: AOJu0YyjvG61zZFgVxkTYp3k9OjzjFe8jDTNylDbfEh1h95AxrRkFxgN
	ZYHzIh+utj/e+T3b+zcaWiq9ZnQAdh7libfqGtniq52/Sh1R3VfStQIoOdewfYRybxJm+EWeSWh
	qbzoZrws=
X-Gm-Gg: AeBDies621hyBuWBfiy5I9K2+2JIPdnxGCuixUsNwkzXPTLREYcohZ3sQsByZ214T1o
	pNJFJsfPFJ6KJMw2d1xLWGnixjJfI4Yk9I4CS9PZwnJi1zVnw1eR5Rc4mNvZYkxa2ld2FOAKSdr
	243a+1Bee/dCU86BpIZSUVrwmUKX8mC9jW/C6WvsiKHIlfEdB0nbRdw69Eqe5gmDETa9hF8wSTx
	3c6wrOcpzEYvBb2/F2VP3F4bH9R1GJO7vnAHD3/Ngww+z7/GcLOz6Umele9eXuTL6R9dJ2NZ1Zf
	FDf84vA7HePyVyJs9pv0TaVttlTcsjRIhVZjvKLdQqqvqAoF+v7rq2GBa6GrMQX0pKOJylhUWbI
	mV19AHlydSJvS3mRURAOW9QVkmPWR/dAi1cDuzfTZE8bnShLa+RFGzVvjcmO3vglLgxC0t0f5RA
	pvs7dHVztvbuaKh49mHW5X0rTHfDRh1d9eU1uTshUpkjo18LzD886AL28qi5AhvgTyWwu02ECRH
	PSc/V4ZWBVdc0aJeToV4R+deIM=
X-Received: by 2002:a05:6000:2508:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-43fe3e14ecbmr2709998f8f.40.1776416417369;
        Fri, 17 Apr 2026 02:00:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d1f3:409a:3cf5:1213? ([2001:8b0:aba:5f3c:d1f3:409a:3cf5:1213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm2922396f8f.25.2026.04.17.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:00:16 -0700 (PDT)
Message-ID: <7fe5f6f964889ffc37d62cc0d2fb734dc53c6434.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][RFC] master.cfg: Replace
 pkg_resources with importlib.metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Date: Fri, 17 Apr 2026 10:00:16 +0100
In-Reply-To: <20260417013758.91120-2-tim.orling@konsulko.com>
References: <20260417013758.91120-2-tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Apr 2026 09:00:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3727

On Thu, 2026-04-16 at 18:37 -0700, Tim Orling via lists.yoctoproject.org wr=
ote:
> pkg_resources (from setuptools) is deprecated. Replace the fake
> Distribution/EntryPoint/working_set manipulation with
> importlib.metadata equivalents:
>=20
> - Intercept importlib.metadata.version() for the local plugin, since
> =C2=A0 buildbot's Application() calls it at import time before the plugin
> =C2=A0 is registered.
> - Use importlib.metadata.EntryPoint directly instead of the old
> =C2=A0 pkg_resources.EntryPoint.parse() plus fake Distribution approach.
> - Remove the now-unused os import.
>=20
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
> This has been working for me on my local AB cluster, where the
> controller is running on a Debian 13 AMD Ryzen system.

Nice!

I think Michael gave up on the local install and is building/running
things a bit differently. I did find this approach handy for local
development and did try and get it working again but failed and
couldn't spend more time on it.

I'm happy to merge this and replace what is there as it has to be an
improvement, thanks!

Cheers,

Richard

