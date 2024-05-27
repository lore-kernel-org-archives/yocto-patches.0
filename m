Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5079C25B78
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 17:58:55 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.3429.1716832732302783614
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 10:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=qaotT01J;
 spf=pass (domain: baylibre.com, ip: 209.85.167.179, mailfrom: tgamblin@baylibre.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1b7ad2283so33874b6e.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716832731; x=1717437531; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jd9Gf/Mh/hWeMEEPAGA32FqWfxuw2IjitJqEOEiYMk=;
        b=qaotT01Jc7r9ffUB8TXplfxBS48ANwGFzTPkBPTVsla1iAhwrE7qQhty8RPQ9vy6Ec
         dSqjyLJcg2Qb16o65CLkDzbQ08cYEo9HSEweNhTBGw3J2qZ0iKqrebkxEF+X5YUgzkfU
         X6ik88DhMBvCpYf1t5764BxdwPHtPkjzcYH6lFIYAEuF6fPL4i/s25IMZ2wi0cV69yzE
         kwmddO0IT2nuaSYv19kzomgDzPoE+seaNc8IGUMGVRwwL9o+ePrVBvcjIv41Jiv2JTyK
         ieWtrie2qugeJonlppwsVDqGVTqUnCBGJyQzO7Ok+7PUBPgppuH//Q2QMjHPznMBlKkO
         4GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716832731; x=1717437531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jd9Gf/Mh/hWeMEEPAGA32FqWfxuw2IjitJqEOEiYMk=;
        b=pZwVk1xURFHbppvuS84TM1BPTse2AWq0ZxRkQ+CKyBob3oi/woydx3Q/4QHZ6P9tSg
         c8H7gc0W0GJ5JYCH58wztQTcqRPm4E1NSOUgGs1dGLfMkh511I5A4C7GFVvApU199XxE
         /SpmCbvKhF4ufQVzs/kE470MArPIZeNtP0LtoXsEsQguTARjb7YZ0/tCiO1j1hpW1qCE
         UNIqf9TOjlQSIjVE9xOEK/dxM3YKx9q7LczNXS1KbHEwsatTAxSK+nAXp0DSNB7D39Di
         SO759kXMdk4g+2+UTH+VDvKkWmiZ4rrB7qscY5ddvPmbDJ918ecpKpecKA/y3X8SmRGi
         iYXQ==
X-Gm-Message-State: AOJu0YxOyDVoEdKrepIpR1RqRjvxRGNZbVrEybxJ5xfUfyuqYlJKfS6g
	LxXGNkYBREjzQLOLykALYA1lY+71u8pbVdstOipMzJ+Fd6GUyVuMd7gRyZ1eLhcw+GWYlEQv+zq
	I
X-Google-Smtp-Source: AGHT+IEH87RaSa+pw+fOqPYSPUmBBxOgRMsYcUuUqOyv6k3pjW7dg0tlIDAbUfzHDSX9EYBYBZ62Ng==
X-Received: by 2002:a05:6808:90d:b0:3c9:64c6:99c3 with SMTP id 5614622812f47-3d1a764720amr9975910b6e.36.1716832731270;
        Mon, 27 May 2024 10:58:51 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac16321ed5sm36219316d6.128.2024.05.27.10.58.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:58:51 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [auto-upgrade-helper][PATCH] upgrade-helper: fix testimage check
Date: Mon, 27 May 2024 13:58:50 -0400
Message-ID: <20240527175850.1256122-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 17:58:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/212

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


