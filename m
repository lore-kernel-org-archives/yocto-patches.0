Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C67C28B2E
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:38 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.34031.1741775615077635557
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 03:33:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i2CE7TNx;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c2d427194so11800401fa.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775613; x=1742380413; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYMUb5Rwqtiw4QsPSqHs3PBqxtKOqoCD+oIVz744200=;
        b=i2CE7TNxZU9yAp0xr0rupcnde4dlgz6ettdTcjcZ+8G3D1C0GaAJhnQ+39lHX4jAfi
         xUWu15d+OY52MsNbVXW39fxvZf6xAN5kMR7EZgPuvfmf/O1YZtUzm5alaF5p9wPSL037
         cNOoBwcJAWsQ7/yiunVplJFjnVgbhtrB+uHjv8YBMuUVXezmo2UhtyTFEXuraAZ68qoN
         /GODQTdjvV1CtcsezBsphqwNmWX5RvIG1U6e3eg5kacKYH6IsCHRyAfpCegK0lyeVPKt
         KrOwDrq5YdgYgomzoMRVulGlcoO3aZ/vejL1eNgS5xHqZDxo/LFNJwLpstorhLXFYo3k
         4pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775613; x=1742380413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYMUb5Rwqtiw4QsPSqHs3PBqxtKOqoCD+oIVz744200=;
        b=Ri88us1Q5C7pHH9t4g348ooexetDKx8BeluggqDTtTpkmmn3wotcMJZ7rHXPnU11Eh
         vw4P2w8PouOyAt2ibl/SicvfzqBoLjvDslSVqtuBiotBhd2tZOpnhxjwBZ85//Egp7y9
         tSAypa68fWp1rOd/UioK2M+YLND1g9+OeKBxo7ru/Fjwqg9ZJA06GNWHUr6n2RGjLLbU
         gqqk7Ydu/Z/pSaLRkJd/lnFeSxhKQIKn17/2Rjt0m3BS3X8P11S1vPpMtWT8UdyZpuII
         J4yHXpnP0xc5A043u4J7lfLQOrMnpGg8u9E/7pUoNkT93/ySS+l6IDxz+nVF1bs/VIuu
         ktQQ==
X-Gm-Message-State: AOJu0YxaG8MDY7DBi1Yq9WnzpO3MCThhwbcnWfAzq1UfaTro4IzHt09K
	UrjXEQWt1mvoJYvoJ2aMJvQqEoeriyl0BWCIol3MG9fB1OywWZCK4Ob9hLfY
X-Gm-Gg: ASbGncujq9wKTFXK8zgk1+csD7ol+TA8ZK4AXuKoiBgZa3RCtVrdsKiWWXmFCdHcByQ
	fSFnyi8pAFfOw/xBBt1Jl/2hLq3h5qgtiusgyWzXIHkfpDHxnW+0Vpw85dGgTP4k4pW/yyoPST4
	I50OJFv2XEMPT9WPOJ/8zLwEXTmXdV7Wgb6060H8+N3zfeq+OWKDYYHmH6ZaAPMJTvS2j3JIoCq
	4hT0IPLvCGKZtMSt6OqruM8Mtc7Sol8HiKxl3YgH2U4isXqidOl4i8H5tlQ/H/EcXBwyQMr83nT
	Agt4R0JOgegPh67o1aPNQBSe3FOG6rl3UXN3msDJ4wF4juHerOyliZ5v1jxZcQ8VOXWmIigLHqE
	VtXpj5+Ye9OU7wRRnoDZm4Row+vQ=
X-Google-Smtp-Source: AGHT+IGkLO3AcycCfn0fWgsSGCy7gFivmk0+hzTytTXRKynoz98WrA/muy/bb9P9YIKQIBv+d9QUYA==
X-Received: by 2002:a05:651c:50a:b0:30b:aabf:fa8 with SMTP id 38308e7fff4ca-30c2071a8ffmr30800961fa.28.1741775612315;
        Wed, 12 Mar 2025 03:33:32 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfceebd49sm18030821fa.60.2025.03.12.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:33:31 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH v2 0/3] meta-tpm: Update python runtime dependencies
Date: Wed, 12 Mar 2025 11:32:38 +0100
Message-ID: <20250312103241.2526274-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 10:33:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1190

When adding the package of tpm2-pkcs11-tools to my Yocto build, the file
of pkcs11-tool failed to run.
There were several different errors, all originated in missing python
packages on my target platform.

I've added the relevant python packages as runtime dependencies to the
relevant recipes in the repository, to ensure that the recipes are
always self-contained.

Omri Sarig (3):
  tpm2-pytss: Add python3-asn1crypto runtime dependency
  tpm2-pkcs11: Add tools python runtime dependencies
  oeqa/cases/tpm2: Add tpm2-pkcs11-tools sanity test

 meta-tpm/lib/oeqa/runtime/cases/tpm2.py                      | 5 +++++
 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb       | 2 +-
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)


