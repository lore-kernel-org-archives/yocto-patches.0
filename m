Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4045C02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 15:28:55 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.43889.1738855732968952047
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 07:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=HdzBgFmn;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB45D443FA;
	Thu,  6 Feb 2025 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738855731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rco5fnfWsXNgX/Q1wAqxvgPoiF8/IklolzUxRMbyiiY=;
	b=HdzBgFmnjqefyTpLsCDuY6SL09mHIxi4yX5LVQVUMljXVSHiJzf+KXKdRvP6s5112yrBxJ
	q/usPX1HCfjlozDZe5TITb84pCWT/dMvHdjg0kFjZBYHrVB6Tnl5BhWfeKzuCoKW8k3kGo
	PmO/OsFUj1yps5Ghur6wcwSTOw7HyDP4+B3biV7UR6QvLMpXaVIX93rZ09ssjlvLjKHT6G
	J8ntvBBv8qFVPlpwno2NBW7VKRVplWwSTV9AFAAl7ZqUDRm82w+vIfZQR2FBlcgjLRMJb0
	kN02MR5OYp9hbdNjSTHfN4t5abSdu3fyn0j6wYCw9/BWEk7491+exsdpUep0iQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 06 Feb 2025 16:28:29 +0100
Subject: [PATCH yocto-autobuilder2] builders: Add controller url in build
 tag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-mathieu-fix_build_tag-v1-1-f77ee974a76a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABzVpGcC/x2MWwqDMBAAryL73YW4+KBepRSJm60utKbkIRbx7
 g1+DszMAVGCSoShOiDIplH9WqC+VcCLXWdBdYWBDLWGTIcfmxaVjC/dxynr243Jzjj1PTO35Lr
 mDqX9BinC9X3Az3PyaHPyVyCB4Hmef/icvXB7AAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738855730; l=4135;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sENGzxuHnQagAdsXSw1P6zeSwI84XG5Z13jN8z/D76U=;
 b=lzagd+9XnJ0wrikKbXPw0uZ1BToOS/LiNUUt7VoayJ8UP4gwZ90uBWJEWQQ5KcW6R9c0+hbXh
 a7Pz2BUupLRCaRgo6NTu0avKhar66yTpSS8PG0/0A8BcSlGqvwzmI90
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiteegieetudejkeevteevleefhefgleegtedvvdefheeiveeivedtteffvdfhnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrs
 hdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 15:28:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1047

Make sure tags created on a-full/a-quick builds are unique, even across
different controller instances.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
We are creating a tag in https://git.yoctoproject.org/poky-ci-archive/
on each a-full and a-quick builds. Today tags only use buider name and
build number, creating tags such as "a-full-960". But as build number
will reset if we ever switch to a new buildbot controller, we should add
some part describing the controller itself. This patch will add a
fragment based on the controller url in the tag, creating tags like
"autobuilder.yoctoproject.org/valkyrie/a-full-960".
---
 builders.py                                                 | 13 ++++++++++++-
 .../0001-builders-Do-not-create-tags-during-builds.patch    |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builders.py b/builders.py
index 4f2bf00e5387..b4c08fa1f29c 100644
--- a/builders.py
+++ b/builders.py
@@ -19,6 +19,7 @@ from dateutil.tz import tzutc
 import os
 import json
 import random
+import urllib.parse
 
 
 builders = []
@@ -249,6 +250,16 @@ def prioritizeBuilders(master, builders):
     #log.msg("Using %s" % str(rv))
     return rv
 
+@util.renderer
+def createBuildTag(props):
+    buildername = props.getProperty('buildername')
+    buildnumber = props.getProperty('buildnumber')
+    build = props.getBuild()
+    url = urllib.parse.urlparse(build.master.config.buildbotURL)
+    host = url.netloc.replace(':', '_')
+    url.path
+    return f"{host}{url.path}{buildername}-{buildnumber}"
+
 def create_parent_builder_factory(buildername, waitname):
     factory = util.BuildFactory()
     # NOTE: Assumes that yocto-autobuilder repo has been cloned to home
@@ -273,7 +284,7 @@ def create_parent_builder_factory(buildername, waitname):
             util.Interpolate("%(prop:builddir)s/layerinfo.json"),
             util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
             "-p", get_publish_dest,
-            "-t", util.Interpolate("%(prop:buildername)s-%(prop:buildnumber)s"),
+            "-t", createBuildTag,
         ],
         haltOnFailure=True,
         name="Prepare shared repositories"))
diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
index 567b80f0ae7b..65b428caa1fc 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -1,4 +1,4 @@
-From ee671836ad9f0b65fa8b8b11c7f366377521ab20 Mon Sep 17 00:00:00 2001
+From 12db34cf42ca695bd34594853013e54464a809f5 Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Fri, 3 Jan 2025 09:39:06 +0100
 Subject: [PATCH 1/2] builders: Do not create tags during builds
@@ -9,14 +9,14 @@ Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
  1 file changed, 1 deletion(-)
 
 diff --git a/builders.py b/builders.py
-index 14ea1df1192e..ba47241de2cc 100644
+index b4c08fa1f29c..4e10bdceedb2 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -273,7 +273,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -284,7 +284,6 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
--            "-t", util.Interpolate("%(prop:buildername)s-%(prop:buildnumber)s"),
+-            "-t", createBuildTag,
          ],
          haltOnFailure=True,
          name="Prepare shared repositories"))

---
base-commit: cb639d12eb9694b0cf3b9f8c7fbe18ee08606597
change-id: 20250206-mathieu-fix_build_tag-b77ccc52d649

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


