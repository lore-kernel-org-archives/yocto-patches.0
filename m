Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E598E7719E
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 08:37:25 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.12761.1736757438720218781
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Jan 2025 00:37:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RDrPkHMQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A543BC000D;
	Mon, 13 Jan 2025 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736757437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZlXlIHI0QC5tDVUoc+DXU2bLxV81qW07O/5KQ96r0o=;
	b=RDrPkHMQnmUGk9PscudHJlPXuvHs3Av0iNXEAHFkVKH+RIv8fL2HwRIMV17lkZuKIrQg++
	6QgQovG9yT6PV3TapJhytHQHxxvmg7pl5A35XGZ5pxYh9B8xim3WwspGIqDNXWxdRwXq0M
	xc92HNODjeHOMFWLEjcRczVQkDoNZjslUbMBJDsh4OGuDiGvQ18KjEqK1TY7+va/WIVBOt
	Kxdj6begPIRKjxmVU88OtJ7Bn8tu9fbafCaaH+MXBh+4pCyC8G91K0Jzcgdc9xXYh0PtEt
	5qDYkxQDZUGVWOyNzdxbcLdBdlYRxWizQrVd+GcA473hksFX3JBmGnd0tVzLhg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 13 Jan 2025 09:36:41 +0100
Subject: [yocto-autobuilder2][PATCH] Fix overriding of the
 yocto-autobuilder-helper parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-fix-autobuilder-dep-v1-1-52de04667ee5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJjQhGcC/x2M0QpAQBQFf0X32a27NpFfkYdlD24J7SIl/27zO
 DUzD0UERaQmeyjg0qjbmsDkGQ2zWyew+sRUSFGKMcKj3uzOY+tPXTwCe+xcO4itrcBUnlK5ByT
 tv7bd+35/By3hZQAAAA==
X-Change-ID: 20250110-fix-autobuilder-dep-8ae03830e17d
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5652;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=oBGrvnR26udHmYl/d2MuHQn8Cr7Na87dIhJT7Le/szQ=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnhNC7ObQ69G6eomujcNMDe/LK0SrfLMbQ+rdTU
 hdhirhjBbeJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ4TQuwAKCRDRgEFAKaOo
 Nu0UEAClr3GLpYNoWsDuzDJC/ZUb4DIOUSpvzhbkFVv58YNLgLft1B1rosQaSnb7quu15Z/iUqD
 0vCoitT5xU0lDiO1MNIHMEcjEY4Bwn5X7Y/RwttMLa5W4dR2g0yI2Z/RhBnuBlsBujEVU3mKYzd
 /kNLBslf8PR9tICYHByT4WczTWKjLMHVqPu8ukbWkODWsE6e6UmTlGiZgShgW0sKmrR3OjEHFjm
 gSM6bZbb+1vizTr7aEiMmVPtrVd+9seU8b/V2EUKcHTzXDhU7J1P0DA866dp77OvYs/21UoGPIL
 0Mahgf8SWo0fXhyfB0rrxQoOEgFB1zkHW6FBnq2XA3XmQ9m9F4U/+z8hkemPLjV97gOTE3J30Ws
 EniIN85IXqsDcKHBKIFnunT5UQKWv5bt0Gl9lt+ra4+kTgm7ToRyHllV9Hz1RjbmtIOXOLj07cV
 aKoKkgimClwxrCMQT9e5f0P4SBzFSpVeIEebiSvyxk7ezDpsxZEbjs3vrMeyw8pnmJmmDlc1spl
 XQPVg6C+AttUpCXGKGdYnXMPeGkF924nyo8vW42uGTB42KAOIHW6XVaWVhsjZNMrfJmj+U5d5t/
 7O1Hipv+x2eqNPnxf2uiSAXfSARPvNbLL0M7j2vArInIWmYWlNNw7wq8QkNOPehGIFQeQH+a4zO
 R3PIgmczjMfGjrw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Jan 2025 08:37:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/981

Like the docs build in commit afa838d962b7 ("docs build: make it
possible to override repo settings") we can make the
yocto-autobuilder-helper part of the repo dependencies in config.py, and
then pass branch and uri information to the builders using util.Property
and util.Interpolate. This allows overriding the
yocto-autobuilder-helper URI/branch when starting a build manually.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 builders.py   |  8 ++++----
 config.py     |  6 +++++-
 schedulers.py | 20 ++++++++++++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builders.py b/builders.py
index 4f2bf00e5387d910f23579028a410e250fccf588..81308211155f7ec71cfb559e40e68f8742a698c7 100644
--- a/builders.py
+++ b/builders.py
@@ -104,8 +104,8 @@ def create_builder_factory():
         haltOnFailure=True,
         name="Clobber build dir"))
     f.addStep(steps.Git(
-        repourl=config.repos["yocto-autobuilder-helper"][0],
-        branch=config.repos["yocto-autobuilder-helper"][1],
+        repourl=util.Interpolate("%(prop:repo_yocto-autobuilder-helper)s"),
+        branch=util.Property('branch_yocto-autobuilder-helper'),
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
         haltOnFailure=True,
@@ -260,8 +260,8 @@ def create_parent_builder_factory(buildername, waitname):
                     name="Clobber build dir"))
     # check out the source
     factory.addStep(steps.Git(
-        repourl=config.repos["yocto-autobuilder-helper"][0],
-        branch=config.repos["yocto-autobuilder-helper"][1],
+        repourl=util.Interpolate("%(prop:repo_yocto-autobuilder-helper)s"),
+        branch=util.Property('branch_yocto-autobuilder-helper'),
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
         haltOnFailure=True,
diff --git a/config.py b/config.py
index 8e2797aaeed7e2c688983d3d1f3c4b1895d393b8..062eafd290c06a49cdb8a6d3e358bea748e15877 100644
--- a/config.py
+++ b/config.py
@@ -27,7 +27,7 @@ buildertorepos = {
     "checkuri": ["poky"],
     "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
     "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein"],
-    "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
+    "docs": ["yocto-docs", "bitbake"],
     "reproducible-meta-oe": ["poky", "meta-openembedded"],
     "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
     "meta-oe-mirror":  ["poky", "meta-openembedded"],
@@ -38,6 +38,10 @@ buildertorepos = {
     "default": ["poky"]
 }
 
+# Add yocto-autobuilder-helper as a default repo dependency
+for builder in buildertorepos:
+    buildertorepos[builder] = ["yocto-autobuilder-helper"] + buildertorepos[builder]
+
 # Repositories used that the scripts need to know about and should be buildbot
 # user customisable
 repos = {
diff --git a/schedulers.py b/schedulers.py
index e4760ed8bf1d02f4edca9af87725cf116630a14b..18ec236391c0f63a49e6b0503b3612eba24c4225 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -399,7 +399,15 @@ for builder in config.subbuilders:
     schedulers.append(sched.ForceScheduler(
         name=builder,
         builderNames=[builder],
-        codebases=[util.CodebaseParameter(codebase='', label="yocto-autobuilder-helper:", project=None)],
+        # Note: we pass FixedParameters here to hide these in the form, since
+        # entries to override the URL and branch are already created thanks to
+        # props_for_builder() below.
+        codebases=[util.CodebaseParameter(codebase='',
+                                          branch=util.FixedParameter(name="branch", default=""),
+                                          revision=util.FixedParameter(name="revision", default=""),
+                                          repository=util.FixedParameter(name="repository", default=""),
+                                          label="yocto-autobuilder-helper:",
+                                          project=None)],
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the
@@ -457,7 +465,15 @@ def parent_scheduler(target):
     name=target,
     builderNames=[target],
     buttonName="Start " + target + " Build",
-    codebases = [util.CodebaseParameter(codebase='', label="yocto-autobuilder-helper:", project=None)],
+    # Note: we pass FixedParameters here to hide these in the form, since
+    # entries to override the URL and branch are already created thanks to
+    # props_for_builder() below.
+    codebases = [util.CodebaseParameter(codebase='',
+                                        branch=util.FixedParameter(name="branch", default=""),
+                                        revision=util.FixedParameter(name="revision", default=""),
+                                        repository=util.FixedParameter(name="repository", default=""),
+                                        label="yocto-autobuilder-helper:",
+                                        project=None)],
     reason=util.StringParameter(
         name="reason",
         label="""Reason (please note the reason for triggering the build and

---
base-commit: 8f6709cf0fad448ea87d80b50cd2ae375e5066b2
change-id: 20250110-fix-autobuilder-dep-8ae03830e17d

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


