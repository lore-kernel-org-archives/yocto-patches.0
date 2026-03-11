Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485771049517
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 09:27:45 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16745.1773221261646954166
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 02:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b/Uu1h3X;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509064418a8so47420241cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 02:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773221260; cv=none;
        d=google.com; s=arc-20240605;
        b=AswBHZomSk+kRo5dLNKtpvHv12CpYeLDVRJHHsls0QdUUQHtyQo7aFflgffu+wATv8
         83x4++hkRfXkbVMTMjxnGSPQYPZPCNofr7qazprkKlb9VsaY7zTcPxS/uwjmr11dl948
         3vQ97zd2JdXEK8NVlnmt1+ngQJrJ9Y07J2819C6ECiaLTDuOz40Lt3VF4ve0WAHoqkRi
         DFLbAbYjRMsvG+AHbEccORXUG6+OSEGW1m+ibnNrgjtLw5G6rwuH4NT3mxfjmI6txkFt
         vx/cFgJE7wB8I2Kx/FC11Dqql18uGxfwfGzE4/soA9HBBIfT1Pb7iM27aNwe0HoTRV+Y
         IuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kV12TID1tlu67D4i18IJCR1rOfcW2ro0kmCg6qiBe40=;
        fh=/MH4wvhPUtbRPiZV7Tvq3PiOTTSvYSOpadHYMgLRw3c=;
        b=eQC5D3ic/x/408YQa0n0ZWS9itihEjj2W2N7Lc/VHmtNhMFY5CPJgF6eJhxgpHurHA
         yL31xayY3YytAuEcoQVXMScZ56Lnsyk8nVvrVXYNsECe7iUZYYjgZFrp23t2F7f/9wEO
         A4Mu14VR1GAU6UBSw+KZKNYlYgExeGqCvJgzDGMakDvUMSn1lU+iejdQmQPkyF2pTEOT
         o7f+1EhtSEZ03QUFexqpNbmBjYil+AvVv9jmPTaXHIu+wK1wevIL2Apkd3yKhLxlUaTY
         A/ND30kGRuPQWhi/wydq/CzUyuyStrMSOkjjfgs5Ohvfl+2Eyw/P3HYhD/k0raDbj7nv
         //mA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221260; x=1773826060; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kV12TID1tlu67D4i18IJCR1rOfcW2ro0kmCg6qiBe40=;
        b=b/Uu1h3XNClNL60AnkG2erWfQbWLDki2yKC83T3E9aiuqmD8zM+tuc8tn7c1YuI0hg
         af/0NWxSerizAbmLsBcwEpPWzuZUdSQEHP4YzdIBQNGngy8NQxssL+dGlKaoXuAKZ7eJ
         ST/aqqveumX4TCaoOyS3+taovrTU2MDtVHXI91GQx/oB3yA4tcGEVJ37lXsPlUUdHmxh
         G+oII2u5OhuDDf6UZbKqDQwTfEtR6CJEXEbinvlnvjMWN+bxuAKqYefblBZdCPBqd3JB
         ZUDeplVa9N4WLeQjBGQTiuaKjSNz4FyUUWr8raEVWw4nbK0eH2OOG3XJo40Zg/ORsanO
         Iy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221260; x=1773826060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV12TID1tlu67D4i18IJCR1rOfcW2ro0kmCg6qiBe40=;
        b=tGLT1phyF3yqdYK1v/VrkA3XkYj7tx+VPBoqhTMaTsJ2jyg9mwsr5MQX2N1/iNEDbx
         7WwTm3B3xsO3JNAR7GvwBwsmOcxmliA+6Y8Y5yTPSd1hRMWv6Hl+x6EXWGRmQydetA2D
         Byp36bVFGHry/yDIGqZzKlfN9nl5oX3bNIPTLa3/886Jkcb+3eJ4UcbGE73HAfw+6JyS
         SK8NiKY07NEiYXsPRnzdvpeBnVLdJJIBQdCiYZj04mppUNNm83pzVtyxEIl02sbpusmw
         Jctx6Z7VFFbwsVvMyYUFISGOlNH/C7i71Y0F1aaaNb1j9MHQlkAQzzBBqBdFsBs/KAny
         pKEg==
X-Gm-Message-State: AOJu0YyTX8BasBKEaQQBJovjlGVsZ9mBJjjYeZE2ABtPl6D+CkiUOEr4
	NluO6LpFJ8ddrzNEgQcxUwfwyWlksbLJFdHVrVDDjFxZtqQVTb6b0k3AtHDcAvmbaOKT6tPfdhM
	QbcyTaQmH16ITlygqq6hROtXaYulc290=
X-Gm-Gg: ATEYQzwr7bfTXIb6Ok+jlis1JDJPEgf5Xhy/OYgQ+EKYXSDUCvYZgP4ha7ds+uR2zJU
	Y49GQJs5z4QkdZHrcrb8stpo8g/yde/vnIJOJKmZYaaZ1zl3mzlVlThb2Fphxr0DrITfY3AzOho
	Nj2AMcu7xNvGo07Ng6Emd5MuMUeEm9zSQW98zq24qOIGlSfS9sM7cOTlC5D17VOP81qosGRWb3H
	936rKb+9uCaeGkrYzMX4yrkAJZMgIqb14EU2q9YLJoNJaAmRx78BccjanmJx+MbMx567/TAUdRb
	7xSRWtjRXrTMWCLNJ4gA8T4W/jKNCCVv3kOruSZCmYGPsKisQo54
X-Received: by 2002:ac8:7e94:0:b0:509:2d50:9778 with SMTP id
 d75a77b69052e-5093a17c6cbmr18740771cf.40.1773221260502; Wed, 11 Mar 2026
 02:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <189B9F01010B1521.2412760@lists.yoctoproject.org> <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
In-Reply-To: <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 10:27:29 +0100
X-Gm-Features: AaiRm50PoB3HwzYSiCedfIqKTOGMIUBMe-FQwhMxOyBXcD_rXKyO7gGrvh3lzuQ
Message-ID: <CANNYZj_Cu0sdFN02WjbNrKNH2pdcNfMqT0dYEV4y9BFTk_uSPg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 09:27:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3427

On Wed, 11 Mar 2026 at 08:30, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> I just wanted to document/highlight that there is one case where this
> change causes a test regression which is the runtime_test
> test_testimage_virgl_gtk_sdl.
>
> In most cases we can redirect to the vnc socket and have equivalent
> functionality but that test uses/tests gl as well as the sdl and gtk+
> backends and that needs either a DISPLAY.
>
> Michael has a way to enable an X DISPLAY on the new systems RHEL 10
> derived systems but I'm still keen to drop the DISPLAY requirements
> where we can (and we can't view it any more).
>
> The best way forward may be to find a different way to tell this single
> test to use DISPLAY=:1 through some new variable we can set in the
> configuration.
>
> Does anyone see an issue with that?

I agree, except one thing.

I would take this opportunity to drop x11 usage on the host/naitve
side altogether, and migrate the test to use some kind of host-side
wayland compositor rather, that can be found via WAYLAND_DISPLAY
variable. I can experiment/propose needed patches to the selftest and
oe-core metadata, but I don't yet have a clear proposal for the
wayland setup on hosts.

Alex

Alex

