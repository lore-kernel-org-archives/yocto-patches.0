Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0FCCD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:52:24 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.126116.1781517134382621717
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 02:52:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=z0lD2jXw;
 spf=pass (domain: smile.fr, ip: 209.85.208.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so5719723a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781517132; x=1782121932; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdg8DX1TNxSzZsZHsNBfEX7MucRIZSVRgXYn8Y6MB7Y=;
        b=z0lD2jXwIwo2Br88MUWxcpDRxEDioM8bnbCjKnMK2vejLAFp/xW+KG4SLGnISHfxBR
         +iKDr0m6HsyqhEJOVOEZSwonCjmNyZmLHRunMQJCTMb6hB5cR/pcxINNp8MdfK8iwBJ+
         mTH8/If7BIqvi6TDEMkwkQqXzGCD2nnnPVZj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517132; x=1782121932;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdg8DX1TNxSzZsZHsNBfEX7MucRIZSVRgXYn8Y6MB7Y=;
        b=Ekk7mquxpXBPH1/pm0YCo5hDHEbP7XUeVN6JGcShLE1zFONW16VXLKjkuB+4SQh2h3
         6NVsRbsYaSuIsQBJ7P2nubZusYp9eoDC//3MIW4DmNhdfcpBX2ixbo5/vySVl37kyBU4
         OESTUpi6JY5HQWO77/A32JGI3u6YETi3VP3oYl149N2fFtjNOgvkAkP38X5LtViMKEO/
         M2JUaD3Pj7fumR+gOADKfUDn0OR0gMbtpdP8oXJ04n6u5JfUHJEvY0qaaJyOIYgSq1sJ
         onp6RnY7qTNyV0aZ7SmZhHwzbmuV4XkUWuk3Etk0AFCmaayOuNJCVhwAbwaHp5Ve3sWt
         Rmwg==
X-Gm-Message-State: AOJu0Yz2wNvchNEix9864ReEVl01lFml6VeWF8CJvZBakXJK0+dJWf/b
	26U+RhUE8+QQRfT1XDsImy5fDaedF7Yr4mh4JwpOnIpqnIU0uPN57UsVAwQNTVvPBFoY7Lwsozp
	dssia
X-Gm-Gg: Acq92OGVS/+SYqLHMfnkcoFIqLUwlX812U6QfQXnvgg2cDwcbgrPy7fL9kniI8F5b+2
	uQugYzD1Cnr3/fPWBjpizGm0Z4kSGWxqE3QICZnxWAWS9bIrAQjJO3pSCk9jLwZUOZLEla0WfTJ
	yXsbiIAVFsEkHK/uCM96Sbl/Kr/SrWuHHLG1oEIkkqG3zRjcflfiJUChIFtZHgzH7eama71pG/k
	l6wkbh6fs/UWX2MwF8JzLx+1ZRKmvt0dDWFulwcoHNXWud0z/ONZehCkxcFA7vuxWr2Gwshh9L7
	g/+vVKbmR8sOYDHOlGq4KLDkRQC4bN1AwSc38l3FUndz711OKmUz4+JU4fmeGCCmVpEA/r1aFFO
	LRdrLEDlHSxPkkdN8YS/Y1SVpJ1BuaQWTmhJ3v1RleQDxk79xeREDSHMxT8ocVx+ng5lvaruWDx
	akBwiWp0M8yng0mkJk8VDvOfdtwtbbcPjjmdkCAbCxuwOIQ0T3E/v3Gufe19bjtqe5AIqcwXS95
	mEGncUn/U9khTU=
X-Received: by 2002:a17:906:7312:b0:bec:929b:cee6 with SMTP id a640c23a62f3a-bff49d124aemr388852766b.20.1781517132476;
        Mon, 15 Jun 2026 02:52:12 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44208f8sm450424466b.10.2026.06.15.02.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:52:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 11:52:11 +0200
Message-Id: <DJ9J47WKVRKJ.1GDBA84GBBGVP@smile.fr>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] schedulers: Switch
 meta-agl to unagi branch for scarthgap
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Mathieu
 Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260615-mathieu-agl-unagi-v1-1-5c2b5b28bd44@bootlin.com>
In-Reply-To: <20260615-mathieu-agl-unagi-v1-1-5c2b5b28bd44@bootlin.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:52:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4224

On Mon Jun 15, 2026 at 11:38 AM CEST, Mathieu Dubois-Briand via lists.yocto=
project.org wrote:
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  schedulers.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/schedulers.py b/schedulers.py
> index 0f41bd0c7ca6..e5f0684fcb34 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -161,7 +161,7 @@ branchdefaults =3D {
>      'scarthgap': {
>          'branch': 'scarthgap',
>          'branch_bitbake': '2.8',
> -        'branch_meta-agl': 'master',
> +        'branch_meta-agl': 'unagi',

This looks correct but note that I don't test/use this anywhere on normal
builds.

>          'branch_meta-arm': 'scarthgap',
>          'branch_meta-aws': 'scarthgap',
>          'branch_meta-clang': 'scarthgap',
>
> ---
> base-commit: 5a6ea7528b04dab22417da66bd9cde87fdd05121
> change-id: 20260615-mathieu-agl-unagi-101394aa4db2
>
> Best regards,


--=20
Yoann Congal
Smile ECS


