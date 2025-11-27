Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D45DD116F3
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 16:47:58 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22804.1764262070857316257
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 08:47:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JG1Mcx71;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477aa218f20so6459675e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764262069; x=1764866869; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jevhVrGt0Fo1u0uNmxwLEFCyRwwW8DUiCHh84TnnNOw=;
        b=JG1Mcx71kDwXhFErR6WsWiWngjI6IKe3bmG6QuUK2Sa+ok7461Qh4PLU2Z6kdytDfT
         CKMpwvVYOM67QynQfk+QYp9tiTL8zCI1WCScPgWD5szpaelcLoKk6fFzehHB5fXqfIo8
         3XMOaf3atHUJLiLoGVPpxiTNgYzMmL93Ha3NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764262069; x=1764866869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jevhVrGt0Fo1u0uNmxwLEFCyRwwW8DUiCHh84TnnNOw=;
        b=NdVYreqf6jfT3HhMH6yaXkBkoW5U3ZWRGH7MzSme1kTy2YXEtlRSKpKbAsFjGh+cAv
         dr8KYfO1xzRSMcSl0G5vWkzm1CSQJEyDWIDSVvvBgVOjPIyF4lq2IT/96vH2+Xb8x2nq
         xFdYPN24U7xRX7OHOj3/cMmMbdIMsIQuMfmdMHUZqar7bHNagVIBybB+J5mTRzqsldOw
         kCDGkoMd6eGntBu62O+76YNBPhKq+FNOeyRn00HxnwNHsGdHKDMbqg8KkuWuxHaIY885
         N0MJuAPR57g+6MDhW0BHRmwm4Zpu4NCA3YohU9SDlZBIyunVWW3dl2JQtM847+Akzmhn
         j+ZA==
X-Gm-Message-State: AOJu0YyP+tfc6sXQfIOojz9KMrLGRCuus28IuI2EG1d9lHUHT/nTt8t4
	QNk0/pK2yLAmMJ3MNpkXnUPz45yOZBLiBZ/V1gNuzjzD0sLo2iCKFqxafficasZbf1S7t/GFvBh
	Ll2CA
X-Gm-Gg: ASbGncvsYB+vwMjnpu3dLbCTwk5wFJ9LhlnpRFvDIpl4S9bmkxjSyuE0MIb+BTURyTi
	Ul6Tc3f5yJBt0kdkCNqen4dn9VTgCqQwdVIm3OO7Cg02G0He1PEy0sf30heWoVp/dkV2DZ68sQZ
	FQEj00/A37q2iBWN0G40fCnPU7o5Lg8AjhuKhGzxa72KIa8oSP6W800C1GvO7+LM7dO/+0SVQqR
	hkqfGO9vUav8AgmJGAsLUPBBbHU9WI6Qam0lzv1/Ll0xkOsV0Wumurow0WZkT27OQ+7H2UUyBaa
	8yYhYQ5C4d89HDA/h0RBLegxkN2CMop5paQRHw2NXizi6G39WHxrbPUMOY/ZtijYHClk8zqi91j
	A9RmG5AAZhvHSZmh7OhcD+epq4kQKsdmrEWuvRAqXrFO48sHfclkv8trRE11F7aeoyrnH6i+3Co
	pcB7ksSylPjRwPURvwn1Va1GLcSctemCmZphokS4o=
X-Google-Smtp-Source: AGHT+IGCuIgSRzSCT6rzaRaBaqK/1xc7sdJdM9zOwRRdA73IPLWQaDLDL21L460SEF8owVWhGp1Waw==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477c0170782mr240824545e9.8.1764262068681;
        Thu, 27 Nov 2025 08:47:48 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:49e4:7f15:9d56:4465])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a396sm4430532f8f.22.2025.11.27.08.47.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:47:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] schedulers: Update to add whinlatter, drop styhead
Date: Thu, 27 Nov 2025 16:47:47 +0000
Message-ID: <20251127164747.854001-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 16:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2722

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 schedulers.py | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 8ab9dee5..718556da 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -31,17 +31,10 @@ branchdefaults = {
         'branch_oecore': 'master',
     },
     'master-next': {
-        'branch': 'master',
-        'branch_poky': 'master-next',
+        'branch_poky': 'master',
         'branch_bitbake': 'master-next',
-        'branch_meta-arm': 'master',
-        'branch_meta-agl': 'next',
-        'branch_meta-aws': 'master',
-        'branch_meta-clang': 'master',
-        'branch_meta-gplv2': 'master',
-        'branch_meta-intel': 'master',
-        'branch_meta-mingw': 'master',
-        'branch_meta-openembedded': 'master',
+        'branch_meta-yocto': 'master-next',
+        'branch_yocto-docs': 'master-next',
         'branch_oecore': 'master-next',
     },
     'mathieu-next': {
@@ -68,6 +61,18 @@ branchdefaults = {
         'branch_meta-openembedded': 'master',
         'branch_oecore': 'master',
     },
+    'whinlatter': {
+        'branch': 'whinlatter',
+        'branch_poky': 'master',
+        'branch_bitbake': '2.16',
+        'branch_meta-agl': 'master',
+        'branch_meta-gplv2': 'master',
+        'branch_meta-mingw': 'whinlatter',
+        'branch_meta-openembedded': 'whinlatter',
+        'branch_meta-yocto': 'whinlatter',
+        'branch_yocto-docs': 'whinlatter',
+        'branch_oecore': 'whinlatter',
+    },
     'walnascar': {
         'branch': 'walnascar',
         'branch_poky': 'walnascar',
@@ -483,7 +488,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "mut", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "mut", "whinlatter", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",
@@ -576,17 +581,17 @@ schedulers.append(sched.Nightly(name='nightly-reproducible-meta-oe', branch='mas
 schedulers.append(sched.Nightly(name='nightly-metrics-dunfell', branch='dunfell', properties=parent_default_props('metrics', 'dunfell'), builderNames=['metrics'], hour=6, minute=0, codebases = {'' : {'branch' : 'dunfell'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-kirkstone', branch='kirkstone', properties=parent_default_props('metrics', 'kirkstone'), builderNames=['metrics'], hour=6, minute=15, codebases = {'' : {'branch' : 'kirkstone'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-scarthgap', branch='scarthgap', properties=parent_default_props('metrics', 'scarthgap'), builderNames=['metrics'], hour=6, minute=30, codebases = {'' : {'branch' : 'scarthgap'}}))
-schedulers.append(sched.Nightly(name='nightly-metrics-styhead', branch='styhead', properties=parent_default_props('metrics', 'styhead'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'styhead'}}))
+schedulers.append(sched.Nightly(name='nightly-metrics-whinlatter', branch='whinlatter', properties=parent_default_props('metrics', 'whinlatter'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'whinlatter'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-walnascar', branch='walnascar', properties=parent_default_props('metrics', 'walnascar'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=15))
 schedulers.append(sched.Nightly(name='nightly-metrics-gitstats', branch='master', properties=parent_default_props('metrics-gitstats'), builderNames=['metrics-gitstats'], hour=4, minute=0))
 
-# Run check-layer-nightly twice a week for walnascar
-schedulers.append(sched.Nightly(name='nightly-check-layer-walnascar', properties=parent_default_props('check-layer-nightly', 'walnascar'),
-                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
-# Run meta-oe-mirror twice a month for walnascar
-schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-walnascar', properties=parent_default_props('meta-oe-mirror', 'walnascar'),
-                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
+# Run check-layer-nightly twice a week for whinlatter
+schedulers.append(sched.Nightly(name='nightly-check-layer-whinlatter', properties=parent_default_props('check-layer-nightly', 'whinlatter'),
+                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'whinlatter'}}))
+# Run meta-oe-mirror twice a month for whinlatter
+schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-whinlatter', properties=parent_default_props('meta-oe-mirror', 'whinlatter'),
+                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'whinlatter'}}))
 
 # Run check-layer-nightly twice a week for scarthgap
 schedulers.append(sched.Nightly(name='nightly-check-layer-scarthgap', properties=parent_default_props('check-layer-nightly', 'scarthgap'),
@@ -620,7 +625,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
-            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
+            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "whinlatter", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             properties=repos_dict_for_scheduler("docs"),
@@ -633,7 +638,7 @@ def isbitbakeDocFile(change):
             return True
     return False
 schedulers.append(sched.AnyBranchScheduler(name="bitbake-docs-changed",
-            change_filter=util.ChangeFilter(project=["bitbake"], branch=["master", "2.10", "2.8", "2.0"]),
+            change_filter=util.ChangeFilter(project=["bitbake"], branch=["master", "2.16", "2.10", "2.8", "2.0"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             fileIsImportant=isbitbakeDocFile,
             onlyImportant=True,

