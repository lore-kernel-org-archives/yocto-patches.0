Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A592AD10F2F
	for <webhook@archiver.kernel.org>; Sun, 17 Nov 2024 20:41:52 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.25884.1731876110270223112
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Nov 2024 12:41:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L7H/xE1t;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38233152c8fso90933f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731876108; x=1732480908; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M40cu4B7ijwbB66p8JmJyH9o7H0vJ2YEALdwh8rmK0A=;
        b=L7H/xE1tapavInnfqiB6GPJLCfC7KeHMXv2NxzeVnSQOBJ52QlZo3EQkzi1479RNMk
         KzeDeq90yLru4H+bw2UVYPBf+7i58njwk1c7QcV2LtJq4FsVQtVj52p7y4c5OIIl4eEu
         RKGrG6VBZU7s4OO0NB/rZ41dFth56ZujN5H+p5KryubX0s+VdZXR2xabWCD1HIseLi8R
         ZXxeXLtaUh1QJt7TxcOsqtONXoLlOPaMal7HFPVEoRgXPBHVCpXIAmlN8ICKf/cAyq9V
         chQsKRFmEeD+VH29SorhrKB77aoCSITKvAJe79Km/v85MDA8Vs2hP6iBdPXozDhnp6Om
         GlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731876108; x=1732480908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M40cu4B7ijwbB66p8JmJyH9o7H0vJ2YEALdwh8rmK0A=;
        b=Ne1KLLnTTe2tLtQWCKUIO/syrxTmrM2YSOd2rOQ9YPgtxa2foQt8PqqKAe6TNcCWMt
         At1fdU82qCFmKPKMFNODjqt1inVKakj6bwpindx+lcFjcAr3Egpo7DMb5sE0K0mAIz0w
         ACR+yXLR1R0qR2sZX+41tdZ4OHxZdfxBEa6STZWJ3yR7cvVr8W6p/3nboYeTpJtEjkva
         EG/j+XTUr/xeblqlVu/XrVaBb59RmpbnPZxoYGw4iIP6i5kRzRS4scPD5RXGvOwUqTFB
         aW2awcUuLyNlnFd7Mz6c5JQmAejcT/yRf3PnPEjZddYCFO+YqvhAPDsMAFcBvttIv8Uf
         HJbA==
X-Gm-Message-State: AOJu0YzK33yoDdquXKTmFNriEkEpt9iR4ggHbDQOJKN4R7/lqABa97dc
	wykFIKkRhrSoIcercGcugLx1o+hSJZIq2jdn/15EdVh2YFaDZpaIFurWyqLk
X-Gm-Gg: ASbGncsAxMgQNG6xH8zIrZU0wXAWyg5YWcnP0VU2U5Gncel7yINwaDNHxKti+Az7I6H
	mx8EpmZqTgP/d37xCsA7xAcjszXPrOvGvFNe+KfjGjSQ32aNw3d+Nl6bfeJMmFvYlSrnQiCiJph
	2/0isLpXZJ/sU2XMeEsaOSrAWKwqULqm3dUM70EiigXdwOpXJ7GGLTBTHMDXW+LS+NYxj9eWGkd
	RHwLidwQcI9kZO6+sR0VP3/Ns87oxM7JRmQgQgF5oZp4DZo64rO0o51eFmw
X-Google-Smtp-Source: AGHT+IH2s8UpRIuqsJSsqngQ4LVAU6qPzS4yxb1JRlJ7xPk2mic70/w76UT1FH4w/fjkDOwDIO+NLA==
X-Received: by 2002:a05:600c:2318:b0:42c:bfd6:9d1f with SMTP id 5b1f17b1804b1-432df71af6emr36149365e9.1.1731876107411;
        Sun, 17 Nov 2024 12:41:47 -0800 (PST)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2658a8sm136607955e9.9.2024.11.17.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 12:41:46 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Thibaud Dufour <thibaudd@rtone.fr>,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [poky] [kirkstone] [BACKPORT 1/3] bitbake: runqueue: Improve inter setscene task dependency handling
Date: Sun, 17 Nov 2024 21:41:16 +0100
Message-ID: <20241117204118.3405309-2-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
References: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 20:41:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/812

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The way the code currently handles dependencies between setscene tasks is fairly
poor, basically by deleting chunks of dependencies and adding reversed dependency
relationships.

This was once the best way to handle things but now a lot of the surrounding code
has changed and this approach is suboptimal and can be improved.

This change firstly adds debug logging for "hard" setscene task dependencies since
previously the codepaths were missing from logs making them very hard to read.

The changes to the setscene dependency graph are removed entirely this these altered
graphs were a significant source of problems. Instead, if a hard dependency is run
into, we mark the hard dependency as buildable and defer the task until the hard
dependencies are met.

The code now also skips the check_dependencies() code for hard dependencies since
previously that code was having to list all possible hard dependencies. We don't
need to do that as we can safely assume hard dependencies are required.

With these changes to runqueue's behaviour, we stand some chance of being able to
fix other bugs in OE-Core related to useradd for example.

(Bitbake rev: 367789b53c1c22ec26e0f4836cdf2bdd9c7d84fa)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Thibaud Dufour <thibaudd@rtone.fr>
Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 42 ++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0b6eddd45c..b0cd15d323 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1787,6 +1787,7 @@ class RunQueueExecute:
         self.build_stamps2 = []
         self.failed_tids = []
         self.sq_deferred = {}
+        self.sq_needed_harddeps = set()
 
         self.stampcache = {}
 
@@ -2104,7 +2105,10 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
+                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
+                            nexttask not in self.sq_needed_harddeps and \
+                            self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
+                            self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
                             logger.debug2("Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
@@ -2112,6 +2116,18 @@ class RunQueueExecute:
                             if nexttask in self.sq_deferred:
                                 del self.sq_deferred[nexttask]
                             return True
+                    if nexttask in self.sqdata.sq_harddeps_rev and not self.sqdata.sq_harddeps_rev[nexttask].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                        logger.debug2("Deferring %s due to hard dependencies" % nexttask)
+                        updated = False
+                        for dep in self.sqdata.sq_harddeps_rev[nexttask]:
+                            if dep not in self.sq_needed_harddeps:
+                                logger.debug2("Enabling task %s as it is a hard dependency" % dep)
+                                self.sq_buildable.add(dep)
+                                self.sq_needed_harddeps.add(dep)
+                                updated = True
+                        if updated:
+                            return True
+                        continue
                     # If covered tasks are running, need to wait for them to complete
                     for t in self.sqdata.sq_covered_tasks[nexttask]:
                         if t in self.runq_running and t not in self.runq_complete:
@@ -2532,8 +2548,8 @@ class RunQueueExecute:
         update_tasks2 = []
         for tid in update_tasks:
             harddepfail = False
-            for t in self.sqdata.sq_harddeps:
-                if tid in self.sqdata.sq_harddeps[t] and t in self.scenequeue_notcovered:
+            for t in self.sqdata.sq_harddeps_rev[tid]:
+                if t in self.scenequeue_notcovered:
                     harddepfail = True
                     break
             if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
@@ -2564,12 +2580,13 @@ class RunQueueExecute:
 
         if changed:
             self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
+            self.sq_needed_harddeps = set()
             self.holdoff_need_update = True
 
     def scenequeue_updatecounters(self, task, fail=False):
 
-        for dep in sorted(self.sqdata.sq_deps[task]):
-            if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+        if fail and task in self.sqdata.sq_harddeps:
+            for dep in sorted(self.sqdata.sq_harddeps[task]):
                 if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
                     # dependency could be already processed, e.g. noexec setscene task
                     continue
@@ -2579,6 +2596,7 @@ class RunQueueExecute:
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
+        for dep in sorted(self.sqdata.sq_deps[task]):
             if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
                 if dep not in self.sq_buildable:
                     self.sq_buildable.add(dep)
@@ -2714,6 +2732,7 @@ class SQData(object):
         self.sq_revdeps = {}
         # Injected inter-setscene task dependencies
         self.sq_harddeps = {}
+        self.sq_harddeps_rev = {}
         # Cache of stamp files so duplicates can't run in parallel
         self.stamps = {}
         # Setscene tasks directly depended upon by the build
@@ -2835,6 +2854,8 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         realtid = tid + "_setscene"
         idepends = rqdata.taskData[mc].taskentries[realtid].idepends
         sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", rqdata.dataCaches[mc], taskfn, noextra=True)
+
+        sqdata.sq_harddeps_rev[tid] = set()
         for (depname, idependtask) in idepends:
 
             if depname not in rqdata.taskData[mc].build_targets:
@@ -2847,20 +2868,15 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             if deptid not in rqdata.runtaskentries:
                 bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
 
+            logger.debug2("Adding hard setscene dependency %s for %s" % (deptid, tid))
+
             if not deptid in sqdata.sq_harddeps:
                 sqdata.sq_harddeps[deptid] = set()
             sqdata.sq_harddeps[deptid].add(tid)
-
-            sq_revdeps_squash[tid].add(deptid)
-            # Have to zero this to avoid circular dependencies
-            sq_revdeps_squash[deptid] = set()
+            sqdata.sq_harddeps_rev[tid].add(deptid)
 
     rqdata.init_progress_reporter.next_stage()
 
-    for task in sqdata.sq_harddeps:
-        for dep in sqdata.sq_harddeps[task]:
-            sq_revdeps_squash[dep].add(task)
-
     rqdata.init_progress_reporter.next_stage()
 
     #for tid in sq_revdeps_squash:
-- 
2.47.0


