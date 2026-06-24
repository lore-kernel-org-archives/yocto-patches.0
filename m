Return-Path: <adityags2004@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23489CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 14:36:29 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8780.1782311784238199779
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 07:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dDfHGtWW;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: adityags2004@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso2155217e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 07:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311782; cv=none;
        d=google.com; s=arc-20260327;
        b=l80qCIFBygUhzPqn+e6AleWOOC3crwWwbI3a0sRJnKU79fe07BPk/64oUdx5KVcm1q
         WYxKO2ZH+sqwQDh8SAxGrakwCb4SHQlB8ruwuD+B80pODG8Mo8PpIpoqx6/e1irEMmMZ
         eIyPNkdnBw1mbSE7xR2F+ygRz7pDUg3lKrGH6wQHSP35H9gYoDP1sKWuelUaKzlBB159
         yXsiwqeeFCpUJfxveF2/mB0GjfhU5hU+ept5yh8YU8KC6UMHHQvIAJxetsDOieg7eUCh
         Wbo2JMD+DV8JDbx0jqo4MFcMOKR6PDYWAQ+FZnQLVFOTvnzMSoQDmMlHk4dNwNEC3RkO
         VrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uTWkHA9OX+MFPVaKHm4epVRckD0PIl/mGFukWAXRfe0=;
        fh=DzQvGcrSJfCJ7Q1SRroko91xyvYTcgsW7QO7MW39vuA=;
        b=nYQSx6QTcrsGa96DxNJfEhICC2rK+a1nc1vtqwnPoyUs/g7fNIO5aH4bu93FUev63H
         btqMkORvggVWaG3QlGpDvxZYmtXCBnP1+Wln+cmVSFIOnnvuX6nazr8u+DB/Vrwnzmd8
         1jQg1h7ltDDrG7r/A5DnL/q+LphAOZok2lJM88psJx6kTU3CRtTMFniXYWPg1aGvkgzi
         eD3BiDAcJnwcu7E3lBqTvyGl1AxgIx25Cl5NMU0WbcSWdSlWGa+YQi9j5gYy1IZd5Tee
         SLqRInbNZSKdtbfrd28G601Jz7G24t66O746ZXa1g4y8UEn9IZgJxBZ0T9HeQmkIHxaJ
         nnzg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311782; x=1782916582; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTWkHA9OX+MFPVaKHm4epVRckD0PIl/mGFukWAXRfe0=;
        b=dDfHGtWWYRXouZpRb00wkEwHO2cN6ryd7qfdUcT4r8PvaNE3a5jgQuTZKlOyyutzJ6
         4eROdlDY+Clrv8WDUxNyGK8vV2/WEhsFM3iEwMlhhcnXhW0tfO5PqDjzMS9UMjIWq0/M
         DGjbSKFLTO+KaS1cZMq8DAmEOj9IDEcWalyIY4MCvARMfJL+Myj9pYZkG0r68Uc0dBR1
         v0noYmlsb7npYuNS38MG4CeC9VEQN0sCzPAl0H3MIF5tSLWDT2Pw41vJYSeHDfJAEt91
         NLKJh6/WEWGmDFjqh0uDRIRqxLlU9hyGq9tj0xEgT7RvDTql5F5eL41K8GzLdCQAIyi1
         HnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311782; x=1782916582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTWkHA9OX+MFPVaKHm4epVRckD0PIl/mGFukWAXRfe0=;
        b=Ogv5PIenizSMz5W0Cp+vPl2c34A3yOQKgnJ8Eum+B4uPwTeZaUZBiUNFFoOHS010eO
         W1bHutIgKH4xR7Cl8YG3XHXglqMNHpTsN91xh4qbhZ9ffemM7C+W7s+L9218iFxftEhS
         Lqlcg/RqIL6C8PBDBkeJ4H0U1upLFclY6f3r9xDuEVyG3fL37CHH/vlOEvdxvNcM+kz1
         1j5IX6rPxc0IlYGQRE134vQyZgjjmprj/CdC/EUATH32svcgZmoC3mX9jtEZLTzutt2q
         1cm0Wd4curGel5t8k2mmpgkJyUV8X93mopOxlmLIkAfUHq0ojl0ZOxsK8JQh7WlsSa3S
         S+4Q==
X-Gm-Message-State: AOJu0YwZssD+mvPOJ4LLwldSLqtybzHrLM97zABI7OEr1Wy5wcnwOMRV
	61jabmyu7WMslHzzYijUXKOIbGuXMCErdiRJKIMNUlH3X+llEp+VVOkuLC0cYqbD3oauadOhEeu
	7aNiYoGegBGX1uMnmomruL8AcDQMTrTY=
X-Gm-Gg: AfdE7cnRV0CiEUmMdUwgstoLjJHCQ2jRYCbVtSPQ95MUJI7GOcxYqAhe7ZH1GZ5cn46
	s0Abvk4fUKh2+x5V6L4cfSD+PEaQyJh0i86tTU9fromiMjUQS4cBxP9R9ZmyEN0WISK7bL7aEBf
	pY+DsAOnMgaoFKveyFCsQDPseeADfI+d46hEG1lpyU6q/08oQWFBX46LcGtfgGIXbnRTimGAtfY
	QJITkiIkUfp2IcTdTvsNzDe7sxRgUkwn0ehnMzcXJESHX1H3+6r/FOasGJdFJ2uKhIN3EIZZOyd
	KnoGKrwqiEWGhc7b9aD+XdYOJc5HFtKTqUTNdXnlP7qsiMrJm5DVr+t90qn2+g==
X-Received: by 2002:a05:6512:12c8:b0:5aa:9360:307e with SMTP id
 2adb3069b0e04-5ad695b5737mr2635867e87.12.1782311780752; Wed, 24 Jun 2026
 07:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260624062620.753-1-adityags2004@gmail.com> <CANNYZj_91TYttV2Y+yMcC7F0DGcpkdMOt9yU+8_p7XYnWNmcxA@mail.gmail.com>
In-Reply-To: <CANNYZj_91TYttV2Y+yMcC7F0DGcpkdMOt9yU+8_p7XYnWNmcxA@mail.gmail.com>
From: "Aditya G.S" <adityags2004@gmail.com>
Date: Wed, 24 Jun 2026 20:06:06 +0530
X-Gm-Features: AVVi8CcPYGLMa8vYduyD_XWtxjnUoO9Lns7W-0u5xyDej1WxTaPQYnJbvDTB2yM
Message-ID: <CAHaUZZDYrqCSfFH4ujFVPkTL3J2XaMS+QLRA=LT7unztWDE0rw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-collab][kirkstone][PATCH] openssl:
 upgrade 3.0.20 -> 3.0.21
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, 
	Aditya GS <aditya.gs@bmwtechworks.in>
Content-Type: multipart/alternative; boundary="000000000000921fb2065500cc22"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 14:36:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4297

--000000000000921fb2065500cc22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for pointing that out.

I'll remove the unused patch files and send a v2 of the patch shortly.

Regards,
Aditya GS

On Wed, Jun 24, 2026, 7:33=E2=80=AFPM Alexander Kanavin <alex.kanavin@gmail=
.com>
wrote:

> On Wed, 24 Jun 2026 at 11:06, Aditya GS via lists.yoctoproject.org
> <adityags2004=3Dgmail.com@lists.yoctoproject.org> wrote:
> > -           file://CVE-2024-41996.patch \
> > -           file://CVE-2023-50781-1.patch \
> > -           file://CVE-2023-50781-2.patch \
> > -           file://CVE-2023-50781-3.patch \
> > -           file://CVE-2023-50781-4.patch \
> > -           file://CVE-2023-50781-5.patch \
> > -           file://CVE-2023-50781-6.patch \
>
> You also need to remove actual patch files.
>
> Alex
>

--000000000000921fb2065500cc22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Alex,<div dir=3D"auto"><br></div><div dir=3D"auto">Tha=
nks for pointing that out.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">I&#39;ll remove the unused patch files and send a v2 of the patch shortl=
y.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div di=
r=3D"auto">Aditya GS</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 24, 2026, 7:33=
=E2=80=AFPM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com"=
>alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">On Wed, 24 Jun 2026 at 11:06, Aditya GS via <a href=3D"http://lists.yoc=
toproject.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lists.yoctop=
roject.org</a><br>
&lt;adityags2004=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org" targ=
et=3D"_blank" rel=3D"noreferrer">gmail.com@lists.yoctoproject.org</a>&gt; w=
rote:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2024-41996.patch =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-1.patc=
h \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-2.patc=
h \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-3.patc=
h \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-4.patc=
h \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-5.patc=
h \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://CVE-2023-50781-6.patc=
h \<br>
<br>
You also need to remove actual patch files.<br>
<br>
Alex<br>
</blockquote></div>

--000000000000921fb2065500cc22--

