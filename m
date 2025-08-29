Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32ADCA0FF9
	for <webhook@archiver.kernel.org>; Fri, 29 Aug 2025 09:55:20 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.9872.1756461308531272921
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 Aug 2025 02:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MPVlHONb;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6ad5146eso155666e87.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 29 Aug 2025 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461306; x=1757066106; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAhBEWE2fOqDgQt666ZljrGGqRmH+3wmv/+HKd3xOYk=;
        b=MPVlHONbACX2s2xqQeUBhI1GMIjykQLFODT6uRR4Re8IaoNjh830ovOYFpcc0h3CU2
         bZE2J/5qLqWJzhe/fnC7YXq+3sHwmj0i6rf15TzI070nSjpgPAfztvwYU7nJR+XuDiaP
         FlIE/6fCHbso7XAOh1O7UX8qlf4fbOUq06L+FKicF+H3r8k9LNUPVrq/GS/jXZFT5RXA
         VDWypjYCYVWNm3OgE8FTZHExWPzglYHrh9pBw6Mj8EK7q7CGk2u9941QZMGkOVz0JtGa
         nuKe6R4et/z93Sy/93M4NNgRRO5sJdFwNF0qchWbepzhf51lb4SHzfRJtdM927SGAsMT
         rMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461306; x=1757066106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAhBEWE2fOqDgQt666ZljrGGqRmH+3wmv/+HKd3xOYk=;
        b=w8g+tWBoON87Jy0BHgURmsLztN8exGkaf9hBebvT4d6SqXQhtBknaKJfaXV6a3+4PS
         wwASDG0jRGOhLBD/EtlFNIMrCArHVN8xDSz2OJL4We4gF8Uub7cZiHYpIYk0MBXKN0IB
         IaKjXO/HYsbbuFr0vVRfUhE9dFsQk6FNoa5G92VH/GRr97qHNgH54Klijx2HHplFfsu2
         abiCIFzsupO+VJ8sCxcA0B5GBpiiAA76pOb26oshf2aCkdBI8D30rMIylm78b75ddnbP
         ot6Q2ocj1VDPzq/LID5p7wzglg+oKdUr5S1CeZccytZoihDs0zGYZtrbVZiIV+0IzI8C
         3jUQ==
X-Gm-Message-State: AOJu0YyKuReJ/efy2w1STrBmh1yYVEE1+P/EfFV6O07kREgKkzWgHah4
	l3gvypSVaazhT6JSCoJuJilPTjmkDe6ITXnmioQGlN6u+9WD4nRlEbyGI5XrbLQSrNzDuOVuzAk
	Zuia/ZS+r6Ei9bR1tu+v5xOtBLTeK6aqN3GBNdUs=
X-Gm-Gg: ASbGncvW+WLMNab6U1SwY7vNOgIyu1c+ugqENo0UXdGcasZx4Wc3Vg3CEbQy9pmkN48
	h1PjpGutYY0a/F3jaHu8rwULkhzqyWNdZO+cL7EdNOUb05uDOUBI2ujdnyTEzSJ2QcH6QLoIrG4
	Ytmeg8m2mQ20oEeLUpw4CpTzvNtx6Q5CJvbcpaXsDV4mSaWF+uDB//6uzB1zrOWc8kaPAnjCxAV
	9zNjpTQ
X-Google-Smtp-Source: AGHT+IGraBRrHmC+w8e/52Dt705kRrZjWnCPWO2/4ihImdISj/SdwR3EyBbeXWS7MzHF6O6Gtt30Ou7OiFTeQeK2VtU=
X-Received: by 2002:a05:6512:1090:b0:55f:4714:efe with SMTP id
 2adb3069b0e04-55f47141690mr5660633e87.23.1756461305335; Fri, 29 Aug 2025
 02:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 29 Aug 2025 11:54:52 +0200
X-Gm-Features: Ac12FXwq36p5pECZ90yol52iO8s1ZdSI8v9S-InhG9Xj4RBms19Mf7gGdFdW0zo
Message-ID: <CANx9H-Dy+hRXngzUdRew-v4xR8dsg-4_r=j=aJZrtKXwe2yPSQ@mail.gmail.com>
Subject: Re: [yocto-patches] Insights from Integrating mixins rust into kirkstone-based
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>, 
	"MacLeod, Randy" <Randy.MacLeod@windriver.com>
Content-Type: multipart/alternative; boundary="0000000000002a9612063d7e04e7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 29 Aug 2025 09:55:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2091

--0000000000002a9612063d7e04e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:29=E2=80=AFPM Soumya via lists.yoctoproject.org
<soumya.sambu=3Dwindriver.com@lists.yoctoproject.org> wrote:

> Hi Scott and meta-lts-mixins/kirkstone/rust folks,
>
> We (Randy and I and others at Wind River) wanted to share our experience
> with integrating 'meta-lts-mixins/kirkstone/rust' into our kirkstone-base=
d
> setup to enable support for the latest Chromium version.
>
> While the initial integration showed promise, we encountered several buil=
d
> issues that led us to reconsider. Most of the challenges stemmed from the
> major upgrade of python3-setuptools and the Rust toolchain, which
> introduced incompatibilities with several packages in our environment.
>
> Here=E2=80=99s a summary of the key issues we faced:
>
> *Setuptools-related failures:*
> - python3-strict-rfc3339 0.7-r0 =E2=80=93 do_compile failure: ERROR: pyth=
on3
> setup.py bdist_wheel' execution failed
> - systemtap =E2=80=93 do_configure failure due to autoconf-related QA err=
ors
> - python3-grpcio =E2=80=93 do_compile failure: distutils.errors.CompileEr=
ror
> - python3-awscrt =E2=80=93 do_compile failure: unsafe include path
> /usr/include/python3.10 for cross-compilation
> - python3-azure-iot-device =E2=80=93 do_compile failure: invalid specifie=
r '!=3D3.3*'
>

You would likely also need a meta-lts-mixins layer for python. No one ever
stepped up to do this, but you can see an implementation at
https://github.com/warthog9/meta-mixin-python


> *Rust-related failures:*
> - Internal BSP: libstd-rs do_compile failure =E2=80=93 Error loading targ=
et
> specification: 'softfp' is not a valid value for llvm-floatabi
> - mozjs78 and mozjs-91 =E2=80=93 do_compile failures
>
> Thanks to a variety of commits and your work, these issues were resolved.
> However, we remain concerned about potential customer regressions from
> introducing higher version packages into our kirkstone-based setup. So,
> we=E2=80=99ve decided to hold off on using 'meta-lts-mixins/kirkstone/rus=
t' for now
> to avoid impacting our customers.
>
> We appreciate the effort that=E2=80=99s gone into maintaining the mixins =
and hope
> this feedback helps others in the community. We=E2=80=99ll continue to mo=
nitor
> developments and may make use of this work in customer-specific projects.
>
> Thanks again for your work and support.
>
> Regards,
> Soumya
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2088)
> <https://lists.yoctoproject.org/g/yocto-patches/message/2088> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20%5Byocto-patches%5D=
%20Insights%20from%20Integrating%20mixins%20rust%20into%20kirkstone-based>
> | Reply to Sender
> <soumya.sambu@windriver.com?subject=3DPrivate:%20Re:%20%5Byocto-patches%5=
D%20Insights%20from%20Integrating%20mixins%20rust%20into%20kirkstone-based>
> | Mute This Topic <https://lists.yoctoproject.org/mt/114935651/924729> | =
New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/924729> | Contact
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/102=
3951714/xyzzy>
> [ticotimo@gmail.com]
> _._,_._,_
>
>

--0000000000002a9612063d7e04e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 28, 2025 at 4:29=E2=80=AFPM=
 Soumya via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.or=
g</a> &lt;soumya.sambu=3D<a href=3D"mailto:windriver.com@lists.yoctoproject=
.org">windriver.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,2=
04,204)">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Hi Scott and meta-lts-mixins/kirkstone/rust folks,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
We (Randy and I and others at Wind River) wanted to share our experience wi=
th integrating &#39;meta-lts-mixins/kirkstone/rust&#39; into our kirkstone-=
based setup to enable support for the latest Chromium version.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
While the initial integration showed promise, we encountered several build =
issues that led us to reconsider. Most of the challenges stemmed from the m=
ajor upgrade of python3-setuptools and the Rust toolchain, which introduced=
 incompatibilities with several
 packages in our environment.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Here=E2=80=99s a summary of the key issues we faced:</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<b style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibr=
i,Helvetica,sans-serif">Setuptools-related failures:</b></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- python3-strict-rfc3339 0.7-r0 =E2=80=93 do_compile failure: ERROR: python=
3 setup.py bdist_wheel&#39; execution failed</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- systemtap =E2=80=93 do_configure failure due to autoconf-related QA error=
s</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- python3-grpcio =E2=80=93 do_compile failure: distutils.errors.CompileErro=
r</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- python3-awscrt =E2=80=93 do_compile failure: unsafe include path /usr/inc=
lude/python3.10 for cross-compilation</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- python3-azure-iot-device =E2=80=93 do_compile failure: invalid specifier =
&#39;!=3D3.3*&#39;</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
</div></div></blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">You =
would likely also need a meta-lts-mixins layer for python. No one ever step=
ped up to do this, but you can see an implementation at=C2=A0<div><a href=
=3D"https://github.com/warthog9/meta-mixin-python">https://github.com/warth=
og9/meta-mixin-python</a></div><div dir=3D"auto"><br></div></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204=
,204)"><div dir=3D"ltr"><div style=3D"font-family:Aptos,Aptos_EmbeddedFont,=
Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0=
,0,0)"><br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<b style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibr=
i,Helvetica,sans-serif">Rust-related failures:</b></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- Internal BSP: libstd-rs do_compile failure =E2=80=93 Error loading target=
 specification: &#39;softfp&#39; is not a valid value for llvm-floatabi</di=
v>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
- mozjs78 and mozjs-91 =E2=80=93 do_compile failures</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Thanks to a variety of commits and your work, these issues were resolved. H=
owever, we remain concerned about potential customer regressions from intro=
ducing higher version packages into our kirkstone-based setup. So, we=E2=80=
=99ve decided to hold off on using &#39;meta-lts-mixins/kirkstone/rust&#39;
 for now to avoid impacting our customers.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
We appreciate the effort that=E2=80=99s gone into maintaining the mixins an=
d hope this feedback helps others in the community. We=E2=80=99ll continue =
to monitor developments and may make use of this work in customer-specific =
projects.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Thanks again for your work and support.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Regards, =C2=A0</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Soumya</div>
</div>



<div width=3D"1" style=3D"clear:both;color:white">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/2088" tar=
get=3D"_blank">View/Reply Online (#2088)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20%5=
Byocto-patches%5D%20Insights%20from%20Integrating%20mixins%20rust%20into%20=
kirkstone-based" target=3D"_blank">Reply to Group</a>
 =20
    | <a href=3D"mailto:soumya.sambu@windriver.com?subject=3DPrivate:%20Re:=
%20%5Byocto-patches%5D%20Insights%20from%20Integrating%20mixins%20rust%20in=
to%20kirkstone-based" target=3D"_blank">Reply to Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/114935651/924729" target=3D"=
_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/924729" t=
arget=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/92=
4729/1023951714/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo@gmail.co=
m</a>]<br>
</p><div width=3D"1" style=3D"clear:both;color:white">_._,_._,_</div>

<p></p><p></p></blockquote></div></div>

--0000000000002a9612063d7e04e7--

