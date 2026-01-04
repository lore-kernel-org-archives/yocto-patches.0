Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C7C2A061
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 00:49:59 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35380.1767487790118682233
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 Jan 2026 16:49:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jQBdEFUD;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8010b8f078so1910960466b.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 Jan 2026 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487788; x=1768092588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBjgaE/9bgiSetYmWQrttafv5dJV0WZ4P80XEwRp5KE=;
        b=jQBdEFUDrpe6Hrp8xesbicQpRZPYHsXqDDWbw+9p8+LJZc/pzDinorwvqGivHPnhuH
         h1ACWcOpmQajhPAUlrkZbafGnQDyamGUoV8HomVKjvY7C1Rattm3Wzh4FocZH6ss4DTk
         hRoUf2+ADS54FZZgDrDZfBx6LO4SOL4BuWyE4y3hNJXEDH42Dtx8z3nwMp539o/yLbaf
         B4eucjnWO76jiRxWtL4rYI7xj+PWwaKpXIDwnDySCVGQ5iiH4Z1lg/6xjKfKhTGcrpRJ
         9GnUONtdaMXeAxfexG4vPoIaSlAx41FtlPXIuA/ppi7tGpN4V4sfVi/MhpmpXDHhIlR4
         8/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487788; x=1768092588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBjgaE/9bgiSetYmWQrttafv5dJV0WZ4P80XEwRp5KE=;
        b=CpIvFhlhAAu9HCX3JJTdzJeKtn3n61kIF0hcX8uNkbVzIQ6hBDIohheyMV6FwBjBV0
         3mhZUJU4f7NwmMmB7zl+saTgNBrhCdp0Ype+6w3wXUwJtEpz73mDjtRsqfNVtGQohg5V
         t/Tk3JjAnFja1T0+wHAIZhFHgSf3QeRswlqkqZwoei09P7ylUZZ7ql2fSzapxSe9UJkF
         2W3z+FpBXJOqsh13l16pMOOVUCelqmTEkn5ZonvD5k0DmgDJV8Rz0gdE9CtyXd9hGsZT
         is7tD6t25o7JtVVYB3j/8mTijJ/4OVMKUroTy1/Oao1+qwO1CCBy/0IMv/j4l1gmwT86
         Ng4Q==
X-Gm-Message-State: AOJu0YzfL8dEKqWOhw+JFm8yh3a4aRyXpnc3TfLQ5Q4V6Y5XYkgdI1W/
	jC2C2tijMzuWwCieK7JPCjwn296ECkwMmBEEega3PIiX+6rRQnxdHLUbIZLtGxmG
X-Gm-Gg: AY/fxX4G11ChklKPZs7x3koEQ8deXnA9X9LVvbb6H8y9GpNLz5p80r8vz4XyESLCRLM
	EcQi5veNVLzY5L84Qyu5tws20y+JOsMjZo8o83c758SVCuigzPosLA3BI1ULkTsZSXSq8GVjT5U
	P7XUep2D2ZSscKD8HOpT8yNwmX9QD+RlCczPeuVSqsS3qDMOkNtZFTFls/JfZGJE4srAyji7LA6
	hLVzcl4N9+Kh3SePCXGpxNhH3KteY5ZiDgi+mJ/7hTm3gjvLlcUGSk19lLEalyCukox0FKmMVCO
	FdBLMPUNXItXdnloWmiRtK/da8dtYRWdDh5VrFhENuLNyYZYe1QgwJSNc1CeZBQoAPW71N8tVIc
	k9jQ+LuwSZx/9YUlw9Pj0zf8zNqra52qMpPY8d59HfC1zdvZlsRtLraVcrNwunJS+EXLI4J+CVn
	CxBhdNATVI3kozY2ddCRWIADOrHkJ7wMGpraBrPQXvl48eotTU0uRuUtZDhw/i1sTV
X-Google-Smtp-Source: AGHT+IGt4PnWk68fz3bC+22PQxlia9G91AJlLuX29C95OhnAg5VgOMmrzDQVNwAjJ1NNJugNw17nUg==
X-Received: by 2002:a17:907:7213:b0:b76:277b:9a5b with SMTP id a640c23a62f3a-b8036f0a536mr4317149766b.6.1767487787937;
        Sat, 03 Jan 2026 16:49:47 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5104839066b.10.2026.01.03.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:49:47 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 4/5] Fix linting errors reported by ruff
Date: Sun,  4 Jan 2026 01:47:03 +0100
Message-ID: <20260104004708.2494403-8-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
References: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 Jan 2026 00:49:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2892

Ruff (or any other linter) should not report any errors when run on the
codebase. This patch fixes various such errors.

---
 modules/buildhistory.py  |  6 +++---
 modules/steps.py         |  8 ++++----
 modules/testimage.py     |  3 +--
 modules/utils/bitbake.py |  2 +-
 modules/utils/devtool.py |  3 ++-
 modules/utils/git.py     |  3 ++-
 upgrade-helper.py        | 17 +++++++----------
 7 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/modules/buildhistory.py b/modules/buildhistory.py
index 407a1e5..c045a73 100644
--- a/modules/buildhistory.py
+++ b/modules/buildhistory.py
@@ -20,11 +20,11 @@
 #
 
 import os
+import re
 from logging import warning as W
 
-from errors import *
-from utils.git import Git
-from utils.bitbake import *
+from errors import Error
+from utils.bitbake import bb
 
 class BuildHistory(object):
     def __init__(self, bb, group):
diff --git a/modules/steps.py b/modules/steps.py
index 93cb3a6..f7dd5c5 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -27,7 +27,7 @@ from logging import debug as D
 from logging import info as I
 from logging import warning as W
 
-from errors import *
+from errors import Error, DevtoolError, CompilationError
 from buildhistory import BuildHistory
 
 def load_env(devtool, bb, git, opts, group):
@@ -59,9 +59,9 @@ def _extract_license_diff(devtool_output):
                 for line in lines:
                      if line.startswith(b'# FIXME: the LIC_FILES_CHKSUM'):
                          extracting = True
-                     elif extracting == True and not line.startswith(b'#') and len(line) > 1:
+                     elif extracting and not line.startswith(b'#') and len(line) > 1:
                          extracting = False
-                     if extracting == True:
+                     if extracting:
                          licenseinfo.append(line[2:])
                      else:
                          f.write(line)
@@ -71,7 +71,7 @@ def _extract_license_diff(devtool_output):
 def _make_commit_msg(group):
     def _get_version(p):
         if p['NPV'].endswith("new-commits-available"):
-            return "to latest revision".format(p['PN'])
+            return "to latest revision"
         else:
             return "{} -> {}".format(p['PV'], p['NPV'])
 
diff --git a/modules/testimage.py b/modules/testimage.py
index 85ee4f3..b96782d 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -25,8 +25,7 @@ import os
 
 from logging import info as I
 
-from errors import *
-from utils.bitbake import *
+from errors import Error
 
 def _pn_in_pkgs_ctx(pn, pkgs_ctx):
     for c in pkgs_ctx:
diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index ad011db..5514c98 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -28,7 +28,7 @@ from logging import debug as D
 import sys
 import re
 
-from errors import *
+from errors import Error, EmptyEnvError
 
 for path in os.environ["PATH"].split(':'):
     if os.path.exists(path) and "bitbake" in os.listdir(path):
diff --git a/modules/utils/devtool.py b/modules/utils/devtool.py
index d4b7ba7..4d4307f 100644
--- a/modules/utils/devtool.py
+++ b/modules/utils/devtool.py
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 from logging import debug as D
 
-from utils.bitbake import *
+from utils.bitbake import bb
+from errors import DevtoolError
 
 class Devtool(object):
     def __init__(self):
diff --git a/modules/utils/git.py b/modules/utils/git.py
index abc1acc..3be75bf 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -26,7 +26,8 @@
 import os
 from logging import debug as D
 
-from utils.bitbake import *
+from utils.bitbake import bb
+from errors import Error
 
 class Git(object):
     def __init__(self, dir):
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 93a0bf3..165fd42 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -49,11 +49,11 @@ import shutil
 sys.path.insert(1, os.path.join(os.path.abspath(
     os.path.dirname(__file__)), 'modules'))
 
-from errors import *
+from errors import Error, EmptyEnvError, UpgradeNotNeededError, UnsupportedProtocolError
 
 from utils.git import Git
 from utils.devtool import Devtool
-from utils.bitbake import *
+from utils.bitbake import Bitbake, get_build_dir
 from utils.emailhandler import Email
 
 from statistics import Statistics
@@ -66,7 +66,6 @@ if not os.getenv('BUILDDIR', False):
     E(" $ . oe-init-build-env build-auh\n")
     exit(1)
 
-import shutil
 # Use the location of devtool to find scriptpath and hence bb/oe libs
 scripts_path = os.path.abspath(os.path.dirname(shutil.which("devtool")))
 sys.path = sys.path + [scripts_path + '/lib']
@@ -235,7 +234,7 @@ class Updater(object):
 
         if settings.get("buildhistory", "no") == "yes":
             if 'buildhistory' in self.base_env['INHERIT']:
-                if not 'BUILDHISTORY_COMMIT' in self.base_env:
+                if 'BUILDHISTORY_COMMIT' not in self.base_env:
                     E(" Buildhistory was INHERIT in conf/local.conf"\
                       " but need BUILDHISTORY_COMMIT=1 please set.")
                     exit(1)
@@ -263,7 +262,7 @@ class Updater(object):
 
         if settings.get("testimage", "no") == "yes":
             if 'testimage' in self.base_env['IMAGE_CLASSES']:
-                if not "ptest" in self.base_env["DISTRO_FEATURES"]:
+                if "ptest" not in self.base_env["DISTRO_FEATURES"]:
                     E(" testimage requires ptest in DISTRO_FEATURES please add to"\
                       " conf/local.conf.")
                     exit(1)
@@ -355,7 +354,7 @@ class Updater(object):
         if license_diffs:
             msg_body += license_change_info % license_diffs
 
-        if 'patch_file' in g and g['patch_file'] != None:
+        if 'patch_file' in g and g['patch_file'] is not None:
             msg_body += next_steps_info % (os.path.basename(g['patch_file']))
 
         msg_body += mail_footer
@@ -514,7 +513,6 @@ class Updater(object):
                         import traceback
                         msg = "Failed(unknown error)\n" + traceback.format_exc()
                         e = Error(message=msg)
-                        error = e
 
                     E(" %s: %s" % (pkggroup_name, e.message))
 
@@ -617,7 +615,6 @@ class UniverseUpdater(Updater):
         recipe_regex = re.compile('^(?P<name>.*):$')
         layer_regex = re.compile('^  (?P<name>.*) +')
 
-        layers = False
         name = ''
 
         output = subprocess.check_output('bitbake-layers show-recipes',
@@ -628,7 +625,7 @@ class UniverseUpdater(Updater):
                 name = s.group('name')
                 continue
 
-            if not 'skipped' in line:
+            if 'skipped' not in line:
                 s = layer_regex.search(line)
                 if s:
                     if s.group('name').strip() == layer:
@@ -667,7 +664,7 @@ class UniverseUpdater(Updater):
                     found = True
                     break
 
-            if found == False:
+            if not found:
                 D(" Skipping upgrade of %s: maintainer \"%s\" not in whitelist" %
                         (pn, maintainer))
                 return False
-- 
2.43.0


