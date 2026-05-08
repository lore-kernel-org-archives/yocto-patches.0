Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F538CD37AD
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:14 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4511.1778205664373536050
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T62VhsvH;
 spf=pass (domain: konsulko.com, ip: 209.85.214.172, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so8619205ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205663; x=1778810463; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHMHMqUFw3Mr58TmHJ1eNwHZJQZt/gX7bY7S8Vl0ghA=;
        b=T62VhsvH0a4hZmU8m+sTNrPwJzbw1uaTfqxy3daQtKzWKOKKTEZkLjDQ8X0+J3JjNR
         a9DAQkmziSddn7nAlg1h2l9B0vxwsq+TwwMJQLYhWYYcBd0ws1n+w4l8z/i34iz2zk+A
         fsMpAW8HSUwaZpHT/gjhf6cEk8NR5NzQR6hxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205663; x=1778810463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lHMHMqUFw3Mr58TmHJ1eNwHZJQZt/gX7bY7S8Vl0ghA=;
        b=hCsC7leVSiEPh9thui+4pmt6NSODNwMrip7CFKtP8QCPo4UWTaT4VJ5S8Rp0Oz8eGX
         QW5qMwjE66aO4WCbhbGQGECcUR2VgQDerQLK13Y+8RPlg3X0xzD2YBnLLfjXGKSXcJG6
         jTnvUhqFtJO1X2Oe9TR5hMlC2No8/QhhjDcAsuLYC9XFr5+V8arGbhbgd6peermNBex1
         aPD7ODLJGdAbUjAjSKTltdSmnIReE30Cg4lJ9tR/urOdMt9CcTvayKbNyjf2J42F72/2
         T63hzE9vE9ifDChXCNMk8VvYpFp6Vk/exO/yxKaQA84cMiDE0Ux2DvsxRGFmEfoygAmw
         4R7A==
X-Gm-Message-State: AOJu0YwStU8U5A8XQLb2Nd5k3kQSQGMhAjsBan21yGz4+HvMk2YFW5zm
	tXvyopGSisMog/DJMpsI8XIc7Mz++Ow69Pcljz9N7A/lbpk8rWZvhRY0E5Xw5ki5hqHH/pyo0sh
	E2aef
X-Gm-Gg: Acq92OHd6aVwBR/fBqgwwaDi4GBNSjhOx+4oXE3QTjabpw9Hz68JsIBg/5/wf8atU52
	IAVJ+l4ytTrx/K1x3hNy7L7QGujeYlhruUb5XgCMMcz50cHzHvI/H6fl+eWIR+afbwBHRH4cWEM
	pS+5mKpZ0D8vlRqa8mxjuWVVgSLQuHEe2H1PL7Xe2L9wX25SPpOCrGfrK0Pxf6cmhE7A1qZ1RyV
	sJvBaGqV6DEQQQvhHxmnZdKOHGii7u4JIeXsIurXl0CS1ju5Fqjhr+zifd9PNLRxvIzQAQs+kCF
	iDQB58L81d3698rgvAa+fYpZ4TvwFeZqPmJ5yYmBIwXbOsZTo7cgshDgV/z332OW/Obgt2Ixlsy
	dlfTfAW38MDJRGKRd32gaaUp5iZ0vyhmpJ3u362wHHS4Qh3i20mcRc/u7ChNWiNNuXfrXukv5wz
	xvb6uS2QLCahpSyYvXpeXKSzvaxUKaQt2QAv4hEJv43+XFtUY6XcRABm/1Xl+K5M4=
X-Received: by 2002:a17:903:3c05:b0:2ba:1202:4fa8 with SMTP id d9443c01a7336-2baf0dd5625mr6771605ad.20.1778205661966;
        Thu, 07 May 2026 19:01:01 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27254sm1936285ad.4.2026.05.07.19.01.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:01:01 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 08/11] scripts: add run-vcontainer-tests for meta-virtualization
Date: Thu,  7 May 2026 19:00:31 -0700
Message-ID: <eb9eeef2941f004f675e208ba300d448fec7b95a.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3947

From: Tim Orling <tim.orling@konsulko.com>

Add scripts/run-vcontainer-tests, the test runner used by the
vcontainer test jobs. It sources the vcontainer-tarball SDK,
discovers the meta-virtualization pytest suite, and runs a
configurable set of suites (vdkr, vpdmn, memres) against the
checked-out layers. Suites can be selected per-step so the
top-level 'vcontainer-tests' job runs the container engine
agnostic tests:

- tests/test_container_cross_install.py
- tests/test_container_registry_script.py
- tests/test_vcontainer_auth_config.py
- tests/test_multiarch_oci.py
- tests/test_multilayer_oci.py

The 'vdkr-tests' and 'vpdmn-tests' jobs run only their respective
suites (including memres for each container engine):

- tests/test_vdkr.py
- tests/test_vdkr_registry.py

and

- tests/test_vpdmn.py

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-vcontainer-tests | 165 +++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100755 scripts/run-vcontainer-tests

diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
new file mode 100755
index 0000000..cbb5544
--- /dev/null
+++ b/scripts/run-vcontainer-tests
@@ -0,0 +1,165 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Run meta-virtualization pytest test suites against the vcontainer
+# standalone SDK (vdkr/vpdmn) that was built by the previous bitbake
+# step.
+#
+# Arguments:
+#   $1 - suite name: one of "vcontainer", "vdkr", "vpdmn"
+#   $2 - bitbake build directory (${BUILDDIR})
+#   $3 - path to the meta-virtualization layer
+#
+# Optional environment variables:
+#   RESULTS_DIR     - directory to copy pytest artefacts (junit xml / log) to
+#   VCONTAINER_EXTRACT_DIR - where to extract the standalone SDK tarball
+#                     (default: ${builddir}/vcontainer-test-extracted)
+#   TEST_OCI_IMAGE  - path to an OCI image directory (enables vdkr/vpdmn
+#                     import tests)
+#   VDKR_ARCH       - target architecture for vdkr/vpdmn tests (default: x86_64)
+#
+# The script is intentionally conservative: any pytest tests that cannot run
+# in the CI environment (those marked "slow", "network", "boot") are skipped
+# are skipped so that the autobuilder step completes without needing network
+# access. Those can be re-enabled by exporting META_VIRT_PYTEST_MARKERS
+# before invocation.
+#
+# It is assumed that /dev/kvm is writable by the CI user running the tests,
+# since the performance is significantly faster with 'memres'.
+#
+
+set -e
+set -u
+set -o pipefail
+set -x
+
+if [ $# -lt 3 ]; then
+    echo "Usage: $0 <suite> <builddir> <meta-virtualization-dir>" >&2
+    echo "  suite: vcontainer | vdkr | vpdmn" >&2
+    exit 2
+fi
+
+suite="$1"
+builddir=$(realpath "$2")
+metavirtdir=$(realpath "$3")
+
+if [ ! -d "$metavirtdir/tests" ]; then
+    echo "ERROR: meta-virtualization tests directory not found at $metavirtdir/tests" >&2
+    exit 1
+fi
+
+# Locate the vcontainer standalone SDK tarball. Prefer an externally-built
+# SDK passed via VCONTAINER_SDK (the autobuilder -tests jobs share the SDK
+# produced by the separate vcontainer-tarball builder), and fall back to
+# looking in the local build's deploy/sdk directory when running stand-alone.
+sdk_tarball=""
+if [ -n "${VCONTAINER_SDK:-}" ]; then
+    if [ -f "$VCONTAINER_SDK" ]; then
+        sdk_tarball="$VCONTAINER_SDK"
+    else
+        echo "ERROR: VCONTAINER_SDK=$VCONTAINER_SDK is set but not a file" >&2
+        exit 1
+    fi
+fi
+if [ -z "$sdk_tarball" ]; then
+    sdk_tarball="$builddir/tmp/deploy/sdk/vcontainer-standalone.sh"
+    if [ ! -f "$sdk_tarball" ]; then
+        # Try to find any matching tarball in case naming changed (e.g. versioned)
+        alt=$(ls -1 "$builddir"/tmp/deploy/sdk/vcontainer-*.sh 2>/dev/null | head -n1 || true)
+        if [ -n "$alt" ]; then
+            sdk_tarball="$alt"
+        else
+            echo "ERROR: vcontainer standalone SDK not found." >&2
+            echo "       Set VCONTAINER_SDK to an existing SDK installer, or" >&2
+            echo "       build vcontainer-tarball so $builddir/tmp/deploy/sdk/vcontainer-standalone.sh exists." >&2
+            exit 1
+        fi
+    fi
+fi
+
+extract_dir="${VCONTAINER_EXTRACT_DIR:-$builddir/vcontainer-test-extracted}"
+rm -rf "$extract_dir"
+mkdir -p "$(dirname "$extract_dir")"
+
+# Self-extracting installer (silent, -y agrees to license, -d picks dir)
+"$sdk_tarball" -d "$extract_dir" -y
+
+# Prepare a Python venv so we don't pollute the worker's system packages.
+python3 -m venv "$builddir/meta-virt-test-venv"
+# shellcheck disable=SC1091
+source "$builddir/meta-virt-test-venv/bin/activate"
+# Avoid warnings by upgrading pip; install pytest/pexpect into the venv via pip.
+python3 -m pip install --quiet --upgrade pip setuptools wheel
+python3 -m pip install --quiet --upgrade pytest pytest-timeout pexpect
+
+# Default marker filter excludes long running / infrastructure dependent tests.
+marker_filter="${META_VIRT_PYTEST_MARKERS:-not slow and not network and not boot and not incus and not k3s}"
+
+# Per-suite test file selection. Uses -k/-m for fine-grained filtering and
+# keeps the CLI small for logging clarity.
+case "$suite" in
+    vdkr)
+        test_files=(
+            "tests/test_vdkr.py"
+            "tests/test_vdkr_registry.py"
+        )
+        ;;
+    vpdmn)
+        test_files=(
+            "tests/test_vpdmn.py"
+        )
+        ;;
+    vcontainer)
+        # Broad vcontainer/bbclass/tooling coverage that doesn't require the
+        # vdkr/vpdmn CLI harness to be running.
+        test_files=(
+            "tests/test_container_cross_install.py"
+            "tests/test_container_registry_script.py"
+            "tests/test_vcontainer_auth_config.py"
+            "tests/test_multiarch_oci.py"
+            "tests/test_multilayer_oci.py"
+        )
+        ;;
+    *)
+        echo "ERROR: unknown suite '$suite' (expected vcontainer|vdkr|vpdmn)" >&2
+        exit 2
+        ;;
+esac
+
+pytest_args=(
+    -v
+    --tb=short
+    -m "$marker_filter"
+    --vdkr-dir "$extract_dir"
+    --junitxml="$builddir/pytest-$suite-results.xml"
+)
+
+# Allow tests that consume an OCI image (import/save/load) to find one.
+if [ -n "${TEST_OCI_IMAGE:-}" ] && [ -d "${TEST_OCI_IMAGE}" ]; then
+    pytest_args+=(--oci-image "$TEST_OCI_IMAGE")
+fi
+
+# Pass architecture through when set in the environment (default is x86_64).
+if [ -n "${VDKR_ARCH:-}" ]; then
+    pytest_args+=(--arch "$VDKR_ARCH")
+fi
+
+cd "$metavirtdir"
+# Don't let a single failing test kill the whole step - collect the junit
+# report, then surface the exit code via the junit file + exit status.
+set +e
+python3 -m pytest "${pytest_args[@]}" "${test_files[@]}"
+rc=$?
+set -e
+
+# Copy artefacts to the results dir if one was provided.
+if [ -n "${RESULTS_DIR:-}" ]; then
+    mkdir -p "$RESULTS_DIR"
+    cp -f "$builddir/pytest-$suite-results.xml" "$RESULTS_DIR/" 2>/dev/null || true
+    if [ -f /tmp/pytest-vcontainer.log ]; then
+        cp -f /tmp/pytest-vcontainer.log "$RESULTS_DIR/pytest-$suite.log" || true
+    fi
+fi
+
+exit $rc
-- 
2.43.0


