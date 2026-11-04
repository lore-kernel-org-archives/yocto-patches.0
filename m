Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5436.1793784746492448739
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yQi5DPJ6;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C80D84E413F7
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96BB960770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C3B810329218;
	Wed,  4 Nov 2026 10:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Iy+w7N6D8E9ApCZmXLJKcwon10RmIXJVyDZ9AziyyJE=;
	b=yQi5DPJ6Sl4vaIVuAOHyM6dmDdevWBJfEuVIQBPr8+nVhMEDNBvWHzMIrJHg67pMvOLYww
	GoOUbsmz+SkUEWYQWzc12SJglJrZy0qBQ9BlyAc3OnijpZSNYj1KwrdPwc/ciuwqHkFGpl
	14e2F9OW11VNyWk2KUWUITpLPWLvS7RSMrfd8hdqvFNF8pViTArQP/FLs+Xrbs7U8Sk3mX
	4bHyypBZzF78uN+9GiK+LORbG5KNdPBRmiiAI01Ukv63DLaQFxjZ5qtu+XZSEx8yCItIXT
	s1PYrl4KPYdw2814qPFIKb8jfsxmOVp7GMNGIFjhfC0sdc0MVt6v1P0eFG8L9g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 04 Nov 2026 10:32:13 +0100
Subject: [PATCH yocto-autobuilder2 2/5] docker: Refresh patches and fix
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-mathieu-release-selector-fix-v1-2-a245895c0093@bootlin.com>
References: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
In-Reply-To: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=6610;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=JvvMU0kOxKCPCKe2n8W6zBTzLzXwOAacmRYf5B7+DYM=;
 b=czPyel+QrUbeI9u2gqSdJMzWHqkWUoIvEoZ4J2LBQ+6QYhK6icvivsEqod+KrA7h9TVa1zaqe
 OV+5yVN6S4fDire8Trx9TmtaFECmHOYFSR4Lbt0doyKos+3haFzBkMw
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5227

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile                                   |  4 ++--
 docker/entry.sh                                     |  1 +
 ...-builders-Do-not-create-tags-during-builds.patch | 10 +++++-----
 ...-Modify-free-space-check-to-work-in-docker.patch | 21 ++++++++++-----------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 361d409f990c..0ddd20d52ac6 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -107,8 +107,8 @@ RUN sed -i \
         # Add local workers \
         -e "s/^\(workers_debian *=.*\).*/\1 + [f\"local-worker-debian\"]/" \
         -e "s/^\(workers *=.*\).*/\1 + [f\"local-worker-extra-{i}\" for i in range(1, 9)]/" \
-        # Remove workers_bringup from all_workers \
-        -e "/^all_workers *=/s/workers_bringup + //" \
+        # Empty workers_bringup variable \
+        -e "s/^\(workers_bringup *=\).*/\1 []/" \
         # Switch from ssh:// URLS to https:// so we do not need any auth \
         -e "s#ssh://git@push\.\(yoctoproject.org\|openembedded.org\)/#https://git.\1/#" \
         # Use any worker for any release \
diff --git a/docker/entry.sh b/docker/entry.sh
index 125f447be4f2..aac1af9dc1da 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -2,6 +2,7 @@
 
 chmod 666 /dev/kvm
 
+mkdir -p /srv/autobuilder/repos /srv/autobuilder/autobuilder.yocto.io/pub
 chown pokybuild:nogroup /srv/autobuilder/repos
 chown pokybuild:nogroup /srv/autobuilder/autobuilder.yocto.io/pub
 chown pokybuild:nogroup /home/pokybuild/git/mirror
diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
index c1482f72c8e4..7549329ba68a 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -1,4 +1,4 @@
-From b6a31b0c63a7529961ea02c53f43b9edb110f4de Mon Sep 17 00:00:00 2001
+From 3bc68471778693c59a692a26d5ef5a9d9212d901 Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Fri, 3 Jan 2025 09:39:06 +0100
 Subject: [PATCH 1/2] builders: Do not create tags during builds
@@ -9,10 +9,10 @@ Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
  1 file changed, 13 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index b7379ece71f2..d87e41c9233e 100644
+index 2d42d07e3b9a..574a23cc86bd 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -314,18 +314,9 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -337,18 +337,9 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
@@ -31,7 +31,7 @@ index b7379ece71f2..d87e41c9233e 100644
      factory.addStep(steps.SetProperty(
          property="sharedrepolocation",
          value=util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))
-@@ -374,7 +365,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -406,7 +397,6 @@ def create_parent_builder_factory(buildername, waitname):
              "rc_number": util.Property("rc_number"),
              "yp_build_revision": util.Property("yp_build_revision"),
              "yp_build_branch": util.Property("yp_build_branch"),
@@ -39,7 +39,7 @@ index b7379ece71f2..d87e41c9233e 100644
          }
  
          for repo in config.buildertorepos[buildername]:
-@@ -385,9 +375,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -417,9 +407,6 @@ def create_parent_builder_factory(buildername, waitname):
          set_props["milestone_number"] = util.Property("milestone_number")
          set_props["rc_number"] = util.Property("rc_number")
  
diff --git a/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
index 8c0ad1c93cbe..0ced8eaf7220 100644
--- a/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
+++ b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
@@ -1,19 +1,18 @@
-From c6032ab33d39981eb9dede27d0bbd073a8d58389 Mon Sep 17 00:00:00 2001
+From d2ac1923753ea987117f89506790f749370f8a77 Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Wed, 20 Nov 2024 14:53:34 +0100
 Subject: [PATCH 2/2] builders: Modify free space check to work in docker
 
 Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 ---
- builders.py | 5 ++---
- 1 file changed, 2 insertions(+), 3 deletions(-)
+ builders.py | 3 +--
+ 1 file changed, 1 insertion(+), 2 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index a16a857d9211..d5389283e605 100644
+index 574a23cc86bd..fb825bad72e7 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -70,8 +70,7 @@ def canStartBuild(builder, wfb, request):
- 
+@@ -73,7 +73,6 @@ def canStartBuild(builder, wfb, request):
      # threshold is GB of space
      checks = {
 -        "." : (200, "HOME"),
@@ -22,15 +21,15 @@ index a16a857d9211..d5389283e605 100644
      }
  
      for mountpoint in checks:
-@@ -79,7 +78,7 @@ def canStartBuild(builder, wfb, request):
+@@ -81,7 +80,7 @@ def canStartBuild(builder, wfb, request):
  
          bytes_in_gb = 1024 * 1024 * 1024
  
--        cmd = yield shell("findmnt -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
-+        cmd = yield shell("findmnt --all -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
+-        cmd = yield shell(["findmnt", "-T", mountpoint, "--df", "-n", "--bytes",
++        cmd = yield shell(["findmnt", "--all", "-T", mountpoint, "--df", "-n", "--bytes",
+                            "-o", "AVAIL"],
+                           wfb.worker, builder)
          space = int(cmd.stdout.strip())
-         if space < threshold * bytes_in_gb:
-             log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(space / bytes_in_gb, name, threshold))
 -- 
 2.47.3
 

-- 
2.47.3

