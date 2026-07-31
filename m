Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D7C55183
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4470.1785497607334328940
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JVl+CQY7;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50a650a0so43700885a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497606; x=1786102406; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wXH7sUaES3niRQjhgq3DR33OsZ9DkvW5nDf0aSghi08=;
        b=JVl+CQY7AMgL6ikXHE39vR/4BYtdIt93KlE8yRWz++hcHxT43LPyKZA0O9Gfuv5I97
         JZCUyII07zZyoOqVmahijDsJkM7EGs/6lkumhq1X9VXmhES9uP+0iMOsXf+lpCkKqvTb
         43Qc2RucRFtaumWGBYDPDFRkb3wCE4JhllTYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497606; x=1786102406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wXH7sUaES3niRQjhgq3DR33OsZ9DkvW5nDf0aSghi08=;
        b=Tyo/5iTZc6z/7t3Yw41+WSQG73ebUCl00UMsHrrD8T+zx8oqZMw8PQaA07cId/f2xM
         PoBRS77PwEWe97jPRGPmrSANLlHPfC8z12vLG1ue2g0mxNIyq/TZaPXwlnDN1iEGrQsc
         Tkyg5ON9XDP1zSkU+L99akdM+93/Bb3Ic2tRf0DDQEcs+1CB7r0V+VYSUN0PA+pV/5eC
         bFpkNoSxo0uehJ0B2mhMsYsqoPmk4P4UiKAE2qk2iRk4Gw0oJBSYUCQtUPdox7ZLPVS5
         wK6wnOwB7Jrez0CEJ+8KxstUd99XT+RQHcql6IY6a1cxD7GpzsTDavuZeKoobgy3iyfZ
         tSPA==
X-Gm-Message-State: AOJu0YyHR0rFYEzvZ6TwGbGj7jsEji2rCvukLL8/YcFilJfxzJWhMtRA
	WGhSDc2k9wSBzBfngaOR+edIgTjbbnDf614JXazKjxess9XPbPLIz9PdvewWZAnKgzLcceV7wYJ
	QoHOT
X-Gm-Gg: AR+sD126Z0nMsICazihYaU0w/Ri1mE2y5Nj2CPIc0xca48ZjwdCJZmtO++hlDK9qWeR
	hNRk0WHiqbvejaFaOUq22+R9zDKtTP6NqPbHKYkRZVif7RVBJ4OupyAa6/qvRa4rYsISr0tQvir
	O9cOvnP1BX+aa3izB3DxgjNE1q50lPZDJJ0iH2XCbYstIv5F2Ugflrjfs7RhYdqQS9AI6ZJLsLB
	XB2SUDg66jHUFyQbOqDfxYf3/HiS5/Xeo04DQXzazRm9Tk6Y3B/TXzZ8EdZAYZIOspVnzRYxopx
	0DPbwuKeeLWHDkyJKPCTyKcGvc28oGBFvx6yKjvPotRAmh9jacHEP/Q+/3bc5Fa7UNPWCIMA6Lc
	ahv1z70OemjzDv3lOWHvZbaZymSR6NqSFEWBoartTowAIhcEthj6MVKct827wex+JdL75wBkT38
	6dSoUukKFPuZ/rduv+RTLGyo7C0ucd4xOkruYUGKYFlFqDfHB0pEQFN7LqMuHyxo8q52iYRi1ZW
	skDrYFP6wwCZC3lXXcwCTH3/xl00vnB25b4d7a6VJB8qGa84+x+GZdqP9STHVK4g29taR1lyzmI
	6Nk6j2VM5zm9TWZJxN0MmMD3nQ==
X-Received: by 2002:a05:620a:a1c8:b0:915:e670:4021 with SMTP id af79cd13be357-93497c4f067mr153670685a.45.1785497606099;
        Fri, 31 Jul 2026 04:33:26 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:25 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/35] rust: Fix flaky assertions in oneshot tests
Date: Fri, 31 Jul 2026 07:32:41 -0400
Message-ID: <64b972909b93bcee722046d1f8d4ba1e3398d116.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4587

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Fixes [YOCTO #16199]

Backport three commits from upstream to fix flaky assertions in oneshot tests

https://github.com/rust-lang/rust/commit/6970849fee93900b6eb28a64cf957157a9fb51b3
https://github.com/rust-lang/rust/commit/dab350a3ed7691201f6752c4375e8e6ab40b58b9
https://github.com/rust-lang/rust/commit/d02743e2fd7433ba2320fc85421a8a5927235b65

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 636ea9269c1d7ebabefb3bed01fd30583758cc8c)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ix-flaky-assertions-in-oneshot-tests.patch | 72 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch

diff --git a/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch b/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
new file mode 100644
index 0000000..be0e85d
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
@@ -0,0 +1,72 @@
+Backport three commits from upstream to fix flaky assertions in oneshot tests
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/6970849fee93900b6eb28a64cf957157a9fb51b3]
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/dab350a3ed7691201f6752c4375e8e6ab40b58b9]
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/d02743e2fd7433ba2320fc85421a8a5927235b65]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+
+diff --git a/library/std/tests/sync/oneshot.rs b/library/std/tests/sync/oneshot.rs
+index 6a87c72..d8f3cd7 100644
+--- a/library/std/tests/sync/oneshot.rs
++++ b/library/std/tests/sync/oneshot.rs
+@@ -89,15 +89,15 @@ fn send_before_recv_timeout() {
+ 
+     assert!(sender.send(22i128).is_ok());
+ 
+-    let start = Instant::now();
+-
+     let timeout = Duration::from_secs(1);
+     match receiver.recv_timeout(timeout) {
+         Ok(22) => {}
+         _ => panic!("expected Ok(22)"),
+     }
+ 
+-    assert!(start.elapsed() < timeout);
++    // FIXME(#152648): There previously was a timing assertion here.
++    // This was removed, because under load there's no guarantee that the main thread is
++    // scheduled and run before `timeout` expires
+ }
+ 
+ #[test]
+@@ -127,6 +127,7 @@ fn recv_before_send() {
+ }
+ 
+ #[test]
++#[ignore = "Inherently flaky and has caused several CI failures"]
+ fn recv_timeout_before_send() {
+     let (sender, receiver) = oneshot::channel();
+ 
+@@ -135,6 +136,8 @@ fn recv_timeout_before_send() {
+         sender.send(99u128).unwrap();
+     });
+ 
++    // FIXME(#152145): Under load, there's no guarantee that thread `t` has
++    // ever been scheduled and run before this timeout expires.
+     match receiver.recv_timeout(Duration::from_secs(1)) {
+         Ok(99) => {}
+         _ => panic!("expected Ok(99)"),
+@@ -240,7 +243,9 @@ fn recv_deadline_passed() {
+     }
+ 
+     assert!(start.elapsed() >= timeout);
+-    assert!(start.elapsed() < timeout * 3);
++    // FIXME(#152878): An upper-bound assertion on the elapsed time was removed,
++    // because CI runners can starve individual threads for a surprisingly long
++    // time, leading to flaky failures.
+ }
+ 
+ #[test]
+@@ -253,8 +258,11 @@ fn recv_time_passed() {
+         Err(RecvTimeoutError::Timeout(_)) => {}
+         _ => panic!("expected timeout error"),
+     }
++
+     assert!(start.elapsed() >= timeout);
+-    assert!(start.elapsed() < timeout * 3);
++    // FIXME(#152878): An upper-bound assertion on the elapsed time was removed,
++    // because CI runners can starve individual threads for a surprisingly long
++    // time, leading to flaky failures.
+ }
+ 
+ #[test]
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 8887824..b9077c3 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,6 +7,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
+            file://0001-Fix-flaky-assertions-in-oneshot-tests.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600"
 
-- 
2.55.0


