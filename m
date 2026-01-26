Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37589D19533
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35791.1769471710275909156
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=p0iTvhq1;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502b0aa36feso63808801cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471709; x=1770076509; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd9ihi8QTU+mjcQxjisZT6wmPRuZ4kHl02cfC5dkI24=;
        b=p0iTvhq1LG+P0/e5GUxMEaKAgjLFaXw2pCM78c+TzQiwTX7tH2+/J8WbARbaBk8vjv
         c8ViqR2i/tGhFd89xI6jkYcBu1pri1VvGO7Pbeq+IuP17P8Ve1yXvw9olKvDdrGoo9Me
         LodrnrposDZhmksEAak4x25i4sfnAnUP8cphk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471709; x=1770076509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gd9ihi8QTU+mjcQxjisZT6wmPRuZ4kHl02cfC5dkI24=;
        b=ZBlO1V+0mZOjYJV/4hRLw8hmEhWO0/hX6ll+snYUunqSEwPW2aNi/mbzuSk58pqVgl
         IERMl6DqNpqgfcCP6JavsoQMcoZ9eiLA7lxRlF8EixPY9dWrmyCLIKfbCGeh9N2Bkb27
         HgJBYU71uMb+CBT9IjhYeEpQFGEa58bBUH9h4C/33/qcTUYbu8R1uls/gISw+N9DCVLd
         lGYD2qdJ87EOy+DLQeMawXvlFLY/Yh2v0MWm26jhRyFNGK6dkgkiixxVbqnCE4ZwuyO/
         2jaZrsq/iy4hzg5tO+c43GQiFNiIVuKc8Iu1Ve+Q2KjM6FbQn4eqHWgDBWyocWoFPnZz
         jDOQ==
X-Gm-Message-State: AOJu0YwUObH1mNlefWkO31FqYQra2Wxy956b3Xv4XYufnJaU30vAfWbs
	KlPO53oaSG3fphHGed71c49ce1L/fnZUxaEIRkODCrZNd9L3wr4GHVTLIGS+G6GfkoPX6UmD/0V
	NkRKpQ6Y=
X-Gm-Gg: AZuq6aKjBdqAp7OUqnyt+oH4A5NzotzqMT4a9fH3o0yWrn8L//4WswCVU7o8eEpinbS
	6Ihs98CaB39CI6lMfNdE/YcapHn0ObcWAEfCYD+JR4Qs7rYMs0YsvS4I6esVtE7DmLvKP8UzUpY
	Cnksj7ZOtloHXPqPW2FbefBaL38mIHfGpfSRH8VQeEjS2m7KzVf+q7vW/NpLOjDo+V6xy3ibkNP
	eYFh4Tgg7M58bfw+Rhv4nnME7CS7pEfTnWqYwqWnP0Z8z4HWVX2LX3whUf0fbQvPXS8H5lTHNfn
	ZGzaKL+beN0zzFLBKZ/0Y1uVJeMPTrErqyQo1s7F8rxPJhK6kvfezHbt0gRYe9ZLTAZYuwsF7eQ
	z8FahUaKESE00Fyn2jbnjTJkr4OepPFfEJxv3sIEZi4JfsJ0BRs+upyvFKlMw/wtiDuzLc7LdFQ
	mrZIqMzHyd0601/KI18fA9HKgmCx2iv+AnPKWd1C42c4J0DaH6h7K2+oKwavJ/nR0Jd71Uf0biP
	JQMNRDMvKn/mSYScftPwNW0yKDbQeAWl6Ak/8I07h5Vx53zig8U
X-Received: by 2002:a05:622a:1102:b0:501:4b9d:ad19 with SMTP id d75a77b69052e-50314c598ffmr80031391cf.22.1769471708927;
        Mon, 26 Jan 2026 15:55:08 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:08 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/10] rust: enable default uwtable and ignore arm no_std test
Date: Mon, 26 Jan 2026 18:54:54 -0500
Message-ID: <3d237ea3ec022bf7dfe2fe29ca77d72ad5a72182.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3110

From: Hemanth Kumar M D <hemanth.250302@gmail.com>

Rust 1.92.0 adds new test that require unwind table support to be
enabled by default. Set `default-uwtable = true` in the generated
target spec to match upstream behavior.

ref:https://github.com/rust-lang/rust/commit/fe66eaa67acc47525db6f13cf97d54780d87b805

Also ignore the no_std simple-runs UI test on ARM targets. The test
fails with panic=abort due to a known unwind table issue on 32-bit ARM

https://github.com/rust-lang/rust/issues/146996

Signed-off-by: Hemanth Kumar M D <hemanth.250302@gmail.com>
Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f38b4e8b35d6ce2dba9c1f933e3b22b22c065574)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass                 |  1 +
 recipes-devtools/rust/files/rust-oe-selftest.patch | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 0c6fc95..4fa8a85 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -401,6 +401,7 @@ def rust_gen_target(d, thing, wd, arch):
         tspec['llvm-floatabi'] = "soft"
     elif fpu == "hard":
         tspec['llvm-floatabi'] = "hard"
+    tspec['default-uwtable'] = True
     tspec['dynamic-linking'] = True
     tspec['executables'] = True
     tspec['linker-is-gnu'] = True
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index b39b326..d1fba81 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -254,3 +254,15 @@ index a3562f2fd93..d4e52ed91be 100644
      fn linux_hwcap2_aarch64() {
          let file =
              concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/linux-hwcap2-aarch64.auxv");
+diff --git a/tests/ui/no_std/simple-runs.rs b/tests/ui/no_std/simple-runs.rs
+index af44dfe..e6674e5 100644
+--- a/tests/ui/no_std/simple-runs.rs
++++ b/tests/ui/no_std/simple-runs.rs
+@@ -2,6 +2,7 @@
+ 
+ //@ run-pass
+ //@ compile-flags: -Cpanic=abort
++//@ ignore-arm FIXME(#146996)
+ //@ ignore-wasm different `main` convention
+ 
+ #![feature(lang_items)]
-- 
2.51.0


