Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.7083.1712798216238860898
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 18:16:56 -0700
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d57bd5781so309036685a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712798214; x=1713403014; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmI0L67b97poapm0b0FcFmREJnot3l3NaDdCEu1vVHM=;
        b=LcXRLUIoXiMg3aYaaJ2rG+DUf49LG/hGI/nHSDjpEv3OuISUadb67Nzao5zHO0Y5vd
         v9ZCZaTd0XSW1RtoRMr/XGwj4iaQosvGFUy/41+BcW2RTebcJkReycCpLK+1c3u8peue
         xCTOUWRa14Mi8M8eSf7suw9QjHAxXIO2/Auphw1kcHnQNXsJwYypw4yA0PE+FbRsJmGo
         teQ9/dcJh/St66nYQz+UpLKykml83d3JM7N0MhrwvqmUyve29W3cGwSMbj0AzKZK8Uj+
         NsjKvsRIPZVC6/9jRmWJrrjx/fM+gQrgVXxvgb0o3q79LpI5ctX1YKjJNamixN2urFIY
         IzQw==
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id xy2-20020a05620a5dc200b0078d6120fad0sm311319qkn.108.2024.04.10.18.16.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:16:53 -0700 (PDT)
From: "Trevor Woerner" <twoerner@gmail.com>
Subject: [meta-rockchip][PATCH v2 2/2] fw_env.config: use partition name/label
Date: Wed, 10 Apr 2024 21:16:38 -0400
Message-ID: <20240411011638.12198-2-twoerner@gmail.com>
In-Reply-To: <20240411011638.12198-1-twoerner@gmail.com>
References: <20240411011638.12198-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

A filesystem label (/dev/disk/by-label) is a property of, and stored in, the
filesystem itself. Since the U-Boot environment partition is not formatted (it
is a raw copy of the generated, binary U-Boot environment) it is not possible
to assign it a label.

However, if GPT partitioning is being used, GPT supports the notion of
assigning labels/names to the partitions which are stored as part of the
GPT partition table itself (instead of being stored in the filesystem
in the partition). The naming is a bit confusing (different tools use
different names) but `wic` calls this "--part-name", `lsblk` calls this
"PARTLABEL", and `parted` calls this "name".

In Linux user-space these partition labels are referenced via
/dev/disk/by-partlabel and provide an excellent way of finding the GPT
partition containing the U-Boot environment regardless of which backing
device is actually being used (e.g. mmcblk0, mmcblk1... i.e. emmc,
sdcard...).

Tested in both systemd and sysvinit.
Tested on rock-5b (both emmc and sdcard).

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- new
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 3 +--
 wic/rockchip.wks                     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 18702428a787..a1dc25449229 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -59,8 +59,7 @@ do_compile:append:rock2-square () {
 
 do_compile:append:rk-u-boot-env() {
 	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
-	UBOOT_MMC_DEV="$(cat ${B}/.config | grep "^CONFIG_SYS_MMC_ENV_DEV=" | cut -d'=' -f2)"
-	echo "/dev/mmcblk${UBOOT_MMC_DEV}p5 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
+	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
 }
 
 do_deploy:append:rk-u-boot-env() {
diff --git a/wic/rockchip.wks b/wic/rockchip.wks
index febb826bccc7..f7e501cbd25e 100644
--- a/wic/rockchip.wks
+++ b/wic/rockchip.wks
@@ -22,7 +22,7 @@ part loader1   --offset 64s    --fixed-size 3552K --fstype=none --source rawcopy
 part v_storage --offset 7168s  --fixed-size 256K  --fstype=none
 part reserved  --offset 7680s  --fixed-size 192K  --fstype=none
 part reserved1 --offset 8064s  --fixed-size 32K   --fstype=none
-part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none ${RK_UBOOT_ENV}
+part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboot_env ${RK_UBOOT_ENV}
 part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none
 part loader2   --offset 16384s --fixed-size 4096K --fstype=none --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
 part atf       --offset 24576s --fixed-size 4096K --fstype=none
-- 
2.44.0.501.g19981daefd7c

