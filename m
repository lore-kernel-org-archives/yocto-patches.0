Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C1C3ABC5
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 19:46:07 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.35107.1746992756575641423
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 May 2025 12:45:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=QPpYMtCh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-2025051119455294cf048fc9517bc949-o1s4qx@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025051119455294cf048fc9517bc949
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 May 2025 21:45:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SbBvWBj+yb2s31POJ2ztSvaRldcq20UGAYoAF4rubvI=;
 b=QPpYMtChqK389zf9qRfGWmycfN+iedY0EoseVXg+iqz2Mt3Va4sHAw2/GCPckftVL/ArB+
 42q7PCrVCZBUYgZvoCNZw7Ufr4G3+YbzbOvipHwBZsfWiVrPO0BeioB1yGEpDXkdklqf+ptU
 ZQw/FhvXfWtoFIObd8a/8ulPHEr79HW0fS8MhUWmovGCd/+zLCMVNxJJLpkZZQmzy3WcajRX
 U6yyyqyCB38oilCF2O/Z3iRVeoV5o3Ub6Gq9NX8HyBxTTRp+UovlbGR3Qr0EjuJYZ1K4caHY
 8UiaSTxsxDPZLIO4YcGvKwbqt1CsoKD3SbFTp9rjWSd+8VjNYezQaYdw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: add walnascar jobs
Date: Sun, 11 May 2025 21:45:06 +0200
Message-Id: <20250511194506.3716103-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 May 2025 19:46:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1543

From: Peter Marko <peter.marko@siemens.com>

* add metrics job (which also shifts master job by 15 minutes)
* replace weekly/monthly styhead jobs by walnascar
* add docs job

This should make walnascar to have the same jobs as styhead before this
patch and to scarthgap.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 schedulers.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 9916d8b..56b38ec 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -579,15 +579,16 @@ schedulers.append(sched.Nightly(name='nightly-metrics-dunfell', branch='dunfell'
 schedulers.append(sched.Nightly(name='nightly-metrics-kirkstone', branch='kirkstone', properties=parent_default_props('metrics', 'kirkstone'), builderNames=['metrics'], hour=6, minute=15, codebases = {'' : {'branch' : 'kirkstone'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-scarthgap', branch='scarthgap', properties=parent_default_props('metrics', 'scarthgap'), builderNames=['metrics'], hour=6, minute=30, codebases = {'' : {'branch' : 'scarthgap'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-styhead', branch='styhead', properties=parent_default_props('metrics', 'styhead'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'styhead'}}))
-schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=0))
+schedulers.append(sched.Nightly(name='nightly-metrics-walnascar', branch='walnascar', properties=parent_default_props('metrics', 'walnascar'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
+schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=15))
 schedulers.append(sched.Nightly(name='nightly-metrics-gitstats', branch='master', properties=parent_default_props('metrics-gitstats'), builderNames=['metrics-gitstats'], hour=4, minute=0))
 
-# Run check-layer-nightly twice a week for styhead
-schedulers.append(sched.Nightly(name='nightly-check-layer-styhead', properties=parent_default_props('check-layer-nightly', 'styhead'),
-                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'styhead'}}))
-# Run meta-oe-mirror twice a month for styhead
-schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-styhead', properties=parent_default_props('meta-oe-mirror', 'styhead'),
-                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'styhead'}}))
+# Run check-layer-nightly twice a week for walnascar
+schedulers.append(sched.Nightly(name='nightly-check-layer-walnascar', properties=parent_default_props('check-layer-nightly', 'walnascar'),
+                  builderNames=['check-layer-nightly'], dayOfWeek=[1, 4], hour=2, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
+# Run meta-oe-mirror twice a month for walnascar
+schedulers.append(sched.Nightly(name='nightly-meta-oe-mirror-walnascar', properties=parent_default_props('meta-oe-mirror', 'walnascar'),
+                  builderNames=['meta-oe-mirror'], dayOfMonth=[3, 17], hour=2, minute=0, codebases = {'' : {'branch' : 'walnascar'}}))
 
 # Run check-layer-nightly twice a week for scarthgap
 schedulers.append(sched.Nightly(name='nightly-check-layer-scarthgap', properties=parent_default_props('check-layer-nightly', 'scarthgap'),
@@ -621,7 +622,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
-            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
+            change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "walnascar", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             properties=repos_dict_for_scheduler("docs"),

