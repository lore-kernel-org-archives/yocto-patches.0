Return-Path: <a.fatoum@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC3FED3CB
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 13:20:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20668.1777036809711924722
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 06:20:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: a.fatoum@pengutronix.de)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wGGRz-0000Mk-UJ; Fri, 24 Apr 2026 15:20:07 +0200
Message-ID: <9cfc63de-56e9-43e3-9bd0-220962860b77@pengutronix.de>
Date: Fri, 24 Apr 2026 15:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root
 hash signature support
To: Ayoub Zaki <ayoub.zaki@embetrix.com>, yocto-patches@lists.yoctoproject.org
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
 <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
 <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
 <047e1adf-b779-4440-9e36-3a74c9b8ec89@embetrix.com>
 <e6679de5-4882-46d1-814a-00e102aafa7f@pengutronix.de>
 <4e98643f-b382-4eb5-b0a6-4d465c6e47dd@embetrix.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <4e98643f-b382-4eb5-b0a6-4d465c6e47dd@embetrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: yocto-patches@lists.yoctoproject.org
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 13:20:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3801

Hello Ayoub,

On 4/24/26 1:53 PM, Ayoub Zaki wrote:
> On 4/24/26 09:19, Ahmad Fatoum wrote:
>> Frankly, I don't see how for signed FIT configurations this offers a
>> security
>> benefit.
>>
> 
> 
> You're right about the RAM symmetry STRICT_KERNEL_RWX IOMMU don't really
> help once you've granted the attacker DMA or JTAG.
> 
> There's a also other cases where the patch could help and it doesn't
> need RAM tampering. where root hash comes from the kernel cmdline via a
> unsigned Bootloader enviroments.

The security of any such system is not salvageable.

An attacker just needs to stick an init=/bin/sh there, they wouldn't
even bother to compute any dm-verity hashes.

> An attacker could tamper the env
> offline  with their own root hash and craft a matching rootfs.

Sure, an attacker could also just tamper with the initramfs itself to
mount the rootfs without any dm-verity at all..

> Even the secure boot chain is not interupted, dm-verity happily sets up
> against the attacker's hash and mounts their rootfs.
> 
> With CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG the kernel refuses an unsigned
> hash regardless of where it came from (enforcment via  dm_verity
> require_signatures=1 should be set)
> So defense in depth not a replacement for hardware mitigations.

I just want to avoid that we give users a false sense of security.

> I can reframe the threat model in a v3 an maybe drops the RAM arguments.

Yes, please. CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG has its place for
sure, but not for protecting against DMA attacks or an insecurely
configured bootloader.

Please keep me in the loop for later series.

Cheers,
Ahmad

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


