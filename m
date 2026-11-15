Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7560.1794702933215221601
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=fR/YSCLg;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2059125a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702932; x=1795307732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H269tTLNyZkqNS3gkiZLESQ/LQl4VTTA4YBp8IkThLI=;
        b=fR/YSCLgHvJS6Enf5v9+ouvsCn1jqJCrVGkoIxKTh1zrS74dtUGaRPVkk5h6TNWNtk
         n0s/T+N4osKhBNy2ZETvt5e6nIQjWV1zmZd6Dk0t7yrwDwSrnvC4lCe5VNCCHLIYBwP/
         VqN4I0fGQClMwIMJbNZUNhYwfG0XR6s7cPp/DUVrOnka0RLeEK5aHFSbkCtm3HnMPzjF
         b1rH/H/zavRVLqhV6VSVmBkN5GZajdXzyo0WXNzqMUh1IACfp9FJhb3KzomfsQ8dH9on
         tMJViV/R5SBIACKdCDxweuHOJnX9puPbbxWgnjCjkNizVd0uBP8SCvTg36DynGhNrwCw
         XXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702932; x=1795307732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H269tTLNyZkqNS3gkiZLESQ/LQl4VTTA4YBp8IkThLI=;
        b=getNAxtzF2zul3eYVVc93w43bhh9it/Pta/2AFc7j17h3eOMcUj2d5jV1WDQxYtuxp
         PJSwl41knY2JxuNcXEhAp7KH4J920X2GLL3brc6erlK2j7wcsHcgCusnw+kj8wKff/b/
         8MZ0FfIYQDDv4UW1EMceHVe+qegIbGFkq1xfR16ZRSDWuxgI/QQuxISoPtimHeLW+mCG
         8UU85uf5QHhAT6J7qLhTM+XzcnoVKKhkWcda4aEtyZ32Xw/OOuLudhzX6izavpmZdIYt
         yfjV+r5ITZNAV5bkQAYwh+IrfBQAOESfyaL4ekSbOMXcYc047GOuMuQ5B80OaiNxGDsN
         x/jA==
X-Gm-Message-State: APuU4Z9s34tuD6qt5/GuiifJUeNQkPWFBv2wzV0/zbdIvLZu8/KSt6dw
	ZulNgvW7WH0NRm6pZIQiNyhyd7554qskiqSpvS2TTgcSu0O4rHMHtwY+wrFwBA==
X-Gm-Gg: AYBFou3n6GBDwJ1hosxwJLlKrMmp9Y4vNWvbYDlmrpnbWmnqbTlIqB4dEMShWXwI4EU
	p6NnDL9bbtxOUEKkkt/Hhny+rmQdIkrNlKEflLSdJ0CLMXyHf0Cir3cN8kGB3kNPr2z6BatgFXx
	HocbIRXCtgGTvr3JyQZmrguW9Mz5pfIqgRS3ZJ7yWOTZpiMpra/psUxaD8x9u2A1LCr8iPaLf5x
	uUKjxnJCQWMSYGzxuo5aIBwBY2LS3Jlf5bYH/0DiRL0hDQ7/t4p9K7DNgUFpWLDhzbFKwESDeQ9
	0XC9b1ErKUiB3HmlRNAFta3Wz7A9RFeUEQ+3FESt++78Ka6FdDXnyR84+h/8TQcbOr+bjwvb2qD
	32innQSDdmVyaiccQpWZ+5/+mtS6cUbd/lv2uPm7iod/YV5BZi/Z69sku9m1JktmlHjkcfZlPpT
	mFpnttm+46ElbSLsQ5b5lDyol5Cvu989GCKJdhmGaNIC3PKrVGEJoUh2usDzosM/1v1lkTDbiok
	uqC4GJxth6aLb0Bz7N5W6T1heILIgGyXTaknJdeu5dFGyeue0kN8ayvcGsfG5fZfpxRP7t+w9Fp
	T4XCq4dPAFABgKC3H19iWXmXj3KavSQm5Ei67oP8OEzD0iPvix5/NwmqeO15rV0=
X-Received: by 2002:a17:90b:5910:b0:3b0:a378:1cf with SMTP id 98e67ed59e1d1-3b1b09e7b8dmr5793688a91.22.1794702932487;
        Sat, 14 Nov 2026 16:35:32 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:31 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/6] rrs/tools/common.py: check out the layer branch before parsing it
Date: Sat, 14 Nov 2026 16:35:04 -0800
Message-ID: <20261115003506.53654-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5382
Content-Type: text/plain; charset="utf-8"

load_recipes() let init_parser() check out BitBake and the core layer,
but not the layer itself or the layers it depends on, so
rrs_upstream_history.py and rrs_distros.py parsed whichever branch the
layer index updates had left them on, e.g. meta-openembedded at dunfell
while working on master. Check out the layer branch and its
dependencies' unless nocheckout is set.

[YOCTO #16502]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/common.py            | 13 +++++++++-
 tests/test_rrs_load_recipes.py | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/rrs/tools/common.py b/rrs/tools/common.py
index ccdbe62..f97d4e1 100644
--- a/rrs/tools/common.py
+++ b/rrs/tools/common.py
@@ -92,7 +92,7 @@ def get_recipe_files(layerdir):
 
 def load_recipes(layerbranch, bitbakepath, fetchdir, settings, logger,
         recipe_files=None, nocheckout=False):
-    from layerindex import recipeparse
+    from layerindex import recipeparse, utils
 
     try:
         (tinfoil, tempdir) = recipeparse.init_parser(settings,
@@ -110,6 +110,17 @@ def load_recipes(layerbranch, bitbakepath, fetchdir, settings, logger,
     repodir = os.path.join(fetchdir, urldir)
     layerdir = os.path.join(repodir, str(layerbranch.vcs_subdir))
 
+    if not nocheckout:
+        # The repositories are left on whichever branch was updated last;
+        # check out this branch of the layer and of the layers it depends on
+        # (init_parser() has done BitBake and the core layer)
+        utils.checkout_layer_branch(layerbranch, repodir, logger=logger)
+        for dep in layerbranch.dependencies_set.all():
+            deplayerbranch = dep.dependency.get_layerbranch(layerbranch.branch.name)
+            if deplayerbranch:
+                utils.checkout_layer_branch(deplayerbranch,
+                        os.path.join(fetchdir, dep.dependency.get_fetch_dir()), logger=logger)
+
     d = recipeparse.setup_layer(tinfoil.config_data, fetchdir, layerdir,
             layer, layerbranch, logger)
 
diff --git a/tests/test_rrs_load_recipes.py b/tests/test_rrs_load_recipes.py
index 97f3d26..8322350 100644
--- a/tests/test_rrs_load_recipes.py
+++ b/tests/test_rrs_load_recipes.py
@@ -33,3 +33,48 @@ def test_load_recipes_checks_out_bitbake_before_importing_it(monkeypatch):
     with pytest.raises(Stop):
         common.load_recipes(types.SimpleNamespace(branch=None), '/nonexistent', '/nonexistent',
                             types.SimpleNamespace(), None)
+
+
+@pytest.mark.django_db
+@pytest.mark.parametrize('nocheckout', [False, True])
+def test_load_recipes_checks_out_the_layer_branch(monkeypatch, nocheckout):
+    # [YOCTO #16502] parse the branch being worked on, not whichever branch
+    # the repositories were left on
+    import common
+    monkeypatch.syspath_prepend(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'layerindex'))
+    from layerindex import recipeparse, utils
+    from layerindex.models import Branch, LayerBranch, LayerDependency, LayerItem
+
+    master, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layers = {}
+    for name in ('meta-oe', 'meta-python'):
+        layer = LayerItem.objects.create(name=name, status='P', layer_type='A', summary=name,
+                                         description=name, vcs_url='git://example.com/%s.git' % name)
+        layers[name] = LayerBranch.objects.create(layer=layer, branch=master, actual_branch='main')
+    LayerDependency.objects.create(layerbranch=layers['meta-oe'], dependency=layers['meta-python'].layer)
+
+    class Stop(Exception):
+        pass
+
+    def fake_setup_layer(*args, **kwargs):
+        raise Stop()
+
+    # load_recipes() imports bb.fetch once init_parser() has checked out BitBake
+    bb = types.ModuleType('bb')
+    bb.fetch = types.ModuleType('bb.fetch')
+    bb.fetch.FetchError = Exception
+    monkeypatch.setitem(sys.modules, 'bb', bb)
+    monkeypatch.setitem(sys.modules, 'bb.fetch', bb.fetch)
+
+    checkouts = []
+    monkeypatch.setattr(recipeparse, 'init_parser', lambda *args, **kwargs: (types.SimpleNamespace(config_data=None), '/tmp'))
+    monkeypatch.setattr(recipeparse, 'setup_layer', fake_setup_layer)
+    monkeypatch.setattr(utils, 'checkout_repo', lambda repodir, ref, logger=None: checkouts.append((os.path.basename(repodir), ref)))
+    with pytest.raises(Stop):
+        common.load_recipes(layers['meta-oe'], '/bitbake', '/fetch', types.SimpleNamespace(), None,
+                            recipe_files=[], nocheckout=nocheckout)
+    if nocheckout:
+        assert checkouts == []
+    else:
+        assert checkouts == [('git___example_com_meta-oe_git', 'origin/main'),
+                             ('git___example_com_meta-python_git', 'origin/main')]
-- 
2.56.1

