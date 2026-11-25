Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3164.1795645899595800199
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dnVViOl0;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55ade1de0b4so72859521cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645898; x=1796250698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W2nCmwsjL2Tc+WzotmKMgZfHInE9ED+ywRQzutFeJ5c=;
        b=dnVViOl0OTEfC+iARaNMMemqIK1BhSGvpOddAN2hTYm342xmZag8DFBvlkgppdIgTb
         qUw7rSvIEcTAZqvq5anF4Z9B5aqpGeLSpFtjNYzoEFqs9nAxIhrjY1m646XnJxM+aj3U
         TB0nXDOU6AafS08FSAJrL5x0JV8nTwKzyEBc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645898; x=1796250698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W2nCmwsjL2Tc+WzotmKMgZfHInE9ED+ywRQzutFeJ5c=;
        b=RnW8NExk4QDgd91iIoLx15bh37HpKFISz8GcrIVbAoU+0YW4MgcO8cwXY239IH1q6Y
         ifToQVEdG9zpGnuciEY6PBngpryWmcx/opBK/Tk3RwJmNLtaA6zo/BpSQ5BfNXnRVM/4
         +xbOBJZTsMFgjoOVYM9qD1zSy7hmElmKQLfKMa6Qq78z8BPUXpjTgyi0LsndgjjKlS+U
         oIh33ijMujRttz1e8GRIDzS/94CPhK6q8ACoBVwb3qvACuj6F6KUdHzEXhcBAAEWOsMl
         E4eGM93FCul0Yd0DXRATgBiHX70HnTMGyFtCq8rVHDzSsDXzzi4Tnh+qExWwz6TGRwwM
         rb/A==
X-Gm-Message-State: APuU4Z96Ef6B0gUt2EdrJRNIP/gY++50rI4wDN8fnzW99jQ1DN2bDDoE
	7cGeTQqHGRhglzaBCQ/HWgZaLIelQd7GNZE52yXnK0IM/W6kPIsImN5cy3wuxQGREGY67gHJM3Q
	DNrp1
X-Gm-Gg: AZFdTZeZ/iN10K/Td2QRBh3oDguklZCiP7QbJV2AKyQG10GtdzU8plJOV7c5IGtBYgP
	4dwThE2w5KJ1hzDVBwWy4gmTVnGTZSV+8nRaW+ODCJkHeMujGw7W3yDv6mfRDGZ0/refTvCP94s
	76nCVVbZcJTUw52GUDaHYD6uoB+p/0XqQ5C0+QQQ+n/XKXEI/2VC+lCPXC4RErjYU4RYWxHe9KW
	qrrP+5BbfDLC44fMHoSiz7TKIxyScJbFk2AG42GgZ3WzC4twDJ8SNwnQ54rFUoYLrFUpurc5d6J
	D2vzqtywTRTOSJlWlFfx/4oZ0N/27eX3vOpLXma3Zw0nGRDuE60ew2I6xmg3dEmUFtxr/bDwBw5
	wxGhDRm0AJ6vYoFx1USzCMl36DY7LiTogS9/7NMhe1kvsdAQ2Pnc5BRTS3BiVjSnINVDzqvomIW
	4HNzVuj4I266d3fBUxjPftPHZSCG0xql8RLuVUk4Zqa38wY9OSPHaGTWrZbkAHHI7zRGeKJo6J9
	EZ8M9a5rMOtx7F2Hi4czDHFxwxBcj2Mnvj+yxn1w/qv11c8HWze59l8WRGX77W7ZFfVWPXls8xr
	7BJDcbSt0JHNVzaxZ7MwKZEOpH4ol1YAAQG9Nn4VbTN/GKiojBJC3hN4VCbaQLAMVO+YI3CXjFH
	rWYDYKzyYrvN/vbS+5/iGo8FCc/AMu/qdVKdPasYIWqgxMt7kyGtLE+FCPPoG8Q2U3A==
X-Received: by 2002:a05:622a:58c4:b0:542:d089:7b11 with SMTP id d75a77b69052e-55d76b6047amr342743061cf.77.1795645898352;
        Wed, 25 Nov 2026 14:31:38 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:37 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 19/19] ptest-cargo: align test and application build environments
Date: Wed, 25 Nov 2026 17:31:10 -0500
Message-ID: <aab2170013dc2e82444cc3acccba73574885b86c.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5538
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
2.56.1

