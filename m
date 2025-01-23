Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A23C0218B
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 21:41:35 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.23117.1737668488376273975
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Jan 2025 13:41:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=czkQzk8k;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.175, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30227c56b11so12457241fa.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Jan 2025 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737668486; x=1738273286; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhoc5bC55JAG4LUnPqkONVNMTfcQmzqY9dU8Bbn+gb0=;
        b=czkQzk8kI/6k019UQLKvmD+0Z05z+TiQWogAFItlWqF3HWdyyAKjEke/8XZBJy7lYi
         9tzM8917PKjWoVcFQ37gLUEPdATF/QfjOAlOYhB1WJqYon5j50VE06kWOCcDa4RmYLM4
         /LwB85G9GlcwNjyBFvUjZAXYuUXALsSMeCpHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737668486; x=1738273286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhoc5bC55JAG4LUnPqkONVNMTfcQmzqY9dU8Bbn+gb0=;
        b=XaIhzyF5R9RBd3BoDtupnjSJvdCANCxwDQIgKiX45z6scJ4PmR5UZOxYezgrdcA5IX
         uOVdRwWVFzzhKTkAVGYuG7FSrO4TQzwGnQN2FKPW+OsPqApM+pb+ZD7Jhwhn2za7pA2R
         DNpnlQAMI4UNq/PPyXnIqz5V4D2Dc2vfdnVZDXlOrwb9fGHH8O2nHDQlK64k+UmkwpM6
         wInapwlFdvfRddVQgOv64kemZrzjxlwQkA6/5+RBfP0LQQya5hasWjKyD0Yswk0RmHG2
         IKZnC3Y2MGGoiKTTIV7ZnDzUQCNGMQ4ln48i0FoTOnBvbZhkzLsCmLBOldiozCoxlkzI
         +o7w==
X-Gm-Message-State: AOJu0Ywca5zxOf0RgRT4w+vssYTMZPj9ptxXhSAiFTj0/Fhdm2+0CAIY
	Mq9+4+CNA85AJvCWr+VMFiv9e+pO7VdODlcATrPskhcVYcZ9X7t9wO/N7vi20SQR+TQZqPItgqP
	9Nr0/qkDvlBbprlt6IaDS+yHhxdbL5w74fAhe5g==
X-Gm-Gg: ASbGnctt1YAChpru5y1QEnPHt/GfU9HZECJXMIv/mcrL0eHmsZumNW+vnKVZziSDJeJ
	8UZMT1Aoyq68VvgNn0mqo27BTNbjQNzVz522WWR1w+dhFCjPaUWuNjSGn3NUlB52VAVnRFFcl0u
	N3lP+CPEoTI0V0/lDDT8F+
X-Google-Smtp-Source: AGHT+IHWBMAUIEclo158mJM5WjAzMaPDoqFTeLrY6Lpdz/lQfJogqQPWS+6lAQq1qMWnwkiwEp9SACvA3TFf2qEnr5g=
X-Received: by 2002:a05:651c:888:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-3072caa1681mr108256091fa.22.1737668486421; Thu, 23 Jan 2025
 13:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20250123-update-release-parser-v1-1-95a165ab36ed@bootlin.com>
In-Reply-To: <20250123-update-release-parser-v1-1-95a165ab36ed@bootlin.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Thu, 23 Jan 2025 11:41:13 -1000
X-Gm-Features: AWEUYZkri5FHpSmQNTXJQlKLFlrpbyzvUzG400ye3tj7opHfcq06dm3OE4FjeAA
Message-ID: <CADfgfobG5D2_D+MZzFkwX2yHu4ukLcbBRhHBwG_o=buxDSOnFQ@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper PATCH] scripts/release-parser.py: merge
 full list with previous list
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: yocto-patches@lists.yoctoproject.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: multipart/alternative; boundary="000000000000def0fd062c6678bc"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Jan 2025 21:41:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1006

--000000000000def0fd062c6678bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and deployed. Now working on hiding the Full Releases section now.

On Thu, Jan 23, 2025 at 6:33=E2=80=AFAM Antonin Godard <antonin.godard@boot=
lin.com>
wrote:

> On https://www.yoctoproject.org/development/releases, the "Full Release
> List" can mislead users into thinking the list represents all of the
> Yocto release, whereas these are only EOL releases. Remove this list and
> merge everything in "Previous Release List".
>
> [YOCTO #15339]
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Note: I'm not sure if this will remove the "Full Release List" section
> title and how I can verify this.
> ---
>  scripts/release-parser.py | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/scripts/release-parser.py b/scripts/release-parser.py
> index
> 96b9d5ef416c16d348459bc4ce74e16abdc6a33a..321bd582be4f927d5f23c396cf41a6d=
81d7f7d78
> 100755
> --- a/scripts/release-parser.py
> +++ b/scripts/release-parser.py
> @@ -120,14 +120,9 @@ tags.append(
>
>  tags.reverse()
>
> -previous_release_series =3D 3
>  for tag in tags:
>      if tag["status"] =3D=3D "EOL":
> -        if previous_release_series > 0:
> -            tag["series"] =3D "previous"
> -            previous_release_series -=3D 1
> -        else:
> -            tag["series"] =3D "full"
> +        tag["series"] =3D "previous"
>      else:
>          tag["series"] =3D "current"
>
>
> ---
> base-commit: 384d37a957a7f90abe04fe320cf0919c5a8f22ef
> change-id: 20250123-update-release-parser-4dfbbec54485
>
> Best regards,
> --
> Antonin Godard <antonin.godard@bootlin.com>
>
>

--=20
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000def0fd062c6678bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged and deployed. Now working on hiding the Full Releas=
es section now.</div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2025 at 6:33=E2=80=AFA=
M Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.com">antonin.=
godard@bootlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On <a href=3D"https://www.yoctoproject.org/development/re=
leases" rel=3D"noreferrer" target=3D"_blank">https://www.yoctoproject.org/d=
evelopment/releases</a>, the &quot;Full Release<br>
List&quot; can mislead users into thinking the list represents all of the<b=
r>
Yocto release, whereas these are only EOL releases. Remove this list and<br=
>
merge everything in &quot;Previous Release List&quot;.<br>
<br>
[YOCTO #15339]<br>
<br>
Signed-off-by: Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.=
com" target=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
---<br>
Note: I&#39;m not sure if this will remove the &quot;Full Release List&quot=
; section<br>
title and how I can verify this.<br>
---<br>
=C2=A0scripts/release-parser.py | 7 +------<br>
=C2=A01 file changed, 1 insertion(+), 6 deletions(-)<br>
<br>
diff --git a/scripts/release-parser.py b/scripts/release-parser.py<br>
index 96b9d5ef416c16d348459bc4ce74e16abdc6a33a..321bd582be4f927d5f23c396cf4=
1a6d81d7f7d78 100755<br>
--- a/scripts/release-parser.py<br>
+++ b/scripts/release-parser.py<br>
@@ -120,14 +120,9 @@ tags.append(<br>
<br>
=C2=A0tags.reverse()<br>
<br>
-previous_release_series =3D 3<br>
=C2=A0for tag in tags:<br>
=C2=A0 =C2=A0 =C2=A0if tag[&quot;status&quot;] =3D=3D &quot;EOL&quot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if previous_release_series &gt; 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag[&quot;series&quot;] =3D &quo=
t;previous&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 previous_release_series -=3D 1<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag[&quot;series&quot;] =3D &quo=
t;full&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tag[&quot;series&quot;] =3D &quot;previous&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tag[&quot;series&quot;] =3D &quot;current=
&quot;<br>
<br>
<br>
---<br>
base-commit: 384d37a957a7f90abe04fe320cf0919c5a8f22ef<br>
change-id: 20250123-update-release-parser-4dfbbec54485<br>
<br>
Best regards,<br>
-- <br>
Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.com" target=3D"=
_blank">antonin.godard@bootlin.com</a>&gt;<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Michael Halstead<div>Linux Foundation / Yocto Pr=
oject</div><div>Systems Operations Engineer</div></div></div>

--000000000000def0fd062c6678bc--

