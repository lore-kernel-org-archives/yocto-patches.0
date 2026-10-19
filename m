Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5914.1792445732011318932
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 14:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RvU/1USi;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so16100a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445731; x=1793050531; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YA1gg6BoUoVKTH8l6gbRE0hIecZchtZ78EYq2sP4l78=;
        b=RvU/1USiHD2Suu58zyzmY8zli43RGUyf0yYdoCeINADdFJ6VDKCjt1CZg5LQTaKffn
         qFQGzJj/M0kOgOpvE6eyUvnLFG4Yqjc1LuOfcUEO6n3ogr/JKG8MBSt9vVpQZD7ljy/6
         69B8EDJ4nkOSSU7GhieJ3P/1MF18mJ93CYZQkqKALJR2lUKBqPQ+txzT79VwbmYZDkuS
         I/D6AOQSOm+XSFT+XTZsNAaXOxLrkcnI78kGDT8x/Cxk0gtiXDtXMfhnlPuDq4AMNRmz
         zdnl4uyeGLQIcT0g6S8ox+vDCPUTXuJNVvGi2s1rStWtVDQTe+YuPLMih/Ly9Tz3WWPy
         CwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445731; x=1793050531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YA1gg6BoUoVKTH8l6gbRE0hIecZchtZ78EYq2sP4l78=;
        b=FeSpoIE5zqUjSaPWmsEsZQ7xOeAHYfkAdNdyDQiFyKWX4lhYTETVDtX9sl9Rw+wa3a
         vbLS/BX54MSld1F7ZkW+rBob00bR0iNYQ5AI7XL/S+hlx5tVGSJRdCcj+8m66VycO+RN
         tKQORPm8P5jDlTYKaBqgZ4Y9xEj+uc7kiKML72Aef+2PRHRuBGRDqnlKnViEBmHYrcG9
         lAntM2VpFQXBwHsj7zMoKICq40PxR524zwhpxlj/LFOq2p0i7WmjvWYuD7GZ1UPiv32q
         y/IpfhRAoVwQ4/rvxXErwH+SxVmLzORgw41i9LxHH6IlY1oDqUftz7prdi6TkSSIRJ5D
         mNeA==
X-Gm-Message-State: AFq9FYIZ7QCJXmaEPoWa+d79ex+plaVTaXs+XcS07yCLa72YBkWsPzj4
	5sg3FIORG92M4YK34oqq1pZ/4auOLvitbK+2jQzrwgaTZ20cXFZVlSqb1rpweKUj
X-Gm-Gg: AYBFou0Ubnay4G1FYi3r/U3LEvZOAAPvW/RBBX48Gv+alGhtL2ED4agMJU7g6SNlq+R
	Mk+Dpzh3yVZ03Jvb0ghQLhCfkYGHAwSOw1N5JvWER4THYl/mSc24OW12imtuD7E3tuQ4uzkSC2G
	zB1gQTemuKT7BNrmbZRIAbaxa6CVaSd0bs+B/+2etJ9GefVdZepmRtnJIEYgzalnMMFIvm3yxRz
	LCaoxhKhS03vvfuUYZ+O2w/tzx2jsb0Vyi5FMrYjAtJXJdaWqVZ7+bhH4FZtn7RQaGQpxVEJgcO
	fpfS195HhIBB9uUvU6pZvYrHUtFV0HpEuQSA/XIPu0KcBL+K5e8qgmylgIer3zACVMxgbTkFbHK
	7csDM9VB9v6fhPibbkj6l/SMDBvzTHK2SXYz08Q/dxCGEk4nojxS2lo4OjnIRcNRC/Em+7aFWnC
	T6Nt3sH3zI6JL22LiqItLCwYikRs4K02tIRxUSEQSAUbl8ytlfIWBpv0r6poq12C7rQevSvHC/q
	payt4DChuCO3xmSylBxFgNfdNaau2I=
X-Received: by 2002:a05:6a20:918b:b0:3e2:6b5a:fea3 with SMTP id adf61e73a8af0-3e26b5b095fmr658991637.71.1792445731357;
        Mon, 19 Oct 2026 14:35:31 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm4307747b3a.53.2026.10.19.14.35.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 14:35:29 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] layerindex/models.py: store long recipe values without truncating
Date: Mon, 19 Oct 2026 14:35:10 -0700
Message-ID: <20261019213510.4384-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213510.4384-1-tim.orling@konsulko.com>
References: <20261019213510.4384-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 21:35:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5104
Content-Type: text/plain; charset="utf-8"

Several Recipe fields hold free-form values from the metadata with no
real length limit, and the update script kept truncating them (e.g.
linux-firmware's LICENSE at 4688 characters). Raising CharField limits
again only moves the problem and runs into MariaDB's per-row VARCHAR
limit, so make Recipe.summary, license, provides, bbclassextend,
inherits and configopts, and PackageConfig.with_option and
without_option, TextFields. Recipe.pn is indexed, so raise it to 255
characters instead.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../migrations/0055_recipe_text_fields.py     | 58 +++++++++++++++++++
 layerindex/models.py                          | 18 +++---
 tests/test_recipe_fields.py                   | 53 +++++++++++++++++
 3 files changed, 120 insertions(+), 9 deletions(-)
 create mode 100644 layerindex/migrations/0055_recipe_text_fields.py
 create mode 100644 tests/test_recipe_fields.py

diff --git a/layerindex/migrations/0055_recipe_text_fields.py b/layerindex/migrations/0055_recipe_text_fields.py
new file mode 100644
index 0000000..0714623
--- /dev/null
+++ b/layerindex/migrations/0055_recipe_text_fields.py
@@ -0,0 +1,58 @@
+# Generated by Django 5.2.18 on 2026-10-19 03:19
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0054_alter_sitenotice_expires'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='packageconfig',
+            name='with_option',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='packageconfig',
+            name='without_option',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='bbclassextend',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='configopts',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='inherits',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='license',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='pn',
+            field=models.CharField(blank=True, max_length=255),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='provides',
+            field=models.TextField(blank=True),
+        ),
+        migrations.AlterField(
+            model_name='recipe',
+            name='summary',
+            field=models.TextField(blank=True),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index a9e9bdf..425af53 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -469,22 +469,22 @@ class Recipe(models.Model):
     layerbranch = models.ForeignKey(LayerBranch, on_delete=models.CASCADE)
     filename = models.CharField(max_length=255)
     filepath = models.CharField(max_length=255, blank=True)
-    pn = models.CharField(max_length=100, blank=True)
+    pn = models.CharField(max_length=255, blank=True)
     pv = models.CharField(max_length=100, blank=True)
     pr = models.CharField(max_length=100, blank=True)
     pe = models.CharField(max_length=100, blank=True)
-    summary = models.CharField(max_length=200, blank=True)
+    summary = models.TextField(blank=True)
     description = models.TextField(blank=True)
     section = models.CharField(max_length=100, blank=True)
-    license = models.CharField(max_length=3072, blank=True)
+    license = models.TextField(blank=True)
     homepage = models.URLField(blank=True)
     bugtracker = models.URLField(blank=True)
-    provides = models.CharField(max_length=2048, blank=True)
-    bbclassextend = models.CharField(max_length=100, blank=True)
-    inherits = models.CharField(max_length=383, blank=True)
+    provides = models.TextField(blank=True)
+    bbclassextend = models.TextField(blank=True)
+    inherits = models.TextField(blank=True)
     updated = models.DateTimeField(auto_now=True)
     blacklisted = models.CharField(max_length=255, blank=True)
-    configopts = models.CharField(max_length=4096, blank=True)
+    configopts = models.TextField(blank=True)
     srcrev = models.CharField(max_length=64, blank=True)
 
     class Meta:
@@ -639,8 +639,8 @@ class Patch(models.Model):
 class PackageConfig(models.Model):
     recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
     feature = models.CharField(max_length=255)
-    with_option = models.CharField(max_length=255, blank=True)
-    without_option = models.CharField(max_length=255, blank=True)
+    with_option = models.TextField(blank=True)
+    without_option = models.TextField(blank=True)
     build_deps = models.CharField(max_length=255, blank=True)
 
     def __str__(self):
diff --git a/tests/test_recipe_fields.py b/tests/test_recipe_fields.py
new file mode 100644
index 0000000..8b8dc42
--- /dev/null
+++ b/tests/test_recipe_fields.py
@@ -0,0 +1,53 @@
+# layerindex-web - tests for storing long recipe values
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import Branch, LayerBranch, LayerItem, PackageConfig, Recipe
+
+
+@pytest.mark.django_db
+class TestLongRecipeValues(TestCase):
+    """Values longer than the old field limits, as seen in real layers
+    (e.g. linux-firmware's LICENSE, nativesdk recipes' inherits), must be
+    stored in full rather than truncated."""
+
+    def setUp(self):
+        branch = Branch.objects.create(name='master', bitbake_branch='master')
+        layer = LayerItem.objects.create(name='meta-test', status='P', layer_type='A',
+                                         summary='test', description='test',
+                                         vcs_url='git://example.com/meta-test.git')
+        self.layerbranch = LayerBranch.objects.create(layer=layer, branch=branch)
+
+    def test_long_values_are_not_truncated(self):
+        values = {
+            'pn': 'p' * 112,
+            'summary': 's' * 264,
+            'license': ' & '.join(['LicenseRef-Firmware-%d' % i for i in range(250)]),
+            'provides': 'virtual/x ' * 270,
+            # As generated by core-image-ptest.bb: one multiconfig variant per ptest
+            'bbclassextend': 'native nativesdk ' + ' '.join(['mcextend:python3-ptest-%d' % i for i in range(150)]),
+            'inherits': 'class ' * 110,
+            'configopts': '--enable-thing ' * 290,
+        }
+        with self.assertNoLogs('LayerIndexModels', 'WARNING'):
+            recipe = Recipe.objects.create(layerbranch=self.layerbranch, filename='test_1.0.bb', **values)
+            pc = PackageConfig.objects.create(recipe=recipe, feature='tests',
+                                              with_option='--with-x ' * 45, without_option='--without-x ' * 30)
+        recipe.refresh_from_db()
+        pc.refresh_from_db()
+        for field, value in values.items():
+            self.assertEqual(getattr(recipe, field), value, field)
+        self.assertEqual(pc.with_option, '--with-x ' * 45)
+        self.assertEqual(pc.without_option, '--without-x ' * 30)
+
+    def test_short_fields_are_still_truncated(self):
+        # Fields that keep a length limit are still truncated, with a warning
+        with self.assertLogs('LayerIndexModels', 'WARNING'):
+            recipe = Recipe.objects.create(layerbranch=self.layerbranch, filename='test_1.0.bb', pv='1' * 150)
+        recipe.refresh_from_db()
+        self.assertEqual(len(recipe.pv), 100)
-- 
2.56.0

