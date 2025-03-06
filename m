Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD436C282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 12:50:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.12302.1741265444794799281
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Mar 2025 04:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Kq728NsP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f403edb4eso356209f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741265443; x=1741870243; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M82MJpcSz+F9OOdu/6/Xyqfxco7FdqqiIGOBXUkwpU8=;
        b=Kq728NsPsqhsfvEVb52p5h4GN6Z1HLwdNM8r1qYgdE5OrujLPiuMGuc+XhikdS983C
         GohOJMWIaI1K5/9FZG1j3vC38HKp2ZgOHomc4++9OsSahx9nkMhsNo5HVNkEqnHI49OV
         5JKzQ/+65TBJIGRkw4WvLWblE7W0fecP737l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265443; x=1741870243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M82MJpcSz+F9OOdu/6/Xyqfxco7FdqqiIGOBXUkwpU8=;
        b=W+iRQRp0gVRd9Rg/YJnQ08vz2NVJhHrAj8HtDzoHcpqxdpuaU26xHaAXxH8YI+dxkF
         XowfXzXgpA4xJseooItlrUm2b8ybkonjLVyr8Xjqg1s2Tge2v3/xy+OLRMeWuhAFKCSV
         5D8Ii/ZarHxKmWwZ5x3i5vyK51K0r2xf1v5QRwhdr9nFEBYcfJcfBu/woxVAZzG8SEyo
         rh87xPsWUsA2vA2y9Gej4IZGsKBKvF1icrbOnjWUNNzw/6u3wAHSF4tNcRMh5wWBtkBs
         L3d4VIyEdrRgCZZzlVIVQvqlNeg7LNib2+fsQaXJ4vqmQIrIyEjskh0Q9XOrfOIg8BY1
         zl6A==
X-Gm-Message-State: AOJu0YxDBrsbmgbdZawJAyk7JyOVAfbylgxVP1R1ps97fgGaV84+Z7cH
	lE9FSwhTzkDHKW36zWq+ZmGu298K6zlLuX0eSS6kGApJ7T6NnHeHSvwNLRhcEnAyaDv1URRz21y
	j
X-Gm-Gg: ASbGnctnh+jOvZRZ6ICfpez1UbRZ3NNKfrFmsyZ1/e5PV+DRLKH8sOpfr1e0haSCzMG
	3Rt+n+cL8uWw6Mrt/46Q2L7k+zu2Mq8DURSGrTLFdHkYsusYBNweO6O0T8yGi4EPArIv+oC9tlc
	+HWK6b9bcv9s+3jfldTRazzbYpwatXI3+1Q9IPNHhgo1TqYcRSxSriNLvJfzKEQ4kz6NDS/wz9E
	EqdZTUpJ8wsl4v8x7wm9w9iuzfRVDxOBhpjjnaflG9/6mUSXVvFuTJFsGUhvuWBM//pUAUhYyux
	mACReQqe88GraX6GbUYq68xXYCr/cLrbMnXVsD1z0Ehbr48U8u2ABgi7ri216ZtfXubbN8G4Dw=
	=
X-Google-Smtp-Source: AGHT+IH23HKHUO3MbRbPQ3zVGM6YN29Lw9k8dvINgRH48QIHst/oFBEWUWH+kU0OMYVjfD1ob7N/6g==
X-Received: by 2002:a05:6000:184d:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-3911f7c3d8cmr5726180f8f.42.1741265442547;
        Thu, 06 Mar 2025 04:50:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e869:4c46:3bba:1ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1955126f8f.3.2025.03.06.04.50.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:50:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] builders: Avoid giving jobs to workers that already have them
Date: Thu,  6 Mar 2025 12:50:41 +0000
Message-ID: <20250306125041.2399638-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 12:50:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1159

When giving jobs to workers, we want to prioritise idle ones and only
give them to the busiest ones when there are no others free.

This isn't entirely straight forward as there is no "idle" attribute
for workers but we can use a query and work it out.

Includes fixes from Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 builders.py | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/builders.py b/builders.py
index 81b74ad3..667e491a 100644
--- a/builders.py
+++ b/builders.py
@@ -9,6 +9,7 @@ from yoctoabb.steps.writelayerinfo import WriteLayerInfo
 from yoctoabb.steps.runconfig import get_publish_dest, get_publish_resultdir, get_publish_name, RunConfigCheckSteps, TargetPresent
 from buildbot.process.results import Results, SUCCESS, FAILURE, CANCELLED, WARNINGS, SKIPPED, EXCEPTION, RETRY
 from buildbot.process.remotecommand import RemoteCommand
+from buildbot.data import resultspec
 
 from twisted.python import log
 from twisted.internet import defer
@@ -150,6 +151,7 @@ def create_builder_factory():
 
     return f
 
+@defer.inlineCallbacks
 def nextWorker(bldr, workers, buildrequest):
     forced_worker = buildrequest.properties.getProperty("worker", "*")
     possible_workers = list(workers)
@@ -170,7 +172,33 @@ def nextWorker(bldr, workers, buildrequest):
                 break
 
     if forced_worker == "*":
-        return random.choice(possible_workers) if possible_workers else None
+        # Query running builds so we can push builds away from those already running the most
+        builds = yield bldr.master.data.get(
+            ('builds',),
+            [resultspec.Filter('complete', 'eq', [False])],
+        )
+
+        active = {}
+        maxbuilds = 0
+        for build in builds:
+            if build['workerid'] not in active:
+                active[build['workerid']] = 1
+            else:
+                active[build['workerid']] += 1
+                if maxbuilds > active[build['workerid']]:
+                    maxbuilds = active[build['workerid']]
+
+        random.shuffle(possible_workers)
+
+        for worker in possible_workers:
+            if worker.worker.workerid not in active:
+                return worker
+        for i in range(maxbuilds):
+            for worker in possible_workers:
+                if active[worker.worker.workerid] == i:
+                    return worker
+
+        return None
     for w in possible_workers:
         if w.worker.workername == forced_worker:
             return w

