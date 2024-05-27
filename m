Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA7EC25B78
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 20:18:47 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.6557.1716841121292181641
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 13:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=p4OtwXo2;
 spf=pass (domain: baylibre.com, ip: 209.85.160.179, mailfrom: tgamblin@baylibre.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43fb05b1ef2so678291cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716841120; x=1717445920; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jd9Gf/Mh/hWeMEEPAGA32FqWfxuw2IjitJqEOEiYMk=;
        b=p4OtwXo2PWzH4TklDTv11kU9U2+W8+dpXSZ9Hq8rFfGY7bP3UjX67qXOIJkHpySrDH
         On8/HbpJc+EoyjmQ/eKdfyVsU+2k1nNQV2MogsG7c3mDu7ZpiLpc32EoOKnaJuUS2vf2
         kJ5CHnz174LHW+DNHSh+lEmqw42usSMD/r6j2L/SPZIytkUfd0k7eFEfat2Q9Dz3LJr4
         1HiMye/VCzwhuaBUZIWesGWjMBg56m07YMO2UYqQbLDT1m+DTBxzK5DQueCzdAf3QKek
         YjbXfjseDRJd/iM/+HJpnHGdHvLxU+r78BIp1KIOa0cR00ijNN4lPhbso5z+dZM2Ja07
         07PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841120; x=1717445920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jd9Gf/Mh/hWeMEEPAGA32FqWfxuw2IjitJqEOEiYMk=;
        b=Vumg4XQX+UFJd8csPFEV42sLi0/rukYnOFMGo80gTDT/HS1uaRw1ByOjKe8t5Sihk3
         aU2F5/zH9JbN+cbWIlpiBDxOAkUg6Nwp85UOv/U/VZB/28SpfHSVunskKrB/YfZhdcov
         rqd9Y3r9DtxzfGWkJQNBZR/NLQK4XTiACb9un38yjJdJub1GbZlnuxJSqeh4yrZNVnGn
         Rjjl+TbfBcEUvSY3I4LAD6qaueMenfHYPGZoOJODwoTTobkvdFFXpe5JWkMNIuLdAyJK
         tD0LtN64LUS+3HIZy5sAaTLgedDmWO+Yon4MQXmcNHKcEuzVWVICvZ+0Zg/2YE10O/uu
         sZzg==
X-Gm-Message-State: AOJu0Yxlz9drfQI319iJHRCZD85oVSYghT/H4bt2N/338DUYPDrG2tBF
	3ez8XM/VP/Cr7rh/hnbQTlwIEEwzoegEatE/5WbkqLPliGs3x4zatTDYXNmlIn1n6LyPYvZTWBw
	K
X-Google-Smtp-Source: AGHT+IG7CkqojY+6aEPTTvNUqIo3V6Qgn2XnF1ZJi5j0BQqsd5W0VcJ+OcjjespHpiuMn4hiAuNNlg==
X-Received: by 2002:a05:622a:284:b0:43a:b9c9:a25a with SMTP id d75a77b69052e-43fb0f19ee4mr126408701cf.56.1716841119461;
        Mon, 27 May 2024 13:18:39 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16bffecsm37119041cf.1.2024.05.27.13.18.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:18:39 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [auto-upgrade-helper][PATCH] upgrade-helper: fix testimage check
Date: Mon, 27 May 2024 16:18:38 -0400
Message-ID: <20240527201838.1258614-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 20:18:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/216

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


