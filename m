Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC099CCF2CA
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 08:53:19 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31808.1768812796807351826
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 00:53:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O9vNOcYC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so37472925e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 00:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768812795; x=1769417595; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q1dLMzov02/DKMKQX7lZ8ejUqwgzzeO3Fwzqke98n1E=;
        b=O9vNOcYC1LFmfPeXoHbR9mkQ65Wd6T1dDQNWuGX0O1kjn+l+kRSlbx2kZbn2Hl+zyi
         m/Mq+9x3O7IPj/HTkOGu1Dsw1MQQbcn94rKFAUyF/EV7OiH1nys1YIpMi+xojzX9kg3a
         qwKrNjdCiv949CX/ptwMWSyBNWSMaju3KEDHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812795; x=1769417595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1dLMzov02/DKMKQX7lZ8ejUqwgzzeO3Fwzqke98n1E=;
        b=LXZvBupo+aHcr80gCBZF3W3gHLPaap0Gi0zqfeCwPmLd0CswJjzaArDdpicbondgi2
         rxURhhpT/V+osvAtbT+eeEg7AjY+a+ZYPa8dNMVfzf92PrTtzHv+YOQHXlyyFRem4Ow7
         4ppNUA652/pR8GxYSA4+VTv0YMX/AWKrgdpVs2ViahEpBDWZc9XlviG8tXlVIK/HC7RM
         a7IvOT+ASI2GSMkWaAoIiDa0rGliXAnaLmo7JimsxWvPwaTNuNqD7FEBpyWF/sb3+kmQ
         rrdqamZnJpDwVchuHq2fjMg9fCI+Gskb8Zl+HzwfK0GsvQ4vWiJvqehnlPTlpZS3lNc/
         uJ0Q==
X-Gm-Message-State: AOJu0YymZF2FMO32xYBs+1tF/q9iU2TEYXY3sPdKMvAlwrr/VfQ9Ahg0
	Q0E7SAqew7uxsJceHgJ0UTGLVW9N5zrWrXh//e9QOvPAHhgnU38x8AdZizjPQqsp381/wxz33Hx
	UuValcqo=
X-Gm-Gg: AY/fxX5FOR83kBMq2g49XWW9gH++LbM4Q5Ulle5sgDGQbRZ+qS32owYOSSIRuasEO83
	BxdnLQ2b9qGEpRfZiM68BijMpZSKQ8lxwDLK2qILI+ynWzTrdcjOVrW3BFX5CHPg6jMSTfeUJZ4
	S/PBUA/5etdUtfapwNai5+UIN9kTZrzXSixuMB+1i4bYKna8zI8gcvM38WpE+uFzS43dG7Eobd3
	/pM8zYvpyuZEuMk4LiNSLF4VPlUeJbjO3TdnMKkeRbZf/P6altGy+JH5CjwZlNJ4U52WA20W2uz
	QJ18pfpuim6tPDAqjRBHt8MOkuKkTu50QBqIQpv+Oy+AQ5uyLJKLhP/uYOCaiP2pR0cxac1qtrR
	miI9S8QBA4pC9vJE3uXO4afyUUAPH5+3AAoUwOFzTsMK39bHT4OVCz0jpNsNxgZoJZ1mZYex66j
	8LtW1Y5MPjRgPumgiun0wP1Zpa0Zr/MA7omEbjaDOKKCf2z6kgSpZGGk8+7kDcuPD9RbpUEQpGP
	O0=
X-Received: by 2002:a05:600c:8597:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-48024c9525bmr78141515e9.20.1768812794666;
        Mon, 19 Jan 2026 00:53:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7cb0:ccc0:c4cf:d0a1? ([2001:8b0:aba:5f3c:7cb0:ccc0:c4cf:d0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb2asm21938438f8f.37.2026.01.19.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:53:13 -0800 (PST)
Message-ID: <c232e9f1078adaf155f7c0c7ad74a8665737df0e.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] config.json:
 rename qemux86-64 builders to contain "-64"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Antonin Godard
	 <antonin.godard@bootlin.com>
Date: Mon, 19 Jan 2026 08:53:13 +0000
In-Reply-To: <20260119-qemux86-64-builds-rename-v1-1-1509a9431c02@bootlin.com>
References: 
	<20260119-qemux86-64-builds-rename-v1-1-1509a9431c02@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:53:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3008

On Mon, 2026-01-19 at 09:43 +0100, Antonin Godard via lists.yoctoproject.or=
g wrote:
> It can be confusing as some builds are also named qemux86-<something> for
> the "qemux86" machine. Rename these two qemux86-64 to begin with
> "qemux86-64-".
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> =C2=A0config.json | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

I do agree it is confusing but it isn't this simple, you need to rename
in autobuilder2 and in every branch of autobuilder-helper. Things like
the results output then change too :/

It did used to actually build qemux86, we changed that as it didn't
make sense but I worried about the renaming of the target on the
autobuilder. I'm not sure whether that was in kirkstone or not.

Cheers,

Richard

