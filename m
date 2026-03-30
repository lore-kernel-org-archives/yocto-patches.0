Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A4FF493C
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 04:17:13 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43360.1774844228494116022
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 21:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f6RCrBii;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso4370580e87.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 21:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774844226; cv=none;
        d=google.com; s=arc-20240605;
        b=LelrOOQGnq/ZgzKRjhRxOZGxTKHAzvqA5QgrJAcN89i9f3tiBOoVVdZcW8No8F6Z5k
         JaTidb9FMPU3YN0i8NpI2mYszSC8FjTf7+06Xz8aiCerHf0+lmYcS1cRFdrpt9pk9MPu
         QFZMvHR5mgNN/kSP7MQQCjkP0W8bp1N8cyhEEGW6ap8jMKg0kiQ+9ZoMAypjSrTXUTlr
         UTHVxG3x0mG0L38TAlh+w2/xBpGVgspJ4W2mwEsX0lhQU06Kyd2oft7aztfdmL2oRpKL
         66Rl/l+D9kZMNCi0DLWF7936AI47vLBscK2/HpY26tEzLE4Wg/doAbt2TbQxyhKumaJM
         w8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LXrurr1FOXKX8uBzaLo3N7VypLQ9o4KC0OeeBgSd88E=;
        fh=jrEbHcM9NVatGxI25/yVqhLCFNkcjzfu6ylXCc39wAY=;
        b=iNjzIVFPexmtYmU4o4yYV60bS5R5nnFe6G8XKRFJgdq5EpiensX3UC/a7LGCoaweBI
         gWLGtuOq/xAdJjBhe5OFn4j+0wMf/3eMIwhBjoOtZnI+ZhABYkqX5GarwyB3p9G+2RA/
         2S4VXBIPpyx+2VMykMkif7RRWPw5tWga225FWZnmS8DqXEX4WuNz2c26xfGunVbTr4Ki
         HEaZ5mzk3kHHO60DjzSwlUwJgv8ZWWHNY3EDcUhWjLIFJX/juWHDK1MuFfmA2vxZnwKU
         OYQjjU8bpZ8NunDvlQPKqJLr9aA6kV7TylGjBgbfRJuzekmeebYMdElsKZsfXpVRC6Sn
         WQSA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844226; x=1775449026; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXrurr1FOXKX8uBzaLo3N7VypLQ9o4KC0OeeBgSd88E=;
        b=f6RCrBiiTGE7rmuPfGwexRiqsB6Kd4verdSFSctFKy8MqcMplxACui4r0ezxd71HvL
         TynDxWFJxyAN8HnyBPtn1lDfMCbfGx8tTAtzNZgLPYVpkt2U0C7q4R/EqjHUo9nUFDvv
         Q/MgIMeSDJNYz+TFDWnqCpaHkX1G1uDZhNpW1lQ9qCEG3H+0Z7nvtnivQOGCexoC5f8R
         a2TSiL4dPwxRLcXIWAy+UPIMzh7MayvcRExrydjrdKP/1MhldTL4PE6B9OzwQ3PGR4Bf
         C7vO13mqKewbmwbl2pipq/omGtoVyKp8eTBHGNiALu/rh3dynCoTZiAGMT96D5g7fhyb
         ppdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844226; x=1775449026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXrurr1FOXKX8uBzaLo3N7VypLQ9o4KC0OeeBgSd88E=;
        b=OcNGozUhZLSfY1hpVyLWSLfPU6dEc8PtOLSbrsnjW095XslSgELmpFNatyvzr+PNwC
         rN7UNNVPGIvvyl6hhZ00DzGQ9LJm1MtZOw00gMcyuKh2wKl9o/rBnYrP1jyuvB9K6rY+
         n97S+YnFVhcHp3twgwsru5O0BfBBukU1IeWDA++aMFVX57CGJkUV5P3JgM5hFLDRPiV7
         SRwKDUUhPuFym/+Kz3TWG8RomAM2RvlNrkmvE6/y7V35Gs8ER5y7c5X+ONkXFBHgnc2e
         dxb7oLXMklD1FW3zC1oNsS6CYnvStj2Ux7mfLNX5EjjSwbDwcQvIf2psbR+H6TGKe82i
         r67w==
X-Gm-Message-State: AOJu0YydM4mH0ydNddMEVfundsv7H2T6hgmZtRTs3+o3VnHlFTSan6XZ
	gWxc8xn8GvdXfzyBEaVoUkpPdQkHREQqkGxcr+7kxQg3/afuthyQ0eMNysPHZPihyYl1uwjWTaP
	Vir8d8jHUUVIyjGUrqiAMtD/FUZUsA0YG9w==
X-Gm-Gg: ATEYQzw0kVPRbJZHj43XZbqCrcxZjfehnrEwq9TpxGjyk8MG/71Uz69Rrm92mvvpvqJ
	rdinhEjupsmvwvla6CuAKJkIf9EH+vWUdlH/vyv3pqVSVqCrz8SIkZxhbB68dHooQP/wI1ogwb1
	c+DhExxfK7+0GuS0UlOvzYrUCW/NmvFw+1cYOYcV8Tmzpb9ti2OKwvLzvG0338dBr0gJXZw8m2c
	+2yf9aoPZ07mkWsQNtkWEMHYfWYwXGWtvsXAHf3jjSEGmJAok7ftkAteRboiAc6sqa1UK1HWlhA
	Wy1v0yk=
X-Received: by 2002:a05:6512:2204:b0:5a2:a1aa:2b8d with SMTP id
 2adb3069b0e04-5a2ab8029b5mr3152666e87.15.1774844225861; Sun, 29 Mar 2026
 21:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260329171109.34764-1-piotr@qbee.io>
In-Reply-To: <20260329171109.34764-1-piotr@qbee.io>
From: Tim Orling <ticotimo@gmail.com>
Date: Sun, 29 Mar 2026 21:16:53 -0700
X-Gm-Features: AQROBzBMqN9G3MEXkjexLdEAZVHDFJCfnWUnfcfA_K0XD1z76d0yfRN9jZkuumY
Message-ID: <CANx9H-BxvZ4ZKxtcgd0Vd7OMoFSufHwWqsevKwh4G43q61qXBQ@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH 1/3] Convert logout to a
 POST request, as GET is not longer supported by the new Djang 5.2 TLS.
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?Q?Piotr_Buli=C5=84ski?= <piotr@qbee.io>
Content-Type: multipart/alternative; boundary="0000000000009d3a6f064e361f2d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 04:17:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3578

--0000000000009d3a6f064e361f2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor tweak to subject line: Djang -> Django.

Merged to master. Thank you.

On Sun, Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via lists.yoct=
oproject.org
<piotr=3Dqbee.io@lists.yoctoproject.org> wrote:

> Signed-off-by: Piotr Buli=C5=84ski <piotr@qbee.io>
> ---
>  templates/base.html | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/templates/base.html b/templates/base.html
> index e167139..e31238c 100644
> --- a/templates/base.html
> +++ b/templates/base.html
> @@ -30,6 +30,7 @@
>  <body>
>      {% block header %}
>      {% autoescape on %}
> +    <form id=3D"logout-form" method=3D"post" action=3D"{% url 'logout' %=
}">{%
> csrf_token %}</form>
>      <nav class=3D"navbar navbar-default navbar-fixed-top">
>          <div class=3D"container-fluid">
>              <div class=3D"navbar-header">
> @@ -53,7 +54,7 @@
>                              <b class=3D"caret"></b>
>                          </button>
>                          <ul class=3D"dropdown-menu">
> -                            <li><a href=3D"{% url 'logout' %}">{% trans
> "Log out" %}</a></li>
> +                            <li><a href=3D"#"
> onclick=3D"document.getElementById('logout-form').submit(); return false;=
">{%
> trans "Log out" %}</a></li>
>                              <li><a href=3D"{% url 'password_change' %}">=
{%
> trans "Change password" %}</a></li>
>                              <li><a href=3D"{% url 'profile' %}?return_to=
=3D{{
> request.path }}">{% trans "Edit profile" %}</a></li>
>                          </ul>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3575):
> https://lists.yoctoproject.org/g/yocto-patches/message/3575
> Mute This Topic: https://lists.yoctoproject.org/mt/118566576/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000009d3a6f064e361f2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Minor tweak to subject line: Djang -&gt; Django.<div><br><=
/div><div>Merged to master. Thank you.</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, M=
ar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via <a href=3D"http://l=
ists.yoctoproject.org">lists.yoctoproject.org</a> &lt;piotr=3D<a href=3D"ma=
ilto:qbee.io@lists.yoctoproject.org">qbee.io@lists.yoctoproject.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-o=
ff-by: Piotr Buli=C5=84ski &lt;<a href=3D"mailto:piotr@qbee.io" target=3D"_=
blank">piotr@qbee.io</a>&gt;<br>
---<br>
=C2=A0templates/base.html | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/templates/base.html b/templates/base.html<br>
index e167139..e31238c 100644<br>
--- a/templates/base.html<br>
+++ b/templates/base.html<br>
@@ -30,6 +30,7 @@<br>
=C2=A0&lt;body&gt;<br>
=C2=A0 =C2=A0 =C2=A0{% block header %}<br>
=C2=A0 =C2=A0 =C2=A0{% autoescape on %}<br>
+=C2=A0 =C2=A0 &lt;form id=3D&quot;logout-form&quot; method=3D&quot;post&qu=
ot; action=3D&quot;{% url &#39;logout&#39; %}&quot;&gt;{% csrf_token %}&lt;=
/form&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;nav class=3D&quot;navbar navbar-default navbar-fixe=
d-top&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;div class=3D&quot;container-fluid&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;div class=3D&quot;navba=
r-header&quot;&gt;<br>
@@ -53,7 +54,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;b class=3D&quot;caret&quot;&gt;&lt;/b&gt=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&lt;/button&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&lt;ul class=3D&quot;dropdown-menu&quot;&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;li&gt;&lt;a href=3D&quot;{% url &#39;logout&#3=
9; %}&quot;&gt;{% trans &quot;Log out&quot; %}&lt;/a&gt;&lt;/li&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;li&gt;&lt;a href=3D&quot;#&quot; onclick=3D&qu=
ot;document.getElementById(&#39;logout-form&#39;).submit(); return false;&q=
uot;&gt;{% trans &quot;Log out&quot; %}&lt;/a&gt;&lt;/li&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;li&gt;&lt;a href=3D&quot;{% url &#39;pas=
sword_change&#39; %}&quot;&gt;{% trans &quot;Change password&quot; %}&lt;/a=
&gt;&lt;/li&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;li&gt;&lt;a href=3D&quot;{% url &#39;pro=
file&#39; %}?return_to=3D{{ request.path }}&quot;&gt;{% trans &quot;Edit pr=
ofile&quot; %}&lt;/a&gt;&lt;/li&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&lt;/ul&gt;<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3575): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3575" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3575</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118566576/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/118566576/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000009d3a6f064e361f2d--

