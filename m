Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40893FCE096
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 14:42:41 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71514.1772116951540014971
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 06:42:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CAIaeoDO;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48378136adcso5773515e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772116950; x=1772721750; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZzNG6CzWZqJAaz081d/eT7jAXUYTg/1mgNZrbyuFCs=;
        b=CAIaeoDOKN6Oe9YXYNy1RR+WQVV0G9GmDalA3jGjPp+ThuA/xdE3o0mYNlHE6n3Knv
         qX84wcd29ZrMWpQ3CFGVhqI+qK9Wut4K5uHsDyNdehyjn+288cbLpwKshDo3hcNiwTp6
         r3mpX3pV9i65TlWmvSZ4MvXE5WVUSZpnHruTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772116950; x=1772721750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZzNG6CzWZqJAaz081d/eT7jAXUYTg/1mgNZrbyuFCs=;
        b=jiBgBjO/Fkk9/pm8Yor95Mh3qCL6yFQCC8Y31Oj2hkkwqG+q1JK93CEyiWEOiDyvxv
         iX90FETG8mNDB5BDfWeWTur71Bdb2Tf9Ht/PNn4PKuWwCjyI/ajnK1WtTDRcA4Y+u7X1
         Df/oRvkC0xDrGShbvYKlKkPogk2HX65wFMnF/it2HR8p8kPLOAxJ4uM2+J2FVYrNJgtI
         /o4rbZqZJNEPnjdDtaXBkSht2ycuLKEUFQ6loKE3YF3iXAj3c1BHRF4SbMCpv54PwxaL
         Bhk1SWIPVZVDEcedXLVSadcXg+JjUNiPlyoNAVQPsnvkINvhjsqLbSHxAgGkCKeWRy5R
         6JNw==
X-Gm-Message-State: AOJu0YxKW/lrGYyBg9YK5UYYHXPpk2umK+cy1bgm4OSiF5nr8GBmLixf
	3X+RyCLZMHdTntGF/TRHEIfECe+cZi+twWdp1OXv+DM0xWeIw4YiQst4WWr2zfSGjJzz/ie3EAt
	YRojC
X-Gm-Gg: ATEYQzxQ9CjjLT5dWRxR+ogviwucu1+wgoguGeKfwrubiRYPz/vaYDw+OKhmmL7vgTG
	Sxp6smcJBHJucd23bZwJ0NNmva18s5aLaaCcmz0ynvMznvFlYhoCja+0TZ6Sxf0XcSjpKLZA5D0
	bp2RvOLw3awiCp0Krp+lu90nWm7Oyn6ti+UsNXPrJPnRVyR2MFbuDv6txs2RB0gEB0MqE0lFhnG
	8c+3IM1f57QWHHAYSDKSpCVWrxONcZ99P64kyL+fvgxlVuBEJXeMjSvJr/tBn5AbHy6vMeN9Foi
	RZKfbb5k/M1XFQOQsbAZY8sSTLHoCQSEw7MTiG7/LQxFcLzUhkdZJtZYMh3sutkSdN2rZHX8LUF
	iwdkEj1pN/gvLqHTNPcmluIh5GARV6Sdl7xvpTIEgrOCPc3eVdeNXssH4158eoq4F1IHdiJXGl5
	M6+ta/J9/KnWtzXgDKt69UCyPNxcIxS3SCxZEObzsDMx1hEUxaaRZ4794WiLEkgd96sH4tzihFJ
	MzSNCoAq0RqSGLbQS2YCQlQgX+B
X-Received: by 2002:a05:600c:1f06:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-483c21764e8mr63995815e9.11.1772116949633;
        Thu, 26 Feb 2026 06:42:29 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa002c0b752a8b25831e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:2c0b:752a:8b25:831e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84139sm55362735e9.14.2026.02.26.06.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:42:29 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2] schedulers: Add stable -next/-nut builds to the branch selector
Date: Thu, 26 Feb 2026 15:42:01 +0100
Message-ID: <20260226144201.47577-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:42:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3289

From: Yoann Congal <yoann.congal@smile.fr>

These build setups are frequently used for stable maintenance
work. A shortcut is appreciated.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index dd692a4..51d3ba1 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -85,6 +85,28 @@ branchdefaults = {
         'branch_poky': 'master',
         'branch_yocto-docs': 'whinlatter',
     },
+    'whinlatter-next': {
+        'reason': 'Stable maintenance - whinlatter-next',
+        'branch': 'whinlatter',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.16-next',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/whinlatter-next',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/whinlatter-next',
+    },
+    'whinlatter-nut': {
+        'reason': 'Stable maintenance - whinlatter-nut',
+        'branch': 'whinlatter',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.16-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/whinlatter-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/whinlatter-nut',
+    },
     'walnascar': {
         'branch': 'walnascar',
         'branch_poky': 'walnascar',
@@ -141,6 +163,32 @@ branchdefaults = {
         'branch_poky': 'scarthgap',
         'branch_yocto-docs': 'scarthgap',
     },
+    'scarthgap-next': {
+        'reason': 'Stable maintenance - scarthgap-next',
+        'branch': 'scarthgap',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.8-next',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/scarthgap-next',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/scarthgap-next',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/scarthgap-next',
+    },
+    'scarthgap-nut': {
+        'reason': 'Stable maintenance - scarthgap-nut',
+        'branch': 'scarthgap',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.8-nut',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/scarthgap-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/scarthgap-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/scarthgap-nut',
+    },
     'nanbield': {
         'branch': 'nanbield',
         'branch_poky': 'nanbield',
@@ -208,6 +256,32 @@ branchdefaults = {
         'branch_poky': 'kirkstone',
         'branch_yocto-docs': 'kirkstone',
     },
+    'kirkstone-next': {
+        'reason': 'Stable maintenance - kirkstone-next',
+        'branch': 'kirkstone',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.0-next',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/kirkstone-next',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/kirkstone-next',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/kirkstone-next',
+    },
+    'kirkstone-nut': {
+        'reason': 'Stable maintenance - kirkstone-nut',
+        'branch': 'kirkstone',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.0-nut',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/kirkstone-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/kirkstone-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/kirkstone-nut',
+    },
     'honister': {
         'branch': 'honister',
         'branch_poky': 'honister',
@@ -504,7 +578,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "whinlatter-next", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-next", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-next", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",

