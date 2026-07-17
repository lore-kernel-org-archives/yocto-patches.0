Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC99C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 18:35:19 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3277.1784313317429013205
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 11:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IEcN/AI7;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90327237340so18035696d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313316; x=1784918116; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gMORbWZxc72HgyJa0gL2l6lnghZJ7gQ9cAsdDZsgU34=;
        b=IEcN/AI7Wf3NkgQ9S5VLCWu0W3dHhXBlxD8HFUSTKMyaghzVuViugZp1+E/qxGKSeA
         b6D/0GHVaZNphTdhufCSbH8gvyZuZbjxh+xJapE17brElnI5JYueNTWq61vn6cww84yI
         t7MPSyZ1+WMlx6X+Qe4SH90ef3yoQ2l9drC+RXMGyjBAlD/DN+yTrbgcSoZzKSAGyFlv
         5QkxvjlVFj9kXkkb2J7fSomn1i8POK2QfJiY3757f6GIG46tsmESVYJVNP3BbAN+0kFX
         R/4ftfubXIkvKNMaO3I/uTOETqpA3d4QjjctWojoO+ak9347g+WGwKfZjgsxEiztba2B
         5/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313316; x=1784918116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gMORbWZxc72HgyJa0gL2l6lnghZJ7gQ9cAsdDZsgU34=;
        b=gpCfV4aElGM7BourqN8zbeNfU+yEBcwmSzeGmo4LxfklV1MffiU0aEe77CAAWGshsh
         jIkRG1Pz/oL/p+fqSnwPEscxkE2NR6T+KjxdsUNcPvOzcyF5zUc4+RxaoH/Xod91+9B4
         yIGe4rVJrM2xlSGGi3bVwX2aNOZRgfiuWcWEME2MJlyjN5jiHbZnfbvSeGqGiJdcsoo7
         mmZ7dyZ7kGDRG40FGG5hwYQF5uznyAjO1xLhTDtAX3Gh95SsUnv1BDYIUe44h9Hh9x2L
         XVletJw7jJwSCgD3mPPB6JC+OpKzXZfhbkt58M7T5jr8ZwKIxZ5XPcutN38BjxIY+V/S
         Le3A==
X-Gm-Message-State: AOJu0Ywuhm6mZoQTufCojJydzSdxlKZFucYG1QOmlRurfPtoJAtSRBc3
	Nl+rdKDbq7tgiHuibyGZ8pRWaX5VQRcUflZQlwC14wBNT5ZrsYfEUIt9NKK/Rw==
X-Gm-Gg: AfdE7cl/THaDLxuqq7a3QxxINYttOOIMUhDw3qV1j/u5iiF2CtOucklXQ0QkgMeY3ao
	ctSVAte11xNy4vZtXipHExr/Lix5F+QXgsCyitLseYGysFqpKqvKNixuP8QGPSP4RXsDJxU+Xx0
	ALmqLEWI9QC7NmdMmjvAibm7/bk5kZNZZZ0hjT8LEJWki/p0z+gWWW5sp/J1OvWYIFeLi6U+hND
	z4U1C/eNUBKxAoIWFlZ8Wq//97CTrL7Vqo+ZvPnBtMoUYKqErx61wp6/V3Y6F/G15xSe3Lv+Kz2
	GC20B2gIuApn8Q7PQL6YiYLVYi/T1JfdjYwOXO++dma+BI7jLZueU0G0S1dNbsUainReZ1MOXXb
	7lrylgbuZr0SVYefPVWd0siORLYTVt/Ny3Z0NhBKVgvR2r5h9S8x0mwZWOyL2JrDYyhCz/UtAAt
	p05fdt1Lk8ROoftBcJ8/t//LyD89L2grUzkXbyZjd0IkohlelFG9H2IWU=
X-Received: by 2002:a05:6214:f28:b0:8fd:6e22:6631 with SMTP id 6a1803df08f44-907789a00a0mr43372656d6.29.1784313316092;
        Fri, 17 Jul 2026 11:35:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b21d6sm22992816d6.24.2026.07.17.11.35.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:14 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 2/2] tests/unit/test_ksparser_parse: cover the .wks KickStart parser
Date: Fri, 17 Jul 2026 14:35:07 -0400
Message-ID: <20260717183507.3539287-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717183507.3539287-1-twoerner@gmail.com>
References: <20260717183507.3539287-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 18:35:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4506

Add end-to-end coverage for KickStart(): happy-path part/bootloader
lines, degenerate files (empty, comment-only, CRLF, unknown directive),
mutually-exclusive and invalid option combinations, multiple-bootloader
rejection, diskid parsing for both ptables, and include handling. The
bitbake variable lookup is neutralised so the parser runs with no
BitBake and no host tools.

The msdos --diskid cases assert that a non-integer value raises a
KickStartError naming the offending value.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 tests/unit/test_ksparser_parse.py | 217 ++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 tests/unit/test_ksparser_parse.py

diff --git a/tests/unit/test_ksparser_parse.py b/tests/unit/test_ksparser_parse.py
new file mode 100644
index 000000000000..d5edc1250efc
--- /dev/null
+++ b/tests/unit/test_ksparser_parse.py
@@ -0,0 +1,217 @@
+r"""
+End-to-end tests for the KickStart .wks parser (wic/ksparser.py).
+
+KickStart(confpath) reads a .wks file line by line, runs each line
+through an argparse-based grammar, validates filesystem/option
+combinations, and builds Partition objects plus a bootloader config.
+It is pure logic apart from get_bitbake_var() (used for ${VAR}
+expansion and the bootloader APPEND), which these tests neutralise so
+no bitbake or host tools are needed.
+
+Each test writes a small .wks file and asserts on the parsed result or
+on the specific error raised.
+"""
+
+import sys
+from pathlib import Path
+
+import pytest
+
+_SRC = Path(__file__).resolve().parent.parent.parent / "src"
+if str(_SRC) not in sys.path:
+    sys.path.insert(0, str(_SRC))
+
+import wic.misc as misc
+import wic.ksparser as ksparser
+from wic.ksparser import KickStart, KickStartError
+
+
+@pytest.fixture(autouse=True)
+def no_bitbake(monkeypatch):
+    """Neutralise bitbake variable lookups in both modules.
+
+    get_bitbake_var is imported into ksparser's namespace and also used
+    via misc; patch both so ${VAR} expansion and APPEND resolve to None
+    instead of trying to run `bitbake -e`.
+    """
+    monkeypatch.setattr(misc, "get_bitbake_var", lambda *a, **k: None)
+    monkeypatch.setattr(ksparser, "get_bitbake_var", lambda *a, **k: None)
+
+
+def _wks(tmp_path, text):
+    path = tmp_path / "test.wks"
+    path.write_text(text)
+    return str(path)
+
+
+def _parse(tmp_path, text):
+    return KickStart(_wks(tmp_path, text))
+
+
+# ---------------------------------------------------------------------------
+# Happy path
+# ---------------------------------------------------------------------------
+
+class TestParseHappyPath:
+
+    def test_single_part(self, tmp_path):
+        ks = _parse(tmp_path, "part / --source rootfs --fstype ext4 --size 100M\n")
+        assert len(ks.partitions) == 1
+        p = ks.partitions[0]
+        assert p.fstype == "ext4"
+        assert p.size == 100 * 1024
+        assert p.mountpoint == "/"
+
+    def test_defaults_applied_without_fixed_size(self, tmp_path):
+        ks = _parse(tmp_path, "part / --source rootfs --fstype ext4 --size 1M\n")
+        p = ks.partitions[0]
+        assert p.overhead_factor == KickStart.DEFAULT_OVERHEAD_FACTOR
+        assert p.extra_filesystem_space == KickStart.DEFAULT_EXTRA_FILESYSTEM_SPACE
+
+    def test_partnum_increments(self, tmp_path):
+        ks = _parse(
+            tmp_path,
+            "part /boot --source bootimg --fstype vfat --size 50M\n"
+            "part / --source rootfs --fstype ext4 --size 100M\n",
+        )
+        assert [p.lineno for p in ks.partitions] == [1, 2]
+        assert len(ks.partitions) == 2
+
+    def test_bootloader_parsed(self, tmp_path):
+        ks = _parse(tmp_path, "bootloader --ptable gpt\n")
+        assert ks.bootloader.ptable == "gpt"
+
+    def test_comment_and_blank_lines_ignored(self, tmp_path):
+        ks = _parse(
+            tmp_path,
+            "# a comment\n"
+            "\n"
+            "   \n"
+            "part / --source rootfs --fstype ext4 --size 1M\n",
+        )
+        assert len(ks.partitions) == 1
+
+
+# ---------------------------------------------------------------------------
+# Degenerate files
+# ---------------------------------------------------------------------------
+
+class TestParseDegenerateFiles:
+
+    def test_empty_file(self, tmp_path):
+        ks = _parse(tmp_path, "")
+        assert ks.partitions == []
+        assert ks.bootloader is not None  # defaults filled in
+
+    def test_comment_only_file(self, tmp_path):
+        ks = _parse(tmp_path, "# only comments\n# nothing else\n")
+        assert ks.partitions == []
+
+    def test_crlf_line_endings(self, tmp_path):
+        ks = _parse(tmp_path, "part / --source rootfs --fstype ext4 --size 1M\r\n")
+        assert len(ks.partitions) == 1
+
+    def test_unknown_directive_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "frobnicate everything\n")
+
+
+# ---------------------------------------------------------------------------
+# Mutually-exclusive and invalid option combinations
+# ---------------------------------------------------------------------------
+
+class TestParseInvalidCombinations:
+
+    def test_size_and_fixed_size_conflict(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype ext4 "
+                             "--size 100M --fixed-size 200M\n")
+
+    def test_fixed_size_with_overhead_factor_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype ext4 "
+                             "--fixed-size 100M --overhead-factor 1.5\n")
+
+    def test_squashfs_with_label_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype squashfs --label boot\n")
+
+    def test_squashfs_with_fsuuid_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype squashfs --fsuuid 0x1234\n")
+
+    def test_erofs_with_label_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype erofs --label x --size 1M\n")
+
+    def test_use_label_without_label_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype ext4 --size 1M --use-label\n")
+
+    def test_msdos_fsuuid_too_long_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "part / --source rootfs --fstype msdos "
+                             "--size 1M --fsuuid 0xDEADBEEF12\n")
+
+
+# ---------------------------------------------------------------------------
+# Multiple bootloaders
+# ---------------------------------------------------------------------------
+
+class TestParseBootloader:
+
+    def test_two_bootloaders_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "bootloader --ptable gpt\nbootloader --ptable msdos\n")
+
+    def test_msdos_diskid_integer(self, tmp_path):
+        ks = _parse(tmp_path, "bootloader --ptable msdos --diskid 0x12345678\n")
+        assert ks.bootloader.diskid == 0x12345678
+
+    def test_gpt_bad_diskid_raises_kickstart_error(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "bootloader --ptable gpt --diskid not-a-uuid\n")
+
+    def test_msdos_bad_diskid_raises_kickstart_error(self, tmp_path):
+        # A non-integer --diskid on an msdos ptable must raise a described
+        # KickStartError, not an opaque AttributeError from the error path
+        # interpolating a missing attribute.
+        with pytest.raises(KickStartError) as excinfo:
+            _parse(tmp_path, "bootloader --ptable msdos --diskid not-an-int\n")
+        # The message names the offending value so the user can see what
+        # was rejected.
+        assert "not-an-int" in str(excinfo.value)
+
+    def test_msdos_bad_diskid_hex_string_rejected(self, tmp_path):
+        # int(x, 0) parses "0x..." but a stray non-hex digit still fails;
+        # the same described KickStartError path handles it.
+        with pytest.raises(KickStartError) as excinfo:
+            _parse(tmp_path, "bootloader --ptable msdos --diskid 0xZZ\n")
+        assert "0xZZ" in str(excinfo.value)
+
+    def test_gpt_diskid_uuid_parsed(self, tmp_path):
+        ks = _parse(
+            tmp_path,
+            "bootloader --ptable gpt "
+            "--diskid 12345678-1234-5678-1234-567812345678\n",
+        )
+        assert str(ks.bootloader.diskid) == \
+            "12345678-1234-5678-1234-567812345678"
+
+
+# ---------------------------------------------------------------------------
+# Include handling
+# ---------------------------------------------------------------------------
+
+class TestParseInclude:
+
+    def test_include_missing_file_rejected(self, tmp_path):
+        with pytest.raises(KickStartError):
+            _parse(tmp_path, "include does-not-exist.wks\n")
+
+    def test_include_pulls_in_partitions(self, tmp_path):
+        inc = tmp_path / "inc.wks"
+        inc.write_text("part / --source rootfs --fstype ext4 --size 5M\n")
+        ks = _parse(tmp_path, "include inc.wks\n")
+        assert len(ks.partitions) == 1
+        assert ks.partitions[0].size == 5 * 1024
-- 
2.50.0.173.g8b6f19ccfc3a


