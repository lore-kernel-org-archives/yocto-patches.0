Return-Path: <javier.tia@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F10D149F5
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 22:00:13 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
 by mx.groups.io with SMTP id smtpd.web11.715.1729893609441175531
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 15:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iZjHdJrK;
 spf=pass (domain: linaro.org, ip: 209.85.221.178, mailfrom: javier.tia@linaro.org)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d35639bfaso846827e0c.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729893608; x=1730498408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BM7Uh8fTLEZy+2RodAL6Si41uAQb049D5ovHhSRS29g=;
        b=iZjHdJrK+RNZwGAGNUhGlm0PGTneST26Ttq8vBs/4RNmHq2weKCmvq9YhYqscKi4Cl
         4H20VipfjJvlR8FA5GKdoIiPdViJBb6YZCVSRh/V3tqJAj29BqRtu4nXLgO98eGllnvu
         BlHW0X/2n6+5zpVpPGyqbqdId0NPK54XwAd1ppE2Tw7DgAJ+sCa5FjFOIyzQzGjiOtVF
         SUyx9mzV79HC1x3Gm/CeThVLtubU5XQfMwLW298Stz/DegJ9JMQyawWtpw2vKEnfJEyA
         Aj7n8JNpA9TVogWv2DvKtzGybk9pr+F5P+affNi+NexCXyBBL4+wlPviaMqzciFcLmDk
         kJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893608; x=1730498408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BM7Uh8fTLEZy+2RodAL6Si41uAQb049D5ovHhSRS29g=;
        b=opxxqP0MpCSs4mAmpacVjmmRdvWU1cUBxyuurUgdaJMnzO6rL4lVCka8G2nWPHqC0s
         /yZ7l9OxIJ2zO/kHSyxRejua4gmKkXhDbQyL0dJjxgsygL3EP1ekYBzoL9b3mmJ0NE0F
         HBw7Q+suRnGL+7wrJbKopXnjlfRrGhvl1eTL/K+C1FEtZTobhcwV6M9qqFbopfwdez3y
         xv9uD4kwsT1cfRGbECq9nrpf2WhcxAW0zwAuj27JsqaGLylBbnGt4C9gdhNNYMizG4Ny
         2240HcKZnlB5BMfATwPXFspm1RvJzMBzcz5RFRScgdhxC0QHiFbd02nvpDNKjD+fKQp7
         ixvg==
X-Gm-Message-State: AOJu0YxQUHuKdMupmmqEaWEQj9Hxmzs65HbKh2HcyRbiw+B5E9ecU1az
	Gkso7+v/HvMLQPvIG+orpzIxgB3Q9sIt2hRdP6e8c2S88WiWipw+XWPNN6SWrRszmuTeJ5kXRN0
	S
X-Google-Smtp-Source: AGHT+IEO4FmB2cTwpBp4hZDpfX2ofK/Pqvy9ZiyDnjqpHHLlScFaNDg8XjhppitoJkH8Z0HCOLPjqQ==
X-Received: by 2002:a05:6122:180a:b0:50d:354a:19ae with SMTP id 71dfb90a1353d-510150ef3c4mr665576e0c.10.1729893608186;
        Fri, 25 Oct 2024 15:00:08 -0700 (PDT)
Received: from localhost.localdomain ([170.246.157.153])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-510047a534csm266302e0c.51.2024.10.25.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 15:00:07 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [meta-security][PATCH v1 0/1] Enable Measured Boot
Date: Fri, 25 Oct 2024 15:59:57 -0600
Message-ID: <20241025215958.378681-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 22:00:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/761

Hi,

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

---

Changes since v0:
- Change subject to follow OE guidelines.
- Add Ilias' sign in commit message footer.

Javier Tia (1):
  u-boot: tpm: Enable Measured Boot

 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg | 6 ++++++
 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend        | 3 +++
 2 files changed, 9 insertions(+)
 create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot/measured-boot.cfg
 create mode 100644 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend

-- 
2.47.0


