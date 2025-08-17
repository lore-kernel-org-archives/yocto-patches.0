Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A83CA0EE9
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:30:01 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.56802.1755451791809894494
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=o4UlRato;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b10993301fso35494691cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451790; x=1756056590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AegYvPrPhVB5yaCKf9I/GZMFdDFvf8KTpn6KVIZuc1E=;
        b=o4UlRatoDaGb+Yc/6Bh1uUNjxxMSPZd/ov8m3QUEdrfTTkCFyac72yeYvfehf1HfRn
         6OzDfg405yL97lcmnCTrb9U4GtgT5vq2hS6ZPkAudStCHT86N+4w7tguyetFkCHcVudK
         af+o190dx9LpwvE/Y7NUuAMjXJ6yAS5XuzZ28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451790; x=1756056590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AegYvPrPhVB5yaCKf9I/GZMFdDFvf8KTpn6KVIZuc1E=;
        b=UjmOS+aJk3qv/+8mCms0bHB5AfrTrEFQrT7qYHnBBzYf20cGg2kdF2p9myXNF67lPq
         PJNmqAMuUQSPI09qlnAzSKbicP73601AiPKvhITwOufI791zbURkS5yJWusThO7VnpmW
         opoVfLU3patzarO1iV4ROtGP4CRIIbZ35Exh5nhkynM/TbG53BCQcSkpFuaxiYaXa5CF
         Eg0Q1+FUw96AlTylLB5s/QfAkKI0asO7lrzkD4ap8/PgW4Ienleubc409XZLXE6bsumW
         cozW8FQTTKw8Csp+lEmLUvBETfX5VlqX5TWYLmnslFbApCdHx9cjknS34fYp1mnxt226
         c3GA==
X-Gm-Message-State: AOJu0Yxr35kxXyQXJ5iDzR0yf4rQr+h4qI4uAl3GT/0DdZZc+UqZ93hl
	jdpETKrJmHbAXXy4QkT5ZZ2gpnTVLlVdrjsSy+0TTO3GRwNH4uQpXcGwXTBSaD8TR9x2E1AJ6kW
	cGI1C
X-Gm-Gg: ASbGncsCs22hEw15dr+N/0lt99wJxlLH4j0ds5YMZtpxtepkzBPnAq1tfSNFVTl4ziA
	KIVbo3rVpMOLoi+0bfOpiR3/M3HZq6yy1pMUNUlUuM7Ia22Ol/KSb2BugUpb79czwlL5ilzOcds
	L5CbB56Rxwwvfh3t9NHCKlOc55fdSPCvgCEXserq18gDbUzjkDBrmzqrCbuj4qz2E960Ze6mbJV
	oXgYuJ7fIQ4vsEzFv3tiMoBk0AF1TTL8HRE4cxEOqLFhtYYmyh8tqrnGAHATuCkulqQJkO89StP
	7QJ1a7VcHSMaspvITR9+xfy0PkkMpHA4nVlimEE3cgl2LIVZ6qDFXJNH2mpsQsSUHX/er80dNb/
	ungTl4CTee6zCUQYxe4EjqtrzV2+V+VAxfEoIPBPOhJn4T/wfaQCRah6mocytzWb6RZrTKURn3w
	==
X-Google-Smtp-Source: AGHT+IGGDfe+MCeQWMF7nCIqvGISfQMijvDpRZj/FzLPMP3kBcnsz68EFvYQeQELx67D8fc+RPgEkw==
X-Received: by 2002:a05:622a:5c92:b0:4b0:77d4:ec1e with SMTP id d75a77b69052e-4b11e101f48mr110211811cf.3.1755451790406;
        Sun, 17 Aug 2025 10:29:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 6/7] rust: disable executable-no-mangle-strip test on PowerPC due to linker issue
Date: Sun, 17 Aug 2025 13:29:30 -0400
Message-ID: <2c2b8a5f57a80d59a02c5904dd98d2318d781b00.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:30:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2010

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


