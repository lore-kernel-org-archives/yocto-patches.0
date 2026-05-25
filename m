Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45252CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 21:07:33 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24445.1779743244000985110
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 14:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Y0NeUucS;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490686877a1so8611095e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779743242; x=1780348042; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be6QxQhCpJJa+3P7Ok1ja9+b9aIMC/oo8aC/iGd/dnk=;
        b=Y0NeUucSHWv5+oNZ+1yKH77E0ZOdZFZsTSsmArS9oXkSz7Q8LKkHHgJ77BhCGwVvcU
         lipXlMf9J/t/h2mDqWJXhLJjglXql6FCySEQLNcnFHMDHhh0IRHAgpvBMUHiZCBljBv/
         9JDzQ+Hr64YLaa0VSDsSrGKSgaRbIKO8T/4lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779743242; x=1780348042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Be6QxQhCpJJa+3P7Ok1ja9+b9aIMC/oo8aC/iGd/dnk=;
        b=S1gWcnGwBNzNNePWOSo15wYWzZyLufPSXYiwHx6xilZVNWQs2iqDBQBPdgpMHGU0M0
         wMMvOtkSP6dswsH/sQRzGlmmfBmezNG/mYxa4AVPv8COya3SSIlQe1YfD3nYbDjHi7z3
         J+kRCRKE2YBpS7Cl3VfbgCJd72SAEcf4JwVb5IGy5mDBm+vm9E4xOSkN5aN1te7fh5Ra
         Qzn8mMtwq/auFFXv+dfUgaHYIM4mUdMDcOSoTr+wjU62U83rXpada+Rwh8iVFfaDhoso
         CXtw6W65qDLYrOGrLVa4bLOmYPD8En4YMoTo4GgQm4M55NM0lUzu73u+fQLxrPgAWjnS
         3B/Q==
X-Gm-Message-State: AOJu0YzkchuRJ8SZ83vu7LGyvcEXROgLj0NV/Satp2AlVRaClWGex1Om
	J5uTvqAmHJaC1qczTJ4I6K5jvObKdj50dg42/MWChbaygURTsFGh0b17tWIyBB6zkKXQMDxcmWn
	b5Seq
X-Gm-Gg: Acq92OFIywVYzY9OLUt+3Tyo/i7nTcSg6zcPH3kpQGSe8Y9i3EjHoffNtJ5SrJ7QSgo
	HPLoML+AfrGHgncqrIGo1qUZLmyu9CL+wASl9Ct/UL6Psrcuwj2tiJwL5N+GfwEDKbLJ04BXFCm
	Jvr0qeBnqjPmJUHVVjb5e7IO550/lalfNB0G7GDckbLir0va/7L6fPHZcukYsQ//vhsX8dwK3Tw
	fRXusm0r1ajA9wBkgSQo/x8l8vReZcKgpezPeMBu7zttt20b4KN6cCB8m/NuOBhGEbdPzyoeoTg
	c9xPCWBhuZ8+UmI2FQeUgaMxoo+PDvBqRfPYzaxQBJl/RkqJ8jIqMrSdnHqKpHvNbUCRYOWEwPO
	XwI/45GkZfDtXgEKqLCY0KJJ1mtC0dHXlW5YD+GvrB3D0XKXjBoNbZ/UlUW7daao/h8jhJpwqRp
	QSzjXqcqV0T8ICSThHG8/17NITTp9FwaVf7IeXxAwReHXbmw/fthprlYWAVN0QD7rhKjm5JQjmg
	znmhskEXB70c/HI/Szay9p8FXKz5Akz4KV4rw==
X-Received: by 2002:a05:600c:3b07:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-490420f67f5mr208593835e9.0.1779743242469;
        Mon, 25 May 2026 14:07:22 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm282941535e9.12.2026.05.25.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:07:22 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: Yocto Patches ML <yocto-patches@lists.yoctoproject.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 4/4] builders/runconfig: Terminate release builds if output directory already exists
Date: Mon, 25 May 2026 23:07:08 +0200
Message-ID: <20260525210708.2918572-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525210708.2918572-1-yoann.congal@smile.fr>
References: <20260525210708.2918572-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 21:07:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4052

From: Yoann Congal <yoann.congal@smile.fr>

Add a new step "CheckReleaseDir" that, on release builds, check if the
release artefact directory already exist, if it does, terminate the
build before corrupting it.

Fixes [YOCTO #15937]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 builders.py        |  3 ++-
 steps/runconfig.py | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builders.py b/builders.py
index 721adc5..40873a7 100644
--- a/builders.py
+++ b/builders.py
@@ -7,7 +7,7 @@ from buildbot.plugins import *
 from yoctoabb import config
 from yoctoabb.steps.writelayerinfo import WriteLayerInfo
 from yoctoabb.steps.writebbsetupjson import WriteBBSetupJson
-from yoctoabb.steps.runconfig import get_publish_dest, get_publish_resultdir, get_publish_name, RunConfigCheckSteps, TargetPresent
+from yoctoabb.steps.runconfig import get_publish_dest, get_publish_resultdir, get_publish_name, RunConfigCheckSteps, TargetPresent, CheckReleaseDir
 from buildbot.process.results import Results, SUCCESS, FAILURE, CANCELLED, WARNINGS, SKIPPED, EXCEPTION, RETRY
 from buildbot.process.remotecommand import RemoteCommand
 from buildbot.data import resultspec
@@ -317,6 +317,7 @@ def create_parent_builder_factory(buildername, waitname):
         mode='incremental',
         haltOnFailure=True,
         name='Fetch yocto-autobuilder-helper'))
+    factory.addStep(CheckReleaseDir(haltOnFailure=True))
     factory.addStep(WriteLayerInfo(name='Write main layerinfo.json', haltOnFailure=True))
     factory.addStep(WriteBBSetupJson(name='Write bbsetup-overrides.json', haltOnFailure=True))
     factory.addStep(steps.ShellCommand(
diff --git a/steps/runconfig.py b/steps/runconfig.py
index 18cdd7a..d52c7cd 100644
--- a/steps/runconfig.py
+++ b/steps/runconfig.py
@@ -237,3 +237,24 @@ class TargetPresent(shell.ShellCommand):
         cmd = yield self.makeRemoteShellCommand()
         yield self.runCommand(cmd)
         return self.evaluateCommand(cmd)
+
+class CheckReleaseDir(buildstep.BuildStep):
+    name = "Check if release directory already exists"
+    description = ["checking release directory"]
+    descriptionDone = ["checked release directory"]
+
+    def __init__(self, **kwargs):
+        buildstep.BuildStep.__init__(self, **kwargs)
+
+    @defer.inlineCallbacks
+    def run(self):
+        is_release = self.getProperty("is_release", False)
+        deploy_artefacts = self.getProperty("deploy_artefacts", False)
+        if is_release and deploy_artefacts:
+            dest = get_publish_internal(self.build.properties)
+            if dest and os.path.exists(dest):
+                self.descriptionDone = [f"Release directory {dest} already exists!"]
+                yield add_to_log(self, "error", f"Release directory already exists: {dest}\n")
+                return FAILURE
+        return SUCCESS
+

