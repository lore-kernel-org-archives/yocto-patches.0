Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F6C5B549
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:13 +0000 (UTC)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.12374.1748486527112950092
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QpWdy62f;
 spf=pass (domain: konsulko.com, ip: 209.85.214.193, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2349282084bso5947335ad.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486526; x=1749091326; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMaFSQHiB5u6+zDpEuU54+n9HwB48kcxixGoMiFgcvk=;
        b=QpWdy62fq130Hq5R9exZeqs87ns9fin+XaEe91m2jwl1CVluxrOdEjPtxc/0dauEtQ
         81OiHcPSTf1+DzsGPJHRraeRE15vlPKR65D30a6NdmyoFOeuGcB/o86IrbdAMi8uN9v4
         Gd5MTGxSwL6gqZZsfw7OZXbGPmKOSbUjM+cMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486526; x=1749091326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMaFSQHiB5u6+zDpEuU54+n9HwB48kcxixGoMiFgcvk=;
        b=ngNEK/whH9podOuRMVONLNNJQRejaWv9Qw4s+hh3xJ2Lpz7Ei9i5+fqW9xkD7noQyA
         Lhb07Ek3ZfG5JwX1qrmP8QrzGMwCfPLLI5vhQwgHvpW/dlW5LFUREP5+C+nMFHm6yD8l
         owj1qqatJ9PYRepCuBjJhIGMY/yQlG6TaZP4+QKA1jF9m1JtmkzrYnsPWDBF+U7pJPKz
         QOnZq+3sT9bu7VuI4stRLqoWekyOfLPd3PK/51JvlxBHY1/LoazPY/hf8pqw2S1MhQ59
         xB8azKCm+2H1aDqjf3sfS5FzgzrJgWE3m9mlmwfiG6kxemekIeaQwucIUpjChIHrk6B6
         uzGw==
X-Gm-Message-State: AOJu0Yz54hMp0sfhrqV6yOc0Y0Mbw2iLooaors6oMnk59KCwXAH8BLEK
	L9px2PEBG0zB06wYj0wYcViq7nl3i399ut0OUqPEu3Y4RkNw16eO34ki3Pi54tcaoln5wGa8Cc4
	hgobes/RZQGug
X-Gm-Gg: ASbGncv6y2/73s1NYg51YaE3v6dvsURWoOGJZQFgmlXBeDczXV4oT6Zm+Rirki2oc77
	MTqpap165GRHlvwPFl6QA92zJFfzmcPTvMgIqE09AWQy1H591v1JDKbcm6YVPW4nQMlpY+GEWv6
	sMWPxbRHQrvnbz82FlGSKpeS8+Gv07J+crfadgL+CXtVZM0kKdkc2B5tSq6sAfwZgnAZISkBR74
	G79PD8upZ4aOgFJNPvNm4DV8oR3N/Fr51WoKEEAxmOahIz7zlIrlRAeivVGjRpFGpRjmtj34Am9
	YzbXRMHShsdi0BIDHsMqhINRcvgtWikIrebM5uUkJhlFrzXRmgI2Zw4QREQMw2lDYJye5gHbFnb
	twijtU5jM+ki+qB0=
X-Google-Smtp-Source: AGHT+IHOeuqFWSkORHvuUm5EsQx0s9V8u6QXuFlrDX4GS+p31A3VpQZ8w4rvVLcmHnWi3BfZrGyPog==
X-Received: by 2002:a17:902:cecc:b0:235:737:7bd with SMTP id d9443c01a7336-23508033d8emr6643065ad.27.1748486526171;
        Wed, 28 May 2025 19:42:06 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8880sm2876395ad.22.2025.05.28.19.42.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:05 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 05/11] u-boot: upgrade 2024.07 -> 2024.10
Date: Wed, 28 May 2025 19:41:32 -0700
Message-ID: <16a823200c47413be169ba887e2786cb511cf17e.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1589

From: Fabio Estevam <festevam@denx.de>

Upgrade to U-Boot 2024.10.

Add the gnutls-native dependency because now U-Boot needs it installed
on the host machine to handle the CONFIG_TOOLS_MKEFICAPSULE option.

(From OE-Core rev: e3ece22060725c9eebc0feed9b2be2d00ce4bf8e)

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc                         | 2 +-
 .../{u-boot-tools_2024.07.bb => u-boot-tools_2024.10.bb}     | 0
 recipes-bsp/u-boot/u-boot_2024.07.bb                         | 5 -----
 recipes-bsp/u-boot/u-boot_2024.10.bb                         | 4 ++++
 4 files changed, 5 insertions(+), 6 deletions(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.07.bb => u-boot-tools_2024.10.bb} (100%)
 delete mode 100644 recipes-bsp/u-boot/u-boot_2024.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot_2024.10.bb

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index 1b5382a..113f215 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,7 +12,7 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "3f772959501c99fbe5aa0b22a36efe3478d1ae1c"
+SRCREV = "f919c3a889f0ec7d63a48b5d0ed064386b0980bd"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
 
diff --git a/recipes-bsp/u-boot/u-boot-tools_2024.07.bb b/recipes-bsp/u-boot/u-boot-tools_2024.10.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2024.07.bb
rename to recipes-bsp/u-boot/u-boot-tools_2024.10.bb
diff --git a/recipes-bsp/u-boot/u-boot_2024.07.bb b/recipes-bsp/u-boot/u-boot_2024.07.bb
deleted file mode 100644
index b15bcaa..0000000
--- a/recipes-bsp/u-boot/u-boot_2024.07.bb
+++ /dev/null
@@ -1,5 +0,0 @@
-require u-boot-common.inc
-require u-boot.inc
-
-DEPENDS += "bc-native dtc-native python3-pyelftools-native"
-
diff --git a/recipes-bsp/u-boot/u-boot_2024.10.bb b/recipes-bsp/u-boot/u-boot_2024.10.bb
new file mode 100644
index 0000000..db8b2d5
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot_2024.10.bb
@@ -0,0 +1,4 @@
+require u-boot-common.inc
+require u-boot.inc
+
+DEPENDS += "bc-native dtc-native gnutls-native python3-pyelftools-native"
-- 
2.43.0


