Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2DCCD199
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 04:14:37 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.8272.1760674473780491953
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 21:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KBfZKtDU;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: rybczynska@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2907948c1d2so15961095ad.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760674473; x=1761279273; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGRfo1kPNPlAMFLL1DnLXtKOtsAyXjP313Ql5Vejaiw=;
        b=KBfZKtDUtV1jSAYK7ICEBQOGhLyrCFfYNgYo64ZHVirT7vfn02y6DUcPSHCAH5E4j/
         EekSek7BHJo0SWc+wVRGZ4yVp06FrhtE70LjuBLTiV3z59PLQAhFweyQgI+XX+S9lt1/
         ZqdsKAn7pcXEsBT7pjh4Jb+Fcibu2BXnt2ffJZUVK1VBXLlqBXedRkS9uG6O6ktSbgL1
         IUUOGQPWpe7JtP60KAl5Ez9p7q3Vh2R4W6EfoIphqt7p4aKUxfd/8AZUFn1jY3P7J2w2
         NK0yJEulBM9msXZaC1lieeQF2NpAwSR4MmGUGrJY2AzXRusBQk6VB8szePEwoL+8V3Kr
         +pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674473; x=1761279273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGRfo1kPNPlAMFLL1DnLXtKOtsAyXjP313Ql5Vejaiw=;
        b=ZBf5CFxvOX1ZpfvqffiKKeqJLwsVEyd7U2/q6r1xKnDpC7qSK0/qqoind+uAJ97tur
         rAThC1dUywfgC83KP45Fnu4f354k2VmE5CbiSsfidqyVgv5inYRHNU1UnKg0opQnlnts
         4Jvz/shlvkxPC9I6lMUEGEfi3HVQQWcUdVs5MMdqKXxwTsqIYCxFxFZR3x76dNZtWw11
         lRZSRLYHEzJA9A2Caw92AoKd/DLdjRbClg+szgAQ0snMwWQnD3ozt4p3XGhI4lT4c/te
         3WljMWBPT7ZJDm+v7xRGm7eK4bP/Hr+xmpIn3h24/v//pI+VZLb3b6xVhc2g2l7c9+71
         rZPQ==
X-Gm-Message-State: AOJu0Yzy4k92VDzRmYs9Cg7/200wD0Cfbywb2BUm5O95HH/Zn1rzIKxN
	RBvwTQOPU1Z+6vcJMeUZ+ZqqcS34mpUSjdwMk/52kZgAshDsqZCg8nrRH4jtpzn1nWMLVe/w4rt
	l1qVScl6KPULRrGC/PtXdJT03bOE7e10SuY1M
X-Gm-Gg: ASbGncsBrJ5UBCNe5EzX4xzGfNH1rFFrE37fGT/WwQ53LGiPu6yspEU6qx1TxiCf+OR
	JYGj9DRKrMfuFk7xcpJKypkQ+jo31pvsbsTFmviCOo9aMhk5B4rvxuQc+ZGLCcO82f5PoGKayjv
	sjXS5JCtdt82tBna7+UrstZs9pRhm2TyrOWYdJLVhYscNY97aqV6CMmGqyoRIbAayAs/7rjKWAK
	wlKEScqnDx2tWog8UNWCez7QfZEtoMOxjCUgDd4099B9bWY63dwx+OyY6ILj0nZVoyN0Q3vjjpk
	gFz1JvvnFQkTa+gK5F5t5hOzbucf
X-Google-Smtp-Source: AGHT+IEdi/C8ek9EBLySmN9DvyFXjUAP6kdL8DezWiuISxw0IGp8IQKBexdqSk9FilhzQOysIXJcycUvcT1vbWe/VMk=
X-Received: by 2002:a17:903:8c6:b0:290:d0fb:55ab with SMTP id
 d9443c01a7336-290d0fb57e8mr22479855ad.50.1760674472450; Thu, 16 Oct 2025
 21:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1760648348.git.scott.murray@konsulko.com> <6cbe841e8b09ac4804e8c87e23f81d68f97c17f4.1760648348.git.scott.murray@konsulko.com>
In-Reply-To: <6cbe841e8b09ac4804e8c87e23f81d68f97c17f4.1760648348.git.scott.murray@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Fri, 17 Oct 2025 06:14:19 +0200
X-Gm-Features: AS18NWAgOr9ykaXkCOlnFy8vzS6NJSL_mYyz-bWrCGJ736IBxW1DzpxobdcZmvM
Message-ID: <CAApg2=Qyi6MuRVhwux=1y6TfGgu+6Xs6Hc3rXod7tBaU0vZApA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 01/15] kas: use repo name
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Content-Type: multipart/alternative; boundary="0000000000007edd32064152f86b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:14:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2341

--0000000000007edd32064152f86b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Scott,
We do not need this one, it will actually break the build for
meta-security, I have removed it already earlier this week from
https://git.yoctoproject.org/meta-security/log/?h=3Dmaster-next

Kind regards,
Marta

On Thu, Oct 16, 2025 at 11:22=E2=80=AFPM Scott Murray via lists.yoctoprojec=
t.org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:

> From: Marta Rybczynska <marta.rybczynska@ygreky.com>
>
> Use the repo name directly, otherwise the build can get the wrong clone.
>
> Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> ---
>  kas/kas-security-base.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
> index 17f4bb3..e5af7bc 100644
> --- a/kas/kas-security-base.yml
> +++ b/kas/kas-security-base.yml
> @@ -6,7 +6,7 @@ distro: poky
>  repos:
>    meta-security:
>      layers:
> -      ../meta-security:
> +      ../meta-security-staging:
>        meta-tpm:
>        meta-integrity:
>        meta-hardening:
> --
> 2.51.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2326):
> https://lists.yoctoproject.org/g/yocto-patches/message/2326
> Mute This Topic: https://lists.yoctoproject.org/mt/115797538/5827677
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13234581/5827677/971=
106717/xyzzy
> [rybczynska@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000007edd32064152f86b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Scott,</div><div>We do not need this one, it wi=
ll actually break the build for meta-security, I have removed it already ea=
rlier this week from <a href=3D"https://git.yoctoproject.org/meta-security/=
log/?h=3Dmaster-next">https://git.yoctoproject.org/meta-security/log/?h=3Dm=
aster-next</a></div><div><br></div><div>Kind regards,</div><div>Marta<br></=
div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Oct 16, 2025 at 11:22=E2=80=AFPM Scott Mu=
rray via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</=
a> &lt;scott.murray=3D<a href=3D"mailto:konsulko.com@lists.yoctoproject.org=
">konsulko.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">From: Marta Rybczynska &lt;<a href=3D"=
mailto:marta.rybczynska@ygreky.com" target=3D"_blank">marta.rybczynska@ygre=
ky.com</a>&gt;<br>
<br>
Use the repo name directly, otherwise the build can get the wrong clone.<br=
>
<br>
Signed-off-by: Marta Rybczynska &lt;<a href=3D"mailto:marta.rybczynska@ygre=
ky.com" target=3D"_blank">marta.rybczynska@ygreky.com</a>&gt;<br>
---<br>
=C2=A0kas/kas-security-base.yml | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml<br>
index 17f4bb3..e5af7bc 100644<br>
--- a/kas/kas-security-base.yml<br>
+++ b/kas/kas-security-base.yml<br>
@@ -6,7 +6,7 @@ distro: poky<br>
=C2=A0repos:<br>
=C2=A0 =C2=A0meta-security:<br>
=C2=A0 =C2=A0 =C2=A0layers:<br>
-=C2=A0 =C2=A0 =C2=A0 ../meta-security:<br>
+=C2=A0 =C2=A0 =C2=A0 ../meta-security-staging:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0meta-tpm:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0meta-integrity:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0meta-hardening:<br>
-- <br>
2.51.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2326): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2326" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2326</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/115797538/582=
7677" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/115797538/5827677</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13234581/5827677/971106717/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13234581/5827677/9711067=
17/xyzzy</a> [<a href=3D"mailto:rybczynska@gmail.com" target=3D"_blank">ryb=
czynska@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000007edd32064152f86b--

