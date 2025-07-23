Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F8C87FCA
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.23023.1753296035143505763
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=B/MX1CON;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7df981428abso34217085a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296034; x=1753900834; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YsYEI5DPRV3K+K4D4lwSYA37bfDGmbcrHeKSEypsxg=;
        b=B/MX1CON47oRZ1Te1T1zq8frOjniItbWKoNcg62k2TyJ+Ji3oeznjYTAvQNXoYQ7Jv
         6dDECn5oXhjKst1zGbW4oG9YId5hjHqXJ+/HOckraGqNnCFpVjROQY+yi6aaz4KcEW7u
         O7VpFh5/IBwwmz1KgvixS+QkbEN84i/2WLiPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296034; x=1753900834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YsYEI5DPRV3K+K4D4lwSYA37bfDGmbcrHeKSEypsxg=;
        b=jGE3YtjvvIz4C2UmkomYqCzKV/ejDCuAtuKFc/x+Q55l6jTzhSFma7jSCWL0MWaBtY
         jzerJp+3Yc6lfLDTfWZsjl14BDz6vSFp0RyI1FGZSkIazYTvfUkIhw2TWU4iw0IhI2hR
         4ZbojNJj8D+wtPsPUpf1fgzm8FWglwMOdJ+tOvQjrnjTyBLeTzJBr2LnpnSZCU2hj7zs
         jmu+8b1eXKbF6pBymH618iA2TT/SjvPUPuQUHj1qtElReMATpd5p+15GqJOEKvdvPlex
         EJQKc+VhGmwTxV9IDgrmXJBU1hDpWsPT9tZkLhtwaw3wLB9ml0aFb3R540jSb9fKfxwl
         FUMg==
X-Gm-Message-State: AOJu0YyNIAjP5y484PQBKTJi0SiIkMOJojGxZhZAr/NDsSgOhdNfLjF4
	qtgTchcY9P9UP0Y4F0XUuzgPup6LfjktuGXN6aC0WVXfI83Vl3KVIglvvoqddTMJYOQgVXE4TlQ
	m7c+M
X-Gm-Gg: ASbGnctc0GUZd3nZ8V7hXKzvPFpV4jsYrooLC6JXsVAZztqS6qGZgRw2DKW5TNW0nci
	Vo26FyznDvyBYwgyNmBdXyUszpq+VU0dkg6kY8ZJ70hbSdSj3sU7zSl0xIiIYX+06aIw7JtxgFb
	CuQpQ5aneBVkffx6NkqwjXkyxd6iWW6aJpC0UqHKySd4OuutFgvyGPy3cx1OBpyWjIZl/DkKqPm
	WhiMGHQRi6imJxuN5GDA2UcZ86i/KO7o7MxJVbn71eVrr8FU9Bk7YMrXc6k1UOiB0DR/feN7yry
	+7HvCIdbC6EsBDGRfOGMJVNz19kDB6CPykfTYlzj772uG5wkN2bCVYxywboKXzzcwfQRF4l3RFw
	80gbezbgJNIFTMQbNQyHWoXKyJmYWa1F+lSaHvyVYpDqQAc2Ga9HND4kb2aCC97Ya+IsVicgcUQ
	==
X-Google-Smtp-Source: AGHT+IGI481bEvsqmB+eey93CWzGLri1EGgVmRuMNvuBWjDmySStHC6/l9YnoKKulp7Y66D6x6Y33A==
X-Received: by 2002:a05:620a:400f:b0:7e3:3682:6dea with SMTP id af79cd13be357-7e62a0b2e23mr595219985a.15.1753296033619;
        Wed, 23 Jul 2025 11:40:33 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:33 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/13] rust: re-enable the unit tests that are previously ignored
Date: Wed, 23 Jul 2025 14:40:02 -0400
Message-ID: <270b7a562053cacd809df755aff0d1fcacfe54f1.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1829

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Some unit tests were previously marked as ignored due to failures in earlier
versions of Rust. With the upgrade to Rust 1.85.1, these tests are now passing
consistently. They've been re-enabled and verified to run successfully on the
latest version.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 56149c8c2108973666251e21609a7210a91984cf)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 909bc97..048fc3f 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -103,50 +103,6 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_get_mut_poison() {
      let mut m = new_poisoned_rwlock(NonCopy(10));
 
-diff --git a/library/std/src/thread/tests.rs b/library/std/src/thread/tests.rs
-index 5d6b9e94ee9..a5aacb2eb87 100644
---- a/library/std/src/thread/tests.rs
-+++ b/library/std/src/thread/tests.rs
-@@ -116,6 +116,7 @@ fn test_is_finished() {
- }
-
- #[test]
-+#[ignore]
- fn test_join_panic() {
-     match thread::spawn(move || panic!()).join() {
-         result::Result::Err(_) => (),
-@@ -218,6 +219,7 @@ fn test_simple_newsched_spawn() {
- }
-
- #[test]
-+#[ignore]
- fn test_try_panic_message_string_literal() {
-     match thread::spawn(move || {
-         panic!("static string");
-@@ -234,6 +236,7 @@ fn test_try_panic_message_string_literal() {
- }
-
- #[test]
-+#[ignore]
- fn test_try_panic_any_message_owned_str() {
-     match thread::spawn(move || {
-         panic_any("owned string".to_string());
-@@ -250,6 +253,7 @@ fn test_try_panic_any_message_owned_str() {
- }
-
- #[test]
-+#[ignore]
- fn test_try_panic_any_message_any() {
-     match thread::spawn(move || {
-         panic_any(Box::new(413u16) as Box<dyn Any + Send>);
-@@ -268,6 +272,7 @@ fn test_try_panic_any_message_any() {
- }
-
- #[test]
-+#[ignore]
- fn test_try_panic_any_message_unit_struct() {
-     struct Juju;
-
 diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 --- a/library/test/src/tests.rs
 +++ b/library/test/src/tests.rs
-- 
2.50.0


