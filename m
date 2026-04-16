Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653AF8D75A
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 15:43:19 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17695.1776354192705114797
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 08:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SRziW1je;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2323496f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776354191; x=1776958991; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNwZD34Z3m5/I0Q7wUDCJ7NEnNB7ZmNVS9Iqi/mMSdA=;
        b=SRziW1jeoSx08lZhNECW+lndDyRT6iXV//GTCihcahpfeVqK01EGZ35/+sRADKADjU
         7sZvFM17DWi+AnegbPwXVNZJc1wKbn3lyOceeex9gv6OpowCLlZ1r/QbwT8GH8iX6q7i
         iKJ0R0X40zCOZwSP37WcQaFrScyZ/il+ZpZaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354191; x=1776958991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNwZD34Z3m5/I0Q7wUDCJ7NEnNB7ZmNVS9Iqi/mMSdA=;
        b=ZEKBZzwvJtmQTEfm37QnocwjfBbtbPc4GFhCgfHEV5wSvxNY+Al0elgr8XnAZzp4LU
         NLCB8k9RoQRnfYf3MZ7FRpmA8OfHebCLVq1bIELYN7eBccdbB9GFdrP2ma2zbasQhr0s
         NeL8nlbus2WVNSifeaq1VX9mJj7ELF/ot6adP+2Mnmx6dGihfCWrzlyvzkS+ZDAboKlz
         nJpIIzeNcOaGMo6TeIjDgJ9xChLscDx+K8VDcGOKz5eD8yHEekT5iTi8VjoKknmssnXp
         3C7KLuA6smUjIOZP5QvvS4dxLxAs9qxnOcFun/F5BTmr8n7ABukQmSjgKQdeynEG2/2/
         VCrg==
X-Gm-Message-State: AOJu0Ywm+AIV7AY/PqWmLo/W2N1VMHdk7sYRb4DdD1A0L4SAOSRiF3w1
	IzUW0aQBXi7utlEE5cKmrwbHUo9nnD0KkDf4zKIPD8VVtaP/CaAGQMTOUFqpAkv9YiEgzFYmadY
	hsA6ICHg=
X-Gm-Gg: AeBDietx1/56fLb4xT6dU2u+oo5WFtXOKCXy1NYYmxxs498pcf5FBJboKdOc8hhiEcD
	q3MMVWvlAVzAKrLVmTSGSoYBkZUR3yDeEtRnIWm6fgnKS5KlZvFefBpE5UImNkVMyagNhiK6I9+
	vhzTxQHcebcGHtFxbkkJGZau31GOf+mzTUsJf/VoqQ/OQ5WwLrynlof+eJaD9duAyH9pQkR3K/b
	EyPiYfyX+IfVcrreRPIwldrMi5izxtaVLV98hkMfbqxb2f5DFzWz/ljz4GB5douhaWW54p2HASg
	qBlmc+ne63IzfTRyJYMSNU/NtfHiJ4+6P5K1VIAAo+cXMrSrn5QZOkOkpGSH0AR17FMjnvVu192
	fUJVB8/cA4Ox/HxxIgDffQOYZzaQjkT/nbiKyer2I17HQJA6hukUiT20IjHaPB+Tq1cQdMXpgIV
	dEp0gk3jq+Zxc0XZX2/FUUC2W4ZehWZj1S15N4th2H5WCrAnZ1LDHAF940P0aTVOKqhp21piCfM
	H+7oH23SRyM0tRu+klySbGr/KKswUFJ0DDSGQ==
X-Received: by 2002:a05:6000:25c4:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-43d64271215mr43352940f8f.17.1776354190428;
        Thu, 16 Apr 2026 08:43:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9444:ba74:dc4b:e8c7? ([2001:8b0:aba:5f3c:9444:ba74:dc4b:e8c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6e9sm14538324f8f.1.2026.04.16.08.43.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:43:09 -0700 (PDT)
Message-ID: <3ac212e2eb03e20e559ffb387af332dc98e1e18a.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][whinlatter 0/5]
 Patch review
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Thu, 16 Apr 2026 16:43:09 +0100
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 15:43:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3724

On Thu, 2026-04-16 at 09:07 +0200, Yoann Congal via lists.yoctoproject.org =
wrote:
> The following changes since commit
> 29abc96b6310fef8dd5ff34c22f0ff0d313ebe0a:
>=20
> =C2=A0 config.json: Drop checkvnc usage (2026-03-16 20:28:25 +0000)
>=20
> are available in the Git repository at:
>=20
> =C2=A0
> https://git.yoctoproject.org/yocto-autobuilder-helper=C2=A0contrib/yconga=
l
> /whinlatter
> =C2=A0
> https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=3Dcontrib/yc=
ongal/whinlatter
>=20
> for you to fetch changes up to
> 93894832c9a4ce0b96d16e503bed99a959f3d232:
>=20
> =C2=A0 scripts/yocto-supported-distros: fix the centos stream regular
> expression (2026-04-14 10:10:51 +0200)
>=20
> ----------------------------------------------------------------
>=20
> Antonin Godard (1):
> =C2=A0 scripts/yocto-supported-distros: fix the centos stream regular
> =C2=A0=C2=A0=C2=A0 expression
>=20
> Richard Purdie (3):
> =C2=A0 config.json: Set SSTATE_DIR unconditionally
> =C2=A0 config.json: Fix bring up after bitbake-setup changes
> =C2=A0 scripts/utils: Milestones are now yocto- prefixed
>=20
> Yoann Congal (1):
> =C2=A0 run-config: drop one more checkvnc usage

I've merged this series as they all look to make sense to me for
whinlatter, thanks.

Cheers,

Richard


