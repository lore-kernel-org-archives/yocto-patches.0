Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD0C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 07:22:19 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.9911.1721287330793946208
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jul 2024 00:22:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=UedqDjPx;
 spf=pass (domain: mvista.com, ip: 209.85.208.170, mailfrom: vanusuri@mvista.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so7644951fa.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jul 2024 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1721287329; x=1721892129; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUGsBZ1h6BUDp9tm+OpSlxypNuVkcADh8hm9Z7T7tbM=;
        b=UedqDjPxibxcGspilD9DhMDfL8wAZfus+h/l9yR0zJ/4BKEiKSAYEPqSWW+dSqLWvM
         4rQHTrKGyQVcdmtHeuL8ngm/dOHbGz/xJXfBg/X2CnhtVIoroS5hZMsDpn5aRAm7cJqO
         c3QhTOFLRgQFeXtmoOvc11HRRiOhNZ+zSUMT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721287329; x=1721892129;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUGsBZ1h6BUDp9tm+OpSlxypNuVkcADh8hm9Z7T7tbM=;
        b=SH8E7JB+6UfeI1byJJZ/B2HAlsyqqu4MNUeMTYZsgdAK5xT8QYplkh/gzdErRELLno
         h0N8zvJT/CWaC2TvQ/O0aopaSFvzS8pjnIrAjEdk2q6on1hS7Rz+6ez6kS9Yir8kMJe9
         dKcDx2c1XulTP9oaqu9eafd3lPFduIZs2L0HIKeVPlhcHkC8e5VYZ4akgx4tco9WWJBX
         T5Fw+lxPgL3q4sKP9InAR+H7WzCP79perX4iKVJOGrOomTzm397ja1C+6gscvank8jLU
         RZbHzhfO7kETgsnoBDuo4Hg/Bthn2QqEvAFRasjiAVUZPqclXcqozk0JzKyMVwU72mxi
         Z5qQ==
X-Gm-Message-State: AOJu0YxaoDrfMU4sIjGwFWyxR/hEOsPiWUiJoWNahNEDLJ7kcxZczcFx
	m9lLnwi6+At9qdkIzB5i17Tczu5EitZOxe7Sj7vB5VdD6JTYESltxtID3DR335844M+wBVgiEhs
	r/J0z4m4eKGAbtQTNhGKUDqiMDmJ1s+fAjyOdrymjyXe8kFJJZSU=
X-Google-Smtp-Source: AGHT+IF2qGqtvXyz3oAL8R94NwKNcMBMy59/mPlU45tM509+G143f9oV4MRThKftVhe/uU/R8llEN8jfq+2qNo35rEE=
X-Received: by 2002:a2e:914d:0:b0:2ec:5fa1:2434 with SMTP id
 38308e7fff4ca-2ef05c524femr9905651fa.9.1721287328373; Thu, 18 Jul 2024
 00:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240702064949.1631187-1-vanusuri@mvista.com>
In-Reply-To: <20240702064949.1631187-1-vanusuri@mvista.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Thu, 18 Jul 2024 12:51:56 +0530
Message-ID: <CANQUz18O_TB_qMyA0pWgnseDqKs1TOTCRtDmqiomKMF_cW8-GQ@mail.gmail.com>
Subject: Re: [meta-security][master][PATCH] tpm2-tools: Upgrade 5.5 -> 5.7
To: yocto-patches@lists.yoctoproject.org, Armin Kuster <akuster808@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c3b342061d806f44"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jul 2024 07:22:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/442

--000000000000c3b342061d806f44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Armin,

Any update on this?

Thanks & Regards,
Vijay

On Tue, Jul 2, 2024 at 12:20=E2=80=AFPM <vanusuri@mvista.com> wrote:

> From: Vijay Anusuri <vanusuri@mvista.com>
>
> Include Security fixes:
> Fixed CVE-2024-29038
> Fixed CVE-2024-29039
>
> Changelog:
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6
>
> Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> ---
>  .../tpm2-tools/{tpm2-tools_5.5.bb =3D> tpm2-tools_5.7.bb}         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.5.bb =3D>
> tpm2-tools_5.7.bb} (83%)
>
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
> b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> similarity index 83%
> rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
> rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> index 9bad758..bb422cf 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> @@ -8,7 +8,7 @@ DEPENDS =3D "tpm2-tss openssl curl"
>
>  SRC_URI =3D "
> https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${=
PV}.tar.gz
> "
>
> -SRC_URI[sha256sum] =3D
> "1fdb49c730537bfdaed088884881a61e3bfd121e957ec0bdceeec0261236c123"
> +SRC_URI[sha256sum] =3D
> "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
>
>  UPSTREAM_CHECK_URI =3D "https://github.com/tpm2-software/${BPN}/releases=
"
>
> --
> 2.25.1
>
>

--000000000000c3b342061d806f44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Armin,<br><br></div><div>Any update on this?</div>=
<div><br></div><div>Thanks &amp; Regards,</div><div>Vijay<br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Jul 2, 2024 at 12:20=E2=80=AFPM &lt;<a href=3D"mailto:vanusuri@mvista.com">=
vanusuri@mvista.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvist=
a.com" target=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
<br>
Include Security fixes:<br>
Fixed CVE-2024-29038<br>
Fixed CVE-2024-29039<br>
<br>
Changelog:<br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.7</a><br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.6</a><br>
<br>
Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" tar=
get=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
---<br>
=C2=A0.../tpm2-tools/{<a href=3D"http://tpm2-tools_5.5.bb" rel=3D"noreferre=
r" target=3D"_blank">tpm2-tools_5.5.bb</a> =3D&gt; <a href=3D"http://tpm2-t=
ools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a>}=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename meta-tpm/recipes-tpm2/tpm2-tools/{<a href=3D"http://tpm2-tools=
_5.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a> =3D&gt;=
 <a href=3D"http://tpm2-tools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">=
tpm2-tools_5.7.bb</a>} (83%)<br>
<br>
diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_=
5.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a> b/meta-t=
pm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
similarity index 83%<br>
rename from meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5=
.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a><br>
rename to meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7=
.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
index 9bad758..bb422cf 100644<br>
--- a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.5.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a><br>
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
@@ -8,7 +8,7 @@ DEPENDS =3D &quot;tpm2-tss openssl curl&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://github.com/tpm2-software/$%7BBPN=
%7D/releases/download/$%7BPV%7D/$%7BBPN%7D-$%7BPV%7D.tar.gz" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/tpm2-software/${BPN}/releases/dow=
nload/${PV}/${BPN}-${PV}.tar.gz</a>&quot;<br>
<br>
-SRC_URI[sha256sum] =3D &quot;1fdb49c730537bfdaed088884881a61e3bfd121e957ec=
0bdceeec0261236c123&quot;<br>
+SRC_URI[sha256sum] =3D &quot;3810d36b5079256f4f2f7ce552e22213d43b1031c1315=
38df8a2dbc3c570983a&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://github.com/tpm2-softw=
are/$%7BBPN%7D/releases" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/tpm2-software/${BPN}/releases</a>&quot;<br>
<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000c3b342061d806f44--

