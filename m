Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web10.31130.1712417654356235425
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Apr 2024 08:34:14 -0700
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6ece8991654so2774291b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Apr 2024 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712417653; x=1713022453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL1Bga+2GUSqCltQQXzCJuwoFhj9BXYBnPclMc0LxKg=;
        b=Rp5P1XjtJDGpMAlgZxKB6HtaaMgAWkMIaexcj+1uHB4il7xIqEMI6g/qAkqhlssbyt
         NEMoABJefQe2SOQuTi6IKhWNkFBpLHrl8d2Q1JmofgCuTBq8rx4bb+NGBf3+i5iuBzA1
         rfu/ylti34qnjhb5ThfU+OywYQD1UvTB6GBbY=
Return-Path: <tim.orling@konsulko.com>
Received: from localhost ([2601:1c0:ca00:bd60:b218:59be:238f:ebbb])
        by smtp.gmail.com with ESMTPSA id w9-20020a63fb49000000b005bd980cca56sm3322115pgj.29.2024.04.06.08.34.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:34:13 -0700 (PDT)
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [meta-lts-mixins][scarthgap/u-boot][PATCH 1/2] u-boot: bump to v2024.04-rc5
Date: Sat,  6 Apr 2024 08:34:02 -0700
Message-ID: <d2df6d3fbd68e6b8b958b4f82faee9572cdfb67d.1712417041.git.tim.orling@konsulko.com>
In-Reply-To: <cover.1712417041.git.tim.orling@konsulko.com>
References: <cover.1712417041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

https://github.com/u-boot/u-boot/compare/v2024.04-rc4...v2024.04-rc5

Release announcement:
    https://lists.denx.de/pipermail/u-boot/2024-March/549161.html

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc                            | 2 +-
 ...{u-boot-tools_2024.04-rc4.bb => u-boot-tools_2024.04-rc5.bb} | 0
 .../u-boot/{u-boot_2024.04-rc4.bb => u-boot_2024.04-rc5.bb}     | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.04-rc4.bb => u-boot-tools_2024.04-rc5.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2024.04-rc4.bb => u-boot_2024.04-rc5.bb} (100%)

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index 69ecff8..01067f6 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,7 +12,7 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "f3c979dd0053c082d2df170446923e7ce5edbc2d"
+SRCREV = "dde373bde392c38649c8c4420e0c98ef8d38d9dc"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
 
diff --git a/recipes-bsp/u-boot/u-boot-tools_2024.04-rc4.bb b/recipes-bsp/u-boot/u-boot-tools_2024.04-rc5.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2024.04-rc4.bb
rename to recipes-bsp/u-boot/u-boot-tools_2024.04-rc5.bb
diff --git a/recipes-bsp/u-boot/u-boot_2024.04-rc4.bb b/recipes-bsp/u-boot/u-boot_2024.04-rc5.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot_2024.04-rc4.bb
rename to recipes-bsp/u-boot/u-boot_2024.04-rc5.bb
-- 
2.43.2

