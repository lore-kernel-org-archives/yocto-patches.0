Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F60AC61DC2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 11:35:14 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34052.1787830507783982823
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Aug 2026 04:35:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HiPA4HXP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so5313425e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787830506; x=1788435306; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wNbUc+MAMbxkR3PN85X9S+cWio6iNSCcDENA73KIpNc=;
        b=HiPA4HXPr5VjtjCqZY0dv3eHZEyLCFCNaFPQAAnLsDStMcuCZh2suxiXaGqXpW3nfE
         HP5pl2wPXWNY4jGmJJClG+ST9N4KFXwLlz1BvDOyt0cLAfZLrtWshM/J4WEjpsraJ49B
         NAwpNGHm5YLPl5BZJJwcOu3b3CCf7BBaqnGmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787830506; x=1788435306;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNbUc+MAMbxkR3PN85X9S+cWio6iNSCcDENA73KIpNc=;
        b=qRADZ8Ku/L5PNa6Q2+6qL+vW1xwrpB8HzMxmfIKuQu3Nk4II9/klhEeUGJzTg/TSzm
         JOG/fLNMMtZ0cQQmnkd3qM/+VvcAkTew3NMT9c/LQwaLVwZdkFKQMdk1p13ACX7+zIgo
         dXdRqyySiJEfViXv9OBzK6PI4RuyHbx2qVtHrbhv0pr4E9J1LESLcP1Vx/fq9Ri3EkCB
         FuMOgUjzHyd/UDCsll3E3VKrKRZajit6cptdFhBx34johDkAea1hQqk+ZfApv21WlSmQ
         wwMo5ssU/C5QR1yau7UCME1gv6vQn44XDsOLl8GiIznbt4J25XYOrXMVZ5UsD1/jZ6g6
         yiZQ==
X-Gm-Message-State: AFuF++lMFrGMIHh+VruNtvMaH1W9dvlEmls3qCn0hIXHp4G2xz8FimPw
	kHIvMYL+033xrATNoEFwPhUivG1SZHVk4uZe94Pserzb2eGCX8OZMkG3tfeG0P9xEGFT1AWB0Hj
	fB3eS7OE=
X-Gm-Gg: AR+sD13wa6dolroSJG8I8fJx8d6+0K3eK91OLSMcsXSH6nKEixJ30mjhrG8JLeyKE7q
	DlKDlnDlGCLyU4HVKetlrUCjvNQX7aoIt08SSQ90Kj6nHh0iKg6ILHQAe9Z5K+LHGQuKHYSpsMD
	TTbjBN8muDIxQGDC92W5OskkPZjx+SO0Q/IBgHFCAfz3uiZSJtR38Y1OnnPdfDyY/mvvadLulb7
	MzPT/u0RAwbyUZ0F5oVzD01teObOpvvqGXnlCjhn1F6RwP9i93lxC9G0lyAbu621TWjeDevcJIF
	ImRQ7soF/hg9RvK0y/m7qIhZL/Y/JosaM+1P6M33jdGQKmce7HHoVutmQ7EjoyoYBhz7GGnW9mj
	C/03iJDuWtjzLPSFuK5D+a2zkMeFxOEHHG1Edxp3eSumiJxr4bGHr6qYdpYYOlmO2iFVvgq1Wx3
	rkmtv64MUNZlq1vGJiAwJEsxAUWTyQqXOkb+sPPdWhFgxBIf5+I5nQo+5X2rwbKaYPn+DTrLbAP
	p1cbBOO1syzROCOkSK9cFNlhLnpRcUtPMy+fnGYfIfAMI2/rY2CFTv2+hfOrQ==
X-Received: by 2002:a05:600c:1c06:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49b8f5e52b1mr28072125e9.3.1787830505886;
        Thu, 27 Aug 2026 04:35:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:297a:6cb9:3a6b:fc8? ([2001:8b0:aba:5f3c:297a:6cb9:3a6b:fc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4b3ccafesm38196305e9.15.2026.08.27.04.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:35:05 -0700 (PDT)
Message-ID: <b7d24922bec85c242c580ab7dd321a8a084f5685.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] config: add
 mixin-wrynose-linux-firmware repo to a-full
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 27 Aug 2026 12:35:04 +0100
In-Reply-To: <20260827084028.1896945-1-yoann.congal@smile.fr>
References: <20260827084028.1896945-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 11:35:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4710

On Thu, 2026-08-27 at 10:40 +0200, Yoann Congal via lists.yoctoproject.org =
wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> Without this, meta-qcom/wrynose does not find
> mixin-wrynose-linux-firmware in the shared repos archive[0]:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Copying in repo mixin-wrynose-linux-firmware (1787813774.7)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > tar: ./mixin-wrynose-linux-firmware: Not found in archive
> > tar: Exiting with failure status due to previous errors
> > Traceback (most recent call last):
> > =C2=A0 File "/srv/pokybuild/yocto-worker/meta-qcom/yocto-autobuilder-he=
lper/scripts/shared-repo-unpack", line 71, in <module>
> > =C2=A0=C2=A0=C2=A0 subprocess.check_call(["tar", "-I", "zstd", "-C", ta=
rgetsubdir, "-xf", "%s.tar.zst" % args.cache_dir, "./" + repo])
> > =C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0 File "/usr/lib/python3.14/subprocess.py", line 420, in check_cal=
l
> > =C2=A0=C2=A0=C2=A0 raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['tar', '-I', 'zstd', '-C', '/s=
rv/pokybuild/yocto-worker/meta-qcom/build/repos', '-xf', '/srv/autobuilder/=
repos/a-full-4593.tar.zst', './mixin-wrynose-linux-firmware']' returned non=
-zero exit status 2.
>=20
> [0]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/113/builds/=
1490
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> =C2=A0config.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/config.py b/config.py
> index 615c5ae..6058a9a 100644
> --- a/config.py
> +++ b/config.py
> @@ -8,7 +8,7 @@ baserepos =3D ["bitbake", "oecore", "meta-yocto", "yocto-=
docs", "poky"]
> =C2=A0# Repositories used by each builder
> =C2=A0buildertorepos =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 "a-quick": baserepos + ["meta-intel", "meta-ming=
w", "meta-gplv2"],
> -=C2=A0=C2=A0=C2=A0 "a-full": baserepos + ["meta-intel", "meta-mingw", "m=
eta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-=
virtualization", "meta-clang", "meta-qcom"],
> +=C2=A0=C2=A0=C2=A0 "a-full": baserepos + ["meta-intel", "meta-mingw", "m=
eta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-=
virtualization", "meta-clang", "meta-qcom", "mixin-wrynose-linux-firmware"]=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 "non-gpl3": baserepos + ["meta-gplv2"],
> =C2=A0=C2=A0=C2=A0=C2=A0 "meta-mingw": baserepos + ["meta-mingw"],
> =C2=A0=C2=A0=C2=A0=C2=A0 "meta-oe": baserepos + ["meta-openembedded"],
>=20

This implications of doing this are significant, for example master
might start shipping releases with a tarball of mixin-wrynose-linux-
firmware unless we make further changes. We probably need to find
another way to make this work :/

Cheers,

Richard

