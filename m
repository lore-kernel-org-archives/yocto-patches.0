Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105FF8E49E
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 01:41:20 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32255.1776390070324411727
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 18:41:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GaGaT+1s;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d95017a68so118390a91.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776390069; x=1776994869; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j861QpcgGuEzH8MbCrrqG9qBq15j7mIjZbMIuJn9B4s=;
        b=GaGaT+1s9dTnJO+z0FTlCAL6ZlrpFqpFZzW1HyPtXPdSccgZFhlx1J3uZ30YWJ6xLK
         yWvIvNslOBKSB1RepXt6SJVdt8Vw2SPc/HhNGh17hRoaaihUivcEGJ+Ny3dxPUSPm3Bb
         QYI1MPjm7brSnGCw17nU5gP+/DZ1IJFv135omsTQxx1ajS5y2AOLQ1dn3L4kN9Exu3pn
         lMFUlDS27WoQnHJzm/Jz5ls3BM0wo4MVubjMD4f8bFLBbiXEl6sAFm+/35Su34pdzY/i
         NCMCxI6ghzA40cSx+A5YG5MNgSZ03WhGIk6Va4oTZGxq8SoXWy45mDCFn6+554mCkLE8
         YmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776390069; x=1776994869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j861QpcgGuEzH8MbCrrqG9qBq15j7mIjZbMIuJn9B4s=;
        b=BieFWffWaDcxPdXbBdBxIbnHTMiKUJrSUF74nTqp/Rg6ves2Bq9YYyhBt/s9JCrtEn
         iRYHQmwIuCKF8zLv+pRPLZC8rhAdT5m98Ez3lUu9NFJ6GW/amgFpOHV6CSaZbVm0xokf
         WLrQAheoc47X8sWNJ9ITWhmOW/qMQslPTbyZPkU4ftaH0L8qHUd1Curcg+0rhVKd1x+/
         6zzUFfX4MNPWYioBX/97/7aeZ2nYN2CIHrJkQIgFqzelP60O42csoh4vcjhJElMzMM/U
         U1LWpMPBF70GeK19MeW98jVdX8WxNiuMUIin866uR9A0CjSEJAv7XvHmIKL6kSRalO8o
         jQWA==
X-Gm-Message-State: AOJu0YwGGCCjM4J7H/EGCx0r88AGBkY4SMb4ac7AdK2YCmUrsemXDSE9
	IE83gmHENo60IqxuNrTelbasS1eP/wamjRPJsynKQ28PMX815F82UWNEmumlKD8M9UM=
X-Gm-Gg: AeBDieuNclns50YbjYZUuKBVoRXNQqO4WGwjh2KHyly01m1UQrQltb7McSMpkWtz4zK
	QXsJV06/aPB+Y7na43qFIBlgdZ6rjtKXRZdvC7OFgQqbtQviuyyod8WEpjuVrxos4hfkCx/rQvi
	+bVHVn8lwe7a827kOBW5r/5KgzcwBKjnNw5PU2QyL5riuQrALkl8bg4bUo+mw6qOiEOvk4K4VAs
	O0hpuZRnewzYzF0cJPJZbUGrJ1z/+mxVZBlQO0MptVw2zdoNcKzr6kKdxDmfm32TUXlxwH/JIfC
	WNQtSNvVMkMnkQFIvLRinFyOHCpeauQEuxlvtkoqTo+XrACaOvVZUqMpvv0putZCbx8eXL+cUKz
	aWLrNZXKB05qVeHPoS5Hc2xIVizt6etwNIcdnTYPS5+JeArPeHc0ykt0Y/VReVBVFyb+hfV6wKs
	Ork0bFvJqg0BrHjcAp1FyckA/Eq0N2VVs+mbxWKix7G79KLK9HFwHWQhBEcZ7dSWvC62i09rp+v
	LewiL4uOjo61JLNvhy1A3JPJe0dAWIt
X-Received: by 2002:a17:90b:2f0c:b0:35b:a9f3:62ee with SMTP id 98e67ed59e1d1-361404b247cmr826056a91.27.1776390069023;
        Thu, 16 Apr 2026 18:41:09 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa810cesm183904a91.3.2026.04.16.18.41.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 18:41:08 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder2][RFC] master.cfg: Replace pkg_resources with importlib.metadata
Date: Thu, 16 Apr 2026 18:37:59 -0700
Message-ID: <20260417013758.91120-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Apr 2026 01:41:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3725

pkg_resources (from setuptools) is deprecated. Replace the fake
Distribution/EntryPoint/working_set manipulation with
importlib.metadata equivalents:

- Intercept importlib.metadata.version() for the local plugin, since
  buildbot's Application() calls it at import time before the plugin
  is registered.
- Use importlib.metadata.EntryPoint directly instead of the old
  pkg_resources.EntryPoint.parse() plus fake Distribution approach.
- Remove the now-unused os import.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This has been working for me on my local AB cluster, where the
controller is running on a Debian 13 AMD Ryzen system.

 master.cfg | 61 +++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/master.cfg b/master.cfg
index 63119ca..55312ef 100644
--- a/master.cfg
+++ b/master.cfg
@@ -1,46 +1,47 @@
 # -*- python -*-
 # ex: set filetype=python:
 
-import os
 import importlib
-import pkg_resources
-
-from buildbot.plugins import *
-from buildbot.plugins import db
-from yoctoabb import builders, config, schedulers, workers, services, www
+import importlib.metadata
+from importlib.metadata import EntryPoint
 
 #
-# Prepare to feel ill
+# Buildbot discovers www plugins via entry points. Since the yocto_console_view
+# plugin lives in this repo rather than being installed as a package, we need
+# two workarounds:
 #
-# Buildbot uses plugins from pkg_resources, i.e. things which are installed
-# For the Yocto autobuilder, we want the plugin from this repo/directory.
+# 1. Buildbot's Application() calls importlib.metadata.version() at import
+#    time, so we intercept that to return a version for our local plugin
+#    before any yoctoabb imports occur.
 #
-# Firstly we therefore have to create a dummy pkg_resources entry/distribution
-# which we add into the global working set. Ugly. It gets worse.
+# 2. The get_plugins('www') call from www/service.py happens before this
+#    master.cfg file is parsed, so we create an EntryPoint directly and
+#    register it into buildbot's internal plugin DB.
 #
-# The get_plugins('www') call from www/service.py happens before this
-# master.cfg file is parsed, which means our plugin won't be found. There
-# is no API to rescan for plugins. We therefore so some horrible internal
-# API monkey patching to add ourselves into the internal list.
 
-# Create a fake distribution to insert into the global working_set
-us = os.path.dirname(os.path.realpath(__file__))
-d = pkg_resources.Distribution(us + "/yocto_console_view", metadata=None, project_name="yocto_console_view", version="0.0.1")
+# Handle importlib.metadata.version() for our uninstalled local plugin.
+# This must happen before importing yoctoabb, since that triggers
+# Application().__init__ which calls importlib.metadata.version().
+_orig_metadata_version = importlib.metadata.version
+def _local_metadata_version(name):
+    if name == 'yoctoabb.yocto_console_view.yocto_console_view':
+        return '0.0.1'
+    return _orig_metadata_version(name)
+importlib.metadata.version = _local_metadata_version
 
-# Create the fake entry point definition
-ep = pkg_resources.EntryPoint.parse("yocto_console_view = yoctoabb.yocto_console_view.yocto_console_view:ep", dist=d)
-
-# Add the mapping to the fake EntryPoint
-d._ep_map = {'buildbot.www': {'yocto_console_view': ep}}
+from buildbot.plugins import *
+from buildbot.plugins import db
+from yoctoabb import builders, config, schedulers, workers, services, www
 
-# Add the fake distribution to the global working_set
-pkg_resources.working_set.add(d)
+ep_entry = EntryPoint(
+    name='yocto_console_view',
+    value='yoctoabb.yocto_console_view.yocto_console_view:ep',
+    group='buildbot.www'
+)
 
-# Now monkey patch us into buildbot's plugins DB
-for entry in pkg_resources.iter_entry_points('buildbot.www'):
-    if entry.name == "yocto_console_view":
-        plugindb = db._DB._namespaces['www']
-        plugindb._real_tree.add(entry.name, db._PluginEntry('buildbot.www', entry, plugindb._load_entry))
+# Register the plugin directly into buildbot's plugin DB
+plugindb = db._DB._namespaces['www']
+plugindb._real_tree.add(ep_entry.name, db._PluginEntry('buildbot.www', ep_entry, plugindb._load_entry))
 
 
 # supports re-loading configuration with buildbot sighup, meaning we can change
-- 
2.50.1 (Apple Git-155)


