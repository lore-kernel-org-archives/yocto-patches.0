Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD857CD37AF
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 00:47:31 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22355.1778374050177293899
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 May 2026 17:47:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CTvef6wm;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-366330b6751so1869785a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374049; x=1778978849; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US3J4gVDpCzawGPgdoHUZTsWJlUDN8GoAGwu6RyYxsk=;
        b=CTvef6wmh/hxB+5DB4So0HASdwFHGBQ/1igYsfDlXwiSupzodHnASWCoaF898gXrIo
         aWszZd99RTN+kT0dU1D8u5JVtA41O7FAXJ+WErXLVQ5XAn/MLHRCV7cvQpTolMXE4R2U
         ybOUFZegsGF8i1ZYHC0y/ZofjrQ1sIU/LIrBNCVhQIVgFvOaZuN/wJdMcSWcLfHcNcMD
         /sq3au8U5Yg8SFEMOwQOJ39msLL3Ck8z+plRZLRoQojYLPft5Q2tfH6jzATqP+iT2aJA
         XzISZAlDjT7QttXfygNciim9HS9M/CpYOC6BgnNrr965OCKe0FxdrWAaorWXLs/UhHjF
         E66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374049; x=1778978849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=US3J4gVDpCzawGPgdoHUZTsWJlUDN8GoAGwu6RyYxsk=;
        b=ivZo3nq6yZ1fd7O8TcsSnpDJsTcFKDmq05YZNLKFvFVvzGYaYbXgh9V8I02pcJkSXJ
         ck9Mnts0cRKGRx0XiAW8iQSu1GFimw+ndp62DYTr01UoEVitoRnSdRSTxs4z5UWyCfCI
         fK17BBf7T+eN+yFR6KfmBlG/vV8aa0i5kip4pOSNjTgSftWpbpF+mOJ0zHtU9y+0rdc0
         P8ZQF3TbNDIXs1wa6Dv8gdAqQpOyRE7YESgzuMlU9BpMX5wZMTXqq+mvlBsk9DIoC57/
         Oro9HBnVqgxmCDQ9ypnyU1u40R6jXNxSritE8lnRmDbmLQtXPBtsBkvAynNPv/t23Bum
         /a2g==
X-Gm-Message-State: AOJu0YzPAc6tsi3HSQC8/8xgcsH1U4n9Tsloxy4CTyYlGLQT7NbH1oXL
	BihaEDxQhTUZ9Qa7ysRXPW+K6wnpqYokCE7sWQ6HvQYHvar1UqlAVJPylexOObb3
X-Gm-Gg: Acq92OGOYMCTaMcJBNqwSdEoPHXGvSr3dVH8bccDr5NrKq//huI/tcYr7ngd9gd42h5
	ptIovcei+NYu+4esX8zrrbzQKll9J9kzqHXiKnaQ0D60XmIME6TvAEWbXZWzabg34VNdhINptoG
	/DFUAr2nn/oTvUX3Eeg8fq9mceK9+lKXvjRECAsYwe5vNUzqnGZH6M1PYteI7NhElNUIagVeEhS
	IpLDDdwvviUHMf68T1syjnFfCG7RpV6VANLtuZKrocQaC6T+lnz6m3sN7vL69JOQ0P62mXh36MB
	bINzEu00Vgq/xYBfrmYBdsHVUkUnPHSmR7Fd0Y6JKqoyTJdwCmwpfRXG82YkUrD1A3geFRpmr5p
	DCwOVn7+dBlsAJT1250bwgcSGeJKbTLH6kP1RucF0Qhs6Dr95q6nMAlEdPP3GcGR+LBf4NGuLHb
	ZEroioiKtKbDBw3CEdNT9yjAikb6KnMoGojh7t+2DK53K65+9I1BeUOycWPHhT5VopmYYHoG4Kd
	jT4dtiUEBhLX2x29ycuE0s=
X-Received: by 2002:a17:90b:1c8b:b0:35b:e4f8:7b2b with SMTP id 98e67ed59e1d1-365abe8a3d0mr20860800a91.18.1778374048938;
        Sat, 09 May 2026 17:47:28 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm3178257a91.7.2026.05.09.17.47.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 17:47:28 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/5] tests: add StatsView tests
Date: Sat,  9 May 2026 17:47:00 -0700
Message-ID: <20260510004706.81282-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510004706.81282-1-tim.orling@konsulko.com>
References: <20260510004706.81282-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 00:47:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3959

Add test_stats_view.py covering the StatsView statistics page:

- HTTP 200 response
- perbranch context is a list of dicts (not a queryset)
- hidden branches are excluded
- branches are sorted by sort_priority
- each dict contains all keys the template requires
- per-branch counts match test fixture data
- updates_enabled is correctly reflected per branch
- overall context keys (layercount, *_count_distinct) are present

[YOCTO #15391]

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 tests/test_stats_view.py | 164 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 tests/test_stats_view.py

diff --git a/tests/test_stats_view.py b/tests/test_stats_view.py
new file mode 100644
index 0000000..c30cc17
--- /dev/null
+++ b/tests/test_stats_view.py
@@ -0,0 +1,164 @@
+# layerindex-web - tests for StatsView
+#
+# Copyright (C) 2026 Konsulko Group
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+# Tests for bug #15391 - Statistics page timeout
+# https://bugzilla.yoctoproject.org/show_bug.cgi?id=15391
+#
+# The fix replaces a single annotated queryset (which generated one huge SQL
+# query with multiple COUNT(DISTINCT ...) JOINs) with per-branch individual
+# COUNT queries that are much cheaper at production data volumes.
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+from layerindex.models import (Branch, LayerItem, LayerBranch, Recipe,
+                                BBClass, Machine, Distro)
+
+
+@pytest.mark.django_db
+class TestStatsView(TestCase):
+    """Tests for StatsView (bug #15391 - statistics page timeout fix)."""
+
+    def setUp(self):
+        # Create two visible branches with different sort priorities
+        self.branch1 = Branch.objects.create(
+            name='main',
+            bitbake_branch='master',
+            short_description='Main branch',
+            sort_priority=1,
+            hidden=False,
+            updates_enabled=True,
+        )
+        self.branch2 = Branch.objects.create(
+            name='wrynose',
+            bitbake_branch='2.18',
+            short_description='Wrynose branch',
+            sort_priority=2,
+            hidden=False,
+            updates_enabled=False,
+        )
+        # A hidden branch that should never appear in perbranch
+        self.branch_hidden = Branch.objects.create(
+            name='old-hidden',
+            bitbake_branch='1.0',
+            short_description='Old hidden branch',
+            sort_priority=99,
+            hidden=True,
+            updates_enabled=False,
+        )
+
+        # A layer
+        self.layer = LayerItem.objects.create(
+            name='meta-test',
+            status='P',
+            layer_type='A',
+            summary='Test layer',
+            description='A test layer',
+            vcs_url='git://example.com/meta-test.git',
+        )
+
+        # Wire up layerbranches
+        self.lb1 = LayerBranch.objects.create(layer=self.layer, branch=self.branch1)
+        self.lb2 = LayerBranch.objects.create(layer=self.layer, branch=self.branch2)
+
+        # Add objects only to branch1
+        Recipe.objects.create(
+            layerbranch=self.lb1,
+            filename='test_1.0.bb',
+            pn='test',
+            pv='1.0',
+            filepath='recipes-test',
+        )
+        BBClass.objects.create(
+            layerbranch=self.lb1,
+            name='testclass',
+        )
+        Machine.objects.create(
+            layerbranch=self.lb1,
+            name='qemux86',
+            description='QEMU x86 machine',
+        )
+        Distro.objects.create(
+            layerbranch=self.lb1,
+            name='testdistro',
+            description='Test distro',
+        )
+
+    def test_stats_view_returns_200(self):
+        """StatsView should return HTTP 200."""
+        response = self.client.get(reverse('stats'))
+        self.assertEqual(response.status_code, 200)
+
+    def test_perbranch_is_list_of_dicts(self):
+        """perbranch context should be a list of dicts, not a queryset."""
+        response = self.client.get(reverse('stats'))
+        perbranch = response.context['perbranch']
+        self.assertIsInstance(perbranch, list)
+        for item in perbranch:
+            self.assertIsInstance(item, dict)
+
+    def test_perbranch_excludes_hidden_branches(self):
+        """Hidden branches should not appear in perbranch."""
+        response = self.client.get(reverse('stats'))
+        names = [b['name'] for b in response.context['perbranch']]
+        self.assertIn('main', names)
+        self.assertIn('wrynose', names)
+        self.assertNotIn('old-hidden', names)
+
+    def test_perbranch_sorted_by_priority(self):
+        """Branches should be ordered by sort_priority."""
+        response = self.client.get(reverse('stats'))
+        names = [b['name'] for b in response.context['perbranch']]
+        self.assertEqual(names, ['master', 'main', 'wrynose'])
+
+    def test_perbranch_dict_has_required_keys(self):
+        """Each perbranch dict must contain all keys the template expects."""
+        required_keys = {'name', 'updates_enabled', 'layer_count',
+                         'recipe_count', 'class_count', 'machine_count', 'distro_count'}
+        response = self.client.get(reverse('stats'))
+        for item in response.context['perbranch']:
+            self.assertTrue(required_keys.issubset(item.keys()),
+                            f"Missing keys in perbranch item: {required_keys - item.keys()}")
+
+    def test_perbranch_counts_branch1(self):
+        """Per-branch counts for branch1 should reflect the test data."""
+        response = self.client.get(reverse('stats'))
+        branch1_data = next(b for b in response.context['perbranch'] if b['name'] == 'main')
+        self.assertEqual(branch1_data['layer_count'], 1)
+        self.assertEqual(branch1_data['recipe_count'], 1)
+        self.assertEqual(branch1_data['class_count'], 1)
+        self.assertEqual(branch1_data['machine_count'], 1)
+        self.assertEqual(branch1_data['distro_count'], 1)
+    
+    def test_perbranch_counts_branch2_empty(self):
+        """Branch2 has a layerbranch but no recipes/classes/machines/distros."""
+        response = self.client.get(reverse('stats'))
+        branch2_data = next(b for b in response.context['perbranch'] if b['name'] == 'wrynose')
+        self.assertEqual(branch2_data['layer_count'], 1)
+        self.assertEqual(branch2_data['recipe_count'], 0)
+        self.assertEqual(branch2_data['class_count'], 0)
+        self.assertEqual(branch2_data['machine_count'], 0)
+        self.assertEqual(branch2_data['distro_count'], 0)
+
+    def test_perbranch_updates_enabled_field(self):
+        """updates_enabled should be correctly reflected per branch."""
+        response = self.client.get(reverse('stats'))
+        perbranch = response.context['perbranch']
+        b1 = next(b for b in perbranch if b['name'] == 'main')
+        b2 = next(b for b in perbranch if b['name'] == 'wrynose')
+        self.assertTrue(b1['updates_enabled'])
+        self.assertFalse(b2['updates_enabled'])
+
+    def test_overall_context_keys_present(self):
+        """Overall statistics context keys should all be present."""
+        response = self.client.get(reverse('stats'))
+        for key in ('layercount', 'recipe_count_distinct', 'class_count_distinct',
+                    'machine_count_distinct', 'distro_count_distinct'):
+            self.assertIn(key, response.context,
+                          f"Missing context key: {key}")
-- 
2.54.0


