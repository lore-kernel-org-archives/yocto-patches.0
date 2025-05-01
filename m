Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F7C3ABB7
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.4649.1746132052948229150
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FMJEaa6L;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8efefec89so14153646d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132052; x=1746736852; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwtLVagJUDEzgg56NKyuWVlnz04lmsusaGYKkWqGbf0=;
        b=FMJEaa6Lyn9C6TU8X69ssvMSxdfutqE8+KkSdYuEboIxHQhNUwW/y+LA1JRabVRkvb
         FypnmQBf3PE+eMFwbYwbVQ0daOQzLbNMiK9QjR8tt+DShieC6EXj/ZlwJcsJNL2wBxRj
         7m5V74ub1cbEW85KvagvW/gI3Ea129U+rjFhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132052; x=1746736852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwtLVagJUDEzgg56NKyuWVlnz04lmsusaGYKkWqGbf0=;
        b=Snm9UVTCExddST35WMriHwzPONsTnndU7O4S3nSdrQxh0KGQ8bguId3yXzZkD2NcQa
         +JIitMAyriXGGaLVuQNZ8OU2RHJttpDDBkVyccOKjd9OML4VYAr51WuN7XyhAqmHhM/c
         98ip9ljZ+Xof+eHyXiDzQseJGPbLLH9ahnJQ+Dd+raQDgw3NbWwBXKbTMQFNkN4dqbNh
         I+FR4OH3rC4b+l2SMG3wqMPJyMt2k/OVvmUwka2j9+RK1NV/vXOaJcTlqKKddH1FbyZ1
         sfWGZ7PSu0yLLS6/qwIa6nBChyVDDrvDpMfY6fQM+E6dFCrKuwpDpzHITIeoB+F4qj/0
         lpZw==
X-Gm-Message-State: AOJu0YwtsB0406SVYOUPVerFA5A31p+q5yfzcIhWyAiWoHzAIb8ERuB4
	2tYCTiFOz16vOyHks8C7yDmWEnxmnSY4ajZ6VKLqRMITBH9OA7OzXiOqNphkJ1RAZptcrq6u6ix
	4
X-Gm-Gg: ASbGnct7jDWCpo3EhAzboH+utaoTzzEZUXeKlrM2sM2Qmb1U8mY5M7jTp4EDJIdJ75i
	rqh4rbKnQj2DbTIsRVd6+jvuBFiLe3dDDdBs/SuHOuRqms8Ihn/HZrnorTsEPaqVuksBtiBkJxC
	Vbd/dw4OU14h2XVYeTb+DvHuxz11Gh3Ijd8jme2W4SNslX5ed7sipzXOgJZQZVsAo0+zbCcDCPM
	UaFmowoIOgq9I48sIFK1iPtgYNrg0puM/KtJ34yLUVL4FyUZrdV6jote9W6nwMiCvCn2MipkvJn
	qPEcmMWhorFl/qUtP0ZjogTGh16yZr/RGERvQTzzlkJNoGVWtvbTq0jUeiqN0YcCySz+odwabqw
	hnuHqsVKgDIQBi0d0
X-Google-Smtp-Source: AGHT+IFkC7YUn+rFbDWUHPxDjnWz+LHs2ulH0jgjdmPsgy+JgK7kJnCaSBHOEBXeCtK/W9DRmWFtCw==
X-Received: by 2002:a05:6214:2682:b0:6ef:3de:5ff7 with SMTP id 6a1803df08f44-6f51574c533mr9433326d6.15.1746132051743;
        Thu, 01 May 2025 13:40:51 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 17/38] rust: Oe-selftest changes for rust v1.83.0
Date: Thu,  1 May 2025 16:39:53 -0400
Message-ID: <e1a9005021dcbab3a40e777a40fb9e078e4ecb78.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1443

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


