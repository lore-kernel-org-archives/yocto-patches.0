Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06063CEFC30
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 16:34:23 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web10.250.1728405258426381386
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Oct 2024 09:34:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WvryMUSC;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7154e7b915bso2952984a34.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405257; x=1729010057; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87PAcSce6ZMymwKsYl1spBgUC7//mIhcNw+/uLAxEQU=;
        b=WvryMUSCbKZGO7EEjJYHlCpIHzc1TdKdAwPRmSCeUsSN1RO72Ij1z+o6zAlXYCUrzk
         sm9d3PlHNPWeup7pSRTrHJGHSMpCsTjEGiMnIrE/6Np3LsnwFOv8aHTLts2l70DsoSOb
         NTQnT4DRbJU25Z6x0WzDnb/EdzOih2X6RWfFU5YtKri0yhIGGIxRbxZEcZHIPuf/0+7u
         7yP6x/fU2T7i+BgvAoSZEaiVt0UAGrdgDw61KlNtBridRkG9nMp7/5t5+ysQ64iY8Blp
         YeA/wLG6kiupz1PLFBhkibRXpp7U1fZU/dAV3+xGix5w9AmKll7mYJa8xz964uM9pL7C
         DeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405257; x=1729010057;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87PAcSce6ZMymwKsYl1spBgUC7//mIhcNw+/uLAxEQU=;
        b=lD6Yw1YhSD+6u46V2U5sEjYmYAg5ru2MjKCiJaT9sQr/lroXADdruL5Gqw2yZWQcEP
         K/2p3bLyW+356ir/qgMEa8DTrtXdZd0aqhQRd13iqtTgjRDNAKSMzRmi9L5cwdWVNO9c
         /3ke0MACbLnwDWy5rxQqHnwm+4LVXbL9/S7YjfTmW/kQXOy5MWz4yCsZLSsFFZw78CTg
         kxIBcQu+QAauXXGj5FPCqfpyzViY0d0eL5ESSkaM563IPxXwIV2KYR/RLAAeJf5OnyWF
         g7CAbpQnlprtCmFGHFIDIu0VzJ/YmMnmGOCKUdlrNR/jT8y3vx+pqeCeHOgjvQRqu5Ic
         tAFg==
X-Gm-Message-State: AOJu0YyvdvP9QrtSbUpnKK3BsB6FJYWMN8jKBtoypmLgeJ+ngi5D9okA
	5s3q1GZXRnUUX5og4LQSr0D93DbuLl1efcfaY1LrE6UcOLFGWjGQU1Dq2iRScMdhErgVx6PNhuP
	eRda1jw5MG2aKMAZ2S/MP00uhmxsFiqwU
X-Google-Smtp-Source: AGHT+IEo5cpli2AqBdSMEsjp/ciQ6A0PDpMYzz2lGHCFR+49w8zJSwzTHM0vGLWS2wXTCgtQselPuxZ/p49RTMQpMFA=
X-Received: by 2002:a05:6830:378b:b0:709:4556:fafc with SMTP id
 46e09a7af769-7154e81a63dmr12952878a34.2.1728405256606; Tue, 08 Oct 2024
 09:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no> <17FC807120D8B78D.25242@lists.yoctoproject.org>
In-Reply-To: <17FC807120D8B78D.25242@lists.yoctoproject.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 8 Oct 2024 17:34:05 +0100
Message-ID: <CANPvuRnZC-zcSAG_G90H-jDKmxefqBWLruJMFojoKTDwsLRu6A@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] meta-lts-mixins kirkstone/go: depend on
 -crosssdk recipes
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000591e910623f9b5f1"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 16:34:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/694

--000000000000591e910623f9b5f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jose Quaresma via lists.yoctoproject.org <quaresma.jose=3D
gmail.com@lists.yoctoproject.org> escreveu (ter=C3=A7a, 8/10/2024 =C3=A0(s)=
 15:26):

> Hi Martin,
>
> First of all, sorry for the delay.
> This happened during my vacation and I didn't see it at the time or when =
I
> came back later.
>
> I mostly use this with clang and everything seems to work but I believe
> you use gcc. I will test with the latter to see what happens.
> Could you please describe the steps to reproduce your build problem?
>

I have built go in the latest kirkstone without problems:

Build Configuration:
BB_VERSION           =3D "2.0.0"
BUILD_SYS            =3D "x86_64-linux"
NATIVELSBSTRING      =3D "universal"
TARGET_SYS           =3D "x86_64-poky-linux"
MACHINE              =3D "qemux86-64"
DISTRO               =3D "poky"
DISTRO_VERSION       =3D "4.0.21"
TUNE_FEATURES        =3D "m64 core2"
TARGET_FPU           =3D ""
meta
meta-poky            =3D "kirkstone:b61f2dc18a8b928091e4997335be66fa67a5e10=
d"
meta-lts-mixins      =3D
"kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4c7c59"


>
> Jose
>
> Martin D=C3=B8rum via lists.yoctoproject.org <martin=3D
> dorumtech.no@lists.yoctoproject.org> escreveu (segunda, 2/09/2024 =C3=A0(=
s)
> 12:57):
>
>> The Go recipes failed to compile for me,
>> because Bitbake said that the recipes
>> virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils
>> didn't exist.
>> I took a look at how Poky does it, and Poky's Go recipes depend on
>> virtual/${HOST_PREFIX}gcc-crosssdk and
>> virtual/${HOST_PREFIX}binutils-crosssdk,
>> so I changed the mixin recipes to reflect that.
>>
>> With these changes, the Go recipes compile on Kirkstone.
>> ---
>>  recipes-devtools/go/go-cross-canadian.inc | 2 +-
>>  recipes-devtools/go/go-crosssdk.inc       | 2 +-
>>  recipes-devtools/go/go-runtime.inc        | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-devtools/go/go-cross-canadian.inc
>> b/recipes-devtools/go/go-cross-canadian.inc
>> index dd485b6..2c6ed29 100644
>> --- a/recipes-devtools/go/go-cross-canadian.inc
>> +++ b/recipes-devtools/go/go-cross-canadian.inc
>> @@ -1,7 +1,7 @@
>>  inherit cross-canadian
>>
>>  DEPENDS =3D "go-native virtual/${HOST_PREFIX}go
>> virtual/nativesdk-${HOST_PREFIX}go-runtime \
>> -           virtual/${HOST_PREFIX}gcc virtual/nativesdk-libc \
>> +           virtual/${HOST_PREFIX}gcc-crosssdk virtual/nativesdk-libc \
>>             virtual/nativesdk-${HOST_PREFIX}compilerlibs"
>>  PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>>
>> diff --git a/recipes-devtools/go/go-crosssdk.inc
>> b/recipes-devtools/go/go-crosssdk.inc
>> index 1293900..61486a6 100644
>> --- a/recipes-devtools/go/go-crosssdk.inc
>> +++ b/recipes-devtools/go/go-crosssdk.inc
>> @@ -1,6 +1,6 @@
>>  inherit crosssdk
>>
>> -DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc
>> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
>> virtual/${TARGET_PREFIX}binutils"
>> +DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk
>> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
>> virtual/${TARGET_PREFIX}binutils-crosssdk"
>>  PN =3D "go-crosssdk-${SDK_SYS}"
>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go"
>>
>> diff --git a/recipes-devtools/go/go-runtime.inc
>> b/recipes-devtools/go/go-runtime.inc
>> index 413cf6d..86539f2 100644
>> --- a/recipes-devtools/go/go-runtime.inc
>> +++ b/recipes-devtools/go/go-runtime.inc
>> @@ -1,5 +1,5 @@
>>  DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"
>> -DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"
>> +DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"
>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"
>>
>>  DEBUG_PREFIX_MAP =3D "\
>> --
>> 2.46
>>
>>
>>
>>
>>
>>
>>
>
> --
> Best regards,
>
> Jos=C3=A9 Quaresma
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#693)
> <https://lists.yoctoproject.org/g/yocto-patches/message/693> | Reply To
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depend%20on%=
20-crosssdk%20recipes>
> | Reply To Sender
> <quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patc=
hes%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depend%20on%20=
-crosssdk%20recipes>
> | Mute This Topic <https://lists.yoctoproject.org/mt/108225175/5052612> |=
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

--000000000000591e910623f9b5f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jose Quaresma via <a href=3D"http://l=
ists.yoctoproject.org">lists.yoctoproject.org</a> &lt;quaresma.jose=3D<a hr=
ef=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@lists.yoctoproject=
.org</a>&gt; escreveu (ter=C3=A7a, 8/10/2024 =C3=A0(s) 15:26):<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Mar=
tin,</div><div><br></div><div>First of all, sorry for the delay.</div>This =
happened during my vacation and I didn&#39;t see it at the time or when I c=
ame back later.<br><br>I mostly use this with clang and everything seems to=
 work but I believe you use gcc. I will test with the latter to see what ha=
ppens.<br>Could you please describe the steps to reproduce your build probl=
em?<br></div></blockquote><div><br></div><div>I have built go in the latest=
 kirkstone without=C2=A0problems:<br></div><div><br></div><div>Build Config=
uration:<br>BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;2.0.0&q=
uot;<br>BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;x86_64=
-linux&quot;<br>NATIVELSBSTRING =C2=A0 =C2=A0 =C2=A0=3D &quot;universal&quo=
t;<br>TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x86_64-poky-l=
inux&quot;<br>MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
quot;qemux86-64&quot;<br>DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D &quot;poky&quot;<br>DISTRO_VERSION =C2=A0 =C2=A0 =C2=A0 =3D &quo=
t;4.0.21&quot;<br>TUNE_FEATURES =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;m64 co=
re2&quot;<br>TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;&quot;=
<br>meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>meta-p=
oky =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;kirkstone:b61f2dc18a=
8b928091e4997335be66fa67a5e10d&quot;<br>meta-lts-mixins =C2=A0 =C2=A0 =C2=
=A0=3D &quot;kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4c7c59&quot;<br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><br>Jose<div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Martin D=C3=B8rum via <a href=3D"http://lists.yoctop=
roject.org" target=3D"_blank">lists.yoctoproject.org</a> &lt;martin=3D<a hr=
ef=3D"mailto:dorumtech.no@lists.yoctoproject.org" target=3D"_blank">dorumte=
ch.no@lists.yoctoproject.org</a>&gt; escreveu (segunda, 2/09/2024 =C3=A0(s)=
 12:57):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The Go =
recipes failed to compile for me,<br>
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
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div><br clear=3D"all"><div><br></div><span cla=
ss=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail=
_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div>=
</div></div></div>

--000000000000591e910623f9b5f1--

