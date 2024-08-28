Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CCBC678DF
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web10.5960.1724875789894666889
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kp3MilxG;
 spf=pass (domain: konsulko.com, ip: 209.85.166.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-829e856a159so134851239f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875789; x=1725480589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy/bheMTF1M/dkdk19iArcNleIjNPc57JX/1wb5YVfY=;
        b=kp3MilxGDlfojM5k/ZFU+rpuQO0C7LVQ2OEg440udnNnFd3bgZEfNdXXcXIWnNv04V
         xckz7INpAtoL1qG3Zs8kZgWYnCKQKUuUbuh8eWSuK8uUs17VOqCrWx0fgzENCVr7NGO8
         +dH81BME4oKyNXzaj2v5E7VQREqXUagDHK/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875789; x=1725480589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy/bheMTF1M/dkdk19iArcNleIjNPc57JX/1wb5YVfY=;
        b=e1RCjDHsGdSaQuMYbMkj0k+b4tN0xdTqkJ8ZPOkak4q7EVvSBmcuflp4VAJ4DZxj18
         s7jJRJY6M7Yn5yTqPw4sD/40tgMN+2lLTIfELllMZY/Etp2AZ2rNCqoluTiZQq+eJvsZ
         3MYftyvwVFoh+8lDlL5voIxBh6UsF6o5tnVrurzjT00rgzrsQzJhpGtyklU5anxP41PM
         89dYCdl3XlIto1waqlTKXG85Qz0FYzDVN6eM7dVjl9Q2RlfiGYC3aYOHntp8UJ6eF2vL
         6rhiOBrmhkurlmd1/PxSstNtNCxPv6xlpKEIIjfrb/c9funuYg1R6WVWi+E/MtfymQHd
         W9vg==
X-Gm-Message-State: AOJu0Yydp004mwROlsT/p6M+ZMtu/5sVbZpRBCG3V0in9BcLJk0FFaNj
	WFP3HWeGaAyFXP1KCBtdUG0yhkvr3TklxRYcjKOCC7i6Zsgy/JoKHwrwvcIqae1O+W30Hje/sJy
	L
X-Google-Smtp-Source: AGHT+IG6xXsxNmCDrnykqkEQi2F+0L8jXylXyqtXGDfj/u39Jwji4XpDcpX5QsmdyqnhmFnWFjDHvw==
X-Received: by 2002:a05:6602:6002:b0:804:2216:4b23 with SMTP id ca18e2360f4ac-82a1109952amr69870739f.17.1724875788378;
        Wed, 28 Aug 2024 13:09:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 01/33] Add ptest-cargo.bbclass
Date: Wed, 28 Aug 2024 16:08:47 -0400
Message-ID: <717722f4c8aac86eff77ba97e2fa4504e7c3b093.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/568

Previous upgrades did not include the ptest-cargo.bbclass added in
nanbield, add it now to make backporting future updates easier.
The backport is of the file as of oe-core commit 0101de25.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/ptest-cargo.bbclass | 138 ++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 classes/ptest-cargo.bbclass

diff --git a/classes/ptest-cargo.bbclass b/classes/ptest-cargo.bbclass
new file mode 100644
index 0000000..c46df36
--- /dev/null
+++ b/classes/ptest-cargo.bbclass
@@ -0,0 +1,138 @@
+inherit cargo ptest
+
+RUST_TEST_ARGS ??= ""
+RUST_TEST_ARGS[doc] = "Arguments to give to the test binaries (e.g. --shuffle)"
+
+# I didn't find a cleaner way to share data between compile and install tasks
+CARGO_TEST_BINARIES_FILES ?= "${B}/test_binaries_list"
+
+# Sadly, generated test binaries have no deterministic names (https://github.com/rust-lang/cargo/issues/1924)
+# This forces us to parse the cargo output in json format to find those test binaries.
+python do_compile_ptest_cargo() {
+    import subprocess
+    import json
+
+    cargo = bb.utils.which(d.getVar("PATH"), d.getVar("CARGO", True))
+    cargo_build_flags = d.getVar("CARGO_BUILD_FLAGS", True)
+    rust_flags = d.getVar("RUSTFLAGS", True)
+    manifest_path = d.getVar("CARGO_MANIFEST_PATH", True)
+    project_manifest_path = os.path.normpath(manifest_path)
+    manifest_dir = os.path.dirname(manifest_path)
+
+    env = os.environ.copy()
+    env['RUSTFLAGS'] = rust_flags
+    cmd = f"{cargo} build --tests --message-format json {cargo_build_flags}"
+    bb.note(f"Building tests with cargo ({cmd})")
+
+    try:
+        proc = subprocess.Popen(cmd, shell=True, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
+    except subprocess.CalledProcessError as e:
+        bb.fatal(f"Cannot build test with cargo: {e}")
+
+    lines = []
+    for line in proc.stdout:
+        data = line.strip('\n')
+        lines.append(data)
+        bb.note(data)
+    proc.communicate()
+    if proc.returncode != 0:
+        bb.fatal(f"Unable to compile test with cargo, '{cmd}' failed")
+
+    # Definition of the format: https://doc.rust-lang.org/cargo/reference/external-tools.html#json-messages
+    test_bins = []
+    for line in lines:
+        try:
+            data = json.loads(line)
+        except json.JSONDecodeError:
+            # skip lines that are not a json
+            pass
+        else:
+            try:
+                # Filter the test packages coming from the current project:
+                #    - test binaries from the root manifest
+                #    - test binaries from sub manifest of the current project if any
+                current_manifest_path = os.path.normpath(data['manifest_path'])
+                common_path = os.path.commonpath([current_manifest_path, project_manifest_path])
+                if common_path in [manifest_dir, current_manifest_path]:
+                    if (data['target']['test'] or data['target']['doctest']) and data['executable']:
+                        test_bins.append(data['executable'])
+            except (KeyError, ValueError) as e:
+                # skip lines that do not meet the requirements
+                pass
+
+    # All rust project will generate at least one unit test binary
+    # It will just run a test suite with 0 tests, if the project didn't define some
+    # So it is not expected to have an empty list here
+    if not test_bins:
+        bb.fatal("Unable to find any test binaries")
+
+    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES', True)
+    bb.note(f"Found {len(test_bins)} tests, write their paths into {cargo_test_binaries_file}")
+    with open(cargo_test_binaries_file, "w") as f:
+        for test_bin in test_bins:
+            f.write(f"{test_bin}\n")
+
+}
+
+python do_install_ptest_cargo() {
+    import shutil
+
+    dest_dir = d.getVar("D", True)
+    pn = d.getVar("PN", True)
+    ptest_path = d.getVar("PTEST_PATH", True)
+    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES', True)
+    rust_test_args = d.getVar('RUST_TEST_ARGS') or ""
+
+    ptest_dir = os.path.join(dest_dir, ptest_path.lstrip('/'))
+    os.makedirs(ptest_dir, exist_ok=True)
+
+    test_bins = []
+    with open(cargo_test_binaries_file, "r") as f:
+        for line in f.readlines():
+            test_bins.append(line.strip('\n'))
+
+    test_paths = []
+    for test_bin in test_bins:
+        shutil.copy2(test_bin, ptest_dir)
+        test_paths.append(os.path.join(ptest_path, os.path.basename(test_bin)))
+
+    ptest_script = os.path.join(ptest_dir, "run-ptest")
+    if os.path.exists(ptest_script):
+        with open(ptest_script, "a") as f:
+            f.write(f"\necho \"\"\n")
+            f.write(f"echo \"## starting to run rust tests ##\"\n")
+            for test_path in test_paths:
+                f.write(f"{test_path} {rust_test_args}\n")
+    else:
+        with open(ptest_script, "a") as f:
+            f.write("#!/bin/sh\n")
+            for test_path in test_paths:
+                f.write(f"{test_path} {rust_test_args}\n")
+        os.chmod(ptest_script, 0o755)
+
+    # this is chown -R root:root ${D}${PTEST_PATH}
+    for root, dirs, files in os.walk(ptest_dir):
+        for d in dirs:
+            shutil.chown(os.path.join(root, d), "root", "root")
+        for f in files:
+            shutil.chown(os.path.join(root, f), "root", "root")
+}
+
+do_install_ptest_cargo[dirs] = "${B}"
+do_install_ptest_cargo[doc] = "Create or update the run-ptest script with rust test binaries generated"
+do_compile_ptest_cargo[dirs] = "${B}"
+do_compile_ptest_cargo[doc] = "Generate rust test binaries through cargo"
+
+addtask compile_ptest_cargo after do_compile            before do_compile_ptest_base
+addtask install_ptest_cargo after do_install_ptest_base before do_package
+
+python () {
+    if not bb.data.inherits_class('native', d) and not bb.data.inherits_class('cross', d):
+        d.setVarFlag('do_install_ptest_cargo', 'fakeroot', '1')
+        d.setVarFlag('do_install_ptest_cargo', 'umask', '022')
+
+    # Remove all '*ptest_cargo' tasks when ptest is not enabled
+    if not(d.getVar('PTEST_ENABLED') == "1"):
+        for i in ['do_compile_ptest_cargo', 'do_install_ptest_cargo']:
+            bb.build.deltask(i, d)
+}
-- 
2.46.0


