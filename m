Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBCC43602
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 06:24:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63290.1782973429542965834
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 23:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CTdSlkGu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so4450375e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782973428; x=1783578228; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ackIL+J9kKWqiMuEQQWFZ7FqmLtD6lXD/Y4S9rcS/QQ=;
        b=CTdSlkGugg/RRUPNQTBc7d4RNiTSlrZuhzloEk0fkF10WeZXemsLjg5zfCEtvlAe57
         uIvAQOSfN9DEBddeZWdiQ+jhFmofFbmySA4aC9EPRytCZ9bOE4qF52XfgvA9aXsGEqb1
         xLFlg9e2WD30s5NKpb+wclQGNKX6JTH+POdt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782973428; x=1783578228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ackIL+J9kKWqiMuEQQWFZ7FqmLtD6lXD/Y4S9rcS/QQ=;
        b=YYMk9+TZIVg4kraCbyaAN5IGdpvsKku9F49bgyiOfKgRLp1KfHrvbUHtxbq9PhUo50
         +YukT1AkDgPpQKlcf9b3/esp4fxuRfXQ+ZRv3pQX1ViMQkmd0hIQeFm6IA46IZLbaB1t
         641A0CDoG+Hb7eQ+NT9ywA05zmPP1XHe7ik5NEh2RBfYPFnQ1gnll2faROwDBpSvaC3B
         3Ba+92uijYvJDMxB1zbhs8baKQQObCv00Ath2o1Srag5a1gDdkgw8Q1gtB7uVYuICu8U
         n6EnmTOIIVLc2lv9aJojoLO9S2VILRbYtVPP1YcRG3fsE5bGbrAnnl1QwAOAUilEy4g2
         PjCQ==
X-Gm-Message-State: AOJu0Yy0FJD+lkrVv0HELSg5qJbHtJEwpcRlAgJYJtzFvrdHJfhlJ7Yr
	QTS8z/x4KUjUMj0DFw6JOaYIS00hI016svlpWxsJnmTcgsVIw1zENRAn41AQtNH5J32p42bfGEQ
	cjaEb
X-Gm-Gg: AfdE7ckj2e6Km/rYJUcV9q8tAQ1lLpsdxOaPR2vpBhn1e9t1Gyjj9DiHFvLJIoTon8k
	lmX/umny96Qfki60aqLSw6ql+4g4WJJF713the4UlF5jPch5cmiV6LTOzbWSqCWFanOhIb1sH1b
	xcx30Av0UFKaMXgCGAESJT1kKyYv6JIlBVWzW4Xnt4FG/ePwW5z2K+1N8j8LgeM6PUALa1X4FzN
	Dg9G6VrXGLsX+wCO33xEDkKRnWAKSHolKyZ9/qgSIbO1j0i7wSPMc5p8HYEselCMlZvjJJLvTJA
	doko1NGfWGhikic5/aA7bLI77ZUGEONd3GalGKzVbPUDBug0edXIEpRu0NCLAJGrnmas3WL/Wie
	X6//L4tu4L029T69e8Ilhkt+zsuHiuyS/oWyNX1nzq7LfExijtsB3oFYDPJgPClUGioRUIAKG3K
	W68jgbS+ieULW4ukHmBiXP5ZUQ3XgG9SSsBdxiLyLB/DyeeYVHbq1Yfk5u1zJoW0AKOsO/Lxj2c
	tQ=
X-Received: by 2002:a05:600c:5297:b0:492:7019:caca with SMTP id 5b1f17b1804b1-493c3cfaba5mr44455515e9.26.1782973427627;
        Wed, 01 Jul 2026 23:23:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:144:7f9c:c394:defe? ([2001:8b0:aba:5f3c:144:7f9c:c394:defe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4a343csm89668285e9.0.2026.07.01.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:23:46 -0700 (PDT)
Message-ID: <7a87ea66f1db2762737f424921a38eb6ce026dfe.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 6/7] exec*: Replace bash
 workaround to avoid memory corruption
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Thu, 02 Jul 2026 07:23:44 +0100
In-Reply-To: <DJNUP3YO8KUG.39DIX5U7FDR6H@gmail.com>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
	 <20260701131336.3578279-6-richard.purdie@linuxfoundation.org>
	 <DJNUP3YO8KUG.39DIX5U7FDR6H@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 06:24:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4362

Hi Ga=C3=ABl,

On Thu, 2026-07-02 at 07:54 +0200, Ga=C3=ABl PORTAY via lists.yoctoproject.=
org wrote:
> On Wed Jul 1, 2026 at 3:13 PM CEST, Richard Purdie via lists.yoctoproject=
.org wrote:
> > Bash intercepts getenv/setenv/unsetenv and does magic with it internall=
y.
> >=20
> > The data pointed to by environ may not be allocated by glibc but by bas=
h
> > and the glibc env functions have their own memory handling outside of m=
alloc.
> > Unfortuantely bash doesn't keep environ and the result of setenv/getenv=
/unsetenv
> > in sync either. This means the current workaround badly corrupts memory=
 and it
> > is just luck we're not breaking more often than the occasional opkg-bui=
ld segfaults
> > we've been seeing.
> >=20
> > Fixing this is tricky, the best we can probably do is to read through e=
nviron and
> > create our own copy of the it, modifying it how we need to keep the pse=
udo variables
> > correct.
> >=20
> > We do already have a function which can copyn and modify the environmen=
t, we can
>=20
> s,copyn,copy,

I'll tweak, thanks.

> > therefore swap some setupenv calls for setupenvp and switch out environ=
 around
> > the exec calls.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0ports/common/guts/execv.c=C2=A0 | 19 ++++++++++++++-----
> > =C2=A0ports/common/guts/execvp.c | 15 ++++++++++++---
> > =C2=A0ports/unix/guts/popen.c=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++---
> > =C2=A0ports/unix/guts/system.c=C2=A0=C2=A0 | 16 +++++++++++++---
>=20
> Don't you need to make these changes to execve(), and posix_spawn{,p}()?
> i.e. in files:
> =C2=A0- ports/common/guts/posix_spawnp.c
> =C2=A0- ports/common/guts/posix_spawn.c
> =C2=A0- ports/common/guts/execve.c

Those already have a environment being passed in and so they already
use setupenvp and we don't need to change that. We only need to change
the places setupenv is being used.

There are still some setupenv calls left and in theory we probably
don't need many of them but they're harmless as long as we use bash's
setenv so I just left them.

Cheers,

Richard

