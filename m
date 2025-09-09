Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26613CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 07:24:42 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.6727.1757402676606389775
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 00:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=EpoXDusY;
 spf=pass (domain: mvista.com, ip: 209.85.214.182, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c786130feso46173145ad.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1757402676; x=1758007476; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zFfi8XO7vWjf/bAW58P+nJZHvCO5WdM2L+pt8Qvn0U=;
        b=EpoXDusY4iQFHIJ0jfA6c+1sGZR/VEd1S8j/OoKRwevokS1+yoKWSWjujQs0O7H1N1
         YlbtkId4guXJq0FBhSHjsw6CY6bKugMIRmpAaB5MvC59+z5Rf0wYAzq2On6IKQT+X+QX
         mHjg+K/W6HCrcQ6A3U18Bu40TC4gsurGnLEd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402676; x=1758007476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zFfi8XO7vWjf/bAW58P+nJZHvCO5WdM2L+pt8Qvn0U=;
        b=XovZKrub2g75TCmyRE2LrH4Cw62CO5BSwPv/6dijfoHDhYazURnOdNs2xGU/ur0ScR
         AUq8wPTgv9tXlZx87XTZ7JYLqtah97XxHkricdmh+R1ejraHWuBLGWe9xYrJTnfwKd1t
         Uz7OYi1X7sIKg1EropZqDIEdZGxacIFEPjLAoDXNULpdQQG1FRPr6+GWQs95R1/qyaqy
         DMDLRGDgV6trJCls47kaDYs4n6onW5P02r5pCCMVIw3GoR+njTYCvK8s3hIEzkJiXRRi
         9eoBj4aHu1hOx8WhstiV3LgDi6v4rpKQ9Wa5WHFxl0UV72SPe2XSaSMSxRG1UqAQa7GL
         g8Iw==
X-Gm-Message-State: AOJu0YzKTIevO93SM68X0elzuigvr42SM7pGsm9bkiQy1hnp+sd8dDDx
	sII8MVMwlObZSfb+cW0DOfBR4x8Mfoc+9svNZgXZUa80UhLH1oY/T9q8MGmXDNKC4dhPf0/PFH2
	ac12F
X-Gm-Gg: ASbGncsBE+xB/xaBKLlGtf6OJLGeSgz32NjyYdxJ6s0kMwfsRcPXxBu+FQXr1HF0+a1
	EWRV1k3yOzVYyNgVnzxz2xYjLGjhn7yKtjrYQr7ByMk9QPDbhclGEIdlKG9nDHdIiVEbWrJAjfR
	FcoZ6aSxTFEdCrQTlkBbuBXv26cDvVyGnWE48j3n8BOdf7QzMvX6mQGBX0uxKJoJmXokox5mNEe
	tAGT4tZ2etW73aE+By/idil0gktI9HsqRL/L2+4z7lMG4vE9kaTAexwoxNL9+mYfxm19r7Wj/Yk
	GbNLL4I+grOcbyzSN0brI98gj9EckM8/c5MRtwQyjReeQWS0aof5WL7nfbcYYO0uaTjln177cTm
	+pUXJHXMJ/1OFxss3h/wi514+x9O6ICOJKjlH
X-Google-Smtp-Source: AGHT+IHRvwnFmZfBxI7lui17HBLYOeb/Db+xvKr7d4Ersui+P/AL+JIE9UjX5qVrk9kpishsc/8C0w==
X-Received: by 2002:a17:903:19ce:b0:249:147:95bb with SMTP id d9443c01a7336-2516dfcd7ddmr123977225ad.13.1757402674499;
        Tue, 09 Sep 2025 00:24:34 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm132120195ad.63.2025.09.09.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:24:33 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	scott.murray@konsulko.com,
	rybczynska@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: Fix multiple CVEs
Date: Tue,  9 Sep 2025 12:54:13 +0530
Message-ID: <20250909072413.83062-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 07:24:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2149

Backport fixes for:

* CVE-2024-32663 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/e68ec4b227d19498f364a41eb25d3182f0383ca5 && https://github.com/OISF/suricata/commit/c0af92295e833d1db29b184d63cd3b829451d7fd
* CVE-2024-32664 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/d5ffecf11ad2c6fe89265e518f5d7443caf26ba4
* CVE-2024-32867 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/2f39ba75f153ba9bdf8eedc2a839cc973dbaea66 && https://github.com/OISF/suricata/commit/7137d5e7ab5500f1b7f3391f8ab55a59f1e4cbd7 && https://github.com/OISF/suricata/commit/1e110d0a71db46571040b937e17a4bc9f91d6de9 && https://github.com/OISF/suricata/commit/e6267758ed5da27f804f0c1c07f9423bdf4d72b8

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2024-32663-001.patch   | 294 +++++++++
 .../suricata/files/CVE-2024-32663-002.patch   |  70 +++
 .../suricata/files/CVE-2024-32664.patch       |  53 ++
 .../suricata/files/CVE-2024-32867-001.patch   | 235 +++++++
 .../suricata/files/CVE-2024-32867-002.patch   | 591 ++++++++++++++++++
 .../suricata/files/CVE-2024-32867-003.patch   | 472 ++++++++++++++
 .../suricata/files/CVE-2024-32867-004.patch   | 169 +++++
 recipes-ids/suricata/suricata_7.0.0.bb        |   7 +
 8 files changed, 1891 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32663-001.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32663-002.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32664.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32867-001.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32867-002.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32867-003.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2024-32867-004.patch

diff --git a/recipes-ids/suricata/files/CVE-2024-32663-001.patch b/recipes-ids/suricata/files/CVE-2024-32663-001.patch
new file mode 100644
index 0000000..f07904a
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32663-001.patch
@@ -0,0 +1,294 @@
+From e68ec4b227d19498f364a41eb25d3182f0383ca5 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Wed, 27 Mar 2024 14:33:54 +0100
+Subject: [PATCH] http2: use a reference counter for headers
+
+Ticket: 6892
+
+As HTTP hpack header compression allows one single byte to
+express a previously seen arbitrary-size header block (name+value)
+we should avoid to copy the vectors data, but just point
+to the same data, while reamining memory safe, even in the case
+of later headers eviction from the dybnamic table.
+
+Rust std solution is Rc, and the use of clone, so long as the
+data is accessed by only one thread.
+
+(cherry picked from commit 390f09692eb99809c679d3f350c7cc185d163e1a)
+
+CVE: CVE-2024-32663
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e68ec4b227d19498f364a41eb25d3182f0383ca5]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ rust/src/http2/detect.rs | 19 +++++++------
+ rust/src/http2/http2.rs  |  2 +-
+ rust/src/http2/parser.rs | 61 +++++++++++++++++++++-------------------
+ 3 files changed, 43 insertions(+), 39 deletions(-)
+
+diff --git a/rust/src/http2/detect.rs b/rust/src/http2/detect.rs
+index 99261ad..904b9ad 100644
+--- a/rust/src/http2/detect.rs
++++ b/rust/src/http2/detect.rs
+@@ -23,6 +23,7 @@ use crate::core::Direction;
+ use crate::detect::uint::{detect_match_uint, DetectUintData};
+ use std::ffi::CStr;
+ use std::str::FromStr;
++use std::rc::Rc;
+ 
+ fn http2_tx_has_frametype(
+     tx: &mut HTTP2Transaction, direction: Direction, value: u8,
+@@ -404,7 +405,7 @@ fn http2_frames_get_header_firstvalue<'a>(
+     for frame in frames {
+         if let Some(blocks) = http2_header_blocks(frame) {
+             for block in blocks.iter() {
+-                if block.name == name.as_bytes() {
++                if block.name.as_ref() == name.as_bytes() {
+                     return Ok(&block.value);
+                 }
+             }
+@@ -428,7 +429,7 @@ pub fn http2_frames_get_header_value_vec(
+     for frame in frames {
+         if let Some(blocks) = http2_header_blocks(frame) {
+             for block in blocks.iter() {
+-                if block.name == name.as_bytes() {
++                if block.name.as_ref() == name.as_bytes() {
+                     if found == 0 {
+                         vec.extend_from_slice(&block.value);
+                         found = 1;
+@@ -465,7 +466,7 @@ fn http2_frames_get_header_value<'a>(
+     for frame in frames {
+         if let Some(blocks) = http2_header_blocks(frame) {
+             for block in blocks.iter() {
+-                if block.name == name.as_bytes() {
++                if block.name.as_ref() == name.as_bytes() {
+                     if found == 0 {
+                         single = Ok(&block.value);
+                         found = 1;
+@@ -905,8 +906,8 @@ fn http2_tx_set_header(state: &mut HTTP2State, name: &[u8], input: &[u8]) {
+     };
+     let mut blocks = Vec::new();
+     let b = parser::HTTP2FrameHeaderBlock {
+-        name: name.to_vec(),
+-        value: input.to_vec(),
++        name: Rc::new(name.to_vec()),
++        value: Rc::new(input.to_vec()),
+         error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
+         sizeupdate: 0,
+     };
+@@ -1061,15 +1062,15 @@ mod tests {
+         };
+         let mut blocks = Vec::new();
+         let b = parser::HTTP2FrameHeaderBlock {
+-            name: "Host".as_bytes().to_vec(),
+-            value: "abc.com".as_bytes().to_vec(),
++            name: "Host".as_bytes().to_vec().into(),
++            value: "abc.com".as_bytes().to_vec().into(),
+             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
+             sizeupdate: 0,
+         };
+         blocks.push(b);
+         let b2 = parser::HTTP2FrameHeaderBlock {
+-            name: "Host".as_bytes().to_vec(),
+-            value: "efg.net".as_bytes().to_vec(),
++            name: "Host".as_bytes().to_vec().into(),
++            value: "efg.net".as_bytes().to_vec().into(),
+             error: parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
+             sizeupdate: 0,
+         };
+diff --git a/rust/src/http2/http2.rs b/rust/src/http2/http2.rs
+index 326030f..d14ca06 100644
+--- a/rust/src/http2/http2.rs
++++ b/rust/src/http2/http2.rs
+@@ -204,7 +204,7 @@ impl HTTP2Transaction {
+ 
+     fn handle_headers(&mut self, blocks: &[parser::HTTP2FrameHeaderBlock], dir: Direction) {
+         for block in blocks {
+-            if block.name == b"content-encoding" {
++            if block.name.as_ref() == b"content-encoding" {
+                 self.decoder.http2_encoding_fromvec(&block.value, dir);
+             }
+         }
+diff --git a/rust/src/http2/parser.rs b/rust/src/http2/parser.rs
+index adabeb2..1a46437 100644
+--- a/rust/src/http2/parser.rs
++++ b/rust/src/http2/parser.rs
+@@ -30,6 +30,7 @@ use nom7::sequence::tuple;
+ use nom7::{Err, IResult};
+ use std::fmt;
+ use std::str::FromStr;
++use std::rc::Rc;
+ 
+ #[repr(u8)]
+ #[derive(Clone, Copy, PartialEq, Eq, FromPrimitive, Debug)]
+@@ -295,8 +296,8 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
+     };
+     if !name.is_empty() {
+         return Some(HTTP2FrameHeaderBlock {
+-            name: name.as_bytes().to_vec(),
+-            value: value.as_bytes().to_vec(),
++            name: Rc::new(name.as_bytes().to_vec()),
++            value: Rc::new(value.as_bytes().to_vec()),
+             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
+             sizeupdate: 0,
+         });
+@@ -304,23 +305,23 @@ fn http2_frame_header_static(n: u64, dyn_headers: &HTTP2DynTable) -> Option<HTTP
+         //use dynamic table
+         if n == 0 {
+             return Some(HTTP2FrameHeaderBlock {
+-                name: Vec::new(),
+-                value: Vec::new(),
++                name: Rc::new(Vec::new()),
++                value: Rc::new(Vec::new()),
+                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIndex0,
+                 sizeupdate: 0,
+             });
+         } else if dyn_headers.table.len() + HTTP2_STATIC_HEADERS_NUMBER < n as usize {
+             return Some(HTTP2FrameHeaderBlock {
+-                name: Vec::new(),
+-                value: Vec::new(),
++                name: Rc::new(Vec::new()),
++                value: Rc::new(Vec::new()),
+                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
+                 sizeupdate: 0,
+             });
+         } else {
+             let indyn = dyn_headers.table.len() - (n as usize - HTTP2_STATIC_HEADERS_NUMBER);
+             let headcopy = HTTP2FrameHeaderBlock {
+-                name: dyn_headers.table[indyn].name.to_vec(),
+-                value: dyn_headers.table[indyn].value.to_vec(),
++                name: dyn_headers.table[indyn].name.clone(),
++                value: dyn_headers.table[indyn].value.clone(),
+                 error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess,
+                 sizeupdate: 0,
+             };
+@@ -348,8 +349,10 @@ impl fmt::Display for HTTP2HeaderDecodeStatus {
+ 
+ #[derive(Clone, Debug)]
+ pub struct HTTP2FrameHeaderBlock {
+-    pub name: Vec<u8>,
+-    pub value: Vec<u8>,
++    // Use Rc reference counted so that indexed headers do not get copied.
++    // Otherwise, this leads to quadratic complexity in memory occupation.
++    pub name: Rc<Vec<u8>>,
++    pub value: Rc<Vec<u8>>,
+     pub error: HTTP2HeaderDecodeStatus,
+     pub sizeupdate: u64,
+ }
+@@ -391,7 +394,7 @@ fn http2_parse_headers_block_literal_common<'a>(
+ ) -> IResult<&'a [u8], HTTP2FrameHeaderBlock> {
+     let (i3, name, error) = if index == 0 {
+         match http2_parse_headers_block_string(input) {
+-            Ok((r, n)) => Ok((r, n, HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
++            Ok((r, n)) => Ok((r, Rc::new(n), HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess)),
+             Err(e) => Err(e),
+         }
+     } else {
+@@ -403,7 +406,7 @@ fn http2_parse_headers_block_literal_common<'a>(
+             )),
+             None => Ok((
+                 input,
+-                Vec::new(),
++                Rc::new(Vec::new()),
+                 HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeNotIndexed,
+             )),
+         }
+@@ -413,7 +416,7 @@ fn http2_parse_headers_block_literal_common<'a>(
+         i4,
+         HTTP2FrameHeaderBlock {
+             name,
+-            value,
++            value: Rc::new(value),
+             error,
+             sizeupdate: 0,
+         },
+@@ -435,8 +438,8 @@ fn http2_parse_headers_block_literal_incindex<'a>(
+     match r {
+         Ok((r, head)) => {
+             let headcopy = HTTP2FrameHeaderBlock {
+-                name: head.name.to_vec(),
+-                value: head.value.to_vec(),
++                name: head.name.clone(),
++                value: head.value.clone(),
+                 error: head.error,
+                 sizeupdate: 0,
+             };
+@@ -556,8 +559,8 @@ fn http2_parse_headers_block_dynamic_size<'a>(
+     return Ok((
+         i3,
+         HTTP2FrameHeaderBlock {
+-            name: Vec::new(),
+-            value: Vec::new(),
++            name: Rc::new(Vec::new()),
++            value: Rc::new(Vec::new()),
+             error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSizeUpdate,
+             sizeupdate: maxsize2,
+         },
+@@ -614,8 +617,8 @@ fn http2_parse_headers_blocks<'a>(
+                 // if we error from http2_parse_var_uint, we keep the first parsed headers
+                 if err.code == ErrorKind::LengthValue {
+                     blocks.push(HTTP2FrameHeaderBlock {
+-                        name: Vec::new(),
+-                        value: Vec::new(),
++                        name: Rc::new(Vec::new()),
++                        value: Rc::new(Vec::new()),
+                         error: HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeIntegerOverflow,
+                         sizeupdate: 0,
+                     });
+@@ -765,8 +768,8 @@ mod tests {
+         match r0 {
+             Ok((remainder, hd)) => {
+                 // Check the first message.
+-                assert_eq!(hd.name, ":method".as_bytes().to_vec());
+-                assert_eq!(hd.value, "GET".as_bytes().to_vec());
++                assert_eq!(hd.name, ":method".as_bytes().to_vec().into());
++                assert_eq!(hd.value, "GET".as_bytes().to_vec().into());
+                 // And we should have no bytes left.
+                 assert_eq!(remainder.len(), 0);
+             }
+@@ -782,8 +785,8 @@ mod tests {
+         match r1 {
+             Ok((remainder, hd)) => {
+                 // Check the first message.
+-                assert_eq!(hd.name, "accept".as_bytes().to_vec());
+-                assert_eq!(hd.value, "*/*".as_bytes().to_vec());
++                assert_eq!(hd.name, "accept".as_bytes().to_vec().into());
++                assert_eq!(hd.value, "*/*".as_bytes().to_vec().into());
+                 // And we should have no bytes left.
+                 assert_eq!(remainder.len(), 0);
+                 assert_eq!(dynh.table.len(), 1);
+@@ -802,8 +805,8 @@ mod tests {
+         match result {
+             Ok((remainder, hd)) => {
+                 // Check the first message.
+-                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
+-                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
++                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
++                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
+                 // And we should have no bytes left.
+                 assert_eq!(remainder.len(), 0);
+                 assert_eq!(dynh.table.len(), 2);
+@@ -820,8 +823,8 @@ mod tests {
+         match r3 {
+             Ok((remainder, hd)) => {
+                 // same as before
+-                assert_eq!(hd.name, ":authority".as_bytes().to_vec());
+-                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec());
++                assert_eq!(hd.name, ":authority".as_bytes().to_vec().into());
++                assert_eq!(hd.value, "localhost:3000".as_bytes().to_vec().into());
+                 // And we should have no bytes left.
+                 assert_eq!(remainder.len(), 0);
+                 assert_eq!(dynh.table.len(), 2);
+@@ -856,8 +859,8 @@ mod tests {
+         match r2 {
+             Ok((remainder, hd)) => {
+                 // Check the first message.
+-                assert_eq!(hd.name, ":path".as_bytes().to_vec());
+-                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec());
++                assert_eq!(hd.name, ":path".as_bytes().to_vec().into());
++                assert_eq!(hd.value, "/doc/manual/html/index.html".as_bytes().to_vec().into());
+                 // And we should have no bytes left.
+                 assert_eq!(remainder.len(), 0);
+                 assert_eq!(dynh.table.len(), 2);
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32663-002.patch b/recipes-ids/suricata/files/CVE-2024-32663-002.patch
new file mode 100644
index 0000000..a57f58f
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32663-002.patch
@@ -0,0 +1,70 @@
+From c0af92295e833d1db29b184d63cd3b829451d7fd Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Thu, 28 Mar 2024 11:15:51 +0100
+Subject: [PATCH] http2: do not log duplicate headers
+
+Ticket: 6900
+
+And thus avoid DOS by logging a request using a compressed
+header block repeated many times and having a long value...
+
+(cherry picked from commit 03442c9071b8d863d26b609d54c6eacf4de9e340)
+
+CVE: CVE-2024-32663
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/c0af92295e833d1db29b184d63cd3b829451d7fd]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ rust/src/http2/logger.rs | 17 +++++++++++++++--
+ 1 file changed, 15 insertions(+), 2 deletions(-)
+
+diff --git a/rust/src/http2/logger.rs b/rust/src/http2/logger.rs
+index d25f852..a117a54 100644
+--- a/rust/src/http2/logger.rs
++++ b/rust/src/http2/logger.rs
+@@ -19,7 +19,8 @@ use super::http2::{HTTP2Frame, HTTP2FrameTypeData, HTTP2Transaction};
+ use super::parser;
+ use crate::jsonbuilder::{JsonBuilder, JsonError};
+ use std;
+-use std::collections::HashMap;
++use std::collections::{HashMap, HashSet};
++use std::rc::Rc;
+ 
+ #[derive(Hash, PartialEq, Eq, Debug)]
+ enum HeaderName {
+@@ -35,10 +36,20 @@ fn log_http2_headers<'a>(
+     blocks: &'a [parser::HTTP2FrameHeaderBlock], js: &mut JsonBuilder,
+     common: &mut HashMap<HeaderName, &'a Vec<u8>>,
+ ) -> Result<(), JsonError> {
++    let mut logged_headers = HashSet::new();
+     for block in blocks {
+-        js.start_object()?;
++        // delay js.start_object() because we skip suplicate headers
+         match block.error {
+             parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSuccess => {
++                if Rc::strong_count(&block.name) > 2 {
++                    // more than one reference in headers table + current headers
++                    let ptr = Rc::as_ptr(&block.name) as usize;
++                    if !logged_headers.insert(ptr) {
++                        // only log once
++                        continue;
++                    }
++                }
++                js.start_object()?;
+                 js.set_string_from_bytes("name", &block.name)?;
+                 js.set_string_from_bytes("value", &block.value)?;
+                 if let Ok(name) = std::str::from_utf8(&block.name) {
+@@ -66,9 +77,11 @@ fn log_http2_headers<'a>(
+                 }
+             }
+             parser::HTTP2HeaderDecodeStatus::HTTP2HeaderDecodeSizeUpdate => {
++                js.start_object()?;
+                 js.set_uint("table_size_update", block.sizeupdate)?;
+             }
+             _ => {
++                js.start_object()?;
+                 js.set_string("error", &block.error.to_string())?;
+             }
+         }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32664.patch b/recipes-ids/suricata/files/CVE-2024-32664.patch
new file mode 100644
index 0000000..ee55b25
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32664.patch
@@ -0,0 +1,53 @@
+From d5ffecf11ad2c6fe89265e518f5d7443caf26ba4 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Thu, 28 Mar 2024 14:00:02 +0100
+Subject: [PATCH] util/base64: fix buffer overflow
+
+Ticket: 6902
+
+In case the caller of DecodeBase64 does not supply a big enough
+output buffer.
+
+(cherry picked from commit fd47e67dc65f9111895c88fb406c938b1f857325)
+
+CVE: CVE-2024-32664
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/d5ffecf11ad2c6fe89265e518f5d7443caf26ba4]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/util-base64.c | 6 +++++-
+ 1 file changed, 5 insertions(+), 1 deletion(-)
+
+diff --git a/src/util-base64.c b/src/util-base64.c
+index 4a4a5d1..d973f0e 100644
+--- a/src/util-base64.c
++++ b/src/util-base64.c
+@@ -156,6 +156,8 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
+                 ecode = BASE64_ECODE_BUF;
+                 break;
+             }
++            if (dest_size - *decoded_bytes < ASCII_BLOCK)
++                return BASE64_ECODE_BUF;
+ 
+             /* Decode base-64 block into ascii block and move pointer */
+             DecodeBase64Block(dptr, b64);
+@@ -183,7 +185,7 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
+         /* if the destination size is not at least 3 Bytes long, it'll give a dynamic
+          * buffer overflow while decoding, so, return and let the caller take care of the
+          * remaining bytes to be decoded which should always be < 4 at this stage */
+-        if (dest_size - *decoded_bytes < 3)
++        if (dest_size - *decoded_bytes < ASCII_BLOCK)
+             return BASE64_ECODE_BUF;
+         *decoded_bytes += numDecoded_blk;
+         DecodeBase64Block(dptr, b64);
+@@ -193,6 +195,8 @@ Base64Ecode DecodeBase64(uint8_t *dest, uint32_t dest_size, const uint8_t *src,
+     /* Finish remaining b64 bytes by padding */
+     if (valid && bbidx > 0 && (mode != BASE64_MODE_RFC2045)) {
+         /* Decode remaining */
++        if (dest_size - *decoded_bytes < ASCII_BLOCK)
++            return BASE64_ECODE_BUF;
+         *decoded_bytes += ASCII_BLOCK - (B64_BLOCK - bbidx);
+         DecodeBase64Block(dptr, b64);
+     }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-001.patch b/recipes-ids/suricata/files/CVE-2024-32867-001.patch
new file mode 100644
index 0000000..68bd6ea
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32867-001.patch
@@ -0,0 +1,235 @@
+From 2f39ba75f153ba9bdf8eedc2a839cc973dbaea66 Mon Sep 17 00:00:00 2001
+From: Jason Ish <jason.ish@oisf.net>
+Date: Tue, 28 Nov 2023 12:35:26 -0600
+Subject: [PATCH] defrag: check next fragment for overlap before stopping
+ re-assembly
+
+Instead of breaking the loop when the current fragment does not have
+any more fragments, set a flag and continue to the next fragment as
+the next fragment may have data that occurs before this fragment, but
+overlaps it.
+
+Then break if the next fragment does not overlap the previous.
+
+Bug: #6668
+(cherry picked from commit d0fd0782505d837e691ceef1b801776f0db82726)
+
+CVE: CVE-2024-32867
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/2f39ba75f153ba9bdf8eedc2a839cc973dbaea66]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/defrag.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++---
+ 1 file changed, 139 insertions(+), 6 deletions(-)
+
+diff --git a/src/defrag.c b/src/defrag.c
+index 38704c9..e154899 100644
+--- a/src/defrag.c
++++ b/src/defrag.c
+@@ -295,10 +295,20 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+     uint16_t hlen = 0;
+     int ip_hdr_offset = 0;
+ 
++    /* Assume more frags. */
++    uint16_t prev_offset = 0;
++    bool more_frags = 1;
++
+     RB_FOREACH(frag, IP_FRAGMENTS, &tracker->fragment_tree) {
+         SCLogDebug("frag %p, data_len %u, offset %u, pcap_cnt %"PRIu64,
+                 frag, frag->data_len, frag->offset, frag->pcap_cnt);
+ 
++        /* Previous fragment has no more fragments, and this packet
++         * doesn't overlap. We're done. */
++        if (!more_frags && frag->offset > prev_offset) {
++            break;
++        }
++
+         if (frag->skip)
+             continue;
+         if (frag->ltrim >= frag->data_len)
+@@ -339,9 +349,16 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+                 fragmentable_len = frag->offset + frag->data_len;
+         }
+ 
+-        if (!frag->more_frags) {
+-            break;
+-        }
++        /* Even if this fragment is flagged as having no more
++         * fragments, still continue. The next fragment may have the
++         * same offset with data that is preferred.
++         *
++         * For example, DefragBsdFragmentAfterNoMfIpv{4,6}Test
++         *
++         * This is due to not all fragments being completely trimmed,
++         * but relying on the copy ordering. */
++        more_frags = frag->more_frags;
++        prev_offset = frag->offset;
+     }
+ 
+     SCLogDebug("ip_hdr_offset %u, hlen %" PRIu16 ", fragmentable_len %" PRIu16, ip_hdr_offset, hlen,
+@@ -436,7 +453,15 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+     uint16_t fragmentable_len = 0;
+     int ip_hdr_offset = 0;
+     uint8_t next_hdr = 0;
++
++    /* Assume more frags. */
++    uint16_t prev_offset = 0;
++    bool more_frags = 1;
++
+     RB_FOREACH(frag, IP_FRAGMENTS, &tracker->fragment_tree) {
++        if (!more_frags && frag->offset > prev_offset) {
++            break;
++        }
+         if (frag->skip)
+             continue;
+         if (frag->data_len - frag->ltrim <= 0)
+@@ -481,9 +506,16 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+                 fragmentable_len = frag->offset + frag->data_len;
+         }
+ 
+-        if (!frag->more_frags) {
+-            break;
+-        }
++        /* Even if this fragment is flagged as having no more
++         * fragments, still continue. The next fragment may have the
++         * same offset with data that is preferred.
++         *
++         * For example, DefragBsdFragmentAfterNoMfIpv{4,6}Test
++         *
++         * This is due to not all fragments being completely trimmed,
++         * but relying on the copy ordering. */
++        more_frags = frag->more_frags;
++        prev_offset = frag->offset;
+     }
+ 
+     rp->ip6h = (IPV6Hdr *)(GET_PKT_DATA(rp) + ip_hdr_offset);
+@@ -2374,6 +2406,10 @@ static int DefragMfIpv4Test(void)
+      * fragments should be in the re-assembled packet. */
+     FAIL_IF(IPV4_GET_IPLEN(p) != 36);
+ 
++    /* Verify the payload of the IPv4 packet. */
++    uint8_t expected_payload[] = "AAAAAAAABBBBBBBB";
++    FAIL_IF(memcmp(GET_PKT_DATA(p) + sizeof(IPV4Hdr), expected_payload, sizeof(expected_payload)));
++
+     SCFree(p1);
+     SCFree(p2);
+     SCFree(p3);
+@@ -2417,6 +2453,10 @@ static int DefragMfIpv6Test(void)
+      * of 2 fragments, so 16. */
+     FAIL_IF(IPV6_GET_PLEN(p) != 16);
+ 
++    /* Verify the payload of the IPv4 packet. */
++    uint8_t expected_payload[] = "AAAAAAAABBBBBBBB";
++    FAIL_IF(memcmp(GET_PKT_DATA(p) + sizeof(IPV6Hdr), expected_payload, sizeof(expected_payload)));
++
+     SCFree(p1);
+     SCFree(p2);
+     SCFree(p3);
+@@ -2510,6 +2550,96 @@ static int DefragTestJeremyLinux(void)
+     PASS;
+ }
+ 
++static int DefragBsdFragmentAfterNoMfIpv4Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[4];
++
++    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 24 >> 3, 0, 'A', 16);
++    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 8 >> 3, 1, 'B', 16);
++    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 16 >> 3, 1, 'C', 16);
++    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, 0x96, 0, 1, 'D', 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    uint8_t expected[] = {
++	'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D',
++	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
++	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
++	'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C',
++	'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
++    };
++    // clang-format on
++
++    if (memcmp(expected, GET_PKT_DATA(r) + 20, sizeof(expected)) != 0) {
++        printf("Expected:\n");
++        PrintRawDataFp(stdout, expected, sizeof(expected));
++        printf("Got:\n");
++        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
++        FAIL;
++    }
++
++    DefragDestroy();
++    PASS;
++}
++
++static int DefragBsdFragmentAfterNoMfIpv6Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[4];
++
++    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 24 >> 3, 0, 'A', 16);
++    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 8 >> 3, 1, 'B', 16);
++    packets[2] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 16 >> 3, 1, 'C', 16);
++    packets[3] = BuildIpv6TestPacket(IPPROTO_ICMP, 0x96, 0, 1, 'D', 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    uint8_t expected[] = {
++	'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D',
++	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
++	'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B',
++	'C', 'C', 'C', 'C', 'C', 'C', 'C', 'C',
++	'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
++    };
++    // clang-format on
++
++    if (memcmp(expected, GET_PKT_DATA(r) + 40, sizeof(expected)) != 0) {
++        printf("Expected:\n");
++        PrintRawDataFp(stdout, expected, sizeof(expected));
++        printf("Got:\n");
++        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
++        FAIL;
++    }
++
++    DefragDestroy();
++    PASS;
++}
++
+ #endif /* UNITTESTS */
+ 
+ void DefragRegisterTests(void)
+@@ -2555,5 +2685,8 @@ void DefragRegisterTests(void)
+     UtRegisterTest("DefragTestBadProto", DefragTestBadProto);
+ 
+     UtRegisterTest("DefragTestJeremyLinux", DefragTestJeremyLinux);
++
++    UtRegisterTest("DefragBsdFragmentAfterNoMfIpv4Test", DefragBsdFragmentAfterNoMfIpv4Test);
++    UtRegisterTest("DefragBsdFragmentAfterNoMfIpv6Test", DefragBsdFragmentAfterNoMfIpv6Test);
+ #endif /* UNITTESTS */
+ }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-002.patch b/recipes-ids/suricata/files/CVE-2024-32867-002.patch
new file mode 100644
index 0000000..cfddce2
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32867-002.patch
@@ -0,0 +1,591 @@
+From 7137d5e7ab5500f1b7f3391f8ab55a59f1e4cbd7 Mon Sep 17 00:00:00 2001
+From: Jason Ish <jason.ish@oisf.net>
+Date: Mon, 27 Nov 2023 16:27:27 -0600
+Subject: [PATCH] defrag: consistent unit test naming
+
+Use a more consistent naming scheme between ipv4 and ipv6.
+
+(cherry picked from commit 2f00b5870abc6053fca8271a0a827babc03d56f0)
+
+CVE: CVE-2024-32867
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/7137d5e7ab5500f1b7f3391f8ab55a59f1e4cbd7]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/defrag.c | 217 ++++++++++++++++++++++++---------------------------
+ 1 file changed, 102 insertions(+), 115 deletions(-)
+
+diff --git a/src/defrag.c b/src/defrag.c
+index e154899..99fbab3 100644
+--- a/src/defrag.c
++++ b/src/defrag.c
+@@ -1125,8 +1125,8 @@ void DefragDestroy(void)
+  * Allocate a test packet.  Nothing to fancy, just a simple IP packet
+  * with some payload of no particular protocol.
+  */
+-static Packet *BuildTestPacket(uint8_t proto, uint16_t id, uint16_t off, int mf,
+-        const char content, int content_len)
++static Packet *BuildIpv4TestPacket(
++        uint8_t proto, uint16_t id, uint16_t off, int mf, const char content, int content_len)
+ {
+     Packet *p = NULL;
+     int hlen = 20;
+@@ -1199,8 +1199,8 @@ error:
+     return NULL;
+ }
+ 
+-static Packet *IPV6BuildTestPacket(uint8_t proto, uint32_t id, uint16_t off,
+-        int mf, const char content, int content_len)
++static Packet *BuildIpv6TestPacket(
++        uint8_t proto, uint32_t id, uint16_t off, int mf, const char content, int content_len)
+ {
+     Packet *p = NULL;
+     uint8_t *pcontent;
+@@ -1283,11 +1283,11 @@ static int DefragInOrderSimpleTest(void)
+ 
+     DefragInit();
+ 
+-    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = BuildTestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
++    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
+     FAIL_IF_NULL(p2);
+-    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
++    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
+     FAIL_IF_NULL(p3);
+ 
+     FAIL_IF(Defrag(NULL, NULL, p1) != NULL);
+@@ -1335,11 +1335,11 @@ static int DefragReverseSimpleTest(void)
+ 
+     DefragInit();
+ 
+-    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = BuildTestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
++    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 1, 'B', 8);
+     FAIL_IF_NULL(p2);
+-    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
++    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
+     FAIL_IF_NULL(p3);
+ 
+     FAIL_IF(Defrag(NULL, NULL, p3) != NULL);
+@@ -1379,7 +1379,7 @@ static int DefragReverseSimpleTest(void)
+  * Test the simplest possible re-assembly scenario.  All packet in
+  * order and no overlaps.
+  */
+-static int IPV6DefragInOrderSimpleTest(void)
++static int DefragInOrderSimpleIpv6Test(void)
+ {
+     Packet *p1 = NULL, *p2 = NULL, *p3 = NULL;
+     Packet *reassembled = NULL;
+@@ -1388,11 +1388,11 @@ static int IPV6DefragInOrderSimpleTest(void)
+ 
+     DefragInit();
+ 
+-    p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
++    p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
++    p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
+     FAIL_IF_NULL(p2);
+-    p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
++    p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
+     FAIL_IF_NULL(p3);
+ 
+     FAIL_IF(Defrag(NULL, NULL, p1) != NULL);
+@@ -1426,7 +1426,7 @@ static int IPV6DefragInOrderSimpleTest(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragReverseSimpleTest(void)
++static int DefragReverseSimpleIpv6Test(void)
+ {
+     DefragContext *dc = NULL;
+     Packet *p1 = NULL, *p2 = NULL, *p3 = NULL;
+@@ -1439,11 +1439,11 @@ static int IPV6DefragReverseSimpleTest(void)
+     dc = DefragContextNew();
+     FAIL_IF_NULL(dc);
+ 
+-    p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
++    p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
++    p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 1, 1, 'B', 8);
+     FAIL_IF_NULL(p2);
+-    p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
++    p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 2, 0, 'C', 3);
+     FAIL_IF_NULL(p3);
+ 
+     FAIL_IF(Defrag(NULL, NULL, p3) != NULL);
+@@ -1496,59 +1496,59 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
+      */
+ 
+     /* A*24 at 0. */
+-    packets[0] = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
++    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
+ 
+     /* B*15 at 32. */
+-    packets[1] = BuildTestPacket(IPPROTO_ICMP, id, 32 >> 3, 1, 'B', 16);
++    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 32 >> 3, 1, 'B', 16);
+ 
+     /* C*24 at 48. */
+-    packets[2] = BuildTestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'C', 24);
++    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'C', 24);
+ 
+     /* D*8 at 80. */
+-    packets[3] = BuildTestPacket(IPPROTO_ICMP, id, 80 >> 3, 1, 'D', 8);
++    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 80 >> 3, 1, 'D', 8);
+ 
+     /* E*16 at 104. */
+-    packets[4] = BuildTestPacket(IPPROTO_ICMP, id, 104 >> 3, 1, 'E', 16);
++    packets[4] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 104 >> 3, 1, 'E', 16);
+ 
+     /* F*24 at 120. */
+-    packets[5] = BuildTestPacket(IPPROTO_ICMP, id, 120 >> 3, 1, 'F', 24);
++    packets[5] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 120 >> 3, 1, 'F', 24);
+ 
+     /* G*16 at 144. */
+-    packets[6] = BuildTestPacket(IPPROTO_ICMP, id, 144 >> 3, 1, 'G', 16);
++    packets[6] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 144 >> 3, 1, 'G', 16);
+ 
+     /* H*16 at 160. */
+-    packets[7] = BuildTestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'H', 16);
++    packets[7] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'H', 16);
+ 
+     /* I*8 at 176. */
+-    packets[8] = BuildTestPacket(IPPROTO_ICMP, id, 176 >> 3, 1, 'I', 8);
++    packets[8] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 176 >> 3, 1, 'I', 8);
+ 
+     /*
+      * Overlapping subsequent fragments.
+      */
+ 
+     /* J*32 at 8. */
+-    packets[9] = BuildTestPacket(IPPROTO_ICMP, id, 8 >> 3, 1, 'J', 32);
++    packets[9] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 8 >> 3, 1, 'J', 32);
+ 
+     /* K*24 at 48. */
+-    packets[10] = BuildTestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'K', 24);
++    packets[10] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 48 >> 3, 1, 'K', 24);
+ 
+     /* L*24 at 72. */
+-    packets[11] = BuildTestPacket(IPPROTO_ICMP, id, 72 >> 3, 1, 'L', 24);
++    packets[11] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 72 >> 3, 1, 'L', 24);
+ 
+     /* M*24 at 96. */
+-    packets[12] = BuildTestPacket(IPPROTO_ICMP, id, 96 >> 3, 1, 'M', 24);
++    packets[12] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 96 >> 3, 1, 'M', 24);
+ 
+     /* N*8 at 128. */
+-    packets[13] = BuildTestPacket(IPPROTO_ICMP, id, 128 >> 3, 1, 'N', 8);
++    packets[13] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 128 >> 3, 1, 'N', 8);
+ 
+     /* O*8 at 152. */
+-    packets[14] = BuildTestPacket(IPPROTO_ICMP, id, 152 >> 3, 1, 'O', 8);
++    packets[14] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 152 >> 3, 1, 'O', 8);
+ 
+     /* P*8 at 160. */
+-    packets[15] = BuildTestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'P', 8);
++    packets[15] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 160 >> 3, 1, 'P', 8);
+ 
+     /* Q*16 at 176. */
+-    packets[16] = BuildTestPacket(IPPROTO_ICMP, id, 176 >> 3, 0, 'Q', 16);
++    packets[16] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 176 >> 3, 0, 'Q', 16);
+ 
+     default_policy = policy;
+ 
+@@ -1588,8 +1588,7 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
+     PASS;
+ }
+ 
+-static int IPV6DefragDoSturgesNovakTest(int policy, u_char *expected,
+-        size_t expected_len)
++static int DefragDoSturgesNovakIpv6Test(int policy, u_char *expected, size_t expected_len)
+ {
+     int i;
+ 
+@@ -1608,59 +1607,59 @@ static int IPV6DefragDoSturgesNovakTest(int policy, u_char *expected,
+      */
+ 
+     /* A*24 at 0. */
+-    packets[0] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 24);
++    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 0, 1, 'A', 24);
+ 
+     /* B*15 at 32. */
+-    packets[1] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 32 >> 3, 1, 'B', 16);
++    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 32 >> 3, 1, 'B', 16);
+ 
+     /* C*24 at 48. */
+-    packets[2] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'C', 24);
++    packets[2] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'C', 24);
+ 
+     /* D*8 at 80. */
+-    packets[3] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 80 >> 3, 1, 'D', 8);
++    packets[3] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 80 >> 3, 1, 'D', 8);
+ 
+     /* E*16 at 104. */
+-    packets[4] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 104 >> 3, 1, 'E', 16);
++    packets[4] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 104 >> 3, 1, 'E', 16);
+ 
+     /* F*24 at 120. */
+-    packets[5] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 120 >> 3, 1, 'F', 24);
++    packets[5] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 120 >> 3, 1, 'F', 24);
+ 
+     /* G*16 at 144. */
+-    packets[6] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 144 >> 3, 1, 'G', 16);
++    packets[6] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 144 >> 3, 1, 'G', 16);
+ 
+     /* H*16 at 160. */
+-    packets[7] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'H', 16);
++    packets[7] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'H', 16);
+ 
+     /* I*8 at 176. */
+-    packets[8] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 1, 'I', 8);
++    packets[8] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 1, 'I', 8);
+ 
+     /*
+      * Overlapping subsequent fragments.
+      */
+ 
+     /* J*32 at 8. */
+-    packets[9] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 8 >> 3, 1, 'J', 32);
++    packets[9] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 8 >> 3, 1, 'J', 32);
+ 
+     /* K*24 at 48. */
+-    packets[10] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'K', 24);
++    packets[10] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 48 >> 3, 1, 'K', 24);
+ 
+     /* L*24 at 72. */
+-    packets[11] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 72 >> 3, 1, 'L', 24);
++    packets[11] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 72 >> 3, 1, 'L', 24);
+ 
+     /* M*24 at 96. */
+-    packets[12] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 96 >> 3, 1, 'M', 24);
++    packets[12] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 96 >> 3, 1, 'M', 24);
+ 
+     /* N*8 at 128. */
+-    packets[13] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 128 >> 3, 1, 'N', 8);
++    packets[13] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 128 >> 3, 1, 'N', 8);
+ 
+     /* O*8 at 152. */
+-    packets[14] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 152 >> 3, 1, 'O', 8);
++    packets[14] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 152 >> 3, 1, 'O', 8);
+ 
+     /* P*8 at 160. */
+-    packets[15] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'P', 8);
++    packets[15] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 160 >> 3, 1, 'P', 8);
+ 
+     /* Q*16 at 176. */
+-    packets[16] = IPV6BuildTestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 0, 'Q', 16);
++    packets[16] = BuildIpv6TestPacket(IPPROTO_ICMPV6, id, 176 >> 3, 0, 'Q', 16);
+ 
+     default_policy = policy;
+ 
+@@ -1735,7 +1734,7 @@ DefragSturgesNovakBsdTest(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakBsdTest(void)
++static int DefragSturgesNovakBsdIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -1765,8 +1764,7 @@ static int IPV6DefragSturgesNovakBsdTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_BSD, expected,
+-                    sizeof(expected)));
++    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_BSD, expected, sizeof(expected)));
+     PASS;
+ }
+ 
+@@ -1805,7 +1803,7 @@ static int DefragSturgesNovakLinuxIpv4Test(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakLinuxTest(void)
++static int DefragSturgesNovakLinuxIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -1835,8 +1833,7 @@ static int IPV6DefragSturgesNovakLinuxTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_LINUX, expected,
+-            sizeof(expected)));
++    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_LINUX, expected, sizeof(expected)));
+     PASS;
+ }
+ 
+@@ -1875,7 +1872,7 @@ static int DefragSturgesNovakWindowsIpv4Test(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakWindowsTest(void)
++static int DefragSturgesNovakWindowsIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -1905,8 +1902,7 @@ static int IPV6DefragSturgesNovakWindowsTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_WINDOWS, expected,
+-                    sizeof(expected)));
++    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_WINDOWS, expected, sizeof(expected)));
+     PASS;
+ }
+ 
+@@ -1945,7 +1941,7 @@ static int DefragSturgesNovakSolarisTest(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakSolarisTest(void)
++static int DefragSturgesNovakSolarisIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -1975,8 +1971,7 @@ static int IPV6DefragSturgesNovakSolarisTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_SOLARIS, expected,
+-                    sizeof(expected)));
++    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_SOLARIS, expected, sizeof(expected)));
+     PASS;
+ }
+ 
+@@ -2015,7 +2010,7 @@ static int DefragSturgesNovakFirstTest(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakFirstTest(void)
++static int DefragSturgesNovakFirstIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -2045,8 +2040,7 @@ static int IPV6DefragSturgesNovakFirstTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    return IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_FIRST, expected,
+-        sizeof(expected));
++    return DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_FIRST, expected, sizeof(expected));
+ }
+ 
+ static int
+@@ -2085,7 +2079,7 @@ DefragSturgesNovakLastTest(void)
+     PASS;
+ }
+ 
+-static int IPV6DefragSturgesNovakLastTest(void)
++static int DefragSturgesNovakLastIpv6Test(void)
+ {
+     /* Expected data. */
+     u_char expected[] = {
+@@ -2115,8 +2109,7 @@ static int IPV6DefragSturgesNovakLastTest(void)
+         "QQQQQQQQ"
+     };
+ 
+-    FAIL_IF_NOT(IPV6DefragDoSturgesNovakTest(DEFRAG_POLICY_LAST, expected,
+-                    sizeof(expected)));
++    FAIL_IF_NOT(DefragDoSturgesNovakIpv6Test(DEFRAG_POLICY_LAST, expected, sizeof(expected)));
+     PASS;
+ }
+ 
+@@ -2131,7 +2124,7 @@ static int DefragTimeoutTest(void)
+ 
+     /* Load in 16 packets. */
+     for (i = 0; i < 16; i++) {
+-        Packet *p = BuildTestPacket(IPPROTO_ICMP,i, 0, 1, 'A' + i, 16);
++        Packet *p = BuildIpv4TestPacket(IPPROTO_ICMP, i, 0, 1, 'A' + i, 16);
+         FAIL_IF_NULL(p);
+ 
+         Packet *tp = Defrag(NULL, NULL, p);
+@@ -2141,7 +2134,7 @@ static int DefragTimeoutTest(void)
+ 
+     /* Build a new packet but push the timestamp out by our timeout.
+      * This should force our previous fragments to be timed out. */
+-    Packet *p = BuildTestPacket(IPPROTO_ICMP, 99, 0, 1, 'A' + i, 16);
++    Packet *p = BuildIpv4TestPacket(IPPROTO_ICMP, 99, 0, 1, 'A' + i, 16);
+     FAIL_IF_NULL(p);
+ 
+     p->ts = SCTIME_ADD_SECS(p->ts, defrag_context->timeout + 1);
+@@ -2166,7 +2159,7 @@ static int DefragTimeoutTest(void)
+  * fail.  The fix was simple, but this unit test is just to make sure
+  * its not introduced.
+  */
+-static int DefragIPv4NoDataTest(void)
++static int DefragNoDataIpv4Test(void)
+ {
+     DefragContext *dc = NULL;
+     Packet *p = NULL;
+@@ -2178,7 +2171,7 @@ static int DefragIPv4NoDataTest(void)
+     FAIL_IF_NULL(dc);
+ 
+     /* This packet has an offset > 0, more frags set to 0 and no data. */
+-    p = BuildTestPacket(IPPROTO_ICMP, id, 1, 0, 'A', 0);
++    p = BuildIpv4TestPacket(IPPROTO_ICMP, id, 1, 0, 'A', 0);
+     FAIL_IF_NULL(p);
+ 
+     /* We do not expect a packet returned. */
+@@ -2195,7 +2188,7 @@ static int DefragIPv4NoDataTest(void)
+     PASS;
+ }
+ 
+-static int DefragIPv4TooLargeTest(void)
++static int DefragTooLargeIpv4Test(void)
+ {
+     DefragContext *dc = NULL;
+     Packet *p = NULL;
+@@ -2207,7 +2200,7 @@ static int DefragIPv4TooLargeTest(void)
+ 
+     /* Create a fragment that would extend past the max allowable size
+      * for an IPv4 packet. */
+-    p = BuildTestPacket(IPPROTO_ICMP, 1, 8183, 0, 'A', 71);
++    p = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 8183, 0, 'A', 71);
+     FAIL_IF_NULL(p);
+ 
+     /* We do not expect a packet returned. */
+@@ -2238,9 +2231,9 @@ static int DefragVlanTest(void)
+ 
+     DefragInit();
+ 
+-    p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
++    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
+     FAIL_IF_NULL(p2);
+ 
+     /* With no VLAN IDs set, packets should re-assemble. */
+@@ -2270,9 +2263,9 @@ static int DefragVlanQinQTest(void)
+ 
+     DefragInit();
+ 
+-    p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
++    p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
+     FAIL_IF_NULL(p2);
+ 
+     /* With no VLAN IDs set, packets should re-assemble. */
+@@ -2304,9 +2297,9 @@ static int DefragVlanQinQinQTest(void)
+ 
+     DefragInit();
+ 
+-    Packet *p1 = BuildTestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
++    Packet *p1 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    Packet *p2 = BuildTestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
++    Packet *p2 = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 1, 0, 'B', 8);
+     FAIL_IF_NULL(p2);
+ 
+     /* With no VLAN IDs set, packets should re-assemble. */
+@@ -2340,7 +2333,7 @@ static int DefragTrackerReuseTest(void)
+ 
+     /* Build a packet, its not a fragment but shouldn't matter for
+      * this test. */
+-    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 0, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 0, 'A', 8);
+     FAIL_IF_NULL(p1);
+ 
+     /* Get a tracker. It shouldn't look like its already in use. */
+@@ -2387,9 +2380,9 @@ static int DefragMfIpv4Test(void)
+ 
+     DefragInit();
+ 
+-    Packet *p1 = BuildTestPacket(IPPROTO_ICMP, ip_id, 2, 1, 'C', 8);
+-    Packet *p2 = BuildTestPacket(IPPROTO_ICMP, ip_id, 0, 1, 'A', 8);
+-    Packet *p3 = BuildTestPacket(IPPROTO_ICMP, ip_id, 1, 0, 'B', 8);
++    Packet *p1 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 2, 1, 'C', 8);
++    Packet *p2 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 0, 1, 'A', 8);
++    Packet *p3 = BuildIpv4TestPacket(IPPROTO_ICMP, ip_id, 1, 0, 'B', 8);
+     FAIL_IF(p1 == NULL || p2 == NULL || p3 == NULL);
+ 
+     p = Defrag(NULL, NULL, p1);
+@@ -2434,9 +2427,9 @@ static int DefragMfIpv6Test(void)
+ 
+     DefragInit();
+ 
+-    Packet *p1 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 2, 1, 'C', 8);
+-    Packet *p2 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 0, 1, 'A', 8);
+-    Packet *p3 = IPV6BuildTestPacket(IPPROTO_ICMPV6, ip_id, 1, 0, 'B', 8);
++    Packet *p1 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 2, 1, 'C', 8);
++    Packet *p2 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 0, 1, 'A', 8);
++    Packet *p3 = BuildIpv6TestPacket(IPPROTO_ICMPV6, ip_id, 1, 0, 'B', 8);
+     FAIL_IF(p1 == NULL || p2 == NULL || p3 == NULL);
+ 
+     p = Defrag(NULL, NULL, p1);
+@@ -2476,11 +2469,11 @@ static int DefragTestBadProto(void)
+ 
+     DefragInit();
+ 
+-    p1 = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
++    p1 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 8);
+     FAIL_IF_NULL(p1);
+-    p2 = BuildTestPacket(IPPROTO_UDP, id, 1, 1, 'B', 8);
++    p2 = BuildIpv4TestPacket(IPPROTO_UDP, id, 1, 1, 'B', 8);
+     FAIL_IF_NULL(p2);
+-    p3 = BuildTestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
++    p3 = BuildIpv4TestPacket(IPPROTO_ICMP, id, 2, 0, 'C', 3);
+     FAIL_IF_NULL(p3);
+ 
+     FAIL_IF_NOT_NULL(Defrag(NULL, NULL, p1));
+@@ -2522,10 +2515,10 @@ static int DefragTestJeremyLinux(void)
+     Packet *packets[4];
+     int i = 0;
+ 
+-    packets[0] = BuildTestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
+-    packets[1] = BuildTestPacket(IPPROTO_ICMP, id, 40 >> 3, 1, 'B', 48);
+-    packets[2] = BuildTestPacket(IPPROTO_ICMP, id, 24 >> 3, 1, 'C', 48);
+-    packets[3] = BuildTestPacket(IPPROTO_ICMP, id, 88 >> 3, 0, 'D', 14);
++    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 0, 1, 'A', 24);
++    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 40 >> 3, 1, 'B', 48);
++    packets[2] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 24 >> 3, 1, 'C', 48);
++    packets[3] = BuildIpv4TestPacket(IPPROTO_ICMP, id, 88 >> 3, 0, 'D', 14);
+ 
+     Packet *r = Defrag(NULL, NULL, packets[0]);
+     FAIL_IF_NOT_NULL(r);
+@@ -2657,23 +2650,17 @@ void DefragRegisterTests(void)
+     UtRegisterTest("DefragSturgesNovakFirstTest", DefragSturgesNovakFirstTest);
+     UtRegisterTest("DefragSturgesNovakLastTest", DefragSturgesNovakLastTest);
+ 
+-    UtRegisterTest("DefragIPv4NoDataTest", DefragIPv4NoDataTest);
+-    UtRegisterTest("DefragIPv4TooLargeTest", DefragIPv4TooLargeTest);
+-
+-    UtRegisterTest("IPV6DefragInOrderSimpleTest", IPV6DefragInOrderSimpleTest);
+-    UtRegisterTest("IPV6DefragReverseSimpleTest", IPV6DefragReverseSimpleTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakBsdTest",
+-                   IPV6DefragSturgesNovakBsdTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakLinuxTest",
+-                   IPV6DefragSturgesNovakLinuxTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakWindowsTest",
+-                   IPV6DefragSturgesNovakWindowsTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakSolarisTest",
+-                   IPV6DefragSturgesNovakSolarisTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakFirstTest",
+-                   IPV6DefragSturgesNovakFirstTest);
+-    UtRegisterTest("IPV6DefragSturgesNovakLastTest",
+-                   IPV6DefragSturgesNovakLastTest);
++    UtRegisterTest("DefragNoDataIpv4Test", DefragNoDataIpv4Test);
++    UtRegisterTest("DefragTooLargeIpv4Test", DefragTooLargeIpv4Test);
++
++    UtRegisterTest("DefragInOrderSimpleIpv6Test", DefragInOrderSimpleIpv6Test);
++    UtRegisterTest("DefragReverseSimpleIpv6Test", DefragReverseSimpleIpv6Test);
++    UtRegisterTest("DefragSturgesNovakBsdIpv6Test", DefragSturgesNovakBsdIpv6Test);
++    UtRegisterTest("DefragSturgesNovakLinuxIpv6Test", DefragSturgesNovakLinuxIpv6Test);
++    UtRegisterTest("DefragSturgesNovakWindowsIpv6Test", DefragSturgesNovakWindowsIpv6Test);
++    UtRegisterTest("DefragSturgesNovakSolarisIpv6Test", DefragSturgesNovakSolarisIpv6Test);
++    UtRegisterTest("DefragSturgesNovakFirstIpv6Test", DefragSturgesNovakFirstIpv6Test);
++    UtRegisterTest("DefragSturgesNovakLastIpv6Test", DefragSturgesNovakLastIpv6Test);
+ 
+     UtRegisterTest("DefragVlanTest", DefragVlanTest);
+     UtRegisterTest("DefragVlanQinQTest", DefragVlanQinQTest);
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-003.patch b/recipes-ids/suricata/files/CVE-2024-32867-003.patch
new file mode 100644
index 0000000..15ee1f4
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32867-003.patch
@@ -0,0 +1,472 @@
+From 1e110d0a71db46571040b937e17a4bc9f91d6de9 Mon Sep 17 00:00:00 2001
+From: Jason Ish <jason.ish@oisf.net>
+Date: Thu, 7 Dec 2023 16:44:56 -0600
+Subject: [PATCH] defrag: fix subsequent overlap of start of original (bsd)
+
+Fix the BSD policy case where a subsequent fragment starts before an
+original fragment and overlaps the beginning of the original
+fragment. In this case the overlapping data from the new fragment is
+preferred.
+
+Suricata was preferring the data from the original fragment, but it
+should only do that when the original fragment has an offset <= to the
+new fragment.
+
+- Adds test for this case
+
+Bug: #6669
+(cherry picked from commit f1709ea551124e1a64fdc509993ad022ab27aa77)
+
+CVE: CVE-2024-32867
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/1e110d0a71db46571040b937e17a4bc9f91d6de9]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/defrag.c | 387 ++++++++++++++++++++++++++++++++++++++++++++++++++-
+ 1 file changed, 380 insertions(+), 7 deletions(-)
+
+diff --git a/src/defrag.c b/src/defrag.c
+index 99fbab3..28d085d 100644
+--- a/src/defrag.c
++++ b/src/defrag.c
+@@ -692,16 +692,45 @@ DefragInsertFrag(ThreadVars *tv, DecodeThreadVars *dtv, DefragTracker *tracker,
+             switch (tracker->policy) {
+             case DEFRAG_POLICY_BSD:
+                 if (frag_offset < prev->offset + prev->data_len) {
+-                    if (frag_offset >= prev->offset) {
+-                        ltrim = prev->offset + prev->data_len - frag_offset;
++                    if (prev->offset <= frag_offset) {
++                        /* We prefer the data from the previous
++                         * fragment, so trim off the data in the new
++                         * fragment that exists in the previous
++                         * fragment. */
++                        uint16_t prev_end = prev->offset + prev->data_len;
++                        if (prev_end > frag_end) {
++                            /* Just skip. */
++                            /* TODO: Set overlap flag. */
++                            goto done;
++                        }
++                        ltrim = prev_end - frag_offset;
++
++                        if ((next != NULL) && (frag_end > next->offset)) {
++                            next->ltrim = frag_end - next->offset;
++                        }
++
++                        goto insert;
+                     }
++
++                    /* If the end of this fragment overlaps the start
++                     * of the previous fragment, then trim up the
++                     * start of previous fragment so this fragment is
++                     * used.
++                     *
++                     * See:
++                     * DefragBsdSubsequentOverlapsStartOfOriginal.
++                     */
++                    if (frag_offset <= prev->offset && frag_end > prev->offset + prev->ltrim) {
++                        uint16_t prev_ltrim = frag_end - prev->offset;
++                        if (prev_ltrim > prev->ltrim) {
++                            prev->ltrim = prev_ltrim;
++                        }
++                    }
++
+                     if ((next != NULL) && (frag_end > next->offset)) {
+                         next->ltrim = frag_end - next->offset;
+                     }
+-                    if ((frag_offset < prev->offset) &&
+-                        (frag_end >= prev->offset + prev->data_len)) {
+-                        prev->skip = 1;
+-                    }
++
+                     goto insert;
+                 }
+                 break;
+@@ -1199,6 +1228,77 @@ error:
+     return NULL;
+ }
+ 
++/**
++ * Allocate a test packet, much like BuildIpv4TestPacket, but with
++ * the full content provided by the caller.
++ */
++static Packet *BuildIpv4TestPacketWithContent(
++        uint8_t proto, uint16_t id, uint16_t off, int mf, const uint8_t *content, int content_len)
++{
++    Packet *p = NULL;
++    int hlen = 20;
++    int ttl = 64;
++    IPV4Hdr ip4h;
++
++    p = SCCalloc(1, sizeof(*p) + default_packet_size);
++    if (unlikely(p == NULL))
++        return NULL;
++
++    PacketInit(p);
++
++    struct timeval tval;
++    gettimeofday(&tval, NULL);
++    p->ts = SCTIME_FROM_TIMEVAL(&tval);
++    ip4h.ip_verhl = 4 << 4;
++    ip4h.ip_verhl |= hlen >> 2;
++    ip4h.ip_len = htons(hlen + content_len);
++    ip4h.ip_id = htons(id);
++    if (mf)
++        ip4h.ip_off = htons(IP_MF | off);
++    else
++        ip4h.ip_off = htons(off);
++    ip4h.ip_ttl = ttl;
++    ip4h.ip_proto = proto;
++
++    ip4h.s_ip_src.s_addr = 0x01010101; /* 1.1.1.1 */
++    ip4h.s_ip_dst.s_addr = 0x02020202; /* 2.2.2.2 */
++
++    /* copy content_len crap, we need full length */
++    PacketCopyData(p, (uint8_t *)&ip4h, sizeof(ip4h));
++    p->ip4h = (IPV4Hdr *)GET_PKT_DATA(p);
++    SET_IPV4_SRC_ADDR(p, &p->src);
++    SET_IPV4_DST_ADDR(p, &p->dst);
++
++    PacketCopyDataOffset(p, hlen, content, content_len);
++    SET_PKT_LEN(p, hlen + content_len);
++
++    p->ip4h->ip_csum = IPV4Checksum((uint16_t *)GET_PKT_DATA(p), hlen, 0);
++
++    /* Self test. */
++    if (IPV4_GET_VER(p) != 4)
++        goto error;
++    if (IPV4_GET_HLEN(p) != hlen)
++        goto error;
++    if (IPV4_GET_IPLEN(p) != hlen + content_len)
++        goto error;
++    if (IPV4_GET_IPID(p) != id)
++        goto error;
++    if (IPV4_GET_IPOFFSET(p) != off)
++        goto error;
++    if (IPV4_GET_MF(p) != mf)
++        goto error;
++    if (IPV4_GET_IPTTL(p) != ttl)
++        goto error;
++    if (IPV4_GET_IPPROTO(p) != proto)
++        goto error;
++
++    return p;
++error:
++    if (p != NULL)
++        SCFree(p);
++    return NULL;
++}
++
+ static Packet *BuildIpv6TestPacket(
+         uint8_t proto, uint32_t id, uint16_t off, int mf, const char content, int content_len)
+ {
+@@ -1270,6 +1370,71 @@ error:
+     return NULL;
+ }
+ 
++static Packet *BuildIpv6TestPacketWithContent(
++        uint8_t proto, uint32_t id, uint16_t off, int mf, const uint8_t *content, int content_len)
++{
++    Packet *p = NULL;
++    IPV6Hdr ip6h;
++
++    p = SCCalloc(1, sizeof(*p) + default_packet_size);
++    if (unlikely(p == NULL))
++        return NULL;
++
++    PacketInit(p);
++
++    struct timeval tval;
++    gettimeofday(&tval, NULL);
++    p->ts = SCTIME_FROM_TIMEVAL(&tval);
++
++    ip6h.s_ip6_nxt = 44;
++    ip6h.s_ip6_hlim = 2;
++
++    /* Source and dest address - very bogus addresses. */
++    ip6h.s_ip6_src[0] = 0x01010101;
++    ip6h.s_ip6_src[1] = 0x01010101;
++    ip6h.s_ip6_src[2] = 0x01010101;
++    ip6h.s_ip6_src[3] = 0x01010101;
++    ip6h.s_ip6_dst[0] = 0x02020202;
++    ip6h.s_ip6_dst[1] = 0x02020202;
++    ip6h.s_ip6_dst[2] = 0x02020202;
++    ip6h.s_ip6_dst[3] = 0x02020202;
++
++    /* copy content_len crap, we need full length */
++    PacketCopyData(p, (uint8_t *)&ip6h, sizeof(IPV6Hdr));
++
++    p->ip6h = (IPV6Hdr *)GET_PKT_DATA(p);
++    IPV6_SET_RAW_VER(p->ip6h, 6);
++    /* Fragmentation header. */
++    IPV6FragHdr *fh = (IPV6FragHdr *)(GET_PKT_DATA(p) + sizeof(IPV6Hdr));
++    fh->ip6fh_nxt = proto;
++    fh->ip6fh_ident = htonl(id);
++    fh->ip6fh_offlg = htons((off << 3) | mf);
++
++    DecodeIPV6FragHeader(p, (uint8_t *)fh, 8, 8 + content_len, 0);
++
++    PacketCopyDataOffset(p, sizeof(IPV6Hdr) + sizeof(IPV6FragHdr), content, content_len);
++    SET_PKT_LEN(p, sizeof(IPV6Hdr) + sizeof(IPV6FragHdr) + content_len);
++
++    p->ip6h->s_ip6_plen = htons(sizeof(IPV6FragHdr) + content_len);
++
++    SET_IPV6_SRC_ADDR(p, &p->src);
++    SET_IPV6_DST_ADDR(p, &p->dst);
++
++    /* Self test. */
++    if (IPV6_GET_VER(p) != 6)
++        goto error;
++    if (IPV6_GET_NH(p) != 44)
++        goto error;
++    if (IPV6_GET_PLEN(p) != sizeof(IPV6FragHdr) + content_len)
++        goto error;
++
++    return p;
++error:
++    if (p != NULL)
++        SCFree(p);
++    return NULL;
++}
++
+ /**
+  * Test the simplest possible re-assembly scenario.  All packet in
+  * order and no overlaps.
+@@ -1575,7 +1740,13 @@ static int DefragDoSturgesNovakTest(int policy, u_char *expected,
+     FAIL_IF(IPV4_GET_HLEN(reassembled) != 20);
+     FAIL_IF(IPV4_GET_IPLEN(reassembled) != 20 + 192);
+ 
+-    FAIL_IF(memcmp(GET_PKT_DATA(reassembled) + 20, expected, expected_len) != 0);
++    if (memcmp(expected, GET_PKT_DATA(reassembled) + 20, expected_len) != 0) {
++        printf("Expected:\n");
++        PrintRawDataFp(stdout, expected, expected_len);
++        printf("Got:\n");
++        PrintRawDataFp(stdout, GET_PKT_DATA(reassembled) + 20, GET_PKT_LEN(reassembled) - 20);
++        FAIL;
++    }
+     SCFree(reassembled);
+ 
+     /* Make sure all frags were returned back to the pool. */
+@@ -2543,6 +2714,16 @@ static int DefragTestJeremyLinux(void)
+     PASS;
+ }
+ 
++/**
++ * | 0        | 8        | 16       | 24       | 32       |
++ * |----------|----------|----------|----------|----------|
++ * |                                  AAAAAAAA | AAAAAAAA |
++ * |          | BBBBBBBB | BBBBBBBB |          |          |
++ * |          |          | CCCCCCCC | CCCCCCCC |          |
++ * | DDDDDDDD |          |          |          |          |
++ *
++ * | DDDDDDDD | BBBBBBBB | BBBBBBBB | CCCCCCCC | AAAAAAAA |
++ */
+ static int DefragBsdFragmentAfterNoMfIpv4Test(void)
+ {
+     DefragInit();
+@@ -2633,6 +2814,192 @@ static int DefragBsdFragmentAfterNoMfIpv6Test(void)
+     PASS;
+ }
+ 
++static int DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[4];
++
++    /* Packet 1: off=16, mf=1 */
++    packets[0] = BuildIpv4TestPacketWithContent(
++            IPPROTO_ICMP, 6, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
++
++    /* Packet 2: off=8, mf=1 */
++    packets[1] = BuildIpv4TestPacketWithContent(
++            IPPROTO_ICMP, 6, 8 >> 3, 1, (uint8_t *)"AACCBBDDAACCDDBB", 16);
++
++    /* Packet 3: off=0, mf=1: IP and ICMP header. */
++    packets[2] = BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 6, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
++
++    /* Packet 4: off=8, mf=1 */
++    packets[3] =
++            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 6, 32 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    const uint8_t expected[] = {
++	// AACCBBDD
++	// AACCDDBB
++	// AABBDDCC
++	// DDCCBBAA
++	'A', 'A', 'C', 'C', 'B', 'B', 'D', 'D',
++	'A', 'A', 'C', 'C', 'D', 'D', 'B', 'B',
++	'A', 'A', 'B', 'B', 'D', 'D', 'C', 'C',
++	'D', 'D', 'C', 'C', 'B', 'B', 'A', 'A',
++    };
++    // clang-format on
++
++    FAIL_IF(memcmp(expected, GET_PKT_DATA(r) + 20 + 8, sizeof(expected)) != 0);
++
++    DefragDestroy();
++    PASS;
++}
++
++static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[4];
++
++    /* Packet 1: off=16, mf=1 */
++    packets[0] = BuildIpv6TestPacketWithContent(
++            IPPROTO_ICMP, 6, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
++
++    /* Packet 2: off=8, mf=1 */
++    packets[1] = BuildIpv6TestPacketWithContent(
++            IPPROTO_ICMP, 6, 8 >> 3, 1, (uint8_t *)"AACCBBDDAACCDDBB", 16);
++
++    /* Packet 3: off=0, mf=1: IP and ICMP header. */
++    packets[2] = BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 6, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
++
++    /* Packet 4: off=8, mf=1 */
++    packets[3] =
++            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 6, 32 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    const uint8_t expected[] = {
++	// AACCBBDD
++	// AACCDDBB
++	// AABBDDCC
++	// DDCCBBAA
++	'A', 'A', 'C', 'C', 'B', 'B', 'D', 'D',
++	'A', 'A', 'C', 'C', 'D', 'D', 'B', 'B',
++	'A', 'A', 'B', 'B', 'D', 'D', 'C', 'C',
++	'D', 'D', 'C', 'C', 'B', 'B', 'A', 'A',
++    };
++    // clang-format on
++
++    FAIL_IF(memcmp(expected, GET_PKT_DATA(r) + 40 + 8, sizeof(expected)) != 0);
++
++    DefragDestroy();
++    PASS;
++}
++
++/**
++ * #### Input
++ *
++ * | 96 (0)   | 104 (8)  | 112 (16) | 120 (24) |
++ * |----------|----------|----------|----------|
++ * |          | EEEEEEEE | EEEEEEEE | EEEEEEEE |
++ * | MMMMMMMM | MMMMMMMM | MMMMMMMM |          |
++ *
++ * #### Expected Output
++ *
++ * | MMMMMMMM | MMMMMMMM | MMMMMMMM | EEEEEEEE |
++ */
++static int DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[2];
++
++    packets[0] = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 8 >> 3, 0, 'E', 24);
++    packets[1] = BuildIpv4TestPacket(IPPROTO_ICMP, 1, 0, 1, 'M', 24);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    const uint8_t expected[] = {
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E',
++    };
++    // clang-format on
++
++    if (memcmp(expected, GET_PKT_DATA(r) + 20, sizeof(expected)) != 0) {
++        printf("Expected:\n");
++        PrintRawDataFp(stdout, expected, sizeof(expected));
++        printf("Got:\n");
++        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
++        FAIL;
++    }
++
++    PASS;
++}
++
++static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[2];
++
++    packets[0] = BuildIpv6TestPacket(IPPROTO_ICMP, 1, 8 >> 3, 0, 'E', 24);
++    packets[1] = BuildIpv6TestPacket(IPPROTO_ICMP, 1, 0, 1, 'M', 24);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NULL(r);
++
++    // clang-format off
++    const uint8_t expected[] = {
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'M', 'M', 'M', 'M', 'M', 'M', 'M', 'M',
++	'E', 'E', 'E', 'E', 'E', 'E', 'E', 'E',
++    };
++    // clang-format on
++
++    if (memcmp(expected, GET_PKT_DATA(r) + 40, sizeof(expected)) != 0) {
++        printf("Expected:\n");
++        PrintRawDataFp(stdout, expected, sizeof(expected));
++        printf("Got:\n");
++        PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
++        FAIL;
++    }
++
++    PASS;
++}
++
+ #endif /* UNITTESTS */
+ 
+ void DefragRegisterTests(void)
+@@ -2675,5 +3042,11 @@ void DefragRegisterTests(void)
+ 
+     UtRegisterTest("DefragBsdFragmentAfterNoMfIpv4Test", DefragBsdFragmentAfterNoMfIpv4Test);
+     UtRegisterTest("DefragBsdFragmentAfterNoMfIpv6Test", DefragBsdFragmentAfterNoMfIpv6Test);
++    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test",
++            DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test);
++    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test",
++            DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test);
++    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2);
++    UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2);
+ #endif /* UNITTESTS */
+ }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2024-32867-004.patch b/recipes-ids/suricata/files/CVE-2024-32867-004.patch
new file mode 100644
index 0000000..7edb3b3
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-32867-004.patch
@@ -0,0 +1,169 @@
+From e6267758ed5da27f804f0c1c07f9423bdf4d72b8 Mon Sep 17 00:00:00 2001
+From: Jason Ish <jason.ish@oisf.net>
+Date: Fri, 12 Jan 2024 11:09:59 -0600
+Subject: [PATCH] defrag: fix check for complete packet
+
+The list of fragments may still contain overlaps, so adding up the
+fragment lengths is flawed. Instead track the largest size of
+contiguous data that can be re-assembled.
+
+Bug: #6675
+(cherry picked from commit d226d0a3fce8837936e1bdfaee496c80d417e0a5)
+
+CVE: CVE-2024-32867
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e6267758ed5da27f804f0c1c07f9423bdf4d72b8]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/defrag.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++-
+ 1 file changed, 114 insertions(+), 2 deletions(-)
+
+diff --git a/src/defrag.c b/src/defrag.c
+index 28d085d..fc46411 100644
+--- a/src/defrag.c
++++ b/src/defrag.c
+@@ -276,7 +276,8 @@ Defrag4Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+             goto done;
+         }
+         else {
+-            len += frag->data_len;
++            /* Update the packet length to the largest known data offset. */
++            len = MAX(len, frag->offset + frag->data_len);
+         }
+     }
+ 
+@@ -434,7 +435,7 @@ Defrag6Reassemble(ThreadVars *tv, DefragTracker *tracker, Packet *p)
+                 goto done;
+             }
+             else {
+-                len += frag->data_len;
++                len = MAX(len, frag->offset + frag->data_len);
+             }
+         }
+     }
+@@ -3000,6 +3001,115 @@ static int DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test(void)
+     PASS;
+ }
+ 
++/**
++ * Reassembly should fail.
++ *
++ * |0       |8       |16      |24      |32      |40      |48      |
++ * |========|========|========|========|========|========|========|
++ * |        |        |AABBCCDD|AABBDDCC|        |        |        |
++ * |        |        |        |        |        |AACCBBDD|        |
++ * |        |AACCDDBB|AADDBBCC|        |        |        |        |
++ * |ZZZZZZZZ|        |        |        |        |        |        |
++ * |        |        |        |        |        |        |DDCCBBAA|
++ */
++static int DefragBsdMissingFragmentIpv4Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[5];
++
++    packets[0] = BuildIpv4TestPacketWithContent(
++            IPPROTO_ICMP, 189, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
++
++    packets[1] =
++            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 40 >> 3, 1, (uint8_t *)"AACCBBDD", 8);
++
++    packets[2] = BuildIpv4TestPacketWithContent(
++            IPPROTO_ICMP, 189, 8 >> 3, 1, (uint8_t *)"AACCDDBBAADDBBCC", 16);
++
++    /* ICMP header. */
++    packets[3] = BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
++
++    packets[4] =
++            BuildIpv4TestPacketWithContent(IPPROTO_ICMP, 189, 48 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[4]);
++    FAIL_IF_NOT_NULL(r);
++
++#if 0
++    PrintRawDataFp(stdout, GET_PKT_DATA(r) + 20, GET_PKT_LEN(r) - 20);
++#endif
++
++    for (int i = 0; i < 5; i++) {
++        SCFree(packets[i]);
++    }
++
++    DefragDestroy();
++
++    PASS;
++}
++
++static int DefragBsdMissingFragmentIpv6Test(void)
++{
++    DefragInit();
++    default_policy = DEFRAG_POLICY_BSD;
++    Packet *packets[5];
++
++    packets[0] = BuildIpv6TestPacketWithContent(
++            IPPROTO_ICMP, 189, 16 >> 3, 1, (uint8_t *)"AABBCCDDAABBDDCC", 16);
++
++    packets[1] =
++            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 40 >> 3, 1, (uint8_t *)"AACCBBDD", 8);
++
++    packets[2] = BuildIpv6TestPacketWithContent(
++            IPPROTO_ICMP, 189, 8 >> 3, 1, (uint8_t *)"AACCDDBBAADDBBCC", 16);
++
++    /* ICMP header. */
++    packets[3] = BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 0, 1, (uint8_t *)"ZZZZZZZZ", 8);
++
++    packets[4] =
++            BuildIpv6TestPacketWithContent(IPPROTO_ICMP, 189, 48 >> 3, 0, (uint8_t *)"DDCCBBAA", 8);
++
++    Packet *r = Defrag(NULL, NULL, packets[0]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[1]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[2]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[3]);
++    FAIL_IF_NOT_NULL(r);
++
++    r = Defrag(NULL, NULL, packets[4]);
++    FAIL_IF_NOT_NULL(r);
++
++#if 0
++    PrintRawDataFp(stdout, GET_PKT_DATA(r) + 40, GET_PKT_LEN(r) - 40);
++#endif
++
++    for (int i = 0; i < 5; i++) {
++        SCFree(packets[i]);
++    }
++
++    DefragDestroy();
++
++    PASS;
++}
++
+ #endif /* UNITTESTS */
+ 
+ void DefragRegisterTests(void)
+@@ -3048,5 +3158,7 @@ void DefragRegisterTests(void)
+             DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test);
+     UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv4Test_2);
+     UtRegisterTest("DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2", DefragBsdSubsequentOverlapsStartOfOriginalIpv6Test_2);
++    UtRegisterTest("DefragBsdMissingFragmentIpv4Test", DefragBsdMissingFragmentIpv4Test);
++    UtRegisterTest("DefragBsdMissingFragmentIpv6Test", DefragBsdMissingFragmentIpv6Test);
+ #endif /* UNITTESTS */
+ }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 9618c45..4a1857e 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -24,6 +24,13 @@ SRC_URI += " \
     file://CVE-2025-29916-03.patch \
     file://CVE-2025-29917.patch \
     file://CVE-2025-29918.patch \
+    file://CVE-2024-32663-001.patch \
+    file://CVE-2024-32663-002.patch \
+    file://CVE-2024-32664.patch \
+    file://CVE-2024-32867-001.patch \
+    file://CVE-2024-32867-002.patch \
+    file://CVE-2024-32867-003.patch \
+    file://CVE-2024-32867-004.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.50.1


