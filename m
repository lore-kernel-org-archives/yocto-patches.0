Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AD5C44501
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:52 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39530.1782891651510482484
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Fa6eFU/4;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c05dcdf49so3277401cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891650; x=1783496450; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axQ2ssvVXKU6yhRY9smbJOUcyfNFkOt7WLLJlfd4Vdo=;
        b=Fa6eFU/4gYfC9bLOPnAYhq2FbNC9rSX0aEeozRUCDEN4icc+HShprAHHpryMj6XzwJ
         7+I67dnM1TUHbNndMrNXuSeF5r/u12DTM9fr4RKYhbju7x/qMDb/L+10elHP4ziIDARo
         hAwQ1PkurVnR+/d8MR/YNKOdg1xt7ceCqtu2c4JZwa0keOguQJ6tyZz4JGo5MxJW/YZO
         Wx9k6hylQshe3KitesgnZb6wz4QRjZvZAfBxNkxvuQbixJSLIFIQ5K20kzfN8fECxVcu
         YqiT1ttratupmIbqbe1u0mLSzihvNmc57dhV/YEi7XbOnOQWH0pcU/HmlFDZ+vVB0NpD
         +aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891650; x=1783496450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=axQ2ssvVXKU6yhRY9smbJOUcyfNFkOt7WLLJlfd4Vdo=;
        b=Kfy7CUApmkGXkvi3bsHCBFp2bAJU+qPAUdjiA0diWuosuYzQ6X6VWWMuowt7dN3w6H
         3fQ1o+b2fGrGY+VHyjydfF9F2H7IV3kSQekWx0O36ZYwvpX9qi6TCjmMDPgxgkx5IWj5
         OL8UrrYdmPDopjHaU+G9qeVoU4wOxFSiF3/osRZ8lgnmhEYqb3zjE6KlsQ50lkVbOQLe
         ubAZJFt1vvTW04CphRrh6sWmo7c0AGAyASUfH5DM21P+TUX2a/gnDnhFlCyM+63EHiWQ
         87fiJkdFu8LD9zqXpSkmjqrPRlF2ep8q13tb7h+WIQPJ5ptH2BpbgyZF3glSL37B+hL1
         VIyQ==
X-Gm-Message-State: AOJu0Yx0woPaU3hN1v6Ht1b82ogrKZay+cD8DnrL4TzvkmDcUozpGM5u
	W3qzvRiA4BcaS2abtXaZaEIocR/Q4QgL1eWRpO2odSkmfRZ8nO2xmKYtUb3L3A==
X-Gm-Gg: AfdE7cklA8sXe+6TkzqpD8dwAo5qfOv3NOZheXdwsEEmps9FaWrKkN1ZtM/zmCVg5LI
	uiMl9FpGaYUYmqubGRYo8P7NVtHx0dehS31+PMJinbUt3BwvsMxXgTnKE1IgAYMdxhYFaYvWREt
	/kjED3FNaCIidwhD9Vdy6M6uo92Tp2pVK0tjvp6Z9FPbMCgO43NdnKHmQqUam5FcFImDJ0uEm+9
	GAFGQmBvKxtV3UmjgdubiB2aTLSXdCWjoPXhY6tMWPxCwcK6LrKyi9uZLyxhJMR+6hekRveSlUL
	n46peHwcJlS/9tA5sS0xnprniIBqVHhTuaNpisAtbPSARFrMnID6k3ua/XYlijVCldmj4F4AI/i
	DIU0jY9ohY+zAKPQVXBoF5HU2yzbUWwdXZy3nQSq00iKtNEbaX0hzAd3mYjrE0z/xl1sHzucZ9c
	LjsQ20e6G5ciYgNHNO7LwUJExJ5CGhHpRiO+38cXmH7UK7UBjfSxHiIiI=
X-Received: by 2002:a05:622a:4d8d:b0:51a:8bc9:2915 with SMTP id d75a77b69052e-51c26a3b27fmr6773711cf.8.1782891650286;
        Wed, 01 Jul 2026 00:40:50 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:48 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 09/10] tests/unit/test_bb_utils: test mkdirhier() and fix its missing errno import
Date: Wed,  1 Jul 2026 03:40:29 -0400
Message-ID: <20260701074030.1090807-10-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4341

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

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- switch the tests from tempfile.mkdtemp() to pytest's tmp_path
  fixture so each test's scratch directory is cleaned up instead of
  leaking under /tmp; no change to what is tested.
changes in v2:
- v1 recorded this bug with an xfail marker in one large commit;
  v2 drops the xfail, asserts the correct behaviour directly, and
  lands the one-line errno-import fix in this same commit so the
  test passes green.
---
 src/wic/bb/utils.py         |   1 +
 tests/unit/test_bb_utils.py | 116 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
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
index 000000000000..aeca054109ff
--- /dev/null
+++ b/tests/unit/test_bb_utils.py
@@ -0,0 +1,116 @@
+r"""
+Unit tests for wic.bb.utils -- a small standalone subset of BitBake's
+bb.utils. mkdirhier() is a mkdir -p wrapper with two guards: an
+unexpanded-${} check and an OSError handler that re-checks EEXIST.
+"""
+import errno
+import os
+import sys
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
+    def test_creates_nested_directory(self, tmp_path):
+        target = os.path.join(str(tmp_path), "a", "b", "c")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_idempotent_on_existing_directory(self, tmp_path):
+        target = os.path.join(str(tmp_path), "x")
+        mkdirhier(target)
+        # Second call must not raise (exist_ok=True).
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_single_level(self, tmp_path):
+        target = os.path.join(str(tmp_path), "single")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+    def test_existing_root_directory(self, tmp_path):
+        # An already-existing directory (the tmpdir itself) is a no-op.
+        mkdirhier(str(tmp_path))
+        assert os.path.isdir(str(tmp_path))
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
+    def test_unexpanded_var_not_created(self, tmp_path):
+        bad = os.path.join(str(tmp_path), "${VAR}", "sub")
+        with pytest.raises(Exception):
+            mkdirhier(bad)
+        # Nothing should have been created.
+        assert not os.path.exists(os.path.join(str(tmp_path), "${VAR}"))
+
+    def test_brace_without_dollar_is_allowed(self, tmp_path):
+        # Only the literal '${' marker triggers the guard; a bare '{' is a
+        # legal (if unusual) directory name.
+        target = os.path.join(str(tmp_path), "plain{brace")
+        mkdirhier(target)
+        assert os.path.isdir(target)
+
+
+# ---------------------------------------------------------------------------
+# OSError handler
+# ---------------------------------------------------------------------------
+
+class TestMkdirhierErrorPath:
+    def test_oserror_under_a_file_component(self, tmp_path):
+        # Create a regular file, then try to mkdir a subdir *under* it. On
+        # Linux os.makedirs raises NotADirectoryError (an OSError subclass);
+        # the handler must let it surface rather than swallow it.
+        f = os.path.join(str(tmp_path), "afile")
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
+    def test_eexist_on_existing_dir_is_swallowed(self, tmp_path):
+        # An EEXIST OSError on a path that is already a directory is the
+        # benign race the handler exists to absorb; it must not propagate.
+        err = OSError()
+        err.errno = errno.EEXIST
+        with mock.patch("wic.bb.utils.os.makedirs", side_effect=err):
+            mkdirhier(str(tmp_path))  # exists and is a dir -> swallowed, no raise
+
+    def test_eexist_on_existing_file_propagates(self, tmp_path):
+        # EEXIST but the path is a regular file, not a directory: the
+        # handler's isdir() re-check fails, so the error must propagate.
+        f = os.path.join(str(tmp_path), "afile")
+        Path(f).write_text("x")
+        err = OSError()
+        err.errno = errno.EEXIST
+        with mock.patch("wic.bb.utils.os.makedirs", side_effect=err):
+            with pytest.raises(OSError) as ei:
+                mkdirhier(f)
+        assert ei.value.errno == errno.EEXIST
-- 
2.50.0.173.g8b6f19ccfc3a


