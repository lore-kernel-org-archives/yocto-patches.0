Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877AF36BA5
	for <webhook@archiver.kernel.org>; Sat, 11 Apr 2026 07:14:56 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.182053.1775891695319361762
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Apr 2026 00:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wkk5tN/u;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so17569535e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775891693; x=1776496493; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3d3nkaxfWdIxpBDmdRbPNgb3kqjFybGtzttlvdWwMM=;
        b=Wkk5tN/u/Ge4BsISE2KCcIvjuaa7MJP61IoOEcf1BzMsR5p3T2434uA5ARmspn7LFT
         1Yw9CnaKs1Nv5Ke9+j7xZCFHZAdcCTHTWnJK4LRpKyiepwNtYKXVb73w1njtZYWP/apY
         r8xYhfuOCV4lqNwHKQLIp18HfAxDoeIrb8DGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775891693; x=1776496493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3d3nkaxfWdIxpBDmdRbPNgb3kqjFybGtzttlvdWwMM=;
        b=M48EQ1en7Ry+DP2zA2g5cvOKMlihaIgUv4B4fSrzyLy86bDOsnDUXcaoUOl/hqHzCH
         BOApHUNw9NCgHnlJo3Rgx9rXjE408E0H0+c+mYEU0DLg8HJUazv9t/clAe4YthZfuUgq
         I0IsRS8r9X0RgHGkm1W7Z62xkOYVi7YC75A/jgmUsm7XtHERBbNoTVZBTbm5vWhyHorB
         PYA8QGbezkCLRw+yWtaRvXTsIKaqnhYvAejbPvf2nxuOr4QCW5ABRivCXVjCzbNnL79E
         XwkLyxe0pMFd4r0ZfDVDXPDHzzU9g8hBPRcxCft3oxTPb/eUFrKhWC7ajSwducEKjGr+
         39UQ==
X-Gm-Message-State: AOJu0YyFEsSpzj89MI2zZLjznbwJT7OZI8x6kEUIgf267O7iCgB6oHlg
	uzEs3xtKUBpg8Tusq/e8anxcHPQdjAXBTMkKijxvX4mbAIJcH0bvfEDTaAR1eehX2lcjBaF7N9A
	vtue1pkY=
X-Gm-Gg: AeBDiesxXYB/Y0KJB6iGXFKnmqSlLZhc7pF5xEb/Ztrwp21hlcaF8CScyVon/eZ76ro
	7IX+0/rVt3auS3szSefLktxAluo0cfClJAKZIVi+RUUNic2+i/V/qaIpOj2XuS0jYc8d76oI1Oa
	tewbx1QZd//CVFrpIHThLjBTAgN2sq7fFm8YvqqB5xobxvkIwGNTEkc5MuaE8p5mz/ToVlBnoV1
	kkvxl9ug7rFZsfbfD4XI/avZQgwPD3KZ9jfjbn88rSX5j/ow+JDmpYjDejLes5VKkq1rnpqEuFK
	QmPBMIWEms/8yOdGEZqw7m0pxZTSgASpG9Q99q1YSaEB9le877tR5aSkw9BLlzAzFkAFGn61vs9
	pgEzCdq4v2GIWPfY4VuAPER4QkGP/q2ODlUnTxV0xrMX5lgU1ZgkcL3kzOgxm96InDw5vqblULb
	XFa4dm9YsffDewHjryzJ1sSCUdFZLZ2sgnjvcvEO6ntUSDQuYzzvOM
X-Received: by 2002:a05:600c:a406:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488d6781cf5mr58945855e9.0.1775891693037;
        Sat, 11 Apr 2026 00:14:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:99d1:9089:a726:87e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm133193765e9.13.2026.04.11.00.14.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:14:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Fix wic tests image patch for 4th test
Date: Sat, 11 Apr 2026 08:14:50 +0100
Message-ID: <20260411071450.520161-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 07:14:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3690

This was incorrect after the recent wic changes, fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.json b/config.json
index c8df556..5cc7091 100644
--- a/config.json
+++ b/config.json
@@ -1074,9 +1074,9 @@
                      "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
                 ],
                 "EXTRACMDS" : [
-                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
-                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
-                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/"
+                    "oe-run-native wic-native wic create directdisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
+                    "oe-run-native wic-native wic create directdisk-gpt -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/",
+                    "oe-run-native wic-native wic create mkefidisk -e core-image-sato -o ${BUILDDIR}/tmp/deploy/wic_images/genericx86-64/directdisk/core-image-sato/ --vars ${BUILDDIR}/tmp/deploy/images/genericx86-64/"
                 ]
             }
         },

