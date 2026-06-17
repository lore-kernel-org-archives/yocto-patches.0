Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7FCD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 13:30:24 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15634.1781703019455741444
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 06:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PHOmGuKo;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-462adf21308so40800f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781703017; x=1782307817; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZljgTUMUowDTx0NTPxk6XRh7cUakyJJ2FYKkOxbOtfs=;
        b=PHOmGuKoAHxWnBPc1hZ59nt05ZwQ3Xor6qde0jfOZKXLRUjpwslz5Aexas6nL8LAzZ
         74+nd2f6T/+hvjIke5W7Kd0Pje9tZ7bMubJcwWVbz73wDmy2m3kEoDeutU26o9kMnC2K
         nI3ZX2/zfCGy1908E83bpb7quObTdWP49942krs8gTjL33cgIag7nz9NjT0EQSwHkkoE
         borG1+s78IS65MgMIUjcaRThF17QLymDD/eWuFycivKshnstAzZU3I6L724XoZzMVeH6
         mvwoylSxfRJL2g2/Jo6+wZkrzLVRrfpucQJnCZAP5Y7t18KkmuUhiGP8CgE1paZZ/w6Y
         fibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703017; x=1782307817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZljgTUMUowDTx0NTPxk6XRh7cUakyJJ2FYKkOxbOtfs=;
        b=I2c7Q8g3gU5EaZf1UX463ISQHrQU2dVAyZJ9Y8CdTfPWtAPg+hmmqj0oKtgU8vsVNG
         xutR9BZ3Bopq0SWdUd/tq9Q/EcB87J0jtR5Y2rZmjUZXKrORdCMGbya4LOSB8KUH1plo
         OnAogPNHD7D1+kn2YmVrg8VYcnQgcMKwolxgy4RsqDwgCXzkrabbr9Ak00HG+PN4MYc5
         U6DnXIo0pV4hxlZPV55aNIr2LkU4Ri0uTOyS6Y2TE3Ev8lMzQH8Fb/8DXZ1DVOAhFQ4V
         /xIpKO9PAa/GCTrWEKrTfhiFSp18uQzuRYJJ6z8E1wot1uc80KHs9I3XmgIouTC12H33
         RtvA==
X-Gm-Message-State: AOJu0Yy6TcG6uVRM+URZYE9R7vf1NsMARQnWW/HzodPdFEIdVgPwSFly
	U1pWWX0mTxcZKWQNhFRhp3GxZLCrLoy3DMZIEvKDAR8wOVrML+49emmbmj4I/JX4
X-Gm-Gg: Acq92OH2Bv2S6+kq2wlWZ6vFkXsxbBoMqpdSYWJ2IqtEg5gURU8lLo0f63hfiZwNO+m
	+j71KfC5vxx63nsF7tL6so3cg96zU6Mo3GibSWW8VoZHreKz7hFKK23DHs04Y7cQIaRiTqR9n6N
	efNc95AcS/WZWPXphpSSvjOWOVf5916ZRG6fCxt7uVHA6wsTHt2R30NgqAMC6/dQrX6k+2zrHVg
	VNPqvYrBGfp5mvZxZCgBBbnYwkT7iizWfo4DSwFgsValHdJniiMU1h/yOfaRbxqGDIm0mL09+05
	2WbVIJBGsgqClxc/2eObWjjRt5eZO16HNr92hvsLjopc77UiPOsZtL0IvO81eZI746AJ+YeghEV
	AIZSwyi1hLJR2M7ollWKWdvUT4kwsGMGziOj2n1QsrZKCeevnXT1pN98DHlHHqagQr7pY5AFcJe
	3ehMjISh4KZd7YwQGt7R11U2/XeBybtInXiwzEeME00u7O1yfl0rhmOjl3vDo=
X-Received: by 2002:a05:600c:c0d9:b0:490:ec79:3063 with SMTP id 5b1f17b1804b1-492333e13eemr20625265e9.3.1781703016732;
        Wed, 17 Jun 2026 06:30:16 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:9d74:8833:3c05:bedc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f264333sm56120563f8f.4.2026.06.17.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:30:16 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] wic: Update after plugin name changes once again
Date: Wed, 17 Jun 2026 15:29:55 +0200
Message-ID: <20260617132955.2607392-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 13:30:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4232

Update the plugin names to account for the "-" to "_" plugin name change.

See commit 78a3c516077 ("wic: Update after plugin name changes")

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/help.py b/src/wic/help.py
index 5d7c404..7bc9d70 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -817,7 +817,7 @@ DESCRIPTION
       # long-description: Creates a partitioned EFI disk image that the user
       # can directly dd to boot media.
 
-      part /boot --source bootimg-efi --ondisk sda --fstype=efi --active
+      part /boot --source bootimg_efi --ondisk sda --fstype=efi --active
 
       part / --source rootfs --ondisk sda --fstype=ext3 --label platform
 
-- 
2.43.0


