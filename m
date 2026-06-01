Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51534CD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:39 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12717.1780355918068990977
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n8Qse1hW;
 spf=pass (domain: konsulko.com, ip: 209.85.210.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f52af13so1218676b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355917; x=1780960717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3YxBLJtmIQ3m4N+t4kJmwp56pZxSysUKkEjicX0XAo=;
        b=n8Qse1hWYv/OpK6StXwILGSkd7bvJBwOYnU55mrQdfRVPx8m/Cw2H4h1pHSPdIhILx
         UE5tG14zGgNSxoSrxdSQJ6pGGuJPDDNjzPCNAVmt/ce5OSQWRdq0W7q2Z/RtfQdwi4Nz
         7VeLK7PMQpuSt1L5UPXocafKxac8pw+4cIbtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355917; x=1780960717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c3YxBLJtmIQ3m4N+t4kJmwp56pZxSysUKkEjicX0XAo=;
        b=egIHnlMnywrdshaaGEtD6simrAPrmoZp8kTon3VBCYCFX2qYQJQhz+iUv3RkqkcUpA
         Iih5ev2mNcsZjD6JGttpxmShnMrmxSTTaBvDZML/3ABTq89Q61TlIeKT6RaK1UOkS4WS
         m4FJ1hqforuMYGFJrLlMcZEZJFE5EfsyroetvFa98cBnzGimGr4BvznXDyxOT4WlGpeJ
         592x7FpCoMAwN93ZjoRRmadV/3lSgOfWxGUZFMOp7dMFNpghKig/Oe2XIvZoG0DRYnIQ
         Ees8z2Rvxr3ukTKL1QYBQuFu0y+EI4wKweELowTxZiPF/Q/rq0BvYhtBplGCe+Jmdp+W
         zXVQ==
X-Gm-Message-State: AOJu0YwMRA7/8Cn1FvBTTrBPPCBvXyO1TxXkK4vK6CZZcOhb3zt4mpgc
	2ssgcFiloQbLiyQUSVkWjxWffNWAQO4ZjabDjk532an9ggU+Ca9DQpXPFv8ruZkyzL1bIvPo9QW
	OTzh2
X-Gm-Gg: Acq92OHymcF5gbublAaKhuNrVwIkMNq9VFAODpmio+ZKSvoju/CbCra+8q+37V3gKAB
	gf7/wQLwZenU5Sze6/ZjXsR5Rm2u95X+nYjKPV7OhHsUSWRH6whJXDa1J4VfrxUK14Lib/qdqhx
	PPFmWB2D7kmHvCYZMeTSDSgNR/d4u1djC5Ffom+D47/l0JJAtn+oB9twQFVOob6p+g71FV5v6Y+
	+j5rQvWN4SE6zlxFKD8dIVmCV8AhSNR0gWKZllyD7V/UCUsVX2LizJ1vEcoiA4zaT6JKzow4HB7
	q4Alk8Of3Lamo5sDD0knHEot9rr5VPqKNfJbz+BGLoM2qCOkiuNLkHdwLvMRFy1yR0G5FUH718C
	JPLUdy0Qo+EgzLBXLEOzSjmjt2cLsUbrUVvWZNlvSMIzqtKiqtYecMe6hBKH3//9LtcFCfY4569
	TiLVyKDf9uJnhVOaLhjYM1yCk0D4PU7IJvf5bXFFAa05ZZWZ8G3udc0rIdRqRMIXgVbk90RWJvi
	d57jnc7LbTt
X-Received: by 2002:a05:6a00:2450:b0:82c:6b46:271d with SMTP id d2e1a72fcca58-842257240cfmr12072730b3a.48.1780355917365;
        Mon, 01 Jun 2026 16:18:37 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ce85d2sm11069030b3a.51.2026.06.01.16.18.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:36 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 07/10] scripts: add run-vcontainer-tests for meta-virtualization
Date: Mon,  1 Jun 2026 16:18:06 -0700
Message-ID: <1b74cb9ed9d6f1865141964682958160f4041d44.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4104

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
 config.json                  |  34 ++++++++
 scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100755 scripts/run-vcontainer-tests

diff --git a/config.json b/config.json
index 7206c41..79a9d10 100644
--- a/config.json
+++ b/config.json
@@ -1890,6 +1890,40 @@
                     "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
                 ]
             }
+        },
+        "vcontainer-tests": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-virtualization"
+            ],
+            "step1" : {
+                "shortname" : "Run vcontainer pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vcontainer ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            },
+            "step2" : {
+                "shortname" : "Run vdkr pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vdkr ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            },
+            "step3" : {
+                "shortname" : "Run vpdmn pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vpdmn ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            }
         }
     },
     "repo-defaults" : {
diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
new file mode 100755
index 0000000..1394c7c
--- /dev/null
+++ b/scripts/run-vcontainer-tests
@@ -0,0 +1,164 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Run meta-virtualization pytest test suites against the vcontainer
+# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
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
+# so that the autobuilder step completes without needing network access. Those
+# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before invocation.
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


