Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5906.1794631248688097054
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 20:40:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=GOQtIl/v;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1698975a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 20:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794631248; x=1795236048; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kzp6l9DlV0zDaZcrru4Tv3p4ksV0IWckTKIULqjoxTA=;
        b=GOQtIl/vPsiIRmQyKvAdfXsHEaEu1jOUs6z1Iz3awEj4avQXy63od40aVmtU4Dpi6L
         RTBlZRyQfnW2Cc/CSUi2+hVRIhFnUxj2yO5gxnIRJvg36hvwff3XiDwffDzVeoxLYSnw
         ceBJ4F4GBDY8ZlF76YfK84d7rs/ag0WQD2x8wy0NbjY76I6mxIsFGM8UMyUnvHJv5ub+
         4MK2Wdl1Hx3iHb1CXZLgTvgC669rDXJsSxvDjq359x/mF+FXeBPfN0frDSasoqgjuFVu
         MXJgrujkx6n1pkgbs8WFWJF5fv4xXXpPy3kjrMCNgKwN4EzRlHVgecQ9cL6VCLFr5XaO
         DNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794631248; x=1795236048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kzp6l9DlV0zDaZcrru4Tv3p4ksV0IWckTKIULqjoxTA=;
        b=CS7efsETefkNc6kuG31oIPEgmttDRKGp7Qu7dUPXUDlm+UXQynjrWFhkQfTnHfXhuE
         LwV0wr1D5vBqr/AFHvH+8a60M8DtSN6TEAeAf4DT997mwOKfs+JeQseLxg9AVcOBG7oE
         t9xVXva3AOlJxLuKaMz6CugB36fvt84QQ94GOMmi7+YbAd+yn/eFY/swSsfsbhMbYN3A
         JRoV8id1yL8F2Ei4PCM0uakubwg4wYK0NVFpA6uCKODDtalZknpy2ZC/8AAwAiDvHiqh
         jBa6bYgvguzEd0n8+DGVueiRtJW10iI/eDbJv7nPEMBBKkYotinDQkBgx/B9XFyfDXgI
         ltyw==
X-Gm-Message-State: APuU4Z9iC/nNQoJHSO9ThN5wwLwjZEc/AFWEtu3DSfJsqpZG1hI1R3PR
	MYAo7lP02PpAnzP5F4zMfaUHfZaPPsQzHSlUQ9N3eDEtOm/qOPEfvviTSwHS/tXm
X-Gm-Gg: AYBFou1hxL+zmQrlhM3C4S/x/SSY+LajV9WcZXKgdM/bQTkE05GrZxzqvztoAqy82En
	3rXXvCBqng6HGkEUdiP3G/COr0VQBUnUDMsyOgh3Q5bbHOd5WhAa7UEaag/BDLceoLJx9JgGgfz
	mlK77kBMsMZRuuu17QWKJU6FJj8FDQCN5/RWGNAKflFkk12XCERXt58R+uHMFnh4uni3qUK7xMV
	oN5TzzhXL8L3/PNoVQfmH9V4SHdkS/Tu4b+nYRNQTFDp/ym7HuM92X4j1iFoQcdZ/gQrYEBtyD5
	VlLpr2vnlsTxhRRjP033sTmjvHTjElSFDahE1Yw2I9IJQykmr7M2q7Tf+T0WRhC/6ROFYLWihV6
	xNV0j2gN2wHmlxA+GxF+izP0gbjFQwtZmCt+C3qnH7gsBku6alBz+/KLKNgy8nMBeQJ8r0Z6Oto
	rILq95fLVKOrEoEwwFcMA37DEM4x14GvbSGIhvIbYcGxmMzj7WtIeRZL0bgxc3RJebezs6P+5Ke
	vnU3JxUH04NfYywE3R/TJUr78VEnzgUGH68dIjWmeacVr+tKkvWjZ71ZT7jby/IBsfYJMyWOd8X
	cnfOhWlgqddkEZImNHfY9ICYvbQoOgsrxULuky5WAJe/W3eTPm0JaOZrVWXX2g==
X-Received: by 2002:a17:90b:440b:b0:3b0:99f8:72f4 with SMTP id 98e67ed59e1d1-3b197d54b53mr5875497a91.23.1794631247998;
        Fri, 13 Nov 2026 20:40:47 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186fc72sm2165693a12.5.2026.11.13.20.40.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:40:46 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] update_layer: make addpylib libraries available to recipe parsing
Date: Fri, 13 Nov 2026 20:40:35 -0800
Message-ID: <20261114044035.88470-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114044035.88470-1-tim.orling@konsulko.com>
References: <20261114044035.88470-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 04:40:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5366
Content-Type: text/plain; charset="utf-8"

A recipe that uses a Python library added with addpylib in its layer's
conf/layer.conf failed to parse, e.g. meta-luneos with "NameError: name
'oebackport' is not defined". update_layer.py parses layer.conf itself,
but the recipes are parsed by the BitBake server, which only processes
addpylib in its base configuration, so the library was never imported
there. Add the addpylib statements of the layer and its dependencies to
the bblayers.conf the server reads.

[YOCTO #16192]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/recipeparse.py  | 23 ++++++++++++++++++++++-
 layerindex/update_layer.py |  9 ++++++++-
 tests/test_update.py       | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/layerindex/recipeparse.py b/layerindex/recipeparse.py
index d8486e7..4d91d77 100644
--- a/layerindex/recipeparse.py
+++ b/layerindex/recipeparse.py
@@ -24,7 +24,24 @@ class RecipeParseError(Exception):
 
 
 
-def init_parser(settings, branch, bitbakepath, enable_tracking=False, nocheckout=False, classic=False, logger=None):
+def layer_addpylibs(layerdir):
+    """
+    Return the addpylib statements in a layer's conf/layer.conf, with LAYERDIR
+    expanded. The BitBake server only processes addpylib while parsing its base
+    configuration, so these need to go in bblayers.conf for its recipe parsing
+    to be able to use the libraries.
+    """
+    lines = []
+    try:
+        with open(os.path.join(layerdir, 'conf', 'layer.conf')) as f:
+            for line in f:
+                if re.match(r'\s*addpylib\s', line):
+                    lines.append(line.strip().replace('${LAYERDIR}', layerdir))
+    except FileNotFoundError:
+        pass
+    return lines
+
+def init_parser(settings, branch, bitbakepath, enable_tracking=False, nocheckout=False, classic=False, logger=None, pylib_layerdirs=None):
     if not (nocheckout or classic):
         # Check out the branch of BitBake appropriate for this branch and clean out any stale files (e.g. *.pyc)
         if re.match('[0-9a-f]{40}', branch.bitbake_branch):
@@ -86,6 +103,10 @@ def init_parser(settings, branch, bitbakepath, enable_tracking=False, nocheckout
             # We need this to avoid problems with AVAILABLE_LICENSES
             f.write('COREBASE = "%s"\n' % core_repodir)
             f.write('BBLAYERS = "%s"\n' % core_layerdir)
+            # Python libraries of the layer being parsed and its dependencies
+            for layerdir in pylib_layerdirs or []:
+                for line in layer_addpylibs(layerdir):
+                    f.write(line + '\n')
         pass
 
     if logger:
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 3f21e8b..7e47269 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -428,8 +428,15 @@ def main():
                             logger.warn("Unable to checkout dependent layer %s - %s" % (layerdependency.dependency, str(e)))
 
                 logger.info("Collecting data for layer %s on branch %s" % (layer.name, branchdesc))
+                # Layers whose addpylib libraries recipes may use (the core
+                # layer's are loaded through BBLAYERS)
+                pylib_layerdirs = [layerdir]
+                for dep in layerbranch.dependencies_set.all():
+                    deplayerbranch = dep.dependency.get_layerbranch(branch.name)
+                    if deplayerbranch and dep.dependency.name != settings.CORE_LAYER_NAME:
+                        pylib_layerdirs.append(os.path.join(fetchdir, dep.dependency.get_fetch_dir(), deplayerbranch.vcs_subdir))
                 try:
-                    (tinfoil, tempdir) = recipeparse.init_parser(settings, branch, bitbakepath, nocheckout=options.nocheckout, logger=logger)
+                    (tinfoil, tempdir) = recipeparse.init_parser(settings, branch, bitbakepath, nocheckout=options.nocheckout, logger=logger, pylib_layerdirs=pylib_layerdirs)
                 except recipeparse.RecipeParseError as e:
                     logger.error(str(e))
                     sys.exit(1)
diff --git a/tests/test_update.py b/tests/test_update.py
index a0ac897..702a042 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -144,6 +144,26 @@ def test_upgrade_recipe(import_layer, repo, db_access_without_rollback_and_trunc
     assert recipe.filename == 'upgrademe_0.2.bb'
     assert recipe.filepath == 'recipes-example/upgrademe'
 
+def test_addpylib_used_in_recipe(import_layer, repo, db_access_without_rollback_and_truncate):
+    # [YOCTO #16192] a recipe can use a Python library the layer adds with
+    # addpylib in conf/layer.conf, as it can in a build
+    from layerindex.models import LayerBranch, Recipe
+    layerdir = os.path.join(repo, 'meta-layerindex-test')
+    os.makedirs(os.path.join(layerdir, 'lib', 'layerindextestlib'))
+    with open(os.path.join(layerdir, 'lib', 'layerindextestlib', '__init__.py'), 'w') as f:
+        f.write('def summary():\n    return "Summary from addpylib"\n')
+    with open(os.path.join(layerdir, 'conf', 'layer.conf'), 'a') as f:
+        f.write('\naddpylib ${LAYERDIR}/lib layerindextestlib\n')
+    os.makedirs(os.path.join(layerdir, 'recipes-example', 'pylib'))
+    with open(os.path.join(layerdir, 'recipes-example', 'pylib', 'pylib_1.0.bb'), 'w') as f:
+        f.write('SUMMARY = "${@layerindextestlib.summary()}"\nLICENSE = "MIT"\n')
+    run_cmd('git add -A && git commit -m "Add a recipe that uses addpylib"', cwd=repo)
+    run_cmd("layerindex/update.py -d -l meta-layerindex-test --nofetch --nocheckout")
+    layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test')
+    recipe = Recipe.objects.filter(layerbranch=layerbranch, pn='pylib').first()
+    assert recipe, 'pylib recipe not found'
+    assert recipe.summary == 'Summary from addpylib'
+
 def test_add_recipe(import_layer, repo, db_access_without_rollback_and_truncate):
     from layerindex.models import LayerBranch, Recipe
     layerbranch = LayerBranch.objects.get(layer__name='meta-layerindex-test')
-- 
2.56.0

