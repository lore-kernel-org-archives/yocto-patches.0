Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9AE77180
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 15:49:03 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.18723.1734104933681320785
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 07:48:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H90Tclrd;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8edad9932so14653956d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104932; x=1734709732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwvYj2HKbQGiAy/x/+qfqDk3B83EnRWwraGSS4aPBp0=;
        b=H90TclrdBYvqsDjn/3DW0xJiIlN7fPIY8OHFyyyzOy39iwK5a6C+BU/H3p3LHVje0w
         mZC5aviBSSgfAXFD4QQPA8ZbYI4yPXXOBeBCL/mJsQ4BuEuKNvpcYBpGkdLEETPXnS9D
         EouxtUfoIh00O+6DiMRGP/Sx79yY6hy69AWT+KFyUPlNF0eSSY1dZtB0cB5M5fKwp6hI
         tvaNWZC14ROddFPip0U6/07rpQC7+rBI7/tBdkLpztiE6sP8oTN0Qv3oT6l+O3Qshjo7
         8bm7ZiPwnXUXIORV7m4dkFCfctswjjHsdrQ8JnOUJszHTP0/oFxmNVc24I2eC9UBLn0p
         IOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104932; x=1734709732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwvYj2HKbQGiAy/x/+qfqDk3B83EnRWwraGSS4aPBp0=;
        b=FznC3oPyvxB0FLIl6/PbyA9g5DGxpfaOphQuZ5JV5X20MidbslarnPvZjn/zAlYcoH
         Dl2p9EaOCSISKiPQkq8RuI1inYoPfbnRv6CBuCugCh2yfkx2nIa6c8WiyBG5ijowhjv9
         d+YT7JYjuZlQJyJlfNQ6gzKchrgDtCpzAF3FU7UEWciLowOtfZbN/9vICDxZo8MMCn/Z
         gHN6+ihYpxgu74gS9ZdqqkcmnrRKcmEKsX1DnHriNlbUZFVSH9a11ET30Ej0L5W8TZAv
         ZDacaN6jU1Cubnt4J+ZV2jmKZh0iM4f9o7DwXSZAyXQ4BYepH1/0m3aNjtsSHUC7kocC
         pqLg==
X-Gm-Message-State: AOJu0YzDphESrnLj9YFgO+g8uq/8TfXo+jJQT0RqoBaAc91NQA0bcXc6
	hnrwMc7GhLnpWNmc+ariX8phPJ+vIX1jUudP1aDm3EnEWPtyAvJtOx4Upw==
X-Gm-Gg: ASbGncu6BcWuLauwFsIjlL1ycksVHTbThL5psEUB1PbsVidX0d6xjTIueUbiAnjyLaM
	ONjxvkgBGAAPes7lD21pPzUQp8Mz2RIRKXc6uOVrSEr8uo+FeXc6Wm3WC0UIA/5fDl9AZ/shEHJ
	+5TbACFxelgN3QvOPhCjGZKi75SfoDjl9bRQgZSE8KwTJOwPMnNHjVgL4LIeN70Iw9uV5mW7Cm9
	bjOHmS40Cq/i0rajm3nxX+7ZuMfBnOKdbHVzI7d6Q3auvP/ZfFG4Dm2lstrzkB4OH5ZzYZLGbgv
	NDY1W5s4zjfYOBWOKryrqDyP
X-Google-Smtp-Source: AGHT+IGjRndcrRrTH01ugn7uCxrVVTQKrehj7EZKvF+cVHxl3/0z+efTBnwrG01BY9WVAfPxq/rmjQ==
X-Received: by 2002:ad4:5f0e:0:b0:6d8:a610:21cc with SMTP id 6a1803df08f44-6dc8ca3d469mr59267196d6.1.1734104931993;
        Fri, 13 Dec 2024 07:48:51 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm92221816d6.58.2024.12.13.07.48.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:48:51 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 3/4] radxa-zero-3: switch to yocto-dev kernel
Date: Fri, 13 Dec 2024 10:48:42 -0500
Message-ID: <20241213154843.27592-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20241213154843.27592-1-twoerner@gmail.com>
References: <20241213154843.27592-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 15:49:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/901

The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
but they are supported in the yocto-dev kernel. Switch to yocto-dev until
support is available in the yocto kernel.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1:
- add [meta-rockchip] to subject
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


