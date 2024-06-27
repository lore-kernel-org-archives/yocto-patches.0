Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026FC2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 08:36:31 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.3426.1719477384306909576
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Jun 2024 01:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=b0V6Uf+R;
 spf=pass (domain: snapchat.com, ip: 209.85.218.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72510ebc3fso656361866b.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1719477382; x=1720082182; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCqvkRKmjFmXHWksHk7LKVeUzdsaOg/l5H/Y88RoZmc=;
        b=b0V6Uf+R0+mEJ4/tUxBNxkP2afXRSC1L/rz0iEPMO4iXKIhCz1RgtWcRz433Vxee+6
         NYBIDC5mRlLs46DgTjCCf1lFFYr4XVAv02IBCybhscNUjibU1nBiKrRkZBWM+0FLwYuf
         mfLRKBimc+zQtSu2TOvn+d6rATc7B/Rr+16tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719477382; x=1720082182;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCqvkRKmjFmXHWksHk7LKVeUzdsaOg/l5H/Y88RoZmc=;
        b=MarJKrlmHDedRSyY/zP7reMRWQOdAXHICk9B7cx4tDzqm7yoBamJY3qkl/NKyqNVme
         fDciBYB7tbLbqLrbqv9RXLXapy3d5WozVUL8wybc+M/EaG67obBnT+SMFFyS9JxlgHKM
         r+nDsjvjxYTHNy+PXQA8R9DqJvgSzuWlCxJMH3L3H9lxoae9Adt5lqB8jv/F+cfeUCAS
         EeFJHnMpRXecKx8kWOlwk388su+H7eNsC+MBFDc8YrtR5YzgMZ4BzLXbn7YT4Y0PrlZy
         pYxb/9WSBJLss7Q4bZgIV+1g3jMA5x/i2GYAb4umXTlxO0W4bO/DHx/5pTGynsQBEtg/
         4o2g==
X-Gm-Message-State: AOJu0Yx+kO2q71RPasXqIAYlUzF0RVxdtCWB7inf9JPUbB780YC7zrM0
	VmqHsR1MXdEjWvd0AN//dMxmp5zJ2xT8Jny90YqtILaW9YTDoVDEpdLoZjvG/I7OVdEsDuX36Fx
	YMQfZEreQ5Bu+nIFBQZ9BUK9loRMuZ4owl8SS33u/a8xIvwlo+CHbWw==
X-Google-Smtp-Source: AGHT+IF6OMHlB9OrynQv8blupCd3vK6UoMbo+xKVQJmA1ZOB2KHn/LeTMRw3B3s9oYd539C1nku2ZmxqWLsEnVTHLwc=
X-Received: by 2002:a17:906:ca14:b0:a6f:b75f:3d46 with SMTP id
 a640c23a62f3a-a7242c4b89fmr1050589566b.43.1719477382097; Thu, 27 Jun 2024
 01:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <17D213B141A57C32.4692@lists.yoctoproject.org> <17D2140E51A07FE0.4692@lists.yoctoproject.org>
In-Reply-To: <17D2140E51A07FE0.4692@lists.yoctoproject.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 27 Jun 2024 10:36:11 +0200
Message-ID: <CAHUKmYYbXydmQC78rJVRmrVOC1wQBrVzGbJNWDhTK11VOYUONQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] selinux-python: make GPLv3
 dependency optional
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000008f56c6061bdb06ae"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 08:36:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/387

--0000000000008f56c6061bdb06ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
what is the status of this patch?

Thanks,
=C3=89tienne

On Thu, May 23, 2024 at 11:27=E2=80=AFAM Etienne Cordonnier via
lists.yoctoproject.org <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrot=
e:

> Hi, note that another way to implement this is  RRECOMMENDS=3D"binutils" =
in
> the recipe, and BAD_RECOMMENDATION+=3D"binutils" for users of the layer w=
ho
> want to disable the dependency. I used the PACKAGECONFIG way since it mak=
es
> it clearer which functionality gets disabled IMO:
> PACKAGECONFIG:remove:pn-selinux-python-sepolicy =3D "sepolicy-generate"
>
> =C3=89tienne
>
> On Thu, May 23, 2024 at 11:21=E2=80=AFAM Etienne Cordonnier via
> lists.yoctoproject.org
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.yoctoproject=
.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNon=
VuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZM=
Ng7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DzCOxOsLdY4YpzCCow8OlIHj3Hm80Yh7Wa3HD1T2L=
8Ok&e=3D>
> <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrote:
>
>> From: Etienne Cordonnier <ecordonnier@snap.com>
>>
>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>> ---
>>  recipes-security/selinux/selinux-python_3.6.bb
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-=
5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLx=
FkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPu=
aCOJQKs&e=3D>
>> | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-security/selinux/selinux-python_3.6.bb
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-=
5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLx=
FkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPu=
aCOJQKs&e=3D>
>> b/recipes-security/selinux/selinux-python_3.6.bb
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-=
5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLx=
FkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPu=
aCOJQKs&e=3D>
>> index 79125d0..faf5d28 100644
>> --- a/recipes-security/selinux/selinux-python_3.6.bb
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-=
5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLx=
FkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPu=
aCOJQKs&e=3D>
>> +++ b/recipes-security/selinux/selinux-python_3.6.bb
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-=
5F3.6.bb&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLx=
FkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPu=
aCOJQKs&e=3D>
>> @@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage =3D "\
>>          audit-python \
>>          ${PN} \
>>  "
>> +PACKAGECONFIG ??=3D "sepolicy-generate"
>> +PACKAGECONFIG[sepolicy-generate] =3D ",,,"
>>  RDEPENDS:${PN}-sepolicy =3D "\
>> -        binutils \
>> +        ${@bb.utils.contains('PACKAGECONFIG', 'sepolicy-generate',
>> 'binutils', '', d)} \
>>          python3-core \
>>          python3-codecs \
>>          python3-distro \
>> --
>> 2.36.1.vfs.0.0
>>
>>
>>
>>
>>
>>
>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#177)
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_message_177&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvU=
iXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DDCVuET1XO=
MUydX_uQyyQOOjB48wBdkv-iqH0Tl769-I&e=3D>
> | Reply To Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3A%20make%20GPLv3=
%20dependency%20optional>
> | Reply To Sender
> <ecordonnier@snap.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches=
%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3A%20make%20GPLv3%20de=
pendency%20optional>
> | Mute This Topic
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_mt_106259298_7048771&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkIC=
C2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sV=
Hk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3D-iyNi9UljHjA5rLQs9=
B3ZkRTOPuZcwAex9nV7q4-IEs&e=3D>
> | New Topic
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_post&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-=
sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DiwjqA6svYEujPJBM=
_rJg9RPBcVJZeggsqrlNmnxYBqE&e=3D>
> Your Subscription
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_editsub_7048771&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF=
_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=
=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&s=3DDIU=
CI-n9Ij_gWQCIUAJM3gRqYNBYHEZmvUyKWHLjozY&e=3D>
> | Contact Group Owner <yocto-patches+owner@lists.yoctoproject.org> |
> Unsubscribe
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoprojec=
t.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwMFaQ&=
c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjY=
WhGSSEhk43Xgxp&s=3D-JmoyURmgnC4ffGLNj7jgar4IOYcaqnoBBLB20TCFv0&e=3D>
> [ecordonnier@snap.com]
> _._,_._,_
>
>

--0000000000008f56c6061bdb06ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>what is the status of this patch?<br><br>Thanks,<br=
>=C3=89tienne</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, May 23, 2024 at 11:27=E2=80=AFAM Etienne Cordonnier vi=
a <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;=
ecordonnier=3D<a href=3D"mailto:snap.com@lists.yoctoproject.org">snap.com@l=
ists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Hi, note that another way to implemen=
t this is=C2=A0<span style=3D"color:rgb(31,35,40);font-family:-apple-system=
,BlinkMacSystemFont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Ar=
ial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;fon=
t-size:14px">=C2=A0RRECOMMENDS=3D&quot;binutils&quot; in the recipe, and=C2=
=A0</span><span style=3D"color:rgb(31,35,40);font-family:-apple-system,Blin=
kMacSystemFont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Arial,s=
ans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-siz=
e:14px">BAD_RECOMMENDATION+=3D&quot;binutils&quot; for users of the layer w=
ho want to disable the dependency. I used the PACKAGECONFIG way since it ma=
kes it clearer which functionality gets disabled IMO:<br></span>PACKAGECONF=
IG:remove:pn-selinux-python-sepolicy =3D &quot;sepolicy-generate&quot;<br><=
span style=3D"color:rgb(31,35,40);font-family:-apple-system,BlinkMacSystemF=
ont,&quot;Segoe UI&quot;,&quot;Noto Sans&quot;,Helvetica,Arial,sans-serif,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px"><br=
>=C3=89tienne</span></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, May 23, 2024 at 11:21=E2=80=AFAM Etienne Cordon=
nier via <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__l=
ists.yoctoproject.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Ds=
vUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&amp;s=3DzCO=
xOsLdY4YpzCCow8OlIHj3Hm80Yh7Wa3HD1T2L8Ok&amp;e=3D" target=3D"_blank">lists.=
yoctoproject.org</a> &lt;ecordonnier=3D<a href=3D"mailto:snap.com@lists.yoc=
toproject.org" target=3D"_blank">snap.com@lists.yoctoproject.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Etien=
ne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank"=
>ecordonnier@snap.com</a>&gt;<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a> | 4 +++-<br=
>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-security/selinux/<a href=3D"https://urldefense.proofpo=
int.com/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9=
TsRih1DULJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4k=
CNbCpjYWhGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&a=
mp;e=3D" rel=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a> b/r=
ecipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com/v2/url=
?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvj=
IDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkS=
Ga66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk=
43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D" rel=3D=
"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><br>
index 79125d0..faf5d28 100644<br>
--- a/recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><br>
+++ b/recipes-security/selinux/<a href=3D"https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__selinux-2Dpython-5F3.6.bb&amp;d=3DDwMFaQ&amp;c=3DncDTm=
phkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DU=
LJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYW=
hGSSEhk43Xgxp&amp;s=3DixJG_H5bJU1GGqRFcKTAK2WyQXKt0wsSdZPuaCOJQKs&amp;e=3D"=
 rel=3D"noreferrer" target=3D"_blank">selinux-python_3.6.bb</a><br>
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


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoc=
toproject.org_g_yocto-2Dpatches_message_177&amp;d=3DDwMFaQ&amp;c=3DncDTmphk=
JTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJT=
KUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGS=
SEhk43Xgxp&amp;s=3DDCVuET1XOMUydX_uQyyQOOjB48wBdkv-iqH0Tl769-I&amp;e=3D" ta=
rget=3D"_blank">View/Reply Online (#177)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%=
3A%20make%20GPLv3%20dependency%20optional" target=3D"_blank">Reply To Group=
</a>
 =20
    | <a href=3D"mailto:ecordonnier@snap.com?subject=3DPrivate:%20Re:%20Re%=
3A%20%5Byocto-patches%5D%20%5Bmeta-selinux%5D%5BPATCH%5D%20selinux-python%3=
A%20make%20GPLv3%20dependency%20optional" target=3D"_blank">Reply To Sender=
</a>
 =20

|

  <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.y=
octoproject.org_mt_106259298_7048771&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDP=
h0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa6=
6m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43X=
gxp&amp;s=3D-iyNi9UljHjA5rLQs9B3ZkRTOPuZcwAex9nV7q4-IEs&amp;e=3D" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.y=
octoproject.org_g_yocto-2Dpatches_post&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjI=
DPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSG=
a66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk4=
3Xgxp&amp;s=3DiwjqA6svYEujPJBM_rJg9RPBcVJZeggsqrlNmnxYBqE&amp;e=3D" target=
=3D"_blank">New Topic</a>

<br>




<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoc=
toproject.org_g_yocto-2Dpatches_editsub_7048771&amp;d=3DDwMFaQ&amp;c=3DncDT=
mphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1D=
ULJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUzlzLxFkZMNg7mIpG4kCNbCpjY=
WhGSSEhk43Xgxp&amp;s=3DDIUCI-n9Ij_gWQCIUAJM3gRqYNBYHEZmvUyKWHLjozY&amp;e=3D=
" target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoc=
toproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp=
;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DsvUiXAGWL-sVHk8x8ZsNqyXZUz=
lzLxFkZMNg7mIpG4kCNbCpjYWhGSSEhk43Xgxp&amp;s=3D-JmoyURmgnC4ffGLNj7jgar4IOYc=
aqnoBBLB20TCFv0&amp;e=3D" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@sna=
p.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--0000000000008f56c6061bdb06ae--

