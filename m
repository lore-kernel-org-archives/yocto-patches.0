Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A018F428EC
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:52 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4574.1776284386983647268
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=po2dawUQ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso81361436d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284386; x=1776889186; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZO/Txp+v1hd+xfMkX/JULc80qjePhEStAJLUEtj/5ok=;
        b=po2dawUQ4O/y/Rqu+x9RMmvmGfxPNRkjzVk2vAZuILDlZ1d3JQzPhszHzWKyyymhGj
         CAUjE/LFkmfvzle18NnlyXJab3GgRW6EF9WyFt6fRueyHzpXn0SK0/Qoh57nzyKjOm2a
         d71EZHv7tufOwL8tAlMnHc1FCy7KDPFh2ciy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284386; x=1776889186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZO/Txp+v1hd+xfMkX/JULc80qjePhEStAJLUEtj/5ok=;
        b=esrvwwu6EmMGLo23we/XPHiZmoEKov+S1By1yelM3b8p8n5i7r1qLSZtYlr2NHJuId
         V2gYEkiAKE64+FBvrse+pwIagZddGylxBi7go/lRs0uWkdXEJBS0Y3yGGeHs3q7uJgAy
         Rvj9ypt8cyGp3kVDV0sshh2aQmhxXYnF78xTu9j+wmj9RtBOb7H8KWGeAquR3nYFRp2g
         0TemmmkGXGQX8Cj0n1YnTxJlABgp/M5AsOjFt5e/uGv4+oE2BLiVYc5cVzzlA3IY6J/k
         4uuWwVgBHFQN00hJ/hKfU0AqBl8X+48A4EfPHmB2uM1wbZ6ozOKccqCEIvzt0SGpfKdO
         V1RQ==
X-Gm-Message-State: AOJu0YzNLXDqDmu+HUl7g4fgzTu5yBcfwayr7559Qx/GBIxaZP3bwvZ/
	6NKYApOn6PjparmhAsKObSvTXYto8LDPMA60XnDPU2UnlFgvIKhATz1Pg3JYTZN+5Un1PbFSnq7
	NeKab
X-Gm-Gg: AeBDieu22Vr7UMxflY5oeZKOR05trWrKHlnLPV9nX/2ojgpN60d6wrIExlN2pCHqlOb
	gHI3l9mibyAA7OaR47q88l/lK7pC8NwxsQ1aGbMNyAtjayNENjIfy5YoX7S084Dt7TrcoiIuzSB
	zkCHqfYYwUliG68tgN2GQAUta+GE0FU04u9IdY0+j9h2PQtXYi/i1cl/r3ZVDJ30Yzs3FRwYFmx
	arICwxJ9AxOaY8ZYZogLqrG+hr7PssVRGTJT0YA54hh7dQ81HmVr0n4SpGqQqOuU8lvfQ0Af8OA
	4geVCKDjhCwpFlzdA/fG8AZeg3unpnjdbWRw6nmySWi37dZv32018YN/FapJ09bCUADyqT/wLQ7
	01hJJH1wDLzw2pp7oQ3mYweJnkKgkH8i1J5FP1YYWj22uQWD4Me9YDhh0HLX/T2nBkVgKvJkm8C
	/PXdyb2tRSbxBxWzcaiESbfAc/hj5UH+FDFhCPdXrRYc/QBA1vTr7d4NcwbPtrjY1zE2Hny/0qb
	T7av2ZkAwQfBPrPp7UxDJLivRAY7UJxQLb3Rjyj5C9/VqVAfQyucNqObSQhySBA
X-Received: by 2002:a0c:e00d:0:b0:8ac:b31c:9961 with SMTP id 6a1803df08f44-8acb31c9b95mr170272056d6.43.1776284385710;
        Wed, 15 Apr 2026 13:19:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/7] scap-security-guide: upgrade 0.1.78 -> 0.1.80
Date: Wed, 15 Apr 2026 16:19:22 -0400
Message-ID: <f276fa1ccad8989c0ccacd18ae13fabdf4cc621c.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3710

From: Yi Zhao <yi.zhao@eng.windriver.com>

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.80

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...p-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} (97%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
similarity index 97%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
index 919a09c..ab495db 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
+SRCREV = "a1b32362394c7739a7a94426c61c7cb24449d9a0"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
            file://run_eval.sh \
            "
-- 
2.53.0


