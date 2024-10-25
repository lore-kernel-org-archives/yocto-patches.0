Return-Path: <javier.tia@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42402D149F6
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 22:03:03 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.805.1729893773596720325
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 15:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WD3S+IBX;
 spf=pass (domain: linaro.org, ip: 209.85.219.43, mailfrom: javier.tia@linaro.org)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso30117436d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729893772; x=1730498572; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtKZoaW6H7xdmxxhcrA0W+ikc9Mq0OXkqT0bkfI4A78=;
        b=WD3S+IBXuaKgqv5nVJOpG+wX5Gz/SD121lHtCQDgAEmUlxOdB2pKSIERg+6C2eBQw7
         lYcncc1enHzDL6lSzuWTaflWzMW9KQ7UDb1aEN2qY71ZAons7A6hGhfD0wJqppt9+VEe
         OzZSlnZcWtGgwwagrmcg5OwBhKySlo8hWe4iNH1P63f8mql8m9vKNQSPCylw/F58ch2h
         Oq1hb5wdTYAUDr8Pa5ZZOXKbEa+JnaJzQkV0okITxh1bDGTc7zp63JINiaeSUjygJ/nK
         zsxulo+YFBZXuvoNYIzsuzgbRbSD/oaCxiMLh0REcRtqSKx9ampGodS2LX98F9Ayxv1F
         JVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893772; x=1730498572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtKZoaW6H7xdmxxhcrA0W+ikc9Mq0OXkqT0bkfI4A78=;
        b=erukREClyNuG0NMJW8y+Yf8vUiz8+8OoXFbWDskJom+imlSUAQwCXyTTP8Sgsj/Sx3
         kOIcSVUghlu+gJtwC1bd+lpkwB+wEGheDYJg+VCGG1TnsYmjyAM8QsvSJdS6KH99p5vW
         7cXv1OmTcTYXONAMbOWn9FG2r62ZPH4zmiCxvuEdUG+Ds0ANrZzEJK1aMM4r1uee6j9j
         RbKY8wbCXfx2PtrqGoBfcd2czzOG1NVkIYYphap6z67HyZO01yqlTuHE2i7R1YbcUw1N
         YpxvRsA5tTjGQGvkZdF26sro6OYqiWp8dbafrzCrQwo4yx4OtzpYpIYmJZ+EWikIIzxW
         iLsw==
X-Gm-Message-State: AOJu0Ywq1XSRGHKKuWNnRmDjMh6UyT0HG6od7zlFSjNyOWWif9XKux+O
	CT3X8w3XTlfzmHQB7Br4kIojNbPOWKAPTRBI4t03gaGnxig93Tj5x8MzrJkXObHydPV6gDJyguw
	8
X-Google-Smtp-Source: AGHT+IEEWcKlVh7lfUGF84Zo3cCu7vO1Zsbbb87ZYsMXoqSZrmWHcgssfVeiU8Us9zblxs2QxVRctg==
X-Received: by 2002:a05:6214:2306:b0:6ce:230d:a7bb with SMTP id 6a1803df08f44-6d0763a204emr123362876d6.5.1729893772385;
        Fri, 25 Oct 2024 15:02:52 -0700 (PDT)
Received: from localhost.localdomain ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-510047a534csm266302e0c.51.2024.10.25.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 15:02:51 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [meta-security][PATCH v1 1/1] u-boot: tpm: Enable Measured Boot
Date: Fri, 25 Oct 2024 15:59:58 -0600
Message-ID: <20241025215958.378681-2-javier.tia@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025215958.378681-1-javier.tia@linaro.org>
References: <20241025215958.378681-1-javier.tia@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 22:03:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/763

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

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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


