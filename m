Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C2E7C6EC
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 20:59:20 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17426.1769893156050661149
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 12:59:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Qu9kIIaX;
 spf=pass (domain: snapchat.com, ip: 209.85.128.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so23773625e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 12:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769893154; cv=none;
        d=google.com; s=arc-20240605;
        b=cRTx0Krc/mv0rZ+ajT0TrSgIqjCYvicRJKbcQUREUGL2cqfHl1Us7pwJZ6g4wiLgbL
         cHeP8R6m2ybzW7oYMnh9wpv5LS+dmYNr62e1qP5R5eg/GBZBtdWCQJk1LonJwaF26YJ2
         /kvw+nsHMhrGhAVswny/8/gynTxj2qVVa65hcObEdy6uHB2Dr8RuXO4U3/ioL/ZLT+a4
         qtQhfEtcVzUl3dkcsYKgJlN04towFIRkdOnG/BgQBUGDmvREtZdq0o/vsmb9PGmtp1Ql
         WUY7mqGmMiBsjnpDMQKgUT31rclWTblQs/doJrlavQoNfS1knB+sQWJAlbCarAm3tHhr
         q6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oE3atSTI0e2qKZIiMDQMA6tZwWC6g1/9rqYxHc0/td0=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=jIw757AfU5vYyAjvsmJ5TUAy6nSDMtgEt1wJApGdQ7seUzmivzhsxHIa4wYT3MbTTy
         Uqp5gXzQdRq/gaaY7XCfHk5G/ijgHFFal+ISDeQKRejX1IkhByb8KQaupfLNYT7nkYmE
         Uzpx4a5XaMjoC9unSwkDX/Zs6uAzqOfkbPbPXH1a2SZy7e/vxUPFhs9wsLXHc5i7qgGV
         nwoPmRIruVRlQVTgyJmQt7HPZ+zr7rY8XnWs8FbZp8PYLFK67QAcxrwUBZfWl8EsGVoP
         0YSrL3k3O5IaIGwCWLRm4Y/N6cVAlXef42/J34pSHltLkXumusqoEnry7JbVbd684c/q
         ngpw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769893154; x=1770497954; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oE3atSTI0e2qKZIiMDQMA6tZwWC6g1/9rqYxHc0/td0=;
        b=Qu9kIIaXxDDKSQsDjVFrKySHr4Ur0pqiCBD2v8Jk+GIYNpuzNh0z73cCDSEFvX1Xgi
         ww9GgIwKDFrVkfAUjPxelpr+1EYNDBEtoJD+8QpeqT0fQ0YEHtGAWZfLeKhY6Ry2a7+U
         mpELSzzDnFngcVD6IVf3vPoVhlWYvKQupO5zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769893154; x=1770497954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE3atSTI0e2qKZIiMDQMA6tZwWC6g1/9rqYxHc0/td0=;
        b=YnjzuiEzuWix+5H6QJIkw+BPV+fD+W8XqErhVxApXBw3XfQFSX+6JUHqTR1mu+NJq8
         687hH4SxqmzLSJ4r6UGERFgydg5GCVt6BbtyqGxNSXA/DGTgG9aFEO4acSA3DSBrAw8o
         GPuIAA5qGnwiIjAh3XP0gbfmTiTjQXLwZ775obEgO8k0rdODr7vq7h7uVw0P/Vr31r4H
         YRP3coSbu6dhvSoig+kvfpKUiIaXUEoEkDuJ++GGyknWAJXi6dakuHC30hCjLwmfLnPx
         GVQCzjLoddSOtr/H6q8zkRoU7HmjFu1diXff4lDvQN2TGAsIh8eD91h3qicupAToXH51
         X17Q==
X-Gm-Message-State: AOJu0Yw4z+oCsSiLKSBV+8/AvkGcGJlKNqWkFtljHY2W7OjrhLOBWnTb
	EjiIKhCPDRFZ1pKBXJ00egJb0TPyVIk55iLkte59qS7Bn6YhkvfWtyIS9zyIIfUg9Xde9dA8FxX
	XmrgOPl0IPikOdYkftLAwTDBr07cIhFxzQU6/O2fMr2e/H5/xEoDTviLWcQ==
X-Gm-Gg: AZuq6aLkNcuRdwkvY0cjAWOviOS4h4Hd7pf5b/Vbbmfwac8eMIme8qvYaaSUKeqT1nS
	5+vXLabg1QeYhduysNeXaoCh5pLZtUdWoWAD9oZllqIF2jDQMb2haa/anLuAgIzjnB0gSfRphld
	O3fRxuED46njQahyGvxdUfZpJowMLsfsVDjokXHRETd/sTbzA7aE9XL9mUZjU7wy9Xl45cQi3Rg
	kb/AHEGp4Tc31brU1EXTwXSIkcllF7pYlmfNmS7JMbIWYNJ7BMGXyMhzaVRZUrNw6199h0afhAw
	1/dQ4HC9SQ9D7mjhnTbrtK2e54g=
X-Received: by 2002:a05:600c:8b0a:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-482db49d43bmr81871535e9.28.1769893153825; Sat, 31 Jan 2026
 12:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20260128063648.1422-1-dev@qinc.tv> <20260128063648.1422-2-dev@qinc.tv>
In-Reply-To: <20260128063648.1422-2-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sat, 31 Jan 2026 21:59:02 +0100
X-Gm-Features: AZwV_Qg1MKlAddTmeYiUEvdCdtG6Kn4nO9_59N8P5vyv9Vfl9MB-_rsG5byQGMI
Message-ID: <CAHUKmYaU-UUJmpKnwzjjO_DP_A0WF63Ed_6fpWEQ9mMe1pPP=Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH 2/3] add recipe for libdmg-hfsplus
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="000000000000b98f900649b55c3f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 20:59:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3160

--000000000000b98f900649b55c3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! Applied as
https://git.yoctoproject.org/meta-darwin/commit/?id=3Dbc61b22dba483ddd43c9a=
012efd581e743ddc4db


=C3=89tienne

On Wed, Jan 28, 2026 at 7:37=E2=80=AFAM Eric L. Hernes via lists.yoctoproje=
ct.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> libdmg-hfsplus contains the `hfsplus` program which copies files from
> the filesystem to the .dmg image
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  .../libdmg-hfsplus/libdmg-hfsplus_git.bb         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
>
> diff --git a/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
> b/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
> new file mode 100644
> index 0000000..77ac88e
> --- /dev/null
> +++ b/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
> @@ -0,0 +1,16 @@
> +SUMMARY =3D "Utilities for manipulating macOS dmg files"
> +DESCRIPTION =3D "This is a set of utilities for manipulating macOS dmg a=
nd
> hfs files"
> +HOMEPAGE =3D "https://github.com/elhernes/libdmg-hfsplus "
> +
> +LICENSE =3D "GPL-3.0-only"
> +
> +SRC_URI =3D "git://
> github.com/elhernes/libdmg-hfsplus.git;branch=3Dmaster;protocol=3Dhttps"
> +SRCREV =3D "3c3ce87a7e2f036f771f81147f9e125a2bb207f1"
> +
> +LIC_FILES_CHKSUM =3D
> "file://${WORKDIR}/git/LICENSE;md5=3Dd32239bcb673463ab874e80d47fae504"
> +
> +S =3D "${WORKDIR}/git"
> +
> +inherit cmake
> +
> +BBCLASSEXTEND =3D "native"
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3126):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3126&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DiKG=
nzdwRLbZyGpj0w-beuZvVkxOKHPOeFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&s=3DoZ8lqaK7k=
_wEZkmswYmAzAg9nBpTbhGZpBwMQe4wHzQ&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117504011_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DiKGnzdwRLbZyG=
pj0w-beuZvVkxOKHPOeFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&s=3Doq9vuEEVu17uPtAT2n8=
u9JOnhjPalMtb1V7wX3d5pnI&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DiKGnzdwRLbZyGpj0w-beuZvVkxOKHPOeFdKM30KyhTYwjjsiGHy=
dEkbK7_OAcAo_&s=3DL5DQRi-A1fgi00El9sxBWhrfOBY1HMqZJWBhbIgV7q0&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000b98f900649b55c3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! Applied as=C2=A0<a href=
=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3Dbc61b22dba483ddd4=
3c9a012efd581e743ddc4db">https://git.yoctoproject.org/meta-darwin/commit/?i=
d=3Dbc61b22dba483ddd43c9a012efd581e743ddc4db</a>=C2=A0<br><br>=C3=89tienne<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jan 28, 2026 at 7:37=E2=80=AFAM Eric L. Hernes=
 via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &=
lt;dev=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yo=
ctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">libdmg-hfsplus contains the `hfsplus` program which copies fi=
les from<br>
the filesystem to the .dmg image<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0.../libdmg-hfsplus/<a href=3D"http://libdmg-hfsplus_git.bb" rel=3D"no=
referrer" target=3D"_blank">libdmg-hfsplus_git.bb</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 16 ++++++++++++++++<br>
=C2=A01 file changed, 16 insertions(+)<br>
=C2=A0create mode 100644 recipes-support/libdmg-hfsplus/<a href=3D"http://l=
ibdmg-hfsplus_git.bb" rel=3D"noreferrer" target=3D"_blank">libdmg-hfsplus_g=
it.bb</a><br>
<br>
diff --git a/recipes-support/libdmg-hfsplus/<a href=3D"http://libdmg-hfsplu=
s_git.bb" rel=3D"noreferrer" target=3D"_blank">libdmg-hfsplus_git.bb</a> b/=
recipes-support/libdmg-hfsplus/<a href=3D"http://libdmg-hfsplus_git.bb" rel=
=3D"noreferrer" target=3D"_blank">libdmg-hfsplus_git.bb</a><br>
new file mode 100644<br>
index 0000000..77ac88e<br>
--- /dev/null<br>
+++ b/recipes-support/libdmg-hfsplus/<a href=3D"http://libdmg-hfsplus_git.b=
b" rel=3D"noreferrer" target=3D"_blank">libdmg-hfsplus_git.bb</a><br>
@@ -0,0 +1,16 @@<br>
+SUMMARY =3D &quot;Utilities for manipulating macOS dmg files&quot;<br>
+DESCRIPTION =3D &quot;This is a set of utilities for manipulating macOS dm=
g and hfs files&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"https://github.com/elhernes/libdmg-hfsplus" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/elhernes/libdmg-hfs=
plus</a> &quot;<br>
+<br>
+LICENSE =3D &quot;GPL-3.0-only&quot;<br>
+<br>
+SRC_URI =3D &quot;git://<a href=3D"http://github.com/elhernes/libdmg-hfspl=
us.git;branch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blan=
k">github.com/elhernes/libdmg-hfsplus.git;branch=3Dmaster;protocol=3Dhttps<=
/a>&quot;<br>
+SRCREV =3D &quot;3c3ce87a7e2f036f771f81147f9e125a2bb207f1&quot;<br>
+<br>
+LIC_FILES_CHKSUM =3D &quot;file://${WORKDIR}/git/LICENSE;md5=3Dd32239bcb67=
3463ab874e80d47fae504&quot;<br>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+<br>
+inherit cmake<br>
+<br>
+BBCLASSEXTEND =3D &quot;native&quot;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3126): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3126&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DiKGnzdwRLbZyGpj0w-beuZvVkx=
OKHPOeFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&amp;s=3DoZ8lqaK7k_wEZkmswYmAzAg9nBpT=
bhGZpBwMQe4wHzQ&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3126&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Di=
KGnzdwRLbZyGpj0w-beuZvVkxOKHPOeFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&amp;s=3DoZ8=
lqaK7k_wEZkmswYmAzAg9nBpTbhGZpBwMQe4wHzQ&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117504011_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DiKGnzdwRLbZyGpj0w-beuZvVkxOKHPOeFdKM30KyhTYwjj=
siGHydEkbK7_OAcAo_&amp;s=3Doq9vuEEVu17uPtAT2n8u9JOnhjPalMtb1V7wX3d5pnI&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117504011_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DiKGnzdwRLbZyGpj0w-beuZvVkxOKHPO=
eFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&amp;s=3Doq9vuEEVu17uPtAT2n8u9JOnhjPalMtb1=
V7wX3d5pnI&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DiKGnzdwRLbZyG=
pj0w-beuZvVkxOKHPOeFdKM30KyhTYwjjsiGHydEkbK7_OAcAo_&amp;s=3DL5DQRi-A1fgi00E=
l9sxBWhrfOBY1HMqZJWBhbIgV7q0&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DiKGnzdwRLbZyGpj0w-beuZvVkxOKHPOeFdKM=
30KyhTYwjjsiGHydEkbK7_OAcAo_&amp;s=3DL5DQRi-A1fgi00El9sxBWhrfOBY1HMqZJWBhbI=
gV7q0&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000b98f900649b55c3f--

