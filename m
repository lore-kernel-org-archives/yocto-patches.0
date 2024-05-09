Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED5C25B4F
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 13:01:40 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.9837.1715259695852410854
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 May 2024 06:01:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iv6nR/nK;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: rybczynska@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b27c660174so642623a91.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715259695; x=1715864495; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYG9CFKacPdzer4O9+viqTaiJv1LmbNLyctnynZ8XIQ=;
        b=iv6nR/nKwkJa8q8sMTBBcjL21JCvZ2SORqXa53xq7a3P92LoqwiIGeZFywzP+qrayo
         J60GRs31N6elU6hTDv3lpUBMLqGarAFQyn2oeBEyD8SDf0fN2cZbCtXvTHeAUcrgfWAc
         hcL2ypXQOPuD8tMrt1CRGRA6JDGwCcbxY/ENVwlw82D/y6jAB9bGJ/FDKKQB4I6SSfhI
         I8py0F2J9DtbsqYpo8hjTX7SrqioGWFiNLeMbLBo18cvvgDxnoPXz5CFxJ+tetCL10VS
         iM0wvXqjVeYtDD6ol6pJFWC9sxDo/Q37BG46s9B9xGGENl3maJqXWB2EY/ERHOm0hk4F
         dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715259695; x=1715864495;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYG9CFKacPdzer4O9+viqTaiJv1LmbNLyctnynZ8XIQ=;
        b=V7O7f5qhUveIKC+zcKtaah38wdJsX7FTe0+p1jFpq8bRdEN35ve0dXK1Ir+UKEViOX
         zpdIbidy8SWkSkP/A1Ily186Hy+M5MR6wDCu+QQrB9pYN/5/2BN9G4cnKfSUGjX6+vEs
         q3Op/95illp6qEXCMgl1OkCWj5VOXOqkW4GEN3rjQNi+2T0vMGc8FfmhxjQLNp8IVB6t
         nKoEuU7cY9BFMR+aW7b6T0bauPHyO42iG7Ll/EyCNoLePc7j6C7sN13MicC/3MI28n3p
         E3nnvp5Sf/x99rgg+33kpoYzlPGZaAVFKjQC7UYCSYXf2MeorUF0FenAwZtcPmP+VVlP
         tiew==
X-Gm-Message-State: AOJu0Yzs0SYggnZ7N8b1JjFfRf90sEdI9CQroHV0tRb20P0fo5iewgV8
	JAqr/y+uVkNpDpcdqOpGQMe105Pv6YCy1bbuPQXxsYEdqqSdyRd+XPjswj0lLpKQtAlVh9A9J1U
	x0/LwMBT7ESwvDGSXhuDPPsB/GSYcbA==
X-Google-Smtp-Source: AGHT+IE4GK+I3jUAkpfLIDQej4dTuYzb0m0u24k9yXnADvgRq/0jFR8wuEOvy16IspGu863+aaw072GQ56bJmyr87y4=
X-Received: by 2002:a17:90a:e2d5:b0:2ac:5a83:b8b7 with SMTP id
 98e67ed59e1d1-2b615af6df8mr6203130a91.0.1715259693008; Thu, 09 May 2024
 06:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
In-Reply-To: <20240508070412.2939015-1-mingli.yu@windriver.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 9 May 2024 15:01:20 +0200
Message-ID: <CAApg2=Rxma2ggie=wQr_ZtZOQ7i_J1_7xzOEOHfrrhBoz8jigw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000b310fe06180504da"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 13:01:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/113

--000000000000b310fe06180504da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 9:04=E2=80=AFAM Yu, Mingli via lists.yoctoproject.or=
g
<mingli.yu=3Deng.windriver.com@lists.yoctoproject.org> wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
>
> Userspace functionality that requires BPF is becoming more common,
> so enable it by default [1].
>
> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
>
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>

For a big feature (and attack vector) like bpf, I think it would make sense
to create a new
DISTRO_FEATURE or so. People who want bpf can enable it (probably they
already do),
others do not have a feature they do not need.

PS. Yocto kernel options review is one of the things on my TODO list after
we're done with
the CVE crisis...

Regards,
Marta

--000000000000b310fe06180504da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 8, 2024 at 9:04=E2=80=AFA=
M Yu, Mingli via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproje=
ct.org</a> &lt;mingli.yu=3D<a href=3D"mailto:eng.windriver.com@lists.yoctop=
roject.org">eng.windriver.com@lists.yoctoproject.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">From: Mingli Yu &lt;<a =
href=3D"mailto:mingli.yu@windriver.com" target=3D"_blank">mingli.yu@windriv=
er.com</a>&gt;<br>
<br>
Userspace functionality that requires BPF is becoming more common,<br>
so enable it by default [1].<br>
<br>
[1] <a href=3D"https://lore.kernel.org/all/20200224140131.461979697@linutro=
nix.de/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/all/2=
0200224140131.461979697@linutronix.de/</a><br>
<br>
Signed-off-by: Mingli Yu &lt;<a href=3D"mailto:mingli.yu@windriver.com" tar=
get=3D"_blank">mingli.yu@windriver.com</a>&gt;<br></blockquote><div><br></d=
iv><div>For a big feature (and attack vector) like bpf, I think it would ma=
ke sense to create a new</div><div>DISTRO_FEATURE or so. People who want bp=
f can enable it (probably they already do),</div><div>others do not have a =
feature they do not need. <br></div><div><br></div><div>PS. Yocto kernel op=
tions review is one of the things on my TODO list after we&#39;re done with=
</div><div>the CVE crisis...<br></div><div><br></div><div>Regards,</div><di=
v>Marta=C2=A0 <br></div></div></div>

--000000000000b310fe06180504da--

