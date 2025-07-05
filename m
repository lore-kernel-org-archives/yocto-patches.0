Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD88C8303C
	for <webhook@archiver.kernel.org>; Sat,  5 Jul 2025 14:21:04 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.18466.1751725257941527319
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Jul 2025 07:20:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=lCONXA4C;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.172, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71173646662so15101947b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Jul 2025 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1751725257; x=1752330057; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HahQSLMfvx1sZu5Fj/RA77Rfhu728nWrxIDvZdsEptU=;
        b=lCONXA4CwS27Ke1CpHLZLUReZfT7aETxAo9T0WajxXgC2+nmlsBsLJoWtSRPbonjwv
         bueJFIoyHWOZJ8UQTMNHuvAOTykvEh0qSO19FpHVhBljhcVzWmrUoUQcYmt97q2ro9nl
         vcGr56LFEiwB5e3saMBfHmtvI5QRNCaboXeYbRHCv437QC9s+8/l2L6H+lnYusI6j3HP
         f29iym+4VXcg/Y9EyL6Ul0aCTLtmAb0UlbSNBLjCjOvswNaJlWchL0QZ0frO8Z5KB79x
         hz+JEL2yIGB5L9cXqv3SnQLYLYoDLos4eTwM0QwDHqZQ7Uxtp6SbSzCA9wSHs6sVP+Bo
         TcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751725257; x=1752330057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HahQSLMfvx1sZu5Fj/RA77Rfhu728nWrxIDvZdsEptU=;
        b=Ygbcl8CitMzy/bQEyJ3e1YQNPkI8l36ErwZwtezMkufxWqPuwQ8Ho0uW4zJyCZbKdQ
         RXP6ZvHnNdvKeDlX9e2WQ1bV7MddGyabG+wqrlAoRPYGkZjfDWUuTkaRC53OIR0dUz/E
         bE807S3r9btCHpLHx6MXRW+L1ZZXMoENQYEUzqGHM+eGeh3cT54aWyrfEsATKwkaN6P1
         iFaUA+ZLEhowitRPPRn2vuv9zC7oB/gLCJRFmeY6tr3XQvc0RvJe7vUbjqPpG9/NkquD
         1uCyh0HG+4CNnUjklu7C5jDJiXTQEg4xKBwWrCszA+CWTEev9mI1ugsYrWhqveEyM2LO
         /4/A==
X-Gm-Message-State: AOJu0YwmW+XQMia6pUadrl99zzaV1a+4jp7eb9tEiDuo/4LwHPP1eIie
	clGU5Yw4Udyc6tlGEwH9Bjej+cXe2pzE4LJtP/777Wd0//l6STRg9bdJs482e5IuXK2V1h7VPx/
	K9JW3U+mVNLB1ZP4C07OXg1IW/lYxxvQcPFiC7oUbzQ==
X-Gm-Gg: ASbGncvw1tzCCH6MkWONRfy2EYXYRvYzCtKUuF4GVnsfIT3q9xEpvMZEtFyP7Pg2DFv
	q6Cag01vOQRH4gM0qTy4T+ZAu2aPbhYYzvhCb2iWH3cRyJbr34e8b6zvjJSd2NfBxQJJOmgE935
	YhkiLZHijSEGLBsjV6EzrAyiJ97DUhxXmOQ2e4OGx2rSi8eA==
X-Google-Smtp-Source: AGHT+IFpVK270tead2xrAMfDa+pxOIqeSEXJj8SsXoQsEuTxdWZVx3h2irGmTah7Y/3Lb0v9kglEiuuqP6Bqv6JcacI=
X-Received: by 2002:a05:690c:387:b0:712:d70b:45cc with SMTP id
 00721157ae682-71668cf2015mr79566957b3.8.1751725256900; Sat, 05 Jul 2025
 07:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <61615a15a0fbc852291cf2852972ce38b700ffd7.1751650751.git.joerg.sommer@navimatix.de>
In-Reply-To: <61615a15a0fbc852291cf2852972ce38b700ffd7.1751650751.git.joerg.sommer@navimatix.de>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Sat, 5 Jul 2025 08:20:46 -0600
X-Gm-Features: Ac12FXyuumgNlvvsOpCUOaZk1jouYyf5eVx02pm1sVLrEMPHdUAJlYeQApADwF8
Message-ID: <CAOU5ZMtqzRJ3V8gsV3Gixou=sxb_QDA8yVY7xz_q_zzR-ggaug@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH] main.c: Add print_helptext() for detailed help
To: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
Cc: yocto-patches@lists.yoctoproject.org, nata.dobrick@gmail.com
Content-Type: multipart/alternative; boundary="000000000000ae946606392f511f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Jul 2025 14:21:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1768

--000000000000ae946606392f511f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg, Nata,

Applied,

Thanks!,
Anibal

On Fri, Jul 4, 2025 at 11:41=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@navi=
matix.de>
wrote:

> From: Natalie Dobrick <nata.dobrick@gmail.com>
>
> The flag -h should give a more detailed message to understand the usage o=
f
> the flags.
>
> Signed-off-by: Natalie Dobrick <nata.dobrick@gmail.com>
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  main.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
>
> Feel free to amend the help message. It's only a suggestion to give a
> better user experience.
>
>
> diff --git a/main.c b/main.c
> index feb0685..594d198 100644
> --- a/main.c
> +++ b/main.c
> @@ -51,6 +51,26 @@ print_usage(FILE *stream, char *progname)
>                         " [-x xml-filename] [-h] [ptest1 ptest2 ...]\n",
> progname);
>  }
>
> +static inline void
> +print_help(FILE *stream, char *progname)
> +{
> +       print_usage(stream, progname);
> +       fprintf(stream,
> +               "\n  Runs all Yocto/Openembedded ptests installed in "
> DEFAULT_DIRECTORY
> +               "/*/ptest/run-ptest by default.\n\n"
> +               "Options:\n\n"
> +               "  -d DIRS              Load tests from one or more
> directories. (default: " DEFAULT_DIRECTORY ")\n"
> +               "                       DIRS must be a list separated by
> spaces.\n"
> +               "  -e NAMES             Exclude specified tests from
> execution.\n"
> +               "                       NAMES must be a list separated by
> spaces.\n"
> +               "  -h                   This help message.\n"
> +               "  -l                   List all available tests and
> exit.\n"
> +               "  -t SECONDS           Set a timeout (in seconds) for
> each test. (default: %d)\n"
> +               "  -x FILE              Write test results to an XML
> file.\n"
> +               "\n", DEFAULT_TIMEOUT
> +       );
> +}
> +
>  static char **
>  str2array(char *str, const char *delim, int *num)
>  {
> @@ -148,7 +168,7 @@ main(int argc, char *argv[])
>                                 opts.timeout =3D (unsigned int) atoi(opta=
rg);
>                         break;
>                         case 'h':
> -                               print_usage(stdout, argv[0]);
> +                               print_help(stdout, argv[0]);
>                                 exit(0);
>                         /* break; not needed, not reachable after exit() =
*/
>                         case 'x':
> --
> 2.48.1
>
>

--000000000000ae946606392f511f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi J=C3=B6rg, Nata,<div><br></div><div>Applied,</div><div>=
<br></div><div>Thanks!,</div><div>Anibal</div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Jul 4, 2025 at 11:41=E2=80=AFAM J=C3=B6rg Sommer &lt;<a href=3D"mailto:joe=
rg.sommer@navimatix.de">joerg.sommer@navimatix.de</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">From: Natalie Dobrick &lt;=
<a href=3D"mailto:nata.dobrick@gmail.com" target=3D"_blank">nata.dobrick@gm=
ail.com</a>&gt;<br>
<br>
The flag -h should give a more detailed message to understand the usage of<=
br>
the flags.<br>
<br>
Signed-off-by: Natalie Dobrick &lt;<a href=3D"mailto:nata.dobrick@gmail.com=
" target=3D"_blank">nata.dobrick@gmail.com</a>&gt;<br>
Signed-off-by: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimati=
x.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
---<br>
=C2=A0main.c | 22 +++++++++++++++++++++-<br>
=C2=A01 file changed, 21 insertions(+), 1 deletion(-)<br>
<br>
<br>
Feel free to amend the help message. It&#39;s only a suggestion to give a b=
etter user experience.<br>
<br>
<br>
diff --git a/main.c b/main.c<br>
index feb0685..594d198 100644<br>
--- a/main.c<br>
+++ b/main.c<br>
@@ -51,6 +51,26 @@ print_usage(FILE *stream, char *progname)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; [-x xml-filename] [-h] [ptest1 ptest2 ...]\n&quot;, progn=
ame);<br>
=C2=A0}<br>
<br>
+static inline void<br>
+print_help(FILE *stream, char *progname)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0print_usage(stream, progname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stream,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\n=C2=A0 Runs=
 all Yocto/Openembedded ptests installed in &quot; DEFAULT_DIRECTORY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/*/ptest/run-=
ptest by default.\n\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Options:\n\n&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -d DIR=
S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Load tests from one or mo=
re directories. (default: &quot; DEFAULT_DIRECTORY &quot;)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DIRS =
must be a list separated by spaces.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -e NAM=
ES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exclude specified tests f=
rom execution.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NAMES=
 must be a list separated by spaces.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -h=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This help=
 message.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -l=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0List all =
available tests and exit.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -t SEC=
ONDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set a timeout (in seconds) for=
 each test. (default: %d)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 -x FIL=
E=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Write test results to an =
XML file.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\n&quot;, DEF=
AULT_TIMEOUT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
+}<br>
+<br>
=C2=A0static char **<br>
=C2=A0str2array(char *str, const char *delim, int *num)<br>
=C2=A0{<br>
@@ -148,7 +168,7 @@ main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.timeout =3D (unsigned int) atoi=
(optarg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case &#39;h&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_usage(stdout, argv[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_help(stdout, argv[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* break; not needed, not reachable after exit() */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case &#39;x&#39;:<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000ae946606392f511f--

