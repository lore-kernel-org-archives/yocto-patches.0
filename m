Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7627.1794702926434182393
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=b4D+UPDd;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so1367424a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702926; x=1795307726; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=665cj0vIDvZBoTuppu7mw0+WJXCrB4+Kd0zZU7Qz+D8=;
        b=b4D+UPDde87TUcCfnvAcGfXhB0iPrcPi5viTNzpIm7eXG6bHPJJ/MCffaWczMqJZ1+
         XVmqZ4fL86Pe58MA+6h6xHvpubB2JtcmlIj7QAyt2pRnIZsQb24dS+PkiX2qlDSTyNOS
         bBnWfOXa5tyoO2s4cA4pRp/f56vvTt/mEYXh2xQTpGkE3bIVS/SmhJt6gjqZRdbvqobx
         mymk/C+ovadxf2ykjudx4QAhb4z26h7smEooOVxQ7kEIUhRYzAcbpaARMx5nC8or171Q
         kWg8sEWoES5ZRarjdZFIaK+Iq+DyuLjGXf+Fh4xCJDEFtfyvuO0jrsoFtF+62aWj3MTZ
         1UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702926; x=1795307726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=665cj0vIDvZBoTuppu7mw0+WJXCrB4+Kd0zZU7Qz+D8=;
        b=RQ96VKmfhj4S250uD6DgDSwP6KKme2O1DCfzjecIKRPBIKPQIinBQxPXTuYl7c453c
         BqIrCfkYBCaTNRE6s6bPLxe4frnIIzb3n20eISdVqrgKgfGBNP+uebAn7GlzkeBnFmfp
         n07/oLq677BbQMhq3XiRE1b01sx1UxnamPvyPi4EdudQom4TOj52YZNWiZJezWUmhgUi
         K4IfwZ6I8i35Y9QDueXhcn7zEnyUBejWETh0AnsOmLQeYiwqv1+yU0b2r9TGtHP8qM3I
         Ai00J40vThFMQqhDsVjAXwrQQemzYT4HXrIrtF7J9T9KN2LbMDq6Ea8IkfSxmcHcYdK+
         tx4g==
X-Gm-Message-State: APuU4Z86arSNvZnqfgG34GymmH3yg4N6jNSHzfqWCma6rzH4JWjLI51Z
	otfURdCDSsiSTzcFN8rTfpDdHP2v5wV+glT1psePMHtaOPmY4tzMb4m2nt3jR3LM
X-Gm-Gg: AYBFou3m+FHmXW2BTrbwxX2Ew8YQrK3fvq4sE2TGiVdAukPejvt2r3B6f4Jy8KysVQH
	gsrrttVxjVRfR8bU7De1RNsx2nam33+J0Lq6fLLbgx/6AIXZguPIKLoT6m6h6yrOMJV/+thWPVf
	zIqURh+iLeZ9VNpKF80eOCGLEwu+avMAtLVzzK25CjgyBFGuwaFKpZddtSsgfPptWs8TkILvbrl
	G7roqERQ14tsrqIWusOvWvREaZlQSRb6gmePOwrN/R96MJo7lKSXaPJITcj0jYVBdIKmCkQY1N9
	ff20AX1M7ogUkJsM3gghK+5/xJJyddARyi6L/coNlR9pdGixPLfkwN/u4rRqrvCoj94zZeq15Sc
	GcoMBWvoEwy183IpBvUHEN7TyNu+D7oQZwG3ZLS/utNwRJ3jIOJz+chEkOoIhnPmkf5WvfO8CVA
	BOJNaONRk7olz8Twqd/0nD49Mxeq3TPfnHtv22zRz/DWWuqy/b7EJTJ8NPhd9Fb8W9fh4v2HjFn
	yGQf0HcTQKv5gP0JuhvoyYr+NH/GrgfwQbsUDVEUz9KXEUJxcbkfkZ2Tk/K43xmkZRWxJGZSa9C
	va32Zy8mBziQWWkraSoqElkT+fRD8Vl8Z/geo1447YvnSR4c8PK8VfTEQccx6g==
X-Received: by 2002:a17:90a:c2d0:b0:3aa:f2c4:12ea with SMTP id 98e67ed59e1d1-3b1b0a43396mr5927983a91.20.1794702925787;
        Sat, 14 Nov 2026 16:35:25 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:24 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/6] rrs/tools/common.py: import BitBake after checking out its revision
Date: Sat, 14 Nov 2026 16:35:02 -0800
Message-ID: <20261115003506.53654-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5380
Content-Type: text/plain; charset="utf-8"

load_recipes() imported bb.fetch before recipeparse.init_parser() checks
out the BitBake revision for the branch, so the bb package came from
whichever revision was checked out before, e.g. an old one left by
rrs_upgrade_history.py, while the rest of BitBake came from the new
one. rrs_upstream_history.py then failed with "cannot import name
'multiprocessing' from 'bb'". Import it after init_parser().

[YOCTO #16501]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/common.py            |  4 +++-
 tests/test_rrs_load_recipes.py | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 tests/test_rrs_load_recipes.py

diff --git a/rrs/tools/common.py b/rrs/tools/common.py
index 0caf1c9..ccdbe62 100644
--- a/rrs/tools/common.py
+++ b/rrs/tools/common.py
@@ -93,7 +93,6 @@ def get_recipe_files(layerdir):
 def load_recipes(layerbranch, bitbakepath, fetchdir, settings, logger,
         recipe_files=None, nocheckout=False):
     from layerindex import recipeparse
-    from bb.fetch import FetchError
 
     try:
         (tinfoil, tempdir) = recipeparse.init_parser(settings,
@@ -102,6 +101,9 @@ def load_recipes(layerbranch, bitbakepath, fetchdir, settings, logger,
     except recipeparse.RecipeParseError as e:
         logger.error(str(e))
         sys.exit(1)
+    # Only now that init_parser() has checked out the BitBake revision for the
+    # branch, or bb would be loaded from whichever one was checked out before
+    from bb.fetch import FetchError
 
     layer = layerbranch.layer
     urldir = str(layer.get_fetch_dir())
diff --git a/tests/test_rrs_load_recipes.py b/tests/test_rrs_load_recipes.py
new file mode 100644
index 0000000..97f3d26
--- /dev/null
+++ b/tests/test_rrs_load_recipes.py
@@ -0,0 +1,35 @@
+# layerindex-web - tests for load_recipes() in rrs/tools/common.py
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
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'rrs', 'tools'))
+
+
+def test_load_recipes_checks_out_bitbake_before_importing_it(monkeypatch):
+    # [YOCTO #16501] bb must come from the revision init_parser() checks out
+    import common
+    # As common_setup() does for the scripts: recipeparse imports utils
+    monkeypatch.syspath_prepend(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'layerindex'))
+    from layerindex import recipeparse
+
+    class Stop(Exception):
+        pass
+
+    def fake_init_parser(*args, **kwargs):
+        assert 'bb.fetch' not in sys.modules
+        raise Stop()
+
+    for name in [m for m in sys.modules if m == 'bb' or m.startswith('bb.')]:
+        monkeypatch.delitem(sys.modules, name)
+    monkeypatch.setattr(recipeparse, 'init_parser', fake_init_parser)
+    with pytest.raises(Stop):
+        common.load_recipes(types.SimpleNamespace(branch=None), '/nonexistent', '/nonexistent',
+                            types.SimpleNamespace(), None)
-- 
2.56.1

