Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF68C71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 09:40:26 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
 by mx.groups.io with SMTP id smtpd.web10.4052.1750412422194677786
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 02:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iOUc9Chg;
 spf=pass (domain: gmail.com, ip: 209.85.217.52, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e9c6b44477so284336137.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750412421; x=1751017221; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSDEZRup1WJ+SuddAR8Aq3TpMV2QUghF7nNtR0N36Oc=;
        b=iOUc9ChgEURj3fpiI6gXleWSWnGkL6iz0/kJr9VV/Gkm2cMU05MSrLgcaQQCIs1SUh
         E9qkoUp9Pai1JdS31Lue7VPiYjG/qeG54G3DDj6Tq8AUKeKP2Zn+B+YiEpcG49XbVVdL
         ZJD0oGPe8xscn22nYj4k97mjj7p3JmiibdD+euRPJ1T/4hCI2LeYhmSCdh9kl/lTDA/0
         79+OI4e19WpYpm51NSJKW3z9jbGYU/4QFyOeiCyoEshjKZMUS5VKOJusKpey5uMNUp9x
         q886iBirltM8MNQM5d4bfofLZWgWYAUTh+3jY7y1se/HNv/Lj35zTdshb4HIo7sn8ZIp
         Iv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412421; x=1751017221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSDEZRup1WJ+SuddAR8Aq3TpMV2QUghF7nNtR0N36Oc=;
        b=f53oKc2bpved7+IIafMimkZhiNucN3vIQyk9j8p1oAoU/t4rdwsSI2yR1DwsDEl0f2
         ihRILYlyRWQq1Q5IK+XZapGUskHOqdZIjTSb8b26N+//qHU6ObLIUVDueSTTJCXc0g8e
         U+9kjf9cBguchu7EIRbi7tUS2+IE1o4qUplOReDu7pFVjzyVEuOfADC2wjqSJpz+93Pq
         dAscpIv0Rb2TmfQ7k4MHCCkP9XUz9PgmW+x6uT2MqbVWbF2oJ0CNZ0fTUUb0C+etGfQo
         PKFEr7KaSiyJIunf1mZhkkOJfX03Sznml94jutW+tEV5os/r8LTINYPay/x72nj4ELrq
         QR4A==
X-Gm-Message-State: AOJu0YyVnkuQelDI+nVseVaTWjxzUfQG1AP/WOHpzvnvVH15yTaTnszn
	P33LI4DRL9z1APFhdAjQLCKfG2KRY5m4erKtk6T00H1vC+pQUdAytM9pfAAvFc7Sg/KX9jVEQTT
	WzZ3mO24qodnJ6gNZ5rwkEQ/DX20EzsiNgXOo
X-Gm-Gg: ASbGncs6+OBXR/NgcbxUNSaVLDz19ipidBJL37DmfsLQS8CBjVXOYl9cmHTNonVmqyS
	v09YgptCY4Y96fKsTPfX7koHbwnv7wXkZpLXxwME3JSYYZh21yFj2dKVcPyG9MYaOQB1EfRN3Ta
	ME9zlik+dYPjheaWT0ot/SNwKhX2gxgg3ftVzMAFyzpkguwYaylQBcYmw=
X-Google-Smtp-Source: AGHT+IE6y2vXGcRPc5b7UN4vBzxBi1dE8krufIeLYt/p2rEW635nWOywX1HCqBLsVe21eHbqJeZy2dSZbKU9oowUL3U=
X-Received: by 2002:a05:6102:4b86:b0:4e5:ade7:eb7c with SMTP id
 ada2fe7eead31-4e9c2bc7ddamr1059402137.12.1750412420943; Fri, 20 Jun 2025
 02:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250619213154.16580-1-peter.marko@siemens.com>
In-Reply-To: <20250619213154.16580-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 20 Jun 2025 10:40:10 +0100
X-Gm-Features: Ac12FXxO0LmXxvHcxcP59UQA6AVxAsl7IMLN8HP3ezusavtkwgaPslcPITawibI
Message-ID: <CANPvuR=jFoSS3ytO__tPPuwDxmCHVyQijMaqnT35aNfcPmub=Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go: set
 status of CVE-2024-3566
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000008f94400637fda677"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 09:40:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1669

--0000000000008f94400637fda677
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quinta, 19/06/2025 =C3=A0(s)
22:32):

> From: Peter Marko <peter.marko@siemens.com>
>
> NVD ([1]) tracks this as:
> cpe:2.3:a:golang:go:*:*:*:*:*:*:*:*
> Running on/with
>   cpe:2.3:o:microsoft:windows:-:*:*:*:*:*:*:*
>
> Yocto cve-check ignores the "Running on/with", so it needs to be ignored
> explicitly.
>
> [1] https://nvd.nist.gov/vuln/detail/CVE-2024-3566
>
> (From OE-Core rev: c8ce6710d864d237fdf67d2c3d3aa0f0970a2a05)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> Switched CVE_SDTATUS to CVE_CHECK_IGNORE syntax.
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/go-binary-native_1.24.4.bb | 3 +++
>  recipes-devtools/go/go-common.inc              | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/recipes-devtools/go/go-binary-native_1.24.4.bb
> b/recipes-devtools/go/go-binary-native_1.24.4.bb
> index 9f78853..d1f8fc6 100644
> --- a/recipes-devtools/go/go-binary-native_1.24.4.bb
> +++ b/recipes-devtools/go/go-binary-native_1.24.4.bb
> @@ -18,6 +18,9 @@ UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linu=
x"
>
>  CVE_PRODUCT =3D "golang:go"
>
> +# not-applicable-platform: Issue only applies on Windows
> +CVE_CHECK_IGNORE +=3D "CVE-2024-3566"
> +
>  S =3D "${WORKDIR}/go"
>
>  inherit goarch native
> diff --git a/recipes-devtools/go/go-common.inc
> b/recipes-devtools/go/go-common.inc
> index ca8469d..e90aab8 100644
> --- a/recipes-devtools/go/go-common.inc
> +++ b/recipes-devtools/go/go-common.inc
> @@ -22,6 +22,9 @@ UPSTREAM_CHECK_REGEX =3D "(?P<pver>\d+(\.\d+)+)\.src\.t=
ar"
>  # all recipe variants are created from the same product
>  CVE_PRODUCT =3D "golang:go"
>
> +# not-applicable-platform: Issue only applies on Windows
> +CVE_CHECK_IGNORE +=3D "CVE-2024-3566"
> +
>  INHIBIT_PACKAGE_DEBUG_SPLIT =3D "1"
>  SSTATE_SCAN_CMD =3D "true"
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1664):
> https://lists.yoctoproject.org/g/yocto-patches/message/1664
> Mute This Topic: https://lists.yoctoproject.org/mt/113733474/5052612
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>
Thanks, applied

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000008f94400637fda677
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;p=
eter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.=
com@lists.yoctoproject.org</a>&gt; escreveu (quinta, 19/06/2025 =C3=A0(s) 2=
2:32):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Pet=
er Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank">p=
eter.marko@siemens.com</a>&gt;<br>
<br>
NVD ([1]) tracks this as:<br>
cpe:2.3:a:golang:go:*:*:*:*:*:*:*:*<br>
Running on/with<br>
=C2=A0 cpe:2.3:o:microsoft:windows:-:*:*:*:*:*:*:*<br>
<br>
Yocto cve-check ignores the &quot;Running on/with&quot;, so it needs to be =
ignored<br>
explicitly.<br>
<br>
[1] <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2024-3566" rel=3D"noref=
errer" target=3D"_blank">https://nvd.nist.gov/vuln/detail/CVE-2024-3566</a>=
<br>
<br>
(From OE-Core rev: c8ce6710d864d237fdf67d2c3d3aa0f0970a2a05)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
<br>
Switched CVE_SDTATUS to CVE_CHECK_IGNORE syntax.<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
---<br>
=C2=A0recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a> | 3 +++<br=
>
=C2=A0recipes-devtools/go/go-common.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 3 +++<br>
=C2=A02 files changed, 6 insertions(+)<br>
<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a><br>
index 9f78853..d1f8fc6 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a><br>
@@ -18,6 +18,9 @@ UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+=
)+)\.linux&quot;<br>
<br>
=C2=A0CVE_PRODUCT =3D &quot;golang:go&quot;<br>
<br>
+# not-applicable-platform: Issue only applies on Windows<br>
+CVE_CHECK_IGNORE +=3D &quot;CVE-2024-3566&quot;<br>
+<br>
=C2=A0S =3D &quot;${WORKDIR}/go&quot;<br>
<br>
=C2=A0inherit goarch native<br>
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-com=
mon.inc<br>
index ca8469d..e90aab8 100644<br>
--- a/recipes-devtools/go/go-common.inc<br>
+++ b/recipes-devtools/go/go-common.inc<br>
@@ -22,6 +22,9 @@ UPSTREAM_CHECK_REGEX =3D &quot;(?P&lt;pver&gt;\d+(\.\d+)+=
)\.src\.tar&quot;<br>
=C2=A0# all recipe variants are created from the same product<br>
=C2=A0CVE_PRODUCT =3D &quot;golang:go&quot;<br>
<br>
+# not-applicable-platform: Issue only applies on Windows<br>
+CVE_CHECK_IGNORE +=3D &quot;CVE-2024-3566&quot;<br>
+<br>
=C2=A0INHIBIT_PACKAGE_DEBUG_SPLIT =3D &quot;1&quot;<br>
=C2=A0SSTATE_SCAN_CMD =3D &quot;true&quot;<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1664): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1664" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1664</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/113733474/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/113733474/5052612</a><br>
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
</blockquote></div><div><br clear=3D"all"></div><div>Thanks, applied</div><=
div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>J=
os=C3=A9 Quaresma</div></div></div></div>

--0000000000008f94400637fda677--

