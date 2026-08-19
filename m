Return-Path: <halstead@happypunch.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D9C5DF81
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 18:13:34 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2666.1787163213479179629
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Aug 2026 11:13:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@happypunch.com header.s=google header.b=hH6quhdI;
 spf=pass (domain: happypunch.com, ip: 209.85.214.170, mailfrom: halstead@happypunch.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so10397925ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happypunch.com; s=google; t=1787163212; x=1787768012; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=643fCYaW0Xl81UWxLvRoTGX4LXJVd5LZ/hYXwMd6ZC0=;
        b=hH6quhdIBSqqmPygEwk1au2qFn787xV1idUAGJwVpOICFKC4CqZ1XHfdCWyzp1xoi9
         V0eiG3OLtgJyj1osMgYYkAqhivX/wBLcWOGg8MGqRVPUIN/M7U8U9oWwWIUfxVvKfpMM
         UuH6REH4Qp5om/FxI8CBWj01YtOBZfmmn98zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787163212; x=1787768012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=643fCYaW0Xl81UWxLvRoTGX4LXJVd5LZ/hYXwMd6ZC0=;
        b=q5CGp8ykU92YAQhg6of18G3XGRSkfTx9CL358KwGl78p9HTHcNsuj4QsvVsMHzvlFj
         I488qarwOutmt0UWDrsOX/tHcUj/HtUYTrRb3jaY/HE/gneGsEOWsMcfxByYkIgTd+hu
         VzAHqcDhpWguFvZUY13SXqpjkRx9+RfmMyaTIGzuZz3O0s51rTMGIKsvyahY/OeNDP+E
         uH1+HTIo5qz7j0eUAOiQAr7G5cAdOvccDenD5jJAn+UmrkANGlWV12tacc8448iL9yc6
         EhVQ2q/BiTvBU/KHxKOuEzGeRd8fkGjaKQ7EBx/H2Ko8kCBrpGrYQNVACc0UnAVPVZwj
         nxiQ==
X-Gm-Message-State: AFuF++njBF/eDiRwXEHqaC61mfHVGRqKFC5jj0lXIuOeeJ9KSNmdllA+
	eDfD9107X+ik1xCA1nm0ZdIaSMs/dlzP4/1pUjYaFSBJoWShDqIME9JLDyj9j0qQRXfrXWH+T88
	Ebqo=
X-Gm-Gg: AR+sD12b58gPK++iSKzQxShNg5CVuka2+eaZaEo7tjRnOfKgfZvyrFvhmdiYXUtIBzu
	d3qT5U3bMzxHI7PzgFfZ+cK7hMxHfGk4pQs01QbWhBBiTZ9Ibw+lued6ge0PSKE9ixwbCOyPdX/
	r6/X9sD8BEQ7zTCoV9T2gS5FmCeknxIBxhzp1Gjyya59hUJ8vhT08gEps5axBcjZVdUxeE6vLTB
	nUWoMrK+a5BE1BpBqqBN7JPmPtUAp5MmAHWu7+jaofyPKtwi/dOt1aWAMO2GgeGogrgABjXzqHB
	De+ZhrWJCOKvCQI8NaDAjrhGrkrtePyDda9zvqx6Up2gC0OrMVIOXf+iSiXRS1/AFZOKVF1Ojmb
	bOK2MMoZJi8w++hSNDIcmILxXc8YHKvVZYGauOoe/15KApd1jrmG6CuS4oq5uAl6+M5JZbSTh1K
	GxROnIdZtzUzMYTt3VvaG11IY4xe3Kfxe3g54rnRh6xF50UWmgR0qCLmqbdrsiFHNbdArcfxTcd
	sF4pWFVryX41GfUoZ+f/IkycXHr1mt/xtwbi4QTQOqI7RAAL0KengphNX4dHGl+bAiZpSk=
X-Received: by 2002:a17:90b:3b83:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39580a4d117mr10842082a91.1.1787163212370;
        Wed, 19 Aug 2026 11:13:32 -0700 (PDT)
Received: from yct-bluefin.taild15c8.ts.net ([2602:61:7822:c00::6c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fc82965sm1298722a91.4.2026.08.19.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:13:31 -0700 (PDT)
From: Michael Halstead <halstead@happypunch.com>
X-Google-Original-From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [layerindex-web][PATCH] Add indexes to speed up recipe, patch and bbappend lookups
Date: Wed, 19 Aug 2026 11:12:46 -0700
Message-ID: <20260819181301.67908-2-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 18:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4677

Slow query digest (events_statements_summary_by_digest) showed the
hottest queries on the site filtering by Recipe.pn and joining
BBAppend/Patch/RecipeUpgrade with no supporting index. Add composite
indexes for the actual filter/join patterns instead of the FK columns,
which Django already indexes by default. Also index SiteNotice.expires,
which is checked on every page load via the notices context processor.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
Co-authored-by: Claude Opus 5 <noreply@anthropic.com>
---
 .../migrations/0053_add_query_indexes.py      | 35 +++++++++++++++++++
 .../0054_alter_sitenotice_expires.py          | 23 ++++++++++++
 layerindex/models.py                          | 14 +++++++-
 rrs/migrations/0031_add_query_indexes.py      | 24 +++++++++++++
 rrs/models.py                                 | 10 ++++++
 5 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 layerindex/migrations/0053_add_query_indexes.py
 create mode 100644 layerindex/migrations/0054_alter_sitenotice_expires.py
 create mode 100644 rrs/migrations/0031_add_query_indexes.py

diff --git a/layerindex/migrations/0053_add_query_indexes.py b/layerindex/migrations/0053_add_query_indexes.py
new file mode 100644
index 0000000..0aa6ee1
--- /dev/null
+++ b/layerindex/migrations/0053_add_query_indexes.py
@@ -0,0 +1,35 @@
+# Generated by Django 6.1 on 2026-08-11 19:35
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ("layerindex", "0052_source_path"),
+    ]
+
+    operations = [
+        migrations.AddIndex(
+            model_name="bbappend",
+            index=models.Index(
+                fields=["layerbranch", "filename"], name="bbappend_lb_filename"
+            ),
+        ),
+        migrations.AddIndex(
+            model_name="patch",
+            index=models.Index(fields=["recipe", "status"], name="patch_recipe_status"),
+        ),
+        migrations.AddIndex(
+            model_name="recipe",
+            index=models.Index(
+                fields=["layerbranch", "pn"], name="recipe_layerbranch_pn"
+            ),
+        ),
+        migrations.AddIndex(
+            model_name="recipe",
+            index=models.Index(
+                fields=["pn", "layerbranch"], name="recipe_pn_layerbranch"
+            ),
+        ),
+    ]
diff --git a/layerindex/migrations/0054_alter_sitenotice_expires.py b/layerindex/migrations/0054_alter_sitenotice_expires.py
new file mode 100644
index 0000000..ea826a0
--- /dev/null
+++ b/layerindex/migrations/0054_alter_sitenotice_expires.py
@@ -0,0 +1,23 @@
+# Generated by Django 6.1 on 2026-08-11 21:07
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ("layerindex", "0053_add_query_indexes"),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name="sitenotice",
+            name="expires",
+            field=models.DateTimeField(
+                blank=True,
+                db_index=True,
+                help_text="Optional date/time when this notice will stop showing",
+                null=True,
+            ),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index eb7d8bf..1a2ec60 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -478,6 +478,12 @@ class Recipe(models.Model):
     configopts = models.CharField(max_length=4096, blank=True)
     srcrev = models.CharField(max_length=64, blank=True)
 
+    class Meta:
+        indexes = [
+            models.Index(fields=['layerbranch', 'pn'], name='recipe_layerbranch_pn'),
+            models.Index(fields=['pn', 'layerbranch'], name='recipe_pn_layerbranch'),
+        ]
+
     def vcs_web_url(self):
         url = self.layerbranch.file_url(os.path.join(self.filepath, self.filename))
         return url or ''
@@ -582,6 +588,9 @@ class Patch(models.Model):
     class Meta:
         verbose_name_plural = 'Patches'
         ordering = ['recipe', 'apply_order']
+        indexes = [
+            models.Index(fields=['recipe', 'status'], name='patch_recipe_status'),
+        ]
 
     def vcs_web_url(self):
         url = self.recipe.layerbranch.file_url(self.path)
@@ -769,6 +778,9 @@ class BBAppend(models.Model):
 
     class Meta:
         verbose_name = "Append"
+        indexes = [
+            models.Index(fields=['layerbranch', 'filename'], name='bbappend_lb_filename'),
+        ]
 
     def vcs_web_url(self):
         url = self.layerbranch.file_url(os.path.join(self.filepath, self.filename))
@@ -910,7 +922,7 @@ class SiteNotice(models.Model):
     text = models.TextField(help_text='Text to show in the notice. A limited subset of HTML is supported for formatting.')
     level = models.CharField(max_length=1, choices=NOTICE_LEVEL_CHOICES, default='I', help_text='Level of notice to display')
     disabled = models.BooleanField('Disabled', default=False, help_text='Use to temporarily disable this notice')
-    expires = models.DateTimeField(blank=True, null=True, help_text='Optional date/time when this notice will stop showing')
+    expires = models.DateTimeField(blank=True, null=True, db_index=True, help_text='Optional date/time when this notice will stop showing')
 
     def __str__(self):
         prefix = ''
diff --git a/rrs/migrations/0031_add_query_indexes.py b/rrs/migrations/0031_add_query_indexes.py
new file mode 100644
index 0000000..91a6d5c
--- /dev/null
+++ b/rrs/migrations/0031_add_query_indexes.py
@@ -0,0 +1,24 @@
+# Generated by Django 6.1 on 2026-08-11 19:35
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ("layerindex", "0053_add_query_indexes"),
+        ("rrs", "0030_alter_recipeupgrade_maintainer"),
+    ]
+
+    operations = [
+        migrations.AddIndex(
+            model_name="recipesymbol",
+            index=models.Index(fields=["layerbranch", "pn"], name="recipesymbol_lb_pn"),
+        ),
+        migrations.AddIndex(
+            model_name="recipeupgrade",
+            index=models.Index(
+                fields=["recipesymbol", "commit_date"], name="recipeupgrade_rs_date"
+            ),
+        ),
+    ]
diff --git a/rrs/models.py b/rrs/models.py
index df30995..e1de689 100644
--- a/rrs/models.py
+++ b/rrs/models.py
@@ -214,6 +214,11 @@ class RecipeSymbol(models.Model):
             rsym.save()
         return rsym
 
+    class Meta:
+        indexes = [
+            models.Index(fields=['layerbranch', 'pn'], name='recipesymbol_lb_pn'),
+        ]
+
     def __str__(self):
         return "%s: %s" % (str(self.layerbranch), self.pn)
 
@@ -509,6 +514,11 @@ class RecipeUpgrade(models.Model):
     group = models.ForeignKey(RecipeUpgradeGroup, blank=True, null=True, on_delete=models.SET_NULL)
     prev_version = models.CharField(max_length=100, blank=True)
 
+    class Meta:
+        indexes = [
+            models.Index(fields=['recipesymbol', 'commit_date'], name='recipeupgrade_rs_date'),
+        ]
+
     @staticmethod
     def get_by_recipe_and_date(recipe, end_date):
         ru = RecipeUpgrade.objects.filter(recipesymbol__pn=recipe.pn,
-- 
2.55.0


