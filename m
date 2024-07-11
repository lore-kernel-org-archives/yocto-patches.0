Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5E0C3DA41
	for <webhook@archiver.kernel.org>; Thu, 11 Jul 2024 07:07:59 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.6262.1720681675234872002
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jul 2024 00:07:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=D9oX2GzR;
 spf=pass (domain: mvista.com, ip: 209.85.218.49, mailfrom: rsangam@mvista.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77baa87743so59612366b.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jul 2024 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1720681673; x=1721286473; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5S4FQJ+jbHFW6CayDUpMX8Bf4XFkg7BoYoB6RDtuAQ=;
        b=D9oX2GzRZRqm9yuWbXPrc8Jpke+CEY9MWyA+m3G41uBP7eeCWy1EQmEYXMY48UT5Tm
         KpyoRvvFWL7PrAMXLFvNSPNE7j6vlplLepSl+twoUpVI3ZnuyzAWG5SOpX06D66uI7WZ
         wkMUYLGyE2/3OkPKZAyGGsMN6w2n+vKpGTCZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681673; x=1721286473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5S4FQJ+jbHFW6CayDUpMX8Bf4XFkg7BoYoB6RDtuAQ=;
        b=Su+Esb/mw38D15ChRgiJXdzxWwAXvmH9YXppbUTTODrOMhMxsO1el8A0d81ruCegLd
         /rXuBqj0FBBHhXQp/kSs05wsvin1OoRKizAqSdsm9+KfaWFsn7dkkIJtY7CINWWwZO+U
         HaiGqNFKx99H/o6b0JS4ddd4myQ484X9+CeZQqoHE/LKPn0w/PN/FMFzZ/+QFw6CQHgl
         c1KppzLaBIhuRNkakE4fnw58yeIX86RX8OIbbfFk0NMzGOc/2LV7shzT8sudzSic2Q0t
         50Kfv6kycaXzE8zMRW0cGxeTB0aGrTW6IgN1R9d8D8mAabHScbu5o8PuToJybjgAo6qd
         BZnQ==
X-Gm-Message-State: AOJu0YzogpjUGN5wQtSYWq9uw1G9wQ85Z+ZIlnc1MPbes+NysdqJ7BXD
	1iiX2xQ+cJxv2TWV518bIH7eE8vFVQcOD8ARK7lTZewQL+qUoqwOTyit0g3/83f1p4EnEr0rF8d
	QUY+9DEG8cwBNSOhpEcOIdAm4qjHNVFDVd6paW2anXYjwb+bY
X-Google-Smtp-Source: AGHT+IHKkzEbNg0hiwSRUR4zl37rYhbGuCNMbuPVbcY8IFY8MKI4zciZPOeeXOE1Q8qz6cOzhRlQLdqLzAqZ4vdy1So=
X-Received: by 2002:a17:906:4118:b0:a77:e58d:d8db with SMTP id
 a640c23a62f3a-a780b6b35b9mr595201566b.32.1720681673204; Thu, 11 Jul 2024
 00:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240702073934.21734-1-rsangam@mvista.com>
In-Reply-To: <20240702073934.21734-1-rsangam@mvista.com>
From: Rohini Sangam <rsangam@mvista.com>
Date: Thu, 11 Jul 2024 12:37:40 +0530
Message-ID: <CAL7QmvCeuw71G0Y3AoeRwq8WbNApsMCpVbdMNfh6c8hWc8dGAQ@mail.gmail.com>
Subject: Re: [meta-java][master][PATCH] openjdk-8: Security fix for CVE-2024-21094
To: yocto-patches@lists.yoctoproject.org
Cc: Siddharth Doshi <sdoshi@mvista.com>
Content-Type: multipart/alternative; boundary="000000000000e73cce061cf36b83"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jul 2024 07:07:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/424

--000000000000e73cce061cf36b83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle reminder!!!
Any update on this ??

Regards,
Rohini Sangam

On Tue, Jul 2, 2024 at 1:09=E2=80=AFPM Rohini Sangam <rsangam@mvista.com> w=
rote:

> CVE fixed:
> -CVE-2024-21094 OpenJDK: C2 compilation fails with "Exceeded _node_regs
> array" (8317507)
> Upstream-Status: Backport from
> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb07=
1301bd3
>
> Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
> ---
>  .../openjdk/openjdk-8-release-common.inc      |   1 +
>  .../patches-openjdk-8/CVE-2024-21094.patch    | 637 ++++++++++++++++++
>  2 files changed, 638 insertions(+)
>  create mode 100644
> recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>
> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc
> b/recipes-core/openjdk/openjdk-8-release-common.inc
> index ff8d96e..f71eb10 100644
> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
> @@ -21,6 +21,7 @@ PATCHES_URI =3D "\
>      file://2007-jdk-no-genx11-in-headless.patch \
>      file://2008-jdk-no-unused-deps.patch \
>
>  file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.patch \
> +    file://CVE-2024-21094.patch \
>  "
>  HOTSPOT_UB_PATCH =3D "\
>      file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch \
> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> new file mode 100644
> index 0000000..1852bd7
> --- /dev/null
> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
> @@ -0,0 +1,637 @@
> +From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:00:00 2001
> +From: Martin Balao <mbalao@openjdk.org>
> +Date: Wed, 27 Mar 2024 03:21:25 +0000
> +Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fails with
> "Exceeded _node_regs
> + array"
> +
> +Upstream-Status: Backport from
> https://github.com/openjdk/jdk8u/commit/43cb87550865a93c559c9e8eaa59fcb07=
1301bd3
> +CVE: CVE-2024-21094
> +
> +Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> +---
> + .../hotspot/src/share/vm/adlc/output_c.cpp    |   2 +
> + .../regalloc/TestNodeRegArrayOverflow.java    | 599 ++++++++++++++++++
> + 2 files changed, 601 insertions(+)
> + create mode 100644
> hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> +
> +diff --git a/hotspot/src/share/vm/adlc/output_c.cpp
> b/hotspot/src/share/vm/adlc/output_c.cpp
> +index 19916904..b85123b4 100644
> +--- a/hotspot/src/share/vm/adlc/output_c.cpp
> ++++ b/hotspot/src/share/vm/adlc/output_c.cpp
> +@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bool used,
> FILE *fp_cpp) {
> +     fprintf(fp_cpp, "    if( i !=3D cisc_operand() ) \n");
> +     fprintf(fp_cpp, "      to[i] =3D _opnds[i]->clone(C);\n");
> +     fprintf(fp_cpp, "  }\n");
> ++    fprintf(fp_cpp, "  // Do not increment node index counter, since
> node reuses my index\n");
> ++    fprintf(fp_cpp, "  C->set_unique(C->unique() - 1);\n");
> +     fprintf(fp_cpp, "}\n");
> +   }
> +   fprintf(fp_cpp, "\n");
> +diff --git a/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.jav=
a
> b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> +new file mode 100644
> +index 00000000..281524cc
> +--- /dev/null
> ++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
> +@@ -0,0 +1,599 @@
> ++/*
> ++ * Copyright (c) 2023, Oracle and/or its affiliates. All rights reserve=
d.
> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> ++ *
> ++ * This code is free software; you can redistribute it and/or modify it
> ++ * under the terms of the GNU General Public License version 2 only, as
> ++ * published by the Free Software Foundation.
> ++ *
> ++ * This code is distributed in the hope that it will be useful, but
> WITHOUT
> ++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY o=
r
> ++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licens=
e
> ++ * version 2 for more details (a copy is included in the LICENSE file
> that
> ++ * accompanied this code).
> ++ *
> ++ * You should have received a copy of the GNU General Public License
> version
> ++ * 2 along with this work; if not, write to the Free Software Foundatio=
n,
> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> ++ *
> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065
> USA
> ++ * or visit www.oracle.com if you need additional information or have
> any
> ++ * questions.
> ++ */
> ++
> ++package compiler.regalloc;
> ++
> ++/**
> ++ * @test
> ++ * @bug 8317507
> ++ * @summary Test that C2's PhaseRegAlloc::_node_regs (a
> post-register-allocation
> ++ *          mapping from machine nodes to assigned registers) does not
> overflow
> ++ *          in the face of a program with a high-density of CISC spilli=
ng
> ++ *          candidate nodes.
> ++ * @run main/othervm -Xcomp
> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithCom=
pilerUnrolling
> ++
>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverfl=
ow::dontInline
> ++                     compiler.regalloc.TestNodeRegArrayOverflow compile=
r
> ++ * @run main/othervm -Xcomp
> -XX:CompileOnly=3Dcompiler.regalloc.TestNodeRegArrayOverflow::testWithMan=
ualUnrolling
> ++
>  -XX:CompileCommand=3Ddontinline,compiler.regalloc.TestNodeRegArrayOverfl=
ow::dontInline
> ++                     compiler.regalloc.TestNodeRegArrayOverflow manual
> ++ */
> ++
> ++public class TestNodeRegArrayOverflow {
> ++
> ++    static int dontInline() {
> ++        return 0;
> ++    }
> ++
> ++    static float testWithCompilerUnrolling(float inc) {
> ++        int i =3D 0, j =3D 0;
> ++        // This non-inlined method call causes 'inc' to be spilled.
> ++        float f =3D dontInline();
> ++        // This two-level reduction loop is unrolled 512 times, which i=
s
> ++        // requested by the SLP-specific unrolling analysis, but not
> vectorized.
> ++        // Because 'inc' is spilled, each of the unrolled AddF nodes is
> ++        // CISC-spill converted (PhaseChaitin::fixup_spills()). Before
> the fix,
> ++        // this causes the unique node index counter (Compile::_unique)
> to grow
> ++        // beyond the size of the node register array
> ++        // (PhaseRegAlloc::_node_regs), and leads to overflow when
> accessed for
> ++        // nodes that are created later (e.g. during the peephole phase=
).
> ++        while (i++ < 128) {
> ++            for (j =3D 0; j < 16; j++) {
> ++                f +=3D inc;
> ++            }
> ++        }
> ++        return f;
> ++    }
> ++
> ++    // This test reproduces the same failure as
> 'testWithCompilerUnrolling'
> ++    // without relying on loop transformations.
> ++    static float testWithManualUnrolling(float inc) {
> ++        int i =3D 0, j =3D 0;
> ++        float f =3D dontInline();
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        f +=3D inc;
> ++        return f;
> ++    }
> ++
> ++    public static void main(String[] args) {
> ++        switch (args[0]) {
> ++        case "compiler":
> ++            testWithCompilerUnrolling(0);
> ++            break;
> ++        case "manual":
> ++            testWithManualUnrolling(0);
> ++            break;
> ++        default:
> ++            throw new IllegalArgumentException("Invalid mode: " +
> args[0]);
> ++        }
> ++    }
> ++}
> +--
> +2.35.7
> +
> --
> 2.34.1
>
>

--000000000000e73cce061cf36b83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+R2VudGxlIHJlbWluZGVyISEhPGJyPjwvZGl2
PkFueSB1cGRhdGUgb24gdGhpcyA/Pzxicj48YnI+PC9kaXY+UmVnYXJkcyw8YnI+PC9kaXY+Um9o
aW5pIFNhbmdhbTxicj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGly
PSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIEp1bCAyLCAyMDI0IGF0IDE6MDnigK9Q
TSBSb2hpbmkgU2FuZ2FtICZsdDs8YSBocmVmPSJtYWlsdG86cnNhbmdhbUBtdmlzdGEuY29tIj5y
c2FuZ2FtQG12aXN0YS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkNWRSBmaXhl
ZDo8YnI+DQotQ1ZFLTIwMjQtMjEwOTQgT3BlbkpESzogQzIgY29tcGlsYXRpb24gZmFpbHMgd2l0
aCAmcXVvdDtFeGNlZWRlZCBfbm9kZV9yZWdzIGFycmF5JnF1b3Q7ICg4MzE3NTA3KTxicj4NClVw
c3RyZWFtLVN0YXR1czogQmFja3BvcnQgZnJvbSA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20v
b3Blbmpkay9qZGs4dS9jb21taXQvNDNjYjg3NTUwODY1YTkzYzU1OWM5ZThlYWE1OWZjYjA3MTMw
MWJkMyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29t
L29wZW5qZGsvamRrOHUvY29tbWl0LzQzY2I4NzU1MDg2NWE5M2M1NTljOWU4ZWFhNTlmY2IwNzEz
MDFiZDM8L2E+PGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogUm9oaW5pIFNhbmdhbSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnJzYW5nYW1AbXZpc3RhLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJzYW5nYW1A
bXZpc3RhLmNvbTwvYT4mZ3Q7PGJyPg0KU2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIERvc2hpICZs
dDs8YSBocmVmPSJtYWlsdG86c2Rvc2hpQG12aXN0YS5jb20iIHRhcmdldD0iX2JsYW5rIj5zZG9z
aGlAbXZpc3RhLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqAuLi4vb3Blbmpkay9vcGVuamRr
LTgtcmVsZWFzZS1jb21tb24uaW5jwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KwqAuLi4vcGF0Y2hl
cy1vcGVuamRrLTgvQ1ZFLTIwMjQtMjEwOTQucGF0Y2jCoCDCoCB8IDYzNyArKysrKysrKysrKysr
KysrKys8YnI+DQrCoDIgZmlsZXMgY2hhbmdlZCwgNjM4IGluc2VydGlvbnMoKyk8YnI+DQrCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWNvcmUvb3Blbmpkay9wYXRjaGVzLW9wZW5qZGstOC9D
VkUtMjAyNC0yMTA5NC5wYXRjaDxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUv
b3Blbmpkay9vcGVuamRrLTgtcmVsZWFzZS1jb21tb24uaW5jIGIvcmVjaXBlcy1jb3JlL29wZW5q
ZGsvb3Blbmpkay04LXJlbGVhc2UtY29tbW9uLmluYzxicj4NCmluZGV4IGZmOGQ5NmUuLmY3MWVi
MTAgMTAwNjQ0PGJyPg0KLS0tIGEvcmVjaXBlcy1jb3JlL29wZW5qZGsvb3Blbmpkay04LXJlbGVh
c2UtY29tbW9uLmluYzxicj4NCisrKyBiL3JlY2lwZXMtY29yZS9vcGVuamRrL29wZW5qZGstOC1y
ZWxlYXNlLWNvbW1vbi5pbmM8YnI+DQpAQCAtMjEsNiArMjEsNyBAQCBQQVRDSEVTX1VSSSA9ICZx
dW90O1w8YnI+DQrCoCDCoCDCoGZpbGU6Ly8yMDA3LWpkay1uby1nZW54MTEtaW4taGVhZGxlc3Mu
cGF0Y2ggXDxicj4NCsKgIMKgIMKgZmlsZTovLzIwMDgtamRrLW5vLXVudXNlZC1kZXBzLnBhdGNo
IFw8YnI+DQrCoCDCoCDCoGZpbGU6Ly8yMDA5LWpkay1tYWtlLXVzZS1nY2MtaW5zdGVhZC1vZi1s
ZC1mb3ItZ2VuU29ja2V0T3B0aW9uUmUucGF0Y2ggXDxicj4NCivCoCDCoCBmaWxlOi8vQ1ZFLTIw
MjQtMjEwOTQucGF0Y2ggXDxicj4NCsKgJnF1b3Q7PGJyPg0KwqBIT1RTUE9UX1VCX1BBVENIID0g
JnF1b3Q7XDxicj4NCsKgIMKgIMKgZmlsZTovLzEwMDEtaG90c3BvdC1maXgtY3Jhc2gtb24tSk5J
X0NyZWF0ZUphdmFWTS5wYXRjaCBcPGJyPg0KZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9vcGVu
amRrL3BhdGNoZXMtb3Blbmpkay04L0NWRS0yMDI0LTIxMDk0LnBhdGNoIGIvcmVjaXBlcy1jb3Jl
L29wZW5qZGsvcGF0Y2hlcy1vcGVuamRrLTgvQ1ZFLTIwMjQtMjEwOTQucGF0Y2g8YnI+DQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NDxicj4NCmluZGV4IDAwMDAwMDAuLjE4NTJiZDc8YnI+DQotLS0gL2Rl
di9udWxsPGJyPg0KKysrIGIvcmVjaXBlcy1jb3JlL29wZW5qZGsvcGF0Y2hlcy1vcGVuamRrLTgv
Q1ZFLTIwMjQtMjEwOTQucGF0Y2g8YnI+DQpAQCAtMCwwICsxLDYzNyBAQDxicj4NCitGcm9tIDQz
Y2I4NzU1MDg2NWE5M2M1NTljOWU4ZWFhNTlmY2IwNzEzMDFiZDMgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxPGJyPg0KK0Zyb206IE1hcnRpbiBCYWxhbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1iYWxh
b0BvcGVuamRrLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm1iYWxhb0BvcGVuamRrLm9yZzwvYT4mZ3Q7
PGJyPg0KK0RhdGU6IFdlZCwgMjcgTWFyIDIwMjQgMDM6MjE6MjUgKzAwMDA8YnI+DQorU3ViamVj
dDogW1BBVENIXSBDVkUtMjAyNC0yMTA5NDogODMxNzUwNzogQzIgY29tcGlsYXRpb24gZmFpbHMg
d2l0aCAmcXVvdDtFeGNlZWRlZCBfbm9kZV9yZWdzPGJyPg0KKyBhcnJheSZxdW90Ozxicj4NCis8
YnI+DQorVXBzdHJlYW0tU3RhdHVzOiBCYWNrcG9ydCBmcm9tIDxhIGhyZWY9Imh0dHBzOi8vZ2l0
aHViLmNvbS9vcGVuamRrL2pkazh1L2NvbW1pdC80M2NiODc1NTA4NjVhOTNjNTU5YzllOGVhYTU5
ZmNiMDcxMzAxYmQzIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dp
dGh1Yi5jb20vb3Blbmpkay9qZGs4dS9jb21taXQvNDNjYjg3NTUwODY1YTkzYzU1OWM5ZThlYWE1
OWZjYjA3MTMwMWJkMzwvYT48YnI+DQorQ1ZFOiBDVkUtMjAyNC0yMTA5NDxicj4NCis8YnI+DQor
U2lnbmVkLW9mZi1ieTogUm9oaW5pIFNhbmdhbSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJzYW5nYW1A
bXZpc3RhLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJzYW5nYW1AbXZpc3RhLmNvbTwvYT4mZ3Q7PGJy
Pg0KKy0tLTxicj4NCisgLi4uL2hvdHNwb3Qvc3JjL3NoYXJlL3ZtL2FkbGMvb3V0cHV0X2MuY3Bw
wqAgwqAgfMKgIMKgMiArPGJyPg0KKyAuLi4vcmVnYWxsb2MvVGVzdE5vZGVSZWdBcnJheU92ZXJm
bG93LmphdmHCoCDCoCB8IDU5OSArKysrKysrKysrKysrKysrKys8YnI+DQorIDIgZmlsZXMgY2hh
bmdlZCwgNjAxIGluc2VydGlvbnMoKyk8YnI+DQorIGNyZWF0ZSBtb2RlIDEwMDY0NCBob3RzcG90
L3Rlc3QvY29tcGlsZXIvcmVnYWxsb2MvVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93LmphdmE8YnI+
DQorPGJyPg0KK2RpZmYgLS1naXQgYS9ob3RzcG90L3NyYy9zaGFyZS92bS9hZGxjL291dHB1dF9j
LmNwcCBiL2hvdHNwb3Qvc3JjL3NoYXJlL3ZtL2FkbGMvb3V0cHV0X2MuY3BwPGJyPg0KK2luZGV4
IDE5OTE2OTA0Li5iODUxMjNiNCAxMDA2NDQ8YnI+DQorLS0tIGEvaG90c3BvdC9zcmMvc2hhcmUv
dm0vYWRsYy9vdXRwdXRfYy5jcHA8YnI+DQorKysrIGIvaG90c3BvdC9zcmMvc2hhcmUvdm0vYWRs
Yy9vdXRwdXRfYy5jcHA8YnI+DQorQEAgLTMwMjMsNiArMzAyMyw4IEBAIHN0YXRpYyB2b2lkIGRl
ZmluZV9maWxsX25ld19tYWNobm9kZShib29sIHVzZWQsIEZJTEUgKmZwX2NwcCkgezxicj4NCivC
oCDCoCDCoGZwcmludGYoZnBfY3BwLCAmcXVvdDvCoCDCoCBpZiggaSAhPSBjaXNjX29wZXJhbmQo
KSApIFxuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqBmcHJpbnRmKGZwX2NwcCwgJnF1b3Q7wqAgwqAg
wqAgdG9baV0gPSBfb3BuZHNbaV0tJmd0O2Nsb25lKEMpO1xuJnF1b3Q7KTs8YnI+DQorwqAgwqAg
wqBmcHJpbnRmKGZwX2NwcCwgJnF1b3Q7wqAgfVxuJnF1b3Q7KTs8YnI+DQorK8KgIMKgIGZwcmlu
dGYoZnBfY3BwLCAmcXVvdDvCoCAvLyBEbyBub3QgaW5jcmVtZW50IG5vZGUgaW5kZXggY291bnRl
ciwgc2luY2Ugbm9kZSByZXVzZXMgbXkgaW5kZXhcbiZxdW90Oyk7PGJyPg0KKyvCoCDCoCBmcHJp
bnRmKGZwX2NwcCwgJnF1b3Q7wqAgQy0mZ3Q7c2V0X3VuaXF1ZShDLSZndDt1bmlxdWUoKSAtIDEp
O1xuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqBmcHJpbnRmKGZwX2NwcCwgJnF1b3Q7fVxuJnF1b3Q7
KTs8YnI+DQorwqAgwqB9PGJyPg0KK8KgIMKgZnByaW50ZihmcF9jcHAsICZxdW90O1xuJnF1b3Q7
KTs8YnI+DQorZGlmZiAtLWdpdCBhL2hvdHNwb3QvdGVzdC9jb21waWxlci9yZWdhbGxvYy9UZXN0
Tm9kZVJlZ0FycmF5T3ZlcmZsb3cuamF2YSBiL2hvdHNwb3QvdGVzdC9jb21waWxlci9yZWdhbGxv
Yy9UZXN0Tm9kZVJlZ0FycmF5T3ZlcmZsb3cuamF2YTxicj4NCituZXcgZmlsZSBtb2RlIDEwMDY0
NDxicj4NCitpbmRleCAwMDAwMDAwMC4uMjgxNTI0Y2M8YnI+DQorLS0tIC9kZXYvbnVsbDxicj4N
CisrKysgYi9ob3RzcG90L3Rlc3QvY29tcGlsZXIvcmVnYWxsb2MvVGVzdE5vZGVSZWdBcnJheU92
ZXJmbG93LmphdmE8YnI+DQorQEAgLTAsMCArMSw1OTkgQEA8YnI+DQorKy8qPGJyPg0KKysgKiBD
b3B5cmlnaHQgKGMpIDIwMjMsIE9yYWNsZSBhbmQvb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCByaWdo
dHMgcmVzZXJ2ZWQuPGJyPg0KKysgKiBETyBOT1QgQUxURVIgT1IgUkVNT1ZFIENPUFlSSUdIVCBO
T1RJQ0VTIE9SIFRISVMgRklMRSBIRUFERVIuPGJyPg0KKysgKjxicj4NCisrICogVGhpcyBjb2Rl
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQ8YnI+DQorKyAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyIG9ubHksIGFzPGJyPg0KKysgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbi48YnI+DQorKyAqPGJyPg0KKysgKiBUaGlzIGNvZGUgaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0IFdJVEhPVVQ8
YnI+DQorKyAqIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mIE1FUkNIQU5UQUJJTElUWSBvcjxicj4NCisrICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuwqAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZTxicj4NCisrICog
dmVyc2lvbiAyIGZvciBtb3JlIGRldGFpbHMgKGEgY29weSBpcyBpbmNsdWRlZCBpbiB0aGUgTElD
RU5TRSBmaWxlIHRoYXQ8YnI+DQorKyAqIGFjY29tcGFuaWVkIHRoaXMgY29kZSkuPGJyPg0KKysg
Kjxicj4NCisrICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbjxicj4NCisrICogMiBhbG9uZyB3aXRoIHRoaXMg
d29yazsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLDxicj4N
CisrICogSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEw
LTEzMDEgVVNBLjxicj4NCisrICo8YnI+DQorKyAqIFBsZWFzZSBjb250YWN0IE9yYWNsZSwgNTAw
IE9yYWNsZSBQYXJrd2F5LCBSZWR3b29kIFNob3JlcywgQ0EgOTQwNjUgVVNBPGJyPg0KKysgKiBv
ciB2aXNpdCA8YSBocmVmPSJodHRwOi8vd3d3Lm9yYWNsZS5jb20iIHJlbD0ibm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiPnd3dy5vcmFjbGUuY29tPC9hPiBpZiB5b3UgbmVlZCBhZGRpdGlvbmFs
IGluZm9ybWF0aW9uIG9yIGhhdmUgYW55PGJyPg0KKysgKiBxdWVzdGlvbnMuPGJyPg0KKysgKi88
YnI+DQorKzxicj4NCisrcGFja2FnZSBjb21waWxlci5yZWdhbGxvYzs8YnI+DQorKzxicj4NCisr
LyoqPGJyPg0KKysgKiBAdGVzdDxicj4NCisrICogQGJ1ZyA4MzE3NTA3PGJyPg0KKysgKiBAc3Vt
bWFyeSBUZXN0IHRoYXQgQzImIzM5O3MgUGhhc2VSZWdBbGxvYzo6X25vZGVfcmVncyAoYSBwb3N0
LXJlZ2lzdGVyLWFsbG9jYXRpb248YnI+DQorKyAqwqAgwqAgwqAgwqAgwqAgbWFwcGluZyBmcm9t
IG1hY2hpbmUgbm9kZXMgdG8gYXNzaWduZWQgcmVnaXN0ZXJzKSBkb2VzIG5vdCBvdmVyZmxvdzxi
cj4NCisrICrCoCDCoCDCoCDCoCDCoCBpbiB0aGUgZmFjZSBvZiBhIHByb2dyYW0gd2l0aCBhIGhp
Z2gtZGVuc2l0eSBvZiBDSVNDIHNwaWxsaW5nPGJyPg0KKysgKsKgIMKgIMKgIMKgIMKgIGNhbmRp
ZGF0ZSBub2Rlcy48YnI+DQorKyAqIEBydW4gbWFpbi9vdGhlcnZtIC1YY29tcCAtWFg6Q29tcGls
ZU9ubHk9Y29tcGlsZXIucmVnYWxsb2MuVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93Ojp0ZXN0V2l0
aENvbXBpbGVyVW5yb2xsaW5nPGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC1YWDpDb21waWxlQ29tbWFuZD1kb250aW5saW5lLGNvbXBpbGVyLnJlZ2FsbG9jLlRlc3ROb2Rl
UmVnQXJyYXlPdmVyZmxvdzo6ZG9udElubGluZTxicj4NCisrwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjb21waWxlci5yZWdhbGxvYy5UZXN0Tm9kZVJlZ0FycmF5T3ZlcmZsb3cgY29t
cGlsZXI8YnI+DQorKyAqIEBydW4gbWFpbi9vdGhlcnZtIC1YY29tcCAtWFg6Q29tcGlsZU9ubHk9
Y29tcGlsZXIucmVnYWxsb2MuVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93Ojp0ZXN0V2l0aE1hbnVh
bFVucm9sbGluZzxicj4NCisrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtWFg6Q29t
cGlsZUNvbW1hbmQ9ZG9udGlubGluZSxjb21waWxlci5yZWdhbGxvYy5UZXN0Tm9kZVJlZ0FycmF5
T3ZlcmZsb3c6OmRvbnRJbmxpbmU8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY29tcGlsZXIucmVnYWxsb2MuVGVzdE5vZGVSZWdBcnJheU92ZXJmbG93IG1hbnVhbDxicj4N
CisrICovPGJyPg0KKys8YnI+DQorK3B1YmxpYyBjbGFzcyBUZXN0Tm9kZVJlZ0FycmF5T3ZlcmZs
b3cgezxicj4NCisrPGJyPg0KKyvCoCDCoCBzdGF0aWMgaW50IGRvbnRJbmxpbmUoKSB7PGJyPg0K
KyvCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+DQorK8KgIMKgIH08YnI+DQorKzxicj4NCisrwqAg
wqAgc3RhdGljIGZsb2F0IHRlc3RXaXRoQ29tcGlsZXJVbnJvbGxpbmcoZmxvYXQgaW5jKSB7PGJy
Pg0KKyvCoCDCoCDCoCDCoCBpbnQgaSA9IDAsIGogPSAwOzxicj4NCisrwqAgwqAgwqAgwqAgLy8g
VGhpcyBub24taW5saW5lZCBtZXRob2QgY2FsbCBjYXVzZXMgJiMzOTtpbmMmIzM5OyB0byBiZSBz
cGlsbGVkLjxicj4NCisrwqAgwqAgwqAgwqAgZmxvYXQgZiA9IGRvbnRJbmxpbmUoKTs8YnI+DQor
K8KgIMKgIMKgIMKgIC8vIFRoaXMgdHdvLWxldmVsIHJlZHVjdGlvbiBsb29wIGlzIHVucm9sbGVk
IDUxMiB0aW1lcywgd2hpY2ggaXM8YnI+DQorK8KgIMKgIMKgIMKgIC8vIHJlcXVlc3RlZCBieSB0
aGUgU0xQLXNwZWNpZmljIHVucm9sbGluZyBhbmFseXNpcywgYnV0IG5vdCB2ZWN0b3JpemVkLjxi
cj4NCisrwqAgwqAgwqAgwqAgLy8gQmVjYXVzZSAmIzM5O2luYyYjMzk7IGlzIHNwaWxsZWQsIGVh
Y2ggb2YgdGhlIHVucm9sbGVkIEFkZEYgbm9kZXMgaXM8YnI+DQorK8KgIMKgIMKgIMKgIC8vIENJ
U0Mtc3BpbGwgY29udmVydGVkIChQaGFzZUNoYWl0aW46OmZpeHVwX3NwaWxscygpKS4gQmVmb3Jl
IHRoZSBmaXgsPGJyPg0KKyvCoCDCoCDCoCDCoCAvLyB0aGlzIGNhdXNlcyB0aGUgdW5pcXVlIG5v
ZGUgaW5kZXggY291bnRlciAoQ29tcGlsZTo6X3VuaXF1ZSkgdG8gZ3Jvdzxicj4NCisrwqAgwqAg
wqAgwqAgLy8gYmV5b25kIHRoZSBzaXplIG9mIHRoZSBub2RlIHJlZ2lzdGVyIGFycmF5PGJyPg0K
KyvCoCDCoCDCoCDCoCAvLyAoUGhhc2VSZWdBbGxvYzo6X25vZGVfcmVncyksIGFuZCBsZWFkcyB0
byBvdmVyZmxvdyB3aGVuIGFjY2Vzc2VkIGZvcjxicj4NCisrwqAgwqAgwqAgwqAgLy8gbm9kZXMg
dGhhdCBhcmUgY3JlYXRlZCBsYXRlciAoZS5nLiBkdXJpbmcgdGhlIHBlZXBob2xlIHBoYXNlKS48
YnI+DQorK8KgIMKgIMKgIMKgIHdoaWxlIChpKysgJmx0OyAxMjgpIHs8YnI+DQorK8KgIMKgIMKg
IMKgIMKgIMKgIGZvciAoaiA9IDA7IGogJmx0OyAxNjsgaisrKSB7PGJyPg0KKyvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQor
K8KgIMKgIMKgIMKgIH08YnI+DQorK8KgIMKgIMKgIMKgIHJldHVybiBmOzxicj4NCisrwqAgwqAg
fTxicj4NCisrPGJyPg0KKyvCoCDCoCAvLyBUaGlzIHRlc3QgcmVwcm9kdWNlcyB0aGUgc2FtZSBm
YWlsdXJlIGFzICYjMzk7dGVzdFdpdGhDb21waWxlclVucm9sbGluZyYjMzk7PGJyPg0KKyvCoCDC
oCAvLyB3aXRob3V0IHJlbHlpbmcgb24gbG9vcCB0cmFuc2Zvcm1hdGlvbnMuPGJyPg0KKyvCoCDC
oCBzdGF0aWMgZmxvYXQgdGVzdFdpdGhNYW51YWxVbnJvbGxpbmcoZmxvYXQgaW5jKSB7PGJyPg0K
KyvCoCDCoCDCoCDCoCBpbnQgaSA9IDAsIGogPSAwOzxicj4NCisrwqAgwqAgwqAgwqAgZmxvYXQg
ZiA9IGRvbnRJbmxpbmUoKTs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAg
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
wqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKg
IMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDC
oCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKgIMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAg
wqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDCoCDCoCDCoCBmICs9IGluYzs8YnI+DQorK8KgIMKg
IMKgIMKgIGYgKz0gaW5jOzxicj4NCisrwqAgwqAgwqAgwqAgZiArPSBpbmM7PGJyPg0KKyvCoCDC
oCDCoCDCoCByZXR1cm4gZjs8YnI+DQorK8KgIMKgIH08YnI+DQorKzxicj4NCisrwqAgwqAgcHVi
bGljIHN0YXRpYyB2b2lkIG1haW4oU3RyaW5nW10gYXJncykgezxicj4NCisrwqAgwqAgwqAgwqAg
c3dpdGNoIChhcmdzWzBdKSB7PGJyPg0KKyvCoCDCoCDCoCDCoCBjYXNlICZxdW90O2NvbXBpbGVy
JnF1b3Q7Ojxicj4NCisrwqAgwqAgwqAgwqAgwqAgwqAgdGVzdFdpdGhDb21waWxlclVucm9sbGlu
ZygwKTs8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCisrwqAgwqAgwqAgwqAg
Y2FzZSAmcXVvdDttYW51YWwmcXVvdDs6PGJyPg0KKyvCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0V2l0
aE1hbnVhbFVucm9sbGluZygwKTs8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4N
CisrwqAgwqAgwqAgwqAgZGVmYXVsdDo8YnI+DQorK8KgIMKgIMKgIMKgIMKgIMKgIHRocm93IG5l
dyBJbGxlZ2FsQXJndW1lbnRFeGNlcHRpb24oJnF1b3Q7SW52YWxpZCBtb2RlOiAmcXVvdDsgKyBh
cmdzWzBdKTs8YnI+DQorK8KgIMKgIMKgIMKgIH08YnI+DQorK8KgIMKgIH08YnI+DQorK308YnI+
DQorLS0gPGJyPg0KKzIuMzUuNzxicj4NCis8YnI+DQotLSA8YnI+DQoyLjM0LjE8YnI+DQo8YnI+
DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--000000000000e73cce061cf36b83--

