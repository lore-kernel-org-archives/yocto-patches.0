Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD860C3DA49
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 09:03:20 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.39919.1721725396708239229
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 02:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DrT8Zz3C;
 spf=pass (domain: snapchat.com, ip: 209.85.218.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a81bd549eso41159266b.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1721725395; x=1722330195; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOugWpV0HVYX4UQISngbo4/0o8miNgt4HJt0teLq1yE=;
        b=DrT8Zz3CSyJx24bakwplBjpLKSPrvAeZpeI2hx5obPLAXCRvbWChWek8qEQLTybsn0
         +bTSmx8Ujit+eOk4o1hrSwyZVheMmWzqVvAxoeQEq1YEzfTcKJaApewe4LGejrRS0y1l
         cZftYF4y3U568C2FUP77yYyPkQyRn1LkPwv5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725395; x=1722330195;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOugWpV0HVYX4UQISngbo4/0o8miNgt4HJt0teLq1yE=;
        b=odc6FHk3YNuOv/Ank8tFKqdrgGJBiB8w2hSIB3lh0LkqriKdcHPbJBIiUqkXC4kCZa
         q9tZoZCXbBADqUp8/oaDiQiNP3jO9otPZk59RD5A5Tc7jhy8VXGgOEw65zQnbjGswYy1
         NNMxUBvqw7LRSiaYgojTYsIRMWRfh+BysHGmIxNCIkYp1nqxTvtRx3gpQdz88Ky8Tq1B
         OSSmLJOST5lBcqPvtPZ3wC2JpW8dvXIrhVabwPHu0DNCGd+RH9Fjs9IeSV6S0W7sEUWc
         KUb1P1vexmsoybBcit/zxHWYawjeZShuPdMemJkenpORqyVnP553jzjgv3c4eAZ+cGQz
         aY6w==
X-Gm-Message-State: AOJu0Yxg1l75L8ay6BQbCuk/U/lU4rFiYSXdCIvh+yh83fJhRh5z9xby
	yFjyPw3CfRjtb/Dj36OVGhCcQoYuDsAQ8/hs4u/jUTYnd8A+mco0IIjLJr0uvAmO6r/rmYzceL9
	AkqHnM9JPWe90mJ38JK3z20Eiu49RU4TC2yXDs/PG20yDAygCO80=
X-Google-Smtp-Source: AGHT+IFjd75nU4oA0DnZUAU5ggODXUJ3LdRFiu4IFxLutNkA1Q+bjn88rkTyw2BkPX5PryRRF7TwYeqWCVKuhZt6WAE=
X-Received: by 2002:a17:906:c10f:b0:a77:e1fb:7dec with SMTP id
 a640c23a62f3a-a7a87c7fb85mr169069866b.17.1721725394428; Tue, 23 Jul 2024
 02:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240621121239.594152-1-ecordonnier@snap.com> <17DB03E840849069.21660@lists.yoctoproject.org>
In-Reply-To: <17DB03E840849069.21660@lists.yoctoproject.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 23 Jul 2024 11:03:03 +0200
Message-ID: <CAHUKmYZkhvYbZ2CHhcssOvvxCstYUiarssxt51UOEZnwr_t-Sw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] README: remove outdated section
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000089a53b061de66ec7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 09:03:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/445

--00000000000089a53b061de66ec7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
what is the status of this patch?

Thanks,
=C3=89tienne

On Fri, Jun 21, 2024 at 2:13=E2=80=AFPM Etienne Cordonnier via
lists.yoctoproject.org <ecordonnier=3Dsnap.com@lists.yoctoproject.org> wrot=
e:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> After commit
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yoctoproject.o=
rg_meta-2Dselinux_commit_-3Fid-3D9e986d7d794f044464e1af914ddbcd57d8f1c2e9&d=
=3DDwIDAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnPtDbT=
g9EpKZww-5ivSdyDUgg6QtAw&s=3D9fSbog0BXi2LxT5R5eu74CVFm4ccFNsm8l91UY99Uj4&e=
=3D
> ,
> it is not possible any more to choose a different version os the
> refpolicy, and
> only the git version is maintained.
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  README | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/README b/README
> index ce91cc1..ae011f3 100644
> --- a/README
> +++ b/README
> @@ -47,22 +47,6 @@ to be tailored for your environment.
>  e.g. PREFERRED_PROVIDER_virtual/refpolicy ?=3D "refpolicy-mls"
>
>
> -Using different versions of refpolicy
> --------------------------------------
> -To prepare selinux enabled images using different ver. of refpolicy,
> -we can choose supported releases of refpolicy
> -refer to available versions under recipes-security/refpolicy
> -
> -We can use the refpolicy directly from git repository instead of release
> tarballs.
> -By default refpolicy from git builds head commit of master branch, we ca=
n
> update
> -SRCREV for refpolicy and refpolicy-contrib as appropriate at
> refpolicy_git.inc
> -to check refpolicy as per required commits.
> -
> -* enable the preferred refpolicy-minimum:
> -PREFERRED_VERSION_refpolicy-minimum =3D "2.20151208"
> -PREFERRED_VERSION_refpolicy =3D "2.20151208"
> -
> -
>  Using different init manager
>  ----------------------------
>  By default selinux enabled images coming up with "sysvinit" as init
> manager,
> --
> 2.36.1.vfs.0.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#363):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_363&d=3DDwIDAg&c=3DncDTmphkJTvjIDPh0hpF_4vCH=
vabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DghRU=
j7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&s=3DfmzST4Tt2E=
W8c27U7m6lI-asg1ezZXJ_cegjtgo6jX0&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_106797251_7048771&d=3DDwIDAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DghRUj7zLxL9M5=
QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&s=3DeeClF7tFzqtJ_OpkpWu=
YQFP0WhwFycFy0M_7Y2cJCqw&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIDAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5i=
vSdyDUgg6QtAw&s=3DluJTf111dZRNsoW2B_ZV9sgVlo9GMV5U8KaMU1oYMlI&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000089a53b061de66ec7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>what is the status of this patch?<br><br>Thanks,<br=
>=C3=89tienne</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Jun 21, 2024 at 2:13=E2=80=AFPM Etienne Cordonnier via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;e=
cordonnier=3D<a href=3D"mailto:snap.com@lists.yoctoproject.org">snap.com@li=
sts.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonn=
ier@snap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
<br>
After commit<br>
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yocto=
project.org_meta-2Dselinux_commit_-3Fid-3D9e986d7d794f044464e1af914ddbcd57d=
8f1c2e9&amp;d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&=
amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5Qi=
O1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3D9fSbog0BXi2LxT5R5=
eu74CVFm4ccFNsm8l91UY99Uj4&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">h=
ttps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yoctoproject.org_=
meta-2Dselinux_commit_-3Fid-3D9e986d7d794f044464e1af914ddbcd57d8f1c2e9&amp;=
d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkb=
NonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5QiO1MsNgP7HUMj=
XOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3D9fSbog0BXi2LxT5R5eu74CVFm4ccF=
Nsm8l91UY99Uj4&amp;e=3D</a>=C2=A0 ,<br>
it is not possible any more to choose a different version os the refpolicy,=
 and<br>
only the git version is maintained.<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0README | 16 ----------------<br>
=C2=A01 file changed, 16 deletions(-)<br>
<br>
diff --git a/README b/README<br>
index ce91cc1..ae011f3 100644<br>
--- a/README<br>
+++ b/README<br>
@@ -47,22 +47,6 @@ to be tailored for your environment.<br>
=C2=A0e.g. PREFERRED_PROVIDER_virtual/refpolicy ?=3D &quot;refpolicy-mls&qu=
ot;<br>
<br>
<br>
-Using different versions of refpolicy<br>
--------------------------------------<br>
-To prepare selinux enabled images using different ver. of refpolicy,<br>
-we can choose supported releases of refpolicy<br>
-refer to available versions under recipes-security/refpolicy<br>
-<br>
-We can use the refpolicy directly from git repository instead of release t=
arballs.<br>
-By default refpolicy from git builds head commit of master branch, we can =
update<br>
-SRCREV for refpolicy and refpolicy-contrib as appropriate at refpolicy_git=
.inc<br>
-to check refpolicy as per required commits.<br>
-<br>
-* enable the preferred refpolicy-minimum:<br>
-PREFERRED_VERSION_refpolicy-minimum =3D &quot;2.20151208&quot;<br>
-PREFERRED_VERSION_refpolicy =3D &quot;2.20151208&quot;<br>
-<br>
-<br>
=C2=A0Using different init manager<br>
=C2=A0----------------------------<br>
=C2=A0By default selinux enabled images coming up with &quot;sysvinit&quot;=
 as init manager,<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#363): <a href=3D"https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_363&amp;d=
=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjX=
OJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3DfmzST4Tt2EW8c27U7m6lI-asg1ezZX=
J_cegjtgo6jX0&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldef=
ense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dp=
atches_message_363&amp;d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkIC=
C2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRU=
j7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3DfmzST4=
Tt2EW8c27U7m6lI-asg1ezZXJ_cegjtgo6jX0&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_106797251_7048771&amp;d=3DDwIDAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZ=
ww-5ivSdyDUgg6QtAw&amp;s=3DeeClF7tFzqtJ_OpkpWuYQFP0WhwFycFy0M_7Y2cJCqw&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_106797251_7048771&amp;d=3D=
DwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjXOJR=
3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3DeeClF7tFzqtJ_OpkpWuYQFP0WhwFycFy0=
M_7Y2cJCqw&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIDAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5=
QiO1MsNgP7HUMjXOJR3DrnPtDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3DluJTf111dZRNsoW=
2B_ZV9sgVlo9GMV5U8KaMU1oYMlI&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIDA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DghRUj7zLxL9M5QiO1MsNgP7HUMjXOJR3DrnP=
tDbTg9EpKZww-5ivSdyDUgg6QtAw&amp;s=3DluJTf111dZRNsoW2B_ZV9sgVlo9GMV5U8KaMU1=
oYMlI&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--00000000000089a53b061de66ec7--

