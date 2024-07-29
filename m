Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97AEC3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 11:09:25 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.53583.1722251359743853865
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 04:09:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=MiTepeHP;
 spf=pass (domain: mvista.com, ip: 209.85.208.173, mailfrom: vanusuri@mvista.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so53060961fa.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1722251357; x=1722856157; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q67NIGkNtyAzeyDLEYKbwQ4vAAyZTpMqRu4wXale2HA=;
        b=MiTepeHPtM6FkhbYw4WlVYIRZ0pk6aJ3ZW9nMpGxAmxdh9tcXnZHFeAbBQs8Zw2/5Q
         XHvVWfTw0S3v5shAC9Jj891PyHbmIbSwYrlHnJE6GHLQSOVlscXbc+hcr0O6bEoffoId
         TAiSlYjEK2vu1D/h2TTdtF9ebUrl8MjNjSBes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251357; x=1722856157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q67NIGkNtyAzeyDLEYKbwQ4vAAyZTpMqRu4wXale2HA=;
        b=upAsFJGqMZwHXhCoSUfNU2H0whEQerzPoPgXeFGQoi69rmF5CeKqH40LOXCF4wF3hz
         YmXlZiQEXI8W5xZ3q3piRMFtJ9/xHstCUD7zhasBTJhI1bK3vcNJGFdFLqpePg3aeEKU
         uixdexhyCrpeMtfh6vvpFUUuA0Vh6c3mtnBBANx7b7ajjz8fBWtOdDhOKQyaOrvCmilO
         fbRAShjftjunEPiaKAKnhaRhHZFam0YzYKxyvY3udkOgeBZYtUFGT5X6fQ8e55lPwlac
         aQnjaOMD4wzMZfDfPeS+JyyVIOGjALrzRk4M0awAEE0OC++d7NPqPClf7SxbmO2+qmqY
         zXnA==
X-Gm-Message-State: AOJu0YwAxX/RW2kdGE91Q+oeeE1NKNgSrqoAgCkD3tu6evQobWBe1zhc
	u9FznvhZUQlKWVM1Be0QXYKG/ZImw0nMf+7LWaCiB+KpzNI0OYJvZ70PVM6xfCVBuG6yNcS2PDN
	LIWo3xoOUEkThiGP0zFmQwBLYYw6vj/3FaBKm97EUUywWb3CHdSA=
X-Google-Smtp-Source: AGHT+IEpSKoK23UxVmQGcLVXjzMAgDuD7tSeNR8xPv4DVtAnIrZxxmIZjtG0qL+VPXLFIH3gVzILBmnW1quUfJzs04I=
X-Received: by 2002:a2e:9799:0:b0:2ef:2c0f:283e with SMTP id
 38308e7fff4ca-2f12ecd2892mr45500691fa.12.1722251356671; Mon, 29 Jul 2024
 04:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240702064949.1631187-1-vanusuri@mvista.com> <17E33DB5416A0169.25516@lists.yoctoproject.org>
In-Reply-To: <17E33DB5416A0169.25516@lists.yoctoproject.org>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Mon, 29 Jul 2024 16:39:04 +0530
Message-ID: <CANQUz18y44MMsVo9+FCbO3M+Gu5u_WbUd=mY0bL-=VHMdJCMiA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][master][PATCH] tpm2-tools:
 Upgrade 5.5 -> 5.7
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000542fcf061e60e407"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 11:09:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/492

--000000000000542fcf061e60e407
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Gentle Reminder ...!!!

Any update on this?

Thanks & Regards,
Vijay

On Thu, Jul 18, 2024 at 12:52=E2=80=AFPM Vijay Anusuri via lists.yoctoproje=
ct.org
<vanusuri=3Dmvista.com@lists.yoctoproject.org> wrote:

> Hi Armin,
>
> Any update on this?
>
> Thanks & Regards,
> Vijay
>
> On Tue, Jul 2, 2024 at 12:20=E2=80=AFPM <vanusuri@mvista.com> wrote:
>
>> From: Vijay Anusuri <vanusuri@mvista.com>
>>
>> Include Security fixes:
>> Fixed CVE-2024-29038
>> Fixed CVE-2024-29039
>>
>> Changelog:
>> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
>> https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6
>>
>> Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
>> ---
>>  .../tpm2-tools/{tpm2-tools_5.5.bb =3D> tpm2-tools_5.7.bb}         | 2 +=
-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>  rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.5.bb =3D>
>> tpm2-tools_5.7.bb} (83%)
>>
>> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
>> b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
>> similarity index 83%
>> rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
>> rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
>> index 9bad758..bb422cf 100644
>> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
>> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
>> @@ -8,7 +8,7 @@ DEPENDS =3D "tpm2-tss openssl curl"
>>
>>  SRC_URI =3D "
>> https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-$=
{PV}.tar.gz
>> "
>>
>> -SRC_URI[sha256sum] =3D
>> "1fdb49c730537bfdaed088884881a61e3bfd121e957ec0bdceeec0261236c123"
>> +SRC_URI[sha256sum] =3D
>> "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
>>
>>  UPSTREAM_CHECK_URI =3D "https://github.com/tpm2-software/${BPN}/release=
s"
>>
>> --
>> 2.25.1
>>
>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#442)
> <https://lists.yoctoproject.org/g/yocto-patches/message/442> | Reply To
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-security%5D%5Bmaster%5D%5BPATCH%5D%20tpm2-tools%3A%20Upg=
rade%205.5%20-%3E%205.7>
> | Reply To Sender
> <vanusuri@mvista.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches%=
5D%20%5Bmeta-security%5D%5Bmaster%5D%5BPATCH%5D%20tpm2-tools%3A%20Upgrade%2=
05.5%20-%3E%205.7>
> | Mute This Topic <https://lists.yoctoproject.org/mt/106995604/7301997> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/7301997> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13419208/7301997/13=
35553898/xyzzy>
> [vanusuri@mvista.com]
> _._,_._,_
>
>

--000000000000542fcf061e60e407
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Team,</div><div><br></div><div>Gentle Reminder ...=
!!!<br><br></div><div>Any update on this?<br><br></div><div>Thanks &amp; Re=
gards,</div><div>Vijay<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 18, 2024 at 12:52=E2=80=AFPM Vi=
jay Anusuri via <a href=3D"http://lists.yoctoproject.org">lists.yoctoprojec=
t.org</a> &lt;vanusuri=3D<a href=3D"mailto:mvista.com@lists.yoctoproject.or=
g">mvista.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Armin,<br><br>=
</div><div>Any update on this?</div><div><br></div><div>Thanks &amp; Regard=
s,</div><div>Vijay<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 12:20=E2=80=AFPM &lt;<=
a href=3D"mailto:vanusuri@mvista.com" target=3D"_blank">vanusuri@mvista.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" target=3D"_b=
lank">vanusuri@mvista.com</a>&gt;<br>
<br>
Include Security fixes:<br>
Fixed CVE-2024-29038<br>
Fixed CVE-2024-29039<br>
<br>
Changelog:<br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.7</a><br>
<a href=3D"https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-to=
ols/releases/tag/5.6</a><br>
<br>
Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" tar=
get=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
---<br>
=C2=A0.../tpm2-tools/{<a href=3D"http://tpm2-tools_5.5.bb" rel=3D"noreferre=
r" target=3D"_blank">tpm2-tools_5.5.bb</a> =3D&gt; <a href=3D"http://tpm2-t=
ools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a>}=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename meta-tpm/recipes-tpm2/tpm2-tools/{<a href=3D"http://tpm2-tools=
_5.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a> =3D&gt;=
 <a href=3D"http://tpm2-tools_5.7.bb" rel=3D"noreferrer" target=3D"_blank">=
tpm2-tools_5.7.bb</a>} (83%)<br>
<br>
diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_=
5.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a> b/meta-t=
pm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
similarity index 83%<br>
rename from meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5=
.5.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a><br>
rename to meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7=
.bb" rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
index 9bad758..bb422cf 100644<br>
--- a/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.5.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.5.bb</a><br>
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/<a href=3D"http://tpm2-tools_5.7.bb"=
 rel=3D"noreferrer" target=3D"_blank">tpm2-tools_5.7.bb</a><br>
@@ -8,7 +8,7 @@ DEPENDS =3D &quot;tpm2-tss openssl curl&quot;<br>
<br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://github.com/tpm2-software/$%7BBPN=
%7D/releases/download/$%7BPV%7D/$%7BBPN%7D-$%7BPV%7D.tar.gz" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/tpm2-software/${BPN}/releases/dow=
nload/${PV}/${BPN}-${PV}.tar.gz</a>&quot;<br>
<br>
-SRC_URI[sha256sum] =3D &quot;1fdb49c730537bfdaed088884881a61e3bfd121e957ec=
0bdceeec0261236c123&quot;<br>
+SRC_URI[sha256sum] =3D &quot;3810d36b5079256f4f2f7ce552e22213d43b1031c1315=
38df8a2dbc3c570983a&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://github.com/tpm2-softw=
are/$%7BBPN%7D/releases" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/tpm2-software/${BPN}/releases</a>&quot;<br>
<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/442" targ=
et=3D"_blank">View/Reply Online (#442)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bmaster%5D%5BPATCH%5D%20tp=
m2-tools%3A%20Upgrade%205.5%20-%3E%205.7" target=3D"_blank">Reply To Group<=
/a>
 =20
    | <a href=3D"mailto:vanusuri@mvista.com?subject=3DPrivate:%20Re:%20Re%3=
A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bmaster%5D%5BPATCH%5D%20tpm2=
-tools%3A%20Upgrade%205.5%20-%3E%205.7" target=3D"_blank">Reply To Sender</=
a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/106995604/7301997" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/7301997" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13419208/73=
01997/1335553898/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:vanusuri@mvista.com" target=3D"_blank">vanusuri@mvista.=
com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--000000000000542fcf061e60e407--

