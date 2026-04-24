Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E55FE5202
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 10:23:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16056.1777015152813085045
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 00:19:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: a.fatoum@pengutronix.de)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wGAog-000438-Vc; Fri, 24 Apr 2026 09:19:11 +0200
Message-ID: <e6679de5-4882-46d1-814a-00e102aafa7f@pengutronix.de>
Date: Fri, 24 Apr 2026 09:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root hash signature support
To: yocto-patches@lists.yoctoproject.org
Cc: rybczynska@gmail.com
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
 <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
 <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
 <047e1adf-b779-4440-9e36-3a74c9b8ec89@embetrix.com>
From: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
In-Reply-To: <047e1adf-b779-4440-9e36-3a74c9b8ec89@embetrix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: yocto-patches@lists.yoctoproject.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 10:23:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3787

Hello Ayoub,

Thanks for your patch.

On 4/22/26 19:34, Ayoub Zaki wrote:
> On 4/22/26 18:54, Scott Murray via lists.yoctoproject.org wrote:
>> On Wed, 22 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>>> On 4/21/26 22:45, Scott Murray via lists.yoctoproject.org wrote:
>>>> On Mon, 20 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>>>>> +Root Hash Signature Verification
>>>>> +--------------------------------
>>>>> +By default, dm-verity stores the root hash as plain text in the initramfs
>>>>> +at /usr/share/misc/dm-verity.env. This creates a TOCTOU (time-of-check to
>>>>> +time-of-use) vulnerability: an attacker who can modify the initramfs can
>>>>> +replace both the root hash and the filesystem image, defeating dm-verity.
>>>>
>>>> Just to double check I'm clear wrt the attack scenario, this only works
>>>> if the initramfs is outside the secure boot chain, i.e. stored as a
>>>> separate file from the kernel?  I'm thinking that perhaps secure boot
>>>> with FIT images avoids the problem, and that's not uncommon these days.
>>>> And I'm guessing initramfs bundled with the kernel might also avoid TOCTOU
>>>> w/o a more elaborate attack.  If so, it might be good to be more explicit
>>>> here wrt the insecure scenario.

I agree.

>>> The scenario this addresses is precisely when the initramfs is verified at an
>>> earlier boot stage (e.g. bundled with the kernel or part of a signed FIT
>>> image) but there is a multi-second window between that verification and the
>>> actual use of the root hash where memory contents can be modified:The
>>> specific techniques to exploit this window vary depending on hardware (DMA
>>> attacks, JTAG, etc.). I'll clarify this in the documentation so readers
>>> understand the attack surface more precisely.
>>
>> Gotcha.  I'm all for your changes as they will add another layer of
>> defense, but I am curious if a determined attacker with that capability
>> might also be able to flip off the signature verification flag, or
>> potentially overwrite the kernel keyring?

One wouldn't even need to go for the kernel keyring. The attacker can just
directly exchange code in the kernel image itself. It lies there in RAM
the same way as the initramfs and in the same time window.

Critically, a vast number of systems doesn't employ physical ASLR, so
an attacker knows beforehand exactly what memory address the relevant
parts of the kernel will be at.


>>
>> [snip]
> 
> That's a good question : yes in theory but the difference is the attack magnitude: replacing a plain-text hash in RAM location is trivial compared to locating and patching kernel data structures in memory at runtime.

An attacker that has read/write access to DRAM can trivially search the
page cache for an executable page of any UID 0 binary at runtime and modify
it all the same, no? I fail to see how one is harder than the other.

> On top of that standard kernel hardening via CONFIG_STRICT_KERNEL_RWX

For the described scenario here, the attacker can directly manipulate
physical memory, so their memory accesses wouldn't even go through the MMU
and thus CONFIG_STRICT_KERNEL_RWX is without consequence.

> IOMMU/SMMU makes those structures significantly harder to tamper with.

Either:

- IOMMU/SMMU prevents access to kernel, so it should equally prevent access to initramfs
- IOMMU/SMMU does not prevent access to kernel, so it would not prevent access to initramfs

The situation of having initramfs and kernel in the same memory region during
bootloader/kernel startup, but assuming only initramfs can be modified by not the
kernel image itself sounds a bit contrived.

Frankly, I don't see how for signed FIT configurations this offers a security
benefit.


I agree though that if your initramfs is outside the secure boot chain and
it can't be easily aadded into it, this can be a workable solution.

Just keep in mind that without rotating the keys every time, this will allow
mix-n-match attacks, e.g. an attacker could dig out a vulnerable initramfs
and inject it into a boot flow where all other components are of the newest
version. If that's something you want to prevent, you could equally well
compile the initramfs into the kernel and not need any signing at all...

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

