Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0834C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 20:53:01 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.989.1783630374255971111
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 13:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ek9991ch;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e7c6ec9dbso10392085a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630373; x=1784235173; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KWdT6n65kSRkzEI1EWmER4yPJP150V+zupUZrjgcdro=;
        b=ek9991chGuD0ZfFNEzuSqiQbFcAHiGR20YAx+wGP39v4ZLD99SaZFecHSRzIuGuQeY
         RVPLTR/DSBxhzndhVcvQEj8v5aFGvRHl5xdq3UKI3fZie04bJo5JfukYj5pBD06ca0lK
         IK0RtGdubqEssRyxQHLhVfiPtg5xZ88FtBJhTvMpH+PgePllDtyXwVNDTovgfR9ampPI
         HG1co6OZsNywkvPZX6PlJ4Tlc61B105bjbOWDcnLRt+6PjNFoNrGZj3ksiheNMVhdwor
         2XTxVxBoccWqbdwoXh1U86dx7AYeAI9KApF8oO2gj78+zFlilT5JvjuYBSai30kMvIIa
         Tjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630373; x=1784235173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KWdT6n65kSRkzEI1EWmER4yPJP150V+zupUZrjgcdro=;
        b=l7sbVARxyR1zxRVZylXp3WEncBv3LjuI9YwVUUGfSVVNuli3BLYjlkb/xaVz7er2wC
         RZayFjypHORrJIbgH417qpEIiRuL3dMlK6N7FFZTO83JJmpog3qQw5RFNK3dMKjvnV9l
         9CWCYz7zg6Gzu0uYJR4Fe04C4WmrPh4MEaFfRU8wEFSymXpMlsOm+bGyukxmssi2H9Kv
         WO9r4xllY/QW1UGBzegvosVVVbZ0tcqxA1mLMNd1+Jo7ZWj7xUEi+DW35sZbMquQQTXq
         7EkyBQYtp9HGrim5+jGE0qfSLLOZDR+YkgnCWFBhSHKwEFiAahWni8pTl68MqlWqJ9as
         DDKw==
X-Gm-Message-State: AOJu0Ywvi+YDzJSBWH6yeSaLkS3Quc82F2eMoO1/EwFLXfOchbtbQCIV
	0aAh5iX8pK28uNyNrXXoP/CFETv1aXeHFSEJLAiUfHG/DFR3wyjhgX4NH6S4xw==
X-Gm-Gg: AfdE7cniLnc2nAfo4K68YzSfPID42PYpw1M5PlLyoi4WJjVuX7w8ojdJdUBc1nCUBS3
	0cSwri5T5NMh5QtpidWtQxaHAlIq+7HL8biK1/FJJWgTasvNgZ0FUDHgAGLVmaBo7oQMCTxJTXR
	A5UBxVW7THy1D9ghWrQyMV4yjGpRWNFde6LqqbJi3+M0rtANVK1TQ40fvgOQZr+EXoCawNgq6Cf
	+ieEYvCKWt1F3wQiKZWe7Gi3a+i5AWhKTuFKNyRnRol7l0OMt/D0liMtApEtT1nKmJLYMXjcMcE
	QFVYBaa2mXxhr3rbyOhyVf3uEdcjJYArOlEJQnMXLSd9n2GQinPHW+fSbqYwDRDmJKWDSNcNYRa
	vcHUrwcEhpGxVagAefej/e7njYLYF9w0zadFkknl0jQYHLTg8iEifV2b86c9FFRGFHcmBRvzAaz
	g+2kn8o1HcQg5wZYGMnXfCVjhxuaeZefKC6MVcUnJmGxJh0XVrQ8rRBbg=
X-Received: by 2002:a05:620a:268d:b0:914:7e9a:2716 with SMTP id af79cd13be357-92ecf5e36b3mr960609285a.38.1783630372809;
        Thu, 09 Jul 2026 13:52:52 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm32893085a.38.2026.07.09.13.52.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:52:51 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 4/4] tests/unit/test_oe_path: cover oe/path's own path logic
Date: Thu,  9 Jul 2026 16:52:27 -0400
Message-ID: <20260709205227.3470712-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709205227.3470712-1-twoerner@gmail.com>
References: <20260709205227.3470712-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 20:53:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4463

Add unit coverage for the wic-specific behaviour in oe/path.py:

  - join() keeps an absolute right-hand component relative and
    normalises redundant separators, '.', and '..'.
  - is_path_parent() treats containment by path component, so a shared
    string prefix such as /usrlocal is not below /usr, and every
    supplied path must be below the parent.
  - symlink() creates links, is idempotent for a matching link, raises
    on a conflicting one, and with force=True replaces the literal
    destination -- including names with glob metacharacters and an
    existing directory -- without deleting glob siblings.
  - make_relative_symlink() leaves non-links and already-relative links
    alone and rewrites an absolute link to a working relative one.
  - canonicalize() expands real paths, drops '$' and empty tokens, keeps
    trailing slashes, and returns '' for '' and None.
  - which_wild() honours an explicit search path, expands wildcards, and
    returns the first match per name (last with reverse=True).
  - realpath() resolves links below root, rejects paths outside root, and
    falls back cleanly when os.path.isdir() raises.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 tests/unit/test_oe_path.py | 298 +++++++++++++++++++++++++++++++++++++
 1 file changed, 298 insertions(+)
 create mode 100644 tests/unit/test_oe_path.py

diff --git a/tests/unit/test_oe_path.py b/tests/unit/test_oe_path.py
new file mode 100644
index 000000000000..a978fcf789d2
--- /dev/null
+++ b/tests/unit/test_oe_path.py
@@ -0,0 +1,298 @@
+"""
+Unit tests for wic/oe/path.py, covering wic's own path logic: join,
+is_path_parent, symlink, make_relative_symlink, canonicalize, which_wild,
+and realpath. Thin standard-library wrappers (relative -> os.path.relpath,
+find -> os.walk) are left to the standard library.
+"""
+import os
+import sys
+from pathlib import Path
+
+import pytest
+
+_SRC = Path(__file__).resolve().parent.parent.parent / "src"
+if str(_SRC) not in sys.path:
+    sys.path.insert(0, str(_SRC))
+
+from wic.oe.path import (
+    join,
+    is_path_parent,
+    symlink,
+    make_relative_symlink,
+    canonicalize,
+    which_wild,
+    realpath,
+)
+
+
+class TestJoin:
+    """join() is os.path.normpath("/".join(paths)); unlike os.path.join it
+    does not treat an absolute right-hand component specially."""
+
+    def test_two_paths(self):
+        assert join("a", "b") == "a/b"
+
+    def test_three_paths(self):
+        assert join("a", "b", "c") == "a/b/c"
+
+    def test_absolute_rhs_is_not_special(self):
+        # os.path.join("a", "/b") == "/b"; join() keeps it relative.
+        assert join("a", "/b") == "a/b"
+
+    def test_redundant_separators_normalised(self):
+        assert join("a//", "b") == "a/b"
+
+    def test_pardir_normalised(self):
+        assert join("a", "..", "b") == "b"
+
+    def test_curdir_normalised(self):
+        assert join("a", ".", "b") == "a/b"
+
+    def test_single_component(self):
+        assert join("a") == "a"
+
+    def test_empty_leading_component_is_absolute(self):
+        # "/".join(["", "b"]) is "/b", which normpath leaves absolute.
+        assert join("", "b") == "/b"
+
+
+class TestIsPathParent:
+    def test_direct_child(self):
+        assert is_path_parent("/usr", "/usr/bin") is True
+
+    def test_deep_child(self):
+        assert is_path_parent("/usr", "/usr/share/doc/readme") is True
+
+    def test_unrelated_path(self):
+        assert is_path_parent("/usr", "/tmp") is False
+
+    def test_child_is_not_parent_of_its_parent(self):
+        assert is_path_parent("/usr/bin", "/usr") is False
+
+    def test_prefix_string_is_not_a_path_parent(self):
+        # "/usrlocal" shares a string prefix with "/usr" but is not below it;
+        # the trailing-separator handling must reject it.
+        assert is_path_parent("/usr", "/usrlocal") is False
+
+    def test_no_paths_returns_false(self):
+        assert is_path_parent("/usr") is False
+
+    def test_all_paths_must_be_below(self):
+        assert is_path_parent("/usr", "/usr/bin", "/usr/lib") is True
+
+    def test_one_path_outside_fails(self):
+        assert is_path_parent("/usr", "/usr/bin", "/tmp") is False
+
+
+class TestSymlink:
+    def test_creates_symlink(self, tmp_path):
+        src = tmp_path / "target.txt"
+        src.write_text("content")
+        dst = tmp_path / "link"
+        symlink(str(src), str(dst))
+        assert os.path.islink(str(dst))
+        assert os.readlink(str(dst)) == str(src)
+
+    def test_matching_existing_symlink_is_idempotent(self, tmp_path):
+        src = tmp_path / "target.txt"
+        src.write_text("content")
+        dst = tmp_path / "link"
+        symlink(str(src), str(dst))
+        symlink(str(src), str(dst))
+        assert os.readlink(str(dst)) == str(src)
+
+    def test_conflicting_existing_symlink_raises(self, tmp_path):
+        src1 = tmp_path / "t1.txt"
+        src2 = tmp_path / "t2.txt"
+        src1.write_text("a")
+        src2.write_text("b")
+        dst = tmp_path / "link"
+        symlink(str(src1), str(dst))
+        with pytest.raises(OSError):
+            symlink(str(src2), str(dst))
+
+    def test_force_overwrites_existing_symlink(self, tmp_path):
+        src1 = tmp_path / "t1"
+        src2 = tmp_path / "t2"
+        src1.write_text("a")
+        src2.write_text("b")
+        dst = tmp_path / "link"
+        symlink(str(src1), str(dst))
+        symlink(str(src2), str(dst), force=True)
+        assert os.readlink(str(dst)) == str(src2)
+
+    def test_force_replaces_destination_with_glob_metacharacters(self, tmp_path):
+        # A destination whose name contains glob metacharacters must still be
+        # replaced. Routing the removal through glob (the old behaviour) fails
+        # to match "link[1]" against itself, leaving the stale entry in place.
+        src = tmp_path / "target"
+        src.write_text("content")
+        dst = tmp_path / "link[1]"
+        dst.write_text("stale regular file")
+        symlink(str(src), str(dst), force=True)
+        assert os.path.islink(str(dst))
+        assert os.readlink(str(dst)) == str(src)
+
+    def test_force_does_not_delete_glob_siblings(self, tmp_path):
+        # The destination "keep?.txt" does not exist, but a sibling
+        # "keepX.txt" matches it as a glob pattern. force=True must remove
+        # only the literal destination, never a pattern sibling.
+        sibling = tmp_path / "keepX.txt"
+        sibling.write_text("do not delete me")
+        src = tmp_path / "target"
+        src.write_text("content")
+        dst = tmp_path / "keep?.txt"
+        symlink(str(src), str(dst), force=True)
+        assert sibling.exists()
+        assert os.readlink(str(dst)) == str(src)
+
+    def test_force_replaces_existing_directory(self, tmp_path):
+        # An existing directory at the destination is torn down (EISDIR ->
+        # rmtree) before the link is created.
+        src = tmp_path / "target"
+        src.write_text("content")
+        dst = tmp_path / "dir"
+        dst.mkdir()
+        (dst / "child").write_text("x")
+        symlink(str(src), str(dst), force=True)
+        assert os.path.islink(str(dst))
+        assert os.readlink(str(dst)) == str(src)
+
+
+class TestMakeRelativeSymlink:
+    def test_non_symlink_is_ignored(self, tmp_path):
+        regular = tmp_path / "file.txt"
+        regular.write_text("content")
+        make_relative_symlink(str(regular))
+        assert regular.is_file()
+
+    def test_already_relative_symlink_is_unchanged(self, tmp_path):
+        target = tmp_path / "target.txt"
+        target.write_text("content")
+        link = tmp_path / "link"
+        os.symlink("target.txt", str(link))
+        make_relative_symlink(str(link))
+        assert os.readlink(str(link)) == "target.txt"
+
+    def test_absolute_symlink_becomes_relative_and_resolves(self, tmp_path):
+        target = tmp_path / "target.txt"
+        target.write_text("content")
+        link = tmp_path / "link"
+        os.symlink(str(target), str(link))
+        assert os.path.isabs(os.readlink(str(link)))
+        make_relative_symlink(str(link))
+        result = os.readlink(str(link))
+        assert not os.path.isabs(result)
+        assert os.path.exists(str(link))
+        assert Path(str(link)).read_text() == "content"
+
+
+class TestCanonicalize:
+    def test_real_path_returned(self, tmp_path):
+        result = canonicalize(str(tmp_path))
+        assert result == os.path.realpath(str(tmp_path))
+
+    def test_unexpanded_variable_is_skipped(self):
+        assert canonicalize("$SOME_VAR") == ""
+
+    def test_variable_token_dropped_leaving_real_path(self, tmp_path):
+        result = canonicalize("$VAR," + str(tmp_path))
+        # The "$VAR" token is dropped entirely: no empty placeholder, no
+        # leading separator, just the canonical real path.
+        assert result == os.path.realpath(str(tmp_path))
+
+    def test_empty_string_returns_empty_string(self):
+        # os.path.realpath("") is the cwd; canonicalize("") must not leak it.
+        assert canonicalize("") == ""
+
+    def test_none_returns_empty_string(self):
+        assert canonicalize(None) == ""
+
+    def test_empty_token_between_paths_is_dropped(self, tmp_path):
+        p1 = tmp_path / "a"
+        p2 = tmp_path / "b"
+        p1.mkdir()
+        p2.mkdir()
+        # The stray separator in "a,,b" must not inject a cwd entry.
+        result = canonicalize("%s,,%s" % (p1, p2))
+        assert result == "%s,%s" % (
+            os.path.realpath(str(p1)), os.path.realpath(str(p2)))
+
+    def test_trailing_slash_preserved(self, tmp_path):
+        result = canonicalize(str(tmp_path) + "/")
+        assert result == os.path.realpath(str(tmp_path)) + "/"
+
+
+class TestWhichWild:
+    def test_finds_existing_executable(self):
+        results = which_wild("python3")
+        assert results
+        assert all(os.path.isabs(p) for p in results)
+        assert all(os.path.basename(p) == "python3" for p in results)
+
+    def test_missing_tool_returns_empty(self):
+        assert which_wild("totally_nonexistent_tool_xyz") == []
+
+    def test_explicit_search_path(self, tmp_path):
+        tool = tmp_path / "mytool"
+        tool.write_text("#!/bin/sh\n")
+        tool.chmod(0o755)
+        results = which_wild("mytool", path=str(tmp_path))
+        assert results == [str(tool)]
+
+    def test_wildcard_pattern(self, tmp_path):
+        (tmp_path / "foo-a").write_text("")
+        (tmp_path / "foo-b").write_text("")
+        (tmp_path / "bar").write_text("")
+        results = which_wild("foo-*", path=str(tmp_path))
+        assert sorted(os.path.basename(p) for p in results) == ["foo-a", "foo-b"]
+
+    def test_first_match_per_name_wins(self, tmp_path):
+        # A name found in an earlier PATH element shadows the same name later.
+        first = tmp_path / "first"
+        second = tmp_path / "second"
+        first.mkdir()
+        second.mkdir()
+        (first / "tool").write_text("")
+        (second / "tool").write_text("")
+        search = "%s:%s" % (first, second)
+        assert which_wild("tool", path=search) == [str(first / "tool")]
+        # reverse=True walks PATH the other way, so the other copy wins.
+        assert which_wild("tool", path=search, reverse=True) == [str(second / "tool")]
+
+
+class TestRealpath:
+    def test_resolves_symlink_below_root(self, tmp_path):
+        target = tmp_path / "real"
+        target.mkdir()
+        link = tmp_path / "lnk"
+        os.symlink("real", str(link))
+        result = realpath(str(link), str(tmp_path))
+        assert result == str(target)
+
+    def test_plain_path_is_returned(self, tmp_path):
+        sub = tmp_path / "d"
+        sub.mkdir()
+        assert realpath(str(sub), str(tmp_path)) == str(sub)
+
+    def test_path_outside_root_raises(self, tmp_path):
+        root = tmp_path / "root"
+        outside = tmp_path / "outside"
+        root.mkdir()
+        outside.mkdir()
+        with pytest.raises(OSError):
+            realpath(str(outside), str(root))
+
+    def test_isdir_failure_falls_back_without_nameerror(self, tmp_path, monkeypatch):
+        # The final stanza of __realpath tolerates any failure from
+        # os.path.isdir by treating the path as not-a-directory. Force isdir
+        # to raise and confirm the fallback returns the resolved path rather
+        # than raising NameError from an undefined fallback value.
+        sub = tmp_path / "d"
+        sub.mkdir()
+
+        def boom(_path):
+            raise OSError("synthetic stat failure")
+
+        monkeypatch.setattr(os.path, "isdir", boom)
+        assert realpath(str(sub), str(tmp_path), use_physdir=False) == str(sub)
-- 
2.50.0.173.g8b6f19ccfc3a


