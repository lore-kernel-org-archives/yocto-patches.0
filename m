Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A990EF06FA
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:32 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34797.1770587126581125182
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fURNwJA6;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-793fdbb8d3aso36466277b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587125; x=1771191925; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jZBVXqv/JRBXvfRI8J2rO8pB6bPj3CT7nOMsM6Nebc=;
        b=fURNwJA6ps5cwcvyl59iKd/0jy13tr4At2rpOVO1LG1nn+8u2K+uZ2a7R+ZIDAwX89
         EQ3faJD1WdOf04UO+HpzRfmkniND5NffjUZKqv1/5tWOexvgdi3eAXf3Ql5r7DBPVL1o
         OC6zgGn15lsyIHZXv7Cb4xOuTS7jq6yAQu/DO849IZBdlaAjrXYLYLmzs0OGd1HXXERe
         a/HudZNC/F6UNJRKS5BCl+7sCAuKDJFHBvsRSW9flOeImd16x/fXTOinHlSW3lcnaPzZ
         Zf09JXz6BOKpAWyxboujh1IWiV/rS9XpYskckWXR9/qJmv3bC6Fv/D+OEGsNwWQig9ih
         RtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587125; x=1771191925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jZBVXqv/JRBXvfRI8J2rO8pB6bPj3CT7nOMsM6Nebc=;
        b=wVNupth1OHa6Fi6iVKGAFathMq/R1nCYrUeX0DOIxhiesD8pjB/OEmbDZUTHUz4HMz
         pUGmCaj/oAEZC1geLGqxXE31sQGgjJp9aftjDvo1772pdRPcYV2P4qEeCqwUBwYW7qPv
         3lx3ntVMqAHOdg1Si169M/oDy9TnWmNYaQL1nipV6rjw5BEW882E12iTJRh6AgB40OGU
         tqvmqIWJMcTVD4kBVcznHc+RCxXFCFBhvSLJVGdGK8yAkN1M/wI0KrYmCQHWXdPqQI58
         z7ELv97sxRsMU5iedNvMn+LzilyHCXE0zuO+TPhGyIXV4aIG3fp+j9P+G8qXo+l0+i/5
         u99Q==
X-Gm-Message-State: AOJu0Yw7KzQ6ZRgZ1gPTKZx6M5PhCqMW607grien+POpdv9Wb5QMCl/I
	z6QczklSwty7oz3OgXIePr3kR0KLF5WxLpcSqQmAVr3d7gSET4hiikcSntX9qg==
X-Gm-Gg: AZuq6aKwKDoycljid+YievyzMP3tGtsRMr0OPZUh3Lic7nLD8HibUtif5bIZTnQ9J1O
	m8CywWpO0UVOo2AF7lCZJA3VsgS1+gzuKa1Wk5riPKe63V6cfcuLOx/9lNGPNMcFnCq3yt4+M8u
	ztWfooM/7GR3Ucd4j+/QosL2fwesldVoshzA+aGNLyld9dExKIfICLqgRo46+LxfipGO8GRMc2J
	zhQjjkBdr1QOWbyNSpNAB7eKpADHTexecWPh1IO7ITyJtVzEWZ+gi1Z+cilvYssP1q4cDQRQgOX
	f8IxMkzOFRjlvjH7LJKoYCewivDxDCgUtZgXC4j2EzCqGWszNBAyfV9unL6y09EHc/ejN9FdzCG
	HSN0oHAscou9KLXTJdfmwmvTM7RRQOUAAb2VScZTO67EXkfAOvb7JLkxaWxKJTGImPjUO2eMDFg
	aNU6YvDadu8M7PMFb2uJzx4g==
X-Received: by 2002:a05:690c:6b07:b0:794:c129:f6b2 with SMTP id 00721157ae682-7952ab69872mr89797497b3.56.1770587125342;
        Sun, 08 Feb 2026 13:45:25 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:45:24 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 4/5] qemu-cortex-a9: fix DEFAULTTUNE to cortexa9hf-neon
Date: Sun,  8 Feb 2026 18:44:29 -0300
Message-ID: <20260208214430.1048640-5-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208214430.1048640-1-charles.embedded@gmail.com>
References: <20260208214430.1048640-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3204

From: Charles Dias <charlesdias.cd@outlook.com>

Change DEFAULTTUNE from "cortexa9" to "cortexa9hf-neon" so the
toolchain uses hard-float with NEON, matching what Zephyr expects
for the qemu_cortex_a9 target.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
index 4e42695..a04e058 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
@@ -2,7 +2,7 @@
 #@NAME: qemu-cortex-a9
 #@DESCRIPTION: Machine for Zephyr BOARD qemu_cortex_a9
 
-DEFAULTTUNE ?= "cortexa9"
+DEFAULTTUNE ?= "cortexa9hf-neon"
 require conf/machine/include/qemu.inc
 require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 

