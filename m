Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62CD3C92A
	for <webhook@archiver.kernel.org>; Sun, 20 Oct 2024 09:01:59 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.21587.1729414911170378493
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Oct 2024 02:01:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V2CctIzB;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: dixitparmar19@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20bb39d97d1so32498165ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Oct 2024 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729414910; x=1730019710; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEEYSK42wfhSjsurKYaYhK9G8WEGPtmXL884rTbhMWg=;
        b=V2CctIzB/qikxK1EOebGbdIwpRQvyNwsW/scoOfKqhpbL6b43v9WGP+A8n4h39EmIV
         BvRp9u5fyAV+HW9uc30cn6E+M9QCZrzYmVZrEMVN2pWLT3HfeXFxCtRHSE1xe4FYpgPS
         Dkb3dLQAxQ63HCgLgv9MFYSv8mJ5AgB5oumctM8E0uTJ4955bOTbhwMgWn9q82Lw0jiM
         tC8nWecTqa5yfQEfCX2MLTuu9sUseKyygoKKUUHyz5CJ/if2pVCJ8GuR4H17BjpJC/Et
         uMrWLHYKkchQKwfiW8gDLFhuixRBL/mtNah4Fiv1t54IM1sJ5a7EKDom0Tb+htZaYFV6
         i8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729414910; x=1730019710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEEYSK42wfhSjsurKYaYhK9G8WEGPtmXL884rTbhMWg=;
        b=VfPTKz1ulkekt+bMYPbHSPiE9zOt6vZehh/umtAYU3XGHE38VAEh6LpHpPJfV4HJbn
         t8hpMzkLYdx+ppNzUQgOtcXa2/tXe/bITIWlmGwgliChoDwiP9csB/553Yp+uUePr7TJ
         yWy0n+bQDoroZYtVB13zX6/uyLwPVGvvc4QAubzdXMv1Us+IrQ9pDoRPJlBuN+YCodEK
         PtrAVvkK1jxz0W7cVbXp9OyiE644wKapOj078Gy+T8XBH0IKyVWrFxK6nXVMQjnw+FIU
         PN8Nm23tOeVj6kG8Js00LZMQjkh0U63rMcSq9V8NPFihD/oiBsp+59tDyo7fvh61uKY5
         /xtA==
X-Gm-Message-State: AOJu0YwGW2tI/yMlHxSd4Sv4yrJTJ7V/ezb3y7fXDbfoU3NQZqEHJrtk
	wrJgnrbhRNuPNpWqJjJYEJRTA7a/gZ+5k9Ay2z1lT/Z33WVHOs/t4Tsl6w==
X-Google-Smtp-Source: AGHT+IFRnv2dpy/kcF8JqBd7QcbXxUisvjHw6qhGwwWJ3ASZixLl5Q8u7AQ4gJ9l5rFwhuBJZrZN2A==
X-Received: by 2002:a17:903:32cb:b0:20c:9da6:65af with SMTP id d9443c01a7336-20e5a9581d1mr115671685ad.57.1729414910197;
        Sun, 20 Oct 2024 02:01:50 -0700 (PDT)
Received: from dixit.. ([2401:4900:1c45:9bd8:a0fb:7820:67f4:49b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62dcsm7281055ad.27.2024.10.20.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 02:01:49 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [matchbox-panel-2 1/1] add mailing-list to README
Date: Sun, 20 Oct 2024 14:31:40 +0530
Message-ID: <20241020090140.451403-1-dixitparmar19@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 20 Oct 2024 09:01:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/720

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/README b/README
index 2e6e402..91eb547 100644
--- a/README
+++ b/README
@@ -1 +1,8 @@
 A simple GTK+ based panel for handheld devices.
+
+Where to Send Patches
+---------------------
+
+- Git repository: <https://git.yoctoproject.org/matchbox-panel-2>
+- Mailing list: yocto-patches@lists.yoctoproject.org
+	use --subject-prefix to put "matchbox-panel-2" in subject.
-- 
2.43.0


