Return-Path: <javier.tia@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D6D149F6
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 22:02:03 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web10.766.1729893716750219750
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 15:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=d8VAy3zu;
 spf=pass (domain: linaro.org, ip: 209.85.219.45, mailfrom: javier.tia@linaro.org)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso30110406d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729893716; x=1730498516; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCXBxLkkze0gHCwcsSAroUGfu5g9A8Rw8qMV0GYdJXY=;
        b=d8VAy3zuyW8CVDUVR9rPiOWXGuV26jWKizllKXzjA2e2YWcb6KX7Shf5BfLWsSZ673
         SdNGgxj3OQqIC/x0FYGRL4qlm6+gXIrO+0KWBM5twEpBSDykNI2vObsw3S/+70ByggJB
         kj8HHztyJ/pRjMXJJvwof97U6s7l/ZCFR92Cm8jF1INM/EAZYo+Zp60t+zZn7FhiWjzx
         QZsWekPxJj1nYrzUTUzcP490b22fRLbh95QdoXwgd/Q+RyrP2FHdlx+wpCA2wVg0DjDx
         rJSK/XrdgOphTHHEEREQclnQFeTM6BFjZefjlLW6l3uNycg45b0IUJnbdCkdz8JwGS76
         ZJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893716; x=1730498516;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCXBxLkkze0gHCwcsSAroUGfu5g9A8Rw8qMV0GYdJXY=;
        b=qY+J9D5T+i0RDR+sOsAMzqQmwzLCnbLV/c5NNMMy1B3JE5zjPc6YAF0qYaGubyZWF+
         yISuzLX8JsyNyeG7socTxY+V3yGqw7t/Egg5sY+nATA9CkP5DjIkdHxRSNCJcCqQBBh3
         trNi4+hfCEAqluTvi07pin0w7JH2An/PQC7C+rRwxu1e74NJq/Vr4gBD70zS6axS3Wqn
         OfECtAZo8pT47s0plaa8gPmWPXJys3KTVYFTP32i6EwDa7gkpfT1ct7js4jUB6fLKULs
         7F0iYhYOD3xHvHHKuYCWfjAs6vgR7a6e3Wr70yB3wkhFiiJATO3mchjEHy6R9b6IToXV
         shSQ==
X-Gm-Message-State: AOJu0YyiAzHJyWqNjcvOG1BB818F0A2IxnSuYwqgCTqVjo7h2aQo6T0m
	Rxtt2IqNp8sLkNih/L0nSOTGM/QP+zv6EAjnmBELb0Z7PvCk7wJEno2WU6nx0BA=
X-Google-Smtp-Source: AGHT+IG2YWSJjJF3SwgpeNiMFf3b9EvcU3mEiOTFd9Jrs8wh8SVTcICwEtYYyKHaTOKBPfAP68FJ0Q==
X-Received: by 2002:a05:6214:5083:b0:6cb:c845:ed0f with SMTP id 6a1803df08f44-6d0890c4031mr134081526d6.17.1729893715624;
        Fri, 25 Oct 2024 15:01:55 -0700 (PDT)
Received: from [192.168.8.164] ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c5234378sm324155137.10.2024.10.25.15.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:01:54 -0700 (PDT)
Message-ID: <ef14ec6b-73c2-486c-a50a-ca7f64f32c0b@linaro.org>
Date: Fri, 25 Oct 2024 16:01:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] tpm: Enable Measured Boot in U-Boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org,
 Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20241024212301.3304651-1-javier.tia@linaro.org>
 <CAC_iWjLiV4PDQHKT7me3Z52jFU8PqQ6=uGXdym1aByEx0AS8bw@mail.gmail.com>
From: Javier Tia <javier.tia@linaro.org>
Content-Language: en-US, es-MX
Autocrypt: addr=javier.tia@linaro.org; keydata=
 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
 WdJQjTu3/NJR54YogRY=
In-Reply-To: <CAC_iWjLiV4PDQHKT7me3Z52jFU8PqQ6=uGXdym1aByEx0AS8bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 22:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/762

Hi,

On 10/25/24 4:12 AM, Ilias Apalodimas wrote:
> On Fri, 25 Oct 2024 at 00:23, Javier Tia <javier.tia@linaro.org> wrote:
>>
>> Measured Boot is the term used to describe the process of securely
>> recording and computing hashes of code and critical data at each stage
>> in the boot chain prior to their use.
>>
>> These measurements can be employed by other system components to
>> establish a comprehensive attestation system. For example, they could be
>> employed to enforce local attestation policies (such as the release of
>> specific platform keys) or to securely transmit them to a remote
>> challenger, also known as a verifier, post-boot to verify the condition
>> of the code and critical data.
>>
>> Measured launch does not authenticate the code or critical data; rather,
>> it records the code or critical data that was present on the system
>> during boot.
>>
>> Initially, the TPM measures the BIOS/EFI layer in the fundamental flow.
>> This measurement involves the generation of a cryptographic hash of the
>> binary image and the verification of the binary instructions that this
>> layer will execute. The TPM stores the generated hash in one of the
>> numerous "slots" in the Platform Configuration Register (PCR). The TPM
>> or entities external to the TPM can read these portions of memory at a
>> later time; however, they are unalterable once they have been written.
>> These memory pieces are protected by integrity protection from the
>> instant they are first written. This guarantees that the value written
>> to a PCR by the TPM will remain constant for the duration of the system,
>> unless the system is powered off or rebooted.
>>
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>>   meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg | 6 ++++++
>>   meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend        | 3 +++
>>   2 files changed, 9 insertions(+)
>>   create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
>>   create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
>>
>> diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
>> new file mode 100644
>> index 0000000..76c51ea
>> --- /dev/null
>> +++ b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
>> @@ -0,0 +1,6 @@
>> +CONFIG_TPM=y
>> +CONFIG_TPM_RNG=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_MMIO=y
>> +CONFIG_TPM2_TIS_SPI=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> \ No newline at end of file
>> diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
>> new file mode 100644
>> index 0000000..c5d2923
>> --- /dev/null
>> +++ b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
>> @@ -0,0 +1,3 @@
>> +FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>> +
>> +SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "measured-boot", "file://measured-boot.cfg", "", d)}"
>> \ No newline at end of file
>> --
>> 2.47.0
>>
> 
> FWIW
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied in patch series v1. Thanks,

» Javier Tia 🖋

