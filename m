Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB0C531F9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:50:38 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17433.1784893836757844387
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 04:50:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ib0HZJCp;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so2743831cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784893836; x=1785498636; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tKtZMa4zuGitSEMXSafboxjHRRIO/n09vjMHIaMOuD4=;
        b=Ib0HZJCpSE7rBrNgMvxKOFpc2eS7X5GTdXnW3HNLQef3dckysu4p8OGOMFxvaZlJSD
         kFeoF7ROoU7iOfMEQ+jfgR3Gx5uvRL7iCbZ+GDh3aGBuQMNlDE1ASiA6R8JUEhLvzCqc
         i6Z1KZneG3+zH4BIvaaU4wTlAn9UlVyhoL1p8v9d54r/gGK8iZxABovNNd9AaxhfAcLX
         lA8B0Yo2+DiIa0zhGOgp2kjMBmXS1mB/ECYXLk93u3N4phRtPIndgpCTPfBIxPKaKAP6
         yl8d9DXwQpZbvWph9LBaJuOfLWaBQQLsMVMl7d8kvuSDOrjbmI6uSfF94iqG3HPcTYTt
         Nm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893836; x=1785498636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tKtZMa4zuGitSEMXSafboxjHRRIO/n09vjMHIaMOuD4=;
        b=tPJJ4k9xif3pHTIMoRwB73ojq0hxBQZEl4V7SNCv6CluV0j5kEKATB4qWopC5PYKL6
         J7x+r+jTlRnCQPqKrm1xEidhz7TxZp13ho1bCWbjGaptlvEesD4UpfoJwElBAFOAxAfN
         x67LEbSpvtXQKKOEf9ssocWQIUEY6LX1nL4zobL1FO8b8vsajJM9cUe/X7+oKruMP84M
         10Y/Ls83qbcMjr8spt/lxTtf90PMQ/BYafP5RM3o4IW2heucHsim4P2DAlzwSiN35Ny4
         YkVttiNW1pUwwhY9znYVJequouzeBH89yLniX12a9Isqtp3BLoOJclhDNe6NI36irnnt
         SMxg==
X-Gm-Message-State: AOJu0YyS0vCwofzk1BFXoIygm1ekNDIwsNBJKI0R7HvXRuUEHmaVIlbG
	yYK1W4KkEbqbTk7Gdc15BKlcDsTGa7ZcD3qQ57QV77hxlUNLdTOY4m2i8Rxt3A==
X-Gm-Gg: AR+sD10WdSnSJJJi7QkUAEbVZbd+6B2uQsxlQr+fUsRSEJ9zWojsnhynAMwBmgJ1NUt
	sMhxof2baR9IuJsl2tSaLrBG7feQE3Tn9O793XnxsL8WNNLyGV82gfw53io11LOsvnQNLjhfND1
	1J7Ncg95dAuaL+FKGJiHu5X6C45D9UHDy0hBb47GSX7PhrU+zp+gk5swE3RyRKr1vPAvvvY8EF6
	A3H55bQctpaBlkHznMDwTo4ga/RY1HQNSPa9iw8mOa3+IOVrzSE0iJv9LL/LzocxBw0+fySWvU7
	WNwssYXMk5IkzMHQMmttImLn3g9V7RP9XitUBQdpzT+fHUT9cmYtDf1mYL3t/EbpkvsJvClgbuJ
	DHz77ggIkZvgndvVoLhDVbeAvrJstQEJqeB8wY6AL4O2cYW8WVicXHGAqolsNV1c9cCyVRyakpw
	Tfi9B+3TctDqaOO2//WbN2BWBVbAbRBR9CjdZq3UgFNWCexbaj+5KX8aM=
X-Received: by 2002:a05:622a:c09:b0:51a:7d43:9392 with SMTP id d75a77b69052e-5283ddb0700mr65301591cf.8.1784893835247;
        Fri, 24 Jul 2026 04:50:35 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cf1sm66582796d6.46.2026.07.24.04.50.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:50:33 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 4/4] tests/unit/test_oe_path: cover oe/path's own path logic
Date: Fri, 24 Jul 2026 07:50:20 -0400
Message-ID: <20260724115020.38079-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260724115020.38079-1-twoerner@gmail.com>
References: <20260724115020.38079-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4536

Add unit coverage for the wic-specific behaviour in oe/path.py:

  - join() keeps an absolute right-hand component relative and
    normalises redundant separators, '.', and '..'.
  - is_path_parent() treats containment by path component, so a shared
    string prefix such as /usrlocal is not below /usr, and every
    supplied path must be below the parent.
  - symlink() creates links, is idempotent for a matching link, raises
    on a conflicting one, and with force=True replaces the literal
    destination -- including names with glob metacharacters and an
    existing directory -- without deleting glob siblings. A dangling
    link whose source does not exist yet is also covered.
  - make_relative_symlink() leaves non-links and already-relative links
    alone, rewrites an absolute link to a working relative one, and
    prepends multiple '../' segments when the link sits several
    directories below its target.
  - canonicalize() expands real paths, drops '$' and empty tokens
    (including a run of '$' tokens), keeps trailing slashes, and returns
    '' for '' and None.
  - which_wild() honours an explicit search path, expands wildcards, and
    returns the first match per name (last with reverse=True).
  - realpath() resolves links below root (including several components
    deep under use_physdir), rejects paths outside root, raises ELOOP on
    a self-referential link and on an A->B->A cycle, honours the
    assume_dir contract (ENOENT for a missing component by default,
    tolerated when assume_dir=True), and falls back cleanly when
    os.path.isdir() raises.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- Expand test_oe_path coverage: realpath() ELOOP on a self-loop and on
  an A->B->A cycle, multi-component resolution under use_physdir, and
  the assume_dir ENOENT-vs-tolerated contract; a dangling symlink()
  whose source does not exist yet; make_relative_symlink() several
  directories below its target (multi-level '../'); and two
  canonicalize() cases (a run of '$' tokens all dropped, and a dropped
  '$' token before a trailing-slash path). Module goes 42 -> 51 test
  functions.
- Rebased onto current master (past the merged ksparser test series); no
  change to the fixes themselves.
---
 tests/unit/test_oe_path.py | 378 +++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 tests/unit/test_oe_path.py

diff --git a/tests/unit/test_oe_path.py b/tests/unit/test_oe_path.py
new file mode 100644
index 000000000000..3abe1f0873a3
--- /dev/null
+++ b/tests/unit/test_oe_path.py
@@ -0,0 +1,378 @@
+"""
+Unit tests for wic/oe/path.py, covering wic's own path logic: join,
+is_path_parent, symlink, make_relative_symlink, canonicalize, which_wild,
+and realpath. Thin standard-library wrappers (relative -> os.path.relpath,
+find -> os.walk) are left to the standard library.
+"""
+import errno
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
+    def test_creates_dangling_symlink(self, tmp_path):
+        # symlink() does not require the source to exist; wic relies on being
+        # able to stage a link before its target is populated.
+        src = tmp_path / "not_created_yet"
+        dst = tmp_path / "link"
+        symlink(str(src), str(dst))
+        assert os.path.islink(str(dst))
+        assert os.readlink(str(dst)) == str(src)
+        assert not os.path.exists(str(dst))  # dangling: target is absent
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
+    def test_absolute_symlink_several_levels_deep_becomes_relative(self, tmp_path):
+        # The link sits several directories below the target, so the
+        # depth loop has to prepend more than one '../' segment. A
+        # single-level case never exercises that loop body.
+        target = tmp_path / "target.txt"
+        target.write_text("content")
+        deep = tmp_path / "a" / "b" / "c"
+        deep.mkdir(parents=True)
+        link = deep / "link"
+        os.symlink(str(target), str(link))
+        make_relative_symlink(str(link))
+        result = os.readlink(str(link))
+        assert not os.path.isabs(result)
+        assert result == "../../../target.txt"
+        assert Path(str(link)).read_text() == "content"
+
+
+class TestCanonicalize:
+    def test_real_path_returned(self, tmp_path):
+        result = canonicalize(str(tmp_path))
+        assert result == os.path.realpath(str(tmp_path))
+
+    def test_multiple_variable_tokens_all_skipped(self, tmp_path):
+        # Every "$"-bearing token is dropped, so a list made only of them
+        # canonicalizes to the empty string (no separators, no cwd).
+        assert canonicalize("$A,$B,$C") == ""
+
+    def test_variable_and_trailing_slash_path(self, tmp_path):
+        # A dropped "$" token followed by a real path with a trailing slash:
+        # the slash is preserved and no phantom leading separator appears.
+        result = canonicalize("$VAR,%s/" % tmp_path)
+        assert result == os.path.realpath(str(tmp_path)) + "/"
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
+    def test_resolves_symlink_several_components_deep(self, tmp_path):
+        # With use_physdir=True realpath resolves each intermediate
+        # component, so a link buried under real subdirectories must still
+        # resolve to its final target.
+        (tmp_path / "a" / "b" / "c").mkdir(parents=True)
+        link = tmp_path / "link_to_c"
+        os.symlink("a/b/c", str(link))
+        result = realpath(str(link / "file"), str(tmp_path), assume_dir=True)
+        assert result == str(tmp_path / "a" / "b" / "c" / "file")
+
+    def test_self_referential_symlink_raises_eloop(self, tmp_path):
+        # A link that points at itself must be reported as ELOOP rather than
+        # spinning until the recursion limit or the stack blows.
+        link = tmp_path / "loop"
+        os.symlink("loop", str(link))
+        with pytest.raises(OSError) as exc:
+            realpath(str(link), str(tmp_path))
+        assert exc.value.errno == errno.ELOOP
+
+    def test_mutual_symlink_cycle_raises_eloop(self, tmp_path):
+        # An A -> B -> A cycle is the same contract as the self-loop.
+        a = tmp_path / "a"
+        b = tmp_path / "b"
+        os.symlink("b", str(a))
+        os.symlink("a", str(b))
+        with pytest.raises(OSError) as exc:
+            realpath(str(a), str(tmp_path))
+        assert exc.value.errno == errno.ELOOP
+
+    def test_missing_component_raises_enoent_without_assume_dir(self, tmp_path):
+        # By default a missing path component is an error.
+        with pytest.raises(OSError) as exc:
+            realpath(str(tmp_path / "nope" / "missing"), str(tmp_path))
+        assert exc.value.errno == errno.ENOENT
+
+    def test_missing_component_tolerated_with_assume_dir(self, tmp_path):
+        # assume_dir=True lets realpath resolve a path whose trailing
+        # components do not exist yet, returning the composed path.
+        result = realpath(str(tmp_path / "nope" / "missing"),
+                          str(tmp_path), assume_dir=True)
+        assert result == str(tmp_path / "nope" / "missing")
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


