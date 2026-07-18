Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4AC44521
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 23:30:24 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3527.1784417422573078524
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Jul 2026 16:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BIov3rlm;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f502ff678so113477f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417421; x=1785022221; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iWHEv5Bj0Y9B/xxDbPTVHsCfYjlLBq7YXi8eQTYXrBw=;
        b=BIov3rlmflKFbnfXGlkTdKRWmOH2B+YKadKyZJZ41FdC+4OyKBfhFJLqfHN8aAc7xO
         IBs16smk7zN//nlKzegGqIpmlFFlvMWKOuo4mlTlCyWFehcPR9nviBupfxtmLVqZlvWn
         ypX/I9aHJDn8pgNY258oW188O3HCTI5ZJf8HmxvnoO8s7rPLjHk081Kl/UeSw9XNrNhf
         LjCvVcSmvUyrsDREhO796L+2w32JBbvbB0R5EXkBy/fz7e9mYBkRUmCbJDU0/Td+lAt4
         GZvZxG3LR3/i9uBc2LVwKby6avDI+F71NWQqFp9R5bFTGwgXExPVnWSyWfVadoXrZiOi
         YwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417421; x=1785022221;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iWHEv5Bj0Y9B/xxDbPTVHsCfYjlLBq7YXi8eQTYXrBw=;
        b=mw3+6lgbkdbFmz+lQxJoz1jnpZ4cY12fqAq+F2TQ0Is4pV8PxIeOUDmwI70S/87cCp
         ta4JMB4bVUz8ctIoyo22usrOrSvydk3W2nON/Su/FwrRS3cKl5cY2yeSstIwzH5ykTyw
         TbYNeuuJx8rulAwRxhI4aS/KwgxbeESMmniAp7o3aoSIOcBhXTpnKUSffwyGy3aveCm2
         crSzcPBHBD0gH67pZBVukIHs0ifHzBHKQOCimahKDdotzprA+3VPLnw/WyI8prF6CXvt
         6fEASg6LqT/WhGuVzyZpMRiw5Nm7WDdwf4LHwaaFPEVVMfOhYp5ThqP73mc9an4L6KIw
         fiwg==
X-Gm-Message-State: AOJu0Yy9IzLlHlcFTlXGSPObsMV9KSIEaNWQs8DPQGpGvGTCjY/XUxWa
	PytXISYMFYBMoQqzNJWEz2GICpofK7DryByJ20IeZcZ+A45PZZoUTqYB1edb4WiM
X-Gm-Gg: AfdE7ckLRR6IWQqjqlk8rnsfVzT5qL/L7JDsaSgJjKnZd4nrvo6faGw1zYuEJp9j5Aq
	69E/3KK4RHo4/Q2PnIL8VE/AJ2yzp923sP7b4oumF/EIyyBwnbPnRWyuE41SZCrOLSmKN30fYlm
	/LNOHBFK7uk9ddMDWZa07jTPqHhaIg3Wj1zxA1lzftrt9/LgPWc2OhN/0IlcSwJRhT/LwrBT0zE
	ANwQeax0oO7sjpAveBkfeQ7NdJWKNcSbtYNNL3gI7CGkdZmwJ0LKgjSSdO2su//GprrCW0tSxfE
	fx/B3PNdVjstZiAv64d2xc0wZoqBb1+XmHI481nZeMR1R1EIGV79qRHW/OimTtstJcbJ6V8hSrQ
	R4qUsYn+kArhKXc7tUY2F8kdiXPjYUUhK80m2Wbags+fpjFuEsrF9hz1BFN9m9eVwls4xwZQT+0
	xJnjYd69yDFZjnytNcDhfMXXmkLTuHgOQ8zRnCdgIo7h4t9go=
X-Received: by 2002:a05:6000:2086:b0:47f:7050:f2d7 with SMTP id ffacd0b85a97d-47f7050f371mr1026777f8f.6.1784417420764;
        Sat, 18 Jul 2026 16:30:20 -0700 (PDT)
Received: from chipmunk-161.. ([78.243.54.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm17738993f8f.27.2026.07.18.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:30:20 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH] docs: update path of wic files
Date: Sun, 19 Jul 2026 01:30:07 +0200
Message-ID: <20260718233008.2823789-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 23:30:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4514

The wic files were moved from wic/ to files/wic since commit 596b966a0d
("wic: wic need to be moved to files/wic within the layer to be
found/used").

This updates the path of wic files in the documentation.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 docs/dm-verity-systemd-x86-64.txt | 6 +++---
 docs/dm-verity.txt                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/dm-verity-systemd-x86-64.txt b/docs/dm-verity-systemd-x86-64.txt
index a47b02c..5d759a5 100644
--- a/docs/dm-verity-systemd-x86-64.txt
+++ b/docs/dm-verity-systemd-x86-64.txt
@@ -14,8 +14,8 @@ writing (kernel v6.1) the resulting qemux86-64 build can also be booted
 successfully on physical hardware, but if you don't intend to use qemu,
 you might instead want to choose "genericx86-64"
 
-This will make use of wic/systemd-bootdisk-dmverity.wks.in -- note that it
-contains a dependency on the meta-intel layer for microcode, so you'll need
+This will make use of files/wic/systemd-bootdisk-dmverity.wks.in -- note that
+it contains a dependency on the meta-intel layer for microcode, so you'll need
 to fetch and add that layer in addition to the meta-security related layers.
 
 In addition to the basic dm-verity settings, choose systemd in local.conf:
@@ -56,7 +56,7 @@ The following build artifacts were used to create the image(s):
   NATIVE_SYSROOT:               /home/paul/poky/build-qemu-x86_64/tmp/work/core2-64-poky-linux/wic-tools/1.0-r0/recipe-sysroot-native
 
 INFO: The image(s) were created using OE kickstart file:
-  /home/paul/poky/meta-security/wic/systemd-bootdisk-dmverity.wks.in
+  /home/paul/poky/meta-security/files/wic/systemd-bootdisk-dmverity.wks.in
 build-qemu-x86_64$
            ------------------------------
 
diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
index a538fa2..dca3df6 100644
--- a/docs/dm-verity.txt
+++ b/docs/dm-verity.txt
@@ -115,7 +115,7 @@ The following build artifacts were used to create the image(s):
   NATIVE_SYSROOT:    /home/paul/poky/build-bbb-verity/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/wic-tools/1.0-r0/recipe-sysroot-native
 
 INFO: The image(s) were created using OE kickstart file:
-  /home/paul/poky/meta-security/wic/beaglebone-yocto-verity.wks.in
+  /home/paul/poky/meta-security/files/wic/beaglebone-yocto-verity.wks.in
              ----------------------
 
 The "direct" image contains the partition table, bootloader, and dm-verity
-- 
2.43.0


