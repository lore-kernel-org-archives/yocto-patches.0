Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1D2C0219C
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 11:06:31 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.67016.1738926386404486440
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Feb 2025 03:06:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SO4z057K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dd022ad96so19298f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Feb 2025 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738926385; x=1739531185; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XaKQkSZVvuNTLqtca61MG291Yl72pDSd9S6Jl3r9i1o=;
        b=SO4z057KGqHXXSELlTMbzK9H8m7KtTyb4Afgfpqg17q1qKUDCmQ/C2aXlf6I8VXsR1
         23T+GAQ3TJZUDt1VMxng4JIWUPANvLF83S2Asfw4u85MTtLeMoDlbM2cLNerVnRmhxzU
         at46Xvymvw2hQ0RYAZxZThIpBchh8MXI8B0JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926385; x=1739531185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaKQkSZVvuNTLqtca61MG291Yl72pDSd9S6Jl3r9i1o=;
        b=HINoCXMDCisEHEf155vWai+Gyva3czZhlEKAmijlMPOIMh21SLLpO13u6tYzZT3hIQ
         uOOTTOlP3vRHAR57k+Frt18Dr9ry1rHLWaWsWTSFMtcAfwzkEla3cE26KAV5V4B4m3cl
         sBCFI8N9WouXnE1k7tmrsOS4B+Z5aBT26QOb3eJwJsl3/PovDesjMaagLdayDLOb+b8f
         FBqFB8njYEE2JCbZkwTmbJ9IkcqQC3kgN2jevVtrDHC4suGKddmlqBBguMb01+YP1pKN
         tvBNCCLx34N3TF2QCprnpE0zhqmUKTVJTFc6t0Dmqmc5F/kHcKxdFb3z3SHY9/5vEZyL
         irNw==
X-Forwarded-Encrypted: i=1; AJvYcCWbo3UZWbpvKnFN082ukq6r25EBDU1dJFKFDC4VEl79D2G5xcWasHqNvkQMZMpLV5hcsnGV3dTrSyXp2x7G@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxoEAvR4GuqwBhbGbF/KeMrOqlPYt6hY0W4kcvVkpKwLBXBdO0h
	CEw9+UniAIcSpwZwf5/LJwHZPO5LQpAqawDThu0mPh08p+BBsiYGaFp8x7B6keo=
X-Gm-Gg: ASbGncvTftLf8cZmA28MGJMO5vV/ODi2G4QdMYFVPAesTkyW3cJS6RHDRqVGRJrph+/
	qRNxvCZIRIr+kec5ORvtgMOOxWG67HAXpRehcNzO8X+Z7sdnWqp5cjs8o+6ahpigfDPDpv4Ee6K
	6nlru3WEKuT+J4CClbAolx+JhbP8cBAGkf/P91HCGgKa8rXG3/argHKq9r+uQO4MIw47LsFLfhn
	Zxi5EhddmPPMQwjwyBbHifexpdnXxzlhL73ksomDwljZ2o8Qp+ieTK5N6FVi+BxX8ubSWeL03aO
	P6fSuYx+LqYKkcl+d/JkLXYh1stMbkjp3E025QAs5jEZOtxkrL68W0n0a/Jep04mH0OZL4rJMI5
	zOPo+
X-Google-Smtp-Source: AGHT+IG2y/V2QJrkHsXX+4BqptCzXnwK4hkAU0SxFg75ua/Vs1D3I7By4+5NB/X0WtMGDZhVG7w9dQ==
X-Received: by 2002:a5d:648b:0:b0:38d:ca76:9e68 with SMTP id ffacd0b85a97d-38dca76a05dmr1212964f8f.49.1738926384714;
        Fri, 07 Feb 2025 03:06:24 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:dcae:28d1:c97a:4196? ([2001:8b0:aba:5f3c:dcae:28d1:c97a:4196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fd3csm4225212f8f.62.2025.02.07.03.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:06:24 -0800 (PST)
Message-ID: <fd039928464fe4856890f0dad170ed60ad32d42b.camel@linuxfoundation.org>
Subject: Re: [yocto-autobuilder2][PATCH v2] Fix overriding of the
 yocto-autobuilder-helper parameters
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 07 Feb 2025 11:06:23 +0000
In-Reply-To: <D7DJZHCOLHSJ.XL65V59UKWG1@bootlin.com>
References: <20250122-fix-autobuilder-dep-v2-1-84e8c0f623e5@bootlin.com>
	 <D7DJZHCOLHSJ.XL65V59UKWG1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Feb 2025 11:06:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1048

On Tue, 2025-01-28 at 09:12 +0100, Antonin Godard wrote:
> On Wed Jan 22, 2025 at 9:41 AM CET, Antonin Godard wrote:
> [...]
> > diff --git a/schedulers.py b/schedulers.py
> > index
> > e4760ed8bf1d02f4edca9af87725cf116630a14b..cb4ac2b6c8042e03899551bb4
> > 2e1ff7e72824717 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -399,7 +399,7 @@ for builder in config.subbuilders:
> > =C2=A0=C2=A0=C2=A0=C2=A0 schedulers.append(sched.ForceScheduler(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=3Dbuilder,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 builderNames=3D[builde=
r],
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codebases=3D[util.CodebaseP=
arameter(codebase=3D'',
> > label=3D"yocto-autobuilder-helper:", project=3DNone)],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codebases=3D[util.CodebaseP=
arameter(codebase=3D'',
> > project=3DNone)],
>=20
> Come to think of it, I think the label could also be something like
> "Default
> parameters:" to clearly explain what it is.

For the archives, adding this results in two helper config boxes in the
form which is confusing. We've backed this out again for now until we
better work out what we should be doing.

Cheers,

Richard

