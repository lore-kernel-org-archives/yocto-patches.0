Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E1E7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 19:57:48 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.390.1734033458869417819
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 11:57:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fn15o+Fk;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6eeff1fdfso77706785a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033457; x=1734638257; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ahBA3hKjDAXs3BEnyfW/tdHk16Mj1yZa8e67I1k8Pc=;
        b=fn15o+FkKiv3B1lgYephAWfD+On2GfYmzvaXlnHoq2eBFKLjiSByvVu0f0/FQUBjfm
         Es7qGrZpcn/Pk2kpH4Mj1SHmHV1wZJiLtiY91ysnWZgjnxeTVS6pqD8Slb12XKioXNEp
         nWBsZ5E3AktarpwbFzMvjKB9WbLQg8vnxTAfEXLfOhW197JkDPNcuaM2cGSihl0tuXlS
         4n4Fh1CFYEgxQoCC14RMqRKEc09qEAZPTFUrJVTieW/iWcP5HoqcA0+oAgGhhLmJk2ge
         aXo/0YL8UkXos5IanqIHZ+TwnMNZtJRDRh+U4oYxgIe+x+mpBBA2J52U5CbGOP4om3M8
         GvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033457; x=1734638257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ahBA3hKjDAXs3BEnyfW/tdHk16Mj1yZa8e67I1k8Pc=;
        b=eZM6AfFTvFuEUaEv6i3aljgxBI2NJasxhGAC0csCvxS5ulasZ5PMk8eOVRJczCTKkp
         DhGIsNK18Sn4lexlVakz+2gql67EVTOocdoGO3hGebWq17p36nVvNDGZouebjYexymmG
         a2Xf/ehRGWXvqQyMdCMwZ4JOiyf+WHmu0LUMx462aA27GCRFECR5XMDBEQjzfWkaWLAt
         hU7rOzk/IRHBdd/7D9NPCeZrnaGBU3mR604bsOcbIEHpyL2DnonwIwFz0YuyIXrKaDhX
         Hx4R4Q+qLyFaUmVRhT0BShPkDjwKDjmBinc+4yf066mVUirzryoU9H+cCl2nuxneV2Pc
         4k3g==
X-Gm-Message-State: AOJu0YziddckKv06P0TB2UftTXE53NEwXDWeCJLrue5hCsHS3DTdMaPi
	3uH+9s2HEAPLigYjcTZheq+iZMqB/NmUHUIrV9dr27oOEPP3EBA0H9VIvA==
X-Gm-Gg: ASbGnct1rXcFbH9SABbciOSt+xFAVBhePtGPY349DnwotmV2JHUy8U1w83aOYydpdFa
	lbfFEXXbxpxaGeCgtIn86vPYvgiH4Jxbr70t19myJlQppY1EUXoToS/qn3sgz4hx2a+Ey/ODbxX
	XPMyD6tycPB+/7UoJiKz/wmbGInYn1XMsCQ/y/LNNQpIey4NLVqNSrRX5pDD3DDStq3leyYsgdK
	UoV2eRtv2UCFPC0dkBzejXHcq1jDHnjwv27Gy9jbYAfxnNM0N9a7O0ZizqNK6eQpWTbPWckEtzy
	XklNC78dFWpAsorMavTwvCZ9
X-Google-Smtp-Source: AGHT+IHe8mmu2zB0ZzL/6N7zWtCuCGzK6BlbUbjPSwRkg9I11Rf3ajGlWOehQ6hGtkaCCWHMm1y+LA==
X-Received: by 2002:a05:620a:7186:b0:7b6:d6e5:ac63 with SMTP id af79cd13be357-7b6f88df0fbmr239791685a.12.1734033457091;
        Thu, 12 Dec 2024 11:57:37 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f16ead8fsm133406185a.39.2024.12.12.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:57:35 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Subject: [PATCH 3/3] radxa-zero-3: switch to yocto-dev kernel
Date: Thu, 12 Dec 2024 14:57:18 -0500
Message-ID: <20241212195718.25203-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20241212195718.25203-1-twoerner@gmail.com>
References: <20241212195718.25203-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 19:57:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/890

The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
but they are supported in the yocto-dev kernel. Switch to yocto-dev until
support is available in the yocto kernel.

Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/radxa-zero-3.inc         |  2 +-
 ...xt_%.bbappend => linux-yocto-dev.bbappend} |  0
 .../linux/linux-torvalds-next_git.bb          | 25 -------------------
 recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
 4 files changed, 3 insertions(+), 26 deletions(-)
 rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend => linux-yocto-dev.bbappend} (100%)
 delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb

diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
index 1c6f972c1e31..b351afae8c0f 100644
--- a/conf/machine/include/radxa-zero-3.inc
+++ b/conf/machine/include/radxa-zero-3.inc
@@ -2,7 +2,7 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
 
 require conf/machine/include/rk3566.inc
 
-PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
 MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
 
 UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
similarity index 100%
rename from dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
rename to dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
deleted file mode 100644
index b961b1408f09..000000000000
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ /dev/null
@@ -1,25 +0,0 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
-
-DESCRIPTION = "Linux Kernel"
-SECTION = "kernel"
-LICENSE = "GPL-2.0-only"
-LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
-
-ERROR_QA:remove = "buildpaths"
-DEFAULT_PREFERENCE = "-1"
-COMPATIBLE_MACHINE = "^$"
-COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
-
-LINUX_VERSION = "6.11-rc6"
-KERNEL_VERSION_SANITY_SKIP = "1"
-PV = "${LINUX_VERSION}+git${SRCPV}"
-SRC_URI = " \
-	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
-	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
-	"
-# this is tag 'next-20240904'
-SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
-
-inherit kernel
-inherit kernel-yocto
-require recipes-kernel/linux/linux-yocto.inc
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index b6a63d7b7b29..f738d1357d6c 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,5 +1,7 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
 SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:radxa-zero-3 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-- 
2.44.0.478.g7774cfed6261


