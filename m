Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9963AC43602
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:51 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39525.1782891645088313295
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qe4zevRs;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eefd4a8057so4494746d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891644; x=1783496444; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FNUNHVfuGVDIE7QbmCHde7NVjnWrHF198jUhaGuOORo=;
        b=qe4zevRsp3Oph99HdqsVA2k5pbGgMYIFOJ2DGy1g1Kn0qjv6NKoFs+9bp37cPGPpY4
         UEEvLOFI6NEMP+2/RZ1ftFiq0X1LjRIW5jxoPNFwZQfzeuYRZYr++qZdLYyzcv/dSj0I
         IXANtAKLEmoRYMYhRvXihJnWXgQKt/0rzo4xvG63Oi4HKYn0QnBWVNIvY/JdwJqofWrE
         GGdpBYxIRWfJ/H93iT16pw43OOUZCg8JNZOt2rTJFdESyHEVKQE25y55dEjlRJM8csWb
         C+0RxrxFirhNEC3dz4EpN5zS8y9sEoVhn40iDjOa3DXZ2k8kMXPpZIcMFBi+wdNru71Z
         OVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891644; x=1783496444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FNUNHVfuGVDIE7QbmCHde7NVjnWrHF198jUhaGuOORo=;
        b=sOaa1SPMDIOJWdOwPCLXU2ibByHlsOUHp2np7zU4hw3vp3oKnEf7cLXBWw3zfvcEsz
         7V2aIEQUUlX4W4IM7UKiI3SvsTlfiYC+gLbyZYXHqNyh1I+YtyCz99DGgCEexXvUHnx5
         upSwrGZHcnI+aIvi2/Jw/WchvTVZi+snfOIJLePR4KUYV2S2VIo9RG4JxmVtcxAuw6FZ
         8Mfol/8xPbxqFLfpHzKfP7hvuNMXYwN90emX8tCnEDX8Wgm/9wsyBAjdPtNQbh7tDoIk
         887CVfs5E/ebStfdUd6qWVStOklY/LFlYin/vcGmaOeONAvys8Iwz3+/dRy5cns4728G
         vmIA==
X-Gm-Message-State: AOJu0YzdviUPvjRJNjOrwXZQASOmlR5uHi8DMqrBfFIUi416E8Aer9mF
	z0Vx2iVYNYO+RDi4XTgjA9MjLVidmbgJEqOze/RI3uxzGsuZBJojIY7KRJnwSw==
X-Gm-Gg: AfdE7cnN5NjjMf9JAjKxRR2KTfpw21A3dBfEAfiO7ArTWSVZM1uANwMMZJVvLhCkALT
	AOs3NCu1vblBcDn0DQNAS/BGf+ZGrBxQP2sYrtAovzQEIuad16pk/yJn2NHigrQijpoU1KCcGjP
	8+KFg4zfaht/LU+fwiC7SWtoL/bK9L4U/c6LMZ+4p/9NcqfBUIEEbQTnf7xkdtYtIxsLopzz6WJ
	QElW8fyruzGanzodtjNczGPOJAsaWLwZOBetIEA4dkOMneVsichFHWH9PwrMpb87I7h6xuIhmk7
	BYwSHP7Nt5u377tkUMAMwFUk0MZZuj/PYbz+fuz5UMz6f6Ka7b2YVH725kWW9SZW7ZYwqecXb3Z
	ZU5sRTNqfelbIo88yq79wUshcJZTNvPudWoUerdOL2eVw/YQUyJ+9oFN4CAWsJdWq3/MdjwFqtB
	NYTSRJZaJ0ef5CnWuxC5QjbwbqTOjS8d03kkeNXezR8z/YqsZqiFpm7WQ=
X-Received: by 2002:a05:6214:2dca:b0:8e4:d2ba:d677 with SMTP id 6a1803df08f44-8f3c7e708demr5879746d6.29.1782891643663;
        Wed, 01 Jul 2026 00:40:43 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:42 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 05/10] tests: add ruff linting to run-tests.sh
Date: Wed,  1 Jul 2026 03:40:25 -0400
Message-ID: <20260701074030.1090807-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4337

A test suite is only trustworthy if its own code is clean, so this
commit brings ruff into the runner and holds the test tree to a clean
bar. It also makes it easy to preview what ruff thinks of the wic
source, without yet enforcing it.

pyproject.toml gains ruff in the tests extra and a [tool.ruff] section.
The configuration is deliberately minimal for now: the test suite is
the only tree under an enforced clean bar; the wic source under src/ is
not yet ruff-clean and is reported, not gated.

run-tests.sh gains two lint modes, each used on its own:

  - --lint-tests runs ruff over tests/ and exits. The test suite must
    report nothing; a finding here is a bug in our own test code and is
    expected to be fixed.

  - --lint-src runs ruff over src/ and exits. The source is not yet
    ruff-clean, so this is a preview: the runner prints ruff's findings
    and exits with its status, but nothing in the suite asserts on
    them. Keeping the two trees on separate flags means cleaning up the
    source later does not disturb the test-tree gate.

A lint mode cannot be combined with coverage, with the other lint mode,
or with pytest arguments; the runner rejects such combinations loudly
rather than silently dropping the extras. If ruff is not installed it
fails with the install command.

tests/docs/linting.md documents the two modes and why src/ is held back
for now. That file replaces the tests/docs/.gitkeep placeholder, which
is no longer needed now that the directory has real content.

.gitignore learns to ignore ruff's .ruff_cache/ directory.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore            |  3 +++
 pyproject.toml        |  8 ++++++++
 tests/docs/.gitkeep   |  0
 tests/docs/linting.md | 39 +++++++++++++++++++++++++++++++++++
 tests/run-tests.sh    | 47 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+)
 delete mode 100644 tests/docs/.gitkeep
 create mode 100644 tests/docs/linting.md

diff --git a/.gitignore b/.gitignore
index 534c49538091..3c3cfb328fb0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,3 +6,6 @@
 # coverage data and reports
 /.coverage
 /htmlcov/
+
+# ruff cache
+/.ruff_cache/
diff --git a/pyproject.toml b/pyproject.toml
index ece2757bb686..656adcd4930a 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -26,6 +26,7 @@ tests = [
     "pytest >= 7.0",
     "coverage >= 7.0",
     "pytest-cov >= 4.0",
+    "ruff >= 0.5",
 ]
 
 [project.scripts]
@@ -50,3 +51,10 @@ path = "src/wic/cli.py"
 # leftover files under the pytest base temp directory.
 tmp_path_retention_policy = "failed"
 tmp_path_retention_count  = 1
+
+[tool.ruff]
+# For now only the test suite is actually linted (run-tests.sh
+# --lint-tests passes the tests/ path); the wic source under src/ is
+# not yet ruff-clean and is left out until its findings are fixed (see
+# tests/docs/linting.md). --lint-src can still be run to preview the
+# source findings, but it is reported, not enforced.
diff --git a/tests/docs/.gitkeep b/tests/docs/.gitkeep
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tests/docs/linting.md b/tests/docs/linting.md
new file mode 100644
index 000000000000..71b4de21c100
--- /dev/null
+++ b/tests/docs/linting.md
@@ -0,0 +1,39 @@
+# Linting
+
+## Contents
+
+- [Running the linter](#running-the-linter)
+- [tests/ must be clean](#tests-must-be-clean)
+- [src/ is not linted yet](#src-is-not-linted-yet)
+
+The test suite is linted with [ruff](https://docs.astral.sh/ruff/). It
+is configured in `pyproject.toml` (`[tool.ruff]`).
+
+## Running the linter
+
+The runner exposes ruff through two separate modes, each used on its
+own:
+
+```bash
+tests/run-tests.sh --lint-tests   # ruff over tests/
+tests/run-tests.sh --lint-src     # ruff over src/ (preview only)
+```
+
+A lint mode cannot be combined with coverage, with the other lint
+mode, or with pytest arguments; the runner rejects such combinations.
+
+## tests/ must be clean
+
+Our own test code is held to a clean bar: `tests/run-tests.sh
+--lint-tests` reports nothing. If you add a test that trips a rule, fix
+the test before the change lands.
+
+## src/ is not linted yet
+
+`--lint-src` runs ruff over the wic source, but the source is **not**
+yet ruff-clean, so its findings are a preview report rather than a
+gate: the runner prints them and exits with ruff's status, but nothing
+in the suite asserts on them. Treating `src/` findings as a hard
+failure now would block every run on fixes that have not landed. Once
+the source is cleaned up, `src/` can be promoted to the same clean bar
+as `tests/`.
diff --git a/tests/run-tests.sh b/tests/run-tests.sh
index a483da6a63a6..085dcc93f91d 100755
--- a/tests/run-tests.sh
+++ b/tests/run-tests.sh
@@ -14,23 +14,34 @@ usage() {
     cat <<'USAGE'
 Usage:
   tests/run-tests.sh [--coverage] [--html [DIR]] [pytest args]
+  tests/run-tests.sh --lint-tests
+  tests/run-tests.sh --lint-src
 
 Options:
   --coverage    also measure branch coverage of src/wic and print a
                 terminal report listing the lines that were missed
   --html [DIR]  also write an HTML coverage report (default dir:
                 htmlcov/); implies --coverage
+  --lint-tests  run ruff over tests/ and exit; the test suite is held
+                to a clean bar, so this must report nothing
+  --lint-src    run ruff over src/ and exit; src/ is not yet ruff-clean,
+                so this is a preview report and is not enforced
   -h, --help    show this help and exit
 
 Anything else is passed straight through to pytest (for example a
 path, -k EXPR, or -v). With no such argument the whole suite under
 tests/ is run.
 
+The two lint modes each run on their own; they cannot be combined with
+coverage, with each other, or with pytest arguments.
+
 Examples:
   tests/run-tests.sh                  # whole suite
   tests/run-tests.sh --coverage       # + terminal coverage report
   tests/run-tests.sh --html           # + HTML report in htmlcov/
   tests/run-tests.sh --html /tmp/cov  # + HTML report in /tmp/cov
+  tests/run-tests.sh --lint-tests     # ruff over tests/
+  tests/run-tests.sh --lint-src       # ruff over src/ (preview)
   tests/run-tests.sh -k filemap -v    # pass args through to pytest
   tests/run-tests.sh tests/unit       # a single tier or file
 
@@ -44,6 +55,8 @@ PY="${PYTHON:-python3}"
 coverage=0
 html=0
 html_dir="htmlcov"
+lint_tests=0
+lint_src=0
 pytest_args=()
 while [ $# -gt 0 ]; do
     case "$1" in
@@ -60,6 +73,12 @@ while [ $# -gt 0 ]; do
                 *) html_dir="$2"; shift ;;
             esac
             ;;
+        --lint-tests)
+            lint_tests=1
+            ;;
+        --lint-src)
+            lint_src=1
+            ;;
         -h|--help)
             usage
             exit 0
@@ -78,6 +97,34 @@ done
 
 cd "$REPO_ROOT"
 
+# The lint modes run ruff and exit, so each must be used on its own.
+# Reject combining them with coverage, with each other, or with pytest
+# arguments loudly instead of silently ignoring the extras.
+if [ $((lint_tests + lint_src)) -gt 0 ]; then
+    if [ "$lint_tests" -eq 1 ] && [ "$lint_src" -eq 1 ]; then
+        echo "error: --lint-tests and --lint-src cannot be combined." >&2
+        echo "       run one lint mode at a time." >&2
+        exit 2
+    fi
+    if [ "$coverage" -eq 1 ] || [ "$html" -eq 1 ] || [ ${#pytest_args[@]} -gt 0 ]; then
+        echo "error: a lint mode must be used on its own." >&2
+        echo "       lint, or drop the lint flag to run the suite." >&2
+        exit 2
+    fi
+    if ! "$PY" -c "import ruff" >/dev/null 2>&1 && ! command -v ruff >/dev/null 2>&1; then
+        echo "error: lint requested but ruff is not installed." >&2
+        echo "       run: $PY -m pip install -e \".[tests]\"" >&2
+        exit 1
+    fi
+    if [ "$lint_tests" -eq 1 ]; then
+        # The test suite is held to a clean bar; a finding here is a bug
+        # in our own test code and must be fixed.
+        exec "$PY" -m ruff check tests
+    fi
+    # src/ is not yet ruff-clean; this is a preview report, not a gate.
+    exec "$PY" -m ruff check src
+fi
+
 # Make sure the interpreter that will run pytest can actually import wic.
 # The suites pass even without an install (each adds src/ to sys.path),
 # but the session banner and any install-dependent behaviour would be
-- 
2.50.0.173.g8b6f19ccfc3a


