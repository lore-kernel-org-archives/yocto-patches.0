Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006ECF8849
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 11:56:55 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32632.1763639805818239133
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 03:56:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JoCU/sq9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b91680f8so6536155e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763639803; x=1764244603; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=17dH3sG0mloFfq/5TuM3yhWS2MwJc30GAd68xDl7R1s=;
        b=JoCU/sq98A+0tU7FE9EvBbnp0o86DFm9hbCCXCMbQHP6NHAg7Kinl1yrh5HS+DtZu1
         K47/76qmQ3nZwkbcYHk/OLCWoD3Hn9XY1pejRWU4rLb0/8OYK2rFHhHS7PFWMO/PfvHf
         /+5PYXXzchcey9WnajGzeLVbsDzNkoSVGh+n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763639803; x=1764244603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17dH3sG0mloFfq/5TuM3yhWS2MwJc30GAd68xDl7R1s=;
        b=F0B5mxUJByNBMAsDu27wZZGDOlX/1iqOFRFgueQvIVMFYWyItIbaxOL47eXO1GQ6jZ
         8TIIN5dnH41+J9qEyTOFFfulIyRcYZi9R4uHE4PzKELV3VNjLH5SR+szMDtdCEXF7GXk
         wAwBsM6w+64IIjzkOLuCvHgY7cBwLlWLhZbB+hl0XrYB7yXa7R7+gL79OoYIDXagNLBT
         jGG35gMfihvDcjqnmKWw2yJFpglO6yDMvbaV9slWOkzx6P1df4vo/2Vu4VWOfNpWu80r
         iM6XEfhE9Il7Jyqm5YpUFgrKcK8tl8zhYH/ywx0F3aFN3+/DoLLfJjSsSH9+j1Xv5B5n
         bwaQ==
X-Gm-Message-State: AOJu0Yx1il1Z6BaENj7bp2xrrWMyZnVSH3yAKKf20Kanv4kAm3vwc3Cm
	niEGq5qX89u/JKN5C6Y5ZZ8+4xsnQRsISZTvpzpYRB9FaU0CszakSppIbvXa/PCaTclTd1Zxnkm
	RKmQh
X-Gm-Gg: ASbGncu2/QLCf7H4D5wCipcAsBD9cZk1Hdtutp0e3toWhx8e6mAfEK++9JAeD0rJ1/R
	6rPISx6ri0+nC/GHRVQ9KAxP4OxVdDe0AmgaFsqk3V+lNrU6Qbs4gSSfYf3cEOuiUKsMF2dhCgC
	jXi3bqpLojcDMkZ7YlfbMyXu38qL2NSin8KDsOxeNR1cnC4FYgU7eNEM5zxuJ4TauKZmNZRqzE6
	odxwFW7l1t1aZQDddMfzVUk8noUhlq/yEu9LR+Bz0vLnQDetMnjU+DeSdBuOdwqlHM2dfpr/QLi
	NBTYEjRPEPEJjo19ngIiMfpQvWak4tV1SJe8PvEvlFLjikIDDHeWfrAGJ8YSxim4LZtiPNdQ55W
	jU7g6LVlocd5K0qrD0nD/XT/XPe0G8bwJIv2PgLIOTknIBBfBAuw2vFjcJ2r+8OfjbE57vuBDo3
	cOzVUG50TJxxj1Ct8bZQFThdtr4wkgNJdbwEhUcug=
X-Google-Smtp-Source: AGHT+IHN9yr4sVUR5ZtErmsICAEPuD1/enkXFKnlomTJnPX9iPCz9MLOBhL/d3V5OhX2PVDcrIS/cg==
X-Received: by 2002:a05:600c:45d0:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-477b8a84acfmr31504115e9.17.1763639802986;
        Thu, 20 Nov 2025 03:56:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8d15:c0ee:cc9b:c363])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b102bc9csm104553725e9.8.2025.11.20.03.56.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 03:56:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Drop Ubuntu 25.10 for wine usage for now
Date: Thu, 20 Nov 2025 11:56:41 +0000
Message-ID: <20251120115641.61942-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:56:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2626

It can't build meta-mingw at present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 9221c2cd..2408602e 100644
--- a/config.py
+++ b/config.py
@@ -172,7 +172,7 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
-workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
+workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 workers_arm = ["debian13-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists

