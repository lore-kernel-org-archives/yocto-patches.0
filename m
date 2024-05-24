Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F0C25B75
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 02:37:37 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.7257.1716518255445677771
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 19:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AHW7dNM5;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7949747a23fso207915785a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716518253; x=1717123053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtf796DSW2awKuy/HlnBUnpntld+cs0FPQM9VQctunQ=;
        b=AHW7dNM5oAWiRYTzTYp8BTJB+l1p7HHBwL9xIjgw7JZFUo7hEjuICPUrgrbiox1zBs
         DsX+Fd05NJNX3zzG/LYhscZyePtnvDFT60xlyQ1gauV+tO3rCoF5W0pFLUd2/6VggH3I
         hfUhu22ytlxLv8pYdsu2rJlfDctVxhANKRNLqYhJG/8A0sTCffCeesj++fy/RUOXUAFs
         B/mU+1uOhds30kSINwdcTtpjFZWc+2yiPqtPHT2RI4ItZT/pfqCCHXeJxIUew6mmAyPr
         4M2B78t4kf8tRu+j5/a6OmGpjcbyxjdPcsSZpVC9QwuIE4sFQGExKbdM3oDg8UHNj00W
         Q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716518253; x=1717123053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtf796DSW2awKuy/HlnBUnpntld+cs0FPQM9VQctunQ=;
        b=M7xd46Kvj3cGYU8we/8RGZ1JHDT8BUzRl365qwpzrigugAB4eauhignnc43UDhiQ+x
         JMSOkZeB/bWqozZNryDgnF/Bcci2Mbv8c1rjBJfP0KrRtbMSMBNflqTZGtEaF/P5SKsI
         7PVlV58SDJgyPUXwUyy4sMPedyruugydT0kEVgqpzQOz/2CEWWcakt8Hp7MBFkyWQHBh
         +KIFO2ImSJkCWJ2yVPst+P0t1wiK21v0dmkM3gVjudVfx0YrxwdDP/V9TB709ZHSmTwz
         DHkGbWI6tZx/+EWryVus2dFBa+O0RbuvtAcHh8wyp2CW2nCMDJT8/nPv7O4yOfqP9r7v
         UX2g==
X-Gm-Message-State: AOJu0YyLiqFQyfqfs86WGlbfa50LpJ8ODyJYnHqFjwBXREOd0Hf6bwht
	XmrAR1G932F4avVKpjNiNV5ws1upNmXvUdO6s7Qmm4DjgQwBHgQV0eTOfQ==
X-Google-Smtp-Source: AGHT+IGBGIxLDsDq6O3B6747q62My0R3b8sXyaAJKXunpxVIx9/Gc82BNBbWidVN55H9pQ/Yhm4jew==
X-Received: by 2002:a05:620a:1448:b0:792:9148:96a with SMTP id af79cd13be357-794ab099fb8mr96771785a.41.1716518252824;
        Thu, 23 May 2024 19:37:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca6357sm23285485a.15.2024.05.23.19.37.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:37:32 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 1/3] rename root partition
Date: Thu, 23 May 2024 22:37:22 -0400
Message-ID: <20240524023724.20109-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 May 2024 02:37:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/184

Rename the root partition to "rootfsA" in the off-chance the user may someday
be interested in implementing some sort of whole-partition update mechanism.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- (none)
---
 conf/machine/include/rockchip-extlinux.inc | 2 +-
 wic/rockchip.wks                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index ca33f4c7f42a..ab46b76d33a1 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -12,7 +12,7 @@
 NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split('/')[1]}"
 
 UBOOT_EXTLINUX ?= "1"
-UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=root"
+UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
 UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
 UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '${NONFITDT}', d)}"
 UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
diff --git a/wic/rockchip.wks b/wic/rockchip.wks
index bc65f73b0cf3..e1d74d9983ab 100644
--- a/wic/rockchip.wks
+++ b/wic/rockchip.wks
@@ -26,6 +26,6 @@ part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboo
 part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none --part-name reserved2
 part loader2   --offset 16384s --fixed-size 4096K --fstype=none --part-name loader2   --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
 part atf       --offset 24576s --fixed-size 4096K --fstype=none --part-name atf
-part /         --label root    --active           --fstype=ext4 --part-name root      --source rootfs
+part /         --label rootfsA --active           --fstype=ext4 --part-name rootfsA   --source rootfs
 
 bootloader --ptable gpt
-- 
2.44.0.478.g7774cfed6261


