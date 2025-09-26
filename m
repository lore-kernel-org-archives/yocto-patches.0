Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24708CAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 16:57:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.359.1758905872804667273
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 09:57:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GVRCY0Iq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e29d65728so16372415e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758905871; x=1759510671; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+eMjNMtTf8xEXS5v1FDozpg6eV9ny1KqGRMiU3Ob50=;
        b=GVRCY0Iq3nA8xAyBfZSmD2PgzN8mgM5xLRVnnDJLUb0ceBQYop3yOcZZZgLbnEMOEh
         XqH0GS98mlCfbPKYYPPfs1qae2JkcmOTCT3J1PpOqrihu4t3IZfDSq0+v3qltfXVc/iR
         cHo+GujKdNcSl1yHc1ihqHPxcMq+CPM0duKE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905871; x=1759510671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+eMjNMtTf8xEXS5v1FDozpg6eV9ny1KqGRMiU3Ob50=;
        b=kb5wh1wb7nIcp+Cc0/wBWKC4DmiBgqB8/3fdCBmqRIHz17REKY/wi0mT04U99BlbI3
         K0+pgWemGLSkszeU+vVHDgmhe3oyQz9+OfGZ4gZxsiwsuqPzYIyp+qSUsFCYP45gBmF6
         XUwPrB9meY4UeIugM5yuVHvT4C7PbcLCunXeC3t2hOiJQTtREjwZ2XIdM0clNBTT4ygP
         vW5yhI1ISH4CaUsgexou41rvM+KDBrsXwj72em8MjWXXVZ6xnGCwrZYtgdzKUABEKD6n
         1cTmSYeGULXiklQruC5ujWzjVx1fWNUnSIq6L+um8b9urDSbXa374HyZTAaHVcTZcwtK
         Zjrg==
X-Gm-Message-State: AOJu0Yxiqc0oim1h4wEMB/yY0XI3ANrfJIGCVtqcriCqpf9Jsa1zW/zl
	iVTAHEQS/tBisalgvJV7yVomToNUBjFvm2MANfa/oZnQeA6Y4M06HpzT9nsyv/Kz6akosK2j82H
	mkQZf
X-Gm-Gg: ASbGncuv4zodhQlllLj9CQ0KLwuyqUSaXtJ/+8DrAgcJ/6YpHrLs9XgWFuUJK+XQiQe
	tCnPvP4ueMM4+LZvyc+AvPXhlqQn3TfWd5Iu9cbd7e54tN3RdUuHkJxqnNbE5rLOgkwMr3J6viN
	iOzvbPSXJOXcp3gzHLCGpJSTrrtNT8huq5wt07IrSWakpeilAEcCMYWC3LENUSIm2FcTdgcwupg
	5hi/hkntu8g57BMs2noFLdtdFUJT2hBNHhqak0SugYqDpRfYVg6yywxAUlrWtrT1Lu2LFTA9h4B
	1+sz+bJAvrgD/Qp1U5wBOL3G3BKfarLa89EDT+r6i17dZu9E2g7XtQg0UmVGUTIzPUE1EloThGY
	qnOPjrye+SuB0XLRfevKNvqI5Lnot5twxX/aXduYr9DvNssCpUTo=
X-Google-Smtp-Source: AGHT+IFTHdsvz2YN6QeglPiaJS3tf8onlf9LCiG3txoeXI8PaomRO5DDrEUBGZuL/JNSWdQDmmLo1A==
X-Received: by 2002:a05:600c:698c:b0:46e:1abc:1839 with SMTP id 5b1f17b1804b1-46e329ba122mr79881215e9.15.1758905870550;
        Fri, 26 Sep 2025 09:57:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm8040330f8f.37.2025.09.26.09.57.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:57:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] builders: Write out an overrides file for bitbake-setup
Date: Fri, 26 Sep 2025 17:57:49 +0100
Message-ID: <20250926165749.31002-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 16:57:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2241

bitbake-setup can take an overrides file for repository information. Write
this out into all builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 builders.py               |  2 +
 steps/writebbsetupjson.py | 83 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 steps/writebbsetupjson.py

diff --git a/builders.py b/builders.py
index bf36c755..e519562e 100644
--- a/builders.py
+++ b/builders.py
@@ -121,6 +121,7 @@ def create_builder_factory():
     f.addStep(TargetPresent())
     f.addStep(steps.SetProperties(properties=ensure_props_set))
     f.addStep(WriteLayerInfo(name='Write main layerinfo.json', haltOnFailure=True))
+    f.addStep(WriteBBSetupJson(name='Write bbsetup-overrides.json', haltOnFailure=True))
     f.addStep(steps.ShellCommand(
         command=[util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/shared-repo-unpack"),
                  util.Interpolate("%(prop:builddir)s/layerinfo.json"),
@@ -298,6 +299,7 @@ def create_parent_builder_factory(buildername, waitname):
         haltOnFailure=True,
         name='Fetch yocto-autobuilder-helper'))
     factory.addStep(WriteLayerInfo(name='Write main layerinfo.json', haltOnFailure=True))
+    factory.addStep(WriteBBSetupJson(name='Write bbsetup-overrides.json', haltOnFailure=True))
     factory.addStep(steps.ShellCommand(
         command=[
             util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/prepare-shared-repos"),
diff --git a/steps/writebbsetupjson.py b/steps/writebbsetupjson.py
new file mode 100644
index 00000000..ae55d01a
--- /dev/null
+++ b/steps/writebbsetupjson.py
@@ -0,0 +1,83 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Author: Richard Purdie <richard.purdie@linuxfoundation.org>
+#
+
+from twisted.internet import defer
+from buildbot.process import buildstep
+import json
+import os
+
+import config
+
+mappings = {
+    "oecore" : "openembedded-core",
+}
+
+class WriteBBSetupJson(buildstep.ShellMixin, buildstep.BuildStep):
+    name = "WriteBBSetupJson"
+
+    def __init__(self, **kwargs):
+        buildstep.BuildStep.__init__(self, **kwargs)
+
+    def generateSetupJson(self):
+        setupdata = {}
+        setupdata["description"] = "Autobuilder generated bitbake setup json config"
+        setupdata["version"] = "1.0"
+        setupdata["sources"] = {}
+
+        writerepos = config.buildertorepos.get(self.getProperty("buildername"))
+        if not writerepos:
+            writerepos = config.buildertorepos["default"]
+
+        for repo in writerepos:
+            # poky is only used for older releases which don't use bitbake-setup
+            if repo == "poky":
+                continue
+
+            url = self.getProperty("repo_{}".format(repo))
+            branch = self.getProperty("branch_{}".format(repo))
+            revision = self.getProperty("commit_{}".format(repo))
+
+            if revision and revision != "HEAD":
+                rev = revision
+            else:
+                rev = branch
+
+            reponame = repo
+            if repo in mappings:
+                reponame = mappings[repo]
+            repodict = {
+                "git-remote": {
+                    "remotes" : {
+                        "origin": {
+                            "uri" : url
+                        }
+                    },
+                   "rev" : rev
+                }
+            }
+            setupdata["sources"] = {reponame : repodict}
+
+        return json.dumps(setupdata, sort_keys=True, indent=4,
+                          separators=(',', ': '))
+
+    @defer.inlineCallbacks
+    def run(self):
+        repojson = self.generateSetupJson()
+        layerinfo = os.path.join(self.getProperty("builddir"),
+                                 "bbsetup-overrides.json")
+        writerepos = "printf '%s' > %s" % (repojson, layerinfo)
+        cmd = yield self.makeRemoteShellCommand(
+            command=writerepos)
+        yield self.runCommand(cmd)
+        return cmd.results()
+
+
+@defer.inlineCallbacks
+def run(self):
+    cmd = RemoteCommand(args)
+    log = yield self.addLog('output')
+    cmd.useLog(log, closeWhenFinished=True)
+    yield self.runCommand(cmd)

