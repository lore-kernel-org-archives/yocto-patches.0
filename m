Return-Path: <cleiton.bueno@b2open.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632DACDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 16:07:24 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.456.1782144434009595903
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 09:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@b2open-com.20251104.gappssmtp.com header.s=20251104 header.b=mh1dxUSu;
 spf=pass (domain: b2open.com, ip: 209.85.160.44, mailfrom: cleiton.bueno@b2open.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4472500e25fso1068142fac.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 09:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782144433; cv=none;
        d=google.com; s=arc-20240605;
        b=NZt2HeU70y15jXzu16VTQuPGxM/MZYbF4QUvvgrvt053j4SmUA9eFilhEADtixvwQk
         rS70ZBdjjQBzBI3qv8wZpaijhjA7bJ8mXLSg+MTLorFwvcoTSx9RsR7234esso0IUH5D
         QnCgYDlSIb1hkAHpkvMZ4YDrLIUrF9aaEUeOxF1bI7F3xz6KOXDLYmpq4b14cgQWEozG
         8+z/yw0avk21Z/DWffoYAzwlF0aZH5X657NwhBvhuQKu3dUWiqrsKaRPHCCrXD7q3TxM
         dAyTbopTI1nj0gsSWJSm4ittcRMC4YZQcVdY5Ob3Co71CXwQwQEUVP7PHncr8JCQtDtA
         8fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0eya2M09CYA3uywJAsIfR2z7Krj8cHpX3w7rWeV3vbM=;
        fh=QttiF20qQLGPeYxvS2rfsZyKkvis9WXT/gr73OA3B8g=;
        b=Z94y0ZSYyZ5Q96H8o+zR7PZwYX8TeBr0sDTWpdsxCiTsLcyWZJJwvJoSZ1SD/wPs2g
         wsBH6ti+1RyzajYOzL+fa1GAeCo6jL3iPAOUFWA9YGclK9W2v8o/0BbBzqpnnp6NQ8pU
         0hafOCHkHYeQ0PptNlGhk2vD8rT8T/klz/n75e4S9LzAm8kZ9KXHt4f/CbKrwGalc4lX
         Ym3bfi38V4f0WJ0NO2R+Nwpys8XOCpuayG6kk/0Nr8fr+vc05bpDbNe0DWWYsatzhmI2
         9cTAzcMRJdAb/9p4K8jzlSBC23LhzwFABlreyMAjEAZgeKyc6oNAIi5zpGec8fAw0Jnl
         Yplw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b2open-com.20251104.gappssmtp.com; s=20251104; t=1782144433; x=1782749233; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eya2M09CYA3uywJAsIfR2z7Krj8cHpX3w7rWeV3vbM=;
        b=mh1dxUSu+YH7xo/py5WK7JS35FleQ/ozMT3QVmC9p5pf6/1sPR/4PqKWhAkW6JtaG/
         nhs6L/J+3MgqAbtjvt4Z/g2YTMKFiFyPPLu/bz8Zb3Y5i72skOxherV1W7yJQ7XRDk9G
         U3u+7ZsD21svSaa9P2t1faetjbyKhjUU1+l322Q5dJK/D7fIIAFpM8cGW4zFsRj0P/Q6
         pefkFmOFB9MxB7Z6D8L8f6kJdXXSqb8vAhKa6ghkSx2hHhRKKQN6Gg6bQzqOZ9ADwnLZ
         i2Eu66cTMbr3ZSIea36Ww2A/5u/Xg5cCciKy5qGwj2IEr4MuHrspFo5kWb0xvb/c9PIV
         ZkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144433; x=1782749233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eya2M09CYA3uywJAsIfR2z7Krj8cHpX3w7rWeV3vbM=;
        b=XpRTk3D9H+53FIcqA9cQC3WKykvoMgt6+vr1wAP5CWDeJBCCEEbbeDbaPalyF6nPgm
         v5lmPQZneA/OKlW/hZMIjVS31nnma355dBnLlkGAvHzBR4J8Z6SEOGYkXJURzZgTiLLT
         36SKRk+o+6Lv7thayoq9fGJnABr8x0X68SkK+9Ca5KbZUy4MKrtPm0JPE2nuUdE47vcd
         3xwmjJqtLHhXME3TRRfpUUpSzwaNN7rh6eRpenXbhDYtgQtd5hftBTa4TKyMCgDeDcJn
         AES9eHcBkj73jTI2tDnbhNbMGwT5WUKBBLIQ8bDIRWw69TvehF6gcxf8sIinpp0a/Tfz
         u4sw==
X-Gm-Message-State: AOJu0YwuZ8/JBQLeVyKMdKgqelB2NUkN5m1BdJWkl0k5KIfNXPG1qLXg
	TSN60XAl5grrbvHZPDA96xie7C6xdgnWWkY0jzcemtkI72eFCb+/TyWSB4gh16bIE4FAtsizY8W
	8ADcKy5ykguW9HQMtD7A4YS3LXcmZtgFuC4N58hjjBQ==
X-Gm-Gg: AfdE7ckCmD5qb6zyGMAf7bAR3FUbHR1Ej2SoqsDNGMs5npkhIf0/A2fn5cKeIofjHlB
	uTp812Bai40KbU1qTQX8iMpEDC0cs3QeLCLPWK93/EdoTVVM6IX3iNp4avJH+9y4sWQlnTBreDI
	Jp3B1ccZ4BYAcelzoHGHJHgqMD2qwgjFv+rCBPZ8WefgXn3dCVGNAszGtTJ4rSfW9vbQooVtjt5
	nOyWs/w4qJpd4trJPyxWt+0VeDtrJ77mkwnpGsJj2wCblfRaRrSc/Xkf6qnWB0nY8i7pQu7qDZi
	8dMTryObXlfqxcszyZZK/cpNKHgBWYxIVFzu9BfJHQur4/L8lUPnNG7OLQQARYeR/Mll4GrGJiJ
	12v+IVTVJ5UBktTZ4Vq/0fCbCFhQwJq//xbSuNR+lLZb2bzVguBL6Kw3PlQ==
X-Received: by 2002:a05:6830:f8b:b0:7e6:e349:539a with SMTP id
 46e09a7af769-7e92d9187c0mr12738635a34.21.1782144432906; Mon, 22 Jun 2026
 09:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260622134626.3616736-1-cleiton.bueno@b2open.com> <9edde087-11b6-4377-b74e-7637883c0d52@cherry.de>
In-Reply-To: <9edde087-11b6-4377-b74e-7637883c0d52@cherry.de>
From: Cleiton Bueno <cleiton.bueno@b2open.com>
Date: Mon, 22 Jun 2026 13:06:36 -0300
X-Gm-Features: AVVi8CfANj75XpsRuW41JA2ixGaxyBqFN4lAIiNmDFdQn9D7iRPuVtF-TAZW0_U
Message-ID: <CAA-i2LwP13YUZ8cnN7G8h3XuYESC36PPHSyvnTp6Oyd+PnXA7g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] u-boot: fix incorrect
 commit reference (radxa-zero-3)
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000dcb5120654d9d5a0"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 16:07:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4259

--000000000000dcb5120654d9d5a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood!

I'll move u-boot upstream and test it. If it works, I'll send a patch with
this modification to radxa-zero-3w as soon as it's working.

Em seg., 22 de jun. de 2026 =C3=A0s 13:00, Quentin Schulz <
quentin.schulz@cherry.de> escreveu:

> Hi Cleiton,
>
> On 6/22/26 3:46 PM, Cleiton Bueno via lists.yoctoproject.org wrote:
> > [You don't often get email from cleiton.bueno=3D
> b2open.com@lists.yoctoproject.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
> >
> > The commit 8cdf606 is incorrect and does not belong to any
> > branch on this repository, it may belong to a fork outside of
> > the repository. The correct commit should be:
> > 2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
> >
> > Signed-off-by: Cleiton Bueno <cleiton.bueno@b2open.com>
> > ---
> >   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend
> b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index c939a48..9432e2b 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
> >   FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> >
> >   SRC_URI:radxa-zero-3 =3D "git://
> github.com/Kwiboo/u-boot-rockchip.git;protocol=3Dhttps;branch=3Drk3xxx-20=
24.07;name=3DKwiboo
> "
> > -SRCREV:radxa-zero-3 =3D "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > -SRCREV:radxa-zero-3:rk-u-boot-env =3D
> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > +SRCREV:radxa-zero-3 =3D "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> > +SRCREV:radxa-zero-3:rk-u-boot-env =3D
> "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> >
>
> This code doesn't exist anymore since Walnascar, on which branch of
> meta-rockchip are you building?
>
> If it's for scarthgap/styhead, I think it'd make more sense to add
> upstream 2024.10 (or later) U-Boot recipe since the board is supported
> starting that version.
>
> Jonas (Kwiboo) is the sole owner of that repo and may freely decide to
> rebase branches or delete them, so we should really aim at not using it.
>
> Cheers,
> Quentin
>


--

--000000000000dcb5120654d9d5a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Understood!<br><br>I&#39;ll move u-boot upstream and test =
it. If it works, I&#39;ll send a patch with this modification to radxa-zero=
-3w as soon as it&#39;s working.</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">Em seg., 22 de jun. d=
e 2026 =C3=A0s 13:00, Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@c=
herry.de">quentin.schulz@cherry.de</a>&gt; escreveu:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Cleiton,<br>
<br>
On 6/22/26 3:46 PM, Cleiton Bueno via <a href=3D"http://lists.yoctoproject.=
org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a> wrote:=
<br>
&gt; [You don&#39;t often get email from cleiton.bueno=3D<a href=3D"mailto:=
b2open.com@lists.yoctoproject.org" target=3D"_blank">b2open.com@lists.yocto=
project.org</a>. Learn why this is important at <a href=3D"https://aka.ms/L=
earnAboutSenderIdentification" rel=3D"noreferrer" target=3D"_blank">https:/=
/aka.ms/LearnAboutSenderIdentification</a> ]<br>
&gt; <br>
&gt; The commit 8cdf606 is incorrect and does not belong to any<br>
&gt; branch on this repository, it may belong to a fork outside of<br>
&gt; the repository. The correct commit should be:<br>
&gt; 2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead<br>
&gt; <br>
&gt; Signed-off-by: Cleiton Bueno &lt;<a href=3D"mailto:cleiton.bueno@b2ope=
n.com" target=3D"_blank">cleiton.bueno@b2open.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot=
/u-boot_%.bbappend<br>
&gt; index c939a48..9432e2b 100644<br>
&gt; --- a/recipes-bsp/u-boot/u-boot_%.bbappend<br>
&gt; +++ b/recipes-bsp/u-boot/u-boot_%.bbappend<br>
&gt; @@ -3,8 +3,8 @@ require u-boot-rockchip.inc<br>
&gt;=C2=A0 =C2=A0FILESEXTRAPATHS:prepend :=3D &quot;${THISDIR}/files:&quot;=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0SRC_URI:radxa-zero-3 =3D &quot;git://<a href=3D"http://git=
hub.com/Kwiboo/u-boot-rockchip.git;protocol=3Dhttps;branch=3Drk3xxx-2024.07=
;name=3DKwiboo" rel=3D"noreferrer" target=3D"_blank">github.com/Kwiboo/u-bo=
ot-rockchip.git;protocol=3Dhttps;branch=3Drk3xxx-2024.07;name=3DKwiboo</a>&=
quot;<br>
&gt; -SRCREV:radxa-zero-3 =3D &quot;8cdf606e616baa36751f3b4adcfaefc781126c8=
c&quot;<br>
&gt; -SRCREV:radxa-zero-3:rk-u-boot-env =3D &quot;8cdf606e616baa36751f3b4ad=
cfaefc781126c8c&quot;<br>
&gt; +SRCREV:radxa-zero-3 =3D &quot;2e2ae1fb69a25217640bfe2fb9abaf9f4fbacea=
d&quot;<br>
&gt; +SRCREV:radxa-zero-3:rk-u-boot-env =3D &quot;2e2ae1fb69a25217640bfe2fb=
9abaf9f4fbacead&quot;<br>
&gt; <br>
<br>
This code doesn&#39;t exist anymore since Walnascar, on which branch of <br=
>
meta-rockchip are you building?<br>
<br>
If it&#39;s for scarthgap/styhead, I think it&#39;d make more sense to add =
<br>
upstream 2024.10 (or later) U-Boot recipe since the board is supported <br>
starting that version.<br>
<br>
Jonas (Kwiboo) is the sole owner of that repo and may freely decide to <br>
rebase branches or delete them, so we should really aim at not using it.<br=
>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><img src=3D"https://ci3.googleusercontent.com/ma=
il-sig/AIorK4z-FDqneUytZeCMahhNKdzPOXCuRDUt42pGJKhGciWkdWJH3c_fneMTAdyi0Mza=
_TEs4Av1U7gXpijA"><br></div></div>

--000000000000dcb5120654d9d5a0--

