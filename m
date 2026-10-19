Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5865.1792445725757654947
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 14:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gv24MTCY;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06c60065fso964874b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445725; x=1793050525; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t50t8m8INy93F4pg5Wr++Bl+EN8ToRBd6SBMm9clHis=;
        b=gv24MTCYnnn7qCaPbtxwn19dNpHXhRhc/sbNtkIBTn2tPiNxCTB3U0jTQ9aXMRMjAA
         6IFvZXt7649Wl1oifw5sS6W5Asx/MYxZFYkU/0ie0l/vw+BhVPv9zkT6r8iH6nwwqPiS
         24wZtjvpuQPxZtRX3T8c6DRmhwNLYvBHlqYxIi4PqakKDoVmQvKlLvMpUG2usxufeRuA
         KZlk7jy9u9gvFfZUaYgdfhAh7zHYxXgqoudTBLm7MxQqNNlsr6NVgh833nm9y8Okw/vn
         DVXWCH3WdxvL7zxKPN1h3K+EL5HeEib8K/nilnVxlqwv0mLIgGL+JF8/Icz1HpC94sPa
         7d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445725; x=1793050525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t50t8m8INy93F4pg5Wr++Bl+EN8ToRBd6SBMm9clHis=;
        b=1YikZdHH8klx3MMvHp20P2ZZmuFcf+PYlnj5PGwsLKVRx9B60IztLP2hGhcZubLMBY
         +Z4SrFwLcxR7OR2vobIbKDd2wnPrQ+676V4WLeb23EAew//SEJzTwi0Fr3+EvNMocYJc
         G8fsn293FgYCzgc+4jrSjCrOHBW+wQCQ0sR6cMumQQIhTTUjEvfsiM7KFKX+h2/+bOXE
         g5lbdx1mbxqNOdU07Jno2Z8ePzSJ6fgd9+L/2Tc52XPWtpI++A8B71LIGQScKBG9A7DY
         uOn0aa7pDVBL0gjrZg0Cx8FZyrqEiTXSjld+I9OgVKUO0pbI3/SgAhKtIzfI1tsYm76Y
         I5RQ==
X-Gm-Message-State: AFq9FYLmMrmAqI91hwb7yDMHA4TJ0LpNqh/9viAWWSHkPxfRqTNq/Eyt
	Vq1jg4k2WMLn4KrURSPTkDl3A6cK1pzVcdwafj2FlnQIoLIMh9Tn2VUMsek+/7fH
X-Gm-Gg: AYBFou2bgYCl+3vSG2mIuIAfh/IDjqa00fvimm6xPG6uUjFjkrP/kw15WQ7QGHGKrJi
	ys3lIDJkXAqqGL05Or+3xlRLAGWTimg+wECplktjZ5RIkEWXrpVbWeO2gXfAzqmRBLug2b10R8E
	o6wBnOSM3l05JKNGWCgd10xRms7anYOL+wqmNAlX8wlkfEViIh928kGrx0kHHsy8UgiM8TPEPKP
	/vJchlfuGgR8DZVm/IFmfjlUHQAHeVKITyi3DYR8LoIxSecyzJWUlH89L2AjE6na4O9p04WIBPu
	zwX67fSfhXGjpD78xY8HP5o3ddNvIeJ9Gh7RTBxBm0kBYYPEgp3FJkDWMhPWqIdmGqkLW9g9gO5
	S/cbB2kbHPG9r4OWclnw87mQmZNIhTr5HYxBJq780WVEFGyJe4StRFLYI+IA5oocnVhUn00/heA
	4oIr8LqRyPve4eJ5igODkz6otXmgFFLOw5ctOOjjzx9Jvp3YvTFgMvfW6voVboqQMXZnoPhfPzK
	apCQsXvwAnRPywbK+eFHP+M/br+Zbs=
X-Received: by 2002:a05:6a00:4106:b0:89e:5133:d98b with SMTP id d2e1a72fcca58-8a04ba22ddamr6806314b3a.24.1792445724987;
        Mon, 19 Oct 2026 14:35:24 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm4307747b3a.53.2026.10.19.14.35.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 14:35:23 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] update: copy a new layer branch's subdirectory from the newest branch
Date: Mon, 19 Oct 2026 14:35:08 -0700
Message-ID: <20261019213510.4384-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213510.4384-1-tim.orling@konsulko.com>
References: <20261019213510.4384-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 21:35:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5102
Content-Type: text/plain; charset="utf-8"

When a layer is first found on a new branch, vcs_subdir was copied from
get_layerbranch(None), an arbitrary and usually the oldest layer branch.
meta-tq has since moved into a subdirectory, so its wrynose update
failed with "conf/layer.conf not found". Copy it from the newest
non-comparison branch instead.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/models.py             |  9 ++++++
 layerindex/update.py             |  2 +-
 layerindex/update_layer.py       |  2 +-
 tests/test_latest_layerbranch.py | 52 ++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_latest_layerbranch.py

diff --git a/layerindex/models.py b/layerindex/models.py
index a72a72b..a9e9bdf 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -162,6 +162,15 @@ class LayerItem(models.Model):
             return res[0]
         return None
 
+    def get_latest_layerbranch(self):
+        """
+        Return the layer branch for the newest non-comparison branch (by
+        branch sort priority), e.g. to copy settings such as vcs_subdir from
+        when the layer is first seen on a new branch.
+        """
+        return self.layerbranch_set.filter(branch__comparison=False).order_by(
+            models.F('branch__sort_priority').asc(nulls_last=True), '-id').first()
+
     def active_maintainers(self):
         matches = None
         for layerbranch in self.layerbranch_set.all():
diff --git a/layerindex/update.py b/layerindex/update.py
index dd730ca..ca68e3e 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -389,7 +389,7 @@ def main():
                         layerbranch.branch = branchobj
                         layerbranch_source = layer.get_layerbranch(branchobj)
                         if not layerbranch_source:
-                            layerbranch_source = layer.get_layerbranch(None)
+                            layerbranch_source = layer.get_latest_layerbranch()
                         if layerbranch_source:
                             layerbranch.vcs_subdir = layerbranch_source.vcs_subdir
 
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 441efc2..0f49371 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -380,7 +380,7 @@ def main():
                     layerbranch.actual_branch = options.actual_branch
                 layerbranch_source = layer.get_layerbranch(branch)
                 if not layerbranch_source:
-                    layerbranch_source = layer.get_layerbranch(None)
+                    layerbranch_source = layer.get_latest_layerbranch()
                 if layerbranch_source:
                     layerbranch.vcs_subdir = layerbranch_source.vcs_subdir
                 layerbranch.save()
diff --git a/tests/test_latest_layerbranch.py b/tests/test_latest_layerbranch.py
new file mode 100644
index 0000000..33e0844
--- /dev/null
+++ b/tests/test_latest_layerbranch.py
@@ -0,0 +1,52 @@
+# layerindex-web - tests for choosing the layer branch to copy settings from
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+
+from layerindex.models import Branch, LayerBranch, LayerItem
+
+
+@pytest.mark.django_db
+class TestLatestLayerBranch(TestCase):
+    """When a layer is first seen on a new branch, the update script copies
+    vcs_subdir from an existing layer branch. It must use the newest branch:
+    meta-tq moved into a meta-tq/ subdirectory, and copying the empty
+    subdirectory of an old branch made the new branch's update fail with
+    "conf/layer.conf not found"."""
+
+    def setUp(self):
+        self.layer = LayerItem.objects.create(name='meta-tq', status='P', layer_type='B',
+                                              summary='test', description='test',
+                                              vcs_url='https://example.com/meta-tq.git')
+
+    def branch(self, name, sort_priority, comparison=False):
+        return Branch.objects.create(name=name, bitbake_branch=name, sort_priority=sort_priority,
+                                     comparison=comparison)
+
+    def layerbranch(self, branch, subdir):
+        return LayerBranch.objects.create(layer=self.layer, branch=branch, vcs_subdir=subdir)
+
+    def test_newest_branch_wins_over_oldest_record(self):
+        # Oldest branch first, so it is the first record (as for meta-tq)
+        self.layerbranch(self.branch('krogoth', 20), '')
+        self.layerbranch(self.branch('kirkstone', 5), 'meta-tq')
+        newest = self.layerbranch(self.branch('scarthgap', 3), 'meta-tq')
+        self.assertEqual(self.layer.get_latest_layerbranch(), newest)
+        self.assertEqual(self.layer.get_latest_layerbranch().vcs_subdir, 'meta-tq')
+
+    def test_comparison_and_unprioritised_branches_are_not_preferred(self):
+        self.layerbranch(self.branch('comparison', 1, comparison=True), 'other')
+        self.layerbranch(self.branch('unsorted', None), 'other')
+        newest = self.layerbranch(self.branch('scarthgap', 3), 'meta-tq')
+        self.assertEqual(self.layer.get_latest_layerbranch(), newest)
+
+    def test_only_unprioritised_branches(self):
+        lb = self.layerbranch(self.branch('unsorted', None), 'meta-tq')
+        self.assertEqual(self.layer.get_latest_layerbranch(), lb)
+
+    def test_no_layer_branches(self):
+        self.assertIsNone(self.layer.get_latest_layerbranch())
-- 
2.56.0

