Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82882F94CA5
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 18:09:02 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42454.1776794941473275077
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 11:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oYnWiTjP;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c745e18a0so750926366b.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 11:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776794940; cv=none;
        d=google.com; s=arc-20240605;
        b=HibjYx1y7b/Yrz4GwWtiFGZacnbugTKWhONj7k2QlZmDvehtIDGPgICuEDuUe7m8rI
         Zm3Pjx+jk6MFrHQddTsBIlpyPuXopmHlzxHi/SF138ueM0v/VL9Sfj8f7SQyH4TLA0hb
         G+vbJUy41DmDbHij/azrl8DOZ66CkBB1UhfHCgZoWVacKoLId1vit5xyYnNQK504iGj6
         UhkE7nsFnOtDzAHQGzZgmTk+peiCcwHg58cP79aN9VmIhs7sSxh3U9CQeF8QJkd215Zf
         hFBoa4Bvb4eIUQDog3dLXl/obuLW9CVSXbUbI2UBoGEFNCxsbXStjJH13UTUQfu509jI
         M/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h55UQPRCoVki4js+UhHd10gwUkIKcWsf+2i+dse+vyw=;
        fh=XYDvufTmJb9BMi3dGbuH5zDx7W5fpuxpUhmZHJjAzPs=;
        b=RBYtk1FL8s0Ghrs6GGStdLBNVjYO9kUNZiA4E1QG4Wd10jrvrDfAef2UAMQaOmv4oN
         ZFoHvO2WK4N4ShNrhKUyiHpb24ReB8KWXIH5oiU45u1yQyHAX6SywXwtaeLhxpYxf0+J
         YSjd1MwhpkoKtaIL61RPkmZWgc12hnLhvLTQN5X9PE8Xsn7dH16T/uq4YDe20g8SSKLb
         PkEj79+vKafZ0mJNW+PWLRZLLwSHuX8ImdPQa07gg69TF1oXOb1UYN2pn3NjaSF/nYw1
         8qo3KLLeZwrdaI5H+URVxe3Pe+lSO7w2fx28LPCy5hWZskCSDzUbMZ6/E6LUtKmoAKyH
         Qe7g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794940; x=1777399740; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h55UQPRCoVki4js+UhHd10gwUkIKcWsf+2i+dse+vyw=;
        b=oYnWiTjPjxjy1i3Z7qPu29rB41Qgf9opmR3mQ6FNfGUZ3/5Ojhonli0ImrxwdAMeHD
         dzAaQggUl7faDaIEWYd01zkp5+eVZX6qrpTvK5saIVxJnmBBHZp45kXsTt+7u6IMbGTp
         pMEhoVDFcL28S4WJg/sC0CLyJDFQeFQKvMMNTcqdhAepsm65tm1UuGvZZqb7kdwS+Yst
         xmwHaMaiJYUrWPK+GOLQfaQ+4DlwGpJSQXa7stLErG7JoMIeLlN3hNfXkzwtDewD2wuA
         fMoEYlknIjJ81vHavnNC9quQ5ltzG2LbLrdAPZnH3GB5Nu4nfxYH7JMRVLXgdv4ZclpD
         CGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794940; x=1777399740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h55UQPRCoVki4js+UhHd10gwUkIKcWsf+2i+dse+vyw=;
        b=c5Hod5zBVilX2/r2mw2hFpRVLDLawvlA3U1zvtvRG4FUTESlIqQxt9vq+N4UjuD6Ix
         BC6ODMqS46LBSuCS5OK3pArxrFs3vFAMRb9WwoEouaA53csga99nnBt/cxpeSfwRc4Ia
         50QaB2ZHiNCTOJhZVebI2r57v9uUkWaLCCqL2qRZt3dBrXdTO+23q7jKNPilgbVdT+qG
         DKGhP/zC7KgY/oAz+tHBbWfhs0ETtYQGOTN+e4ne8wk9xgCiqc23D719NKfatc/BMLys
         yw91hFeNvvPh93abybvaqGvSVMAYVwN2yBulQdgBPFpjJkjS/7hy1hkvqk/H3p8WO9cc
         ePoA==
X-Gm-Message-State: AOJu0YxZkOmX4qtCZULY4OhfVaorOiPNH/t42OvRY/c9ALD5HuicmIQI
	BeU2EvEnPx/6sosXsRv2yGwbpLkuKHE6SISuB/5PFB5EW7dWcHtG2+/W95OihjyPP6SuvSIiZxL
	SYmrMC02kH6/wBDVlL3jJVJSfwe+1Ztk=
X-Gm-Gg: AeBDietH2/kRl9q3ggHa6qsFyw8IdbLagAGjeJU4cPvs7IuHvUC3mlNu040lQZIR1tN
	JJ5y8EbpXofOJmt3knMH4mbTQGZFYZq9CTqYUhXUsHqlitAqz6QRQgQE99wD6JgyBO8iVVX2OVE
	hNjz5+uQJVvSjO35CVYm5oFZgVXrFnGIq5nGrq4oOXtRJuHE5Y4Z1qppQT+Dw+eyulvNzv5mrRV
	0xpP0m5nckN9FGvq03b3ngyvO45IaZbRBFcUIV8S/QvtIOJ686BMvu79z+Zi80CtXGcw5qntYvH
	S9NbSdhNW4y1JdmmFB3aX8LwyKGXrSj+G/GVRwxIuYIVKEFq//Qqq1oH5AnFlTuElI8XwRs5IOc
	2pzcs
X-Received: by 2002:a17:907:15c5:b0:ba9:3f4a:1521 with SMTP id
 a640c23a62f3a-ba93f4a157amr187564866b.19.1776794939132; Tue, 21 Apr 2026
 11:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776283733.git.scott.murray@konsulko.com>
 <CANPvuRkN7vGW+_Tu6qd0vxcw9BDZAF=ZUzb0hebDZSm2kOJXMg@mail.gmail.com> <a2ac6d5e-c0bb-70df-bd4b-756fbc026ef1@konsulko.com>
In-Reply-To: <a2ac6d5e-c0bb-70df-bd4b-756fbc026ef1@konsulko.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 21 Apr 2026 19:08:47 +0100
X-Gm-Features: AQROBzCSnxu4oC3-WT3qgshmg32j_lx8dHKT68wK-B1xj8vIAXUzqUehjhrM16s
Message-ID: <CANPvuRmtf1N+8gDgd+8bLZm69PY+pDkS2j0q7q_kfq51yONqOg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/7] Assorted updates 04/15
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000002f8df9064ffc4fd5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 18:09:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3751

--0000000000002f8df9064ffc4fd5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Scott Murray <scott.murray@konsulko.com> escreveu (ter=C3=A7a, 21/04/2026 =
=C3=A0(s)
17:57):

> On Mon, 20 Apr 2026, Jose Quaresma via lists.yoctoproject.org wrote:
>
> > Hi Scott,
> >
> > Scott Murray via lists.yoctoproject.org <scott.murray=3D
> > konsulko.com@lists.yoctoproject.org> escreveu (quarta, 15/04/2026 =C3=
=A0(s)
> > 21:19):
> >
> > > This patch series rolls up the contributed patches from the past few
> > > weeks, barring the suricata 8.04 update that will need some rework fo=
r
> > > Lua 5.5.  These changes are queued on the master-next branch if you
> > > would like to check them out to test yourself.  I intend to merge the=
se
> > > to master branch at end of day tomorrow (Eastern Time, April 16) unle=
ss
> > > there are objections.
> > >
> >
> > Were there any objections or other restrictions?
>
> Sorry, no, I had forgotten to push to master before the weekend, but did
> so yesterday morning.  I'll try to be more on the ball going forward.
>

No worries!

It probably had already been integrated yesterday when I asked.
I asked because I didn't see anything in [1], and for your information,
it's still outdated.

[1] https://git.yoctoproject.org/meta-security/

Thanks

Jose


>
> Scott
>
>
> > > Note that there are the following known issues atm:
> > > * parsec-service currently fails to build with an error in the
> > >   cryptoki crate.  This was likely triggered by the upgrade to
> > >   Rust 1.94.x in oe-core.
> > > * Including python3-privacyidea in an image results in packaging
> > >   conflicts between python3-cryptography and python3-pyrad that
> > >   need to be addressed in those recipes in oe-core/meta-python.
> > >
> > > I hope to get these addressed in the next week or so.
> > >
> > > Scott
> > >
> > >
> > > Changes:
> > >
> > > Haiqing Bai (1):
> > >   isic: fix RDEPNEDS typo
> > >
> > > Khem Raj (1):
> > >   wic: wic need to be moved to files/wic within the layer to be
> > >     found/used
> > >
> > > Peter Marko (2):
> > >   libtpms: fix build with glibc 2.43
> > >   tpm2-pkcs11: fix build failure
> > >
> > > Yi Zhao (2):
> > >   scap-security-guide: upgrade 0.1.78 -> 0.1.80
> > >   openscap: upgrade 1.4.2 -> 1.4.3
> > >
> > > Zhang Peng (1):
> > >   meta-security: fix incorrect HOMEPAGE variable names
> > >
> > >  .../wic}/beaglebone-yocto-verity.wks.in       |  0
> > >  .../systemd-bootdisk-dmverity-hash.wks.in     |  0
> > >  .../wic}/systemd-bootdisk-dmverity.wks.in     |  0
> > >  ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++=
++
> > >  meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
> > >  ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++
> > >  .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
> > >  recipes-compliance/lynis/lynis_3.1.6.bb       |  2 +-
> > >  .../{openscap_1.4.2.bb =3D> openscap_1.4.3.bb}  |  4 +--
> > >  ....1.78.bb =3D> scap-security-guide_0.1.80.bb} |  4 +--
> > >  recipes-scanners/arpwatch/arpwatch_3.3.bb     |  2 +-
> > >  recipes-security/glome/glome_git.bb           |  2 +-
> > >  .../google-authenticator-libpam_1.09.bb       |  2 +-
> > >  recipes-security/isic/isic_0.07.bb            |  2 +-
> > >  14 files changed, 75 insertions(+), 10 deletions(-)
> > >  rename {wic =3D> files/wic}/beaglebone-yocto-verity.wks.in (100%)
> > >  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity-hash.wks.in
> (100%)
> > >  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
> > >  create mode 100644
> > >
> meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLI=
B_GetPlaintext.patch
> > >  create mode 100644
> > >
> meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-=
twist-on-auth-failure.patch
> > >  rename recipes-compliance/openscap/{openscap_1.4.2.bb =3D>
> > > openscap_1.4.3.bb} (96%)
> > >  rename recipes-compliance/scap-security-guide/{
> > > scap-security-guide_0.1.78.bb =3D> scap-security-guide_0.1.80.bb} (93=
%)
> > >
> > > --
> > > 2.53.0
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> >
> >



--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000002f8df9064ffc4fd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Scott Murray &l=
t;<a href=3D"mailto:scott.murray@konsulko.com">scott.murray@konsulko.com</a=
>&gt; escreveu (ter=C3=A7a, 21/04/2026 =C3=A0(s) 17:57):<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Mon, 20 Apr 2026, Jose Quaresma=
 via <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D=
"_blank">lists.yoctoproject.org</a> wrote:<br>
<br>
&gt; Hi Scott,<br>
&gt;<br>
&gt; Scott Murray via <a href=3D"http://lists.yoctoproject.org" rel=3D"nore=
ferrer" target=3D"_blank">lists.yoctoproject.org</a> &lt;scott.murray=3D<br=
>
&gt; <a href=3D"mailto:konsulko.com@lists.yoctoproject.org" target=3D"_blan=
k">konsulko.com@lists.yoctoproject.org</a>&gt; escreveu (quarta, 15/04/2026=
 =C3=A0(s)<br>
&gt; 21:19):<br>
&gt;<br>
&gt; &gt; This patch series rolls up the contributed patches from the past =
few<br>
&gt; &gt; weeks, barring the suricata 8.04 update that will need some rewor=
k for<br>
&gt; &gt; Lua 5.5.=C2=A0 These changes are queued on the master-next branch=
 if you<br>
&gt; &gt; would like to check them out to test yourself.=C2=A0 I intend to =
merge these<br>
&gt; &gt; to master branch at end of day tomorrow (Eastern Time, April 16) =
unless<br>
&gt; &gt; there are objections.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Were there any objections or other restrictions?<br>
<br>
Sorry, no, I had forgotten to push to master before the weekend, but did<br=
>
so yesterday morning.=C2=A0 I&#39;ll try to be more on the ball going forwa=
rd.<br></blockquote><div><br></div><div>No worries!</div><div><br>It probab=
ly had already been integrated yesterday when I asked.</div><div>I asked be=
cause I didn&#39;t see anything in [1], and for your information, it&#39;s =
still outdated.</div><div><br>[1] <a href=3D"https://git.yoctoproject.org/m=
eta-security/">https://git.yoctoproject.org/meta-security/</a><br><br>Thank=
s</div><div><br>Jose<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Scott<br>
<br>
<br>
&gt; &gt; Note that there are the following known issues atm:<br>
&gt; &gt; * parsec-service currently fails to build with an error in the<br=
>
&gt; &gt;=C2=A0 =C2=A0cryptoki crate.=C2=A0 This was likely triggered by th=
e upgrade to<br>
&gt; &gt;=C2=A0 =C2=A0Rust 1.94.x in oe-core.<br>
&gt; &gt; * Including python3-privacyidea in an image results in packaging<=
br>
&gt; &gt;=C2=A0 =C2=A0conflicts between python3-cryptography and python3-py=
rad that<br>
&gt; &gt;=C2=A0 =C2=A0need to be addressed in those recipes in oe-core/meta=
-python.<br>
&gt; &gt;<br>
&gt; &gt; I hope to get these addressed in the next week or so.<br>
&gt; &gt;<br>
&gt; &gt; Scott<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Changes:<br>
&gt; &gt;<br>
&gt; &gt; Haiqing Bai (1):<br>
&gt; &gt;=C2=A0 =C2=A0isic: fix RDEPNEDS typo<br>
&gt; &gt;<br>
&gt; &gt; Khem Raj (1):<br>
&gt; &gt;=C2=A0 =C2=A0wic: wic need to be moved to files/wic within the lay=
er to be<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0found/used<br>
&gt; &gt;<br>
&gt; &gt; Peter Marko (2):<br>
&gt; &gt;=C2=A0 =C2=A0libtpms: fix build with glibc 2.43<br>
&gt; &gt;=C2=A0 =C2=A0tpm2-pkcs11: fix build failure<br>
&gt; &gt;<br>
&gt; &gt; Yi Zhao (2):<br>
&gt; &gt;=C2=A0 =C2=A0scap-security-guide: upgrade 0.1.78 -&gt; 0.1.80<br>
&gt; &gt;=C2=A0 =C2=A0openscap: upgrade 1.4.2 -&gt; 1.4.3<br>
&gt; &gt;<br>
&gt; &gt; Zhang Peng (1):<br>
&gt; &gt;=C2=A0 =C2=A0meta-security: fix incorrect HOMEPAGE variable names<=
br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 .../wic}/<a href=3D"http://beaglebone-yocto-verity.wks.in" =
rel=3D"noreferrer" target=3D"_blank">beaglebone-yocto-verity.wks.in</a>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt; &gt;=C2=A0 .../<a href=3D"http://systemd-bootdisk-dmverity-hash.wks.in=
" rel=3D"noreferrer" target=3D"_blank">systemd-bootdisk-dmverity-hash.wks.i=
n</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt; &gt;=C2=A0 .../wic}/<a href=3D"http://systemd-bootdisk-dmverity.wks.in=
" rel=3D"noreferrer" target=3D"_blank">systemd-bootdisk-dmverity.wks.in</a>=
=C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt; &gt;=C2=A0 ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 ++++++++=
+++++++++++<br>
&gt; &gt;=C2=A0 meta-tpm/recipes-tpm/libtpm/<a href=3D"http://libtpms_0.10.=
0.bb" rel=3D"noreferrer" target=3D"_blank">libtpms_0.10.0.bb</a> |=C2=A0 4 =
++-<br>
&gt; &gt;=C2=A0 ...eturn-NULL-for-twist-on-auth-failure.patch | 28 ++++++++=
+++++++<br>
&gt; &gt;=C2=A0 .../tpm2-pkcs11/<a href=3D"http://tpm2-pkcs11_1.9.1.bb" rel=
=3D"noreferrer" target=3D"_blank">tpm2-pkcs11_1.9.1.bb</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt;=C2=A0 recipes-compliance/lynis/<a href=3D"http://lynis_3.1.6.bb" =
rel=3D"noreferrer" target=3D"_blank">lynis_3.1.6.bb</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 .../{<a href=3D"http://openscap_1.4.2.bb" rel=3D"noreferrer=
" target=3D"_blank">openscap_1.4.2.bb</a> =3D&gt; <a href=3D"http://opensca=
p_1.4.3.bb" rel=3D"noreferrer" target=3D"_blank">openscap_1.4.3.bb</a>}=C2=
=A0 |=C2=A0 4 +--<br>
&gt; &gt;=C2=A0 ....<a href=3D"http://1.78.bb" rel=3D"noreferrer" target=3D=
"_blank">1.78.bb</a> =3D&gt; <a href=3D"http://scap-security-guide_0.1.80.b=
b" rel=3D"noreferrer" target=3D"_blank">scap-security-guide_0.1.80.bb</a>} =
|=C2=A0 4 +--<br>
&gt; &gt;=C2=A0 recipes-scanners/arpwatch/<a href=3D"http://arpwatch_3.3.bb=
" rel=3D"noreferrer" target=3D"_blank">arpwatch_3.3.bb</a>=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 recipes-security/glome/<a href=3D"http://glome_git.bb" rel=
=3D"noreferrer" target=3D"_blank">glome_git.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 .../<a href=3D"http://google-authenticator-libpam_1.09.bb" =
rel=3D"noreferrer" target=3D"_blank">google-authenticator-libpam_1.09.bb</a=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 recipes-security/isic/<a href=3D"http://isic_0.07.bb" rel=
=3D"noreferrer" target=3D"_blank">isic_0.07.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 14 files changed, 75 insertions(+), 10 deletions(-)<br>
&gt; &gt;=C2=A0 rename {wic =3D&gt; files/wic}/<a href=3D"http://beaglebone=
-yocto-verity.wks.in" rel=3D"noreferrer" target=3D"_blank">beaglebone-yocto=
-verity.wks.in</a> (100%)<br>
&gt; &gt;=C2=A0 rename {wic =3D&gt; files/wic}/<a href=3D"http://systemd-bo=
otdisk-dmverity-hash.wks.in" rel=3D"noreferrer" target=3D"_blank">systemd-b=
ootdisk-dmverity-hash.wks.in</a> (100%)<br>
&gt; &gt;=C2=A0 rename {wic =3D&gt; files/wic}/<a href=3D"http://systemd-bo=
otdisk-dmverity.wks.in" rel=3D"noreferrer" target=3D"_blank">systemd-bootdi=
sk-dmverity.wks.in</a> (100%)<br>
&gt; &gt;=C2=A0 create mode 100644<br>
&gt; &gt; meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-=
in-TPMLIB_GetPlaintext.patch<br>
&gt; &gt;=C2=A0 create mode 100644<br>
&gt; &gt; meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-N=
ULL-for-twist-on-auth-failure.patch<br>
&gt; &gt;=C2=A0 rename recipes-compliance/openscap/{<a href=3D"http://opens=
cap_1.4.2.bb" rel=3D"noreferrer" target=3D"_blank">openscap_1.4.2.bb</a> =
=3D&gt;<br>
&gt; &gt; <a href=3D"http://openscap_1.4.3.bb" rel=3D"noreferrer" target=3D=
"_blank">openscap_1.4.3.bb</a>} (96%)<br>
&gt; &gt;=C2=A0 rename recipes-compliance/scap-security-guide/{<br>
&gt; &gt; <a href=3D"http://scap-security-guide_0.1.78.bb" rel=3D"noreferre=
r" target=3D"_blank">scap-security-guide_0.1.78.bb</a> =3D&gt; <a href=3D"h=
ttp://scap-security-guide_0.1.80.bb" rel=3D"noreferrer" target=3D"_blank">s=
cap-security-guide_0.1.80.bb</a>} (93%)<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.53.0<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;</blockquote></div><div><br clear=3D"all"></div><div><br></div><span cl=
ass=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div=
></div></div></div>

--0000000000002f8df9064ffc4fd5--

