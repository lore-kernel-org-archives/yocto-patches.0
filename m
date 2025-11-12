Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD6CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:44:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8253.1762933486836782205
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 23:44:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nsBcFhy5;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: samuli.piippo@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b72134a5125so83024666b.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 23:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762933485; x=1763538285; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7KyjUXM+LaCKRjMv80P3odp//8kMcjerpP/nPWqqfc=;
        b=nsBcFhy5KDdwfg5jd01o7yvHsALYsdpxTZaer4bkzJHUnQY7G2Pt7oY6Mc8WqAlrd7
         yoaQbN2aZlvDpbYbsaPP+0wsXGFji3uwUuvu7hZ0n0dUeXBEkhJOs/A+TpOCpvaytcxl
         3ndGyoFO6dpyOE5bKyny4Rnp5I6giCjhvG9zHxToA2EFR+krQj+ZoDZgqiY8xfKma6r+
         aZdUPe4EAm/3TPdkTVJeysrUqO4mX/GWn7VVtJ/xvCUlhc/iS6zPZwUa2XzufCP4vQ+C
         UDeXHHfER34Hx+vltdDbFoF2G8Lt3q/kzN3daDbe1wwKSHBXJN4MiOBAIaZQtTZ3Jhp4
         RIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933485; x=1763538285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7KyjUXM+LaCKRjMv80P3odp//8kMcjerpP/nPWqqfc=;
        b=SQKUcbW6LC6Y4S6TCvgZoJVp9lZNGQHu1x28hVrCBzGpzEzofOTgznOeFhUkPg4BoU
         Oz/VzBjQ6shDh2NFa+KyaZO2p0E28VM0MaR/VjTP5Eifo2f8966fcNWcPnYXsGSE64Nh
         4nkHvcT18nbzUAwkf+6x2JXQCd1h2V9cKcCPLNl4EcXiCQAVuhFqD4uMNN2pd1Frm2HX
         GV7HgPd/YSNKR2S9rTCqLHSYu5XJkEiBp/ryi/HNH6uUUG5ebep0Vx9wLi/pziFr7Hhz
         gLdf+j6lu8sP8JS9/3wUwVD8C4kZ58yoHOyEU2YP7BA2BBAGzXhaPSEcSpVZ1nXsufIt
         XSaQ==
X-Gm-Message-State: AOJu0YxbmjdusGGVVyx7PzegsD+/T40hWNlOu7P/yX8l2MpocNFsnXiB
	RB1Ng8KPCuxhpqfzLORZ3dxEjxf2KTPnrixEPXTM1sAqlt91E8+PGsL+l0FJXFcEv9K98BwE4Xa
	jE6iuBU4JLgPnDEFty2dFpwElvHHA3i2iPA==
X-Gm-Gg: ASbGncuOBmwjldhrnMpBA/eVE7g1lVVJoLeyZKgUqFFMPV7wxbrD8pDbhOmyJDH6tjv
	a+5/AoCZEy5N3Nz7xLItEUxg4XIiqep7xCGkRTOhrFYUbUri+gGdxdTOpVsgwPIPY7z+vp9aRFx
	MsRRhnFNOV+9d8iQ9uu6C+jObaulbh+W7UvEkZXAP26JJMlD6fYw3Y2namNbg/Ol/ucVsHLUy6r
	kzN5K6kPbs7yoLzTRGN2F+wSg7W+EqmjJIex7tuORly4+DMXZ+BAuU3iV4=
X-Google-Smtp-Source: AGHT+IHR4orcd6w6ul55t+MoksrFMd14BOW9Ygq2CF+RLJ+uKjviK7CEVDSyV54JzPceGJloUkDJIyOYhhSIzInddvo=
X-Received: by 2002:a17:906:730a:b0:b54:7778:c62d with SMTP id
 a640c23a62f3a-b733197ecf5mr193280266b.15.1762933484784; Tue, 11 Nov 2025
 23:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20250820065756.1295786-1-samuli.piippo@qt.io>
In-Reply-To: <20250820065756.1295786-1-samuli.piippo@qt.io>
From: Samuli Piippo <samuli.piippo@gmail.com>
Date: Wed, 12 Nov 2025 09:44:33 +0200
X-Gm-Features: AWmQ_bmTShzaHFUkpcLbJU51_SZdZZ3X1nWe_NV79_638Kf1FhTb6Ux1pw1jQ2M
Message-ID: <CABXoSoUd7qmCp4p+5-cCy-E0FZ0XoKotF_pP4vBgnHH_uasyKg@mail.gmail.com>
Subject: Re: [meta-mingw] [PATCH] mingw-w64: use correct path to license file
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Content-Type: multipart/alternative; boundary="0000000000001f91b3064360f038"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:44:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2491

--0000000000001f91b3064360f038
Content-Type: text/plain; charset="UTF-8"

The yocto autobuilder doesn't seem to catch this error as the builds pass
with the patch still in master-next.
Should there be some improvement on the autobuilder scripts as well?

-samuli

On Wed, 20 Aug 2025 at 09:58, Samuli Piippo <samuli.piippo@gmail.com> wrote:

> Amend b7ac9777ad0c4512f1a63aa6bec4ecedd91783e1 and use UNPACKDIR
> also for the license file.
>
> Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
> ---
>  recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc
> b/recipes-devtools/mingw-w64/mingw-w64.inc
> index 97315f4..a24e96c 100644
> --- a/recipes-devtools/mingw-w64/mingw-w64.inc
> +++ b/recipes-devtools/mingw-w64/mingw-w64.inc
> @@ -1,5 +1,5 @@
>  LICENSE = "ZPL-2.1"
> -LIC_FILES_CHKSUM =
> "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
> +LIC_FILES_CHKSUM =
> "file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
>
>  COMPATIBLE_HOST = ".*-mingw.*"
>
> --
> 2.43.0
>
>

--0000000000001f91b3064360f038
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The yocto autobuilder doesn&#39;t seem to catch this =
error as the builds pass with the patch still in master-next.</div><div>Sho=
uld there be some improvement on the=C2=A0autobuilder scripts as well?</div=
><div><br></div><div>-samuli</div></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 20 Aug 2025=
 at 09:58, Samuli Piippo &lt;<a href=3D"mailto:samuli.piippo@gmail.com">sam=
uli.piippo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Amend b7ac9777ad0c4512f1a63aa6bec4ecedd91783e1 and use =
UNPACKDIR<br>
also for the license file.<br>
<br>
Signed-off-by: Samuli Piippo &lt;<a href=3D"mailto:samuli.piippo@qt.io" tar=
get=3D"_blank">samuli.piippo@qt.io</a>&gt;<br>
---<br>
=C2=A0recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mi=
ngw-w64/mingw-w64.inc<br>
index 97315f4..a24e96c 100644<br>
--- a/recipes-devtools/mingw-w64/mingw-w64.inc<br>
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc<br>
@@ -1,5 +1,5 @@<br>
=C2=A0LICENSE =3D &quot;ZPL-2.1&quot;<br>
-LIC_FILES_CHKSUM =3D &quot;file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=
=3Dbb936f0e04d8f1e19ad545100cee9654&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md=
5=3Dbb936f0e04d8f1e19ad545100cee9654&quot;<br>
<br>
=C2=A0COMPATIBLE_HOST =3D &quot;.*-mingw.*&quot;<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000001f91b3064360f038--

