Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2023AE6F074
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 17:42:14 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.310.1730482931736062947
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Nov 2024 10:42:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H11eGeq3;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: raj.khem@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71811aba576so1746198a34.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730482931; x=1731087731; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d87QCpAdzYPYBXBEeHeO5mh1B6kMbS9ok90fAx6i8PQ=;
        b=H11eGeq3dIaaeegCAPWdBXpfogQhHHRsT/qvuqUvLi1sJoWcnoMvxfgJIrYuAUUr3x
         74ZD+N+BVbXKDCoe0/bkxo6TPunxn47DX9IaS3RSx4zHsToyYvXk7B3vSl1Xq36/JFxU
         WpfQB4p/xT+1Kd1cUoonpSkkQxi7r3Z/tuPY09GuVYQkwNe0gbeK9WYzmrgVYyoXW78U
         rIHIWok+kjWpQ900OBkHuYSBtiy880QmoRhux20lTma1HcaAWbzNtnwYdCRzUIeOKwmE
         0wO61utkylFIV848t4AF/GKsAvIRYjokKMGzgAo+osxlNKvivtgWZxf6l9cQRZ+e7mS0
         piyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482931; x=1731087731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d87QCpAdzYPYBXBEeHeO5mh1B6kMbS9ok90fAx6i8PQ=;
        b=dlcVyuw1b/HsoJ1w1QrUw6VEhMv0bGjhImQVFYSShb9Km+tyhdhTAJx0eQVWRsQZYU
         wqQVpn7PUogBNGAl72knISwrf7dvbl9jWa5Y3NJN7gGrYZIKCloX/6542mmhUovdTxc8
         BlBkiVlN6fKaD4hKTH4nR07kP9TeeGiJQJ5u993apaBktENJEiHX58MEi3vVE+Jj/x0R
         m+kD4EQhHtpIAlZZZ6Z9ZZmbItNUtiYxxg/21LQPxMG6xvoAUKxyWhWkbTALCJdXBndp
         hFNrwtIp1ah84Q0myPdB4r2v2nciEPPgZjvTJRp28+cXMj4A0nPGPT9BvgEnIyES/rDk
         eZGQ==
X-Gm-Message-State: AOJu0YwrH+4WENkUBbwzWM/v+Ro9Mp9lnvkfmOW6lvaJkkfobuSXDOEq
	Jl5pgadqKv8GH0woXxS7nU9XdaAzdp9xTQANYLQtqa5peL2S76XVw5mUzIcRu9ZPV0442TGnSTM
	1gwohSxp2e0e4ERablqMIDGACwZw=
X-Google-Smtp-Source: AGHT+IE3FDaNp8ru/5F96rawk3fQJVVkAjamM6rxbkepa8q7XQxfUTZnqwNUb9DCnKZY5Dk4IK2ceJ/7le5YAepoJcg=
X-Received: by 2002:a05:6808:4c01:b0:3e7:6174:a9c8 with SMTP id
 5614622812f47-3e76174aaf0mr783911b6e.7.1730482930813; Fri, 01 Nov 2024
 10:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com> <CA+chaQex3k7a1ksiDUGYU-We0KYRP4apaV5WiPSVy5+1ZGgS5w@mail.gmail.com>
In-Reply-To: <CA+chaQex3k7a1ksiDUGYU-We0KYRP4apaV5WiPSVy5+1ZGgS5w@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 1 Nov 2024 10:41:43 -0700
Message-ID: <CAMKF1sor1UBoFpmQfc3JjuoGDQanBnLCt_ncWo-12K02UXhTLQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/clang][RFC]
 kirkstone/clang branch proposal
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com, 
	peter.marko@siemens.com, max@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 17:42:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/786

On Fri, Nov 1, 2024 at 10:40=E2=80=AFAM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> Hi,
>
> it might be more visible as a branch in meta-clang as previous
> multiple clang versions for the same yocto release were as well, e.g.:
> https://github.com/kraj/meta-clang/tree/dunfell-clang14
> https://github.com/kraj/meta-clang/tree/dunfell-clang12
> https://github.com/kraj/meta-clang/tree/kirkstone-clang12
>
> if Khem doesn't mind having another branch for kirkstone there, then I
> would prefer kirkstone-clang18 in meta-clang instead of
> meta-lts-mixins

Yeah I am ok with another branch in meta-clang.

>
> Cheers,
>
>
> On Fri, Nov 1, 2024 at 5:27=E2=80=AFPM Ariel D'Alessandro via
> lists.yoctoproject.org
> <ariel.dalessandro=3Dcollabora.com@lists.yoctoproject.org> wrote:
> >
> > Hi all meta-lts-mixins people,
> >
> > We're currently working on getting `meta-browser` chromium support bump
> > to version `129.` on kirkstone [0], which requires `clang 16`.
> >
> > Scarthgap `meta-clang` layer provides clang `18.1.6`, but kirkstone LTS
> > branches do not accept major version updates [1].
> >
> > Could this be submitted instead to
> > https://git.yoctoproject.org/meta-lts-mixins/ as a new branch
> > `kirkstone/clang`?
> >
> > Thanks in advance!
> > Ariel
> >
> > [0] https://github.com/OSSystems/meta-browser/pull/843
> > [1] https://github.com/kraj/meta-clang/pull/1024#issuecomment-245185150=
7
> >
> > --
> > Ariel D'Alessandro
> > Software Engineer
> >
> > Collabora Ltd.
> > Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> > Registered in England & Wales, no. 5513718
> >
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#783): https://lists.yoctoproject.org/g/yocto-patche=
s/message/783
> > Mute This Topic: https://lists.yoctoproject.org/mt/109337193/3617156
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13388=
836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >

