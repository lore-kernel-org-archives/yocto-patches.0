Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BDECF5395
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 14:25:42 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.10476.1729693534735329564
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 07:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=kQw9keS9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA68E1BF205;
	Wed, 23 Oct 2024 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729693532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HNy4xoWJOdCU6ZNAxOrBuApWRoVGd/B8+ayarhpCKgw=;
	b=kQw9keS9ml9MEF8QN99Kjc9lay9qdD5yn+ei/S8ZrACRz2Rl6PD7u1eYQnrTS9dm9ww2oz
	/PUp4iTo4bOja7RM9PpuJOPtstlef5zK5gPVKpTRkYVSIOakQa3zzIyZyFOELBMtOz4EsF
	1hjlEOyWJHDmQkO9xQU1/pq1HsaBXB+Rhf0Wx6fXMtVbUmIwOSampJ4iu2/h1bVPJR+f0N
	fa/rYlitZw5H4lOEOPPnNnK9mkRgA7J8WTrMVTuiljbiEHB1Gzx1VHW8IgKvrsGxS9jPlF
	QjE2zT5K4ls5DNkuw/1BUvLYJs4tEwjOPoWjGuxSc9YS0+ildaLa8jvD1A4ogQ==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] builders/config: Use a shorter codebase name for docs
Date: Wed, 23 Oct 2024 16:25:07 +0200
Message-Id: <20241023142507.4173847-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 14:25:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/738

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

The introduction of codebases for docs builder changed the git clone
steps internal names, as they are now suffixed with the codebase name.
This new name for the yocto-autobuilder-helper seems to be too long for
the database used on our autobuilder and triggers an exception. Use a
shorter codebase name to fix this issue.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py   | 2 +-
 schedulers.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builders.py b/builders.py
index ced47def9961..55c7d07f6a09 100644
--- a/builders.py
+++ b/builders.py
@@ -382,7 +382,7 @@ def create_doc_builder_factory():
     f.addStep(steps.Git(
         repourl=config.repos["yocto-autobuilder-helper"][0],
         branch=config.repos["yocto-autobuilder-helper"][1],
-        codebase='yocto-autobuilder-helper',
+        codebase='yab-helper',
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
         haltOnFailure=True,
diff --git a/schedulers.py b/schedulers.py
index 114a2389983b..e4266a53d1b8 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -497,7 +497,7 @@ schedulers.append(parent_scheduler("a-full"))
 schedulers.append(sched.ForceScheduler(
         name="docs",
         builderNames=["docs"],
-        codebases=[util.CodebaseParameter(codebase='yocto-autobuilder-helper',
+        codebases=[util.CodebaseParameter(codebase='yab-helper',
                                           label="yocto-autobuilder-helper:",
                                           project=None),
                    util.CodebaseParameter(codebase='yocto-docs',
@@ -581,7 +581,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
             change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
-            codebases = ['yocto-autobuilder-helper', 'yocto-docs', 'bitbake'],
+            codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             builderNames=["docs"]))
 
-- 
2.39.5


