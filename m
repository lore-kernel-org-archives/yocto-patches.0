Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5864.1792445722706522357
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 14:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eePFpwqJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89d6bd67045so49563b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445722; x=1793050522; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0ilYJ69NZHzfNWIgFCKxy5rvc04Si6r3HLP9kL8JRU=;
        b=eePFpwqJ6dGnoQagIeaKS6zy6j48mMeuHnePcsYZdK61eOKRlydOWz2gMGJz39EkF3
         VIKqBBWtIWzu7EMOgMmzHMVzCFDGEhNoUtMhOEo5qN3ZT5H0Z/hmPvP6gCA2DcYmKd4A
         ZiRF1talR87DWGn1VvZ/nAQLcC0Ktgq7nqirSeH8USaYJCOQr77rWv6zIsGz1wi/wV0e
         DeO6CknFtEaCUk4KYbm5+Yf4IOMtL1/b8kH+b4mKtgKDDePSJ1bixMxpDXbur4ylLiSP
         jPDGPJHSQTLjTlXkh3/VlP//e5KaUhq9+Vvfpj1M/S84OYf9iUERIRQglszjxXCVo0nE
         C9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445722; x=1793050522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0ilYJ69NZHzfNWIgFCKxy5rvc04Si6r3HLP9kL8JRU=;
        b=Nc7TN2pXlv+FVS7sEtknicQRa4u33bYymM8tBVpesQJuZ+ZnKu8OA6VLlFhqg46NpK
         P1mUZrUonM48O5IrRCveL//mhYHNFaED9btaPHpc+Y+nBva1p0nyraQpEwUov3LsMlbn
         NwQnPJweeKJ+PFr6ruwaCj94HLV9O/CGlzzHCw0A6geFxJP/tG4iJ8NAqATsOldqgHhk
         T/YJzE7ZDBBQis/TOOSi1SkyaItTS2G1eJRTY9d/j8ZgWvIdKRVhA0heE2kgaZxMB9xf
         uYdWrcw522RQ6m/32gWa1uoNeSaI+SMkKQWG1u+GX2lZLTvcBHbsnvBTvsZ47RKuynWe
         OHyg==
X-Gm-Message-State: AFq9FYKHufybhhfGAWMi8SC/gS7C4KdMK4pF9pCMapcLjISOzJZz2WD7
	uUcEYiAREEsPe6wuY6EV5kozCJ3nqTCVqqbxqHYnjFuvvJeogjZczdLWfRCDBKBY
X-Gm-Gg: AYBFou0/YTOdtLeSPbB7ukpZsHyWElqB3qM0x4kv6qc90hmsmA+ouhHN7vp2wXxRqN+
	oOzqXyjE6ecJOynhPsltEii9qwqda3Eoll1g5ggBXQYabroejVod7tYaiVPbwUkqHDYMsAZoRdm
	AvYTHUsAUJTEUPzjFBNuNxxNnY+Vas/UBKAKW3Kgb8jfZXVUKlyqA0Lxq9UCQGUBvpICw+p76Tg
	4Au1rdfle1qjB3eBXmA3imhykVjofeiFCAF2tCUdbO9LnClcaDMdHVUFUj14CDpmK9IbXI4Cfmi
	OQ51DMn8ETM2w+Ranvifjk0ljH5GGDQT5w2m+5OrOfcre/H9VSNvwU0IKXs06BEANl71aJ7VgEI
	ziFNuEDo/jPoIz3sb2WJEAo9VA8wqHSa0coZo63P/wnOkzVHo/qzrXhRGUO/Ybp+LXOQY74mxDP
	nqCQX5Gfc3/jK9AZjPFS0SjAm7HPLMRcWzsvWE9aekVKdz12PmOZLcpKhzMOQwoN0FijIkmwAND
	wC14yM3BVcEwJuh1kfU3ulwHCC5dXtcvHKgWGTxnw==
X-Received: by 2002:a05:6a00:3908:b0:8a0:6417:8f9b with SMTP id d2e1a72fcca58-8a07c01b24emr212045b3a.32.1792445721876;
        Mon, 19 Oct 2026 14:35:21 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm4307747b3a.53.2026.10.19.14.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 14:35:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] update_layer.py: skip layers within a layer on incremental updates
Date: Mon, 19 Oct 2026 14:35:07 -0700
Message-ID: <20261019213510.4384-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213510.4384-1-tim.orling@konsulko.com>
References: <20261019213510.4384-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 21:35:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5101
Content-Type: text/plain; charset="utf-8"

On incremental updates the check for layers within a layer compared
repository-relative git diff paths with absolute directory paths, so it
never matched, and files in nested layers (e.g. meta-voltumna's vendored
copies of oe-core and meta-openembedded) were indexed as part of the
outer layer. Move the check into utils.nested_layer_dirs() and
utils.in_nested_layer(), use it for all change types, and treat renames
into a nested layer as deletes.

Records already indexed this way are removed by a full rescan
(update.py -r).

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/update_layer.py | 39 ++++++++-------------------------
 layerindex/utils.py        | 22 +++++++++++++++++++
 tests/test_utils.py        | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 55b3e14..441efc2 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -494,11 +494,7 @@ def main():
                 layerrecipes_add = []
 
                 # Check if any paths should be ignored because there are layers within this layer
-                removedirs = []
-                for root, dirs, files in os.walk(layerdir):
-                    for diritem in dirs:
-                        if os.path.exists(os.path.join(root, diritem, 'conf', 'layer.conf')):
-                            removedirs.append(os.path.join(root, diritem) + os.sep)
+                removedirs = utils.nested_layer_dirs(layerdir)
 
                 if diff:
                     # Apply git changes to existing recipe list
@@ -515,19 +511,17 @@ def main():
                     for diffitem in diff.iter_change_type('R'):
                         oldpath = diffitem.a_blob.path
                         newpath = diffitem.b_blob.path
-                        skip = False
-                        for removedir in removedirs:
-                            # FIXME what about files moved into removedirs?
-                            if oldpath.startswith(removedir):
-                                skip = True
-                                break
-                        if skip:
+                        if utils.in_nested_layer(oldpath, removedirs, repodir):
                             continue
                         if oldpath.startswith(subdir_start):
                             if not newpath.startswith(subdir_start):
                                 logger.debug("Treating rename of %s to %s as a delete since new path is outside layer" % (oldpath, newpath))
                                 other_deletes.append(diffitem)
                                 continue
+                            if utils.in_nested_layer(newpath, removedirs, repodir):
+                                logger.debug("Treating rename of %s to %s as a delete since new path is in a layer within this layer" % (oldpath, newpath))
+                                other_deletes.append(diffitem)
+                                continue
                             (oldtypename, oldfilepath, oldfilename) = recipeparse.detect_file_type(oldpath, subdir_start)
                             (newtypename, newfilepath, newfilename) = recipeparse.detect_file_type(newpath, subdir_start)
                             if oldtypename != newtypename:
@@ -606,12 +600,7 @@ def main():
                     for diffitem in itertools.chain(diff.iter_change_type('D'), other_deletes):
                         path = diffitem.a_blob.path
                         if path.startswith(subdir_start):
-                            skip = False
-                            for removedir in removedirs:
-                                if path.startswith(removedir):
-                                    skip = True
-                                    break
-                            if skip:
+                            if utils.in_nested_layer(path, removedirs, repodir):
                                 continue
                             (typename, filepath, filename) = recipeparse.detect_file_type(path, subdir_start)
                             if typename == 'recipe':
@@ -636,12 +625,7 @@ def main():
                     for diffitem in itertools.chain(diff.iter_change_type('A'), other_adds):
                         path = diffitem.b_blob.path
                         if path.startswith(subdir_start):
-                            skip = False
-                            for removedir in removedirs:
-                                if path.startswith(removedir):
-                                    skip = True
-                                    break
-                            if skip:
+                            if utils.in_nested_layer(path, removedirs, repodir):
                                 continue
                             (typename, filepath, filename) = recipeparse.detect_file_type(path, subdir_start)
                             if typename == 'recipe':
@@ -685,12 +669,7 @@ def main():
                     for diffitem in diff.iter_change_type('M'):
                         path = diffitem.b_blob.path
                         if path.startswith(subdir_start):
-                            skip = False
-                            for removedir in removedirs:
-                                if path.startswith(removedir):
-                                    skip = True
-                                    break
-                            if skip:
+                            if utils.in_nested_layer(path, removedirs, repodir):
                                 continue
                             (typename, filepath, filename) = recipeparse.detect_file_type(path, subdir_start)
                             if typename == 'recipe':
diff --git a/layerindex/utils.py b/layerindex/utils.py
index e5bad40..fd29de0 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -57,6 +57,28 @@ def get_layer_var(config_data, var, logger):
         value = config_data.getVar(var, True)
     return value or ''
 
+def nested_layer_dirs(layerdir):
+    """
+    Return the directories below layerdir that contain a conf/layer.conf of
+    their own, i.e. other layers within this layer, each with a trailing
+    separator.
+    """
+    dirs = []
+    for root, subdirs, _ in os.walk(layerdir):
+        for subdir in subdirs:
+            if os.path.exists(os.path.join(root, subdir, 'conf', 'layer.conf')):
+                dirs.append(os.path.join(root, subdir) + os.sep)
+    return dirs
+
+def in_nested_layer(path, nested_dirs, repodir):
+    """
+    Check whether path is within one of nested_dirs (as returned by
+    nested_layer_dirs()). path may be relative to repodir, as git diff paths
+    are, or absolute.
+    """
+    fullpath = os.path.join(repodir, path)
+    return any(fullpath.startswith(nested_dir) for nested_dir in nested_dirs)
+
 def is_deps_satisfied(req_col, req_ver, collections):
     """ Check whether required collection and version are in collections"""
     for existed_col, existed_ver in collections:
diff --git a/tests/test_utils.py b/tests/test_utils.py
index 2b9ebcb..95b5e04 100644
--- a/tests/test_utils.py
+++ b/tests/test_utils.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: MIT
 
 import operator
+import os
 import sys
 import types
 
@@ -40,3 +41,47 @@ def fake_bb(monkeypatch):
 ])
 def test_is_deps_satisfied(fake_bb, req_ver, collections, expected):
     assert utils.is_deps_satisfied('core', req_ver, collections) is expected
+
+
+def make_layer(path):
+    (path / 'conf').mkdir(parents=True)
+    (path / 'conf' / 'layer.conf').write_text('')
+
+
+@pytest.fixture
+def repo_with_nested_layers(tmp_path):
+    """A repository whose layer (in subdirectory 'meta-top') contains other
+    layers, as when layers are vendored with git subtree."""
+    repodir = tmp_path / 'repo'
+    layerdir = repodir / 'meta-top'
+    make_layer(layerdir)
+    (layerdir / 'recipes-core' / 'foo').mkdir(parents=True)
+    make_layer(layerdir / 'meta-sub')
+    make_layer(layerdir / 'meta-openembedded' / 'meta-oe')
+    # A directory whose name starts like a nested layer's, but isn't one
+    (layerdir / 'meta-subsidiary' / 'recipes-x').mkdir(parents=True)
+    return str(repodir), str(layerdir)
+
+
+def test_nested_layer_dirs(repo_with_nested_layers):
+    repodir, layerdir = repo_with_nested_layers
+    assert sorted(utils.nested_layer_dirs(layerdir)) == [
+        os.path.join(layerdir, 'meta-openembedded', 'meta-oe') + os.sep,
+        os.path.join(layerdir, 'meta-sub') + os.sep,
+    ]
+
+
+@pytest.mark.parametrize('path, expected', [
+    # Paths relative to the repository, as git diff reports them
+    ('meta-top/meta-openembedded/meta-oe/recipes-a/a/a_1.0.bb', True),
+    ('meta-top/meta-sub/recipes-b/b/b_1.0.bb', True),
+    ('meta-top/recipes-core/foo/foo_1.0.bb', False),
+    ('meta-top/meta-subsidiary/recipes-x/x/x_1.0.bb', False),
+    ('meta-top/meta-openembedded/README', False),
+])
+def test_in_nested_layer(repo_with_nested_layers, path, expected):
+    repodir, layerdir = repo_with_nested_layers
+    nested = utils.nested_layer_dirs(layerdir)
+    assert utils.in_nested_layer(path, nested, repodir) is expected
+    # Absolute paths give the same answer
+    assert utils.in_nested_layer(os.path.join(repodir, path), nested, repodir) is expected
-- 
2.56.0

