Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F086C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 23:07:49 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.73057.1718665665258278555
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Jun 2024 16:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B7gCmgsO;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7979198531fso356884985a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Jun 2024 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665663; x=1719270463; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDjHA84+vSofXQQilncYBG3TEvhjmfiSId9ZUTFvAP8=;
        b=B7gCmgsOTqox4d990UTB5Hlu3//N7IBAajgAs+kXigs8QTGrLlgkCrjA2XLXf3XcUb
         288Y9Rnoo4d1x3xBf9zWfTvCKvHDZBAf1At1MD9dJcehNJ7tpO7yFYyz1XerjzmVxXL4
         13fKN5WMZlWnEdok8tV0RSuGK9ukQaAcHBEA029wdBcL+hNfc/Lo0D21FlN7A46c65Kd
         p/Y33OKTIPDzkwJ+HqvMWW71Ej2y8w5ptb8bDpaQtBpgs7nV2TsX+M+TLNxwiEwVz+ZJ
         UbkJI8J0OckgPjr7b/wfHwA18RrxgpUZxxkYjD1GORaJwrH8EPlOx53W+g3D7M5IvS7G
         0jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665663; x=1719270463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDjHA84+vSofXQQilncYBG3TEvhjmfiSId9ZUTFvAP8=;
        b=PWfHuE2FNgXVG/5/tbgHTUiN8HS2xg81OD49joStqy5B0ZxSLT+LWAowe30FFhtrqw
         vrqKPG7LfArX7Yak+5b8orLvCP0qJXBG0oyWVdctwe+cuyx4ddEDVFeb6dJcSjp72fgp
         2DcPI3iJyKQUzlVay68rtBHMlctjHoViJVBC5tjLbA1E3qdSB2qf3JWMGuaOujUh3sge
         Ehk9tZOdFs6eGenQF2X6MpdwF90q5sWIa2fmd9QyJzfttQtZJbfUbfKR6GJpRhfuEoL1
         gawP+Dn/zMQ3FMUXIk8xzWe3Ll78gDQybXFSDy06ChUxIkg9QvKMUXpITxOm7mrMWUX0
         Dnhw==
X-Gm-Message-State: AOJu0YweBb3LvHWYzZ5tkP1yMrcK2syY77nzWFeNAP4jbd4PgrAIA2Cx
	xvowvKuYdfN3g+32XSG2lbCKyeFgaV2l/fiXUWzVhY5hDGaY5bQdDFwdMg==
X-Google-Smtp-Source: AGHT+IHmZvGPzI2vKR25WoQz0HJM0XpwPIbJz42vaMMd8GJIIQWurFhS2csAuK/gImjl+56+j837lg==
X-Received: by 2002:a05:620a:2903:b0:795:502d:f138 with SMTP id af79cd13be357-798d24222f1mr1250240485a.24.1718665663081;
        Mon, 17 Jun 2024 16:07:43 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe4b45esm467497485a.120.2024.06.17.16.07.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:07:42 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-torvalds-next: use AUTOREV
Date: Mon, 17 Jun 2024 19:07:35 -0400
Message-ID: <20240617230735.13593-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Jun 2024 23:07:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/334

Already the SRCREV that was used for -next has been rebased out of existence.
Also that tag that was originally proposed no longer exists. With a repository
that is rebased so regularly, the only thing we can safely use to hope for
valid builds that don't need to be tweaked every few days is AUTOREV.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index 9a95eb5bc4d8..a87f73dcda89 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -10,13 +10,13 @@ COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
 LINUX_VERSION = "6.10-rc3"
-PV = "${LINUX_VERSION}+git${SRCPV}"
+KERNEL_VERSION_SANITY_SKIP = "1"
+PV = "${LINUX_VERSION}+git"
 SRC_URI = " \
 	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
-# this is tag 'next-20240611'
-SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
+SRCREV = "${AUTOREV}"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.44.0.478.g7774cfed6261


