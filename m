Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F00C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:27 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2389.1785202882154739179
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iOqVZrNF;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485ef63b68so3381783b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202881; x=1785807681; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3yuCYSfZZAoGe7kGcPvrddiV6aYXo1dRAp4Q1JuwzU=;
        b=iOqVZrNFnImla7q8H74j7RYsQH4KG5G8nzSj5WvJqfkTL3jTReni8kYllZuZX74ZYz
         p08kJBNOll3nMzv+qs+c0NAwq0a6wWERd4vudHAdUWhFNSBskn5wa9jngO8FuxP5mROj
         mvEpRCeAZSt618LJd6KxrXLe9PJMhiHcjfexGUWZdPWtZk2Yfnln0nNanYvsUDIYno+N
         u1+LjTd1iwuubEkElHBdWQ4WYm/S3nSRb5vf4w7YY2YWp1RJT+3+cGgTS7MpcW2YFvky
         yRwNMSJ+MierTU6eghu/GXT4z1C6jnh9Pb0Q/sPppRi0Zz/Bl4a8FrPiuZ2AdMK+li7L
         2Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202881; x=1785807681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T3yuCYSfZZAoGe7kGcPvrddiV6aYXo1dRAp4Q1JuwzU=;
        b=Cjs2cey1/q2YUInJ6qO+kUacrhHWJJ2fnNubXI7KpOBJtYD2ubbieg+8h7P8v41v6L
         W4WD48Nf3oIriGgZrDa+B4NhEMvtQQuOqOkjpjYlJPM7feAYiLr+/1G6j49OcE0V/B9I
         3+Z8OWn8cOol5QZhOultxqJ7IsuECf82KzbnblADWydmlhdDPwE65LAqhxBycbJugK1R
         YlObaYSISO368qAQJbJWMuyamSt1QtiB0tNip4Zd9TJFA5bCxnlZJ+HfX0bnexOk8htx
         z7364jkCTydQwOJx4KeXCda1zhFO2znAwEziiiJkdA4uJbPSWdJUea6+BJpE3hubbWDQ
         +qbA==
X-Gm-Message-State: AOJu0YxICS3sUUajaBFJD+sT68MqsWy84HIPWtfXtvd4DBlhhIOSaAay
	e2eYa/Qzo2Nf5DRjS6bSAB85lpneDnFi5CBCOmw9ONdCkpUnpe/7s52+YhvukQ==
X-Gm-Gg: AR+sD11LKu6dK8dA5Q//ClQtPHIcl0jAjJXg69TxreF4RfMSVlhTnxOQYVe6dkvhaW/
	Ch+0Ul/nA/H7NpL2/ToJHn2FSBKhj5UIlogr8c9WV7pl8uYAwSCqBjU1NCp9bMsFCLzRCbN85AS
	cwbwBXM2Ca5umhnwalQvPlZWni2Z5Pd31OcQr5EEmkqGR0ldwqjJNCMQMNEMbvLwF1c1ZQlHFtT
	+3dpKto9ZFVdjSvRCU9CWQocp/Wa7x3H78XukzF2Ozzx7DIXUWZvkGlTNpdj9kgcgeFvDYMmy7P
	f4IfOWxPCy2xjyt1MlD2Ac7n6upnelnZn5q3iLLK8hEk70yTHWAIV7WLsNS2AB2Sm6WM8gGLyA/
	3C/jIJDoLhtL+UOOoaul1AJMw91Pv0YUo3USz2rlLYwnfa0iKcUujo0/0WEKMnYBi032VKA+BS1
	od9uZ2As7uM8AK/SJiNwyA57YUfR6jGbDz2ubzI4PNQofYmx6YCDvLmiX0s9BlQO8cJwQf3W38B
	aDKXFhtJZ8xypQst2vn6zXahqvg2Tpm/qKwaV6mh6hKprlZ8H9+j7ZObRko
X-Received: by 2002:a05:6a00:cd3:b0:847:9151:3409 with SMTP id d2e1a72fcca58-84e9335fe7emr305291b3a.55.1785202881344;
        Mon, 27 Jul 2026 18:41:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 03/12] scripts: add run-vcontainer-tests for meta-virtualization
Date: Mon, 27 Jul 2026 18:40:36 -0700
Message-ID: <eecf2ec5ad5881d600e6d1bb13679dfac69998c3.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4542

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

For older hosts, with python < 3.10, we need buildtools
for pytest 9.x in meta-virtualization/tests/requirements.txt.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                  |  28 +++++
 scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100755 scripts/run-vcontainer-tests

diff --git a/config.json b/config.json
index 8a665cc..5a97674 100644
--- a/config.json
+++ b/config.json
@@ -1855,6 +1855,34 @@
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
+                "EXTRACMDS" : [
+                    "${SCRIPTSDIR}/run-vcontainer-tests -s vcontainer -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
+                ]
+            },
+            "step2" : {
+                "shortname" : "Run vdkr pytest suite",
+                "EXTRACMDS" : [
+                    "${SCRIPTSDIR}/run-vcontainer-tests -s vdkr -b ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
+                ]
+            },
+            "step3" : {
+                "shortname" : "Run vpdmn pytest suite",
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
2.55.0


