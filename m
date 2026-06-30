Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F7C43327
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:54 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24720.1782835610833409333
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q7jd/fQ6;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e602d2c0fso77265885a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835610; x=1783440410; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R6If7c6OZw39q32lIaEALMs2iTGuDqe9/Yq38qAI7A=;
        b=Q7jd/fQ6y/5uderQmIN/asB2zs/Jpf4NIEbYg/GNjj/AgDQY2Pm9GghaXOo+1VL5Uu
         xihWif1yCdSRK/dQvcdEQsv5gJi4chZwRLiP5DNlclw5H98D2LaEC6w7F1T0WAD1VngF
         yeoUWJiSZaLEFMbmSyQsT5nRHuKYV/DwcfsB2HO2hfYnnKpTcHiTSOf6yZmsbVRpoQUV
         65x+JfIwxp3hHenXbxLgQRVYBjk/ODyMp1epCfEWPGFiLaOaFXCtdnfRoPFgmNJWJM1A
         CLNYNzRbHkWU/MLyVUa33B4VJba2WYD1/Xbj82eTnBmsBmYKJzpoOC0MpZXvCPZPrSK9
         5pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835610; x=1783440410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+R6If7c6OZw39q32lIaEALMs2iTGuDqe9/Yq38qAI7A=;
        b=FZn9Lqf+itWXaK+33vqzhx/PIL8upBKcUIIJ4vaFhXYdgODCJLqeqBtpogwXf7bqLS
         1U/SXaGc3hzE9gs02nl7feRbi3CMdCDytZob0u11KP1qGRpPx41DCxie2LC2pw748Tr5
         lyVUXELPwKwKALEpMcNixNiOGF5FgB88PrtNowmqLxJlgHguWqsDWUQwBaPEZcZT1oks
         6Mqsh1YVMC32jqRGBK8gwyrQ54gs5AA93PJ00Accd7e6VZItQqex+UgS0/oNAFHhq/VF
         lzedpMR7oxkXhBinFkBE8CULhOydlI/qD7AIpkaiDQgg4nAxzuF+6uh+G1tI5atBZPN7
         MytA==
X-Gm-Message-State: AOJu0YzUi1IeIzNft/yGGEtZuq9xY0fGcq/qjwWiob6nwoMbS+tNDchP
	/f4Sl3fBdVDWT0gBNho+Tk6Zmt3gfxdFclFZu5BMz3MRo/Blxgsd4XF8s8UMtQ==
X-Gm-Gg: AfdE7cmLxKBDvhsZmF6yQG99APOsbFRzsWA23Eozx6DIc02BQtCUSfyR9hCLuE1Wq/E
	V3XtxKmb5vFMSAqV1A1H7X/I4h6a/KGTnHDRztmuKe5F6OgfcK3br1n2LdKplx7tNqcBLendyXk
	Wb2a9GoD2A3TUHJNBj2V62dH6OTmefcYoC3UAZTeNUAxzqlZityJHLL5xzJ0L9qAtBzBx4T5goL
	6o5BpsS1iyYck9Ee2CZif76nSbBm4eT5E57qqaeOKnAN1Zok2cVQrcP3ZrzEZ0TY8jNVhr5YYnv
	DW9Wn0TaMkw239hmDQ2QxsI2ObYrxrRduLjz8+fiV4lBbhOCugzh9B/mbkJE0Mnv5sGyDsat8rq
	OPoKaQGrEq3ytuqYSph3sFl/UdlFEdxGh8ldwOXdTWSkCFjKxM2O7d/yGP9QFfqq+EXqfCIkIpt
	HcvWbAuc/XG3b0rKJEtiv6YHrK2kvIxr1+C2SaRCgBdsIAWOjeI0zl03o=
X-Received: by 2002:a05:620a:2a01:b0:910:c308:159f with SMTP id af79cd13be357-92e697a3307mr322256985a.28.1782835609342;
        Tue, 30 Jun 2026 09:06:49 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:47 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 4/9] tests: add optional coverage reporting to run-tests.sh
Date: Tue, 30 Jun 2026 12:06:07 -0400
Message-ID: <20260630160612.1005451-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4325

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


