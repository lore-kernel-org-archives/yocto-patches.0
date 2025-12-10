Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE49D2CE17
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 08:35:31 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11013.1765355722241991536
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Dec 2025 00:35:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lKcgscUc;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: rybczynska@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29e1b8be48fso34305425ad.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765355721; x=1765960521; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJ7Z4qQk5lQvkqIM/GIQRdtkEEWl5PEplmbt0Uexsqw=;
        b=lKcgscUcsqMrQMXoZT9QSHOUcdlX13HejpYZCmHsiCU0OpXGANnghgRBstbNVSZ4gE
         cnWszflyg1v4Xr1PBqJjihxsUSI4op/h0Nd6+Jb/JQ6ouJYpZNU1l7ZSwYR11hzyrSSU
         JuIb/kGifpXmZfb7HN1z8wWiKmIzB6P1rgzMyzf1fP95Izmlg958WBK2rljHQ8bXju3L
         tyeVb4NJPE68chBOAA3okQn+aEJDm6tddVooXYoIu/coYWF3pRgwTsTWW5LQowziFRRa
         BBuqTY7zOTCJSYNpmTCrlnL3VcBcvl/AhNMLfI3mM1TZwmhFnRE+9dQhu67W1bc03OHS
         IS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765355721; x=1765960521;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ7Z4qQk5lQvkqIM/GIQRdtkEEWl5PEplmbt0Uexsqw=;
        b=IOZuZRW26LKWHjDspsJ8VcW01gXIvU4RFPokfeltAgmuFcUFTQZUibSDYeKfZeQfDw
         Y+GYL0u3z8lbKehiv+JOXRrLDiklOVQuUG4qgceQc0av+XJxuLLYy4c8qZPi7hL6zcdH
         c7NCdVBLYHT1A6uUu12ZnVFbjoMuO2TfJgqo2mOUamWS4m28/lpoOYjs+FEK2T4D22yj
         9l8eHzehumei/Kt5NaocW6dBU/efM6RLSPtKQriD/eUsnRWPqdLjnOpz1FmwTLRFbslE
         AP9wugC+rwfUK9kZEom5l0QzCoeqLnZiPAxVCaYP+wWzroS7MDbubagbcXCU6ezWjzbG
         JBVw==
X-Gm-Message-State: AOJu0YyYwIUfs8EDnmjh7rSmB6Xd6R4WjzW6BhwtTGpncwoMKIMwpcOY
	RW7wh6LeWM3TQRDkeA4LMKCJsU2TtL/SkedZI21MQKjUEPiX7Ya/lC5nBG1DzU4CVwOk1pUkGAu
	Gcq2NeAj2L60PODZIXWt05A1lDlPLLP5ZfQ==
X-Gm-Gg: ASbGncs/bd8gs3YMvYhKBxnA2Eus0cqHI9op3NAr+1yaILOdJcIUS37agN7LhLGnjzy
	nSn2jy6SO7wuLHY9Effb8NXdILMpjOth+sfy3U44fJeh/EHvBVhqiO4em3lcBUBLZYzZr1Q8ypL
	qX+tdYEQtq1PglsHJTxQTy8T8rTbODpwLlu9qbpkxlN6Bmt+KSwrhuuOURpqZ21K+Qvki/XiM18
	E5ZXiudDCe01SoxofHSzqCIFJrCfDA2sK8OX0LtNCUBPny0w89isXekFQwX2vM4lo4jri7l
X-Google-Smtp-Source: AGHT+IGOTkMfrCjhY59GYvJSr+qUEayygc9FmIzAJ9AJlWn3klYPYIRJlxLOHEHl4t74a5UiNV0jCKvPwOe34iUG4tY=
X-Received: by 2002:a05:7022:68a5:b0:11b:9e5e:1a66 with SMTP id
 a92af1059eb24-11f2967d1abmr1391761c88.14.1765355720782; Wed, 10 Dec 2025
 00:35:20 -0800 (PST)
MIME-Version: 1.0
References: <88AE90DC-46C2-6F46-8E7C-9CFDB12E6218@hxcore.ol>
In-Reply-To: <88AE90DC-46C2-6F46-8E7C-9CFDB12E6218@hxcore.ol>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Wed, 10 Dec 2025 09:35:08 +0100
X-Gm-Features: AQt7F2oq8BKf-461mJbDjJ4GU5IKCYs3BRt4I2MTjxmwBVMBzwmCvka5aI_9daY
Message-ID: <CAApg2=RdnugMudu9pL_FepJtSTgFuFNGLX_asB3F4C7izFTLhw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security] Upcoming (?) breaking change in
 veritysetup format output
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000a3b742064594e8c4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 08:35:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2761

--000000000000a3b742064594e8c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 11:08=E2=80=AFPM Joschka Seydell via lists.yoctoproj=
ect.org
<joschka=3Dseydell.org@lists.yoctoproject.org> wrote:

> Hi there.
>
> When tinkering with latest greatest I observed that newer versions of
> cryptsetup/veritysetup have a slightly different output - units are now
> included. This however breaks the current assumptions in
> dm-verity-image.bbclass when creating the dm-verity.env file to deploy in
> the initramfs. Overall this leads to a kernel panic.
>
> I did not dig into this further yet, as I would like to have your opinion
> first. But here's the commit in cryptsetup that probably causes the
> trouble:
> https://gitlab.com/cryptsetup/cryptsetup/-/commit/f8788f347ebfa5ba5df860b=
2c599e66f312a0693
>
>
Thank you for heads-up!

Kind regards,
Marta

--000000000000a3b742064594e8c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 2, =
2025 at 11:08=E2=80=AFPM Joschka Seydell via <a href=3D"http://lists.yoctop=
roject.org">lists.yoctoproject.org</a> &lt;joschka=3D<a href=3D"mailto:seyd=
ell.org@lists.yoctoproject.org">seydell.org@lists.yoctoproject.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div=
 dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-system,=
Roboto,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(33,33,33)">Hi th=
ere.</div><div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,=
-apple-system,Roboto,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(33=
,33,33)"><br></div><div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFon=
tService,-apple-system,Roboto,Arial,Helvetica,sans-serif;font-size:12pt;col=
or:rgb(33,33,33)">When tinkering with latest greatest I observed that newer=
 versions of cryptsetup/veritysetup have a slightly different output - unit=
s are now included. This however breaks the current assumptions in dm-verit=
y-image.bbclass when creating the dm-verity.env file to deploy in the initr=
amfs. Overall this leads to a kernel panic.</div><div dir=3D"auto" style=3D=
"font-family:Aptos,Aptos_MSFontService,-apple-system,Roboto,Arial,Helvetica=
,sans-serif;font-size:12pt;color:rgb(33,33,33)"><br></div><div dir=3D"auto"=
 style=3D"font-family:Aptos,Aptos_MSFontService,-apple-system,Roboto,Arial,=
Helvetica,sans-serif;font-size:12pt"><span style=3D"color:rgb(33,33,33)">I =
did not dig into this further yet, as I would like to have your opinion fir=
st. But here&#39;s the commit in cryptsetup that probably causes the troubl=
e: </span><span style=3D"color:rgb(0,0,0)"><a href=3D"https://gitlab.com/cr=
yptsetup/cryptsetup/-/commit/f8788f347ebfa5ba5df860b2c599e66f312a0693" rel=
=3D"noreferrer noopener" target=3D"_blank">https://gitlab.com/cryptsetup/cr=
yptsetup/-/commit/f8788f347ebfa5ba5df860b2c599e66f312a0693</a></span></div>=
<br></div></blockquote><div><br></div><div>Thank you for heads-up!</div><di=
v><br></div><div>Kind regards,</div><div>Marta <br></div></div></div>

--000000000000a3b742064594e8c4--

