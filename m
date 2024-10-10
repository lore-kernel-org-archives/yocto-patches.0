Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1BCF11C2
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 09:53:08 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web10.39658.1728553986674330229
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Oct 2024 02:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VBlEDkme;
 spf=pass (domain: gmail.com, ip: 209.85.222.41, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so263256241.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728553985; x=1729158785; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ho6B+oOF1BtxtKTh4ESKPPMtDGVj7HR6NSUDQc2tNE=;
        b=VBlEDkme4Jp83pQNl7zhSO6iVSCGlHASKQ+/oyXdvFqHOMYz02B9Agyq7vWbZ+GSoX
         XAApnheAYdCGDNYeUVC7uvE4YGzvvH8LpCOBOu9UGvV9BteXdFiCSWnrAJiAx7dx3cYf
         0ntGgo9apw1aMCbe4+nx5lk63rDblJWsNxdmK89nUzp9bKXD/E8YpCHnjEgBik/9s1wR
         q7kThGigXhIbSxalivIO3IzNYo4gEnHJ1Fo+M7hs5WqCIVsPvM+z73k4uGgusdKs74MC
         HbDDnEcgiw9dsHvNWPudJO9bY0rglsnzyDMTAw165HWGa+jGjnihW2MoycsZmAxmAA7P
         gbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553985; x=1729158785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ho6B+oOF1BtxtKTh4ESKPPMtDGVj7HR6NSUDQc2tNE=;
        b=YfolPvzfUBbOXw3/W9feYDPcnHsy87usWCT3Ng/21qcLtvJDXPOhpgEVniTXCxgsRX
         oXCJGh0P14nMBk8Wln0RBD8hEkmXJGREzdG6WQj4PHarwWXd9Go19ZC/29XscKXrtu10
         4fQmwzzYd4rY4z+wyIVZ8wxpB4jHwXTbPsVxDWTtdxVhWyAXLCygRsW2I26fsgJcY9tQ
         h5+h++KESnUVYSIWR5AOclVeaPqUFtYgPKifQLO7tQLweB6HWWNS/gwTrNf85agXEeVH
         L+2cQbU/FHcn/n/klru56zNfHxMFPbl1dNnty/OhK1MDQbtGmkExtd/0vmac8cjSN1GA
         2KlQ==
X-Gm-Message-State: AOJu0YwmVDI4yUld+rP/NWIDDfOYD3VManYg3t2ZTrJ4Ac781GaBLmqe
	5dGjlvgDGljTqOPx0EvMI5taPM0B0cFetrSjq/63O/sxJJNacKoDU9ZVmKpt2aLYVAYM5xx3jdk
	Jyp5DcjqOjzazZ8Z0zahL5kfkZZ0=
X-Google-Smtp-Source: AGHT+IFN7clFRbHKgXNCz4mg9iOmJa/aaktrxByWbvcq39FsxrqHtTkjDdtuzCHxqAJoXM2IyVrbyvjYyJ+O99I/aeI=
X-Received: by 2002:a05:6102:3594:b0:4a3:bbc1:7eee with SMTP id
 ada2fe7eead31-4a448e340eemr6713445137.28.1728553985333; Thu, 10 Oct 2024
 02:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no>
 <17FC807120D8B78D.25242@lists.yoctoproject.org> <CANPvuRnZC-zcSAG_G90H-jDKmxefqBWLruJMFojoKTDwsLRu6A@mail.gmail.com>
 <C9F3D693-10AA-45B5-A6FE-8C5526129A08@dorumtech.no>
In-Reply-To: <C9F3D693-10AA-45B5-A6FE-8C5526129A08@dorumtech.no>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 10 Oct 2024 10:52:54 +0100
Message-ID: <CANPvuRnwXXpbQCw=hMoe-owa4HfcwA87o9tE=OqM5PGWSC=ndw@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] meta-lts-mixins kirkstone/go: depend on
 -crosssdk recipes
To: martin@dorumtech.no
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004562f606241c5669"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 09:53:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/698

--0000000000004562f606241c5669
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin D=C3=B8rum <martin@dorumtech.no> escreveu (ter=C3=A7a, 8/10/2024 =C3=
=A0(s) 21:34):

> I didn't understand the problem properly when I sent the patch,
> so my description was a bit lacking. Sorry for that.
> It turns out that the problem occurs specifically when building
> go-cross-canadian-<ARCH>.
> Turns out that I was seeing it because I had
> "packagegroup-go-cross-canadian-${MACHINE}"
> in my TOOLCHAIN_HOST_TASK and packagegroup-go-cross-canadian-<ARCH>
> depends on go-cross-canadian-<ARCH>.
>
> I think the problem is that commit 768c89e306d0486acf8bc76cecef90436f6551=
b3
> (
> https://git.yoctoproject.org/poky/commit/?h=3Dstyhead&id=3D768c89e306d048=
6acf8bc76cecef90436f6551b3
> )
> changed all the recipes to remove the -crosssdk suffix,
> and meta-lts-mixins kirkstone/go incorporates that change even though
> it doesn't work with the rest of Poky kirkstone.
>
> Here's what happens when I try to `bitbake go-cross-canadian-x86-64`
> on a fresh system with only Poky kirkstone and meta-lts-mixins
> kirkstone/go:
>
> =E2=88=9E nova /yocto/build $ bitbake go-cross-canadian-x86-64
> Loading cache: 100%
> |##################################################################| Time=
:
> 0:00:00
> Loaded 1653 entries from dependency cache.
> NOTE: Resolving any missing task queue dependencies
> ERROR: Nothing PROVIDES 'virtual/x86_64-pokysdk-linux-gcc' (but
> /yocto/meta-lts-mixins-go/recipes-devtools/go/go-cross-canadian_1.22.6.bb
> DEPENDS on or otherwise requires it). Close matches:
>   virtual/x86_64-poky-linux-g++
>   virtual/x86_64-poky-linux-gcc
>   virtual/x86_64-pokysdk-linux-go
> ERROR: Required build target 'go-cross-canadian-x86-64' has no buildable
> providers.
> Missing or unbuildable dependency chain was: ['go-cross-canadian-x86-64',
> 'virtual/x86_64-pokysdk-linux-gcc']
>
>
Hi Martin,

As a note I do not test this layer using the nativesdk and because of that
I do not know the level of support in the sdk.

I managed to reproduce the problem locally and after some testing I found
no regressions and so merged it.
Thanks for the steps to reproduce the issue.

Jose


> On 8 Oct 2024, at 18:34, Jose Quaresma <quaresma.jose@gmail.com> wrote:
>
>
>
> Jose Quaresma via lists.yoctoproject.org <quaresma.jose=3D
> gmail.com@lists.yoctoproject.org> escreveu (ter=C3=A7a, 8/10/2024 =C3=A0(=
s) 15:26):
>
>> Hi Martin,
>>
>> First of all, sorry for the delay.
>> This happened during my vacation and I didn't see it at the time or when
>> I came back later.
>>
>> I mostly use this with clang and everything seems to work but I believe
>> you use gcc. I will test with the latter to see what happens.
>> Could you please describe the steps to reproduce your build problem?
>>
>
> I have built go in the latest kirkstone without problems:
>
> Build Configuration:
> BB_VERSION           =3D "2.0.0"
> BUILD_SYS            =3D "x86_64-linux"
> NATIVELSBSTRING      =3D "universal"
> TARGET_SYS           =3D "x86_64-poky-linux"
> MACHINE              =3D "qemux86-64"
> DISTRO               =3D "poky"
> DISTRO_VERSION       =3D "4.0.21"
> TUNE_FEATURES        =3D "m64 core2"
> TARGET_FPU           =3D ""
> meta
> meta-poky            =3D "kirkstone:b61f2dc18a8b928091e4997335be66fa67a5e=
10d"
> meta-lts-mixins      =3D
> "kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4c7c59"
>
>
>>
>> Jose
>>
>> Martin D=C3=B8rum via lists.yoctoproject.org <martin=3D
>> dorumtech.no@lists.yoctoproject.org> escreveu (segunda, 2/09/2024 =C3=A0=
(s)
>> 12:57):
>>
>>> The Go recipes failed to compile for me,
>>> because Bitbake said that the recipes
>>> virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils
>>> didn't exist.
>>> I took a look at how Poky does it, and Poky's Go recipes depend on
>>> virtual/${HOST_PREFIX}gcc-crosssdk and
>>> virtual/${HOST_PREFIX}binutils-crosssdk,
>>> so I changed the mixin recipes to reflect that.
>>>
>>> With these changes, the Go recipes compile on Kirkstone.
>>> ---
>>>  recipes-devtools/go/go-cross-canadian.inc | 2 +-
>>>  recipes-devtools/go/go-crosssdk.inc       | 2 +-
>>>  recipes-devtools/go/go-runtime.inc        | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/recipes-devtools/go/go-cross-canadian.inc
>>> b/recipes-devtools/go/go-cross-canadian.inc
>>> index dd485b6..2c6ed29 100644
>>> --- a/recipes-devtools/go/go-cross-canadian.inc
>>> +++ b/recipes-devtools/go/go-cross-canadian.inc
>>> @@ -1,7 +1,7 @@
>>>  inherit cross-canadian
>>>
>>>  DEPENDS =3D "go-native virtual/${HOST_PREFIX}go
>>> virtual/nativesdk-${HOST_PREFIX}go-runtime \
>>> -           virtual/${HOST_PREFIX}gcc virtual/nativesdk-libc \
>>> +           virtual/${HOST_PREFIX}gcc-crosssdk virtual/nativesdk-libc \
>>>             virtual/nativesdk-${HOST_PREFIX}compilerlibs"
>>>  PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>>>
>>> diff --git a/recipes-devtools/go/go-crosssdk.inc
>>> b/recipes-devtools/go/go-crosssdk.inc
>>> index 1293900..61486a6 100644
>>> --- a/recipes-devtools/go/go-crosssdk.inc
>>> +++ b/recipes-devtools/go/go-crosssdk.inc
>>> @@ -1,6 +1,6 @@
>>>  inherit crosssdk
>>>
>>> -DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc
>>> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
>>> virtual/${TARGET_PREFIX}binutils"
>>> +DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk
>>> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
>>> virtual/${TARGET_PREFIX}binutils-crosssdk"
>>>  PN =3D "go-crosssdk-${SDK_SYS}"
>>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go"
>>>
>>> diff --git a/recipes-devtools/go/go-runtime.inc
>>> b/recipes-devtools/go/go-runtime.inc
>>> index 413cf6d..86539f2 100644
>>> --- a/recipes-devtools/go/go-runtime.inc
>>> +++ b/recipes-devtools/go/go-runtime.inc
>>> @@ -1,5 +1,5 @@
>>>  DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"
>>> -DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"
>>> +DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"
>>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"
>>>
>>>  DEBUG_PREFIX_MAP =3D "\
>>> --
>>> 2.46
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>
>> --
>> Best regards,
>>
>> Jos=C3=A9 Quaresma
>> _._,_._,_
>> ------------------------------
>> Links:
>>
>> You receive all messages sent to this group.
>>
>> View/Reply Online (#693)
>> <https://lists.yoctoproject.org/g/yocto-patches/message/693> | Reply To
>> Group
>> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-p=
atches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depend%20on=
%20-crosssdk%20recipes>
>> | Reply To Sender
>> <quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-pat=
ches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depend%20on%2=
0-crosssdk%20recipes>
>> | Mute This Topic <https://lists.yoctoproject.org/mt/108225175/5052612>
>> | New Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
>> Your Subscription
>> <https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612> | Conta=
ct
>> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
>> <https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/1=
504338242/xyzzy>
>> [quaresma.jose@gmail.com]
>> _._,_._,_
>>
>>
>>
>
> --
> Best regards,
>
> Jos=C3=A9 Quaresma
>
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000004562f606241c5669
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Martin D=C3=B8rum &lt;<a href=3D"mail=
to:martin@dorumtech.no">martin@dorumtech.no</a>&gt; escreveu (ter=C3=A7a, 8=
/10/2024 =C3=A0(s) 21:34):<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div><div>I didn&#39;t understand the problem properly when I se=
nt the patch,</div><div>so my description was a bit lacking. Sorry for that=
.</div><div>It turns out that the problem occurs specifically when building=
 go-cross-canadian-&lt;ARCH&gt;.</div><div>Turns out that I was seeing it b=
ecause I had &quot;packagegroup-go-cross-canadian-${MACHINE}&quot;</div><di=
v>in my TOOLCHAIN_HOST_TASK and packagegroup-go-cross-canadian-&lt;ARCH&gt;=
</div><div>depends on go-cross-canadian-&lt;ARCH&gt;.</div><div><br></div><=
div><div style=3D"color:rgb(0,0,0)">I think the problem is that commit=C2=
=A0768c89e306d0486acf8bc76cecef90436f6551b3</div><div style=3D"color:rgb(0,=
0,0)">(<a href=3D"https://git.yoctoproject.org/poky/commit/?h=3Dstyhead&amp=
;id=3D768c89e306d0486acf8bc76cecef90436f6551b3" target=3D"_blank">https://g=
it.yoctoproject.org/poky/commit/?h=3Dstyhead&amp;id=3D768c89e306d0486acf8bc=
76cecef90436f6551b3</a>)</div><div style=3D"color:rgb(0,0,0)">changed all t=
he recipes to remove the -crosssdk suffix,</div><div style=3D"color:rgb(0,0=
,0)">and meta-lts-mixins kirkstone/go incorporates that change even though<=
/div><div style=3D"color:rgb(0,0,0)">it doesn&#39;t work with the rest of P=
oky kirkstone.</div></div><div><br></div><div>Here&#39;s what happens when =
I try to `bitbake go-cross-canadian-x86-64`</div><div>on a fresh system wit=
h only Poky kirkstone and meta-lts-mixins kirkstone/go:</div><div><br></div=
><div>=E2=88=9E nova /yocto/build $ bitbake go-cross-canadian-x86-64</div><=
div>Loading cache: 100% |##################################################=
################| Time: 0:00:00</div><div>Loaded 1653 entries from dependen=
cy cache.</div><div>NOTE: Resolving any missing task queue dependencies</di=
v><div>ERROR: Nothing PROVIDES &#39;virtual/x86_64-pokysdk-linux-gcc&#39; (=
but /yocto/meta-lts-mixins-go/recipes-devtools/go/<a href=3D"http://go-cros=
s-canadian_1.22.6.bb" target=3D"_blank">go-cross-canadian_1.22.6.bb</a> DEP=
ENDS on or otherwise requires it). Close matches:</div><div>=C2=A0 virtual/=
x86_64-poky-linux-g++</div><div>=C2=A0 virtual/x86_64-poky-linux-gcc</div><=
div>=C2=A0 virtual/x86_64-pokysdk-linux-go</div><div>ERROR: Required build =
target &#39;go-cross-canadian-x86-64&#39; has no buildable providers.</div>=
<div>Missing or unbuildable dependency chain was: [&#39;go-cross-canadian-x=
86-64&#39;, &#39;virtual/x86_64-pokysdk-linux-gcc&#39;]</div><div><br></div=
></div></blockquote><div><br></div><div>Hi Martin,<br><br><div>As a note I =
do not test this layer using the nativesdk and because of that I do not kno=
w the level of support in the sdk.<br></div><div><div><br></div></div></div=
><div>I managed to reproduce the problem locally and after some testing I f=
ound no regressions and so merged it.<br></div><div><div><div>Thanks for th=
e steps to reproduce the issue.</div><div><br></div>Jose</div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div><div></div><div><div>=
<div><div><blockquote type=3D"cite"><div>On 8 Oct 2024, at 18:34, Jose Quar=
esma &lt;<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank">quare=
sma.jose@gmail.com</a>&gt; wrote:</div><br><div><div dir=3D"ltr"><div dir=
=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Jose Quaresma via <a href=3D"http://lists.yoctoproject.org/" t=
arget=3D"_blank">lists.yoctoproject.org</a> &lt;quaresma.jose=3D<a href=3D"=
mailto:gmail.com@lists.yoctoproject.org" target=3D"_blank">gmail.com@lists.=
yoctoproject.org</a>&gt; escreveu (ter=C3=A7a, 8/10/2024 =C3=A0(s) 15:26):<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div>Hi Martin,</div><div><br></div><div>First of all, sorry for the delay=
.</div>This happened during my vacation and I didn&#39;t see it at the time=
 or when I came back later.<br><br>I mostly use this with clang and everyth=
ing seems to work but I believe you use gcc. I will test with the latter to=
 see what happens.<br>Could you please describe the steps to reproduce your=
 build problem?<br></div></blockquote><div><br></div><div>I have built go i=
n the latest kirkstone without=C2=A0problems:<br></div><div><br></div><div>=
Build Configuration:<br>BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &=
quot;2.0.0&quot;<br>BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
&quot;x86_64-linux&quot;<br>NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D &quot;u=
niversal&quot;<br>TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x=
86_64-poky-linux&quot;<br>MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D &quot;qemux86-64&quot;<br>DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D &quot;poky&quot;<br>DISTRO_VERSION =C2=A0 =C2=A0 =C2=
=A0 =3D &quot;4.0.21&quot;<br>TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
&quot;m64 core2&quot;<br>TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
&quot;&quot;<br>meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>meta-poky =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;kirkst=
one:b61f2dc18a8b928091e4997335be66fa67a5e10d&quot;<br>meta-lts-mixins =C2=
=A0 =C2=A0 =C2=A0=3D &quot;kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4=
c7c59&quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><br>Jose<div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">Martin D=C3=B8rum via <a href=3D"http:=
//lists.yoctoproject.org/" target=3D"_blank">lists.yoctoproject.org</a> &lt=
;martin=3D<a href=3D"mailto:dorumtech.no@lists.yoctoproject.org" target=3D"=
_blank">dorumtech.no@lists.yoctoproject.org</a>&gt; escreveu (segunda, 2/09=
/2024 =C3=A0(s) 12:57):<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">The Go recipes failed to compile for me,<br>
because Bitbake said that the recipes<br>
virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils<br>
didn&#39;t exist.<br>
I took a look at how Poky does it, and Poky&#39;s Go recipes depend on<br>
virtual/${HOST_PREFIX}gcc-crosssdk and<br>
virtual/${HOST_PREFIX}binutils-crosssdk,<br>
so I changed the mixin recipes to reflect that.<br>
<br>
With these changes, the Go recipes compile on Kirkstone.<br>
---<br>
=C2=A0recipes-devtools/go/go-cross-canadian.inc | 2 +-<br>
=C2=A0recipes-devtools/go/go-crosssdk.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
=C2=A0recipes-devtools/go/go-runtime.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<=
br>
=C2=A03 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/recipes-devtools/go/go-cross-canadian.inc b/recipes-devtools/g=
o/go-cross-canadian.inc<br>
index dd485b6..2c6ed29 100644<br>
--- a/recipes-devtools/go/go-cross-canadian.inc<br>
+++ b/recipes-devtools/go/go-cross-canadian.inc<br>
@@ -1,7 +1,7 @@<br>
=C2=A0inherit cross-canadian<br>
<br>
=C2=A0DEPENDS =3D &quot;go-native virtual/${HOST_PREFIX}go virtual/nativesd=
k-${HOST_PREFIX}go-runtime \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtual/${HOST_PREFIX}gcc virtual=
/nativesdk-libc \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtual/${HOST_PREFIX}gcc-crosssd=
k virtual/nativesdk-libc \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtual/nativesdk-${HOST_PREFIX}c=
ompilerlibs&quot;<br>
=C2=A0PN =3D &quot;go-cross-canadian-${TRANSLATED_TARGET_ARCH}&quot;<br>
<br>
diff --git a/recipes-devtools/go/go-crosssdk.inc b/recipes-devtools/go/go-c=
rosssdk.inc<br>
index 1293900..61486a6 100644<br>
--- a/recipes-devtools/go/go-crosssdk.inc<br>
+++ b/recipes-devtools/go/go-crosssdk.inc<br>
@@ -1,6 +1,6 @@<br>
=C2=A0inherit crosssdk<br>
<br>
-DEPENDS =3D &quot;go-native virtual/${TARGET_PREFIX}gcc virtual/nativesdk-=
${TARGET_PREFIX}compilerlibs virtual/${TARGET_PREFIX}binutils&quot;<br>
+DEPENDS =3D &quot;go-native virtual/${TARGET_PREFIX}gcc-crosssdk virtual/n=
ativesdk-${TARGET_PREFIX}compilerlibs virtual/${TARGET_PREFIX}binutils-cros=
ssdk&quot;<br>
=C2=A0PN =3D &quot;go-crosssdk-${SDK_SYS}&quot;<br>
=C2=A0PROVIDES =3D &quot;virtual/${TARGET_PREFIX}go&quot;<br>
<br>
diff --git a/recipes-devtools/go/go-runtime.inc b/recipes-devtools/go/go-ru=
ntime.inc<br>
index 413cf6d..86539f2 100644<br>
--- a/recipes-devtools/go/go-runtime.inc<br>
+++ b/recipes-devtools/go/go-runtime.inc<br>
@@ -1,5 +1,5 @@<br>
=C2=A0DEPENDS =3D &quot;virtual/${TUNE_PKGARCH}-go go-native&quot;<br>
-DEPENDS:class-nativesdk =3D &quot;virtual/${TARGET_PREFIX}go&quot;<br>
+DEPENDS:class-nativesdk =3D &quot;virtual/${TARGET_PREFIX}go-crosssdk&quot=
;<br>
=C2=A0PROVIDES =3D &quot;virtual/${TARGET_PREFIX}go-runtime&quot;<br>
<br>
=C2=A0DEBUG_PREFIX_MAP =3D &quot;\<br>
--<br>
2.46<br>
<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/693" targ=
et=3D"_blank">View/Reply Online (#693)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%=
3A%20depend%20on%20-crosssdk%20recipes" target=3D"_blank">Reply To Group</a=
>
 =20
    | <a href=3D"mailto:quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20=
Re%3A%20%5Byocto-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fg=
o%3A%20depend%20on%20-crosssdk%20recipes" target=3D"_blank">Reply To Sender=
</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/108225175/5052612" target=3D=
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
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div><div><=
br></div><div><br></div></blockquote></div><br clear=3D"all"><div><br></div=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quar=
esma</div></div></div></div>
</div></blockquote></div><br></div></div></div></div></blockquote></div><br=
 clear=3D"all"><div><br></div><span class=3D"gmail_signature_prefix">-- </s=
pan><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best re=
gards,<div><br>Jos=C3=A9 Quaresma</div></div></div></div>

--0000000000004562f606241c5669--

