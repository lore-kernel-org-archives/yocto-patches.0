Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36ECEA7193
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 09:54:49 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5651.1776592485619731106
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Apr 2026 02:54:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=O0iGnDdx;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a283c44478so3481334e87.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 02:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776592484; cv=none;
        d=google.com; s=arc-20240605;
        b=LO0HOUsBupEM/jkGVDdI1uZtepPpQ5lVphS/TKhFShDeTlQDpMu+ttMZB1pN8vIEGL
         kHaUrZkO81S+Ha7bK1+4jqF1tNXiT0BfOVXN1L0DXYPlQ8RNY5RvRoRDoi+yWMxqfbQe
         2iMAU0BeeujrqdPUt9tsnx6kdpuC/8eITHz6sqX4tiY2M9JjyC+PnI1SFOGvZOrZUN1T
         FRg4YCqA01swimm9YNJYl5ZFAs+ZYbt4y2TLOlTi5UcoTN7vrdeWDm1uaCT12BnYyWEo
         VtO2vHXDNVSxbVc53Z9C0u/Z6tX9GIh5y4ESnqwF/aEutk+Nf6j6UPCCRdmFfiEBoduR
         Sg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/VMqeB8M8ISx1HQDj2ZpDHCV7FIrqD8XJYnWGauT5yY=;
        fh=+Ayz3PnhGh9kZJp7lng7xXRSbdfesLzeADI8Xk96IoA=;
        b=PaTePyPaq0RSDBZ10PWI2MAlea7vnnvVEerNhuej50AKJ357M5B6npeFg7KmyZCr+6
         lflJGLN2teksqrda5PQoTrMYmqS0kj11Hb0pua+nSjZbQvsZcmMIh/uRUy1kO/NE1u1Y
         n32Ry9F13K2BD8ABsa6T9umjTqRoe/gExqsyaSg7ptbCA3p1HONApvbSUSgUjLc27g2m
         H2gA9elsTxZBq4u2zQaZlwCshJeuOUO4fm+7+NDmgULZ4JH/JRhZOkB1My6XPQLJTo5r
         kKP48487xceWng5xrgn6CfYd9S1uB4JNbPy5esJH8koGchZvfzQGjsD1KtK/Z1UJCk8i
         UbCQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592484; x=1777197284; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VMqeB8M8ISx1HQDj2ZpDHCV7FIrqD8XJYnWGauT5yY=;
        b=O0iGnDdxnMxVx7+DmXOnXrjc50ZCgwdeWJxIdG0wpeKgQ9BwFiZsClHR1XDnKsBwDI
         lFrOLMu1fzJhFk10g3Xb5jzWPRl7XZZyUJ5K9NeHEObmTPX99vGDZHXgHVvyH+bBijwy
         2g1jGImG0IsWgo05hrqwvXGoRaelXEwSrA4TVl5pI6QcERAJ4pVFIqZivQ1eChwMSsXX
         LywxnX1AuVpl9khFJoaM/N7qHlUgYrfR3ijdkFfckTGtRdaZYdL9vmzskoicpCjWF5f2
         TTbWzfj21lif7AHLgCxZpFo/vUnnzgBI7l7yvYAKbhGtFfYPfo7AjhKHsTk/mtLdQiyZ
         pC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592484; x=1777197284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VMqeB8M8ISx1HQDj2ZpDHCV7FIrqD8XJYnWGauT5yY=;
        b=oZfR6ANBLWcfF4KB1zA3RYra6iw2UxT8JHHbA02aNGipDEgH4GJ+ot0F/1ESWtwe6t
         Gv4BPFAG1vIv1kvOn3xeGPdkP73HPHlakyJPkOiGhWknmml/ySUxRoPRtDuEGKEKsVDl
         aIgZtdYz4cyIKbnhytJ0YagyEBwR/Wtj2WZ4gHWUploxe4HvQLHtC5zIVNbq+uJLYOa2
         THlzymtm8t4VZMOA40+OD9sDjitcCI2LXMycoiP0vDHL/IOf3niyJAyTJvFQP0MDPeDp
         QivTK9IwYQBXxrm9qv1rgd7xGyJYQ5bIBDUHo0QqcD+HhizNcm/LZ56Gp9CRuZFqTKv4
         UAgA==
X-Gm-Message-State: AOJu0YweYFYb5Tpwxs4ccfH2k3UmBgJkmYviCyYiSCsJHe+0MnR0sZAc
	v9Ex06vUP3CPLXnOP1njpPRgMXYIqAcF1HA2FjZMAnAf2Go+9w90OHNazoRWdwfsDVnl3tTDrnM
	rIX2BD72tJydoyabxGbbhTyiyNiCWqRxj7lGe
X-Gm-Gg: AeBDietlA81oBv74pkv9/e4soqat6MI07ufq5fSUs320NA8PV3E8Cxt958P02f8kJwj
	rXq3MChzi1rxEoWfG4bEKJ/93VCbWrVCqb73jxihVXCTtZiZEn2SMkoAc534yoXgyaNWQyRvQnP
	u7mrykZDRWnR1dm7eqL6y6yfKEqcpCi51s5NpmCaWu4gf+x3gh90Rgblu8qFJ07thGJpdoIbPev
	BHWkQJQTv1Ypvn3Tr69mMlYUFbGkB95jpBXIgEBst/VspOEq7Wp2AKJgLwP+Empvyk0LxHPJMVS
	PR3w3i42AvM9R1X/Oqef63qtVUjVZyumg1tSn+5jY4eo9dA4Z6RZKuAai9pjT7sn05WLDIbzYhn
	P
X-Received: by 2002:a05:6512:234b:b0:5a3:fc79:934 with SMTP id
 2adb3069b0e04-5a4172de2b1mr3030649e87.30.1776592483348; Sun, 19 Apr 2026
 02:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260419085321.3608814-1-michael@amarulasolutions.com>
In-Reply-To: <20260419085321.3608814-1-michael@amarulasolutions.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 19 Apr 2026 11:54:31 +0200
X-Gm-Features: AQROBzBC-vzeHt12q97F3BmRfOa6KEaqLuaGANaOWkc0rSeKNNbi6BqyOrlgdOE
Message-ID: <CA+chaQe8uPCAAfKD6Y+n8F+MUV0oz3LKXOoa3t+aLds7QHg1yw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH V2] wic: wic need to be
 moved to files/wic within the layer to be found/used
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 09:54:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3730

Not sure where you're seeing the issue now, but it was fixed in master
and wrynose branch 11 days ago with:
https://git.yoctoproject.org/meta-rockchip/commit/?id=3D7bc349061e8ac3f03b5=
646f2ae1d3958ce53c460

On Sun, Apr 19, 2026 at 10:53=E2=80=AFAM Michael Nazzareno Trimarchi via
lists.yoctoproject.org
<michael=3Damarulasolutions.com@lists.yoctoproject.org> wrote:
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> V1->V2:
>
> - Fix correct directory to be wic
>
> ---
>  {wic =3D> files/wic}/rockchip.wks | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {wic =3D> files/wic}/rockchip.wks (100%)
>
> diff --git a/wic/rockchip.wks b/files/wic/rockchip.wks
> similarity index 100%
> rename from wic/rockchip.wks
> rename to files/wic/rockchip.wks
> --
> 2.53.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3729): https://lists.yoctoproject.org/g/yocto-patches=
/message/3729
> Mute This Topic: https://lists.yoctoproject.org/mt/118901614/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

