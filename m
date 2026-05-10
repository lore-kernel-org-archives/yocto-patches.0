Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87BCD37B2
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 00:47:41 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22359.1778374060063043499
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 May 2026 17:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=q+RoSm2U;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-366be8040a9so704737a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374059; x=1778978859; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWUHzosjP56wsLW+5LHup3T6f9+ajPtvKbgLXdesrqU=;
        b=q+RoSm2UvjNDzdZCq8uiNqEivKte9PfRWOJlH7hl6Bk9kZoF6D6aVPIyc/uX9mhE2F
         67cL3N/NyjfvMETzbJbt4lPGcO53kX7l5ZaSExIx9jrY7ER5up6kdumiVuMgXdo0P8fM
         fud4RAHjT2NBwoAgayXVfpdJTKmApCGlpmhCE05/wIBjvDROmbQ7AYUxWeQc9dU6kMy8
         4E4fLRd9oEIh1BgiVogdHb08C0nzWHfMChh2ri+h2cQ3YtTim0xDwDyv/UPCx60E3zKl
         nsTTc1WmR/wuuxu4lzkeJRIBejpXvmXYAs0HRXalz0ds6NLWVgWPqpStWKpRx539+Bl+
         VUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374059; x=1778978859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWUHzosjP56wsLW+5LHup3T6f9+ajPtvKbgLXdesrqU=;
        b=lHseR+9lZ4VE/ABCtW2pukVt0vLxrD8AhO5HFsx6RXsGnoman/YdnH54UUSURtFW5n
         G8pjqEM704VmoNPfoeol0bGU9u9ap4qGHg1Eb0lfVhch6o+yEeOQk3KcBCIfRxhRo2ca
         FLfOzVZwzcKLInWUVsvuWZrW1fFErCzJRapmtlKnzoi76b4vkgCMQZbY9RRo2Y/PUAIV
         zp+zOf0s7fRraNL6EZgHK9wgE40TIrHMWysyPsejK2h0FCeplzIf/ttTJLkZyftil32k
         maITRWjBLxuiqjWNlI4f0MSNqf3ZQo1RUfIYH9CVPjxmQVSrhfaVTcCYLEPDB/2mvLLU
         nZlA==
X-Gm-Message-State: AOJu0YzT+i8FW/oxDwD00SxinrT81j+ckVATdzuvfwRnUOJufA+fJUUy
	m0+/hmqulIR/hJ4cA9txGa0WzfbIaB61Rn9f1tkDlkvj+6+KiNhL/6ZsWIOss7qp
X-Gm-Gg: Acq92OEsWsozvL+FJVT9XCHNBymfv+3qmXkplZEb2vw8o2oVD7KHbOfz+4bS10P2VJm
	+XYqNcM2M52SzakHxoRRSHW9+I4KlzCqVp/INC3sa8iWHS5yg0tOZ/2hS8e9VB29wQurKj25+kq
	rOddJjMw/wkzhBtSdUhkrvnufeB5spzjFN/Hra2X3hFOvEGNCZNy5HnwFeFqEw6g+hy7Hgqappc
	3UpZ8MY9pLrrY1nokfneT69w3TbpB/GDv/tcygJtf835HaM0WZe9UnNXSnlt+fsvTzAI48qZBSd
	Gy82xjXZolDiCFEK+GCXj4y57gpkbSMY4yT6Dh0QQswgBDgL54D2WvNmTJc5LCE/FgRggNodhzW
	thCpAyZgjyor546kOTM+PYYbEC/AW6fXk4RGMYwQaac5Ina4i6nUksLSv1jA7cRmzNknOnba4Gf
	VDVAqNI62U/9tKCO4t8giZxvb4OZ3A8TpRkmv9Kw+KvPsXBtXXTE5hov/Id1LEySHbIcF/SWEGc
	7FDt2xYH15G7+5WFztuaio=
X-Received: by 2002:a17:90b:224f:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-365ac080dc9mr18646828a91.15.1778374058637;
        Sat, 09 May 2026 17:47:38 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm3178257a91.7.2026.05.09.17.47.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 17:47:38 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 5/5] layerindex/views.py: fix DuplicatesView 504 from per-row correlated subquery
Date: Sat,  9 May 2026 17:47:03 -0700
Message-ID: <20260510004706.81282-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510004706.81282-1-tim.orling@konsulko.com>
References: <20260510004706.81282-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 00:47:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3962

The previous fix (subquery IN clause + select_related) resolved the Python
memory overhead but the 504 Gateway Timeout persisted because
recipes_preferred_count() uses .extra(select={...}) to embed a correlated
multi-table subquery that the database evaluates once for every result row.
With hundreds of duplicate recipes on the master branch this creates an
O(N) compounding scan that dominates page load time.

Replace the call to recipes_preferred_count() in DuplicatesView.get_recipes
with a two-step batch approach:

1. Fetch all duplicate recipes into a list using the existing subquery +
   select_related (one SQL query).

2. Run a single aggregating query to find, for each pn, the maximum
   index_preference among S/A-type layers in this branch that carry that
   pn (one SQL query returning one row per distinct pn).

3. Annotate each recipe object in Python: preferred_count is set to 1 if
   another S/A layer has a strictly higher index_preference for the same
   pn, otherwise 0.  The template only checks preferred_count > 0, so the
   boolean semantics are identical to the original COUNT.

recipes_preferred_count() is intentionally left unchanged — it is still
used by RecipeSearchView where result sets are paginated to 50 rows and
the per-row cost is negligible.

Also add Max to the django.db.models import line.

[YOCTO #16175]

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py           |  30 ++++++++-
 tests/test_duplicates_view.py | 113 ++++++++++++++++++++++------------
 2 files changed, 100 insertions(+), 43 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 742e5d5..84750f7 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -25,7 +25,7 @@ from django.contrib.sites.models import Site
 from django.core.exceptions import PermissionDenied
 from django.urls import resolve, reverse, reverse_lazy
 from django.db import transaction
-from django.db.models import Count, Q
+from django.db.models import Count, Max, Q
 from django.db.models.functions import Lower
 from django.db.models.query import QuerySet
 from django.db.models.signals import pre_save
@@ -661,8 +661,32 @@ class DuplicatesView(TemplateView):
         # into memory and building a potentially huge IN (...) clause.
         # See: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16175
         dupes = init_qs.values('pn').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1).values('pn')
-        qs = init_qs.filter(pn__in=dupes).select_related('layerbranch__layer').order_by('pn', 'layerbranch__layer', '-pv')
-        return recipes_preferred_count(qs)
+        recipes = list(init_qs.filter(pn__in=dupes).select_related('layerbranch__layer').order_by('pn', 'layerbranch__layer', '-pv'))
+        if not recipes:
+            return recipes
+        # recipes_preferred_count() attaches a correlated subquery via .extra() that
+        # the database evaluates once per result row.  With hundreds of duplicate
+        # recipes that compounds into a slow multi-table correlated scan that causes
+        # a 504 Gateway Timeout.  Instead, compute preferred_count with a single
+        # batch MAX query across all pns and annotate the results in Python.
+        #
+        # A recipe is "non-preferred" (preferred_count > 0) when another layer of
+        # type S or A carries the same pn and has a higher index_preference.
+        pns = {r.pn for r in recipes}
+        pn_max_pref = dict(
+            Recipe.objects.filter(
+                layerbranch__branch__name=self.kwargs['branch'],
+                pn__in=pns,
+                layerbranch__layer__layer_type__in=['S', 'A'],
+            ).values('pn').annotate(
+                max_pref=Max('layerbranch__layer__index_preference')
+            ).values_list('pn', 'max_pref')
+        )
+        for recipe in recipes:
+            own_pref = recipe.layerbranch.layer.index_preference
+            max_pref = pn_max_pref.get(recipe.pn)
+            recipe.preferred_count = 1 if (max_pref is not None and max_pref > own_pref) else 0
+        return recipes
 
     def get_classes(self, layer_ids):
         init_qs = BBClass.objects.filter(layerbranch__branch__name=self.kwargs['branch'])
diff --git a/tests/test_duplicates_view.py b/tests/test_duplicates_view.py
index 304a35c..78d1036 100644
--- a/tests/test_duplicates_view.py
+++ b/tests/test_duplicates_view.py
@@ -9,9 +9,17 @@
 # Tests for bug #16175 - Duplicates page timeout
 # https://bugzilla.yoctoproject.org/show_bug.cgi?id=16175
 #
-# The fix replaces Python list comprehensions used to build IN (...) clauses
-# with Django ORM subqueries, and adds select_related to avoid N+1 queries
-# when the template resolves layerbranch__layer names.
+# The original code had two performance problems:
+#
+# 1. Python list comprehension IN clause: each get_* method pulled all
+#    duplicate names into Python memory and built a huge IN (...) literal.
+#    Fixed by passing the 'dupes' queryset directly so Django emits a subquery.
+#
+# 2. Per-row correlated subquery: get_recipes() called recipes_preferred_count()
+#    which embeds a correlated subquery via .extra() evaluated once per result
+#    row by the database.  With hundreds of duplicate recipes this caused a 504
+#    Gateway Timeout.  Fixed by computing preferred_count with a single batch
+#    MAX query over all pns, then annotating results in Python.
 
 import pytest
 from django.test import TestCase
@@ -35,7 +43,7 @@ class TestDuplicatesView(TestCase):
             updates_enabled=True,
         )
 
-        # Two layers — objects in both will appear as duplicates
+        # layer_a: base layer (type A), lower preference
         self.layer_a = LayerItem.objects.create(
             name='meta-alpha',
             status='P',
@@ -43,7 +51,9 @@ class TestDuplicatesView(TestCase):
             summary='Alpha layer',
             description='Alpha test layer',
             vcs_url='git://example.com/meta-alpha.git',
+            index_preference=0,
         )
+        # layer_b: software layer (type S), higher preference — recipes here win
         self.layer_b = LayerItem.objects.create(
             name='meta-beta',
             status='P',
@@ -51,8 +61,9 @@ class TestDuplicatesView(TestCase):
             summary='Beta layer',
             description='Beta test layer',
             vcs_url='git://example.com/meta-beta.git',
+            index_preference=10,
         )
-        # A third layer whose objects are unique (should NOT appear as duplicates)
+        # layer_c: unique objects only, should never appear as duplicates
         self.layer_c = LayerItem.objects.create(
             name='meta-gamma',
             status='P',
@@ -60,36 +71,42 @@ class TestDuplicatesView(TestCase):
             summary='Gamma layer',
             description='Gamma test layer',
             vcs_url='git://example.com/meta-gamma.git',
+            index_preference=5,
         )
 
         self.lb_a = LayerBranch.objects.create(layer=self.layer_a, branch=self.branch)
         self.lb_b = LayerBranch.objects.create(layer=self.layer_b, branch=self.branch)
         self.lb_c = LayerBranch.objects.create(layer=self.layer_c, branch=self.branch)
 
-        # Duplicate recipe (same pn in layer_a and layer_b)
-        Recipe.objects.create(layerbranch=self.lb_a, filename='shared_1.0.bb',
-                               pn='shared', pv='1.0', filepath='recipes-test')
-        Recipe.objects.create(layerbranch=self.lb_b, filename='shared_1.0.bb',
-                               pn='shared', pv='1.0', filepath='recipes-test')
-        # Unique recipe (only in layer_c — should NOT appear)
-        Recipe.objects.create(layerbranch=self.lb_c, filename='unique_1.0.bb',
-                               pn='unique', pv='1.0', filepath='recipes-test')
-
-        # Duplicate class (same name in layer_a and layer_b)
+        # Duplicate recipe in both layer_a (pref=0) and layer_b (pref=10)
+        self.recipe_a = Recipe.objects.create(
+            layerbranch=self.lb_a, filename='shared_1.0.bb',
+            pn='shared', pv='1.0', filepath='recipes-test')
+        self.recipe_b = Recipe.objects.create(
+            layerbranch=self.lb_b, filename='shared_1.0.bb',
+            pn='shared', pv='1.0', filepath='recipes-test')
+        # Unique recipe only in layer_c — must NOT appear
+        Recipe.objects.create(
+            layerbranch=self.lb_c, filename='unique_1.0.bb',
+            pn='unique', pv='1.0', filepath='recipes-test')
+
+        # Duplicate class in layer_a and layer_b
         BBClass.objects.create(layerbranch=self.lb_a, name='sharedclass')
         BBClass.objects.create(layerbranch=self.lb_b, name='sharedclass')
-        # Unique class (only in layer_c — should NOT appear)
+        # Unique class only in layer_c — must NOT appear
         BBClass.objects.create(layerbranch=self.lb_c, name='uniqueclass')
 
-        # Duplicate include file (same path in layer_a and layer_b)
+        # Duplicate include file in layer_a and layer_b
         IncFile.objects.create(layerbranch=self.lb_a, path='conf/shared.inc')
         IncFile.objects.create(layerbranch=self.lb_b, path='conf/shared.inc')
-        # Unique include file (only in layer_c — should NOT appear)
+        # Unique include file only in layer_c — must NOT appear
         IncFile.objects.create(layerbranch=self.lb_c, path='conf/unique.inc')
 
     def _url(self, branch='main'):
         return reverse('duplicates', kwargs={'branch': branch})
 
+    # --- Basic page health ---
+
     def test_duplicates_view_returns_200(self):
         """DuplicatesView should return HTTP 200."""
         response = self.client.get(self._url())
@@ -110,11 +127,38 @@ class TestDuplicatesView(TestCase):
         self.assertNotIn('unique', pns)
 
     def test_duplicate_recipes_have_two_rows(self):
-        """Each layer's entry for the duplicate recipe should be present."""
+        """Each layer's copy of the duplicate recipe should be present."""
         response = self.client.get(self._url())
         shared = [r for r in response.context['recipes'] if r.pn == 'shared']
         self.assertEqual(len(shared), 2)
 
+    # --- preferred_count (batch MAX computation, replaces per-row correlated subquery) ---
+
+    def test_lower_preference_recipe_is_deemphasised(self):
+        """The layer_a recipe (pref=0) should have preferred_count > 0 because
+        layer_b (pref=10, type S) has a higher-preference copy of the same pn."""
+        response = self.client.get(self._url())
+        recipe_from_a = next(
+            r for r in response.context['recipes']
+            if r.pn == 'shared' and r.layerbranch.layer.name == 'meta-alpha')
+        self.assertGreater(recipe_from_a.preferred_count, 0)
+
+    def test_higher_preference_recipe_is_not_deemphasised(self):
+        """The layer_b recipe (pref=10) should have preferred_count == 0 because
+        no other S/A layer has a higher preference for the same pn."""
+        response = self.client.get(self._url())
+        recipe_from_b = next(
+            r for r in response.context['recipes']
+            if r.pn == 'shared' and r.layerbranch.layer.name == 'meta-beta')
+        self.assertEqual(recipe_from_b.preferred_count, 0)
+
+    def test_preferred_count_attribute_present_on_all_recipes(self):
+        """Every recipe in the context must have a preferred_count attribute."""
+        response = self.client.get(self._url())
+        for recipe in response.context['recipes']:
+            self.assertTrue(hasattr(recipe, 'preferred_count'),
+                            f"preferred_count missing on {recipe.pn}")
+
     # --- Classes ---
 
     def test_duplicate_classes_included(self):
@@ -158,20 +202,15 @@ class TestDuplicatesView(TestCase):
     # --- Layer filter ---
 
     def test_layer_filter_restricts_recipes(self):
-        """Passing ?l=<layer_id> should restrict results to that layer."""
+        """With only one layer selected, nothing can be a duplicate."""
         response = self.client.get(self._url() + f'?l={self.layer_a.id}')
         self.assertEqual(response.status_code, 200)
-        # With only one layer selected, nothing can be a duplicate
         pns = [r.pn for r in response.context['recipes']]
         self.assertNotIn('shared', pns)
 
     def test_wrong_branch_returns_empty(self):
-        """A branch with no data should return empty querysets."""
-        other = Branch.objects.create(
-            name='other',
-            bitbake_branch='other',
-            sort_priority=50,
-        )
+        """A branch with no data should return empty result sets."""
+        Branch.objects.create(name='other', bitbake_branch='other', sort_priority=50)
         response = self.client.get(reverse('duplicates', kwargs={'branch': 'other'}))
         self.assertEqual(response.status_code, 200)
         self.assertEqual(len(list(response.context['recipes'])), 0)
@@ -179,30 +218,24 @@ class TestDuplicatesView(TestCase):
         self.assertEqual(len(list(response.context['incfiles'])), 0)
 
     def test_select_related_avoids_extra_queries(self):
-        """Ensure layerbranch and layer are fetched with select_related.
-
-        Checks that accessing layerbranch.layer.name on query results does not
-        trigger additional database queries (i.e. select_related is working).
-        """
+        """Accessing layerbranch.layer.name after list evaluation fires no new queries."""
         from django.db import connection, reset_queries
         from django.conf import settings
+        import layerindex.views as views_module
 
         settings.DEBUG = True
         reset_queries()
 
-        view = __import__('layerindex.views', fromlist=['DuplicatesView']).DuplicatesView
-        v = view()
+        v = views_module.DuplicatesView()
         v.kwargs = {'branch': 'main'}
-        v.request = None
+        v.request = type('req', (), {'GET': {}})()
 
-        recipes = list(v.get_recipes([]))
+        recipes = v.get_recipes([])
         classes = list(v.get_classes([]))
         incfiles = list(v.get_incfiles([]))
 
-        # Record query count after fetching
         query_count_after_fetch = len(connection.queries)
 
-        # Access layerbranch.layer.name on every result — should NOT fire new queries
         for r in recipes:
             _ = r.layerbranch.layer.name
         for c in classes:
@@ -214,5 +247,5 @@ class TestDuplicatesView(TestCase):
         settings.DEBUG = False
 
         self.assertEqual(query_count_after_fetch, query_count_after_access,
-                         "Unexpected extra queries when accessing layerbranch.layer.name — "
-                         "select_related may not be working")
+                         "Extra queries fired when accessing layerbranch.layer.name — "
+                         "select_related may not be effective")
-- 
2.54.0


