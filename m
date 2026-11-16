Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5326.1794867873830920147
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Xq/OpMA+;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed0890476fso31690545ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794867873; x=1795472673; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWeZ812I+YU5VXnKnv0OHTOJ/JcosAl5H4QM/CTZEBI=;
        b=Xq/OpMA+UpifZ2gNPXNuhw+SUnLbDR+bWVYCKz5lH6D+kaWohSRGuPNNv4J+McvXzf
         b7szwBcdBSZGbu9xTvvAXjPcPzdbLaZWPdis4Aaq3ozsc/cdQ784LIvKAaL+G5kNAA5X
         6hyqh8cXDaVWSzNSimAKF10O7jYGcgyqlNYKwC2Jo99t9i16vt5qdp91QPWJykd6fGzt
         tKM4Wrf/CgX1GV/uxoLvChj4NQlP6SqCMaFD6tk2mVgfK3bkzSk6jtvoxxvj0FrZGh58
         Ml83J0ORpeKPGd4f9kIQjjM8TeKf6/N7aCTjzqvzJVu7JqllxYBTAqZ/admZ8okcmZtU
         wu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867873; x=1795472673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWeZ812I+YU5VXnKnv0OHTOJ/JcosAl5H4QM/CTZEBI=;
        b=nInWSNJMi6ziSeUQnLdBDbzDEdsDXpttHmuedw2zgIA6YnkRcl8hGbw0hx/L8wwOal
         y6RKazSQVegk7G4ds3451TIabZNiRFB0hHOpOdy1K9nuG0voV9MQZnLklZCJqPJfEvn+
         aJAnCUeEsiFmpa8BX/e9y/wnleRU8Jta+REIDxpa9+vCJmMNtjA4a6l6iYBzZpn/gvES
         fk+9jEbWdxHCnCF8p6rkWGZHiguVIyFdxcb8zqHYm515lACaLvdvP0mBbL0EXBTUMalq
         2VIN7/xf638/6FES0pSy/OWzUJIHon4QlUho8BLuJE9WTvF9s7X576zDAluw6LDrYM1G
         W6vg==
X-Gm-Message-State: APuU4Z/jePU/SqOUB/jXuXSvsBvQc+KK2TL610JDZ5j0lTc59kGB/l4+
	NgZ8pKLMtrGHq/UNdRdnzCRYIlWU/nJCDvpVA9Up+slrLU2clLT7V97vI4STWQ==
X-Gm-Gg: AZFdTZenmn/5A1/MVWR2G7e3Qex0nEs0/G6l/Q/Qk4yWygcNCP9SwUEvZMEiMQ/qr1q
	2iaXOdN7TMQRnUPreZKvkATEhmsNGS/R9Aa9+W0Y6e+WxFJ0KG6rgBrfHDn99ARtdzq6hJb9QoR
	f+VarxYkFMUqAwRWXk1uLK+/xu12wyPcqDQItfWfdhFxj1W0USAwr7O/Qaa5ptr6VbzMtmpCqvm
	pxTr0RE8tmeQVBnQ8iTjnlGF1lzJ4ydjnU6YTCVHyRiPsC9WnXCR8yz6djHUzCxB8ke+e+r8Zyz
	XmWdsONDzkZIdsFdu/Mk/AUe5O54keLm45jeZcKqou5ZAz/6DbRr6WJpfYZsoFI6hiTggT6oi9G
	mSJ+iRKHomKngfY7BHoM6WJGdEU+bNv51hJcBHnsQb/uUm/7rGgYfdGznO2v/wy1TGBn2qQv/cS
	1BPYVKKCBfKELCYG0XiBIRaLM0Tlz97Xaq4+EB+j7/H2T1pW6jjvpqcZ3avwJuDlHCMBlwALvES
	AiA6mb3N0uZ6aPtyGPZyB+VsPRfazal8w3Tqh3DU1OacraXkO9WONcFwMRpFC9LGJRSo4lJaoEB
	zH9bPNIGpgHvhMileiULll3CsnCle4+wLFLL2lrnKorKTFwIlBsx3CxOyjUkfRhffFqENLatd4p
	ebtJSOt8=
X-Received: by 2002:a17:902:e744:b0:2e9:6333:fbb8 with SMTP id d9443c01a7336-2ee0dd2ed49mr111856255ad.12.1794867873111;
        Mon, 16 Nov 2026 14:24:33 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7ab4abcsm4618945ad.70.2026.11.16.14.24.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 14:24:32 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] rrs/views.py: fetch the maintainers page's statistics in a few queries
Date: Mon, 16 Nov 2026 14:24:09 -0800
Message-ID: <20261116222410.35784-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116222410.35784-1-tim.orling@konsulko.com>
References: <20261116222410.35784-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:24:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5432
Content-Type: text/plain; charset="utf-8"

The maintainers page ran about a dozen queries per maintainer: the
statistics of each maintainer separately, then one count of upgrades per
maintainer per interval. Compute every maintainer's statistics from one
read of the maintainer and upstream records per layer branch, and count
each interval's upgrades for all maintainers in one grouped query.

On a copy of the production database the page data for 9 milestones is
identical before and after, and OE-Core 6.2 takes 28 queries and 0.08 s
instead of 952 queries and 0.75 s.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/views.py                  | 78 +++++++++++++++++++++++++++--
 tests/rrs/test_maintainers.py | 94 +++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 4 deletions(-)
 create mode 100644 tests/rrs/test_maintainers.py

diff --git a/rrs/views.py b/rrs/views.py
index b580818..81ef35e 100644
--- a/rrs/views.py
+++ b/rrs/views.py
@@ -373,6 +373,68 @@ def _get_milestone_statistics(milestone, maintainer_name=None):
 
     return milestone_statistics
 
+def _get_maintainers_statistics(milestone, maintainer_names):
+    """
+    The statistics of _get_milestone_statistics(milestone, name) for every
+    name in maintainer_names, with a few queries per layer branch rather
+    than several per maintainer (AI-generated, Claude Opus 5.5)
+    """
+    statistics = {name: {'all': 0, 'up_to_date': 0, 'not_updated': 0,
+                         'cant_be_updated': 0, 'unknown': 0}
+                  for name in maintainer_names}
+    if not statistics:
+        return statistics
+
+    for maintplanlayer in milestone.release.plan.maintenanceplanlayerbranch_set.all():
+        layerbranch = maintplanlayer.layerbranch
+
+        recipe_upstream_history = RecipeUpstreamHistory.get_last_by_date_range(
+            layerbranch,
+            milestone.start_date,
+            milestone.end_date
+        )
+        recipe_maintainer_history = Raw.get_remahi_by_end_date(
+                layerbranch.id, milestone.end_date)
+        if not recipe_maintainer_history:
+            continue
+
+        maintainer_recipes = {}
+        for recipesymbol_id, name in RecipeMaintainer.objects.filter(
+                history_id=recipe_maintainer_history[0]).values_list(
+                'recipesymbol_id', 'maintainer__name'):
+            maintainer_recipes.setdefault(name, set()).add(recipesymbol_id)
+
+        recipe_upstreams = {}
+        if recipe_upstream_history and maintainer_recipes:
+            for ru in RecipeUpstream.objects.filter(
+                    history=recipe_upstream_history).values(
+                    'recipesymbol_id', 'status', 'no_update_reason'):
+                recipe_upstreams.setdefault(ru['recipesymbol_id'], []).append(ru)
+
+        for name, maintainer_statistics in statistics.items():
+            recipes = maintainer_recipes.get(name, set())
+            maintainer_statistics['all'] += len(recipes)
+            for recipesymbol_id in recipes:
+                for ru in recipe_upstreams.get(recipesymbol_id, []):
+                    if ru['status'] == 'Y':
+                        maintainer_statistics['up_to_date'] += 1
+                    elif ru['status'] == 'N':
+                        if ru['no_update_reason'] == '':
+                            maintainer_statistics['not_updated'] += 1
+                        else:
+                            maintainer_statistics['cant_be_updated'] += 1
+                    else:
+                        maintainer_statistics['unknown'] += 1
+
+    for maintainer_statistics in statistics.values():
+        maintainer_statistics['percentage'] = '0'
+        if maintainer_statistics['all'] > 0:
+            maintainer_statistics['percentage'] = "%.0f" % \
+                ((float(maintainer_statistics['up_to_date']) /
+                    float(maintainer_statistics['all'])) * 100)
+
+    return statistics
+
 class RecipeList():
     pk = None
     name = None
@@ -879,8 +941,18 @@ class MaintainerListView(ListView):
 
         self.intervals = sorted(intervals.keys())
         current_date = date.today()
+        maintainer_names = {ml.name for ml in maintainer_list}
+        all_statistics = _get_maintainers_statistics(milestone, maintainer_names)
+        # Upgrades per maintainer in each interval, one query per interval
+        interval_upgrades = []
+        for i in (self.intervals if maintainer_names else []):
+            interval_upgrades.append(dict(RecipeUpgrade.objects.filter(
+                    maintainer__name__in=maintainer_names,
+                    commit_date__gte=intervals[i]['start_date'],
+                    commit_date__lte=intervals[i]['end_date']).values_list(
+                    'maintainer__name').annotate(Count('id')).order_by()))
         for ml in maintainer_list:
-            milestone_statistics = _get_milestone_statistics(milestone, ml.name)
+            milestone_statistics = all_statistics[ml.name]
             ml.recipes_all = milestone_statistics['all']
             ml.recipes_up_to_date = ('' if milestone_statistics['up_to_date'] == 0
                     else milestone_statistics['up_to_date'])
@@ -901,9 +973,7 @@ class MaintainerListView(ListView):
                 if current_date >= start_date and current_date <= end_date:
                     self.current_interval = idx
 
-                number = RecipeUpgrade.objects.filter(maintainer__name = ml.name,
-                        commit_date__gte = start_date,
-                        commit_date__lte = end_date).count()
+                number = interval_upgrades[idx].get(ml.name, 0)
                 ml.interval_statistics.append('' if number == 0 else number)
 
         # To add Wk prefix after get statics to avoid sorting problems
diff --git a/tests/rrs/test_maintainers.py b/tests/rrs/test_maintainers.py
new file mode 100644
index 0000000..ace1458
--- /dev/null
+++ b/tests/rrs/test_maintainers.py
@@ -0,0 +1,94 @@
+# layerindex-web - tests for the RRS maintainers page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# The maintainers page shows each maintainer's recipe statistics and upgrades
+# per week, and must get them without running queries per maintainer.
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
+    RecipeUpstream,
+    RecipeUpstreamHistory,
+)
+
+URL = '/rrs/maintainers/OE-Core/6.2/M1/'
+# USE_TZ is False
+UPGRADE_DATE = datetime.datetime(2026, 11, 1)
+
+
+def histories(layerbranch):
+    author, _ = Maintainer.objects.get_or_create(name='No maintainer')
+    maintainer_history = RecipeMaintainerHistory.objects.create(
+        title='Update maintainers', date=datetime.datetime(2026, 10, 15), author=author,
+        sha1='0' * 40, layerbranch=layerbranch)
+    upstream_history = RecipeUpstreamHistory.objects.create(
+        layerbranch=layerbranch, start_date=datetime.datetime(2026, 10, 20),
+        end_date=datetime.datetime(2026, 10, 20, 1))
+    return maintainer_history, upstream_history
+
+
+def add_recipe(layerbranch, history, pn, maintainer_name, status, no_update_reason=''):
+    """A recipe maintained by maintainer_name, with an upstream status and one upgrade"""
+    maintainer_history, upstream_history = history
+    maintainer, _ = Maintainer.objects.get_or_create(name=maintainer_name)
+    symbol = RecipeSymbol.objects.create(layerbranch=layerbranch, pn=pn, summary=pn)
+    RecipeMaintainer.objects.create(recipesymbol=symbol, maintainer=maintainer,
+                                    history=maintainer_history)
+    RecipeUpstream.objects.create(recipesymbol=symbol, history=upstream_history, version='2.0',
+                                  type='A', status=status, no_update_reason=no_update_reason,
+                                  date=upstream_history.end_date)
+    RecipeUpgrade.objects.create(recipesymbol=symbol, maintainer=maintainer, version='1.0',
+                                 author_date=UPGRADE_DATE, commit_date=UPGRADE_DATE,
+                                 upgrade_type='U')
+
+
+def maintainer_list(client):
+    response = client.get(URL)
+    assert response.status_code == 200
+    return {ml.name: ml for ml in response.context['maintainer_list']}
+
+
+def test_statistics(client, rrs_plan):
+    history = histories(rrs_plan.layerbranch)
+    add_recipe(rrs_plan.layerbranch, history, 'busybox', 'Alice', 'Y')
+    add_recipe(rrs_plan.layerbranch, history, 'zlib', 'Alice', 'N')
+    add_recipe(rrs_plan.layerbranch, history, 'gcc', 'Bob', 'N', 'Needs a newer binutils')
+
+    maintainers = maintainer_list(client)
+
+    alice, bob = maintainers['Alice'], maintainers['Bob']
+    assert (alice.recipes_all, alice.recipes_up_to_date, alice.recipes_not_updated,
+            alice.recipes_cant_be_updated, alice.percentage_done) == (2, 1, 1, '', '50%')
+    assert (bob.recipes_all, bob.recipes_up_to_date, bob.recipes_cant_be_updated,
+            bob.percentage_done) == (1, '', 1, '0%')
+    # One upgrade each, in the week of UPGRADE_DATE
+    assert [n for n in alice.interval_statistics if n] == [2]
+    assert [n for n in bob.interval_statistics if n] == [1]
+    assert alice.interval_statistics.index(2) == bob.interval_statistics.index(1)
+
+
+def test_queries_do_not_grow_with_maintainers(client, rrs_plan):
+    history = histories(rrs_plan.layerbranch)
+    # All 'N', so the plan-wide statistics take the same path both times
+    add_recipe(rrs_plan.layerbranch, history, 'recipe-0', 'Maintainer 0', 'N')
+    maintainer_list(client)  # fills the per-process caches first
+    with CaptureQueriesContext(connection) as one:
+        assert 'Maintainer 0' in maintainer_list(client)
+    for i in range(1, 6):
+        add_recipe(rrs_plan.layerbranch, history, f'recipe-{i}', f'Maintainer {i}', 'N')
+    with CaptureQueriesContext(connection) as six:
+        assert len(maintainer_list(client)) == 6
+    assert len(six) == len(one)
-- 
2.56.1

