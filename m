Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F98C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:57 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.1806.1739301472497264764
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IQXi/ri1;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05c2dc5ddso274208685a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301471; x=1739906271; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fCoBPwwoMqhzd26qNC0NELYBdVQKbaYXfdyZ0XSnuU=;
        b=IQXi/ri1br77/wybKbQ+PLXxf4u0l6/MQ3xNV+KxRXv2XjCb4blhmSvQ5wEZlI80Z8
         lCuinrYYS4/RDKaRK/4NPvRCril6cvY9wzKF1NDDkonsxp9HNlX4BvGqZIm4SQBv+/zb
         /eRuk0DyDq7NxfYgQDiiOH7Gz9dLvdQnmRYNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301471; x=1739906271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fCoBPwwoMqhzd26qNC0NELYBdVQKbaYXfdyZ0XSnuU=;
        b=I/2xCckSrBL0Ga/zZNt2W4bMYZ/aOQCcvVNzMT3ihYcPKVUfd3prRyPCJsprcCUe1L
         HyQpjNWm+Khtps/WZKTpm3YfKzGRa0GIqXl0aENrYAhU7uJtl5CEXQENv3mkZU0/FIwS
         4719vnYJ5ON2G1dqoEulF/WD090N/A402boYpEpby5GAcZlK42CiaS68lz/7Gq7wrJkX
         Fwh49Er3wbb1EpATwaOCDHyBeQrkce8SUKteZSxa45i9PkuGZGIS5Miiaejikzodpr6O
         +BAqS7hyyosldo0UHKSq0yznVrYvQ1+RQDspbaEb5k/Srm1V99mnsvrB29lOd/ITuX21
         1pgA==
X-Gm-Message-State: AOJu0YxWRdk3CXGMNggigR6Of60vLr+sSeC9dFn0u6kYTx70Nv9fPd6E
	m8KegYgG0o/oNnnl31/joE0TCl9FdAj4FYEGME6dxHxUAsas68oLPn2PZIAzEN1PNt2aeocL/Me
	F
X-Gm-Gg: ASbGncvNDqmXBd2kIl/UbQobL1IO79iad3M3o6I8Ig17MsnWxODQrW/rYji0vIR++P9
	RJ76exGe/KgUSNW9AjSs+dRYDIgrHzRyc8uBE/TY1XwefqMARTUjYGbb1b7+R5/8eTLsKtsfpf3
	QHKSSyTmNJgwPrOmu6Y12bIpSDmLLTonUL5k5cfB4jdZm7g79HcQBoGiqL8ZUMSvuLNXcwPwXPE
	z2tRHx3aZCyJr4vhx3jOiA4HTCHHeBUbsBtRuNOm/NjQNMOOEneiq+R/ET6N+hKAy1Lp5Gghlkj
	OL3mhF+fmG31YIfGOgtEAMPjKYdQiMaJSU3mSSyckS+WuuNVtzdvPv+8w5Dqw6ta6vY=
X-Google-Smtp-Source: AGHT+IEuaCAgdHqQDYsMY5fyZIrD67uyy4HO8rTPUpRHSC5P3wgieBnXGfqtXGHX5LnF/4IL80i0aQ==
X-Received: by 2002:a05:620a:440f:b0:7bd:bafc:32a0 with SMTP id af79cd13be357-7c07071cdc3mr21417185a.23.1739301471366;
        Tue, 11 Feb 2025 11:17:51 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:50 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/10] rust-common: add LDFLAGS to 'build-rust-cc' wrapper
Date: Tue, 11 Feb 2025 14:17:22 -0500
Message-ID: <81a18087995ffc3cbc00c6a45227f9e4fe30259d.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1075

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

Although rust differs between compiling (--> 'rust-cc' wrapper) and
linking (--> 'rust-ccld' wrapper), some core crates are using only the
'rust-cc' wrapper to check for available compiler options [1] and
libraries [2].

Not having LDFLAGS can break the build in subtle ways.  E.g. 'cargo-native'
can fail to build with

|   = note: .../hosttools/ld: .../liblibz_sys-....rlib(deflate.o):
|     relocation R_X86_64_32S against hidden symbol `_length_code' can not be used when making a PIE object

because it does not find '-lz' (added by "DEPENDS = zlib") and builds
a static libz.a with missing PIC flags.

Add LDFLAGS to the 'build-rust-cc' wrapper as it is done already for
the target one.

[1] https://github.com/rust-lang/cc-rs/pull/1322

[2] https://github.com/rust-lang/libz-sys/blob/12a32798c6bd18986cb5cd603359b03c96f0eb4c/build.rs#L228-L234

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 classes/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-common.bbclass b/classes/rust-common.bbclass
index 6b44f3d..910d6ad 100644
--- a/classes/rust-common.bbclass
+++ b/classes/rust-common.bbclass
@@ -173,7 +173,7 @@ do_rust_create_wrappers () {
 	mkdir -p "${WRAPPER_DIR}"
 
 	# Yocto Build / Rust Host C compiler
-	create_wrapper_rust "${RUST_BUILD_CC}" "" "${CRATE_CC_FLAGS}" "${BUILD_CC}"
+	create_wrapper_rust "${RUST_BUILD_CC}" "" "${CRATE_CC_FLAGS}" "${BUILD_CC}" "${BUILD_LDFLAGS}"
 	# Yocto Build / Rust Host C++ compiler
 	create_wrapper_rust "${RUST_BUILD_CXX}" "" "${CRATE_CC_FLAGS}" "${BUILD_CXX}"
 	# Yocto Build / Rust Host linker
-- 
2.48.1


