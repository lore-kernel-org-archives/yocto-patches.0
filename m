Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73148C4450A
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:59 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.887.1784154773056621771
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=a2ODggNE;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f0d6853360so43297776d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154772; x=1784759572; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hzknf4H9TyLnXFxGkY4rAzItZggB8hKQ5vgDhzh529s=;
        b=a2ODggNECpAOLKizVndNx2ykl/moBBhE1NsNgMw9KvNgkL4GttuZbkEZleErB4VUaf
         k/ZzIbeRGme98TWoFmsIVhmGaZazYs/KBEvgs6W2asPUA2lF1gkM8r9kqmTfGAHWBYr8
         DRyZtL/0ex/9vaYkaLI6qxgs44vGXIN/ZYHCuH9LTR82YxuqOH3AvpsMBLbh3w8P72A3
         afWQtK2DA4USN1PdeF+g5xsOwH4yLUSkRNLb17v/xFo11H3vd3iRO/Ou2EBaWoI2cA3g
         JiOQdL4DKF+Hz0zwggsfFFfpTGCGRtAkO4aNHTV1gA46M9v+n8umKoj5HXA3rvV0Vhn2
         xDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154772; x=1784759572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hzknf4H9TyLnXFxGkY4rAzItZggB8hKQ5vgDhzh529s=;
        b=c4co9EjgB8LY+2M9tRqjxZZ6UIvoKbZAi+ax+6Ew9wdDafQvTr42Bv3q6dnPv1fi37
         Tb+jJfebVoAuQ04biEFLNLrv5uO8UX0HvVKIgVUnWynkydGd4aMs1d9eQwZWADsrZas4
         1vp0d3fdrBqADOHTQZz2pdOvj1yxaFGAp6aE2PhzWn+VwTfRmTbJjviAWqFhL9T+2sgA
         L3sKe3+zYtBDqcNy1OT2iUCUigIBugoq067ZneKu4c6bS18tyYz2SEZq1RU8kFdkr8Np
         thHDMVGxZpMNShUDhbEpeE06aLyKcS6pwn8CuQsbbHxoM6SoyHg4Q3tOBgyAClBPcZz8
         YmSw==
X-Gm-Message-State: AOJu0YyFLFsTOweg+TNaalp3pcO0bA1xPXSuBI/J3KDs+HKeI490MnsJ
	LNAPM/2gADifj9cLCodg2DfhMfssN/khaVgRIKO6zOQQNz5C1Qero50EY9MEOw==
X-Gm-Gg: AfdE7cne0ec/AiU8NuQq4AkHxJRC92w5DtC5NzDJyNPTMdRN+0dsEYuxEstDF8GkEUi
	rCDD2A/atQV2l/ryfJK/CaZ6Z9PYKfOV60n/7gH0oHT/THeKA2qlKgFd5/2tHHSixMr0K1NTBLL
	MM74xFuo1ReiwLo+xiRvW3l8kGy/4QCooxPjK99OUymnOifdD8QBxCYGEUGgvVTjR3F5nNvG/UR
	GcZuJ8gPF1uJamwh9zTz//GNj6w76haJBnJAq5aMZ2PzTnaYwE31VO7K97BWXZ1Q86r1k1PYspH
	Rw56B5htx+EkmJyrbnLLW5QjNbSySsqHsLwdYjussHjhMRSVY+1YIvJjPKqCL/PTAndw1FTiz+q
	o70OetPR4Dmjy+nVnG8fJf6TPdQqPlq6MGIZ4iEBgqfnP+VMghZAyujzIXygEydhGEH4syBV9AP
	8VByCQPSbjakcU1pSL0gxGd3icuwj2eVuzii0zbZh2upnU
X-Received: by 2002:a05:6214:500e:b0:8ef:5b18:65ec with SMTP id 6a1803df08f44-9074c70b5cemr93457776d6.15.1784154771681;
        Wed, 15 Jul 2026 15:32:51 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:50 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 5/5] tests/unit/test_ksparser_types: cover ksparser's argparse types
Date: Wed, 15 Jul 2026 18:32:26 -0400
Message-ID: <20260715223226.3371498-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4489

Add direct unit coverage for sizetype(), overheadtype(), and
systemidtype(): the accepted KiB/byte-mode units and default-suffix
handling, the >= 1.0 overhead contract, and the 0x-prefixed system-id
byte range, together with the boundary and malformed inputs each
rejects.

The cases pin behaviour that is easy to regress: sizetype() rejects a
negative count, overheadtype() raises a clean ArgumentTypeError (not a
TypeError) for a sub-1.0 factor and refuses nan/inf, and systemidtype()
accepts only an explicit 0x-prefixed hex byte.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 tests/unit/test_ksparser_types.py | 226 ++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 tests/unit/test_ksparser_types.py

diff --git a/tests/unit/test_ksparser_types.py b/tests/unit/test_ksparser_types.py
new file mode 100644
index 000000000000..49ac38ba5397
--- /dev/null
+++ b/tests/unit/test_ksparser_types.py
@@ -0,0 +1,226 @@
+"""
+Unit tests for wic/ksparser.py's custom argparse types: sizetype,
+overheadtype, and systemidtype. These are wic's own input validators for
+kickstart/command-line values, so the tests pin the accepted forms, the
+rejected forms, and the boundaries between them.
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
+from argparse import ArgumentTypeError
+
+from wic.ksparser import sizetype, overheadtype, systemidtype
+
+
+class TestSizetype:
+    """sizetype(default, size_in_bytes=False) returns f(arg) that turns a
+    "<num>[S|s|K|k|M|G]" string into an integer. With size_in_bytes=False
+    the multiplier is 1 (K->1, M->1024, G->1024*1024, i.e. KiB counts);
+    with size_in_bytes=True the multiplier is 1024 and S/s means sectors of
+    512 bytes. A bare number takes the default suffix."""
+
+    @pytest.mark.parametrize("arg,expected", [
+        ("0", 0),
+        ("0M", 0),
+        ("1K", 1),
+        ("1k", 1),
+        ("3K", 3),
+        ("7K", 7),
+        ("512k", 512),
+        ("999k", 999),
+        ("1024K", 1024),
+        ("1000K", 1000),
+        ("1M", 1 * 1024),
+        ("10M", 10 * 1024),
+        ("13M", 13 * 1024),
+        ("100M", 100 * 1024),
+        ("512M", 512 * 1024),
+        ("1G", 1 * 1024 * 1024),
+        ("2G", 2 * 1024 * 1024),
+        ("3G", 3 * 1024 * 1024),
+        # a large magnitude past 2**31, to catch any 32-bit truncation
+        ("5000000K", 5000000),
+    ])
+    def test_kib_units_with_M_default(self, arg, expected):
+        assert sizetype("M")(arg) == expected
+
+    def test_bare_number_uses_M_default(self):
+        assert sizetype("M")("100") == 100 * 1024
+
+    def test_bare_number_uses_K_default(self):
+        assert sizetype("K")("512") == 512
+
+    @pytest.mark.parametrize("arg,expected", [
+        ("1S", 512),
+        ("1s", 512),
+        ("2S", 2 * 512),
+        ("7S", 7 * 512),
+        ("1K", 1024),
+        ("3K", 3 * 1024),
+        ("17M", 17 * 1024 * 1024),
+        ("1M", 1024 * 1024),
+        ("1G", 1024 ** 3),
+        # past 2**63 to confirm Python's arbitrary-precision ints hold
+        ("10000000G", 10000000 * 1024 ** 3),
+    ])
+    def test_size_in_bytes_units(self, arg, expected):
+        assert sizetype("K", size_in_bytes=True)(arg) == expected
+
+    def test_sectors_only_when_size_in_bytes(self):
+        # 'S' is a valid suffix only in byte mode; without it the suffix is
+        # unknown and rejected.
+        with pytest.raises(ArgumentTypeError):
+            sizetype("M")("1S")
+
+    # --- suffix case sensitivity -------------------------------------------
+
+    @pytest.mark.parametrize("arg", ["1m", "1g"])
+    def test_lowercase_m_and_g_rejected(self, arg):
+        # Only k/K are case-insensitive; m and g are not accepted.
+        with pytest.raises(ArgumentTypeError):
+            sizetype("M")(arg)
+
+    # --- negative sizes -----------------------------------------------------
+
+    @pytest.mark.parametrize("arg", ["-1M", "-5", "-1K", "-1024K", "-1G"])
+    def test_negative_size_rejected(self, arg):
+        with pytest.raises(ArgumentTypeError):
+            sizetype("M")(arg)
+
+    # --- invalid formats ----------------------------------------------------
+
+    @pytest.mark.parametrize("bad", [
+        "abc",       # no digits
+        "M",         # suffix only
+        "1X",        # unsupported suffix
+        "1.5M",      # float not accepted
+        "1M ",       # trailing space becomes the suffix
+        "1e3M",      # scientific notation
+        "",          # empty
+        "   ",       # whitespace only
+        "1;M",       # shell metacharacters
+        "1|M",
+        "$(1)M",
+        "1`M",
+    ])
+    def test_invalid_format_rejected(self, bad):
+        with pytest.raises(ArgumentTypeError):
+            sizetype("M")(bad)
+
+    def test_none_rejected(self):
+        with pytest.raises((ArgumentTypeError, TypeError)):
+            sizetype("M")(None)
+
+
+class TestOverheadtype:
+    """overheadtype(arg) -> float, and the factor must be >= 1.0. Anything
+    below 1.0, non-numeric, or non-finite is an ArgumentTypeError."""
+
+    @pytest.mark.parametrize("arg,expected", [
+        ("1.0", 1.0),
+        ("1.001", 1.001),
+        ("1.1", 1.1),
+        ("1.3", 1.3),
+        ("1.37", 1.37),
+        ("3.14159", 3.14159),
+        ("7", 7.0),
+        ("2", 2.0),
+        ("2.0", 2.0),
+        ("100.0", 100.0),
+        ("1000000.0", 1000000.0),
+    ])
+    def test_valid_factor(self, arg, expected):
+        assert overheadtype(arg) == pytest.approx(expected)
+
+    def test_leading_whitespace_accepted(self):
+        # float() strips surrounding whitespace.
+        assert overheadtype(" 1.1") == pytest.approx(1.1)
+
+    def test_trailing_whitespace_accepted(self):
+        assert overheadtype("1.1 ") == pytest.approx(1.1)
+
+    # --- below 1.0: a clean ArgumentTypeError, not a TypeError crash --------
+
+    @pytest.mark.parametrize("arg", ["0.0", "0.5", "0.999", "-1.0", "-0.5"])
+    def test_below_one_rejected(self, arg):
+        with pytest.raises(ArgumentTypeError):
+            overheadtype(arg)
+
+    # --- non-finite ---------------------------------------------------------
+
+    @pytest.mark.parametrize("arg", ["nan", "NaN", "inf", "Infinity", "-inf"])
+    def test_non_finite_rejected(self, arg):
+        with pytest.raises(ArgumentTypeError):
+            overheadtype(arg)
+
+    # --- non-numeric --------------------------------------------------------
+
+    @pytest.mark.parametrize("bad", [
+        "abc", "1.1.1", "M", "1,3", "1 1", "--1.1", "",
+    ])
+    def test_non_numeric_rejected(self, bad):
+        with pytest.raises(ArgumentTypeError):
+            overheadtype(bad)
+
+    def test_none_rejected(self):
+        with pytest.raises((ArgumentTypeError, TypeError)):
+            overheadtype(None)
+
+
+class TestSystemidtype:
+    """systemidtype(arg) validates an MBR partition type id as an explicit
+    0x-prefixed hex byte in 0x1..0xFF and returns the original string
+    unchanged."""
+
+    @pytest.mark.parametrize("arg", [
+        "0x1", "0x01", "0x0b", "0x0B", "0x82", "0x83", "0xFE", "0xFF",
+        "0xff", "0xFf", "0X82",
+        # odd, non-round bytes across the range
+        "0x7", "0x2a", "0x5b", "0x93", "0xa7", "0xd3",
+    ])
+    def test_valid_returned_unchanged(self, arg):
+        assert systemidtype(arg) == arg
+
+    # --- out of range -------------------------------------------------------
+
+    @pytest.mark.parametrize("arg", ["0x0", "0x00", "0x100", "0xFFFF"])
+    def test_out_of_range_rejected(self, arg):
+        with pytest.raises(ArgumentTypeError):
+            systemidtype(arg)
+
+    # --- must be an explicit 0x-prefixed hex string -------------------------
+
+    @pytest.mark.parametrize("arg", [
+        "82",        # no 0x prefix (would parse as hex 130)
+        "130",       # decimal that names a valid value
+        "+0x82",     # leading sign
+        "-0x82",
+        "0b1010",    # binary prefix
+    ])
+    def test_non_prefixed_forms_rejected(self, arg):
+        with pytest.raises(ArgumentTypeError):
+            systemidtype(arg)
+
+    @pytest.mark.parametrize("bad", [
+        "0x",              # prefix with no digit
+        "0xGG",            # invalid hex digit
+        "abc",             # not hex
+        "0x 82",           # embedded whitespace
+        " 0x82",           # leading whitespace
+        "",                # empty
+        "   ",             # whitespace only
+        "0x" + "F" * 10000,  # very long
+    ])
+    def test_invalid_format_rejected(self, bad):
+        with pytest.raises(ArgumentTypeError):
+            systemidtype(bad)
+
+    def test_none_rejected(self):
+        with pytest.raises((ArgumentTypeError, TypeError)):
+            systemidtype(None)
-- 
2.50.0.173.g8b6f19ccfc3a


