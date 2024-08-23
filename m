Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2396C52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 13:14:52 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.15784.1724418884750153150
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 06:14:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=javJ0m/2;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202508cb8ebso13968975ad.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724418884; x=1725023684; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIiq6dw9P6K91eDkzQNJ7Xb8mDwuedEBSapQHPLZkFw=;
        b=javJ0m/2qJbVMGIMBMpwa9y1qSG5pOHG/nCoqeQhbi5LzB+Gm9gKQgthT2YSwfBcwv
         FkhnIyFMaQ5Y2gum+AZG7xNZ1aZLSv6a6eF/NJPxPl1lCBHqf14vxX/Jj616cyTjvH++
         lsQjzzc1kiC02rG1MOV8R43s5LW1xellUMOczntyVFBIaKrWGxua7s/GVj5XzzyZIKPM
         JrQpryh1U8W7AkK1GCm7E7asgaWyzwzMX/06yBzOR8U3avTfuWLmu9JA09A1Yifnr4Ci
         Awn8/Lx/Ol+6ozg0d1wZ7Tcz2PIsi9cc4SyuzCq2pQh6rqcsGgfKRAj9fq0/+ZJxPVDG
         +Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418884; x=1725023684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIiq6dw9P6K91eDkzQNJ7Xb8mDwuedEBSapQHPLZkFw=;
        b=geV/77x46y6C9TACNfKX18UsO7kSON/qiq75LDgwonupuPN4tnXEnmXZZb3tBv2NFw
         FL3PmXwFKvboNfxtL+ub09LbNj6VjTc3onvvRq02C0K/qs4F4Ys5tv/uX35VPt9wMuTj
         BGakIE3oUBGDGFZe1QXUg4IF9aNC2+iXfV7z0bjAxtGgKR1GT36XgtKPHdwQObhynci6
         DX7IItNiWRjYcepVPe6u7ip1INK4FUf3OZ2Dj41viYVmtrEAPRq6yQTTAN5wcfrvZ4mJ
         8v/RoLFkzIpr9wmW4XN6lunOlRhllXSeJ5dT77ISWlL99XUUGHnSkM6TTbRUgcvbgJ45
         QjAQ==
X-Gm-Message-State: AOJu0YzpFEdyEhYu/hDthvYuYwpHwzEibMSCYCYEd7heDHn15h8qMy9U
	66vzlLthFrVaAr5/BhCTvQvR0Ab5IYrD6LqqN/owBK7jsBcaePKQXGIjlw==
X-Google-Smtp-Source: AGHT+IGqooQRho6/LaRuyKc5VgXUYLr9TbMT2UbPHdug20PkaYazAVgvkQ0Gulq6ArjrPh1iZUnVlw==
X-Received: by 2002:a17:902:e801:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-2039e5598c7mr25665175ad.50.1724418883866;
        Fri, 23 Aug 2024 06:14:43 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::77e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcf525sm28082695ad.300.2024.08.23.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:14:43 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Khem Raj <raj.khem@gmail.com>
Subject: [meta-rockchip] [PATCH] mesa: Rename bbappend to match oe-core
Date: Fri, 23 Aug 2024 06:14:38 -0700
Message-ID: <20240823131438.1539692-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 13:14:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/554

OE-core dropped _git from mesa recipe name

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} (100%)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa.bbappend
similarity index 100%
rename from recipes-graphics/mesa/mesa_%.bbappend
rename to recipes-graphics/mesa/mesa.bbappend

