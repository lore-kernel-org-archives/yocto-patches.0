Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EFDC3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web10.4571.1746132038023836102
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F9ph6Jwi;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso14565546d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132037; x=1746736837; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wh0+CQFr+q+WlbQh7DFMoPtbZVPPlWwmbRFz20GuaRw=;
        b=F9ph6JwiE2H61xPMXV1DtG66CMrVqah+sO6MTVUkZi/W0qT50DbrnfPv5+k4bsPmsI
         giqehJONibHVT4uaWrKs13Q/cck3jXesnVNSENiE/Vk7/WpV+Schc2vntcc/C7KuOzV+
         2huH3xl9AL4Cv2rMhl5yEQuD2bDwsMgk57/3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132037; x=1746736837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh0+CQFr+q+WlbQh7DFMoPtbZVPPlWwmbRFz20GuaRw=;
        b=DLNZTz7XB95/shtFVu8w3vvQxoWxetM2274ugKW4N0H5tSsFPsUUt4nH7LN9Mwj8t0
         Dqwzd5arwfkPV7KUZ4vYhYdJqN2qKxoMwSEh9LpS3GysJ4+yHRlxnlsPxQkssn82Wr7t
         Hj89itOLA41Vt4QBsHrU8QAepJ9OvJagxdPYLk6PNxN6P6KEk3zrrvmWH1AyfrhNAFcn
         bToJSqaLwf/DiAfU4WO6v9xfW4tgaQrF8vEJHO/qLEmd6//naeFqOxWMCY76XVAN0HZa
         ctcxFAX0yNVZamIh+klqWedzLg/lFKBkFYmgtqmLO/rep6dmCfSx45IdL3cnGjWTXciN
         QsMg==
X-Gm-Message-State: AOJu0YxqFqHJ9ud6fRzuTED5b47uhstL9+8ymp3pd0SHx8A8tEDzNbmq
	aM7znBWYWRhkwTRXXY5bLnXKq/6Ii/bL85HlfdBuU/fAcmV51KIuGVdQ59HHF46B7oV7qh2bxZk
	C
X-Gm-Gg: ASbGnctMbTFXDkJjJ/kCh5g6Q7b0ty7J6Q+mVV8ei+ZhHy7vGSb+GKy6oRLvA0GtLoB
	xamfwqhB2XyIm6ATs/quHw/1yvsAgbAantSO/2SwHerkv5YPzZocRSNQkAr+sCJGiyZ1BKTSZQK
	iNGIsKjj8Kf7AE+EbN/QWSRJkVSSBMN66OOAck5fr6AjQEf4+YXVrpMtfzhOhpJONCqfmfzeGA0
	PLtfadbBbwmJ3VXI3cOZuu5bEOCM/cVKN79au1BQmx4TivDDq9eM677ayrGmi1xXgl4UZqiAZ9k
	6Q8gMkmTD/m8hA+xDI4F9qnhL10mH319eJhwexZ7x2dKSivq6eUWw6mAnCGN5yPTwP0Nw6CY09E
	5YQzDkITFTVSS2wMv
X-Google-Smtp-Source: AGHT+IEvEt5FuWfxgWsjHPk+v1IVONkc8zQY2O06Fng7fsTbMQtDlmWjQxa6thggPBRJFUIfL2hSJw==
X-Received: by 2002:ad4:5ced:0:b0:6e4:6ee1:a282 with SMTP id 6a1803df08f44-6f51574cd88mr11347926d6.18.1746132036432;
        Thu, 01 May 2025 13:40:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 01/38] Add selftest backport to ease maintenance
Date: Thu,  1 May 2025 16:39:37 -0400
Message-ID: <ebe3be27e6f4902708e018dc12db3e866fb87e7d.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1428

Add the backported Rust selftest as "rust_mixin" as has been done
for scarthgap/rust, to simplify the backport process.  At present
no guarantees are being made with respect to the usability of the
selftest, and it is not expected to pass if run.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md                             |   7 +-
 lib/oeqa/selftest/cases/rust_mixin.py | 132 ++++++++++++++++++++++++++
 meta/lib/oeqa/selftest/cases/rust.py  |  85 -----------------
 3 files changed, 136 insertions(+), 88 deletions(-)
 create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
 delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py

diff --git a/README.md b/README.md
index f0f89b1..13962b4 100644
--- a/README.md
+++ b/README.md
@@ -39,9 +39,10 @@ Notes
   finicky build.  This may change if sufficient rationale for doing the
   backport becomes apparent.
 - While changes to Rust recipe and class files related to oe-selftest
-  support are included by necessity, no effort has been made to backport
-  the actual addition of Rust to oe-selftest, as that is considered too
-  invasive and maintenance heavy.
+  support are included by necessity, and the Rust selftest is backported
+  (as "rust_mixin") to simplify the backporting workflow, note that no
+  effort has been made to ensure the selftest passes, and doing so is
+  not considered a priority.
 - To include Rust support in a SDK, do the following in e.g. local.conf:
   ```
   TOOLCHAIN_HOST_TASK:append = " packagegroup-rust-cross-canadian-${MACHINE}"  
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
new file mode 100644
index 0000000..42e0258
--- /dev/null
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: MIT
+import subprocess
+import time
+from oeqa.core.decorator import OETestTag
+from oeqa.core.decorator.data import skipIfArch
+from oeqa.core.case import OEPTestResultTestCase
+from oeqa.selftest.case import OESelftestTestCase
+from oeqa.utils.commands import runCmd, bitbake, get_bb_var, runqemu
+from oeqa.utils.sshcontrol import SSHControl
+
+def parse_results(filename):
+    tests = {}
+    with open(filename, "r") as f:
+        lines = f.readlines()
+        for line in lines:
+            if "..." in line and "test [" in line:
+                test = line.split("test ")[1].split(" ... ")[0]
+                if "] " in test:
+                    test = test.split("] ", 1)[1]
+                result = line.split(" ... ")[1].strip()
+                if result == "ok":
+                    result = "PASS"
+                elif result == "failed":
+                    result = "FAIL"
+                elif "ignored" in result:
+                    result = "SKIPPED"
+                if test in tests:
+                    if tests[test] != result:
+                        print("Duplicate and mismatching result %s for %s" % (result, test))
+                    else:
+                        print("Duplicate result %s for %s" % (result, test))
+                else:
+                    tests[test] = result
+    return tests
+
+# Total time taken for testing is of about 2hr 20min, with PARALLEL_MAKE set to 40 number of jobs.
+@OETestTag("toolchain-system")
+@OETestTag("toolchain-user")
+@OETestTag("runqemu")
+class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
+
+    @skipIfArch(['mips', 'mips64'])
+    def test_rust(self, *args, **kwargs):
+        # build remote-test-server before image build
+        recipe = "rust"
+        start_time = time.time()
+        bitbake("{} -c test_compile".format(recipe))
+        builddir = get_bb_var("RUSTSRC", "rust")
+        # build core-image-minimal with required packages
+        default_installed_packages = ["libgcc", "libstdc++", "libatomic", "libgomp"]
+        features = []
+        features.append('IMAGE_FEATURES += "ssh-server-dropbear"')
+        features.append('CORE_IMAGE_EXTRA_INSTALL += "{0}"'.format(" ".join(default_installed_packages)))
+        self.write_config("\n".join(features))
+        bitbake("core-image-minimal")
+
+        # Exclude the test folders that error out while building
+        # TODO: Fix the errors and include them for testing
+        # no-fail-fast: Run all tests regardless of failure.
+        # bless: First runs rustfmt to format the codebase,
+        # then runs tidy checks.
+        exclude_list =  [
+                            'src/bootstrap',
+                            'src/doc/rustc',
+                            'src/doc/rustdoc',
+                            'src/doc/unstable-book',
+                            'src/librustdoc',
+                            'src/rustdoc-json-types',
+                            'src/tools/jsondoclint',
+                            'src/tools/lint-docs',
+                            'src/tools/replace-version-placeholder',
+                            'src/tools/rust-analyzer',
+                            'src/tools/rustdoc-themes',
+                            'src/tools/rust-installer',
+                            'src/tools/suggest-tests',
+                            'tests/assembly/asm/aarch64-outline-atomics.rs',
+                            'tests/codegen/issues/issue-122805.rs',
+                            'tests/codegen/thread-local.rs',
+                            'tests/mir-opt/',
+                            'tests/run-make',
+                            'tests/run-make-fulldeps',
+                            'tests/rustdoc',
+                            'tests/rustdoc-json',
+                            'tests/rustdoc-js-std',
+                            'tests/ui/abi/stack-probes-lto.rs',
+                            'tests/ui/abi/stack-probes.rs',
+                            'tests/ui/codegen/mismatched-data-layouts.rs',
+                            'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and-split-debuginfo.rs',
+                            'tests/ui-fulldeps/',
+                            'tests/ui/process/nofile-limit.rs',
+                            'tidyselftest'
+                        ]
+
+        exclude_fail_tests = " ".join([" --exclude " + item for item in exclude_list])
+        # Add exclude_fail_tests with other test arguments
+        testargs =  exclude_fail_tests + " --no-fail-fast --bless"
+
+        # wrap the execution with a qemu instance.
+        # Tests are run with 512 tasks in parallel to execute all tests very quickly
+        with runqemu("core-image-minimal", runqemuparams = "nographic", qemuparams = "-m 512") as qemu:
+            # Copy remote-test-server to image through scp
+            host_sys = get_bb_var("RUST_BUILD_SYS", "rust")
+            ssh = SSHControl(ip=qemu.ip, logfile=qemu.sshlog, user="root")
+            ssh.copy_to(builddir + "/build/" + host_sys + "/stage1-tools-bin/remote-test-server","~/")
+            # Execute remote-test-server on image through background ssh
+            command = '~/remote-test-server --bind 0.0.0.0:12345 -v'
+            sshrun=subprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=/dev/null', '-o',  'StrictHostKeyChecking=no', '-f', "root@%s" % qemu.ip, command), shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+            # Get the values of variables.
+            tcpath = get_bb_var("TARGET_SYS", "rust")
+            targetsys = get_bb_var("RUST_TARGET_SYS", "rust")
+            rustlibpath = get_bb_var("WORKDIR", "rust")
+            tmpdir = get_bb_var("TMPDIR", "rust")
+
+            # Set path for target-poky-linux-gcc, RUST_TARGET_PATH and hosttools.
+            cmd = "export TARGET_VENDOR=\"-poky\";"
+            cmd = cmd + " export PATH=%s/recipe-sysroot-native/usr/bin/python3-native:%s/recipe-sysroot-native/usr/bin:%s/recipe-sysroot-native/usr/bin/%s:%s/hosttools:$PATH;" % (rustlibpath, rustlibpath, rustlibpath, tcpath, tmpdir)
+            cmd = cmd + " export RUST_TARGET_PATH=%s/rust-targets;" % rustlibpath
+            # Trigger testing.
+            cmd = cmd + " export TEST_DEVICE_ADDR=\"%s:12345\";" % qemu.ip
+            cmd = cmd + " cd %s; python3 src/bootstrap/bootstrap.py test %s --target %s" % (builddir, testargs, targetsys)
+            retval = runCmd(cmd)
+            end_time = time.time()
+
+            resultlog = rustlibpath + "/results-log.txt"
+            with open(resultlog, "w") as f:
+                f.write(retval.output)
+
+            ptestsuite = "rust"
+            self.ptest_section(ptestsuite, duration = int(end_time - start_time), logfile=resultlog)
+            test_results = parse_results(resultlog)
+            for test in test_results:
+                self.ptest_result(ptestsuite, test, test_results[test])
diff --git a/meta/lib/oeqa/selftest/cases/rust.py b/meta/lib/oeqa/selftest/cases/rust.py
deleted file mode 100644
index 4fbe8f0..0000000
--- a/meta/lib/oeqa/selftest/cases/rust.py
+++ /dev/null
@@ -1,85 +0,0 @@
-# SPDX-License-Identifier: MIT
-import os
-import subprocess
-from oeqa.core.decorator import OETestTag
-from oeqa.core.case import OEPTestResultTestCase
-from oeqa.selftest.case import OESelftestTestCase
-from oeqa.utils.commands import runCmd, bitbake, get_bb_var, get_bb_vars, runqemu, Command
-from oeqa.utils.sshcontrol import SSHControl
-
-def parse_results(filename):
-    tests = []
-    with open(filename, "r") as f:
-        lines = f.readlines()
-        for line in lines:
-            if "..." in line and "test [" in line:
-                test = line.split("test ")[1].split(" ... ")[0]
-                result = line.split(" ... ")[1].strip()
-                if result == "ok":
-                    result = "PASS"
-                elif result == "failed":
-                    result = "FAIL"
-                elif "ignored" in result:
-                    result = "SKIP"
-                tests.append((test, result))
-    return tests
-
-# Total time taken for testing is of about 2hr 20min, with PARALLEL_MAKE set to 40 number of jobs.
-class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
-    def test_rust(self, *args, **kwargs):
-        # build remote-test-server before image build
-        recipe = "rust"
-        bitbake("{} -c test_compile".format(recipe))
-        builddir = get_bb_var("RUSTSRC", "rust")
-        # build core-image-minimal with required packages
-        default_installed_packages = ["libgcc", "libstdc++", "libatomic", "libgomp"]
-        features = []
-        features.append('IMAGE_FEATURES += "ssh-server-dropbear"')
-        features.append('CORE_IMAGE_EXTRA_INSTALL += "{0}"'.format(" ".join(default_installed_packages)))
-        self.write_config("\n".join(features))
-        bitbake("core-image-minimal")
-        # wrap the execution with a qemu instance.
-        # Tests are run with 512 tasks in parallel to execute all tests very quickly
-        with runqemu("core-image-minimal", runqemuparams = "nographic", qemuparams = "-m 512") as qemu:
-            # Copy remote-test-server to image through scp
-            host_sys = get_bb_var("RUST_BUILD_SYS", "rust")
-            ssh = SSHControl(ip=qemu.ip, logfile=qemu.sshlog, user="root")
-            ssh.copy_to(builddir + "/build/" + host_sys + "/stage1-tools-bin/remote-test-server","~/")
-            # Execute remote-test-server on image through background ssh
-            command = '~/remote-test-server --bind 0.0.0.0:12345 -v'
-            sshrun=subprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=/dev/null', '-o',  'StrictHostKeyChecking=no', '-f', "root@%s" % qemu.ip, command), shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-            # Get the values of variables.
-            tcpath = get_bb_var("TARGET_SYS", "rust")
-            targetsys = get_bb_var("RUST_TARGET_SYS", "rust")
-            rustlibpath = get_bb_var("WORKDIR", "rust")
-            tmpdir = get_bb_var("TMPDIR", "rust")
-
-            # Exclude the test folders that error out while building
-            # TODO: Fix the errors and include them for testing
-            # no-fail-fast: Run all tests regardless of failure.
-            # bless: First runs rustfmt to format the codebase,
-            # then runs tidy checks.
-            testargs = "--exclude tests/rustdoc --exclude src/tools/rust-analyzer  --exclude tests/rustdoc-json  --exclude tests/run-make-fulldeps --exclude src/tools/tidy --exclude src/tools/rustdoc-themes --exclude src/rustdoc-json-types --exclude src/librustdoc --exclude src/doc/unstable-book --exclude src/doc/rustdoc --exclude src/doc/rustc --exclude compiler/rustc --exclude library/panic_abort --exclude library/panic_unwind --exclude src/tools/lint-docs  --exclude tests/rustdoc-js-std --doc --no-fail-fast --bless"
-
-            # Set path for target-poky-linux-gcc, RUST_TARGET_PATH and hosttools.
-            cmd = " export PATH=%s/recipe-sysroot-native/usr/bin:$PATH;" % rustlibpath
-            cmd = cmd + " export TARGET_VENDOR=\"-poky\";"
-            cmd = cmd + " export PATH=%s/recipe-sysroot-native/usr/bin/%s:%s/hosttools:$PATH;" % (rustlibpath, tcpath, tmpdir)
-            cmd = cmd + " export RUST_TARGET_PATH=%s/rust-targets;" % rustlibpath
-            # Trigger testing.
-            cmd = cmd + " export TEST_DEVICE_ADDR=\"%s:12345\";" % qemu.ip
-            cmd = cmd + " cd %s; python3 src/bootstrap/bootstrap.py test %s --target %s > summary.txt 2>&1;" % (builddir, testargs, targetsys)
-            runCmd(cmd)
-
-            ptestsuite = "rust"
-            self.ptest_section(ptestsuite, logfile = builddir + "/summary.txt")
-            filename = builddir + "/summary.txt"
-            test_results = parse_results(filename)
-            for test, result in test_results:
-                self.ptest_result(ptestsuite, test, result)
-
-@OETestTag("toolchain-system")
-@OETestTag("runqemu")
-class RustSelfTestBase(RustSelfTestSystemEmulated):
-    def test_check(self):
-        self.test_rust()
-- 
2.49.0


