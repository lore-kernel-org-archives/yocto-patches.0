Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF64EF06E1
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 16:45:50 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28861.1770569147224668278
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 08:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SXJvZizX;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794e95357cfso34230507b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770569146; x=1771173946; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEavUQyVe7EF7PVFGFcSWBhIEQLbdRnm3b27+3PObG4=;
        b=SXJvZizXuRNDhGQvJrZKqV3tS2lNbcMXTUrVBW4fpBz3Mzf12IZ5hZTN8uhmADA/XC
         3ln5HVw9k48PCCWv56q63Q+P8zZCOkefV5qLiwoxEByHruX/xrUQTB3HOYx3yk0OEfc4
         bdfAwMEdqawqTCtwO4B3gnfc+9FRBnpUDOPk8MZfW5cRJqbgbheKmQiiz4ZNktfiC9V/
         V50LvJYBnxAj2+n9/BoEg669V1O7TGyH79bGacUfgG7u+hpZPOcj2SJRIkqDl6XQkV03
         qVJ8aU2zbFj1K/dAao+AzD14NVqeExZWwy1tTTlYlgrvBKXDw6RDIN9lvf38nHCmEK7j
         RDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770569146; x=1771173946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEavUQyVe7EF7PVFGFcSWBhIEQLbdRnm3b27+3PObG4=;
        b=ZGM9/uQacSkE6Rav0nlS3feimiSt9d5LV2QLDgmBZogEtHYtoNK5yL1lRIBMzuF04W
         dMkgO7tUIP0rPXbUo1LiR+kliIR5/C2lcayMfVFudT60Si5TJ4OKsmYrW+2IIQK+b9Kf
         xlWkCl7jrVvLrQIgOyvoaoN/HX7YF2iWI2AjHoQZY+bYLKXKtxiVmcSCDqAfeEruu3DC
         OW/syUnZyjVphYxBGC6MoV1vWXdM1OY7aUu5GYpSGhC5hSvU2SI6hXZD1NFcOX8ZtpX9
         BbfuBk5f3OrZz6a0x7JAN6Byhpfnrt6IT7lmMi6cR2waeFpWcVjDbwnrB+ytZWFnQypt
         4fSQ==
X-Gm-Message-State: AOJu0YzI+WFKGkQ0d/lN++2gwLCk3X/nCSuQaz27wo2j/p2nXwuf1A7G
	70G0+Y6AEeVZCgtkMUtAkEBU/8xSbqbFBZ3NcOszplDwCNFHxJJ9oNpF3NNWzw==
X-Gm-Gg: AZuq6aICUpmzsv9pPv12myhX63f5nh7Ow9bsyg+nhnGbQC2D4TqqoDrmIwk+/T+MP7G
	ac3Ze6mwGXFPt8QOrFF1vbLhj9f1N7k5seDMrObmPJOrz1UBWh613G2yuE9tKlrW1UwWPCZmgHu
	o2vlQIHZT9W75SPuHUm+aO5+Mgt9cmNlfsjRxoXILbfpTN5cqQUtuLp5glQ6MtNPbPsMn7Dma00
	aOz8VyTcseovkAkfmJpPqZY9qjSKg4H9AJO3b7UhxZxZd198gaJ3YahnCvhkOKeTIVM5eZqAJnZ
	vHp3BMBEY+f7VIKJqApnZmEWQSW7ulWQDyoEzhsWFvtHCCnTqCdoJoIbLKbLuVyEGADHocCAvgl
	b5Ykneu3GPSAl7MPy18yzMdR0MCI3wWrRuPt1XXFA4lDjhm5m/a+Q0Z2qTuCllOfJBmQN6EVVXS
	JBubv6uZeRVUa4C3/7XoJS5g==
X-Received: by 2002:a05:690c:6c90:b0:794:77da:aa55 with SMTP id 00721157ae682-7952ab3fbabmr73672317b3.42.1770569145842;
        Sun, 08 Feb 2026 08:45:45 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79641ed89c7sm11843387b3.44.2026.02.08.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 08:45:45 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH] zephyr-qemuboot: use stable ELF symlink to avoid broken runqemu rootfs
Date: Sun,  8 Feb 2026 13:44:58 -0300
Message-ID: <20260208164458.101865-1-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 16:45:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3199

From: Charles Dias <charlesdias.cd@outlook.com>

do_bootconf_write() may update qemuboot.conf and the QEMU ELF symlink to a
new timestamped name while the ELF itself is reused from sstate and not
deployed, leaving a broken symlink and causing runqemu to fail with
"Can't find rootfs: ... .elf".

Fix by making zephyr-qemuboot use the stable link name
(${ZEPHYR_IMAGE_LINK_NAME}.elf / ${PN}-${MACHINE}.elf), which is
guaranteed to exist as a symlink created by zephyr-image.inc and always
points at the most recently deployed ELF.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
index ab0a281..4d8920f 100644
--- a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
+++ b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
@@ -1,8 +1,8 @@
 inherit qemuboot
 
-ZEPHYR_IMAGE_BASE_NAME ?= "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+ZEPHYR_IMAGE_LINK_NAME ?= "${PN}-${MACHINE}"
 
-KERNEL_IMAGETYPE = "${ZEPHYR_IMAGE_BASE_NAME}.elf"
+KERNEL_IMAGETYPE = "${ZEPHYR_IMAGE_LINK_NAME}.elf"
 QB_DEFAULT_FSTYPE = "elf"
 QB_NETWORK_DEVICE = "none"
 QB_NET = "none"
@@ -29,7 +29,7 @@ python bootconf_clean() {
 python do_bootconf_write() {
     bb.build.exec_func("do_write_qemuboot_conf", d)
 
-    qemuimage = "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.getVar('ZEPHYR_IMAGE_BASE_NAME', True))
+    qemuimage = "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.getVar('ZEPHYR_IMAGE_LINK_NAME', True))
     qemuimage_link = d.getVar('QEMU_IMAGE_LINK', True)
     if os.path.lexists(qemuimage_link):
         os.remove(qemuimage_link)

