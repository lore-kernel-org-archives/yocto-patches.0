Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CECE7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 16:08:33 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.37913.1734278907599801696
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 08:08:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gvQzsH1G;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a0a6c9fcso51050801cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734278906; x=1734883706; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbsSHFIGVlBr9RvHcWqISb6zcHWZpydLCmAUWEqEpk8=;
        b=gvQzsH1GOUC5D9Muha7LicKZV6h8sTVOGyz+ggxyw6jTvDdfaIbD26bmO2FpC3WShe
         DYvQ6skmkFhP3fhKW94NXbJrfbC5IgUQLf8Wpf5LJAjM2jgaa1N6ia5Z+wUEPZ0qER0N
         qfNaB9i3MoRovRvQ8yzAXgKrssTPRcd7zqlY3eJfTeTaGxNA83iNlvbCk0Geo1LZ8AsN
         bpYs5Hif4eDDiTFE2pkdu0cdWri1Qvz9hYTSrFKoBYXEQ9a4ySnBFGRhQ9jhc7mv/u21
         u9zZ/7oE6yOdYYAZyUe/blajGK9CSebvLB1Nl0HnNOKevrad9apRqXch3j3DEewdlx/E
         UOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734278906; x=1734883706;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbsSHFIGVlBr9RvHcWqISb6zcHWZpydLCmAUWEqEpk8=;
        b=LLTwdxexvGRO2zgC2eXCrxm4DZyjUN175/Q0kGB/AUhNnEQES3eoZ5Zhfn714nbQS5
         +rwGZGva8KHnRefXSEDAeLinTYBulGIfI5ZX7vlx0ScgIg+iCz5w30ijk4XUK7hyy44H
         +SzA91vPcsiU/ev5q9MEqLF9xnVgKHZkgj6TTMJnyXWmC1eRkXuajVDwnrVFJvh+z+48
         YjqdUbqJj7f0XIMEsGkDewt4raFY97RJjMYj21B+D5SiU4URpKNQYxEoIf9sD+thqGu7
         i7kITIvURN073JthweVFlyY6a8XiPR0bjoBp/tk3ODpQB5ReUkrN2OeWnecmdhBdbyy0
         wzLQ==
X-Gm-Message-State: AOJu0YzV3WiZwVwe0fHAJtlmXpaxvzNw+wj/uX41ilenBVcGY7KJF5Sk
	Z09CIpiLZC2VUQFxX7oPSUbXWrPxehtVJMz/9BYu1CN1aZjOlz6k
X-Gm-Gg: ASbGncu3T1Jsi85W3Y5v65Vhp/o9mGxg9As7OtiFXb9rH+e0ugsupnA22D5TMKz/6Tk
	gqOnN9TT2E4Y1NebizVb2sbD0qc+j8WPpnajekiywiO+HK/5pBTox35sST/SVPiA4HIaYtlCIi0
	yEITWlTyv7XxbxbevxhgB75gF4DrG97St+b1AHIQTAfoSaDB450yuaVDHfelGurdjc/nYncdeoi
	xemCSoyPmkMNbJAJFdiPVmCtOHFXFTJoHRWjjSGBr+ThXwSu5FwnA7zg+MthFzPAuSzciUT2+fb
	pCkVZfJC
X-Google-Smtp-Source: AGHT+IEzyUaDFnd5CV9DS014w1RUCFLKKZ76azzKg7xrrOEmjJAs2uehQCQm499igXFE/Mg95L1tIw==
X-Received: by 2002:a05:622a:149:b0:467:6692:c18a with SMTP id d75a77b69052e-467a574ab61mr199402621cf.13.1734278906621;
        Sun, 15 Dec 2024 08:08:26 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e83169sm18124371cf.61.2024.12.15.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:08:25 -0800 (PST)
Date: Sun, 15 Dec 2024 11:08:22 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 2/3] u-boot: use upstream for
 radxa-zero-3{e|w}
Message-ID: <20241215160822.GA2090@localhost>
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-2-twoerner@gmail.com>
 <7a0bed0a-d85a-42ae-8756-77df1be8efcd@gmail.com>
 <181161B988FC6012.23577@lists.yoctoproject.org>
 <e704a2e3-0f7c-4565-8a25-837f98fdab74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e704a2e3-0f7c-4565-8a25-837f98fdab74@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 16:08:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/912

On Sun 2024-12-15 @ 04:15:53 PM, Oleksii Kurochko wrote:
> 
> On 12/15/24 3:59 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
> > 
> > On 12/15/24 3:49 PM, Oleksii Kurochko wrote:
> > > Hi Trevor,
> > > 
> > > On 12/12/24 8:57 PM, Trevor Woerner wrote:
> > > > Upstream U-Boot 2024.10 (the latest release supported by Yocto)
> > > > has support
> > > > for radxa-zero-3{e|w}. Therefore switch away from the fork where
> > > > the initial
> > > > U-Boot development for this board had been added.
> > > > 
> > > > Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> > > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > > ---
> > > >   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
> > > >   1 file changed, 4 deletions(-)
> > > > 
> > > > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > b/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > index 06ba6d54de8e..08e1730b5d3d 100644
> > > > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
> > > >     FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > > >   -SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> > > > -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > > > -SRCREV:radxa-zero-3:rk-u-boot-env =
> > > > "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > > > -
> > > >   SRC_URI:append:rk-u-boot-env = "
> > > > file://rockchip-enable-environment-mmc.cfg"
> > > >     DEPENDS:append:rk3308 = " u-boot-tools-native"
> > > I have a compilation issue after applying of this patch series:
> > >     | scripts/kconfig/conf
> > > --defconfig=arch/../configs/radxa-zero-3-rk3566_defconfig Kconfig
> > >     | ***
> > >     | *** Can't find default configuration
> > > "arch/../configs/radxa-zero-3-rk3566_defconfig"!
> > >     | ***
> > >     | make[2]: *** [/home/ok/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/scripts/kconfig/Makefile:96:
> > > radxa-zero-3-rk3566_defconfig] Error 1
> > > 
> > > 
> > > And it seems like there is not defconfig for radxa-zero-3 at all:
> > > 
> > > ok@fedora:~/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/configs$
> > > ls -la radxa-
> > >     radxa-cm3-io-rk3566_defconfig  radxa-e25-rk3568_defconfig
> > > radxa-zero2_defconfig          radxa-zero_defconfig
> > 
> > But it is present in the master:
> > 
> > https://source.denx.de/u-boot/u-boot/-/blob/master/configs/radxa-zero-3-rk3566_defconfig?ref_type=heads
> > 
> > 
> > And It seems we need or cherry-pick the patch ( 5d199ad9a6b("board:
> > rockchip: Add Radxa ZERO 3W/3E") ) or switch to newer tag:
> >    git tag --contains 5d199ad9a6b
> >    v2024.10
> >    v2024.10-rc3
> >    v2024.10-rc4
> >    v2024.10-rc5
> >    v2024.10-rc6
> >    v2025.01-rc1
> >    v2025.01-rc2
> >    v2025.01-rc3
> >    v2025.01-rc4
> 
> Sorry for flooding but I think it is needed to note that it is needed for
> scarthgap branch.

These patches are targeting master, not styhead.

> 
> ~ Oleksii
> 
> > 
> > ~ Oleksii
> > 
> > 
> > > 
> > > 
> > > Should I apply something else except the current patch series?
> > > 
> > > 
> > > Best regards,
> > > 
> > >  Oleksii
> > > 
> > 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#909):
> > https://lists.yoctoproject.org/g/yocto-patches/message/909
> > Mute This Topic: https://lists.yoctoproject.org/mt/110086429/7609514
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13794076/7609514/1776480132/xyzzy
> > [oleksii.kurochko@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> > 

