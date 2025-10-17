Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115BCCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 08:21:18 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.10824.1760689269707845747
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 01:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=kftqOzki;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6155D4E4111B
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:21:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37FE4606DB
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:21:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EFC0102F2335;
	Fri, 17 Oct 2025 10:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760689267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4S+WV6pWFkquzaXivoJ9e4vJHQFc4uBTg58XLkAFfF0=;
	b=kftqOzkimhEg3+etQzLlNEASDYFK9sjwI70hI0VWtAAsK4Tcze9vbho1CtICf8km7nztwz
	cjB2CtMva7cumtnTb/A1VUaHI3QH8jj0gJCjGXm9/uJTQoDlnn+6ax74cseHEaqBaFQ6n4
	WPWMNiLkV521WFGDd+X+OeEEZitWtsA6ef0xY9FVhy8Mx/84OAos0NKFeZbdfP63LNz2/R
	jObYGnES0maXcXVvitmLTfmu3GNHss/RUvGc0btNXQFUZ2qNNy1Fcm9AgPo6wrGD6AZSPk
	8tnMfKJYBICzq6gOnRHuy7BXUfnbQylzs3wP2+I2lDVrrZ5ySTqMAqpvT2Lbbg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 17 Oct 2025 10:21:05 +0200
Subject: [PATCH yocto-autobuilder2] builders: Show tags on separate gits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-contrib-mathieu-oe-core-tag-v1-1-a9c204c3750e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHD88WgC/x2M0QrCMAwAf2Xk2UDbIYK/Ij60XdwC2kiaDmXs3
 1f2eMdxG1RSpgr3YQOllStL6eAvA+QllpmQp84QXLh652+YpZhywk+0hamhUFdKaHHGMQXnfB5
 9L6Efvkov/p33B/wlm2BsJqnxeyIN8Nz3A4FDmcqBAAAA
X-Change-ID: 20251017-contrib-mathieu-oe-core-tag-3b2001c31101
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760689267; l=6358;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=hcRKp6wP/w3nQE/EVcFEQ5RAXn3RS2lAwLjvnH4T848=;
 b=ox53YyVQPC3v2eAspQCQJDzoBnuCapL4wnQAv7h9t2dFLYCnda7ITo3lluKksltxp/ej9s1fo
 ySDvY5ZveiFBvmahO1BI+q2cWHLEa4bXsKM0cTcJ/kZk9THhauYMTQE
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:21:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2348

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py                                        | 21 +++++++++++----
 ...builders-Do-not-create-tags-during-builds.patch | 31 +++++++++++++++-------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/builders.py b/builders.py
index 18c119aa7617..b7379ece71f2 100644
--- a/builders.py
+++ b/builders.py
@@ -272,6 +272,13 @@ def prioritizeBuilders(master, builders):
     #log.msg("Using %s" % str(rv))
     return rv
 
+# Tags in poky-ci-archive are prefixed with the name of the repo, except for
+# poky itself.
+tag_prefixes = {"poky": "",
+                "bitbake": "bitbake/",
+                "oecore": "oecore/",
+                "meta-yocto": "meta-yocto/"}
+
 @util.renderer
 def createBuildTag(props):
     buildername = props.getProperty('buildername')
@@ -313,10 +320,12 @@ def create_parent_builder_factory(buildername, waitname):
         name="Prepare shared repositories"))
     factory.addStep(steps.SetProperty(
         property="poky-ci-archive_tag", value=createBuildTag))
-    tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:tag)s',
-                              tag=createBuildTag)
-    factory.addStep(steps.SetProperty(
-        property="poky-ci-archive_url", value=tagurl))
+
+    for repo, prefix in tag_prefixes.items():
+        tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:prefix)s%(kw:tag)s',
+                                  prefix=prefix, tag=createBuildTag)
+        factory.addStep(steps.SetProperty(
+            property=f"poky-ci-archive_url_{repo}", value=tagurl))
     factory.addStep(steps.SetProperty(
         property="sharedrepolocation",
         value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
@@ -366,7 +375,6 @@ def create_parent_builder_factory(buildername, waitname):
             "yp_build_revision": util.Property("yp_build_revision"),
             "yp_build_branch": util.Property("yp_build_branch"),
             "poky-ci-archive_tag": util.Property("poky-ci-archive_tag"),
-            "poky-ci-archive_url": util.Property("poky-ci-archive_url")
         }
 
         for repo in config.buildertorepos[buildername]:
@@ -377,6 +385,9 @@ def create_parent_builder_factory(buildername, waitname):
         set_props["milestone_number"] = util.Property("milestone_number")
         set_props["rc_number"] = util.Property("rc_number")
 
+        for repo in tag_prefixes:
+            set_props[f"poky-ci-archive_url_{repo}"] = util.Property(f"poky-ci-archive_url_{repo}")
+
         return set_props
 
     factory.addStep(steps.Trigger(schedulerNames=[waitname],
diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
index b36f2ea7e83e..c1482f72c8e4 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -5,14 +5,14 @@ Subject: [PATCH 1/2] builders: Do not create tags during builds
 
 Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 ---
- builders.py | 9 ---------
- 1 file changed, 9 deletions(-)
+ builders.py | 13 -------------
+ 1 file changed, 13 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index 2fb0bf827b0f..af1cc263fd2e 100644
+index b7379ece71f2..d87e41c9233e 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -307,16 +307,9 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -314,18 +314,9 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
@@ -22,22 +22,33 @@ index 2fb0bf827b0f..af1cc263fd2e 100644
          name="Prepare shared repositories"))
 -    factory.addStep(steps.SetProperty(
 -        property="poky-ci-archive_tag", value=createBuildTag))
--    tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:tag)s',
--                              tag=createBuildTag)
--    factory.addStep(steps.SetProperty(
--        property="poky-ci-archive_url", value=tagurl))
+-
+-    for repo, prefix in tag_prefixes.items():
+-        tagurl = util.Interpolate('https://git.yoctoproject.org/poky-ci-archive/log/?h=%(kw:prefix)s%(kw:tag)s',
+-                                  prefix=prefix, tag=createBuildTag)
+-        factory.addStep(steps.SetProperty(
+-            property=f"poky-ci-archive_url_{repo}", value=tagurl))
      factory.addStep(steps.SetProperty(
          property="sharedrepolocation",
          value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
-@@ -365,8 +358,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -374,7 +365,6 @@ def create_parent_builder_factory(buildername, waitname):
              "rc_number": util.Property("rc_number"),
              "yp_build_revision": util.Property("yp_build_revision"),
              "yp_build_branch": util.Property("yp_build_branch"),
 -            "poky-ci-archive_tag": util.Property("poky-ci-archive_tag"),
--            "poky-ci-archive_url": util.Property("poky-ci-archive_url")
          }
  
          for repo in config.buildertorepos[buildername]:
+@@ -385,9 +375,6 @@ def create_parent_builder_factory(buildername, waitname):
+         set_props["milestone_number"] = util.Property("milestone_number")
+         set_props["rc_number"] = util.Property("rc_number")
+ 
+-        for repo in tag_prefixes:
+-            set_props[f"poky-ci-archive_url_{repo}"] = util.Property(f"poky-ci-archive_url_{repo}")
+-
+         return set_props
+ 
+     factory.addStep(steps.Trigger(schedulerNames=[waitname],
 -- 
 2.47.3
 

---
base-commit: 37a0183944496fb30ed73e4d2fd3acdb532a7d06
change-id: 20251017-contrib-mathieu-oe-core-tag-3b2001c31101

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


