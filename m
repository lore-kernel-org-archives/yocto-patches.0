Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D96C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:51 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39524.1782891643629284491
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DhBr/udh;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e622cc874so19018285a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891642; x=1783496442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mQcRXUgEI8W4D4U44K3nCuFCRFgIDOVPPX/UhC27ik=;
        b=DhBr/udhOqi4LhHSlzPfA4PF5E5OATq65k+8gPBK7EI2OYePPb4YVgkoiEIyQ4erfi
         dgMMXbd7FoEhoxpNDrkTc9+ypKy8vN9admFkQnc8c6x9HUb/Y1KbP0wt6pPvRUemicIw
         8bjqmLpo86q6iCo4Fgpw+nvcvYgvplhTup3l53SLan9tGYXeaDvY5GX17QwYX0RIu4oE
         su48V2bD+7e8raNBxGFJwGUO1beWPLUp2TnX+fm8Shq53tKP+IZVIpdwwnx4cEVVBXNC
         8MfQwkBS7vpJEtFqQAtZyS0mgxQ+WkR7imTWnCXYwXAIFoaQxSiWItZW52wqRXRa6kqn
         68+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891642; x=1783496442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/mQcRXUgEI8W4D4U44K3nCuFCRFgIDOVPPX/UhC27ik=;
        b=dtQ9WPP7gwwwAa59tsLjO6I2cFNwpClt9QR0qG+lPnGIkq3rLEIZBjuJc403SzAZIY
         V6JzQmlhaIQ/KumrzmWtBZPVOgVNDKPNBYplLw+t+bmmhfy0RBI2i36gkRBbZxuLjYwz
         dM6zOiS20M9YFot3aXw2NKEPqI9n/7/UzPMlSlJ0SLWMPi2gVjESnhMUBOqwCNpCyUFs
         7zvraDx1eRukv5N7gglZedoe7Qp31eZRC3sKMW5p2QVqlgEedX9LxkxUCm+TAr2+ULYq
         0uTNZuU4mtUtggnYJX/pYga2Oom9XrUNPY/euiZBTAv+/jsRJdAcQJGpA2g8sp/caV9g
         h2Iw==
X-Gm-Message-State: AOJu0YwjGdM75dtIvOuC3wOpjVNnMUzGO4U/UqPRIfKuhjTlsMrHbHXA
	QIeR6UynJkBMaMF7otR4mVj2Mhpvrv0rvFG9NWGsQG+E9vERgGe1iHcWkhxdDg==
X-Gm-Gg: AfdE7cm+yd8dz1D3Nq/WI9jQzJOTWsdgYGsA5Vi/pnuyVEoGT8tJxUibnagDKkttE1q
	PItGWy8tyH3JNEHpw085QgEI77pTxk401exgGsd9lw+SItH+YjehFIGmJzzmX0m+qDgH4VEHfVi
	PBh0HZCDeNIu8HJKmGXMmPHE29SUkkjt8x7JPxEUNkYDCmMU79m/9B60fEpkOSSuzixPaWwtpLR
	y2C8/yKmdo0MwOwJHtu1RmPM8WxVJPlnn6/4QO1hUKA/me7AsliMd6Yu09e5FgEariRHaNpWvoU
	r11xyzh92tXXws32Bhe51yCBsefWV+Z8tdqdKcxHRFF5bmtKhG7dIa+JAAaXo2bsG539W3mOz5L
	Di3Q//XF1Iuq6tMy9sTJbGLmY7YHr0EvgXIXvxmHaJAe/tySuqKTbHGtQcddy/4GWb94c05ny9X
	VuP6Xxryvg8c/F06MoQjKmEL00773gaFZUqX3cz4QI/w0eAIoqSO2brC0=
X-Received: by 2002:a05:620a:4451:b0:92d:d721:3fd1 with SMTP id af79cd13be357-92e78534bdamr68029885a.74.1782891642326;
        Wed, 01 Jul 2026 00:40:42 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:39 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 04/10] tests: add optional coverage reporting to run-tests.sh
Date: Wed,  1 Jul 2026 03:40:24 -0400
Message-ID: <20260701074030.1090807-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4336

Knowing which lines a test run actually exercised is the difference
between "the suite is green" and "the suite is green and we know what
it touched". This commit wires branch coverage of the wic source into
the runner, kept entirely opt-in so a plain run stays fast and quiet.

pyproject.toml gains coverage and pytest-cov in the tests extra, so
"pip install -e .[tests]" pulls in what the new flags need.

run-tests.sh gains two options:

  - --coverage measures branch coverage of src/wic during the run and
    prints a terminal report listing the lines that were missed;

  - --html [DIR] additionally writes a browsable HTML report (default
    htmlcov/, or DIR if given) and implies --coverage.

If --coverage is requested but pytest-cov is not installed the runner
fails loudly with the install command rather than running without the
measurement it was asked for.

The coverage data file and the HTML report directory are build
artifacts, so .gitignore learns to ignore .coverage and htmlcov/.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 .gitignore         |  4 ++++
 pyproject.toml     |  2 ++
 tests/run-tests.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 07992096c0fb..534c49538091 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,7 @@
 
 # pytest cache
 /.pytest_cache/
+
+# coverage data and reports
+/.coverage
+/htmlcov/
diff --git a/pyproject.toml b/pyproject.toml
index d660e39007c4..ece2757bb686 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -24,6 +24,8 @@ Repository = "https://git.yoctoproject.org/wic"
 [project.optional-dependencies]
 tests = [
     "pytest >= 7.0",
+    "coverage >= 7.0",
+    "pytest-cov >= 4.0",
 ]
 
 [project.scripts]
diff --git a/tests/run-tests.sh b/tests/run-tests.sh
index 9db6d50338d6..a483da6a63a6 100755
--- a/tests/run-tests.sh
+++ b/tests/run-tests.sh
@@ -13,9 +13,13 @@ set -euo pipefail
 usage() {
     cat <<'USAGE'
 Usage:
-  tests/run-tests.sh [pytest args]
+  tests/run-tests.sh [--coverage] [--html [DIR]] [pytest args]
 
 Options:
+  --coverage    also measure branch coverage of src/wic and print a
+                terminal report listing the lines that were missed
+  --html [DIR]  also write an HTML coverage report (default dir:
+                htmlcov/); implies --coverage
   -h, --help    show this help and exit
 
 Anything else is passed straight through to pytest (for example a
@@ -24,6 +28,9 @@ tests/ is run.
 
 Examples:
   tests/run-tests.sh                  # whole suite
+  tests/run-tests.sh --coverage       # + terminal coverage report
+  tests/run-tests.sh --html           # + HTML report in htmlcov/
+  tests/run-tests.sh --html /tmp/cov  # + HTML report in /tmp/cov
   tests/run-tests.sh -k filemap -v    # pass args through to pytest
   tests/run-tests.sh tests/unit       # a single tier or file
 
@@ -34,9 +41,25 @@ USAGE
 REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
 PY="${PYTHON:-python3}"
 
+coverage=0
+html=0
+html_dir="htmlcov"
 pytest_args=()
 while [ $# -gt 0 ]; do
     case "$1" in
+        --coverage)
+            coverage=1
+            ;;
+        --html)
+            coverage=1
+            html=1
+            # Optional directory argument: consume the next token only if
+            # it is not another option or the pytest pass-through marker.
+            case "${2:-}" in
+                ""|-*|--) ;;
+                *) html_dir="$2"; shift ;;
+            esac
+            ;;
         -h|--help)
             usage
             exit 0
@@ -72,4 +95,18 @@ if [ ${#pytest_args[@]} -eq 0 ]; then
     pytest_args=("tests")
 fi
 
+if [ "$coverage" -eq 1 ]; then
+    if ! "$PY" -c "import pytest_cov" >/dev/null 2>&1; then
+        echo "error: coverage requested but pytest-cov is not installed." >&2
+        echo "       run: $PY -m pip install -e \".[tests]\"" >&2
+        exit 1
+    fi
+    cov_args=(--cov=wic --cov-branch --cov-report=term-missing)
+    if [ "$html" -eq 1 ]; then
+        cov_args+=(--cov-report="html:${html_dir}")
+        echo "HTML coverage report: ${html_dir}/index.html" >&2
+    fi
+    exec "$PY" -m pytest "${pytest_args[@]}" "${cov_args[@]}"
+fi
+
 exec "$PY" -m pytest "${pytest_args[@]}"
-- 
2.50.0.173.g8b6f19ccfc3a


