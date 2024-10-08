Return-Path: <martin@dorumtech.no>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0774CEFC56
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 20:34:34 +0000 (UTC)
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mx.groups.io with SMTP id smtpd.web10.6098.1728419665904517468
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Oct 2024 13:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@dorumtech.no header.s=fm1 header.b=sLXI1vzY;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=b6pAe7uC;
 spf=pass (domain: dorumtech.no, ip: 103.168.172.156, mailfrom: martin@dorumtech.no)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0890411401FB;
	Tue,  8 Oct 2024 16:34:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 08 Oct 2024 16:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dorumtech.no; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728419665; x=1728506065; bh=UK1/R5SRmh
	uw1iEkaQr5/pYJsDpQAUONxizy6ExSke0=; b=sLXI1vzYRKNAx5MA5gv5CYrqmv
	J9Z0v9SFy4araRMPNdKplSdEPfHRyDTZB3SP2nABJ5fbUzTOqCB7IGqx/3ReFUn9
	Ge1I0Q9VLhuQSfyVULKB0A9o/QI+Twfl7+kGqLFpa6lo/xT70eyQytbgcNRJ54Yr
	0BU3N0yBmGLrU1ZBnVARBhu0L4zDIAp087ompTahG9/0TapRhUTnaITK+MZbnNty
	Ag1JRibdGj9EduFkfyAs4Ma9lpmMWQgq774XG4GenwIk4nsxDHCVEwdm2w57eGks
	jSC/t9yMRc2IbFriwUzJ8HC6M001KbGcbySE3AWfS94ZExCgZ/IqupBArv1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728419665; x=1728506065; bh=UK1/R5SRmhuw1iEkaQr5/pYJsDpQ
	AUONxizy6ExSke0=; b=b6pAe7uCDdfwWNp4ne1NDgsOlhFl/jy7ouvKApWWM8Mj
	Nw2Ul1pNVJq2RcY1Xd5+ieO9RpYCLjyBr7Y8yovjaURH/Vom8jrAGz775ZYpAQw3
	iGPkbBhhUlZS9YrbYSFR7caEsPIrB7DGmkYud05lxUqUMgzi8RXrgkZSGF2lI1BU
	Ebc07HLU4mFa5pMxN4velCFYyYmixOE/4DOZQ5kPyIBELcLd4U4h0CZZH6WUTCtX
	NjHDyXdRBsvH579HeTBEQQTcPgmkyVSkWX3GtDgATgOcdRznoJNf6kMfDz828pdg
	D6KOCHdEze6+Jdoiu2PTb4Pl5VszeZPGp197SJ3HDg==
X-ME-Sender: <xms:UJcFZ3dg-sXo2NUSAIqTcslBp0yNTEGFEsgK3bAVeeqme3Ok42aSow>
    <xme:UJcFZ9MY8KWXDxjHToOUGY_yfznUBV3eEA6ya4sHaFxSnwoj7wn1vny8b9b1RyvmZ
    CdJCj8av3dvW4mQUNQ>
X-ME-Received: <xmr:UJcFZwh8bDFkID1Pl7C-TgQBFg48Unar5IY7gRgWOSgQAn33EHaJXjX7m6WQHmrJZ7Y6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhkfgtggfuffgjvefvfhfosegrtdhmrehhtdej
    necuhfhrohhmpeforghrthhinhcuffpprhhumhcuoehmrghrthhinhesughorhhumhhtvg
    gthhdrnhhoqeenucggtffrrghtthgvrhhnpeeiueefgfevgeefueeujeekudekudeftddv
    hedtiefffeektdehteevudehfeefudenucffohhmrghinhephihotghtohhprhhojhgvtg
    htrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrrhhtihhnseguohhruhhmthgvtghhrdhnohdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhurghrvghsmhgrrdhjohhsvgesghhm
    rghilhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrd
    ihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:UJcFZ49r4w4wBijPj3Q4eiPeOTN8ZLyb4nIiL3VYqB57KFknMJFaYg>
    <xmx:UJcFZzsKjw-i2RibosVOqIzMdvEKMziNG5qO6LwYSMFs1Odd773LMw>
    <xmx:UJcFZ3H5YjziEeYhSB1IdUsG_MbPIgduS0XmeodOLMWsWpuCa8PjoA>
    <xmx:UJcFZ6NMCQc6506OZVrqaX_Xqc43sqIbUMzH2lngj4HgRKvFvYBsCg>
    <xmx:UJcFZ84DHbVmv7eJJxaKQ13c_adhLLF-_hJPAdH9ne-pLLwStGpiR1dw>
Feedback-ID: i1281493f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 16:34:23 -0400 (EDT)
From: =?utf-8?Q?Martin_D=C3=B8rum?= <martin@dorumtech.no>
Message-Id: <C9F3D693-10AA-45B5-A6FE-8C5526129A08@dorumtech.no>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_E9FF14AA-4ECD-49C9-8AA1-D9B3C8E33B9F"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [yocto-patches] [PATCH] meta-lts-mixins kirkstone/go: depend on
 -crosssdk recipes
Date: Tue, 8 Oct 2024 22:34:10 +0200
In-Reply-To: <CANPvuRnZC-zcSAG_G90H-jDKmxefqBWLruJMFojoKTDwsLRu6A@mail.gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
To: Jose Quaresma <quaresma.jose@gmail.com>
References: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no>
 <17FC807120D8B78D.25242@lists.yoctoproject.org>
 <CANPvuRnZC-zcSAG_G90H-jDKmxefqBWLruJMFojoKTDwsLRu6A@mail.gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 20:34:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/695


--Apple-Mail=_E9FF14AA-4ECD-49C9-8AA1-D9B3C8E33B9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I didn't understand the problem properly when I sent the patch,
so my description was a bit lacking. Sorry for that.
It turns out that the problem occurs specifically when building =
go-cross-canadian-<ARCH>.
Turns out that I was seeing it because I had =
"packagegroup-go-cross-canadian-${MACHINE}"
in my TOOLCHAIN_HOST_TASK and packagegroup-go-cross-canadian-<ARCH>
depends on go-cross-canadian-<ARCH>.

I think the problem is that commit =
768c89e306d0486acf8bc76cecef90436f6551b3
=
(https://git.yoctoproject.org/poky/commit/?h=3Dstyhead&id=3D768c89e306d048=
6acf8bc76cecef90436f6551b3)
changed all the recipes to remove the -crosssdk suffix,
and meta-lts-mixins kirkstone/go incorporates that change even though
it doesn't work with the rest of Poky kirkstone.

Here's what happens when I try to `bitbake go-cross-canadian-x86-64`
on a fresh system with only Poky kirkstone and meta-lts-mixins =
kirkstone/go:

=E2=88=9E nova /yocto/build $ bitbake go-cross-canadian-x86-64
Loading cache: 100% =
|##################################################################| =
Time: 0:00:00
Loaded 1653 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies
ERROR: Nothing PROVIDES 'virtual/x86_64-pokysdk-linux-gcc' (but =
/yocto/meta-lts-mixins-go/recipes-devtools/go/go-cross-canadian_1.22.6.bb =
DEPENDS on or otherwise requires it). Close matches:
  virtual/x86_64-poky-linux-g++
  virtual/x86_64-poky-linux-gcc
  virtual/x86_64-pokysdk-linux-go
ERROR: Required build target 'go-cross-canadian-x86-64' has no buildable =
providers.
Missing or unbuildable dependency chain was: =
['go-cross-canadian-x86-64', 'virtual/x86_64-pokysdk-linux-gcc']

> On 8 Oct 2024, at 18:34, Jose Quaresma <quaresma.jose@gmail.com> =
wrote:
>=20
>=20
>=20
> Jose Quaresma via lists.yoctoproject.org =
<http://lists.yoctoproject.org/> =
<quaresma.jose=3Dgmail.com@lists.yoctoproject.org =
<mailto:gmail.com@lists.yoctoproject.org>> escreveu (ter=C3=A7a, =
8/10/2024 =C3=A0(s) 15:26):
>> Hi Martin,
>>=20
>> First of all, sorry for the delay.
>> This happened during my vacation and I didn't see it at the time or =
when I came back later.
>>=20
>> I mostly use this with clang and everything seems to work but I =
believe you use gcc. I will test with the latter to see what happens.
>> Could you please describe the steps to reproduce your build problem?
>=20
> I have built go in the latest kirkstone without problems:
>=20
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
> meta                =20
> meta-poky            =3D =
"kirkstone:b61f2dc18a8b928091e4997335be66fa67a5e10d"
> meta-lts-mixins      =3D =
"kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4c7c59"
> =20
>>=20
>> Jose
>>=20
>> Martin D=C3=B8rum via lists.yoctoproject.org =
<http://lists.yoctoproject.org/> =
<martin=3Ddorumtech.no@lists.yoctoproject.org =
<mailto:dorumtech.no@lists.yoctoproject.org>> escreveu (segunda, =
2/09/2024 =C3=A0(s) 12:57):
>>> The Go recipes failed to compile for me,
>>> because Bitbake said that the recipes
>>> virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils
>>> didn't exist.
>>> I took a look at how Poky does it, and Poky's Go recipes depend on
>>> virtual/${HOST_PREFIX}gcc-crosssdk and
>>> virtual/${HOST_PREFIX}binutils-crosssdk,
>>> so I changed the mixin recipes to reflect that.
>>>=20
>>> With these changes, the Go recipes compile on Kirkstone.
>>> ---
>>>  recipes-devtools/go/go-cross-canadian.inc | 2 +-
>>>  recipes-devtools/go/go-crosssdk.inc       | 2 +-
>>>  recipes-devtools/go/go-runtime.inc        | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/recipes-devtools/go/go-cross-canadian.inc =
b/recipes-devtools/go/go-cross-canadian.inc
>>> index dd485b6..2c6ed29 100644
>>> --- a/recipes-devtools/go/go-cross-canadian.inc
>>> +++ b/recipes-devtools/go/go-cross-canadian.inc
>>> @@ -1,7 +1,7 @@
>>>  inherit cross-canadian
>>>=20
>>>  DEPENDS =3D "go-native virtual/${HOST_PREFIX}go =
virtual/nativesdk-${HOST_PREFIX}go-runtime \
>>> -           virtual/${HOST_PREFIX}gcc virtual/nativesdk-libc \
>>> +           virtual/${HOST_PREFIX}gcc-crosssdk =
virtual/nativesdk-libc \
>>>             virtual/nativesdk-${HOST_PREFIX}compilerlibs"
>>>  PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>>>=20
>>> diff --git a/recipes-devtools/go/go-crosssdk.inc =
b/recipes-devtools/go/go-crosssdk.inc
>>> index 1293900..61486a6 100644
>>> --- a/recipes-devtools/go/go-crosssdk.inc
>>> +++ b/recipes-devtools/go/go-crosssdk.inc
>>> @@ -1,6 +1,6 @@
>>>  inherit crosssdk
>>>=20
>>> -DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils"
>>> +DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils-crosssdk"
>>>  PN =3D "go-crosssdk-${SDK_SYS}"
>>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go"
>>>=20
>>> diff --git a/recipes-devtools/go/go-runtime.inc =
b/recipes-devtools/go/go-runtime.inc
>>> index 413cf6d..86539f2 100644
>>> --- a/recipes-devtools/go/go-runtime.inc
>>> +++ b/recipes-devtools/go/go-runtime.inc
>>> @@ -1,5 +1,5 @@
>>>  DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"
>>> -DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"
>>> +DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"
>>>  PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"
>>>=20
>>>  DEBUG_PREFIX_MAP =3D "\
>>> --
>>> 2.46
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>>=20
>> --
>> Best regards,
>>=20
>> Jos=C3=A9 Quaresma
>> _._,_._,_
>> Links:
>> You receive all messages sent to this group.
>>=20
>> View/Reply Online (#693) =
<https://lists.yoctoproject.org/g/yocto-patches/message/693> | Reply To =
Group =
<mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byo=
cto-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depen=
d%20on%20-crosssdk%20recipes> | Reply To Sender =
<mailto:quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byoct=
o-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20depend%=
20on%20-crosssdk%20recipes> | Mute This Topic =
<https://lists.yoctoproject.org/mt/108225175/5052612> | New Topic =
<https://lists.yoctoproject.org/g/yocto-patches/post>=20
>> Your Subscription =
<https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612> | =
Contact Group Owner <mailto:yocto-patches+owner@lists.yoctoproject.org> =
| Unsubscribe =
<https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy> [quaresma.jose@gmail.com =
<mailto:quaresma.jose@gmail.com>]
>>=20
>> _._,_._,_
>>=20
>>=20
>=20
>=20
> --
> Best regards,
>=20
> Jos=C3=A9 Quaresma


--Apple-Mail=_E9FF14AA-4ECD-49C9-8AA1-D9B3C8E33B9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><div>I didn't =
understand the problem properly when I sent the patch,</div><div>so my =
description was a bit lacking. Sorry for that.</div><div>It turns out =
that the problem occurs specifically when building =
go-cross-canadian-&lt;ARCH&gt;.</div><div>Turns out that I was seeing it =
because I had "packagegroup-go-cross-canadian-${MACHINE}"</div><div>in =
my TOOLCHAIN_HOST_TASK and =
packagegroup-go-cross-canadian-&lt;ARCH&gt;</div><div>depends on =
go-cross-canadian-&lt;ARCH&gt;.</div><div><br></div><div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">I think the =
problem is that =
commit&nbsp;768c89e306d0486acf8bc76cecef90436f6551b3</div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">(<a =
href=3D"https://git.yoctoproject.org/poky/commit/?h=3Dstyhead&amp;id=3D768=
c89e306d0486acf8bc76cecef90436f6551b3">https://git.yoctoproject.org/poky/c=
ommit/?h=3Dstyhead&amp;id=3D768c89e306d0486acf8bc76cecef90436f6551b3</a>)<=
/div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">changed all the recipes to remove the -crosssdk suffix,</div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">and =
meta-lts-mixins kirkstone/go incorporates that change even =
though</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">it doesn't work with the rest of Poky =
kirkstone.</div></div><div><br></div><div>Here's what happens when I try =
to `bitbake go-cross-canadian-x86-64`</div><div>on a fresh system with =
only Poky kirkstone and meta-lts-mixins =
kirkstone/go:</div><div><br></div><div>=E2=88=9E nova /yocto/build $ =
bitbake go-cross-canadian-x86-64</div><div>Loading cache: 100% =
|##################################################################| =
Time: 0:00:00</div><div>Loaded 1653 entries from dependency =
cache.</div><div>NOTE: Resolving any missing task queue =
dependencies</div><div>ERROR: Nothing PROVIDES =
'virtual/x86_64-pokysdk-linux-gcc' (but =
/yocto/meta-lts-mixins-go/recipes-devtools/go/go-cross-canadian_1.22.6.bb =
DEPENDS on or otherwise requires it). Close matches:</div><div>&nbsp; =
virtual/x86_64-poky-linux-g++</div><div>&nbsp; =
virtual/x86_64-poky-linux-gcc</div><div>&nbsp; =
virtual/x86_64-pokysdk-linux-go</div><div>ERROR: Required build target =
'go-cross-canadian-x86-64' has no buildable providers.</div><div>Missing =
or unbuildable dependency chain was: ['go-cross-canadian-x86-64', =
'virtual/x86_64-pokysdk-linux-gcc']</div><div><br></div><div><div><div><di=
v><blockquote type=3D"cite"><div>On 8 Oct 2024, at 18:34, Jose Quaresma =
&lt;quaresma.jose@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div dir=3D"ltr"><div =
dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Jose Quaresma via <a =
href=3D"http://lists.yoctoproject.org/">lists.yoctoproject.org</a> =
&lt;quaresma.jose=3D<a =
href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@lists.yoctoproj=
ect.org</a>&gt; escreveu (ter=C3=A7a, 8/10/2024 =C3=A0(s) =
15:26):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi =
Martin,</div><div><br></div><div>First of all, sorry for the =
delay.</div>This happened during my vacation and I didn't see it at the =
time or when I came back later.<br><br>I mostly use this with clang and =
everything seems to work but I believe you use gcc. I will test with the =
latter to see what happens.<br>Could you please describe the steps to =
reproduce your build =
problem?<br></div></blockquote><div><br></div><div>I have built go in =
the latest kirkstone =
without&nbsp;problems:<br></div><div><br></div><div>Build =
Configuration:<br>BB_VERSION &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
"2.0.0"<br>BUILD_SYS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
"x86_64-linux"<br>NATIVELSBSTRING &nbsp; &nbsp; &nbsp;=3D =
"universal"<br>TARGET_SYS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
"x86_64-poky-linux"<br>MACHINE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=3D "qemux86-64"<br>DISTRO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; =3D "poky"<br>DISTRO_VERSION &nbsp; &nbsp; &nbsp; =3D =
"4.0.21"<br>TUNE_FEATURES &nbsp; &nbsp; &nbsp; &nbsp;=3D "m64 =
core2"<br>TARGET_FPU &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D ""<br>meta =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>meta-poky =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
"kirkstone:b61f2dc18a8b928091e4997335be66fa67a5e10d"<br>meta-lts-mixins =
&nbsp; &nbsp; &nbsp;=3D =
"kirkstone/go:5e3924465987f19655f6f5540f8c5187fa4c7c59"<br></div><div>&nbs=
p;</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><br>Jose<div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Martin D=C3=B8rum via <a =
href=3D"http://lists.yoctoproject.org/" =
target=3D"_blank">lists.yoctoproject.org</a> &lt;martin=3D<a =
href=3D"mailto:dorumtech.no@lists.yoctoproject.org" =
target=3D"_blank">dorumtech.no@lists.yoctoproject.org</a>&gt; escreveu =
(segunda, 2/09/2024 =C3=A0(s) 12:57):<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">The Go recipes failed to =
compile for me,<br>
because Bitbake said that the recipes<br>
virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils<br>
didn't exist.<br>
I took a look at how Poky does it, and Poky's Go recipes depend on<br>
virtual/${HOST_PREFIX}gcc-crosssdk and<br>
virtual/${HOST_PREFIX}binutils-crosssdk,<br>
so I changed the mixin recipes to reflect that.<br>
<br>
With these changes, the Go recipes compile on Kirkstone.<br>
---<br>
&nbsp;recipes-devtools/go/go-cross-canadian.inc | 2 +-<br>
&nbsp;recipes-devtools/go/go-crosssdk.inc&nbsp; &nbsp; &nbsp; &nbsp;| 2 =
+-<br>
&nbsp;recipes-devtools/go/go-runtime.inc&nbsp; &nbsp; &nbsp; &nbsp; | 2 =
+-<br>
&nbsp;3 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/recipes-devtools/go/go-cross-canadian.inc =
b/recipes-devtools/go/go-cross-canadian.inc<br>
index dd485b6..2c6ed29 100644<br>
--- a/recipes-devtools/go/go-cross-canadian.inc<br>
+++ b/recipes-devtools/go/go-cross-canadian.inc<br>
@@ -1,7 +1,7 @@<br>
&nbsp;inherit cross-canadian<br>
<br>
&nbsp;DEPENDS =3D "go-native virtual/${HOST_PREFIX}go =
virtual/nativesdk-${HOST_PREFIX}go-runtime \<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;virtual/${HOST_PREFIX}gcc =
virtual/nativesdk-libc \<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;virtual/${HOST_PREFIX}gcc-crosssdk virtual/nativesdk-libc \<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
virtual/nativesdk-${HOST_PREFIX}compilerlibs"<br>
&nbsp;PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"<br>
<br>
diff --git a/recipes-devtools/go/go-crosssdk.inc =
b/recipes-devtools/go/go-crosssdk.inc<br>
index 1293900..61486a6 100644<br>
--- a/recipes-devtools/go/go-crosssdk.inc<br>
+++ b/recipes-devtools/go/go-crosssdk.inc<br>
@@ -1,6 +1,6 @@<br>
&nbsp;inherit crosssdk<br>
<br>
-DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils"<br>
+DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils-crosssdk"<br>
&nbsp;PN =3D "go-crosssdk-${SDK_SYS}"<br>
&nbsp;PROVIDES =3D "virtual/${TARGET_PREFIX}go"<br>
<br>
diff --git a/recipes-devtools/go/go-runtime.inc =
b/recipes-devtools/go/go-runtime.inc<br>
index 413cf6d..86539f2 100644<br>
--- a/recipes-devtools/go/go-runtime.inc<br>
+++ b/recipes-devtools/go/go-runtime.inc<br>
@@ -1,5 +1,5 @@<br>
&nbsp;DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"<br>
-DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"<br>
+DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"<br>
&nbsp;PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"<br>
<br>
&nbsp;DEBUG_PREFIX_MAP =3D "\<br>
--<br>
2.46<br>
<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span =
class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/693" =
target=3D"_blank">View/Reply Online (#693)</a> |


  <a =
href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%=
20%5Byocto-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%=
20depend%20on%20-crosssdk%20recipes" target=3D"_blank">Reply To =
Group</a>
 =20
    | <a =
href=3D"mailto:quaresma.jose@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20=
%5Byocto-patches%5D%20%5BPATCH%5D%20meta-lts-mixins%20kirkstone%2Fgo%3A%20=
depend%20on%20-crosssdk%20recipes" target=3D"_blank">Reply To Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/108225175/5052612" =
target=3D"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" =
target=3D"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612"=
 target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" =
target=3D"_blank">Contact Group Owner</a> |

<a =
href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052=
612/1504338242/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:quaresma.jose@gmail.com" =
target=3D"_blank">quaresma.jose@gmail.com</a>]<br>
</p><div width=3D"1" =
style=3D"color:white;clear:both">_._,_._,_</div><div><br =
class=3D"webkit-block-placeholder"></div><div><br =
class=3D"webkit-block-placeholder"></div></blockquote></div><br =
clear=3D"all"><div><br></div><span class=3D"gmail_signature_prefix">-- =
</span><br><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 =
Quaresma</div></div></div></div>
</div></blockquote></div><br></div></div></div></body></html>=

--Apple-Mail=_E9FF14AA-4ECD-49C9-8AA1-D9B3C8E33B9F--

