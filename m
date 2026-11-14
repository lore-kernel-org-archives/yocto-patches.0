Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5905.1794631245470312714
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 20:40:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=YvK6e1KL;
 spf=pass (domain: gmail.com, ip: 209.85.215.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1556801a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 20:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794631245; x=1795236045; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MBDLhGy4lbZxTDJWllRpCivghMA1+ONeJXcpSDrYq8=;
        b=YvK6e1KLNwWIO43glbT1uiFeStrpPCYXQnXk9tBwnTV8dTzuXlB0F2Wk3McPmxPwtf
         AvfIXVfj5WA+9mBO12IOd2A6IZvHPJDNo48qnuaqO7dlMKByMsVieqizqxD/kNUm7Axs
         0JAplWIAF15GhK4iJZbiLEkFhsUjkS+MefGG2i6GbrhyVHxOk/QWxQCZam/i7gj9onIn
         smgCsAs7WnqhobiEnHpjlXsq7pyTaEA3Q5A+m+EbopFAjtrgo9/akIwA2/p1OvAVBvQb
         leLF8BaKa/8kjzX9ZLDJpLaNKVeHUBtj4YQwUCnBz73Og4Ub1HjAi/d/Bq77iN0b95yx
         6frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794631245; x=1795236045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MBDLhGy4lbZxTDJWllRpCivghMA1+ONeJXcpSDrYq8=;
        b=lI1af+QB0dnCSdYlX1KpYDm1wUh+nk05EN8yu86gRILMkZ4sqBtFQU/xYYVWdhFgpG
         6nm/ppTs0ilvhKiduYEl9LRagfWl85oDVj+9TR8mM5djT2ND/9bcJSWe1P25NnpONOOq
         KLGhQBFWdGQWHsOdp3IvPkqQbVEU5V2e9ErnfCpSjZZX5jnpWJvktX9mNL2geVuFvfeY
         Jjw3c82DozeT4bUd3qd5EDueAKSARYe1LEQxVdkKBxseXtsCO9doXNJjZSoe5AiDaUW7
         KUBq98sXtbdUoADq6XWyp4rCkhDrxwH7UhQDcARKvQKz/m6Izt9XPy4Eqy8HXPsNnqG3
         rTYA==
X-Gm-Message-State: APuU4Z8HyfvF3Tdp68DG548ZwjZfcLt+rNbcC11kePGCJvObtcJn70si
	OgntxYY9BfDKk7TFHNXfs8tzoPvUwojFb5hUn9CphGzMWmqhYGGtmvsdhBtv0w==
X-Gm-Gg: AYBFou2HgXsMuqDBsNlMfpKFm3BmGGMAmXFfSNORJz9WNKhmZwe7hM384U6pN3gORva
	Nk4/uFuyNQfXTjvuKhCuPqsqqIEUeb0D5CwbQQgFRdgxKVN9Ffh+t6xdxw1nrPJOfwZaX9sfik3
	685K8BSpJ4iHUA0p821YjCnoK3iY4JzpiWMFSKyL4G4I5K25qh46t4g6hDHTznky7NhWkrgPfGo
	lKqKUWHJuqRmJqIaGwAT6TAAQ53Dmz2bZLmTonUqucg4isMygxqXEdzxoWVS//ER5hjcTWGDJsw
	Ti536WiQczpzj25kgctEkpmq8eQik0mHQbaT8h+iZPI3ECCuI9lrPMKQB7rCA7sRV9zwA2n2Xrt
	QzBQV7qXVpbDGc0xhwbxOjySHoSscTnILIdGg9/6ebDbDNB8c/IyzciWT597TgeFmFq34NRWHoI
	N/bxCcRYfKbxFlZbfEtuIQj0WdEDvCLUIvqHBiUEzOG4RGbn8O9SS0/Xf1u/wU4l/ACDq6r0e5c
	c8uA+qCFamEu8AkUY8EcFYjUHuoMxjZq8QWayyTilplD3p6zwPE8g9JGRIVGMsO4SzSSEwSUZan
	B14fw4EyKkxeucars8D7Xnluj2tUP3jARYXHLu0IhFUBUrm1a+F2y4ue8W5HAAkyO1ZCyR/nVyg
	0INHuLow=
X-Received: by 2002:a17:90b:4d06:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3b1b0ba1321mr4050872a91.25.1794631244563;
        Fri, 13 Nov 2026 20:40:44 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186fc72sm2165693a12.5.2026.11.13.20.40.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:40:43 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] update_layer: don't parse distro configuration into the recipe datastore
Date: Fri, 13 Nov 2026 20:40:34 -0800
Message-ID: <20261114044035.88470-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114044035.88470-1-tim.orling@konsulko.com>
References: <20261114044035.88470-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 04:40:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5365
Content-Type: text/plain; charset="utf-8"

To index a layer's distros, update_layer.py parsed each distro
configuration file into the datastore it then uses to parse the layer's
recipes, so every recipe parsed after it got that distro's
configuration. For meta-luneos, image recipes then failed with
"NameError: name 'oebackport' is not defined" from a LuneOS variable.
Parse each distro configuration file into a copy instead.

[YOCTO #16497]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/update_layer.py |  4 +++-
 tests/test_distro_conf.py  | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_distro_conf.py

diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 0f49371..3f21e8b 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -248,7 +248,9 @@ def update_distro_conf_file(path, distro, d):
 
     distro_name = ''
     try:
-        d = utils.parse_conf(path, d)
+        # Parse into a copy: d is also used to parse the layer's recipes,
+        # which must not get this distro's configuration
+        d = utils.parse_conf(path, d.createCopy())
         distro_name = d.getVar('DISTRO_NAME', True)
     except Exception as e:
         logger.warn('Error parsing distro configuration file %s: %s' % (path, str(e)))
diff --git a/tests/test_distro_conf.py b/tests/test_distro_conf.py
new file mode 100644
index 0000000..8d7c22a
--- /dev/null
+++ b/tests/test_distro_conf.py
@@ -0,0 +1,47 @@
+# layerindex-web - test that indexing a distro configuration file doesn't
+# change the configuration used to parse recipes
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import os
+import sys
+import types
+
+import pytest
+
+basepath = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
+
+
+@pytest.fixture
+def bb_data(settings):
+    from layerindex.models import LayerItem
+    bitbakepath = os.path.join(settings.LAYER_FETCH_DIR,
+                               LayerItem(vcs_url=settings.BITBAKE_REPO_URL).get_fetch_dir())
+    if not os.path.isdir(os.path.join(bitbakepath, 'lib', 'bb')):
+        pytest.skip('BitBake not fetched to %s' % bitbakepath)
+    for path in (os.path.join(bitbakepath, 'lib'), os.path.join(basepath, 'layerindex')):
+        if path not in sys.path:
+            sys.path.insert(0, path)
+    import bb.data
+    import bb.parse
+    import utils
+    utils.bb = sys.modules['bb']
+    return bb.data
+
+
+def test_distro_conf_not_parsed_into_recipe_data(bb_data, tmp_path):
+    import update_layer
+    conf = tmp_path / 'conf' / 'distro' / 'testdistro.conf'
+    conf.parent.mkdir(parents=True)
+    conf.write_text('DISTRO_NAME = "Test Distro"\nLEAKCHECK = "from the distro"\n')
+    d = bb_data.init()
+    d.setVar('LEAKCHECK', 'original')
+    distro = types.SimpleNamespace(description='')
+
+    update_layer.update_distro_conf_file(str(conf), distro, d)
+
+    assert distro.description == 'Test Distro'
+    # Recipes parsed with d afterwards must not see the distro's settings
+    assert d.getVar('LEAKCHECK') == 'original'
-- 
2.56.0

