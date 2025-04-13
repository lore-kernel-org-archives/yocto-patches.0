Return-Path: <schonm@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7711FC3601E
	for <webhook@archiver.kernel.org>; Sun, 13 Apr 2025 12:46:05 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web10.27970.1744548364676842246
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Apr 2025 05:46:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XXv3EWif;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: schonm@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c1caacc1f7so2041950fac.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744548364; x=1745153164; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/TATTVohzX29CKLfMk6LFLBP2JfL18W8LG9ds5KWIE=;
        b=XXv3EWifpUr82G2qyKekYvvwt9rcEnbsUqjb1c72Pum+N6R6NVnalgl7OrGMWepknR
         T/emORCgdgIj5wQgoAz+WywFk8fmpIV/TOsvwjJTgFou9t9/q08TUPjr6pM79uMUW+RS
         hv+ANPTMEc7au9PswYdASoNNGIvXEz1MZA1390P7Sqc+eBYqSXQXZkjQhcSOxrxKjO4t
         USKR8qeAErkvnTZDypsmKMBt42ViHbiLGRGg/ckxwEc2Nr353dyknHshSYP7R90Et07R
         asNM2qDNhQ58cRLMeM4HGvTsdm/tBcOeeKnCfVi+YzzpUD+QsfsePkJwXG8eWjC2jYNX
         UPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744548364; x=1745153164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/TATTVohzX29CKLfMk6LFLBP2JfL18W8LG9ds5KWIE=;
        b=DITa4DFUAhHfMEyK1ehD77UOxVG/3973Eucytcb8ZcI2yE8WFrEMp7gREMC/nR32oY
         8Tt2ehIVWZPcHalyVoWBExI/aFWGgELTX58mBi/PN61EcuKW7zdQq7FhM/9kjT+H2CYY
         JqJDCvpvBmoP4xlN84DM/gd3oa+iK6vG3zSyZRBhy9CBuJas3Fg31PXFoI6SkJWgAFB5
         9p4nbOKXLp7WS3wroq/gukK2Vx80Oaub3hD98BDTurWI6HIrJ/S8KB4h06oDgGB+N9bg
         BUySqAhADlQIkp+yQmoqN+aSavKDVRrZnKBxaLBSEYvGDJ2e4AAKBEd5QW/nvc8Ib5FK
         FNTA==
X-Gm-Message-State: AOJu0YwPQSBa99UMto/wfRIVZNg6HZURe4N2mMSaCi3+TN+Fi+HIssjx
	SVaXE3XRdMwDnLe7tyLXdpnQBcgXUORr6iw9NmdhxqJ6WKkVKYkWq7R/XYQrUN8OvFU5ehlVSrD
	oBYRdq2NwhMLfYi+Dqo3SNoUl+YY=
X-Gm-Gg: ASbGncsQNM+U04BDrgwyasXCBvI5EKtiYg8WRtCahWN88j9DCVQ9NoclTTZ/g4JTD3p
	Xsgnc/8EuLwuG0UGcn91Cohzq3BYixaxJ4QyKFSryM32focHjl36IJ1SNPy/3BnOysQ2si9f3bz
	+IVMCeekh6eFXeTcPMq1o=
X-Google-Smtp-Source: AGHT+IH1WnfMTBtLGn6xxMKsE119PBJV1cHRmBBOxy+av4NhRU6HEdCfZKQudA9B1pZPJbDcEVcRV+dhwgvaNh4kq+8=
X-Received: by 2002:a05:6871:a582:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2d0d5efba95mr4899390fac.25.1744548363543; Sun, 13 Apr 2025
 05:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250412172641.1632340-1-schonm@gmail.com> <08f5f7fa-60e4-49ee-8a72-0febeb735721@gmail.com>
In-Reply-To: <08f5f7fa-60e4-49ee-8a72-0febeb735721@gmail.com>
From: "J. S." <schonm@gmail.com>
Date: Sun, 13 Apr 2025 08:45:52 -0400
X-Gm-Features: ATxdqUHWy5lxkmF6Qqu6kQJyYtgHtD4xj8x6MMnxcKjxwzRclWdYOZ3S3R1zxXM
Message-ID: <CABTo8gAkC-UQNFAYZ=4iUKNyvz+YtT_zWD=jRXN-dDENB_cm2g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] Fix warning : lack of
 whitespace around assignment
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 12:46:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1365

I've sent a v2 with your suggested changes.

Thanks,
Jason Schonberg

On Sun, Apr 13, 2025 at 8:02=E2=80=AFAM Gyorgy Sarvari <skandigraun@gmail.c=
om> wrote:
>
> It's not really about this specific change, just 2 typos I noticed while
> skimming it through... if you don't feel like doing a v2 for this, I
> understand.
>
> On 4/12/25 19:25, J. S. via lists.yoctoproject.org wrote:
> > diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs=
-tools/ccs-tools_1.8.9.bb
> > index a746c56..d9d80fb 100644
> > --- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> > +++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> > @@ -26,7 +26,7 @@ do_install(){
> >      oe_runmake INSTALLDIR=3D${D}  USRLIBDIR=3D${libdir} SBINDIR=3D${sb=
indir} install
> >  }
> >
> > -PACKAGE=3D"${PN} ${PN}-dbg ${PN}-doc"
> > +PACKAGE =3D "${PN} ${PN}-dbg ${PN}-doc"
> I think this should be "PACKAGES".
> >  FILES:${PN} =3D "\
> >      ${sbindir}/* \
> > @@ -46,4 +46,4 @@ FILES:${PN}-dbg =3D "\
> >      /usr/src/debug/* \
> >  "
> >
> > -REQUIRED_DISTRO_FEATURES ?=3D" tomoyo"
> > +REQUIRED_DISTRO_FEATURES ?=3D " tomoyo"
> ...
> > diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-secu=
rity/sshguard/sshguard_2.4.3.bb
> > index 37b414e..5380c74 100644
> > --- a/recipes-security/sshguard/sshguard_2.4.3.bb
> > +++ b/recipes-security/sshguard/sshguard_2.4.3.bb
> > @@ -1,10 +1,10 @@
> > -SUMARRY=3D" Intelligently block brute-force attacks by aggregating sys=
tem logs "
> > +SUMARRY =3D " Intelligently block brute-force attacks by aggregating s=
ystem logs "
> Typo in SUMMARY
> >  HOMEPAGE =3D "https://www.sshguard.net/"
> >  LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D47a33fc98cd20713882c4d822a5=
7bf4d"
> >  LICENSE =3D "BSD-1-Clause"
> >
> >
> > -SRC_URI=3D"https://sourceforge.net/projects/sshguard/files/sshguard/${=
PV}/sshguard-${PV}.tar.gz"
> > +SRC_URI =3D "https://sourceforge.net/projects/sshguard/files/sshguard/=
${PV}/sshguard-${PV}.tar.gz"
> >
> >  SRC_URI[sha256sum] =3D "64029deff6de90fdeefb1f497d414f0e4045076693a91d=
a1a70eb7595e97efeb"
> >

