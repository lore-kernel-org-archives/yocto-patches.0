Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ECE9904C
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 07:25:25 +0000 (UTC)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.150848.1775805916479214087
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Apr 2026 00:25:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=AAhTqEPv;
 spf=pass (domain: qbee.io, ip: 209.85.208.193, mailfrom: piotr@qbee.io)
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-38ddc25ce01so14945801fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Apr 2026 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1775805914; x=1776410714; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9IY+gdPOGWasbPwt8Zq2JVNAMswxEqq7f5wCfRL5OM=;
        b=AAhTqEPvxVAMkDux/wdYlKiJ10By/ptU5Oi5FKSiB4WtYQ8eMq6mAFDmJlvDLSziC/
         FNYdvJRKWAc0Emzh4XkM6+jt0Sbr4cLsvkayTSqwYanrxc9iBFO6EwrL2M4NxfGOCn3l
         gyxzRCNYBrgHZ0jCYMZ6KL/GYdIxtyQYxc4Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775805914; x=1776410714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9IY+gdPOGWasbPwt8Zq2JVNAMswxEqq7f5wCfRL5OM=;
        b=bmXrXWGFZf4W6djKY3Plc2hkVVAQxBPHpdjjqiUzJhNVPF9YOFbWymzG9rRCiJ0B91
         74l1Dt2wl0RZK0CvWerG0pSxMHC2CMsP4f7wOMH6cnwULNobyVXYqvgRUpqrB1DL+cSa
         5sxSj2dUNhPy6u5kHlJRASvgHkUIZSKu7y+v65ArLZ8exzv16A24lkZ5kJZ9F81WJ+E6
         orARRtPf2zmfWZ3AaxpBov2R/IaW4eWBdaEj0QkCkPA3SiM3Vp1pvghKUrFY3+TC1YUG
         eVvfErWB1z3mul79e+jUIN3UCIEURqQCgHHsDja8XCKVkkcmBVIi4+N0/C4nKKc0PZud
         5YHA==
X-Gm-Message-State: AOJu0YwJ/YcJEvpRU+Yt/jFjpRuiBWRwK0BdQsnVV/QfSbzKlMzk0Zbz
	tXmun9cewR041efTHPDUp5ehp/+tuQut1JrVbhjd9/kbB+sx6NzQzaDm+pOZEwmH0gg6sTQ+JWZ
	d6Z768VQSzg==
X-Gm-Gg: AeBDievT0LN0ukh6QuNh8m/WvvuGLg/S/aYjdTcd2KuT1zoW4C4L30VFyo2dYX3fnvU
	y93gmbCEmSGEjbBQYHaKMmgx32jn6lfFjUOzNdLqUEjSGY97SdtPHogmSXQZqOQ3nNC/w4lTuFf
	1EzPVR4lcbgDmMOp473cQBkh8skKkwjX9mfutO4YsYBxzq7vysK969ROGc0nBRPQAT/xlH5eOtI
	lxlHLIRVvS8cYNmJpMSEQm2MFKy6H9hoVplVDNdPajvqabfsQP4s7zbC1fxbZCsOfPOmyNfexi7
	BrnAd3oTxnf5gx52U0JIcQRrTZWJkWEDCDWt4Xvq7ZJN51QV9eB/fZyRnk6gTpaTMyzvDr1Y81G
	ViHM+gDcwB9BB7mUGuaCEbgXhY8ZW2oOmEH07My38bgXP9pef4pZyKK3T5tM6tWQhAbeXHkj0Rf
	PRwD6ie4Zj56d7Fkjnjx5yNanmNarept2+U+K0rT9aibAVtQuYgVFP
X-Received: by 2002:a05:651c:1604:b0:383:20cd:52fe with SMTP id 38308e7fff4ca-38e4bef91bdmr6324911fa.17.1775805914038;
        Fri, 10 Apr 2026 00:25:14 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-38e495461b7sm4745941fa.26.2026.04.10.00.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 00:25:13 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] Update git.yoctoproject.org URLs from old cgit paths to new direct paths
Date: Fri, 10 Apr 2026 09:24:59 +0200
Message-ID: <20260410072459.52859-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Apr 2026 07:25:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3685

The old /cgit/cgit.cgi/ URL scheme is no longer used by
git.yoctoproject.org. Update all references to use the new shorter
URLs and switch from http to https. Add a data migration to fix
existing LayerItem records in the database.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 README                                        |  2 +-
 .../0051_fix_yoctoproject_cgit_urls.py        | 29 +++++++++++++++++++
 layerindex/models.py                          |  2 +-
 layerindex/tools/import_layer.py              |  8 ++---
 layerindex/tools/import_wiki_layers.py        |  8 ++---
 templates/layerindex/about.html               |  2 +-
 templates/layerindex/editlayer.html           |  8 ++---
 7 files changed, 44 insertions(+), 15 deletions(-)
 create mode 100644 layerindex/migrations/0051_fix_yoctoproject_cgit_urls.py

diff --git a/README b/README
index 1335b7a..9e1e659 100644
--- a/README
+++ b/README
@@ -428,7 +428,7 @@ The code for this application is maintained by the Yocto Project.
 
 The latest version of the code can always be found here:
 
-  http://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
+  https://git.yoctoproject.org/layerindex-web/
 
 Contributions are welcome. Please send patches / pull requests to
 yocto-patches@lists.yoctoproject.org with '[layerindex-web]' in the
diff --git a/layerindex/migrations/0051_fix_yoctoproject_cgit_urls.py b/layerindex/migrations/0051_fix_yoctoproject_cgit_urls.py
new file mode 100644
index 0000000..2303a7f
--- /dev/null
+++ b/layerindex/migrations/0051_fix_yoctoproject_cgit_urls.py
@@ -0,0 +1,29 @@
+# Generated by Django 5.2.12 on 2026-04-09 18:51
+
+from django.db import migrations
+
+
+def fix_yoctoproject_cgit_urls(apps, schema_editor):
+    """Update git.yoctoproject.org URLs from old cgit paths to new direct paths."""
+    LayerItem = apps.get_model('layerindex', 'LayerItem')
+
+    old = 'http://git.yoctoproject.org/cgit/cgit.cgi/'
+    new = 'https://git.yoctoproject.org/'
+
+    for layer in LayerItem.objects.filter(vcs_web_url__contains='git.yoctoproject.org/cgit/cgit.cgi/'):
+        layer.vcs_web_url = layer.vcs_web_url.replace(old, new)
+        layer.vcs_web_tree_base_url = layer.vcs_web_tree_base_url.replace(old, new)
+        layer.vcs_web_file_base_url = layer.vcs_web_file_base_url.replace(old, new)
+        layer.vcs_web_commit_url = layer.vcs_web_commit_url.replace(old, new)
+        layer.save()
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0050_alter_recipe_inherits_alter_recipe_license'),
+    ]
+
+    operations = [
+        migrations.RunPython(fix_yoctoproject_cgit_urls, migrations.RunPython.noop),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index e43d1df..6e96342 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -542,7 +542,7 @@ class Source(models.Model):
         elif self.url.startswith('git://github.com'):
             return drop_dotgit('https' + self.url[3:])
         elif self.url.startswith('git://git.yoctoproject.org'):
-            return drop_dotgit('https://git.yoctoproject.org/cgit/cgit.cgi' + self.url[26:])
+            return drop_dotgit('https://git.yoctoproject.org' + self.url[26:])
         elif self.url.startswith('git://git.kernel.org'):
             return 'https' + self.url[3:]
         return None
diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_layer.py
index dfe887c..4af062e 100755
--- a/layerindex/tools/import_layer.py
+++ b/layerindex/tools/import_layer.py
@@ -40,10 +40,10 @@ def set_vcs_fields(layer, repoval):
         layer.vcs_web_commit_url = 'http://cgit.openembedded.org/' + reponame + '/commit/?id=%hash%'
     elif repoval.startswith('git://git.yoctoproject.org/'):
         reponame = re.sub('^.*/', '', repoval)
-        layer.vcs_web_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame
-        layer.vcs_web_tree_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-        layer.vcs_web_file_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-        layer.vcs_web_commit_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/commit/?id=%hash%'
+        layer.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
+        layer.vcs_web_tree_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+        layer.vcs_web_file_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+        layer.vcs_web_commit_url = 'https://git.yoctoproject.org/' + reponame + '/commit/?id=%hash%'
     elif repoval.startswith('git://github.com/') or repoval.startswith('http://github.com/') or repoval.startswith('https://github.com/'):
         reponame = re.sub('^.*github.com/', '', repoval)
         reponame = re.sub('.git$', '', reponame)
diff --git a/layerindex/tools/import_wiki_layers.py b/layerindex/tools/import_wiki_layers.py
index 2c82411..a9508de 100755
--- a/layerindex/tools/import_wiki_layers.py
+++ b/layerindex/tools/import_wiki_layers.py
@@ -104,10 +104,10 @@ def main():
                             layer.vcs_web_commit_url = 'http://cgit.openembedded.org/' + reponame + '/commit/?id=%hash%'
                         elif repoval.startswith('git://git.yoctoproject.org/'):
                             reponame = re.sub('^.*/', '', repoval)
-                            layer.vcs_web_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame
-                            layer.vcs_web_tree_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-                            layer.vcs_web_file_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-                            layer.vcs_web_commit_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/commit/?id=%hash%'
+                            layer.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
+                            layer.vcs_web_tree_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+                            layer.vcs_web_file_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+                            layer.vcs_web_commit_url = 'https://git.yoctoproject.org/' + reponame + '/commit/?id=%hash%'
                         elif repoval.startswith('git://github.com/') or repoval.startswith('http://github.com/') or repoval.startswith('https://github.com/'):
                             reponame = re.sub('^.*github.com/', '', repoval)
                             reponame = re.sub('.git$', '', reponame)
diff --git a/templates/layerindex/about.html b/templates/layerindex/about.html
index f79bf22..a2055fb 100644
--- a/templates/layerindex/about.html
+++ b/templates/layerindex/about.html
@@ -55,7 +55,7 @@
 <li>Tim Orling</li>
 </ul>
 
-<p>The code is Open Source and can be found on <a href="http://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/">git.yoctoproject.org</a>. Patches welcome!</p>
+<p>The code is Open Source and can be found on <a href="https://git.yoctoproject.org/layerindex-web/">git.yoctoproject.org</a>. Patches welcome!</p>
 
 {% endautoescape %}
 {% endblock %}
diff --git a/templates/layerindex/editlayer.html b/templates/layerindex/editlayer.html
index e21e649..f6d4967 100644
--- a/templates/layerindex/editlayer.html
+++ b/templates/layerindex/editlayer.html
@@ -206,10 +206,10 @@
         }
         else if( repoval.startsWith('git://git.yoctoproject.org/') ) {
             reponame = repoval.replace(/^.*\//, '')
-            this.vcs_web_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame
-            this.vcs_web_tree_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-            this.vcs_web_file_base_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/tree/%path%?h=%branch%'
-            this.vcs_web_commit_url = 'http://git.yoctoproject.org/cgit/cgit.cgi/' + reponame + '/commit/?id=%hash%'
+            this.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
+            this.vcs_web_tree_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+            this.vcs_web_file_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
+            this.vcs_web_commit_url = 'https://git.yoctoproject.org/' + reponame + '/commit/?id=%hash%'
             this.vcs_web_type = 'cgit'
         }
         else if( repoval.startsWith('git://github.com/') ) {
-- 
2.34.1


