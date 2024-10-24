Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D16FD10388
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 21:26:55 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
 by mx.groups.io with SMTP id smtpd.web11.7457.1729804994444862836
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 14:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HbyMJCer;
 spf=pass (domain: linaro.org, ip: 209.85.221.177, mailfrom: javier.tia@linaro.org)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d24099415so415320e0c.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729804993; x=1730409793; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifVLEPpGc+sJ6BO+U2sE5XezmqbLWOQnyoIhZSe/OWo=;
        b=HbyMJCerNrdzYH6GSok8V98EIBDDFN7TaD7yZ4R1yJ8IjDXEUSz/fw2yw3B7Hc6QHb
         Yh0Lbl7rRgNAECmrY4JCDlZfNBTxHckyxDVkFJkXchSzEbEO3hO9Gl4z0XvJGvNqQ1AW
         C2Jqi7UscPWGymQqjXzeEOKwu0Y+5C81cuvcANGog7ETJO9aftINvtoihI1YZ03CD1YY
         mDX1I2hwhkpK+icPaw5FerpWp3c4khm1rtHwJCloulOZtnIGc7vNTGNDniPV2oLwlP2r
         eYtYgOTEHtbGZ+xfRsigw8qvPsylB+nAJxvUPeg5QhlbK8c2TrrMbaEzh+h6J5iB8HP0
         /Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804993; x=1730409793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifVLEPpGc+sJ6BO+U2sE5XezmqbLWOQnyoIhZSe/OWo=;
        b=TsK64iga5byGLKvvMAAZiJJDrECbdalw7sny7Ecd9wEIWH7e7aQr3jw8OQvwMvhzFw
         pSU3uanhd11Cs81ql9smJir8qkAKa6TW30iif/Az0p3Ne5142iQo8YFMgB/K8UPMBpt4
         aZepn/qXxehG/WYFdJhfjd+TbyD9wb+xAlS2KZGvnt2RjLUNi9M2mjDfXv+/Uqek14hL
         p/s0ZXesxXYV+zQSkaUy7YVZh1PwoCPrLAdw12k6d1xfY2GDt5u4xxt3QqwU03Acmtpr
         dTPVKw9n4anJLuvwY9zqdLOCv7QNk09l5IyX5YD4lhxDKpThjqtlCH300QRyQ8SjTTDD
         ZbOQ==
X-Gm-Message-State: AOJu0YxXroWJUcT5PG3ldFll33pP1TYDEf+qaLDobEyKagf4CNZd19Lf
	dvm0/zvM8IroT0SS9JH/qnFePNEoeSRfx/N6/bKRQDRJIREc1T3ZDaMDJj5/uBVuDwYIgGgmZ/2
	w
X-Google-Smtp-Source: AGHT+IG9xR9wrQMFKBJI9kfNDVO5r8dYQ+/aR4+9wwveO9bO+p3wHsq9sRUfqkC9+UPWawI37Eb2WQ==
X-Received: by 2002:a05:6122:169f:b0:50c:79a4:c25 with SMTP id 71dfb90a1353d-50fd03049camr8566065e0c.8.1729804993168;
        Thu, 24 Oct 2024 14:23:13 -0700 (PDT)
Received: from localhost.localdomain ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f8effesm1455011e0c.48.2024.10.24.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:23:12 -0700 (PDT)
From: "Javier Tia" <javier.tia@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Javier Tia <javier.tia@linaro.org>
Subject: [meta-security][PATCH] tpm: Enable Measured Boot in U-Boot
Date: Thu, 24 Oct 2024 15:23:01 -0600
Message-ID: <20241024212301.3304651-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 21:26:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/745

Measured Boot is the term used to describe the process of securely
recording and computing hashes of code and critical data at each stage
in the boot chain prior to their use.

These measurements can be employed by other system components to
establish a comprehensive attestation system. For example, they could be
employed to enforce local attestation policies (such as the release of
specific platform keys) or to securely transmit them to a remote
challenger, also known as a verifier, post-boot to verify the condition
of the code and critical data.

Measured launch does not authenticate the code or critical data; rather,
it records the code or critical data that was present on the system
during boot.

Initially, the TPM measures the BIOS/EFI layer in the fundamental flow.
This measurement involves the generation of a cryptographic hash of the
binary image and the verification of the binary instructions that this
layer will execute. The TPM stores the generated hash in one of the
numerous "slots" in the Platform Configuration Register (PCR). The TPM
or entities external to the TPM can read these portions of memory at a
later time; however, they are unalterable once they have been written.
These memory pieces are protected by integrity protection from the
instant they are first written. This guarantees that the value written
to a PCR by the TPM will remain constant for the duration of the system,
unless the system is powered off or rebooted.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg | 6 ++++++
 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend        | 3 +++
 2 files changed, 9 insertions(+)
 create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
 create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend

diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
new file mode 100644
index 0000000..76c51ea
--- /dev/null
+++ b/meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
@@ -0,0 +1,6 @@
+CONFIG_TPM=y
+CONFIG_TPM_RNG=y
+CONFIG_CMD_TPM=y
+CONFIG_TPM2_MMIO=y
+CONFIG_TPM2_TIS_SPI=y
+CONFIG_TPM2_FTPM_TEE=y
\ No newline at end of file
diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
new file mode 100644
index 0000000..c5d2923
--- /dev/null
+++ b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -0,0 +1,3 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "measured-boot", "file://measured-boot.cfg", "", d)}"
\ No newline at end of file
-- 
2.47.0


