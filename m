Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A980CAC58D
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:30:44 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.15008.1757428238304177601
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WUbgFxx1;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D536F4E40884
	for <yocto-patches@lists.yoctoproject.org>; Tue,  9 Sep 2025 14:30:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AFEFA60630
	for <yocto-patches@lists.yoctoproject.org>; Tue,  9 Sep 2025 14:30:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08100102F287A;
	Tue,  9 Sep 2025 16:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jEyBrJZSgMjpzjiKNxR4r6U8lhvzQlWGu2176Y5VXhw=;
	b=WUbgFxx159YPQviqiBtpxNGk6BArS6KeulwLwDANj3W1G9if4ol3ZydnFBE7qAJGG3/7Qd
	napuXZK6AqHbgHoyAer4K3rVtVJBuI7JtyUqAuYKPXJSTMFXg/RRHLIwwMpmPHekUjAnWM
	fRDCeCTmvw5lBZFDqIvkHGL+Tyx/sy942m2bxdXxRduABBkBTDrBWbZX9p2VJT8uwuKeB2
	0jm2eeosSSUBQ7OQFSBBSytLnW4GtfgG+67hPeF0aLIpTyy4EzLldpXUqtOX1wU1r4GIEN
	/n+O0/K55//Svh8spfj+OcMRk61aPpQaQhL5k2KczMsqtrEnTyO0w+PKEywPKg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 09 Sep 2025 16:30:00 +0200
Subject: [PATCH yocto-autobuilder-helper v2 1/2] run-config: Generate a
 file with build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-contrib-mathieu-build_props-v2-1-b607bb47be08@bootlin.com>
References: <20250909-contrib-mathieu-build_props-v2-0-b607bb47be08@bootlin.com>
In-Reply-To: <20250909-contrib-mathieu-build_props-v2-0-b607bb47be08@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428233; l=3364;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=zE1S6t7Y8rj4PWWbTDlZ3rwPb/GT7N257HzWV0I6d2w=;
 b=DJQ7pK9o/gKkvXZvx/vGcJQK7ZpZMRvNskkQonvCVk0+/YxdvGUJ/q2jgCJYS1LOvOd7WE2nU
 gpH1b222AQjDjk2hq19poRiecFvP5JrBRed5XDilNDIR4FbV1QCHsEx
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2150

Extract some important build configuration values, allowing to add them
to buildbot properties. Output filename is based on the one of
--json-outputfile, so no additional argument is needed: the arguments
list remain the same in all yocto-autobuilder-helper branches, with or
without this commit.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/run-config | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/scripts/run-config b/scripts/run-config
index 98b48e55473c..1bde354c5dcf 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -11,10 +11,12 @@ import json
 import os
 import sys
 import subprocess
-import errno
+import pathlib
 
 import utils
 
+exported_properties = ['DISTRO', 'MACHINE', 'SDKMACHINE', 'PACKAGE_CLASSES']
+
 parser = utils.ArgParser(description='Runs configurations in json.conf.')
 
 parser.add_argument('target',
@@ -58,7 +60,8 @@ parser.add_argument('--workername',
                     help="the name of the worker the build is running on")
 parser.add_argument('-j', '--json-outputfile',
                     action='store',
-                    default="",
+                    default=None,
+                    type=pathlib.Path,
                     help="the file to store json information about the build in")
 parser.add_argument('--stepname',
                     action='store',
@@ -94,17 +97,26 @@ if arch == "qemux86" or arch == "qemux86-64":
 else:
     ourconfig["HELPERSTMACHTARGS"] = "-a -t machine -t toolchain-user"
 
-# Find out the number of steps this target has
+# Find out the number of steps this target has and properties
 maxsteps = 0
 stepnum = 0
+properties = {}
 if args.target in ourconfig['overrides']:
+    target = ourconfig['overrides'][args.target]
     maxsteps = 1
-    for v in ourconfig['overrides'][args.target]:
+    for v in target:
         if v.startswith("step"):
             n = int(v[4:])
-            if n <= maxsteps:
-                continue
-            maxsteps = n
+            if n > maxsteps:
+                maxsteps = n
+
+            # Get properties values for this build step, falling back to
+            # defaults if they are not set.
+            for prop in exported_properties:
+                for propdict in (target[v], target, ourconfig['defaults']):
+                    if prop in propdict:
+                        properties.setdefault(prop, set()).add(propdict[prop])
+                        break
 
 hp.printheader("Target task %s has %d steps" % (args.target, maxsteps))
 
@@ -377,8 +389,15 @@ elif args.phase == "finish" and args.stepname == "builddir-cleanup":
         runcmd(["mv", args.builddir, args.builddir + "-renamed"])
 
 if args.json_outputfile:
-    with open(args.json_outputfile, "w") as f:
+    with args.json_outputfile.open("w") as f:
         json.dump(jsonconfig, f, indent=4, sort_keys=True)
 
+    properties_outfile = args.json_outputfile.with_stem(f"{args.json_outputfile.stem}-properties")
+    properties = {k: list(v)[0] if len(v) == 1 else list(v)
+                  for k, v in properties.items()}
+
+    with properties_outfile.open("w") as f:
+        json.dump(properties, f, indent=4, sort_keys=True)
+
 sys.exit(0)
 

-- 
2.39.5


