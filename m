Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B1105F7B3
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:53 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16492.1773410447078154409
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 07:00:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=w1lULTqE;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso33327045e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773410445; x=1774015245; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcw6daHZZoYOgOoqJLtnQHtNbj3ABwzvZ7CtYLPGJW4=;
        b=w1lULTqENlqwdap2A9YVDsyGWQPWQdpaxbtW8DfSZ+LDY5noLB8H8zfx3Mw3npv0HB
         eJP2BkCcts8wHbD3uYz42Jie1FqYmkDBEoii4qgS+NxTuf8MJeTXRgfbseleErIJIrnm
         r6U/4H3icA9UU7LoxWpWuZLy6KWm35tazUj9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410445; x=1774015245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcw6daHZZoYOgOoqJLtnQHtNbj3ABwzvZ7CtYLPGJW4=;
        b=Kcxqjotx9UAuMi1b5xdYGWPPAUB5vNuEDKxTO5/s9e5tuEIWKZdhtEsETMt3rjN5Xx
         X7m7/M++CN7r3JQkOcHCP3pSsH6TBA1P9Zzw4qg46G74GwpkX1hS4a58GHy2RAYxGrH8
         MUqIS58WsP70ezTHhja3VZ8BeLEliw7R8xZDvB8o3ICxLYFk2uIkuIuMYgnHfkVgbwg7
         AlBIdknKchM6wx8GRXhrW5JzUOEOTFqhsRPnezisxvr4tUkC40En3SPQkv+IzOZdSz9P
         NVcY8NxLCfXS8KvQxRHJ7UXU1PRFsY8qz5wVnYfy7D+jCLB/dDgP2naUtyGzviHULB1H
         A47A==
X-Gm-Message-State: AOJu0YxqPsso90m+N+xqj22yOJLvDTU5gCxaJGAI3l3x8KxuJvhdHcdp
	ojQfEdFQ5q7nWnpvsKKxLyO5hjRf5D97EgiWax4vqSt59Y0aSnbrIjM/6G6CCNGeGYsbQOezPFM
	93vvy
X-Gm-Gg: ATEYQzyt5fhR0kTocvEPZHWSXUC/ffQgBkcvmdk872Cq9Q1z6uXO1q+THVnvosQo1F9
	9NCWLWGObs3MWfkTQPYNyJMMJkLrgDnqNCq7HuN1XK5efahZP+ZGCj2htaDgMwvhGsbJzbqUK5C
	I+BLv4/IRxMpv8jrJfBw0mqaoQlkquXVGhizaJXOiaZZdsd5NzxH0R/IY9vZGPfdFC9GUJojCKl
	bfw1K6nGCQDneShDlQSiCPI+LY8bMcooGnVm7tXjHhrMcnSZtD5JDeYiaDeH0k2tvu25cY+TdWz
	rK9slYrUEfTFK8asjo3JqPL2eN/dRlUeO2h384wPMknuEoJWoysXuhdTq5PbwLI9MjlLi95yPFA
	IPSSrWkwOmQBNcALx3JAY1nP7W+pkYBmbKQheeOTUQZ2RBN2wc4LgommDa8LJdO+FsoNiB8uzVO
	chFCUkMeBB6Wc5z5lIn2dUTMSX2vijO9lKTJuAYBGKAqavx1ecqGIxfnySy8rBprkWa/nGpyvJo
	SdQN35XBlk3zth0OTdwpjK2qZfR
X-Received: by 2002:a05:600c:17d2:b0:485:3f1c:d89b with SMTP id 5b1f17b1804b1-4854f561c44mr83395695e9.4.1773410445023;
        Fri, 13 Mar 2026 07:00:45 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa001ac8ae6baecd7e1d.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:1ac8:ae6b:aecd:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2db487sm2056109f8f.28.2026.03.13.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:00:44 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH 1/4] dashboard/bugtriage: Re-order Wrong Milestone above Old bugs
Date: Fri, 13 Mar 2026 15:00:26 +0100
Message-ID: <20260313140029.805927-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 14:00:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3454

From: Yoann Congal <yoann.congal@smile.fr>

This should match the bug triage meeting order.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Cc: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 10d998d..8e2d3a0 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -119,6 +119,15 @@
         <div id="needinfo"></div>
       </div>
 
+      <div class="section scrollspy" id="oldmilestone-container">
+        <h4>Wrong Milestone <a class="waves-effect btn-flat" onclick="reloadTable('#oldmilestone');"><i class="material-icons">refresh</i></a></h4>
+        <p>
+          All open bugs that are targetted for a milestone in the past: they
+          should be closed if fixed, or moved to a future milestone.
+        </p>
+        <div id="oldmilestone"></div>
+      </div>
+
       <div class="section scrollspy" id="inactivebugs-container">
         <h4>Inactive Bugs <a class="waves-effect btn-flat" onclick="reloadTable('#inactivebugs');"><i class="material-icons">refresh</i></a></h4>
         <p>
@@ -135,15 +144,6 @@
         <div id="inactivefeatures"></div>
       </div>
 
-      <div class="section scrollspy" id="oldmilestone-container">
-        <h4>Wrong Milestone <a class="waves-effect btn-flat" onclick="reloadTable('#oldmilestone');"><i class="material-icons">refresh</i></a></h4>
-        <p>
-          All open bugs that are targetted for a milestone in the past: they
-          should be closed if fixed, or moved to a future milestone.
-        </p>
-        <div id="oldmilestone"></div>
-      </div>
-
       <div class="section scrollspy" id="newcomer-container">
         <h4>Potential Newcomer <a class="waves-effect btn-flat" onclick="reloadTable('#newcomer');"><i class="material-icons">refresh</i></a></h4>
         <p>
@@ -170,9 +170,9 @@
         <li><a href="#reopened-container">Reopened</a></li>
         <li><a href="#abint-container">AB-INT</a></li>
         <li><a href="#needinfo-container">Need Info</a></li>
+        <li><a href="#oldmilestone-container">Wrong Milestone</a></li>
         <li><a href="#inactivebugs-container">Old Bugs</a></li>
         <li><a href="#inactivefeatures-container">Old Features</a></li>
-        <li><a href="#oldmilestone-container">Wrong Milestone</a></li>
         <li><a href="#newcomer-container">Newcomer</a></li>
         <li><a href="#retest-container">Retest</a></li>
       </ul>

