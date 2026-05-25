Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA0CD5BDD
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 21:07:34 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24444.1779743242342022082
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 14:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=G25AP0sT;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso22916245e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779743241; x=1780348041; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5EdP5fGGh32LgDq3A5/fiBWQqCb38OLKIRctcj7hTQ=;
        b=G25AP0sT51TfOzIEldKXgpLek8FCGC1SuGPq2HwPch2emZMhlfxuxVAaEF6IRfJx5g
         UYpPY9ZpWKR+dTLglFY9C1HMf9EvgFX8sNyHNkKOOX1UMrCYMEanTLiN2y8jGj8O2W+s
         UrvArRW398qUkuaVo7pZDLRykDMNupsFLZDFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779743241; x=1780348041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5EdP5fGGh32LgDq3A5/fiBWQqCb38OLKIRctcj7hTQ=;
        b=p/YAiN4R2jxJaqdYaM6hV+nYn+Z6FxMBkFtb7zicoO31nr+unqttv0OhK/WYFZtJWO
         2Rz3PMU8+IGUYOqe3bWcyiYe+xS3goiYmSdOUEb6F0X1rGZt9ESdw+AvxQQ6clHxHxTG
         bNYa4odjXWSUaFbPFsdFLSQzU696TqYKqLg3Lu9GsYel9E5tjr4/MVDogM/Slkoctqh3
         cP2iKd5lD3A/dkzsLqri1WYYaNc7cqWb7cXUcokwaoZE9bi5Y9aqsG8n1U6yAODGChN9
         jEdzRv/sQt6D8yB0rI3FLdUlu4fAY+nXCORVjbUHKLG200s6SxCkEtnpOxUClZflKKPC
         VzMA==
X-Gm-Message-State: AOJu0YxRLMmcQ9Jm3QI+r8a5kqNBhILKn7y/QRsoTwQ5d1xhSzcx1ta4
	LI9Mz0YLPE3nkJx8gnlxjFd9GgBge3nRno40rMTZUe0073gbeOIeBw6udiYo3/W+E9WtSTCFg/l
	k8DJv
X-Gm-Gg: Acq92OGpTMq6m8F0M50Ws7JeTMHqKlg1g+h5GXWGOyjn1PfkosGO2YU9NIGkJi5qiGd
	+cA+JYAhx1vKLF0CIBJwtZKz9xFbyzpM6YP5J017bf9Gekfhipi6vJPJSCvojHRNG9bpCh9OTbH
	7b2vwZz/Jjp33fvpDTJw71e/Vx/Bmq9Lbotv9xGvd+oXcUEkzpefHL/LyDmHMmCMdAgcJyHsV0j
	yJgj4jLS6EeL//+ktSQBTVVsYI1uYd6KfR6UmPYQNalfEcTGnRkC2nWIYoA1z6DDm2t1iuHtxe0
	A6P/MDSHuTmeD6O978FvZ0EHSRFBKqtDRBMCuRslPLOYr7XZ13D3+LmOMS5i6PbBK0AMtiB5rzW
	S1G+C5B32vR2VEdH4heZPpzpiy6GWlGuwWnAaCLzwRkm85jYGvM5HFlCqeSQMOUWr0pntnXXeyE
	wDXBX0mKQvvE3h8XCGKDnM8dLjXBYfpIcESn76dXu0S6xtZbtPasvXKF+4oL8Xwe/EoEFkWl/04
	Q/weXsS6iWeixrJEJatCtoZ+eQ=
X-Received: by 2002:a05:600c:3b1f:b0:490:688b:ee96 with SMTP id 5b1f17b1804b1-490688beeb3mr64865515e9.21.1779743240717;
        Mon, 25 May 2026 14:07:20 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm282941535e9.12.2026.05.25.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:07:20 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: Yocto Patches ML <yocto-patches@lists.yoctoproject.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 1/4] docker: Switch RO git URL from git:// to https://
Date: Mon, 25 May 2026 23:07:05 +0200
Message-ID: <20260525210708.2918572-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 21:07:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4049

From: Yoann Congal <yoann.congal@smile.fr>

git:// are deprecated (and currently don't work)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 docker/Dockerfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 3d6be54..0a2777e 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -108,8 +108,8 @@ RUN sed -i \
         -e "s/^\(workers *=.*\).*/\1 + [f\"local-worker-extra-{i}\" for i in range(1, 9)]/" \
         # Remove workers_bringup from all_workers \
         -e "/^all_workers *=/s/workers_bringup + //" \
-        # Switch from ssh:// URLS to git:// so we do not need any auth \
-        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#git://git.\1/#" \
+        # Switch from ssh:// URLS to https:// so we do not need any auth \
+        -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#https://git.\1/#" \
         # Use any worker for any release \
         -e '$ a workers_prev_releases = {}' \
         /home/pokybuild/yocto-controller/yoctoabb/config.py && \

