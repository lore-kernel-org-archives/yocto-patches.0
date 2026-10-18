Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A5ECCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:23 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22592.1792361000919972733
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OdMZXJ8n;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1125515a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361000; x=1792965800; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8BEIsZg675+Zi0Xq+3mlUXeAce09+qvIgVto/L497k=;
        b=OdMZXJ8nVtf7EuIfctirHldL5BoQK8AFBOlH/eDhABYcNsZ6FsHeWELACemo+31pQO
         Pb0AY1KBS7QAebQ06tOX7CIGDsV5NhRXnu8fpCHqRUAsQK3oLCmuXvBgDECNElpUnFJe
         keJlvZR1k3mib1Cgbm4o5GfI1jtfx+zOUCQvY8y8jDUX/1G1V5LKo/mHp+GeNuITnLXo
         VERB7UihrD0GAeg2HW0H5hAT1Rvi1aS2NIT2yQc+dhePGzS36oU7xTimzPOV2clqnUum
         qmRJ4YunPPEcqB2pBXjPk9Am7edAfVLBRWEC4U3rcMRn1nS3K4TdPD+AtUG5AgwSJBps
         3+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361000; x=1792965800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8BEIsZg675+Zi0Xq+3mlUXeAce09+qvIgVto/L497k=;
        b=vZ/FUo3eneLm5bYktyewWPaRcf5m0iFl6k6Zrln2Q8Ckt38pZEEStz0W1E6bjYzrbt
         x/9NYcVr8y2uafh9ZogTn9PJDxYw5wG9AdpvaDqgCnBbIxyuxycRBAqqWgv2TlR10JF/
         veHmlHTwQNR7G6WB/5wefvIavu7t1ii7Q0DF9l71uuJ7NFHhmQs0CwzXHQAzz7jY2oKS
         knBj70MeyZJG78g5RBJffVYprUucJstgamMB+DyOr+F7ocCJHztA1OwM4deFta/8G5HP
         99D4tySBZQMDQIN4U2puBIXfE0KGTbg48TRRKAeCk6A+q54e6oC2KR9nDs5ksOUm0m3f
         vn0g==
X-Gm-Message-State: AFq9FYLmlm+bIN8rvL7TkTMUWadEReMkO/CK5CMJ83B0pDrvEft9VQws
	3dcOL0AOzd9X3AOIj/SEAhaTm9Vq8whBtrofmi8gFoJj4fxZn3K6yvj2Qal2Fg==
X-Gm-Gg: AYBFou3HBy810YMEKulReGaDLvC3AUZn5j4lZYrYJjy0o1M/se+WZDmI10C89Ai68nW
	dV+yb96Qh19VaBkYHjG7Pb48zm/Y2YVO5pJ5rizz+WhpE+9+XTa4DL8jNwZM1rVrF6LP2bjdI38
	+IF0L91OkWZ6HFFpJ5jkWOX/SOfzsYfmVFQJXuXlJDAZt7hNMiU1OA2LCQvoECoxjTmJjiEj4nD
	yWJ2Z/Hw2iOyymALYaoE5hQwhzHvZTLGIfkGHT0ukPr4eNS1UYpYhzdSN3uk5rAeT2+zZmK2qjm
	EXe4l4Y2meDd2GD4AAtIjGBW2UvC6PXcbCQKEeFW3mHGRej8ak7fSrdqbd+hqB4KjEXRfB/eJAK
	GKfbYa+XP99x4ZrXsvURrojZYYYM1PKmyg4CTd1lOAXNnvDQzxjLG/dKw1Nt8Br46EAFTtPE+rG
	+1Wfwg7pNZq1Y/pxuDASx4uR3kExkYk/5lBt9LPj27DvPm+1pQ/aRE+mzG2+wcQPhlsk9u0kJiY
	QMzVUmwiKhBOXj2UrbdAHm8FJGphCY7
X-Received: by 2002:a17:90b:4c92:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3acef55d641mr3607330a91.36.1792361000218;
        Sun, 18 Oct 2026 15:03:20 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 03/10] README.rrs: mention ENABLE_RRS for the Docker-based setup
Date: Sun, 18 Oct 2026 15:03:01 -0700
Message-ID: <20261018220308.72731-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5085

docker/settings.py adds 'rrs' to INSTALLED_APPS when ENABLE_RRS=1, so
Docker users set that in the environment files rather than editing
settings.py.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.rrs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README.rrs b/README.rrs
index 07bdea9..a311adf 100644
--- a/README.rrs
+++ b/README.rrs
@@ -22,7 +22,9 @@ Setup procedure:
 
 2. Edit settings.py:
 
-   * Add 'rrs' to INSTALLED_APPS
+   * Add 'rrs' to INSTALLED_APPS. In the Docker-based setup, set
+     ENABLE_RRS=1 in the app and celery environment files instead (see
+     "Environment files" in README)
 
    * Configure TOOLS_LOG_DIR if you wish the logs to be written somewhere
      other than the current directory when the scripts are run
-- 
2.56.0


