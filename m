Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5817FE7E352
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 09:10:52 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7940.1775207443832396427
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 02:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=J1xOby18;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a04f39d2so716875e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775207442; x=1775812242; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB+KzqiKOIoTfvXNZ+tz/zNly4XyAvw6J4dxLrYWAww=;
        b=J1xOby18amODLTPDkrzhHc7ofHKGILqEeI8PQAcWFtZvAonWJmgOGZIb4/mS1ONZp+
         OkaVJ2+ExGWM3Io5ylriB+VCsyDshoCMSh/nTxfz0oTjlRhkUrmj6obWuYk5HgTpY5Rj
         kjdo7X4Uy/1Jj29CvdsW+vkXQm+v6vTCQOGw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775207442; x=1775812242;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QB+KzqiKOIoTfvXNZ+tz/zNly4XyAvw6J4dxLrYWAww=;
        b=LLsFFnEKsZDG1mZHQNEkAskG9LdE+vbfVNSSQWBdMn+Ufyeyb0p96wFk7cBpukrrXB
         /GDD6pnEb9QUnjFigT1Emw96TRTBMBIx860GuhTrWQLksQUTwbo8zvr2MLBGgsR3BiS+
         6ucvJI1Su8KRmdS96cHDvuqSdMo7u3WATl7R1k2DDUvkc4kNU42q8ETfdQiPT1lqABsF
         KU8olyJnw+0IVqOkGhuKrnlzPD6Y55gWySU+g1xWuxze2ZiUDPV0JfyfVPjcfTkoRb95
         7hhRA+3T8jjSSrKfR6A6gIVf7b/weSgBxBkHdoX1Ytei+WWbXKWCJy5/4vAilpwmsnbu
         OwqA==
X-Gm-Message-State: AOJu0YyiMmAaI7NgOUqf9HQX3fbQamaFnpJ1/lQWLKxi6IABP+3o0f4T
	I6r5yzykD/gSFJ6YiW3DwAsL97D71QVv3FEYeF0enAp3hpIn605Zwc3Ko0LNl8ilSnEm0ISoVWT
	Y/ZqhH6I=
X-Gm-Gg: ATEYQzw2xK9YcHB43e6fZRoSSM+b3H3ZpYKjTF+b3l5TfDvJOZUC/pEApz3r/F6owRY
	mj7B93jAxDAC4bGQLJq3blmQTU6URvWJsV1r6XAZFWocvGgmifdXROzy6D12LfAlMMl7qBPLLdS
	HwrN8dY4X1xEjilEPh4KPVuQB8xvn2tcOvQ2sqtlEXKr4ppmzli3Onzuy5sdPfcli/9MLoCBRPL
	xUWZqmWFrXctDRnqitJDo/68Fl7BefpTlKiWzK9W0hPJeOsILXt3cpu6XxC1A9mKZN1W8osz3Kw
	xmCWCeQOhVLBh9LRpYIk3Tz2/mPn6ZY/3mzmP+615J3v/F85kw0/lt0OBUphD9Mbp/t1Ho+NgBc
	IK/A628MZxuZzaP1Jfvm16z85yNs8fVqaYTXBTBBgk4msYpdn0OEAH1sZnLr1l+MoaHo+XZRISx
	p0ooje0f6Q7zYzsfh2Hm3FkMx8m3usX62u3h5DvIyIIJKs0iNvtAjIcKkw8VTT0Ap5p2zc/KnpL
	OVHut2zSiSlM2Z4
X-Received: by 2002:a05:600c:a11:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488998f8562mr30328285e9.30.1775207441643;
        Fri, 03 Apr 2026 02:10:41 -0700 (PDT)
Received: from localhost (2a01cb001331aa00dac7300510953f30.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:dac7:3005:1095:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdf2d0sm17640415e9.5.2026.04.03.02.10.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 02:10:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 11:10:40 +0200
Message-Id: <DHJEINZZ2G3I.1AM9Z5X53IOGS@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder2] [PATCH] workers: Add
 stram10-vk-1 and opensuse160-vk-2
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260403090302.700265-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260403090302.700265-1-richard.purdie@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 09:10:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3625

On Fri Apr 3, 2026 at 11:03 AM CEST, Richard Purdie via lists.yoctoproject.=
org wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---

Hello,

Small typo in title: stram10-vk-1 -> stream10-vk-1
(I know I will grep for this on at some point)

Regards,

>  config.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/config.py b/config.py
> index 86a6f5e0..a44fd1d4 100644
> --- a/config.py
> +++ b/config.py
> @@ -178,14 +178,14 @@ workers_ubuntu =3D ["ubuntu2204-vk-1", "ubuntu2204-=
vk-2", "ubuntu2204-vk-3", "ubun
>  workers_centos =3D ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk=
-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk=
-3"]
>  workers_fedora =3D ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "=
fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora4=
2-vk-1", "fedora43-vk-1", "fedora43-vk-2"]
>  workers_debian =3D ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1", "=
debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian1=
2-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"=
,"debian13-vk-2"]
> -workers_opensuse =3D ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse1=
56-vk-1"]
> +workers_opensuse =3D ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse1=
56-vk-1", "opensuse160-vk-2"]
> =20
>  workers =3D workers_ubuntu + workers_centos + workers_fedora + workers_d=
ebian + workers_opensuse
> =20
>  workers_bringup =3D []
>  # workers with wine on them for meta-mingw
>  workers_wine =3D ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3=
", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-=
3", "ubuntu2504-vk-1"]
> -workers_arm =3D ["debian13-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-v=
k-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
> +workers_arm =3D ["debian13-vk-arm1", "stream10-vk-arm1", "ubuntu2204-vk-=
arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "u=
buntu2504-vk-arm1"]
>  workers_buildperf =3D ["perf-debian12-vk", "perf-alma8-vk"]
>  # workers which don't need buildtools for AUH and are able to send email=
 to mailing lists
>  workers_auh =3D ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3624): https://lists.yoctoproject.org/g/yocto-patches=
/message/3624
> Mute This Topic: https://lists.yoctoproject.org/mt/118647004/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS


