Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122BCDE000
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 20:05:26 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20409.1782417925674119860
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jun 2026 13:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MHqcbBjB;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845a3c05df9so124052b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417925; x=1783022725; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLPyxbype/vOAGo6nmYGHYm95HsiPQs65mxSWXIhM4A=;
        b=MHqcbBjB3Nq+d6/70Z6mhrHVkvV6/Vw5prN/AQSJvy1N9Yt0cPAJMuWLypH+I85E6W
         aDixWnlODb2E55ULLjLJAHwaOM4WFD1Gb8Tpe7VHoUlHT4wg2aYxdr9u4exrLrfaRClT
         ZcxwiVeKDGjNEzaL98KT1yTGOUONOMIaOIurO0oEjlnyGjFwDX5KsklgdgjdIGua1SB+
         liCH/RkpJJ1yu/lb/xu5SibNsa9/Q2hcMxDvCd99oR86ERoj39Lo+c3k92lph+tbudvq
         cUJuk1p4HOGuRs3IWpgP6LW/A3fcGcDgyCMszrh6cXnkIEXoVXLbPRJK2BcA6lvUNmL1
         kUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417925; x=1783022725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLPyxbype/vOAGo6nmYGHYm95HsiPQs65mxSWXIhM4A=;
        b=HlYft3SerkZF2z6G8C8dGSpAAdVRgntxBZA9m5t0GzstjxoU6tV7c42j3txKj10ocG
         sDgKjPKg7n29ZAL1ZVhFcPOjx29Wb4iud3zPBnZ0wNO3rMecll6Lt0FVYpggqCDBjIoS
         arrh3+oG3rUz+/ITujnBYIlziaV9KVibgG9EQEaYf6rktViV4sVH7lOrwexN4YZYAjqx
         mI5MEfS/wzKNmBqRXjHFFajsN1UW+rQNhSnKgDxW0bvb9qeUAq+LVZO2wy+8puf2/g0O
         I6MOBd7de5j03IQy3v3/F/S8UafpNNfnPCzAL7kDwGhXI/CGeFBTJFzeQcC+iLkuJDCf
         4saw==
X-Gm-Message-State: AOJu0Yzh2Lvzpwu7Jx40bkKTcQONg8hY9iDW3LMuRxBJwDk8Tfn5L9p7
	8JZdT+H6L8F8UPr9yjHXUGzvlCb23gEGphaVEb5JTvq6Rzrg+QTLXU0i7gH7EA==
X-Gm-Gg: AfdE7cnNN2Momp+e1q8oR3qcQ/B/SY+THQSpSKhQ49taS2sEVbn5CTbEBnIiAf/pHJT
	A1BHcLpPvK2qcaj5DwGCqnBorm4KHKQTOnn0YHo0IZfzMw0RPy+SsFMOw8Fn6+bOaEOeyCcT8E4
	Z47K9kGZsiqON2ac3CgcxSPznncQo3oWuC8tFg1MSn/GKfetiOFxkDpelibJclyF+Yvfi8B6iSs
	Gxw6hLAvEoL6eXYuWV+API9CvoIzZVa/jkApQ2WXplZFUt6WrGrm5P8pwwWd39bLaAuC/l7E3Bw
	cjKk4KylkDue3bQZ5z9s2ZOEVBo1W1afumyYs1V6oU2LKGfA0NcjBJmURzNsifxuPk7mdQXYKd2
	WkqelxjBNE4miSYNuulTx3JpgErqOhjdJUjY1iXC+VFow175qvs+DxTpnBUNbXaWSdy4M8dFI+y
	Gc4IvB5tL78qUWTbyloP5+ne6V0tdPNqYbvf/wh59O9eORYmLGFfhwNwm+d1S5i6ei4IrxJAwwN
	ijvrVmZDSTI
X-Received: by 2002:a05:6a00:66c4:b0:845:bc1d:40f2 with SMTP id d2e1a72fcca58-845bc1d4599mr2349916b3a.11.1782417924799;
        Thu, 25 Jun 2026 13:05:24 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23ccsm6012211b3a.36.2026.06.25.13.05.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 13:05:23 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] Add 'local' files to "Sources"
Date: Thu, 25 Jun 2026 13:04:51 -0700
Message-ID: <20260625200450.93797-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 20:05:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4305

Previously, "local" URIs such as 'file://run-ptest' were
explicitly skipped. Add handling of 'file://' URIs for
the Source model (ignoring Patches as those were already
handled elsewhere).

Similar to "Recipe File" field, we display the layer path
to the file and provide a link to it.

Fixes: [Yocto #13757]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/migrations/0052_source_path.py | 16 +++++++++++
 layerindex/models.py                      |  5 ++++
 layerindex/update_layer.py                | 34 ++++++++++++++++++-----
 templates/layerindex/recipedetail.html    |  2 +-
 4 files changed, 49 insertions(+), 8 deletions(-)
 create mode 100644 layerindex/migrations/0052_source_path.py

diff --git a/layerindex/migrations/0052_source_path.py b/layerindex/migrations/0052_source_path.py
new file mode 100644
index 0000000..8047947
--- /dev/null
+++ b/layerindex/migrations/0052_source_path.py
@@ -0,0 +1,16 @@
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0051_fix_yoctoproject_cgit_urls'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='source',
+            name='path',
+            field=models.CharField(blank=True, max_length=255),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index 864264b..eb7d8bf 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -531,12 +531,17 @@ class Source(models.Model):
     recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
     url = models.CharField(max_length=255)
     sha256sum = models.CharField(max_length=64, blank=True)
+    # Layer-relative path for local (file://) sources, used to link to the
+    # file in the layer's repository (empty for remote sources)
+    path = models.CharField(max_length=255, blank=True)
 
     def web_url(self):
         def drop_dotgit(url):
             if url.endswith('.git'):
                 url = url[:-4]
             return url
+        if self.path:
+            return self.recipe.layerbranch.file_url(self.path) or None
         if self.url and self.url.startswith(('http', 'ftp')):
             return self.url
         elif self.url.startswith('git://github.com'):
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 33c5cfb..432201a 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -138,15 +138,35 @@ def update_recipe_file(tinfoil, data, path, recipe, layerdir_start, repodir, sto
         recipe.save()
 
         # Handle sources
+        import bb.fetch2
+        import oe.patch
         old_urls = list(recipe.source_set.values_list('url', flat=True))
-        for url in (envdata.getVar('SRC_URI', True) or '').split():
-            if not url.startswith('file://'):
+        srcfetch = bb.fetch2.Fetch([], envdata)
+        for url in srcfetch.urls:
+            # Patches are recorded separately (shown in the Patches section),
+            # so skip them here - but keep other local file:// entries
+            # (e.g. run-ptest, init scripts, config files) as sources.
+            if oe.patch.patch_path(url, srcfetch, '', expand=False):
+                continue
+            path = ''
+            if url.startswith('file://'):
+                # Show local files without the file:// scheme (e.g. run-ptest)
+                # and, if the file lives in this layer, record its path so we
+                # can link to it in the layer's repository.
+                try:
+                    localpath = srcfetch.localpath(url)
+                except bb.fetch2.FetchError:
+                    localpath = ''
+                if localpath and localpath.startswith(layerdir_start):
+                    path = os.path.relpath(localpath, layerdir_start)
+                url = url[7:].split(';')[0]
+            else:
                 url = url.split(';')[0]
-                if url in old_urls:
-                    old_urls.remove(url)
-                else:
-                    src = Source(recipe=recipe, url=url)
-                    src.save()
+            if url in old_urls:
+                old_urls.remove(url)
+            else:
+                src = Source(recipe=recipe, url=url, path=path)
+                src.save()
         for url in old_urls:
             recipe.source_set.filter(url=url).delete()
 
diff --git a/templates/layerindex/recipedetail.html b/templates/layerindex/recipedetail.html
index 6446386..5322758 100644
--- a/templates/layerindex/recipedetail.html
+++ b/templates/layerindex/recipedetail.html
@@ -163,7 +163,7 @@
                     <tbody>
                         {% for source in recipe.source_set.all %}
                         <tr>
-                            <td>{% if source.web_url %}<a href="{{ source.web_url }}">{% endif %}{{ source.url }}{% if source.web_url %}</a>{% endif %}</td>
+                            <td>{% if source.web_url %}<a href="{{ source.web_url }}">{% endif %}{{ source.path|default:source.url }}{% if source.web_url %}</a>{% endif %}</td>
                         </tr>
                         {% endfor %}
                     </tbody>
-- 
2.54.0


