Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761FCA0EFD
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 12:00:11 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
 by mx.groups.io with SMTP id smtpd.web10.17979.1755691209757508215
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 05:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lY4TWW6j;
 spf=pass (domain: gmail.com, ip: 209.85.222.48, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018e97232so1699830241.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755691208; x=1756296008; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9irdchOeq3ztThfFOVeJi0dAnsmksKtlBAdIOFTlC8=;
        b=lY4TWW6jMfTpFSq1LMejpogJr7YFUTN8ypJWfDdqpLXiFX0dOxmLrANyS2cel4jYry
         1EACCSO3JI88kEU2nE08mbv0l/I8CN184YMa113XFGcxwrxWu1J7pKw3ToZI/1mulnn8
         IcV/3XjY8xcg+gFPDcePUQuFua2qDhCKsePfb6qIzZx8cnNdOCGIusRAU4jZpj/GpQ7Q
         TvoQTT0fG5dmhkPuBCXtpV4+FnLigqZut0giQGFgJItagzG+puovt7Hd6X58tABaHkjz
         vOaw3DL4MajpvhmAIHroGNR7HmwB0RZYdnacnZJ9F45gqHpSeUYMZLmdAuS8mfVeZFY/
         3agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755691208; x=1756296008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9irdchOeq3ztThfFOVeJi0dAnsmksKtlBAdIOFTlC8=;
        b=LDU151VVEXv+QRPWzmwAseRI09D+otTtqWxbjjMtf4nFithEVtpkaIzXBxwJXRHdHs
         E5QicvCavN4MKK6InozUlnRobIvKsAJyLxyZRZQO1n2Nm327iuIjuduDOnk3d9iAVb+x
         X70YmYBCrBFAvH0uiQ5qvqq7M6aPY3wWRKS5clgPBlPlk7IeTy/MPivoBoez94P6KUqd
         6mLA7KiJTEd6FRnQE6pJsyJIySBsGZ+DV9u1eEi0TIrSRaPA0vkX8py1q4qCMV2TUA/T
         F4IdH+CdugDHXF+PIH9WXFPquhGXDFq+Ill5REK0NkbJvZeeU0ICyYc2vpViYB4Y5INq
         93vg==
X-Gm-Message-State: AOJu0YxvrwG0Qs0sGZq/pmQlvGV3vWDjuoZ5gLlK0MmTCqU2r00PrRp1
	0/6UDLwveeunpuXvZsVexeYMmCwKkK5Kz/qua/5nRw0zI7oW/t7VysjPy3fHO2Kbwmn4/R4pTQ+
	xUiKA/bVj4uYjw3i1AhUOm84YAEAtbnaFBM11cX8=
X-Gm-Gg: ASbGncs8K2Brp79rk+xJlKCUIRyGWCjxlyo1qlv3+KEf7MUzGHZfIdMryzZvPPkXN33
	AL8ghkYVWVlvVtHMxJ5dkvUsCm2sl7sYhfoRO/giV/IuzaWsIKk/DjAYgS0r5KMP08uyBZlYeaO
	T9q40AfVRVaKSu96W7frcxKrzYe003zWUaX0un4d69jmuJgCHDeZVac3PtZ4QlZtIQZ7VzcmV1q
	Ux+Lq+O
X-Google-Smtp-Source: AGHT+IGv3KS48f2FeLSI3+hwrc2oGtOvVYrXwgYtm9rD9ixrKj0ckugB6QO7ePLZ5PNAnkAtgaH5B/wsHvc7zfy2QOc=
X-Received: by 2002:a05:6102:1611:b0:4fd:b392:c500 with SMTP id
 ada2fe7eead31-51a517c488amr583003137.24.1755691208350; Wed, 20 Aug 2025
 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250818225046.55311-1-peter.marko@siemens.com>
 <CANPvuRkYWZZ3YnegmTxCYLM65G+wvR7UvsRE0DeZ2enWzXSwcg@mail.gmail.com>
 <AS1PR10MB56973181DD547A7B6EB042B9FD33A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <185D77A108AB874C.23467@lists.yoctoproject.org>
In-Reply-To: <185D77A108AB874C.23467@lists.yoctoproject.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 20 Aug 2025 12:59:56 +0100
X-Gm-Features: Ac12FXx35m6TAQrIBNkesKmOS_31w6lEJG2xEPPGpGev1Yx4tG81IdM_VdYJws8
Message-ID: <CANPvuRmiX8b9hMWcf5w_nU2HdXj3ugJdHJYj178TDxzjHVoJaA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH]
 conf/layer: switch to golang 1.25
To: yocto-patches@lists.yoctoproject.org
Cc: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000cf250c063ccab651"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 12:00:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2068

--000000000000cf250c063ccab651
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this one shouldn't have gone, I'll do a build to check
https://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkstone/go&id=3D=
f3bb48cea8c9794ff9e4d9eb13309c4651a7a226

Jose

Jose Quaresma via lists.yoctoproject.org <quaresma.jose=3D
gmail.com@lists.yoctoproject.org> escreveu (quarta, 20/08/2025 =C3=A0(s) 12=
:56):

> It will be good to pick it all since it is a good example to test and it
> should be aligned with the rest of the pieces.
> I updated the go-helloworld with what was pending from oe-core.
>
> Thanks for the reminder.
>
> Jose
>
> Peter Marko via lists.yoctoproject.org <peter.marko=3D
> siemens.com@lists.yoctoproject.org> escreveu (quarta, 20/08/2025 =C3=A0(s=
)
> 12:41):
>
>> Thanks Jose,
>>
>> I=E2=80=99m wondering if we should also pick all commits for go-hellowor=
ld recipe
>> or if it is irrelevant.
>>
>>
>>
>> Peter
>>
>>
>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2067)
> <https://lists.yoctoproject.org/g/yocto-patches/message/2067> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPATCH%5D%20conf%2Fla=
yer%3A%20switch%20to%20golang%201.25>
> | Reply to Sender
> <quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patc=
hes%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPATCH%5D%20conf%2Flaye=
r%3A%20switch%20to%20golang%201.25>
> | Mute This Topic <https://lists.yoctoproject.org/mt/114772931/5052612> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/15=
04338242/xyzzy>
> [quaresma.jose@gmail.com]
> _._,_._,_
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000cf250c063ccab651
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think this one shouldn&#39;t have gone, I&#39;ll do a bu=
ild to check<br><a href=3D"https://git.yoctoproject.org/meta-lts-mixins/com=
mit/?h=3Dkirkstone/go&amp;id=3Df3bb48cea8c9794ff9e4d9eb13309c4651a7a226">ht=
tps://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkstone/go&amp;id=
=3Df3bb48cea8c9794ff9e4d9eb13309c4651a7a226</a><br><br>Jose</div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">Jose Quaresma via <a href=3D"http://lists.yoctoproject.org">lists.yoc=
toproject.org</a> &lt;quaresma.jose=3D<a href=3D"mailto:gmail.com@lists.yoc=
toproject.org">gmail.com@lists.yoctoproject.org</a>&gt; escreveu (quarta, 2=
0/08/2025 =C3=A0(s) 12:56):<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div>It will be good to pick=C2=A0it all=C2=A0=
since it is a good example to test=C2=A0and it should be aligned with the r=
est of the pieces.<br>I updated the=C2=A0<span style=3D"font-family:Arial,s=
ans-serif;font-size:13.3333px">go-helloworld</span>=C2=A0with what was pend=
ing from oe-core.</div><div><br></div><div>Thanks=C2=A0for the reminder.<br=
><br>Jose</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">Peter Marko via <a href=3D"http://lists.yoctoproject.org" target=
=3D"_blank">lists.yoctoproject.org</a> &lt;peter.marko=3D<a href=3D"mailto:=
siemens.com@lists.yoctoproject.org" target=3D"_blank">siemens.com@lists.yoc=
toproject.org</a>&gt; escreveu (quarta, 20/08/2025 =C3=A0(s) 12:41):<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div>





<div lang=3D"EN-US">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Thanks Jose,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">I=E2=80=99m wondering if we should also pick all commits for go-hel=
loworld recipe or if it is irrelevant.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Peter<u></u><u></u></span></p>
<p class=3D"MsoNormal"><br></p></div></div></div></blockquote></div></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/2067" tar=
get=3D"_blank">View/Reply Online (#2067)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPAT=
CH%5D%20conf%2Flayer%3A%20switch%20to%20golang%201.25" target=3D"_blank">Re=
ply to Group</a>
 =20
    | <a href=3D"mailto:quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20=
Re%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BP=
ATCH%5D%20conf%2Flayer%3A%20switch%20to%20golang%201.25" target=3D"_blank">=
Reply to Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/114772931/5052612" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/50=
52612/1504338242/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank">quaresma.jos=
e@gmail.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div><div><br clear=3D"all"></div><div><br></di=
v><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Qua=
resma</div></div></div>

--000000000000cf250c063ccab651--

