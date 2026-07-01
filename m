Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FAC44502
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:51 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39837.1782891649718384700
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gfCrmOYn;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d0db9372so2659121cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891648; x=1783496448; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q92M89GGIt1K9FOezygJ/AHJtuX7nVA7F7g4W6P8R/g=;
        b=gfCrmOYnGk6IxYG0JMy5Ai7rjglN/hah6TSWcsaeRaSc9ShPBo049KKsWLngj5J8Fu
         bwUq0OWS5I18OANzOO3kjE/q1vD66FSj/voulwhyh+xyvQGkEmlLB4bz4Hz/BFtM5QJ/
         2u1IqBeB2hM/0vvzDxsreoSlpm+gDOzZ2TRN2f60w1yxlhdqkTHOraoWLnUmc19lswCv
         ZQ/pVTFraeXpYUC0kDdXgcLEU44MR9KljY5wb+0vsJSAxqpm/KY0pQsbLgeF9gZUMTaK
         TUIDl3KHGgq+ccfEtF6Jspb1gNbz6kGILLQ1oEIDGL6YYFstZHDdYj/Zs/nO6Rirn9kI
         HsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891648; x=1783496448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q92M89GGIt1K9FOezygJ/AHJtuX7nVA7F7g4W6P8R/g=;
        b=AkJm9mnsa+6UWv+sz6jncAxAHNOHZxrc6900/KUz0w30cslkJOo0dEA8EFmqzFrx7N
         xIfKAvVVQs3t7NQM+qqCkes5pyUfyMwGPRmVFQYLGcN6maueKkKAM7fkO2LEFMCbsW3P
         XfAzx8UIDQg2mS7FDCZLxuqvsRfvBXP7PPtvEhFUttLs0CtAIrEJi7rIagZIr7GKewQE
         GJtyNC3TZyteBDnafJv0KGr842jNJKolDEQbDttTMc1iBR04xvnms/I7mpoc6bVAuJkQ
         ug82FDkiTufuh8G0o8xZx4HkLON7O9PPIhdCXg9qAtaCQiLaQ7z/AmpQKN0qwqBdY5Rc
         Kx2w==
X-Gm-Message-State: AOJu0Yx7uxqtQTDeGb5oAevO+vLqHM7+zchy5/kAfphyFU5GyrJnYyM7
	WrZfnd5w1smzwMic43HE81s06KrWL+71fIcAX/PhTMnikP9tSizwFkkS4li0xw==
X-Gm-Gg: AfdE7clzdGugzE9usmyfsI4On6tiFIibsCCv+QELLS5yiJe7IQ/XZG0B9LwAMKwvmLJ
	J7+tHMw2SnTJytXB7y4mJOjwQi6gK+0NtNhACbn+P26oJnv9hjR7aqGrFZSb4iB5PPtNjFDkGpo
	PCkmRQSvomWh5hkZCau5UT99Mk8GiSAn3B9rBNwsbueE/+69iehgTCG2yYauaZCBFAxqSU9zqDA
	Y7JLef+a4aTD9Trk1ukKEsiii4zxu/W4Ri0v09/g8TPub3ORcE+YQWcJUuuxbbDqQsYjxORIrmO
	HgOSYeKLUEDjQ2ZoED+UfZf7WM6r5I5/B3DfGP6QZu5FAfGN2kwnbN1i6VQAFh2Rzd9v5voVvt2
	r9DDj0U03R3XRLOo1GEWho9zASajenWMTNwsdQLOLmra2HZpSzDKNb2a1+wdCFldOHta8Rdz9XN
	UPeI0E1Thgt1Uz6KYDcEjq1KbBaK/0nTfoEjFUOjQCkBjJLfilhfS7ILQ=
X-Received: by 2002:ac8:7f81:0:b0:51c:ee2:fe75 with SMTP id d75a77b69052e-51c26b1d1dbmr5648211cf.47.1782891648549;
        Wed, 01 Jul 2026 00:40:48 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:46 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 08/10] tests: ignore E402 in the test tree for the sys.path bootstrap
Date: Wed,  1 Jul 2026 03:40:28 -0400
Message-ID: <20260701074030.1090807-9-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4340

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
changes in v3:
- no change in this revision.
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


