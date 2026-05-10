Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D5CD3447
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 00:47:41 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22529.1778374055170712861
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 May 2026 17:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CjSSVbZp;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-367dd53815fso292196a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374054; x=1778978854; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs8RuFCxoBQjFS91jjdCkhuZq7hlN5GJgHV65iNw72c=;
        b=CjSSVbZpMvv0SMGGBGwxGjBzpI6o8ka3Uc2LOMIeD7oJK+bu5vTm3BcJweXNui3kb3
         W0IEU///o7g6eHAMXtOOMAhTPsC2/gVtBBciQN+Q1cLaWchNl//yaqF1+cKfeLkBDOR/
         cU0ZRNce74piDIpnWdC7tU2x7o2T2FBeIj+yF3G3ZRgUVYfCSvqu0OfW7Mpr82rMzgwG
         uVs989sGmDdakcxWwCezAbAV8raQ4sl8nItwHwhI11x2017VtWRDP608VOQU7YVsMXiF
         TUQJseFeNXHsR91b31Ty0MpShNbotGGPPIaQXw2m89D8DxDuNnt6MoOeNUjyMv5iCzFT
         XyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374054; x=1778978854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vs8RuFCxoBQjFS91jjdCkhuZq7hlN5GJgHV65iNw72c=;
        b=a0FcpLX+DN8/mNbY85R2Ze4MyoZMQo3zen+aZhTGtr1KjYzIA8/Tpay8iD1EIjILy+
         4kujwoo1tifvM9VRNwkRmY/AgAS4x96LKEK9Qu83ciyhwqJ853fwiYwvAKVCNK7Id8qX
         9r6gZwcddKrcSSFB2d84NK5PzpdwQGtxmI5m6GyCchDSK8mup1Uf8SzqrOfWIeg3KPT0
         Z2XyyWg/i/EOs2xsJFKx1JIsLHDC9W293Z8dUSwaOJKHPWYgp/sN9yW2y3Pij4v0zSdP
         iJ9vEhbmAB3ukaKePno0e1rydSswHfG0GiPJydS4ofOxRvW5MFwkgpAwlm/U0gRIqjZy
         yQ6Q==
X-Gm-Message-State: AOJu0Yx59f+lNYa5aV+C8moVEDHbqAFEaafQPdsHfaMgr0NMAosnplzx
	I1AbmF2WLaNrSpq6o27TKcaKa6fZhlEMrsplMJ4KUcdvGriVTnGoTlBoU/yyTQek
X-Gm-Gg: Acq92OGYudnDGX2ZUJmibTOArxS609IjCGhFcG+2LzGyhupQqT7TYGg+ZWbSzu+b6HU
	n1lX2JEpuj0PMsyQ2Q7KFEcObAbUAMvnY31r6EXDb0D7vpqLKiR2L362qH77EcQWXb0YfTtVhJi
	KAEHtBjdEnsb4owBNZ61qgBkveNVpYml9qehAVqXCrFdUlIEWkevJHqNQWR5cQwnI7O1jcanyKW
	Q4PTYfoRsuiXf/OBhb4fzq7FdmDzkrgG/ulcgl6rvMNT1RZbh+vzusyYz6slRRTh7wnWFXMVXbY
	CTrc+g6Woa6G37jPGu7qNGruu7fQf0pY6A+11Z4HigUIRR75E/g+LxmRQqM7s0rJ1hWoN6K48P/
	JkSIKUfdmCXx85H6mmIJV26O//p03IpRDIoLb2fPDZ+/hF3BybQIyz8Ea4az8c+aW5IWFFlXatT
	1YOKn9d/TPsPyIHnQGYJ/hmNu9uZSzU8KHkKcg0M3qAvoYuultkBv/aq53Iz3YwJdEUI3dU25uQ
	ObHnLsEM2EUs2vEnnqfsBs/ef4s6wzSBA==
X-Received: by 2002:a17:90b:2d8a:b0:367:e13b:f52 with SMTP id 98e67ed59e1d1-367e13b11cemr2399916a91.0.1778374053880;
        Sat, 09 May 2026 17:47:33 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm3178257a91.7.2026.05.09.17.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 17:47:33 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/5] tests: add DuplicatesView tests
Date: Sat,  9 May 2026 17:47:02 -0700
Message-ID: <20260510004706.81282-4-tim.orling@konsulko.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3961

Add test_duplicates_view.py covering the DuplicatesView duplicates page:

- HTTP 200 response
- Duplicate recipes/classes/include files are included in context
- Unique (non-duplicate) objects are excluded from context
- Each duplicate appears once per layer (two rows for two layers)
- Layer filter (?l=id) restricts results to the selected layer,
  suppressing duplicates when only one layer is in scope
- Branch with no data returns empty querysets
- select_related check: accessing layerbranch.layer.name after list
  evaluation fires no additional queries

[YOCTO #16175]

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 tests/test_duplicates_view.py | 218 ++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 tests/test_duplicates_view.py

diff --git a/tests/test_duplicates_view.py b/tests/test_duplicates_view.py
new file mode 100644
index 0000000..304a35c
--- /dev/null
+++ b/tests/test_duplicates_view.py
@@ -0,0 +1,218 @@
+# layerindex-web - tests for DuplicatesView
+#
+# Copyright (C) 2026 Tim Orling <tim.orling@konsulko.com>
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+# Tests for bug #16175 - Duplicates page timeout
+# https://bugzilla.yoctoproject.org/show_bug.cgi?id=16175
+#
+# The fix replaces Python list comprehensions used to build IN (...) clauses
+# with Django ORM subqueries, and adds select_related to avoid N+1 queries
+# when the template resolves layerbranch__layer names.
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import (Branch, LayerItem, LayerBranch, Recipe,
+                                BBClass, IncFile)
+
+
+@pytest.mark.django_db
+class TestDuplicatesView(TestCase):
+    """Tests for DuplicatesView (bug #16175 - duplicates page timeout fix)."""
+
+    def setUp(self):
+        self.branch = Branch.objects.create(
+            name='main',
+            bitbake_branch='master',
+            short_description='Main branch',
+            sort_priority=1,
+            hidden=False,
+            updates_enabled=True,
+        )
+
+        # Two layers — objects in both will appear as duplicates
+        self.layer_a = LayerItem.objects.create(
+            name='meta-alpha',
+            status='P',
+            layer_type='A',
+            summary='Alpha layer',
+            description='Alpha test layer',
+            vcs_url='git://example.com/meta-alpha.git',
+        )
+        self.layer_b = LayerItem.objects.create(
+            name='meta-beta',
+            status='P',
+            layer_type='S',
+            summary='Beta layer',
+            description='Beta test layer',
+            vcs_url='git://example.com/meta-beta.git',
+        )
+        # A third layer whose objects are unique (should NOT appear as duplicates)
+        self.layer_c = LayerItem.objects.create(
+            name='meta-gamma',
+            status='P',
+            layer_type='S',
+            summary='Gamma layer',
+            description='Gamma test layer',
+            vcs_url='git://example.com/meta-gamma.git',
+        )
+
+        self.lb_a = LayerBranch.objects.create(layer=self.layer_a, branch=self.branch)
+        self.lb_b = LayerBranch.objects.create(layer=self.layer_b, branch=self.branch)
+        self.lb_c = LayerBranch.objects.create(layer=self.layer_c, branch=self.branch)
+
+        # Duplicate recipe (same pn in layer_a and layer_b)
+        Recipe.objects.create(layerbranch=self.lb_a, filename='shared_1.0.bb',
+                               pn='shared', pv='1.0', filepath='recipes-test')
+        Recipe.objects.create(layerbranch=self.lb_b, filename='shared_1.0.bb',
+                               pn='shared', pv='1.0', filepath='recipes-test')
+        # Unique recipe (only in layer_c — should NOT appear)
+        Recipe.objects.create(layerbranch=self.lb_c, filename='unique_1.0.bb',
+                               pn='unique', pv='1.0', filepath='recipes-test')
+
+        # Duplicate class (same name in layer_a and layer_b)
+        BBClass.objects.create(layerbranch=self.lb_a, name='sharedclass')
+        BBClass.objects.create(layerbranch=self.lb_b, name='sharedclass')
+        # Unique class (only in layer_c — should NOT appear)
+        BBClass.objects.create(layerbranch=self.lb_c, name='uniqueclass')
+
+        # Duplicate include file (same path in layer_a and layer_b)
+        IncFile.objects.create(layerbranch=self.lb_a, path='conf/shared.inc')
+        IncFile.objects.create(layerbranch=self.lb_b, path='conf/shared.inc')
+        # Unique include file (only in layer_c — should NOT appear)
+        IncFile.objects.create(layerbranch=self.lb_c, path='conf/unique.inc')
+
+    def _url(self, branch='main'):
+        return reverse('duplicates', kwargs={'branch': branch})
+
+    def test_duplicates_view_returns_200(self):
+        """DuplicatesView should return HTTP 200."""
+        response = self.client.get(self._url())
+        self.assertEqual(response.status_code, 200)
+
+    # --- Recipes ---
+
+    def test_duplicate_recipes_included(self):
+        """Recipes appearing in more than one layer should be in context."""
+        response = self.client.get(self._url())
+        pns = [r.pn for r in response.context['recipes']]
+        self.assertIn('shared', pns)
+
+    def test_unique_recipes_excluded(self):
+        """Recipes appearing in only one layer should not appear."""
+        response = self.client.get(self._url())
+        pns = [r.pn for r in response.context['recipes']]
+        self.assertNotIn('unique', pns)
+
+    def test_duplicate_recipes_have_two_rows(self):
+        """Each layer's entry for the duplicate recipe should be present."""
+        response = self.client.get(self._url())
+        shared = [r for r in response.context['recipes'] if r.pn == 'shared']
+        self.assertEqual(len(shared), 2)
+
+    # --- Classes ---
+
+    def test_duplicate_classes_included(self):
+        """Classes appearing in more than one layer should be in context."""
+        response = self.client.get(self._url())
+        names = [c.name for c in response.context['classes']]
+        self.assertIn('sharedclass', names)
+
+    def test_unique_classes_excluded(self):
+        """Classes appearing in only one layer should not appear."""
+        response = self.client.get(self._url())
+        names = [c.name for c in response.context['classes']]
+        self.assertNotIn('uniqueclass', names)
+
+    def test_duplicate_classes_have_two_rows(self):
+        """Both layer entries for the duplicate class should be present."""
+        response = self.client.get(self._url())
+        shared = [c for c in response.context['classes'] if c.name == 'sharedclass']
+        self.assertEqual(len(shared), 2)
+
+    # --- Include files ---
+
+    def test_duplicate_incfiles_included(self):
+        """Include files appearing in more than one layer should be in context."""
+        response = self.client.get(self._url())
+        paths = [f.path for f in response.context['incfiles']]
+        self.assertIn('conf/shared.inc', paths)
+
+    def test_unique_incfiles_excluded(self):
+        """Include files appearing in only one layer should not appear."""
+        response = self.client.get(self._url())
+        paths = [f.path for f in response.context['incfiles']]
+        self.assertNotIn('conf/unique.inc', paths)
+
+    def test_duplicate_incfiles_have_two_rows(self):
+        """Both layer entries for the duplicate include file should be present."""
+        response = self.client.get(self._url())
+        shared = [f for f in response.context['incfiles'] if f.path == 'conf/shared.inc']
+        self.assertEqual(len(shared), 2)
+
+    # --- Layer filter ---
+
+    def test_layer_filter_restricts_recipes(self):
+        """Passing ?l=<layer_id> should restrict results to that layer."""
+        response = self.client.get(self._url() + f'?l={self.layer_a.id}')
+        self.assertEqual(response.status_code, 200)
+        # With only one layer selected, nothing can be a duplicate
+        pns = [r.pn for r in response.context['recipes']]
+        self.assertNotIn('shared', pns)
+
+    def test_wrong_branch_returns_empty(self):
+        """A branch with no data should return empty querysets."""
+        other = Branch.objects.create(
+            name='other',
+            bitbake_branch='other',
+            sort_priority=50,
+        )
+        response = self.client.get(reverse('duplicates', kwargs={'branch': 'other'}))
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(len(list(response.context['recipes'])), 0)
+        self.assertEqual(len(list(response.context['classes'])), 0)
+        self.assertEqual(len(list(response.context['incfiles'])), 0)
+
+    def test_select_related_avoids_extra_queries(self):
+        """Ensure layerbranch and layer are fetched with select_related.
+
+        Checks that accessing layerbranch.layer.name on query results does not
+        trigger additional database queries (i.e. select_related is working).
+        """
+        from django.db import connection, reset_queries
+        from django.conf import settings
+
+        settings.DEBUG = True
+        reset_queries()
+
+        view = __import__('layerindex.views', fromlist=['DuplicatesView']).DuplicatesView
+        v = view()
+        v.kwargs = {'branch': 'main'}
+        v.request = None
+
+        recipes = list(v.get_recipes([]))
+        classes = list(v.get_classes([]))
+        incfiles = list(v.get_incfiles([]))
+
+        # Record query count after fetching
+        query_count_after_fetch = len(connection.queries)
+
+        # Access layerbranch.layer.name on every result — should NOT fire new queries
+        for r in recipes:
+            _ = r.layerbranch.layer.name
+        for c in classes:
+            _ = c.layerbranch.layer.name
+        for f in incfiles:
+            _ = f.layerbranch.layer.name
+
+        query_count_after_access = len(connection.queries)
+        settings.DEBUG = False
+
+        self.assertEqual(query_count_after_fetch, query_count_after_access,
+                         "Unexpected extra queries when accessing layerbranch.layer.name — "
+                         "select_related may not be working")
-- 
2.54.0


