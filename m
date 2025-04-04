Return-Path: <arena.lor@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50EC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 09:51:02 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7132.1743760252735489040
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Apr 2025 02:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CfkShhpZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: arena.lor@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so20458705e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743760251; x=1744365051; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SB6Hy+zuF01OFvBr75jiHNEvtHMZ7ChpC3lHshwfjXA=;
        b=CfkShhpZKdxgqsXnfbJoRMYS1+fUirE/Z8kX8XNMJLeMHL4KLK/tyHSY4KkrgaIB6t
         I3C51Jg4gzGBmx+Ij5ZivYvGSEMDy7gqvmpLX/gDu+t6MAUK6IFDw5jTz3d5Z/eCr4e1
         0zja6Ju5J9ALvviW9bXXw/FD2+zo3mz9a3eQclwHQimiMgDzytleqFujVWKt9TS5Ucq3
         fyKfK6PVnwuXmmTXxmaz9kR84j+3t0BshH8liv0jIVPS0jUwiGBQ4Y5W7+ZGcxq8Tn9D
         L8npcIaxdJULVIGcHa/M3RdYMyN8IhLWIvkHMbL6pIo8SxcS8/4X6hsOZVJlkVNqT0LX
         PL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743760251; x=1744365051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB6Hy+zuF01OFvBr75jiHNEvtHMZ7ChpC3lHshwfjXA=;
        b=NKSdQWkZmivotMHO2JxpHawWr3Id0pnKKjzvN5vHs530/K5uR/ms2N9GtxxWVwXwMx
         rUA95CZv6mgfgObg3d4gI3jYEsWp0BEhIOQavgDRWwUT4NXB1tYDCm3QLDcshjCSOvPC
         sHUQ6JOxcu4Icuq/rhMHnhikJOyZQcgoCvzjDFssYffqwNgBmLLh2pIu5VxWgdWqoRr6
         NGCK/98zP1tkU5APSmk1w+eTJHzgN92zblpsGhekMV52H68ttlVJj8hi3C6uZ4kzjcOp
         /EqPjmIQVCnYX1TwNIrtLAJxSTq0mrhOzoMVxdZfrEVXmoIq/+ioX92zWbLdoif/afPC
         wl7w==
X-Gm-Message-State: AOJu0Ywff+VlaSRj9af2JaLcVLxWnqCRSGnfGfVsGGzw7EcaD1GXZRBR
	o3xWCw2wVkgJkXw4d1IgAzvjAEP7tjYrJPuQEEN6m6ZFAJpuELExLEZwdg==
X-Gm-Gg: ASbGncvfgtbRV02zX4AND7qOQe+hkgsfa9guq0rpAuYzzhiV/ZWIwbc2R3In/d8YM+T
	W6Lyg+Y8wOIAHFbC1ygMCDSCNh+BJhwsZPhNWTiXJAouaSvhcGAHzBkbcGrmki2NRH4e8Di70QL
	o3rQYQWdnhN15NtWHf6AaTpW9tB2jlDN+YRAV/7vLsC8whWrVesXYO3lJJ+KbSPSFXW+mz14PXt
	vVQ93P/tu5S9GXwve0UzaolZdP6kCSaw/qHx6CHaqt/wVqAwsPLzUNHTOvqQAdpL4TwP7PNFupi
	+B5E2iLyGZcR/+9zkcetN/7ZskBc1pruabns+Ri0SeOhi9/4ijGJ6g8gLTB5stS4iBK64coBypo
	CbP6giMRO6KPld7CKNeIUfoGnlbbPmCe+qWFXoFTx
X-Google-Smtp-Source: AGHT+IEFm3brb6kgy4R4Va/k8/en2XG0uHio8V97PS6aAqHAStG2ZHeWohS+y6T8Rq3+LpQ3G2lOKg==
X-Received: by 2002:a05:6000:2287:b0:39c:266b:feec with SMTP id ffacd0b85a97d-39cb35aec8dmr2388947f8f.7.1743760250770;
        Fri, 04 Apr 2025 02:50:50 -0700 (PDT)
Received: from larena-Precision-3680.powersoft.it (host-5-99-65-66.business.telecomitalia.it. [5.99.65.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301ba3c4sm4012421f8f.59.2025.04.04.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 02:50:50 -0700 (PDT)
From: Lorenzo Arena <arena.lor@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Lorenzo Arena <arena.lor@gmail.com>,
	Armin Kuster <akuster808@gmail.com>
Subject: [meta-security][PATCH] dm-verity-img.bbclass: set sparse as "never" during initial file copy
Date: Fri,  4 Apr 2025 11:49:52 +0200
Message-ID: <20250404094952.2952778-1-arena.lor@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 09:51:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1280

This is needed when a verity image is used in conjunction with tools
like a WIC and a bmap file, as avoiding writing "sparse" sectors
can result in errors in the signature verification.

Signed-off-by: Lorenzo Arena <arena.lor@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 classes/dm-verity-img.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 7f79548..df9c278 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -143,7 +143,7 @@ verity_setup() {
         HASH_OFFSET="--hash-offset="$SIZE
     fi
 
-    cp -a $INPUT $OUTPUT
+    cp -a --sparse=never $INPUT $OUTPUT
 
     SETUP_ARGS=" \
         --data-block-size=${DM_VERITY_IMAGE_DATA_BLOCK_SIZE} \
-- 
2.43.0


