Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC09C44500
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:51 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39526.1782891647777707345
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Maaw2NDd;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f29ec73064so2278686d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891647; x=1783496447; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYdZzk0y49p9zkaYJLkHiICuaXzdqidNJRp2xn+NhJg=;
        b=Maaw2NDdDxSJ0dpXFxmWyTI/HmMK0IJb8YoCmBBCp5X6iWV8GLXiN06NYD373XTp/+
         ep8lfy+AGQcgOvdkKJy6cwJ5CLCLImAQhCqzGmyR7/AgNJmL2ZYS9vg5aucWMHrKVCDL
         3lCmiWz5p1p1Sbpv/F0PTlz2YckoQez4hH+Fq3lbc0Jc8LK3OozR5a5FMfeBVFrVTaKg
         7sP3vesMBtFhwqiZr8C7m+CLX8G0tI3G/B4+BZSejhqWgNazjmSXWlDzLQb5VUy2hQT4
         l9g0W6Qw89mA4K06QRfS5tcQTRgzLYD4HRD+JFvBguRZY1ApRoDScR21Y0ygh9ABAF1t
         nWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891647; x=1783496447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DYdZzk0y49p9zkaYJLkHiICuaXzdqidNJRp2xn+NhJg=;
        b=aNv+cAdYQp6K3e1JO+TCXFNrMZBrELe3sIEwH7R2Wt9lN6X5+MWZ5EJXXOgYqGcjP6
         gsYx5qwSsp7Bcj3xUMhhbWZo+DDUmDMjt9aepDLer90XVwUR/Du1w6lC59QYtTl3kmrV
         WWj8dO8O562cWaK9N9jUESeXOkMS7ujI/YpjMkRYBYogkG25Qu6wxoW+zwCZHRmvA8S7
         xf0Nh9fqpAV/XLNXTuYj173hjp1xaDMqLLNiaEXeK+Fs9zRqQN3uI49LXJhfx6+xSM0s
         3Ix/NZflA4pJNqBecSGpTwIHok+dV+XYUXKcZrYLMOorBMZptw5vX2DoNjx31Xq3jgjn
         fyOA==
X-Gm-Message-State: AOJu0YxfFRXjSKLkcF2fi0PTXKjwxUf2sypV7tpYIHaaOz0HiuDNGTww
	0UMSiFluBij0D5Q0xwFjiq2cHsDxiMLqJ26it55hzS3dvrT1xu9KQXCR21/Jkw==
X-Gm-Gg: AfdE7cmSUYGS8VLP7EansAJDHoHzrbJkh9lIKhWrfEdHGL0Zm7dsyLrnwU9sNrmGCG7
	ycQjgLFXpY/hT929w/d9dHzRUoD3h7fNj/5aj2aVmEW3Aas0sXumrXAOGFwmPwqT3nZyWNX6vPc
	DhMdT+EilFAwsAykl7UNcaoiI2tVkEe+/iXN9lklQ/6msdOJloG8RELVusHPCrRai0NcvqwpUaH
	CttmoBLoOl6rDw+tpbxdCKKGYQY+3+LudEfKOSwY07MaIq3fxZ55ghXdNe6C/QhiHNj6/YyPzo1
	S3jUCXxRhM4PyCAyyCYtEK8CrPC9tMM1HQPo4VBLv/2jfwcY0L/HNWofQOMg5JgTPt3yClWwI5k
	etSYeUYeiXgiNGwTEhZ6Tix38lrabk33nW+6z6+Gwh9Y6U3xRwCJW8EqPi0/iQJfkwj1D56mr5E
	d4RbZGYSgZGXjRYLM7JSLr/vKlJcSkfIiEZoUI0LvIn5nIl+Hb1ejhnws=
X-Received: by 2002:ad4:5fc9:0:b0:8ef:cfa:2a36 with SMTP id 6a1803df08f44-8f3c63db19emr6074936d6.9.1782891646570;
        Wed, 01 Jul 2026 00:40:46 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 07/10] tests/docs: add the test-authoring guide
Date: Wed,  1 Jul 2026 03:40:27 -0400
Message-ID: <20260701074030.1090807-8-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4339

A suite is only as good as the tests added to it over time, so it needs
a guide that says where a new test goes, what one looks like, and how
to choose its inputs and assertions. This commit adds
tests/docs/authoring.md.

The guide covers:

  - where a test goes: one test_<area>.py per wic module under
    tests/unit/, extending an existing file or starting a new one;

  - the shape of a test: a small worked example, a preference for
    parametrize over in-test loops so each input/output pair is its own
    named case, and use of the tmp_path fixture for scratch files;

  - asserting the correct behaviour rather than whatever wic currently
    does, so a test never bakes in a bug; when a test exposes a defect,
    the source fix lands in the same change so the test passes;

  - probing the boundaries: a checklist of input classes worth covering
    for numbers, strings, paths, types/shape, and state, each asserting
    a specific value or exception rather than merely "it did not
    crash";

  - keeping the assertion strong: never weaken an assertion to get
    green;

  - how to run just the test you wrote, with and without coverage.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 tests/docs/authoring.md | 124 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 tests/docs/authoring.md

diff --git a/tests/docs/authoring.md b/tests/docs/authoring.md
new file mode 100644
index 000000000000..c60cceb2d32d
--- /dev/null
+++ b/tests/docs/authoring.md
@@ -0,0 +1,124 @@
+# Authoring a unit test
+
+Unit tests live under `tests/unit/`, one module per area of wic, named
+`test_<area>.py`. They import the wic module under test directly and
+run in-process, so they need no host tools and no build environment.
+
+## Contents
+
+- [Where a test goes](#where-a-test-goes)
+- [Shape of a test](#shape-of-a-test)
+- [Assert the correct behaviour](#assert-the-correct-behaviour)
+- [Probe the boundaries](#probe-the-boundaries)
+- [Keep the assertion strong](#keep-the-assertion-strong)
+- [Running what you wrote](#running-what-you-wrote)
+
+## Where a test goes
+
+Group tests by the wic module they exercise, one `test_<area>.py` per
+module. Start a new file when you begin covering a module that has no
+file yet; otherwise extend the existing one.
+
+## Shape of a test
+
+```python
+import pytest
+
+from wic.ksparser import sizetype
+
+
+class TestSizetype:
+    # sizetype(default, size_in_bytes=False) returns a parser f(arg);
+    # with default "M", a bare number is read as mebibytes-in-KiB.
+    def test_plain_value_uses_default_unit(self):
+        parse = sizetype("M")
+        assert parse("100") == 100 * 1024
+
+    @pytest.mark.parametrize("arg,expected", [
+        ("1K", 1),
+        ("1G", 1 * 1024 * 1024),
+        ("0", 0),
+    ])
+    def test_suffixes(self, arg, expected):
+        assert sizetype("M")(arg) == expected
+```
+
+Prefer `@pytest.mark.parametrize` to express each input/output pair as
+its own case rather than looping inside one test, so a single bad
+value shows up as one named failure.
+
+Use `pytest`'s `tmp_path` fixture for any scratch files; a passing
+test's scratch directory is removed automatically (see the retention
+policy in `pyproject.toml`), and a failing one is kept for inspection.
+
+## Assert the correct behaviour
+
+Every assertion states the behaviour wic is *expected* to provide,
+never the behaviour it currently happens to have. A test that locks in
+a wrong result is worse than no test: it gives false confidence and it
+turns red exactly when someone repairs the code.
+
+When a test exposes a defect, the fix to the wic source lands in the
+same change as the test, so the test asserts the correct behaviour and
+passes. Do not commit a test that asserts a known-wrong result.
+
+Wrong -- bakes in the bug:
+
+```python
+# value lost its comma; asserting the broken output
+assert result["file"] == "s3://bucket/a"
+```
+
+Right -- asserts the correct output (and the fix lands with it):
+
+```python
+assert result["file"] == "s3://bucket/a,b.img"
+```
+
+## Probe the boundaries
+
+For a parameter, probe the boundary and just past it rather than only
+the comfortable middle of its range. The classes worth covering:
+
+- numbers: empty, zero, negative, the maximum and one beyond it,
+  non-power-of-two and non-multiple-of-1024/1000 values, primes,
+  fractional values where an integer is assumed, `0` versus `0.0`
+  versus `"0"`, off-by-one at a block or sector boundary, and very
+  large magnitudes near `2**31` and `2**63`
+- strings: the empty string, whitespace only, embedded spaces, tabs,
+  newlines and CRLF endings, non-ASCII characters, shell
+  metacharacters in a value that becomes part of a command line,
+  leading-dash values that look like options, over-delimited or
+  malformed forms (stray commas, doubled or missing separators), and
+  very long values
+- paths: traversal (`../`), doubled slashes, a trailing slash or its
+  absence, `.` and `..` components, broken or looping symlinks, and a
+  non-existent path
+- types and shape: each wrong type the parameter might receive (a
+  string where an integer is expected, a list where a string is
+  expected, `None`, and so on), the wrong argument count, and
+  duplicate keys or entries
+- state: a second call that must not see stale cached data, a
+  `cache=False` path that must evict, calling an operation twice, and
+  finalising a half-constructed object
+
+Each case asserts a specific outcome -- an exact value, or a specific
+exception -- rather than merely "it did not crash." A test that only
+checks for the absence of an exception will pass against badly wrong
+output.
+
+## Keep the assertion strong
+
+If a test is hard to make pass, the answer is in the code or in
+understanding the correct behaviour, never in weakening the assertion
+to something vague enough to pass. Loosening an assertion to get green
+is how a suite quietly stops catching regressions.
+
+## Running what you wrote
+
+```bash
+tests/run-tests.sh tests/unit/test_<area>.py -v
+tests/run-tests.sh --coverage tests/unit/test_<area>.py
+```
+
+A new test should leave the suite green, with zero failures.
-- 
2.50.0.173.g8b6f19ccfc3a


