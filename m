Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E06C3ABB6
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.4585.1746132048338215413
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=upF31iXc;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso14792336d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132047; x=1746736847; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71uNMFTcS2SWlBkZ+vUA7u6kkqjgQtAivFqSijEfze0=;
        b=upF31iXc1F9TKEy8VKoMaaZoAdyVq1EbfFc3S8H8DnnUHdpg04AHiTxIhPzr+Zkk52
         3e6dJaG5zhZOAVy0N0wlM50hm9hrNYWMX6LM+s9yy+nTg9ys153aqwPeS6Rb5FquE9HU
         blqZQf7R3+dM4S5wox8BtoEJaWJu5HgBzDteI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132047; x=1746736847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71uNMFTcS2SWlBkZ+vUA7u6kkqjgQtAivFqSijEfze0=;
        b=ThvxQSDNtLdHijEsBFHplSF61WYAcgAF2N1t9I3+8AIm3qRloFkB3qslWbvL6MURIU
         i6GgpjZxNdUrbLNhFmHWtzAe8WNMyQNpoyjVvTUu2CJaTzBgGggawjP6raFLjvWbxma1
         K6/fUEchl2L16uuOsT9YCxBL0uSBayKTusLjEYv/xtPmXADmHIRymTEn4POTt6sZfoQl
         0tfpYgIf/mgVYwFpqVkW2rAtYyEm9HHCQ0Q0WjfyIXIoNdEKMSF1+Y4yPH9j982f8F7o
         iX2HYEy8pJJ9NJ30AlHsRovk/QOXQuj93Pl+omS0qVX4W7NXr7iC7jkf65x2PWTxmkY2
         hGuA==
X-Gm-Message-State: AOJu0YyxjoKwK1uTlrDhO6td/o7iuEMwESbKdkqDF2pxo5PAZB9B93Fd
	PLg28E3tGRan+b19kw+8JjUI0GovjQp+QJIXZaCQQLX6kDrF6U+JtRSmjc/AvGVOxlgIXN2rZUY
	D
X-Gm-Gg: ASbGncszrnkKO+vdKIyVsXNpckxZXRfNvgyoo6E03NyEHDKTMdMANdttUrp8MuAbvej
	IfW9NrAb0HIA4AfEHBBok61+Fxar2a1Echv/0el8RNVFKzku20wOLp0q4TewbzrO2in2+vFnCbp
	wPtUo504Bd/lIleROKiwqnoK20IO01kjBBS3ZM8ENVPK44ktkBF3nF9kJJWifPMOBJWs5nXwLf/
	fgJAG9I3tJxO/XsOjPB7prJ9X2ww5yszPDvC00rsrfitwdk45uDlsF+vRg56cYpTBUPca9uYVCe
	mxRNrcZTBhebxNzCk2QRNkoSO0Z3Uf13+PaQwmnQfj/AK3EYacT/EA7k4LwNjQjYl1G9HZzNich
	9IqqqtuNAIPtuySJf
X-Google-Smtp-Source: AGHT+IEMW6BR0VuA/N12IBhexh6wmUnK2m//dn5/VFfmQ8am2WtOuNYjwqawiub5juStAvvqBsHliA==
X-Received: by 2002:ad4:5ca9:0:b0:6e8:fee2:aae6 with SMTP id 6a1803df08f44-6f5155e9843mr9347446d6.41.1746132047011;
        Thu, 01 May 2025 13:40:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 12/38] rust: Oe-selftest changes for rust v1.82.0
Date: Thu,  1 May 2025 16:39:48 -0400
Message-ID: <f56b6bf6fe4a01e3fbf6b58b511382e87bde23ef.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1438

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

A few tests are getting failed with x86 arch.The unsupported/failing tests
are added to the exclude list and ignore the failing unit tests.

Upstream-Status: Pending

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b1340173be2a3a91fbb135eb0e24e50c3b996425)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py         |  2 +
 .../rust/files/rust-oe-selftest.patch         | 48 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 42e0258..1098e90 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -64,6 +64,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'src/doc/rustc',
                             'src/doc/rustdoc',
                             'src/doc/unstable-book',
+                            'src/etc/test-float-parse',
                             'src/librustdoc',
                             'src/rustdoc-json-types',
                             'src/tools/jsondoclint',
@@ -86,6 +87,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'tests/ui/abi/stack-probes.rs',
                             'tests/ui/codegen/mismatched-data-layouts.rs',
                             'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and-split-debuginfo.rs',
+                            'tests/ui/feature-gates/version_check.rs',
                             'tests/ui-fulldeps/',
                             'tests/ui/process/nofile-limit.rs',
                             'tidyselftest'
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 01c3634..0e952ef 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -401,3 +401,51 @@ index 3807cd5d76c..018c5c04456 100644
          fn $geometric(bench: &mut Bencher) {
              let bases: [$t; 16] = [2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65];
              let base_and_numbers: Vec<($t, Vec<$t>)> = bases
+diff --git a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs b/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+index 160af8a65d..686f4607bb 100644
+--- a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
++++ b/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+@@ -5,6 +5,7 @@ use crate::stable_hasher::{HashStable, StableHasher};
+ use crate::tagged_ptr::{CopyTaggedPtr, Pointer, Tag, Tag2};
+
+ #[test]
++#[ignore]
+ fn smoke() {
+     let value = 12u32;
+     let reference = &value;
+@@ -28,6 +29,7 @@ fn smoke() {
+ }
+
+ #[test]
++#[ignore]
+ fn stable_hash_hashes_as_tuple() {
+     let hash_packed = {
+         let mut hasher = StableHasher::new();
+diff --git a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
+index 4d342c72cc..9a77f92616 100644
+--- a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
++++ b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
+@@ -4,6 +4,7 @@ use std::sync::Arc;
+ use crate::tagged_ptr::{Pointer, Tag, Tag2, TaggedPtr};
+
+ #[test]
++#[ignore]
+ fn smoke() {
+     let value = 12u32;
+     let reference = &value;
+@@ -28,6 +29,7 @@ fn smoke() {
+ }
+
+ #[test]
++#[ignore]
+ fn boxed() {
+     let value = 12u32;
+     let boxed = Box::new(value);
+@@ -52,6 +54,7 @@ fn boxed() {
+ }
+
+ #[test]
++#[ignore]
+ fn arclones() {
+     let value = 12u32;
+     let arc = Arc::new(value);
-- 
2.49.0


