Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0DE7C6E6
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 20:15:00 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16652.1769890497895177699
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 12:14:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=WUngz5qo;
 spf=pass (domain: snapchat.com, ip: 209.85.221.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d2c96215so3055099f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 12:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769890496; cv=none;
        d=google.com; s=arc-20240605;
        b=A58Sin48qQ1jopLKfmRkEnArDcUc25l4w6W81GrmF65EjUoLJPsOdj8HyNILU19rq6
         6+J3NzERXbvGGLwh2En7lbj2VTD/8oruK5bbnj73dZ/bqEWZXyUnbybZ1XwvK8binItn
         Fw59tASu0RBRyg3kN2g7rhH+09448r9PMd2gSrlO/usBVuUeW8yeUpJZay4AB7sPjW3J
         +ApD2mdKwhp5p4XPJT6ZdDE1TVpqCXeqHWQYzIOCYrEKcW1LeHMV90CommCgxDEeBHJh
         ZgIg/Z7Uv5w9ZAo6q8bXs2q8lt71g5ATSXw9/WTGQjTvAQQCbjkWEKtBdlfXQe0Q2iKj
         caaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m9nAowXLHcQpQqX+9n6AH+sDpb3PkpFiDjY4gXDcWcY=;
        fh=hK1LeuTgB4bRbLKT41uWVXhdrSsml4D7If2/NW6+UAo=;
        b=T12Q2Q5rjkEVhKEZvji4RCvoWkqsCxDrKbACVXqPQuGoiKwuEB2LeIJvcQse44ygGg
         wYO4WGkyRiHcZ7/0pNuOcpXGs0QlQDs2t0ciIOZA1xSfJbYjnMjCNzR0Gn56fQnw/P8F
         Xu39YQV6xrwzw/AMnTC8Q/FzwJVGWWIPf/clhlEYxY9OztOK8yl5ILy3M7vWmw1LpMAm
         mTKe9d1wXsFhnaOV2oU17YxLeyUaPCz0T03arpeUCXWOeWQIO5TdguW9YggKs4ZHT50+
         XAcyhgaAfPRjjyIg1ug0md/BY44/DMrT10RuG3Trsdi3xpLRRkcSgqgSxoiJNZctsn9C
         LLRw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769890496; x=1770495296; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m9nAowXLHcQpQqX+9n6AH+sDpb3PkpFiDjY4gXDcWcY=;
        b=WUngz5qo+gFpkAUzgDBDEK5JhAt0usMXYNveAF59/4QuZAL/Iscf3SEAGoIimerRpA
         Q2xQS4XI7e/H1fQZ0Szy6T3LTV0acTObf4b8bcLSIxcq+LH4mgQCYdJe476DzuOUbXZt
         fwePAzkW+f6W5RupABZgpvEHcBMmMBpz1oIQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769890496; x=1770495296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9nAowXLHcQpQqX+9n6AH+sDpb3PkpFiDjY4gXDcWcY=;
        b=lfDwgLIic7M+aASOdYFkTWp7AxmTdIr5/3ugx6ji/nTlYFahMeBElMYxTPx3KkhLV5
         QvUIas1u7w6tRKs7adWFRqLU1Dm1O8dz8zGeE0WSkF+SuYkyNzVQ6wuvQhWTVRy9DhAj
         lEl60WysZGiSTOrp1z58qp1jl9gofXT4R5juPu7E2WoPo6LSa5Mgt2dlv3sm2KWZ/JlH
         HdAFQDr6NCY36Ks2RZyluscGWkTJATFe4I0ecAl2oV5gwkbQ6W5RXM87GrrNqtftx+ew
         ei1ozhw2jhcS7t0nW1s7TaNumFMfyXNwAqxiLkvq8l8ew8XzMcvekBvKo7KQow+80Dis
         xf6g==
X-Gm-Message-State: AOJu0Yy/ooIr/0X0LPv0HrigIxeiRderm/osz9fs+0OVDVxPCFhrxSf6
	vIJSoMMkDTfkONbaDEfMFsspugXxXwXpbUJdlivfI2teZ9hA1LLB3HRFXtJPj7xfD9exKeNWjtY
	SMPRReLfkNQRLqDviBwjPgADDuEnYrbjqT9qqeMGfJeKxbA2+vY7/w+9Cww==
X-Gm-Gg: AZuq6aLkblQKx4wZK9veCO4k2NH8Z9LrGXV5b/HOGnf3V4dlu0WFoBvmtWSkzgO0RST
	6z0hLE+OdBPcDDRgwH53lFEaL7JmFw2wIsl5NXe2qz3Acszufsk7lhsSKegcDQ0zq9kpZsnUi+t
	0TjUw5qeo9Yg6/FEK9JMIXEHd/51ccXG8e4ZRiUZAJahbvQFXhOoOgpKDtTAT6iWf3DP2urYQIE
	FydFcZngeCYnNaxWdII84XCjuxe3MEeP7cs0aenoNNDvYlTnaQqGeconlTlAzIvzeRz67tHRSek
	JJh+xdzC6sC1fmuN8zSurvQeJV8=
X-Received: by 2002:adf:fa02:0:b0:436:348:9a7f with SMTP id
 ffacd0b85a97d-43603489b39mr395588f8f.28.1769890495382; Sat, 31 Jan 2026
 12:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20260128062928.97927-1-dev@qinc.tv>
In-Reply-To: <20260128062928.97927-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sat, 31 Jan 2026 21:14:44 +0100
X-Gm-Features: AZwV_Qh3Fkm3caN3BbDJY74iNQomsdeGwYszZK0ZziZKRToKionPjKdzQhej4P8
Message-ID: <CAHUKmYYnuSdK66WUi_rwaZwD2MV8z0C=28uGKOe_gSavRZXViQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Patch GCC for aarch64 macOS
 host build on aarch64 linux host
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>, "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="00000000000044fd960649b4be3e"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 20:15:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3156

--00000000000044fd960649b4be3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! I have merged it upstream as
https://git.yoctoproject.org/meta-darwin/commit/?id=3D2ddb2d2c52e9b0cdc6bdf=
57b001aa6eef23f6fef
. I have only removed those lines from the commit message. I've assumed
they were not intentional:

```
commit da00745de4531722df9b955892c5835a7c26c03f
Author: Eric L. Hernes <dev@qinc.tv>
Date:   Mon Jan 19 09:54:57 2026 -0600

    additional patch for gcc to build on arm64 build for arm64 host
```

=C3=89tienne

On Wed, Jan 28, 2026 at 7:30=E2=80=AFAM Eric L. Hernes via lists.yoctoproje=
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
> Author: Eric L. Hernes <dev@qinc.tv>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> Date:   Mon Jan 19 09:54:57 2026 -0600
>
>     additional patch for gcc to build on arm64 build for arm64 host
> ---
>  .../gcc/files/0102-aarch64-on-aarch64.patch   | 32 +++++++++++++++++++
>  recipes-devtools/gcc/gcc-source_%.bbappend    |  4 +++
>  2 files changed, 36 insertions(+)
>  create mode 100644
> recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
>
> diff --git a/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> new file mode 100644
> index 0000000..f6da25f
> --- /dev/null
> +++ b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
> @@ -0,0 +1,32 @@
> +Upstream-Status: Inappropriate [OE specific]
> +Signed-off-by: Eric L. Hernes <dev@qinc.tv>
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
> View/Reply Online (#3123):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3123&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dluq=
jbFFHyORi_5ZXAun64M_bUjePIK0pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&s=3DB9EwMJhHf=
Wbxd5CfimNqcVqVlMdKO6IdmDcz1QOMSmk&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117503969_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DluqjbFFHyORi_=
5ZXAun64M_bUjePIK0pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&s=3DrXld_pMTINIRmwre1iv=
3SeyKSMhlveSrQsKbsz8tJMg&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DluqjbFFHyORi_5ZXAun64M_bUjePIK0pc0LC21NZneN6pB1fP8O=
vQ8plT2YcOs9m&s=3Dj-zD9JWZuWc_CdtEVoRIA6oYkFUlqyij8BOeJTRTa_Q&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000044fd960649b4be3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! I have merged it upstrea=
m as <a href=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3D2ddb2=
d2c52e9b0cdc6bdf57b001aa6eef23f6fef">https://git.yoctoproject.org/meta-darw=
in/commit/?id=3D2ddb2d2c52e9b0cdc6bdf57b001aa6eef23f6fef</a> . I have only =
removed those lines from the commit message. I&#39;ve assumed they were not=
 intentional:<br><br>```<br>commit da00745de4531722df9b955892c5835a7c26c03f=
<br>Author: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv">dev@qinc.tv</=
a>&gt;<br>Date: =C2=A0 Mon Jan 19 09:54:57 2026 -0600<br><br>=C2=A0 =C2=A0 =
additional patch for gcc to build on arm64 build for arm64 host<br>```<br><=
br>=C3=89tienne</div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28, 2026 at 7:30=E2=80=AFA=
M Eric L. Hernes via <a href=3D"http://lists.yoctoproject.org">lists.yoctop=
roject.org</a> &lt;dev=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org">=
qinc.tv@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: &quot;Eric L. Hernes&quot; &lt;<a href=
=3D"mailto:eric@qinc.tv" target=3D"_blank">eric@qinc.tv</a>&gt;<br>
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
Author: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"_blank"=
>dev@qinc.tv</a>&gt;<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
Date:=C2=A0 =C2=A0Mon Jan 19 09:54:57 2026 -0600<br>
<br>
=C2=A0 =C2=A0 additional patch for gcc to build on arm64 build for arm64 ho=
st<br>
---<br>
=C2=A0.../gcc/files/0102-aarch64-on-aarch64.patch=C2=A0 =C2=A0| 32 ++++++++=
+++++++++++<br>
=C2=A0recipes-devtools/gcc/gcc-source_%.bbappend=C2=A0 =C2=A0 |=C2=A0 4 +++=
<br>
=C2=A02 files changed, 36 insertions(+)<br>
=C2=A0create mode 100644 recipes-devtools/gcc/files/0102-aarch64-on-aarch64=
.patch<br>
<br>
diff --git a/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch b/rec=
ipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch<br>
new file mode 100644<br>
index 0000000..f6da25f<br>
--- /dev/null<br>
+++ b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch<br>
@@ -0,0 +1,32 @@<br>
+Upstream-Status: Inappropriate [OE specific]<br>
+Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D=
"_blank">dev@qinc.tv</a>&gt;<br>
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
View/Reply Online (#3123): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3123&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DluqjbFFHyORi_5ZXAun64M_bUj=
ePIK0pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&amp;s=3DB9EwMJhHfWbxd5CfimNqcVqVlMdK=
O6IdmDcz1QOMSmk&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3123&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dl=
uqjbFFHyORi_5ZXAun64M_bUjePIK0pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&amp;s=3DB9E=
wMJhHfWbxd5CfimNqcVqVlMdKO6IdmDcz1QOMSmk&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117503969_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DluqjbFFHyORi_5ZXAun64M_bUjePIK0pc0LC21NZneN6pB=
1fP8OvQ8plT2YcOs9m&amp;s=3DrXld_pMTINIRmwre1iv3SeyKSMhlveSrQsKbsz8tJMg&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117503969_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DluqjbFFHyORi_5ZXAun64M_bUjePIK0=
pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&amp;s=3DrXld_pMTINIRmwre1iv3SeyKSMhlveSrQ=
sKbsz8tJMg&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DluqjbFFHyORi_=
5ZXAun64M_bUjePIK0pc0LC21NZneN6pB1fP8OvQ8plT2YcOs9m&amp;s=3Dj-zD9JWZuWc_Cdt=
EVoRIA6oYkFUlqyij8BOeJTRTa_Q&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DluqjbFFHyORi_5ZXAun64M_bUjePIK0pc0LC=
21NZneN6pB1fP8OvQ8plT2YcOs9m&amp;s=3Dj-zD9JWZuWc_CdtEVoRIA6oYkFUlqyij8BOeJT=
RTa_Q&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--00000000000044fd960649b4be3e--

