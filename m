Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3828.1794620327969140996
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 17:38:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DvEK9rvC;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso1535740a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 17:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794620327; x=1795225127; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud0HUYiuu6OcchotBCHNrmAfeAdZWYV3gaDQPs2nMpI=;
        b=DvEK9rvCHA/P26zmh2DchyUq3wVGhkb45MhCV52M5RpVWg2bOgn9NaUQ4Txl6k9L6G
         d0PIaOBivsmVDkHDWmdb7f044zfsgGOLl7l3aptwgz1WGKZpCI2eR43hqwD17hYg5XPR
         3892SH0miNJDb2ScGOxG97Vfpnuh6RJixwlOt5mr2QEBWZJtt/kCAdVpXITNnCS5v7IU
         qNAQLOQ8PHYXxMJKgGFBoC6rzAqlOEutBH3KV1kiN2akNdSZu/qYr3g0HbcKq4olg30C
         yIn9Vq4rGxU/IE0rSQmRg4tAchQFAmOGQCDGtQKetDa/R3FiwIx0icYXIgd0tb2rbpe1
         U6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794620327; x=1795225127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud0HUYiuu6OcchotBCHNrmAfeAdZWYV3gaDQPs2nMpI=;
        b=VU+CSqbkwHLKx7yIwgds/GEmkhcfN6KHUNk5hFV9PCWjeHi4ZcxfMMmiWgyls303zY
         UjV6Fb7WIx/sVOVHuWbjN1AwM9Bg6O8ouUR+Yi4ahEPxI5Y6JDhEQZjspMyKOpRtBUzC
         BNelW5Q/QF2RZdLfCVbsn3g0z8SbI+48HEPFD5B1Ke9kbd1F+WnQ16lZgbhFSSGFXlt2
         14VZj2n6zBO++105+g8tAlfQCRyRVlcmrBSfDnugj/Actb0gR4sujaBYnOh34XN2eGpM
         l+nRz/FnpGYNsDK/9M3v96BLXhezUzZOoeVgrnMUDtXWwKZxtQregNVD6s7cnW+Gp5YI
         Hbjg==
X-Gm-Message-State: APuU4Z/UUQSCifNtliTw+uLj/cDXtK+/hm2LHpr3yesc9HNLJxxU4mFf
	0E/TxEDQCn9nnEpmUg7RPKbZ81JeQ6HzpsQTgfAvbSYJ1saz3UqFcfu5aLSCFnEE
X-Gm-Gg: AYBFou0JHRxct9vx7fBoKiXdvBkbeMrW+8/jXFjX+Yl6Eeu8khD4Q38INSfIDIf69/n
	pzYI43FNYklsF1uDrgxr/3R1s9g/NisuOCQrhBHKj8qGbm1bCbPCzMzD/QooHvautW0I2e+ycaZ
	m0KGqq4zoQcJr+f1uVuw1+alyz7CnTDdRaaD3ywqmKyqvKBK4xuYvMvw+3qEJYP/54GSi6w/X0c
	YQgTOF8W+eBj2VOgP8XRbeisX6gEmfd/GLY8oqJAsZ7tHsj/3oo0ddGKWL+zS8TlWtozDHPKxyY
	ZbdEKZCeFR5yzmkjmrmHoWq6FKNKmYwEDsMzoztXIDgfvMGNkijERDX27FXWh/O0Z77loNIaG2J
	nP3yKV77bAUHO0IELSv62a/QGFUHQ3Xn5Eid+JEHcNBlr047MFlxIfHZaz6d/30VNN05DLYDzGb
	rwdQb+3YjJ5bzvo9ja44EWZdf3/X8sW2w9MQmLlTJig6d0APxei/EjnvMtLUIaVlnxKrqbxXF3B
	pwqBgZdisQvMEf+ZNGEh3T7aSoRGecsUPesnIxh+MSqDwJDiA/u4B6O0RhkVwVOROjbs0JAdLES
	TJVUzwtZi1xti21S59hGhqrtbOnmqdHkzT1rGGXzKMmlNdNTj9uhWjymG0eVcEA=
X-Received: by 2002:a17:90b:5585:b0:3b0:ae41:2711 with SMTP id 98e67ed59e1d1-3b1b0a12f15mr3727826a91.24.1794620327170;
        Fri, 13 Nov 2026 17:38:47 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm6593679a91.3.2026.11.13.17.38.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 17:38:45 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] layerindex: remove dependencies that are dropped from conf/layer.conf
Date: Fri, 13 Nov 2026 17:38:38 -0800
Message-ID: <20261114013839.51312-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114013839.51312-1-tim.orling@konsulko.com>
References: <20261114013839.51312-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 01:38:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5354
Content-Type: text/plain; charset="utf-8"

When a layer dropped a dependency from LAYERDEPENDS or LAYERRECOMMENDS,
the update only warned about it, unless REMOVE_LAYER_DEPENDENCIES was
set, which also removes the dependencies added by hand in the edit
form. Record which dependencies came from conf/layer.conf, and remove
those when they are no longer there. Dependencies added by hand, or
before this was recorded, are kept and warned about as before.

[YOCTO #14348]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../0056_layerdependency_from_layer_conf.py   |  16 +++
 layerindex/models.py                          |   3 +
 layerindex/utils.py                           |  50 +++++----
 tests/test_add_dependency.py                  | 104 ++++++++++++++++++
 4 files changed, 152 insertions(+), 21 deletions(-)
 create mode 100644 layerindex/migrations/0056_layerdependency_from_layer_conf.py
 create mode 100644 tests/test_add_dependency.py

diff --git a/layerindex/migrations/0056_layerdependency_from_layer_conf.py b/layerindex/migrations/0056_layerdependency_from_layer_conf.py
new file mode 100644
index 0000000..ab0b731
--- /dev/null
+++ b/layerindex/migrations/0056_layerdependency_from_layer_conf.py
@@ -0,0 +1,16 @@
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('layerindex', '0055_recipe_text_fields'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='layerdependency',
+            name='from_layer_conf',
+            field=models.BooleanField(default=False, verbose_name='From conf/layer.conf'),
+        ),
+    ]
diff --git a/layerindex/models.py b/layerindex/models.py
index 1d72c55..fd8e88f 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -402,6 +402,9 @@ class LayerDependency(models.Model):
     layerbranch = models.ForeignKey(LayerBranch, related_name='dependencies_set', on_delete=models.CASCADE)
     dependency = models.ForeignKey(LayerItem, related_name='dependents_set', on_delete=models.CASCADE)
     required = models.BooleanField(default=True)
+    # Set when the dependency was found in conf/layer.conf, so that it can be
+    # removed when it goes from there; those added by hand are kept
+    from_layer_conf = models.BooleanField('From conf/layer.conf', default=False)
 
     class Meta:
         verbose_name_plural = "Layer dependencies"
diff --git a/layerindex/utils.py b/layerindex/utils.py
index fd29de0..3889468 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -160,14 +160,13 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
 
     dep_list = config_data.getVar("%s_%s" % (var, var_name), True)
 
-    if not dep_list:
-        return
-
-    try:
-        dep_dict = bb.utils.explode_dep_versions2(dep_list)
-    except bb.utils.VersionStringException as vse:
-        logger.debug('Error parsing %s_%s for %s\n%s' % (var, var_name, layer_name, str(vse)))
-        return
+    dep_dict = {}
+    if dep_list:
+        try:
+            dep_dict = bb.utils.explode_dep_versions2(dep_list)
+        except bb.utils.VersionStringException as vse:
+            logger.debug('Error parsing %s_%s for %s\n%s' % (var, var_name, layer_name, str(vse)))
+            return
 
     need_remove = LayerDependency.objects.filter(layerbranch=layerbranch).filter(required=required)
     for dep, ver_list in list(dep_dict.items()):
@@ -175,6 +174,10 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
         if ver_list:
             ver_str = ver_list[0]
 
+        # Keep any dependency still named here, even if it can't be resolved
+        # (e.g. its version doesn't match)
+        need_remove = need_remove.exclude(dependency__name=dep).exclude(dependency__layerbranch__collection=dep)
+
         try:
             dep_layer = get_dependency_layer(dep, branch_name, ver_str, logger)
         except bb.utils.VersionStringException as vse:
@@ -191,13 +194,12 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
                     logger.warning('Cannot resolve %s %s (version %s) for %s' % (name, dep, ver_str, layer_name))
             continue
 
-        # Preparing to remove obsolete ones
-        if need_remove:
-            need_remove = need_remove.exclude(dependency=dep_layer)
+        need_remove = need_remove.exclude(dependency=dep_layer)
 
-        # Skip existing entries.
-        existing = list(LayerDependency.objects.filter(layerbranch=layerbranch).filter(required=required).filter(dependency=dep_layer))
+        # Skip existing entries, noting that they are in conf/layer.conf
+        existing = LayerDependency.objects.filter(layerbranch=layerbranch).filter(required=required).filter(dependency=dep_layer)
         if existing:
+            existing.update(from_layer_conf=True)
             logger.debug('Skipping %s - already a dependency for %s' % (dep, layer_name))
             continue
 
@@ -208,17 +210,23 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
         layerdep.layerbranch = layerbranch
         layerdep.dependency = dep_layer
         layerdep.required = required
+        layerdep.from_layer_conf = True
         layerdep.save()
 
+    # Remove those that came from conf/layer.conf and are no longer there.
+    # Warn about those added by hand (or before this was recorded), unless
+    # REMOVE_LAYER_DEPENDENCIES says to remove them too.
+    from django.conf import settings
+    if not getattr(settings, 'REMOVE_LAYER_DEPENDENCIES', False):
+        if dep_list and need_remove.filter(from_layer_conf=False):
+            names = ', '.join(d.dependency.name for d in need_remove.filter(from_layer_conf=False))
+            logger.warning('%s %s of %s are not in its conf/layer.conf' % (var, names, layer_name))
+            logger.warning('Either set REMOVE_LAYER_DEPENDENCIES to remove them from the database, or fix conf/layer.conf')
+        need_remove = need_remove.filter(from_layer_conf=True)
     if need_remove:
-        from django.conf import settings
-        remove_layer_dependencies = getattr(settings, 'REMOVE_LAYER_DEPENDENCIES', False)
-        if remove_layer_dependencies:
-            logger.info('Removing obsolete dependencies "%s" for layer %s' % (need_remove, layer_name))
-            need_remove.delete()
-        else:
-            logger.warn('Dependencies "%s" are not in %s\'s conf/layer.conf' % (need_remove, layer_name))
-            logger.warn('Either set REMOVE_LAYER_DEPENDENCIES to remove them from the database, or fix conf/layer.conf')
+        logger.info('Removing %s %s of %s, which are no longer in its conf/layer.conf'
+                    % (var, ', '.join(d.dependency.name for d in need_remove), layer_name))
+        need_remove.delete()
 
 def set_layerbranch_collection_version(layerbranch, config_data, logger=None):
     layerbranch.collection = get_layer_var(config_data, 'BBFILE_COLLECTIONS', logger)
diff --git a/tests/test_add_dependency.py b/tests/test_add_dependency.py
new file mode 100644
index 0000000..13ef5cc
--- /dev/null
+++ b/tests/test_add_dependency.py
@@ -0,0 +1,104 @@
+# layerindex-web - tests for updating layer dependencies from conf/layer.conf
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+import types
+
+import pytest
+
+from layerindex import utils
+from layerindex.models import Branch, LayerBranch, LayerDependency, LayerItem
+
+LOG = logging.getLogger('test')
+
+
+@pytest.fixture
+def fake_bb(monkeypatch):
+    """BitBake is only importable during a real update; parse LAYERDEPENDS
+    without version constraints, which is all these tests use."""
+    bb = types.SimpleNamespace(utils=types.SimpleNamespace(
+        VersionStringException=Exception,
+        explode_dep_versions2=lambda s: {d: [] for d in s.split()}))
+    monkeypatch.setattr(utils, 'bb', bb, raising=False)
+
+
+class FakeConfig:
+    def __init__(self, **values):
+        self.values = values
+
+    def getVar(self, name, expand=True):
+        return self.values.get(name)
+
+
+@pytest.fixture
+def layers(db):
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    lbs = {}
+    for name in ('meta-arm-bsp', 'meta-arm', 'meta-linux-mainline', 'meta-manual', 'meta-gone'):
+        layer = LayerItem.objects.create(name=name, status='P', layer_type='A', summary=name,
+                                         description=name, vcs_url='git://example.com/%s.git' % name)
+        lbs[name] = LayerBranch.objects.create(layer=layer, branch=master, collection=name)
+    return lbs
+
+
+def deps(lb):
+    return {d.dependency.name: d.from_layer_conf for d in LayerDependency.objects.filter(layerbranch=lb)}
+
+
+def add(lb, name):
+    LayerDependency.objects.create(layerbranch=lb, dependency=LayerItem.objects.get(name=name))
+
+
+@pytest.mark.django_db
+def test_dependency_dropped_from_layer_conf_is_removed(fake_bb, layers):
+    lb = layers['meta-arm-bsp']
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-arm meta-linux-mainline'}), logger=LOG)
+    assert deps(lb) == {'meta-arm': True, 'meta-linux-mainline': True}
+
+    # [YOCTO #14348] meta-arm-bsp stopped depending on meta-linux-mainline
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-arm'}), logger=LOG)
+    assert deps(lb) == {'meta-arm': True}
+
+
+@pytest.mark.django_db
+def test_dependencies_added_by_hand_are_kept(fake_bb, layers, caplog):
+    lb = layers['meta-arm-bsp']
+    add(lb, 'meta-manual')
+    add(lb, 'meta-arm')   # also in conf/layer.conf: recorded as such
+
+    with caplog.at_level(logging.WARNING):
+        utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-arm'}), logger=LOG)
+
+    assert deps(lb) == {'meta-arm': True, 'meta-manual': False}
+    assert 'LAYERDEPENDS meta-manual of meta-arm-bsp are not in its conf/layer.conf' in caplog.text
+
+
+@pytest.mark.django_db
+def test_unresolvable_dependency_is_kept(fake_bb, layers):
+    lb = layers['meta-arm-bsp']
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-gone'}), logger=LOG)
+    # meta-gone has no branch here any more, but conf/layer.conf still names it
+    LayerBranch.objects.filter(layer__name='meta-gone').delete()
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-gone'}), logger=LOG)
+    assert deps(lb) == {'meta-gone': True}
+
+
+@pytest.mark.django_db
+def test_all_dependencies_dropped_from_layer_conf(fake_bb, layers):
+    lb = layers['meta-arm-bsp']
+    add(lb, 'meta-manual')
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-arm'}), logger=LOG)
+    utils.add_dependencies(lb, FakeConfig(), logger=LOG)
+    assert deps(lb) == {'meta-manual': False}
+
+
+@pytest.mark.django_db
+def test_remove_layer_dependencies_setting_removes_all(fake_bb, layers, settings):
+    settings.REMOVE_LAYER_DEPENDENCIES = True
+    lb = layers['meta-arm-bsp']
+    add(lb, 'meta-manual')
+    utils.add_dependencies(lb, FakeConfig(**{'LAYERDEPENDS_meta-arm-bsp': 'meta-arm'}), logger=LOG)
+    assert deps(lb) == {'meta-arm': True}
-- 
2.56.0

