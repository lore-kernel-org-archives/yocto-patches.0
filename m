Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C5AE6F073
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 17:40:14 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.270.1730482808719947144
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Nov 2024 10:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=emocOdst;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so22513851fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730482807; x=1731087607; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ypw5JJoTjNyK9FMe5EFWjstIrTQElLZ0V9g6VuYaHE=;
        b=emocOdstMcwfc7fEREVbnMgpIRyg/EU+enrxwMv6e98UQfLukeO6LjGanw/vgJrQB4
         rRNOchCq2NVkJaD9TbvCOkuNEcOMQ6mrWxt+2sJFkHCdcXGqt2d+wM/G+lxOOneiuZt6
         69Mc6+6Ta+Km5xx1fm+IUVPlfMQpNYYv5TPoGxRPcvJz7MFe+MxxbaYmJvdZ6Ov/xX9v
         ZFc9TNJQG8Nf9ITkPYNXpHqd/R8SXESszZOJ6uMEzDFlMvYfKs0EHLIUaxcBPsyKfw8v
         gr7/OkEU97APAvN+G2qDPPZ3t2BzWjBmg+99wIT4EOn+LbEjYatdhaGJ6H+BUg40ekxc
         2AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482807; x=1731087607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ypw5JJoTjNyK9FMe5EFWjstIrTQElLZ0V9g6VuYaHE=;
        b=t//iscvSe5EU70suFA3HpQAuBNkjbsTYpCbM0N/PprxWIzEePHmBg/9IWJaQxRCEcH
         J1IeN8Ww9ZX7S0fQN+TSw4YvuQCnCg9Hhwegt6N1rzg9snV4pLt/lRaaYrZAym3FRaYw
         y2z8jDvUepK3TE3rw7jwBufxJT7rAEgZKKwLaWqC+PoXbUhwLjThszg6TTPqTpdmeX1b
         pW+RBczIZlUVRr4TqIEJABeaDjVq08eBOYuIIagx7/ti7X2KxV9xxA9zkXG7X4jqD5r3
         hRCemc7xRXH4CE2JHvNstxL5pXtXRIwzBqTqifKIUfwWij68mAumRK7sqgv9PkvSjyyg
         MQ1w==
X-Gm-Message-State: AOJu0YzjPPdSPv5iH33eoCPIKgkw4e6RxnLKk6ZT0E01F/vRYKqiveAp
	GRmjBHZZxl8n8ghZM0JMWYZzJyS8/uKU2VyoRe0GWeffz88g/2fANdWsllGyodCpYEJ774r1RWG
	2pLl7UKk+aXvvJbQ1aBFjBQ6Pkhp4xnB+
X-Google-Smtp-Source: AGHT+IFrNRGSNbU0jDJH9MiptKFH4rwq1jGoozMRC6JIsTZdsYsGapc1Twr+tltQ4EFfrvaGKmDhWvOMyDSP2yDC0EI=
X-Received: by 2002:a05:651c:548:b0:2fb:4c5c:3f7d with SMTP id
 38308e7fff4ca-2fd058fc750mr71178481fa.5.1730482806585; Fri, 01 Nov 2024
 10:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
In-Reply-To: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 1 Nov 2024 18:39:50 +0100
Message-ID: <CA+chaQex3k7a1ksiDUGYU-We0KYRP4apaV5WiPSVy5+1ZGgS5w@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/clang][RFC]
 kirkstone/clang branch proposal
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, peter.marko@siemens.com, raj.khem@gmail.com, 
	max@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 17:40:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/785

Hi,

it might be more visible as a branch in meta-clang as previous
multiple clang versions for the same yocto release were as well, e.g.:
https://github.com/kraj/meta-clang/tree/dunfell-clang14
https://github.com/kraj/meta-clang/tree/dunfell-clang12
https://github.com/kraj/meta-clang/tree/kirkstone-clang12

if Khem doesn't mind having another branch for kirkstone there, then I
would prefer kirkstone-clang18 in meta-clang instead of
meta-lts-mixins

Cheers,


On Fri, Nov 1, 2024 at 5:27=E2=80=AFPM Ariel D'Alessandro via
lists.yoctoproject.org
<ariel.dalessandro=3Dcollabora.com@lists.yoctoproject.org> wrote:
>
> Hi all meta-lts-mixins people,
>
> We're currently working on getting `meta-browser` chromium support bump
> to version `129.` on kirkstone [0], which requires `clang 16`.
>
> Scarthgap `meta-clang` layer provides clang `18.1.6`, but kirkstone LTS
> branches do not accept major version updates [1].
>
> Could this be submitted instead to
> https://git.yoctoproject.org/meta-lts-mixins/ as a new branch
> `kirkstone/clang`?
>
> Thanks in advance!
> Ariel
>
> [0] https://github.com/OSSystems/meta-browser/pull/843
> [1] https://github.com/kraj/meta-clang/pull/1024#issuecomment-2451851507
>
> --
> Ariel D'Alessandro
> Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#783): https://lists.yoctoproject.org/g/yocto-patches/=
message/783
> Mute This Topic: https://lists.yoctoproject.org/mt/109337193/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

