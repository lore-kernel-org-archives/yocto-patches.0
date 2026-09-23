Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFFC982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:17:09 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2990.1790155027127002591
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 02:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GZAPPY+Y;
 spf=pass (domain: gmail.com, ip: 74.125.230.205, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso65137385a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 02:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790155026; cv=none;
        d=google.com; s=arc-20260327;
        b=LhxFKpklUVwf7xJ1MobuAHFQ7Bd2PtKc4CfKt8tI9zggp3CxgHp3Pk3YbbWIMfNoYF
         ItMRTchEoeEIwQMw8nSPVmAwcCMkuKT2fUc/HSugE600wa5LQVTW3KbmwWsU8Oliya2x
         J+G8Oc86x4COJTLe97EUiEMlWJghSu9bT7mZHgpQZfr0L9tcMAOEWflBJqGnEZW7vNw8
         0FlMH/vA+PamdBCPM+Xmxp/o8y59p0GSn8ZUeym47gWYPAME1aUzJ8hzx+s1kLperYJ3
         mXnYNnovZgBC0aqXB9dOa0AmFCR9oLyS7f5OqUgt41pS1VXj9zGO33eR8tVxkTPMM/xK
         AFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Lx2viTKJAmdsUY+IX0pzgI3asmRCDoohSJrKDD6pYdo=;
        fh=WFk6WqVLMumhhBiMgmEG6lAyoeJm2sRryqhUz7/ms2k=;
        b=hl3dJsB/z048VVaCW7YGxDZdkw4O/FJBrOM3EPtcjZtN9FFJfVEgPQztbjVddBRV5m
         a9XU3frrssuqoexHo7zYDNunKL4yS71pniBJt6O4f34NqtM6rJRT5lkrkvAltL5WQeHo
         KV/BmInEHaNscjMWuuetFFeCJdv7ozXgycgTYIqWZKhsjPZguMLja1r9mSSNyojjVdR7
         EAL1oBd8JbB+aZMo1FNYQC+aIZF442Uosydu2fBx17XFv5VtiUmthrnK50dawKJLyHeC
         D8Z6tgBvB7M+58JzBXmg1lvNtdinhlQ4+AehWxysNiJ59vcPNMp05h2Yu0crsHuxZda5
         43hw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790155026; x=1790759826; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lx2viTKJAmdsUY+IX0pzgI3asmRCDoohSJrKDD6pYdo=;
        b=GZAPPY+YEw/UjzotplGp34UD0aBeqxIsfmlXZvOUEYdPueEg+A0vHpp/MUYn/DNSTg
         kSPHcGThMWpTeX2Kgl0snp1/ZutKiPA3B84ZQcwdR6YeCdx63f1IcRbTK1lhvKa7eHxh
         5bd7Ic3yDj4RYwmrVIzccUU9b6gw3WxNAlR8yGU1RZyXm778EX3mGGsxtooY50MkfKUG
         2hG216fs3Npzq1wUmumG+L1JQKRjOCnQMo9B1J7E2n2i4NKRA7UtLJ3YXMxFU1vHgSuo
         /tK7dCxovMJTtO0mpJkTWuyzL3z/hX3IhjV4DuVwoUPc8bTTrtFid8QQYKQHRYTrp7gM
         RZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790155026; x=1790759826;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lx2viTKJAmdsUY+IX0pzgI3asmRCDoohSJrKDD6pYdo=;
        b=Zak050cI0ltogySF2RE2xmSa+1Y1AXOWGVilGhQi5EJu0+e5BEPA4HDBffcbIEDFWR
         jIXCwby+nu4klfJhrYhpH/ql6rXCNUiHtn7aY+KgAl/zDWgu5jkaNGal+tQcLymOUzu7
         qZ9tTAUFW5e9KNkZwR4JPTrkoYjDnvzt0uXsy9+1LTOqC6f/CwtBK8STlp8rwtDrds05
         tZ2rh2kTyLZkNFatk2FNjPWuSrIutpEMxHfUvYlAiT+Kjz5jdP2RHvjrmWCdSwyJIns2
         /QQfOTJbIHzPrCtPgwfY4tZnLwso/Q7dK5rWH0DK+OCBfnFvsC53OvwyuS5IT//ULf+m
         xqfg==
X-Gm-Message-State: AFuF++kgLrvvJMFglHpJHqttyfD0I/vtWnI2wx/ar6WK3NVdeRi83vDv
	Spasc1c+q1SqF6VqfLLHAhJeZdA0JqyVcGAhlnHFsIKocMtMtEE3gAgndWGR291oZn29Iwao7AG
	JlUXe3wUq4Frd2i+z2xrItVNLucjQ1TE=
X-Gm-Gg: AYBFou1LYgc97QbFAvHKhNwGnB5AH8htPQjFC0Ia9y8GHMiZAT/rKemTT396hG2k994
	xt3hhWxfUZt2Q5Si9RPmgITAiIskcPuDinDiOH1BmyoGmylq1tykjTNZHxH7++hlkrK0fb5MQWA
	3bm4WeCxU4b7ZnAy1ci+Zg7GFJSarX6iw84VVgmzI3oAFn4ndKanO74u7rbCF07WvqYLlwfEtJc
	zTgF3Og0fFgg09BVZryZlkzjv+tZsUW3pfq2lI2RsivLuLLl/IfaaCvutqao0uSovzRlcitPL1d
	V87HHTyZGrUEzObIygayc5DWTAraAkpQ/uSPYGN6pDkam1zkOoJpoc4vTy+/0hVX/AsyYty7sT1
	FckRTERGxor84Mg==
X-Received: by 2002:a05:620a:4390:b0:93b:c279:2fc9 with SMTP id
 af79cd13be357-93c251063c2mr308365485a.30.1790155025882; Wed, 23 Sep 2026
 02:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260923085528.88881-1-daniel.turull@ericsson.com> <cf408d794ae1149af198fa0acb1e9d9d1ac87755.camel@ericsson.com>
In-Reply-To: <cf408d794ae1149af198fa0acb1e9d9d1ac87755.camel@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Sep 2026 11:16:53 +0200
X-Gm-Features: AclHuK8Ay85ELC7bOf3z5ab2cYEY8DaSFNCset6UikevbHz-tJ0HTw8-nmfJBIU
Message-ID: <CANNYZj_BgVKGcndf=BfuUcBMexPG3Fa-Hvjp8wkVOrf8AkbPHg@mail.gmail.com>
Subject: Re: [auh][PATCH v2 1/2] steps: skip duplicate changelog for
 shared-source recipes
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="00000000000069229f065c22f2e4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 09:17:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4939

--00000000000069229f065c22f2e4
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 11:06, Daniel Turull <daniel.turull@ericsson.com>
wrote:

>
> The patch will work when the oe-
> patch
> https://lore.kernel.org/openembedded-core/20260918120125.770604-1-daniel.turull@ericsson.com/
>
> that I send to create the metadata is merged. Until then the files are
> slightly
> different with the changelog since the recipe is on it.
>

That patch is already merged?
https://git.openembedded.org/openembedded-core/log/

Alex

--00000000000069229f065c22f2e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, 23 Sept 2026 at 11:06, Daniel Turu=
ll &lt;<a href=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
The patch will work when the oe-<br>
patch=C2=A0<a href=3D"https://lore.kernel.org/openembedded-core/20260918120=
125.770604-1-daniel.turull@ericsson.com/" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/openembedded-core/20260918120125.770604-1-danie=
l.turull@ericsson.com/</a><br>
<br>
that I send to create the metadata is merged. Until then the files are slig=
htly<br>
different with the changelog since the recipe is on it.<br></blockquote><br=
></div><div class=3D"gmail_quote gmail_quote_container">That patch is alrea=
dy merged?</div><div class=3D"gmail_quote gmail_quote_container"><a href=3D=
"https://git.openembedded.org/openembedded-core/log/">https://git.openembed=
ded.org/openembedded-core/log/</a></div><div class=3D"gmail_quote gmail_quo=
te_container"><br></div><div class=3D"gmail_quote gmail_quote_container">Al=
ex</div></div>

--00000000000069229f065c22f2e4--

