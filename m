Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2010.1792529859913968616
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 13:57:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LpzcQDQt;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd76b1361dso232725ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529859; x=1793134659; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F9SE/o8z6hKNH+cHvqLL0T+gEq2TC4h83Gg9ZXdlEL0=;
        b=LpzcQDQt9BL/pzLzfTKdfeuCQaKjfmW6CtySzGlzrNPrZaqL2JYPVHvqeBuecRjrQv
         KCzC0J+twQG99aIYi2zLv3LAncAui1Nbh3URQHiBgAMn5ih3qJvlKei8L3K1UDlt3CyJ
         LWGPLWViFWxhwGxaHAUhvxTla0RnKf93hQ7biZdQzWBMnhoPO71wMkMgUnXg6QaZYOeZ
         d0GM0r4bgRVUuvrDQgzDrEWxJgwJBT9NmqPZhAH5ejPOlrjUOS/qHfjS+kZonbXSjrEx
         flFCp+FK3EMQwvZuKmKMWYAk20z6OUIF7Apznh4dpJCIsIvAngVzvlJK3zjYZ01Wt3fB
         Wjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529859; x=1793134659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9SE/o8z6hKNH+cHvqLL0T+gEq2TC4h83Gg9ZXdlEL0=;
        b=qp1sjwZYRfXavND00qlFETJIIA1+mSiKsF7L/fkCWL03FBr8dSHHpGwrduKAF5ElnN
         konmxI+oaZ+FGDmdSbYpRE71LZAmBcaTMuThwPS4m4p2IsB8XOTDxcS2mF9rnvkXXDbv
         XhrziG3Ax+7s15ZZlPoCkuUHdDkAHDxL2oKScapVz3j2vGGkKxW//EFweZTTxSySuhYi
         NmSTc/ICFeikNKqWFKYf4jEjXbSp3ue9FGvQfbODVqJJFl0Hh4J2b1ABcpoYY8PG0y64
         Pmwt6Ie+a0bBGh4qFISjrtiZWvFvCXjaRO561+KOY5Kgf0gLWFyAYS9KH+61EVg3YDsv
         Ybgg==
X-Gm-Message-State: AFq9FYKaGCil2AQp12FsfCbteu6/HgCKteZeiB1zcipgUYdRHAhaus87
	COKQzPKn4McV6UjfC5Are63MiO+2esQIFTsXQ8f6aXS2g++GSQ6KNKK6ATT1Advd
X-Gm-Gg: AYBFou2Gh+2ybE3JUhNOouh07m4p3vYf5YOf3dPaGsuJXh2hVIdrNYl4wbriZhmLSW/
	6Rv+IAOLdeH5Q9slxPmM2vNQRYD4NfO8Ki1QB/p3zW4Yf/0Ozhuo1JRYnxO7IwDp8SFYzM/uUmr
	fEfEe77cjk7+c8kPdVvF8nSD95cMc7jA1vZRNgX9LDvnfSj//oudgI1sf7zsNx1NpKl46ZFgq4e
	GVk+a3xv65GYmYrykOkANFyBGjZdWR5y4pF0X7GD+r5Avzn66darptYVimvf7sRHZoG4gUL+3fI
	ZKx6AEdQ4mMo1c1paCqcatp3UNudU6myw44Ouvdq+sQAJ/BEnVlHcbnu3D3WRc2C00O+7pyz4+R
	zb40TJ/dgzixsJ49p7jWRdymZJUSewjHKP7kSCfZsoR+mnDEUYROu934BREQ12L3wA0IdZbfWIG
	/AiBp5cUzRnuufQboy8dy3T/G9fy9baU01kceVJyHH1+fRvv6ildPw+jk39rh8G9ozTiW0sFhqJ
	5qSW7g8vduF11XApL9ZwEYSgAT6NGc0Vy19Yfluvw==
X-Received: by 2002:a17:90b:5106:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ad86dcaf4dmr102711a91.6.1792529859098;
        Tue, 20 Oct 2026 13:57:39 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8029765fsm1039115a91.10.2026.10.20.13.57.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 13:57:36 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] layerindex/views: fix reflected XSS in recipes CSV export
Date: Tue, 20 Oct 2026 13:57:27 -0700
Message-ID: <20261020205730.53370-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020205730.53370-1-tim.orling@konsulko.com>
References: <20261020205730.53370-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 20:57:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5114
Content-Type: text/plain; charset="utf-8"

layer_export_recipes_csv_view echoed an invalid name from the "fields"
query parameter back in an HttpResponse with the default text/html
content type, so a crafted link could run script on the site without
the victim being logged in. Return the error as text/plain with status
400 instead.

Reported by CodeQL (py/reflective-xss).

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py       |  2 +-
 tests/test_recipes_csv.py | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_recipes_csv.py

diff --git a/layerindex/views.py b/layerindex/views.py
index dea0a98..c030ae1 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1599,7 +1599,7 @@ def layer_export_recipes_csv_view(request, branch, slug):
     recipe_fields = [f.name for f in Recipe._meta.get_fields() if not (f.auto_created and f.is_relation)]
     for field in fieldlist:
         if field not in recipe_fields:
-            return HttpResponse('Field %s is invalid' % field)
+            return HttpResponse('Field %s is invalid' % field, content_type='text/plain', status=400)
 
     writer = csv.writer(response)
     for recipe in layerbranch.sorted_recipes():
diff --git a/tests/test_recipes_csv.py b/tests/test_recipes_csv.py
new file mode 100644
index 0000000..9ed9084
--- /dev/null
+++ b/tests/test_recipes_csv.py
@@ -0,0 +1,33 @@
+# layerindex-web - tests for the layer recipes CSV export
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import Branch, LayerItem, LayerBranch
+
+
+@pytest.mark.django_db
+class TestRecipesCsv(TestCase):
+
+    def setUp(self):
+        branch = Branch.objects.create(name='master', bitbake_branch='master')
+        layer = LayerItem.objects.create(name='meta-test', status='P', layer_type='A',
+                                         summary='test', description='test',
+                                         vcs_url='git://example.com/meta-test.git')
+        LayerBranch.objects.create(layer=layer, branch=branch)
+        self.url = reverse('layer_export_recipes_csv', args=('master', 'meta-test'))
+
+    def test_valid_fields(self):
+        response = self.client.get(self.url, {'fields': 'pn,pv'})
+        self.assertEqual(response.status_code, 200)
+        self.assertTrue(response['Content-Type'].startswith('text/csv'))
+
+    def test_invalid_field_not_reflected_as_html(self):
+        response = self.client.get(self.url, {'fields': '<script>alert(1)</script>'})
+        self.assertEqual(response.status_code, 400)
+        self.assertTrue(response['Content-Type'].startswith('text/plain'))
-- 
2.56.0

