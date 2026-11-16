Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6319.1794870789446552737
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=O0gbWQ6j;
 spf=pass (domain: konsulko.com, ip: 209.85.221.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ec20398b05so4061284e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870788; x=1795475588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Hd2WjwCeNMWBIxKd0vP44ABcuATK0QxPbUhq32VZM8=;
        b=O0gbWQ6joiIG1cig/e9XhRnXGuL0V3t/bW5iICv7F7ASam9hC33JDEEohbVxHNRj5H
         3qhIalxcLDsYIaNd/7DlKpDxqW/BMhedbTI3Vt+5kUMZQInDTdWAGE1lFh/1w4NJSKEF
         vnt7+/xrCJ9wz18gn8DuLMigJ/odjr26XkIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870788; x=1795475588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Hd2WjwCeNMWBIxKd0vP44ABcuATK0QxPbUhq32VZM8=;
        b=miQEFaJ5SHQnPO//NKvgs8UJbi25HnqnREqIRDICSESTVfLzPNHbvuXC9uuW6TX8sy
         9o+zdry0ga8LEfrmw+Lb/eEEXj7zqNkiMA6qa6aSoxnjrt+128cf6vEIT6oDm6vwAFWB
         Q0tKdFUcWVC0pS26beSfR/5pzuSKI7SiF4tAiJmsaJD4JF5dSSWw7rORqYkfpKSKmajr
         eJ+74gVWXtEmJud3kGl+ubwWtlGqbKjnrJJwloKutQEz1GNuDD9ASjPIUlAA9YqD6Uhs
         Za2A1RGCwJN5BBM5tpFWxkgy1Xs8QK/6hywUYzy039UR6DOyNtSQlyrivTBOAxHaK17H
         33OQ==
X-Gm-Message-State: APuU4Z/dB6gai+pto0UmyYkbJvKpW7mXAXOC+T3sjzNx2lBDdvxZ/v6U
	uGz+6/RD/Go5hC+2cHAKyJnudwRW0Zk+DVzpX7KddPhsUuFBvEy5ZoSbCR25Y9w13TTwVGCz9Yt
	M9eWGog0=
X-Gm-Gg: AYBFou0o+B/s/FTubtk4JVmJNGKHlVdGEErNfIPHbyNMv+HP1enHxcH07/N9RS2zz9C
	NpeVgsrL1nkdaj79wprFzmw88NFh81D2I1sCS4Jj1gZCYt/6xJigAKeRMnSa3a6IsVYG+L21i54
	gSqrJcHprr5Dylo4sA/Wb71qFvhaoPG3TN5zRZSxYW8iIg//tszcc5713Z0p+3mDY9z3k2LMQQt
	1xaLjOupaH7ZHgu/lIqEc4fYGkqbD3sKhILcXnOy3Le8i0AUk0xZovUNiAh+anaQcmegTixUX6k
	HgTDPQ5JNg5aOda4lPAAVVa90kqJypJZ1cRBsQ6cWBXuSsYkm6wMqP9/8Wka3nAlZ6Cgn4xkOL2
	Gyw1r6hekGz3OMtOMkZ4OKNEfU7wxHTpd/pus4hejiBR32HPPxis1Yqy47++1J7B5KKjrkSG98L
	8aNGP1BYOBWYa0Bue421XQQ/dSC7qv/Mqh1Af48xi5hTOzvGw9QSCxIkF0AZq07FoG+cfm10v+7
	8VKIacZHcKHfOvLoW9S5/EPBAYAh7Pf2bCGodHX77ka+Aat15g95nOQ3YvohztP/4Q5skHEH7v3
	oUuRVJP0dq8Z+9MNWnVdI5ZBp+7U5ItsK1QVEffspb5ENUJH1pSw2xNydC3QfErId3FPI/gKtev
	fxDaApI1Paw7kCVXJPlLUCxDRTPN/z8Aa3vuagfMXCGduBSISRlVQMw/0wmL2B4GzzQ==
X-Received: by 2002:a05:6122:2094:b0:5ea:e18b:32e3 with SMTP id 71dfb90a1353d-5ee34aa1142mr4672940e0c.15.1794870788159;
        Mon, 16 Nov 2026 15:13:08 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:07 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 19/19] ptest-cargo: align test and application build environments
Date: Mon, 16 Nov 2026 18:12:40 -0500
Message-ID: <016354f64984a6de91edc792fe77d77ff3c2ac04.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5458
Content-Type: text/plain; charset="utf-8"

From: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>

do_compile runs oe_cargo_fix_env before invoking cargo. That function
points cargo and the crate build scripts at the cross toolchain correctly.

do_compile_ptest_cargo spawned cargo from python with only RUSTFLAGS
set, so every build script that still had to run for the test build
(e.g. dev-dependencies, test-only features, etc)
saw the plain task environment. The test binaries were therefore built in a
different, and for cross builds wrong, environment than the application.

Run the test build through oe_cargo_fix_env as well so both builds share
one environment.

Co-authored-by: Patrick Wicki <patrick.wicki@siemens.com>

Signed-off-by: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 81ace97afd065c8c6b9753451f6b62b2400f008d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 35 ++++++++++--------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 62444e9..5cdd1c4 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -5,39 +5,28 @@ RUST_TEST_ARGS[doc] = "Arguments to give to the test binaries (e.g. --shuffle)"
 
 # I didn't find a cleaner way to share data between compile and install tasks
 CARGO_TEST_BINARIES_FILES ?= "${B}/test_binaries_list"
+CARGO_TEST_BUILD_JSON ?= "${B}/cargo_test_build.json"
+
+# Build the tests with the same environment as do_compile (oe_cargo_fix_env).
+cargo_ptest_build () {
+    oe_cargo_fix_env
+    export RUSTFLAGS="${RUSTFLAGS}"
+    bbnote "Building tests with cargo"
+    "${CARGO}" build --tests --message-format json-render-diagnostics ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} > "${CARGO_TEST_BUILD_JSON}"
+}
 
 # Sadly, generated test binaries have no deterministic names (https://github.com/rust-lang/cargo/issues/1924)
 # This forces us to parse the cargo output in json format to find those test binaries.
 python do_compile_ptest_cargo() {
-    import subprocess
     import json
 
-    cargo = bb.utils.which(d.getVar("PATH"), d.getVar("CARGO"))
-    cargo_build_flags = d.getVar("CARGO_BUILD_FLAGS")
-    packageconfig_confargs = d.getVar("PACKAGECONFIG_CONFARGS")
-    rust_flags = d.getVar("RUSTFLAGS")
     manifest_path = d.getVar("CARGO_MANIFEST_PATH")
     project_manifest_path = os.path.normpath(manifest_path)
     manifest_dir = os.path.dirname(manifest_path)
 
-    env = os.environ.copy()
-    env['RUSTFLAGS'] = rust_flags
-    cmd = f"{cargo} build --tests --message-format json {cargo_build_flags} {packageconfig_confargs}"
-    bb.note(f"Building tests with cargo ({cmd})")
-
-    try:
-        proc = subprocess.Popen(cmd, shell=True, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
-    except subprocess.CalledProcessError as e:
-        bb.fatal(f"Cannot build test with cargo: {e}")
-
-    lines = []
-    for line in proc.stdout:
-        data = line.strip('\n')
-        lines.append(data)
-        bb.note(data)
-    proc.communicate()
-    if proc.returncode != 0:
-        bb.fatal(f"Unable to compile test with cargo, '{cmd}' failed")
+    bb.build.exec_func("cargo_ptest_build", d)
+    with open(d.getVar("CARGO_TEST_BUILD_JSON")) as f:
+        lines = f.read().splitlines()
 
     # Definition of the format: https://doc.rust-lang.org/cargo/reference/external-tools.html#json-messages
     test_bins = []
-- 
2.56.0

