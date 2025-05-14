Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB9DC3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 10:00:29 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.98897.1747216822369739695
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 03:00:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VOtGvFdB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b933f214so3152513f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747216820; x=1747821620; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LioAyO2bN3OzHCI+HTeMaH7aO1e7VlGyo/DXF7D1DB4=;
        b=VOtGvFdBDBLkT7UbDle1S2p1JWeQJwoRfB6VH382rsaoa9HeDIr1oIKWNyRVO3cBUU
         XTXZBSl0/skNfeNyRnoVZDwwMMBbz0xftIzqgq2woP/D5/nXBOdmnM2u12tZCr67UIav
         QytqKhMLVPyfY9KjdFpEvc8xEqWI0nAtuNTKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747216820; x=1747821620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LioAyO2bN3OzHCI+HTeMaH7aO1e7VlGyo/DXF7D1DB4=;
        b=W1rALw4k1JYm/DHVgQOYaNiY0Jn1/E+O2AnrFG7Sj8flS7NHGQLU3/KaPrr0rYn2un
         kvVvNPpH2KTKWdFsL2QTpKanfYYyakpWwPKb5Pn4OlqCXGJhBWSqflzJmTL1xkG8y+gG
         lDXq2nSQxGzce9yWpILov/mJYGruRENwQhm0fYEgnN2eWyJhexJpJ9xjZrCqxR84bxO+
         ONgnH8bQAnhHNQu7pA+uR8pdU9kiiO6523iT6S+6AGeI2QwBoAH49eUcoTuo3DIageSs
         GM5ZZ+pPF0rjHArQiQHcav1qp14aXBxZXX4Y+gqtcS/NhMYjYGsvgLPuGlXJDN8wzAHS
         wbvA==
X-Gm-Message-State: AOJu0Yx5CP4Wrm/mTCD3bK9MCjiBT1fc7nA52GO25tqLl3PTvJyCJ6aE
	52pex73Zlm3D364cj9FXe4uj2DIGkPJwGXp5xVVk8m8xY8flumK5gwM5KveJ/DrtvJXTPxRJCjh
	B
X-Gm-Gg: ASbGncsecuOGqwXIecJ9kyY3nWrhDQA54n7CCrpEUykX5wT9UFVgg+zCqo6IsEbi4K4
	ocXJqIYHLxZzxb7Uygbjw7+6VoSF30Xh5iOWm3XII58sOpROYP63dlXYfvmlGnhrGLJ2A+nd8U/
	s5TVbUX+rAoJGY0VQ8A0vkgzkTk2bk6ySU6GLcOvq+Hu99Yhi1P616Y1gVRQIcgTvpLVCtim8KT
	FS7uYfKsfv9m2dZ3/4lF9rrpZCs5z/TNw+gcQgptrjfIADsvc4+YJrXIK3JOKFiC8iqp0Ni6CJ/
	RAiL2e9UsGiR0wQa1JLaI1hCTCfFv2UFIhzZxB5hc7U2tzqZtvaNOIkJ21wvqDXP6014o978ONT
	JEtU0isRQByFQ8JfvLNIyA7Gw5S2JxRcLcB1aLwcX
X-Google-Smtp-Source: AGHT+IG+5zEi1UWV+SyQC1jNC/chKkeYHTitI7IJFF1S60+46mI+zm/L/GCYsZH1Moo5GJezLZeCTQ==
X-Received: by 2002:a05:6000:1acf:b0:3a1:f653:85dc with SMTP id ffacd0b85a97d-3a349952f09mr2301443f8f.58.1747216819776;
        Wed, 14 May 2025 03:00:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34? ([2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde1asm18994780f8f.8.2025.05.14.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:00:18 -0700 (PDT)
Message-ID: <e4eb1e2b57f9d954d17a7c43252f7be7998d172e.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] schedulers: add
 meta-webosose scheduled build for scarthgap
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: martin.jansa@gmail.com, Hieu Van Nguyen <hieu2.nguyen@lge.com>
Date: Wed, 14 May 2025 11:00:17 +0100
In-Reply-To: <20250429021622.309740-1-hieu2.nguyen@lge.com>
References: <20250429021622.309740-1-hieu2.nguyen@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 10:00:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1552

On Tue, 2025-04-29 at 11:16 +0900, Hieu Van Nguyen via lists.yoctoproject.o=
rg wrote:
> From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
>=20
> Support to build meta-webosose for both of kirkstone and scarthgap
> branches.
>=20
> Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> ---
> =C2=A0schedulers.py | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/schedulers.py b/schedulers.py
> index fd2cad6..1fead60 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -642,7 +642,10 @@ schedulers.append(sched.AnyBranchScheduler(name=3D"b=
itbake-docs-changed",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
properties=3Drepos_dict_for_scheduler("docs"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
builderNames=3D["docs"]))
> =C2=A0
> -# Run meta-webosose for kirkstone once a week on weekends (2am on Friday=
)
> +# Run meta-webosose for kirkstone and scarthgap once a week on weekends =
(2am on Friday)
> =C2=A0schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', bra=
nch=3D'kirkstone', properties=3Dparent_default_props('meta-webosose', 'kirk=
stone'),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codebases =3D {'' : {'branch'=
 : 'kirkstone'}},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 builderNames=3D['meta-webosos=
e'], hour=3D2, minute=3D0, dayOfWeek=3D4))
> +schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=
=3D'scarthgap', properties=3Dparent_default_props('meta-webosose', 'scarthg=
ap'),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codebases =3D {'' : {'branch' : 'sc=
arthgap'}},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 builderNames=3D['meta-webosose'], h=
our=3D2, minute=3D0, dayOfWeek=3D4))

The patch breaks things since it has two schedulers with the same name.
I've tweaked the patch to fix that and applied it, sorry about the
delay.

Cheers,

Richard

