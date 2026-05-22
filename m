Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E2CD5BB1
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 12:32:30 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15072.1779449649817168516
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 22 May 2026 04:34:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iv54kcQf;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: aleksandar.nikolic010@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bcd0111ea98so1063025866b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 22 May 2026 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449648; x=1780054448; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZafoTtcN+oRsHXiWNMTGjD3Jdxnj/jbxgyECLs18plE=;
        b=iv54kcQfF8VXJX1Mf9utr6vJh2KFOJqcmXN8QTBWEr7w6fmAAvUBc276qdRP6vkrvN
         tmuiLiCVSQJvVs6ebHxtiXGwPGz4HW1xmYKcnCAQFlXQ0CE6QedSF4bhFxAEI3QH95iU
         S1eZ1m047TgH00LQcs/e1YN1f4LFaTn+OP7IO9MovqX2CPCakHEcLZowFZVnS3Jv0oSg
         prhmD32fpBhVKomLs1heVcw4OwceocIrg+S7Mo3GQSgGKNjigh9fMprJKgSQr1ppmIYI
         i63ZjpvWn3ueSQN/QIeGoHKNnZ8AYJzX47FagIcOiWbCyPM//iLzFGMzAvYh5a/lmWKd
         u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449648; x=1780054448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZafoTtcN+oRsHXiWNMTGjD3Jdxnj/jbxgyECLs18plE=;
        b=ha8GLoOuX2ZaYlRmGlU7FzuxksCzZtYcE2etx9eUBk9Ye3hHCMGIiJ36PRx6DpJWcd
         NaY0Mczzooq4mjuV3zSzzUmZ8TmZ/HQXAfkswrymQbMJsf6uuiUIajMpjvgEyWeSlni4
         4XgYMgZjPjALaXADNEWWCXYvisKkYpLN0k4gw/wjT8L0lUp571GfwjiyfmSA/2FchFj3
         i/U7uIOEpZCUYvbwHzYxCPLb96DAZuGvDfH8mojw4iKVthEKqvcxblPj7QDJAMFvBeOL
         2AzQ0xFuzxMZU6JHIzSyTxGJJZW3cx5evkbUw6g/EqFLv5EiJj6yd7/A/kxnpUZSGqz/
         U6cg==
X-Gm-Message-State: AOJu0YwK4LAP9CmG/7c3me+5oBqynrl+YZt08KRbsZVNO7fEHzeIRy2q
	rMjB+mwfzMA4v1VFc0f7iCkCUUB1opFM5w6ny5mgnkhpLAr5V52xZ1rMiBWGHQ==
X-Gm-Gg: Acq92OFC++GOdPKlf3UUT53vwWr/a3dgseg+akVsUgaCO1AuvLzYdlbaw4iBx2BOdCT
	Y5O8zrwLYJagCW/EBjNJ3wKT8AmJdIxI2s/mseIBg7nHbKMm4SqMk6iYk5XIL1Fa4/Yi2TLu8dI
	ZbZlUWTw6zA/9V/7g6nPDdJDA+zCSYgtiuWRhOT5pD4MHKZoPJEwdGUdQgXccpqoB38J6OMeUWV
	Xy4NFdFDcHyogv0PboRbEk89eK839+sBG8AzlWSRbtj4W6/mmZ3XbjogV31Vbnw51uGf+RP+I9T
	ovdPA34nqaxObaXBtji4pOWyGcmHojDR1JabGBdoNRkDfLU/6xJuAA2C6rZwd2WWWBwDcNYnb8A
	y4ONf3tkvibEUSesc/KKpEXPdOL0O4iVJrEiInWiUWi3i2IlWGEEPuBYpzePgREQqUABM1bpdrl
	e90xR/rfnQJlht6JFR8avDm+gQCmPTY8NWO0UbaZ7cDMEX7S8=
X-Received: by 2002:a17:907:ca84:b0:bd8:c9f5:8422 with SMTP id a640c23a62f3a-bdd28b76784mr204795266b.18.1779449647773;
        Fri, 22 May 2026 04:34:07 -0700 (PDT)
Received: from acert-swift3.. ([2a02:810d:60a:2b00:c68:3233:6f5a:58be])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eca616sm45270566b.30.2026.05.22.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:34:07 -0700 (PDT)
From: "Aleksandar Nikolic" <aleksandar.nikolic010@gmail.com>
X-Google-Original-From: Aleksandar Nikolic <aleksandar.nikolic22@pm.me>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
Subject: [wic][PATCH] wic: Fix updating fstab for nvme devices
Date: Fri, 22 May 2026 13:34:00 +0200
Message-ID: <20260522113400.192786-1-aleksandar.nikolic22@pm.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 22 May 2026 12:32:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4005

From: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>

In case wks file references nvme, update_fstab() function will not add
prefix 'p' before the partition number, as the if condition only takes
mmcblk into consideration.

In case of nvme0n1 this leads that following entries are added to fstab:

    /dev/nvme0n11
    /dev/nvme0n13

instead of:

    /dev/nvme0n1p1
    /dev/nvme0n1p3

The patch fixes this as it extends the if condition and adds prefix 'p' for
both mmcblk and nvme.

Signed-off-by: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
---
 src/wic/plugins/imager/direct.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
index 832d0e6..38a675e 100644
--- a/src/wic/plugins/imager/direct.py
+++ b/src/wic/plugins/imager/direct.py
@@ -134,8 +134,8 @@ class DirectPlugin(ImagerPlugin):
             elif part.use_label:
                 device_name = "LABEL=%s" % part.label
             else:
-                # mmc device partitions are named mmcblk0p1, mmcblk0p2..
-                prefix = 'p' if  part.disk.startswith('mmcblk') else ''
+                # mmc and nvme device partitions start with prefix 'p'
+                prefix = 'p' if  part.disk.startswith(('mmcblk', 'nvme')) else ''
                 device_name = "/dev/%s%s%d" % (part.disk, prefix, part.realnum)
 
             opts = part.fsopts if part.fsopts else "defaults"
-- 
2.43.0


