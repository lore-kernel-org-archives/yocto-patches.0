Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7630.1794702940645758562
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=rSgla2fE;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2124674a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702940; x=1795307740; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DNeSFap/rZHMML5YMEAPmRDosYBMRU9l3QKTNHWdRc=;
        b=rSgla2fE2a5O3tcV62/JLSdSbfA+30zrg8w6Qcm0hxOG3lr8H6y3HYsz5bNbfqr3Pk
         ePulK+GLfRJHL5vwBs5NqIJbGHGhlURlfXPnYu4x9O8WXkiY+bczuQ5/7Xu6xUMSh1KD
         mQzTZC41skCrls4YXHdTn7Hc09DqcomTOp2Sm0SlYjgQsxW0KGKvvH98s75deEInmBC4
         CD9F2hh/OP6KOaKJbRwMZf6sbtiwBhmeXoymC2dNr1lk7keYSMmJKJJIR1DlxRi8nNNu
         8QpmailAZA3sIENqdu/EsObOawL5fidKRi/cCYQFcC7tONxzA3cES0mkFDS8NtsbMjDq
         9MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702940; x=1795307740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0DNeSFap/rZHMML5YMEAPmRDosYBMRU9l3QKTNHWdRc=;
        b=hwgfcbWlocVrKWrBOROaVUqdnIHk5Wqkzvp9BF6hz1MB0++TJVoNXGcmb3CNzqZzd3
         CA4jI53QGJjD2CePiZqeV6B2Ugr5i20UUm17Gfw5HSNTotTI/0IkczLsIEX9CohMREN0
         jE4nf+3Isj4VoYdKG2M2rGP3D/d0kkDVPaGlAAeiDPGi3tCR3TvmYNNk79EFsLilmq0K
         ybP85BVi/LIs7pc3bR3AlR+c6h2FB12AT4kVzLrZumLhw3xvwDDE1D03kWOQBuwoIaOA
         7ZJjkuSumZHg9LB83f6646mQxKJEYK7YqOfZwG3PSEnxq5VcQM4iiTDGFsJZ4rD6AW28
         NL3g==
X-Gm-Message-State: APuU4Z/+jYIE4kZJKZMZ60KhQPRo5rnix93lNnfRc++khNeaY+KDBF6i
	fcoVufqghw7SW/MhwFXJZ/B3XTyb1HVKYzlfsVzJAPH5EbLa580QUFUKjOjmGw0q
X-Gm-Gg: AYBFou0HGLLAOH5ThHH2krXgvHLqMw1V2a7QBdNX59ISZzi/4GEhkjQgq7+sBa+Reg9
	F+dXPZtUD6xtZehg4xpbCuz04TxGcIcmrcNkvkqF16B80wf6PUgNOAjoEzd1D5Ekss9SelzaQ0g
	DaTtThh9GqoJ8oDSwLMw7dOrMHScKk9Hjqlqk0YasQLdcAaBx3fCny7ypyf1vObZkF6IppYgUlt
	yBWSNsneBfIi5rq7xdUGv7CgegABug0Zwu+OKllMIlYpum9dv3lEAfs8Q9b7obahYjTzlSstURi
	x6YO8dCEAxK2pLZPxv6ntgs0XOkrwpxIGleq0NtE7uCJYSvCGQpwhnnHDCfRGQKeNYAdL5mi944
	LlnF9TkvfpTpWj2k0yIh0OrrYGI7kH4K3mrS+GFw5S9MXrE65L9iSdQ2nVob1ilJNyKYVBtAdAy
	5mDHp/xt5GPX9eh0ILOh8Ct9o3DE6jxNDKg1R3d2f2GhVPcnliSBGIjFm3Xp+VA908JsKf53A+v
	PIDVJpSR3fuhx130/oxENDRl+0xeynqL8VSFKARtFuFNaGahopE+UFRkMBC3cfh4fBVu16iKSaJ
	KxNG2wwhUs7t31NbMe4EyJrA/Ozv5PorB0EHgL3AXQbTUvQYdMumipuB+ESIEQ==
X-Received: by 2002:a17:90b:314c:b0:3ac:86a0:5766 with SMTP id 98e67ed59e1d1-3b1b0b55624mr6913554a91.63.1794702939879;
        Sat, 14 Nov 2026 16:35:39 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:39 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 6/6] rrs_distros: keep the environment when fetching distro package lists
Date: Sat, 14 Nov 2026 16:35:06 -0800
Message-ID: <20261115003506.53654-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5384
Content-Type: text/plain; charset="utf-8"

OE-Core's distro_check calls bb.utils.export_proxies(), which also
exports the datastore's PATH and HOME. OE-Core's PATH puts its
scripts/git wrapper first with no python3 beside it, so once the
package lists were fetched for the first layer branch, every git command
for the next one failed with "/usr/bin/env: 'python3': No such file or
directory". Restore the environment after fetching the lists.

[YOCTO #16506]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/common.py               | 18 +++++++++++++
 rrs/tools/rrs_distros.py          |  5 ++--
 tests/test_rrs_distros_environ.py | 45 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_rrs_distros_environ.py

diff --git a/rrs/tools/common.py b/rrs/tools/common.py
index f97d4e1..ef213af 100644
--- a/rrs/tools/common.py
+++ b/rrs/tools/common.py
@@ -24,6 +24,24 @@ def common_setup():
     os.environ['GIT_ASKPASS'] = ''
     os.environ['GIT_TERMINAL_PROMPT'] = '0'
 
+def create_distro_packages_list(distro_check, fetchdir, d):
+    """
+    Download the distros' package lists with OE-Core's oe.distro_check,
+    keeping this process's environment as it was.
+
+    distro_check's create_socket() calls bb.utils.export_proxies(), which
+    exports PATH and HOME from the datastore along with the proxy
+    variables. OE-Core's PATH puts its scripts/git wrapper first, with no
+    python3 beside it, so left in place it breaks every later git command
+    in this process.
+    """
+    saved_environ = os.environ.copy()
+    try:
+        distro_check.create_distro_packages_list(fetchdir, d)
+    finally:
+        os.environ.clear()
+        os.environ.update(saved_environ)
+
 def get_logger(name, settings):
     from logging.handlers import RotatingFileHandler
 
diff --git a/rrs/tools/rrs_distros.py b/rrs/tools/rrs_distros.py
index e6717c1..3dc745d 100755
--- a/rrs/tools/rrs_distros.py
+++ b/rrs/tools/rrs_distros.py
@@ -17,7 +17,8 @@ from datetime import datetime
 
 sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__))))
 from common import common_setup, load_recipes, \
-        get_pv_type, get_logger, DryRunRollbackException
+        get_pv_type, get_logger, DryRunRollbackException, \
+        create_distro_packages_list
 common_setup()
 from layerindex import utils
 
@@ -138,7 +139,7 @@ if __name__=="__main__":
                             # Only need to do this once
                             from oe import distro_check
                             logger.debug("Downloading distro's package information ...")
-                            distro_check.create_distro_packages_list(fetchdir, d)
+                            create_distro_packages_list(distro_check, fetchdir, d)
                             pkglst_dir = os.path.join(fetchdir, "package_lists")
 
                         RecipeDistro.objects.filter(recipe__layerbranch = layerbranch).delete()
diff --git a/tests/test_rrs_distros_environ.py b/tests/test_rrs_distros_environ.py
new file mode 100644
index 0000000..e07fa74
--- /dev/null
+++ b/tests/test_rrs_distros_environ.py
@@ -0,0 +1,45 @@
+# layerindex-web - tests for create_distro_packages_list() in rrs/tools/common.py
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
+import common
+
+
+def fake_distro_check(fail=False):
+    # Like OE-Core's create_socket(): bb.utils.export_proxies() writes the
+    # datastore's PATH and HOME into os.environ
+    def create_distro_packages_list(fetchdir, d):
+        os.environ['PATH'] = '/oe-core/scripts:/build/tmp/hosttools'
+        os.environ['HOME'] = '/build'
+        os.environ['http_proxy'] = 'http://proxy.example.com:3128'
+        if fail:
+            raise OSError('HTTP Error 404: Not Found')
+    return types.SimpleNamespace(create_distro_packages_list=create_distro_packages_list)
+
+
+@pytest.mark.parametrize('fail', [False, True])
+def test_create_distro_packages_list_keeps_the_environment(monkeypatch, fail):
+    # [YOCTO #16506] OE-Core's PATH left in the environment made the next
+    # layer branch's git commands run OE-Core's scripts/git without python3
+    monkeypatch.setenv('PATH', '/usr/local/bin:/usr/bin:/bin')
+    monkeypatch.setenv('HOME', '/home/layers')
+    monkeypatch.delenv('http_proxy', raising=False)
+    before = dict(os.environ)
+
+    if fail:
+        with pytest.raises(OSError):
+            common.create_distro_packages_list(fake_distro_check(fail=True), '/fetch', None)
+    else:
+        common.create_distro_packages_list(fake_distro_check(), '/fetch', None)
+
+    assert dict(os.environ) == before
-- 
2.56.1

