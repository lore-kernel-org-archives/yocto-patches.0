Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF8C369CB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 06:48:05 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.11077.1745909280963554355
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 23:48:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OgFKvopa;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54acc0cd458so6775593e87.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 23:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909279; x=1746514079; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdO0N4Cilxdfe/r619Lf4weZ6AYuzKYy+Ablyz0Vu6Q=;
        b=OgFKvopaqKmU+hVrD37Duj3UMsnr7UhLohQBzXX5xmWShNmI8KEb5/XecC66tt8SG8
         XSdxzK+3CAvKiqYXYb/IaY5ztP8oXy1Sd9pGj4edN59r4ETWZ0XiPwvh+Tu4NkDeT9Xe
         etWZID/aJb0szZSVTVQ8EgOtbd/2oRpaEcnHzcvP6/6wp3dpGYism0NQoCH+CgOH0hVI
         yE5h//oE1et9wLga14tEE0OZs0QlYpzXFVdePw3CDtdXHekXcm7AZi1k163B8lEgSEo2
         8stEuztXW74CfHwbp+mOBj7IEcnPXloPZZ26EKqE/eD6BQw5YOADornaK5LS8YxJnqtU
         IozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909279; x=1746514079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdO0N4Cilxdfe/r619Lf4weZ6AYuzKYy+Ablyz0Vu6Q=;
        b=ry8MhDgxAKk9riwU16Z5+b6k4UQDG5fASgG02Jc3PArvOSNhQAOoAcr0MsTZ2M5lPm
         Bn/+B25hEjeyDjCMGwF+zEYC/FZfZO2FDqxNOhE67fNjnWK5JT3jtu7vPzDlmNBsMRjS
         yIrS7LNOTZnAA2ctH5vTIA0+6mCz1coB7vlXdBh9k5YKLPEige82hqvowHArkIyoFasH
         ugxUUO2GSi5Gq6RyWHnlVe6Z0w5yq/NAz2uKTXwa2URVUHyOR6oijPLLDFz4Qa/j37il
         ThdnIRapnJRbvA/5FxUB3bA0RfkcxzL95skhyA8jsiWQhGnyw1PbUhrPgbXHi/jTc4wP
         Y7+Q==
X-Gm-Message-State: AOJu0YzxHC6tMrGoa29FrzAjy8xEpZLwLTjOX41LjA85DFbOcAPGLhn8
	g1hE4JG8n+bU9J2mhnQesPBp6YFH5XisnSHI7fa4XjhuM68lf/Ay9ix4ksv84m6+ljNVv/Zz68H
	7BytDsaVw16fjNu33i0YcJzcKhlc=
X-Gm-Gg: ASbGnctmGv70SC3MS6jBekLJe1TXF2hHv6YhExh77XZjR3p4Wr4WocIkYQtsNpxl+4L
	M80uZlBYCYXZyblumehiR5HxI53/1ampntZnQRdsJG5DW5zzlzzSbpBDnbA2AlRK6RLMSg3IbuS
	/VHWapyNEeAFp1ip5dA+1KwOFv
X-Google-Smtp-Source: AGHT+IF5WRC0w1YT9gWK2VCQXbke5CIRupdudSL1ypuDtBuSQ5y6StZ3BxHZv04cbMXqj2mlyljrpHpPpnGst2Idp2I=
X-Received: by 2002:a05:6512:124e:b0:54b:f33:cc16 with SMTP id
 2adb3069b0e04-54e9e53d33dmr384148e87.16.1745909278763; Mon, 28 Apr 2025
 23:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250429021622.309740-1-hieu2.nguyen@lge.com> <D9IWYS89PR2K.3BQ97RPTUB3UR@bootlin.com>
In-Reply-To: <D9IWYS89PR2K.3BQ97RPTUB3UR@bootlin.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 29 Apr 2025 08:47:47 +0200
X-Gm-Features: ATxdqUEzKuu4DmEtyk4oGtTmTy_ymIxuqS3mCDGKBSLkYg2vaVs0aP95slFbwyI
Message-ID: <CA+chaQcOT+oRpoDSDXxfQutAeR2m4OO0YzYK08iPevbY36+wnA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] schedulers: add
 meta-webosose scheduled build for scarthgap
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: yocto-patches@lists.yoctoproject.org, 
	Hieu Van Nguyen <hieu2.nguyen@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 06:48:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1416

On Tue, Apr 29, 2025 at 8:37=E2=80=AFAM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> On Tue Apr 29, 2025 at 4:16 AM CEST, Hieu Van Nguyen via lists.yoctoproje=
ct.org wrote:
> > From: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> >
> > Support to build meta-webosose for both of kirkstone and scarthgap
> > branches.
> >
> > Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
> > ---
> >  schedulers.py | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/schedulers.py b/schedulers.py
> > index fd2cad6..1fead60 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -642,7 +642,10 @@ schedulers.append(sched.AnyBranchScheduler(name=3D=
"bitbake-docs-changed",
> >              properties=3Drepos_dict_for_scheduler("docs"),
> >              builderNames=3D["docs"]))
> >
> > -# Run meta-webosose for kirkstone once a week on weekends (2am on Frid=
ay)
> > +# Run meta-webosose for kirkstone and scarthgap once a week on weekend=
s (2am on Friday)
> >  schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=
=3D'kirkstone', properties=3Dparent_default_props('meta-webosose', 'kirksto=
ne'),
> >                                  codebases =3D {'' : {'branch' : 'kirks=
tone'}},
> >                                  builderNames=3D['meta-webosose'], hour=
=3D2, minute=3D0, dayOfWeek=3D4))
> > +schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=
=3D'scarthgap', properties=3Dparent_default_props('meta-webosose', 'scarthg=
ap'),
> > +                                codebases =3D {'' : {'branch' : 'scart=
hgap'}},
> > +                                builderNames=3D['meta-webosose'], hour=
=3D2, minute=3D0, dayOfWeek=3D4))
>
> Hi Hieu,
>
> IIRC in your previous version you also had changes about meta-qt6
> versions. Are these changes not needed anymore?

Maybe you mean this commit:
https://web.git.yoctoproject.org/yocto-autobuilder2/commit/?id=3D21b5aa780e=
a79c32b340d53aaef808520983b88b
which was already merged and the same version should be used for both
kirkstone and scarthgap based builds.

Cheers,

