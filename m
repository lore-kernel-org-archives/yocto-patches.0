Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE9C5B552
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:23 +0000 (UTC)
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
 by mx.groups.io with SMTP id smtpd.web11.12381.1748486539607064738
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GN+/+IbA;
 spf=pass (domain: konsulko.com, ip: 209.85.216.67, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3119822df05so416848a91.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486539; x=1749091339; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtFhq8bQ9uIfdumAAVywI9DPtPtGmWoXY7eYbpNrmHM=;
        b=GN+/+IbAYMO+gQeMgzjPMUP9VFsS6CMaM05rCwR3sVwrrE1VSBH/VWJKNhbH9JIKdZ
         ZjBjz8Ex4wPvcqKQHV/+TfYKXMS8PlGVtAbantkqivpxfK4WYuLX6d0YmFtmFwJRKMCa
         /GKCAWtlY/sZ4am6s87t1gxAYEc9zT1y26DXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486539; x=1749091339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtFhq8bQ9uIfdumAAVywI9DPtPtGmWoXY7eYbpNrmHM=;
        b=gPH/g+Eu34HD2/cUrQvrdXKUea1DoaO5U4smSw2s6e/T6kiun0w5VpoNZnORqgkYRF
         eiug3xNL26m9ptPi5iXhBCgpO9USCkYt7GiED0HsZ5/VW3Xx1wU7lZg1m/wlG/VuoO9/
         mr2r34itTea9ALGekzUPlrTIWROlKA9yIvlo54jYQDzR8JDcQhUQz4y56FxF5beOfcuv
         bsfRPzfHV5QShzOBEDJ6iryXGj/EvFd2EDiDUuRbCYjOI7zBS8zO9KgeeKYsnEif73q3
         PtrxlloyWX0G7nOl7QLsRE05LaK21tayE/lAPXCi7+ehyY8gOT9W0NcNIQq+WNtIHIPu
         /SBA==
X-Gm-Message-State: AOJu0YyOcUQG2+iGbjU5COu+J/W8aberN+UvMcfcMh8v1GVVYRkr56Y7
	JobE6xB7pg4LbEBF6DGxYgyLCgJzz3VtSg9gQ6DhSwl/UdIsBXMPNjt30pp2NxXyP/WDoCtF2LP
	3/Y5tSc7KwPiP
X-Gm-Gg: ASbGncvVcxoOjBindXZxKw9HaNL6n9SrhU9/6BZybmyfBgh4ZkEEa9W6gzqq7KdVHSr
	rPOeh4CEBLQ96xprnvMBqlWgeAR/F8TkdbJda8f+WLMXA/zHPYztDO30a6oPGQ5HgIcX+mAX4if
	LayHLkEGqzh+Onxgq0DLY6tXexAsNshSB+UUxBo5g+QaIBGHwqdir/8BnR5EPY55SYsf3k6Q9Jp
	/l+OL+W/hp5vC67Wh6AYcY0LrG+JIWzBRXfr1BbDM6KoB7+X4O4dATAWd93NxovRhxH/i+mBiu1
	5yXnYxOnnbs7uO8lhEJCI3TYuaL0V1TCjh6rJeeQaqijPlEJHaVyHIN8F0uGywZtol/DIA/sREB
	jZg3S2qCh+CC2l8g=
X-Google-Smtp-Source: AGHT+IFJxFKl8PqfssO1R5oDxUtjtNCJiy2aMwCEVMThDMzQuz9oNOG758cADfnM0GLAsGz1d2peNg==
X-Received: by 2002:a17:90b:1910:b0:311:a314:c2d9 with SMTP id 98e67ed59e1d1-311a314c48bmr12514183a91.9.1748486538552;
        Wed, 28 May 2025 19:42:18 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b91c16asm352208a91.22.2025.05.28.19.42.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:18 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 11/11] u-boot: upgrade 2025.01 -> 2025.04
Date: Wed, 28 May 2025 19:41:38 -0700
Message-ID: <68856926465b56b98599ab2506fceb0d1bcfad5b.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1595

From: Fabio Estevam <festevam@denx.de>

Upgrade to U-Boot 2025.04.

While at it, pass the tag parameter in SRC_URI.

(From OE-Core rev: 4a1671159ec05e9b013a7fd31f65d50302e657e0)

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc                          | 4 ++--
 .../{u-boot-tools_2025.01.bb => u-boot-tools_2025.04.bb}      | 0
 recipes-bsp/u-boot/{u-boot_2025.01.bb => u-boot_2025.04.bb}   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2025.01.bb => u-boot-tools_2025.04.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2025.01.bb => u-boot_2025.04.bb} (100%)

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index fc86024..fd1eab5 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,9 +12,9 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72"
+SRCREV = "34820924edbc4ec7803eb89d9852f4b870fa760a"
 
-SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
+SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master;tag=v${PV}"
 
 S = "${WORKDIR}/git"
 B = "${WORKDIR}/build"
diff --git a/recipes-bsp/u-boot/u-boot-tools_2025.01.bb b/recipes-bsp/u-boot/u-boot-tools_2025.04.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2025.01.bb
rename to recipes-bsp/u-boot/u-boot-tools_2025.04.bb
diff --git a/recipes-bsp/u-boot/u-boot_2025.01.bb b/recipes-bsp/u-boot/u-boot_2025.04.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot_2025.01.bb
rename to recipes-bsp/u-boot/u-boot_2025.04.bb
-- 
2.43.0


