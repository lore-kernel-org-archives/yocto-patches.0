Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0DCF65CF
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 10:07:55 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16486.1769422062233528028
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 02:07:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=cy/xOSYP;
 spf=pass (domain: snapchat.com, ip: 209.85.221.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3045281f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 02:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422060; cv=none;
        d=google.com; s=arc-20240605;
        b=fZGuLpF3zFREUfmkbiLFkAUsB0aLDJnK+buesl8NoeZNGBff5d1AdYMAYaYyEyoPXV
         b4KCClYTSdnii1bGC3+28k0n/M8eRRy/E9K5AmP4kynmyaQ01z41AV3Rwrg1rc9FbWlx
         ZK8Pf0d0TqsHPQtfo02vV7HVJIazrjR0h9opWKsVCoSJxtyYE6y8x60rh1E9Nvq5Ni8a
         sPgUp++ClIrGUF3Hto7er2qNgVUSJ/RDO+apJfJHYVEcjXwuCMDM1T2jatxaQQ+NotWU
         9DY2vDoy+EbgiDpYeCJ04Km5DNHm34TKXaxlBOU7ZcEjL9VRmr99AV3zUwEQbX2uw0KB
         C1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LtaP1qflAFMMSDKnMCjrw97NDMStBOI+fY3ZeoZ1S1I=;
        fh=WQAYL5Tt6bCDGsPQ2J2E/q0HAuT09zuz8dHI6y63uQ4=;
        b=jhCokikzICPtwxUn3L/7E2y5ID/HYUUcuO68ZCb27v3WmK0D14L0bmm5/8Jm9nshv7
         YqyCGCX5MW4IkEP0cQ3icUeg8RQnzJrBotCBhAcM9V2mviGw6IcosZvgZ9t9XVDJUARr
         zXZDDyHrfg7NYh/iBFzgxG16EfG51RkA+QvQLOLQkYrMtjanlYPAdjVW4XHdG3hpS+ba
         EGVgqPXLUCp3SrwECQbIDAadcUKVNlPFU7aT4Bdm4xoFyzfSXApUqKoQtVOWxK6+LhJd
         nNpx7AZpVEzMpu9i/+NvuYuzANmp7T0R4MSM0ALurg8fIwLLpICMluyuqBFwFXYmMfH1
         qHbw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769422060; x=1770026860; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtaP1qflAFMMSDKnMCjrw97NDMStBOI+fY3ZeoZ1S1I=;
        b=cy/xOSYP52k0ter9bskePp8WBa6TawJ/0MnrSwfMcW3YqFV0RjcmpKuDnar97P4AWo
         5OQycF6VPXIOgQW3xIJu+KsFp+p4q7NGFrNKvt3HYmY9feYJuZMZ0kjSbfmp7pNAOM71
         C5lCnwT3WhL1Icc8afhqc9xA+51HDX7CLPkI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422060; x=1770026860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtaP1qflAFMMSDKnMCjrw97NDMStBOI+fY3ZeoZ1S1I=;
        b=DezbQy/bHjrBJq1sZqeec/F39ektr9uLwbHGCfYE8rcUVOIBLwKn6lDZbMlE8816kw
         JrUwBtWENVaP6XFGbxip3/+Drtqu4P1hCNU2AgkPJEPRZLyXJaBCPwWYDbcRVktbSx3X
         PeEvgvBAFSV1Rf1lL/HCpUt7fjmh+RQYADTQnGDyVZztxcsP9YUOT2PgvyZuIL14UQaD
         YOqLV0UagK+fmSaIHLzgmk5HN/y4EH/+/afpW3XKkz10d3QLFhQRQdzKiR48OGGHQkQD
         ZPdb1rmqxfbGlnx5Mkd4XN/I0w8xTfsOUQhz00PFYy2mqdaRwlrr7qKGkzMcFJZaAbxh
         4nvQ==
X-Gm-Message-State: AOJu0YwhAWkBddOQiHY3ikQWUq2oiP2sCJFbCxT5VpJItjXPy8u7Zad+
	5KvYdbwBdhv/JaP0sBjohTwhwVubCOQwBTYknqmxDONR+lqEbHvw6+o0BPPuEslSzMqBQyxxxCB
	3V6V0nHDIa/Dtl2t+Ag6pyXAgrkVopQbrNtjjUL8A6D5euQvkjo09pQQ=
X-Gm-Gg: AZuq6aJeOP4ZshE26RkXRCB6bYnW6hnuVwdQim0jcr9kZG/OHRoEYaKBJuPtmls4wuI
	cicKHjXaYFkX6uTJNk290ZKR89ZbAYBsgeb4RUSDPZGHrZYICKsOZwJ6bbqFJtrDuxdfjFE7YbJ
	vsBAgWrtztkXpfkGJeIr/SxVwF3IpNv4S39bhsqRuHi6sfL4khSrIjQ2OHAAQeu2A85H05pjjiz
	7m0JaLkxyYODHYFZicf+hqyRJbrm6/yGalEXMiAxeHfeShFlSbcmQhHv3SP1aOyGvZqfmLt6ln4
	0xh1jh+hSfFEVdGJoClsGTRos3OQ
X-Received: by 2002:a05:6000:609:b0:42b:38b1:e32e with SMTP id
 ffacd0b85a97d-435ca138f41mr5897036f8f.46.1769422060292; Mon, 26 Jan 2026
 02:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20260120170459.95161-1-dev@qinc.tv> <CAHUKmYaGtmW80g5c+Rky4N5f854JnsoC+us83Ut=BZAYtKmPWw@mail.gmail.com>
 <B6B154A6-74C3-4376-9E92-C4172686521E@qinc.tv>
In-Reply-To: <B6B154A6-74C3-4376-9E92-C4172686521E@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 26 Jan 2026 11:07:29 +0100
X-Gm-Features: AZwV_QhVzKab6T0n2tgWC59FCfAfyDjxBZ2aDvsRZZvo3ifAuX-6AvsNg1HzZBw
Message-ID: <CAHUKmYY+uX-uX=DC-nZqiY4mzp32Vr9eQtyAeWjM5t3t-GR+5w@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Add GDB and CLANG
 (conditionally) to the SDK builds
To: "Eric L. Hernes" <eric@qinc.tv>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005cb7a1064947adb4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 10:07:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3079

--0000000000005cb7a1064947adb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
the standard indentation for do_configure in meta-darwin is 4 spaces.

=C3=89tienne

On Sun, Jan 25, 2026 at 4:32=E2=80=AFAM Eric L. Hernes <eric@qinc.tv> wrote=
:

> Thanks Etienne,
>
> What is the correct indentation?  I guess I didn=E2=80=99t look closely e=
nough at
> it.
>
> The target is an oversight on my part, I=E2=80=99ll fix that.
>
> The =E2=80=98with-mpft=E2=80=99 was taken straight from the
>  `gcc-cross-canadian_%.bbappend` patch, the same issue is in there too.  =
I
> will fix both.
>
> -Eric
>
> --
> *Eric L. Hernes*
> eric@qinc.tv
>
>
>
>
> On Jan 24, 2026, at 5:52=E2=80=AFPM, Etienne Cordonnier <ecordonnier@snap=
.com>
> wrote:
>
> Hi Eric,
>
> thanks for the patch!
>
> I've not tested the patch functionally yet. Just some minor comments at
> the moment:
> - the indentation at 7 spaces is non-standard and needs to be fixed
> - we can't hard-code target to arm as long as we've not dropped x86
> support completely:
> instead of target=3Ddarwin64-arm64-cc, something like:
>
> target=3D"${@'darwin64-arm64-cc' if d.getVar('SDK_ARCH') =3D=3D 'aarch64'=
 else
> 'darwin64-x86_64-cc'}"
>
> - there is a typo: with-mpft -> with-mpfr
>
> =C3=89tienne
>
> On Tue, Jan 20, 2026 at 6:05=E2=80=AFPM Eric L. Hernes via lists.yoctopro=
ject.org
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.yoctoproject=
.org_&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNo=
nVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DXLO-Np5YiioP293c95Xb2TUy2gAvp5dtJ=
arkO4C_GMR3TOydU2KqTlxiw951hLMh&s=3D1_yFvWP69V-fa7kvBgHNpED7vZ_s-EAkvXSOTGG=
68AE&e=3D>
> <dev=3Dqinc.tv@lists.yoctoproject.org> wrote:
>
>> From: "Eric L. Hernes" <eric@qinc.tv>
>>
>> GDB and CLANG are not included in the SDK builds on Darwin. This patch
>> adds them. GDB is added to the packagegroup files.  I had to disable
>> some of the advanced options for gdb to get a compile.
>>
>> CLANG is added conditionally from the `CLANGSDK=3D1` variable.  This
>> also was missing from the *packagegroup* files.
>>
>> commit f68c74645010c413601ed4766f702c93e8b111f7
>> Author: Eric L. Hernes <ehernes@portrait.com>
>> Date:   Mon Jan 19 11:45:13 2026 -0600
>>
>>     patches to enable CLANGSDK and gdb on darwinsdk builds
>>
>> commit da00745de4531722df9b955892c5835a7c26c03f
>> Author: Eric L. Hernes <ehernes@portrait.com>
>> Signed-off-by: Eric L. Hernes <eric@qinc.tv>
>> Date:   Mon Jan 19 09:54:57 2026 -0600
>>
>>     additional patch for gcc to build on arm64 build for arm64 host
>> ---
>>  .../openssl/openssl_%.bbappend                | 25 +++++++++++++++++++
>>  .../nativesdk-packagegroup-sdk-host.bbappend  |  3 +++
>>  .../packagegroup-cross-canadian.bbappend      |  5 ++++
>>  .../gdb/gdb-cross-canadian_%.bbappend         | 19 ++++++++++++++
>>  4 files changed, 52 insertions(+)
>>  create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend
>>  create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>>
>> diff --git a/recipes-connectivity/openssl/openssl_%.bbappend
>> b/recipes-connectivity/openssl/openssl_%.bbappend
>> new file mode 100644
>> index 0000000..befbc64
>> --- /dev/null
>> +++ b/recipes-connectivity/openssl/openssl_%.bbappend
>> @@ -0,0 +1,25 @@
>> +
>> +do_configure:darwin21 () {
>> +       target=3Ddarwin64-arm64-cc
>> +
>> +       useprefix=3D${prefix}
>> +       if [ "x$useprefix" =3D "x" ]; then
>> +               useprefix=3D/
>> +       fi
>> +       # WARNING: do not set compiler/linker flags (-I/-D etc.) in
>> EXTRA_OECONF, as they will fully replace the
>> +       # environment variables set by bitbake. Adjust the environment
>> variables instead.
>> +       PERLEXTERNAL=3D"$(realpath ${S}/external/perl/Text-Template-*/li=
b)"
>> +       test -d "$PERLEXTERNAL" || bberror "PERLEXTERNAL '$PERLEXTERNAL'
>> not found!"
>> +       HASHBANGPERL=3D"/usr/bin/env perl" PERL=3Dperl
>> PERL5LIB=3D"$PERLEXTERNAL" \
>> +       perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS}
>> ${DEPRECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldir=3D${libdir=
}/ssl-3
>> --libdir=3D${libdir} $target
>> +       perl ${B}/configdata.pm
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__configdata.pm_&d=
=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DXLO-Np5YiioP293c95Xb2TUy2gAvp5dtJarkO4C_=
GMR3TOydU2KqTlxiw951hLMh&s=3Dad416kaw8EIshyMQROSeqHw-cWwGKidsfdI9bydLZrc&e=
=3D>
>> --dump
>> +}
>> +
>> +RDEPENDS:remove:${PN}-misc =3D "perl"
>> +RDEPENDS:remove:${PN}-ptest =3D "openssl-bin"
>> +RDEPENDS:remove:${PN}-ptest =3D "perl"
>> +RDEPENDS:remove:${PN}-ptest =3D "perl-modules"
>> +RDEPENDS:remove:${PN}-ptest =3D "bash"
>> +RDEPENDS:remove:${PN}-ptest =3D "sed"
>> +RDEPENDS:remove:${PN}-ptest =3D "openssl-engines"
>> +RDEPENDS:remove:${PN}-ptest =3D "openssl-ossl-module-legacy"
>> diff --git
>> a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
>> b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
>> index 170a8c1..d1191e7 100644
>> --- a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappen=
d
>> +++ b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappen=
d
>> @@ -4,3 +4,6 @@ RDEPENDS:${PN}:darwin21 =3D "\
>>      nativesdk-bison \
>>      nativesdk-sdk-provides-dummy \
>>      "
>> +
>> +RDEPENDS:${PN}:darwin21 +=3D "${@bb.utils.contains('CLANGSDK', '1',
>> 'nativesdk-clang', '', d)}"
>> +
>> diff --git
>> a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
>> b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
>> index de29f47..4e46eae 100644
>> --- a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
>> +++ b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
>> @@ -1,9 +1,14 @@
>>  # Use indirection to stop these being expanded prematurely
>>  BINUTILS =3D "binutils-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>>  GCC =3D "gcc-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>> +GDB =3D "gdb-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>> +CLANG =3D "clang-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>>
>>  RDEPENDS:${PN}:darwinsdk =3D "\
>>      ${@all_multilib_tune_values(d, 'BINUTILS')} \
>>      ${@all_multilib_tune_values(d, 'GCC')} \
>> +    ${GDB} \
>>      meta-environment-${MACHINE} \
>>      "
>> +
>> +RDEPENDS:${PN}:darwinsdk +=3D "${@bb.utils.contains('CLANGSDK', '1',
>> '${CLANGCROSSCANADIANDEPS}', '', d)}"
>> diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>> b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>> new file mode 100644
>> index 0000000..99dac80
>> --- /dev/null
>> +++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
>> @@ -0,0 +1,19 @@
>> +PACKAGECONFIG:remove =3D "python"
>> +PACKAGECONFIG:remove =3D "debuginfod"
>> +
>> +EXTRA_OECONF:append:darwinsdk =3D " \
>> +    --with-gmp=3D${STAGING_EXECPREFIXDIR} \
>> +    --with-mpft=3D${STAGING_EXECPREFIXDIR} \
>> +    --with-mpc=3D${STAGING_EXECPREFIXDIR} \
>> +"
>> +
>> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-gas"
>> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-binutils"
>> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-ld"
>> +EXTRA_OECONF:remove:darwinsdk =3D "--disable-gold"
>> +EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readline"
>> +
>> +# Remove -rpath-link and -rpath
>> +LDFLAGS:darwinsdk =3D "${BUILDSDK_LDFLAGS}"
>> +
>> +INSANE_SKIP:append:darwin21 =3D " buildpaths"
>> --
>> 2.50.1 (Apple Git-155)
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#3035):
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_message_3035&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D_p=
uerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&s=3DWdCUPuQH=
4_kgB_zPSlmoiDVolXxnGlpUrnZ4bgKGHpo&e=3D
>> Mute This Topic:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_mt_117366396_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkIC=
C2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D_puerYIDUBoa=
GuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7QvUgvq1B0KPzK2&s=3DO62qmjJUsxyOm39Z8u=
Q9q7zP0xxII0nRnkugFlqlffM&e=3D
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&=
c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&m=3D_puerYIDUBoaGuNtBlJG7tTaRD6u0CmRwlKdBXOgrQdKsYsyc7=
QvUgvq1B0KPzK2&s=3DQESP0Hyg0GP6AoZbq9EY5fTX390b8qALUz8LqGOdbOI&e=3D
>> [ecordonnier@snap.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
>>
>

--0000000000005cb7a1064947adb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<div>the standard indentation for do_configure in =
meta-darwin is 4 spaces.<br><br>=C3=89tienne</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sun, Jan 25, 2026 at 4:32=E2=80=AFAM Eric L. Hernes &lt;<a href=3D"mailto:e=
ric@qinc.tv">eric@qinc.tv</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div>Thanks Etienne,<div><br></div><div>What is th=
e correct indentation?=C2=A0 I guess I didn=E2=80=99t look closely enough a=
t it.</div><div><br></div><div>The target is an oversight on my part, I=E2=
=80=99ll fix that.</div><div><br></div><div>The =E2=80=98with-mpft=E2=80=99=
 was taken straight from the =C2=A0`gcc-cross-canadian_%.bbappend` patch, t=
he same issue is in there too.=C2=A0 I will fix both.</div><div><br></div><=
div>-Eric</div><div><br id=3D"m_-3661092721075811665lineBreakAtBeginningOfM=
essage"><div>
<div dir=3D"auto" style=3D"color:rgb(0,0,0);letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;text-decoration:none"><div>--</div><div><b>Eric L. Hernes</b></div><di=
v><a href=3D"mailto:eric@qinc.tv" target=3D"_blank">eric@qinc.tv</a></div><=
div><br></div></div><br><br>

</div>
<div><br><blockquote type=3D"cite"><div>On Jan 24, 2026, at 5:52=E2=80=AFPM=
, Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"=
_blank">ecordonnier@snap.com</a>&gt; wrote:</div><br><div><div dir=3D"ltr">=
Hi Eric,<br><br>thanks for the patch!<br><br>I&#39;ve not tested the patch =
functionally yet. Just some minor comments at the moment:<br>- the indentat=
ion at 7 spaces is non-standard and needs to be fixed<br>- we can&#39;t har=
d-code target to arm as long as we&#39;ve not dropped x86 support completel=
y:<br>instead of target=3Ddarwin64-arm64-cc, something like:<br><br>target=
=3D&quot;${@&#39;darwin64-arm64-cc&#39; if d.getVar(&#39;SDK_ARCH&#39;) =3D=
=3D &#39;aarch64&#39; else &#39;darwin64-x86_64-cc&#39;}&quot;<br><br>- the=
re is a typo: with-mpft -&gt; with-mpfr<br><br>=C3=89tienne</div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 20, =
2026 at 6:05=E2=80=AFPM Eric L. Hernes via <a href=3D"https://urldefense.pr=
oofpoint.com/v2/url?u=3Dhttp-3A__lists.yoctoproject.org_&amp;d=3DDwMFaQ&amp=
;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Q=
j9TsRih1DULJTKUkSGa66m67E&amp;m=3DXLO-Np5YiioP293c95Xb2TUy2gAvp5dtJarkO4C_G=
MR3TOydU2KqTlxiw951hLMh&amp;s=3D1_yFvWP69V-fa7kvBgHNpED7vZ_s-EAkvXSOTGG68AE=
&amp;e=3D" target=3D"_blank">lists.yoctoproject.org</a> &lt;dev=3D<a href=
=3D"mailto:qinc.tv@lists.yoctoproject.org" target=3D"_blank">qinc.tv@lists.=
yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: &quot;Eric L. Hernes&quot; &lt;<a href=3D"mailto:eric=
@qinc.tv" target=3D"_blank">eric@qinc.tv</a>&gt;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0perl ${B}/<a href=3D"https://urldefense.proofpo=
int.com/v2/url?u=3Dhttp-3A__configdata.pm_&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJ=
TvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTK=
UkSGa66m67E&amp;m=3DXLO-Np5YiioP293c95Xb2TUy2gAvp5dtJarkO4C_GMR3TOydU2KqTlx=
iw951hLMh&amp;s=3Dad416kaw8EIshyMQROSeqHw-cWwGKidsfdI9bydLZrc&amp;e=3D" rel=
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
</div></blockquote></div><br></div></div></blockquote></div>

--0000000000005cb7a1064947adb4--

