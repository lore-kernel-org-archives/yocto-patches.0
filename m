Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6DCA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:30 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.138.1757000959968737111
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=t82NfOlk;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0FD6C8F1EB;
	Thu,  4 Sep 2025 15:49:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2BD2606C4;
	Thu,  4 Sep 2025 15:49:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91D001C22DE12;
	Thu,  4 Sep 2025 17:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lefWDd7rkhMh21c35F+T3O0+deiFSbDQeSwcbOVdFNU=;
	b=t82NfOlkgCtT2uwhVRuypnugrwMz5u0bxwK+XKyHnvlP68endGQvx/0+HVdzXROEtlvV/H
	tUwPIQzzPoaBxoOP9CA40VA5qZ0yqAu6lAUv8djhCNRCZ9gOCDAM67XCjjHP4p6twDH7w+
	1KvpTdm0PMX+BhSUrTqF1QAgk5kvx2nNKWhbfcxoCiq/7B5OWurxQg3XQ0+BTN87HPed36
	QZAX1q7KkwR1cgXmd+M967qg2iks/sF2920v38tUJet96b/0WKPIocra99v0pR7hdR1Md2
	YyXyKG74+x0M54M+xb8RiUvBHVx2Gw03Q7rgaeTm2bBkH2fQXM50QFxLTs2F6Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 04 Sep 2025 17:48:49 +0200
Subject: [PATCH yocto-autobuilder2 1/3] runconfig: Add build configuration
 as properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-contrib-mathieu-build_props-v1-1-0ffaafcd01cb@bootlin.com>
References: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000954; l=2421;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=VkLZoQ9mj/l4YsR16lNXsfL62uT8FN5kRtTvaWfpo3M=;
 b=suOeSmws0gIqUh8wp6lWmcPFWZIrRwTXw50Nr9np8bawbGVkt/ikoAac0BpNWSLh4pNVMOdLL
 I7NYR+1vapvCcfgqlvD2bUw4HovlUiJi2E1fHD4XO+nWwBvq228CSyN
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:49:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2132

Add some important build configuration such as MACHINE or DISTRO to
buildbot build properties.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/runconfig.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/steps/runconfig.py b/steps/runconfig.py
index a6d0dbd42efe..4e1e704f9de8 100644
--- a/steps/runconfig.py
+++ b/steps/runconfig.py
@@ -160,17 +160,22 @@ class RunConfigCheckSteps(shell.ShellCommand):
     haltOnFailure = False
     flunkOnFailure = True
     jsonFileName = util.Interpolate("%(prop:builddir)s/runconfig.json")
-    logfiles = {'json': jsonFileName}
+    propertiesFileName = util.Interpolate("%(prop:builddir)s/runconfig-properties.json")
+    logfiles = {'json': jsonFileName, 'properties': propertiesFileName}
 
     def __init__(self, *args, **kwargs):
         self.posttrigger = kwargs.pop("posttrigger")
         self.command = get_runconfig_command(self.posttrigger)
         self.command.append("--json-outputfile")
         self.command.append(self.jsonFileName)
+        self.command.append("--properties-outputfile")
+        self.command.append(self.propertiesFileName)
         super().__init__(*args, **kwargs)
 
         self.log_observer_json = logobserver.BufferLogObserver()
         self.addLogObserver('json', self.log_observer_json)
+        self.log_observer_properties = logobserver.BufferLogObserver()
+        self.addLogObserver('properties', self.log_observer_properties)
 
     @defer.inlineCallbacks
     def run(self):
@@ -188,12 +193,17 @@ class RunConfigCheckSteps(shell.ShellCommand):
         # If the command fails, fall back to old style run-config execution
         rc = cmd.results()
         logLines = self.log_observer_json.getStdout()
+        propertiesLines = self.log_observer_properties.getStdout()
         jsonconfig = None
         try:
             jsonconfig = json.loads(logLines)
+            properties = json.loads(propertiesLines)
         except Exception as ex:
             self._addToLog('stderr', 'ERROR: unable to parse data, exception {}: {}'.format(ex.__class__, ex))
 
+        for k, v in properties.items():
+            self.setProperty(k, v, "run-config output")
+
         if rc == FAILURE or not jsonconfig:
             steps = [get_runconfig_legacy_step(self.posttrigger)]
         else:

-- 
2.39.5


