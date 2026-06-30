Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA7C44500
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:07:04 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24724.1782835617821504144
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=irsIrQXH;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92b21f65b60so77864185a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835617; x=1783440417; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BDSA1QKxTReYbw9OKs+BRslFftrUHOqJgjFiom/7Kk=;
        b=irsIrQXHUjurd4Mc9RhJ2bnnbFAJR0wBfQO6RXxZGX3GhAVtXTm8LwlDwEkbzSg+G6
         LAYkRanDv/0XkH5pe3gteNmiFtgeAM0kwsuTifpOnvZnPs1OtEZjtZKgBnwIOOhKe9YS
         m0015qQlRDIz6UZMUtNMt/CPxzUo3PZW9reayG7qgrLWkpQleSUSUZ+3WVgch7Ct2+mp
         DgNF8HpWQOSL3+JEKPUK0lbMa1DRaHRIVrK/wFU2Y5l6lElmGRnnI0YWQwTwvIyp0tdS
         7a/ep3n736XFQsDDgyGrEU7hadbCY6wPkckF4cmWqwS0abp1O8/KWthz72sd+IHMvRU5
         iZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835617; x=1783440417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9BDSA1QKxTReYbw9OKs+BRslFftrUHOqJgjFiom/7Kk=;
        b=N8cj3jUUYrvVr0ctjuqnx+YiRScP1m7nzyZNokHGZwdaLgqnP3Jv1Y5598rt4GU1y2
         nUNr/Y+yAldTMzWHapiSdIliX5BFwmCKRTpoiZYAT+PLNTBZawCgG+5LoX8JAlCLq40l
         RrqxXbHL1ddlZPpW0kj66ncIebe1OkRrPgtbY2nThs7KXsVWEP302orGcrhfmkLWRUXR
         RS0CZyWKNE1vH/HmSa5k0yxC0zxE5nxnCoPbtnY9fAQL+nnHF2ULHl04CxLk6U77mko3
         GD2CL+n6VKaL/Uv8k4kwr6m9EmUC/tYMnDGBNprXJItVHhVvFw7oRRd9mOdD8TTM1V6w
         1ptQ==
X-Gm-Message-State: AOJu0Yym1oxLPKxz6vJGduOFIe6trBqb9yJRDdDtwpZnxH5cO8TRpcKc
	S/5KdV0z4VJt27tSDD1eoLzK8vU8/ZCJ8My+sYZjervH9OBgqRjSGUbqsSotTg==
X-Gm-Gg: AfdE7cmkCiGvZP8WJQXLuoQYiTWjAmYuXMNOvugolHatAgim+qSNz75vMaMWP7SUezY
	N9Nz5CXVVCDR7dwyMQEhglBJG57RHSsdSG0A+LEqoTPJKjRpb/kbq31yrmHnbZrV/yg86MRoY8/
	2hvhWfWGO1sonYx/brj45UjKLG27Rjw8KxrVofZCI16OTwignT8ew8PBkzw4/24D7MrZRLpnoKD
	qFVnGHvvko8AVxHABPJVYp7Gkp7duRm90nULdAzaKa9kRadM+NmqimRa2OlHQNEkCiEyFE+CQdV
	EGBojspr1icPGBrufzNsNj9e//49jGxExCjHEEIaiz+2hkDI8bhnCxjNWjUjYXmqSlTIjwLOcTk
	ezPfVnwpfFME4i33N/kxu56O1mPl72erQx8/KbEvCcGijlSqzoND4PuPRiMKB9Gjd3x+ZA0NPyY
	n476Osz0pp0QfAFkUipxZCeUxjjMP7vYRMCBizGY03dRpb9HW3qWspjS8=
X-Received: by 2002:a05:620a:600c:b0:92e:56ea:ec69 with SMTP id af79cd13be357-92e697cbdb7mr308557085a.31.1782835616181;
        Tue, 30 Jun 2026 09:06:56 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:55 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 8/9] tests: ignore E402 in the test tree for the sys.path bootstrap
Date: Tue, 30 Jun 2026 12:06:11 -0400
Message-ID: <20260630160612.1005451-9-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:07:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4329

The unit tests that follow run against a plain checkout that has not
been installed. To do that, each test module prepends the in-tree src/
directory to sys.path and only then imports wic:

    _SRC = Path(__file__).resolve().parent.parent.parent / "src"
    if str(_SRC) not in sys.path:
        sys.path.insert(0, str(_SRC))

    from wic.bb.utils import mkdirhier

That bootstrap necessarily runs before the wic imports, which trips
ruff's E402 (module-level import not at top of file). The ordering is
required, not accidental: the import would fail without the sys.path
adjustment ahead of it.

Rather than scatter per-line noqa comments through every test module,
this commit relaxes E402 for the test tree once, via a
[tool.ruff.lint.per-file-ignores] entry scoped to tests/**. It is the
only rule relaxed for tests/; the suite is otherwise held to a clean
bar by --lint-tests.

tests/docs/linting.md gains a section describing this single exception
and why it exists.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 pyproject.toml        |  8 ++++++++
 tests/docs/linting.md | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/pyproject.toml b/pyproject.toml
index 656adcd4930a..fb42fe6dd135 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -58,3 +58,11 @@ tmp_path_retention_count  = 1
 # not yet ruff-clean and is left out until its findings are fixed (see
 # tests/docs/linting.md). --lint-src can still be run to preview the
 # source findings, but it is reported, not enforced.
+
+[tool.ruff.lint.per-file-ignores]
+# Test modules prepend the in-tree src/ directory to sys.path before
+# importing wic, so the suite runs against a checkout that has not been
+# installed. That bootstrap necessarily runs before the wic imports,
+# which trips E402 (module-level import not at top of file). The
+# ordering is deliberate; ignore E402 for the test tree only.
+"tests/**" = ["E402"]
diff --git a/tests/docs/linting.md b/tests/docs/linting.md
index 71b4de21c100..1c1bfcc06f82 100644
--- a/tests/docs/linting.md
+++ b/tests/docs/linting.md
@@ -4,6 +4,7 @@
 
 - [Running the linter](#running-the-linter)
 - [tests/ must be clean](#tests-must-be-clean)
+- [The one intentional exception in tests/](#the-one-intentional-exception-in-tests)
 - [src/ is not linted yet](#src-is-not-linted-yet)
 
 The test suite is linted with [ruff](https://docs.astral.sh/ruff/). It
@@ -28,6 +29,25 @@ Our own test code is held to a clean bar: `tests/run-tests.sh
 --lint-tests` reports nothing. If you add a test that trips a rule, fix
 the test before the change lands.
 
+## The one intentional exception in tests/
+
+Test modules prepend the in-tree `src/` directory to `sys.path` before
+importing `wic`, so the suite runs against a plain checkout that has not
+been installed:
+
+```python
+_SRC = Path(__file__).resolve().parent.parent.parent / "src"
+if str(_SRC) not in sys.path:
+    sys.path.insert(0, str(_SRC))
+
+from wic.bb.utils import mkdirhier
+```
+
+That bootstrap necessarily runs before the `wic` imports, which trips
+`E402` (module-level import not at top of file). The ordering is
+required, so `E402` is ignored for the test tree via `per-file-ignores`
+in `pyproject.toml`. This is the only rule relaxed for `tests/`.
+
 ## src/ is not linted yet
 
 `--lint-src` runs ruff over the wic source, but the source is **not**
-- 
2.50.0.173.g8b6f19ccfc3a


