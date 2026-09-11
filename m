Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA4C88E63
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:07 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48463.1789157645529813026
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kTcua+fG;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5306baf6b53so19005141cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157644; x=1789762444; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/RiqF/NnA4Tgjwh93KYnuhV9LlNnUhcnZM1l07LsOCg=;
        b=kTcua+fGUGQz5FA90exV4r/zi5uJhIa1Qscjx9lw8HS5obPV50g23lG77ilY/I0fxA
         zYN0giLP9pQzkw0DQqXFvUJ4Jj+9O6hqbF/xr84hnrMMKAG7S4T/ck4ciq70mRlWFk3j
         bMtXaRwL5ZycAhZmsPwy8wYoVmjtPB3dNANeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157644; x=1789762444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/RiqF/NnA4Tgjwh93KYnuhV9LlNnUhcnZM1l07LsOCg=;
        b=YL/d61o/+Qajf/VLR+G7XesBZ3eKuEYsgYQgPGS/3C5iIBPbd3LHybPmaLDiz5TBwe
         N6owbmZLugQhkzv3fbhG8QKGtCZVoVzHRy4RfKBpIWCmCD7HkFKbMtbzIhkC29hu9qqg
         z7yNMCZrwJWCG0Ks0n4b63lH68viCOiB6+ndgCR3f2FV6V5v7bKvUV6z33uWnDoMZOF3
         hO82VTLgJ68HlMXP9WEs/wbCnCkx+4D9UMkaFUeoK/PXkn7I7Om5qy5tp2hYb2kVkUa7
         slA/eOi31sNYwORGrJEcc87j2Ppv58QgNYLJr77B2jpsXsaNI6wCuqtRUzdq1XT0Dotz
         R8Eg==
X-Gm-Message-State: AFuF++mRWRekZDUlzMgmHk7ozFhTuIK2qqols3FIcmt/LT2Xm0fsIXSD
	CTFgL61lCVzZz3ooMZUwEfOoUn2L7oHj56SrKQxUlc262pLwa7+qEdPJzwGcWzbCQO8UaS0AYQd
	sRM/2
X-Gm-Gg: AYBFou0qfp1qjl18CPwqgBs2sYzIARJ93qzQkyg+kq5hIPIRLHleF/3ujrVlVAgbCoz
	31A5+JyDhw75Tfx/KQQ+NIijqGPyGuH16899UVhAtXEGi6xxAvS3ucDSrLJeStNUsiXWoeWk1e6
	1N5YTnlgulgdivNEtOmSFpJXlK1TxwJNH40SZl2mC6yo6sPrqqr0iYYXxovDpEQUwSJOb7XulLi
	dLaMD+g56XokoFPcddmmjyD7YGZnKpQWvNn1G9+6RwBiJ0ghqvD68tBKyf2ziWRargukBzkcF3P
	BULQE3E5x1VezW9IcoQgzAqD9iTy4B1sTnj3tSIRD5TgTYsPnGbVwrdN1Jb8FLrLvzlRSbPsJxL
	qQmjH5D3XRRPg6VDf4JMhe5/bvb5h4+d3RJIb5fZlAY3PgL97Fn1jnSSEZwPhN6jNdnpul4mkPm
	RUCCqdvE6nQIWvooG7Q0BIcpeng8pKvOeh1umyD6QDecFuLuz4yXjgGnugibrgFPYJr9On8HjiX
	iKdQ2jh2mMyTcSgjwOceNTHZOezRFwOYm5dfIzgyCpcqYdyTWpRFOAHi2tknpOeaUHqFO9eCTeo
	usEeTTeUOecHonoaYKMl9WDQp4PQohvO7HY=
X-Received: by 2002:a05:622a:4114:b0:530:da2a:757 with SMTP id d75a77b69052e-530da2a1198mr45361591cf.33.1789157644268;
        Fri, 11 Sep 2026 13:14:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 27/37] rust: patch uninative loader into snapshot's self-contained lld
Date: Fri, 11 Sep 2026 16:13:13 -0400
Message-ID: <38ac6945a437a41aea3f5281e4823776ce071d5b.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4793

From: Markus Volk <f_l_k@t-online.de>

Since Rust 1.90, rustc defaults to using the self-contained lld
linker (lib/rustlib/<triple>/bin/gcc-ld/ld.lld, which execs
rust-lld) on x86_64-unknown-linux-gnu.

https://blog.rust-lang.org/2025/09/01/rust-lld-on-1.90.0-stable/

This applies to the snapshot compiler used to bootstrap the target
rustc, before the rust.lld/use-lld settings in the config.toml we
generate for the target compiler can take effect. Without patching
these too, they fail to exec on build hosts without a /lib64
compatibility path.

collect2: fatal error: posix_spawnp: No such file or directory
|           compilation terminated.
|
|
| error: linking with
`/home/flk/bitbake/bitbake-builds/master/build/tmp/work/x86_64-linux/rust-native/1.96.1/wrapper/target-rust-ccld`
failed: exit status: 1

Signed-off-by: Markus Volk <f_l_k@t-online.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9db020032ee1f328bfab7ca7842d7725777e487e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.96.1.bb | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.96.1.bb b/recipes-devtools/rust/rust_1.96.1.bb
index 581523a..a6374f9 100644
--- a/recipes-devtools/rust/rust_1.96.1.bb
+++ b/recipes-devtools/rust/rust_1.96.1.bb
@@ -66,8 +66,12 @@ do_rust_setup_snapshot () {
     # Need to use uninative's loader if enabled/present since the library paths
     # are used internally by rust and result in symbol mismatches if we don't
     if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
-        for bin in cargo rustc rustdoc; do
-            patchelf ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
+        for bin in ${WORKDIR}/rust-snapshot/bin/cargo \
+                   ${WORKDIR}/rust-snapshot/bin/rustc \
+                   ${WORKDIR}/rust-snapshot/bin/rustdoc \
+                   ${WORKDIR}/rust-snapshot/lib/rustlib/*/bin/rust-lld \
+                   ${WORKDIR}/rust-snapshot/lib/rustlib/*/bin/gcc-ld/*; do
+            [ -f "$bin" ] && patchelf "$bin" --set-interpreter ${UNINATIVE_LOADER}
         done
     fi
 }
-- 
2.55.0


