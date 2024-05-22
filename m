Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E9AC41513
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 23:08:27 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.2936.1716419298306063644
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 16:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dVtrjJg+;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a8691d736cso10032916d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716419296; x=1717024096; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiBNwEhBy/1L0eqmVi6sfQb85z1DVbOdt9aVuPAAPq4=;
        b=dVtrjJg+Qr9TWs5wXikI1L4KN668bEgv3ANLALNAhhsFDF+bBPD9UkTqu6OaXUcijz
         kBcr2sfNrPjr0uHOqqGvM50MAekrCe2MiXdJs8KRoXYl+ubsrzwg5C20vr673GNDwd7R
         JXVr/uDBqGAwZ82ImxHKQwUqRzdjMo8Kx49YpQF0+qpO+WVKTdJ+FPuN7LmVWkwuxhf0
         wrFdn0ISG5Rn22FdzGkPfECdRqwst8J77eg0UiRVq4olbtuNeSW0/dPYTM6eB2fbpyFh
         GeYclfh3HUmcQZ6sl4b7vkhYsEILtQUPrvaqVnsWaa+I9V2eJ8tKzOC7qn2p0QJoNjnW
         GvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419296; x=1717024096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiBNwEhBy/1L0eqmVi6sfQb85z1DVbOdt9aVuPAAPq4=;
        b=pQ39NbgZI/wTalvlH4bZL5JayK2EeNg2crtNtUV0eLQjfDC9h/9DNBLWVdn+epBUvv
         ELAc0cW/q/LcQw07LTJnigPp5Xxvpk6PIvTYSHWOnoEU5FYpcg8OJz7biJ5gjqzHO57L
         Ulmf0gbXl2Tfp2D/17ckUJq73NFB0jf4WxxWs/pSfX5qtEQRPQ2avlZbMqNKvptUgAdR
         EcYORwr2BucLk3qJtFV6TQTNKM5zaclj4Y1ZwCit3svlHs23VBfaH6MEjrtaBKyv/h4s
         bVxX80Ee1pGUzgwx96IWYhoAlHtd9c9NbQQ2fdl48EhZBahO18c04LBDCcx4SgOf9to0
         gxRg==
X-Gm-Message-State: AOJu0YzgzLwSbTQMOlc6yDumdak0mN4c0hMwqEHjsX24R46Qwt1B+fFS
	4HgZQorQgPPAGMjfnIUE/FvvlvwzqVvQj5lJcCANDryceLQS28qg+2RAqA==
X-Google-Smtp-Source: AGHT+IHSIDBtDKJVVcer7h621zf39B85TuGOEiS7dStuVH7Ko0zvF2VM/OxvX+ebsUBQNesceCCIiQ==
X-Received: by 2002:a05:6214:4383:b0:6ab:8f57:e467 with SMTP id 6a1803df08f44-6ab8f5956e2mr12465456d6.8.1716419296117;
        Wed, 22 May 2024 16:08:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab908a01b7sm743886d6.11.2024.05.22.16.08.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:08:15 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/4] rename root partition
Date: Wed, 22 May 2024 19:08:05 -0400
Message-ID: <20240522230808.14409-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 23:08:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/168

Rename the root partition to "rootfsA" in the off-chance the user may someday
be interested in implementing some sort of whole-partition update mechanism.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
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


