Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0886C3ABB9
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.4664.1746132063683368626
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Sx1uF39z;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8ec399427so14167166d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132062; x=1746736862; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5sOUaRsMHrp8/VqJQhbgXp32Qw0PHUK+HuCsZOYU8g=;
        b=Sx1uF39zASn4DLg7+AJWItz3Mizup4ZV0M82mWqpKBByAoAppc1jlUOAerZTGuebdg
         xFgic4U1Fn35zsKa+4Iqy6Zau31fLc/+pYp6uunsRu6EQ89xJmfHhbXwX22evjbh6puN
         Y95pvqD/C/xBi4CDFhoU8yeIs4hVS/38oSYNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132062; x=1746736862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5sOUaRsMHrp8/VqJQhbgXp32Qw0PHUK+HuCsZOYU8g=;
        b=WQ/7uyVX1BoC1QSeugHVJ5gyXVeRnYZudwzVFZOBw0vBysn/jVDpkUsb5cBwIrn0Lc
         +AJ1Axh/32hBkWFvrquhDuFe1Sls1Bmy4leMwOS5sDLv2Z9YDIA3YZzo0FCfXtpoCTMB
         j8V6YBjqW14Di6GuJL4EVyqMc6xKK4e1Ds+/yR9JF1DHwXHrAPkOf+3MMPJvQj1okbRl
         yTULJOYtwZwQPvSRXrmqOhiqnhiuAnFaW9W0qhROj6Oj9Vw8FdgcjJUgPnfA3IWxR2xK
         FdnSnOjg/0kjqiCvqNRiIm/hjAt4BM1vPakjWjOAgdpdRFhES0EiOUSUaU94CdXZrGgp
         o+iA==
X-Gm-Message-State: AOJu0YxfDrrgJvmrvatAgLQ3tlCfatrImWzrLk4r2f+bxr1icccrdj8p
	QSqH6tBD/NoqexFWYjP8Xpvvli+GGKjN4MLHQChTyxe/2LC96APh5EErFS7Hi790ZPlKVLbFDsX
	T
X-Gm-Gg: ASbGnctBAr9abYjKOu+jG5z7ojpygDsYqTwmMEU6LISvDUVes4vNnrqhv1knTkdJhAh
	iiscBFfT9USM0hY/Yl0E3lh4xetjNd9RQi99gGbtgzhdz9gNumxhnyu0QTQIGmVSDk26nMzm2rk
	jbnt5oPpCFYf9dVynxD5iCBktvC2ruXeA9E8D8d5qOSwM4Ibj03BcSX/WzCQttNabivOsrWcRqf
	gMPBPLyB1qYKKkMmVRD7Wti+oFmZtuk24dLTenldmtbyGwQDa3IfdpVQ0FVLaMFnVy2BN8kjC/f
	Hg3gF74YamAhaE69nZ3Cav0x2xCTpLllQ6J58pNJJRGorrOu5XxLyt/shitiYSkH37dnBDvk7MB
	5ELstwaA058SmHrJh
X-Google-Smtp-Source: AGHT+IGoRGIVvVhf/gcDB/mGHC4AwORL2OGwTbSo5Ci+0SM4Dfy0PyLskUbvZpUjLh1AQZE7htOkFw==
X-Received: by 2002:a05:6214:f21:b0:6e4:f090:3634 with SMTP id 6a1803df08f44-6f5155f3f82mr10804276d6.33.1746132062499;
        Thu, 01 May 2025 13:41:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 28/38] rust: Update "do_update_snapshot" task for rust-snapshot.inc
Date: Thu,  1 May 2025 16:40:04 -0400
Message-ID: <9b19e89f2be3f28a25b9b51fae8852bf74d89945.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1455

From: Yash Shinde <Yash.Shinde@windriver.com>

The 'do_update_snapshot' task is failed with below error:
Exception: FileNotFoundError: [Errno 2] No such file or directory: '.../rustc-1.83.0-src/src/stage0.json'

There are changes in use of key-value format in stage0 file in
rust sources and the rust recipe should be apdated for that.

Changes in rust:
https://github.com/rust-lang/rust/commit/1adfffd07f8704ca722f3897719ace079944b0c5

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d64456f6ea58d683993b0bc7294baa889bafdf7b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.84.1.bb | 47 ++++++++++++++++++----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.84.1.bb b/recipes-devtools/rust/rust_1.84.1.bb
index 40b813b..dfc9960 100644
--- a/recipes-devtools/rust/rust_1.84.1.bb
+++ b/recipes-devtools/rust/rust_1.84.1.bb
@@ -327,24 +327,37 @@ python do_update_snapshot() {
 
     from collections import defaultdict
 
-    with open(os.path.join(d.getVar("S"), "src", "stage0.json")) as f:
-        j = json.load(f)
-
-    config_dist_server = j['config']['dist_server']
-    compiler_date = j['compiler']['date']
-    compiler_version = j['compiler']['version']
+    key_value_pairs = {}
+    with open(os.path.join(d.getVar("S"), "src", "stage0")) as f:
+        for line in f:
+            # Skip empty lines or comments
+            if not line.strip() or line.startswith("#"):
+                continue
+            # Split the line into key and value using '=' as separator
+            match = re.match(r'(\S+)\s*=\s*(\S+)', line.strip())
+            if match:
+                key = match.group(1)
+                value = match.group(2)
+                key_value_pairs[key] = value
+    # Extract the required values from key_value_pairs
+    config_dist_server = key_value_pairs.get('dist_server', '')
+    compiler_date = key_value_pairs.get('compiler_date', '')
+    compiler_version = key_value_pairs.get('compiler_version', '')
 
     src_uri = defaultdict(list)
-    for k, v in j['checksums_sha256'].items():
-        m = re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
-        if m:
-            component = m.group('component')
-            arch = m.group('arch')
-            src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] = \"{v}\"")
-
+    # Assuming checksums_sha256 is now a key-value pair like: checksum_key = checksum_value
+    for k, v in key_value_pairs.items():
+        # Match the pattern for checksums
+        if "dist" in k and "tar.xz" in k:
+            m = re.search(f"dist/{compiler_date}/(?P<component>.*)-{compiler_version}-(?P<arch>.*)-unknown-linux-gnu\\.tar\\.xz", k)
+            if m:
+                component = m.group('component')
+                arch = m.group('arch')
+                src_uri[arch].append(f"SRC_URI[{component}-snapshot-{arch}.sha256sum] = \"{v}\"")
+    # Create the snapshot string with the extracted values
     snapshot = """\
 ## This is information on the rust-snapshot (binary) used to build our current release.
-## snapshot info is taken from rust/src/stage0.json
+## snapshot info is taken from rust/src/stage0
 ## Rust is self-hosting and bootstraps itself with a pre-built previous version of itself.
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
@@ -352,10 +365,10 @@ python do_update_snapshot() {
 SNAPSHOT_VERSION = "%s"
 
 """ % compiler_version
-
+    # Add the checksum components to the snapshot
     for arch, components in src_uri.items():
         snapshot += "\n".join(components) + "\n\n"
-
+    # Add the additional snapshot URIs
     snapshot += """\
 SRC_URI += " \\
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \\
@@ -369,7 +382,7 @@ RUST_STD_SNAPSHOT = "rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-lin
 RUSTC_SNAPSHOT = "rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
 CARGO_SNAPSHOT = "cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-linux-gnu"
 """ % config_dist_server
-
+    # Write the updated snapshot information to the rust-snapshot.inc file
     with open(os.path.join(d.getVar("THISDIR"), "rust-snapshot.inc"), "w") as f:
         f.write(snapshot)
 }
-- 
2.49.0


