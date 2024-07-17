Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA2C3DA62
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 18:23:30 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.337.1721240605215158520
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jul 2024 11:23:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xf2wuMxp;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3678aa359b7so697549f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721240603; x=1721845403; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1iEYWFsTBKI13VdGZJnfO8Zsp7DcJ7o9orjvxzwTR8=;
        b=Xf2wuMxp3FGDdWxd0fiToV3QO5wwBZcNucFl3fbv+E+Jia3WgKGSGk7jCaf9XQy6Ed
         mhvBv9RxUwsznOiVOxATvrX2nKRDl90tQTaxYzyIX8Xsuv7fV/3BJQ7F5GZOyxh4zIds
         shIvotNzsx/oqt3/YUFv0IeCdepzrcCRub6WrGI2mo5eV1RbloRJEt5qJpqFr32eQZVo
         Ke1SwDeNpwStn+m2VJnHbfFJzmBLU2rqs8t9EGceF9mE1t87/Rt9/nttX3fjgzLLUIhR
         tsTI/68SiP/KWjKgKVDqcoQSwUP+Y65ulFbM6r4aRfH1dhqFVY8r1DKGLBNmGdjaIGsH
         8WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240604; x=1721845404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1iEYWFsTBKI13VdGZJnfO8Zsp7DcJ7o9orjvxzwTR8=;
        b=BHi6qGznjSYpR9Wj2NQZRLmzvETmppjkiOL9oCOjucFTO2axwOtonp09+TAQNdTc0U
         i3FGjqeMGAg/k80kLzIW5GLuSMoS9xfejrdRjsiM/RTM7BIyWtpDK8QQZur/Mkm3GwI/
         +obKOxE29/6Mdi3XegBn9viGSyygstb+RpnVJrAu9Vz4o6k6UnpupG/JPmu/fltaBRfg
         KJ5wlmpEVnOpLqXOzIZbinlGCkKAj2+7UAZ5oxYxS4BzIMobF+9PscNLvudPF/KBY+FQ
         cOTgcqN8+YmOD5pbP8yAH5iAuGxpS80C7yPDInoHfRDla9ZK447tRBRxXh04MMSfXkzG
         oqww==
X-Gm-Message-State: AOJu0YyJb8JSQDFc3EAOFlYgZhd2/3D6fEqh0XhmUM2ywZPm2/hgyA6C
	Vsv6SfjjASJTbfENpb+gTYCMyx+wJg9tGH3TdGBmuzxXq0vIYCa9/y1Wrg==
X-Google-Smtp-Source: AGHT+IFEOjPjYzFaKuoCT6NoQ+t6JJZEw3DHK6XXGEvViduyQJJdnv9tocowYDvar8P73AZnUAAhJQ==
X-Received: by 2002:a05:6000:ad1:b0:367:8e57:8 with SMTP id ffacd0b85a97d-3684b3e359amr302436f8f.19.1721240603140;
        Wed, 17 Jul 2024 11:23:23 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7799f2asm7157925e9.1.2024.07.17.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:23:22 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH 1/2] upgrade-helper: rewrite the code to update groups of recipes in lockstep
Date: Wed, 17 Jul 2024 20:23:18 +0200
Message-Id: <20240717182319.1661071-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 18:23:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/440

This support the changes in oe-core that group recipes if they share
common includes, and allow lockstep updates of items like
cmake and cmake-native, that previously would reliably fail when
updated separately.

The patch is invasive: the code throughout assumes that each
update transaction is for a single recipe, and adjusting that
to split the data into recipe-specific and update-specific parts
has to happen all over the place.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 modules/buildhistory.py  |  11 +-
 modules/statistics.py    |   6 +-
 modules/steps.py         |  73 +++++------
 modules/testimage.py     |  27 +++--
 modules/utils/devtool.py |   2 +-
 upgrade-helper.py        | 255 +++++++++++++++++++--------------------
 6 files changed, 192 insertions(+), 182 deletions(-)

diff --git a/modules/buildhistory.py b/modules/buildhistory.py
index e0f7191..0c13cb4 100644
--- a/modules/buildhistory.py
+++ b/modules/buildhistory.py
@@ -33,15 +33,16 @@ from utils.git import Git
 from utils.bitbake import *
 
 class BuildHistory(object):
-    def __init__(self, bb, pn, workdir):
+    def __init__(self, bb, group):
         self.bb = bb
-        self.pn = pn
-        self.workdir = workdir
+        self.group = group
+        self.pns = " ".join([p['PN'] for p in group['pkgs']])
+        self.workdir = group['workdir']
 
     def init(self, machines):
         for machine in machines:
             try:
-                self.bb.complete(self.pn, machine)
+                self.bb.complete(self.pns, machine)
             except Error as e:
                 for line in e.stdout.split("\n") + e.stderr.split("\n"):
                     # version going backwards is not a real error
@@ -67,4 +68,4 @@ class BuildHistory(object):
                         "w+") as log:
                     log.write(stdout)
         except bb.process.ExecutionError as e:
-            W( "%s: Buildhistory checking fails\n%s" % (self.pn, e.stdout))
+            W( "%s: Buildhistory checking fails\n%s" % (self.group['name'], e.stdout))
diff --git a/modules/statistics.py b/modules/statistics.py
index 77db151..864cce8 100644
--- a/modules/statistics.py
+++ b/modules/statistics.py
@@ -33,7 +33,7 @@ class Statistics(object):
         self.maintainers = set()
         self.total_attempted = 0
 
-    def update(self, pn, new_ver, maintainer, error):
+    def _update(self, pn, new_ver, maintainer, error):
         if type(error).__name__ == "UpgradeNotNeededError":
             return
         elif error is None:
@@ -63,6 +63,10 @@ class Statistics(object):
 
         self.total_attempted += 1
 
+    def update(self, group):
+        for p in group['pkgs']:
+            self._update(p['PN'],p['NPV'],p['MAINTAINER'],group['error'])
+
     def _pkg_stats(self):
         stat_msg = "Recipe upgrade statistics:\n\n"
         for status in self.upgrade_stats:
diff --git a/modules/steps.py b/modules/steps.py
index bde72db..08f47fd 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -34,24 +34,21 @@ from logging import critical as C
 from errors import *
 from buildhistory import BuildHistory
 
-def load_env(devtool, bb, git, opts, pkg_ctx):
-    pkg_ctx['workdir'] = os.path.join(pkg_ctx['base_dir'], pkg_ctx['PN'])
-    os.mkdir(pkg_ctx['workdir'])
-    pkg_ctx['env'] = bb.env(pkg_ctx['PN'])
-    pkg_ctx['recipe_dir'] = os.path.dirname(pkg_ctx['env']['FILE'])
-
-    if pkg_ctx['env']['PV'] == pkg_ctx['NPV']:
-        raise UpgradeNotNeededError
-
-def buildhistory_init(devtool, bb, git, opts, pkg_ctx):
+def load_env(devtool, bb, git, opts, group):
+    group['workdir'] = os.path.join(group['base_dir'], group['name'])
+    os.mkdir(group['workdir'])
+    for pkg_ctx in group['pkgs']:
+        pkg_ctx['env'] = bb.env(pkg_ctx['PN'])
+        pkg_ctx['recipe_dir'] = os.path.dirname(pkg_ctx['env']['FILE'])
+
+def buildhistory_init(devtool, bb, git, opts, group):
     if not opts['buildhistory']:
         return
 
-    pkg_ctx['buildhistory'] = BuildHistory(bb, pkg_ctx['PN'],
-            pkg_ctx['workdir'])
-    I(" %s: Initial buildhistory for %s ..." % (pkg_ctx['PN'],
+    group['buildhistory'] = BuildHistory(bb, group)
+    I(" %s: Initial buildhistory for %s ..." % (group['name'],
             opts['machines'][:1]))
-    pkg_ctx['buildhistory'].init(opts['machines'][:1])
+    group['buildhistory'].init(opts['machines'][:1])
 
 def _extract_license_diff(devtool_output):
     licenseinfo = []
@@ -75,12 +72,17 @@ def _extract_license_diff(devtool_output):
     D(" License diff extracted: {}".format(b"".join(licenseinfo).decode('utf-8')))
     return licenseinfo
 
-def devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
-    if pkg_ctx['NPV'].endswith("new-commits-available"):
-        pkg_ctx['commit_msg'] = "{}: upgrade to latest revision".format(pkg_ctx['PN'])
-    else:
-        pkg_ctx['commit_msg'] = "{}: upgrade {} -> {}".format(pkg_ctx['PN'], pkg_ctx['PV'], pkg_ctx['NPV'])
+def _make_commit_msg(group):
+    def _get_version(p):
+        if p['NPV'].endswith("new-commits-available"):
+            return "to latest revision".format(p['PN'])
+        else:
+            return "{} -> {}".format(p['PV'], p['NPV'])
 
+    pn = group['name']
+    return "{}: upgrade {}".format(pn, ",".join([_get_version(p) for p in group['pkgs']]))
+
+def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
     try:
         devtool_output = devtool.upgrade(pkg_ctx['PN'], pkg_ctx['NPV'], pkg_ctx['NSRCREV'])
         D(" 'devtool upgrade' printed:\n%s" %(devtool_output))
@@ -89,19 +91,23 @@ def devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
             raise DevtoolError("Running 'devtool upgrade' for recipe %s failed." %(pkg_ctx['PN']), devtool_output)
     except DevtoolError as e1:
         try:
-            devtool_output = devtool.reset(pkg_ctx['PN'])
-            _rm_source_tree(devtool_output)
+            devtool_output = devtool.reset()
         except DevtoolError as e2:
             pass
         raise e1
 
     license_diff_info = _extract_license_diff(devtool_output)
     if len(license_diff_info) > 0:
-        pkg_ctx['license_diff_fn'] = "license-diff.txt"
+        pkg_ctx['license_diff_fn'] = "license-diff-{}.txt".format(pkg_ctx['PV'])
         with open(os.path.join(pkg_ctx['workdir'], pkg_ctx['license_diff_fn']), 'wb') as f:
             f.write(b"".join(license_diff_info))
 
 
+def devtool_upgrade(devtool, bb, git, opts, group):
+    group['commit_msg'] = _make_commit_msg(group)
+    for p in group['pkgs']:
+        _devtool_upgrade(devtool, bb, git, opts, p)
+
 def _compile(bb, pkg, machine, workdir):
         try:
             bb.complete(pkg, machine)
@@ -118,17 +124,17 @@ def _compile(bb, pkg, machine, workdir):
             else:
                 raise CompilationError()
 
-def compile(devtool, bb, git, opts, pkg_ctx):
+def compile(devtool, bb, git, opts, group):
     if opts['skip_compilation']:
-        W(" %s: Compilation was skipped by user choice!" % pkg_ctx['PN'])
+        W(" %s: Compilation was skipped by user choice!" % group['name'])
         return
 
     for machine in opts['machines']:
-        I(" %s: compiling upgraded version for %s ..." % (pkg_ctx['PN'], machine))
-        _compile(bb, pkg_ctx['PN'], machine, pkg_ctx['workdir'])
+        I(" %s: compiling upgraded version for %s ..." % (group['name'], machine))
+        _compile(bb, " ".join([pkg_ctx['PN'] for pkg_ctx in group['pkgs']]), machine, group['workdir'])
         if opts['buildhistory'] and machine == opts['machines'][0]:
-            I(" %s: Checking buildhistory ..." % pkg_ctx['PN'])
-            pkg_ctx['buildhistory'].diff()
+            I(" %s: Checking buildhistory ..." % group['name'])
+            group['buildhistory'].diff()
 
 def _rm_source_tree(devtool_output):
     for line in devtool_output.split("\n"):
@@ -136,15 +142,14 @@ def _rm_source_tree(devtool_output):
             srctree = line.split()[4]
             shutil.rmtree(srctree)
 
-def devtool_finish(devtool, bb, git, opts, pkg_ctx):
+def devtool_finish(devtool, bb, git, opts, group):
     try:
-        devtool_output = devtool.finish(pkg_ctx['PN'], pkg_ctx['recipe_dir'])
-        _rm_source_tree(devtool_output)
-        D(" 'devtool finish' printed:\n%s" %(devtool_output))
+        for p in group['pkgs']:
+            devtool_output = devtool.finish(p['PN'], p['recipe_dir'])
+            D(" 'devtool finish' printed:\n%s" %(devtool_output))
     except DevtoolError as e1:
         try:
-            devtool_output = devtool.reset(pkg_ctx['PN'])
-            _rm_source_tree(devtool_output)
+            devtool_output = devtool.reset()
         except DevtoolError as e2:
             pass
         raise e1
diff --git a/modules/testimage.py b/modules/testimage.py
index fb2e467..6377368 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -42,12 +42,12 @@ def _pn_in_pkgs_ctx(pn, pkgs_ctx):
     return None
 
 class TestImage():
-    def __init__(self, bb, git, uh_work_dir, opts, packages, image):
+    def __init__(self, bb, git, uh_work_dir, opts, groups, image):
         self.bb = bb
         self.git = git
         self.uh_work_dir = uh_work_dir
         self.opts = opts
-        self.pkgs_ctx = packages['succeeded']
+        self.groups = groups['succeeded']
         self.image = image
 
         self.logdir = os.path.join(uh_work_dir, "testimage-logs")
@@ -56,22 +56,23 @@ class TestImage():
         os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] = os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] + \
             " CORE_IMAGE_EXTRA_INSTALL TEST_LOG_DIR TESTIMAGE_UPDATE_VARS"
 
-    def _get_pkgs_to_install(self, pkgs):
+    def _get_pkgs_to_install(self, groups):
         pkgs_out = []
 
-        for c in pkgs:
-            pkgs_out.append(c['PN'])
+        for g in groups:
+            for c in g['pkgs']:
+                pkgs_out.append(c['PN'])
 
-            I(" Checking if package {} has ptests...".format(c['PN']))
-            if 'PTEST_ENABLED' in self.bb.env(c['PN']):
-                I("  ...yes")
-                pkgs_out.append((c['PN']) + '-ptest')
-            else:
-                I("  ...no")
+                I(" Checking if package {} has ptests...".format(c['PN']))
+                if 'PTEST_ENABLED' in self.bb.env(c['PN']):
+                    I("  ...yes")
+                    pkgs_out.append((c['PN']) + '-ptest')
+                else:
+                    I("  ...no")
 
         return ' '.join(pkgs_out)
 
-    def testimage(self, pkgs_ctx, machine, image):
+    def testimage(self, groups, machine, image):
         os.environ['CORE_IMAGE_EXTRA_INSTALL'] = \
             self._get_pkgs_to_install(pkgs_ctx)
         os.environ['TEST_LOG_DIR'] = self.logdir
@@ -105,4 +106,4 @@ class TestImage():
     def run(self):
         machine = self.opts['machines'][0]
         I("  Testing image for %s ..." % machine)
-        self.testimage(self.pkgs_ctx, machine, self.image)
+        self.testimage(self.groups, machine, self.image)
diff --git a/modules/utils/devtool.py b/modules/utils/devtool.py
index c26061f..b3a9ce7 100644
--- a/modules/utils/devtool.py
+++ b/modules/utils/devtool.py
@@ -37,6 +37,6 @@ class Devtool(object):
         if recipe:
             cmd = " reset -n " + recipe
         else:
-            cmd = " reset -a"
+            cmd = " reset -n -a"
         return self._cmd(cmd)
 
diff --git a/upgrade-helper.py b/upgrade-helper.py
index e307d60..93a0bf3 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -277,18 +277,18 @@ class Updater(object):
 
         return enabled
 
-    def _get_packages_to_upgrade(self, packages=None):
+    def _get_packagegroups_to_upgrade(self, packages=None):
         if packages is None:
             I( "Nothing to upgrade")
             exit(0)
         else:
-            return packages
+            return [[p] for p in packages]
 
-    # this function will be called at the end of each recipe upgrade
-    def pkg_upgrade_handler(self, pkg_ctx):
+    # this function will be called at the end of each recipe group upgrade
+    def pkg_upgrade_handler(self, g):
         mail_header = \
             "Hello,\n\nthis email is a notification from the Auto Upgrade Helper\n" \
-            "that the automatic attempt to upgrade the recipe *%s* to *%s* has %s.\n\n"
+            "that the automatic attempt to upgrade the recipe(s) *%s* to *%s* has %s.\n\n"
 
         license_change_info = \
             "*LICENSE CHANGED* please review the %s file, update the LICENSE\n" \
@@ -313,51 +313,57 @@ class Updater(object):
             "Any problem please file a bug at https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Automated%20Update%20Handler\n\n" \
             "Regards,\nThe Upgrade Helper"
 
-        if pkg_ctx['MAINTAINER'] in maintainer_override:
-            to_addr = maintainer_override[pkg_ctx['MAINTAINER']]
-        elif 'global_maintainer_override' in settings:
-            to_addr = settings['global_maintainer_override']
+        to_addr = []
+        cc_addr = []
+        if 'global_maintainer_override' in settings:
+            to_addr = [settings['global_maintainer_override']]
         else:
-            to_addr = pkg_ctx['MAINTAINER']
+            for p in g['pkgs']:
+                maintainer = p['MAINTAINER']
+                if maintainer in maintainer_override:
+                    maintainer = maintainer_override[maintainer]
+                if 'unassigned' not in maintainer:
+                    to_addr.append(maintainer)
 
-        cc_addr = None
         if "cc_recipients" in settings:
-            if 'unassigned' in to_addr:
+            if not to_addr:
                 to_addr = settings["cc_recipients"].split()
             else:
                 cc_addr = settings["cc_recipients"].split()
 
-        newversion = pkg_ctx['NPV'] if not pkg_ctx['NPV'].endswith("new-commits-available") else pkg_ctx['NSRCREV']
-        subject = "[AUH] " + pkg_ctx['PN'] + ": upgrading to " + newversion
-        if not pkg_ctx['error']:
+        newversions = ",".join([pkg_ctx['NPV'] if not pkg_ctx['NPV'].endswith("new-commits-available") else pkg_ctx['NSRCREV'] for pkg_ctx in g['pkgs']])
+        pns = ",".join([pkg_ctx['PN'] for pkg_ctx in g['pkgs']])
+        subject = "[AUH] " + pns + ": upgrading to " + newversions
+        if not g['error']:
             subject += " SUCCEEDED"
         else:
             subject += " FAILED"
-        msg_body = mail_header % (pkg_ctx['PN'], newversion,
-                self._get_status_msg(pkg_ctx['error']))
+        msg_body = mail_header % (pns, newversions,
+                self._get_status_msg(g['error']))
 
-        if pkg_ctx['error'] is not None:
+        e = g['error']
+        if e is not None:
             msg_body += """Detailed error information:
 
 %s
 %s
 %s
 
-""" %(pkg_ctx['error'].message if pkg_ctx['error'].message else "", pkg_ctx['error'].stdout if pkg_ctx['error'].stdout else "" , pkg_ctx['error'].stderr if pkg_ctx['error'].stderr else "")
+""" %(e.message if e.message else "", e.stdout if e.stdout else "" , e.stderr if e.stderr else "")
 
-        if 'license_diff_fn' in pkg_ctx:
-            license_diff_fn = pkg_ctx['license_diff_fn']
-            msg_body += license_change_info % license_diff_fn
+        license_diffs = "\n".join([pkg_ctx['license_diff_fn'] for pkg_ctx in g['pkgs'] if 'license_diff_fn' in pkg_ctx])
+        if license_diffs:
+            msg_body += license_change_info % license_diffs
 
-        if 'patch_file' in pkg_ctx and pkg_ctx['patch_file'] != None:
-            msg_body += next_steps_info % (os.path.basename(pkg_ctx['patch_file']))
+        if 'patch_file' in g and g['patch_file'] != None:
+            msg_body += next_steps_info % (os.path.basename(g['patch_file']))
 
         msg_body += mail_footer
 
         # Add possible attachments to email
         attachments = []
-        for attachment in os.listdir(pkg_ctx['workdir']):
-            attachment_fullpath = os.path.join(pkg_ctx['workdir'], attachment)
+        for attachment in os.listdir(g['workdir']):
+            attachment_fullpath = os.path.join(g['workdir'], attachment)
             if os.path.isfile(attachment_fullpath):
                 attachments.append(attachment_fullpath)
                 # Also add the patch inline using the 'scissors':
@@ -368,7 +374,7 @@ class Updater(object):
         if self.opts['send_email']:
             self.email_handler.send_email(to_addr, subject, msg_body, attachments, cc_addr=cc_addr)
         # Preserve email for review purposes.
-        email_file = os.path.join(pkg_ctx['workdir'],
+        email_file = os.path.join(g['workdir'],
                     "email_summary")
         with open(email_file, "w+") as f:
             f.write("To: %s\n" % to_addr)
@@ -381,26 +387,28 @@ class Updater(object):
             f.write("Attachments: %s\n" % ' '.join(attachments))
             f.write("\n%s\n" % msg_body)
 
-    def commit_changes(self, pkg_ctx):
+    def commit_changes(self, g):
         try:
-            pkg_ctx['patch_file'] = None
+            g['patch_file'] = None
+            pns = ",".join([pkg_ctx['PN'] for pkg_ctx in g['pkgs']])
 
-            I(" %s: Auto commit changes ..." % pkg_ctx['PN'])
-            self.git.add(pkg_ctx['recipe_dir'])
-            self.git.commit(pkg_ctx['commit_msg'], self.opts['author'])
+            I(" %s: Auto commit changes ..." % pns)
+            for p in g['pkgs']:
+                self.git.add(p['recipe_dir'])
+            self.git.commit(g['commit_msg'], self.opts['author'])
 
-            stdout = self.git.create_patch(pkg_ctx['workdir'])
-            pkg_ctx['patch_file'] = stdout.strip()
+            stdout = self.git.create_patch(g['workdir'])
+            g['patch_file'] = stdout.strip()
 
-            if not pkg_ctx['patch_file']:
+            if not g['patch_file']:
                 msg = "Patch file not generated."
-                E(" %s: %s\n %s" % (pkg_ctx['PN'], msg, stdout))
+                E(" %s: %s\n %s" % (pns, msg, stdout))
                 raise Error(msg, stdout)
             else:
                 I(" %s: Save patch in directory: %s." %
-                    (pkg_ctx['PN'], pkg_ctx['workdir']))
+                    (pns, g['workdir']))
             revert_policy = settings.get('commit_revert_policy', 'failed_to_build')
-            if (pkg_ctx['error'] is not None and revert_policy == 'failed_to_build'):
+            if (g['error'] is not None and revert_policy == 'failed_to_build'):
                 I("Due to build errors, the commit will also be reverted to avoid cascading upgrade failures.")
                 self.git.revert("HEAD")
             elif revert_policy == 'all':
@@ -412,9 +420,9 @@ class Updater(object):
             for line in e.stdout.split("\n"):
                 if line.find("nothing to commit") == 0:
                     msg = "Nothing to commit!"
-                    I(" %s: %s" % (pkg_ctx['PN'], msg))
+                    I(" %s: %s" % (pns, msg))
 
-            I(" %s: %s" % (pkg_ctx['PN'], e.stdout))
+            I(" %s: %s" % (pns, e.stdout))
             raise e
 
     def send_status_mail(self, statistics_summary, attachments):
@@ -436,35 +444,35 @@ class Updater(object):
             W("No recipes attempted, not sending status mail!")
 
     def run(self, package_list=None):
-        pkgs_to_upgrade = self._get_packages_to_upgrade(package_list)
-        total_pkgs = len(pkgs_to_upgrade)
-
-        pkgs_ctx = {}
+        pkggroups_to_upgrade = self._get_packagegroups_to_upgrade(package_list)
+        total_pkggroups = len(pkggroups_to_upgrade)
 
+        pkggroups_ctx = []
         I(" ########### The list of recipes to be upgraded #############")
-        for pkg_to_upgrade in pkgs_to_upgrade:
-            I(" %s, %s, %s, %s, %s, %s" % (
-                pkg_to_upgrade["layer_name"],
-                pkg_to_upgrade["pn"],
-                pkg_to_upgrade["cur_ver"],
-                pkg_to_upgrade["next_ver"],
-                pkg_to_upgrade["maintainer"],
-                pkg_to_upgrade["revision"],
-            ))
-
-            p = pkg_to_upgrade["pn"]
-
-            pkgs_ctx[p] = {}
-            pkgs_ctx[p]['PN'] = p
-            pkgs_ctx[p]['PV'] = pkg_to_upgrade["cur_ver"]
-            pkgs_ctx[p]['NPV'] = pkg_to_upgrade["next_ver"]
-            pkgs_ctx[p]['MAINTAINER'] = pkg_to_upgrade["maintainer"]
-            pkgs_ctx[p]['NSRCREV'] = pkg_to_upgrade["revision"]
-
-            pkgs_ctx[p]['base_dir'] = self.uh_recipes_all_dir
+        for pkgs_to_upgrade in pkggroups_to_upgrade:
+            pkgs_ctx = []
+
+            for pkg_to_upgrade in pkgs_to_upgrade:
+                I(" %s, %s, %s, %s, %s, %s" % (
+                    pkg_to_upgrade["layer_name"],
+                    pkg_to_upgrade["pn"],
+                    pkg_to_upgrade["cur_ver"],
+                    pkg_to_upgrade["next_ver"],
+                    pkg_to_upgrade["maintainer"],
+                    pkg_to_upgrade["revision"],
+                ))
+
+                pkg_ctx = {}
+                pkg_ctx['PN'] = pkg_to_upgrade["pn"]
+                pkg_ctx['PV'] = pkg_to_upgrade["cur_ver"]
+                pkg_ctx['NPV'] = pkg_to_upgrade["next_ver"]
+                pkg_ctx['MAINTAINER'] = pkg_to_upgrade["maintainer"]
+                pkg_ctx['NSRCREV'] = pkg_to_upgrade["revision"]
+                pkgs_ctx.append(pkg_ctx)
+
+            pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_ctx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_all_dir})
         I(" ############################################################")
-
-        if pkgs_to_upgrade and not self.args.skip_compilation:
+        if pkggroups_ctx and not self.args.skip_compilation:
             I(" Building gcc runtimes ...")
             for machine in self.opts['machines']:
                 I("  building gcc runtime for %s" % machine)
@@ -479,30 +487,28 @@ class Updater(object):
                         import traceback
                         traceback.print_exc(file=sys.stdout)
 
-        succeeded_pkgs_ctx = []
-        failed_pkgs_ctx = []
-        attempted_pkgs = 0
-        for pkg_to_upgrade in pkgs_to_upgrade:
-            pn = pkg_to_upgrade["pn"]
-            pkg_ctx = pkgs_ctx[pn]
-            pkg_ctx['error'] = None
-
-            attempted_pkgs += 1
-            I(" ATTEMPT PACKAGE %d/%d" % (attempted_pkgs, total_pkgs))
+        succeeded_pkggroups_ctx = []
+        failed_pkggroups_ctx = []
+        attempted_pkggroups = 0
+        for g in pkggroups_ctx:
+            attempted_pkggroups += 1
+            pkggroup_name = g["name"]
+            I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total_pkggroups))
             try:
-                I(" %s: Upgrading to %s" % (pkg_ctx['PN'], pkg_ctx['NPV']))
+                for pkg_ctx in g['pkgs']:
+                    I(" %s: Upgrading to %s" % (pkg_ctx['PN'], pkg_ctx['NPV']))
                 for step, msg in upgrade_steps:
                     if msg is not None:
-                        I(" %s: %s" % (pkg_ctx['PN'], msg))
-                    step(self.devtool, self.bb, self.git, self.opts, pkg_ctx)
-                succeeded_pkgs_ctx.append(pkg_ctx)
+                        I(" %s: %s" % (pkggroup_name, msg))
+                    step(self.devtool, self.bb, self.git, self.opts, g)
+                succeeded_pkggroups_ctx.append(g)
 
-                I(" %s: Upgrade SUCCESSFUL! Please test!" % pkg_ctx['PN'])
+                I(" %s: Upgrade SUCCESSFUL! Please test!" % pkggroup_name)
             except Exception as e:
                 if isinstance(e, UpgradeNotNeededError):
-                    I(" %s: %s" % (pkg_ctx['PN'], e.message))
+                    I(" %s: %s" % (pkggroup_name, e.message))
                 elif isinstance(e, UnsupportedProtocolError):
-                    I(" %s: %s" % (pkg_ctx['PN'], e.message))
+                    I(" %s: %s" % (pkggroup_name, e.message))
                 else:
                     if not isinstance(e, Error):
                         import traceback
@@ -510,47 +516,47 @@ class Updater(object):
                         e = Error(message=msg)
                         error = e
 
-                    E(" %s: %s" % (pkg_ctx['PN'], e.message))
+                    E(" %s: %s" % (pkggroup_name, e.message))
 
-                    if 'workdir' in pkg_ctx and os.listdir(pkg_ctx['workdir']):
+                    if 'workdir' in g and os.listdir(g['workdir']):
                         E(" %s: Upgrade FAILED! Logs and/or file diffs are available in %s"
-                            % (pkg_ctx['PN'], pkg_ctx['workdir']))
+                            % (pkggroup_name, g['workdir']))
 
-                pkg_ctx['error'] = e
-                failed_pkgs_ctx.append(pkg_ctx)
+                g['error'] = e
+                failed_pkggroups_ctx.append(g)
 
             try:
-                self.commit_changes(pkg_ctx)
-            except:
-                if pkg_ctx in succeeded_pkgs_ctx:
-                    succeeded_pkgs_ctx.remove(pkg_ctx)
-                    failed_pkgs_ctx.append(pkg_ctx)
+                self.commit_changes(g)
+            except Exception as e:
+                import traceback
+                E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                if g in succeeded_pkggroups_ctx:
+                    succeeded_pkggroups_ctx.remove(g)
+                    failed_pkggroups_ctx.append(g)
 
         if self.opts['testimage']:
             ctxs = {}
-            ctxs['succeeded'] = succeeded_pkgs_ctx
-            ctxs['failed'] = failed_pkgs_ctx
+            ctxs['succeeded'] = succeeded_pkggroups_ctx
+            ctxs['failed'] = failed_pkggroups_ctx
             image = settings.get('testimage_name', DEFAULT_TESTIMAGE)
             tim = TestImage(self.bb, self.git, self.uh_work_dir, self.opts,
                    ctxs, image)
 
             tim.run()
 
-        for pn in pkgs_ctx.keys():
-            pkg_ctx = pkgs_ctx[pn]
+        for g in pkggroups_ctx:
 
-            if pkg_ctx in succeeded_pkgs_ctx:
-                os.symlink(pkg_ctx['workdir'], os.path.join( \
-                    self.uh_recipes_succeed_dir, pkg_ctx['PN']))
+            if g in succeeded_pkggroups_ctx:
+                os.symlink(g['workdir'], os.path.join( \
+                    self.uh_recipes_succeed_dir, g['name']))
             else:
-                os.symlink(pkg_ctx['workdir'], os.path.join( \
-                    self.uh_recipes_failed_dir, pkg_ctx['PN']))
+                os.symlink(g['workdir'], os.path.join( \
+                    self.uh_recipes_failed_dir, g['name']))
 
-            self.statistics.update(pkg_ctx['PN'], pkg_ctx['NPV'],
-                    pkg_ctx['MAINTAINER'], pkg_ctx['error'])
-            self.pkg_upgrade_handler(pkg_ctx)
+            self.statistics.update(g)
+            self.pkg_upgrade_handler(g)
 
-        if attempted_pkgs > 0:
+        if attempted_pkggroups > 0:
             publish_work_url = settings.get('publish_work_url', '')
             attach_tarball = settings.get('summary_includes_tarball', True)
             work_tarball = os.path.join(self.uh_base_work_dir,
@@ -666,17 +672,10 @@ class UniverseUpdater(Updater):
                         (pn, maintainer))
                 return False
 
-        # drop native/cross/cross-canadian recipes. We deal with native
-        # when upgrading the main recipe but we keep away of cross* pkgs...
-        # for now
-        if pn.find("cross") != -1 or pn.find("native") != -1:
-            D(" Skipping upgrade of %s: is cross or native" % pn)
-            return False
-
         return True
 
-    def _get_packages_to_upgrade(self, packages=None):
-    
+    def _get_packagegroups_to_upgrade(self, packages=None):
+
         # Prepare a single pkg dict data (or None is not upgradable) from recipeutils.get_recipe_upgrade_status data.
         def _get_pkg_to_upgrade(self, layer_name, pn, status, cur_ver, next_ver, maintainer, revision, no_upgrade_reason):
             pkg_to_upgrade = None
@@ -685,8 +684,7 @@ class UniverseUpdater(Updater):
                 next_ver = self.args.to_version
 
             if status == 'UPDATE' and not no_upgrade_reason:
-                # Always do the upgrade if recipes are specified
-                if self.recipes and pn in self.recipes or self._pkg_upgradable(pn, next_ver, maintainer):
+                if self._pkg_upgradable(pn, next_ver, maintainer):
                     pkg_to_upgrade = {
                         "layer_name": layer_name,
                         "pn": pn,
@@ -707,19 +705,20 @@ class UniverseUpdater(Updater):
 
             return pkg_to_upgrade
 
-        pkgs_list = []
+        upgrade_pkggroups = []
 
         for layer_name, layer_recipes in self.recipes:
-            pkgs = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
-
-            for pkg in pkgs:
-                pn, status, cur_ver, next_ver, maintainer, revision, no_upgrade_reason = pkg
-
-                pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pn, status, cur_ver, next_ver, maintainer, revision, no_upgrade_reason)
-                if pkg_to_upgrade:
-                    pkgs_list.append(pkg_to_upgrade)
-
-        return pkgs_list
+            pkggroups = oe.recipeutils.get_recipe_upgrade_status(layer_recipes)
+
+            for group in pkggroups:
+                upgrade_group = []
+                for pkg in group:
+                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], pkg['maintainer'], pkg['revision'], pkg['no_upgrade_reason'])
+                    if pkg_to_upgrade:
+                        upgrade_group.append(pkg_to_upgrade)
+                if upgrade_group:
+                    upgrade_pkggroups.append(upgrade_group)
+        return upgrade_pkggroups
 
     def pkg_upgrade_handler(self, pkg_ctx):
         super(UniverseUpdater, self).pkg_upgrade_handler(pkg_ctx)
-- 
2.39.2


