Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6085.1792498687936635140
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 05:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=zw9WzcC3;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1df146015so18922235e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1792498686; x=1793103486; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aZkTyglaVuV3omFISLHAPpcvu8fluZnDRGhNnm2ygZY=;
        b=zw9WzcC30ndwZqAWmlsOMVNvuIu1UvHoVGk/RthZ1qjDiOpucD+Sz76CJNaLp7njIZ
         QCH0GjDoTcpg9QLIo/bDBDCzSpBHnTng3l0TqV6mMiEcd6JkX3Acnx08xtZI03G8bd9h
         XI54vEHOYklsyNKJXHNEtYmz/7FUuTj7W5FFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498686; x=1793103486;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZkTyglaVuV3omFISLHAPpcvu8fluZnDRGhNnm2ygZY=;
        b=UkHwsOZ4EKLRiU5QWOdnFTMSTMC9yeLpZ7Dgi00RR6+acTKRPoVyphtEswLgMrSP+L
         VOH0O0wHAadhj3VXOtDQcjj2xg354U8Q85iGVTEOW2XEj2jErbD4W/ls/ZIbUBPKM+6d
         VER48vT5NPgSF3q6ASEfMFujqlXLbB7O9ewwFQRGGL5OxsWXeyy6idhP4GghF/cyUQJx
         Ajrcmc96O/7ZPu0D67PuO1XV6IbW2X3/g8AJZaKspAygppsGkpCqICg/xOdfsNR8IKUG
         hjIXRtjm9AFn2m/L0DwebZjfXmaoZIGaixBbTtDpWrzUpinq+qC29DqfPx97tQNtUu6G
         rW8A==
X-Gm-Message-State: AFq9FYIm4fEZFxELu2ioGwnOf6wC2dvbqUdmGNMSdEm4DXMJa0+cvHun
	jTEqPtwTjFvNC6u3tUWcTjkpkR1ONnBqg+103eB0HJZC4+lSKfjf0zh+skdb3ULC4m7Liqp5bDd
	Xo/D9Nv4=
X-Gm-Gg: AYBFou1ztjMTbpk1rVuoXdJtsvVDLD2TzLawiiDcDzgvl7bP3hzeohZ6GfVYVmlGXGU
	HqtVuO5ay6sUas57dO67jWn3Nr/WPIOQm6l3+9YdmXoPLemXqvLFlAQlvCNeIsFQ7S3FOeN3r9x
	FPXZVgHqHxclB1ZV1qNyzSHRwZuC0LwPlWk4Xm66L7HkwSO7Uh+0BGjOFp0IXj981ehYIsp7FEs
	Mz5QOXZIvCi/4Fw736QSLD9si+dqUtnu2mm3h4UmWKMwWC3thzzdRwWK4G/k0lk6uPNdBIP7O/G
	vSCT9Bi+W2ez7YyjVfwS3CTknOHq3Qjg48BqvglyfW4CAE7IQGehs+S2jB/BEZpZXjkQb85zny+
	1r701SmyA8v/ki6JQBlocJsq4ZzaaOTlH4iG7z1oEeLKpJOlsCtQJj44azQeat0lJem8a0+YwSq
	m+ZUbfcTMsbWmRH5S7vT3dimEZu4GRggB5Lc5rQWQkn/qZxIWy7SL7VrfA+DiMPYvURWI3o7q9Z
	6m9c92HDXmegkF6VocNqWmon/1VSx1Uu6fZBls/7CHk0S91HAIGvATLMOA=
X-Received: by 2002:a05:600d:4447:20b0:4a1:d483:559b with SMTP id 5b1f17b1804b1-4a1d7612bbdmr166875985e9.24.1792498685461;
        Tue, 20 Oct 2026 05:18:05 -0700 (PDT)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm68902825e9.14.2026.10.20.05.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:18:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 14:18:04 +0200
Message-Id: <DM9NR3QJDKUO.22INDNPCK9Q4K@smile.fr>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] schedulers: Fix
 meta-meta-agl branch for wrynose
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Jan-Simon Moeller"
 <jsmoeller@linuxfoundation.org>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20261020-mathieu-agl-wrynose-v1-1-f1bc4f908055@bootlin.com>
In-Reply-To: <20261020-mathieu-agl-wrynose-v1-1-f1bc4f908055@bootlin.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 12:18:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5110

On Tue Oct 20, 2026 at 1:46 PM CEST, Mathieu Dubois-Briand via lists.yoctop=
roject.org wrote:
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  schedulers.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/schedulers.py b/schedulers.py
> index 5577f5b6fbe2..2bfc36ed4439 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -94,6 +94,7 @@ branchdefaults =3D {
>      'wrynose': {
>          'branch': 'wrynose',
>          'branch_bitbake': '2.18',
> +        'branch_meta-agl': 'master',
>          'branch_meta-arm': 'wrynose',
>          'branch_meta-aws': 'wrynose',
>          'branch_meta-clang': 'wrynose',
>
> ---
> base-commit: 8cc2acaac17df5a15f7c58a330cf30e4a7132d7b
> change-id: 20261020-mathieu-agl-wrynose-fe466d82d3bc
>
> Best regards,

Nitpick: Small typo in title meta-meta-agl -> meta-agl

Regards,
--=20
Yoann Congal
Smile ECS

