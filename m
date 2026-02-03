Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342BAE8783F
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 14:35:36 +0000 (UTC)
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17788.1770129328642046775
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Feb 2026 06:35:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q1v7dZgb;
 spf=pass (domain: gmail.com, ip: 74.125.82.68, mailfrom: charles.embedded@gmail.com)
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124566b6693so3457827c88.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129327; x=1770734127; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GhN824l13BtVUB/1RtWAMHf556mQxelXINhHNb5jOs=;
        b=Q1v7dZgb89lGauAQ/HPs+OlGtvxaX7v7Z1HS6vxbubhhX66Ikn9KbblRfoXmumAtIE
         FEfyqn1qbTpCED8QkxrteE0R/rMfPpH/80FMTiyA3VMNSHuQe4DrCxRhBLyPjDEs5xeM
         A70DYfcHkT9FSYrNin4T/bgcciUN61oAD3YgSkJVvNEOnv0HtiXohD+QaIemCeDTjGJ5
         KiCfcfKwXAZZP3qnliKy5qllDq9hzXR4RKOlHs/RqpHGU8gWk5L7MH6eikenEuh0hYs1
         Q4lkAQV7tmSy0gw7oUjidFR2Yi8Nr8l89CAMJOZcdraAA88L7NjI09+ed96npNY2FsMG
         LdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129327; x=1770734127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GhN824l13BtVUB/1RtWAMHf556mQxelXINhHNb5jOs=;
        b=kTmnEKsuPLXkHGqQ80WowsSfabcnRWh7MUgAtp39LZKg/28zLOS7nvLIpWT1eGCU+A
         ONGJFNTAyp1r2TXKX5//ghYM9L+9GgvWQyiRR36YNBiCYW1oB8tQlJGBeXWJ+oprH+W3
         8QOezhDbEJrlFNUtkP76i0FdjASkokt7pM9ILPOfkMa6yvvkAoWpOnlu+/17azekkfhy
         f0X4DihgIvS12BzpCEQA58qUppHr7KNpkeDRu122KiI4Qc5FkZSiOEWaAJI6Yjm5jpiC
         sYDidWqAM/iN8aJh1oG/O1RbGQFF5QgVroo1Qe1flnrzksk38HNVUCmvXsbkfvAs0eQY
         eNMQ==
X-Gm-Message-State: AOJu0YzWmsKjm+KpyK2idYvZ16fE66k7llmS94VZya9f/cv4WaPFD7B1
	wC9e8ZYuvH4pohE1YarUwgR6/VqJITJ2XcGLV7gE6yOFMP3i64KQbcLxLRCXCTGQ
X-Gm-Gg: AZuq6aJn5HWnVdm04lJeP7Fss9bbiYODTnnbpb4aUHmoE0EyBLRcw54Gsg8NciY3sZO
	v4Lmie9huLGygVQcPdeeO40/GQOPexfDhC/fwlJBd6+AifAqh+EAutLSyw+QOs3kn+fVK1Uefcq
	V2MSCUIQYnH+fAJh1PnuWijZusm15e4FmwFZZW8stSkSW9mWwUxxp3CW50q9vNhEVlJwZ2681ZB
	b7zmRMEtujuADKULHOyl0xSMI5FkKxS8hXfXULIDEMLoxbGD83m7IM8izRNO3eF175IUlJLAhNT
	6iWH5E1N19ZMEPXFER99hburu6OSQnKs6OM/ASZsde7WQuFWmW6HpWLEtTyvN5aNvWGDS2RITB9
	4vkWoOEYAfjPYKTtthPdTgXFSyrYbffR+HUEfIOn4E7LBthnHfBnkWVOj2ISSH8ejwzyfzVIqMX
	a7npR7Sw4S5jdQ9YEVtlBF4TYO
X-Received: by 2002:a05:7301:19a3:b0:2b7:fdb6:ccf2 with SMTP id 5a478bee46e88-2b7fdb6e781mr3607916eec.13.1770129327416;
        Tue, 03 Feb 2026 06:35:27 -0800 (PST)
Received: from charlesdias.. ([2804:14c:daa3:8233:8473:de65:79dd:cac4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm22347273eec.2.2026.02.03.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:35:27 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 0/2] qemu-x86: switch to generic q35 and document nographic
Date: Tue,  3 Feb 2026 11:35:04 -0300
Message-Id: <20260203143506.119483-1-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 14:35:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3175

From: Charles Dias <charlesdias.cd@outlook.com>

This small series updates qemu-x86 to use the generic q35 machine type and
documents how to request a terminal-only console via runqemu.

Context: https://lists.openembedded.org/g/openembedded-core/topic/patch_runqemu_parse/117568097

Charles Dias (2):
  qemu-x86: update QEMU configuration
  README: mention runqemu nographic

 README.md                                  | 5 ++++-
 meta-zephyr-bsp/conf/machine/qemu-x86.conf | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)


