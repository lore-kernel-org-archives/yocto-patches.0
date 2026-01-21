Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A57AC44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:47:13 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17843.1769017629125994451
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:47:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=o9xwOL6D;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so1277735e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769017627; x=1769622427; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFFgf4vNuogVmBuExZWJZQkCHEzWGEMcqVZMP3dhMIY=;
        b=o9xwOL6DJIsqNms2md98Db0R2UzAp0b/IF5Wjo88iMevnc6SLW1F94yGWo2tgGB3iz
         oEPGwffQlXjDlesLSXdGaePWYvjCbY+mEoTMlpr+cbgkRVZ4uflAxBxJfrZJuGY4T7D+
         UfjdzF5vlIXzLDPsVT3RAOanB/edfQDRhTWwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017627; x=1769622427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFFgf4vNuogVmBuExZWJZQkCHEzWGEMcqVZMP3dhMIY=;
        b=b61EAMKfxtppLjztpNub1vEnKhrAvauYL2GigcK9dgH0eUz9j4lrgznAymu+Dah+YW
         oVkutQ/4M1wE4SsO6ZEI9xSoI2mH1ooHH31Go1fDB/KVfK9pSb+HXHTslOhOd3yhO49f
         +lc402kvO+knkp9rg38kv3mthJG77I5Xr7JBnqRJIZA37hSDn+7/tPWYR0zM2leK6RQ1
         IaV4iSOig/1Sl00Xb508agImdbZfHboYQZ/pYakPMFFaOAJPduFk1QJxAHYDci5UZFcZ
         vAF5QiztuivFLDS64A8wfaFOWkufN1s1tufYPRxSayOCiyPAl1EZXD0KqPk4n0FDM9Gp
         gCbQ==
X-Gm-Message-State: AOJu0YyfCOQ7r5iy8EZ78IM4Bof3M1MWDQnSS4b4xrW8gRigihQ2D1ic
	foNWsLFi0W5U6YPuSCgmCDy0rCf1HffZSH9p8mvcjlhWwz4iHtYe2KEN4IIttKDJH0WxRJR/VBt
	8M2Bu
X-Gm-Gg: AZuq6aIykDSulvZG28OKnLcm7eP8kGpdhISCy2sae0lSvLQu0zpE1M4YG90afzgRGs3
	Yvgb9aqUMh9yKeinFqhQjBNzXTpontChDfef554cKp5k/+8JfSRUOM4ZO5UEqxjLjQqgW1l8AeB
	PjOueN7+8Ig3lvf5LwFn+/gxxuB1lHm4NUnhp9ZrfcO/A8ywVqJgHypqQ+cYKuuykvLy9X8cDhd
	7Cq7TpFhd0lnn5Qc0vakW/pKVLaARolkNjprthcnxABU3X+fDWgih7wRusaoKXRZurjttUZMVeG
	4x3qsX3gRClvkg50yediEWyWrvy4SqzjuoXd3xu7gmureytsMuwTPONQoLYpr5mpSb/WWRbDcd4
	izdkSzUGyf0uTBGw+Ua5nme38LXVh1DrY+GC5kN/jYN9vzCyGPxIsqWV4880jXW8RC6VyW5+AG0
	WiTdbX7Lv4b9W3KP9ClKNCaZ3bLXoQ9bOJ4A3E7R37UAquIbymoMzeVrJybAnusqYH85fm6ktS1
	oYq4ITcTt/c8lz+7Kw=
X-Received: by 2002:a05:600c:1c17:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4803e7f18famr96875805e9.28.1769017627266;
        Wed, 21 Jan 2026 09:47:07 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-2607-6b4c-4a99-80db-6945-f296.rev.sfr.net. [2a02:8440:2607:6b4c:4a99:80db:6945:f296])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4359f4a7ac7sm5082117f8f.20.2026.01.21.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:47:06 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2 1/2] schedulers: sort repo branches in maintained stable branches
Date: Wed, 21 Jan 2026 18:46:50 +0100
Message-ID: <20260121174651.64212-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:47:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3048

From: Yoann Congal <yoann.congal@smile.fr>

This should help seeing if any branch is missing by comparing with the
"Build Properties" page of a build.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 42983a8..0018fcb 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -73,16 +73,16 @@ branchdefaults = {
     },
     'whinlatter': {
         'branch': 'whinlatter',
-        'branch_poky': 'master',
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
         'branch_meta-gplv2': 'master',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
+        'branch_meta-virtualization': 'whinlatter',
         'branch_meta-yocto': 'whinlatter',
-        'branch_yocto-docs': 'whinlatter',
         'branch_oecore': 'whinlatter',
-        'branch_meta-virtualization': 'whinlatter',
+        'branch_poky': 'master',
+        'branch_yocto-docs': 'whinlatter',
     },
     'walnascar': {
         'branch': 'walnascar',
@@ -120,22 +120,22 @@ branchdefaults = {
     },
     'scarthgap': {
         'branch': 'scarthgap',
-        'branch_poky': 'scarthgap',
         'branch_bitbake': '2.8',
-        'branch_meta-arm': 'scarthgap',
         'branch_meta-agl': 'master',
+        'branch_meta-arm': 'scarthgap',
         'branch_meta-aws': 'scarthgap',
         'branch_meta-clang': 'scarthgap',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'scarthgap',
         'branch_meta-mingw': 'scarthgap',
         'branch_meta-openembedded': 'scarthgap',
+        'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'scarthgap',
         'branch_meta-ti': 'scarthgap',
         'branch_meta-virtualization': 'scarthgap',
-        'branch_oecore': 'scarthgap',
         'branch_meta-webosose': 'scarthgap-webos',
-        'branch_meta-qt6': '6.8.1',
+        'branch_oecore': 'scarthgap',
+        'branch_poky': 'scarthgap',
     },
     'nanbield': {
         'branch': 'nanbield',
@@ -185,22 +185,22 @@ branchdefaults = {
     },
     'kirkstone': {
         'branch': 'kirkstone',
-        'branch_poky': 'kirkstone',
         'branch_bitbake': '2.0',
-        'branch_meta-arm': 'kirkstone',
         'branch_meta-agl': 'quillback',
+        'branch_meta-arm': 'kirkstone',
         'branch_meta-aws': 'kirkstone',
         'branch_meta-clang': 'kirkstone',
         'branch_meta-gplv2': 'kirkstone',
         'branch_meta-intel': 'kirkstone',
         'branch_meta-mingw': 'kirkstone',
         'branch_meta-openembedded': 'kirkstone',
+        'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'kirkstone',
         'branch_meta-ti': 'kirkstone',
         'branch_meta-virtualization': 'kirkstone',
-        'branch_oecore': 'kirkstone',
         'branch_meta-webosose': 'kirkstone-webos',
-        'branch_meta-qt6': '6.8.1',
+        'branch_oecore': 'kirkstone',
+        'branch_poky': 'kirkstone',
     },
     'honister': {
         'branch': 'honister',

