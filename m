Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B3C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 01:35:37 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web11.5855.1721266530840191177
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jul 2024 18:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KHf3kQFQ;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b417e1511so2396077b3.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721266530; x=1721871330; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IqjhEZ8h9xfkYRbg8uXLZFFsciSlFAFupmegGxjs48=;
        b=KHf3kQFQ3Qd921qdgte9WVLOg0dZ4k6vs1/ih3rsvodsoSAcxwi2dYJk1ttGROE1Ey
         KeKcTL+VjkBlcQXdwgUDCterVxKEj27/52OMNTCrfmx5cj/BXc1vLMuL4EBt3x4dLhGY
         XJLU/VALXDHoZnJ0lNZWjEdE/h55MV2oJo7LqXO1SXGd1ymNB2Ve1DgQAoXs5YV9yZJj
         73F4PQr0xssxI7XZVcf02QqfTyjwedZX2UbmFlZYhW+v8owDdyOwOEpg93P6MUDBGAg3
         +gpnTZjBDXMdmR0ah9oQpAXAFqs/wVkqcXjlKW7beCBR39KmVkx2FX6y1pCAqpVSLkQn
         xQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721266530; x=1721871330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IqjhEZ8h9xfkYRbg8uXLZFFsciSlFAFupmegGxjs48=;
        b=jgQ7fzN1j1TZCuQk5t9ZUJde16qY0MXq47OBcTr4WZnbzJkUBOANUgP4HjqkcxHD07
         VNA0ty1kKwlTP3Z+PNuMcT+vabJ0SSJGKb2QLOD7ndaWvVyAh9iSTPQhp00KNbTZB0Tn
         GQUEbmNCybTzj/q2OIzoPMatIHJ86sKYmCoW/wrXz7fOp8cUoXgwND6CFquWyvAlSxbj
         lAtgYnCeS1JdXAl3ACNDXNAea6qE/2G4X6hJB0sKFVB2eCdvMDAd+URThsn/6BPYNio0
         Xk6XPB2lJOmCaNvSm9dsO4bkfjjOdRfoqFKFgN7ln917PvxXFhX6KitTpAaapqS2jyX9
         Jd9A==
X-Gm-Message-State: AOJu0Yz9u5HsqrrX8inXwXk580EtOcDmMLQMidJznwtoX5wbs+uRTa0P
	emnQyGmsS49DOBTVsy0QluBB2VldXNlhNTMtB2qQHSvoHAEynhackamjeFQSpcuzWBo7yDzX2/1
	koJ9WWQnwDN2kunqecIKivSXiG7QSSg==
X-Google-Smtp-Source: AGHT+IFt70ZtCYsieRfy49dlxS8iWIZmDlp9VMSWcUbgQOWdiFns/HHoaC+jL6e7tDKgZ7ukbTAj4fmTl8g1KTIiIPk=
X-Received: by 2002:a05:690c:9:b0:646:25c7:178e with SMTP id
 00721157ae682-666016fc4c2mr20556467b3.5.1721266529481; Wed, 17 Jul 2024
 18:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240702073934.21734-1-rsangam@mvista.com> <CAL7QmvCeuw71G0Y3AoeRwq8WbNApsMCpVbdMNfh6c8hWc8dGAQ@mail.gmail.com>
 <CAL7QmvC0YoYeYwZgfSvV=RLCmGqNbRE1RgmDKccBvXFQVwDOOw@mail.gmail.com> <CANNYZj-qHcxsxwS5oBnYrT8gkxz2N4d2nG=HsCew_1578UZazg@mail.gmail.com>
In-Reply-To: <CANNYZj-qHcxsxwS5oBnYrT8gkxz2N4d2nG=HsCew_1578UZazg@mail.gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 17 Jul 2024 18:35:18 -0700
Message-ID: <CANx9H-AyfYWPzPwDEhu2y5pRq+fFLqwH2h+_10t-gk5XkDTdmA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java][master][PATCH] openjdk-8: Security
 fix for CVE-2024-21094
To: yocto-patches@lists.yoctoproject.org
Cc: Siddharth Doshi <sdoshi@mvista.com>, Tim Orling <tim.orling@konsulko.com>
Content-Type: multipart/alternative; boundary="0000000000000dbcb1061d7b98b1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jul 2024 01:35:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/441

--0000000000000dbcb1061d7b98b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Most of the metadata is identical on master, scarthgap and kirkstone.
Stable release policy is that we must apply the patches to master and then
back port to stable branches. No CVEs will be fixed in only kirkstone when
they are also applicable to master and scarthgap.

I cannot currently get any supported branch to build on a modern distro,
such as those currently tested on the AutoBuilder. Therefore I cannot merge
any patches. FWIW, my personal systems are Ybuntu 22.94 and Debian 12.

We have zero continuous integration. We have zero ptest packages enabled.

I have spent all the own-time and more on this situation without any real
success or help. I will not devote more time to this situation unless
things change.

I do not use nor rely on meta-java. I do not have any customers paying me
to work on it. The original maintainers all went silent many years ago.

Unless the community steps up to get master branch reliably building in a
way that could be turned into CI, we are at a standstill. We need to see a
branch and configuration that can be reproduced by any one of us.

On Wed, Jul 17, 2024 at 12:19=E2=80=AFAM Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=3Dgmail.com@lists.yoctoproject.org>
wrote:

> I think you should CC Tim. Note that meta-java may not be maintained
> anymore.
>
> Alex
>
> On Wed, 17 Jul 2024 at 06:19, Rohini Sangam via lists.yoctoproject.org
> <rsangam=3Dmvista.com@lists.yoctoproject.org> wrote:
> >
> > Gentle reminder!!!
> > Any update on this ??
> >
> > Regards,
> > Rohini Sangam
> >
> > On Thu, Jul 11, 2024 at 12:37=E2=80=AFPM Rohini Sangam <rsangam@mvista.=
com>
> wrote:
> >>
> >> Gentle reminder!!!
> >> Any update on this ??
> >>
> >> Regards,
> >> Rohini Sangam
> >>
> >> On Tue, Jul 2, 2024 at 1:09=E2=80=AFPM Rohini Sangam <rsangam@mvista.c=
om>
> wrote:
> >>>
> >>> CVE fixed:
> >>> -CVE-2024-21094 OpenJDK: C2 compilation fails with "Exceeded
> _node_regs array" (8317507)
> >>> Upstream-Status: Backport from
> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb07=
1301bd3
> >>>
> >>> Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> >>> Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> >>> ---
> >>>  .../openjdk/openjdk-8-release-common.inc      |   1 +
> >>>  .../patches-openjdk-8/CVE-2024-21094.patch    | 637 ++++++++++++++++=
++
> >>>  2 files changed, 638 insertions(+)
> >>>  create mode 100644
> recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> >>>
> >>> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc
> b/recipes-core/openjdk/openjdk-8-release-common.inc
> >>> index ff8d96e..f71eb10 100644
> >>> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
> >>> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
> >>> @@ -21,6 +21,7 @@ PATCHES_URI =3D "\
> >>>      file://2007-jdk-no-genx11-in-headless.patch \
> >>>      file://2008-jdk-no-unused-deps.patch \
> >>>
> file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch \
> >>> +    file://CVE-2024-21094.patch \
> >>>  "
> >>>  HOTSPOT_UB_PATCH =3D "\
> >>>      file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch \
> >>> diff --git
> a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> >>> new file mode 100644
> >>> index 0000000..1852bd7
> >>> --- /dev/null
> >>> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> >>> @@ -0,0 +1,637 @@
> >>> +From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:00:00 20=
01
> >>> +From: Martin Balao <mbalao@openjdk.org>
> >>> +Date: Wed, 27 Mar 2024 03:21:25 +0000
> >>> +Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fails with
> "Exceeded _node_regs
> >>> + array"
> >>> +
> >>> +Upstream-Status: Backport from
> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb07=
1301bd3
> >>> +CVE: CVE-2024-21094
> >>> +
> >>> +Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> >>> +---
> >>> + .../hotspot/src/share/vm/adlc/output_c.cpp    |   2 +
> >>> + .../regalloc/TestNodeRegArrayOverflow.java    | 599
> ++++++++++++++++++
> >>> + 2 files changed, 601 insertions(+)
> >>> + create mode 100644
> hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> >>> +
> >>> +diff --git a/hotspot/src/share/vm/adlc/output_c.cpp
> b/hotspot/src/share/vm/adlc/output_c.cpp
> >>> +index 19916904..b85123b4 100644
> >>> +--- a/hotspot/src/share/vm/adlc/output_c.cpp
> >>> ++++ b/hotspot/src/share/vm/adlc/output_c.cpp
> >>> +@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bool used=
,
> FILE *fp_cpp) {
> >>> +     fprintf(fp_cpp, "    if( i !=3D cisc_operand() ) \n");
> >>> +     fprintf(fp_cpp, "      to[i] =3D _opnds[i]->clone(C);\n");
> >>> +     fprintf(fp_cpp, "  }\n");
> >>> ++    fprintf(fp_cpp, "  // Do not increment node index counter, sinc=
e
> node reuses my index\n");
> >>> ++    fprintf(fp_cpp, "  C->set_unique(C->unique() - 1);\n");
> >>> +     fprintf(fp_cpp, "}\n");
> >>> +   }
> >>> +   fprintf(fp_cpp, "\n");
> >>> +diff --git
> a/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> >>> +new file mode 100644
> >>> +index 00000000..281524cc
> >>> +--- /dev/null
> >>> ++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> >>> +@@ -0,0 +1,599 @@
> >>> ++/*
> >>> ++ * Copyright (c) 2023, Oracle and/or its affiliates. All rights
> reserved.
> >>> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> >>> ++ *
> >>> ++ * This code is free software; you can redistribute it and/or modif=
y
> it
> >>> ++ * under the terms of the GNU General Public License version 2 only=
,
> as
> >>> ++ * published by the Free Software Foundation.
> >>> ++ *
> >>> ++ * This code is distributed in the hope that it will be useful, but
> WITHOUT
> >>> ++ * ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or
> >>> ++ * FITNESS FOR A PARTIC
> <https://www.google.com/maps/search/S+FOR+A+PARTIC?entry=3Dgmail&source=
=3Dg>ULAR
> PURPOSE.  See the GNU General Public License
> >>> ++ * version 2 for more details (a copy is included in the LICENSE fi=
l
> <https://www.google.com/maps/search/e+details+(a+copy+is+included+in+the+=
LICENSE+fil?entry=3Dgmail&source=3Dg>e
> that
> >>> ++ * accompanied this code).
> >>> ++ *
> >>> ++ * You should have received a copy of the GNU General Public Licens=
e
> version
> >>> ++ * 2 along with this work; if not, write to the Free Software
> Foundation,
> >>> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> >>> ++ *
> >>> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA
> 94065 USA
> >>> ++ * or visit www.oracle.com if you need additional information or
> have any
> >>> ++ * questions.
> >>> ++ */
> >>> ++
> >>> ++package compiler.regalloc;
> >>> ++
> >>> ++/**
> >>> ++ * @test
> >>> ++ * @bug 8317507
> >>> ++ * @summary Test that C2's PhaseRegAlloc::_node_regs (a
> post-register-allocation
> >>> ++ *          mapping from machine nodes to assigned registers) does
> not overflow
> >>> ++ *          in the face of a program with a high-density of CISC
> spilling
> >>> ++ *          candidate nodes.
> >>> ++ * @run main/othervm -Xcomp
> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithCom=
pilerUnrolling
> >>> ++
>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverfl=
ow::dontInline
> >>> ++                     compiler.regalloc.TestNodeRegArrayOverflow
> compiler
> >>> ++ * @run main/othervm -Xcomp
> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithMan=
ualUnrolling
> >>> ++
>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverfl=
ow::dontInline
> >>> ++                     compiler.regalloc.TestNodeRegArrayOverflow
> manual
> >>> ++ */
> >>> ++
> >>> ++public class TestNodeRegArrayOverflow {
> >>> ++
> >>> ++    static int dontInline() {
> >>> ++        return 0;
> >>> ++    }
> >>> ++
> >>> ++    static float testWithCompilerUnrolling(float inc) {
> >>> ++        int i =3D 0, j =3D 0;
> >>> ++        // This non-inlined method call causes 'inc' to be spilled.
> >>> ++        float f =3D dontInline();
> >>> ++        // This two-level reduction loop is unrolled 512 times,
> which is
> >>> ++        // requested by the SLP-specific unrolling analysis, but no=
t
> vectorized.
> >>> ++        // Because 'inc' is spilled, each of the unrolled AddF node=
s
> is
> >>> ++        // CISC-spill converted (PhaseChaitin::fixup_spills()).
> Before the fix,
> >>> ++        // this causes the unique node index counter
> (Compile::_unique) to grow
> >>> ++        // beyond the size of the node register array
> >>> ++        // (PhaseRegAlloc::_node_regs), and leads to overflow when
> accessed for
> >>> ++        // nodes that are created later (e.g. during the peephole
> phase).
> >>> ++        while (i++ < 128) {
> >>> ++            for (j =3D 0; j < 16; j++) {
> >>> ++                f +=3D inc;
> >>> ++            }
> >>> ++        }
> >>> ++        return f;
> >>> ++    }
> >>> ++
> >>> ++    // This test reproduces the same failure as
> 'testWithCompilerUnrolling'
> >>> ++    // without relying on loop transformations.
> >>> ++    static float testWithManualUnrolling(float inc) {
> >>> ++        int i =3D 0, j =3D 0;
> >>> ++        float f =3D dontInline();
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        f +=3D inc;
> >>> ++        return f;
> >>> ++    }
> >>> ++
> >>> ++    public static void main(String[] args) {
> >>> ++        switch (args[0]) {
> >>> ++        case "compiler":
> >>> ++            testWithCompilerUnrolling(0);
> >>> ++            break;
> >>> ++        case "manual":
> >>> ++            testWithManualUnrolling(0);
> >>> ++            break;
> >>> ++        default:
> >>> ++            throw new IllegalArgumentException("Invalid mode: " +
> args[0]);
> >>> ++        }
> >>> ++    }
> >>> ++}
> >>> +--
> >>> +2.35.7
> >>> +
> >>> --
> >>> 2.34.1
> >>>
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#436):
> https://lists.yoctoproject.org/g/yocto-patches/message/436
> Mute This Topic: https://lists.yoctoproject.org/mt/106996115/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000000dbcb1061d7b98b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Most of the metadata is identical on master, scarthgap an=
d kirkstone. Stable release policy is that we must apply the patches to mas=
ter and then back port to stable branches. No CVEs will be fixed in only ki=
rkstone when they are also applicable to master and scarthgap.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">I cannot currently get any supported=
 branch to build on a modern distro, such as those currently tested on the =
AutoBuilder. Therefore I cannot merge any patches. FWIW, my personal system=
s are Ybuntu 22.94 and Debian 12.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">We have zero continuous integration. We have zero ptest packages =
enabled.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I have spent al=
l the own-time and more on this situation without any real success or help.=
 I will not devote more time to this situation unless things change.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">I do not use nor rely on meta-=
java. I do not have any customers paying me to work on it. The original mai=
ntainers all went silent many years ago.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Unless the community steps up to get master branch reliabl=
y building in a way that could be turned into CI, we are at a standstill. W=
e need to see a branch and configuration that can be reproduced by any one =
of us.</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Jul 17, 2024 at 12:19=E2=80=AFAM Alexander Kanavin via <=
a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;ale=
x.kanavin=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@l=
ists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">I think you =
should CC Tim. Note that meta-java may not be maintained anymore.<br>
<br>
Alex<br>
<br>
On Wed, 17 Jul 2024 at 06:19, Rohini Sangam via <a href=3D"http://lists.yoc=
toproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org<=
/a><br>
&lt;rsangam=3D<a href=3D"mailto:mvista.com@lists.yoctoproject.org" target=
=3D"_blank">mvista.com@lists.yoctoproject.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Gentle reminder!!!<br>
&gt; Any update on this ??<br>
&gt;<br>
&gt; Regards,<br>
&gt; Rohini Sangam<br>
&gt;<br>
&gt; On Thu, Jul 11, 2024 at 12:37=E2=80=AFPM Rohini Sangam &lt;<a href=3D"=
mailto:rsangam@mvista.com" target=3D"_blank">rsangam@mvista.com</a>&gt; wro=
te:<br>
&gt;&gt;<br>
&gt;&gt; Gentle reminder!!!<br>
&gt;&gt; Any update on this ??<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Rohini Sangam<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Jul 2, 2024 at 1:09=E2=80=AFPM Rohini Sangam &lt;<a href=
=3D"mailto:rsangam@mvista.com" target=3D"_blank">rsangam@mvista.com</a>&gt;=
 wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; CVE fixed:<br>
&gt;&gt;&gt; -CVE-2024-21094 OpenJDK: C2 compilation fails with &quot;Excee=
ded _node_regs array&quot; (8317507)<br>
&gt;&gt;&gt; Upstream-Status: Backport from <a href=3D"https://github.com/o=
penjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb071301bd3" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/openjdk/jdk8u/commit/43cb8755086=
5a93c559c9e8eaa59fcb071301bd3</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Rohini Sangam &lt;<a href=3D"mailto:rsangam@mvi=
sta.com" target=3D"_blank">rsangam@mvista.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Siddharth Doshi &lt;<a href=3D"mailto:sdoshi@mv=
ista.com" target=3D"_blank">sdoshi@mvista.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 .../openjdk/openjdk-8-release-common.inc=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;&gt;=C2=A0 .../patches-openjdk-8/CVE-2024-21094.patch=C2=A0 =C2=A0 =
| 637 ++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 2 files changed, 638 insertions(+)<br>
&gt;&gt;&gt;=C2=A0 create mode 100644 recipes-core/openjdk/patches-openjdk-=
8/CVE-2024-21094.patch<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc=
 b/recipes-core/openjdk/openjdk-8-release-common.inc<br>
&gt;&gt;&gt; index ff8d96e..f71eb10 100644<br>
&gt;&gt;&gt; --- a/recipes-core/openjdk/openjdk-8-release-common.inc<br>
&gt;&gt;&gt; +++ b/recipes-core/openjdk/openjdk-8-release-common.inc<br>
&gt;&gt;&gt; @@ -21,6 +21,7 @@ PATCHES_URI =3D &quot;\<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 file://2007-jdk-no-genx11-in-headless.patc=
h \<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 file://2008-jdk-no-unused-deps.patch \<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 file://2009-jdk-make-use-gcc-instead-of-ld=
-for-genSocketOptionRe.patch \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 file://CVE-2024-21094.patch \<br>
&gt;&gt;&gt;=C2=A0 &quot;<br>
&gt;&gt;&gt;=C2=A0 HOTSPOT_UB_PATCH =3D &quot;\<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 file://1001-hotspot-fix-crash-on-JNI_Creat=
eJavaVM.patch \<br>
&gt;&gt;&gt; diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-2=
1094.patch b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch<br=
>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000..1852bd7<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.pa=
tch<br>
&gt;&gt;&gt; @@ -0,0 +1,637 @@<br>
&gt;&gt;&gt; +From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:0=
0:00 2001<br>
&gt;&gt;&gt; +From: Martin Balao &lt;<a href=3D"mailto:mbalao@openjdk.org" =
target=3D"_blank">mbalao@openjdk.org</a>&gt;<br>
&gt;&gt;&gt; +Date: Wed, 27 Mar 2024 03:21:25 +0000<br>
&gt;&gt;&gt; +Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fail=
s with &quot;Exceeded _node_regs<br>
&gt;&gt;&gt; + array&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +Upstream-Status: Backport from <a href=3D"https://github.com/=
openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb071301bd3" rel=3D"noref=
errer" target=3D"_blank">https://github.com/openjdk/jdk8u/commit/43cb875508=
65a93c559c9e8eaa59fcb071301bd3</a><br>
&gt;&gt;&gt; +CVE: CVE-2024-21094<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +Signed-off-by: Rohini Sangam &lt;<a href=3D"mailto:rsangam@mv=
ista.com" target=3D"_blank">rsangam@mvista.com</a>&gt;<br>
&gt;&gt;&gt; +---<br>
&gt;&gt;&gt; + .../hotspot/src/share/vm/adlc/output_c.cpp=C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +<br>
&gt;&gt;&gt; + .../regalloc/TestNodeRegArrayOverflow.java=C2=A0 =C2=A0 | 59=
9 ++++++++++++++++++<br>
&gt;&gt;&gt; + 2 files changed, 601 insertions(+)<br>
&gt;&gt;&gt; + create mode 100644 hotspot/test/compiler/regalloc/TestNodeRe=
gArrayOverflow.java<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +diff --git a/hotspot/src/share/vm/adlc/output_c.cpp b/hotspot=
/src/share/vm/adlc/output_c.cpp<br>
&gt;&gt;&gt; +index 19916904..b85123b4 100644<br>
&gt;&gt;&gt; +--- a/hotspot/src/share/vm/adlc/output_c.cpp<br>
&gt;&gt;&gt; ++++ b/hotspot/src/share/vm/adlc/output_c.cpp<br>
&gt;&gt;&gt; +@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bo=
ol used, FILE *fp_cpp) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0fprintf(fp_cpp, &quot;=C2=A0 =C2=A0 if( i=
 !=3D cisc_operand() ) \n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0fprintf(fp_cpp, &quot;=C2=A0 =C2=A0 =C2=
=A0 to[i] =3D _opnds[i]-&gt;clone(C);\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0fprintf(fp_cpp, &quot;=C2=A0 }\n&quot;);<=
br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 fprintf(fp_cpp, &quot;=C2=A0 // Do not increme=
nt node index counter, since node reuses my index\n&quot;);<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 fprintf(fp_cpp, &quot;=C2=A0 C-&gt;set_unique(=
C-&gt;unique() - 1);\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0fprintf(fp_cpp, &quot;}\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0fprintf(fp_cpp, &quot;\n&quot;);<br>
&gt;&gt;&gt; +diff --git a/hotspot/test/compiler/regalloc/TestNodeRegArrayO=
verflow.java b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java=
<br>
&gt;&gt;&gt; +new file mode 100644<br>
&gt;&gt;&gt; +index 00000000..281524cc<br>
&gt;&gt;&gt; +--- /dev/null<br>
&gt;&gt;&gt; ++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow=
.java<br>
&gt;&gt;&gt; +@@ -0,0 +1,599 @@<br>
&gt;&gt;&gt; ++/*<br>
&gt;&gt;&gt; ++ * Copyright (c) 2023, Oracle and/or its affiliates. All rig=
hts reserved.<br>
&gt;&gt;&gt; ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEA=
DER.<br>
&gt;&gt;&gt; ++ *<br>
&gt;&gt;&gt; ++ * This code is free software; you can redistribute it and/o=
r modify it<br>
&gt;&gt;&gt; ++ * under the terms of the GNU General Public License version=
 2 only, as<br>
&gt;&gt;&gt; ++ * published by the Free Software Foundation.<br>
&gt;&gt;&gt; ++ *<br>
&gt;&gt;&gt; ++ * This code is distributed in the hope that it will be usef=
ul, but WITHOUT<br>
&gt;&gt;&gt; ++ * ANY WARRANTY; without even the implied warranty of MERCHA=
NTABILITY or<br>
&gt;&gt;&gt; ++ * FITNES<a href=3D"https://www.google.com/maps/search/S+FOR=
+A+PARTIC?entry=3Dgmail&amp;source=3Dg">S FOR A PARTIC</a>ULAR PURPOSE.=C2=
=A0 See the GNU General Public License<br>
&gt;&gt;&gt; ++ * version 2 for mor<a href=3D"https://www.google.com/maps/s=
earch/e+details+(a+copy+is+included+in+the+LICENSE+fil?entry=3Dgmail&amp;so=
urce=3Dg">e details (a copy is included in the LICENSE fil</a>e that<br>
&gt;&gt;&gt; ++ * accompanied this code).<br>
&gt;&gt;&gt; ++ *<br>
&gt;&gt;&gt; ++ * You should have received a copy of the GNU General Public=
 License version<br>
&gt;&gt;&gt; ++ * 2 along with this work; if not, write to the Free Softwar=
e Foundation,<br>
&gt;&gt;&gt; ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 =
USA.<br>
&gt;&gt;&gt; ++ *<br>
&gt;&gt;&gt; ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores=
, CA 94065 USA<br>
&gt;&gt;&gt; ++ * or visit <a href=3D"http://www.oracle.com" rel=3D"norefer=
rer" target=3D"_blank">www.oracle.com</a> if you need additional informatio=
n or have any<br>
&gt;&gt;&gt; ++ * questions.<br>
&gt;&gt;&gt; ++ */<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++package compiler.regalloc;<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++/**<br>
&gt;&gt;&gt; ++ * @test<br>
&gt;&gt;&gt; ++ * @bug 8317507<br>
&gt;&gt;&gt; ++ * @summary Test that C2&#39;s PhaseRegAlloc::_node_regs (a =
post-register-allocation<br>
&gt;&gt;&gt; ++ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mapping from machine no=
des to assigned registers) does not overflow<br>
&gt;&gt;&gt; ++ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in the face of a progra=
m with a high-density of CISC spilling<br>
&gt;&gt;&gt; ++ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 candidate nodes.<br>
&gt;&gt;&gt; ++ * @run main/othervm -Xcomp -XX:CompileOnly=3Dcompiler.regal=
loc.TestNodeRegArrayOverflow::testWithCompilerUnrolling<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNode=
RegArrayOverflow::dontInline<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0compiler.regalloc.TestNodeRegArrayOverflow compiler<br>
&gt;&gt;&gt; ++ * @run main/othervm -Xcomp -XX:CompileOnly=3Dcompiler.regal=
loc.TestNodeRegArrayOverflow::testWithManualUnrolling<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNode=
RegArrayOverflow::dontInline<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0compiler.regalloc.TestNodeRegArrayOverflow manual<br>
&gt;&gt;&gt; ++ */<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++public class TestNodeRegArrayOverflow {<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 static int dontInline() {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 static float testWithCompilerUnrolling(float i=
nc) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i =3D 0, j =3D 0;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // This non-inlined method call =
causes &#39;inc&#39; to be spilled.<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 float f =3D dontInline();<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // This two-level reduction loop=
 is unrolled 512 times, which is<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // requested by the SLP-specific=
 unrolling analysis, but not vectorized.<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Because &#39;inc&#39; is spil=
led, each of the unrolled AddF nodes is<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // CISC-spill converted (PhaseCh=
aitin::fixup_spills()). Before the fix,<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // this causes the unique node i=
ndex counter (Compile::_unique) to grow<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // beyond the size of the node r=
egister array<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // (PhaseRegAlloc::_node_regs), =
and leads to overflow when accessed for<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 // nodes that are created later =
(e.g. during the peephole phase).<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (i++ &lt; 128) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &l=
t; 16; j++) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=
=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 // This test reproduces the same failure as &#=
39;testWithCompilerUnrolling&#39;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 // without relying on loop transformations.<br=
>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 static float testWithManualUnrolling(float inc=
) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i =3D 0, j =3D 0;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 float f =3D dontInline();<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 f +=3D inc;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 public static void main(String[] args) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (args[0]) {<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &quot;compiler&quot;:<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testWithCompilerUn=
rolling(0);<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &quot;manual&quot;:<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testWithManualUnro=
lling(0);<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throw new IllegalA=
rgumentException(&quot;Invalid mode: &quot; + args[0]);<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; ++}<br>
&gt;&gt;&gt; +--<br>
&gt;&gt;&gt; +2.35.7<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.34.1<br>
&gt;&gt;&gt;<br>
&gt; <br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#436): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/436" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/436</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/106996115/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/106996115/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--0000000000000dbcb1061d7b98b1--

