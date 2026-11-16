Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5214.1794867870694909690
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:24:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=RrnYdfqe;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2eb18f4da15so17292675ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794867870; x=1795472670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/46wrWFS3+/RL98Qk2K/MpXBPO2/wX7WoTjtR+1X9U=;
        b=RrnYdfqePzeAev5hhjwtMzNKp/Ab29N+xSpCUyWjhtI/JIh2VvETP13vObX0/jS66B
         2gvSdOj1I6fmdPyJx9j7KzAyw5XUqF/ICHQcENGCZXX+q4o4zW1L0CfRrU728qU0rWLP
         GvbTHBGN1gKINVAREbBrKMU3yfLzqyXfA+Tqh0vbINUTwn7KgziF+Ajv3YoEMa+OaMni
         afRy1ewDjZome6p/NypAv6f9kc3X1ixAkXJP0hGLN+ACZ4gyiNbzNlNeWPcDFfzy6ICA
         eoqoNyFKZiIiJEyTTBkPgp5RXQhsyVuRhRZub10kIW7/hKTgRIG9aVnTeOLRVM9AqjyR
         ff/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867870; x=1795472670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S/46wrWFS3+/RL98Qk2K/MpXBPO2/wX7WoTjtR+1X9U=;
        b=BnlNEV7soCaybdRIVtZYW8Zh9+T/xhsQxeNmml7M/uKtGCzm2X8VNXzCKLmwXZ1kzN
         ZkWWL1xMqC2VKYF658Tt2vxzf6gPxupLzPLkIVgPYjFrhmzbqjBVvRZvStOZYT9j8L6t
         WDgdhd/W12tLZjYBnbLjnUOGKcxPAg30ghmnh0YGDYxzfOuR9Mae0QvmqfazfBupi5M3
         4OESU4GNQSA1VrwxNqfxez5OwK+x7ayM71aaWA6LrHub3t1i+GLx0VsD93V84C0+WDJX
         7MP8u2147bmjyoH1SoauYL7u2sJruzkX1Oo4Dd9+YZgxADhtFHjmX81Y4P6VELnVO1+b
         oFmQ==
X-Gm-Message-State: APuU4Z+LNeLnTQ2/2uCT3N10ubx56w/U5h5iuyZjICXiRIkXlHW9PVi4
	/K27/69Dnb9XGcKN0h2ZbrWHoDv7E/5Jz++cBxa5DnxHGqFFoRRIsnSik1k9YQ==
X-Gm-Gg: AZFdTZfLEzW95gip/5txd0ANyCCAfeYGjGoNzfQ0ivZutO0Kx64pF3eqkPC0ZDHDzWH
	CTQWAK4exzs7V31dRvBDWOo21TSEK7+OzJBcnh8m1B/liKc70pJX9nl868u9E68xaJw/zbZvXzV
	soWDxEOhDKl4GXPSu6yzw8R4X6X14HxFo+ZOSsiIxBVskDHLPaWRfrUN5S2PcH81AlxU/dSXDNK
	57ozFXIxmYVl6hhFFb9Ks//WeOUYuqO/z2S7kVy3ro8+IGYZUVL7SK82Wxvy/8STuXbdRAXDbeB
	2teQRgj3ySv+lwlNV0BmBaDJ0UsIGATVv9fM4MOAt4tcIqHTUDnfHxefNcLH2CFT7+3ykyGusVY
	qIlIqUm7fi+k9piyJWLyMNtw09S9LUdt+22tZdt5FoXKiS6fLf2satJ/hfjnXLFfeHQiwIkW/r/
	2MhSNbb8OPP5MJo70DEWrQmAxZ5WarHbtYkEbAqMtdO6GDsrx24QefC9iVwv6Y1l6m+LGwky4IN
	GAf4NgapelXgWkGChvT8mMNBe+m7SLMoa2DBRgxdubtn8S4zbg0zNEgzL3Ln9Xil7nP/bNwwzYG
	RxV4yZRMUD1lXGOqPDfbb5JlAOhclc4PkXULekK5JXfmnyk+RLc7eRO7/Q+T8w==
X-Received: by 2002:a17:903:458d:b0:2dd:ad73:5b6d with SMTP id d9443c01a7336-2ee0dcd040cmr105815845ad.29.1794867869983;
        Mon, 16 Nov 2026 14:24:29 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7ab4abcsm4618945ad.70.2026.11.16.14.24.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 14:24:29 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] rrs/views.py: fetch the recipe list's patch counts in a few queries
Date: Mon, 16 Nov 2026 14:24:08 -0800
Message-ID: <20261116222410.35784-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116222410.35784-1-tim.orling@konsulko.com>
References: <20261116222410.35784-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:24:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5431
Content-Type: text/plain; charset="utf-8"

_get_recipe_list() ran five queries per recipe, so the recipes and report
pages took about 4 s for OE-Core and 9 s for meta-openembedded, with the
database busy for under 0.5 s of that. Fetch the recipe symbols with
in_bulk() and the patch counts with one annotated query per layer branch,
counting the same recipe as before when several share a pn.

On a copy of the production database the recipe lists of 12 milestones
are identical before and after, and OE-Core 6.2 takes 9 queries and
0.12 s instead of 4880 queries and 3.7 s.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/views.py                  | 30 ++++++++++-----
 tests/rrs/test_recipe_list.py | 71 +++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 9 deletions(-)
 create mode 100644 tests/rrs/test_recipe_list.py

diff --git a/rrs/views.py b/rrs/views.py
index b2520ce..b580818 100644
--- a/rrs/views.py
+++ b/rrs/views.py
@@ -17,6 +17,7 @@ from django.shortcuts import get_object_or_404
 from django.views.generic import TemplateView, ListView, DetailView, RedirectView
 from django.urls import resolve, reverse, reverse_lazy
 from django.db import connection
+from django.db.models import Count, Q
 from django.contrib import messages
 
 from layerindex.models import Recipe, StaticBuildDep, Patch
@@ -432,12 +433,29 @@ def _get_recipe_list(milestone):
                 for ma in maintainers_all:
                     maintainers_dict_all[ma['recipesymbol_id']] = ma['name']
 
+        # Fetch the recipe symbols, and the patch counts of their layer index
+        # recipes, in a few queries rather than several per recipe
+        # (AI-generated, Claude Opus 5.5)
+        recipesymbols = RecipeSymbol.objects.in_bulk([recipe['id'] for recipe in recipes])
+        patch_counts = {}
+        if recipesymbols:
+            recipeobjs = Recipe.objects.filter(
+                    layerbranch_id__in={rs.layerbranch_id for rs in recipesymbols.values()},
+                    pn__in={rs.pn for rs in recipesymbols.values()}) \
+                .order_by('id') \
+                .annotate(patches_total=Count('patch'),
+                          patches_pending=Count('patch', filter=Q(patch__status='P')))
+            for recipeobj in recipeobjs:
+                # Keep the first recipe by id for a pn, as .first() did
+                patch_counts.setdefault((recipeobj.layerbranch_id, recipeobj.pn),
+                                        (recipeobj.patches_total, recipeobj.patches_pending))
+
         for recipe in recipes:
             upstream_version = ''
             upstream_status = ''
             no_update_reason = ''
             outdated = ''
-            recipesymbol = RecipeSymbol.objects.filter(id=recipe['id']).first()
+            recipesymbol = recipesymbols.get(recipe['id'])
 
             if recipe_upstream_history:
                 recipe_upstream = recipe_upstream_dict_all.get(recipe['id'])
@@ -479,14 +497,8 @@ def _get_recipe_list(milestone):
             recipe_list_item.upstream_status = upstream_status
             recipe_list_item.upstream_version = upstream_version
             recipe_list_item.outdated = outdated
-            recipeobj = recipesymbol.layerbranch.recipe_set.filter(pn=recipesymbol.pn, layerbranch=recipesymbol.layerbranch).first()
-            if recipeobj:
-                patches = recipeobj.patch_set
-                recipe_list_item.patches_total = patches.count()
-                recipe_list_item.patches_pending = patches.filter(status='P').count()
-            else:
-                recipe_list_item.patches_total = 0
-                recipe_list_item.patches_pending = 0
+            recipe_list_item.patches_total, recipe_list_item.patches_pending = \
+                patch_counts.get((recipesymbol.layerbranch_id, recipesymbol.pn), (0, 0))
             recipe_list_item.maintainer_name = maintainer_name
             recipe_list_item.no_update_reason = no_update_reason
             recipe_list.append(recipe_list_item)
diff --git a/tests/rrs/test_recipe_list.py b/tests/rrs/test_recipe_list.py
new file mode 100644
index 0000000..95b2595
--- /dev/null
+++ b/tests/rrs/test_recipe_list.py
@@ -0,0 +1,71 @@
+# layerindex-web - tests for the RRS recipe list
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# The recipe list shows each recipe's patch counts, and must get them without
+# running queries per recipe.
+
+import datetime
+
+from django.db import connection
+from django.test.utils import CaptureQueriesContext
+
+from layerindex.models import Patch, Recipe
+from rrs.models import RecipeSymbol, RecipeUpgrade
+
+URL = '/rrs/recipes/OE-Core/6.2/M1/'
+
+
+def add_recipe(layerbranch, pn, patch_statuses=(), recipe=True):
+    """A recipe that RRS lists for the milestone, with patches of the given statuses"""
+    symbol = RecipeSymbol.objects.create(layerbranch=layerbranch, pn=pn, summary=pn)
+    date = datetime.datetime(2026, 11, 1)  # USE_TZ is False
+    RecipeUpgrade.objects.create(recipesymbol=symbol, version='1.0', author_date=date,
+                                 commit_date=date, upgrade_type='U')
+    if recipe:
+        obj = Recipe.objects.create(layerbranch=layerbranch, filename=f'{pn}_1.0.bb',
+                                    filepath='recipes', pn=pn, pv='1.0')
+        for i, status in enumerate(patch_statuses):
+            Patch.objects.create(recipe=obj, path=f'{pn}-{i}.patch',
+                                 src_path=f'{pn}-{i}.patch', status=status)
+    return symbol
+
+
+def recipe_list(client):
+    response = client.get(URL)
+    assert response.status_code == 200
+    return {item.name: item for item in response.context['recipe_list']}
+
+
+def test_patch_counts(client, rrs_plan):
+    layerbranch = rrs_plan.layerbranch
+    add_recipe(layerbranch, 'busybox', ['P', 'P', 'A'])
+    add_recipe(layerbranch, 'zlib', [])
+    add_recipe(layerbranch, 'norecipe', recipe=False)
+    # A second recipe with the same pn: the first one by id is counted
+    add_recipe(layerbranch, 'gcc', ['P'])
+    later = Recipe.objects.create(layerbranch=layerbranch, filename='gcc_2.0.bb',
+                                  filepath='recipes', pn='gcc', pv='2.0')
+    Patch.objects.create(recipe=later, path='x.patch', src_path='x.patch', status='P')
+    Patch.objects.create(recipe=later, path='y.patch', src_path='y.patch', status='P')
+
+    counts = {name: (item.patches_total, item.patches_pending)
+              for name, item in recipe_list(client).items()}
+
+    assert counts == {'busybox': (3, 2), 'zlib': (0, 0), 'norecipe': (0, 0), 'gcc': (1, 1)}
+
+
+def test_queries_do_not_grow_with_recipes(client, rrs_plan):
+    add_recipe(rrs_plan.layerbranch, 'recipe-0', ['P'])
+    recipe_list(client)  # fills the per-process caches first
+    with CaptureQueriesContext(connection) as one:
+        assert len(recipe_list(client)) == 1
+    for i in range(1, 6):
+        add_recipe(rrs_plan.layerbranch, f'recipe-{i}', ['P'])
+    with CaptureQueriesContext(connection) as six:
+        assert len(recipe_list(client)) == 6
+    assert len(six) == len(one)
-- 
2.56.1

