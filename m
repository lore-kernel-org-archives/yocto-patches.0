Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F3C43458
	for <webhook@archiver.kernel.org>; Sun, 28 Jun 2026 20:36:57 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24643.1782679013101489297
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jun 2026 13:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=C/kifw3d;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so15090425e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jun 2026 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782679011; x=1783283811; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEr6Ec9X1RWPxYYts5xrxDbI+Mfd31bFsurtR581XK8=;
        b=C/kifw3dFKaqFm9JA78Grj6qFhpS3qnTTVCx6hasVt36DAwl7zh4PsJlZ8868E6Vxr
         GDw/hxb/NOCf0gkz5l5TX66qa7dOu1GGXt1KmbGsjMI3E+/JuavjVo/4vHwWz9weTIPx
         ip0IzPEslzrTfgEbqCcuOJhsVq/1d7qt/Uc9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782679011; x=1783283811;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEr6Ec9X1RWPxYYts5xrxDbI+Mfd31bFsurtR581XK8=;
        b=QnQX4u4z1Fp2X77h1YYOAVI13ekYm/pVag377NNBxBcIHR4wbpBPjZz3Az5XCf2nID
         PhUflC//UQ0Ss8O1cuciCIDK4o1A1JaUejGzLEFqdPPZkFJnSCa7ybgaHOCUxBVsMj1j
         7oo7qGmBmTjhSmEEe08tIFwIKRjDUAU5+x357Ycg6SnRO5E3j8aL1DiM7gnQ7qQH75Tp
         RqUzSySSXD3roeG1OTxdHVrRN3wvI++AkgrKBn7tErz/lRjfnpat57E9Ab2DtYMYI0jQ
         Rey80BVueCnxfPTTlLoBf74SW9dqN3vzeXKvUyUwm98bfz/h/ErYi7aC8ez5NoB88ZnL
         DfrA==
X-Forwarded-Encrypted: i=1; AFNElJ94mQt08q/VZutT2ND/3IPYOZ8zv3YYvszjlrYvtrwXE3p1itE16JZIu38afv4lI5cKFdr5MGlNaq/Ul0ZS@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyuo4CFvsthw7tIxxJy+izhz8DjDdbUqgvNltl1tHO5aWdGLihH
	9WeuYanIcMmElCA5Afo5af/ZC/ee8f+bFNzXyg4bp51Sro9lDmujQH+7P6JCX2L8JVo=
X-Gm-Gg: AfdE7cnIrBNGXSu0bPDp8tnN50Ak6FB2e5zzJhEb/nBlNWUsL+sUDagphukFbTvGBbQ
	N6f8Sqr5cqVS7mU4sB1EsQMsOI8bbvVnsUWSYpYyMKWwFRtGbjXlxB22/vRbutb3bVfdK6QN8QH
	s2YUM90d5L6ukpUh2StPiVIpZtFkK/GJpwEqs9BnnJ8sCQQnYFjdgezZ1P8jn6UwVgNTGfOs+Do
	uZhqnsBdD4KlBbXI3p4MGo484o/NHVJQvcjuxe2rlUOCZBQ+a+elzGnDRwWU8SCcxKk19dxbfxg
	FUr0sTYWXCmaRKqSzQgiDdMGfrDBN9pB86LKGDmKtS/eHsGE+0FYnwM+BBj6/KKJUTN+t1utGvo
	IbHjEWdJq+HP4xCAShOHpOaILgzZJg3GbI1sP68zW2OGxtsdc6VM8pVFXA5ayYDEmll4mshgKp2
	pwFUhC9XjTuuQn1vU2NnkJl16m/o9zJjR/OccjvhoVG+H/qaVV3j7jafAqcQS4c69AcAST4FQwQ
	uhcKA==
X-Received: by 2002:a05:600c:1f91:b0:492:4d56:d5fe with SMTP id 5b1f17b1804b1-49266858306mr207076965e9.14.1782679010860;
        Sun, 28 Jun 2026 13:36:50 -0700 (PDT)
Received: from localhost (2a01cb001331aa004db220001799fd29.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:4db2:2000:1799:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493adf3d98fsm27190285e9.8.2026.06.28.13.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 13:36:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 22:36:50 +0200
Message-Id: <DJKYYVGQR3E2.269VYKT1TDY4W@smile.fr>
Subject: Re: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: Use
 buildtools on RHEL9 derivatives
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Paul Barker" <paul@pbarker.dev>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260624142429.1628429-1-yoann.congal@smile.fr>
 <e9ee27ab791e38456ff57b535abe9d56eac60f76.camel@linuxfoundation.org>
In-Reply-To: <e9ee27ab791e38456ff57b535abe9d56eac60f76.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jun 2026 20:36:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4312

On Sun Jun 28, 2026 at 10:08 AM CEST, Richard Purdie wrote:
> On Wed, 2026-06-24 at 16:24 +0200, Yoann Congal wrote:
>> From: Paul Barker <paul@pbarker.dev>
>>=20
>> tar 1.34 (and possibly earlier versions) is unable to extract tarballs
>> containing read-only files with xattrs. This was fixed upstream, but
>> it's unlikely at this point that the fix will be backported to RHEL9
>> related distros (CentOS Stream 9, AlmaLinux 9, Rocky Linux 9). The issue
>> affects these distros specifically because they have selinux enabled by
>> default and this uses xattrs.
>>=20
>> The specific failure we've seen is with the /usr/lib/udev/hwdb.bin file
>> installed by the systemd recipe - this file is chmod 0444. This leads to
>> the following error, typically during do_image_wic (shortened and split
>> to make it readable):
>>=20
>> =C2=A0=C2=A0=C2=A0 subprocess.CalledProcessError: Command
>> =C2=A0=C2=A0=C2=A0 'tar --xattrs --xattrs-include=3D'*' -cf - -S -C .../=
tmp/work/qemux86_64-poky-linux/core-image-minimal/1.0/rootfs -p . |
>> =C2=A0=C2=A0=C2=A0 tar --xattrs --xattrs-include=3D'*' -xf - -C .../tmp/=
work/qemux86_64-poky-linux/core-image-minimal/1.0/tmp-wic/rootfs2'
>> =C2=A0=C2=A0=C2=A0 returned non-zero exit status 2.
>>=20
>> To work around this, we will need to use the buildtools tarball on
>> affected systems.
>>=20
>> Fixes [YOCTO #16143].
>
> I'm a little worried we missed a side effect of this change.
>
> https://git.openembedded.org/openembedded-core/commit/?id=3Dbb7c445004f07=
06a96192d97bba1c8776595814b
>
> means we do detect and warn users of the issue.
>
> Unfortunately, buildtools has a lot more in than just tar and we're
> effectively reducing the value of testing on those older systems by
> using a full buildtools to work around an issue in a single one of
> them.
>
> I'm wondering if we should create a simpler "tar" buildtools tarball,
> to ensure other issues don't creep in on RHEL9 derivatives?
>
> Sadly, we're stuck with RHEL9 for a while yet, we still can't drop
> RHEL8 :/
>
> There is precedent for a single tool buildtools before when we had make
> issues with ./meta/recipes-core/meta/buildtools-make-tarball.bb
> (these days I'd class extend it!).

In this case, I do not request the backport for tar but to upgrade python3
above the fix for https://github.com/python/cpython/issues/91351. See my
remark between the cherry-pick and my SoB line.
> [YC: Also, by upgrading python3, this patch fixes:
> | ERROR: Unable to parse /srv/pokybuild/yocto-worker/oe-selftest-fedora/b=
uild/meta/lib/oe/data.py
> | Traceback (most recent call last):
> |   File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/o=
e/data.py", line 8, in <module>
> |     import oe.maketype
> |   File "<frozen importlib._bootstrap>", line 1004, in _find_and_load
> |   File "<frozen importlib._bootstrap>", line 158, in __enter__
> |   File "<frozen importlib._bootstrap>", line 110, in acquire
> | KeyError: 140127001167424
> From https://autobuilder.yoctoproject.org/valkyrie/?#/builders/40/builds/=
3981
> See upstream issue: https://github.com/python/cpython/issues/91351]

That said, your worry about reducing tests and the need for more
fine-grained buildtools still stands. In that case, what I needed was a
python3 buildtools.

I've created #16335 =E2=80=93 Create more fine-grained buildtools
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16335
... to track this.

>
> Cheers,
>
> Richard


--=20
Yoann Congal
Smile ECS


