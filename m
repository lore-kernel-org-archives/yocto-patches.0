Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C881E77188
	for <webhook@archiver.kernel.org>; Fri,  3 Jan 2025 15:25:17 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.33041.1735917907053895663
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jan 2025 07:25:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FsiftVL0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08B0960004;
	Fri,  3 Jan 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735917905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=id5/fXc9oI2FqPsm/KLWdLu8SS3J2dK2hw25OgisRGM=;
	b=FsiftVL0mH1NLBFKB5TDjNw7Cx4Cmrl5kOAcMiNOeAqYvJfUz1u9+cylsW0DY23NylrHUn
	nF+gQYA0oX1W4CGVwFp92XSKMRaGzb2BHyWAFovzMX473C3YIrrQebvCkVxcN2Fv48Nsve
	/gHaD62px953C83wgq0AWddLyE7dcylJWmNFfNikhktkaOai/vapPaCSteFHOAV7VZG9IU
	gdF6R/5SprqwiuGLzL8XuR99Cmscmz0bvSsp+bk7Gn7e+C0MptqCpbeOvc3JkEGNl0t2X0
	ZuOGTxPfm9iUIJy2Fk3pDFDAEDP0FOn3YAJTvsqtdqg67fG7JK7FXvMy7GRyEQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 03 Jan 2025 16:24:57 +0100
Subject: [yocto-autobuilder2][PATCH] docs: fetch yocto-docs and bitbake
 using *shared-repos scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-docs-build-shared-repos-v1-1-7b5705d895a1@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEgBeGcC/x3MSwqAMAwA0atI1gaqRfxcRVxoEzUgVhIUQby7x
 eVbzDxgrMIGXfaA8iUmcU8o8gzCOu4Lo1AylK6sXOE8UgyG0ykboa2jMqHyEQ19mH0zVU1LtYd
 UH8qz3P+5H973A7zkqERpAAAA
X-Change-ID: 20250103-docs-build-shared-repos-3cf38b589d73
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5741;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=s3SMJczQFPvj97XVBYQEEX6GTLyArG7a6Pj317X2DDs=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBneAFQiIGxeF2iysTyL14F+AX3IbIjIY9EeedID
 yf4DitBcEaJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ3gBUAAKCRDRgEFAKaOo
 NscuD/9HOWxDSevlrjyyiOQr8HGuOjyAogdXtRfukji7Il7EhKWk5CXijHqMh/MOGfVlU4PUFVX
 GtXQUpq5QK7/Cc+TYFCBnKP2q46+OxdUUfK1r/lItJLyC8bZ6jqz2cQ2DTXhzj93JuWbNrWnHDY
 KhUvKziBtOo7cab7G0v1OBwqCBdwpKj4BZDksP5eUn5RScK3nGqCo0dKcZWH3UP2RKG4XzRTxFG
 i4a4sFiSN+e74ra+sT9AaDZS5f3SooDXw+LFKt7/ZiY4+IP1EnqVfV2xwR4HVVk2lKyR1YCWcyU
 m9hkcsp6FHDLtJAqmK3u1si3JbcysDbufxVRoYUFy4ROhAOkgq6D7SC9pZdjJpVu1ZtH0Ov7lBO
 SQzfbEdckVrhC5pJjQwRUYCN79xEEDPb9SzftgbWKM6WcqsFKD1Tlc7nasDjnQzG/LJXaRZCkvz
 g1T2MyEdIdUPJzhJ/waBkF5WE+HbO3mnlirBwBchrMoTyvwywQYfZpgR+OfiOsZ+4v6Km4dRqmj
 EOQKzTaVEiEQLbkW1CaDhTddOYP7KSe5SOcmGXglz7NEDPBiBxMUDWfk3Y0QMQeEGKkk7frYZM1
 PmZqO3xwmWXFxXgsdQT1a4c20A+EvUrk3c8qGsFlbMqfR+XSgjpTLoeouk2vpownJlGY7YoA7Yt
 7zkbTfjCEpKpINg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jan 2025 15:25:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/965

The docs build was one of the only builder not using the shared-repos
scripts. This prevented some of the repository properties to be
overriden, such as the bitbake/yocto-docs repository URI. Overriding the
bitbake URI is especially useful when using bitbake-contrib instead of
bitbake, to test changes.

Leave the yocto-autobuilder-helper in the codebases (like in the other
builders), but move the yocto-docs/bitbake repositories to NEEDREPOS in
yocto-autobuilder-helper/config.json.

This patch depends on the patch "config.json: add docs build config" on
yocto-autobuilder-helper.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 builders.py   | 36 ++++++++++++++++++++++--------------
 config.py     |  2 +-
 schedulers.py | 11 +----------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builders.py b/builders.py
index 88ff328c7ec6ecf0f28da2693cc9c0210e760b35..e19fe5a138b18deec776f19c6b0af507e3021c89 100644
--- a/builders.py
+++ b/builders.py
@@ -389,22 +389,26 @@ def create_doc_builder_factory():
         mode='incremental',
         haltOnFailure=True,
         name='Fetch yocto-autobuilder-helper'))
-    f.addStep(steps.Git(
-        repourl=config.repos["yocto-docs"][0],
-        branch=config.repos["yocto-docs"][1],
-        codebase='yocto-docs',
-        workdir=util.Interpolate("%(prop:builddir)s/yocto-docs"),
-        mode='incremental',
+    f.addStep(WriteLayerInfo(name='Write main layerinfo.json', haltOnFailure=True))
+    f.addStep(steps.ShellCommand(
+        command=[
+            util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/prepare-shared-repos"),
+            util.Interpolate("%(prop:builddir)s/layerinfo.json"),
+            util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
+            ],
         haltOnFailure=True,
-        name='Fetch yocto-docs'))
-    f.addStep(steps.Git(
-        repourl=config.repos["bitbake"][0],
-        branch=config.repos["bitbake"][1],
-        codebase='bitbake',
-        workdir=util.Interpolate("%(prop:builddir)s/bitbake"),
-        mode='incremental',
+        name="Prepare shared repositories"))
+    f.addStep(steps.ShellCommand(
+        command=[
+            util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/shared-repo-unpack"),
+            util.Interpolate("%(prop:builddir)s/layerinfo.json"),
+            util.Interpolate("%(prop:builddir)s"),
+            util.Property("buildername"),
+            "-c", util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir)),
+            "--workername", util.Interpolate("%(prop:workername)s"),
+            ],
         haltOnFailure=True,
-        name='Fetch bitbake'))
+        name="Unpack shared repositories"))
     f.addStep(steps.ShellCommand(
         command=[util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/run-docs-build"),
                  util.Interpolate("%(prop:builddir)s"),
@@ -412,6 +416,10 @@ def create_doc_builder_factory():
                  util.Interpolate("%(prop:builddir)s/bitbake")],
         haltOnFailure=True,
         name="Run documentation Build"))
+    f.addStep(steps.ShellCommand(
+                    command=["rm", "-fr", util.Interpolate("{}/%(prop:buildername)s-%(prop:buildnumber)s".format(config.sharedrepodir))],
+                    haltOnFailure=True,
+                    name="Remove shared repo dir"))
     return f
 
 # Only run one docs build at a time
diff --git a/config.py b/config.py
index 94d0405803fb9c916e06518f12d257e978ffc46e..d9203f79006631678f92b2a3991cd0c598116de0 100644
--- a/config.py
+++ b/config.py
@@ -27,7 +27,7 @@ buildertorepos = {
     "checkuri": ["poky"],
     "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
     "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein"],
-    "docs": [],
+    "docs": ["yocto-docs", "bitbake"],
     "reproducible-meta-oe": ["poky", "meta-openembedded"],
     "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
     "meta-oe-mirror":  ["poky", "meta-openembedded"],
diff --git a/schedulers.py b/schedulers.py
index bbd249a3aec45f60faec6c7f67056050794866a3..15d7948dcf275432a1986ceeee551dec7f6de61b 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -498,16 +498,7 @@ schedulers.append(parent_scheduler("a-full"))
 schedulers.append(sched.ForceScheduler(
         name="docs",
         builderNames=["docs"],
-        codebases=[util.CodebaseParameter(codebase='yab-helper',
-                                          label="yocto-autobuilder-helper:",
-                                          project=None),
-                   util.CodebaseParameter(codebase='yocto-docs',
-                                          label="yocto-docs:",
-                                          project=None),
-                   util.CodebaseParameter(codebase='bitbake',
-                                          label="bitbake:",
-                                          project=None),
-                   ],
+        codebases=[util.CodebaseParameter(codebase='yab-helper', label="yocto-autobuilder-helper:", project=None)],
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the docs build:""",

---
base-commit: adb36c2213d331fd4a4fdcb5f48969b37bf1feb2
change-id: 20250103-docs-build-shared-repos-3cf38b589d73

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


