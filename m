Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EEBCCD188
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20534.1759847847111038424
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ovKkcIVe;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D03921A116B
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A90E9606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE41E102F2168;
	Tue,  7 Oct 2025 16:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1n/PfEIy8T/ke7sR7sW2U4r8XL5aCCtkmL7lG7LXAfk=;
	b=ovKkcIVeLbFzD0y7Z4O32Sv+bpkLd1OzMSgVToLLZCkQFCiVXf3lpSQ6l9Kg1hksS5jEz2
	CB2KnCO0UpSi0TRuIwVduSNxi16tsNgrvrdYYq0V8GQj1l3IrMDtYHWwdasu+3wI3zKvHU
	uC0qYdc0aMQSWnaoMSLr+PvGdkC70VYMioBRon9q5Bh7b9KA5ZlROgRMulVp6Ny5Y79iDU
	Vi3fUeqdGRdx4fP50/+IsgUwkeoOmYcGXyoGHJOgoHE0Omx2ng77exk1MgmBh6VQCPtIIb
	NPCLK3+02mbMwgMElc12MYY89sDXDufQMfyOZ+8g0gEus3RAG9EF75UYMnBOgQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:21 +0200
Subject: [PATCH yocto-autobuilder2 05/10] docker: refresh patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-5-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=4396;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=eoj1cUw/NZtNe7Wmk/bbz6xAp4hPhnH4NK7Lf394HSY=;
 b=8ZUd9gC6pnzlJK8jXyZN+E/aowQ6ULnr2fKlfSYMTD4Jo6VpGVKZ72fCLOpubYrCSX2fYzyRp
 nEgeuFsi8WFD1dWGTVEveMP0eYX4XMQIaugAhnHh/iCeNCDFUUbbtyH
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2281

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 ...001-builders-Do-not-create-tags-during-builds.patch |  8 ++++----
 ...ers-Modify-free-space-check-to-work-in-docker.patch | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
index 65b428caa1fc086a88f6b1326de25d2b00843582..8e772c8fa7b1b2cdd59af58f5f87b1332d5fb602 100644
--- a/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
+++ b/docker/yocto-autobuilder2_patches/0001-builders-Do-not-create-tags-during-builds.patch
@@ -1,4 +1,4 @@
-From 12db34cf42ca695bd34594853013e54464a809f5 Mon Sep 17 00:00:00 2001
+From baef5f6c4c2cf973385392d1e163f8bec2f6cca2 Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Fri, 3 Jan 2025 09:39:06 +0100
 Subject: [PATCH 1/2] builders: Do not create tags during builds
@@ -9,10 +9,10 @@ Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
  1 file changed, 1 deletion(-)
 
 diff --git a/builders.py b/builders.py
-index b4c08fa1f29c..4e10bdceedb2 100644
+index 15985f258bb9..a16a857d9211 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -284,7 +284,6 @@ def create_parent_builder_factory(buildername, waitname):
+@@ -307,7 +307,6 @@ def create_parent_builder_factory(buildername, waitname):
              util.Interpolate("%(prop:builddir)s/layerinfo.json"),
              util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
              "-p", get_publish_dest,
@@ -21,5 +21,5 @@ index b4c08fa1f29c..4e10bdceedb2 100644
          haltOnFailure=True,
          name="Prepare shared repositories"))
 -- 
-2.39.5
+2.47.3
 
diff --git a/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
index 6d3ec5539b97c0c45b18f73cf7d1fcf93fa39f32..8c0ad1c93cbefe0887c6618a67761c582ce0b99d 100644
--- a/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
+++ b/docker/yocto-autobuilder2_patches/0002-builders-Modify-free-space-check-to-work-in-docker.patch
@@ -1,4 +1,4 @@
-From 9bf9680ab9125138d926c22ca434ad86053bb5c4 Mon Sep 17 00:00:00 2001
+From c6032ab33d39981eb9dede27d0bbd073a8d58389 Mon Sep 17 00:00:00 2001
 From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 Date: Wed, 20 Nov 2024 14:53:34 +0100
 Subject: [PATCH 2/2] builders: Modify free space check to work in docker
@@ -9,10 +9,10 @@ Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
  1 file changed, 2 insertions(+), 3 deletions(-)
 
 diff --git a/builders.py b/builders.py
-index ba47241de2cc..02f6c10c6add 100644
+index a16a857d9211..d5389283e605 100644
 --- a/builders.py
 +++ b/builders.py
-@@ -67,8 +67,7 @@ def canStartBuild(builder, wfb, request):
+@@ -70,8 +70,7 @@ def canStartBuild(builder, wfb, request):
  
      # threshold is GB of space
      checks = {
@@ -22,15 +22,15 @@ index ba47241de2cc..02f6c10c6add 100644
      }
  
      for mountpoint in checks:
-@@ -76,7 +75,7 @@ def canStartBuild(builder, wfb, request):
+@@ -79,7 +78,7 @@ def canStartBuild(builder, wfb, request):
  
-         threshold = threshold * 1024 *1024 * 1024
+         bytes_in_gb = 1024 * 1024 * 1024
  
 -        cmd = yield shell("findmnt -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
 +        cmd = yield shell("findmnt --all -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
-         if int(cmd.stdout) < threshold:
-             log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(cmd.stdout, name, threshold))
-             wfb.worker.quarantine_timeout = 10 * 60
+         space = int(cmd.stdout.strip())
+         if space < threshold * bytes_in_gb:
+             log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(space / bytes_in_gb, name, threshold))
 -- 
-2.39.5
+2.47.3
 

-- 
2.47.3


