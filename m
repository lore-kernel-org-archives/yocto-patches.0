Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EBC54E65
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 00:54:22 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web11.615.1747788852998471570
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 May 2025 17:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LTvp28pT;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc6945e109so25586915ab.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747788852; x=1748393652; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWx3fjnst2oRRGfAGMNmaGLPnbayTqQDekSlDsUs3Wg=;
        b=LTvp28pTLWvbBP+enlbGwJ58+QT9vBnDrx/2MPFcQXAutD55/DTiC8OOgZ4NNy/ggR
         pLIEdVMcjetEEVLyeBsGqKSd+MFuMyNFcMBSYBMuZ+9osUC6HViVa+qlYPJXqdYFxtoa
         zcIOXgoMC3iIT3uDCQSBs7FpF1rr18wRuz+kFAAveYWCL79crVBaWdsldSMqVAZxW7Hg
         2PKEo87H4EA2TYgX757RgR2j3xwMZk15MGoENrT0M7E+vm6UuB7f0zVUFqfgQVdq0abm
         qnmsejcptkKv9bm1dBlfxXkEmOSI4FAyY2wkqhXG6ExZyK5wG+k3AiGy67n/toFc+UIb
         Yl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747788852; x=1748393652;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GWx3fjnst2oRRGfAGMNmaGLPnbayTqQDekSlDsUs3Wg=;
        b=cY7XKbzMhpMzPHcyjW1vzZ3nAD35zT/o5a1NdA6C5b731YkTel8yusI0lCxCIhNMc4
         x0RsBq2PzI5xAwB0TzNL7AWEQqYkkESP5PccPg1Z9uaCtzp/+m81RMWM/muDE+kOUafk
         wLhP0mmwoNV5P5tdSfrJA12lYJbX5W0qLZbNiYvAYnt2v18/XOQRhHTZFDMl9FP5xT8K
         2t8HmdA7GbJGDr5EMYHRGr6wgZSuoD88uY5X86TUDtN+TUEnYPg5q1OtMato6CGx8u5f
         3dXyJL5p4ou+QfyIxxbV8J5pHtes8wPFIa4h31yejXV+dEVwcibSPEQLQZPZ6qxQKKEE
         4vgA==
X-Forwarded-Encrypted: i=1; AJvYcCXNIqBJBn0sWyKOzoCNm9EGAGXkgFUs72XrzRSazu/X3k1X7KCndPwOwwQlkd8RLC8h5t7hO9H5Q3VE3TcW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyMuSgBgSN69436MUr7ZbaPQXS/i0tNpEL7yptxqiQrQNIa59ci
	7br+fkSL955upL1P6s5E6makwvHLTWRAn715ycKmRZZeBJlmhrawJXQ4
X-Gm-Gg: ASbGnctoYAeYj9wJQYyLjbWXWiomfTlBLz8PE65GepZ5r8eoepXjdejrkil3PdjxG6d
	Yg4lPvWqrep75yAu2WhYExp7CjHEu3AOIkogfH6gnNfvtotfZl1wq6F4ZeqyKNNkmGaW3LXEdrA
	vTcOg7/bA2Jutc8dCyF1Ca+ExymOT4NCeIGzyE2EXVAItkoV7l6UNg10g7+hHxGBhEtMtAvSv1q
	JC84m6Hs6T6Cx1ZVq1alPv7Hw8mOkMcJ8HlieQcCms+xCLpOPuAzaa7VP/Wy8Ejbj0g3pWwiRo7
	m+g6EvmIq/XkIU5RgPzsyB7PrZkH3mbWNhdWdyHGRFThKsDlm8RQ4yqXelWtXFb4S/Jg+st1HNS
	RONtHxD2/SNZevwYrmRHCmuqEUzAP
X-Google-Smtp-Source: AGHT+IEFGdcRDj7xkJrDHgdwMVrbzbgxX2swS9nnhBndD8rIfVBPuUfsz41x0/hK/mYYY4JtlxcjyA==
X-Received: by 2002:a05:6e02:3cc7:b0:3d9:6cd9:5079 with SMTP id e9e14a558f8ab-3db8432391dmr176635915ab.14.1747788851791;
        Tue, 20 May 2025 17:54:11 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3df0b7sm2412240173.61.2025.05.20.17.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 17:54:11 -0700 (PDT)
Message-ID: <88d7b8ad-5154-493c-ae36-66d0f2cbe2b3@gmail.com>
Date: Tue, 20 May 2025 18:54:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
Cc: sdoshi@mvista.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: update to 7.0.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 May 2025 00:54:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1572

7.0.3:
CVE-2024-23835
CVE-2024-23836
CVE-2024-24568

7.0.4:
CVE-2024-28870

7.0.5:
CVE-2024-32663
CVE-2024-32664
CVE-2024-32867

7.0.6:
CVE-2024-37151
CVE-2024-38534
CVE-2024-38535
CVE-2024-38536

7.0.7:
CVE-2024-47187
CVE-2024-47188
CVE-2024-47522
CVE-2024-45795
CVE-2024-45796
CVE-2024-45797

7.0.8:
CVE-2024-55605
CVE-2024-55626
CVE-2024-55627
CVE-2024-55628
CVE-2024-55629

7.0.9:
CVE-2025-29915
CVE-2025-29916
CVE-2025-29917
CVE-2025-29918

7.0.10:
"This is an extra release to address a critical issue in 7.0.9 affecting
AF_PACKET users: setting a BPF would cause Suricata to fail to start up"

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

I wasn't able to use update_crates, so that piece was completed manually

 .../suricata/files/CVE-2024-37151.patch       |  53 ----
 .../suricata/files/CVE-2024-38534.patch       |  44 ---
 .../suricata/files/CVE-2024-38535.patch       |  57 ----
 .../suricata/files/CVE-2024-38535_pre.patch   | 292 ------------------
 .../suricata/files/CVE-2024-38536.patch       |  40 ---
 recipes-ids/suricata/files/fixup.patch        |  46 +--
 recipes-ids/suricata/suricata-crates.inc      | 100 +++---
 .../{suricata_7.0.0.bb => suricata_7.0.10.bb} |   7 +-
 8 files changed, 78 insertions(+), 561 deletions(-)
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-37151.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38534.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38535_pre.patch
 delete mode 100644 recipes-ids/suricata/files/CVE-2024-38536.patch
 rename recipes-ids/suricata/{suricata_7.0.0.bb => suricata_7.0.10.bb} (95%)

diff --git a/recipes-ids/suricata/files/CVE-2024-37151.patch b/recipes-ids/suricata/files/CVE-2024-37151.patch
deleted file mode 100644
index 7e5d8e2..0000000
--- a/recipes-ids/suricata/files/CVE-2024-37151.patch
+++ /dev/null
@@ -1,53 +0,0 @@
-From a6052dca1e27f3c8f96ec7be0fe7514c56a0d56f Mon Sep 17 00:00:00 2001
-From: Victor Julien <vjulien@oisf.net>
-Date: Tue, 4 Jun 2024 14:43:22 +0200
-Subject: [PATCH 1/4] defrag: don't use completed tracker
-
-When a Tracker is set up for a IPID, frags come in for it and it's
-reassembled and complete, the `DefragTracker::remove` flag is set. This
-is mean to tell the hash cleanup code to recyle the tracker and to let
-the lookup code skip the tracker during lookup.
-
-A logic error lead to the following scenario:
-
-1. there are sufficient frag trackers to make sure the hash table is
-   filled with trackers
-2. frags for a Packet with IPID X are processed correctly (X1)
-3. frags for a new Packet that also has IPID X come in quickly after the
-   first (X2).
-4. during the lookup, the frag for X2 hashes to a hash row that holds
-   more than one tracker
-5. as the trackers in hash row are evaluated, it finds the tracker for
-   X1, but since the `remove` bit is not checked, it is returned as the
-   tracker for X2.
-6. reassembly fails, as the tracker is already complete
-
-The logic error is that only for the first tracker in a row the `remove`
-bit was checked, leading to reuse to a closed tracker if there were more
-trackers in the hash row.
-
-Ticket: #7042.
-
-Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/aab7f35c76721df19403a7c0c0025feae12f3b6b]
-CVE: CVE-2024-37151
-Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
----
- src/defrag-hash.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/src/defrag-hash.c b/src/defrag-hash.c
-index 2f19ce2..87d40f9 100644
---- a/src/defrag-hash.c
-+++ b/src/defrag-hash.c
-@@ -591,7 +591,7 @@ DefragTracker *DefragGetTrackerFromHash (Packet *p)
-                 return dt;
-             }
- 
--            if (DefragTrackerCompare(dt, p) != 0) {
-+            if (!dt->remove && DefragTrackerCompare(dt, p) != 0) {
-                 /* we found our tracker, lets put it on top of the
-                  * hash list -- this rewards active trackers */
-                 if (dt->hnext) {
--- 
-2.44.0
-
diff --git a/recipes-ids/suricata/files/CVE-2024-38534.patch b/recipes-ids/suricata/files/CVE-2024-38534.patch
deleted file mode 100644
index 14a958c..0000000
--- a/recipes-ids/suricata/files/CVE-2024-38534.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From f1645ea911d4e90b1be8ee5863e8e1a665079cce Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Thu, 25 Apr 2024 21:24:33 +0200
-Subject: [PATCH 2/4] modbus: abort flow parsing on flood
-
-Ticket: 6987
-
-Let's not spend more resources for a flow which is trying to
-make us do it...
-
-(cherry picked from commit 37509e8e0ed097f8e0174df754835ac60584fc72)
-
-Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/a753cdbe84caee3b66d0bf49b2712d29a50d67ae]
-CVE: CVE-2024-38534
-Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
----
- rust/src/modbus/modbus.rs | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/rust/src/modbus/modbus.rs b/rust/src/modbus/modbus.rs
-index 246e9ca..d2f7c6b 100644
---- a/rust/src/modbus/modbus.rs
-+++ b/rust/src/modbus/modbus.rs
-@@ -189,7 +189,7 @@ impl ModbusState {
-                                 None => {
-                                     let mut tx = match self.new_tx() {
-                                         Some(tx) => tx,
--                                        None => return AppLayerResult::ok(),
-+                                        None => return AppLayerResult::err(),
-                                     };
-                                     tx.set_events_from_flags(&msg.error_flags);
-                                     tx.request = Some(msg);
-@@ -215,7 +215,7 @@ impl ModbusState {
-                             None => {
-                                 let mut tx = match self.new_tx() {
-                                     Some(tx) => tx,
--                                    None => return AppLayerResult::ok(),
-+                                    None => return AppLayerResult::err(),
-                                 };
-                                 if msg
-                                     .access_type
--- 
-2.44.0
-
diff --git a/recipes-ids/suricata/files/CVE-2024-38535.patch b/recipes-ids/suricata/files/CVE-2024-38535.patch
deleted file mode 100644
index 7ac72c8..0000000
--- a/recipes-ids/suricata/files/CVE-2024-38535.patch
+++ /dev/null
@@ -1,57 +0,0 @@
-From 6b00dc36d7527f051c2346f03d20f8d9e5a60138 Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Mon, 17 Jun 2024 16:30:49 +0200
-Subject: [PATCH 3/4] http2: do not expand duplicate headers
-
-Ticket: 7104
-
-As this can cause a big mamory allocation due to the quadratic
-nature of the HPACK compression.
-
-(cherry picked from commit 5bd17934df321b88f502d48afdd6cc8bad4787a7)
-
-Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/c82fa5ca0d1ce0bd8f936e0b860707a6571373b2]
-CVE: CVE-2024-38535
-Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
----
- rust/src/http2/detect.rs | 8 ++++----
- 1 file changed, 4 insertions(+), 4 deletions(-)
-
-diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
-index 99261ad..9c2f8ab 100644
---- a/rust/src/http2/detect.rs
-+++ b/rust/src/http2/detect.rs
-@@ -432,11 +432,11 @@ pub fn http2_frames_get_header_value_vec(
-                     if found == 0 {
-                         vec.extend_from_slice(&block.value);
-                         found = 1;
--                    } else if found == 1 {
-+                    } else if found == 1 && Rc::strong_count(&block.name) <= 2 {
-                         vec.extend_from_slice(&[b',', b' ']);
-                         vec.extend_from_slice(&block.value);
-                         found = 2;
--                    } else {
-+                    } else if Rc::strong_count(&block.name) <= 2 {
-                         vec.extend_from_slice(&[b',', b' ']);
-                         vec.extend_from_slice(&block.value);
-                     }
-@@ -469,14 +469,14 @@ fn http2_frames_get_header_value<'a>(
-                     if found == 0 {
-                         single = Ok(&block.value);
-                         found = 1;
--                    } else if found == 1 {
-+                    } else if found == 1 && Rc::strong_count(&block.name) <= 2 {
-                         if let Ok(s) = single {
-                             vec.extend_from_slice(s);
-                         }
-                         vec.extend_from_slice(&[b',', b' ']);
-                         vec.extend_from_slice(&block.value);
-                         found = 2;
--                    } else {
-+                    } else if Rc::strong_count(&block.name) <= 2 {
-                         vec.extend_from_slice(&[b',', b' ']);
-                         vec.extend_from_slice(&block.value);
-                     }
--- 
-2.44.0
-
diff --git a/recipes-ids/suricata/files/CVE-2024-38535_pre.patch b/recipes-ids/suricata/files/CVE-2024-38535_pre.patch
deleted file mode 100644
index 2aa42c4..0000000
--- a/recipes-ids/suricata/files/CVE-2024-38535_pre.patch
+++ /dev/null
@@ -1,292 +0,0 @@
-From 390f09692eb99809c679d3f350c7cc185d163e1a Mon Sep 17 00:00:00 2001
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
-Note: This patch is needed to patch CVE-2024-38535 as  it defines Rc.
-Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/390f09692eb99809c679d3f350c7cc185d163e1a]
-Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
----
- rust/src/http2/detect.rs | 19 +++++++------
- rust/src/http2/http2.rs  |  2 +-
- rust/src/http2/parser.rs | 61 +++++++++++++++++++++-------------------
- 3 files changed, 43 insertions(+), 39 deletions(-)
-
-diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
-index 9c2f8ab..e068a17 100644
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
-2.44.0
-
diff --git a/recipes-ids/suricata/files/CVE-2024-38536.patch b/recipes-ids/suricata/files/CVE-2024-38536.patch
deleted file mode 100644
index 2d4b3d7..0000000
--- a/recipes-ids/suricata/files/CVE-2024-38536.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From 4026bca7f04c419dd3f3ba17a1af17bbcbcf18bc Mon Sep 17 00:00:00 2001
-From: Philippe Antoine <pantoine@oisf.net>
-Date: Fri, 17 May 2024 09:39:52 +0200
-Subject: [PATCH 4/4] http: fix nul deref on memcap reached
-
-HttpRangeOpenFileAux may return NULL in different cases, including
-when memcap is reached.
-But is only caller did not check it before calling HttpRangeAppendData
-which would dereference the NULL value.
-
-Ticket: 7029
-(cherry picked from commit fd262df457f67f2174752dd6505ba2ed5911fd96)
-
-Upstream-Status: Backport from [https://github.com/OISF/suricata/commit/2bd3bd0e318f19008e9fe068ab17277c530ffb92]
-CVE: CVE-2024-38536
-Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
----
- src/app-layer-htp-range.c | 6 ++++--
- 1 file changed, 4 insertions(+), 2 deletions(-)
-
-diff --git a/src/app-layer-htp-range.c b/src/app-layer-htp-range.c
-index 3cdde35..f0d75a9 100644
---- a/src/app-layer-htp-range.c
-+++ b/src/app-layer-htp-range.c
-@@ -351,8 +351,10 @@ static HttpRangeContainerBlock *HttpRangeOpenFile(HttpRangeContainerFile *c, uin
- {
-     HttpRangeContainerBlock *r =
-             HttpRangeOpenFileAux(c, start, end, total, sbcfg, name, name_len, flags);
--    if (HttpRangeAppendData(sbcfg, r, data, len) < 0) {
--        SCLogDebug("Failed to append data while opening");
-+    if (r) {
-+        if (HttpRangeAppendData(sbcfg, r, data, len) < 0) {
-+            SCLogDebug("Failed to append data while opening");
-+        }
-     }
-     return r;
- }
--- 
-2.44.0
-
diff --git a/recipes-ids/suricata/files/fixup.patch b/recipes-ids/suricata/files/fixup.patch
index 0b2ae7c..beb4438 100644
--- a/recipes-ids/suricata/files/fixup.patch
+++ b/recipes-ids/suricata/files/fixup.patch
@@ -1,32 +1,40 @@
-Skip pkg Makefile from using its own rust steps
+From 0aa70a43ab1c2a781b86b49a83442e94137dc2cf Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+Date: Mon, 12 May 2025 20:42:44 -0600
+Subject: [PATCH] Skip pkg Makefile from using its own rust steps
 
 Upstream-Status: Inappropriate [OE Specific]
 
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ Makefile.am | 2 +-
+ Makefile.in | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
 
-Index: suricata-7.0.0/Makefile.in
-===================================================================
---- suricata-7.0.0.orig/Makefile.in
-+++ suricata-7.0.0/Makefile.in
-@@ -424,7 +424,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
- 	     acsite.m4 \
- 	     scripts/generate-images.sh
- 
+diff --git a/Makefile.am b/Makefile.am
+index d0d3d09..a572912 100644
+--- a/Makefile.am
++++ b/Makefile.am
+@@ -10,7 +10,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
+ 	     scripts/generate-images.sh \
+ 	     scripts/docs-almalinux9-minimal-build.sh \
+ 	     scripts/docs-ubuntu-debian-minimal-build.sh
 -SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
 +SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
            $(SURICATA_UPDATE_DIR)
- 
+
  CLEANFILES = stamp-h[0-9]*
-Index: suricata-7.0.0/Makefile.am
-===================================================================
---- suricata-7.0.0.orig/Makefile.am
-+++ suricata-7.0.0/Makefile.am
-@@ -8,7 +8,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE s
- 	     lua \
- 	     acsite.m4 \
- 	     scripts/generate-images.sh
+diff --git a/Makefile.in b/Makefile.in
+index 120330a..c9d187f 100644
+--- a/Makefile.in
++++ b/Makefile.in
+@@ -427,7 +427,7 @@ EXTRA_DIST = ChangeLog COPYING LICENSE suricata.yaml.in \
+ 	     scripts/docs-almalinux9-minimal-build.sh \
+ 	     scripts/docs-ubuntu-debian-minimal-build.sh
+
 -SUBDIRS = $(HTP_DIR) rust src qa rules doc contrib etc python ebpf \
 +SUBDIRS = $(HTP_DIR) src qa rules doc contrib etc python ebpf \
            $(SURICATA_UPDATE_DIR)
- 
+
  CLEANFILES = stamp-h[0-9]*
diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
index 386d8d1..1fe9e73 100644
--- a/recipes-ids/suricata/suricata-crates.inc
+++ b/recipes-ids/suricata/suricata-crates.inc
@@ -17,13 +17,13 @@ SRC_URI += " \
     crate://crates.io/bendy/0.3.3 \
     crate://crates.io/bitflags/1.2.1 \
     crate://crates.io/block-buffer/0.10.4 \
-    crate://crates.io/brotli/3.3.4 \
-    crate://crates.io/brotli-decompressor/2.3.4 \
+    crate://crates.io/brotli/3.4.0 \
+    crate://crates.io/brotli-decompressor/2.5.1 \
     crate://crates.io/build_const/0.2.2 \
     crate://crates.io/byteorder/1.4.3 \
     crate://crates.io/cfg-if/1.0.0 \
     crate://crates.io/cipher/0.3.0 \
-    crate://crates.io/cpufeatures/0.2.9 \
+    crate://crates.io/cpufeatures/0.2.11 \
     crate://crates.io/crc/1.8.1 \
     crate://crates.io/crc32fast/1.3.2 \
     crate://crates.io/crypto-common/0.1.6 \
@@ -37,20 +37,20 @@ SRC_URI += " \
     crate://crates.io/enum_primitive/0.1.1 \
     crate://crates.io/failure/0.1.8 \
     crate://crates.io/failure_derive/0.1.8 \
-    crate://crates.io/flate2/1.0.26 \
+    crate://crates.io/flate2/1.0.28 \
     crate://crates.io/generic-array/0.14.7 \
-    crate://crates.io/getrandom/0.2.10 \
+    crate://crates.io/getrandom/0.2.11 \
     crate://crates.io/ghash/0.4.4 \
     crate://crates.io/hex/0.4.3 \
     crate://crates.io/hkdf/0.12.3 \
     crate://crates.io/hmac/0.12.1 \
     crate://crates.io/ipsec-parser/0.7.0 \
-    crate://crates.io/itoa/1.0.8 \
+    crate://crates.io/itoa/1.0.9 \
     crate://crates.io/kerberos-parser/0.7.1 \
     crate://crates.io/lazy_static/1.4.0 \
     crate://crates.io/libc/0.2.147 \
     crate://crates.io/lzma-rs/0.2.0 \
-    crate://crates.io/md-5/0.10.5 \
+    crate://crates.io/md-5/0.10.6 \
     crate://crates.io/memchr/2.4.1 \
     crate://crates.io/minimal-lexical/0.2.1 \
     crate://crates.io/miniz_oxide/0.7.1 \
@@ -60,14 +60,14 @@ SRC_URI += " \
     crate://crates.io/ntp-parser/0.6.0 \
     crate://crates.io/num/0.2.1 \
     crate://crates.io/num-bigint/0.2.6 \
-    crate://crates.io/num-bigint/0.4.3 \
+    crate://crates.io/num-bigint/0.4.4 \
     crate://crates.io/num-complex/0.2.4 \
-    crate://crates.io/num-derive/0.2.5 \
+    crate://crates.io/num-derive/0.4.2 \
     crate://crates.io/num-integer/0.1.45 \
     crate://crates.io/num-iter/0.1.43 \
     crate://crates.io/num-rational/0.2.4 \
     crate://crates.io/num-traits/0.1.43 \
-    crate://crates.io/num-traits/0.2.15 \
+    crate://crates.io/num-traits/0.2.17 \
     crate://crates.io/num_enum/0.5.11 \
     crate://crates.io/num_enum_derive/0.5.11 \
     crate://crates.io/num_threads/0.1.6 \
@@ -81,39 +81,39 @@ SRC_URI += " \
     crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/proc-macro-crate/1.1.0 \
     crate://crates.io/proc-macro2/0.4.30 \
-    crate://crates.io/proc-macro2/1.0.64 \
+    crate://crates.io/proc-macro2/1.0.69 \
     crate://crates.io/quote/0.6.13 \
-    crate://crates.io/quote/1.0.29 \
+    crate://crates.io/quote/1.0.33 \
     crate://crates.io/rand/0.8.5 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
     crate://crates.io/regex/1.5.6 \
     crate://crates.io/regex-syntax/0.6.29 \
     crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/rustversion/1.0.13 \
+    crate://crates.io/rustversion/1.0.14 \
     crate://crates.io/sawp/0.12.1 \
     crate://crates.io/sawp-flags/0.12.1 \
     crate://crates.io/sawp-flags-derive/0.12.1 \
     crate://crates.io/sawp-modbus/0.12.1 \
-    crate://crates.io/serde/1.0.171 \
-    crate://crates.io/sha1/0.10.5 \
-    crate://crates.io/sha2/0.10.7 \
-    crate://crates.io/siphasher/0.3.10 \
+    crate://crates.io/serde/1.0.192 \
+    crate://crates.io/sha1/0.10.6 \
+    crate://crates.io/sha2/0.10.8 \
+    crate://crates.io/siphasher/0.3.11 \
     crate://crates.io/snmp-parser/0.9.0 \
     crate://crates.io/subtle/2.4.1 \
     crate://crates.io/syn/0.15.44 \
     crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.25 \
+    crate://crates.io/syn/2.0.39 \
     crate://crates.io/synstructure/0.12.6 \
     crate://crates.io/test-case/1.1.0 \
-    crate://crates.io/thiserror/1.0.43 \
-    crate://crates.io/thiserror-impl/1.0.43 \
+    crate://crates.io/thiserror/1.0.50 \
+    crate://crates.io/thiserror-impl/1.0.50 \
     crate://crates.io/time/0.3.13 \
     crate://crates.io/time-macros/0.2.4 \
     crate://crates.io/tls-parser/0.11.0 \
     crate://crates.io/toml/0.5.11 \
-    crate://crates.io/typenum/1.16.0 \
-    crate://crates.io/unicode-ident/1.0.10 \
+    crate://crates.io/typenum/1.17.0 \
+    crate://crates.io/unicode-ident/1.0.12 \
     crate://crates.io/unicode-xid/0.1.0 \
     crate://crates.io/unicode-xid/0.2.4 \
     crate://crates.io/universal-hash/0.4.1 \
@@ -121,7 +121,7 @@ SRC_URI += " \
     crate://crates.io/version_check/0.9.4 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
     crate://crates.io/widestring/0.4.3 \
-    crate://crates.io/x509-parser/0.15.0 \
+    crate://crates.io/x509-parser/0.15.1 \
 "
 
 SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
@@ -139,13 +139,13 @@ SRC_URI[base64-0.13.1.sha256sum] = "9e1b586273c5702936fe7b7d6896644d8be71e6314cf
 SRC_URI[bendy-0.3.3.sha256sum] = "8133e404c8bec821e531f347dab1247bf64f60882826e7228f8ffeb33a35a658"
 SRC_URI[bitflags-1.2.1.sha256sum] = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693"
 SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
-SRC_URI[brotli-3.3.4.sha256sum] = "a1a0b1dbcc8ae29329621f8d4f0d835787c1c38bb1401979b49d13b0b305ff68"
-SRC_URI[brotli-decompressor-2.3.4.sha256sum] = "4b6561fd3f895a11e8f72af2cb7d22e08366bebc2b6b57f7744c4bda27034744"
+SRC_URI[brotli-3.4.0.sha256sum] = "516074a47ef4bce09577a3b379392300159ce5b1ba2e501ff1c819950066100f"
+SRC_URI[brotli-decompressor-2.5.1.sha256sum] = "4e2e4afe60d7dd600fdd3de8d0f08c2b7ec039712e3b6137ff98b7004e82de4f"
 SRC_URI[build_const-0.2.2.sha256sum] = "b4ae4235e6dac0694637c763029ecea1a2ec9e4e06ec2729bd21ba4d9c863eb7"
 SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
 SRC_URI[cipher-0.3.0.sha256sum] = "7ee52072ec15386f770805afd189a01c8841be8696bed250fa2f13c4c0d6dfb7"
-SRC_URI[cpufeatures-0.2.9.sha256sum] = "a17b76ff3a4162b0b27f354a0c87015ddad39d35f9c0c36607a3bdd175dde1f1"
+SRC_URI[cpufeatures-0.2.11.sha256sum] = "ce420fe07aecd3e67c5f910618fe65e94158f6dcc0adf44e00d69ce2bdfe0fd0"
 SRC_URI[crc-1.8.1.sha256sum] = "d663548de7f5cca343f1e0a48d14dcfb0e9eb4e079ec58883b7251539fa10aeb"
 SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
 SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
@@ -159,20 +159,20 @@ SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67
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
 SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
 SRC_URI[lzma-rs-0.2.0.sha256sum] = "aba8ecb0450dfabce4ad72085eed0a75dffe8f21f7ada05638564ea9db2d7fb1"
-SRC_URI[md-5-0.10.5.sha256sum] = "6365506850d44bff6e2fbcb5176cf63650e48bd45ef2fe2665ae1570e0f4b9ca"
+SRC_URI[md-5-0.10.6.sha256sum] = "d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
 SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
@@ -182,14 +182,14 @@ SRC_URI[nom-derive-impl-0.10.1.sha256sum] = "cd0b9a93a84b0d3ec3e70e02d332dc33ac6
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
@@ -203,39 +203,39 @@ SRC_URI[polyval-0.5.3.sha256sum] = "8419d2b623c7c0896ff2d5d96e2cb4ede590fed28fcc
 SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[proc-macro-crate-1.1.0.sha256sum] = "1ebace6889caf889b4d3f76becee12e90353f2b8c7d875534a71e5742f8f6f83"
 SRC_URI[proc-macro2-0.4.30.sha256sum] = "cf3d2011ab5c909338f7887f4fc896d35932e29146c12c8d01da6b22a80ba759"
-SRC_URI[proc-macro2-1.0.64.sha256sum] = "78803b62cbf1f46fde80d7c0e803111524b9877184cfe7c3033659490ac7a7da"
+SRC_URI[proc-macro2-1.0.69.sha256sum] = "134c189feb4956b20f6f547d2cf727d4c0fe06722b20a0eec87ed445a97f92da"
 SRC_URI[quote-0.6.13.sha256sum] = "6ce23b6b870e8f94f81fb0a363d65d86675884b34a09043c81e5562f11c1f8e1"
-SRC_URI[quote-1.0.29.sha256sum] = "573015e8ab27661678357f27dc26460738fd2b6c86e46f386fde94cb5d913105"
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
+SRC_URI[sha1-0.10.6.sha256sum] = "e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
+SRC_URI[sha2-0.10.8.sha256sum] = "793db75ad2bcafc3ffa7c68b215fee268f537982cd901d132f89c6343f3a3dc8"
+SRC_URI[siphasher-0.3.11.sha256sum] = "38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
 SRC_URI[snmp-parser-0.9.0.sha256sum] = "773a26ad6742636f4259e7cc32262efb31feabd56bc34f0b2f28de9801aa24b3"
 SRC_URI[subtle-2.4.1.sha256sum] = "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
 SRC_URI[syn-0.15.44.sha256sum] = "9ca4b3b69a77cbe1ffc9e198781b7acb0c7365a883670e8f1c1bc66fba79a5c5"
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
+SRC_URI[typenum-1.17.0.sha256sum] = "42ff0bf0c66b8238c6f3b578df37d0b7848e55df8577b3f74f92a69acceeb825"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 SRC_URI[unicode-xid-0.1.0.sha256sum] = "fc72304796d0818e357ead4e000d19c9c174ab23dc11093ac919054d20a6a7fc"
 SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
 SRC_URI[universal-hash-0.4.1.sha256sum] = "9f214e8f697e925001e66ec2c6e37a4ef93f0f78c2eed7814394e10c62025b05"
@@ -243,7 +243,7 @@ SRC_URI[uuid-0.8.2.sha256sum] = "bc5cf98d8186244414c848017f0e2676b3fcb46807f6668
 SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
 SRC_URI[widestring-0.4.3.sha256sum] = "c168940144dd21fd8046987c16a46a33d5fc84eec29ef9dcddc2ac9e31526b7c"
-SRC_URI[x509-parser-0.15.0.sha256sum] = "bab0c2f54ae1d92f4fcb99c0b7ccf0b1e3451cbd395e5f115ccbdbcb18d4f634"
+SRC_URI[x509-parser-0.15.1.sha256sum] = "7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
 # from rust/vendor/base64/Cargo.lock
 SRC_URI += " \
     crate://crates.io/ansi_term/0.12.1 \
@@ -443,7 +443,7 @@ SRC_URI += " \
     crate://crates.io/rustversion/1.0.12 \
     crate://crates.io/ryu/1.0.13 \
     crate://crates.io/serde/1.0.160 \
-    crate://crates.io/serde_derive/1.0.160 \
+    crate://crates.io/serde_derive/1.0.192 \
     crate://crates.io/serde_json/1.0.96 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/syn/1.0.109 \
@@ -474,7 +474,7 @@ SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722
 SRC_URI[rustversion-1.0.12.sha256sum] = "4f3208ce4d8448b3f3e7d168a73f5e0c43a61e32930de3bceeccedb388b6bf06"
 SRC_URI[ryu-1.0.13.sha256sum] = "f91339c0467de62360649f8d3e185ca8de4224ff281f66000de5eb2a77a79041"
 SRC_URI[serde-1.0.160.sha256sum] = "bb2f3770c8bce3bcda7e149193a069a0f4365bda1fa5cd88e03bca26afc1216c"
-SRC_URI[serde_derive-1.0.160.sha256sum] = "291a097c63d8497e00160b166a967a4a79c64f3facdd01cbd7502231688d77df"
+SRC_URI[serde_derive-1.0.192.sha256sum] = "d6c7207fbec9faa48073f3e3074cbe553af6ea512d7c21ba46e434e70ea9fbc1"
 SRC_URI[serde_json-1.0.96.sha256sum] = "057d394a50403bcac12672b2b18fb387ab6d289d957dab67dd201875391e52f1"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
@@ -605,7 +605,7 @@ SRC_URI += " \
     crate://crates.io/cmake/0.1.48 \
     crate://crates.io/crc32fast/1.3.2 \
     crate://crates.io/getrandom/0.2.6 \
-    crate://crates.io/libc/0.2.124 \
+    crate://crates.io/libc/0.2.150 \
     crate://crates.io/libz-ng-sys/1.1.8 \
     crate://crates.io/libz-sys/1.1.8 \
     crate://crates.io/miniz_oxide/0.7.1 \
@@ -626,7 +626,7 @@ SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a780
 SRC_URI[cmake-0.1.48.sha256sum] = "e8ad8cef104ac57b68b89df3208164d228503abbdce70f6880ffa3d970e7443a"
 SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
 SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
-SRC_URI[libc-0.2.124.sha256sum] = "21a41fed9d98f27ab1c6d161da622a4fa35e8a54a8adc24bbf3ddd0ef70b0e50"
+SRC_URI[libc-0.2.150.sha256sum] = "89d92a4743f9a61002fae18374ed11e7973f530cb3a3255fb354818118b2203c"
 SRC_URI[libz-ng-sys-1.1.8.sha256sum] = "4399ae96a9966bf581e726de86969f803a81b7ce795fcd5480e640589457e0f2"
 SRC_URI[libz-sys-1.1.8.sha256sum] = "9702761c3935f8cc2f101793272e202c72b99da8f4224a19ddcf1279a6450bbf"
 SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.10.bb
similarity index 95%
rename from recipes-ids/suricata/suricata_7.0.0.bb
rename to recipes-ids/suricata/suricata_7.0.10.bb
index 910e21e..453ddc0 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.10.bb
@@ -5,7 +5,7 @@ require suricata.inc
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
 SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
-SRC_URI[sha256sum] = "7bcd1313118366451465dc3f8385a3f6aadd084ffe44dd257dda8105863bb769"
+SRC_URI[sha256sum] = "197f925ea701bdcb4a15aca024b06546b002674cd958b58958f29a5bb214d759"
 
 DEPENDS = "lz4 libhtp"
 
@@ -16,11 +16,6 @@ SRC_URI += " \
     file://suricata.service \
     file://run-ptest \
     file://fixup.patch \
-    file://CVE-2024-37151.patch \
-    file://CVE-2024-38534.patch \
-    file://CVE-2024-38535_pre.patch \
-    file://CVE-2024-38535.patch \
-    file://CVE-2024-38536.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates

