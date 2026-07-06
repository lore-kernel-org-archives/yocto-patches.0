Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F504C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:35 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161873.1783376968676302139
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lWkvAaBV;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eabb1a9378so26604256d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376968; x=1783981768; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCG4cABeR4m1pYuK4vhoMKS1R1BUSQwaRNXndkspQRg=;
        b=lWkvAaBVmVR3tkh8z5xujAapRIT5IGMpQLOKrnyoSm8C+vFdIag7dVB+Pcc0z1D3Js
         ULGh8rcfCVYsIkeXPLKJKQgPAs47GuwfwAbxG7knjsQYws2k5S8nAHh8Uc0UZedbdzks
         BTyJ2DBlKdqYI/hO3B5xTXxiSb8EeqfXMOfrOafEmyHoIgRoo6W6FyPIJe+KrrblYVy9
         dVDQVJ+O9FCHIbxEkyKSmSZmvuTEOnh287gU1mQRMR9vpyEHW5q0mV24IEkzLJf+5PNH
         AbBxrgSIKkHSuRoDIUvKfJUjB/nS9W4j2tINNGoQ10OyEvMLTwi/LASsOubnJQTkPOxY
         +m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376968; x=1783981768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uCG4cABeR4m1pYuK4vhoMKS1R1BUSQwaRNXndkspQRg=;
        b=RNgEvEILeQr4Fbur6gWnFHs3yxyGJkyf0moPji/WpORbBwfIiW8qM7OrVS6B4sMQJu
         HVzLLDj+zzvCpCIODPYrFbsux7l6Xkv8Y27M7OGyhuhZ7NhDtt34JNVv7BnE/yjqg+Zg
         0WXdI0n1XaPZsMneZj/q1aQOkglPHYlMF0SBfzGoLIfsb2oFBGrNeKZJLx037UUy4lLC
         XllAF8lnRs5cysHN+R/FS3gFf9F79+NbRq7sktNgtz4Lzmd7/8HGTYATqzXKP+pv68D/
         IOKAuBGaycXz5D0EPnuVGu1tKJmqJ+5vc7r6r0EwhG7mK25VA59w62YbGxFKVlMyuXQ6
         nNAg==
X-Gm-Message-State: AOJu0Yzh0TZnWly7rEKRYIFJypRtlDwkWor5nUehyR8D61hEPgHRnjlH
	iD/A5NLl+aaPmBLLC/k7jxZFBxcsdU99J/ZG2VR816q3pcOr0U4R5U/u6bf2Dhsr
X-Gm-Gg: AfdE7cnjb31Npe2U4imtQuZ2wpbjL4fXqrFr60tpelUI/EqpgNlBJ80tFTVMCpPVR28
	YGvGeLSq+bJCU7YD5G2mY6kUoM9pwZUC8QMWffWvf5f47pNJq1b2LtFZQeTyj4DZa4LC6juYvYk
	UkxlSrQg3MzQ8O5AVdKYTz2PcPSvygICxh/Oo5li6zdui/8YTeo5BWc8sX6afZ9H7nQwOOFboz2
	bW/Ib2RNPNeY3glsvkLueG+QKd7MiCnrMeZRH7oTuo+SRVDqzOb7Tk4HVhijxZ47WcF3DdPPTWg
	+a7KOr53jJZ+F8Kg0NicRbKhyu3WJIzel9FKU7GpbbNnfE9OrCco1d3aBA/FopTn+X4HclqvLOW
	6ss8BoxLXs0aMebZNvgI2owa+/e3lSAt/0FoTwdJyrpETOEuFEC9dA2xuTzJ7RTKMiuP50I+0w6
	zF+3c/7zJ782G7098uIkQYV+sPLhN3MXZ2t2rbMVxryrj25gkYsH75Ces=
X-Received: by 2002:a05:6214:3285:b0:8dd:f14c:1dc with SMTP id 6a1803df08f44-8fcb26a6000mr32273526d6.1.1783376967281;
        Mon, 06 Jul 2026 15:29:27 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:26 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 6/6] tests/unit/test_bb_utils: cover mkdirhier()
Date: Mon,  6 Jul 2026 18:29:04 -0400
Message-ID: <20260706222904.664863-7-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4448

Add unit tests for mkdirhier(), the one function in wic.bb.utils. They
pin the behaviour wic relies on so it cannot regress: it creates missing
directories, accepts a directory that already exists, rejects a path
containing an unexpanded bitbake variable (${...}), and allows a name
with a lone brace or a lone dollar, neither of which is the ${ marker.

Three tests cover the OSError handler that the errno import repairs: a
path whose parent component is a regular file, a target that already
exists as a file rather than a directory, and a directory that appears
concurrently mid-call (a create race), which must be treated as success.
Run against a wic.bb.utils that does not import errno, all three fail
with NameError instead, so they catch that bug directly.

The tests replace the tests/unit/.gitkeep placeholder.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- reframe the tests to target mkdirhier's own behaviour: drop the
  cases that only re-exercised os.makedirs and the assertions that
  pinned implementation details.
- the errno fix moved to its own preceding commit; this is tests
  only.
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
 tests/unit/.gitkeep         |  0
 tests/unit/test_bb_utils.py | 81 +++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 delete mode 100644 tests/unit/.gitkeep
 create mode 100644 tests/unit/test_bb_utils.py

diff --git a/tests/unit/.gitkeep b/tests/unit/.gitkeep
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tests/unit/test_bb_utils.py b/tests/unit/test_bb_utils.py
new file mode 100644
index 000000000000..0300b8d4a1a0
--- /dev/null
+++ b/tests/unit/test_bb_utils.py
@@ -0,0 +1,81 @@
+"""
+Unit tests for wic.bb.utils.mkdirhier: a mkdir -p wrapper that rejects
+unexpanded bitbake variables and, on error, tolerates an already-existing
+directory while re-raising every real failure.
+"""
+import sys
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
+class TestMkdirhier:
+    def test_creates_missing_directories(self, tmp_path):
+        target = tmp_path / "a" / "b" / "c"
+        mkdirhier(str(target))
+        assert target.is_dir()
+
+    def test_existing_directory_is_accepted(self, tmp_path):
+        # Calling it on a directory that already exists is not an error.
+        mkdirhier(str(tmp_path))
+        mkdirhier(str(tmp_path))
+        assert tmp_path.is_dir()
+
+    def test_unexpanded_bitbake_variable_is_rejected(self, tmp_path):
+        target = tmp_path / "${WORKDIR}" / "sub"
+        with pytest.raises(Exception, match="unexpanded bitbake variable"):
+            mkdirhier(str(target))
+        assert not (tmp_path / "${WORKDIR}").exists()
+
+    def test_plain_brace_is_not_treated_as_a_variable(self, tmp_path):
+        # Only the '${' marker trips the guard; a bare brace is a legal
+        # (if unusual) directory name.
+        target = tmp_path / "plain{brace"
+        mkdirhier(str(target))
+        assert target.is_dir()
+
+    def test_dollar_without_brace_is_allowed(self, tmp_path):
+        # The guard keys on the literal '${' marker; a '$' on its own is
+        # not an unexpanded variable and is a legal directory name.
+        target = tmp_path / "price$5"
+        mkdirhier(str(target))
+        assert target.is_dir()
+
+    def test_path_under_a_file_raises(self, tmp_path):
+        # A parent component that is a regular file makes the underlying
+        # mkdir fail; the error must surface rather than be swallowed.
+        afile = tmp_path / "afile"
+        afile.write_text("x")
+        with pytest.raises(OSError):
+            mkdirhier(str(afile / "sub"))
+
+    def test_existing_file_at_target_raises(self, tmp_path):
+        # The target already exists but is a file, not a directory: the
+        # error must propagate rather than be tolerated.
+        afile = tmp_path / "afile"
+        afile.write_text("x")
+        with pytest.raises(OSError):
+            mkdirhier(str(afile))
+
+    def test_concurrent_creation_is_treated_as_success(self, tmp_path, monkeypatch):
+        # If the directory appears while mkdirhier runs (a create race
+        # with another process), that is success, not an error.
+        import errno
+
+        import wic.bb.utils as bb_utils
+
+        target = tmp_path / "made-concurrently"
+
+        def racing_makedirs(path, exist_ok=False):
+            target.mkdir()  # someone else wins the race
+            raise OSError(errno.EEXIST, "File exists", str(path))
+
+        monkeypatch.setattr(bb_utils.os, "makedirs", racing_makedirs)
+        mkdirhier(str(target))  # must not raise
+        assert target.is_dir()
-- 
2.50.0.173.g8b6f19ccfc3a


