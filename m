Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3DBCD98C5
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 07:42:43 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87308.1781336554758152107
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Jun 2026 00:42:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=G9MFlHPV;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4601949975dso285365f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781336553; x=1781941353; darn=lists.yoctoproject.org;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/ILiUOQNZI8Rz+ZnVNVDdnM7qPDMriOpa4z27KrN5Q=;
        b=G9MFlHPVS7SLiUUustomLTkKipOU9htZCAc/8RhCzi2ys5vyi/rfaX15tWA6ES1a00
         +sFM0RHeBhER9SIWEYC1+tq45MxHtJ1MCmaAqL1IwTlpPP/KorPZPT37lT8ES9RSFRze
         74UKqJK59gCkAnxF2IOIMd9eS+UGT680bfejU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781336553; x=1781941353;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/ILiUOQNZI8Rz+ZnVNVDdnM7qPDMriOpa4z27KrN5Q=;
        b=FzeXnRFidsvG6vDbWEipIABvUTwwDfv32W4pYGpyAqzQtbMoJ6fDo9PjlmpCYGIaKd
         X5oucGLVpat6i9FYpZihSp5DqPuok70eymiGmqGE40K3E08NzcdkGjfBOfSfubyzcKpb
         8nPdDnASIbD7KxwZqvgJl/n9x3mEqni4nPQ13XiM+qKpMM+5EG+Fe+GPjfwCQTf9X0OR
         HvKqB91pjLBFx0nWgaaEcQCBCEy4rn+T5PlHF7gbVGxzlZGeiZxMrmboYqkdWs+VSe85
         58PdWNt0yNynBX2Je6vCF6Aa6X8AV6qnMhGW/T4hyoXyAPbXMM82MKCQAe5nUAfk0zK8
         zA3A==
X-Forwarded-Encrypted: i=1; AFNElJ9UqnzyE2nkKo4ONGGa8bHZ66P3DULDmXiIYgeq1Qwf3Cl9p74b9Y2Alxm42IhVQtBtcgeusBBnYGxu+KPB@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yy6A+kw/KbIC+bdYK5y/y9W1oP5YTNWn9ZmGY/S9ZS7smLnb8I6
	SoPybJ+mQGzo+RwQk77Bo4Aaie/Gt82poPtjH7YZLZGEOELZzJsmG+Ndvuna20vp/uI=
X-Gm-Gg: Acq92OHc4JxpljlwwqJAeQeZ0GgTShIarkxPqA4Cmo2o+iw3xIaoCrLfvGk63vcME6A
	ujaJNGYCEdA7/wzoo83D2ZtL6W0CD4Mcir9IJjbBl/c4aZQ27RTOAutllRCMO/1oVmUZNLuWsZt
	8rjKFmZzT6EH5yUfKTVcz9aq0qXgKDSlVgF/dDN0UlVEiO+AGznefs9lcHRELh2i6uuSkzXAUfJ
	U+Ux9DLRFwXYBRM1SGS7hvVbDbDe4JG7q5TFWcw9hjPkXw1kXEwGqwtJkt9Oh4m2xYJM8Zbsxpm
	SYWA0HEGNMrmMFvvRWMKyZBAIUNlZE6rNcxgkn0BCrzHNRHypnycwdr67pm7NQhNMJaaTveCUnR
	PpzeLUIDCgsXNOHve0m7XtKiTNKxhbFDy3D/cwoE5DSbB+Nr5oejkystVGc80Pl3Vu7StkXmQ56
	7yD7iVzwNQmZZ0FCBp6Aq79HMFQfArpcCyemxpt6KVGzUHdh1UffW45RZ3r+ckNdZRB+wwBJ6L4
	5qArYCL2FcXYLcY4eYzljcoQ04=
X-Received: by 2002:a05:6000:4013:b0:460:5949:960a with SMTP id ffacd0b85a97d-4606da5a4c5mr8040013f8f.8.1781336552909;
        Sat, 13 Jun 2026 00:42:32 -0700 (PDT)
Received: from localhost (2a01cb001331aa0088eaf8e3bd76d877.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:88ea:f8e3:bd76:d877])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f23fsm12965655f8f.9.2026.06.13.00.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:42:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 09:42:32 +0200
Message-Id: <DJ7R3UWI1FS8.2CU5GBTM3TPNG@smile.fr>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH 1/2] schedulers:
 Drop whinlatter
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <20260611130338.484322-1-yoann.congal@smile.fr>
 <a35c0f4d636255b636b5ec1ed9b7454a513b3762.camel@linuxfoundation.org>
In-Reply-To: <a35c0f4d636255b636b5ec1ed9b7454a513b3762.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 07:42:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4219

On Sat Jun 13, 2026 at 9:22 AM CEST, Richard Purdie wrote:
> On Thu, 2026-06-11 at 15:03 +0200, Yoann Congal via
> lists.yoctoproject.org wrote:
>> From: Yoann Congal <yoann.congal@smile.fr>
>>=20
>> The whinlatter release is out of maintenance now, stop running
>> metrics for it.
>> Also, its CVE metrics count dominates the patchmetrics graph:
>> https://valkyrie.yocto.io/pub/non-release/patchmetrics/
>>=20
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>> =C2=A0schedulers.py | 1 -
>> =C2=A01 file changed, 1 deletion(-)
>
> I'm torn on this. You'll note we still collect metrics for some of the
> older releases and have done for a while after they are no longer
> maintained.
>
> There is a reason for this in that I wanted to collect data about what
> happens to the CVE count after we stop maintaining them so we can see=20
> before/after data...

I believed the trigger to remove a branch from metrics was when its CVE
count was greater than other branches.

Looking at https://valkyrie.yocto.io/pub/non-release/patchmetrics/:
* For Whinlatter, that happened a month ago and that was way quicker than
  every other branches in this situation.
* Given the current rate, I'd day the whinlatter curve will start to scale
  down the whole graph in a few weeks.

I have no trouble with you waiting to merge this, I just wanted to have
the patch sent for when you need it.

>
> Cheers,
>
> Richard


--=20
Yoann Congal
Smile ECS


