Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B8C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 15:17:27 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.25452.1751555838952140980
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 08:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=08jP83pD;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.170, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-714078015edso62143077b3.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1751555838; x=1752160638; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCPTQaCKLHknCloxZgv6KYYggaemK38KKi1FdyGhilE=;
        b=08jP83pDqu7Y19dDk/AA/F4Q1R3w24ki71S/kP/NHTIzW6FPH4NXeBYaZvMd3v7COI
         8V+yI4QJMexSWIsrVCifKECtDxRUaI/TdQ1w9dE4Vl7IdnQ0m5bXyvJB0zNiJPw+lSj2
         Ds1mNqWEVHEgwmwcQdgd3HyOPjhvhRirKOX53R7WuguENt7UbQrvhgq5z3B+jc2QjSrx
         M/UYtOpT0VtMYH1v+yO/lhIvz8rMyRSGyDDhMNWLko3HRfmnfrPm/Vxmhecn6SZRbVf9
         5G65IRLvlyVCRTqRtBbd63Dm4iFVEhgFRuhiyDwWWbBG1NFi8l620JdmxQ+44ZyS/n3x
         HdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555838; x=1752160638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCPTQaCKLHknCloxZgv6KYYggaemK38KKi1FdyGhilE=;
        b=U7X1exe+Hpihoap0KKLRdE3tcSFSoJOzTOO4v4X8++l1xPZxc+1IzNVkQTWhJrg2aJ
         KHQSdLmZWes/PZ6k7c7YGmTVNg3BxwEwlqusIfzVVmdB0kERH1WAZdpvqiAIAhvGzMic
         aWqOJNpAq+DXn8XbaeaHMJj0XyqZ84nJO++smw3vLSJOJS+i4K0mLeZQdJjVl0jG8/F5
         +ug9j1DIRiBy89tRfWwqSVDcyyG7JL0FWSLEyettOaz4KwVy3R4H/R7Ib+VvFABJKh9U
         LYXto9dYLxiayK6h8Kri3PfkiTR/DdVbooqq0UsEuUwiIVrceLFEorrbcITCKq+JgKlE
         DXUw==
X-Gm-Message-State: AOJu0YyXGqySfPypwBqOEPg4AiOhqlGc45+lkHvtCY9xA4K2xqA0Z9I0
	5YUVFJQLZh8ffrTqF3Lgw+bG3PXgJ/qaJmp/biBKwMKgf5kjKwD1sZPMmC7yPbkB+VAgLKIY+3N
	QnYJ+NWab/ZA6fcJyvfJdXo74cGwiCbqaa0rYmM2uBg==
X-Gm-Gg: ASbGncsoRvsvXpspCjtYb3FvEMijIU4wVpLJQwjnc+gvKDPqD/V9/8Xw7TQy9/dIEHS
	hY/lx8GM7Zw53qDgKwlH8bzAh+X1mE65VY2CzqVEtnxsM2BvQPTmujJSl+qPQCQrDt9h5rxgUng
	eXQHa/+kihoeeNGK6z93Jptq8zuii3jsn9tigSdxSSd3eYLgN4X5Kngj8=
X-Google-Smtp-Source: AGHT+IEp6N8Xb/GXfKm+qPD8dnCSGBVqP6ZC1kLX76quqyulKLsbPSpdhok8pHbhREIAdDDwfTZhP45XA1Mi29bxop0=
X-Received: by 2002:a05:690c:4b12:b0:712:e2b5:e61b with SMTP id
 00721157ae682-7164d2c794amr113813697b3.13.1751555837747; Thu, 03 Jul 2025
 08:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <036b0e6d97c28f21acc8a3fa855240b24e2d850c.1751552135.git.joerg.sommer@navimatix.de>
In-Reply-To: <036b0e6d97c28f21acc8a3fa855240b24e2d850c.1751552135.git.joerg.sommer@navimatix.de>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 3 Jul 2025 09:17:06 -0600
X-Gm-Features: Ac12FXwWE1XVw0ShiC-HsT4GSL49q5IBOPFCqViYgfNLncfKjevtn9XdVsHK0x8
Message-ID: <CAOU5ZMuv9eUJ+cB8ewmtfecLc7Y3Ri-CCS7RigEy=Nwx_JeSeQ@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH] main.print_usage: Remove unused argument
 list of -l
To: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
Cc: yocto-patches@lists.yoctoproject.org, nata.dobrick@gmail.com
Content-Type: multipart/alternative; boundary="000000000000836fbc063907df40"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 15:17:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1745

--000000000000836fbc063907df40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

I will apply this patch!,

Cheers!,
Anibal

On Thu, Jul 3, 2025 at 8:15=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@navim=
atix.de>
wrote:

> From: Natalie Dobrick <nata.dobrick@gmail.com>
>
> Removed unused argument 'list' from usage message because the
> option -l does not take an argument according to the *get_opt*
> specification and *print_list* gets nothing passed, too.
>
> Signed-off-by: Natalie Dobrick <nata.dobrick@gmail.com>
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/main.c b/main.c
> index 31e4dd5..feb0685 100644
> --- a/main.c
> +++ b/main.c
> @@ -47,7 +47,7 @@
>  static inline void
>  print_usage(FILE *stream, char *progname)
>  {
> -       fprintf(stream, "Usage: %s [-d directory directory2 ...] [-e
> exclude] [-l list] [-t timeout]"
> +       fprintf(stream, "Usage: %s [-d directory directory2 ...] [-e
> exclude] [-l] [-t timeout]"
>                         " [-x xml-filename] [-h] [ptest1 ptest2 ...]\n",
> progname);
>  }
>
> --
> 2.48.1
>
>

--000000000000836fbc063907df40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi J=C3=B6rg,<div><br></div><div>I will apply this patch!,=
</div><div><br></div><div>Cheers!,</div><div>Anibal</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Jul 3, 2025 at 8:15=E2=80=AFAM J=C3=B6rg Sommer &lt;<a href=3D"=
mailto:joerg.sommer@navimatix.de">joerg.sommer@navimatix.de</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Natalie Do=
brick &lt;<a href=3D"mailto:nata.dobrick@gmail.com" target=3D"_blank">nata.=
dobrick@gmail.com</a>&gt;<br>
<br>
Removed unused argument &#39;list&#39; from usage message because the<br>
option -l does not take an argument according to the *get_opt*<br>
specification and *print_list* gets nothing passed, too.<br>
<br>
Signed-off-by: Natalie Dobrick &lt;<a href=3D"mailto:nata.dobrick@gmail.com=
" target=3D"_blank">nata.dobrick@gmail.com</a>&gt;<br>
Signed-off-by: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimati=
x.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
---<br>
=C2=A0main.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/main.c b/main.c<br>
index 31e4dd5..feb0685 100644<br>
--- a/main.c<br>
+++ b/main.c<br>
@@ -47,7 +47,7 @@<br>
=C2=A0static inline void<br>
=C2=A0print_usage(FILE *stream, char *progname)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stream, &quot;Usage: %s [-d directory d=
irectory2 ...] [-e exclude] [-l list] [-t timeout]&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stream, &quot;Usage: %s [-d directory d=
irectory2 ...] [-e exclude] [-l] [-t timeout]&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; [-x xml-filename] [-h] [ptest1 ptest2 ...]\n&quot;, progn=
ame);<br>
=C2=A0}<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000836fbc063907df40--

