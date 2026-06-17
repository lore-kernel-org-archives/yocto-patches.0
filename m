Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B4CD98ED
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 07:41:39 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10326.1781682092633277301
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 00:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iy2fYr9z;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490791a3e92so6318195e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781682091; x=1782286891; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJklKX2JSwUVsiaH92RMW5441IZMHs9edBy5IxBuHJQ=;
        b=iy2fYr9zPb7FDWyfoJXNvfuGqXOgRG7nNyTwzueVzmrVVXlEBJYbs5AliqGINrduA+
         TSrYlQbzkMTtxgU/Bopk9Hx3vGkEg+Bet3n+In0Gc2E2r8FKOG7p+FPhcsK5dppUfX2t
         yT99Sdm5dX09Xv/9Xa/DVVI0BbbyeBVCMqPqs6AWqq21r7lxi9IUvynqjja4V9qZm9ak
         LVhqL3DVdHpLtdrkY0aoFVrn0onGeojmsYCl2iOGwrJ4zcmQWaCbtUvAQPb+GmoBcsOY
         057UUYWKmyPs90tgPUBKL+QK7q93j95auxQzW5cAiA/mJFjlHmwunBK+4GXJSCttcJmr
         bzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781682091; x=1782286891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJklKX2JSwUVsiaH92RMW5441IZMHs9edBy5IxBuHJQ=;
        b=ByuFOpwtICd1t2u84JIyaXBbl/q4TvmFOtGmf+osO9if6Y+ghWHaQH+n8S/1EwpkZo
         wRojpdPbH5yqkQ81jI/DNiAIiuj6xMZ23vPLF46+z+0Y7Bjd6lRZkVEugn+snpbEdiUR
         FE4M2ixjGEnNr7iG7N4oKH8TLA0jsGIhdjc1oiMQIvv4Ya7s4c0y8HQY9NHzAbKPZsIu
         ah8G4pUH75fSCBrpeKGKG1Cq7MPI2bWYm1N/xt2sXo/YY0N4jhuYYKGwzIVvsQ/t5KUs
         Dr7WiGZzZGXzoPlEemfF2ffi6WbO3iqlvOve565KsuAmm1cb6VasLGXF96h+1i+A0scu
         FsEg==
X-Gm-Message-State: AOJu0YzyQ2OPqGhG/hnvSMYYMonM3+UlNUxjHsYId3vC0WBCB7pM09bS
	oqb/S2lcsty2ORaWsfUS4WZYnCsMeWlpj0wexMJY2QyPKCawRQZmTpX36WJdQ1mz
X-Gm-Gg: Acq92OGvr0qiGo5iAhIm0xFbKxDZFrnX9LGZ/797POEQpxLwDIQ/4xrm71hGh3h5fsV
	1hW1NosSJt5zFZ3UI8B0ziKA95dvSNo3pMv8CA8DYlzYFI3ksDH4W2yGOwwemlQ3YRrBMsPfT3+
	B7AwG8aoMCoBX4MG/YBS2EdQuj2wxoyV0IOe7TPZfERCYYGleARz4nq/3lUGdXygba9k+ulD+OZ
	Iz5G9CHtm7YIvmeAh2j7A8j7TSg5QuK1/QIiFPX4PbXrDbcd6qlBsp5w96n5zZxjSRKUQRrhlEV
	l5FiESqGXv64Q8cF/1ew8FGkb8ujAw8H/F7sl/9ohl0+eInRxGlvESWiO5PKp2qs98tRKpQ6pTc
	kCXlWF5whAnbkdSQDTms2Qmo4aJ7DwYUN+VENOTqvYDWbE5btSxNPYEoPHZYeIR8HOpbt0g9tjo
	re3P1WTP4u9HdrepTNIpSBZvweuCE3jMG80MvGmNgpYxcB9c2faU8iTM+D4cnyjg==
X-Received: by 2002:a05:600c:1392:b0:492:1eaa:a8ba with SMTP id 5b1f17b1804b1-492333e6c17mr17900625e9.6.1781682090519;
        Wed, 17 Jun 2026 00:41:30 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:6d55:4b21:7db4:207a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm54493925f8f.36.2026.06.17.00.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:41:29 -0700 (PDT)
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] bootimg_pcbios: fix typo in comment
Date: Wed, 17 Jun 2026 09:40:07 +0200
Message-ID: <20260617074007.2599873-1-gael.portay@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 07:41:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4230

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/plugins/source/bootimg_pcbios.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
index 2ae4eb1..f87c337 100644
--- a/src/wic/plugins/source/bootimg_pcbios.py
+++ b/src/wic/plugins/source/bootimg_pcbios.py
@@ -26,7 +26,7 @@ logger = logging.getLogger('wic')
 
 class BootimgPcbiosPlugin(SourcePlugin):
     """
-    Creates boot partition that is legacy BIOS firmare bootable with
+    Creates boot partition that is legacy BIOS firmware bootable with
     MBR/MSDOS as partition table format. Plugin will install caller
     selected bootloader directly to resulting wic image.
 
-- 
2.43.0


