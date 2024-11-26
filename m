Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D1D65549
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web10.53094.1732644737124377124
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=k/K6MA80;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d408e38561so33282256d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644736; x=1733249536; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaiM62H6DXZWgRmc0LIs+TQUXSf/3e96PkPYwuC3XYY=;
        b=k/K6MA80pGJcbGJhgznxKUN/Qc6+oc5w+ehH01ZrrcbM/0fXDo7bTEr6VN8i1Hhhwh
         kPVbgrbD72ljsep71uHtS0NDsCpFKD+Ui+ZB7GxhjULUUB6YjpROwzVQIOZZ1cD1xJEQ
         hO/1GtBzKBeAOHo0HgCgvJpIo/amOWWv6W1bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644736; x=1733249536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaiM62H6DXZWgRmc0LIs+TQUXSf/3e96PkPYwuC3XYY=;
        b=sWEuSUi0ZW+YGGsUZ4TJTWfEoiOG4tA4fyB71PMI38jnQ8Rc1X3RF7uTOY+u/s4e89
         v47qiOLr2jP80ok0C3M00r1Ba3kmqG08GpKadh3ibe1umUCmAsrQMr0HR8gGzgcInHS9
         iH5LiGwqPYyyFes5jl8cRYei1gEvG2Kh6kuqEa70YNLK9SE1msjON6Q/dIY1j75FEmTp
         u6i5536YKvFbIfujbTmCj3Rd3zFcyuiYvtI/oCz/ww8zu4O4xgYsz0c2bQ/AtMcXIOC3
         RDqJJr5vZowWsN9Y+SGMMQGHSWfV4P5mLjYXHOlBhXr2XoMQQDxiE3xYaHES8doGqljn
         /2Aw==
X-Gm-Message-State: AOJu0Yzar2gpcvHLqZaSNnBVAXmjWvuEj28rlvF+qhn7IG3L+yK7wA+E
	vBS/nDzzUbo+FdxmMOAuYFEryEkQZdTvDFcfvZ91rFU7HlV/Gl9EefpBVPtXYKgnDYcqmedLs8u
	5
X-Gm-Gg: ASbGncs/5xRVa1THwIDnrzd720gZ/3PggKS5LccUpR5S74Zsg+jejBy7RL2tfPiOFkP
	iD07hwYnZMutq+xnzuG8FvQGW2iKw7tyhnGIsTev3ZXc5CeXU68z1uggK/FOR+efKrLVJONq3Ft
	zTuPFpV9u4UwLIiF/UCxB70hQM1tzp0iziyE9fThv79rW466EEox7m3K4lqFsiucFIyC9K0B0LH
	MZmQWwyRQ+qMGf9BmK5MiL86eZw1sHx2bk4lt7yGMzfupT3xIvl8LH61UMDY0KmQ8jz4DkqvPCD
	k+Atsfuv7ZsRtnzQb446azSmXw==
X-Google-Smtp-Source: AGHT+IEiqWo7/YSjEw7UU44ONjVE0R8Ex/eckPzi+3AVy+erpX6IPLPgg0uGYbgLpG8B377h3Ho3lg==
X-Received: by 2002:a05:6214:5197:b0:6d4:19d2:2089 with SMTP id 6a1803df08f44-6d864d8c860mr235456d6.32.1732644735879;
        Tue, 26 Nov 2024 10:12:15 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:15 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 5/9] rust: Add patch to increase timeout in process-sigpipe rust selftest
Date: Tue, 26 Nov 2024 13:11:36 -0500
Message-ID: <20241126181152.407253-6-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/838

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

This commit adds a patch to increase the timeout in the process-sigpipe
rust selftest to prevent occasional failures under heavy server load.
The patch aims to reduce the likelihood of false negatives when the test
environment is overloaded.

Patch file:
* oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch

Fixes [YOCTO #15625]

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 12c85933e2150ba78a8a914787e400c95c5cf585)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...crease-timeout-in-process-sigpipe-ru.patch | 31 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch

diff --git a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
new file mode 100644
index 0000000..b42dda8
--- /dev/null
+++ b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
@@ -0,0 +1,31 @@
+From b4524278985f517b0785b6f64a21380dcf1ff096 Mon Sep 17 00:00:00 2001
+From: Peter Tatrai <peter.tatrai.ext@siemens.com>
+Date: Mon, 4 Nov 2024 13:58:16 +0100
+Subject: [PATCH] oeqa/selftest: Increase timeout in process-sigpipe rust test
+
+This patch increases the timeout for the process-sigpipe rust test, which
+occasionally fails when the server is under heavy load. Increasing the timeout
+reduces the likelihood of false negatives under load.
+
+Fixes [YOCTO #15625]
+
+Upstream-Status: Inappropriate [OE testing specific]
+
+Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
+---
+ tests/ui/process/process-sigpipe.rs | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/tests/ui/process/process-sigpipe.rs b/tests/ui/process/process-sigpipe.rs
+index 11f363d62..c12d66016 100644
+--- a/tests/ui/process/process-sigpipe.rs
++++ b/tests/ui/process/process-sigpipe.rs
+@@ -23,7 +23,7 @@ use std::thread;
+ fn main() {
+     // Just in case `yes` doesn't check for EPIPE...
+     thread::spawn(|| {
+-        thread::sleep_ms(5000);
++        thread::sleep_ms(10000);
+         process::exit(1);
+     });
+     let output = process::Command::new("sh")
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 929a4a9..f0681c8 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,6 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
+            file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "ab826e84b8d48ec6eda3370065034dea8c006f6a946d78a9ba12bcb50e6d3c7a"
 
-- 
2.47.0


