Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517EFCAC583
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:31:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.14947.1757428274899107432
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=O7UegEBS;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 787134E40C5C;
	Tue,  9 Sep 2025 14:31:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533CF60630;
	Tue,  9 Sep 2025 14:31:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FDAE102F287B;
	Tue,  9 Sep 2025 16:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428272; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=StNpT28IIpErbjDrUx+szz2e60JKMkZimnSDhQy1JR4=;
	b=O7UegEBSQ4xBvlHhhIuVmVrW2fQrgIMKdNYsciGev3bEloYjFt4XiHtQrrTOkr1oQPfLk9
	df4ncCptpMKOt9DeqVSn4kqS+uaNSdbeyC3/MtISXdrnvSA0oYRhcDkvhclAoPSBs3Ep2F
	14es6rshwS4ASV5TzjMgL8Jy/ZH0vSMg0h7/eNnaqbYtC4SfYg7ddVLKLim3VRho3isTJI
	bGHeBNazHH6FVl4lSspAdUXz2i74/mpCmKrwfUAdk7lB9O5T9Co5a4hEbKs1YRUPLEVTwV
	UpzF7e+5984WKLvOLwfagEBiPmWdxzZyjW8G6CU+4Xe6xrgcCeGp3EIPWtbXBA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 09 Sep 2025 16:31:04 +0200
Subject: [PATCH yocto-autobuilder2 v2 2/3] builders: Add poky-ci-archive
 tag in build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-contrib-mathieu-build_props-v2-2-14b809f99dfa@bootlin.com>
References: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
In-Reply-To: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428270; l=3741;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=UT/ZxZtttH+FGQNGeACDSAXzRfJE7w8MneYOWg0fcxc=;
 b=NAwDAXvx3vgJyF8Zzy0J7g2/03vM5IZLarrXe3/7WdLvooy7VeJItkjAYT98jlE9eEcqXhX2R
 drSLHRXOG1HBPDxRIjn/4wF0vpJC2eKpGqifANPwqt5f49YPFPAtzSt
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:31:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2155

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py                                             | 10 +++++++++-
 ...0001-builders-Do-not-create-tags-during-builds.patch | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builders.py b/builders.py
index e4763d5325aa..0fa6e0035385 100644
--- a/builders.py
+++ b/builders.py
@@ -307,6 +307,12 @@ def create_parent_builder_factory(buildername, waitname):
         ],
         haltOnFailure=True,
         name="Prepare shared repositories"))
+    factory.addStep(steps.SetProperty(
+        property="poky-ci-archive_tag", value=createBuildTag))
+    tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:tag)s',
+                              tag=createBuildTag)
+    factory.addStep(steps.SetProperty(
+        property="poky-ci-archive_url", value=tagurl))
     factory.addStep(steps.SetProperty(
         property="sharedrepolocation",
         value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
@@ -358,7 +364,9 @@ def create_parent_builder_factory(buildername, waitname):
             "milestone_number": util.Property("milestone_number"),
             "rc_number": util.Property("rc_number"),
             "yp_build_revision": util.Property("yp_build_revision"),
-            "yp_build_branch": util.Property("yp_build_branch")
+            "yp_build_branch": util.Property("yp_build_branch"),
+            "poky-ci-archive_tag": util.Property("poky-ci-archive_tag"),
+            "poky-ci-archive_url": util.Property("poky-ci-archive_url")
         }
 
         for repo in config.buildertorepos[buildername]:
diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
index 65b428caa1fc..8448e58e3ad6 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -5,14 +5,14 @@ Subject: [PATCH 1/2] builders: Do not create tags during builds
 
 Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 ---
- builders.py | 1 -
- 1 file changed, 1 deletion(-)
+ builders.py | 7 -------
+ 1 file changed, 7 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index b4c08fa1f29c..4e10bdceedb2 100644
+index 0fa6e0035385..a264a9ec5c7e 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -284,7 +284,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -303,16 +303,9 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
@@ -20,6 +20,15 @@ index b4c08fa1f29c..4e10bdceedb2 100644
          ],
          haltOnFailure=True,
          name="Prepare shared repositories"))
+-    factory.addStep(steps.SetProperty(
+-        property="poky-ci-archive_tag", value=createBuildTag))
+-    tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:tag)s',
+-                              tag=createBuildTag)
+-    factory.addStep(steps.SetProperty(
+-        property="poky-ci-archive_url", value=tagurl))
+     factory.addStep(steps.SetProperty(
+         property="sharedrepolocation",
+         value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
 -- 
 2.39.5
 

-- 
2.39.5


