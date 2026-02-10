Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC5EA3F08
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 05:36:32 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13820.1770701780865458184
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Feb 2026 21:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iqUPkiQ1;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-896fb37d1f0so33466506d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Feb 2026 21:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770701780; x=1771306580; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nntKIOUVc3aeRKwvJ18tesa5BOwuuEZqn/POwGLBr5Y=;
        b=iqUPkiQ1f3VCL/UbPAz+wiiaeB8birIygrBHK+aK2vWK1LiuDQNhhykOoILRl47YyB
         u2JfGRd7255anFnPs4WDT8NitutSjay9+0U64oXllIUkQJXeio3DYbyWBeoXCeabOh6P
         38+MENc+jdB2/ke0kr0A/f2Yz08tOOcXim2CMXokVjBf7UrQsI8UdouTafxktvzsd81G
         CMKqZsCRyWVg83KxSyC+3+MHjrvLnQr7PW+a6ad1kg68WRJk7KJHXXqz9uPJpzbZYkmU
         hU/g81jh15cKNQ5HLi9BtSmk9dORMo7QGy9baxYwsodcRzwFcULeWmBXFMkDOiAQuhPE
         JD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701780; x=1771306580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nntKIOUVc3aeRKwvJ18tesa5BOwuuEZqn/POwGLBr5Y=;
        b=Yj836vAJqwz73ARF1za9Le0xL+3yLMGLMTL0+eojfM7Xa5UYodxuWPJ+Q6NYTFCRXK
         xAndp0QGUT0D0Ej7BitSzX3rtsZRrZP85yz37NHq/h9YZ6MiCZBiYhgqvS7u/+2CoCZr
         J14p3VPeXYIz4b8urJEDhggL+EtYSWd9rxrUONvmB1fdV24aJfeGzSXQ/gntQkijLsHH
         l78wGh10syyASHA38QvLzC1q0O554qbUlSAUoloMPl+E3aFf9oQpuPLpqepoHxgymRwu
         X+hLtLJAI/ZDAjsOPhN7wVMCTGm6gc7ZNQ4xyUnRnbwE9pB3EpJUorRewZy1b1bB8bqq
         kDmw==
X-Forwarded-Encrypted: i=1; AJvYcCVsldz6bRAHSe1AChXdFtxoMgdMHfF+og783hUo0TnF2aDKipat9rZ4aXJezTef+9xNXi1MnW6cdOlZKTcu@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyvzYEBPV+JjhZNvyFzdcyeOGJxbRmm1m6ULpSvLe6OTv1321Hc
	FmZ5V3yid1NUIUwmwPBNss3huscWG5PExAKlyCmfMbauk4BB3tZmRCGF
X-Gm-Gg: AZuq6aJ/UQCjdINjuQjZawMRbAyZSdmtSE/d5bF/1Xj67r2kMdE1atGi9xUc5C3Iaxj
	BmSuiFI9IHG/uXZnONI6q7X/q2TNAGCKMfwKJMRvXlQPSf5aA4dM/TMLedXIw6GG2R20Yql69XM
	jwd27Lqrw+r1wZdrPsQVo7QdqWS4pVPpC9DJrafODbzeWNZqK+eSIoxrkGsq1bFXasKuCRwgKZQ
	iJpQ4slqVO1eMdeDUIMUX3cp1oBR4DwTj6bTTBRDanviTDnks5lmJWr0Z76gEH9uYlVIAaKIb7D
	mQUC+VSnmpcRZ7ocpexY8UCqoly1XAMf8GXm6JecH9dQW/JKuMckilMVbZMTSLJRwR0py8SI9Nk
	cYeqPfUq7dDbMM8OAxkjAP9pAAWPF80ntI0SeozO0aId0uxYD1apzM4nnyuhOWyNb3UJEFCi761
	NEg0GZKqs+h5Omk90mqW6Bn9hVeGulYJHff3YJpzcm//dx52ToMQlr7VO51U5gmGMVfELoEuqtS
	ubr
X-Received: by 2002:ad4:5c6c:0:b0:88a:3837:4981 with SMTP id 6a1803df08f44-8953cfa08bemr218768396d6.65.1770701779836;
        Mon, 09 Feb 2026 21:36:19 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aefb75sm958352985a.22.2026.02.09.21.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:36:19 -0800 (PST)
Date: Tue, 10 Feb 2026 00:36:17 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+yocto@0leil.net>,
	yocto-patches@lists.yoctoproject.org,
	Peter Hoyes <peter.hoyes@arm.com>
Subject: Re: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
Message-ID: <aYrD0XKUQPfhSB1b@localhost.localdomain>
References: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
 <128a6f2a-58e2-4b15-9ecc-e067c8ed8d98@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <128a6f2a-58e2-4b15-9ecc-e067c8ed8d98@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 05:36:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3208

On Mon 2026-01-26 @ 03:27:15 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 1/21/26 6:06 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
> > firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
> > subdirectory named trusted-firmware-a and the binary is simply called
> > bl31.elf without any other string.
> > 
> > This differs from what it used to be by the use of the subdirectory and
> > the name of the file itself. This is an issue for us because the U-Boot
> > recipe is given the path to the BL31 binary in deploy directory and that
> > now was wrong.
> > 
> > The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
> > replacement for the upstream recipe and have nothing to change in other
> > recipes dependent on *an* implementation of TF-A (such as the U-Boot
> > recipe).
> > 
> > We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
> > for tf-a firmware") but we'll need to do that for all current and future
> > SoCs (and also wasn't a complete fix as for example px30 didn't have the
> > fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
> > deploy the same way that the upstream trusted-firmware-a recipe does by
> > installing in a trusted-firmware-a subdirectory, simply name the binary
> > bl31.elf and update the BL31 environment variable in the U-Boot recipe
> > to use the new path.
> > 
> > Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
> > make sure the directory is created (with install -D).
> > 
> > This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
> > for RK3399 and PX30.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> > This is a follow-up to
> > https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
> > and
> > https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/
> > ---
> >   recipes-bsp/rkbin/rk3308-rkbin_git.bb                        |  2 +-
> >   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb                 |  9 +++++----
> >   recipes-bsp/rkbin/rockchip-rkbin.inc                         |  2 +-
> >   recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend | 11 -----------
> >   recipes-bsp/u-boot/u-boot-rockchip.inc                       |  4 +---
> >   5 files changed, 8 insertions(+), 20 deletions(-)
> > 
> > diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> > index ab2c70f..0661fc4 100644
> > --- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> > +++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> > @@ -28,7 +28,7 @@ ALLOW_EMPTY:${PN} = "1"
> >   do_deploy:rk3308() {
> >   	# Prebuilt TF-A
> > -	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
> > +	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/trusted-firmware-a/bl31.elf
> 
> I believe we should add -D after install here. Do you mind doing this change
> when applying or should I send a v2?

Done!

