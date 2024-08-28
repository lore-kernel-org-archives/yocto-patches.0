Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC3C71120
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web11.5849.1724875801530684742
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kGhWt0ag;
 spf=pass (domain: konsulko.com, ip: 209.85.166.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f8f0197abso351732739f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875800; x=1725480600; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXrFqBzCD0xDfiCmWRu7EChBTtvDJB8yOF96UVpj6FE=;
        b=kGhWt0ag3BraxEgo0VPH7wEObYOUYi51ad3RbOFl6sicyAYpkaTDmmcAP2aiJe3UWB
         d55SPkA+mIBd2sQ47qjHPt5DzT0nwrRuHk6229XUBUA8reAK3fgHm5dz2KJ186upvPER
         0GvYCIttVRki2c0l/RYahTrGH+P85PM0hq+9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875800; x=1725480600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXrFqBzCD0xDfiCmWRu7EChBTtvDJB8yOF96UVpj6FE=;
        b=FE5ob90g3IqrJmq8c+NAzPXi5sM4VONaru/5VqkceUeBzT5JygNjUx+jwxAdRHIQ7w
         yc3Zik7QjXney5lN8ov4ON3QaIEtMEeK0Y/3Y6402Uh57LVAnK/PP1WM1pp6n0DRIFwx
         k9OwZN0Bn6AKXz3tqzW3EYSbkqUTVbe1lQUONeMLoaE/3FPANL2U83Lp6U3xa7ajhWEf
         WeFdBCAOJGb0p2gykSoMc8oTczWBhh4ZPot+GJ9yPuoX66OsIEcBRhV85VJwz3bedMof
         PLuCjV9U6C3L65cgxFt8ztUqL1YA3vJ8ZVpBb2PHO/ETfiKUrg1vhHJyrgFwED0acOIw
         XIsw==
X-Gm-Message-State: AOJu0Yy/5swnmJBMbFIXhczzD9giflg7V1TAifgHJ7FBWc2+cwOJ9OaG
	++KpoGZbehIsu50VIq6m4KHccd8XsS9RIKf5xAwh0KYQox/9KHVRr1GzLwtLhTd3NLzZ3uB+Pv5
	Q
X-Google-Smtp-Source: AGHT+IEho+l09dDcmI312VdU5OsEnlY3QbjJKlTd+6sB84E8nY6UMvi67PHPHwrqOyCLqYAAwp5wQw==
X-Received: by 2002:a05:6602:15d3:b0:81f:a3c3:abb2 with SMTP id ca18e2360f4ac-82a11083523mr84216239f.15.1724875800328;
        Wed, 28 Aug 2024 13:10:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 15/33] cargo: remove True option to getVar calls
Date: Wed, 28 Aug 2024 16:09:01 -0400
Message-ID: <9d3f1c0f834df8f5511f29703ecee5a1703e7c28.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/582

From: Peter Marko <peter.marko@siemens.com>

Layer cleanup similar to
https://git.openembedded.org/openembedded-core/commit/?id=26c74fd10614582e177437608908eb43688ab510

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9a2ed52473a3e4eb662509824ef8e59520ebdefb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo_common.bbclass |  4 ++--
 classes/ptest-cargo.bbclass  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/classes/cargo_common.bbclass b/classes/cargo_common.bbclass
index dcaf881..92731c2 100644
--- a/classes/cargo_common.bbclass
+++ b/classes/cargo_common.bbclass
@@ -41,7 +41,7 @@ CARGO_SRC_DIR ??= ""
 CARGO_MANIFEST_PATH ??= "${S}/${CARGO_SRC_DIR}/Cargo.toml"
 
 # Path to Cargo.lock
-CARGO_LOCK_PATH ??= "${@ os.path.join(os.path.dirname(d.getVar('CARGO_MANIFEST_PATH', True)), 'Cargo.lock')}"
+CARGO_LOCK_PATH ??= "${@ os.path.join(os.path.dirname(d.getVar('CARGO_MANIFEST_PATH')), 'Cargo.lock')}"
 
 CARGO_RUST_TARGET_CCLD ??= "${RUST_TARGET_CCLD}"
 cargo_common_do_configure () {
@@ -171,7 +171,7 @@ python cargo_common_do_patch_paths() {
     # here is better than letting cargo tell (in case the file is missing)
     # "Cargo.lock should be modified but --frozen was given"
 
-    lockfile = d.getVar("CARGO_LOCK_PATH", True)
+    lockfile = d.getVar("CARGO_LOCK_PATH")
     if not os.path.exists(lockfile):
         bb.fatal(f"{lockfile} file doesn't exist")
 
diff --git a/classes/ptest-cargo.bbclass b/classes/ptest-cargo.bbclass
index c46df36..fd1df9d 100644
--- a/classes/ptest-cargo.bbclass
+++ b/classes/ptest-cargo.bbclass
@@ -12,10 +12,10 @@ python do_compile_ptest_cargo() {
     import subprocess
     import json
 
-    cargo = bb.utils.which(d.getVar("PATH"), d.getVar("CARGO", True))
-    cargo_build_flags = d.getVar("CARGO_BUILD_FLAGS", True)
-    rust_flags = d.getVar("RUSTFLAGS", True)
-    manifest_path = d.getVar("CARGO_MANIFEST_PATH", True)
+    cargo = bb.utils.which(d.getVar("PATH"), d.getVar("CARGO"))
+    cargo_build_flags = d.getVar("CARGO_BUILD_FLAGS")
+    rust_flags = d.getVar("RUSTFLAGS")
+    manifest_path = d.getVar("CARGO_MANIFEST_PATH")
     project_manifest_path = os.path.normpath(manifest_path)
     manifest_dir = os.path.dirname(manifest_path)
 
@@ -66,7 +66,7 @@ python do_compile_ptest_cargo() {
     if not test_bins:
         bb.fatal("Unable to find any test binaries")
 
-    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES', True)
+    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES')
     bb.note(f"Found {len(test_bins)} tests, write their paths into {cargo_test_binaries_file}")
     with open(cargo_test_binaries_file, "w") as f:
         for test_bin in test_bins:
@@ -77,10 +77,10 @@ python do_compile_ptest_cargo() {
 python do_install_ptest_cargo() {
     import shutil
 
-    dest_dir = d.getVar("D", True)
-    pn = d.getVar("PN", True)
-    ptest_path = d.getVar("PTEST_PATH", True)
-    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES', True)
+    dest_dir = d.getVar("D")
+    pn = d.getVar("PN")
+    ptest_path = d.getVar("PTEST_PATH")
+    cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES')
     rust_test_args = d.getVar('RUST_TEST_ARGS') or ""
 
     ptest_dir = os.path.join(dest_dir, ptest_path.lstrip('/'))
-- 
2.46.0


