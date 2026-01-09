Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2114D1A628
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:28:58 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9958.1767965336342550728
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 05:28:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=N4zSv61U;
 spf=pass (domain: mvista.com, ip: 209.85.218.44, mailfrom: vanusuri@mvista.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79af62d36bso742556066b.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1767965334; x=1768570134; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu8NeUURYb37qw2XiyB5hx+K9995CGKwfax0KHKqnv0=;
        b=N4zSv61UfS7bGhoVGJuoahqCkCyFaa9DqUxKCJ8ltm/jUUpN2B1RVlPqTIo3fDhNp8
         GkuRSO38+bP86qZkq6Av1TPy02Kj6Rc90HZgQlJbigjwNMCGCaTNePfBoISW/8UxbxTC
         95q3ZKYYC3+EnevO6vVDtPDgJ0BFfpXJWZ7uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767965334; x=1768570134;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu8NeUURYb37qw2XiyB5hx+K9995CGKwfax0KHKqnv0=;
        b=a0PUQcms84a0ayEm6t35+V2iPIWsSSt5Khr66yaT2qgGkv+Cxk9VR0qjyIfBJ4DV81
         OAWntflBsZZXLd/q+kovSsharH3giDFPmwibuAeubu0aC/8GMMwdTu2fvDi8GOWgVv8j
         MwzTId226gAF5urJCokkcqnbnZScukykolXtGePc0Nrp8qD/EkGO/dYoWgSS12dEisJn
         tIeFZ6S112+RMwmwYwDpqT1ibKuC+EiVYLb3XlAiR1+Vc4gnCaoCAWJ5mXcwucu4rDvX
         Uoz0s3Sa2MeW46eilPpoxT11GBTZAXASSjWvZwCOjmLh7bf/1F8ICVBGg7XSy3SIkosA
         1pmA==
X-Gm-Message-State: AOJu0YySknAsU8v2wdCWv4EB4dSje0xxsTsnMFKzTlMDHh+ZBzX6Q8nj
	x1gAf4JiV40BWmenuPHnVuHa58OfFXKjeDoINikUYv6BgZXHosm+xgGIyiOZc+kUl6vUSvOLn0H
	uv7ZBY/JopbSow4a4fteSzyLVfve/GNFUy4YgnwVKC7fFI3+Y5V9IAQo=
X-Gm-Gg: AY/fxX61Xh96IxNzaQ/8ljNWs8EopoPH8xoekuhgy9L/q4+UZsw3GYd5qwR4l3Du7g7
	B8DM31QpzM1xBblGjwtwmleckaLjUhsv5OGbDxerCUiBmqk7XGePNz+AlrFiomaydjRdEycyiQF
	KnaFHsJFFiBncuhTCIiIaNJCBf33PzKe+9K/V0MNA3/sw94sqdHpWlYez2qJJixWOCS+MFVDHB/
	d8ULyt5SlE7F3420m2FCAmtQG/txldkSmsJlrfZE9ownhs9fEjzTHEv+zmXqgNM8SGSzozvntHL
	Fhc8frnMDs68yCONrvxzVKqa4ZfSO0xJBb+Igg==
X-Google-Smtp-Source: AGHT+IG6pYpG8QUKjz//a4Br5ijvrOgDrVY1lqdo8t/srqAhVnEK6YEEMI+GjUqYZJdo1zUOiKYsx4QCPqdK/sUhguk=
X-Received: by 2002:a17:907:72d6:b0:b80:40d2:9652 with SMTP id
 a640c23a62f3a-b84451bcc0emr900484766b.65.1767965333861; Fri, 09 Jan 2026
 05:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20251205101051.171885-1-vanusuri@mvista.com>
In-Reply-To: <20251205101051.171885-1-vanusuri@mvista.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Fri, 9 Jan 2026 18:58:41 +0530
X-Gm-Features: AZwV_QhPRspSvkiVwxvbDfu_-wQNGolsdcdqquBXhtIFfOKjkH1bRHcCYOcFtcQ
Message-ID: <CANQUz19gBo=0VHCRMPYRqHLn8Cvw5V5u6F4SPcKFYMSJsxRoVA@mail.gmail.com>
Subject: Re: [meta-security][kirkstone][PATCH] sssd: Fix for CVE-2025-11561
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000b348a40647f48121"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 13:28:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2925

--000000000000b348a40647f48121
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Any Update on this ?

Thanks & Regards,
Vijay

On Fri, Dec 5, 2025 at 3:41=E2=80=AFPM <vanusuri@mvista.com> wrote:

> From: Vijay Anusuri <vanusuri@mvista.com>
>
> Upstream-Status: Backport [
> https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da=
4d2
> ]
>
> Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> ---
>  .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
>  recipes-security/sssd/sssd_2.5.2.bb           |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch
>
> diff --git a/recipes-security/sssd/files/CVE-2025-11561.patch
> b/recipes-security/sssd/files/CVE-2025-11561.patch
> new file mode 100644
> index 0000000..0bfed6d
> --- /dev/null
> +++ b/recipes-security/sssd/files/CVE-2025-11561.patch
> @@ -0,0 +1,50 @@
> +From a0336f4cd69c25b3d501a3d361d3d286c00da4d2 Mon Sep 17 00:00:00 2001
> +From: Sumit Bose <sbose@redhat.com>
> +Date: Fri, 10 Oct 2025 12:57:40 +0200
> +Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IP=
A
> +MIME-Version: 1.0
> +Content-Type: text/plain; charset=3DUTF-8
> +Content-Transfer-Encoding: 8bit
> +
> +If a client is joined to AD or IPA SSSD's localauth plugin can handle
> +the mapping of Kerberos principals to local accounts. In case it cannot
> +map the Kerberos principals libkrb5 is currently configured to fall back
> +to the default localauth plugins 'default', 'rule', 'names',
> +'auth_to_local', 'k5login' and 'an2ln' (see man krb5.conf for details).
> +All plugins except 'an2ln' require some explicit configuration by either
> +the administrator or the local user. To avoid some unexpected mapping is
> +done by the 'an2ln' plugin this patch disables it in the configuration
> +snippets for SSSD's localauth plugin.
> +
> +Resolves: https://github.com/SSSD/sssd/issues/8021
> +
> +:relnote: After startup SSSD already creates a Kerberos configuration
> + snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plug=
in
> + if the AD or IPA providers are used. This enables SSSD's localauth
> plugin.
> + Starting with this release the an2ln plugin is disabled in the
> + configuration snippet as well. If this file or its content are included
> in
> + the Kerberos configuration it will fix CVE-2025-11561.
> +
> +Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
> +Reviewed-by: Pavel B=C5=99ezina <pbrezina@redhat.com>
> +(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)
> +
> +Upstream-Status: Backport [
> https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da=
4d2
> ]
> +CVE: CVE-2025-11561
> +Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> +---
> + src/util/domain_info_utils.c | 1 +
> + 1 file changed, 1 insertion(+)
> +
> +diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
> +index e131a5d96af..160e1711bcd 100644
> +--- a/src/util/domain_info_utils.c
> ++++ b/src/util/domain_info_utils.c
> +@@ -751,6 +751,7 @@ static errno_t sss_write_krb5_snippet_common(const
> char *file_name,
> + #define LOCALAUTH_PLUGIN_CONFIG \
> + "[plugins]\n" \
> + " localauth =3D {\n" \
> ++"  disable =3D an2ln\n" \
> + "  module =3D sssd:"APP_MODULES_PATH"/sssd_krb5_localauth_plugin.so\n" =
\
> + " }\n"
> +
> diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/
> sssd_2.5.2.bb
> index c07559c..43c31ee 100644
> --- a/recipes-security/sssd/sssd_2.5.2.bb
> +++ b/recipes-security/sssd/sssd_2.5.2.bb
> @@ -25,6 +25,7 @@ SRC_URI =3D "
> https://github.com/SSSD/sssd/releases/download/${PV}/sssd-${PV}.tar.g
>             file://musl_fixup.patch \
>             file://CVE-2021-3621.patch \
>             file://CVE-2023-3758.patch \
> +           file://CVE-2025-11561.patch \
>             "
>
>  SRC_URI[sha256sum] =3D
> "5e21b3c7b4a2f1063d0fbdd3216d29886b6eaba153b44fb5961698367f399a0f"
> --
> 2.25.1
>
>

--000000000000b348a40647f48121
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Team,<br><br></div>Any Update on this ?<=
br><br></div>Thanks &amp; Regards,<br></div>Vijay</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Dec 5, 2025 at 3:41=E2=80=AFPM &lt;<a href=3D"mailto:vanusuri@mvista.co=
m">vanusuri@mvista.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">From: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mv=
ista.com" target=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
<br>
Upstream-Status: Backport [<a href=3D"https://github.com/SSSD/sssd/commit/a=
0336f4cd69c25b3d501a3d361d3d286c00da4d2" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00d=
a4d2</a>]<br>
<br>
Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" tar=
get=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
---<br>
=C2=A0.../sssd/files/CVE-2025-11561.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 50 +++++++++++++++++++<br>
=C2=A0recipes-security/sssd/<a href=3D"http://sssd_2.5.2.bb" rel=3D"norefer=
rer" target=3D"_blank">sssd_2.5.2.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 1 +<br>
=C2=A02 files changed, 51 insertions(+)<br>
=C2=A0create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch<b=
r>
<br>
diff --git a/recipes-security/sssd/files/CVE-2025-11561.patch b/recipes-sec=
urity/sssd/files/CVE-2025-11561.patch<br>
new file mode 100644<br>
index 0000000..0bfed6d<br>
--- /dev/null<br>
+++ b/recipes-security/sssd/files/CVE-2025-11561.patch<br>
@@ -0,0 +1,50 @@<br>
+From a0336f4cd69c25b3d501a3d361d3d286c00da4d2 Mon Sep 17 00:00:00 2001<br>
+From: Sumit Bose &lt;<a href=3D"mailto:sbose@redhat.com" target=3D"_blank"=
>sbose@redhat.com</a>&gt;<br>
+Date: Fri, 10 Oct 2025 12:57:40 +0200<br>
+Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IPA<=
br>
+MIME-Version: 1.0<br>
+Content-Type: text/plain; charset=3DUTF-8<br>
+Content-Transfer-Encoding: 8bit<br>
+<br>
+If a client is joined to AD or IPA SSSD&#39;s localauth plugin can handle<=
br>
+the mapping of Kerberos principals to local accounts. In case it cannot<br=
>
+map the Kerberos principals libkrb5 is currently configured to fall back<b=
r>
+to the default localauth plugins &#39;default&#39;, &#39;rule&#39;, &#39;n=
ames&#39;,<br>
+&#39;auth_to_local&#39;, &#39;k5login&#39; and &#39;an2ln&#39; (see man kr=
b5.conf for details).<br>
+All plugins except &#39;an2ln&#39; require some explicit configuration by =
either<br>
+the administrator or the local user. To avoid some unexpected mapping is<b=
r>
+done by the &#39;an2ln&#39; plugin this patch disables it in the configura=
tion<br>
+snippets for SSSD&#39;s localauth plugin.<br>
+<br>
+Resolves: <a href=3D"https://github.com/SSSD/sssd/issues/8021" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/SSSD/sssd/issues/8021</a><br>
+<br>
+:relnote: After startup SSSD already creates a Kerberos configuration<br>
+ snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plugin=
<br>
+ if the AD or IPA providers are used. This enables SSSD&#39;s localauth pl=
ugin.<br>
+ Starting with this release the an2ln plugin is disabled in the<br>
+ configuration snippet as well. If this file or its content are included i=
n<br>
+ the Kerberos configuration it will fix CVE-2025-11561.<br>
+<br>
+Reviewed-by: Alexey Tikhonov &lt;<a href=3D"mailto:atikhono@redhat.com" ta=
rget=3D"_blank">atikhono@redhat.com</a>&gt;<br>
+Reviewed-by: Pavel B=C5=99ezina &lt;<a href=3D"mailto:pbrezina@redhat.com"=
 target=3D"_blank">pbrezina@redhat.com</a>&gt;<br>
+(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)<br>
+<br>
+Upstream-Status: Backport [<a href=3D"https://github.com/SSSD/sssd/commit/=
a0336f4cd69c25b3d501a3d361d3d286c00da4d2" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00=
da4d2</a>]<br>
+CVE: CVE-2025-11561<br>
+Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" ta=
rget=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
+---<br>
+ src/util/domain_info_utils.c | 1 +<br>
+ 1 file changed, 1 insertion(+)<br>
+<br>
+diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c<b=
r>
+index e131a5d96af..160e1711bcd 100644<br>
+--- a/src/util/domain_info_utils.c<br>
++++ b/src/util/domain_info_utils.c<br>
+@@ -751,6 +751,7 @@ static errno_t sss_write_krb5_snippet_common(const cha=
r *file_name,<br>
+ #define LOCALAUTH_PLUGIN_CONFIG \<br>
+ &quot;[plugins]\n&quot; \<br>
+ &quot; localauth =3D {\n&quot; \<br>
++&quot;=C2=A0 disable =3D an2ln\n&quot; \<br>
+ &quot;=C2=A0 module =3D sssd:&quot;APP_MODULES_PATH&quot;/sssd_krb5_local=
auth_plugin.so\n&quot; \<br>
+ &quot; }\n&quot;<br>
+ <br>
diff --git a/recipes-security/sssd/<a href=3D"http://sssd_2.5.2.bb" rel=3D"=
noreferrer" target=3D"_blank">sssd_2.5.2.bb</a> b/recipes-security/sssd/<a =
href=3D"http://sssd_2.5.2.bb" rel=3D"noreferrer" target=3D"_blank">sssd_2.5=
.2.bb</a><br>
index c07559c..43c31ee 100644<br>
--- a/recipes-security/sssd/<a href=3D"http://sssd_2.5.2.bb" rel=3D"norefer=
rer" target=3D"_blank">sssd_2.5.2.bb</a><br>
+++ b/recipes-security/sssd/<a href=3D"http://sssd_2.5.2.bb" rel=3D"norefer=
rer" target=3D"_blank">sssd_2.5.2.bb</a><br>
@@ -25,6 +25,7 @@ SRC_URI =3D &quot;<a href=3D"https://github.com/SSSD/sssd=
/releases/download/$%7BPV%7D/sssd-$%7BPV%7D.tar.g" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/SSSD/sssd/releases/download/${PV}/sssd-${PV=
}.tar.g</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://musl_fixup.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://CVE-2021-3621.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://CVE-2023-3758.patch \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2025-11561.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
<br>
=C2=A0SRC_URI[sha256sum] =3D &quot;5e21b3c7b4a2f1063d0fbdd3216d29886b6eaba1=
53b44fb5961698367f399a0f&quot;<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000b348a40647f48121--

