Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA7C369A5
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:14 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web10.60134.1744061465782022565
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TJRY+YYA;
 spf=pass (domain: konsulko.com, ip: 209.85.166.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86135aeca58so60960439f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061465; x=1744666265; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5sOUaRsMHrp8/VqJQhbgXp32Qw0PHUK+HuCsZOYU8g=;
        b=TJRY+YYAakXmlUd59/yIo6LJmA1/HDcR/gtzwzpBsiw8WG3tk1+gDiZqKdl6wkX87l
         OGW/ifNDGBjwPohh4Rd5fS8VNyoKEzI4WV2IqmdPRt+U86CwaGQeZNcGMqYnHzm58evd
         oCQ0u7+E3DUdfQyytsa9escB6puoc8yw2LWw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061465; x=1744666265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5sOUaRsMHrp8/VqJQhbgXp32Qw0PHUK+HuCsZOYU8g=;
        b=ITjv95kJFWm6EVge8W4vFZAZYepx11xzqyl3L3iuDd8QYLTxTmYIqlynGXXtNKdOBm
         pA5iH8pEpHntrSctR+N28KSm3WDFSayJGElaQm1fqck2zfXFd9lRMAt6BvNj3rdOHcm0
         O7UbFWXs0lpm1t81xGPenNv7VFuQrBNYwZ9bFSFo3FDQBI9gUmGgB3M+AzoOmS10KyS2
         lkfGCe9OmWTjqGg8h8eXskzGNkbZitG2DWSPawGZtR03tCqPlE4R8fqyGTab69as0AB3
         Ju9KIXo4h8cbxkwLZitk2WjYK3uzrCmlfI1KFYJ1UDyyEhFOOp5hdz+YKxc3XKdEfPh5
         0MKw==
X-Gm-Message-State: AOJu0YzeS69S6vjw5/oLu6x5aHZiX5MNLoTQMhF/9HmEHp5UDpy4cy+b
	8As63PKpOtK89YnUdO7jTUDLCwnpORYBIrkGeHr25ZOB7ru5GZ5UXzMOepwBM5S23Ny3aOcucl6
	O7GU=
X-Gm-Gg: ASbGncuRnclO2X9FhIrXowt6RU/9xEDjiZ3TXO8yoaUkr4uK7VkTeclbpyi4QH0Ch0+
	ZrAiz7Iu6ldu/X1iRsKHsb2RRsnsqHQlBvABDvH7O0QsG8x5naycBA/sJDVOXNqSDguXTF3Bt1W
	Xjg2xVJNo52YDZOWgKa01kwsi/c6ait6bpZ+x+sX6EAYvR2qM1LlyL5Z7LkULRD7+AMDZ1Uxmey
	2HGXKFWs7s9J1KhVoO1keAqaJQn0gnlAUJikZHv7HITdRMBd1FYA+1exXfVNMg+bjRxqZ+n6O7c
	agKY42k4oOUduAQ3gJz1ciMwOFOCN2DUTwKfuuxQPJjdnG74wysKw1FQ5PKmZnyAC3XxMAnMMyu
	X2Fy95M5eTtOskyabhZfHn2oI+ToIU7w=
X-Google-Smtp-Source: AGHT+IGBapmeRO//ggVjBz1z51pCaw12YallQZm4qwVe69Mdm+6dNFe1um8T0w/L9RO6gaOP6n5LJA==
X-Received: by 2002:a05:6602:4c8c:b0:85c:c7f9:9a23 with SMTP id ca18e2360f4ac-8611c3f6147mr1469788939f.14.1744061464708;
        Mon, 07 Apr 2025 14:31:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 26/29] rust: Update "do_update_snapshot" task for rust-snapshot.inc
Date: Mon,  7 Apr 2025 17:30:15 -0400
Message-ID: <aea3ba62a36e5a0fafc4f4a68f93dc6adef44eee.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1326

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


