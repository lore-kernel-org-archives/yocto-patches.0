Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF1D0C600
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 11:07:47 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.8939.1729851188447484453
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 03:13:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=MBgifnQL;
 spf=pass (domain: linaro.org, ip: 209.85.215.179, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1112371a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729851187; x=1730455987; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N1+kG9GEsDYxUpTVKNe7jXlp3KmHockqzx2LDbCDIfc=;
        b=MBgifnQLf4btkRMo1i3kn+rZcSf5ktXRENEsqHnhqQFG2wjGRSYZ7Uy2lhhxGuuEW/
         iMnEoCvZKLM6znSCHtliyErSg2ysd4R+bKZKQ33keEW21A/g4/ZATCk5v2dQPpmeFZwP
         54huO/8+3BfJgtUVxSN8D2rNootaeD7401iIT9F5P4eNq0QmxSOGDP47W+2BKyzRcOQX
         B6eYMHDVg16Jn0l6GVz/o1uBcKJXZp/bb/wqzv21xIFgiKhhvHTazJCMuGioQU2jCojF
         oHCz6k+Gp1njhbjV90L2iVkCZ71MnDvHAanXDcYgZJBL5dHLLO2jHMOES7powJiQCyR/
         VWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729851187; x=1730455987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1+kG9GEsDYxUpTVKNe7jXlp3KmHockqzx2LDbCDIfc=;
        b=QfiEzlyIZ3kPHZEsqOGVbcrBzZENokPo06tVKtDShsjI/0bwFXC+ThT4k3kPs2xfO/
         C2Mgea2IK/43SJC47W4m2Jk90tnW39aWR2FlShPnkwscSBOEYyxEZvkEhOPhKXi+tY5b
         ieUL9/SNGUkykweoHQ6DauLwX2P6dtmzcgNxA7fs+CDBSFih0Jkr6Lp69o9nsrz7147/
         68Pc7un8sXI5m8x1bJpD49uyAxsFhsxjeCYF8qj1o7RPQA7iF0XeIKz0jhaTHG8o2LcQ
         /X8ddHZZvAdfKxeqXDJx7emaJuMSva3aN5mETgXgwo0s+iKrpFjT9O6Gwd5kFK+a+Vr+
         2z7Q==
X-Gm-Message-State: AOJu0Yy984kPaVcLmo3JIiYcyjXiFMnD0Xx96auk941vPZQolO1k6NXM
	DE9CcDix7Miw6OiaQqWb5riQyayy5KpfWSNZ8yA3mJN8VwD+BTkkhMs9Q69jjliL8B1vmiYPCZn
	hyw7K9TBHDGWk4wLsXHl4LyE48rDqoUd3uzcMFw==
X-Google-Smtp-Source: AGHT+IFx4q141kIUnPkHAg8z/olnQ8+0eW+krUlGLn8mAOXllHus3MrVo3h7GvMz6sUAPPPgC6iCzr+IgwxmBzV9THA=
X-Received: by 2002:a05:6a21:1798:b0:1d2:eb91:c0c1 with SMTP id
 adf61e73a8af0-1d978bb2bacmr11553220637.42.1729851187610; Fri, 25 Oct 2024
 03:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241024212301.3304651-1-javier.tia@linaro.org>
In-Reply-To: <20241024212301.3304651-1-javier.tia@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 13:12:30 +0300
Message-ID: <CAC_iWjLiV4PDQHKT7me3Z52jFU8PqQ6=uGXdym1aByEx0AS8bw@mail.gmail.com>
Subject: Re: [meta-security][PATCH] tpm: Enable Measured Boot in U-Boot
To: Javier Tia <javier.tia@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 11:07:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/759

On Fri, 25 Oct 2024 at 00:23, Javier Tia <javier.tia@linaro.org> wrote:
>
> Measured Boot is the term used to describe the process of securely
> recording and computing hashes of code and critical data at each stage
> in the boot chain prior to their use.
>
> These measurements can be employed by other system components to
> establish a comprehensive attestation system. For example, they could be
> employed to enforce local attestation policies (such as the release of
> specific platform keys) or to securely transmit them to a remote
> challenger, also known as a verifier, post-boot to verify the condition
> of the code and critical data.
>
> Measured launch does not authenticate the code or critical data; rather,
> it records the code or critical data that was present on the system
> during boot.
>
> Initially, the TPM measures the BIOS/EFI layer in the fundamental flow.
> This measurement involves the generation of a cryptographic hash of the
> binary image and the verification of the binary instructions that this
> layer will execute. The TPM stores the generated hash in one of the
> numerous "slots" in the Platform Configuration Register (PCR). The TPM
> or entities external to the TPM can read these portions of memory at a
> later time; however, they are unalterable once they have been written.
> These memory pieces are protected by integrity protection from the
> instant they are first written. This guarantees that the value written
> to a PCR by the TPM will remain constant for the duration of the system,
> unless the system is powered off or rebooted.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg | 6 ++++++
>  meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend        | 3 +++
>  2 files changed, 9 insertions(+)
>  create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
>  create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
>
> diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
> new file mode 100644
> index 0000000..76c51ea
> --- /dev/null
> +++ b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
> @@ -0,0 +1,6 @@
> +CONFIG_TPM=y
> +CONFIG_TPM_RNG=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM2_MMIO=y
> +CONFIG_TPM2_TIS_SPI=y
> +CONFIG_TPM2_FTPM_TEE=y
> \ No newline at end of file
> diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
> new file mode 100644
> index 0000000..c5d2923
> --- /dev/null
> +++ b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -0,0 +1,3 @@
> +FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
> +
> +SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "measured-boot", "file://measured-boot.cfg", "", d)}"
> \ No newline at end of file
> --
> 2.47.0
>

FWIW
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

