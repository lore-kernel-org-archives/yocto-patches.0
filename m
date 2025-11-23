Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FECFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:46:03 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5058.1763941556803367330
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GdCJQoXv;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2d6df99c5so529236585a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941555; x=1764546355; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reYKB2tnEzv3CZ+2uuyBvxkGsSN3kn14z1S7HET1aUw=;
        b=GdCJQoXvQfjzxGtZkKd/vlkPedHswmjOJ1N4OmHMDVDkGe6GKegvGkQ19py1Fysfes
         uRc7qMTl/gOjFGK+o6PrwUN7HOMQEo7mtico+jWkbkUACL7feD7YToxVTQvVa1szIfzZ
         tfb52Q/OKMF592hg/lw3iu5z85uSmzlXqnft8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941555; x=1764546355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=reYKB2tnEzv3CZ+2uuyBvxkGsSN3kn14z1S7HET1aUw=;
        b=RIAjp4HSH9bO78BniL2fy6gDIhdgIazvH8ol2OWfLjLBPrQ5BeGaCrXgH7FLhn1F76
         qGMGCJSH/fyd81wohrbHh2HhxASf2REf3/dHBaOYa54BHTh/r4hXnGPH51oBmTluhVaD
         QfRlyUeK7tAOyxdR56dfD4ans1je1W3Rheol7GfwaCTV8yMH06Uv5vX5LtJ5Vfi1eyHz
         WB3agz9ek57xgRiN5m+XC0Cvj8PKwiujmupqpAFFsSwvWAsCjwfiXFtK7UvjXBNK2qbZ
         c6if1qFhlxVpXiusnnQgJj21isF1qO+LLliizw+C4FCwHbIB4Odz/FOdsif1itwr4gsU
         G3wg==
X-Gm-Message-State: AOJu0YwsBMkcAhf7tFEgrRqVZmhMsEVDD2Y6qFV8Ggm7ww99hjiRiaBB
	SBNBs4JQNeDej2NT5YrfX7pTFFKKRQMbQT26mUvuMloyNKjqUAcsauZeSAeQkfniQkuAZxVd+Jo
	IpAmu
X-Gm-Gg: ASbGncu+qeZ/h2V2aVIzOvHipThwaRBE2yY5QdyIKVOTfn/rgBuZsFQjqdWAjgSCO4O
	dh65a+npzevDnvS2LLodLXfU1Dnkk6X95NEui5YrPtrNFpC6JRwkZ5VaANN4mcLpYmc16jr+0fT
	l69Flx4UMM7tNKSJ4NCqNLJUMGkbz053DKvt/PxEea85+qGhjTJpXn1+2OKFMS/GU07akIUfuZq
	SCFLEQL4SUsEhCnskIbH7wAgErKnuxn5oldpGRtqsdzzR5XzOOymJZgPp/o2sq988gFBgXGdIxK
	RKlIxFBTMO+XhpMjn4LIplputgXby+/V47zOmZZx6PEXZkArT+a2GFjraUVjNz0RFiSzGgEDozP
	bubDheZp9wQ6WxK4QdGFSOK8ynCvg89UQDUgWW6hTkh9BOWwRUgVNN7JMu1E7lOI6LSQCD3W5ua
	OYekhCXQ+xHybxVjBTiwdyHFuXFGeEaG3QpZRAP28cGV630FQTgQwT460wb6JVTlY=
X-Google-Smtp-Source: AGHT+IG9J8vKN6Kecex+Sur3oqLqQK0OIW+G2KPzOBrc5evf3TZRIGnlCRFLj2T49hJ8wqms4CWYTw==
X-Received: by 2002:a05:620a:45a7:b0:810:a62b:1950 with SMTP id af79cd13be357-8b33bde8919mr1513670685a.31.1763941552678;
        Sun, 23 Nov 2025 15:45:52 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:51 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 32/32] suricata: update to 7.0.12
Date: Sun, 23 Nov 2025 18:45:12 -0500
Message-ID: <2c11f9f384f7f421d390064b348f00d9eb7c48da.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:46:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2690

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Also update libhtp to required version 0.5.52.

See suricata release notes for more details about changes and
CVEs fixed:

https://suricata.io/2024/02/08/suricata-7-0-3-and-6-0-16-released/
https://suricata.io/2024/03/19/suricata-7-0-4-and-6-0-17-released/
https://suricata.io/2024/04/23/suricata-7-0-5-and-6-0-19-released/
https://suricata.io/2024/06/27/suricata-7-0-6-and-6-0-20-released/
https://suricata.io/2024/10/01/suricata-7-0-7-released/
https://suricata.io/2024/12/12/suricata-7-0-8-released/
https://suricata.io/2025/03/18/suricata-7-0-9-released/
https://suricata.io/2025/07/08/suricata-7-0-11-released/
https://suricata.io/2025/09/16/suricata-8-0-1-and-7-0-12-released/

Obsolete CVE patches removed.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
(cherry picked from commit fbb8343cf81b0cfe1dc396b0cd2417a8315de9ad)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...kefile-from-using-its-own-rust-steps.patch |   40 +
 .../suricata/files/CVE-2024-32663-001.patch   |  294 -
 .../suricata/files/CVE-2024-32663-002.patch   |   70 -
 .../suricata/files/CVE-2024-32664.patch       |   53 -
 .../suricata/files/CVE-2024-32867-001.patch   |  235 -
 .../suricata/files/CVE-2024-32867-002.patch   |  591 --
 .../suricata/files/CVE-2024-32867-003.patch   |  472 --
 .../suricata/files/CVE-2024-32867-004.patch   |  169 -
 .../suricata/files/CVE-2024-45795.patch       |  123 -
 .../suricata/files/CVE-2024-45796.patch       |   33 -
 .../suricata/files/CVE-2024-45797.patch       |  148 -
 .../suricata/files/CVE-2024-55605.patch       |  205 -
 .../suricata/files/CVE-2024-55627-001.patch   |   59 -
 .../suricata/files/CVE-2024-55627-002.patch   |   44 -
 .../suricata/files/CVE-2024-55627-003.patch   |   41 -
 .../suricata/files/CVE-2024-55628-001.patch   |  738 ---
 .../suricata/files/CVE-2024-55628-002.patch   | 4877 -----------------
 .../suricata/files/CVE-2024-55628-003.patch   |  114 -
 .../suricata/files/CVE-2024-55628-004.patch   |  510 --
 .../suricata/files/CVE-2025-29916-01.patch    |  124 -
 .../suricata/files/CVE-2025-29916-02.patch    |  197 -
 .../suricata/files/CVE-2025-29916-03.patch    |   55 -
 .../suricata/files/CVE-2025-29917.patch       |  115 -
 .../suricata/files/CVE-2025-29918.patch       |   49 -
 .../suricata/files/CVE-2025-53537-001.patch   |   79 -
 .../suricata/files/CVE-2025-53537-002.patch   |   31 -
 recipes-ids/suricata/files/fixup.patch        |   32 -
 .../{libhtp_0.5.45.bb => libhtp_0.5.52.bb}    |    8 +-
 recipes-ids/suricata/suricata-crates.inc      | 1509 +++--
 .../{suricata_7.0.0.bb => suricata_7.0.12.bb} |   26 +-
 30 files changed, 780 insertions(+), 10261 deletions(-)
 create mode 100644 recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32663-001.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32663-002.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32664.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32867-001.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32867-002.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32867-003.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-32867-004.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-45795.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-45796.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-45797.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55605.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55627-001.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55627-002.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55627-003.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55628-001.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55628-002.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55628-003.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-55628-004.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-29916-01.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-29916-02.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-29916-03.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-29917.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-29918.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-53537-001.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2025-53537-002.patch
 delete mode 100644 recipes-ids/suricata/files/fixup.patch
 rename recipes-ids/suricata/{libhtp_0.5.45.bb => libhtp_0.5.52.bb} (72%)
 rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.12.bb} (86%)

diff --git a/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch b/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
new file mode 100644
index 0000000..12cb096
--- /dev/null
+++ b/recipes-ids/suricata/files/0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch
@@ -0,0 +1,40 @@
+From a59708a9300df8116867ac77f7829f7fd647325e Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 3 Nov 2025 10:30:26 -0700
+Subject: [PATCH] Skip pkg Makefile from using its own rust steps
+
+Upstream-Status: Inappropriate [OE Specific]
+
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ Makefile.am | 2 +-
+ Makefile.in | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/Makefile.am b/Makefile.am
+index d0d3d09..a572912 100644
+--- a/Makefile.am
++++ b/Makefile.am
+@@ -10,7 +10,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
+ 	     scripts/generate-images.sh \
+ 	     scripts/docs-almalinux9-minimal-build.sh \
+ 	     scripts/docs-ubuntu-debian-minimal-build.sh
+-SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
++SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
+           $(SURICATA_UPDATE_DIR)
+ 
+ CLEANFILES = stamp-h[0-9]*
+diff --git a/Makefile.in b/Makefile.in
+index 7a89353..3864613 100644
+--- a/Makefile.in
++++ b/Makefile.in
+@@ -428,7 +428,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
+ 	     scripts/docs-almalinux9-minimal-build.sh \
+ 	     scripts/docs-ubuntu-debian-minimal-build.sh
+ 
+-SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
++SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
+           $(SURICATA_UPDATE_DIR)
+ 
+ CLEANFILES = stamp-h[0-9]*
diff --git a/recipes-ids/suricata/files/CVE-2024-32663-001.patch b/recipes-ids/suricata/files/CVE-2024-32663-001.patch
deleted file mode 100644
index f07904a..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32663-001.patch
+++ /dev/null
@@ -1,294 +0,0 @@
-From e68ec4b227d19498f364a41eb25d3182f0383ca5 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Wed, 27 Mar 2024 14:33:54 +0100
-Subject: [PATCH] http2: use a reference counter for headers
-
-Ticket: 6892
-
-As HTTP hpack header compression allows one single byte to
-express a previously seen arbitrary-size header block (name+value)
-we should avoid to copy the vectors data, but just point
-to the same data, while reamining memory safe, even in the case
-of later headers eviction from the dybnamic table.
-
-Rust std solution is Rc, and the use of clone, so long as the
-data is accessed by only one thread.
-
-(cherry picked from commit 390f09692eb99809c679d3f350c7cc185d163e1a)
-
-CVE: CVE-2024-32663
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e68ec4b227d19498f364a41eb25d3182f0383ca5]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- rust/src/http2/detect.rs | 19 +++++++------
- rust/src/http2/http2.rs  |  2 +-
- rust/src/http2/parser.rs | 61 +++++++++++++++++++++-------------------
- 3 files changed, 43 insertions(+), 39 deletions(-)
-
-diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
-index 99261ad..904b9ad 100644
---- a/rust/src/http2/detect.rs
-+++ b/rust/src/http2/detect.rs
-@@ -23,6 +23,7 @@ use crate::core::Direction;
- use crate::detect::uint::{detect_match_uint, DetectUintData};
- use std::ffi::CStr;
- use std::str::FromStr;
-+use std::rc::Rc;
- 
- fn http2_tx_has_frametype(
-     tx: &mut HTTP2Transaction, direction: Direction, value: u8,
-@@ -404,7 +405,7 @@ fn http2_frames_get_header_firstvalue<'a>(
-     for frame in frames {
-         if let Some(blocks) = http2_header_blocks(frame) {
-             for block in blocks.iter() {
--                if block.name == name.as_bytes() {
-+                if block.name.as_ref() == name.as_bytes() {
-                     return Ok(&block.value);
-                 }
-             }
-@@ -428,7 +429,7 @@ pub fn http2_frames_get_header_value_vec(
-     for frame in frames {
-         if let Some(blocks) = http2_header_blocks(frame) {
-             for block in blocks.iter() {
--                if block.name == name.as_bytes() {
-+                if block.name.as_ref() == name.as_bytes() {
-                     if found == 0 {
-                         vec.extend_from_slice(&block.value);
-                         found = 1;
-@@ -465,7 +466,7 @@ fn http2_frames_get_header_value<'a>(
-     for frame in frames {
-         if let Some(blocks) = http2_header_blocks(frame) {
-             for block in blocks.iter() {
--                if block.name == name.as_bytes() {
-+                if block.name.as_ref() == name.as_bytes() {
-                     if found == 0 {
-                         single = Ok(&block.value);
-                         found = 1;
-@@ -905,8 +906,8 @@ fn http2_tx_set_header(state: &mut HTTP2State, name: &[u8], input: &[u8]) {
-     };
-     let mut blocks = Vec::new();
-     let b = parser::HTTP2FrameHeaderBlock {
--        name: name.to_vec(),
--        value: input.to_vec(),
-+        name: Rc::new(name.to_vec()),
-+        value: Rc::new(input.to_vec()),
-         error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
-         sizeupdate: 0,
-     };
-@@ -1061,15 +1062,15 @@ mod tests {
-         };
-         let mut blocks = Vec::new();
-         let b = parser::HTTP2FrameHeaderBlock {
--            name: "Host".as_bytes().to_vec(),
--            value: "abc.com".as_bytes().to_vec(),
-+            name: "Host".as_bytes().to_vec().into(),
-+            value: "abc.com".as_bytes().to_vec().into(),
-             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
-             sizeupdate: 0,
-         };
-         blocks.push(b);
-         let b2 = parser::HTTP2FrameHeaderBlock {
--            name: "Host".as_bytes().to_vec(),
--            value: "efg.net".as_bytes().to_vec(),
-+            name: "Host".as_bytes().to_vec().into(),
-+            value: "efg.net".as_bytes().to_vec().into(),
-             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
-             sizeupdate: 0,
-         };
-diff --git a/rust/src/http2/http2.rs b/rust/src/http2/http2.rs
-index 326030f..d14ca06 100644
---- a/rust/src/http2/http2.rs
-+++ b/rust/src/http2/http2.rs
-@@ -204,7 +204,7 @@ impl HTTP2Transaction {
- 
-     fn handle_headers(&mut self, blocks: &[parser::HTTP2FrameHeaderBlock], dir: Direction) {
-         for block in blocks {
--            if block.name == b"content-encoding" {
-+            if block.name.as_ref() == b"content-encoding" {
-                 self.decoder.http2_encoding_fromvec(&block.value, dir);
-             }
-         }
-diff --git a/rust/src/http2/parser.rs b/rust/src/http2/parser.rs
-index adabeb2..1a46437 100644
---- a/rust/src/http2/parser.rs
-+++ b/rust/src/http2/parser.rs
-@@ -30,6 +30,7 @@ use nom7::sequence::tuple;
- use nom7::{Err, IResult};
- use std::fmt;
- use std::str::FromStr;
-+use std::rc::Rc;
- 
- #[repr(u8)]
- #[derive(Clone, Copy, PartialEq, Eq, FromPrimitive, Debug)]
-@@ -295,8 +296,8 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
-     };
-     if !name.is_empty() {
-         return Some(HTTP2FrameHeaderBlock {
--            name: name.as_bytes().to_vec(),
--            value: value.as_bytes().to_vec(),
-+            name: Rc::new(name.as_bytes().to_vec()),
-+            value: Rc::new(value.as_bytes().to_vec()),
-             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
-             sizeupdate: 0,
-         });
-@@ -304,23 +305,23 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
-         //use dynamic table
-         if n == 0 {
-             return Some(HTTP2FrameHeaderBlock {
--                name: Vec::new(),
--                value: Vec::new(),
-+                name: Rc::new(Vec::new()),
-+                value: Rc::new(Vec::new()),
-                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIndex0,
-                 sizeupdate: 0,
-             });
-         } else if dyn_headers.table.len() + HTTP2_STATIC_HEADERS_NUMBER < n as usize {
-             return Some(HTTP2FrameHeaderBlock {
--                name: Vec::new(),
--                value: Vec::new(),
-+                name: Rc::new(Vec::new()),
-+                value: Rc::new(Vec::new()),
-                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
-                 sizeupdate: 0,
-             });
-         } else {
-             let indyn = dyn_headers.table.len() - (n as usize - HTTP2_STATIC_HEADERS_NUMBER);
-             let headcopy = HTTP2FrameHeaderBlock {
--                name: dyn_headers.table[indyn].name.to_vec(),
--                value: dyn_headers.table[indyn].value.to_vec(),
-+                name: dyn_headers.table[indyn].name.clone(),
-+                value: dyn_headers.table[indyn].value.clone(),
-                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
-                 sizeupdate: 0,
-             };
-@@ -348,8 +349,10 @@ impl fmt::Display for HTTP2HeaderDecodeStatus {
- 
- #[derive(Clone, Debug)]
- pub struct HTTP2FrameHeaderBlock {
--    pub name: Vec<u8>,
--    pub value: Vec<u8>,
-+    // Use Rc reference counted so that indexed headers do not get copied.
-+    // Otherwise, this leads to quadratic complexity in memory occupation.
-+    pub name: Rc<Vec<u8>>,
-+    pub value: Rc<Vec<u8>>,
-     pub error: HTTP2HeaderDecodeStatus,
-     pub sizeupdate: u64,
- }
-@@ -391,7 +394,7 @@ fn http2_parse_headers_block_literal_common<'a>(
- ) -> IResult<&'a [u8], HTTP2FrameHeaderBlock> {
-     let (i3, name, error) = if index == 0 {
-         match http2_parse_headers_block_string(input) {
--            Ok((r, n)) => Ok((r, n, HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
-+            Ok((r, n)) => Ok((r, Rc::new(n), HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
-             Err(e) => Err(e),
-         }
-     } else {
-@@ -403,7 +406,7 @@ fn http2_parse_headers_block_literal_common<'a>(
-             )),
-             None => Ok((
-                 input,
--                Vec::new(),
-+                Rc::new(Vec::new()),
-                 HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
-             )),
-         }
-@@ -413,7 +416,7 @@ fn http2_parse_headers_block_literal_common<'a>(
-         i4,
-         HTTP2FrameHeaderBlock {
-             name,
--            value,
-+            value: Rc::new(value),
-             error,
-             sizeupdate: 0,
-         },
-@@ -435,8 +438,8 @@ fn http2_parse_headers_block_literal_incindex<'a>(
-     match r {
-         Ok((r, head)) => {
-             let headcopy = HTTP2FrameHeaderBlock {
--                name: head.name.to_vec(),
--                value: head.value.to_vec(),
-+                name: head.name.clone(),
-+                value: head.value.clone(),
-                 error: head.error,
-                 sizeupdate: 0,
-             };
-@@ -556,8 +559,8 @@ fn http2_parse_headers_block_dynamic_size<'a>(
-     return Ok((
-         i3,
-         HTTP2FrameHeaderBlock {
--            name: Vec::new(),
--            value: Vec::new(),
-+            name: Rc::new(Vec::new()),
-+            value: Rc::new(Vec::new()),
-             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSizeUpdate,
-             sizeupdate: maxsize2,
-         },
-@@ -614,8 +617,8 @@ fn http2_parse_headers_blocks<'a>(
-                 // if we error from http2_parse_var_uint, we keep the first parsed headers
-                 if err.code == ErrorKind::LengthValue {
-                     blocks.push(HTTP2FrameHeaderBlock {
--                        name: Vec::new(),
--                        value: Vec::new(),
-+                        name: Rc::new(Vec::new()),
-+                        value: Rc::new(Vec::new()),
-                         error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIntegerOverflow,
-                         sizeupdate: 0,
-                     });
-@@ -765,8 +768,8 @@ mod tests {
-         match r0 {
-             Ok((remainder, hd)) => {
-                 // Check the first message.
--                assert_eq!(hd.name, ":method".as_bytes().to_vec());
--                assert_eq!(hd.value, "GET".as_bytes().to_vec());
-+                assert_eq!(hd.name, ":method".as_bytes().to_vec().into());
-+                assert_eq!(hd.value, "GET".as_bytes().to_vec().into());
-                 // And we should have no bytes left.
-                 assert_eq!(remainder.len(), 0);
-             }
-@@ -782,8 +785,8 @@ mod tests {
-         match r1 {
-             Ok((remainder, hd)) => {
-                 // Check the first message.
--                assert_eq!(hd.name, "accept".as_bytes().to_vec());
--                assert_eq!(hd.value, "*/*".as_bytes().to_vec());
-+                assert_eq!(hd.name, "accept".as_bytes().to_vec().into());
-+                assert_eq!(hd.value, "*/*".as_bytes().to_vec().into());
-                 // And we should have no bytes left.
-                 assert_eq!(remainder.len(), 0);
-                 assert_eq!(dynh.table.len(), 1);
-@@ -802,8 +805,8 @@ mod tests {
-         match result {
-             Ok((remainder, hd)) => {
-                 // Check the first message.
--                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
--                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
-+                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
-+                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
-                 // And we should have no bytes left.
-                 assert_eq!(remainder.len(), 0);
-                 assert_eq!(dynh.table.len(), 2);
-@@ -820,8 +823,8 @@ mod tests {
-         match r3 {
-             Ok((remainder, hd)) => {
-                 // same as before
--                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
--                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
-+                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
-+                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
-                 // And we should have no bytes left.
-                 assert_eq!(remainder.len(), 0);
-                 assert_eq!(dynh.table.len(), 2);
-@@ -856,8 +859,8 @@ mod tests {
-         match r2 {
-             Ok((remainder, hd)) => {
-                 // Check the first message.
--                assert_eq!(hd.name, ":path".as_bytes().to_vec());
--                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec());
-+                assert_eq!(hd.name, ":path".as_bytes().to_vec().into());
-+                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec().into());
-                 // And we should have no bytes left.
-                 assert_eq!(remainder.len(), 0);
-                 assert_eq!(dynh.table.len(), 2);
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32663-002.patch b/recipes-ids/suricata/files/CVE-2024-32663-002.patch
deleted file mode 100644
index a57f58f..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32663-002.patch
+++ /dev/null
@@ -1,70 +0,0 @@
-From c0af92295e833d1db29b184d63cd3b829451d7fd Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 28 Mar 2024 11:15:51 +0100
-Subject: [PATCH] http2: do not log duplicate headers
-
-Ticket: 6900
-
-And thus avoid DOS by logging a request using a compressed
-header block repeated many times and having a long value...
-
-(cherry picked from commit 03442c9071b8d863d26b609d54c6eacf4de9e340)
-
-CVE: CVE-2024-32663
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/c0af92295e833d1db29b184d63cd3b829451d7fd]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- rust/src/http2/logger.rs | 17 +++++++++++++++--
- 1 file changed, 15 insertions(+), 2 deletions(-)
-
-diff --git a/rust/src/http2/logger.rs b/rust/src/http2/logger.rs
-index d25f852..a117a54 100644
---- a/rust/src/http2/logger.rs
-+++ b/rust/src/http2/logger.rs
-@@ -19,7 +19,8 @@ use super::http2::{HTTP2Frame, HTTP2FrameTypeData, HTTP2Transaction};
- use super::parser;
- use crate::jsonbuilder::{JsonBuilder, JsonError};
- use std;
--use std::collections::HashMap;
-+use std::collections::{HashMap, HashSet};
-+use std::rc::Rc;
- 
- #[derive(Hash, PartialEq, Eq, Debug)]
- enum HeaderName {
-@@ -35,10 +36,20 @@ fn log_http2_headers<'a>(
-     blocks: &'a [parser::HTTP2FrameHeaderBlock], js: &mut JsonBuilder,
-     common: &mut HashMap<HeaderName, &'a Vec<u8>>,
- ) -> Result<(), JsonError> {
-+    let mut logged_headers = HashSet::new();
-     for block in blocks {
--        js.start_object()?;
-+        // delay js.start_object() because we skip suplicate headers
-         match block.error {
-             parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess => {
-+                if Rc::strong_count(&block.name) > 2 {
-+                    // more than one reference in headers table + current headers
-+                    let ptr = Rc::as_ptr(&block.name) as usize;
-+                    if !logged_headers.insert(ptr) {
-+                        // only log once
-+                        continue;
-+                    }
-+                }
-+                js.start_object()?;
-                 js.set_string_from_bytes("name", &block.name)?;
-                 js.set_string_from_bytes("value", &block.value)?;
-                 if let Ok(name) = std::str::from_utf8(&block.name) {
-@@ -66,9 +77,11 @@ fn log_http2_headers<'a>(
-                 }
-             }
-             parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSizeUpdate => {
-+                js.start_object()?;
-                 js.set_uint("table_size_update", block.sizeupdate)?;
-             }
-             _ => {
-+                js.start_object()?;
-                 js.set_string("error", &block.error.to_string())?;
-             }
-         }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32664.patch b/recipes-ids/suricata/files/CVE-2024-32664.patch
deleted file mode 100644
index ee55b25..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32664.patch
+++ /dev/null
@@ -1,53 +0,0 @@
-From d5ffecf11ad2c6fe89265e518f5d7443caf26ba4 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 28 Mar 2024 14:00:02 +0100
-Subject: [PATCH] util/base64: fix buffer overflow
-
-Ticket: 6902
-
-In case the caller of DecodeBase64 does not supply a big enough
-output buffer.
-
-(cherry picked from commit fd47e67dc65f9111895c88fb406c938b1f857325)
-
-CVE: CVE-2024-32664
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/d5ffecf11ad2c6fe89265e518f5d7443caf26ba4]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/util-base64.c | 6 +++++-
- 1 file changed, 5 insertions(+), 1 deletion(-)
-
-diff --git a/src/util-base64.c b/src/util-base64.c
-index 4a4a5d1..d973f0e 100644
---- a/src/util-base64.c
-+++ b/src/util-base64.c
-@@ -156,6 +156,8 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
-                 ecode = BASE64_ECODE_BUF;
-                 break;
-             }
-+            if (dest_size - *decoded_bytes < ASCII_BLOCK)
-+                return BASE64_ECODE_BUF;
- 
-             /* Decode base-64 block into ascii block and move pointer */
-             DecodeBase64Block(dptr, b64);
-@@ -183,7 +185,7 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
-         /* if the destination size is not at least 3 Bytes long, it'll give a dynamic
-          * buffer overflow while decoding, so, return and let the caller take care of the
-          * remaining bytes to be decoded which should always be < 4 at this stage */
--        if (dest_size - *decoded_bytes < 3)
-+        if (dest_size - *decoded_bytes < ASCII_BLOCK)
-             return BASE64_ECODE_BUF;
-         *decoded_bytes += numDecoded_blk;
-         DecodeBase64Block(dptr, b64);
-@@ -193,6 +195,8 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
-     /* Finish remaining b64 bytes by padding */
-     if (valid && bbidx > 0 && (mode != BASE64_MODE_RFC2045)) {
-         /* Decode remaining */
-+        if (dest_size - *decoded_bytes < ASCII_BLOCK)
-+            return BASE64_ECODE_BUF;
-         *decoded_bytes += ASCII_BLOCK - (B64_BLOCK - bbidx);
-         DecodeBase64Block(dptr, b64);
-     }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-001.patch b/recipes-ids/suricata/files/CVE-2024-32867-001.patch
deleted file mode 100644
index 68bd6ea..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32867-001.patch
+++ /dev/null
@@ -1,235 +0,0 @@
-From 2f39ba75f153ba9bdf8eedc2a839cc973dbaea66 Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Tue, 28 Nov 2023 12:35:26 -0600
-Subject: [PATCH] defrag: check next fragment for overlap before stopping
- re-assembly
-
-Instead of breaking the loop when the current fragment does not have
-any more fragments, set a flag and continue to the next fragment as
-the next fragment may have data that occurs before this fragment, but
-overlaps it.
-
-Then break if the next fragment does not overlap the previous.
-
-Bug: #6668
-(cherry picked from commit d0fd0782505d837e691ceef1b801776f0db82726)
-
-CVE: CVE-2024-32867
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/2f39ba75f153ba9bdf8eedc2a839cc973dbaea66]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/defrag.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++---
- 1 file changed, 139 insertions(+), 6 deletions(-)
-
-diff --git a/src/defrag.c b/src/defrag.c
-index 38704c9..e154899 100644
---- a/src/defrag.c
-+++ b/src/defrag.c
-@@ -295,10 +295,20 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-     uint16_t hlen = 0;
-     int ip_hdr_offset = 0;
- 
-+    /* Assume more frags. */
-+    uint16_t prev_offset = 0;
-+    bool more_frags = 1;
-+
-     RB_FOREACH(frag, IP_FRAGMENTS, &tracker->fragment_tree) {
-         SCLogDebug("frag %p, data_len %u, offset %u, pcap_cnt %"PRIu64,
-                 frag, frag->data_len, frag->offset, frag->pcap_cnt);
- 
-+        /* Previous fragment has no more fragments, and this packet
-+         * doesn't overlap. We're done. */
-+        if (!more_frags && frag->offset > prev_offset) {
-+            break;
-+        }
-+
-         if (frag->skip)
-             continue;
-         if (frag->ltrim >= frag->data_len)
-@@ -339,9 +349,16 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-                 fragmentable_len = frag->offset + frag->data_len;
-         }
- 
--        if (!frag->more_frags) {
--            break;
--        }
-+        /* Even if this fragment is flagged as having no more
-+         * fragments, still continue. The next fragment may have the
-+         * same offset with data that is preferred.
-+         *
-+         * For example, DefragBsdFragmentAfterNoMfIpv{4,6}Test
-+         *
-+         * This is due to not all fragments being completely trimmed,
-+         * but relying on the copy ordering. */
-+        more_frags = frag->more_frags;
-+        prev_offset = frag->offset;
-     }
- 
-     SCLogDebug("ip_hdr_offset %u, hlen %" PRIu16 ", fragmentable_len %" PRIu16, ip_hdr_offset, hlen,
-@@ -436,7 +453,15 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-     uint16_t fragmentable_len = 0;
-     int ip_hdr_offset = 0;
-     uint8_t next_hdr = 0;
-+
-+    /* Assume more frags. */
-+    uint16_t prev_offset = 0;
-+    bool more_frags = 1;
-+
-     RB_FOREACH(frag, IP_FRAGMENTS, &tracker->fragment_tree) {
-+        if (!more_frags && frag->offset > prev_offset) {
-+            break;
-+        }
-         if (frag->skip)
-             continue;
-         if (frag->data_len - frag->ltrim <= 0)
-@@ -481,9 +506,16 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-                 fragmentable_len = frag->offset + frag->data_len;
-         }
- 
--        if (!frag->more_frags) {
--            break;
--        }
-+        /* Even if this fragment is flagged as having no more
-+         * fragments, still continue. The next fragment may have the
-+         * same offset with data that is preferred.
-+         *
-+         * For example, DefragBsdFragmentAfterNoMfIpv{4,6}Test
-+         *
-+         * This is due to not all fragments being completely trimmed,
-+         * but relying on the copy ordering. */
-+        more_frags = frag->more_frags;
-+        prev_offset = frag->offset;
-     }
- 
-     rp->ip6h = (IPV6Hdr *)(GET_PKT_DATA(rp) + ip_hdr_offset);
-@@ -2374,6 +2406,10 @@ static int DefragMfIpv4Test(void)
-      * fragments should be in the re-assembled packet. */
-     FAIL_IF(IPV4_GET_IPLEN(p) != 36);
- 
-+    /* Verify the payload of the IPv4 packet. */
-+    uint8_t expected_payload[] = "AAAAAAAABBBBBBBB";
-+    FAIL_IF(memcmp(GET_PKT_DATA(p) + sizeof(IPV4Hdr), expected_payload, sizeof(expected_payload)));
-+
-     SCFree(p1);
-     SCFree(p2);
-     SCFree(p3);
-@@ -2417,6 +2453,10 @@ static int DefragMfIpv6Test(void)
-      * of 2 fragments, so 16. */
-     FAIL_IF(IPV6_GET_PLEN(p) != 16);
- 
-+    /* Verify the payload of the IPv4 packet. */
-+    uint8_t expected_payload[] = "AAAAAAAABBBBBBBB";
-+    FAIL_IF(memcmp(GET_PKT_DATA(p) + sizeof(IPV6Hdr), expected_payload, sizeof(expected_payload)));
-+
-     SCFree(p1);
-     SCFree(p2);
-     SCFree(p3);
-@@ -2510,6 +2550,96 @@ static int DefragTestJeremyLinux(void)
-     PASS;
- }
- 
-+static int DefragBsdFragmentAfterNoMfIpv4Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[4];
-+
-+    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 24 >> 3, 0, 'A', 16);
-+    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 8 >> 3, 1, 'B', 16);
-+    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 16 >> 3, 1, 'C', 16);
-+    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 0, 1, 'D', 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    uint8_t expected[] = {
-+	'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D',
-+	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
-+	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
-+	'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C',
-+	'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
-+    };
-+    // clang-format on
-+
-+    if (memcmp(expected, GET_PKT_DATA(r) + 20, sizeof(expected)) != 0) {
-+        printf("Expected:\n");
-+        PrintRawDataFp(stdout, expected, sizeof(expected));
-+        printf("Got:\n");
-+        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
-+        FAIL;
-+    }
-+
-+    DefragDestroy();
-+    PASS;
-+}
-+
-+static int DefragBsdFragmentAfterNoMfIpv6Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[4];
-+
-+    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 24 >> 3, 0, 'A', 16);
-+    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 8 >> 3, 1, 'B', 16);
-+    packets[2] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 16 >> 3, 1, 'C', 16);
-+    packets[3] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 0, 1, 'D', 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    uint8_t expected[] = {
-+	'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D',
-+	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
-+	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
-+	'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C',
-+	'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
-+    };
-+    // clang-format on
-+
-+    if (memcmp(expected, GET_PKT_DATA(r) + 40, sizeof(expected)) != 0) {
-+        printf("Expected:\n");
-+        PrintRawDataFp(stdout, expected, sizeof(expected));
-+        printf("Got:\n");
-+        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
-+        FAIL;
-+    }
-+
-+    DefragDestroy();
-+    PASS;
-+}
-+
- #endif /* UNITTESTS */
- 
- void DefragRegisterTests(void)
-@@ -2555,5 +2685,8 @@ void DefragRegisterTests(void)
-     UtRegisterTest("DefragTestBadProto", DefragTestBadProto);
- 
-     UtRegisterTest("DefragTestJeremyLinux", DefragTestJeremyLinux);
-+
-+    UtRegisterTest("DefragBsdFragmentAfterNoMfIpv4Test", DefragBsdFragmentAfterNoMfIpv4Test);
-+    UtRegisterTest("DefragBsdFragmentAfterNoMfIpv6Test", DefragBsdFragmentAfterNoMfIpv6Test);
- #endif /* UNITTESTS */
- }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-002.patch b/recipes-ids/suricata/files/CVE-2024-32867-002.patch
deleted file mode 100644
index cfddce2..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32867-002.patch
+++ /dev/null
@@ -1,591 +0,0 @@
-From 7137d5e7ab5500f1b7f3391f8ab55a59f1e4cbd7 Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Mon, 27 Nov 2023 16:27:27 -0600
-Subject: [PATCH] defrag: consistent unit test naming
-
-Use a more consistent naming scheme between ipv4 and ipv6.
-
-(cherry picked from commit 2f00b5870abc6053fca8271a0a827babc03d56f0)
-
-CVE: CVE-2024-32867
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/7137d5e7ab5500f1b7f3391f8ab55a59f1e4cbd7]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/defrag.c | 217 ++++++++++++++++++++++++---------------------------
- 1 file changed, 102 insertions(+), 115 deletions(-)
-
-diff --git a/src/defrag.c b/src/defrag.c
-index e154899..99fbab3 100644
---- a/src/defrag.c
-+++ b/src/defrag.c
-@@ -1125,8 +1125,8 @@ void DefragDestroy(void)
-  * Allocate a test packet.  Nothing to fancy, just a simple IP packet
-  * with some payload of no particular protocol.
-  */
--static Packet *BuildTestPacket(uint8_t proto, uint16_t id, uint16_t off, int mf,
--        const char content, int content_len)
-+static Packet *BuildIpv4TestPacket(
-+        uint8_t proto, uint16_t id, uint16_t off, int mf, const char content, int content_len)
- {
-     Packet *p = NULL;
-     int hlen = 20;
-@@ -1199,8 +1199,8 @@ error:
-     return NULL;
- }
- 
--static Packet *IPV6BuildTestPacket(uint8_t proto, uint32_t id, uint16_t off,
--        int mf, const char content, int content_len)
-+static Packet *BuildIpv6TestPacket(
-+        uint8_t proto, uint32_t id, uint16_t off, int mf, const char content, int content_len)
- {
-     Packet *p = NULL;
-     uint8_t *pcontent;
-@@ -1283,11 +1283,11 @@ static int DefragInOrderSimpleTest(void)
- 
-     DefragInit();
- 
--    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = BuildTestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
-+    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
-     FAIL_IF_NULL(p2);
--    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-+    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-     FAIL_IF_NULL(p3);
- 
-     FAIL_IF(Defrag(NULL, NULL, p1) != NULL);
-@@ -1335,11 +1335,11 @@ static int DefragReverseSimpleTest(void)
- 
-     DefragInit();
- 
--    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = BuildTestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
-+    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
-     FAIL_IF_NULL(p2);
--    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-+    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-     FAIL_IF_NULL(p3);
- 
-     FAIL_IF(Defrag(NULL, NULL, p3) != NULL);
-@@ -1379,7 +1379,7 @@ static int DefragReverseSimpleTest(void)
-  * Test the simplest possible re-assembly scenario.  All packet in
-  * order and no overlaps.
-  */
--static int IPV6DefragInOrderSimpleTest(void)
-+static int DefragInOrderSimpleIpv6Test(void)
- {
-     Packet *p1 = NULL, *p2 = NULL, *p3 = NULL;
-     Packet *reassembled = NULL;
-@@ -1388,11 +1388,11 @@ static int IPV6DefragInOrderSimpleTest(void)
- 
-     DefragInit();
- 
--    p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
-+    p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
-+    p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
-     FAIL_IF_NULL(p2);
--    p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
-+    p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
-     FAIL_IF_NULL(p3);
- 
-     FAIL_IF(Defrag(NULL, NULL, p1) != NULL);
-@@ -1426,7 +1426,7 @@ static int IPV6DefragInOrderSimpleTest(void)
-     PASS;
- }
- 
--static int IPV6DefragReverseSimpleTest(void)
-+static int DefragReverseSimpleIpv6Test(void)
- {
-     DefragContext *dc = NULL;
-     Packet *p1 = NULL, *p2 = NULL, *p3 = NULL;
-@@ -1439,11 +1439,11 @@ static int IPV6DefragReverseSimpleTest(void)
-     dc = DefragContextNew();
-     FAIL_IF_NULL(dc);
- 
--    p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
-+    p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
-+    p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
-     FAIL_IF_NULL(p2);
--    p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
-+    p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
-     FAIL_IF_NULL(p3);
- 
-     FAIL_IF(Defrag(NULL, NULL, p3) != NULL);
-@@ -1496,59 +1496,59 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
-      */
- 
-     /* A*24 at 0. */
--    packets[0] = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
-+    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
- 
-     /* B*15 at 32. */
--    packets[1] = BuildTestPacket(IPPROTO_ICMP, id, 32 >> 3, 1, 'B', 16);
-+    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 32 >> 3, 1, 'B', 16);
- 
-     /* C*24 at 48. */
--    packets[2] = BuildTestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'C', 24);
-+    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'C', 24);
- 
-     /* D*8 at 80. */
--    packets[3] = BuildTestPacket(IPPROTO_ICMP, id, 80 >> 3, 1, 'D', 8);
-+    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 80 >> 3, 1, 'D', 8);
- 
-     /* E*16 at 104. */
--    packets[4] = BuildTestPacket(IPPROTO_ICMP, id, 104 >> 3, 1, 'E', 16);
-+    packets[4] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 104 >> 3, 1, 'E', 16);
- 
-     /* F*24 at 120. */
--    packets[5] = BuildTestPacket(IPPROTO_ICMP, id, 120 >> 3, 1, 'F', 24);
-+    packets[5] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 120 >> 3, 1, 'F', 24);
- 
-     /* G*16 at 144. */
--    packets[6] = BuildTestPacket(IPPROTO_ICMP, id, 144 >> 3, 1, 'G', 16);
-+    packets[6] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 144 >> 3, 1, 'G', 16);
- 
-     /* H*16 at 160. */
--    packets[7] = BuildTestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'H', 16);
-+    packets[7] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'H', 16);
- 
-     /* I*8 at 176. */
--    packets[8] = BuildTestPacket(IPPROTO_ICMP, id, 176 >> 3, 1, 'I', 8);
-+    packets[8] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 176 >> 3, 1, 'I', 8);
- 
-     /*
-      * Overlapping subsequent fragments.
-      */
- 
-     /* J*32 at 8. */
--    packets[9] = BuildTestPacket(IPPROTO_ICMP, id, 8 >> 3, 1, 'J', 32);
-+    packets[9] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 8 >> 3, 1, 'J', 32);
- 
-     /* K*24 at 48. */
--    packets[10] = BuildTestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'K', 24);
-+    packets[10] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'K', 24);
- 
-     /* L*24 at 72. */
--    packets[11] = BuildTestPacket(IPPROTO_ICMP, id, 72 >> 3, 1, 'L', 24);
-+    packets[11] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 72 >> 3, 1, 'L', 24);
- 
-     /* M*24 at 96. */
--    packets[12] = BuildTestPacket(IPPROTO_ICMP, id, 96 >> 3, 1, 'M', 24);
-+    packets[12] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 96 >> 3, 1, 'M', 24);
- 
-     /* N*8 at 128. */
--    packets[13] = BuildTestPacket(IPPROTO_ICMP, id, 128 >> 3, 1, 'N', 8);
-+    packets[13] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 128 >> 3, 1, 'N', 8);
- 
-     /* O*8 at 152. */
--    packets[14] = BuildTestPacket(IPPROTO_ICMP, id, 152 >> 3, 1, 'O', 8);
-+    packets[14] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 152 >> 3, 1, 'O', 8);
- 
-     /* P*8 at 160. */
--    packets[15] = BuildTestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'P', 8);
-+    packets[15] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'P', 8);
- 
-     /* Q*16 at 176. */
--    packets[16] = BuildTestPacket(IPPROTO_ICMP, id, 176 >> 3, 0, 'Q', 16);
-+    packets[16] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 176 >> 3, 0, 'Q', 16);
- 
-     default_policy = policy;
- 
-@@ -1588,8 +1588,7 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
-     PASS;
- }
- 
--static int IPV6DefragDoSturgesNovakTest(int policy, u_char *expected,
--        size_t expected_len)
-+static int DefragDoSturgesNovakIpv6Test(int policy, u_char *expected, size_t expected_len)
- {
-     int i;
- 
-@@ -1608,59 +1607,59 @@ static int IPV6DefragDoSturgesNovakTest(int policy, u_char *expected,
-      */
- 
-     /* A*24 at 0. */
--    packets[0] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 24);
-+    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 24);
- 
-     /* B*15 at 32. */
--    packets[1] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 32 >> 3, 1, 'B', 16);
-+    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 32 >> 3, 1, 'B', 16);
- 
-     /* C*24 at 48. */
--    packets[2] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'C', 24);
-+    packets[2] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'C', 24);
- 
-     /* D*8 at 80. */
--    packets[3] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 80 >> 3, 1, 'D', 8);
-+    packets[3] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 80 >> 3, 1, 'D', 8);
- 
-     /* E*16 at 104. */
--    packets[4] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 104 >> 3, 1, 'E', 16);
-+    packets[4] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 104 >> 3, 1, 'E', 16);
- 
-     /* F*24 at 120. */
--    packets[5] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 120 >> 3, 1, 'F', 24);
-+    packets[5] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 120 >> 3, 1, 'F', 24);
- 
-     /* G*16 at 144. */
--    packets[6] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 144 >> 3, 1, 'G', 16);
-+    packets[6] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 144 >> 3, 1, 'G', 16);
- 
-     /* H*16 at 160. */
--    packets[7] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'H', 16);
-+    packets[7] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'H', 16);
- 
-     /* I*8 at 176. */
--    packets[8] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 1, 'I', 8);
-+    packets[8] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 1, 'I', 8);
- 
-     /*
-      * Overlapping subsequent fragments.
-      */
- 
-     /* J*32 at 8. */
--    packets[9] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 8 >> 3, 1, 'J', 32);
-+    packets[9] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 8 >> 3, 1, 'J', 32);
- 
-     /* K*24 at 48. */
--    packets[10] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'K', 24);
-+    packets[10] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'K', 24);
- 
-     /* L*24 at 72. */
--    packets[11] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 72 >> 3, 1, 'L', 24);
-+    packets[11] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 72 >> 3, 1, 'L', 24);
- 
-     /* M*24 at 96. */
--    packets[12] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 96 >> 3, 1, 'M', 24);
-+    packets[12] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 96 >> 3, 1, 'M', 24);
- 
-     /* N*8 at 128. */
--    packets[13] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 128 >> 3, 1, 'N', 8);
-+    packets[13] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 128 >> 3, 1, 'N', 8);
- 
-     /* O*8 at 152. */
--    packets[14] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 152 >> 3, 1, 'O', 8);
-+    packets[14] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 152 >> 3, 1, 'O', 8);
- 
-     /* P*8 at 160. */
--    packets[15] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'P', 8);
-+    packets[15] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'P', 8);
- 
-     /* Q*16 at 176. */
--    packets[16] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 0, 'Q', 16);
-+    packets[16] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 0, 'Q', 16);
- 
-     default_policy = policy;
- 
-@@ -1735,7 +1734,7 @@ DefragSturgesNovakBsdTest(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakBsdTest(void)
-+static int DefragSturgesNovakBsdIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -1765,8 +1764,7 @@ static int IPV6DefragSturgesNovakBsdTest(void)
-         "QQQQQQQQ"
-     };
- 
--    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_BSD, expected,
--                    sizeof(expected)));
-+    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_BSD, expected, sizeof(expected)));
-     PASS;
- }
- 
-@@ -1805,7 +1803,7 @@ static int DefragSturgesNovakLinuxIpv4Test(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakLinuxTest(void)
-+static int DefragSturgesNovakLinuxIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -1835,8 +1833,7 @@ static int IPV6DefragSturgesNovakLinuxTest(void)
-         "QQQQQQQQ"
-     };
- 
--    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_LINUX, expected,
--            sizeof(expected)));
-+    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_LINUX, expected, sizeof(expected)));
-     PASS;
- }
- 
-@@ -1875,7 +1872,7 @@ static int DefragSturgesNovakWindowsIpv4Test(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakWindowsTest(void)
-+static int DefragSturgesNovakWindowsIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -1905,8 +1902,7 @@ static int IPV6DefragSturgesNovakWindowsTest(void)
-         "QQQQQQQQ"
-     };
- 
--    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_WINDOWS, expected,
--                    sizeof(expected)));
-+    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_WINDOWS, expected, sizeof(expected)));
-     PASS;
- }
- 
-@@ -1945,7 +1941,7 @@ static int DefragSturgesNovakSolarisTest(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakSolarisTest(void)
-+static int DefragSturgesNovakSolarisIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -1975,8 +1971,7 @@ static int IPV6DefragSturgesNovakSolarisTest(void)
-         "QQQQQQQQ"
-     };
- 
--    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_SOLARIS, expected,
--                    sizeof(expected)));
-+    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_SOLARIS, expected, sizeof(expected)));
-     PASS;
- }
- 
-@@ -2015,7 +2010,7 @@ static int DefragSturgesNovakFirstTest(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakFirstTest(void)
-+static int DefragSturgesNovakFirstIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -2045,8 +2040,7 @@ static int IPV6DefragSturgesNovakFirstTest(void)
-         "QQQQQQQQ"
-     };
- 
--    return IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_FIRST, expected,
--        sizeof(expected));
-+    return DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_FIRST, expected, sizeof(expected));
- }
- 
- static int
-@@ -2085,7 +2079,7 @@ DefragSturgesNovakLastTest(void)
-     PASS;
- }
- 
--static int IPV6DefragSturgesNovakLastTest(void)
-+static int DefragSturgesNovakLastIpv6Test(void)
- {
-     /* Expected data. */
-     u_char expected[] = {
-@@ -2115,8 +2109,7 @@ static int IPV6DefragSturgesNovakLastTest(void)
-         "QQQQQQQQ"
-     };
- 
--    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_LAST, expected,
--                    sizeof(expected)));
-+    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_LAST, expected, sizeof(expected)));
-     PASS;
- }
- 
-@@ -2131,7 +2124,7 @@ static int DefragTimeoutTest(void)
- 
-     /* Load in 16 packets. */
-     for (i = 0; i < 16; i++) {
--        Packet *p = BuildTestPacket(IPPROTO_ICMP,i, 0, 1, 'A' + i, 16);
-+        Packet *p = BuildIpv4TestPacket(IPPROTO_ICMP, i, 0, 1, 'A' + i, 16);
-         FAIL_IF_NULL(p);
- 
-         Packet *tp = Defrag(NULL, NULL, p);
-@@ -2141,7 +2134,7 @@ static int DefragTimeoutTest(void)
- 
-     /* Build a new packet but push the timestamp out by our timeout.
-      * This should force our previous fragments to be timed out. */
--    Packet *p = BuildTestPacket(IPPROTO_ICMP, 99, 0, 1, 'A' + i, 16);
-+    Packet *p = BuildIpv4TestPacket(IPPROTO_ICMP, 99, 0, 1, 'A' + i, 16);
-     FAIL_IF_NULL(p);
- 
-     p->ts = SCTIME_ADD_SECS(p->ts, defrag_context->timeout + 1);
-@@ -2166,7 +2159,7 @@ static int DefragTimeoutTest(void)
-  * fail.  The fix was simple, but this unit test is just to make sure
-  * its not introduced.
-  */
--static int DefragIPv4NoDataTest(void)
-+static int DefragNoDataIpv4Test(void)
- {
-     DefragContext *dc = NULL;
-     Packet *p = NULL;
-@@ -2178,7 +2171,7 @@ static int DefragIPv4NoDataTest(void)
-     FAIL_IF_NULL(dc);
- 
-     /* This packet has an offset > 0, more frags set to 0 and no data. */
--    p = BuildTestPacket(IPPROTO_ICMP, id, 1, 0, 'A', 0);
-+    p = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 0, 'A', 0);
-     FAIL_IF_NULL(p);
- 
-     /* We do not expect a packet returned. */
-@@ -2195,7 +2188,7 @@ static int DefragIPv4NoDataTest(void)
-     PASS;
- }
- 
--static int DefragIPv4TooLargeTest(void)
-+static int DefragTooLargeIpv4Test(void)
- {
-     DefragContext *dc = NULL;
-     Packet *p = NULL;
-@@ -2207,7 +2200,7 @@ static int DefragIPv4TooLargeTest(void)
- 
-     /* Create a fragment that would extend past the max allowable size
-      * for an IPv4 packet. */
--    p = BuildTestPacket(IPPROTO_ICMP, 1, 8183, 0, 'A', 71);
-+    p = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 8183, 0, 'A', 71);
-     FAIL_IF_NULL(p);
- 
-     /* We do not expect a packet returned. */
-@@ -2238,9 +2231,9 @@ static int DefragVlanTest(void)
- 
-     DefragInit();
- 
--    p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-+    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-     FAIL_IF_NULL(p2);
- 
-     /* With no VLAN IDs set, packets should re-assemble. */
-@@ -2270,9 +2263,9 @@ static int DefragVlanQinQTest(void)
- 
-     DefragInit();
- 
--    p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-+    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-     FAIL_IF_NULL(p2);
- 
-     /* With no VLAN IDs set, packets should re-assemble. */
-@@ -2304,9 +2297,9 @@ static int DefragVlanQinQinQTest(void)
- 
-     DefragInit();
- 
--    Packet *p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-+    Packet *p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    Packet *p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-+    Packet *p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
-     FAIL_IF_NULL(p2);
- 
-     /* With no VLAN IDs set, packets should re-assemble. */
-@@ -2340,7 +2333,7 @@ static int DefragTrackerReuseTest(void)
- 
-     /* Build a packet, its not a fragment but shouldn't matter for
-      * this test. */
--    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 0, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 0, 'A', 8);
-     FAIL_IF_NULL(p1);
- 
-     /* Get a tracker. It shouldn't look like its already in use. */
-@@ -2387,9 +2380,9 @@ static int DefragMfIpv4Test(void)
- 
-     DefragInit();
- 
--    Packet *p1 = BuildTestPacket(IPPROTO_ICMP, ip_id, 2, 1, 'C', 8);
--    Packet *p2 = BuildTestPacket(IPPROTO_ICMP, ip_id, 0, 1, 'A', 8);
--    Packet *p3 = BuildTestPacket(IPPROTO_ICMP, ip_id, 1, 0, 'B', 8);
-+    Packet *p1 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 2, 1, 'C', 8);
-+    Packet *p2 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 0, 1, 'A', 8);
-+    Packet *p3 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 1, 0, 'B', 8);
-     FAIL_IF(p1 == NULL || p2 == NULL || p3 == NULL);
- 
-     p = Defrag(NULL, NULL, p1);
-@@ -2434,9 +2427,9 @@ static int DefragMfIpv6Test(void)
- 
-     DefragInit();
- 
--    Packet *p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 2, 1, 'C', 8);
--    Packet *p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 0, 1, 'A', 8);
--    Packet *p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 1, 0, 'B', 8);
-+    Packet *p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 2, 1, 'C', 8);
-+    Packet *p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 0, 1, 'A', 8);
-+    Packet *p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 1, 0, 'B', 8);
-     FAIL_IF(p1 == NULL || p2 == NULL || p3 == NULL);
- 
-     p = Defrag(NULL, NULL, p1);
-@@ -2476,11 +2469,11 @@ static int DefragTestBadProto(void)
- 
-     DefragInit();
- 
--    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-+    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
-     FAIL_IF_NULL(p1);
--    p2 = BuildTestPacket(IPPROTO_UDP, id, 1, 1, 'B', 8);
-+    p2 = BuildIpv4TestPacket(IPPROTO_UDP, id, 1, 1, 'B', 8);
-     FAIL_IF_NULL(p2);
--    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-+    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
-     FAIL_IF_NULL(p3);
- 
-     FAIL_IF_NOT_NULL(Defrag(NULL, NULL, p1));
-@@ -2522,10 +2515,10 @@ static int DefragTestJeremyLinux(void)
-     Packet *packets[4];
-     int i = 0;
- 
--    packets[0] = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
--    packets[1] = BuildTestPacket(IPPROTO_ICMP, id, 40 >> 3, 1, 'B', 48);
--    packets[2] = BuildTestPacket(IPPROTO_ICMP, id, 24 >> 3, 1, 'C', 48);
--    packets[3] = BuildTestPacket(IPPROTO_ICMP, id, 88 >> 3, 0, 'D', 14);
-+    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
-+    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 40 >> 3, 1, 'B', 48);
-+    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 24 >> 3, 1, 'C', 48);
-+    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 88 >> 3, 0, 'D', 14);
- 
-     Packet *r = Defrag(NULL, NULL, packets[0]);
-     FAIL_IF_NOT_NULL(r);
-@@ -2657,23 +2650,17 @@ void DefragRegisterTests(void)
-     UtRegisterTest("DefragSturgesNovakFirstTest", DefragSturgesNovakFirstTest);
-     UtRegisterTest("DefragSturgesNovakLastTest", DefragSturgesNovakLastTest);
- 
--    UtRegisterTest("DefragIPv4NoDataTest", DefragIPv4NoDataTest);
--    UtRegisterTest("DefragIPv4TooLargeTest", DefragIPv4TooLargeTest);
--
--    UtRegisterTest("IPV6DefragInOrderSimpleTest", IPV6DefragInOrderSimpleTest);
--    UtRegisterTest("IPV6DefragReverseSimpleTest", IPV6DefragReverseSimpleTest);
--    UtRegisterTest("IPV6DefragSturgesNovakBsdTest",
--                   IPV6DefragSturgesNovakBsdTest);
--    UtRegisterTest("IPV6DefragSturgesNovakLinuxTest",
--                   IPV6DefragSturgesNovakLinuxTest);
--    UtRegisterTest("IPV6DefragSturgesNovakWindowsTest",
--                   IPV6DefragSturgesNovakWindowsTest);
--    UtRegisterTest("IPV6DefragSturgesNovakSolarisTest",
--                   IPV6DefragSturgesNovakSolarisTest);
--    UtRegisterTest("IPV6DefragSturgesNovakFirstTest",
--                   IPV6DefragSturgesNovakFirstTest);
--    UtRegisterTest("IPV6DefragSturgesNovakLastTest",
--                   IPV6DefragSturgesNovakLastTest);
-+    UtRegisterTest("DefragNoDataIpv4Test", DefragNoDataIpv4Test);
-+    UtRegisterTest("DefragTooLargeIpv4Test", DefragTooLargeIpv4Test);
-+
-+    UtRegisterTest("DefragInOrderSimpleIpv6Test", DefragInOrderSimpleIpv6Test);
-+    UtRegisterTest("DefragReverseSimpleIpv6Test", DefragReverseSimpleIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakBsdIpv6Test", DefragSturgesNovakBsdIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakLinuxIpv6Test", DefragSturgesNovakLinuxIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakWindowsIpv6Test", DefragSturgesNovakWindowsIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakSolarisIpv6Test", DefragSturgesNovakSolarisIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakFirstIpv6Test", DefragSturgesNovakFirstIpv6Test);
-+    UtRegisterTest("DefragSturgesNovakLastIpv6Test", DefragSturgesNovakLastIpv6Test);
- 
-     UtRegisterTest("DefragVlanTest", DefragVlanTest);
-     UtRegisterTest("DefragVlanQinQTest", DefragVlanQinQTest);
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-003.patch b/recipes-ids/suricata/files/CVE-2024-32867-003.patch
deleted file mode 100644
index 15ee1f4..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32867-003.patch
+++ /dev/null
@@ -1,472 +0,0 @@
-From 1e110d0a71db46571040b937e17a4bc9f91d6de9 Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Thu, 7 Dec 2023 16:44:56 -0600
-Subject: [PATCH] defrag: fix subsequent overlap of start of original (bsd)
-
-Fix the BSD policy case where a subsequent fragment starts before an
-original fragment and overlaps the beginning of the original
-fragment. In this case the overlapping data from the new fragment is
-preferred.
-
-Suricata was preferring the data from the original fragment, but it
-should only do that when the original fragment has an offset <= to the
-new fragment.
-
-- Adds test for this case
-
-Bug: #6669
-(cherry picked from commit f1709ea551124e1a64fdc509993ad022ab27aa77)
-
-CVE: CVE-2024-32867
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/1e110d0a71db46571040b937e17a4bc9f91d6de9]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/defrag.c | 387 ++++++++++++++++++++++++++++++++++++++++++++++++++-
- 1 file changed, 380 insertions(+), 7 deletions(-)
-
-diff --git a/src/defrag.c b/src/defrag.c
-index 99fbab3..28d085d 100644
---- a/src/defrag.c
-+++ b/src/defrag.c
-@@ -692,16 +692,45 @@ DefragInsertFrag(ThreadVars *tv, DecodeThreadVars *dtv, DefragTracker *tracker,
-             switch (tracker->policy) {
-             case DEFRAG_POLICY_BSD:
-                 if (frag_offset < prev->offset + prev->data_len) {
--                    if (frag_offset >= prev->offset) {
--                        ltrim = prev->offset + prev->data_len - frag_offset;
-+                    if (prev->offset <= frag_offset) {
-+                        /* We prefer the data from the previous
-+                         * fragment, so trim off the data in the new
-+                         * fragment that exists in the previous
-+                         * fragment. */
-+                        uint16_t prev_end = prev->offset + prev->data_len;
-+                        if (prev_end > frag_end) {
-+                            /* Just skip. */
-+                            /* TODO: Set overlap flag. */
-+                            goto done;
-+                        }
-+                        ltrim = prev_end - frag_offset;
-+
-+                        if ((next != NULL) && (frag_end > next->offset)) {
-+                            next->ltrim = frag_end - next->offset;
-+                        }
-+
-+                        goto insert;
-                     }
-+
-+                    /* If the end of this fragment overlaps the start
-+                     * of the previous fragment, then trim up the
-+                     * start of previous fragment so this fragment is
-+                     * used.
-+                     *
-+                     * See:
-+                     * DefragBsdSubsequentOverlapsStartOfOriginal.
-+                     */
-+                    if (frag_offset <= prev->offset && frag_end > prev->offset + prev->ltrim) {
-+                        uint16_t prev_ltrim = frag_end - prev->offset;
-+                        if (prev_ltrim > prev->ltrim) {
-+                            prev->ltrim = prev_ltrim;
-+                        }
-+                    }
-+
-                     if ((next != NULL) && (frag_end > next->offset)) {
-                         next->ltrim = frag_end - next->offset;
-                     }
--                    if ((frag_offset < prev->offset) &&
--                        (frag_end >= prev->offset + prev->data_len)) {
--                        prev->skip = 1;
--                    }
-+
-                     goto insert;
-                 }
-                 break;
-@@ -1199,6 +1228,77 @@ error:
-     return NULL;
- }
- 
-+/**
-+ * Allocate a test packet, much like BuildIpv4TestPacket, but with
-+ * the full content provided by the caller.
-+ */
-+static Packet *BuildIpv4TestPacketWithContent(
-+        uint8_t proto, uint16_t id, uint16_t off, int mf, const uint8_t *content, int content_len)
-+{
-+    Packet *p = NULL;
-+    int hlen = 20;
-+    int ttl = 64;
-+    IPV4Hdr ip4h;
-+
-+    p = SCCalloc(1, sizeof(*p) + default_packet_size);
-+    if (unlikely(p == NULL))
-+        return NULL;
-+
-+    PacketInit(p);
-+
-+    struct timeval tval;
-+    gettimeofday(&tval, NULL);
-+    p->ts = SCTIME_FROM_TIMEVAL(&tval);
-+    ip4h.ip_verhl = 4 << 4;
-+    ip4h.ip_verhl |= hlen >> 2;
-+    ip4h.ip_len = htons(hlen + content_len);
-+    ip4h.ip_id = htons(id);
-+    if (mf)
-+        ip4h.ip_off = htons(IP_MF | off);
-+    else
-+        ip4h.ip_off = htons(off);
-+    ip4h.ip_ttl = ttl;
-+    ip4h.ip_proto = proto;
-+
-+    ip4h.s_ip_src.s_addr = 0x01010101; /* 1.1.1.1 */
-+    ip4h.s_ip_dst.s_addr = 0x02020202; /* 2.2.2.2 */
-+
-+    /* copy content_len crap, we need full length */
-+    PacketCopyData(p, (uint8_t *)&ip4h, sizeof(ip4h));
-+    p->ip4h = (IPV4Hdr *)GET_PKT_DATA(p);
-+    SET_IPV4_SRC_ADDR(p, &p->src);
-+    SET_IPV4_DST_ADDR(p, &p->dst);
-+
-+    PacketCopyDataOffset(p, hlen, content, content_len);
-+    SET_PKT_LEN(p, hlen + content_len);
-+
-+    p->ip4h->ip_csum = IPV4Checksum((uint16_t *)GET_PKT_DATA(p), hlen, 0);
-+
-+    /* Self test. */
-+    if (IPV4_GET_VER(p) != 4)
-+        goto error;
-+    if (IPV4_GET_HLEN(p) != hlen)
-+        goto error;
-+    if (IPV4_GET_IPLEN(p) != hlen + content_len)
-+        goto error;
-+    if (IPV4_GET_IPID(p) != id)
-+        goto error;
-+    if (IPV4_GET_IPOFFSET(p) != off)
-+        goto error;
-+    if (IPV4_GET_MF(p) != mf)
-+        goto error;
-+    if (IPV4_GET_IPTTL(p) != ttl)
-+        goto error;
-+    if (IPV4_GET_IPPROTO(p) != proto)
-+        goto error;
-+
-+    return p;
-+error:
-+    if (p != NULL)
-+        SCFree(p);
-+    return NULL;
-+}
-+
- static Packet *BuildIpv6TestPacket(
-         uint8_t proto, uint32_t id, uint16_t off, int mf, const char content, int content_len)
- {
-@@ -1270,6 +1370,71 @@ error:
-     return NULL;
- }
- 
-+static Packet *BuildIpv6TestPacketWithContent(
-+        uint8_t proto, uint32_t id, uint16_t off, int mf, const uint8_t *content, int content_len)
-+{
-+    Packet *p = NULL;
-+    IPV6Hdr ip6h;
-+
-+    p = SCCalloc(1, sizeof(*p) + default_packet_size);
-+    if (unlikely(p == NULL))
-+        return NULL;
-+
-+    PacketInit(p);
-+
-+    struct timeval tval;
-+    gettimeofday(&tval, NULL);
-+    p->ts = SCTIME_FROM_TIMEVAL(&tval);
-+
-+    ip6h.s_ip6_nxt = 44;
-+    ip6h.s_ip6_hlim = 2;
-+
-+    /* Source and dest address - very bogus addresses. */
-+    ip6h.s_ip6_src[0] = 0x01010101;
-+    ip6h.s_ip6_src[1] = 0x01010101;
-+    ip6h.s_ip6_src[2] = 0x01010101;
-+    ip6h.s_ip6_src[3] = 0x01010101;
-+    ip6h.s_ip6_dst[0] = 0x02020202;
-+    ip6h.s_ip6_dst[1] = 0x02020202;
-+    ip6h.s_ip6_dst[2] = 0x02020202;
-+    ip6h.s_ip6_dst[3] = 0x02020202;
-+
-+    /* copy content_len crap, we need full length */
-+    PacketCopyData(p, (uint8_t *)&ip6h, sizeof(IPV6Hdr));
-+
-+    p->ip6h = (IPV6Hdr *)GET_PKT_DATA(p);
-+    IPV6_SET_RAW_VER(p->ip6h, 6);
-+    /* Fragmentation header. */
-+    IPV6FragHdr *fh = (IPV6FragHdr *)(GET_PKT_DATA(p) + sizeof(IPV6Hdr));
-+    fh->ip6fh_nxt = proto;
-+    fh->ip6fh_ident = htonl(id);
-+    fh->ip6fh_offlg = htons((off << 3) | mf);
-+
-+    DecodeIPV6FragHeader(p, (uint8_t *)fh, 8, 8 + content_len, 0);
-+
-+    PacketCopyDataOffset(p, sizeof(IPV6Hdr) + sizeof(IPV6FragHdr), content, content_len);
-+    SET_PKT_LEN(p, sizeof(IPV6Hdr) + sizeof(IPV6FragHdr) + content_len);
-+
-+    p->ip6h->s_ip6_plen = htons(sizeof(IPV6FragHdr) + content_len);
-+
-+    SET_IPV6_SRC_ADDR(p, &p->src);
-+    SET_IPV6_DST_ADDR(p, &p->dst);
-+
-+    /* Self test. */
-+    if (IPV6_GET_VER(p) != 6)
-+        goto error;
-+    if (IPV6_GET_NH(p) != 44)
-+        goto error;
-+    if (IPV6_GET_PLEN(p) != sizeof(IPV6FragHdr) + content_len)
-+        goto error;
-+
-+    return p;
-+error:
-+    if (p != NULL)
-+        SCFree(p);
-+    return NULL;
-+}
-+
- /**
-  * Test the simplest possible re-assembly scenario.  All packet in
-  * order and no overlaps.
-@@ -1575,7 +1740,13 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
-     FAIL_IF(IPV4_GET_HLEN(reassembled) != 20);
-     FAIL_IF(IPV4_GET_IPLEN(reassembled) != 20 + 192);
- 
--    FAIL_IF(memcmp(GET_PKT_DATA(reassembled) + 20, expected, expected_len) != 0);
-+    if (memcmp(expected, GET_PKT_DATA(reassembled) + 20, expected_len) != 0) {
-+        printf("Expected:\n");
-+        PrintRawDataFp(stdout, expected, expected_len);
-+        printf("Got:\n");
-+        PrintRawDataFp(stdout, GET_PKT_DATA(reassembled) + 20, GET_PKT_LEN(reassembled) - 20);
-+        FAIL;
-+    }
-     SCFree(reassembled);
- 
-     /* Make sure all frags were returned back to the pool. */
-@@ -2543,6 +2714,16 @@ static int DefragTestJeremyLinux(void)
-     PASS;
- }
- 
-+/**
-+ * | 0        | 8        | 16       | 24       | 32       |
-+ * |----------|----------|----------|----------|----------|
-+ * |                                  AAAAAAAA | AAAAAAAA |
-+ * |          | BBBBBBBB | BBBBBBBB |          |          |
-+ * |          |          | CCCCCCCC | CCCCCCCC |          |
-+ * | DDDDDDDD |          |          |          |          |
-+ *
-+ * | DDDDDDDD | BBBBBBBB | BBBBBBBB | CCCCCCCC | AAAAAAAA |
-+ */
- static int DefragBsdFragmentAfterNoMfIpv4Test(void)
- {
-     DefragInit();
-@@ -2633,6 +2814,192 @@ static int DefragBsdFragmentAfterNoMfIpv6Test(void)
-     PASS;
- }
- 
-+static int DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[4];
-+
-+    /* Packet 1: off=16, mf=1 */
-+    packets[0] = BuildIpv4TestPacketWithContent(
-+            IPPROTO_ICMP, 6, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
-+
-+    /* Packet 2: off=8, mf=1 */
-+    packets[1] = BuildIpv4TestPacketWithContent(
-+            IPPROTO_ICMP, 6, 8 >> 3, 1, (uint8_t *)"AACCBBDDAACCDDBB", 16);
-+
-+    /* Packet 3: off=0, mf=1: IP and ICMP header. */
-+    packets[2] = BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 6, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
-+
-+    /* Packet 4: off=8, mf=1 */
-+    packets[3] =
-+            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 6, 32 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    const uint8_t expected[] = {
-+	// AACCBBDD
-+	// AACCDDBB
-+	// AABBDDCC
-+	// DDCCBBAA
-+	'A', 'A', 'C', 'C', 'B', 'B', 'D', 'D',
-+	'A', 'A', 'C', 'C', 'D', 'D', 'B', 'B',
-+	'A', 'A', 'B', 'B', 'D', 'D', 'C', 'C',
-+	'D', 'D', 'C', 'C', 'B', 'B', 'A', 'A',
-+    };
-+    // clang-format on
-+
-+    FAIL_IF(memcmp(expected, GET_PKT_DATA(r) + 20 + 8, sizeof(expected)) != 0);
-+
-+    DefragDestroy();
-+    PASS;
-+}
-+
-+static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[4];
-+
-+    /* Packet 1: off=16, mf=1 */
-+    packets[0] = BuildIpv6TestPacketWithContent(
-+            IPPROTO_ICMP, 6, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
-+
-+    /* Packet 2: off=8, mf=1 */
-+    packets[1] = BuildIpv6TestPacketWithContent(
-+            IPPROTO_ICMP, 6, 8 >> 3, 1, (uint8_t *)"AACCBBDDAACCDDBB", 16);
-+
-+    /* Packet 3: off=0, mf=1: IP and ICMP header. */
-+    packets[2] = BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 6, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
-+
-+    /* Packet 4: off=8, mf=1 */
-+    packets[3] =
-+            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 6, 32 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    const uint8_t expected[] = {
-+	// AACCBBDD
-+	// AACCDDBB
-+	// AABBDDCC
-+	// DDCCBBAA
-+	'A', 'A', 'C', 'C', 'B', 'B', 'D', 'D',
-+	'A', 'A', 'C', 'C', 'D', 'D', 'B', 'B',
-+	'A', 'A', 'B', 'B', 'D', 'D', 'C', 'C',
-+	'D', 'D', 'C', 'C', 'B', 'B', 'A', 'A',
-+    };
-+    // clang-format on
-+
-+    FAIL_IF(memcmp(expected, GET_PKT_DATA(r) + 40 + 8, sizeof(expected)) != 0);
-+
-+    DefragDestroy();
-+    PASS;
-+}
-+
-+/**
-+ * #### Input
-+ *
-+ * | 96 (0)   | 104 (8)  | 112 (16) | 120 (24) |
-+ * |----------|----------|----------|----------|
-+ * |          | EEEEEEEE | EEEEEEEE | EEEEEEEE |
-+ * | MMMMMMMM | MMMMMMMM | MMMMMMMM |          |
-+ *
-+ * #### Expected Output
-+ *
-+ * | MMMMMMMM | MMMMMMMM | MMMMMMMM | EEEEEEEE |
-+ */
-+static int DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[2];
-+
-+    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 8 >> 3, 0, 'E', 24);
-+    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'M', 24);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    const uint8_t expected[] = {
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E',
-+    };
-+    // clang-format on
-+
-+    if (memcmp(expected, GET_PKT_DATA(r) + 20, sizeof(expected)) != 0) {
-+        printf("Expected:\n");
-+        PrintRawDataFp(stdout, expected, sizeof(expected));
-+        printf("Got:\n");
-+        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
-+        FAIL;
-+    }
-+
-+    PASS;
-+}
-+
-+static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[2];
-+
-+    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMP, 1, 8 >> 3, 0, 'E', 24);
-+    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMP, 1, 0, 1, 'M', 24);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NULL(r);
-+
-+    // clang-format off
-+    const uint8_t expected[] = {
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
-+	'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E',
-+    };
-+    // clang-format on
-+
-+    if (memcmp(expected, GET_PKT_DATA(r) + 40, sizeof(expected)) != 0) {
-+        printf("Expected:\n");
-+        PrintRawDataFp(stdout, expected, sizeof(expected));
-+        printf("Got:\n");
-+        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
-+        FAIL;
-+    }
-+
-+    PASS;
-+}
-+
- #endif /* UNITTESTS */
- 
- void DefragRegisterTests(void)
-@@ -2675,5 +3042,11 @@ void DefragRegisterTests(void)
- 
-     UtRegisterTest("DefragBsdFragmentAfterNoMfIpv4Test", DefragBsdFragmentAfterNoMfIpv4Test);
-     UtRegisterTest("DefragBsdFragmentAfterNoMfIpv6Test", DefragBsdFragmentAfterNoMfIpv6Test);
-+    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test",
-+            DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test);
-+    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test",
-+            DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test);
-+    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2);
-+    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2);
- #endif /* UNITTESTS */
- }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-004.patch b/recipes-ids/suricata/files/CVE-2024-32867-004.patch
deleted file mode 100644
index 7edb3b3..0000000
--- a/recipes-ids/suricata/files/CVE-2024-32867-004.patch
+++ /dev/null
@@ -1,169 +0,0 @@
-From e6267758ed5da27f804f0c1c07f9423bdf4d72b8 Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Fri, 12 Jan 2024 11:09:59 -0600
-Subject: [PATCH] defrag: fix check for complete packet
-
-The list of fragments may still contain overlaps, so adding up the
-fragment lengths is flawed. Instead track the largest size of
-contiguous data that can be re-assembled.
-
-Bug: #6675
-(cherry picked from commit d226d0a3fce8837936e1bdfaee496c80d417e0a5)
-
-CVE: CVE-2024-32867
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e6267758ed5da27f804f0c1c07f9423bdf4d72b8]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/defrag.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++-
- 1 file changed, 114 insertions(+), 2 deletions(-)
-
-diff --git a/src/defrag.c b/src/defrag.c
-index 28d085d..fc46411 100644
---- a/src/defrag.c
-+++ b/src/defrag.c
-@@ -276,7 +276,8 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-             goto done;
-         }
-         else {
--            len += frag->data_len;
-+            /* Update the packet length to the largest known data offset. */
-+            len = MAX(len, frag->offset + frag->data_len);
-         }
-     }
- 
-@@ -434,7 +435,7 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
-                 goto done;
-             }
-             else {
--                len += frag->data_len;
-+                len = MAX(len, frag->offset + frag->data_len);
-             }
-         }
-     }
-@@ -3000,6 +3001,115 @@ static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test(void)
-     PASS;
- }
- 
-+/**
-+ * Reassembly should fail.
-+ *
-+ * |0       |8       |16      |24      |32      |40      |48      |
-+ * |========|========|========|========|========|========|========|
-+ * |        |        |AABBCCDD|AABBDDCC|        |        |        |
-+ * |        |        |        |        |        |AACCBBDD|        |
-+ * |        |AACCDDBB|AADDBBCC|        |        |        |        |
-+ * |ZZZZZZZZ|        |        |        |        |        |        |
-+ * |        |        |        |        |        |        |DDCCBBAA|
-+ */
-+static int DefragBsdMissingFragmentIpv4Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[5];
-+
-+    packets[0] = BuildIpv4TestPacketWithContent(
-+            IPPROTO_ICMP, 189, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
-+
-+    packets[1] =
-+            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 40 >> 3, 1, (uint8_t *)"AACCBBDD", 8);
-+
-+    packets[2] = BuildIpv4TestPacketWithContent(
-+            IPPROTO_ICMP, 189, 8 >> 3, 1, (uint8_t *)"AACCDDBBAADDBBCC", 16);
-+
-+    /* ICMP header. */
-+    packets[3] = BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
-+
-+    packets[4] =
-+            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 48 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[4]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+#if 0
-+    PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
-+#endif
-+
-+    for (int i = 0; i < 5; i++) {
-+        SCFree(packets[i]);
-+    }
-+
-+    DefragDestroy();
-+
-+    PASS;
-+}
-+
-+static int DefragBsdMissingFragmentIpv6Test(void)
-+{
-+    DefragInit();
-+    default_policy = DEFRAG_POLICY_BSD;
-+    Packet *packets[5];
-+
-+    packets[0] = BuildIpv6TestPacketWithContent(
-+            IPPROTO_ICMP, 189, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
-+
-+    packets[1] =
-+            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 40 >> 3, 1, (uint8_t *)"AACCBBDD", 8);
-+
-+    packets[2] = BuildIpv6TestPacketWithContent(
-+            IPPROTO_ICMP, 189, 8 >> 3, 1, (uint8_t *)"AACCDDBBAADDBBCC", 16);
-+
-+    /* ICMP header. */
-+    packets[3] = BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
-+
-+    packets[4] =
-+            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 48 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
-+
-+    Packet *r = Defrag(NULL, NULL, packets[0]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[1]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[2]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[3]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+    r = Defrag(NULL, NULL, packets[4]);
-+    FAIL_IF_NOT_NULL(r);
-+
-+#if 0
-+    PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
-+#endif
-+
-+    for (int i = 0; i < 5; i++) {
-+        SCFree(packets[i]);
-+    }
-+
-+    DefragDestroy();
-+
-+    PASS;
-+}
-+
- #endif /* UNITTESTS */
- 
- void DefragRegisterTests(void)
-@@ -3048,5 +3158,7 @@ void DefragRegisterTests(void)
-             DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test);
-     UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2);
-     UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2);
-+    UtRegisterTest("DefragBsdMissingFragmentIpv4Test", DefragBsdMissingFragmentIpv4Test);
-+    UtRegisterTest("DefragBsdMissingFragmentIpv6Test", DefragBsdMissingFragmentIpv6Test);
- #endif /* UNITTESTS */
- }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-45795.patch b/recipes-ids/suricata/files/CVE-2024-45795.patch
deleted file mode 100644
index 10363c5..0000000
--- a/recipes-ids/suricata/files/CVE-2024-45795.patch
+++ /dev/null
@@ -1,123 +0,0 @@
-From 72456d359bf3064306b62024c809bb30b162f18c Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Mon, 12 Aug 2024 09:54:43 +0200
-Subject: [PATCH] detect/datasets: implement unset command
-
-Ticket: 7195
-
-Otherwise, Suricata aborted on such a rule
-
-(cherry picked from commit e47598110a557bb9f87ea498d85ba91a45bb0cb6)
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/72456d359bf3064306b62024c809bb30b162f18c && https://github.com/OISF/suricata/commit/96d5c81aed01f2bc0cd3e2e60057d0deb38caa99]
-CVE: CVE-2024-45795
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- doc/userguide/rules/datasets.rst |  2 +-
- src/datasets.c                   | 20 ++++++++++++++++++++
- src/datasets.h                   |  1 +
- src/detect-dataset.c             | 11 +++++++++++
- src/detect-dataset.h             |  5 -----
- 5 files changed, 33 insertions(+), 6 deletions(-)
-
-diff --git a/doc/userguide/rules/datasets.rst b/doc/userguide/rules/datasets.rst
-index 647b12e..dd9ecd2 100644
---- a/doc/userguide/rules/datasets.rst
-+++ b/doc/userguide/rules/datasets.rst
-@@ -78,7 +78,7 @@ Syntax::
- 
-     dataset:<cmd>,<name>,<options>;
- 
--    dataset:<set|isset|isnotset>,<name> \
-+    dataset:<set|unset|isset|isnotset>,<name> \
-         [, type <string|md5|sha256|ipv4|ip>, save <file name>, load <file name>, state <file name>, memcap <size>, hashsize <size>];
- 
- type <type>
-diff --git a/src/datasets.c b/src/datasets.c
-index d89ed8d..32bcf6e 100644
---- a/src/datasets.c
-+++ b/src/datasets.c
-@@ -1741,3 +1741,23 @@ int DatasetRemoveSerialized(Dataset *set, const char *string)
-     return DatasetOpSerialized(set, string, DatasetRemoveString, DatasetRemoveMd5,
-             DatasetRemoveSha256, DatasetRemoveIPv4, DatasetRemoveIPv6);
- }
-+
-+int DatasetRemove(Dataset *set, const uint8_t *data, const uint32_t data_len)
-+{
-+    if (set == NULL)
-+        return -1;
-+
-+    switch (set->type) {
-+        case DATASET_TYPE_STRING:
-+            return DatasetRemoveString(set, data, data_len);
-+        case DATASET_TYPE_MD5:
-+            return DatasetRemoveMd5(set, data, data_len);
-+        case DATASET_TYPE_SHA256:
-+            return DatasetRemoveSha256(set, data, data_len);
-+        case DATASET_TYPE_IPV4:
-+            return DatasetRemoveIPv4(set, data, data_len);
-+        case DATASET_TYPE_IPV6:
-+            return DatasetRemoveIPv6(set, data, data_len);
-+    }
-+    return -1;
-+}
-diff --git a/src/datasets.h b/src/datasets.h
-index af4fc17..0f28a9f 100644
---- a/src/datasets.h
-+++ b/src/datasets.h
-@@ -56,6 +56,7 @@ Dataset *DatasetFind(const char *name, enum DatasetTypes type);
- Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save, const char *load,
-         uint64_t memcap, uint32_t hashsize);
- int DatasetAdd(Dataset *set, const uint8_t *data, const uint32_t data_len);
-+int DatasetRemove(Dataset *set, const uint8_t *data, const uint32_t data_len);
- int DatasetLookup(Dataset *set, const uint8_t *data, const uint32_t data_len);
- DataRepResultType DatasetLookupwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
-         const DataRepType *rep);
-diff --git a/src/detect-dataset.c b/src/detect-dataset.c
-index 3d29646..aad5cf0 100644
---- a/src/detect-dataset.c
-+++ b/src/detect-dataset.c
-@@ -41,6 +41,11 @@
- #include "util-path.h"
- #include "util-conf.h"
- 
-+#define DETECT_DATASET_CMD_SET      0
-+#define DETECT_DATASET_CMD_UNSET    1
-+#define DETECT_DATASET_CMD_ISNOTSET 2
-+#define DETECT_DATASET_CMD_ISSET    3
-+
- int DetectDatasetMatch (ThreadVars *, DetectEngineThreadCtx *, Packet *,
-         const Signature *, const SigMatchCtx *);
- static int DetectDatasetSetup (DetectEngineCtx *, Signature *, const char *);
-@@ -91,6 +96,12 @@ int DetectDatasetBufferMatch(DetectEngineThreadCtx *det_ctx,
-                 return 1;
-             break;
-         }
-+        case DETECT_DATASET_CMD_UNSET: {
-+            int r = DatasetRemove(sd->set, data, data_len);
-+            if (r == 1)
-+                return 1;
-+            break;
-+        }
-         default:
-             abort();
-     }
-diff --git a/src/detect-dataset.h b/src/detect-dataset.h
-index ca83267..d243552 100644
---- a/src/detect-dataset.h
-+++ b/src/detect-dataset.h
-@@ -26,11 +26,6 @@
- 
- #include "datasets.h"
- 
--#define DETECT_DATASET_CMD_SET      0
--#define DETECT_DATASET_CMD_UNSET    1
--#define DETECT_DATASET_CMD_ISNOTSET 2
--#define DETECT_DATASET_CMD_ISSET    3
--
- typedef struct DetectDatasetData_ {
-     Dataset *set;
-     uint8_t cmd;
--- 
-2.25.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-45796.patch b/recipes-ids/suricata/files/CVE-2024-45796.patch
deleted file mode 100644
index ae00a5f..0000000
--- a/recipes-ids/suricata/files/CVE-2024-45796.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From 9203656496c4081260817cce018a0d8fd57869b5 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Mon, 15 Jul 2024 09:52:00 +0200
-Subject: [PATCH] defrag: fix off by one
-
-Ticket: 7067
-
-This off by one could lead to an empty fragment being inserted
-in the rb tree, which led to integer underflow.
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/9203656496c4081260817cce018a0d8fd57869b5]
-CVE: CVE-2024-45796
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/defrag.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/src/defrag.c b/src/defrag.c
-index 71cf420..38704c9 100644
---- a/src/defrag.c
-+++ b/src/defrag.c
-@@ -808,7 +808,7 @@ DefragInsertFrag(ThreadVars *tv, DecodeThreadVars *dtv, DefragTracker *tracker,
-         }
-     }
- 
--    if (ltrim > data_len) {
-+    if (ltrim >= data_len) {
-         /* Full packet has been trimmed due to the overlap policy. Overlap
-          * already set. */
-         goto done;
--- 
-2.25.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-45797.patch b/recipes-ids/suricata/files/CVE-2024-45797.patch
deleted file mode 100644
index 3db4625..0000000
--- a/recipes-ids/suricata/files/CVE-2024-45797.patch
+++ /dev/null
@@ -1,148 +0,0 @@
-From 0d550de551b91d5e57ba23e2b1e2c6430fad6818 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <contact@catenacyber.fr>
-Date: Mon, 12 Aug 2024 14:06:40 +0200
-Subject: [PATCH] headers: put a configurable limit on their numbers
-
-So as to avoid quadratic complexity
-
-Ticket: 7191
-
-Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/0d550de551b91d5e57ba23e2b1e2c6430fad6818]
-CVE: CVE-2024-45797
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- htp/htp_config.c           |  8 ++++++++
- htp/htp_config.h           |  8 ++++++++
- htp/htp_config_private.h   |  6 ++++++
- htp/htp_core.h             |  1 +
- htp/htp_request_generic.c  | 11 +++++++++++
- htp/htp_response_generic.c | 10 ++++++++++
- 6 files changed, 44 insertions(+)
-
-diff --git a/htp/htp_config.c b/htp/htp_config.c
-index 767458f..9e0eee3 100644
---- a/htp/htp_config.c
-+++ b/htp/htp_config.c
-@@ -145,6 +145,8 @@ static unsigned char bestfit_1252[] = {
-     0xff, 0x5d, 0x7d, 0xff, 0x5e, 0x7e, 0x00, 0x00, 0x00
- };
- 
-+#define HTP_HEADERS_LIMIT 1024
-+
- htp_cfg_t *htp_config_create(void) {
-     htp_cfg_t *cfg = calloc(1, sizeof (htp_cfg_t));
-     if (cfg == NULL) return NULL;
-@@ -163,6 +165,7 @@ htp_cfg_t *htp_config_create(void) {
-     cfg->response_lzma_layer_limit = 1; // default is only one layer
-     cfg->compression_bomb_limit = HTP_COMPRESSION_BOMB_LIMIT;
-     cfg->compression_time_limit = HTP_COMPRESSION_TIME_LIMIT_USEC;
-+    cfg->number_headers_limit = HTP_HEADERS_LIMIT;
-     cfg->allow_space_uri = 0;
- 
-     // Default settings for URL-encoded data.
-@@ -542,6 +545,11 @@ void htp_config_set_compression_time_limit(htp_cfg_t *cfg, size_t useclimit) {
-     }
- }
- 
-+void htp_config_set_number_headers_limit(htp_cfg_t *cfg, uint32_t limit) {
-+    if (cfg == NULL) return;
-+    cfg->number_headers_limit = limit;
-+}
-+
- void htp_config_set_log_level(htp_cfg_t *cfg, enum htp_log_level_t log_level) {
-     if (cfg == NULL) return;
-     cfg->log_level = log_level;
-diff --git a/htp/htp_config.h b/htp/htp_config.h
-index d1365dc..ed0eaeb 100644
---- a/htp/htp_config.h
-+++ b/htp/htp_config.h
-@@ -466,6 +466,14 @@ void htp_config_set_compression_time_limit(htp_cfg_t *cfg, size_t useclimit);
-  */
- void htp_config_set_log_level(htp_cfg_t *cfg, enum htp_log_level_t log_level);
- 
-+/**
-+ * Configures the maximum number of headers LibHTP will accept per request or response.
-+ *
-+ * @param[in] cfg
-+ * @param[in] limit
-+ */
-+void htp_config_set_number_headers_limit(htp_cfg_t *cfg, uint32_t limit);
-+
- /**
-  * Configures how the server reacts to encoded NUL bytes. Some servers will stop at
-  * at NUL, while some will respond with 400 or 404. When the termination option is not
-diff --git a/htp/htp_config_private.h b/htp/htp_config_private.h
-index 5f1d60d..ecc8717 100644
---- a/htp/htp_config_private.h
-+++ b/htp/htp_config_private.h
-@@ -360,6 +360,12 @@ struct htp_cfg_t {
- 
-     /** Whether to decompress compressed request bodies. */
-     int request_decompression_enabled;
-+
-+    /** Maximum number of transactions. */
-+    uint32_t max_tx;
-+
-+    /** Maximum number of headers. */
-+    uint32_t number_headers_limit;
- };
- 
- #ifdef	__cplusplus
-diff --git a/htp/htp_core.h b/htp/htp_core.h
-index e4c933e..7c23212 100644
---- a/htp/htp_core.h
-+++ b/htp/htp_core.h
-@@ -235,6 +235,7 @@ enum htp_file_source_t {
- #define HTP_REQUEST_INVALID                0x100000000ULL
- #define HTP_REQUEST_INVALID_C_L            0x200000000ULL
- #define HTP_AUTH_INVALID                   0x400000000ULL
-+#define HTP_HEADERS_TOO_MANY               0x800000000ULL
- 
- #define HTP_MAX_HEADERS_REPETITIONS 64
- 
-diff --git a/htp/htp_request_generic.c b/htp/htp_request_generic.c
-index 435cf0a..1350e57 100644
---- a/htp/htp_request_generic.c
-+++ b/htp/htp_request_generic.c
-@@ -120,6 +120,17 @@ htp_status_t htp_process_request_header_generic(htp_connp_t *connp, unsigned cha
-         bstr_free(h->value);
-         free(h);
-     } else {
-+        if (htp_table_size(connp->in_tx->request_headers) > connp->cfg->number_headers_limit) {
-+            if (!(connp->in_tx->flags & HTP_HEADERS_TOO_MANY)) {
-+                connp->in_tx->flags |= HTP_HEADERS_TOO_MANY;
-+                htp_log(connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "Too many request headers");
-+            }
-+            bstr_free(h->name);
-+            bstr_free(h->value);
-+            free(h);
-+            // give up on what comes next
-+            return HTP_ERROR;
-+        }
-         // Add as a new header.
-         if (htp_table_add(connp->in_tx->request_headers, h->name, h) != HTP_OK) {
-             bstr_free(h->name);
-diff --git a/htp/htp_response_generic.c b/htp/htp_response_generic.c
-index f5fa59e..69da625 100644
---- a/htp/htp_response_generic.c
-+++ b/htp/htp_response_generic.c
-@@ -321,6 +321,16 @@ htp_status_t htp_process_response_header_generic(htp_connp_t *connp, unsigned ch
-         bstr_free(h->value);
-         free(h);       
-     } else {
-+        if (htp_table_size(connp->out_tx->response_headers) > connp->cfg->number_headers_limit) {
-+            if (!(connp->out_tx->flags & HTP_HEADERS_TOO_MANY)) {
-+                connp->out_tx->flags |= HTP_HEADERS_TOO_MANY;
-+                htp_log(connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "Too many response headers");
-+            }
-+            bstr_free(h->name);
-+            bstr_free(h->value);
-+            free(h);
-+            return HTP_ERROR;
-+        }
-         // Add as a new header.
-         if (htp_table_add(connp->out_tx->response_headers, h->name, h) != HTP_OK) {
-             bstr_free(h->name);
--- 
-2.25.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55605.patch b/recipes-ids/suricata/files/CVE-2024-55605.patch
deleted file mode 100644
index c8bfead..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55605.patch
+++ /dev/null
@@ -1,205 +0,0 @@
-From f80ebd5a30b02db5915f749f0c067c7adefbbe76 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 7 Nov 2024 17:49:45 +0100
-Subject: [PATCH] detect/transforms: write directly in inspect buffer
-
-instead of writing to a temporary buffer and then copying,
-to save the cost of copying.
-
-Ticket: 7229
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/f80ebd5a30b02db5915f749f0c067c7adefbbe76 && https://github.com/OISF/suricata/commit/c3a6abf60134c2993ee3802ee52206e9fdbf55ba]
-CVE: CVE-2024-55605
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/detect-engine.c                        | 23 ++++++++++++++++++++--
- src/detect-engine.h                        |  3 ++-
- src/detect-transform-compress-whitespace.c |  8 ++++++--
- src/detect-transform-dotprefix.c           | 10 +++++++---
- src/detect-transform-strip-whitespace.c    |  8 ++++++--
- src/detect-transform-urldecode.c           |  8 ++++++--
- src/detect-transform-xor.c                 |  7 +++++--
- 7 files changed, 53 insertions(+), 14 deletions(-)
-
-diff --git a/src/detect-engine.c b/src/detect-engine.c
-index 141b48a..cdb24d8 100644
---- a/src/detect-engine.c
-+++ b/src/detect-engine.c
-@@ -1647,11 +1647,13 @@ void InspectionBufferFree(InspectionBuffer *buffer)
- /**
-  * \brief make sure that the buffer has at least 'min_size' bytes
-  * Expand the buffer if necessary
-+ *
-+ * \retval pointer to inner buffer to use, or NULL if realloc failed
-  */
--void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
-+uint8_t *InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
- {
-     if (likely(buffer->size >= min_size))
--        return;
-+        return buffer->buf;
- 
-     uint32_t new_size = (buffer->size == 0) ? 4096 : buffer->size;
-     while (new_size < min_size) {
-@@ -1662,7 +1664,24 @@ void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
-     if (ptr != NULL) {
-         buffer->buf = ptr;
-         buffer->size = new_size;
-+    } else {
-+        return NULL;
-     }
-+    return buffer->buf;
-+}
-+
-+/**
-+ * \brief set inspect length of inspect buffer
-+ * The inspect buffer may have been overallocated (by strip_whitespace for example)
-+ * so, this sets the final length
-+ */
-+void InspectionBufferTruncate(InspectionBuffer *buffer, uint32_t buf_len)
-+{
-+    DEBUG_VALIDATE_BUG_ON(buffer->buf == NULL);
-+    DEBUG_VALIDATE_BUG_ON(buf_len > buffer->size);
-+    buffer->inspect = buffer->buf;
-+    buffer->inspect_len = buf_len;
-+    buffer->initialized = true;
- }
- 
- void InspectionBufferCopy(InspectionBuffer *buffer, uint8_t *buf, uint32_t buf_len)
-diff --git a/src/detect-engine.h b/src/detect-engine.h
-index 7617e66..04713a7 100644
---- a/src/detect-engine.h
-+++ b/src/detect-engine.h
-@@ -31,7 +31,8 @@ void InspectionBufferInit(InspectionBuffer *buffer, uint32_t initial_size);
- void InspectionBufferSetup(DetectEngineThreadCtx *det_ctx, const int list_id,
-         InspectionBuffer *buffer, const uint8_t *data, const uint32_t data_len);
- void InspectionBufferFree(InspectionBuffer *buffer);
--void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size);
-+uint8_t *InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size);
-+void InspectionBufferTruncate(InspectionBuffer *buffer, uint32_t buf_len);
- void InspectionBufferCopy(InspectionBuffer *buffer, uint8_t *buf, uint32_t buf_len);
- void InspectionBufferApplyTransforms(InspectionBuffer *buffer,
-         const DetectEngineTransforms *transforms);
-diff --git a/src/detect-transform-compress-whitespace.c b/src/detect-transform-compress-whitespace.c
-index 5cbf0fd..cc78c7e 100644
---- a/src/detect-transform-compress-whitespace.c
-+++ b/src/detect-transform-compress-whitespace.c
-@@ -111,7 +111,11 @@ static void TransformCompressWhitespace(InspectionBuffer *buffer, void *options)
-         return;
-     }
- 
--    uint8_t output[input_len]; // we can only shrink
-+    // we can only shrink
-+    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
-+    if (output == NULL) {
-+        return;
-+    }
-     uint8_t *oi = output, *os = output;
- 
-     //PrintRawDataFp(stdout, input, input_len);
-@@ -132,7 +136,7 @@ static void TransformCompressWhitespace(InspectionBuffer *buffer, void *options)
-     uint32_t output_size = oi - os;
-     //PrintRawDataFp(stdout, output, output_size);
- 
--    InspectionBufferCopy(buffer, os, output_size);
-+    InspectionBufferTruncate(buffer, output_size);
- }
- 
- #ifdef UNITTESTS
-diff --git a/src/detect-transform-dotprefix.c b/src/detect-transform-dotprefix.c
-index 52a2633..d58e1d4 100644
---- a/src/detect-transform-dotprefix.c
-+++ b/src/detect-transform-dotprefix.c
-@@ -110,11 +110,15 @@ static void TransformDotPrefix(InspectionBuffer *buffer, void *options)
-     const size_t input_len = buffer->inspect_len;
- 
-     if (input_len) {
--        uint8_t output[input_len + 1]; // For the leading '.'
-+        // For the leading '.'
-+        uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len + 1);
-+        if (output == NULL) {
-+            return;
-+        }
- 
-+        memmove(&output[1], buffer->inspect, input_len);
-         output[0] = '.';
--        memcpy(&output[1], buffer->inspect, input_len);
--        InspectionBufferCopy(buffer, output, input_len + 1);
-+        InspectionBufferTruncate(buffer, input_len + 1);
-     }
- }
- 
-diff --git a/src/detect-transform-strip-whitespace.c b/src/detect-transform-strip-whitespace.c
-index 32fb96f..6040592 100644
---- a/src/detect-transform-strip-whitespace.c
-+++ b/src/detect-transform-strip-whitespace.c
-@@ -106,7 +106,11 @@ static void TransformStripWhitespace(InspectionBuffer *buffer, void *options)
-     if (input_len == 0) {
-         return;
-     }
--    uint8_t output[input_len]; // we can only shrink
-+    // we can only shrink
-+    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
-+    if (output == NULL) {
-+        return;
-+    }
-     uint8_t *oi = output, *os = output;
- 
-     //PrintRawDataFp(stdout, input, input_len);
-@@ -119,7 +123,7 @@ static void TransformStripWhitespace(InspectionBuffer *buffer, void *options)
-     uint32_t output_size = oi - os;
-     //PrintRawDataFp(stdout, output, output_size);
- 
--    InspectionBufferCopy(buffer, os, output_size);
-+    InspectionBufferTruncate(buffer, output_size);
- }
- 
- #ifdef UNITTESTS
-diff --git a/src/detect-transform-urldecode.c b/src/detect-transform-urldecode.c
-index 13ef033..a4e9655 100644
---- a/src/detect-transform-urldecode.c
-+++ b/src/detect-transform-urldecode.c
-@@ -125,12 +125,16 @@ static void TransformUrlDecode(InspectionBuffer *buffer, void *options)
-     if (input_len == 0) {
-         return;
-     }
--    uint8_t output[input_len]; // we can only shrink
-+    // we can only shrink
-+    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
-+    if (output == NULL) {
-+        return;
-+    }
- 
-     changed = BufferUrlDecode(input, input_len, output, &output_size);
- 
-     if (changed) {
--        InspectionBufferCopy(buffer, output, output_size);
-+        InspectionBufferTruncate(buffer, output_size);
-     }
- }
- 
-diff --git a/src/detect-transform-xor.c b/src/detect-transform-xor.c
-index e42700f..18f96df 100644
---- a/src/detect-transform-xor.c
-+++ b/src/detect-transform-xor.c
-@@ -133,12 +133,15 @@ static void DetectTransformXor(InspectionBuffer *buffer, void *options)
-     if (input_len == 0) {
-         return;
-     }
--    uint8_t output[input_len];
-+    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
-+    if (output == NULL) {
-+        return;
-+    }
- 
-     for (uint32_t i = 0; i < input_len; i++) {
-         output[i] = input[i] ^ pxd->key[i % pxd->length];
-     }
--    InspectionBufferCopy(buffer, output, input_len);
-+    InspectionBufferTruncate(buffer, input_len);
- }
- 
- #ifdef UNITTESTS
--- 
-2.25.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55627-001.patch b/recipes-ids/suricata/files/CVE-2024-55627-001.patch
deleted file mode 100644
index 50b4f06..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55627-001.patch
+++ /dev/null
@@ -1,59 +0,0 @@
-From 0dc364aef2dec122fc0e7ee4c190864f4cc5f1bd Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 21 Nov 2024 14:55:32 +0100
-Subject: [PATCH] util/streaming-buffer: fix regions intersection
-
-This was not a problem for current callers in Suricata,
-as RegionsIntersect is only called through StreamingBufferInsertAt
-which is only used by TCP...
-
-And TCP uses default region gap = 256kb, and only calls
-StreamingBufferInsertAt with a u16, so TCP never inserts a new
-data that will strictly contain an existing region augmented
-with region gap, which was the only case where RegionsIntersect
-returned the wrong result, which could later lead to a
-buffer overflow.
-
-Ticket: 7393
-(cherry picked from commit 282509f70c4ce805098e59535af445362e3e9ebd)
-
-CVE: CVE-2024-55627
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/0dc364aef2dec122fc0e7ee4c190864f4cc5f1bd]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/util-streaming-buffer.c | 19 ++++++++-----------
- 1 file changed, 8 insertions(+), 11 deletions(-)
-
-diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
-index 7608b50..d1d20e8 100644
---- a/src/util-streaming-buffer.c
-+++ b/src/util-streaming-buffer.c
-@@ -133,17 +133,14 @@ static inline bool RegionsIntersect(const StreamingBuffer *sb, const StreamingBu
-     SCLogDebug("r %p: %" PRIu64 "/%" PRIu64 " - adjusted %" PRIu64 "/%" PRIu64, r, r->stream_offset,
-             r->stream_offset + r->buf_size, reg_o, reg_re);
-     /* check if data range intersects with region range */
--    if (offset >= reg_o && offset <= reg_re) {
--        SCLogDebug("r %p is in-scope", r);
--        return true;
--    }
--    if (re >= reg_o && re <= reg_re) {
--        SCLogDebug("r %p is in-scope: %" PRIu64 " >= %" PRIu64 " && %" PRIu64 " <= %" PRIu64, r, re,
--                reg_o, re, reg_re);
--        return true;
--    }
--    SCLogDebug("r %p is out of scope: %" PRIu64 "/%" PRIu64, r, offset, re);
--    return false;
-+    /* [offset:re] and [reg_o:reg_re] do not intersect if and only if
-+     * re < reg_o or if reg_re < offset (one segment is strictly before the other)
-+     * trusting that offset<=re and reg_o<=reg_re
-+     */
-+    if (re < reg_o || reg_re < offset) {
-+        return false;
-+    }
-+    return true;
- }
- 
- /** \internal
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55627-002.patch b/recipes-ids/suricata/files/CVE-2024-55627-002.patch
deleted file mode 100644
index 8e2ca6b..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55627-002.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 949bfeca0e5f92212dc3d79f4a87c7c482d376aa Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 21 Nov 2024 15:17:21 +0100
-Subject: [PATCH] util/streaming-buffer: check need to grow region
-
-Ticket: 7393
-
-As it was possible before earlier patches to get here
-with mem_size lesser than start->buf_size,
-which caused then an unsigned underflow and a buffer overflow.
-
-(cherry picked from commit 8900041405dbb5f9584edae994af2100733fb4be)
-
-CVE: CVE-2024-55627
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/949bfeca0e5f92212dc3d79f4a87c7c482d376aa]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/util-streaming-buffer.c | 10 +++++++---
- 1 file changed, 7 insertions(+), 3 deletions(-)
-
-diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
-index d1d20e8..2625e49 100644
---- a/src/util-streaming-buffer.c
-+++ b/src/util-streaming-buffer.c
-@@ -931,9 +931,13 @@ static inline void StreamingBufferSlideToOffsetWithRegions(
-                     goto done;
-                 } else {
-                     /* using "main", expand to include "next" */
--                    if (GrowRegionToSize(sb, cfg, start, mem_size) != 0) {
--                        new_mem_size = new_data_size;
--                        goto just_main;
-+                    if (mem_size > start->buf_size) {
-+                        // Check that start->buf_size is actually not big enough
-+                        // As mem_size computation and earlier checks do not make it clear.
-+                        if (GrowRegionToSize(sb, cfg, start, mem_size) != 0) {
-+                            new_mem_size = new_data_size;
-+                            goto just_main;
-+                        }
-                     }
-                     SCLogDebug("start->buf now size %u", mem_size);
- 
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55627-003.patch b/recipes-ids/suricata/files/CVE-2024-55627-003.patch
deleted file mode 100644
index 63d5016..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55627-003.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-From 7d47fcf7f7fefacd2b0d8f482534a83b35a3c45e Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 21 Nov 2024 15:20:44 +0100
-Subject: [PATCH] util/streaming-buffer: add extra safety check
-
-Ticket: 7393
-
-Check if GrowRegionToSize is called with an argument
-trying to shrink the region size, and if so do nothing,
-ie do not try to shrink, and just return ok.
-
-This way, we avoid a buffer overflow from memeset using an
-unsigned having underflowed.
-
-(cherry picked from commit 9a53ec43b13f0039a083950511a18bf6f408e432)
-
-CVE: CVE-2024-55627
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/7d47fcf7f7fefacd2b0d8f482534a83b35a3c45e]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/util-streaming-buffer.c | 4 ++++
- 1 file changed, 4 insertions(+)
-
-diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
-index 2625e49..077f8af 100644
---- a/src/util-streaming-buffer.c
-+++ b/src/util-streaming-buffer.c
-@@ -715,6 +715,10 @@ static inline int WARN_UNUSED GrowRegionToSize(StreamingBuffer *sb,
-     /* try to grow in multiples of cfg->buf_size */
-     const uint32_t grow = ToNextMultipleOf(size, cfg->buf_size);
-     SCLogDebug("grow %u", grow);
-+    if (grow <= region->buf_size) {
-+        // do not try to shrink, and do not memset with diff having unsigned underflow
-+        return SC_OK;
-+    }
- 
-     void *ptr = REALLOC(cfg, region->buf, region->buf_size, grow);
-     if (ptr == NULL) {
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55628-001.patch b/recipes-ids/suricata/files/CVE-2024-55628-001.patch
deleted file mode 100644
index 6371729..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55628-001.patch
+++ /dev/null
@@ -1,738 +0,0 @@
-From 58c41a7fa99f62d9a8688e970ab1a9b09c79723a Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Thu, 31 Oct 2024 15:40:40 -0600
-Subject: [PATCH] dns: truncate names larger than 1025 characters
-
-Once a name has gone over 1025 chars it will be truncated to 1025
-chars and no more labels will be added to it, however the name will
-continue to be parsed up to the label limit in attempt to find the end
-so parsing can continue.
-
-This introduces a new struct, DNSName which contains the name and any
-flags which indicate any name parsing errors which should not error
-out parsing the complete message, for example, infinite recursion
-after some labels are parsed can continue, or truncation of name where
-compression was used so we know the start of the next data to be
-parsed.
-
-This limits the logged DNS messages from being over our maximum size
-of 10Mb in the case of really long names.
-
-Ticket: #7280
-
-CVE: CVE-2024-55628
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/58c41a7fa99f62d9a8688e970ab1a9b09c79723a]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- rust/src/dns/dns.rs    |  41 +++++---
- rust/src/dns/log.rs    |  41 ++++----
- rust/src/dns/lua.rs    |  36 ++++---
- rust/src/dns/parser.rs | 231 ++++++++++++++++++++++++++++++++++++-----
- 4 files changed, 277 insertions(+), 72 deletions(-)
-
-diff --git a/rust/src/dns/dns.rs b/rust/src/dns/dns.rs
-index 382c76a..680bf7e 100644
---- a/rust/src/dns/dns.rs
-+++ b/rust/src/dns/dns.rs
-@@ -144,7 +144,7 @@ pub struct DNSHeader {
- 
- #[derive(Debug)]
- pub struct DNSQueryEntry {
--    pub name: Vec<u8>,
-+    pub name: DNSName,
-     pub rrtype: u16,
-     pub rrclass: u16,
- }
-@@ -152,9 +152,9 @@ pub struct DNSQueryEntry {
- #[derive(Debug, PartialEq, Eq)]
- pub struct DNSRDataSOA {
-     /// Primary name server for this zone
--    pub mname: Vec<u8>,
-+    pub mname: DNSName,
-     /// Authority's mailbox
--    pub rname: Vec<u8>,
-+    pub rname: DNSName,
-     /// Serial version number
-     pub serial: u32,
-     /// Refresh interval (seconds)
-@@ -186,7 +186,22 @@ pub struct DNSRDataSRV {
-     /// Port
-     pub port: u16,
-     /// Target
--    pub target: Vec<u8>,
-+    pub target: DNSName,
-+}
-+
-+bitflags! {
-+    #[derive(Default)]
-+    pub struct DNSNameFlags: u8 {
-+        const INFINITE_LOOP = 0b0000_0001;
-+        const TRUNCATED     = 0b0000_0010;
-+        const LABEL_LIMIT   = 0b0000_0100;
-+    }
-+}
-+
-+#[derive(Debug, Clone, PartialEq, Eq)]
-+pub struct DNSName {
-+    pub value: Vec<u8>,
-+    pub flags: DNSNameFlags,
- }
- 
- /// Represents RData of various formats
-@@ -196,10 +211,10 @@ pub enum DNSRData {
-     A(Vec<u8>),
-     AAAA(Vec<u8>),
-     // RData is a domain name
--    CNAME(Vec<u8>),
--    PTR(Vec<u8>),
--    MX(Vec<u8>),
--    NS(Vec<u8>),
-+    CNAME(DNSName),
-+    PTR(DNSName),
-+    MX(DNSName),
-+    NS(DNSName),
-     // RData is text
-     TXT(Vec<u8>),
-     NULL(Vec<u8>),
-@@ -213,7 +228,7 @@ pub enum DNSRData {
- 
- #[derive(Debug, PartialEq, Eq)]
- pub struct DNSAnswerEntry {
--    pub name: Vec<u8>,
-+    pub name: DNSName,
-     pub rrtype: u16,
-     pub rrclass: u16,
-     pub ttl: u32,
-@@ -871,9 +886,9 @@ pub unsafe extern "C" fn rs_dns_tx_get_query_name(
-     if let Some(request) = &tx.request {
-         if (i as usize) < request.queries.len() {
-             let query = &request.queries[i as usize];
--            if !query.name.is_empty() {
--                *len = query.name.len() as u32;
--                *buf = query.name.as_ptr();
-+            if !query.name.value.is_empty() {
-+                *len = query.name.value.len() as u32;
-+                *buf = query.name.value.as_ptr();
-                 return 1;
-             }
-         }
-@@ -904,7 +919,7 @@ pub unsafe extern "C" fn rs_dns_tx_get_query_rrtype(
-     if let Some(request) = &tx.request {
-         if (i as usize) < request.queries.len() {
-             let query = &request.queries[i as usize];
--            if !query.name.is_empty() {
-+            if !query.name.value.is_empty() {
-                 *rrtype = query.rrtype;
-                 return 1;
-             }
-diff --git a/rust/src/dns/log.rs b/rust/src/dns/log.rs
-index 5212b1a..6bf9589 100644
---- a/rust/src/dns/log.rs
-+++ b/rust/src/dns/log.rs
-@@ -398,8 +398,8 @@ pub fn dns_print_addr(addr: &Vec<u8>) -> std::string::String {
- fn dns_log_soa(soa: &DNSRDataSOA) -> Result<JsonBuilder, JsonError> {
-     let mut js = JsonBuilder::try_new_object()?;
- 
--    js.set_string_from_bytes("mname", &soa.mname)?;
--    js.set_string_from_bytes("rname", &soa.rname)?;
-+    js.set_string_from_bytes("mname", &soa.mname.value)?;
-+    js.set_string_from_bytes("rname", &soa.rname.value)?;
-     js.set_uint("serial", soa.serial as u64)?;
-     js.set_uint("refresh", soa.refresh as u64)?;
-     js.set_uint("retry", soa.retry as u64)?;
-@@ -434,7 +434,7 @@ fn dns_log_srv(srv: &DNSRDataSRV) -> Result<JsonBuilder, JsonError> {
-     js.set_uint("priority", srv.priority as u64)?;
-     js.set_uint("weight", srv.weight as u64)?;
-     js.set_uint("port", srv.port as u64)?;
--    js.set_string_from_bytes("name", &srv.target)?;
-+    js.set_string_from_bytes("name", &srv.target.value)?;
- 
-     js.close()?;
-     return Ok(js);
-@@ -443,7 +443,7 @@ fn dns_log_srv(srv: &DNSRDataSRV) -> Result<JsonBuilder, JsonError> {
- fn dns_log_json_answer_detail(answer: &DNSAnswerEntry) -> Result<JsonBuilder, JsonError> {
-     let mut jsa = JsonBuilder::try_new_object()?;
- 
--    jsa.set_string_from_bytes("rrname", &answer.name)?;
-+    jsa.set_string_from_bytes("rrname", &answer.name.value)?;
-     jsa.set_string("rrtype", &dns_rrtype_string(answer.rrtype))?;
-     jsa.set_uint("ttl", answer.ttl as u64)?;
- 
-@@ -451,12 +451,10 @@ fn dns_log_json_answer_detail(answer: &DNSAnswerEntry) -> Result<JsonBuilder, Js
-         DNSRData::A(addr) | DNSRData::AAAA(addr) => {
-             jsa.set_string("rdata", &dns_print_addr(addr))?;
-         }
--        DNSRData::CNAME(bytes)
--        | DNSRData::MX(bytes)
--        | DNSRData::NS(bytes)
--        | DNSRData::TXT(bytes)
--        | DNSRData::NULL(bytes)
--        | DNSRData::PTR(bytes) => {
-+        DNSRData::CNAME(name) | DNSRData::MX(name) | DNSRData::NS(name) | DNSRData::PTR(name) => {
-+            jsa.set_string_from_bytes("rdata", &name.value)?;
-+        }
-+        DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
-             jsa.set_string_from_bytes("rdata", bytes)?;
-         }
-         DNSRData::SOA(soa) => {
-@@ -507,7 +505,7 @@ fn dns_log_json_answer(
-     js.set_uint("opcode", opcode as u64)?;
- 
-     if let Some(query) = response.queries.first() {
--        js.set_string_from_bytes("rrname", &query.name)?;
-+        js.set_string_from_bytes("rrname", &query.name.value)?;
-         js.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
-     }
-     js.set_string("rcode", &dns_rcode_string(header.flags))?;
-@@ -530,12 +528,19 @@ fn dns_log_json_answer(
-                             a.append_string(&dns_print_addr(addr))?;
-                         }
-                     }
--                    DNSRData::CNAME(bytes)
--                    | DNSRData::MX(bytes)
--                    | DNSRData::NS(bytes)
--                    | DNSRData::TXT(bytes)
--                    | DNSRData::NULL(bytes)
--                    | DNSRData::PTR(bytes) => {
-+                    DNSRData::CNAME(name)
-+                    | DNSRData::MX(name)
-+                    | DNSRData::NS(name)
-+                    | DNSRData::PTR(name) => {
-+                        if !answer_types.contains_key(&type_string) {
-+                            answer_types
-+                                .insert(type_string.to_string(), JsonBuilder::try_new_array()?);
-+                        }
-+                        if let Some(a) = answer_types.get_mut(&type_string) {
-+                            a.append_string_from_bytes(&name.value)?;
-+                        }
-+                    }
-+                    DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
-                         if !answer_types.contains_key(&type_string) {
-                             answer_types.insert(type_string.to_string(), JsonBuilder::try_new_array()?);
-                         }
-@@ -614,7 +619,7 @@ fn dns_log_query(
-             if dns_log_rrtype_enabled(query.rrtype, flags) {
-                 jb.set_string("type", "query")?;
-                 jb.set_uint("id", request.header.tx_id as u64)?;
--                jb.set_string_from_bytes("rrname", &query.name)?;
-+                jb.set_string_from_bytes("rrname", &query.name.value)?;
-                 jb.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
-                 jb.set_uint("tx_id", tx.id - 1)?;
-                 if request.header.flags & 0x0040 != 0 {
-diff --git a/rust/src/dns/lua.rs b/rust/src/dns/lua.rs
-index b9935f8..f7b0c15 100644
---- a/rust/src/dns/lua.rs
-+++ b/rust/src/dns/lua.rs
-@@ -34,12 +34,12 @@ pub extern "C" fn rs_dns_lua_get_rrname(clua: &mut CLuaState, tx: &mut DNSTransa
- 
-     if let Some(request) = &tx.request {
-         if let Some(query) = request.queries.first() {
--            lua.pushstring(&String::from_utf8_lossy(&query.name));
-+            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
-             return 1;
-         }
-     } else if let Some(response) = &tx.response {
-         if let Some(query) = response.queries.first() {
--            lua.pushstring(&String::from_utf8_lossy(&query.name));
-+            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
-             return 1;
-         }
-     }
-@@ -86,7 +86,7 @@ pub extern "C" fn rs_dns_lua_get_query_table(
-             lua.settable(-3);
- 
-             lua.pushstring("rrname");
--            lua.pushstring(&String::from_utf8_lossy(&query.name));
-+            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
-             lua.settable(-3);
- 
-             lua.settable(-3);
-@@ -103,7 +103,7 @@ pub extern "C" fn rs_dns_lua_get_query_table(
-             lua.settable(-3);
- 
-             lua.pushstring("rrname");
--            lua.pushstring(&String::from_utf8_lossy(&query.name));
-+            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
-             lua.settable(-3);
- 
-             lua.settable(-3);
-@@ -142,11 +142,11 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
-             lua.settable(-3);
- 
-             lua.pushstring("rrname");
--            lua.pushstring(&String::from_utf8_lossy(&answer.name));
-+            lua.pushstring(&String::from_utf8_lossy(&answer.name.value));
-             lua.settable(-3);
- 
-             // All rdata types are pushed to "addr" for backwards compatibility
--            match answer.data {
-+            match &answer.data {
-                 DNSRData::A(ref bytes) | DNSRData::AAAA(ref bytes) => {
-                     if !bytes.is_empty() {
-                         lua.pushstring("addr");
-@@ -154,12 +154,18 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
-                         lua.settable(-3);
-                     }
-                 }
--                DNSRData::CNAME(ref bytes)
--                | DNSRData::MX(ref bytes)
--                | DNSRData::NS(ref bytes)
--                | DNSRData::TXT(ref bytes)
-+                DNSRData::CNAME(name)
-+                | DNSRData::MX(name)
-+                | DNSRData::NS(name)
-+                | DNSRData::PTR(name) => {
-+                    if !name.value.is_empty() {
-+                        lua.pushstring("addr");
-+                        lua.pushstring(&String::from_utf8_lossy(&name.value));
-+                        lua.settable(-3);
-+                    }
-+                }
-+                DNSRData::TXT(ref bytes)
-                 | DNSRData::NULL(ref bytes)
--                | DNSRData::PTR(ref bytes)
-                 | DNSRData::Unknown(ref bytes) => {
-                     if !bytes.is_empty() {
-                         lua.pushstring("addr");
-@@ -168,9 +174,9 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
-                     }
-                 }
-                 DNSRData::SOA(ref soa) => {
--                    if !soa.mname.is_empty() {
-+                    if !soa.mname.value.is_empty() {
-                         lua.pushstring("addr");
--                        lua.pushstring(&String::from_utf8_lossy(&soa.mname));
-+                        lua.pushstring(&String::from_utf8_lossy(&soa.mname.value));
-                         lua.settable(-3);
-                     }
-                 }
-@@ -181,7 +187,7 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
-                 }
-                 DNSRData::SRV(ref srv) => {
-                     lua.pushstring("addr");
--                    lua.pushstring(&String::from_utf8_lossy(&srv.target));
-+                    lua.pushstring(&String::from_utf8_lossy(&srv.target.value));
-                     lua.settable(-3);
-                 }
-             }
-@@ -221,7 +227,7 @@ pub extern "C" fn rs_dns_lua_get_authority_table(
-             lua.settable(-3);
- 
-             lua.pushstring("rrname");
--            lua.pushstring(&String::from_utf8_lossy(&answer.name));
-+            lua.pushstring(&String::from_utf8_lossy(&answer.name.value));
-             lua.settable(-3);
- 
-             lua.settable(-3);
-diff --git a/rust/src/dns/parser.rs b/rust/src/dns/parser.rs
-index a1d97a5..12929bc 100644
---- a/rust/src/dns/parser.rs
-+++ b/rust/src/dns/parser.rs
-@@ -45,16 +45,48 @@ pub fn dns_parse_header(i: &[u8]) -> IResult<&[u8], DNSHeader> {
-     ))
- }
- 
-+// Set a maximum assembled hostname length of 1025, this value was
-+// chosen as its what DNSMasq uses, a popular DNS server, even if most
-+// tooling limits names to 256 chars without special options.
-+static MAX_NAME_LEN: usize = 1025;
-+
- /// Parse a DNS name.
- ///
-+/// Names are parsed with the following restrictions:
-+///
-+/// - Only 255 segments will be processed, if more the parser may
-+///   error out. This is also our safeguard against an infinite loop. If
-+///   a pointer had been followed a truncated name will be
-+///   returned. However if pointer has been processed we error out as we
-+///   don't know where the next data point starts without more
-+///   iterations.
-+///
-+/// - The maximum name parsed in representation format is MAX_NAME_LEN
-+///   characters. Once larger, the truncated name will be returned with
-+///   a flag specifying the name was truncated. Note that parsing
-+///   continues if no pointer has been used as we still need to find the
-+///   start of the next protocol unit.
-+///
-+/// As some error in parsing the name are recoverable, a DNSName
-+/// object is returned with flags signifying a recoverable
-+/// error. These errors include:
-+///
-+/// - infinite loop: as we know the end of the name in the input
-+///   stream, we can return what we've parsed with the remain data.
-+///
-+/// - maximum number of segments/labels parsed
-+///
-+/// - truncation of name when too long
-+///
- /// Parameters:
- ///   start: the start of the name
- ///   message: the complete message that start is a part of with the DNS header
--pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8], Vec<u8>> {
-+pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8], DNSName> {
-     let mut pos = start;
-     let mut pivot = start;
-     let mut name: Vec<u8> = Vec::with_capacity(32);
-     let mut count = 0;
-+    let mut flags = DNSNameFlags::default();
- 
-     loop {
-         if pos.is_empty() {
-@@ -68,10 +100,12 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8
-             break;
-         } else if len & 0b1100_0000 == 0 {
-             let (rem, label) = length_data(be_u8)(pos)?;
--            if !name.is_empty() {
--                name.push(b'.');
-+            if !flags.contains(DNSNameFlags::TRUNCATED) {
-+                if !name.is_empty() {
-+                    name.push(b'.');
-+                }
-+                name.extend(label);
-             }
--            name.extend(label);
-             pos = rem;
-         } else if len & 0b1100_0000 == 0b1100_0000 {
-             let (rem, leader) = be_u16(pos)?;
-@@ -79,6 +113,21 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8
-             if offset > message.len() {
-                 return Err(Err::Error(error_position!(pos, ErrorKind::OctDigit)));
-             }
-+
-+            if &message[offset..] == pos {
-+                // Self reference, immedate infinite loop.
-+                flags.insert(DNSNameFlags::INFINITE_LOOP);
-+
-+                // If we have followed a pointer, we can just break as
-+                // we've already found the end of the input. But if we
-+                // have not followed a pointer yet return a parse
-+                // error.
-+                if pivot != start {
-+                    break;
-+                }
-+                return Err(Err::Error(error_position!(pos, ErrorKind::OctDigit)));
-+            }
-+
-             pos = &message[offset..];
-             if pivot == start {
-                 pivot = rem;
-@@ -89,19 +138,43 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8
- 
-         // Return error if we've looped a certain number of times.
-         count += 1;
-+
-         if count > 255 {
-+            flags.insert(DNSNameFlags::LABEL_LIMIT);
-+
-+            // Our segment limit has been reached, if we have hit a
-+            // pointer we can just return the truncated name. If we
-+            // have not hit a pointer, we need to bail with an error.
-+            if pivot != start {
-+                flags.insert(DNSNameFlags::TRUNCATED);
-+                break;
-+            }
-             return Err(Err::Error(error_position!(pos, ErrorKind::OctDigit)));
-         }
-+
-+        if name.len() > MAX_NAME_LEN {
-+            name.truncate(MAX_NAME_LEN);
-+            flags.insert(DNSNameFlags::TRUNCATED);
-+
-+            // If we have pivoted due to a pointer we know where the
-+            // end of the data is, so we can break early. Otherwise
-+            // we'll keep parsing in hopes to find the end of the name
-+            // so parsing can continue.
-+            if pivot != start {
-+                break;
-+            }
-+        }
-     }
- 
-     // If we followed a pointer we return the position after the first
-     // pointer followed. Is there a better way to see if these slices
-     // diverged from each other?  A straight up comparison would
-     // actually check the contents.
--    if pivot.len() != start.len() {
--        return Ok((pivot, name));
-+    if pivot != start {
-+        Ok((pivot, DNSName { value: name, flags }))
-+    } else {
-+        Ok((pos, DNSName { value: name, flags }))
-     }
--    return Ok((pos, name));
- }
- 
- /// Parse answer entries.
-@@ -121,7 +194,7 @@ fn dns_parse_answer<'a>(
-     let mut input = slice;
- 
-     struct Answer<'a> {
--        name: Vec<u8>,
-+        name: DNSName,
-         rrtype: u16,
-         rrclass: u16,
-         ttl: u32,
-@@ -375,7 +448,7 @@ mod tests {
-         ];
-         let expected_remainder: &[u8] = &[0x00, 0x01, 0x00];
-         let (remainder, name) = dns_parse_name(buf, buf).unwrap();
--        assert_eq!("client-cf.dropbox.com".as_bytes(), &name[..]);
-+        assert_eq!("client-cf.dropbox.com".as_bytes(), &name.value[..]);
-         assert_eq!(remainder, expected_remainder);
-     }
- 
-@@ -411,7 +484,13 @@ mod tests {
-         let res1 = dns_parse_name(start1, message);
-         assert_eq!(
-             res1,
--            Ok((&start1[22..], "www.suricata-ids.org".as_bytes().to_vec()))
-+            Ok((
-+                &start1[22..],
-+                DNSName {
-+                    value: "www.suricata-ids.org".as_bytes().to_vec(),
-+                    flags: DNSNameFlags::default(),
-+                }
-+            ))
-         );
- 
-         // The second name starts at offset 80, but is just a pointer
-@@ -420,7 +499,13 @@ mod tests {
-         let res2 = dns_parse_name(start2, message);
-         assert_eq!(
-             res2,
--            Ok((&start2[2..], "www.suricata-ids.org".as_bytes().to_vec()))
-+            Ok((
-+                &start2[2..],
-+                DNSName {
-+                    value: "www.suricata-ids.org".as_bytes().to_vec(),
-+                    flags: DNSNameFlags::default()
-+                }
-+            ))
-         );
- 
-         // The third name starts at offset 94, but is a pointer to a
-@@ -429,7 +514,13 @@ mod tests {
-         let res3 = dns_parse_name(start3, message);
-         assert_eq!(
-             res3,
--            Ok((&start3[2..], "suricata-ids.org".as_bytes().to_vec()))
-+            Ok((
-+                &start3[2..],
-+                DNSName {
-+                    value: "suricata-ids.org".as_bytes().to_vec(),
-+                    flags: DNSNameFlags::default()
-+                }
-+            ))
-         );
- 
-         // The fourth name starts at offset 110, but is a pointer to a
-@@ -438,7 +529,13 @@ mod tests {
-         let res4 = dns_parse_name(start4, message);
-         assert_eq!(
-             res4,
--            Ok((&start4[2..], "suricata-ids.org".as_bytes().to_vec()))
-+            Ok((
-+                &start4[2..],
-+                DNSName {
-+                    value: "suricata-ids.org".as_bytes().to_vec(),
-+                    flags: DNSNameFlags::default()
-+                }
-+            ))
-         );
-     }
- 
-@@ -473,7 +570,13 @@ mod tests {
-         let res = dns_parse_name(start, message);
-         assert_eq!(
-             res,
--            Ok((&start[2..], "block.g1.dropbox.com".as_bytes().to_vec()))
-+            Ok((
-+                &start[2..],
-+                DNSName {
-+                    value: "block.g1.dropbox.com".as_bytes().to_vec(),
-+                    flags: DNSNameFlags::default()
-+                }
-+            ))
-         );
-     }
- 
-@@ -512,7 +615,7 @@ mod tests {
-                 assert_eq!(request.queries.len(), 1);
- 
-                 let query = &request.queries[0];
--                assert_eq!(query.name, "www.suricata-ids.org".as_bytes().to_vec());
-+                assert_eq!(query.name.value, "www.suricata-ids.org".as_bytes().to_vec());
-                 assert_eq!(query.rrtype, 1);
-                 assert_eq!(query.rrclass, 1);
-             }
-@@ -569,20 +672,26 @@ mod tests {
-                 assert_eq!(response.answers.len(), 3);
- 
-                 let answer1 = &response.answers[0];
--                assert_eq!(answer1.name, "www.suricata-ids.org".as_bytes().to_vec());
-+                assert_eq!(answer1.name.value, "www.suricata-ids.org".as_bytes().to_vec());
-                 assert_eq!(answer1.rrtype, 5);
-                 assert_eq!(answer1.rrclass, 1);
-                 assert_eq!(answer1.ttl, 3544);
-                 assert_eq!(
-                     answer1.data,
--                    DNSRData::CNAME("suricata-ids.org".as_bytes().to_vec())
-+                    DNSRData::CNAME(DNSName {
-+                        value: "suricata-ids.org".as_bytes().to_vec(),
-+                        flags: Default::default(),
-+                    })
-                 );
- 
-                 let answer2 = &response.answers[1];
-                 assert_eq!(
-                     answer2,
-                     &DNSAnswerEntry {
--                        name: "suricata-ids.org".as_bytes().to_vec(),
-+                        name: DNSName {
-+                            value: "suricata-ids.org".as_bytes().to_vec(),
-+                            flags: Default::default(),
-+                        },
-                         rrtype: 1,
-                         rrclass: 1,
-                         ttl: 244,
-@@ -594,7 +703,10 @@ mod tests {
-                 assert_eq!(
-                     answer3,
-                     &DNSAnswerEntry {
--                        name: "suricata-ids.org".as_bytes().to_vec(),
-+                        name: DNSName {
-+                            value: "suricata-ids.org".as_bytes().to_vec(),
-+                            flags: Default::default(),
-+                        },
-                         rrtype: 1,
-                         rrclass: 1,
-                         ttl: 244,
-@@ -653,15 +765,21 @@ mod tests {
-                 assert_eq!(response.authorities.len(), 1);
- 
-                 let authority = &response.authorities[0];
--                assert_eq!(authority.name, "oisf.net".as_bytes().to_vec());
-+                assert_eq!(authority.name.value, "oisf.net".as_bytes().to_vec());
-                 assert_eq!(authority.rrtype, 6);
-                 assert_eq!(authority.rrclass, 1);
-                 assert_eq!(authority.ttl, 899);
-                 assert_eq!(
-                     authority.data,
-                     DNSRData::SOA(DNSRDataSOA {
--                        mname: "ns-110.awsdns-13.com".as_bytes().to_vec(),
--                        rname: "awsdns-hostmaster.amazon.com".as_bytes().to_vec(),
-+                        mname: DNSName {
-+                            value: "ns-110.awsdns-13.com".as_bytes().to_vec(),
-+                            flags: DNSNameFlags::default()
-+                        },
-+                        rname: DNSName {
-+                            value: "awsdns-hostmaster.amazon.com".as_bytes().to_vec(),
-+                            flags: DNSNameFlags::default()
-+                        },
-                         serial: 1,
-                         refresh: 7200,
-                         retry: 900,
-@@ -712,14 +830,14 @@ mod tests {
- 
-                 assert_eq!(response.queries.len(), 1);
-                 let query = &response.queries[0];
--                assert_eq!(query.name, "vaaaakardli.pirate.sea".as_bytes().to_vec());
-+                assert_eq!(query.name.value, "vaaaakardli.pirate.sea".as_bytes().to_vec());
-                 assert_eq!(query.rrtype, DNS_RECORD_TYPE_NULL);
-                 assert_eq!(query.rrclass, 1);
- 
-                 assert_eq!(response.answers.len(), 1);
- 
-                 let answer = &response.answers[0];
--                assert_eq!(answer.name, "vaaaakardli.pirate.sea".as_bytes().to_vec());
-+                assert_eq!(answer.name.value, "vaaaakardli.pirate.sea".as_bytes().to_vec());
-                 assert_eq!(answer.rrtype, DNS_RECORD_TYPE_NULL);
-                 assert_eq!(answer.rrclass, 1);
-                 assert_eq!(answer.ttl, 0);
-@@ -819,7 +937,7 @@ mod tests {
-                         assert_eq!(srv.weight, 1);
-                         assert_eq!(srv.port, 5060);
-                         assert_eq!(
--                            srv.target,
-+                            srv.target.value,
-                             "sip-anycast-2.voice.google.com".as_bytes().to_vec()
-                         );
-                     }
-@@ -834,7 +952,7 @@ mod tests {
-                         assert_eq!(srv.weight, 1);
-                         assert_eq!(srv.port, 5060);
-                         assert_eq!(
--                            srv.target,
-+                            srv.target.value,
-                             "sip-anycast-1.voice.google.com".as_bytes().to_vec()
-                         );
-                     }
-@@ -848,4 +966,65 @@ mod tests {
-             }
-         }
-     }
-+
-+    #[test]
-+    fn test_dns_parse_name_truncated() {
-+        // Generate a non-compressed hostname over our maximum of 1024.
-+        let mut buf: Vec<u8> = vec![];
-+        for _ in 0..17 {
-+            buf.push(0b0011_1111);
-+            for _ in 0..63 {
-+                buf.push(b'a');
-+            }
-+        }
-+
-+        let (rem, name) = dns_parse_name(&buf, &buf).unwrap();
-+        assert_eq!(name.value.len(), MAX_NAME_LEN);
-+        assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
-+        assert!(rem.is_empty());
-+    }
-+
-+    #[test]
-+    fn test_dns_parse_name_truncated_max_segments_no_pointer() {
-+        let mut buf: Vec<u8> = vec![];
-+        for _ in 0..256 {
-+            buf.push(0b0000_0001);
-+            buf.push(b'a');
-+        }
-+
-+        // This should fail as we've hit the segment limit without a
-+        // pointer, we'd need to keep parsing more segments to figure
-+        // out where the next data point lies.
-+        assert!(dns_parse_name(&buf, &buf).is_err());
-+    }
-+
-+    #[test]
-+    fn test_dns_parse_name_truncated_max_segments_with_pointer() {
-+        let mut buf: Vec<u8> = vec![];
-+
-+        // "a" at the beginning of the buffer.
-+        buf.push(0b0000_0001);
-+        buf.push(b'a');
-+
-+        // Followed by a pointer back to the beginning.
-+        buf.push(0b1100_0000);
-+        buf.push(0b0000_0000);
-+
-+        // The start of the name, which is pointer to the beginning of
-+        // the buffer.
-+        buf.push(0b1100_0000);
-+        buf.push(0b000_0000);
-+
-+        let (_rem, name) = dns_parse_name(&buf[4..], &buf).unwrap();
-+        assert_eq!(name.value.len(), 255);
-+        assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
-+    }
-+
-+    #[test]
-+    fn test_dns_parse_name_self_reference() {
-+        let mut buf = vec![];
-+        buf.push(0b1100_0000);
-+        buf.push(0b0000_0000);
-+        assert!(dns_parse_name(&buf, &buf).is_err());
-+    }
- }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55628-002.patch b/recipes-ids/suricata/files/CVE-2024-55628-002.patch
deleted file mode 100644
index 7bade5d..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55628-002.patch
+++ /dev/null
@@ -1,4877 +0,0 @@
-From 284ad462fcb2e47f1518a1abc19e27ca84c6972e Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <contact@catenacyber.fr>
-Date: Thu, 12 May 2022 20:31:25 +0200
-Subject: [PATCH] output: adds schema.json
-
-Ticket: #1369
-
-CVE: CVE-2024-55628
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/284ad462fcb2e47f1518a1abc19e27ca84c6972e]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- etc/schema.json | 4853 +++++++++++++++++++++++++++++++++++++++++++++++
- 1 file changed, 4853 insertions(+)
- create mode 100644 etc/schema.json
-
-diff --git a/etc/schema.json b/etc/schema.json
-new file mode 100644
-index 0000000..99f419f
---- /dev/null
-+++ b/etc/schema.json
-@@ -0,0 +1,4853 @@
-+{
-+    "type": "object",
-+    "properties": {
-+        "app_proto": {
-+            "type": "string",
-+            "optional": true
-+        },
-+        "app_proto_expected": {
-+            "type": "string"
-+        },
-+        "app_proto_orig": {
-+            "type": "string"
-+        },
-+        "app_proto_tc": {
-+            "type": "string"
-+        },
-+        "app_proto_ts": {
-+            "type": "string"
-+        },
-+        "community_id": {
-+            "type": "string"
-+        },
-+        "dest_ip": {
-+            "type": "string",
-+            "optional": true
-+        },
-+        "dest_port": {
-+            "type": "integer",
-+            "optional": true
-+        },
-+        "event_type": {
-+            "type": "string",
-+            "optional": false
-+        },
-+        "flow_id": {
-+            "type": "integer",
-+            "optional": true
-+        },
-+        "icmp_code": {
-+            "type": "integer"
-+        },
-+        "icmp_type": {
-+            "type": "integer"
-+        },
-+        "log_level": {
-+            "type": "string"
-+        },
-+        "packet": {
-+            "type": "string"
-+        },
-+        "parent_id": {
-+            "type": "integer"
-+        },
-+        "payload": {
-+            "type": "string"
-+        },
-+        "payload_printable": {
-+            "type": "string"
-+        },
-+        "pcap_cnt": {
-+            "type": "integer",
-+            "optional": true
-+        },
-+        "pkt_src": {
-+            "type": "string"
-+        },
-+        "proto": {
-+            "type": "string",
-+            "optional": true
-+        },
-+        "response_icmp_code": {
-+            "type": "integer"
-+        },
-+        "response_icmp_type": {
-+            "type": "integer"
-+        },
-+        "spi": {
-+            "type": "integer"
-+        },
-+        "src_ip": {
-+            "type": "string",
-+            "optional": true
-+        },
-+        "src_port": {
-+            "type": "integer",
-+            "optional": true
-+        },
-+        "stream": {
-+            "type": "integer"
-+        },
-+        "timestamp": {
-+            "type": "string",
-+            "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+[+\\-]\\d+$",
-+            "optional": false
-+        },
-+        "tx_id": {
-+            "type": "integer",
-+            "optional": true
-+        },
-+        "files": {
-+            "type": "array",
-+            "items": {
-+                "type": "object",
-+                "optional": true,
-+                "properties": {
-+                    "end": {
-+                        "type": "integer"
-+                    },
-+                    "filename": {
-+                        "type": "string"
-+                    },
-+                    "gaps": {
-+                        "type": "boolean"
-+                    },
-+                    "md5": {
-+                        "type": "string"
-+                    },
-+                    "sha1": {
-+                        "type": "string"
-+                    },
-+                    "sha256": {
-+                        "type": "string"
-+                    },
-+                    "size": {
-+                        "type": "integer"
-+                    },
-+                    "start": {
-+                        "type": "integer"
-+                    },
-+                    "state": {
-+                        "type": "string"
-+                    },
-+                    "stored": {
-+                        "type": "boolean"
-+                    },
-+                    "tx_id": {
-+                        "type": "integer"
-+                    },
-+                    "sid": {
-+                        "type": "array",
-+                        "items": {
-+                            "type": "integer"
-+                        }
-+                    }
-+                },
-+                "additionalProperties": false
-+            }
-+        },
-+        "vlan": {
-+            "type": "array",
-+            "items": {
-+                "type": "number"
-+            }
-+        },
-+        "alert": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "action": {
-+                    "type": "string"
-+                },
-+                "category": {
-+                    "type": "string"
-+                },
-+                "gid": {
-+                    "type": "integer"
-+                },
-+                "rev": {
-+                    "type": "integer"
-+                },
-+                "rule": {
-+                    "type": "string"
-+                },
-+                "severity": {
-+                    "type": "integer"
-+                },
-+                "signature": {
-+                    "type": "string"
-+                },
-+                "signature_id": {
-+                    "type": "integer"
-+                },
-+                "xff": {
-+                    "type": "string"
-+                },
-+                "metadata": {
-+                    "type": "object",
-+                    "properties": {
-+                        "affected_product": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "attack_target": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "created_at": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "deployment": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "signature_severity": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "tag": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "updated_at": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "source": {
-+                    "type": "object",
-+                    "properties": {
-+                        "ip": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "target": {
-+                    "type": "object",
-+                    "properties": {
-+                        "ip": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "anomaly": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "app_proto": {
-+                    "type": "string"
-+                },
-+                "event": {
-+                    "type": "string"
-+                },
-+                "layer": {
-+                    "type": "string"
-+                },
-+                "type": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "dcerpc": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "activityuuid": {
-+                    "type": "string"
-+                },
-+                "call_id": {
-+                    "type": "integer"
-+                },
-+                "request": {
-+                    "type": "string"
-+                },
-+                "response": {
-+                    "type": "string"
-+                },
-+                "rpc_version": {
-+                    "type": "string"
-+                },
-+                "seqnum": {
-+                    "type": "integer"
-+                },
-+                "interfaces": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "ack_result": {
-+                                "type": "integer"
-+                            },
-+                            "uuid": {
-+                                "type": "string"
-+                            },
-+                            "version": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "req": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "frag_cnt": {
-+                            "type": "integer"
-+                        },
-+                        "opnum": {
-+                            "type": "integer"
-+                        },
-+                        "stub_data_size": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "res": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "frag_cnt": {
-+                            "type": "integer"
-+                        },
-+                        "stub_data_size": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "dhcp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "assigned_ip": {
-+                    "type": "string"
-+                },
-+                "client_id": {
-+                    "type": "string"
-+                },
-+                "client_ip": {
-+                    "type": "string"
-+                },
-+                "client_mac": {
-+                    "type": "string"
-+                },
-+                "dhcp_type": {
-+                    "type": "string"
-+                },
-+                "hostname": {
-+                    "type": "string"
-+                },
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "lease_time": {
-+                    "type": "integer"
-+                },
-+                "next_server_ip": {
-+                    "type": "string"
-+                },
-+                "rebinding_time": {
-+                    "type": "integer"
-+                },
-+                "relay_ip": {
-+                    "type": "string"
-+                },
-+                "renewal_time": {
-+                    "type": "integer"
-+                },
-+                "subnet_mask": {
-+                    "type": "string"
-+                },
-+                "type": {
-+                    "type": "string"
-+                },
-+                "dns_servers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "params": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "routers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "dnp3": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "dst": {
-+                    "type": "integer"
-+                },
-+                "src": {
-+                    "type": "integer"
-+                },
-+                "type": {
-+                    "type": "string"
-+                },
-+                "application": {
-+                    "type": "object",
-+                    "properties": {
-+                        "complete": {
-+                            "type": "boolean"
-+                        },
-+                        "function_code": {
-+                            "type": "integer"
-+                        },
-+                        "objects": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "object",
-+                                "properties": {
-+                                    "count": {
-+                                        "type": "integer"
-+                                    },
-+                                    "group": {
-+                                        "type": "integer"
-+                                    },
-+                                    "prefix_code": {
-+                                        "type": "integer"
-+                                    },
-+                                    "qualifier": {
-+                                        "type": "integer"
-+                                    },
-+                                    "range_code": {
-+                                        "type": "integer"
-+                                    },
-+                                    "start": {
-+                                        "type": "integer"
-+                                    },
-+                                    "stop": {
-+                                        "type": "integer"
-+                                    },
-+                                    "variation": {
-+                                        "type": "integer"
-+                                    },
-+                                    "points": {
-+                                        "type": "array",
-+                                        "items": {
-+                                            "type": "object",
-+                                            "additionalProperties": true
-+                                        }
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "control": {
-+                            "type": "object",
-+                            "properties": {
-+                                "con": {
-+                                    "type": "boolean"
-+                                },
-+                                "fin": {
-+                                    "type": "boolean"
-+                                },
-+                                "fir": {
-+                                    "type": "boolean"
-+                                },
-+                                "sequence": {
-+                                    "type": "integer"
-+                                },
-+                                "uns": {
-+                                    "type": "boolean"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "control": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dir": {
-+                            "type": "boolean"
-+                        },
-+                        "fcb": {
-+                            "type": "boolean"
-+                        },
-+                        "fcv": {
-+                            "type": "boolean"
-+                        },
-+                        "function_code": {
-+                            "type": "integer"
-+                        },
-+                        "pri": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "iin": {
-+                    "type": "object",
-+                    "properties": {
-+                        "indicators": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "request": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dst": {
-+                            "type": "integer"
-+                        },
-+                        "src": {
-+                            "type": "integer"
-+                        },
-+                        "type": {
-+                            "type": "string"
-+                        },
-+                        "application": {
-+                            "type": "object",
-+                            "properties": {
-+                                "complete": {
-+                                    "type": "boolean"
-+                                },
-+                                "function_code": {
-+                                    "type": "integer"
-+                                },
-+                                "objects": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "count": {
-+                                                "type": "integer"
-+                                            },
-+                                            "group": {
-+                                                "type": "integer"
-+                                            },
-+                                            "prefix_code": {
-+                                                "type": "integer"
-+                                            },
-+                                            "qualifier": {
-+                                                "type": "integer"
-+                                            },
-+                                            "range_code": {
-+                                                "type": "integer"
-+                                            },
-+                                            "start": {
-+                                                "type": "integer"
-+                                            },
-+                                            "stop": {
-+                                                "type": "integer"
-+                                            },
-+                                            "variation": {
-+                                                "type": "integer"
-+                                            },
-+                                            "points": {
-+                                                "type": "array",
-+                                                "items": {
-+                                                    "type": "object",
-+                                                    "additionalProperties": true
-+                                                }
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                },
-+                                "control": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "con": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "fin": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "fir": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "sequence": {
-+                                            "type": "integer"
-+                                        },
-+                                        "uns": {
-+                                            "type": "boolean"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "control": {
-+                            "type": "object",
-+                            "properties": {
-+                                "dir": {
-+                                    "type": "boolean"
-+                                },
-+                                "fcb": {
-+                                    "type": "boolean"
-+                                },
-+                                "fcv": {
-+                                    "type": "boolean"
-+                                },
-+                                "function_code": {
-+                                    "type": "integer"
-+                                },
-+                                "pri": {
-+                                    "type": "boolean"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "response": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dst": {
-+                            "type": "integer"
-+                        },
-+                        "src": {
-+                            "type": "integer"
-+                        },
-+                        "type": {
-+                            "type": "string"
-+                        },
-+                        "application": {
-+                            "type": "object",
-+                            "properties": {
-+                                "complete": {
-+                                    "type": "boolean"
-+                                },
-+                                "function_code": {
-+                                    "type": "integer"
-+                                },
-+                                "objects": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "count": {
-+                                                "type": "integer"
-+                                            },
-+                                            "group": {
-+                                                "type": "integer"
-+                                            },
-+                                            "prefix_code": {
-+                                                "type": "integer"
-+                                            },
-+                                            "qualifier": {
-+                                                "type": "integer"
-+                                            },
-+                                            "range_code": {
-+                                                "type": "integer"
-+                                            },
-+                                            "start": {
-+                                                "type": "integer"
-+                                            },
-+                                            "stop": {
-+                                                "type": "integer"
-+                                            },
-+                                            "variation": {
-+                                                "type": "integer"
-+                                            },
-+                                            "points": {
-+                                                "type": "array",
-+                                                "items": {
-+                                                    "type": "object",
-+                                                    "additionalProperties": true
-+                                                }
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                },
-+                                "control": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "con": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "fin": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "fir": {
-+                                            "type": "boolean"
-+                                        },
-+                                        "sequence": {
-+                                            "type": "integer"
-+                                        },
-+                                        "uns": {
-+                                            "type": "boolean"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "control": {
-+                            "type": "object",
-+                            "properties": {
-+                                "dir": {
-+                                    "type": "boolean"
-+                                },
-+                                "fcb": {
-+                                    "type": "boolean"
-+                                },
-+                                "fcv": {
-+                                    "type": "boolean"
-+                                },
-+                                "function_code": {
-+                                    "type": "integer"
-+                                },
-+                                "pri": {
-+                                    "type": "boolean"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "iin": {
-+                            "type": "object",
-+                            "properties": {
-+                                "indicators": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "string"
-+                                    }
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "dns": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "aa": {
-+                    "type": "boolean"
-+                },
-+                "flags": {
-+                    "type": "string"
-+                },
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "qr": {
-+                    "type": "boolean"
-+                },
-+                "ra": {
-+                    "type": "boolean"
-+                },
-+                "rcode": {
-+                    "type": "string"
-+                },
-+                "rd": {
-+                    "type": "boolean"
-+                },
-+                "rrname": {
-+                    "type": "string"
-+                },
-+                "rrtype": {
-+                    "type": "string"
-+                },
-+                "tx_id": {
-+                    "type": "integer"
-+                },
-+                "type": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "integer"
-+                },
-+                "answers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "optional": true,
-+                        "properties": {
-+                            "rdata": {
-+                                "type": "string"
-+                            },
-+                            "rrname": {
-+                                "type": "string"
-+                            },
-+                            "rrtype": {
-+                                "type": "string"
-+                            },
-+                            "ttl": {
-+                                "type": "integer"
-+                            },
-+                            "srv": {
-+                                "type": "object",
-+                                "optional": true,
-+                                "properties": {
-+                                    "name": {
-+                                        "type": "string"
-+                                    },
-+                                    "port": {
-+                                        "type": "integer"
-+                                    },
-+                                    "priority": {
-+                                        "type": "integer"
-+                                    },
-+                                    "weight": {
-+                                        "type": "integer"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "authorities": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "optional": true,
-+                        "properties": {
-+                            "rdata": {
-+                                "type": "string"
-+                            },
-+                            "rrname": {
-+                                "type": "string"
-+                            },
-+                            "rrtype": {
-+                                "type": "string"
-+                            },
-+                            "ttl": {
-+                                "type": "integer"
-+                            },
-+                            "soa": {
-+                                "type": "object",
-+                                "optional": true,
-+                                "properties": {
-+                                    "expire": {
-+                                        "type": "integer"
-+                                    },
-+                                    "minimum": {
-+                                        "type": "integer"
-+                                    },
-+                                    "mname": {
-+                                        "type": "string"
-+                                    },
-+                                    "refresh": {
-+                                        "type": "integer"
-+                                    },
-+                                    "retry": {
-+                                        "type": "integer"
-+                                    },
-+                                    "rname": {
-+                                        "type": "string"
-+                                    },
-+                                    "serial": {
-+                                        "type": "integer"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "query": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "optional": true,
-+                        "properties": {
-+                            "id": {
-+                                "type": "integer"
-+                            },
-+                            "rrname": {
-+                                "type": "string"
-+                            },
-+                            "rrtype": {
-+                                "type": "string"
-+                            },
-+                            "tx_id": {
-+                                "type": "integer"
-+                            },
-+                            "type": {
-+                                "type": "string"
-+                            },
-+                            "z": {
-+                                "type": "boolean"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "answer": {
-+                    "type": "object",
-+                    "properties": {
-+                        "flags": {
-+                            "type": "string"
-+                        },
-+                        "id": {
-+                            "type": "integer"
-+                        },
-+                        "qr": {
-+                            "type": "boolean"
-+                        },
-+                        "ra": {
-+                            "type": "boolean"
-+                        },
-+                        "rcode": {
-+                            "type": "string"
-+                        },
-+                        "rd": {
-+                            "type": "boolean"
-+                        },
-+                        "rrname": {
-+                            "type": "string"
-+                        },
-+                        "rrtype": {
-+                            "type": "string"
-+                        },
-+                        "type": {
-+                            "type": "string"
-+                        },
-+                        "version": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "grouped": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "A": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "AAAA": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "CNAME": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "MX": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "NULL": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "PTR": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "SRV": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "object",
-+                                "optional": true,
-+                                "properties": {
-+                                    "name": {
-+                                        "type": "string"
-+                                    },
-+                                    "port": {
-+                                        "type": "integer"
-+                                    },
-+                                    "priority": {
-+                                        "type": "integer"
-+                                    },
-+                                    "weight": {
-+                                        "type": "integer"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "TXT": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "z": {
-+                    "type": "boolean"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "drop": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "ack": {
-+                    "type": "boolean"
-+                },
-+                "fin": {
-+                    "type": "boolean"
-+                },
-+                "icmp_id": {
-+                    "type": "integer"
-+                },
-+                "icmp_seq": {
-+                    "type": "integer"
-+                },
-+                "ipid": {
-+                    "type": "integer"
-+                },
-+                "len": {
-+                    "type": "integer"
-+                },
-+                "psh": {
-+                    "type": "boolean"
-+                },
-+                "rst": {
-+                    "type": "boolean"
-+                },
-+                "syn": {
-+                    "type": "boolean"
-+                },
-+                "tcpack": {
-+                    "type": "integer"
-+                },
-+                "tcpres": {
-+                    "type": "integer"
-+                },
-+                "tcpseq": {
-+                    "type": "integer"
-+                },
-+                "tcpurgp": {
-+                    "type": "integer"
-+                },
-+                "tcpwin": {
-+                    "type": "integer"
-+                },
-+                "tos": {
-+                    "type": "integer"
-+                },
-+                "ttl": {
-+                    "type": "integer"
-+                },
-+                "urg": {
-+                    "type": "boolean"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "email": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "body_md5": {
-+                    "type": "string"
-+                },
-+                "from": {
-+                    "type": "string"
-+                },
-+                "status": {
-+                    "type": "string"
-+                },
-+                "subject": {
-+                    "type": "string"
-+                },
-+                "subject_md5": {
-+                    "type": "string"
-+                },
-+                "url": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "attachment": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "to": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "engine": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "error": {
-+                    "type": "string"
-+                },
-+                "error_code": {
-+                    "type": "integer"
-+                },
-+                "message": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "ether": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "dest_mac": {
-+                    "type": "string"
-+                },
-+                "src_mac": {
-+                    "type": "string"
-+                },
-+                "dest_macs": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "src_macs": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "fileinfo": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "end": {
-+                    "type": "integer"
-+                },
-+                "file_id": {
-+                    "type": "integer"
-+                },
-+                "filename": {
-+                    "type": "string"
-+                },
-+                "gaps": {
-+                    "type": "boolean"
-+                },
-+                "magic": {
-+                    "type": "string"
-+                },
-+                "md5": {
-+                    "type": "string"
-+                },
-+                "sha1": {
-+                    "type": "string"
-+                },
-+                "sha256": {
-+                    "type": "string"
-+                },
-+                "size": {
-+                    "type": "integer"
-+                },
-+                "start": {
-+                    "type": "integer"
-+                },
-+                "state": {
-+                    "type": "string"
-+                },
-+                "stored": {
-+                    "type": "boolean"
-+                },
-+                "tx_id": {
-+                    "type": "integer"
-+                },
-+                "sid": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "integer"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "flow": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "action": {
-+                    "type": "string"
-+                },
-+                "age": {
-+                    "type": "integer"
-+                },
-+                "alerted": {
-+                    "type": "boolean"
-+                },
-+                "bypass": {
-+                    "type": "string"
-+                },
-+                "bypassed": {
-+                    "type": "object",
-+                    "optional": false,
-+                    "properties": {
-+                        "pkts_toserver": {
-+                            "type": "integer"
-+                        },
-+                        "pkts_toclient": {
-+                            "type": "integer"
-+                        },
-+                        "bytes_toserver": {
-+                            "type": "integer"
-+                        },
-+                        "bytes_toclient": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperites": false
-+                },
-+                "bytes_toclient": {
-+                    "type": "integer"
-+                },
-+                "bytes_toserver": {
-+                    "type": "integer"
-+                },
-+                "end": {
-+                    "type": "string"
-+                },
-+                "pkts_toclient": {
-+                    "type": "integer"
-+                },
-+                "pkts_toserver": {
-+                    "type": "integer"
-+                },
-+                "reason": {
-+                    "type": "string"
-+                },
-+                "start": {
-+                    "type": "string"
-+                },
-+                "state": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "frame": {
-+            "type": "object",
-+            "properties": {
-+                "type": {
-+                    "type": "string"
-+                },
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "direction": {
-+                    "type": "string"
-+                },
-+                "stream_offset": {
-+                    "type": "integer"
-+                },
-+                "length": {
-+                    "type": "integer"
-+                },
-+                "complete": {
-+                    "type": "boolean"
-+                },
-+                "payload": {
-+                    "type": "string"
-+                },
-+                "payload_printable": {
-+                    "type": "string"
-+                },
-+                "tx_id": {
-+                    "type": "integer"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "ftp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "command": {
-+                    "type": "string"
-+                },
-+                "command_data": {
-+                    "type": "string"
-+                },
-+                "command_truncated": {
-+                    "type": "boolean"
-+                },
-+                "dynamic_port": {
-+                    "type": "integer"
-+                },
-+                "mode": {
-+                    "type": "string"
-+                },
-+                "reply_received": {
-+                    "type": "string"
-+                },
-+                "reply_truncated": {
-+                    "type": "boolean"
-+                },
-+                "completion_code": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "reply": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "ftp_data": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "command": {
-+                    "type": "string"
-+                },
-+                "filename": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "http": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "hostname": {
-+                    "type": "string"
-+                },
-+                "http_content_type": {
-+                    "type": "string"
-+                },
-+                "http_method": {
-+                    "type": "string"
-+                },
-+                "http_port": {
-+                    "type": "integer"
-+                },
-+                "http_refer": {
-+                    "type": "string"
-+                },
-+                "http_user_agent": {
-+                    "type": "string"
-+                },
-+                "length": {
-+                    "type": "integer"
-+                },
-+                "protocol": {
-+                    "type": "string"
-+                },
-+                "redirect": {
-+                    "type": "string"
-+                },
-+                "status": {
-+                    "type": "integer"
-+                },
-+                "url": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "string"
-+                },
-+                "xff": {
-+                    "type": "string"
-+                },
-+                "request_headers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "name": {
-+                                "type": "string"
-+                            },
-+                            "table_size_update": {
-+                                "type": "integer"
-+                            },
-+                            "value": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "response_headers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "name": {
-+                                "type": "string"
-+                            },
-+                            "table_size_update": {
-+                                "type": "integer"
-+                            },
-+                            "value": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "content_range": {
-+                    "type": "object",
-+                    "properties": {
-+                        "end": {
-+                            "type": "integer"
-+                        },
-+                        "raw": {
-+                            "type": "string"
-+                        },
-+                        "size": {
-+                            "type": "integer"
-+                        },
-+                        "start": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "http2": {
-+                    "type": "object",
-+                    "properties": {
-+                        "stream_id": {
-+                            "type": "integer"
-+                        },
-+                        "request": {
-+                            "type": "object",
-+                            "properties": {
-+                                "error_code": {
-+                                    "type": "string"
-+                                },
-+                                "priority": {
-+                                    "type": "integer"
-+                                },
-+                                "settings": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "settings_id": {
-+                                                "type": "string"
-+                                            },
-+                                            "settings_value": {
-+                                                "type": "integer"
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "response": {
-+                            "type": "object",
-+                            "properties": {
-+                                "error_code": {
-+                                    "type": "string"
-+                                },
-+                                "settings": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "settings_id": {
-+                                                "type": "string"
-+                                            },
-+                                            "settings_value": {
-+                                                "type": "integer"
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "http2": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "http_method": {
-+                    "type": "string"
-+                },
-+                "http_user_agent": {
-+                    "type": "string"
-+                },
-+                "length": {
-+                    "type": "integer"
-+                },
-+                "status": {
-+                    "type": "integer"
-+                },
-+                "url": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "string"
-+                },
-+                "request_headers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "name": {
-+                                "type": "string"
-+                            },
-+                            "table_size_update": {
-+                                "type": "integer"
-+                            },
-+                            "value": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "response_headers": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "name": {
-+                                "type": "string"
-+                            },
-+                            "table_size_update": {
-+                                "type": "integer"
-+                            },
-+                            "value": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "http2": {
-+                    "type": "object",
-+                    "properties": {
-+                        "stream_id": {
-+                            "type": "integer"
-+                        },
-+                        "request": {
-+                            "type": "object",
-+                            "properties": {
-+                                "priority": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "response": {
-+                            "type": "object",
-+                            "properties": {
-+                                "error_code": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "ike": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "alg_auth": {
-+                    "type": "string"
-+                },
-+                "alg_auth_raw": {
-+                    "type": "integer"
-+                },
-+                "alg_dh": {
-+                    "type": "string"
-+                },
-+                "alg_dh_raw": {
-+                    "type": "integer"
-+                },
-+                "alg_enc": {
-+                    "type": "string"
-+                },
-+                "alg_enc_raw": {
-+                    "type": "integer"
-+                },
-+                "alg_hash": {
-+                    "type": "string"
-+                },
-+                "alg_hash_raw": {
-+                    "type": "integer"
-+                },
-+                "exchange_type": {
-+                    "type": "integer"
-+                },
-+                "exchange_type_verbose": {
-+                    "type": "string"
-+                },
-+                "init_spi": {
-+                    "type": "string"
-+                },
-+                "message_id": {
-+                    "type": "integer"
-+                },
-+                "resp_spi": {
-+                    "type": "string"
-+                },
-+                "role": {
-+                    "type": "string"
-+                },
-+                "sa_key_length": {
-+                    "type": "string"
-+                },
-+                "sa_key_length_raw": {
-+                    "type": "integer"
-+                },
-+                "sa_life_duration": {
-+                    "type": "string"
-+                },
-+                "sa_life_duration_raw": {
-+                    "type": "integer"
-+                },
-+                "sa_life_type": {
-+                    "type": "string"
-+                },
-+                "sa_life_type_raw": {
-+                    "type": "integer"
-+                },
-+                "version_major": {
-+                    "type": "integer"
-+                },
-+                "version_minor": {
-+                    "type": "integer"
-+                },
-+                "payload": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "ikev1": {
-+                    "type": "object",
-+                    "properties": {
-+                        "doi": {
-+                            "type": "integer"
-+                        },
-+                        "encrypted_payloads": {
-+                            "type": "boolean"
-+                        },
-+                        "vendor_ids": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "client": {
-+                            "type": "object",
-+                            "properties": {
-+                                "key_exchange_payload": {
-+                                    "type": "string"
-+                                },
-+                                "key_exchange_payload_length": {
-+                                    "type": "integer"
-+                                },
-+                                "nonce_payload": {
-+                                    "type": "string"
-+                                },
-+                                "nonce_payload_length": {
-+                                    "type": "integer"
-+                                },
-+                                "proposals": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "alg_auth": {
-+                                                "type": "string"
-+                                            },
-+                                            "alg_auth_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "alg_dh": {
-+                                                "type": "string"
-+                                            },
-+                                            "alg_dh_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "alg_enc": {
-+                                                "type": "string"
-+                                            },
-+                                            "alg_enc_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "alg_hash": {
-+                                                "type": "string"
-+                                            },
-+                                            "alg_hash_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "sa_key_length": {
-+                                                "type": "string"
-+                                            },
-+                                            "sa_key_length_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "sa_life_duration": {
-+                                                "type": "string"
-+                                            },
-+                                            "sa_life_duration_raw": {
-+                                                "type": "integer"
-+                                            },
-+                                            "sa_life_type": {
-+                                                "type": "string"
-+                                            },
-+                                            "sa_life_type_raw": {
-+                                                "type": "integer"
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "server": {
-+                            "type": "object",
-+                            "properties": {
-+                                "key_exchange_payload": {
-+                                    "type": "string"
-+                                },
-+                                "key_exchange_payload_length": {
-+                                    "type": "integer"
-+                                },
-+                                "nonce_payload": {
-+                                    "type": "string"
-+                                },
-+                                "nonce_payload_length": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "ikev2": {
-+                    "type": "object",
-+                    "properties": {
-+                        "errors": {
-+                            "type": "integer"
-+                        },
-+                        "notify": {
-+                            "type": "array"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "krb5": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "cname": {
-+                    "type": "string"
-+                },
-+                "encryption": {
-+                    "type": "string"
-+                },
-+                "error_code": {
-+                    "type": "string"
-+                },
-+                "failed_request": {
-+                    "type": "string"
-+                },
-+                "msg_type": {
-+                    "type": "string"
-+                },
-+                "realm": {
-+                    "type": "string"
-+                },
-+                "sname": {
-+                    "type": "string"
-+                },
-+                "weak_encryption": {
-+                    "type": "boolean"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "metadata": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "flowbits": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "flowvars": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "gid": {
-+                                "type": "string"
-+                            },
-+                            "key": {
-+                                "type": "string"
-+                            },
-+                            "value": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": true
-+                    }
-+                },
-+                "pktvars": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "uid": {
-+                                "type": "string"
-+                            },
-+                            "username": {
-+                                "type": "string"
-+                            }
-+                        },
-+                        "additionalProperties": false
-+                    }
-+                },
-+                "flowints": {
-+                    "type": "object",
-+                    "additionalProperties": true
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "modbus": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "request": {
-+                    "type": "object",
-+                    "properties": {
-+                        "access_type": {
-+                            "type": "string"
-+                        },
-+                        "category": {
-+                            "type": "string"
-+                        },
-+                        "data": {
-+                            "type": "string"
-+                        },
-+                        "error_flags": {
-+                            "type": "string"
-+                        },
-+                        "function_code": {
-+                            "type": "string"
-+                        },
-+                        "function_raw": {
-+                            "type": "integer"
-+                        },
-+                        "protocol_id": {
-+                            "type": "integer"
-+                        },
-+                        "transaction_id": {
-+                            "type": "integer"
-+                        },
-+                        "unit_id": {
-+                            "type": "integer"
-+                        },
-+                        "diagnostic": {
-+                            "type": "object",
-+                            "properties": {
-+                                "code": {
-+                                    "type": "string"
-+                                },
-+                                "data": {
-+                                    "type": "string"
-+                                },
-+                                "raw": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "mei": {
-+                            "type": "object",
-+                            "properties": {
-+                                "code": {
-+                                    "type": "string"
-+                                },
-+                                "data": {
-+                                    "type": "string"
-+                                },
-+                                "raw": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "read": {
-+                            "type": "object",
-+                            "properties": {
-+                                "address": {
-+                                    "type": "integer"
-+                                },
-+                                "quantity": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "write": {
-+                            "type": "object",
-+                            "properties": {
-+                                "address": {
-+                                    "type": "integer"
-+                                },
-+                                "data": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "response": {
-+                    "type": "object",
-+                    "properties": {
-+                        "access_type": {
-+                            "type": "string"
-+                        },
-+                        "category": {
-+                            "type": "string"
-+                        },
-+                        "data": {
-+                            "type": "string"
-+                        },
-+                        "error_flags": {
-+                            "type": "string"
-+                        },
-+                        "function_code": {
-+                            "type": "string"
-+                        },
-+                        "function_raw": {
-+                            "type": "integer"
-+                        },
-+                        "protocol_id": {
-+                            "type": "integer"
-+                        },
-+                        "transaction_id": {
-+                            "type": "integer"
-+                        },
-+                        "unit_id": {
-+                            "type": "integer"
-+                        },
-+                        "diagnostic": {
-+                            "type": "object",
-+                            "properties": {
-+                                "code": {
-+                                    "type": "string"
-+                                },
-+                                "data": {
-+                                    "type": "string"
-+                                },
-+                                "raw": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "exception": {
-+                            "type": "object",
-+                            "properties": {
-+                                "code": {
-+                                    "type": "string"
-+                                },
-+                                "raw": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "read": {
-+                            "type": "object",
-+                            "properties": {
-+                                "data": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "write": {
-+                            "type": "object",
-+                            "properties": {
-+                                "address": {
-+                                    "type": "integer"
-+                                },
-+                                "data": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "mqtt": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "connack": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "return_code": {
-+                            "type": "integer"
-+                        },
-+                        "session_present": {
-+                            "type": "boolean"
-+                        },
-+                        "properties": {
-+                            "type": "object",
-+                            "additionalProperties": true
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "connect": {
-+                    "type": "object",
-+                    "properties": {
-+                        "client_id": {
-+                            "type": "string"
-+                        },
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "password": {
-+                            "type": "string"
-+                        },
-+                        "protocol_string": {
-+                            "type": "string"
-+                        },
-+                        "protocol_version": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "username": {
-+                            "type": "string"
-+                        },
-+                        "flags": {
-+                            "type": "object",
-+                            "properties": {
-+                                "clean_session": {
-+                                    "type": "boolean"
-+                                },
-+                                "password": {
-+                                    "type": "boolean"
-+                                },
-+                                "username": {
-+                                    "type": "boolean"
-+                                },
-+                                "will": {
-+                                    "type": "boolean"
-+                                },
-+                                "will_retain": {
-+                                    "type": "boolean"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "properties": {
-+                            "type": "object",
-+                            "additionalProperties": true
-+                        },
-+                        "will": {
-+                            "type": "object",
-+                            "properties": {
-+                                "message": {
-+                                    "type": "string"
-+                                },
-+                                "topic": {
-+                                    "type": "string"
-+                                },
-+                                "properties": {
-+                                    "type": "object",
-+                                    "additionalProperties": true
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "disconnect": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "reason_code": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "properties": {
-+                            "type": "object",
-+                            "additionalProperties": true
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "pingreq": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "pingresp": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "puback": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "reason_code": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "pubcomp": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "reason_code": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "publish": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message": {
-+                            "type": "string"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "skipped_length": {
-+                            "type": "integer"
-+                        },
-+                        "topic": {
-+                            "type": "string"
-+                        },
-+                        "truncated": {
-+                            "type": "boolean"
-+                        },
-+                        "properties": {
-+                            "type": "object",
-+                            "additionalProperties": true
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "pubrec": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "reason_code": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "pubrel": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "reason_code": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "suback": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "qos_granted": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "integer"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "subscribe": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "topics": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "object",
-+                                "properties": {
-+                                    "qos": {
-+                                        "type": "integer"
-+                                    },
-+                                    "topic": {
-+                                        "type": "string"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "unsuback": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "reason_codes": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "integer"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "unsubscribe": {
-+                    "type": "object",
-+                    "properties": {
-+                        "dup": {
-+                            "type": "boolean"
-+                        },
-+                        "message_id": {
-+                            "type": "integer"
-+                        },
-+                        "qos": {
-+                            "type": "integer"
-+                        },
-+                        "retain": {
-+                            "type": "boolean"
-+                        },
-+                        "topics": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "netflow": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "age": {
-+                    "type": "integer"
-+                },
-+                "bytes": {
-+                    "type": "integer"
-+                },
-+                "end": {
-+                    "type": "string"
-+                },
-+                "max_ttl": {
-+                    "type": "integer"
-+                },
-+                "min_ttl": {
-+                    "type": "integer"
-+                },
-+                "pkts": {
-+                    "type": "integer"
-+                },
-+                "start": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "nfs": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "file_tx": {
-+                    "type": "boolean"
-+                },
-+                "filename": {
-+                    "type": "string"
-+                },
-+                "hhash": {
-+                    "type": "string"
-+                },
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "procedure": {
-+                    "type": "string"
-+                },
-+                "status": {
-+                    "type": "string"
-+                },
-+                "type": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "integer"
-+                },
-+                "read": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "chunks": {
-+                            "type": "integer"
-+                        },
-+                        "first": {
-+                            "type": "boolean"
-+                        },
-+                        "last": {
-+                            "type": "boolean"
-+                        },
-+                        "last_xid": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "rename": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "from": {
-+                            "type": "string"
-+                        },
-+                        "to": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "write": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "chunks": {
-+                            "type": "integer"
-+                        },
-+                        "first": {
-+                            "type": "boolean"
-+                        },
-+                        "last": {
-+                            "type": "boolean"
-+                        },
-+                        "last_xid": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "packet_info": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "linktype": {
-+                    "type": "integer"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "pgsql": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "request": {
-+                    "type": "object",
-+                    "properties": {
-+                        "message": {
-+                            "type": "string"
-+                        },
-+                        "password": {
-+                            "type": "string"
-+                        },
-+                        "password_message": {
-+                            "type": "string"
-+                        },
-+                        "protocol_version": {
-+                            "type": "string"
-+                        },
-+                        "sasl_authentication_mechanism": {
-+                            "type": "string"
-+                        },
-+                        "sasl_param": {
-+                            "type": "string"
-+                        },
-+                        "sasl_response": {
-+                            "type": "string"
-+                        },
-+                        "simple_query": {
-+                            "type": "string"
-+                        },
-+                        "startup_parameters": {
-+                            "type": "object",
-+                            "properties": {
-+                                "database": {
-+                                    "type": "string"
-+                                },
-+                                "optional_parameters": {
-+                                    "type": "array",
-+                                    "items": {
-+                                        "type": "object",
-+                                        "properties": {
-+                                            "application_name": {
-+                                                "type": "string"
-+                                            },
-+                                            "client_encoding": {
-+                                                "type": "string"
-+                                            },
-+                                            "replication": {
-+                                                "type": "string"
-+                                            }
-+                                        },
-+                                        "additionalProperties": false
-+                                    }
-+                                },
-+                                "user": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "response": {
-+                    "type": "object",
-+                    "properties": {
-+                        "authentication_md5_password": {
-+                            "type": "string"
-+                        },
-+                        "authentication_sasl_final": {
-+                            "type": "string"
-+                        },
-+                        "code": {
-+                            "type": "string"
-+                        },
-+                        "command_completed": {
-+                            "type": "string"
-+                        },
-+                        "data_rows": {
-+                            "type": "integer"
-+                        },
-+                        "data_size": {
-+                            "type": "integer"
-+                        },
-+                        "field_count": {
-+                            "type": "integer"
-+                        },
-+                        "file": {
-+                            "type": "string"
-+                        },
-+                        "line": {
-+                            "type": "string"
-+                        },
-+                        "message": {
-+                            "type": "string"
-+                        },
-+                        "parameter_status": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "object",
-+                                "properties": {
-+                                    "application_name": {
-+                                        "type": "string"
-+                                    },
-+                                    "client_encoding": {
-+                                        "type": "string"
-+                                    },
-+                                    "date_style": {
-+                                        "type": "string"
-+                                    },
-+                                    "integer_datetimes": {
-+                                        "type": "string"
-+                                    },
-+                                    "interval_style": {
-+                                        "type": "string"
-+                                    },
-+                                    "is_superuser": {
-+                                        "type": "string"
-+                                    },
-+                                    "server_encoding": {
-+                                        "type": "string"
-+                                    },
-+                                    "server_version": {
-+                                        "type": "string"
-+                                    },
-+                                    "session_authorization": {
-+                                        "type": "string"
-+                                    },
-+                                    "standard_conforming_strings": {
-+                                        "type": "string"
-+                                    },
-+                                    "time_zone": {
-+                                        "type": "string"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "process_id": {
-+                            "type": "integer"
-+                        },
-+                        "routine": {
-+                            "type": "string"
-+                        },
-+                        "secret_key": {
-+                            "type": "integer"
-+                        },
-+                        "severity_localizable": {
-+                            "type": "string"
-+                        },
-+                        "severity_non_localizable": {
-+                            "type": "string"
-+                        },
-+                        "ssl_accepted": {
-+                            "type": "boolean"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "tx_id": {
-+                    "type": "integer"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "quic": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "cyu": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "object",
-+                        "properties": {
-+                            "hash": {
-+                                "type": "string"
-+                            },
-+                            "string": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "sni": {
-+                    "type": "string"
-+                },
-+                "ua": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "rdp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "cookie": {
-+                    "type": "string"
-+                },
-+                "event_type": {
-+                    "type": "string"
-+                },
-+                "tx_id": {
-+                    "type": "integer"
-+                },
-+                "channels": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "client": {
-+                    "type": "object",
-+                    "properties": {
-+                        "build": {
-+                            "type": "string"
-+                        },
-+                        "client_name": {
-+                            "type": "string"
-+                        },
-+                        "color_depth": {
-+                            "type": "integer"
-+                        },
-+                        "desktop_height": {
-+                            "type": "integer"
-+                        },
-+                        "desktop_width": {
-+                            "type": "integer"
-+                        },
-+                        "function_keys": {
-+                            "type": "integer"
-+                        },
-+                        "id": {
-+                            "type": "string"
-+                        },
-+                        "keyboard_layout": {
-+                            "type": "string"
-+                        },
-+                        "keyboard_type": {
-+                            "type": "string"
-+                        },
-+                        "product_id": {
-+                            "type": "integer"
-+                        },
-+                        "version": {
-+                            "type": "string"
-+                        },
-+                        "capabilities": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "rfb": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "screen_shared": {
-+                    "type": "boolean"
-+                },
-+                "authentication": {
-+                    "type": "object",
-+                    "properties": {
-+                        "security_result": {
-+                            "type": "string"
-+                        },
-+                        "security_type": {
-+                            "type": "integer"
-+                        },
-+                        "vnc": {
-+                            "type": "object",
-+                            "properties": {
-+                                "challenge": {
-+                                    "type": "string"
-+                                },
-+                                "response": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "client_protocol_version": {
-+                    "type": "object",
-+                    "properties": {
-+                        "major": {
-+                            "type": "string"
-+                        },
-+                        "minor": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "framebuffer": {
-+                    "type": "object",
-+                    "properties": {
-+                        "height": {
-+                            "type": "integer"
-+                        },
-+                        "name": {
-+                            "type": "string"
-+                        },
-+                        "width": {
-+                            "type": "integer"
-+                        },
-+                        "pixel_format": {
-+                            "type": "object",
-+                            "properties": {
-+                                "big_endian": {
-+                                    "type": "boolean"
-+                                },
-+                                "bits_per_pixel": {
-+                                    "type": "integer"
-+                                },
-+                                "blue_max": {
-+                                    "type": "integer"
-+                                },
-+                                "blue_shift": {
-+                                    "type": "integer"
-+                                },
-+                                "depth": {
-+                                    "type": "integer"
-+                                },
-+                                "green_max": {
-+                                    "type": "integer"
-+                                },
-+                                "green_shift": {
-+                                    "type": "integer"
-+                                },
-+                                "red_max": {
-+                                    "type": "integer"
-+                                },
-+                                "red_shift": {
-+                                    "type": "integer"
-+                                },
-+                                "true_color": {
-+                                    "type": "boolean"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "server_protocol_version": {
-+                    "type": "object",
-+                    "properties": {
-+                        "major": {
-+                            "type": "string"
-+                        },
-+                        "minor": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "rpc": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "auth_type": {
-+                    "type": "string"
-+                },
-+                "status": {
-+                    "type": "string"
-+                },
-+                "xid": {
-+                    "type": "integer"
-+                },
-+                "creds": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "gid": {
-+                            "type": "integer"
-+                        },
-+                        "machine_name": {
-+                            "type": "string"
-+                        },
-+                        "uid": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "sip": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "code": {
-+                    "type": "string"
-+                },
-+                "method": {
-+                    "type": "string"
-+                },
-+                "reason": {
-+                    "type": "string"
-+                },
-+                "request_line": {
-+                    "type": "string"
-+                },
-+                "response_line": {
-+                    "type": "string"
-+                },
-+                "uri": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "smb": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "access": {
-+                    "type": "string"
-+                },
-+                "accessed": {
-+                    "type": "integer"
-+                },
-+                "changed": {
-+                    "type": "integer"
-+                },
-+                "client_guid": {
-+                    "type": "string"
-+                },
-+                "command": {
-+                    "type": "string"
-+                },
-+                "created": {
-+                    "type": "integer"
-+                },
-+                "dialect": {
-+                    "type": "string"
-+                },
-+                "directory": {
-+                    "type": "string"
-+                },
-+                "disposition": {
-+                    "type": "string"
-+                },
-+                "filename": {
-+                    "type": "string"
-+                },
-+                "fuid": {
-+                    "type": "string"
-+                },
-+                "function": {
-+                    "type": "string"
-+                },
-+                "id": {
-+                    "type": "integer"
-+                },
-+                "max_read_size": {
-+                    "type": "integer"
-+                },
-+                "max_write_size": {
-+                    "type": "integer"
-+                },
-+                "modified": {
-+                    "type": "integer"
-+                },
-+                "named_pipe": {
-+                    "type": "string"
-+                },
-+                "request_done": {
-+                    "type": "boolean"
-+                },
-+                "response_done": {
-+                    "type": "boolean"
-+                },
-+                "server_guid": {
-+                    "type": "string"
-+                },
-+                "session_id": {
-+                    "type": "integer"
-+                },
-+                "share": {
-+                    "type": "string"
-+                },
-+                "share_type": {
-+                    "type": "string"
-+                },
-+                "size": {
-+                    "type": "integer"
-+                },
-+                "status": {
-+                    "type": "string"
-+                },
-+                "status_code": {
-+                    "type": "string"
-+                },
-+                "tree_id": {
-+                    "type": "integer"
-+                },
-+                "client_dialects": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "dcerpc": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "call_id": {
-+                            "type": "integer"
-+                        },
-+                        "opnum": {
-+                            "type": "integer"
-+                        },
-+                        "request": {
-+                            "type": "string"
-+                        },
-+                        "response": {
-+                            "type": "string"
-+                        },
-+                        "interfaces": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "object",
-+                                "optional": true,
-+                                "properties": {
-+                                    "ack_reason": {
-+                                        "type": "integer"
-+                                    },
-+                                    "ack_result": {
-+                                        "type": "integer"
-+                                    },
-+                                    "uuid": {
-+                                        "type": "string"
-+                                    },
-+                                    "version": {
-+                                        "type": "string"
-+                                    }
-+                                },
-+                                "additionalProperties": false
-+                            }
-+                        },
-+                        "req": {
-+                            "type": "object",
-+                            "optional": true,
-+                            "properties": {
-+                                "frag_cnt": {
-+                                    "type": "integer"
-+                                },
-+                                "stub_data_size": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "res": {
-+                            "type": "object",
-+                            "optional": true,
-+                            "properties": {
-+                                "frag_cnt": {
-+                                    "type": "integer"
-+                                },
-+                                "stub_data_size": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "kerberos": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "realm": {
-+                            "type": "string"
-+                        },
-+                        "snames": {
-+                            "type": "array",
-+                            "items": {
-+                                "type": "string"
-+                            }
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "ntlmssp": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "domain": {
-+                            "type": "string"
-+                        },
-+                        "host": {
-+                            "type": "string"
-+                        },
-+                        "user": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "request": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "native_lm": {
-+                            "type": "string"
-+                        },
-+                        "native_os": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "response": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "native_lm": {
-+                            "type": "string"
-+                        },
-+                        "native_os": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "service": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "request": {
-+                            "type": "string"
-+                        },
-+                        "response": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "smtp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "helo": {
-+                    "type": "string"
-+                },
-+                "mail_from": {
-+                    "type": "string"
-+                },
-+                "rcpt_to": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "snmp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "community": {
-+                    "type": "string"
-+                },
-+                "pdu_type": {
-+                    "type": "string"
-+                },
-+                "usm": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "integer"
-+                },
-+                "vars": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "ssh": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "client": {
-+                    "type": "object",
-+                    "properties": {
-+                        "proto_version": {
-+                            "type": "string"
-+                        },
-+                        "software_version": {
-+                            "type": "string"
-+                        },
-+                        "hassh": {
-+                            "type": "object",
-+                            "properties": {
-+                                "hash": {
-+                                    "type": "string"
-+                                },
-+                                "string": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "server": {
-+                    "type": "object",
-+                    "properties": {
-+                        "proto_version": {
-+                            "type": "string"
-+                        },
-+                        "software_version": {
-+                            "type": "string"
-+                        },
-+                        "hassh": {
-+                            "type": "object",
-+                            "properties": {
-+                                "hash": {
-+                                    "type": "string"
-+                                },
-+                                "string": {
-+                                    "type": "string"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "stats": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "uptime": {
-+                    "type": "integer"
-+                },
-+                "app_layer": {
-+                    "type": "object",
-+                    "properties": {
-+                        "expectations": {
-+                            "type": "integer"
-+                        },
-+                        "error": {
-+                            "type": "object",
-+                            "properties": {
-+                                "dcerpc_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "dcerpc_udp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "dhcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "dnp3": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "dns_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "dns_udp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "enip_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "enip_udp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "failed_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "ftp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "ftp-data": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "http": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "http2": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "ike": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "imap": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "krb5_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "krb5_udp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "mqtt": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "nfs_tcp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "nfs_udp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "ntp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "pgsql": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "quic": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "rdp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "rfb": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "sip": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "smb": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "smtp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "snmp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "ssh": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "telnet": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "tftp": { "$ref": "#/$defs/stats_applayer_error" },
-+                                "tls": { "$ref": "#/$defs/stats_applayer_error" }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "flow": {
-+                            "type": "object",
-+                            "properties": {
-+                                "dcerpc_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dcerpc_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "dhcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dnp3": {
-+                                    "type": "integer"
-+                                },
-+                                "dns_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dns_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "enip_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "enip_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "failed_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "failed_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "ftp": {
-+                                    "type": "integer"
-+                                },
-+                                "ftp-data": {
-+                                    "type": "integer"
-+                                },
-+                                "http": {
-+                                    "type": "integer"
-+                                },
-+                                "http2": {
-+                                    "type": "integer"
-+                                },
-+                                "ike": {
-+                                    "type": "integer"
-+                                },
-+                                "ikev2": {
-+                                    "type": "integer"
-+                                },
-+                                "imap": {
-+                                    "type": "integer"
-+                                },
-+                                "krb5_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "krb5_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "modbus": {
-+                                    "type": "integer"
-+                                },
-+                                "mqtt": {
-+                                    "type": "integer"
-+                                },
-+                                "nfs_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "nfs_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "ntp": {
-+                                    "type": "integer"
-+                                },
-+                                "pgsql": {
-+                                    "type": "integer"
-+                                },
-+                                "quic": {
-+                                    "type": "integer"
-+                                },
-+                                "rdp": {
-+                                    "type": "integer"
-+                                },
-+                                "rfb": {
-+                                    "type": "integer"
-+                                },
-+                                "sip": {
-+                                    "type": "integer"
-+                                },
-+                                "smb": {
-+                                    "type": "integer"
-+                                },
-+                                "smtp": {
-+                                    "type": "integer"
-+                                },
-+                                "snmp": {
-+                                    "type": "integer"
-+                                },
-+                                "ssh": {
-+                                    "type": "integer"
-+                                },
-+                                "telnet": {
-+                                    "type": "integer"
-+                                },
-+                                "tftp": {
-+                                    "type": "integer"
-+                                },
-+                                "tls": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "tx": {
-+                            "type": "object",
-+                            "properties": {
-+                                "dcerpc_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dcerpc_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "dhcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dnp3": {
-+                                    "type": "integer"
-+                                },
-+                                "dns_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "dns_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "enip_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "enip_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "ftp": {
-+                                    "type": "integer"
-+                                },
-+                                "ftp-data": {
-+                                    "type": "integer"
-+                                },
-+                                "http": {
-+                                    "type": "integer"
-+                                },
-+                                "http2": {
-+                                    "type": "integer"
-+                                },
-+                                "ike": {
-+                                    "type": "integer"
-+                                },
-+                                "ikev2": {
-+                                    "type": "integer"
-+                                },
-+                                "imap": {
-+                                    "type": "integer"
-+                                },
-+                                "krb5_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "krb5_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "modbus": {
-+                                    "type": "integer"
-+                                },
-+                                "mqtt": {
-+                                    "type": "integer"
-+                                },
-+                                "nfs_tcp": {
-+                                    "type": "integer"
-+                                },
-+                                "nfs_udp": {
-+                                    "type": "integer"
-+                                },
-+                                "ntp": {
-+                                    "type": "integer"
-+                                },
-+                                "pgsql": {
-+                                    "type": "integer"
-+                                },
-+                                "quic": {
-+                                    "type": "integer"
-+                                },
-+                                "rdp": {
-+                                    "type": "integer"
-+                                },
-+                                "rfb": {
-+                                    "type": "integer"
-+                                },
-+                                "sip": {
-+                                    "type": "integer"
-+                                },
-+                                "smb": {
-+                                    "type": "integer"
-+                                },
-+                                "smtp": {
-+                                    "type": "integer"
-+                                },
-+                                "snmp": {
-+                                    "type": "integer"
-+                                },
-+                                "ssh": {
-+                                    "type": "integer"
-+                                },
-+                                "telnet": {
-+                                    "type": "integer"
-+                                },
-+                                "tftp": {
-+                                    "type": "integer"
-+                                },
-+                                "tls": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "decoder": {
-+                    "type": "object",
-+                    "properties": {
-+                        "avg_pkt_size": {
-+                            "type": "integer"
-+                        },
-+                        "bytes": {
-+                            "type": "integer"
-+                        },
-+                        "chdlc": {
-+                            "type": "integer"
-+                        },
-+                        "erspan": {
-+                            "type": "integer"
-+                        },
-+                        "esp": {
-+                            "type": "integer"
-+                        },
-+                        "ethernet": {
-+                            "type": "integer"
-+                        },
-+                        "geneve": {
-+                            "type": "integer"
-+                        },
-+                        "gre": {
-+                            "type": "integer"
-+                        },
-+                        "icmpv4": {
-+                            "type": "integer"
-+                        },
-+                        "icmpv6": {
-+                            "type": "integer"
-+                        },
-+                        "ieee8021ah": {
-+                            "type": "integer"
-+                        },
-+                        "invalid": {
-+                            "type": "integer"
-+                        },
-+                        "ipv4": {
-+                            "type": "integer"
-+                        },
-+                        "ipv4_in_ipv6": {
-+                            "type": "integer"
-+                        },
-+                        "ipv6": {
-+                            "type": "integer"
-+                        },
-+                        "ipv6_in_ipv6": {
-+                            "type": "integer"
-+                        },
-+                        "max_mac_addrs_dst": {
-+                            "type": "integer"
-+                        },
-+                        "max_mac_addrs_src": {
-+                            "type": "integer"
-+                        },
-+                        "max_pkt_size": {
-+                            "type": "integer"
-+                        },
-+                        "mpls": {
-+                            "type": "integer"
-+                        },
-+                        "nsh": {
-+                            "type": "integer"
-+                        },
-+                        "null": {
-+                            "type": "integer"
-+                        },
-+                        "pkts": {
-+                            "type": "integer"
-+                        },
-+                        "ppp": {
-+                            "type": "integer"
-+                        },
-+                        "pppoe": {
-+                            "type": "integer"
-+                        },
-+                        "raw": {
-+                            "type": "integer"
-+                        },
-+                        "sctp": {
-+                            "type": "integer"
-+                        },
-+                        "sll": {
-+                            "type": "integer"
-+                        },
-+                        "tcp": {
-+                            "type": "integer"
-+                        },
-+                        "teredo": {
-+                            "type": "integer"
-+                        },
-+                        "too_many_layers": {
-+                            "type": "integer"
-+                        },
-+                        "udp": {
-+                            "type": "integer"
-+                        },
-+                        "vlan": {
-+                            "type": "integer"
-+                        },
-+                        "vlan_qinq": {
-+                            "type": "integer"
-+                        },
-+                        "vntag": {
-+                            "type": "integer"
-+                        },
-+                        "vxlan": {
-+                            "type": "integer"
-+                        },
-+                        "event": {
-+                            "type": "object",
-+                            "properties": {
-+                                "chdlc": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "dce": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "erspan": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "too_many_vlan_layers": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unsupported_version": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "esp": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ethernet": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "geneve": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "unknown_payload_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "gre": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version0_flags": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version0_hdr_too_big": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version0_malformed_sre_hdr": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version0_recur": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_chksum": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_flags": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_hdr_too_big": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_malformed_sre_hdr": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_no_key": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_recur": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_route": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_ssr": {
-+                                            "type": "integer"
-+                                        },
-+                                        "version1_wrong_protocol": {
-+                                            "type": "integer"
-+                                        },
-+                                        "wrong_version": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "icmpv4": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "ipv4_trunc_pkt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv4_unknown_ver": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_code": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "icmpv6": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "experimentation_type": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv6_trunc_pkt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv6_unknown_version": {
-+                                            "type": "integer"
-+                                        },
-+                                        "mld_message_with_invalid_hl": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unassigned_type": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_code": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ieee8021ah": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ipraw": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "invalid_ip_version": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ipv4": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "frag_ignored": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_overlap": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_pkt_too_large": {
-+                                            "type": "integer"
-+                                        },
-+                                        "hlen_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "icmpv6": {
-+                                            "type": "integer"
-+                                        },
-+                                        "iplen_smaller_than_hlen": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_duplicate": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_eol_required": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_invalid": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_invalid_len": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_malformed": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_pad_required": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_unknown": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "trunc_pkt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "wrong_ip_version": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ipv6": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "data_after_none_header": {
-+                                            "type": "integer"
-+                                        },
-+                                        "dstopts_only_padding": {
-+                                            "type": "integer"
-+                                        },
-+                                        "dstopts_unknown_opt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_ah_res_not_null": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_ah": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_dh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_eh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_fh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_hh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_dupl_rh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_invalid_optlen": {
-+                                            "type": "integer"
-+                                        },
-+                                        "exthdr_useless_fh": {
-+                                            "type": "integer"
-+                                        },
-+                                        "fh_non_zero_reserved_field": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_ignored": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_invalid_length": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_overlap": {
-+                                            "type": "integer"
-+                                        },
-+                                        "frag_pkt_too_large": {
-+                                            "type": "integer"
-+                                        },
-+                                        "hopopts_only_padding": {
-+                                            "type": "integer"
-+                                        },
-+                                        "hopopts_unknown_opt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "icmpv4": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv4_in_ipv6_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv4_in_ipv6_wrong_version": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv6_in_ipv6_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ipv6_in_ipv6_wrong_version": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "rh_type_0": {
-+                                            "type": "integer"
-+                                        },
-+                                        "trunc_exthdr": {
-+                                            "type": "integer"
-+                                        },
-+                                        "trunc_pkt": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_next_header": {
-+                                            "type": "integer"
-+                                        },
-+                                        "wrong_ip_version": {
-+                                            "type": "integer"
-+                                        },
-+                                        "zero_len_padn": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ltnull": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unsupported_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "mpls": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "bad_label_implicit_null": {
-+                                            "type": "integer"
-+                                        },
-+                                        "bad_label_reserved": {
-+                                            "type": "integer"
-+                                        },
-+                                        "bad_label_router_alert": {
-+                                            "type": "integer"
-+                                        },
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_payload_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "nsh": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "bad_header_length": {
-+                                            "type": "integer"
-+                                        },
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "reserved_type": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_payload": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unsupported_type": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unsupported_version": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "ppp": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "ip4_pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "ip6_pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unsup_proto": {
-+                                            "type": "integer"
-+                                        },
-+                                        "vju_pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "wrong_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "pppoe": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "malformed_tags": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "wrong_code": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "sctp": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "sll": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "tcp": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "hlen_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "invalid_optlen": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_duplicate": {
-+                                            "type": "integer"
-+                                        },
-+                                        "opt_invalid_len": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "udp": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "hlen_invalid": {
-+                                            "type": "integer"
-+                                        },
-+                                        "hlen_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "pkt_too_small": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "vlan": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "too_many_layers": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "vntag": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "header_too_small": {
-+                                            "type": "integer"
-+                                        },
-+                                        "unknown_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                },
-+                                "vxlan": {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "unknown_payload_type": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "defrag": {
-+                    "type": "object",
-+                    "properties": {
-+                        "max_frag_hits": {
-+                            "type": "integer"
-+                        },
-+                        "ipv4": {
-+                            "type": "object",
-+                            "properties": {
-+                                "fragments": {
-+                                    "type": "integer"
-+                                },
-+                                "reassembled": {
-+                                    "type": "integer"
-+                                },
-+                                "timeouts": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "ipv6": {
-+                            "type": "object",
-+                            "properties": {
-+                                "fragments": {
-+                                    "type": "integer"
-+                                },
-+                                "reassembled": {
-+                                    "type": "integer"
-+                                },
-+                                "timeouts": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "detect": {
-+                    "type": "object",
-+                    "properties": {
-+                        "alert": {
-+                            "type": "integer"
-+                        },
-+                        "alert_queue_overflow": {
-+                            "type": "integer"
-+                        },
-+                        "alerts_suppressed": {
-+                            "type": "integer"
-+                        },
-+                        "engines": {
-+                            "type": "array",
-+                            "items": [
-+                                {
-+                                    "type": "object",
-+                                    "properties": {
-+                                        "id": {
-+                                            "type": "integer"
-+                                        },
-+                                        "last_reload": {
-+                                            "type": "string"
-+                                        },
-+                                        "rules_loaded": {
-+                                            "type": "integer"
-+                                        },
-+                                        "rules_failed": {
-+                                            "type": "integer"
-+                                        }
-+                                    },
-+                                    "additionalProperties": false
-+                                }
-+                            ]
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "file_store": {
-+                    "type": "object",
-+                    "properties": {
-+                        "fs_errors": {
-+                            "type": "integer"
-+                        },
-+                        "open_files": {
-+                            "type": "integer"
-+                        },
-+                        "open_files_max_hit": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "flow": {
-+                    "type": "object",
-+                    "properties": {
-+                        "emerg_mode_entered": {
-+                            "type": "integer"
-+                        },
-+                        "emerg_mode_over": {
-+                            "type": "integer"
-+                        },
-+                        "get_used": {
-+                            "type": "integer"
-+                        },
-+                        "get_used_eval": {
-+                            "type": "integer"
-+                        },
-+                        "get_used_eval_busy": {
-+                            "type": "integer"
-+                        },
-+                        "get_used_eval_reject": {
-+                            "type": "integer"
-+                        },
-+                        "get_used_failed": {
-+                            "type": "integer"
-+                        },
-+                        "icmpv4": {
-+                            "type": "integer"
-+                        },
-+                        "icmpv6": {
-+                            "type": "integer"
-+                        },
-+                        "memcap": {
-+                            "type": "integer"
-+                        },
-+                        "memuse": {
-+                            "type": "integer"
-+                        },
-+                        "spare": {
-+                            "type": "integer"
-+                        },
-+                        "tcp": {
-+                            "type": "integer"
-+                        },
-+                        "tcp_reuse": {
-+                            "type": "integer"
-+                        },
-+                        "udp": {
-+                            "type": "integer"
-+                        },
-+                        "mgr": {
-+                            "type": "object",
-+                            "properties": {
-+                                "bypassed_pruned": {
-+                                    "type": "integer"
-+                                },
-+                                "closed_pruned": {
-+                                    "type": "integer"
-+                                },
-+                                "est_pruned": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_checked": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_evicted": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_evicted_needs_work": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_notimeout": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_timeout": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_timeout_inuse": {
-+                                    "type": "integer"
-+                                },
-+                                "full_hash_pass": {
-+                                    "type": "integer"
-+                                },
-+                                "new_pruned": {
-+                                    "type": "integer"
-+                                },
-+                                "rows_maxlen": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        },
-+                        "wrk": {
-+                            "type": "object",
-+                            "properties": {
-+                                "flows_evicted": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_evicted_needs_work": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_evicted_pkt_inject": {
-+                                    "type": "integer"
-+                                },
-+                                "flows_injected": {
-+                                    "type": "integer"
-+                                },
-+                                "spare_sync": {
-+                                    "type": "integer"
-+                                },
-+                                "spare_sync_avg": {
-+                                    "type": "integer"
-+                                },
-+                                "spare_sync_empty": {
-+                                    "type": "integer"
-+                                },
-+                                "spare_sync_incomplete": {
-+                                    "type": "integer"
-+                                }
-+                            },
-+                            "additionalProperties": false
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "flow_bypassed": {
-+                    "type": "object",
-+                    "properties": {
-+                        "bytes": {
-+                            "type": "integer"
-+                        },
-+                        "closed": {
-+                            "type": "integer"
-+                        },
-+                        "local_bytes": {
-+                            "type": "integer"
-+                        },
-+                        "local_capture_bytes": {
-+                            "type": "integer"
-+                        },
-+                        "local_capture_pkts": {
-+                            "type": "integer"
-+                        },
-+                        "local_pkts": {
-+                            "type": "integer"
-+                        },
-+                        "pkts": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "flow_mgr": {
-+                    "type": "object",
-+                    "properties": {
-+                        "bypassed_pruned": {
-+                            "type": "integer"
-+                        },
-+                        "closed_pruned": {
-+                            "type": "integer"
-+                        },
-+                        "est_pruned": {
-+                            "type": "integer"
-+                        },
-+                        "flows_checked": {
-+                            "type": "integer"
-+                        },
-+                        "flows_notimeout": {
-+                            "type": "integer"
-+                        },
-+                        "flows_removed": {
-+                            "type": "integer"
-+                        },
-+                        "flows_timeout": {
-+                            "type": "integer"
-+                        },
-+                        "flows_timeout_inuse": {
-+                            "type": "integer"
-+                        },
-+                        "new_pruned": {
-+                            "type": "integer"
-+                        },
-+                        "rows_busy": {
-+                            "type": "integer"
-+                        },
-+                        "rows_checked": {
-+                            "type": "integer"
-+                        },
-+                        "rows_empty": {
-+                            "type": "integer"
-+                        },
-+                        "rows_maxlen": {
-+                            "type": "integer"
-+                        },
-+                        "rows_skipped": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "ftp": {
-+                    "type": "object",
-+                    "properties": {
-+                        "memcap": {
-+                            "type": "integer"
-+                        },
-+                        "memuse": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "http": {
-+                    "type": "object",
-+                    "properties": {
-+                        "memcap": {
-+                            "type": "integer"
-+                        },
-+                        "memuse": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "tcp": {
-+                    "type": "object",
-+                    "properties": {
-+                        "insert_data_normal_fail": {
-+                            "type": "integer"
-+                        },
-+                        "insert_data_overlap_fail": {
-+                            "type": "integer"
-+                        },
-+                        "insert_list_fail": {
-+                            "type": "integer"
-+                        },
-+                        "invalid_checksum": {
-+                            "type": "integer"
-+                        },
-+                        "memuse": {
-+                            "type": "integer"
-+                        },
-+                        "midstream_pickups": {
-+                            "type": "integer"
-+                        },
-+                        "no_flow": {
-+                            "type": "integer"
-+                        },
-+                        "overlap": {
-+                            "type": "integer"
-+                        },
-+                        "overlap_diff_data": {
-+                            "type": "integer"
-+                        },
-+                        "pkt_on_wrong_thread": {
-+                            "type": "integer"
-+                        },
-+                        "pseudo": {
-+                            "type": "integer"
-+                        },
-+                        "pseudo_failed": {
-+                            "type": "integer"
-+                        },
-+                        "reassembly_gap": {
-+                            "type": "integer"
-+                        },
-+                        "reassembly_memuse": {
-+                            "type": "integer"
-+                        },
-+                        "rst": {
-+                            "type": "integer"
-+                        },
-+                        "segment_memcap_drop": {
-+                            "type": "integer"
-+                        },
-+                        "sessions": {
-+                            "type": "integer"
-+                        },
-+                        "ssn_memcap_drop": {
-+                            "type": "integer"
-+                        },
-+                        "stream_depth_reached": {
-+                            "type": "integer"
-+                        },
-+                        "syn": {
-+                            "type": "integer"
-+                        },
-+                        "synack": {
-+                            "type": "integer"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "tcp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "ack": {
-+                    "type": "boolean"
-+                },
-+                "cwr": {
-+                    "type": "boolean"
-+                },
-+                "ecn": {
-+                    "type": "boolean"
-+                },
-+                "fin": {
-+                    "type": "boolean"
-+                },
-+                "psh": {
-+                    "type": "boolean"
-+                },
-+                "rst": {
-+                    "type": "boolean"
-+                },
-+                "state": {
-+                    "type": "string"
-+                },
-+                "syn": {
-+                    "type": "boolean"
-+                },
-+                "tcp_flags": {
-+                    "type": "string"
-+                },
-+                "tcp_flags_tc": {
-+                    "type": "string"
-+                },
-+                "tcp_flags_ts": {
-+                    "type": "string"
-+                },
-+                "urg": {
-+                    "type": "boolean"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "template": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "request": {
-+                    "type": "string"
-+                },
-+                "response": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "tftp": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "file": {
-+                    "type": "string"
-+                },
-+                "mode": {
-+                    "type": "string"
-+                },
-+                "packet": {
-+                    "type": "string"
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "tls": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "fingerprint": {
-+                    "type": "string"
-+                },
-+                "from_proto": {
-+                    "type": "string"
-+                },
-+                "issuerdn": {
-+                    "type": "string"
-+                },
-+                "notafter": {
-+                    "type": "string"
-+                },
-+                "notbefore": {
-+                    "type": "string"
-+                },
-+                "serial": {
-+                    "type": "string"
-+                },
-+                "session_resumed": {
-+                    "type": "boolean"
-+                },
-+                "sni": {
-+                    "type": "string"
-+                },
-+                "subject": {
-+                    "type": "string"
-+                },
-+                "version": {
-+                    "type": "string"
-+                },
-+                "ja3": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "hash": {
-+                            "type": "string"
-+                        },
-+                        "string": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                },
-+                "ja3s": {
-+                    "type": "object",
-+                    "optional": true,
-+                    "properties": {
-+                        "hash": {
-+                            "type": "string"
-+                        },
-+                        "string": {
-+                            "type": "string"
-+                        }
-+                    },
-+                    "additionalProperties": false
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "traffic": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "id": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                },
-+                "label": {
-+                    "type": "array",
-+                    "items": {
-+                        "type": "string"
-+                    }
-+                }
-+            },
-+            "additionalProperties": false
-+        },
-+        "tunnel": {
-+            "type": "object",
-+            "optional": true,
-+            "properties": {
-+                "depth": {
-+                    "type": "integer"
-+                },
-+                "dest_ip": {
-+                    "type": "string"
-+                },
-+                "dest_port": {
-+                    "type": "integer"
-+                },
-+                "pcap_cnt": {
-+                    "type": "integer"
-+                },
-+                "pkt_src": {
-+                    "type": "string"
-+                },
-+                "proto": {
-+                    "type": "string"
-+                },
-+                "src_ip": {
-+                    "type": "string"
-+                },
-+                "src_port": {
-+                    "type": "integer"
-+                }
-+            },
-+            "additionalProperties": false
-+        }
-+    },
-+    "additionalProperties": false,
-+    "$defs": {
-+        "stats_applayer_error": {
-+            "type": "object",
-+            "properties": {
-+                "gap": {
-+                    "type": "integer"
-+                },
-+                "alloc": {
-+                    "type": "integer"
-+                },
-+                "parser": {
-+                    "type": "integer"
-+                },
-+                "internal": {
-+                    "type": "integer"
-+                }
-+            },
-+            "additionalProperties": false
-+        }
-+    }
-+}
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55628-003.patch b/recipes-ids/suricata/files/CVE-2024-55628-003.patch
deleted file mode 100644
index c498a6b..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55628-003.patch
+++ /dev/null
@@ -1,114 +0,0 @@
-From 5edb84fe234f47a0fedfbf9b10b49699152fe8cb Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Thu, 31 Oct 2024 15:46:35 -0600
-Subject: [PATCH] eve/dns: add truncation flags for fields that are truncated
-
-If rrname, rdata or mname are truncated, set a flag field like
-'rrname_truncated: true' to indicate that the name is truncated.
-
-Ticket: #7280
-
-(cherry picked from commit 37f4c52b22fcdde4adf9b479cb5700f89d00768d)
-
-CVE: CVE-2024-55628
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/5edb84fe234f47a0fedfbf9b10b49699152fe8cb]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- etc/schema.json     |  7 +++++++
- rust/src/dns/log.rs | 19 +++++++++++++++++++
- 2 files changed, 26 insertions(+)
-
-diff --git a/etc/schema.json b/etc/schema.json
-index 99f419f..422d77c 100644
---- a/etc/schema.json
-+++ b/etc/schema.json
-@@ -790,6 +790,9 @@
-                 "rrname": {
-                     "type": "string"
-                 },
-+		"rrname_truncated": {
-+		    "type": "boolean"
-+		},
-                 "rrtype": {
-                     "type": "string"
-                 },
-@@ -2365,6 +2368,10 @@
-                             "type": "array",
-                             "items": {
-                                 "type": "integer"
-+                            },
-+                            "rrname_truncated": {
-+                                "description": "Set to true if the rrname was too long and truncated by Suricata",
-+                                "type": "boolean"
-                             }
-                         }
-                     },
-diff --git a/rust/src/dns/log.rs b/rust/src/dns/log.rs
-index 6bf9589..d0e468d 100644
---- a/rust/src/dns/log.rs
-+++ b/rust/src/dns/log.rs
-@@ -399,7 +399,13 @@ fn dns_log_soa(soa: &DNSRDataSOA) -> Result<JsonBuilder, JsonError> {
-     let mut js = JsonBuilder::try_new_object()?;
- 
-     js.set_string_from_bytes("mname", &soa.mname.value)?;
-+    if soa.mname.flags.contains(DNSNameFlags::TRUNCATED) {
-+        js.set_bool("mname_truncated", true)?;
-+    }
-     js.set_string_from_bytes("rname", &soa.rname.value)?;
-+    if soa.rname.flags.contains(DNSNameFlags::TRUNCATED) {
-+        js.set_bool("rname_truncated", true)?;
-+    }
-     js.set_uint("serial", soa.serial as u64)?;
-     js.set_uint("refresh", soa.refresh as u64)?;
-     js.set_uint("retry", soa.retry as u64)?;
-@@ -444,6 +450,9 @@ fn dns_log_json_answer_detail(answer: &DNSAnswerEntry) -> Result<JsonBuilder, Js
-     let mut jsa = JsonBuilder::try_new_object()?;
- 
-     jsa.set_string_from_bytes("rrname", &answer.name.value)?;
-+    if answer.name.flags.contains(DNSNameFlags::TRUNCATED) {
-+        jsa.set_bool("rrname_truncated", true)?;
-+    }
-     jsa.set_string("rrtype", &dns_rrtype_string(answer.rrtype))?;
-     jsa.set_uint("ttl", answer.ttl as u64)?;
- 
-@@ -453,6 +462,9 @@ fn dns_log_json_answer_detail(answer: &DNSAnswerEntry) -> Result<JsonBuilder, Js
-         }
-         DNSRData::CNAME(name) | DNSRData::MX(name) | DNSRData::NS(name) | DNSRData::PTR(name) => {
-             jsa.set_string_from_bytes("rdata", &name.value)?;
-+            if name.flags.contains(DNSNameFlags::TRUNCATED) {
-+                jsa.set_bool("rdata_truncated", true)?;
-+            }
-         }
-         DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
-             jsa.set_string_from_bytes("rdata", bytes)?;
-@@ -506,6 +518,9 @@ fn dns_log_json_answer(
- 
-     if let Some(query) = response.queries.first() {
-         js.set_string_from_bytes("rrname", &query.name.value)?;
-+        if query.name.flags.contains(DNSNameFlags::TRUNCATED) {
-+            js.set_bool("rrname_truncated", true)?;
-+        }
-         js.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
-     }
-     js.set_string("rcode", &dns_rcode_string(header.flags))?;
-@@ -532,6 +547,7 @@ fn dns_log_json_answer(
-                     | DNSRData::MX(name)
-                     | DNSRData::NS(name)
-                     | DNSRData::PTR(name) => {
-+                        // Flags like truncated not logged here as it would break the schema.
-                         if !answer_types.contains_key(&type_string) {
-                             answer_types
-                                 .insert(type_string.to_string(), JsonBuilder::try_new_array()?);
-@@ -620,6 +636,9 @@ fn dns_log_query(
-                 jb.set_string("type", "query")?;
-                 jb.set_uint("id", request.header.tx_id as u64)?;
-                 jb.set_string_from_bytes("rrname", &query.name.value)?;
-+                if query.name.flags.contains(DNSNameFlags::TRUNCATED) {
-+                    jb.set_bool("rrname_truncated", true)?;
-+                }
-                 jb.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
-                 jb.set_uint("tx_id", tx.id - 1)?;
-                 if request.header.flags & 0x0040 != 0 {
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2024-55628-004.patch b/recipes-ids/suricata/files/CVE-2024-55628-004.patch
deleted file mode 100644
index 5a2bcf6..0000000
--- a/recipes-ids/suricata/files/CVE-2024-55628-004.patch
+++ /dev/null
@@ -1,510 +0,0 @@
-From 71212b78bd1b7b841c9d9a907d0b3eea71a54060 Mon Sep 17 00:00:00 2001
-From: Jason Ish <jason.ish@oisf.net>
-Date: Fri, 1 Nov 2024 11:39:23 -0600
-Subject: [PATCH] dns: provide events for recoverable parse errors
-
-Add events for the following resource name parsing issues:
-
-- name truncated as its too long
-- maximum number of labels reached
-- infinite loop
-
-Currently these events are only registered when encountered, but
-recoverable. That is where we are able to return some of the name,
-usually in a truncated state.
-
-As name parsing has many code paths, we pass in a pointer to a flag
-field that can be updated by the name parser, this is done in
-addition to the flags being set on a specific name as when logging we
-want to designate which fields are truncated, etc. But for alerts, we
-just care that something happened during the parse. It also reduces
-errors as it won't be forgotten to check for the flags and set the
-event if some new parser is written that also parses names.
-
-Ticket: #7280
-
-(cherry picked from commit 19cf0f81335d9f787d587450f7105ad95a648951)
-
-CVE: CVE-2024-55628
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/71212b78bd1b7b841c9d9a907d0b3eea71a54060]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- rules/dns-events.rules |   9 +++
- rust/src/dns/dns.rs    |  36 ++++++++++-
- rust/src/dns/parser.rs | 136 +++++++++++++++++++++++++----------------
- 3 files changed, 124 insertions(+), 57 deletions(-)
-
-diff --git a/rules/dns-events.rules b/rules/dns-events.rules
-index d4c02b5..cc43629 100644
---- a/rules/dns-events.rules
-+++ b/rules/dns-events.rules
-@@ -8,3 +8,12 @@ alert dns any any -> any any (msg:"SURICATA DNS Not a response"; flow:to_client;
- # Z flag (reserved) not 0
- alert dns any any -> any any (msg:"SURICATA DNS Z flag set"; app-layer-event:dns.z_flag_set; classtype:protocol-command-decode; sid:2240006; rev:2;)
- alert dns any any -> any any (msg:"SURICATA DNS Invalid opcode"; app-layer-event:dns.invalid_opcode; classtype:protocol-command-decode; sid:2240007; rev:1;)
-+
-+# A resource name was too long (over 1025 chars)
-+alert dns any any -> any any (msg:"SURICATA DNS Name too long"; app-layer-event:dns.name_too_long; classtype:protocol-command-decode; sid:224008; rev:1;)
-+
-+# An infinite loop was found while decoding a DNS resource name.
-+alert dns any any -> any any (msg:"SURICATA DNS Infinite loop"; app-layer-event:dns.infinite_loop; classtype:protocol-command-decode; sid:224009; rev:1;)
-+
-+# Suricata's maximum number of DNS name labels was reached while parsing a resource name.
-+alert dns any any -> any any (msg:"SURICATA DNS Too many labels"; app-layer-event:dns.too_many_labels; classtype:protocol-command-decode; sid:224010; rev:1;)
-diff --git a/rust/src/dns/dns.rs b/rust/src/dns/dns.rs
-index 680bf7e..34406dc 100644
---- a/rust/src/dns/dns.rs
-+++ b/rust/src/dns/dns.rs
-@@ -129,6 +129,12 @@ pub enum DNSEvent {
-     NotResponse,
-     ZFlagSet,
-     InvalidOpcode,
-+    /// A DNS resource name was exessively long and was truncated.
-+    NameTooLong,
-+    /// An infinite loop was found while parsing a name.
-+    InfiniteLoop,
-+    /// Too many labels were found.
-+    TooManyLabels,
- }
- 
- #[derive(Debug, PartialEq, Eq)]
-@@ -418,7 +424,7 @@ impl DNSState {
-         };
- 
-         match parser::dns_parse_request_body(body, input, header) {
--            Ok((_, request)) => {
-+            Ok((_, (request, parse_flags))) => {
-                 if request.header.flags & 0x8000 != 0 {
-                     SCLogDebug!("DNS message is not a request");
-                     self.set_event(DNSEvent::NotRequest);
-@@ -441,6 +447,18 @@ impl DNSState {
-                     self.set_event(DNSEvent::InvalidOpcode);
-                 }
- 
-+                if parse_flags.contains(DNSNameFlags::TRUNCATED) {
-+                    self.set_event(DNSEvent::NameTooLong);
-+                }
-+                
-+                if parse_flags.contains(DNSNameFlags::INFINITE_LOOP) {
-+                    self.set_event(DNSEvent::InfiniteLoop);
-+                }
-+                
-+                if parse_flags.contains(DNSNameFlags::LABEL_LIMIT) {
-+                    self.set_event(DNSEvent::TooManyLabels);
-+                }
-+
-                 return true;
-             }
-             Err(Err::Incomplete(_)) => {
-@@ -490,7 +508,7 @@ impl DNSState {
-         };
- 
-         match parser::dns_parse_response_body(body, input, header) {
--            Ok((_, response)) => {
-+            Ok((_, (response, parse_flags))) => {
-                 SCLogDebug!("Response header flags: {}", response.header.flags);
- 
-                 if response.header.flags & 0x8000 == 0 {
-@@ -519,6 +537,18 @@ impl DNSState {
-                     self.set_event(DNSEvent::InvalidOpcode);
-                 }
- 
-+                if parse_flags.contains(DNSNameFlags::TRUNCATED) {
-+                    self.set_event(DNSEvent::NameTooLong);
-+                }
-+                
-+                if parse_flags.contains(DNSNameFlags::INFINITE_LOOP) {
-+                    self.set_event(DNSEvent::InfiniteLoop);
-+                }
-+                
-+                if parse_flags.contains(DNSNameFlags::LABEL_LIMIT) {
-+                    self.set_event(DNSEvent::TooManyLabels);
-+                }
-+
-                 return true;
-             }
-             Err(Err::Incomplete(_)) => {
-@@ -718,7 +748,7 @@ fn probe(input: &[u8], dlen: usize) -> (bool, bool, bool) {
-     }
- 
-     match parser::dns_parse_request(input) {
--        Ok((_, request)) => {
-+        Ok((_, (request, _))) => {
-             return probe_header_validity(&request.header, dlen);
-         }
-         Err(Err::Incomplete(_)) => match parser::dns_parse_header(input) {
-diff --git a/rust/src/dns/parser.rs b/rust/src/dns/parser.rs
-index 12929bc..c98ba05 100644
---- a/rust/src/dns/parser.rs
-+++ b/rust/src/dns/parser.rs
-@@ -81,7 +81,7 @@ static MAX_NAME_LEN: usize = 1025;
- /// Parameters:
- ///   start: the start of the name
- ///   message: the complete message that start is a part of with the DNS header
--pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8], DNSName> {
-+pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8], parse_flags: &mut DNSNameFlags) -> IResult<&'b [u8], DNSName> {
-     let mut pos = start;
-     let mut pivot = start;
-     let mut name: Vec<u8> = Vec::with_capacity(32);
-@@ -166,6 +166,8 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8
-         }
-     }
- 
-+    parse_flags.insert(flags);
-+
-     // If we followed a pointer we return the position after the first
-     // pointer followed. Is there a better way to see if these slices
-     // diverged from each other?  A straight up comparison would
-@@ -188,7 +190,7 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) -> IResult<&'b [u8
- /// multi-string TXT entry as a single quote string, similar to the
- /// output of dig. Something to consider for a future version.
- fn dns_parse_answer<'a>(
--    slice: &'a [u8], message: &'a [u8], count: usize,
-+    slice: &'a [u8], message: &'a [u8], count: usize, flags: &mut DNSNameFlags,
- ) -> IResult<&'a [u8], Vec<DNSAnswerEntry>> {
-     let mut answers = Vec::new();
-     let mut input = slice;
-@@ -201,8 +203,10 @@ fn dns_parse_answer<'a>(
-         data: &'a [u8],
-     }
- 
--    fn subparser<'a>(i: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], Answer<'a>> {
--        let (i, name) = dns_parse_name(i, message)?;
-+    fn subparser<'a>(
-+        i: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+    ) -> IResult<&'a [u8], Answer<'a>> {
-+        let (i, name) = dns_parse_name(i, message, flags)?;
-         let (i, rrtype) = be_u16(i)?;
-         let (i, rrclass) = be_u16(i)?;
-         let (i, ttl) = be_u32(i)?;
-@@ -218,7 +222,7 @@ fn dns_parse_answer<'a>(
-     }
- 
-     for _ in 0..count {
--        match subparser(input, message) {
-+        match subparser(input, message, flags) {
-             Ok((rem, val)) => {
-                 let n = match val.rrtype {
-                     DNS_RECORD_TYPE_TXT => {
-@@ -236,7 +240,7 @@ fn dns_parse_answer<'a>(
-                     }
-                 };
-                 let result: IResult<&'a [u8], Vec<DNSRData>> =
--                    many_m_n(1, n, complete(|b| dns_parse_rdata(b, message, val.rrtype)))(val.data);
-+                    many_m_n(1, n, complete(|b| dns_parse_rdata(b, message, val.rrtype, flags)))(val.data);
-                 match result {
-                     Ok((_, rdatas)) => {
-                         for rdata in rdatas {
-@@ -266,18 +270,19 @@ fn dns_parse_answer<'a>(
- 
- pub fn dns_parse_response_body<'a>(
-     i: &'a [u8], message: &'a [u8], header: DNSHeader,
--) -> IResult<&'a [u8], DNSResponse> {
--    let (i, queries) = count(|b| dns_parse_query(b, message), header.questions as usize)(i)?;
--    let (i, answers) = dns_parse_answer(i, message, header.answer_rr as usize)?;
--    let (i, authorities) = dns_parse_answer(i, message, header.authority_rr as usize)?;
-+) -> IResult<&'a [u8], (DNSResponse, DNSNameFlags)> {
-+    let mut flags = DNSNameFlags::default();
-+    let (i, queries) = count(|b| dns_parse_query(b, message, &mut flags), header.questions as usize)(i)?;
-+    let (i, answers) = dns_parse_answer(i, message, header.answer_rr as usize, &mut flags)?;
-+    let (i, authorities) = dns_parse_answer(i, message, header.authority_rr as usize, &mut flags)?;
-     Ok((
-         i,
--        DNSResponse {
-+        (DNSResponse {
-             header,
-             queries,
-             answers,
-             authorities,
--        },
-+        }, flags),
-     ))
- }
- 
-@@ -286,9 +291,9 @@ pub fn dns_parse_response_body<'a>(
- /// Arguments are suitable for using with call!:
- ///
- ///    call!(complete_dns_message_buffer)
--pub fn dns_parse_query<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSQueryEntry> {
-+pub fn dns_parse_query<'a>(input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags) -> IResult<&'a [u8], DNSQueryEntry> {
-     let i = input;
--    let (i, name) = dns_parse_name(i, message)?;
-+    let (i, name) = dns_parse_name(i, message, flags)?;
-     let (i, rrtype) = be_u16(i)?;
-     let (i, rrclass) = be_u16(i)?;
-     Ok((
-@@ -309,22 +314,30 @@ fn dns_parse_rdata_aaaa(input: &[u8]) -> IResult<&[u8], DNSRData> {
-     rest(input).map(|(input, data)| (input, DNSRData::AAAA(data.to_vec())))
- }
- 
--fn dns_parse_rdata_cname<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
--    dns_parse_name(input, message).map(|(input, name)| (input, DNSRData::CNAME(name)))
-+fn dns_parse_rdata_cname<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-+    dns_parse_name(input, message, flags).map(|(input, name)| (input, DNSRData::CNAME(name)))
- }
- 
--fn dns_parse_rdata_ns<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
--    dns_parse_name(input, message).map(|(input, name)| (input, DNSRData::NS(name)))
-+fn dns_parse_rdata_ns<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-+    dns_parse_name(input, message, flags).map(|(input, name)| (input, DNSRData::NS(name)))
- }
- 
--fn dns_parse_rdata_ptr<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
--    dns_parse_name(input, message).map(|(input, name)| (input, DNSRData::PTR(name)))
-+fn dns_parse_rdata_ptr<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-+    dns_parse_name(input, message, flags).map(|(input, name)| (input, DNSRData::PTR(name)))
- }
- 
--fn dns_parse_rdata_soa<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
-+fn dns_parse_rdata_soa<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-     let i = input;
--    let (i, mname) = dns_parse_name(i, message)?;
--    let (i, rname) = dns_parse_name(i, message)?;
-+    let (i, mname) = dns_parse_name(i, message, flags)?;
-+    let (i, rname) = dns_parse_name(i, message, flags)?;
-     let (i, serial) = be_u32(i)?;
-     let (i, refresh) = be_u32(i)?;
-     let (i, retry) = be_u32(i)?;
-@@ -344,20 +357,24 @@ fn dns_parse_rdata_soa<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u
-     ))
- }
- 
--fn dns_parse_rdata_mx<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
-+fn dns_parse_rdata_mx<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-     // For MX we skip over the preference field before
-     // parsing out the name.
-     let (i, _) = be_u16(input)?;
--    let (i, name) = dns_parse_name(i, message)?;
-+    let (i, name) = dns_parse_name(i, message, flags)?;
-     Ok((i, DNSRData::MX(name)))
- }
- 
--fn dns_parse_rdata_srv<'a>(input: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8], DNSRData> {
-+fn dns_parse_rdata_srv<'a>(
-+    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
-+) -> IResult<&'a [u8], DNSRData> {
-     let i = input;
-     let (i, priority) = be_u16(i)?;
-     let (i, weight) = be_u16(i)?;
-     let (i, port) = be_u16(i)?;
--    let (i, target) = dns_parse_name(i, message)?;
-+    let (i, target) = dns_parse_name(i, message, flags)?;
-     Ok((
-         i,
-         DNSRData::SRV(DNSRDataSRV {
-@@ -398,26 +415,26 @@ fn dns_parse_rdata_unknown(input: &[u8]) -> IResult<&[u8], DNSRData> {
- }
- 
- pub fn dns_parse_rdata<'a>(
--    input: &'a [u8], message: &'a [u8], rrtype: u16,
-+    input: &'a [u8], message: &'a [u8], rrtype: u16, flags: &mut DNSNameFlags
- ) -> IResult<&'a [u8], DNSRData> {
-     match rrtype {
-         DNS_RECORD_TYPE_A => dns_parse_rdata_a(input),
-         DNS_RECORD_TYPE_AAAA => dns_parse_rdata_aaaa(input),
--        DNS_RECORD_TYPE_CNAME => dns_parse_rdata_cname(input, message),
--        DNS_RECORD_TYPE_PTR => dns_parse_rdata_ptr(input, message),
--        DNS_RECORD_TYPE_SOA => dns_parse_rdata_soa(input, message),
--        DNS_RECORD_TYPE_MX => dns_parse_rdata_mx(input, message),
--        DNS_RECORD_TYPE_NS => dns_parse_rdata_ns(input, message),
-+        DNS_RECORD_TYPE_CNAME => dns_parse_rdata_cname(input, message, flags),
-+        DNS_RECORD_TYPE_PTR => dns_parse_rdata_ptr(input, message, flags),
-+        DNS_RECORD_TYPE_SOA => dns_parse_rdata_soa(input, message, flags),
-+        DNS_RECORD_TYPE_MX => dns_parse_rdata_mx(input, message, flags),
-+        DNS_RECORD_TYPE_NS => dns_parse_rdata_ns(input, message, flags),
-         DNS_RECORD_TYPE_TXT => dns_parse_rdata_txt(input),
-         DNS_RECORD_TYPE_NULL => dns_parse_rdata_null(input),
-         DNS_RECORD_TYPE_SSHFP => dns_parse_rdata_sshfp(input),
--        DNS_RECORD_TYPE_SRV => dns_parse_rdata_srv(input, message),
-+        DNS_RECORD_TYPE_SRV => dns_parse_rdata_srv(input, message, flags),
-         _ => dns_parse_rdata_unknown(input),
-     }
- }
- 
- /// Parse a DNS request.
--pub fn dns_parse_request(input: &[u8]) -> IResult<&[u8], DNSRequest> {
-+pub fn dns_parse_request(input: &[u8]) -> IResult<&[u8], (DNSRequest, DNSNameFlags)> {
-     let i = input;
-     let (i, header) = dns_parse_header(i)?;
-     dns_parse_request_body(i, input, header)
-@@ -425,10 +442,11 @@ pub fn dns_parse_request(input: &[u8]) -> IResult<&[u8], DNSRequest> {
- 
- pub fn dns_parse_request_body<'a>(
-     input: &'a [u8], message: &'a [u8], header: DNSHeader,
--) -> IResult<&'a [u8], DNSRequest> {
-+) -> IResult<&'a [u8], (DNSRequest, DNSNameFlags)> {
-+    let mut flags = DNSNameFlags::default();
-     let i = input;
--    let (i, queries) = count(|b| dns_parse_query(b, message), header.questions as usize)(i)?;
--    Ok((i, DNSRequest { header, queries }))
-+    let (i, queries) = count(|b| dns_parse_query(b, message, &mut flags), header.questions as usize)(i)?;
-+    Ok((i, (DNSRequest { header, queries }, flags)))
- }
- 
- #[cfg(test)]
-@@ -447,7 +465,8 @@ mod tests {
-             0x03, 0x63, 0x6f, 0x6d, 0x00, 0x00, 0x01, 0x00, /* .com.... */
-         ];
-         let expected_remainder: &[u8] = &[0x00, 0x01, 0x00];
--        let (remainder, name) = dns_parse_name(buf, buf).unwrap();
-+        let mut flags = DNSNameFlags::default();
-+        let (remainder, name) = dns_parse_name(buf, buf, &mut flags).unwrap();
-         assert_eq!("client-cf.dropbox.com".as_bytes(), &name.value[..]);
-         assert_eq!(remainder, expected_remainder);
-     }
-@@ -481,7 +500,8 @@ mod tests {
- 
-         // The name at offset 54 is the complete name.
-         let start1 = &buf[54..];
--        let res1 = dns_parse_name(start1, message);
-+        let mut flags = DNSNameFlags::default();
-+        let res1 = dns_parse_name(start1, message, &mut flags);
-         assert_eq!(
-             res1,
-             Ok((
-@@ -496,7 +516,8 @@ mod tests {
-         // The second name starts at offset 80, but is just a pointer
-         // to the first.
-         let start2 = &buf[80..];
--        let res2 = dns_parse_name(start2, message);
-+        let mut flags = DNSNameFlags::default();
-+        let res2 = dns_parse_name(start2, message, &mut flags);
-         assert_eq!(
-             res2,
-             Ok((
-@@ -511,7 +532,8 @@ mod tests {
-         // The third name starts at offset 94, but is a pointer to a
-         // portion of the first.
-         let start3 = &buf[94..];
--        let res3 = dns_parse_name(start3, message);
-+        let mut flags = DNSNameFlags::default();
-+        let res3 = dns_parse_name(start3, message, &mut flags);
-         assert_eq!(
-             res3,
-             Ok((
-@@ -526,7 +548,8 @@ mod tests {
-         // The fourth name starts at offset 110, but is a pointer to a
-         // portion of the first.
-         let start4 = &buf[110..];
--        let res4 = dns_parse_name(start4, message);
-+        let mut flags = DNSNameFlags::default();
-+        let res4 = dns_parse_name(start4, message, &mut flags);
-         assert_eq!(
-             res4,
-             Ok((
-@@ -567,7 +590,8 @@ mod tests {
-         // packet).
-         let start: &[u8] = &buf[100..];
- 
--        let res = dns_parse_name(start, message);
-+        let mut flags = DNSNameFlags::default();
-+        let res = dns_parse_name(start, message, &mut flags);
-         assert_eq!(
-             res,
-             Ok((
-@@ -595,7 +619,7 @@ mod tests {
- 
-         let res = dns_parse_request(pkt);
-         match res {
--            Ok((rem, request)) => {
-+            Ok((rem, (request, _flags))) => {
-                 // For now we have some remainder data as there is an
-                 // additional record type we don't parse yet.
-                 assert!(!rem.is_empty());
-@@ -626,7 +650,7 @@ mod tests {
-     }
- 
-     /// Parse a DNS response.
--    fn dns_parse_response(message: &[u8]) -> IResult<&[u8], DNSResponse> {
-+    fn dns_parse_response(message: &[u8]) -> IResult<&[u8], (DNSResponse, DNSNameFlags)> {
-         let i = message;
-         let (i, header) = dns_parse_header(i)?;
-         dns_parse_response_body(i, message, header)
-@@ -653,7 +677,7 @@ mod tests {
- 
-         let res = dns_parse_response(pkt);
-         match res {
--            Ok((rem, response)) => {
-+            Ok((rem, (response, _flags))) => {
-                 // The response should be full parsed.
-                 assert_eq!(rem.len(), 0);
- 
-@@ -745,7 +769,7 @@ mod tests {
- 
-         let res = dns_parse_response(pkt);
-         match res {
--            Ok((rem, response)) => {
-+            Ok((rem, (response, _flags))) => {
-                 // For now we have some remainder data as there is an
-                 // additional record type we don't parse yet.
-                 assert!(!rem.is_empty());
-@@ -812,7 +836,7 @@ mod tests {
- 
-         let res = dns_parse_response(pkt);
-         match res {
--            Ok((rem, response)) => {
-+            Ok((rem, (response, _flags))) => {
-                 // The response should be fully parsed.
-                 assert_eq!(rem.len(), 0);
- 
-@@ -924,7 +948,7 @@ mod tests {
- 
-         let res = dns_parse_response(pkt);
-         match res {
--            Ok((rem, response)) => {
-+            Ok((rem, (response, _flags))) => {
-                 // The data should be fully parsed.
-                 assert_eq!(rem.len(), 0);
- 
-@@ -978,7 +1002,8 @@ mod tests {
-             }
-         }
- 
--        let (rem, name) = dns_parse_name(&buf, &buf).unwrap();
-+        let mut flags = DNSNameFlags::default();
-+        let (rem, name) = dns_parse_name(&buf, &buf, &mut flags).unwrap();
-         assert_eq!(name.value.len(), MAX_NAME_LEN);
-         assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
-         assert!(rem.is_empty());
-@@ -995,7 +1020,8 @@ mod tests {
-         // This should fail as we've hit the segment limit without a
-         // pointer, we'd need to keep parsing more segments to figure
-         // out where the next data point lies.
--        assert!(dns_parse_name(&buf, &buf).is_err());
-+        let mut flags = DNSNameFlags::default();
-+        assert!(dns_parse_name(&buf, &buf, &mut flags).is_err());
-     }
- 
-     #[test]
-@@ -1015,7 +1041,8 @@ mod tests {
-         buf.push(0b1100_0000);
-         buf.push(0b000_0000);
- 
--        let (_rem, name) = dns_parse_name(&buf[4..], &buf).unwrap();
-+        let mut flags = DNSNameFlags::default();
-+        let (_rem, name) = dns_parse_name(&buf[4..], &buf, &mut flags).unwrap();
-         assert_eq!(name.value.len(), 255);
-         assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
-     }
-@@ -1025,6 +1052,7 @@ mod tests {
-         let mut buf = vec![];
-         buf.push(0b1100_0000);
-         buf.push(0b0000_0000);
--        assert!(dns_parse_name(&buf, &buf).is_err());
-+        let mut flags = DNSNameFlags::default();
-+        assert!(dns_parse_name(&buf, &buf, &mut flags).is_err());
-     }
- }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2025-29916-01.patch b/recipes-ids/suricata/files/CVE-2025-29916-01.patch
deleted file mode 100644
index ae020e2..0000000
--- a/recipes-ids/suricata/files/CVE-2025-29916-01.patch
+++ /dev/null
@@ -1,124 +0,0 @@
-From 2f432c99a9734ea3a75c9218f35060e11a7a39ad Mon Sep 17 00:00:00 2001
-From: Victor Julien <vjulien@oisf.net>
-Date: Tue, 18 Mar 2025 10:55:39 +0100
-Subject: [PATCH] datasets: improve default hashsize handling
-
-Make hashsize default local to dataset code, instead of relying on the
-thash code.
-
-Use the same default value as before.
-
-(cherry picked from commit d32a39ca4b53d7f659f4f0a2a5c162ef97dc4797)
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/2f432c99a9734ea3a75c9218f35060e11a7a39ad]
-CVE: CVE-2025-29916
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/datasets.c | 37 +++++++++++++++++++++++--------------
- 1 file changed, 23 insertions(+), 14 deletions(-)
-
-diff --git a/src/datasets.c b/src/datasets.c
-index 32bcf6e..89e7899 100644
---- a/src/datasets.c
-+++ b/src/datasets.c
-@@ -677,6 +677,11 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-         }
-     }
- 
-+    GetDefaultMemcap(&default_memcap, &default_hashsize);
-+    if (hashsize == 0) {
-+        hashsize = default_hashsize;
-+    }
-+
-     set = DatasetAlloc(name);
-     if (set == NULL) {
-         goto out_err;
-@@ -696,12 +701,11 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-     char cnf_name[128];
-     snprintf(cnf_name, sizeof(cnf_name), "datasets.%s.hash", name);
- 
--    GetDefaultMemcap(&default_memcap, &default_hashsize);
-     switch (type) {
-         case DATASET_TYPE_MD5:
-             set->hash = THashInit(cnf_name, sizeof(Md5Type), Md5StrSet, Md5StrFree, Md5StrHash,
-                     Md5StrCompare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
--                    hashsize > 0 ? hashsize : default_hashsize);
-+                    hashsize);
-             if (set->hash == NULL)
-                 goto out_err;
-             if (DatasetLoadMd5(set) < 0)
-@@ -710,7 +714,7 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-         case DATASET_TYPE_STRING:
-             set->hash = THashInit(cnf_name, sizeof(StringType), StringSet, StringFree, StringHash,
-                     StringCompare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
--                    hashsize > 0 ? hashsize : default_hashsize);
-+                    hashsize);
-             if (set->hash == NULL)
-                 goto out_err;
-             if (DatasetLoadString(set) < 0)
-@@ -719,26 +723,25 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-         case DATASET_TYPE_SHA256:
-             set->hash = THashInit(cnf_name, sizeof(Sha256Type), Sha256StrSet, Sha256StrFree,
-                     Sha256StrHash, Sha256StrCompare, load != NULL ? 1 : 0,
--                    memcap > 0 ? memcap : default_memcap,
--                    hashsize > 0 ? hashsize : default_hashsize);
-+                    memcap > 0 ? memcap : default_memcap, hashsize);
-             if (set->hash == NULL)
-                 goto out_err;
-             if (DatasetLoadSha256(set) < 0)
-                 goto out_err;
-             break;
-         case DATASET_TYPE_IPV4:
--            set->hash = THashInit(cnf_name, sizeof(IPv4Type), IPv4Set, IPv4Free, IPv4Hash,
--                    IPv4Compare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
--                    hashsize > 0 ? hashsize : default_hashsize);
-+            set->hash =
-+                    THashInit(cnf_name, sizeof(IPv4Type), IPv4Set, IPv4Free, IPv4Hash, IPv4Compare,
-+                            load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap, hashsize);
-             if (set->hash == NULL)
-                 goto out_err;
-             if (DatasetLoadIPv4(set) < 0)
-                 goto out_err;
-             break;
-         case DATASET_TYPE_IPV6:
--            set->hash = THashInit(cnf_name, sizeof(IPv6Type), IPv6Set, IPv6Free, IPv6Hash,
--                    IPv6Compare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
--                    hashsize > 0 ? hashsize : default_hashsize);
-+            set->hash =
-+                    THashInit(cnf_name, sizeof(IPv6Type), IPv6Set, IPv6Free, IPv6Hash, IPv6Compare,
-+                            load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap, hashsize);
-             if (set->hash == NULL)
-                 goto out_err;
-             if (DatasetLoadIPv6(set) < 0)
-@@ -825,6 +828,10 @@ void DatasetPostReloadCleanup(void)
-     SCMutexUnlock(&sets_lock);
- }
- 
-+/* Value reflects THASH_DEFAULT_HASHSIZE which is what the default was earlier,
-+ * despite 2048 commented out in the default yaml. */
-+#define DATASETS_HASHSIZE_DEFAULT 4096
-+
- static void GetDefaultMemcap(uint64_t *memcap, uint32_t *hashsize)
- {
-     const char *str = NULL;
-@@ -836,12 +843,14 @@ static void GetDefaultMemcap(uint64_t *memcap, uint32_t *hashsize)
-             *memcap = 0;
-         }
-     }
-+
-+    *hashsize = (uint32_t)DATASETS_HASHSIZE_DEFAULT;
-     if (ConfGet("datasets.defaults.hashsize", &str) == 1) {
-         if (ParseSizeStringU32(str, hashsize) < 0) {
-+            *hashsize = (uint32_t)DATASETS_HASHSIZE_DEFAULT;
-             SCLogWarning("hashsize value cannot be deduced: %s,"
--                         " resetting to default",
--                    str);
--            *hashsize = 0;
-+                         " resetting to default: %u",
-+                    str, *hashsize);
-         }
-     }
- }
--- 
-2.49.0
-
diff --git a/recipes-ids/suricata/files/CVE-2025-29916-02.patch b/recipes-ids/suricata/files/CVE-2025-29916-02.patch
deleted file mode 100644
index fbaaabc..0000000
--- a/recipes-ids/suricata/files/CVE-2025-29916-02.patch
+++ /dev/null
@@ -1,197 +0,0 @@
-From e28c8c655a324a18932655a2c2b8f0d5aa1c55d7 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Tue, 18 Mar 2025 10:55:39 +0100
-Subject: [PATCH] detect: add configurable limits for datasets
-
-Ticket: 7615
-
-Avoids signatures setting extreme hash sizes, which would lead to very
-high memory use.
-
-Default to allowing:
-- 65536 per dataset
-- 16777216 total
-
-To override these built-in defaults:
-
-```yaml
-datasets:
-  # Limits for per rule dataset instances to avoid rules using too many
-  # resources.
-  limits:
-    # Max value for per dataset `hashsize` setting
-    #single-hashsize: 65536
-    # Max combined hashsize values for all datasets.
-    #total-hashsizes: 16777216
-```
-
-(cherry picked from commit a7713db709b8a0be5fc5e5809ab58e9b14a16e85)
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e28c8c655a324a18932655a2c2b8f0d5aa1c55d7]
-CVE: CVE-2025-29916
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/datasets.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
- src/util-thash.c |  5 ----
- suricata.yaml.in |  8 ++++++
- 3 files changed, 73 insertions(+), 5 deletions(-)
-
-diff --git a/src/datasets.c b/src/datasets.c
-index 89e7899..0729894 100644
---- a/src/datasets.c
-+++ b/src/datasets.c
-@@ -39,11 +39,16 @@
- #include "util-misc.h"
- #include "util-path.h"
- #include "util-debug.h"
-+#include "util-validate.h"
- 
- SCMutex sets_lock = SCMUTEX_INITIALIZER;
- static Dataset *sets = NULL;
- static uint32_t set_ids = 0;
- 
-+uint32_t dataset_max_one_hashsize = 65536;
-+uint32_t dataset_max_total_hashsize = 16777216;
-+uint32_t dataset_used_hashsize = 0;
-+
- static int DatasetAddwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
-         DataRepType *rep);
- 
-@@ -629,6 +634,34 @@ Dataset *DatasetFind(const char *name, enum DatasetTypes type)
-     return set;
- }
- 
-+static bool DatasetCheckHashsize(const char *name, uint32_t hash_size)
-+{
-+    if (dataset_max_one_hashsize > 0 && hash_size > dataset_max_one_hashsize) {
-+        SCLogError("hashsize %u in dataset '%s' exceeds configured 'single-hashsize' limit (%u)",
-+                hash_size, name, dataset_max_one_hashsize);
-+        return false;
-+    }
-+    // we cannot underflow as we know from conf loading that
-+    // dataset_max_total_hashsize >= dataset_max_one_hashsize if dataset_max_total_hashsize > 0
-+    if (dataset_max_total_hashsize > 0 &&
-+            dataset_max_total_hashsize - hash_size < dataset_used_hashsize) {
-+        SCLogError("hashsize %u in dataset '%s' exceeds configured 'total-hashsizes' limit (%u, in "
-+                   "use %u)",
-+                hash_size, name, dataset_max_total_hashsize, dataset_used_hashsize);
-+        return false;
-+    }
-+
-+    return true;
-+}
-+
-+static void DatasetUpdateHashsize(const char *name, uint32_t hash_size)
-+{
-+    if (dataset_max_total_hashsize > 0) {
-+        dataset_used_hashsize += hash_size;
-+        SCLogDebug("set %s adding with hash_size %u", name, hash_size);
-+    }
-+}
-+
- Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save, const char *load,
-         uint64_t memcap, uint32_t hashsize)
- {
-@@ -682,6 +715,10 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-         hashsize = default_hashsize;
-     }
- 
-+    if (!DatasetCheckHashsize(name, hashsize)) {
-+        goto out_err;
-+    }
-+
-     set = DatasetAlloc(name);
-     if (set == NULL) {
-         goto out_err;
-@@ -755,6 +792,10 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
-     set->next = sets;
-     sets = set;
- 
-+    /* hash size accounting */
-+    DEBUG_VALIDATE_BUG_ON(set->hash->config.hash_size != hashsize);
-+    DatasetUpdateHashsize(set->name, set->hash->config.hash_size);
-+
-     SCMutexUnlock(&sets_lock);
-     return set;
- out_err:
-@@ -796,6 +837,9 @@ void DatasetReload(void)
-             continue;
-         }
-         set->hidden = true;
-+        if (dataset_max_total_hashsize > 0) {
-+            dataset_used_hashsize -= set->hash->config.hash_size;
-+        }
-         SCLogDebug("Set %s at %p hidden successfully", set->name, set);
-         set = set->next;
-     }
-@@ -863,6 +907,27 @@ int DatasetsInit(void)
-     uint32_t default_hashsize = 0;
-     GetDefaultMemcap(&default_memcap, &default_hashsize);
-     if (datasets != NULL) {
-+        const char *str = NULL;
-+        if (ConfGet("datasets.limits.total-hashsizes", &str) == 1) {
-+            if (ParseSizeStringU32(str, &dataset_max_total_hashsize) < 0) {
-+                FatalError("failed to parse datasets.limits.total-hashsizes value: %s", str);
-+            }
-+        }
-+        if (ConfGet("datasets.limits.single-hashsize", &str) == 1) {
-+            if (ParseSizeStringU32(str, &dataset_max_one_hashsize) < 0) {
-+                FatalError("failed to parse datasets.limits.single-hashsize value: %s", str);
-+            }
-+        }
-+        if (dataset_max_total_hashsize > 0 &&
-+                dataset_max_total_hashsize < dataset_max_one_hashsize) {
-+            FatalError("total-hashsizes (%u) cannot be smaller than single-hashsize (%u)",
-+                    dataset_max_total_hashsize, dataset_max_one_hashsize);
-+        }
-+        if (dataset_max_total_hashsize > 0 && dataset_max_one_hashsize == 0) {
-+            // the total limit also applies for single limit
-+            dataset_max_one_hashsize = dataset_max_total_hashsize;
-+        }
-+
-         int list_pos = 0;
-         ConfNode *iter = NULL;
-         TAILQ_FOREACH(iter, &datasets->head, next) {
-diff --git a/src/util-thash.c b/src/util-thash.c
-index 6443990..3fba3ef 100644
---- a/src/util-thash.c
-+++ b/src/util-thash.c
-@@ -310,16 +310,11 @@ THashTableContext *THashInit(const char *cnf_prefix, size_t data_size,
-     ctx->config.hash_size = hashsize > 0 ? hashsize : THASH_DEFAULT_HASHSIZE;
-     /* Reset memcap in case of loading from file to the highest possible value
-      unless defined by the rule keyword */
--#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
--    // limit memcap size to default when fuzzing
--    ctx->config.memcap = THASH_DEFAULT_MEMCAP;
--#else
-     if (memcap > 0) {
-         ctx->config.memcap = memcap;
-     } else {
-         ctx->config.memcap = reset_memcap ? UINT64_MAX : THASH_DEFAULT_MEMCAP;
-     }
--#endif
-     ctx->config.prealloc = THASH_DEFAULT_PREALLOC;
- 
-     SC_ATOMIC_INIT(ctx->counter);
-diff --git a/suricata.yaml.in b/suricata.yaml.in
-index 6303991..b218515 100644
---- a/suricata.yaml.in
-+++ b/suricata.yaml.in
-@@ -1167,6 +1167,14 @@ datasets:
-     #memcap: 100mb
-     #hashsize: 2048
- 
-+  # Limits for per rule dataset instances to avoid rules using too many
-+  # resources.
-+  limits:
-+    # Max value for per dataset `hashsize` setting
-+    #single-hashsize: 65536
-+    # Max combined hashsize values for all datasets.
-+    #total-hashsizes: 16777216
-+
-   rules:
-     # Set to true to allow absolute filenames and filenames that use
-     # ".." components to reference parent directories in rules that specify
--- 
-2.49.0
-
diff --git a/recipes-ids/suricata/files/CVE-2025-29916-03.patch b/recipes-ids/suricata/files/CVE-2025-29916-03.patch
deleted file mode 100644
index 73e66a2..0000000
--- a/recipes-ids/suricata/files/CVE-2025-29916-03.patch
+++ /dev/null
@@ -1,55 +0,0 @@
-From d86c5f9f0c75736d4fce93e27c0773fcb27e1047 Mon Sep 17 00:00:00 2001
-From: Victor Julien <vjulien@oisf.net>
-Date: Mon, 17 Mar 2025 21:19:13 +0100
-Subject: [PATCH] datasets: set higher hashsize limits
-
-To avoid possible upgrade issues, allow higher defaults than in the
-master branch. Add some upgrade guidance and a note that defaults will
-probably be further reduced.
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/d86c5f9f0c75736d4fce93e27c0773fcb27e1047]
-CVE: CVE-2025-29916
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/datasets.c   | 5 +++--
- suricata.yaml.in | 5 +++--
- 2 files changed, 6 insertions(+), 4 deletions(-)
-
-diff --git a/src/datasets.c b/src/datasets.c
-index 0729894..f99f63c 100644
---- a/src/datasets.c
-+++ b/src/datasets.c
-@@ -45,8 +45,9 @@ SCMutex sets_lock = SCMUTEX_INITIALIZER;
- static Dataset *sets = NULL;
- static uint32_t set_ids = 0;
- 
--uint32_t dataset_max_one_hashsize = 65536;
--uint32_t dataset_max_total_hashsize = 16777216;
-+/* 4x what we set in master to allow a smoother upgrade path */
-+uint32_t dataset_max_one_hashsize = 262144;
-+uint32_t dataset_max_total_hashsize = 67108864;
- uint32_t dataset_used_hashsize = 0;
- 
- static int DatasetAddwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
-diff --git a/suricata.yaml.in b/suricata.yaml.in
-index b218515..59db9ef 100644
---- a/suricata.yaml.in
-+++ b/suricata.yaml.in
-@@ -1169,11 +1169,12 @@ datasets:
- 
-   # Limits for per rule dataset instances to avoid rules using too many
-   # resources.
-+  # Note: in Suricata 8 the built-in default will be set to lower values.
-   limits:
-     # Max value for per dataset `hashsize` setting
--    #single-hashsize: 65536
-+    #single-hashsize: 262144
-     # Max combined hashsize values for all datasets.
--    #total-hashsizes: 16777216
-+    #total-hashsizes: 67108864
- 
-   rules:
-     # Set to true to allow absolute filenames and filenames that use
--- 
-2.49.0
-
diff --git a/recipes-ids/suricata/files/CVE-2025-29917.patch b/recipes-ids/suricata/files/CVE-2025-29917.patch
deleted file mode 100644
index 8b30dbf..0000000
--- a/recipes-ids/suricata/files/CVE-2025-29917.patch
+++ /dev/null
@@ -1,115 +0,0 @@
-From bab716776ba3561cfbfd1a57fc18ff1f6859f019 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Tue, 17 Dec 2024 15:06:25 +0100
-Subject: [PATCH] detect: limit base64_decode `bytes` to 64KiB
-
-Ticket: 7613
-
-Avoids potential large per-thread memory allocation. A buffer with the
-size of the largest decode_base64 buffer size setting would be allocated
-per thread. As this was a u32, it could mean a per-thread 4GiB memory
-allocation.
-
-64KiB was already the built-in default for cases where bytes size wasn't
-specified.
-
-(cherry picked from commit 32d0bd2bbb4d486623dec85a94952fde2515f2f0)
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/bab716776ba3561cfbfd1a57fc18ff1f6859f019]
-CVE: CVE-2025-29917
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- doc/userguide/rules/base64-keywords.rst |  1 +
- src/detect-base64-decode.c              | 15 ++++++---------
- src/detect.h                            |  2 +-
- 3 files changed, 8 insertions(+), 10 deletions(-)
-
-diff --git a/doc/userguide/rules/base64-keywords.rst b/doc/userguide/rules/base64-keywords.rst
-index 7daf0c2..cf4e679 100644
---- a/doc/userguide/rules/base64-keywords.rst
-+++ b/doc/userguide/rules/base64-keywords.rst
-@@ -15,6 +15,7 @@ Syntax::
-     base64_decode:bytes <value>, offset <value>, relative;
- 
- The ``bytes`` option specifies how many bytes Suricata should decode and make available for base64_data.
-+This number is limited to 64KiB.
- The decoding will stop at the end of the buffer.
- 
- The ``offset`` option specifies how many bytes Suricata should skip before decoding.
-diff --git a/src/detect-base64-decode.c b/src/detect-base64-decode.c
-index 25fdf10..5ae38c5 100644
---- a/src/detect-base64-decode.c
-+++ b/src/detect-base64-decode.c
-@@ -28,7 +28,7 @@
- #define BASE64_DECODE_MAX 65535
- 
- typedef struct DetectBase64Decode_ {
--    uint32_t bytes;
-+    uint16_t bytes;
-     uint32_t offset;
-     uint8_t relative;
- } DetectBase64Decode;
-@@ -111,8 +111,8 @@ int DetectBase64DecodeDoMatch(DetectEngineThreadCtx *det_ctx, const Signature *s
-     return det_ctx->base64_decoded_len > 0;
- }
- 
--static int DetectBase64DecodeParse(const char *str, uint32_t *bytes,
--    uint32_t *offset, uint8_t *relative)
-+static int DetectBase64DecodeParse(
-+        const char *str, uint16_t *bytes, uint32_t *offset, uint8_t *relative)
- {
-     const char *bytes_str = NULL;
-     const char *offset_str = NULL;
-@@ -132,7 +132,7 @@ static int DetectBase64DecodeParse(const char *str, uint32_t *bytes,
- 
-     if (pcre_rc >= 3) {
-         if (pcre2_substring_get_bynumber(match, 2, (PCRE2_UCHAR8 **)&bytes_str, &pcre2_len) == 0) {
--            if (StringParseUint32(bytes, 10, 0, bytes_str) <= 0) {
-+            if (StringParseUint16(bytes, 10, 0, bytes_str) <= 0) {
-                 SCLogError("Bad value for bytes: \"%s\"", bytes_str);
-                 goto error;
-             }
-@@ -186,7 +186,7 @@ error:
- static int DetectBase64DecodeSetup(DetectEngineCtx *de_ctx, Signature *s,
-     const char *str)
- {
--    uint32_t bytes = 0;
-+    uint16_t bytes = 0;
-     uint32_t offset = 0;
-     uint8_t relative = 0;
-     DetectBase64Decode *data = NULL;
-@@ -238,9 +238,6 @@ static int DetectBase64DecodeSetup(DetectEngineCtx *de_ctx, Signature *s,
-         data->bytes = BASE64_DECODE_MAX;
-     }
-     if (data->bytes > de_ctx->base64_decode_max_len) {
--#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
--        data->bytes = BASE64_DECODE_MAX;
--#endif
-         de_ctx->base64_decode_max_len = data->bytes;
-     }
- 
-@@ -272,7 +269,7 @@ static int g_http_header_buffer_id = 0;
- static int DetectBase64TestDecodeParse(void)
- {
-     int retval = 0;
--    uint32_t bytes = 0;
-+    uint16_t bytes = 0;
-     uint32_t offset = 0;
-     uint8_t relative = 0;
- 
-diff --git a/src/detect.h b/src/detect.h
-index 2760dda..fd938a1 100644
---- a/src/detect.h
-+++ b/src/detect.h
-@@ -910,7 +910,7 @@ typedef struct DetectEngineCtx_ {
-     struct SigGroupHead_ *decoder_event_sgh;
- 
-     /* Maximum size of the buffer for decoded base64 data. */
--    uint32_t base64_decode_max_len;
-+    uint16_t base64_decode_max_len;
- 
-     /** Store rule file and line so that parsers can use them in errors. */
-     int rule_line;
--- 
-2.49.0
-
diff --git a/recipes-ids/suricata/files/CVE-2025-29918.patch b/recipes-ids/suricata/files/CVE-2025-29918.patch
deleted file mode 100644
index da9d680..0000000
--- a/recipes-ids/suricata/files/CVE-2025-29918.patch
+++ /dev/null
@@ -1,49 +0,0 @@
-From f6c9490e1f7b0b375c286d5313ebf3bc81a95eb6 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Tue, 28 Jan 2025 15:02:45 +0100
-Subject: [PATCH] detect/pcre: avoid infinite loop after negated pcre
-
-Ticket: 7526
-
-The usage of negated pcre, followed by other relative payload
-content keywords could lead to an infinite loop.
-
-This is because regular (not negated) pcre can test multiple
-occurences, but negated pcre should be tried only once.
-
-(cherry picked from commit b14c67cbdf25fa6c7ffe0d04ddf3ebe67b12b50b)
-
-Upstream-Status: Backport [https://github.com/OISF/suricata/commit/f6c9490e1f7b0b375c286d5313ebf3bc81a95eb6]
-CVE: CVE-2025-29918
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- src/detect-engine-content-inspection.c | 6 +++++-
- 1 file changed, 5 insertions(+), 1 deletion(-)
-
-diff --git a/src/detect-engine-content-inspection.c b/src/detect-engine-content-inspection.c
-index 77ebb3f..2a789c9 100644
---- a/src/detect-engine-content-inspection.c
-+++ b/src/detect-engine-content-inspection.c
-@@ -450,7 +450,6 @@ uint8_t DetectEngineContentInspection(DetectEngineCtx *de_ctx, DetectEngineThrea
-             if (r == 0) {
-                 goto no_match;
-             }
--
-             if (!(pe->flags & DETECT_PCRE_RELATIVE_NEXT)) {
-                 SCLogDebug("no relative match coming up, so this is a match");
-                 goto match;
-@@ -473,6 +472,11 @@ uint8_t DetectEngineContentInspection(DetectEngineCtx *de_ctx, DetectEngineThrea
-             if (det_ctx->discontinue_matching)
-                 goto no_match;
- 
-+            if (prev_offset == 0) {
-+                // This happens for negated PCRE
-+                // We do not search for another occurrence of this pcre
-+                SCReturnInt(0);
-+            }
-             det_ctx->buffer_offset = prev_buffer_offset;
-             det_ctx->pcre_match_start_offset = prev_offset;
-         } while (1);
--- 
-2.49.0
-
diff --git a/recipes-ids/suricata/files/CVE-2025-53537-001.patch b/recipes-ids/suricata/files/CVE-2025-53537-001.patch
deleted file mode 100644
index e16a59a..0000000
--- a/recipes-ids/suricata/files/CVE-2025-53537-001.patch
+++ /dev/null
@@ -1,79 +0,0 @@
-From 226580d502ae98c148aaecc4846f78694b5e253c Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <contact@catenacyber.fr>
-Date: Tue, 11 Mar 2025 16:45:35 +0100
-Subject: [PATCH] decompressors: do not take data after end
-
-
-CVE: CVE-2025-53537
-Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/226580d502ae98c148aaecc4846f78694b5e253c]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- htp/htp_core.h          |  5 ++++-
- htp/htp_decompressors.c | 21 ++++++++++++---------
- 2 files changed, 16 insertions(+), 10 deletions(-)
-
-diff --git a/htp/htp_core.h b/htp/htp_core.h
-index 7c23212..fb142c9 100644
---- a/htp/htp_core.h
-+++ b/htp/htp_core.h
-@@ -161,7 +161,10 @@ enum htp_content_encoding_t {
-     HTP_COMPRESSION_DEFLATE = 3,
- 
-     /** LZMA compression. */
--    HTP_COMPRESSION_LZMA = 4
-+    HTP_COMPRESSION_LZMA = 4,
-+
-+    /** No more data. */
-+    HTP_COMPRESSION_OVER = 5
- };
- 
- /**
-diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
-index 19950df..0d94c30 100644
---- a/htp/htp_decompressors.c
-+++ b/htp/htp_decompressors.c
-@@ -203,6 +203,8 @@ htp_status_t htp_gzip_decompressor_decompress(htp_decompressor_t *drec1, htp_tx_
-         }
- 
-         return HTP_OK;
-+    } else if (drec->zlib_initialized == HTP_COMPRESSION_OVER) {
-+        return HTP_ERROR;
-     }
- 
-     if (d->data == NULL) {
-@@ -316,15 +318,9 @@ restart:
-             // no initialization means previous error on stream
-             return HTP_ERROR;
-         }
--        if (GZIP_BUF_SIZE > drec->stream.avail_out) {
--            if (rc == Z_DATA_ERROR) {
--                // There is data even if there is an error
--                // So use this data and log a warning
--                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
--                rc = Z_STREAM_END;
--            }
--        }
--        if (rc == Z_STREAM_END) {
-+
-+	int error_after_data = (rc == Z_DATA_ERROR && drec->restart == 0 && GZIP_BUF_SIZE > drec->stream.avail_out);
-+        if (rc == Z_STREAM_END || error_after_data) {
-             // How many bytes do we have?
-             size_t len = GZIP_BUF_SIZE - drec->stream.avail_out;
- 
-@@ -351,6 +347,13 @@ restart:
-             drec->stream.next_out = drec->buffer;
-             // TODO Handle trailer.
- 
-+            if (error_after_data) {
-+                // There is data even if there is an error
-+                // So use this data and log a warning
-+                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
-+                drec->zlib_initialized = HTP_COMPRESSION_OVER;
-+                return HTP_ERROR;
-+            }
-             return HTP_OK;
-         }
-         else if (rc != Z_OK) {
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/CVE-2025-53537-002.patch b/recipes-ids/suricata/files/CVE-2025-53537-002.patch
deleted file mode 100644
index ff4f1a0..0000000
--- a/recipes-ids/suricata/files/CVE-2025-53537-002.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <contact@catenacyber.fr>
-Date: Tue, 17 Jun 2025 10:12:47 +0200
-Subject: [PATCH] decompressors: fix leak in lzma error case
-
-Ticket: 7766
-
-CVE: CVE-2025-53537
-Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7]
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
----
- htp/htp_decompressors.c | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
-index 0d94c30..ce6cfe1 100644
---- a/htp/htp_decompressors.c
-+++ b/htp/htp_decompressors.c
-@@ -351,6 +351,9 @@ restart:
-                 // There is data even if there is an error
-                 // So use this data and log a warning
-                 htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
-+                if (drec->zlib_initialized == HTP_COMPRESSION_LZMA) {
-+                    LzmaDec_Free(&drec->state, &lzma_Alloc);
-+                }
-                 drec->zlib_initialized = HTP_COMPRESSION_OVER;
-                 return HTP_ERROR;
-             }
--- 
-2.50.1
-
diff --git a/recipes-ids/suricata/files/fixup.patch b/recipes-ids/suricata/files/fixup.patch
deleted file mode 100644
index 0b2ae7c..0000000
--- a/recipes-ids/suricata/files/fixup.patch
+++ /dev/null
@@ -1,32 +0,0 @@
-Skip pkg Makefile from using its own rust steps
-
-Upstream-Status: Inappropriate [OE Specific]
-
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: suricata-7.0.0/Makefile.in
-===================================================================
---- suricata-7.0.0.orig/Makefile.in
-+++ suricata-7.0.0/Makefile.in
-@@ -424,7 +424,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
- 	     acsite.m4 \
- 	     scripts/generate-images.sh
- 
--SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
-+SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
-           $(SURICATA_UPDATE_DIR)
- 
- CLEANFILES = stamp-h[0-9]*
-Index: suricata-7.0.0/Makefile.am
-===================================================================
---- suricata-7.0.0.orig/Makefile.am
-+++ suricata-7.0.0/Makefile.am
-@@ -8,7 +8,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
- 	     lua \
- 	     acsite.m4 \
- 	     scripts/generate-images.sh
--SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
-+SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
-           $(SURICATA_UPDATE_DIR)
- 
- CLEANFILES = stamp-h[0-9]*
diff --git a/recipes-ids/suricata/libhtp_0.5.45.bb b/recipes-ids/suricata/libhtp_0.5.52.bb
similarity index 72%
rename from recipes-ids/suricata/libhtp_0.5.45.bb
rename to recipes-ids/suricata/libhtp_0.5.52.bb
index b87db35..d849e8f 100644
--- a/recipes-ids/suricata/libhtp_0.5.45.bb
+++ b/recipes-ids/suricata/libhtp_0.5.52.bb
@@ -4,12 +4,8 @@ require suricata.inc
 
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=596ab7963a1a0e5198e5a1c4aa621843"
 
-SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x \
-           file://CVE-2024-45797.patch \
-           file://CVE-2025-53537-001.patch \
-           file://CVE-2025-53537-002.patch \
-          "
-SRCREV = "8bdfe7b9d04e5e948c8fbaa7472e14d884cc00af"
+SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x"
+SRCREV = "314ca7360e141a1e40be58707b3abeefe32258c9"
 
 DEPENDS = "zlib"
 
diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
index 386d8d1..0755302 100644
--- a/recipes-ids/suricata/suricata-crates.inc
+++ b/recipes-ids/suricata/suricata-crates.inc
@@ -1,128 +1,547 @@
 # Autogenerated with 'bitbake -c update_crates suricata'
 
 # from rust/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/adler/1.0.2 \
-    crate://crates.io/aead/0.4.3 \
-    crate://crates.io/aes/0.7.5 \
-    crate://crates.io/aes-gcm/0.9.4 \
-    crate://crates.io/aho-corasick/0.7.20 \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-    crate://crates.io/alloc-stdlib/0.2.2 \
-    crate://crates.io/asn1-rs/0.5.2 \
-    crate://crates.io/asn1-rs-derive/0.4.0 \
-    crate://crates.io/asn1-rs-impl/0.1.0 \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/base64/0.13.1 \
-    crate://crates.io/bendy/0.3.3 \
-    crate://crates.io/bitflags/1.2.1 \
-    crate://crates.io/block-buffer/0.10.4 \
-    crate://crates.io/brotli/3.3.4 \
-    crate://crates.io/brotli-decompressor/2.3.4 \
-    crate://crates.io/build_const/0.2.2 \
-    crate://crates.io/byteorder/1.4.3 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/cipher/0.3.0 \
-    crate://crates.io/cpufeatures/0.2.9 \
-    crate://crates.io/crc/1.8.1 \
-    crate://crates.io/crc32fast/1.3.2 \
-    crate://crates.io/crypto-common/0.1.6 \
-    crate://crates.io/ctr/0.8.0 \
-    crate://crates.io/data-encoding/2.4.0 \
-    crate://crates.io/der-oid-macro/0.5.0 \
-    crate://crates.io/der-parser/6.0.1 \
-    crate://crates.io/der-parser/8.2.0 \
-    crate://crates.io/digest/0.10.7 \
-    crate://crates.io/displaydoc/0.2.4 \
-    crate://crates.io/enum_primitive/0.1.1 \
-    crate://crates.io/failure/0.1.8 \
-    crate://crates.io/failure_derive/0.1.8 \
-    crate://crates.io/flate2/1.0.26 \
-    crate://crates.io/generic-array/0.14.7 \
-    crate://crates.io/getrandom/0.2.10 \
-    crate://crates.io/ghash/0.4.4 \
-    crate://crates.io/hex/0.4.3 \
-    crate://crates.io/hkdf/0.12.3 \
-    crate://crates.io/hmac/0.12.1 \
-    crate://crates.io/ipsec-parser/0.7.0 \
-    crate://crates.io/itoa/1.0.8 \
-    crate://crates.io/kerberos-parser/0.7.1 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.147 \
-    crate://crates.io/lzma-rs/0.2.0 \
-    crate://crates.io/md-5/0.10.5 \
-    crate://crates.io/memchr/2.4.1 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/miniz_oxide/0.7.1 \
-    crate://crates.io/nom/7.1.3 \
-    crate://crates.io/nom-derive/0.10.1 \
-    crate://crates.io/nom-derive-impl/0.10.1 \
-    crate://crates.io/ntp-parser/0.6.0 \
-    crate://crates.io/num/0.2.1 \
-    crate://crates.io/num-bigint/0.2.6 \
-    crate://crates.io/num-bigint/0.4.3 \
-    crate://crates.io/num-complex/0.2.4 \
-    crate://crates.io/num-derive/0.2.5 \
-    crate://crates.io/num-integer/0.1.45 \
-    crate://crates.io/num-iter/0.1.43 \
-    crate://crates.io/num-rational/0.2.4 \
-    crate://crates.io/num-traits/0.1.43 \
-    crate://crates.io/num-traits/0.2.15 \
-    crate://crates.io/num_enum/0.5.11 \
-    crate://crates.io/num_enum_derive/0.5.11 \
-    crate://crates.io/num_threads/0.1.6 \
-    crate://crates.io/oid-registry/0.6.1 \
-    crate://crates.io/opaque-debug/0.3.0 \
-    crate://crates.io/phf/0.10.1 \
-    crate://crates.io/phf_codegen/0.10.0 \
-    crate://crates.io/phf_generator/0.10.0 \
-    crate://crates.io/phf_shared/0.10.0 \
-    crate://crates.io/polyval/0.5.3 \
-    crate://crates.io/ppv-lite86/0.2.17 \
-    crate://crates.io/proc-macro-crate/1.1.0 \
-    crate://crates.io/proc-macro2/0.4.30 \
-    crate://crates.io/proc-macro2/1.0.64 \
-    crate://crates.io/quote/0.6.13 \
-    crate://crates.io/quote/1.0.29 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/regex/1.5.6 \
-    crate://crates.io/regex-syntax/0.6.29 \
-    crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/rustversion/1.0.13 \
-    crate://crates.io/sawp/0.12.1 \
-    crate://crates.io/sawp-flags/0.12.1 \
-    crate://crates.io/sawp-flags-derive/0.12.1 \
-    crate://crates.io/sawp-modbus/0.12.1 \
-    crate://crates.io/serde/1.0.171 \
-    crate://crates.io/sha1/0.10.5 \
-    crate://crates.io/sha2/0.10.7 \
-    crate://crates.io/siphasher/0.3.10 \
-    crate://crates.io/snmp-parser/0.9.0 \
-    crate://crates.io/subtle/2.4.1 \
-    crate://crates.io/syn/0.15.44 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.25 \
-    crate://crates.io/synstructure/0.12.6 \
-    crate://crates.io/test-case/1.1.0 \
-    crate://crates.io/thiserror/1.0.43 \
-    crate://crates.io/thiserror-impl/1.0.43 \
-    crate://crates.io/time/0.3.13 \
-    crate://crates.io/time-macros/0.2.4 \
-    crate://crates.io/tls-parser/0.11.0 \
-    crate://crates.io/toml/0.5.11 \
-    crate://crates.io/typenum/1.16.0 \
-    crate://crates.io/unicode-ident/1.0.10 \
-    crate://crates.io/unicode-xid/0.1.0 \
-    crate://crates.io/unicode-xid/0.2.4 \
-    crate://crates.io/universal-hash/0.4.1 \
-    crate://crates.io/uuid/0.8.2 \
-    crate://crates.io/version_check/0.9.4 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/widestring/0.4.3 \
-    crate://crates.io/x509-parser/0.15.0 \
-"
+SRC_URI += "crate://crates.io/adler/1.0.2 \
+           crate://crates.io/aead/0.4.3 \
+           crate://crates.io/aes/0.7.5 \
+           crate://crates.io/aes-gcm/0.9.4 \
+           crate://crates.io/aho-corasick/0.7.20 \
+           crate://crates.io/alloc-no-stdlib/2.0.4 \
+           crate://crates.io/alloc-stdlib/0.2.2 \
+           crate://crates.io/asn1-rs/0.5.2 \
+           crate://crates.io/asn1-rs-derive/0.4.0 \
+           crate://crates.io/asn1-rs-impl/0.1.0 \
+           crate://crates.io/autocfg/1.1.0 \
+           crate://crates.io/base64/0.13.1 \
+           crate://crates.io/bendy/0.3.3 \
+           crate://crates.io/bitflags/1.2.1 \
+           crate://crates.io/block-buffer/0.10.4 \
+           crate://crates.io/brotli/8.0.1 \
+           crate://crates.io/brotli-decompressor/5.0.0 \
+           crate://crates.io/build_const/0.2.2 \
+           crate://crates.io/byteorder/1.4.3 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/cipher/0.3.0 \
+           crate://crates.io/cpufeatures/0.2.11 \
+           crate://crates.io/crc/1.8.1 \
+           crate://crates.io/crc32fast/1.3.2 \
+           crate://crates.io/crypto-common/0.1.6 \
+           crate://crates.io/ctr/0.8.0 \
+           crate://crates.io/data-encoding/2.4.0 \
+           crate://crates.io/der-oid-macro/0.5.0 \
+           crate://crates.io/der-parser/6.0.1 \
+           crate://crates.io/der-parser/8.2.0 \
+           crate://crates.io/digest/0.10.7 \
+           crate://crates.io/displaydoc/0.2.4 \
+           crate://crates.io/enum_primitive/0.1.1 \
+           crate://crates.io/failure/0.1.8 \
+           crate://crates.io/failure_derive/0.1.8 \
+           crate://crates.io/flate2/1.0.28 \
+           crate://crates.io/generic-array/0.14.7 \
+           crate://crates.io/getrandom/0.2.11 \
+           crate://crates.io/ghash/0.4.4 \
+           crate://crates.io/hex/0.4.3 \
+           crate://crates.io/hkdf/0.12.3 \
+           crate://crates.io/hmac/0.12.1 \
+           crate://crates.io/ipsec-parser/0.7.0 \
+           crate://crates.io/itoa/1.0.9 \
+           crate://crates.io/kerberos-parser/0.7.1 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.150 \
+           crate://crates.io/lzma-rs/0.2.0 \
+           crate://crates.io/md-5/0.10.6 \
+           crate://crates.io/memchr/2.4.1 \
+           crate://crates.io/minimal-lexical/0.2.1 \
+           crate://crates.io/miniz_oxide/0.7.1 \
+           crate://crates.io/nom/7.1.3 \
+           crate://crates.io/nom-derive/0.10.1 \
+           crate://crates.io/nom-derive-impl/0.10.1 \
+           crate://crates.io/ntp-parser/0.6.0 \
+           crate://crates.io/num/0.2.1 \
+           crate://crates.io/num-bigint/0.2.6 \
+           crate://crates.io/num-bigint/0.4.4 \
+           crate://crates.io/num-complex/0.2.4 \
+           crate://crates.io/num-derive/0.4.2 \
+           crate://crates.io/num-integer/0.1.45 \
+           crate://crates.io/num-iter/0.1.43 \
+           crate://crates.io/num-rational/0.2.4 \
+           crate://crates.io/num-traits/0.1.43 \
+           crate://crates.io/num-traits/0.2.17 \
+           crate://crates.io/num_enum/0.5.11 \
+           crate://crates.io/num_enum_derive/0.5.11 \
+           crate://crates.io/num_threads/0.1.6 \
+           crate://crates.io/oid-registry/0.6.1 \
+           crate://crates.io/opaque-debug/0.3.0 \
+           crate://crates.io/phf/0.10.1 \
+           crate://crates.io/phf_codegen/0.10.0 \
+           crate://crates.io/phf_generator/0.10.0 \
+           crate://crates.io/phf_shared/0.10.0 \
+           crate://crates.io/polyval/0.5.3 \
+           crate://crates.io/ppv-lite86/0.2.17 \
+           crate://crates.io/proc-macro-crate/1.1.0 \
+           crate://crates.io/proc-macro2/1.0.69 \
+           crate://crates.io/quote/1.0.33 \
+           crate://crates.io/rand/0.8.5 \
+           crate://crates.io/rand_chacha/0.3.1 \
+           crate://crates.io/rand_core/0.6.4 \
+           crate://crates.io/regex/1.5.6 \
+           crate://crates.io/regex-syntax/0.6.29 \
+           crate://crates.io/rusticata-macros/4.1.0 \
+           crate://crates.io/rustversion/1.0.14 \
+           crate://crates.io/sawp/0.12.1 \
+           crate://crates.io/sawp-flags/0.12.1 \
+           crate://crates.io/sawp-flags-derive/0.12.1 \
+           crate://crates.io/sawp-modbus/0.12.1 \
+           crate://crates.io/serde/1.0.192 \
+           crate://crates.io/serde_derive/1.0.192 \
+           crate://crates.io/sha1/0.10.6 \
+           crate://crates.io/sha2/0.10.8 \
+           crate://crates.io/siphasher/0.3.11 \
+           crate://crates.io/snmp-parser/0.9.0 \
+           crate://crates.io/subtle/2.4.1 \
+           crate://crates.io/syn/1.0.109 \
+           crate://crates.io/syn/2.0.39 \
+           crate://crates.io/synstructure/0.12.6 \
+           crate://crates.io/test-case/1.1.0 \
+           crate://crates.io/thiserror/1.0.50 \
+           crate://crates.io/thiserror-impl/1.0.50 \
+           crate://crates.io/time/0.3.13 \
+           crate://crates.io/time-macros/0.2.4 \
+           crate://crates.io/tls-parser/0.11.0 \
+           crate://crates.io/toml/0.5.11 \
+           crate://crates.io/typenum/1.17.0 \
+           crate://crates.io/unicode-ident/1.0.12 \
+           crate://crates.io/unicode-xid/0.2.4 \
+           crate://crates.io/universal-hash/0.4.1 \
+           crate://crates.io/uuid/0.8.2 \
+           crate://crates.io/version_check/0.9.4 \
+           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+           crate://crates.io/widestring/0.4.3 \
+           crate://crates.io/x509-parser/0.15.1 \
+           crate://crates.io/ansi_term/0.12.1 \
+           crate://crates.io/atty/0.2.14 \
+           crate://crates.io/autocfg/0.1.8 \
+           crate://crates.io/autocfg/1.1.0 \
+           crate://crates.io/bitflags/1.3.2 \
+           crate://crates.io/bstr/0.2.17 \
+           crate://crates.io/bumpalo/3.11.1 \
+           crate://crates.io/cast/0.2.7 \
+           crate://crates.io/cast/0.3.0 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/clap/2.34.0 \
+           crate://crates.io/cloudabi/0.0.3 \
+           crate://crates.io/criterion/0.3.2 \
+           crate://crates.io/criterion-plot/0.4.5 \
+           crate://crates.io/crossbeam-channel/0.5.6 \
+           crate://crates.io/crossbeam-deque/0.8.2 \
+           crate://crates.io/crossbeam-epoch/0.9.11 \
+           crate://crates.io/crossbeam-utils/0.8.12 \
+           crate://crates.io/csv/1.1.6 \
+           crate://crates.io/csv-core/0.1.10 \
+           crate://crates.io/either/1.8.0 \
+           crate://crates.io/fuchsia-cprng/0.1.1 \
+           crate://crates.io/heck/0.3.3 \
+           crate://crates.io/hermit-abi/0.1.19 \
+           crate://crates.io/itertools/0.9.0 \
+           crate://crates.io/itertools/0.10.5 \
+           crate://crates.io/itoa/0.4.8 \
+           crate://crates.io/itoa/1.0.4 \
+           crate://crates.io/js-sys/0.3.60 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.135 \
+           crate://crates.io/log/0.4.17 \
+           crate://crates.io/memchr/2.5.0 \
+           crate://crates.io/memoffset/0.6.5 \
+           crate://crates.io/num-traits/0.2.15 \
+           crate://crates.io/num_cpus/1.13.1 \
+           crate://crates.io/once_cell/1.15.0 \
+           crate://crates.io/oorandom/11.1.3 \
+           crate://crates.io/plotters/0.2.15 \
+           crate://crates.io/proc-macro-error/1.0.4 \
+           crate://crates.io/proc-macro-error-attr/1.0.4 \
+           crate://crates.io/proc-macro2/1.0.47 \
+           crate://crates.io/quote/1.0.21 \
+           crate://crates.io/rand/0.6.5 \
+           crate://crates.io/rand_chacha/0.1.1 \
+           crate://crates.io/rand_core/0.3.1 \
+           crate://crates.io/rand_core/0.4.2 \
+           crate://crates.io/rand_hc/0.1.0 \
+           crate://crates.io/rand_isaac/0.1.1 \
+           crate://crates.io/rand_jitter/0.1.4 \
+           crate://crates.io/rand_os/0.1.3 \
+           crate://crates.io/rand_pcg/0.1.2 \
+           crate://crates.io/rand_xorshift/0.1.1 \
+           crate://crates.io/rayon/1.5.3 \
+           crate://crates.io/rayon-core/1.9.3 \
+           crate://crates.io/rdrand/0.4.0 \
+           crate://crates.io/regex/1.6.0 \
+           crate://crates.io/regex-automata/0.1.10 \
+           crate://crates.io/regex-syntax/0.6.27 \
+           crate://crates.io/rustc_version/0.4.0 \
+           crate://crates.io/ryu/1.0.11 \
+           crate://crates.io/same-file/1.0.6 \
+           crate://crates.io/scopeguard/1.1.0 \
+           crate://crates.io/semver/1.0.14 \
+           crate://crates.io/serde/1.0.146 \
+           crate://crates.io/serde_derive/1.0.146 \
+           crate://crates.io/serde_json/1.0.87 \
+           crate://crates.io/strsim/0.8.0 \
+           crate://crates.io/structopt/0.3.26 \
+           crate://crates.io/structopt-derive/0.4.18 \
+           crate://crates.io/syn/1.0.103 \
+           crate://crates.io/textwrap/0.11.0 \
+           crate://crates.io/tinytemplate/1.2.1 \
+           crate://crates.io/unicode-ident/1.0.5 \
+           crate://crates.io/unicode-segmentation/1.10.0 \
+           crate://crates.io/unicode-width/0.1.10 \
+           crate://crates.io/vec_map/0.8.2 \
+           crate://crates.io/version_check/0.9.4 \
+           crate://crates.io/walkdir/2.3.2 \
+           crate://crates.io/wasm-bindgen/0.2.83 \
+           crate://crates.io/wasm-bindgen-backend/0.2.83 \
+           crate://crates.io/wasm-bindgen-macro/0.2.83 \
+           crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
+           crate://crates.io/wasm-bindgen-shared/0.2.83 \
+           crate://crates.io/web-sys/0.3.60 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-util/0.1.5 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/backtrace/0.3.46 \
+           crate://crates.io/backtrace-sys/0.1.37 \
+           crate://crates.io/cc/1.0.52 \
+           crate://crates.io/cfg-if/0.1.10 \
+           crate://crates.io/failure_derive/0.1.7 \
+           crate://crates.io/libc/0.2.69 \
+           crate://crates.io/proc-macro2/1.0.12 \
+           crate://crates.io/quote/1.0.4 \
+           crate://crates.io/rustc-demangle/0.1.16 \
+           crate://crates.io/syn/1.0.18 \
+           crate://crates.io/synstructure/0.12.3 \
+           crate://crates.io/unicode-xid/0.2.0 \
+           crate://crates.io/autocfg/1.1.0 \
+           crate://crates.io/hashbrown/0.12.3 \
+           crate://crates.io/indexmap/1.9.2 \
+           crate://crates.io/itoa/1.0.5 \
+           crate://crates.io/proc-macro2/1.0.50 \
+           crate://crates.io/quote/1.0.23 \
+           crate://crates.io/ryu/1.0.12 \
+           crate://crates.io/serde/1.0.152 \
+           crate://crates.io/serde_derive/1.0.152 \
+           crate://crates.io/serde_json/1.0.91 \
+           crate://crates.io/syn/1.0.107 \
+           crate://crates.io/unicode-ident/1.0.6 \
+           crate://crates.io/autocfg/1.0.1 \
+           crate://crates.io/bit-set/0.5.2 \
+           crate://crates.io/bit-vec/0.6.3 \
+           crate://crates.io/bitflags/1.3.2 \
+           crate://crates.io/byteorder/1.4.3 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/doc-comment/0.3.3 \
+           crate://crates.io/fnv/1.0.7 \
+           crate://crates.io/getrandom/0.2.3 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.106 \
+           crate://crates.io/memchr/2.4.1 \
+           crate://crates.io/minimal-lexical/0.2.1 \
+           crate://crates.io/num-traits/0.2.14 \
+           crate://crates.io/ppv-lite86/0.2.15 \
+           crate://crates.io/proptest/1.0.0 \
+           crate://crates.io/quick-error/1.2.3 \
+           crate://crates.io/quick-error/2.0.1 \
+           crate://crates.io/rand/0.8.4 \
+           crate://crates.io/rand_chacha/0.3.1 \
+           crate://crates.io/rand_core/0.6.3 \
+           crate://crates.io/rand_hc/0.3.1 \
+           crate://crates.io/rand_xorshift/0.3.0 \
+           crate://crates.io/redox_syscall/0.2.10 \
+           crate://crates.io/regex-syntax/0.6.25 \
+           crate://crates.io/remove_dir_all/0.5.3 \
+           crate://crates.io/rusty-fork/0.3.0 \
+           crate://crates.io/tempfile/3.2.0 \
+           crate://crates.io/wait-timeout/0.2.0 \
+           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/alloc-no-stdlib/2.0.4 \
+           crate://crates.io/alloc-stdlib/0.2.2 \
+           crate://crates.io/ansi_term/0.11.0 \
+           crate://crates.io/basic-toml/0.1.2 \
+           crate://crates.io/ctor/0.1.26 \
+           crate://crates.io/difference/2.0.0 \
+           crate://crates.io/glob/0.3.1 \
+           crate://crates.io/itoa/1.0.6 \
+           crate://crates.io/libc/0.2.142 \
+           crate://crates.io/once_cell/1.17.1 \
+           crate://crates.io/output_vt100/0.1.3 \
+           crate://crates.io/pretty_assertions/0.6.1 \
+           crate://crates.io/proc-macro2/1.0.56 \
+           crate://crates.io/quote/1.0.26 \
+           crate://crates.io/rustversion/1.0.12 \
+           crate://crates.io/ryu/1.0.13 \
+           crate://crates.io/serde/1.0.160 \
+           crate://crates.io/serde_derive/1.0.160 \
+           crate://crates.io/serde_json/1.0.96 \
+           crate://crates.io/static_assertions/1.1.0 \
+           crate://crates.io/syn/1.0.109 \
+           crate://crates.io/syn/2.0.15 \
+           crate://crates.io/termcolor/1.2.0 \
+           crate://crates.io/thiserror/1.0.40 \
+           crate://crates.io/thiserror-impl/1.0.40 \
+           crate://crates.io/trybuild/1.0.80 \
+           crate://crates.io/unicode-ident/1.0.8 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-util/0.1.5 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/asn1-rs/0.5.1 \
+           crate://crates.io/asn1-rs-derive/0.4.0 \
+           crate://crates.io/asn1-rs-impl/0.1.0 \
+           crate://crates.io/atty/0.2.14 \
+           crate://crates.io/autocfg/1.1.0 \
+           crate://crates.io/base64/0.13.1 \
+           crate://crates.io/basic-toml/0.1.2 \
+           crate://crates.io/bitvec/1.0.1 \
+           crate://crates.io/colored/2.0.0 \
+           crate://crates.io/cookie-factory/0.3.2 \
+           crate://crates.io/displaydoc/0.2.3 \
+           crate://crates.io/funty/2.0.0 \
+           crate://crates.io/glob/0.3.1 \
+           crate://crates.io/hermit-abi/0.1.19 \
+           crate://crates.io/hex-literal/0.3.4 \
+           crate://crates.io/itoa/1.0.6 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.139 \
+           crate://crates.io/memchr/2.5.0 \
+           crate://crates.io/minimal-lexical/0.2.1 \
+           crate://crates.io/nom/7.1.3 \
+           crate://crates.io/num-bigint/0.4.3 \
+           crate://crates.io/num-integer/0.1.45 \
+           crate://crates.io/num-traits/0.2.15 \
+           crate://crates.io/oid-registry/0.6.1 \
+           crate://crates.io/once_cell/1.17.1 \
+           crate://crates.io/pem/1.1.1 \
+           crate://crates.io/proc-macro2/1.0.51 \
+           crate://crates.io/quote/1.0.23 \
+           crate://crates.io/radium/0.7.0 \
+           crate://crates.io/rusticata-macros/4.1.0 \
+           crate://crates.io/ryu/1.0.13 \
+           crate://crates.io/serde/1.0.152 \
+           crate://crates.io/serde_derive/1.0.152 \
+           crate://crates.io/serde_json/1.0.94 \
+           crate://crates.io/syn/1.0.109 \
+           crate://crates.io/synstructure/0.12.6 \
+           crate://crates.io/tap/1.0.1 \
+           crate://crates.io/termcolor/1.2.0 \
+           crate://crates.io/thiserror/1.0.39 \
+           crate://crates.io/thiserror-impl/1.0.39 \
+           crate://crates.io/time/0.3.20 \
+           crate://crates.io/time-core/0.1.0 \
+           crate://crates.io/time-macros/0.2.8 \
+           crate://crates.io/trybuild/1.0.79 \
+           crate://crates.io/unicode-ident/1.0.8 \
+           crate://crates.io/unicode-xid/0.2.4 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-util/0.1.5 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/wyz/0.5.1 \
+           crate://crates.io/alloc-no-stdlib/2.0.4 \
+           crate://crates.io/alloc-stdlib/0.2.2 \
+           crate://crates.io/block-buffer/0.10.4 \
+           crate://crates.io/brotli-decompressor/5.0.0 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/cpufeatures/0.2.17 \
+           crate://crates.io/crypto-common/0.1.6 \
+           crate://crates.io/digest/0.10.7 \
+           crate://crates.io/generic-array/0.14.7 \
+           crate://crates.io/libc/0.2.172 \
+           crate://crates.io/sha2/0.10.9 \
+           crate://crates.io/typenum/1.18.0 \
+           crate://crates.io/version_check/0.9.5 \
+           crate://crates.io/atty/0.2.14 \
+           crate://crates.io/autocfg/1.0.1 \
+           crate://crates.io/bitflags/1.2.1 \
+           crate://crates.io/bstr/0.2.16 \
+           crate://crates.io/bumpalo/3.7.0 \
+           crate://crates.io/cast/0.2.7 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/clap/2.33.3 \
+           crate://crates.io/criterion/0.3.4 \
+           crate://crates.io/criterion-plot/0.4.4 \
+           crate://crates.io/crossbeam-channel/0.5.1 \
+           crate://crates.io/crossbeam-deque/0.8.1 \
+           crate://crates.io/crossbeam-epoch/0.9.5 \
+           crate://crates.io/crossbeam-utils/0.8.5 \
+           crate://crates.io/csv/1.1.6 \
+           crate://crates.io/csv-core/0.1.10 \
+           crate://crates.io/either/1.6.1 \
+           crate://crates.io/getrandom/0.2.3 \
+           crate://crates.io/half/1.7.1 \
+           crate://crates.io/hermit-abi/0.1.19 \
+           crate://crates.io/itertools/0.10.1 \
+           crate://crates.io/itoa/0.4.7 \
+           crate://crates.io/js-sys/0.3.52 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.99 \
+           crate://crates.io/log/0.4.14 \
+           crate://crates.io/memchr/2.4.0 \
+           crate://crates.io/memoffset/0.6.4 \
+           crate://crates.io/num-traits/0.2.14 \
+           crate://crates.io/num_cpus/1.13.0 \
+           crate://crates.io/oorandom/11.1.3 \
+           crate://crates.io/phf_shared/0.10.0 \
+           crate://crates.io/plotters/0.3.1 \
+           crate://crates.io/plotters-backend/0.3.2 \
+           crate://crates.io/plotters-svg/0.3.1 \
+           crate://crates.io/ppv-lite86/0.2.10 \
+           crate://crates.io/proc-macro2/1.0.28 \
+           crate://crates.io/quote/1.0.9 \
+           crate://crates.io/rand/0.8.4 \
+           crate://crates.io/rand_chacha/0.3.1 \
+           crate://crates.io/rand_core/0.6.3 \
+           crate://crates.io/rand_hc/0.3.1 \
+           crate://crates.io/rayon/1.5.1 \
+           crate://crates.io/rayon-core/1.9.1 \
+           crate://crates.io/regex/1.5.4 \
+           crate://crates.io/regex-automata/0.1.10 \
+           crate://crates.io/regex-syntax/0.6.25 \
+           crate://crates.io/rustc_version/0.4.0 \
+           crate://crates.io/ryu/1.0.5 \
+           crate://crates.io/same-file/1.0.6 \
+           crate://crates.io/scopeguard/1.1.0 \
+           crate://crates.io/semver/1.0.4 \
+           crate://crates.io/serde/1.0.127 \
+           crate://crates.io/serde_cbor/0.11.1 \
+           crate://crates.io/serde_derive/1.0.127 \
+           crate://crates.io/serde_json/1.0.66 \
+           crate://crates.io/siphasher/0.3.6 \
+           crate://crates.io/syn/1.0.74 \
+           crate://crates.io/textwrap/0.11.0 \
+           crate://crates.io/tinytemplate/1.2.1 \
+           crate://crates.io/unicode-width/0.1.8 \
+           crate://crates.io/unicode-xid/0.2.2 \
+           crate://crates.io/walkdir/2.3.2 \
+           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
+           crate://crates.io/wasm-bindgen/0.2.75 \
+           crate://crates.io/wasm-bindgen-backend/0.2.75 \
+           crate://crates.io/wasm-bindgen-macro/0.2.75 \
+           crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
+           crate://crates.io/wasm-bindgen-shared/0.2.75 \
+           crate://crates.io/web-sys/0.3.52 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-util/0.1.5 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/alloc-no-stdlib/2.0.4 \
+           crate://crates.io/asn1-rs/0.5.2 \
+           crate://crates.io/asn1-rs-derive/0.4.0 \
+           crate://crates.io/asn1-rs-impl/0.1.0 \
+           crate://crates.io/autocfg/1.1.0 \
+           crate://crates.io/bumpalo/3.13.0 \
+           crate://crates.io/cc/1.0.81 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/data-encoding/2.4.0 \
+           crate://crates.io/der-parser/8.2.0 \
+           crate://crates.io/deranged/0.3.7 \
+           crate://crates.io/displaydoc/0.2.4 \
+           crate://crates.io/itoa/1.0.9 \
+           crate://crates.io/js-sys/0.3.64 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.147 \
+           crate://crates.io/log/0.4.19 \
+           crate://crates.io/memchr/2.5.0 \
+           crate://crates.io/minimal-lexical/0.2.1 \
+           crate://crates.io/nom/7.1.3 \
+           crate://crates.io/num-bigint/0.4.3 \
+           crate://crates.io/num-integer/0.1.45 \
+           crate://crates.io/num-traits/0.2.16 \
+           crate://crates.io/oid-registry/0.6.1 \
+           crate://crates.io/once_cell/1.18.0 \
+           crate://crates.io/proc-macro2/1.0.66 \
+           crate://crates.io/quote/1.0.32 \
+           crate://crates.io/ring/0.16.20 \
+           crate://crates.io/rusticata-macros/4.1.0 \
+           crate://crates.io/serde/1.0.180 \
+           crate://crates.io/spin/0.5.2 \
+           crate://crates.io/syn/1.0.109 \
+           crate://crates.io/syn/2.0.28 \
+           crate://crates.io/synstructure/0.12.6 \
+           crate://crates.io/thiserror/1.0.44 \
+           crate://crates.io/thiserror-impl/1.0.44 \
+           crate://crates.io/time/0.3.25 \
+           crate://crates.io/time-core/0.1.1 \
+           crate://crates.io/time-macros/0.2.11 \
+           crate://crates.io/unicode-ident/1.0.11 \
+           crate://crates.io/unicode-xid/0.2.4 \
+           crate://crates.io/untrusted/0.7.1 \
+           crate://crates.io/wasm-bindgen/0.2.87 \
+           crate://crates.io/wasm-bindgen-backend/0.2.87 \
+           crate://crates.io/wasm-bindgen-macro/0.2.87 \
+           crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
+           crate://crates.io/wasm-bindgen-shared/0.2.87 \
+           crate://crates.io/web-sys/0.3.64 \
+           crate://crates.io/winapi/0.3.9 \
+           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+           crate://crates.io/aho-corasick/0.7.18 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/getrandom/0.2.6 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.125 \
+           crate://crates.io/memchr/2.5.0 \
+           crate://crates.io/quickcheck/1.0.3 \
+           crate://crates.io/rand/0.8.5 \
+           crate://crates.io/rand_core/0.6.3 \
+           crate://crates.io/regex-syntax/0.6.26 \
+           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
+           crate://crates.io/addr2line/0.14.0 \
+           crate://crates.io/adler/0.2.3 \
+           crate://crates.io/aho-corasick/0.7.15 \
+           crate://crates.io/autocfg/1.0.1 \
+           crate://crates.io/backtrace/0.3.54 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/failure/0.1.8 \
+           crate://crates.io/failure_derive/0.1.8 \
+           crate://crates.io/gimli/0.23.0 \
+           crate://crates.io/lazy_static/1.4.0 \
+           crate://crates.io/libc/0.2.80 \
+           crate://crates.io/memchr/2.3.4 \
+           crate://crates.io/miniz_oxide/0.4.3 \
+           crate://crates.io/object/0.22.0 \
+           crate://crates.io/proc-macro2/1.0.24 \
+           crate://crates.io/quote/1.0.7 \
+           crate://crates.io/regex/1.4.2 \
+           crate://crates.io/regex-syntax/0.6.21 \
+           crate://crates.io/rustc-demangle/0.1.18 \
+           crate://crates.io/serde/1.0.117 \
+           crate://crates.io/serde_bytes/0.11.5 \
+           crate://crates.io/serde_derive/1.0.117 \
+           crate://crates.io/syn/1.0.48 \
+           crate://crates.io/synstructure/0.12.4 \
+           crate://crates.io/thread_local/1.0.1 \
+           crate://crates.io/unicode-xid/0.2.1 \
+           crate://crates.io/adler/1.0.2 \
+           crate://crates.io/cc/1.0.79 \
+           crate://crates.io/cfg-if/1.0.0 \
+           crate://crates.io/cloudflare-zlib-sys/0.3.0 \
+           crate://crates.io/cmake/0.1.50 \
+           crate://crates.io/crc32fast/1.3.2 \
+           crate://crates.io/getrandom/0.2.9 \
+           crate://crates.io/libc/0.2.144 \
+           crate://crates.io/libz-ng-sys/1.1.10 \
+           crate://crates.io/libz-sys/1.1.10 \
+           crate://crates.io/miniz_oxide/0.7.1 \
+           crate://crates.io/pkg-config/0.3.27 \
+           crate://crates.io/ppv-lite86/0.2.17 \
+           crate://crates.io/quickcheck/1.0.3 \
+           crate://crates.io/rand/0.8.5 \
+           crate://crates.io/rand_chacha/0.3.1 \
+           crate://crates.io/rand_core/0.6.4 \
+           crate://crates.io/vcpkg/0.2.15 \
+           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+           "
 
 SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
 SRC_URI[aead-0.4.3.sha256sum] = "0b613b8e1e3cf911a086f53f03bf286f52fd7a7258e4fa606f0ef220d39d8877"
@@ -139,13 +558,13 @@ SRC_URI[base64-0.13.1.sha256sum] = "9e1b586273c5702936fe7b7d6896644d8be71e6314cf
 SRC_URI[bendy-0.3.3.sha256sum] = "8133e404c8bec821e531f347dab1247bf64f60882826e7228f8ffeb33a35a658"
 SRC_URI[bitflags-1.2.1.sha256sum] = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
-SRC_URI[brotli-3.3.4.sha256sum] = "a1a0b1dbcc8ae29329621f8d4f0d835787c1c38bb1401979b49d13b0b305ff68"
-SRC_URI[brotli-decompressor-2.3.4.sha256sum] = "4b6561fd3f895a11e8f72af2cb7d22e08366bebc2b6b57f7744c4bda27034744"
+SRC_URI[brotli-8.0.1.sha256sum] = "9991eea70ea4f293524138648e41ee89b0b2b12ddef3b255effa43c8056e0e0d"
+SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
 SRC_URI[build_const-0.2.2.sha256sum] = "b4ae4235e6dac0694637c763029ecea1a2ec9e4e06ec2729bd21ba4d9c863eb7"
 SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
 SRC_URI[cipher-0.3.0.sha256sum] = "7ee52072ec15386f770805afd189a01c8841be8696bed250fa2f13c4c0d6dfb7"
-SRC_URI[cpufeatures-0.2.9.sha256sum] = "a17b76ff3a4162b0b27f354a0c87015ddad39d35f9c0c36607a3bdd175dde1f1"
+SRC_URI[cpufeatures-0.2.11.sha256sum] = "ce420fe07aecd3e67c5f910618fe65e94158f6dcc0adf44e00d69ce2bdfe0fd0"
 SRC_URI[crc-1.8.1.sha256sum] = "d663548de7f5cca343f1e0a48d14dcfb0e9eb4e079ec58883b7251539fa10aeb"
 SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
@@ -159,20 +578,20 @@ SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67
 SRC_URI[enum_primitive-0.1.1.sha256sum] = "be4551092f4d519593039259a9ed8daedf0da12e5109c5280338073eaeb81180"
 SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
 SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
-SRC_URI[flate2-1.0.26.sha256sum] = "3b9429470923de8e8cbd4d2dc513535400b4b3fef0319fb5c4e1f520a7bef743"
+SRC_URI[flate2-1.0.28.sha256sum] = "46303f565772937ffe1d394a4fac6f411c6013172fadde9dcdb1e147a086940e"
 SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
-SRC_URI[getrandom-0.2.10.sha256sum] = "be4136b2a15dd319360be1c07d9933517ccf0be8f16bf62a3bee4f0d618df427"
+SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
 SRC_URI[ghash-0.4.4.sha256sum] = "1583cc1656d7839fd3732b80cf4f38850336cdb9b8ded1cd399ca62958de3c99"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
 SRC_URI[hkdf-0.12.3.sha256sum] = "791a029f6b9fc27657f6f188ec6e5e43f6911f6f878e0dc5501396e09809d437"
 SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
 SRC_URI[ipsec-parser-0.7.0.sha256sum] = "2cf8413e5de78bcbc51880ff71f4b64105719abe6efb8b4b877d3c7dc494ddd1"
-SRC_URI[itoa-1.0.8.sha256sum] = "62b02a5381cc465bd3041d84623d0fa3b66738b52b8e2fc3bab8ad63ab032f4a"
+SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
 SRC_URI[kerberos-parser-0.7.1.sha256sum] = "c10e7cfd4759cbce37ea65e2f48caebd695c246196a38e97ba4f731da48996da"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
+SRC_URI[libc-0.2.150.sha256sum] = "89d92a4743f9a61002fae18374ed11e7973f530cb3a3255fb354818118b2203c"
 SRC_URI[lzma-rs-0.2.0.sha256sum] = "aba8ecb0450dfabce4ad72085eed0a75dffe8f21f7ada05638564ea9db2d7fb1"
-SRC_URI[md-5-0.10.5.sha256sum] = "6365506850d44bff6e2fbcb5176cf63650e48bd45ef2fe2665ae1570e0f4b9ca"
+SRC_URI[md-5-0.10.6.sha256sum] = "d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
 SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
@@ -182,14 +601,14 @@ SRC_URI[nom-derive-impl-0.10.1.sha256sum] = "cd0b9a93a84b0d3ec3e70e02d332dc33ac6
 SRC_URI[ntp-parser-0.6.0.sha256sum] = "76084be9bf432d487336dd4e39b31ad93f94aecb14b81f08724f4a37b9abb7a5"
 SRC_URI[num-0.2.1.sha256sum] = "b8536030f9fea7127f841b45bb6243b27255787fb4eb83958aa1ef9d2fdc0c36"
 SRC_URI[num-bigint-0.2.6.sha256sum] = "090c7f9998ee0ff65aa5b723e4009f7b217707f1fb5ea551329cc4d6231fb304"
-SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
+SRC_URI[num-bigint-0.4.4.sha256sum] = "608e7659b5c3d7cba262d894801b9ec9d00de989e8a82bd4bef91d08da45cdc0"
 SRC_URI[num-complex-0.2.4.sha256sum] = "b6b19411a9719e753aff12e5187b74d60d3dc449ec3f4dc21e3989c3f554bc95"
-SRC_URI[num-derive-0.2.5.sha256sum] = "eafd0b45c5537c3ba526f79d3e75120036502bebacbb3f3220914067ce39dbf2"
+SRC_URI[num-derive-0.4.2.sha256sum] = "ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
 SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
 SRC_URI[num-iter-0.1.43.sha256sum] = "7d03e6c028c5dc5cac6e2dec0efda81fc887605bb3d884578bb6d6bf7514e252"
 SRC_URI[num-rational-0.2.4.sha256sum] = "5c000134b5dbf44adc5cb772486d335293351644b801551abe8f75c84cfa4aef"
 SRC_URI[num-traits-0.1.43.sha256sum] = "92e5113e9fd4cc14ded8e499429f396a20f98c772a47cc8622a736e1ec843c31"
-SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
+SRC_URI[num-traits-0.2.17.sha256sum] = "39e3200413f237f41ab11ad6d161bc7239c84dcb631773ccd7de3dfe4b5c267c"
 SRC_URI[num_enum-0.5.11.sha256sum] = "1f646caf906c20226733ed5b1374287eb97e3c2a5c227ce668c1f2ce20ae57c9"
 SRC_URI[num_enum_derive-0.5.11.sha256sum] = "dcbff9bc912032c62bf65ef1d5aea88983b420f4f839db1e9b0c281a25c9c799"
 SRC_URI[num_threads-0.1.6.sha256sum] = "2819ce041d2ee131036f4fc9d6ae7ae125a3a40e97ba64d04fe799ad9dabbb44"
@@ -202,140 +621,46 @@ SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456
 SRC_URI[polyval-0.5.3.sha256sum] = "8419d2b623c7c0896ff2d5d96e2cb4ede590fed28fcc34934f4c33c036e620a1"
 SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[proc-macro-crate-1.1.0.sha256sum] = "1ebace6889caf889b4d3f76becee12e90353f2b8c7d875534a71e5742f8f6f83"
-SRC_URI[proc-macro2-0.4.30.sha256sum] = "cf3d2011ab5c909338f7887f4fc896d35932e29146c12c8d01da6b22a80ba759"
-SRC_URI[proc-macro2-1.0.64.sha256sum] = "78803b62cbf1f46fde80d7c0e803111524b9877184cfe7c3033659490ac7a7da"
-SRC_URI[quote-0.6.13.sha256sum] = "6ce23b6b870e8f94f81fb0a363d65d86675884b34a09043c81e5562f11c1f8e1"
-SRC_URI[quote-1.0.29.sha256sum] = "573015e8ab27661678357f27dc26460738fd2b6c86e46f386fde94cb5d913105"
+SRC_URI[proc-macro2-1.0.69.sha256sum] = "134c189feb4956b20f6f547d2cf727d4c0fe06722b20a0eec87ed445a97f92da"
+SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
 SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
 SRC_URI[regex-1.5.6.sha256sum] = "d83f127d94bdbcda4c8cc2e50f6f84f4b611f69c902699ca385a39c3a75f9ff1"
 SRC_URI[regex-syntax-0.6.29.sha256sum] = "f162c6dd7b008981e4d40210aca20b4bd0f9b60ca9271061b07f78537722f2e1"
 SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[rustversion-1.0.13.sha256sum] = "dc31bd9b61a32c31f9650d18add92aa83a49ba979c143eefd27fe7177b05bd5f"
+SRC_URI[rustversion-1.0.14.sha256sum] = "7ffc183a10b4478d04cbbbfc96d0873219d962dd5accaff2ffbd4ceb7df837f4"
 SRC_URI[sawp-0.12.1.sha256sum] = "7e74f84d736420afcba72f689a494d275c97cf4775c3fe248f937e9d3bf83e30"
 SRC_URI[sawp-flags-0.12.1.sha256sum] = "1f2b22023d224b5314d51e53bfb2dbca53dc2cf90a4435aa4feb78172799dad0"
 SRC_URI[sawp-flags-derive-0.12.1.sha256sum] = "49a585d3c22887d23bb06dd602b8ce96c2a716e1fa89beec8bfb49e466f2d643"
 SRC_URI[sawp-modbus-0.12.1.sha256sum] = "2cbad9b003999a0f3016fb3603da113ff86f06279ccf6aacb577058168c0568d"
-SRC_URI[serde-1.0.171.sha256sum] = "30e27d1e4fd7659406c492fd6cfaf2066ba8773de45ca75e855590f856dc34a9"
-SRC_URI[sha1-0.10.5.sha256sum] = "f04293dc80c3993519f2d7f6f511707ee7094fe0c6d3406feb330cdb3540eba3"
-SRC_URI[sha2-0.10.7.sha256sum] = "479fb9d862239e610720565ca91403019f2f00410f1864c5aa7479b950a76ed8"
-SRC_URI[siphasher-0.3.10.sha256sum] = "7bd3e3206899af3f8b12af284fafc038cc1dc2b41d1b89dd17297221c5d225de"
+SRC_URI[serde-1.0.192.sha256sum] = "bca2a08484b285dcb282d0f67b26cadc0df8b19f8c12502c13d966bf9482f001"
+SRC_URI[serde_derive-1.0.192.sha256sum] = "d6c7207fbec9faa48073f3e3074cbe553af6ea512d7c21ba46e434e70ea9fbc1"
+SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
+SRC_URI[sha2-0.10.8.sha256sum] = "793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
+SRC_URI[siphasher-0.3.11.sha256sum] = "38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
 SRC_URI[snmp-parser-0.9.0.sha256sum] = "773a26ad6742636f4259e7cc32262efb31feabd56bc34f0b2f28de9801aa24b3"
 SRC_URI[subtle-2.4.1.sha256sum] = "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
-SRC_URI[syn-0.15.44.sha256sum] = "9ca4b3b69a77cbe1ffc9e198781b7acb0c7365a883670e8f1c1bc66fba79a5c5"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.25.sha256sum] = "15e3fc8c0c74267e2df136e5e5fb656a464158aa57624053375eb9c8c6e25ae2"
+SRC_URI[syn-2.0.39.sha256sum] = "23e78b90f2fcf45d3e842032ce32e3f2d1545ba6636271dcbf24fa306d87be7a"
 SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
 SRC_URI[test-case-1.1.0.sha256sum] = "956044ef122917dde830c19dec5f76d0670329fde4104836d62ebcb14f4865f1"
-SRC_URI[thiserror-1.0.43.sha256sum] = "a35fc5b8971143ca348fa6df4f024d4d55264f3468c71ad1c2f365b0a4d58c42"
-SRC_URI[thiserror-impl-1.0.43.sha256sum] = "463fe12d7993d3b327787537ce8dd4dfa058de32fc2b195ef3cde03dc4771e8f"
+SRC_URI[thiserror-1.0.50.sha256sum] = "f9a7210f5c9a7156bb50aa36aed4c95afb51df0df00713949448cf9e97d382d2"
+SRC_URI[thiserror-impl-1.0.50.sha256sum] = "266b2e40bc00e5a6c09c3584011e08b06f123c00362c92b975ba9843aaaa14b8"
 SRC_URI[time-0.3.13.sha256sum] = "db76ff9fa4b1458b3c7f077f3ff9887394058460d21e634355b273aaf11eea45"
 SRC_URI[time-macros-0.2.4.sha256sum] = "42657b1a6f4d817cda8e7a0ace261fe0cc946cf3a80314390b22cc61ae080792"
 SRC_URI[tls-parser-0.11.0.sha256sum] = "409206e2de64edbf7ea99a44ac31680daf9ef1a57895fb3c5bd738a903691be0"
 SRC_URI[toml-0.5.11.sha256sum] = "f4f7f0dd8d50a853a531c426359045b1998f04219d88799810762cd4ad314234"
-SRC_URI[typenum-1.16.0.sha256sum] = "497961ef93d974e23eb6f433eb5fe1b7930b659f06d12dec6fc44a8f554c0bba"
-SRC_URI[unicode-ident-1.0.10.sha256sum] = "22049a19f4a68748a168c0fc439f9516686aa045927ff767eca0a85101fb6e73"
-SRC_URI[unicode-xid-0.1.0.sha256sum] = "fc72304796d0818e357ead4e000d19c9c174ab23dc11093ac919054d20a6a7fc"
+SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
 SRC_URI[universal-hash-0.4.1.sha256sum] = "9f214e8f697e925001e66ec2c6e37a4ef93f0f78c2eed7814394e10c62025b05"
 SRC_URI[uuid-0.8.2.sha256sum] = "bc5cf98d8186244414c848017f0e2676b3fcb46807f6668a97dfe67359a3c4b7"
 SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
 SRC_URI[widestring-0.4.3.sha256sum] = "c168940144dd21fd8046987c16a46a33d5fc84eec29ef9dcddc2ac9e31526b7c"
-SRC_URI[x509-parser-0.15.0.sha256sum] = "bab0c2f54ae1d92f4fcb99c0b7ccf0b1e3451cbd395e5f115ccbdbcb18d4f634"
+SRC_URI[x509-parser-0.15.1.sha256sum] = "7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
 # from rust/vendor/base64/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/ansi_term/0.12.1 \
-    crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/0.1.8 \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bstr/0.2.17 \
-    crate://crates.io/bumpalo/3.11.1 \
-    crate://crates.io/cast/0.2.7 \
-    crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/2.34.0 \
-    crate://crates.io/cloudabi/0.0.3 \
-    crate://crates.io/criterion/0.3.2 \
-    crate://crates.io/criterion-plot/0.4.5 \
-    crate://crates.io/crossbeam-channel/0.5.6 \
-    crate://crates.io/crossbeam-deque/0.8.2 \
-    crate://crates.io/crossbeam-epoch/0.9.11 \
-    crate://crates.io/crossbeam-utils/0.8.12 \
-    crate://crates.io/csv/1.1.6 \
-    crate://crates.io/csv-core/0.1.10 \
-    crate://crates.io/either/1.8.0 \
-    crate://crates.io/fuchsia-cprng/0.1.1 \
-    crate://crates.io/heck/0.3.3 \
-    crate://crates.io/hermit-abi/0.1.19 \
-    crate://crates.io/itertools/0.9.0 \
-    crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itoa/0.4.8 \
-    crate://crates.io/itoa/1.0.4 \
-    crate://crates.io/js-sys/0.3.60 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.135 \
-    crate://crates.io/log/0.4.17 \
-    crate://crates.io/memchr/2.5.0 \
-    crate://crates.io/memoffset/0.6.5 \
-    crate://crates.io/num-traits/0.2.15 \
-    crate://crates.io/num_cpus/1.13.1 \
-    crate://crates.io/once_cell/1.15.0 \
-    crate://crates.io/oorandom/11.1.3 \
-    crate://crates.io/plotters/0.2.15 \
-    crate://crates.io/proc-macro-error/1.0.4 \
-    crate://crates.io/proc-macro-error-attr/1.0.4 \
-    crate://crates.io/proc-macro2/1.0.47 \
-    crate://crates.io/quote/1.0.21 \
-    crate://crates.io/rand/0.6.5 \
-    crate://crates.io/rand_chacha/0.1.1 \
-    crate://crates.io/rand_core/0.3.1 \
-    crate://crates.io/rand_core/0.4.2 \
-    crate://crates.io/rand_hc/0.1.0 \
-    crate://crates.io/rand_isaac/0.1.1 \
-    crate://crates.io/rand_jitter/0.1.4 \
-    crate://crates.io/rand_os/0.1.3 \
-    crate://crates.io/rand_pcg/0.1.2 \
-    crate://crates.io/rand_xorshift/0.1.1 \
-    crate://crates.io/rayon/1.5.3 \
-    crate://crates.io/rayon-core/1.9.3 \
-    crate://crates.io/rdrand/0.4.0 \
-    crate://crates.io/regex/1.6.0 \
-    crate://crates.io/regex-automata/0.1.10 \
-    crate://crates.io/regex-syntax/0.6.27 \
-    crate://crates.io/rustc_version/0.4.0 \
-    crate://crates.io/ryu/1.0.11 \
-    crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/scopeguard/1.1.0 \
-    crate://crates.io/semver/1.0.14 \
-    crate://crates.io/serde/1.0.146 \
-    crate://crates.io/serde_derive/1.0.146 \
-    crate://crates.io/serde_json/1.0.87 \
-    crate://crates.io/strsim/0.8.0 \
-    crate://crates.io/structopt/0.3.26 \
-    crate://crates.io/structopt-derive/0.4.18 \
-    crate://crates.io/syn/1.0.103 \
-    crate://crates.io/textwrap/0.11.0 \
-    crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/unicode-ident/1.0.5 \
-    crate://crates.io/unicode-segmentation/1.10.0 \
-    crate://crates.io/unicode-width/0.1.10 \
-    crate://crates.io/vec_map/0.8.2 \
-    crate://crates.io/version_check/0.9.4 \
-    crate://crates.io/walkdir/2.3.2 \
-    crate://crates.io/wasm-bindgen/0.2.83 \
-    crate://crates.io/wasm-bindgen-backend/0.2.83 \
-    crate://crates.io/wasm-bindgen-macro/0.2.83 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
-    crate://crates.io/wasm-bindgen-shared/0.2.83 \
-    crate://crates.io/web-sys/0.3.60 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-"
 
 SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
 SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
@@ -426,38 +751,74 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/failure/Cargo.lock
+
+SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
+SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399"
+SRC_URI[cc-1.0.52.sha256sum] = "c3d87b23d6a92cd03af510a5ade527033f6aa6fa92161e2d5863a907d4c5e31d"
+SRC_URI[cfg-if-0.1.10.sha256sum] = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822"
+SRC_URI[failure_derive-0.1.7.sha256sum] = "030a733c8287d6213886dd487564ff5c8f6aae10278b3588ed177f9d18f8d231"
+SRC_URI[libc-0.2.69.sha256sum] = "99e85c08494b21a9054e7fe1374a732aeadaff3980b6990b94bfd3a70f690005"
+SRC_URI[proc-macro2-1.0.12.sha256sum] = "8872cf6f48eee44265156c111456a700ab3483686b3f96df4cf5481c89157319"
+SRC_URI[quote-1.0.4.sha256sum] = "4c1f4b0efa5fc5e8ceb705136bfee52cfdb6a4e3509f770b478cd6ed434232a7"
+SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783"
+SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
+SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
+SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
+# from rust/vendor/toml/Cargo.lock
+
+SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
+SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
+SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
+SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
+SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
+SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
+SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
+SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
+SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
+SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
+SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
+# from rust/vendor/nom/Cargo.lock
+
+SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
+SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
+SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
+SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
+SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
+SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
+SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
+SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
+SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
+SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
+SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
+SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
+SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
+SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
+SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
+SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
+SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
+SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
+SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/brotli-decompressor/Cargo.lock
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
+SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
 # from rust/vendor/displaydoc/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/ansi_term/0.11.0 \
-    crate://crates.io/basic-toml/0.1.2 \
-    crate://crates.io/ctor/0.1.26 \
-    crate://crates.io/difference/2.0.0 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/itoa/1.0.6 \
-    crate://crates.io/libc/0.2.142 \
-    crate://crates.io/once_cell/1.17.1 \
-    crate://crates.io/output_vt100/0.1.3 \
-    crate://crates.io/pretty_assertions/0.6.1 \
-    crate://crates.io/proc-macro2/1.0.56 \
-    crate://crates.io/quote/1.0.26 \
-    crate://crates.io/rustversion/1.0.12 \
-    crate://crates.io/ryu/1.0.13 \
-    crate://crates.io/serde/1.0.160 \
-    crate://crates.io/serde_derive/1.0.160 \
-    crate://crates.io/serde_json/1.0.96 \
-    crate://crates.io/static_assertions/1.1.0 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.15 \
-    crate://crates.io/termcolor/1.2.0 \
-    crate://crates.io/thiserror/1.0.40 \
-    crate://crates.io/thiserror-impl/1.0.40 \
-    crate://crates.io/trybuild/1.0.80 \
-    crate://crates.io/unicode-ident/1.0.8 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-"
 
 SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
 SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
@@ -489,60 +850,6 @@ SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5c
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 # from rust/vendor/asn1-rs/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/asn1-rs/0.5.1 \
-    crate://crates.io/asn1-rs-derive/0.4.0 \
-    crate://crates.io/asn1-rs-impl/0.1.0 \
-    crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/base64/0.13.1 \
-    crate://crates.io/basic-toml/0.1.2 \
-    crate://crates.io/bitvec/1.0.1 \
-    crate://crates.io/colored/2.0.0 \
-    crate://crates.io/cookie-factory/0.3.2 \
-    crate://crates.io/displaydoc/0.2.3 \
-    crate://crates.io/funty/2.0.0 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/hermit-abi/0.1.19 \
-    crate://crates.io/hex-literal/0.3.4 \
-    crate://crates.io/itoa/1.0.6 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.139 \
-    crate://crates.io/memchr/2.5.0 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/nom/7.1.3 \
-    crate://crates.io/num-bigint/0.4.3 \
-    crate://crates.io/num-integer/0.1.45 \
-    crate://crates.io/num-traits/0.2.15 \
-    crate://crates.io/oid-registry/0.6.1 \
-    crate://crates.io/once_cell/1.17.1 \
-    crate://crates.io/pem/1.1.1 \
-    crate://crates.io/proc-macro2/1.0.51 \
-    crate://crates.io/quote/1.0.23 \
-    crate://crates.io/radium/0.7.0 \
-    crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/ryu/1.0.13 \
-    crate://crates.io/serde/1.0.152 \
-    crate://crates.io/serde_derive/1.0.152 \
-    crate://crates.io/serde_json/1.0.94 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/synstructure/0.12.6 \
-    crate://crates.io/tap/1.0.1 \
-    crate://crates.io/termcolor/1.2.0 \
-    crate://crates.io/thiserror/1.0.39 \
-    crate://crates.io/thiserror-impl/1.0.39 \
-    crate://crates.io/time/0.3.20 \
-    crate://crates.io/time-core/0.1.0 \
-    crate://crates.io/time-macros/0.2.8 \
-    crate://crates.io/trybuild/1.0.79 \
-    crate://crates.io/unicode-ident/1.0.8 \
-    crate://crates.io/unicode-xid/0.2.4 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/wyz/0.5.1 \
-"
 
 SRC_URI[asn1-rs-0.5.1.sha256sum] = "cf6690c370453db30743b373a60ba498fc0d6d83b11f4abfd87a84a075db5dd4"
 SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
@@ -596,383 +903,22 @@ SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5c
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
-# from rust/vendor/flate2/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/adler/1.0.2 \
-    crate://crates.io/cc/1.0.73 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/cloudflare-zlib-sys/0.3.0 \
-    crate://crates.io/cmake/0.1.48 \
-    crate://crates.io/crc32fast/1.3.2 \
-    crate://crates.io/getrandom/0.2.6 \
-    crate://crates.io/libc/0.2.124 \
-    crate://crates.io/libz-ng-sys/1.1.8 \
-    crate://crates.io/libz-sys/1.1.8 \
-    crate://crates.io/miniz_oxide/0.7.1 \
-    crate://crates.io/pkg-config/0.3.25 \
-    crate://crates.io/ppv-lite86/0.2.16 \
-    crate://crates.io/quickcheck/1.0.3 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/vcpkg/0.2.15 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-"
-
-SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
-SRC_URI[cc-1.0.73.sha256sum] = "2fff2a6927b3bb87f9595d67196a70493f627687a71d87a0d692242c33f58c11"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
-SRC_URI[cmake-0.1.48.sha256sum] = "e8ad8cef104ac57b68b89df3208164d228503abbdce70f6880ffa3d970e7443a"
-SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
-SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
-SRC_URI[libc-0.2.124.sha256sum] = "21a41fed9d98f27ab1c6d161da622a4fa35e8a54a8adc24bbf3ddd0ef70b0e50"
-SRC_URI[libz-ng-sys-1.1.8.sha256sum] = "4399ae96a9966bf581e726de86969f803a81b7ce795fcd5480e640589457e0f2"
-SRC_URI[libz-sys-1.1.8.sha256sum] = "9702761c3935f8cc2f101793272e202c72b99da8f4224a19ddcf1279a6450bbf"
-SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
-SRC_URI[pkg-config-0.3.25.sha256sum] = "1df8c4ec4b0627e53bdf214615ad287367e482558cf84b109250b37464dc03ae"
-SRC_URI[ppv-lite86-0.2.16.sha256sum] = "eb9f9e6e233e5c4a35559a617bf40a4ec447db2e84c20b55a6f83167b7e57872"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
-# from rust/vendor/toml/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/hashbrown/0.12.3 \
-    crate://crates.io/indexmap/1.9.2 \
-    crate://crates.io/itoa/1.0.5 \
-    crate://crates.io/proc-macro2/1.0.50 \
-    crate://crates.io/quote/1.0.23 \
-    crate://crates.io/ryu/1.0.12 \
-    crate://crates.io/serde/1.0.152 \
-    crate://crates.io/serde_derive/1.0.152 \
-    crate://crates.io/serde_json/1.0.91 \
-    crate://crates.io/syn/1.0.107 \
-    crate://crates.io/unicode-ident/1.0.6 \
-"
-
-SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
-SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
-SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
-SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
-SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
-SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
-SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
-SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
-SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
-SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
-SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
-# from rust/vendor/nom/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/bit-set/0.5.2 \
-    crate://crates.io/bit-vec/0.6.3 \
-    crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/byteorder/1.4.3 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/doc-comment/0.3.3 \
-    crate://crates.io/fnv/1.0.7 \
-    crate://crates.io/getrandom/0.2.3 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.106 \
-    crate://crates.io/memchr/2.4.1 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/num-traits/0.2.14 \
-    crate://crates.io/ppv-lite86/0.2.15 \
-    crate://crates.io/proptest/1.0.0 \
-    crate://crates.io/quick-error/1.2.3 \
-    crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/rand/0.8.4 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/rand_hc/0.3.1 \
-    crate://crates.io/rand_xorshift/0.3.0 \
-    crate://crates.io/redox_syscall/0.2.10 \
-    crate://crates.io/regex-syntax/0.6.25 \
-    crate://crates.io/remove_dir_all/0.5.3 \
-    crate://crates.io/rusty-fork/0.3.0 \
-    crate://crates.io/tempfile/3.2.0 \
-    crate://crates.io/wait-timeout/0.2.0 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-"
-
-SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
-SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
-SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
-SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
-SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
-SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
-SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
-SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
-SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
-SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
-SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
-SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
-SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
-SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
-SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
-SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
-SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
-SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
-SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 # from rust/vendor/brotli/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.3 \
-    crate://crates.io/alloc-stdlib/0.2.1 \
-    crate://crates.io/block-buffer/0.7.3 \
-    crate://crates.io/block-padding/0.1.5 \
-    crate://crates.io/brotli-decompressor/2.3.2 \
-    crate://crates.io/byte-tools/0.3.1 \
-    crate://crates.io/byteorder/1.4.3 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/digest/0.8.1 \
-    crate://crates.io/fake-simd/0.1.2 \
-    crate://crates.io/generic-array/0.12.4 \
-    crate://crates.io/libm/0.1.4 \
-    crate://crates.io/opaque-debug/0.2.3 \
-    crate://crates.io/packed_simd_2/0.3.7 \
-    crate://crates.io/sha2/0.8.2 \
-    crate://crates.io/typenum/1.15.0 \
-"
-
-SRC_URI[alloc-no-stdlib-2.0.3.sha256sum] = "35ef4730490ad1c4eae5c4325b2a95f521d023e5c885853ff7aca0a6a1631db3"
-SRC_URI[alloc-stdlib-0.2.1.sha256sum] = "697ed7edc0f1711de49ce108c541623a0af97c6c60b2f6e2b65229847ac843c2"
-SRC_URI[block-buffer-0.7.3.sha256sum] = "c0940dc441f31689269e10ac70eb1002a3a1d3ad1390e030043662eb7fe4688b"
-SRC_URI[block-padding-0.1.5.sha256sum] = "fa79dedbb091f449f1f39e53edf88d5dbe95f895dae6135a8d7b881fb5af73f5"
-SRC_URI[brotli-decompressor-2.3.2.sha256sum] = "59ad2d4653bf5ca36ae797b1f4bb4dbddb60ce49ca4aed8a2ce4829f60425b80"
-SRC_URI[byte-tools-0.3.1.sha256sum] = "e3b5ca7a04898ad4bcd41c90c5285445ff5b791899bb1b0abdd2a2aa791211d7"
-SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[digest-0.8.1.sha256sum] = "f3d0c8c8752312f9713efd397ff63acb9f85585afbf179282e720e7704954dd5"
-SRC_URI[fake-simd-0.1.2.sha256sum] = "e88a8acf291dafb59c2d96e8f59828f3838bb1a70398823ade51a84de6a6deed"
-SRC_URI[generic-array-0.12.4.sha256sum] = "ffdf9f34f1447443d37393cc6c2b8313aebddcd96906caf34e54c68d8e57d7bd"
-SRC_URI[libm-0.1.4.sha256sum] = "7fc7aa29613bd6a620df431842069224d8bc9011086b1db4c0e0cd47fa03ec9a"
-SRC_URI[opaque-debug-0.2.3.sha256sum] = "2839e79665f131bdb5782e51f2c6c9599c133c6098982a54c794358bf432529c"
-SRC_URI[packed_simd_2-0.3.7.sha256sum] = "defdcfef86dcc44ad208f71d9ff4ce28df6537a4e0d6b0e8e845cb8ca10059a6"
-SRC_URI[sha2-0.8.2.sha256sum] = "a256f46ea78a0c0d9ff00077504903ac881a1dafdc20da66545699e7776b3e69"
-SRC_URI[typenum-1.15.0.sha256sum] = "dcf81ac59edc17cc8697ff311e8f5ef2d99fcbd9817b34cec66f90b6c3dfd987"
-# from rust/vendor/failure/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/backtrace/0.3.46 \
-    crate://crates.io/backtrace-sys/0.1.37 \
-    crate://crates.io/cc/1.0.52 \
-    crate://crates.io/cfg-if/0.1.10 \
-    crate://crates.io/failure_derive/0.1.7 \
-    crate://crates.io/libc/0.2.69 \
-    crate://crates.io/proc-macro2/1.0.12 \
-    crate://crates.io/quote/1.0.4 \
-    crate://crates.io/rustc-demangle/0.1.16 \
-    crate://crates.io/syn/1.0.18 \
-    crate://crates.io/synstructure/0.12.3 \
-    crate://crates.io/unicode-xid/0.2.0 \
-"
-
-SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
-SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399"
-SRC_URI[cc-1.0.52.sha256sum] = "c3d87b23d6a92cd03af510a5ade527033f6aa6fa92161e2d5863a907d4c5e31d"
-SRC_URI[cfg-if-0.1.10.sha256sum] = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822"
-SRC_URI[failure_derive-0.1.7.sha256sum] = "030a733c8287d6213886dd487564ff5c8f6aae10278b3588ed177f9d18f8d231"
-SRC_URI[libc-0.2.69.sha256sum] = "99e85c08494b21a9054e7fe1374a732aeadaff3980b6990b94bfd3a70f690005"
-SRC_URI[proc-macro2-1.0.12.sha256sum] = "8872cf6f48eee44265156c111456a700ab3483686b3f96df4cf5481c89157319"
-SRC_URI[quote-1.0.4.sha256sum] = "4c1f4b0efa5fc5e8ceb705136bfee52cfdb6a4e3509f770b478cd6ed434232a7"
-SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783"
-SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
-SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
-SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
-# from rust/vendor/alloc-stdlib/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-"
-
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-# from rust/vendor/bendy/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/addr2line/0.14.0 \
-    crate://crates.io/adler/0.2.3 \
-    crate://crates.io/aho-corasick/0.7.15 \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/backtrace/0.3.54 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/failure/0.1.8 \
-    crate://crates.io/failure_derive/0.1.8 \
-    crate://crates.io/gimli/0.23.0 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.80 \
-    crate://crates.io/memchr/2.3.4 \
-    crate://crates.io/miniz_oxide/0.4.3 \
-    crate://crates.io/object/0.22.0 \
-    crate://crates.io/proc-macro2/1.0.24 \
-    crate://crates.io/quote/1.0.7 \
-    crate://crates.io/regex/1.4.2 \
-    crate://crates.io/regex-syntax/0.6.21 \
-    crate://crates.io/rustc-demangle/0.1.18 \
-    crate://crates.io/serde/1.0.117 \
-    crate://crates.io/serde_bytes/0.11.5 \
-    crate://crates.io/serde_derive/1.0.117 \
-    crate://crates.io/syn/1.0.48 \
-    crate://crates.io/synstructure/0.12.4 \
-    crate://crates.io/thread_local/1.0.1 \
-    crate://crates.io/unicode-xid/0.2.1 \
-"
-
-SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
-SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
-SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
-SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
-SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
-SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
-SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
-SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
-SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
-SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
-SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
-SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
-SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
-SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
-SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
-SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
-SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
-SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
-SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
-SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
-SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
-SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
-# from rust/vendor/regex/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/aho-corasick/0.7.18 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/getrandom/0.2.6 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.125 \
-    crate://crates.io/memchr/2.5.0 \
-    crate://crates.io/quickcheck/1.0.3 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/regex-syntax/0.6.26 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-"
-
-SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
-SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
-# from rust/vendor/brotli-decompressor/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-    crate://crates.io/alloc-stdlib/0.2.2 \
-"
 
 SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
 SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
+SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
+SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
+SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
+SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
+SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
+SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 # from rust/vendor/phf_generator/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/bitflags/1.2.1 \
-    crate://crates.io/bstr/0.2.16 \
-    crate://crates.io/bumpalo/3.7.0 \
-    crate://crates.io/cast/0.2.7 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/2.33.3 \
-    crate://crates.io/criterion/0.3.4 \
-    crate://crates.io/criterion-plot/0.4.4 \
-    crate://crates.io/crossbeam-channel/0.5.1 \
-    crate://crates.io/crossbeam-deque/0.8.1 \
-    crate://crates.io/crossbeam-epoch/0.9.5 \
-    crate://crates.io/crossbeam-utils/0.8.5 \
-    crate://crates.io/csv/1.1.6 \
-    crate://crates.io/csv-core/0.1.10 \
-    crate://crates.io/either/1.6.1 \
-    crate://crates.io/getrandom/0.2.3 \
-    crate://crates.io/half/1.7.1 \
-    crate://crates.io/hermit-abi/0.1.19 \
-    crate://crates.io/itertools/0.10.1 \
-    crate://crates.io/itoa/0.4.7 \
-    crate://crates.io/js-sys/0.3.52 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.99 \
-    crate://crates.io/log/0.4.14 \
-    crate://crates.io/memchr/2.4.0 \
-    crate://crates.io/memoffset/0.6.4 \
-    crate://crates.io/num-traits/0.2.14 \
-    crate://crates.io/num_cpus/1.13.0 \
-    crate://crates.io/oorandom/11.1.3 \
-    crate://crates.io/phf_shared/0.10.0 \
-    crate://crates.io/plotters/0.3.1 \
-    crate://crates.io/plotters-backend/0.3.2 \
-    crate://crates.io/plotters-svg/0.3.1 \
-    crate://crates.io/ppv-lite86/0.2.10 \
-    crate://crates.io/proc-macro2/1.0.28 \
-    crate://crates.io/quote/1.0.9 \
-    crate://crates.io/rand/0.8.4 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/rand_hc/0.3.1 \
-    crate://crates.io/rayon/1.5.1 \
-    crate://crates.io/rayon-core/1.9.1 \
-    crate://crates.io/regex/1.5.4 \
-    crate://crates.io/regex-automata/0.1.10 \
-    crate://crates.io/regex-syntax/0.6.25 \
-    crate://crates.io/rustc_version/0.4.0 \
-    crate://crates.io/ryu/1.0.5 \
-    crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/scopeguard/1.1.0 \
-    crate://crates.io/semver/1.0.4 \
-    crate://crates.io/serde/1.0.127 \
-    crate://crates.io/serde_cbor/0.11.1 \
-    crate://crates.io/serde_derive/1.0.127 \
-    crate://crates.io/serde_json/1.0.66 \
-    crate://crates.io/siphasher/0.3.6 \
-    crate://crates.io/syn/1.0.74 \
-    crate://crates.io/textwrap/0.11.0 \
-    crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/unicode-width/0.1.8 \
-    crate://crates.io/unicode-xid/0.2.2 \
-    crate://crates.io/walkdir/2.3.2 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.75 \
-    crate://crates.io/wasm-bindgen-backend/0.2.75 \
-    crate://crates.io/wasm-bindgen-macro/0.2.75 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
-    crate://crates.io/wasm-bindgen-shared/0.2.75 \
-    crate://crates.io/web-sys/0.3.52 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-"
 
 SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
 SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
@@ -1048,103 +994,120 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/alloc-stdlib/Cargo.lock
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
 # from rust/vendor/x509-parser/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/asn1-rs/0.5.2 \
-    crate://crates.io/asn1-rs-derive/0.4.0 \
-    crate://crates.io/asn1-rs-impl/0.1.0 \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/bumpalo/3.12.0 \
-    crate://crates.io/cc/1.0.79 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/data-encoding/2.3.3 \
-    crate://crates.io/der-parser/8.2.0 \
-    crate://crates.io/displaydoc/0.2.3 \
-    crate://crates.io/itoa/1.0.6 \
-    crate://crates.io/js-sys/0.3.61 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.140 \
-    crate://crates.io/log/0.4.17 \
-    crate://crates.io/memchr/2.5.0 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/nom/7.1.3 \
-    crate://crates.io/num-bigint/0.4.3 \
-    crate://crates.io/num-integer/0.1.45 \
-    crate://crates.io/num-traits/0.2.15 \
-    crate://crates.io/oid-registry/0.6.1 \
-    crate://crates.io/once_cell/1.17.1 \
-    crate://crates.io/proc-macro2/1.0.52 \
-    crate://crates.io/quote/1.0.26 \
-    crate://crates.io/ring/0.16.20 \
-    crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/serde/1.0.156 \
-    crate://crates.io/spin/0.5.2 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/synstructure/0.12.6 \
-    crate://crates.io/thiserror/1.0.39 \
-    crate://crates.io/thiserror-impl/1.0.39 \
-    crate://crates.io/time/0.3.20 \
-    crate://crates.io/time-core/0.1.0 \
-    crate://crates.io/time-macros/0.2.8 \
-    crate://crates.io/unicode-ident/1.0.8 \
-    crate://crates.io/unicode-xid/0.2.4 \
-    crate://crates.io/untrusted/0.7.1 \
-    crate://crates.io/wasm-bindgen/0.2.84 \
-    crate://crates.io/wasm-bindgen-backend/0.2.84 \
-    crate://crates.io/wasm-bindgen-macro/0.2.84 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.84 \
-    crate://crates.io/wasm-bindgen-shared/0.2.84 \
-    crate://crates.io/web-sys/0.3.61 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-"
 
 SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
 SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
 SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
 SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[bumpalo-3.12.0.sha256sum] = "0d261e256854913907f67ed06efbc3338dfe6179796deefc1ff763fc1aee5535"
-SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
+SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
+SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[data-encoding-2.3.3.sha256sum] = "23d8666cb01533c39dde32bcbab8e227b4ed6679b2c925eba05feabea39508fb"
+SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
 SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
-SRC_URI[displaydoc-0.2.3.sha256sum] = "3bf95dc3f046b9da4f2d51833c0d3547d8564ef6910f5c1ed130306a75b92886"
-SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
-SRC_URI[js-sys-0.3.61.sha256sum] = "445dde2150c55e483f3d8416706b97ec8e8237c307e5b7b4b8dd15e6af2a0730"
+SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
+SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
+SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
+SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.140.sha256sum] = "99227334921fae1a979cf0bfdfcc6b3e5ce376ef57e16fb6fb3ea2ed6095f80c"
-SRC_URI[log-0.4.17.sha256sum] = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e"
+SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
+SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
 SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
 SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
 SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
-SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
+SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
 SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
-SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
-SRC_URI[proc-macro2-1.0.52.sha256sum] = "1d0e1ae9e836cc3beddd63db0df682593d7e2d3d891ae8c9083d2113e1744224"
-SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
+SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
+SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
+SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
 SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
 SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[serde-1.0.156.sha256sum] = "314b5b092c0ade17c00142951e50ced110ec27cea304b1037c6969246c2469a4"
+SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
 SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
 SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
-SRC_URI[thiserror-1.0.39.sha256sum] = "a5ab016db510546d856297882807df8da66a16fb8c4101cb8b30054b0d5b2d9c"
-SRC_URI[thiserror-impl-1.0.39.sha256sum] = "5420d42e90af0c38c3290abcca25b9b3bdf379fc9f55c528f53a269d9c9a267e"
-SRC_URI[time-0.3.20.sha256sum] = "cd0cbfecb4d19b5ea75bb31ad904eb5b9fa13f21079c3b92017ebdf4999a5890"
-SRC_URI[time-core-0.1.0.sha256sum] = "2e153e1f1acaef8acc537e68b44906d2db6436e2b35ac2c6b42640fff91f00fd"
-SRC_URI[time-macros-0.2.8.sha256sum] = "fd80a657e71da814b8e5d60d3374fc6d35045062245d80224748ae522dd76f36"
-SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
+SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
+SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
+SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
+SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
+SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
+SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
 SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
 SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
-SRC_URI[wasm-bindgen-0.2.84.sha256sum] = "31f8dcbc21f30d9b8f2ea926ecb58f6b91192c17e9d33594b3df58b2007ca53b"
-SRC_URI[wasm-bindgen-backend-0.2.84.sha256sum] = "95ce90fd5bcc06af55a641a86428ee4229e44e07033963a2290a8e241607ccb9"
-SRC_URI[wasm-bindgen-macro-0.2.84.sha256sum] = "4c21f77c0bedc37fd5dc21f897894a5ca01e7bb159884559461862ae90c0b4c5"
-SRC_URI[wasm-bindgen-macro-support-0.2.84.sha256sum] = "2aff81306fcac3c7515ad4e177f521b5c9a15f2b08f4e32d823066102f35a5f6"
-SRC_URI[wasm-bindgen-shared-0.2.84.sha256sum] = "0046fef7e28c3804e5e38bfa31ea2a0f73905319b677e57ebe37e49358989b5d"
-SRC_URI[web-sys-0.3.61.sha256sum] = "e33b99f4b23ba3eec1a53ac264e35a755f00e966e0065077d6027c0f575b0b97"
+SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
+SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
+SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
+SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
+SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
+SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/regex/Cargo.lock
+
+SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
+SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
+SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
+SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
+# from rust/vendor/bendy/Cargo.lock
+
+SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
+SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
+SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
+SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
+SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
+SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
+SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
+SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
+SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
+SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
+SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
+SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
+SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
+SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
+SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
+SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
+SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
+SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
+SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
+SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
+SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
+SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
+# from rust/vendor/flate2/Cargo.lock
+
+SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
+SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
+SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
+SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
+SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
+SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
+SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
+SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
+SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
+SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.12.bb
similarity index 86%
rename from recipes-ids/suricata/suricata_7.0.0.bb
rename to recipes-ids/suricata/suricata_7.0.12.bb
index 62baa35..ff022e0 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.12.bb
@@ -5,7 +5,7 @@ require suricata.inc
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
 SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
-SRC_URI[sha256sum] = "7bcd1313118366451465dc3f8385a3f6aadd084ffe44dd257dda8105863bb769"
+SRC_URI[sha256sum] = "da5a591c749fed2bd986fc3b3cac25d9cfd3b453f57becf14610746999d3c5dd"
 
 DEPENDS = "lz4 libhtp"
 
@@ -15,29 +15,7 @@ SRC_URI += " \
     file://suricata.yaml \
     file://suricata.service \
     file://run-ptest \
-    file://fixup.patch \
-    file://CVE-2024-45795.patch \
-    file://CVE-2024-45796.patch \
-    file://CVE-2024-55605.patch \
-    file://CVE-2025-29916-01.patch \
-    file://CVE-2025-29916-02.patch \
-    file://CVE-2025-29916-03.patch \
-    file://CVE-2025-29917.patch \
-    file://CVE-2025-29918.patch \
-    file://CVE-2024-32663-001.patch \
-    file://CVE-2024-32663-002.patch \
-    file://CVE-2024-32664.patch \
-    file://CVE-2024-32867-001.patch \
-    file://CVE-2024-32867-002.patch \
-    file://CVE-2024-32867-003.patch \
-    file://CVE-2024-32867-004.patch \
-    file://CVE-2024-55627-001.patch \
-    file://CVE-2024-55627-002.patch \
-    file://CVE-2024-55627-003.patch \
-    file://CVE-2024-55628-001.patch \
-    file://CVE-2024-55628-002.patch \
-    file://CVE-2024-55628-003.patch \
-    file://CVE-2024-55628-004.patch \
+    file://0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.47.3


