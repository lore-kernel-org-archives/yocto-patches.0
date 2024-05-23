Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347F8C25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 09:20:50 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.11204.1716456046936765858
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 02:20:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=aIl6SNQp;
 spf=pass (domain: snapchat.com, ip: 209.85.218.52, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so977351766b.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1716456045; x=1717060845; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYCiN2ufYlyY4El2Vw9gtmQ2bVLC/ryJQsJBPBN6DBo=;
        b=aIl6SNQp8/fsjPd7SXYkfrpfgj4Pa38hAgir5iIoLWqRGOZaQcuEHyuiCeUlhrNFxy
         6/LiV9x2zc5NiEwBsaGhTry74RZ2aMt5VwLFpJ3f1BhLdhU7EpdqpS55OWitexeaOa0d
         RsFKV8ReemQv8CzMSBoamVSYhvl4mSIPd9FcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456045; x=1717060845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYCiN2ufYlyY4El2Vw9gtmQ2bVLC/ryJQsJBPBN6DBo=;
        b=Bsx/1rx0aqaAiDLZNA8GeW2/gz0we3JFdl54it5jlXhQM82MSFWHyndYLcUrNy0Uko
         Da1CKQjZkqLpBK/G7jPhdjlofyx6N35nd0I/SmfDWPosY4PUMI806U2ajnRUrVjUulxw
         uHG/DWXCcbH0rJd0P/fOKpD7L7UnwNDP2pFPBy6BN66HhGVtuMOMnoqKHOvxIo9WlBMW
         Y0oLgljtrEEE1F5nT7aqxuwxA7YwjDfwOxGEZxdNlJ+UL+kZFl44V3ReRCIL68I6USdP
         9lyCnytW4cPIRTlRZY0Gl0oLgGa73XUD8+/qzg+7sJxRM2ZmhmG5u3kMeKNt+039MSuf
         0yzw==
X-Gm-Message-State: AOJu0Yx1HgfkNFEgiC0NpKya2gHcQV1tvojdqHS34+jRyhxT/fEjQVRq
	dA4z5AEYTuBjWaTZlk21PCUu2El0RSAqhYhs8w2PA46MWx6LAoXwKBM0dqdnnJUfL8KxRCAIhqT
	Arig=
X-Google-Smtp-Source: AGHT+IHiCisSsoEoQYvFzFcFslke+u9U01sDGvxtfP//EI0NeDTV7lTv5wIIDdn9IYATm14r+lOAKQ==
X-Received: by 2002:a17:906:b755:b0:a59:c941:e5e5 with SMTP id a640c23a62f3a-a6228134dedmr370011766b.45.1716456044542;
        Thu, 23 May 2024 02:20:44 -0700 (PDT)
Received: from LC49NTQ3.sc-core.net (62-178-121-202.cable.dynamic.surfer.at. [62.178.121.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm1053476366b.67.2024.05.23.02.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:20:44 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][PATCH] MAINTAINERS: fix description of section entries
Date: Thu, 23 May 2024 11:20:37 +0200
Message-Id: <20240523092037.239962-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 09:20:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/175

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 016f325..42a85e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17,8 +17,8 @@ Descriptions of section entries:
 	M: Mail patches to: FullName <address@domain>
 	F: Files and directories with wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
-	   F:	recipes-devtools/	all files in and below meta-crownbay
-	   F:	recipes-selinux/*	all files in meta-crownbay, but not below
+	   F:	recipes-devtools/	all files in and below recipes-devtools
+	   F:	recipes-selinux/*	all files in recipes-selinux, but not below
 	   One pattern per line.  Multiple F: lines acceptable.
 
 Please keep this list in alphabetical order.
-- 
2.34.1


