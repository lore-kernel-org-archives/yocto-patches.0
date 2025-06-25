Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F4C77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 15:08:10 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web11.17801.1750864087658352406
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 08:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZO2zJvcY;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d20f79a00dso955684985a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864086; x=1751468886; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1JjdTUBalundoMkXPXC0XtG/hiUlbqae9ftsrA694I=;
        b=ZO2zJvcYk96IxIoW6ghWmCDdga8mEbxNXfSuPtQZrNBq+W8G7DXDCdthMCuS/O/dFx
         4PRsJa2huWTdNcdPm4IMFBt1Ya5O2WUg4nRKC+6UWw9qCqNo8QX9TdsurHi6KTXcp+vf
         nmQP6TYRAMmTm37T/Jf3lRRV3BU7AoqE7O1gr1z6dkRti+ZMkpiR6ExAdebvCYsKFHyY
         5vycwOwz9OB1kPXwNSx1NmkK+net58D/ZcT5KXLUCILz+ea3NE8VOuezeEvIn5RAISPj
         pgI9CuPLW+kUZB6oEXxh++qf/7Ml/9+Abed5KGAjzH4DvXBH9S/fIvrhlg0A6JUdkkEQ
         TLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864086; x=1751468886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1JjdTUBalundoMkXPXC0XtG/hiUlbqae9ftsrA694I=;
        b=UYuYj4tmULYVx3iz5E+hGUIzlQTmBmCFp8JEfdawt8HVxGVBEPjK5zrqybUBCQB+If
         wJQr8QffsbR7UfBqyOLqzI2tCyx4L8PzYaH9LvHmRxkcpvrcXHpqC6HgdBOXMyv1ebpP
         Gi91UI5gxyI9y+UwRfGWMfhOHbr1VZGBBHE1beuc5KMHCo5xY9BLLTXYVJDULeRmgwtc
         rSxSeSvmX13suEH8BpjlMB8QJd4sBAIZ2CmpuqIf+70nLF10gWGMNrtP94lof+w0w1Gk
         eBBZPBAwfZZU5/Xm0cM/OOKww5TntnH8p4UtU/2CsnqUXZGCbLFLFR57ZpRKNsh8k7er
         9kBw==
X-Gm-Message-State: AOJu0YxpoFFiWdv4aP6u13BoI6QpN+wWwb090ljbVXjFBT0WDnH5nZKZ
	ieY19VRhyLB6ygZKkAzW25L1fn2IjQp4HyJRcXUJWEtxxQzWdJFQVguqMvo2smfX
X-Gm-Gg: ASbGncumMD/sixNQYIDmxHVW7re7fGe8pUy6IhU1fJL9Qf4xHYTt9FCyljdFSMiz/Fc
	3ueThXXWQtSC/rTxZ8WeXr8gPQU18jb8SMeQWtB5pKwAxbHBphO8eJrxYWCnbTtEf3VHWrLA33g
	TZ2oPVA5jBHUvmw05OtQSLaeiPPNvkucj6lsIHBqpzSXJhnhBoxuQUhEiiwo/48050ZAszwQvko
	QLWyI8PJ04+cG7Mki4hlpcOrsH/5foysF+J3RRruRS6Tb47XbgKBUfNWowtY5qqDpDg3vjHeh61
	7t90tz2xSgcxEO6ugDQOmQbViS5cxifOfG+PaWZkx9g0mit5fuIm1Fjs/5z39QAQIc+yv4mG8Xt
	Rq7I443nLuqxPxZNvxrJ58yFG8kaDaA==
X-Google-Smtp-Source: AGHT+IFwQhLF4IMzuc9dUjsz6nLJE4ItucxUMUw3CftbM4kjfruMQDBZ5tdiCEo7N6K9+8Pxj0cnng==
X-Received: by 2002:a05:620a:4587:b0:7d4:2840:5a10 with SMTP id af79cd13be357-7d4297884c3mr456417685a.44.1750864085868;
        Wed, 25 Jun 2025 08:08:05 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efab4sm622449785a.76.2025.06.25.08.08.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:08:04 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] remove S = WORKDIR/git
Date: Wed, 25 Jun 2025 11:08:02 -0400
Message-ID: <20250625150802.21854-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 15:08:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1689

oe-core sets S = "${WORKDIR}/git" and will now fail if recipes set this
explicitly:

	ERROR: rockchip-rkbin-tf-a-git-r0 do_unpack: Recipes that set S = "${WORKDIR}/git" or S = "${UNPACKDIR}/git" should remove that assignment, as S set by bitbake.conf in oe-core now works.

oe-core: f80c07019dda ("meta: remove S in recipes that fetch from git via setting BB_GIT_DEFAULT_DESTSUFFIX")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb | 2 --
 recipes-bsp/rkbin/rockchip-rkbin.inc  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index eaf2ce1f5f03..ab2c70f02f92 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -13,8 +13,6 @@ PROVIDES += "optee-os"
 
 inherit bin_package deploy
 
-S = "${WORKDIR}/git"
-
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
 
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 79149c5bebc3..25ec58c73e97 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -7,8 +7,6 @@ inherit bin_package deploy
 
 INHIBIT_DEFAULT_DEPS = "1"
 
-S = "${WORKDIR}/git"
-
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
 COMPATIBLE_MACHINE:rk3566 = "rk3566"
-- 
2.44.0.501.g19981daefd7c


