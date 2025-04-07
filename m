Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D77BC369A8
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web11.59613.1744061461936565908
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=onOccelk;
 spf=pass (domain: konsulko.com, ip: 209.85.166.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d57143ee39so39254615ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061461; x=1744666261; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tbPZw3QHZCdVDpLYo+yrzab306eUWiEqYCoeWbyA2w=;
        b=onOccelkXtARuevNjhIZ6uLDvNGJT7wtT5kxNVr8OBiMzJzz98Gk7KovSonaAFSoip
         1BQ9EObxZAj9wLOOSHP/7j46NTkbEukv+S4BgCUsSDURvUJ6aCvzgTV9LtsdM8RvQRpM
         jdZQua6JZVM6E4ZlUDg06imSVJgGTvNTEODz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061461; x=1744666261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tbPZw3QHZCdVDpLYo+yrzab306eUWiEqYCoeWbyA2w=;
        b=AZwPWdU4SL+T6VFo/icpjjkDP9AATAfqzKQOUH7RbbrSrxG8ht5+PBHvSMw3eRiODv
         jo4AAo3uLvCIalZKdiUaRoqt+//pFiSsZvYlAYWaCC1h3JOzfp0tp+HrCNK0IBEXbqzM
         JEduXaV7rgo7l4hmvQUhCj2UZ37/sMGX5rXzyxVSlvfOe0w8CuUcuzKFIMcA2uraTDr6
         ygT9eOxd2I2re/A59IbSbMHCFcAPibUtnRGcJ3H+9B/Dvmn6O7dUUX2qwmd3+rJJhacT
         R2aOntIng55uDQExjq3ZRTgMS9TOl+dKAo53gYnkRIfLQQgBeXWE0XG4gnWGvafd8O7p
         ljhA==
X-Gm-Message-State: AOJu0Yz8wXnYYaOSlL/2DNmoLh7EeL3nMWXpzl1bTP2b0GZhJcqQM46O
	TuH4a0DrroC48f1u6ULYjPH8Nrm8dStjMXEe50HhgT39gSjyWcyw0IViwzlhiloRCvZpgUU9U6C
	wmv0=
X-Gm-Gg: ASbGncsy68cJiUmvI12WcwrYS83AMIkZQpxlsvoV/46qaL5xyZa54XCj44zwTIxgRQY
	cZnmG/63G/ALjtHOUlmto0dCetadR756mGs3j/PLCHjgWXRvfW5JEvREvsHPYF9GShlCAGjMQWk
	zdzYHz9ART8x8RgcjsYsnqL2KQEsXR6+lVZLYx6LqNOFL/dVscuhpllCdW6UNbrpMpE+zhHVQGj
	UZN0TUNAXwWSQ7+hQNIlJ4K4O4j42XEA2wj4Pxi3v9TAlyPM9Ha0btVjgZgexRezFVtjrG9bHH0
	6rSTXDZ5cxz/cS1KPcRqTtfQEOG3AwvM/nCwFT5lf9noLro5JoaXLUIyXuPmYxrqnHwLeg9T/b/
	64QvkQZn84zn3MewDJMhXXR+Un8Pvdak=
X-Google-Smtp-Source: AGHT+IFN0vp2bxyHZ3W0/LpC5fmptp4ibmwxolcWC7nKJQ5O95nofT3jqRQHsYKJZg8b2i7Ga8kE3A==
X-Received: by 2002:a05:6e02:2701:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3d6e3ee1a2cmr128324565ab.5.1744061460914;
        Mon, 07 Apr 2025 14:31:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 22/29] rust: Fix build failure when multilibs are enabled
Date: Mon,  7 Apr 2025 17:30:11 -0400
Message-ID: <0901b65272b370bae8d2a9cd1131e4016bf25de0.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1321

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

When multilibs are enabled, building rust is failing because of the following commit
https://github.com/rust-lang/rust/commit/68034f837a39387e49fc7d7c5b088f5372a1127e
with stage1/rustc cannot able to find dependent *.so files. The issue is
been fixed inrust-master with the following commit by passing the necessary library
paths before executing stage1/rustc

Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/139d6ba054a1a4cc5fe64981ad46fd5547bd4916]

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ab29b970ba7e08eabca92018d103af5f249ed2c5)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../Zdual-proc-macros-additional-check.patch  | 31 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch

diff --git a/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch b/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
new file mode 100644
index 0000000..6bb1738
--- /dev/null
+++ b/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
@@ -0,0 +1,31 @@
+Fix bootstrap failure when multilibs are enabled.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/139d6ba054a1a4cc5fe64981ad46fd5547bd4916]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+---
+diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/core/builder/cargo.rs
+index 066e6bf53f..a2f6fac4b1 100644
+--- a/src/bootstrap/src/core/builder/cargo.rs
++++ b/src/bootstrap/src/core/builder/cargo.rs
+@@ -646,7 +646,10 @@ impl Builder<'_> {
+                 // Build proc macros both for the host and the target unless proc-macros are not
+                 // supported by the target.
+                 if target != compiler.host && cmd_kind != Kind::Check {
+-                    let error = command(self.rustc(compiler))
++                    let mut rustc_cmd = command(self.rustc(compiler));
++                    self.add_rustc_lib_path(compiler, &mut rustc_cmd);
++
++                    let error = rustc_cmd
+                         .arg("--target")
+                         .arg(target.rustc_target_arg())
+                         .arg("--print=file-names")
+@@ -654,6 +657,7 @@ impl Builder<'_> {
+                         .arg("-")
+                         .run_capture(self)
+                         .stderr();
++
+                     let not_supported = error
+                         .lines()
+                         .any(|line| line.contains("unsupported crate type `proc-macro`"));
+
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 28f5aeb..ee23e5a 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,6 +7,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
 	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
+	    file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "e23ec747a06ffd3e94155046f40b6664ac152c9ee3c2adfd90353a7ccff24226"
 
-- 
2.49.0


