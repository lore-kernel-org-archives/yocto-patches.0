Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC0D715F8
	for <webhook@archiver.kernel.org>; Sun, 25 Jan 2026 00:04:08 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30349.1769299439027556367
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Jan 2026 16:03:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=GKSukzb7;
 spf=pass (domain: snapchat.com, ip: 209.85.221.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359249bbacso2843342f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 16:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769299437; cv=none;
        d=google.com; s=arc-20240605;
        b=bA4EPhNecEaNo8H5rEnuOSqEi+LD2hYx1USyADqCSFCEcjg7/Q72IDMDeEOS3y2udR
         sgMRFtlC/PlrHgA76h7M9LMnvHDozp/nodU3xzBeJBA6H8pzwGZLRcTVt/wGKzexyasr
         od5iODG1jJXlQGArH8WC7wmMmOmz22D7UZggVKTeP30BYLXkbUXgkTt7u7tkZaBWxwWv
         ajgy5ot4bKdWZey3wH2VZhlVVbskoxeE1sJ1u2IWZokel4DwIyJ86yfORAlzhQ3G8WvM
         CiVPTJYNNJXA9lgT76IDNWewuuIr1iMeCSX/t6TX2DomrqEvf9m9I4XUVwX3nNf3M+g0
         1Xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UP0VZDCIUdtlQZKIfNHkyDl1B1TVnW1/eZP5ZCpx/vo=;
        fh=WYPXitkITvu5Cy82D7TmXctEruuopl2Z5dY5LsP+Ht0=;
        b=i3spCtHJL30z9/nHSQrGrWrnTXrvj6CcjgG0rd5UA6v+hfDvVVlujdY00/EUOVng8X
         3PE+Cm4mIxAy+yhGhg9EvGBtPSHSjY5abbGlYHpbktuX9PRUT00iqsGgGri9NjU3Sbq0
         NEErp0KObIh1pYe86+1eVE4Rw9s40FOfFtomCMunjAv2mn6Ocv8HZ8S9r1GAOyFOR4rw
         CkEPaClLlRjBduFuYUlXlMl7slLmWYuFXd8nNjPvlm8ypg73fgYgnyfBoTBZcKfroQBI
         5WFgHn990PA78sLuoGPa1fMjQHwpzkR1zedIzaBQmf6idtlnzWmqVcOS4fTD0Yl4XDfs
         bhFA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769299437; x=1769904237; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UP0VZDCIUdtlQZKIfNHkyDl1B1TVnW1/eZP5ZCpx/vo=;
        b=GKSukzb7Qe3xrjbdn9kQE+4fNDmpmUYud9vi7mJrL32tFdfHKzYKgi2J41v+atM0d4
         86Lu0+eqhdeTZuUOMh71bsjG2W9mRHvO/Q72dNwfSVIZGHRuod6yG4mSwvtYPdFfA8e/
         VcOPa4ibHBxKhaaexheiP0MRDl5P2NBp39vSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769299437; x=1769904237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP0VZDCIUdtlQZKIfNHkyDl1B1TVnW1/eZP5ZCpx/vo=;
        b=U5PT/lr7annlnTQg4Am7u9KjyMfh966VSDs1a75oGdGqvYvbgl1hnfdj9xoesmetCu
         pWdm5/6AahxbOvnk8A9RHsX0tX+MbMYIJPGW9NaDSb+3UcePYBkPXSUYr3qXHpYkfLvM
         dyYHqaaLB6iyqVtyh+STo4aU8no1abmuELCkw2JKOkKyz3+8Mi7VzHwK4A9y0ONwJqK4
         aB4ocbFRejlrWJSqDTFSf3ZnFH14wJ7TM9eCgrZ61YSOQxvMdKJA/Xa5P5CpokNqwtGB
         TS16BVtCA3jNeDpYK0qZGLAaGdPs/QQOYZw8bTvJEZOHoX8mKNIFHmotV+f88Zq8bE8E
         zXuQ==
X-Gm-Message-State: AOJu0Yw7MuKmgjvz7Ki/MXSmNq9u5nLEqUpCCGC0v1h7IrTDvZ/3+3KC
	1cqbi3Is9JvEqF8OP6gmuYldoEqDh61i8dG2l+s60K/VU5dtTSFD2sK8mtse4YRJwmw/uxuGupd
	xyLf3V/lEQHW540+52zNKl5VhUF2yhPqgOEOgJz3WflwLkLYDWqB02rA=
X-Gm-Gg: AZuq6aLaVA3i+qF3P+qHB2ZqPMgp0YyoHVSq5jBZusnzcVrqzEyu3yLNv7dQbrj5z7F
	5npWgyU+miBMoFq1UUfYiYZlOuqincVufrpZ0l97auyOJ4qfL3lnDJ5t64kV8Asj2fDCM3ju8vx
	EtD7fDzejzMVHl9dg4cjcTzotcPT4S+iChvudbZ5SsISgb2sS66BAtWNFkzn5eeM2HNJvvOfmsC
	SeOcQmgpYbcuxTpMbCKq5iVkLTuToWA3DCJ7NY18ZhSoF3gtDnjkIrktWL5RBXxZ6eKoOAbl54e
	O0Txw9GkbYDt9Y5R/YIA1k/nzBU=
X-Received: by 2002:a05:6000:2389:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-435c9a8f9d6mr474370f8f.2.1769299436701; Sat, 24 Jan 2026
 16:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20260120170246.94746-1-dev@qinc.tv>
In-Reply-To: <20260120170246.94746-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sun, 25 Jan 2026 01:03:45 +0100
X-Gm-Features: AZwV_Qh3CJI5foSy-XdtbBR6QSVLTBHb25TkfhvPrXIiTudmJBKu30uzJq4U8Gk
Message-ID: <CAHUKmYaTWriiL3A1R4BgxCHU0tiyu+3Xyw_F-XeqTOW2DS+F8Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Patch GCC for aarch64 macOS
 host build on aarch64 linux host
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>
Content-Type: multipart/alternative; boundary="0000000000006d2de406492b20a2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 25 Jan 2026 00:04:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3074

--0000000000006d2de406492b20a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the patch! Can you please add an upstream-status to the
file 0102-aarch64-on-aarch64.patch (
https://docs.yoctoproject.org/scarthgap/contributor-guide/recipe-style-guid=
e.html
 ). The QA_ERROR patch-status is enabled per default on recent yocto
releases and we'll need it on all patches for updating meta-darwin to the
next version.

=C3=89tienne


On Tue, Jan 20, 2026 at 6:03=E2=80=AFPM Eric L. Hernes via lists.yoctoproje=
ct.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> From: "Eric L. Hernes" <eric@qinc.tv>
>
> The configure script and aarch64.h get a bit confused when building
> the darwin cross canadian.  `driver-aarch64.c` gets added which has
> more build problems and isn't needed on the cross build.  The
> `aarch64.h` file looks for `sysctl/..h` headers when targeting MACHO
> binaries , which also do not exist on the linux build machine.
>
> There should be a CPP macro for "linux_build_host" or
> similar to use for the system dependent includes and config.  Since we
> don't have this, we use (!defined(darwin_macosx_version_min)), which
> seems to be "darwin builds only".  It's a bit of a hack, but should be
> ok for this deep corner case.
>
> Without this patch, cross builds targeting macOS/arm64 on a Linux
> Intel machine work; but linux arm64 does not.  This is maybe a more
> common situation. With Apple Intel machines out of production for 5+
> years now, Docker on Apple Silicon should be much more common, and
> getting more so.
>
> It is possible to configure an Intel Docker image on Apple Silicon
> with Rosetta 2, but the builds with native arm64 are significantly
> faster.
>
> commit da00745de4531722df9b955892c5835a7c26c03f
> Author: Eric L. Hernes <ehernes@portrait.com>
> Signed-off-by: Eric L. Hernes <eric@qinc.tv>
> Date:   Mon Jan 19 09:54:57 2026 -0600
>
>     additional patch for gcc to build on arm64 build for arm64 host
> ---
>  .../gcc/files/0102-aarch64-on-aarch64.patch   | 30 +++++++++++++++++++
>  recipes-devtools/gcc/gcc-source_%.bbappend    |  4 +++
>  2 files changed, 34 insertions(+)
>  create mode 100644
> recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
>
> diff --git a/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> new file mode 100644
> index 0000000..fd7ef2c
> --- /dev/null
> +++ b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> @@ -0,0 +1,30 @@
> +--- gcc-13.4.0/gcc/config.host~        2026-01-08 23:01:47.056268010 +00=
00
> ++++ gcc-13.4.0/gcc/config.host 2026-01-08 23:10:07.958588006 +0000
> +@@ -102,6 +102,9 @@
> +   aarch64*-*-freebsd* | aarch64*-*-linux* | aarch64*-*-fuchsia* |\
> +   aarch64*-*-darwin*)
> +     case ${target} in
> ++      *-oesdk-*)
> ++      # don't add driver-aarch64.o for oesdk cross builds
> ++      ;;
> +       aarch64*-*-*)
> +       host_extra_gcc_objs=3D"driver-aarch64.o"
> +       host_xmake_file=3D"${host_xmake_file} aarch64/x-aarch64"
> +--- gcc-13.4.0/gcc/config/aarch64/aarch64.h~   2026-01-08
> 23:01:46.859268010 +0000
> ++++ gcc-13.4.0/gcc/config/aarch64/aarch64.h    2026-01-08
> 23:08:14.417236009 +0000
> +@@ -1223,7 +1223,14 @@
> +
> + /* Extra specs when building a native AArch64-hosted compiler.
> +    Option rewriting rules based on host system.  */
> +-#if defined(__aarch64__)
> ++
> ++//
> ++// XXX-ELH: we don't do this for crosssdk builds,
> ++// so how do we know that? For now we just pick a symbol that is define=
d
> in the build
> ++//
> ++// g++ -fno-PIE -dM -E  .....  -MT gcc.o -MMD -MP -MF ./.deps/gcc.TPo
> ../../../../../../../work-shared/gcc-13.4.0-r0/gcc-13.4.0/gcc/gcc.cc
> ++//
> ++#if defined(__aarch64__) && !defined(darwin_macosx_version_min)
> + extern const char *host_detect_local_cpu (int argc, const char **argv);
> + #define HAVE_LOCAL_CPU_DETECT
> + # define EXTRA_SPEC_FUNCTIONS                                          =
 \
> diff --git a/recipes-devtools/gcc/gcc-source_%.bbappend
> b/recipes-devtools/gcc/gcc-source_%.bbappend
> index 73b4843..d1089e5 100644
> --- a/recipes-devtools/gcc/gcc-source_%.bbappend
> +++ b/recipes-devtools/gcc/gcc-source_%.bbappend
> @@ -9,3 +9,7 @@ SRC_URI:append =3D " \
>  SRC_URI:append =3D " \
>      file://0101-aarch64-Darwin-support-gcc-13-darwin.patch \
>  "
> +# Patch to allow building aarch64 toolchain for mac on aarch64 linux
> +SRC_URI:append =3D " \
> +    file://0102-aarch64-on-aarch64.patch \
> +"
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3034):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3034&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dv_c=
XEb90NejE92y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&s=3DnvE2CScun=
7jrUsSqv8R5GZrhQ85vrrkjT_Hx9pvZh9M&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117366348_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dv_cXEb90NejE9=
2y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&s=3DtfNwfVQqI75MWPFBK9k=
j_nq8wkP4FfSZWqKzzKG5ko4&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3Dv_cXEb90NejE92y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCoe7w_W=
AVPnpNOERnMcH&s=3D2PQ6gTEChT_YXwK8n3kAvN8UEKKPgXf-WnlinWMlkUE&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000006d2de406492b20a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br><br>Thanks for the patch! Can you please add a=
n upstream-status to the file=C2=A00102-aarch64-on-aarch64.patch (=C2=A0<a =
href=3D"https://docs.yoctoproject.org/scarthgap/contributor-guide/recipe-st=
yle-guide.html" target=3D"_blank">https://docs.yoctoproject.org/scarthgap/c=
ontributor-guide/recipe-style-guide.html</a> =C2=A0). The QA_ERROR patch-st=
atus is enabled per default on recent yocto releases and we&#39;ll need=C2=
=A0it on all patches for updating meta-darwin to the next version.<br><br>=
=C3=89tienne<br><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Jan 20, 2026 at 6:03=E2=80=AFPM Eric L. Hernes =
via <a href=3D"http://lists.yoctoproject.org" target=3D"_blank">lists.yocto=
project.org</a> &lt;dev=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org"=
 target=3D"_blank">qinc.tv@lists.yoctoproject.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">From: &quot;Eric L. Hernes=
&quot; &lt;<a href=3D"mailto:eric@qinc.tv" target=3D"_blank">eric@qinc.tv</=
a>&gt;<br>
<br>
The configure script and aarch64.h get a bit confused when building<br>
the darwin cross canadian.=C2=A0 `driver-aarch64.c` gets added which has<br=
>
more build problems and isn&#39;t needed on the cross build.=C2=A0 The<br>
`aarch64.h` file looks for `sysctl/..h` headers when targeting MACHO<br>
binaries , which also do not exist on the linux build machine.<br>
<br>
There should be a CPP macro for &quot;linux_build_host&quot; or<br>
similar to use for the system dependent includes and config.=C2=A0 Since we=
<br>
don&#39;t have this, we use (!defined(darwin_macosx_version_min)), which<br=
>
seems to be &quot;darwin builds only&quot;.=C2=A0 It&#39;s a bit of a hack,=
 but should be<br>
ok for this deep corner case.<br>
<br>
Without this patch, cross builds targeting macOS/arm64 on a Linux<br>
Intel machine work; but linux arm64 does not.=C2=A0 This is maybe a more<br=
>
common situation. With Apple Intel machines out of production for 5+<br>
years now, Docker on Apple Silicon should be much more common, and<br>
getting more so.<br>
<br>
It is possible to configure an Intel Docker image on Apple Silicon<br>
with Rosetta 2, but the builds with native arm64 are significantly<br>
faster.<br>
<br>
commit da00745de4531722df9b955892c5835a7c26c03f<br>
Author: Eric L. Hernes &lt;<a href=3D"mailto:ehernes@portrait.com" target=
=3D"_blank">ehernes@portrait.com</a>&gt;<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:eric@qinc.tv" target=3D=
"_blank">eric@qinc.tv</a>&gt;<br>
Date:=C2=A0 =C2=A0Mon Jan 19 09:54:57 2026 -0600<br>
<br>
=C2=A0 =C2=A0 additional patch for gcc to build on arm64 build for arm64 ho=
st<br>
---<br>
=C2=A0.../gcc/files/0102-aarch64-on-aarch64.patch=C2=A0 =C2=A0| 30 ++++++++=
+++++++++++<br>
=C2=A0recipes-devtools/gcc/gcc-source_%.bbappend=C2=A0 =C2=A0 |=C2=A0 4 +++=
<br>
=C2=A02 files changed, 34 insertions(+)<br>
=C2=A0create mode 100644 recipes-devtools/gcc/files/0102-aarch64-on-aarch64=
.patch<br>
<br>
diff --git a/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch b/rec=
ipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch<br>
new file mode 100644<br>
index 0000000..fd7ef2c<br>
--- /dev/null<br>
+++ b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch<br>
@@ -0,0 +1,30 @@<br>
+--- gcc-13.4.0/gcc/config.host~=C2=A0 =C2=A0 =C2=A0 =C2=A0 2026-01-08 23:0=
1:47.056268010 +0000<br>
++++ gcc-13.4.0/gcc/config.host 2026-01-08 23:10:07.958588006 +0000<br>
+@@ -102,6 +102,9 @@<br>
+=C2=A0 =C2=A0aarch64*-*-freebsd* | aarch64*-*-linux* | aarch64*-*-fuchsia*=
 |\<br>
+=C2=A0 =C2=A0aarch64*-*-darwin*)<br>
+=C2=A0 =C2=A0 =C2=A0case ${target} in<br>
++=C2=A0 =C2=A0 =C2=A0 *-oesdk-*)<br>
++=C2=A0 =C2=A0 =C2=A0 # don&#39;t add driver-aarch64.o for oesdk cross bui=
lds<br>
++=C2=A0 =C2=A0 =C2=A0 ;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0aarch64*-*-*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0host_extra_gcc_objs=3D&quot;driver-aarch64.o&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0host_xmake_file=3D&quot;${host_xmake_file} aarc=
h64/x-aarch64&quot;<br>
+--- gcc-13.4.0/gcc/config/aarch64/aarch64.h~=C2=A0 =C2=A02026-01-08 23:01:=
46.859268010 +0000<br>
++++ gcc-13.4.0/gcc/config/aarch64/aarch64.h=C2=A0 =C2=A0 2026-01-08 23:08:=
14.417236009 +0000<br>
+@@ -1223,7 +1223,14 @@<br>
+ <br>
+ /* Extra specs when building a native AArch64-hosted compiler.<br>
+=C2=A0 =C2=A0 Option rewriting rules based on host system.=C2=A0 */<br>
+-#if defined(__aarch64__)<br>
++<br>
++//<br>
++// XXX-ELH: we don&#39;t do this for crosssdk builds,<br>
++// so how do we know that? For now we just pick a symbol that is defined =
in the build<br>
++//<br>
++// g++ -fno-PIE -dM -E=C2=A0 .....=C2=A0 -MT gcc.o -MMD -MP -MF ./.deps/g=
cc.TPo ../../../../../../../work-shared/gcc-13.4.0-r0/gcc-13.4.0/gcc/gcc.cc=
<br>
++//<br>
++#if defined(__aarch64__) &amp;&amp; !defined(darwin_macosx_version_min)<b=
r>
+ extern const char *host_detect_local_cpu (int argc, const char **argv);<b=
r>
+ #define HAVE_LOCAL_CPU_DETECT<br>
+ # define EXTRA_SPEC_FUNCTIONS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
diff --git a/recipes-devtools/gcc/gcc-source_%.bbappend b/recipes-devtools/=
gcc/gcc-source_%.bbappend<br>
index 73b4843..d1089e5 100644<br>
--- a/recipes-devtools/gcc/gcc-source_%.bbappend<br>
+++ b/recipes-devtools/gcc/gcc-source_%.bbappend<br>
@@ -9,3 +9,7 @@ SRC_URI:append =3D &quot; \<br>
=C2=A0SRC_URI:append =3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0file://0101-aarch64-Darwin-support-gcc-13-darwin.patch =
\<br>
=C2=A0&quot;<br>
+# Patch to allow building aarch64 toolchain for mac on aarch64 linux<br>
+SRC_URI:append =3D &quot; \<br>
+=C2=A0 =C2=A0 file://0102-aarch64-on-aarch64.patch \<br>
+&quot;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3034): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3034&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dv_cXEb90NejE92y4oHgGGaxyjM=
e0vXc0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&amp;s=3DnvE2CScun7jrUsSqv8R5GZrhQ85v=
rrkjT_Hx9pvZh9M&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3034&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dv=
_cXEb90NejE92y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&amp;s=3DnvE=
2CScun7jrUsSqv8R5GZrhQ85vrrkjT_Hx9pvZh9M&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117366348_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3Dv_cXEb90NejE92y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCo=
e7w_WAVPnpNOERnMcH&amp;s=3DtfNwfVQqI75MWPFBK9kj_nq8wkP4FfSZWqKzzKG5ko4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117366348_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dv_cXEb90NejE92y4oHgGGaxyjMe0vXc=
0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&amp;s=3DtfNwfVQqI75MWPFBK9kj_nq8wkP4FfSZW=
qKzzKG5ko4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dv_cXEb90NejE9=
2y4oHgGGaxyjMe0vXc0NQVyod-CBBjQCoe7w_WAVPnpNOERnMcH&amp;s=3D2PQ6gTEChT_YXwK=
8n3kAvN8UEKKPgXf-WnlinWMlkUE&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dv_cXEb90NejE92y4oHgGGaxyjMe0vXc0NQVy=
od-CBBjQCoe7w_WAVPnpNOERnMcH&amp;s=3D2PQ6gTEChT_YXwK8n3kAvN8UEKKPgXf-WnlinW=
MlkUE&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000006d2de406492b20a2--

