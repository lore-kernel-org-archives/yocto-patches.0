Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B94E9A02D
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 18:00:28 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18320.1771351225536475042
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 10:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fx2IvpAQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3368599f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771351224; x=1771956024; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hnzzg664UX9KyunAsxFZYUMzoxA2GmsTyguYxhgB4/U=;
        b=fx2IvpAQePCh16bpr+i9ufGyN/Fy14NCswM9LAN9ZRAprBAvnhkbFWgqqh4rFagb3o
         4sSlr/NB+THYdWZrZDlDKmg5nSbosJmxL9UaTAvOLDg7a7f8QV9MccgYBNT1q3pXAE7P
         3bARHcU4Pqb3xVn14t+NVk1zknigx9LMHcx0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351224; x=1771956024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hnzzg664UX9KyunAsxFZYUMzoxA2GmsTyguYxhgB4/U=;
        b=a8FgskxxZnbLDAdE2zayEvzhbCB4j44mZBwf2CSGqal0OmDDZ4j7OOOorDxnfPXFAG
         i0dEqR3uKDuGg4iFZreqHyroBAb/d0Kap+Wb9+xrb+R4c+7f3F/LDvwbz+Q0rYVSXAH3
         UiixC2X8RWuKJG1jkBU2fKMjsKRcUBd1Bp5Asd4dPzGlpx1qZtl2Q5Y2bhScHeeXGfwL
         ISxdNskEIL19zI+bbF3qfy18fsVWwgNp/TL4+68Yl0nHhatKDyoBArZz/qpPXJv5CXo/
         /WTzZ3gRevgykUmo4x5ecCEn+jrl7vqn7CPL8JsM4v96dd+o2aCamxrAQOgjTqewK9k/
         49MA==
X-Forwarded-Encrypted: i=1; AJvYcCUK3Ceuy4Uw3XfUU1NOgQb+mSSjD3vJkTt4XL+QCSRoTyT090oayr4bpKFvIdDP/74uRCH4JpblXUP8GR6z@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzEfw+8EHi9CthIQBsC6EWZQOtJvntS6N07aFfYy5rmZ9JuBrZa
	3x8+N3ZJSGX4Od6LSa8DqRKM2n8GCph4+GKMGlkcuLhg9H2HdmRCIGM315cWo+io2R0=
X-Gm-Gg: AZuq6aIaKz8u6X3PbsUe5B4wITZ/2+/vFrOhEGLVgAzzEpgXWSnp17n0XRAPJC2qrgh
	u2TtrHCrxq+Y54n2bELufQM8SNdvbiDriLG4Rfc2INM27Tu7PGLYXvGpgq5SGOAcD0ntaHPnrRZ
	6WBZyeXbuPo9EpARlcB0n+oJOHY97bL59VkMHfSdOIVylNKbfcPmiRkx1LQsF6p2FqgEclYbrOm
	+pMAql260FtMkreRnY7JxkBhOyVPZ1+iN9Vg/em+KmDqO/GmTc1BbuwM0gX2rg8cvhIF81fqn9k
	MpwoaWyM8RGub5Jc7B/4FWU65ncWB+4lFMbdVQCA2cXvn2yUzRuEJe+ODx/sTlQWYExjzU1geMn
	9WpkuAWBHdA/AK3qKGdXcQvYOPMtwLURahC0zGpUAieTdwYngA81teQqeJfvRag8WzMrEqWhvX9
	fZ5gdox60OMpYe7EinVK4A4VP9MRn3x9YV/MTTOMvp6ThQxeuLPKAa5By1MFm/R4G4AYZs0kJAA
	LhwSIkTJ2Edb2I=
X-Received: by 2002:a05:6000:268a:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-43796ab1ee0mr27070533f8f.1.1771351223825;
        Tue, 17 Feb 2026 10:00:23 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f0dd:6d04:6647:fd3d? ([2001:8b0:aba:5f3c:f0dd:6d04:6647:fd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b4cdsm39268270f8f.8.2026.02.17.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:00:23 -0800 (PST)
Message-ID: <b85d670688dabc587ffa9447251ba88d6ca51235.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] ports/linux: define
 __NR_openat2 if missing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, 
	yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 17 Feb 2026 18:00:22 +0000
In-Reply-To: <586decc9-87e3-4403-8d60-28e7bdaa5c32@kernel.crashing.org>
References: <20260217154814.483670-1-yoann.congal@smile.fr>
	 <586decc9-87e3-4403-8d60-28e7bdaa5c32@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 18:00:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3253

On Tue, 2026-02-17 at 10:45 -0600, Mark Hatle wrote:
> I'm inclined to say if __NR_openat2 isn't defined we don't want to
> support openat2 at all in the _standard_ pseudo.=C2=A0 Since the system
> userspace is effectively disconnected from the kernel.
>=20
> Now, from the OE/YP point of view this is different, we want to build
> a system with support for openat2 (at least the intercept) even if
> the host system  doesn't support it.
>=20
> (I thought all of the 'modern' supported/not deprecated host systems
> were new enough that everyone had NR_openat2 defined in them.=C2=A0 I
> guess I was wrong.)
>=20
> Right now the reply is ENOSYS, so it shouldn't be any sort of issue
> just always enabling it.=C2=A0 But I'd really like to get openat2 enabled
> at some point, and if  we do it becomes very important that we only
> wrap it if it exists, otherwise we  need to wrap and call the syscall
> then look for ENOSYS and 'unwrap' any changes we've made...

I think if we have the wrapper, it will only trigger if something in
the system calls it and that is unlikely if the base system never had
it in the first place. If it is called, our wrapper should be
functional, so again, I can't see much bad happening.

It is possible with sstate that something could be compiled on a newer
system and calls it even if it isn't present on the older system too,
so we need to handle that case as well.

> So I'm tempted to suggest a few things:
>=20
> 1) If NR_openat2 is not defined, we disable openat2 in the upstream
> project.=C2=A0 YP then carries a patch that unconditionally defines the
> value.

Maybe. I'm not sure I want to do that but I'm not going to push really
hard. I would ask we don't do it with a patch but a configuration
option though. We're an important enough user of pseudo we should make
that configurable.

> 2) We optionally supply the NR_openat2 value (if undefined), but we
> add some  sort of configure switch to pseudo to activate this
> behavior.

That would be better IMO but again, I'm not sure we really do need to
make this configurable.

> 3) We say we always support openat2 due to the current ENOSYS
> behavior and just bake it into the future implementation that we need
> to handle this.=C2=A0 In this case the patch below (or one like it) is
> fine.

I'd probably lean more towards this overall.

> (A few notes below)

> > +/* On kernel <5.6, __NR_openat2 is not defined. Import the
> > definition from
> > + *
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> > + */
> > +#ifndef __NR_openat2
> > +#define __NR_openat2 437
>=20
> The value of 437 is arch specific.=C2=A0 I'm worried we need to expand
> this.
>=20
> alpha - 547
>=20
> (everyone else is 437)
>=20
> I seriously down anyone is going to use pseudo on an alpha platform,
> so maybe this isn't a real concern anymore.

I did check this before I took the patch and that it had the same value
on any of the platforms we're likely to run on (x86/arm, maybe riscv).

So I think we're ok for now and the plan looks ok. I do really not want
to need to patch pseudo at all though.

Cheers,

Richard



