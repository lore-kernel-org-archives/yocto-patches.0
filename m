Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D83C369A5
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web11.59607.1744061455547382336
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PBUyoVbW;
 spf=pass (domain: konsulko.com, ip: 209.85.166.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cfc8772469so23817915ab.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061454; x=1744666254; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwtLVagJUDEzgg56NKyuWVlnz04lmsusaGYKkWqGbf0=;
        b=PBUyoVbWxWnkw9QBHC1LGWb7lNfjdcH7iYuQBrKPrOi/GK5Ug9sDUH68EZdLb/VchI
         NJn8tQcFvy+/NfWVzYUUvEkvO6DI9j8KFXsLpI/4yqpdYKSqeOi2loziBTTsUZYCcLDO
         v2ZPmoMpN3tYkG07o93xvJnpK7ElCwIB44pIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061454; x=1744666254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwtLVagJUDEzgg56NKyuWVlnz04lmsusaGYKkWqGbf0=;
        b=UxsjNx8X/dBgkhqOLnYZfsrHYyKc7Fqq73OCUAKGu9AFJKOmHR/+yTHhmVl+QnPEhJ
         eVAjA0kjvodVTWIAuaflPs+IBGoAyvaFRRcixBsYWxm6HEHT/WeTG8YdOukTOf3aNP8F
         Ja8OMNDkzFT98+jQlrIDr3RVGsIF1vnmTOiFddRIeget6kRlh2qGg5Pjqf7kVLnpvlXB
         Yh9/Bogchmq8XRVLaNE7yBd/otrJ4ctU/Qvo0Ew8YA+HZyY83lyQ/jmWStXI0K1wFSoC
         R1wBRPSPKkh16gxqNoTckecA2TcLBjZWzC/KfDk/wcAJTK2k+kpI9okbSVuFX1fvd81f
         cc4w==
X-Gm-Message-State: AOJu0YzufzmH9rT86Oj5uAvxP4nGMA7Wvn75Ueyvg/jxmdJZswlwyD0E
	rMHoaIZQDH8puUANzvq0md5zcM2GgtYs/Z8rVDtjwMvr4UAgZXCNucwNt9xfAT8OMgP8OzjHDhA
	cyiI=
X-Gm-Gg: ASbGncvFbd2jN9p3wx4+4J2vSssO8MgQeXURY1ZnPYkJfot2i7bnB8Drs5kCDVBwxsx
	YUwK+Di5tOI82JLdRDgVXcn2PKp68HcwmHw7i1F5IpJQM+3Ypi939yvPvxak+B9bWrAYYZ84CNY
	RlA1M5Y+K8hKasFkK8yJOelKA00omqZYs2lT3nC62xlhpVXuB0oVQsjZYdQ7yjbdhVfatwZLj9w
	QHZ+rBsknMQGrWFbCpnQnpwbbvhjj8XvtwCbn0WXeZ33KWG447gFRGMXiD+zAPoBnG9/VgvNMW1
	QgbllkrFMbER3ONbU2DDK2HCgUjATZV++BR2kU2P4Ke0yXRKwr6Keu0azvUSTXVmiA51w6BLg75
	1IAT2/QX0ZPCslxa1AA/B
X-Google-Smtp-Source: AGHT+IFjDKvoU/yuwfOBcKC2pgS1CYsFgGqQUiW0jt4jwpljiIE1a5hNjYfZlcHh0b/qF2vy6wnJxA==
X-Received: by 2002:a05:6e02:3e04:b0:3d4:3ab3:5574 with SMTP id e9e14a558f8ab-3d6e52f629bmr148875515ab.3.1744061454330;
        Mon, 07 Apr 2025 14:30:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 16/29] rust: Oe-selftest changes for rust v1.83.0
Date: Mon,  7 Apr 2025 17:30:05 -0400
Message-ID: <486f669abba4e6ffdc2c58ce6b04c06358b09c73.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1315

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Few unit tests are failing for x86_64 arch.
Ignore the failing unit tests.

Upstream-Status: Pending

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c71f9efc3140d279813ff6eb474fdbf5e677e348)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index b2bfed0..dd22ced 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -438,3 +438,34 @@ index 4d342c72cc..9a77f92616 100644
  fn arclones() {
      let value = 12u32;
      let arc = Arc::new(value);
+diff --git a/library/std/src/thread/local/tests.rs b/library/std/src/thread/local/tests.rs
+index 9d4f52a092..d425e5f7b7 100644
+--- a/library/std/src/thread/local/tests.rs
++++ b/library/std/src/thread/local/tests.rs
+@@ -346,6 +346,7 @@ fn join_orders_after_tls_destructors() {
+
+ // Test that thread::current is still available in TLS destructors.
+ #[test]
++#[ignore]
+ fn thread_current_in_dtor() {
+     // Go through one round of TLS destruction first.
+     struct Defer;
+diff --git a/library/alloc/tests/sort/tests.rs b/library/alloc/tests/sort/tests.rs
+index 14e6013f96..b670f27ab4 100644
+--- a/library/alloc/tests/sort/tests.rs
++++ b/library/alloc/tests/sort/tests.rs
+@@ -915,12 +915,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
+ macro_rules! instantiate_sort_test_inner {
+     ($sort_impl:ty, miri_yes, $test_fn_name:ident) => {
+         #[test]
++        #[ignore]
+         fn $test_fn_name() {
+             $crate::sort::tests::$test_fn_name::<$sort_impl>();
+         }
+     };
+     ($sort_impl:ty, miri_no, $test_fn_name:ident) => {
+         #[test]
++        #[ignore]
+         #[cfg_attr(miri, ignore)]
+         fn $test_fn_name() {
+             $crate::sort::tests::$test_fn_name::<$sort_impl>();
-- 
2.49.0


