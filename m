Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D60CD5BD5
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:18 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7308.1779625697866212225
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fj7fz0TQ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90caad2e944so913302485a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625697; x=1780230497; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyAR8EnaSZyrhUSKWdatuNYEwD9apBLlu/6ryHKY75Q=;
        b=fj7fz0TQYCCujpBambD8BDWtMdMELpt9b5vgU0DJ2Eq/7zi9LSzxSkTaiHiD9HEXPU
         bjDK8c7qrDecqBSriaeAoi9uhWzr3dg8sKQSi1X1hj/lNuocc0KCEfqdvTe2HelFHiKw
         UrNT7SZwI3ZnOBaStnnvGJ5x2icW83q1ensMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625697; x=1780230497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyAR8EnaSZyrhUSKWdatuNYEwD9apBLlu/6ryHKY75Q=;
        b=KbW6qPAu6hEpj4tmPexZiWYb+xXVQWYPKphK9w8HGSaaN//A/RAzshVNi2hnoR3i1n
         ZbJ1OyYUiX3RUEzSOZ/Ih09ozCIzoaThi+btAaOEWECS75ExwTefAYBLeMa0AH9X9WDf
         LQYyXgXY1jOpyAPZXCQdh0JYUpwkbImA4zNmvAd92aASVcClRjGxmlG6EcLUGafhnikI
         Za4ZrjIv/778WGiOX2kehfc8xgN28x5ACAJ8hwDvhBDPJtj5soGwvqRl4C8psCuWKYyP
         Art0BpvOM/d9SYkJt/T0HTWgSZNc46y4SUis7GrTZ1VuGkl2fNWeEiYNVT+0BHK8jsAY
         EpaA==
X-Gm-Message-State: AOJu0YzbSr/lHeWLqBjWoDeFITXWmZdYDM3zO1B8IGEz+6/Txla0/Y5h
	mydX1wawZfkRulhXha5YZ8oCs7ljIw+GfieM1wNi7b8nNUQwOUgU4KnV9dsFde1u86BZB/3IaGh
	lIF0P
X-Gm-Gg: Acq92OG9VASuKjITB/q8Q+ZSoM93J7XWY2Uqa3s1rcMUJy7fmxtorIG9JOIwi6gBA8Y
	UE5Ne2Yanq2J3IiFsrxlXZvoDnCzBLnzWKWH1e7SL4+ptr7OdvPkfXKsoGjjtmis1HG+nH97wjS
	Nl7IfwCbB/M87hC4ZVwdearR/c9RK/7SazhiUbT68Lv5ZSxCm3htgC4ZYFAEJZDFroYiRRqZnZB
	unEKNtNzxTyfrQZ3EAaxcH61sH0L9nSwRXMJCchQ2m/fDiWPXsBZIwLC9/T3ZnLK/XhKMrngvfF
	Al1MLTXEgGLTrihPoN/ohoq8+dcon3Ge+VR0oaqS0toR3F2Nf1sNd5niKf8yMmqZEhR+doKUaOd
	5h/KFNrRSJKVjLpWd0yNiue6tUS3AIA7xK+nXIPlt2b4g6qhqh7epcVJLFq9pr4LuiNdX22Jkp8
	MfSjhlVHSyYhBvpUaaRZ/AkUCjWdQS+McdoLLu8kgUMVVs7F8mEqGyI5Ek+7cHFYNzlrd+uk5tL
	7DV76OYNiTGba3cKp1dK91QWUX2KJRmijT5DmWZcDPxKlxGK/BOXgsYOUAlqp0esXGJBDAu7rg=
X-Received: by 2002:a05:620a:4102:b0:914:c8aa:34ea with SMTP id af79cd13be357-914c8aa3c5bmr702735485a.56.1779625696643;
        Sun, 24 May 2026 05:28:16 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:16 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 11/13] aide-base.bbclass: correct STAGING_AIDE_DIR
Date: Sun, 24 May 2026 08:28:00 -0400
Message-ID: <e9fb34c51e28de2c11b3aa4dc4fb6425840ed0df.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4031

From: Li Zhou <li.zhou@windriver.com>

Fix the typo "aida" to "aide" in STAGING_AIDE_DIR.

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/aide-base.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/aide-base.bbclass b/classes/aide-base.bbclass
index 36cc454..9d9472c 100644
--- a/classes/aide-base.bbclass
+++ b/classes/aide-base.bbclass
@@ -2,7 +2,7 @@
 # Copyright 2022 Armin Kuster <akuster808@gmail.com>
 #
 
-STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aida"
+STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aide"
 AIDE_INCLUDE_DIRS ?= "/lib"
 AIDE_SKIP_DIRS ?= "/lib/modules/.\*"
 
-- 
2.53.0


