Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE96CA1002
	for <webhook@archiver.kernel.org>; Sun, 31 Aug 2025 11:41:22 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.27757.1756640472948533902
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 Aug 2025 04:41:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YgOrmmsN;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b2f4ac4786so27490751cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640471; x=1757245271; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlhIHljrKfcmnC1FB/GUfx0Cc01dxEgoy57EP4kxaPg=;
        b=YgOrmmsN0gHUxPdx6zHQpokE8G5ybJSgdsPCaIX+IlZwT5tdzzYSqGFuvCk25YFpt8
         11p9G69hNN0kTauvJll6Qyb/PNG1AjClyHKUikMnsWN1+qpYzHzIuDEO/W2D6ONScJTZ
         wB12v8gbbJ1h/klR06V+/vwT/5zrXpmz45fYpkp0V4gXsiRI8O30L45f0iW8BXm7q75L
         1h3Tevj2WkZ17DBuywwYn8FkJiubm8S7hZ+wAPtYm2/A95H9ppPJhMFM3HA7Ru/KWdfQ
         fpKbrHMyoPY84LR1zqiHfcItmg7ZjizqzHJSAQ4OA0DPMtQUyX5lEcCx/lYK+5LyhCBC
         B2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640471; x=1757245271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlhIHljrKfcmnC1FB/GUfx0Cc01dxEgoy57EP4kxaPg=;
        b=a+5+aSugzAqsh2SVBzhp6KlOGQjZULUL8c+jQKuhLCm164ekww4qu3OEhlqyqhRMOZ
         ElLnaM1Lek3VrxetybCmLBZhq48Fgxj/DEd/9OTtEJkvQIPkJyrHwxs8oyYbwA+tCkyU
         OBY9aZJIXwTEf2XsRdVWUOKXaEFBp0UpEcNgBaMAQODD4CiHY6F9A9jf6zd68ZEnVF8W
         mqEag9UKSatdTMEnKd2KoBcuifZpovEscrQmFuTFvXznkV2Zkhhg/5FHnuAaoYyTL9sz
         UR7fJ8AD34UWWH9RcA3Hl81WJK26ydBZgTagLGGSu2lgkcCGrszVj7WdOP/xkEFEUQHM
         fQJQ==
X-Gm-Message-State: AOJu0YygvU9Fx8shojnXWcHg1cg6yr+P0atKkQOuuSPv7p8LdZmi353D
	NUJMSmuVeHVshOwVrVbL20Q2xCQ0xgC00PbQR/my1EjlcwoVJ3mLSoK7S/1qaw==
X-Gm-Gg: ASbGnctvA6/l4vW6DVOCwgI8HQf5j+j67F/9INHKmAvYpkyhNDHYONshusv9loSQXPt
	rJdU8f0OJE7LmqjLjFDFaDH6yoHsMUR6Vi0wMrrmheOaWJQSzJST7CsLkETrkyaMPqJvEY1z+bd
	zTlRB8XddNYVgx9JDTApcH5K8ejS4Q01Xl7owQ95o4SVCt7rw4LyuoFZ2wsOqtrU/ehI5zedQPb
	L3N9OgKJGe3nspfP8dssNWOVSIdotmdB6+50vb750tqt8RliPtPBkoUTjpjesoMjHAObAEUxQxo
	oUMolLOV1cQeZ6u6RyD6pbXOIHk+6iytywubW4umbFlKXtnKyLk753vMWBjGaIKMrgmJ1jXkF3N
	EyPFw7vlFxRzkql0eLvlpIGU0cw94YkO9IaRAfmIn8lI7SyYwGugzHFjzMO5vKd1uJgitjAQBHC
	ya
X-Google-Smtp-Source: AGHT+IGDktADbh33GIj/SfAqyeF+MuTlZXlaNv1nEhRflWEojdkWD4glj8nbABcdhZPVQQ/dGgFLMw==
X-Received: by 2002:ac8:5a56:0:b0:4ae:f21a:83ce with SMTP id d75a77b69052e-4b31da3df0emr49426651cf.40.1756640471209;
        Sun, 31 Aug 2025 04:41:11 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6fd490sm45174911cf.53.2025.08.31.04.41.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:41:10 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/4] radxa-zero-3: use non -dev kernel
Date: Sun, 31 Aug 2025 07:41:03 -0400
Message-ID: <20250831114105.27494-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250831114105.27494-1-twoerner@gmail.com>
References: <20250831114105.27494-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 11:41:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2094

Now that 6.16.y is the preferred version of the linux-yocto kernel, the
radxa-zero-3 machine that had been using the linux-yocto-dev kernel can be
switched to using the linux-yocto kernel instead.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/radxa-zero-3.inc         | 1 -
 recipes-kernel/linux/linux-yocto-dev.bbappend | 2 --
 recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
index b351afae8c0f..b05a0872a511 100644
--- a/conf/machine/include/radxa-zero-3.inc
+++ b/conf/machine/include/radxa-zero-3.inc
@@ -2,7 +2,6 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
 
 require conf/machine/include/rk3566.inc
 
-PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
 MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
 
 UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index f49768ba57f1..b876a1cefedb 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,9 +1,7 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
-COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 
 SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-SRC_URI:append:radxa-zero-3 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index cd5efcf9d25c..9d60e2641ec5 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -13,6 +13,7 @@ COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
 COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
 COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
 COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
 COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
 COMPATIBLE_MACHINE:rock-3a = "rock-3a"
-- 
2.44.0.501.g19981daefd7c


