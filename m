Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BABCDDE5E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:25:20 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.5656.1729679114890253020
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 03:25:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KUheroh9;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53a097aa3daso6312461e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679113; x=1730283913; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6CYr8fAl+B4ORG9texbWmRTYEPNOeyQn7Q3ja8ht3U=;
        b=KUheroh96+sKfAICIU8QCQxOiXPP/weAuE4UJa9w4uxWwmo2vlujwRU/Tipl8zyFsK
         6Jkrpfu8Y4BfIjVHuJGRQultFHCvO5Z/vX6CUUO0ylvtelED78HDj0r3LRcOmUX7hcm/
         nH6HJ1/q4jDWeHBPJbb8b6z/Ge9MztrzTigAvJCRPEk1Bpoj4MmvsZYD3y4IkVXWYatN
         J+GzH2lJnbLi86ti+W6iux6wxFTPe1fztvXs7VS1MRM7t9dFW9K76PkXJ2n2F7GCOHDr
         uiTW8UlPJRxd4y6lqbtY+hKLKgYukjg44KwPJOiWrPCNFI+mWcWW5iHmdMDV93yBp4PW
         yIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679113; x=1730283913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6CYr8fAl+B4ORG9texbWmRTYEPNOeyQn7Q3ja8ht3U=;
        b=RP0KJpkoxL+CA3NssakpGE9Uzw8k68ZLgkbCy+7MwzsPTtr5Jw3CwZ5l8IguyBquVH
         yFPhAded7hWd2ZorRRhHak/xdENs4v8wpljAtNojURqzEDi1biisKRrZpS8bagYt56a3
         FlIvdlbMiN7wbezYSQcOn82Lt87q/dH9wz/1ycgMg4e6ZXfxCBtwV/v1rgMsuAg4Xqmp
         KIr/JKxV4WYsoIkemEFB/hMQLCWuKYm9dwE7UbGCQo3VJgQaPXR0gcRnAv7dFSPj2ARs
         1S1ZirAjY46mcHO7UpEbCvVe6DkGFvohaBhhzB7adprZrzZfSSRg0OGQS938wWB3MDXU
         7MXA==
X-Gm-Message-State: AOJu0Yzu3T4Xg+uto40dg6stpTkMmPemDWVP9JLgbTUJE3f4kNr+Sv6/
	Wzym+vxAbvWC+TszEfW3JTsLCqwdxGRU0GNGNfCD34QDS499WLlCYDXksFgPH1ORIPReJ6ti4c8
	vp/hfTFXex2Jzs4Q7rUFpCYmvblOsIA==
X-Google-Smtp-Source: AGHT+IHHdD4PbRhDxGBmxEbHCiWhFKy53WvgMW7FTHsb56txAN+zbYY/UhQSduax/PnAPDBEPXy2PwpTTuFp9lzoFnA=
X-Received: by 2002:a05:6512:b01:b0:539:d428:fbdd with SMTP id
 2adb3069b0e04-53b1a3736e7mr1054940e87.53.1729679112908; Wed, 23 Oct 2024
 03:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-YHx0Hw_GGPWMruF2+vp5CWe6yyxPMqPGBSx-S6Mk=Yg@mail.gmail.com>
 <17198.1729678370250194557@lists.yoctoproject.org> <CANNYZj8CNhBQeKm+=RZggx60cfDnN-17Gx9goCq__+D-Nvj--w@mail.gmail.com>
In-Reply-To: <CANNYZj8CNhBQeKm+=RZggx60cfDnN-17Gx9goCq__+D-Nvj--w@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Oct 2024 12:25:01 +0200
Message-ID: <CANNYZj9jbBRzi=KO1e5SA6k8xfP=32_F2d2FWG2gEUxo0fdKHw@mail.gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 10:25:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/735

On Wed, 23 Oct 2024 at 12:24, Alexander Kanavin <alex.kanavin@gmail.com> wr=
ote:
> > Thank you for review. from what I understood from your comment,
> > The file[battery-sysfs.c] was created solely by me as an individual con=
tributor, out of my work duties with my employer.
> > The file header(along with copyright details) is copied straight away f=
rom the same codebase's existing file: https://git.yoctoproject.org/matchbo=
x-panel-2/tree/applets/battery/battery-acpi.c. I am not good with the licen=
sing terms, so I am not exactly sure what the correct one should be. Pls gu=
ide me for correct header.
>
> I think
> (C) Dixit Parmar
> is fine. No need for the year.

And the rest of the header should be as it is.

Alex

