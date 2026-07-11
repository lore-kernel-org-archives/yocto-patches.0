Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1EC43458
	for <webhook@archiver.kernel.org>; Sat, 11 Jul 2026 16:20:32 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7728.1783786825854416921
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Jul 2026 09:20:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=E+8OlOVd;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: twoerner@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c9107baa7so19350341fa.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jul 2026 09:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783786824; cv=none;
        d=google.com; s=arc-20260327;
        b=SdqoH160UEbByh4WDJk3TZ0arogfQIDs5icldqrdNG1AzelTgXDovtiDPKdSMmJ1Rx
         UUYw5//wSV640qZONzTHPOX9+lkX1IPk5w1wZ1Dsp0empxUOn0CNAHxBqEryx2fWtKhQ
         Ntuq7GilqOu7QcrRKaFg7r4QuSdsXmV4BAlWAQt3qocm6OGS5xJGUi+AQXEm5wWQcczM
         xMCes1KVMI8yUZG+vJERjmDK0TkuU8QdWUkr427y380pzUOU38aFu174m0hxnjpVjJdO
         Sv2av87eNfv8pp+hxYLrGV8Ayds3gDV8hpvA7tTwyjrNkFL+JX1cGZ9MpBMnIniK0JKm
         CXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3P/TNB9lbZWpdbr2yhzLz7wtEvDrzefV9kSDSIN6Zg=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=XKF1SqOfCPIcAPcrlJ9oA90Z8KmktPHM9K4RJYvH+wNT72qAI6Ja/EFWMLkENVbbwL
         uAHWpCLOXD1fz6lTDf5k1PclKa3DFY9LtotUX0LHEaD/Vx3qhY0TzrII9luYlo9l6Gak
         ijXqX2Pu0yGjGqefhVIu2oT1/YvPaKojoVFIQcC72JgJ/q6iS4rFJPOleTXJt7V5mInj
         8KeOFmcpvXY57oGhp1FPGVIOgoXnQbsAAY6kaPVRcZg1mHUkrYpqFsZLQxbIYmljJvI5
         5qGb1t9SJb6T0mueie8HqkMfCaAisnyhyqbbJclEdG3h6C437rmeiuL1t2Uk7vmXcQYC
         xXKw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783786824; x=1784391624; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3P/TNB9lbZWpdbr2yhzLz7wtEvDrzefV9kSDSIN6Zg=;
        b=E+8OlOVdehNB8by6HDwuFTqMLlG7/U+8vydRNEMjF50Mm/3VWEYqjmGuKP74p+2l2E
         BHUTjzbmPqJ4A2mg8Ion8lJzXE0arPa4y46pFm74s5OIXxmlhb5L47RzySmDbJWXIZs9
         8tK1eIDYsgJP49koi8RUchyT+VdcNiL10i+ExUknKawA3JKGF7/w4kXG73FzB8YKfMKq
         luZeqMjEmpmdCnXLGnZH+ovOQ4R4qfGFse3px8atTEm+EcYst1izP5gFv5yqRdFgvX3U
         +mRu/EWm5HL/6CfgOLXpetHRFw49qt2ajOpV60iBpoNFIj0NdESCXOfPZsXnGLLMf1Z4
         6D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783786824; x=1784391624;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r3P/TNB9lbZWpdbr2yhzLz7wtEvDrzefV9kSDSIN6Zg=;
        b=Hwc7Zc2FZpnMdAStADRFXfrWmw/LwQTqegqd4z5di8T/XG+zUW/G+0SEzbNHb5xgcn
         6ykMpIYRenlyivbU6Kg6dyEdjLRttiagv+G3q3uYl8CwWKmT/dp4+A/quKyuZS2nlVgS
         Z++HLPl5UqAX4D0+zQEF+f772VDMyJe9lo31xhkqj8HBZv0gH530lzx33Kuh4BJvDCD4
         +UaylJT6miKgHttROa4PfG4I96p9qLuG1HamfJUp9MuyUG4ui0Fe0cZVYNvqcDhom/O+
         XeyDklqTiRH+H8aFQgigu+thjjwfCuonyBQ/QI9fIV/3haL25D9RnqZ7S9MVi0f2qyKa
         R6rQ==
X-Gm-Message-State: AOJu0YzDD4dHjLcfdAwzH0j45j40rUyQkg+BwX5UJA1dtu+21XV8/DWt
	+ApIu49dRpFueUKHXRv0mv+60wSRUi/WwxfDtBQZA9pfrIDogTtmROcCwok0mxW2qpEiGmbY4LS
	b3u9FG4aacT+AQbEhdbEtQRV1nAO9VySi/g==
X-Gm-Gg: AfdE7ckkOG6EXehL0znctmqNGyUVzXkWETpQJhhv32+IJukL/YsyQ5qAionVpxK1i9y
	EciNYfbWCnydeAwGeOImZWIuzAxsrKaOz+EoSwGTBLkJ7gleDBFl9YJ8KqxUq2Ez/qMzM0fBZZh
	UM74h5FRPSt3xUkHtqGOlkH91Nq9rNdmBR+IGvMrNrOes84TFijlaAD5KFju5FATFjeaCHSbjnz
	uShz1iOGFcjo73wIuqGJRtzkN4/RwDdBdlfAroZA2TDlEt/71uMqdTUEzEp7SDf6bP8lEUHQQ==
X-Received: by 2002:a2e:a545:0:b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-39caa104039mr5980041fa.3.1783786823373; Sat, 11 Jul 2026
 09:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260709223924.3480606-1-twoerner@gmail.com> <08cc79c4-2e3a-4986-8246-d0175e85854b@cherry.de>
In-Reply-To: <08cc79c4-2e3a-4986-8246-d0175e85854b@cherry.de>
From: Trevor Woerner <twoerner@gmail.com>
Date: Sat, 11 Jul 2026 12:20:11 -0400
X-Gm-Features: AVVi8CdkmRcdtrSFUnK_k1TAJlw9uWKhH2DnlKvcZOWlGN2tW3aivIehZawZ4NM
Message-ID: <CAHUNapSmCuYZyY67iyF7wV5yG_pGErEFqQTYz6rhOHp6Xg0bnQ@mail.gmail.com>
Subject: Re: [yocto-patches] [rockchip][PATCH] rauc: update keyring path for
 meta-rauc relocation
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jul 2026 16:20:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4471

Applied to meta-rockchip, master branch.
Thanks!

On Fri, Jul 10, 2026 at 10:36=E2=80=AFAM Quentin Schulz via
lists.yoctoproject.org
<quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
>
> Hi Trevor,
>
> On 7/10/26 12:39 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > meta-rauc moved the keyring installation directory from
> > ${sysconfdir}/rauc (/etc/rauc) to ${nonarch_libdir}/rauc
> > (/usr/lib/rauc) in rauc-conf.bb [1]. Update system.conf to match
> > the new location so RAUC can find the verification certificate
> > at runtime.
> >
> > [1] meta-rauc: 01f7e1bbde16 ("rauc: prepare for hermetic /usr/")
> >
> > AI-Generated: codex/claude-sonnet 4.6 (high)
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4466): https://lists.yoctoproject.org/g/yocto-patches=
/message/4466
> Mute This Topic: https://lists.yoctoproject.org/mt/120198775/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1316874=
5/900817/63955952/xyzzy [twoerner@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

