Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16929.1792894156764127633
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 19:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dMwTNGhM;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2428661a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 19:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894156; x=1793498956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhWEcpjMDHjITfFZVGoi2Fqv0l+sJhzU6DCf9UUu3n8=;
        b=dMwTNGhMTs/lgw0zOngsTvpH6iffOI5Qt43Zr8+AwwdAiwRpE4ZRaJNMlR+6KcAcVm
         8AtIaJgCKN8fouH3hgJVZKlHAG53eK1LIEPUNBnJqJ0cP0QpsEbfH83MzemqGLmRxe6n
         n+A8ujV0jiSwG0vGMHwAsmvQj0PIm7/H+xiq4HS4GNeFDduA+seP7+ypw3LT/Qiv50Ut
         SCQ0xVxo9TUxRyCGry8wp9CHGNBiKIej3bo/+D3Uia5qZ7lp4e2yG3i4wReqZURME7rW
         D2BykZHBrG7oZSzQ+E3tNDWRxdneLWIpGcxKaSYc9FQ5zZQyV++xHtCQ6O2i9cqHwPDG
         NW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894156; x=1793498956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhWEcpjMDHjITfFZVGoi2Fqv0l+sJhzU6DCf9UUu3n8=;
        b=IVts6arDaU3lP9y1E+3/Kpn1yuzSw6oaeuYzwZB4wz+Tduh3hxMjcsxZoVAXnfI06S
         vRWv4tNrGSF5uGXc/TGpvqqQLEX9WYjTeJkq4PorH4CILeKANb1rRp89iMVnpdJg2GJ0
         oYf4C/vk26OoXFfhbh8qrMMKjsPGb5qzoEG5csQu2YwS0jIuG1VDuEIisRROCGGc0b9q
         s82IHWR2ADFwEU4wan69pD9Z8hiiDG3UNqwCgou2L6naut6wrOBtMnwMlyXOBBIXgNki
         9JhVjz4AgaFqAOregB7MO30KGHifsUDbbiynOI4GAqv27GbTqCrgz/TJi4WZQ9+pKptB
         ZSTA==
X-Gm-Message-State: AFq9FYIlXnd2jMvRF4yS9bmEc4hbLhxqsm1oJodLqNhAoRlonKW3XKJf
	nHaEygRx8uNwR3vj6M3sfotsYIo7n2c65wEx9HYS7A6aOuXGCfWBpS9KtqD1sA==
X-Gm-Gg: AYBFou2MeegEbRIBbkOMju1WoDabYPuu8NVxWqiwbyiHleKsvbZvE7WhE+8Oo7oEpR9
	5fCBwxQjeFNr13iR/jBVhEhr2treWV/CKXJETLdbca13rniYimP4r1V8Ee2cy3nUI1wqIa1uFW9
	RmHKvnCaqoEf5wAcQK9UANUqn+5zD+y85NZ3XnTGfu8w0nxfecuyYTP3Q74h5YAazQhDRYFJQ4E
	WA43qkq36nGSpBKCpyIuCqzGQ6WQ+qj1OzbFnX6V2ZyviPPpUJKkJACtUQWQSSKpiqix/TwH45J
	hskt+3xpRnVmxlc469YbIa13RFGMlX2ZxR+vYRkVb2s8RK6MGtYsIE+T/iNSF91uBXtIKF+/sLg
	M+OZddr3dOJwoz6VQAajK3EIdKIPRP9a5nXubW2sxOVxgWPLQ5T4/6u0Eu2cIVhWqzZm1rj/m8X
	PwnxWoW1VShctFkeFMd7IQQpujtawVgUtkjp5UbyLLKG+EXO1wAAVzSWg81h42tHZO7iy1QMV4H
	Gzcsxl6/qrKcrpxqzFj5FIrIfndQPgBZqY5iFpz6mQ12YFGoQP6I0XyW2Fs2Jf0jGM7j5DWXUZR
	TmIZ1C6LCLduaSywzWafJvoZXs26OWdx8g==
X-Received: by 2002:a17:90a:d010:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3adeae6caf4mr3086737a91.39.1792894155975;
        Sat, 24 Oct 2026 19:09:15 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm4132936a91.0.2026.10.24.19.09.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 19:09:15 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: expand recursive dependencies from the right layer branch
Date: Sat, 24 Oct 2026 19:09:11 -0700
Message-ID: <20261025020912.90595-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 02:09:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5151
Content-Type: text/plain; charset="utf-8"

The Expand button on the layer page fetches each dependency's own
dependencies by LayerBranch id, but the list items held the
dependency's LayerItem id, so the first level of the tree came from
an unrelated layer branch, or was empty. Use the dependency's layer
branch on the current branch instead, and start cycle detection with
the layer itself.

[YOCTO #12599]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/models.py             |  4 ++++
 templates/layerindex/detail.html |  4 ++--
 tests/test_layer_dependencies.py | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_layer_dependencies.py

diff --git a/layerindex/models.py b/layerindex/models.py
index 425af53..1d72c55 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -409,6 +409,10 @@ class LayerDependency(models.Model):
     def __str__(self):
         return "%s depends on %s" % (self.layerbranch.layer.name, self.dependency.name)
 
+    def dependency_layerbranch(self):
+        """Return the dependency's LayerBranch on the same branch, if any"""
+        return LayerBranch.objects.filter(layer=self.dependency, branch_id=self.layerbranch.branch_id).first()
+
 
 class LayerNote(models.Model):
     layer = models.ForeignKey(LayerItem, on_delete=models.CASCADE)
diff --git a/templates/layerindex/detail.html b/templates/layerindex/detail.html
index 9ab6bf6..6c20f47 100644
--- a/templates/layerindex/detail.html
+++ b/templates/layerindex/detail.html
@@ -166,7 +166,7 @@
                                 <p>The {{ layeritem.name }} layer depends upon:</p>
                                 <ul id="dependencies_list">
                                     {% for dep in layerbranch.get_required %}
-                                        <li data-layerbranch="{{ dep.dependency.id }}">
+                                        <li data-layerbranch="{{ dep.dependency_layerbranch.id }}">
                                             <a href="{% url 'layer_item' url_branch dep.dependency.name %}">{{ dep.dependency.name }}</a>
                                         </li>
                                     {% endfor %}
@@ -540,7 +540,7 @@
 
                     var layerBranchId = $(this).data('layerbranch');
 
-                    $(this).append(expandLayerDependencies(layerBranchId, []));
+                    $(this).append(expandLayerDependencies(layerBranchId, [{{ layerbranch.id }}]));
                 });
             });
 
diff --git a/tests/test_layer_dependencies.py b/tests/test_layer_dependencies.py
new file mode 100644
index 0000000..1dd8250
--- /dev/null
+++ b/tests/test_layer_dependencies.py
@@ -0,0 +1,41 @@
+# layerindex-web - tests for showing layer dependencies
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerBranch, LayerDependency, LayerItem
+
+
+@pytest.mark.django_db
+class TestLayerDependencies(TestCase):
+
+    def make_layer(self, name):
+        return LayerItem.objects.create(name=name, status='P', layer_type='A',
+                                        summary='test', description='test',
+                                        vcs_url='git://example.com/%s.git' % name)
+
+    def setUp(self):
+        master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+        other = Branch.objects.create(name='other', bitbake_branch='master')
+        top = self.make_layer('meta-top')
+        dep = self.make_layer('meta-dep')
+        # Create layer branches on another branch first, so that meta-dep's
+        # LayerItem and LayerBranch ids differ
+        LayerBranch.objects.create(layer=top, branch=other)
+        LayerBranch.objects.create(layer=dep, branch=other)
+        self.dep_layerbranch = LayerBranch.objects.create(layer=dep, branch=master)
+        top_layerbranch = LayerBranch.objects.create(layer=top, branch=master)
+        self.dependency = LayerDependency.objects.create(layerbranch=top_layerbranch, dependency=dep)
+        self.assertNotEqual(dep.id, self.dep_layerbranch.id)
+
+    def test_dependency_layerbranch(self):
+        self.assertEqual(self.dependency.dependency_layerbranch(), self.dep_layerbranch)
+
+    def test_detail_page_lists_dependency_layerbranch(self):
+        response = self.client.get(reverse('layer_item', args=('master', 'meta-top')))
+        self.assertContains(response, '<li data-layerbranch="%d">' % self.dep_layerbranch.id)
-- 
2.56.0

