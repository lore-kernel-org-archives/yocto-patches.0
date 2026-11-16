Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22648.1794813588030123448
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 23:19:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=e2NI+Tsd;
 spf=pass (domain: qbee.io, ip: 209.85.208.42, mailfrom: piotr@qbee.io)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso4651823a12.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1794813586; x=1795418386; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCuPKtwgzttF3m2lcqvoriVWHEuDUXZ0rc1pSEDIMEg=;
        b=e2NI+TsdcfQ6l2R9cp+f+CokzZ/+CSavhokkJivifDuA8cccTyZtJMT1orFk56ZO+4
         UyS7cXwcv0/JpAfoO9B4j73FzlLvMPgwbGxojru7dUqRRbD4ByJN5SMk8rHriIDEfAtB
         sJmZyj6+kFTBEme1CSTr0jIpGd/k3EPKnyKK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813586; x=1795418386;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCuPKtwgzttF3m2lcqvoriVWHEuDUXZ0rc1pSEDIMEg=;
        b=G9kn0X9NE1Au+tEZm9CtZcMLDUAp6wm29dsaArI0QMlOxA9mLxmkuCsr/TuIOutbv4
         OqumD3RsT89yitungvLKS12snF0OkC0F/6tBvVyaN76Ri7DOqWdBaUrkrEabYFLZPrMy
         fu2mxYV+MRUBrkshIW9oQCbnEzbC4DaVxKoJVj0sAusQlFfBrNFB/NElF1QhdhHk9+C2
         h0O5sF3ChvREGXEeHtGdXAGfjUAn8CY4jmo40pBsMsVYLTMDUNuMWPnJWoVvtX+gmHnk
         BFsZlkSyhYuVVZ1XMmCMs0DhAPVK/J+glQ3yNWlQaZOJ9k0Fx/PbWMiLY+iJcfEr2VkY
         Mwog==
X-Gm-Message-State: APuU4Z9n8RWJfOJsvAD1x8v0ohUY+1MmY1s3nnZAjaiGMMgkVZwIlsQH
	ACZ5XSmAPeOvTWUs8UjxMLzgvIzHScgeOFtC4M3nqrY256G3eBoKXPhQZv+e25Ofd2rtKDqlWCq
	PU8jwt58=
X-Gm-Gg: AYBFou1o1pz0ClHb2z4MIpjupjvzwZ2lrFeGkJSKT53jEgHSyL1feQLpGWtio+ah+Wf
	X0NKs6LropYVpB8gsgpBbLxqsSuDd9GtnjMVVCyoox3GEIsSBZECuyEyR7OjSc0j5nGab8XAjx4
	PfLkWdCzg0sNYJ+I4IL7YHLiUhgGC/CTgCBVXBNAUz0i2ipjMAcc0r6i6ZoCbM2qiAbZzb4aPRT
	KpoJzBiRDpqKwzV8Py/7KC7+JMf0FbftUFvTibj3neWuRoOY2IHU0cEHAmPLZkCOtTozx9Vm0Sn
	BAcqPXdCvpirh6gWLGkFh1o2oYsRENCTurPry/hxhXgsjDK+UoVH7MsvxrK2MDgsxKu/81+O1Ha
	pQV2RXc9an25XLkyCB3Mw++ovj90c/0zEtVoNZ9aPnB0OoXVIgy+3nsugGJ9bZolcpurNd6juZM
	8y/My7mpwqd5bzT9TklR4jXLmJPF04UB0i7i/LRNPY7FwTk+sX4rOIAFb9aVbACHD/8Dq9eqrsZ
	rVvFGZh3INHYPFsYp200OdzZVepvpC64AIHX1KSaxK617LoE4AT0DUKwhS4m3cxk4LRTYZrYuB4
	Is9P63UAeHdT9oymF8pHz/Rru4gV8uJHCfEI/xoQ2R45tmY8pDQsse2pZJwbfUubC2hInBgKEcD
	GjZjV+Cz2qqvQE+Mxzbs5
X-Received: by 2002:a17:907:96a8:b0:c46:9d7b:37d with SMTP id a640c23a62f3a-c50962ec3damr751268066b.17.1794813585712;
        Sun, 15 Nov 2026 23:19:45 -0800 (PST)
Return-Path: <piotr@qbee.io>
Received: from localhost ([2a0d:3341:aac1:2c00:c803:f7fb:919c:9ee0])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c5095b42782sm385288166b.38.2026.11.15.23.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 23:19:45 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH] tests: check the shape of every REST API response
Date: Mon, 16 Nov 2026 08:19:34 +0100
Message-ID: <20261116071934.55661-1-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 07:19:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5406
Content-Type: text/plain; charset="utf-8"

Released BitBake and Toaster read these responses and cannot be changed
once shipped, yet every serializer uses fields = '__all__', so a model
change alters the API with nobody touching the API code. An earlier
change of this kind broke Toaster.

Record what the API root, each of the 14 endpoints and their detail
routes return in tests/data/api_schema.json: field names and JSON types,
bare array or paginated object, and the datetime format. An API change
now has to update that file in the same commit, where a reviewer sees
it. tests/conftest.py adds a seeded index with a row behind every
endpoint, for these and later API tests.

Tested by breaking the API in four ways and checking that the tests
fail for each: the nested "layers" serializer under layerBranches/ (the
effect of the bug in f592209), a field removed, pagination switched on
for every endpoint, and the datetime format changed.

[YOCTO #12560]

AI-Generated: Claude Code (Claude Fable 5.2)
Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 tests/conftest.py          | 160 ++++++++++++++++++++++++++
 tests/data/api_schema.json | 223 +++++++++++++++++++++++++++++++++++++
 tests/test_api_contract.py | 119 ++++++++++++++++++++
 3 files changed, 502 insertions(+)
 create mode 100644 tests/conftest.py
 create mode 100644 tests/data/api_schema.json
 create mode 100644 tests/test_api_contract.py

diff --git a/tests/conftest.py b/tests/conftest.py
new file mode 100644
index 0000000..8539c54
--- /dev/null
+++ b/tests/conftest.py
@@ -0,0 +1,160 @@
+# layerindex-web - fixtures shared between test modules
+#
+# Copyright (C) 2026 Qbee AS
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-Generated: written with Claude Code
+
+import datetime
+import types
+
+import pytest
+
+
+@pytest.fixture
+def seeded_index(db):
+    """A small index with a row behind every REST API endpoint.
+
+    It has two branches and a layer in each status:
+
+    - openembedded-core, published, on both branches
+    - meta-alpha, published, on both branches. On master it is indexed, is
+      Yocto Project Compatible and depends on openembedded-core and on
+      meta-pending; on the release branch it has not been parsed yet
+    - meta-beta, published, on master only, recommends meta-alpha
+    - meta-frozen, "No update", on master only
+    - meta-pending, new (not published), on master only, with a machine and
+      a recipe
+
+    Nullable fields have both a value and NULL somewhere in the data.
+    """
+    # Imported here because tests/test_dockersetup.py also runs on a host
+    # that has no Django, and pytest loads this file for it too
+    from layerindex.models import (
+        BBAppend, BBClass, Branch, Distro, DynamicBuildDep, IncFile,
+        LayerBranch, LayerDependency, LayerItem, LayerMaintainer, LayerNote,
+        Machine, PackageConfig, Patch, PythonEnvironment, Recipe,
+        RecipeFileDependency, Source, StaticBuildDep, YPCompatibleVersion)
+
+    def add_layer(name, status='P', layer_type='S'):
+        return LayerItem.objects.create(
+            name=name, status=status, layer_type=layer_type,
+            summary='%s summary' % name, description='%s description' % name,
+            vcs_url='https://git.example.com/%s' % name,
+            vcs_web_url='https://git.example.com/web/%s' % name)
+
+    def add_indexed(layer, branch, collection, **kwargs):
+        """A layer branch as the update script leaves it after a successful parse"""
+        return LayerBranch.objects.create(
+            layer=layer, branch=branch, collection=collection, version='1',
+            actual_branch=branch.name,
+            vcs_last_fetch=datetime.datetime(2026, 10, 1, 12, 0, 0),
+            vcs_last_rev='0123456789abcdef0123456789abcdef01234567',
+            vcs_last_commit=datetime.datetime(2026, 9, 30, 8, 30, 0),
+            **kwargs)
+
+    env = PythonEnvironment.objects.create(name='Python 3', python_command='python3')
+    # Created by migration 0001
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    release = Branch.objects.create(name='scarthgap', bitbake_branch='2.8',
+                                    short_description='Yocto Project 5.0',
+                                    sort_priority=500, update_environment=env)
+
+    core = add_layer('openembedded-core', layer_type='A')
+    alpha = add_layer('meta-alpha')
+    beta = add_layer('meta-beta')
+    frozen = add_layer('meta-frozen', status='X')
+    pending = add_layer('meta-pending', status='N', layer_type='B')
+
+    compatible = YPCompatibleVersion.objects.create(
+        name='5.0', description='Yocto Project Compatible 5.0',
+        image_url='https://example.com/compatible.png',
+        link_url='https://example.com/compatible')
+
+    core_master = add_indexed(core, master, 'core', vcs_subdir='meta')
+    core_release = add_indexed(core, release, 'core', vcs_subdir='meta')
+    alpha_master = add_indexed(alpha, master, 'alpha', yp_compatible_version=compatible)
+    alpha_release = LayerBranch.objects.create(layer=alpha, branch=release)
+    beta_master = add_indexed(beta, master, 'beta')
+    frozen_master = add_indexed(frozen, master, 'frozen')
+    pending_master = add_indexed(pending, master, 'pending')
+
+    LayerDependency.objects.create(layerbranch=alpha_master, dependency=core)
+    LayerDependency.objects.create(layerbranch=alpha_master, dependency=pending)
+    LayerDependency.objects.create(layerbranch=alpha_release, dependency=core)
+    LayerDependency.objects.create(layerbranch=beta_master, dependency=core)
+    LayerDependency.objects.create(layerbranch=beta_master, dependency=alpha, required=False)
+
+    LayerMaintainer.objects.create(layerbranch=core_master, name='Carol Example',
+                                   email='carol@example.com')
+    LayerMaintainer.objects.create(layerbranch=alpha_master, name='Alice Example',
+                                   email='alice@example.com')
+    LayerMaintainer.objects.create(layerbranch=alpha_master, name='Bob Example',
+                                   email='bob@example.com', status='I',
+                                   responsibility='documentation')
+    LayerMaintainer.objects.create(layerbranch=alpha_release, name='Alice Example',
+                                   email='alice@example.com')
+
+    LayerNote.objects.create(layer=alpha, text='Mirrored from an internal repository.')
+
+    Recipe.objects.create(layerbranch=core_master, filename='base-example_2.0.bb',
+                          filepath='recipes-core/base-example',
+                          pn='base-example', pv='2.0')
+    example = Recipe.objects.create(
+        layerbranch=alpha_master, filename='example_1.0.bb',
+        filepath='recipes-example/example', pn='example', pv='1.0', pr='r0',
+        summary='An example', description='An example recipe',
+        section='examples', license='MIT',
+        homepage='https://example.com/example',
+        bugtracker='https://example.com/example/issues',
+        provides='example', bbclassextend='native',
+        inherits='autotools pkgconfig')
+    Recipe.objects.create(layerbranch=alpha_release, filename='example_0.9.bb',
+                          filepath='recipes-example/example', pn='example', pv='0.9')
+    Recipe.objects.create(layerbranch=pending_master, filename='pending-example_1.0.bb',
+                          filepath='recipes-example/pending-example',
+                          pn='pending-example', pv='1.0')
+
+    Source.objects.create(recipe=example, url='https://example.com/example-1.0.tar.gz',
+                          sha256sum='0' * 64)
+    Source.objects.create(recipe=example, url='file://defconfig')
+    Patch.objects.create(recipe=example, src_path='fix-build.patch',
+                         path='recipes-example/example/files/fix-build.patch',
+                         status='P', apply_order=1)
+    Patch.objects.create(recipe=example, src_path='unused.patch',
+                         path='recipes-example/example/files/unused.patch',
+                         applied=False)
+    ssl = PackageConfig.objects.create(recipe=example, feature='ssl',
+                                       with_option='--with-ssl',
+                                       without_option='--without-ssl',
+                                       build_deps='openssl')
+    openssl = DynamicBuildDep.objects.create(name='openssl')
+    openssl.package_configs.add(ssl)
+    openssl.recipes.add(example)
+    StaticBuildDep.objects.create(name='zlib').recipes.add(example)
+    RecipeFileDependency.objects.create(recipe=example, layerbranch=core_master,
+                                        path='meta/classes-recipe/autotools.bbclass')
+
+    Machine.objects.create(layerbranch=alpha_master, name='alpha-board',
+                           description='Alpha reference board')
+    Machine.objects.create(layerbranch=pending_master, name='pending-board',
+                           description='Pending reference board')
+    Distro.objects.create(layerbranch=alpha_master, name='alphaos',
+                          description='Alpha OS')
+    BBClass.objects.create(layerbranch=alpha_master, name='alpha-image',
+                           bbclass_type='Recipe')
+    BBAppend.objects.create(layerbranch=beta_master, filename='example_%.bbappend',
+                            filepath='recipes-example/example')
+    IncFile.objects.create(layerbranch=alpha_master,
+                           path='recipes-example/example/example.inc')
+
+    return types.SimpleNamespace(
+        master=master, release=release,
+        core=core, alpha=alpha, beta=beta, frozen=frozen, pending=pending,
+        core_master=core_master, core_release=core_release,
+        alpha_master=alpha_master, alpha_release=alpha_release,
+        beta_master=beta_master, frozen_master=frozen_master,
+        pending_master=pending_master, example=example)
diff --git a/tests/data/api_schema.json b/tests/data/api_schema.json
new file mode 100644
index 0000000..99b0356
--- /dev/null
+++ b/tests/data/api_schema.json
@@ -0,0 +1,223 @@
+{
+    "branches": [{
+        "id": "int",
+        "name": "str",
+        "bitbake_branch": "str",
+        "short_description": "str",
+        "sort_priority": "int|null",
+        "updates_enabled": "bool",
+        "comparison": "bool",
+        "hidden": "bool",
+        "updated": "datetime",
+        "update_environment": "int|null"
+    }],
+    "layerItems": [{
+        "id": "int",
+        "name": "str",
+        "status": "str",
+        "layer_type": "str",
+        "summary": "str",
+        "description": "str",
+        "vcs_url": "str",
+        "vcs_web_url": "str",
+        "vcs_web_tree_base_url": "str",
+        "vcs_web_file_base_url": "str",
+        "vcs_web_commit_url": "str",
+        "usage_url": "str",
+        "mailing_list_url": "str",
+        "index_preference": "int",
+        "comparison": "bool",
+        "updated": "datetime"
+    }],
+    "layerBranches": [{
+        "id": "int",
+        "layer": "int",
+        "branch": "int",
+        "collection": "null|str",
+        "version": "null|str",
+        "vcs_subdir": "str",
+        "vcs_last_fetch": "datetime|null",
+        "vcs_last_rev": "str",
+        "vcs_last_commit": "datetime|null",
+        "actual_branch": "str",
+        "yp_compatible_version": "int|null",
+        "local_path": "str",
+        "updates_enabled": "bool",
+        "updated": "datetime"
+    }],
+    "layerDependencies": [{
+        "id": "int",
+        "layerbranch": "int",
+        "dependency": "int",
+        "required": "bool",
+        "from_layer_conf": "bool"
+    }],
+    "layerMaintainers": [{
+        "id": "int",
+        "layerbranch": "int",
+        "name": "str",
+        "email": "str",
+        "responsibility": "str",
+        "status": "str"
+    }],
+    "layerNotes": [{
+        "id": "int",
+        "layer": "int",
+        "text": "str"
+    }],
+    "recipes": [{
+        "id": "int",
+        "layerbranch": "int",
+        "filename": "str",
+        "filepath": "str",
+        "pn": "str",
+        "pv": "str",
+        "pr": "str",
+        "pe": "str",
+        "summary": "str",
+        "description": "str",
+        "section": "str",
+        "license": "str",
+        "homepage": "str",
+        "bugtracker": "str",
+        "provides": "str",
+        "bbclassextend": "str",
+        "inherits": "str",
+        "updated": "datetime",
+        "blacklisted": "str",
+        "configopts": "str",
+        "srcrev": "str"
+    }],
+    "recipesExtended": {
+        "count": "int",
+        "next": "null",
+        "previous": "null",
+        "results": [{
+            "id": "int",
+            "sources": [{
+                "url": "str",
+                "sha256sum": "str"
+            }],
+            "patches": [{
+                "path": "str",
+                "src_path": "str",
+                "status": "str",
+                "status_extra": "str",
+                "apply_order": "int|null",
+                "applied": "bool",
+                "striplevel": "int"
+            }],
+            "package_configs": [{
+                "feature": "str",
+                "with_option": "str",
+                "without_option": "str",
+                "builddeps": ["str"]
+            }],
+            "staticbuilddeps": ["str"],
+            "filedeps": [{
+                "layerbranch": "int",
+                "path": "str"
+            }],
+            "layerbranch": "int",
+            "filename": "str",
+            "filepath": "str",
+            "pn": "str",
+            "pv": "str",
+            "pr": "str",
+            "pe": "str",
+            "summary": "str",
+            "description": "str",
+            "section": "str",
+            "license": "str",
+            "homepage": "str",
+            "bugtracker": "str",
+            "provides": "str",
+            "bbclassextend": "str",
+            "inherits": "str",
+            "updated": "datetime",
+            "blacklisted": "str",
+            "configopts": "str",
+            "srcrev": "str"
+        }]
+    },
+    "machines": [{
+        "id": "int",
+        "layerbranch": "int",
+        "name": "str",
+        "description": "str",
+        "updated": "datetime"
+    }],
+    "distros": [{
+        "id": "int",
+        "layerbranch": "int",
+        "name": "str",
+        "description": "str",
+        "updated": "datetime"
+    }],
+    "classes": [{
+        "id": "int",
+        "layerbranch": "int",
+        "name": "str",
+        "bbclass_type": "str"
+    }],
+    "layers": [{
+        "id": "int",
+        "branch": {
+            "id": "int",
+            "name": "str"
+        },
+        "layer": {
+            "id": "int",
+            "name": "str",
+            "status": "str",
+            "layer_type": "str",
+            "summary": "str",
+            "description": "str",
+            "vcs_url": "str",
+            "vcs_web_url": "str",
+            "vcs_web_tree_base_url": "str",
+            "vcs_web_file_base_url": "str",
+            "vcs_web_commit_url": "str",
+            "usage_url": "str",
+            "mailing_list_url": "str",
+            "index_preference": "int",
+            "comparison": "bool",
+            "updated": "datetime"
+        },
+        "yp_compatible_version": {
+            "null|object": {
+                "id": "int",
+                "name": "str",
+                "description": "str",
+                "image_url": "str",
+                "link_url": "str"
+            }
+        },
+        "maintainers": [{
+            "name": "str",
+            "email": "str",
+            "responsibility": "str"
+        }],
+        "collection": "null|str",
+        "version": "null|str",
+        "vcs_subdir": "str",
+        "vcs_last_fetch": "datetime|null",
+        "vcs_last_rev": "str",
+        "vcs_last_commit": "datetime|null",
+        "actual_branch": "str",
+        "local_path": "str",
+        "updates_enabled": "bool",
+        "updated": "datetime"
+    }],
+    "appends": [{
+        "id": "int",
+        "layerbranch": "int",
+        "filename": "str",
+        "filepath": "str"
+    }],
+    "incFiles": [{
+        "id": "int",
+        "layerbranch": "int",
+        "path": "str"
+    }]
+}
diff --git a/tests/test_api_contract.py b/tests/test_api_contract.py
new file mode 100644
index 0000000..5de9427
--- /dev/null
+++ b/tests/test_api_contract.py
@@ -0,0 +1,119 @@
+# layerindex-web - tests for the shape of the REST API responses
+#
+# Copyright (C) 2026 Qbee AS
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-Generated: written with Claude Code
+
+# BitBake's layer index client, Toaster and other tools read these responses
+# and released versions of them cannot be changed, so tests/data/api_schema.json
+# records what every endpoint returns. A change to the API has to change that
+# file in the same commit, where a reviewer can see it.
+#
+# The file maps each endpoint to the shape of its response body:
+#   "int", "str", "bool", "null"  a JSON value of that type
+#   "datetime"                    a string in the API's datetime format
+#   "int|null"                    either of these, in alphabetical order
+#   {"field": shape, ...}         an object with exactly these fields
+#   [shape]                       an array of values with this shape
+#   {"null|object": {...}}        null or an object with these fields
+
+import json
+import os
+import re
+
+import pytest
+
+with open(os.path.join(os.path.dirname(__file__), 'data', 'api_schema.json')) as f:
+    SCHEMA = json.load(f)
+
+ENDPOINTS = sorted(SCHEMA)
+
+# DATETIME_FORMAT in settings.py
+DATETIME = re.compile(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+0000')
+
+MISSING = object()
+
+
+def shape(values):
+    """Describe the JSON values seen in one place of a response, in the
+    notation of api_schema.json"""
+    kinds = set()
+    objects = []
+    items = []
+    for value in values:
+        if value is MISSING:
+            kinds.add('missing')
+        elif value is None:
+            kinds.add('null')
+        elif isinstance(value, bool):
+            kinds.add('bool')
+        elif isinstance(value, int):
+            kinds.add('int')
+        elif isinstance(value, float):
+            kinds.add('float')
+        elif isinstance(value, str):
+            kinds.add('datetime' if DATETIME.fullmatch(value) else 'str')
+        elif isinstance(value, dict):
+            kinds.add('object')
+            objects.append(value)
+        else:
+            kinds.add('array')
+            items.extend(value)
+    name = '|'.join(sorted(kinds))
+    if objects:
+        fields = {}
+        for obj in objects:
+            for key in obj:
+                if key not in fields:
+                    fields[key] = shape([o.get(key, MISSING) for o in objects])
+        return fields if name == 'object' else {name: fields}
+    if 'array' in kinds:
+        inner = [shape(items)] if items else []
+        return inner if name == 'array' else {name: inner}
+    return name
+
+
+def rows(body):
+    """The records in a list response, paginated or not"""
+    return body['results'] if isinstance(body, dict) else body
+
+
+@pytest.fixture
+def api(client, seeded_index):
+    """Fetch an API URL the way BitBake does: no Accept header and no format
+    parameter, expecting JSON"""
+    def get(path, **params):
+        response = client.get('/layerindex/api/' + path, params)
+        assert response.status_code == 200, path
+        assert response['Content-Type'] == 'application/json', path
+        return response.json()
+    return get
+
+
+def test_root_links_to_every_endpoint(api):
+    # Clients append "?filter=..." to these links
+    assert api('') == {name: 'http://testserver/layerindex/api/%s/' % name for name in ENDPOINTS}
+
+
+@pytest.mark.parametrize('endpoint', ENDPOINTS)
+def test_list_response_shape(api, endpoint):
+    body = api(endpoint + '/')
+    assert rows(body), 'the seeded index has no data for %s' % endpoint
+    seen = shape([body])
+    assert seen == SCHEMA[endpoint], (
+        'The %s response changed. If that is intended, update tests/data/api_schema.json to:\n%s'
+        % (endpoint, json.dumps(seen, indent=4)))
+
+
+@pytest.mark.parametrize('endpoint', ENDPOINTS)
+def test_detail_response_matches_list(api, endpoint):
+    for row in rows(api(endpoint + '/')):
+        assert api('%s/%d/' % (endpoint, row['id'])) == row
+
+
+def test_format_parameter_is_accepted(api):
+    assert api('branches/', format='json') == api('branches/')
