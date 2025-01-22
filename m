Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93EC02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 08:42:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.38846.1737535322133201977
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Jan 2025 00:42:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=f+v79NEo;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 709C640005;
	Wed, 22 Jan 2025 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737535319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gle/VVmwc0euqCFBq1GnQ0rMmCl0LBudGU2bG/mgMxg=;
	b=f+v79NEoR6O/WAzwIIfrXMO+3eGI+A/3wTo1PJwGGkzRXL120+QG8coflq67SnZ4aJAkBD
	AL7LfxUpe1qOtrhULQ64mp9YZuRIzaI3rSNNfHrroFkR+eG8V0sx7ySzgouBPAiUyo8JmT
	YDa37Ef6sXX3eK5My6ti+GEgOiYeZRbUJYpHV0QWZHmQeLgFbAgJlH2hxv7wuhV8ddZTrN
	bDq/Rs7eT4L1uez3TuzQwVQdyW/wx3rhxjRtsTYLU08qCKh93ABRWzdB2GVLlw8Lj/JRSG
	TL2xVRCJGx3WGj0jGkSE1ZfO9GqlghsFTUJ1B731USeXARnDHohV6EPuCw8BMw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 22 Jan 2025 09:41:45 +0100
Subject: [yocto-autobuilder2][PATCH v2] Fix overriding of the
 yocto-autobuilder-helper parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-fix-autobuilder-dep-v2-1-84e8c0f623e5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEivkGcC/22NzQ6CMBCEX4Xs2TX9sUA88R6GA9BVNkFKWmg0p
 O9uJfHm8ZvMfLNDIM8U4Frs4ClyYDdnUKcChrGbH4RsM4MSyggpBd75hd22un7jyZJHSwvWHQl
 da0GyspCXi6dcO6y3NvPIYXX+fZxE+U1/Pv3XFyVKNMqSuJRlRWSa3rl14vk8uCe0KaUPfMCo7
 LgAAAA=
X-Change-ID: 20250110-fix-autobuilder-dep-8ae03830e17d
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4939;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=IQIhUOztvOWWHWu1c3XQTy+++YMCr+h1CI6E5eK6ENQ=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnkK9XXZtcTXzMarOF+Xx/F3/VvWjqxmGE11qU0
 LoT8P/mVCKJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ5CvVwAKCRDRgEFAKaOo
 NgdaD/9dw+mP/Rib9ob2j++LWNLfAlL+0XFLtcXYIbqrRJlsw9WekZ8W7S+AG5LyTufUKgqvNnr
 o2sHu2nH8W+PgiJdFp78bld75Z92MhykiCII0PH9tKKP2PWWGhLSwfUx+bvItIu+YC2PabRP/fF
 d8F4EjdnrK7Aqvs1UCLmhGz0kkItU3SC9H+kLbCs8d58kYEhaYEBbcZlYdzalwtY3hqm3aPPHlh
 Tb9c/n8jalAZCD2Auz7BU6yD8+SMprvzVfZO8t9IReYTLQ18NAjGiulMosD2pA7rq34/QJY3M/R
 bf2naK0ERTlMQlnfkgGLMoFOy4hFJGvbxm/7PKPm7DgvxXpEx8AqZVP59JwZquIRW2IOm8uV03F
 hV4hzikfL+ZEub5IgS/7FjSi1m74tgMUybLu/FpD3JZTzoEii/DB4O5+27GbhyJ67VMgp0/GV3P
 SjkYkdt9nLC/NlKZb2I3f1KIhrHdj6hZch5TJt+me7EVP9Ohx2V6W4VBwS2Z1kOnJpUV5tNwypX
 qyrqtWi0DtV/eOZwY/KZWkpvIEXT7/SuNBW4lYALgnEVdvlXsUbLtf83AgnHoeKWvEVIZXTK/pE
 KY7SO6c6WkJ+2v69R2XizC/2h+ie3KwVTtGOInJyRRPL25KOp2KuG2SrDsQzQmw9eqCdiezdvzt
 YbzNE8l9c3FLBag==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jan 2025 08:42:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1002

Like the docs build in commit afa838d962b7 ("docs build: make it
possible to override repo settings") we can make the
yocto-autobuilder-helper part of the repo dependencies in config.py, and
then pass branch and uri information to the builders using util.Property
and util.Interpolate. This allows overriding the
yocto-autobuilder-helper URI/branch when starting a build manually.

The codebases arguments of ForceScheduler remain here because this is
how the ReleaseSelector sets the "branch" property, which are in turn
used by the triggered builds. We remove the "label" property as in
reality this codebase has nothing to do with the
yocto-autobuilder-helper repository.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Add the codebases argument back, since ReleaseSelector uses it to set
  the "branch" property, used by the triggered builds.
- Link to v1: https://lore.kernel.org/r/20250113-fix-autobuilder-dep-v1-1-52de04667ee5@bootlin.com
---
 builders.py   | 8 ++++----
 config.py     | 6 +++++-
 schedulers.py | 4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

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
index e4760ed8bf1d02f4edca9af87725cf116630a14b..cb4ac2b6c8042e03899551bb42e1ff7e72824717 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -399,7 +399,7 @@ for builder in config.subbuilders:
     schedulers.append(sched.ForceScheduler(
         name=builder,
         builderNames=[builder],
-        codebases=[util.CodebaseParameter(codebase='', label="yocto-autobuilder-helper:", project=None)],
+        codebases=[util.CodebaseParameter(codebase='', project=None)],
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the
@@ -457,7 +457,7 @@ def parent_scheduler(target):
     name=target,
     builderNames=[target],
     buttonName="Start " + target + " Build",
-    codebases = [util.CodebaseParameter(codebase='', label="yocto-autobuilder-helper:", project=None)],
+    codebases = [util.CodebaseParameter(codebase='', project=None)],
     reason=util.StringParameter(
         name="reason",
         label="""Reason (please note the reason for triggering the build and

---
base-commit: 8f6709cf0fad448ea87d80b50cd2ae375e5066b2
change-id: 20250110-fix-autobuilder-dep-8ae03830e17d

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


