Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E5CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:39:24 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7974.1762933158863965703
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 23:39:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eicZbJaL;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: samuli.piippo@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72bf7e703fso95425866b.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762933157; x=1763537957; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1YG717u90cuyWrgEuqLzmz3djaGjLsbX7A9Z5s+mHl4=;
        b=eicZbJaLYgGy4XV+WTcS5mRjNRVnQ8JWW+GRXelf5EgrojL24fduh8x3L5gtRzaONP
         1UoFRa8q7IDi6uZtWppEU2YZyCW8lyUnCYk1+OGIJoQP9jCivzXipPOAJZXMoFoMMA8d
         hRovD3DdMnNUr30Brfhu0v7ohkDdfQTSSbNSwb8x44j3fA9Sr3IgdTYxFB+ws/+B5rwk
         n+t5teiZNHQrBEjOeXA6X8unhGIpKDV9FneJeKcKFSPHwg01B0tCk0u2U51bQt8lLN3+
         8HPBzCbRFm4YamSu+ultHK5yLTDvzYdNVL27mg4b+QW7CgR53lFMD9W3+emhxvny+lEP
         v/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933157; x=1763537957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YG717u90cuyWrgEuqLzmz3djaGjLsbX7A9Z5s+mHl4=;
        b=NFHt97I4zm9YcSNXIIn4dcRn/eEzw4HHBuRfRnQN10A7vxiDTMZLhggVozBFtsahXH
         Ss28SNCKs92IhER4OTW6fYharFQMWwc1EhhPOxwY/fbNk/tE/cAbA3aoGRCapMFe8sNM
         3xxpuK9yqtCuWGj8w04rTlnPKsqBcbQ7O4wwl5nGOQhlFgf1c+3Y/LLNmQWz+rEJupJZ
         oYZAQ8aZ1ocTavG0061MbZwc2oMKmNtpcF0ifKQr2KGhGXN7swh1zGp6t1j1RtAanv+2
         iPxwSVUqUnNDy1FeX9B6NG1oXYF45Ac3r7p/yyE/lt/cXw33VtrY/AhsqDGfZ3ZfUaV6
         m+qQ==
X-Gm-Message-State: AOJu0YypxuQvnZc1vHwSqR47OpJeixb2pAAMOquVr7D4DJ8hIbkh6fzY
	NqqDxX0p9GJRXaW5vTxWlf3d3zvTNc8xzSCb13Oe1XPoYFfRW+PfuhGyRqxU0k/EstZZbVqobws
	h0NlR8HX1ifvrE/T0ZDAJ7YEN/bzkDVVJij1t
X-Gm-Gg: ASbGnctpJK9E4jbOwY3/Pju4bjDr5Ig2A7uvoma1xWTbzUOwBq9zWJ9pwJW6s8OFdJp
	JlJVxQk7P6JldQfROJxo091SBY2Peyg4zNaXC0ZYeJioZbhWhyOZUj13MuP0Q0HsnUzYFpKPd/o
	TLyRu0KfXbDQyWisg6Oxo1JfRwNDpr8XJdBo0XqjEZALfIqoxXOrIss06gIlF2fmxUXqPOuoDw7
	vM4AmrCjRM5J5Ur3g97LKtoNIq1iEJMp+PE4Vr1YjFxN837bzFm62L5Clw=
X-Google-Smtp-Source: AGHT+IHHNh7sZwRHMn5RFj80mF/KbeJqC9OEYW0LAZJclEl4YPiHh+mpfoJd0Yl25eA30e3ykI2GNLk4+OMF5rqzXTM=
X-Received: by 2002:a17:907:7285:b0:b72:dce0:d8e7 with SMTP id
 a640c23a62f3a-b7331973fc7mr186369166b.23.1762933156684; Tue, 11 Nov 2025
 23:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
 <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com> <87e0a761-ad36-44aa-b262-464aaeb97471@windriver.com>
In-Reply-To: <87e0a761-ad36-44aa-b262-464aaeb97471@windriver.com>
From: Samuli Piippo <samuli.piippo@gmail.com>
Date: Wed, 12 Nov 2025 09:39:05 +0200
X-Gm-Features: AWmQ_blaUi3nwSXtCtBALXhTsafs7gTm0IYDV0ZLSLbb4s9k_yQCzP3hokPWf7M
Message-ID: <CABXoSoW68LaasoHdKFcRV_XHBbixCakN+qq=O1hx7dFTf-pFdw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-mingw][PATCH V2] meta-mingw: support
 generating Windows SDK with no symlink
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <jpewhacker@gmail.com>, paul@pbarker.dev
Content-Type: multipart/alternative; boundary="000000000000912862064360dc2c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:39:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2490

--000000000000912862064360dc2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would it make more sense to leave out the INHERIT and WINSDK_NO_SYMLINK.
Instead, if you need this, you can inherit the class in your recipe or
local.conf

-samuli

On Wed, 12 Nov 2025 at 07:35, Chen Qi via lists.yoctoproject.org <Qi.Chen=
=3D
windriver.com@lists.yoctoproject.org> wrote:

> On 11/11/25 23:25, Joshua Watt wrote:
> > On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM <Qi.Chen@windriver.com> wrote:
> >> From: Chen Qi <Qi.Chen@windriver.com>
> >>
> >> On some Windows systems, symlinks are not allowed due to IT policy.
> >> We need to be able to generate Windows SDK without symlinks.
> >>
> >> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
> >> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
> >>
> >> By default, things work as before; when setting WINSDK_NO_SYMLINK
> >> to "1", SDK will replace all symlinks with the actual contents.
> >>
> >> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> >> ---
> >>   classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++=
++
> >>   conf/machine-sdk/include/mingw32-common.inc |  3 +++
> >>   2 files changed, 28 insertions(+)
> >>   create mode 100644 classes/mingw_sdk_handle_symlink.bbclass
> >>
> >> diff --git a/classes/mingw_sdk_handle_symlink.bbclass
> b/classes/mingw_sdk_handle_symlink.bbclass
> >> new file mode 100644
> >> index 0000000..2f6dbe6
> >> --- /dev/null
> >> +++ b/classes/mingw_sdk_handle_symlink.bbclass
> >> @@ -0,0 +1,25 @@
> >> +WINSDK_NO_SYMLINK ?=3D "0"
> >> +
> >> +archive_sdk:prepend:sdkmingw32 () {
> >> +       if [ "${WINSDK_NO_SYMLINK}" =3D "1" ]; then
> >> +               for parse_type in "file" "directory"; do
> >> +                       find "${SDK_OUTPUT}/${SDKPATH}" -type l -print=
0
> | while IFS=3D read -r -d '' symlink; do
> >> +                               target=3D$(readlink -f "$symlink" || e=
cho
> "NOTVALID")
> >> +                               if [ "$target" =3D "NOTVALID" ]; then
> >> +                                       continue
> >> +                               fi
> >> +                               if [ ! -e "$target" ]; then
> >> +                                       continue
> >> +                               elif [ -d "$target" ]; then
> >> +                                       if [ "$parse_type" =3D
> "directory" ]; then
> >> +                                               rm "$symlink" && cp -r
> "$target" "$symlink"
> >> +                                       fi
> >> +                               else
> >> +                                       if [ "$parse_type" =3D "file" =
];
> then
> >> +                                               rm "$symlink" && cp
> "$target" "$symlink"
> >> +                                       fi
> >> +                               fi
> >> +                       done
> >> +               done
> >> +       fi
> >> +}
> >> diff --git a/conf/machine-sdk/include/mingw32-common.inc
> b/conf/machine-sdk/include/mingw32-common.inc
> >> index 56b8052..bf3f14e 100644
> >> --- a/conf/machine-sdk/include/mingw32-common.inc
> >> +++ b/conf/machine-sdk/include/mingw32-common.inc
> >> @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D ""
> >>
> >>   # wine and wineserver are required to test MinGW SDKs
> >>   HOSTTOOLS_NONFATAL +=3D "wine wineserver"
> >> +
> >> +# handle symlinks
> >> +INHERIT +=3D "mingw_sdk_handle_symlink"
> > Does this need to be unconditional? I'd prefer something like
> > INHERIT:mingw32 instead if that works
>
> Hi Joshua,
>
> I just tried it out. Using INHERIT:append:sdkmingw32 works.
> We have to use :append instead of "+=3D" to avoid overriding settings.
>
> I'll send out V3.
>
> Regards,
> Qi
>
> >
> >> --
> >> 2.34.1
> >>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2488):
> https://lists.yoctoproject.org/g/yocto-patches/message/2488
> Mute This Topic: https://lists.yoctoproject.org/mt/116091557/3617605
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/14256716/3617605/551=
361261/xyzzy
> [samuli.piippo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000912862064360dc2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Would it make more sense to leave out the INHERIT and=
=C2=A0WINSDK_NO_SYMLINK.</div><div>Instead, if you need this, you can inher=
it the class in your recipe or local.conf</div><div><br></div><div>-samuli<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, 12 Nov 2025 at 07:35, Chen Qi via <a hre=
f=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;Qi.Chen=
=3D<a href=3D"mailto:windriver.com@lists.yoctoproject.org">windriver.com@li=
sts.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 11/11/25 23:25, Joshua Watt wrote:<br>
&gt; On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM &lt;<a href=3D"mailto:Qi.Chen@w=
indriver.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt; wrote:<br>
&gt;&gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=
=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; On some Windows systems, symlinks are not allowed due to IT policy=
.<br>
&gt;&gt; We need to be able to generate Windows SDK without symlinks.<br>
&gt;&gt;<br>
&gt;&gt; To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,<=
br>
&gt;&gt; mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.<=
br>
&gt;&gt;<br>
&gt;&gt; By default, things work as before; when setting WINSDK_NO_SYMLINK<=
br>
&gt;&gt; to &quot;1&quot;, SDK will replace all symlinks with the actual co=
ntents.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com=
" target=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0classes/mingw_sdk_handle_symlink.bbclass=C2=A0 =C2=A0 =
| 25 +++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0conf/machine-sdk/include/mingw32-common.inc |=C2=A0 3 =
+++<br>
&gt;&gt;=C2=A0 =C2=A02 files changed, 28 insertions(+)<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 classes/mingw_sdk_handle_symlink.bb=
class<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mi=
ngw_sdk_handle_symlink.bbclass<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..2f6dbe6<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/classes/mingw_sdk_handle_symlink.bbclass<br>
&gt;&gt; @@ -0,0 +1,25 @@<br>
&gt;&gt; +WINSDK_NO_SYMLINK ?=3D &quot;0&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +archive_sdk:prepend:sdkmingw32 () {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;${WINSDK_NO_SYMLINK}&quot; =
=3D &quot;1&quot; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for parse_=
type in &quot;file&quot; &quot;directory&quot;; do<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0find &quot;${SDK_OUTPUT}/${SDKPATH}&quot; -type l -prin=
t0 | while IFS=3D read -r -d &#39;&#39; symlink; do<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=3D$(readlink -f &quo=
t;$symlink&quot; || echo &quot;NOTVALID&quot;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$target&quot; =
=3D &quot;NOTVALID&quot; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ ! -e &quot;$target&quo=
t; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif [ -d &quot;$target&quo=
t; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ &quot;$parse_type&quot; =3D &quot;directory&quot; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm &quot;$symlink&quot; &amp;&amp; cp -r &qu=
ot;$target&quot; &quot;$symlink&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ &quot;$parse_type&quot; =3D &quot;file&quot; ]; then<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm &quot;$symlink&quot; &amp;&amp; cp &quot;=
$target&quot; &quot;$symlink&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0done<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;&gt; +}<br>
&gt;&gt; diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/ma=
chine-sdk/include/mingw32-common.inc<br>
&gt;&gt; index 56b8052..bf3f14e 100644<br>
&gt;&gt; --- a/conf/machine-sdk/include/mingw32-common.inc<br>
&gt;&gt; +++ b/conf/machine-sdk/include/mingw32-common.inc<br>
&gt;&gt; @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D &quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0# wine and wineserver are required to test MinGW SDKs<=
br>
&gt;&gt;=C2=A0 =C2=A0HOSTTOOLS_NONFATAL +=3D &quot;wine wineserver&quot;<br=
>
&gt;&gt; +<br>
&gt;&gt; +# handle symlinks<br>
&gt;&gt; +INHERIT +=3D &quot;mingw_sdk_handle_symlink&quot;<br>
&gt; Does this need to be unconditional? I&#39;d prefer something like<br>
&gt; INHERIT:mingw32 instead if that works<br>
<br>
Hi Joshua,<br>
<br>
I just tried it out. Using INHERIT:append:sdkmingw32 works.<br>
We have to use :append instead of &quot;+=3D&quot; to avoid overriding sett=
ings.<br>
<br>
I&#39;ll send out V3.<br>
<br>
Regards,<br>
Qi<br>
<br>
&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.34.1<br>
&gt;&gt;<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2488): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2488" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2488</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/116091557/361=
7605" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/116091557/3617605</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/14256716/3617605/551361261/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/14256716/3617605/5513612=
61/xyzzy</a> [<a href=3D"mailto:samuli.piippo@gmail.com" target=3D"_blank">=
samuli.piippo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000912862064360dc2c--

