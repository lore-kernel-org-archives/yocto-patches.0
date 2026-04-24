Return-Path: <ayoub.zaki@embetrix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD144FE5214
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:54:06 +0000 (UTC)
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19450.1777031640294416437
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:54:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@embetrix.com header.s=rsa2 header.b=FqGt+L2o;
 dkim=pass header.i=@embetrix.com header.s=ed2 header.b=jle+pglb;
 spf=none, err=permanent DNS error (domain: embetrix.com, ip: 46.30.212.3, mailfrom: ayoub.zaki@embetrix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777031637; x=1777636437;
	d=embetrix.com; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=s6dD9/T+xWUg8uyWkAv1x0T/iHrrLTJ1DM8YfHewFiI=;
	b=FqGt+L2oP2l9NT/coOJA2++HFVqwG870PnZXz5cUtBgC4PEUasnPQcQip4/8rW0fU1pzliPjZ4Ud1
	 ZArUsbDpHOmTP9W/CZO7SPHmlCXfhYhOiaMXsUb69tne8jNVAdTIwm0IRGPJVII5UfnhwplDKxih3F
	 E34wYv724H32UGf9wMhNlzpAMUv32uOI/Ep2lWIHjE6LA+HCYiK8MEG4Mzm9eYz2FTNf0I+kXP/axh
	 tQylOQvH4hpi5dAzGtp8ynyXjVhjGQDyIz7TZmJbnX6ka1tSMfoODAyMbwvd3n7CyWF3mnxfPGbQ6o
	 cE/fEnep4E6yqtSC0FXp1csrKXeluvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777031637; x=1777636437;
	d=embetrix.com; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=s6dD9/T+xWUg8uyWkAv1x0T/iHrrLTJ1DM8YfHewFiI=;
	b=jle+pglbjZSHag1YnXiSPTvsjoLOcgELWZaAK802hklMDDXZbmlGuKkueIeI7o9CrntZpnXllLaZ9
	 AnDqBAIDw==
X-HalOne-ID: 45b55ce9-3fd4-11f1-8af6-632fe8569f3f
Received: from [IPV6:2a02:3102:8c10:1ae0:7fc0:6ad0:c2b7:2937] (dynamic-2a02-3102-8c10-1ae0-7fc0-6ad0-c2b7-2937.310.pool.telefonica.de [2a02:3102:8c10:1ae0:7fc0:6ad0:c2b7:2937])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 45b55ce9-3fd4-11f1-8af6-632fe8569f3f;
	Fri, 24 Apr 2026 11:53:57 +0000 (UTC)
Message-ID: <4e98643f-b382-4eb5-b0a6-4d465c6e47dd@embetrix.com>
Date: Fri, 24 Apr 2026 13:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root
 hash signature support
To: yocto-patches@lists.yoctoproject.org
Cc: a.fatoum@pengutronix.de
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
 <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
 <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
 <047e1adf-b779-4440-9e36-3a74c9b8ec89@embetrix.com>
 <e6679de5-4882-46d1-814a-00e102aafa7f@pengutronix.de>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <e6679de5-4882-46d1-814a-00e102aafa7f@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:54:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3800

Hi Ahmad,

thanks for the review.

On 4/24/26 09:19, Ahmad Fatoum wrote:
> Hello Ayoub,
> 
> Thanks for your patch.
> 
> On 4/22/26 19:34, Ayoub Zaki wrote:
>> On 4/22/26 18:54, Scott Murray via lists.yoctoproject.org wrote:
>>> On Wed, 22 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>>>> On 4/21/26 22:45, Scott Murray via lists.yoctoproject.org wrote:
>>>>> On Mon, 20 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>>>>>> +Root Hash Signature Verification
>>>>>> +--------------------------------
>>>>>> +By default, dm-verity stores the root hash as plain text in the initramfs
>>>>>> +at /usr/share/misc/dm-verity.env. This creates a TOCTOU (time-of-check to
>>>>>> +time-of-use) vulnerability: an attacker who can modify the initramfs can
>>>>>> +replace both the root hash and the filesystem image, defeating dm-verity.
>>>>>
>>>>> Just to double check I'm clear wrt the attack scenario, this only works
>>>>> if the initramfs is outside the secure boot chain, i.e. stored as a
>>>>> separate file from the kernel?  I'm thinking that perhaps secure boot
>>>>> with FIT images avoids the problem, and that's not uncommon these days.
>>>>> And I'm guessing initramfs bundled with the kernel might also avoid TOCTOU
>>>>> w/o a more elaborate attack.  If so, it might be good to be more explicit
>>>>> here wrt the insecure scenario.
> 
> I agree.
> 
>>>> The scenario this addresses is precisely when the initramfs is verified at an
>>>> earlier boot stage (e.g. bundled with the kernel or part of a signed FIT
>>>> image) but there is a multi-second window between that verification and the
>>>> actual use of the root hash where memory contents can be modified:The
>>>> specific techniques to exploit this window vary depending on hardware (DMA
>>>> attacks, JTAG, etc.). I'll clarify this in the documentation so readers
>>>> understand the attack surface more precisely.
>>>
>>> Gotcha.  I'm all for your changes as they will add another layer of
>>> defense, but I am curious if a determined attacker with that capability
>>> might also be able to flip off the signature verification flag, or
>>> potentially overwrite the kernel keyring?
> 
> One wouldn't even need to go for the kernel keyring. The attacker can just
> directly exchange code in the kernel image itself. It lies there in RAM
> the same way as the initramfs and in the same time window.
> 
> Critically, a vast number of systems doesn't employ physical ASLR, so
> an attacker knows beforehand exactly what memory address the relevant
> parts of the kernel will be at.
> 
> 
>>>
>>> [snip]
>>
>> That's a good question : yes in theory but the difference is the attack magnitude: replacing a plain-text hash in RAM location is trivial compared to locating and patching kernel data structures in memory at runtime.
> 
> An attacker that has read/write access to DRAM can trivially search the
> page cache for an executable page of any UID 0 binary at runtime and modify
> it all the same, no? I fail to see how one is harder than the other.
> 
>> On top of that standard kernel hardening via CONFIG_STRICT_KERNEL_RWX
> 
> For the described scenario here, the attacker can directly manipulate
> physical memory, so their memory accesses wouldn't even go through the MMU
> and thus CONFIG_STRICT_KERNEL_RWX is without consequence.
> 
>> IOMMU/SMMU makes those structures significantly harder to tamper with.
> 
> Either:
> 
> - IOMMU/SMMU prevents access to kernel, so it should equally prevent access to initramfs
> - IOMMU/SMMU does not prevent access to kernel, so it would not prevent access to initramfs
> 
> The situation of having initramfs and kernel in the same memory region during
> bootloader/kernel startup, but assuming only initramfs can be modified by not the
> kernel image itself sounds a bit contrived.
> 
> Frankly, I don't see how for signed FIT configurations this offers a security
> benefit.
> 


You're right about the RAM symmetry STRICT_KERNEL_RWX IOMMU don't really 
help once you've granted the attacker DMA or JTAG.

There's a also other cases where the patch could help and it doesn't 
need RAM tampering. where root hash comes from the kernel cmdline via a 
unsigned Bootloader enviroments. An attacker could tamper the env 
offline  with their own root hash and craft a matching rootfs.
Even the secure boot chain is not interupted, dm-verity happily sets up 
against the attacker's hash and mounts their rootfs.

With CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG the kernel refuses an unsigned 
hash regardless of where it came from (enforcment via  dm_verity 
require_signatures=1 should be set)
So defense in depth not a replacement for hardware mitigations.
I can reframe the threat model in a v3 an maybe drops the RAM arguments.


> 
> I agree though that if your initramfs is outside the secure boot chain and
> it can't be easily aadded into it, this can be a workable solution.
> 
> Just keep in mind that without rotating the keys every time, this will allow
> mix-n-match attacks, e.g. an attacker could dig out a vulnerable initramfs
> and inject it into a boot flow where all other components are of the newest
> version. If that's something you want to prevent, you could equally well
> compile the initramfs into the kernel and not need any signing at all...
> 


> Cheers,
> Ahmad
> 

Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg

Mobile   : +4917662901545
Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com
VAT No.  : DE313902634


