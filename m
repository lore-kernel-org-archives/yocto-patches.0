Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF37C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:55 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1107.1790263611818844938
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Sep 2026 08:26:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KGoOBv6O;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so15028185e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790263610; x=1790868410; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sBcgSDj9Kl+jtRiHC70vIeOIX6vzE5UJ4BpgRQjuBI=;
        b=KGoOBv6O0yDxlesIthWHydycdTi+BQ0gmAQRH4bMSQLJd7DA228T10YTZP87A8CssL
         JcPoIjCjRw9eDNtSguQ6wBONgvGWdyb6N4i7IhVav8oeaN3q6EWEobJT9CbgO7fMU7f0
         UKvZPoIw7fgb2RTyJP27M5YHbG67LPMO3II4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263610; x=1790868410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8sBcgSDj9Kl+jtRiHC70vIeOIX6vzE5UJ4BpgRQjuBI=;
        b=yA4tVuy2evvv5ZfymJDUSjRE6lXfiYkSCks+PzhCsB8GtV7TSyvvj0vMbrWkH9K/fN
         UPYZOFYieLY2fPfHbbKOfJQsUVY+5s6qh9d9lRbtl7c03guVw9Yy/FKXDpBmoW/vty17
         7AKOJRE+Qbsvb+AE9sJYcVX1Kj1FQcTC93K2/rx49Z8p+BzpZEy4Z/gLHeTc5LCUMIUD
         d6XWOsOEPytKyjbfZMs/shcXp0jzFjR7lZqaO2EhylZvaVQHz03GcWNMVc0KfhfCWk1/
         6Z+S0LNddnhGQSbwOO6ehVEwytofnPyUa3yiCOtlyJ27aEO3kbMD9xxzpDqFtEyPRlSs
         M4TQ==
X-Gm-Message-State: AFuF++np/nmDI2pWg734d7wiUpUpKW7Na2UIKwDhs6L6XfBc0CTge5QN
	rDhwW6j4dVDARu0Qf7uW5XDiA7PUcFHJvW08qhc22fT8KzthGHMe9+zuErmDnZGh79pdmDvcPVP
	XKDT2ejM=
X-Gm-Gg: AYBFou0Dx1JeYSoa/IWvNiq4Th9SqiGQugXpH0y4vZJcyxIP/ZWxWIx72xaPExdMScg
	nKKTPzf5IUsdYKTETomE+96cqc+4CVry3c2+8ykO4SkWIovLaSTdrVdC6AVBs4AR9rR6C5Plep/
	2WfzJh4EFl6t/xqr9RXnp0grxM6I0GtWPbm5pBnVSKTuHWH3aZALcFx4diWNG8YxmXzbWl3Dnxu
	Wu+OP08zkcpBu6r8RBk9lkqRDdVYhp0JBhlLt8wSl/h1Uw9mJ/6ns5zHpJAMP4fPY5JKZLZRQ+N
	nlifHumrG5AjWbNZx1UFls8GWAHW8nxA/YzbQWxY3mNeZSPacJMMGfjI7yl0G/bJN1SVbI8YRXm
	4QKgKU/QAH9RyuBI0Hhbdn45D3egI2qQ4MHkiEayWjBmAV4PXSPRve3RqYveTBXpDkE2m3nYUlx
	b5iCLp3w61DtWAOvmBEWmQAMzDmhXp3uUZUmpNaVdZK3MyGloGIhpfjAayYCeUU82c+As4eLju8
	2n6dKHCVOuiXHBgBFio9bBwXQ==
X-Received: by 2002:a05:600c:a47:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49fe66abc9cmr47596975e9.6.1790263609531;
        Thu, 24 Sep 2026 08:26:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d896:f63e:1133:71e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm141501975e9.2.2026.09.24.08.26.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:26:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config/schedlers: Add blacksail release entries
Date: Thu, 24 Sep 2026 16:26:42 +0100
Message-ID: <20260924152642.1090161-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 15:26:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4954

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py     |  1 +
 schedulers.py | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 4cd8cb1a..09736b8f 100644
--- a/config.py
+++ b/config.py
@@ -204,6 +204,7 @@ all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
 # Worker filtering for older releases
 workers_prev_releases = {
+    "blacksail" : ("alma8", "alma9", "alma10", "debian11", "debian12", "debian13", "fedora43", "fedora44", "opensuse156", "opensuse160", "rocky8", "rocky9", "rocky10", "stream9", "stream10", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "ubuntu2604", "perf-"),
     "wrynose" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora42", "fedora43", "opensuse156", "opensuse160", "rocky8", "rocky9", "stream9", "stream10", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "ubuntu2604", "perf-"),
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
diff --git a/schedulers.py b/schedulers.py
index 54136768..5497eb9a 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -73,6 +73,14 @@ branchdefaults = {
         'branch_meta-openembedded': 'master',
         'branch_oecore': 'master',
     },
+    'blacksail': {
+        'branch': 'blacksail',
+        'branch_bitbake': '2.20',
+        'branch_meta-mingw': 'blacksail',
+        'branch_meta-yocto': 'blacksail',
+        'branch_oecore': 'blacksail',
+        'branch_yocto-docs': 'blacksail',
+    },
     'wrynose': {
         'branch': 'wrynose',
         'branch_bitbake': '2.18',
@@ -581,7 +589,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "wrynose", "wrynose-nut", "whinlatter", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "blacksail", "wrynose", "wrynose-nut", "whinlatter", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",
@@ -680,9 +688,17 @@ schedulers.append(sched.Nightly(name='nightly-metrics-kirkstone', branch='kirkst
 schedulers.append(sched.Nightly(name='nightly-metrics-scarthgap', branch='scarthgap', properties=parent_default_props('metrics', 'scarthgap'), builderNames=['metrics'], hour=6, minute=30, codebases = {'' : {'branch' : 'scarthgap'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-whinlatter', branch='whinlatter', properties=parent_default_props('metrics', 'whinlatter'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'whinlatter'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-wrynose', branch='wrynose', properties=parent_default_props('metrics', 'wrynose'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
+schedulers.append(sched.Nightly(name='nightly-metrics-blacksail', branch='blacksail', properties=parent_default_props('metrics', 'blacksail'), builderNames=['metrics'], hour=5, minute=15, codebases = {'' : {'branch' : 'blacksail'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=15))
 schedulers.append(sched.Nightly(name='nightly-metrics-gitstats', branch='master', properties=parent_default_props('metrics-gitstats'), builderNames=['metrics-gitstats'], hour=4, minute=0))
 
+# Run check-layer-nightly twice a week for blacksail
+schedulers.append(sched.Nightly(name='nightly-check-layer-blacksail', properties=parent_default_props('check-layer-nightly', 'blacksail'),
+                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'blacksail'}}))
+# Run meta-oe-mirror twice a month for blacksail
+schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-blacksail', properties=parent_default_props('meta-oe-mirror', 'blacksail'),
+                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'blacksail'}}))
+
 # Run check-layer-nightly twice a week for wrynose
 schedulers.append(sched.Nightly(name='nightly-check-layer-wrynose', properties=parent_default_props('check-layer-nightly', 'wrynose'),
                   builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
@@ -722,7 +738,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
-            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "wrynose", "whinlatter", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
+            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "blacksail", "wrynose", "whinlatter", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             properties=repos_dict_for_scheduler("docs"),

