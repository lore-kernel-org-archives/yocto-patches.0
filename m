Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0602CA5FFC
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 07:27:07 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40008.1791271624058341061
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Oct 2026 00:27:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=TfLu5WhW;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=VpCEEQXW;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 582351D00154
	for <yocto-patches@lists.yoctoproject.org>; Tue,  6 Oct 2026 03:27:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 06 Oct 2026 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791271623;
	 x=1791358023; bh=VNVVM3h6cBOH89lZ4GYnh363ZakScHPG7TvRpvib5FE=; b=
	TfLu5WhWm1rXp2NvHR8Fuoa2sDxV9OGXgTZ6bPwfUGsHuKdKZIJ59B36jy7BRmQJ
	kBvBVZq+XVKoy+UzdUTi4WqO7NdeqD5opXGXW5NuzgE6jR4VNc6MZHOhckCVVmVX
	P2vZ92d9bwnxVHhglcGenEHTYH1hpK7R9GrM6RLJ79BpD7VMcUtDgVBdxIPCG7vx
	hsiFdNdO+RhecgIPDxTjNNatD9V1wQZBaV+rjd8XvsUkku56YyRgPK+xj4xgaupP
	Hkm1+vuG/WkPOKHSwqmT6ufwi1eSwMsfPJf0vqiQMRXqli/pipGLIgX1WObjBUeQ
	aF4X/BL+H8sbPIG4cJ7Kzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791271623; x=
	1791358023; bh=VNVVM3h6cBOH89lZ4GYnh363ZakScHPG7TvRpvib5FE=; b=V
	pCEEQXWFMCtyDkSUQiVp+/hlzVqonAi9B2JvGzGlhs4Y/KVnjdcUf199ruCiGDor
	6Ij7lIbeNlNIHHzpVdgXVvbPL0ekHsT51zB9w5yVAfBLbYsXJpE27DKYtE2D/hE5
	0hMVO9f+Kc6mN5JDa5tZr6C7tWShHeYe9BjG9l3xskitw4jd2fNLfnOyGMOXlHbN
	PD8rO4yWGREd6yNOJS0gGgQgoWs80NbMLKLZjkdtQzDU0WF8vpEaBxDAX+VfeaCi
	nXHo4nsWEkXuzr7/7IQ5w8xNL3MQuXrEThl5Bm8HMUXh16yVlN0abWAglUhp7p40
	aPO1nCWyiDRdHR3up49zA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791271623; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4=;
	s=fm3:rsa-sha256:J3FDJdc5i9n/VBqBNL3TjwrJS9BRHZAPxznpHnhaM9acOcB
	vAmkfBYX2hcCgzgf5gvOW1ZuU5VeWzSdrYjO9fkLseQzPXNCHaUtzmJ1JUDhA6ZL
	TtK1FFJ/ARWRRvJ3f3nyYaN6dO+m9/NQYRcR8r9NnE2DIFJTNBJJhp7R7/wclM9O
	JlaFwEwbcRy1Lf45m3RHEXmGPcYjIkZ5E640skcrBG29qGLVLLRiI3y1l226WrjL
	F6kxPMK1fWA8/w3l5RGwdCGqE2MFko36Esr/7lVhEGDUXKShV+EVffCMmPwnkH7Q
	u4piB6ZS/7LCONnrNgrxuszUUvRf740rENGh6wg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:7UdGAo1VakoIu+ZXW07tE7PzAacyp0bQlXlgHAWDjv0=:UOlV7FftKM3OEVTBYKf2t+1n0Yl34O6h30NNpgLWpPA=;
X-ME-Sender: <xms:xqLEasX0gSczvQIJDhNQ4DlZMMfb1prIq0MkgsxWWk2yPKXxy75iTQ>
    <xme:xqLEamnVbejCYJg410jjWs-Qdk_wrtcmPfQw1iyy6K0nHT5GveyfK6D_8IhKRzkhf
    UXXekC01zSnm6sqLHRAruJ9tcy3tgX8JdjyiFZ9sJMJww1qewD5AJM>
X-ME-Received: <xmr:xqLEauAplaP3Jvwq_1Mua2-JOklVGoNgzqv_LMNUmJAK5M-SMm6PLUe9ERFHIG5J>
X-ME-Proxy-Cause: dmFkZTGcs1wepfuFWTMHRlCjqVb9rCR1hiUFDhxpzshDBapsgmhFQCdO5rbK7kIS54y4V1
    o/Slb/SuWw1U0q9oyYkb0pvG5ZzcXLxVsx3mschDh7U1qS4LMbGCd4vJfWUuPC2oc1LGXD
    uTRJ8Gpvoyh1ksqiPwraLxBZTfpAvfTO4v5YrXOwZ84MoGw9rZCA0CVxHrBNUvJ8oTHM8i
    ESQ/9x79/PNgG1vXMl22wtH4CFrDMT1uxLE75VbUA2W6sf2w1qbrpL8yZNra+CW0Vc4nt4
    1htjJeFid7BAeJIZxGQFly7gbZpOxmQnu8aFxCc7HtHpjGU7JXDvqse9w5D1OpNZqpdKqu
    D7T+giwWeaSqYHGx1/Za+8OnwHRLZ5vzo39uwyOzCzbN+jmQNU1kzkmm34X/pD7t32XSHL
    zz8QcrvoODdae58nAQTe/0Xwys/9V+GrrbEXQs0KQ5/J1asPp5SZHXsE3f7QIyoH7v6Yrh
    YDIyd3q1P1Os5ldi6XRm2pKBTzUJcYrL5vEVQTsWJSTVIrCvJp7CSJ0D3MSZKwsPKXf9Oz
    HMChL5TtBDmEu9y7AMvJuP2aar3X269XCK54V28+S6OLi+Up0W9eCbEVtJZbi3cxP2HTlq
    Y/a6bnFS1fxqfILI609pDxTg8fHdrij8Yznlhh9uNdOqgDdW3lHTnayThkKg
X-ME-Proxy: <xmx:xqLEamddfKx7H5f45ZfswEkGoiYRvTPeg5x58WaIwCvG8kx3YaJNJA>
    <xmx:xqLEapLMmINgMkwo3i3YeEh0tC4L1RZ77qTy0bGSM4g86q_Q9ESmEQ>
    <xmx:xqLEapcxCiB_DxD-RNEcmRSXd0maCkf_Do7SzC5117bGENYA8XRcsg>
    <xmx:xqLEag16rVGSvLgHubUYWd9jQ-Yf_MFgVp1-9CD3_F2qvkfy1mjSnA>
    <xmx:x6LEatlmCF9iUqsdHFqHV_RU5wChjhfu4h_eqCH4BMzQb24c2JkIf-TC>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 03:27:01 -0400 (EDT)
Message-ID: <40c181bbc8e01ae3b4a74b4dc0d82d6a683e10c5.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v3 1/6] ports/linux/guts: Add open_tree wrapper
From: Paul Barker <paul@pbarker.dev>
To: Dmitry Sakhonchik <frezidok1@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
In-Reply-To: <CAP4GjN5Ti1jQT61PSg9oasO_c7pOwyL80Ek6KsQkZ6LTM=rndQ@mail.gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
	 <20260907111843.26746-2-frezidok1@gmail.com>
	 <6307d52fb41715013cddf71e6493373f672f46e2.camel@pbarker.dev>
	 <CAP4GjN5Ti1jQT61PSg9oasO_c7pOwyL80Ek6KsQkZ6LTM=rndQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:15:01 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1.1 
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Oct 2026 07:27:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4991

Hi Dmitry,

Apologies for the slow replies here, we're all busy and pseudo is
under-maintained.

On Mon, 2026-09-21 at 14:12 +0300, Dmitry Sakhonchik wrote:
> =D0=BF=D0=BD, 21 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12=
:28, Paul Barker <paul@pbarker.dev>:
>=20
> > On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> > > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> > >=20
> > > [YOCTO #16379]
> > >=20
> > > OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is
> > outside the common pseudo use case.
> >=20
> > We should at least log an error if OPEN_TREE_CLONE is seen instead of
> > silently ignoring it.
> >=20
> > >=20
> > > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> > > ---
> > >  ports/linux/guts/open_tree.c | 46 ++++++++++++++++++++++++++++++++++=
++
> > >  ports/linux/portdefs.h       |  9 +++++++
> > >  ports/linux/wrapfuncs.in     |  1 +
> > >  3 files changed, 56 insertions(+)
> > >  create mode 100644 ports/linux/guts/open_tree.c
> > >=20
> > > diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tre=
e.c
> > > new file mode 100644
> > > index 0000000..6c2aad9
> > > --- /dev/null
> > > +++ b/ports/linux/guts/open_tree.c
> > > @@ -0,0 +1,46 @@
> > > +/*
> > > + * Copyright (c) 2026 Yocto Project
> > > + * guts/COPYRIGHT for information.
> > > + *
> > > + * SPDX-License-Identifier: LGPL-2.1-only
> > > + *
> > > + * int open_tree(int dirfd, const char *path, unsigned int flags)
> > > + *   int rc =3D -1;
> > > + */
> > > +
> > > +     struct stat64 buf;
> > > +     int save_errno;
> > > +     char *pseudo_path;
> > > +
> > > +     if (real_open_tree) {
> > > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> > open_tree.\n");
> > > +             rc =3D real_open_tree(dirfd, path, flags);
> > > +     } else {
> > > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> > syscall.\n");
> > > +             rc =3D real_syscall(SYS_open_tree, dirfd, path, flags);
> > > +     }
> >=20
> > The commit message or a comment should briefly explain why we need to
> > handle both ways of invoking the real open_tree syscall.
> >=20
> > > +
> > > +     pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, pat=
h, 0);
> >=20
> > This should be after the (rc !=3D -1) conditional, as this call could
> > clobber errno.
> >=20
> > If we use preserve_path=3D1, then the absolute path must go through
> pseudo_root_path before the real open_tree call so that a possible chroot
> is handled correctly.
> So I think these two cases need to be somehow handled separately rather
> than moving pseudo_root_path() entirely below the rc !=3D -1 check.
> By the way, for some reason the openat2 wrapper is ok with the
> pseudo_root_path outside of conditional.

The problem is that the real open_tree() call could set errno if it
fails, and calling pseudo_root_path() after this before returning the
error could overwrite errno. It is safe to call pseudo_root_path()
before calling the real open_tree(), or to only call it if the real
open_tree() call succeeds.

Best regards,

--=20
Paul Barker


