Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.6671.1713477876647580575
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 15:04:36 -0700
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b44071a07so11208726d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477875; x=1714082675; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM8M9nHW4KflHzXcnQQs00GwOj4cWkwNeIIvZNeuuuo=;
        b=fQ9SUklABvKL1NJNcdEt/694OyZ6Zw1A/9Ucg510jRDk5zqezw7W0Ur0ACxjEBlvMA
         uSFV98kbQVSclmbrS75xvZezY7WWTE6H1BKI9HtxO1usAa3by2b/JzQKwUNAhScRqWq9
         Bb2GI5FPHdYz1WdXS7VShCklocRe4dEnOIyyJbieWCoKFTmwyNWlnTxEDfjqTgO4KMiG
         QojeaHwPHGRQof3PeF4Rx2T8n+NOyEY84HOwRyCsH44xGK5ktG4RJ1H+HwblpE/n8sn/
         NFP6S3wkrzfYl3QJhwr4HD6Cy0Z2Z+NkS/RhfTMyw3Cg8Vt4q7Y9LeI+S/abts+PVZVz
         /LNg==
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id s14-20020a0c8d4e000000b00699427d1611sm1030794qvb.40.2024.04.18.15.04.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 15:04:33 -0700 (PDT)
From: "Trevor Woerner" <twoerner@gmail.com>
Subject: [meta-rockchip][PATCH] wic: add GPT partition names to partitions
Date: Thu, 18 Apr 2024 18:04:31 -0400
Message-ID: <20240418220431.31286-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

A filesystem label (/dev/disk/by-label) is a property of, and stored in, the
filesystem itself. Partitions that are not destined to hold filesystems are
not formatted, therefore it is not possible to assign filesystem labels to
such partitions.

However, if GPT partitioning is being used, GPT supports the notion of
assigning labels/names to the partitions which are stored as part of the GPT
partition table itself (instead of being stored in the filesystem in the
partition). The naming is a bit confusing (different tools use different
names) but `wic` calls this "--part-name", `lsblk` calls this "PARTLABEL", and
`parted` calls this "name".

In Linux user-space these partition labels are referenced via
/dev/disk/by-partlabel and provide an excellent way of finding these GPT
partitions regardless of which backing device is actually being used (e.g.
mmcblk0, mmcblk1... i.e. emmc, sdcard...).

An example where this would be handy is for interacting with a stored U-Boot
environment. Another potential use would be to use one of the unused raw
partitions to store information such as MAC addresses, serial numbers, etc.
which could be set/updated "at the factory" as images are flashed.

Tested with both systemd and sysvinit on both rock-pi-e and rock-pi-s.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 wic/rockchip.wks | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/wic/rockchip.wks b/wic/rockchip.wks
index a9e5508d3ff5..9ba3352b51bb 100644
--- a/wic/rockchip.wks
+++ b/wic/rockchip.wks
@@ -18,14 +18,14 @@
 #   atf         24576           8192        (trusted OS e.g. ATF, OP-TEE, etc)
 #   root        32768           -
 
-part loader1   --offset 64s    --fixed-size 3552K --fstype=none --source rawcopy --sourceparams="file=${SPL_BINARY}"
-part v_storage --offset 7168s  --fixed-size 256K  --fstype=none
-part reserved  --offset 7680s  --fixed-size 192K  --fstype=none
-part reserved1 --offset 8064s  --fixed-size 32K   --fstype=none
-part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none
-part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none
-part loader2   --offset 16384s --fixed-size 4096K --fstype=none --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
-part atf       --offset 24576s --fixed-size 4096K --fstype=none
-part /         --label root    --active           --fstype=ext4 --source rootfs
+part loader1   --offset 64s    --fixed-size 3552K --fstype=none --part-name loader1   --source rawcopy --sourceparams="file=${SPL_BINARY}"
+part v_storage --offset 7168s  --fixed-size 256K  --fstype=none --part-name v_storage
+part reserved  --offset 7680s  --fixed-size 192K  --fstype=none --part-name reserved
+part reserved1 --offset 8064s  --fixed-size 32K   --fstype=none --part-name reserved1
+part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboot_env
+part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none --part-name reserved2
+part loader2   --offset 16384s --fixed-size 4096K --fstype=none --part-name loader2   --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
+part atf       --offset 24576s --fixed-size 4096K --fstype=none --part-name atf
+part /         --label root    --active           --fstype=ext4 --part-name root      --source rootfs
 
 bootloader --ptable gpt
-- 
2.44.0.478.g7774cfed6261

