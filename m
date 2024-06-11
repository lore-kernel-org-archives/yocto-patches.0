Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B7C27C65
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 18:17:53 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.1332.1718129872058557520
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 11:17:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J7KcQNsQ;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a08b1a81bso60600147b3.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718129870; x=1718734670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcFnWRH7O8ajo79p/PikkFi99YW1DDLN3jjkx/jzciM=;
        b=J7KcQNsQae35PNvu8j+zjHUb6BghuwnzWzmR2jf6krXjFCwEYcCtmGDAcsf46OwEFH
         f0k9mKvINzgphTAsEqAeuX/4AY8musoIox/sAh2g59ZwJlYKv3fmNEc2nj+3D8svjyk5
         7NSEByHrMbDEE7U5LlE+kR96PTzcaRkqnkxB/ZdMZW/2WMDec0SsCFg36J2tDifV34qf
         gXGOJIqaWWZoN2zbpIL7tMtDJhEMtT+zXWM48BSEy/0n/jwLJ69wOFPIhOGLzX4bkUpW
         zB3FCoiyZol98XQ5f65tHLXtePLL6/eR/Xuuv43fpOGUiM9DeLO6Tg2e7+98uMXmi9OA
         0jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129870; x=1718734670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcFnWRH7O8ajo79p/PikkFi99YW1DDLN3jjkx/jzciM=;
        b=b3jUQjCYuZCAH1RXlYoupQbYuBIlMw4QM1Hoh6Y1t2XJvhykq5hc1thDCAzDMd+XKr
         Qc5enofSx0ldzOH9lflHzDMIzmRUpSgqLm3pN0IR5iB6RbFN8ehPF8B7DFULW79vgANE
         bAGk5V3HPvoit9zNxBBbbVgyW+Ujl1Vv6bQkyZHSgQ8QrtPIpt11gI4NKqdpsq/1BYjd
         lJmFfUwSI2nKFzTPqU6L9e8YPf9P3h6Ly9qoGKweDmOLSLeBMx1H+mm5dw2FW6EvUrdB
         SlsJgEvfJIeupYSxmX2PrYrDLvXD7eDQim0vCN79U9S9agdvhcytxy8kMDc+dqQBlYIx
         gVWQ==
X-Gm-Message-State: AOJu0Yyro7WlHaDG/2+9v/SFSogZn3tmGrSFM57CG7WruGnwE6IF3fn/
	gTjhdwHzzD7DN7n1qKeP86PyS6sQV4+TQXvKz+Pmo18tpkWOqL00Ul8Itg==
X-Google-Smtp-Source: AGHT+IHG7eil5+cJquY1IX9+PcTjQ7T4O1g9MqdxHKbmglkB6z99MDN//Oj2hmk6mH4OTanyOJYajA==
X-Received: by 2002:a81:c74b:0:b0:61a:b066:3525 with SMTP id 00721157ae682-62cd55f4a42mr133908177b3.23.1718129869572;
        Tue, 11 Jun 2024 11:17:49 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0895497easm12718446d6.95.2024.06.11.11.17.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:17:48 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2] user-selectable wic compression
Date: Tue, 11 Jun 2024 14:17:42 -0400
Message-ID: <20240611181742.1408-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 18:17:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/310

For boards which build and boot wic images, the user can optionally specify
a compression using the WIC_COMPRESSION_EXTENSION variable. By default "wic"
images are built, but if the user would prefer, say "wic.xz" images, simply
specify:

	WIC_COMPRESSION_EXTENSION = ".xz"

in the configuration (e.g. conf/local.conf).

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- change subject to specify "compression" not "format"
- add information in the README
- improve the commit message
- realize, thanks to Quentin's feedback, that this feature is used to help a
  user select a wic compression, not whether or not to use wic; as such, rename
  the variable and how it is used to emphasize this fact
---
 README                                | 11 +++++++++++
 conf/machine/include/rockchip-wic.inc |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 605773d4ecd3..b21e92360dcc 100644
--- a/README
+++ b/README
@@ -47,6 +47,7 @@ Status of supported boards:
 
 Notes:
 -----
+  rk3308 rkbin:
 	The latest ddr initializer for the rk3308 platform does not output
 	diagnostic messages to uart0. This causes a bunch of gibberish to
 	be printed to the console window which only becomes legible once
@@ -67,6 +68,16 @@ Notes:
 	
 	in the configuration (e.g. conf/local.conf).
 
+  wic compression:
+	For boards which build and boot wic images, the user can optionally specify
+	a compression using the WIC_COMPRESSION_EXTENSION variable. By default "wic"
+	images are built, but if the user would prefer, say "wic.xz" images, simply
+	specify:
+
+		WIC_COMPRESSION_EXTENSION = ".xz"
+
+	in the configuration (e.g. conf/local.conf).
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
index dab61d83ed2c..ebfc0cb96507 100644
--- a/conf/machine/include/rockchip-wic.inc
+++ b/conf/machine/include/rockchip-wic.inc
@@ -5,7 +5,10 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
 
 SPL_BINARY ?= "idbloader.img"
 
-IMAGE_FSTYPES += "wic wic.bmap"
+# if you use the following variable, make sure to add the '.' e.g.
+# WIC_COMPRESSION_EXTENSION = ".xz"
+WIC_COMPRESSION_EXTENSION ?= ""
+IMAGE_FSTYPES += "wic${WIC_COMPRESSION_EXTENSION} wic.bmap"
 WKS_FILE ?= "rockchip.wks"
 WKS_FILE_DEPENDS ?= " \
 	e2fsprogs-native \
-- 
2.44.0.478.g7774cfed6261


