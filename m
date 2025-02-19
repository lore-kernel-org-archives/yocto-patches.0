Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE02C021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 18:04:35 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.29330.1739988269438561676
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Feb 2025 10:04:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y3aFfngB;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439e331cceso109659e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739988267; x=1740593067; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FjoCOpGY9oVzNjewhImaRJQ8Z5ysBcsn2R92OBm88k=;
        b=Y3aFfngBhW+TwXobK8wYyr7INTV07Qbmg8UYpsn7Az3KE31TdIRuXk7rhX+bWdhQsE
         6wJMqiqmY4vL/0zZauCE6i3aJJo9Bib195M/rAGfjKuo00GUK3lowK4HAohrtB0Ggpgv
         MY81SAFxz0j01aY3gp8fg+Mlc2yfiwhbxQeTCvhYFBU1Ruk6X8SDNNPLwfyTyAR0nnuE
         +da1qida2UDdO+fX8vRh5RwRh+5dBhPb8m4B6q3+wfuYginFGb4Y0mikH86xSnh7Cj72
         Xm6v62GsbUYbdVHp9aavzpiNYLZUnt0VW3Ps4RtiGC8ELBS7vBSk20H8fZPtsAlxHZDf
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988267; x=1740593067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FjoCOpGY9oVzNjewhImaRJQ8Z5ysBcsn2R92OBm88k=;
        b=A+fxVBpidO1m12PrtEPZvd5TsckefOEVi7RI1a8vqRLonecDx7kTZAVpszLYr81otE
         yQPFLA9iZ2o+Hgam61j6CRrqKMDOms40jPg/IPKf2KLTpwzdR1HP81pqSsFylR35UpsC
         7JMdkR2eaexFABYY7/00sJ++loTS09SIwRVqH2HhtHa6hS1LujD9Ivhgu65+z7S78lw2
         XJLkGkdaKe+KUAfYYCYVXtlgrqy9JIO9jPGNo/pkAHN+FWf3T77aVXL3EsLbIulhcIC+
         yAsO1O77QU/hdny25U454bAjEC2bwlJucQO1V9uLCruO28KZncaCnubFdfdsgJkmF5om
         r5Ag==
X-Gm-Message-State: AOJu0YxiB0aJPa+m+KaQ0lcy1f5a2rGeYngm60aX9ir/EfFS2q0ytU9g
	oDrKzHL1ccm+DcXzak2i0T7Xt6S3KUHoY6WOlJlqjcx7fF2SgASPnNNfBwy1LES7Qi8CdBIbahe
	8pndvAHvGqQMHdKMJLsbpoz6DE6U=
X-Gm-Gg: ASbGncs3Q1PrEErupHH0aiJInPhPb6uRiHNjGn43WXVS06NSj4OJY9NwzaDWdJlURUc
	gaJXno8jGKwEKpLmeJDH+R3SQv33qgAPk2K4mDx+nOhHiCWxoy/jHXuQMVzLx6hl64GP5gpR5
X-Google-Smtp-Source: AGHT+IES9+rlTK4eJwAj/I7GI4QQzxWIi1INNQqsJhoPcEETgKwAz5VUQMAQS39CZ5acFrKzKuWc+Zhh4U1sBHm9Rcs=
X-Received: by 2002:a05:6512:3b07:b0:544:1156:a9d with SMTP id
 2adb3069b0e04-5462eee4d22mr1935602e87.22.1739988266911; Wed, 19 Feb 2025
 10:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20250213190424.1873927-1-peter.marko@siemens.com> <AS1PR10MB5697639AC70EB51E87E51514FDC52@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB5697639AC70EB51E87E51514FDC52@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 19 Feb 2025 11:04:13 -0700
X-Gm-Features: AWEUYZmNDPwse2bed5fQrEMWrj92sbh6dOvjbMXwyax7E-AUu-tXvSXUmsaUHqY
Message-ID: <CAJdd5GaxRox1y4eKO20DGeGVWnRHgdhkm-LnCui3z9PwbwhG1g@mail.gmail.com>
Subject: Re: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2 dependency
To: "Marko, Peter" <Peter.Marko@siemens.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 18:04:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1094

Sorry, I had forgotten to subscribe to this mailing list when it
switched over. This patch is now in master-next

On Wed, Feb 19, 2025 at 11:02=E2=80=AFAM Marko, Peter <Peter.Marko@siemens.=
com> wrote:
>
> I guess I forgot to cc Joshua as described in layer README.
> So adding a ping here.
>
> Peter
>
> > -----Original Message-----
> > From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Sent: Thursday, February 13, 2025 20:04
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Subject: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2
> > dependency
> >
> > From: Peter Marko <peter.marko@siemens.com>
> >
> > This was removed in
> > https://git.openembedded.org/meta-
> > openembedded/commit/?id=3D83c6dfcce6c334d9e699858614e902f2a5a41e20
> >
> > Signed-off-by: Peter Marko <peter.marko@siemens.com>
> > ---
> >  .../openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend  | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/dynamic-layers/openembedded-layers/recipes-
> > devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layers/reci=
pes-
> > devtools/grpc/grpc_%.bbappend
> > index dc0ea42..a72496d 100644
> > --- a/dynamic-layers/openembedded-layers/recipes-
> > devtools/grpc/grpc_%.bbappend
> > +++ b/dynamic-layers/openembedded-layers/recipes-
> > devtools/grpc/grpc_%.bbappend
> > @@ -1,5 +1,2 @@
> > -# doesn't build and not required
> > -DEPENDS:remove:mingw32 =3D "libnsl2"
> > -
> >  EXTRA_OECMAKE:remove:mingw32 =3D "-DBUILD_SHARED_LIBS=3DON"
> >  EXTRA_OECMAKE:append:mingw32 =3D " -DBUILD_SHARED_LIBS=3DOFF"

