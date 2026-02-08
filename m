Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E89DEF06F5
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:22 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34827.1770587114185800239
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:45:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kEpCBIbH;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7950881727cso24430397b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587113; x=1771191913; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvojsvIrEv+sQ558nFi9E71EiqJSpbYjIO8R4DIu6VE=;
        b=kEpCBIbHxA26s7/pyANU+ErDmM9WzZFFkk8UqAm0fpi/EVNji2QNXVloK7EsASHDFk
         pf6rIHXLM6qrGbIOh/vV/BSr3lg63EoAvc6YE7w6jl8d4+0WMbWgXPA1uOw17m1SaNFT
         oIijie10udLI6jaZASjyTm2SIDfa/TJHN8Avip0pAqpBURjODsSiPtIGnmKxWsCjzCS9
         Occ47bjVxVEJNaJRixr1Ahw9MakhQD2pDCqIeNcSxHEXMH4X8/GRSmHFzSU2gzsWxkEe
         JOYCu/zUjI0YQZlkFhkqo1Wz4ViQQevf2aJf004ws4TQZrD/QuS1dPzI3WA/+LDd15pQ
         VADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587113; x=1771191913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvojsvIrEv+sQ558nFi9E71EiqJSpbYjIO8R4DIu6VE=;
        b=d+RriiWCWvfMSPuSiig1iPbJ9+/v7i2m4xYrT37czlhU8FTntYlqcWBbcfLoCnA+Lr
         x/s2iap4V15L4KtvEeAaUJT/jEDDV4TistiRmYaotY7c/psaVBY8BVibTa448GVlFBG4
         aPuFEnaEdaPJ9Z/NC2QBT0ZxJpAKAnR3pHvc1i66OiJBv7ajkSSupSjCghtlgExEO/i4
         CTR3g8/2+OvxZMUz4XUg+/gZshmZVkesgZOPVKc3aRbQMEqR6rJCnh4okugH6bmiJJsC
         KjzXlb64MmfUG1CQGg4VpNL0wNfDzmkFgcA3kR1w1QPLPUVj1P7sxHpO55W42OwqhNGb
         W+DA==
X-Gm-Message-State: AOJu0YwYnII5yfBzQL5sSwYtx/bBb3arvszwF5Et7oLklz58XJOjk6Nh
	qGAT+AjffDlBxoPPUs8hbQYZ2KiV8IEhbz2/WxItGE8plWdF0ZjJr03ls2arzA==
X-Gm-Gg: AZuq6aL8S3TFtJMlG3xgg93oWPU+VVqgwEcn+T20KiVSsIQVvkMnL0cKK8+lVQWAiUC
	sQxFAYfYhaiV0tMll8TL3O4PrNhe8DpkcswmUyRsqVDclYNR0uTik6AFJtrVTfAp/cK60Wl6rcx
	CSJdkDH63rP3xyZRaggp4R8U4fBZDO++iFacg2FfzJHWwur2RPzA8YVCAsAxiAPLvUKHMeKG+xH
	khViShAtH4ZlO1yo1zEbEjoB/jmEvB/CandSpfz6aMSNUEkcl5/a1qhBAZ2h8Ca5ItJccBYf9dc
	UV3NSNfMIYkSFs9a8k2A0h4eZaIpIJ/DE0Ei/4v9XpjZzprifIxJm08K49gNw9T4oZu+LtSnyuJ
	UtKRoKYoqp90zneCWhbJVkmkalUWrsnE1EN0BtigolU53PMj8kwcXNjGqVWiYVQltjiE6sTYJfc
	dDTaqMd21ByPGejOUVKAOzWQ==
X-Received: by 2002:a05:690c:498f:b0:796:3124:6565 with SMTP id 00721157ae682-796312469e8mr98125347b3.1.1770587112848;
        Sun, 08 Feb 2026 13:45:12 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:45:12 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 1/5] zephyr-bsp: drop nios2 machine fragments (unsupported in Zephyr 4.2)
Date: Sun,  8 Feb 2026 18:44:26 -0300
Message-ID: <20260208214430.1048640-2-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208214430.1048640-1-charles.embedded@gmail.com>
References: <20260208214430.1048640-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3201

From: Charles Dias <charlesdias.cd@outlook.com>

Zephyr 4.2 removed Nios II support, so building Zephyr targets for nios2
no longer works.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-bsp/conf/machine/qemu-nios2.conf | 17 -----------------
 1 file changed, 17 deletions(-)
 delete mode 100644 meta-zephyr-bsp/conf/machine/qemu-nios2.conf

diff --git a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf b/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
deleted file mode 100644
index e9420b5..0000000
--- a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
+++ /dev/null
@@ -1,17 +0,0 @@
-#@TYPE: Machine
-#@NAME: qemu-nios2
-#@DESCRIPTION: Machine for Zephyr BOARD qemu_nios2
-
-require conf/machine/include/qemu.inc
-require conf/machine/include/tune-nios2.inc
-
-ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
-
-# For runqemu
-QB_SYSTEM_NAME = "qemu-system-nios2"
-QB_MACHINE = "-machine altera_10m50_zephyr"
-QB_OPT_APPEND = "-nographic"
-QB_CPU = "-cpu nios2"
-
-
-TCLIBC = "glibc"

