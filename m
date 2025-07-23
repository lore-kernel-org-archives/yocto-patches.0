Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711AC83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.23087.1753297549239392941
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NdglZjGp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e32c95778aso14337585a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297548; x=1753902348; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YsYEI5DPRV3K+K4D4lwSYA37bfDGmbcrHeKSEypsxg=;
        b=NdglZjGpGN8MeDppVK6weRDS3UoKVOE56/CCGwXEH+XySW8qn2/1d5ccbJ7MXKDLGM
         Y1+bO9sRb4gVGshcCaP/BKTTbk1/1Eubo7i4ZTSJ1nxZpe4mVw5c8rMoxNAEKQLwJ0Iz
         CdTcKy7r8itiPQnnp0/1KIr0iZEYnuRVwVUDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297548; x=1753902348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YsYEI5DPRV3K+K4D4lwSYA37bfDGmbcrHeKSEypsxg=;
        b=qfC0J9//LsbG7g5wRawYGcctE+cFJNm02Nys68MwT69Xqyk75uraAs8dQXwV4U0Aia
         ljz5V+lVETBfjG1hsh7Y7gsUd9LRqOXFtKQDADqg6E7HZMLcDeMLA7Vr+XBSihqetXxR
         rA8jWnlh9q1HRwoXhb5w3uTjNIbrs8VoRZcxa9g75nF/74AbAC7U4Cpc5fb5aBOurTnH
         88WBJEGx5CvEOFxMJIEVAqP1CObjnAJxpAMMS3K2nybg91Jrhi2Rh/zZRZZosSY1BaoF
         a2w1ffBHKxc5ef6p4XTELAq3+SI+kVL1M6/UfMfP/VRX+Kvcba+2Ntj+/xthcyFgP6V2
         QxyQ==
X-Gm-Message-State: AOJu0YzSsaoNvzcuFKr/kW0DDuMHVLYHnthRyimLO7hkZD6Kx3GoWKRo
	1e4agtdXVCNRS6ae+69bxeveWB9Tl56zGqb1TFTYd/+EsV6Sf0MWI3W1RJNot5TGaN/iPQ1Wq3P
	0L/SD
X-Gm-Gg: ASbGncunVoIh5cwMEbeMeu6h2ff/oJYyqH7T2YRRJpgDpg5aH37W9QnmJF2npo/su5U
	RFVDVTAJMFfyEoafBByVZSZ84A3n5Mr8XoaOS4i/hV4y+KtKQDhMRn4bYNi+Q15XMvastKCbEwc
	6cnID6skPwkI3rFbmCDygRHtNyd9vPly03Thde7FyJUqBRSUaLv4xxd/uFWaF41K+i0QL5nfEyb
	HDtH4ceWkjVLKa274BpuXECwsfLu0w4qDR8/mxINXSUR+DvwwijkE9WCtLitcUA1DxVu0o9nSnI
	2E9CsBhf8o/ns9xVKxO1dfS7Ize0uyN3Y0lfNKMMS8ZnaBCCG7c7cMEwq9R01p+8meMHyvaD1vP
	kbTKFzt6CLqw1H/RV73o6M4DCsjGhaPzquUwL8/hI+gzR6qFg1is6aMqhZ63XgFZnAkFbHw0X+g
	==
X-Google-Smtp-Source: AGHT+IEAGjwTVcJ8JOuyDkUoaiBMAFgnpoYRxyy3+bZjipEBhtVxBmG2HwfsTNqMUVWdFBcmrk+9ew==
X-Received: by 2002:a05:620a:a904:b0:7e1:3b7d:d12b with SMTP id af79cd13be357-7e62a098a20mr494823385a.6.1753297545937;
        Wed, 23 Jul 2025 12:05:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 02/13] rust: re-enable the unit tests that are previously ignored
Date: Wed, 23 Jul 2025 15:05:21 -0400
Message-ID: <8f50c8dc310bae9eb8f6695acaf5fbee333dbc3f.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1843

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


