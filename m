Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9FC30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 07:39:57 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.19339.1719905990447193245
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jul 2024 00:39:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=hVs+asU2;
 spf=pass (domain: mvista.com, ip: 209.85.219.171, mailfrom: rsangam@mvista.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so3939911276.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719905989; x=1720510789; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEKoCNlORV05sgEZksE+Kr6SsHTAxVvlwxhBv56qMI=;
        b=hVs+asU2u0hakgJj6o/g4BDMZCXcDwvJ4rgURrM+7b93wf+gmMUzy9tffnHIb3wZUW
         mAkODL2l1iqN9zX2wqy5728QklzTsrVU2HwkhOX5d1t6g+u+FfxmB8uF4e4dJDYGO27M
         eoCQcYNdfQmO3dBTFM95q7Hw5yOU8QOV09gAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905989; x=1720510789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVEKoCNlORV05sgEZksE+Kr6SsHTAxVvlwxhBv56qMI=;
        b=ald6QhhRJrhIHUrFrPWdJCQ5MtMMFMFubYFgdqY/8xyTAF/sdgUrB29qHW/uHFp+9f
         mIS0UoPU/DGqera+8icBuf4qTWx7TkNFCaA4UmXkGgH7t6I4Ew52jKxTqkFFnSwMSRmP
         8z0EqoJlH7qjx/ClHFHagNRiWjV+Koxb5dXisi74o3H8RXYAi3J3VUC3UMJXQQ6iWig1
         /DZusuZGB+5xtfeFIqMRiS59+O34s5dbo0ItBVqvniQV/trRmRePhEsT/fatCdFJb3OO
         3oVfVov87KUMT9CV+gyLxFOimiKpWSBiqf7XyBEuvEeQgXalSZLCXUYvOkXY8rrtg8oS
         QxlA==
X-Gm-Message-State: AOJu0YxlnnFoVYwcv1Z0ychPus12bGGryes2bkYSn5cy3CCkM2+6VWHu
	DwBxa0Sfeutt9SoR5JssGiSLkRT/MHRLuFyLUgSjBzEAM7PiUks+SHJP7HYPRbEDJlCatWaxxc5
	E
X-Google-Smtp-Source: AGHT+IFW5CEBYhzALxXCksz+6erFGDbOmMO5OMbeY6g6XH537154GSrdZOTT0Qio7/F65yK3LXhxZg==
X-Received: by 2002:a25:a128:0:b0:dff:2e22:a188 with SMTP id 3f1490d57ef6-e036eaf7d99mr9032705276.1.1719905988717;
        Tue, 02 Jul 2024 00:39:48 -0700 (PDT)
Received: from MVIN00040.mvista.com ([49.207.211.89])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e036346ef9csm1298939276.47.2024.07.02.00.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:39:47 -0700 (PDT)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>,
	Siddharth Doshi <sdoshi@mvista.com>
Subject: [meta-java][master][PATCH] openjdk-8: Security fix for CVE-2024-21094
Date: Tue,  2 Jul 2024 13:09:34 +0530
Message-Id: <20240702073934.21734-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 07:39:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/407

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


