Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6BBCA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:46:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.37.1757000781369211686
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:46:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DBrPNoat;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B70D74E40C32
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FE57606C4
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 132231C22DA0C;
	Thu,  4 Sep 2025 17:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6CYzS0KjsjSGzZR10x9z+MqSVq3yw5khmUl9jOOAsrU=;
	b=DBrPNoatJBe14IY6LDhHq6SQ5alX4FICnJ79s8IYez7aN+lwWVw3E4aQ8RBouUH9gsUFww
	yHGSlPQ80WCG+QghgMm/Brilq8+I3oKkrajdH0iSZLEFVZlrvmaGWPfg2Q9xHqz+F79kak
	Qr9Hvmk3ZaRF8Budx7fel5tWYMjNLxzL86SWkiPZre4qkVn2WS9s+0pEF1zk9zvBl77umE
	D1q3JTRTnW+f3eWvZZzpD9V02n/Jk456IvA+8tTtUAZAp1gZxVIdM8pUlOxoQqpIbirTnL
	7QTyFfdnOgB/faLAW7q/wNX0sCptM3ATh/Bm8hsgXuo4hKVsNjRv+wgZ3dDEcQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 04 Sep 2025 17:45:31 +0200
Subject: [PATCH yocto-autobuilder-helper 1/2] run-config: Generate a file
 with build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-contrib-mathieu-build_props-v1-1-28de412ac349@bootlin.com>
References: <20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com>
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000770; l=2962;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sYwc79wQqIwtFIVuEQUisamnoBaZ6DLr+SXyhnLlyTs=;
 b=QAirG7Xp07TiPTW5/9Mdea5v9b7vMnhfqZlyohLW1+t3a25bb+Q2ena0plGYdX5bBfUsj/9/v
 mP8paAxgMWzDyTPq3D8kGOcOWHlm7WFWsyDxysXJXcUVgeaU8Zg+UKF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:46:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2129

Extract some important build configuration values, allowing to add them
to buildbot properties.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/run-config | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/scripts/run-config b/scripts/run-config
index 98b48e55473c..4cc688533cef 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -15,6 +15,8 @@ import errno
 
 import utils
 
+exported_properties = ['DISTRO', 'MACHINE', 'SDKMACHINE', 'PACKAGE_CLASSES']
+
 parser = utils.ArgParser(description='Runs configurations in json.conf.')
 
 parser.add_argument('target',
@@ -60,6 +62,10 @@ parser.add_argument('-j', '--json-outputfile',
                     action='store',
                     default="",
                     help="the file to store json information about the build in")
+parser.add_argument('--properties-outputfile',
+                    action='store',
+                    default="",
+                    help="the file to store json information about build properties to add in")
 parser.add_argument('--stepname',
                     action='store',
                     default=None,
@@ -94,17 +100,26 @@ if arch == "qemux86" or arch == "qemux86-64":
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
 
@@ -379,6 +394,12 @@ elif args.phase == "finish" and args.stepname == "builddir-cleanup":
 if args.json_outputfile:
     with open(args.json_outputfile, "w") as f:
         json.dump(jsonconfig, f, indent=4, sort_keys=True)
+if args.properties_outputfile:
+    properties = {k: list(v)[0] if len(v) == 1 else list(v)
+                  for k, v in properties.items()}
+
+    with open(args.properties_outputfile, "w") as f:
+        json.dump(properties, f, indent=4, sort_keys=True)
 
 sys.exit(0)
 

-- 
2.39.5


