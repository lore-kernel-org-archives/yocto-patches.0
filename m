Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235AFF4936
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 21:07:14 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5099.1775250427417162836
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 14:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=P658SVdl;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a283c44478so2558667e87.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 14:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775250425; cv=none;
        d=google.com; s=arc-20240605;
        b=bz/e3P2zMOMrlZYr425LU8wHWgTp4zpduMLnDFR5GVG6NmV2mu8sFdPVLZ9SbeRSvv
         l6s5wCVAdEVN0p5ugvQ2u+mw1hn7XiJiZ6v2esgTM+t+xdBnBSodK49v8RnWfEvovbIs
         nL5zMiwv8f2e36sZtxAW6H1LikUWfdhJs62OyUtiQ97luwwwCOF3GeBVxeV8smr1V6v0
         OfW9/onxd2ykAqwcSYSo8KIUBusHA4+XJr8fzT5lKwOo6B7hqV12HvBJfgoDG4h8D6Ub
         sveY4Uj9/D12jCaSmBriZ5vsASZfLYIdZjXm+TXMPW9qj4iUzgzfCwus65YPUfQqqXWv
         sN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRyPlZpESNlXwJOFwO1O8oK86+jR+Xe5KkmrFFSQbdM=;
        fh=YxyZJTwvlnYL1a/o6tF5vRj+Cc3YRjLc3I44lBzCqGk=;
        b=XDFzgFBFJ7MSj5LsnNK8NhnLXGQoMY1Ju1k5lBaIzDmK1U55ST+09zQN3q31S3PRWe
         BvnOD3t7WPXo/cAWQ1jexIPCOXiOXBTTSFGuvPRjZpcbI2YY13v0oKNTa7lKRCL7m/ss
         QK0l+HD7T2KAu+/Hs3gPl0u9uL+w73MsY9/5a6e6Nf/vj2N9+t0y+jRcjoU+1czONPO1
         gMb432hhMUzJG/CWsI7lZhuZ70ki2IlGJ/sRv7ifwNmtW4CfLy3Rysr6dHmbDnVLdw3l
         bv1EU3NRrmMCTh54Txs3gpQmgui1lEeP/u8UjdENUXydR2dO3uRI06rt1S8nmoO7IONH
         5jzA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775250425; x=1775855225; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRyPlZpESNlXwJOFwO1O8oK86+jR+Xe5KkmrFFSQbdM=;
        b=P658SVdl58Sak19nB/SQjqtbfgDSdIti7KktCS6n3HoLiOhTE4UwusT0N4jKerIjzw
         0k2lT0JBSX0riW8g93/4rYpeH4T0Fyh75+zL4+N7oQ+223OBdSb11h/b4CJEmga4aU2K
         s4+VDQIipqtxD03oXTn8f9uiAJ8gMOES/cLkkTBZmp/TL6iNXdUwJ5BNt6Srxpdw5VWM
         6kmuuQS0amGMPwssM01CJIzxC0gbjumxMujNCFEVyf81QD2qpridAgtguJw5IF7oPklv
         zsNLG+tRcnWWtWMNba8fMMypRxmiWrZLBrAtsGSUi1wAKLgBSJHhbI/CWmLNzyu//pDE
         bAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250425; x=1775855225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRyPlZpESNlXwJOFwO1O8oK86+jR+Xe5KkmrFFSQbdM=;
        b=OuLsvMmuQjkT6QTw/CcUQGaLMRm+DnBMIr2WYsVfTDmtngg/srlfQkSTgK2T+YXte4
         2PApzeADWy8loO30gqBm191NCwHRDpuM8lVpYLHZ+AOtmt23sWL5qEw37OqELHGX/oe9
         LHOGttXMkMvu77IhF495DK9XdG0Ks+my5aOCEJNLtVY0eYn9Zlt9qAii9dieAuY4txsD
         Zpa1q9BEWTvK74olKs6jwU5wgD7OeCRUieMsVqOjsRpW2yu5rgdfD+8oM4n+OITEcCAO
         XJNnKJvdy9pdsuFJv4FoJ9ehlpERcYNwQnasaem+ptKOjctgWPipQnbCL34avNsox6Wr
         SEXA==
X-Gm-Message-State: AOJu0Yy2t/i/pwxrJ/ZDwkEkiHUBUQWhvvk6OmohvJpO0KK8MIiZ9MlW
	yVcTib2yFyHNXrpvacL373pMMVD5TAia2BUF1xh+YCMzo3WYGPlZPXaVSCThcGhD6Q2t7g3/ty9
	UZEZvFpr4V4yaMX8c6kpq3lUvfvbtG8gAxVqA
X-Gm-Gg: AeBDievGlV7XI5GDe5AIlHQTH5Zh3bVMLRc7uwH6k3cK5hY6tdx8Dy0n9dJsVlYIY+C
	+x27BH815/dh7jtizkQsumxCEFsDf/GSagC8PI5FtAxaIEp86g7uOijWcy8E8x9uy0/QLDIITWz
	BdG9TH/r5HFjpxswQ61PL5MTmi2G6k3+WaJDMAYJZhY3r/yyaY110BHkbpUpJjA/R1edZT6M0UC
	Xewi9qxA5PKkViSexetqP2PEI1uPmbimf2FhR/mXSR2CxS8lb+n8lkyCbEbPJ9v1KTHCPWa5TAO
	WazORThn+PrWDSqoMF8T
X-Received: by 2002:a05:6512:1108:b0:5a2:b3d8:443b with SMTP id
 2adb3069b0e04-5a337596e4fmr1207515e87.43.1775250424747; Fri, 03 Apr 2026
 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053022.96757-1-martin.jansa@gmail.com>
 <9d3a3b8c-2b03-41ed-8ac9-49ae7ec174a6@windriver.com> <18A23E43F60C98CB.509824@lists.yoctoproject.org>
In-Reply-To: <18A23E43F60C98CB.509824@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 3 Apr 2026 23:06:48 +0200
X-Gm-Features: AQROBzAH9kyzB0Z2kJDWbnmLwpIrYqKrNAswyBMUo1amLh_X5LfZKpGMTgp7AEs
Message-ID: <CA+chaQe03v1X3wkfVAg=wVi1wk7my+pzrzG39zzeXE9uLaRkvg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow-lite: don't
 install flatbuffers header files
To: yocto-patches@lists.yoctoproject.org
Cc: Hongxu Jia <hongxu.jia@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 21:07:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3636

On Wed, Apr 1, 2026 at 3:21=E2=80=AFPM Martin Jansa via lists.yoctoproject.=
org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org> wrote:
>
> On Wed, Apr 1, 2026 at 7:34=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.c=
om> wrote:
> >
> > On 4/1/26 13:30, martin.jansa@gmail.com wrote:
> > > CAUTION: This email comes from a non Wind River email account!
> > > Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
> > >
> > > From: Martin Jansa <martin.jansa@gmail.com>
> > >
> > > https://lists.yoctoproject.org/g/yocto-patches/message/2186
> > > breaks a build for recipes which depend on both tensorflow-lite and f=
latbuffers because of conflicts in RSS as in:
> > > ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file /usr/include/fl=
atbuffers/array.h is installed by both tensorflow-lite and flatbuffers, abo=
rting
> > >
> > > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > > ---
> > >   recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 7 -------
> > >   1 file changed, 7 deletions(-)
> >
> > Merged
> >
> > //Hongxu
>
> Thank you for quick update.
>
> With newer ubuntu on host I'm seeing one more issue with bazel-native,
> will send a patch or more details when I figure out what's wrong, but
> it fails with ubuntu-25.04 and newer while in ubuntu-24.04 and 24.10
> it built bazel-native fine.
>
> I'm sharing it now just in case you've already seen this issue and
> might have some pending fix already.
>
> The log from 24.04 doesn't show "Linking src/main/cpp/util/libport.a"
> at all, so I guess it's util:port dependency somehow not required, but
> I'm still searching why (in all that bazel output which is a bit
> confusing to me :)).

Thank you for merging those small cleanups for bazel recipe.

Maybe you've noticed the fix for this "ar" issue as well:
https://lists.openembedded.org/g/openembedded-core/message/234468

Now with a lot more debugging I also know why only ubuntu-26.04 called ar
while ubuntu-24.04 didn't and it boils down to detected features, mostly
supports_start_end_lib in gold linker preferred by bazel in 24.04:

work/x86_64-linux/bazel-native/7.7.0/sources $ diff -uNr
/OE/lge/.cache/bazel/_bazel_bitbake/*/external/rules_cc~~cc_configure_exten=
sion~local_config_cc/BUILD
--- /OE/lge/.cache/bazel/_bazel_bitbake/0e259dd960791f8b4e31fbc469f19299/ex=
ternal/rules_cc~~cc_configure_extension~local_config_cc/BUILD
       2026-04-03 20:55:30.662177841 +0200
+++ /OE/lge/.cache/bazel/_bazel_bitbake/a47ed104727c1f493f7aa830ae20096b/ex=
ternal/rules_cc~~cc_configure_extension~local_config_cc/BUILD
       2026-04-03 21:03:44.814557111 +0200
@@ -111,13 +111,13 @@
     target_libc =3D "local",
     abi_version =3D "local",
     abi_libc_version =3D "local",
-    cxx_builtin_include_directories =3D
["/usr/lib/gcc/x86_64-linux-gnu/13/include",
+    cxx_builtin_include_directories =3D
["/usr/lib/gcc/x86_64-linux-gnu/15/include",
     "/usr/local/include",
     "/usr/include/x86_64-linux-gnu",
     "/usr/include",
-    "/usr/include/c++/13",
-    "/usr/include/x86_64-linux-gnu/c++/13",
-    "/usr/include/c++/13/backward",
+    "/usr/include/c++/15",
+    "/usr/include/x86_64-linux-gnu/c++/15",
+    "/usr/include/c++/15/backward",
     "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"],
     tool_paths =3D {"ar": "/usr/bin/ar",
         "ld": "/usr/bin/ld",
@@ -147,8 +147,7 @@
     dbg_compile_flags =3D ["-g"],
     conly_flags =3D [],
     cxx_flags =3D ["-std=3Dc++17"],
-    link_flags =3D ["-fuse-ld=3Dgold",
-    "-B/usr/bin",
+    link_flags =3D ["-B/usr/bin",
     "-Wl,-no-as-needed",
     "-Wl,-z,relro,-z,now",
     "-pass-exit-codes"],
@@ -166,7 +165,7 @@
     "-D__TIME__=3D\"redacted\""],
     coverage_compile_flags =3D ["--coverage"],
     coverage_link_flags =3D ["--coverage"],
-    supports_start_end_lib =3D True,
+    supports_start_end_lib =3D False,
     extra_flags_per_feature =3D {},
 )

And then linking e.g.
bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so was on 24.04
using .o files directly with "-Wl,--start-lib .../*.pic.o
-Wl,--end-lib" while on 26.04 it was calling ar to create .a files
first.

24.04:
action 'Linking src/main/native/libunix_jni.so'
  Mnemonic: CppLink
  Target: //src/main/native:libunix_jni.so
  Configuration: k8-fastbuild
  Execution platform: //:default_host_platform
  ActionKey: d581ae102ab4782b26755373f49cb81a01b48d113e4cb7e31b4e876667acc6=
eb
  Inputs: [bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3.=
pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_avx2_x8=
6-64_unix.pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_avx512_=
x86-64_unix.pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_dispatc=
h.pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_portabl=
e.pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_sse2_x8=
6-64_unix.pic.o,
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_sse41_x=
86-64_unix.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/logging/logging.pic.=
o, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/md5/md5.pic.o, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/port/port.pic.o, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/strings/strings.pic.=
o, \
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/blake3_jni/blake3_jni.=
pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/latin1_jni_path/latin1=
_jni_path.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/process=
.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i_linux.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so-2.params, \
    external/bazel_tools/tools/cpp/build_interface_so, \
    external/bazel_tools/tools/cpp/link_dynamic_library.sh, \
    external/rules_cc~~cc_configure_extension~local_config_cc/builtin_inclu=
de_directory_paths,
\
    external/rules_cc~~cc_configure_extension~local_config_cc/cc_wrapper.sh=
, \
    external/rules_cc~~cc_configure_extension~local_config_cc/deps_scanner_=
wrapper.sh,
\
    external/rules_cc~~cc_configure_extension~local_config_cc/validate_stat=
ic_library.sh]
  Outputs: [bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so]
  Command Line: (exec /usr/bin/gcc \
    -shared \
    -o \
    bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so \
    -Wl,-S \
    '-fuse-ld=3Dgold' \
    -B/usr/bin \
    -Wl,-no-as-needed \
    -Wl,-z,relro,-z,now \
    -pass-exit-codes \
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/process=
.pic.o
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i.pic.o
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i_linux.pic.o
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/blake3_jni/blake3_jni.=
pic.o
\
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3.pic.o \
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_dispatc=
h.pic.o
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_portabl=
e.pic.o
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_avx2_x8=
6-64_unix.pic.o
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_avx512_=
x86-64_unix.pic.o
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_sse2_x8=
6-64_unix.pic.o
\
    bazel-out/k8-fastbuild/bin/external/blake3~/_objs/blake3/blake3_sse41_x=
86-64_unix.pic.o
\
    -Wl,--end-lib \
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/latin1_jni_path/latin1=
_jni_path.pic.o
\
    -Wl,--end-lib \
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/logging/logging.pic.=
o \
    -Wl,--end-lib \
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/strings/strings.pic.=
o \
    -Wl,--end-lib \
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/md5/md5.pic.o \
    -Wl,--end-lib \
    -Wl,--start-lib \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/_objs/port/port.pic.o \
    -Wl,--end-lib \
    -Wl,--push-state,-as-needed \
    -lstdc++ \
    -Wl,--pop-state \
    -Wl,--push-state,-as-needed \
    -lm \
    -Wl,--pop-state)
# Configuration:
7986f41e68c0f8695304d476c9d739fc4489b6ae519d039e958db1eb026d1faa
# Execution platform: //:default_host_platform

26.04:
action 'Linking src/main/native/libunix_jni.so'
  Mnemonic: CppLink
  Target: //src/main/native:libunix_jni.so
  Configuration: k8-fastbuild
  Execution platform: //:default_host_platform
  ActionKey: 7fd7cf007954470fff795125ded88171fc21fb1c446fe65adb18abfa40564c=
e8
  Inputs: [bazel-out/k8-fastbuild/bin/external/blake3~/libblake3.a, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/liblogging.a, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libmd5.a, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libport.a, \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libstrings.a, \
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/process=
.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i_linux.pic.o,
\
    bazel-out/k8-fastbuild/bin/src/main/native/libblake3_jni.lo, \
    bazel-out/k8-fastbuild/bin/src/main/native/liblatin1_jni_path.a, \
    bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so-2.params, \
    external/bazel_tools/tools/cpp/build_interface_so, \
    external/bazel_tools/tools/cpp/link_dynamic_library.sh, \
    external/rules_cc~~cc_configure_extension~local_config_cc/builtin_inclu=
de_directory_paths,
\
    external/rules_cc~~cc_configure_extension~local_config_cc/cc_wrapper.sh=
, \
    external/rules_cc~~cc_configure_extension~local_config_cc/deps_scanner_=
wrapper.sh,
\
    external/rules_cc~~cc_configure_extension~local_config_cc/validate_stat=
ic_library.sh]
  Outputs: [bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so]
  Command Line: (exec /usr/bin/gcc \
    -shared \
    -o \
    bazel-out/k8-fastbuild/bin/src/main/native/libunix_jni.so \
    -Wl,-S \
    -B/usr/bin \
    -Wl,-no-as-needed \
    -Wl,-z,relro,-z,now \
    -pass-exit-codes \
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/process=
.pic.o
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i.pic.o
\
    bazel-out/k8-fastbuild/bin/src/main/native/_objs/libunix_jni.so/unix_jn=
i_linux.pic.o
\
    -Wl,-whole-archive \
    bazel-out/k8-fastbuild/bin/src/main/native/libblake3_jni.lo \
    -Wl,-no-whole-archive \
    bazel-out/k8-fastbuild/bin/external/blake3~/libblake3.a \
    bazel-out/k8-fastbuild/bin/src/main/native/liblatin1_jni_path.a \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/liblogging.a \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libstrings.a \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libmd5.a \
    bazel-out/k8-fastbuild/bin/src/main/cpp/util/libport.a \
    -Wl,--push-state,-as-needed \
    -lstdc++ \
    -Wl,--pop-state \
    -Wl,--push-state,-as-needed \
    -lm \
    -Wl,--pop-state)
# Configuration:
7986f41e68c0f8695304d476c9d739fc4489b6ae519d039e958db1eb026d1faa
# Execution platform: //:default_host_platform

now with intercept script fixes it builds fine with both (and
tensorflow-lite as well). Thank you.

Regards,

