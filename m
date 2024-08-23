Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D251FC531DC
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 13:18:32 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.15894.1724419107285356272
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 06:18:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UQ8jFPB4;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5da686531d3so1431204eaf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419106; x=1725023906; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9tW2T+6If49/E1nzatXaP15A2BFZHXhCZ8tnlc3FgI=;
        b=UQ8jFPB4KngZw3owHah5eBDOfbCiOvi/EPf8p+Gr2yyLHDgu6KzNt29LodqKBMkbLc
         Wy2FcFlgEW3q9uNZvXj8LpXyMpt4ZHy3OafbHP+7d6gyu/OUIAvQk1rEOIBp8MM27kjm
         RRXbkuq5jdcTfWaMmQQ1qmHV/HLTDPTyu77dZvA6BpXd2i5sR4IExVcR8KTxVOjjzaZf
         7tYxDGSAyUweHW6j/CdWUXdP7wx/+fLn+qW9fbmLKVW5zIhVldNxOl5qxVZC+1bS0i/9
         eUlJQ9Z5VlBaQRrG6q8YqgewkhErioUYhIqtwHrbELX+lGmreWJhcbrW92wDwclTXLOs
         hznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419106; x=1725023906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9tW2T+6If49/E1nzatXaP15A2BFZHXhCZ8tnlc3FgI=;
        b=OreFRm1GQ7Ypmg7U2RdMl685vQL8zX9ZoAlrpLj4H2PYTD/bf1rpMY+ZqwM476E0Bo
         V93kpPPQmgmTkFEDkzhmxxijyTHyWvOVWvtuoGNKC0hoZ3ZRtoS3yzjQLsYkFGHb+INg
         4s0a0Kneh5JhrqUqN4rZjFdwoK4Q9/9F5dWv0SF1gRzl/E9Is1GlLpGMXztKz8EBvc/W
         LP53b8HyeiII8v46Nj1L0D6wLsjZ9ZvrwHnt5gfW44Vpr4LONlJGctZnKMMQ9bi3uKxL
         /8UsExgNxJ+6VuIsFsGj2hWUpycPVtUJU5V1eNEegiQD79+rGrlk4WpBT2+A63aVxO6V
         yTJg==
X-Gm-Message-State: AOJu0YwckGzORvR8QCJzEhQISa59z+17iBF+DZuk8VUBbYxP4kc5nIuj
	FU8wiACsj+t1tw9RhWDFCKC16pc+CkNQ+P5HCC/OidLbd68+6AmDIp+fWoTRVa4RhM2DKdvJXf1
	ILQwcnvN3BCmZY5+2MJolFH31aUc=
X-Google-Smtp-Source: AGHT+IHlRzUXEYTizCiEsZGKkkdyPOoJFq0Mno0LiAPhXFCZJXYntROoP+qNUhpX98BOcshnER+rXg9DXIzZWf7LTOE=
X-Received: by 2002:a05:6820:22a3:b0:5da:9204:6736 with SMTP id
 006d021491bc7-5dcc632b56bmr2478883eaf.6.1724419106503; Fri, 23 Aug 2024
 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240823131438.1539692-1-raj.khem@gmail.com> <88170668-0528-4faa-a727-73777e91a8ce@cherry.de>
In-Reply-To: <88170668-0528-4faa-a727-73777e91a8ce@cherry.de>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 23 Aug 2024 06:18:00 -0700
Message-ID: <CAMKF1sqE9UFyAJ+xVqMfbyu0tAOSYf6qAo_iakxipmZJPkyEkw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: Rename bbappend to
 match oe-core
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org, twoerner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 13:18:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/556

On Fri, Aug 23, 2024 at 6:17=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Khem,
>
> On 8/23/24 3:14 PM, Khem Raj via lists.yoctoproject.org wrote:
> > OE-core dropped _git from mesa recipe name
> >
>
> There's already another patch posted on the ML, c.f.
> https://lore.kernel.org/yocto-patches/20240823123253.3562592-1-martin.jan=
sa@gmail.com/T/#u
>

cool. discard this then

> Thanks!
> Quentin

