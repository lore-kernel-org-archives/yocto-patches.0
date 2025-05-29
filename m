Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B678C5B543
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:03 +0000 (UTC)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.12371.1748486520097727852
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WHjUoRpI;
 spf=pass (domain: konsulko.com, ip: 209.85.214.193, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-234477e3765so4350405ad.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486519; x=1749091319; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8YARpms9tgVK34KLCMupvTM26DOPFgr/li0ljjYm5I=;
        b=WHjUoRpICWeigHeN46YJ8RpcQF8wASIkjpwqMcJ6OfraAQuzBUeHPp5fMCOvdiS2aV
         YP0WxelVnAVyfHdcviyhrCfoGsOcSQGln+H8dYmsLtZ6fHxKGXk6Pqc+Q/OUe2tul84s
         9R9PZe5axPqb/IXyAK8fFPzSAhPjjvEBsgEHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486519; x=1749091319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8YARpms9tgVK34KLCMupvTM26DOPFgr/li0ljjYm5I=;
        b=uxREiMEXnEEeaB212XTyS26Z+AwdtIAv1ULnTndTIibEUQO94TvpWU6mns9We8CiyS
         z8QDVuU3/IbRet4zVFKQo5c+W47+A2ZLOwObdvMg2GPgjz3fGcyCj3gvUwpPb6i0LDYf
         sZINpunz01lVrB9RiFePk9umL1BuMx8gJ3Ne1GpImnbdu0z3Yr6mlubjn0uhLBA1rgNs
         vniMENbMufoN6Elx84ADgu4bK77/1DrB/bz6OQFBRpLJ2NhRkr6GbJTzLfF9X/XcYs71
         0l1JPylB7Zc1/kzgL6inJuaTmXCxwEGZzIwKnSQFga4td3KRYyH8MTOLNxrCqHtwWbUZ
         hdPg==
X-Gm-Message-State: AOJu0YxyuzjfT4TmhluSMUco/Z8rcIGSZwXY1Oipu/3eDST6RLWqiiX1
	oNM+JCN9i60RSgKQL72lKantVTWmNkwD3gtNMOJrxmzs64l6z1xg5BOCEK5cmbJVn1TyUgu0CYK
	iiZp8sW3FCFds
X-Gm-Gg: ASbGnct3CeaN8pRpr1Twfg39vVUgrrsAord4qYEUXQBtwQ/5JRoSNU790pS6DGvxskj
	MlKhZJILa0tVwe8QA+FUIR5pM4B2a9Bre+TobHJOJ8ehQSu6Zo2DE8V4baSEYqcCZRlDzj0V7fI
	nNaHhXA70K8ySaOuF90WSYweGzrcbKbRaoPUuPbeBgXWhG8EszZxWYpHAqaf9493kcHfeQnFTYM
	XZB+/fh9LtXN3tBGj59iKuvplY/NNA6RLiYBC6FOiaS+KPmpm6JZN/Scgn/uFv61QQCz/dook6N
	HxvHjl0D+aGeZ18jrFwk+5mo31MunCa+gbGtOEfNjIfP6hOv383mOYOtdKBqoy5ibIstQabrZjp
	ME8pMyNPmKkE4sn8=
X-Google-Smtp-Source: AGHT+IGcgwBCyFVHBzm4ByHFKFNMxle93czuaD0oIyXhAA8vW5zOMQyeJht+a4dqOkdc1ZxzQYrpWA==
X-Received: by 2002:a17:902:e849:b0:22c:3609:97ed with SMTP id d9443c01a7336-234d2add5bdmr51972475ad.30.1748486519083;
        Wed, 28 May 2025 19:41:59 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d19c88sm2745835ad.247.2025.05.28.19.41.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:41:58 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 02/11] u-boot: upgrade 2024.04 -> 2024.07
Date: Wed, 28 May 2025 19:41:29 -0700
Message-ID: <fcea00c1bf4a66aaa119af8730cea6ffb11bf23c.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1586

From: Fabio Estevam <festevam@denx.de>

Upgrade to U-Boot 2024.07.

(From OE-Core rev: 377e8d7fc019b0b2a0fd020e51741a4543f5f209)

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc                            | 2 +-
 .../u-boot/{u-boot-tools_2024.04.bb => u-boot-tools_2024.07.bb} | 0
 recipes-bsp/u-boot/{u-boot_2024.04.bb => u-boot_2024.07.bb}     | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.04.bb => u-boot-tools_2024.07.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2024.04.bb => u-boot_2024.07.bb} (100%)

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index ca53573..1b5382a 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,7 +12,7 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "25049ad560826f7dc1c4740883b0016014a59789"
+SRCREV = "3f772959501c99fbe5aa0b22a36efe3478d1ae1c"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
 
diff --git a/recipes-bsp/u-boot/u-boot-tools_2024.04.bb b/recipes-bsp/u-boot/u-boot-tools_2024.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2024.04.bb
rename to recipes-bsp/u-boot/u-boot-tools_2024.07.bb
diff --git a/recipes-bsp/u-boot/u-boot_2024.04.bb b/recipes-bsp/u-boot/u-boot_2024.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot_2024.04.bb
rename to recipes-bsp/u-boot/u-boot_2024.07.bb
-- 
2.43.0


