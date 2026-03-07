Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E2FC9EE1
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 09:48:05 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6430.1772876882946370183
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 01:48:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IkAOi7hy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so4312065e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772876881; x=1773481681; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbMrQZ7IcpvpTeMxkkL81PSi9le0vvwq3HZY1V5pEDw=;
        b=IkAOi7hyoWvc/e8+7A7rs7zPIpGULU25QLiGXPFLrrPXIQVKqqMl324YV+Pu265Ixh
         4N/aoTVhvaHzLhr7EGehshnWRQWvbisM6P4IUQ3EICXpqMDMftA50bdQ7GpRaoun85YR
         2YEnNHdWFYRjFizMuL2QkQn2FZU3xedYD6Z+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772876881; x=1773481681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbMrQZ7IcpvpTeMxkkL81PSi9le0vvwq3HZY1V5pEDw=;
        b=CfNANWqlcXfE0vyabXKa+iUb0rFArYEFB/1OIVehJRfTM80natnmKc8ejRiMF1MHaP
         GLmrDw4RKyBXFbe9/4LqVf3Y7S40/kaCs5Ibp+3AgQW+7+3aGKM9bDM++D9ChGf4qFX1
         i5qIjba+DVdCrkQJOi+G69/61ZxOr1qoEZIxbOV0JgSStxSLkWMU+RfQi21Xrnx34tOY
         qSANEP94wrbPX0ovV8EZDlOAnRvd5exX584b4VaBFlTIVcWU70zR3Se07VW0aTa9+8wf
         nqk68Sszir3IhFswNInLOkRRN3tIDrsAYArGD0IMWtq/n6CyFXNYHfKuGmblLIvZs77n
         FWGA==
X-Gm-Message-State: AOJu0Yxz0AgftNuolgnm9Gi2cqi/5q+Cc3HMDaw4sSiHmaHr28BaFci1
	mHPou6U7Jq11lwSH18ZoDxmRrdLRMNGtXIaiKfJyub/sJWpFO5K+j1ZLFpwWsHrg/8xByNruhTK
	JRQNR1kk=
X-Gm-Gg: ATEYQzzM0RSWrlXwsXNCAaLcwLSEP4I+MXriABeQr57dr442bCWtfK5oGN8OP8aT/4W
	V+wp0lnXZG621wR/LxK4zDjc6rnUqkd06BBsdkKK1Y/mJbkhl+RqrtL9h8/5u4TYvTed6MMPG52
	9kH1F0/IGWP0dAh8W4sBZEdzK1dkGql0GTaVRJSxXjXfwrc7/FVI3DUFwoJYZR/JxquIgqtHFIH
	sUF/ArLGwFmNFxg25ysIFhRvXsE0n0oa0YIy13g9bc6tNyamlCeB6yeaYcgJLqOMAUzfTP2GAPn
	ceJUGzjUOiodCQOWff8HJ0H2uphGFiZ+dfHLT3Fct6CM/oX24RActRehXQShWfHIcbKZcygg7Lt
	RL2y4Btxx1do9T6TzP3+7JIMR81+3UB5aBEDoBbG6nwV6XHSKdMLJxUAhTf/0w+vrk4rDdh5jv5
	UBn1bpTi06dxK+qSRzPTh7QooxST5h9S2CsKpRmhJTnivU883OeWqGhXxIehszk6hTH1p/cWtFk
	iq3VyMvcnhr/Cs5iGE0Zh9KaQ==
X-Received: by 2002:a05:600c:3d90:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48526930a4fmr83530825e9.12.1772876880766;
        Sat, 07 Mar 2026 01:48:00 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d746:2cdc:e7ea:aa72? ([2001:8b0:aba:5f3c:d746:2cdc:e7ea:aa72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485244b6e9esm65643755e9.5.2026.03.07.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 01:48:00 -0800 (PST)
Message-ID: <47351a387272fa900c414ccc3a4857ce29a1744a.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo][PATCH] openat2: use const struct
 open_how
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 07 Mar 2026 09:47:59 +0000
In-Reply-To: <20260307090906.5609-1-martin.jansa@gmail.com>
References: <20260307090906.5609-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 09:48:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3364

On Sat, 2026-03-07 at 10:09 +0100, Martin Jansa via lists.yoctoproject.org =
wrote:
> From: Martin Jansa <martin.jansa@gmail.com>
>=20
> To match
> https://sourceware.org/cgit/glibc/commit/?id=3D0f0a5cd338998f4b603f52f3ce=
2163df0db7b814
>=20
> Otherwise it fails to build with glibc-2.43:
>=20
> In file included from pseudo_wrappers.c:300:
> pseudo_wrapfuncs.c: At top level:
> pseudo_wrapfuncs.c:11537:1: error: conflicting types for =E2=80=98openat2=
=E2=80=99; have =E2=80=98int(int,=C2=A0 const char *, struct open_how *, si=
ze_t)=E2=80=99 {aka =E2=80=98int(int,=C2=A0 const char *, struct open_how *=
, long unsigned int)=E2=80=99}
> 11537 | openat2(int dirfd, const char *path, struct open_how *how, size_t=
 size) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~
> In file included from /usr/include/bits/fcntl-linux.h:492,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/bits/fcntl.h:61,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/fcntl.h:35,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from pseudo_wrappers.c:23:
> /usr/include/bits/fcntl-linux-fortify.h:36:1: note: previous definition o=
f =E2=80=98openat2=E2=80=99 with type =E2=80=98int(int,=C2=A0 const char *,=
 const struct open_how *, long unsigned int)=E2=80=99
> =C2=A0=C2=A0 36 | openat2 (int __dfd, const char *__filename, const struc=
t open_how *__how,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~
> make: *** [Makefile:162: pseudo_wrappers.o] Error 1
>=20
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
> =C2=A0ports/linux/openat2/guts/openat2.c | 2 +-
> =C2=A0ports/linux/openat2/wrapfuncs.in=C2=A0=C2=A0 | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)

Thanks, I've merged this.

Cheers,

Richard

