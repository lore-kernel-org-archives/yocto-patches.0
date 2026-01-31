Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB8E7C6E8
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 20:19:30 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16732.1769890763672276602
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 12:19:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fVOFHJ74;
 spf=pass (domain: snapchat.com, ip: 209.85.221.43, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-435903c4040so2159976f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 12:19:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769890761; cv=none;
        d=google.com; s=arc-20240605;
        b=Sy8cAgzSNZbuBDS8wa8v61j7LYaf/hGM0hb9K6yIh/oOPyP2sXuM4H6I0e1tednWtg
         3kL0yrViuyitXepheiu5yRo0ROVxlFtb5vTgZuNAnN7ieug/q+EnU7x+XRHS7HNQOhtq
         fj9JUSDplP5VF5bbn/lJsSVLzmTvYJJW437T4cVcOm6/aolRLFBDVgUrmuODVnQ6Yjqg
         dTVKRO3FtXPL7kfUYzhaNH6KiXCC8PLdMX+xEuMfVstGGwc6TW44QU3x3k3+oTmdSSLK
         lWHKAxl/o8DmOJ8x651AMKTcYdkVyRrJWWZWmHu/6kts9kB4oqzglwfxqcpeTynPsII7
         llyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qlMaRMiwep6f4muT3ZpY7r4fZ1Qqfbat7UFg4L4u8AY=;
        fh=hK1LeuTgB4bRbLKT41uWVXhdrSsml4D7If2/NW6+UAo=;
        b=EwiYkb1arwEARrvtbL19mG8DJvGhXcj+w0XktLJseB9dSPF6Vp8WQPrh6+CoHI5pVJ
         gNY79Ufg9nplxqPWXYiEok7Xp1aiferVyjMXCcYLPFtN8R8QNZkH46q7103jHBlxy5/O
         FhyMbSEvDDuR3TmhyFDdwyWT+iFG/AMAhlUl2QGoEAx+FaIDMbvUDOkETbQTQNp4nnmn
         KirAx0ribDUVpzvpO9yFrOpqNaDIJiwdEAGaQyVeTrnndLe58TbqQmX+S/uxCa0Sp6WC
         oh62NkRzL0KopmiYF9I281JlgxwV4iZPwT9ykgrpf0IPENUN9QNW0cljVE5VHCzdzhqk
         xAvg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769890761; x=1770495561; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qlMaRMiwep6f4muT3ZpY7r4fZ1Qqfbat7UFg4L4u8AY=;
        b=fVOFHJ74Ddup1q3MKPMD/sky4Q40x7AancNqWa7rzxHbdAs8Fo22DVs/jzQy4neH55
         98kv49uz5DSUpzU74bkWMOkycReJupWaiRnJUbWmpKHlw4hSkQWaH0C6tmlC/0jYT0ZI
         nvLsGZpJTyW9AfSeDUJ7JpudNp9CS/TOKeBJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769890761; x=1770495561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlMaRMiwep6f4muT3ZpY7r4fZ1Qqfbat7UFg4L4u8AY=;
        b=Mo/I9USwh4on8uo8Kqz4huqYzsq0tR6tFKCZh4xRfU2bePAO8rWXMblXGvcK6RJeB/
         FAKZTGYyk53N/WZsbVjl8SVTnMg2jGQ5uYpmUu2/a32e26LHWZhwgW3qTt0QLXD7N6C7
         blQ/DxnuqwjDEO/RyPcbkVX79AWb7rFZxr3dhoc33r5pjaTDJp+CizfaBmIhs7jFLcyW
         uoxGS9+HCM9QDWXi+Dqj+ILzGF2MGdhXDf03kjUbwzAOnxV3CkF+35dJ22wRIy1j1PmC
         iqcZd+kIhp1FePpsFUIhycp9xntMqCnRJx32HwQKn2MgPA17gBWn0O3ql08BUiNPzard
         22lg==
X-Gm-Message-State: AOJu0Yy3ext6MrcDhzxGilpgcGACJX4W+LVwo35MdZkOrepqrMGrL5v4
	KGOzYX1LdajYHrTizYep8FScNBPLyO8R9G3HKexi0mLWlX64uz97Sl+Mk7Bd+jtXouISg+8lSNz
	f0Gsq5MAlfFWuZJz4Ay3vuJBW5oOVHNVPIK/psar3m9W5GQJ7KUjxvncPVA==
X-Gm-Gg: AZuq6aLfkLm/d37ymwLGtYGtEMo2tvIhThlRM/EczhgFiSFPJGVNg+nWHqk+7Cyvvk6
	py8CvuUGLVyw6s5+APxIiQ3WV3y0sz0bwvswTTa2ivbOzGjPgZurI1ZrJW0zjJWINp5vNFySgxU
	oT3pJrPcprWe87Bws6/dbA4DLh0pLxftRkKFnwI4hQ4pi0kIkETrT7rJ0bMMTxYGdGLGaWhzR6A
	iXmy/wFsoBfAOJS5ygat7iSauvYrTJhEk2xCqXiYPWL9rt+R1rQtUov7YVUtPdfWlcSwKOP5MVw
	SNgypMChgbiJTxKvRpkGJaFClR0=
X-Received: by 2002:a05:6000:2004:b0:435:b755:c67e with SMTP id
 ffacd0b85a97d-435f3ab5999mr9673355f8f.49.1769890761393; Sat, 31 Jan 2026
 12:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20260128063200.99314-1-dev@qinc.tv>
In-Reply-To: <20260128063200.99314-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sat, 31 Jan 2026 21:19:10 +0100
X-Gm-Features: AZwV_QgdTB6pOR6uAQ0OupbqewRipOUCb83cuGo52LNGyGJDGdXnxjDwA3ob8qE
Message-ID: <CAHUKmYazFb34hVzmxPKrk+oJhBw4v9=Eos=Bio4PxVSuwd=mig@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Add GDB and CLANG
 (conditionally) to the SDK builds
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>, "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="0000000000001fe9ce0649b4ced2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 20:19:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3158

--0000000000001fe9ce0649b4ced2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! Applied as
https://git.yoctoproject.org/meta-darwin/commit/?id=3Dc6cd4d7f83d079bc03419=
872c57269e8bbded95b

On Wed, Jan 28, 2026 at 7:32=E2=80=AFAM Eric L. Hernes via lists.yoctoproje=
ct.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> From: "Eric L. Hernes" <eric@qinc.tv>
>
> GDB and CLANG are not included in the SDK builds on Darwin. This patch
> adds them. GDB is added to the packagegroup files.  I had to disable
> some of the advanced options for gdb to get a compile.
>
> CLANG is added conditionally from the `CLANGSDK=3D1` variable.  This
> also was missing from the *packagegroup* files.
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  .../openssl/openssl_%.bbappend                | 25 +++++++++++++++++++
>  .../nativesdk-packagegroup-sdk-host.bbappend  |  3 +++
>  .../packagegroup-cross-canadian.bbappend      |  5 ++++
>  .../gcc/gcc-cross-canadian_%.bbappend         |  2 +-
>  .../gdb/gdb-cross-canadian_%.bbappend         | 19 ++++++++++++++
>  5 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend
>  create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>
> diff --git a/recipes-connectivity/openssl/openssl_%.bbappend
> b/recipes-connectivity/openssl/openssl_%.bbappend
> new file mode 100644
> index 0000000..3b0674c
> --- /dev/null
> +++ b/recipes-connectivity/openssl/openssl_%.bbappend
> @@ -0,0 +1,25 @@
> +
> +do_configure:darwin21 () {
> +    target=3D"${@'darwin64-arm64-cc' if d.getVar('SDK_ARCH') =3D=3D 'aar=
ch64'
> else 'darwin64-x86_64-cc'}"
> +
> +    useprefix=3D${prefix}
> +    if [ "x$useprefix" =3D "x" ]; then
> +        useprefix=3D/
> +    fi
> +    # WARNING: do not set compiler/linker flags (-I/-D etc.) in
> EXTRA_OECONF, as they will fully replace the
> +    # environment variables set by bitbake. Adjust the environment
> variables instead.
> +    PERLEXTERNAL=3D"$(realpath ${S}/external/perl/Text-Template-*/lib)"
> +    test -d "$PERLEXTERNAL" || bberror "PERLEXTERNAL '$PERLEXTERNAL' not
> found!"
> +    HASHBANGPERL=3D"/usr/bin/env perl" PERL=3Dperl PERL5LIB=3D"$PERLEXTE=
RNAL" \
> +    perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS}
> ${DEPRECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldir=3D${libdir}=
/ssl-3
> --libdir=3D${libdir} $target
> +    perl ${B}/configdata.pm --dump
> +}
> +
> +RDEPENDS:remove:${PN}-misc =3D "perl"
> +RDEPENDS:remove:${PN}-ptest =3D "openssl-bin"
> +RDEPENDS:remove:${PN}-ptest =3D "perl"
> +RDEPENDS:remove:${PN}-ptest =3D "perl-modules"
> +RDEPENDS:remove:${PN}-ptest =3D "bash"
> +RDEPENDS:remove:${PN}-ptest =3D "sed"
> +RDEPENDS:remove:${PN}-ptest =3D "openssl-engines"
> +RDEPENDS:remove:${PN}-ptest =3D "openssl-ossl-module-legacy"
> diff --git
> a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
> b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
> index 170a8c1..d1191e7 100644
> --- a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
> +++ b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
> @@ -4,3 +4,6 @@ RDEPENDS:${PN}:darwin21 =3D "\
>      nativesdk-bison \
>      nativesdk-sdk-provides-dummy \
>      "
> +
> +RDEPENDS:${PN}:darwin21 +=3D "${@bb.utils.contains('CLANGSDK', '1',
> 'nativesdk-clang', '', d)}"
> +
> diff --git
> a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
> b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
> index de29f47..4e46eae 100644
> --- a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
> +++ b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
> @@ -1,9 +1,14 @@
>  # Use indirection to stop these being expanded prematurely
>  BINUTILS =3D "binutils-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>  GCC =3D "gcc-cross-canadian-${TRANSLATED_TARGET_ARCH}"
> +GDB =3D "gdb-cross-canadian-${TRANSLATED_TARGET_ARCH}"
> +CLANG =3D "clang-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>
>  RDEPENDS:${PN}:darwinsdk =3D "\
>      ${@all_multilib_tune_values(d, 'BINUTILS')} \
>      ${@all_multilib_tune_values(d, 'GCC')} \
> +    ${GDB} \
>      meta-environment-${MACHINE} \
>      "
> +
> +RDEPENDS:${PN}:darwinsdk +=3D "${@bb.utils.contains('CLANGSDK', '1',
> '${CLANGCROSSCANADIANDEPS}', '', d)}"
> diff --git a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
> b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
> index 192ee0d..5a4b8f9 100644
> --- a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
> +++ b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
> @@ -3,7 +3,7 @@ ELFUTILS:darwinsdk =3D ""
>
>  EXTRA_OECONF:append:darwinsdk =3D " \
>      --with-gmp=3D${STAGING_EXECPREFIXDIR} \
> -    --with-mpft=3D${STAGING_EXECPREFIXDIR} \
> +    --with-mpfr=3D${STAGING_EXECPREFIXDIR} \
>      --with-mpc=3D${STAGING_EXECPREFIXDIR} \
>  "
>
> diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> new file mode 100644
> index 0000000..3f69019
> --- /dev/null
> +++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> @@ -0,0 +1,19 @@
> +PACKAGECONFIG:remove =3D "python"
> +PACKAGECONFIG:remove =3D "debuginfod"
> +
> +EXTRA_OECONF:append:darwinsdk =3D " \
> +    --with-gmp=3D${STAGING_EXECPREFIXDIR} \
> +    --with-mpfr=3D${STAGING_EXECPREFIXDIR} \
> +    --with-mpc=3D${STAGING_EXECPREFIXDIR} \
> +"
> +
> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-gas"
> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-binutils"
> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-ld"
> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-gold"
> +EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readline"
> +
> +# Remove -rpath-link and -rpath
> +LDFLAGS:darwinsdk =3D "${BUILDSDK_LDFLAGS}"
> +
> +INSANE_SKIP:append:darwin21 =3D " buildpaths"
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3124):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3124&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFp2=
eoTk4Zck92dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&s=3Dhj8tOSn4d=
9fQ908oAmpEbnRkgmin_r0W0NVabMqJSgc&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117366396_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFp2eoTk4Zck92=
dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&s=3DxeJ1pU9u9JWzdF43Uku=
TGVRK_mS6RIG-x0s5uXn6Wy4&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DFp2eoTk4Zck92dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2hZ8Dj=
EEFQys_fZni3S&s=3Drx3_LvbCd61-o8p9w2FT181MqA-v-vky8JEbc8kjyW0&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000001fe9ce0649b4ced2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! Applied as=C2=A0<a href=
=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3Dc6cd4d7f83d079bc0=
3419872c57269e8bbded95b">https://git.yoctoproject.org/meta-darwin/commit/?i=
d=3Dc6cd4d7f83d079bc03419872c57269e8bbded95b</a></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Jan 28, 2026 at 7:32=E2=80=AFAM Eric L. Hernes via <a href=3D"http://lis=
ts.yoctoproject.org">lists.yoctoproject.org</a> &lt;dev=3D<a href=3D"mailto=
:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yoctoproject.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: &quot;=
Eric L. Hernes&quot; &lt;<a href=3D"mailto:eric@qinc.tv" target=3D"_blank">=
eric@qinc.tv</a>&gt;<br>
<br>
GDB and CLANG are not included in the SDK builds on Darwin. This patch<br>
adds them. GDB is added to the packagegroup files.=C2=A0 I had to disable<b=
r>
some of the advanced options for gdb to get a compile.<br>
<br>
CLANG is added conditionally from the `CLANGSDK=3D1` variable.=C2=A0 This<b=
r>
also was missing from the *packagegroup* files.<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0.../openssl/openssl_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 25 +++++++++++++++++++<br>
=C2=A0.../nativesdk-packagegroup-sdk-host.bbappend=C2=A0 |=C2=A0 3 +++<br>
=C2=A0.../packagegroup-cross-canadian.bbappend=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
5 ++++<br>
=C2=A0.../gcc/gcc-cross-canadian_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
=C2=A0.../gdb/gdb-cross-canadian_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 19 ++++++++++++++<br>
=C2=A05 files changed, 53 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend<br=
>
=C2=A0create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend=
<br>
<br>
diff --git a/recipes-connectivity/openssl/openssl_%.bbappend b/recipes-conn=
ectivity/openssl/openssl_%.bbappend<br>
new file mode 100644<br>
index 0000000..3b0674c<br>
--- /dev/null<br>
+++ b/recipes-connectivity/openssl/openssl_%.bbappend<br>
@@ -0,0 +1,25 @@<br>
+<br>
+do_configure:darwin21 () {<br>
+=C2=A0 =C2=A0 target=3D&quot;${@&#39;darwin64-arm64-cc&#39; if d.getVar(&#=
39;SDK_ARCH&#39;) =3D=3D &#39;aarch64&#39; else &#39;darwin64-x86_64-cc&#39=
;}&quot;<br>
+<br>
+=C2=A0 =C2=A0 useprefix=3D${prefix}<br>
+=C2=A0 =C2=A0 if [ &quot;x$useprefix&quot; =3D &quot;x&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 useprefix=3D/<br>
+=C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 # WARNING: do not set compiler/linker flags (-I/-D etc.) in =
EXTRA_OECONF, as they will fully replace the<br>
+=C2=A0 =C2=A0 # environment variables set by bitbake. Adjust the environme=
nt variables instead.<br>
+=C2=A0 =C2=A0 PERLEXTERNAL=3D&quot;$(realpath ${S}/external/perl/Text-Temp=
late-*/lib)&quot;<br>
+=C2=A0 =C2=A0 test -d &quot;$PERLEXTERNAL&quot; || bberror &quot;PERLEXTER=
NAL &#39;$PERLEXTERNAL&#39; not found!&quot;<br>
+=C2=A0 =C2=A0 HASHBANGPERL=3D&quot;/usr/bin/env perl&quot; PERL=3Dperl PER=
L5LIB=3D&quot;$PERLEXTERNAL&quot; \<br>
+=C2=A0 =C2=A0 perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS=
} ${DEPRECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldir=3D${libdir}=
/ssl-3 --libdir=3D${libdir} $target<br>
+=C2=A0 =C2=A0 perl ${B}/<a href=3D"http://configdata.pm" rel=3D"noreferrer=
" target=3D"_blank">configdata.pm</a> --dump<br>
+}<br>
+<br>
+RDEPENDS:remove:${PN}-misc =3D &quot;perl&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;openssl-bin&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;perl&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;perl-modules&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;bash&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;sed&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;openssl-engines&quot;<br>
+RDEPENDS:remove:${PN}-ptest =3D &quot;openssl-ossl-module-legacy&quot;<br>
diff --git a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bba=
ppend b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend=
<br>
index 170a8c1..d1191e7 100644<br>
--- a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend<b=
r>
+++ b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend<b=
r>
@@ -4,3 +4,6 @@ RDEPENDS:${PN}:darwin21 =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0nativesdk-bison \<br>
=C2=A0 =C2=A0 =C2=A0nativesdk-sdk-provides-dummy \<br>
=C2=A0 =C2=A0 =C2=A0&quot;<br>
+<br>
+RDEPENDS:${PN}:darwin21 +=3D &quot;${@bb.utils.contains(&#39;CLANGSDK&#39;=
, &#39;1&#39;, &#39;nativesdk-clang&#39;, &#39;&#39;, d)}&quot;<br>
+<br>
diff --git a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappen=
d b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend<br>
index de29f47..4e46eae 100644<br>
--- a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend<br>
+++ b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend<br>
@@ -1,9 +1,14 @@<br>
=C2=A0# Use indirection to stop these being expanded prematurely<br>
=C2=A0BINUTILS =3D &quot;binutils-cross-canadian-${TRANSLATED_TARGET_ARCH}&=
quot;<br>
=C2=A0GCC =3D &quot;gcc-cross-canadian-${TRANSLATED_TARGET_ARCH}&quot;<br>
+GDB =3D &quot;gdb-cross-canadian-${TRANSLATED_TARGET_ARCH}&quot;<br>
+CLANG =3D &quot;clang-cross-canadian-${TRANSLATED_TARGET_ARCH}&quot;<br>
<br>
=C2=A0RDEPENDS:${PN}:darwinsdk =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0${@all_multilib_tune_values(d, &#39;BINUTILS&#39;)} \<b=
r>
=C2=A0 =C2=A0 =C2=A0${@all_multilib_tune_values(d, &#39;GCC&#39;)} \<br>
+=C2=A0 =C2=A0 ${GDB} \<br>
=C2=A0 =C2=A0 =C2=A0meta-environment-${MACHINE} \<br>
=C2=A0 =C2=A0 =C2=A0&quot;<br>
+<br>
+RDEPENDS:${PN}:darwinsdk +=3D &quot;${@bb.utils.contains(&#39;CLANGSDK&#39=
;, &#39;1&#39;, &#39;${CLANGCROSSCANADIANDEPS}&#39;, &#39;&#39;, d)}&quot;<=
br>
diff --git a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend b/recipes-d=
evtools/gcc/gcc-cross-canadian_%.bbappend<br>
index 192ee0d..5a4b8f9 100644<br>
--- a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend<br>
+++ b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend<br>
@@ -3,7 +3,7 @@ ELFUTILS:darwinsdk =3D &quot;&quot;<br>
<br>
=C2=A0EXTRA_OECONF:append:darwinsdk =3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0--with-gmp=3D${STAGING_EXECPREFIXDIR} \<br>
-=C2=A0 =C2=A0 --with-mpft=3D${STAGING_EXECPREFIXDIR} \<br>
+=C2=A0 =C2=A0 --with-mpfr=3D${STAGING_EXECPREFIXDIR} \<br>
=C2=A0 =C2=A0 =C2=A0--with-mpc=3D${STAGING_EXECPREFIXDIR} \<br>
=C2=A0&quot;<br>
<br>
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes-d=
evtools/gdb/gdb-cross-canadian_%.bbappend<br>
new file mode 100644<br>
index 0000000..3f69019<br>
--- /dev/null<br>
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
@@ -0,0 +1,19 @@<br>
+PACKAGECONFIG:remove =3D &quot;python&quot;<br>
+PACKAGECONFIG:remove =3D &quot;debuginfod&quot;<br>
+<br>
+EXTRA_OECONF:append:darwinsdk =3D &quot; \<br>
+=C2=A0 =C2=A0 --with-gmp=3D${STAGING_EXECPREFIXDIR} \<br>
+=C2=A0 =C2=A0 --with-mpfr=3D${STAGING_EXECPREFIXDIR} \<br>
+=C2=A0 =C2=A0 --with-mpc=3D${STAGING_EXECPREFIXDIR} \<br>
+&quot;<br>
+<br>
+EXTRA_OECONF:remove:darwinsdk =3D &quot;--disable-gas&quot;<br>
+EXTRA_OECONF:remove:darwinsdk =3D &quot;--disable-binutils&quot;<br>
+EXTRA_OECONF:remove:darwinsdk =3D &quot;--disable-ld&quot;<br>
+EXTRA_OECONF:remove:darwinsdk =3D &quot;--disable-gold&quot;<br>
+EXTRA_OECONF:remove:darwinsdk =3D &quot;--with-system-readline&quot;<br>
+<br>
+# Remove -rpath-link and -rpath<br>
+LDFLAGS:darwinsdk =3D &quot;${BUILDSDK_LDFLAGS}&quot;<br>
+<br>
+INSANE_SKIP:append:darwin21 =3D &quot; buildpaths&quot;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3124): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3124&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFp2eoTk4Zck92dmwd9nMaE-SHR=
vw9vw8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&amp;s=3Dhj8tOSn4d9fQ908oAmpEbnRkgmin=
_r0W0NVabMqJSgc&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3124&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DF=
p2eoTk4Zck92dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&amp;s=3Dhj8=
tOSn4d9fQ908oAmpEbnRkgmin_r0W0NVabMqJSgc&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117366396_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DFp2eoTk4Zck92dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2=
hZ8DjEEFQys_fZni3S&amp;s=3DxeJ1pU9u9JWzdF43UkuTGVRK_mS6RIG-x0s5uXn6Wy4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117366396_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFp2eoTk4Zck92dmwd9nMaE-SHRvw9vw=
8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&amp;s=3DxeJ1pU9u9JWzdF43UkuTGVRK_mS6RIG-x=
0s5uXn6Wy4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFp2eoTk4Zck92=
dmwd9nMaE-SHRvw9vw8S8ErdK_olZxHo2hZ8DjEEFQys_fZni3S&amp;s=3Drx3_LvbCd61-o8p=
9w2FT181MqA-v-vky8JEbc8kjyW0&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFp2eoTk4Zck92dmwd9nMaE-SHRvw9vw8S8Er=
dK_olZxHo2hZ8DjEEFQys_fZni3S&amp;s=3Drx3_LvbCd61-o8p9w2FT181MqA-v-vky8JEbc8=
kjyW0&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000001fe9ce0649b4ced2--

