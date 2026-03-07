Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB4F55115
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 22:49:56 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18985.1772923789098715546
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 14:49:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ycf2q0rc;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae41544dcfso82421805ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 14:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772923788; x=1773528588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHbJQ2jNpymj1qdF9UaKj0UI9Uu9bkQuerjXBx6a1W8=;
        b=Ycf2q0rcqjUvn2uGjIc/KRGiUyf2z6DGwWq92WlUE2lhDDn2gJIFnjRg/7umFkdpBJ
         pAu/S+b/oJR9uLQdb+dTnWoeVQmn1ZjBKZlaYAF1g2+N9JiKJaI3BmzHcP87bC2v+BGf
         OJzPDGbktQx7mwdbOo/Tt2EezMxiuIxxfQ+U9Ehz8jyhG5mbDymg1sOftvGbAeAwpwEp
         xHY+S5ILdSBcvP++dDB9lvJie0entBtK0XZYTNwXxwa5IyYj/l2GONJ/HacxT1a9tPkt
         bdZq6/vyuAfemrpo1PzxVfcTJ7Eq8Thu+Q1FUEkBdPgtTDQirigVa0oGELM7cBLTIA/e
         X3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772923788; x=1773528588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHbJQ2jNpymj1qdF9UaKj0UI9Uu9bkQuerjXBx6a1W8=;
        b=ZL0tvoR5AoKxPXqgWlqZ/wIg4I5JyHf0VS9/hblsluOvpqTyqUkLlEgevMTBi0WvR3
         bhMN9YGoaDxPDDeipVfgY1mX7uL7lx3PaYEU9UagPpnzICWO5pW0EAIcUV1KrPSVgwVG
         BqwPq7YC3wWWQT3N7J98izsSrsXolxsWKUv+rQRdohxGptaWW0u4yGLfEjFCC9Lw6SB7
         Fc0ezZOAf2mAmmRev+2XXFexk9DVWd/yqxlJdCm4CUbVYOunpSPnBKQOofXwsjlXQZol
         C7eZSH/IIpULE/8HN5Teirhd4Ppdq49WZEiDt80rpR9JEtu08odQMJrY9xt96ZqcX24y
         arCw==
X-Gm-Message-State: AOJu0YzdUl2jHJaFQhk07PlfxsGbBqXXKSLLmSMzjIS0SBNZ0ST+oGIh
	7rmRc6QXt8fewWAS7y0RJYq4wGeljgO15BD2IXXkQEUQ65cdbArQbt4451Bp6A==
X-Gm-Gg: ATEYQzxT0zp2VBEez5rV3vk6tlZiZCj6U6Q7E0Gd1v6RPTU4rl4SXf2nX/eyNSVobYz
	Wd/0NU+9B5x7i9rJAzmLZI1lFl7AGBqcZdqfLmcs/81BiSP7y1B2xnWnzRIf31uutrdYLMHOzya
	AdOBji0Sk4mNbGykg3Z5SztlcQurUVoaojQPBVOT9kTBI1khbrG06d2cCicumEryqF62/5Lkvqj
	PblDYqBN4UOD3UvQZRGlZxXpq5xgPy6J03vS9uVJRWn4lcFNanQdgXaZjG7Ycr6wsf5H/PoV/5o
	AWIT2HWXypifdJP3vP4maBmGflUR0KqM8+m0vOdk75tlrr1WgnycLkUQ41jiYNn0TT3qbj/8z2M
	YxU8pnJBc+sSMr1wZJ9dlhCjmtaFB7XRfILwv0d/JbiC18csXKcC6S9B1Um8Ic4j7nOyf0oTKXU
	CCJSycWUNxvR6PqIjES4NICwwy8Ijt7gu5WTSIGFeGpLJ6TuNvyefxe4IaZk5SVFBROaarwhpJ8
	9gke+xrdPnzm2OVJd4KUA==
X-Received: by 2002:a17:903:17c6:b0:2aa:d11d:5c36 with SMTP id d9443c01a7336-2ae8242e038mr62207205ad.30.1772923787861;
        Sat, 07 Mar 2026 14:49:47 -0800 (PST)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f759fdsm81608215ad.57.2026.03.07.14.49.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Mar 2026 14:49:47 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex/models.py: increase size of fields; add migration
Date: Sat,  7 Mar 2026 14:49:01 -0800
Message-ID: <20260307224900.55581-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 22:49:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3377

Fixes:
WARNING: Recipe.license: recipes-kernel/linux-firmware/linux-firmware_20260221.bb: length 3042 exceeds maximum (2048), truncating

Fixes (many similar):
WARNING: Recipe.inherits: recipes-graphics/images/core-image-x11.bb: length 298 exceeds maximum (255), truncating

Also add necessary migration.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 ...er_recipe_inherits_alter_recipe_license.py | 23 +++++++++++++++++++
 layerindex/models.py                          |  4 ++--
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 layerindex/migrations/0050_alter_recipe_inherits_alter_recipe_license.py

diff --git a/layerindex/migrations/0050_alter_recipe_inherits_alter_recipe_license.py b/layerindex/migrations/0050_alter_recipe_inherits_alter_recipe_license.py
new file mode 100644
index 0000000..247d134
--- /dev/null
+++ b/layerindex/migrations/0050_alter_recipe_inherits_alter_recipe_license.py
@@ -0,0 +1,23 @@
+# Generated by Django 4.2.28 on 2026-03-07 22:43
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0049_alter_layerbranch_vcs_subdir'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='recipe',
+            name='inherits',
+            field=models.CharField(blank=True, max_length=383),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='license',
+            field=models.CharField(blank=True, max_length=3072),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index 50be60f..e43d1df 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -467,12 +467,12 @@ class Recipe(models.Model):
     summary = models.CharField(max_length=200, blank=True)
     description = models.TextField(blank=True)
     section = models.CharField(max_length=100, blank=True)
-    license = models.CharField(max_length=2048, blank=True)
+    license = models.CharField(max_length=3072, blank=True)
     homepage = models.URLField(blank=True)
     bugtracker = models.URLField(blank=True)
     provides = models.CharField(max_length=2048, blank=True)
     bbclassextend = models.CharField(max_length=100, blank=True)
-    inherits = models.CharField(max_length=255, blank=True)
+    inherits = models.CharField(max_length=383, blank=True)
     updated = models.DateTimeField(auto_now=True)
     blacklisted = models.CharField(max_length=255, blank=True)
     configopts = models.CharField(max_length=4096, blank=True)
-- 
2.50.1 (Apple Git-155)


