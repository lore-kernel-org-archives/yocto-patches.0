Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B76C25B7A
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 09:27:40 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.12700.1716456459286505253
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 02:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=VDyUMX+Y;
 spf=pass (domain: snapchat.com, ip: 209.85.218.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1113330066b.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1716456457; x=1717061257; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8lj60nxlOqhxBUZhHB8iSE1gxRaPVyIp2G7xIwSm6w=;
        b=VDyUMX+YcGwmClU/jRfUCox5AklwokNS0Qa53Ux4ksIbfoPUObRfrmdT3uKrDg3L1Y
         mSDcvEeNPH54FqCuWCBMlZEoZKC+nXlNGGAVLIuBub30Pbp5LMkMT3u9kDcVIF6Xfjqn
         WCg5X7mtb7WTeraCOuJO6Hu8DGxTMXGc63w3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456457; x=1717061257;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8lj60nxlOqhxBUZhHB8iSE1gxRaPVyIp2G7xIwSm6w=;
        b=s49HDmmzubG8wPlFYlNfjkU4n+uqNetQYX8ugvdsucS+3wx31PW6viBxlPcYxdYboA
         Hga7kWtEi2x5NzIa2YAzPTj7hSiabJWVU+eSLnPF2i89DBu4dhVW6Dzb/Q5cKpOG4dfJ
         JGBERvXaV6+LfTNkGNLexP+bAb4gN9TfoOjBuKjXvdv97IZWNeYWZxkyBsuEIaM9Pmsn
         QVm0PSCsadXEQC9+KL+9zoxsHxdi5XrkfEEMLilwODmJ7xzLSUsZDEXi+6UW8iQ4hY8T
         5vt4ZljD35engH/9Od2J0Re0XdkbW+C5j7R6IztMrTvBB6K6AiBLboAOFvsv4E/7jZ0s
         a6jA==
X-Gm-Message-State: AOJu0YzLFVhEqrbvnYOJe+zJQ1QuVctIRlTL/zwXmz/0UpphUkoInOFq
	JnPJV7AnvHTZxg0On3dISHuvJhtE53QYnAiHO6gVkmN6C0GjJThdP/Ta+8yo195pGgeOpd5HdBj
	c4clqUhPeXSAlN2lRfKvgMcLmrC1NY6i1YroE2EwwUhjhUJ9O9C2vyw==
X-Google-Smtp-Source: AGHT+IFuXUog4+sO+LsIl+JH2BI9GDvq/5qzf1tpPZf9rOzytjE7dBiUSmQiiMvMWycwdXkPK+p4LGQ/ceMetpC0QRg=
X-Received: by 2002:a17:906:3544:b0:a62:469f:338c with SMTP id
 a640c23a62f3a-a62469f34b5mr50703066b.32.1716456457233; Thu, 23 May 2024
 02:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <17D213B141A57C32.4692@lists.yoctoproject.org>
In-Reply-To: <17D213B141A57C32.4692@lists.yoctoproject.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 23 May 2024 11:27:26 +0200
Message-ID: <CAHUKmYZ8z29v6furOy4n9RfdgeNq2npvFz3Y3dHzmNxg5EwNXQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] selinux-python: make GPLv3
 dependency optional
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000068087506191ba93b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 09:27:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/177

--00000000000068087506191ba93b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, note that another way to implement this is  RRECOMMENDS=3D"binutils" in
the recipe, and BAD_RECOMMENDATION+=3D"binutils" for users of the layer who
want to disable the dependency. I used the PACKAGECONFIG way since it makes
it clearer which functionality gets disabled IMO:
PACKAGECONFIG:remove:pn-selinux-python-sepolicy =3D "sepolicy-generate"

=C3=89tienne

On Thu, May 23, 2024 at 11:21=E2=80=AFAM Etienne Cordonnier via
lists.yoctoproject.org <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrot=
e:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  recipes-security/selinux/selinux-python_3.6.bb | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/recipes-security/selinux/selinux-python_3.6.bb
> b/recipes-security/selinux/selinux-python_3.6.bb
> index 79125d0..faf5d28 100644
> --- a/recipes-security/selinux/selinux-python_3.6.bb
> +++ b/recipes-security/selinux/selinux-python_3.6.bb
> @@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage =3D "\
>          audit-python \
>          ${PN} \
>  "
> +PACKAGECONFIG ??=3D "sepolicy-generate"
> +PACKAGECONFIG[sepolicy-generate] =3D ",,,"
>  RDEPENDS:${PN}-sepolicy =3D "\
> -        binutils \
> +        ${@bb.utils.contains('PACKAGECONFIG', 'sepolicy-generate',
> 'binutils', '', d)} \
>          python3-core \
>          python3-codecs \
>          python3-distro \
> --
> 2.36.1.vfs.0.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#176):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_176&d=3DDwIDAg&c=3DncDTmphkJTvjIDPh0hpF_4vCH=
vabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DlPIk=
UojxnbO-FZs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&s=3DQ7pJEscGHJ=
AQWu-JyNkLzNGARkVCiKyJHqXOXyIKUt0&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_106259298_7048771&d=3DDwIDAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DlPIkUojxnbO-F=
Zs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&s=3D3vh1q3hhQildiGh8hio=
Ogq6sV24cOaqF_ktqqgysaa4&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIDAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DlPIkUojxnbO-FZs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuVQkSnB=
qLuhpkl9aXF6N&s=3DIaa6t5krk7y3o1kPBUWyCjh22AMQh5M07gP-pg7Vq60&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000068087506191ba93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, note that another way to implement this is=C2=A0<span =
style=3D"color:rgb(31,35,40);font-family:-apple-system,BlinkMacSystemFont,&=
quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Arial,sans-serif,&quot;=
Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px">=C2=A0RR=
ECOMMENDS=3D&quot;binutils&quot; in the recipe, and=C2=A0</span><span style=
=3D"color:rgb(31,35,40);font-family:-apple-system,BlinkMacSystemFont,&quot;=
Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Arial,sans-serif,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px">BAD_RECOMMEND=
ATION+=3D&quot;binutils&quot; for users of the layer who want to disable th=
e dependency. I used the PACKAGECONFIG way since it makes it clearer which =
functionality gets disabled IMO:<br></span>PACKAGECONFIG:remove:pn-selinux-=
python-sepolicy =3D &quot;sepolicy-generate&quot;<br><span style=3D"color:r=
gb(31,35,40);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&qu=
ot;,&quot;Noto Sans&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoj=
i&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px"><br>=C3=89tienne</span><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, May 23, 2024 at 11:21=E2=80=AFAM Etienne Cordonnier via <a href=3D"h=
ttp://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;ecordonnier=3D=
<a href=3D"mailto:snap.com@lists.yoctoproject.org">snap.com@lists.yoctoproj=
ect.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com"=
 target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0recipes-security/selinux/<a href=3D"http://selinux-python_3.6.bb" rel=
=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a> | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-security/selinux/<a href=3D"http://selinux-python_3.6.=
bb" rel=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a> b/recipe=
s-security/selinux/<a href=3D"http://selinux-python_3.6.bb" rel=3D"noreferr=
er" target=3D"_blank">selinux-python_3.6.bb</a><br>
index 79125d0..faf5d28 100644<br>
--- a/recipes-security/selinux/<a href=3D"http://selinux-python_3.6.bb" rel=
=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><br>
+++ b/recipes-security/selinux/<a href=3D"http://selinux-python_3.6.bb" rel=
=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><br>
@@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audit-python \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${PN} \<br>
=C2=A0&quot;<br>
+PACKAGECONFIG ??=3D &quot;sepolicy-generate&quot;<br>
+PACKAGECONFIG[sepolicy-generate] =3D &quot;,,,&quot;<br>
=C2=A0RDEPENDS:${PN}-sepolicy =3D &quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 binutils \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, =
&#39;sepolicy-generate&#39;, &#39;binutils&#39;, &#39;&#39;, d)} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-core \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-codecs \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-distro \<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#176): <a href=3D"https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_176&amp;d=
=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DlPIkUojxnbO-FZs2EHT9zZhzsx0U=
0o3Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&amp;s=3DQ7pJEscGHJAQWu-JyNkLzNGARkVCiK=
yJHqXOXyIKUt0&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldef=
ense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dp=
atches_message_176&amp;d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkIC=
C2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DlPIk=
UojxnbO-FZs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&amp;s=3DQ7pJEs=
cGHJAQWu-JyNkLzNGARkVCiKyJHqXOXyIKUt0&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_106259298_7048771&amp;d=3DDwIDAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DlPIkUojxnbO-FZs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuV=
QkSnBqLuhpkl9aXF6N&amp;s=3D3vh1q3hhQildiGh8hioOgq6sV24cOaqF_ktqqgysaa4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_106259298_7048771&amp;d=3D=
DwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DlPIkUojxnbO-FZs2EHT9zZhzsx0U0o3=
Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&amp;s=3D3vh1q3hhQildiGh8hioOgq6sV24cOaqF_=
ktqqgysaa4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DlPIkUojxnbO-F=
Zs2EHT9zZhzsx0U0o3Cm0zMSned_1OYuVQkSnBqLuhpkl9aXF6N&amp;s=3DIaa6t5krk7y3o1k=
PBUWyCjh22AMQh5M07gP-pg7Vq60&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIDA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DlPIkUojxnbO-FZs2EHT9zZhzsx0U0o3Cm0zM=
Sned_1OYuVQkSnBqLuhpkl9aXF6N&amp;s=3DIaa6t5krk7y3o1kPBUWyCjh22AMQh5M07gP-pg=
7Vq60&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--00000000000068087506191ba93b--

