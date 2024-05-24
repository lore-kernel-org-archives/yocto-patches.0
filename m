Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC854C25B7D
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 02:37:37 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.7258.1716518256372710377
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 19:37:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hdBPzkhk;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7931a0a4d8fso540873285a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 19:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716518254; x=1717123054; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iJamAmmRWrwV6kI0fPsFgADYhzoKl9bl+JKsq/Fnyc=;
        b=hdBPzkhkODODYR04JYP5wY2VHgaP4/L5WJ3de27zQ/2URooLHTeSEFmQxdZOppaJX7
         mrjOtYUiPMleootlnhaJuAzI83WSlZt8ghB6V9Dn5ANxn3kNx2VDGzxshC/Eaf/tj3iP
         3yw28O4XY8BFEneLaaFZVZTb+pGRaCQMxTEalG0O1aCOTT51WKgdW8EmHS4L4GUpgvyG
         x8WbQoBdi6k5d4ibVEUXQI7Z4oXSCNEU++MbcYCpwzwh/PC1HpgZvk0EwG5n2OvaZUII
         k925Ro3wcLvceLTGgMUnxeidrz8014f2vOjh6weewwOl6fYWOR/rT5ZuYWP5LK03p0Tf
         c9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716518254; x=1717123054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iJamAmmRWrwV6kI0fPsFgADYhzoKl9bl+JKsq/Fnyc=;
        b=TD5xSNTEbmyl0Tbpwyk5/MWtIGr9sCjpc+4KDYL7otoaoZJnfjiNUV80Q1KIYzKxOq
         Z567DBBLh9wBdWNeEk4RqmA4QDFWNgb30Ohw3MFJtptBr6bVzW79f3iVcWB0IBly3FV6
         kvFNWb6atC2borxJpS3MyjaaQORatVwVMfuJ5FXxMmWhcF3qeHZsFokQrSkuOn4/vZxf
         vbTzfUlcwOgzWFM49kEHcpvzRnqcUM+rTJrkGu5b6Kn3eU6s7/p0TGLszoWYZGM4G0A5
         oTl9Ko/a6NNGg5zdRYbFns65SBfy0cm/PYTp5S52H6Hsl+SudjMIldSJCcXHu8UrQBrA
         hzjA==
X-Gm-Message-State: AOJu0Yx6mxxW60Wvv2ndIOduQS3bQEEhA3gGbUoIsuQzha5f3YvbnCoc
	q5PWZrEbFtg4vpPYTOmar1JJ7l1pIKlGT/0hYDENyrIxZuogPfrRV2s5tw==
X-Google-Smtp-Source: AGHT+IEyhrJzzfIn3zi699Os2Ao+EP+2rpWHNBu33DO2/LYcAsZTLAbR0nvWsQvIijvSoEEBpTskNQ==
X-Received: by 2002:a05:620a:4787:b0:790:98ba:67c5 with SMTP id af79cd13be357-794ab0acf2emr109055685a.33.1716518253833;
        Thu, 23 May 2024 19:37:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca6357sm23285485a.15.2024.05.23.19.37.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:37:33 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 2/3] specify root partition type
Date: Thu, 23 May 2024 22:37:23 -0400
Message-ID: <20240524023724.20109-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240524023724.20109-1-twoerner@gmail.com>
References: <20240524023724.20109-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 May 2024 02:37:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/185

Specify the root partition's type according to the Discoverable Partitions
Specification:

	32-bit ARM: 69dad710-2ce4-4e3c-b16c-21a1d49abed3
	64-bit ARM: b921b045-1df0-41c3-af44-4c6f280d3fae

Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- use lower-case for both partition identifiers (in code and in commit msg)
- use Arm overrides instead of MACHINE overrides to identify which identifiers
  are used for which builds, this clarifies why the 2 identifiers are needed
---
 conf/machine/include/rockchip-defaults.inc | 4 ++++
 conf/machine/include/rockchip-wic.inc      | 1 +
 wic/rockchip.wks                           | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index 2387eb909934..e33a25c07b5a 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -21,3 +21,7 @@ XSERVER = " \
 SERIAL_CONSOLES ?= "1500000;ttyS2"
 RK_CONSOLE_BAUD ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[0]}"
 RK_CONSOLE_DEVICE ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[1].split()[0]}"
+
+# Discoverable Partitions Specification (DPS)
+ROOT_DPS:arm = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
+ROOT_DPS:aarch64 = "b921b045-1df0-41c3-af44-4c6f280d3fae"
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


