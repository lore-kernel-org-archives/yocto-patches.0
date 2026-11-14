Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6737.1794638592390271522
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 22:43:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=s+6r2Taf;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso1609518a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 22:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794638592; x=1795243392; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM8GEJW9tQy0Dvvy+kGO5hUsQQyp1fNq2CUWYLNetqI=;
        b=s+6r2Taf8toHVrECEbrOU/RlsdEo8rt8JIWYJS6PuDdUDsspsnGlgL/3IAmBmhgnsH
         oX7rJqQrDyWYyvpyDeb10Yp+JaqOKdTSVUA5dkRgd6YD9AcQjauWBVYDjfF5fz52Jzdb
         m7WqLGneLXun2w4Ko9mZRIKG/Zlf2bgxrof/wpn3N/iEPDNGhCo8elFUkkyWENVGN+ya
         7bS59c4aeoH+eGTeDzE+1QWXm5kKmHcw4SV7IaO014X6/+5hRXQquIWorA3mwTfDoE8I
         PsWNaXtq2WFGCr50+II9FZWacuvgLifgik0ppdrekbZOi9zn4/podJSlaGY4A97hGa53
         ImMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794638592; x=1795243392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM8GEJW9tQy0Dvvy+kGO5hUsQQyp1fNq2CUWYLNetqI=;
        b=KZ9RX9SdqPvGPCUdfcWz+puoDnQEWWIMhaYv+M3ny8I1f8a+Tj6ZoIqhCkOWmbUHQO
         ysXDjg8Lkd9DHgrHurqRPm67zpc87ECVuIsZH7Kwxo/28QQYG5sS2QoUeitmM+DINsxt
         7fA+CqRxHJCjg1LqzfAZRfDmpo58GP5izy4ctV0d+clSiSngCJJl+/q+yMJ//oaj2oPK
         iy/jFhVH4hVCT6kjPldaYWWR7WwYPG2ZhePWuQ1DSpJI5odRj7iGwpaiAqSoWto5kEph
         wpgknKQkAob+EnoKb3yeOPxwB3EJ2ipEwxtCrXZa/9/ZhejkDsJ9/sh+1PJA2cD939VR
         dZDQ==
X-Gm-Message-State: APuU4Z8BIbPGiJXK5cAb1cAZrNRMy55ttj4S9ZC9jF1U5uuNzw3VkePG
	mSaZ23LTC014Mid5CzXEJnGUvig1KKa5VzE9Fm4O12jXQnd8dJ3WzDdVE0r0JWwv
X-Gm-Gg: AYBFou1KY6ySsn3NFGCg4hv6AL8W4FMA4cpcKNwAz7K4L6axkFEZZ6wbmP+AT1e20UK
	57w0lnepBhz68jLr259d/ZE6rYSJRUTSqRePZ1vAmKrP0HyNUB/FSNzTbCfuLSVxScLc6X93fFd
	4Sgf+Qo1fJ+CxJ+tPOOco1BGr4Zf8K+YNJPPmIYxmjB0MKumIg4O47rAnlsNQmFNN0Y5FZWAp+O
	LYEicl6MkEiNmHSXRsq2ynPvCk9rEedpXKbELLFNXU72EFmmjel19E9B2cP/MkOh4jUWLpKQ/08
	Y6evMqhSRPQwyr0v2SCS8L90BszVZvwgmuGasIEzVtcnELngJVgT7Y26Yk+vMdPqzK7/2Q6NXdU
	P7kHDPZgmzZkvDWzVuSZjfZCC48P8eW2atox39mgvQWLjV+mcvCMn91MO89cokUhUtbRsHv5VkI
	twP8d0MTBJcZrnu+HhneafWLSQenAvDMXCBxYRpmhCHhtvZVPltSYcYIr6xLQ7Wl6fbePd8nYMf
	qlBbsYukGuIYixHfZ3LCin0Zuh2LGg4gladMJaNiB66Ci/cZRnw+pWFOncQuhFrD4KhjI/UyYvy
	GUxgSL2ucSlnC5iLz0GqPogXbIbXA+3GhxnUXsiyKKHK+xbuToaznqHJiy+xZA==
X-Received: by 2002:a17:90b:4a88:b0:3aa:6b5d:9fe4 with SMTP id 98e67ed59e1d1-3b1b09f37b1mr4369290a91.12.1794638591597;
        Fri, 13 Nov 2026 22:43:11 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm12828568a91.16.2026.11.13.22.43.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 22:43:10 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] update: stop updating layers not compatible with a release branch
Date: Fri, 13 Nov 2026 22:43:04 -0800
Message-ID: <20261114064304.24562-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 06:43:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5373
Content-Type: text/plain; charset="utf-8"

A layer branch kept being updated on a release branch even when the
layer's LAYERSERIES_COMPAT does not include that release, e.g. layers
that still only list thud and warrior on kirkstone and scarthgap. On
release branches, disable updates for such a layer branch and record
why against the layer, as for a layer that has gone from the branch.

On master the core layer is already the next release, which layers
only catch up with over time, so there it is only a warning in the
layer's update log.

[YOCTO #7792]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This applies on top of "[PATCH 0/3] Report problems with the first
parse of a layer" and "[PATCH] update: disable updates for a layer
branch whose layer has gone" (bug 12922), whose helpers it uses, and
on master-next.

It covers the "not compatible" side of the bug; showing a layer as
compatible with other releases it lists is not part of it.

On a test instance loaded with a copy of the layers.openembedded.org
database, a dry run on scarthgap reported meta-agl-core (wrynose only)
and meta-openstack-compute-deploy, -controller-deploy and -qemu (thud
warrior only). On master it would be 241 of 359 layer branches, since
core master is already blacksail and most layers still list wrynose,
hence only a warning there. The check runs when a layer has changed
(or with -r), like the rest of the parsing.

 layerindex/update.py       | 10 ++++++++++
 layerindex/update_layer.py | 13 ++++++++++++-
 layerindex/utils.py        | 17 +++++++++++++++++
 tests/test_update.py       | 27 +++++++++++++++++++++++++++
 tests/test_utils.py        | 14 ++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/layerindex/update.py b/layerindex/update.py
index 72bad6c..cd4b267 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -514,6 +514,16 @@ def main():
                         record_layer_error(layer, branchobj, 'Unable to find BBFILE_COLLECTIONS value for layer %s - is it set in conf/layer.conf?' % layer.name)
                         # Assume (perhaps naively) that it's an error specific to the layer
                         continue
+                    if branchobj.name != 'master':
+                        mismatch = utils.layerseries_mismatch(extract_value('LAYERSERIES_COMPAT', initial_values),
+                                                              extract_value('LAYERSERIES_CORENAMES', initial_values))
+                        if mismatch:
+                            errmsg = 'Layer %s %s' % (layer.name, mismatch)
+                            if newbranch:
+                                record_layer_error(layer, branchobj, errmsg)
+                            else:
+                                disable_layerbranch_updates(layer, branchobj, layerbranch, errmsg)
+                            continue
                     ver = extract_value('LAYERVERSION', initial_values)
                     deps = extract_value('LAYERDEPENDS', initial_values)
                     recs = extract_value('LAYERRECOMMENDS', initial_values)
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index c11c002..9bcfa3a 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -457,10 +457,21 @@ def main():
                     # Write these to a file rather than the output, which is
                     # shown on the console and in the update log
                     with open(options.initial, 'w') as f:
-                        for i in ["BBFILE_COLLECTIONS", "LAYERVERSION", "LAYERDEPENDS", "LAYERRECOMMENDS"]:
+                        for i in ["BBFILE_COLLECTIONS", "LAYERVERSION", "LAYERDEPENDS", "LAYERRECOMMENDS",
+                                  "LAYERSERIES_COMPAT", "LAYERSERIES_CORENAMES"]:
                             f.write('%s = "%s"\n' % (i, utils.get_layer_var(layer_config_data, i, logger)))
                     sys.exit(0)
 
+                # On master the core layer is already the next release, which
+                # layers catch up with over time, so only warn (on release
+                # branches update.py doesn't update such layers)
+                if branch.name == 'master':
+                    mismatch = utils.layerseries_mismatch(
+                        utils.get_layer_var(layer_config_data, 'LAYERSERIES_COMPAT', logger),
+                        utils.get_layer_var(layer_config_data, 'LAYERSERIES_CORENAMES', logger))
+                    if mismatch:
+                        logger.warning('Layer %s %s' % (layer.name, mismatch))
+
                 # Set up for recording patch info
                 utils.setup_core_layer_sys_path(settings, branch.name)
                 skip_patches = False
diff --git a/layerindex/utils.py b/layerindex/utils.py
index fd29de0..5502163 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -57,6 +57,23 @@ def get_layer_var(config_data, var, logger):
         value = config_data.getVar(var, True)
     return value or ''
 
+def layerseries_mismatch(compat, corenames):
+    """
+    If a layer's LAYERSERIES_COMPAT doesn't include any of the release series
+    the core layer is (LAYERSERIES_CORENAMES), return why; otherwise return
+    None. Branches whose core layer has no LAYERSERIES_CORENAMES (before 2.5)
+    aren't checked.
+    """
+    corenames = (corenames or '').split()
+    if not corenames:
+        return None
+    compat = (compat or '').split()
+    if not compat:
+        return 'does not set LAYERSERIES_COMPAT'
+    if set(compat) & set(corenames):
+        return None
+    return 'is only compatible with %s, not %s (LAYERSERIES_COMPAT)' % (' '.join(compat), ' '.join(corenames))
+
 def nested_layer_dirs(layerdir):
     """
     Return the directories below layerdir that contain a conf/layer.conf of
diff --git a/tests/test_update.py b/tests/test_update.py
index 8cd3161..42be35f 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -116,6 +116,33 @@ def test_move_recipe_out(import_layer, repo, db_access_without_rollback_and_trun
     with pytest.raises(Recipe.DoesNotExist):
         recipe.refresh_from_db()
 
+def test_layerseries_compat(import_layer, repo, db_access_without_rollback_and_truncate):
+    # [YOCTO #7792] the test layer only lists "sumo" in LAYERSERIES_COMPAT
+    from layerindex.models import LayerBranch, LayerUpdate
+    # On master: updated, with a warning in the layer's update log
+    run_cmd("layerindex/update.py -l meta-layerindex-test --nofetch --nocheckout -r")
+    layerupdate = LayerUpdate.objects.filter(layer__name='meta-layerindex-test', branch__name='master').order_by('-id').first()
+    assert 'WARNING: Layer meta-layerindex-test is only compatible with sumo' in layerupdate.log
+    assert LayerBranch.objects.get(layer__name='meta-layerindex-test', branch__name='master').updates_enabled
+    # On a release branch: updates for the layer branch are disabled
+    run_cmd('python3 manage.py shell -c "from layerindex.models import Branch, LayerBranch, LayerItem; '
+            'b = Branch.objects.create(name=\'teststable\', bitbake_branch=\'master\'); '
+            'LayerBranch.objects.create(layer=LayerItem.objects.get(name=\'meta-layerindex-test\'), branch=b, '
+            'vcs_subdir=\'meta-layerindex-test\', actual_branch=\'master\'); '
+            'LayerBranch.objects.create(layer=LayerItem.objects.get(name=\'openembedded-core\'), branch=b, '
+            'vcs_subdir=\'meta\', actual_branch=\'master\')"', cwd=basepath)
+    try:
+        run_cmd("layerindex/update.py -b teststable -l meta-layerindex-test --nofetch --nocheckout")
+        layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test', branch__name='teststable')
+        assert not layerbranch.updates_enabled
+        layerupdate = LayerUpdate.objects.filter(layer__name='meta-layerindex-test', branch__name='teststable').order_by('-id').first()
+        assert 'is only compatible with sumo' in layerupdate.log
+        assert 'updates for this layer branch have been disabled' in layerupdate.log
+    finally:
+        run_cmd('python3 manage.py shell -c "from layerindex.models import Branch; '
+                'Branch.objects.filter(name=\'teststable\').delete()"', cwd=basepath)
+
+
 def test_delete_recipe(import_layer, repo, db_access_without_rollback_and_truncate):
     from layerindex.models import LayerBranch, Recipe
     layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test')
diff --git a/tests/test_utils.py b/tests/test_utils.py
index 95b5e04..37b80d4 100644
--- a/tests/test_utils.py
+++ b/tests/test_utils.py
@@ -48,6 +48,20 @@ def make_layer(path):
     (path / 'conf' / 'layer.conf').write_text('')
 
 
+@pytest.mark.parametrize('compat, corenames, expected', [
+    # [YOCTO #7792]
+    ('scarthgap', 'scarthgap', None),
+    ('kirkstone scarthgap', 'scarthgap', None),
+    ('wrynose', 'blacksail', 'is only compatible with wrynose, not blacksail (LAYERSERIES_COMPAT)'),
+    ('', 'scarthgap', 'does not set LAYERSERIES_COMPAT'),
+    # Before LAYERSERIES_CORENAMES existed nothing is checked
+    ('', '', None),
+    ('sumo', None, None),
+])
+def test_layerseries_mismatch(compat, corenames, expected):
+    assert utils.layerseries_mismatch(compat, corenames) == expected
+
+
 @pytest.fixture
 def repo_with_nested_layers(tmp_path):
     """A repository whose layer (in subdirectory 'meta-top') contains other

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 85be5c2fe68b937570c6e8be5a911e92864cdf63
prerequisite-patch-id: 85ea51619f1ba4ca8253c1df2d0f7689823f1d22
prerequisite-patch-id: e0e8ba9340973102abc551c2c349edbf518d6d48
prerequisite-patch-id: b10e06558db0fb85abfab3d8b9d4bd8f29449e9e
-- 
2.56.0

