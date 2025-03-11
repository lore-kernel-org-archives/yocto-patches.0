Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A13C282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 10:34:30 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.5722.1741689261404150250
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 03:34:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D2rxdvHO;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf8632052so39607181fa.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741689259; x=1742294059; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsF3BnOSLrTQxhGJZ2OG90oiKJ9nAUa1ehsUbgKJO7Q=;
        b=D2rxdvHOJxRc83hiyneGbJy4K+TI/x2PE37cU8BcEN+HAoShu4JvfT1k4dBslOkClR
         HHNcKkUrvgTI2atPshL5zPy5g9FElALZ/C7cloWst4YX2jROyj14+6jPb9r1MnlJAZq4
         eYthVVqxJV08NHkXp1gMH3RMWoz6mePcWLsvYRcbuw2f4+8e076FbwcJ4I7vrG7XMqiq
         bacAbxbeklE/5xe+t3DHvhfiWT2phCfDpm2qkd0t3Z16SBlNIFyEEiR1kHgR/Jkkj6cn
         Q87qAxXd75ySvqkp6obw5uA0AHKfnLjuweK5Wr3amBR/HhbgrBkTQNOnQaLzRDs3DfZa
         P+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689259; x=1742294059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsF3BnOSLrTQxhGJZ2OG90oiKJ9nAUa1ehsUbgKJO7Q=;
        b=kwgfdcXAcvZx9GrHYTOBtBYd1vkFI+S3KoPNrhnPFHPKM9U8pM+YR1sJP/Tfxa8oIG
         75dZ8vVf1c4GNJzpW61mse1QvW8xxmtqn3saJlEszgjVzJyO5UsciARgEN2KAA2xsmrL
         vqJH2eOIKZKuCEYDDabb5jSPjRAaQYAydVGRfFYY6LU4dkJqLtzZ440NN9WZTzGPPzzn
         EmIzt5fjWh3/sSrlo3mnKm3ImH9mBG2b4fywRd/+6szFtjpC02699SpyOIu+FFjBf51o
         HRs+rYgOYctAP0C0xnGXzo+YgOObU6xgxm5M8qML5Eu03PEAqJyBqjPnSiXGRZNqhLnT
         l2iA==
X-Gm-Message-State: AOJu0Yzb+LjxSDTqTT50JuVBQuGzMaefwmbovGabiibwDVWBNbgFgt2Q
	IVWXCFeO/oh5MwrbjrNzHmo7xinBM7ArcaMVmKQeWXyXLS5vkwpv4dWhwcW/
X-Gm-Gg: ASbGncuVhbbetSOX8xTw06FHBxyvPYdQaf6bnr14/LRLSbsWjnPdwGi1yR6Mia2C0Ec
	Iv1hztmQLr8FfGU/ii6BE7Ve16UH7gnzuk21FNDpSb2OqyeRB0PFsPJ4pKJygFw5jEIW88TG3sK
	xJ1jtHWKc49Y4i8mvLQZFNHdeBwmfvESWmhVSZ+3g+rRgxRnB/fOIo/KV7oc2pGep1O7VMWrBBq
	tWMSOWvIxyiNQWngKzSkmvg3BNk54ld6c2gCmB5aO0S1GWH2wLoPCdASENm8oxHQddP1qH9ixp9
	rq2UHADXnvjx9rHfLn9mUZyuQoxtoRcyREPQufqwX34/7oJzK/5LBzch03v+fFI4BLM6Eoxbfsv
	TXnDmljzwbUo/9pAtc8KnI2mSHlc=
X-Google-Smtp-Source: AGHT+IGegSGlCLxVr3mpQlNiE2u5t2pZBLUQy8gdfC8tPUISx6Px9ZDywz8xPmS0puEzPdD4S0hErQ==
X-Received: by 2002:a05:651c:2111:b0:30b:9813:b002 with SMTP id 38308e7fff4ca-30bf45eba8cmr54221291fa.30.1741689258709;
        Tue, 11 Mar 2025 03:34:18 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c0ed155f0sm9080431fa.28.2025.03.11.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:34:18 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH 0/2] meta-tpm: Update python runtime dependencies
Date: Tue, 11 Mar 2025 11:33:31 +0100
Message-ID: <20250311103333.2972573-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 10:34:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1177

When adding the package of tpm2-pkcs11-tools to my Yocto build, the file
of pkcs11-tool failed to run.
There were several different errors, all originated in missing python
packages on my target platform.

I've added the relevant python packages as runtime dependencies to the
relevant recipes in the repository, to ensure that the recipes are
always self-contained.

Omri Sarig (2):
  tpm2-pytss: Add python3-asn1crypto runtime dependency
  tpm2-pkcs11: Add tools python runtime dependencies

 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb       | 2 +-
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


