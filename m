Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CECAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 14:24:14 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.15190.1757341452827736602
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Sep 2025 07:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bXciqLu8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so38419355e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Sep 2025 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757341451; x=1757946251; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KOOYXuKO0SRYEwM3pON+R1UT+r1ye3l/ig+euHl+Nyg=;
        b=bXciqLu8eYezzfLb3KJGHKREqQw2z8rkatw9k2Thxv0BOTwT+XFviDfx/RWgXD9THQ
         mPkrWA0bTCmJGswouTBq/gCh6YwFPPV1pPt6twMcEXOeh2hY87cjI6tBzzEMElUTzQRo
         r0XDHrkJzDZ0FNEOKHFeVS8U5cQ7R3BCiQPq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341451; x=1757946251;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOOYXuKO0SRYEwM3pON+R1UT+r1ye3l/ig+euHl+Nyg=;
        b=mBymu8rF8PaZJBQCmWVvDBxFw6Y6HiEp5E7z/xQTC+zCo44gf3rv7vWzn1YyfhxjN4
         yawIb/mR0wf6qi8ZjWCFresNIN6sFM+FCOrEKhU9li17C8iXoZbBGfk4LlvDdw+6tJT2
         +edPTAetwArMA+BYF2VYeSJaAnlL/kHqNsJFS//oSmXeSsT37BTgDVxTeTSwgUxVs9St
         IuLRpRPUMt9QbMK0w06r7Meqa6WPMhk0qheuXp9WwmHCkMLtSItZqkNLqZp/INU2UJNd
         tmP4+gx/NsiaLdwD80OC+hLIf4F8QjMpuzhTAFp50MW84FECFijrNn+xbXkcQRYLpC2k
         /txw==
X-Gm-Message-State: AOJu0Yyj1Qey3dEuiJiBKIxspQWDCg2RpOJQDp3muisMPUo6HcIT6UDm
	o8dt8FQRZ/HlsVlPf/hxwGUHcgqKgNGZqd+9vGkC+Yjv2KzacwEiGFnvjvBfqj1V1ssZ/y+BnwW
	blIOb
X-Gm-Gg: ASbGncv9gX4ttG1j/FHMemv0GESb9sTS9kABSaaY4H8NAaRtcig2asmyZZTmu/0Xi6M
	gTeclZM+5YQNeyXshRWS387365Cs4FmJBLtVjI/PqKuXEzRkNczotVBS8RbX/RoRz5yeVFBYgko
	lFePvRKjXlcIRtPB2Tupu4UE7v4biIo5hgP04oj4WZ7XDTtGGIV07x7anUcU5dy7fQBdA+CKn+t
	YVTNEw+FR4WllV3djvNDetOjby4gRioKSVQyKP+pJFQd3LMeeGsrYEeWvda7kOuElHfcaDiCRmQ
	Bbb+O+Y/pV/LwS9J8cunYpnNqV0YCotZ/jG5Kpm9TF42eYmidBHYoZatW0XoedNySCZLvAwHK0K
	BGidQSEJAupOGuIg7zZXnLnwJsxd+6A7dHEwiiVi4v0p77ndwcSOy61qRS4fkFB57raiErXykUb
	GNMhDPiWUpBY3lbfTigheg6Q==
X-Google-Smtp-Source: AGHT+IF1HFRSnK2ZhZ2tiUGbyj2+T8x6JzpWi/8htJlv7pv24/pK/XSTxn+mXlmiXmeivJHEtU+fUw==
X-Received: by 2002:a05:600c:4fc5:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-45dddea5200mr78143095e9.11.1757341450784;
        Mon, 08 Sep 2025 07:24:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2892:3aae:20fe:dbc0? ([2001:8b0:aba:5f3c:2892:3aae:20fe:dbc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm448159015e9.12.2025.09.08.07.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:24:10 -0700 (PDT)
Message-ID: <d6f02c8cba213acdce5b0ec41704d265ab5ea9d8.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2 0/3] runconfig: Add
 build configuration as properties
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>
Date: Mon, 08 Sep 2025 15:24:09 +0100
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
References: 
	<20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Sep 2025 14:24:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2146

On Thu, 2025-09-04 at 17:48 +0200, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> It was recently brought to my attention that the "Build properties" tab
> on buildbot could contain more data. One is the build configuration,
> such as MACHINE or DISTRO, the other is about the poky-ci-archive tag
> that is automatically created on a-full and a-quick builds.
>=20
> This series aims to improve a bit the situation, by extracting DISTRO,
> MACHINE, SDKMACHINE and PACKAGE_CLASSES from the config.json file
> describing builds configuration, and adding them as build properties.
> More properties can be added if any appears to be useful.
>=20
> It also stores poky-ci-archive tag as well as a web git URL in
> "poky-ci-archive_tag" and "poky-ci-archive_url" properties, on a-full
> and a-quick builds, copied to all sub-builds. I'm not convinced by the
> need to have both properties, so I'm open for any feedback.
>=20
> This series has a dependency on run-config modifications, in
> yocto-autobuilder-helper git [1].

The challenge is we have to patch all helper branches we're still using
when we make a change like that, which makes this kind of change a lot
harder to merge.

Cheers,

Richard

