Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58651039894
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 20:20:44 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.105463.1772223637379740766
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 12:20:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=ngz+8b+J;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.44, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9a398bc7so2442228d50.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 12:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772223636; cv=none;
        d=google.com; s=arc-20240605;
        b=FALAdGB6jUoG2C/6U25vF70GhLSLH0QgLUmKWMICdRo30DEyEMQyFXce5xumhsNQ8f
         xFhT6fDy2fzs2Lhyd78rA7C/Sx6GBoZuOhvB4es+s+k2H+4BWoYNI6VjW1CHmgTG4DlU
         jC/LR8TTfWnryyGtA+ZMqYNFipSU567GkOfi90qgsaLV6h9eEhnsJlPS+kGqwyzBVUs7
         gnuI4vTXvrBNZli0Iw2RdkeJCchfclooQBg4WNuT5YfukHhwQ/qnAmrWq6FnT7fjuT+8
         v8FYesbSd+8hQiYPDeavy3jZJJu/lI27GkFY1t7IMY2OvoXaN3SzYz4f5kwiCeF2SeNJ
         wVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2RjRBcQ00tMBAjnu1TiZQJxNzzXkvrNKh/8hXuZrg30=;
        fh=yLBxv/52CWn0pBdf5TTAUaoOmFFwMs4CvCxKvfS4TI0=;
        b=R29mvvSG5utIgug6osVww4jWdDXAuqlEt7zrWQik10ln2DplUZBvAn9ZIJhzrGQYb/
         ZDYDjxjy8N675EUqvXza6l/bad/m1YbKwKdL2zKPTin68rWqpmnNYMuRRDDHTv4NZ9ud
         ZF8tYZqnTpORKUoQ6CS0+RC3Mxb9DE8R27Eex9X6xvMUkSoV3TTFatdf6eN2AAjdUWse
         xuijF5W4wtEMhJucG/SzIfOoxLm9HdBPtE6KJ2CNo5Cl/jxSBcgViRIZqVDSHjHPfC9c
         kQlHhEklMq5wdyeHU6hbBomXlMmm4vbi5XmwQCNMpK7eIuG2f4h7LC+NNgjITlt1rclj
         7Y1Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772223636; x=1772828436; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RjRBcQ00tMBAjnu1TiZQJxNzzXkvrNKh/8hXuZrg30=;
        b=ngz+8b+JFjicdSS4QnVxYajYK0d9qzIxNj6WINuD9Ke/fNXWvfMy1T71DAIsbeSiag
         CFx9Ax8UmGd8L3M+s8fct65eaZVwDBAWnNQLe2Dj1Cijvhv9HfbAnLGZY3xZAZ3D+nqc
         m52TyCsBdirEX2S2cKNuNKUwaWZfU9hVmG47ANqQZXjAPqEHX0iG2cs1t+/z/+yZ15DU
         xSgmsqLPnwRblGqoefJcrDUrYztxQU/3/CkfhOxgW5ELXPFcvgi7dHHNEDmrE8CGGhXC
         Q4imm100K0E6He40wTVkA4y2m1jkPnzeffeyuFXbviXzRwnc+av3u9mtwE6rIMrmfPbp
         yytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223636; x=1772828436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RjRBcQ00tMBAjnu1TiZQJxNzzXkvrNKh/8hXuZrg30=;
        b=wHS7E9dBp1Q/VNFfzq4+TM8sE0NR5S1NUuLQ4ASastDvRl5WOJiaYQFh9PXxVjeb2J
         lZBXwsplPrdj5fMW+EwpaaEGEbL/FHdFmzH77U+5rCRVXbRftJxJ9Djjspyz7HKBx7MC
         l/8U0LB4Mgt7TcNFIPP1CtDa/GDKlAkzmbBlJ7NXOhIb2WH/shGfTS12s7Hu61GM+7sq
         5DTI7HytJu7qYiOjRk4R8ksyyB0EshZ0bGPEZBZCCp0kTWGFNJ2EChJ2C6FOOy9yK6K5
         jAGfbsIaxrDmDKipVQUwsBhrtrv3YhW25km8f2PA0kmjAUg0hhtqa3KnuJ3aGJQlRgk5
         yWsA==
X-Gm-Message-State: AOJu0YwfybS6FpYR/rS/GoJJkhmFUnjMnDhX2IA0Af909uDojgKGjjPu
	9MVN+JiJwu5lsXhOmjWqD6cJjfAsx04eE6bFOHTxFaSNBCXKu/oBcVF8hQSXqc1v7H6mhpgf/9h
	fLG/rxlnU4y4KRlh79/seJPNK348bsq1F9WVresHs3A==
X-Gm-Gg: ATEYQzz8mIZjmSArJpv2Nyi0M0cWKYTqfzcVFObrKYKSbj1VCfzfGgoegNX+linEcdX
	qZ1PHj3f2RHHoDlTz5JyQg5//vx2HHJVR34ji8U3AAnaOeBpX5vMA9WhuuHFjwRCXHt6Ll3UCGd
	TSed+8aBoogwW0gFH9aO5Qe9PkyxrVAcQPM4KQzLb0Sb+6K4xlI+kMChnqxKNL+XW4BHULJYrHu
	t1XC5XkMo0W0dhDvAmt+/VYKNVNAo0pAi59GqRQInOu1dI3ZyWB5tearyuX9ueB4hUuxA0ZY9xv
	3GywMRiBxUWWtp8Qd3pREXTTigWfX5Lt51WGFRy3sDelpYmkVmiGMkDXRwuFkuI8q6Ppsg==
X-Received: by 2002:a53:ac4b:0:b0:644:444f:3bd1 with SMTP id
 956f58d0204a3-64cc22cd96emr2745625d50.68.1772223636306; Fri, 27 Feb 2026
 12:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com> <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com>
In-Reply-To: <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Fri, 27 Feb 2026 14:20:25 -0600
X-Gm-Features: AaiRm50JRf0bQTJa-BzP1iSFvce7pFQbuJvqOzV-bFfeJlcIvG_ar6F5FcCAZEA
Message-ID: <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004e189b064bd3f82f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 20:20:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3305

--0000000000004e189b064bd3f82f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus <florian.schmaus@co=
dasip.com>
wrote:

> On 27/02/2026 16.58, Anibal Limon wrote:
> > Hi Florian,
>
> Hi Anibal,
>
>
> > Thanks for the patch, comments below,
>
> Thanks for looking at my patch.
>
>
> > Can you refer me to the musl dirname(3) function that uses static
> > allocation?.
> > I reviewed [1] and found that modifying the same string anyway doing th=
e
> > assignment is needed.
>
> Oh, right. It's the CHERI-enable musl libc that is using a static
> allocation [1]. I wasn't aware that this is a deviation from upstream.
>
> But it doesn't really matter, the current usage of dirname() is fragile
> and should be fixed.
>
>
> > [1] https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
> > <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
> >
> > On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus
> > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>>
> wrote:
> >
> >     It is required to use the return value of dirname() instead of
> >     assuming that dirname() modifies the input string. While certain
> >     implementations of dirname(), for example glibc, *may* modify the
> >     input string, this is not guaranteed behavior. Musl, on the other
> >     hand, does not modify the input string but instead returns a pointe=
r
> >     to a statically allocated string.
> >
> >     Previously, ptest-runner would fail on musl systems:
> >
> >     $ ptest-runner busybox
> >     START: ptest-runner
> >     2026-02-27T09:21
> >     BEGIN: /usr/lib/busybox/ptest/run-ptest
> >     ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), Not a
> >     directory
> >
> >     ERROR: Exited from signal Killed (9)
> >     DURATION: 0
> >     END: /usr/lib/busybox/ptest/run-ptest
> >     2026-02-27T09:21
> >     STOP: ptest-runner
> >     TOTAL: 1 FAIL: 1
> >
> >     Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com
> >     <mailto:florian.schmaus@codasip.com>>
> >     ---
> >       utils.c | 12 +++++++++---
> >       1 file changed, 9 insertions(+), 3 deletions(-)
> >
> >     diff --git a/utils.c b/utils.c
> >     index 6cf7705586bc..7614dce99bd8 100644
> >     --- a/utils.c
> >     +++ b/utils.c
> >     @@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head, const
> >     struct ptest_options opts,
> >
> >                      fprintf(fp, "START: %s\n", progname);
> >                      PTEST_LIST_ITERATE_START(head, p)
> >     -                       char ptest_dir[PATH_MAX] =3D {'\0'};
> >     +                       char *ptest_dir;
> >     +                       char run_ptest[PATH_MAX] =3D {'\0'};
> >                              int pipefd_stdout[2] =3D {-1, -1};
> >                              int pipefd_stderr[2] =3D {-1, -1};
> >                              int pty[2] =3D {-1, -1};
> >
> >     -                       strcpy(ptest_dir, p->run_ptest);
> >     -                       dirname(ptest_dir);
> >
> >
> > strcpy(ptest_dir, p->run_ptest); // This assumes ptest_dir and run_ptes=
t
> > are both PATH_MAX; perhaps improve with a secure version of strcpy?
>
> Not sure if I understand the comment. My patch is using strlcpy() and
> should be safe.


>
> > ptest_dir =3D dirname(ptest_dir);
>

I mean making this change should be enough, plus the `strcpy` change to
`strlcpy` removes the assumption about
using PATH_MAX.

Cheers!.
Anibal


> >
> >     +                       /* Copy, since dirname() may modify its
> >     input buffer */
> >     +                       if (strlcpy(run_ptest, p->run_ptest,
> >     sizeof(run_ptest)) >=3D sizeof(run_ptest)) {
> >     +                               fprintf(fp, "ERROR: %s exceeds
> >     PATH_MAX\n", p->run_ptest);
> >     +                               rc =3D -1;
> >     +                               goto ptest_list_fail1;
> >     +                       }
> >     +                       ptest_dir =3D dirname(run_ptest);
> >
> >                              if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
> >                                      fprintf(fp, "ERROR: pipe2() failed
> >     with: %s.\n", strerror(errno));
> >     --
> >     2.52.0
> >
>
> - Florian
>
> 1:
>
> https://git.morello-project.org/morello/musl-libc/-/blob/morello/master/s=
rc/misc/dirname.c
>
>

--0000000000004e189b064bd3f82f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:52=E2=80=AFPM Florian Schmaus &lt;<a href=3D"mailto:florian.schm=
aus@codasip.com">florian.schmaus@codasip.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On 27/02/2026 16.58, Anibal Lim=
on wrote:<br>
&gt; Hi Florian,<br>
<br>
Hi Anibal,<br>
<br>
<br>
&gt; Thanks for the patch, comments below,<br>
<br>
Thanks for looking at my patch.<br>
<br>
<br>
&gt; Can you refer me to the musl dirname(3) function that uses static <br>
&gt; allocation?.<br>
&gt; I reviewed [1] and found that modifying the same string anyway doing t=
he <br>
&gt; assignment=C2=A0is needed.<br>
<br>
Oh, right. It&#39;s the CHERI-enable musl libc that is using a static <br>
allocation [1]. I wasn&#39;t aware that this is a deviation from upstream.<=
br>
<br>
But it doesn&#39;t really matter, the current usage of dirname() is fragile=
 <br>
and should be fixed.<br>
<br>
<br>
&gt; [1] <a href=3D"https://git.musl-libc.org/cgit/musl/tree/src/misc/dirna=
me.c" rel=3D"noreferrer" target=3D"_blank">https://git.musl-libc.org/cgit/m=
usl/tree/src/misc/dirname.c</a> <br>
&gt; &lt;<a href=3D"https://git.musl-libc.org/cgit/musl/tree/src/misc/dirna=
me.c" rel=3D"noreferrer" target=3D"_blank">https://git.musl-libc.org/cgit/m=
usl/tree/src/misc/dirname.c</a>&gt;<br>
&gt; <br>
&gt; On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus <br>
&gt; &lt;<a href=3D"mailto:florian.schmaus@codasip.com" target=3D"_blank">f=
lorian.schmaus@codasip.com</a> &lt;mailto:<a href=3D"mailto:florian.schmaus=
@codasip.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It is required to use the return value of dirname()=
 instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0assuming that dirname() modifies the input string. =
While certain<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementations of dirname(), for example glibc, *m=
ay* modify the<br>
&gt;=C2=A0 =C2=A0 =C2=A0input string, this is not guaranteed behavior. Musl=
, on the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0hand, does not modify the input string but instead =
returns a pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0to a statically allocated string.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Previously, ptest-runner would fail on musl systems=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ ptest-runner busybox<br>
&gt;=C2=A0 =C2=A0 =C2=A0START: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A02026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0BEGIN: /usr/lib/busybox/ptest/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A0ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-p=
test), Not a<br>
&gt;=C2=A0 =C2=A0 =C2=A0directory<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0ERROR: Exited from signal Killed (9)<br>
&gt;=C2=A0 =C2=A0 =C2=A0DURATION: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0END: /usr/lib/busybox/ptest/run-ptest<br>
&gt;=C2=A0 =C2=A0 =C2=A02026-02-27T09:21<br>
&gt;=C2=A0 =C2=A0 =C2=A0STOP: ptest-runner<br>
&gt;=C2=A0 =C2=A0 =C2=A0TOTAL: 1 FAIL: 1<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Florian Schmaus &lt;<a href=3D"mailt=
o:florian.schmaus@codasip.com" target=3D"_blank">florian.schmaus@codasip.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0utils.c | 12 +++++++++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 9 insertions(+), 3 deletions=
(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/utils.c b/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 6cf7705586bc..7614dce99bd8 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/utils.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -361,13 +361,19 @@ run_ptests(struct ptest_list =
*head, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct ptest_options opts,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(fp, &quot;START: %s\n&quot;, progname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PTEST_LIST_ITERATE_START(head, p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ptest_dir[PATH_MAX] =3D {&#39;\0&#39=
;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *ptest_dir;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char run_ptest[PATH_MAX] =3D {&#39;\0&#39=
;};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pty[2] =3D {-1, -1};<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(ptest_dir, p-&gt;run_ptest);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirname(ptest_dir);<br>
&gt; <br>
&gt; <br>
&gt; strcpy(ptest_dir, p-&gt;run_ptest); // This assumes ptest_dir and run_=
ptest <br>
&gt; are both PATH_MAX; perhaps improve with a secure version of strcpy?<br=
>
<br>
Not sure if I understand the comment. My patch is using strlcpy() and <br>
should be safe.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
&gt; ptest_dir =3D dirname(ptest_dir);<br></blockquote><div><br></div><div>=
I mean making this change should be enough, plus the `strcpy` change to `st=
rlcpy` removes the assumption about</div><div>using PATH_MAX.</div><div><br=
></div><div>Cheers!.</div><div>Anibal</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Copy, since dirname() may modify its<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0input buffer */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlcpy(run_ptest, p-&gt;run_ptest,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0sizeof(run_ptest)) &gt;=3D sizeof(run_ptest)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &=
quot;ERROR: %s exceeds<br>
&gt;=C2=A0 =C2=A0 =C2=A0PATH_MAX\n&quot;, p-&gt;run_ptest);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto ptest_li=
st_fail1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptest_dir =3D dirname(run_ptest);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, =
&quot;ERROR: pipe2() failed<br>
&gt;=C2=A0 =C2=A0 =C2=A0with: %s.\n&quot;, strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.52.0<br>
&gt; <br>
<br>
- Florian<br>
<br>
1: <br>
<a href=3D"https://git.morello-project.org/morello/musl-libc/-/blob/morello=
/master/src/misc/dirname.c" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.morello-project.org/morello/musl-libc/-/blob/morello/master/src/misc/dirn=
ame.c</a><br>
<br>
</blockquote></div></div>

--0000000000004e189b064bd3f82f--

