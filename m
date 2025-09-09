Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42560CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:31:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.14945.1757428274287481050
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=EyUS6HYc;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DF65AC6B3AA;
	Tue,  9 Sep 2025 14:30:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9693060630;
	Tue,  9 Sep 2025 14:31:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABE3C102F287A;
	Tue,  9 Sep 2025 16:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428272; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AsQhuVmZu53zPgHQPMYqEbYTgT1TJgj+byzvW59Nq3k=;
	b=EyUS6HYcsKUk/HspatpSy5hxo8DSxLja06FZUHwqb3/BEGO8JxZQloQ/pV930jTrip2jvC
	pzRfpqbBzVigfagu5Fyh8ZaGrOmSaO/RJRvAPDwnZ0qGRHoTqfui2DUG+oahzUUpENW17/
	LvfY9YsG+YTmxnKJXKDgr3iP2xeIp1TZoObKk8+GRQ8xjqXnIrNr3mWD2OmrAAQwZNLhNU
	EMncxpwx0uQtRlmllx5a+fFYqkB6lyuR1+rz8BBh5n4qK1IrB/RkDS6N0XfjHGFSz4fFab
	UMgV0oMWLd+RmHmfFhKLkfRaShH39Cn56res3nkgAU92eWzu+qff7vSoBvt86A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 09 Sep 2025 16:31:03 +0200
Subject: [PATCH yocto-autobuilder2 v2 1/3] runconfig: Add build
 configuration as properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-contrib-mathieu-build_props-v2-1-14b809f99dfa@bootlin.com>
References: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
In-Reply-To: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428270; l=2364;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=WkyX/SycSQJAKiNpjSrVairz4MuPVxDxS2PHLo9gMRw=;
 b=kmNlnjb0B+gMRg2A1ww7aJ654XvHLIKC7ejWYEJEuRS4cqs55v3n5uAA6xirthWuFKOFK90+N
 g04+uGUgEVOAZS2GcOUYlI+Th/VkZPFfVsAhu2JkcXgBvXvIGoFwvzh
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:31:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2154

Add some important build configuration such as MACHINE or DISTRO to
buildbot build properties.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/runconfig.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/steps/runconfig.py b/steps/runconfig.py
index a6d0dbd42efe..27600231e606 100644
--- a/steps/runconfig.py
+++ b/steps/runconfig.py
@@ -160,7 +160,8 @@ class RunConfigCheckSteps(shell.ShellCommand):
     haltOnFailure = False
     flunkOnFailure = True
     jsonFileName = util.Interpolate("%(prop:builddir)s/runconfig.json")
-    logfiles = {'json': jsonFileName}
+    propertiesFileName = util.Interpolate("%(prop:builddir)s/runconfig-properties.json")
+    logfiles = {'json': jsonFileName, 'properties': propertiesFileName}
 
     def __init__(self, *args, **kwargs):
         self.posttrigger = kwargs.pop("posttrigger")
@@ -171,6 +172,8 @@ class RunConfigCheckSteps(shell.ShellCommand):
 
         self.log_observer_json = logobserver.BufferLogObserver()
         self.addLogObserver('json', self.log_observer_json)
+        self.log_observer_properties = logobserver.BufferLogObserver()
+        self.addLogObserver('properties', self.log_observer_properties)
 
     @defer.inlineCallbacks
     def run(self):
@@ -188,12 +191,21 @@ class RunConfigCheckSteps(shell.ShellCommand):
         # If the command fails, fall back to old style run-config execution
         rc = cmd.results()
         logLines = self.log_observer_json.getStdout()
+        propertiesLines = self.log_observer_properties.getStdout()
         jsonconfig = None
         try:
             jsonconfig = json.loads(logLines)
         except Exception as ex:
             self._addToLog('stderr', 'ERROR: unable to parse data, exception {}: {}'.format(ex.__class__, ex))
 
+        try:
+            properties = json.loads(propertiesLines)
+        except Exception as ex:
+            self._addToLog('stderr', 'INFO: unable to parse properties data, exception {}: {}'.format(ex.__class__, ex))
+        else:
+            for k, v in properties.items():
+                self.setProperty(k, v, "run-config output")
+
         if rc == FAILURE or not jsonconfig:
             steps = [get_runconfig_legacy_step(self.posttrigger)]
         else:

-- 
2.39.5


