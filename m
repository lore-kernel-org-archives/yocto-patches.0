Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2952E103FF85
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 21:02:45 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.106473.1772226154953275339
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 13:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=ZsRiN9ac;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.51, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64caaacb9bcso2519522d50.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 13:02:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772226154; cv=none;
        d=google.com; s=arc-20240605;
        b=eHoN1iTAMd52NNbqMWcOhwOu/KEd0VHIfB492K0ip4cPAi+fYh8PZm5i98GGLQlqKQ
         nIKdIqCFbfFbcYFIEa/Z+vhOhGp3+Xzbb4AlRLsuUFwxyQHH+O2DvMhsriBzcpoAjZlv
         hs42hGn8PhRegav33n9I1lB+xf1h4H7lqNolAlZTMPCH3Cuz3m7jt+LzGuPPJFK49r1v
         A+a9qg3zQLB7seBtB+/ruV5ORvL85C8bk55kRv94ayD2y+RYrfW+Hh5DIiKmDbHIW/xU
         BD6nLZ8I5WYHfdvrsagYXowBHO3NiFEIeMX3SSTXkHHeNp+KYS7JWOofhNBRpGPvAWbz
         Z6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PiGt0NCIWGAqvz3nZO6doHzCd1UeRjCiQrRWKdhJjhU=;
        fh=yLBxv/52CWn0pBdf5TTAUaoOmFFwMs4CvCxKvfS4TI0=;
        b=eMXyZdeHCEXdhsbZHS0EbDLjZ/PPstoDfZgmAlvFvzSBRVHEUZas+1PD+8ABh91pvk
         KLU3dnNph3Q2utGCeL7/MCinr5UFvE6av8nPVXBZARqQ0wKJpTmrNaQyUzEsUxTWRCrx
         S64O9JC+f+lVDGYLw7qFrm/MW5aZ5vlzEgk1N3ogkjkrBjTnn6IKLgIexOInWmAVshrp
         +VrNH8cIy7Stf5pjbMERiGq1dwPLYgU+3QSuIgUhRALdTpM6vyW8KETAVbpOqW+2/d2o
         /p/ZqfS7IJxqP7wCXQgGllg87aZl/RXUoZgTvy0IyimV3qQ3iKae9b+a5Q9nNru9PzLO
         W1Jw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772226154; x=1772830954; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PiGt0NCIWGAqvz3nZO6doHzCd1UeRjCiQrRWKdhJjhU=;
        b=ZsRiN9acShFpYUjn/VhrHkoGH4VdGEH5aGFVsppjxlRzelgse72SPPIKUaBL6BKiBV
         yrIvXJBzzCkakY4vuKjmv2+GROiBKfEYuvPVTYQSBHsFXIO3oDbhTUxGs9B10vQ/fEkJ
         D18y98bn3Sn7cun0+XWwmZ1416kh+C935NakKjnuG2L325oYUBLX6zj8I07Q73q+674r
         VvtmY084olGeGJf81XEGilRb+42Wy17UbMKeZqiqwBuUZl1D8hK8GI+lL7CVBwZT8xSW
         26LinUKUE8lQSzR7NYKJij7ElUpTKVpjU1UXeriVBS+PWb23GiZ0sSgPddC5z1t2MPQ1
         Lugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226154; x=1772830954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiGt0NCIWGAqvz3nZO6doHzCd1UeRjCiQrRWKdhJjhU=;
        b=AWYR4kSHwcApnUyjJWDzj3f5gtdf4hkrJw+GmQ6BwBIlWhk1k7joyg7HljB2oEM/yJ
         Z88mhfFhb/GVcdLrximlieBSplmCHLOWLFpddY/6c6u1R3IkDvTjD01VS9EE1ECjpsb6
         ZC0p397orNH6SROqfCrHoEWmPR+ImtQYsIwrqjCZqTO1uwP9Dz1HVFuqZPa9JwG10H/S
         K4kjiiMdVqaR0DP255moCqaqOks7aZM958McTdBxRUgPYYhXBGND/dMvYnjNl+jxYvA1
         t+xduUlO9sQimuSnUMxYuugnlOwCN5znFEZMMCGm62+McZkDuBqJONtmzWlrORYGKTYQ
         7olw==
X-Gm-Message-State: AOJu0YwtZuJM1tz31cSY8PTXYJqrfatgL89/I0jxQG9cSppz+Bi5snvb
	lZ1VQw07PeMyn8jC4qSRaeXObFWNUQeICOFliEIV/2KdN/Ums4FJ8P6Hwbay6C8HekBIrxpRrUl
	G6DJ5EUIgup2CEl4x39ypFB8aJVVThCdSQZ4MEXsceQ==
X-Gm-Gg: ATEYQzy9Raks5HYmhgub0z3t+Z/BTBwU+VJiEf2uksnwy59we6BjtW0z9Kgz9zd/1bi
	lRrrbugslQepPprWKadv7dzO4msr7M9W7TgdlVbQHsc2paWFss6HeZIQqUR9Zr00jTgLNqbWLxA
	FSQ1ttWEWQLGo84aBvMy8zmOgLCjbB2bGqvzdQEF8Ug7cl0x1+1XXutqUoz8izM7RXXkTyFXJEo
	KzV2avKF1lAnBVAf1LYUM0RAHwzG5Qf5KFGM6Wo58A3dPbbFTeOH82VJwY5li4Hi/kOi1FvkeeA
	VCebbc0DZS4Li36T91NajIZFgvsCEIRS2WMcNMmodIn+zHflq/YjHbZ0PKEPN0m2aZk11Q==
X-Received: by 2002:a05:690e:d4b:b0:649:eaa9:f252 with SMTP id
 956f58d0204a3-64cc222ae25mr3844926d50.53.1772226153946; Fri, 27 Feb 2026
 13:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
 <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com> <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
 <1eb39bda-cb9f-4435-b784-540f203c8ef7@codasip.com>
In-Reply-To: <1eb39bda-cb9f-4435-b784-540f203c8ef7@codasip.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Fri, 27 Feb 2026 15:02:22 -0600
X-Gm-Features: AaiRm53e_ptSIn5wlLYl5T3SMsW-nT6gGsewOtHRvpJxh8SWkDgf_71kWpJ8kYk
Message-ID: <CAOU5ZMs+SgsAXWp7rO-C=TYKf90ER9N5fLzVfEx2P6ZXm=dxFA@mail.gmail.com>
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005e403b064bd48eab"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 21:02:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3307

--0000000000005e403b064bd48eab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:37=E2=80=AFPM Florian Schmaus <florian.schmaus@co=
dasip.com>
wrote:

> On 27/02/2026 21.20, Anibal Limon wrote:
> >
> >
> > On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus
> > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>>
> wrote:
> >
> >     On 27/02/2026 16.58, Anibal Limon wrote:
> >      > Hi Florian,
> >
> >     Hi Anibal,
> >
> >
> >      > Thanks for the patch, comments below,
> >
> >     Thanks for looking at my patch.
> >
> >
> >      > Can you refer me to the musl dirname(3) function that uses stati=
c
> >      > allocation?.
> >      > I reviewed [1] and found that modifying the same string anyway
> >     doing the
> >      > assignment is needed.
> >
> >     Oh, right. It's the CHERI-enable musl libc that is using a static
> >     allocation [1]. I wasn't aware that this is a deviation from
> upstream.
> >
> >     But it doesn't really matter, the current usage of dirname() is
> fragile
> >     and should be fixed.
> >
> >
> >      > [1] https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
> >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
> >      > <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
> >     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>
> >      >
> >      > On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus
> >      > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com=
>
> >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>> wrote:
> >      >
> >      >     It is required to use the return value of dirname() instead =
of
> >      >     assuming that dirname() modifies the input string. While
> certain
> >      >     implementations of dirname(), for example glibc, *may* modif=
y
> the
> >      >     input string, this is not guaranteed behavior. Musl, on the
> other
> >      >     hand, does not modify the input string but instead returns a
> >     pointer
> >      >     to a statically allocated string.
> >      >
> >      >     Previously, ptest-runner would fail on musl systems:
> >      >
> >      >     $ ptest-runner busybox
> >      >     START: ptest-runner
> >      >     2026-02-27T09:21
> >      >     BEGIN: /usr/lib/busybox/ptest/run-ptest
> >      >     ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), No=
t
> a
> >      >     directory
> >      >
> >      >     ERROR: Exited from signal Killed (9)
> >      >     DURATION: 0
> >      >     END: /usr/lib/busybox/ptest/run-ptest
> >      >     2026-02-27T09:21
> >      >     STOP: ptest-runner
> >      >     TOTAL: 1 FAIL: 1
> >      >
> >      >     Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>
> >      >     <mailto:florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>>
> >      >     ---
> >      >       utils.c | 12 +++++++++---
> >      >       1 file changed, 9 insertions(+), 3 deletions(-)
> >      >
> >      >     diff --git a/utils.c b/utils.c
> >      >     index 6cf7705586bc..7614dce99bd8 100644
> >      >     --- a/utils.c
> >      >     +++ b/utils.c
> >      >     @@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head,
> const
> >      >     struct ptest_options opts,
> >      >
> >      >                      fprintf(fp, "START: %s\n", progname);
> >      >                      PTEST_LIST_ITERATE_START(head, p)
> >      >     -                       char ptest_dir[PATH_MAX] =3D {'\0'};
> >      >     +                       char *ptest_dir;
> >      >     +                       char run_ptest[PATH_MAX] =3D {'\0'};
> >      >                              int pipefd_stdout[2] =3D {-1, -1};
> >      >                              int pipefd_stderr[2] =3D {-1, -1};
> >      >                              int pty[2] =3D {-1, -1};
> >      >
> >      >     -                       strcpy(ptest_dir, p->run_ptest);
> >      >     -                       dirname(ptest_dir);
> >      >
> >      >
> >      > strcpy(ptest_dir, p->run_ptest); // This assumes ptest_dir and
> >     run_ptest
> >      > are both PATH_MAX; perhaps improve with a secure version of
> strcpy?
> >
> >     Not sure if I understand the comment. My patch is using strlcpy() a=
nd
> >     should be safe.
> >
> >
> >
> >      > ptest_dir =3D dirname(ptest_dir);
> >
> >
> > I mean making this change should be enough
> That doesn't work as it would assign to an array type.
>

A possible implementation could be:

```
--- a/utils.c
+++ b/utils.c
@@ -361,13 +361,14 @@ run_ptests(struct ptest_list *head, const struct
ptest_options opts,

                fprintf(fp, "START: %s\n", progname);
                PTEST_LIST_ITERATE_START(head, p)
-                       char ptest_dir[PATH_MAX] =3D {'\0'};
+                       char ptest_dir_tmp[PATH_MAX] =3D {'\0'};
+                       char *ptest_dir =3D NULL;
                        int pipefd_stdout[2] =3D {-1, -1};
                        int pipefd_stderr[2] =3D {-1, -1};
                        int pty[2] =3D {-1, -1};

-                       strcpy(ptest_dir, p->run_ptest);
-                       dirname(ptest_dir);
+                       strcpy(ptest_dir_tmp, p->run_ptest);
+                       ptest_dir =3D dirname(ptest_dir_tmp);

                        if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
                                fprintf(fp, "ERROR: pipe2() failed with:
%s.\n", strerror(errno));
```

Anibal


>
> - Florian
>

--0000000000005e403b064bd48eab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 2:37=E2=80=AFPM Florian Schmaus &lt;<a href=3D"mailto:florian.schm=
aus@codasip.com">florian.schmaus@codasip.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On 27/02/2026 21.20, Anibal Lim=
on wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus <br>
&gt; &lt;<a href=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">f=
lorian.schmaus@codasip.com</a> &lt;mailto:<a href=3D"mailto:florian.schmaus=
@codasip.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 27/02/2026 16.58, Anibal Limon wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Florian,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Anibal,<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thanks for the patch, comments below,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for looking at my patch.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Can you refer me to the musl dirname(3) funct=
ion that uses static<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; allocation?.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I reviewed [1] and found that modifying the s=
ame string anyway<br>
&gt;=C2=A0 =C2=A0 =C2=A0doing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; assignment=C2=A0is needed.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Oh, right. It&#39;s the CHERI-enable musl libc that=
 is using a static<br>
&gt;=C2=A0 =C2=A0 =C2=A0allocation [1]. I wasn&#39;t aware that this is a d=
eviation from upstream.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But it doesn&#39;t really matter, the current usage=
 of dirname() is fragile<br>
&gt;=C2=A0 =C2=A0 =C2=A0and should be fixed.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [1] <a href=3D"https://git.musl-libc.org/cgit=
/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https:/=
/git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.musl-libc.org/cgit/musl/=
tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https://git.m=
usl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"https://git.musl-libc.org/cgit=
/musl/tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https:/=
/git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.musl-libc.org/cgit/musl/=
tree/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https://git.m=
usl-libc.org/cgit/musl/tree/src/misc/dirname.c</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Flori=
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0It is required to use the =
return value of dirname() instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0assuming that dirname() mo=
difies the input string. While certain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0implementations of dirname=
(), for example glibc, *may* modify the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0input string, this is not =
guaranteed behavior. Musl, on the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0hand, does not modify the =
input string but instead returns a<br>
&gt;=C2=A0 =C2=A0 =C2=A0pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to a statically allocated =
string.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Previously, ptest-runner w=
ould fail on musl systems:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ ptest-runner busybox<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0START: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0BEGIN: /usr/lib/busybox/pt=
est/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ERROR: Unable to chdir(/us=
r/lib/busybox/ptest/run-ptest), Not a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0directory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ERROR: Exited from signal =
Killed (9)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0DURATION: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0END: /usr/lib/busybox/ptes=
t/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0STOP: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TOTAL: 1 FAIL: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Florian Sch=
maus &lt;<a href=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">f=
lorian.schmaus@codasip.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0utils.c | 12 ++++++=
+++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 9 i=
nsertions(+), 3 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0diff --git a/utils.c b/uti=
ls.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0index 6cf7705586bc..7614dc=
e99bd8 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0--- a/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+++ b/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0@@ -361,13 +361,19 @@ run_=
ptests(struct ptest_list *head, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0struct ptest_options opts,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;START: %s\n&quot;, progna=
me);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERATE_START(head, p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ptest_dir[P=
ATH_MAX] =3D {&#39;\0&#39;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *ptest_dir;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char run_ptest[P=
ATH_MAX] =3D {&#39;\0&#39;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stdo=
ut[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stde=
rr[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pty[2] =3D =
{-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(ptest_dir=
, p-&gt;run_ptest);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirname(ptest_di=
r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; strcpy(ptest_dir, p-&gt;run_ptest); // This a=
ssumes ptest_dir and<br>
&gt;=C2=A0 =C2=A0 =C2=A0run_ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; are both PATH_MAX; perhaps improve with a sec=
ure version of strcpy?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Not sure if I understand the comment. My patch is u=
sing strlcpy() and<br>
&gt;=C2=A0 =C2=A0 =C2=A0should be safe. <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ptest_dir =3D dirname(ptest_dir);<br>
&gt; <br>
&gt; <br>
&gt; I mean making this change should be enough<br>
That doesn&#39;t work as it would assign to an array type.<br></blockquote>=
<div><br></div><div>A possible implementation could be:</div><div><br></div=
><div>```</div><div>--- a/utils.c<br>+++ b/utils.c<br>@@ -361,13 +361,14 @@=
 run_ptests(struct ptest_list *head, const struct ptest_options opts,<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f=
p, &quot;START: %s\n&quot;, progname);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERATE_START(head, p)<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char pte=
st_dir[PATH_MAX] =3D {&#39;\0&#39;};<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char ptest_dir_tmp[PATH_MAX] =
=3D {&#39;\0&#39;};<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *ptest_dir =3D NULL;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipe=
fd_stdout[2] =3D {-1, -1};<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pty[2] =3D {-1, -1};<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(ptest_dir, p-&g=
t;run_ptest);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dirname(ptest_dir);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(ptest_dir_tmp, p-&g=
t;run_ptest);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ptest_dir =3D dirname(ptest_dir_tmp);<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 fprintf(fp, &quot;ERROR: pipe2() failed with: %s.\n&quot;, st=
rerror(errno));<br></div><div>```</div><div><br></div><div>Anibal</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
- Florian<br>
</blockquote></div></div>

--0000000000005e403b064bd48eab--

