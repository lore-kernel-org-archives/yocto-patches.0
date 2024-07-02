Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CD0C3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 07:05:27 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web10.18698.1719903917705191555
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jul 2024 00:05:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=kmQKwbbl;
 spf=pass (domain: mvista.com, ip: 209.85.128.172, mailfrom: rsangam@mvista.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64a6bf15db9so32448587b3.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719903916; x=1720508716; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEKoCNlORV05sgEZksE+Kr6SsHTAxVvlwxhBv56qMI=;
        b=kmQKwbbl5sSHuOPXRh7gXRBa06xcnUcPY1hyPHrOs7C7gQT/yqpPu0re2xBaMaTUHp
         WuwfN1RKzVZQ4JCzGAWg/sgMqi8yA3pCPAyN3H6g4JHLKYc8n1xQ9/eULvbCup507l5g
         ReR3/YQen1WJSMerrjzlD+M5u9zGHzfPAAO2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903916; x=1720508716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVEKoCNlORV05sgEZksE+Kr6SsHTAxVvlwxhBv56qMI=;
        b=LclAB3bDZOy/Tb17YdObXGtdMDaXwuSOKqWHDLvPgNCJBZqjHKjnf+GkOtjAHgp3Zc
         wEjcFvKWT/hdijnJsztgV2YCACFPw2SpsWDaYnc7/NkSq9/1zENq5k6MwVNg2k5ct5sf
         cPWf6OixQDpLYAsoVfSqfZDe8wG9XpUAnMeHSOXo25VgFpfZGHvNnHNFuV99Aj12Gxgm
         vJjSM4k9VlgCUAJyDTtoqjRS1gJjh07gdYXVS2dEyL1vLQ+wKmZO1/pozkkGFC/9zzx+
         e7nwwD2Qk/QyC86Gt8BGZCHu8gIG/lb+Fp8htCz31lkT5pd/i8Fmo1qgtl2zZRqlF42Z
         VGHg==
X-Gm-Message-State: AOJu0YytylNlmQhiDWAhQgMmFaqKsfmYEc83tqftGEODmwENiPIzlGQQ
	ibXNl8Sy6CY2VrGnO0JLD1Spz/Lm0Xnq6QztR1ywDj/SYUORfGIOilfikimfkADoSNsZCZCqMiK
	G
X-Google-Smtp-Source: AGHT+IF0NwaPVH9Hu5wZCI0HtcJeL9kHwaDQ5x9S1Yew7zzPhMNtLDEqyL0ERH61xkRJ01HtYNLMXg==
X-Received: by 2002:a81:7c46:0:b0:632:7161:d16c with SMTP id 00721157ae682-64c71ec64d5mr73337427b3.28.1719903916205;
        Tue, 02 Jul 2024 00:05:16 -0700 (PDT)
Received: from MVIN00040.mvista.com ([49.207.211.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9bb50350sm16617767b3.90.2024.07.02.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:05:15 -0700 (PDT)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>,
	Siddharth Doshi <sdoshi@mvista.com>
Subject: [meta-java][kirkstone][PATCH] openjdk-8: Security fix for CVE-2024-21094
Date: Tue,  2 Jul 2024 12:35:07 +0530
Message-Id: <20240702070507.18385-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 07:05:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/406

CVE fixed:
-CVE-2024-21094 OpenJDK: C2 compilation fails with "Exceeded _node_regs array" (8317507)
Upstream-Status: Backport from https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb071301bd3

Signed-off-by: Rohini Sangam <rsangam@mvista.com>
Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
---
 .../openjdk/openjdk-8-release-common.inc      |   1 +
 .../patches-openjdk-8/CVE-2024-21094.patch    | 637 ++++++++++++++++++
 2 files changed, 638 insertions(+)
 create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch

diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipes-core/openjdk/openjdk-8-release-common.inc
index ff8d96e..f71eb10 100644
--- a/recipes-core/openjdk/openjdk-8-release-common.inc
+++ b/recipes-core/openjdk/openjdk-8-release-common.inc
@@ -21,6 +21,7 @@ PATCHES_URI = "\
     file://2007-jdk-no-genx11-in-headless.patch \
     file://2008-jdk-no-unused-deps.patch \
     file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch \
+    file://CVE-2024-21094.patch \
 "
 HOTSPOT_UB_PATCH = "\
     file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch \
diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
new file mode 100644
index 0000000..1852bd7
--- /dev/null
+++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
@@ -0,0 +1,637 @@
+From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:00:00 2001
+From: Martin Balao <mbalao@openjdk.org>
+Date: Wed, 27 Mar 2024 03:21:25 +0000
+Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fails with "Exceeded _node_regs
+ array"
+
+Upstream-Status: Backport from https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb071301bd3
+CVE: CVE-2024-21094
+
+Signed-off-by: Rohini Sangam <rsangam@mvista.com>
+---
+ .../hotspot/src/share/vm/adlc/output_c.cpp    |   2 +
+ .../regalloc/TestNodeRegArrayOverflow.java    | 599 ++++++++++++++++++
+ 2 files changed, 601 insertions(+)
+ create mode 100644 hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
+
+diff --git a/hotspot/src/share/vm/adlc/output_c.cpp b/hotspot/src/share/vm/adlc/output_c.cpp
+index 19916904..b85123b4 100644
+--- a/hotspot/src/share/vm/adlc/output_c.cpp
++++ b/hotspot/src/share/vm/adlc/output_c.cpp
+@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bool used, FILE *fp_cpp) {
+     fprintf(fp_cpp, "    if( i != cisc_operand() ) \n");
+     fprintf(fp_cpp, "      to[i] = _opnds[i]->clone(C);\n");
+     fprintf(fp_cpp, "  }\n");
++    fprintf(fp_cpp, "  // Do not increment node index counter, since node reuses my index\n");
++    fprintf(fp_cpp, "  C->set_unique(C->unique() - 1);\n");
+     fprintf(fp_cpp, "}\n");
+   }
+   fprintf(fp_cpp, "\n");
+diff --git a/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
+new file mode 100644
+index 00000000..281524cc
+--- /dev/null
++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
+@@ -0,0 +1,599 @@
++/*
++ * Copyright (c) 2023, Oracle and/or its affiliates. All rights reserved.
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
++ * or visit www.oracle.com if you need additional information or have any
++ * questions.
++ */
++
++package compiler.regalloc;
++
++/**
++ * @test
++ * @bug 8317507
++ * @summary Test that C2's PhaseRegAlloc::_node_regs (a post-register-allocation
++ *          mapping from machine nodes to assigned registers) does not overflow
++ *          in the face of a program with a high-density of CISC spilling
++ *          candidate nodes.
++ * @run main/othervm -Xcomp -XX:CompileOnly=compiler.regalloc.TestNodeRegArrayOverflow::testWithCompilerUnrolling
++                     -XX:CompileCommand=dontinline,compiler.regalloc.TestNodeRegArrayOverflow::dontInline
++                     compiler.regalloc.TestNodeRegArrayOverflow compiler
++ * @run main/othervm -Xcomp -XX:CompileOnly=compiler.regalloc.TestNodeRegArrayOverflow::testWithManualUnrolling
++                     -XX:CompileCommand=dontinline,compiler.regalloc.TestNodeRegArrayOverflow::dontInline
++                     compiler.regalloc.TestNodeRegArrayOverflow manual
++ */
++
++public class TestNodeRegArrayOverflow {
++
++    static int dontInline() {
++        return 0;
++    }
++
++    static float testWithCompilerUnrolling(float inc) {
++        int i = 0, j = 0;
++        // This non-inlined method call causes 'inc' to be spilled.
++        float f = dontInline();
++        // This two-level reduction loop is unrolled 512 times, which is
++        // requested by the SLP-specific unrolling analysis, but not vectorized.
++        // Because 'inc' is spilled, each of the unrolled AddF nodes is
++        // CISC-spill converted (PhaseChaitin::fixup_spills()). Before the fix,
++        // this causes the unique node index counter (Compile::_unique) to grow
++        // beyond the size of the node register array
++        // (PhaseRegAlloc::_node_regs), and leads to overflow when accessed for
++        // nodes that are created later (e.g. during the peephole phase).
++        while (i++ < 128) {
++            for (j = 0; j < 16; j++) {
++                f += inc;
++            }
++        }
++        return f;
++    }
++
++    // This test reproduces the same failure as 'testWithCompilerUnrolling'
++    // without relying on loop transformations.
++    static float testWithManualUnrolling(float inc) {
++        int i = 0, j = 0;
++        float f = dontInline();
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        f += inc;
++        return f;
++    }
++
++    public static void main(String[] args) {
++        switch (args[0]) {
++        case "compiler":
++            testWithCompilerUnrolling(0);
++            break;
++        case "manual":
++            testWithManualUnrolling(0);
++            break;
++        default:
++            throw new IllegalArgumentException("Invalid mode: " + args[0]);
++        }
++    }
++}
+-- 
+2.35.7
+
-- 
2.34.1


