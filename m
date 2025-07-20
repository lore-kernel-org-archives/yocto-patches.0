Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E0C83F22
	for <webhook@archiver.kernel.org>; Sun, 20 Jul 2025 18:26:26 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.23123.1753035979013282064
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Jul 2025 11:26:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EojPm2O8;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: rybczynska@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313f68bc519so2291970a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Jul 2025 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753035978; x=1753640778; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dTlwXpG0OjcTrGKPTP9sqr/eRoHcIaUrKIC3y7Li1Q8=;
        b=EojPm2O8/P7yY/w+LYdiCfY2v1f++6c2j9opE6ug6flHqJRGFziRpRZlm9CZ6zyOKE
         4bbemDaqEoVFkcIe1bl3HEBCqPe4Un6QrxxFUZik/hZTaKsotLEkk0DXRuwwuGJicOv3
         vQQ5EKCsnFKP7jP1f10uDCGXVQET7XG69Y/Egedu+2Opg7ZTdsvbtTm8TE3G+mvfl8Ue
         0ZG0lrUnWrGnx+flGOqvQVeWtCsyacJBsj+Xt3kxWHf0MOQd1NWbWPYuMrAwP4zZguPD
         77IM29TC3GNk6fdFT+xtao+s0R7tIknHcBuIf87huoRuww6sPRQWvq4MeCYb7aqMcR2w
         YBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753035978; x=1753640778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTlwXpG0OjcTrGKPTP9sqr/eRoHcIaUrKIC3y7Li1Q8=;
        b=wf1OwTa+UIghnhWEkBdQ4XbA7dUkUNU8WT/9xnvUpjxDgU7ppFezIEYeOmR23Qo1M9
         iEsX0BlZ0SEy1X+CbT6t1ruDxdt+9elXGC3ww/0vySCkoKxY7Ig70GLQkVBqHGCt81WS
         LbqSingpRUxtuldH6LKRIwV25X6f5LHwHGMDuO6QVuUNs1wiMcd9r3dhGEWm8awQ/exO
         JyZ6UhiC68GSF9yATUihC86i3UGVbyA6lecGCrE7x5VaYs7ZHGyFy/cmxnN4z9zHxyrr
         qdAe65OpJJVbfa0Q/0ZZj5oMsmctz0ovm1Ydy+u+RGszcN0vhwpKvJr9Py3TPSbinDTW
         4oWw==
X-Gm-Message-State: AOJu0Yy0egJyPAGNUq/7hDAxJpcNtogubi6ztQpTkBeNk4tQqFlC8o5k
	PQspKUFid49Cysq6t7WeiWMCdmgXN/EAZcdAEAFZb7Fg3412c82yFXtqgEkcwU3QAz77MoBvtv2
	G2BBkvI++FIzNRbDwUtX/Y6gpDhRONm8M5A==
X-Gm-Gg: ASbGnctuDesWbS10vSp6gdqmqO8PSgcC0DsPJPiZHsO492DG6YgLjibRuZ11bYwgH35
	FQUkpfi+D0dgNcXGv+CFvsEUemdu7vmmq/VQP98o1yGJei2lZ7+Qh8MKSfhFPXsEoXpgqgPXqAp
	SGS59AJs+E/4FhNM+cjcEfWNx6EbPw/9MrDzXjLitAvmrVqGh/Dt7f6wRAZMwe6WzH0aBc5NDj9
	Oz+Yw9G
X-Google-Smtp-Source: AGHT+IF1Zv4eUN/LHDGJIY1UG/0mVfdS23eTI+QTrqJEH37KI2Wp5OfPLmmfAsgzl8ioXJMO32x3hEyAaJ3nnOcjCGs=
X-Received: by 2002:a17:90b:4c52:b0:311:ffe8:20e9 with SMTP id
 98e67ed59e1d1-31c9f4a6b75mr29233733a91.17.1753035977885; Sun, 20 Jul 2025
 11:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752846514.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1752846514.git.scott.murray@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Sun, 20 Jul 2025 20:26:06 +0200
X-Gm-Features: Ac12FXzSCPX2ev2-0BsUnLZVAac1INl6fEF2tT5m48M7vIsZwFOOzptFqSu6-Ss
Message-ID: <CAApg2=Rs6QLgeErvpfFaAOP6ghbx+tBch7jFBBweZoNJ+M=24g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/4] master-next updates
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Content-Type: multipart/alternative; boundary="000000000000bd8c29063a607ed1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 20 Jul 2025 18:26:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1817

--000000000000bd8c29063a607ed1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:11=E2=80=AFPM Scott Murray via lists.yoctoproject=
.org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:

> Roll up the submissions since the first batch of whinlatter fixes,
> plus an upgrade of scap-security-guide to get it building again
> after the CMake 4.0 upgrade in oe-core.
>
> A note about the ptest removal for scap-security-guide; while
> having comprehensive ptests is desirable, from the commit history
> it is clear that there was no interest in banging these ones into
> a working state in the last couple of years.  As well, ptests are
> not enabled in most of the current CI build configurations, and it
> seems clear that the build time hit would be massive in this case
> if they were.  If someone motivated to try to investigate resolving
> these issues appears, this decision can be revisited.
>
>
Fine for me. This commit leads to a better situation in the CI, OK to merge=
.

Kind regards,
Marta

--000000000000bd8c29063a607ed1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 18,=
 2025 at 4:11=E2=80=AFPM Scott Murray via <a href=3D"http://lists.yoctoproj=
ect.org">lists.yoctoproject.org</a> &lt;scott.murray=3D<a href=3D"mailto:ko=
nsulko.com@lists.yoctoproject.org">konsulko.com@lists.yoctoproject.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Roll =
up the submissions since the first batch of whinlatter fixes,<br>
plus an upgrade of scap-security-guide to get it building again<br>
after the CMake 4.0 upgrade in oe-core.<br>
<br>
A note about the ptest removal for scap-security-guide; while<br>
having comprehensive ptests is desirable, from the commit history<br>
it is clear that there was no interest in banging these ones into<br>
a working state in the last couple of years.=C2=A0 As well, ptests are<br>
not enabled in most of the current CI build configurations, and it<br>
seems clear that the build time hit would be massive in this case<br>
if they were.=C2=A0 If someone motivated to try to investigate resolving<br=
>
these issues appears, this decision can be revisited.<br>
<br></blockquote><div><br></div><div>Fine for me. This commit leads to a be=
tter situation in the CI, OK to merge.</div><div><br></div><div>Kind regard=
s,</div><div>Marta <br></div></div></div>

--000000000000bd8c29063a607ed1--

