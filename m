Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D4AD2E03D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:56:19 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.5094.1729677376828807703
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 02:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Ms4sFhqI;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE0E9E000E;
	Wed, 23 Oct 2024 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729677375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A/9LPjMgIrR6C+pUY6ekTCKxhYJ7dmAry3rQcwzWhAA=;
	b=Ms4sFhqIMxUpbDPqJ7kgwznj5gkqz5qmCFp8G5+4VBjxmqeAmB0rHVYQCLXOjIyV4yC6CN
	HPLLvIoAamZaWa1iG0Ovbps60Wxh0pWzG4A651L/rPMdJ+pFYIt8AaVPLkIoyZ20Qx2nCz
	r52sjkWhRzno3GXKFRBPvfBOEtgsLckyeOWtHlBTgynXfgExuLkb6WJHe0TXJyLcblr4+k
	EuJmDNa578kq/vocx/LCSmTzqXz1I+ffWzOfAHjuTXv+lZjMaZo+Ed/ZTJOYbELq2EpKh4
	DmlKsVn2kmZyR3EOmt0dE1cyq2v49I1gM89sgv07oorU1RiNf3AIUrRmCMeijQ==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] Fix docs builder with custom branches
Date: Wed, 23 Oct 2024 11:55:16 +0200
Message-Id: <20241023095516.3945437-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 09:56:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/728

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

While most of the builds on the autobuilder rely on the
shared-repo-unpack helper script and do not use the Buildbot codebases,
the "docs" builder use Buildbot traditional way to setup sources. As a
consequence, we have to use Buildbot codebases, otherwise the same
branch name is used for all cloned repos.

Add the codebase specifications for all three repos used by the docs
builder. Also remove them from the repos list, as these fields are not
used.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py   |  3 +++
 config.py     |  2 +-
 schedulers.py | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builders.py b/builders.py
index 431744ac275a..ced47def9961 100644
--- a/builders.py
+++ b/builders.py
@@ -382,6 +382,7 @@ def create_doc_builder_factory():
     f.addStep(steps.Git(
         repourl=config.repos["yocto-autobuilder-helper"][0],
         branch=config.repos["yocto-autobuilder-helper"][1],
+        codebase='yocto-autobuilder-helper',
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
         haltOnFailure=True,
@@ -389,6 +390,7 @@ def create_doc_builder_factory():
     f.addStep(steps.Git(
         repourl=config.repos["yocto-docs"][0],
         branch=config.repos["yocto-docs"][1],
+        codebase='yocto-docs',
         workdir=util.Interpolate("%(prop:builddir)s/yocto-docs"),
         mode='incremental',
         haltOnFailure=True,
@@ -396,6 +398,7 @@ def create_doc_builder_factory():
     f.addStep(steps.Git(
         repourl=config.repos["bitbake"][0],
         branch=config.repos["bitbake"][1],
+        codebase='bitbake',
         workdir=util.Interpolate("%(prop:builddir)s/bitbake"),
         mode='incremental',
         haltOnFailure=True,
diff --git a/config.py b/config.py
index 7230a5ffbd42..158cc5f2e2ab 100644
--- a/config.py
+++ b/config.py
@@ -27,7 +27,7 @@ buildertorepos = {
     "checkuri": ["poky"],
     "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
     "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein"],
-    "docs": ["yocto-docs", "bitbake"],
+    "docs": [],
     "reproducible-meta-oe": ["poky", "meta-openembedded"],
     "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
     "meta-oe-mirror":  ["poky", "meta-openembedded"],
diff --git a/schedulers.py b/schedulers.py
index ec3a085ace8a..64f082c6d562 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -315,7 +315,7 @@ def repos_for_builder(buildername):
 
     parameters = []
     repos = config.buildertorepos.get(buildername)
-    if not repos:
+    if repos is None:
         repos = config.buildertorepos["default"]
     for repo in repos:
         inputs = create_repo_inputs(repo)
@@ -497,6 +497,16 @@ schedulers.append(parent_scheduler("a-full"))
 schedulers.append(sched.ForceScheduler(
         name="docs",
         builderNames=["docs"],
+        codebases=[util.CodebaseParameter(codebase='yocto-autobuilder-helper',
+                                          label="yocto-autobuilder-helper:",
+                                          project=None),
+                   util.CodebaseParameter(codebase='yocto-docs',
+                                          label="yocto-docs:",
+                                          project=None),
+                   util.CodebaseParameter(codebase='bitbake',
+                                          label="bitbake:",
+                                          project=None),
+                   ],
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the docs build:""",
@@ -571,7 +581,7 @@ schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', prop
 # If any of our sphinx docs branches change, trigger a build
 schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
             change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
-            codebases = ['', 'yocto-docs', 'bitbake'],
+            codebases = ['yocto-autobuilder-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
             builderNames=["docs"]))
 
-- 
2.39.5


