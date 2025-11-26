Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB2D10393
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 08:38:44 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9183.1764146318378000823
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Nov 2025 00:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g2JNvI3V;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so9009881a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Nov 2025 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146317; x=1764751117; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rhy6hWv5D0sDFebQ+Bi/pT4Eo2aAJ6M+vnccTl/nNY=;
        b=g2JNvI3VgA9aYTuCJyV1stqy6GzGDyOXIhRnbZcqG7I2++sie+Ay17hUVeV2zQ7JOb
         E3m7zUKEwrgM3CriwYAhMGv6T3W30tsrp86zrjWZbsTKtuhjn+IPAzOhST87cZSuU1Fi
         0VlfZXOv0BMDGt5NQWkY59QlildoQl77y3wo1XdME0f3jKpARhwuV6tkRZupMMJC/cSF
         VaHOZYZKZ32BRPEgY3mm96ACQMS6lsVTOCbWGKK6X8katVtyiGgdHsHJVVfafKCbPmd/
         8StYrBUwDoRnueMqrwvnxSORXKJYB19ftAyTcLbd6RVs9wkg69HAzwUW/jmPUNfJIOfd
         Xsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146317; x=1764751117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rhy6hWv5D0sDFebQ+Bi/pT4Eo2aAJ6M+vnccTl/nNY=;
        b=fu/tFWm+HOUCdQ0X7rPMDd9NaKFN/472tTgiyrVRrQjYUcqt8Q9nsCi5r3vTTlBAkH
         QsY7+1R11d9ivmeFdPovclR0TuHenxXRnfAf9YofVSITzcRGdRhngbYZEPluU2zbf+Er
         ng6CJaDtcrhziX6l29aPInkupBlZyEd7qnrHZGdDkScyiekkx5a1mLDpOeDeBgoA7IGX
         YzdkJy471T6AbxPndXRcTcn6URwww/2EYNj+iLMk5YVc1hjqLVTxHZ4jtiyobMRkdw++
         SYO9rkxLyL5+wVNWeO3O4tch5k3ZW2RBc/frKeU+rk7NKTM/Mp+YpF2wFXLFBC8kKq1o
         rofA==
X-Gm-Message-State: AOJu0YwAY65CPzdgyVWSl9n0oCBCZacbn+Tq6CrBG6NXwb8ZbuQGqFES
	vWBdcMTzQM7euGcY9HvlXhvJecuUDdfeflbuJPbbpF4WAhGHNRBV6ZRlQlR81g==
X-Gm-Gg: ASbGncsCABCmG/sW6L7frJ/WIEDJ3zEGhluZaPfvT44Wc9sDIS2leRnf2V5olhCQueZ
	Hq47UpxHeAVEPTJoARh4+ThitlosG2oxO8HUt84YaM/M0+8PYdR78ucPdJPG8uyp2IrfzBcUTOX
	W5s9M89QjumoWFDVDGeBheQqbuHPPfd3omarL5+dqIetftBVsqW0JLhZAkoxfkzTt3xLnGRYRF+
	Abyb0/vcmC1WExHvTfXlEchCcgAdX/RjqOpDm4FzbbLs5Iyer/9c8Tpz/S0Ff7EzEfC2+AHxdGJ
	klCqemNyTxYiP5ujvTUgjEFya+czRQ/67ZRzv6AtGJ2GJWq2arTGirRy1Dh166Sikv4Aw15OaJ8
	F0+81wY0b7z1fJwAg8BVjdyoEpERzk8kuTv0F2ncNBcVLMo0brkpX0bbxaImlk190CYqiY0swoU
	iIz01kffB8irk7MLhtmW/jrB4Zu/Eb6UxKyfgN5mnOaQ/i+y5oBMY=
X-Google-Smtp-Source: AGHT+IE3fogzuKb6rIcV5qBQUXE7A1uuZPpqYs6EIsQarvabL+JRkBAW4Z7mSSd4CUTY3Q5y2uyyOw==
X-Received: by 2002:a05:6402:2689:b0:640:95fc:2fcb with SMTP id 4fb4d7f45d1cf-64554459225mr18184286a12.12.1764146316511;
        Wed, 26 Nov 2025 00:38:36 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645364437b2sm16963842a12.25.2025.11.26.00.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:38:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] commit.json: account for oe-nodistro -> oe-nodistro-master rename
Date: Wed, 26 Nov 2025 09:38:32 +0100
Message-ID: <20251126083832.1828092-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Nov 2025 08:38:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2711

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index d9f14e0..db58c18 100644
--- a/config.json
+++ b/config.json
@@ -493,7 +493,7 @@
             "NEEDREPOS" : ["bitbake"],
             "MACHINE" : "qemuarm",
             "DISTRO" : "",
-            "BBSETUP_CONFIG" : ["oe-nodistro", "nodistro"],
+            "BBSETUP_CONFIG" : ["oe-nodistro-master", "nodistro"],
             "extravars" : [
                 "INHERIT += 'uninative'",
                 "require conf/distro/include/yocto-uninative.inc",
-- 
2.47.2


