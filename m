Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5330.1794867876944840247
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:24:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=IBo45bz/;
 spf=pass (domain: gmail.com, ip: 209.85.215.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1809197a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794867876; x=1795472676; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mD2Vg/w9hnc/PLl0n0TiVJQ86JmMisraooNAksUKMzk=;
        b=IBo45bz/YTXSqSsoYRTUdxHAnG10s9Uq0nHN/ABt8x0zacoyYqycbHLGqp+JugrdK9
         VZeRMIUveIQnh/DQcIL5mAo6BN3Q0lEmUX3j58Nvq/tZDGXtnOBFB6Jiw6lgd/oZqqtL
         LIPatxPYtT/sLhE6+pNyRY3LkiH7Ue5mxj3WjoOBz+4Jd3SIG+Wddy8TiqwQgkRiiOwR
         KqlWcu4DbKUGEqP1ugPU/CnbYYvPWpS9OIC1nVTQc7KGuyNmgs/982zRflZzmK7lsfb7
         Xdpa5A9xtvTn3hn9r9CG1g316xPzBDNS/AjVpgcq6OSrN/4aURnuWD1AHR0knxRWD3qW
         EuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867876; x=1795472676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mD2Vg/w9hnc/PLl0n0TiVJQ86JmMisraooNAksUKMzk=;
        b=2LMeaZ/wuLcSYFBAX2EcfG6df96FvwapRvbZSxTB3mTfVQqaQeugPBE9luMiZMlPEj
         /6N7pA0dIFXwkgMxM1SyHXGQNT+QxZ66seE/Bd5dO75t2e1YtbwqsCLoA2aoQn7EMlQE
         qgCETIIk2PJr7J9YIdFMBxslSVtkkRdogh957uh/luifMjfjq9QrkO++0atwXETyPUBN
         MMalvf0HHvus8dG/K1w/BkrVu2V7+x1NQrRmNDM3W9YcP11Et2MeDblh4luXrid32c7v
         sFUjcSLtRzuXlT3PmBvdFSnvQhAjb5GApJP0r/ugIcgVM0EjOZOsQNEqjXq48INmKG14
         /Glg==
X-Gm-Message-State: APuU4Z8U4u9RYWUGF2Y7N2hRy5g7vxTA3AOoMgKzDHqcJSmrI6O5PTUV
	UnPBhJr2fmpoBC/nMAF8YtvT3KyW4FFXydc563oBNsM1kCIY/4j+MnONRfdbxw==
X-Gm-Gg: AZFdTZdJCq9kQWHCV5fjZgG9i14aLodFn9Zf28Yqm9JbfvUYtP13OiK4SkPy9E+YdhK
	l1MdN/nERtJqGbYBPgSTBf14RXJtvh3oCk1Rn0lXtmw3nCh9Y+Hf0mCTDwhh7Axk34MMdl6WPSc
	DOQ0Miovf7TitJMDSbTqRzGiqR4BYLLHwaz6F8YB2oAzbOY4fJ1rA9MiikD2KpqmuoMhca8mTrs
	NUADKXWCujFAG8MEf+PaOP0EwXuTD2f6ozcIjrhy21iZNmhg3OeAt7tJf5vuGgbs5E0VgJNbwqc
	8LetzkWDzKRR6ouhCJSkf8evsAtY9IBNEW6jDQpxx0adBEGx/WXxM8OHKfdAbOad5xIdQQgaWVZ
	yL6Yw+l5obtbkY5W0G23UJsq6CdsMUwC6nWYKPfcaOohhDAjBJNyZzMzDa2d3yVrX42yPP6ULo+
	9Kn6IdtxSA3tlsOkJiorUmj/jpswupf1Xx4s6+JPO9C3wB69lLPzruR1gjHd51Ry44a52tsJPMX
	O+nzG7CJJJxf7BcXtB9PsqxROOi2nTt8AVcbxYAIdKDp9Et+uZYaMqIw6z9p9tvU62Qcp/bw3pL
	PxJ0tAOVzhHdsKCxt2+aotDIzhyp6esGzir75XwQ8L++cLqXIogc8ng1A7YXkBwyXmNN7PD1re7
	4w1bxThk=
X-Received: by 2002:a17:90b:4a84:b0:3b0:ad42:dcb3 with SMTP id 98e67ed59e1d1-3b1b09fa377mr10543250a91.14.1794867876091;
        Mon, 16 Nov 2026 14:24:36 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7ab4abcsm4618945ad.70.2026.11.16.14.24.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 14:24:35 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] rrs/views.py: fetch the recipe detail page's upgrades in a few queries
Date: Mon, 16 Nov 2026 14:24:10 -0800
Message-ID: <20261116222410.35784-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116222410.35784-1-tim.orling@konsulko.com>
References: <20261116222410.35784-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:24:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5433
Content-Type: text/plain; charset="utf-8"

The recipe detail page ran about nine queries per upgrade to find the
release and milestone it falls in and whether its author maintained the
recipe then, so linux-yocto, with 282 upgrades, took 3.7 s. Read the
plan's releases and milestones once and pick from them by date, and look
up each maintainer history and maintainer once per page. Releases with
the same dates are picked in id order, as the queries returned them.
Also fetch the other branches' recipes with their layer branch and branch.

On a copy of the production database the page data for 153 OE-Core
recipes is identical before and after, and linux-yocto takes 0.3 s
instead of 3.6 s.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/views.py                    | 63 +++++++++++++++++++------
 tests/rrs/test_recipe_detail.py | 84 +++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 14 deletions(-)
 create mode 100644 tests/rrs/test_recipe_detail.py

diff --git a/rrs/views.py b/rrs/views.py
index 81ef35e..529b203 100644
--- a/rrs/views.py
+++ b/rrs/views.py
@@ -754,31 +754,63 @@ class RecipeUpgradeDetail():
         self.upgrade_type = upgrade_type
         self.group = group
 
-def _get_recipe_upgrade_detail(maintplan, recipe_upgrade):
+def _get_release_and_milestone(maintplan, commit_date, lookups):
+    """
+    Release.get_by_date() and Milestone.get_by_release_and_date() for
+    commit_date, from the plan's releases and milestones read once into
+    lookups (AI-generated, Claude Opus 5.5)
+    """
+    if 'releases' not in lookups:
+        # id breaks ties between releases with the same dates as the queries did
+        lookups['releases'] = list(Release.objects.filter(plan=maintplan).order_by('-end_date', 'id'))
+        lookups['milestones'] = {}
+        for milestone in Milestone.objects.filter(release__plan=maintplan) \
+                .exclude(name='All').order_by('-end_date', 'id'):
+            lookups['milestones'].setdefault(milestone.release_id, []).append(milestone)
+    # The queries compare the DateFields with the commit's date
+    commit_day = commit_date.date()
+    release = next((r for r in lookups['releases']
+                    if r.start_date <= commit_day <= r.end_date), None)
+    milestone = None
+    if release:
+        milestone = next((m for m in lookups['milestones'].get(release.id, [])
+                          if m.start_date <= commit_day <= m.end_date), None)
+    return release, milestone
+
+def _get_recipe_upgrade_detail(maintplan, recipe_upgrade, lookups=None):
+    # lookups keeps what several upgrades of a recipe share, so a caller
+    # that passes the same dict for each runs fewer queries
+    if lookups is None:
+        lookups = {}
     release_name = ''
     milestone_name = ''
     recipe_maintainer_history = None
 
-    release = Release.get_by_date(maintplan, recipe_upgrade.commit_date)
+    release, milestone = _get_release_and_milestone(maintplan, recipe_upgrade.commit_date, lookups)
     if release:
         release_name = release.name
-        milestone = Milestone.get_by_release_and_date(release,
-                recipe_upgrade.commit_date)
         if milestone:
             milestone_name = milestone.name
-            recipe_maintainer_history = RecipeMaintainerHistory.get_by_end_date(
-                recipe_upgrade.recipesymbol.layerbranch,
-                milestone.end_date)
+            key = ('maintainer_history', recipe_upgrade.recipesymbol.layerbranch_id, milestone.end_date)
+            if key not in lookups:
+                lookups[key] = RecipeMaintainerHistory.get_by_end_date(
+                    recipe_upgrade.recipesymbol.layerbranch,
+                    milestone.end_date)
+            recipe_maintainer_history = lookups[key]
 
     is_recipe_maintainer = False
     maintainer_name = ''
     if not recipe_upgrade.maintainer is None:
         maintainer_name = recipe_upgrade.maintainer.name
 
-        if not recipe_maintainer_history is None and \
-            RecipeMaintainer.objects.filter(maintainer__name
-            = maintainer_name, history = recipe_maintainer_history) \
-            .count() > 0:
+        key = ('is_maintainer', maintainer_name,
+               recipe_maintainer_history.id if recipe_maintainer_history else None)
+        if key not in lookups:
+            lookups[key] = not recipe_maintainer_history is None and \
+                RecipeMaintainer.objects.filter(maintainer__name
+                = maintainer_name, history = recipe_maintainer_history) \
+                .exists()
+        if lookups[key]:
             is_recipe_maintainer = True
 
     commit_date = recipe_upgrade.commit_date.date().isoformat()
@@ -849,8 +881,11 @@ class RecipeDetailView(DetailView):
         details = []
         multigroup = False
         lastgroup = '' # can't use None here
-        for ru in RecipeUpgrade.objects.filter(recipesymbol=recipesymbol).exclude(upgrade_type='M').order_by('group', '-commit_date', '-id'):
-            details.append(_get_recipe_upgrade_detail(maintplan, ru))
+        lookups = {}
+        # Through the related manager, each upgrade shares recipesymbol
+        for ru in recipesymbol.recipeupgrade_set.select_related('maintainer', 'group') \
+                .exclude(upgrade_type='M').order_by('group', '-commit_date', '-id'):
+            details.append(_get_recipe_upgrade_detail(maintplan, ru, lookups))
             if not multigroup:
                 if lastgroup == '':
                     lastgroup = ru.group
@@ -882,7 +917,7 @@ class RecipeDetailView(DetailView):
             context['recipe_depends'] = []
             context['recipe_distros'] = []
 
-        context['otherbranch_recipes'] = Recipe.objects.filter(layerbranch__layer=recipesymbol.layerbranch.layer, layerbranch__branch__comparison=False, pn=recipesymbol.pn).order_by('layerbranch__branch__sort_priority')
+        context['otherbranch_recipes'] = Recipe.objects.filter(layerbranch__layer=recipesymbol.layerbranch.layer, layerbranch__branch__comparison=False, pn=recipesymbol.pn).select_related('layerbranch__branch').order_by('layerbranch__branch__sort_priority')
 
         return context
 
diff --git a/tests/rrs/test_recipe_detail.py b/tests/rrs/test_recipe_detail.py
new file mode 100644
index 0000000..d29d136
--- /dev/null
+++ b/tests/rrs/test_recipe_detail.py
@@ -0,0 +1,84 @@
+# layerindex-web - tests for the RRS recipe detail page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# The recipe detail page lists a recipe's upgrades with the release and
+# milestone each falls in, and whether its author maintained the recipe then.
+# It must get them without running queries per upgrade.
+
+import datetime
+
+from django.db import connection
+from django.test.utils import CaptureQueriesContext
+
+from rrs.models import (
+    Maintainer,
+    RecipeMaintainer,
+    RecipeMaintainerHistory,
+    RecipeSymbol,
+    RecipeUpgrade,
+)
+
+
+def setup_recipe(layerbranch):
+    """busybox, maintained by Alice since 2026-10-15"""
+    alice, _ = Maintainer.objects.get_or_create(name='Alice')
+    Maintainer.objects.get_or_create(name='Bob')
+    history = RecipeMaintainerHistory.objects.create(
+        title='Update maintainers', date=datetime.datetime(2026, 10, 15), author=alice,
+        sha1='0' * 40, layerbranch=layerbranch)
+    symbol = RecipeSymbol.objects.create(layerbranch=layerbranch, pn='busybox', summary='busybox')
+    RecipeMaintainer.objects.create(recipesymbol=symbol, maintainer=alice, history=history)
+    return symbol
+
+
+def add_upgrade(symbol, version, when, maintainer_name):
+    # USE_TZ is False
+    RecipeUpgrade.objects.create(recipesymbol=symbol, version=version, author_date=when,
+                                 commit_date=when, upgrade_type='U', sha1='1' * 40,
+                                 maintainer=Maintainer.objects.get(name=maintainer_name))
+
+
+def details(client, symbol):
+    response = client.get(f'/rrs/recipedetail/OE-Core/{symbol.pk}/')
+    assert response.status_code == 200
+    return response.context['recipe_upgrade_details']
+
+
+def test_release_milestone_and_maintainer(client, rrs_plan):
+    symbol = setup_recipe(rrs_plan.layerbranch)
+    add_upgrade(symbol, '1.37.0', datetime.datetime(2026, 11, 1, 10), 'Alice')
+    add_upgrade(symbol, '1.36.1', datetime.datetime(2026, 10, 2, 10), 'Bob')
+    # In release 6.2 but after its only milestone
+    add_upgrade(symbol, '1.38.0', datetime.datetime(2027, 2, 1, 10), 'Alice')
+    # Before any release
+    add_upgrade(symbol, '1.30.0', datetime.datetime(2025, 1, 1, 10), 'Alice')
+
+    rows = {d.version: (d.release_name, d.milestone_name, d.maintainer_name, d.is_recipe_maintainer)
+            for d in details(client, symbol)}
+
+    assert rows == {
+        '1.38.0': ('6.2', '', 'Alice', False),
+        '1.37.0': ('6.2', 'M1', 'Alice', True),
+        '1.36.1': ('6.2', 'M1', 'Bob', False),
+        '1.30.0': ('', '', 'Alice', False),
+    }
+
+
+def test_queries_do_not_grow_with_upgrades(client, rrs_plan):
+    symbol = setup_recipe(rrs_plan.layerbranch)
+    add_upgrade(symbol, '1.0', datetime.datetime(2026, 10, 2), 'Alice')
+    add_upgrade(symbol, '1.1', datetime.datetime(2026, 10, 3), 'Bob')
+    details(client, symbol)  # fills the per-process caches first
+    with CaptureQueriesContext(connection) as two:
+        assert len(details(client, symbol)) == 2
+    for day in range(4, 10):
+        add_upgrade(symbol, f'1.{day - 2}', datetime.datetime(2026, 10, day),
+                    'Alice' if day % 2 else 'Bob')
+    with CaptureQueriesContext(connection) as eight:
+        assert len(details(client, symbol)) == 8
+    assert len(eight) == len(two)
-- 
2.56.1

