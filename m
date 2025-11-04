Return-Path: <mustela@erminea.space>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD58CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:55:52 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16924.1762260950280229008
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 04:55:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: erminea.space, ip: 51.250.125.203, mailfrom: mustela@erminea.space)
Received: from localhost (unknown [37.204.49.201])
	by erminea.space (Postfix) with ESMTPSA id BEB10424
	for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 15:55:47 +0300 (MSK)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 15:55:47 +0300
Message-Id: <DDZXDAXPCG6V.3V4XOU5IS7E2E@erminea.space>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] rk3288: use u-boot.itb
 as bootloader image
From: "Peter Shkenev" <mustela@erminea.space>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102132931.228967-1-mustela@erminea.space>
 <1c51d67c-1c7e-4934-91c8-21a214027d1d@cherry.de>
In-Reply-To: <1c51d67c-1c7e-4934-91c8-21a214027d1d@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 12:55:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2414

Hello,

Thank you for the review!

On Mon Nov 3, 2025 at 4:31 PM MSK, Quentin Schulz via lists.yoctoproject.or=
g wrote:
> rock2_defconfig used for the rock2-square machine doesn't build (nor=20
> supports booting U-Boot proper from) a FIT image. Same can be said for=20
> the Amarula Vyasa RK3288, so this would break the build for them.
>
> Please build U-Boot for all RK3288 to see if it works (I didn't, but=20
> reading their defconfig was enough to know this will be an issue).
>
> This change *could* be fine if it was accompanied by the necessary=20
> changes for the boards that cannot boot the .itb image to change their=20
> UBOOT_SUFFIX as well, to .img as thats what we build now (c.f.=20
> u-boot-img node instead of fit in arch/arm/dts/rockchip-u-boot.dtsi, and=
=20
> tools/binman/entries.rst).

I have checked. Turns out defconfigs for all boards supported by
meta-rockchip do not build .itb, but they build .img and .bin. So I
guess I should have set UBOOT_SUFFIX to img by default and set it to bin
for rock2-square and vyasa.

> You can also add a comment stating this needs to be itb if=20
> SPL_OPTEE_IMAGE and SPL_FIT are set in the .config, otherwise img.

Will do.

> On a side note, I think it should be possible to migrate away from=20
> classes/rockchip-gpt-img.bbclass to wks/wic and upstream U-Boot. Not=20
> something you need to do though.

Can we discuss that (either here, or in private, or on IRC)?

> Cheers,
> Quentin
>

---
Best regards,
Peter

