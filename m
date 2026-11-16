Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5213.1794867866985231752
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:24:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=pq/BbiLG;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efde3200c7so87895ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794867866; x=1795472666; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hfxRNEGx67WuwEx33thR5cDN6e6frCYHTHXoet/Y4Q=;
        b=pq/BbiLGFlcNgLUp/aLEXAZ5E+UlpKm8YdMVrBQH80ZOf/OeJrMDChrFkPfcMy1hte
         DVoyje3oRhfclGAcn2CfWTVAhJG+a04Jpuwgnk8NxbPi8zAL7kTlJWbC2VloyWcL9nj3
         vth6pMeP9XVMQSCm1IboOuw+e5Hh2/rcAruJ4y7C1VpS4sZ+wTWbGFzJvxCQw1dYdVZm
         1A6CN6eNYXKPo0H9032zb/IXjJqgmKXLH2iucthchYAJQDVVSWY/ZaVa6LyPL26sz2rf
         sYC5NWAMkOFr5uWuhTQFtCSNjIhbifzr9uXZH0sjWDCcEyE+Z6MjO+g2ptuABkmr2Xw2
         11TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867866; x=1795472666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hfxRNEGx67WuwEx33thR5cDN6e6frCYHTHXoet/Y4Q=;
        b=AQ2YRul0ftwsKhhrn2X2Rudy+dMP8ZMlMvA6uoeASjGB2tUCrlPYTzknl5xeUStK31
         BbKeYFpCbi6keSTw5amXs0NoPoXlbtBCLOKBcp146HZAlbxqoAaa6dmzw35YDYyro+cZ
         2ITViGPdpqw74lrXext0xuuTpvZ3dQkMyZ6dTfl6qRbtoMsa1V5NcaLcuhl3uY2INITx
         7wtwK9pg7en6sK9RJNgmwDcuHy+uk8eUkstia5phiBZfNLppWEt6TU9UyxVs2mGJ9Qmk
         rMus886ZaHF+KykHTwzPs4Fys2lLJChEwm5ylz27tq0fL5FMR/Ffmp0AgK1o1Qnb47jW
         qKXA==
X-Gm-Message-State: APuU4Z+yilbvXg21ujbIo20DojFSaeiTVNiBxBs1iKOM5f+4mc6lE/d9
	zYefc0P7ZXEQ9i4xMIBDf/28MxezuL8ZIos6+iiJ5zsbRb86aEPVLu+SmTAldg==
X-Gm-Gg: AYBFou0+GaQ2rL5PtOtdf1AredHKV4l+tFurk1Xgu2avbTpLzl+riHJFgoDrKGbxGdR
	Ve/Jkmv49mzmwEyhG+XTrppouALZWtXBIQb2NGC7OURxKMFeEN3DnsBkSdDA/Wlz3is3xoO+uuh
	KzXxnmVjKBLZvcywUwFsAYMIG/ywyKubmWXzCLnH7Z5Ws30edEqghdrDHYsbh81i42vFYVwHDrE
	7Z025EWiuyN42HAvSiZslaaJrdoVt2gviM8OL2r8PRCthORftTISrdHRqd6ABtFiWnchVs3PTFL
	oBT6RA9HNXrQ+uqzVentCeN0nZj8eW0xc7JdZRCglzndHkSY6+MxlyHFqygajx2IrN9Lkppd5X3
	l7AIW5uQCYcdD9Fy8u9gZgc1xSZ/VcOpt568e8SAAs7p8RtvjyOcPOAd78fALaSED7WCZtJlVup
	YPzKrU1HZbOASYfwiTGcdmXGkYxv60BnqPjvY4AXhBkCvaZkdAf1JfSsp6pFrQP+MWV0SeE0Ev3
	StTIEvCOtUvsFdUigijB7ffG3mTLZos4J4JzZ0g741597gkF0TJZu0/x5yfNFViDGek3AEMLDtG
	zLhnl6LM02INzMekoYcsDgU2ZZIuWXZ5bo7eisfpkg3ys2hxRilg2VxmVkH7RA==
X-Received: by 2002:a17:902:d491:b0:2e9:821a:5527 with SMTP id d9443c01a7336-2ee0da7f5b7mr126617525ad.12.1794867866152;
        Mon, 16 Nov 2026 14:24:26 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7ab4abcsm4618945ad.70.2026.11.16.14.24.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 14:24:25 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] docker/run-tests.sh: run tests for the RRS app with RRS enabled
Date: Mon, 16 Nov 2026 14:24:07 -0800
Message-ID: <20261116222410.35784-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116222410.35784-1-tim.orling@konsulko.com>
References: <20261116222410.35784-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:24:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5430
Content-Type: text/plain; charset="utf-8"

RRS is optional, so its views had no tests: the test database is built
without the app. Add tests/rrs/, collected only when RRS is installed, with
a fixture for a maintenance plan and smoke tests for the RRS pages, and run
it in a second pass with ENABLE_RRS=1. That pass builds the tables with
--nomigrations, because the RRS data migrations need the core layer before
they run (README.rrs.md), and checks that the RRS models have no changes
missing a migration.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.devel.md         |  9 +++++++
 docker/run-tests.sh     |  9 ++++++-
 tests/rrs/conftest.py   | 52 +++++++++++++++++++++++++++++++++++++++++
 tests/rrs/test_views.py | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 tests/rrs/conftest.py
 create mode 100644 tests/rrs/test_views.py

diff --git a/README.devel.md b/README.devel.md
index 64106d0..ea510a9 100644
--- a/README.devel.md
+++ b/README.devel.md
@@ -198,6 +198,15 @@ at a MariaDB/MySQL server where your database user may create databases
 pytest --ignore=tests/test_update.py tests/
 ```
 
+The tests in `tests/rrs/` need the RRS app and are skipped without it.
+`docker/run-tests.sh` runs them in a second pass with `ENABLE_RRS=1`. To run
+them directly, add `'rrs'` to `INSTALLED_APPS` and build the test database from
+the models, since the RRS data migrations need the core layer to exist first:
+
+```sh
+pytest --nomigrations tests/rrs/
+```
+
 `tests/test_dockersetup.py` tests the files `dockersetup.py` writes. It needs only
 pytest and PyYAML, and is skipped inside the Docker image:
 
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
index 5da56b3..2a22476 100755
--- a/docker/run-tests.sh
+++ b/docker/run-tests.sh
@@ -27,6 +27,10 @@ done
 # Runs as root only to prepare the container: tests/test_update.py rewrites
 # settings.py and bitbake writes its lock file next to it, the update scripts
 # expect bitbake already fetched, and the tests commit to git and call tree.
+# The tests in tests/rrs/ need RRS, so a second pass runs them with
+# ENABLE_RRS=1. --nomigrations builds the tables from the models: the RRS
+# data migrations need the core layer to exist first (see README.rrs.md),
+# which an empty database lacks.
 docker run --rm --network $NET -u root \
     -e SECRET_KEY=ci-only \
     -e GIT_AUTHOR_NAME=ci -e GIT_AUTHOR_EMAIL=ci@example.com \
@@ -40,4 +44,7 @@ docker run --rm --network $NET -u root \
         su layers -s /bin/sh -c "set -e
             git clone -q https://git.openembedded.org/bitbake /opt/workdir/https___git_openembedded_org_bitbake
             pip3 install -q --user --no-warn-script-location -r /src/requirements-dev.txt
-            python3 -m pytest -rfE -p no:cacheprovider tests/"'
+            python3 -m pytest -rfE -p no:cacheprovider tests/
+            export ENABLE_RRS=1
+            python3 manage.py makemigrations --check --dry-run rrs
+            python3 -m pytest -rfE -p no:cacheprovider --nomigrations tests/rrs/"'
diff --git a/tests/rrs/conftest.py b/tests/rrs/conftest.py
new file mode 100644
index 0000000..060f2ef
--- /dev/null
+++ b/tests/rrs/conftest.py
@@ -0,0 +1,52 @@
+# layerindex-web - fixtures for the tests that need the RRS app
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+# RRS is optional (ENABLE_RRS=1 in docker/settings.py). Without it these tests
+# are not collected; docker/run-tests.sh runs them in a second pass with it.
+
+import datetime
+import types
+
+import pytest
+from django.conf import settings
+
+if 'rrs' not in settings.INSTALLED_APPS:
+    collect_ignore_glob = ['test_*.py']
+
+
+@pytest.fixture
+def rrs_plan(db):
+    """A maintenance plan "OE-Core" on the core layer's master branch, with
+    release 6.2 and its milestone M1 (October to December 2026)"""
+    from layerindex.models import Branch, LayerBranch, LayerItem
+    from rrs.models import (
+        Maintainer,
+        MaintenancePlan,
+        MaintenancePlanLayerBranch,
+        Milestone,
+        Release,
+    )
+
+    # Created by rrs/migrations/0001_initial.py, which --nomigrations skips
+    for name in ('No maintainer', 'All'):
+        Maintainer.objects.get_or_create(name=name)
+
+    branch, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layer = LayerItem.objects.create(name='openembedded-core', status='P', layer_type='A',
+                                     summary='Core metadata', description='Core metadata',
+                                     vcs_url='https://git.example.com/openembedded-core')
+    layerbranch = LayerBranch.objects.create(layer=layer, branch=branch)
+    plan = MaintenancePlan.objects.create(name='OE-Core')
+    MaintenancePlanLayerBranch.objects.create(plan=plan, layerbranch=layerbranch)
+    release = Release.objects.create(plan=plan, name='6.2', start_date=datetime.date(2026, 10, 1),
+                                     end_date=datetime.date(2027, 4, 30))
+    milestone = Milestone.objects.create(release=release, name='M1',
+                                         start_date=datetime.date(2026, 10, 1),
+                                         end_date=datetime.date(2026, 12, 31))
+    return types.SimpleNamespace(layerbranch=layerbranch, plan=plan, release=release,
+                                 milestone=milestone)
diff --git a/tests/rrs/test_views.py b/tests/rrs/test_views.py
new file mode 100644
index 0000000..c494861
--- /dev/null
+++ b/tests/rrs/test_views.py
@@ -0,0 +1,52 @@
+# layerindex-web - smoke tests for the RRS pages
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+#
+# AI-generated, Claude Opus 5.5
+
+import datetime
+
+import pytest
+
+from rrs.models import RecipeSymbol, RecipeUpgrade
+
+PAGES = ['recipes', 'recipesreport', 'maintainers', 'stats']
+
+
+@pytest.fixture
+def busybox(rrs_plan):
+    symbol = RecipeSymbol.objects.create(layerbranch=rrs_plan.layerbranch, pn='busybox',
+                                         summary='Tiny versions of many common UNIX utilities')
+    date = datetime.datetime(2026, 11, 1)  # USE_TZ is False
+    RecipeUpgrade.objects.create(recipesymbol=symbol, version='1.37.0', author_date=date,
+                                 commit_date=date, upgrade_type='U')
+    return symbol
+
+
+def test_front_page_redirects_to_the_recipe_list(client, rrs_plan):
+    response = client.get('/rrs/')
+    assert response.status_code == 302
+    assert response['Location'].startswith('/rrs/recipes/OE-Core/')
+
+
+@pytest.mark.parametrize('page', PAGES)
+def test_milestone_pages(client, busybox, page):
+    response = client.get(f'/rrs/{page}/OE-Core/6.2/M1/')
+    assert response.status_code == 200
+
+
+def test_recipe_list_shows_the_recipe(client, busybox):
+    response = client.get('/rrs/recipes/OE-Core/6.2/M1/')
+    assert [item.name for item in response.context['recipe_list']] == ['busybox']
+
+
+def test_recipe_detail(client, busybox):
+    response = client.get(f'/rrs/recipedetail/OE-Core/{busybox.pk}/')
+    assert response.status_code == 200
+    assert b'busybox' in response.content
+
+
+def test_unknown_milestone_is_404(client, rrs_plan):
+    assert client.get('/rrs/recipes/OE-Core/6.2/M9/').status_code == 404
-- 
2.56.1

