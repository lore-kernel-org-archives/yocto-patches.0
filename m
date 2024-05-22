Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94CC25B7D
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 23:08:27 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.2938.1716419299010029587
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 16:08:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UNU0Iv3w;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69cb4a046dfso24097366d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716419297; x=1717024097; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdK2lWJFmURLTf6wV+I2BM0kPifXnUIEFqpBMb7vJ5M=;
        b=UNU0Iv3w/Q4xA/azCDdgnx0P3asrHmhGJXwgFW5LDLNUxH6Uh6clw88oFg9qWX6WVg
         KoZYfDGalc7BUxoGT6ehsa3kLE1ochkzX6vgPW0EKw8KsLz3xZJmturnvWH9JOF0Y36q
         WGtV34yxgeLndPxJ/dBQOvUW1NzvSZUC9OOa5f2rB38YHiPncRFzEI+0Dlxn7yf9NWP0
         6HFUzIC4IAFitexJvTUjeZN+x70UszxkNJY/inrcK3yVo7RVKWyIJddto8haH0oh25Va
         bVsTS7dZMs3nE0nvJBlijP2QKL9kiysroI3oMFdo2J5a+xQUHygOpZdB8DAagp6NGhCc
         LFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419297; x=1717024097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdK2lWJFmURLTf6wV+I2BM0kPifXnUIEFqpBMb7vJ5M=;
        b=i8suYVMLT32rZ7N+2N4GBdQe+sILo+1AB5oWFQ+6L8UPVVaZ4WOIht6Wauez4hD0sU
         BPKKR1A4YoKZKdTsxzYDZMX9Ek0y3uy1mEbcvHNMobM8B1ingZ6kVMMyJfLmfETPSkd4
         OjFeTn7Mk4R+asgsY5r5rkClYHRhD4ao0J7bwOrl+Mvun9Etx31GFO45yBNtp7pAY1eI
         K9QFodogNmDymQ7bxOB8CXp2bzJUYB8VnyQgP8GidB79dBfm6oKIRLOEhZ8F/ogm1jL2
         pTTV7UrotL0RwA+/yNQ1cAnM1Kv+9JWD+7Hee7ItDuI4gur7AOcUSefbO7BPODaLpt2V
         +W1Q==
X-Gm-Message-State: AOJu0Yzo2WjY9OrYyuZ6J5K4sE67J8bY2b7Fb6Nub8h9yoc1/khW+60z
	z+1JjzNzp/lUdTLfgDU/8l5t6a0PLf/WTwzKtZMP99PuUyZwlGBr8O7xjg==
X-Google-Smtp-Source: AGHT+IHoEhj5q4ywvQ/V2bg46RcCOqv0cDgHEMdS1hZ0//1U3tb2YvOkD+IrkMpRMp324C0/bKbOvQ==
X-Received: by 2002:a05:6214:3a09:b0:6aa:4784:6b41 with SMTP id 6a1803df08f44-6ab808fc740mr45056676d6.52.1716419297159;
        Wed, 22 May 2024 16:08:17 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab908a01b7sm743886d6.11.2024.05.22.16.08.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:08:16 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/4] specify root partition type
Date: Wed, 22 May 2024 19:08:06 -0400
Message-ID: <20240522230808.14409-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240522230808.14409-1-twoerner@gmail.com>
References: <20240522230808.14409-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 23:08:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/169

Specify the root partition's type according to the Discoverable Partitions
Specification:

	32-bit ARM: 69dad710-2ce4-4e3c-b16c-21a1d49abed3
	64-bit ARM: B921B045-1DF0-41C3-AF44-4C6F280D3FAE

Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/rockchip-defaults.inc | 6 ++++++
 conf/machine/include/rockchip-wic.inc      | 1 +
 wic/rockchip.wks                           | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index 2387eb909934..717085b1535c 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -21,3 +21,9 @@ XSERVER = " \
 SERIAL_CONSOLES ?= "1500000;ttyS2"
 RK_CONSOLE_BAUD ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[0]}"
 RK_CONSOLE_DEVICE ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[1].split()[0]}"
+
+# Discoverable Partitions Specification (DPS)
+ROOT_DPS = "B921B045-1DF0-41C3-AF44-4C6F280D3FAE"
+ROOT_DPS:rk3066 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
+ROOT_DPS:rk3188 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
+ROOT_DPS:rk3288 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
index b5ee6e0c2724..dab61d83ed2c 100644
--- a/conf/machine/include/rockchip-wic.inc
+++ b/conf/machine/include/rockchip-wic.inc
@@ -19,6 +19,7 @@ RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.e
 
 WICVARS:append = " \
 	RK_UBOOT_ENV \
+	ROOT_DPS \
 	SPL_BINARY \
 	UBOOT_SUFFIX \
 	"
diff --git a/wic/rockchip.wks b/wic/rockchip.wks
index e1d74d9983ab..cabdb6559550 100644
--- a/wic/rockchip.wks
+++ b/wic/rockchip.wks
@@ -26,6 +26,6 @@ part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboo
 part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none --part-name reserved2
 part loader2   --offset 16384s --fixed-size 4096K --fstype=none --part-name loader2   --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
 part atf       --offset 24576s --fixed-size 4096K --fstype=none --part-name atf
-part /         --label rootfsA --active           --fstype=ext4 --part-name rootfsA   --source rootfs
+part /         --label rootfsA --active           --fstype=ext4 --part-name rootfsA   --source rootfs  --part-type ${ROOT_DPS}
 
 bootloader --ptable gpt
-- 
2.44.0.478.g7774cfed6261


