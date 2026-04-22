Return-Path: <ayoub.zaki@embetrix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F6FA1FD6
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 17:34:54 +0000 (UTC)
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88454.1776879287540857030
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 10:34:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@embetrix.com header.s=rsa2 header.b=gqXxRPNE;
 dkim=pass header.i=@embetrix.com header.s=ed2 header.b=qTo/QpJ7;
 spf=none, err=permanent DNS error (domain: embetrix.com, ip: 46.30.212.3, mailfrom: ayoub.zaki@embetrix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776879284; x=1777484084;
	d=embetrix.com; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=TFU079ZP+ArtwRyIeNYtXeiBS8hBG29Z3gyXzyqCzSY=;
	b=gqXxRPNEjssvk2s2+2KGrSbG7smFHyNh381I4TkC0FZICM12Dso2M/38OhI8hkxmJVW1qhMFwM4Z6
	 3xDY7yqOXfzdG8XpRETwMHyUDzOJmLWf+YliDYGBmEVLxNFfn8v1CpPOLHR+1MdY/Plwjxn7DR7bD4
	 JpjYTTvJdioTGZPK05VGHlbEPT5cG7k0itB/8u5Yy8rqi8inmBBgcTNOm4nFOVVi1pbE+HAIeTjYsF
	 s+CiretSokxB/tEFVJ4O2p5WvtsErtbjuGU6JGO+B/wY5Ly9anYxK9GM1sv366waFymM1l+549df21
	 Kja9IhNG96m6czJ5vSbbbQZRsaRQ0iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776879284; x=1777484084;
	d=embetrix.com; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=TFU079ZP+ArtwRyIeNYtXeiBS8hBG29Z3gyXzyqCzSY=;
	b=qTo/QpJ7Pf4CnG68agG7QeMeIjZmJ7JRoeQflpmZBx//J7ZcHBuzvf1zBnSldq6LEinOCNQbjGq+m
	 1A9iLABDg==
X-HalOne-ID: 8bd9ddf2-3e71-11f1-8ac7-494313b7f784
Received: from [IPV6:2a02:3102:8c10:1ae0:e80e:f9fe:39ce:37f3] (dynamic-2a02-3102-8c10-1ae0-e80e-f9fe-39ce-37f3.310.pool.telefonica.de [2a02:3102:8c10:1ae0:e80e:f9fe:39ce:37f3])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 8bd9ddf2-3e71-11f1-8ac7-494313b7f784;
	Wed, 22 Apr 2026 17:34:43 +0000 (UTC)
Message-ID: <047e1adf-b779-4440-9e36-3a74c9b8ec89@embetrix.com>
Date: Wed, 22 Apr 2026 19:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root
 hash signature support
To: yocto-patches@lists.yoctoproject.org
Cc: rybczynska@gmail.com
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
 <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
 <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <258554ca-9212-2f90-5f91-4ebbf2c69777@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 17:34:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3764

Hi,

On 4/22/26 18:54, Scott Murray via lists.yoctoproject.org wrote:
> On Wed, 22 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
> 
>> Hi Scott, Marta,
>>
>> Thanks for the review and for testing effort.
>>
>> On 4/21/26 22:45, Scott Murray via lists.yoctoproject.org wrote:
>>> On Mon, 20 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
>>>
>>>> The dm-verity root hash stored in the initramfs is vulnerable to TOCTOU
>>>> attacks. Mitigate this by signing the root hash at build time and
>>>> verifying it from the kernel via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
>>>> The signature is deployed into the initramfs while the signing certificate
>>>> is embedded in the kernel's built-in trusted keyring.
>>>>
>>>> - dm-verity-img.bbclass: sign root hash with openssl smime when
>>>> DM_VERITY_SIGN=1
>>>> - kernel-trusted-keys.bbclass: new shared class to collect PEM certs
>>>>     into trusted_keys.pem via KERNEL_TRUSTED_CERTS variable
>>>> - linux-yocto_security.inc: add kernel config fragments and append
>>>>     signing cert via KERNEL_TRUSTED_CERTS
>>>> - dm-verity-image-initramfs.bb: deploy .p7s signature
>>>> - dmverity initrd script: pass --root-hash-signature to veritysetup
>>>> - linux_ima.inc: use KERNEL_TRUSTED_CERTS instead of absolute path in
>>>>     CONFIG_SYSTEM_TRUSTED_KEYS, fixing buildpaths QA
>>>> - Add debug/test keys and documentation
>>>>
>>>> Signing is not enabled by default for backward compatibility but is
>>>> strongly recommended for production deployments.
>>>
>>> I believe Marta is doing some testing of this, and I'll try to do some
>>> as well in the next couple of days.  I do have some comments that I'll put
>>> inline below.
>>>
>>>> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>>>> ---
>>>>    classes/dm-verity-img.bbclass                 | 46 +++++++++++-
>>>>    classes/kernel-trusted-keys.bbclass           | 34 +++++++++
>>>>    docs/dm-verity.txt                            | 73 +++++++++++++++++++
>>>>    meta-integrity/data/debug-keys/README.md      |  7 ++
>>>>    .../data/debug-keys/privkey_verity.pem        | 52 +++++++++++++
>>>>    .../data/debug-keys/x509_verity.crt           | 30 ++++++++
>>>>    .../recipes-kernel/linux/linux_ima.inc        |  9 +--
>>>>    .../images/dm-verity-image-initramfs.bb       |  6 ++
>>>>    .../initramfs-framework-dm/dmverity           |  7 ++
>>>>    .../linux/files/dm-verity-verify.cfg          | 10 +++
>>>>    .../linux/files/dm-verity-verify.scc          |  5 ++
>>>>    recipes-kernel/linux/linux-yocto_security.inc | 10 +++
>>>>    12 files changed, 283 insertions(+), 6 deletions(-)
>>>>    create mode 100644 classes/kernel-trusted-keys.bbclass
>>>>    create mode 100644 meta-integrity/data/debug-keys/privkey_verity.pem
>>>>    create mode 100644 meta-integrity/data/debug-keys/x509_verity.crt
>>>>    create mode 100644 recipes-kernel/linux/files/dm-verity-verify.cfg
>>>>    create mode 100644 recipes-kernel/linux/files/dm-verity-verify.scc
>>>>
>>>> diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
>>>> index 48557e9..fba8454 100644
>>>> --- a/classes/dm-verity-img.bbclass
>>>> +++ b/classes/dm-verity-img.bbclass
>>>> @@ -3,6 +3,12 @@
>>>>    # Copyright (C) 2020 BayLibre SAS
>>>>    # Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>    #
>>>> +# Copyright 2026 Embetrix Embedded Systems Solutions
>>>> <ayoub.zaki@embetrix.com>
>>>
>>> Please use "Copyright (C)" for consistency, this applies to the other
>>> files changed/added as well.
>>
>> Agreed, will fix for consistency.
>>
> [snip]
>>>> +do_shared_workdir:append() {
>>>> +    if [ -f trusted_keys.pem ]; then
>>>> +        cp trusted_keys.pem $kerneldir/
>>>> +    fi
>>>> +}
>>>
>>> Since you're storing this aggregated set of keys in work-shared, it
>>> probably needs to be explicitly documented that TMPDIR should not be
>>> accessible by other users, as that may not be obvious to some folks.
>>>
>>
>> Worth noting that the "trusted keys" naming here is inherited from the
>> kernel's own CONFIG_SYSTEM_TRUSTED_KEYS convention and is somewhat misleading:
>> these are certificates only. The kernel's built-in trusted keyring does not
>> handle private keys at all.
>> The same pattern is already used by the kernel-modsign.bbclass which this was
>> modeled after.
>> That said, I'm happy to add a note clarifying this in the documentation to
>> avoid confusion.
> 
> Okay, that sounds good.
> 
>>>> diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
>>>> index a538fa2..9d326bf 100644
>>>> --- a/docs/dm-verity.txt
>>>> +++ b/docs/dm-verity.txt
>>>> @@ -121,3 +121,76 @@ INFO: The image(s) were created using OE kickstart
>>>> file:
>>>>    The "direct" image contains the partition table, bootloader, and
>>>>    dm-verity
>>>>    enabled ext4 image all in one -- ready to write to a raw device, such as
>>>>    a
>>>>    u-SD card in the case of the beaglebone.
>>>> +
>>>> +Root Hash Signature Verification
>>>> +--------------------------------
>>>> +By default, dm-verity stores the root hash as plain text in the initramfs
>>>> +at /usr/share/misc/dm-verity.env. This creates a TOCTOU (time-of-check to
>>>> +time-of-use) vulnerability: an attacker who can modify the initramfs can
>>>> +replace both the root hash and the filesystem image, defeating dm-verity.
>>>
>>> Just to double check I'm clear wrt the attack scenario, this only works
>>> if the initramfs is outside the secure boot chain, i.e. stored as a
>>> separate file from the kernel?  I'm thinking that perhaps secure boot
>>> with FIT images avoids the problem, and that's not uncommon these days.
>>> And I'm guessing initramfs bundled with the kernel might also avoid TOCTOU
>>> w/o a more elaborate attack.  If so, it might be good to be more explicit
>>> here wrt the insecure scenario.
>>>
>>
>> The scenario this addresses is precisely when the initramfs is verified at an
>> earlier boot stage (e.g. bundled with the kernel or part of a signed FIT
>> image) but there is a multi-second window between that verification and the
>> actual use of the root hash where memory contents can be modified: The
>> specific techniques to exploit this window vary depending on hardware (DMA
>> attacks, JTAG, etc.). I'll clarify this in the documentation so readers
>> understand the attack surface more precisely.
> 
> Gotcha.  I'm all for your changes as they will add another layer of
> defense, but I am curious if a determined attacker with that capability
> might also be able to flip off the signature verification flag, or
> potentially overwrite the kernel keyring?
> 
> [snip]

That's a good question : yes in theory but the difference is the attack 
magnitude: replacing a plain-text hash in RAM location is trivial 
compared to locating and patching kernel data structures in memory at 
runtime. On top of that standard kernel hardening via 
CONFIG_STRICT_KERNEL_RWX, IOMMU/SMMU makes those structures 
significantly harder to tamper with.

>>>> +These are insecure debug/test keys. Generate your own for production use.
>>>> +
>>>
>>> I would strongly prefer that we not add any more debug keys in-tree, as
>>> there's a chance someone might go ahead and use them, and they sometimes
>>> generate spam from folks running scanners on public repos (I've
>>> experienced this on other projects).  If we were to add a selftest, it
>>> can generate a key on the fly.  If there's a strong reason they should be
>>> added that I'm missing, I'd say these ones should probably not be in
>>> meta-integrity, as dm-verity-img.bbclass is in the base layer, not
>>> meta-integrity.
>>>
>>
>> Fully agree. I'll remove the in-tree debug keys. On a related note I think the
>> verity related implementation should probably land in meta-integrity as well,
>> rather than in base layer.
> 
> I can see that view, but I suspect the ship has maybe already sailed given
> the bbclass has been in meta-security for a while now.  If we were going
> to move it, we're currently in a narrow window before we create the
> wrynose branch for LTS where it might make sense.  Marta may have a
> better idea of how much impact that would be for downstreams, I'm actually
> not sure myself.
> 
> [snip]
>>> Since we're only bbappending linux-yocto in meta-security, if you'd like
>>> this to gain traction, I'd suggest extending the "Kernel Configuration"
>>> section in dm-verity.txt to outline the steps needed to add it to a
>>> vendor kernel via bbappend (i.e. adding the config fragment and required
>>> inherits).
>>
>> Good idea, I'll add a section outlining the steps needed to integrate this
>> with a vendor kernel via bbappend, covering the config fragment and required
>> inherits.
>>
>> If you agree with the above I can send a v2 addressing all those points.
> 
> That sounds good to me, please send a v2 when you have it.

I'll prepare and test the v2 then send it over.


Thanks


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


