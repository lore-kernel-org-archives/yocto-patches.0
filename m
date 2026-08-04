Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B1C55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 15:29:08 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19226.1785857344458050479
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 08:29:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aVIQJnIQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ab70b882c5so2721104b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785857343; x=1786462143; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ym50oAe+hEDK/T5OUHylRw2ku0e5Y2PxGQvXMzEhqjo=;
        b=aVIQJnIQ9JIbZBby+JXxl6zLkM/A8PammwP+IAQTaSPn0oJkcLglrbvU8AUsf1NaPE
         6G3FsqvIYtGC1GE3yHnZniLCCUAmyYtWSoshJb75stJWF+I51fFFSPlAZAzXwpKHt5JY
         +0mcFhUqgQXAfoaSlvxSg18MD1Lf3yeaKMglDIZpU/ropkceoWwOw8rbIi2sLuoMEaWA
         kweuY4uXb2lTJTRi2hHu1MHgB6nVs4664GeXimrEmEBJGek54VKWbKrE/+8FIobdsMuL
         JaX+4zV2oDSLFTsfs1aqDvJTZg4W/13TdcPMHK2KCGFOaB/8BEdl2RsTGmsLqQoefDWU
         o8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857343; x=1786462143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ym50oAe+hEDK/T5OUHylRw2ku0e5Y2PxGQvXMzEhqjo=;
        b=Ly7QnHPxg334/pzye8IH0lBj6P9dRX0F9hv+nLI04lTP05U+xLD393bZsGwQlV2up3
         fm+Bq2mwZHUZ4KBCZvEZVNrNzuNXF1TcBADQOuBac5/GEeh72OqM5W3ZJvkXOeLrg2nF
         lLJ4i42RZuFWQ4Qpwx+St+lKSlPwBGfs099b2XMlVFMvb+8jJ3Bn5aaMm16w0algsgZ7
         dnxWXsMhWAH9OI6NTzbst08L0kXsfVKs8SfIm+K2EscNm5p2Ux/q+PJP0V+ZwlClsx3E
         wZdVqCly0dphV6u3S9vVvfiu2b1HMfOReYMnldMsCUxdq/597R06yiqDatkXLCgqGG8i
         VI2Q==
X-Gm-Message-State: AOJu0Yx+fL6efBEwlNeE04wTZEzpCteS7RWyzwPMwLwPwMm6lNxyRV+L
	6ikk/Hf0oQHgcXGv7rj8D8GuaY1s+3yNeIYPWSA6GwPnLCE0YhFrrkKukKL97w==
X-Gm-Gg: AR+sD13SCPlQBMzgA2zV/Bvm2FZ/iSC2IqTy24NcvGEXeOaLW94DPKXkPQADXnExkBI
	FWrZphpItDaIEa/Am5Kf3+3vJb4RO69QYX3oYyJ9zICkULIFzRcb3XZ97PVa9JoLVioF+GLiWFk
	+Xc5r76J038DT25tzQpH7Npki/2dKaHXayEoK50LLskqDtk45LPcPNNzy8xjP9htie+gmkUKeEs
	cot2gMuf5pfHzpPsC7MgHsXTZR8F0Qw4hbaYAgEJNebwCxa4Z/swHRWpC1pgW5+8xUS09pLjhgG
	gh9oae59WHGWuRXYrZUVVw1dwLw+fZpstPz8V7BprpaB3Zqrd+5rSAh0mPDvU3K/BjuP7lEq8i2
	o97FHtaUrUXcMLAedXnGONuLxO6sdvmy1UQ4OpdbZzdEi0AP1jtLdqCmS+p+ezpdwCJEIFAKIg1
	BN++QwIba6z0l7fXysK349xL3kdf9SB9eIIpFu0OLOAgY=
X-Received: by 2002:a05:6808:1b8f:b0:497:d1e7:5e90 with SMTP id 5614622812f47-4af5e2927e6mr22633506b6e.18.1785857338727;
        Tue, 04 Aug 2026 08:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::2351])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58f22c54sm8703324b6e.13.2026.08.04.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:28:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] re2: Fix append
Date: Tue,  4 Aug 2026 09:28:48 -0600
Message-ID: <20260804152848.928489-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 15:29:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4621

The append needs a space prefixed to apply correctly

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../openembedded-layer/recipes-support/re2/re2_%.bbappend       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
index 16bb5a0..a72496d 100644
--- a/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
+++ b/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
@@ -1,2 +1,2 @@
 EXTRA_OECMAKE:remove:mingw32 = "-DBUILD_SHARED_LIBS=ON"
-EXTRA_OECMAKE:append:mingw32 = "-DBUILD_SHARED_LIBS=OFF"
+EXTRA_OECMAKE:append:mingw32 = " -DBUILD_SHARED_LIBS=OFF"
-- 
2.54.0


