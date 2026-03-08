Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8AEA8535
	for <webhook@archiver.kernel.org>; Sun,  8 Mar 2026 16:09:14 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41810.1772986152600666496
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Mar 2026 09:09:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=wvo7nmtU;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.50, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649278a69c5so9125413d50.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Mar 2026 09:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772986152; cv=none;
        d=google.com; s=arc-20240605;
        b=MxnJDvpFyPR+MYGjQ5r5UWoncufCqAhIp+wMix0LJOHP3rORpIgNgkEk53gYcZ1CAf
         sCDx7bKQXgBirGv4B09EPNeB4U/hHAO9k7yS+APBNJzPncyXalmvos9kilptRUm7arLO
         5K1dDKlGx29hIRdWI2lnI4cJ7RTHF52s9cb8XrmEnIXyU3GXMkbGXhL0QcygPOlizTgG
         8BAIddnbcf/XWkEsLdYFGv1UMm4shFTbdOwRUVqj1hZQgCpjNTtetg1G3w0MzV3Irkgu
         +cznG4I+UMGTMhObfY8cZqcD1yAr9Hrr/AQqM+tIGsKlz9O3c2EXNwYcfJiNzHHHWz1o
         eWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=USPwT1gqGn6Rwt4OXHIrzecDGYJ1mOo7EbsNqurfgY4=;
        fh=/MH4wvhPUtbRPiZV7Tvq3PiOTTSvYSOpadHYMgLRw3c=;
        b=PlOPcTePJW4S9lefvTf1kEvM/0tBE4T8BffoCwAMjo9tCnMSLDOX5mMlfL1T0cJGg/
         7g495zepxCwZpxxkBz0K0nnu1KiFMzSI95nSqWkeFofHLPzxoGwvvJNDhY6IUXE+Jxmo
         MaW+THSIo8QoWinduSTWEka+4PhbCNtnvgldzIrANFqPjADrQe36NEDzIO8qydkoC+kj
         OCy+FgZB/tAPo2wRk7DKGDAZ7qnMeT6/OHxKyJz3akLEeHSCIvATI4VwqiTladRXhh2n
         d8kyTeTpqoBdb9Rus+tpJ2jHC9ki6md3QSnaVgbR/G1K31ltn2waL75N3mKTYDDjDua7
         ShOA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772986152; x=1773590952; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USPwT1gqGn6Rwt4OXHIrzecDGYJ1mOo7EbsNqurfgY4=;
        b=wvo7nmtUDJX7ZHnwHs6csJiZXh823UL9nnI3yT3b+z31GrCRz2ZNoTFmMiCyz8fZnj
         fW6/fMOKz8i521vKjbUq1w2MrOamufd27MhcuG7ER2yjtyxZhoOMkkFV6+dgBMjnA7z9
         npBnRel0uWUVAnAXTIpsoGerYKOyj/gvBn6uQ/csVKkoieIUIkkbclujqgRMx/UZ9QOd
         BTsHGjn+CXUd00L7T0m+jLYJ5nc8Hdqhu0TxnnPW7IXhp6c+Q1Rep+M/guuDKGp1bXld
         xXYRBaqrPX86vc39BPcYT6DEXfmugdBOZaCoumKxKikGr5Y2ltLF+sJNjN97nHnVwE4k
         uoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772986152; x=1773590952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USPwT1gqGn6Rwt4OXHIrzecDGYJ1mOo7EbsNqurfgY4=;
        b=IjIg6liwATzdk3G/mtNQ4uo1LJ/xDKcDcYBno80xAor+IBQfxjMVCf0ndQIKcZ3UpD
         S+C10+UUhZX/Pq6vFizN29vvMrQMrG45Ba7YPkEhlpQx3CQVELNDXKsX8BdVPrATZhaX
         9ppJDevaYgkzovUBgetvTOCd7eYVERVLF3HRfi+nuJiydzbVk586IVM19Rx16KfM/GN5
         EwBRczbpYAeAQxaxZLIeigwHVYP5yUlmaAqRLBDzfrjzp/0Oxi26YRlj8sahciJoubx7
         6l2SWirsI7daj9ealuYuzFYI3zW8YdMkeaYp+mSH8wv5UVtDzp/UV/ozpRjKH5M7PGSj
         pVSA==
X-Gm-Message-State: AOJu0YwLL7/4zOstBIJs239LqyDUN4aQCwXP6ZSQnrAuXnOegamc0kyH
	Kz2522ZGYa5+bisvsyEU8DyFCSmnafvel3M/hebpoeHFii50p9FnQnlLI+r5cC/rfc4GwUtQYc9
	sPprHZCD2/CSiG4URoC0Vk2jUbuRWmAuMC8Eb3qCfDw==
X-Gm-Gg: ATEYQzy4/tWzSfdA/CvngU2/tbp57wpEroR7v9BMfmDKovbamUyLk6QzYgC8cW0xxN6
	6gfz4/Dotnf6gmzusJeKbsotaoYJ9OcTk6Ea5XUDTEW1xVwtIYHVqtLbCy23Q3c2OfO9PfecTFh
	SS9eiiZS+CNVlWZPPtowneRZNSeLKz7SDCc5BAh+h7gukFiuJFs9BVn5uC31oPyEZ6KO1OM0ioV
	CdCdfpO9zeNwdczzfJueQlZjgJB2M9v+Az0gY5o0qLv/l7ku5+7tYCkWYwK8uhL22PvzLwOluFB
	D5brYC+JAD1GFbVVUxNF7+qHctacHkeAafGoSwOQQtSWdt1yymuk36lA5WbD/bGh7Z4h1W/7h6t
	hyF+U
X-Received: by 2002:a05:690e:130c:b0:64c:f8a3:86d5 with SMTP id
 956f58d0204a3-64d14279b15mr8281784d50.42.1772986151549; Sun, 08 Mar 2026
 09:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260307103516.2584088-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260307103516.2584088-1-richard.purdie@linuxfoundation.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Sun, 8 Mar 2026 10:09:00 -0600
X-Gm-Features: AaiRm5116WW_6v2y40xfAKdZ0nXkHHLnHVhnkuAi1X3RA9a_-LTzCmBhiDN2Wtw
Message-ID: <CAOU5ZMsFdKyjkYxf7dF6bSzgG=u-ZKX1tVkPCFA1taMqPjUzVA@mail.gmail.com>
Subject: Re: [ptest-runner] [PATCH] utils: Ensure output buffers are always
 line based
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000c14b01064c85813b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Mar 2026 16:09:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3378

--000000000000c14b01064c85813b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied!, Thanks!

On Sat, Mar 7, 2026 at 4:35=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> When running slow ptests, we can see an issue where the tests are writing
> output
> but it doesn't make it to the process (e.g. ssh connection) running
> ptest-runner.
>
> The issue is that the standard buffering for non-interactive terminals is
> 8kb and
> some ptests don't output enough data to trigger a write. This can lead to
> the controlling connection timing out.
>
> This change forces the output streams to be line buffered in all cases.
> Most
> ptest output would contain newlines so this should work well. stderr can =
be
> unbuffered by default but making it consistent here seems the best
> approach.
>
> Testing with this change on slow ptest runs (e.g. qemu emulated) showed
> much
> more consistent data with this change.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  utils.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/utils.c b/utils.c
> index 6cfa26f..192d3d0 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -434,11 +434,13 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                                 set_nonblocking(pipefd_stdout[PIPE_READ])=
;
>                                 pfds[0].fd =3D pipefd_stdout[PIPE_READ];
>                                 pfds[0].events =3D POLLIN;
> +                               setlinebuf(fp);
>                                 dest_fps[0] =3D fp;
>
>                                 set_nonblocking(pipefd_stderr[PIPE_READ])=
;
>                                 pfds[1].fd =3D pipefd_stderr[PIPE_READ];
>                                 pfds[1].events =3D POLLIN;
> +                               setlinebuf(fp_stderr);
>                                 dest_fps[1] =3D fp_stderr;
>
>                                 while (true) {
>

--000000000000c14b01064c85813b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied!, Thanks!</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 7, 2026=
 at 4:35=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">When running slow ptest=
s, we can see an issue where the tests are writing output<br>
but it doesn&#39;t make it to the process (e.g. ssh connection) running pte=
st-runner.<br>
<br>
The issue is that the standard buffering for non-interactive terminals is 8=
kb and<br>
some ptests don&#39;t output enough data to trigger a write. This can lead =
to<br>
the controlling connection timing out.<br>
<br>
This change forces the output streams to be line buffered in all cases. Mos=
t<br>
ptest output would contain newlines so this should work well. stderr can be=
<br>
unbuffered by default but making it consistent here seems the best approach=
.<br>
<br>
Testing with this change on slow ptest runs (e.g. qemu emulated) showed muc=
h<br>
more consistent data with this change.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0utils.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/utils.c b/utils.c<br>
index 6cfa26f..192d3d0 100644<br>
--- a/utils.c<br>
+++ b/utils.c<br>
@@ -434,11 +434,13 @@ run_ptests(struct ptest_list *head, const struct ptes=
t_options opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_nonblocking(pipefd_stdout[PIPE_R=
EAD]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pfds[0].fd =3D pipefd_stdout[PIPE_RE=
AD];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pfds[0].events =3D POLLIN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setlinebuf(fp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_fps[0] =3D fp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_nonblocking(pipefd_stderr[PIPE_R=
EAD]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pfds[1].fd =3D pipefd_stderr[PIPE_RE=
AD];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pfds[1].events =3D POLLIN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setlinebuf(fp_stderr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_fps[1] =3D fp_stderr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (true) {<br>
</blockquote></div>

--000000000000c14b01064c85813b--

