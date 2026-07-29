Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3016BC53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 06:20:03 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5476.1785305994978852272
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 23:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YoI+Z4IO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f904e80eeso472804f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785305993; x=1785910793; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h3p+3G10czMhwH22N9hnDJSKw0Na2pxudLjFRwX9eVw=;
        b=YoI+Z4IO5frncwzqQvGL55s7RPmQg0Mx7w/sMzziKjfrHw1h4+b/rfB922ES6ZZ+vM
         7Fx5LVCbkGe/9zImHCJxsCwFF3b3D0zbfVqSW5+VASfbYyS1uOVWUVPSMBcQWC1PMIAF
         qYi2iTsUs7TsyjfnHCbVje9PvQwsYl5Ps7pik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785305993; x=1785910793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3p+3G10czMhwH22N9hnDJSKw0Na2pxudLjFRwX9eVw=;
        b=CYLTBebgqF1KLgt4hvAL4J6TAzVLA+cH81H+ZYPgNtIEmzm7sFoYrRb0zrDFDkn8Ia
         ++HMKqA92FNKyIGJ87IZmXBjNDSyYcKBn/gHTahci7dQk161LvrsWR9dD6Ocw8m06xTb
         ZOKe9EOKWYv1peJq8cpPAZgag9fwOeSwMEeGhaHQvJW71UlFYgHetR+DM/KAH972uN2p
         U5/p7LZMPH4IozpTtGe9M0M5jroiKcCLu3Pk9QDGV5jAt5VLROduCs8vr8Bz6ojJMnFR
         D6S5btYjzHiCyKpsHZLn6J+FIqdMXLZyZ+/hGa4VeaeGQS6uWuVVuPatplys7H2QSzFB
         xSkg==
X-Forwarded-Encrypted: i=1; AHgh+RraP+4yEf5yGuGI43geZDV3muwiMwalrxTDyOYMICUMHwQzUG/h0+i2hn2aTK8oHe37TNXm5vHV59BOBPtw@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzsMYD1Jd4YV+jUkl1YBXJmmICltjHCaYV9r0Mhk8TyavKO2MmZ
	7qHFFkouVnZlBFptrLqEGciwI9xjedivL2XwMzaOkWbO97EcsNTP6Klkoi8IP2dOXs8=
X-Gm-Gg: AR+sD11v8h207OkEUzWIOXA/7rBcDtvOlmUD+KKAehqP/8gPtu1EucjnCodchQgBKP2
	MTQMaxsCyqaFd018tbybRnjU9Uy6QDx90hB7trm/nym666zmzeVOYHA69BX5U/VQgxpSKPaRZ4R
	VkZgy3O0dDJdFU4uH6rwvN/TibtVr92A7prxEYKIZl2e7dwCfYT+KBc3BrYyI454BjvhUq758O8
	oxBtSIOIOUNZvmTh65oyC4Efiqx6h0pHg5Ml0K0HBanTKX/RAeQvdnWl52BSKD005l5nEyQH5e8
	VoxThXAGM8sa8LkfWweC7IJEznEgGby7M6AFMbm4hfmeTkGFD5EATaKP01Dob+vGHcfvYLRsxN+
	3Pgd5vfFf7nXCJDgUO27zTeAtzNfOzbGwUl/SVZYAocDYYwhlSaKCvuMyQWD4bqkXlxp+tVg//5
	n1/SLc24geub801BWm2WPMA1QvYSL7DHkzd84wvupbYD8XpIssrTAm/Of5T+bzKL0ZQIHDpgDd/
	qktTeXX7OJccWLruzbB25Y4tCkigk9Syw7UTwSJCsMYNna3xXWqCQ==
X-Received: by 2002:a05:6000:2386:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47fb1edfae1mr5722129f8f.23.1785305993080;
        Tue, 28 Jul 2026 23:19:53 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3647:86f2:68ea:efc7? ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a32sm5399862f8f.2.2026.07.28.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 23:19:52 -0700 (PDT)
Message-ID: <6f274217d70c5f9e201c435239c1dc0340a5989a.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every
 pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Wed, 29 Jul 2026 07:19:48 +0100
In-Reply-To: <20260729050807.7-1-bbnpreetsingh@gmail.com>
References: 
	<d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
	 <20260729050807.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 06:20:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4563

On Wed, 2026-07-29 at 05:08 +0000, Babanpreet Singh wrote:
> On Tue, 2026-07-28 at 16:59 +0100, Richard Purdie wrote:
> > I think the missing piece is this:
> >=20
> > - if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op !=
=3D OP_CLOSEFROM && op !=3D OP_DUP
> > + if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op !=
=3D OP_CLOSEFROM && op !=3D OP_CLOSE_RANGE && op !=3D OP_DUP
>=20
> Sorry for the breakage, and thanks for chasing it down.
>=20
> I can reproduce it both ways on master-next at 6d65d74, with a probe that
> opens an fd and calls close_range(fd, ~0U, 0):
>=20
> =C2=A0 no PSEUDO_*_PATHS set=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 OK
> =C2=A0 PSEUDO_IGNORE_PATHS covering the fd's path=C2=A0=C2=A0 SIGSEGV
> =C2=A0 PSEUDO_INCLUDE_PATHS set, path not in it=C2=A0=C2=A0=C2=A0=C2=A0 S=
IGSEGV
> =C2=A0 same env, closefrom() instead=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
> =C2=A0 all of the above, plus your line=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
>=20
> For OP_CLOSE_RANGE the path comes from fd_path(lowfd), the ignore check
> hits it, and pseudo_client_op() returns early with result still 0, which
> close_range.c then dereferences.
>=20
> Two things before I respin. Do you want the three fd-protect patches
> resent, or will you carry the master-next commits since you have already
> resolved the conflicts? And the ignore-path line: fold it into the
> close_range patch with a Suggested-by, or keep it as your own commit ahea=
d
> of it? Either works for me.

You can fold the above piece in with a suggested by, it doesn't make
sense in a commit on its own. I can take the other fd-protect patches
if you're ok with that change, I need to update the commit messages.

Whilst most builds are testing cleanly, we are seeing these two
failures:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4403
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4466

which look like a pseudo problem, and that is with the current pseudo
master-next. I think there is still some issue remaining somewhere
unfortunately. I'm afraid I don't know what it is.

Cheers,

Richard

