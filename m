Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3AD11702
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 06:26:55 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.6059.1729837612150205562
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 23:26:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=V+t0pyNg;
 spf=pass (domain: mvista.com, ip: 209.85.208.181, mailfrom: vanusuri@mvista.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51f39394so17696621fa.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 23:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1729837610; x=1730442410; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auRVYVNcD44Md3G8PSjjxpZZ/6ycfwE2akBAvmjfhhY=;
        b=V+t0pyNgQobF+ZbGZYhjNH8j8oBgUUNsPiZGdzELWfaa/jxHjigmGIAmKYGFpRwaeu
         rwXX5h5xJwLKjO3B2FuvFdCsO5DyvcypZhSl9Lxm7aPH/79Lp9kDn3W4H3u6V8RaIRKs
         VSFZ3ykBgF2AkoZuiSrqTkPmd6tlQLtznSXaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837610; x=1730442410;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auRVYVNcD44Md3G8PSjjxpZZ/6ycfwE2akBAvmjfhhY=;
        b=IYltLoZQmkCiE3U17b40zZ9Ep+mz3P1BXZldDKiuq+jWau1QiBldtpq7/RHVKe/7Nx
         ugXHtE6LMTr0l5JcSsJuqFLWJQAsY8o1JhiYUJsnKtdOUMJCXMpmr8ILjsmjujrfgSiJ
         jKd36+cVmxBCuj1h3DMFoWQcymPLLiNBg/RnAG4lJv8zdxfZGy6XrhEoaBqPnYT4y3Fo
         etSszFTlGLmwymwTGD/ppaTKHlozqyIPEnj6QpegnlHDJ5s9JUvixPUEcTvzx/xwR4u4
         FGRT+tYgJm6CjUQQw0F30vLQcYbQIrje7g34MzNnuj5zuqUDz2vnsYIj9dcZxYlU5o6G
         vgjA==
X-Gm-Message-State: AOJu0YzHVRt41S50VHVGlmJtmolkSFqPTZcIjxhJQF9sW3Nc2utcSXbV
	xFNwTXtdy9GSS0Kl8z5K8dMxEmfVUBTsLf0eEe9vYPyOw8uuMTyCnmlnu59K6B/k9Zcqyg0pJtP
	pnYcZ6oGOI+NbZZbxNoXwPBR5MRhiRjwDsa7K8UMRk0iVz5ukANk=
X-Google-Smtp-Source: AGHT+IGmVxmAZgJptaIaM1rz+e/Mq4f6FFZk1PEeNEpBk+iJx1IffexGf/FhLhoL5ySWLUbMY0bG665n2FM4RTmyOdI=
X-Received: by 2002:a05:651c:211a:b0:2fb:5f9d:c284 with SMTP id
 38308e7fff4ca-2fca820b3d8mr28150011fa.16.1729837609630; Thu, 24 Oct 2024
 23:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240909125857.6639-1-vanusuri@mvista.com>
In-Reply-To: <20240909125857.6639-1-vanusuri@mvista.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Fri, 25 Oct 2024 11:56:37 +0530
Message-ID: <CANQUz18qSWH9OzXxs6_bxUvpiHk1FkfN2jcLgRXn6q3m1DVEdA@mail.gmail.com>
Subject: Re: [meta-security][kirkstone][PATCH] tpm2-tools: Upgrade 5.2 -> 5.7
To: yocto-patches@lists.yoctoproject.org, Armin Kuster <akuster808@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003ddb8706254734e2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 06:26:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/747

--0000000000003ddb8706254734e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Gentle Reminder ...!!!

Any Update on this ?

Thanks & Regards,
Vijay

On Mon, Sep 9, 2024 at 6:29=E2=80=AFPM <vanusuri@mvista.com> wrote:

> From: Vijay Anusuri <vanusuri@mvista.com>
>
> Include Security fixes:
> Fixed CVE-2024-29038
> Fixed CVE-2024-29039
>
> Changelog:
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.5
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.4
> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.3
>
> Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> ---
>  .../tpm2-tools/{tpm2-tools_5.2.bb =3D> tpm2-tools_5.7.bb}  | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>  rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.2.bb =3D>
> tpm2-tools_5.7.bb} (51%)
>
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb
> b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> similarity index 51%
> rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb
> rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> index c20af7e..bd3d34b 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.2.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> @@ -1,21 +1,16 @@
>  SUMMARY =3D "Tools for TPM2."
>  DESCRIPTION =3D "tpm2-tools"
>  LICENSE =3D "BSD-3-Clause"
> -LIC_FILES_CHKSUM =3D
> "file://doc/LICENSE;md5=3Da846608d090aa64494c45fc147cc12e3"
> +LIC_FILES_CHKSUM =3D
> "file://docs/LICENSE;md5=3Da846608d090aa64494c45fc147cc12e3"
>  SECTION =3D "tpm"
>
>  DEPENDS =3D "tpm2-abrmd tpm2-tss openssl curl autoconf-archive"
>
>  SRC_URI =3D "
> https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${=
PV}.tar.gz
> "
>
> -SRC_URI[sha256sum] =3D
> "c0b402f6a7b3456e8eb2445211e2d41c46c7e769e05fe4d8909ff64119f7a630"
> +SRC_URI[sha256sum] =3D
> "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
>
>  inherit autotools pkgconfig bash-completion
>
> -do_configure:prepend() {
> -    # do not extract the version number from git
> -    sed -i -e 's/m4_esyscmd_s(\[git describe --tags --always
> --dirty\])/${PV}/' ${S}/configure.ac
> -}
> -
>  # need tss-esys
>  RDEPENDS:${PN} =3D "libtss2 tpm2-abrmd"
> --
> 2.25.1
>
>

--0000000000003ddb8706254734e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Team,<br><br></div>Gentle Reminder ...!!=
!<br><br></div>Any Update on this ?<br><br></div><div>Thanks &amp; Regards,=
</div><div>Vijay<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Sep 9, 2024 at 6:29=E2=80=AFPM &lt;<a hre=
f=3D"mailto:vanusuri@mvista.com">vanusuri@mvista.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">From: Vijay Anusuri &lt=
;<a href=3D"mailto:vanusuri@mvista.com" target=3D"_blank">vanusuri@mvista.c=
om</a>&gt;<br>
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
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.5" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.5</a><br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.4" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.4</a><br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.3" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.3</a><br>
<br>
Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" tar=
get=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
---<br>
=C2=A0.../tpm2-tools/{<a href=3D"http://tpm2-tools_5.2.bb" rel=3D"noreferre=
r" target=3D"_blank">tpm2-tools_5.2.bb</a> =3D&gt; <a href=3D"http://tpm2-t=
ools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a>}=C2=
=A0 | 9 ++-------<br>
=C2=A01 file changed, 2 insertions(+), 7 deletions(-)<br>
=C2=A0rename meta-tpm/recipes-tpm2/tpm2-tools/{<a href=3D"http://tpm2-tools=
_5.2.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.2.bb</a> =3D&gt;=
 <a href=3D"http://tpm2-tools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">=
tpm2-tools_5.7.bb</a>} (51%)<br>
<br>
diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_=
5.2.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.2.bb</a> b/meta-t=
pm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
similarity index 51%<br>
rename from meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5=
.2.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.2.bb</a><br>
rename to meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7=
.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
index c20af7e..bd3d34b 100644<br>
--- a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.2.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.2.bb</a><br>
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
@@ -1,21 +1,16 @@<br>
=C2=A0SUMMARY =3D &quot;Tools for TPM2.&quot;<br>
=C2=A0DESCRIPTION =3D &quot;tpm2-tools&quot;<br>
=C2=A0LICENSE =3D &quot;BSD-3-Clause&quot;<br>
-LIC_FILES_CHKSUM =3D &quot;file://doc/LICENSE;md5=3Da846608d090aa64494c45f=
c147cc12e3&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://docs/LICENSE;md5=3Da846608d090aa64494c45=
fc147cc12e3&quot;<br>
=C2=A0SECTION =3D &quot;tpm&quot;<br>
<br>
=C2=A0DEPENDS =3D &quot;tpm2-abrmd tpm2-tss openssl curl autoconf-archive&q=
uot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://github.com/tpm2-software/$%7BBPN=
%7D/releases/download/$%7BPV%7D/$%7BBPN%7D-$%7BPV%7D.tar.gz" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/tpm2-software/${BPN}/releases/dow=
nload/${PV}/${BPN}-${PV}.tar.gz</a>&quot;<br>
<br>
-SRC_URI[sha256sum] =3D &quot;c0b402f6a7b3456e8eb2445211e2d41c46c7e769e05fe=
4d8909ff64119f7a630&quot;<br>
+SRC_URI[sha256sum] =3D &quot;3810d36b5079256f4f2f7ce552e22213d43b1031c1315=
38df8a2dbc3c570983a&quot;<br>
<br>
=C2=A0inherit autotools pkgconfig bash-completion<br>
<br>
-do_configure:prepend() {<br>
-=C2=A0 =C2=A0 # do not extract the version number from git<br>
-=C2=A0 =C2=A0 sed -i -e &#39;s/m4_esyscmd_s(\[git describe --tags --always=
 --dirty\])/${PV}/&#39; ${S}/<a href=3D"http://configure.ac" rel=3D"norefer=
rer" target=3D"_blank">configure.ac</a><br>
-}<br>
-<br>
=C2=A0# need tss-esys<br>
=C2=A0RDEPENDS:${PN} =3D &quot;libtss2 tpm2-abrmd&quot;<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000003ddb8706254734e2--

