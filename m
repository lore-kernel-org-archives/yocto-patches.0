Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F4C44500
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:54 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25079.1782835608841556482
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fIYXgbeB;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92c7a0a7059so305134885a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835608; x=1783440408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYdajNMvxe9R8ztWnBBJNV55DFrMi6iRzDu+6HIWlpg=;
        b=fIYXgbeBQPIeXQIXPMHt00hJBdkbgla0WQNInnvsqdzTqHCF0DC99qAFB/K7jm/ICa
         HaB+FSE/gvGcH1sTIyMcwDDIdvB3CGQw6eqgn6uB7S0RrJQYlYapNdMmYOAWlkruNek0
         n1UxZUYVjjykpinkw695Ny/zB2ILC9lgNXIWDD79NxzO9vO+Xe+p5bXdncJspqackmLJ
         CKfAogvEDx/vIqTzBWFEIDBdN731xSFZ/KQlrKY6laxQjf9VpPc1OyWi8KwCfx2q1gj2
         FIIAyGuOTY413dapalIeX7cWHCJZaPKhyrqJU4e9IojSCPlNvxQkQSxCiXMn3Gbw6PjS
         /OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835608; x=1783440408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYdajNMvxe9R8ztWnBBJNV55DFrMi6iRzDu+6HIWlpg=;
        b=S7WvtY0LOJRUHEig+aj2KIoDl6iOmo4xTEk13xasI3Wb9XM5h+4n5vkJLeX5almP5M
         xOIKwgo0+ew7fs7uKmsWO2IYyGQmTQjBsVRrheM2wV9bQj49NA+AWz5lTKzOG4CNpOBH
         1EVTuOVLnWVYWCAK8gliujxkF9+MNQjrX3wTFKAQ25aFzqmHfrw3VHgEwizVE0haqJtn
         So6NvVDRk7vRPGs1mjRuxH7GkNKR6YdNQX5UbsW9426KGKa3gdnSlxtX5ad9Wo1DoBmi
         xl5CH1EpawlwRfQSD/3PxmuRmBp324h5jSB+tJMQXBHAaAnWLcxnvim0q5GO6OMj6smJ
         uNMg==
X-Gm-Message-State: AOJu0YwAi21ksgjufnRbsRmQynUHt3NWMC0joe2UBse9R4KDrtoVrgje
	CavyJ4gX5oYVJ7JF/zUc9w36T9akmd1QZLzJnjycwSkbTTiDgCyBNqaUBLlokQ==
X-Gm-Gg: AfdE7cnFDeRRTaAYFs+di/lfP/zWe68mr38Gnzwx17RdxK2UguD1Iu0oNFObkZkPitq
	iKqsnqSxK5rT2N8DEXE/P6FBJN5eWctetd7NGigC/Kmt2ABsR3JgBqxh1gVS3rO5lLmR+Slkd/M
	v1kTpG46y/4cIkK+PAICbQJv8c4ECigHHNM+IZQCIldQc4HMwQ9Qf0R4I7coBLNroEp/v2BrJIy
	8DVyt/gVGzipxL+/h+vCTzGHKHnvrucu4mcRqE5AJuRp5UFoxymtvTUTS1m7pJNFF/NO9nO4ZUm
	Kq/L5xdgdM0EPuAlIbhtaUbqOcTFstviBAiL4cEQ3MgtFeiZYj4x5RswX+s2i1cQcGh235Tccso
	ssTBGsIuidrnn5qR4y4YwlPxLAO870ovaRvcMgPayNVqT5cnj5Gj4CWTGKEF3KeBhb2ZN6FoCeW
	c2HtYWsN9rljFqrb0kKZNi/1c83qCDzFWD4bDGqoJI5hagyzjp3SKTgWE=
X-Received: by 2002:a05:620a:8807:b0:92b:67e6:8abf with SMTP id af79cd13be357-92e62852736mr623878885a.73.1782835607201;
        Tue, 30 Jun 2026 09:06:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 3/9] tests: add the run-tests.sh wrapper
Date: Tue, 30 Jun 2026 12:06:06 -0400
Message-ID: <20260630160612.1005451-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4324

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


