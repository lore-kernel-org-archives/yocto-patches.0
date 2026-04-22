Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A7CFA1FCF
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 16:13:23 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86554.1776874399461435067
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 09:13:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Q2wNCacC;
 spf=pass (domain: snapchat.com, ip: 209.85.128.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so51360585e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 09:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776874397; cv=none;
        d=google.com; s=arc-20240605;
        b=b+Lmw53xKhpIompSPXAfVYQ2bAr3IOEmfoVpd5i5jd4T+1q3HZc1ZSqovTrQqcalL/
         Y+f7B835qztI54xaQnr1ObcCYQdslOJfnfHUlbdt+ZBqjv9CYao6BazmIIB52J0ytKaR
         /Se/CTXKZVe2adLaZJi+OgaKFkZUESEb4pXJGEaVfSCeUlIrJnjRzCm0DBxswCyL9Odl
         Z6NpU3w1+i09nrHTU6GTIktzrdNP6FiAoCOpvxP/tH+ZECHx+Yyzr5/RaNDM2OX2IVy1
         4OYeYrGvdbdzGZNqpfYGYYi85dSMt7rzDbmNI0tWDM72zum9/FhhLJcedVHGkAOa7X5o
         Kd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=lPxL/zAoav32xCLmExID2FbO7sen3+oTq0Bq+H8OLTs=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=Ov0BdJp2sS3ba+zRIDG2m/+nBMCDcNgDSZKy759vG2zR1WENJnSi0X9gTWgeP8UBEc
         C6KVLIxmas/kKpteFhD8HYuVoQ72/8l/rQY18NlqI/N1wA4qeEZZOvZSVZBeV33KF+dU
         2xhPedVgS/0HPRBK3lPdbHSHxGVEx7Qz5U1L93RJpaaQJ9Ih52+BEJBpBNZbFFJnrjzr
         N1witeGF4DgcE+s2JsnmjUJ07QVTV3Bu4lJKbWIBLTGa/XRiDYQBSS4mZFZJehHFoowP
         7rn2UR+nQyEQ2UYixgv774f5T+ym2BKSkAseH0SQNcCWaidocEMmIzDzNFaOqBTIUtkL
         fvEA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1776874397; x=1777479197; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPxL/zAoav32xCLmExID2FbO7sen3+oTq0Bq+H8OLTs=;
        b=Q2wNCacCHHeoVmArv1lF2j5R0oqN8snX+8Qumcq0xZbBp7nicw7bQWf/Oxog3fYhd+
         N3P4uZwUIlO2KFfSG+9cG06aVtS5yJXwlH4VpzyXRZ8U9+IFy15CWurSZc5+iTkbAbiC
         5y0ppoBbKFMIE4NOPNKSNUQwuGJzEW6WzmrQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874397; x=1777479197;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPxL/zAoav32xCLmExID2FbO7sen3+oTq0Bq+H8OLTs=;
        b=hwVxUZ1R3bX11XztITx6bh7sV7uZZmR6ut0kD4R6vyVwrNaZwhVDBa6tNwwEbSMrM5
         X8/wxxWxurEutB1pGtXzPJj4Wd2TpnBCPEM2JWVR/RQ1jxB+ugFJryACaENq4BWlwI+I
         y28T1jI+KJ/JhjVkuqdwA1gnApEK5/AzcNcV9pDBLPenW93vf1V3TS4Vvd+2Nz+sL14O
         fmJr/AKHHXHHPolAo04CD3B6Zg8wKORyEcO9hA/b1Fyi/1xuXUHoEWj9kuCcXOidg7z8
         9pV0SGtKHAbqLo32AZXi0zqVq1aWkG9OwIg+HfzYSzXO0powtTDT1YPtxWNUXsxh7QZ6
         mD7A==
X-Gm-Message-State: AOJu0YyttN8OKawP8WtYVZYbxl5/ekPyC7BL03swzlOTjHsJYUmEbzmv
	qTbRdXzH9C/w5kqIgR24h04UbhSNLPQqgucI2Qj7oD3k2W9dRyWazg19GBTKDpGWjO8na8At0Uz
	arfA8CxK7IPV+S6Iwu1MjsIhAR4FKJkwSpopXYo/BsgApbE6fQJIkkKM=
X-Gm-Gg: AeBDievS/FIzaAxlm1483p0bXq411b6fcW/AOjED/Qfa9HgmByn2ei+h4+qiJkz5M/a
	1L+JcCnBLmsUUBULmnSmrE9iqHM65hj6g4slCGiAbKIUlwSXvo4Ifpk6b+SdP93bAg+gDgRRStB
	n7+p3fTPJqp/33EjSfqryxHUM5XD1j1T0s6QJd2BUwWHQyT6a9wH5XDTcXas5tot6r9gVV91Ry2
	dBVV4yWYJt/HWJ3pIz/l2ApZYRhFzf9+tImnu1VSxvEa+omENz5XdkzwzrlxrY5TI+p+I/zkhzo
	klpoNFFPIn9/ZvQ8ZGyz9mQCmY55+FiYEIP8iRlVxbC4bIE3AQ==
X-Received: by 2002:a05:600c:5246:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-488fb750a1dmr330197405e9.11.1776874397097; Wed, 22 Apr 2026
 09:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260414073920.4112974-1-ecordonnier@snap.com>
In-Reply-To: <20260414073920.4112974-1-ecordonnier@snap.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 22 Apr 2026 18:13:05 +0200
X-Gm-Features: AQROBzD1Q79QIbZy8jeL-hMHU1Qu00eulES4DFCPnYg5ErvpVhRxMLOYeSsF7TE
Message-ID: <CAHUKmYY8GCZ445FiYkq-W4zzuw4mK6BS--M1Xy3Ah0LGmFcfrQ@mail.gmail.com>
Subject: Re: [meta-selinux][PATCH] refpolicy_common: enable PARALLEL_MAKE
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004007e406500ecf3c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 16:13:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3762

--0000000000004007e406500ecf3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

now that this patch is in the master branch, can you please cherry-pick
this patch to the scarthgap branch as well?

Thanks
=C3=89tienne

On Tue, Apr 14, 2026 at 9:39=E2=80=AFAM <ecordonnier@snap.com> wrote:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> Using parallel make threads speeds up the build.
>
> This line was added in
> https://git.yoctoproject.org/meta-selinux/commit/?id=3D1139c40cb687deefdd=
c31c5fbc8ab61f3d50402f
> in 2012.
>
> The parallel build of refpolicy was fixed in 2014 in commit "Fix parallel
> build of the policy":
> https://github.com/SELinuxProject/refpolicy/commit/c1c11fa2f8ca03d47adaf3=
1bca4b257459448c19
>
> I've tested a build of core-image-full-cmdline with yocto master branch a=
s
> well as a custom image and it seems to work without issues.
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  recipes-security/refpolicy/refpolicy_common.inc | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc
> b/recipes-security/refpolicy/refpolicy_common.inc
> index 2e1a929..014714c 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -103,8 +103,6 @@ PACKAGE_ARCH =3D "${MACHINE_ARCH}"
>
>  inherit python3native
>
> -PARALLEL_MAKE =3D ""
> -
>  DEFAULT_ENFORCING ??=3D "enforcing"
>
>  POLICY_NAME ?=3D "${POLICY_TYPE}"
> --
> 2.43.0
>
>

--0000000000004007e406500ecf3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>now that this patch is in the master branch, ca=
n you please cherry-pick this patch to the scarthgap branch as well?<br><br=
>Thanks<br>=C3=89tienne</div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 14, 2026 at 9:39=
=E2=80=AFAM &lt;<a href=3D"mailto:ecordonnier@snap.com">ecordonnier@snap.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" targe=
t=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
<br>
Using parallel make threads speeds up the build.<br>
<br>
This line was added in <a href=3D"https://git.yoctoproject.org/meta-selinux=
/commit/?id=3D1139c40cb687deefddc31c5fbc8ab61f3d50402f" rel=3D"noreferrer" =
target=3D"_blank">https://git.yoctoproject.org/meta-selinux/commit/?id=3D11=
39c40cb687deefddc31c5fbc8ab61f3d50402f</a> in 2012.<br>
<br>
The parallel build of refpolicy was fixed in 2014 in commit &quot;Fix paral=
lel build of the policy&quot;:=C2=A0 <a href=3D"https://github.com/SELinuxP=
roject/refpolicy/commit/c1c11fa2f8ca03d47adaf31bca4b257459448c19" rel=3D"no=
referrer" target=3D"_blank">https://github.com/SELinuxProject/refpolicy/com=
mit/c1c11fa2f8ca03d47adaf31bca4b257459448c19</a><br>
<br>
I&#39;ve tested a build of core-image-full-cmdline with yocto master branch=
 as well as a custom image and it seems to work without issues.<br>
<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0recipes-security/refpolicy/refpolicy_common.inc | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc<br>
index 2e1a929..014714c 100644<br>
--- a/recipes-security/refpolicy/refpolicy_common.inc<br>
+++ b/recipes-security/refpolicy/refpolicy_common.inc<br>
@@ -103,8 +103,6 @@ PACKAGE_ARCH =3D &quot;${MACHINE_ARCH}&quot;<br>
<br>
=C2=A0inherit python3native<br>
<br>
-PARALLEL_MAKE =3D &quot;&quot;<br>
-<br>
=C2=A0DEFAULT_ENFORCING ??=3D &quot;enforcing&quot;<br>
<br>
=C2=A0POLICY_NAME ?=3D &quot;${POLICY_TYPE}&quot;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000004007e406500ecf3c--

