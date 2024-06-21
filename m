Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E593C27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 12:13:00 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.71536.1718971970621707415
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 05:12:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=KC605qEP;
 spf=pass (domain: snapchat.com, ip: 209.85.208.177, mailfrom: ecordonnier@snapchat.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so5002641fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718971968; x=1719576768; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2admxA/Kdk7iMzmL3srZqmzMud3PefMibYneIsc5hY=;
        b=KC605qEP54UtOeBrz19J6xNSeZF5m1v6kwZro2iLNktUWfJpcv4EHq17nokWOUHN+R
         OZUj/ZABetKC64oNrV4uAB6mB0LKFjNx0S2BXSYUcaFX1nSvGbVkINpglH3LzKiZIc1J
         EeOnYRUBKRaG1wNMAktW40ICtEjG5vzXYpzAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971968; x=1719576768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2admxA/Kdk7iMzmL3srZqmzMud3PefMibYneIsc5hY=;
        b=uB6ZANk2zZooLDLe+RjNooDJSCiCO8vpO20pjKOC1ZJme77KdJixHfTGBZTN5oui0f
         Lx23zSq3/WK0Bf8FJ3upUo11pDKu/k/LWn104BbCGBRvGcdo0t9i9cPDF71z2cnWVLsT
         uaJedBhm7aPbqli+IMSVR/Ue9xCFhh1w9we3he0quhb11XbVJdk0dCjRIWaD4sI8E+NP
         tzkKfjrQRcdr5Sn/fFY/LDjuIPQuKC4BaiZ8bknbaHmJT02wp2DMferhLka4w8AASEUM
         C2Tat1UGLxQ1c2zV7Hufg5Sh5vn1nLokL6N9hHmpco5y2gU+VObuZRZiDeY2b6PwDiEe
         /xZw==
X-Gm-Message-State: AOJu0YzMxP2vkk6fVtgJZJdpSAG4QSn1ArccEtinjsm576lTjwSE65qa
	2FYfONeCGFsOkcEPpe3Or0BfbS9qo6EEjXeXVs1iCswOnZB/iBCYe5bn4Ms4zf2fAhSmaIP3t4U
	q/bQ=
X-Google-Smtp-Source: AGHT+IGhkhUfroGy0esm+ogMu/I8ApZP/ICkoqZLBJv9V80eECUut4LBlSuKEA/4NFsvpQCkMAu6pg==
X-Received: by 2002:a2e:8555:0:b0:2eb:df39:232b with SMTP id 38308e7fff4ca-2ec3ceb8e3bmr52809801fa.20.1718971968062;
        Fri, 21 Jun 2024 05:12:48 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305616f5sm863931a12.80.2024.06.21.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:12:47 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][PATCH 1/2] README: use simpler syntax to enable systemd
Date: Fri, 21 Jun 2024 14:12:38 +0200
Message-Id: <20240621121239.594152-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 12:13:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/362

From: Etienne Cordonnier <ecordonnier@snap.com>

The variable INIT_MANAGER was added in yocto version Zeus / 3.0 and makes the selection of systemd easier.
See https://git.yoctoproject.org/poky/commit/?id=7508711b3835cc7890d46fda1b4a1c3da196ec9a for details.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 README | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/README b/README
index 67708f7..ce91cc1 100644
--- a/README
+++ b/README
@@ -69,10 +69,7 @@ By default selinux enabled images coming up with "sysvinit" as init manager,
 we can use "systemd" as an init manager using below changes to local.conf
 
 * enable systemd as init manager changes to local.conf
-DISTRO_FEATURES:remove = " sysvinit"
-DISTRO_FEATURES:append = " systemd"
-VIRTUAL-RUNTIME_init_manager = "systemd"
-DISTRO_FEATURES_BACKFILL_CONSIDERED = ""
+INIT_MANAGER = "systemd"
 
 
 Enable labeling on first boot
-- 
2.36.1.vfs.0.0


