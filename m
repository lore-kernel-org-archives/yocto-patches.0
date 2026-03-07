Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7517FC9EF1
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6732.1772879420530077045
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=c0ho9F5M;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50905b779dfso3948701cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879419; x=1773484219; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBLdimLlT9WzbwoPUV+gSdWyzLG1C8ELseRhDI4Jdag=;
        b=c0ho9F5MpgkAqKeVQivYctgZZffOzQSXeivRMi1z38tjAxABXXL+MHCu6wa+TKH2RU
         yaIYYL0NFgwxlq6zixOkIS7MoXOznUAfUC5jlEXVuH+y1WMi7N6XX/zRMvVL2699lLT6
         Fx0rEUCfsVUcJuUEScI1Pieb2PZjeDbSlXJIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879419; x=1773484219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fBLdimLlT9WzbwoPUV+gSdWyzLG1C8ELseRhDI4Jdag=;
        b=OnEJaFGPQ3O9uBMZaxAbUOEUd/qlx7C4eKatMuCL1DTIaLvqzsLgk28+NM+/S1mknh
         N0DafahYS2nGzktnVmFw06U5RD6QZhI01UQ1oH0ws0aKBMq7oIW9kjT4R/CHQVgeCmYh
         4X+6N75glQCgcw2evI0SZ0jzv/6XMxx6cluJVKuXpqpLCzxatQMPNM6TNZ6fLZbaFom8
         vTgChdNhhyzvzjOisocwid1KfTTVK0N3LS97al61mPJeE4kGP0+z5uE6N5v3S+klOg0N
         PKiGLXyT3+lJDCouSdw4ilwkGg0iDak1Bq0qzMtm9iyDKdpOPkLjh7hqOTdrWXJB8KU6
         pnxQ==
X-Gm-Message-State: AOJu0YyUC0KOEERZjJsJ9J2zT2ufms3AE3gnRiXx/Cz05P8MhVmJyC1o
	mmNoZQMy/F6zph03m+t1BQIy70YLM1Mfw5EZNq0iak0vYpsAiJmziL1u2PZy9eoijjoP8zajiX3
	MeUIhHEs=
X-Gm-Gg: ATEYQzyX092H77ote/ypjwpPLxU2hl4jcHlglzAL7hPfPVl49CdDaI3MNI5qZjf7S4I
	oYgB/zZtWSqNZlpwhJkRWojveia3dlLKY5v5H30vzVmXc3hRyOmU+SfYdclBYKb4tVgMQWJ20ai
	mJpYGnQPonENjFekDRUM7tMWYttlEwJuwSqTenLfz+s//GhGjbAhTS5TxbgtGbpNtOjYyJZpxhh
	Jfg4PJ2T2HPqucUd1cvFVsuM5zJYd/kjqRmeFmN2++L3aed/WdQBPRpcU3XlKMXPHu7TLc64EPX
	kYXaQilDEvwryv7n9jAk3e2zlyNvb2RKZ5yHaEbma0XSaXGIjOngx1kMHYHJftLqs5FEpSh9pyd
	HuPg55vdQ+KKqth3Nn3I9HeYrh2ysK40yh0PuLGnVIb3tp9cpecI4N3KaXjUHcs5E+i1SFLx9tq
	23mXSiI9vy3pa5tBj3x44uCJELUSdZheC1jzAMtow1QPClkNuV6p2T08YOK/xWHiZDxhyrMpJZE
	7qlfrSqvEYQEYdqpAbCBseV5PxyoC/3+QrMhAUnKtf1/pTli3275WZ0IGbWsFdo
X-Received: by 2002:a05:622a:608:b0:509:a9b:8a6f with SMTP id d75a77b69052e-5090a9b9ad4mr3227241cf.56.1772879419269;
        Sat, 07 Mar 2026 02:30:19 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:18 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 7/7] A couple of small CI fixes
Date: Sat,  7 Mar 2026 05:30:01 -0500
Message-ID: <0936595355433f9691fd30257743865b9ae27a1d.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3372

Change the "poky" layer configuration name to "meta-yocto" in the
KAS configuration so the cloned repo name is less confusing in logs,
and fix a spot where "poky" -> "openembedded-core" had been missed
in the gitlab configuration.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml            | 2 +-
 kas/kas-security-base.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 80b2dfd..701a65a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@
     - mkdir -p $CI_PROJECT_DIR/log/
 
 .after-my-script: &after-my-script
-    - cd $CI_PROJECT_DIR/poky
+    - cd $CI_PROJECT_DIR/openembedded-core
     - . ./oe-init-build-env $CI_PROJECT_DIR/build
     - for x in `ls $CI_PROJECT_DIR/build/tmp/log/error-report/ | grep error_report_`; do
     - send-error-report -y tmp/log/error-report/$x
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 2ab81aa..38043f5 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -23,7 +23,7 @@ repos:
     layers:
       meta:
 
-  poky:
+  meta-yocto:
     url: "https://git.yoctoproject.org/git/meta-yocto"
     branch: master
     layers:
-- 
2.51.0


