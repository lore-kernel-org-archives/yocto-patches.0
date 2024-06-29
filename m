Return-Path: <joe@deserted.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7AC27C4F
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 14:27:00 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web11.6756.1719671218566763182
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 29 Jun 2024 07:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@deserted-net.20230601.gappssmtp.com header.s=20230601 header.b=f6Cw12GE;
 spf=none, err=permanent DNS error (domain: deserted.net, ip: 209.85.219.182, mailfrom: joe@deserted.net)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0365588ab8so1133939276.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 29 Jun 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deserted-net.20230601.gappssmtp.com; s=20230601; t=1719671217; x=1720276017; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZtQXgHvIZQyssjHH2XeLnd33/5UoEbjivoQhb74sHY=;
        b=f6Cw12GEVeVNe7yhOfC3W5gzf+flHaxzN4B6UPo7V054baizZG9tz1s6e1/C8QSoG9
         l93rRCn+ZOP7eK+aN29b36w+CIbwDvoB0HhLVS7ysgUF4j+sr/0C0reKAsDx0uyOiDHW
         JHsTZk7dt3bs52l6odquoWA+Klmt05xVmIP+gI6B3gYZiuQT0IyawCZmDSzx7c+eBALH
         /U0Ge1Co22WRZV7qaoxyumsoIElLTNLYQAJ5qYPpIuhH2CBuDBTb36xGAvnC1iYD/Afa
         eP86ZkIPmeOcangKEc7oIiXgdx8l1eCo/sL3NSbJqARDovXkVXmjE6gwQBV20J6QAnga
         RONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719671217; x=1720276017;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZtQXgHvIZQyssjHH2XeLnd33/5UoEbjivoQhb74sHY=;
        b=tcA3zCwWXGm0E8zgE5l5NV63ksQUhAFqhcEhaa0ietQck6uzcKIWA3VyLSrD/agiFy
         Woh19IxI4PAxTwhx8fwyrKPqT+oZR2Obf2XE8yLsr7hUPO/r78sVERk5zmYWjZpXYEsA
         tHJF6WWj7HBg1LxNoOZk3DTl2ZTkBKrrAf9GZRya3FjJQfDhDbngTz2Q9Ru1gqCpYtQI
         NOnjs38UkhOcXPuY/O+juNtdHyZw6LgDhg9vu7+TXQR5/Qcs19n/8JgFCJR2naS6n1rf
         H+PB4y9B7VTgY4ig3lvNCbrJhHHSoeEIC3dpdqEqYyYpmXSqQt1yg/MpOw6lFqXbuaZ9
         64WA==
X-Gm-Message-State: AOJu0YzMnz2BAGhCdChOIlpAh4LXCu0HdZx1fClNo6ddPPqdhZrQWHfL
	J0uJYPtD8ZiWI+2pgzW3GZY0MG1+jQtUgOJfl+xUwXpRPiKEs69WyT291u4htm1R8hdnNttXU8O
	T04ECEoqBZI7T1Da6dK2aMbcP2caZG0xuFH58AUXX3PODErru1g==
X-Google-Smtp-Source: AGHT+IHxkT7aJpEqneNsN1z9Ahd+YTUfxKEOY8df70lOWELsF1tw8Flnbd4v1Kar9z1WkSoAkVBlAX/8vM3Lb2f6DKo=
X-Received: by 2002:a5b:545:0:b0:dfa:57a2:3b10 with SMTP id
 3f1490d57ef6-e036ec8bd85mr812741276.61.1719671217072; Sat, 29 Jun 2024
 07:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <17D213B141A57C32.4692@lists.yoctoproject.org> <17D2140E51A07FE0.4692@lists.yoctoproject.org>
 <CAHUKmYYbXydmQC78rJVRmrVOC1wQBrVzGbJNWDhTK11VOYUONQ@mail.gmail.com>
In-Reply-To: <CAHUKmYYbXydmQC78rJVRmrVOC1wQBrVzGbJNWDhTK11VOYUONQ@mail.gmail.com>
From: Joe MacDonald <joe@deserted.net>
Date: Sat, 29 Jun 2024 10:26:48 -0400
Message-ID: <CANBf+V3ZL_LMru3JbcEe1dLZy6nZzzDDFCnZu+jCXJKGYY3Duw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] selinux-python: make GPLv3
 dependency optional
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000064d13061c0828d2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 29 Jun 2024 14:27:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/394

--000000000000064d13061c0828d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi =C3=89tienne,

Sorry about that, Yi and I had a brief discussion about it, it'll be merged
today with the other patches in the queue.

Thanks,
-Joe.

On Thu, Jun 27, 2024, 04:36 Etienne Cordonnier via lists.yoctoproject.org
<ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrote:

> Hi,
> what is the status of this patch?
>
> Thanks,
> =C3=89tienne
>
> On Thu, May 23, 2024 at 11:27=E2=80=AFAM Etienne Cordonnier via
> lists.yoctoproject.org <ecordonnier=3Dsnap.com@lists.yoctoproject.org>
> wrote:
>
>> Hi, note that another way to implement this is  RRECOMMENDS=3D"binutils"
>> in the recipe, and BAD_RECOMMENDATION+=3D"binutils" for users of the lay=
er
>> who want to disable the dependency. I used the PACKAGECONFIG way since i=
t
>> makes it clearer which functionality gets disabled IMO:
>> PACKAGECONFIG:remove:pn-selinux-python-sepolicy =3D "sepolicy-generate"
>>
>> =C3=89tienne
>>
>> On Thu, May 23, 2024 at 11:21=E2=80=AFAM Etienne Cordonnier via
>> lists.yoctoproject.org
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.yoctoprojec=
t.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNo=
nVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZ=
MNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DzCOxOsLdY4YpzCCow8OlIHj3Hm80Yh7Wa3HD1T2=
L8Ok&e=3D>
>> <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrote:
>>
>>> From: Etienne Cordonnier <ecordonnier@snap.com>
>>>
>>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>>> ---
>>>  recipes-security/selinux/selinux-python_3.6.bb
>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython=
-5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzL=
xFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZP=
uaCOJQKs&e=3D>
>>> | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-security/selinux/selinux-python_3.6.bb
>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython=
-5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzL=
xFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZP=
uaCOJQKs&e=3D>
>>> b/recipes-security/selinux/selinux-python_3.6.bb
>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython=
-5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzL=
xFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZP=
uaCOJQKs&e=3D>
>>> index 79125d0..faf5d28 100644
>>> --- a/recipes-security/selinux/selinux-python_3.6.bb
>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython=
-5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzL=
xFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZP=
uaCOJQKs&e=3D>
>>> +++ b/recipes-security/selinux/selinux-python_3.6.bb
>>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython=
-5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAh=
kbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzL=
xFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZP=
uaCOJQKs&e=3D>
>>> @@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage =3D "\
>>>          audit-python \
>>>          ${PN} \
>>>  "
>>> +PACKAGECONFIG ??=3D "sepolicy-generate"
>>> +PACKAGECONFIG[sepolicy-generate] =3D ",,,"
>>>  RDEPENDS:${PN}-sepolicy =3D "\
>>> -        binutils \
>>> +        ${@bb.utils.contains('PACKAGECONFIG', 'sepolicy-generate',
>>> 'binutils', '', d)} \
>>>          python3-core \
>>>          python3-codecs \
>>>          python3-distro \
>>> --
>>> 2.36.1.vfs.0.0
>>>
>>>
>>>
>>>
>>>
>>>
>>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#387)
> <https://lists.yoctoproject.org/g/yocto-patches/message/387> | Reply To
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3A%20make%20GPLv3=
%20dependency%20optional>
> | Reply To Sender
> <ecordonnier@snap.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches=
%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3A%20make%20GPLv3%20de=
pendency%20optional>
> | Mute This Topic <https://lists.yoctoproject.org/mt/106905395/1150288> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/1150288> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13405315/1150288/15=
96567232/xyzzy>
> [joe@deserted.net]
> _._,_._,_
>
>

--000000000000064d13061c0828d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi =C3=89tienne,=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Sorry about that, Yi and I had a brief discussion abo=
ut it, it&#39;ll be merged today with the other patches in the queue.=C2=A0=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,=C2=A0</div><div=
 dir=3D"auto">-Joe.=C2=A0<br><br><div class=3D"gmail_quote" dir=3D"auto"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 27, 2024, 04:36 Etienne Cor=
donnier via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.or=
g</a> &lt;ecordonnier=3D<a href=3D"mailto:snap.com@lists.yoctoproject.org">=
snap.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi,<br>what is the status of this patch?<br>=
<br>Thanks,<br>=C3=89tienne</div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, May 23, 2024 at 11:27=E2=80=AFAM Etienne=
 Cordonnier via <a href=3D"http://lists.yoctoproject.org" target=3D"_blank"=
 rel=3D"noreferrer">lists.yoctoproject.org</a> &lt;ecordonnier=3D<a href=3D=
"mailto:snap.com@lists.yoctoproject.org" target=3D"_blank" rel=3D"noreferre=
r">snap.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi, note that another wa=
y to implement this is=C2=A0<span style=3D"color:rgb(31,35,40);font-family:=
-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;=
,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Em=
oji&quot;;font-size:14px">=C2=A0RRECOMMENDS=3D&quot;binutils&quot; in the r=
ecipe, and=C2=A0</span><span style=3D"color:rgb(31,35,40);font-family:-appl=
e-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helv=
etica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&q=
uot;;font-size:14px">BAD_RECOMMENDATION+=3D&quot;binutils&quot; for users o=
f the layer who want to disable the dependency. I used the PACKAGECONFIG wa=
y since it makes it clearer which functionality gets disabled IMO:<br></spa=
n>PACKAGECONFIG:remove:pn-selinux-python-sepolicy =3D &quot;sepolicy-genera=
te&quot;<br><span style=3D"color:rgb(31,35,40);font-family:-apple-system,Bl=
inkMacSystemFont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Arial=
,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-s=
ize:14px"><br>=C3=89tienne</span></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, May 23, 2024 at 11:21=E2=80=AFAM E=
tienne Cordonnier via <a href=3D"https://urldefense.proofpoint.com/v2/url?u=
=3Dhttp-3A__lists.yoctoproject.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0=
hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m=
67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgx=
p&amp;s=3DzCOxOsLdY4YpzCCow8OlIHj3Hm80Yh7Wa3HD1T2L8Ok&amp;e=3D" target=3D"_=
blank" rel=3D"noreferrer">lists.yoctoproject.org</a> &lt;ecordonnier=3D<a h=
ref=3D"mailto:snap.com@lists.yoctoproject.org" target=3D"_blank" rel=3D"nor=
eferrer">snap.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Etienne Cordonnier &lt;<a hre=
f=3D"mailto:ecordonnier@snap.com" target=3D"_blank" rel=3D"noreferrer">ecor=
donnier@snap.com</a>&gt;<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank" rel=3D"noreferrer">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">selinux-python_3.6.bb</a> =
| 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-security/selinux/<a href=3D"https://urldefense.proofpo=
int.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9=
TsRih1DULJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4k=
CNbCpjYWhGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&a=
mp;e=3D" rel=3D"noreferrer noreferrer" target=3D"_blank">selinux-python_3.6=
.bb</a> b/recipes-security/selinux/<a href=3D"https://urldefense.proofpoint=
.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbC=
pjYWhGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=
=3D" rel=3D"noreferrer noreferrer" target=3D"_blank">selinux-python_3.6.bb<=
/a><br>
index 79125d0..faf5d28 100644<br>
--- a/recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><=
br>
+++ b/recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><=
br>
@@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audit-python \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${PN} \<br>
=C2=A0&quot;<br>
+PACKAGECONFIG ??=3D &quot;sepolicy-generate&quot;<br>
+PACKAGECONFIG[sepolicy-generate] =3D &quot;,,,&quot;<br>
=C2=A0RDEPENDS:${PN}-sepolicy =3D &quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 binutils \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, =
&#39;sepolicy-generate&#39;, &#39;binutils&#39;, &#39;&#39;, d)} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-core \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-codecs \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0python3-distro \<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div>




<p></p><p></p></blockquote></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/387" targ=
et=3D"_blank" rel=3D"noreferrer">View/Reply Online (#387)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%=
3A%20make%20GPLv3%20dependency%20optional" target=3D"_blank" rel=3D"norefer=
rer">Reply To Group</a>
 =20
    | <a href=3D"mailto:ecordonnier@snap.com?subject=3DPrivate:%20Re:%20Re%=
3A%20%5Byocto-patches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3=
A%20make%20GPLv3%20dependency%20optional" target=3D"_blank" rel=3D"noreferr=
er">Reply To Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/106905395/1150288" target=3D=
"_blank" rel=3D"noreferrer">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank" rel=3D"noreferrer">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/1150288" =
target=3D"_blank" rel=3D"noreferrer">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank" rel=3D"noreferrer">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13405315/11=
50288/1596567232/xyzzy" target=3D"_blank" rel=3D"noreferrer">Unsubscribe</a=
>

 [<a href=3D"mailto:joe@deserted.net" target=3D"_blank" rel=3D"noreferrer">=
joe@deserted.net</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div></div></div>

--000000000000064d13061c0828d2--

