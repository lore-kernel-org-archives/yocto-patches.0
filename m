Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6020.1794870261980592503
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:04:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=xoyWU/wj;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cddff772fffso407230a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794870261; x=1795475061; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQQC1k4aWDZyYdwWVP9lWSpW1VZaU3LoCi1BNAO83eY=;
        b=xoyWU/wjB6hRVkYB86UCeMmUtKLU+h8YdjFQV46NcOxVVC+1T3eaobv8SBcivQLWzT
         iNsm0G/jlB5dcqqna7rVbyCcDtyvTlM85lWCZd1O4pXJ/5UTQcWtdjTlPNyQ/BHG/7d/
         dLiU1dO6/R0+LzegDOb/LiISmv7NIz14J6QYPWkxKbrD4SbbChUwQUqk1ecYmnizKy12
         IUuide56tRppwF2lDVnygQBmxhgICh9OgUYfMmrLthBBS8mcp4vDnTSH0Cazhug9nmGI
         ZSZaGoR/le0La/Rg9mxjfbWACjwpuDLc47OrFN/17b9l3X09xQ7BaUADvNo7VRr/ikxw
         tMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870261; x=1795475061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQQC1k4aWDZyYdwWVP9lWSpW1VZaU3LoCi1BNAO83eY=;
        b=koL5ldO3OC6TAaRguI63uAs4vUb/Vs8WmcTWC/acQ17JiwSMslrUhkNUQp88xNc8qj
         Ku/aqv56cO1Wqg1esDwz4NQOgQKGlCg39EvInH5pRXPimvgKAjAdhqB3zFYMrvyWjo0T
         jPOlk6GcCaOock+d0RXW5rMGlahn0aNzpe881d9ZzHU6X5hIk6N3yDT8Wm47PKptft6b
         +mCupqr8sddcrituaXsi57idGTx1B/arnVN9XGSS46apNCIuUcWuOXf4UubFKwhK27ee
         Jz3Vel7gaS0GOYy9VCkrCDydBWB4c+TwGAXnLlsaIHhWvAXmi12CEzSuFFjaPe2uFItk
         xr9Q==
X-Gm-Message-State: APuU4Z98Uqai65r3/N+It+vbKlzCKXx0zzpBcrmI4L75D739UfKmYYJl
	edPqi9UzhE8ResabS6xSPUEXy4jCrAEaIKedaXseDH2Zm5PrXmplCKlF3Obg7A==
X-Gm-Gg: AYBFou1z3syT060I5I71nGDXKnO7IKZ18lgBh488wp2J7a1Zr7Fwggt+lm0/vN4BaNd
	zytElcNmKmLD/YPnNRQ2d36YyXiyqjrtviGT+1iV5TotoRZq/aAqAW8+08vgW6TbMsVjyAj/hhE
	o9YDMFut6UTq/jY0J/apbktorGuzBU8+6VygI1o8mAMWbWHzILe53Npdi61krv0b/h7dW/emkk4
	JsNWxHTn2x0N+p7NC06pFcT1Aw7Y84DDaQKS+NTAgcifKikivR2ISJ6ILpdKQ53wpzjzkr42APx
	agkpwYlLmGGRkssjDOk41s4hxFH4oWl777O5MzktbzzgDJic2mbiuEjgnlP+0ZCHYtw3wBG+vqY
	0b3j3ojg6sh8ULxI2cfotGurrDeyj0cR9eD1fShcjfDsMZBqkl+tIE5bRU6QXS/CRO2bZT/siTN
	laJ2aqZ0as18c6a+b+ri7sWVKKHFvt4SpKppdn/98Kt1jRHaoh4E93Ojko3/rgAPJAAPs9FgitT
	rh0CwsvaLqRZg6UlJ+sq2sjsCj70+hxx7GsDSppEzkLBTnF5Cc8ymXTAjcXohxWbKtcPZ16OfeF
	guzsC6HMO5CTlZ/Q4gwVPg9nIXPlWHbnRNB/R99K2QRfmb8ma+c6SHD1Coxctw==
X-Received: by 2002:a05:6a21:3d95:b0:3fa:df2d:d3e2 with SMTP id adf61e73a8af0-3fadf2dd835mr3882629637.16.1794870261072;
        Mon, 16 Nov 2026 15:04:21 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a90f1sm4210535b3a.19.2026.11.16.15.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 15:04:20 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] layerindex: give a 404 for a non-numeric id in a URL
Date: Mon, 16 Nov 2026 15:03:51 -0800
Message-ID: <20261116230401.42917-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116230401.42917-1-tim.orling@konsulko.com>
References: <20261116230401.42917-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:04:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5437
Content-Type: text/plain; charset="utf-8"

The URL patterns captured primary keys with [-\w]+, and BranchCompareView
passed the from_branch and to_branch parameters straight to the id
lookup, so a value such as /layerindex/recipe/NaN/ or from_branch= raised
ValueError and gave a 500. Match only digits in the URLs and check the
branch parameters, so these are a 404.

[YOCTO #16519]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/urls.py           | 18 ++++++-------
 layerindex/views.py          | 32 +++++++++++-----------
 tests/test_nonnumeric_ids.py | 51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 24 deletions(-)
 create mode 100644 tests/test_nonnumeric_ids.py

diff --git a/layerindex/urls.py b/layerindex/urls.py
index 32e51d9..9910eee 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -72,19 +72,19 @@ urlpatterns = [
         name='layer_review'),
     re_path(r'^layer/(?P<slug>[-\.\w]+)/addnote/$',
         edit_layernote_view, {'template_name': 'layerindex/editlayernote.html'}, name="add_layernote"),
-    re_path(r'^layer/(?P<slug>[-\.\w]+)/editnote/(?P<pk>[-\w]+)/$',
+    re_path(r'^layer/(?P<slug>[-\.\w]+)/editnote/(?P<pk>\d+)/$',
         edit_layernote_view, {'template_name': 'layerindex/editlayernote.html'}, name="edit_layernote"),
-    re_path(r'^layer/(?P<slug>[-\.\w]+)/deletenote/(?P<pk>[-\w]+)/$',
+    re_path(r'^layer/(?P<slug>[-\.\w]+)/deletenote/(?P<pk>\d+)/$',
         delete_layernote_view, {'template_name': 'layerindex/deleteconfirm.html'}, name="delete_layernote"),
     re_path(r'^layer/(?P<slug>[-\.\w]+)/delete/$',
         delete_layer_view, {'template_name': 'layerindex/deleteconfirm.html'}, name="delete_layer"),
-    re_path(r'^recipe/(?P<pk>[-\w]+)/$',
+    re_path(r'^recipe/(?P<pk>\d+)/$',
         RecipeDetailView.as_view(
             template_name='layerindex/recipedetail.html'),
         name='recipe'),
     re_path(r'^layer/(?P<name>[-\.\w]+)/publish/$', publish_view, name="publish"),
     re_path(r'^layers/published/rss/$', PublishedLayersFeed(), name='published_layers_feed'),
-    re_path(r'^layerupdate/(?P<pk>[-\w]+)/$',
+    re_path(r'^layerupdate/(?P<pk>\d+)/$',
         LayerUpdateDetailView.as_view(
             template_name='layerindex/layerupdate.html'),
         name='layerupdate'),
@@ -114,7 +114,7 @@ urlpatterns = [
         UpdateListView.as_view(
             template_name='layerindex/updatelist.html'),
         name='update_list'),
-    re_path(r'^updates/(?P<pk>[-\w]+)/$',
+    re_path(r'^updates/(?P<pk>\d+)/$',
         UpdateDetailView.as_view(
             template_name='layerindex/updatedetail.html'),
         name='update'),
@@ -143,7 +143,7 @@ urlpatterns = [
     re_path(r'^oe-classic/stats/$',
         RedirectView.as_view(url=reverse_lazy('comparison_recipe_stats', kwargs={'branch': 'oe-classic'}), permanent=False),
         name='classic_recipe_stats'),
-    re_path(r'^oe-classic/recipe/(?P<pk>[-\w]+)/$',
+    re_path(r'^oe-classic/recipe/(?P<pk>\d+)/$',
         ClassicRecipeDetailView.as_view(
             template_name='layerindex/classicrecipedetail.html'),
         name='classic_recipe'),
@@ -161,15 +161,15 @@ urlpatterns = [
         ClassicRecipeStatsView.as_view(
             template_name='layerindex/classicstats.html'),
         name='comparison_recipe_stats'),
-    re_path(r'^comparison/recipe/(?P<pk>[-\w]+)/$',
+    re_path(r'^comparison/recipe/(?P<pk>\d+)/$',
         ClassicRecipeDetailView.as_view(
             template_name='layerindex/classicrecipedetail.html'),
         name='comparison_recipe'),
-    re_path(r'^comparison/select/(?P<pk>[-\w]+)/$',
+    re_path(r'^comparison/select/(?P<pk>\d+)/$',
         ComparisonRecipeSelectView.as_view(
             template_name='layerindex/comparisonrecipeselect.html'),
         name='comparison_select'),
-    re_path(r'^comparison/selectdetail/(?P<selectfor>[-\w]+)/(?P<pk>[-\w]+)/$',
+    re_path(r'^comparison/selectdetail/(?P<selectfor>[-\w]+)/(?P<pk>\d+)/$',
         ComparisonRecipeSelectDetailView.as_view(
             template_name='layerindex/comparisonrecipeselectdetail.html'),
         name='comparison_select_detail'),
diff --git a/layerindex/views.py b/layerindex/views.py
index 92da12b..d503a94 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1979,33 +1979,35 @@ class BranchCompareView(FormView):
                     layer_ids.append(int(layer_id))
         return layer_ids
 
+    def get_branch(self, param):
+        # A non-numeric id is a 404, not a ValueError (AI-generated, Claude Opus 5.5)
+        branch_id = self.request.GET.get(param, None)
+        if branch_id is None:
+            return None
+        if not (branch_id.isascii() and branch_id.isdigit()):
+            raise Http404
+        return get_object_or_404(Branch, id=branch_id)
+
     def form_valid(self, form):
         return HttpResponseRedirect(reverse_lazy('branch_comparison', args=(form.cleaned_data['from_branch'].name, form.cleaned_data['to_branch'].name)))
 
     def get_initial(self):
         initial = super(BranchCompareView, self).get_initial()
-        from_branch_id = self.request.GET.get('from_branch', None)
-        if from_branch_id is not None:
-            initial['from_branch'] = get_object_or_404(Branch, id=from_branch_id)
-        to_branch_id = self.request.GET.get('to_branch', None)
-        if to_branch_id is not None:
-            initial['to_branch'] = get_object_or_404(Branch, id=to_branch_id)
+        from_branch = self.get_branch('from_branch')
+        if from_branch is not None:
+            initial['from_branch'] = from_branch
+        to_branch = self.get_branch('to_branch')
+        if to_branch is not None:
+            initial['to_branch'] = to_branch
         initial['layers'] = ','.join(str(i) for i in self.get_layer_ids())
         return initial
 
     def get_context_data(self, **kwargs):
         context = super(BranchCompareView, self).get_context_data(**kwargs)
-        from_branch_id = self.request.GET.get('from_branch', None)
-        to_branch_id = self.request.GET.get('to_branch', None)
-
         layer_ids = self.get_layer_ids()
-        from_branch = None
-        if from_branch_id is not None:
-            from_branch = get_object_or_404(Branch, id=from_branch_id)
+        from_branch = self.get_branch('from_branch')
         context['from_branch'] = from_branch
-        to_branch = None
-        if to_branch_id is not None:
-            to_branch = get_object_or_404(Branch, id=to_branch_id)
+        to_branch = self.get_branch('to_branch')
         context['to_branch'] = to_branch
         if from_branch and to_branch:
             context['added'], context['changed'], context['removed'] = self.get_recipes(from_branch, to_branch, layer_ids)
diff --git a/tests/test_nonnumeric_ids.py b/tests/test_nonnumeric_ids.py
new file mode 100644
index 0000000..1f64d4d
--- /dev/null
+++ b/tests/test_nonnumeric_ids.py
@@ -0,0 +1,51 @@
+# layerindex-web - tests for non-numeric ids in URLs
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# [YOCTO #16519]: a non-numeric id in a URL or in the branch_comparison
+# parameters reached the database as an id and raised ValueError (a 500).
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import Branch, LayerItem
+
+
+@pytest.mark.django_db
+class TestNonNumericIds(TestCase):
+
+    def assert_not_found(self, url, params=None):
+        response = self.client.get(url, params or {})
+        self.assertEqual(response.status_code, 404, (url, params))
+
+    def test_recipe(self):
+        for pk in ('NaN', '_', '1e400', 'true', 'é'):
+            self.assert_not_found('/layerindex/recipe/%s/' % pk)
+
+    def test_classic_recipe(self):
+        self.assert_not_found('/layerindex/oe-classic/recipe/x/')
+
+    def test_comparison_recipe(self):
+        self.assert_not_found('/layerindex/comparison/recipe/x/')
+
+    def test_branch_comparison(self):
+        branch = Branch.objects.create(name='testbranch', bitbake_branch='master',
+                                       short_description='Test', sort_priority=1)
+        for value in ('', 'x', '²'):
+            for url in ('/layerindex/branch_comparison/', '/layerindex/branch_comparison_plain/'):
+                self.assert_not_found(url, {'from_branch': value, 'to_branch': branch.id})
+                self.assert_not_found(url, {'from_branch': branch.id, 'to_branch': value})
+
+    def test_branch_comparison_valid(self):
+        branch = Branch.objects.create(name='testbranch', bitbake_branch='master',
+                                       short_description='Test', sort_priority=1)
+        # The comparison shows the core layer by default
+        LayerItem.objects.create(name='openembedded-core', status='P', layer_type='A',
+                                 summary='core', description='core',
+                                 vcs_url='git://example.com/oe-core.git')
+        response = self.client.get('/layerindex/branch_comparison/', {'from_branch': branch.id})
+        self.assertEqual(response.status_code, 200)
-- 
2.56.1

