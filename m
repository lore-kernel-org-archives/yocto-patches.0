Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D5C44501
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:54 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24722.1782835612627355961
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Rzs5e0XO;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92c7a0a701aso231948985a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835611; x=1783440411; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn2DjkNRyw10/1RTSalbIpM7FIRHeNivQ5guJ8/Cmdg=;
        b=Rzs5e0XOEEJHiAepFW3t0rJ79szsfZE3I/2k2y25gzUDZrXNrnvNljONa9oKdzkNit
         EQGESbqWm3G7Jw8kbUK16DzNnJHO4yvnb0E4y1UBRnCttLHd+rGqZuNpWCiyMDLKCiXW
         5blum+DiGt9NetugiZ8TWQyUkooyxsCzpWvNz8ky2RvpdYW6yuh5bcbMKas3rgl3tjyG
         sSJlXhfQBp8LqbXTNt0hvUpJUIBDfw0H3GkIrVRG1TZhPmdNcK7wImHIu4JjPTAuW5Zo
         UnTwIBHM1OtTuox+JcVeq9TbGTp7fqmUtTbCoVdCJrNY6yE6XvqwElmhKHg3wX2AbG/9
         Jsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835611; x=1783440411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wn2DjkNRyw10/1RTSalbIpM7FIRHeNivQ5guJ8/Cmdg=;
        b=Z8HeUw0sdAB3eL9PEYlYrGBz2b3hBxCEmIdmEixwurlkhxuOeBirTQE9s95kb6MTy/
         vPgbejsaQcSInwBj8vrRaFnWwCCG+YVzuvaR0Xm41MMKxevQH8ZQ55cHkRv64ilzJT06
         ZJEd2OO7DigODOw//alUYAERcjMQx/Z5OA2CcCKLph6q+onIcZEtIToR7N18+ujke6c8
         8xnv0G+eCUDgx376ZD7pL2+7u0nVgtKowtf1D95zqCjJlLDJMpwYAfGDrV7g9RW6GN6S
         VIIgcROv/fMqQeY8w3mjEd5FRjsNjJ+rhkMrj04bG2EEDi2M28zridjAwoU2+IOB2rDK
         zEoQ==
X-Gm-Message-State: AOJu0YxcfEGCWMZW47rsJTNBezaSZkqbM9ko5Ds1tJvqvR9oyepwmMCX
	32Op10dr52sBtaOd2iCCG47NPiHulkNu6XNar8MjNvdmwo1wWOFl28d5qV4KJw==
X-Gm-Gg: AfdE7clQraYyl/2YPmCEHEBbpXT4AD14LWJVypUI/LGmunjubHkd353JSgafNuraJDt
	Goz5v94o/AbsHFAX9CS0dtHXbyHvdVyA0hjCSR4VJnbqO+UN4G2vbQ4xUWtSoKSh05hLXw5Xa+x
	D6WUQG6F/Lo1REX33GcM9bl+YV7KzNza4Bu2tc+ADL6jJ7N8PyWxxLiWc0o41TeRUcqjR3NwtGO
	J+YgMcLKxZXpg1fLZDKqqfyxris41WlATkzjb8dR8Xe6fueJu2l1gq/0UCemHwueVMyea+qZmzJ
	Bk2hmeLE7E6wfmY4oE71c5IrwhGDTfyb2kGkxDmTfcjGXtxsf4iXaYBMSP6qRmFbb5mLDO8/D1p
	XO3hVPQZbPhY1xUDjUDmHrbjQDr9oKQP6UNWkJ1pEG1zD678ldE+6lL4u35RzTog2lAtREiHvMY
	leU0EFyePeSGp8KLz4ytFWeoXdjVVw+HV/5Ov/VaL0T8OUM3cMzhL0Oto=
X-Received: by 2002:a05:620a:8391:b0:92e:4867:95af with SMTP id af79cd13be357-92e62af0f9amr643052085a.73.1782835611050;
        Tue, 30 Jun 2026 09:06:51 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:49 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 5/9] tests: add ruff linting to run-tests.sh
Date: Tue, 30 Jun 2026 12:06:08 -0400
Message-ID: <20260630160612.1005451-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4326

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


