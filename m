Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24BD72369
	for <webhook@archiver.kernel.org>; Sat, 24 Jan 2026 23:52:28 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30223.1769298741475767049
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Jan 2026 15:52:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=TvCc4xMJ;
 spf=pass (domain: snapchat.com, ip: 209.85.221.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3160886f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 15:52:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769298739; cv=none;
        d=google.com; s=arc-20240605;
        b=NM77Iu5+WcqQPytq6fAP4PT3snnqvjfPJCy9aYEKdFh4zkzf6PCTTjE5EIyCBWIFlf
         aoABEL0xA+ABe5iNqG+3vluHRkfE5lyRz+IJ+7kiMS/OXbvPoEX3DqlERQYfWZNsUtAC
         cE9GcO1d+EeTz5OlJifhU+sUocl0go4fU9bqSkb+wZgu3yl0HNpI+gN2n4l66+C+ZuJa
         4/XDzJh9QndgLDQzskzPi+7ogkkawCV151y5KiCm/nz5xrnwVoyK+tOq0+kutvxHWKlM
         PX6OWi6/hulidwY42fol7GL5CAV13OWavmuqGWLZz53ua/87OFsInBL5lOzGten9k0FN
         WKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vGZacQOtDgFAG24oFwr9+s/ETi6ZchaL+FFtrh7l19g=;
        fh=WYPXitkITvu5Cy82D7TmXctEruuopl2Z5dY5LsP+Ht0=;
        b=OiUkGhMmNeGWhlQu4PeCCDWYsXZ0xNunuH19wUSFJugaORaoJjtne2sb68L69ypTie
         tmFWibrRHciePu/r2Zkq1Ha/KWxm+Djx49uwAuHscSbqDHs8WCbNT0VLCFsfPQtpbm9J
         /qwt0iFuPVXf9wThZ5HuiJ//ogJ3f6vBk/tKTpB9XXUTk3FylI9SnOs4tt4a6g4jmOjd
         m2ZONDwP+Uz/rLUWDKOJ/YSpQkzGFmbcUnRB+1jo6XsgftV2jnZyTNd6jyh6BbflMKiZ
         xKx8J5+w9CyYp+f5iMZk7edU1wK/2VuwVP5LrVb4pEr/pH3O4hpNnGPDDZaVzMQy88eH
         Enzw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769298739; x=1769903539; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vGZacQOtDgFAG24oFwr9+s/ETi6ZchaL+FFtrh7l19g=;
        b=TvCc4xMJ7oQkBrQVW3w7HVAddhIIii8AXVMDN09RxuXrDcGKlss61h3NIvtRfFlFmS
         JvNPNC5cgiclyCOq5dG/P5YizJXC3/rdkt0s4Z4/4sAxKN6IM9SGkgLhLOpEnw1GGO68
         1smM6mCF2IvpHcqvXpHxKUe58137fHeOD+BJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769298739; x=1769903539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGZacQOtDgFAG24oFwr9+s/ETi6ZchaL+FFtrh7l19g=;
        b=TQtteHNo+jZ10cq2CQ0J2mkI4cL78FqokoABBIDpSSjSMV2a/p5mRKl/b5eUBuScKS
         Z2Na/YnyMo/bgc4OrFerfuO1jjCnBXbo5629EPvs6gHi6iSRX35KEjv8FL/tPXkWWTuU
         qz3DSJmHBErHGyg9T+9CdSiXtgmAB0U0QGsM5OsHNt0AJGuxlLnU968BgoaSEcI3Bwaw
         FdnMT0znuGgteE0fJRCvp1obCmSLORc8+5niuNRoCSW9ardu/ABl3OKm5f5ngepzRlFR
         iyNGazyFV20b0lZdkHGjdds9Rg+EqdxKTcIqtiG2NLjH60e6QsKfQELA+aSP42s/Wu4+
         h+/g==
X-Gm-Message-State: AOJu0YyoXGnUxgwiZFVgcKWKgr+BNwEzv0+eORawI/N82FdJdFbXFXcX
	AOVIjQ7TGmwhIhZptdeakZOOpCq6vdBFDD/88fz+yRsBqX4A97f1n9WPAhwWf96NOs2eAFxcIay
	E6+9JgLs2+50mq84CjmGL9UPBkCSM93mUDYgwvr3YEU1Wq5Q41LD5LcoAyQ==
X-Gm-Gg: AZuq6aLsgMBL+Z+pcxbD1BX14bugERaWbZvKCu3GJDK9l+M8dZtcVATYPC+K7Ba8k6f
	yG1uUn0MBVZCS4y9EYuxx+jISjVaP+fFWpO+sJ1sjW+7VIrV1KJj4bws3M05nPFhh9nopbwjL1A
	hc+vmnqpF3e1BthMnX2ve9huHhQFthRicfo7p8u5ADr1CcqLyMtKEHROHu5txt3+W+ajB7LJ6Et
	0XvxtHm24H0SMIZSa4eFsCI4BPV/9u/OW3yTMJOYCtJbBVEPtW4IisUlsiRis5Mxk7uy6gh5PLJ
	brKuwGqe1lyq70kI0XM+YgLByXin7vt3LzmVxA==
X-Received: by 2002:a05:6000:2389:b0:430:f59d:4dfc with SMTP id
 ffacd0b85a97d-435ca0e2b4amr177072f8f.9.1769298738931; Sat, 24 Jan 2026
 15:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20260120170459.95161-1-dev@qinc.tv>
In-Reply-To: <20260120170459.95161-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sun, 25 Jan 2026 00:52:07 +0100
X-Gm-Features: AZwV_QhvOslulnl7dX-1VjqC0WUAfsmMxO2_0KrlQFtTfq_ph-YSpla0a7rbZxY
Message-ID: <CAHUKmYaGtmW80g5c+Rky4N5f854JnsoC+us83Ut=BZAYtKmPWw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Add GDB and CLANG
 (conditionally) to the SDK builds
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>
Content-Type: multipart/alternative; boundary="000000000000d615c706492af604"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 23:52:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3073

--000000000000d615c706492af604
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

thanks for the patch!

I've not tested the patch functionally yet. Just some minor comments at the
moment:
- the indentation at 7 spaces is non-standard and needs to be fixed
- we can't hard-code target to arm as long as we've not dropped x86 support
completely:
instead of target=3Ddarwin64-arm64-cc, something like:

target=3D"${@'darwin64-arm64-cc' if d.getVar('SDK_ARCH') =3D=3D 'aarch64' e=
lse
'darwin64-x86_64-cc'}"

- there is a typo: with-mpft -> with-mpfr

=C3=89tienne

On Tue, Jan 20, 2026 at 6:05=E2=80=AFPM Eric L. Hernes via lists.yoctoproje=
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
> commit f68c74645010c413601ed4766f702c93e8b111f7
> Author: Eric L. Hernes <ehernes@portrait.com>
> Date:   Mon Jan 19 11:45:13 2026 -0600
>
>     patches to enable CLANGSDK and gdb on darwinsdk builds
>
> commit da00745de4531722df9b955892c5835a7c26c03f
> Author: Eric L. Hernes <ehernes@portrait.com>
> Signed-off-by: Eric L. Hernes <eric@qinc.tv>
> Date:   Mon Jan 19 09:54:57 2026 -0600
>
>     additional patch for gcc to build on arm64 build for arm64 host
> ---
>  .../openssl/openssl_%.bbappend                | 25 +++++++++++++++++++
>  .../nativesdk-packagegroup-sdk-host.bbappend  |  3 +++
>  .../packagegroup-cross-canadian.bbappend      |  5 ++++
>  .../gdb/gdb-cross-canadian_%.bbappend         | 19 ++++++++++++++
>  4 files changed, 52 insertions(+)
>  create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend
>  create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>
> diff --git a/recipes-connectivity/openssl/openssl_%.bbappend
> b/recipes-connectivity/openssl/openssl_%.bbappend
> new file mode 100644
> index 0000000..befbc64
> --- /dev/null
> +++ b/recipes-connectivity/openssl/openssl_%.bbappend
> @@ -0,0 +1,25 @@
> +
> +do_configure:darwin21 () {
> +       target=3Ddarwin64-arm64-cc
> +
> +       useprefix=3D${prefix}
> +       if [ "x$useprefix" =3D "x" ]; then
> +               useprefix=3D/
> +       fi
> +       # WARNING: do not set compiler/linker flags (-I/-D etc.) in
> EXTRA_OECONF, as they will fully replace the
> +       # environment variables set by bitbake. Adjust the environment
> variables instead.
> +       PERLEXTERNAL=3D"$(realpath ${S}/external/perl/Text-Template-*/lib=
)"
> +       test -d "$PERLEXTERNAL" || bberror "PERLEXTERNAL '$PERLEXTERNAL'
> not found!"
> +       HASHBANGPERL=3D"/usr/bin/env perl" PERL=3Dperl
> PERL5LIB=3D"$PERLEXTERNAL" \
> +       perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS}
> ${DEPRECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldir=3D${libdir}=
/ssl-3
> --libdir=3D${libdir} $target
> +       perl ${B}/configdata.pm --dump
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
> diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> new file mode 100644
> index 0000000..99dac80
> --- /dev/null
> +++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> @@ -0,0 +1,19 @@
> +PACKAGECONFIG:remove =3D "python"
> +PACKAGECONFIG:remove =3D "debuginfod"
> +
> +EXTRA_OECONF:append:darwinsdk =3D " \
> +    --with-gmp=3D${STAGING_EXECPREFIXDIR} \
> +    --with-mpft=3D${STAGING_EXECPREFIXDIR} \
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
> View/Reply Online (#3035):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3035&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D_pu=
erYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&s=3DWdCUPuQH4=
_kgB_zPSlmoiDVolXxnGlpUrnZ4bgKGHpo&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117366396_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D_puerYIDUBoaG=
uNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&s=3DO62qmjJUsxyOm39Z8uQ=
9q7zP0xxII0nRnkugFlqlffM&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3D_puerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7Q=
vUgvq1B0KPzK2&s=3DQESP0Hyg0GP6AoZbq9EY5fTX390b8qALUz8LqGOdbOI&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000d615c706492af604
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br><br>thanks for the patch!<br><br>I&#39;ve not =
tested the patch functionally yet. Just some minor comments at the moment:<=
br>- the indentation at 7 spaces is non-standard and needs to be fixed<br>-=
 we can&#39;t hard-code target to arm as long as we&#39;ve not dropped x86 =
support completely:<br>instead of target=3Ddarwin64-arm64-cc, something lik=
e:<br><br>target=3D&quot;${@&#39;darwin64-arm64-cc&#39; if d.getVar(&#39;SD=
K_ARCH&#39;) =3D=3D &#39;aarch64&#39; else &#39;darwin64-x86_64-cc&#39;}&qu=
ot;<br><br>- there is a typo: with-mpft -&gt; with-mpfr<br><br>=C3=89tienne=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Jan 20, 2026 at 6:05=E2=80=AFPM Eric L. Herne=
s via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> =
&lt;dev=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.y=
octoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">From: &quot;Eric L. Hernes&quot; &lt;<a href=3D"mailto:eric@=
qinc.tv" target=3D"_blank">eric@qinc.tv</a>&gt;<br>
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
commit f68c74645010c413601ed4766f702c93e8b111f7<br>
Author: Eric L. Hernes &lt;<a href=3D"mailto:ehernes@portrait.com" target=
=3D"_blank">ehernes@portrait.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Mon Jan 19 11:45:13 2026 -0600<br>
<br>
=C2=A0 =C2=A0 patches to enable CLANGSDK and gdb on darwinsdk builds<br>
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
=C2=A0.../openssl/openssl_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 25 +++++++++++++++++++<br>
=C2=A0.../nativesdk-packagegroup-sdk-host.bbappend=C2=A0 |=C2=A0 3 +++<br>
=C2=A0.../packagegroup-cross-canadian.bbappend=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
5 ++++<br>
=C2=A0.../gdb/gdb-cross-canadian_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 19 ++++++++++++++<br>
=C2=A04 files changed, 52 insertions(+)<br>
=C2=A0create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend<br=
>
=C2=A0create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend=
<br>
<br>
diff --git a/recipes-connectivity/openssl/openssl_%.bbappend b/recipes-conn=
ectivity/openssl/openssl_%.bbappend<br>
new file mode 100644<br>
index 0000000..befbc64<br>
--- /dev/null<br>
+++ b/recipes-connectivity/openssl/openssl_%.bbappend<br>
@@ -0,0 +1,25 @@<br>
+<br>
+do_configure:darwin21 () {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0target=3Ddarwin64-arm64-cc<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0useprefix=3D${prefix}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;x$useprefix&quot; =3D &quot;x&quot; =
]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0useprefix=3D/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# WARNING: do not set compiler/linker flags (-I=
/-D etc.) in EXTRA_OECONF, as they will fully replace the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# environment variables set by bitbake. Adjust =
the environment variables instead.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PERLEXTERNAL=3D&quot;$(realpath ${S}/external/p=
erl/Text-Template-*/lib)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test -d &quot;$PERLEXTERNAL&quot; || bberror &q=
uot;PERLEXTERNAL &#39;$PERLEXTERNAL&#39; not found!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0HASHBANGPERL=3D&quot;/usr/bin/env perl&quot; PE=
RL=3Dperl PERL5LIB=3D&quot;$PERLEXTERNAL&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECO=
NFIG_CONFARGS} ${DEPRECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldi=
r=3D${libdir}/ssl-3 --libdir=3D${libdir} $target<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0perl ${B}/<a href=3D"http://configdata.pm" rel=
=3D"noreferrer" target=3D"_blank">configdata.pm</a> --dump<br>
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
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes-d=
evtools/gdb/gdb-cross-canadian_%.bbappend<br>
new file mode 100644<br>
index 0000000..99dac80<br>
--- /dev/null<br>
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
@@ -0,0 +1,19 @@<br>
+PACKAGECONFIG:remove =3D &quot;python&quot;<br>
+PACKAGECONFIG:remove =3D &quot;debuginfod&quot;<br>
+<br>
+EXTRA_OECONF:append:darwinsdk =3D &quot; \<br>
+=C2=A0 =C2=A0 --with-gmp=3D${STAGING_EXECPREFIXDIR} \<br>
+=C2=A0 =C2=A0 --with-mpft=3D${STAGING_EXECPREFIXDIR} \<br>
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
View/Reply Online (#3035): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3035&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D_puerYIDUBoaGuNtBlJG7tTaRD=
6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&amp;s=3DWdCUPuQH4_kgB_zPSlmoiDVolXxn=
GlpUrnZ4bgKGHpo&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3035&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D_=
puerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&amp;s=3DWdC=
UPuQH4_kgB_zPSlmoiDVolXxnGlpUrnZ4bgKGHpo&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117366396_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D_puerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsY=
syc7QvUgvq1B0KPzK2&amp;s=3DO62qmjJUsxyOm39Z8uQ9q7zP0xxII0nRnkugFlqlffM&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117366396_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D_puerYIDUBoaGuNtBlJG7tTaRD6u0Cm=
RwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&amp;s=3DO62qmjJUsxyOm39Z8uQ9q7zP0xxII0nRn=
kugFlqlffM&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D_puerYIDUBoaG=
uNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&amp;s=3DQESP0Hyg0GP6AoZ=
bq9EY5fTX390b8qALUz8LqGOdbOI&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D_puerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKd=
BXOgrQdKsYsyc7QvUgvq1B0KPzK2&amp;s=3DQESP0Hyg0GP6AoZbq9EY5fTX390b8qALUz8LqG=
OdbOI&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000d615c706492af604--

