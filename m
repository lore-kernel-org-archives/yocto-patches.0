Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87859E7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 15:30:40 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.21315.1736523032717428219
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jan 2025 07:30:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=JB4/A/nu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23A0EFF807;
	Fri, 10 Jan 2025 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736523031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=db1Tzf3PuMHw8L6J3eNd6mM9Bjr+QbYdt43peMTQ5Qc=;
	b=JB4/A/nu4D3GO6whDF1uCmItV0pZi+F5UbtXyvhNmS7PP9+AN/Qi8z2dlOQ21z+SFUAVXb
	yzgfjS1M/3oc2ky3YiIsVWtiWc2nw2h6baoYt68n4AgHrnPNo9DfNtweEccILkMXz4zLo1
	4bZYKo5yu6tvunrJ2RbMakCnlxFyTQlkzghoVneV5VZNmbOPX21yVxW/aAR3w2J0TiWRxq
	aTNAVcmL2dvFKVTyXemadgQSh02XpQsY0GexZf9SzLHG4hSIMvzzoIqpiI36czmCR+hQS0
	oJZL6WmFUr1D0YUc54gxZMNA2Yz0YKHUpss1EnMTpLRaaF92IeHJquvjQz+C1g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 10 Jan 2025 16:30:06 +0100
Subject: [yocto-autobuilder2][PATCH v2 2/2] schedulers: docs: pass
 properties to branch schedulers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-docs-build-shared-repos-v2-2-a83a7a09915d@bootlin.com>
References: <20250110-docs-build-shared-repos-v2-0-a83a7a09915d@bootlin.com>
In-Reply-To: <20250110-docs-build-shared-repos-v2-0-a83a7a09915d@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aBfFKImM3ZPzGDCiyEH+nh6ufDCwcrs4WGlib8ZwlTs=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBngT0WyUvfS8UVfQRq+akFWK8R45t7t8HMzC5eR
 Fz45tWrhWmJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ4E9FgAKCRDRgEFAKaOo
 NtjjEACeDXTTqdi3DcGVKv36KDv3uqyOwXPQ7srEfeLsmZbx8SFS+7EHLnSqnopQXahvQMVaDyt
 shpZXopkbq7RgGunlNY13OKpQOmAdMrOaJ4DIrVm01963KTTbwZL9OQ01e7Hk18dok2BZAvqldT
 1M0etwVEHnJWidc0Z+Bi+9Dso+2iLx+bhW8QDHPuYq/LoqU5Ni2JefzNGFDvGDqOsdWD2NW12z9
 eHRefwM7gAARyzwCxgyqFI0+j5xYJHlbXuQ2ZUQ8smiQxa3aNaQy2ccWSI7R6TXSJI24BTZ8pWu
 tU5SXutCTgKVMxmzhZXzBf4iNPWJbKu2x4bP1PSfrLlSfOgxIWhPfd474/fU3voMN+Ovx1dSUw/
 A/wQrhk9wn517AJQttqd8AutbdDsO+VR41Rf6VhJu3n3l2rjITfoFZxIsV0yU5bqXL5oG/r+jlI
 yVKw9z6M7Id+cAhRuokyRva1i2fr1DaN/RG/kO+j/DDbB8oOPOFO1jV0a0zDkAMycXJTzb76EDV
 yDpbh003xgUYp38QsxdD3BqRojIqiZLtgg8a6LOTRjUwLs29GGDQzKFhxP/I1eCObslCQYOSM7o
 GfULmWXdSRI21CyMNU5fZcqMOqzvMz13ULdTduYLZuE6UM3S8cSAoJT/6NPejTYH5SKxZYVV6px
 lUEJvuumYrWt10A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jan 2025 15:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/978

Unlike the ForceScheduler, the AnyBranchScheduler does not take a list
of parameters but a simple dict. Add a repos_dict_for_scheduler() helper
that returns a dict containing the {repo,branch}_<repo> keys mapping to
the values in config.py. These are used in the factory definition of the
docs build (see the Git steps).

Also add the missing "yab-helper" to the bitbake-docs-changed scheduler.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 schedulers.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index a3466d5b596bd0b1e8879a5acabf5ad66ee297a1..e4760ed8bf1d02f4edca9af87725cf116630a14b 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -322,6 +322,19 @@ def repos_for_builder(buildername):
         parameters = parameters + [util.NestedParameter(name='', label=repo, fields=inputs, columns=2)]
     return parameters
 
+def repos_dict_for_scheduler(buildername):
+    """
+    Returns a dict of repository properties for a scheduler.
+    """
+    props = {}
+    repos = config.buildertorepos.get(buildername)
+    if repos is None:
+        repos = config.buildertorepos["default"]
+    for repo in repos:
+        props["repo_{}".format(repo)] = config.repos[repo][0]
+        props["branch_{}".format(repo)] = config.repos[repo][1]
+    return props
+
 def parent_default_props(buildername, branchname=None):
     props = {}
     props["swat_monitor"] = True
@@ -593,6 +606,7 @@ schedulers.append(sched.AnyBranchScheduler(name="yocto-docs-changed",
             change_filter=util.ChangeFilter(project=["yocto-docs"], branch=[None, "master", "master-next", "styhead", "scarthgap", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "transition"]),
             codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             treeStableTimer=60,
+            properties=repos_dict_for_scheduler("docs"),
             builderNames=["docs"]))
 
 # If bitbake's sphinx docs change, trigger a build
@@ -603,10 +617,11 @@ def isbitbakeDocFile(change):
     return False
 schedulers.append(sched.AnyBranchScheduler(name="bitbake-docs-changed",
             change_filter=util.ChangeFilter(project=["bitbake"], branch=["master", "2.10", "2.8", "2.0"]),
-            codebases = ['', 'yocto-docs', 'bitbake'],
+            codebases = ['yab-helper', 'yocto-docs', 'bitbake'],
             fileIsImportant=isbitbakeDocFile,
             onlyImportant=True,
             treeStableTimer=60,
+            properties=repos_dict_for_scheduler("docs"),
             builderNames=["docs"]))
 
 # Run meta-webosose for kirkstone once a week on weekends (2am on Friday)

-- 
2.47.1


