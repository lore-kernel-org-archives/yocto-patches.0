Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E562CCA0EF1
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:32:11 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.57181.1755451931289256195
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:32:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=C3RP5FQ/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87035a7c3so494884985a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451930; x=1756056730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AegYvPrPhVB5yaCKf9I/GZMFdDFvf8KTpn6KVIZuc1E=;
        b=C3RP5FQ/9fp/qS0b8bhwXoJ2IDEjadchieZrvjsmBDcVeeNTMrn15guDQ9lKPWG9Kk
         SaCR5vbBAA0IYDdD2gL47DKvbLWdGT+/b6ievG3vHLFw+ru002xpIkV3XAfzgF/y+HDV
         TqTtIQ4aXSi/fejxfX8JrCPI65RGx1G5P3JyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451930; x=1756056730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AegYvPrPhVB5yaCKf9I/GZMFdDFvf8KTpn6KVIZuc1E=;
        b=kbC6WcqckwS+8IzEQD2rl4MYda3k6HrhpabqeLa7QA05JABU1lPX91carV0VmiQVJx
         JPKrnjoOm0pFF1slwxAXKPS1GuAa92e3kaCeyt7Qk2RT1tnCJM7wgGoUsqYObq3y/BMO
         mD3fhpAu7Ot1anig17Vcv92Q/nDSQ04pXFyLFnnqpM18OtvJWpN0YAERselyGXubnrQG
         xbt+cS4F/yN/exIvrDd5icqM2uuF/Ms3hawR+5sc6CN1miTL0ibhwLclO+bIBlr649ul
         rYEqZEHJ7w6l9+Ena3fXyy3ZWNQ//iy9BrcqU3d3I32Gm1WEgpuYIImh0negSMSS7afF
         Hx/g==
X-Gm-Message-State: AOJu0YxlA0wJR/3QDV/QIzwDd+e6UM0M6OC0nTN3n7EavaAG9iIj73i4
	s12mtUJ89ONvYvKfCY+69H7pV22ese3dnHja80tN179br9yvdr/7Gj8YwphiZqs9KlzecPIt76H
	gu+tL
X-Gm-Gg: ASbGnctkV+rXHoCskV/O6wHrKjxAua62a34Ym5XBN+uJQlfqkFO3gm0DsdjkdE41d2M
	59ykeyYg5uG2amyd+OYREh+xzQPN5k2SOe4DsQ6fM10pfb/idQnrquXmUOzd96XPLJrg9EdIcSO
	hahswZO0twz/VVN5Z/heWMKJqKL7prMkWvyj6mOM9VNy1oHKSiUQLBoxvCXgvmfK58f+PlhtEOY
	OoFPvdY2DVN0wDZhS4nD5ykubjYy/7FX91hlMNQTw+VrRbMQUss5s9MysNRcOFSHKkRmVYZJIcj
	cL5G0FOEIWK3PpkN4LGYqXuhh+2AzlUbzg+Ev+rADc0Cf6TsHDQ6j26YK4elMmwGhanDLJcJxyQ
	Cd7fZMCEZcoRw0k1K1yWgjsyg4KeIZWII8ikIG0CfxAue8Zvk0wIS9cJmDHK+ytQj04aDnmyvSA
	==
X-Google-Smtp-Source: AGHT+IHAoJKqghJih1+AfOOSTbBpdh5UIUy+/fmXoRAkxDoLnlZJdZH6NepfM3DwJuQgmWUPpobT3A==
X-Received: by 2002:a05:620a:f0b:b0:7e8:6ecc:34e4 with SMTP id af79cd13be357-7e88673c752mr896751585a.19.1755451929928;
        Sun, 17 Aug 2025 10:32:09 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm450093185a.36.2025.08.17.10.32.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:32:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 7/8] rust: disable executable-no-mangle-strip test on PowerPC due to linker issue
Date: Sun, 17 Aug 2025 13:31:56 -0400
Message-ID: <e758a2e911beab3b2acf09fa66a5ae7ef2d63c47.1755451833.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451833.git.scott.murray@konsulko.com>
References: <cover.1755451833.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:32:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2018

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

The executable-no-mangle-strip test fails on PowerPC target with an undefined
reference error when linking. The linker attempts to resolve this undefined symbol
at link time, causing the test to fail with:
  undefined reference to `THIS_SYMBOL_SHOULD_BE_UNDEFINED'

The test is designed to verify garbage collection behavior of #[no_mangle]
functions and used(compiler)] statics. This appears to be a PowerPC-specific
linker behavior issue.

Temporarily disable this test on PowerPC until the underlying issue is
resolved upstream.

Related upstream issue: https://github.com/rust-lang/rust/issues/144777

Fixes oe-selftest failure:
- tests/ui/linking/executable-no-mangle-strip.rs on powerpc-poky-linux-gnu

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Tested-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 58ccb78de7e87f2f17d8ee47be545de49b8e2450)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch             | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 547807f..61f366d 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -4,6 +4,8 @@ ignore them during rust oe-selftest.
 Upstream-Status: Inappropriate [OE testing specific]
 
 Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+# added executable-no-mangle-strip.rs ignore
+Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
 ---
 diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
 --- a/compiler/rustc_errors/src/markdown/tests/term.rs
@@ -306,3 +308,16 @@ index 42921442e03..af0edc2ee92 100644
  //@ revisions: OPT0 OPT0_S390X
  //@ [OPT0] ignore-s390x
  //@ [OPT0_S390X] only-s390x
+
+diff --git a/tests/ui/linking/executable-no-mangle-strip.rs b/tests/ui/linking/executable-no-mangle-strip.rs
+index cc283dc53..73cbab9c0 100644
+--- a/tests/ui/linking/executable-no-mangle-strip.rs
++++ b/tests/ui/linking/executable-no-mangle-strip.rs
+@@ -1,5 +1,7 @@
+ //@ run-pass
+ //@ ignore-windows-gnu: only statics marked with used can be GC-ed on windows-gnu
++//@ ignore-powerpc: this test is not working on powerpc
++//  bug report: https://github.com/rust-lang/rust/issues/144777
+ 
+ // Regression test for <https://github.com/rust-lang/rust/issues/139744>.
+ // Functions in the binary marked with no_mangle should be GC-ed if they
-- 
2.50.1


