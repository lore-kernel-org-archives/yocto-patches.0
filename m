Return-Path: <ayoub.zaki@embetrix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC72F9EDC3
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 12:00:19 +0000 (UTC)
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.80764.1776859210449483155
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 05:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@embetrix.com header.s=rsa2 header.b=b1QhGMEp;
 dkim=pass header.i=@embetrix.com header.s=ed2 header.b=KSm6/pRn;
 spf=none, err=permanent DNS error (domain: embetrix.com, ip: 46.30.212.3, mailfrom: ayoub.zaki@embetrix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776859207; x=1777464007;
	d=embetrix.com; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=6r2pdbKZ7PjGXR0MYh8vaTJEZdM8uRkGo9rkrXWK7pw=;
	b=b1QhGMEp9yRQG5x7KkPaWhmuop8Ybc0d9Y8Bzyj1g2VaZiBoQMxw0DG8H/6znDNJ7pxVkTD+/+Gir
	 GbIG4uJ5dMtG65s6VuKaXJuwBmKOCyOCJH55thyNVlQv4jk/CJt7PzlbPDU8dwNVQITGBrMVKNQKae
	 CQu6ZOrbU7x2JxGlB/RmSIBBwwoY+dOOK6/dmM4Yi/zDSKI2jZK40dSfWTBDW985pCmpq8w6nWLlbF
	 fYqUXX449D7MTANFmBM8FJLHOI4m+3mGY2DOUN9v77wutrEBCMC9X8eo7+QwxA8CopJLbD2k7PMlhQ
	 L2ixyeK6KKRiSYGn93SDHzqmqERYQJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776859207; x=1777464007;
	d=embetrix.com; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=6r2pdbKZ7PjGXR0MYh8vaTJEZdM8uRkGo9rkrXWK7pw=;
	b=KSm6/pRnC9yAg7/H7kErHGacA5j4ryO9dZ1qVfrf3zTggdao4Rr0jRGxmgjMPzmjk8pgAl6E+8mWG
	 BX6SvCVBw==
X-HalOne-ID: cc360de2-3e42-11f1-b65f-db97761f2682
Received: from [IPV6:2a02:3102:8c10:1ae0:e80e:f9fe:39ce:37f3] (dynamic-2a02-3102-8c10-1ae0-e80e-f9fe-39ce-37f3.310.pool.telefonica.de [2a02:3102:8c10:1ae0:e80e:f9fe:39ce:37f3])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id cc360de2-3e42-11f1-b65f-db97761f2682;
	Wed, 22 Apr 2026 12:00:06 +0000 (UTC)
Message-ID: <0d8fbd63-efc4-4047-9964-c1bd492835a4@embetrix.com>
Date: Wed, 22 Apr 2026 14:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity: add PKCS#7 root
 hash signature support
To: yocto-patches@lists.yoctoproject.org
Cc: rybczynska@gmail.com
References: <20260420135525.130421-1-ayoub.zaki@embetrix.com>
 <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <6518c92a-bca5-0dbd-65fe-4d61bd5c6178@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 12:00:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3759

Hi Scott, Marta,

Thanks for the review and for testing effort.

On 4/21/26 22:45, Scott Murray via lists.yoctoproject.org wrote:
> On Mon, 20 Apr 2026, Ayoub Zaki via lists.yoctoproject.org wrote:
> 
>> The dm-verity root hash stored in the initramfs is vulnerable to TOCTOU
>> attacks. Mitigate this by signing the root hash at build time and
>> verifying it from the kernel via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
>> The signature is deployed into the initramfs while the signing certificate
>> is embedded in the kernel's built-in trusted keyring.
>>
>> - dm-verity-img.bbclass: sign root hash with openssl smime when DM_VERITY_SIGN=1
>> - kernel-trusted-keys.bbclass: new shared class to collect PEM certs
>>    into trusted_keys.pem via KERNEL_TRUSTED_CERTS variable
>> - linux-yocto_security.inc: add kernel config fragments and append
>>    signing cert via KERNEL_TRUSTED_CERTS
>> - dm-verity-image-initramfs.bb: deploy .p7s signature
>> - dmverity initrd script: pass --root-hash-signature to veritysetup
>> - linux_ima.inc: use KERNEL_TRUSTED_CERTS instead of absolute path in
>>    CONFIG_SYSTEM_TRUSTED_KEYS, fixing buildpaths QA
>> - Add debug/test keys and documentation
>>
>> Signing is not enabled by default for backward compatibility but is
>> strongly recommended for production deployments.
> 
> I believe Marta is doing some testing of this, and I'll try to do some
> as well in the next couple of days.  I do have some comments that I'll put
> inline below.
> 
>> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>> ---
>>   classes/dm-verity-img.bbclass                 | 46 +++++++++++-
>>   classes/kernel-trusted-keys.bbclass           | 34 +++++++++
>>   docs/dm-verity.txt                            | 73 +++++++++++++++++++
>>   meta-integrity/data/debug-keys/README.md      |  7 ++
>>   .../data/debug-keys/privkey_verity.pem        | 52 +++++++++++++
>>   .../data/debug-keys/x509_verity.crt           | 30 ++++++++
>>   .../recipes-kernel/linux/linux_ima.inc        |  9 +--
>>   .../images/dm-verity-image-initramfs.bb       |  6 ++
>>   .../initramfs-framework-dm/dmverity           |  7 ++
>>   .../linux/files/dm-verity-verify.cfg          | 10 +++
>>   .../linux/files/dm-verity-verify.scc          |  5 ++
>>   recipes-kernel/linux/linux-yocto_security.inc | 10 +++
>>   12 files changed, 283 insertions(+), 6 deletions(-)
>>   create mode 100644 classes/kernel-trusted-keys.bbclass
>>   create mode 100644 meta-integrity/data/debug-keys/privkey_verity.pem
>>   create mode 100644 meta-integrity/data/debug-keys/x509_verity.crt
>>   create mode 100644 recipes-kernel/linux/files/dm-verity-verify.cfg
>>   create mode 100644 recipes-kernel/linux/files/dm-verity-verify.scc
>>
>> diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
>> index 48557e9..fba8454 100644
>> --- a/classes/dm-verity-img.bbclass
>> +++ b/classes/dm-verity-img.bbclass
>> @@ -3,6 +3,12 @@
>>   # Copyright (C) 2020 BayLibre SAS
>>   # Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>   #
>> +# Copyright 2026 Embetrix Embedded Systems Solutions <ayoub.zaki@embetrix.com>
> 
> Please use "Copyright (C)" for consistency, this applies to the other
> files changed/added as well.

Agreed, will fix for consistency.

> 
>> +# - Added PKCS#7 root hash signature support to mitigate TOCTOU attacks.
>> +#   The root hash is signed at build time and verified by the kernel at boot
>> +#   via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG, removing the need to trust
>> +#   the initramfs as the sole root hash storage.
>> +#
>>   # This bbclass allows creating of dm-verity protected partition images. It
>>   # generates a device image file with dm-verity hash data appended at the end
>>   # plus the corresponding .env file containing additional information needed
>> @@ -49,6 +55,21 @@ DM_VERITY_SEPARATE_HASH ?= "0"
>>   # Additional arguments for veritysetup
>>   DM_VERITY_SETUP_ARGS ?= ""
>>
>> +# Root hash signing: set to "1" to generate a PKCS#7 signature of the root
>> +# hash that the kernel verifies via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
>> +DM_VERITY_SIGN ?= "0"
>> +
>> +# No default! Either this or DM_VERITY_SIGN_KEY/DM_VERITY_SIGN_CERT have
>> +# to be set explicitly in a local.conf before enabling DM_VERITY_SIGN.
>> +DM_VERITY_SIGN_KEY_DIR ?= "DM_VERITY_SIGN_KEY_DIR_NOT_SET"
>> +
>> +# Private key (PEM) used to sign the root hash.
>> +DM_VERITY_SIGN_KEY ?= "${DM_VERITY_SIGN_KEY_DIR}/privkey_verity.pem"
>> +
>> +# X.509 certificate (PEM) corresponding to the signing key. This cert must
>> +# also be embedded in the kernel via CONFIG_SYSTEM_TRUSTED_KEYS.
>> +DM_VERITY_SIGN_CERT ?= "${DM_VERITY_SIGN_KEY_DIR}/x509_verity.crt"
>> +
>>   # These are arch specific.  We could probably intelligently auto-assign these?
>>   # Take x86-64 values as defaults. No impact on functionality currently.
>>   # See SD_GPT_ROOT_X86_64 and SD_GPT_ROOT_X86_64_VERITY in the spec.
>> @@ -56,7 +77,7 @@ DM_VERITY_SETUP_ARGS ?= ""
>>   DM_VERITY_ROOT_GUID ?= "4f68bce3-e8cd-4db1-96e7-fbcaf984b709"
>>   DM_VERITY_RHASH_GUID ?= "2c7357ed-ebd2-46d9-aec1-23d437ec2bf5"
>>
>> -DEPENDS += "bc-native"
>> +DEPENDS += "bc-native ${@bb.utils.contains('DM_VERITY_SIGN', '1', 'openssl-native', '', d)}"
>>
>>   # Process the output from veritysetup and generate the corresponding .env
>>   # file. The output from veritysetup is not very machine-friendly so we need to
>> @@ -160,6 +181,29 @@ verity_setup() {
>>       # Let's drop the first line of output (doesn't contain any useful info)
>>       # and feed the rest to another function.
>>       veritysetup $SETUP_ARGS | tail -n +2 | process_verity
>> +
>> +    if [ ${DM_VERITY_SIGN} -eq 1 ]; then
>> +        if [ ! -f "${DM_VERITY_SIGN_KEY}" ]; then
>> +            bbfatal "DM_VERITY_SIGN_KEY not found: ${DM_VERITY_SIGN_KEY}"
>> +        fi
>> +        if [ ! -f "${DM_VERITY_SIGN_CERT}" ]; then
>> +            bbfatal "DM_VERITY_SIGN_CERT not found: ${DM_VERITY_SIGN_CERT}"
>> +        fi
>> +
>> +        local ENV="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.verity.env"
>> +        local SIG="${ENV}.p7s"
>> +        local ROOTHASH=$(cat $ENV | grep ^ROOT_HASH | sed 's/ROOT_HASH=//')
>> +        local HASH_HEX=$(mktemp)
>> +
>> +        echo -n "$ROOTHASH" > $HASH_HEX
>> +
>> +        openssl smime -sign -nocerts -noattr -binary \
>> +            -in $HASH_HEX \
>> +            -inkey ${DM_VERITY_SIGN_KEY} -signer ${DM_VERITY_SIGN_CERT} \
>> +            -outform der -out $SIG
>> +
>> +        rm -f $HASH_HEX
>> +    fi
>>   }
>>
>>   # make "dateless" symlink for the hash so the wks can find it.
>> diff --git a/classes/kernel-trusted-keys.bbclass b/classes/kernel-trusted-keys.bbclass
>> new file mode 100644
>> index 0000000..5b0cbac
>> --- /dev/null
>> +++ b/classes/kernel-trusted-keys.bbclass
>> @@ -0,0 +1,34 @@
>> +#
>> +# Copyright 2026 Embetrix Embedded Systems Solutions <ayoub.zaki@embetrix.com>
>> +#
>> +# Collect PEM certificates into a shared trusted_keys.pem bundle
>> +# for CONFIG_SYSTEM_TRUSTED_KEYS. Multiple features (IMA, dm-verity
>> +# signing, etc.) can append their certs to KERNEL_TRUSTED_CERTS.
>> +#
>> +# Usage from other classes or .inc files:
>> +#   KERNEL_TRUSTED_CERTS:append = " ${MY_CERT_PATH}"
>> +#   inherit kernel-trusted-keys
>> +
>> +KERNEL_TRUSTED_CERTS ?= ""
>> +
>> +do_configure:append() {
>> +    if [ -f .config ]; then
>> +        for cert in ${KERNEL_TRUSTED_CERTS}; do
>> +            if [ -f "$cert" ]; then
>> +                if ! grep -q "BEGIN CERTIFICATE" "$cert"; then
>> +                    bbfatal "$cert is not in PEM format"
>> +                fi
>> +                cat "$cert" >> "${B}/trusted_keys.pem"
>> +            fi
>> +        done
>> +        if [ -f "${B}/trusted_keys.pem" ]; then
>> +            echo 'CONFIG_SYSTEM_TRUSTED_KEYS="trusted_keys.pem"' >> .config
>> +        fi
>> +    fi
>> +}
>> +
>> +do_shared_workdir:append() {
>> +    if [ -f trusted_keys.pem ]; then
>> +        cp trusted_keys.pem $kerneldir/
>> +    fi
>> +}
> 
> Since you're storing this aggregated set of keys in work-shared, it
> probably needs to be explicitly documented that TMPDIR should not be
> accessible by other users, as that may not be obvious to some folks.
> 

Worth noting that the "trusted keys" naming here is inherited from the 
kernel's own CONFIG_SYSTEM_TRUSTED_KEYS convention and is somewhat 
misleading: these are certificates only. The kernel's built-in trusted 
keyring does not handle private keys at all.
The same pattern is already used by the kernel-modsign.bbclass which 
this was modeled after.
That said, I'm happy to add a note clarifying this in the documentation 
to avoid confusion.

>> diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
>> index a538fa2..9d326bf 100644
>> --- a/docs/dm-verity.txt
>> +++ b/docs/dm-verity.txt
>> @@ -121,3 +121,76 @@ INFO: The image(s) were created using OE kickstart file:
>>   The "direct" image contains the partition table, bootloader, and dm-verity
>>   enabled ext4 image all in one -- ready to write to a raw device, such as a
>>   u-SD card in the case of the beaglebone.
>> +
>> +Root Hash Signature Verification
>> +--------------------------------
>> +By default, dm-verity stores the root hash as plain text in the initramfs
>> +at /usr/share/misc/dm-verity.env. This creates a TOCTOU (time-of-check to
>> +time-of-use) vulnerability: an attacker who can modify the initramfs can
>> +replace both the root hash and the filesystem image, defeating dm-verity.
> 
> Just to double check I'm clear wrt the attack scenario, this only works
> if the initramfs is outside the secure boot chain, i.e. stored as a
> separate file from the kernel?  I'm thinking that perhaps secure boot
> with FIT images avoids the problem, and that's not uncommon these days.
> And I'm guessing initramfs bundled with the kernel might also avoid TOCTOU
> w/o a more elaborate attack.  If so, it might be good to be more explicit
> here wrt the insecure scenario.
> 

The scenario this addresses is precisely when the initramfs is verified 
at an earlier boot stage (e.g. bundled with the kernel or part of a 
signed FIT image) but there is a multi-second window between that 
verification and the actual use of the root hash where memory contents 
can be modified: The specific techniques to exploit this window vary 
depending on hardware (DMA attacks, JTAG, etc.). I'll clarify this in 
the documentation so readers understand the attack surface more precisely.

>> +To mitigate this, the root hash can be cryptographically signed at build
>> +time using PKCS#7. The signature is deployed into the initramfs and passed
>> +to veritysetup via --root-hash-signature. The kernel then verifies the
>> +signature against certificates embedded in its built-in trusted keyring
>> +(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG). No certificate is stored in the
>> +initramfs and the trust anchor is the kernel binary itself.
>> +
>> +This feature requires a secure boot chain to protect the kernel image.
>> +
>> +Signing Setup
>> +~~~~~~~~~~~~~
>> +1. Generate a signing key pair (do this once, keep the private key safe):
>> +
>> +   openssl req -new -x509 -newkey rsa:4096 -nodes \
>> +       -keyout privkey_verity.pem -out x509_verity.crt \
>> +       -days 3650 -subj "/CN=dm-verity signing key"
>> +
>> +2. Add the following to your conf/local.conf or distro config:
>> +
>> +   DM_VERITY_SIGN = "1"
>> +   DM_VERITY_SIGN_KEY_DIR = "/path/to/keys"
>> +
>> +   The key directory should contain privkey_verity.pem (private key) and
>> +   x509_verity.crt (X.509 certificate). The certificate serves a dual
>> +   purpose:
>> +   - It is used by openssl at build time to create the PKCS#7 signature
>> +   - It is embedded into the kernel via CONFIG_SYSTEM_TRUSTED_KEYS so the
>> +     kernel can verify the signature at boot
>> +
>> +   Alternatively, set DM_VERITY_SIGN_KEY and DM_VERITY_SIGN_CERT
>> +   individually to override the default filenames.
>> +
>> +3. The build will automatically:
>> +   - Enable CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG in the kernel
>> +   - Embed the signing certificate in the kernel's trusted keyring
>> +   - Sign the root hash and produce a .p7s signature file
>> +   - Deploy the signature into the initramfs
>> +
>> +4. At boot, the initramfs dmverity script passes the signature to
>> +   veritysetup, which forwards it to the kernel. The kernel verifies
>> +   the root hash against its built-in trusted keys before activating
>> +   the dm-verity target. If verification fails, the device will not
>> +   be created and the boot will fail.
>> +
>> +Hardening
>> +~~~~~~~~~
>> +By default CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG only verifies the
>> +signature when one is provided. A dm-verity target created without a
>> +signature will still be accepted. To enforce that ALL dm-verity targets
>> +must have a valid root hash signature, add the following to the kernel
>> +command line:
>> +
>> +   dm_verity.require_signatures=1
>> +
>> +With this parameter set, any attempt to create a dm-verity device
>> +without a valid PKCS#7 signature will be rejected by the kernel. This
>> +is strongly recommended for production deployments.
>> +
>> +Compatibility Notes
>> +~~~~~~~~~~~~~~~~~~~
>> +- Signing is optional but strongly recommended. It is backward compatible;
>> +  when DM_VERITY_SIGN is "0" (the default) the behavior is unchanged.
>> +- Both appended hash and separate hash partition modes support signing.
>> +- The signing certificate can coexist with other certificates already set
>> +  in CONFIG_SYSTEM_TRUSTED_KEYS (e.g. for IMA/EVM).
>> diff --git a/meta-integrity/data/debug-keys/README.md b/meta-integrity/data/debug-keys/README.md
>> index e613968..9a5626f 100644
>> --- a/meta-integrity/data/debug-keys/README.md
>> +++ b/meta-integrity/data/debug-keys/README.md
>> @@ -7,6 +7,13 @@ The following IMA & EVM debug/test keys are in this directory
>>   - privkey_ima.pem: IMA & EVM private key used for signing files
>>   - x509_ima.der: Certificate containing public key (of privkey_ima.pem) to verify signatures
>>
>> +## dm-verity root hash signing keys
>> +
>> +- privkey_verity.pem: Private key for signing the dm-verity root hash
>> +- x509_verity.crt: X.509 certificate embedded in the kernel to verify root hash signatures
>> +
>> +These are insecure debug/test keys. Generate your own for production use.
>> +
> 
> I would strongly prefer that we not add any more debug keys in-tree, as
> there's a chance someone might go ahead and use them, and they sometimes
> generate spam from folks running scanners on public repos (I've
> experienced this on other projects).  If we were to add a selftest, it
> can generate a key on the fly.  If there's a strong reason they should be
> added that I'm missing, I'd say these ones should probably not be in
> meta-integrity, as dm-verity-img.bbclass is in the base layer, not
> meta-integrity.
> 

Fully agree. I'll remove the in-tree debug keys. On a related note I 
think the verity related implementation should probably land in 
meta-integrity as well, rather than in base layer.


>>   The CA's (self-signed) certificate can be used to verify the validity of
>>   the x509_ima.der certificate. Since the CA certificate will be built into
>>   the Linux kernel, any key (x509_ima.der) loaded onto the .ima keyring must
>> diff --git a/meta-integrity/data/debug-keys/privkey_verity.pem b/meta-integrity/data/debug-keys/privkey_verity.pem
>> new file mode 100644
>> index 0000000..782bf77
>> --- /dev/null
>> +++ b/meta-integrity/data/debug-keys/privkey_verity.pem
>> @@ -0,0 +1,52 @@
>> +-----BEGIN PRIVATE KEY-----
>> +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
>> +tXDzfFcrGmA/vPQoipJjFBAKCa+3GQ==
>> +-----END PRIVATE KEY-----
>> diff --git a/meta-integrity/data/debug-keys/x509_verity.crt b/meta-integrity/data/debug-keys/x509_verity.crt
>> new file mode 100644
>> index 0000000..8cb3ee4
>> --- /dev/null
>> +++ b/meta-integrity/data/debug-keys/x509_verity.crt
>> @@ -0,0 +1,30 @@
>> +-----BEGIN CERTIFICATE-----
>> +MIIFLTCCAxWgAwIBAgIUNvaZTG/goboDKXsPVVJA5WSVG18wDQYJKoZIhvcNAQEL
>> +BQAwJjEkMCIGA1UEAwwbZG0tdmVyaXR5IGRlYnVnIHNpZ25pbmcga2V5MB4XDTI2
>> +MDQyMDExMDMzNloXDTM2MDQxNzExMDMzNlowJjEkMCIGA1UEAwwbZG0tdmVyaXR5
>> +IGRlYnVnIHNpZ25pbmcga2V5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
>> +AgEAn1iRiywbn1iAAyKKRM6eggIXaXtrntpKHqp7i64lhpgA1qlV1vzUDfz+IXC3
>> +rSxGH8+V2xeExMRzy5ffRORlWzJNqFcscVzR26wgacWIgdsnC2yGrma7Rl28xH+p
>> +nrjrGrITdfYuruadKcIW9SwYS0Fvnw1iVzDRFEFlsUGPsaB4kH/U9e7gt+U1v+Dn
>> +W76Y7/TZs5OTQniLT/HT7jmokRVoPw0UgbPxnkLdnv8cEzkeKeW1cokfJEPvwEnL
>> +zA2tku3LQg98kHHf/7rH6GMIC03zkUxY+CbmL/7Tlt8B++fae8r1HEcej+1897Th
>> +LQuisSsXKwEe1ENe6Epqj3/f6mhqEsrjTeCiCteI10RqF2E35SyVetHPbqlzJ6k+
>> +2hSMg5HmeHdx+x9wDehNlggYC0mz3fTrB7DXP5917erdOzVn1SWOYHIl4If6c+1P
>> +BW+g8avl24A8EbS6NEKX7EX1FGhD6JGF2tBDOq26LdBBqREAfcvOhMhwEUwomqnE
>> +W+yd/UJ85ExJ8xZvBiTDeZMGMZpB2Ks7Lv/0XMPkHVgQPytA8Q0UOdHo0/A97IeN
>> +yfnMXymslJGdxuKlvhDGGK33pY2WXpjL9JgKgqpi+O9QvKjgBcSVVPgLS7Ds0Sbv
>> +RxQWRaE2OS3sRaPbcc/GBmEs4BVUoRj7R2MLke/5jiVjXWUCAwEAAaNTMFEwHQYD
>> +VR0OBBYEFNZByJG6BCzRmJTJWYPlckchsLWRMB8GA1UdIwQYMBaAFNZByJG6BCzR
>> +mJTJWYPlckchsLWRMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggIB
>> +ACgdmIPvJ1/Z6ue+UCExzPld/HqPH7sW3YvCBvdlU0fG7Z91wTgvZ1R29wKnDkPD
>> +PdwMW4gJjbI5ZCgRwEXA45PQ8AJoebRMFdS846qedPx8dfiIKqfTnGippaW2ygIf
>> +oNpOJXMJNxgTyXl1uJh5P4Y3ZIYAmJ+2k5Kud978Vw8phKu1UnM+RcXgYHVX8kws
>> +9/RI+6I/HWIPFrFMuNd6cy6YlSSg3w60MU5hn+e1MPniXTL9y77/i9bL+RtgPdPw
>> +ArAE50HZ0R2dVHgk8gGe9pmFEc7IxkWAZDZgd5DghZMOEpKlPVvQsgLjl/C6vzQn
>> +3Jv+jQ9QwrTry1EAerMbPDQajwhaoXPnRVi59igtktQ02ioLdKyxZBd4v4nHyK7Z
>> +DUzFzMfBOnYBxBy9GyDe5jHKT/wqK2Q5Jgqp2IHF/SBsqhey6EYbPp3XWEJp6j8I
>> +cSgOHwRtJaHl2ZRmCLElpB29xFWBLsmttECC1rRgGt1Rb6DHu0FuNtXg/gXVPo5k
>> +TloerUsE038QJg+lZdFlv6LaXE2NVZ4iWCBjXrGliGPhMk4qwXXJLzIlF/kAEk1R
>> +Rk+wHohrCY/tUBJ6TizGmH8yprc6da0g+QPbc7glM6XhefDX23SNEEojgWNbZrc9
>> +0qL3dZgj+Jc2i030KD6eN61f5ZKh6aODHSSkGG2cqJTk
>> +-----END CERTIFICATE-----
>> diff --git a/meta-integrity/recipes-kernel/linux/linux_ima.inc b/meta-integrity/recipes-kernel/linux/linux_ima.inc
>> index 415476a..fbedaf9 100644
>> --- a/meta-integrity/recipes-kernel/linux/linux_ima.inc
>> +++ b/meta-integrity/recipes-kernel/linux/linux_ima.inc
>> @@ -1,9 +1,8 @@
>> +IMA_EVM_KEY_DIR ?= "IMA_EVM_KEY_DIR_NOT_SET"
>> +IMA_EVM_ROOT_CA ?= "${IMA_EVM_KEY_DIR}/ima-local-ca.pem"
>>
>> -do_configure:append() {
>> -    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'yes', '', d)}" = "yes" ] && [ -f .config ] ; then
>> -        sed -i "s|^CONFIG_SYSTEM_TRUSTED_KEYS=.*|CONFIG_SYSTEM_TRUSTED_KEYS=\"${IMA_EVM_ROOT_CA}\"|" .config
>> -    fi
>> -}
>> +KERNEL_TRUSTED_CERTS:append = " ${@d.getVar('IMA_EVM_ROOT_CA') if bb.utils.contains('DISTRO_FEATURES', 'ima', True, False, d) else ''}"
>> +inherit kernel-trusted-keys
>>
>>   KERNEL_FEATURES:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'modsign', ' features/ima/modsign.scc', '', d)}"
>>   KERNEL_FEATURES:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ima', ' features/ima/ima.scc', '', d)}"
>> diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/recipes-core/images/dm-verity-image-initramfs.bb
>> index 7ed83dc..41fa53a 100644
>> --- a/recipes-core/images/dm-verity-image-initramfs.bb
>> +++ b/recipes-core/images/dm-verity-image-initramfs.bb
>> @@ -39,5 +39,11 @@ deploy_verity_hash() {
>>       install -D -m 0644 \
>>           ${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env \
>>           ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.env
>> +
>> +    local SIG="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env.p7s"
>> +    if [ -f "$SIG" ]; then
>> +        install -D -m 0644 "$SIG" \
>> +            ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.sig
>> +    fi
>>   }
>>   IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash;"
>> diff --git a/recipes-core/initrdscripts/initramfs-framework-dm/dmverity b/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
>> index 1923490..20b06f2 100644
>> --- a/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
>> +++ b/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
>> @@ -12,6 +12,11 @@ dmverity_run() {
>>
>>       . /usr/share/misc/dm-verity.env
>>
>> +    ROOTHASH_SIG_ARG=""
>> +    if [ -f /usr/share/misc/dm-verity.sig ]; then
>> +        ROOTHASH_SIG_ARG="--root-hash-signature=/usr/share/misc/dm-verity.sig"
>> +    fi
>> +
>>       C=0
>>       delay=${bootparam_rootdelay:-1}
>>       timeout=${bootparam_roottimeout:-5}
>> @@ -30,6 +35,7 @@ dmverity_run() {
>>
>>           veritysetup \
>>               --data-block-size=${DATA_BLOCK_SIZE} \
>> +            ${ROOTHASH_SIG_ARG} \
>>               create rootfs \
>>               /dev/disk/by-partuuid/${ROOT_UUID} \
>>               /dev/disk/by-partuuid/${RHASH_UUID} \
>> @@ -81,6 +87,7 @@ dmverity_run() {
>>       veritysetup \
>>           --data-block-size=${DATA_BLOCK_SIZE} \
>>           --hash-offset=${DATA_SIZE} \
>> +        ${ROOTHASH_SIG_ARG} \
>>           create rootfs \
>>           ${RDEV} \
>>           ${RDEV} \
>> diff --git a/recipes-kernel/linux/files/dm-verity-verify.cfg b/recipes-kernel/linux/files/dm-verity-verify.cfg
>> new file mode 100644
>> index 0000000..aba6a67
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/dm-verity-verify.cfg
>> @@ -0,0 +1,10 @@
>> +CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
>> +CONFIG_KEYS=y
>> +CONFIG_ASYMMETRIC_KEY_TYPE=y
>> +CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>> +CONFIG_X509_CERTIFICATE_PARSER=y
>> +CONFIG_PKCS7_MESSAGE_PARSER=y
>> +CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> +CONFIG_SYSTEM_TRUSTED_KEYS="trusted_keys.pem"
>> +CONFIG_CRYPTO_RSA=y
>> +CONFIG_CRYPTO_SHA256=y
>> diff --git a/recipes-kernel/linux/files/dm-verity-verify.scc b/recipes-kernel/linux/files/dm-verity-verify.scc
>> new file mode 100644
>> index 0000000..2af676a
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/dm-verity-verify.scc
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: MIT
>> +define KFEATURE_DESCRIPTION "Enable dm-verity root hash signature verification"
>> +define KFEATURE_COMPATIBILITY board
>> +
>> +kconf hardware dm-verity-verify.cfg
>> diff --git a/recipes-kernel/linux/linux-yocto_security.inc b/recipes-kernel/linux/linux-yocto_security.inc
>> index 3a2ff96..505f0db 100644
>> --- a/recipes-kernel/linux/linux-yocto_security.inc
>> +++ b/recipes-kernel/linux/linux-yocto_security.inc
>> @@ -5,3 +5,13 @@ KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "smack", " fe
>>   KERNEL_FEATURES:append = " ${@bb.utils.contains("IMAGE_CLASSES", "dm-verity-img", " features/device-mapper/dm-verity.scc", "" ,d)}"
>>   KERNEL_FEATURES:append = " features/ecryptfs/ecryptfs.scc"
>>   SRC_URI += " ${@bb.utils.contains("DISTRO_FEATURES", "lkrg", "file://lkrg.scc", "" ,d)}"
>> +
>> +DM_VERITY_SIGN ?= "0"
>> +DM_VERITY_SIGN_KEY_DIR ?= "DM_VERITY_SIGN_KEY_DIR_NOT_SET"
>> +DM_VERITY_SIGN_CERT ?= "${DM_VERITY_SIGN_KEY_DIR}/x509_verity.crt"
>> +
>> +SRC_URI += " ${@bb.utils.contains("DM_VERITY_SIGN", "1", "file://dm-verity-verify.scc file://dm-verity-verify.cfg", "" ,d)}"
>> +KERNEL_FEATURES:append = " ${@bb.utils.contains("DM_VERITY_SIGN", "1", " dm-verity-verify.scc", "" ,d)}"
>> +
>> +KERNEL_TRUSTED_CERTS:append = " ${@d.getVar('DM_VERITY_SIGN_CERT') if d.getVar('DM_VERITY_SIGN') == '1' else ''}"
>> +inherit kernel-trusted-keys
> 
> Since we're only bbappending linux-yocto in meta-security, if you'd like
> this to gain traction, I'd suggest extending the "Kernel Configuration"
> section in dm-verity.txt to outline the steps needed to add it to a
> vendor kernel via bbappend (i.e. adding the config fragment and required
> inherits).

Good idea, I'll add a section outlining the steps needed to integrate 
this with a vendor kernel via bbappend, covering the config fragment and 
required inherits.

If you agree with the above I can send a v2 addressing all those points.

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


