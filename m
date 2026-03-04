Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC8EF9014
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 16:58:07 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23334.1772643477345288886
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 08:57:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=1QCeTwd+;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.50, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c31ca77b4so6951339d50.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:57:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772643476; cv=none;
        d=google.com; s=arc-20240605;
        b=OGkeHumJIfMZaJqVJVNtQH50uMqglxx49TYuwTQVfRZt14F88NozXIpita/Y56kPIx
         LLkuY4Pr9zNhTiBOmuyTQd+Fr1SdW0vk6XRIVm11VBQbRLOrtHSNVjD6ZgF5devopAq6
         2T1UL5dWKE/QA8ga/YGjMgGXW9q47VFDkEGCNobUbRH8u2t6B47cN2qPIM7Fpg4yePa7
         EUg0R335bqKUUHzoQmvx8xZ8NmN/AjvRww7ZvWUTEFSuDFRbGDygTt5mC02IvWDa4tDh
         TiHtk8Yi1ibdash6sSLOPHiKlL0n6ZU6rlUoZoonY3JGYyC5a43gd97jfKJgUSHeTfff
         2VYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VZpgTWuAasW6EYaU9q7U/4CSvFYE/uOJMSvmmkrjOdo=;
        fh=/MH4wvhPUtbRPiZV7Tvq3PiOTTSvYSOpadHYMgLRw3c=;
        b=PDMDkKca/ZWxBEk3UoftPFXSz7FjlRqT8Tp5S5m8/9BpzqDNmNtnm0363qoanWEIDL
         kCr2GrOWsq5ceEbnboIcx1AheXhVu6zunVphcy1nxO2yg6oKl/SsMRlUM+ifP/891VP4
         V0ybF68f+P+aGZNE3V6DA5tPhZPafnifmomAuqsLHA6ThA/MF690GhuqKvb2PQ2qvk+q
         lBX2K20dp3kzGo2zPoNv2z56z0yI1R1ghKBb2qIrx/jjCRwE9GTvdBXEZ79xq4Tzr3+h
         yXsR8fFCx3qOCYueMtr0O8Gm/FEEqv58ir+Z0A2dzKW+3hmbAZ5Gsesuj4/CD5xOdyOg
         90hg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772643476; x=1773248276; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZpgTWuAasW6EYaU9q7U/4CSvFYE/uOJMSvmmkrjOdo=;
        b=1QCeTwd+38uRt+TGAM3fYI+rcsRIEdb1j68Dd8yCUk9F02WYgVJf1GD1Fj/UCqYs+Y
         2MmqNMiHG5Gbbs004QSQ/OwjZ5+GytxkAYEzUxRn+TOrWDfpY/Tv/rt04L68Z3J2dxOO
         qanI39ofO8ONC8lzj9ndEQ5Ap5VbrZh3epo3oNe8nMD+iwoPwWPlpD6lZ6V2jYZuA1zu
         pZnuTFNbreDaPO7P2oVzvEXmA7gFKFky8FJXDHzbGs/DXWQxIbLt2PUZHYQsS3MDuy9f
         41OarqkCIMbFQhRFxMFP2obR8S1Fr15cCRto83Mno+dLLccjbMqxd99+9SdQ672/EWZB
         mJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643476; x=1773248276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZpgTWuAasW6EYaU9q7U/4CSvFYE/uOJMSvmmkrjOdo=;
        b=uejDBEM6K/S8uyzVrdWPPSFGNpgMsYNxaKBhg+wd3GeRpWrq1mA4YbIUokLuwqrEEm
         v5hBr1fmuTMD+qTj/SKIxiCgt1qZQUERS2Eqhin9XoG7C8DhGO4k0ioHh/0qhpiUHxYb
         NwN9qS5JdBTlDqRXzlX+bIlhZ3bTmgjh+DnVxeT3TQJL47ijEzktcGGyjaPISOUcjpAf
         X6BMBUbROu6UeGSz6xyoaKIz2yUIxTPBVVpRgSfRxIXrOGQCkd6dnChbYwJfJ9mlOV0Q
         NexgISGq3T19jEXmEmNh1jvadXtWHRnlU1I6Ju3iPW9ls6uUP69Ke3K0Gyh17P7Zj/Sv
         1TKw==
X-Gm-Message-State: AOJu0Yz8cxUhDAZr5tmpAeUEIrXb/1/0g6o3+dqlJAMyYRaByPl3Eqbe
	NILqk/C6ANXURP7l6Om352ut1XekyZ4e9Yc+uo1imp1PuY9etfrpn170DfWfM5pFhd6MeqZitQ+
	gb9n6c6ap6JCM9qEmvO77AYyTynTVGqriw4XVQhpLsqKQjUcwgduV
X-Gm-Gg: ATEYQzx8C3sDUvJWgeOGMwPFX6Sdct3dZwBjS5oEDqKUyxIPQLwi6od6fdQZav1/TT4
	TfvqpGeRZfFCDEWdzvZR0/2L2zOsgx1juFIUOyKC5EnffjcGLpiSnPhwejj3Tqrq+G4oQ8rZG8j
	HhMde93qn+4rGTqhta7Ed8KbvM4o4P4PMA6hcr/LwFhO/zSQ7qBK87JsPRDAVL7LmKQk7vR/MPs
	mG/0OzVyt4wF+snffsHcLl6zMcEBeIjxtozIdCzf1U5UEEN7IZLvQtEYtF2Wwk+7rX4V48vfT2k
	l3Wh8XwgTetiS2rMiy/nnR8EBD9xmXdS5aXbqQYlqggh+wVQATaXFUFuZzii/K7pG+Ojxw==
X-Received: by 2002:a05:690e:1a5a:b0:64a:ce20:d9e0 with SMTP id
 956f58d0204a3-64cf9bae8c5mr1529163d50.46.1772643476444; Wed, 04 Mar 2026
 08:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20260304160454.1988923-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260304160454.1988923-1-richard.purdie@linuxfoundation.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 4 Mar 2026 10:57:45 -0600
X-Gm-Features: AaiRm50DldFmDLNYoHTCvCU8WoJS15z22OLL0Q4aYP1DQ6aI1iUkDXjtrkYhyiE
Message-ID: <CAOU5ZMuiK5a0h1hCEXECbLUwKLeyHmN6FWT+OcSgvt8PrcxOSA@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH] main.c: Set PYTHONUNBUFFERED in the environment
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000ba27a2064c35b865"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 16:58:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3333

--000000000000ba27a2064c35b865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied thanks!,

If we add more variables or cases to the environment, we could refactor to
a function later.


On Wed, Mar 4, 2026 at 10:04=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> When python tests are run, on a normal terminal they output unbuffered bu=
t
> they behave differently, buffering the output. This creates issues with t=
he
> timeout handling that ptest-runner uses. This is the cause of some of the
> strange ptest timeout issues we see.
>
> Set the environment variable in all cases to avoid this. An alternative
> would be to update every ptest runner script that uses python but that
> seems
> to be a lot of work for no good reason when we can just set it here.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/main.c b/main.c
> index 594d198..3d5b0d4 100644
> --- a/main.c
> +++ b/main.c
> @@ -238,6 +238,13 @@ main(int argc, char *argv[])
>         for (i =3D 0; i < ptest_exclude_num; i++)
>                 ptest_list_remove(run, opts.exclude[i], 1);
>
> +       /* python programs need to use unbuffered output for our timeouts
> to work correctly */
> +       rc =3D putenv("PYTHONUNBUFFERED=3D1");
> +       if (rc) {
> +               fprintf(stderr, "Couldn't putenv: %d\n", rc);
> +               exit(1);
> +       }
> +
>         rc =3D run_ptests(run, opts, argv[0], stdout, stderr);
>         fprintf(stdout, "TOTAL: %d FAIL: %d\n", ptest_list_length(run),
> rc);
>         if (rc > 0)
>

--000000000000ba27a2064c35b865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied thanks!,<div><br></div><div>If we add more variabl=
es or cases to the environment, we could refactor to a function later.</div=
><div>=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2026 at 10:04=E2=80=
=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.o=
rg">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">When python tests are run, on a norma=
l terminal they output unbuffered but<br>
they behave differently, buffering the output. This creates issues with the=
<br>
timeout handling that ptest-runner uses. This is the cause of some of the<b=
r>
strange ptest timeout issues we see.<br>
<br>
Set the environment variable in all cases to avoid this. An alternative<br>
would be to update every ptest runner script that uses python but that seem=
s<br>
to be a lot of work for no good reason when we can just set it here.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0main.c | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/main.c b/main.c<br>
index 594d198..3d5b0d4 100644<br>
--- a/main.c<br>
+++ b/main.c<br>
@@ -238,6 +238,13 @@ main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ptest_exclude_num; i++)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest_list_remove(r=
un, opts.exclude[i], 1);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* python programs need to use unbuffered outpu=
t for our timeouts to work correctly */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D putenv(&quot;PYTHONUNBUFFERED=3D1&quot;)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Couldn&#39;t putenv: %d\n&quot;, rc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D run_ptests(run, opts, argv[0], stdout, s=
tderr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stdout, &quot;TOTAL: %d FAIL: %d\n&quot=
;, ptest_list_length(run), rc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &gt; 0)<br>
</blockquote></div>

--000000000000ba27a2064c35b865--

