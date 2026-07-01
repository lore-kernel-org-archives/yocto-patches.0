Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A31C43327
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 16:47:08 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49811.1782924426860089161
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 09:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LN9o+gly;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493be1b9682so6651095e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782924425; x=1783529225; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKMmKDByDiQvPT5l4Sl82cSozAB3i2lxgMFCKL1so/w=;
        b=LN9o+glyJA7SoVx+yoTDjpQGc48n7Qp7NXTF0x5dt6V3kePlDEBmaYn2O6zAf0NK8q
         NxRwynMllOD7xRp/cqZMcIFtBmSKFNeP0R5Jk2GVktfPp7vfpSq40oOZasY/Gp/fy8kg
         uXDJ7mdp7myXN2wBzasNH2DVgsawSC501shtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924425; x=1783529225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKMmKDByDiQvPT5l4Sl82cSozAB3i2lxgMFCKL1so/w=;
        b=mgvbctur8PHK0LeKMowYdrgEK8D+hg+zCSv6ybY7DpW8QkLTbCaiVOOTkjO6HIiEYV
         x8nYcn9ay4OAOr+yWypSKF7OKf7D+8Ji1tWnqG8JowCgztvkqhpoy2uPROj2PffdPOAM
         9OfhnQC2YWglQGNZZzULOC04i0WVg3lZJCtfzx0kKWom3uWttMMQr8TwCmbnbIZ1stoo
         XIWpcI+vy03lwlOuU0cDLOhjBFGgqMD1HthEe1T6rW1laRn+G90FoxyNEkkqkRnanfLt
         6HotK5TIiSpD13w6/XUkogM0sAZTHr4uJ1t730GFkGP9asR5fQ9JlrP7wDMv7CGgRbCm
         YaTA==
X-Forwarded-Encrypted: i=1; AFNElJ85mV2vsH/wgCS6XVQENwLsYsfL0q0byCpeWjCx/9TFnXds7A2JeGLnvHZXeEfqOZIH18ZKnX2nwnizsylw@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwEz7FVcEqhgH8A7KFar3HKcKCWZwQrnPfuMJ4/D3z577ejFjya
	3hylcU218e0Cq7wHENNr5kijIEAKZ9Qz50cRFQh42Lc9v7fsuJdfJnpEA2x361Uaxcs=
X-Gm-Gg: AfdE7cmAJjQAJUhCvAWwULB93LKr805vd5xY2JoJgsY7heXYDP4mL7ibbK35Ob9hQBa
	KBN/h2DlxjgsYojMDHF1NI61Zy34LNwxEh3sMxjq+1/8bZ0LZOiwZ51xQEEJg8Ai88e7/KCqXOu
	hmt2mdV5rFQQvGrE1NrC8GWxg+EUcjNJlbxX6EEzqzmvkTjD2QdowPe01RYHRlofx0o02vUKVM4
	Gdij/w4kGGV8ypQ3sYfS6teibX2PYO1lyOMSY+WSO2BQktV/JU0+vmrG4ceU9gtj9OUOxB9STfz
	8l7tIUatx47rOzLpCoTL1XFzS446KSvta4pvGBI9fYUPviovKHioGPnUKgxCd5vDWSKoV3YQxZF
	zKp6JUJy2N+4t7pFynXCVIRWtWCgJsVOSUQGyEFLclJSiUfPCysWZPBdaF0PEIsas+qCejOy1mn
	Pb1TdYdcLmLSrZj750bhv84CCuGgjuIzKglSjL6IbO0tLydvq74iVbKgkdJHIMT5NSsupBHqnei
	ShUHQ==
X-Received: by 2002:a05:600c:530d:b0:493:c478:8744 with SMTP id 5b1f17b1804b1-493c478875bmr8475845e9.18.1782924425000;
        Wed, 01 Jul 2026 09:47:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032? ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfd47sm121693235e9.2.2026.07.01.09.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:47:04 -0700 (PDT)
Message-ID: <340bdc220ec5eff7e0542e825ddde89ce451531f.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH 1/7] pseudo.h: Avoid accessing unallocated
 memory
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, 
	yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
Date: Wed, 01 Jul 2026 17:47:03 +0100
In-Reply-To: <1a6863b7-b95f-4330-913d-8230827212a9@kernel.crashing.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
	 <1a6863b7-b95f-4330-913d-8230827212a9@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 16:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4351

On Wed, 2026-07-01 at 11:40 -0500, Mark Hatle wrote:
> On 7/1/26 8:13 AM, Richard Purdie wrote:
> > We can call STARTSWITH in cases where the item being searched for is lo=
nger
> > than the string itself. Switch from memcmp to strncmp to avoid accessin=
g
> > unassigned memory.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0 pseudo.h | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/pseudo.h b/pseudo.h
> > index b6c13f2..1152c19 100644
> > --- a/pseudo.h
> > +++ b/pseudo.h
> > @@ -99,7 +99,7 @@ extern char *pseudo_version;
> > =C2=A0=C2=A0 #define PSEUDO_LIBDIR "lib"
> > =C2=A0 #endif
> > =C2=A0=20
> > -#define STARTSWITH(x, y) (!memcmp((x), (y), sizeof(y) - 1))
> > +#define STARTSWITH(x, y) (strncmp(y, x, strlen(y)) =3D=3D 0)
>=20
> I've not looked at the users of STARTSWITH.=C2=A0 If they are all strings=
 this is=20
> fine.=C2=A0 I believe memcmp was originally used because it could be item=
s with nulls=20
> in it.=C2=A0 The bug may be that 'sizeof' was not calculated properly (sp=
ecifically=20
> checking both X and Y, only y.. which can lead that the issue.)

It is only used by pseudo_util.c against envp:

pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) {
pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) {
pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_PATH "=3D")) {
pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) continue;
pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_PATH "=3D")) continue;

i.e. always on strings.

The bug is that y can be longer than x and the memcmp check doesn't
check for that. I could have put more logic in there but we may as well
just use strncmp.

Cheers,

Richard

