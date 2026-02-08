Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA4EF06F7
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:32 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34798.1770587131091351159
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:45:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nVOUJyKm;
 spf=pass (domain: gmail.com, ip: 74.125.224.53, mailfrom: charles.embedded@gmail.com)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649f2d9fe48so2107055d50.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587130; x=1771191930; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKFAoMUQAUL8d5KEZg6cxBqG/Y8yxXCRV4aV7XVyCzo=;
        b=nVOUJyKmBVRDG7ZOheq41Ubu/f/SyK0OofajoJ4hB9dSUcZAjpuKdkh0cB/8vzyneb
         arQjTL+frNLKDwx6CTE2wrtRE0r0NNhVemLMtIpzbh5h+qnjp1CaNOFve2CicM3Yr0yN
         9Av7U1iA+sxvC9z1ApuCOyQRHDsGUYoGlSO4pGVm5ktqphUjco5Sy3vATK2EBZAC8GwW
         5Wo/J2p/HXbYES0GLL1h2/bL8zMzyjbcNARAWQXOe/UXMYXHmr75oyO4ds7avnHmupCJ
         isqpNIaSXfUJ/setU2VNWxa4mqI/tas96tIuZ8LC8AtWKiYldnetzxcGfgYcCuNn7hoF
         6+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587130; x=1771191930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKFAoMUQAUL8d5KEZg6cxBqG/Y8yxXCRV4aV7XVyCzo=;
        b=lkfxfkJg9yJsOnv9XCtt2eV1ZeGwTWzQcKuck1W/JbJOHxUpzDLsADdN21T/q277Xi
         N0Tt8irT8ZV9jXtUrkLbyRwf2dzIsw/gBiKFdd5MdMIcqvZwDDWxzFU+Ky+KYBZwyEyQ
         IeO/Frq6KZdsvUrxUfymj8mp0eo0xPfsgI3Yh5iQ7Q1xObbln0ecrC0sm6YV23uUQirb
         CA8XMMUbof2ltRucaKwXKfVBpVF6/xTevJhWUPhZRXUiiRKZxwBzap/mJNYQObVcWXI1
         Oo1uTw0bOPMOa/WtaUHM694QdZp1eb99/GlDfMzWt2JGuqqJiQfwWgWc4OLCFAl1w+HF
         SOFA==
X-Gm-Message-State: AOJu0YxcYNy9dR+qkDMxtUQZEmlZV/7VFh+xfL3ekd9egMM/tU73MAPO
	sN269Zvl5H47YFKIRC2I7dVopB7JBUsE6eT2x/b6TkoL2bf5Onu+YnLALUSIwA==
X-Gm-Gg: AZuq6aKQtE2XysvQroKhbydzvsAKGzwiGJIR6Prd4OhlhJCZkWQdsEtuVSuJLkshY/2
	0z2W/OslQX0zeT5sLo09WSajgu2VrR/hfHf8tUlAI6lvjPRe3U2SCsRSbvGJpTGYChXWRZDlmSZ
	Y/WSTvc7p0gYCFLIPzG2O/xDzpx1q1lvTnsRt9aYbCTuFs4L16DRfMMeZbNKl7Wj4BCsbs5e00E
	LC5SBLKJ2pQkhmtz4H5OlHxzUf0MgVSgu1NKeyNSZ5VNjVtMdjDTquhqar1ksY6RrTytl0mTAI1
	NqwAgDCWUJTvX7+3JFVDmQMCRlRHI1TiZXdZCOLrA0BGUK6NStMli80bOumLfWnfthEzO0ftj6q
	DaK7zUhaRxViv5bLOdvyBlo6GFqHe1ixARChcUts6G7aSSHEkSSuajVxsLDNrd5yFDr9Ujwzdch
	CzAvXpnSgSpzKZ5py4QRBucw==
X-Received: by 2002:a05:690c:6605:b0:794:ecaf:c4b1 with SMTP id 00721157ae682-7952aa925f8mr201002387b3.25.1770587129813;
        Sun, 08 Feb 2026 13:45:29 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:45:29 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 5/5] README: improve runqemu examples and add supported machines section
Date: Sun,  8 Feb 2026 18:44:30 -0300
Message-ID: <20260208214430.1048640-6-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208214430.1048640-1-charles.embedded@gmail.com>
References: <20260208214430.1048640-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3205

From: Charles Dias <charlesdias.cd@outlook.com>

Add QEMU run instructions to Quick Build, use "nographic" consistently
in all runqemu examples, and add a section listing supported machines.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 README.md | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/README.md b/README.md
index d360de1..0aa55e1 100644
--- a/README.md
+++ b/README.md
@@ -64,6 +64,14 @@ build the Zephyr "helloworld" sample:
 bitbake zephyr-helloworld
 ```
 
+Then, you can run the created "helloworld" image in QEMU:
+
+```console
+runqemu nographic
+```
+
+To exit QEMU when running in nographic mode, press `Ctrl+A x`.
+
 ### Building and Running other Zephyr Samples
 
 You can build other Zephyr samples. There are several sample recipes
@@ -76,21 +84,18 @@ For example, to build the
 bitbake zephyr-philosophers
 ```
 
-You can then run the created "philosophers" image in qemu:
+You can then run the created "philosophers" image in QEMU.
 
 ```console
-runqemu
+runqemu nographic
 ```
 
-For a terminal-only console, pass `nographic` on the runqemu command line, for example
-`runqemu nographic`.
-
 The same sample can be built for other machines/boards, for example ARM Cortex-M3:
 
 ```console
 bitbake-config-build enable-fragment machine/qemu-cortex-m3
 bitbake zephyr-philosophers
-runqemu
+runqemu nographic
 ```
 
 Alternatively, you can use the MACHINE variable to define the target machine,
@@ -99,7 +104,7 @@ you will need to disable the machine fragment to prevent conflict:
 ```console
 bitbake-config-build disable-fragment machine/qemu-x86
 MACHINE=qemu-cortex-m3 bitbake zephyr-philosophers
-runqemu qemu-cortex-m3
+runqemu qemu-cortex-m3 nographic
 ```
 
 The default configuration (with `zephyr` DISTRO) uses the Yocto Project toolchain
@@ -113,6 +118,13 @@ ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
 Other Tips and Tricks for building zephyr image can be found
 [here](https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages).
 
+### Supported Zephyr Machines
+
+To see the list of supported Zephyr machines, type the following command:
+
+```
+bitbake-layers show-machines | grep zephyr
+```
 
 ### Flashing
 

