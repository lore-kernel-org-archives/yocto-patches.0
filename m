Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775EFC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 20:32:37 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.6677.1716841952694349036
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 13:32:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Jbyke8QQ;
 spf=pass (domain: baylibre.com, ip: 209.85.210.51, mailfrom: tgamblin@baylibre.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8d0a1e500so124684a34.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716841952; x=1717446752; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrpHtBsppa1LIcB6gDHXtuwjHlGZRKRmnXHD2HzCVZA=;
        b=Jbyke8QQ3ydqpYXxylwx4TvdbdJPl/ww4kGYP7VPtV5+jbJ9O5VYBsbYj7nNMoNfrD
         9+yaG3zuHEgrC8Sk0tAFwAoKD4L2EgXSO7J3TbiDHE6qz6KHrZgEn+5WNol2JqehFBK0
         z4J83VXL7H6B+eny1UqUeasb8S9YatWp/UVagTonwqulahJu34H5lBt7THr59LIBCb5U
         nzTwf4vOpTOWq1K7himqXjjDdTbExhslOOxEJWPKazyKt69RuI02eOykGhxLIb3Se9vS
         GUTOZihrHOrTLXMmodMswxAgNr6KBA66wfcQe1egcBfEQI5XWAXQDVfuuK4nZMsXrLzg
         0SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841952; x=1717446752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrpHtBsppa1LIcB6gDHXtuwjHlGZRKRmnXHD2HzCVZA=;
        b=iGAz8VZxkVna5pSq7+gNnXYrpuTMlNvNrX/uLiwn37BUpEfYzswp5kEs0rVePK0O2x
         1OpCvNPKC0Q5uvRNJk/IRshZPMauEE+YbBXwf3MkdObb+6Y48RsUamSBFvRALJCGWBpm
         XP9hHauZxrK+s5Gpf2dWHf0yiSc/rIwpf1QoKH6C/roq8cbOblG0XrCkT/BTxpJn05F9
         Qi0zWieKr7uetnhOgXZJo021JfcBG1sZITdcaQk6J0caMdmzt3SeyB+OPTHkK8qxGY8o
         WqU4QYxTiIsGlAwbK4UuLkPpd5Bn6hxJzAkbbxsUKJp3kouNPYK+HHvhS98mltnH43mT
         HpXA==
X-Gm-Message-State: AOJu0Yzhss/v0wMLcDF++PHiL9wG7XZyLUW0nkoudwwGMgYUMe/5A3H/
	hdkQ+62qJQxSPUgp6QAD75y/arzJ3JgXQlutMaPbMKFT1tCa1mCoSU5jAr4QyVOnXbGLMe+SZBq
	v
X-Google-Smtp-Source: AGHT+IGmnBRZchjQxWaFR7+QgYe/BUn8UqnPIOA/wCte+wuOUMRnLhT+vtr6CtGmBahGL3KSFoia0A==
X-Received: by 2002:a05:6359:1793:b0:197:974d:33e with SMTP id e5c5f4694b2df-197e566b777mr1459650555d.28.1716841951492;
        Mon, 27 May 2024 13:32:31 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd0638csm321368285a.80.2024.05.27.13.32.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:32:31 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [auto-upgrade-helper][PATCH] upgrade-helper: fix testimage check
Date: Mon, 27 May 2024 16:32:30 -0400
Message-ID: <20240527203230.1258788-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 20:32:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/218

From: Trevor Gamblin <tgamblin@baylibre.com>

AUH's testimage logic is still checking for BB_ENV_EXTRAWHITE instead of
BB_ENV_PASSTHROUGH_ADDITIONS, and INHERIT += "testimage" instead of
IMAGE_CLASSES += "testimage". Update it so that checks for the correct
variable names.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 modules/testimage.py | 2 +-
 upgrade-helper.py    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/modules/testimage.py b/modules/testimage.py
index 0fc1adb..fb2e467 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -53,7 +53,7 @@ class TestImage():
         self.logdir = os.path.join(uh_work_dir, "testimage-logs")
         os.mkdir(self.logdir)
 
-        os.environ['BB_ENV_EXTRAWHITE'] = os.environ['BB_ENV_EXTRAWHITE'] + \
+        os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] = os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] + \
             " CORE_IMAGE_EXTRA_INSTALL TEST_LOG_DIR TESTIMAGE_UPDATE_VARS"
 
     def _get_pkgs_to_install(self, pkgs):
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 869dc3f..e307d60 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -262,7 +262,7 @@ class Updater(object):
         enabled = False
 
         if settings.get("testimage", "no") == "yes":
-            if 'testimage' in self.base_env['INHERIT']:
+            if 'testimage' in self.base_env['IMAGE_CLASSES']:
                 if not "ptest" in self.base_env["DISTRO_FEATURES"]:
                     E(" testimage requires ptest in DISTRO_FEATURES please add to"\
                       " conf/local.conf.")
@@ -271,8 +271,8 @@ class Updater(object):
                 enabled = True
             else:
                 E(" testimage was enabled in upgrade-helper.conf"\
-                  " but isn't INHERIT in conf/local.conf, if you want"\
-                  " to enable please set.")
+                  " but isn't added to IMAGE_CLASSES in conf/local.conf, \
+                    if you want to enable please set.")
                 exit(1)
 
         return enabled
-- 
2.45.1


