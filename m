Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9CCCD189
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20406.1759847849545423740
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1C398tw/;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 42C061A116B
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A82F606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C023102F216A;
	Tue,  7 Oct 2025 16:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0jWrnr0KOK0VFgVvCdN2dwOhZTgtdgSJIMmfy9aSRUY=;
	b=1C398tw/J2VCDXodH7Txw0KAd16YSVk/pEjBab3qaKzB9Y6I3qvMqvHmPBpprRQjsOtyyk
	Js+XbnYg/yB4OikufPvTNyuZUcbnCQvQ3G96e9FTiiYGdTUlxRU2nUiJRM7FySZNNRL6xG
	/2iJ6V7B0C6IvM0Bpzruz0jhQI0JB9CLKQBlaQs/SufsDNfM5CDWeCQYKwK1HiWzyVTBwL
	KX5cMMrH0M1tyo8nvx3M7LTolCbNxfzZSkZcvGjUyr5Y3VGnh5yDTJFShP8jt/tPnLuEgb
	zRxdxlo6PcYOf3kuztQaGBPCDvcluA9a4OF7glxtEiQu7PNOz+2JknScNGoXFQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:24 +0200
Subject: [PATCH yocto-autobuilder2 08/10] builders: Add poky-ci-archive tag
 in build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-8-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=4604;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=3J9Uaocr2o+e/7ipiXsMFhBoMD7u3mlc16k8N6BYgFI=;
 b=UZzJZKtlhTLdol9YcvMSsS2/Vo7OuCECmoUJzM2I90530Fe8rpoer0wEsvxnUaz6Z4uX8aqit
 ngdYCE6UaHZAxH53+vKSLEKXRa/PB2t3gGRFdu7M0aAkkZkt24arTZd
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2284

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py                                        | 10 +++++++-
 ...builders-Do-not-create-tags-during-builds.patch | 28 ++++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builders.py b/builders.py
index 15985f258bb9fa7d38e70f4ca35f87ede4c24a23..2fb0bf827b0f08fb822320ad9fc858592e606cc7 100644
--- a/builders.py
+++ b/builders.py
@@ -311,6 +311,12 @@ def create_parent_builder_factory(buildername, waitname):
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
index 8e772c8fa7b1b2cdd59af58f5f87b1332d5fb602..b36f2ea7e83edcd70ecbab6ecd13f2bb986e2dc6 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -1,18 +1,18 @@
-From baef5f6c4c2cf973385392d1e163f8bec2f6cca2 Mon Sep 17 00:00:00 2001
+From b6a31b0c63a7529961ea02c53f43b9edb110f4de Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Fri, 3 Jan 2025 09:39:06 +0100
 Subject: [PATCH 1/2] builders: Do not create tags during builds
 
 Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 ---
- builders.py | 1 -
- 1 file changed, 1 deletion(-)
+ builders.py | 9 ---------
+ 1 file changed, 9 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index 15985f258bb9..a16a857d9211 100644
+index 2fb0bf827b0f..af1cc263fd2e 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -307,7 +307,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -307,16 +307,9 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
@@ -20,6 +20,24 @@ index 15985f258bb9..a16a857d9211 100644
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
+@@ -365,8 +358,6 @@ def create_parent_builder_factory(buildername, waitname):
+             "rc_number": util.Property("rc_number"),
+             "yp_build_revision": util.Property("yp_build_revision"),
+             "yp_build_branch": util.Property("yp_build_branch"),
+-            "poky-ci-archive_tag": util.Property("poky-ci-archive_tag"),
+-            "poky-ci-archive_url": util.Property("poky-ci-archive_url")
+         }
+ 
+         for repo in config.buildertorepos[buildername]:
 -- 
 2.47.3
 

-- 
2.47.3


