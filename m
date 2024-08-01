Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B1BC3DA64
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 03:05:13 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.59816.1722481511768151881
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 31 Jul 2024 20:05:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N5iX6uMW;
 spf=pass (domain: gmail.com, ip: 209.85.166.46, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f95052c2cso294545539f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 31 Jul 2024 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722481510; x=1723086310; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jml7MiP8QlXvsOHlWr+DI+dgu8R6kZHyT4stKMr1klg=;
        b=N5iX6uMWFuw0Q2ZND/d5UL/9eyVkK08LiPUKd8UlTbhNI+LpBG/iPCPiIi2kdpiIHD
         PnDCcviY+Fot80jJxmcefH6iSiDdX1POt1ZXky8ETtwTX2MYOSiU6MKeibK1FaSvgtDC
         +ibgQMXQLoiQsc6F4KOxygHjrOUQAsud9WcluMQvZGeWvfiPK4D3KmcoK2FjagyqsbFY
         BAaauI1a8BYpBqXjMqLYjgsFhKqkmsQA9QeZbUnzu7zVa3S/IzSB+Or9A4nRD5Jf4Ld/
         qnuUdfF0CnhrisxHtuJ0tQ18+l+fQ8VCz1VnAgTb5BObMyZk/KvwiAbEVUIZBBbNLAZL
         7Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722481510; x=1723086310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jml7MiP8QlXvsOHlWr+DI+dgu8R6kZHyT4stKMr1klg=;
        b=PDd3E1YK+rJRXOZ+zsmj+/NzMzrQ7qmR2ixxgLo4Vjuoadhvpe+Rg7s38DylOTbPyc
         Ox495cq6khdqx+lCyQeg3T+YPseGaM3ArNQtgeVIKy8+FQSkzEl5DM0gz8pZvbJGi1nh
         Mfud6U9qGetnV4cg/pqmpKHzZZxd6SRIlq/u868/V868pz1UEEOar3fI7lOvqD2V4omP
         EKNk4qlJWqLLJVuKohCze9obGXpiMzJH+gWnuiBNjbEYwkWQFOe5g2jLIt8gv8I4OcCW
         aXLxaQqSNcYnNAi+UTTeS5vWjubzMA9JhZLcpq/lebJsjvbe+J3tSHk4ceMH3r5vp2Rz
         yRmg==
X-Gm-Message-State: AOJu0YzaJmBaze0WHoxCUVin+0JadNMQRh4nEh67tqW7U6yQ9h/T4ZNa
	U8gpHbb0TjmnOTJwaS/n+ydUjH9Hzguui0GC2yUpDkoztUHsN2KXhgIPMw==
X-Google-Smtp-Source: AGHT+IG3k5R8wI6o/5l/NOqJ/F2nFKMCzVS77re3JKRnypyTwYA7jxW/bkOIchXvEn5VIjz5u8HJzw==
X-Received: by 2002:a05:6602:160a:b0:807:f0fb:1192 with SMTP id ca18e2360f4ac-81fcc0fd9c3mr152661739f.1.1722481510068;
        Wed, 31 Jul 2024 20:05:10 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa376ccsm3546468173.29.2024.07.31.20.05.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:05:09 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2] linux-torvalds-next: add rauc config
Date: Wed, 31 Jul 2024 23:05:06 -0400
Message-ID: <20240801030506.8626-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 03:05:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/502

The kernel needs a couple configuration tweaks in order to work with RAUC, and
the default upstream kernel recipes already have this built-in due to
meta-rauc. The non-upstream, one-off kernel required to support the Radxa Zero
3{e|w} boards (linux-torvalds-next) needs a similar tweak.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- use a different, more efficient, way to do the same thing without having to
  repeat (and keep in sync) the cfg itself
---
 .../recipes-kernel/linux/linux-torvalds-next_%.bbappend          | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend

diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
new file mode 100644
index 000000000000..6c75cb1338e7
--- /dev/null
+++ b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
@@ -0,0 +1 @@
+include ${@ 'recipes-kernel/linux/linux-yocto_rauc.inc' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}
-- 
2.44.0.478.g7774cfed6261


