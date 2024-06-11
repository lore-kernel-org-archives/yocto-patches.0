Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A17C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 15:01:37 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.11973.1718118092077624405
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 08:01:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ha6TccCC;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so8575125ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718118091; x=1718722891; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RkaJQoHAHfVwYu+LArduSIkL95qdmY1j5zpbiUWXmM=;
        b=Ha6TccCCEo6flUeznn5gBfwj9L0fs9yihAvUNWYyvIj9oXFj7ji+MDYx8O65CDIKox
         1tqJc8eOlYTsKA6wu95r/ta3v3NMGA6/BMRnsO5Bt6BwWbiW4Vq3FuaD0E66Vhci232D
         AKqDMcBWVSinPXE4yrJlIiUqvag4VqKe2+b6F2/oXIq6DVA9pSTIndQER+swsxhbKhAj
         mtyCrpBY+iqlcsOGNzTHucMBsc6OCLTp71dNsXUPlsP+swZCO935noJnakNrKTTo/fVv
         amPVC8Ks0V4IyJd4j5ulYXQv+Dy82hgZrXHExGx6Bo4cIwn7ZgkKACuf1JMSQ4/QNXpq
         /XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118091; x=1718722891;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RkaJQoHAHfVwYu+LArduSIkL95qdmY1j5zpbiUWXmM=;
        b=OMNqlXSvbgsM73hJHj0soWhZbGkj/FCjRf1O1iLWEIJxR6XizcFtMQThPdbN9CKd3C
         WGPG18XgLOROvmWWOvVGatZVUimOXHWDCChhzQ+YSSa7W2sou4Ry4wAm4D/kJwzGH1pH
         igGf+CVAxRfBG6Ykn/65EOvWDp4+n7dO6WmDZrWePaigXnLPItETq1S/e/5HiQg5KimR
         fUbocj8EOONIGoq79TZQnYAxBj9SVk1KyYtU4icpEpLUEkWnELDRYisj5z7D/vTpcvL/
         JTAXomQHXCMrLUgDBu6Hr7PQYqAO64JS8iRRHhfn8+pvQKXpYNX1WrEpKdqPimANxdeP
         OpBA==
X-Gm-Message-State: AOJu0YztsV4DZilzJ1BxNc7dIirKmiPk2zNIhI3I6Tch+B7HX0HDkV2O
	ytZMW09obEC/sMDqofuP9UIO9mEQaThEKWb2kASXOpPT75ry7n0Wzei4kF43yRCbvKFzfEMWPMe
	nL8RBmavYap3ZisiupZ4nAI+oP067J707
X-Google-Smtp-Source: AGHT+IHre5NfeHDhEsG2ztvUEH+njkJZC4m7paxJ4W6alDm9sc6Gn3vEM1t73w3oLMIAr+RDacsrdt9bq4tNUbeAFbk=
X-Received: by 2002:a17:90a:684a:b0:2c2:5f25:5490 with SMTP id
 98e67ed59e1d1-2c2bcc6cd65mr13140617a91.34.1718118090416; Tue, 11 Jun 2024
 08:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240611140607.2719-1-twoerner@gmail.com> <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
In-Reply-To: <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Tue, 11 Jun 2024 11:01:20 -0400
Message-ID: <CADkTA4N6vr-CwmAGX9JATaiCZ+OxprTYp=t=cjG8iX4roiFYQA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 15:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/303

On Tue, Jun 11, 2024 at 10:29=E2=80=AFAM Quentin Schulz via
lists.yoctoproject.org
<quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
>
> Hi Trevor,
>
> On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The linux-yocto-dev build was failing with:
> >       | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was=
 exported
> >
> > Disabling some filesystem-related security options fixes the build.
> >
>
> Is this the case for every board, including non-Rockchip ones?
>
> Is Bruce aware of those issues? Shouldn't this rather be fixed in
> oe-core instead?

Ross had mentioned something like this a week or so ago,
but I haven't seen it locally yet.

It's an aufs6 export that is causing the issue, I'm looking into
it now.

Preferably I need to reproduce it on the qemuarm machines,
so I can be sure of the fix.

Bruce

>
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   recipes-kernel/linux/linux-yocto-dev.bbappend                | 1 +
> >   .../linux/linux-yocto-dev/disable-some-fs-security.cfg       | 5 ++++=
+
> >   2 files changed, 6 insertions(+)
> >   create mode 100644 recipes-kernel/linux/linux-yocto-dev/disable-some-=
fs-security.cfg
> >
> > diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-ke=
rnel/linux/linux-yocto-dev.bbappend
> > index b6a63d7b7b29..94bf737c63bd 100644
> > --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> > +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > @@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend :=3D "${THISDIR}/${PN}:"
> >
> >   COMPATIBLE_MACHINE:orangepi-5-plus =3D "orangepi-5-plus"
> >
> > +SRC_URI:append =3D " file://disable-some-fs-security.cfg"
>
> If it is Rockchip-specific, I would suggest using
> SRC_URI:append:rockchip here, to make sure we do not modify other
> machines from other layers whenever meta-rockchip is included?
>
> Cheers,
> Quentin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#300): https://lists.yoctoproject.org/g/yocto-patches/=
message/300
> Mute This Topic: https://lists.yoctoproject.org/mt/106613842/1050810
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317149=
3/1050810/607820704/xyzzy [bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

