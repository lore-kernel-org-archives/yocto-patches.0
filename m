Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA481CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:09:14 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.43479.1754899748094250488
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 01:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SSL5UFgS;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b06d162789so47908551cf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899747; x=1755504547; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0eP1Vr+JS9xz01lCiaXqEi2zGsKk57RoKWkIEhRD5M=;
        b=SSL5UFgSq/RtH3Tc8XAtAKhYbEtUtv1J6e9OmoDTbehWD69aHc+kJ92HvAGM710lwi
         NVkA1z8KOonXoCUnr2oQiw/O9f11xJomYMJT0mWPY5Hu2M3/L4ScOBjgE0TBaTpI4eTX
         70tZSYgAJY6KvSYqY696W+d3uArsi5evXSMpFlzV82HhjaVH6HmuxxCNWXejChJO8GyI
         2ZoJ2GItS33GwuLydKA2MrmBvXRWlADoUe1F7fQ46dVZN/7UNxFFg3LnLF0S5TDZ7gvu
         c/1u4TcDF0Dm2XAr6JQmXs86KFABAFHmUz/nvJVlzRIWdyavIg5ZReCRiVqwGQaWSBuV
         DuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899747; x=1755504547;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0eP1Vr+JS9xz01lCiaXqEi2zGsKk57RoKWkIEhRD5M=;
        b=kB4joRvbIGVR7bo/WXQaXFDhMeuQCS5qxByRFRQ4cKPHZ0LrkGsuesgOv5xm0jZLV1
         Q38UnIUlFxPZfHJtC2fvJbpP8/YgeFoXH4DuO6UmSOk8J4JMcH9mOVfC+Motw0pLw5ly
         yykyJ3BtOJSkq4zfyx0KdJQJ54dmPJEWzeHbMa+p23nPpro0cnsx56oXduWbojPSOGVs
         wdVwrQJpE1epOV7nC/D/jXI2PM/SATTgDc/FiELgR0jAXl3+CeVkHVeYA1qg0HO6q81A
         UMXVpiSHAVuuQPxmt2wust1fC8Q9iQWriNg61WGWwv6uPKsBqqNIZTmTAKAWi9mEFDga
         hlDQ==
X-Gm-Message-State: AOJu0YyukNs9Fw1rvniJ88p6EKEmNMtK9/UqPzQZQhpVd9Xho1A5n8lx
	XJ4umoN81UdhICc+d47Exp7hHtE9a36sHPQU9UYtSvGfcBs65duEbFcsG2GZg5C0mdn5V1jlLba
	huszZCCV9rVBSDqQ7W/YWyYvYUXeby4w3fw==
X-Gm-Gg: ASbGncu4153miqn929Uj8cZp+vepy4bJI3qZGUG5NLuJF09Ru/a91DUzyHzvo1l7rM8
	QwxWldPK3LGUCvvSRNq4FDTGZ44wtP2L0umIzxwTaDIKQHhuFPCkqw9cXyrG03sQ8QLJi7AsriM
	SyWAVcuX+FRUlIc9CayfhwQABEIPVPLmPCPmHlfXo4TGFBNYqZwjoDiHuwxLwpEzu3W7b8OTABD
	nYZTQY=
X-Google-Smtp-Source: AGHT+IG+1JQVfN60wctR9/VmknzIgJQk31hGg8VphhsRzaOMuAA26Xt4eM8O9EvgBRNEfs7GBpO9UeZ5aXJBrvCnbZw=
X-Received: by 2002:a05:622a:a953:10b0:4b0:8f21:cd9 with SMTP id
 d75a77b69052e-4b0b81c7c8dmr84050801cf.31.1754899747039; Mon, 11 Aug 2025
 01:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250716031705.110773-1-dixitparmar19@gmail.com> <28147.1754890480235811557@lists.yoctoproject.org>
In-Reply-To: <28147.1754890480235811557@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 11 Aug 2025 10:08:56 +0200
X-Gm-Features: Ac12FXwLVWpvJVuedTtTQ5FP_YUf9LCE0Poo3icfOyu36pFu8HenRwCTV8tf0cc
Message-ID: <CANNYZj_9NKsq=307pN+wiO_1JBFcdwO8aaFai6Xp0b0OUuYq9w@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH v5] [matchbox-panel-2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 08:09:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1926

Ross is on holiday now. This work is massively appreciated, I'll make
sure to poke him if needed :-)

Alex

On Mon, 11 Aug 2025 at 07:34, Dixit Parmar via lists.yoctoproject.org
<dixitparmar19=3Dgmail.com@lists.yoctoproject.org> wrote:
>
> Hi Ross and all,
>
> As it has been almost a month since this new patch version submission, I =
would like to send a gentle reminder to bring this patch to the top of your=
 review list. It's of course not urgent, but an ACK to confirm if it looks =
good or not would be highly appreciated.
>
> Thanks,
> Dixit
>
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#1924) | Reply to Group | Reply to Sender | Mute This =
Topic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [alex.kanavin@gmail=
.com]
>
> _._,_._,_

