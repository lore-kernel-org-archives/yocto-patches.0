Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93976C43327
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:41 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39523.1782891639846996442
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lrqdqqLq;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f032b47e3cso2540346d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891639; x=1783496439; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8AwUyqD3YHDjcfObBhFvOsCWa4Eh1L7njz67SGuOEQ=;
        b=lrqdqqLq+tlM/yJbLzL6OK1bdoMTfbyUaArMInll3z3yA1MHfgZETvwFxKFXLZJ5qJ
         dMFOd/C2raFd/4sPPBttGbc31s7Q63uUoCaBX+xqSB+7Vv15/1lkpe5gxEfLg+hkDGpq
         8xGjr6LdeUTHVxVPk42aqtNMBVtMhnQwV13Eb3nrnFQCln5x6VfZALd6HTn8pkHnQKrr
         JyTXErtFymenmsz02EWEH39Gx/jNGd+izHSSNDAquyziAuwF4mDAippkZadBcJpUR9DX
         hHInQMplFScn50hQ7Kj3PWHD09fc4uq2TGZmch6BrCXBD3oWNIyZR1fYehigRCb9UM+I
         SCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891639; x=1783496439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8AwUyqD3YHDjcfObBhFvOsCWa4Eh1L7njz67SGuOEQ=;
        b=dDUP1DB1TYUV2+6Eq5waF7Cq/a5CBNWaVuQUPg+oa4ncswzhNB6bhrxaCwvP5GBWsd
         OtLlo/TmayyMxZpN758MatfEEJ/X32Nw7bovvqNBzA0w3N3vpj6Vt3ZRnoxb5jioHlfq
         OD6cOz/e8QIC+6Emr3xUYr9NjWzYLP5sS3kU3k1sqy94W5OKx87Ifae0iGMYC5rjj8fd
         p/bD2S3pBINRh/etDjizqeEFlxtVjHN412Inab/BeR+yUyP7LD3C+xUL0EQhtiMDP/mO
         GU1kL7aHnbRQSlk8sP9mMCsB7HT99lz4eEN5THjxHCzj5fjD1EPmFK7YK9RchL9c1qXg
         3DZA==
X-Gm-Message-State: AOJu0Yz16WzqqUmW/32Whvfp6+7ayGHizBN12QDmUYdjmCLoCuHtoqyA
	gZFAFXQVJSisNX9t7impbcz+Prm1M34EeCYc5L8HIr+jlVbwo6MaYu109ITgMg==
X-Gm-Gg: AfdE7cnFF24JMnDGmToIdsAxD4CwEwtzM08b8pBc/eVQQcLC7OYl7uFPWExQYurS33x
	27osGiD+d47cxBABNLNItLyQL4qcd7WN1RxJxZsvn4KaXKKWqzoS2Ey5wwgZcqCHYrbsfygrCUp
	+KelRuLn3OYzsvYg5PYGif7koWn55pGWxWlUfjagC5EAThmFdHfpiGbW/is4GYL33an4Te1+D21
	u+PZNeHXhJjEWOJpes069rGYqBxZ0fCkDXyL8WdQyIclqA/+NKKLdtdNc2EfklCCnRtmOPuDk0A
	XX/Vi6/HkYY6eL2zhlgpakV1MsJOQpGBvXH6HXhrmhSMjcrxlGSNdXLgiuX6Op2xklxg62vFIF/
	LXN+cgIU4f6XYNbYg2NQzEep2RtgxeGI91huZwuFMDaktq8GSWx8kyEIC4sjdHt+5l1zM6IHbaM
	dpnE8H4NQlTwKvUCjUmJo5aTpm88R4Jfl1VGdJcfE+VUOoqt/pNS53xgw=
X-Received: by 2002:a05:6214:2604:b0:8f1:c359:43cf with SMTP id 6a1803df08f44-8f3c8ff7be5mr4987706d6.39.1782891638684;
        Wed, 01 Jul 2026 00:40:38 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:37 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 03/10] tests: add the run-tests.sh wrapper
Date: Wed,  1 Jul 2026 03:40:23 -0400
Message-ID: <20260701074030.1090807-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4335

The suite is run with pytest, but invoking pytest directly has two
sharp edges: it must be run from the right directory for the pyproject
configuration to apply, and it happily runs against whatever Python
happens to be first on PATH, even one that cannot import wic. A run
against the wrong interpreter produces a misleading banner and, worse,
can silently exercise a different wic than the one in the checkout.

This commit adds tests/run-tests.sh, a thin wrapper that removes both
hazards:

  - it locates the repository root from its own path and changes there
    before running, so it works regardless of the caller's directory;

  - it checks that the interpreter can import wic before handing off to
    pytest, and fails loudly with the install command if it cannot;

  - with no arguments it runs the whole suite under tests/; any
    argument it does not recognise (a path, -k EXPR, -v, ...) is passed
    straight through to pytest, and an explicit -- forwards everything
    after it.

The interpreter can be overridden with the PYTHON environment variable
(default python3). -h/--help prints usage and exits.

The README Testing section gains the run-tests.sh invocation alongside
the install step.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 README.md          |  1 +
 tests/run-tests.sh | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/run-tests.sh

diff --git a/README.md b/README.md
index 497ebb1de0f0..e557eb435316 100644
--- a/README.md
+++ b/README.md
@@ -56,6 +56,7 @@ extras pull in everything the suite needs:
 
 ```
 pip install -e ".[tests]"
+tests/run-tests.sh
 ```
 
 See [tests/docs/](tests/docs/) for how to run the suite and the
diff --git a/tests/run-tests.sh b/tests/run-tests.sh
new file mode 100755
index 000000000000..9db6d50338d6
--- /dev/null
+++ b/tests/run-tests.sh
@@ -0,0 +1,75 @@
+#!/usr/bin/env bash
+#
+# Run the wic test suite.
+#
+# Thin wrapper around pytest that works from anywhere in the checkout:
+# it locates the repository root, makes sure the interpreter can import
+# wic, and then hands off to pytest.
+#
+# Needs the test extras: pip install -e ".[tests]"
+
+set -euo pipefail
+
+usage() {
+    cat <<'USAGE'
+Usage:
+  tests/run-tests.sh [pytest args]
+
+Options:
+  -h, --help    show this help and exit
+
+Anything else is passed straight through to pytest (for example a
+path, -k EXPR, or -v). With no such argument the whole suite under
+tests/ is run.
+
+Examples:
+  tests/run-tests.sh                  # whole suite
+  tests/run-tests.sh -k filemap -v    # pass args through to pytest
+  tests/run-tests.sh tests/unit       # a single tier or file
+
+Needs the test extras: pip install -e ".[tests]"
+USAGE
+}
+
+REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
+PY="${PYTHON:-python3}"
+
+pytest_args=()
+while [ $# -gt 0 ]; do
+    case "$1" in
+        -h|--help)
+            usage
+            exit 0
+            ;;
+        --)
+            shift
+            pytest_args+=("$@")
+            break
+            ;;
+        *)
+            pytest_args+=("$1")
+            ;;
+    esac
+    shift
+done
+
+cd "$REPO_ROOT"
+
+# Make sure the interpreter that will run pytest can actually import wic.
+# The suites pass even without an install (each adds src/ to sys.path),
+# but the session banner and any install-dependent behaviour would be
+# wrong, so fail loudly instead of running against the wrong interpreter.
+if ! "$PY" -c "import wic" >/dev/null 2>&1; then
+    echo "error: '$PY' cannot import wic." >&2
+    echo "       install wic with its test extras:" >&2
+    echo "       $PY -m pip install -e \".[tests]\"" >&2
+    exit 1
+fi
+
+# Default target: the whole suite. Overridden if the caller passed a
+# path or -k/-m selector to pytest.
+if [ ${#pytest_args[@]} -eq 0 ]; then
+    pytest_args=("tests")
+fi
+
+exec "$PY" -m pytest "${pytest_args[@]}"
-- 
2.50.0.173.g8b6f19ccfc3a


