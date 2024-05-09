Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FE4C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 13:07:40 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.9778.1715260058366561796
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 May 2024 06:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c1O/vJzt;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso640508a91.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260057; x=1715864857; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrPVZOoWmsLQuvpm1rCCt+rNAYfUpOF9hh3ZBQuFsZw=;
        b=c1O/vJztv2BtaDWvl7K/NxpIf2e7WxDcdYZ0FeLWH5wUcrd5JU0gEJ5FGutTRQ4dFM
         l/CQOl6IILl1NVcOZVMWw4e1dHC0nj+giq6ohGI+1Xc8w81308wK8iLfjddZ3odxrq6n
         q/+an+x3u/7bYUMFJevOXU87Litv1VlBdKHPsOj37HYetwYvRoBcYhfaE+GzwElL3uKI
         LtZOwsact0WI5gvCPoBIr5R/pmiBjZKMnKNa0vw5+wvvdquhSidTBIJKbb8lyNmbDImJ
         X9EfaT31t9Hbo577uNICX3u4Yht6kkiJ5Z5q97FqMaySaBj/oMM1jAXSssy2LBgA4Bcr
         rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260057; x=1715864857;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrPVZOoWmsLQuvpm1rCCt+rNAYfUpOF9hh3ZBQuFsZw=;
        b=b9RzrVuCO4Mn3IwL2WwtFEVoBpFHO3lBM1gz7h6vuisWR+j64iElfu0FGPieLo84+x
         Twdm9oAaL3CEXSGf8ytG2GzEWNrmi4KGufsGe3OqN9RLU9hZ7NPVop5RqMDxjozbBSUr
         /YzUnSdv+y2xg8yUBP/CZdkZxBiiPa7CVwdZQ/qssPvyBQSWJELQb/6vbPGzQdWHoLxQ
         iA3+a7doo2B1WnbM5DJNnnwexSuvV/nMsA4zcqhNeFCVN9ANhkcCDL+19pu00uO9GmHD
         R1DJLLB4jfyJkEQHbd2yAPiYzKZU2oU7j4xOA+rqMIgFoipMzCHSGQlXZ9mgzu0NUWW+
         6oEg==
X-Gm-Message-State: AOJu0Yxln/tnlE8g+DCxOEgv8SPsODyOlxYwSdvgYjkQy4wrSa7qUck+
	BBa8Y3up5fZ8I7lYrtKXvgspcJbVoed+SY713IpTNOoN9Ajz85xeQyiX0X4Mv0H+udT5/FdopZv
	z6M0iP+5419pg4qdXDmJAT0Us6EV1Xc5L
X-Google-Smtp-Source: AGHT+IFjHdCmg/g8Tb33FJTm7x3Mwcm0mEtG9opspfRU8X2MsgxOYboGjk1vW5++LWbqbnFYpv/XkcJ0/2Z83sHAcy8=
X-Received: by 2002:a17:90a:b113:b0:2b1:534f:ea09 with SMTP id
 98e67ed59e1d1-2b6166bfd77mr5621021a91.23.1715260057308; Thu, 09 May 2024
 06:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240508070412.2939015-1-mingli.yu@windriver.com> <CAApg2=Rxma2ggie=wQr_ZtZOQ7i_J1_7xzOEOHfrrhBoz8jigw@mail.gmail.com>
In-Reply-To: <CAApg2=Rxma2ggie=wQr_ZtZOQ7i_J1_7xzOEOHfrrhBoz8jigw@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 9 May 2024 09:07:25 -0400
Message-ID: <CADkTA4OAb1ZvtqvxMtPnr=dhE-SDKH7138w=4sjLbrYNMwKPAQ@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 13:07:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/114

On Thu, May 9, 2024 at 9:01=E2=80=AFAM Marta Rybczynska via
lists.yoctoproject.org <rybczynska=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
>
>
> On Wed, May 8, 2024 at 9:04=E2=80=AFAM Yu, Mingli via lists.yoctoproject.=
org <mingli.yu=3Deng.windriver.com@lists.yoctoproject.org> wrote:
>>
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> Userspace functionality that requires BPF is becoming more common,
>> so enable it by default [1].
>>
>> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>
>
> For a big feature (and attack vector) like bpf, I think it would make sen=
se to create a new
> DISTRO_FEATURE or so. People who want bpf can enable it (probably they al=
ready do),
> others do not have a feature they do not need.
>

For the kernel configuration, I'll argue against that. They should be
creating their
own kernel type and re-using the fragments in their own way.

The base kernel configuration, in particular for large features, should not=
 be
conditional and cobbled together with distro features. The kernel
tools themselves
have support for conditional processing, which is where anything
optional/configurable
needs to be, not spread across layers, .bb files, variables, and combinatio=
ns of
conditionals.

Bruce

> PS. Yocto kernel options review is one of the things on my TODO list afte=
r we're done with
> the CVE crisis...
>
> Regards,
> Marta
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#113) | Reply To Group | Reply To Sender | Mute This T=
opic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [bruce.ashfield@gma=
il.com]
>
> _._,_._,_



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

