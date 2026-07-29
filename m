Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCFC53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 08:14:26 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6577.1785312856918982188
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 01:14:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IeB5AdzT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1740c36c5cso92498366b.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785312855; x=1785917655; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ba57G1I86OwKGE5ekKmoyHzfX5S3fHbaPdO3Zo9cQpI=;
        b=IeB5AdzT46hzoKQ9m+maX1din08hvNwJKL+jjlj50rRTuEOVTeRDPwJWpJcCcCQdTd
         5PFl1A/bgiFGlwnCC+0Kde72ZgTJqpFK7yc8Y9MVu8LIfdsAbkeAU4HRGmqHQ6bb0ZWv
         2yuXKftPEWbaLL6oKHfboLQ/KcJduynXYlAYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312855; x=1785917655;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ba57G1I86OwKGE5ekKmoyHzfX5S3fHbaPdO3Zo9cQpI=;
        b=LhdP6Ha50fPlifP2ZOAoGFU+GZqwnILGdlsp3lO+SZjMnyb7lqkzJRncfZLdTA3X51
         vP5DUOoK8pBOW2FKlG5ewAjd4MjHyImjimIVL8PTbA5OZg1HWqk7VxGL/U8ZDk6GT1SJ
         Ua/fHTIbAFAZcTK8exhYi9kpd7+/duYZHlb6nAD7T1A8tj08HVnR1qP18HZP5EvWCGxA
         1Q56LvKxUxpL0/Sx8RSAle9SFbhV3eMKvXNhba47VN/GksB76pdU07UBd9wJ5xqkoINM
         RJFK5ilCJeLplJRobnkAzyvWMPP+ZCbeY/EoFJlX4s2Zt+vlSiv9ZTOtX6/VNOqECeJ3
         f3Fg==
X-Gm-Message-State: AOJu0YyzqqnSbZQMFTU8IH0BDVX4oTkg2CT95X6OoghAG4XX1IZ9/+y1
	NW9MLWPI8Mp+IiYBSsi3uDWxFNfWntl8XBVz2gMnUrTp8H5ItwtVtHzIfJwBa0xZ84STY7kGLOW
	2CtIy66w=
X-Gm-Gg: AR+sD12RqzS4wecKOsimYrGxQdvTfw/TNyS9y3wqLlepqtmWZmrLTOqd8PbEoO0uHHK
	jwSYrHTWdekcQ88jDg5tQ791lNXgtHCnOO+rRgApMUXxdxHlyrwBqQzjf44MEZHH8lfppE/oKvX
	2gdwguaWtS25PFrGAmyuAinhKEZ+hnJK6IaI6hAr81xNTQDLWU4tptnreX6aELLjsOeZrVJRDgV
	qcM3S1lTda2r81vxV6nyYKhuDe+c+d9TNB38Agd4YYbMBK1Gwzusonzlc37uBpG2bkUyx0eqYdI
	miFh4uz9yjcWHd1RBS3ip7qo01MtIF42wvvz9G+2mcYPcjE6Ov87zckF7q4JsP1ioxas3DJ598J
	tJuhENWx9IBtWkM4eaSFhqOvlx8Jb3wf+IBocjJkWCfqe4+P5U07jkundczsJTK7Q7k+FDue4fG
	sfin2hWVe5pVu9502vEgBrd0utOfkCZZf1lWv1IX6NqGpyXcMqJTXNL82jIiW0S7HWA9wczXZf4
	pQSM93TgXKy+jA6iGIHuYLpCVqtBb5vgqXraTH9P49fDGlkz0zNGQ==
X-Received: by 2002:a17:907:d643:b0:c0e:840a:79a3 with SMTP id a640c23a62f3a-c1f7226ce73mr271811066b.52.1785312854760;
        Wed, 29 Jul 2026 01:14:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3647:86f2:68ea:efc7? ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de45sm77943466b.35.2026.07.29.01.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 01:14:14 -0700 (PDT)
Message-ID: <37a61cc641f5c8384248013f0e634ebefebe288b.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 0/3] closefrom/close_range:
 protect every pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Wed, 29 Jul 2026 09:14:13 +0100
In-Reply-To: <18C6AE58128B91FB.3067440@lists.yoctoproject.org>
References: 
	<d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
		 <20260729050807.7-1-bbnpreetsingh@gmail.com>
	 <18C6AE58128B91FB.3067440@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 08:14:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4564

On Wed, 2026-07-29 at 07:19 +0100, Richard Purdie via
lists.yoctoproject.org wrote:
> On Wed, 2026-07-29 at 05:08 +0000, Babanpreet Singh wrote:
> > On Tue, 2026-07-28 at 16:59 +0100, Richard Purdie wrote:
> > > I think the missing piece is this:
> > >=20
> > > - if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op
> > > !=3D OP_CLOSEFROM && op !=3D OP_DUP
> > > + if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && op
> > > !=3D OP_CLOSEFROM && op !=3D OP_CLOSE_RANGE && op !=3D OP_DUP
> >=20
> > Sorry for the breakage, and thanks for chasing it down.
> >=20
> > I can reproduce it both ways on master-next at 6d65d74, with a
> > probe that
> > opens an fd and calls close_range(fd, ~0U, 0):
> >=20
> > =C2=A0 no PSEUDO_*_PATHS set=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 OK
> > =C2=A0 PSEUDO_IGNORE_PATHS covering the fd's path=C2=A0=C2=A0 SIGSEGV
> > =C2=A0 PSEUDO_INCLUDE_PATHS set, path not in it=C2=A0=C2=A0=C2=A0=C2=A0=
 SIGSEGV
> > =C2=A0 same env, closefrom() instead=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
> > =C2=A0 all of the above, plus your line=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
> >=20
> > For OP_CLOSE_RANGE the path comes from fd_path(lowfd), the ignore
> > check
> > hits it, and pseudo_client_op() returns early with result still 0,
> > which
> > close_range.c then dereferences.
> >=20
> > Two things before I respin. Do you want the three fd-protect
> > patches
> > resent, or will you carry the master-next commits since you have
> > already
> > resolved the conflicts? And the ignore-path line: fold it into the
> > close_range patch with a Suggested-by, or keep it as your own
> > commit ahead
> > of it? Either works for me.
>=20
> You can fold the above piece in with a suggested by, it doesn't make
> sense in a commit on its own. I can take the other fd-protect patches
> if you're ok with that change, I need to update the commit messages.
>=20
> Whilst most builds are testing cleanly, we are seeing these two
> failures:
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4403
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4466
>=20
> which look like a pseudo problem, and that is with the current pseudo
> master-next. I think there is still some issue remaining somewhere
> unfortunately. I'm afraid I don't know what it is.

One of those doesn't look to be pseudo, the arm one definitely does
though. It looks like it may be arch specific.

Cheers,

Richard


