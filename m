Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09AC3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 07:19:12 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.9678.1721200748359387542
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jul 2024 00:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CiF36XOM;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eec7e43229so76694271fa.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721200746; x=1721805546; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1I7A14Hb7oaCaZwVyo8+V3eAeeRizwimlOPyfOOpr0=;
        b=CiF36XOMZfQ1A9jKxs7TaskLlww/zFeY3U9vewoBzLvOjqQkJbZ2LXC69Cd66Pcuah
         su8YeSKNpplhR11YI7LGzLksMnAmIba3MQWSPQVUmVnHRSkODzSBs2ilyIYVY5sNuiQb
         9UxT8TYnwVYJze9hQreq73AINXnhUcAq87nvx70m7lxvZ9lVtJX/1DkwszBbWNf6/sd9
         CF2y2z93p7Mn69fb/bm1s+Yi1k+8XgX450X/Z+ieJ6nbNBCo03zb/OKbWLMbMjuQ+rSF
         tvZaKwegnE2Sa/rhAtf2ejCahwA9/sY+k/w/I8ni7/s12iAqYG4Y+U/oh7PJvmEc8zW9
         cNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721200746; x=1721805546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1I7A14Hb7oaCaZwVyo8+V3eAeeRizwimlOPyfOOpr0=;
        b=ln19DJYcakPH50RCdiSd+FUsGRAJy+lvn2ZSwlKt7fWTAcg4on065WDI2gvB2/Xghz
         KTojs9grrFW+8wOO7v6JC7Fv2w10yXrtfE55TDYkWrqnB9066ZE+tjhAwI9lhpYiltIH
         wCJ5Bd6HMbak2Gm+l9Adsi5f/ruypGi6yWkQDi+RmAY+bahgQiK1qs+dnYznkrV4AJjO
         gfedSql8/fd8ejTti4gtEcvo5OB3IbGmmJNRfRRWABR29Z2BMXJ7tTxAQB64X21LODdK
         VE2cDJ8cHYC9vLOEL1VEwtrHyTZqm81bL9iDwiZ8V/0SBF9rNxTjXlid00qVNunD6sVY
         kPzg==
X-Gm-Message-State: AOJu0Yy0DAJkarK8cRuM1Bb/UU3syFtDBorQZfJQz4H/efdjqFiONFGN
	RJSK45uSBL9vHDzah7zg1kpisoJG+Zf2LmhV+C4R2MI6WpGb/HOo9E7uhtUjgnDxgyGc8Y7xguJ
	ZWubiHJXq6pzKZdDKhSJdlBE/lQNkJQ==
X-Google-Smtp-Source: AGHT+IFFt3x/aYszbj0GgzG3ThaKM7rKvDnusTTLZhx1TM9TDfehKR1u+OIzIPH8yxNnYAbws17yvTE43FgXbiPxRbU=
X-Received: by 2002:a05:651c:b2c:b0:2ec:7300:d02f with SMTP id
 38308e7fff4ca-2eefd18780bmr6700021fa.49.1721200746041; Wed, 17 Jul 2024
 00:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240702073934.21734-1-rsangam@mvista.com> <CAL7QmvCeuw71G0Y3AoeRwq8WbNApsMCpVbdMNfh6c8hWc8dGAQ@mail.gmail.com>
 <CAL7QmvC0YoYeYwZgfSvV=RLCmGqNbRE1RgmDKccBvXFQVwDOOw@mail.gmail.com>
In-Reply-To: <CAL7QmvC0YoYeYwZgfSvV=RLCmGqNbRE1RgmDKccBvXFQVwDOOw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 17 Jul 2024 09:18:54 +0200
Message-ID: <CANNYZj-qHcxsxwS5oBnYrT8gkxz2N4d2nG=HsCew_1578UZazg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java][master][PATCH] openjdk-8: Security
 fix for CVE-2024-21094
To: yocto-patches@lists.yoctoproject.org
Cc: Siddharth Doshi <sdoshi@mvista.com>, Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 07:19:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/436

I think you should CC Tim. Note that meta-java may not be maintained anymor=
e.

Alex

On Wed, 17 Jul 2024 at 06:19, Rohini Sangam via lists.yoctoproject.org
<rsangam=3Dmvista.com@lists.yoctoproject.org> wrote:
>
> Gentle reminder!!!
> Any update on this ??
>
> Regards,
> Rohini Sangam
>
> On Thu, Jul 11, 2024 at 12:37=E2=80=AFPM Rohini Sangam <rsangam@mvista.co=
m> wrote:
>>
>> Gentle reminder!!!
>> Any update on this ??
>>
>> Regards,
>> Rohini Sangam
>>
>> On Tue, Jul 2, 2024 at 1:09=E2=80=AFPM Rohini Sangam <rsangam@mvista.com=
> wrote:
>>>
>>> CVE fixed:
>>> -CVE-2024-21094 OpenJDK: C2 compilation fails with "Exceeded _node_regs=
 array" (8317507)
>>> Upstream-Status: Backport from https://github.com/openjdk/jdk8u/commit/=
43cb87550865a93c559c9e8eaa59fcb071301bd3
>>>
>>> Signed-off-by: Rohini Sangam <rsangam@mvista.com>
>>> Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
>>> ---
>>>  .../openjdk/openjdk-8-release-common.inc      |   1 +
>>>  .../patches-openjdk-8/CVE-2024-21094.patch    | 637 ++++++++++++++++++
>>>  2 files changed, 638 insertions(+)
>>>  create mode 100644 recipes-core/openjdk/patches-openjdk-8/CVE-2024-210=
94.patch
>>>
>>> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipe=
s-core/openjdk/openjdk-8-release-common.inc
>>> index ff8d96e..f71eb10 100644
>>> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
>>> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
>>> @@ -21,6 +21,7 @@ PATCHES_URI =3D "\
>>>      file://2007-jdk-no-genx11-in-headless.patch \
>>>      file://2008-jdk-no-unused-deps.patch \
>>>      file://2009-jdk-make-use-gcc-instead-of-ld-for-genSocketOptionRe.p=
atch \
>>> +    file://CVE-2024-21094.patch \
>>>  "
>>>  HOTSPOT_UB_PATCH =3D "\
>>>      file://1001-hotspot-fix-crash-on-JNI_CreateJavaVM.patch \
>>> diff --git a/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patc=
h b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>>> new file mode 100644
>>> index 0000000..1852bd7
>>> --- /dev/null
>>> +++ b/recipes-core/openjdk/patches-openjdk-8/CVE-2024-21094.patch
>>> @@ -0,0 +1,637 @@
>>> +From 43cb87550865a93c559c9e8eaa59fcb071301bd3 Mon Sep 17 00:00:00 2001
>>> +From: Martin Balao <mbalao@openjdk.org>
>>> +Date: Wed, 27 Mar 2024 03:21:25 +0000
>>> +Subject: [PATCH] CVE-2024-21094: 8317507: C2 compilation fails with "E=
xceeded _node_regs
>>> + array"
>>> +
>>> +Upstream-Status: Backport from https://github.com/openjdk/jdk8u/commit=
/43cb87550865a93c559c9e8eaa59fcb071301bd3
>>> +CVE: CVE-2024-21094
>>> +
>>> +Signed-off-by: Rohini Sangam <rsangam@mvista.com>
>>> +---
>>> + .../hotspot/src/share/vm/adlc/output_c.cpp    |   2 +
>>> + .../regalloc/TestNodeRegArrayOverflow.java    | 599 +++++++++++++++++=
+
>>> + 2 files changed, 601 insertions(+)
>>> + create mode 100644 hotspot/test/compiler/regalloc/TestNodeRegArrayOve=
rflow.java
>>> +
>>> +diff --git a/hotspot/src/share/vm/adlc/output_c.cpp b/hotspot/src/shar=
e/vm/adlc/output_c.cpp
>>> +index 19916904..b85123b4 100644
>>> +--- a/hotspot/src/share/vm/adlc/output_c.cpp
>>> ++++ b/hotspot/src/share/vm/adlc/output_c.cpp
>>> +@@ -3023,6 +3023,8 @@ static void define_fill_new_machnode(bool used, =
FILE *fp_cpp) {
>>> +     fprintf(fp_cpp, "    if( i !=3D cisc_operand() ) \n");
>>> +     fprintf(fp_cpp, "      to[i] =3D _opnds[i]->clone(C);\n");
>>> +     fprintf(fp_cpp, "  }\n");
>>> ++    fprintf(fp_cpp, "  // Do not increment node index counter, since =
node reuses my index\n");
>>> ++    fprintf(fp_cpp, "  C->set_unique(C->unique() - 1);\n");
>>> +     fprintf(fp_cpp, "}\n");
>>> +   }
>>> +   fprintf(fp_cpp, "\n");
>>> +diff --git a/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.j=
ava b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>>> +new file mode 100644
>>> +index 00000000..281524cc
>>> +--- /dev/null
>>> ++++ b/hotspot/test/compiler/regalloc/TestNodeRegArrayOverflow.java
>>> +@@ -0,0 +1,599 @@
>>> ++/*
>>> ++ * Copyright (c) 2023, Oracle and/or its affiliates. All rights reser=
ved.
>>> ++ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
>>> ++ *
>>> ++ * This code is free software; you can redistribute it and/or modify =
it
>>> ++ * under the terms of the GNU General Public License version 2 only, =
as
>>> ++ * published by the Free Software Foundation.
>>> ++ *
>>> ++ * This code is distributed in the hope that it will be useful, but W=
ITHOUT
>>> ++ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or
>>> ++ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lice=
nse
>>> ++ * version 2 for more details (a copy is included in the LICENSE file=
 that
>>> ++ * accompanied this code).
>>> ++ *
>>> ++ * You should have received a copy of the GNU General Public License =
version
>>> ++ * 2 along with this work; if not, write to the Free Software Foundat=
ion,
>>> ++ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
>>> ++ *
>>> ++ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 9406=
5 USA
>>> ++ * or visit www.oracle.com if you need additional information or have=
 any
>>> ++ * questions.
>>> ++ */
>>> ++
>>> ++package compiler.regalloc;
>>> ++
>>> ++/**
>>> ++ * @test
>>> ++ * @bug 8317507
>>> ++ * @summary Test that C2's PhaseRegAlloc::_node_regs (a post-register=
-allocation
>>> ++ *          mapping from machine nodes to assigned registers) does no=
t overflow
>>> ++ *          in the face of a program with a high-density of CISC spil=
ling
>>> ++ *          candidate nodes.
>>> ++ * @run main/othervm -Xcomp -XX:CompileOnly=3Dcompiler.regalloc.TestN=
odeRegArrayOverflow::testWithCompilerUnrolling
>>> ++                     -XX:CompileCommand=3Ddontinline,compiler.regallo=
c.TestNodeRegArrayOverflow::dontInline
>>> ++                     compiler.regalloc.TestNodeRegArrayOverflow compi=
ler
>>> ++ * @run main/othervm -Xcomp -XX:CompileOnly=3Dcompiler.regalloc.TestN=
odeRegArrayOverflow::testWithManualUnrolling
>>> ++                     -XX:CompileCommand=3Ddontinline,compiler.regallo=
c.TestNodeRegArrayOverflow::dontInline
>>> ++                     compiler.regalloc.TestNodeRegArrayOverflow manua=
l
>>> ++ */
>>> ++
>>> ++public class TestNodeRegArrayOverflow {
>>> ++
>>> ++    static int dontInline() {
>>> ++        return 0;
>>> ++    }
>>> ++
>>> ++    static float testWithCompilerUnrolling(float inc) {
>>> ++        int i =3D 0, j =3D 0;
>>> ++        // This non-inlined method call causes 'inc' to be spilled.
>>> ++        float f =3D dontInline();
>>> ++        // This two-level reduction loop is unrolled 512 times, which=
 is
>>> ++        // requested by the SLP-specific unrolling analysis, but not =
vectorized.
>>> ++        // Because 'inc' is spilled, each of the unrolled AddF nodes =
is
>>> ++        // CISC-spill converted (PhaseChaitin::fixup_spills()). Befor=
e the fix,
>>> ++        // this causes the unique node index counter (Compile::_uniqu=
e) to grow
>>> ++        // beyond the size of the node register array
>>> ++        // (PhaseRegAlloc::_node_regs), and leads to overflow when ac=
cessed for
>>> ++        // nodes that are created later (e.g. during the peephole pha=
se).
>>> ++        while (i++ < 128) {
>>> ++            for (j =3D 0; j < 16; j++) {
>>> ++                f +=3D inc;
>>> ++            }
>>> ++        }
>>> ++        return f;
>>> ++    }
>>> ++
>>> ++    // This test reproduces the same failure as 'testWithCompilerUnro=
lling'
>>> ++    // without relying on loop transformations.
>>> ++    static float testWithManualUnrolling(float inc) {
>>> ++        int i =3D 0, j =3D 0;
>>> ++        float f =3D dontInline();
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        f +=3D inc;
>>> ++        return f;
>>> ++    }
>>> ++
>>> ++    public static void main(String[] args) {
>>> ++        switch (args[0]) {
>>> ++        case "compiler":
>>> ++            testWithCompilerUnrolling(0);
>>> ++            break;
>>> ++        case "manual":
>>> ++            testWithManualUnrolling(0);
>>> ++            break;
>>> ++        default:
>>> ++            throw new IllegalArgumentException("Invalid mode: " + arg=
s[0]);
>>> ++        }
>>> ++    }
>>> ++}
>>> +--
>>> +2.35.7
>>> +
>>> --
>>> 2.34.1
>>>
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#435) | Reply To Group | Reply To Sender | Mute This T=
opic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [alex.kanavin@gmail=
.com]
>
> _._,_._,_

