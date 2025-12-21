Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D2E67491
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:48:50 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51310.1766278129150439867
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 16:48:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Oeli1a91;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8bb6a27d390so178868885a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Dec 2025 16:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766278128; x=1766882928; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFddC83/W6GAQK2p68ayaaIpX3aCIBAgg5SVU7noUx8=;
        b=Oeli1a91NlsMaohnk69gB36ht2X18cn47DdrSDrzlGcV02XB5zsmEpDRheB1hB4Fqn
         a6+gVlJqxMJoPg5YEN+/dlYUOJzE1haqZhaPGhQQze85m6EjEv8o3xmGN8lki0HC+J5p
         0ruL37J/3lCdxGoRHTNbVF6ADZnnTvw85rMYi/if+mZjlTdDsoO6N8E93e/fYuj+oYUM
         rxPNlevtp0D0lW0vfh/5v8wA5vg7rQkljT7TgutgGXicbRjgDJVh/ptZnMRNVW3Q4enM
         QCfZ4pn+z07ruYyBqtG4D7FC79+IFSmF47o5wcX1u2BbMEZya47ZwEz2I+qndqTQ1B7x
         dQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278128; x=1766882928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFddC83/W6GAQK2p68ayaaIpX3aCIBAgg5SVU7noUx8=;
        b=IVFHZyVuTF4Voo6ToMTS3BI2LU4/Un5BkcrsNilUtzUPmEFv+OR7ALtmaKkoAbNCoz
         KsMWJ9RrKusPhkto8K0FiR1klDvB/bTxaIkjHIcMG2y8c2OoGY1NVBe1z7H7gtBpw+Kn
         16noNyZgaLeP2Rw506qT4M3nz5Z59Pl2l0cFWnFnFswT0yPdunaiNcDVnzyx068JrfeB
         vgS3ADfD+DxCSHbn25mT9tRbWCMSSMVHr/vfFDLcsKH+iWR6FEtsCh8uX9VRGyriqaqA
         AUmt3FPnuMPe9NUDoXL9a07c0L92iddkUBAEyWqnax7DeqXR3FREofEYgnnaqPhzUYTj
         rMMA==
X-Gm-Message-State: AOJu0YzcE9/cBvDFVglOHoX9DqOKBckyeAeC9Pe8yaOlnKW4d5hFP95y
	8s9gwFW9lnMAUr2GTNp34I38UVQd+ld4fgU8LRQ5m+hgFGy+x7wHRZElYoVrgw==
X-Gm-Gg: AY/fxX4SIQ4PfG35nwAUT9lUBrHwPpZS4nccUG5vxSeQ25SWI7rir1w1/g2wSVehJpf
	2X/fKBxCfyov1GXRJkmKdf0+t+Wb87MGOQBLaKRxGgf65O/Ji56q/0EFJdo0rLoskIQxwrauQnx
	XrraspDQEYf1LvtwoXtvJ96sdcOSjfGsq+5Dhnjg1gadw9bLAlV6bfHl3NsFToraDtlzf7x2aAx
	eNQOphkcx4g0rXwDjLUEDd/mfvuYXcaZ3pppxscUQStdzF15sRhPY78MapSVvoJwvMkiuhYFvEc
	/SQw2fIx1uY8VnROAjT1wh8BtEbaIS+l/1xgwZZ0kTvhuwmmPGjg/Bhsk7i5ybauPUs8I/zw7RZ
	nCfzZ9mYYj/Tk7LZd05so1V3S4x/p62Or+ChWpju5snlgPcWs6pGJqbGqwQo5EvP/aqXBBIYXWX
	wZUZJ9WViVUfpTOuo/Ok4xuOtrC/0ArTWk9votFw==
X-Google-Smtp-Source: AGHT+IGUav6daCio4IuieDjJ65kDY4oNdv+rVCeYUC1nOSG0AqJa1YoqGrOjGPDkKGf5g+uQiLBkKg==
X-Received: by 2002:a05:620a:1aa6:b0:8b2:9a8a:118b with SMTP id af79cd13be357-8c08ff231c4mr1165894785a.73.1766278127564;
        Sat, 20 Dec 2025 16:48:47 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm511867385a.41.2025.12.20.16.48.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:48:47 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 2/5] provide kernel *.inc
Date: Sat, 20 Dec 2025 19:48:40 -0500
Message-ID: <20251221004843.31946-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251221004843.31946-1-twoerner@gmail.com>
References: <20251221004843.31946-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 00:48:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2838

Consolidate the two bbappends for linux-yocto and linux-yocto-dev and
provide the "guts" of the rockchip additions in an *inc file which could
be used by other linux kernel recipes outside this layer when a rockchip
machine is used.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- changed kernel bbappend name from "linux-%" to "linux-yocto_%"
---
 recipes-kernel/linux/linux-rockchip.inc       | 35 ++++++++++++++++++
 recipes-kernel/linux/linux-yocto-dev.bbappend |  3 --
 recipes-kernel/linux/linux-yocto_%.bbappend   | 36 +------------------
 3 files changed, 36 insertions(+), 38 deletions(-)
 create mode 100644 recipes-kernel/linux/linux-rockchip.inc
 delete mode 100644 recipes-kernel/linux/linux-yocto-dev.bbappend

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
new file mode 100644
index 000000000000..a648ecb20679
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -0,0 +1,35 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
+
+# 32-bit devices
+COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
+COMPATIBLE_MACHINE:marsboard-rk3066 = "marsboard-rk3066"
+COMPATIBLE_MACHINE:radxarock = "radxarock"
+COMPATIBLE_MACHINE:rock2-square = "rock2-square"
+COMPATIBLE_MACHINE:tinker-board = "tinker-board"
+COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
+COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
+
+# 64-bit devices
+COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
+COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
+COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
+COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
+COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
+COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
+COMPATIBLE_MACHINE:orangepi-3b = "orangepi-3b"
+COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
+COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
+COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
+COMPATIBLE_MACHINE:rock-3a = "rock-3a"
+COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
+COMPATIBLE_MACHINE:rock-5a = "rock-5a"
+COMPATIBLE_MACHINE:rock-5b = "rock-5b"
+COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
+COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
+COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
+COMPATIBLE_MACHINE:rock64 = "rock64"
+COMPATIBLE_MACHINE:soquartz = "soquartz"
+
+SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
deleted file mode 100644
index 81d2b6d693c4..000000000000
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ /dev/null
@@ -1,3 +0,0 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
-
-SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index a648ecb20679..34bf335d0b10 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -1,35 +1 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
-
-# 32-bit devices
-COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
-COMPATIBLE_MACHINE:marsboard-rk3066 = "marsboard-rk3066"
-COMPATIBLE_MACHINE:radxarock = "radxarock"
-COMPATIBLE_MACHINE:rock2-square = "rock2-square"
-COMPATIBLE_MACHINE:tinker-board = "tinker-board"
-COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
-COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
-
-# 64-bit devices
-COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
-COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
-COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
-COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
-COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
-COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
-COMPATIBLE_MACHINE:orangepi-3b = "orangepi-3b"
-COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
-COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
-COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
-COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
-COMPATIBLE_MACHINE:rock-3a = "rock-3a"
-COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
-COMPATIBLE_MACHINE:rock-5a = "rock-5a"
-COMPATIBLE_MACHINE:rock-5b = "rock-5b"
-COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
-COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
-COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
-COMPATIBLE_MACHINE:rock64 = "rock64"
-COMPATIBLE_MACHINE:soquartz = "soquartz"
-
-SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
+require linux-rockchip.inc
-- 
2.50.0.173.g8b6f19ccfc3a


