Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26269C3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 04:19:52 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.7952.1721189983651156793
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Jul 2024 21:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=OsogLFDb;
 spf=pass (domain: mvista.com, ip: 209.85.167.48, mailfrom: rsangam@mvista.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso8992081e87.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Jul 2024 21:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1721189981; x=1721794781; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyGRMO6GWXH2nC2T0KFIPICwHJtKiYB1AMKB26TcjRs=;
        b=OsogLFDbUrmgWOmkOJdna8cjnl8Tmr97+KMSik/KVdNex8eY904A0bjN2VpLExqhwf
         jgYGXyCOSQ4ZkKmNhFQKPRSfNx0b6YnSh67KqgZuIad1x6njY9vcy0fQBMnYd37WjynL
         176Cg9PugJ+XMY4Iin2mG64yNh/kMWihRTmc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721189981; x=1721794781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyGRMO6GWXH2nC2T0KFIPICwHJtKiYB1AMKB26TcjRs=;
        b=oJgzO52ZudcadkmEQIul2Tnqan83UduB1C2mweY2CuVB+oF8QnoJSLqlXI3uDSnm38
         i3n7hOMX9Ovj2tD99wWGCmlEOAHYKdSjj2QEZa5p+sC5dQnHb7hZu5CPiMxbzrHORYkW
         XqON+u8bdgLx/Ftzh28bu3haWCpIL4P8UcZgsIrWhL4shgpKOKP5mSuNBzFzdnDiC9yV
         fPSVmvE5wwoYgZUYvoFUZfB0C2ovWsKKW9u89mEZnvM974fUnhTEp0BJHZx0Z7iCGcBd
         nndg3U+j9kr7FD1A3Kp0aA5WcucXZ/OgKxMWqHL/UbkwoDlzWEySbEt2qWBdx6q4ncg9
         VU7g==
X-Gm-Message-State: AOJu0Yy2HsY+FCpP/FJ8gWOgrtGTsO9wlhoqSj9ErxsxU7NMK07zFczd
	nCrC3UT22l0I01YFnVRBc5a6A/b1THYSAryvOAO+zLTZ6YGXBFcWDAW6+kI8vxf70eU/KDkhTSW
	U75TbLUPJ0pQkH4KdEJ/qaPegJeZjOTDy1i3JlycfwkBOSYmLzfY=
X-Google-Smtp-Source: AGHT+IH+diTnCYpDL+b9fNwV66+kYAS9Ck4Det3Rr90EM1TNTAJ+DoDxQ1MjobNd/cOyRusYK/qSAdevZqjQmrACguM=
X-Received: by 2002:a05:6512:b9e:b0:52c:df55:e110 with SMTP id
 2adb3069b0e04-52ee53a7675mr390487e87.12.1721189980763; Tue, 16 Jul 2024
 21:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240702073934.21734-1-rsangam@mvista.com> <CAL7QmvCeuw71G0Y3AoeRwq8WbNApsMCpVbdMNfh6c8hWc8dGAQ@mail.gmail.com>
In-Reply-To: <CAL7QmvCeuw71G0Y3AoeRwq8WbNApsMCpVbdMNfh6c8hWc8dGAQ@mail.gmail.com>
From: Rohini Sangam <rsangam@mvista.com>
Date: Wed, 17 Jul 2024 09:49:29 +0530
Message-ID: <CAL7QmvC0YoYeYwZgfSvV=RLCmGqNbRE1RgmDKccBvXFQVwDOOw@mail.gmail.com>
Subject: Re: [meta-java][master][PATCH] openjdk-8: Security fix for CVE-2024-21094
To: yocto-patches@lists.yoctoproject.org
Cc: Siddharth Doshi <sdoshi@mvista.com>
Content-Type: multipart/alternative; boundary="0000000000006517e6061d69c5e0"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 04:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/435

--0000000000006517e6061d69c5e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle reminder!!!
Any update on this ??

Regards,
Rohini Sangam

On Thu, Jul 11, 2024 at 12:37=E2=80=AFPM Rohini Sangam <rsangam@mvista.com>=
 wrote:

> Gentle reminder!!!
> Any update on this ??
>
> Regards,
> Rohini Sangam
>
> On Tue, Jul 2, 2024 at 1:09=E2=80=AFPM Rohini Sangam <rsangam@mvista.com>=
 wrote:
>
>> CVE fixed:
>> -CVE-2024-21094 OpenJDK: C2 compilation fails with "Exceeded _node_regs
>> array" (8317507)
>> Upstream-Status: Backport from
>> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb0=
71301bd3
>>
>> Signed-off-by: Rohini Sangam <rsangam@mvista.com>
>> Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
>> ---
>>  .../openjdk/openjdk-8-release-common.inc      |   1 +
>>  .../patches-openjdk-8/CVE-2024-21094.patch    | 637 ++++++++++++++++++
>>  2 files changed, 638 insertions(+)
>>  create mode 100644
>> recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>>
>> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc
>> b/recipes-core/openjdk/openjdk-8-release-common.inc
>> index ff8d96e..f71eb10 100644
>> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
>> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
>> @@ -21,6 +21,7 @@ PATCHES_URI =3D "\
>>      file://2007-jdk-no-genx11-in-headless.patch \
>>      file://2008-jdk-no-unused-deps.patch \
>>
>>  file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch =
\
>> +    file://CVE-2024-21094.patch \
>>  "
>>  HOTSPOT_UB_PATCH =3D "\
>>      file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch \
>> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>> b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>> new file mode 100644
>> index 0000000..1852bd7
>> --- /dev/null
>> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>> @@ -0,0 +1,637 @@
>> +From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:00:00 2001
>> +From: Martin Balao <mbalao@openjdk.org>
>> +Date: Wed, 27 Mar 2024 03:21:25 +0000
>> +Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fails with
>> "Exceeded _node_regs
>> + array"
>> +
>> +Upstream-Status: Backport from
>> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb0=
71301bd3
>> +CVE: CVE-2024-21094
>> +
>> +Signed-off-by: Rohini Sangam <rsangam@mvista.com>
>> +---
>> + .../hotspot/src/share/vm/adlc/output_c.cpp    |   2 +
>> + .../regalloc/TestNodeRegArrayOverflow.java    | 599 ++++++++++++++++++
>> + 2 files changed, 601 insertions(+)
>> + create mode 100644
>> hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>> +
>> +diff --git a/hotspot/src/share/vm/adlc/output_c.cpp
>> b/hotspot/src/share/vm/adlc/output_c.cpp
>> +index 19916904..b85123b4 100644
>> +--- a/hotspot/src/share/vm/adlc/output_c.cpp
>> ++++ b/hotspot/src/share/vm/adlc/output_c.cpp
>> +@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bool used,
>> FILE *fp_cpp) {
>> +     fprintf(fp_cpp, "    if( i !=3D cisc_operand() ) \n");
>> +     fprintf(fp_cpp, "      to[i] =3D _opnds[i]->clone(C);\n");
>> +     fprintf(fp_cpp, "  }\n");
>> ++    fprintf(fp_cpp, "  // Do not increment node index counter, since
>> node reuses my index\n");
>> ++    fprintf(fp_cpp, "  C->set_unique(C->unique() - 1);\n");
>> +     fprintf(fp_cpp, "}\n");
>> +   }
>> +   fprintf(fp_cpp, "\n");
>> +diff --git
>> a/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>> b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>> +new file mode 100644
>> +index 00000000..281524cc
>> +--- /dev/null
>> ++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>> +@@ -0,0 +1,599 @@
>> ++/*
>> ++ * Copyright (c) 2023, Oracle and/or its affiliates. All rights
>> reserved.
>> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
>> ++ *
>> ++ * This code is free software; you can redistribute it and/or modify i=
t
>> ++ * under the terms of the GNU General Public License version 2 only, a=
s
>> ++ * published by the Free Software Foundation.
>> ++ *
>> ++ * This code is distributed in the hope that it will be useful, but
>> WITHOUT
>> ++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
>> ++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se
>> ++ * version 2 for more details (a copy is included in the LICENSE file
>> that
>> ++ * accompanied this code).
>> ++ *
>> ++ * You should have received a copy of the GNU General Public License
>> version
>> ++ * 2 along with this work; if not, write to the Free Software
>> Foundation,
>> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
>> ++ *
>> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065
>> USA
>> ++ * or visit www.oracle.com if you need additional information or have
>> any
>> ++ * questions.
>> ++ */
>> ++
>> ++package compiler.regalloc;
>> ++
>> ++/**
>> ++ * @test
>> ++ * @bug 8317507
>> ++ * @summary Test that C2's PhaseRegAlloc::_node_regs (a
>> post-register-allocation
>> ++ *          mapping from machine nodes to assigned registers) does not
>> overflow
>> ++ *          in the face of a program with a high-density of CISC
>> spilling
>> ++ *          candidate nodes.
>> ++ * @run main/othervm -Xcomp
>> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithCo=
mpilerUnrolling
>> ++
>>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverf=
low::dontInline
>> ++                     compiler.regalloc.TestNodeRegArrayOverflow compil=
er
>> ++ * @run main/othervm -Xcomp
>> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithMa=
nualUnrolling
>> ++
>>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverf=
low::dontInline
>> ++                     compiler.regalloc.TestNodeRegArrayOverflow manual
>> ++ */
>> ++
>> ++public class TestNodeRegArrayOverflow {
>> ++
>> ++    static int dontInline() {
>> ++        return 0;
>> ++    }
>> ++
>> ++    static float testWithCompilerUnrolling(float inc) {
>> ++        int i =3D 0, j =3D 0;
>> ++        // This non-inlined method call causes 'inc' to be spilled.
>> ++        float f =3D dontInline();
>> ++        // This two-level reduction loop is unrolled 512 times, which =
is
>> ++        // requested by the SLP-specific unrolling analysis, but not
>> vectorized.
>> ++        // Because 'inc' is spilled, each of the unrolled AddF nodes i=
s
>> ++        // CISC-spill converted (PhaseChaitin::fixup_spills()). Before
>> the fix,
>> ++        // this causes the unique node index counter (Compile::_unique=
)
>> to grow
>> ++        // beyond the size of the node register array
>> ++        // (PhaseRegAlloc::_node_regs), and leads to overflow when
>> accessed for
>> ++        // nodes that are created later (e.g. during the peephole
>> phase).
>> ++        while (i++ < 128) {
>> ++            for (j =3D 0; j < 16; j++) {
>> ++                f +=3D inc;
>> ++            }
>> ++        }
>> ++        return f;
>> ++    }
>> ++
>> ++    // This test reproduces the same failure as
>> 'testWithCompilerUnrolling'
>> ++    // without relying on loop transformations.
>> ++    static float testWithManualUnrolling(float inc) {
>> ++        int i =3D 0, j =3D 0;
>> ++        float f =3D dontInline();
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        f +=3D inc;
>> ++        return f;
>> ++    }
>> ++
>> ++    public static void main(String[] args) {
>> ++        switch (args[0]) {
>> ++        case "compiler":
>> ++            testWithCompilerUnrolling(0);
>> ++            break;
>> ++        case "manual":
>> ++            testWithManualUnrolling(0);
>> ++            break;
>> ++        default:
>> ++            throw new IllegalArgumentException("Invalid mode: " +
>> args[0]);
>> ++        }
>> ++    }
>> ++}
>> +--
>> +2.35.7
>> +
>> --
>> 2.34.1
>>
>>

--0000000000006517e6061d69c5e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5HZW50bGUgcmVtaW5kZXIhISE8YnI+PC9kaXY+QW55IHVwZGF0
ZSBvbiB0aGlzID8/PGJyPjxicj48ZGl2PlJlZ2FyZHMsPGJyPjwvZGl2PlJvaGluaSBTYW5nYW08
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUaHUsIEp1bCAxMSwgMjAyNCBhdCAxMjozN+KAr1BNIFJvaGluaSBTYW5n
YW0gJmx0OzxhIGhyZWY9Im1haWx0bzpyc2FuZ2FtQG12aXN0YS5jb20iPnJzYW5nYW1AbXZpc3Rh
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48
ZGl2PjxkaXY+R2VudGxlIHJlbWluZGVyISEhPGJyPjwvZGl2PkFueSB1cGRhdGUgb24gdGhpcyA/
Pzxicj48YnI+PC9kaXY+UmVnYXJkcyw8YnI+PC9kaXY+Um9oaW5pIFNhbmdhbTxicj48L2Rpdj48
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9h
dHRyIj5PbiBUdWUsIEp1bCAyLCAyMDI0IGF0IDE6MDnigK9QTSBSb2hpbmkgU2FuZ2FtICZsdDs8
YSBocmVmPSJtYWlsdG86cnNhbmdhbUBtdmlzdGEuY29tIiB0YXJnZXQ9Il9ibGFuayI+cnNhbmdh
bUBtdmlzdGEuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5DVkUgZml4ZWQ6PGJy
Pg0KLUNWRS0yMDI0LTIxMDk0IE9wZW5KREs6IEMyIGNvbXBpbGF0aW9uIGZhaWxzIHdpdGggJnF1
b3Q7RXhjZWVkZWQgX25vZGVfcmVncyBhcnJheSZxdW90OyAoODMxNzUwNyk8YnI+DQpVcHN0cmVh
bS1TdGF0dXM6IEJhY2twb3J0IGZyb20gPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL29wZW5q
ZGsvamRrOHUvY29tbWl0LzQzY2I4NzU1MDg2NWE5M2M1NTljOWU4ZWFhNTlmY2IwNzEzMDFiZDMi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9vcGVu
amRrL2pkazh1L2NvbW1pdC80M2NiODc1NTA4NjVhOTNjNTU5YzllOGVhYTU5ZmNiMDcxMzAxYmQz
PC9hPjxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IFJvaGluaSBTYW5nYW0gJmx0OzxhIGhyZWY9
Im1haWx0bzpyc2FuZ2FtQG12aXN0YS5jb20iIHRhcmdldD0iX2JsYW5rIj5yc2FuZ2FtQG12aXN0
YS5jb208L2E+Jmd0Ozxicj4NClNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBEb3NoaSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnNkb3NoaUBtdmlzdGEuY29tIiB0YXJnZXQ9Il9ibGFuayI+c2Rvc2hpQG12
aXN0YS5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgLi4uL29wZW5qZGsvb3Blbmpkay04LXJl
bGVhc2UtY29tbW9uLmluY8KgIMKgIMKgIHzCoCDCoDEgKzxicj4NCsKgLi4uL3BhdGNoZXMtb3Bl
bmpkay04L0NWRS0yMDI0LTIxMDk0LnBhdGNowqAgwqAgfCA2MzcgKysrKysrKysrKysrKysrKysr
PGJyPg0KwqAyIGZpbGVzIGNoYW5nZWQsIDYzOCBpbnNlcnRpb25zKCspPGJyPg0KwqBjcmVhdGUg
bW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL29wZW5qZGsvcGF0Y2hlcy1vcGVuamRrLTgvQ1ZFLTIw
MjQtMjEwOTQucGF0Y2g8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL29wZW5q
ZGsvb3Blbmpkay04LXJlbGVhc2UtY29tbW9uLmluYyBiL3JlY2lwZXMtY29yZS9vcGVuamRrL29w
ZW5qZGstOC1yZWxlYXNlLWNvbW1vbi5pbmM8YnI+DQppbmRleCBmZjhkOTZlLi5mNzFlYjEwIDEw
MDY0NDxicj4NCi0tLSBhL3JlY2lwZXMtY29yZS9vcGVuamRrL29wZW5qZGstOC1yZWxlYXNlLWNv
bW1vbi5pbmM8YnI+DQorKysgYi9yZWNpcGVzLWNvcmUvb3Blbmpkay9vcGVuamRrLTgtcmVsZWFz
ZS1jb21tb24uaW5jPGJyPg0KQEAgLTIxLDYgKzIxLDcgQEAgUEFUQ0hFU19VUkkgPSAmcXVvdDtc
PGJyPg0KwqAgwqAgwqBmaWxlOi8vMjAwNy1qZGstbm8tZ2VueDExLWluLWhlYWRsZXNzLnBhdGNo
IFw8YnI+DQrCoCDCoCDCoGZpbGU6Ly8yMDA4LWpkay1uby11bnVzZWQtZGVwcy5wYXRjaCBcPGJy
Pg0KwqAgwqAgwqBmaWxlOi8vMjAwOS1qZGstbWFrZS11c2UtZ2NjLWluc3RlYWQtb2YtbGQtZm9y
LWdlblNvY2tldE9wdGlvblJlLnBhdGNoIFw8YnI+DQorwqAgwqAgZmlsZTovL0NWRS0yMDI0LTIx
MDk0LnBhdGNoIFw8YnI+DQrCoCZxdW90Ozxicj4NCsKgSE9UU1BPVF9VQl9QQVRDSCA9ICZxdW90
O1w8YnI+DQrCoCDCoCDCoGZpbGU6Ly8xMDAxLWhvdHNwb3QtZml4LWNyYXNoLW9uLUpOSV9DcmVh
dGVKYXZhVk0ucGF0Y2ggXDxicj4NCmRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvb3Blbmpkay9w
YXRjaGVzLW9wZW5qZGstOC9DVkUtMjAyNC0yMTA5NC5wYXRjaCBiL3JlY2lwZXMtY29yZS9vcGVu
amRrL3BhdGNoZXMtb3Blbmpkay04L0NWRS0yMDI0LTIxMDk0LnBhdGNoPGJyPg0KbmV3IGZpbGUg
bW9kZSAxMDA2NDQ8YnI+DQppbmRleCAwMDAwMDAwLi4xODUyYmQ3PGJyPg0KLS0tIC9kZXYvbnVs
bDxicj4NCisrKyBiL3JlY2lwZXMtY29yZS9vcGVuamRrL3BhdGNoZXMtb3Blbmpkay04L0NWRS0y
MDI0LTIxMDk0LnBhdGNoPGJyPg0KQEAgLTAsMCArMSw2MzcgQEA8YnI+DQorRnJvbSA0M2NiODc1
NTA4NjVhOTNjNTU5YzllOGVhYTU5ZmNiMDcxMzAxYmQzIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MTxicj4NCitGcm9tOiBNYXJ0aW4gQmFsYW8gJmx0OzxhIGhyZWY9Im1haWx0bzptYmFsYW9Ab3Bl
bmpkay5vcmciIHRhcmdldD0iX2JsYW5rIj5tYmFsYW9Ab3Blbmpkay5vcmc8L2E+Jmd0Ozxicj4N
CitEYXRlOiBXZWQsIDI3IE1hciAyMDI0IDAzOjIxOjI1ICswMDAwPGJyPg0KK1N1YmplY3Q6IFtQ
QVRDSF0gQ1ZFLTIwMjQtMjEwOTQ6IDgzMTc1MDc6IEMyIGNvbXBpbGF0aW9uIGZhaWxzIHdpdGgg
JnF1b3Q7RXhjZWVkZWQgX25vZGVfcmVnczxicj4NCisgYXJyYXkmcXVvdDs8YnI+DQorPGJyPg0K
K1Vwc3RyZWFtLVN0YXR1czogQmFja3BvcnQgZnJvbSA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5j
b20vb3Blbmpkay9qZGs4dS9jb21taXQvNDNjYjg3NTUwODY1YTkzYzU1OWM5ZThlYWE1OWZjYjA3
MTMwMWJkMyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIu
Y29tL29wZW5qZGsvamRrOHUvY29tbWl0LzQzY2I4NzU1MDg2NWE5M2M1NTljOWU4ZWFhNTlmY2Iw
NzEzMDFiZDM8L2E+PGJyPg0KK0NWRTogQ1ZFLTIwMjQtMjEwOTQ8YnI+DQorPGJyPg0KK1NpZ25l
ZC1vZmYtYnk6IFJvaGluaSBTYW5nYW0gJmx0OzxhIGhyZWY9Im1haWx0bzpyc2FuZ2FtQG12aXN0
YS5jb20iIHRhcmdldD0iX2JsYW5rIj5yc2FuZ2FtQG12aXN0YS5jb208L2E+Jmd0Ozxicj4NCist
LS08YnI+DQorIC4uLi9ob3RzcG90L3NyYy9zaGFyZS92bS9hZGxjL291dHB1dF9jLmNwcMKgIMKg
IHzCoCDCoDIgKzxicj4NCisgLi4uL3JlZ2FsbG9jL1Rlc3ROb2RlUmVnQXJyYXlPdmVyZmxvdy5q
YXZhwqAgwqAgfCA1OTkgKysrKysrKysrKysrKysrKysrPGJyPg0KKyAyIGZpbGVzIGNoYW5nZWQs
IDYwMSBpbnNlcnRpb25zKCspPGJyPg0KKyBjcmVhdGUgbW9kZSAxMDA2NDQgaG90c3BvdC90ZXN0
L2NvbXBpbGVyL3JlZ2FsbG9jL1Rlc3ROb2RlUmVnQXJyYXlPdmVyZmxvdy5qYXZhPGJyPg0KKzxi
cj4NCitkaWZmIC0tZ2l0IGEvaG90c3BvdC9zcmMvc2hhcmUvdm0vYWRsYy9vdXRwdXRfYy5jcHAg
Yi9ob3RzcG90L3NyYy9zaGFyZS92bS9hZGxjL291dHB1dF9jLmNwcDxicj4NCitpbmRleCAxOTkx
NjkwNC4uYjg1MTIzYjQgMTAwNjQ0PGJyPg0KKy0tLSBhL2hvdHNwb3Qvc3JjL3NoYXJlL3ZtL2Fk
bGMvb3V0cHV0X2MuY3BwPGJyPg0KKysrKyBiL2hvdHNwb3Qvc3JjL3NoYXJlL3ZtL2FkbGMvb3V0
cHV0X2MuY3BwPGJyPg0KK0BAIC0zMDIzLDYgKzMwMjMsOCBAQCBzdGF0aWMgdm9pZCBkZWZpbmVf
ZmlsbF9uZXdfbWFjaG5vZGUoYm9vbCB1c2VkLCBGSUxFICpmcF9jcHApIHs8YnI+DQorwqAgwqAg
wqBmcHJpbnRmKGZwX2NwcCwgJnF1b3Q7wqAgwqAgaWYoIGkgIT0gY2lzY19vcGVyYW5kKCkgKSBc
biZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgZnByaW50ZihmcF9jcHAsICZxdW90O8KgIMKgIMKgIHRv
W2ldID0gX29wbmRzW2ldLSZndDtjbG9uZShDKTtcbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgZnBy
aW50ZihmcF9jcHAsICZxdW90O8KgIH1cbiZxdW90Oyk7PGJyPg0KKyvCoCDCoCBmcHJpbnRmKGZw
X2NwcCwgJnF1b3Q7wqAgLy8gRG8gbm90IGluY3JlbWVudCBub2RlIGluZGV4IGNvdW50ZXIsIHNp
bmNlIG5vZGUgcmV1c2VzIG15IGluZGV4XG4mcXVvdDspOzxicj4NCisrwqAgwqAgZnByaW50Zihm
cF9jcHAsICZxdW90O8KgIEMtJmd0O3NldF91bmlxdWUoQy0mZ3Q7dW5pcXVlKCkgLSAxKTtcbiZx
dW90Oyk7PGJyPg0KK8KgIMKgIMKgZnByaW50ZihmcF9jcHAsICZxdW90O31cbiZxdW90Oyk7PGJy
Pg0KK8KgIMKgfTxicj4NCivCoCDCoGZwcmludGYoZnBfY3BwLCAmcXVvdDtcbiZxdW90Oyk7PGJy
Pg0KK2RpZmYgLS1naXQgYS9ob3RzcG90L3Rlc3QvY29tcGlsZXIvcmVnYWxsb2MvVGVzdE5vZGVS
ZWdBcnJheU92ZXJmbG93LmphdmEgYi9ob3RzcG90L3Rlc3QvY29tcGlsZXIvcmVnYWxsb2MvVGVz
dE5vZGVSZWdBcnJheU92ZXJmbG93LmphdmE8YnI+DQorbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+
DQoraW5kZXggMDAwMDAwMDAuLjI4MTUyNGNjPGJyPg0KKy0tLSAvZGV2L251bGw8YnI+DQorKysr
IGIvaG90c3BvdC90ZXN0L2NvbXBpbGVyL3JlZ2FsbG9jL1Rlc3ROb2RlUmVnQXJyYXlPdmVyZmxv
dy5qYXZhPGJyPg0KK0BAIC0wLDAgKzEsNTk5IEBAPGJyPg0KKysvKjxicj4NCisrICogQ29weXJp
Z2h0IChjKSAyMDIzLCBPcmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLiBBbGwgcmlnaHRzIHJl
c2VydmVkLjxicj4NCisrICogRE8gTk9UIEFMVEVSIE9SIFJFTU9WRSBDT1BZUklHSFQgTk9USUNF
UyBPUiBUSElTIEZJTEUgSEVBREVSLjxicj4NCisrICo8YnI+DQorKyAqIFRoaXMgY29kZSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0PGJy
Pg0KKysgKiB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMiBvbmx5LCBhczxicj4NCisrICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24uPGJyPg0KKysgKjxicj4NCisrICogVGhpcyBjb2RlIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUPGJyPg0K
KysgKiBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBN
RVJDSEFOVEFCSUxJVFkgb3I8YnI+DQorKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLsKgIFNlZSB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2U8YnI+DQorKyAqIHZlcnNp
b24gMiBmb3IgbW9yZSBkZXRhaWxzIChhIGNvcHkgaXMgaW5jbHVkZWQgaW4gdGhlIExJQ0VOU0Ug
ZmlsZSB0aGF0PGJyPg0KKysgKiBhY2NvbXBhbmllZCB0aGlzIGNvZGUpLjxicj4NCisrICo8YnI+
DQorKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb248YnI+DQorKyAqIDIgYWxvbmcgd2l0aCB0aGlzIHdvcms7
IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiw8YnI+DQorKyAq
IEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAx
IFVTQS48YnI+DQorKyAqPGJyPg0KKysgKiBQbGVhc2UgY29udGFjdCBPcmFjbGUsIDUwMCBPcmFj
bGUgUGFya3dheSwgUmVkd29vZCBTaG9yZXMsIENBIDk0MDY1IFVTQTxicj4NCisrICogb3Igdmlz
aXQgPGEgaHJlZj0iaHR0cDovL3d3dy5vcmFjbGUuY29tIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj53d3cub3JhY2xlLmNvbTwvYT4gaWYgeW91IG5lZWQgYWRkaXRpb25hbCBpbmZv
cm1hdGlvbiBvciBoYXZlIGFueTxicj4NCisrICogcXVlc3Rpb25zLjxicj4NCisrICovPGJyPg0K
Kys8YnI+DQorK3BhY2thZ2UgY29tcGlsZXIucmVnYWxsb2M7PGJyPg0KKys8YnI+DQorKy8qKjxi
cj4NCisrICogQHRlc3Q8YnI+DQorKyAqIEBidWcgODMxNzUwNzxicj4NCisrICogQHN1bW1hcnkg
VGVzdCB0aGF0IEMyJiMzOTtzIFBoYXNlUmVnQWxsb2M6Ol9ub2RlX3JlZ3MgKGEgcG9zdC1yZWdp
c3Rlci1hbGxvY2F0aW9uPGJyPg0KKysgKsKgIMKgIMKgIMKgIMKgIG1hcHBpbmcgZnJvbSBtYWNo
aW5lIG5vZGVzIHRvIGFzc2lnbmVkIHJlZ2lzdGVycykgZG9lcyBub3Qgb3ZlcmZsb3c8YnI+DQor
KyAqwqAgwqAgwqAgwqAgwqAgaW4gdGhlIGZhY2Ugb2YgYSBwcm9ncmFtIHdpdGggYSBoaWdoLWRl
bnNpdHkgb2YgQ0lTQyBzcGlsbGluZzxicj4NCisrICrCoCDCoCDCoCDCoCDCoCBjYW5kaWRhdGUg
bm9kZXMuPGJyPg0KKysgKiBAcnVuIG1haW4vb3RoZXJ2bSAtWGNvbXAgLVhYOkNvbXBpbGVPbmx5
PWNvbXBpbGVyLnJlZ2FsbG9jLlRlc3ROb2RlUmVnQXJyYXlPdmVyZmxvdzo6dGVzdFdpdGhDb21w
aWxlclVucm9sbGluZzxicj4NCisrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtWFg6
Q29tcGlsZUNvbW1hbmQ9ZG9udGlubGluZSxjb21waWxlci5yZWdhbGxvYy5UZXN0Tm9kZVJlZ0Fy
cmF5T3ZlcmZsb3c6OmRvbnRJbmxpbmU8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY29tcGlsZXIucmVnYWxsb2MuVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93IGNvbXBpbGVy
PGJyPg0KKysgKiBAcnVuIG1haW4vb3RoZXJ2bSAtWGNvbXAgLVhYOkNvbXBpbGVPbmx5PWNvbXBp
bGVyLnJlZ2FsbG9jLlRlc3ROb2RlUmVnQXJyYXlPdmVyZmxvdzo6dGVzdFdpdGhNYW51YWxVbnJv
bGxpbmc8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLVhYOkNvbXBpbGVD
b21tYW5kPWRvbnRpbmxpbmUsY29tcGlsZXIucmVnYWxsb2MuVGVzdE5vZGVSZWdBcnJheU92ZXJm
bG93Ojpkb250SW5saW5lPGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNv
bXBpbGVyLnJlZ2FsbG9jLlRlc3ROb2RlUmVnQXJyYXlPdmVyZmxvdyBtYW51YWw8YnI+DQorKyAq
Lzxicj4NCisrPGJyPg0KKytwdWJsaWMgY2xhc3MgVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93IHs8
YnI+DQorKzxicj4NCisrwqAgwqAgc3RhdGljIGludCBkb250SW5saW5lKCkgezxicj4NCisrwqAg
wqAgwqAgwqAgcmV0dXJuIDA7PGJyPg0KKyvCoCDCoCB9PGJyPg0KKys8YnI+DQorK8KgIMKgIHN0
YXRpYyBmbG9hdCB0ZXN0V2l0aENvbXBpbGVyVW5yb2xsaW5nKGZsb2F0IGluYykgezxicj4NCisr
wqAgwqAgwqAgwqAgaW50IGkgPSAwLCBqID0gMDs8YnI+DQorK8KgIMKgIMKgIMKgIC8vIFRoaXMg
bm9uLWlubGluZWQgbWV0aG9kIGNhbGwgY2F1c2VzICYjMzk7aW5jJiMzOTsgdG8gYmUgc3BpbGxl
ZC48YnI+DQorK8KgIMKgIMKgIMKgIGZsb2F0IGYgPSBkb250SW5saW5lKCk7PGJyPg0KKyvCoCDC
oCDCoCDCoCAvLyBUaGlzIHR3by1sZXZlbCByZWR1Y3Rpb24gbG9vcCBpcyB1bnJvbGxlZCA1MTIg
dGltZXMsIHdoaWNoIGlzPGJyPg0KKyvCoCDCoCDCoCDCoCAvLyByZXF1ZXN0ZWQgYnkgdGhlIFNM
UC1zcGVjaWZpYyB1bnJvbGxpbmcgYW5hbHlzaXMsIGJ1dCBub3QgdmVjdG9yaXplZC48YnI+DQor
K8KgIMKgIMKgIMKgIC8vIEJlY2F1c2UgJiMzOTtpbmMmIzM5OyBpcyBzcGlsbGVkLCBlYWNoIG9m
IHRoZSB1bnJvbGxlZCBBZGRGIG5vZGVzIGlzPGJyPg0KKyvCoCDCoCDCoCDCoCAvLyBDSVNDLXNw
aWxsIGNvbnZlcnRlZCAoUGhhc2VDaGFpdGluOjpmaXh1cF9zcGlsbHMoKSkuIEJlZm9yZSB0aGUg
Zml4LDxicj4NCisrwqAgwqAgwqAgwqAgLy8gdGhpcyBjYXVzZXMgdGhlIHVuaXF1ZSBub2RlIGlu
ZGV4IGNvdW50ZXIgKENvbXBpbGU6Ol91bmlxdWUpIHRvIGdyb3c8YnI+DQorK8KgIMKgIMKgIMKg
IC8vIGJleW9uZCB0aGUgc2l6ZSBvZiB0aGUgbm9kZSByZWdpc3RlciBhcnJheTxicj4NCisrwqAg
wqAgwqAgwqAgLy8gKFBoYXNlUmVnQWxsb2M6Ol9ub2RlX3JlZ3MpLCBhbmQgbGVhZHMgdG8gb3Zl
cmZsb3cgd2hlbiBhY2Nlc3NlZCBmb3I8YnI+DQorK8KgIMKgIMKgIMKgIC8vIG5vZGVzIHRoYXQg
YXJlIGNyZWF0ZWQgbGF0ZXIgKGUuZy4gZHVyaW5nIHRoZSBwZWVwaG9sZSBwaGFzZSkuPGJyPg0K
KyvCoCDCoCDCoCDCoCB3aGlsZSAoaSsrICZsdDsgMTI4KSB7PGJyPg0KKyvCoCDCoCDCoCDCoCDC
oCDCoCBmb3IgKGogPSAwOyBqICZsdDsgMTY7IGorKykgezxicj4NCisrwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KKyvCoCDC
oCDCoCDCoCB9PGJyPg0KKyvCoCDCoCDCoCDCoCByZXR1cm4gZjs8YnI+DQorK8KgIMKgIH08YnI+
DQorKzxicj4NCisrwqAgwqAgLy8gVGhpcyB0ZXN0IHJlcHJvZHVjZXMgdGhlIHNhbWUgZmFpbHVy
ZSBhcyAmIzM5O3Rlc3RXaXRoQ29tcGlsZXJVbnJvbGxpbmcmIzM5Ozxicj4NCisrwqAgwqAgLy8g
d2l0aG91dCByZWx5aW5nIG9uIGxvb3AgdHJhbnNmb3JtYXRpb25zLjxicj4NCisrwqAgwqAgc3Rh
dGljIGZsb2F0IHRlc3RXaXRoTWFudWFsVW5yb2xsaW5nKGZsb2F0IGluYykgezxicj4NCisrwqAg
wqAgwqAgwqAgaW50IGkgPSAwLCBqID0gMDs8YnI+DQorK8KgIMKgIMKgIMKgIGZsb2F0IGYgPSBk
b250SW5saW5lKCk7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
wqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8Kg
IMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvC
oCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisr
wqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQor
K8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0K
KyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4N
CisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+
DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxi
cj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8
YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7
PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5j
Ozxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGlu
Yzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBp
bmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0g
aW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9
IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiAr
PSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYg
Kz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBm
ICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAg
ZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKg
IGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDC
oCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAg
wqAgcmV0dXJuIGY7PGJyPg0KKyvCoCDCoCB9PGJyPg0KKys8YnI+DQorK8KgIMKgIHB1YmxpYyBz
dGF0aWMgdm9pZCBtYWluKFN0cmluZ1tdIGFyZ3MpIHs8YnI+DQorK8KgIMKgIMKgIMKgIHN3aXRj
aCAoYXJnc1swXSkgezxicj4NCisrwqAgwqAgwqAgwqAgY2FzZSAmcXVvdDtjb21waWxlciZxdW90
Ozo8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3RXaXRoQ29tcGlsZXJVbnJvbGxpbmcoMCk7
PGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQorK8KgIMKgIMKgIMKgIGNhc2Ug
JnF1b3Q7bWFudWFsJnF1b3Q7Ojxicj4NCisrwqAgwqAgwqAgwqAgwqAgwqAgdGVzdFdpdGhNYW51
YWxVbnJvbGxpbmcoMCk7PGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQorK8Kg
IMKgIMKgIMKgIGRlZmF1bHQ6PGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCB0aHJvdyBuZXcgSWxs
ZWdhbEFyZ3VtZW50RXhjZXB0aW9uKCZxdW90O0ludmFsaWQgbW9kZTogJnF1b3Q7ICsgYXJnc1sw
XSk7PGJyPg0KKyvCoCDCoCDCoCDCoCB9PGJyPg0KKyvCoCDCoCB9PGJyPg0KKyt9PGJyPg0KKy0t
IDxicj4NCisyLjM1Ljc8YnI+DQorPGJyPg0KLS0gPGJyPg0KMi4zNC4xPGJyPg0KPGJyPg0KPC9i
bG9ja3F1b3RlPjwvZGl2Pg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--0000000000006517e6061d69c5e0--

