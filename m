Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D7FCAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 05:28:49 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.6940.1758173326352021288
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 22:28:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LwAyWOx8;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: rybczynska@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267f0fe72a1so3440645ad.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758173325; x=1758778125; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyQ1g4DTzGGeK8ragipI6QsJ8TjGc3DyEeDe6FvFgXY=;
        b=LwAyWOx8z0YPlHArojOf2RxDSFi8RFmRZu9yPwsJs5ekmfE/DzIwyTRVQSBbdzfwfU
         59uqEvaFnVFlanvwv+Xumiwe5Fh1eUX53FZbt18vCIK56z0OnoV3VJ0ZXqFk2F5lNGts
         BsaAMJ2Wed6SM4ygEIrgFQmMzM5/8vd1eZHVkuKqHhKzuPu1ifoaWZnhwbDmkpeJEcvL
         0fTjTXcMIAm7zAr3T3YHpKbeMxqDsH4fDD+qkXIONtloPP+hyVjo8QbmPP6H+1pbwR1M
         g6+oX5ctt3xoMfafTdMevfG2TEdCpsDjbor1TCYSh5EXSxvcYFpsXcjiCnPOdCV+1wuU
         aZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173325; x=1758778125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyQ1g4DTzGGeK8ragipI6QsJ8TjGc3DyEeDe6FvFgXY=;
        b=B8/aJtYz+KrwNuRbk/XcIH7BJG0XxlVIZTZsRG1E2+tl73LfGP44t6NmKS/ySRcTpO
         1uqvNd+wwTp1Psf8d9aTuC2LpptoOIf43IZZQsGV+cwGF3qNwgYrUaOk8eVXqv8zfkv2
         1kAFjbzxw5dBpPkTZXrvhPt/r0P18eMfOduEEASl4YKrHprYor1U+xEhWnU+hf9gdQXJ
         fTqorIUn8yiWhO+vY/rx2mADAFAddlrFjyrgQ+WpntgG8DbMTxuCCcv6YkVYzsfd8y22
         W6CjnUqbgjCSq142cVLLbRNraOWhUoWBuTtyzIrGHW/rsVUQjkO7RsWGUiXBk2dPgtED
         jB+A==
X-Gm-Message-State: AOJu0YwwH4J+CLyHTtsAYwYpDpaBNgNoVsdkgO8QCLBQxLVMNxaRxL8l
	3IdxalralAmADq+gPqgu3jaJmhqdhyqt5i4a2yeg+MIGJJVDKge5QMse+PmDU+dd+xqD+rC8w/K
	sUmAbgcVKP5r3B4LhcsS7pgFsZruGfyTS51XtUhw=
X-Gm-Gg: ASbGnctn1pHNlvzd8/I+fPApg1VYNsxn/fa+kfgrNgrTQ2zy1tvV06yVA6zhP+tZ/YH
	AFniRsmkD6A+YvkEOH6xw1M23E/wuO80i7PBM2Umyn2l/As9ZSG+GHkwQA7zqjV4/kyp03yfrmJ
	okXlnSZQgPluhkZOOibYRoDq7FXKicokUvODWlVwbjKxtYRXMTo6Ts2yChFOrF11BpELpioVNQQ
	Xv858qRFzY9M7FPMyqlkUItGBhtSrVY/IjSH7x3bSFDweMsExrDoG6exQQ=
X-Google-Smtp-Source: AGHT+IGf7e6FAMBYD0xjoBFGwY7J+nXHrIbj18TP5VRmLNGwt2oAg/ZWgSYT/k8Kkz9eO9L93qdxVwsQeRZWEp+8y0c=
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id
 d9443c01a7336-268118b9516mr62731335ad.1.1758173325178; Wed, 17 Sep 2025
 22:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1758138771.git.scott.murray@konsulko.com> <730ebbddc121016151a72d3e0bce61351a0ad365.1758138771.git.scott.murray@konsulko.com>
In-Reply-To: <730ebbddc121016151a72d3e0bce61351a0ad365.1758138771.git.scott.murray@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 18 Sep 2025 07:28:33 +0200
X-Gm-Features: AS18NWAl7Be3-cA7VeyZicYnrCAY8gaDecc865iP7BVfdIHmalv2sRi33QpzdxI
Message-ID: <CAApg2=TMGYOJN0=u5-YSSaEnZC3UDjnXf_deEpWSB9pAjFJyXA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 5/5] lynis: update to 3.1.5
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Content-Type: multipart/alternative; boundary="000000000000803e36063f0ca080"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 05:28:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2215

--000000000000803e36063f0ca080
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:43=E2=80=AFPM Scott Murray via lists.yoctoprojec=
t.org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>
> Tested on master (whinlatter) with beaglebone-yocto
>
> New in version 3.1.5 (2025-07-29):
> https://cisofy.com/changelog/lynis/#315
>
> Added:
> - Support for OpenWrt
> - Bitdefender detection on Linux
> - Detection of openSUSE Tumbleweed-Slowroll
>
> Changed:
> - Corrected detection of service manager SMF
> - Extended GetHostID function to allow HostID and HostID2 creation on
> OpenWrt
> - Check modules also under /usr/lib/modules.d
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  recipes-compliance/lynis/{lynis_3.1.4.bb =3D> lynis_3.1.5.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-compliance/lynis/{lynis_3.1.4.bb =3D> lynis_3.1.5.bb} (93=
%)
>
> diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb
> b/recipes-compliance/lynis/lynis_3.1.5.bb
> similarity index 93%
> rename from recipes-compliance/lynis/lynis_3.1.4.bb
> rename to recipes-compliance/lynis/lynis_3.1.5.bb
> index 3546a9e..3d1e8b7 100644
> --- a/recipes-compliance/lynis/lynis_3.1.4.bb
> +++ b/recipes-compliance/lynis/lynis_3.1.5.bb
> @@ -8,7 +8,7 @@ LIC_FILES_CHKSUM =3D
> "file://LICENSE;md5=3D3edd6782854304fd11da4975ab9799c1"
>
>  SRC_URI =3D "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
>
> -SRC_URI[sha256sum] =3D
> "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
> +SRC_URI[sha256sum] =3D
> "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
>
>  #UPSTREAM_CHECK =3D "https://downloads.cisofy.com/lynis"
>
>
Hello,
I was thinking about this one, as lynis is causing issues for each new
version. The last version is indeed  ${BPN}-${PV}.tar.gz
<https://downloads.cisofy.com/lynis/$%7BBPN%7D-$%7BPV%7D.tar.gz>, but when
they release, they move the previous one. Existing recipes do not work
anymore.

I think the solution would be to use their GitHub releases like
https://github.com/CISOfy/lynis/archive/refs/tags/3.1.5.tar.gz

That would avoid the need to update the link every time they release.

What do you think?

Kind regards,
Marta

--000000000000803e36063f0ca080
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 17,=
 2025 at 10:43=E2=80=AFPM Scott Murray via <a href=3D"http://lists.yoctopro=
ject.org">lists.yoctoproject.org</a> &lt;scott.murray=3D<a href=3D"mailto:k=
onsulko.com@lists.yoctoproject.org">konsulko.com@lists.yoctoproject.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From=
: Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@rootcommit.co=
m" target=3D"_blank">michael.opdenacker@rootcommit.com</a>&gt;<br>
<br>
Tested on master (whinlatter) with beaglebone-yocto<br>
<br>
New in version 3.1.5 (2025-07-29):<br>
<a href=3D"https://cisofy.com/changelog/lynis/#315" rel=3D"noreferrer" targ=
et=3D"_blank">https://cisofy.com/changelog/lynis/#315</a><br>
<br>
Added:<br>
- Support for OpenWrt<br>
- Bitdefender detection on Linux<br>
- Detection of openSUSE Tumbleweed-Slowroll<br>
<br>
Changed:<br>
- Corrected detection of service manager SMF<br>
- Extended GetHostID function to allow HostID and HostID2 creation on OpenW=
rt<br>
- Check modules also under /usr/lib/modules.d<br>
<br>
Signed-off-by: Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@=
rootcommit.com" target=3D"_blank">michael.opdenacker@rootcommit.com</a>&gt;=
<br>
---<br>
=C2=A0recipes-compliance/lynis/{<a href=3D"http://lynis_3.1.4.bb" rel=3D"no=
referrer" target=3D"_blank">lynis_3.1.4.bb</a> =3D&gt; <a href=3D"http://ly=
nis_3.1.5.bb" rel=3D"noreferrer" target=3D"_blank">lynis_3.1.5.bb</a>} | 2 =
+-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename recipes-compliance/lynis/{<a href=3D"http://lynis_3.1.4.bb" re=
l=3D"noreferrer" target=3D"_blank">lynis_3.1.4.bb</a> =3D&gt; <a href=3D"ht=
tp://lynis_3.1.5.bb" rel=3D"noreferrer" target=3D"_blank">lynis_3.1.5.bb</a=
>} (93%)<br>
<br>
diff --git a/recipes-compliance/lynis/<a href=3D"http://lynis_3.1.4.bb" rel=
=3D"noreferrer" target=3D"_blank">lynis_3.1.4.bb</a> b/recipes-compliance/l=
ynis/<a href=3D"http://lynis_3.1.5.bb" rel=3D"noreferrer" target=3D"_blank"=
>lynis_3.1.5.bb</a><br>
similarity index 93%<br>
rename from recipes-compliance/lynis/<a href=3D"http://lynis_3.1.4.bb" rel=
=3D"noreferrer" target=3D"_blank">lynis_3.1.4.bb</a><br>
rename to recipes-compliance/lynis/<a href=3D"http://lynis_3.1.5.bb" rel=3D=
"noreferrer" target=3D"_blank">lynis_3.1.5.bb</a><br>
index 3546a9e..3d1e8b7 100644<br>
--- a/recipes-compliance/lynis/<a href=3D"http://lynis_3.1.4.bb" rel=3D"nor=
eferrer" target=3D"_blank">lynis_3.1.4.bb</a><br>
+++ b/recipes-compliance/lynis/<a href=3D"http://lynis_3.1.5.bb" rel=3D"nor=
eferrer" target=3D"_blank">lynis_3.1.5.bb</a><br>
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D3edd6782854=
304fd11da4975ab9799c1&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://downloads.cisofy.com/lynis/$%7BB=
PN%7D-$%7BPV%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://downlo=
ads.cisofy.com/lynis/${BPN}-${PV}.tar.gz</a>&quot;<br>
<br>
-SRC_URI[sha256sum] =3D &quot;c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb=
0a9fdd3ca5f0ae28eb6&quot;<br>
+SRC_URI[sha256sum] =3D &quot;8d2c6652ba60116a82514522b666ca77293f4bfc69f1e=
581028769f7ebb52ba4&quot;<br>
<br>
=C2=A0#UPSTREAM_CHECK =3D &quot;<a href=3D"https://downloads.cisofy.com/lyn=
is" rel=3D"noreferrer" target=3D"_blank">https://downloads.cisofy.com/lynis=
</a>&quot;<br>
<br></blockquote><div><br></div><div>Hello,</div><div>I was thinking about =
this one, as lynis is causing issues for each new version. The last version=
 is indeed=C2=A0 <a href=3D"https://downloads.cisofy.com/lynis/$%7BBPN%7D-$=
%7BPV%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">${BPN}-${PV}.tar.gz</=
a>, but when they release, they move the previous one. Existing recipes do =
not work anymore.</div><div><br></div><div>I think the solution would be to=
 use their GitHub releases like <a href=3D"https://github.com/CISOfy/lynis/=
archive/refs/tags/3.1.5.tar.gz">https://github.com/CISOfy/lynis/archive/ref=
s/tags/3.1.5.tar.gz</a></div><div><br></div><div>That would avoid the need =
to update the link every time they release.<br></div><div><br></div><div>Wh=
at do you think?</div><div><br></div><div>Kind regards,</div><div>Marta<br>=
</div></div></div>

--000000000000803e36063f0ca080--

