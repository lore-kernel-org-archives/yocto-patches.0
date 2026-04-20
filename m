Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E982F55807
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 10:17:45 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16510.1776680264305972418
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 03:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Z3l6MXia;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9382e59c0eso454299466b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 03:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776680262; cv=none;
        d=google.com; s=arc-20240605;
        b=kI0dm7CvuYragKVkha/42ioE1FQIHQH2rdiXxfK7tJYkhPKopS6IMqBCMLR7yPIpQ2
         xKsG91hgWx73wq841fnT+KKpL9WzvhLA7ARMph8B71N5xFwcaRKnLQYzoPk3CuH2zper
         Se1DVXXF8SatGInZ3PFk2ZEZ2zwYxT0qqET8cq41WHT1eweKk7M0rmf6mmJLvnSjog2B
         o/Hyte7WDd7qsluQRP/vYaqvg7mAYNwpEbDPVDMNii7/+VQVPV3o0iMWa1TRBj4KENO2
         bvZWTBiVCk/eUI8tkzYchBgxDf/iTmTTU+gXmryPzht1MoI0FmSCZnvHeL+lf54UmPhF
         Q0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=RXAzObMmUQX7YQQ7pgrh8cTTFmjgd2LVQN2guDmJNJU=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=Hv18GiZuiotsqbAhe9Tx642MPS8STkhWn77UlwXCQhRj+LoFINZy0GcZOOX64BaEBq
         beERqEFtejr+Vre4PPeKewWA+/sm1To5f9AyAAgZdPXVyxBj/RXqioQiwW0vpEj1tvu4
         ES8OZnRftO9K/MamozgmVX0bc0sIpD7pfGT3f0qXJS6SWqD+tbZwu3KDQ8oW5Xa2VyZH
         RmcJoTSNweMhieiDWshoSG5yxkwECZ9H8gCGmN2zV2YgdMb/lzjbYZUxZVJmuen8JaC8
         F+tfGz9mGb/Ef46tjCd/LAW+3WvRaSe038zNmxNt19v1gsQikF6vUpBcqcYBLIIW94/N
         AL1Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776680262; x=1777285062; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXAzObMmUQX7YQQ7pgrh8cTTFmjgd2LVQN2guDmJNJU=;
        b=Z3l6MXiarXhVXZt/8iWLDGneavom43ysakdL5U1hy6GNX6LKGPRxDbCDxMy8XOgMZK
         9o7v4KJq4bJQUNzQYQhtIIemuFycV+bfF61Yq1Accoz9owLSnKXrzNKI46HMPxOe3Q1j
         vT7RPAfQCs66LI3SfDNTrv1N9zteKj8jT8OAvcaB8r2kfaACf5Xmm/r4/tvktvCIv82w
         g4vbU7bWlgW/QAM8Nr2iXM+8YNXbKkcYOCAxkGDpop5T1cmb8QxFPS7oBbSXN4ZIhcAS
         OMFktsSLCAVmnAiQjhP5uVTYmMp1Yxxp2zTP5ZivMBaw8uxpla2/SfTkuORGsKhSpgfe
         pIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680262; x=1777285062;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXAzObMmUQX7YQQ7pgrh8cTTFmjgd2LVQN2guDmJNJU=;
        b=kA3k+jQYMB5OYruAXsNlsCnj2LrIld0iXA3YI3x6kp4fT832k3A5I6K0hnGMEctvOm
         Ow3l2jwUMwLcJ7o0NHIc1S624cB70G8ScpWANYuOXGkVSfl02jOvDwT+/medDK+MohfY
         WhHtqTsej7eg2rm8xYJrf/4Ue4NdDhr7D4HxXXzTlaYf1XvE+acMD+6VIBeVQ/RWC6j3
         DicPrkVoLHrogKcxxTNutIZKOdBUYncnX3pP6nTjqOxa2F7lsrOCtFwC0DfYLzGDpq46
         dYycDC1m9oL/9mmzFPSmbbsIMimUdl+YUafBNXzhMNleBcMFPP1dPXtrg6mp3MrjTI/g
         RG3A==
X-Gm-Message-State: AOJu0YxWLEVVk87gaIMsFNgRCWwfMu9rVpFYxmMmVNIJlUmLdXjlPOdI
	IgIAWFxY9sP1T653fAe8zDV0xx6mU84pO5HwolCI5R/U/8sYDwIi+rohb9o/jzcDZxJwaflLs+h
	ZwFpxYTPaGVmcSJkoLNXKg0l8QwqWkFKOSQ==
X-Gm-Gg: AeBDieta1kmJ8ysUG95lfZfziR0GldjAsubtxHo+jyH91EVR9ObmuZp4CAGcrmh/sfz
	k4PGIT6h+GrICa6Fuew0/0xjUmskFYX/9Y+dsCQ2jpxY1tfslmITSfylkt+qlrcr7P06HDLfo7D
	wpvqkOkVqjz+pExliZghp2z3hirA/b9hah3AkXlu7YQEL/7U5+Q74vCah5GrlfKUstLOEPcSGsN
	srw5PaT9zpruRLPbIfO2AqMD9mDY5s/ToXdiqA9EcWzqWu9ktzmktKGiVGwwACWWdd5yoTnfexe
	REZArbCeuGNWJh1Y4vlyXLfi+tiXN6B8jxkQ52VBONwua1pAKYdzNuWHyTfsFMEpKq4Gq0GppLD
	Jece9
X-Received: by 2002:a17:907:da7:b0:ba7:62f:9fa6 with SMTP id
 a640c23a62f3a-ba7062fa2eemr204678466b.2.1776680261915; Mon, 20 Apr 2026
 03:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776283733.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 20 Apr 2026 11:17:30 +0100
X-Gm-Features: AQROBzA42FTP2Byp_wqTsuPeRKoLpEwcKRoRJLiRZw6XpIZg95h1kOvBjc5Vb-8
Message-ID: <CANPvuRkN7vGW+_Tu6qd0vxcw9BDZAF=ZUzb0hebDZSm2kOJXMg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/7] Assorted updates 04/15
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e41955064fe19b81"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 10:17:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3735

--000000000000e41955064fe19b81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Scott,

Scott Murray via lists.yoctoproject.org <scott.murray=3D
konsulko.com@lists.yoctoproject.org> escreveu (quarta, 15/04/2026 =C3=A0(s)
21:19):

> This patch series rolls up the contributed patches from the past few
> weeks, barring the suricata 8.04 update that will need some rework for
> Lua 5.5.  These changes are queued on the master-next branch if you
> would like to check them out to test yourself.  I intend to merge these
> to master branch at end of day tomorrow (Eastern Time, April 16) unless
> there are objections.
>

Were there any objections or other restrictions?

Jose


>
> Note that there are the following known issues atm:
> * parsec-service currently fails to build with an error in the
>   cryptoki crate.  This was likely triggered by the upgrade to
>   Rust 1.94.x in oe-core.
> * Including python3-privacyidea in an image results in packaging
>   conflicts between python3-cryptography and python3-pyrad that
>   need to be addressed in those recipes in oe-core/meta-python.
>
> I hope to get these addressed in the next week or so.
>
> Scott
>
>
> Changes:
>
> Haiqing Bai (1):
>   isic: fix RDEPNEDS typo
>
> Khem Raj (1):
>   wic: wic need to be moved to files/wic within the layer to be
>     found/used
>
> Peter Marko (2):
>   libtpms: fix build with glibc 2.43
>   tpm2-pkcs11: fix build failure
>
> Yi Zhao (2):
>   scap-security-guide: upgrade 0.1.78 -> 0.1.80
>   openscap: upgrade 1.4.2 -> 1.4.3
>
> Zhang Peng (1):
>   meta-security: fix incorrect HOMEPAGE variable names
>
>  .../wic}/beaglebone-yocto-verity.wks.in       |  0
>  .../systemd-bootdisk-dmverity-hash.wks.in     |  0
>  .../wic}/systemd-bootdisk-dmverity.wks.in     |  0
>  ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
>  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
>  ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++
>  .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
>  recipes-compliance/lynis/lynis_3.1.6.bb       |  2 +-
>  .../{openscap_1.4.2.bb =3D> openscap_1.4.3.bb}  |  4 +--
>  ....1.78.bb =3D> scap-security-guide_0.1.80.bb} |  4 +--
>  recipes-scanners/arpwatch/arpwatch_3.3.bb     |  2 +-
>  recipes-security/glome/glome_git.bb           |  2 +-
>  .../google-authenticator-libpam_1.09.bb       |  2 +-
>  recipes-security/isic/isic_0.07.bb            |  2 +-
>  14 files changed, 75 insertions(+), 10 deletions(-)
>  rename {wic =3D> files/wic}/beaglebone-yocto-verity.wks.in (100%)
>  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
>  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
>  create mode 100644
> meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLI=
B_GetPlaintext.patch
>  create mode 100644
> meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-=
twist-on-auth-failure.patch
>  rename recipes-compliance/openscap/{openscap_1.4.2.bb =3D>
> openscap_1.4.3.bb} (96%)
>  rename recipes-compliance/scap-security-guide/{
> scap-security-guide_0.1.78.bb =3D> scap-security-guide_0.1.80.bb} (93%)
>
> --
> 2.53.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3708):
> https://lists.yoctoproject.org/g/yocto-patches/message/3708
> Mute This Topic: https://lists.yoctoproject.org/mt/118847685/5052612
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000e41955064fe19b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Scott,</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">Scott Murray via <a href=3D=
"http://lists.yoctoproject.org" target=3D"_blank">lists.yoctoproject.org</a=
> &lt;scott.murray=3D<a href=3D"mailto:konsulko.com@lists.yoctoproject.org"=
 target=3D"_blank">konsulko.com@lists.yoctoproject.org</a>&gt; escreveu (qu=
arta, 15/04/2026 =C3=A0(s) 21:19):<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This patch series rolls up the contributed patches from =
the past few<br>
weeks, barring the suricata 8.04 update that will need some rework for<br>
Lua 5.5.=C2=A0 These changes are queued on the master-next branch if you<br=
>
would like to check them out to test yourself.=C2=A0 I intend to merge thes=
e<br>
to master branch at end of day tomorrow (Eastern Time, April 16) unless<br>
there are objections.<br></blockquote><div><br></div><div>Were there any ob=
jections or other restrictions?</div><div><br></div><div>Jose</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Note that there are the following known issues atm:<br>
* parsec-service currently fails to build with an error in the<br>
=C2=A0 cryptoki crate.=C2=A0 This was likely triggered by the upgrade to<br=
>
=C2=A0 Rust 1.94.x in oe-core.<br>
* Including python3-privacyidea in an image results in packaging<br>
=C2=A0 conflicts between python3-cryptography and python3-pyrad that<br>
=C2=A0 need to be addressed in those recipes in oe-core/meta-python.<br>
<br>
I hope to get these addressed in the next week or so.<br>
<br>
Scott<br>
<br>
<br>
Changes:<br>
<br>
Haiqing Bai (1):<br>
=C2=A0 isic: fix RDEPNEDS typo<br>
<br>
Khem Raj (1):<br>
=C2=A0 wic: wic need to be moved to files/wic within the layer to be<br>
=C2=A0 =C2=A0 found/used<br>
<br>
Peter Marko (2):<br>
=C2=A0 libtpms: fix build with glibc 2.43<br>
=C2=A0 tpm2-pkcs11: fix build failure<br>
<br>
Yi Zhao (2):<br>
=C2=A0 scap-security-guide: upgrade 0.1.78 -&gt; 0.1.80<br>
=C2=A0 openscap: upgrade 1.4.2 -&gt; 1.4.3<br>
<br>
Zhang Peng (1):<br>
=C2=A0 meta-security: fix incorrect HOMEPAGE variable names<br>
<br>
=C2=A0.../wic}/<a href=3D"http://beaglebone-yocto-verity.wks.in" rel=3D"nor=
eferrer" target=3D"_blank">beaglebone-yocto-verity.wks.in</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
=C2=A0.../<a href=3D"http://systemd-bootdisk-dmverity-hash.wks.in" rel=3D"n=
oreferrer" target=3D"_blank">systemd-bootdisk-dmverity-hash.wks.in</a>=C2=
=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
=C2=A0.../wic}/<a href=3D"http://systemd-bootdisk-dmverity.wks.in" rel=3D"n=
oreferrer" target=3D"_blank">systemd-bootdisk-dmverity.wks.in</a>=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 0<br>
=C2=A0...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 ++++++++++++++++++=
+<br>
=C2=A0meta-tpm/recipes-tpm/libtpm/<a href=3D"http://libtpms_0.10.0.bb" rel=
=3D"noreferrer" target=3D"_blank">libtpms_0.10.0.bb</a> |=C2=A0 4 ++-<br>
=C2=A0...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++<br=
>
=C2=A0.../tpm2-pkcs11/<a href=3D"http://tpm2-pkcs11_1.9.1.bb" rel=3D"norefe=
rrer" target=3D"_blank">tpm2-pkcs11_1.9.1.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 1 +<br>
=C2=A0recipes-compliance/lynis/<a href=3D"http://lynis_3.1.6.bb" rel=3D"nor=
eferrer" target=3D"_blank">lynis_3.1.6.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0.../{<a href=3D"http://openscap_1.4.2.bb" rel=3D"noreferrer" target=
=3D"_blank">openscap_1.4.2.bb</a> =3D&gt; <a href=3D"http://openscap_1.4.3.=
bb" rel=3D"noreferrer" target=3D"_blank">openscap_1.4.3.bb</a>}=C2=A0 |=C2=
=A0 4 +--<br>
=C2=A0....<a href=3D"http://1.78.bb" rel=3D"noreferrer" target=3D"_blank">1=
.78.bb</a> =3D&gt; <a href=3D"http://scap-security-guide_0.1.80.bb" rel=3D"=
noreferrer" target=3D"_blank">scap-security-guide_0.1.80.bb</a>} |=C2=A0 4 =
+--<br>
=C2=A0recipes-scanners/arpwatch/<a href=3D"http://arpwatch_3.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">arpwatch_3.3.bb</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A0recipes-security/glome/<a href=3D"http://glome_git.bb" rel=3D"norefer=
rer" target=3D"_blank">glome_git.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-<br>
=C2=A0.../<a href=3D"http://google-authenticator-libpam_1.09.bb" rel=3D"nor=
eferrer" target=3D"_blank">google-authenticator-libpam_1.09.bb</a>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0recipes-security/isic/<a href=3D"http://isic_0.07.bb" rel=3D"noreferr=
er" target=3D"_blank">isic_0.07.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A014 files changed, 75 insertions(+), 10 deletions(-)<br>
=C2=A0rename {wic =3D&gt; files/wic}/<a href=3D"http://beaglebone-yocto-ver=
ity.wks.in" rel=3D"noreferrer" target=3D"_blank">beaglebone-yocto-verity.wk=
s.in</a> (100%)<br>
=C2=A0rename {wic =3D&gt; files/wic}/<a href=3D"http://systemd-bootdisk-dmv=
erity-hash.wks.in" rel=3D"noreferrer" target=3D"_blank">systemd-bootdisk-dm=
verity-hash.wks.in</a> (100%)<br>
=C2=A0rename {wic =3D&gt; files/wic}/<a href=3D"http://systemd-bootdisk-dmv=
erity.wks.in" rel=3D"noreferrer" target=3D"_blank">systemd-bootdisk-dmverit=
y.wks.in</a> (100%)<br>
=C2=A0create mode 100644 meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-com=
pilation-error-in-TPMLIB_GetPlaintext.patch<br>
=C2=A0create mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-l=
ib-tpm-return-NULL-for-twist-on-auth-failure.patch<br>
=C2=A0rename recipes-compliance/openscap/{<a href=3D"http://openscap_1.4.2.=
bb" rel=3D"noreferrer" target=3D"_blank">openscap_1.4.2.bb</a> =3D&gt; <a h=
ref=3D"http://openscap_1.4.3.bb" rel=3D"noreferrer" target=3D"_blank">opens=
cap_1.4.3.bb</a>} (96%)<br>
=C2=A0rename recipes-compliance/scap-security-guide/{<a href=3D"http://scap=
-security-guide_0.1.78.bb" rel=3D"noreferrer" target=3D"_blank">scap-securi=
ty-guide_0.1.78.bb</a> =3D&gt; <a href=3D"http://scap-security-guide_0.1.80=
.bb" rel=3D"noreferrer" target=3D"_blank">scap-security-guide_0.1.80.bb</a>=
} (93%)<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3708): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3708" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3708</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118847685/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/118847685/5052612</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13170708/5052612/1504338242/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150433=
8242/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>
</div>

--000000000000e41955064fe19b81--

