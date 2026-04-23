Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC5EFDEE53
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 21:44:23 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8635.1776980656478160962
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 14:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aKZTduSc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so58145725e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776980654; x=1777585454; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKgXg8jNZvH98sfNB0ic0vaKY+9wcln46thD4MKAjdE=;
        b=aKZTduSc7e3xnb3wMJ0uINY5qLcDuZ5hkflOoRqsUhD7nWWFfC2bZAE6B27IKMgcaR
         I4X3lwkAaQVZRyHqqtnBILkjqKxVlzBpmZDmrYOMkf7FAySviF4qRv+/16BtBYF2WXlq
         6WJzVTAdogPnQahB+4MQCzpSDPki7YQmJLYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980654; x=1777585454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKgXg8jNZvH98sfNB0ic0vaKY+9wcln46thD4MKAjdE=;
        b=ke+YQ+Ne3ne/uaUNtVZU7OgVc8PWQGEd5woUG3h+7V61UUoToUrBPsfNup6DooOKvR
         fFcYiH3euBVk7bBYcMjUHEbyvvsJZUkZUiOi5JD3p6HTjKlKXeZ7HMOSVGxWKOZ8v4D2
         /3Ved2eovhSYV+uCzBLlGYm6+nMV1slbOlEnm1yTJ54MNNvFnrZZAjKZtBXCb5cBKi9+
         qq7mjPnO3pdeMQOCGxNnY3qXgwaJivL5TgBTAMlzsNrkkIxWeSG4ATUo9p1VUmThc/r1
         MjlXON6xw9r0oiU6S4LwFcamPjJXoeKhyUjEPrGus7fKZ0EEaAhCnbwWyoIDlrlbSTwH
         ym7Q==
X-Gm-Message-State: AOJu0YzSqxdiN3O5rg5/1CH/WMbwNbRJRINJnqlysvPsrMvrEkUrZge6
	nCBHrA1A+Qc73zwOVgbhk8xGstGVzJf2vwTVqXYY+Qfi2fcTDqeDlDdHfQw+hsDFO1PwKtIfEHZ
	CIq7TWzQ=
X-Gm-Gg: AeBDiet/18LZun9YsYMEhCqfMIqLBE3xPyvQbtJg+Kc7GtMQ2P5NL7E4KzjToikqfAv
	EfrygxWxAKrdGIz6ypOFWCWLdUc9WJsvg4q/APKYXTkuNLTZH+KfiFY0xXNecQdWNTlhqFFY0z3
	ghFe7EKCl3Cjwe0BBikJr5yjmGVs3Crt2g2brmdwDF2LtDzVUraOI9I8/1sXV0CIf8AlodmxOI1
	QdwzFTRdk/tPv0d3i5hAsP3oBvKuD2AQYsuDwD9VZC5sWq/HrpVZ4eJRJmnaWvDnUDOgYyZjXrR
	ppE5Aqfc3P6Dc1/nLKae2xYR2BVcoN6WSNhgVj3Ql3zZqENZmPqnxWRvYytNltyUMkOszNqYmYL
	VegxBs2fCPQp/cBCBFk57D8r+XZtcQmloNT+S+E2y6pmLmFelVruym1JA1jQDh4aah6XWDqk4m8
	eb33XDqxT07nUxy1r84zwDTppIsKrhmdw98mTNUE6tB/WTvgZ/tBLFM7SeNyZ3v1Q=
X-Received: by 2002:a05:600c:6990:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48a597021eamr149637445e9.4.1776980654466;
        Thu, 23 Apr 2026 14:44:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2813:1dbe:9c2b:249b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm466703225e9.3.2026.04.23.14.44.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:44:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/2] schedulers: Add wrynose scheduled jobs
Date: Thu, 23 Apr 2026 22:44:12 +0100
Message-ID: <20260423214412.2387367-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423214412.2387367-1-richard.purdie@linuxfoundation.org>
References: <20260423214412.2387367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 21:44:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3782

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 schedulers.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index ee8887d3..67fdd39d 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -656,16 +656,16 @@ schedulers.append(sched.Nightly(name='nightly-metrics-dunfell', branch='dunfell'
 schedulers.append(sched.Nightly(name='nightly-metrics-kirkstone', branch='kirkstone', properties=parent_default_props('metrics', 'kirkstone'), builderNames=['metrics'], hour=6, minute=15, codebases = {'' : {'branch' : 'kirkstone'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-scarthgap', branch='scarthgap', properties=parent_default_props('metrics', 'scarthgap'), builderNames=['metrics'], hour=6, minute=30, codebases = {'' : {'branch' : 'scarthgap'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-whinlatter', branch='whinlatter', properties=parent_default_props('metrics', 'whinlatter'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'whinlatter'}}))
-schedulers.append(sched.Nightly(name='nightly-metrics-walnascar', branch='walnascar', properties=parent_default_props('metrics', 'walnascar'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
+schedulers.append(sched.Nightly(name='nightly-metrics-wrynose', branch='wrynose', properties=parent_default_props('metrics', 'wrynose'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=15))
 schedulers.append(sched.Nightly(name='nightly-metrics-gitstats', branch='master', properties=parent_default_props('metrics-gitstats'), builderNames=['metrics-gitstats'], hour=4, minute=0))
 
-# Run check-layer-nightly twice a week for whinlatter
-schedulers.append(sched.Nightly(name='nightly-check-layer-whinlatter', properties=parent_default_props('check-layer-nightly', 'whinlatter'),
-                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'whinlatter'}}))
-# Run meta-oe-mirror twice a month for whinlatter
-schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-whinlatter', properties=parent_default_props('meta-oe-mirror', 'whinlatter'),
-                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'whinlatter'}}))
+# Run check-layer-nightly twice a week for wrynose
+schedulers.append(sched.Nightly(name='nightly-check-layer-wrynose', properties=parent_default_props('check-layer-nightly', 'wrynose'),
+                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
+# Run meta-oe-mirror twice a month for wrynose
+schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-wrynose', properties=parent_default_props('meta-oe-mirror', 'wrynose'),
+                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
 
 # Run check-layer-nightly twice a week for scarthgap
 schedulers.append(sched.Nightly(name='nightly-check-layer-scarthgap', properties=parent_default_props('check-layer-nightly', 'scarthgap'),
@@ -699,7 +699,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
-            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "whinlatter", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
+            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "wrynose", "whinlatter", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             properties=repos_dict_for_scheduler("docs"),
@@ -712,7 +712,7 @@ def isbitbakeDocFile(change):
             return True
     return False
 schedulers.append(sched.AnyBranchScheduler(name="bitbake-docs-changed",
-            change_filter=util.ChangeFilter(project=["bitbake"], branch=["master", "2.16", "2.10", "2.8", "2.0"]),
+            change_filter=util.ChangeFilter(project=["bitbake"], branch=["master", "2.18", "2.16", "2.10", "2.8", "2.0"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             fileIsImportant=isbitbakeDocFile,
             onlyImportant=True,

