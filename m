Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB03F3C269
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:21:57 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15451.1773066115888131753
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 07:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WV6oVZLE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso7853185e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773066114; x=1773670914; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1lm5MAY6d9Z3ljXgUv+fM85XoPq9rQUmJSQ6LDFVWw=;
        b=WV6oVZLEKANwS7tUVJu2CXdalXBhRaimgAZ4NQviDvaXWVJ4VN4PnBHyE4ZhKPonq6
         8o8aam++o8O5n3SOZEtOBMaQI/ijx75akvGFvVACWl/Ht5EKeN9k/dZveJK1273Yw9qP
         mQPcJhIBXE9EGRpJ9lryNPGRJQ2WCmh5NeZdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066114; x=1773670914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1lm5MAY6d9Z3ljXgUv+fM85XoPq9rQUmJSQ6LDFVWw=;
        b=tnlrx7BgVdxh6EXfcLV3VyN8DBt/oVmfFFU3YbTM0nFkJ1rg+2xUmqwrWZ5DPXT9Sm
         zj638ZkQ6dxoFMYTVY1du4k5S+SahwW5xr9zE9bu49KPj+pRV9XOzvdLnR7/bkedSeXp
         bIrtGxr9qj88bJWABq9L8Q+2rKPzMd7eJWta/4CTsW0aSciu+Kgz63KLhIBuQzBJU2kO
         +MLmbWtPuKSIFFJekHDXuhz0khmmDrvhi3ic/YBGiFVLohxvYdGDvx2kMDcQ0xMgGD3B
         n00Dim//cvYIp5OmA2oZAT91fvSYkCTgk5UdPCA1CbPGZkkM4+UVk8ckVvzKWIkBWW/v
         DssA==
X-Gm-Message-State: AOJu0Yxh3hMb9Q5dYyHnxc59b1ZI7sZPGHMFgq60xSCqPnHDpYJR3Pr2
	8GSeBXVU2pnCIZ3Nzm/+V5Sle/qZSMHNrOG2I94LQ3lTa9wIBl2olwF01Zgxiej71BgSyL60GdV
	PMiGEZrI=
X-Gm-Gg: ATEYQzyNcDMEKIgGmqvUDQKqkSnqjHLGdVlD/pZCwxbj+i3LDbZCJVgMiHmZDG6nv5o
	vHWhYhcxam3sEIsb0Y+D5olFRNlxsvpMc0b4uy3IkI3Fq+F6baP1//QN2GZxOeYM6FPicEE8dP+
	5qTyXcRkgLXzACdI86xUazbHcRk23lhK/1xZfQ3E5tzzG5b9I2KWQ0ZGGvO1jsQe9d0XdMLilI0
	aGn5kYetovNFawMIh1b2kcvB0YleetXJGpCOWAsFX4lfqhpBN/q7AViyvFEKliJjshuSgc+FEXz
	Woltz/r+Ma3zUQoHu1WYEaDsYQVOtQghhyJBiZr/NOPtOH/GZLYHCVXQgQqq9THMv4eWMw+ZmLr
	IjA94/mDRokfl4XgLumsZ9ObkpfWftH6oOVAShEFe/whtxY+1llgom/hgwiWcENt0xVpdxVVMIv
	+gAQ9+59HiaALFcMNOwYBWhS/qfC49CbUi4+wXWx8YlNmn5agPXnbUH+GfVWKLuRwqGkcPkRMB5
	0t1VtsZMrB5uUU=
X-Received: by 2002:a05:600c:1e2a:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4852695d16fmr187153685e9.24.1773066113219;
        Mon, 09 Mar 2026 07:21:53 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:24aa:67b9:6ef1:bd24? ([2001:8b0:aba:5f3c:24aa:67b9:6ef1:bd24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48536150e61sm159373215e9.1.2026.03.09.07.21.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:21:52 -0700 (PDT)
Message-ID: <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 09 Mar 2026 14:21:51 +0000
In-Reply-To: <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
	 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 14:21:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3385

On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.org wrote=
:
>=20
> On 2/13/26 23:42, "Uwe Kleine-K=C3=B6nig wrote:
> > With SELinux enabled for the target it makes sense to have SELinux
> > support enabled for the native tools, too.
> >=20
> > Note that for native packages DISTRO_FEATURES is filtered, thus up to n=
ow
> > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIVE t=
o
> > make "selinux" propagate also to DISTRO_FEATURES for native packages.
> > ---
> > Hello,
> >=20
> > I use this on scarthgap, but the patch applies fine to master, too.
> >=20
> > During a debug session it took me quite a while to find out why
> >=20
> > 	ls -lZ "${IMAGE_ROOTFS}
> >=20
> > at the end of selinux_set_labels() didn't show the labels added by
> > setfiles.
> >=20
> > Best regards
> > Uwe
> >=20
> > =C2=A0 classes/enable-selinux.bbclass | 2 +-
> > =C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bb=
class
> > index 3dc61d6931ff..0c9f52e74cec 100644
> > --- a/classes/enable-selinux.bbclass
> > +++ b/classes/enable-selinux.bbclass
> > @@ -1,3 +1,3 @@
> > =C2=A0 inherit selinux
> > =C2=A0=20
> > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
> > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATURES', 'seli=
nux', d)}"
> > diff --git a/conf/layer.conf b/conf/layer.conf
> > index 4e04e5cc7e6a..ca981db57019 100644
> > --- a/conf/layer.conf
> > +++ b/conf/layer.conf
> > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
> > =C2=A0 "
> > =C2=A0=20
> > =C2=A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-targeted"
> > +
> > +# With target support for SELinux it is very helpful during debug when=
 the
> > +# native tools support SELinux, too.
> > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
>=20
> Can we add this to the doc (e.g. README) instead of enabling it directly=
=20
> in layer.conf? Since we haven't directly enabled DISTRO_FEATURES =3D=20
> "selinux" in layer.conf either.

I just wanted to add that putting that directly in layer.conf will mean
the layer isn't Yocto Project Compatible too.

Cheers,

Richard

