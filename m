Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790CCCD8C8F
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:48 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9586.1780714303852122268
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CFdfdjQi;
 spf=pass (domain: konsulko.com, ip: 209.85.216.49, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so1619838a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714303; x=1781319103; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bPHjOxfbjQ9W+jvWNQXK1aXWSvTMAKTkFiF4LvOATo=;
        b=CFdfdjQim6oNKT02GZfBWTy20eihIEr7oR3tw7OeqHo9BtvXX0kyqsfu9HKkiuii7N
         Ofy9j5OBEHFc7H16CHsx5mS5vOOo//+YndV1G9QpbY2DPeGkumyI+IxdMS2bFNSUt8sR
         toVGQ9ZMjonqlRxwLyHmDlHRM4F5itRy+5bfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714303; x=1781319103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/bPHjOxfbjQ9W+jvWNQXK1aXWSvTMAKTkFiF4LvOATo=;
        b=DWAlrF4WLmtdcWXXwH1bGaJHyURxWA3x+akV2dK0NxUiVCfuipLUkKV7JRi1gqZeFX
         91QWMmTeFQFoTR9AJnH9k11H6XyiIM1FgrC9GWEdcey9gT3RUOwInn6mSLVDsPKDvja0
         Y5jOLQs0Pz7DzWB/PBq6u7PvgFYoR7ygoM0b8SOd1bEbSjxOjSzWa/AYDN7e8FF2NM8J
         jaMLa5QKbtgnNoWb1P33SmPFkWV7xAy5ZzwvvILRbPNKJo5QId5Pg/7jCga13yrlm3pu
         OyWbdNlhNPYPeitlCQ8cIRLnrwCrlkLJanwrGsVpjnpOYH82ihm4S0axVpCx4+qXoLoK
         6tNw==
X-Gm-Message-State: AOJu0YwYtTLoi/hFakb8ipD4R84ett8Y2BavIe1mL6VqF/1DDwwIeGw6
	icBJZ+OvSVmv1Gb7GgkRX6amYbNKpqfWlxQhn4JohN/DF51EGjCzDF8W75LjouQHKthyQg17LoF
	+5vtr
X-Gm-Gg: Acq92OFVCKGkkl0FvDNDIkuntSb7Y/PaoEx/hdJf1eP6Lh+tPAxoFNRVqgVSX6oWQ0t
	rb9aZXknpfj8NnrnqPiAKD9TzxIchTCHP5QO95qnH9myGGWtVo0G0n19Pa3t1OvaXGayxcNh4sA
	zeTtoggqQCe8DbnGiPUvk4vMXdOi4LuTfUMuzxeGM2NKmNugr6XAkX46jhtiKO/WYzQy//x0uyz
	Xsa3W/8h78YbYHJbvz8y7wZFq8Cqli4GDToTb931C0+CHwzx9S7uKvgB19m9dZC0xJJwWAo3gjK
	XFaNzcqcqesXqWLmxLiFsO0oPlrGI6xjIRU1zIqsfU5gS/fG0RiUMoG9SzNgmE8JXDkXXqaG4SC
	CRGCC94yCLe1BW5clqMzEM1fIBY3z+KiVlgor/MtD69Qm3Tjq9ib0vbYSfNxIi528oTrwmFug4a
	SqKHbLTVr90DacJMWfUcrxe4gFmrGS3DnPIlJjPrqKfPkVC5fqhxZE7aotZ/9cluEned9aZVkfF
	qiJPDKXw7va
X-Received: by 2002:a17:90b:3b49:b0:36d:6315:1de4 with SMTP id 98e67ed59e1d1-370f096ab48mr6648455a91.17.1780714303105;
        Fri, 05 Jun 2026 19:51:43 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e52b0sm8275396a91.15.2026.06.05.19.51.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:42 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 3/6] scripts: add run-vcontainer-tests for meta-virtualization
Date: Fri,  5 Jun 2026 19:51:17 -0700
Message-ID: <f8b9782f90a7ac2f92b29c9498ad747901a99399.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4158

From: Tim Orling <tim.orling@konsulko.com>

Add scripts/run-vcontainer-tests, the test runner used by the
vcontainers-test job. It sources the vcontainer-tarball SDK,
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

The purpose of this script is to test the just built vcontainer-tarball,
so that it can be considered "known-good" and be published for use by
container building jobs that need the vcontainer-tarball installed.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                  |  31 +++++
 scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100755 scripts/run-vcontainer-tests

diff --git a/config.json b/config.json
index 2971fe9..3fccd83 100644
--- a/config.json
+++ b/config.json
@@ -1853,6 +1853,37 @@
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
+                "EXTRACMDS" : [
+                    "${SCRIPTSDIR}/run-vcontainer-tests -s vcontainer -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
+                ]
+            },
+            "step2" : {
+                "shortname" : "Run vdkr pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "EXTRACMDS" : [
+                    "${SCRIPTSDIR}/run-vcontainer-tests -s vdkr -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
+                ]
+            },
+            "step3" : {
+                "shortname" : "Run vpdmn pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "EXTRACMDS" : [
+                    "${SCRIPTSDIR}/run-vcontainer-tests -s vpdmn -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
+                ]
+            }
         }
     },
     "repo-defaults" : {
diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
new file mode 100755
index 0000000..a7dbab3
--- /dev/null
+++ b/scripts/run-vcontainer-tests
@@ -0,0 +1,212 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Run meta-virtualization pytest test suites against the vcontainer
+# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
+# step.
+#
+# Usage:
+#   run-vcontainer-tests -s <suite> -b <builddir> -m <metavirtdir> [options]
+#
+# Required:
+#   -s <suite>        suite name: one of "vcontainer", "vdkr", "vpdmn"
+#   -b <builddir>     bitbake build directory (${BUILDDIR})
+#   -m <metavirtdir>  path to the meta-virtualization layer
+#
+# Optional:
+#   -S <sdk>          path to the vcontainer standalone SDK installer. The
+#                     autobuilder -tests jobs share the SDK produced by the
+#                     separate vcontainer-tarball builder. When unset, falls
+#                     back to looking in <builddir>/tmp/deploy/sdk.
+#   -e <extractdir>   where to extract the standalone SDK tarball
+#                     (default: <builddir>/vcontainer-test-extracted)
+#   -i <oci_image>    path to an OCI image directory (enables vdkr/vpdmn
+#                     import tests)
+#   -a <arch>         target architecture for vdkr/vpdmn tests (default: x86_64)
+#   -r <resultsdir>   directory to copy pytest artefacts (junit xml / log) to
+#   -k <markers>      pytest marker filter (default excludes long running /
+#                     infrastructure dependent tests)
+#   -h                show this help and exit
+#
+# The script is intentionally conservative: any pytest tests that cannot run
+# in the CI environment (those marked "slow", "network", "boot") are skipped
+# so that the autobuilder step completes without needing network access. Those
+# can be re-enabled via -k before invocation.
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
+usage() {
+    cat >&2 <<'EOF'
+Usage: run-vcontainer-tests -s <suite> -b <builddir> -m <metavirtdir> [options]
+
+Required:
+  -s <suite>        vcontainer | vdkr | vpdmn
+  -b <builddir>     bitbake build directory
+  -m <metavirtdir>  path to the meta-virtualization layer
+
+Optional:
+  -S <sdk>          path to the vcontainer standalone SDK installer
+  -e <extractdir>   where to extract the standalone SDK tarball
+  -i <oci_image>    path to an OCI image directory
+  -a <arch>         target architecture (default: x86_64)
+  -r <resultsdir>   directory to copy pytest artefacts to
+  -k <markers>      pytest marker filter
+  -h                show this help and exit
+EOF
+}
+
+suite=""
+builddir=""
+metavirtdir=""
+sdk_tarball=""
+extract_dir=""
+oci_image=""
+arch=""
+results_dir=""
+marker_filter="not slow and not network and not boot and not incus and not k3s"
+
+while getopts ":s:b:m:S:e:i:a:r:k:h" opt; do
+    case "$opt" in
+        s) suite="$OPTARG" ;;
+        b) builddir="$OPTARG" ;;
+        m) metavirtdir="$OPTARG" ;;
+        S) sdk_tarball="$OPTARG" ;;
+        e) extract_dir="$OPTARG" ;;
+        i) oci_image="$OPTARG" ;;
+        a) arch="$OPTARG" ;;
+        r) results_dir="$OPTARG" ;;
+        k) marker_filter="$OPTARG" ;;
+        h) usage; exit 0 ;;
+        :) echo "ERROR: option -$OPTARG requires an argument" >&2; usage; exit 2 ;;
+        \?) echo "ERROR: unknown option -$OPTARG" >&2; usage; exit 2 ;;
+    esac
+done
+
+if [ -z "$suite" ] || [ -z "$builddir" ] || [ -z "$metavirtdir" ]; then
+    echo "ERROR: -s, -b and -m are required" >&2
+    usage
+    exit 2
+fi
+
+builddir=$(realpath "$builddir")
+metavirtdir=$(realpath "$metavirtdir")
+
+if [ ! -d "$metavirtdir/tests" ]; then
+    echo "ERROR: meta-virtualization tests directory not found at $metavirtdir/tests" >&2
+    exit 1
+fi
+
+# Locate the vcontainer standalone SDK tarball. Prefer an explicitly-provided
+# SDK (-S), and fall back to looking in the local build's
+# deploy/sdk directory when running stand-alone.
+if [ -n "$sdk_tarball" ]; then
+    if [ ! -f "$sdk_tarball" ]; then
+        echo "ERROR: SDK installer '$sdk_tarball' is set but not a file" >&2
+        exit 1
+    fi
+else
+    sdk_tarball="$builddir/tmp/deploy/sdk/vcontainer-standalone.sh"
+    if [ ! -f "$sdk_tarball" ]; then
+        # Try to find any matching tarball in case naming changed (e.g. versioned)
+        alt=$(ls -1 "$builddir"/tmp/deploy/sdk/vcontainer-*.sh 2>/dev/null | head -n1 || true)
+        if [ -n "$alt" ]; then
+            sdk_tarball="$alt"
+        else
+            echo "ERROR: vcontainer standalone SDK not found." >&2
+            echo "       Pass -S with an existing SDK installer, or" >&2
+            echo "       build vcontainer-tarball so $builddir/tmp/deploy/sdk/vcontainer-standalone.sh exists." >&2
+            exit 1
+        fi
+    fi
+fi
+
+extract_dir="${extract_dir:-$builddir/vcontainer-test-extracted}"
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
+export PIP_DISABLE_PIP_VERSION_CHECK=1
+python3 -m pip install --quiet -r "$metavirtdir/tests/requirements.txt"
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
+if [ -n "$oci_image" ] && [ -d "$oci_image" ]; then
+    pytest_args+=(--oci-image "$oci_image")
+fi
+
+# Pass architecture through when set (default is x86_64).
+if [ -n "$arch" ]; then
+    pytest_args+=(--arch "$arch")
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
+if [ -n "$results_dir" ]; then
+    mkdir -p "$results_dir"
+    cp -f "$builddir/pytest-$suite-results.xml" "$results_dir/" 2>/dev/null || true
+    if [ -f /tmp/pytest-vcontainer.log ]; then
+        cp -f /tmp/pytest-vcontainer.log "$results_dir/pytest-$suite.log" || true
+    fi
+fi
+
+exit $rc
-- 
2.43.0


