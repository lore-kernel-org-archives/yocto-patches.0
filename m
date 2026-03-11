Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B0FD064B
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 07:30:38 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15527.1773214230214260340
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 00:30:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YSzxpInv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso36414715e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773214228; x=1773819028; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WBNg9pzbJAqmhLRona0dawnC70DkSvFULyWd8vFkntg=;
        b=YSzxpInvkP6Az6kxc282rMc5TSoy95RKjibg+4yqZNXkEEJ6LcIyW2wemxu6J2Gzde
         cM8OaWd9qOQy7p+bfQugbAyEPgF/RQI03cPxB3lm7+jJ7dEDv5KkH9g5F1KMf9KRRKgW
         LdsQwAFPScSvBQJHhaickrXf+//xQW55Vnh6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214228; x=1773819028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBNg9pzbJAqmhLRona0dawnC70DkSvFULyWd8vFkntg=;
        b=Ap9Q+rteTBV5qlaFXiQvTcw3zttaHwA8C8yUTafOQN6AOeMa91+qhBduGiu2PkhC4w
         h9lz0Xqn542+k3ovO3l7LnZDUUzeb72MoCsxX24B7ZPvvc92tY2ltF2ZFm+tZ+NZ8/lU
         em7LZ+Btd6BZeBHepqnOxiPelnvtPCrQJXFUY1K3l5egsq+GHpvWip7cTN7k9F/0x2H3
         /s7AC37TWqSZR4eNO9KlPQGB3NzDfrIMGfFUety7AR4r8A7CDmzqUltpjFHO66Q7d+n7
         q5rhw5xn1NxjGWDYVYYBCLOv2SM1InQyUm5MEs2xDvIeWwVyPuYl3Ye7XEiz3DC7EKzM
         ILZQ==
X-Gm-Message-State: AOJu0Yx0569uW6ysxCuKo7dXqWUOlckrIQQGKKHR8DoFmsReyeWjS49C
	iyZW+QmdddpHw/rFKz2BGrQloRHs2GRLD9rTQsUYJbFZtHDkgjkJmAwyorjYAv+ypGCrMOz0VtW
	1x+n6Qko=
X-Gm-Gg: ATEYQzwgJKTe+jWfgYoS8KnFbyJrUZtP1Aze+J8e3ed27DPgrb/8J4sk1w4tOS9iBjH
	cyl2b8cFPhppbbPnZznHRr4WiFTyevvkYUM/rRvLbcP8D5BrFP92si/9Xm7moKV0CjPBIB3LqI2
	zRfUS/WZHz5u0gn2XhRg55teWSTb+D5U6/mXrdcp2hJpyCylMwVakt1Q9RsZJcDZKoNoO1ycYuq
	GuHV539p+JH4rPeWgWzNGdXhRUSbXjc9BqmxWO/AYKg1W4E+WqdHSmMGWCMDOSi/CcvdLtbKsIj
	7Ef0bUl+WQzzuv9WkFUO5owqJwi/8yGgoLDsaPoXNnj1NKIG+lrNOWSHQPRDMfWstHKuPWgmKoB
	jYWkgbP/I2+syrO2VxyweDTSgESE2FsISrfDkUzpOqrsh2ycLjBgj6YpTXPXV5JEcYj8u9BwF8N
	WOQ/YcniAh8XdXlJf+ddGEDGScCxseRsdcABSxRIRp6B9y0BsDOZw3eQnffNlc5ds6ikqHbx6mT
	vAQeNc+yOvxAMI=
X-Received: by 2002:a05:600c:64ce:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-4854ad77395mr24748735e9.0.1773214227885;
        Wed, 11 Mar 2026 00:30:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b? ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6070acsm26325355e9.8.2026.03.11.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:30:27 -0700 (PDT)
Message-ID: <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 07:30:26 +0000
In-Reply-To: <189B9F01010B1521.2412760@lists.yoctoproject.org>
References: <189B9F01010B1521.2412760@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 07:30:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3426

On Tue, 2026-03-10 at 23:34 +0000, Richard Purdie via lists.yoctoproject.or=
g wrote:
> We no longer need a DISPLAY set to a vnc server to allow oe-selftest to w=
ork, we
> can use qemu's inbuilt VNC server instead. We can therefore remove the
> vnc starting and DISPLAY settings entirely.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0config.json | 36 ++++++++++++++++++------------------
> =C2=A01 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/config.json b/config.json
> index 1a8284c..cf27ae4 100644
> --- a/config.json
> +++ b/config.json
> @@ -88,7 +88,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
],
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"step1" : {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "shortname" : "Machine oe-selftest",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=3D:1 oe-=
selftest ${HELPERSTMACHTARGS} -j 15"],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "EXTRACMDS" : ["oe-selftest ${HELPERSTMACHTARGS} -j 15"]=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-=
core/meta-selftest"]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },

I just wanted to document/highlight that there is one case where this
change causes a test regression which is the runtime_test
test_testimage_virgl_gtk_sdl.

In most cases we can redirect to the vnc socket and have equivalent
functionality but that test uses/tests gl as well as the sdl and gtk+
backends and that needs either a DISPLAY.

Michael has a way to enable an X DISPLAY on the new systems RHEL 10
derived systems but I'm still keen to drop the DISPLAY requirements
where we can (and we can't view it any more).

The best way forward may be to find a different way to tell this single
test to use DISPLAY=3D:1 through some new variable we can set in the
configuration.

Does anyone see an issue with that?

Cheers,

Richard


