Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154BC369A1
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web11.59597.1744061444353346701
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d9930r/y;
 spf=pass (domain: konsulko.com, ip: 209.85.166.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d57143ee39so39252725ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061443; x=1744666243; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7NItwXhvilrzp1DYYA0eBkBMCggf1Yo1ytrg+jVHek=;
        b=d9930r/y4tJqD4Kjtu3+/9Xefo7xEyRJ3T+J+5b7jWsIxyA93uqfLOOThSvX1e576Z
         yQSUyEHwwc4tVOdip1puMNwBWZY8zd3lGioZz7AX2wju7cZlfJGBG1ey7KCrou5MjkmU
         3RD87UM2LiLPL04KEE3SXIR3pjg+hcFiOgWGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061443; x=1744666243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7NItwXhvilrzp1DYYA0eBkBMCggf1Yo1ytrg+jVHek=;
        b=QJ/RIqdgZcuf0NYJ9ohAnkpRHXxpuHP0bmhbyocdv1LZkYwqTDXwRH3R20JQ4bz700
         buMwphZr2bqsKzPE/pfc+71TBMbqM8i+qjG+fojhA26x8RUyQNAOq07jxmkjnLoyViqB
         IEuIKdF1IwevFRf/CxErSOnUq6CjporJ2dE6ljFeKl1OAeZPhmzzh6Lg23CbuLY/WsTt
         PQQmWhmEZMUU93SRRyohaPd2Mhq5fR+Wk9iZSEicEIE65VN31YGul6/L6Qe2uPCGTLCp
         OGRg3CIsMHJO+voDagCC9bgyMGblMxOe8/DNTq7KqTVk+UC4YNysZLFu8cyErsmaZHFP
         kXQg==
X-Gm-Message-State: AOJu0YznxJsTqKcP77eRxkFMl3WtMF9yNvwfi5o4RXx9/rQqnCrF294E
	4IZojTqxfefLGiDMIjeJuu69Brw3ypF123ZPurcRpI13b/VfEVF78FG5QxpGxDfb0vFwL7EbXFE
	2Jq4=
X-Gm-Gg: ASbGncupZh7k7rTghOeL9r2RVNfqEd50nGS07Pgzs0powPp/sD+iYc4IQVXOdPzPz+4
	dd9SQRGlovo7Sg7sE3BCCyxlk9znA4miFPx6z6GeNv13/GVZBYrkJ+s30RYcTCn5MlDj8URt2P4
	bpLC22APJqJEpui+ijpe8vg7p7y0QfuZN9WURQ3V3MlzSnc765LHrnM4kl2RjngH0yJp8VKYaYN
	Du0wsPpKFzX/MH1+sgdiGPyZjXmk8DhVyvWrFgdyTeoIHCOI6OMO+EY3tg75C05NmxQ6aUq1xBc
	1NEI06oNdzfY7OcKbZbNd9dGaNdc74TEDR0k4U9O+TIjQvgcwwU5o24C5umtjpUh9QwO8LJaFfc
	rnNgscSia1imEjatPOZNu30gKmUt8Qto=
X-Google-Smtp-Source: AGHT+IHfErMHOEYEeXnrnXos5U3pcVI0Q14siiT+kv4SuoIJJRsZ2giYXxwJTBej20PbGsE7P1j1aA==
X-Received: by 2002:a05:6e02:2199:b0:3d4:244b:db20 with SMTP id e9e14a558f8ab-3d6e3f653acmr157109175ab.16.1744061443318;
        Mon, 07 Apr 2025 14:30:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/29] rust/README-rust.md: fix markdown style issues
Date: Mon,  7 Apr 2025 17:29:55 -0400
Message-ID: <0f7f6548dfbf5c1bdc51b4713e60d63856ce3d71.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1306

From: Igor Opaniuk <igor.opaniuk@foundries.io>

Fix markdown style issues using markdownlint tool [1]:

$ cat ./recipes-devtools/rust/README-rust.md | mdl
(stdin):1: MD002 First header should be a top level header
(stdin):25: MD006 Consider starting bulleted lists at the beginning of the line
(stdin):3: MD009 Trailing spaces
(stdin):11: MD009 Trailing spaces
(stdin):26: MD009 Trailing spaces
(stdin):39: MD012 Multiple consecutive blank lines
(stdin):32: MD032 Lists should be surrounded by blank lines
(stdin):36: MD032 Lists should be surrounded by blank lines

[1] https://github.com/markdownlint/markdownlint
Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 62bade83dd6e021f11e9599a2699a1b202324f0f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/README-rust.md | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/recipes-devtools/rust/README-rust.md b/recipes-devtools/rust/README-rust.md
index 209836a..a7e19c5 100644
--- a/recipes-devtools/rust/README-rust.md
+++ b/recipes-devtools/rust/README-rust.md
@@ -1,14 +1,14 @@
-## Introduction
+# Introduction
 
-This provides the Rust compiler, tools for building packages (cargo), and 
+This provides the Rust compiler, tools for building packages (cargo), and
 a few example projects.
 
 ## Building a rust package
 
 When building a rust package in bitbake, it's usually easiest to build with
 cargo using cargo.bbclass.  If the package already has a Cargo.toml file (most
-rust packages do), then it's especially easy.  Otherwise you should probably
-get the code building in cargo first. 
+rust packages do), then it's especially easy. Otherwise you should probably
+get the code building in cargo first.
 
 Once your package builds in cargo, you can use
 [cargo-bitbake](https://github.com/cardoe/cargo-bitbake) to generate a bitbake
@@ -22,17 +22,19 @@ contained within it
 
 ## Pitfalls
 
- - TARGET_SYS _must_ be different from BUILD_SYS. This is due to the way Rust
- configuration options are tracked for different targets. This is the reason 
- we use the Yocto triples instead of the native Rust triples. See rust-lang/cargo#3349.
+`TARGET_SYS` _must_ be different from `BUILD_SYS`. This is due to the way Rust
+configuration options are tracked for different targets. This is the reason
+we use the Yocto triples instead of the native Rust triples. See
+[Add the ability to provide build flags for the build-script-build #3349](https://github.com/rust-lang/cargo/issues/3349)
 
 ## Dependencies
 
 On the host:
- - Any `-sys` packages your project might need must have RDEPENDs for
- the native library.
+
+* Any `-sys` packages your project might need must have RDEPENDs for
+  the native library.
 
 On the target:
- - Any `-sys` packages your project might need must have RDEPENDs for
- the native library.
 
+* Any `-sys` packages your project might need must have RDEPENDs for
+  the native library.
-- 
2.49.0


