Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48346EDEC10
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 05:29:31 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11881.1772602168814544912
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 21:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LOjGNoEP;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38704f70ea3so114362571fa.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 21:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772602167; cv=none;
        d=google.com; s=arc-20240605;
        b=WrAWw01GpzxPh9xqGry8hK9NTWc/9BhUqsv+Bpf7FrYnclArU7/e1Pm83Al+8qXoYR
         bwbiSbdpbkmf4vYZ+/JS0VAdyyZPZpIwtj9RJxI2c6WY24AIC1G0ITknmR9d8jcZH+iH
         Il3IDHsuGYRn0eYmf882xi953vElL7GPpoHw8aGq8mlhfQcWMG+qDifjVS+3AvKVsACm
         XnQnpuNior+aEuJCet0gX2IP7J8ygfY0XR7lBjp3plMj6UZVmHZ+T/Ml9XcRvwLo6Y92
         HZtGsM336zHFuOOAt+9Q4AlFQMZkiAJhoN08d0yDO09tbND74tW4Hq+NrgCSge8X1Bbr
         D7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLCXYOVN1JuVIzWHlj/LxvqYPibt6F0aDrWx6kJxSXk=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=FRSJ6ypLotMUnvGHVcnIEDUfe170lvCMLURU4l2sYSu65gXGzTCvnkhdRpm7wM9FHg
         HZrKUaL327XkKzrHO9NT6k+QQTtRbKMf++oYw9BbWZaYeTQB3t+jF84/LbL1q+k9dmba
         ubAitAs/Hulh/IXl7HOnnA7JyROrsJLMMagIPI74umYX/3vU3tAh1yK/FnpjiAoda2mE
         DLMAgIeg4D9n3EWYCLEVf8z0u7RE7I4tOG0JTWTbCoY5GbaQ2Jt6naOZTWWuYU6Q9grF
         kQx7J5r6G+x7TMWrGfC4fun+2UTe+B6R4P+zMx9aKOLTh35afu7Pgt2HGoKMC6aDx5e8
         zYFQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602167; x=1773206967; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLCXYOVN1JuVIzWHlj/LxvqYPibt6F0aDrWx6kJxSXk=;
        b=LOjGNoEPoYKxzU4uCw+xxNYbycmbViW/yUloUPdH2Jj1DcXmQuLY2ndH5oOq4P6sLe
         8xLy/O+gBFl3PpsMx7pT61LpmQ9SUTgd1FdaFjS36rlJFUmQpPOsWz70JONBLaWer6dr
         Muxm1Qn/lehRCqs0wU7V0k5NO+B+Ml1+e+UMackGocuQ7KVQPU0oRJS9/qMcyz3FRXJQ
         F1TR6UEt5R3D8quX4g4suITk1Bkbe8XClM2DqfPdr7xxyLpUd72R0tfddB/geYTV+hoM
         VMDVcGfAN6YrLuiQCuOgbeucyrLRnTbXvTnw2Sp3vnCBcdEBXuoevSzcuXzuScrLQ4vO
         RRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602167; x=1773206967;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLCXYOVN1JuVIzWHlj/LxvqYPibt6F0aDrWx6kJxSXk=;
        b=SnMEaX3SMZPoBuh7AyhnkiW4Kr1/bi2I4aeToEWT8tttpb3YyNZTjeK6598fSgv7Jl
         SfiZ0jSVOyle7mOh5iHAIfujgUPuShpNJboPq3TK6OsO8SbD/7MHA10tzlmhvJh946KK
         NzJaRGetmpSttTvtDimTNxy2E1QseXJs/oWbcgVWEQSdjiNrEHaufilL/z7YK3I9XRDc
         q1LV2ER3mYFBTewFt1qo8ZMoU2i7iMsSS8nipMMz79IBoxizGXThJ1r9JzL7hhVvkR+F
         kJ3favzmuy+6PRnWZCRnuaPPyCwfj11xWHOs/Jue6LdTbPD7qPBRZEJRg/lhXfF4HMUa
         wJqg==
X-Gm-Message-State: AOJu0Yw7NuVgsMz1uItMsoaZ1UWY1fXjcyoka/LVD+22Mb9m3F8zAlou
	UVVRZz62y6Eq6ASODOrb9UpTuQptHba4VJSeKQsxU9LhZM9r1L+MMJHHHwxtGH8LbbMoGorg8XW
	nxRTpDf+o9B75A2Wk/8tQ6H2RisooipL0kk80
X-Gm-Gg: ATEYQzz98/xL1qxveJun9+VgiFScmAbuMqXsoe/86gdipMfOxlxfvQBSMreJEiK2VAm
	Yf+p6kgIDxYnnTau7YFNBk8tvtQYi8vmFHotB3daerJVR57ndQBvAEY3XdzKuCMxGVYxsCJi8Kh
	rFGM9BVwiCLCjKz2Mc42M7x7v68smk3VvjL+EPFsfFYXydSBv3RpmKpGg4Ty6GHxZFLX80zxvHq
	Wi8cW+QtSh7wGuJ1uhYsZSczAogdRSOLpIVLEVwvrMbd55wfs84YwXG/AszN9WSBQbrHQiI/hX/
	4y53wSOi/ghkSs+hmRzu
X-Received: by 2002:a2e:bc02:0:b0:37f:c5ca:b734 with SMTP id
 38308e7fff4ca-38a2c5745cdmr6711611fa.9.1772602166680; Tue, 03 Mar 2026
 21:29:26 -0800 (PST)
MIME-Version: 1.0
References: <8087c0ac-48db-4682-a3ff-28da284f351a@cherry.de> <ee18df0d-3770-4277-a55c-2dd38e5cc5be@windriver.com>
In-Reply-To: <ee18df0d-3770-4277-a55c-2dd38e5cc5be@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 4 Mar 2026 06:29:14 +0100
X-Gm-Features: AaiRm53FbaphVfHw1H0eXzPf-9khTWvrqOhNXG8oRHmigZhhtuXaKPCkzVm9oHk
Message-ID: <CA+chaQcG8WXk+4YV-iq4i5JvM+vkPb0iCwg8d1y+FhYpqvGq+Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow] tensorflow-lite not buildable
 since 3.14 python upgrade
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 05:29:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3322

There were some changes for supporting 3.14 merged recently e.g.:
https://github.com/tensorflow/tensorflow/pull/111070
https://github.com/tensorflow/tensorflow/pull/111421
do you plan to integrate them in meta-tensorflow instead of the
python3 downgrade to 3.13 or are you waiting for some official
tensorflow release which will include them?

Cheers,

On Wed, Jan 28, 2026 at 3:21=E2=80=AFAM hongxu via lists.yoctoproject.org
<hongxu.jia=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
> On 1/28/26 01:29, Quentin Schulz via lists.yoctoproject.org wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender
> > and know the content is safe.
> >
> > Hi,
> >
> > Just a heads up that the tensorflow (I tried -lite) recipe(s) doesn't
> > build since OE-Core moved to Python 3.14.
> >
> > There seems to be *some* support upstream (and plenty of people
> > complaining there is no release with support for 3.14 yet) but it's
> > still missing a requirements_lock_3_14.txt file which is the first thin=
g
> > that the recipe complains about.
> >
> Thanks for your reporting, we have to wait for upstream to support it [1]
>
> [1] https://github.com/tensorflow/tensorflow/issues/102890
>
> //Hongxu
>
> > Cheers,
> > Quentin
> >
> >
> >
> >
> >
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3122): https://lists.yoctoproject.org/g/yocto-patches=
/message/3122
> Mute This Topic: https://lists.yoctoproject.org/mt/117492755/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

