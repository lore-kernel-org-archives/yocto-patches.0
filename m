Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6EFEFB6D
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 15:59:03 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.99305.1772207936172854190
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 07:58:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=juYj3sfj;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.180, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79863ab8478so22733587b3.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 07:58:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207935; cv=none;
        d=google.com; s=arc-20240605;
        b=FbpJLEYGd/mNktIsIPbFUQcYtD4l4dI8EdNYaBaZ1A8EKbQ/0fJvqXblHqPBkIYc51
         tYY6MwTFh3JMvA0RaM1vYiQzQ7b0O+MV04WOEZyK3CAqTGugPBOV18PKnyRumcey+dDU
         oO+l3Inl+MoupthXoZvU9D8TwuUPxCZK5p1GX8ayEqzlVmDdSGvmtYwiiDsKEq+e04QJ
         TTi/UyDmZuKkIKNaY1Hmsda1Vx7nEqlwOVn9wwFfQbrMSvkZgkuaddQeFP89vVDt/y68
         T7HVK7TeVVNb9F2FPMyHjHmbzpVyMTzlUnx75Q1cQrFaIkhygW9N8M0pmcYX415neksO
         BUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xbidP0+PlLRfdrHtBKBMNV4X4Y55nZVITrnNutXQbKo=;
        fh=yLBxv/52CWn0pBdf5TTAUaoOmFFwMs4CvCxKvfS4TI0=;
        b=S3sPwan8O6beNkzTs2HRAN2iJDyQLuW/w2ATux0MqLtyYxuPj2g62Rwzfz0055d45x
         8fzuix6qg9UYiZcWynkWmjEmJZkwE8mU0EnlDG1fvyl3Qix2kgbhPQcoZPSH4LXXy1MQ
         bNys6o235zOErCU0gtafIyt0UBsfePpgxpXqXitBF7uoezjEe4qmg3xtlrQJow/fKckv
         M60Bv22JBf/lPWcqeufwDXKFfRVSHk1BMCG13P5FPsQvisU1M7CNa7qvMCFF/cHKGfVx
         corV9q3gi4kkCyuneihBb7ZWPb7bw8xaK6m4XBMx+6OByospPTYVNAeqIgeQKt0fbkfa
         hlfA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772207935; x=1772812735; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xbidP0+PlLRfdrHtBKBMNV4X4Y55nZVITrnNutXQbKo=;
        b=juYj3sfjB8WIadO8ubmBCwUGCTQVcU6D/Sq9IvBjdZMee1IvfYjonuUXG6CKgbMsQV
         GAXgetQFDtVBcKY+H0MT3YpzZSZi91omZ6Lc+lSzXhMHGp8cAd3LHWVHj+9JOmr/dXxa
         ywdI6OK0zIiYD59UNSU12IDZWQ5qRaPiT78rIYyxrckbTx8wX8w7orcp7Env6XBE+hfE
         M94gqOzDWY1iLKlrcGELgyp6WOsjB+baTfb5rPMLcZ/7lK2FAIBYifbYQwVRBoOxq/5D
         xtMkkEIdfIkdbgyg5vyB4NXfjs8plpf+P9W1A64MhKhFL9ANl1EVhEojRb6f6KaallCI
         f9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207935; x=1772812735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbidP0+PlLRfdrHtBKBMNV4X4Y55nZVITrnNutXQbKo=;
        b=p7Lmla03BEJmUIKURWNRsVngWndnap+hDAbyVBl/afFfz9X6wumNOzpu3pwPYvV0u8
         XRaEP7ToN3i8WUFQYRErWF+hBKfsmz4cJzWVcXahetiPIi19x4L5iwpxOcoRyz+vzB/t
         jXE3TA6bGz8K2P/qRTpBb+vDZAR1gFjiTfeo+wGEdaS91HFSXqlbWZlvXbGUIwDLsfgv
         iLx82yQDve9eaZkf0BTKKCqBl5QuH/DfwZXni+YDXhhJNcbZknTo24VUCkgvuu7T+2vg
         I0PSGT0EvfMDTRr0jCl8oy2AoQSP4hQQknyNsDVipQMxTy3n/aIyAddn8jVXzxPus4T7
         z73g==
X-Gm-Message-State: AOJu0YxgbVfLQTfBVftLOuSxiqT2YFAgXMw6BPQBiFmEtD4oCxRTP44m
	g+Y7R0R4C9HoxHKMeysTd2MpZwsA7Qsq34aWPISAizkGsWeeY7GdaPtPLRoxrG3tVLNagKtWl8p
	8ECXSQ45ie4RzuSpJq0FUPkOZKDWqgCy7A8DGC5G3nKZwGc6Nh/NQq78=
X-Gm-Gg: ATEYQzyb2qbmppKbwcAiE9pIGPLscL3BUFCx89uyJk47Y+yqB/eZVSabIwbuPm1jDGJ
	94dng80SB9XguOPbtNjvoeMY/bNfKl+YweDWl0ifaSYR13wgmHLOYiZAkMS4KQFc2o14srcVxW3
	erDOvoYKBLcang92MNXt/Z+MqvSLMExSDfPz+d7Av8s2rGDU3QUnpUCHoKYDHaHdH0ZomXFE07A
	JWHo9GGHKeKl3GpnaJOZ+ezVoZVBrkF02jl72FRT2QshSghtKFbvY3fdDHti5Gxq7VZaVllkwjH
	9OMIq7Sb26pBechW+ffKJ3L190g9qPEPtEhkeXmc7sQjMdqBjTl2q2gN2ad26TjOtrPXNA==
X-Received: by 2002:a05:690e:158f:10b0:64c:aa01:55bc with SMTP id
 956f58d0204a3-64cc20876dbmr2285681d50.21.1772207935004; Fri, 27 Feb 2026
 07:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
In-Reply-To: <20260227100943.284203-1-florian.schmaus@codasip.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Fri, 27 Feb 2026 09:58:43 -0600
X-Gm-Features: AaiRm52N9M5lPMkU8fO_1bC5ZcHavA6mKp4GnxXqMn-SqX-M8_CSsGnhSuhwAfo
Message-ID: <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000006f2dfc064bd05059"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 15:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3302

--0000000000006f2dfc064bd05059
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thanks for the patch, comments below,

Can you refer me to the musl dirname(3) function that uses static
allocation?.
I reviewed [1] and found that modifying the same string anyway doing the
assignment is needed.

[1] https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c

On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus <florian.schmaus@co=
dasip.com>
wrote:

> It is required to use the return value of dirname() instead of
> assuming that dirname() modifies the input string. While certain
> implementations of dirname(), for example glibc, *may* modify the
> input string, this is not guaranteed behavior. Musl, on the other
> hand, does not modify the input string but instead returns a pointer
> to a statically allocated string.
>
> Previously, ptest-runner would fail on musl systems:
>
> $ ptest-runner busybox
> START: ptest-runner
> 2026-02-27T09:21
> BEGIN: /usr/lib/busybox/ptest/run-ptest
> ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), Not a directory
>
> ERROR: Exited from signal Killed (9)
> DURATION: 0
> END: /usr/lib/busybox/ptest/run-ptest
> 2026-02-27T09:21
> STOP: ptest-runner
> TOTAL: 1 FAIL: 1
>
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
>  utils.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/utils.c b/utils.c
> index 6cf7705586bc..7614dce99bd8 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>
>                 fprintf(fp, "START: %s\n", progname);
>                 PTEST_LIST_ITERATE_START(head, p)
> -                       char ptest_dir[PATH_MAX] =3D {'\0'};
> +                       char *ptest_dir;
> +                       char run_ptest[PATH_MAX] =3D {'\0'};
>                         int pipefd_stdout[2] =3D {-1, -1};
>                         int pipefd_stderr[2] =3D {-1, -1};
>                         int pty[2] =3D {-1, -1};
>
> -                       strcpy(ptest_dir, p->run_ptest);
> -                       dirname(ptest_dir);
>

strcpy(ptest_dir, p->run_ptest); // This assumes ptest_dir and run_ptest
are both PATH_MAX; perhaps improve with a secure version of strcpy?
ptest_dir =3D dirname(ptest_dir);

> +                       /* Copy, since dirname() may modify its input
> buffer */
> +                       if (strlcpy(run_ptest, p->run_ptest,
> sizeof(run_ptest)) >=3D sizeof(run_ptest)) {
> +                               fprintf(fp, "ERROR: %s exceeds
> PATH_MAX\n", p->run_ptest);
> +                               rc =3D -1;
> +                               goto ptest_list_fail1;
> +                       }
> +                       ptest_dir =3D dirname(run_ptest);
>
>                         if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>                                 fprintf(fp, "ERROR: pipe2() failed with:
> %s.\n", strerror(errno));
> --
> 2.52.0
>
>

--0000000000006f2dfc064bd05059
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Florian,<div><br></div><div>Thanks for=
 the patch, comments below,</div><div><br></div><div>Can you refer me to th=
e musl dirname(3) function that uses static allocation?.</div><div>I review=
ed [1] and found that modifying the same string anyway doing the assignment=
=C2=A0is needed.</div><div><br></div><div>[1]=C2=A0<a href=3D"https://git.m=
usl-libc.org/cgit/musl/tree/src/misc/dirname.c">https://git.musl-libc.org/c=
git/musl/tree/src/misc/dirname.c</a></div></div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb=
 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus &lt;<a href=3D"mailto:florian.=
schmaus@codasip.com">florian.schmaus@codasip.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">It is required to use the r=
eturn value of dirname() instead of<br>
assuming that dirname() modifies the input string. While certain<br>
implementations of dirname(), for example glibc, *may* modify the<br>
input string, this is not guaranteed behavior. Musl, on the other<br>
hand, does not modify the input string but instead returns a pointer<br>
to a statically allocated string.<br>
<br>
Previously, ptest-runner would fail on musl systems:<br>
<br>
$ ptest-runner busybox<br>
START: ptest-runner<br>
2026-02-27T09:21<br>
BEGIN: /usr/lib/busybox/ptest/run-ptest<br>
ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), Not a directory<b=
r>
<br>
ERROR: Exited from signal Killed (9)<br>
DURATION: 0<br>
END: /usr/lib/busybox/ptest/run-ptest<br>
2026-02-27T09:21<br>
STOP: ptest-runner<br>
TOTAL: 1 FAIL: 1<br>
<br>
Signed-off-by: Florian Schmaus &lt;<a href=3D"mailto:florian.schmaus@codasi=
p.com" target=3D"_blank">florian.schmaus@codasip.com</a>&gt;<br>
---<br>
=C2=A0utils.c | 12 +++++++++---<br>
=C2=A01 file changed, 9 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/utils.c b/utils.c<br>
index 6cf7705586bc..7614dce99bd8 100644<br>
--- a/utils.c<br>
+++ b/utils.c<br>
@@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head, const struct ptes=
t_options opts,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;S=
TART: %s\n&quot;, progname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERATE_=
START(head, p)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char ptest_dir[PATH_MAX] =3D {&#39;\0&#39;};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char *ptest_dir;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char run_ptest[PATH_MAX] =3D {&#39;\0&#39;};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pty[2] =3D {-1, -1};<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0strcpy(ptest_dir, p-&gt;run_ptest);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dirname(ptest_dir);<br></blockquote><div><br></div><div>strcpy(pt=
est_dir, p-&gt;run_ptest); // This assumes ptest_dir and run_ptest are both=
 PATH_MAX; perhaps improve with a secure version of strcpy?</div><div>ptest=
_dir =3D dirname(ptest_dir);</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Copy, since dirname() may modify its input buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (strlcpy(run_ptest, p-&gt;run_ptest, sizeof(run_ptest)) &gt;=
=3D sizeof(run_ptest)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR: %s exceeds P=
ATH_MAX\n&quot;, p-&gt;run_ptest);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto ptest_list_fail1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ptest_dir =3D dirname(run_ptest);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;ERROR: pipe2() fai=
led with: %s.\n&quot;, strerror(errno));<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--0000000000006f2dfc064bd05059--

