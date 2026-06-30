Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E1C43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:07:04 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25091.1782835619928831644
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:07:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=S58160zx;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e67555e24so75771785a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835619; x=1783440419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5ahhGnLahXnO8Z7/NI7nZYav1I5X6A7dXXYRegvcCg=;
        b=S58160zxkbqVdm+Blj+Y5LJ3D3jRmlCDXfT08PVj99zASyHnLJfFEp4Hnile7KDkK+
         LglEVEYCkusK0+OEtZaanT5iEw5v/t6fpG9G+e4F2pqRWfKStGhoHPSbhXsUlOTHF0eO
         SxHNy739cvaQRLwh7bKqqYMDOniCc1E0Ban7g48a57S717vBLBx64tvtAkw1m8XQn187
         BO9CerLyWWF6IXiqkYG0zgUjGl+Y04FKh+NecGkEE4CyWWE99hk2/UFcw/QXN8LJ//3+
         MJ+GWX+MIfbrXHmI2EVecxIGL3uH9Bw9MKbLiwH+dgr9Xwx0rfGRsndJvI/Yt0sbmzf2
         w3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835619; x=1783440419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5ahhGnLahXnO8Z7/NI7nZYav1I5X6A7dXXYRegvcCg=;
        b=DG9sDheDBbgRMLtZMclGvA11UJVtIa4s8okGkshj1LP3/7Sd5odGCH3MQjczGzE+Rm
         POUS2K4poUzRhu1SMB7Desi+UUH+zLWii+0oFkpytc4aA8oGrpve618mpc5GccLWBGUi
         jIzkOM3cjI9OYhZWCwYIk7b/XqgVYo2YsJnZKQMsC1V9gFHfKZ8YF+d//th5lD7O5mij
         m4OVoNA1AbKG7hFj5GoKrlXw8LYAhksC4SFlYkgouWCeRlLSnPKfvRx1vzihtiVd/aCC
         7iGtSqSzWZWwAN5zq2l7fO+KLieRGe8kbXpkWEnOwCh7t/bwDl6Fez6RaIXBBjuU6OIR
         VuAQ==
X-Gm-Message-State: AOJu0YxCOGKmqmmtOojRG5fBhZNT9g36smAg/ZoWd9r2VZvX1Yaqms42
	zJeHQsSaRbYyV2k4Q2a9YyiX2N4YBg1VrtQwk8MKYRwMj9tjY+ft+l548SZVLw==
X-Gm-Gg: AfdE7cniSzhG008J6MSB1fax2uA0Av5hnQqkMLkS1nkBNAR7rha/eOdH6XWe4w10C/n
	L915LQu0sLVbJ6fGkNAuM8tuQlmu24XwtdsculeV7YJt9AyuNNfIsnQ4/paJKOQA7b4ytDY1COl
	mERyrlikCfkitMK2whqJFRvjeIUI7GIz936jQqUhqbjiUtYQ9fqst9C1VWU1h9gh1d55bJC1vwh
	SbFXFZ/uzZLT2NoWjKZEYeMRhx9BhLKhynzTLmmu1kG/zgwgGkNTlBdMmmCFzQE01knNZAchomH
	N6N0r5X1DdmwNjc9Ab1xR4FEDKria1Q0I1P3vW7sy4FozgiltU8xvrb4LFNdjQ0WMHPYvIuREt1
	6vHPNUNnwTmNbe/vE/ezcUoIMk6eBqlWfKZkBQoFE3Pu+0jiADgE0dtyLk4EIAtOhrsxp3/R1Zg
	/KLWBycRFtSA6BH7EZ3q7Eb5mMtPFdWrJkKgwApSCXfNMTh6Aijx5Oamc=
X-Received: by 2002:a05:620a:390c:b0:92e:529b:b802 with SMTP id af79cd13be357-92e62815e60mr680923685a.70.1782835618662;
        Tue, 30 Jun 2026 09:06:58 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:56 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 9/9] tests/unit/test_bb_utils: test mkdirhier() and fix its missing errno import
Date: Tue, 30 Jun 2026 12:06:12 -0400
Message-ID: <20260630160612.1005451-10-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:07:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4330

mkdirhier() wraps os.makedirs() and, on OSError, re-checks the error to
decide whether to swallow a benign "already exists" race or re-raise:

    except OSError as e:
        if e.errno != errno.EEXIST or not os.path.isdir(directory):
            raise e

but the module never imports errno. The reference to errno.EEXIST is
only evaluated when os.makedirs() actually raises, so the defect is
invisible on the happy path and on the unexpanded-${} guard. The moment
a real OSError occurs -- a parent component that is a file, a permission
error, anything -- the handler itself raises NameError: name 'errno' is
not defined, masking the original error with a misleading one.

The fix is a one-line import. With errno available the handler behaves
as intended: an EEXIST on an existing directory is swallowed, while any
other OSError (and an EEXIST whose path is not a directory) propagates
unchanged.

This commit adds tests/unit/test_bb_utils.py, covering mkdirhier() end
to end:

  - the happy path (nested, single-level, idempotent, existing dir);
  - the unexpanded-${} guard (rejected, nothing created, and that a
    bare brace without a dollar is allowed);
  - the OSError handler: a real mkdir under a file component surfaces an
    OSError, an arbitrary OSError propagates with its errno intact, an
    EEXIST on an existing directory is swallowed, and an EEXIST on a
    regular file propagates.

The error-path tests fail with NameError without the import and pass
with it, so the test and the fix belong together in this one change.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- v1 recorded this bug with an xfail marker in one large commit;
  v2 drops the xfail, asserts the correct behaviour directly, and
  lands the one-line errno-import fix in this same commit so the
  test passes green.
---
 src/wic/bb/utils.py         |   1 +
 tests/unit/test_bb_utils.py | 126 ++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tests/unit/test_bb_utils.py

diff --git a/src/wic/bb/utils.py b/src/wic/bb/utils.py
index 3750056ba563..0b40dd0c1d59 100644
--- a/src/wic/bb/utils.py
+++ b/src/wic/bb/utils.py
@@ -1,6 +1,7 @@
 """
 Minimal subset of BitBake's bb.utils used by standalone wic.
 """
+import errno
 import os
 
 # from bitbake/lib/bb/utils.py
diff --git a/tests/unit/test_bb_utils.py b/tests/unit/test_bb_utils.py
new file mode 100644
index 000000000000..5cd6035ca453
--- /dev/null
+++ b/tests/unit/test_bb_utils.py
@@ -0,0 +1,126 @@
+r"""
+Unit tests for wic.bb.utils -- a small standalone subset of BitBake's
+bb.utils. mkdirhier() is a mkdir -p wrapper with two guards: an
+unexpanded-${} check and an OSError handler that re-checks EEXIST.
+"""
+import errno
+import os
+import sys
+import tempfile
+import unittest.mock as mock
+from pathlib import Path
+
+import pytest
+
+_SRC = Path(__file__).resolve().parent.parent.parent / "src"
+if str(_SRC) not in sys.path:
+    sys.path.insert(0, str(_SRC))
+
+from wic.bb.utils import mkdirhier
+
+
+# ---------------------------------------------------------------------------
+# Happy path
+# ---------------------------------------------------------------------------
+
+class TestMkdirhierHappyPath:
+    def test_creates_nested_directory(self):
+        d = tempfile.mkdtemp()
+        target = os.path.join(d, "a", "b", "c")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_idempotent_on_existing_directory(self):
+        d = tempfile.mkdtemp()
+        target = os.path.join(d, "x")
+        mkdirhier(target)
+        # Second call must not raise (exist_ok=True).
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_single_level(self):
+        d = tempfile.mkdtemp()
+        target = os.path.join(d, "single")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_existing_root_directory(self):
+        # An already-existing directory (the tmpdir itself) is a no-op.
+        d = tempfile.mkdtemp()
+        mkdirhier(d)
+        assert os.path.isdir(d)
+
+
+# ---------------------------------------------------------------------------
+# Unexpanded bitbake-variable guard
+# ---------------------------------------------------------------------------
+
+class TestMkdirhierUnexpandedVar:
+    def test_unexpanded_var_rejected(self):
+        with pytest.raises(Exception) as ei:
+            mkdirhier("/tmp/${WORKDIR}/x")
+        assert "unexpanded bitbake variable" in str(ei.value)
+
+    def test_unexpanded_var_not_created(self):
+        d = tempfile.mkdtemp()
+        bad = os.path.join(d, "${VAR}", "sub")
+        with pytest.raises(Exception):
+            mkdirhier(bad)
+        # Nothing should have been created.
+        assert not os.path.exists(os.path.join(d, "${VAR}"))
+
+    def test_brace_without_dollar_is_allowed(self):
+        # Only the literal '${' marker triggers the guard; a bare '{' is a
+        # legal (if unusual) directory name.
+        d = tempfile.mkdtemp()
+        target = os.path.join(d, "plain{brace")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+
+# ---------------------------------------------------------------------------
+# OSError handler
+# ---------------------------------------------------------------------------
+
+class TestMkdirhierErrorPath:
+    def test_oserror_under_a_file_component(self):
+        # Create a regular file, then try to mkdir a subdir *under* it. On
+        # Linux os.makedirs raises NotADirectoryError (an OSError subclass);
+        # the handler must let it surface rather than swallow it.
+        d = tempfile.mkdtemp()
+        f = os.path.join(d, "afile")
+        Path(f).write_text("x")
+        target = os.path.join(f, "sub")
+        with pytest.raises(OSError):
+            mkdirhier(target)
+
+    def test_generic_oserror_propagates(self):
+        # An arbitrary OSError (EACCES != EEXIST) must propagate unchanged.
+        err = OSError()
+        err.errno = errno.EACCES
+        with mock.patch("wic.bb.utils.os.makedirs", side_effect=err):
+            with pytest.raises(OSError) as ei:
+                mkdirhier("/whatever/path")
+        assert ei.value.errno == errno.EACCES
+
+    def test_eexist_on_existing_dir_is_swallowed(self):
+        # An EEXIST OSError on a path that is already a directory is the
+        # benign race the handler exists to absorb; it must not propagate.
+        d = tempfile.mkdtemp()
+        err = OSError()
+        err.errno = errno.EEXIST
+        with mock.patch("wic.bb.utils.os.makedirs", side_effect=err):
+            mkdirhier(d)  # d exists and is a dir -> swallowed, no raise
+
+    def test_eexist_on_existing_file_propagates(self):
+        # EEXIST but the path is a regular file, not a directory: the
+        # handler's isdir() re-check fails, so the error must propagate.
+        d = tempfile.mkdtemp()
+        f = os.path.join(d, "afile")
+        Path(f).write_text("x")
+        err = OSError()
+        err.errno = errno.EEXIST
+        with mock.patch("wic.bb.utils.os.makedirs", side_effect=err):
+            with pytest.raises(OSError) as ei:
+                mkdirhier(f)
+        assert ei.value.errno == errno.EEXIST
-- 
2.50.0.173.g8b6f19ccfc3a


