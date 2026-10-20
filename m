Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2012.1792529862688144959
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 13:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=S2MUroWk;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso1555753a12.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792529862; x=1793134662; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hmlF5MMSRg1UtPpvJ8QuTjientNnF2dIuppmOsR+fA0=;
        b=S2MUroWkcunmFPVolL0URPTojYWGVICZFeJyL5SAm1s6SuPOs3SeA1A3yU6L0pk8Ox
         emw/K+FMKfiERV8PeMBBef89T4EjpiSO0LiV48Ye+v35jl9n0HG3VaGIpOnoU8h7p4si
         t0fsIlGAgNw2aI3VJz86HqMxy9RirndLdgEcp+sSa6VMCq11P/Q03d/+HtfT51T0iTae
         DOeLn5KD3lrQ7EZo8p8jogXugT2EPkUkU0tK8q5V4u5dE+yda/EODYSPprwv3CbPnZBT
         oKz3qvhbMXkhiGBXBOo3fXhb9uV7+/crEBXzvxqH6KIVJdqxmnQ8g3MCsj8XLOHu3WaM
         4xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529862; x=1793134662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hmlF5MMSRg1UtPpvJ8QuTjientNnF2dIuppmOsR+fA0=;
        b=KflyDivS1jUHaSIabrP2f9Sq4DdPL8OBtvMlu/ruJS9Ovlq71MnC8u467BOvlwgFQE
         uKgA0ePq5cfIcgz8cHEjZCMjh7Ax2CDtvuOxuTEiA9d7ebX6vpIH2+9foftRWm3qkYn/
         Tgf6GbgO6wdoj0sek5wwgZuVs/Y7+8MMSpLKIejoJEriRZ5pC2nFX2gVen/ayz+ZVVZM
         +pK4kaNB8vNGpGwEqopyCvjbKxsjdkpBVDqZCPZHfHDLoSeGCGxXuY1RYgqvDSrw8YZy
         Q6EiTbgH6FmzmsV71ohMiW6MfOEQ/WRaOqY2/oj5vaW+HldLAtUD3x42BhVeHExgg8SB
         gGWw==
X-Gm-Message-State: AFq9FYKogle0lEsJrOyUcswaTF1t8uaVgpj8/pfeiP7Coiv6rwEDq0vX
	CIbsJ4wwXkycFjm3A0f4cnS5AK49Humbt+wqtFcUcMiTZ2IAkBMUWRQE5Hive3ih
X-Gm-Gg: AYBFou3jS/v1Fjp98jQEk0CJgAZ710CrCaes5xpyGV3zZDRXswr3/1plMHSOWYkGfwd
	1epQVlB7KNCz3d5WwF6nxmjbS9NyAX3FFkEv2K0dYTOjErcYvs/Y3XJbE0x/bmFRA+On/xv5+Qv
	sCMm4u44Tc9bzl7JXcS+Wpdc+zqnLDTcG0rZ/00VILgSGqUxlvW15ntcxQkUCJCXyBw/rOeUNiW
	QBmixOS17dDR6Zrx9WJmwECQV2iwqJPlShepC8zRAeAo3rYnj6zvEGaH9U0NGqIOI7ErmGa7fgS
	FtBqZzMaStrSIVF+anxif8ARKdyMuzDncTCxuDgB4OGY1tlXYhyByXwsrRqZJD2RWSyrmMgjNXr
	dPWRzmpoDDWam8VKuVXF9njkzcSVUKLQX31unkK46XGPOAGADk31kyhz3Mj717NbE46oCBsBQef
	OsF44s1W4ugWeOLK92DIgC+xIMXH6XCfgsjxeOTKPNlbVYnfTaO2FAVD1TXcc2X5WSS8Dkec9Jn
	RJUJjCYnUv7OQe7ycGXN+lYGFIeyQw=
X-Received: by 2002:a17:90b:2b4f:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3ad86d5066dmr97810a91.42.1792529861923;
        Tue, 20 Oct 2026 13:57:41 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8029765fsm1039115a91.10.2026.10.20.13.57.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 13:57:40 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] layerindex: restrict bulk changes to their owner
Date: Tue, 20 Oct 2026 13:57:28 -0700
Message-ID: <20261020205730.53370-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020205730.53370-1-tim.orling@konsulko.com>
References: <20261020205730.53370-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 20:57:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5115
Content-Type: text/plain; charset="utf-8"

The bulk change search and delete views only allow the user who owns
the changeset, but the edit, review and patch views did not check
ownership or require a login. Anyone could view or edit another user's
bulk change, or start patch generation for it.

Require a login for all of these views and look the changeset up by
owner, so other users' changesets return 404 as the delete view
already does. Also require a login for the delete view, which
otherwise failed for anonymous users.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/urls.py              | 10 +++----
 layerindex/views.py             | 23 ++++++++++++--
 tests/test_bulkchange_access.py | 53 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 8 deletions(-)
 create mode 100644 tests/test_bulkchange_access.py

diff --git a/layerindex/urls.py b/layerindex/urls.py
index 51a832d..92f419f 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -6,18 +6,18 @@
 #
 # SPDX-License-Identifier: MIT
 
-from django.views.generic import TemplateView, DetailView, ListView, RedirectView
+from django.views.generic import TemplateView, ListView, RedirectView
 from django.views.defaults import page_not_found
 from django.urls import include, re_path, reverse_lazy
 from layerindex.views import LayerListView, LayerReviewListView, LayerReviewDetailView, RecipeSearchView, \
     MachineSearchView, LayerDetailView, edit_layer_view, delete_layer_view, edit_layernote_view, delete_layernote_view, \
     HistoryListView, EditProfileFormView, AdvancedRecipeSearchView, BulkChangeView, BulkChangeSearchView, \
-    bulk_change_edit_view, bulk_change_patch_view, BulkChangeDeleteView, RecipeDetailView, RedirectParamsView, \
+    bulk_change_edit_view, bulk_change_patch_view, BulkChangeReviewView, BulkChangeDeleteView, RecipeDetailView, RedirectParamsView, \
     ClassicRecipeSearchView, ClassicRecipeDetailView, ClassicRecipeStatsView, LayerUpdateDetailView, UpdateListView, \
     UpdateDetailView, StatsView, publish_view, LayerCheckListView, BBClassCheckListView, TaskStatusView, \
     ComparisonRecipeSelectView, ComparisonRecipeSelectDetailView, task_log_view, task_stop_view, email_test_view, \
     BranchCompareView, RecipeDependenciesView, update_layer_view
-from layerindex.models import LayerItem, Recipe, RecipeChangeset
+from layerindex.models import LayerItem, Recipe
 from rest_framework import routers
 from . import restviews
 
@@ -97,9 +97,7 @@ urlpatterns = [
     re_path(r'^bulkchange/(?P<pk>\d+)/edit/$',
         bulk_change_edit_view, {'template_name': 'layerindex/bulkchangeedit.html'}, name="bulk_change_edit"),
     re_path(r'^bulkchange/(?P<pk>\d+)/review/$',
-        DetailView.as_view(
-            model=RecipeChangeset,
-            context_object_name='changeset',
+        BulkChangeReviewView.as_view(
             template_name='layerindex/bulkchangereview.html'),
         name="bulk_change_review"),
     re_path(r'^bulkchange/(?P<pk>\d+)/patches/$',
diff --git a/layerindex/views.py b/layerindex/views.py
index c030ae1..42722bf 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -307,8 +307,9 @@ def edit_layer_view(request, template_name, branch='master', slug=None):
         'return_url': return_url,
     })
 
+@login_required
 def bulk_change_edit_view(request, template_name, pk):
-    changeset = get_object_or_404(RecipeChangeset, pk=pk)
+    changeset = get_object_or_404(RecipeChangeset, pk=pk, user=request.user)
 
     if request.method == 'POST':
         formset = BulkChangeEditFormSet(request.POST, queryset=changeset.recipechange_set.all())
@@ -322,8 +323,9 @@ def bulk_change_edit_view(request, template_name, pk):
         'formset': formset,
     })
 
+@login_required
 def bulk_change_patch_view(request, pk):
-    changeset = get_object_or_404(RecipeChangeset, pk=pk)
+    changeset = get_object_or_404(RecipeChangeset, pk=pk, user=request.user)
     # FIXME this couples the web server and machine running the update script together,
     # but given that it's a separate script the way is open to decouple them in future
     try:
@@ -855,10 +857,27 @@ class BaseDeleteView(DeleteView):
         return context
 
 
+class BulkChangeReviewView(DetailView):
+    model = RecipeChangeset
+    context_object_name = 'changeset'
+
+    @method_decorator(login_required)
+    def dispatch(self, request, *args, **kwargs):
+        return super(BulkChangeReviewView, self).dispatch(request, *args, **kwargs)
+
+    def get_queryset(self):
+        qs = super(BulkChangeReviewView, self).get_queryset()
+        return qs.filter(user=self.request.user)
+
+
 class BulkChangeDeleteView(BaseDeleteView):
     model = RecipeChangeset
     success_url = reverse_lazy('bulk_change')
 
+    @method_decorator(login_required)
+    def dispatch(self, request, *args, **kwargs):
+        return super(BulkChangeDeleteView, self).dispatch(request, *args, **kwargs)
+
     def get_queryset(self):
         qs = super(BulkChangeDeleteView, self).get_queryset()
         return qs.filter(user=self.request.user)
diff --git a/tests/test_bulkchange_access.py b/tests/test_bulkchange_access.py
new file mode 100644
index 0000000..e85451d
--- /dev/null
+++ b/tests/test_bulkchange_access.py
@@ -0,0 +1,53 @@
+# layerindex-web - tests for bulk change access control
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.contrib.auth.models import User
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import RecipeChangeset
+
+
+@pytest.mark.django_db
+class TestBulkChangeAccess(TestCase):
+
+    def setUp(self):
+        self.owner = User.objects.create_user('owner', 'owner@example.com', 'pw')
+        self.other = User.objects.create_user('other', 'other@example.com', 'pw')
+        self.changeset = RecipeChangeset.objects.create(user=self.owner, name='mine')
+
+    def _url(self, name):
+        return reverse(name, args=(self.changeset.pk,))
+
+    def test_anonymous_redirected_to_login(self):
+        for name in ('bulk_change_edit', 'bulk_change_review', 'bulk_change_patches', 'bulk_change_delete'):
+            response = self.client.get(self._url(name))
+            self.assertEqual(response.status_code, 302, name)
+            self.assertIn('login', response['Location'], name)
+
+    def test_other_user_gets_404(self):
+        self.client.force_login(self.other)
+        for name in ('bulk_change_edit', 'bulk_change_review', 'bulk_change_patches', 'bulk_change_delete'):
+            response = self.client.get(self._url(name))
+            self.assertEqual(response.status_code, 404, name)
+        response = self.client.post(self._url('bulk_change_delete'))
+        self.assertEqual(response.status_code, 404)
+        self.assertTrue(RecipeChangeset.objects.filter(pk=self.changeset.pk).exists())
+
+    def test_other_user_cannot_post_edits(self):
+        self.client.force_login(self.other)
+        # A valid (empty) edit formset, which would be saved and redirect
+        # to the review page if the changeset were found
+        data = {'form-TOTAL_FORMS': '0', 'form-INITIAL_FORMS': '0'}
+        response = self.client.post(self._url('bulk_change_edit'), data)
+        self.assertEqual(response.status_code, 404)
+
+    def test_owner_can_access(self):
+        self.client.force_login(self.owner)
+        for name in ('bulk_change_edit', 'bulk_change_review'):
+            response = self.client.get(self._url(name))
+            self.assertEqual(response.status_code, 200, name)
-- 
2.56.0

