Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817BCCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 09:49:06 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11082.1762422540967040258
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Nov 2025 01:49:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XPF0Yu31;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so145942066b.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422539; x=1763027339; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q68OBHXATXs6JYULyeAqBggXMk1qQlyiw391ZYsUC7o=;
        b=XPF0Yu31yK2INDxlppbJwOWtYVJHB3WhelKnhKkGWA0cBafmFVX77efU0VGXo2j9/s
         WAIbAIambTjGGT3l8EaQybALqTkEzLgUY+xL3OjpSu6rKGPEQF3rmBY5BlU7TbpzBPeC
         ch8GYW0NyNXULFNFKcJzwo65hwK/bTa1VbbTJ3kFvHWhyn4sErwnfjkbWU+5uaBpPZlH
         qHpOBqoEvJqnj3OrDSVYIeFr05w9wYTOtZb36eOTiepl0CLiaJClIh1Qmdq4TlXbM7cK
         GCMGTZBkEi98hnyurmkDjUu4gcthM/sIAUBctgn5SNYLdLytMtL+qAkHRxO7TH1Rcivt
         nrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422539; x=1763027339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q68OBHXATXs6JYULyeAqBggXMk1qQlyiw391ZYsUC7o=;
        b=iASH53995SjFLr/l3BHHrGjWkQqKM1FyKwscV1BnJ9PQ5np7Vxsi5BhJbtZujQtht3
         X+lQQL6O4QcI01HGG24v1Xed25Fk6fkMhyN38hwx4Uts7o1v0TPnmogcaN58+iYPkeGM
         Q1RLLQXLG9M59n5e4rpVmu+RaS7hvB9E4EMtXQ2NfRg424soVBPVWuyBidABwprrzBl8
         OS6AtsAujVpbqCJqmY5y8IOF+bwO5sIHQBtwALx0X31/AzHJIeFr5CeO1JsufvTfTJA5
         y00e45yC0y2+jC2KSyJuBI9hjmGGlsJZZVelevXHT13Z4LX5RggRcZsHk6veQR+QkkwP
         4e6g==
X-Gm-Message-State: AOJu0YyhQ+shC1Z0pU7sP4EUOARdbSt3sYpKNFz4MpfAwSmmX2PiLrUK
	e+s3R38LRVpNYwo96+h3z7RzcW7ngBIj7n9ND2j34Tk051dy9qVUnycLf5lxKA==
X-Gm-Gg: ASbGncuAzAI83PGx2FLdLT3qJC4m0GjSGJTHArXOMuRd0asNoHA5xA4i/vrHnJ+w/nJ
	X1Y22I/If56k/BXklZd/nR8y28iY1F8ZDCX4rj7SYbeXUgsua2Nduc6JfyBjITHUkIsSNacEUUR
	RhQ99BDuVIL3oe/a480tvxqk5r0z9AkH5CgpmS2K2fLUm2BxeuGMOCXQysFDO13S3zTziCqsqoZ
	C2/KRDZtERlwdTzqh7czRsrVSND0cgnRbNuniimG0DZQHwHs+WV+AVw/PnAiMk1aLoN57y6aPmx
	P9GDwCCaoASREJ3ono/ZjtZd6HrNuCN8qFuEkVQ6tSnVZ3npdcyQzX2HONEsgNvsF0KdHcNS4F9
	ulKXbuf+qRpobVMnREI0qTYgmG8kbEiHuDAo1dkvnZbX8X6fIiFO/sDkdaAevVE1WAaUfrl4rei
	hvCtbq3MxsTh8BFTRbs4u4Jg5zA2zzkd0wCMiuAAZu7hXs/KIP
X-Google-Smtp-Source: AGHT+IFyM6hMkscjNBPd4LSMpW7Th3JticZQvtLGlH/tIIo6BO1XFu3FOs7IEK2Klm5kNExw+ZeogA==
X-Received: by 2002:a17:907:7e92:b0:b04:6546:345a with SMTP id a640c23a62f3a-b72655cdfa1mr640359066b.52.1762422539095;
        Thu, 06 Nov 2025 01:48:59 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de (vpn23a.hotsplots.net. [176.74.57.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334288sm175757466b.15.2025.11.06.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:48:58 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json: correct AUH job to match the new bitbake-setup based layer layout
Date: Thu,  6 Nov 2025 10:48:54 +0100
Message-ID: <20251106094854.259875-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 09:49:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2424

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.json b/config.json
index 100de3a..f65563b 100644
--- a/config.json
+++ b/config.json
@@ -1532,10 +1532,10 @@
             "step1" : {
                 "shortname" : "setup AUH",
                 "EXTRAPLAINCMDS" : [
-                    "git config user.email auh@yoctoproject.org",
-                    "git config user.name 'Auto Upgrade Helper'",
-                    "git switch -C tmp-auh-upgrades HEAD",
-                    "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./build/upgrade-helper/upgrade-helper.conf"
+                    "git -C ../layers/openembedded-core config user.email auh@yoctoproject.org",
+                    "git -C ../layers/openembedded-core config user.name 'Auto Upgrade Helper'",
+                    "git -C ../layers/openembedded-core switch -C tmp-auh-upgrades HEAD",
+                    "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./upgrade-helper/upgrade-helper.conf"
                 ]
             },
             "step2" : {
-- 
2.47.2


