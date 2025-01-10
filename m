Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE67E7719E
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 15:30:40 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.21336.1736523033038771481
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jan 2025 07:30:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=eEexYIAK;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA113FF80E;
	Fri, 10 Jan 2025 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736523031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TznyL9vCAeZto/uOQ+K8rEMPozLt7NTHqkDxMyCEJU=;
	b=eEexYIAKdNCY1uicYT2Z1cLFZ+Swa+BD9j+NHFw/xCqC26S3ngTPaKeLHO0/IU3o0lMAMx
	VsubpVxKJskepKy94KyNjuSQqFKtmwphRIwSqEicf61SjREBy5RWlO1qvrhJcgPKhQ3QcF
	F7m0M+5dPAWe6irdNLdOlLg2sOS1B6/x7wjreO4xggCpj5T9KnYC3AmFqfIMQYPvWLrBbp
	ReLK6KpbLM7WCq5c1IB3YgGpMbs1XvIRR+Klv0L6ukXWdy5Sx/PHPOz1jR98C6oHYrzbyA
	G1jsbCGD72CcelRJXx7j3xGt3Y8VN4fzIWsWUhInkW/gtknUHMUCorap0Tzn2g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 10 Jan 2025 16:30:05 +0100
Subject: [yocto-autobuilder2][PATCH v2 1/2] docs build: make it possible to
 override repo settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-docs-build-shared-repos-v2-1-a83a7a09915d@bootlin.com>
References: <20250110-docs-build-shared-repos-v2-0-a83a7a09915d@bootlin.com>
In-Reply-To: <20250110-docs-build-shared-repos-v2-0-a83a7a09915d@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5927;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=s4TT2yX+y1LR4RPjvVrlszLpjEsxQGbe15lT68WmfEk=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBngT0WI74B6lMTPYLHI3Z4zxD66lOxudJ8q7ZsB
 l39yZWXaxSJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ4E9FgAKCRDRgEFAKaOo
 NkDXD/wIT7LKt267P0XPFZ1K8PNkuXPFm8dnBAOLtRQoneCURfP6Sr3413IlZgP3mW6FFaUiwfs
 ymV28utN9gOGKk6BdyPM8Y7ZxdW67SFD5RSx1uHQKA6hgmVEjHL5WQGK4+wjTjtCf0PmSVxpelh
 3si9G6/OwZByHJSQG3hgPb4hgzWoel5b9C/iNQlsRgmnK0eZYQXk4GagYV8CmA4eKGhJXh57tVm
 2rzmURqCVaz/dEzyodY3x/PJdQmRKSjl1hksXKUx+oagRtmqT1Zrr5qK4NugAtVDdDgHsk2fDqh
 3JDDRCQKsxlhie7MQCszVV42mfQHkcFpbkhllH9yZGbELTOorbCSSM9lkdcBvwfsD5Qp9X2mZc+
 j741AGpnjCidh6Q4PY9UZn3B+G54mFyK6/bfeCpTgcC0dgrm+5L5WMBTTDkS7x8QrzxRB+n0d86
 W/W98Uu9XTwUZ+GYW4ulB8KFt/9zhB2cVY4s+feYsLHOPWsFXRgFUcbuXCPqPl+CAP/uvsC5J3h
 vwKifjgEqxhisg+0XukyQBVlc61aps9TO83Z/5uEc+Ad0XqSMB7AN30JzvQZdLoH4750bKHjyEW
 talBYI5o+OcOl06o31bl5tUrqcq8kQAtVCYbCEIEF/quB6lDo+Dtx/W7gYcT8RalDQv6TZSslxm
 UDINYUXlc51NZMg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jan 2025 15:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/979

In the current form when forcing a docs build, the different repo
parameters do nothing and are not propagated. The properties from
props_for_builder() are propagated, but weren't used in the factory
definition.

So use FixedParameters in the codebases definition: this removes the
useless entries in the form (we cannot simply remove the codebases arg
or it triggers another error "No sourcestamp found in build for
codebase"). Then in config.py, populate the "docs" entry in
buildertorepos, so that these show up in the form. Finally, in the docs
factory build, use Interpolate to get the property (I had issues using
util.Property directly).

Note: in latest buildbot version I hit a known bug
https://github.com/buildbot/buildbot/issues/8274. It shouldn't affect us
since we use an older version of Buildbot, but leaving this here just in
case.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 builders.py   | 12 ++++++------
 config.py     |  2 +-
 schedulers.py | 18 +++++++++++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builders.py b/builders.py
index 88ff328c7ec6ecf0f28da2693cc9c0210e760b35..4f2bf00e5387d910f23579028a410e250fccf588 100644
--- a/builders.py
+++ b/builders.py
@@ -382,24 +382,24 @@ def create_doc_builder_factory():
         haltOnFailure=True,
         name="Clobber build dir"))
     f.addStep(steps.Git(
-        repourl=config.repos["yocto-autobuilder-helper"][0],
-        branch=config.repos["yocto-autobuilder-helper"][1],
+        repourl=util.Interpolate("%(prop:repo_yocto-autobuilder-helper)s"),
+        branch=util.Property('branch_yocto-autobuilder-helper'),
         codebase='yab-helper',
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
         haltOnFailure=True,
         name='Fetch yocto-autobuilder-helper'))
     f.addStep(steps.Git(
-        repourl=config.repos["yocto-docs"][0],
-        branch=config.repos["yocto-docs"][1],
+        repourl=util.Interpolate("%(prop:repo_yocto-docs)s"),
+        branch=util.Property('branch_yocto-docs'),
         codebase='yocto-docs',
         workdir=util.Interpolate("%(prop:builddir)s/yocto-docs"),
         mode='incremental',
         haltOnFailure=True,
         name='Fetch yocto-docs'))
     f.addStep(steps.Git(
-        repourl=config.repos["bitbake"][0],
-        branch=config.repos["bitbake"][1],
+        repourl=util.Interpolate("%(prop:repo_bitbake)s"),
+        branch=util.Property('branch_bitbake'),
         codebase='bitbake',
         workdir=util.Interpolate("%(prop:builddir)s/bitbake"),
         mode='incremental',
diff --git a/config.py b/config.py
index 94d0405803fb9c916e06518f12d257e978ffc46e..8e2797aaeed7e2c688983d3d1f3c4b1895d393b8 100644
--- a/config.py
+++ b/config.py
@@ -27,7 +27,7 @@ buildertorepos = {
     "checkuri": ["poky"],
     "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
     "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein"],
-    "docs": [],
+    "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": ["poky", "meta-openembedded"],
     "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
     "meta-oe-mirror":  ["poky", "meta-openembedded"],
diff --git a/schedulers.py b/schedulers.py
index bbd249a3aec45f60faec6c7f67056050794866a3..a3466d5b596bd0b1e8879a5acabf5ad66ee297a1 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -498,15 +498,27 @@ schedulers.append(parent_scheduler("a-full"))
 schedulers.append(sched.ForceScheduler(
         name="docs",
         builderNames=["docs"],
+        # Note: we pass FixedParameters here to hide these in the form, since
+        # entries to override the URL and branch are already created thanks to
+        # props_for_builder() below.
         codebases=[util.CodebaseParameter(codebase='yab-helper',
                                           label="yocto-autobuilder-helper:",
-                                          project=None),
+                                          branch=util.FixedParameter(name="branch", default=""),
+                                          revision=util.FixedParameter(name="revision", default=""),
+                                          repository=util.FixedParameter(name="repository", default=""),
+                                          project=util.FixedParameter(name="project", default="")),
                    util.CodebaseParameter(codebase='yocto-docs',
                                           label="yocto-docs:",
-                                          project=None),
+                                          branch=util.FixedParameter(name="branch", default=""),
+                                          revision=util.FixedParameter(name="revision", default=""),
+                                          repository=util.FixedParameter(name="repository", default=""),
+                                          project=util.FixedParameter(name="project", default="")),
                    util.CodebaseParameter(codebase='bitbake',
                                           label="bitbake:",
-                                          project=None),
+                                          branch=util.FixedParameter(name="branch", default=""),
+                                          revision=util.FixedParameter(name="revision", default=""),
+                                          repository=util.FixedParameter(name="repository", default=""),
+                                          project=util.FixedParameter(name="project", default="")),
                    ],
         reason=util.StringParameter(
                 name="reason",

-- 
2.47.1


