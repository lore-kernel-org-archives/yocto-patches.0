Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB431ECE585
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.55089.1725893749127517252
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QAgF10Wi;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-457ea6560a3so26738281cf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893747; x=1726498547; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StG4IsxOKSWlM0J0ovknX7GsQcaX4Mq6HWzfB1MgxvY=;
        b=QAgF10WiTinV6acmMQPiX96VoFY3w4wZC+ILwUSKCFbdAnal6XXjLKjB2PmWAEAshX
         O6QIwHyeM53grF/IQkHC7jRlbHJ++ntPl1Ij+rQfF2XciNQSRd2DcxBKzBSRL+zr09ZY
         HGStr3Dagft4X5mKWR++YZ0RZLDax1utaa3imw6Roln0GPVEkMJKkVYKJlMcHXblwpBc
         9kAeZlnnMGLiih1MJWyuyFbHNN+PYJJZd8T+JpcCUo5MTjgJDLzvDJqxfwNkKGJWIOy1
         VsWgcdZ9HBtUCNWsHQEoAnTk7dfAJuY3oh4okShIwyHxTE3d8q+ylPsvl1RGVutdfrxx
         2jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893747; x=1726498547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StG4IsxOKSWlM0J0ovknX7GsQcaX4Mq6HWzfB1MgxvY=;
        b=I2EnZ9wqS9/Zaeos7Xfdgz4eKSrNMzR26nARfjcpMREcKwLUtTeJHXkBaAWQnVVpm+
         ysovDHOfpH8O4SUisT552K6orEwbuQk6oPEkLr3BI02+U0yH/7kYYrooNwNInIUc1/pA
         BUW2WWArnzDaDgXBhOqGaznfP9AqazT+E5zV5fO1NYoRjVYQT4vIwt+AQLs9VufH6UAU
         CC8QD76UXCWf7qKNefqyy6nnXWlBRjUZOYUK5L16mC+o6NdZX+0Apnauqs0m5oB7aLx7
         77QA4fANliWqH323lCIlsiDNIdLu5n3ZbALe6ZvdxuvBmd70xsP0EnRSSeUyc4mW5843
         3fBw==
X-Gm-Message-State: AOJu0YxFZdC3rJ5FHg62ZfrKJoD/GBpS69NrIUG7ilx9qcwLZ0UFUEL0
	grhKsp8kS0S0tnrM99ITtvdoNaDFIlPaAymmCfIpTNV/X46Xf5F5ksInv/by
X-Google-Smtp-Source: AGHT+IH7S9sobiD2NCb+eroDmnxayGLF6WTy9AEKgnJApFrmZ6BPIMwn6ZmXTh56TDA28yOYEEvZbQ==
X-Received: by 2002:a05:622a:3cd:b0:458:38cf:410e with SMTP id d75a77b69052e-45838cf4326mr14359351cf.22.1725893747232;
        Mon, 09 Sep 2024 07:55:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 03/10] user-selectable wic compression
Date: Mon,  9 Sep 2024 10:55:23 -0400
Message-ID: <20240909145530.25301-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/629

For boards which build and boot wic images, the user can optionally specify
a compression using the WIC_COMPRESSION_EXTENSION variable. By default "wic"
images are built, but if the user would prefer, say "wic.xz" images, simply
specify:

	WIC_COMPRESSION_EXTENSION = ".xz"

in the configuration (e.g. conf/local.conf).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
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


