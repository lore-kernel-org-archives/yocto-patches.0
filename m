Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DECFD0075
	for <webhook@archiver.kernel.org>; Sun,  1 Mar 2026 19:38:48 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.144851.1772393918640310025
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Mar 2026 11:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=HBQsS4Fx;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.44, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9f7576d4so2612906d50.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 01 Mar 2026 11:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772393918; cv=none;
        d=google.com; s=arc-20240605;
        b=RhBFvFUJTtPoNY929cPo6Po8N2S9fdSgoc05ujwPM0snuqfUAT35Qb6jppJojKPsqD
         dWfaB+LUFfceo9ZK8frDS2bF1E6I3fvgQZ1VVsE2f2JPu2I5oCd5F3Jivfa2w642Y+Ew
         fN5LZY4YriceFAtCxxkj+Bhs48hO0oh6iV6w/5tFOqPXmUDpNN2fS8rZDb7sNm6iBvbC
         bBhy2RWx5fd6xVRsmCCFKUzxHpQC89w7vNJhVoUHrJhPvj0ODa5fkt3tk5D9xdEJ2HUn
         ub32zDQqawTVXFEvqdTVfXRtkCbRkNnXNV/ONRF82HRN388YK8SZqGVdoiJCK+1fEQ+t
         ZwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kKUbo2NHXK+vmuPiKJMxh7lPwvRk0srgm+Xo7+wSIOk=;
        fh=yLBxv/52CWn0pBdf5TTAUaoOmFFwMs4CvCxKvfS4TI0=;
        b=URowcc5lRbxYwu+JOClbum0/8HkrV0Phs8AUV5RACwM5VrlnlEOktZdPqd+c6aOIdZ
         gbY1dKJrMCoFgk6rbo4Zp5ARyMpGlxEpt2O8P1gsGrHvghCfN3o6KgoK9FT24DgblYUP
         54GSGxIps5c1TRRn8GsrV7cbUsqj+QtobVWxYrzZvdPvrooZ1iFbVq83HHYaH7vA08aG
         HKes4GBh8jraW1D7+agcJhN0abjB09VqiXZJ2cqWQ0OacAiphZ83iHxiokAqb+I+WcZd
         Zy7qYo3mZuDcu1v566xIpNdzJeYqZDY45rfc9FImAMW2wzGgVY+mlSNQgF719dRptBIz
         6nUw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772393918; x=1772998718; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kKUbo2NHXK+vmuPiKJMxh7lPwvRk0srgm+Xo7+wSIOk=;
        b=HBQsS4Fx7Cc0zkmBPmuVnuBjrdzpQUr1RO42Ekoe86+FdKIjRwb5UXmILZSxbcefk5
         X44EAczVP6MFYn5cYkIUWsPfZ9/8Vq06TtrIna294ABA9LjH3PBYlZEPCW11AQyuV6mo
         ZMO/rpFu+7UBnfk88IejI7lJzmJB9gyZ8S0JLnWmBELf7z4UQSRDML15G+7g7eHYvRn2
         60DpToZ/B8CQwwBPkZbInuM9lFgouOEJh/DQTF8D8Ss9J3fGDCS9bjgdrrX1nekLmz6R
         64BAADoYKFwWUFpEIQM6Z2j0LCV2AhD420FVQkQ3oAa0NjcGFdiQuGUodcZWvHHbOQHW
         nKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772393918; x=1772998718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKUbo2NHXK+vmuPiKJMxh7lPwvRk0srgm+Xo7+wSIOk=;
        b=NR5tXRSl11cPjtLqbHAhxASmRunncKmz+XbRi0IdTzUTtuOcfHqtbneLooYcIyESQJ
         Mnj9AD/NNL0be/3C4eHZYHsyaFpFg2odh0LjKh4enU1C9DWsJOVLDxrXaFC1lZK58m+x
         eF/eeshh5FO4+Q4MiAAQF7IBW2Ks/5WgtZfIfvXor8+SpUkJrsT3TqQutGzyv3c2+tO1
         ezl4WB5nIWDjcyWsxwYPgOejFLTX1L9GZi9PVefUW2CgHzzdRDGH7splflqMUJmdI8od
         fUgZeB7OvuyGYMAEiRR62PlIMabpfjeYlyMrIADyaejus8bKrMAACWwKzhZqiKmjlJKU
         4izg==
X-Gm-Message-State: AOJu0Ywdq7fpzgauyh0qFjdcDOX3YP0oGv1olVbmmumozrXcRB59h+G6
	vjgX+cgzSyQqtcNvUnbIpE1YQZuTgQ/m0d6QrDdqZefBZFMEhkWkaQ6bX1C3MDDGuAVoGSZBNgT
	mPKXyzc7S8tR4mW7HPXBHbSOw6k/9VyvpEt6/x5OKKg==
X-Gm-Gg: ATEYQzznPHoPfYGzMKshb0f/oWlJirMfLNejGi4kppuIBQ0xX5fuCAlNZTNkGYDezIA
	EA8LMhGVtN7c6dq3MPZ9mrNEaaQF2tTG+RUkuj84Kkky1g+pslNmHdqGH44bcdCsby6wd3BR0Zc
	FPrDJwYNjJFkSBXqwNmB9jyFX2YwEFjK+Quk1Jw2U7BukL5324cMJLcaZYOLi/9+OfNC6EMCBpg
	19DwSaQYlQVOf4p7y0vELW3QOQKAMbAU8NhUGLgocfQn6tjmFv6UuK+KNbbnKd1CnDRpR7wVPs/
	kjhH8ocjD3RwSGpKIGrfqoxAPXEhQlMvsO/ZS/B+XiUsVY+oy09a5wgw43hh5tXm8m/5kg==
X-Received: by 2002:a05:690e:2594:b0:64c:9fe1:38d7 with SMTP id
 956f58d0204a3-64cc237ceb0mr5458806d50.85.1772393917660; Sun, 01 Mar 2026
 11:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
 <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com> <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
 <1eb39bda-cb9f-4435-b784-540f203c8ef7@codasip.com> <CAOU5ZMs+SgsAXWp7rO-C=TYKf90ER9N5fLzVfEx2P6ZXm=dxFA@mail.gmail.com>
 <290045a9-e932-4808-92ec-6e0d57dd441a@codasip.com>
In-Reply-To: <290045a9-e932-4808-92ec-6e0d57dd441a@codasip.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Sun, 1 Mar 2026 13:38:27 -0600
X-Gm-Features: AaiRm51VxkWVZw1ecRWjM6QtsEFqbZbcUy5XCdajNMd1XdzdKplw0XcgibeqMsE
Message-ID: <CAOU5ZMuVdhRBonT8EofssLwM26bNgVhR=OeQawJR=VhjOBc9pw@mail.gmail.com>
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000dd52b9064bfb9d45"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 01 Mar 2026 19:38:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3312

--000000000000dd52b9064bfb9d45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 4:57=E2=80=AFAM Florian Schmaus <florian.schmaus@cod=
asip.com>
wrote:

> On 27/02/2026 22.02, Anibal Limon wrote:
> >
> >
> > On Fri, Feb 27, 2026 at 2:37=E2=80=AFPM Florian Schmaus
> > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>>
> wrote:
> >
> >     On 27/02/2026 21.20, Anibal Limon wrote:
> >      >
> >      >
> >      > On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus
> >      > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com=
>
> >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>> wrote:
> >      >
> >      >     On 27/02/2026 16.58, Anibal Limon wrote:
> >      >      > Hi Florian,
> >      >
> >      >     Hi Anibal,
> >      >
> >      >
> >      >      > Thanks for the patch, comments below,
> >      >
> >      >     Thanks for looking at my patch.
> >      >
> >      >
> >      >      > Can you refer me to the musl dirname(3) function that use=
s
> >     static
> >      >      > allocation?.
> >      >      > I reviewed [1] and found that modifying the same string
> anyway
> >      >     doing the
> >      >      > assignment is needed.
> >      >
> >      >     Oh, right. It's the CHERI-enable musl libc that is using a
> static
> >      >     allocation [1]. I wasn't aware that this is a deviation from
> >     upstream.
> >      >
> >      >     But it doesn't really matter, the current usage of dirname()
> >     is fragile
> >      >     and should be fixed.
> >      >
> >      >
> >      >      > [1] https://git.musl-libc.org/cgit/musl/tree/src/misc/
> >     dirname.c <
> https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
> >      >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
> >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>
> >      >      > <https://git.musl-libc.org/cgit/musl/tree/src/misc/
> >     dirname.c <
> https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
> >      >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
> >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>>
> >      >      >
> >      >      > On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus
> >      >      > <florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>
> >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>
> >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>
> >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>>> wrote:
> >      >      >
> >      >      >     It is required to use the return value of dirname()
> >     instead of
> >      >      >     assuming that dirname() modifies the input string.
> >     While certain
> >      >      >     implementations of dirname(), for example glibc, *may=
*
> >     modify the
> >      >      >     input string, this is not guaranteed behavior. Musl,
> >     on the other
> >      >      >     hand, does not modify the input string but instead
> >     returns a
> >      >     pointer
> >      >      >     to a statically allocated string.
> >      >      >
> >      >      >     Previously, ptest-runner would fail on musl systems:
> >      >      >
> >      >      >     $ ptest-runner busybox
> >      >      >     START: ptest-runner
> >      >      >     2026-02-27T09:21
> >      >      >     BEGIN: /usr/lib/busybox/ptest/run-ptest
> >      >      >     ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-
> >     ptest), Not a
> >      >      >     directory
> >      >      >
> >      >      >     ERROR: Exited from signal Killed (9)
> >      >      >     DURATION: 0
> >      >      >     END: /usr/lib/busybox/ptest/run-ptest
> >      >      >     2026-02-27T09:21
> >      >      >     STOP: ptest-runner
> >      >      >     TOTAL: 1 FAIL: 1
> >      >      >
> >      >      >     Signed-off-by: Florian Schmaus
> >     <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>
> >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>
> >      >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>
> >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>>>
> >      >      >     ---
> >      >      >       utils.c | 12 +++++++++---
> >      >      >       1 file changed, 9 insertions(+), 3 deletions(-)
> >      >      >
> >      >      >     diff --git a/utils.c b/utils.c
> >      >      >     index 6cf7705586bc..7614dce99bd8 100644
> >      >      >     --- a/utils.c
> >      >      >     +++ b/utils.c
> >      >      >     @@ -361,13 +361,19 @@ run_ptests(struct ptest_list
> >     *head, const
> >      >      >     struct ptest_options opts,
> >      >      >
> >      >      >                      fprintf(fp, "START: %s\n", progname)=
;
> >      >      >                      PTEST_LIST_ITERATE_START(head, p)
> >      >      >     -                       char ptest_dir[PATH_MAX] =3D
> {'\0'};
> >      >      >     +                       char *ptest_dir;
> >      >      >     +                       char run_ptest[PATH_MAX] =3D
> {'\0'};
> >      >      >                              int pipefd_stdout[2] =3D {-1=
,
> -1};
> >      >      >                              int pipefd_stderr[2] =3D {-1=
,
> -1};
> >      >      >                              int pty[2] =3D {-1, -1};
> >      >      >
> >      >      >     -                       strcpy(ptest_dir,
> p->run_ptest);
> >      >      >     -                       dirname(ptest_dir);
> >      >      >
> >      >      >
> >      >      > strcpy(ptest_dir, p->run_ptest); // This assumes ptest_di=
r
> and
> >      >     run_ptest
> >      >      > are both PATH_MAX; perhaps improve with a secure version
> >     of strcpy?
> >      >
> >      >     Not sure if I understand the comment. My patch is using
> >     strlcpy() and
> >      >     should be safe.
> >      >
> >      >
> >      >
> >      >      > ptest_dir =3D dirname(ptest_dir);
> >      >
> >      >
> >      > I mean making this change should be enough
> >     That doesn't work as it would assign to an array type.
> >
> >
> > A possible implementation could be:
> >
> > ```
> > --- a/utils.c
> > +++ b/utils.c
> > @@ -361,13 +361,14 @@ run_ptests(struct ptest_list *head, const struct
> > ptest_options opts,
> >
> >                  fprintf(fp, "START: %s\n", progname);
> >                  PTEST_LIST_ITERATE_START(head, p)
> > -                       char ptest_dir[PATH_MAX] =3D {'\0'};
> > +                       char ptest_dir_tmp[PATH_MAX] =3D {'\0'};
> > +                       char *ptest_dir =3D NULL;
> >                          int pipefd_stdout[2] =3D {-1, -1};
> >                          int pipefd_stderr[2] =3D {-1, -1};
> >                          int pty[2] =3D {-1, -1};
> >
> > -                       strcpy(ptest_dir, p->run_ptest);
> > -                       dirname(ptest_dir);
> > +                       strcpy(ptest_dir_tmp, p->run_ptest);
> > +                       ptest_dir =3D dirname(ptest_dir_tmp);
> >
> >                          if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
> >                                  fprintf(fp, "ERROR: pipe2() failed
> > with: %s.\n", strerror(errno));
>
> Thank you for taking the time to look into this. I noticed your patch
> uses strcpy() instead of strlcpy(). While I generally prefer
> size-limited string copies for security reasons, as the maintainer, it's
> ultimately your call.
>
>

I'm open to changing strlcpy(), if the potential patch up + strlcpy()
change works for you.
I would be glad to integrate. Let me know.

Cheers!,
Anibal


> - Florian
>
>
>

--000000000000dd52b9064bfb9d45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 1, =
2026 at 4:57=E2=80=AFAM Florian Schmaus &lt;<a href=3D"mailto:florian.schma=
us@codasip.com">florian.schmaus@codasip.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 27/02/2026 22.02, Anibal Limo=
n wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Feb 27, 2026 at 2:37=E2=80=AFPM Florian Schmaus <br>
&gt; &lt;<a href=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">f=
lorian.schmaus@codasip.com</a> &lt;mailto:<a href=3D"mailto:florian.schmaus=
@codasip.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 27/02/2026 21.20, Anibal Limon wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Flori=
an Schmaus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:florian.schmaus@codasip=
.com" target=3D"_blank">florian.schmaus@codasip.com</a> &lt;mailto:<a href=
=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@c=
odasip.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;&gt; wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 27/02/2026 16.58, Aniba=
l Limon wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Florian,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hi Anibal,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thanks for the patch=
, comments below,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Thanks for looking at my p=
atch.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Can you refer me to =
the musl dirname(3) function that uses<br>
&gt;=C2=A0 =C2=A0 =C2=A0static<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; allocation?.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I reviewed [1] and f=
ound that modifying the same string anyway<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0doing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; assignment=C2=A0is n=
eeded.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Oh, right. It&#39;s the CH=
ERI-enable musl libc that is using a static<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0allocation [1]. I wasn&#39=
;t aware that this is a deviation from<br>
&gt;=C2=A0 =C2=A0 =C2=A0upstream.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0But it doesn&#39;t really =
matter, the current usage of dirname()<br>
&gt;=C2=A0 =C2=A0 =C2=A0is fragile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and should be fixed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; [1] <a href=3D"https=
://git.musl-libc.org/cgit/musl/tree/src/misc/" rel=3D"noreferrer" target=3D=
"_blank">https://git.musl-libc.org/cgit/musl/tree/src/misc/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0dirname.c &lt;<a href=3D"https://git.musl-libc.org/=
cgit/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git=
.musl-libc.org/cgit/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=
=3D"_blank">https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.musl-libc.org/cgit/musl/=
tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https://git.m=
usl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"https=
://git.musl-libc.org/cgit/musl/tree/src/misc/" rel=3D"noreferrer" target=3D=
"_blank">https://git.musl-libc.org/cgit/musl/tree/src/misc/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0dirname.c &lt;<a href=3D"https://git.musl-libc.org/=
cgit/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git=
.musl-libc.org/cgit/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=
=3D"_blank">https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.musl-libc.org/cgit/musl/=
tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https://git.m=
usl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Feb 27, 2026=
 at 4:09=E2=80=AFAM Florian Schmaus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailt=
o:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;&gt;&gt; wr=
ote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I=
t is required to use the return value of dirname()<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0a=
ssuming that dirname() modifies the input string.<br>
&gt;=C2=A0 =C2=A0 =C2=A0While certain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
mplementations of dirname(), for example glibc, *may*<br>
&gt;=C2=A0 =C2=A0 =C2=A0modify the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
nput string, this is not guaranteed behavior. Musl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0h=
and, does not modify the input string but instead<br>
&gt;=C2=A0 =C2=A0 =C2=A0returns a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0t=
o a statically allocated string.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0P=
reviously, ptest-runner would fail on musl systems:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$=
 ptest-runner busybox<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0S=
TART: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02=
026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0B=
EGIN: /usr/lib/busybox/ptest/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0E=
RROR: Unable to chdir(/usr/lib/busybox/ptest/run-<br>
&gt;=C2=A0 =C2=A0 =C2=A0ptest), Not a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0d=
irectory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0E=
RROR: Exited from signal Killed (9)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0D=
URATION: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0E=
ND: /usr/lib/busybox/ptest/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02=
026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0S=
TOP: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0T=
OTAL: 1 FAIL: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0S=
igned-off-by: Florian Schmaus<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:florian.schmaus@codasip.com" =
target=3D"_blank">florian.schmaus@codasip.com</a> &lt;mailto:<a href=3D"mai=
lto:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.=
com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&=
lt;mailto:<a href=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">=
florian.schmaus@codasip.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;&gt;&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=
--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0utils.c | 12 +++++++++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A01 file changed, 9 insertions(+), 3 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0d=
iff --git a/utils.c b/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
ndex 6cf7705586bc..7614dce99bd8 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=
-- a/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=
++ b/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0@=
@ -361,13 +361,19 @@ run_ptests(struct ptest_list<br>
&gt;=C2=A0 =C2=A0 =C2=A0*head, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
truct ptest_options opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;S=
TART: %s\n&quot;, progname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERATE_=
START(head, p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char ptest_dir[PATH_MAX] =3D {&#39;\0&#39;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char *ptest_dir;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char run_ptest[PATH_MAX] =3D {&#39;\0&#39;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pty[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0strcpy(ptest_dir, p-&gt;run_ptest);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dirname(ptest_dir);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; strcpy(ptest_dir, p-=
&gt;run_ptest); // This assumes ptest_dir and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0run_ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; are both PATH_MAX; p=
erhaps improve with a secure version<br>
&gt;=C2=A0 =C2=A0 =C2=A0of strcpy?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Not sure if I understand t=
he comment. My patch is using<br>
&gt;=C2=A0 =C2=A0 =C2=A0strlcpy() and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0should be safe.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ptest_dir =3D dirnam=
e(ptest_dir);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I mean making this change should be enough<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0That doesn&#39;t work as it would assign to an arra=
y type.<br>
&gt; <br>
&gt; <br>
&gt; A possible implementation could be:<br>
&gt; <br>
&gt; ```<br>
&gt; --- a/utils.c<br>
&gt; +++ b/utils.c<br>
&gt; @@ -361,13 +361,14 @@ run_ptests(struct ptest_list *head, const struct=
 <br>
&gt; ptest_options opts,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(=
fp, &quot;START: %s\n&quot;, progname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LI=
ST_ITERATE_START(head, p)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char ptest_dir[PATH_MAX] =3D {&#39;\0&#39;};<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char ptest_dir_tmp[PATH_MAX] =3D {&#39;\0&#39;};<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char *ptest_dir =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int pty[2] =3D {-1, -1};<br>
&gt; <br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strcpy(ptest_dir, p-&gt;run_ptest);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dirname(ptest_dir);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strcpy(ptest_dir_tmp, p-&gt;run_ptest);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ptest_dir =3D dirname(ptest_dir_tmp);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;ERROR: p=
ipe2() failed <br>
&gt; with: %s.\n&quot;, strerror(errno));<br>
<br>
Thank you for taking the time to look into this. I noticed your patch <br>
uses strcpy() instead of strlcpy(). While I generally prefer <br>
size-limited string copies for security reasons, as the maintainer, it&#39;=
s <br>
ultimately your call.<br>
<br></blockquote><div><br></div><div><br></div><div>I&#39;m open to changin=
g strlcpy(), if the potential patch up + strlcpy() change works for you.</d=
iv><div>I would be glad to integrate. Let me know.</div><div><br></div><div=
>Cheers!,</div><div>Anibal</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
- Florian<br>
<br>
<br>
</blockquote></div></div>

--000000000000dd52b9064bfb9d45--

