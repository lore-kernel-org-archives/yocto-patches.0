Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C586C3271E
	for <webhook@archiver.kernel.org>; Thu, 11 Jul 2024 04:36:18 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.4762.1720672577153386679
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jul 2024 21:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=HqEbGJA7;
 spf=pass (domain: mvista.com, ip: 209.85.219.179, mailfrom: hprajapati@mvista.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso505056276.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1720672576; x=1721277376; darn=lists.yoctoproject.org;
        h=in-reply-to:from:cc:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIWR6Td3ettBhc2m4vUHtZAPXxxd8eubZT59LfbCe1Q=;
        b=HqEbGJA7MK+qNNNZasOKqV0WRBDydREs4bdTmoq9L2Ssmbq0zQIMGlOppSKOgNQv4Q
         eewa07b/i82n2t3kfCRb2cT/DXeEdTex1DUxk1tZFMcNicrihslNFIxy4XjhYl9CM7f8
         geyKmilsY/aXH2UlKLGuZg7ntIhVEnPRSdMGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720672576; x=1721277376;
        h=in-reply-to:from:cc:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIWR6Td3ettBhc2m4vUHtZAPXxxd8eubZT59LfbCe1Q=;
        b=tisiI3AJ0P6QKK/gfVi92ZN0zYSpMzJgsSZ6I/bm00oTg1bCoX/sGaM8Wa4npgLJ4N
         tuO88FRtxj/89B5gsxWShnlokFhWK5JOW/sOAN28+5fZq4Wwq/D/4Aie4yJuDvwF3fNN
         ACNkCO6bid2j5Gn6y/eZQACiOyOulObYQDrb2XYoxNr811NJzSjtdqfFJtOdqX1FHyxw
         Gy1wBjm/hWoa5xbPJXdqoYswuI4W/jKUgO3/GF1333groKmq/VfN4SnoO3cwqxH80kax
         niCzKfpGrSmh4nzvWX/SDklDE82uegTq8AN8f6KgIYH2+uVPdQXF0Ebp0ITgJtLgR7dN
         z0hQ==
X-Gm-Message-State: AOJu0YyeFCCFZr1ybFG2O+1DWyEcG14O6tBl4rBPrkxRdFSPAI+RnVXZ
	uxrA9+sHzRXhhwKcxnbgzrH97WF+ghhe7sRrqZ1gzLLRdh7Wv7Fz/PEOT9oqv+nbFEEkTjAuob7
	r
X-Google-Smtp-Source: AGHT+IFe6Xp0gA7bRZHbpr8sVoC2dwJq1A/YfiNS+bcTcVOx6Ip09DhfUMkOGsfcC6fnHbqbtdnKOw==
X-Received: by 2002:a25:9781:0:b0:e02:b9ac:1486 with SMTP id 3f1490d57ef6-e041b1d6215mr8064327276.57.1720672575725;
        Wed, 10 Jul 2024 21:36:15 -0700 (PDT)
Received: from [192.168.0.102] ([103.250.136.191])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a902531sm840649276.35.2024.07.10.21.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 21:36:15 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------7WLfVxn0jzIaGzVsJPc02c0d"
Message-ID: <3998e572-f752-45ab-9d9a-8c985b4052d1@mvista.com>
Date: Thu, 11 Jul 2024 10:06:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-java, master][PATCH] openjdk-8: Fix multiple CVEs
To: yocto-patches@lists.yoctoproject.org
References: <20240701115411.15574-1-hprajapati@mvista.com>
Content-Language: en-US
Cc: Hitendra Prajapati <hprajapati@mvista.com>
From: Hitendra Prajapati <hprajapati@mvista.com>
In-Reply-To: <20240701115411.15574-1-hprajapati@mvista.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jul 2024 04:36:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/423

This is a multi-part message in MIME format.
--------------7WLfVxn0jzIaGzVsJPc02c0d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Team,

Any Update on this issue ?

Regards,

Hitendra

On 01/07/24 5:24 pm, Hitendra Prajapati wrote:
> Backport fixes for:
>
> * CVE-2022-40433 - Upstream-Status: Backport fromhttps://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04
> * CVE-2024-20919 - Upstream-Status: Backport fromhttps://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215
> * CVE-2024-20921 - Upstream-Status: Backport fromhttps://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436
>
> Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> ---
>   .../openjdk/openjdk-8-release-common.inc      |   3 +
>   .../patches-openjdk-8/CVE-2022-40433.patch    | 233 +++++++
>   .../patches-openjdk-8/CVE-2024-20919.patch    | 126 ++++
>   .../patches-openjdk-8/CVE-2024-20921.patch    | 657 ++++++++++++++++++
>   4 files changed, 1019 insertions(+)
>   create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
>   create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
>   create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch
>
> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipes-core/openjdk/openjdk-8-release-common.inc
> index ff8d96e..985d0d7 100644
> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
> @@ -21,6 +21,9 @@ PATCHES_URI = "\
>       file://2007-jdk-no-genx11-in-headless.patch  \
>       file://2008-jdk-no-unused-deps.patch  \
>       file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch  \
> +file://CVE-2022-40433.patch  \
> +file://CVE-2024-20919.patch  \
> +file://CVE-2024-20921.patch  \
>   "
>   HOTSPOT_UB_PATCH = "\
>       file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch  \
> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
> new file mode 100644
> index 0000000..fcae4f4
> --- /dev/null
> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
> @@ -0,0 +1,233 @@
> +From 961ab463974b7d05600b826303f9111c4f367a04 Mon Sep 17 00:00:00 2001
> +From: =?UTF-8?q?Ji=C5=99=C3=AD=20Van=C4=9Bk?=<jvanek@openjdk.org>
> +Date: Mon, 25 Sep 2023 14:05:03 +0000
> +Subject: [PATCH] 8283441: C2: segmentation fault in
> + ciMethodBlocks::make_block_at(int)
> +
> +Reviewed-by: mbalao
> +Backport-of: 947869609ce6b74d4d28f79724b823d8781adbed
> +
> +Upstream-Status: Backport [https://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04]
> +CVE: CVE-2022-40433
> +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> +---
> + hotspot/src/share/vm/c1/c1_GraphBuilder.cpp   | 12 ++++--
> + hotspot/src/share/vm/ci/ciMethodBlocks.cpp    | 17 +++++---
> + .../src/share/vm/compiler/methodLiveness.cpp  |  9 ++--
> + hotspot/test/compiler/parsing/Custom.jasm     | 38 +++++++++++++++++
> + ...UnreachableBlockFallsThroughEndOfCode.java | 42 +++++++++++++++++++
> + 5 files changed, 106 insertions(+), 12 deletions(-)
> + create mode 100644 hotspot/test/compiler/parsing/Custom.jasm
> + create mode 100644 hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
> +
> +diff --git a/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp b/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
> +index 99f1c510..6e3e4cc4 100644
> +--- a/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
> ++++ b/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
> +@@ -206,8 +206,10 @@ void BlockListBuilder::handle_exceptions(BlockBegin* current, int cur_bci) {
> + }
> +
> + void BlockListBuilder::handle_jsr(BlockBegin* current, int sr_bci, int next_bci) {
> +-  // start a new block after jsr-bytecode and link this block into cfg
> +-  make_block_at(next_bci, current);
> ++  if (next_bci < method()->code_size()) {
> ++    // start a new block after jsr-bytecode and link this block into cfg
> ++    make_block_at(next_bci, current);
> ++  }
> +
> +   // start a new block at the subroutine entry at mark it with special flag
> +   BlockBegin* sr_block = make_block_at(sr_bci, current);
> +@@ -227,6 +229,8 @@ void BlockListBuilder::set_leaders() {
> +   // branch target and a modification of the successor lists.
> +   BitMap bci_block_start = method()->bci_block_start();
> +
> ++  int end_bci = method()->code_size();
> ++
> +   ciBytecodeStream s(method());
> +   while (s.next() != ciBytecodeStream::EOBC()) {
> +     int cur_bci = s.cur_bci();
> +@@ -297,7 +301,9 @@ void BlockListBuilder::set_leaders() {
> +       case Bytecodes::_if_acmpne: // fall through
> +       case Bytecodes::_ifnull:    // fall through
> +       case Bytecodes::_ifnonnull:
> +-        make_block_at(s.next_bci(), current);
> ++        if (s.next_bci() < end_bci) {
> ++          make_block_at(s.next_bci(), current);
> ++        }
> +         make_block_at(s.get_dest(), current);
> +         current = NULL;
> +         break;
> +diff --git a/hotspot/src/share/vm/ci/ciMethodBlocks.cpp b/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
> +index 614e75dc..2285eb0a 100644
> +--- a/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
> ++++ b/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
> +@@ -1,5 +1,5 @@
> + /*
> +- * Copyright (c) 2006, 2011, Oracle and/or its affiliates. All rights reserved.
> ++ * Copyright (c) 2006, 2022, Oracle and/or its affiliates. All rights reserved.
> +  * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> +  *
> +  * This code is free software; you can redistribute it and/or modify it
> +@@ -33,12 +33,13 @@
> +
> +
> + ciBlock *ciMethodBlocks::block_containing(int bci) {
> ++  assert(bci >= 0 && bci < _code_size, "valid bytecode range");
> +   ciBlock *blk = _bci_to_block[bci];
> +   return blk;
> + }
> +
> + bool ciMethodBlocks::is_block_start(int bci) {
> +-  assert(bci >=0 && bci < _code_size, "valid bytecode range");
> ++  assert(bci >= 0 && bci < _code_size, "valid bytecode range");
> +   ciBlock *b = _bci_to_block[bci];
> +   assert(b != NULL, "must have block for bytecode");
> +   return b->start_bci() == bci;
> +@@ -146,7 +147,9 @@ void ciMethodBlocks::do_analysis() {
> +       case Bytecodes::_ifnonnull   :
> +       {
> +         cur_block->set_control_bci(bci);
> +-        ciBlock *fall_through = make_block_at(s.next_bci());
> ++        if (s.next_bci() < limit_bci) {
> ++          ciBlock *fall_through = make_block_at(s.next_bci());
> ++        }
> +         int dest_bci = s.get_dest();
> +         ciBlock *dest = make_block_at(dest_bci);
> +         break;
> +@@ -166,7 +169,9 @@ void ciMethodBlocks::do_analysis() {
> +       case Bytecodes::_jsr         :
> +       {
> +         cur_block->set_control_bci(bci);
> +-        ciBlock *ret = make_block_at(s.next_bci());
> ++        if (s.next_bci() < limit_bci) {
> ++          ciBlock *ret = make_block_at(s.next_bci());
> ++        }
> +         int dest_bci = s.get_dest();
> +         ciBlock *dest = make_block_at(dest_bci);
> +         break;
> +@@ -224,7 +229,9 @@ void ciMethodBlocks::do_analysis() {
> +       case Bytecodes::_jsr_w       :
> +       {
> +         cur_block->set_control_bci(bci);
> +-        ciBlock *ret = make_block_at(s.next_bci());
> ++        if (s.next_bci() < limit_bci) {
> ++          ciBlock *ret = make_block_at(s.next_bci());
> ++        }
> +         int dest_bci = s.get_far_dest();
> +         ciBlock *dest = make_block_at(dest_bci);
> +         break;
> +diff --git a/hotspot/src/share/vm/compiler/methodLiveness.cpp b/hotspot/src/share/vm/compiler/methodLiveness.cpp
> +index eda1ab15..7fb496dc 100644
> +--- a/hotspot/src/share/vm/compiler/methodLiveness.cpp
> ++++ b/hotspot/src/share/vm/compiler/methodLiveness.cpp
> +@@ -268,10 +268,11 @@ void MethodLiveness::init_basic_blocks() {
> +       case Bytecodes::_ifnull:
> +       case Bytecodes::_ifnonnull:
> +         // Two way branch.  Set predecessors at each destination.
> +-        dest = _block_map->at(bytes.next_bci());
> +-        assert(dest != NULL, "must be a block immediately following this one.");
> +-        dest->add_normal_predecessor(current_block);
> +-
> ++        if (bytes.next_bci() < method_len) {
> ++          dest = _block_map->at(bytes.next_bci());
> ++          assert(dest != NULL, "must be a block immediately following this one.");
> ++          dest->add_normal_predecessor(current_block);
> ++        }
> +         dest = _block_map->at(bytes.get_dest());
> +         assert(dest != NULL, "branch desination must start a block.");
> +         dest->add_normal_predecessor(current_block);
> +diff --git a/hotspot/test/compiler/parsing/Custom.jasm b/hotspot/test/compiler/parsing/Custom.jasm
> +new file mode 100644
> +index 00000000..73a2b1ff
> +--- /dev/null
> ++++ b/hotspot/test/compiler/parsing/Custom.jasm
> +@@ -0,0 +1,38 @@
> ++/*
> ++ * Copyright (c) 2022, Oracle and/or its affiliates. All rights reserved.
> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> ++ *
> ++ * This code is free software; you can redistribute it and/or modify it
> ++ * under the terms of the GNU General Public License version 2 only, as
> ++ * published by the Free Software Foundation.
> ++ *
> ++ * This code is distributed in the hope that it will be useful, but WITHOUT
> ++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> ++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> ++ * version 2 for more details (a copy is included in the LICENSE file that
> ++ * accompanied this code).
> ++ *
> ++ * You should have received a copy of the GNU General Public License version
> ++ * 2 along with this work; if not, write to the Free Software Foundation,
> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> ++ *
> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
> ++ * or visitwww.oracle.com  if you need additional information or have any
> ++ * questions.
> ++ */
> ++
> ++package compiler/parsing;
> ++
> ++super public class Custom {
> ++
> ++    public static Method test:"(I)V" stack 2 locals 1 {
> ++        return;
> ++Loop:
> ++        // Unreachable block
> ++        iload_0;
> ++        bipush        100;
> ++        if_icmpge     Loop;
> ++        // Falls through
> ++    }
> ++
> ++}
> +diff --git a/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java b/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
> +new file mode 100644
> +index 00000000..9dfb488d
> +--- /dev/null
> ++++ b/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
> +@@ -0,0 +1,42 @@
> ++/*
> ++ * Copyright (c) 2022, Oracle and/or its affiliates. All rights reserved.
> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> ++ *
> ++ * This code is free software; you can redistribute it and/or modify it
> ++ * under the terms of the GNU General Public License version 2 only, as
> ++ * published by the Free Software Foundation.
> ++ *
> ++ * This code is distributed in the hope that it will be useful, but WITHOUT
> ++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> ++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> ++ * version 2 for more details (a copy is included in the LICENSE file that
> ++ * accompanied this code).
> ++ *
> ++ * You should have received a copy of the GNU General Public License version
> ++ * 2 along with this work; if not, write to the Free Software Foundation,
> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> ++ *
> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
> ++ * or visitwww.oracle.com  if you need additional information or have any
> ++ * questions.
> ++ *
> ++ */
> ++
> ++/*
> ++ * @test UnreachableBlockFallsThroughEndOfCode.java
> ++ * @bug 8283441
> ++ * @compile Custom.jasm UnreachableBlockFallsThroughEndOfCode.java
> ++ * @summary Compiling method that falls off the end of the code array
> ++ * @run main/othervm -XX:TieredStopAtLevel=1 -Xbatch compiler.parsing.UnreachableBlockFallsThroughEndOfCode
> ++ * @run main/othervm -XX:-TieredCompilation -Xbatch compiler.parsing.UnreachableBlockFallsThroughEndOfCode
> ++ */
> ++
> ++package compiler.parsing;
> ++
> ++public class UnreachableBlockFallsThroughEndOfCode {
> ++    public static void main(String[] strArr) {
> ++        for (int i = 0; i < 20000; i++) {
> ++            Custom.test(i);
> ++        }
> ++    }
> ++}
> +--
> +2.25.1
> +
> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
> new file mode 100644
> index 0000000..a3fc8b6
> --- /dev/null
> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
> @@ -0,0 +1,126 @@
> +From 77d38b78e4993381ddb113d012b30ab2d7cd9215 Mon Sep 17 00:00:00 2001
> +From: Martin Balao<mbalao@openjdk.org>
> +Date: Fri, 29 Sep 2023 13:01:13 +0000
> +Subject: [PATCH] 8314295: Enhance verification of verifier
> +
> +Reviewed-by: yan, andrew
> +Backport-of: 08980a0a60bc48c17eacd57fd2d7065ac2d986a8
> +
> +Upstream-Status: Backport [https://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215]
> +CVE: CVE-2024-20919
> +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> +---
> + hotspot/src/share/vm/classfile/verifier.cpp   |  5 +++--
> + .../src/share/vm/interpreter/bytecodes.cpp    | 22 ++++++++++++++-----
> + jdk/src/share/native/common/check_code.c      | 11 ++++++----
> + 3 files changed, 26 insertions(+), 12 deletions(-)
> +
> +diff --git a/hotspot/src/share/vm/classfile/verifier.cpp b/hotspot/src/share/vm/classfile/verifier.cpp
> +index 2a572058..3a3e04ba 100644
> +--- a/hotspot/src/share/vm/classfile/verifier.cpp
> ++++ b/hotspot/src/share/vm/classfile/verifier.cpp
> +@@ -2078,11 +2078,12 @@ void ClassVerifier::verify_switch(
> +           "low must be less than or equal to high in tableswitch");
> +       return;
> +     }
> +-    keys = high - low + 1;
> +-    if (keys < 0) {
> ++    int64_t keys64 = ((int64_t)high - low) + 1;
> ++    if (keys64 > 65535) {  // Max code length
> +       verify_error(ErrorContext::bad_code(bci), "too many keys in tableswitch");
> +       return;
> +     }
> ++    keys = (int)keys64;
> +     delta = 1;
> +   } else {
> +     keys = (int)Bytes::get_Java_u4(aligned_bcp + jintSize);
> +diff --git a/hotspot/src/share/vm/interpreter/bytecodes.cpp b/hotspot/src/share/vm/interpreter/bytecodes.cpp
> +index 24adc4d9..f0753735 100644
> +--- a/hotspot/src/share/vm/interpreter/bytecodes.cpp
> ++++ b/hotspot/src/share/vm/interpreter/bytecodes.cpp
> +@@ -111,12 +111,18 @@ int Bytecodes::special_length_at(Bytecodes::Code code, address bcp, address end)
> +       if (end != NULL && aligned_bcp + 3*jintSize >= end) {
> +         return -1; // don't read past end of code buffer
> +       }
> ++      // Promote calculation to signed 64 bits to do range checks, used by the verifier.
> +       jlong lo = (jint)Bytes::get_Java_u4(aligned_bcp + 1*jintSize);
> +       jlong hi = (jint)Bytes::get_Java_u4(aligned_bcp + 2*jintSize);
> +       jlong len = (aligned_bcp - bcp) + (3 + hi - lo + 1)*jintSize;
> +-      // only return len if it can be represented as a positive int;
> +-      // return -1 otherwise
> +-      return (len > 0 && len == (int)len) ? len : -1;
> ++      // Only return len if it can be represented as a positive int and lo <= hi.
> ++      // The caller checks for bytecode stream overflow.
> ++      if (lo <= hi && len == (int)len) {
> ++        assert(len > 0, "must be");
> ++        return (int)len;
> ++      } else {
> ++        return -1;
> ++      }
> +     }
> +
> +   case _lookupswitch:      // fall through
> +@@ -128,9 +134,13 @@ int Bytecodes::special_length_at(Bytecodes::Code code, address bcp, address end)
> +       }
> +       jlong npairs = (jint)Bytes::get_Java_u4(aligned_bcp + jintSize);
> +       jlong len = (aligned_bcp - bcp) + (2 + 2*npairs)*jintSize;
> +-      // only return len if it can be represented as a positive int;
> +-      // return -1 otherwise
> +-      return (len > 0 && len == (int)len) ? len : -1;
> ++      // Only return len if it can be represented as a positive int and npairs >= 0.
> ++      if (npairs >= 0 && len == (int)len) {
> ++        assert(len > 0, "must be");
> ++        return (int)len;
> ++      } else {
> ++        return -1;
> ++      }
> +     }
> +   }
> +   // Note: Length functions must return <=0 for invalid bytecodes.
> +diff --git a/jdk/src/share/native/common/check_code.c b/jdk/src/share/native/common/check_code.c
> +index 96091720..491b95cd 100644
> +--- a/jdk/src/share/native/common/check_code.c
> ++++ b/jdk/src/share/native/common/check_code.c
> +@@ -1,5 +1,5 @@
> + /*
> +- * Copyright (c) 1994, 2014, Oracle and/or its affiliates. All rights reserved.
> ++ * Copyright (c) 1994, 2023, Oracle and/or its affiliates. All rights reserved.
> +  * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> +  *
> +  * This code is free software; you can redistribute it and/or modify it
> +@@ -84,6 +84,7 @@
> + #include <assert.h>
> + #include <limits.h>
> + #include <stdlib.h>
> ++#include <stdint.h>
> +
> + #include "jni.h"
> + #include "jvm.h"
> +@@ -1202,7 +1203,7 @@ verify_opcode_operands(context_type *context, unsigned int inumber, int offset)
> +             }
> +         }
> +         if (opcode == JVM_OPC_tableswitch) {
> +-            keys = _ck_ntohl(lpc[2]) -  _ck_ntohl(lpc[1]) + 1;
> ++            keys = _ck_ntohl(lpc[2]) - _ck_ntohl(lpc[1]) + 1;
> +             delta = 1;
> +         } else {
> +             keys = _ck_ntohl(lpc[1]); /* number of pairs */
> +@@ -1682,11 +1683,13 @@ static int instruction_length(unsigned char *iptr, unsigned char *end)
> +     switch (instruction) {
> +         case JVM_OPC_tableswitch: {
> +             int *lpc = (int *)UCALIGN(iptr + 1);
> +-            int index;
> +             if (lpc + 2 >= (int *)end) {
> +                 return -1; /* do not read pass the end */
> +             }
> +-            index = _ck_ntohl(lpc[2]) - _ck_ntohl(lpc[1]);
> ++            int64_t low  = _ck_ntohl(lpc[1]);
> ++            int64_t high = _ck_ntohl(lpc[2]);
> ++            int64_t index = high - low;
> ++            // The value of low must be less than or equal to high - i.e. index >= 0
> +             if ((index < 0) || (index > 65535)) {
> +                 return -1;      /* illegal */
> +             } else {
> +--
> +2.25.1
> +
> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch
> new file mode 100644
> index 0000000..edce6f0
> --- /dev/null
> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch
> @@ -0,0 +1,657 @@
> +From f7cb28de01117f598ecf48ad58e277c3a4590436 Mon Sep 17 00:00:00 2001
> +From: Roland Westrelin<rwestrel@redhat.com>
> +Date: Tue, 7 Nov 2023 11:08:30 +0000
> +Subject: [PATCH] 8314307: Improve loop handling
> +
> +Reviewed-by: mbalao, fferrari, andrew
> +Backport-of: 62ac93d145ca9fa1ab0c040533c62c42c202703a
> +
> +Upstream-Status: Backport [https://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436]
> +CVE: CVE-2024-20921
> +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> +---
> + hotspot/src/share/vm/opto/ifnode.cpp   |  59 +++-
> + hotspot/src/share/vm/opto/loopnode.cpp | 422 ++++++++++++++++++++-----
> + hotspot/src/share/vm/opto/loopnode.hpp |   4 +
> + hotspot/src/share/vm/opto/phaseX.hpp   |   6 +-
> + 4 files changed, 404 insertions(+), 87 deletions(-)
> +
> +diff --git a/hotspot/src/share/vm/opto/ifnode.cpp b/hotspot/src/share/vm/opto/ifnode.cpp
> +index 68f068d0..51579032 100644
> +--- a/hotspot/src/share/vm/opto/ifnode.cpp
> ++++ b/hotspot/src/share/vm/opto/ifnode.cpp
> +@@ -882,6 +882,46 @@ Node *IfNode::Ideal(PhaseGVN *phase, bool can_reshape) {
> +     // then we are guaranteed to fail, so just start interpreting there.
> +     // We 'expand' the top 3 range checks to include all post-dominating
> +     // checks.
> ++    //
> ++    // Example:
> ++    // a[i+x] // (1) 1 < x < 6
> ++    // a[i+3] // (2)
> ++    // a[i+4] // (3)
> ++    // a[i+6] // max = max of all constants
> ++    // a[i+2]
> ++    // a[i+1] // min = min of all constants
> ++    //
> ++    // If x < 3:
> ++    //   (1) a[i+x]: Leave unchanged
> ++    //   (2) a[i+3]: Replace with a[i+max] = a[i+6]: i+x < i+3 <= i+6  -> (2) is covered
> ++    //   (3) a[i+4]: Replace with a[i+min] = a[i+1]: i+1 < i+4 <= i+6  -> (3) and all following checks are covered
> ++    //   Remove all other a[i+c] checks
> ++    //
> ++    // If x >= 3:
> ++    //   (1) a[i+x]: Leave unchanged
> ++    //   (2) a[i+3]: Replace with a[i+min] = a[i+1]: i+1 < i+3 <= i+x  -> (2) is covered
> ++    //   (3) a[i+4]: Replace with a[i+max] = a[i+6]: i+1 < i+4 <= i+6  -> (3) and all following checks are covered
> ++    //   Remove all other a[i+c] checks
> ++    //
> ++    // We only need the top 2 range checks if x is the min or max of all constants.
> ++    //
> ++    // This, however, only works if the interval [i+min,i+max] is not larger than max_int (i.e. abs(max - min) < max_int):
> ++    // The theoretical max size of an array is max_int with:
> ++    // - Valid index space: [0,max_int-1]
> ++    // - Invalid index space: [max_int,-1] // max_int, min_int, min_int - 1 ..., -1
> ++    //
> ++    // The size of the consecutive valid index space is smaller than the size of the consecutive invalid index space.
> ++    // If we choose min and max in such a way that:
> ++    // - abs(max - min) < max_int
> ++    // - i+max and i+min are inside the valid index space
> ++    // then all indices [i+min,i+max] must be in the valid index space. Otherwise, the invalid index space must be
> ++    // smaller than the valid index space which is never the case for any array size.
> ++    //
> ++    // Choosing a smaller array size only makes the valid index space smaller and the invalid index space larger and
> ++    // the argument above still holds.
> ++    //
> ++    // Note that the same optimization with the same maximal accepted interval size can also be found in C1.
> ++    const jlong maximum_number_of_min_max_interval_indices = (jlong)max_jint;
> +
> +     // The top 3 range checks seen
> +     const int NRC =3;
> +@@ -915,13 +955,18 @@ Node *IfNode::Ideal(PhaseGVN *phase, bool can_reshape) {
> +             found_immediate_dominator = true;
> +             break;
> +           }
> +-          // Gather expanded bounds
> +-          off_lo = MIN2(off_lo,offset2);
> +-          off_hi = MAX2(off_hi,offset2);
> +-          // Record top NRC range checks
> +-          prev_checks[nb_checks%NRC].ctl = prev_dom;
> +-          prev_checks[nb_checks%NRC].off = offset2;
> +-          nb_checks++;
> ++
> ++          // "x - y" -> must add one to the difference for number of elements in [x,y]
> ++          const jlong diff = (jlong)MIN2(offset2, off_lo) - (jlong)MAX2(offset2, off_hi);
> ++          if (ABS(diff) < maximum_number_of_min_max_interval_indices) {
> ++            // Gather expanded bounds
> ++            off_lo = MIN2(off_lo, offset2);
> ++            off_hi = MAX2(off_hi, offset2);
> ++            // Record top NRC range checks
> ++            prev_checks[nb_checks % NRC].ctl = prev_dom;
> ++            prev_checks[nb_checks % NRC].off = offset2;
> ++            nb_checks++;
> ++          }
> +         }
> +       }
> +       prev_dom = dom;
> +diff --git a/hotspot/src/share/vm/opto/loopnode.cpp b/hotspot/src/share/vm/opto/loopnode.cpp
> +index b2d5dccd..8bc9dd29 100644
> +--- a/hotspot/src/share/vm/opto/loopnode.cpp
> ++++ b/hotspot/src/share/vm/opto/loopnode.cpp
> +@@ -260,6 +260,49 @@ void PhaseIdealLoop::set_subtree_ctrl( Node *n ) {
> +   set_early_ctrl( n );
> + }
> +
> ++void PhaseIdealLoop::insert_loop_limit_check(ProjNode* limit_check_proj, Node* cmp_limit, Node* bol) {
> ++  Node* new_predicate_proj = create_new_if_for_predicate(limit_check_proj, NULL,
> ++                                                         Deoptimization::Reason_loop_limit_check);
> ++  Node* iff = new_predicate_proj->in(0);
> ++  assert(iff->Opcode() == Op_If, "bad graph shape");
> ++  Node* conv = iff->in(1);
> ++  assert(conv->Opcode() == Op_Conv2B, "bad graph shape");
> ++  Node* opaq = conv->in(1);
> ++  assert(opaq->Opcode() == Op_Opaque1, "bad graph shape");
> ++  cmp_limit = _igvn.register_new_node_with_optimizer(cmp_limit);
> ++  bol = _igvn.register_new_node_with_optimizer(bol);
> ++  set_subtree_ctrl(bol);
> ++  _igvn.replace_input_of(iff, 1, bol);
> ++
> ++#ifndef PRODUCT
> ++  // report that the loop predication has been actually performed
> ++  // for this loop
> ++  if (TraceLoopLimitCheck) {
> ++    tty->print_cr("Counted Loop Limit Check generated:");
> ++    debug_only( bol->dump(2); )
> ++  }
> ++#endif
> ++}
> ++
> ++static int check_stride_overflow(jlong final_correction, const TypeInt* limit_t) {
> ++  if (final_correction > 0) {
> ++    if (limit_t->_lo > (max_jint - final_correction)) {
> ++      return -1;
> ++    }
> ++    if (limit_t->_hi > (max_jint - final_correction)) {
> ++      return 1;
> ++    }
> ++  } else {
> ++    if (limit_t->_hi < (min_jint - final_correction)) {
> ++      return -1;
> ++    }
> ++    if (limit_t->_lo < (min_jint - final_correction)) {
> ++      return 1;
> ++    }
> ++  }
> ++  return 0;
> ++}
> ++
> + //------------------------------is_counted_loop--------------------------------
> + bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +   PhaseGVN *gvn = &_igvn;
> +@@ -463,51 +506,256 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +   assert(x->Opcode() == Op_Loop, "regular loops only");
> +   C->print_method(PHASE_BEFORE_CLOOPS, 3);
> +
> +-  Node *hook = new (C) Node(6);
> ++  Node* adjusted_limit = limit;
> +
> +   if (LoopLimitCheck) {
> +
> +   // ===================================================
> +-  // Generate loop limit check to avoid integer overflow
> +-  // in cases like next (cyclic loops):
> ++  // We can only convert this loop to a counted loop if we can guarantee that the iv phi will never overflow at runtime.
> ++  // This is an implicit assumption taken by some loop optimizations. We therefore must ensure this property at all cost.
> ++  // At this point, we've already excluded some trivial cases where an overflow could have been proven statically.
> ++  // But even though we cannot prove that an overflow will *not* happen, we still want to speculatively convert this loop
> ++  // to a counted loop. This can be achieved by adding additional iv phi overflow checks before the loop. If they fail,
> ++  // we trap and resume execution before the loop without having executed any iteration of the loop, yet.
> +   //
> +-  // for (i=0; i <= max_jint; i++) {}
> +-  // for (i=0; i <  max_jint; i+=2) {}
> ++  // These additional iv phi overflow checks can be inserted as Loop Limit Check Predicates above the Loop Limit Check
> ++  // Parse Predicate which captures a JVM state just before the entry of the loop. If there is no such Parse Predicate,
> ++  // we cannot generate a Loop Limit Check Predicate and thus cannot speculatively convert the loop to a counted loop.
> +   //
> ++  // In the following, we only focus on int loops with stride > 0 to keep things simple. The argumentation and proof
> ++  // for stride < 0 is analogously. For long loops, we would replace max_int with max_long.
> +   //
> +-  // Limit check predicate depends on the loop test:
> +   //
> +-  // for(;i != limit; i++)       --> limit <= (max_jint)
> +-  // for(;i <  limit; i+=stride) --> limit <= (max_jint - stride + 1)
> +-  // for(;i <= limit; i+=stride) --> limit <= (max_jint - stride    )
> ++  // The loop to be converted does not always need to have the often used shape:
> +   //
> ++  //                                                 i = init
> ++  //     i = init                                loop:
> ++  //     do {                                        ...
> ++  //         // ...               equivalent         i+=stride
> ++  //         i+=stride               <==>            if (i < limit)
> ++  //     } while (i < limit);                          goto loop
> ++  //                                             exit:
> ++  //                                                 ...
> ++  //
> ++  // where the loop exit check uses the post-incremented iv phi and a '<'-operator.
> ++  //
> ++  // We could also have '<='-operator (or '>='-operator for negative strides) or use the pre-incremented iv phi value
> ++  // in the loop exit check:
> ++  //
> ++  //         i = init
> ++  //     loop:
> ++  //         ...
> ++  //         if (i <= limit)
> ++  //             i+=stride
> ++  //             goto loop
> ++  //     exit:
> ++  //         ...
> ++  //
> ++  // Let's define the following terms:
> ++  // - iv_pre_i: The pre-incremented iv phi before the i-th iteration.
> ++  // - iv_post_i: The post-incremented iv phi after the i-th iteration.
> ++  //
> ++  // The iv_pre_i and iv_post_i have the following relation:
> ++  //      iv_pre_i + stride = iv_post_i
> ++  //
> ++  // When converting a loop to a counted loop, we want to have a canonicalized loop exit check of the form:
> ++  //     iv_post_i < adjusted_limit
> ++  //
> ++  // If that is not the case, we need to canonicalize the loop exit check by using different values for adjusted_limit:
> ++  // (LE1) iv_post_i < limit: Already canonicalized. We can directly use limit as adjusted_limit.
> ++  //           -> adjusted_limit = limit.
> ++  // (LE2) iv_post_i <= limit:
> ++  //           iv_post_i < limit + 1
> ++  //           -> adjusted limit = limit + 1
> ++  // (LE3) iv_pre_i < limit:
> ++  //           iv_pre_i + stride < limit + stride
> ++  //           iv_post_i < limit + stride
> ++  //           -> adjusted_limit = limit + stride
> ++  // (LE4) iv_pre_i <= limit:
> ++  //           iv_pre_i < limit + 1
> ++  //           iv_pre_i + stride < limit + stride + 1
> ++  //           iv_post_i < limit + stride + 1
> ++  //           -> adjusted_limit = limit + stride + 1
> ++  //
> ++  // Note that:
> ++  //     (AL) limit <= adjusted_limit.
> ++  //
> ++  // The following loop invariant has to hold for counted loops with n iterations (i.e. loop exit check true after n-th
> ++  // loop iteration) and a canonicalized loop exit check to guarantee that no iv_post_i over- or underflows:
> ++  // (INV) For i = 1..n, min_int <= iv_post_i <= max_int
> ++  //
> ++  // To prove (INV), we require the following two conditions/assumptions:
> ++  // (i): adjusted_limit - 1 + stride <= max_int
> ++  // (ii): init < limit
> ++  //
> ++  // If we can prove (INV), we know that there can be no over- or underflow of any iv phi value. We prove (INV) by
> ++  // induction by assuming (i) and (ii).
> ++  //
> ++  // Proof by Induction
> ++  // ------------------
> ++  // > Base case (i = 1): We show that (INV) holds after the first iteration:
> ++  //     min_int <= iv_post_1 = init + stride <= max_int
> ++  // Proof:
> ++  //     First, we note that (ii) implies
> ++  //         (iii) init <= limit - 1
> ++  //     max_int >= adjusted_limit - 1 + stride   [using (i)]
> ++  //             >= limit - 1 + stride            [using (AL)]
> ++  //             >= init + stride                 [using (iii)]
> ++  //             >= min_int                       [using stride > 0, no underflow]
> ++  // Thus, no overflow happens after the first iteration and (INV) holds for i = 1.
> ++  //
> ++  // Note that to prove the base case we need (i) and (ii).
> ++  //
> ++  // > Induction Hypothesis (i = j, j > 1): Assume that (INV) holds after the j-th iteration:
> ++  //     min_int <= iv_post_j <= max_int
> ++  // > Step case (i = j + 1): We show that (INV) also holds after the j+1-th iteration:
> ++  //     min_int <= iv_post_{j+1} = iv_post_j + stride <= max_int
> ++  // Proof:
> ++  // If iv_post_j >= adjusted_limit:
> ++  //     We exit the loop after the j-th iteration, and we don't execute the j+1-th iteration anymore. Thus, there is
> ++  //     also no iv_{j+1}. Since (INV) holds for iv_j, there is nothing left to prove.
> ++  // If iv_post_j < adjusted_limit:
> ++  //     First, we note that:
> ++  //         (iv) iv_post_j <= adjusted_limit - 1
> ++  //     max_int >= adjusted_limit - 1 + stride    [using (i)]
> ++  //             >= iv_post_j + stride             [using (iv)]
> ++  //             >= min_int                        [using stride > 0, no underflow]
> ++  //
> ++  // Note that to prove the step case we only need (i).
> ++  //
> ++  // Thus, by assuming (i) and (ii), we proved (INV).
> ++  //
> ++  //
> ++  // It is therefore enough to add the following two Loop Limit Check Predicates to check assumptions (i) and (ii):
> ++  //
> ++  // (1) Loop Limit Check Predicate for (i):
> ++  //     Using (i): adjusted_limit - 1 + stride <= max_int
> ++  //
> ++  //     This condition is now restated to use limit instead of adjusted_limit:
> ++  //
> ++  //     To prevent an overflow of adjusted_limit -1 + stride itself, we rewrite this check to
> ++  //         max_int - stride + 1 >= adjusted_limit
> ++  //     We can merge the two constants into
> ++  //         canonicalized_correction = stride - 1
> ++  //     which gives us
> ++  //        max_int - canonicalized_correction >= adjusted_limit
> ++  //
> ++  //     To directly use limit instead of adjusted_limit in the predicate condition, we split adjusted_limit into:
> ++  //         adjusted_limit = limit + limit_correction
> ++  //     Since stride > 0 and limit_correction <= stride + 1, we can restate this with no over- or underflow into:
> ++  //         max_int - canonicalized_correction - limit_correction >= limit
> ++  //     Since canonicalized_correction and limit_correction are both constants, we can replace them with a new constant:
> ++  //         final_correction = canonicalized_correction + limit_correction
> ++  //     which gives us:
> ++  //
> ++  //     Final predicate condition:
> ++  //         max_int - final_correction >= limit
> ++  //
> ++  // (2) Loop Limit Check Predicate for (ii):
> ++  //     Using (ii): init < limit
> ++  //
> ++  //     This Loop Limit Check Predicate is not required if we can prove at compile time that either:
> ++  //        (2.1) type(init) < type(limit)
> ++  //             In this case, we know:
> ++  //                 all possible values of init < all possible values of limit
> ++  //             and we can skip the predicate.
> ++  //
> ++  //        (2.2) init < limit is already checked before (i.e. found as a dominating check)
> ++  //            In this case, we do not need to re-check the condition and can skip the predicate.
> ++  //            This is often found for while- and for-loops which have the following shape:
> ++  //
> ++  //                if (init < limit) { // Dominating test. Do not need the Loop Limit Check Predicate below.
> ++  //                    i = init;
> ++  //                    if (init >= limit) { trap(); } // Here we would insert the Loop Limit Check Predicate
> ++  //                    do {
> ++  //                        i += stride;
> ++  //                    } while (i < limit);
> ++  //                }
> ++  //
> ++  //        (2.3) init + stride <= max_int
> ++  //            In this case, there is no overflow of the iv phi after the first loop iteration.
> ++  //            In the proof of the base case above we showed that init + stride <= max_int by using assumption (ii):
> ++  //                init < limit
> ++  //            In the proof of the step case above, we did not need (ii) anymore. Therefore, if we already know at
> ++  //            compile time that init + stride <= max_int then we have trivially proven the base case and that
> ++  //            there is no overflow of the iv phi after the first iteration. In this case, we don't need to check (ii)
> ++  //            again and can skip the predicate.
> ++
> ++
> ++  // Accounting for (LE3) and (LE4) where we use pre-incremented phis in the loop exit check.
> ++  const jlong limit_correction_for_pre_iv_exit_check = (phi_incr != NULL) ? stride_con : 0;
> ++
> ++  // Accounting for (LE2) and (LE4) where we use <= or >= in the loop exit check.
> ++  const bool includes_limit = (bt == BoolTest::le || bt == BoolTest::ge);
> ++  const jlong limit_correction_for_le_ge_exit_check = (includes_limit ? (stride_con > 0 ? 1 : -1) : 0);
> ++
> ++  const jlong limit_correction = limit_correction_for_pre_iv_exit_check + limit_correction_for_le_ge_exit_check;
> ++  const jlong canonicalized_correction = stride_con + (stride_con > 0 ? -1 : 1);
> ++  const jlong final_correction = canonicalized_correction + limit_correction;
> ++
> ++  int sov = check_stride_overflow(final_correction, limit_t);
> ++
> ++  // If sov==0, limit's type always satisfies the condition, for
> ++  // example, when it is an array length.
> ++  if (sov != 0) {
> ++    if (sov < 0) {
> ++      return false;  // Bailout: integer overflow is certain.
> ++    }
> ++    // (1) Loop Limit Check Predicate is required because we could not statically prove that
> ++    //     limit + final_correction = adjusted_limit - 1 + stride <= max_int
> ++    ProjNode *limit_check_proj = find_predicate_insertion_point(init_control, Deoptimization::Reason_loop_limit_check);
> ++    if (!limit_check_proj) {
> ++      // The Loop Limit Check Parse Predicate is not generated if this method trapped here before.
> ++#ifdef ASSERT
> ++      if (TraceLoopLimitCheck) {
> ++        tty->print("missing loop limit check:");
> ++        loop->dump_head();
> ++        x->dump(1);
> ++      }
> ++#endif
> ++      return false;
> ++    }
> +
> +-  // Check if limit is excluded to do more precise int overflow check.
> +-  bool incl_limit = (bt == BoolTest::le || bt == BoolTest::ge);
> +-  int stride_m  = stride_con - (incl_limit ? 0 : (stride_con > 0 ? 1 : -1));
> +-
> +-  // If compare points directly to the phi we need to adjust
> +-  // the compare so that it points to the incr. Limit have
> +-  // to be adjusted to keep trip count the same and the
> +-  // adjusted limit should be checked for int overflow.
> +-  if (phi_incr != NULL) {
> +-    stride_m  += stride_con;
> +-  }
> ++    IfNode* check_iff = limit_check_proj->in(0)->as_If();
> +
> +-  if (limit->is_Con()) {
> +-    int limit_con = limit->get_int();
> +-    if ((stride_con > 0 && limit_con > (max_jint - stride_m)) ||
> +-        (stride_con < 0 && limit_con < (min_jint - stride_m))) {
> +-      // Bailout: it could be integer overflow.
> ++    if (!is_dominator(get_ctrl(limit), check_iff->in(0))) {
> +       return false;
> +     }
> +-  } else if ((stride_con > 0 && limit_t->_hi <= (max_jint - stride_m)) ||
> +-             (stride_con < 0 && limit_t->_lo >= (min_jint - stride_m))) {
> +-      // Limit's type may satisfy the condition, for example,
> +-      // when it is an array length.
> +-  } else {
> +-    // Generate loop's limit check.
> +-    // Loop limit check predicate should be near the loop.
> ++
> ++    Node* cmp_limit;
> ++    Node* bol;
> ++
> ++    if (stride_con > 0) {
> ++      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(max_jint - final_correction));
> ++      bol = new (C) BoolNode(cmp_limit, BoolTest::le);
> ++    } else {
> ++      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(min_jint - final_correction));
> ++      bol = new (C) BoolNode(cmp_limit, BoolTest::ge);
> ++    }
> ++
> ++    insert_loop_limit_check(limit_check_proj, cmp_limit, bol);
> ++  }
> ++
> ++  // (2.3)
> ++  const bool init_plus_stride_could_overflow =
> ++          (stride_con > 0 && init_t->_hi > max_jint - stride_con) ||
> ++          (stride_con < 0 && init_t->_lo < min_jint - stride_con);
> ++  // (2.1)
> ++  const bool init_gte_limit = (stride_con > 0 && init_t->_hi >= limit_t->_lo) ||
> ++                              (stride_con < 0 && init_t->_lo <= limit_t->_hi);
> ++
> ++  if (init_gte_limit && // (2.1)
> ++     ((bt == BoolTest::ne || init_plus_stride_could_overflow) && // (2.3)
> ++      !has_dominating_loop_limit_check(init_trip, limit, stride_con, init_control))) { // (2.2)
> ++    // (2) Iteration Loop Limit Check Predicate is required because neither (2.1), (2.2), nor (2.3) holds.
> ++    // We use the following condition:
> ++    // - stride > 0: init < limit
> ++    // - stride < 0: init > limit
> ++    //
> ++    // This predicate is always required if we have a non-equal-operator in the loop exit check (where stride = 1 is
> ++    // a requirement). We transform the loop exit check by using a less-than-operator. By doing so, we must always
> ++    // check that init < limit. Otherwise, we could have a different number of iterations at runtime.
> ++
> +     ProjNode *limit_check_proj = find_predicate_insertion_point(init_control, Deoptimization::Reason_loop_limit_check);
> +     if (!limit_check_proj) {
> +       // The limit check predicate is not generated if this method trapped here before.
> +@@ -520,41 +768,38 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> + #endif
> +       return false;
> +     }
> +-
> +     IfNode* check_iff = limit_check_proj->in(0)->as_If();
> ++
> ++    if (!is_dominator(get_ctrl(limit), check_iff->in(0)) ||
> ++        !is_dominator(get_ctrl(init_trip), check_iff->in(0))) {
> ++      return false;
> ++    }
> ++
> +     Node* cmp_limit;
> +     Node* bol;
> +
> +     if (stride_con > 0) {
> +-      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(max_jint - stride_m));
> +-      bol = new (C) BoolNode(cmp_limit, BoolTest::le);
> ++      cmp_limit = new (C) CmpINode(init_trip, limit);
> ++      bol = new (C) BoolNode(cmp_limit, BoolTest::lt);
> +     } else {
> +-      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(min_jint - stride_m));
> +-      bol = new (C) BoolNode(cmp_limit, BoolTest::ge);
> ++      cmp_limit = new (C) CmpINode(init_trip, limit);
> ++      bol = new (C) BoolNode(cmp_limit, BoolTest::gt);
> +     }
> +-    cmp_limit = _igvn.register_new_node_with_optimizer(cmp_limit);
> +-    bol = _igvn.register_new_node_with_optimizer(bol);
> +-    set_subtree_ctrl(bol);
> +-
> +-    // Replace condition in original predicate but preserve Opaque node
> +-    // so that previous predicates could be found.
> +-    assert(check_iff->in(1)->Opcode() == Op_Conv2B &&
> +-           check_iff->in(1)->in(1)->Opcode() == Op_Opaque1, "");
> +-    Node* opq = check_iff->in(1)->in(1);
> +-    _igvn.hash_delete(opq);
> +-    opq->set_req(1, bol);
> +-    // Update ctrl.
> +-    set_ctrl(opq, check_iff->in(0));
> +-    set_ctrl(check_iff->in(1), check_iff->in(0));
> +
> +-#ifndef PRODUCT
> +-    // report that the loop predication has been actually performed
> +-    // for this loop
> +-    if (TraceLoopLimitCheck) {
> +-      tty->print_cr("Counted Loop Limit Check generated:");
> +-      debug_only( bol->dump(2); )
> ++    insert_loop_limit_check(limit_check_proj, cmp_limit, bol);
> ++  }
> ++
> ++  if (bt == BoolTest::ne) {
> ++    // Now we need to canonicalize the loop condition if it is 'ne'.
> ++    assert(stride_con == 1 || stride_con == -1, "simple increment only - checked before");
> ++    if (stride_con > 0) {
> ++      // 'ne' can be replaced with 'lt' only when init < limit. This is ensured by the inserted predicate above.
> ++      bt = BoolTest::lt;
> ++    } else {
> ++      assert(stride_con < 0, "must be");
> ++      // 'ne' can be replaced with 'gt' only when init > limit. This is ensured by the inserted predicate above.
> ++      bt = BoolTest::gt;
> +     }
> +-#endif
> +   }
> +
> +   if (phi_incr != NULL) {
> +@@ -567,26 +812,15 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +     // is converted to
> +     //   i = init; do {} while(++i < limit+1);
> +     //
> +-    limit = gvn->transform(new (C) AddINode(limit, stride));
> +-  }
> +-
> +-  // Now we need to canonicalize loop condition.
> +-  if (bt == BoolTest::ne) {
> +-    assert(stride_con == 1 || stride_con == -1, "simple increment only");
> +-    // 'ne' can be replaced with 'lt' only when init < limit.
> +-    if (stride_con > 0 && init_t->_hi < limit_t->_lo)
> +-      bt = BoolTest::lt;
> +-    // 'ne' can be replaced with 'gt' only when init > limit.
> +-    if (stride_con < 0 && init_t->_lo > limit_t->_hi)
> +-      bt = BoolTest::gt;
> ++    adjusted_limit = gvn->transform(new (C) AddINode(limit, stride));
> +   }
> +
> +-  if (incl_limit) {
> ++  if (includes_limit) {
> +     // The limit check guaranties that 'limit <= (max_jint - stride)' so
> +     // we can convert 'i <= limit' to 'i < limit+1' since stride != 0.
> +     //
> +     Node* one = (stride_con > 0) ? gvn->intcon( 1) : gvn->intcon(-1);
> +-    limit = gvn->transform(new (C) AddINode(limit, one));
> ++    adjusted_limit = gvn->transform(new (C) AddINode(adjusted_limit, one));
> +     if (bt == BoolTest::le)
> +       bt = BoolTest::lt;
> +     else if (bt == BoolTest::ge)
> +@@ -594,10 +828,11 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +     else
> +       ShouldNotReachHere();
> +   }
> +-  set_subtree_ctrl( limit );
> ++  set_subtree_ctrl(adjusted_limit);
> +
> +   } else { // LoopLimitCheck
> +
> ++  Node *hook = new (C) Node(6);
> +   // If compare points to incr, we are ok.  Otherwise the compare
> +   // can directly point to the phi; in this case adjust the compare so that
> +   // it points to the incr by adjusting the limit.
> +@@ -691,6 +926,11 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +   limit = gvn->transform(new (C) AddINode(span,init_trip));
> +   set_subtree_ctrl( limit );
> +
> ++  adjusted_limit = limit;
> ++
> ++  // Free up intermediate goo
> ++  _igvn.remove_dead_node(hook);
> ++
> +   } // LoopLimitCheck
> +
> +   if (!UseCountedLoopSafepoints) {
> +@@ -728,7 +968,7 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +   }
> +   cmp = cmp->clone();
> +   cmp->set_req(1,incr);
> +-  cmp->set_req(2,limit);
> ++  cmp->set_req(2, adjusted_limit);
> +   cmp = _igvn.register_new_node_with_optimizer(cmp);
> +   set_ctrl(cmp, iff->in(0));
> +
> +@@ -802,9 +1042,6 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +     }
> +   }
> +
> +-  // Free up intermediate goo
> +-  _igvn.remove_dead_node(hook);
> +-
> + #ifdef ASSERT
> +   assert(l->is_valid_counted_loop(), "counted loop shape is messed up");
> +   assert(l == loop->_head && l->phi() == phi && l->loopexit() == lex, "" );
> +@@ -821,6 +1058,37 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
> +   return true;
> + }
> +
> ++// Check if there is a dominating loop limit check of the form 'init < limit' starting at the loop entry.
> ++// If there is one, then we do not need to create an additional Loop Limit Check Predicate.
> ++bool PhaseIdealLoop::has_dominating_loop_limit_check(Node* init_trip, Node* limit, const int stride_con,
> ++                                                     Node* loop_entry) {
> ++  // Eagerly call transform() on the Cmp and Bool node to common them up if possible. This is required in order to
> ++  // successfully find a dominated test with the If node below.
> ++  Node* cmp_limit;
> ++  Node* bol;
> ++  if (stride_con > 0) {
> ++    cmp_limit = _igvn.transform(new (C) CmpINode(init_trip, limit));
> ++    bol = _igvn.transform(new (C) BoolNode(cmp_limit, BoolTest::lt));
> ++  } else {
> ++    cmp_limit = _igvn.transform(new (C) CmpINode(init_trip, limit));
> ++    bol = _igvn.transform(new (C) BoolNode(cmp_limit, BoolTest::gt));
> ++  }
> ++
> ++  // Check if there is already a dominating init < limit check. If so, we do not need a Loop Limit Check Predicate.
> ++  IfNode* iff = new (C) IfNode(loop_entry, bol, PROB_MIN, COUNT_UNKNOWN);
> ++  // Also add fake IfProj nodes in order to call transform() on the newly created IfNode.
> ++  IfFalseNode* if_false = new (C) IfFalseNode(iff);
> ++  IfTrueNode* if_true = new (C) IfTrueNode(iff);
> ++  Node* dominated_iff = _igvn.transform(iff);
> ++  // ConI node? Found dominating test (IfNode::dominated_by() returns a ConI node).
> ++  const bool found_dominating_test = dominated_iff != NULL && dominated_iff->Opcode() == Op_ConI;
> ++
> ++  // Kill the If with its projections again in the next IGVN round by cutting it off from the graph.
> ++  _igvn.replace_input_of(iff, 0, C->top());
> ++  _igvn.replace_input_of(iff, 1, C->top());
> ++  return found_dominating_test;
> ++}
> ++
> + //----------------------exact_limit-------------------------------------------
> + Node* PhaseIdealLoop::exact_limit( IdealLoopTree *loop ) {
> +   assert(loop->_head->is_CountedLoop(), "");
> +diff --git a/hotspot/src/share/vm/opto/loopnode.hpp b/hotspot/src/share/vm/opto/loopnode.hpp
> +index 55a7def3..3ae41f8d 100644
> +--- a/hotspot/src/share/vm/opto/loopnode.hpp
> ++++ b/hotspot/src/share/vm/opto/loopnode.hpp
> +@@ -896,6 +896,10 @@ public:
> +   // Create a new if above the uncommon_trap_if_pattern for the predicate to be promoted
> +   ProjNode* create_new_if_for_predicate(ProjNode* cont_proj, Node* new_entry,
> +                                         Deoptimization::DeoptReason reason);
> ++  void insert_loop_limit_check(ProjNode* limit_check_proj, Node* cmp_limit, Node* bol);
> ++  bool has_dominating_loop_limit_check(Node* init_trip, Node* limit, int stride_con,
> ++                                       Node* loop_entry);
> ++
> +   void register_control(Node* n, IdealLoopTree *loop, Node* pred);
> +
> +   // Clone loop predicates to cloned loops (peeled, unswitched)
> +diff --git a/hotspot/src/share/vm/opto/phaseX.hpp b/hotspot/src/share/vm/opto/phaseX.hpp
> +index a2a2a538..bd7393ac 100644
> +--- a/hotspot/src/share/vm/opto/phaseX.hpp
> ++++ b/hotspot/src/share/vm/opto/phaseX.hpp
> +@@ -431,9 +431,6 @@ private:
> +
> + protected:
> +
> +-  // Idealize new Node 'n' with respect to its inputs and its value
> +-  virtual Node *transform( Node *a_node );
> +-
> +   // Warm up hash table, type table and initial worklist
> +   void init_worklist( Node *a_root );
> +
> +@@ -447,6 +444,9 @@ public:
> +   PhaseIterGVN( PhaseGVN *gvn ); // Used after Parser
> +   PhaseIterGVN( PhaseIterGVN *igvn, const char *dummy ); // Used after +VerifyOpto
> +
> ++  // Idealize new Node 'n' with respect to its inputs and its value
> ++  virtual Node *transform( Node *a_node );
> ++
> +   virtual PhaseIterGVN *is_IterGVN() { return this; }
> +
> +   Unique_Node_List _worklist;       // Iterative worklist
> +--
> +2.25.1
> +
-- 
Regards,
Hitendra Prajapati
MontaVista Software LLC
Mo: +91 9998906483
--------------7WLfVxn0jzIaGzVsJPc02c0d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Team,</p>
    <p>Any Update on this issue ?</p>
    <p>Regards,</p>
    <p>Hitendra<br>
    </p>
    <div class="moz-cite-prefix">On 01/07/24 5:24 pm, Hitendra Prajapati
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240701115411.15574-1-hprajapati@mvista.com">
      <pre class="moz-quote-pre" wrap="">Backport fixes for:

* CVE-2022-40433 - Upstream-Status: Backport from <a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04">https://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04</a>
* CVE-2024-20919 - Upstream-Status: Backport from <a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215">https://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215</a>
* CVE-2024-20921 - Upstream-Status: Backport from <a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436">https://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436</a>

Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E" href="mailto:hprajapati@mvista.com">&lt;hprajapati@mvista.com&gt;</a>
---
 .../openjdk/openjdk-8-release-common.inc      |   3 +
 .../patches-openjdk-8/CVE-2022-40433.patch    | 233 +++++++
 .../patches-openjdk-8/CVE-2024-20919.patch    | 126 ++++
 .../patches-openjdk-8/CVE-2024-20921.patch    | 657 ++++++++++++++++++
 4 files changed, 1019 insertions(+)
 create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
 create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
 create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch

diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipes-core/openjdk/openjdk-8-release-common.inc
index ff8d96e..985d0d7 100644
--- a/recipes-core/openjdk/openjdk-8-release-common.inc
+++ b/recipes-core/openjdk/openjdk-8-release-common.inc
@@ -21,6 +21,9 @@ PATCHES_URI = "\
     <a class="moz-txt-link-freetext" href="file://2007-jdk-no-genx11-in-headless.patch">file://2007-jdk-no-genx11-in-headless.patch</a> \
     <a class="moz-txt-link-freetext" href="file://2008-jdk-no-unused-deps.patch">file://2008-jdk-no-unused-deps.patch</a> \
     <a class="moz-txt-link-freetext" href="file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch">file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch</a> \
+    <a class="moz-txt-link-freetext" href="file://CVE-2022-40433.patch">file://CVE-2022-40433.patch</a> \
+    <a class="moz-txt-link-freetext" href="file://CVE-2024-20919.patch">file://CVE-2024-20919.patch</a> \
+    <a class="moz-txt-link-freetext" href="file://CVE-2024-20921.patch">file://CVE-2024-20921.patch</a> \
 "
 HOTSPOT_UB_PATCH = "\
     <a class="moz-txt-link-freetext" href="file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch">file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch</a> \
diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
new file mode 100644
index 0000000..fcae4f4
--- /dev/null
+++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2022-40433.patch
@@ -0,0 +1,233 @@
+From 961ab463974b7d05600b826303f9111c4f367a04 Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Ji=C5=99=C3=AD=20Van=C4=9Bk?= <a class="moz-txt-link-rfc2396E" href="mailto:jvanek@openjdk.org">&lt;jvanek@openjdk.org&gt;</a>
+Date: Mon, 25 Sep 2023 14:05:03 +0000
+Subject: [PATCH] 8283441: C2: segmentation fault in
+ ciMethodBlocks::make_block_at(int)
+
+Reviewed-by: mbalao
+Backport-of: 947869609ce6b74d4d28f79724b823d8781adbed
+
+Upstream-Status: Backport [<a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04">https://github.com/openjdk/jdk8u/commit/961ab463974b7d05600b826303f9111c4f367a04</a>]
+CVE: CVE-2022-40433
+Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E" href="mailto:hprajapati@mvista.com">&lt;hprajapati@mvista.com&gt;</a>
+---
+ hotspot/src/share/vm/c1/c1_GraphBuilder.cpp   | 12 ++++--
+ hotspot/src/share/vm/ci/ciMethodBlocks.cpp    | 17 +++++---
+ .../src/share/vm/compiler/methodLiveness.cpp  |  9 ++--
+ hotspot/test/compiler/parsing/Custom.jasm     | 38 +++++++++++++++++
+ ...UnreachableBlockFallsThroughEndOfCode.java | 42 +++++++++++++++++++
+ 5 files changed, 106 insertions(+), 12 deletions(-)
+ create mode 100644 hotspot/test/compiler/parsing/Custom.jasm
+ create mode 100644 hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
+
+diff --git a/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp b/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
+index 99f1c510..6e3e4cc4 100644
+--- a/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
++++ b/hotspot/src/share/vm/c1/c1_GraphBuilder.cpp
+@@ -206,8 +206,10 @@ void BlockListBuilder::handle_exceptions(BlockBegin* current, int cur_bci) {
+ }
+ 
+ void BlockListBuilder::handle_jsr(BlockBegin* current, int sr_bci, int next_bci) {
+-  // start a new block after jsr-bytecode and link this block into cfg
+-  make_block_at(next_bci, current);
++  if (next_bci &lt; method()-&gt;code_size()) {
++    // start a new block after jsr-bytecode and link this block into cfg
++    make_block_at(next_bci, current);
++  }
+ 
+   // start a new block at the subroutine entry at mark it with special flag
+   BlockBegin* sr_block = make_block_at(sr_bci, current);
+@@ -227,6 +229,8 @@ void BlockListBuilder::set_leaders() {
+   // branch target and a modification of the successor lists.
+   BitMap bci_block_start = method()-&gt;bci_block_start();
+ 
++  int end_bci = method()-&gt;code_size();
++
+   ciBytecodeStream s(method());
+   while (s.next() != ciBytecodeStream::EOBC()) {
+     int cur_bci = s.cur_bci();
+@@ -297,7 +301,9 @@ void BlockListBuilder::set_leaders() {
+       case Bytecodes::_if_acmpne: // fall through
+       case Bytecodes::_ifnull:    // fall through
+       case Bytecodes::_ifnonnull:
+-        make_block_at(s.next_bci(), current);
++        if (s.next_bci() &lt; end_bci) {
++          make_block_at(s.next_bci(), current);
++        }
+         make_block_at(s.get_dest(), current);
+         current = NULL;
+         break;
+diff --git a/hotspot/src/share/vm/ci/ciMethodBlocks.cpp b/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
+index 614e75dc..2285eb0a 100644
+--- a/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
++++ b/hotspot/src/share/vm/ci/ciMethodBlocks.cpp
+@@ -1,5 +1,5 @@
+ /*
+- * Copyright (c) 2006, 2011, Oracle and/or its affiliates. All rights reserved.
++ * Copyright (c) 2006, 2022, Oracle and/or its affiliates. All rights reserved.
+  * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+  *
+  * This code is free software; you can redistribute it and/or modify it
+@@ -33,12 +33,13 @@
+ 
+ 
+ ciBlock *ciMethodBlocks::block_containing(int bci) {
++  assert(bci &gt;= 0 &amp;&amp; bci &lt; _code_size, "valid bytecode range");
+   ciBlock *blk = _bci_to_block[bci];
+   return blk;
+ }
+ 
+ bool ciMethodBlocks::is_block_start(int bci) {
+-  assert(bci &gt;=0 &amp;&amp; bci &lt; _code_size, "valid bytecode range");
++  assert(bci &gt;= 0 &amp;&amp; bci &lt; _code_size, "valid bytecode range");
+   ciBlock *b = _bci_to_block[bci];
+   assert(b != NULL, "must have block for bytecode");
+   return b-&gt;start_bci() == bci;
+@@ -146,7 +147,9 @@ void ciMethodBlocks::do_analysis() {
+       case Bytecodes::_ifnonnull   :
+       {
+         cur_block-&gt;set_control_bci(bci);
+-        ciBlock *fall_through = make_block_at(s.next_bci());
++        if (s.next_bci() &lt; limit_bci) {
++          ciBlock *fall_through = make_block_at(s.next_bci());
++        }
+         int dest_bci = s.get_dest();
+         ciBlock *dest = make_block_at(dest_bci);
+         break;
+@@ -166,7 +169,9 @@ void ciMethodBlocks::do_analysis() {
+       case Bytecodes::_jsr         :
+       {
+         cur_block-&gt;set_control_bci(bci);
+-        ciBlock *ret = make_block_at(s.next_bci());
++        if (s.next_bci() &lt; limit_bci) {
++          ciBlock *ret = make_block_at(s.next_bci());
++        }
+         int dest_bci = s.get_dest();
+         ciBlock *dest = make_block_at(dest_bci);
+         break;
+@@ -224,7 +229,9 @@ void ciMethodBlocks::do_analysis() {
+       case Bytecodes::_jsr_w       :
+       {
+         cur_block-&gt;set_control_bci(bci);
+-        ciBlock *ret = make_block_at(s.next_bci());
++        if (s.next_bci() &lt; limit_bci) {
++          ciBlock *ret = make_block_at(s.next_bci());
++        }
+         int dest_bci = s.get_far_dest();
+         ciBlock *dest = make_block_at(dest_bci);
+         break;
+diff --git a/hotspot/src/share/vm/compiler/methodLiveness.cpp b/hotspot/src/share/vm/compiler/methodLiveness.cpp
+index eda1ab15..7fb496dc 100644
+--- a/hotspot/src/share/vm/compiler/methodLiveness.cpp
++++ b/hotspot/src/share/vm/compiler/methodLiveness.cpp
+@@ -268,10 +268,11 @@ void MethodLiveness::init_basic_blocks() {
+       case Bytecodes::_ifnull:
+       case Bytecodes::_ifnonnull:
+         // Two way branch.  Set predecessors at each destination.
+-        dest = _block_map-&gt;at(bytes.next_bci());
+-        assert(dest != NULL, "must be a block immediately following this one.");
+-        dest-&gt;add_normal_predecessor(current_block);
+-
++        if (bytes.next_bci() &lt; method_len) {
++          dest = _block_map-&gt;at(bytes.next_bci());
++          assert(dest != NULL, "must be a block immediately following this one.");
++          dest-&gt;add_normal_predecessor(current_block);
++        }
+         dest = _block_map-&gt;at(bytes.get_dest());
+         assert(dest != NULL, "branch desination must start a block.");
+         dest-&gt;add_normal_predecessor(current_block);
+diff --git a/hotspot/test/compiler/parsing/Custom.jasm b/hotspot/test/compiler/parsing/Custom.jasm
+new file mode 100644
+index 00000000..73a2b1ff
+--- /dev/null
++++ b/hotspot/test/compiler/parsing/Custom.jasm
+@@ -0,0 +1,38 @@
++/*
++ * Copyright (c) 2022, Oracle and/or its affiliates. All rights reserved.
++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
++ *
++ * This code is free software; you can redistribute it and/or modify it
++ * under the terms of the GNU General Public License version 2 only, as
++ * published by the Free Software Foundation.
++ *
++ * This code is distributed in the hope that it will be useful, but WITHOUT
++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
++ * version 2 for more details (a copy is included in the LICENSE file that
++ * accompanied this code).
++ *
++ * You should have received a copy of the GNU General Public License version
++ * 2 along with this work; if not, write to the Free Software Foundation,
++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
++ *
++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
++ * or visit <a class="moz-txt-link-abbreviated" href="http://www.oracle.com">www.oracle.com</a> if you need additional information or have any
++ * questions.
++ */
++
++package compiler/parsing;
++
++super public class Custom {
++
++    public static Method test:"(I)V" stack 2 locals 1 {
++        return;
++Loop:
++        // Unreachable block
++        iload_0;
++        bipush        100;
++        if_icmpge     Loop;
++        // Falls through
++    }
++
++}
+diff --git a/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java b/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
+new file mode 100644
+index 00000000..9dfb488d
+--- /dev/null
++++ b/hotspot/test/compiler/parsing/UnreachableBlockFallsThroughEndOfCode.java
+@@ -0,0 +1,42 @@
++/*
++ * Copyright (c) 2022, Oracle and/or its affiliates. All rights reserved.
++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
++ *
++ * This code is free software; you can redistribute it and/or modify it
++ * under the terms of the GNU General Public License version 2 only, as
++ * published by the Free Software Foundation.
++ *
++ * This code is distributed in the hope that it will be useful, but WITHOUT
++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
++ * version 2 for more details (a copy is included in the LICENSE file that
++ * accompanied this code).
++ *
++ * You should have received a copy of the GNU General Public License version
++ * 2 along with this work; if not, write to the Free Software Foundation,
++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
++ *
++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
++ * or visit <a class="moz-txt-link-abbreviated" href="http://www.oracle.com">www.oracle.com</a> if you need additional information or have any
++ * questions.
++ *
++ */
++
++/*
++ * @test UnreachableBlockFallsThroughEndOfCode.java
++ * @bug 8283441
++ * @compile Custom.jasm UnreachableBlockFallsThroughEndOfCode.java
++ * @summary Compiling method that falls off the end of the code array
++ * @run main/othervm -XX:TieredStopAtLevel=1 -Xbatch compiler.parsing.UnreachableBlockFallsThroughEndOfCode
++ * @run main/othervm -XX:-TieredCompilation -Xbatch compiler.parsing.UnreachableBlockFallsThroughEndOfCode
++ */
++
++package compiler.parsing;
++
++public class UnreachableBlockFallsThroughEndOfCode {
++    public static void main(String[] strArr) {
++        for (int i = 0; i &lt; 20000; i++) {
++            Custom.test(i);
++        }
++    }
++}
+-- 
+2.25.1
+
diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
new file mode 100644
index 0000000..a3fc8b6
--- /dev/null
+++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20919.patch
@@ -0,0 +1,126 @@
+From 77d38b78e4993381ddb113d012b30ab2d7cd9215 Mon Sep 17 00:00:00 2001
+From: Martin Balao <a class="moz-txt-link-rfc2396E" href="mailto:mbalao@openjdk.org">&lt;mbalao@openjdk.org&gt;</a>
+Date: Fri, 29 Sep 2023 13:01:13 +0000
+Subject: [PATCH] 8314295: Enhance verification of verifier
+
+Reviewed-by: yan, andrew
+Backport-of: 08980a0a60bc48c17eacd57fd2d7065ac2d986a8 
+
+Upstream-Status: Backport [<a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215">https://github.com/openjdk/jdk8u/commit/77d38b78e4993381ddb113d012b30ab2d7cd9215</a>]
+CVE: CVE-2024-20919
+Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E" href="mailto:hprajapati@mvista.com">&lt;hprajapati@mvista.com&gt;</a>
+---
+ hotspot/src/share/vm/classfile/verifier.cpp   |  5 +++--
+ .../src/share/vm/interpreter/bytecodes.cpp    | 22 ++++++++++++++-----
+ jdk/src/share/native/common/check_code.c      | 11 ++++++----
+ 3 files changed, 26 insertions(+), 12 deletions(-)
+
+diff --git a/hotspot/src/share/vm/classfile/verifier.cpp b/hotspot/src/share/vm/classfile/verifier.cpp
+index 2a572058..3a3e04ba 100644
+--- a/hotspot/src/share/vm/classfile/verifier.cpp
++++ b/hotspot/src/share/vm/classfile/verifier.cpp
+@@ -2078,11 +2078,12 @@ void ClassVerifier::verify_switch(
+           "low must be less than or equal to high in tableswitch");
+       return;
+     }
+-    keys = high - low + 1;
+-    if (keys &lt; 0) {
++    int64_t keys64 = ((int64_t)high - low) + 1;
++    if (keys64 &gt; 65535) {  // Max code length
+       verify_error(ErrorContext::bad_code(bci), "too many keys in tableswitch");
+       return;
+     }
++    keys = (int)keys64;
+     delta = 1;
+   } else {
+     keys = (int)Bytes::get_Java_u4(aligned_bcp + jintSize);
+diff --git a/hotspot/src/share/vm/interpreter/bytecodes.cpp b/hotspot/src/share/vm/interpreter/bytecodes.cpp
+index 24adc4d9..f0753735 100644
+--- a/hotspot/src/share/vm/interpreter/bytecodes.cpp
++++ b/hotspot/src/share/vm/interpreter/bytecodes.cpp
+@@ -111,12 +111,18 @@ int Bytecodes::special_length_at(Bytecodes::Code code, address bcp, address end)
+       if (end != NULL &amp;&amp; aligned_bcp + 3*jintSize &gt;= end) {
+         return -1; // don't read past end of code buffer
+       }
++      // Promote calculation to signed 64 bits to do range checks, used by the verifier.
+       jlong lo = (jint)Bytes::get_Java_u4(aligned_bcp + 1*jintSize);
+       jlong hi = (jint)Bytes::get_Java_u4(aligned_bcp + 2*jintSize);
+       jlong len = (aligned_bcp - bcp) + (3 + hi - lo + 1)*jintSize;
+-      // only return len if it can be represented as a positive int;
+-      // return -1 otherwise
+-      return (len &gt; 0 &amp;&amp; len == (int)len) ? len : -1;
++      // Only return len if it can be represented as a positive int and lo &lt;= hi.
++      // The caller checks for bytecode stream overflow.
++      if (lo &lt;= hi &amp;&amp; len == (int)len) {
++        assert(len &gt; 0, "must be");
++        return (int)len;
++      } else {
++        return -1;
++      }
+     }
+ 
+   case _lookupswitch:      // fall through
+@@ -128,9 +134,13 @@ int Bytecodes::special_length_at(Bytecodes::Code code, address bcp, address end)
+       }
+       jlong npairs = (jint)Bytes::get_Java_u4(aligned_bcp + jintSize);
+       jlong len = (aligned_bcp - bcp) + (2 + 2*npairs)*jintSize;
+-      // only return len if it can be represented as a positive int;
+-      // return -1 otherwise
+-      return (len &gt; 0 &amp;&amp; len == (int)len) ? len : -1;
++      // Only return len if it can be represented as a positive int and npairs &gt;= 0.
++      if (npairs &gt;= 0 &amp;&amp; len == (int)len) {
++        assert(len &gt; 0, "must be");
++        return (int)len;
++      } else {
++        return -1;
++      }
+     }
+   }
+   // Note: Length functions must return &lt;=0 for invalid bytecodes.
+diff --git a/jdk/src/share/native/common/check_code.c b/jdk/src/share/native/common/check_code.c
+index 96091720..491b95cd 100644
+--- a/jdk/src/share/native/common/check_code.c
++++ b/jdk/src/share/native/common/check_code.c
+@@ -1,5 +1,5 @@
+ /*
+- * Copyright (c) 1994, 2014, Oracle and/or its affiliates. All rights reserved.
++ * Copyright (c) 1994, 2023, Oracle and/or its affiliates. All rights reserved.
+  * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+  *
+  * This code is free software; you can redistribute it and/or modify it
+@@ -84,6 +84,7 @@
+ #include &lt;assert.h&gt;
+ #include &lt;limits.h&gt;
+ #include &lt;stdlib.h&gt;
++#include &lt;stdint.h&gt;
+ 
+ #include "jni.h"
+ #include "jvm.h"
+@@ -1202,7 +1203,7 @@ verify_opcode_operands(context_type *context, unsigned int inumber, int offset)
+             }
+         }
+         if (opcode == JVM_OPC_tableswitch) {
+-            keys = _ck_ntohl(lpc[2]) -  _ck_ntohl(lpc[1]) + 1;
++            keys = _ck_ntohl(lpc[2]) - _ck_ntohl(lpc[1]) + 1;
+             delta = 1;
+         } else {
+             keys = _ck_ntohl(lpc[1]); /* number of pairs */
+@@ -1682,11 +1683,13 @@ static int instruction_length(unsigned char *iptr, unsigned char *end)
+     switch (instruction) {
+         case JVM_OPC_tableswitch: {
+             int *lpc = (int *)UCALIGN(iptr + 1);
+-            int index;
+             if (lpc + 2 &gt;= (int *)end) {
+                 return -1; /* do not read pass the end */
+             }
+-            index = _ck_ntohl(lpc[2]) - _ck_ntohl(lpc[1]);
++            int64_t low  = _ck_ntohl(lpc[1]);
++            int64_t high = _ck_ntohl(lpc[2]);
++            int64_t index = high - low;
++            // The value of low must be less than or equal to high - i.e. index &gt;= 0
+             if ((index &lt; 0) || (index &gt; 65535)) {
+                 return -1;      /* illegal */
+             } else {
+-- 
+2.25.1
+
diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch
new file mode 100644
index 0000000..edce6f0
--- /dev/null
+++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-20921.patch
@@ -0,0 +1,657 @@
+From f7cb28de01117f598ecf48ad58e277c3a4590436 Mon Sep 17 00:00:00 2001
+From: Roland Westrelin <a class="moz-txt-link-rfc2396E" href="mailto:rwestrel@redhat.com">&lt;rwestrel@redhat.com&gt;</a>
+Date: Tue, 7 Nov 2023 11:08:30 +0000
+Subject: [PATCH] 8314307: Improve loop handling
+
+Reviewed-by: mbalao, fferrari, andrew
+Backport-of: 62ac93d145ca9fa1ab0c040533c62c42c202703a
+
+Upstream-Status: Backport [<a class="moz-txt-link-freetext" href="https://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436">https://github.com/openjdk/jdk8u/commit/f7cb28de01117f598ecf48ad58e277c3a4590436</a>]
+CVE: CVE-2024-20921
+Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E" href="mailto:hprajapati@mvista.com">&lt;hprajapati@mvista.com&gt;</a>
+---
+ hotspot/src/share/vm/opto/ifnode.cpp   |  59 +++-
+ hotspot/src/share/vm/opto/loopnode.cpp | 422 ++++++++++++++++++++-----
+ hotspot/src/share/vm/opto/loopnode.hpp |   4 +
+ hotspot/src/share/vm/opto/phaseX.hpp   |   6 +-
+ 4 files changed, 404 insertions(+), 87 deletions(-)
+
+diff --git a/hotspot/src/share/vm/opto/ifnode.cpp b/hotspot/src/share/vm/opto/ifnode.cpp
+index 68f068d0..51579032 100644
+--- a/hotspot/src/share/vm/opto/ifnode.cpp
++++ b/hotspot/src/share/vm/opto/ifnode.cpp
+@@ -882,6 +882,46 @@ Node *IfNode::Ideal(PhaseGVN *phase, bool can_reshape) {
+     // then we are guaranteed to fail, so just start interpreting there.
+     // We 'expand' the top 3 range checks to include all post-dominating
+     // checks.
++    //
++    // Example:
++    // a[i+x] // (1) 1 &lt; x &lt; 6
++    // a[i+3] // (2)
++    // a[i+4] // (3)
++    // a[i+6] // max = max of all constants
++    // a[i+2]
++    // a[i+1] // min = min of all constants
++    //
++    // If x &lt; 3:
++    //   (1) a[i+x]: Leave unchanged
++    //   (2) a[i+3]: Replace with a[i+max] = a[i+6]: i+x &lt; i+3 &lt;= i+6  -&gt; (2) is covered
++    //   (3) a[i+4]: Replace with a[i+min] = a[i+1]: i+1 &lt; i+4 &lt;= i+6  -&gt; (3) and all following checks are covered
++    //   Remove all other a[i+c] checks
++    //
++    // If x &gt;= 3:
++    //   (1) a[i+x]: Leave unchanged
++    //   (2) a[i+3]: Replace with a[i+min] = a[i+1]: i+1 &lt; i+3 &lt;= i+x  -&gt; (2) is covered
++    //   (3) a[i+4]: Replace with a[i+max] = a[i+6]: i+1 &lt; i+4 &lt;= i+6  -&gt; (3) and all following checks are covered
++    //   Remove all other a[i+c] checks
++    //
++    // We only need the top 2 range checks if x is the min or max of all constants.
++    //
++    // This, however, only works if the interval [i+min,i+max] is not larger than max_int (i.e. abs(max - min) &lt; max_int):
++    // The theoretical max size of an array is max_int with:
++    // - Valid index space: [0,max_int-1]
++    // - Invalid index space: [max_int,-1] // max_int, min_int, min_int - 1 ..., -1
++    //
++    // The size of the consecutive valid index space is smaller than the size of the consecutive invalid index space.
++    // If we choose min and max in such a way that:
++    // - abs(max - min) &lt; max_int
++    // - i+max and i+min are inside the valid index space
++    // then all indices [i+min,i+max] must be in the valid index space. Otherwise, the invalid index space must be
++    // smaller than the valid index space which is never the case for any array size.
++    //
++    // Choosing a smaller array size only makes the valid index space smaller and the invalid index space larger and
++    // the argument above still holds.
++    //
++    // Note that the same optimization with the same maximal accepted interval size can also be found in C1.
++    const jlong maximum_number_of_min_max_interval_indices = (jlong)max_jint;
+ 
+     // The top 3 range checks seen
+     const int NRC =3;
+@@ -915,13 +955,18 @@ Node *IfNode::Ideal(PhaseGVN *phase, bool can_reshape) {
+             found_immediate_dominator = true;
+             break;
+           }
+-          // Gather expanded bounds
+-          off_lo = MIN2(off_lo,offset2);
+-          off_hi = MAX2(off_hi,offset2);
+-          // Record top NRC range checks
+-          prev_checks[nb_checks%NRC].ctl = prev_dom;
+-          prev_checks[nb_checks%NRC].off = offset2;
+-          nb_checks++;
++
++          // "x - y" -&gt; must add one to the difference for number of elements in [x,y]
++          const jlong diff = (jlong)MIN2(offset2, off_lo) - (jlong)MAX2(offset2, off_hi);
++          if (ABS(diff) &lt; maximum_number_of_min_max_interval_indices) {
++            // Gather expanded bounds
++            off_lo = MIN2(off_lo, offset2);
++            off_hi = MAX2(off_hi, offset2);
++            // Record top NRC range checks
++            prev_checks[nb_checks % NRC].ctl = prev_dom;
++            prev_checks[nb_checks % NRC].off = offset2;
++            nb_checks++;
++          }
+         }
+       }
+       prev_dom = dom;
+diff --git a/hotspot/src/share/vm/opto/loopnode.cpp b/hotspot/src/share/vm/opto/loopnode.cpp
+index b2d5dccd..8bc9dd29 100644
+--- a/hotspot/src/share/vm/opto/loopnode.cpp
++++ b/hotspot/src/share/vm/opto/loopnode.cpp
+@@ -260,6 +260,49 @@ void PhaseIdealLoop::set_subtree_ctrl( Node *n ) {
+   set_early_ctrl( n );
+ }
+ 
++void PhaseIdealLoop::insert_loop_limit_check(ProjNode* limit_check_proj, Node* cmp_limit, Node* bol) {
++  Node* new_predicate_proj = create_new_if_for_predicate(limit_check_proj, NULL,
++                                                         Deoptimization::Reason_loop_limit_check);
++  Node* iff = new_predicate_proj-&gt;in(0);
++  assert(iff-&gt;Opcode() == Op_If, "bad graph shape");
++  Node* conv = iff-&gt;in(1);
++  assert(conv-&gt;Opcode() == Op_Conv2B, "bad graph shape");
++  Node* opaq = conv-&gt;in(1);
++  assert(opaq-&gt;Opcode() == Op_Opaque1, "bad graph shape");
++  cmp_limit = _igvn.register_new_node_with_optimizer(cmp_limit);
++  bol = _igvn.register_new_node_with_optimizer(bol);
++  set_subtree_ctrl(bol);
++  _igvn.replace_input_of(iff, 1, bol);
++
++#ifndef PRODUCT
++  // report that the loop predication has been actually performed
++  // for this loop
++  if (TraceLoopLimitCheck) {
++    tty-&gt;print_cr("Counted Loop Limit Check generated:");
++    debug_only( bol-&gt;dump(2); )
++  }
++#endif
++}
++
++static int check_stride_overflow(jlong final_correction, const TypeInt* limit_t) {
++  if (final_correction &gt; 0) {
++    if (limit_t-&gt;_lo &gt; (max_jint - final_correction)) {
++      return -1;
++    }
++    if (limit_t-&gt;_hi &gt; (max_jint - final_correction)) {
++      return 1;
++    }
++  } else {
++    if (limit_t-&gt;_hi &lt; (min_jint - final_correction)) {
++      return -1;
++    }
++    if (limit_t-&gt;_lo &lt; (min_jint - final_correction)) {
++      return 1;
++    }
++  }
++  return 0;
++}
++
+ //------------------------------is_counted_loop--------------------------------
+ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+   PhaseGVN *gvn = &amp;_igvn;
+@@ -463,51 +506,256 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+   assert(x-&gt;Opcode() == Op_Loop, "regular loops only");
+   C-&gt;print_method(PHASE_BEFORE_CLOOPS, 3);
+ 
+-  Node *hook = new (C) Node(6);
++  Node* adjusted_limit = limit;
+ 
+   if (LoopLimitCheck) {
+ 
+   // ===================================================
+-  // Generate loop limit check to avoid integer overflow
+-  // in cases like next (cyclic loops):
++  // We can only convert this loop to a counted loop if we can guarantee that the iv phi will never overflow at runtime.
++  // This is an implicit assumption taken by some loop optimizations. We therefore must ensure this property at all cost.
++  // At this point, we've already excluded some trivial cases where an overflow could have been proven statically.
++  // But even though we cannot prove that an overflow will *not* happen, we still want to speculatively convert this loop
++  // to a counted loop. This can be achieved by adding additional iv phi overflow checks before the loop. If they fail,
++  // we trap and resume execution before the loop without having executed any iteration of the loop, yet.
+   //
+-  // for (i=0; i &lt;= max_jint; i++) {}
+-  // for (i=0; i &lt;  max_jint; i+=2) {}
++  // These additional iv phi overflow checks can be inserted as Loop Limit Check Predicates above the Loop Limit Check
++  // Parse Predicate which captures a JVM state just before the entry of the loop. If there is no such Parse Predicate,
++  // we cannot generate a Loop Limit Check Predicate and thus cannot speculatively convert the loop to a counted loop.
+   //
++  // In the following, we only focus on int loops with stride &gt; 0 to keep things simple. The argumentation and proof
++  // for stride &lt; 0 is analogously. For long loops, we would replace max_int with max_long.
+   //
+-  // Limit check predicate depends on the loop test:
+   //
+-  // for(;i != limit; i++)       --&gt; limit &lt;= (max_jint)
+-  // for(;i &lt;  limit; i+=stride) --&gt; limit &lt;= (max_jint - stride + 1)
+-  // for(;i &lt;= limit; i+=stride) --&gt; limit &lt;= (max_jint - stride    )
++  // The loop to be converted does not always need to have the often used shape:
+   //
++  //                                                 i = init
++  //     i = init                                loop:
++  //     do {                                        ...
++  //         // ...               equivalent         i+=stride
++  //         i+=stride               &lt;==&gt;            if (i &lt; limit)
++  //     } while (i &lt; limit);                          goto loop
++  //                                             exit:
++  //                                                 ...
++  //
++  // where the loop exit check uses the post-incremented iv phi and a '&lt;'-operator.
++  //
++  // We could also have '&lt;='-operator (or '&gt;='-operator for negative strides) or use the pre-incremented iv phi value
++  // in the loop exit check:
++  //
++  //         i = init
++  //     loop:
++  //         ...
++  //         if (i &lt;= limit)
++  //             i+=stride
++  //             goto loop
++  //     exit:
++  //         ...
++  //
++  // Let's define the following terms:
++  // - iv_pre_i: The pre-incremented iv phi before the i-th iteration.
++  // - iv_post_i: The post-incremented iv phi after the i-th iteration.
++  //
++  // The iv_pre_i and iv_post_i have the following relation:
++  //      iv_pre_i + stride = iv_post_i
++  //
++  // When converting a loop to a counted loop, we want to have a canonicalized loop exit check of the form:
++  //     iv_post_i &lt; adjusted_limit
++  //
++  // If that is not the case, we need to canonicalize the loop exit check by using different values for adjusted_limit:
++  // (LE1) iv_post_i &lt; limit: Already canonicalized. We can directly use limit as adjusted_limit.
++  //           -&gt; adjusted_limit = limit.
++  // (LE2) iv_post_i &lt;= limit:
++  //           iv_post_i &lt; limit + 1
++  //           -&gt; adjusted limit = limit + 1
++  // (LE3) iv_pre_i &lt; limit:
++  //           iv_pre_i + stride &lt; limit + stride
++  //           iv_post_i &lt; limit + stride
++  //           -&gt; adjusted_limit = limit + stride
++  // (LE4) iv_pre_i &lt;= limit:
++  //           iv_pre_i &lt; limit + 1
++  //           iv_pre_i + stride &lt; limit + stride + 1
++  //           iv_post_i &lt; limit + stride + 1
++  //           -&gt; adjusted_limit = limit + stride + 1
++  //
++  // Note that:
++  //     (AL) limit &lt;= adjusted_limit.
++  //
++  // The following loop invariant has to hold for counted loops with n iterations (i.e. loop exit check true after n-th
++  // loop iteration) and a canonicalized loop exit check to guarantee that no iv_post_i over- or underflows:
++  // (INV) For i = 1..n, min_int &lt;= iv_post_i &lt;= max_int
++  //
++  // To prove (INV), we require the following two conditions/assumptions:
++  // (i): adjusted_limit - 1 + stride &lt;= max_int
++  // (ii): init &lt; limit
++  //
++  // If we can prove (INV), we know that there can be no over- or underflow of any iv phi value. We prove (INV) by
++  // induction by assuming (i) and (ii).
++  //
++  // Proof by Induction
++  // ------------------
++  // &gt; Base case (i = 1): We show that (INV) holds after the first iteration:
++  //     min_int &lt;= iv_post_1 = init + stride &lt;= max_int
++  // Proof:
++  //     First, we note that (ii) implies
++  //         (iii) init &lt;= limit - 1
++  //     max_int &gt;= adjusted_limit - 1 + stride   [using (i)]
++  //             &gt;= limit - 1 + stride            [using (AL)]
++  //             &gt;= init + stride                 [using (iii)]
++  //             &gt;= min_int                       [using stride &gt; 0, no underflow]
++  // Thus, no overflow happens after the first iteration and (INV) holds for i = 1.
++  //
++  // Note that to prove the base case we need (i) and (ii).
++  //
++  // &gt; Induction Hypothesis (i = j, j &gt; 1): Assume that (INV) holds after the j-th iteration:
++  //     min_int &lt;= iv_post_j &lt;= max_int
++  // &gt; Step case (i = j + 1): We show that (INV) also holds after the j+1-th iteration:
++  //     min_int &lt;= iv_post_{j+1} = iv_post_j + stride &lt;= max_int
++  // Proof:
++  // If iv_post_j &gt;= adjusted_limit:
++  //     We exit the loop after the j-th iteration, and we don't execute the j+1-th iteration anymore. Thus, there is
++  //     also no iv_{j+1}. Since (INV) holds for iv_j, there is nothing left to prove.
++  // If iv_post_j &lt; adjusted_limit:
++  //     First, we note that:
++  //         (iv) iv_post_j &lt;= adjusted_limit - 1
++  //     max_int &gt;= adjusted_limit - 1 + stride    [using (i)]
++  //             &gt;= iv_post_j + stride             [using (iv)]
++  //             &gt;= min_int                        [using stride &gt; 0, no underflow]
++  //
++  // Note that to prove the step case we only need (i).
++  //
++  // Thus, by assuming (i) and (ii), we proved (INV).
++  //
++  //
++  // It is therefore enough to add the following two Loop Limit Check Predicates to check assumptions (i) and (ii):
++  //
++  // (1) Loop Limit Check Predicate for (i):
++  //     Using (i): adjusted_limit - 1 + stride &lt;= max_int
++  //
++  //     This condition is now restated to use limit instead of adjusted_limit:
++  //
++  //     To prevent an overflow of adjusted_limit -1 + stride itself, we rewrite this check to
++  //         max_int - stride + 1 &gt;= adjusted_limit
++  //     We can merge the two constants into
++  //         canonicalized_correction = stride - 1
++  //     which gives us
++  //        max_int - canonicalized_correction &gt;= adjusted_limit
++  //
++  //     To directly use limit instead of adjusted_limit in the predicate condition, we split adjusted_limit into:
++  //         adjusted_limit = limit + limit_correction
++  //     Since stride &gt; 0 and limit_correction &lt;= stride + 1, we can restate this with no over- or underflow into:
++  //         max_int - canonicalized_correction - limit_correction &gt;= limit
++  //     Since canonicalized_correction and limit_correction are both constants, we can replace them with a new constant:
++  //         final_correction = canonicalized_correction + limit_correction
++  //     which gives us:
++  //
++  //     Final predicate condition:
++  //         max_int - final_correction &gt;= limit
++  //
++  // (2) Loop Limit Check Predicate for (ii):
++  //     Using (ii): init &lt; limit
++  //
++  //     This Loop Limit Check Predicate is not required if we can prove at compile time that either:
++  //        (2.1) type(init) &lt; type(limit)
++  //             In this case, we know:
++  //                 all possible values of init &lt; all possible values of limit
++  //             and we can skip the predicate.
++  //
++  //        (2.2) init &lt; limit is already checked before (i.e. found as a dominating check)
++  //            In this case, we do not need to re-check the condition and can skip the predicate.
++  //            This is often found for while- and for-loops which have the following shape:
++  //
++  //                if (init &lt; limit) { // Dominating test. Do not need the Loop Limit Check Predicate below.
++  //                    i = init;
++  //                    if (init &gt;= limit) { trap(); } // Here we would insert the Loop Limit Check Predicate
++  //                    do {
++  //                        i += stride;
++  //                    } while (i &lt; limit);
++  //                }
++  //
++  //        (2.3) init + stride &lt;= max_int
++  //            In this case, there is no overflow of the iv phi after the first loop iteration.
++  //            In the proof of the base case above we showed that init + stride &lt;= max_int by using assumption (ii):
++  //                init &lt; limit
++  //            In the proof of the step case above, we did not need (ii) anymore. Therefore, if we already know at
++  //            compile time that init + stride &lt;= max_int then we have trivially proven the base case and that
++  //            there is no overflow of the iv phi after the first iteration. In this case, we don't need to check (ii)
++  //            again and can skip the predicate.
++
++
++  // Accounting for (LE3) and (LE4) where we use pre-incremented phis in the loop exit check.
++  const jlong limit_correction_for_pre_iv_exit_check = (phi_incr != NULL) ? stride_con : 0;
++
++  // Accounting for (LE2) and (LE4) where we use &lt;= or &gt;= in the loop exit check.
++  const bool includes_limit = (bt == BoolTest::le || bt == BoolTest::ge);
++  const jlong limit_correction_for_le_ge_exit_check = (includes_limit ? (stride_con &gt; 0 ? 1 : -1) : 0);
++
++  const jlong limit_correction = limit_correction_for_pre_iv_exit_check + limit_correction_for_le_ge_exit_check;
++  const jlong canonicalized_correction = stride_con + (stride_con &gt; 0 ? -1 : 1);
++  const jlong final_correction = canonicalized_correction + limit_correction;
++
++  int sov = check_stride_overflow(final_correction, limit_t);
++
++  // If sov==0, limit's type always satisfies the condition, for
++  // example, when it is an array length.
++  if (sov != 0) {
++    if (sov &lt; 0) {
++      return false;  // Bailout: integer overflow is certain.
++    }
++    // (1) Loop Limit Check Predicate is required because we could not statically prove that
++    //     limit + final_correction = adjusted_limit - 1 + stride &lt;= max_int
++    ProjNode *limit_check_proj = find_predicate_insertion_point(init_control, Deoptimization::Reason_loop_limit_check);
++    if (!limit_check_proj) {
++      // The Loop Limit Check Parse Predicate is not generated if this method trapped here before.
++#ifdef ASSERT
++      if (TraceLoopLimitCheck) {
++        tty-&gt;print("missing loop limit check:");
++        loop-&gt;dump_head();
++        x-&gt;dump(1);
++      }
++#endif
++      return false;
++    }
+ 
+-  // Check if limit is excluded to do more precise int overflow check.
+-  bool incl_limit = (bt == BoolTest::le || bt == BoolTest::ge);
+-  int stride_m  = stride_con - (incl_limit ? 0 : (stride_con &gt; 0 ? 1 : -1));
+-
+-  // If compare points directly to the phi we need to adjust
+-  // the compare so that it points to the incr. Limit have
+-  // to be adjusted to keep trip count the same and the
+-  // adjusted limit should be checked for int overflow.
+-  if (phi_incr != NULL) {
+-    stride_m  += stride_con;
+-  }
++    IfNode* check_iff = limit_check_proj-&gt;in(0)-&gt;as_If();
+ 
+-  if (limit-&gt;is_Con()) {
+-    int limit_con = limit-&gt;get_int();
+-    if ((stride_con &gt; 0 &amp;&amp; limit_con &gt; (max_jint - stride_m)) ||
+-        (stride_con &lt; 0 &amp;&amp; limit_con &lt; (min_jint - stride_m))) {
+-      // Bailout: it could be integer overflow.
++    if (!is_dominator(get_ctrl(limit), check_iff-&gt;in(0))) {
+       return false;
+     }
+-  } else if ((stride_con &gt; 0 &amp;&amp; limit_t-&gt;_hi &lt;= (max_jint - stride_m)) ||
+-             (stride_con &lt; 0 &amp;&amp; limit_t-&gt;_lo &gt;= (min_jint - stride_m))) {
+-      // Limit's type may satisfy the condition, for example,
+-      // when it is an array length.
+-  } else {
+-    // Generate loop's limit check.
+-    // Loop limit check predicate should be near the loop.
++
++    Node* cmp_limit;
++    Node* bol;
++
++    if (stride_con &gt; 0) {
++      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(max_jint - final_correction));
++      bol = new (C) BoolNode(cmp_limit, BoolTest::le);
++    } else {
++      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(min_jint - final_correction));
++      bol = new (C) BoolNode(cmp_limit, BoolTest::ge);
++    }
++
++    insert_loop_limit_check(limit_check_proj, cmp_limit, bol);
++  }
++
++  // (2.3)
++  const bool init_plus_stride_could_overflow =
++          (stride_con &gt; 0 &amp;&amp; init_t-&gt;_hi &gt; max_jint - stride_con) ||
++          (stride_con &lt; 0 &amp;&amp; init_t-&gt;_lo &lt; min_jint - stride_con);
++  // (2.1)
++  const bool init_gte_limit = (stride_con &gt; 0 &amp;&amp; init_t-&gt;_hi &gt;= limit_t-&gt;_lo) ||
++                              (stride_con &lt; 0 &amp;&amp; init_t-&gt;_lo &lt;= limit_t-&gt;_hi);
++
++  if (init_gte_limit &amp;&amp; // (2.1)
++     ((bt == BoolTest::ne || init_plus_stride_could_overflow) &amp;&amp; // (2.3)
++      !has_dominating_loop_limit_check(init_trip, limit, stride_con, init_control))) { // (2.2)
++    // (2) Iteration Loop Limit Check Predicate is required because neither (2.1), (2.2), nor (2.3) holds.
++    // We use the following condition:
++    // - stride &gt; 0: init &lt; limit
++    // - stride &lt; 0: init &gt; limit
++    //
++    // This predicate is always required if we have a non-equal-operator in the loop exit check (where stride = 1 is
++    // a requirement). We transform the loop exit check by using a less-than-operator. By doing so, we must always
++    // check that init &lt; limit. Otherwise, we could have a different number of iterations at runtime.
++
+     ProjNode *limit_check_proj = find_predicate_insertion_point(init_control, Deoptimization::Reason_loop_limit_check);
+     if (!limit_check_proj) {
+       // The limit check predicate is not generated if this method trapped here before.
+@@ -520,41 +768,38 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+ #endif
+       return false;
+     }
+-
+     IfNode* check_iff = limit_check_proj-&gt;in(0)-&gt;as_If();
++
++    if (!is_dominator(get_ctrl(limit), check_iff-&gt;in(0)) ||
++        !is_dominator(get_ctrl(init_trip), check_iff-&gt;in(0))) {
++      return false;
++    }
++
+     Node* cmp_limit;
+     Node* bol;
+ 
+     if (stride_con &gt; 0) {
+-      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(max_jint - stride_m));
+-      bol = new (C) BoolNode(cmp_limit, BoolTest::le);
++      cmp_limit = new (C) CmpINode(init_trip, limit);
++      bol = new (C) BoolNode(cmp_limit, BoolTest::lt);
+     } else {
+-      cmp_limit = new (C) CmpINode(limit, _igvn.intcon(min_jint - stride_m));
+-      bol = new (C) BoolNode(cmp_limit, BoolTest::ge);
++      cmp_limit = new (C) CmpINode(init_trip, limit);
++      bol = new (C) BoolNode(cmp_limit, BoolTest::gt);
+     }
+-    cmp_limit = _igvn.register_new_node_with_optimizer(cmp_limit);
+-    bol = _igvn.register_new_node_with_optimizer(bol);
+-    set_subtree_ctrl(bol);
+-
+-    // Replace condition in original predicate but preserve Opaque node
+-    // so that previous predicates could be found.
+-    assert(check_iff-&gt;in(1)-&gt;Opcode() == Op_Conv2B &amp;&amp;
+-           check_iff-&gt;in(1)-&gt;in(1)-&gt;Opcode() == Op_Opaque1, "");
+-    Node* opq = check_iff-&gt;in(1)-&gt;in(1);
+-    _igvn.hash_delete(opq);
+-    opq-&gt;set_req(1, bol);
+-    // Update ctrl.
+-    set_ctrl(opq, check_iff-&gt;in(0));
+-    set_ctrl(check_iff-&gt;in(1), check_iff-&gt;in(0));
+ 
+-#ifndef PRODUCT
+-    // report that the loop predication has been actually performed
+-    // for this loop
+-    if (TraceLoopLimitCheck) {
+-      tty-&gt;print_cr("Counted Loop Limit Check generated:");
+-      debug_only( bol-&gt;dump(2); )
++    insert_loop_limit_check(limit_check_proj, cmp_limit, bol);
++  }
++
++  if (bt == BoolTest::ne) {
++    // Now we need to canonicalize the loop condition if it is 'ne'.
++    assert(stride_con == 1 || stride_con == -1, "simple increment only - checked before");
++    if (stride_con &gt; 0) {
++      // 'ne' can be replaced with 'lt' only when init &lt; limit. This is ensured by the inserted predicate above.
++      bt = BoolTest::lt;
++    } else {
++      assert(stride_con &lt; 0, "must be");
++      // 'ne' can be replaced with 'gt' only when init &gt; limit. This is ensured by the inserted predicate above.
++      bt = BoolTest::gt;
+     }
+-#endif
+   }
+ 
+   if (phi_incr != NULL) {
+@@ -567,26 +812,15 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+     // is converted to
+     //   i = init; do {} while(++i &lt; limit+1);
+     //
+-    limit = gvn-&gt;transform(new (C) AddINode(limit, stride));
+-  }
+-
+-  // Now we need to canonicalize loop condition.
+-  if (bt == BoolTest::ne) {
+-    assert(stride_con == 1 || stride_con == -1, "simple increment only");
+-    // 'ne' can be replaced with 'lt' only when init &lt; limit.
+-    if (stride_con &gt; 0 &amp;&amp; init_t-&gt;_hi &lt; limit_t-&gt;_lo)
+-      bt = BoolTest::lt;
+-    // 'ne' can be replaced with 'gt' only when init &gt; limit.
+-    if (stride_con &lt; 0 &amp;&amp; init_t-&gt;_lo &gt; limit_t-&gt;_hi)
+-      bt = BoolTest::gt;
++    adjusted_limit = gvn-&gt;transform(new (C) AddINode(limit, stride));
+   }
+ 
+-  if (incl_limit) {
++  if (includes_limit) {
+     // The limit check guaranties that 'limit &lt;= (max_jint - stride)' so
+     // we can convert 'i &lt;= limit' to 'i &lt; limit+1' since stride != 0.
+     //
+     Node* one = (stride_con &gt; 0) ? gvn-&gt;intcon( 1) : gvn-&gt;intcon(-1);
+-    limit = gvn-&gt;transform(new (C) AddINode(limit, one));
++    adjusted_limit = gvn-&gt;transform(new (C) AddINode(adjusted_limit, one));
+     if (bt == BoolTest::le)
+       bt = BoolTest::lt;
+     else if (bt == BoolTest::ge)
+@@ -594,10 +828,11 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+     else
+       ShouldNotReachHere();
+   }
+-  set_subtree_ctrl( limit );
++  set_subtree_ctrl(adjusted_limit);
+ 
+   } else { // LoopLimitCheck
+ 
++  Node *hook = new (C) Node(6);
+   // If compare points to incr, we are ok.  Otherwise the compare
+   // can directly point to the phi; in this case adjust the compare so that
+   // it points to the incr by adjusting the limit.
+@@ -691,6 +926,11 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+   limit = gvn-&gt;transform(new (C) AddINode(span,init_trip));
+   set_subtree_ctrl( limit );
+ 
++  adjusted_limit = limit;
++
++  // Free up intermediate goo
++  _igvn.remove_dead_node(hook);
++
+   } // LoopLimitCheck
+ 
+   if (!UseCountedLoopSafepoints) {
+@@ -728,7 +968,7 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+   }
+   cmp = cmp-&gt;clone();
+   cmp-&gt;set_req(1,incr);
+-  cmp-&gt;set_req(2,limit);
++  cmp-&gt;set_req(2, adjusted_limit);
+   cmp = _igvn.register_new_node_with_optimizer(cmp);
+   set_ctrl(cmp, iff-&gt;in(0));
+ 
+@@ -802,9 +1042,6 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+     }
+   }
+ 
+-  // Free up intermediate goo
+-  _igvn.remove_dead_node(hook);
+-
+ #ifdef ASSERT
+   assert(l-&gt;is_valid_counted_loop(), "counted loop shape is messed up");
+   assert(l == loop-&gt;_head &amp;&amp; l-&gt;phi() == phi &amp;&amp; l-&gt;loopexit() == lex, "" );
+@@ -821,6 +1058,37 @@ bool PhaseIdealLoop::is_counted_loop( Node *x, IdealLoopTree *loop ) {
+   return true;
+ }
+ 
++// Check if there is a dominating loop limit check of the form 'init &lt; limit' starting at the loop entry.
++// If there is one, then we do not need to create an additional Loop Limit Check Predicate.
++bool PhaseIdealLoop::has_dominating_loop_limit_check(Node* init_trip, Node* limit, const int stride_con,
++                                                     Node* loop_entry) {
++  // Eagerly call transform() on the Cmp and Bool node to common them up if possible. This is required in order to
++  // successfully find a dominated test with the If node below.
++  Node* cmp_limit;
++  Node* bol;
++  if (stride_con &gt; 0) {
++    cmp_limit = _igvn.transform(new (C) CmpINode(init_trip, limit));
++    bol = _igvn.transform(new (C) BoolNode(cmp_limit, BoolTest::lt));
++  } else {
++    cmp_limit = _igvn.transform(new (C) CmpINode(init_trip, limit));
++    bol = _igvn.transform(new (C) BoolNode(cmp_limit, BoolTest::gt));
++  }
++
++  // Check if there is already a dominating init &lt; limit check. If so, we do not need a Loop Limit Check Predicate.
++  IfNode* iff = new (C) IfNode(loop_entry, bol, PROB_MIN, COUNT_UNKNOWN);
++  // Also add fake IfProj nodes in order to call transform() on the newly created IfNode.
++  IfFalseNode* if_false = new (C) IfFalseNode(iff);
++  IfTrueNode* if_true = new (C) IfTrueNode(iff);
++  Node* dominated_iff = _igvn.transform(iff);
++  // ConI node? Found dominating test (IfNode::dominated_by() returns a ConI node).
++  const bool found_dominating_test = dominated_iff != NULL &amp;&amp; dominated_iff-&gt;Opcode() == Op_ConI;
++
++  // Kill the If with its projections again in the next IGVN round by cutting it off from the graph.
++  _igvn.replace_input_of(iff, 0, C-&gt;top());
++  _igvn.replace_input_of(iff, 1, C-&gt;top());
++  return found_dominating_test;
++}
++
+ //----------------------exact_limit-------------------------------------------
+ Node* PhaseIdealLoop::exact_limit( IdealLoopTree *loop ) {
+   assert(loop-&gt;_head-&gt;is_CountedLoop(), "");
+diff --git a/hotspot/src/share/vm/opto/loopnode.hpp b/hotspot/src/share/vm/opto/loopnode.hpp
+index 55a7def3..3ae41f8d 100644
+--- a/hotspot/src/share/vm/opto/loopnode.hpp
++++ b/hotspot/src/share/vm/opto/loopnode.hpp
+@@ -896,6 +896,10 @@ public:
+   // Create a new if above the uncommon_trap_if_pattern for the predicate to be promoted
+   ProjNode* create_new_if_for_predicate(ProjNode* cont_proj, Node* new_entry,
+                                         Deoptimization::DeoptReason reason);
++  void insert_loop_limit_check(ProjNode* limit_check_proj, Node* cmp_limit, Node* bol);
++  bool has_dominating_loop_limit_check(Node* init_trip, Node* limit, int stride_con,
++                                       Node* loop_entry);
++
+   void register_control(Node* n, IdealLoopTree *loop, Node* pred);
+ 
+   // Clone loop predicates to cloned loops (peeled, unswitched)
+diff --git a/hotspot/src/share/vm/opto/phaseX.hpp b/hotspot/src/share/vm/opto/phaseX.hpp
+index a2a2a538..bd7393ac 100644
+--- a/hotspot/src/share/vm/opto/phaseX.hpp
++++ b/hotspot/src/share/vm/opto/phaseX.hpp
+@@ -431,9 +431,6 @@ private:
+ 
+ protected:
+ 
+-  // Idealize new Node 'n' with respect to its inputs and its value
+-  virtual Node *transform( Node *a_node );
+-
+   // Warm up hash table, type table and initial worklist
+   void init_worklist( Node *a_root );
+ 
+@@ -447,6 +444,9 @@ public:
+   PhaseIterGVN( PhaseGVN *gvn ); // Used after Parser
+   PhaseIterGVN( PhaseIterGVN *igvn, const char *dummy ); // Used after +VerifyOpto
+ 
++  // Idealize new Node 'n' with respect to its inputs and its value
++  virtual Node *transform( Node *a_node );
++
+   virtual PhaseIterGVN *is_IterGVN() { return this; }
+ 
+   Unique_Node_List _worklist;       // Iterative worklist
+-- 
+2.25.1
+
</pre>
    </blockquote>
    <div class="moz-signature">-- <br>
      <font color="#0000FF">
        Regards,<br>
        Hitendra Prajapati<br>
        MontaVista Software LLC<br>
        Mo: +91 9998906483 <br>
      </font></div>
  </body>
</html>

--------------7WLfVxn0jzIaGzVsJPc02c0d--

