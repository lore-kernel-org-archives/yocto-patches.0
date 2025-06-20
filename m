Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B7C71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 12:53:27 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.7065.1750424005997988029
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 05:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C84/6wLF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453426170b6so17498425e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750424004; x=1751028804; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBL7H9nbQ1zP1Lw9uZHXQdS1ExFX8aWZMB+8/90OcOo=;
        b=C84/6wLFBbHhCHswU66bErp0LedhcEUOQahMiIKv072WVJ+yVJ0Pm0VBNcf/lr9Jza
         yB/pliIku3K/X14+FZjdtCMp1/h5TP+Qy+7pvPYG1BIiNQ9KKrSafrL5HHH85T+raWSz
         302R7TJxUIeM3xdYFsH1GnS3P44XvK7z2LGlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424004; x=1751028804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBL7H9nbQ1zP1Lw9uZHXQdS1ExFX8aWZMB+8/90OcOo=;
        b=t9ZQvU5aMDjGunfrOYY/ise9QRoN2o8GWGYmHg0AjLAs0kQDyIGynq8Lygk0NjB8/W
         Ujw9vLM/A4DxYXIomiTMcCMvvK6kb9xjOHxtiAHr5A6SX4GR5jzoQqFi+o9+Y4ob9UCj
         JLVN5OSol1gHazcWcaJnYXYeRc8Le65JK/teEd/R3yJxP3X5bKA0BIGTLd50xQDbFC8x
         wa0JUEic8cwwsEX1g0Oh6fpSh5KZSwnx+HjtrVtkOOd+2ak5jnqtXoI0+Bl+s4vloWZv
         qg3WDi73kOKK+8q0V2GOD05fl1p3YkzIwAUDuz1bz8X1U+0jsLrCBEo109gRcLgXd+0O
         ig9g==
X-Gm-Message-State: AOJu0YzG9Gzu7jAPYHbnyFcWFAGvnly/mUdL1MDrCkgf/5TZ3iH+O5BB
	q1cjpLTdHLR9Woxezceiwj3+Fr8LJkbu787nLhCNgo7A5t+MF32YSpp6oelS8TFhiTaxBPjlo+r
	xp74w0SA=
X-Gm-Gg: ASbGncvhoXuZI3sRytFtXyh41OwHSJrFjGDt/vlhmcWRMDFB7y7jDeTlN+Nm6Kd/Dx5
	hyfT+EhgDiwcDVrIGi757o5Bl46/HMTb2xMmny6M9zsw4tCIhTwCMCAIrL1J57EQ3VcAr5cKVVL
	cnp17nWxoWIOMdS1KLPHjl+5vlsdK55rIsEpZkUX9W1qh5wogeJp5+ytzlxpey4j8LFPdtBoj3g
	zC8OyPiUCfOx5+Jaon1YcUvPxQP2Ma5BGvTEA7F2R1K7ou+T2sLRpH4KPmGq+2z0aNu+XM+hSvB
	oxeGSuzW8jA4AFQjH7Ku7mxOCtKnxfgZw7mmfe+STuG/dWRMC/4fM0/+jCm3DtSv60YdQacY6lc
	XKmshT8PRVZbNFFkULRGMcw1gMJG7ZH9/Ep6I3H6F0gBlspY2S7E=
X-Google-Smtp-Source: AGHT+IE7lWF57llQhs7aNIrFmryuzZx01d24lbhmbRnHu6aK3iOx/k7B3XtXWhPzYTqqrFPwreyEtQ==
X-Received: by 2002:a05:6000:2010:b0:3a3:598f:5a97 with SMTP id ffacd0b85a97d-3a6d2799df4mr1760937f8f.9.1750424003892;
        Fri, 20 Jun 2025 05:53:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b606:370e:6752:7b3d? ([2001:8b0:aba:5f3c:b606:370e:6752:7b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97abf6sm58242935e9.6.2025.06.20.05.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:53:23 -0700 (PDT)
Message-ID: <ed969abc22a74d5153083a0a596b5f7020bd26cc.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-mingw] [PATCH 2/2] layer.conf: Update to
 whinlatter release series
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Date: Fri, 20 Jun 2025 13:53:22 +0100
In-Reply-To: <466956ae-7eee-4f2b-9912-28686d756338@gmail.com>
References: <20250620120810.2480232-1-richard.purdie@linuxfoundation.org>
	 <20250620120810.2480232-2-richard.purdie@linuxfoundation.org>
	 <466956ae-7eee-4f2b-9912-28686d756338@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 12:53:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1673

On Fri, 2025-06-20 at 14:10 +0200, Gyorgy Sarvari via
lists.yoctoproject.org wrote:
> On 6/20/25 14:08, Richard Purdie via lists.yoctoproject.org wrote:
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0conf/layer.conf | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/conf/layer.conf b/conf/layer.conf
> > index 9fb0473..0a00dd3 100644
> > --- a/conf/layer.conf
> > +++ b/conf/layer.conf
> > @@ -16,5 +16,5 @@ addpylib ${LAYERDIR}/lib oeqa
> > =C2=A0
> > =C2=A0LAYERDEPENDS_meta-mingw =3D "core"
> > =C2=A0
> > -LAYERSERIES_COMPAT_meta-mingw =3D "walnascar"
> > +LAYERSERIES_COMPAT_meta-mingw =3D "whimlatter"
> >=20
> Typo: whiMlatter

Well spotted and fixed, thanks. It also came up during testing.

Cheers,

Richard

