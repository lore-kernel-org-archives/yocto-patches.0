Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1716C55181
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4469.1785497604993844526
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=puj0c9WP;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92f0b5ed131so63836885a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497604; x=1786102404; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bhcCyVN5h0VEhNff2PJbvwb2BqMsDnHCvIgYbgvGd18=;
        b=puj0c9WPPUqSyccmiBxlNh5w7Qy99PMNNYojg79sM2JeZs8ykfX3XGtEF3fcW03VEv
         oY8EIOAAAhqtm+bIwS5of2+JHsZ+Nn5I50uOGY70/oB048oubbBWT3ShLbDK5HUwLB2x
         EzHeHI1FRoDo8S0wAmWW0WbnsixdXOzJhp8r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497604; x=1786102404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bhcCyVN5h0VEhNff2PJbvwb2BqMsDnHCvIgYbgvGd18=;
        b=fEWnw+70En/jO6r6Ldlbhyjp4A7FlNFZonwsV+dtwaDXyw28po5RfUNW5WgcYivqRW
         0WT7TgIjEV1qT164eNxYoaP/1huicWjQ5qjhRld2DoqtxeEMC3SwdlDHeOz6UOtaeDkv
         ahJi4op7mwupEQChW/J+WTl38JrQq8xsLAiapZB0KWu57OFV57hig9+Iox/5ZdlMbihM
         0tmKaW7ldqwaGTvSL9YTPZImPZbNZorKxxEQN2VdSvG/J2nXkqR23ydL9A2aHcUFuwDQ
         fbgsAqjJX1plgt4OZYB2TFzkVf874lJV+DRmnWDr9WkrO48C5PZMj58ARDJxGEFT+0iI
         m7QA==
X-Gm-Message-State: AOJu0YxmYn/wed7/Zxf4FIPRZRtpeW2NHH6EnvVXH80V6otaZLlDSZC0
	+xgiFxln/gwhyrUWuDgZlKssUeHxeFV+KAGeh2GmIkZtfMDwkx30B2G5t2bAq6ODM1j4JQxkXH6
	7K7tr
X-Gm-Gg: AR+sD110nS8LhZ6sFxT1H9BOamfw2gqDhKb8aqSVWUtfWh1wvOGUgxTfQccgv2R6mz0
	VrmfGDTXHEDHXL3qtmhobyYKDTcXGpSOCeixG6rv8hk56a/o7N0zOwShZP2oaa5Jhu7OuGIHc/p
	22fY8XmF0FuDoAB+UD6jg2UmaOPxnkr/RR2bwSmQ7fWf5Sp2wU/I9XfIyDZ22HmpoqSWGH+4Xih
	s9QcAUBKI6gLc4dUI4O3n/ONbAv22uzDIXuVO8Ur3fuviYjrTZVNpEUdAzI3vyWug+CK5CzLBId
	pxRzMFqtG1s90TrW3CTB8X5VjmdVo+ZSUnj9gY1+nB4cgonzHTNbUWtPRvFrAZAPRFTilH/9MD1
	+twGzAGsA/3Xm87AKMH2+dNEB4EHO2kFx+uzfdYBM9WqxZEVIJfW0Xb2PfkN4B4FO9buxpik5oF
	vOxM5dQyhbTailX7npboSCE7YvkKYv2TRQXpfbu/ixatvzerPxhSSZvH0HL4GpFg/tWLnEWvk17
	+wRimIRrFrIN4/C8wE5uyQ+trASgWCBea1gmGXH2IRdSWkBuwNGZosXLhvdWC/PQqy8Hi0TyyMA
	8KLS+4qZrWU3Sehf9WiAjaCpRg==
X-Received: by 2002:a05:620a:2b8f:b0:930:f9a6:11ae with SMTP id af79cd13be357-934965b4622mr188552385a.17.1785497603748;
        Fri, 31 Jul 2026 04:33:23 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:23 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/35] rust: Drop oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
Date: Fri, 31 Jul 2026 07:32:38 -0400
Message-ID: <1918e0c1013438f8735a82a95df85121df442fb3.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4584

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

This patch was originally introduced to address a rare failure on the PPC
target and with the latest version of rustc this issue no longer occurs.
So, this patch can be removed.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3b5c2d8bdbcaa6f01af43bb04fe93790b04100a2)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...crease-timeout-in-process-sigpipe-ru.patch | 31 -------------------
 recipes-devtools/rust/rust-source.inc         |  1 -
 2 files changed, 32 deletions(-)
 delete mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch

diff --git a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
deleted file mode 100644
index 5bd1abf..0000000
--- a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From b4524278985f517b0785b6f64a21380dcf1ff096 Mon Sep 17 00:00:00 2001
-From: Peter Tatrai <peter.tatrai.ext@siemens.com>
-Date: Mon, 4 Nov 2024 13:58:16 +0100
-Subject: [PATCH] oeqa/selftest: Increase timeout in process-sigpipe rust test
-
-This patch increases the timeout for the process-sigpipe rust test, which
-occasionally fails when the server is under heavy load. Increasing the timeout
-reduces the likelihood of false negatives under load.
-
-Fixes [YOCTO #15625]
-
-Upstream-Status: Inappropriate [OE testing specific]
-
-Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
----
- tests/ui/process/process-sigpipe.rs | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/tests/ui/process/process-sigpipe.rs b/tests/ui/process/process-sigpipe.rs
-index 11f363d62..c12d66016 100644
---- a/tests/ui/process/process-sigpipe.rs
-+++ b/tests/ui/process/process-sigpipe.rs
-@@ -23,7 +23,7 @@ use std::thread;
- fn main() {
-     // Just in case `yes` or `while-echo` doesn't check for EPIPE...
-     thread::spawn(|| {
--        thread::sleep_ms(5000);
-+        thread::sleep_ms(50000);
-         process::exit(1);
-     });
-     // QNX Neutrino does not have `yes`. Therefore, use `while-echo` for `nto`
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index a5423d0..8887824 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -4,7 +4,6 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch;patchdir=${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
-            file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
-- 
2.55.0


