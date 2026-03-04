Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E8EF8FFA
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 15:41:14 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21183.1772638873523676386
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 07:41:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=wK0iBzs+;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.51, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64caaacb9bcso6701963d50.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 07:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638873; cv=none;
        d=google.com; s=arc-20240605;
        b=dLSbw0WfpKc03A9p+/Qlz3JRrp7PwqBW0LokLn8wksh1ghSG5uqsXj2bTckMOaQtx1
         8MF+QjMtdjEzt7aKODEjWI804/LFrJav0KpPUV4xghSOEk1NXqIETjz0RpitMlhO9QV3
         TOXjoStkxsjb6rsjQjU2Fk8QEVfW/si2p2538kblIVjOCGv2+WcumImuWocetw4gl63B
         XYbXxD61PtrAbOjnPouRCYdT81M5uPMEK8Dv6IGElMM1kMSKCHsEnjQDvPEKYbmDfUkI
         CYL+Zo6YVizmiOp57Dtc4y8wsmh1lQX6/n4Rmt/Hwg81qDcZKEuXVaJrc7fQVkeUySAZ
         MJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BT9OSb136zDL4kYpxm0Ak0eNbVw5XrcCNswVXuIQu30=;
        fh=CFbuv9lAPQTpTkNh+/GMEDdLTkmVJCREhf1Eol1iWWs=;
        b=P9fnBLC+CQ4qtddyNH7yC+yRfTHCupRb5hqqbYbUhHTmm0kS+YDHstnisRsyNXpwU+
         EdCaXDTdnflMXAVAg9wMpIZYmJAYejFLKUpH+G8GCm2O6Ih8uRRC/WifNsVk6lX/aZwO
         X13kx6rqMiIxqBVtrbEU8E3se/VZ9xc4AjuliwzmbJzkkxcbZUnza1gW+y+bcUTeNMU5
         WyxAm281FdEdbtdOIdzowucH/vMx2ZePqwxU3KkYMl23pYQmVyB5ut8dmOpf42stt8lq
         uH3rwOFfrX0COmv8TJGtvQlnQlxJy5FX0Bw3tBKkPv1bNBFZmZ331h+J2dskyZPMzrcw
         knpg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1772638873; x=1773243673; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BT9OSb136zDL4kYpxm0Ak0eNbVw5XrcCNswVXuIQu30=;
        b=wK0iBzs+h73LtHzX8s65WxvBxvDTKjYNAKxB/IMImNxte4D6Tx6Aw3xCuVb1liaA7j
         pGyuYcU26Ect9xvK0MQ8VbeV5vRrFeP815bRIJhdvYUR9Kt21rDsiCCBxake7RELYW3H
         D8jT7Ku6ffEGT/Fp4ecuDS6NvsiYXtkvrpOskIV3p06ZafMarkg7M9xxHl3LYn6JHq7f
         j7zJbDPy+ygtX0WA6ptEuwBAz61pySbIO0qb14qPGx/cX6JqbBUATnoLZHHSMsrHOhnr
         04SbXq28XLy4CIxUCBxI7FhyPo67ZSKtobNwZlWcRaqIq26BV0XxWAQyWP9pQsBrAc3L
         er9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638873; x=1773243673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT9OSb136zDL4kYpxm0Ak0eNbVw5XrcCNswVXuIQu30=;
        b=xH3Uvaqbh2DmRvYta0zLc3x7GWdU9vZ/yzaGlREc2krSacAjipFfrrbMjvwn6hbtAO
         qN7XtqGhJ/17TdNc1etQ7/0ym8EmL8XYJ95WJV4sWBHtp7JSI0UXpqzly4nCQPNeN9QB
         ojMKGf3IT+BsJSmE3aRbaSVaoT7qKU5NaZaw0gT5bDANvkJra7ZMYtoe6Kq+i68Sewzu
         bATPvseSUiVvZ968FhbSrAU5E9+ZV+BGGoOx0DdmOTg75egsdSN/1bvMVeahLhRd9O/e
         QrTQ4XnZPBdSe0osO19XK45MBmexId4cMKRYzcqk2zl4zHYbT7eLLztI/LvPf73iEL4J
         P87Q==
X-Gm-Message-State: AOJu0YwAADF1tpryGNE/67uOedAHgtKBKl2TimDlfc5s3ZBLJc+j0lsf
	cqZ2qqQh5vNRbenCXs4O12RhU8BkI0r4ndPMy2u35PECth8gumHoDMczN9X5RMInV3u5EvGBGcy
	sqqak04Z1Azu6jF0+mVjXAAgVBzHpaShnB1Ec4NEHUXW6xlj0q5vk
X-Gm-Gg: ATEYQzzGxesveY+HdPr4tSuk9vqtPcGHshIYHPESkMvwvQXMLtCoagLGDxCw4HxeAPF
	bmpKKSwt0Fst4pUzfO7DRQcjDK8WIi6oAmXZgNzWcs2pH6fa/dqxE2VqWIHi2w1kHRnzW2aznNn
	AgYWxSNXytnLKorMJueh48ppp10vemXs5N5xsvtVGSJfvxAP/9h0q1PkSmN0MJjjSxLvhb+LZ3h
	/cG5NXZFM88JsZxdD5vPXCSA2jpmCfw97HV3AgfSwtpey4EgNHDtVXN198U6J41TuUlFK3B114z
	2GNCv78k99q1n9bV8AEj3rAS/wBJdWi+DEtLRWYDrj704Ls1g97K6R2SQM5CRsC/by6/gw==
X-Received: by 2002:a05:690e:1343:b0:644:444f:3bd1 with SMTP id
 956f58d0204a3-64cf9ff383dmr1782799d50.68.1772638872616; Wed, 04 Mar 2026
 07:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20260302174500.357368-1-yoann.congal@smile.fr> <20260302174500.357368-2-yoann.congal@smile.fr>
In-Reply-To: <20260302174500.357368-2-yoann.congal@smile.fr>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 4 Mar 2026 09:41:01 -0600
X-Gm-Features: AaiRm51lam3kdcjFpm68hV_S8v3BJK9KmpZmNxUMgCY7r7DqyRmiA_Od8KeSVHM
Message-ID: <CAOU5ZMvZ8ZywMpo3b+2LfJa7u83N1k6QqqvbZPJ2-TNsu=Qcnw@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH 2/2] utils.c: print a message when a timeout occurs
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000514e3a064c34a6dc"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 15:41:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3329

--000000000000514e3a064c34a6dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

On Mon, Mar 2, 2026 at 11:45=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:

> From: Yoann Congal <yoann.congal@smile.fr>
>
> This will make a timeout occuring more clear in the logs.
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  utils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/utils.c b/utils.c
> index 6cf7705..6cfa26f 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -498,6 +498,7 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                                 }
>
>                                 if (timedout) {
> +                                       fprintf(fp, "Timeout! System
> state:\n");
>                                         collect_system_state(fp);
>                                 } else {
>                                         /*
>

--000000000000514e3a064c34a6dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied, thanks!</div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2026 =
at 11:45=E2=80=AFAM Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r">yoann.congal@smile.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Yoann Congal &lt;<a href=3D"mailto:yoann.cong=
al@smile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
<br>
This will make a timeout occuring more clear in the logs.<br>
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
---<br>
=C2=A0utils.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/utils.c b/utils.c<br>
index 6cf7705..6cfa26f 100644<br>
--- a/utils.c<br>
+++ b/utils.c<br>
@@ -498,6 +498,7 @@ run_ptests(struct ptest_list *head, const struct ptest_=
options opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (timedout) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(f=
p, &quot;Timeout! System state:\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 collect_=
system_state(fp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
</blockquote></div>

--000000000000514e3a064c34a6dc--

